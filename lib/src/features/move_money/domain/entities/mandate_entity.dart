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

  /// When this mandate's authorization was last GRANTED (the auth widget's
  /// explicit success callback — SERVER-side stamp via MarkMandateAuthAttempt,
  /// device-independent). Never set on a mere widget open/close.
  final DateTime? authAttemptedAt;
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
    this.authAttemptedAt,
    this.lastDebitAt,
    this.cancelledAt,
    this.reference = '',
    this.description,
    this.switchProcessing = false,
    this.pendingMethod = '',
  });

  /// Whether this mandate is in a usable state for Direct Debit
  bool get isActive =>
      status == MandateStatus.active || status == MandateStatus.readyToDebit;

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

  /// Authorization was GRANTED recently (any device): Mono/NIBSS are
  /// provisioning the mandate and its auth link is SPENT — surfaces must show
  /// "Setting up" + poll, never reopen the link. Without this (and without a
  /// local success stamp) an awaiting mandate renders as plain "One-time".
  bool get authAttemptedRecently =>
      authAttemptedAt != null &&
      DateTime.now().difference(authAttemptedAt!) < const Duration(minutes: 40);

  /// How long a Mono authorization link stays usable.
  ///
  /// Mono does not return an expiry on create, so this is measured from the
  /// only thing we hold: when the mandate was made. Observed live on an ALAT
  /// by WEMA mandate — Mono served the NIBSS activation screen with a
  /// "expires in 29:52" countdown against a mandate created two minutes
  /// earlier, so the window is ~30 minutes. Held slightly under that: a link
  /// wrongly judged stale costs one extra mandate, while one wrongly judged
  /// live dead-ends the user in Mono's "Configuration error" with no way
  /// forward.
  static const Duration authLinkWindow = Duration(minutes: 25);

  /// True when this mandate's authorization link is almost certainly DEAD.
  ///
  /// Reopening it is not a neutral retry: Mono answers "This link is incorrect
  /// or the transaction is already completed", which reads as the user's
  /// mistake and leaves them stuck. A resume in this state must mint a FRESH
  /// mandate instead.
  ///
  /// Deliberately excludes a mandate whose authorization was already granted —
  /// that link is spent for a different reason ([authAttemptedRecently]) and
  /// the right response there is to poll, not to create another mandate.
  bool get authLinkStale =>
      awaitingUserAuthorization &&
      !authAttemptedRecently &&
      DateTime.now().difference(createdAt) > authLinkWindow;

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

  /// Nothing further will happen to this mandate on its own.
  ///
  /// Anything WATCHING a mandate (polling, banners, "setting up" copy) must
  /// stop here. Without it a rejected or expired mandate is indistinguishable
  /// from one still converging, so a watcher waits forever for a state that
  /// can never arrive.
  bool get isTerminal =>
      status == MandateStatus.cancelled ||
      status == MandateStatus.expired ||
      status == MandateStatus.rejected;

  /// Whether the bank side of authorization ever actually completed.
  ///
  /// This is the whole difference between "your Direct Debit stopped working"
  /// and "you never finished setting it up", and it cannot be read off the
  /// status: a mandate abandoned at the Mono sheet and later expired or
  /// cancelled lands in exactly the same terminal status as one that ran for a
  /// year and then lapsed.
  ///
  /// It is not a hypothetical difference. Measured against production on
  /// 2026-10-02, every one of the 14 mandates ever created had
  /// `authorized_at` NULL, `ready_to_debit_at` NULL and `debit_count` 0 — so
  /// every surface that said "re-authorize" was naming something that had
  /// never once happened, to anyone. A user reads "Re-authorize" as "you are
  /// already set up", which is the opposite of what they need to be told.
  ///
  /// Any one of these is proof the bank completed at least once. Statuses are
  /// included because a mandate cannot reach them without authorization, and
  /// they survive even if a timestamp column was missed.
  bool get everAuthorized =>
      authorizedAt != null ||
      readyAt != null ||
      lastDebitAt != null ||
      debitCount > 0 ||
      totalDebited > 0 ||
      status == MandateStatus.authorized ||
      status == MandateStatus.active ||
      status == MandateStatus.readyToDebit ||
      status == MandateStatus.paused;

  /// Dead, and only a fresh authorization can revive it. `isExpired` (a field)
  /// factors the mandate end date; status==expired covers the
  /// reconciler/webhook-driven expiry.
  ///
  /// Branch on THIS to decide whether to prompt, and on [everAuthorized] to
  /// choose the words. Keeping the words off the branch is deliberate: every
  /// caller wants the same prompt in both cases, and only the wording differs.
  bool get needsNewAuthorization =>
      isExpired || status == MandateStatus.expired || isCancelled || isRejected;

  /// A previously-WORKING mandate that can no longer be debited. Only this
  /// case may be described to the user as re-authorizing.
  bool get needsReauthorization => needsNewAuthorization && everAuthorized;

  /// Setup was started but never completed at the bank, and that attempt is
  /// now dead. There is no "re-" for the user to do — they are still finishing
  /// first-time setup, and must be told so.
  bool get setupNeverCompleted => needsNewAuthorization && !everAuthorized;

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
        authorizedAt,
        readyAt,
        lastDebitAt,
        debitCount,
        startDate,
        endDate,
        createdAt,
        switchProcessing,
        pendingMethod,
      ];
}
