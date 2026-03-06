import 'dart:developer' as developer;

/// Simple logger for the LazerVault app
class AppLogger {
  static const String _tag = 'LazerVault';

  static void info(String message, {Object? error, StackTrace? stackTrace}) {
    developer.log(
      message,
      name: _tag,
      time: DateTime.now(),
      level: 500, // INFO level
      error: error,
      stackTrace: stackTrace,
    );
  }

  static void warning(String message, {Object? error, StackTrace? stackTrace}) {
    developer.log(
      message,
      name: _tag,
      time: DateTime.now(),
      level: 900, // WARNING level
      error: error,
      stackTrace: stackTrace,
    );
  }

  static void error(String message, {Object? error, StackTrace? stackTrace}) {
    developer.log(
      message,
      name: _tag,
      time: DateTime.now(),
      level: 1000, // ERROR level
      error: error,
      stackTrace: stackTrace,
    );
  }

  static void debug(String message, {Object? error, StackTrace? stackTrace}) {
    developer.log(
      message,
      name: _tag,
      time: DateTime.now(),
      level: 300, // FINE level (debug)
      error: error,
      stackTrace: stackTrace,
    );
  }
}
