import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/app_theme.dart';
import '../bloc/account_bloc.dart';
import '../bloc/account_event.dart';
import '../bloc/account_state.dart';
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
    context.read<AccountBloc>().add(LoadTransactionHistory(
      fromDate: _fromDate,
      toDate: _toDate,
      type: _selectedType,
    ));
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
            child: BlocBuilder<AccountBloc, AccountState>(
              builder: (context, state) {
                if (state is TransactionHistoryLoaded) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      _loadTransactions();
                    },
                    color: AppTheme.primaryColor,
                    child: ListView(
                      padding: const EdgeInsets.all(12),
                      children: [
                        TransactionList(
                          transactions: state.transactions,
                          showAll: true,
                        ),
                      ],
                    ),
                  );
                }

                if (state is TransactionHistoryError) {
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
                          state.message,
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
    _loadTransactions();
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
          _loadTransactions();
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
            children: [
              _FilterChip(
                label: 'All',
                selected: _selectedType == null,
                onSelected: (selected) {
                  setState(() {
                    _selectedType = null;
                  });
                },
              ),
              _FilterChip(
                label: 'Deposits',
                selected: _selectedType == TransactionType.deposit,
                onSelected: (selected) {
                  setState(() {
                    _selectedType = selected ? TransactionType.deposit : null;
                  });
                },
              ),
              _FilterChip(
                label: 'Withdrawals',
                selected: _selectedType == TransactionType.withdrawal,
                onSelected: (selected) {
                  setState(() {
                    _selectedType = selected ? TransactionType.withdrawal : null;
                  });
                },
              ),
              _FilterChip(
                label: 'Trade Profits',
                selected: _selectedType == TransactionType.tradeProfit,
                onSelected: (selected) {
                  setState(() {
                    _selectedType = selected ? TransactionType.tradeProfit : null;
                  });
                },
              ),
              _FilterChip(
                label: 'Trade Losses',
                selected: _selectedType == TransactionType.tradeLoss,
                onSelected: (selected) {
                  setState(() {
                    _selectedType = selected ? TransactionType.tradeLoss : null;
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
          Row(
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
                  child: const Text('Clear All'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    widget.onApply(_selectedType, _fromDate, _toDate);
                    Navigator.pop(context);
                  },
                  child: const Text('Apply'),
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

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final ValueChanged<bool> onSelected;

  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(label),
      selected: selected,
      onSelected: onSelected,
      selectedColor: AppTheme.primaryColor.withValues(alpha: 0.2),
      checkmarkColor: AppTheme.primaryColor,
      labelStyle: TextStyle(
        color: selected ? AppTheme.primaryColor : AppTheme.textSecondaryColor,
        fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
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
        );
        onDateSelected(selectedDate);
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: AppTheme.borderColor),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              Icons.calendar_today_rounded,
              size: 16,
              color: AppTheme.textSecondaryColor,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                date != null 
                    ? '${date!.day}/${date!.month}/${date!.year}'
                    : 'Select date',
                style: AppTheme.captionStyle.copyWith(
                  color: date != null 
                      ? AppTheme.textSecondaryColor 
                      : AppTheme.textSecondaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
