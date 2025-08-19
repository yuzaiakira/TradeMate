import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/utils/app_theme.dart';
import '../../../../core/widgets/multi_select_dropdown.dart';
import '../../../../core/providers/user_defined_values_provider.dart';
import '../../../add_trade/domain/entities/trade.dart';
import '../../../add_trade/presentation/pages/edit_trade_page.dart';
import '../provider/trade_list_provider.dart';
import '../widgets/trade_card.dart';
import '../widgets/trade_filter_sheet.dart';

class TradeListPage extends StatefulWidget {
  const TradeListPage({super.key});

  @override
  State<TradeListPage> createState() => _TradeListPageState();
}

class _TradeListPageState extends State<TradeListPage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  bool _showFilters = false;

  @override
  void initState() {
    super.initState();
    // Load trades when page initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TradeListProvider>().loadTrades();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trade List'),
        elevation: 0,
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => _showSearchDialog(context),
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterSheet(context),
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
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
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.analytics,
                color: AppTheme.primaryColor,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                'Trade Summary',
                style: AppTheme.subheadingStyle.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.primaryColor,
                ),
              ),
              const Spacer(),
              Text(
                '${provider.trades.length} trades',
                style: AppTheme.captionStyle.copyWith(
                  color: AppTheme.textSecondaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'Total PnL',
                  stats.totalPnL?.toStringAsFixed(2) ?? '0.00',
                  stats.totalPnL != null && stats.totalPnL! > 0 
                      ? AppTheme.successColor 
                      : AppTheme.errorColor,
                  Icons.trending_up,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildStatCard(
                  'Win Rate',
                  '${stats.winRate?.toStringAsFixed(1) ?? 0}%',
                  AppTheme.primaryColor,
                  Icons.emoji_events,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildStatCard(
                  'Avg R',
                  stats.averageR?.toStringAsFixed(2) ?? '0.00',
                  AppTheme.primaryColor,
                  Icons.speed,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 4),
          Text(
            value,
            style: AppTheme.bodyStyle.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: AppTheme.captionStyle.copyWith(
              color: AppTheme.textSecondaryColor,
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
      child: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.all(16),
        itemCount: provider.trades.length,
        itemBuilder: (context, index) {
          final trade = provider.trades[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: TradeCard(
              trade: trade,
              onTap: () => _showTradeDetails(context, trade),
              onEdit: () => _editTrade(context, trade),
              onDelete: () => _deleteTrade(context, trade),
            ),
          );
        },
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
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 8),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
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
                  style: AppTheme.headingStyle,
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close),
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
                  _buildDetailSection('Trade Information', [
                    _buildDetailRow('Symbol', trade.symbol),
                    _buildDetailRow('Entry Price', '\$${trade.entryPrice.toStringAsFixed(2)}'),
                    _buildDetailRow('Quantity', trade.quantity.toStringAsFixed(4)),
                    _buildDetailRow('Side', trade.side?.name.toUpperCase() ?? 'N/A'),
                    _buildDetailRow('Status', trade.status.name.toUpperCase()),
                    _buildDetailRow('Entry Date', _formatDateTime(trade.datetime)),
                  ]),
                  
                  if (trade.exitPrice != null) ...[
                    const SizedBox(height: 16),
                    _buildDetailSection('Exit Information', [
                      _buildDetailRow('Exit Price', '\$${trade.exitPrice!.toStringAsFixed(2)}'),
                      _buildDetailRow('Exit Date', _formatDateTime(trade.exitDate)),
                      _buildDetailRow('PnL', '\$${trade.pnl?.toStringAsFixed(2) ?? '0.00'}'),
                      _buildDetailRow('PnL %', '${trade.pnlPercent?.toStringAsFixed(2) ?? '0.00'}%'),
                    ]),
                  ],
                  
                  if (trade.memo?.isNotEmpty == true) ...[
                    const SizedBox(height: 16),
                    _buildDetailSection('Memo', [
                      _buildDetailRow('Notes', trade.memo!),
                    ]),
                  ],
                  
                  if (trade.rating != null) ...[
                    const SizedBox(height: 16),
                    _buildDetailSection('Rating', [
                      _buildDetailRow('Rating', '${trade.rating}/5 ${'⭐' * trade.rating!}'),
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
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey[200]!),
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
      padding: const EdgeInsets.symmetric(vertical: 4),
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
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: AppTheme.bodyStyle,
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

  void _editTrade(BuildContext context, Trade trade) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditTradePage(trade: trade),
      ),
    );
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
    Navigator.of(context).pushNamed('/add-trade');
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
