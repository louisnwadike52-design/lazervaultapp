import 'package:lazervault/src/generated/bulk-sms.pbgrpc.dart' as pb;
import '../../domain/entities/bulk_sms_entities.dart';

/// Maps generated protobuf messages to plain domain entities. Kept in the data
/// layer so no `pb.*` type ever leaks into cubits/screens.
class BulkSmsMappers {
  const BulkSmsMappers._();

  static DateTime? _ts(bool has, dynamic ts) =>
      has ? DateTime.fromMillisecondsSinceEpoch(ts.seconds.toInt() * 1000, isUtc: true) : null;

  static SmsBalanceEntity balance(pb.SmsBalance p) => SmsBalanceEntity(
        creditsRemaining: p.creditsRemaining,
        providerName: p.providerName,
        lastPurchaseAt: _ts(p.hasLastPurchaseAt(), p.lastPurchaseAt),
      );

  static SmsPackageEntity package(pb.SmsPackage p) => SmsPackageEntity(
        id: p.id,
        name: p.name,
        description: p.description,
        creditCount: p.creditCount,
        priceNaira: koboToNaira(p.priceKobo.toInt()),
        currency: p.currency,
        providerName: p.providerName,
        validityDays: p.validityDays,
        isActive: p.isActive,
        isPopular: p.isPopular,
      );

  static SmsProviderEntity provider(pb.SmsProvider p) => SmsProviderEntity(
        id: p.id,
        name: p.name,
        displayName: p.displayName,
        isActive: p.isActive,
        supportsScheduling: p.supportsScheduling,
        supportsUnicode: p.supportsUnicode,
        supportedCountries: p.supportedCountries.toList(),
      );

  static SmsCampaignStatus _campaignStatus(pb.CampaignStatus s) {
    switch (s) {
      case pb.CampaignStatus.CAMPAIGN_STATUS_PENDING:
        return SmsCampaignStatus.pending;
      case pb.CampaignStatus.CAMPAIGN_STATUS_SENDING:
        return SmsCampaignStatus.sending;
      case pb.CampaignStatus.CAMPAIGN_STATUS_COMPLETED:
        return SmsCampaignStatus.completed;
      case pb.CampaignStatus.CAMPAIGN_STATUS_FAILED:
        return SmsCampaignStatus.failed;
      case pb.CampaignStatus.CAMPAIGN_STATUS_SCHEDULED:
        return SmsCampaignStatus.scheduled;
      case pb.CampaignStatus.CAMPAIGN_STATUS_CANCELLED:
        return SmsCampaignStatus.cancelled;
      case pb.CampaignStatus.CAMPAIGN_STATUS_PARTIALLY_COMPLETED:
        return SmsCampaignStatus.partiallyCompleted;
      default:
        return SmsCampaignStatus.unknown;
    }
  }

  static SmsCampaignEntity campaign(pb.SmsCampaign p) => SmsCampaignEntity(
        id: p.id,
        senderId: p.senderId,
        messageTemplate: p.messageTemplate,
        recipientsCount: p.recipientsCount,
        deliveredCount: p.deliveredCount,
        failedCount: p.failedCount,
        dndFilteredCount: p.dndFilteredCount,
        pendingCount: p.pendingCount,
        status: _campaignStatus(p.status),
        costNaira: koboToNaira(p.costKobo.toInt()),
        currency: p.currency,
        reference: p.reference,
        creditsUsed: p.creditsUsed,
        createdAt: _ts(p.hasCreatedAt(), p.createdAt),
        scheduledAt: _ts(p.hasScheduledAt(), p.scheduledAt),
        completedAt: _ts(p.hasCompletedAt(), p.completedAt),
      );

  static SmsDeliveryStatus _deliveryStatus(pb.DeliveryStatus s) {
    switch (s) {
      case pb.DeliveryStatus.DELIVERY_STATUS_PENDING:
        return SmsDeliveryStatus.pending;
      case pb.DeliveryStatus.DELIVERY_STATUS_SENT:
        return SmsDeliveryStatus.sent;
      case pb.DeliveryStatus.DELIVERY_STATUS_DELIVERED:
        return SmsDeliveryStatus.delivered;
      case pb.DeliveryStatus.DELIVERY_STATUS_FAILED:
        return SmsDeliveryStatus.failed;
      case pb.DeliveryStatus.DELIVERY_STATUS_DND_FILTERED:
        return SmsDeliveryStatus.dndFiltered;
      case pb.DeliveryStatus.DELIVERY_STATUS_INVALID_NUMBER:
        return SmsDeliveryStatus.invalidNumber;
      case pb.DeliveryStatus.DELIVERY_STATUS_REJECTED:
        return SmsDeliveryStatus.rejected;
      default:
        return SmsDeliveryStatus.unknown;
    }
  }

  static SmsDeliveryReportEntity report(pb.SmsDeliveryReport p) =>
      SmsDeliveryReportEntity(
        id: p.id,
        campaignId: p.campaignId,
        phoneNumber: p.phoneNumber,
        recipientName: p.recipientName,
        status: _deliveryStatus(p.status),
        failureReason: p.failureReason,
      );

  static SenderIdStatusEnum _senderIdStatus(pb.SenderIdStatus s) {
    switch (s) {
      case pb.SenderIdStatus.SENDER_ID_STATUS_PENDING:
        return SenderIdStatusEnum.pending;
      case pb.SenderIdStatus.SENDER_ID_STATUS_APPROVED:
        return SenderIdStatusEnum.approved;
      case pb.SenderIdStatus.SENDER_ID_STATUS_REJECTED:
        return SenderIdStatusEnum.rejected;
      default:
        return SenderIdStatusEnum.unknown;
    }
  }

  static SenderIdEntity senderId(pb.SenderId p) => SenderIdEntity(
        id: p.id,
        senderId: p.senderId,
        status: _senderIdStatus(p.status),
        country: p.country,
        rejectionReason: p.rejectionReason,
        requestedAt: _ts(p.hasRequestedAt(), p.requestedAt),
        approvedAt: _ts(p.hasApprovedAt(), p.approvedAt),
      );

  static SmsPurchaseResultEntity purchaseResult(
          pb.PurchaseSmsCreditResponse p) =>
      SmsPurchaseResultEntity(
        newCreditBalance: p.newCreditBalance,
        newWalletBalanceNaira: p.newWalletBalance,
        creditsPurchased: p.purchase.creditsPurchased,
        amountNaira: koboToNaira(p.purchase.amountKobo.toInt()),
        reference: p.purchase.reference,
        message: p.message,
      );

  /// Builds a repeated `SmsRecipient` list from domain recipients.
  static List<pb.SmsRecipient> recipients(List<SmsRecipientEntity> list) {
    return list.map((r) {
      final rec = pb.SmsRecipient()
        ..phoneNumber = r.phoneNumber
        ..name = r.name;
      if (r.variables.isNotEmpty) {
        rec.variables.addAll(r.variables);
      }
      return rec;
    }).toList();
  }
}
