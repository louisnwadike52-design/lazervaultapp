import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import '../entities/referral_code_entity.dart';
import '../repositories/i_referral_repository.dart';

class GetMyReferralCodeUseCase {
  final IReferralRepository repository;

  GetMyReferralCodeUseCase(this.repository);

  Future<Either<Failure, ReferralCodeEntity>> call() async {
    return await repository.getMyReferralCode();
  }
}
