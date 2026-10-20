part of 'group_entities.dart';

// Contribution entity with enhanced scheduling and payout features
class Contribution extends Equatable {
  final String id;
  final String groupId;
  final String title;
  final String description;
  final double targetAmount;
  final double currentAmount;

  /// What this cycle has RAISED, as opposed to what is in the pot now.
  ///
  /// currentAmount is the live balance and a payout empties it, so a
  /// contribution that had just paid out its full target reported
  /// "Raised 0 / 0%". Raised is a fact about the cycle and survives the
  /// sweep. 0 means the server did not supply it, in which case
  /// [amountRaised] falls back to the balance — the previous behaviour.
  final double raisedThisCycle;
  final String currency;
  final DateTime deadline;
  final DateTime createdAt;
  final DateTime updatedAt;
  final ContributionStatus status;
  final String createdBy;
  final List<ContributionPayment> payments;
  final Map<String, dynamic>? metadata;

  // Enhanced scheduling fields
  final ContributionType type; // one_time, rotating_savings, investment_pool
  final ContributionFrequency? frequency; // weekly, monthly, etc.
  final double? regularAmount; // Amount each member should contribute per cycle
  final DateTime? nextPaymentDate;
  final DateTime? startDate;
  final int? totalCycles; // Total number of payment cycles
  final int? currentCycle; // Current cycle number

  /// Which pass through the members this circle is on.
  ///
  /// A round is one full pass: three members, three cycles. [currentCycle]
  /// keeps counting up across rounds (round 2 of a pair is cycles 3 and 4),
  /// so without this nothing can say whether "cycle 4" is this circle's
  /// second pass or its fourth member. 1 for a circle that has not been round
  /// twice, which is every circle created before rounds existed.
  final int currentRound;

  /// Set when the creator ended the circle for good.
  ///
  /// NOT the same as `status == completed`, which a circle reaches at the end
  /// of EVERY round and from which another round can still start. This is the
  /// creator saying there will be no more, and it is what stops the screen
  /// offering the choice.
  final DateTime? roundsClosedAt;

  // Payout rotation fields
  final List<PayoutSchedule> payoutSchedule; // Who gets paid when
  final String? currentPayoutRecipient; // Current person to receive payout
  final DateTime? nextPayoutDate;
  final List<PayoutTransaction> payoutHistory;

  // Advanced settings
  final bool autoPayEnabled; // Automatic payment processing
  final double? penaltyAmount; // Penalty for missed payments
  final int? gracePeriodDays; // Grace period before penalties
  final bool allowPartialPayments;
  final double? minimumBalance; // Minimum balance required for payout

  // Drives the payout scheduler. When true, the platform fires the
  // payout automatically once a receiver is set (at deadline / cycle
  // close, or immediately if the deadline already passed). When false,
  // the creator must press the manual-trigger CTA to release funds.
  // Distinct from autoPayEnabled (above) which controls MEMBER-side
  // auto-debiting of contribution payments.
  final bool autoPayoutEnabled;

  // Members assigned to this contribution
  final List<ContributionMember> members;

  /// Avatar for this goal, as a storage-service public URL. Empty/null is
  /// a normal state — the card draws initials — so nothing may assume one.
  final String? imageUrl;

  /// Whether a payout on this contribution has actually SETTLED, and for
  /// how much.
  ///
  /// Only completed payouts count. A pending payout is money committed but
  /// not gone, and badging that "Paid out" would tell a member their
  /// recipient has been paid while the transfer could still fail back into
  /// the pot.
  final bool paidOut;
  final double paidOutAmount;

  /// When the creator OPENED this esusu, freezing its roster. Null means it
  /// has not started: members can still be added, and nothing is charged or
  /// paid out until it is opened.
  ///
  /// Only rotating savings uses it. A one-time goal has no roster to freeze
  /// and is open from creation, which is why [isOpen] answers true for one
  /// regardless of this field.
  final DateTime? openedAt;

  const Contribution({
    required this.id,
    required this.groupId,
    required this.title,
    required this.description,
    required this.targetAmount,
    required this.currentAmount,
    this.raisedThisCycle = 0,
    required this.currency,
    required this.deadline,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.createdBy,
    required this.payments,
    this.metadata,
    this.type = ContributionType.oneTime,
    this.frequency,
    this.regularAmount,
    this.nextPaymentDate,
    this.startDate,
    this.totalCycles,
    this.currentCycle,
    this.currentRound = 1,
    this.roundsClosedAt,
    this.payoutSchedule = const [],
    this.currentPayoutRecipient,
    this.nextPayoutDate,
    this.payoutHistory = const [],
    this.autoPayEnabled = false,
    this.penaltyAmount,
    this.gracePeriodDays,
    this.allowPartialPayments = true,
    this.minimumBalance,
    this.autoPayoutEnabled = false,
    this.members = const [],
    this.imageUrl,
    this.paidOut = false,
    this.paidOutAmount = 0,
    this.openedAt,
  });

  @override
  List<Object?> get props => [
        id,
        groupId,
        title,
        description,
        targetAmount,
        currentAmount,
        raisedThisCycle,
        currency,
        deadline,
        createdAt,
        updatedAt,
        status,
        createdBy,
        payments,
        metadata,
        type,
        frequency,
        regularAmount,
        nextPaymentDate,
        startDate,
        totalCycles,
        currentCycle,
        currentRound,
        roundsClosedAt,
        payoutSchedule,
        currentPayoutRecipient,
        nextPayoutDate,
        payoutHistory,
        autoPayEnabled,
        penaltyAmount,
        gracePeriodDays,
        allowPartialPayments,
        minimumBalance,
        autoPayoutEnabled,
        members,
        imageUrl,
        paidOut,
        paidOutAmount,
        openedAt,
      ];

  bool get isCompleted => status == ContributionStatus.completed;

  /// Whether the server will accept money into this contribution at all.
  ///
  /// MakePayment refuses every non-active status with its own sentence —
  /// completed ("it has reached its target and is now closed"), paused
  /// ("the organiser can resume it") and cancelled ("it was cancelled") —
  /// but the Contribute CTA was gated on [isCompleted] ALONE. A paused or
  /// cancelled contribution therefore still offered the button, and the only
  /// way to find out was to go through the pay screen, pick an amount and be
  /// refused at the end.
  ///
  /// Mirrors the server's own state check so the two cannot disagree about
  /// what "collecting" means.
  bool get isCollecting => status == ContributionStatus.active;

  /// Whether this contribution has STARTED.
  ///
  /// A one-time goal always has: there is no roster to freeze and nothing
  /// for an Open step to decide. An esusu starts when its creator opens it,
  /// and until then no member is charged and no pot is paid out.
  bool get isOpen => !isRotatingSavings || openedAt != null;

  /// An esusu waiting for its creator to open it. The state where members
  /// can still be added — and the only state where the Open CTA shows.
  bool get awaitingOpen => isRotatingSavings && openedAt == null;

  /// Whether the deadline has passed. Separate from [isOverdue], which asks
  /// about the next PAYMENT date within a cycle.
  bool get deadlinePassed => DateTime.now().isAfter(deadline);

  /// Whether the target was actually met, measured against what the cycle
  /// RAISED rather than the live balance — a payout empties the pot, and a
  /// fully funded goal does not stop having been fully funded.
  bool get targetMet => targetAmount > 0 && amountRaised >= targetAmount;

  /// What a badge should say.
  ///
  /// `status == completed` meant two different things and the UI showed one
  /// word for both: a one-time goal that reached its target, and one the
  /// scheduler closed at its deadline without reaching it. They are not the
  /// same outcome to the people who funded it, so they get different words.
  ContributionDisplayState get displayState {
    switch (status) {
      case ContributionStatus.cancelled:
        return ContributionDisplayState.cancelled;
      case ContributionStatus.paused:
        return ContributionDisplayState.paused;
      case ContributionStatus.completed:
        // CLOSED WITH CYCLES STILL OWED IS NOT A FINISH.
        //
        // AdvancePayoutRotation only awards completion when
        // cycles_completed >= total_cycles, and it cancels the untouched
        // slots on the way. A rotation that is `completed` with cycles
        // remaining was closed by something else and its next slot cannot
        // run — on prod that slot sits in manual_review reading
        // "contribution status is completed (must be active)".
        //
        // Checked BEFORE paidOut, because the stuck case has a settled
        // payout too and would otherwise read as a clean "Paid out".
        if (isRotatingSavings && hasUnrunCycles) {
          return ContributionDisplayState.stalled;
        }
        if (paidOut) return ContributionDisplayState.paidOut;
        if (targetMet) return ContributionDisplayState.completed;
        // Closed by its deadline with the target unmet. "Completed" would
        // claim something that did not happen.
        return ContributionDisplayState.closed;
      case ContributionStatus.active:
        if (deadlinePassed) return ContributionDisplayState.overdue;
        return ContributionDisplayState.active;
    }
  }

  /// True when the server closed a rotation before its agreed cycles ran.
  ///
  /// Read from the CYCLE POINTER, because `cycles_completed` is not on the
  /// wire. A clean finish leaves the pointer on the member who last
  /// collected — AdvancePayoutRotation deliberately does not advance past
  /// the end — so a finished rotation has `currentCycle == totalCycles`,
  /// and a pointer short of the end means cycles were never run.
  ///
  /// Deliberately conservative: it needs BOTH counters present and a total
  /// above one, so a contribution whose numbers the wire did not supply is
  /// never accused of being stuck.
  bool get hasUnrunCycles {
    final total = totalCycles ?? 0;
    final current = currentCycle ?? 0;
    if (total <= 1 || current <= 0) return false;
    return current < total;
  }

  bool get isActive => status == ContributionStatus.active;
  bool get isRotatingSavings => type == ContributionType.rotatingSavings;
  bool get hasSchedule => frequency != null && regularAmount != null;
  bool get isOverdue =>
      nextPaymentDate != null && DateTime.now().isAfter(nextPaymentDate!);
  bool get canPayout =>
      currentAmount >= (minimumBalance ?? 0) && currentPayoutRecipient != null;

  /// The figure to SHOW as raised. Prefers what the cycle actually took;
  /// falls back to the live balance when the server did not supply it.
  double get amountRaised =>
      raisedThisCycle > 0 ? raisedThisCycle : currentAmount;

  /// Progress follows [amountRaised] for the same reason: after a payout the
  /// pot is empty, and a completed contribution showing 0% is wrong about
  /// its own history.
  double get progressPercentage =>
      targetAmount > 0 ? (amountRaised / targetAmount * 100).clamp(0, 100) : 0;

  PayoutSchedule? get currentPayoutInfo => payoutSchedule.isNotEmpty
      ? payoutSchedule.firstWhere((p) => p.userId == currentPayoutRecipient,
          orElse: () => payoutSchedule.first)
      : null;

  Contribution copyWith({
    String? id,
    String? groupId,
    String? title,
    String? description,
    double? targetAmount,
    double? currentAmount,
    double? raisedThisCycle,
    String? currency,
    DateTime? deadline,
    DateTime? createdAt,
    DateTime? updatedAt,
    ContributionStatus? status,
    String? createdBy,
    List<ContributionPayment>? payments,
    Map<String, dynamic>? metadata,
    ContributionType? type,
    ContributionFrequency? frequency,
    double? regularAmount,
    DateTime? nextPaymentDate,
    DateTime? startDate,
    int? totalCycles,
    int? currentCycle,
    int? currentRound,
    DateTime? roundsClosedAt,
    List<PayoutSchedule>? payoutSchedule,
    String? currentPayoutRecipient,
    DateTime? nextPayoutDate,
    List<PayoutTransaction>? payoutHistory,
    bool? autoPayEnabled,
    double? penaltyAmount,
    int? gracePeriodDays,
    bool? allowPartialPayments,
    double? minimumBalance,
    bool? autoPayoutEnabled,
    List<ContributionMember>? members,
    DateTime? openedAt,
    String? imageUrl,
    bool? paidOut,
    double? paidOutAmount,
  }) {
    return Contribution(
      id: id ?? this.id,
      groupId: groupId ?? this.groupId,
      title: title ?? this.title,
      description: description ?? this.description,
      targetAmount: targetAmount ?? this.targetAmount,
      currentAmount: currentAmount ?? this.currentAmount,
      raisedThisCycle: raisedThisCycle ?? this.raisedThisCycle,
      currency: currency ?? this.currency,
      deadline: deadline ?? this.deadline,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      status: status ?? this.status,
      createdBy: createdBy ?? this.createdBy,
      payments: payments ?? this.payments,
      metadata: metadata ?? this.metadata,
      type: type ?? this.type,
      frequency: frequency ?? this.frequency,
      regularAmount: regularAmount ?? this.regularAmount,
      nextPaymentDate: nextPaymentDate ?? this.nextPaymentDate,
      startDate: startDate ?? this.startDate,
      totalCycles: totalCycles ?? this.totalCycles,
      currentCycle: currentCycle ?? this.currentCycle,
      currentRound: currentRound ?? this.currentRound,
      roundsClosedAt: roundsClosedAt ?? this.roundsClosedAt,
      payoutSchedule: payoutSchedule ?? this.payoutSchedule,
      currentPayoutRecipient:
          currentPayoutRecipient ?? this.currentPayoutRecipient,
      nextPayoutDate: nextPayoutDate ?? this.nextPayoutDate,
      payoutHistory: payoutHistory ?? this.payoutHistory,
      autoPayEnabled: autoPayEnabled ?? this.autoPayEnabled,
      penaltyAmount: penaltyAmount ?? this.penaltyAmount,
      gracePeriodDays: gracePeriodDays ?? this.gracePeriodDays,
      allowPartialPayments: allowPartialPayments ?? this.allowPartialPayments,
      minimumBalance: minimumBalance ?? this.minimumBalance,
      autoPayoutEnabled: autoPayoutEnabled ?? this.autoPayoutEnabled,
      members: members ?? this.members,
      // Carried, not dropped.
      //
      // These four were omitted, so EVERY copyWith reset them to their
      // constructor defaults — openedAt to null, which makes an esusu that has
      // already started report awaitingOpen and render as "Not started", and
      // imageUrl to null, which wiped the avatar that had just been uploaded.
      // Changing the cycle count was enough to trigger it.
      openedAt: openedAt ?? this.openedAt,
      imageUrl: imageUrl ?? this.imageUrl,
      paidOut: paidOut ?? this.paidOut,
      paidOutAmount: paidOutAmount ?? this.paidOutAmount,
    );
  }

  // External Social Media Links
  String? get whatsappGroupLink {
    return metadata?['whatsapp_group_link'] as String?;
  }

  String? get telegramGroupLink {
    return metadata?['telegram_group_link'] as String?;
  }

  String? get facebookGroupLink {
    return metadata?['facebook_group_link'] as String?;
  }

  String? get discordInviteLink {
    return metadata?['discord_invite_link'] as String?;
  }

  bool get hasExternalLinks {
    return whatsappGroupLink != null ||
        telegramGroupLink != null ||
        facebookGroupLink != null ||
        discordInviteLink != null;
  }

  /// Get all external links as a map
  Map<String, String?> get externalLinks {
    return {
      'whatsapp': whatsappGroupLink,
      'telegram': telegramGroupLink,
      'facebook': facebookGroupLink,
      'discord': discordInviteLink,
    };
  }
}

/// Extension on Contribution for permission checking
extension ContributionPermissions on Contribution {
  /// Check if user is the creator of the contribution
  bool isCreator(String userId) => createdBy == userId;

  /// Check if user is a member of this contribution
  bool isMember(String userId) {
    return members.any((m) => m.userId == userId);
  }

  /// Check if contribution can be edited (not completed or cancelled)
  bool get canBeEdited =>
      status != ContributionStatus.completed &&
      status != ContributionStatus.cancelled;

  /// Check if contribution can be deleted
  bool get canBeDeleted =>
      currentAmount == 0 &&
      status != ContributionStatus.completed &&
      payments.isEmpty;

  /// Check if user can edit this contribution
  bool canUserEdit(String userId) {
    return isCreator(userId) && canBeEdited;
  }

  /// Check if user can delete this contribution
  bool canUserDelete(String userId) {
    return isCreator(userId) && canBeDeleted;
  }

  /// Check if user can make payments to this contribution
  bool canUserPay(String userId) {
    return isMember(userId) && status == ContributionStatus.active;
  }

  /// Get progress percentage
  double get progressPercentage {
    if (targetAmount <= 0) return 0;
    return (currentAmount / targetAmount * 100).clamp(0, 100);
  }

  /// Check if contribution is overdue
  bool get isOverdue =>
      status == ContributionStatus.active && DateTime.now().isAfter(deadline);

  /// Get user's contribution member record
  ContributionMember? getMember(String userId) {
    try {
      return members.firstWhere((m) => m.userId == userId);
    } catch (_) {
      return null;
    }
  }

  /// Get user's payment progress in this contribution
  double getUserProgress(String userId) {
    final member = getMember(userId);
    if (member == null || member.expectedAmount <= 0) return 0;
    return (member.totalPaid / member.expectedAmount * 100).clamp(0, 100);
  }
}

// Contribution Member entity - a member assigned to a contribution
class ContributionMember extends Equatable {
  final String id;
  final String contributionId;
  final String userId;
  final String userName;
  final String email;
  final String? profileImage;
  final DateTime joinedAt;
  final double totalPaid;
  final double expectedAmount;
  final bool hasPaidCurrentCycle;

  /// Cumulative completed payments for the CURRENT cycle. ROSCA +
  /// allow_partial_payments members can pay their share in chunks;
  /// has_paid_current_cycle stays false until cumulative reaches
  /// regular_amount. Reset to 0 on cycle advance. Always 0 for
  /// one-time contributions.
  final double cyclePaidAmount;

  /// Number of cycles this member's row has missed (no completed
  /// payment by cycle close). Surfaced for the "X members behind"
  /// indicators on the contribution screen.
  final int missedCycles;

  /// Whether this member has already collected the pot in the round that is
  /// currently running.
  ///
  /// A round is one full pass through the members, so collecting twice before
  /// everyone has collected once means the second pot is funded by people
  /// still waiting for a first. The server refuses such an assignment; this
  /// lets the picker say so BEFORE the round trip, instead of greying a row
  /// with no explanation.
  ///
  /// Resets each round — that is the whole point of a round.
  final bool hasCollectedThisRound;

  /// Which cycle they collected in, for the badge. 0 when they have not.
  final int collectedCycleIndex;

  /// Invite-first membership state. ACTIVE rows are full participants;
  /// PENDING_INVITE rows are shadow placeholders waiting on group
  /// invite acceptance and MUST be excluded from financial logic
  /// (member counts, cycle progress, receiver picker).
  final ContributionMembershipStatus membershipStatus;

  /// Linked GroupInvitation row ID when membership is pending. Lets
  /// the UI deep-link to the invite detail or surface "Invite Sent".
  final String? linkedInvitationId;

  /// Auto-charge attempt state for THIS member's current cycle.
  ///
  /// Empty when auto-pay is off or nothing has been attempted. Before these
  /// existed, auto-pay could fail, retry and exhaust its attempts while the
  /// member saw only that they were behind — with no way to learn that we had
  /// tried at all, how many times, or what went wrong.
  final String autoChargeStatus; // ''|pending|succeeded|failed|exhausted
  final int autoChargeAttempts;
  final DateTime? autoChargeLastAttemptAt;
  final String autoChargeLastError;

  const ContributionMember({
    required this.id,
    required this.contributionId,
    required this.userId,
    required this.userName,
    required this.email,
    this.profileImage,
    required this.joinedAt,
    this.totalPaid = 0,
    this.expectedAmount = 0,
    this.hasPaidCurrentCycle = false,
    this.cyclePaidAmount = 0,
    this.missedCycles = 0,
    this.hasCollectedThisRound = false,
    this.collectedCycleIndex = 0,
    this.membershipStatus = ContributionMembershipStatus.active,
    this.linkedInvitationId,
    this.autoChargeStatus = '',
    this.autoChargeAttempts = 0,
    this.autoChargeLastAttemptAt,
    this.autoChargeLastError = '',
  });

  /// True when auto-pay tried and has not succeeded for this cycle.
  bool get autoChargeTriedAndFailed =>
      autoChargeStatus == 'failed' || autoChargeStatus == 'exhausted';

  /// True when auto-pay has given up: max attempts reached, nothing further
  /// will happen on its own and the member has to pay manually.
  bool get autoChargeExhausted => autoChargeStatus == 'exhausted';

  /// Convenience for filtering member lists down to active
  /// participants when computing financial roll-ups.
  bool get isActiveParticipant =>
      membershipStatus == ContributionMembershipStatus.active;

  /// True when this is a shadow row tracking a pending parent group
  /// invitation. UI uses this to render "Invite Sent" instead of
  /// payment progress.
  bool get isPendingInvite =>
      membershipStatus == ContributionMembershipStatus.pendingInvite;

  @override
  List<Object?> get props => [
        id,
        contributionId,
        userId,
        userName,
        email,
        profileImage,
        joinedAt,
        totalPaid,
        expectedAmount,
        hasPaidCurrentCycle,
        cyclePaidAmount,
        missedCycles,
        hasCollectedThisRound,
        collectedCycleIndex,
        membershipStatus,
        linkedInvitationId,
        autoChargeStatus,
        autoChargeAttempts,
        autoChargeLastAttemptAt,
        autoChargeLastError,
      ];

  ContributionMember copyWith({
    String? id,
    String? contributionId,
    String? userId,
    String? userName,
    String? email,
    String? profileImage,
    DateTime? joinedAt,
    double? totalPaid,
    double? expectedAmount,
    bool? hasPaidCurrentCycle,
    double? cyclePaidAmount,
    int? missedCycles,
    ContributionMembershipStatus? membershipStatus,
    String? linkedInvitationId,
  }) {
    return ContributionMember(
      id: id ?? this.id,
      contributionId: contributionId ?? this.contributionId,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      profileImage: profileImage ?? this.profileImage,
      joinedAt: joinedAt ?? this.joinedAt,
      totalPaid: totalPaid ?? this.totalPaid,
      expectedAmount: expectedAmount ?? this.expectedAmount,
      hasPaidCurrentCycle: hasPaidCurrentCycle ?? this.hasPaidCurrentCycle,
      cyclePaidAmount: cyclePaidAmount ?? this.cyclePaidAmount,
      missedCycles: missedCycles ?? this.missedCycles,
      membershipStatus: membershipStatus ?? this.membershipStatus,
      linkedInvitationId: linkedInvitationId ?? this.linkedInvitationId,
    );
  }
}

// Contribution Payment entity
class ContributionPayment extends Equatable {
  final String id;
  final String contributionId;
  final String groupId;
  final String userId;
  final String userName;
  final double amount;
  final String currency;
  final DateTime paymentDate;
  final PaymentStatus status;
  final String? transactionId;
  final String? receiptId;
  final String? notes;
  final Map<String, dynamic>? metadata;

  const ContributionPayment({
    required this.id,
    required this.contributionId,
    required this.groupId,
    required this.userId,
    required this.userName,
    required this.amount,
    required this.currency,
    required this.paymentDate,
    required this.status,
    this.transactionId,
    this.receiptId,
    this.notes,
    this.metadata,
  });

  @override
  List<Object?> get props => [
        id,
        contributionId,
        groupId,
        userId,
        userName,
        amount,
        currency,
        paymentDate,
        status,
        transactionId,
        receiptId,
        notes,
        metadata,
      ];

  ContributionPayment copyWith({
    String? id,
    String? contributionId,
    String? groupId,
    String? userId,
    String? userName,
    double? amount,
    String? currency,
    DateTime? paymentDate,
    PaymentStatus? status,
    String? transactionId,
    String? receiptId,
    String? notes,
    Map<String, dynamic>? metadata,
  }) {
    return ContributionPayment(
      id: id ?? this.id,
      contributionId: contributionId ?? this.contributionId,
      groupId: groupId ?? this.groupId,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      paymentDate: paymentDate ?? this.paymentDate,
      status: status ?? this.status,
      transactionId: transactionId ?? this.transactionId,
      receiptId: receiptId ?? this.receiptId,
      notes: notes ?? this.notes,
      metadata: metadata ?? this.metadata,
    );
  }
}

// Receipt entity
class ContributionReceipt extends Equatable {
  final String id;
  final String paymentId;
  final String contributionId;
  final String groupId;
  final String userId;
  final String userName;
  final double amount;
  final String currency;
  final DateTime paymentDate;
  final DateTime generatedAt;
  final String receiptNumber;
  final Map<String, dynamic> receiptData;

  const ContributionReceipt({
    required this.id,
    required this.paymentId,
    required this.contributionId,
    required this.groupId,
    required this.userId,
    required this.userName,
    required this.amount,
    required this.currency,
    required this.paymentDate,
    required this.generatedAt,
    required this.receiptNumber,
    required this.receiptData,
  });

  @override
  List<Object?> get props => [
        id,
        paymentId,
        contributionId,
        groupId,
        userId,
        userName,
        amount,
        currency,
        paymentDate,
        generatedAt,
        receiptNumber,
        receiptData,
      ];
}

// Contribution Transcript entity
class ContributionTranscript extends Equatable {
  final String id;
  final String contributionId;
  final String groupId;
  final DateTime generatedAt;
  final List<ContributionPayment> payments;
  final double totalAmount;
  final String currency;
  final Map<String, double> memberContributions;

  const ContributionTranscript({
    required this.id,
    required this.contributionId,
    required this.groupId,
    required this.generatedAt,
    required this.payments,
    required this.totalAmount,
    required this.currency,
    required this.memberContributions,
  });

  @override
  List<Object?> get props => [
        id,
        contributionId,
        groupId,
        generatedAt,
        payments,
        totalAmount,
        currency,
        memberContributions,
      ];
}

/// Frozen-at-close summary of one cycle. Drives the history list
/// row and the bottom-sheet header. Amounts are MAJOR units (the
/// gRPC datasource converts from minor units at the boundary, same
/// pattern other monetary values use in this app).
class ContributionCycle extends Equatable {
  final String id;
  final String contributionId;
  final int cycleIndex;
  final ContributionCycleStatus status;
  final DateTime startedAt;
  final DateTime? endedAt;
  final double targetAmount;
  final double raisedAmount;
  final double deficitAmount;
  final String? payoutTransactionId;
  final String? receiverUserId;
  final String receiverName;
  final int paymentCount;
  final int membersCount;
  final int pendingMembersCount;
  final int partialMembersCount;
  final String closeReason;
  final String currency;

  const ContributionCycle({
    required this.id,
    required this.contributionId,
    required this.cycleIndex,
    required this.status,
    required this.startedAt,
    this.endedAt,
    required this.targetAmount,
    required this.raisedAmount,
    this.deficitAmount = 0,
    this.payoutTransactionId,
    this.receiverUserId,
    this.receiverName = '',
    this.paymentCount = 0,
    this.membersCount = 0,
    this.pendingMembersCount = 0,
    this.partialMembersCount = 0,
    this.closeReason = '',
    this.currency = '',
  });

  bool get isLive => status == ContributionCycleStatus.inProgress;
  bool get isSettled => status == ContributionCycleStatus.closedSettled;

  /// Whether the pot actually REACHED this cycle's receiver.
  ///
  /// The cycles sheet marked the receiver with a trophy, which says it was
  /// their TURN — not that they were paid. A member looking at a closed cycle
  /// could not tell the difference between "collected the pot" and "was due to
  /// and the payout is still held".
  ///
  /// Settled status or a payout transaction id: the transaction id is the
  /// evidence money moved (it opens the receipt), and a settled close is the
  /// server's own statement that the payout completed. Failed and cancelled
  /// cycles are neither, so they correctly answer false.
  bool get receiverWasPaid =>
      isSettled || (payoutTransactionId?.trim().isNotEmpty ?? false);
  bool get isFailed => status == ContributionCycleStatus.closedFailed;
  bool get isCancelled => status == ContributionCycleStatus.closedCancelled;

  double get progressPercent => targetAmount > 0
      ? (raisedAmount / targetAmount * 100).clamp(0.0, 999.0)
      : 0.0;

  @override
  List<Object?> get props => [
        id,
        contributionId,
        cycleIndex,
        status,
        startedAt,
        endedAt,
        targetAmount,
        raisedAmount,
        deficitAmount,
        payoutTransactionId,
        receiverUserId,
        receiverName,
        paymentCount,
        membersCount,
        pendingMembersCount,
        partialMembersCount,
        closeReason,
        currency,
      ];
}

/// Per-member snapshot for one cycle. Drives the Members tab in the
/// cycle-details bottom sheet.
class ContributionCycleMemberSnapshot extends Equatable {
  final String userId;
  final String userName;
  final String email;
  final double expectedAmount;
  final double paidAmount;
  final bool hasPaid;
  final bool wasReceiver;
  final int missedCyclesAtClose;
  final String statusAtClose;
  final DateTime? joinedAt;

  const ContributionCycleMemberSnapshot({
    required this.userId,
    required this.userName,
    this.email = '',
    this.expectedAmount = 0,
    this.paidAmount = 0,
    this.hasPaid = false,
    this.wasReceiver = false,
    this.missedCyclesAtClose = 0,
    this.statusAtClose = 'active',
    this.joinedAt,
  });

  /// Helpers for the UI's filter chips on the Members tab.
  bool get isPartial =>
      !hasPaid && paidAmount > 0 && paidAmount < expectedAmount;
  bool get isPending => !hasPaid && paidAmount == 0;
  bool get isFullyPaid => hasPaid;

  @override
  List<Object?> get props => [
        userId,
        userName,
        email,
        expectedAmount,
        paidAmount,
        hasPaid,
        wasReceiver,
        missedCyclesAtClose,
        statusAtClose,
        joinedAt,
      ];
}

/// Bundled payload for the cycle-details bottom sheet — one round
/// trip populates every tab.
class ContributionCycleDetails extends Equatable {
  final ContributionCycle summary;
  final List<ContributionCycleMemberSnapshot> members;
  final List<ContributionPayment> payments;

  const ContributionCycleDetails({
    required this.summary,
    this.members = const [],
    this.payments = const [],
  });

  @override
  List<Object?> get props => [summary, members, payments];
}
