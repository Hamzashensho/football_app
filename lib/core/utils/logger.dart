import 'dart:developer' as developer;

class AppLogger {
  static const String _defaultTag = 'AppLog';

  static void log(
    String message, {
    String tag = _defaultTag,
    Object? error,
    StackTrace? stackTrace,
  }) {
    developer.log(
      message,
      name: tag,
      error: error,
      stackTrace: stackTrace,
    );
  }

  static void info(String message, {String tag = _defaultTag}) {
    log('ℹ️ INFO: $message', tag: tag);
  }

  static void warning(String message, {String tag = _defaultTag}) {
    log('⚠️ WARNING: $message', tag: tag);
  }

  static void error(String message,
      {String tag = _defaultTag, Object? error, StackTrace? stackTrace}) {
    log('❌ ERROR: $message', tag: tag, error: error, stackTrace: stackTrace);
  }

  static void success(String message, {String tag = _defaultTag}) {
    log('✅ SUCCESS: $message', tag: tag);
  }

  static void debug(String message, {String tag = _defaultTag}) {
    log('🐞 DEBUG: $message', tag: tag);
  }
}
