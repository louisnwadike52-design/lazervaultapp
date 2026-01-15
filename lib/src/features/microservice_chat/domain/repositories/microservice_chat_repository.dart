import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';

abstract class MicroserviceChatRepository {
  Future<Either<Failure, String>> processMessage({
    required String message,
    required String sessionId,
    required String userId,
    required String accessToken,
    required String sourceContext,
    String language,
  });
}
