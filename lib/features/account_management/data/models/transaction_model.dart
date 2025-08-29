import '../../domain/entities/transaction.dart' as domain;
import '../../../../core/data/database.dart';
import 'package:drift/drift.dart';

class TransactionModel {
  final int? id;
  final domain.TransactionType type;
  final double amount;
  final String? note;
  final DateTime datetime;
  final int? tradeId;
  final double balanceBefore;
  final double balanceAfter;

  const TransactionModel({
    this.id,
    required this.type,
    required this.amount,
    this.note,
    required this.datetime,
    this.tradeId,
    required this.balanceBefore,
    required this.balanceAfter,
  });

  // Convert from database entity to domain entity
  factory TransactionModel.fromDatabase(AccountTransaction transaction) {
    return TransactionModel(
      id: transaction.id,
      type: _stringToTransactionType(transaction.type),
      amount: transaction.amount,
      note: transaction.note,
      datetime: transaction.datetime,
      tradeId: transaction.tradeId,
      balanceBefore: transaction.balanceBefore,
      balanceAfter: transaction.balanceAfter,
    );
  }

  // Convert to domain entity
  domain.Transaction toDomain() {
    return domain.Transaction(
      id: id,
      type: type,
      amount: amount,
      note: note,
      datetime: datetime,
      tradeId: tradeId,
      balanceBefore: balanceBefore,
      balanceAfter: balanceAfter,
    );
  }

  // Convert from domain entity to database companion
  AccountTransactionsCompanion toDatabaseCompanion() {
    return AccountTransactionsCompanion(
      id: id != null ? Value(id!) : const Value.absent(),
      type: Value(_transactionTypeToString(type)),
      amount: Value(amount),
      note: note != null ? Value(note!) : const Value.absent(),
      datetime: Value(datetime),
      tradeId: tradeId != null ? Value(tradeId!) : const Value.absent(),
      balanceBefore: Value(balanceBefore),
      balanceAfter: Value(balanceAfter),
    );
  }

  // Helper methods for type conversion
  static domain.TransactionType _stringToTransactionType(String type) {
    switch (type.toLowerCase()) {
      case 'deposit':
        return domain.TransactionType.deposit;
      case 'withdrawal':
        return domain.TransactionType.withdrawal;
      case 'tradeprofit':
        return domain.TransactionType.tradeProfit;
      case 'tradeloss':
        return domain.TransactionType.tradeLoss;
      case 'tradefee':
        return domain.TransactionType.tradeFee;
      default:
        return domain.TransactionType.deposit;
    }
  }

  static String _transactionTypeToString(domain.TransactionType type) {
    switch (type) {
      case domain.TransactionType.deposit:
        return 'deposit';
      case domain.TransactionType.withdrawal:
        return 'withdrawal';
      case domain.TransactionType.tradeProfit:
        return 'tradeProfit';
      case domain.TransactionType.tradeLoss:
        return 'tradeLoss';
      case domain.TransactionType.tradeFee:
        return 'tradeFee';
    }
  }
}
