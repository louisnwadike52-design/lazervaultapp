import 'package:grpc/grpc.dart';
import '../errors/grpc_exceptions.dart';

Future<T> retryWithBackoff<T>({
  required Future<T> Function() operation,
  int maxRetries = 3,
  Duration initialDelay = const Duration(seconds: 1),
  double backoffMultiplier = 2.0,
}) async {
  int retries = 0;
  Duration delay = initialDelay;

  while (true) {
    try {
      return await operation();
    } on GrpcError catch (e) {
      // Let auth errors propagate as GrpcError so executeWithTokenRotation
      // can detect them and trigger token refresh
      if (e.code == StatusCode.unauthenticated || e.code == StatusCode.permissionDenied) {
        rethrow;
      }
      if (retries >= maxRetries || !_isRetryable(e)) {
        throw mapGrpcError(e);
      }

      print('Retry attempt ${retries + 1}/$maxRetries after ${delay.inSeconds}s delay');
      await Future.delayed(delay);

      delay = Duration(milliseconds: (delay.inMilliseconds * backoffMultiplier).toInt());
      retries++;
    }
  }
}

bool _isRetryable(GrpcError error) {
  return error.code == StatusCode.unavailable ||
         error.code == StatusCode.deadlineExceeded ||
         error.code == StatusCode.resourceExhausted;
}
