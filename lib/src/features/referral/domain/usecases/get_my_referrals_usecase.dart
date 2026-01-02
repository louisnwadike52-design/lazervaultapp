import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import '../entities/referral_transaction_entity.dart';
import '../repositories/i_referral_repository.dart';

class GetMyReferralsUseCase {
  final IReferralRepository repository;

  GetMyReferralsUseCase(this.repository);

  Future<Either<Failure, List<ReferralTransactionEntity>>> call({
    int page = 1,
    int pageSize = 20,
  }) async {
    return await repository.getMyReferrals(
      page: page,
      pageSize: pageSize,
    );
  }
}
