import 'package:flutter/foundation.dart';
import '../../../add_trade/domain/entities/trade.dart';
import '../../../add_trade/domain/usecases/get_trades_usecase.dart';
import '../../../add_trade/domain/usecases/get_trades_paginated_usecase.dart';
import '../../../add_trade/domain/usecases/get_trades_count_usecase.dart';
import '../../../add_trade/domain/usecases/get_trade_statistics_optimized_usecase.dart';
import '../../../add_trade/domain/usecases/delete_trade_usecase.dart';
import '../models/trade_filters.dart';
import '../models/trade_statistics.dart';
import '../models/trade_sort_option.dart';
import '../models/profit_loss_filter.dart';

enum TradeListStatus { initial, loading, success, error }

class TradeListProvider with ChangeNotifier {
  final GetTradesUseCase getTradesUseCase;
  final GetTradesPaginatedUseCase getTradesPaginatedUseCase;
  final GetTradesCountUseCase getTradesCountUseCase;
  final GetTradeStatisticsOptimizedUseCase getTradeStatisticsOptimizedUseCase;
  final DeleteTradeUseCase deleteTradeUseCase;
  VoidCallback? _onTradesRefreshed;

  TradeListProvider({
    required this.getTradesUseCase,
    required this.getTradesPaginatedUseCase,
    required this.getTradesCountUseCase,
    required this.getTradeStatisticsOptimizedUseCase,
    required this.deleteTradeUseCase,
  });

  // Set callback to be called when trades are refreshed
  void setOnTradesRefreshedCallback(VoidCallback callback) {
    _onTradesRefreshed = callback;
  }

  // Pagination state
  static const int _pageSize = 20;
  int _currentPage = 0;
  bool _hasMoreTrades = true;
  bool _isLoadingMore = false;
  
  // Current state
  TradeListStatus _status = TradeListStatus.initial;
  String _errorMessage = '';
  List<Trade> _currentPageTrades = [];
  TradeFilters _filters = const TradeFilters();
  String _searchQuery = '';
  TradeSortOption _sortOption = TradeSortOption.dateDesc;
  TradeStatistics _statistics = TradeStatistics();
  int _totalTrades = 0;
  bool _isCalculatingStats = false;

  // Getters
  TradeListStatus get status => _status;
  String get errorMessage => _errorMessage;
  List<Trade> get trades => _currentPageTrades;
  TradeFilters get filters => _filters;
  String get searchQuery => _searchQuery;
  TradeSortOption get sortOption => _sortOption;
  TradeStatistics get statistics => _statistics;
  bool get isLoading => _status == TradeListStatus.loading;
  bool get isLoadingMore => _isLoadingMore;
  bool get hasMoreTrades => _hasMoreTrades;
  bool get hasActiveFilters => _filters.hasActiveFilters || _searchQuery.isNotEmpty;
  int get totalTrades => _totalTrades;
  bool get isCalculatingStats => _isCalculatingStats;
  
  void setCalculatingStats(bool value) {
    _isCalculatingStats = value;
    notifyListeners();
  }

  Future<void> loadTrades() async {
    try {
      _status = TradeListStatus.loading;
      _currentPage = 0;
      _hasMoreTrades = true;
      _currentPageTrades.clear();
      notifyListeners();

      await _loadNextPage();
      await _loadStatistics();
      
      _status = TradeListStatus.success;
      _errorMessage = '';
      _onTradesRefreshed?.call(); // Notify callback
    } catch (e) {
      _status = TradeListStatus.error;
      _errorMessage = e.toString();
    }
    notifyListeners();
  }

  // Load next page of trades
  Future<void> loadNextPage() async {
    if (!_hasMoreTrades || _isLoadingMore) return;
    
    try {
      _isLoadingMore = true;
      notifyListeners();
      
      await _loadNextPage();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoadingMore = false;
      notifyListeners();
    }
  }

  // Internal method to load next page
  Future<void> _loadNextPage() async {
    final newTrades = await getTradesPaginatedUseCase(
      limit: _pageSize,
      offset: _currentPage * _pageSize,
      searchQuery: _searchQuery,
      symbolFilter: _filters.symbol,
      statusFilter: _filters.status?.name,
      startDate: _filters.dateRange?.start,
      endDate: _filters.dateRange?.end,
      exchangesFilter: _filters.exchanges.isNotEmpty ? _filters.exchanges.first : null,
      sideFilter: _filters.side?.name,
      minPnL: _filters.minPnL,
      maxPnL: _filters.maxPnL,
      minRating: _filters.minRating,
      profitLossFilter: _filters.profitLossFilter.name,
      sortBy: _getSortBy(),
      sortDesc: _getSortDesc(),
    );
    
    _currentPageTrades.addAll(newTrades);
    _currentPage++;
    _hasMoreTrades = newTrades.length == _pageSize;
    
    // Update total count if this is the first page
    if (_currentPage == 1) {
      _totalTrades = await getTradesCountUseCase(
        searchQuery: _searchQuery,
        symbolFilter: _filters.symbol,
        statusFilter: _filters.status?.name,
        startDate: _filters.dateRange?.start,
        endDate: _filters.dateRange?.end,
        exchangesFilter: _filters.exchanges.isNotEmpty ? _filters.exchanges.first : null,
        sideFilter: _filters.side?.name,
        minPnL: _filters.minPnL,
        maxPnL: _filters.maxPnL,
        minRating: _filters.minRating,
        profitLossFilter: _filters.profitLossFilter.name,
      );
    }
  }

  // Load statistics
  Future<void> _loadStatistics() async {
    final statsData = await getTradeStatisticsOptimizedUseCase(
      searchQuery: _searchQuery,
      symbolFilter: _filters.symbol,
      statusFilter: _filters.status?.name,
      startDate: _filters.dateRange?.start,
      endDate: _filters.dateRange?.end,
      exchangesFilter: _filters.exchanges.isNotEmpty ? _filters.exchanges.first : null,
      sideFilter: _filters.side?.name,
      minPnL: _filters.minPnL,
      maxPnL: _filters.maxPnL,
      minRating: _filters.minRating,
      profitLossFilter: _filters.profitLossFilter.name,
    );
    
    _statistics = TradeStatistics(
      totalTrades: statsData['totalTrades'] ?? 0,
      winningTrades: statsData['winningTrades'] ?? 0,
      losingTrades: statsData['losingTrades'] ?? 0,
      breakevenTrades: statsData['breakevenTrades'] ?? 0,
      totalPnL: statsData['totalPnL'] ?? 0.0,
      averagePnL: statsData['averagePnL'] ?? 0.0,
      winRate: statsData['winRate'] ?? 0.0,
      averageR: statsData['averageR'] ?? 0.0,
      totalRiskAmount: statsData['totalRiskAmount'] ?? 0.0,
      totalRating: statsData['totalRating'] ?? 0,
      averageRating: statsData['averageRating'] ?? 0.0,
      uniqueSymbols: statsData['uniqueSymbols'] ?? 0,
      uniqueExchanges: statsData['uniqueExchanges'] ?? 0,
    );
  }

  // Helper methods for sorting
  String _getSortBy() {
    switch (_sortOption) {
      case TradeSortOption.dateDesc:
      case TradeSortOption.dateAsc:
        return 'datetime';
      case TradeSortOption.symbolAsc:
      case TradeSortOption.symbolDesc:
        return 'symbol';
      case TradeSortOption.pnlDesc:
      case TradeSortOption.pnlAsc:
        return 'pnl';
      case TradeSortOption.ratingDesc:
      case TradeSortOption.ratingAsc:
        return 'rating';
    }
  }

  bool _getSortDesc() {
    switch (_sortOption) {
      case TradeSortOption.dateDesc:
      case TradeSortOption.symbolDesc:
      case TradeSortOption.pnlDesc:
      case TradeSortOption.ratingDesc:
        return true;
      case TradeSortOption.dateAsc:
      case TradeSortOption.symbolAsc:
      case TradeSortOption.pnlAsc:
      case TradeSortOption.ratingAsc:
        return false;
    }
  }

  // Convenience method for refreshing trades
  Future<void> refresh() async {
    await loadTrades();
  }

  // Method to refresh trades without showing loading state (for background refreshes)
  Future<void> refreshSilently() async {
    try {
      final newTrades = await getTradesPaginatedUseCase(
        limit: _pageSize,
        offset: 0,
        searchQuery: _searchQuery,
        symbolFilter: _filters.symbol,
        statusFilter: _filters.status?.name,
        startDate: _filters.dateRange?.start,
        endDate: _filters.dateRange?.end,
        exchangesFilter: _filters.exchanges.isNotEmpty ? _filters.exchanges.first : null,
        sideFilter: _filters.side?.name,
        minPnL: _filters.minPnL,
        maxPnL: _filters.maxPnL,
        minRating: _filters.minRating,
        profitLossFilter: _filters.profitLossFilter.name,
        sortBy: _getSortBy(),
        sortDesc: _getSortDesc(),
      );
      
      if (newTrades.length != _currentPageTrades.length || 
          (newTrades.isNotEmpty && _currentPageTrades.isNotEmpty && 
           newTrades.first.id != _currentPageTrades.first.id)) {
        // Only update if the data has changed
        _currentPageTrades = newTrades;
        _currentPage = 1;
        _hasMoreTrades = newTrades.length == _pageSize;
        await _loadStatistics();
        // Don't call callback for silent refresh to avoid too many notifications
        notifyListeners();
      }
    } catch (e) {
      // Silently fail for background refreshes
      debugPrint('Silent refresh failed: $e');
    }
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
      // Get all trade IDs first
      final allTrades = await getTradesUseCase();
      for (final trade in allTrades) {
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
    _resetAndReload();
  }

  void clearSearch() {
    _searchQuery = '';
    _resetAndReload();
  }

  void setFilters(TradeFilters filters) {
    _filters = filters;
    _resetAndReload();
  }

  void clearAllFilters() {
    _filters = const TradeFilters();
    _searchQuery = '';
    _resetAndReload();
  }

  void setSortOption(TradeSortOption sortOption) {
    _sortOption = sortOption;
    _resetAndReload();
  }

  // Filter clearing methods
  void clearSymbolFilter() {
    _filters = _filters.copyWith(symbol: '');
    _resetAndReload();
  }

  void clearStatusFilter() {
    _filters = _filters.copyWith(status: null);
    _resetAndReload();
  }

  void clearDateRangeFilter() {
    _filters = _filters.copyWith(dateRange: null);
    _resetAndReload();
  }

  void clearExchangeFilter() {
    _filters = _filters.copyWith(exchanges: []);
    _resetAndReload();
  }

  void clearProfitLossFilter() {
    _filters = _filters.copyWith(profitLossFilter: ProfitLossFilter.all);
    _resetAndReload();
  }

  void clearSideFilter() {
    _filters = _filters.copyWith(side: null);
    _resetAndReload();
  }

  void clearPnLRangeFilter() {
    _filters = _filters.copyWith(minPnL: null, maxPnL: null);
    _resetAndReload();
  }

  void clearRatingFilter() {
    _filters = _filters.copyWith(minRating: null);
    _resetAndReload();
  }

  // Reset pagination and reload data
  void _resetAndReload() {
    _currentPage = 0;
    _hasMoreTrades = true;
    _currentPageTrades.clear();
    loadTrades();
  }

  // Get unique values for filters - these will need to be loaded separately
  // For now, we'll return empty lists and these can be loaded when needed
  List<String> getUniqueSymbols() {
    return [];
  }

  List<String> getUniqueExchanges() {
    return [];
  }

  List<TradeStatus> getUniqueStatuses() {
    return [];
  }

  List<Side> getUniqueSides() {
    return [];
  }

  double? getMinPnL() {
    return null;
  }

  double? getMaxPnL() {
    return null;
  }

  int? getMinRating() {
    return null;
  }

  int? getMaxRating() {
    return null;
  }
}


