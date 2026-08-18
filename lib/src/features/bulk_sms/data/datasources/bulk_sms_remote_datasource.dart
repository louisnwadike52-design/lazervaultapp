import 'package:grpc/grpc.dart';
import 'package:lazervault/src/generated/bulk-sms.pbgrpc.dart' as pb;
import 'package:lazervault/src/generated/google/protobuf/timestamp.pb.dart'
    as timestamppb;
import '../../../../core/network/grpc_client.dart';
import '../../domain/entities/bulk_sms_entities.dart';
import '../models/bulk_sms_mappers.dart';

/// Talks to `bulk-sms-service` behind the Commerce Gateway. Every call uses the
/// commerce `GrpcClient` (injected) and its auth-stamped `callOptions`, mapping
/// the generated responses to plain domain entities.
abstract class BulkSmsRemoteDataSource {
  Future<List<SmsProviderEntity>> getProviders({String country});
  Future<List<SmsPackageEntity>> getPackages({String country, String currency});
  Future<SmsBalanceEntity> getBalance({String providerName});
  Future<SmsPurchaseResultEntity> purchaseCredits({
    required String packageId,
    required String providerName,
    required String idempotencyKey,
    required String transactionId,
    required String verificationToken,
    required String currency,
  });
  Future<SmsSendResultEntity> sendBulkSms({
    required String providerName,
    required String senderId,
    required String messageTemplate,
    required List<SmsRecipientEntity> recipients,
    required String idempotencyKey,
    required String transactionId,
    required String verificationToken,
  });
  Future<SmsSendResultEntity> scheduleSms({
    required String providerName,
    required String senderId,
    required String messageTemplate,
    required List<SmsRecipientEntity> recipients,
    required DateTime scheduledAt,
    required String idempotencyKey,
    required String transactionId,
    required String verificationToken,
  });
  Future<SmsCancelResultEntity> cancelScheduledSms(String campaignId);
  Future<SmsCampaignEntity> getCampaignStatus(String campaignId);
  Future<List<SmsDeliveryReportEntity>> getDeliveryReport({
    required String campaignId,
    int page,
    int pageSize,
    String statusFilter,
  });
  Future<List<SmsCampaignEntity>> getHistory({
    int page,
    int pageSize,
    String statusFilter,
  });
  Future<List<SenderIdEntity>> getSenderIds();
  Future<SenderIdEntity> requestSenderId({
    required String senderId,
    required String country,
    required String purpose,
  });
}

class BulkSmsRemoteDataSourceImpl implements BulkSmsRemoteDataSource {
  final GrpcClient grpcClient;

  BulkSmsRemoteDataSourceImpl({required this.grpcClient});

  @override
  Future<List<SmsProviderEntity>> getProviders({String country = 'NG'}) async {
    try {
      final req = pb.GetSmsProvidersRequest()..country = country;
      final res = await grpcClient.bulkSmsClient
          .getSmsProviders(req, options: await grpcClient.callOptions);
      return res.providers.map(BulkSmsMappers.provider).toList();
    } on GrpcError catch (e) {
      throw Exception('Failed to fetch SMS providers: ${e.message}');
    }
  }

  @override
  Future<List<SmsPackageEntity>> getPackages({
    String country = 'NG',
    String currency = 'NGN',
  }) async {
    try {
      final req = pb.GetSmsPackagesRequest()
        ..country = country
        ..currency = currency;
      final res = await grpcClient.bulkSmsClient
          .getSmsPackages(req, options: await grpcClient.callOptions);
      return res.packages.map(BulkSmsMappers.package).toList();
    } on GrpcError catch (e) {
      throw Exception('Failed to fetch SMS packages: ${e.message}');
    }
  }

  @override
  Future<SmsBalanceEntity> getBalance({String providerName = ''}) async {
    // GetSmsBalanceRequest carries no fields — the backend returns balances for
    // every provider; we surface the sticky/first one.
    try {
      final req = pb.GetSmsBalanceRequest();
      final res = await grpcClient.bulkSmsClient
          .getSmsBalance(req, options: await grpcClient.callOptions);
      if (res.balances.isEmpty) {
        return const SmsBalanceEntity(creditsRemaining: 0, providerName: '');
      }
      return BulkSmsMappers.balance(res.balances.first);
    } on GrpcError catch (e) {
      throw Exception('Failed to fetch SMS balance: ${e.message}');
    }
  }

  @override
  Future<SmsPurchaseResultEntity> purchaseCredits({
    required String packageId,
    required String providerName,
    required String idempotencyKey,
    required String transactionId,
    required String verificationToken,
    required String currency,
  }) async {
    try {
      final req = pb.PurchaseSmsCreditRequest()
        ..packageId = packageId
        ..providerName = providerName
        ..idempotencyKey = idempotencyKey
        ..transactionId = transactionId
        ..verificationToken = verificationToken
        ..currency = currency;
      final res = await grpcClient.bulkSmsClient
          .purchaseSmsCredits(req, options: await grpcClient.callOptions);
      return BulkSmsMappers.purchaseResult(res);
    } on GrpcError catch (e) {
      throw Exception('Failed to purchase SMS credits: ${e.message}');
    }
  }

  @override
  Future<SmsSendResultEntity> sendBulkSms({
    required String providerName,
    required String senderId,
    required String messageTemplate,
    required List<SmsRecipientEntity> recipients,
    required String idempotencyKey,
    required String transactionId,
    required String verificationToken,
  }) async {
    try {
      final req = pb.SendBulkSmsRequest()
        ..providerName = providerName
        ..senderId = senderId
        ..messageTemplate = messageTemplate
        ..idempotencyKey = idempotencyKey
        ..transactionId = transactionId
        ..verificationToken = verificationToken
        ..recipients.addAll(BulkSmsMappers.recipients(recipients));
      final res = await grpcClient.bulkSmsClient
          .sendBulkSms(req, options: await grpcClient.callOptions);
      return SmsSendResultEntity(
        campaign: BulkSmsMappers.campaign(res.campaign),
        newCreditBalance: res.newCreditBalance,
        message: res.message,
      );
    } on GrpcError catch (e) {
      throw Exception('Failed to send bulk SMS: ${e.message}');
    }
  }

  @override
  Future<SmsSendResultEntity> scheduleSms({
    required String providerName,
    required String senderId,
    required String messageTemplate,
    required List<SmsRecipientEntity> recipients,
    required DateTime scheduledAt,
    required String idempotencyKey,
    required String transactionId,
    required String verificationToken,
  }) async {
    try {
      final req = pb.ScheduleSmsRequest()
        ..providerName = providerName
        ..senderId = senderId
        ..messageTemplate = messageTemplate
        ..idempotencyKey = idempotencyKey
        ..transactionId = transactionId
        ..verificationToken = verificationToken
        ..scheduledAt = timestamppb.Timestamp.fromDateTime(scheduledAt.toUtc())
        ..recipients.addAll(BulkSmsMappers.recipients(recipients));
      final res = await grpcClient.bulkSmsClient
          .scheduleSms(req, options: await grpcClient.callOptions);
      return SmsSendResultEntity(
        campaign: BulkSmsMappers.campaign(res.campaign),
        newCreditBalance: res.newCreditBalance,
        message: res.message,
      );
    } on GrpcError catch (e) {
      throw Exception('Failed to schedule bulk SMS: ${e.message}');
    }
  }

  @override
  Future<SmsCancelResultEntity> cancelScheduledSms(String campaignId) async {
    try {
      final req = pb.CancelScheduledSmsRequest()..campaignId = campaignId;
      final res = await grpcClient.bulkSmsClient
          .cancelScheduledSms(req, options: await grpcClient.callOptions);
      return SmsCancelResultEntity(
        success: res.success,
        creditsRefunded: res.creditsRefunded,
        newCreditBalance: res.newCreditBalance,
        message: res.message,
      );
    } on GrpcError catch (e) {
      throw Exception('Failed to cancel scheduled SMS: ${e.message}');
    }
  }

  @override
  Future<SmsCampaignEntity> getCampaignStatus(String campaignId) async {
    try {
      final req = pb.GetSmsCampaignStatusRequest()..campaignId = campaignId;
      final res = await grpcClient.bulkSmsClient
          .getSmsCampaignStatus(req, options: await grpcClient.callOptions);
      return BulkSmsMappers.campaign(res.campaign);
    } on GrpcError catch (e) {
      throw Exception('Failed to fetch campaign status: ${e.message}');
    }
  }

  @override
  Future<List<SmsDeliveryReportEntity>> getDeliveryReport({
    required String campaignId,
    int page = 1,
    int pageSize = 50,
    String statusFilter = '',
  }) async {
    try {
      final req = pb.GetDeliveryReportRequest()
        ..campaignId = campaignId
        ..page = page
        ..pageSize = pageSize;
      if (statusFilter.isNotEmpty) req.statusFilter = statusFilter;
      final res = await grpcClient.bulkSmsClient
          .getDeliveryReport(req, options: await grpcClient.callOptions);
      return res.reports.map(BulkSmsMappers.report).toList();
    } on GrpcError catch (e) {
      throw Exception('Failed to fetch delivery report: ${e.message}');
    }
  }

  @override
  Future<List<SmsCampaignEntity>> getHistory({
    int page = 1,
    int pageSize = 20,
    String statusFilter = '',
  }) async {
    try {
      final req = pb.GetSmsHistoryRequest()
        ..page = page
        ..pageSize = pageSize;
      if (statusFilter.isNotEmpty) req.statusFilter = statusFilter;
      final res = await grpcClient.bulkSmsClient
          .getSmsHistory(req, options: await grpcClient.callOptions);
      return res.campaigns.map(BulkSmsMappers.campaign).toList();
    } on GrpcError catch (e) {
      throw Exception('Failed to fetch SMS history: ${e.message}');
    }
  }

  @override
  Future<List<SenderIdEntity>> getSenderIds() async {
    try {
      final res = await grpcClient.bulkSmsClient.getSenderIds(
          pb.GetSenderIdsRequest(),
          options: await grpcClient.callOptions);
      return res.senderIds.map(BulkSmsMappers.senderId).toList();
    } on GrpcError catch (e) {
      throw Exception('Failed to fetch sender IDs: ${e.message}');
    }
  }

  @override
  Future<SenderIdEntity> requestSenderId({
    required String senderId,
    required String country,
    required String purpose,
  }) async {
    try {
      final req = pb.RequestSenderIdRequest()
        ..senderId = senderId
        ..country = country
        ..purpose = purpose;
      final res = await grpcClient.bulkSmsClient
          .requestSenderId(req, options: await grpcClient.callOptions);
      return BulkSmsMappers.senderId(res.senderId);
    } on GrpcError catch (e) {
      throw Exception('Failed to request sender ID: ${e.message}');
    }
  }
}
