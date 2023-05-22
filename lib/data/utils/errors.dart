abstract class AppError {
  const AppError(
    this.message, [
    this.code,
    this.errorType,
  ]);

  final String message;
  final String? code;
  final ErrorType? errorType;

  @override
  List<Object?> get props => [message, code, errorType];
}

/// Network error
class AuthorizationError extends AppError {
  const AuthorizationError(
    String message, [
    String? code,
    ErrorType? errorType,
  ]) : super(message, code, errorType);
}

/// Cache error
class CacheError extends AppError {
  const CacheError(
    String message, [
    String? code,
    ErrorType? errorType,
  ]) : super(message, code, errorType);
}

/// Server error
class ServerError extends AppError {
  const ServerError(
    String message, [
    String? code,
    ErrorType? errorType,
  ]) : super(message, code, errorType);
}

/// Network error
class NetworkError extends AppError {
  const NetworkError(
    String message, [
    String? code,
    ErrorType? errorType,
  ]) : super(message, code, errorType);
}

/// Other error
class OtherError extends AppError {
  const OtherError(
    String message, [
    String? code,
    ErrorType? errorType,
  ]) : super(message, code, errorType);
}

enum ErrorType {
  sessionTimeOut,
  authenticated,
  validated,
  none,
  other,
  maintained,
  noInternet,
}
