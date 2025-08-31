import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import '../utils/logger.dart';

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
  RealColumn get balanceAtEntry => real().nullable()(); // Balance at the time of trade creation
  RealColumn get riskAmount => real().nullable()();
  RealColumn get achievedR => real().nullable()();
  IntColumn get tradeDuration => integer().nullable()(); // in minutes
  
  // Calculated Trade Transfers Fields
  TextColumn get wl => text().nullable()(); // Win/Loss
  TextColumn get entryDayOfWeek => text().nullable()(); // Day of the week for entry
  TextColumn get entrySession => text().nullable()(); // Session (London, NY, Tokyo, etc.)
  RealColumn get orderValue => real().nullable()(); // Order value
  RealColumn get qty => real().nullable()(); // Quantity (same as quantity but for consistency)
  
  // Calculated Trade Management Fields
  RealColumn get positionToAccPercent => real().nullable()(); // Position to account percentage
  RealColumn get plannedSlPercent => real().nullable()(); // Planned stop loss percentage
  RealColumn get accRiskedPercent => real().nullable()(); // Percentage of account risked
  RealColumn get plannedReturn => real().nullable()(); // Planned return (R)
  
  // Calculated Trade Exit Fields
  TextColumn get exitDayOfWeek => text().nullable()(); // Day of the week for exit
  TextColumn get psTag => text().nullable()(); // PS Tag
  
  // Calculated Trade Results Fields
  RealColumn get actualReturn => real().nullable()(); // Actual return
  RealColumn get grossProfitLoss => real().nullable()(); // Gross profit/loss
  RealColumn get positionFees => real().nullable()(); // Position fees
  RealColumn get netProfitLoss => real().nullable()(); // Net profit/loss
  RealColumn get tradeGainPercent => real().nullable()(); // Trade gain percentage
  RealColumn get accountChangePercent => real().nullable()(); // Account change percentage
  RealColumn get newBalance => real().nullable()(); // New balance
  IntColumn get calculatedTradeDuration => integer().nullable()(); // Trade duration in minutes
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

// Account Balance table
class AccountBalance extends Table {
  IntColumn get id => integer().autoIncrement()();
  RealColumn get balance => real()();
  DateTimeColumn get lastUpdated => dateTime()();
  TextColumn get note => text().nullable()();
}

// Account transactions table
class AccountTransactions extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get type => text()(); // deposit, withdrawal, tradeProfit, tradeLoss, tradeFee
  RealColumn get amount => real()();
  TextColumn get note => text().nullable()();
  DateTimeColumn get datetime => dateTime()();
  IntColumn get tradeId => integer().nullable()(); // برای تراکنش‌های مربوط به ترید
  RealColumn get balanceBefore => real()();
  RealColumn get balanceAfter => real()();
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

@DriftDatabase(tables: [Trades, UserDefinedValues, AccountBalance, AccountTransactions, TradeStatisticsTable])
class TradeMateDatabase extends _$TradeMateDatabase {
  TradeMateDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // Method to reset database if needed
  Future<void> resetDatabase() async {
    try {
      // Delete all data from tables
      await delete(trades).go();
      await delete(userDefinedValues).go();
      await delete(accountBalance).go();
      await delete(accountTransactions).go();
      await delete(tradeStatisticsTable).go();
      
      Logger.migration('Database reset successfully');
    } catch (e) {
      Logger.error('Error resetting database: $e', e);
      rethrow;
    }
  }

  // Method to completely recreate database file
  static Future<void> recreateDatabaseFile() async {
    try {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'trademate.db'));
      
      if (await file.exists()) {
        await file.delete();
        Logger.migration('Database file deleted successfully');
      }
      
      Logger.migration('Database file ready for recreation');
    } catch (e) {
      Logger.error('Error recreating database file: $e', e);
      rethrow;
    }
  }

  // Method to ensure data is persisted
  Future<void> ensureDataPersisted() async {
    try {
      // Force a small transaction to ensure data is written
      await customStatement('SELECT 1');
    } catch (e) {
      Logger.error('Error ensuring data persistence: $e', e);
    }
  }

  MigrationStrategy get migrations {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        Logger.migration('Creating new database with all tables...');
        await m.createAll();
        Logger.migration('Database created successfully');
      },
      onUpgrade: (Migrator m, int from, int to) async {
        Logger.migration('Upgrading database from version $from to version $to');
        // Just recreate all tables for now
        await m.createAll();
        Logger.migration('Database upgraded successfully');
      },
    );
  }

  // Trade operations with pagination and filtering
  Future<List<Trade>> getAllTrades() async {
    try {
      return await select(trades).get();
    } catch (e) {
      return [];
    }
  }
  
  Future<List<Trade>> getTradesPaginated({
    int limit = 20,
    int offset = 0,
    String? searchQuery,
    String? symbolFilter,
    String? statusFilter,
    DateTime? startDate,
    DateTime? endDate,
    String? exchangesFilter,
    String? sideFilter,
    double? minPnL,
    double? maxPnL,
    int? minRating,
    String? profitLossFilter,
    String sortBy = 'datetime',
    bool sortDesc = true,
  }) async {
    try {
      // Get all trades first
      final allTrades = await select(trades).get();
      
      // Apply filters in memory
      var filteredTrades = allTrades;
      
      if (searchQuery?.isNotEmpty == true) {
        final queryLower = searchQuery!.toLowerCase();
        filteredTrades = filteredTrades.where((t) => 
          t.symbol.toLowerCase().contains(queryLower) ||
          (t.memo?.toLowerCase().contains(queryLower) ?? false) ||
          (t.notes?.toLowerCase().contains(queryLower) ?? false) ||
          (t.tag?.toLowerCase().contains(queryLower) ?? false)
        ).toList();
      }
      
      if (symbolFilter?.isNotEmpty == true) {
        filteredTrades = filteredTrades.where((t) => 
          t.symbol.toLowerCase().contains(symbolFilter!.toLowerCase())
        ).toList();
      }
      
      if (statusFilter?.isNotEmpty == true) {
        filteredTrades = filteredTrades.where((t) => 
          t.status.toLowerCase() == statusFilter!.toLowerCase()
        ).toList();
      }
      
      if (startDate != null) {
        filteredTrades = filteredTrades.where((t) => 
          t.datetime.isAfter(startDate) || t.datetime.isAtSameMomentAs(startDate)
        ).toList();
      }
      
      if (endDate != null) {
        final endDatePlusOne = endDate.add(const Duration(days: 1));
        filteredTrades = filteredTrades.where((t) => 
          t.datetime.isBefore(endDatePlusOne)
        ).toList();
      }
      
      if (exchangesFilter?.isNotEmpty == true) {
        filteredTrades = filteredTrades.where((t) => 
          t.exchanges?.contains(exchangesFilter!) ?? false
        ).toList();
      }
      
      if (sideFilter?.isNotEmpty == true) {
        filteredTrades = filteredTrades.where((t) => 
          t.side?.toLowerCase() == sideFilter!.toLowerCase()
        ).toList();
      }
      
      if (minPnL != null) {
        filteredTrades = filteredTrades.where((t) => 
          (t.pnl ?? 0) >= minPnL
        ).toList();
      }
      
      if (maxPnL != null) {
        filteredTrades = filteredTrades.where((t) => 
          (t.pnl ?? 0) <= maxPnL
        ).toList();
      }
      
      if (minRating != null) {
        filteredTrades = filteredTrades.where((t) => 
          t.rating != null && t.rating! >= minRating
        ).toList();
      }
      
      if (profitLossFilter?.isNotEmpty == true) {
        switch (profitLossFilter!.toLowerCase()) {
          case 'profitable':
            filteredTrades = filteredTrades.where((t) => (t.pnl ?? 0) > 0).toList();
            break;
          case 'losing':
            filteredTrades = filteredTrades.where((t) => (t.pnl ?? 0) < 0).toList();
            break;
          case 'breakeven':
            filteredTrades = filteredTrades.where((t) => (t.pnl ?? 0) == 0).toList();
            break;
        }
      }
      
      // Apply sorting
      switch (sortBy.toLowerCase()) {
        case 'datetime':
          filteredTrades.sort((a, b) => sortDesc 
            ? b.datetime.compareTo(a.datetime) 
            : a.datetime.compareTo(b.datetime));
          break;
        case 'symbol':
          filteredTrades.sort((a, b) => sortDesc 
            ? b.symbol.compareTo(a.symbol) 
            : a.symbol.compareTo(b.symbol));
          break;
        case 'pnl':
          filteredTrades.sort((a, b) => sortDesc 
            ? (b.pnl ?? 0).compareTo(a.pnl ?? 0) 
            : (a.pnl ?? 0).compareTo(b.pnl ?? 0));
          break;
        case 'rating':
          filteredTrades.sort((a, b) => sortDesc 
            ? (b.rating ?? 0).compareTo(a.rating ?? 0) 
            : (a.rating ?? 0).compareTo(b.rating ?? 0));
          break;
      }
      
      // Apply pagination
      final startIndex = offset;
      final endIndex = offset + limit;
      if (startIndex < filteredTrades.length) {
        return filteredTrades.sublist(
          startIndex, 
          endIndex > filteredTrades.length ? filteredTrades.length : endIndex
        );
      }
      
      return [];
    } catch (e) {
      return [];
    }
  }
  
  Future<int> getTradesCount({
    String? searchQuery,
    String? symbolFilter,
    String? statusFilter,
    DateTime? startDate,
    DateTime? endDate,
    String? exchangesFilter,
    String? sideFilter,
    double? minPnL,
    double? maxPnL,
    int? minRating,
    String? profitLossFilter,
  }) async {
    try {
      final trades = await getTradesPaginated(
        searchQuery: searchQuery,
        symbolFilter: symbolFilter,
        statusFilter: statusFilter,
        startDate: startDate,
        endDate: endDate,
        exchangesFilter: exchangesFilter,
        sideFilter: sideFilter,
        minPnL: minPnL,
        maxPnL: maxPnL,
        minRating: minRating,
        profitLossFilter: profitLossFilter,
        limit: 1000000, // Large limit to get all results
        offset: 0,
      );
      return trades.length;
    } catch (e) {
      return 0;
    }
  }
  
  Future<Trade?> getTradeById(int id) => 
      (select(trades)..where((t) => t.id.equals(id))).getSingleOrNull();
  
  Future<List<Trade>> getTradesByStatus(String status) =>
      (select(trades)..where((t) => t.status.equals(status))).get();
  
  Future<int> insertTrade(TradesCompanion trade) => into(trades).insert(trade);
  
  Future<bool> updateTrade(TradesCompanion trade) async {
    try {
      await update(trades).replace(trade);
      return true;
    } catch (e) {
      return false;
    }
  }
  
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
  
  Future<bool> updateUserDefinedValue(UserDefinedValuesCompanion value) async {
    try {
      await update(userDefinedValues).replace(value);
      return true;
    } catch (e) {
      return false;
    }
  }
  
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
  
  Future<bool> updateStatistics(TradeStatisticsTableCompanion statistics) async {
    try {
      await update(tradeStatisticsTable).replace(statistics);
      return true;
    } catch (e) {
      return false;
    }
  }
  
  // Clear old statistics entries to prevent accumulation
  Future<void> clearOldStatistics() => 
      delete(tradeStatisticsTable).go();
  
  // Optimized statistics calculation at database level
  Future<Map<String, dynamic>> getTradeStatisticsOptimized({
    String? searchQuery,
    String? symbolFilter,
    String? statusFilter,
    DateTime? startDate,
    DateTime? endDate,
    String? exchangesFilter,
    String? sideFilter,
    double? minPnL,
    double? maxPnL,
    int? minRating,
    String? profitLossFilter,
  }) async {
    try {
      final trades = await getTradesPaginated(
        searchQuery: searchQuery,
        symbolFilter: symbolFilter,
        statusFilter: statusFilter,
        startDate: startDate,
        endDate: endDate,
        exchangesFilter: exchangesFilter,
        sideFilter: sideFilter,
        minPnL: minPnL,
        maxPnL: maxPnL,
        minRating: minRating,
        profitLossFilter: profitLossFilter,
        limit: 1000000, // Large limit to get all results
        offset: 0,
      );
      
      if (trades.isEmpty) {
        return {
          'totalTrades': 0,
          'profitableTrades': 0,
          'losingTrades': 0,
          'breakevenTrades': 0,
          'totalPnL': 0.0,
          'averagePnL': 0.0,
          'winRate': 0.0,
          'totalRating': 0,
          'averageRating': 0.0,
          'uniqueSymbols': 0,
          'uniqueExchanges': 0,
        };
      }
      
      final profitableTrades = trades.where((t) => (t.pnl ?? 0) > 0).length;
      final losingTrades = trades.where((t) => (t.pnl ?? 0) < 0).length;
      final breakevenTrades = trades.where((t) => (t.pnl ?? 0) == 0).length;
      final totalPnL = trades.fold(0.0, (sum, t) => sum + (t.pnl ?? 0));
      final averagePnL = totalPnL / trades.length;
      final winRate = trades.isNotEmpty ? (profitableTrades / trades.length) * 100 : 0.0;
      
      final ratedTrades = trades.where((t) => t.rating != null).toList();
      final totalRating = ratedTrades.fold(0, (sum, t) => sum + (t.rating ?? 0));
      final averageRating = ratedTrades.isNotEmpty ? totalRating / ratedTrades.length : 0.0;
      
      final uniqueSymbols = trades.map((t) => t.symbol).toSet().length;
      final uniqueExchanges = trades
          .where((t) => t.exchanges != null && t.exchanges!.isNotEmpty)
          .map((t) => t.exchanges!)
          .toSet()
          .length;
      
      return {
        'totalTrades': trades.length,
        'profitableTrades': profitableTrades,
        'losingTrades': losingTrades,
        'breakevenTrades': breakevenTrades,
        'totalPnL': totalPnL,
        'averagePnL': averagePnL,
        'winRate': winRate,
        'totalRating': totalRating,
        'averageRating': averageRating,
        'uniqueSymbols': uniqueSymbols,
        'uniqueExchanges': uniqueExchanges,
      };
    } catch (e) {
      return {
        'totalTrades': 0,
        'profitableTrades': 0,
        'losingTrades': 0,
        'breakevenTrades': 0,
        'totalPnL': 0.0,
        'averagePnL': 0.0,
        'winRate': 0.0,
        'totalRating': 0,
        'averageRating': 0.0,
        'uniqueSymbols': 0,
        'uniqueExchanges': 0,
      };
    }
  }

  // Complex queries
  Future<List<Trade>> getTradesInDateRange(DateTime start, DateTime end) =>
      (select(trades)
        ..where((t) => t.entryDate.isBiggerOrEqualValue(start) & t.entryDate.isSmallerOrEqualValue(end)))
      .get();

  Future<double> getTotalDeposits() async {
    try {
      final result = await (select(accountTransactions)
        ..where((t) => t.type.equals('deposit')))
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
        ..where((t) => t.type.equals('withdrawal')))
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
        // Use netProfitLoss if available (includes fees), otherwise fall back to pnl
        total += trade.netProfitLoss ?? trade.pnl ?? 0.0;
      }
      return total;
    } catch (e) {
      return 0.0;
    }
  }

  /// Update account balance in the AccountBalance table
  Future<void> updateAccountBalance(double newBalance, String? note) async {
    try {
      final now = DateTime.now();
      
      // Check if balance record exists
      final existingBalance = await select(accountBalance).getSingleOrNull();
      
      if (existingBalance != null) {
        // Update existing record
        await update(accountBalance).replace(
          AccountBalanceCompanion(
            id: Value(existingBalance.id),
            balance: Value(newBalance),
            lastUpdated: Value(now),
            note: note != null ? Value(note) : const Value.absent(),
          ),
        );
      } else {
        // Create new record
        await into(accountBalance).insert(
          AccountBalanceCompanion.insert(
            balance: newBalance,
            lastUpdated: now,
            note: note != null ? Value(note) : const Value.absent(),
          ),
        );
      }
      
      // Force sync to ensure data is written
      await ensureDataPersisted();
    } catch (e) {
      throw Exception('Failed to update account balance: $e');
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
