import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import '../entities/points_balance_entity.dart';
import '../repositories/i_referral_repository.dart';

class GetMyPointsBalanceUseCase {
  final IReferralRepository repository;

  GetMyPointsBalanceUseCase(this.repository);

  Future<Either<Failure, PointsBalanceEntity>> call() async {
    return await repository.getMyPointsBalance();
  }
}
