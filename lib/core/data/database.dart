import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

// Trade table
class Trades extends Table {
  IntColumn get id => integer().autoIncrement()();
  
  // Trade Transfers
  TextColumn get tag => text().nullable()();
  DateTimeColumn get datetime => dateTime()();
  TextColumn get exchanges => text().nullable()();
  TextColumn get entryType => text().nullable()(); // Trade, Margin In/Out, Deposit, Withdrawal, Ignore
  TextColumn get symbol => text()();
  TextColumn get strategies => text().nullable()();
  TextColumn get side => text().nullable()(); // LONG, SHORT
  RealColumn get entryPrice => real()();
  RealColumn get positionMargin => real().nullable()();
  RealColumn get leverage => real().nullable()();
  TextColumn get orderType => text().nullable()(); // Market, Limit, Stop
  TextColumn get timeFrame => text().nullable()();
  RealColumn get entryFeeRate => real().nullable()();
  TextColumn get entryMentalStates => text().nullable()();
  TextColumn get entryScreenshot => text().nullable()();
  
  // Checklist
  TextColumn get checklist => text().nullable()(); // JSON string of checklist items
  
  // Trade Management
  RealColumn get stopLossPrice => real().nullable()();
  RealColumn get takeProfitPrice => real().nullable()();
  
  // Trade Exit
  RealColumn get actualExitPrice => real().nullable()();
  RealColumn get marginClosedPercent => real().nullable()();
  TextColumn get exitType => text().nullable()(); // TP, SL
  RealColumn get exitFeeRate => real().nullable()();
  DateTimeColumn get exitDatetime => dateTime().nullable()();
  TextColumn get exitMentalStates => text().nullable()();
  TextColumn get exitScreenshot => text().nullable()();
  
  // Memo
  IntColumn get rating => integer().nullable()(); // 1-5
  TextColumn get memo => text().nullable()();
  
  // Trackings
  TextColumn get trackings => text().nullable()();
  TextColumn get mistakes => text().nullable()();
  
  // Transfers
  RealColumn get transferAmount => real().nullable()();
  TextColumn get transferScreenshot => text().nullable()();
  
  // Legacy fields (keeping for backward compatibility)
  TextColumn get type => text()(); // BUY, SELL
  TextColumn get status => text()(); // OPEN, CLOSED
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

// User-defined values table for dropdowns
class UserDefinedValues extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get category => text()(); // exchanges, symbols, strategies, etc.
  TextColumn get value => text()();
  BoolColumn get isDefault => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
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

@DriftDatabase(tables: [Trades, UserDefinedValues, AccountTransactions, TradeStatisticsTable])
class TradeMateDatabase extends _$TradeMateDatabase {
  TradeMateDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migrations {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
    );
  }

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

  // User-defined values operations
  Future<List<UserDefinedValue>> getUserDefinedValues(String category) =>
      (select(userDefinedValues)
        ..where((v) => v.category.equals(category))
        ..orderBy([(v) => OrderingTerm.asc(v.value)]))
      .get();
  
  Future<int> insertUserDefinedValue(UserDefinedValuesCompanion value) =>
      into(userDefinedValues).insert(value);
  
  Future<bool> updateUserDefinedValue(UserDefinedValuesCompanion value) =>
      update(userDefinedValues).replace(value);
  
  Future<int> deleteUserDefinedValue(int id) =>
      (delete(userDefinedValues)..where((v) => v.id.equals(id))).go();
  
  Future<List<UserDefinedValue>> getDefaultValues(String category) =>
      (select(userDefinedValues)
        ..where((v) => v.category.equals(category) & v.isDefault.equals(true))
        ..orderBy([(v) => OrderingTerm.asc(v.value)]))
      .get();
  
  Future<void> setDefaultValue(String category, String value, bool isDefault) async {
    // First, unset all defaults for this category
    await (update(userDefinedValues)
      ..where((v) => v.category.equals(category)))
      .write(const UserDefinedValuesCompanion(isDefault: Value(false)));
    
    // Then set the new default
    await (update(userDefinedValues)
      ..where((v) => v.category.equals(category) & v.value.equals(value)))
      .write(UserDefinedValuesCompanion(isDefault: Value(isDefault)));
  }

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
    final file = File(p.join(dbFolder.path, 'trademate_v2.db'));
    return NativeDatabase.createInBackground(file);
  });
}
