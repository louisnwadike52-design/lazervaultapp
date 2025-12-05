import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import '../entities/profile_entity.dart';
import '../repositories/i_auth_repository.dart';

class VerifyEmailUseCase {
  final IAuthRepository repository;

  VerifyEmailUseCase(this.repository);

  Future<Either<Failure, ProfileEntity>> call(String verificationCode) {
    return repository.verifyEmail(verificationCode: verificationCode);
  }
}
