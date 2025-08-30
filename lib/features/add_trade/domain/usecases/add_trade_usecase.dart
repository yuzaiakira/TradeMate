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
      double riskPerUnit;
      if (trade.side == Side.long) {
        // For long positions: risk is entry - stop loss
        riskPerUnit = trade.entryPrice - trade.stopLoss!;
      } else if (trade.side == Side.short) {
        // For short positions: risk is stop loss - entry
        riskPerUnit = trade.stopLoss! - trade.entryPrice;
      } else {
        // Fallback to legacy calculation for backward compatibility
        riskPerUnit = (trade.entryPrice - trade.stopLoss!).abs();
      }
      riskAmount = riskPerUnit * trade.quantity;
    }

    // Calculate risk/reward ratio
    double? riskRewardRatio;
    if (trade.stopLoss != null && trade.takeProfit != null) {
      double risk, reward;
      
      if (trade.side == Side.long) {
        // For long positions: risk is entry - stop loss, reward is take profit - entry
        risk = trade.entryPrice - trade.stopLoss!;
        reward = trade.takeProfit! - trade.entryPrice;
      } else if (trade.side == Side.short) {
        // For short positions: risk is stop loss - entry, reward is entry - take profit
        risk = trade.stopLoss! - trade.entryPrice;
        reward = trade.entryPrice - trade.takeProfit!;
      } else {
        // Fallback to legacy calculation for backward compatibility
        risk = (trade.entryPrice - trade.stopLoss!).abs();
        reward = (trade.takeProfit! - trade.entryPrice).abs();
      }
      
      if (risk > 0) {
        riskRewardRatio = reward / risk;
      }
    }

    // Note: PnL calculation is now handled by TradeCalculator.calculateAllFields()
    // which calculates netProfitLoss, grossProfitLoss, positionFees, etc.
    // This prevents conflicts and ensures consistent calculation

    return trade.copyWith(
      riskAmount: riskAmount,
      riskRewardRatio: riskRewardRatio,
      // Update legacy fields for consistency
      exitPrice: trade.actualExitPrice,
      exitDate: trade.exitDatetime,
      stopLoss: trade.stopLossPrice,
      takeProfit: trade.takeProfitPrice,
    );
  }
}
