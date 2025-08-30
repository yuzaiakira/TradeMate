import 'package:equatable/equatable.dart';

enum TradeType { buy, sell }
enum TradeStatus { open, closed }
enum EntryType { trade, marginInOut, deposit, withdrawal, ignore }
enum Side { long, short }
enum OrderType { market, limit, stop }
enum ExitType { tp, sl }

class Trade extends Equatable {
  final int? id;
  
  // Trade Transfers
  final String? tag;
  final DateTime datetime;
  final String? exchanges;
  final EntryType? entryType;
  final String symbol;
  final String? strategies;
  final Side? side;
  final double entryPrice;
  final double? positionMargin;
  final double? leverage;
  final OrderType? orderType;
  final String? timeFrame;
  final double? entryFeeRate;
  final String? entryMentalStates;
  final String? entryScreenshot;
  
  // Checklist
  final List<String>? checklist;
  
  // Trade Management
  final double? stopLossPrice;
  final double? takeProfitPrice;
  
  // Trade Exit
  final double? actualExitPrice;
  final double? marginClosedPercent;
  final ExitType? exitType;
  final double? exitFeeRate;
  final DateTime? exitDatetime;
  final String? exitMentalStates;
  final String? exitScreenshot;
  
  // Memo
  final int? rating; // 1-5
  final String? memo;
  
  // Trackings
  final String? trackings;
  final String? mistakes;
  
  // Transfers
  final double? transferAmount;
  final String? transferScreenshot;
  
  // Legacy fields (keeping for backward compatibility)
  final TradeType type;
  final TradeStatus status;
  final double? exitPrice;
  final double quantity;
  final double? stopLoss;
  final double? takeProfit;
  final double? pnl;
  final double? pnlPercent;
  final double? riskRewardRatio;
  final DateTime entryDate;
  final DateTime? exitDate;
  final String? notes;
  final String? screenshotPath;
  final double accountBalance;
  final double? riskAmount;
  final double? achievedR;
  final int? tradeDuration; // in minutes
  
  // Calculated Trade Transfers Fields
  final String? wl; // Win/Loss
  final String? entryDayOfWeek; // Day of the week for entry
  final String? entrySession; // Session (London, NY, Tokyo, etc.)
  final double? orderValue; // Order value
  final double? qty; // Quantity (same as quantity but for consistency)
  
  // Calculated Trade Management Fields
  final double? positionToAccPercent; // Position to account percentage
  final double? plannedSlPercent; // Planned stop loss percentage
  final double? accRiskedPercent; // Percentage of account risked
  final double? plannedReturn; // Planned return (R)
  
  // Calculated Trade Exit Fields
  final String? exitDayOfWeek; // Day of the week for exit
  final String? psTag; // PS Tag
  
  // Calculated Trade Results Fields
  final double? actualReturn; // Actual return
  final double? grossProfitLoss; // Gross profit/loss
  final double? positionFees; // Position fees
  final double? netProfitLoss; // Net profit/loss
  final double? tradeGainPercent; // Trade gain percentage
  final double? accountChangePercent; // Account change percentage
  final double? newBalance; // New balance
  final int? calculatedTradeDuration; // Trade duration in minutes

  const Trade({
    this.id,
    // Trade Transfers
    this.tag,
    required this.datetime,
    this.exchanges,
    this.entryType,
    required this.symbol,
    this.strategies,
    this.side,
    required this.entryPrice,
    this.positionMargin,
    this.leverage,
    this.orderType,
    this.timeFrame,
    this.entryFeeRate,
    this.entryMentalStates,
    this.entryScreenshot,
    // Checklist
    this.checklist,
    // Trade Management
    this.stopLossPrice,
    this.takeProfitPrice,
    // Trade Exit
    this.actualExitPrice,
    this.marginClosedPercent,
    this.exitType,
    this.exitFeeRate,
    this.exitDatetime,
    this.exitMentalStates,
    this.exitScreenshot,
    // Memo
    this.rating,
    this.memo,
    // Trackings
    this.trackings,
    this.mistakes,
    // Transfers
    this.transferAmount,
    this.transferScreenshot,
    // Legacy fields
    required this.type,
    required this.status,
    this.exitPrice,
    required this.quantity,
    this.stopLoss,
    this.takeProfit,
    this.pnl,
    this.pnlPercent,
    this.riskRewardRatio,
    required this.entryDate,
    this.exitDate,
    this.notes,
    this.screenshotPath,
    required this.accountBalance,
    this.riskAmount,
    this.achievedR,
    this.tradeDuration,
    // Calculated Trade Transfers Fields
    this.wl,
    this.entryDayOfWeek,
    this.entrySession,
    this.orderValue,
    this.qty,
    // Calculated Trade Management Fields
    this.positionToAccPercent,
    this.plannedSlPercent,
    this.accRiskedPercent,
    this.plannedReturn,
    // Calculated Trade Exit Fields
    this.exitDayOfWeek,
    this.psTag,
    // Calculated Trade Results Fields
    this.actualReturn,
    this.grossProfitLoss,
    this.positionFees,
    this.netProfitLoss,
    this.tradeGainPercent,
    this.accountChangePercent,
    this.newBalance,
    this.calculatedTradeDuration,
  });

  // Calculate PnL
  double? calculatePnL() {
    if (exitPrice == null || status != TradeStatus.closed) return null;
    
    final priceDifference = exitPrice! - entryPrice;
    
    // Use the new Side enum for proper PnL calculation
    double multiplier;
    if (side == Side.long) {
      // For long positions: profit when exit price > entry price
      multiplier = 1;
    } else if (side == Side.short) {
      // For short positions: profit when exit price < entry price
      multiplier = -1;
    } else {
      // Fallback to legacy TradeType for backward compatibility
      multiplier = type == TradeType.buy ? 1 : -1;
    }
    
    return priceDifference * quantity * multiplier;
  }

  // Calculate PnL percentage
  double? calculatePnLPercent() {
    final pnl = calculatePnL();
    if (pnl == null) return null;
    
    final positionValue = entryPrice * quantity;
    return (pnl / positionValue) * 100;
  }

  // Calculate Risk/Reward ratio
  double? calculateRiskRewardRatio() {
    if (stopLoss == null || takeProfit == null) return null;
    
    double risk, reward;
    
    if (side == Side.long) {
      // For long positions: risk is entry - stop loss, reward is take profit - entry
      risk = entryPrice - stopLoss!;
      reward = takeProfit! - entryPrice;
    } else if (side == Side.short) {
      // For short positions: risk is stop loss - entry, reward is entry - take profit
      risk = stopLoss! - entryPrice;
      reward = entryPrice - takeProfit!;
    } else {
      // Fallback to legacy calculation for backward compatibility
      risk = (entryPrice - stopLoss!).abs();
      reward = (takeProfit! - entryPrice).abs();
    }
    
    if (risk == 0) return null;
    return reward / risk;
  }

  // Calculate achieved R
  double? calculateAchievedR() {
    if (riskAmount == null || pnl == null) return null;
    if (riskAmount == 0) return null;
    
    return pnl! / riskAmount!;
  }

  // Calculate trade duration
  int? calculateTradeDuration() {
    if (exitDate == null) return null;
    return exitDate!.difference(entryDate).inMinutes;
  }

  // Check if trade is winning
  bool get isWinning => pnl != null && pnl! > 0;

  // Check if trade is losing
  bool get isLosing => pnl != null && pnl! < 0;

  // Check if trade is breakeven
  bool get isBreakeven => pnl != null && pnl == 0;

  // Copy with method
  Trade copyWith({
    int? id,
    String? tag,
    DateTime? datetime,
    String? exchanges,
    EntryType? entryType,
    String? symbol,
    String? strategies,
    Side? side,
    double? entryPrice,
    double? positionMargin,
    double? leverage,
    OrderType? orderType,
    String? timeFrame,
    double? entryFeeRate,
    String? entryMentalStates,
    String? entryScreenshot,
    List<String>? checklist,
    double? stopLossPrice,
    double? takeProfitPrice,
    double? actualExitPrice,
    double? marginClosedPercent,
    ExitType? exitType,
    double? exitFeeRate,
    DateTime? exitDatetime,
    String? exitMentalStates,
    String? exitScreenshot,
    int? rating,
    String? memo,
    String? trackings,
    String? mistakes,
    double? transferAmount,
    String? transferScreenshot,
    TradeType? type,
    TradeStatus? status,
    double? exitPrice,
    double? quantity,
    double? stopLoss,
    double? takeProfit,
    double? pnl,
    double? pnlPercent,
    double? riskRewardRatio,
    DateTime? entryDate,
    DateTime? exitDate,
    String? notes,
    String? screenshotPath,
    double? accountBalance,
    double? riskAmount,
    double? achievedR,
    int? tradeDuration,
    // Calculated Trade Transfers Fields
    String? wl,
    String? entryDayOfWeek,
    String? entrySession,
    double? orderValue,
    double? qty,
    // Calculated Trade Management Fields
    double? positionToAccPercent,
    double? plannedSlPercent,
    double? accRiskedPercent,
    double? plannedReturn,
    // Calculated Trade Exit Fields
    String? exitDayOfWeek,
    String? psTag,
    // Calculated Trade Results Fields
    double? actualReturn,
    double? grossProfitLoss,
    double? positionFees,
    double? netProfitLoss,
    double? tradeGainPercent,
    double? accountChangePercent,
    double? newBalance,
    int? calculatedTradeDuration,
  }) {
    return Trade(
      id: id ?? this.id,
      tag: tag ?? this.tag,
      datetime: datetime ?? this.datetime,
      exchanges: exchanges ?? this.exchanges,
      entryType: entryType ?? this.entryType,
      symbol: symbol ?? this.symbol,
      strategies: strategies ?? this.strategies,
      side: side ?? this.side,
      entryPrice: entryPrice ?? this.entryPrice,
      positionMargin: positionMargin ?? this.positionMargin,
      leverage: leverage ?? this.leverage,
      orderType: orderType ?? this.orderType,
      timeFrame: timeFrame ?? this.timeFrame,
      entryFeeRate: entryFeeRate ?? this.entryFeeRate,
      entryMentalStates: entryMentalStates ?? this.entryMentalStates,
      entryScreenshot: entryScreenshot ?? this.entryScreenshot,
      checklist: checklist ?? this.checklist,
      stopLossPrice: stopLossPrice ?? this.stopLossPrice,
      takeProfitPrice: takeProfitPrice ?? this.takeProfitPrice,
      actualExitPrice: actualExitPrice ?? this.actualExitPrice,
      marginClosedPercent: marginClosedPercent ?? this.marginClosedPercent,
      exitType: exitType ?? this.exitType,
      exitFeeRate: exitFeeRate ?? this.exitFeeRate,
      exitDatetime: exitDatetime ?? this.exitDatetime,
      exitMentalStates: exitMentalStates ?? this.exitMentalStates,
      exitScreenshot: exitScreenshot ?? this.exitScreenshot,
      rating: rating ?? this.rating,
      memo: memo ?? this.memo,
      trackings: trackings ?? this.trackings,
      mistakes: mistakes ?? this.mistakes,
      transferAmount: transferAmount ?? this.transferAmount,
      transferScreenshot: transferScreenshot ?? this.transferScreenshot,
      type: type ?? this.type,
      status: status ?? this.status,
      exitPrice: exitPrice ?? this.exitPrice,
      quantity: quantity ?? this.quantity,
      stopLoss: stopLoss ?? this.stopLoss,
      takeProfit: takeProfit ?? this.takeProfit,
      pnl: pnl ?? this.pnl,
      pnlPercent: pnlPercent ?? this.pnlPercent,
      riskRewardRatio: riskRewardRatio ?? this.riskRewardRatio,
      entryDate: entryDate ?? this.entryDate,
      exitDate: exitDate ?? this.exitDate,
      notes: notes ?? this.notes,
      screenshotPath: screenshotPath ?? this.screenshotPath,
      accountBalance: accountBalance ?? this.accountBalance,
      riskAmount: riskAmount ?? this.riskAmount,
      achievedR: achievedR ?? this.achievedR,
      tradeDuration: tradeDuration ?? this.tradeDuration,
      // Calculated Trade Transfers Fields
      wl: wl ?? this.wl,
      entryDayOfWeek: entryDayOfWeek ?? this.entryDayOfWeek,
      entrySession: entrySession ?? this.entrySession,
      orderValue: orderValue ?? this.orderValue,
      qty: qty ?? this.qty,
      // Calculated Trade Management Fields
      positionToAccPercent: positionToAccPercent ?? this.positionToAccPercent,
      plannedSlPercent: plannedSlPercent ?? this.plannedSlPercent,
      accRiskedPercent: accRiskedPercent ?? this.accRiskedPercent,
      plannedReturn: plannedReturn ?? this.plannedReturn,
      // Calculated Trade Exit Fields
      exitDayOfWeek: exitDayOfWeek ?? this.exitDayOfWeek,
      psTag: psTag ?? this.psTag,
      // Calculated Trade Results Fields
      actualReturn: actualReturn ?? this.actualReturn,
      grossProfitLoss: grossProfitLoss ?? this.grossProfitLoss,
      positionFees: positionFees ?? this.positionFees,
      netProfitLoss: netProfitLoss ?? this.netProfitLoss,
      tradeGainPercent: tradeGainPercent ?? this.tradeGainPercent,
      accountChangePercent: accountChangePercent ?? this.accountChangePercent,
      newBalance: newBalance ?? this.newBalance,
      calculatedTradeDuration: calculatedTradeDuration ?? this.calculatedTradeDuration,
    );
  }

  @override
  List<Object?> get props => [
    id,
    tag,
    datetime,
    exchanges,
    entryType,
    symbol,
    strategies,
    side,
    entryPrice,
    positionMargin,
    leverage,
    orderType,
    timeFrame,
    entryFeeRate,
    entryMentalStates,
    entryScreenshot,
    checklist,
    stopLossPrice,
    takeProfitPrice,
    actualExitPrice,
    marginClosedPercent,
    exitType,
    exitFeeRate,
    exitDatetime,
    exitMentalStates,
    exitScreenshot,
    rating,
    memo,
    trackings,
    mistakes,
    transferAmount,
    transferScreenshot,
    type,
    status,
    exitPrice,
    quantity,
    stopLoss,
    takeProfit,
    pnl,
    pnlPercent,
    riskRewardRatio,
    entryDate,
    exitDate,
    notes,
    screenshotPath,
    accountBalance,
    riskAmount,
    achievedR,
    tradeDuration,
    // Calculated Trade Transfers Fields
    wl,
    entryDayOfWeek,
    entrySession,
    orderValue,
    qty,
    // Calculated Trade Management Fields
    positionToAccPercent,
    plannedSlPercent,
    accRiskedPercent,
    plannedReturn,
    // Calculated Trade Exit Fields
    exitDayOfWeek,
    psTag,
    // Calculated Trade Results Fields
    actualReturn,
    grossProfitLoss,
    positionFees,
    netProfitLoss,
    tradeGainPercent,
    accountChangePercent,
    newBalance,
    calculatedTradeDuration,
  ];
}
