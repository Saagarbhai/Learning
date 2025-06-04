import 'dart:developer';

class AppLogger {
  static LogLevel _currentLogLevel = LogLevel.debug;

  static void initialize(LogLevel level) {
    _currentLogLevel = level;
  }

  /// Logs the provided data based on the current log level.
  static void logMessage(dynamic message, {StackTrace? stackTrace}) {
    if (_currentLogLevel == LogLevel.debug) {
      final logOutput = stackTrace == null ? "$message" : "$message\n$stackTrace";
      log(logOutput);
    }
  }
}

enum LogLevel { debug, live }
