import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/utils/app_theme.dart';
import '../../../add_trade/domain/entities/trade.dart';
import '../provider/trade_list_provider.dart';
import '../models/trade_filters.dart';

class TradeFilterSheet extends StatefulWidget {
  const TradeFilterSheet({super.key});

  @override
  State<TradeFilterSheet> createState() => _TradeFilterSheetState();
}

class _TradeFilterSheetState extends State<TradeFilterSheet> {
  late TradeFilters _filters;
  late TradeSortOption _sortOption;

  @override
  void initState() {
    super.initState();
    final provider = context.read<TradeListProvider>();
    _filters = provider.filters;
    _sortOption = provider.sortOption;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        children: [
          // Enhanced Handle bar
          Container(
            margin: const EdgeInsets.only(top: 12, bottom: 8),
            width: 48,
            height: 6,
            decoration: BoxDecoration(
              color: AppTheme.textSecondaryColor.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          
          // Enhanced Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: AppTheme.surfaceColor,
              border: Border(
                bottom: BorderSide(
                  color: AppTheme.borderColor.withValues(alpha: 0.5),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                Text(
                  'Filter & Sort',
                  style: AppTheme.headingStyle.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textPrimaryColor,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: _clearAllFilters,
                  style: TextButton.styleFrom(
                    foregroundColor: AppTheme.primaryColor,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Clear All',
                    style: AppTheme.bodyStyle.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 8),
                  decoration: BoxDecoration(
                    color: AppTheme.backgroundColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(
                      Icons.close_rounded,
                      color: AppTheme.textSecondaryColor,
                      size: 20,
                    ),
                    style: IconButton.styleFrom(
                      padding: const EdgeInsets.all(8),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Sort Options - Enhanced with modern cards
                  _buildModernSectionTitle('Sort By', Icons.sort_rounded),
                  const SizedBox(height: 16),
                  _buildModernSortOptions(),
                  
                  const SizedBox(height: 32),
                  
                  // Symbol Filter - Enhanced
                  _buildModernSectionTitle('Symbol', Icons.currency_exchange_rounded),
                  const SizedBox(height: 16),
                  _buildModernSymbolFilter(),
                  
                  const SizedBox(height: 24),
                  
                  // Status Filter - Enhanced
                  _buildModernSectionTitle('Status', Icons.info_outline_rounded),
                  const SizedBox(height: 16),
                  _buildModernStatusFilter(),
                  
                  const SizedBox(height: 24),
                  
                  // Date Range Filter - Enhanced
                  _buildModernSectionTitle('Date Range', Icons.calendar_today_rounded),
                  const SizedBox(height: 16),
                  _buildModernDateRangeFilter(),
                  
                  const SizedBox(height: 24),
                  
                  // Exchange Filter - Enhanced
                  _buildModernSectionTitle('Exchange', Icons.swap_horiz_rounded),
                  const SizedBox(height: 16),
                  _buildModernExchangeFilter(),
                  
                  const SizedBox(height: 24),
                  
                  // Side Filter - Enhanced
                  _buildModernSectionTitle('Side', Icons.trending_up_rounded),
                  const SizedBox(height: 16),
                  _buildModernSideFilter(),
                  
                  const SizedBox(height: 24),
                  
                  // Profit/Loss Filter - Enhanced
                  _buildModernSectionTitle('Profit/Loss', Icons.trending_up_rounded),
                  const SizedBox(height: 16),
                  _buildModernProfitLossFilter(),
                  
                  const SizedBox(height: 24),
                  
                  // PnL Range Filter - Enhanced
                  _buildModernSectionTitle('PnL Range', Icons.attach_money_rounded),
                  const SizedBox(height: 16),
                  _buildModernPnLRangeFilter(),
                  
                  const SizedBox(height: 24),
                  
                  // Rating Filter - Enhanced
                  _buildModernSectionTitle('Minimum Rating', Icons.star_rounded),
                  const SizedBox(height: 16),
                  _buildModernRatingFilter(),
                  
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
          
          // Enhanced Apply Button
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppTheme.surfaceColor,
              border: Border(
                top: BorderSide(
                  color: AppTheme.borderColor.withValues(alpha: 0.5),
                  width: 1,
                ),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _applyFilters,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.filter_alt_rounded,
                      size: 20,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Apply Filters',
                      style: AppTheme.bodyStyle.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernSectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppTheme.primaryColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            size: 18,
            color: AppTheme.primaryColor,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: AppTheme.subheadingStyle.copyWith(
            fontWeight: FontWeight.w600,
            color: AppTheme.textPrimaryColor,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildModernSortOptions() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.borderColor.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        children: TradeSortOption.values.map((option) {
          final isSelected = _sortOption == option;
          return GestureDetector(
            onTap: () {
              setState(() {
                _sortOption = option;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isSelected 
                    ? AppTheme.primaryColor 
                    : AppTheme.surfaceColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected 
                      ? AppTheme.primaryColor 
                      : AppTheme.borderColor.withValues(alpha: 0.3),
                  width: 1.5,
                ),
                boxShadow: isSelected ? [
                  BoxShadow(
                    color: AppTheme.primaryColor.withValues(alpha: 0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ] : null,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    option.displayName,
                    style: AppTheme.bodyStyle.copyWith(
                      fontWeight: FontWeight.w500,
                      color: isSelected ? Colors.white : AppTheme.textPrimaryColor,
                    ),
                  ),
                  if (isSelected) ...[
                    const SizedBox(width: 8),
                    Icon(
                      Icons.check_rounded,
                      size: 16,
                      color: Colors.white,
                    ),
                  ],
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildModernSymbolFilter() {
    final provider = context.read<TradeListProvider>();
    final symbols = provider.getUniqueSymbols();
    
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.borderColor.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Select Symbol',
          hintText: 'All Symbols',
          prefixIcon: Icon(
            Icons.currency_exchange_rounded,
            color: AppTheme.textSecondaryColor,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          labelStyle: TextStyle(
            color: AppTheme.textSecondaryColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        value: _filters.symbol.isNotEmpty ? _filters.symbol : null,
        items: [
          DropdownMenuItem<String>(
            value: null,
            child: Row(
              children: [
                Icon(
                  Icons.all_inclusive_rounded,
                  color: AppTheme.textSecondaryColor,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Text(
                  'All Symbols',
                  style: AppTheme.bodyStyle.copyWith(
                    color: AppTheme.textSecondaryColor,
                  ),
                ),
              ],
            ),
          ),
          ...symbols.map((symbol) => DropdownMenuItem<String>(
            value: symbol,
            child: Row(
              children: [
                Icon(
                  Icons.currency_bitcoin_rounded,
                  color: AppTheme.primaryColor,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Text(
                  symbol,
                  style: AppTheme.bodyStyle.copyWith(
                    color: AppTheme.textPrimaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          )),
        ],
        onChanged: (value) {
          setState(() {
            _filters = _filters.copyWith(symbol: value ?? '');
          });
        },
        dropdownColor: AppTheme.backgroundColor,
        icon: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: AppTheme.textSecondaryColor,
        ),
      ),
    );
  }

  Widget _buildModernStatusFilter() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.borderColor.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: DropdownButtonFormField<TradeStatus>(
        decoration: InputDecoration(
          labelText: 'Select Status',
          hintText: 'All Statuses',
          prefixIcon: Icon(
            Icons.info_outline_rounded,
            color: AppTheme.textSecondaryColor,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          labelStyle: TextStyle(
            color: AppTheme.textSecondaryColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        value: _filters.status,
        items: [
          DropdownMenuItem<TradeStatus>(
            value: null,
            child: Row(
              children: [
                Icon(
                  Icons.all_inclusive_rounded,
                  color: AppTheme.textSecondaryColor,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Text(
                  'All Statuses',
                  style: AppTheme.bodyStyle.copyWith(
                    color: AppTheme.textSecondaryColor,
                  ),
                ),
              ],
            ),
          ),
          ...TradeStatus.values.map((status) => DropdownMenuItem<TradeStatus>(
            value: status,
            child: Row(
              children: [
                Icon(
                  status == TradeStatus.open 
                      ? Icons.radio_button_unchecked_rounded
                      : Icons.check_circle_rounded,
                  color: status == TradeStatus.open 
                      ? AppTheme.bearishColor 
                      : AppTheme.bullishColor,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Text(
                  status.name.toUpperCase(),
                  style: AppTheme.bodyStyle.copyWith(
                    color: AppTheme.textPrimaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          )),
        ],
        onChanged: (value) {
          setState(() {
            _filters = _filters.copyWith(status: value);
          });
        },
        dropdownColor: AppTheme.backgroundColor,
        icon: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: AppTheme.textSecondaryColor,
        ),
      ),
    );
  }

  Widget _buildModernDateRangeFilter() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.borderColor.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildDateField(
                  'Start Date',
                  _filters.dateRange?.start,
                  () => _selectStartDate(),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 12),
                child: Icon(
                  Icons.arrow_forward_rounded,
                  color: AppTheme.textSecondaryColor,
                  size: 20,
                ),
              ),
              Expanded(
                child: _buildDateField(
                  'End Date',
                  _filters.dateRange?.end,
                  () => _selectEndDate(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDateField(String label, DateTime? date, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppTheme.surfaceColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppTheme.borderColor.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.calendar_today_rounded,
              color: AppTheme.textSecondaryColor,
              size: 18,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: AppTheme.captionStyle.copyWith(
                      color: AppTheme.textSecondaryColor,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    date != null 
                        ? '${date.day}/${date.month}/${date.year}'
                        : 'Select date',
                    style: AppTheme.bodyStyle.copyWith(
                      color: date != null 
                          ? AppTheme.textPrimaryColor 
                          : AppTheme.textSecondaryColor,
                      fontWeight: date != null ? FontWeight.w500 : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModernExchangeFilter() {
    final provider = context.read<TradeListProvider>();
    final exchanges = provider.getUniqueExchanges();
    
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.borderColor.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Select Exchange',
          hintText: 'All Exchanges',
          prefixIcon: Icon(
            Icons.swap_horiz_rounded,
            color: AppTheme.textSecondaryColor,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          labelStyle: TextStyle(
            color: AppTheme.textSecondaryColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        value: _filters.exchanges.isNotEmpty ? _filters.exchanges.first : null,
        items: [
          DropdownMenuItem<String>(
            value: null,
            child: Row(
              children: [
                Icon(
                  Icons.all_inclusive_rounded,
                  color: AppTheme.textSecondaryColor,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Text(
                  'All Exchanges',
                  style: AppTheme.bodyStyle.copyWith(
                    color: AppTheme.textSecondaryColor,
                  ),
                ),
              ],
            ),
          ),
          ...exchanges.map((exchange) => DropdownMenuItem<String>(
            value: exchange,
            child: Row(
              children: [
                Icon(
                  Icons.account_balance_rounded,
                  color: AppTheme.primaryColor,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Text(
                  exchange,
                  style: AppTheme.bodyStyle.copyWith(
                    color: AppTheme.textPrimaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          )),
        ],
        onChanged: (value) {
          setState(() {
            _filters = _filters.copyWith(
              exchanges: value != null ? [value] : [],
            );
          });
        },
        dropdownColor: AppTheme.backgroundColor,
        icon: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: AppTheme.textSecondaryColor,
        ),
      ),
    );
  }

  Widget _buildModernSideFilter() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.borderColor.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: DropdownButtonFormField<Side>(
        decoration: InputDecoration(
          labelText: 'Select Side',
          hintText: 'All Sides',
          prefixIcon: Icon(
            Icons.trending_up_rounded,
            color: AppTheme.textSecondaryColor,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          labelStyle: TextStyle(
            color: AppTheme.textSecondaryColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        value: _filters.side,
        items: [
          DropdownMenuItem<Side>(
            value: null,
            child: Row(
              children: [
                Icon(
                  Icons.all_inclusive_rounded,
                  color: AppTheme.textSecondaryColor,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Text(
                  'All Sides',
                  style: AppTheme.bodyStyle.copyWith(
                    color: AppTheme.textSecondaryColor,
                  ),
                ),
              ],
            ),
          ),
          ...Side.values.map((side) => DropdownMenuItem<Side>(
            value: side,
            child: Row(
              children: [
                Icon(
                  side == Side.long 
                      ? Icons.trending_up_rounded
                      : Icons.trending_down_rounded,
                  color: side == Side.long 
                      ? AppTheme.bullishColor 
                      : AppTheme.bearishColor,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Text(
                  side.name.toUpperCase(),
                  style: AppTheme.bodyStyle.copyWith(
                    color: AppTheme.textPrimaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          )),
        ],
        onChanged: (value) {
          setState(() {
            _filters = _filters.copyWith(side: value);
          });
        },
        dropdownColor: AppTheme.backgroundColor,
        icon: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: AppTheme.textSecondaryColor,
        ),
      ),
    );
  }

  Widget _buildModernProfitLossFilter() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.borderColor.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: DropdownButtonFormField<ProfitLossFilter>(
        decoration: InputDecoration(
          labelText: 'Select Profit/Loss',
          hintText: 'All Trades',
          prefixIcon: Icon(
            Icons.trending_up_rounded,
            color: AppTheme.textSecondaryColor,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          labelStyle: TextStyle(
            color: AppTheme.textSecondaryColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        value: _filters.profitLossFilter,
        items: [
          DropdownMenuItem<ProfitLossFilter>(
            value: ProfitLossFilter.all,
            child: Row(
              children: [
                Icon(
                  Icons.all_inclusive_rounded,
                  color: AppTheme.textSecondaryColor,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Text(
                  'All Trades',
                  style: AppTheme.bodyStyle.copyWith(
                    color: AppTheme.textSecondaryColor,
                  ),
                ),
              ],
            ),
          ),
          DropdownMenuItem<ProfitLossFilter>(
            value: ProfitLossFilter.profitable,
            child: Row(
              children: [
                Icon(
                  Icons.trending_up_rounded,
                  color: AppTheme.bullishColor,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Text(
                  'Profitable',
                  style: AppTheme.bodyStyle.copyWith(
                    color: AppTheme.textPrimaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          DropdownMenuItem<ProfitLossFilter>(
            value: ProfitLossFilter.losing,
            child: Row(
              children: [
                Icon(
                  Icons.trending_down_rounded,
                  color: AppTheme.bearishColor,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Text(
                  'Losing',
                  style: AppTheme.bodyStyle.copyWith(
                    color: AppTheme.textPrimaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          DropdownMenuItem<ProfitLossFilter>(
            value: ProfitLossFilter.breakeven,
            child: Row(
              children: [
                Icon(
                  Icons.remove_rounded,
                  color: Colors.grey,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Text(
                  'Breakeven',
                  style: AppTheme.bodyStyle.copyWith(
                    color: AppTheme.textPrimaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
        onChanged: (value) {
          setState(() {
            _filters = _filters.copyWith(profitLossFilter: value ?? ProfitLossFilter.all);
          });
        },
        dropdownColor: AppTheme.backgroundColor,
        icon: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: AppTheme.textSecondaryColor,
        ),
      ),
    );
  }

  Widget _buildModernPnLRangeFilter() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.borderColor.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: _buildNumberField(
              'Min PnL',
              _filters.minPnL?.toString() ?? '',
              Icons.trending_down_rounded,
              (value) {
                final minValue = double.tryParse(value);
                setState(() {
                  _filters = _filters.copyWith(minPnL: minValue);
                });
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            child: Icon(
              Icons.arrow_forward_rounded,
              color: AppTheme.textSecondaryColor,
              size: 20,
            ),
          ),
          Expanded(
            child: _buildNumberField(
              'Max PnL',
              _filters.maxPnL?.toString() ?? '',
              Icons.trending_up_rounded,
              (value) {
                final maxValue = double.tryParse(value);
                setState(() {
                  _filters = _filters.copyWith(maxPnL: maxValue);
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNumberField(String label, String value, IconData icon, Function(String) onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.borderColor.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: AppTheme.textSecondaryColor,
                size: 16,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: AppTheme.captionStyle.copyWith(
                  color: AppTheme.textSecondaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          TextFormField(
            initialValue: value,
            onChanged: onChanged,
            keyboardType: TextInputType.number,
            style: AppTheme.bodyStyle.copyWith(
              color: AppTheme.textPrimaryColor,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              hintText: '0.00',
              hintStyle: TextStyle(
                color: AppTheme.textSecondaryColor.withValues(alpha: 0.5),
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernRatingFilter() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.borderColor.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: DropdownButtonFormField<int>(
        decoration: InputDecoration(
          labelText: 'Select Minimum Rating',
          hintText: 'Any Rating',
          prefixIcon: Icon(
            Icons.star_rounded,
            color: AppTheme.textSecondaryColor,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          labelStyle: TextStyle(
            color: AppTheme.textSecondaryColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        value: _filters.minRating,
        items: [
          DropdownMenuItem<int>(
            value: null,
            child: Row(
              children: [
                Icon(
                  Icons.all_inclusive_rounded,
                  color: AppTheme.textSecondaryColor,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Text(
                  'Any Rating',
                  style: AppTheme.bodyStyle.copyWith(
                    color: AppTheme.textSecondaryColor,
                  ),
                ),
              ],
            ),
          ),
          ...List.generate(5, (index) => index + 1).map((rating) => DropdownMenuItem<int>(
            value: rating,
            child: Row(
              children: [
                Text(
                  '$rating ',
                  style: AppTheme.bodyStyle.copyWith(
                    color: AppTheme.textPrimaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                ...List.generate(rating, (index) => Icon(
                  Icons.star_rounded,
                  size: 16,
                  color: AppTheme.primaryColor,
                )),
              ],
            ),
          )),
        ],
        onChanged: (value) {
          setState(() {
            _filters = _filters.copyWith(minRating: value);
          });
        },
        dropdownColor: AppTheme.backgroundColor,
        icon: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: AppTheme.textSecondaryColor,
        ),
      ),
    );
  }

  Future<void> _selectStartDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _filters.dateRange?.start ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppTheme.primaryColor,
              onPrimary: Colors.white,
              surface: AppTheme.surfaceColor,
              onSurface: AppTheme.textPrimaryColor,
            ),
          ),
          child: child!,
        );
      },
    );
    
    if (picked != null) {
      setState(() {
        final endDate = _filters.dateRange?.end ?? picked;
        _filters = _filters.copyWith(
          dateRange: DateTimeRange(start: picked, end: endDate),
        );
      });
    }
  }

  Future<void> _selectEndDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _filters.dateRange?.end ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppTheme.primaryColor,
              onPrimary: Colors.white,
              surface: AppTheme.surfaceColor,
              onSurface: AppTheme.textPrimaryColor,
            ),
          ),
          child: child!,
        );
      },
    );
    
    if (picked != null) {
      setState(() {
        final startDate = _filters.dateRange?.start ?? picked;
        _filters = _filters.copyWith(
          dateRange: DateTimeRange(start: startDate, end: picked),
        );
      });
    }
  }

  void _clearAllFilters() {
    setState(() {
      _filters = const TradeFilters();
      _sortOption = TradeSortOption.dateDesc;
    });
  }

  void _applyFilters() {
    final provider = context.read<TradeListProvider>();
    provider.setFilters(_filters);
    provider.setSortOption(_sortOption);
    Navigator.of(context).pop();
  }
}
