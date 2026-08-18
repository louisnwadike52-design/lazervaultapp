import 'package:equatable/equatable.dart';

/// Plain domain entities for the Bulk SMS feature. These mirror the generated
/// protobuf messages (`bulk-sms.pb.dart`) but keep the presentation layer free
/// of any `pb.*` types — mapping happens in the datasource (see
/// `bulk_sms_mappers.dart`).

/// Kobo → naira. Provider prices and campaign costs are carried in kobo
/// (minor units) on the wire; the UI always renders naira.
double koboToNaira(int kobo) => kobo / 100.0;

/// A user's SMS credit balance for the sticky provider.
class SmsBalanceEntity extends Equatable {
  final int creditsRemaining;
  final String providerName;
  final DateTime? lastPurchaseAt;

  const SmsBalanceEntity({
    required this.creditsRemaining,
    required this.providerName,
    this.lastPurchaseAt,
  });

  @override
  List<Object?> get props => [creditsRemaining, providerName, lastPurchaseAt];
}

/// A purchasable SMS credit package.
class SmsPackageEntity extends Equatable {
  final String id;
  final String name;
  final String description;
  final int creditCount;
  final double priceNaira;
  final String currency;
  final String providerName;
  final int validityDays;
  final bool isActive;
  final bool isPopular;

  const SmsPackageEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.creditCount,
    required this.priceNaira,
    required this.currency,
    required this.providerName,
    required this.validityDays,
    required this.isActive,
    required this.isPopular,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        creditCount,
        priceNaira,
        currency,
        providerName,
        validityDays,
        isActive,
        isPopular,
      ];
}

/// An available SMS provider (Termii primary, Africa's Talking fallback).
class SmsProviderEntity extends Equatable {
  final String id;
  final String name;
  final String displayName;
  final bool isActive;
  final bool supportsScheduling;
  final bool supportsUnicode;
  final List<String> supportedCountries;

  const SmsProviderEntity({
    required this.id,
    required this.name,
    required this.displayName,
    required this.isActive,
    required this.supportsScheduling,
    required this.supportsUnicode,
    required this.supportedCountries,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        displayName,
        isActive,
        supportsScheduling,
        supportsUnicode,
        supportedCountries,
      ];
}

/// One recipient of a bulk SMS campaign. `variables` back the `{{key}}`
/// merge-fields in the message template.
class SmsRecipientEntity extends Equatable {
  final String phoneNumber;
  final String name;
  final Map<String, String> variables;

  const SmsRecipientEntity({
    required this.phoneNumber,
    this.name = '',
    this.variables = const {},
  });

  @override
  List<Object?> get props => [phoneNumber, name, variables];
}

/// Lifecycle status of a campaign, decoupled from the pb enum.
enum SmsCampaignStatus {
  pending,
  sending,
  completed,
  failed,
  scheduled,
  cancelled,
  partiallyCompleted,
  unknown,
}

extension SmsCampaignStatusX on SmsCampaignStatus {
  String get label => switch (this) {
        SmsCampaignStatus.pending => 'Pending',
        SmsCampaignStatus.sending => 'Sending',
        SmsCampaignStatus.completed => 'Completed',
        SmsCampaignStatus.failed => 'Failed',
        SmsCampaignStatus.scheduled => 'Scheduled',
        SmsCampaignStatus.cancelled => 'Cancelled',
        SmsCampaignStatus.partiallyCompleted => 'Partially sent',
        SmsCampaignStatus.unknown => 'Processing',
      };

  bool get isScheduled => this == SmsCampaignStatus.scheduled;
  bool get isTerminal =>
      this == SmsCampaignStatus.completed ||
      this == SmsCampaignStatus.failed ||
      this == SmsCampaignStatus.cancelled ||
      this == SmsCampaignStatus.partiallyCompleted;
}

/// A bulk SMS campaign (sent or scheduled).
class SmsCampaignEntity extends Equatable {
  final String id;
  final String senderId;
  final String messageTemplate;
  final int recipientsCount;
  final int deliveredCount;
  final int failedCount;
  final int dndFilteredCount;
  final int pendingCount;
  final SmsCampaignStatus status;
  final double costNaira;
  final String currency;
  final String reference;
  final int creditsUsed;
  final DateTime? createdAt;
  final DateTime? scheduledAt;
  final DateTime? completedAt;

  const SmsCampaignEntity({
    required this.id,
    required this.senderId,
    required this.messageTemplate,
    required this.recipientsCount,
    required this.deliveredCount,
    required this.failedCount,
    required this.dndFilteredCount,
    required this.pendingCount,
    required this.status,
    required this.costNaira,
    required this.currency,
    required this.reference,
    required this.creditsUsed,
    this.createdAt,
    this.scheduledAt,
    this.completedAt,
  });

  @override
  List<Object?> get props => [
        id,
        senderId,
        messageTemplate,
        recipientsCount,
        deliveredCount,
        failedCount,
        dndFilteredCount,
        pendingCount,
        status,
        costNaira,
        currency,
        reference,
        creditsUsed,
        createdAt,
        scheduledAt,
        completedAt,
      ];
}

/// Per-recipient delivery outcome within a campaign.
enum SmsDeliveryStatus {
  pending,
  sent,
  delivered,
  failed,
  dndFiltered,
  invalidNumber,
  rejected,
  unknown,
}

extension SmsDeliveryStatusX on SmsDeliveryStatus {
  String get label => switch (this) {
        SmsDeliveryStatus.pending => 'Pending',
        SmsDeliveryStatus.sent => 'Sent',
        SmsDeliveryStatus.delivered => 'Delivered',
        SmsDeliveryStatus.failed => 'Failed',
        SmsDeliveryStatus.dndFiltered => 'DND blocked',
        SmsDeliveryStatus.invalidNumber => 'Invalid number',
        SmsDeliveryStatus.rejected => 'Rejected',
        SmsDeliveryStatus.unknown => 'Processing',
      };
}

/// A single line in a campaign's delivery report.
class SmsDeliveryReportEntity extends Equatable {
  final String id;
  final String campaignId;
  final String phoneNumber;
  final String recipientName;
  final SmsDeliveryStatus status;
  final String failureReason;

  const SmsDeliveryReportEntity({
    required this.id,
    required this.campaignId,
    required this.phoneNumber,
    required this.recipientName,
    required this.status,
    required this.failureReason,
  });

  @override
  List<Object?> get props =>
      [id, campaignId, phoneNumber, recipientName, status, failureReason];
}

/// Registration status of a sender ID.
enum SenderIdStatusEnum { pending, approved, rejected, unknown }

extension SenderIdStatusEnumX on SenderIdStatusEnum {
  String get label => switch (this) {
        SenderIdStatusEnum.pending => 'Pending review',
        SenderIdStatusEnum.approved => 'Approved',
        SenderIdStatusEnum.rejected => 'Rejected',
        SenderIdStatusEnum.unknown => 'Unknown',
      };

  bool get isApproved => this == SenderIdStatusEnum.approved;
  bool get isPending => this == SenderIdStatusEnum.pending;
}

/// A registered / requested sender ID.
class SenderIdEntity extends Equatable {
  final String id;
  final String senderId;
  final SenderIdStatusEnum status;
  final String country;
  final String rejectionReason;
  final DateTime? requestedAt;
  final DateTime? approvedAt;

  const SenderIdEntity({
    required this.id,
    required this.senderId,
    required this.status,
    required this.country,
    required this.rejectionReason,
    this.requestedAt,
    this.approvedAt,
  });

  @override
  List<Object?> get props =>
      [id, senderId, status, country, rejectionReason, requestedAt, approvedAt];
}

/// Result of purchasing SMS credits.
class SmsPurchaseResultEntity extends Equatable {
  final int newCreditBalance;
  final double newWalletBalanceNaira;
  final int creditsPurchased;
  final double amountNaira;
  final String reference;
  final String message;

  const SmsPurchaseResultEntity({
    required this.newCreditBalance,
    required this.newWalletBalanceNaira,
    required this.creditsPurchased,
    required this.amountNaira,
    required this.reference,
    required this.message,
  });

  @override
  List<Object?> get props => [
        newCreditBalance,
        newWalletBalanceNaira,
        creditsPurchased,
        amountNaira,
        reference,
        message,
      ];
}

/// Result of sending or scheduling a bulk SMS campaign.
class SmsSendResultEntity extends Equatable {
  final SmsCampaignEntity campaign;
  final int newCreditBalance;
  final String message;

  const SmsSendResultEntity({
    required this.campaign,
    required this.newCreditBalance,
    required this.message,
  });

  @override
  List<Object?> get props => [campaign, newCreditBalance, message];
}

/// Result of cancelling a scheduled campaign.
class SmsCancelResultEntity extends Equatable {
  final bool success;
  final int creditsRefunded;
  final int newCreditBalance;
  final String message;

  const SmsCancelResultEntity({
    required this.success,
    required this.creditsRefunded,
    required this.newCreditBalance,
    required this.message,
  });

  @override
  List<Object?> get props =>
      [success, creditsRefunded, newCreditBalance, message];
}
