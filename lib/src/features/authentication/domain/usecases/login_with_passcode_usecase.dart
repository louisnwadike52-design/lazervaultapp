import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/src/features/authentication/domain/entities/profile_entity.dart';
import 'package:lazervault/src/features/authentication/domain/repositories/i_auth_repository.dart';

class LoginWithPasscodeUseCase {
  final IAuthRepository _repository;

  LoginWithPasscodeUseCase(this._repository);

  Future<Either<Failure, ProfileEntity>> call({
    required String email,
    required String passcode,
  }) async {
    return _repository.loginWithPasscode(email: email, passcode: passcode);
  }
}
