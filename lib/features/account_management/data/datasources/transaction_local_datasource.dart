import 'package:drift/drift.dart';
import '../../../../core/data/database.dart';
import '../models/transaction_model.dart';
import '../../domain/entities/transaction.dart' as domain;

abstract class TransactionLocalDataSource {
  Future<TransactionModel> addTransaction(domain.Transaction transaction);
  Future<List<TransactionModel>> getTransactionHistory({
    DateTime? fromDate,
    DateTime? toDate,
    domain.TransactionType? type,
    int? limit,
  });
  Future<List<TransactionModel>> getTransactionsByTradeId(int tradeId);
  Future<double> getTotalDeposits();
  Future<double> getTotalWithdrawals();
  Future<double> getTotalTradePnL();
}

class TransactionLocalDataSourceImpl implements TransactionLocalDataSource {
  final TradeMateDatabase database;

  TransactionLocalDataSourceImpl({required this.database});

  @override
  Future<TransactionModel> addTransaction(domain.Transaction transaction) async {
    try {
      final model = TransactionModel(
        type: transaction.type,
        amount: transaction.amount,
        note: transaction.note,
        datetime: transaction.datetime,
        tradeId: transaction.tradeId,
        balanceBefore: transaction.balanceBefore,
        balanceAfter: transaction.balanceAfter,
      );

      final id = await database.into(database.accountTransactions).insert(
        model.toDatabaseCompanion(),
      );
      
      // Force sync to ensure data is written
      await database.ensureDataPersisted();

      return TransactionModel(
        id: id,
        type: model.type,
        amount: model.amount,
        note: model.note,
        datetime: model.datetime,
        tradeId: model.tradeId,
        balanceBefore: model.balanceBefore,
        balanceAfter: model.balanceAfter,
      );
    } catch (e) {
      throw Exception('Failed to add transaction: $e');
    }
  }

  @override
  Future<List<TransactionModel>> getTransactionHistory({
    DateTime? fromDate,
    DateTime? toDate,
    domain.TransactionType? type,
    int? limit,
  }) async {
    try {
      var query = database.select(database.accountTransactions);

      // Apply filters using cascade notation
      if (fromDate != null) {
        query = query..where((t) => t.datetime.isBiggerOrEqualValue(fromDate));
      }
      
      if (toDate != null) {
        query = query..where((t) => t.datetime.isSmallerOrEqualValue(toDate));
      }
      
      if (type != null) {
        final typeString = _transactionTypeToString(type);
        query = query..where((t) => t.type.equals(typeString));
      }

      // Apply ordering
      query = query..orderBy([(t) => OrderingTerm.desc(t.datetime)]);
      
      // Apply limit if specified
      if (limit != null) {
        query = query..limit(limit);
      }

      final results = await query.get();
      return results.map((t) => TransactionModel.fromDatabase(t)).toList();
    } catch (e) {
      throw Exception('Failed to get transaction history: $e');
    }
  }

  @override
  Future<List<TransactionModel>> getTransactionsByTradeId(int tradeId) async {
    try {
      final results = await (database.select(database.accountTransactions)
        ..where((t) => t.tradeId.equals(tradeId))
        ..orderBy([(t) => OrderingTerm.desc(t.datetime)]))
        .get();

      return results.map((t) => TransactionModel.fromDatabase(t)).toList();
    } catch (e) {
      throw Exception('Failed to get transactions by trade ID: $e');
    }
  }

  @override
  Future<double> getTotalDeposits() async {
    try {
      final results = await (database.select(database.accountTransactions)
        ..where((t) => t.type.equals('deposit')))
        .get();

      return results.fold<double>(0.0, (sum, t) => sum + t.amount);
    } catch (e) {
      throw Exception('Failed to get total deposits: $e');
    }
  }

  @override
  Future<double> getTotalWithdrawals() async {
    try {
      final results = await (database.select(database.accountTransactions)
        ..where((t) => t.type.equals('withdrawal')))
        .get();

      return results.fold<double>(0.0, (sum, t) => sum + t.amount);
    } catch (e) {
      throw Exception('Failed to get total withdrawals: $e');
    }
  }

  @override
  Future<double> getTotalTradePnL() async {
    try {
      final profitResults = await (database.select(database.accountTransactions)
        ..where((t) => t.type.equals('tradeProfit')))
        .get();

      final lossResults = await (database.select(database.accountTransactions)
        ..where((t) => t.type.equals('tradeLoss')))
        .get();

      final totalProfit = profitResults.fold<double>(0.0, (sum, t) => sum + t.amount);
      final totalLoss = lossResults.fold<double>(0.0, (sum, t) => sum + t.amount);

      return totalProfit - totalLoss;
    } catch (e) {
      throw Exception('Failed to get total trade PnL: $e');
    }
  }

  // Helper method for type conversion
  String _transactionTypeToString(domain.TransactionType type) {
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
