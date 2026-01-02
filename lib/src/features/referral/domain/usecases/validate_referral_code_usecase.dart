import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import '../repositories/i_referral_repository.dart';

class ValidateReferralCodeUseCase {
  final IReferralRepository repository;

  ValidateReferralCodeUseCase(this.repository);

  Future<Either<Failure, bool>> call({
    required String code,
  }) async {
    return await repository.validateReferralCode(code: code);
  }
}
