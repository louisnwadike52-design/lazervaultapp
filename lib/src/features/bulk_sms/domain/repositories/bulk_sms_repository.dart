import '../entities/bulk_sms_entities.dart';

/// Contract for the Bulk SMS feature. Implemented over gRPC by
/// `BulkSmsRepositoryImpl`.
abstract class BulkSmsRepository {
  Future<List<SmsProviderEntity>> getProviders({String country});
  Future<List<SmsPackageEntity>> getPackages({String country, String currency});
  Future<SmsBalanceEntity> getBalance({String providerName});

  /// Money move — requires a PIN-derived [verificationToken].
  Future<SmsPurchaseResultEntity> purchaseCredits({
    required String packageId,
    required String providerName,
    required String currency,
    required String transactionId,
    required String verificationToken,
    required String idempotencyKey,
  });

  /// Money move (consumes credits) — requires a PIN-derived [verificationToken].
  Future<SmsSendResultEntity> sendCampaign({
    required String providerName,
    required String senderId,
    required String messageTemplate,
    required List<SmsRecipientEntity> recipients,
    required String transactionId,
    required String verificationToken,
    required String idempotencyKey,
  });

  /// Money move (reserves credits) — requires a PIN-derived [verificationToken].
  Future<SmsSendResultEntity> scheduleCampaign({
    required String providerName,
    required String senderId,
    required String messageTemplate,
    required List<SmsRecipientEntity> recipients,
    required DateTime scheduledAt,
    required String transactionId,
    required String verificationToken,
    required String idempotencyKey,
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
