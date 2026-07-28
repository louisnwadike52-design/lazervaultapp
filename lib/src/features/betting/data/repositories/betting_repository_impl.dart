import '../../domain/entities/betting_entities.dart';
import '../../domain/repositories/betting_repository.dart';
import '../datasources/betting_remote_datasource.dart';

class BettingRepositoryImpl implements BettingRepository {
  final BettingRemoteDataSource remoteDataSource;

  BettingRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<BettingPlatform>> getPlatforms() =>
      remoteDataSource.getPlatforms();

  @override
  Future<BettingAccountVerification> verifyAccount({
    required String platform,
    required String accountUserid,
  }) =>
      remoteDataSource.verifyAccount(
        platform: platform,
        accountUserid: accountUserid,
      );

  @override
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
  }) =>
      remoteDataSource.initiateFunding(
        platform: platform,
        accountUserid: accountUserid,
        accountName: accountName,
        amount: amount,
        sourceAccountId: sourceAccountId,
        phoneNumber: phoneNumber,
        transactionId: transactionId,
        verificationToken: verificationToken,
        idempotencyKey: idempotencyKey,
        saveBeneficiary: saveBeneficiary,
        nickname: nickname,
      );

  @override
  Future<List<BettingFundingRecord>> getHistory(
          {int limit = 20, int offset = 0}) =>
      remoteDataSource.getHistory(limit: limit, offset: offset);

  @override
  Future<BettingBeneficiary> saveBeneficiary({
    required String platform,
    required String accountUserid,
    required String accountName,
    String? nickname,
    bool isDefault = false,
  }) =>
      remoteDataSource.saveBeneficiary(
        platform: platform,
        accountUserid: accountUserid,
        accountName: accountName,
        nickname: nickname,
        isDefault: isDefault,
      );

  @override
  Future<List<BettingBeneficiary>> getBeneficiaries() =>
      remoteDataSource.getBeneficiaries();

  @override
  Future<void> deleteBeneficiary(String beneficiaryId) =>
      remoteDataSource.deleteBeneficiary(beneficiaryId);
}
