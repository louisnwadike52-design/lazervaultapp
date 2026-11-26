import 'package:equatable/equatable.dart';

import 'crowdfund_moderation.dart';
part 'crowdfund_entities_widgets.dart';

/// One page of a ListCrowdfunds call, carrying the SERVER's pagination
/// block alongside the rows.
///
/// `totalItems` is `pagination.total_items` — the true number of
/// campaigns matching the query across every page, not the length of
/// this page. It used to be discarded, which made the landing page
/// present page-1 counts as platform-wide figures. `hasNext` is the
/// server's own `has_next` rather than the `rows.length >= pageSize`
/// guess, which mis-reports an exactly-full final page as "has more".
///
/// NOTE: the backend exposes NO platform-wide *money* aggregate —
/// GetCrowdfundStatistics is per-campaign and ListCrowdfunds returns no
/// summed amount. Any "raised" figure folded on the client is therefore
/// page-scoped and MUST be labelled as such.
typedef CrowdfundPage = ({
  List<Crowdfund> crowdfunds,
  int totalItems,
  bool hasNext,
});

/// Main crowdfund entity
class Crowdfund extends Equatable {
  final String id;
  final int creatorUserId;
  final CrowdfundCreator creator;
  final String title;
  final String description;
  final String story;
  final String crowdfundCode;
  final double targetAmount;
  final double currentAmount;
  final String currency;
  final DateTime? deadline;
  final String category;
  final CrowdfundStatus status;
  final String? imageUrl;
  final Map<String, dynamic>? metadata;
  final int donorCount;
  final double progressPercentage;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<CrowdfundDonation> recentDonations;
  // Cancellation context (set when the campaign transitions to
  // cancelling/cancelled). Surfaced on the details screen so
  // contributors know why a campaign they backed was cancelled.
  final String? cancelReason;
  final String? cancelInitiatedBy; // "creator"|"admin"|"system"
  final String? cancelInitiatorUserId;
  final DateTime? cancelledAt;
  // Refund progress counters (denormalized by the server-side
  // worker; safe to display directly without aggregating).
  final int refundsPending;
  final int refundsCompleted;
  final int refundsFailed;
  final double totalRefunded;
  // Lifetime completed contributions (major units). Monotonic on the
  // server: withdrawals and refunds never reduce it, unlike currentAmount,
  // which is the live pot. 0 only on a campaign that never took money.
  final double totalRaised;

  /// WHAT THE PLATFORM HAS DECIDED ABOUT THIS CAMPAIGN.
  ///
  /// Defaults to [CrowdfundModeration.unreviewed] so every existing
  /// construction of this entity — tests, caches, the dozens of call sites
  /// that build a Crowdfund by hand — keeps compiling and keeps behaving.
  /// `unreviewed` reads as pending, which is the safe reading: a campaign the
  /// backend said nothing about is not one the app presents as endorsed.
  final CrowdfundModeration moderation;

  const Crowdfund({
    required this.id,
    required this.creatorUserId,
    required this.creator,
    required this.title,
    required this.description,
    required this.story,
    required this.crowdfundCode,
    required this.targetAmount,
    required this.currentAmount,
    required this.currency,
    this.deadline,
    required this.category,
    required this.status,
    this.imageUrl,
    this.metadata,
    required this.donorCount,
    required this.progressPercentage,
    required this.createdAt,
    required this.updatedAt,
    this.recentDonations = const [],
    this.cancelReason,
    this.cancelInitiatedBy,
    this.cancelInitiatorUserId,
    this.cancelledAt,
    this.refundsPending = 0,
    this.refundsCompleted = 0,
    this.refundsFailed = 0,
    this.totalRefunded = 0.0,
    this.totalRaised = 0.0,
    this.moderation = CrowdfundModeration.unreviewed,
  });

  /// Whether this campaign can take money RIGHT NOW.
  ///
  /// Both gates, in one place. `isActive` alone was the test every contribute
  /// surface used, and moderation adds a second one that must not be
  /// forgotten by any of them: a campaign under review is active and
  /// unfundable at the same time.
  bool get canAcceptMoney => isActive && moderation.isFundable;

  bool get isActive => status == CrowdfundStatus.active;
  bool get isCompleted => status == CrowdfundStatus.completed;
  bool get isPaused => status == CrowdfundStatus.paused;
  bool get isCancelled => status == CrowdfundStatus.cancelled;
  bool get isCancelling => status == CrowdfundStatus.cancelling;
  bool get isServerExpired => status == CrowdfundStatus.expired;
  bool get hasDeadline => deadline != null;
  // `isExpired` previously checked the wall-clock deadline directly;
  // we keep that meaning but also include the server-side 'expired'
  // status so callers don't need to know which one fired.
  bool get isPastDeadline => hasDeadline && DateTime.now().isAfter(deadline!);
  bool get isExpired => isServerExpired || isPastDeadline;
  int get daysRemaining => hasDeadline
      ? deadline!.difference(DateTime.now()).inDays.clamp(0, 999999)
      : 0;
  double get amountRemaining =>
      (targetAmount - currentAmount).clamp(0.0, double.infinity);
  bool get isTargetReached => currentAmount >= targetAmount;
  double get averageDonation =>
      donorCount > 0 ? currentAmount / donorCount : 0.0;

  Map<String, dynamic> toJson() => {
        'id': id,
        'creatorUserId': creatorUserId,
        'creator': creator.toJson(),
        'title': title,
        'description': description,
        'story': story,
        'crowdfundCode': crowdfundCode,
        'targetAmount': targetAmount,
        'currentAmount': currentAmount,
        'currency': currency,
        'deadline': deadline?.toIso8601String(),
        'category': category,
        'status': status.name,
        'imageUrl': imageUrl,
        'donorCount': donorCount,
        'progressPercentage': progressPercentage,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
        // MODERATION MUST SURVIVE THE CACHE.
        //
        // This map is the cache serializer (CrowdfundCubit caches whole pages
        // through it). Leaving moderation out meant every campaign read back
        // from cache arrived as `unreviewed` — which resolves to PENDING, so
        // an approved campaign would render "Under review" and its Donate
        // button would be hidden, on every cache hit. The cache is the normal
        // path, not the exception, so that is what most users would have seen.
        //
        // `moderation_note` is deliberately absent: it never reaches the app
        // and has no field to persist.
        'moderationStatus': moderation.status.name,
        'moderationCategory': moderation.category,
        'moderationReason': moderation.reason,
        'moderatedAt': moderation.moderatedAt?.toIso8601String(),
        'appealCount': moderation.appealCount,
        'canAppeal': moderation.canAppeal,
      };

  factory Crowdfund.fromJson(Map<String, dynamic> json) {
    return Crowdfund(
      id: json['id'] as String,
      creatorUserId: json['creatorUserId'] as int,
      creator:
          CrowdfundCreator.fromJson(json['creator'] as Map<String, dynamic>),
      title: json['title'] as String,
      description: json['description'] as String,
      story: json['story'] as String? ?? '',
      crowdfundCode: json['crowdfundCode'] as String? ?? '',
      targetAmount: (json['targetAmount'] as num).toDouble(),
      currentAmount: (json['currentAmount'] as num).toDouble(),
      currency: json['currency'] as String,
      deadline: json['deadline'] != null
          ? DateTime.tryParse(json['deadline'] as String)
          : null,
      category: json['category'] as String,
      status: CrowdfundStatus.values.firstWhere(
        (s) => s.name == json['status'],
        orElse: () => CrowdfundStatus.active,
      ),
      imageUrl: json['imageUrl'] as String?,
      donorCount: json['donorCount'] as int,
      progressPercentage: (json['progressPercentage'] as num).toDouble(),
      createdAt: DateTime.tryParse(json['createdAt'] as String? ?? '') ??
          DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] as String? ?? '') ??
          DateTime.now(),
      cancelReason: json['cancelReason'] as String?,
      cancelInitiatedBy: json['cancelInitiatedBy'] as String?,
      cancelInitiatorUserId: json['cancelInitiatorUserId'] as String?,
      cancelledAt: json['cancelledAt'] != null
          ? DateTime.tryParse(json['cancelledAt'] as String)
          : null,
      refundsPending: (json['refundsPending'] as int?) ?? 0,
      refundsCompleted: (json['refundsCompleted'] as int?) ?? 0,
      refundsFailed: (json['refundsFailed'] as int?) ?? 0,
      totalRefunded: (json['totalRefunded'] as num?)?.toDouble() ?? 0.0,
      totalRaised: (json['totalRaised'] as num?)?.toDouble() ?? 0.0,
      moderation: CrowdfundModeration(
        // An ABSENT key — a page cached by an older build — resolves to
        // pending via crowdfundModerationStateFrom. That is the safe
        // direction for a stranger's view, and the first network
        // revalidation replaces it; the alternative, defaulting to approved,
        // would show a cached blocked campaign as live.
        status: crowdfundModerationStateFrom(json['moderationStatus'] as String?),
        category: json['moderationCategory'] as String? ?? '',
        reason: json['moderationReason'] as String? ?? '',
        moderatedAt: json['moderatedAt'] != null
            ? DateTime.tryParse(json['moderatedAt'] as String)
            : null,
        appealCount: (json['appealCount'] as int?) ?? 0,
        canAppeal: json['canAppeal'] as bool? ?? false,
      ),
    );
  }

  Crowdfund copyWith({
    CrowdfundModeration? moderation,
    String? id,
    int? creatorUserId,
    CrowdfundCreator? creator,
    String? title,
    String? description,
    String? story,
    String? crowdfundCode,
    double? targetAmount,
    double? currentAmount,
    String? currency,
    DateTime? deadline,
    String? category,
    CrowdfundStatus? status,
    String? imageUrl,
    Map<String, dynamic>? metadata,
    int? donorCount,
    double? progressPercentage,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<CrowdfundDonation>? recentDonations,
    String? cancelReason,
    String? cancelInitiatedBy,
    String? cancelInitiatorUserId,
    DateTime? cancelledAt,
    int? refundsPending,
    int? refundsCompleted,
    int? refundsFailed,
    double? totalRefunded,
    double? totalRaised,
  }) {
    return Crowdfund(
      id: id ?? this.id,
      creatorUserId: creatorUserId ?? this.creatorUserId,
      creator: creator ?? this.creator,
      title: title ?? this.title,
      description: description ?? this.description,
      story: story ?? this.story,
      crowdfundCode: crowdfundCode ?? this.crowdfundCode,
      targetAmount: targetAmount ?? this.targetAmount,
      currentAmount: currentAmount ?? this.currentAmount,
      currency: currency ?? this.currency,
      deadline: deadline ?? this.deadline,
      category: category ?? this.category,
      status: status ?? this.status,
      imageUrl: imageUrl ?? this.imageUrl,
      metadata: metadata ?? this.metadata,
      donorCount: donorCount ?? this.donorCount,
      progressPercentage: progressPercentage ?? this.progressPercentage,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      recentDonations: recentDonations ?? this.recentDonations,
      cancelReason: cancelReason ?? this.cancelReason,
      cancelInitiatedBy: cancelInitiatedBy ?? this.cancelInitiatedBy,
      cancelInitiatorUserId:
          cancelInitiatorUserId ?? this.cancelInitiatorUserId,
      cancelledAt: cancelledAt ?? this.cancelledAt,
      refundsPending: refundsPending ?? this.refundsPending,
      refundsCompleted: refundsCompleted ?? this.refundsCompleted,
      refundsFailed: refundsFailed ?? this.refundsFailed,
      totalRefunded: totalRefunded ?? this.totalRefunded,
      totalRaised: totalRaised ?? this.totalRaised,
      // Carried through copyWith, or any screen that copies a campaign to
      // change one field would silently reset its moderation to `unreviewed`
      // — hiding the Donate button on a perfectly approved campaign.
      moderation: moderation ?? this.moderation,
    );
  }

  @override
  List<Object?> get props => [
        id,
        creatorUserId,
        creator,
        title,
        description,
        story,
        crowdfundCode,
        targetAmount,
        currentAmount,
        currency,
        deadline,
        category,
        status,
        imageUrl,
        metadata,
        donorCount,
        progressPercentage,
        createdAt,
        updatedAt,
        recentDonations,
        // IN props, and this matters more than it looks. Equatable drops an
        // emit whose state compares equal, so a campaign that was blocked
        // while the screen was open would re-fetch, compare equal on every
        // other field, and never repaint — the creator would keep seeing a
        // live campaign the platform had refused.
        moderation,
      ];
}
