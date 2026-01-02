import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import '../entities/country_reward_config_entity.dart';
import '../repositories/i_referral_repository.dart';

class GetCountryRewardConfigUseCase {
  final IReferralRepository repository;

  GetCountryRewardConfigUseCase(this.repository);

  Future<Either<Failure, CountryRewardConfigEntity>> call({
    String? countryCode,
  }) async {
    return await repository.getCountryRewardConfig(
      countryCode: countryCode,
    );
  }
}
