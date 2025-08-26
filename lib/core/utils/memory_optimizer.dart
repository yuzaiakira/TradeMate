import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MemoryOptimizer {
  static final Map<String, Timer> _cleanupTimers = {};
  static final Map<String, List<dynamic>> _cachedData = {};
  
  // Cache data with automatic cleanup
  static void cacheData<T>(String key, List<T> data, {Duration? ttl}) {
    _cachedData[key] = data;
    
    // Set up automatic cleanup
    final cleanupTimer = Timer(ttl ?? const Duration(minutes: 5), () {
      _cachedData.remove(key);
      if (kDebugMode) {
        print('Memory: Cached data for $key has been cleaned up');
      }
    });
    
    _cleanupTimers[key] = cleanupTimer;
  }
  
  // Get cached data
  static List<T>? getCachedData<T>(String key) {
    return _cachedData[key] as List<T>?;
  }
  
  // Clear specific cache
  static void clearCache(String key) {
    _cachedData.remove(key);
    _cleanupTimers[key]?.cancel();
    _cleanupTimers.remove(key);
  }
  
  // Clear all caches
  static void clearAllCaches() {
    _cachedData.clear();
    for (final timer in _cleanupTimers.values) {
      timer.cancel();
    }
    _cleanupTimers.clear();
    
    if (kDebugMode) {
      debugPrint('Memory: All caches have been cleared');
    }
  }
  
  // Get cache statistics
  static Map<String, int> getCacheStats() {
    final stats = <String, int>{};
    for (final entry in _cachedData.entries) {
      stats[entry.key] = entry.value.length;
    }
    return stats;
  }
  
  // Print memory usage information
  static void printMemoryStats() {
    if (!kDebugMode) return;
    
    debugPrint('\n=== Memory Usage Report ===');
    final stats = getCacheStats();
    for (final entry in stats.entries) {
      debugPrint('${entry.key}: ${entry.value} items cached');
    }
    debugPrint('Total cached items: ${stats.values.fold(0, (sum, count) => sum + count)}');
    debugPrint('==========================\n');
  }
}

// Widget for lazy loading
class LazyLoadWidget extends StatefulWidget {
  final Widget Function() builder;
  final Duration delay;
  
  const LazyLoadWidget({
    super.key,
    required this.builder,
    this.delay = Duration.zero,
  });
  
  @override
  State<LazyLoadWidget> createState() => _LazyLoadWidgetState();
}

class _LazyLoadWidgetState extends State<LazyLoadWidget> {
  bool _isLoaded = false;
  Timer? _timer;
  
  @override
  void initState() {
    super.initState();
    if (widget.delay == Duration.zero) {
      _isLoaded = true;
    } else {
      _timer = Timer(widget.delay, () {
        if (mounted) {
          setState(() {
            _isLoaded = true;
          });
        }
      });
    }
  }
  
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    if (!_isLoaded) {
      return const SizedBox.shrink();
    }
    return widget.builder();
  }
}

// Widget for conditional rendering with memory optimization
class ConditionalWidget extends StatelessWidget {
  final bool condition;
  final Widget Function() trueBuilder;
  final Widget Function()? falseBuilder;
  
  const ConditionalWidget({
    super.key,
    required this.condition,
    required this.trueBuilder,
    this.falseBuilder,
  });
  
  @override
  Widget build(BuildContext context) {
    if (condition) {
      return trueBuilder();
    }
    return falseBuilder?.call() ?? const SizedBox.shrink();
  }
}
