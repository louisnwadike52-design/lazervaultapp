import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import '../entities/point_transaction_entity.dart';
import '../repositories/i_referral_repository.dart';

class GetMyPointsHistoryUseCase {
  final IReferralRepository repository;

  GetMyPointsHistoryUseCase(this.repository);

  Future<Either<Failure, List<PointTransactionEntity>>> call({
    int page = 1,
    int pageSize = 20,
  }) async {
    return await repository.getMyPointsHistory(page: page, pageSize: pageSize);
  }
}
