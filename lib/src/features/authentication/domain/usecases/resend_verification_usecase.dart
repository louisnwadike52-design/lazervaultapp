import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import '../repositories/i_auth_repository.dart';

class ResendVerificationUseCase {
  final IAuthRepository repository;

  ResendVerificationUseCase(this.repository);

  Future<Either<Failure, void>> call() {
    return repository.resendVerificationEmail();
  }
}
