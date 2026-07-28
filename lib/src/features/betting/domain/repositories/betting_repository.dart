import '../entities/betting_entities.dart';

abstract class BettingRepository {
  Future<List<BettingPlatform>> getPlatforms();

  Future<BettingAccountVerification> verifyAccount({
    required String platform,
    required String accountUserid,
  });

  Future<BettingFundingResult> initiateFunding({
    required String platform,
    required String accountUserid,
    required String accountName,
    required double amount,
    required String sourceAccountId,
    required String phoneNumber,
    required String transactionId,
    required String verificationToken,
    required String idempotencyKey,
    required bool saveBeneficiary,
    String? nickname,
  });

  Future<List<BettingFundingRecord>> getHistory({int limit = 20, int offset = 0});

  Future<BettingBeneficiary> saveBeneficiary({
    required String platform,
    required String accountUserid,
    required String accountName,
    String? nickname,
    bool isDefault = false,
  });

  Future<List<BettingBeneficiary>> getBeneficiaries();

  Future<void> deleteBeneficiary(String beneficiaryId);
}
