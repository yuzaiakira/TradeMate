import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/utils/app_theme.dart';
import '../provider/account_provider.dart';
import '../widgets/transaction_list.dart';
import '../../domain/entities/transaction.dart';

class TransactionHistoryPage extends StatefulWidget {
  const TransactionHistoryPage({super.key});

  @override
  State<TransactionHistoryPage> createState() => _TransactionHistoryPageState();
}

class _TransactionHistoryPageState extends State<TransactionHistoryPage> {
  TransactionType? _selectedType;
  DateTime? _fromDate;
  DateTime? _toDate;

  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }

  void _loadTransactions() {
    // For now, we'll load all transactions and filter them in the UI
    // In the future, we can add filtering methods to AccountProvider
    context.read<AccountProvider>().loadAccountData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Transaction History',
          style: AppTheme.subheadingStyle.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list_rounded, size: 20),
            onPressed: () => _showFilterDialog(context),
            tooltip: 'Filter',
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter Summary
          if (_selectedType != null || _fromDate != null || _toDate != null)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withValues(alpha: 0.1),
                border: Border(
                  bottom: BorderSide(
                    color: AppTheme.borderColor,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.filter_alt_rounded,
                    size: 16,
                    color: AppTheme.primaryColor,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _buildFilterSummary(),
                      style: AppTheme.captionStyle.copyWith(
                        color: AppTheme.primaryColor,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: _clearFilters,
                    child: const Text('Clear'),
                  ),
                ],
              ),
            ),
          
          // Transaction List
          Expanded(
            child: Consumer<AccountProvider>(
              builder: (context, accountProvider, child) {
                if (accountProvider.status == AccountStatus.loaded) {
                  // Filter transactions based on selected filters
                  List<Transaction> filteredTransactions = accountProvider.transactions;
                  
                  if (_selectedType != null) {
                    filteredTransactions = filteredTransactions
                        .where((t) => t.type == _selectedType)
                        .toList();
                  }
                  
                  if (_fromDate != null) {
                    filteredTransactions = filteredTransactions
                        .where((t) => t.datetime.isAfter(_fromDate!))
                        .toList();
                  }
                  
                  if (_toDate != null) {
                    filteredTransactions = filteredTransactions
                        .where((t) => t.datetime.isBefore(_toDate!.add(const Duration(days: 1))))
                        .toList();
                  }
                  
                  return RefreshIndicator(
                    onRefresh: () async {
                      _loadTransactions();
                    },
                    color: AppTheme.primaryColor,
                    child: ListView(
                      padding: const EdgeInsets.all(12),
                      children: [
                        TransactionList(
                          transactions: filteredTransactions,
                          showAll: true,
                          showDeleteButton: true,
                        ),
                      ],
                    ),
                  );
                }

                if (accountProvider.status == AccountStatus.error) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 64,
                          color: AppTheme.errorColor,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Error loading transactions',
                          style: AppTheme.subheadingStyle,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          accountProvider.errorMessage ?? 'Unknown error',
                          style: AppTheme.captionStyle,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: _loadTransactions,
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }

                return const Center(
                  child: CircularProgressIndicator(
                    color: AppTheme.primaryColor,
                    strokeWidth: 2,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String _buildFilterSummary() {
    final parts = <String>[];
    
    if (_selectedType != null) {
      parts.add(_getTypeLabel(_selectedType!));
    }
    
    if (_fromDate != null) {
      parts.add('From ${_formatDate(_fromDate!)}');
    }
    
    if (_toDate != null) {
      parts.add('To ${_formatDate(_toDate!)}');
    }
    
    return parts.join(' • ');
  }

  String _getTypeLabel(TransactionType type) {
    switch (type) {
      case TransactionType.deposit:
        return 'Deposits';
      case TransactionType.withdrawal:
        return 'Withdrawals';
      case TransactionType.tradeProfit:
        return 'Trade Profits';
      case TransactionType.tradeLoss:
        return 'Trade Losses';
      case TransactionType.tradeFee:
        return 'Trade Fees';
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _clearFilters() {
    setState(() {
      _selectedType = null;
      _fromDate = null;
      _toDate = null;
    });
    // No need to reload transactions, just rebuild the UI
  }

  void _showFilterDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _FilterDialog(
        selectedType: _selectedType,
        fromDate: _fromDate,
        toDate: _toDate,
        onApply: (type, fromDate, toDate) {
          setState(() {
            _selectedType = type;
            _fromDate = fromDate;
            _toDate = toDate;
          });
          // No need to reload transactions, just rebuild the UI
        },
      ),
    );
  }
}

class _FilterDialog extends StatefulWidget {
  final TransactionType? selectedType;
  final DateTime? fromDate;
  final DateTime? toDate;
  final Function(TransactionType? type, DateTime? fromDate, DateTime? toDate) onApply;

  const _FilterDialog({
    this.selectedType,
    this.fromDate,
    this.toDate,
    required this.onApply,
  });

  @override
  State<_FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<_FilterDialog> {
  TransactionType? _selectedType;
  DateTime? _fromDate;
  DateTime? _toDate;

  @override
  void initState() {
    super.initState();
    _selectedType = widget.selectedType;
    _fromDate = widget.fromDate;
    _toDate = widget.toDate;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.filter_alt_rounded,
                color: AppTheme.primaryColor,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                'Filter Transactions',
                style: AppTheme.subheadingStyle.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Transaction Type Filter
          Text(
            'Transaction Type',
            style: AppTheme.labelStyle.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _TransactionTypeChip(
                type: null,
                label: 'All Transactions',
                selected: _selectedType == null,
                onSelected: (selected) {
                  setState(() {
                    _selectedType = null;
                  });
                },
              ),
              _TransactionTypeChip(
                type: TransactionType.deposit,
                label: 'Deposits',
                selected: _selectedType == TransactionType.deposit,
                onSelected: (selected) {
                  setState(() {
                    _selectedType = selected ? TransactionType.deposit : null;
                  });
                },
              ),
              _TransactionTypeChip(
                type: TransactionType.withdrawal,
                label: 'Withdrawals',
                selected: _selectedType == TransactionType.withdrawal,
                onSelected: (selected) {
                  setState(() {
                    _selectedType = selected ? TransactionType.withdrawal : null;
                  });
                },
              ),
              _TransactionTypeChip(
                type: TransactionType.tradeProfit,
                label: 'Trade Profits',
                selected: _selectedType == TransactionType.tradeProfit,
                onSelected: (selected) {
                  setState(() {
                    _selectedType = selected ? TransactionType.tradeProfit : null;
                  });
                },
              ),
              _TransactionTypeChip(
                type: TransactionType.tradeLoss,
                label: 'Trade Losses',
                selected: _selectedType == TransactionType.tradeLoss,
                onSelected: (selected) {
                  setState(() {
                    _selectedType = selected ? TransactionType.tradeLoss : null;
                  });
                },
              ),
              _TransactionTypeChip(
                type: TransactionType.tradeFee,
                label: 'Trade Fees',
                selected: _selectedType == TransactionType.tradeFee,
                onSelected: (selected) {
                  setState(() {
                    _selectedType = selected ? TransactionType.tradeFee : null;
                  });
                },
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Date Range Filter
          Text(
            'Date Range',
            style: AppTheme.labelStyle.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.surfaceColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppTheme.borderColor.withValues(alpha: 0.5),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _DatePickerField(
                    label: 'From Date',
                    date: _fromDate,
                    onDateSelected: (date) {
                      setState(() {
                        _fromDate = date;
                      });
                    },
                  ),
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: AppTheme.borderColor.withValues(alpha: 0.3),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _DatePickerField(
                    label: 'To Date',
                    date: _toDate,
                    onDateSelected: (date) {
                      setState(() {
                        _toDate = date;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Action Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    setState(() {
                      _selectedType = null;
                      _fromDate = null;
                      _toDate = null;
                    });
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppTheme.textSecondaryColor,
                    side: BorderSide(color: AppTheme.borderColor),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.clear_rounded, size: 18),
                      const SizedBox(width: 8),
                      const Text('Clear All'),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    widget.onApply(_selectedType, _fromDate, _toDate);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check_rounded, size: 18),
                      const SizedBox(width: 8),
                      const Text('Apply Filters'),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _TransactionTypeChip extends StatelessWidget {
  final TransactionType? type;
  final String label;
  final bool selected;
  final ValueChanged<bool> onSelected;

  const _TransactionTypeChip({
    this.type,
    required this.label,
    required this.selected,
    required this.onSelected,
  });

  IconData _getIcon() {
    if (type == null) return Icons.list_alt_rounded;
    
    switch (type!) {
      case TransactionType.deposit:
        return Icons.add_circle_rounded;
      case TransactionType.withdrawal:
        return Icons.remove_circle_rounded;
      case TransactionType.tradeProfit:
        return Icons.trending_up_rounded;
      case TransactionType.tradeLoss:
        return Icons.trending_down_rounded;
      case TransactionType.tradeFee:
        return Icons.receipt_rounded;
    }
  }

  Color _getColor() {
    if (type == null) return AppTheme.primaryColor;
    
    switch (type!) {
      case TransactionType.deposit:
      case TransactionType.tradeProfit:
        return AppTheme.bullishColor;
      case TransactionType.withdrawal:
      case TransactionType.tradeLoss:
      case TransactionType.tradeFee:
        return AppTheme.bearishColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _getColor();
    final icon = _getIcon();
    
    return FilterChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: selected ? color : AppTheme.textSecondaryColor,
          ),
          const SizedBox(width: 6),
          Text(label),
        ],
      ),
      selected: selected,
      onSelected: onSelected,
      selectedColor: color.withValues(alpha: 0.15),
      checkmarkColor: color,
      backgroundColor: AppTheme.surfaceColor,
      side: BorderSide(
        color: selected ? color : AppTheme.borderColor,
        width: selected ? 1.5 : 1,
      ),
      labelStyle: TextStyle(
        color: selected ? color : AppTheme.textSecondaryColor,
        fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
        fontSize: 13,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}

class _DatePickerField extends StatelessWidget {
  final String label;
  final DateTime? date;
  final Function(DateTime?) onDateSelected;

  const _DatePickerField({
    required this.label,
    required this.date,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final selectedDate = await showDatePicker(
          context: context,
          initialDate: date ?? DateTime.now(),
          firstDate: DateTime(2020),
          lastDate: DateTime.now(),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: AppTheme.primaryColor,
                ),
              ),
              child: child!,
            );
          },
        );
        onDateSelected(selectedDate);
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: AppTheme.captionStyle.copyWith(
                color: AppTheme.textSecondaryColor,
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  Icons.calendar_today_rounded,
                  size: 16,
                  color: date != null 
                      ? AppTheme.primaryColor 
                      : AppTheme.textSecondaryColor,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    date != null 
                        ? '${date!.day}/${date!.month}/${date!.year}'
                        : 'Select date',
                    style: AppTheme.bodyStyle.copyWith(
                      color: date != null 
                          ? AppTheme.textPrimaryColor 
                          : AppTheme.textSecondaryColor,
                      fontWeight: date != null ? FontWeight.w500 : FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
