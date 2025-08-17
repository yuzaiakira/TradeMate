import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

// Trade table
class Trades extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get symbol => text()();
  TextColumn get type => text()(); // BUY, SELL
  TextColumn get status => text()(); // OPEN, CLOSED
  RealColumn get entryPrice => real()();
  RealColumn get exitPrice => real().nullable()();
  RealColumn get quantity => real()();
  RealColumn get stopLoss => real().nullable()();
  RealColumn get takeProfit => real().nullable()();
  RealColumn get pnl => real().nullable()();
  RealColumn get pnlPercent => real().nullable()();
  RealColumn get riskRewardRatio => real().nullable()();
  DateTimeColumn get entryDate => dateTime()();
  DateTimeColumn get exitDate => dateTime().nullable()();
  TextColumn get notes => text().nullable()();
  TextColumn get screenshotPath => text().nullable()();
  RealColumn get accountBalance => real()();
  RealColumn get riskAmount => real().nullable()();
  RealColumn get achievedR => real().nullable()();
  IntColumn get tradeDuration => integer().nullable()(); // in minutes
}

// Account transactions table
class AccountTransactions extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get type => text()(); // DEPOSIT, WITHDRAWAL
  RealColumn get amount => real()();
  DateTimeColumn get date => dateTime()();
  TextColumn get notes => text().nullable()();
}

// Trade statistics table for caching
class TradeStatisticsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  RealColumn get totalTrades => real()();
  RealColumn get winningTrades => real()();
  RealColumn get losingTrades => real()();
  RealColumn get breakevenTrades => real()();
  RealColumn get openPositions => real()();
  RealColumn get avgAchievedR => real()();
  RealColumn get avgTradeDuration => real()();
  RealColumn get overallPnl => real()();
  RealColumn get avgPnl => real()();
  RealColumn get totalAccountGrowth => real()();
  RealColumn get totalDeposits => real()();
  RealColumn get totalWithdrawals => real()();
  RealColumn get currentAccountBalance => real()();
  DateTimeColumn get lastUpdated => dateTime()();
}

@DriftDatabase(tables: [Trades, AccountTransactions, TradeStatisticsTable])
class TradeMateDatabase extends _$TradeMateDatabase {
  TradeMateDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // Trade operations
  Future<List<Trade>> getAllTrades() async {
    try {
      return await select(trades).get();
    } catch (e) {
      return [];
    }
  }
  
  Future<Trade?> getTradeById(int id) => 
      (select(trades)..where((t) => t.id.equals(id))).getSingleOrNull();
  
  Future<List<Trade>> getTradesByStatus(String status) =>
      (select(trades)..where((t) => t.status.equals(status))).get();
  
  Future<int> insertTrade(TradesCompanion trade) => into(trades).insert(trade);
  
  Future<bool> updateTrade(TradesCompanion trade) => 
      update(trades).replace(trade);
  
  Future<int> deleteTrade(int id) => 
      (delete(trades)..where((t) => t.id.equals(id))).go();

  // Account transaction operations
  Future<List<AccountTransaction>> getAllTransactions() => 
      select(accountTransactions).get();
  
  Future<int> insertTransaction(AccountTransactionsCompanion transaction) => 
      into(accountTransactions).insert(transaction);
  
  Future<int> deleteTransaction(int id) => 
      (delete(accountTransactions)..where((t) => t.id.equals(id))).go();

  // Statistics operations
  Future<TradeStatisticsTableData?> getLatestStatistics() async {
    final results = await (select(tradeStatisticsTable)
      ..orderBy([(t) => OrderingTerm.desc(t.lastUpdated)]))
      .get();
    
    // Return the first (most recent) result, or null if empty
    return results.isNotEmpty ? results.first : null;
  }
  
  Future<int> insertStatistics(TradeStatisticsTableCompanion statistics) => 
      into(tradeStatisticsTable).insert(statistics);
  
  Future<bool> updateStatistics(TradeStatisticsTableCompanion statistics) => 
      update(tradeStatisticsTable).replace(statistics);
  
  // Clear old statistics entries to prevent accumulation
  Future<void> clearOldStatistics() => 
      delete(tradeStatisticsTable).go();

  // Complex queries
  Future<List<Trade>> getTradesInDateRange(DateTime start, DateTime end) =>
      (select(trades)
        ..where((t) => t.entryDate.isBiggerOrEqualValue(start) & t.entryDate.isSmallerOrEqualValue(end)))
      .get();

  Future<double> getTotalDeposits() async {
    try {
      final result = await (select(accountTransactions)
        ..where((t) => t.type.equals('DEPOSIT')))
        .get();
      double total = 0.0;
      for (final transaction in result) {
        total += transaction.amount;
      }
      return total;
    } catch (e) {
      return 0.0;
    }
  }

  Future<double> getTotalWithdrawals() async {
    try {
      final result = await (select(accountTransactions)
        ..where((t) => t.type.equals('WITHDRAWAL')))
        .get();
      double total = 0.0;
      for (final transaction in result) {
        total += transaction.amount;
      }
      return total;
    } catch (e) {
      return 0.0;
    }
  }

  Future<double> getCurrentAccountBalance() async {
    try {
      final totalDeposits = await getTotalDeposits();
      final totalWithdrawals = await getTotalWithdrawals();
      final closedTradesPnl = await getClosedTradesPnl();
      return totalDeposits - totalWithdrawals + closedTradesPnl;
    } catch (e) {
      return 0.0;
    }
  }

  Future<double> getClosedTradesPnl() async {
    try {
      final result = await (select(trades)
        ..where((t) => t.status.equals('CLOSED')))
        .get();
      double total = 0.0;
      for (final trade in result) {
        total += trade.pnl ?? 0.0;
      }
      return total;
    } catch (e) {
      return 0.0;
    }
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'trademate.db'));
    return NativeDatabase.createInBackground(file);
  });
}
