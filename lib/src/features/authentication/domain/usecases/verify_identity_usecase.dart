import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/src/features/authentication/domain/repositories/i_auth_repository.dart';

class VerifyIdentityUseCase {
  final IAuthRepository repository;

  VerifyIdentityUseCase(this.repository);

  Future<Either<Failure, IdentityVerificationResult>> call({
    required String identityType,
    required String identityNumber,
    required String dateOfBirth,
    String? countryCode,
  }) async {
    return await repository.verifyIdentity(
      identityType: identityType,
      identityNumber: identityNumber,
      dateOfBirth: dateOfBirth,
      countryCode: countryCode,
    );
  }
}
