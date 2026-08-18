import 'package:equatable/equatable.dart';
import '../../domain/entities/bulk_sms_entities.dart';

// Re-export the entities so screens can import the state file alone.
export '../../domain/entities/bulk_sms_entities.dart';

/// Load lifecycle for a read-only section (balance, packages, history, …).
enum SectionStatus { initial, loading, loaded, error }

/// Action lifecycle for a mutation (buy credits, send/schedule, request id).
enum ActionStatus { idle, processing, success, failed }

/// A single immutable state carrying every Bulk-SMS section. The landing screen
/// shows balance + history + sender-IDs together, so a single-state cubit is
/// used (instead of many mutually-exclusive state classes) to avoid one
/// section's load clobbering another's data.
class BulkSmsState extends Equatable {
  // ── Providers (sticky routing) ─────────────────────────────────────
  final SectionStatus providersStatus;
  final List<SmsProviderEntity> providers;

  // ── Credit balance ─────────────────────────────────────────────────
  final SectionStatus balanceStatus;
  final SmsBalanceEntity? balance;

  // ── Packages ───────────────────────────────────────────────────────
  final SectionStatus packagesStatus;
  final List<SmsPackageEntity> packages;

  // ── Sender IDs ─────────────────────────────────────────────────────
  final SectionStatus senderIdsStatus;
  final List<SenderIdEntity> senderIds;

  // ── History (campaigns) ────────────────────────────────────────────
  final SectionStatus historyStatus;
  final List<SmsCampaignEntity> history;

  // ── Campaign detail ────────────────────────────────────────────────
  final SectionStatus campaignStatus;
  final SmsCampaignEntity? campaign;

  // ── Delivery report ────────────────────────────────────────────────
  final SectionStatus reportStatus;
  final List<SmsDeliveryReportEntity> reports;

  // ── Buy-credits action ─────────────────────────────────────────────
  final ActionStatus purchaseStatus;
  final SmsPurchaseResultEntity? purchaseResult;

  // ── Send / schedule action ─────────────────────────────────────────
  final ActionStatus sendStatus;
  final SmsSendResultEntity? sendResult;
  final bool lastSendWasScheduled;

  // ── Cancel scheduled action ────────────────────────────────────────
  final ActionStatus cancelStatus;
  final SmsCancelResultEntity? cancelResult;

  // ── Request sender-ID action ───────────────────────────────────────
  final ActionStatus senderIdRequestStatus;
  final SenderIdEntity? requestedSenderId;

  // ── Saved recipient groups ─────────────────────────────────────────
  final SectionStatus groupsStatus;
  final List<BulkSmsGroup> groups;
  final ActionStatus groupActionStatus;

  /// Last user-facing error (set alongside any *error / *failed status).
  final String? errorMessage;

  const BulkSmsState({
    this.providersStatus = SectionStatus.initial,
    this.providers = const [],
    this.balanceStatus = SectionStatus.initial,
    this.balance,
    this.packagesStatus = SectionStatus.initial,
    this.packages = const [],
    this.senderIdsStatus = SectionStatus.initial,
    this.senderIds = const [],
    this.historyStatus = SectionStatus.initial,
    this.history = const [],
    this.campaignStatus = SectionStatus.initial,
    this.campaign,
    this.reportStatus = SectionStatus.initial,
    this.reports = const [],
    this.purchaseStatus = ActionStatus.idle,
    this.purchaseResult,
    this.sendStatus = ActionStatus.idle,
    this.sendResult,
    this.lastSendWasScheduled = false,
    this.cancelStatus = ActionStatus.idle,
    this.cancelResult,
    this.senderIdRequestStatus = ActionStatus.idle,
    this.requestedSenderId,
    this.groupsStatus = SectionStatus.initial,
    this.groups = const [],
    this.groupActionStatus = ActionStatus.idle,
    this.errorMessage,
  });

  BulkSmsState copyWith({
    SectionStatus? providersStatus,
    List<SmsProviderEntity>? providers,
    SectionStatus? balanceStatus,
    SmsBalanceEntity? balance,
    SectionStatus? packagesStatus,
    List<SmsPackageEntity>? packages,
    SectionStatus? senderIdsStatus,
    List<SenderIdEntity>? senderIds,
    SectionStatus? historyStatus,
    List<SmsCampaignEntity>? history,
    SectionStatus? campaignStatus,
    SmsCampaignEntity? campaign,
    SectionStatus? reportStatus,
    List<SmsDeliveryReportEntity>? reports,
    ActionStatus? purchaseStatus,
    SmsPurchaseResultEntity? purchaseResult,
    ActionStatus? sendStatus,
    SmsSendResultEntity? sendResult,
    bool? lastSendWasScheduled,
    ActionStatus? cancelStatus,
    SmsCancelResultEntity? cancelResult,
    ActionStatus? senderIdRequestStatus,
    SenderIdEntity? requestedSenderId,
    SectionStatus? groupsStatus,
    List<BulkSmsGroup>? groups,
    ActionStatus? groupActionStatus,
    String? errorMessage,
  }) {
    return BulkSmsState(
      providersStatus: providersStatus ?? this.providersStatus,
      providers: providers ?? this.providers,
      balanceStatus: balanceStatus ?? this.balanceStatus,
      balance: balance ?? this.balance,
      packagesStatus: packagesStatus ?? this.packagesStatus,
      packages: packages ?? this.packages,
      senderIdsStatus: senderIdsStatus ?? this.senderIdsStatus,
      senderIds: senderIds ?? this.senderIds,
      historyStatus: historyStatus ?? this.historyStatus,
      history: history ?? this.history,
      campaignStatus: campaignStatus ?? this.campaignStatus,
      campaign: campaign ?? this.campaign,
      reportStatus: reportStatus ?? this.reportStatus,
      reports: reports ?? this.reports,
      purchaseStatus: purchaseStatus ?? this.purchaseStatus,
      purchaseResult: purchaseResult ?? this.purchaseResult,
      sendStatus: sendStatus ?? this.sendStatus,
      sendResult: sendResult ?? this.sendResult,
      lastSendWasScheduled: lastSendWasScheduled ?? this.lastSendWasScheduled,
      cancelStatus: cancelStatus ?? this.cancelStatus,
      cancelResult: cancelResult ?? this.cancelResult,
      senderIdRequestStatus:
          senderIdRequestStatus ?? this.senderIdRequestStatus,
      requestedSenderId: requestedSenderId ?? this.requestedSenderId,
      groupsStatus: groupsStatus ?? this.groupsStatus,
      groups: groups ?? this.groups,
      groupActionStatus: groupActionStatus ?? this.groupActionStatus,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        providersStatus,
        providers,
        balanceStatus,
        balance,
        packagesStatus,
        packages,
        senderIdsStatus,
        senderIds,
        historyStatus,
        history,
        campaignStatus,
        campaign,
        reportStatus,
        reports,
        purchaseStatus,
        purchaseResult,
        sendStatus,
        sendResult,
        lastSendWasScheduled,
        cancelStatus,
        cancelResult,
        senderIdRequestStatus,
        requestedSenderId,
        groupsStatus,
        groups,
        groupActionStatus,
        errorMessage,
      ];
}
