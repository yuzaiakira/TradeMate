import 'dart:async';
import 'logger.dart';

class StatisticsCache {
  static final Map<String, _CachedResult> _cache = {};
  static const Duration _cacheExpiry = Duration(minutes: 5);
  static const int _maxCacheSize = 50; // Prevent memory leaks
  
  static String _generateCacheKey(Map<String, dynamic> filters) {
    final sortedEntries = filters.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));
    return sortedEntries.map((e) => '${e.key}:${e.value}').join('|');
  }
  
  static Map<String, dynamic>? getCachedStats(Map<String, dynamic> filters) {
    final key = _generateCacheKey(filters);
    final cached = _cache[key];
    
    if (cached != null && DateTime.now().difference(cached.timestamp) < _cacheExpiry) {
      // Update access time for LRU
      cached.lastAccessed = DateTime.now();
      return cached.data;
    }
    
    // Remove expired entry
    if (cached != null) {
      _cache.remove(key);
    }
    
    return null;
  }
  
  static void cacheStats(Map<String, dynamic> filters, Map<String, dynamic> stats) {
    final key = _generateCacheKey(filters);
    
    // Implement LRU eviction if cache is full
    if (_cache.length >= _maxCacheSize) {
      _evictOldestEntry();
    }
    
    _cache[key] = _CachedResult(
      data: stats,
      timestamp: DateTime.now(),
      lastAccessed: DateTime.now(),
    );
  }
  
  static void _evictOldestEntry() {
    String? oldestKey;
    DateTime? oldestAccess;
    
    for (final entry in _cache.entries) {
      if (oldestAccess == null || entry.value.lastAccessed.isBefore(oldestAccess)) {
        oldestKey = entry.key;
        oldestAccess = entry.value.lastAccessed;
      }
    }
    
    if (oldestKey != null) {
      _cache.remove(oldestKey);
    }
  }
  
  static void clearCache() {
    _cache.clear();
  }
  
  static void removeExpiredEntries() {
    final now = DateTime.now();
    final expiredKeys = _cache.entries
        .where((entry) => now.difference(entry.value.timestamp) >= _cacheExpiry)
        .map((entry) => entry.key)
        .toList();
    
    for (final key in expiredKeys) {
      _cache.remove(key);
    }
  }
  
  static int get cacheSize => _cache.length;
  
  static void printCacheStats() {
    Logger.info('Statistics Cache Stats:');
    Logger.info('  Total entries: ${_cache.length}');
    Logger.info('  Max size: $_maxCacheSize');
    Logger.info('  Expiry time: $_cacheExpiry');
    
    if (_cache.isNotEmpty) {
      final now = DateTime.now();
      final expiredCount = _cache.values
          .where((cached) => now.difference(cached.timestamp) >= _cacheExpiry)
          .length;
      Logger.info('  Expired entries: $expiredCount');
    }
  }
}

class _CachedResult {
  final Map<String, dynamic> data;
  final DateTime timestamp;
  DateTime lastAccessed;
  
  _CachedResult({
    required this.data,
    required this.timestamp,
    required this.lastAccessed,
  });
}

class DebouncedStatisticsLoader {
  Timer? _debounceTimer;
  final Function(Map<String, dynamic>) _onLoad;
  
  DebouncedStatisticsLoader(this._onLoad);
  
  void loadStatistics(Map<String, dynamic> filters) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
      _onLoad(filters);
    });
  }
  
  void dispose() {
    _debounceTimer?.cancel();
  }
}
