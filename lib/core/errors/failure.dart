import 'package:equatable/equatable.dart';
import 'package:lazervault/core/utils/friendly_error.dart';

import 'exceptions.dart';


abstract class Failure extends Equatable {
  final String message;
  final int statusCode;

  // Sanitize on construction so raw transport/exception text is never stored.
  Failure({required String message, required this.statusCode})
      : message = sanitizeUserFacingError(message);

  String get errorMessage => "$statusCode Error $message";

  @override
  List<Object> get props => [message, statusCode];
}

class APIFailure extends Failure {
  APIFailure({required super.message, required super.statusCode});

  APIFailure.fromException(APIException exception)
      : this(message: exception.message, statusCode: exception.statusCode);
}
