import '../../../features/add_trade/domain/entities/trade.dart';

class TradeCalculator {
  /// Calculate Win/Loss based on net profit/loss
  static String calculateWL(Trade trade) {
    final netPnL = calculateNetProfitLoss(trade);
    if (netPnL == null) return 'N/A';
    
    return netPnL > 0 ? 'W' : netPnL < 0 ? 'L' : 'BE';
  }

  /// Calculate day of the week for entry
  static String calculateEntryDayOfWeek(Trade trade) {
    final days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    return days[trade.datetime.weekday - 1];
  }

  /// Calculate trading session based on entry time
  static String calculateEntrySession(Trade trade) {
    final hour = trade.datetime.hour;
    
    if (hour >= 0 && hour < 8) return 'Asia';
    if (hour >= 8 && hour < 16) return 'London';
    if (hour >= 13 && hour < 21) return 'NY';
    
    return 'Other';
  }

  /// Calculate order value = entry price × QTY
  static double? calculateOrderValue(Trade trade) {
    return trade.entryPrice * trade.quantity;
  }

  /// Calculate QTY = (position margin × leverage) ÷ entry price
  static double? calculateQty(Trade trade) {
    if (trade.positionMargin == null || trade.leverage == null || trade.entryPrice <= 0) return null;
    return (trade.positionMargin! * trade.leverage!) / trade.entryPrice;
  }

  /// Calculate position to account percentage = (position margin ÷ account_balance) × 100
  static double? calculatePositionToAccPercent(Trade trade) {
    if (trade.positionMargin == null || trade.accountBalance <= 0) return null;
    return (trade.positionMargin! / trade.accountBalance) * 100;
  }

  /// Calculate planned stop loss percentage
  static double? calculatePlannedSlPercent(Trade trade) {
    if (trade.stopLossPrice == null) return null;
    
    if (trade.side == Side.long) {
      return ((trade.entryPrice - trade.stopLossPrice!) / trade.entryPrice) * 100;
    } else if (trade.side == Side.short) {
      return ((trade.stopLossPrice! - trade.entryPrice) / trade.entryPrice) * 100;
    }
    
    return null;
  }

  /// Calculate percentage of account risked = ((position margin × |planned SL %|) ÷ 100) ÷ account_balance × 100
  static double? calculateAccRiskedPercent(Trade trade) {
    final plannedSlPercent = calculatePlannedSlPercent(trade);
    if (trade.positionMargin == null || plannedSlPercent == null || trade.accountBalance <= 0) return null;
    
    return ((trade.positionMargin! * plannedSlPercent.abs()) / 100) / trade.accountBalance * 100;
  }

  /// Calculate planned return (R)
  static double? calculatePlannedReturn(Trade trade) {
    if (trade.takeProfitPrice == null || trade.stopLossPrice == null) return null;
    
    if (trade.side == Side.long) {
      final risk = trade.entryPrice - trade.stopLossPrice!;
      final reward = trade.takeProfitPrice! - trade.entryPrice;
      if (risk == 0) return null;
      return reward / risk;
    } else if (trade.side == Side.short) {
      final risk = trade.stopLossPrice! - trade.entryPrice;
      final reward = trade.entryPrice - trade.takeProfitPrice!;
      if (risk == 0) return null;
      return reward / risk;
    }
    
    return null;
  }

  /// Calculate day of the week for exit
  static String? calculateExitDayOfWeek(Trade trade) {
    if (trade.exitDatetime == null) return null;
    
    final days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    return days[trade.exitDatetime!.weekday - 1];
  }

  /// Calculate PS Tag = Strategies + "-" + session + "-" + rating
  static String? calculatePSTag(Trade trade) {
    if (trade.status != TradeStatus.closed) return null;
    
    final strategies = trade.strategies ?? '';
    final session = calculateEntrySession(trade);
    final rating = trade.rating?.toString() ?? '0';
    
    return '$strategies-$session-$rating';
  }

  /// Calculate actual return (R)
  static double? calculateActualReturn(Trade trade) {
    if (trade.status != TradeStatus.closed || trade.actualExitPrice == null || trade.stopLossPrice == null) return null;
    
    if (trade.side == Side.long) {
      final risk = trade.entryPrice - trade.stopLossPrice!;
      final reward = trade.actualExitPrice! - trade.entryPrice;
      if (risk == 0) return null;
      return reward / risk;
    } else if (trade.side == Side.short) {
      final risk = trade.stopLossPrice! - trade.entryPrice;
      final reward = trade.entryPrice - trade.actualExitPrice!;
      if (risk == 0) return null;
      return reward / risk;
    }
    
    return null;
  }

  /// Calculate gross profit/loss
  static double? calculateGrossProfitLoss(Trade trade) {
    if (trade.status != TradeStatus.closed || trade.actualExitPrice == null) return null;
    
    // Calculate quantity: (position margin × leverage ÷ entry price)
    final qty = calculateQty(trade);
    if (qty == null) return null;
    
    // Calculate margin closed percentage (default to 100% if not provided)
    final marginClosedPercent = trade.marginClosedPercent ?? 100.0;
    
    if (trade.side == Side.long) {
      return (trade.actualExitPrice! - trade.entryPrice) * qty * (marginClosedPercent / 100);
    } else if (trade.side == Side.short) {
      return (trade.entryPrice - trade.actualExitPrice!) * qty * (marginClosedPercent / 100);
    }
    
    return null;
  }

  /// Calculate position fees = (order value × entry fee rate) + (order value × exit fee rate)
  static double? calculatePositionFees(Trade trade) {
    double totalFees = 0;
    final orderValue = calculateOrderValue(trade) ?? 0;
    
    // Entry fees
    if (trade.entryFeeRate != null) {
      totalFees += (orderValue * trade.entryFeeRate! / 100);
    }
    
    // Exit fees
    if (trade.exitFeeRate != null) {
      totalFees += (orderValue * trade.exitFeeRate! / 100);
    }
    
    return totalFees > 0 ? totalFees : null;
  }

  /// Calculate net profit/loss = Gross profit/loss - position fees
  static double? calculateNetProfitLoss(Trade trade) {
    final grossPnL = calculateGrossProfitLoss(trade);
    final fees = calculatePositionFees(trade);
    
    if (grossPnL == null) return null;
    
    return grossPnL - (fees ?? 0);
  }

  /// Calculate trade gain % = (net profit/loss ÷ position margin) × 100
  static double? calculateTradeGainPercent(Trade trade) {
    final netPnL = calculateNetProfitLoss(trade);
    if (netPnL == null || trade.positionMargin == null || trade.positionMargin == 0) return null;
    
    return (netPnL / trade.positionMargin!) * 100;
  }

  /// Calculate account change % = (net profit/loss ÷ account_balance) × 100
  static double? calculateAccountChangePercent(Trade trade) {
    final netPnL = calculateNetProfitLoss(trade);
    if (netPnL == null || trade.accountBalance <= 0) return null;
    
    return (netPnL / trade.accountBalance) * 100;
  }

  /// Calculate new balance = account_balance + net profit/loss
  static double? calculateNewBalance(Trade trade) {
    final netPnL = calculateNetProfitLoss(trade);
    if (netPnL == null) return null;
    
    return trade.accountBalance + netPnL;
  }

  /// Calculate trade duration = datetime(exit) - datetime(entry)
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
      qty: calculateQty(trade) ?? trade.quantity,
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
