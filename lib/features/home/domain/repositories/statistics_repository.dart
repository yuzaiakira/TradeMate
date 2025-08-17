import '../entities/trade_statistics.dart';

abstract class StatisticsRepository {
  Future<TradeStatistics> getTradeStatistics();
  Future<TradeStatistics> calculateTradeStatistics();
  Future<bool> updateStatistics(TradeStatistics statistics);
}
