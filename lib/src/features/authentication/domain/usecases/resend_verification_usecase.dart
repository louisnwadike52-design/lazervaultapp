import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import '../repositories/i_auth_repository.dart';

class ResendVerificationUseCase {
  final IAuthRepository repository;

  ResendVerificationUseCase(this.repository);

  /// Returns cooldown seconds (time to wait before next resend) on success
  Future<Either<Failure, int>> call({required String email}) {
    return repository.resendVerificationEmail(email: email);
  }
}
