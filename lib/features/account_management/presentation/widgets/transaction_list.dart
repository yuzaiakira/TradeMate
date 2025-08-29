import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/app_theme.dart';
import '../../domain/entities/transaction.dart';
import '../bloc/account_bloc.dart';
import '../bloc/account_event.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final bool showAll;
  final bool showDeleteButton;

  const TransactionList({
    super.key,
    required this.transactions,
    this.showAll = true,
    this.showDeleteButton = false,
  });

  @override
  Widget build(BuildContext context) {
    if (transactions.isEmpty) {
      return Container(
        width: double.infinity, // Take full width
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.receipt_long_outlined,
              size: 48,
              color: AppTheme.textSecondaryColor.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 12),
            Text(
              'No transactions yet',
              style: AppTheme.captionStyle.copyWith(
                color: AppTheme.textSecondaryColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    final displayTransactions = showAll 
        ? transactions 
        : transactions.take(5).toList();

    return Column(
      children: displayTransactions.map((transaction) {
        return _TransactionItem(
          transaction: transaction,
          showDeleteButton: showDeleteButton,
        );
      }).toList(),
    );
  }
}

class _TransactionItem extends StatelessWidget {
  final Transaction transaction;
  final bool showDeleteButton;

  const _TransactionItem({
    required this.transaction,
    this.showDeleteButton = false,
  });

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(
      symbol: '\$',
      decimalDigits: 2,
    );

    final dateFormat = DateFormat('MMM dd, HH:mm');

    IconData getIcon() {
      switch (transaction.type) {
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

    Color getColor() {
      switch (transaction.type) {
        case TransactionType.deposit:
        case TransactionType.tradeProfit:
          return AppTheme.bullishColor;
        case TransactionType.withdrawal:
        case TransactionType.tradeLoss:
        case TransactionType.tradeFee:
          return AppTheme.bearishColor;
      }
    }

    String getTypeLabel() {
      switch (transaction.type) {
        case TransactionType.deposit:
          return 'Deposit';
        case TransactionType.withdrawal:
          return 'Withdrawal';
        case TransactionType.tradeProfit:
          return 'Trade Profit';
        case TransactionType.tradeLoss:
          return 'Trade Loss';
        case TransactionType.tradeFee:
          return 'Trade Fee';
      }
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppTheme.borderColor.withValues(alpha: 0.5),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: getColor().withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              getIcon(),
              color: getColor(),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      getTypeLabel(),
                      style: AppTheme.labelStyle.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      currencyFormat.format(transaction.amount.abs()),
                      style: AppTheme.priceStyle.copyWith(
                        color: getColor(),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    if (transaction.note != null) ...[
                      Expanded(
                        child: Text(
                          transaction.note!,
                          style: AppTheme.captionStyle.copyWith(
                            color: AppTheme.textSecondaryColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                    Text(
                      dateFormat.format(transaction.datetime),
                      style: AppTheme.captionStyle.copyWith(
                        color: AppTheme.textSecondaryColor,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
                if (transaction.tradeId != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    'Trade #${transaction.tradeId}',
                    style: AppTheme.captionStyle.copyWith(
                      color: AppTheme.primaryColor,
                      fontSize: 10,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (showDeleteButton && transaction.id != null) ...[
            const SizedBox(width: 8),
            IconButton(
              onPressed: () => _showDeleteConfirmation(context),
              icon: Icon(
                Icons.delete_outline,
                color: AppTheme.errorColor,
                size: 20,
              ),
              tooltip: 'Delete Transaction',
              padding: const EdgeInsets.all(4),
              constraints: const BoxConstraints(
                minWidth: 32,
                minHeight: 32,
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(
                Icons.delete_outline,
                color: AppTheme.errorColor,
                size: 24,
              ),
              const SizedBox(width: 8),
              const Text('Delete Transaction'),
            ],
          ),
          content: Text(
            'Are you sure you want to delete this transaction?\n\n'
            'This action cannot be undone.',
            style: AppTheme.bodyStyle,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (transaction.id != null) {
                  context.read<AccountBloc>().add(
                    DeleteTransaction(transactionId: transaction.id!),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.errorColor,
                foregroundColor: Colors.white,
              ),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
