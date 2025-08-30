import 'package:equatable/equatable.dart';

class TradeStatistics extends Equatable {
  final int totalTrades;
  final int winningTrades;
  final int losingTrades;
  final int breakevenTrades;
  final int openPositions;
  final double avgAchievedR;
  final double avgTradeDuration; // in minutes
  final double overallPnl;
  final double avgPnl;
  final double totalAccountGrowth;
  final double totalDeposits;
  final double totalWithdrawals;
  final double currentAccountBalance;
  final DateTime lastUpdated;

  const TradeStatistics({
    required this.totalTrades,
    required this.winningTrades,
    required this.losingTrades,
    required this.breakevenTrades,
    required this.openPositions,
    required this.avgAchievedR,
    required this.avgTradeDuration,
    required this.overallPnl,
    required this.avgPnl,
    required this.totalAccountGrowth,
    required this.totalDeposits,
    required this.totalWithdrawals,
    required this.currentAccountBalance,
    required this.lastUpdated,
  });

  // Calculate win rate percentage
  double get winRate {
    if (totalTrades == 0) return 0.0;
    return (winningTrades / totalTrades) * 100;
  }

  // Calculate loss rate percentage
  double get lossRate {
    if (totalTrades == 0) return 0.0;
    return (losingTrades / totalTrades) * 100;
  }

  // Calculate breakeven rate percentage
  double get breakevenRate {
    if (totalTrades == 0) return 0.0;
    return (breakevenTrades / totalTrades) * 100;
  }

  // Calculate profit factor
  double get profitFactor {
    if (losingTrades == 0) return 0.0;
    final totalWins = winningTrades * avgPnl;
    final totalLosses = losingTrades * avgPnl.abs();
    if (totalLosses == 0) return 0.0;
    return totalWins / totalLosses;
  }

  // Calculate average trade duration in hours
  double get avgTradeDurationHours => avgTradeDuration / 60;

  // Calculate average trade duration in days
  double get avgTradeDurationDays => avgTradeDuration / (60 * 24);

  // Format currency
  String get formattedOverallPnl => _formatCurrency(overallPnl);
  String get formattedAvgPnl => _formatCurrency(avgPnl);
  String get formattedTotalAccountGrowth => _formatCurrency(totalAccountGrowth);
  String get formattedTotalDeposits => _formatCurrency(totalDeposits);
  String get formattedTotalWithdrawals => _formatCurrency(totalWithdrawals);
  String get formattedCurrentAccountBalance => _formatCurrency(currentAccountBalance);

  // Format percentages
  String get formattedWinRate => '${winRate.toStringAsFixed(1)}%';
  String get formattedLossRate => '${lossRate.toStringAsFixed(1)}%';
  String get formattedBreakevenRate => '${breakevenRate.toStringAsFixed(1)}%';

  // Format numbers
  String get formattedAvgAchievedR => avgAchievedR.toStringAsFixed(2);
  String get formattedAvgTradeDuration => _formatDuration(avgTradeDuration);
  String get formattedProfitFactor => profitFactor.toStringAsFixed(2);

  String _formatCurrency(double amount) {
    final isNegative = amount < 0;
    final absAmount = amount.abs();
    final prefix = isNegative ? '-\$' : '\$';
    return '$prefix${absAmount.toStringAsFixed(2)}';
  }

  String _formatDuration(double durationInMinutes) {
    if (durationInMinutes <= 0) return '0 min';
    
    final days = durationInMinutes ~/ (24 * 60);
    final remainingMinutes = durationInMinutes % (24 * 60);
    final hours = remainingMinutes ~/ 60;
    final minutes = remainingMinutes % 60;
    
    final parts = <String>[];
    
    if (days > 0) {
      parts.add('${days.toStringAsFixed(0)} ${days == 1 ? 'day' : 'days'}');
    }
    if (hours > 0) {
      parts.add('${hours.toStringAsFixed(0)} ${hours == 1 ? 'hour' : 'hours'}');
    }
    if (minutes > 0 || parts.isEmpty) {
      parts.add('${minutes.toStringAsFixed(0)} min');
    }
    
    return parts.join(' ');
  }

  // Copy with method
  TradeStatistics copyWith({
    int? totalTrades,
    int? winningTrades,
    int? losingTrades,
    int? breakevenTrades,
    int? openPositions,
    double? avgAchievedR,
    double? avgTradeDuration,
    double? overallPnl,
    double? avgPnl,
    double? totalAccountGrowth,
    double? totalDeposits,
    double? totalWithdrawals,
    double? currentAccountBalance,
    DateTime? lastUpdated,
  }) {
    return TradeStatistics(
      totalTrades: totalTrades ?? this.totalTrades,
      winningTrades: winningTrades ?? this.winningTrades,
      losingTrades: losingTrades ?? this.losingTrades,
      breakevenTrades: breakevenTrades ?? this.breakevenTrades,
      openPositions: openPositions ?? this.openPositions,
      avgAchievedR: avgAchievedR ?? this.avgAchievedR,
      avgTradeDuration: avgTradeDuration ?? this.avgTradeDuration,
      overallPnl: overallPnl ?? this.overallPnl,
      avgPnl: avgPnl ?? this.avgPnl,
      totalAccountGrowth: totalAccountGrowth ?? this.totalAccountGrowth,
      totalDeposits: totalDeposits ?? this.totalDeposits,
      totalWithdrawals: totalWithdrawals ?? this.totalWithdrawals,
      currentAccountBalance: currentAccountBalance ?? this.currentAccountBalance,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  @override
  List<Object?> get props => [
    totalTrades,
    winningTrades,
    losingTrades,
    breakevenTrades,
    openPositions,
    avgAchievedR,
    avgTradeDuration,
    overallPnl,
    avgPnl,
    totalAccountGrowth,
    totalDeposits,
    totalWithdrawals,
    currentAccountBalance,
    lastUpdated,
  ];
}
