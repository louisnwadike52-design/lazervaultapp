import 'package:lazervault/core/utils/friendly_error.dart';

class Failure {
  final String message;
  final int statusCode;

  // Sanitize on construction so raw transport/exception text is never stored
  // and later surfaced via state.message / failure.message.
  Failure({
    required String message,
    required this.statusCode,
  }) : message = sanitizeUserFacingError(message);
}

class ServerFailure extends Failure {
  final int? cooldownSeconds;

  ServerFailure({
    required super.message,
    required super.statusCode,
    this.cooldownSeconds,
  });
}

class CacheFailure extends Failure {
  CacheFailure({required super.message, required super.statusCode});
}

// You can add more specific Failure types here as needed.
