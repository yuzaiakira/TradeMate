import '../../domain/entities/trade.dart' as domain;
import '../../domain/repositories/trade_repository.dart';
import '../models/trade_model.dart';
import '../../../../core/data/database.dart';
import '../../../../core/utils/trade_calculator.dart';
import '../../../../core/utils/logger.dart';

class TradeRepositoryImpl implements TradeRepository {
  final TradeMateDatabase database;

  TradeRepositoryImpl(this.database);

  /// Update account balance when a trade is saved or updated
  Future<void> _updateAccountBalanceForTrade(int tradeId, double pnl, double fees) async {
    try {
      // Get current account balance
      final currentBalance = await database.getCurrentAccountBalance();
      
      // Calculate new balance
      double newBalance = currentBalance;
      
      // Add PnL to balance
      if (pnl != 0) {
        newBalance += pnl;
      }
      
      // Subtract fees from balance
      if (fees > 0) {
        newBalance -= fees;
      }
      
      // Update the account balance in the database
      await database.updateAccountBalance(newBalance, 'Trade result processed');
      
    } catch (e) {
      Logger.error('Error updating account balance: $e', e);
      rethrow;
    }
  }

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
    // Calculate all system-calculated fields
    final calculatedTrade = await TradeCalculator.calculateAllFields(trade);
    
    final tradeModel = TradeModel(
      // Trade Transfers
      tag: calculatedTrade.tag,
      datetime: calculatedTrade.datetime,
      exchanges: calculatedTrade.exchanges,
      entryType: calculatedTrade.entryType,
      symbol: calculatedTrade.symbol,
      strategies: calculatedTrade.strategies,
      side: calculatedTrade.side,
      entryPrice: calculatedTrade.entryPrice,
      positionMargin: calculatedTrade.positionMargin,
      leverage: calculatedTrade.leverage,
      orderType: calculatedTrade.orderType,
      timeFrame: calculatedTrade.timeFrame,
      entryFeeRate: calculatedTrade.entryFeeRate,
      entryMentalStates: calculatedTrade.entryMentalStates,
      entryScreenshot: calculatedTrade.entryScreenshot,
      // Checklist
      checklist: calculatedTrade.checklist,
      // Trade Management
      stopLossPrice: calculatedTrade.stopLossPrice,
      takeProfitPrice: calculatedTrade.takeProfitPrice,
      // Trade Exit
      actualExitPrice: calculatedTrade.actualExitPrice,
      marginClosedPercent: calculatedTrade.marginClosedPercent,
      exitType: calculatedTrade.exitType,
      exitFeeRate: calculatedTrade.exitFeeRate,
      exitDatetime: calculatedTrade.exitDatetime,
      exitMentalStates: calculatedTrade.exitMentalStates,
      exitScreenshot: calculatedTrade.exitScreenshot,
      // Memo
      rating: calculatedTrade.rating,
      memo: calculatedTrade.memo,
      // Trackings
      trackings: calculatedTrade.trackings,
      mistakes: calculatedTrade.mistakes,
      // Transfers
      transferAmount: calculatedTrade.transferAmount,
      transferScreenshot: calculatedTrade.transferScreenshot,
      // Legacy fields
      type: calculatedTrade.type,
      status: calculatedTrade.status,
      exitPrice: calculatedTrade.exitPrice,
      quantity: calculatedTrade.quantity,
      stopLoss: calculatedTrade.stopLoss,
      takeProfit: calculatedTrade.takeProfit,
      pnl: calculatedTrade.pnl,
      pnlPercent: calculatedTrade.pnlPercent,
      riskRewardRatio: calculatedTrade.riskRewardRatio,
      entryDate: calculatedTrade.entryDate,
      exitDate: calculatedTrade.exitDate,
      notes: calculatedTrade.notes,
      screenshotPath: calculatedTrade.screenshotPath,
      accountBalance: calculatedTrade.accountBalance,
      riskAmount: calculatedTrade.riskAmount,
      achievedR: calculatedTrade.achievedR,
      tradeDuration: calculatedTrade.tradeDuration,
      // Calculated Trade Transfers Fields
      wl: calculatedTrade.wl,
      entryDayOfWeek: calculatedTrade.entryDayOfWeek,
      entrySession: calculatedTrade.entrySession,
      orderValue: calculatedTrade.orderValue,
      qty: calculatedTrade.qty,
      // Calculated Trade Management Fields
      positionToAccPercent: calculatedTrade.positionToAccPercent,
      plannedSlPercent: calculatedTrade.plannedSlPercent,
      accRiskedPercent: calculatedTrade.accRiskedPercent,
      plannedReturn: calculatedTrade.plannedReturn,
      // Calculated Trade Exit Fields
      exitDayOfWeek: calculatedTrade.exitDayOfWeek,
      psTag: calculatedTrade.psTag,
      // Calculated Trade Results Fields
      actualReturn: calculatedTrade.actualReturn,
      grossProfitLoss: calculatedTrade.grossProfitLoss,
      positionFees: calculatedTrade.positionFees,
      netProfitLoss: calculatedTrade.netProfitLoss,
      tradeGainPercent: calculatedTrade.tradeGainPercent,
      accountChangePercent: calculatedTrade.accountChangePercent,
      newBalance: calculatedTrade.newBalance,
      calculatedTradeDuration: calculatedTrade.calculatedTradeDuration,
    );
    
    final tradeId = await database.insertTrade(tradeModel.toDatabaseCompanion());
    
    // Update account balance if this is a closed trade with PnL
    if (calculatedTrade.status == domain.TradeStatus.closed && calculatedTrade.pnl != null) {
      try {
        await _updateAccountBalanceForTrade(tradeId, calculatedTrade.pnl!, calculatedTrade.positionFees ?? 0.0);
      } catch (e) {
        // Log error but don't fail the trade insertion
        Logger.error('Failed to update account balance: $e', e);
      }
    }
    
    return tradeId;
  }

  @override
  Future<bool> updateTrade(domain.Trade trade) async {
    // Calculate all system-calculated fields
    final calculatedTrade = await TradeCalculator.calculateAllFields(trade);
    
    final tradeModel = TradeModel(
      id: calculatedTrade.id,
      // Trade Transfers
      tag: calculatedTrade.tag,
      datetime: calculatedTrade.datetime,
      exchanges: calculatedTrade.exchanges,
      entryType: calculatedTrade.entryType,
      symbol: calculatedTrade.symbol,
      strategies: calculatedTrade.strategies,
      side: calculatedTrade.side,
      entryPrice: calculatedTrade.entryPrice,
      positionMargin: calculatedTrade.positionMargin,
      leverage: calculatedTrade.leverage,
      orderType: calculatedTrade.orderType,
      timeFrame: calculatedTrade.timeFrame,
      entryFeeRate: calculatedTrade.entryFeeRate,
      entryMentalStates: calculatedTrade.entryMentalStates,
      entryScreenshot: calculatedTrade.entryScreenshot,
      // Checklist
      checklist: calculatedTrade.checklist,
      // Trade Management
      stopLossPrice: calculatedTrade.stopLossPrice,
      takeProfitPrice: calculatedTrade.takeProfitPrice,
      // Trade Exit
      actualExitPrice: calculatedTrade.actualExitPrice,
      marginClosedPercent: calculatedTrade.marginClosedPercent,
      exitType: calculatedTrade.exitType,
      exitFeeRate: calculatedTrade.exitFeeRate,
      exitDatetime: calculatedTrade.exitDatetime,
      exitMentalStates: calculatedTrade.exitMentalStates,
      exitScreenshot: calculatedTrade.exitScreenshot,
      // Memo
      rating: calculatedTrade.rating,
      memo: calculatedTrade.memo,
      // Trackings
      trackings: calculatedTrade.trackings,
      mistakes: calculatedTrade.mistakes,
      // Transfers
      transferAmount: calculatedTrade.transferAmount,
      transferScreenshot: calculatedTrade.transferScreenshot,
      // Legacy fields
      type: calculatedTrade.type,
      status: calculatedTrade.status,
      exitPrice: calculatedTrade.exitPrice,
      quantity: calculatedTrade.quantity,
      stopLoss: calculatedTrade.stopLoss,
      takeProfit: calculatedTrade.takeProfit,
      pnl: calculatedTrade.pnl,
      pnlPercent: calculatedTrade.pnlPercent,
      riskRewardRatio: calculatedTrade.riskRewardRatio,
      entryDate: calculatedTrade.entryDate,
      exitDate: calculatedTrade.exitDate,
      notes: calculatedTrade.notes,
      screenshotPath: calculatedTrade.screenshotPath,
      accountBalance: calculatedTrade.accountBalance,
      riskAmount: calculatedTrade.riskAmount,
      achievedR: calculatedTrade.achievedR,
      tradeDuration: calculatedTrade.tradeDuration,
      // Calculated Trade Transfers Fields
      wl: calculatedTrade.wl,
      entryDayOfWeek: calculatedTrade.entryDayOfWeek,
      entrySession: calculatedTrade.entrySession,
      orderValue: calculatedTrade.orderValue,
      qty: calculatedTrade.qty,
      // Calculated Trade Management Fields
      positionToAccPercent: calculatedTrade.positionToAccPercent,
      plannedSlPercent: calculatedTrade.plannedSlPercent,
      accRiskedPercent: calculatedTrade.accRiskedPercent,
      plannedReturn: calculatedTrade.plannedReturn,
      // Calculated Trade Exit Fields
      exitDayOfWeek: calculatedTrade.exitDayOfWeek,
      psTag: calculatedTrade.psTag,
      // Calculated Trade Results Fields
      actualReturn: calculatedTrade.actualReturn,
      grossProfitLoss: calculatedTrade.grossProfitLoss,
      positionFees: calculatedTrade.positionFees,
      netProfitLoss: calculatedTrade.netProfitLoss,
      tradeGainPercent: calculatedTrade.tradeGainPercent,
      accountChangePercent: calculatedTrade.accountChangePercent,
      newBalance: calculatedTrade.newBalance,
      calculatedTradeDuration: calculatedTrade.calculatedTradeDuration,
    );
    
    final result = await database.updateTrade(tradeModel.toDatabaseCompanion());
    
    // Update account balance if this is a closed trade with PnL
    if (calculatedTrade.status == domain.TradeStatus.closed && calculatedTrade.pnl != null) {
      try {
        await _updateAccountBalanceForTrade(calculatedTrade.id!, calculatedTrade.pnl!, calculatedTrade.positionFees ?? 0.0);
      } catch (e) {
        // Log error but don't fail the trade update
        Logger.error('Failed to update account balance: $e', e);
      }
    }
    
    return result;
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
  
  // New optimized methods for pagination and filtering
  @override
  Future<List<domain.Trade>> getTradesPaginated({
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
    final trades = await database.getTradesPaginated(
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
    return trades.map((trade) => TradeModel.fromDatabase(trade).toDomain()).toList();
  }
  
  @override
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
  }) async {
    return await database.getTradesCount(
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
  
  @override
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
  }) async {
    return await database.getTradeStatisticsOptimized(
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
