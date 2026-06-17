import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/src/features/authentication/domain/entities/phone_verification_entity.dart';
import 'package:lazervault/src/features/authentication/domain/repositories/i_auth_repository.dart';

class VerifyPhoneNumberUseCase {
  final IAuthRepository repository;

  VerifyPhoneNumberUseCase(this.repository);

  Future<Either<Failure, VerifyPhoneEntity>> call({
    required String phoneNumber,
    required String verificationCode,
  }) async {
    return await repository.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCode: verificationCode,
    );
  }
}
