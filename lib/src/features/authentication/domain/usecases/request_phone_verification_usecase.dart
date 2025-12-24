import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/src/features/authentication/domain/entities/phone_verification_entity.dart';
import 'package:lazervault/src/features/authentication/domain/repositories/i_auth_repository.dart';

class RequestPhoneVerificationUseCase {
  final IAuthRepository repository;

  RequestPhoneVerificationUseCase(this.repository);

  Future<Either<Failure, PhoneVerificationEntity>> call({
    required String phoneNumber,
  }) async {
    return await repository.requestPhoneVerification(phoneNumber: phoneNumber);
  }
}
