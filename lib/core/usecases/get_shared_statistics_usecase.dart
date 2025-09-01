import 'package:flutter/foundation.dart';
import '../../../features/add_trade/domain/usecases/get_trade_statistics_optimized_usecase.dart';
import '../../../features/trade_list/presentation/models/trade_statistics.dart' as trade_list;
import '../../../features/home/domain/entities/trade_statistics.dart' as home;
import '../../../features/account_management/domain/repositories/account_repository.dart';

class GetSharedStatisticsUseCase {
  final GetTradeStatisticsOptimizedUseCase getTradeStatisticsOptimizedUseCase;
  final AccountRepository? accountRepository;

  GetSharedStatisticsUseCase(this.getTradeStatisticsOptimizedUseCase, {this.accountRepository});

  /// Get statistics for the Trade List page (using TradeListProvider's calculation logic)
  Future<trade_list.TradeStatistics> getTradeListStatistics({
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
    final statsData = await getTradeStatisticsOptimizedUseCase(
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
    );
    
    return trade_list.TradeStatistics(
      totalTrades: statsData['totalTrades'] ?? 0,
      winningTrades: statsData['winningTrades'] ?? 0,
      losingTrades: statsData['losingTrades'] ?? 0,
      breakevenTrades: statsData['breakevenTrades'] ?? 0,
      totalPnL: statsData['totalPnL'] ?? 0.0,
      averagePnL: statsData['averagePnL'] ?? 0.0,
      winRate: statsData['winRate'] ?? 0.0,
      averageR: statsData['averageR'] ?? 0.0,
      totalRiskAmount: statsData['totalRiskAmount'] ?? 0.0,
      totalRating: statsData['totalRating'] ?? 0,
      averageRating: statsData['averageRating'] ?? 0.0,
      uniqueSymbols: statsData['uniqueSymbols'] ?? 0,
      uniqueExchanges: statsData['uniqueExchanges'] ?? 0,
    );
  }

  /// Get statistics for the Home page (converted from Trade List format with account data)
  Future<home.TradeStatistics> getHomeStatistics() async {
    final tradeListStats = await getTradeListStatistics();
    
    // Get account data if available
    double totalDeposits = 0.0;
    double totalWithdrawals = 0.0;
    double currentAccountBalance = 0.0;
    
    if (accountRepository != null) {
      try {
        totalDeposits = await accountRepository!.getTotalDeposits();
        totalWithdrawals = await accountRepository!.getTotalWithdrawals();
        final currentBalance = await accountRepository!.getCurrentBalance();
        currentAccountBalance = currentBalance?.balance ?? 0.0;
      } catch (e) {
        // If account data fails, use defaults
        debugPrint('Failed to load account data: $e');
      }
    }
    
    // Calculate total account growth (current balance - deposits + withdrawals)
    final totalAccountGrowth = currentAccountBalance - totalDeposits + totalWithdrawals;
    
    // Convert to Home page format
    return home.TradeStatistics(
      totalTrades: tradeListStats.totalTrades,
      winningTrades: tradeListStats.winningTrades,
      losingTrades: tradeListStats.losingTrades,
      breakevenTrades: tradeListStats.breakevenTrades,
      openPositions: 0, // This will be calculated separately if needed
      avgAchievedR: tradeListStats.averageR,
      avgTradeDuration: 0.0, // This will be calculated separately if needed
      overallPnl: tradeListStats.totalPnL,
      avgPnl: tradeListStats.averagePnL,
      totalAccountGrowth: totalAccountGrowth,
      totalDeposits: totalDeposits,
      totalWithdrawals: totalWithdrawals,
      currentAccountBalance: currentAccountBalance,
      lastUpdated: DateTime.now(),
    );
  }

  /// Get overview statistics (Balance, Win Rate, Total P&L) for both pages
  Future<Map<String, dynamic>> getOverviewStatistics({
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
    final tradeListStats = await getTradeListStatistics(
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
    );

    return {
      'avgR': tradeListStats.averageR,
      'winRate': tradeListStats.winRate,
      'totalPnL': tradeListStats.totalPnL,
    };
  }
}
