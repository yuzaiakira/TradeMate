import '../../domain/entities/trade.dart' as domain;
import '../../../../core/data/database.dart';
import 'package:drift/drift.dart';
import 'dart:convert';

class TradeModel {
  final int? id;
  
  // Trade Transfers
  final String? tag;
  final DateTime datetime;
  final String? exchanges;
  final domain.EntryType? entryType;
  final String symbol;
  final String? strategies;
  final domain.Side? side;
  final double entryPrice;
  final double? positionMargin;
  final double? leverage;
  final domain.OrderType? orderType;
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
  final domain.ExitType? exitType;
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
  
  // Legacy fields
  final domain.TradeType type;
  final domain.TradeStatus status;
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

  const TradeModel({
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

  // Convert from database entity to domain entity
  factory TradeModel.fromDatabase(Trade trade) {
    return TradeModel(
      id: trade.id,
      // Trade Transfers
      tag: trade.tag,
      datetime: trade.datetime,
      exchanges: trade.exchanges,
      entryType: _stringToEntryType(trade.entryType),
      symbol: trade.symbol,
      strategies: trade.strategies,
      side: _stringToSide(trade.side),
      entryPrice: trade.entryPrice,
      positionMargin: trade.positionMargin,
      leverage: trade.leverage,
      orderType: _stringToOrderType(trade.orderType),
      timeFrame: trade.timeFrame,
      entryFeeRate: trade.entryFeeRate,
      entryMentalStates: trade.entryMentalStates,
      entryScreenshot: trade.entryScreenshot,
      // Checklist
      checklist: _stringToList(trade.checklist),
      // Trade Management
      stopLossPrice: trade.stopLossPrice,
      takeProfitPrice: trade.takeProfitPrice,
      // Trade Exit
      actualExitPrice: trade.actualExitPrice,
      marginClosedPercent: trade.marginClosedPercent,
      exitType: _stringToExitType(trade.exitType),
      exitFeeRate: trade.exitFeeRate,
      exitDatetime: trade.exitDatetime,
      exitMentalStates: trade.exitMentalStates,
      exitScreenshot: trade.exitScreenshot,
      // Memo
      rating: trade.rating,
      memo: trade.memo,
      // Trackings
      trackings: trade.trackings,
      mistakes: trade.mistakes,
      // Transfers
      transferAmount: trade.transferAmount,
      transferScreenshot: trade.transferScreenshot,
      // Legacy fields
      type: _stringToTradeType(trade.type),
      status: _stringToTradeStatus(trade.status),
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
      // Calculated Trade Transfers Fields
      wl: trade.wl,
      entryDayOfWeek: trade.entryDayOfWeek,
      entrySession: trade.entrySession,
      orderValue: trade.orderValue,
      qty: trade.qty,
      // Calculated Trade Management Fields
      positionToAccPercent: trade.positionToAccPercent,
      plannedSlPercent: trade.plannedSlPercent,
      accRiskedPercent: trade.accRiskedPercent,
      plannedReturn: trade.plannedReturn,
      // Calculated Trade Exit Fields
      exitDayOfWeek: trade.exitDayOfWeek,
      psTag: trade.psTag,
      // Calculated Trade Results Fields
      actualReturn: trade.actualReturn,
      grossProfitLoss: trade.grossProfitLoss,
      positionFees: trade.positionFees,
      netProfitLoss: trade.netProfitLoss,
      tradeGainPercent: trade.tradeGainPercent,
      accountChangePercent: trade.accountChangePercent,
      newBalance: trade.newBalance,
      calculatedTradeDuration: trade.calculatedTradeDuration,
    );
  }

  // Convert to domain entity
  domain.Trade toDomain() {
    return domain.Trade(
      id: id,
      // Trade Transfers
      tag: tag,
      datetime: datetime,
      exchanges: exchanges,
      entryType: entryType,
      symbol: symbol,
      strategies: strategies,
      side: side,
      entryPrice: entryPrice,
      positionMargin: positionMargin,
      leverage: leverage,
      orderType: orderType,
      timeFrame: timeFrame,
      entryFeeRate: entryFeeRate,
      entryMentalStates: entryMentalStates,
      entryScreenshot: entryScreenshot,
      // Checklist
      checklist: checklist,
      // Trade Management
      stopLossPrice: stopLossPrice,
      takeProfitPrice: takeProfitPrice,
      // Trade Exit
      actualExitPrice: actualExitPrice,
      marginClosedPercent: marginClosedPercent,
      exitType: exitType,
      exitFeeRate: exitFeeRate,
      exitDatetime: exitDatetime,
      exitMentalStates: exitMentalStates,
      exitScreenshot: exitScreenshot,
      // Memo
      rating: rating,
      memo: memo,
      // Trackings
      trackings: trackings,
      mistakes: mistakes,
      // Transfers
      transferAmount: transferAmount,
      transferScreenshot: transferScreenshot,
      // Legacy fields
      type: type,
      status: status,
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
      // Calculated Trade Transfers Fields
      wl: wl,
      entryDayOfWeek: entryDayOfWeek,
      entrySession: entrySession,
      orderValue: orderValue,
      qty: qty,
      // Calculated Trade Management Fields
      positionToAccPercent: positionToAccPercent,
      plannedSlPercent: plannedSlPercent,
      accRiskedPercent: accRiskedPercent,
      plannedReturn: plannedReturn,
      // Calculated Trade Exit Fields
      exitDayOfWeek: exitDayOfWeek,
      psTag: psTag,
      // Calculated Trade Results Fields
      actualReturn: actualReturn,
      grossProfitLoss: grossProfitLoss,
      positionFees: positionFees,
      netProfitLoss: netProfitLoss,
      tradeGainPercent: tradeGainPercent,
      accountChangePercent: accountChangePercent,
      newBalance: newBalance,
      calculatedTradeDuration: calculatedTradeDuration,
    );
  }

  // Convert from domain entity to database companion
  TradesCompanion toDatabaseCompanion() {
    return TradesCompanion(
      id: id != null ? Value(id!) : const Value.absent(),
      // Trade Transfers
      tag: tag != null ? Value(tag!) : const Value.absent(),
      datetime: Value(datetime),
      exchanges: exchanges != null ? Value(exchanges!) : const Value.absent(),
      entryType: entryType != null ? Value(_entryTypeToString(entryType!)) : const Value.absent(),
      symbol: Value(symbol),
      strategies: strategies != null ? Value(strategies!) : const Value.absent(),
      side: side != null ? Value(_sideToString(side!)) : const Value.absent(),
      entryPrice: Value(entryPrice),
      positionMargin: positionMargin != null ? Value(positionMargin!) : const Value.absent(),
      leverage: leverage != null ? Value(leverage!) : const Value.absent(),
      orderType: orderType != null ? Value(_orderTypeToString(orderType!)) : const Value.absent(),
      timeFrame: timeFrame != null ? Value(timeFrame!) : const Value.absent(),
      entryFeeRate: entryFeeRate != null ? Value(entryFeeRate!) : const Value.absent(),
      entryMentalStates: entryMentalStates != null ? Value(entryMentalStates!) : const Value.absent(),
      entryScreenshot: entryScreenshot != null ? Value(entryScreenshot!) : const Value.absent(),
      // Checklist
      checklist: checklist != null ? Value(_listToString(checklist!)) : const Value.absent(),
      // Trade Management
      stopLossPrice: stopLossPrice != null ? Value(stopLossPrice!) : const Value.absent(),
      takeProfitPrice: takeProfitPrice != null ? Value(takeProfitPrice!) : const Value.absent(),
      // Trade Exit
      actualExitPrice: actualExitPrice != null ? Value(actualExitPrice!) : const Value.absent(),
      marginClosedPercent: marginClosedPercent != null ? Value(marginClosedPercent!) : const Value.absent(),
      exitType: exitType != null ? Value(_exitTypeToString(exitType!)) : const Value.absent(),
      exitFeeRate: exitFeeRate != null ? Value(exitFeeRate!) : const Value.absent(),
      exitDatetime: exitDatetime != null ? Value(exitDatetime!) : const Value.absent(),
      exitMentalStates: exitMentalStates != null ? Value(exitMentalStates!) : const Value.absent(),
      exitScreenshot: exitScreenshot != null ? Value(exitScreenshot!) : const Value.absent(),
      // Memo
      rating: rating != null ? Value(rating!) : const Value.absent(),
      memo: memo != null ? Value(memo!) : const Value.absent(),
      // Trackings
      trackings: trackings != null ? Value(trackings!) : const Value.absent(),
      mistakes: mistakes != null ? Value(mistakes!) : const Value.absent(),
      // Transfers
      transferAmount: transferAmount != null ? Value(transferAmount!) : const Value.absent(),
      transferScreenshot: transferScreenshot != null ? Value(transferScreenshot!) : const Value.absent(),
      // Legacy fields
      type: Value(_tradeTypeToString(type)),
      status: Value(_tradeStatusToString(status)),
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
      // Calculated Trade Transfers Fields
      wl: wl != null ? Value(wl!) : const Value.absent(),
      entryDayOfWeek: entryDayOfWeek != null ? Value(entryDayOfWeek!) : const Value.absent(),
      entrySession: entrySession != null ? Value(entrySession!) : const Value.absent(),
      orderValue: orderValue != null ? Value(orderValue!) : const Value.absent(),
      qty: qty != null ? Value(qty!) : const Value.absent(),
      // Calculated Trade Management Fields
      positionToAccPercent: positionToAccPercent != null ? Value(positionToAccPercent!) : const Value.absent(),
      plannedSlPercent: plannedSlPercent != null ? Value(plannedSlPercent!) : const Value.absent(),
      accRiskedPercent: accRiskedPercent != null ? Value(accRiskedPercent!) : const Value.absent(),
      plannedReturn: plannedReturn != null ? Value(plannedReturn!) : const Value.absent(),
      // Calculated Trade Exit Fields
      exitDayOfWeek: exitDayOfWeek != null ? Value(exitDayOfWeek!) : const Value.absent(),
      psTag: psTag != null ? Value(psTag!) : const Value.absent(),
      // Calculated Trade Results Fields
      actualReturn: actualReturn != null ? Value(actualReturn!) : const Value.absent(),
      grossProfitLoss: grossProfitLoss != null ? Value(grossProfitLoss!) : const Value.absent(),
      positionFees: positionFees != null ? Value(positionFees!) : const Value.absent(),
      netProfitLoss: netProfitLoss != null ? Value(netProfitLoss!) : const Value.absent(),
      tradeGainPercent: tradeGainPercent != null ? Value(tradeGainPercent!) : const Value.absent(),
      accountChangePercent: accountChangePercent != null ? Value(accountChangePercent!) : const Value.absent(),
      newBalance: newBalance != null ? Value(newBalance!) : const Value.absent(),
      calculatedTradeDuration: calculatedTradeDuration != null ? Value(calculatedTradeDuration!) : const Value.absent(),
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

  // New helper methods for new enums
  static domain.EntryType? _stringToEntryType(String? type) {
    if (type == null) return null;
    switch (type.toLowerCase()) {
      case 'trade':
        return domain.EntryType.trade;
      case 'margin in/out':
      case 'margin in':
      case 'margin out':
        return domain.EntryType.marginInOut;
      case 'deposit':
        return domain.EntryType.deposit;
      case 'withdrawal':
        return domain.EntryType.withdrawal;
      case 'ignore':
        return domain.EntryType.ignore;
      default:
        return null;
    }
  }

  static String _entryTypeToString(domain.EntryType type) {
    switch (type) {
      case domain.EntryType.trade:
        return 'Trade';
      case domain.EntryType.marginInOut:
        return 'Margin In/Out';
      case domain.EntryType.deposit:
        return 'Deposit';
      case domain.EntryType.withdrawal:
        return 'Withdrawal';
      case domain.EntryType.ignore:
        return 'Ignore';
    }
  }

  static domain.Side? _stringToSide(String? side) {
    if (side == null) return null;
    switch (side.toUpperCase()) {
      case 'LONG':
        return domain.Side.long;
      case 'SHORT':
        return domain.Side.short;
      default:
        return null;
    }
  }

  static String _sideToString(domain.Side side) {
    switch (side) {
      case domain.Side.long:
        return 'LONG';
      case domain.Side.short:
        return 'SHORT';
    }
  }

  static domain.OrderType? _stringToOrderType(String? type) {
    if (type == null) return null;
    switch (type.toLowerCase()) {
      case 'market':
        return domain.OrderType.market;
      case 'limit':
        return domain.OrderType.limit;
      case 'stop':
        return domain.OrderType.stop;
      default:
        return null;
    }
  }

  static String _orderTypeToString(domain.OrderType type) {
    switch (type) {
      case domain.OrderType.market:
        return 'Market';
      case domain.OrderType.limit:
        return 'Limit';
      case domain.OrderType.stop:
        return 'Stop';
    }
  }

  static domain.ExitType? _stringToExitType(String? type) {
    if (type == null) return null;
    switch (type.toUpperCase()) {
      case 'TP':
        return domain.ExitType.tp;
      case 'SL':
        return domain.ExitType.sl;
      default:
        return null;
    }
  }

  static String _exitTypeToString(domain.ExitType type) {
    switch (type) {
      case domain.ExitType.tp:
        return 'TP';
      case domain.ExitType.sl:
        return 'SL';
    }
  }

  // Helper methods for JSON conversion
  static List<String>? _stringToList(String? jsonString) {
    if (jsonString == null) return null;
    try {
      final List<dynamic> list = jsonDecode(jsonString);
      return list.cast<String>();
    } catch (e) {
      return null;
    }
  }

  static String _listToString(List<String> list) {
    return jsonEncode(list);
  }
}
