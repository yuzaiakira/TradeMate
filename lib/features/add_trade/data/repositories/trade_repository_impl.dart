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
      // Trade Transfers
      tag: trade.tag,
      datetime: trade.datetime,
      exchanges: trade.exchanges,
      entryType: trade.entryType,
      symbol: trade.symbol,
      strategies: trade.strategies,
      side: trade.side,
      entryPrice: trade.entryPrice,
      positionMargin: trade.positionMargin,
      leverage: trade.leverage,
      orderType: trade.orderType,
      timeFrame: trade.timeFrame,
      entryFeeRate: trade.entryFeeRate,
      entryMentalStates: trade.entryMentalStates,
      entryScreenshot: trade.entryScreenshot,
      // Checklist
      checklist: trade.checklist,
      // Trade Management
      stopLossPrice: trade.stopLossPrice,
      takeProfitPrice: trade.takeProfitPrice,
      // Trade Exit
      actualExitPrice: trade.actualExitPrice,
      marginClosedPercent: trade.marginClosedPercent,
      exitType: trade.exitType,
      exitFeeRate: trade.exitFeeRate,
      exitDatetime: trade.exitDatetime,
      exitMentalStates: trade.exitMentalStates,
      exitScreenshot: trade.exitScreenshot,
      // Memo
      rating: trade.rating,
      memo: trade.memo,
      // Trackings
      trackings: trade.trackings,
      mistakes: trade.mistakes,
      // Transfers
      transferAmount: trade.transferAmount,
      transferScreenshot: trade.transferScreenshot,
      // Legacy fields
      type: trade.type,
      status: trade.status,
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
      // Trade Transfers
      tag: trade.tag,
      datetime: trade.datetime,
      exchanges: trade.exchanges,
      entryType: trade.entryType,
      symbol: trade.symbol,
      strategies: trade.strategies,
      side: trade.side,
      entryPrice: trade.entryPrice,
      positionMargin: trade.positionMargin,
      leverage: trade.leverage,
      orderType: trade.orderType,
      timeFrame: trade.timeFrame,
      entryFeeRate: trade.entryFeeRate,
      entryMentalStates: trade.entryMentalStates,
      entryScreenshot: trade.entryScreenshot,
      // Checklist
      checklist: trade.checklist,
      // Trade Management
      stopLossPrice: trade.stopLossPrice,
      takeProfitPrice: trade.takeProfitPrice,
      // Trade Exit
      actualExitPrice: trade.actualExitPrice,
      marginClosedPercent: trade.marginClosedPercent,
      exitType: trade.exitType,
      exitFeeRate: trade.exitFeeRate,
      exitDatetime: trade.exitDatetime,
      exitMentalStates: trade.exitMentalStates,
      exitScreenshot: trade.exitScreenshot,
      // Memo
      rating: trade.rating,
      memo: trade.memo,
      // Trackings
      trackings: trade.trackings,
      mistakes: trade.mistakes,
      // Transfers
      transferAmount: trade.transferAmount,
      transferScreenshot: trade.transferScreenshot,
      // Legacy fields
      type: trade.type,
      status: trade.status,
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
