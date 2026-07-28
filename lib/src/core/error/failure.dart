import 'package:equatable/equatable.dart';
import 'package:lazervault/core/utils/friendly_error.dart';

abstract class Failure extends Equatable {
  // Sanitize on construction so raw transport/exception text is never stored.
  Failure({required String message, required this.statusCode})
      : message = sanitizeUserFacingError(message);

  final String message;
  final dynamic statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}

class APIFailure extends Failure {
  APIFailure({
    required super.message,
    required super.statusCode,
  });
}

class ServerFailure extends Failure {
  ServerFailure({
    required super.message,
    required super.statusCode,
  });
}

class CacheFailure extends Failure {
  CacheFailure({
    required super.message,
    required super.statusCode,
  });
}

class NetworkFailure extends Failure {
  NetworkFailure({required super.message})
      : super(statusCode: 'Network Error');
}
