import 'package:grpc/grpc.dart';

class GrpcException implements Exception {
  final String message;
  final int? code;

  GrpcException(this.message, [this.code]);

  @override
  String toString() => message;
}

class NotFoundException extends GrpcException {
  NotFoundException(String message) : super(message, 5); // StatusCode.notFound = 5
}

class UnauthorizedException extends GrpcException {
  UnauthorizedException() : super('Unauthorized', 16); // StatusCode.unauthenticated = 16
}

class InsufficientFundsException extends GrpcException {
  InsufficientFundsException(String message) : super(message, 9); // StatusCode.failedPrecondition = 9
}

class NetworkException extends GrpcException {
  NetworkException(String message) : super(message, 14); // StatusCode.unavailable = 14
}

class ServerException extends GrpcException {
  ServerException(String message) : super(message, 13); // StatusCode.internal = 13
}

Exception mapGrpcError(GrpcError error) {
  switch (error.code) {
    case 5: // StatusCode.notFound
      return NotFoundException(error.message ?? 'Resource not found');
    case 16: // StatusCode.unauthenticated
      return UnauthorizedException();
    case 7: // StatusCode.permissionDenied
      return GrpcException('Access denied', 7);
    case 9: // StatusCode.failedPrecondition
      if (error.message?.contains('insufficient funds') ?? false) {
        return InsufficientFundsException(error.message!);
      }
      return GrpcException(error.message ?? 'Precondition failed', error.code);
    case 14: // StatusCode.unavailable
      return NetworkException('Service unavailable. Please check your connection.');
    case 4: // StatusCode.deadlineExceeded
      return NetworkException('Request timed out');
    default:
      return ServerException(error.message ?? 'An unexpected error occurred');
  }
}
