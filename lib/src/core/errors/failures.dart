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
} 