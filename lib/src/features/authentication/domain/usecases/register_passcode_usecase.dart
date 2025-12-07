import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/src/features/authentication/domain/repositories/i_auth_repository.dart';

class RegisterPasscodeUseCase {
  final IAuthRepository _repository;

  RegisterPasscodeUseCase(this._repository);

  Future<Either<Failure, void>> call({
    required String passcode,
  }) async {
    return _repository.registerPasscode(passcode: passcode);
  }
}
