import 'package:grpc/grpc.dart';
import '../../../../core/network/grpc_client.dart';
import '../../../../generated/utility-payments.pb.dart' as pb;
import '../../domain/entities/betting_entities.dart';
import '../models/betting_models.dart';

abstract class BettingRemoteDataSource {
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
  Future<List<BettingFundingRecord>> getHistory({int limit, int offset});
  Future<BettingBeneficiary> saveBeneficiary({
    required String platform,
    required String accountUserid,
    required String accountName,
    String? nickname,
    bool isDefault,
  });
  Future<List<BettingBeneficiary>> getBeneficiaries();
  Future<void> deleteBeneficiary(String beneficiaryId);
}

class BettingRemoteDataSourceImpl implements BettingRemoteDataSource {
  final GrpcClient grpcClient;

  BettingRemoteDataSourceImpl({required this.grpcClient});

  @override
  Future<List<BettingPlatform>> getPlatforms() async {
    try {
      final options = await grpcClient.callOptions;
      final response = await grpcClient.utilityPaymentsClient
          .getBettingPlatforms(pb.GetBettingPlatformsRequest(),
              options: options);
      return response.platforms.map(BettingMappers.platform).toList();
    } on GrpcError catch (e) {
      throw Exception('Failed to fetch betting platforms: ${e.message}');
    }
  }

  @override
  Future<BettingAccountVerification> verifyAccount({
    required String platform,
    required String accountUserid,
  }) async {
    try {
      final options = await grpcClient.callOptions;
      final response =
          await grpcClient.utilityPaymentsClient.verifyBettingAccount(
        pb.VerifyBettingAccountRequest()
          ..platform = platform
          ..accountUserid = accountUserid,
        options: options,
      );
      return BettingMappers.verification(response);
    } on GrpcError catch (e) {
      throw Exception('Failed to verify account: ${e.message}');
    }
  }

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
  }) async {
    try {
      final request = pb.InitiateBettingFundingRequest()
        ..platform = platform
        ..accountUserid = accountUserid
        ..accountName = accountName
        ..amount = amount
        ..sourceAccountId = sourceAccountId
        ..phoneNumber = phoneNumber
        ..transactionId = transactionId
        ..verificationToken = verificationToken
        ..idempotencyKey = idempotencyKey
        ..saveBeneficiary = saveBeneficiary;
      if (nickname != null && nickname.isNotEmpty) {
        request.nickname = nickname;
      }

      final options = await grpcClient.callOptions;
      final response = await grpcClient.utilityPaymentsClient
          .initiateBettingFunding(request, options: options);

      return BettingFundingResult(
        payment: BettingMappers.funding(response.payment),
        newBalance: response.newBalance,
        providerReference: response.providerReference,
        message: response.message,
      );
    } on GrpcError catch (e) {
      throw Exception('Failed to fund betting account: ${e.message}');
    }
  }

  @override
  Future<List<BettingFundingRecord>> getHistory(
      {int limit = 20, int offset = 0}) async {
    try {
      final options = await grpcClient.callOptions;
      final response = await grpcClient.utilityPaymentsClient.getBettingHistory(
        pb.GetBettingHistoryRequest()
          ..limit = limit
          ..offset = offset,
        options: options,
      );
      return response.payments.map(BettingMappers.funding).toList();
    } on GrpcError catch (e) {
      throw Exception('Failed to fetch betting history: ${e.message}');
    }
  }

  @override
  Future<BettingBeneficiary> saveBeneficiary({
    required String platform,
    required String accountUserid,
    required String accountName,
    String? nickname,
    bool isDefault = false,
  }) async {
    try {
      final request = pb.SaveBettingBeneficiaryRequest()
        ..platform = platform
        ..accountUserid = accountUserid
        ..accountName = accountName
        ..isDefault = isDefault;
      if (nickname != null && nickname.isNotEmpty) {
        request.nickname = nickname;
      }
      final options = await grpcClient.callOptions;
      final response = await grpcClient.utilityPaymentsClient
          .saveBettingBeneficiary(request, options: options);
      return BettingMappers.beneficiary(response.beneficiary);
    } on GrpcError catch (e) {
      throw Exception('Failed to save account: ${e.message}');
    }
  }

  @override
  Future<List<BettingBeneficiary>> getBeneficiaries() async {
    try {
      final options = await grpcClient.callOptions;
      final response = await grpcClient.utilityPaymentsClient
          .getBettingBeneficiaries(pb.GetBettingBeneficiariesRequest(),
              options: options);
      return response.beneficiaries.map(BettingMappers.beneficiary).toList();
    } on GrpcError catch (e) {
      throw Exception('Failed to fetch saved accounts: ${e.message}');
    }
  }

  @override
  Future<void> deleteBeneficiary(String beneficiaryId) async {
    try {
      final options = await grpcClient.callOptions;
      await grpcClient.utilityPaymentsClient.deleteBettingBeneficiary(
        pb.DeleteBettingBeneficiaryRequest()..beneficiaryId = beneficiaryId,
        options: options,
      );
    } on GrpcError catch (e) {
      throw Exception('Failed to delete account: ${e.message}');
    }
  }
}
