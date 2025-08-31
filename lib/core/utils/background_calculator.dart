import 'dart:isolate';
import 'dart:async';
import 'package:flutter/foundation.dart';

class BackgroundStatisticsCalculator {
  static Future<Map<String, dynamic>> calculateInBackground(
    Map<String, dynamic> filters,
    Future<Map<String, dynamic>> Function(Map<String, dynamic>) calculationFunction,
  ) async {
    try {
      // For web, use compute function
      if (kIsWeb) {
        return await compute(_calculateStats, {
          'filters': filters,
          'calculationFunction': calculationFunction,
        });
      }
      
      // For mobile, use isolate
      return await _calculateInIsolate(filters, calculationFunction);
    } catch (e) {
      // Fallback to main thread if background calculation fails
      return await calculationFunction(filters);
    }
  }
  
  static Future<Map<String, dynamic>> _calculateInIsolate(
    Map<String, dynamic> filters,
    Future<Map<String, dynamic>> Function(Map<String, dynamic>) calculationFunction,
  ) async {
    final receivePort = ReceivePort();
    
    await Isolate.spawn(_isolateEntryPoint, {
      'sendPort': receivePort.sendPort,
      'filters': filters,
    });
    
    final result = await receivePort.first as Map<String, dynamic>;
    receivePort.close();
    
    return result;
  }
  
  static void _isolateEntryPoint(Map<String, dynamic> message) {
    final sendPort = message['sendPort'] as SendPort;
    // final filters = message['filters'] as Map<String, dynamic>; // TODO: Use filters when implementing actual calculation
    
    // Note: In a real implementation, you would need to pass the database connection
    // or recreate it in the isolate. For now, we'll return a placeholder.
    sendPort.send({
      'totalTrades': 0,
      'winningTrades': 0,
      'losingTrades': 0,
      'breakevenTrades': 0,
      'totalPnL': 0.0,
      'averagePnL': 0.0,
      'winRate': 0.0,
      'averageR': 0.0,
      'totalRiskAmount': 0.0,
      'totalRating': 0,
      'averageRating': 0.0,
      'uniqueSymbols': 0,
      'uniqueExchanges': 0,
    });
  }
  
  static Map<String, dynamic> _calculateStats(Map<String, dynamic> params) {
    // This is a placeholder for the compute function
    // In a real implementation, you would perform the actual calculation here
    return {
      'totalTrades': 0,
      'winningTrades': 0,
      'losingTrades': 0,
      'breakevenTrades': 0,
      'totalPnL': 0.0,
      'averagePnL': 0.0,
      'winRate': 0.0,
      'averageR': 0.0,
      'totalRiskAmount': 0.0,
      'totalRating': 0,
      'averageRating': 0.0,
      'uniqueSymbols': 0,
      'uniqueExchanges': 0,
    };
  }
}

class IncrementalStatistics {
  Map<String, dynamic> _baseStats = {};
  final List<Map<String, dynamic>> _addedTrades = [];
  final List<Map<String, dynamic>> _removedTrades = [];
  bool _isDirty = false;
  
  void setBaseStats(Map<String, dynamic> stats) {
    _baseStats = Map.from(stats);
    _isDirty = false;
  }
  
  void addTrade(Map<String, dynamic> trade) {
    _addedTrades.add(trade);
    _isDirty = true;
  }
  
  void removeTrade(Map<String, dynamic> trade) {
    _removedTrades.add(trade);
    _isDirty = true;
  }
  
  Map<String, dynamic> getCurrentStats() {
    if (!_isDirty) {
      return _baseStats;
    }
    
    return _calculateIncrementalStats();
  }
  
  Map<String, dynamic> _calculateIncrementalStats() {
    final stats = Map<String, dynamic>.from(_baseStats);
    
    // Apply added trades
    for (final trade in _addedTrades) {
      _applyTradeToStats(stats, trade, isAddition: true);
    }
    
    // Apply removed trades
    for (final trade in _removedTrades) {
      _applyTradeToStats(stats, trade, isAddition: false);
    }
    
    return stats;
  }
  
  void _applyTradeToStats(Map<String, dynamic> stats, Map<String, dynamic> trade, {required bool isAddition}) {
    final multiplier = isAddition ? 1 : -1;
    final netPnL = trade['netProfitLoss'] ?? 0.0;
    // final achievedR = trade['achievedR'] ?? 0.0; // TODO: Use achievedR when implementing R-multiple calculations
    final riskAmount = trade['riskAmount'] ?? 0.0;
    final rating = trade['rating'] ?? 0;
    
    // Update counts
    stats['totalTrades'] = (stats['totalTrades'] ?? 0) + multiplier;
    
    // Update P&L related stats
    if (netPnL > 0) {
      stats['winningTrades'] = (stats['winningTrades'] ?? 0) + multiplier;
    } else if (netPnL < 0) {
      stats['losingTrades'] = (stats['losingTrades'] ?? 0) + multiplier;
    } else {
      stats['breakevenTrades'] = (stats['breakevenTrades'] ?? 0) + multiplier;
    }
    
    // Update sums
    stats['totalPnL'] = (stats['totalPnL'] ?? 0.0) + (netPnL * multiplier);
    stats['totalRiskAmount'] = (stats['totalRiskAmount'] ?? 0.0) + (riskAmount * multiplier);
    stats['totalRating'] = (stats['totalRating'] ?? 0) + (rating * multiplier);
    
    // Recalculate averages
    final totalTrades = stats['totalTrades'] ?? 0;
    if (totalTrades > 0) {
      stats['averagePnL'] = (stats['totalPnL'] ?? 0.0) / totalTrades;
      stats['winRate'] = ((stats['winningTrades'] ?? 0) / totalTrades) * 100;
    }
    
    // Note: averageR and averageRating would need more complex recalculation
    // For simplicity, we'll mark them as needing recalculation
    stats['averageR'] = null; // Mark for recalculation
    stats['averageRating'] = null; // Mark for recalculation
  }
  
  void clearChanges() {
    _addedTrades.clear();
    _removedTrades.clear();
    _isDirty = false;
  }
  
  bool get hasChanges => _isDirty;
  
  int get addedTradesCount => _addedTrades.length;
  int get removedTradesCount => _removedTrades.length;
}
