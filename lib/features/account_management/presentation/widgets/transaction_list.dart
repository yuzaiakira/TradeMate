import 'package:flutter/material.dart';
import '../../../../core/utils/app_theme.dart';
import '../../domain/entities/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final bool showAll;

  const TransactionList({
    super.key,
    required this.transactions,
    this.showAll = true,
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
        return _TransactionItem(transaction: transaction);
      }).toList(),
    );
  }
}

class _TransactionItem extends StatelessWidget {
  final Transaction transaction;

  const _TransactionItem({required this.transaction});

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
        ],
      ),
    );
  }
}
