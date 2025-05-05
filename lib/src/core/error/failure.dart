import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure({required this.message, required this.statusCode});

  final String message;
  final dynamic statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}

class APIFailure extends Failure {
  const APIFailure({
    required super.message,
    required super.statusCode,
  });
}

class ServerFailure extends Failure {
  const ServerFailure({
    required super.message,
    required super.statusCode,
  });
}

class CacheFailure extends Failure {
  const CacheFailure({
    required super.message,
    required super.statusCode,
  });
}

class NetworkFailure extends Failure {
  const NetworkFailure({required super.message})
      : super(statusCode: 'Network Error');
} 