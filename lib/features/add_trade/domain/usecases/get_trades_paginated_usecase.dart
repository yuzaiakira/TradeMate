import '../repositories/trade_repository.dart';
import '../entities/trade.dart';

class GetTradesPaginatedUseCase {
  final TradeRepository repository;

  GetTradesPaginatedUseCase(this.repository);

  Future<List<Trade>> call({
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
    return await repository.getTradesPaginated(
      limit: limit,
      offset: offset,
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
      sortBy: sortBy,
      sortDesc: sortDesc,
    );
  }
}

