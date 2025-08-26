import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PerformanceMonitor {
  static final Map<String, Stopwatch> _timers = {};
  static final Map<String, List<Duration>> _measurements = {};
  
  static void startTimer(String name) {
    _timers[name] = Stopwatch()..start();
  }
  
  static void stopTimer(String name) {
    final timer = _timers[name];
    if (timer != null) {
      timer.stop();
      _measurements.putIfAbsent(name, () => []).add(timer.elapsed);
      
      if (kDebugMode) {
        debugPrint('Performance: $name took ${timer.elapsed.inMilliseconds}ms');
      }
      
      _timers.remove(name);
    }
  }
  
  static Duration? getAverageTime(String name) {
    final measurements = _measurements[name];
    if (measurements == null || measurements.isEmpty) return null;
    
    final total = measurements.fold<Duration>(
      Duration.zero,
      (total, duration) => total + duration,
    );
    
    return Duration(microseconds: total.inMicroseconds ~/ measurements.length);
  }
  
  static void clearMeasurements(String name) {
    _measurements.remove(name);
  }
  
  static void clearAllMeasurements() {
    _measurements.clear();
  }
  
  static Map<String, Duration> getAllAverages() {
    final averages = <String, Duration>{};
    for (final name in _measurements.keys) {
      final average = getAverageTime(name);
      if (average != null) {
        averages[name] = average;
      }
    }
    return averages;
  }
  
  static void printPerformanceReport() {
    if (!kDebugMode) return;
    
    debugPrint('\n=== Performance Report ===');
    final averages = getAllAverages();
    for (final entry in averages.entries) {
      debugPrint('${entry.key}: ${entry.value.inMilliseconds}ms average');
    }
    debugPrint('========================\n');
  }
}

class PerformanceWidget extends StatefulWidget {
  final Widget child;
  final String name;
  
  const PerformanceWidget({
    super.key,
    required this.child,
    required this.name,
  });
  
  @override
  State<PerformanceWidget> createState() => _PerformanceWidgetState();
}

class _PerformanceWidgetState extends State<PerformanceWidget> {
  @override
  void initState() {
    super.initState();
    PerformanceMonitor.startTimer(widget.name);
  }
  
  @override
  void dispose() {
    PerformanceMonitor.stopTimer(widget.name);
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
