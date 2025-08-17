import 'package:equatable/equatable.dart';

enum TradeType { buy, sell }
enum TradeStatus { open, closed }

class Trade extends Equatable {
  final int? id;
  final String symbol;
  final TradeType type;
  final TradeStatus status;
  final double entryPrice;
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

  const Trade({
    this.id,
    required this.symbol,
    required this.type,
    required this.status,
    required this.entryPrice,
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
  });

  // Calculate PnL
  double? calculatePnL() {
    if (exitPrice == null || status != TradeStatus.closed) return null;
    
    final priceDifference = exitPrice! - entryPrice;
    final multiplier = type == TradeType.buy ? 1 : -1;
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
    
    final risk = (entryPrice - stopLoss!).abs();
    final reward = (takeProfit! - entryPrice).abs();
    
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
    String? symbol,
    TradeType? type,
    TradeStatus? status,
    double? entryPrice,
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
  }) {
    return Trade(
      id: id ?? this.id,
      symbol: symbol ?? this.symbol,
      type: type ?? this.type,
      status: status ?? this.status,
      entryPrice: entryPrice ?? this.entryPrice,
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
    );
  }

  @override
  List<Object?> get props => [
    id,
    symbol,
    type,
    status,
    entryPrice,
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
  ];
}
