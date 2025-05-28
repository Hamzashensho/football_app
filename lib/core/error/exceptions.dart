
abstract class AppException implements Exception {
  final String message;
  final StackTrace? stackTrace;
  final String? code;

  const AppException({
    required this.message,
    this.stackTrace,
    this.code,
  });

  @override
  String toString() => 'AppException: $message${code != null ? ' (code: $code)' : ''}';
}

// For general failures
class Failure extends AppException {
  const Failure({
    required super.message,
    super.stackTrace,
    super.code,
  });
}

// For network related errors
class NetworkException extends AppException {
  const NetworkException({
    required super.message,
    super.stackTrace,
    super.code,
  });
}

// For cache related errors
class CacheException extends AppException {
  const CacheException({
    required super.message,
    super.stackTrace,
    super.code,
  });
}

// For authentication related errors
class AuthException extends AppException {
  const AuthException({
    required super.message,
    super.stackTrace,
    super.code,
  });
}

// For validation errors
class ValidationException extends AppException {
  const ValidationException({
    required super.message,
    super.stackTrace,
    super.code,
  });
}