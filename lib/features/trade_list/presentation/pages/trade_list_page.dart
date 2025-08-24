import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/utils/app_theme.dart';
import '../../../../core/providers/user_defined_values_provider.dart';
import '../../../add_trade/domain/entities/trade.dart';
import '../../../add_trade/presentation/pages/edit_trade_page.dart';
import '../provider/trade_list_provider.dart';
import '../widgets/trade_card.dart';
import '../widgets/trade_filter_sheet.dart';

class TradeListPage extends StatefulWidget {
  final Function(int)? onNavigateToTab;
  
  const TradeListPage({super.key, this.onNavigateToTab});

  @override
  State<TradeListPage> createState() => _TradeListPageState();
}

class _TradeListPageState extends State<TradeListPage> with WidgetsBindingObserver {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // Load trades when page initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TradeListProvider>().loadTrades();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    // Refresh trades when app becomes visible
    if (state == AppLifecycleState.resumed) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          context.read<TradeListProvider>().loadTrades();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Trades',
          style: AppTheme.subheadingStyle.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded, size: 20),
            onPressed: () {
              context.read<TradeListProvider>().loadTrades();
            },
            tooltip: 'Refresh',
          ),
          IconButton(
            icon: const Icon(Icons.search_rounded, size: 20),
            onPressed: () => _showSearchDialog(context),
            tooltip: 'Search',
          ),
          IconButton(
            icon: const Icon(Icons.filter_list_rounded, size: 20),
            onPressed: () => _showFilterSheet(context),
            tooltip: 'Filter',
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert_rounded, size: 20),
            onSelected: (value) => _handleMenuAction(value),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'export',
                child: Row(
                  children: [
                    Icon(Icons.download),
                    SizedBox(width: 8),
                    Text('Export Trades'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'delete_all',
                child: Row(
                  children: [
                    Icon(Icons.delete_forever, color: Colors.red),
                    SizedBox(width: 8),
                    Text('Delete All Trades', style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Consumer2<TradeListProvider, UserDefinedValuesProvider>(
        builder: (context, tradeListProvider, userValuesProvider, child) {
          return Column(
            children: [
              // Statistics Summary
              _buildStatisticsSummary(tradeListProvider),
              
              // Filter Tags
              if (tradeListProvider.hasActiveFilters)
                _buildFilterTags(tradeListProvider),
              
              // Trade List
              Expanded(
                child: _buildTradeList(tradeListProvider),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddTrade(context),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildStatisticsSummary(TradeListProvider provider) {
    final stats = provider.statistics;
    
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.all(12),
      decoration: AppTheme.cardDecoration,
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.bar_chart_rounded,
                color: AppTheme.textSecondaryColor,
                size: 16,
              ),
              const SizedBox(width: 6),
              Text(
                'Summary',
                style: AppTheme.labelStyle.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textSecondaryColor,
                ),
              ),
              const Spacer(),
              Text(
                '${provider.trades.length} trades',
                style: AppTheme.captionStyle,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'P&L',
                  '\$${stats.totalPnL.toStringAsFixed(2)}',
                  stats.totalPnL > 0 
                      ? AppTheme.bullishColor 
                      : AppTheme.bearishColor,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildStatCard(
                  'Win Rate',
                  '${stats.winRate.toStringAsFixed(1)}%',
                  stats.winRate >= 50 ? AppTheme.bullishColor : AppTheme.bearishColor,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildStatCard(
                  'Avg R',
                  '${stats.averageR.toStringAsFixed(2)}x',
                  AppTheme.primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: AppTheme.captionStyle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: AppTheme.priceStyle.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTags(TradeListProvider provider) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Wrap(
        spacing: 8,
        runSpacing: 4,
        children: [
          if (provider.filters.symbol.isNotEmpty)
            _buildFilterChip('Symbol: ${provider.filters.symbol}', () {
              provider.clearSymbolFilter();
            }),
          if (provider.filters.status != null)
            _buildFilterChip('Status: ${provider.filters.status!.name}', () {
              provider.clearStatusFilter();
            }),
          if (provider.filters.dateRange != null)
            _buildFilterChip('Date Range', () {
              provider.clearDateRangeFilter();
            }),
          if (provider.filters.exchanges.isNotEmpty)
            _buildFilterChip('Exchange: ${provider.filters.exchanges.first}', () {
              provider.clearExchangeFilter();
            }),
          _buildFilterChip('Clear All', () {
            provider.clearAllFilters();
          }, isClearAll: true),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, VoidCallback onRemove, {bool isClearAll = false}) {
    return Chip(
      label: Text(
        label,
        style: AppTheme.captionStyle.copyWith(
          color: isClearAll ? Colors.white : AppTheme.textPrimaryColor,
        ),
      ),
      backgroundColor: isClearAll 
          ? AppTheme.primaryColor 
          : AppTheme.borderColor,
      deleteIcon: isClearAll 
          ? null 
          : Icon(
              Icons.close,
              size: 16,
              color: AppTheme.textSecondaryColor,
            ),
      onDeleted: isClearAll ? null : onRemove,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }

  Widget _buildTradeList(TradeListProvider provider) {
    if (provider.isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Loading trades...'),
          ],
        ),
      );
    }

    if (provider.trades.isEmpty) {
      return _buildEmptyState(provider);
    }

    return RefreshIndicator(
      onRefresh: () => provider.loadTrades(),
      color: AppTheme.primaryColor,
      child: Stack(
        children: [
          ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.all(12),
            itemCount: provider.trades.length,
            itemBuilder: (context, index) {
              final trade = provider.trades[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: TradeCard(
                  trade: trade,
                  onTap: () => _showTradeDetails(context, trade),
                  onEdit: () => _editTrade(context, trade),
                  onDelete: () => _deleteTrade(context, trade),
                ),
              );
            },
          ),
          // Show a small indicator when silently refreshing
          if (provider.status == TradeListStatus.loading)
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(TradeListProvider provider) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inbox_outlined,
            size: 64,
            color: AppTheme.textSecondaryColor,
          ),
          const SizedBox(height: 16),
          Text(
            provider.hasActiveFilters ? 'No trades match your filters' : 'No trades yet',
            style: AppTheme.subheadingStyle.copyWith(
              color: AppTheme.textSecondaryColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            provider.hasActiveFilters 
                ? 'Try adjusting your filters or add a new trade'
                : 'Start by adding your first trade',
            style: AppTheme.captionStyle.copyWith(
              color: AppTheme.textSecondaryColor,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          if (!provider.hasActiveFilters)
            ElevatedButton.icon(
              onPressed: () => _navigateToAddTrade(context),
              icon: const Icon(Icons.add),
              label: const Text('Add First Trade'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
        ],
      ),
    );
  }

  void _showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Search Trades'),
        content: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Search by symbol, notes, or memo...',
            prefixIcon: Icon(Icons.search),
          ),
          onChanged: (value) {
            context.read<TradeListProvider>().setSearchQuery(value);
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<TradeListProvider>().clearSearch();
              _searchController.clear();
              Navigator.of(context).pop();
            },
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }

  void _showFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const TradeFilterSheet(),
    );
  }

  void _showTradeDetails(BuildContext context, Trade trade) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildTradeDetailsSheet(trade),
    );
  }

  Widget _buildTradeDetailsSheet(Trade trade) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        border: Border.all(color: AppTheme.borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 8),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppTheme.textSecondaryColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          
          // Header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Text(
                  'Trade Details',
                  style: AppTheme.headingStyle.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(
                    Icons.close,
                    color: AppTheme.textSecondaryColor,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
          
          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Trade Transfers Section
                  _buildDetailSection('Trade Transfers', [
                    if (trade.tag?.isNotEmpty == true)
                      _buildDetailRow('Tag', trade.tag!),
                    _buildDetailRow('Datetime', _formatDateTime(trade.datetime)),
                    if (trade.exchanges?.isNotEmpty == true)
                      _buildDetailRow('Exchanges', trade.exchanges!),
                    if (trade.entryType != null)
                      _buildDetailRow('Entry Type', _getEntryTypeDisplayName(trade.entryType!)),
                    _buildDetailRow('Symbol', trade.symbol),
                    if (trade.side != null)
                      _buildDetailRow('Side', trade.side!.name.toUpperCase()),
                    if (trade.strategies?.isNotEmpty == true)
                      _buildDetailRow('Strategies', trade.strategies!),
                    _buildDetailRow('Entry Price', '\$${trade.entryPrice.toStringAsFixed(2)}'),
                    if (trade.quantity > 0)
                      _buildDetailRow('Quantity', trade.quantity.toStringAsFixed(4)),
                    _buildDetailRow('Status', trade.status.name.toUpperCase()),
                    if (trade.positionMargin != null)
                      _buildDetailRow('Position Margin', '\$${trade.positionMargin!.toStringAsFixed(2)}'),
                    if (trade.leverage != null)
                      _buildDetailRow('Leverage', '${trade.leverage!}x'),
                    if (trade.orderType != null)
                      _buildDetailRow('Order Type', trade.orderType!.name.toUpperCase()),
                    if (trade.timeFrame?.isNotEmpty == true)
                      _buildDetailRow('Time Frame', trade.timeFrame!),
                    if (trade.entryFeeRate != null)
                      _buildDetailRow('Entry Fee Rate', '${trade.entryFeeRate!}%'),
                    if (trade.entryMentalStates?.isNotEmpty == true)
                      _buildDetailRow('Entry Mental States', trade.entryMentalStates!),
                    if (trade.entryScreenshot?.isNotEmpty == true)
                      _buildDetailRow('Entry Screenshot', trade.entryScreenshot!),
                  ]),
                  
                  // Checklist Section
                  if (trade.checklist?.isNotEmpty == true) ...[
                    const SizedBox(height: 20),
                    _buildDetailSection('Checklist', [
                      ...trade.checklist!.map((item) => _buildDetailRow('•', item)),
                    ]),
                  ],
                  
                  // Trade Management Section
                  if (trade.stopLossPrice != null || trade.takeProfitPrice != null) ...[
                    const SizedBox(height: 20),
                    _buildDetailSection('Trade Management', [
                      if (trade.stopLossPrice != null)
                        _buildDetailRow('Stop Loss Price', '\$${trade.stopLossPrice!.toStringAsFixed(2)}'),
                      if (trade.takeProfitPrice != null)
                        _buildDetailRow('Take Profit Price', '\$${trade.takeProfitPrice!.toStringAsFixed(2)}'),
                    ]),
                  ],
                  
                  // Trade Exit Section
                  if (trade.actualExitPrice != null || trade.exitDatetime != null) ...[
                    const SizedBox(height: 20),
                    _buildDetailSection('Trade Exit', [
                      if (trade.actualExitPrice != null)
                        _buildDetailRow('Actual Exit Price', '\$${trade.actualExitPrice!.toStringAsFixed(2)}'),
                      if (trade.marginClosedPercent != null)
                        _buildDetailRow('% of Margin Closed', '${trade.marginClosedPercent!}%'),
                      if (trade.exitType != null)
                        _buildDetailRow('Exit Type', trade.exitType!.name.toUpperCase()),
                      if (trade.exitFeeRate != null)
                        _buildDetailRow('Exit Fee Rate', '${trade.exitFeeRate!}%'),
                      if (trade.exitDatetime != null)
                        _buildDetailRow('Exit Datetime', _formatDateTime(trade.exitDatetime!)),
                      if (trade.exitMentalStates?.isNotEmpty == true)
                        _buildDetailRow('Exit Mental States', trade.exitMentalStates!),
                      if (trade.exitScreenshot?.isNotEmpty == true)
                        _buildDetailRow('Exit Screenshot', trade.exitScreenshot!),
                    ]),
                  ],
                  
                  // Memo Section
                  if (trade.memo?.isNotEmpty == true || trade.rating != null) ...[
                    const SizedBox(height: 20),
                    _buildDetailSection('Memo', [
                      if (trade.rating != null)
                        _buildDetailRow('Rating', '${trade.rating}/5 ${'⭐' * trade.rating!}'),
                      if (trade.memo?.isNotEmpty == true)
                        _buildDetailRow('Memo', trade.memo!),
                    ]),
                  ],
                  
                  // Trackings Section
                  if (trade.trackings?.isNotEmpty == true || trade.mistakes?.isNotEmpty == true) ...[
                    const SizedBox(height: 20),
                    _buildDetailSection('Trackings', [
                      if (trade.trackings?.isNotEmpty == true)
                        _buildDetailRow('Trackings', trade.trackings!),
                      if (trade.mistakes?.isNotEmpty == true)
                        _buildDetailRow('Mistakes', trade.mistakes!),
                    ]),
                  ],
                  
                  // Transfers Section
                  if (trade.transferAmount != null || trade.transferScreenshot?.isNotEmpty == true) ...[
                    const SizedBox(height: 20),
                    _buildDetailSection('Transfers', [
                      if (trade.transferAmount != null)
                        _buildDetailRow('Amount', '\$${trade.transferAmount!.toStringAsFixed(2)}'),
                      if (trade.transferScreenshot?.isNotEmpty == true)
                        _buildDetailRow('Transfer Screenshot', trade.transferScreenshot!),
                    ]),
                  ],
                  
                  // Legacy PnL Information (if available)
                  if (trade.pnl != null || trade.pnlPercent != null) ...[
                    const SizedBox(height: 20),
                    _buildDetailSection('Performance', [
                      if (trade.pnl != null)
                        _buildDetailRowWithColor('PnL', '\$${trade.pnl!.toStringAsFixed(2)}', trade.pnl!),
                      if (trade.pnlPercent != null)
                        _buildDetailRowWithColor('PnL %', '${trade.pnlPercent!.toStringAsFixed(2)}%', trade.pnlPercent!),
                    ]),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTheme.subheadingStyle.copyWith(
            fontWeight: FontWeight.w600,
            color: AppTheme.primaryColor,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppTheme.backgroundColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppTheme.borderColor),
          ),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: AppTheme.captionStyle.copyWith(
                fontWeight: FontWeight.w500,
                color: AppTheme.textSecondaryColor,
                fontSize: 12,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: AppTheme.bodyStyle.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRowWithColor(String label, String value, double numericValue) {
    final color = numericValue > 0 
        ? AppTheme.bullishColor 
        : numericValue < 0 
            ? AppTheme.bearishColor 
            : AppTheme.textPrimaryColor;
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: AppTheme.captionStyle.copyWith(
                fontWeight: FontWeight.w500,
                color: AppTheme.textSecondaryColor,
                fontSize: 12,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: AppTheme.bodyStyle.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return 'N/A';
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  String _getEntryTypeDisplayName(EntryType type) {
    switch (type) {
      case EntryType.trade:
        return 'Trade';
      case EntryType.marginInOut:
        return 'Margin In/Out';
      case EntryType.deposit:
        return 'Deposit';
      case EntryType.withdrawal:
        return 'Withdrawal';
      case EntryType.ignore:
        return 'Ignore';
    }
  }

  void _editTrade(BuildContext context, Trade trade) async {
    final navigator = Navigator.of(context);
    final provider = context.read<TradeListProvider>();
    await navigator.push(
      MaterialPageRoute(
        builder: (context) => EditTradePage(trade: trade),
      ),
    );
    // Refresh the trade list when returning from edit page
    if (mounted) {
      provider.loadTrades();
    }
  }

  void _deleteTrade(BuildContext context, Trade trade) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Trade'),
        content: Text('Are you sure you want to delete the trade for ${trade.symbol}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<TradeListProvider>().deleteTrade(trade.id!);
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _navigateToAddTrade(BuildContext context) {
    // Navigate to Add Trade tab (index 1) using the callback
    if (widget.onNavigateToTab != null) {
      widget.onNavigateToTab!(1); // Add Trade tab
    } else {
      // Fallback: show a message if callback is not available
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please use the bottom navigation to go to Add Trade'),
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _handleMenuAction(String action) {
    switch (action) {
      case 'export':
        _exportTrades();
        break;
      case 'delete_all':
        _deleteAllTrades();
        break;
    }
  }

  void _exportTrades() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Export functionality coming soon!')),
    );
  }

  void _deleteAllTrades() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete All Trades'),
        content: const Text('Are you sure you want to delete all trades? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<TradeListProvider>().deleteAllTrades();
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete All'),
          ),
        ],
      ),
    );
  }
}
