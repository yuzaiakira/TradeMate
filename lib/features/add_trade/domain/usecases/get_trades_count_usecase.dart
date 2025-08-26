import '../repositories/trade_repository.dart';

class GetTradesCountUseCase {
  final TradeRepository repository;

  GetTradesCountUseCase(this.repository);

  Future<int> call({
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
    return await repository.getTradesCount(
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
