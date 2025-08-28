import '../repositories/trade_repository.dart';

class GetTradeStatisticsOptimizedUseCase {
  final TradeRepository repository;

  GetTradeStatisticsOptimizedUseCase(this.repository);

  Future<Map<String, dynamic>> call({
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
    return await repository.getTradeStatisticsOptimized(
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
  }
}

