import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/src/features/authentication/domain/repositories/i_auth_repository.dart';

class ChangePasscodeUseCase {
  final IAuthRepository _repository;

  ChangePasscodeUseCase(this._repository);

  Future<Either<Failure, void>> call({
    required String oldPasscode,
    required String newPasscode,
  }) async {
    return _repository.changePasscode(
      oldPasscode: oldPasscode,
      newPasscode: newPasscode,
    );
  }
}
