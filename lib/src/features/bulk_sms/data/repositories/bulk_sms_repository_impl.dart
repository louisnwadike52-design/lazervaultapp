import '../../domain/entities/bulk_sms_entities.dart';
import '../../domain/repositories/bulk_sms_repository.dart';
import '../datasources/bulk_sms_remote_datasource.dart';

class BulkSmsRepositoryImpl implements BulkSmsRepository {
  final BulkSmsRemoteDataSource remoteDataSource;

  BulkSmsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<SmsProviderEntity>> getProviders({String country = 'NG'}) =>
      remoteDataSource.getProviders(country: country);

  @override
  Future<List<SmsPackageEntity>> getPackages({
    String country = 'NG',
    String currency = 'NGN',
  }) =>
      remoteDataSource.getPackages(country: country, currency: currency);

  @override
  Future<SmsBalanceEntity> getBalance({String providerName = ''}) =>
      remoteDataSource.getBalance(providerName: providerName);

  @override
  Future<SmsPurchaseResultEntity> purchaseCredits({
    required String packageId,
    required String providerName,
    required String currency,
    required String transactionId,
    required String verificationToken,
    required String idempotencyKey,
  }) {
    // Money-safety guard: never call the paid RPC without a PIN token.
    if (verificationToken.isEmpty) {
      throw Exception('Verification token is required to purchase SMS credits');
    }
    return remoteDataSource.purchaseCredits(
      packageId: packageId,
      providerName: providerName,
      currency: currency,
      transactionId: transactionId,
      verificationToken: verificationToken,
      idempotencyKey: idempotencyKey,
    );
  }

  @override
  Future<SmsSendResultEntity> sendCampaign({
    required String providerName,
    required String senderId,
    required String messageTemplate,
    required List<SmsRecipientEntity> recipients,
    required String transactionId,
    required String verificationToken,
    required String idempotencyKey,
  }) {
    if (verificationToken.isEmpty) {
      throw Exception('Verification token is required to send a campaign');
    }
    return remoteDataSource.sendBulkSms(
      providerName: providerName,
      senderId: senderId,
      messageTemplate: messageTemplate,
      recipients: recipients,
      transactionId: transactionId,
      verificationToken: verificationToken,
      idempotencyKey: idempotencyKey,
    );
  }

  @override
  Future<SmsSendResultEntity> scheduleCampaign({
    required String providerName,
    required String senderId,
    required String messageTemplate,
    required List<SmsRecipientEntity> recipients,
    required DateTime scheduledAt,
    required String transactionId,
    required String verificationToken,
    required String idempotencyKey,
  }) {
    if (verificationToken.isEmpty) {
      throw Exception('Verification token is required to schedule a campaign');
    }
    return remoteDataSource.scheduleSms(
      providerName: providerName,
      senderId: senderId,
      messageTemplate: messageTemplate,
      recipients: recipients,
      scheduledAt: scheduledAt,
      transactionId: transactionId,
      verificationToken: verificationToken,
      idempotencyKey: idempotencyKey,
    );
  }

  @override
  Future<SmsCancelResultEntity> cancelScheduledSms(String campaignId) =>
      remoteDataSource.cancelScheduledSms(campaignId);

  @override
  Future<SmsCampaignEntity> getCampaignStatus(String campaignId) =>
      remoteDataSource.getCampaignStatus(campaignId);

  @override
  Future<List<SmsDeliveryReportEntity>> getDeliveryReport({
    required String campaignId,
    int page = 1,
    int pageSize = 50,
    String statusFilter = '',
  }) =>
      remoteDataSource.getDeliveryReport(
        campaignId: campaignId,
        page: page,
        pageSize: pageSize,
        statusFilter: statusFilter,
      );

  @override
  Future<List<SmsCampaignEntity>> getHistory({
    int page = 1,
    int pageSize = 20,
    String statusFilter = '',
  }) =>
      remoteDataSource.getHistory(
        page: page,
        pageSize: pageSize,
        statusFilter: statusFilter,
      );

  @override
  Future<List<SenderIdEntity>> getSenderIds() =>
      remoteDataSource.getSenderIds();

  @override
  Future<SenderIdEntity> requestSenderId({
    required String senderId,
    required String country,
    required String purpose,
  }) =>
      remoteDataSource.requestSenderId(
        senderId: senderId,
        country: country,
        purpose: purpose,
      );
}
