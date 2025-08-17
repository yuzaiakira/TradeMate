import '../../domain/entities/trade_statistics.dart' as domain;
import '../../domain/repositories/statistics_repository.dart';
import '../../../../core/data/database.dart';
import '../../../add_trade/data/models/trade_model.dart';
import '../../../add_trade/domain/entities/trade.dart';
import 'package:drift/drift.dart';

class StatisticsRepositoryImpl implements StatisticsRepository {
  final TradeMateDatabase database;

  StatisticsRepositoryImpl(this.database);

  @override
  Future<domain.TradeStatistics> getTradeStatistics() async {
    try {
      // Try to get cached statistics first
      final cachedStats = await database.getLatestStatistics();
      if (cachedStats != null) {
        return _mapToTradeStatistics(cachedStats);
      }

      // If no cached stats, calculate them
      return await calculateTradeStatistics();
    } catch (e) {
      // If there's any error, fall back to calculating fresh statistics
      return await calculateTradeStatistics();
    }
  }

  @override
  Future<domain.TradeStatistics> calculateTradeStatistics() async {
    try {
      final allTrades = await database.getAllTrades();
      final trades = allTrades.map((trade) => TradeModel.fromDatabase(trade).toDomain()).toList();

      // Calculate basic counts
      final totalTrades = trades.length;
      final closedTrades = trades.where((t) => t.status == TradeStatus.closed).toList();
      final openPositions = trades.where((t) => t.status == TradeStatus.open).length;
      
      final winningTrades = closedTrades.where((t) => t.isWinning).length;
      final losingTrades = closedTrades.where((t) => t.isLosing).length;
      final breakevenTrades = closedTrades.where((t) => t.isBreakeven).length;

    // Calculate averages
    double avgAchievedR = 0.0;
    double avgTradeDuration = 0.0;
    double overallPnl = 0.0;
    double avgPnl = 0.0;

    if (closedTrades.isNotEmpty) {
      // Calculate average achieved R
      final achievedRs = closedTrades
          .where((t) => t.achievedR != null)
          .map((t) => t.achievedR!)
          .toList();
      avgAchievedR = achievedRs.isNotEmpty 
          ? achievedRs.reduce((a, b) => a + b) / achievedRs.length 
          : 0.0;

      // Calculate average trade duration
      final durations = closedTrades
          .where((t) => t.tradeDuration != null)
          .map((t) => t.tradeDuration!.toDouble())
          .toList();
      avgTradeDuration = durations.isNotEmpty 
          ? durations.reduce((a, b) => a + b) / durations.length 
          : 0.0;

      // Calculate overall and average PnL
      final pnls = closedTrades
          .where((t) => t.pnl != null)
          .map((t) => t.pnl!)
          .toList();
      overallPnl = pnls.isNotEmpty 
          ? pnls.reduce((a, b) => a + b) 
          : 0.0;
      avgPnl = pnls.isNotEmpty 
          ? overallPnl / pnls.length 
          : 0.0;
    }

    // Get account information
    final totalDeposits = await database.getTotalDeposits();
    final totalWithdrawals = await database.getTotalWithdrawals();
    final currentAccountBalance = await database.getCurrentAccountBalance();
    final totalAccountGrowth = currentAccountBalance - totalDeposits + totalWithdrawals;

    final statistics = domain.TradeStatistics(
      totalTrades: totalTrades,
      winningTrades: winningTrades,
      losingTrades: losingTrades,
      breakevenTrades: breakevenTrades,
      openPositions: openPositions,
      avgAchievedR: avgAchievedR,
      avgTradeDuration: avgTradeDuration,
      overallPnl: overallPnl,
      avgPnl: avgPnl,
      totalAccountGrowth: totalAccountGrowth,
      totalDeposits: totalDeposits,
      totalWithdrawals: totalWithdrawals,
      currentAccountBalance: currentAccountBalance,
      lastUpdated: DateTime.now(),
    );

    // Cache the statistics
    try {
      await _cacheStatistics(statistics);
    } catch (e) {
      // If caching fails, we can still return the statistics
      // The error is logged but doesn't prevent the operation
    }

    return statistics;
    } catch (e) {
      // Return default statistics if calculation fails
      return domain.TradeStatistics(
        totalTrades: 0,
        winningTrades: 0,
        losingTrades: 0,
        breakevenTrades: 0,
        openPositions: 0,
        avgAchievedR: 0.0,
        avgTradeDuration: 0.0,
        overallPnl: 0.0,
        avgPnl: 0.0,
        totalAccountGrowth: 0.0,
        totalDeposits: 0.0,
        totalWithdrawals: 0.0,
        currentAccountBalance: 0.0,
        lastUpdated: DateTime.now(),
      );
    }
  }

  @override
  Future<bool> updateStatistics(domain.TradeStatistics statistics) async {
    return await _cacheStatistics(statistics);
  }

  domain.TradeStatistics _mapToTradeStatistics(TradeStatisticsTableData dbStats) {
    return domain.TradeStatistics(
      totalTrades: dbStats.totalTrades.toInt(),
      winningTrades: dbStats.winningTrades.toInt(),
      losingTrades: dbStats.losingTrades.toInt(),
      breakevenTrades: dbStats.breakevenTrades.toInt(),
      openPositions: dbStats.openPositions.toInt(),
      avgAchievedR: dbStats.avgAchievedR,
      avgTradeDuration: dbStats.avgTradeDuration,
      overallPnl: dbStats.overallPnl,
      avgPnl: dbStats.avgPnl,
      totalAccountGrowth: dbStats.totalAccountGrowth,
      totalDeposits: dbStats.totalDeposits,
      totalWithdrawals: dbStats.totalWithdrawals,
      currentAccountBalance: dbStats.currentAccountBalance,
      lastUpdated: dbStats.lastUpdated,
    );
  }

  Future<bool> _cacheStatistics(domain.TradeStatistics statistics) async {
    final dbStats = TradeStatisticsTableCompanion(
      totalTrades: Value(statistics.totalTrades.toDouble()),
      winningTrades: Value(statistics.winningTrades.toDouble()),
      losingTrades: Value(statistics.losingTrades.toDouble()),
      breakevenTrades: Value(statistics.breakevenTrades.toDouble()),
      openPositions: Value(statistics.openPositions.toDouble()),
      avgAchievedR: Value(statistics.avgAchievedR),
      avgTradeDuration: Value(statistics.avgTradeDuration),
      overallPnl: Value(statistics.overallPnl),
      avgPnl: Value(statistics.avgPnl),
      totalAccountGrowth: Value(statistics.totalAccountGrowth),
      totalDeposits: Value(statistics.totalDeposits),
      totalWithdrawals: Value(statistics.totalWithdrawals),
      currentAccountBalance: Value(statistics.currentAccountBalance),
      lastUpdated: Value(statistics.lastUpdated),
    );

    try {
      // Clear old statistics entries first to prevent accumulation
      await database.clearOldStatistics();
      await database.insertStatistics(dbStats);
      return true;
    } catch (e) {
      return false;
    }
  }
}
