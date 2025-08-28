import 'dart:developer' as developer;

/// A simple logging utility to replace print statements in production code
class Logger {
  static const String _tag = 'TradeMate';
  
  /// Log debug information
  static void debug(String message, [String? tag]) {
    developer.log(
      message,
      name: tag ?? _tag,
      level: 500, // Debug level
    );
  }
  
  /// Log information messages
  static void info(String message, [String? tag]) {
    developer.log(
      message,
      name: tag ?? _tag,
      level: 800, // Info level
    );
  }
  
  /// Log warning messages
  static void warning(String message, [String? tag]) {
    developer.log(
      message,
      name: tag ?? _tag,
      level: 900, // Warning level
    );
  }
  
  /// Log error messages
  static void error(String message, [Object? error, StackTrace? stackTrace]) {
    developer.log(
      message,
      name: _tag,
      level: 1000, // Error level
      error: error,
      stackTrace: stackTrace,
    );
  }
  
  /// Log database operations specifically
  static void database(String message) {
    info(message, 'Database');
  }
  
  /// Log migration operations specifically
  static void migration(String message) {
    info(message, 'Migration');
  }
}
