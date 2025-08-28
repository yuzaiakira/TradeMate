import '../../../features/add_trade/domain/entities/trade.dart';

class TradeCalculator {
  /// Calculate Win/Loss based on trade result
  static String calculateWL(Trade trade) {
    if (trade.status != TradeStatus.closed) return 'N/A';
    
    final pnl = trade.pnl ?? trade.calculatePnL();
    if (pnl == null) return 'N/A';
    
    return pnl > 0 ? 'W' : pnl < 0 ? 'L' : 'BE';
  }

  /// Calculate day of the week for entry
  static String calculateEntryDayOfWeek(Trade trade) {
    final days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    return days[trade.datetime.weekday - 1];
  }

  /// Calculate trading session based on entry time
  static String calculateEntrySession(Trade trade) {
    final hour = trade.datetime.hour;
    
    if (hour >= 8 && hour < 16) return 'London';
    if (hour >= 13 && hour < 21) return 'NY';
    if (hour >= 0 && hour < 8) return 'Tokyo';
    if (hour >= 21 || hour < 0) return 'Sydney';
    
    return 'Other';
  }

  /// Calculate order value
  static double? calculateOrderValue(Trade trade) {
    return trade.entryPrice * trade.quantity;
  }

  /// Calculate position to account percentage
  static double? calculatePositionToAccPercent(Trade trade) {
    if (trade.accountBalance <= 0) return null;
    final positionValue = trade.entryPrice * trade.quantity;
    return (positionValue / trade.accountBalance) * 100;
  }

  /// Calculate planned stop loss percentage
  static double? calculatePlannedSlPercent(Trade trade) {
    if (trade.stopLossPrice == null) return null;
    
    final priceDifference = (trade.entryPrice - trade.stopLossPrice!).abs();
    return (priceDifference / trade.entryPrice) * 100;
  }

  /// Calculate percentage of account risked
  static double? calculateAccRiskedPercent(Trade trade) {
    if (trade.accountBalance <= 0 || trade.stopLossPrice == null) return null;
    
    final riskAmount = (trade.entryPrice - trade.stopLossPrice!).abs() * trade.quantity;
    return (riskAmount / trade.accountBalance) * 100;
  }

  /// Calculate planned return (R)
  static double? calculatePlannedReturn(Trade trade) {
    if (trade.takeProfitPrice == null || trade.stopLossPrice == null) return null;
    
    final risk = (trade.entryPrice - trade.stopLossPrice!).abs();
    final reward = (trade.takeProfitPrice! - trade.entryPrice).abs();
    
    if (risk == 0) return null;
    return reward / risk;
  }

  /// Calculate day of the week for exit
  static String? calculateExitDayOfWeek(Trade trade) {
    if (trade.exitDatetime == null) return null;
    
    final days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    return days[trade.exitDatetime!.weekday - 1];
  }

  /// Calculate PS Tag (placeholder for now)
  static String? calculatePSTag(Trade trade) {
    // This would be calculated based on specific business logic
    // For now, return a placeholder
    return trade.status == TradeStatus.closed ? 'PS' : null;
  }

  /// Calculate actual return
  static double? calculateActualReturn(Trade trade) {
    if (trade.status != TradeStatus.closed) return null;
    
    final pnl = trade.pnl ?? trade.calculatePnL();
    if (pnl == null) return null;
    
    final positionValue = trade.entryPrice * trade.quantity;
    if (positionValue == 0) return null;
    
    return (pnl / positionValue) * 100;
  }

  /// Calculate gross profit/loss
  static double? calculateGrossProfitLoss(Trade trade) {
    if (trade.status != TradeStatus.closed) return null;
    
    return trade.pnl ?? trade.calculatePnL();
  }

  /// Calculate position fees
  static double? calculatePositionFees(Trade trade) {
    double totalFees = 0;
    
    // Entry fees
    if (trade.entryFeeRate != null) {
      final entryValue = trade.entryPrice * trade.quantity;
      totalFees += (entryValue * trade.entryFeeRate! / 100);
    }
    
    // Exit fees
    if (trade.exitFeeRate != null && trade.actualExitPrice != null) {
      final exitValue = trade.actualExitPrice! * trade.quantity;
      totalFees += (exitValue * trade.exitFeeRate! / 100);
    }
    
    return totalFees > 0 ? totalFees : null;
  }

  /// Calculate net profit/loss
  static double? calculateNetProfitLoss(Trade trade) {
    final grossPnL = calculateGrossProfitLoss(trade);
    final fees = calculatePositionFees(trade);
    
    if (grossPnL == null) return null;
    
    return grossPnL - (fees ?? 0);
  }

  /// Calculate trade gain percentage
  static double? calculateTradeGainPercent(Trade trade) {
    final netPnL = calculateNetProfitLoss(trade);
    if (netPnL == null) return null;
    
    final positionValue = trade.entryPrice * trade.quantity;
    if (positionValue == 0) return null;
    
    return (netPnL / positionValue) * 100;
  }

  /// Calculate account change percentage
  static double? calculateAccountChangePercent(Trade trade) {
    final netPnL = calculateNetProfitLoss(trade);
    if (netPnL == null || trade.accountBalance <= 0) return null;
    
    return (netPnL / trade.accountBalance) * 100;
  }

  /// Calculate new balance
  static double? calculateNewBalance(Trade trade) {
    final netPnL = calculateNetProfitLoss(trade);
    if (netPnL == null) return null;
    
    return trade.accountBalance + netPnL;
  }

  /// Calculate trade duration in minutes
  static int? calculateTradeDuration(Trade trade) {
    if (trade.exitDatetime == null) return null;
    
    return trade.exitDatetime!.difference(trade.datetime).inMinutes;
  }

  /// Calculate all fields for a trade
  static Trade calculateAllFields(Trade trade) {
    return trade.copyWith(
      // Calculated Trade Transfers Fields
      wl: calculateWL(trade),
      entryDayOfWeek: calculateEntryDayOfWeek(trade),
      entrySession: calculateEntrySession(trade),
      orderValue: calculateOrderValue(trade),
      qty: trade.quantity,
      // Calculated Trade Management Fields
      positionToAccPercent: calculatePositionToAccPercent(trade),
      plannedSlPercent: calculatePlannedSlPercent(trade),
      accRiskedPercent: calculateAccRiskedPercent(trade),
      plannedReturn: calculatePlannedReturn(trade),
      // Calculated Trade Exit Fields
      exitDayOfWeek: calculateExitDayOfWeek(trade),
      psTag: calculatePSTag(trade),
      // Calculated Trade Results Fields
      actualReturn: calculateActualReturn(trade),
      grossProfitLoss: calculateGrossProfitLoss(trade),
      positionFees: calculatePositionFees(trade),
      netProfitLoss: calculateNetProfitLoss(trade),
      tradeGainPercent: calculateTradeGainPercent(trade),
      accountChangePercent: calculateAccountChangePercent(trade),
      newBalance: calculateNewBalance(trade),
      calculatedTradeDuration: calculateTradeDuration(trade),
    );
  }
}
