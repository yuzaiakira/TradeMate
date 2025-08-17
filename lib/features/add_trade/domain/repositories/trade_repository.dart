import '../entities/trade.dart';

abstract class TradeRepository {
  Future<List<Trade>> getAllTrades();
  Future<Trade?> getTradeById(int id);
  Future<List<Trade>> getTradesByStatus(String status);
  Future<int> insertTrade(Trade trade);
  Future<bool> updateTrade(Trade trade);
  Future<bool> deleteTrade(int id);
  Future<List<Trade>> getTradesInDateRange(DateTime start, DateTime end);
}
