import 'package:equatable/equatable.dart';

enum MandateType { emandate, gsm, signed }

enum MandateStatus {
  pending,
  awaitingAuthorization,
  authorized,
  active,
  readyToDebit,
  paused,
  cancelled,
  expired,
  rejected,
}

MandateStatus mandateStatusFromString(String status) {
  switch (status.toLowerCase().replaceAll('_', '')) {
    case 'pending':
      return MandateStatus.pending;
    case 'awaitingauthorization':
      return MandateStatus.awaitingAuthorization;
    case 'authorized':
      return MandateStatus.authorized;
    case 'active':
      return MandateStatus.active;
    case 'readytodebit':
      return MandateStatus.readyToDebit;
    case 'paused':
      return MandateStatus.paused;
    case 'cancelled':
      return MandateStatus.cancelled;
    case 'expired':
      return MandateStatus.expired;
    case 'rejected':
      return MandateStatus.rejected;
    default:
      return MandateStatus.pending;
  }
}

MandateType mandateTypeFromString(String type) {
  switch (type.toLowerCase().replaceAll('_', '').replaceAll('-', '')) {
    case 'emandate':
      return MandateType.emandate;
    case 'gsm':
      return MandateType.gsm;
    case 'signed':
      return MandateType.signed;
    default:
      return MandateType.gsm;
  }
}

class MandateEntity extends Equatable {
  final String id;
  final String monoMandateId;
  final String userId;
  final String linkedAccountId;
  final String monoCustomerId;
  final String bankName;
  final String bankCode;
  final String accountNumber;
  final String accountName;
  final MandateType mandateType;
  final MandateStatus status;
  final int amountLimit; // kobo, 0 = unlimited
  final int debitLimit;
  final int debitCount;
  final int totalDebited; // kobo
  final int remainingLimit; // kobo
  final bool canDebit;
  final bool isExpired;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime createdAt;
  final DateTime? authorizedAt;
  final DateTime? readyAt;
  final DateTime? lastDebitAt;
  final DateTime? cancelledAt;
  final String reference;
  final String? description;

  /// A deposit-method switch (Direct Debit ⇄ one-time DirectPay) has been
  /// requested but Mono hasn't confirmed it yet — render as a "Switching…" state.
  final bool switchProcessing;

  /// The method the in-flight switch is moving TO: "direct_debit" / "one_time" / "".
  final String pendingMethod;

  const MandateEntity({
    required this.id,
    required this.monoMandateId,
    required this.userId,
    required this.linkedAccountId,
    this.monoCustomerId = '',
    this.bankName = '',
    this.bankCode = '',
    this.accountNumber = '',
    this.accountName = '',
    this.mandateType = MandateType.gsm,
    required this.status,
    this.amountLimit = 0,
    this.debitLimit = 0,
    this.debitCount = 0,
    this.totalDebited = 0,
    this.remainingLimit = 0,
    this.canDebit = false,
    this.isExpired = false,
    required this.startDate,
    required this.endDate,
    required this.createdAt,
    this.authorizedAt,
    this.readyAt,
    this.lastDebitAt,
    this.cancelledAt,
    this.reference = '',
    this.description,
    this.switchProcessing = false,
    this.pendingMethod = '',
  });

  /// Whether this mandate is in a usable state for Direct Debit
  bool get isActive =>
      status == MandateStatus.active ||
      status == MandateStatus.readyToDebit;

  /// "Setting up" — the USER has finished their part (authorized at their bank)
  /// and only NIBSS / bank-side activation is left before it becomes debitable.
  /// NOT awaiting_authorization/pending: those mean the user still has to
  /// authorize (e.g. they cancelled the Mono sheet), which is not "setting up".
  bool get isActivating => status == MandateStatus.authorized;

  /// The mandate exists but the USER hasn't authorized it yet (created, or the
  /// auth sheet was cancelled). Direct Debit is not set up — the account behaves
  /// as one-time until the user authorizes (resumable via "Switch to Direct Debit").
  bool get awaitingUserAuthorization =>
      status == MandateStatus.awaitingAuthorization ||
      status == MandateStatus.pending;

  /// Temporarily paused by the user — reinstate to use again.
  bool get isPaused => status == MandateStatus.paused;

  /// A switch TO Direct Debit is awaiting Mono confirmation.
  bool get isSwitchingToDirectDebit =>
      switchProcessing && pendingMethod == 'direct_debit';

  /// A switch TO one-time DirectPay is awaiting Mono confirmation.
  bool get isSwitchingToOneTime =>
      switchProcessing && pendingMethod == 'one_time';

  bool get isCancelled => status == MandateStatus.cancelled;

  bool get isRejected => status == MandateStatus.rejected;

  /// A previously-set-up mandate that can no longer be debited and needs a brand
  /// new authorization. `isExpired` (a field) factors the mandate end date;
  /// status==expired covers the reconciler/webhook-driven expiry.
  bool get needsReauthorization =>
      isExpired || status == MandateStatus.expired || isCancelled || isRejected;

  @override
  List<Object?> get props => [
        id,
        monoMandateId,
        userId,
        linkedAccountId,
        status,
        amountLimit,
        totalDebited,
        remainingLimit,
        canDebit,
        isExpired,
        startDate,
        endDate,
        createdAt,
        switchProcessing,
        pendingMethod,
      ];
}
