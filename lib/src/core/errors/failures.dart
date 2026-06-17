import 'package:grpc/grpc.dart';

/// Maps raw gRPC errors to user-friendly messages.
/// Use this in all repository catch blocks instead of exposing [GrpcError.message].
String friendlyGrpcError(GrpcError e, String fallback) {
  if (e.code == StatusCode.unavailable ||
      e.code == StatusCode.unimplemented ||
      (e.message != null && e.message!.contains('unknown service'))) {
    return 'Service temporarily unavailable. Please try again later.';
  }
  if (e.code == StatusCode.deadlineExceeded) {
    return 'Request timed out. Please try again.';
  }
  if (e.code == StatusCode.unauthenticated) {
    return 'Session expired. Please log in again.';
  }
  if (e.code == StatusCode.permissionDenied) {
    return e.message ?? 'Permission denied.';
  }
  return e.message ?? fallback;
}

abstract class Failure {
  const Failure({required this.message, required this.statusCode});

  final String message;
  final dynamic statusCode; // Can be String or int

  @override
  String toString() => '$statusCode Error: $message';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Failure &&
        other.message == message &&
        other.statusCode == statusCode;
  }

  @override
  int get hashCode => message.hashCode ^ statusCode.hashCode;
}

// Define specific failure types if needed, e.g., ServerFailure, CacheFailure
class ServerFailure extends Failure {
  const ServerFailure({required super.message, required super.statusCode});
}

class CacheFailure extends Failure {
  const CacheFailure({required super.message, required super.statusCode});
}

class NetworkFailure extends Failure {
  const NetworkFailure({required super.message})
      : super(statusCode: 'Network Error'); // Example default status code

  factory NetworkFailure.fromException(dynamic exception) {
    return NetworkFailure(message: exception.toString());
  }
} 