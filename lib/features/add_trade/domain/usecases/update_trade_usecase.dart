import '../entities/trade.dart';
import '../repositories/trade_repository.dart';

class UpdateTradeUseCase {
  final TradeRepository repository;

  UpdateTradeUseCase(this.repository);

  Future<bool> call(Trade trade) async {
    // Validate trade data
    if (trade.id == null) {
      throw ArgumentError('Trade ID cannot be null for updates');
    }
    if (trade.symbol.isEmpty) {
      throw ArgumentError('Symbol cannot be empty');
    }
    if (trade.entryPrice <= 0) {
      throw ArgumentError('Entry price must be greater than 0');
    }
    
    // For updates, calculate quantity from positionMargin if available
    Trade tradeToUpdate = trade;
    if (trade.quantity <= 0 && trade.positionMargin != null && trade.positionMargin! > 0) {
      final calculatedQuantity = trade.positionMargin! / trade.entryPrice;
      tradeToUpdate = trade.copyWith(quantity: calculatedQuantity);
    }
    
    if (tradeToUpdate.quantity <= 0) {
      throw ArgumentError('Quantity must be greater than 0. Please provide either quantity or position margin.');
    }

    // Calculate derived fields
    final calculatedTrade = _calculateTradeFields(tradeToUpdate);
    
    final result = await repository.updateTrade(calculatedTrade);
    
    return result;
  }

  Trade _calculateTradeFields(Trade trade) {
    // Calculate risk amount if stop loss is provided
    double? riskAmount;
    if (trade.stopLossPrice != null) {
      double riskPerUnit;
      if (trade.side == Side.long) {
        // For long positions: risk is entry - stop loss
        riskPerUnit = trade.entryPrice - trade.stopLossPrice!;
      } else if (trade.side == Side.short) {
        // For short positions: risk is stop loss - entry
        riskPerUnit = trade.stopLossPrice! - trade.entryPrice;
      } else {
        // Fallback to legacy calculation for backward compatibility
        riskPerUnit = (trade.entryPrice - trade.stopLossPrice!).abs();
      }
      riskAmount = riskPerUnit * trade.quantity;
    }

    // Calculate risk/reward ratio
    double? riskRewardRatio;
    if (trade.stopLossPrice != null && trade.takeProfitPrice != null) {
      double risk, reward;
      
      if (trade.side == Side.long) {
        // For long positions: risk is entry - stop loss, reward is take profit - entry
        risk = trade.entryPrice - trade.stopLossPrice!;
        reward = trade.takeProfitPrice! - trade.entryPrice;
      } else if (trade.side == Side.short) {
        // For short positions: risk is stop loss - entry, reward is entry - take profit
        risk = trade.stopLossPrice! - trade.entryPrice;
        reward = trade.entryPrice - trade.takeProfitPrice!;
      } else {
        // Fallback to legacy calculation for backward compatibility
        risk = (trade.entryPrice - trade.stopLossPrice!).abs();
        reward = (trade.takeProfitPrice! - trade.entryPrice).abs();
      }
      
      if (risk > 0) {
        riskRewardRatio = reward / risk;
      }
    }

    // Calculate PnL if exit price is provided
    double? pnl;
    double? pnlPercent;
    if (trade.actualExitPrice != null) {
      final priceDifference = trade.actualExitPrice! - trade.entryPrice;
      
      // Use the new Side enum for proper PnL calculation
      double multiplier;
      if (trade.side == Side.long) {
        // For long positions: profit when exit price > entry price
        multiplier = 1;
      } else if (trade.side == Side.short) {
        // For short positions: profit when exit price < entry price
        multiplier = -1;
      } else {
        // Fallback to legacy TradeType for backward compatibility
        multiplier = trade.type == TradeType.buy ? 1 : -1;
      }
      
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
