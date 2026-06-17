import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/src/features/authentication/domain/entities/profile_entity.dart';
import 'package:lazervault/src/features/authentication/domain/repositories/i_auth_repository.dart';

class ValidateTokenUseCase {
  final IAuthRepository _repository;

  ValidateTokenUseCase(this._repository);

  Future<Either<Failure, ProfileEntity>> call({
    required String accessToken,
  }) async {
    return _repository.validateToken(accessToken: accessToken);
  }
}
