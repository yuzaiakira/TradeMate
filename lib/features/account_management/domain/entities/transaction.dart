import 'package:equatable/equatable.dart';

enum TransactionType {
  deposit,
  withdrawal,
  tradeProfit,
  tradeLoss,
  tradeFee,
}

class Transaction extends Equatable {
  final int? id;
  final TransactionType type;
  final double amount;
  final String? note;
  final DateTime datetime;
  final int? tradeId; // برای تراکنش‌های مربوط به ترید
  final double balanceBefore;
  final double balanceAfter;

  const Transaction({
    this.id,
    required this.type,
    required this.amount,
    this.note,
    required this.datetime,
    this.tradeId,
    required this.balanceBefore,
    required this.balanceAfter,
  });

  @override
  List<Object?> get props => [
    id,
    type,
    amount,
    note,
    datetime,
    tradeId,
    balanceBefore,
    balanceAfter,
  ];

  Transaction copyWith({
    int? id,
    TransactionType? type,
    double? amount,
    String? note,
    DateTime? datetime,
    int? tradeId,
    double? balanceBefore,
    double? balanceAfter,
  }) {
    return Transaction(
      id: id ?? this.id,
      type: type ?? this.type,
      amount: amount ?? this.amount,
      note: note ?? this.note,
      datetime: datetime ?? this.datetime,
      tradeId: tradeId ?? this.tradeId,
      balanceBefore: balanceBefore ?? this.balanceBefore,
      balanceAfter: balanceAfter ?? this.balanceAfter,
    );
  }

  // Helper methods
  bool get isPositive => amount >= 0;
  bool get isDeposit => type == TransactionType.deposit;
  bool get isWithdrawal => type == TransactionType.withdrawal;
  bool get isTradeRelated => type == TransactionType.tradeProfit || 
                           type == TransactionType.tradeLoss || 
                           type == TransactionType.tradeFee;
}
