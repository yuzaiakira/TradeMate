import 'package:flutter/foundation.dart';
import '../../../add_trade/domain/entities/trade.dart';
import '../../../add_trade/domain/usecases/get_trades_usecase.dart';
import '../../../add_trade/domain/usecases/delete_trade_usecase.dart';
import '../models/trade_filters.dart';
import '../models/trade_statistics.dart';

enum TradeListStatus { initial, loading, success, error }

class TradeListProvider with ChangeNotifier {
  final GetTradesUseCase getTradesUseCase;
  final DeleteTradeUseCase deleteTradeUseCase;

  TradeListProvider({
    required this.getTradesUseCase,
    required this.deleteTradeUseCase,
  });

  TradeListStatus _status = TradeListStatus.initial;
  String _errorMessage = '';
  List<Trade> _allTrades = [];
  List<Trade> _filteredTrades = [];
  TradeFilters _filters = TradeFilters();
  String _searchQuery = '';
  TradeSortOption _sortOption = TradeSortOption.dateDesc;
  TradeStatistics _statistics = TradeStatistics();

  // Getters
  TradeListStatus get status => _status;
  String get errorMessage => _errorMessage;
  List<Trade> get trades => _filteredTrades;
  List<Trade> get allTrades => _allTrades;
  TradeFilters get filters => _filters;
  String get searchQuery => _searchQuery;
  TradeSortOption get sortOption => _sortOption;
  TradeStatistics get statistics => _statistics;
  bool get isLoading => _status == TradeListStatus.loading;
  bool get hasActiveFilters => _filters.hasActiveFilters || _searchQuery.isNotEmpty;

  Future<void> loadTrades() async {
    try {
      _status = TradeListStatus.loading;
      notifyListeners();

      _allTrades = await getTradesUseCase();
      _applyFiltersAndSort();
      _calculateStatistics();
      
      _status = TradeListStatus.success;
      _errorMessage = '';
    } catch (e) {
      _status = TradeListStatus.error;
      _errorMessage = e.toString();
    }
    notifyListeners();
  }

  Future<void> deleteTrade(int tradeId) async {
    try {
      await deleteTradeUseCase(tradeId);
      await loadTrades(); // Reload trades after deletion
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> deleteAllTrades() async {
    try {
      for (final trade in _allTrades) {
        if (trade.id != null) {
          await deleteTradeUseCase(trade.id!);
        }
      }
      await loadTrades();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    _applyFiltersAndSort();
    notifyListeners();
  }

  void clearSearch() {
    _searchQuery = '';
    _applyFiltersAndSort();
    notifyListeners();
  }

  void setFilters(TradeFilters filters) {
    _filters = filters;
    _applyFiltersAndSort();
    notifyListeners();
  }

  void clearAllFilters() {
    _filters = TradeFilters();
    _searchQuery = '';
    _applyFiltersAndSort();
    notifyListeners();
  }

  void setSortOption(TradeSortOption sortOption) {
    _sortOption = sortOption;
    _applyFiltersAndSort();
    notifyListeners();
  }

  // Filter clearing methods
  void clearSymbolFilter() {
    _filters = _filters.copyWith(symbol: '');
    _applyFiltersAndSort();
    notifyListeners();
  }

  void clearStatusFilter() {
    _filters = _filters.copyWith(status: null);
    _applyFiltersAndSort();
    notifyListeners();
  }

  void clearDateRangeFilter() {
    _filters = _filters.copyWith(dateRange: null);
    _applyFiltersAndSort();
    notifyListeners();
  }

  void clearExchangeFilter() {
    _filters = _filters.copyWith(exchanges: []);
    _applyFiltersAndSort();
    notifyListeners();
  }

  void _applyFiltersAndSort() {
    List<Trade> filtered = List.from(_allTrades);

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((trade) {
        final query = _searchQuery.toLowerCase();
        return trade.symbol.toLowerCase().contains(query) ||
               (trade.memo?.toLowerCase().contains(query) ?? false) ||
               (trade.notes?.toLowerCase().contains(query) ?? false) ||
               (trade.tag?.toLowerCase().contains(query) ?? false);
      }).toList();
    }

    // Apply symbol filter
    if (_filters.symbol.isNotEmpty) {
      filtered = filtered.where((trade) => 
        trade.symbol.toLowerCase().contains(_filters.symbol.toLowerCase())
      ).toList();
    }

    // Apply status filter
    if (_filters.status != null) {
      filtered = filtered.where((trade) => trade.status == _filters.status).toList();
    }

    // Apply date range filter
    if (_filters.dateRange != null) {
      filtered = filtered.where((trade) {
        final tradeDate = trade.datetime;
        return tradeDate.isAfter(_filters.dateRange!.start) &&
               tradeDate.isBefore(_filters.dateRange!.end.add(const Duration(days: 1)));
      }).toList();
    }

    // Apply exchange filter
    if (_filters.exchanges.isNotEmpty) {
      filtered = filtered.where((trade) => 
        trade.exchanges != null && _filters.exchanges.contains(trade.exchanges)
      ).toList();
    }

    // Apply side filter
    if (_filters.side != null) {
      filtered = filtered.where((trade) => trade.side == _filters.side).toList();
    }

    // Apply PnL range filter
    if (_filters.minPnL != null || _filters.maxPnL != null) {
      filtered = filtered.where((trade) {
        final pnl = trade.pnl ?? 0.0;
        if (_filters.minPnL != null && pnl < _filters.minPnL!) return false;
        if (_filters.maxPnL != null && pnl > _filters.maxPnL!) return false;
        return true;
      }).toList();
    }

    // Apply rating filter
    if (_filters.minRating != null) {
      filtered = filtered.where((trade) => 
        trade.rating != null && trade.rating! >= _filters.minRating!
      ).toList();
    }

    // Sort trades
    _sortTrades(filtered);

    _filteredTrades = filtered;
  }

  void _sortTrades(List<Trade> trades) {
    switch (_sortOption) {
      case TradeSortOption.dateDesc:
        trades.sort((a, b) => b.datetime.compareTo(a.datetime));
        break;
      case TradeSortOption.dateAsc:
        trades.sort((a, b) => a.datetime.compareTo(b.datetime));
        break;
      case TradeSortOption.symbolAsc:
        trades.sort((a, b) => a.symbol.compareTo(b.symbol));
        break;
      case TradeSortOption.symbolDesc:
        trades.sort((a, b) => b.symbol.compareTo(a.symbol));
        break;
      case TradeSortOption.pnlDesc:
        trades.sort((a, b) => (b.pnl ?? 0.0).compareTo(a.pnl ?? 0.0));
        break;
      case TradeSortOption.pnlAsc:
        trades.sort((a, b) => (a.pnl ?? 0.0).compareTo(b.pnl ?? 0.0));
        break;
      case TradeSortOption.ratingDesc:
        trades.sort((a, b) => (b.rating ?? 0).compareTo(a.rating ?? 0));
        break;
      case TradeSortOption.ratingAsc:
        trades.sort((a, b) => (a.rating ?? 0).compareTo(b.rating ?? 0));
        break;
    }
  }

  void _calculateStatistics() {
    if (_filteredTrades.isEmpty) {
      _statistics = TradeStatistics();
      return;
    }

    double totalPnL = 0.0;
    int winningTrades = 0;
    int losingTrades = 0;
    int breakevenTrades = 0;
    double totalRiskAmount = 0.0;
    double totalAchievedR = 0.0;
    int tradesWithR = 0;

    for (final trade in _filteredTrades) {
      final pnl = trade.pnl ?? 0.0;
      totalPnL += pnl;

      if (pnl > 0) {
        winningTrades++;
      } else if (pnl < 0) {
        losingTrades++;
      } else {
        breakevenTrades++;
      }

      if (trade.riskAmount != null && trade.riskAmount! > 0) {
        totalRiskAmount += trade.riskAmount!;
      }

      if (trade.achievedR != null) {
        totalAchievedR += trade.achievedR!;
        tradesWithR++;
      }
    }

    final totalTrades = _filteredTrades.length;
    final winRate = totalTrades > 0 ? (winningTrades / totalTrades) * 100 : 0.0;
    final averageR = tradesWithR > 0 ? totalAchievedR / tradesWithR : 0.0;

    _statistics = TradeStatistics(
      totalTrades: totalTrades,
      winningTrades: winningTrades,
      losingTrades: losingTrades,
      breakevenTrades: breakevenTrades,
      totalPnL: totalPnL,
      winRate: winRate,
      averageR: averageR,
      totalRiskAmount: totalRiskAmount,
    );
  }

  // Get unique values for filters
  List<String> getUniqueSymbols() {
    return _allTrades.map((trade) => trade.symbol).toSet().toList()..sort();
  }

  List<String> getUniqueExchanges() {
    return _allTrades
        .where((trade) => trade.exchanges != null && trade.exchanges!.isNotEmpty)
        .map((trade) => trade.exchanges!)
        .toSet()
        .toList()
      ..sort();
  }

  List<TradeStatus> getUniqueStatuses() {
    return _allTrades.map((trade) => trade.status).toSet().toList();
  }

  List<Side> getUniqueSides() {
    return _allTrades
        .where((trade) => trade.side != null)
        .map((trade) => trade.side!)
        .toSet()
        .toList();
  }

  double? getMinPnL() {
    if (_allTrades.isEmpty) return null;
    return _allTrades.map((trade) => trade.pnl ?? 0.0).reduce((a, b) => a < b ? a : b);
  }

  double? getMaxPnL() {
    if (_allTrades.isEmpty) return null;
    return _allTrades.map((trade) => trade.pnl ?? 0.0).reduce((a, b) => a > b ? a : b);
  }

  int? getMinRating() {
    if (_allTrades.isEmpty) return null;
    final ratings = _allTrades
        .where((trade) => trade.rating != null)
        .map((trade) => trade.rating!)
        .toList();
    return ratings.isEmpty ? null : ratings.reduce((a, b) => a < b ? a : b);
  }

  int? getMaxRating() {
    if (_allTrades.isEmpty) return null;
    final ratings = _allTrades
        .where((trade) => trade.rating != null)
        .map((trade) => trade.rating!)
        .toList();
    return ratings.isEmpty ? null : ratings.reduce((a, b) => a > b ? a : b);
  }
}

enum TradeSortOption {
  dateDesc,
  dateAsc,
  symbolAsc,
  symbolDesc,
  pnlDesc,
  pnlAsc,
  ratingDesc,
  ratingAsc,
}

extension TradeSortOptionExtension on TradeSortOption {
  String get displayName {
    switch (this) {
      case TradeSortOption.dateDesc:
        return 'Date (Newest)';
      case TradeSortOption.dateAsc:
        return 'Date (Oldest)';
      case TradeSortOption.symbolAsc:
        return 'Symbol (A-Z)';
      case TradeSortOption.symbolDesc:
        return 'Symbol (Z-A)';
      case TradeSortOption.pnlDesc:
        return 'PnL (Highest)';
      case TradeSortOption.pnlAsc:
        return 'PnL (Lowest)';
      case TradeSortOption.ratingDesc:
        return 'Rating (Highest)';
      case TradeSortOption.ratingAsc:
        return 'Rating (Lowest)';
    }
  }
}
