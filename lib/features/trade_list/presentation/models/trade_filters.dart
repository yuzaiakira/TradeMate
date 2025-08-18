import 'package:flutter/material.dart';
import '../../../add_trade/domain/entities/trade.dart';

class TradeFilters {
  final String symbol;
  final TradeStatus? status;
  final DateTimeRange? dateRange;
  final List<String> exchanges;
  final Side? side;
  final double? minPnL;
  final double? maxPnL;
  final int? minRating;

  const TradeFilters({
    this.symbol = '',
    this.status,
    this.dateRange,
    this.exchanges = const [],
    this.side,
    this.minPnL,
    this.maxPnL,
    this.minRating,
  });

  bool get hasActiveFilters {
    return symbol.isNotEmpty ||
           status != null ||
           dateRange != null ||
           exchanges.isNotEmpty ||
           side != null ||
           minPnL != null ||
           maxPnL != null ||
           minRating != null;
  }

  TradeFilters copyWith({
    String? symbol,
    TradeStatus? status,
    DateTimeRange? dateRange,
    List<String>? exchanges,
    Side? side,
    double? minPnL,
    double? maxPnL,
    int? minRating,
  }) {
    return TradeFilters(
      symbol: symbol ?? this.symbol,
      status: status ?? this.status,
      dateRange: dateRange ?? this.dateRange,
      exchanges: exchanges ?? this.exchanges,
      side: side ?? this.side,
      minPnL: minPnL ?? this.minPnL,
      maxPnL: maxPnL ?? this.maxPnL,
      minRating: minRating ?? this.minRating,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TradeFilters &&
        other.symbol == symbol &&
        other.status == status &&
        other.dateRange == dateRange &&
        other.exchanges.length == exchanges.length &&
        other.exchanges.every((e) => exchanges.contains(e)) &&
        other.side == side &&
        other.minPnL == minPnL &&
        other.maxPnL == maxPnL &&
        other.minRating == minRating;
  }

  @override
  int get hashCode {
    return symbol.hashCode ^
        status.hashCode ^
        dateRange.hashCode ^
        exchanges.hashCode ^
        side.hashCode ^
        minPnL.hashCode ^
        maxPnL.hashCode ^
        minRating.hashCode;
  }

  @override
  String toString() {
    return 'TradeFilters(symbol: $symbol, status: $status, dateRange: $dateRange, exchanges: $exchanges, side: $side, minPnL: $minPnL, maxPnL: $maxPnL, minRating: $minRating)';
  }
}
