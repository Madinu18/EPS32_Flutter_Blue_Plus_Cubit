// lib/utils/logger.dart
import 'package:ansicolor/ansicolor.dart';
import 'package:flutter/foundation.dart';

class Logger {
  static final AnsiPen _errorPen = AnsiPen()..red();
  static final AnsiPen _debugPen = AnsiPen()..yellow();

  static void error(String message) {
    if (kDebugMode) {
      print(_errorPen('ERROR: $message'));
    }
  }

  static void debug(String message) {
    if (kDebugMode) {
      print(_debugPen('DEBUG: $message'));
    }
  }
}

class MSG {
  static void ERR(String message) => Logger.error(message);
  static void DBG(String message) => Logger.debug(message);
}
