import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import '../repositories/i_auth_repository.dart';

class ResetPasswordUseCase {
  final IAuthRepository repository;

  ResetPasswordUseCase(this.repository);

  Future<Either<Failure, void>> call({
    required String email,
    required String token,
    required String newPassword,
  }) {
    return repository.resetPassword(
      email: email,
      token: token,
      newPassword: newPassword,
    );
  }
}
