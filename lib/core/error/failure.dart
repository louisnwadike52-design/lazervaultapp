
class Failure {
  final String message;
  final int statusCode;

  const Failure({
    required this.message,
    required this.statusCode,
  });
}

class ServerFailure extends Failure {
  final int? cooldownSeconds;

  const ServerFailure({
    required super.message,
    required super.statusCode,
    this.cooldownSeconds,
  });
}

class CacheFailure extends Failure {
  const CacheFailure({required super.message, required super.statusCode});
}

// You can add more specific Failure types here as needed. 