import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/utils/app_theme.dart';
import '../../../../core/widgets/multi_select_dropdown.dart';
import '../../../../core/providers/user_defined_values_provider.dart';
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
                  'Filter & Sort',
                  style: AppTheme.headingStyle,
                ),
                const Spacer(),
                TextButton(
                  onPressed: _clearAllFilters,
                  child: const Text('Clear All'),
                ),
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
                  // Sort Options
                  _buildSectionTitle('Sort By'),
                  const SizedBox(height: 8),
                  _buildSortOptions(),
                  
                  const SizedBox(height: 24),
                  
                  // Symbol Filter
                  _buildSectionTitle('Symbol'),
                  const SizedBox(height: 8),
                  _buildSymbolFilter(),
                  
                  const SizedBox(height: 16),
                  
                  // Status Filter
                  _buildSectionTitle('Status'),
                  const SizedBox(height: 8),
                  _buildStatusFilter(),
                  
                  const SizedBox(height: 16),
                  
                  // Date Range Filter
                  _buildSectionTitle('Date Range'),
                  const SizedBox(height: 8),
                  _buildDateRangeFilter(),
                  
                  const SizedBox(height: 16),
                  
                  // Exchange Filter
                  _buildSectionTitle('Exchange'),
                  const SizedBox(height: 8),
                  _buildExchangeFilter(),
                  
                  const SizedBox(height: 16),
                  
                  // Side Filter
                  _buildSectionTitle('Side'),
                  const SizedBox(height: 8),
                  _buildSideFilter(),
                  
                  const SizedBox(height: 16),
                  
                  // PnL Range Filter
                  _buildSectionTitle('PnL Range'),
                  const SizedBox(height: 8),
                  _buildPnLRangeFilter(),
                  
                  const SizedBox(height: 16),
                  
                  // Rating Filter
                  _buildSectionTitle('Minimum Rating'),
                  const SizedBox(height: 8),
                  _buildRatingFilter(),
                ],
              ),
            ),
          ),
          
          // Apply Button
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _applyFilters,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Apply Filters',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: AppTheme.subheadingStyle.copyWith(
        fontWeight: FontWeight.w600,
        color: AppTheme.textPrimaryColor,
      ),
    );
  }

  Widget _buildSortOptions() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: TradeSortOption.values.map((option) {
        final isSelected = _sortOption == option;
        return ChoiceChip(
          label: Text(option.displayName),
          selected: isSelected,
          onSelected: (selected) {
            if (selected) {
              setState(() {
                _sortOption = option;
              });
            }
          },
          selectedColor: AppTheme.primaryColor,
          labelStyle: TextStyle(
            color: isSelected ? Colors.white : AppTheme.textPrimaryColor,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSymbolFilter() {
    final provider = context.read<TradeListProvider>();
    final symbols = provider.getUniqueSymbols();
    
    return DropdownButtonFormField<String>(
      decoration: AppTheme.inputDecoration(
        labelText: 'Symbol',
        hintText: 'Select symbol',
        prefixIcon: Icons.currency_exchange,
      ),
      value: _filters.symbol.isNotEmpty ? _filters.symbol : null,
      items: [
        const DropdownMenuItem<String>(
          value: null,
          child: Text('All Symbols'),
        ),
        ...symbols.map((symbol) => DropdownMenuItem<String>(
          value: symbol,
          child: Text(symbol),
        )),
      ],
      onChanged: (value) {
        setState(() {
          _filters = _filters.copyWith(symbol: value ?? '');
        });
      },
    );
  }

  Widget _buildStatusFilter() {
    return DropdownButtonFormField<TradeStatus>(
      decoration: AppTheme.inputDecoration(
        labelText: 'Status',
        hintText: 'Select status',
        prefixIcon: Icons.info,
      ),
      value: _filters.status,
      items: [
        const DropdownMenuItem<TradeStatus>(
          value: null,
          child: Text('All Statuses'),
        ),
        ...TradeStatus.values.map((status) => DropdownMenuItem<TradeStatus>(
          value: status,
          child: Text(status.name.toUpperCase()),
        )),
      ],
      onChanged: (value) {
        setState(() {
          _filters = _filters.copyWith(status: value);
        });
      },
    );
  }

  Widget _buildDateRangeFilter() {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            decoration: AppTheme.inputDecoration(
              labelText: 'Start Date',
              hintText: 'Select start date',
              prefixIcon: Icons.calendar_today,
            ),
            readOnly: true,
            onTap: () => _selectStartDate(),
            controller: TextEditingController(
              text: _filters.dateRange?.start != null 
                  ? '${_filters.dateRange!.start.day}/${_filters.dateRange!.start.month}/${_filters.dateRange!.start.year}'
                  : '',
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: TextFormField(
            decoration: AppTheme.inputDecoration(
              labelText: 'End Date',
              hintText: 'Select end date',
              prefixIcon: Icons.calendar_today,
            ),
            readOnly: true,
            onTap: () => _selectEndDate(),
            controller: TextEditingController(
              text: _filters.dateRange?.end != null 
                  ? '${_filters.dateRange!.end.day}/${_filters.dateRange!.end.month}/${_filters.dateRange!.end.year}'
                  : '',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildExchangeFilter() {
    final provider = context.read<TradeListProvider>();
    final exchanges = provider.getUniqueExchanges();
    
    return DropdownButtonFormField<String>(
      decoration: AppTheme.inputDecoration(
        labelText: 'Exchange',
        hintText: 'Select exchange',
        prefixIcon: Icons.swap_horiz,
      ),
      value: _filters.exchanges.isNotEmpty ? _filters.exchanges.first : null,
      items: [
        const DropdownMenuItem<String>(
          value: null,
          child: Text('All Exchanges'),
        ),
        ...exchanges.map((exchange) => DropdownMenuItem<String>(
          value: exchange,
          child: Text(exchange),
        )),
      ],
      onChanged: (value) {
        setState(() {
          _filters = _filters.copyWith(
            exchanges: value != null ? [value] : [],
          );
        });
      },
    );
  }

  Widget _buildSideFilter() {
    return DropdownButtonFormField<Side>(
      decoration: AppTheme.inputDecoration(
        labelText: 'Side',
        hintText: 'Select side',
        prefixIcon: Icons.trending_up,
      ),
      value: _filters.side,
      items: [
        const DropdownMenuItem<Side>(
          value: null,
          child: Text('All Sides'),
        ),
        ...Side.values.map((side) => DropdownMenuItem<Side>(
          value: side,
          child: Text(side.name.toUpperCase()),
        )),
      ],
      onChanged: (value) {
        setState(() {
          _filters = _filters.copyWith(side: value);
        });
      },
    );
  }

  Widget _buildPnLRangeFilter() {
    final provider = context.read<TradeListProvider>();
    final minPnL = provider.getMinPnL();
    final maxPnL = provider.getMaxPnL();
    
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            decoration: AppTheme.inputDecoration(
              labelText: 'Min PnL',
              hintText: 'Min PnL',
              prefixIcon: Icons.trending_down,
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              final minValue = double.tryParse(value);
              setState(() {
                _filters = _filters.copyWith(minPnL: minValue);
              });
            },
            controller: TextEditingController(
              text: _filters.minPnL?.toString() ?? '',
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: TextFormField(
            decoration: AppTheme.inputDecoration(
              labelText: 'Max PnL',
              hintText: 'Max PnL',
              prefixIcon: Icons.trending_up,
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              final maxValue = double.tryParse(value);
              setState(() {
                _filters = _filters.copyWith(maxPnL: maxValue);
              });
            },
            controller: TextEditingController(
              text: _filters.maxPnL?.toString() ?? '',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRatingFilter() {
    return DropdownButtonFormField<int>(
      decoration: AppTheme.inputDecoration(
        labelText: 'Minimum Rating',
        hintText: 'Select minimum rating',
        prefixIcon: Icons.star,
      ),
      value: _filters.minRating,
      items: [
        const DropdownMenuItem<int>(
          value: null,
          child: Text('Any Rating'),
        ),
        ...List.generate(5, (index) => index + 1).map((rating) => DropdownMenuItem<int>(
          value: rating,
          child: Row(
            children: [
              Text('$rating '),
              ...List.generate(rating, (index) => const Icon(Icons.star, size: 16)),
            ],
          ),
        )),
      ],
      onChanged: (value) {
        setState(() {
          _filters = _filters.copyWith(minRating: value);
        });
      },
    );
  }

  Future<void> _selectStartDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _filters.dateRange?.start ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
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
      _filters = TradeFilters();
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
