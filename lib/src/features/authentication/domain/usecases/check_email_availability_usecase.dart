import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/src/features/authentication/domain/repositories/i_auth_repository.dart';

class CheckEmailAvailabilityUseCase {
  final IAuthRepository _repository;

  CheckEmailAvailabilityUseCase(this._repository);

  Future<Either<Failure, bool>> call({
    required String email,
  }) async {
    return _repository.checkEmailAvailability(email: email);
  }
}
