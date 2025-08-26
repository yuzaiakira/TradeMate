import '../entities/trade.dart';
import '../repositories/trade_repository.dart';

class AddTradeUseCase {
  final TradeRepository repository;

  AddTradeUseCase(this.repository);

  Future<int> call(Trade trade) async {
    // Validate trade data
    if (trade.symbol.isEmpty) {
      throw ArgumentError('Symbol cannot be empty');
    }
    if (trade.entryPrice <= 0) {
      throw ArgumentError('Entry price must be greater than 0');
    }
    
    // For new trades, calculate quantity from positionMargin if available
    Trade tradeToSave = trade;
    if (trade.quantity <= 0 && trade.positionMargin != null && trade.positionMargin! > 0) {
      final calculatedQuantity = trade.positionMargin! / trade.entryPrice;
      tradeToSave = trade.copyWith(quantity: calculatedQuantity);
    }
    
    if (tradeToSave.quantity <= 0) {
      throw ArgumentError('Quantity must be greater than 0. Please provide either quantity or position margin.');
    }

    // Calculate derived fields
    final calculatedTrade = _calculateTradeFields(tradeToSave);
    
    return await repository.insertTrade(calculatedTrade);
  }

  Trade _calculateTradeFields(Trade trade) {
    // Calculate risk amount if stop loss is provided
    double? riskAmount;
    if (trade.stopLoss != null) {
      final riskPerUnit = (trade.entryPrice - trade.stopLoss!).abs();
      riskAmount = riskPerUnit * trade.quantity;
    }

    // Calculate risk/reward ratio
    double? riskRewardRatio;
    if (trade.stopLoss != null && trade.takeProfit != null) {
      final risk = (trade.entryPrice - trade.stopLoss!).abs();
      final reward = (trade.takeProfit! - trade.entryPrice).abs();
      if (risk > 0) {
        riskRewardRatio = reward / risk;
      }
    }

    // Calculate PnL if exit price is provided
    double? pnl;
    double? pnlPercent;
    if (trade.actualExitPrice != null) {
      final priceDifference = trade.actualExitPrice! - trade.entryPrice;
      final multiplier = trade.type == TradeType.buy ? 1 : -1;
      pnl = priceDifference * trade.quantity * multiplier;
      
      final positionValue = trade.entryPrice * trade.quantity;
      pnlPercent = (pnl / positionValue) * 100;
    }

    // Calculate achieved R
    double? achievedR;
    if (riskAmount != null && pnl != null && riskAmount > 0) {
      achievedR = pnl / riskAmount;
    }

    // Calculate trade duration
    int? tradeDuration;
    if (trade.exitDatetime != null) {
      tradeDuration = trade.exitDatetime!.difference(trade.datetime).inMinutes;
    }

    return trade.copyWith(
      riskAmount: riskAmount,
      riskRewardRatio: riskRewardRatio,
      pnl: pnl,
      pnlPercent: pnlPercent,
      achievedR: achievedR,
      tradeDuration: tradeDuration,
      // Update legacy fields for consistency
      exitPrice: trade.actualExitPrice,
      exitDate: trade.exitDatetime,
      stopLoss: trade.stopLossPrice,
      takeProfit: trade.takeProfitPrice,
    );
  }
}
