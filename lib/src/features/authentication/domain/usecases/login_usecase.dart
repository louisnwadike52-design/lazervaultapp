import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/src/features/authentication/domain/entities/profile_entity.dart';
import 'package:lazervault/src/features/authentication/domain/repositories/i_auth_repository.dart';

class LoginUseCase {
  final IAuthRepository _repository;

  LoginUseCase(this._repository);

  Future<Either<Failure, ProfileEntity>> call({
    required String email,
    required String password,
  }) async {
    return _repository.login(email: email, password: password);
  }
}