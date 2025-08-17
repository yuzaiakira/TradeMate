import '../entities/trade_statistics.dart';
import '../repositories/statistics_repository.dart';

class GetStatisticsUseCase {
  final StatisticsRepository repository;

  GetStatisticsUseCase(this.repository);

  Future<TradeStatistics> call() async {
    return await repository.getTradeStatistics();
  }
}
