import '../../domain/entities/trade.dart' as domain;
import '../../domain/repositories/trade_repository.dart';
import '../models/trade_model.dart';
import '../../../../core/data/database.dart';

class TradeRepositoryImpl implements TradeRepository {
  final TradeMateDatabase database;

  TradeRepositoryImpl(this.database);

  @override
  Future<List<domain.Trade>> getAllTrades() async {
    final trades = await database.getAllTrades();
    return trades.map((trade) => TradeModel.fromDatabase(trade).toDomain()).toList();
  }

  @override
  Future<domain.Trade?> getTradeById(int id) async {
    final trade = await database.getTradeById(id);
    return trade != null ? TradeModel.fromDatabase(trade).toDomain() : null;
  }

  @override
  Future<List<domain.Trade>> getTradesByStatus(String status) async {
    final trades = await database.getTradesByStatus(status);
    return trades.map((trade) => TradeModel.fromDatabase(trade).toDomain()).toList();
  }

  @override
  Future<int> insertTrade(domain.Trade trade) async {
    final tradeModel = TradeModel(
      symbol: trade.symbol,
      type: trade.type,
      status: trade.status,
      entryPrice: trade.entryPrice,
      exitPrice: trade.exitPrice,
      quantity: trade.quantity,
      stopLoss: trade.stopLoss,
      takeProfit: trade.takeProfit,
      pnl: trade.pnl,
      pnlPercent: trade.pnlPercent,
      riskRewardRatio: trade.riskRewardRatio,
      entryDate: trade.entryDate,
      exitDate: trade.exitDate,
      notes: trade.notes,
      screenshotPath: trade.screenshotPath,
      accountBalance: trade.accountBalance,
      riskAmount: trade.riskAmount,
      achievedR: trade.achievedR,
      tradeDuration: trade.tradeDuration,
    );
    
    return await database.insertTrade(tradeModel.toDatabaseCompanion());
  }

  @override
  Future<bool> updateTrade(domain.Trade trade) async {
    final tradeModel = TradeModel(
      id: trade.id,
      symbol: trade.symbol,
      type: trade.type,
      status: trade.status,
      entryPrice: trade.entryPrice,
      exitPrice: trade.exitPrice,
      quantity: trade.quantity,
      stopLoss: trade.stopLoss,
      takeProfit: trade.takeProfit,
      pnl: trade.pnl,
      pnlPercent: trade.pnlPercent,
      riskRewardRatio: trade.riskRewardRatio,
      entryDate: trade.entryDate,
      exitDate: trade.exitDate,
      notes: trade.notes,
      screenshotPath: trade.screenshotPath,
      accountBalance: trade.accountBalance,
      riskAmount: trade.riskAmount,
      achievedR: trade.achievedR,
      tradeDuration: trade.tradeDuration,
    );
    
    return await database.updateTrade(tradeModel.toDatabaseCompanion());
  }

  @override
  Future<bool> deleteTrade(int id) async {
    final deletedRows = await database.deleteTrade(id);
    return deletedRows > 0;
  }

  @override
  Future<List<domain.Trade>> getTradesInDateRange(DateTime start, DateTime end) async {
    final trades = await database.getTradesInDateRange(start, end);
    return trades.map((trade) => TradeModel.fromDatabase(trade).toDomain()).toList();
  }
}
