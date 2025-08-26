import '../entities/trade.dart';

abstract class TradeRepository {
  Future<List<Trade>> getAllTrades();
  Future<Trade?> getTradeById(int id);
  Future<List<Trade>> getTradesByStatus(String status);
  Future<int> insertTrade(Trade trade);
  Future<bool> updateTrade(Trade trade);
  Future<bool> deleteTrade(int id);
  Future<List<Trade>> getTradesInDateRange(DateTime start, DateTime end);
  
  // New optimized methods for pagination and filtering
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
  });
  
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
  });
  
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
  });
}
