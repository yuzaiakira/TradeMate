class TradeStatistics {
  final int totalTrades;
  final int winningTrades;
  final int losingTrades;
  final int breakevenTrades;
  final double totalPnL;
  final double winRate;
  final double averageR;
  final double totalRiskAmount;

  const TradeStatistics({
    this.totalTrades = 0,
    this.winningTrades = 0,
    this.losingTrades = 0,
    this.breakevenTrades = 0,
    this.totalPnL = 0.0,
    this.winRate = 0.0,
    this.averageR = 0.0,
    this.totalRiskAmount = 0.0,
  });

  double get averagePnL => totalTrades > 0 ? totalPnL / totalTrades : 0.0;

  double get profitFactor {
    if (totalRiskAmount == 0) return 0.0;
    return totalPnL / totalRiskAmount;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TradeStatistics &&
        other.totalTrades == totalTrades &&
        other.winningTrades == winningTrades &&
        other.losingTrades == losingTrades &&
        other.breakevenTrades == breakevenTrades &&
        other.totalPnL == totalPnL &&
        other.winRate == winRate &&
        other.averageR == averageR &&
        other.totalRiskAmount == totalRiskAmount;
  }

  @override
  int get hashCode {
    return totalTrades.hashCode ^
        winningTrades.hashCode ^
        losingTrades.hashCode ^
        breakevenTrades.hashCode ^
        totalPnL.hashCode ^
        winRate.hashCode ^
        averageR.hashCode ^
        totalRiskAmount.hashCode;
  }

  @override
  String toString() {
    return 'TradeStatistics(totalTrades: $totalTrades, winningTrades: $winningTrades, losingTrades: $losingTrades, breakevenTrades: $breakevenTrades, totalPnL: $totalPnL, winRate: $winRate, averageR: $averageR, totalRiskAmount: $totalRiskAmount)';
  }
}
