import 'package:equatable/equatable.dart';

/// WHAT THE PLATFORM HAS DECIDED ABOUT A CAMPAIGN, AS THE APP SEES IT.
///
/// ## Why this is separate from [CrowdfundStatus]
///
/// Status is the campaign's LIFECYCLE — active, paused, completed, expired,
/// cancelled. It answers "can this still take money". Moderation answers a
/// different question: "should this be on our platform at all". A campaign
/// can be perfectly active and blocked, and un-blocking one must restore
/// whatever lifecycle it had rather than setting it to active and quietly
/// resurrecting something the creator had paused.
///
/// ## What the app may and may not render
///
/// [status] arrives for every viewer, because a RESTRICTED campaign carries a
/// badge a donor is meant to read before giving.
///
/// [reason] arrives only for the creator and for operators, and is written
/// FOR the creator in the operator's voice. It is the text the blocked-campaign
/// screen shows.
///
/// [note] is OPERATOR-ONLY and arrives EMPTY in the app. It carries the
/// classifier's rationale and admin remarks. **Never render it.** The backend
/// keeps the two in separate columns precisely so one cannot reach the other's
/// audience; this class keeps the field only so its absence is explicit rather
/// than looking like an oversight.
enum CrowdfundModerationState {
  /// The classifier has not answered yet. NOT fundable — that is the point of
  /// the review state.
  pending,

  /// The classifier was not confident enough to decide, or an operator turned
  /// AI review off and a human is reviewing. Also not fundable: an uncertain
  /// campaign is exactly the one that must not be quietly collecting money
  /// while nobody has looked.
  escalated,

  /// Ordinary. Visible to everyone and able to take money.
  approved,

  /// Allowed on the platform, but not endorsed by it. Badged and sorted last.
  /// STILL FUNDABLE — a donor who reads the badge and gives anyway is making
  /// an informed choice, and stopping them would be the platform overruling
  /// its own user.
  restricted,

  /// Off the platform. Invisible to the public and to donors; visible to its
  /// CREATOR with the reason and the right to appeal, because a person whose
  /// campaign vanished with no explanation assumes the platform lost it.
  blocked,
}

CrowdfundModerationState crowdfundModerationStateFrom(String? raw) {
  switch ((raw ?? '').trim().toLowerCase()) {
    case 'approved':
      return CrowdfundModerationState.approved;
    case 'restricted':
      return CrowdfundModerationState.restricted;
    case 'blocked':
      return CrowdfundModerationState.blocked;
    case 'escalated':
      return CrowdfundModerationState.escalated;
    case 'pending':
      return CrowdfundModerationState.pending;
  }
  // AN UNKNOWN OR ABSENT VALUE READS AS PENDING, NEVER AS APPROVED.
  //
  // Campaigns written before moderation existed carry an empty string, and a
  // future backend state this build has not heard of would arrive as a word
  // this switch does not know. Both mean "nobody has told me this is fine",
  // and defaulting to approved would make the app present an unreviewed
  // campaign as endorsed.
  return CrowdfundModerationState.pending;
}

class CrowdfundModeration extends Equatable {
  final CrowdfundModerationState status;

  /// The classifier's own label — "medical", "subsistence_begging". Creator
  /// and operators only; empty for everyone else.
  final String category;

  /// CREATOR-FACING. Shown on the blocked view and nowhere else.
  final String reason;

  final DateTime? moderatedAt;

  /// How many times this campaign has been appealed. Lets a list show
  /// "appealed" without a second request.
  final int appealCount;

  /// Whether to OFFER the appeal button. Resolved by the backend from
  /// ownership, state and whether an appeal is already open — so the app
  /// never offers a button the server then refuses, which reads as the
  /// platform malfunctioning on top of having blocked them.
  final bool canAppeal;

  const CrowdfundModeration({
    this.status = CrowdfundModerationState.pending,
    this.category = '',
    this.reason = '',
    this.moderatedAt,
    this.appealCount = 0,
    this.canAppeal = false,
  });

  /// The state a campaign created before moderation existed is in.
  static const unreviewed = CrowdfundModeration();

  /// Whether this campaign may ACCEPT MONEY.
  ///
  /// Mirrors the backend's `Fundable()`, and the app must agree with it or the
  /// contribute button appears on a campaign the server will refuse. Pending
  /// and escalated both say no, because both mean nobody has decided.
  bool get isFundable =>
      status == CrowdfundModerationState.approved ||
      status == CrowdfundModerationState.restricted;

  /// Whether a human or the classifier still owes this campaign an answer.
  /// Drives the creator's "under review" state.
  bool get isUnderReview =>
      status == CrowdfundModerationState.pending ||
      status == CrowdfundModerationState.escalated;

  bool get isBlocked => status == CrowdfundModerationState.blocked;

  /// Allowed but not endorsed — the badge case.
  bool get isRestricted => status == CrowdfundModerationState.restricted;

  /// Whether this campaign needs any moderation treatment in the UI at all.
  /// An approved campaign renders exactly as it did before moderation
  /// existed, which keeps every existing screen unchanged.
  bool get needsTreatment => status != CrowdfundModerationState.approved;

  /// True once an appeal has been lodged, whatever its outcome. Used to show
  /// "appealed" where the appeal's own status is not loaded.
  bool get hasAppealed => appealCount > 0;

  CrowdfundModeration copyWith({
    CrowdfundModerationState? status,
    String? category,
    String? reason,
    DateTime? moderatedAt,
    int? appealCount,
    bool? canAppeal,
  }) {
    return CrowdfundModeration(
      status: status ?? this.status,
      category: category ?? this.category,
      reason: reason ?? this.reason,
      moderatedAt: moderatedAt ?? this.moderatedAt,
      appealCount: appealCount ?? this.appealCount,
      canAppeal: canAppeal ?? this.canAppeal,
    );
  }

  @override
  List<Object?> get props =>
      [status, category, reason, moderatedAt, appealCount, canAppeal];
}

/// The lifecycle of a creator's challenge to a block.
enum CrowdfundAppealStatus { open, approved, rejected, withdrawn }

CrowdfundAppealStatus crowdfundAppealStatusFrom(String? raw) {
  switch ((raw ?? '').trim().toLowerCase()) {
    case 'approved':
      return CrowdfundAppealStatus.approved;
    case 'rejected':
      return CrowdfundAppealStatus.rejected;
    case 'withdrawn':
      return CrowdfundAppealStatus.withdrawn;
  }
  // Open is the safe default: it keeps the screen showing "we are looking at
  // this" rather than claiming a decision that has not been made.
  return CrowdfundAppealStatus.open;
}

class CrowdfundAppeal extends Equatable {
  final String id;
  final String crowdfundId;

  /// What the creator argued.
  final String message;
  final CrowdfundAppealStatus status;

  /// The operator's answer. Written for the creator — it is the one thing
  /// they will read twice — and empty while the appeal is open.
  final String decision;
  final DateTime? reviewedAt;

  /// The moderation state at the time of the appeal, so the screen can say
  /// what was actually being appealed rather than describing whatever the
  /// campaign looks like now.
  final String appealedStatus;
  final DateTime? createdAt;

  final String crowdfundTitle;
  final String crowdfundCode;

  const CrowdfundAppeal({
    required this.id,
    required this.crowdfundId,
    required this.message,
    this.status = CrowdfundAppealStatus.open,
    this.decision = '',
    this.reviewedAt,
    this.appealedStatus = '',
    this.createdAt,
    this.crowdfundTitle = '',
    this.crowdfundCode = '',
  });

  bool get isOpen => status == CrowdfundAppealStatus.open;
  bool get wasUpheld => status == CrowdfundAppealStatus.approved;
  bool get wasRejected => status == CrowdfundAppealStatus.rejected;

  /// Whether the creator has been given an answer they can read.
  bool get hasDecision => !isOpen && decision.trim().isNotEmpty;

  @override
  List<Object?> get props => [
        id,
        crowdfundId,
        message,
        status,
        decision,
        reviewedAt,
        appealedStatus,
        createdAt,
        crowdfundTitle,
        crowdfundCode,
      ];
}
