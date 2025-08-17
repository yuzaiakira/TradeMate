import '../../domain/entities/trade.dart' as domain;
import '../../../../core/data/database.dart';
import 'package:drift/drift.dart';

class TradeModel {
  final int? id;
  final String symbol;
  final domain.TradeType type;
  final domain.TradeStatus status;
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
  final int? tradeDuration;

  const TradeModel({
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

  // Convert from database entity to domain entity
  factory TradeModel.fromDatabase(Trade trade) {
    return TradeModel(
      id: trade.id,
      symbol: trade.symbol,
      type: _stringToTradeType(trade.type),
      status: _stringToTradeStatus(trade.status),
      entryPrice: trade.entryPrice,
      exitPrice: trade.exitPrice,
      quantity: trade.quantity,
      stopLoss: trade.stopLoss,
      takeProfit: trade.takeProfit,
      pnl: trade.pnl,
      pnlPercent: trade.pnlPercent,
      riskRewardRatio: trade.riskRewardRatio,
      entryDate: trade.entryDate,
      exitDate: trade.exitDate,
      notes: trade.notes,
      screenshotPath: trade.screenshotPath,
      accountBalance: trade.accountBalance,
      riskAmount: trade.riskAmount,
      achievedR: trade.achievedR,
      tradeDuration: trade.tradeDuration,
    );
  }

  // Convert to domain entity
  domain.Trade toDomain() {
    return domain.Trade(
      id: id,
      symbol: symbol,
      type: type,
      status: status,
      entryPrice: entryPrice,
      exitPrice: exitPrice,
      quantity: quantity,
      stopLoss: stopLoss,
      takeProfit: takeProfit,
      pnl: pnl,
      pnlPercent: pnlPercent,
      riskRewardRatio: riskRewardRatio,
      entryDate: entryDate,
      exitDate: exitDate,
      notes: notes,
      screenshotPath: screenshotPath,
      accountBalance: accountBalance,
      riskAmount: riskAmount,
      achievedR: achievedR,
      tradeDuration: tradeDuration,
    );
  }

  // Convert from domain entity to database companion
  TradesCompanion toDatabaseCompanion() {
    return TradesCompanion(
      id: id != null ? Value(id!) : const Value.absent(),
      symbol: Value(symbol),
      type: Value(_tradeTypeToString(type)),
      status: Value(_tradeStatusToString(status)),
      entryPrice: Value(entryPrice),
      exitPrice: exitPrice != null ? Value(exitPrice!) : const Value.absent(),
      quantity: Value(quantity),
      stopLoss: stopLoss != null ? Value(stopLoss!) : const Value.absent(),
      takeProfit: takeProfit != null ? Value(takeProfit!) : const Value.absent(),
      pnl: pnl != null ? Value(pnl!) : const Value.absent(),
      pnlPercent: pnlPercent != null ? Value(pnlPercent!) : const Value.absent(),
      riskRewardRatio: riskRewardRatio != null ? Value(riskRewardRatio!) : const Value.absent(),
      entryDate: Value(entryDate),
      exitDate: exitDate != null ? Value(exitDate!) : const Value.absent(),
      notes: notes != null ? Value(notes!) : const Value.absent(),
      screenshotPath: screenshotPath != null ? Value(screenshotPath!) : const Value.absent(),
      accountBalance: Value(accountBalance),
      riskAmount: riskAmount != null ? Value(riskAmount!) : const Value.absent(),
      achievedR: achievedR != null ? Value(achievedR!) : const Value.absent(),
      tradeDuration: tradeDuration != null ? Value(tradeDuration!) : const Value.absent(),
    );
  }

  // Helper methods for type conversion
  static domain.TradeType _stringToTradeType(String type) {
    switch (type.toUpperCase()) {
      case 'BUY':
        return domain.TradeType.buy;
      case 'SELL':
        return domain.TradeType.sell;
      default:
        throw ArgumentError('Invalid trade type: $type');
    }
  }

  static String _tradeTypeToString(domain.TradeType type) {
    switch (type) {
      case domain.TradeType.buy:
        return 'BUY';
      case domain.TradeType.sell:
        return 'SELL';
    }
  }

  static domain.TradeStatus _stringToTradeStatus(String status) {
    switch (status.toUpperCase()) {
      case 'OPEN':
        return domain.TradeStatus.open;
      case 'CLOSED':
        return domain.TradeStatus.closed;
      default:
        throw ArgumentError('Invalid trade status: $status');
    }
  }

  static String _tradeStatusToString(domain.TradeStatus status) {
    switch (status) {
      case domain.TradeStatus.open:
        return 'OPEN';
      case domain.TradeStatus.closed:
        return 'CLOSED';
    }
  }
}
