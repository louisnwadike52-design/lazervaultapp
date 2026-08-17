part of 'crowdfund_entities.dart';

// ============================================================================
// ENUMS
// ============================================================================

enum CrowdfundStatus {
  active,
  paused,
  completed,
  cancelled,
  // Transient state set when CancelCrowdfund queues per-contribution
  // refunds; advances to cancelled once the worker drains the queue.
  // UI treats this as read-only ("Cancelling…").
  cancelling,
  // Surfaced explicitly (previously folded into cancelled on the
  // wire). Set automatically by the deadline worker when the
  // campaign passes its end date without hitting target.
  expired,
}

enum DonationStatus {
  pending,
  processing,
  completed,
  failed,
  refunded,
}

// ============================================================================
// ENTITIES
// ============================================================================

/// Creator entity with verification details
class CrowdfundCreator extends Equatable {
  final int userId;
  final String username;
  final String firstName;
  final String lastName;
  final String? profilePicture;
  final bool verified;
  final DateTime? verifiedAt;
  final bool facialRecognitionEnabled;

  const CrowdfundCreator({
    required this.userId,
    required this.username,
    required this.firstName,
    required this.lastName,
    this.profilePicture,
    required this.verified,
    this.verifiedAt,
    required this.facialRecognitionEnabled,
  });

  String get fullName => '$firstName $lastName';
  String get displayName => username.isNotEmpty ? username : fullName;
  String get initials {
    final f = firstName.isNotEmpty ? firstName[0] : '';
    final l = lastName.isNotEmpty ? lastName[0] : '';
    return '$f$l'.toUpperCase();
  }

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'username': username,
        'firstName': firstName,
        'lastName': lastName,
        'profilePicture': profilePicture,
        'verified': verified,
        'verifiedAt': verifiedAt?.toIso8601String(),
        'facialRecognitionEnabled': facialRecognitionEnabled,
      };

  factory CrowdfundCreator.fromJson(Map<String, dynamic> json) {
    return CrowdfundCreator(
      userId: (json['userId'] as num?)?.toInt() ?? 0,
      username: (json['username'] as String?) ?? '',
      firstName: (json['firstName'] as String?) ?? '',
      lastName: (json['lastName'] as String?) ?? '',
      profilePicture: json['profilePicture'] as String?,
      verified: (json['verified'] as bool?) ?? false,
      verifiedAt: json['verifiedAt'] != null
          ? DateTime.tryParse(json['verifiedAt'] as String)
          : null,
      facialRecognitionEnabled: (json['facialRecognitionEnabled'] as bool?) ?? false,
    );
  }

  @override
  List<Object?> get props => [
        userId,
        username,
        firstName,
        lastName,
        profilePicture,
        verified,
        verifiedAt,
        facialRecognitionEnabled,
      ];
}

/// Donor entity with privacy abstraction
class CrowdfundDonor extends Equatable {
  final int userId;
  final String displayName;
  final String? profilePicture;
  final bool isAnonymous;
  final bool isCreator; // True if current user is the crowdfund creator

  const CrowdfundDonor({
    required this.userId,
    required this.displayName,
    this.profilePicture,
    required this.isAnonymous,
    required this.isCreator,
  });

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'displayName': displayName,
        'profilePicture': profilePicture,
        'isAnonymous': isAnonymous,
        'isCreator': isCreator,
      };

  factory CrowdfundDonor.fromJson(Map<String, dynamic> json) {
    return CrowdfundDonor(
      userId: (json['userId'] as num).toInt(),
      displayName: json['displayName'] as String? ?? '',
      profilePicture: json['profilePicture'] as String?,
      isAnonymous: json['isAnonymous'] as bool? ?? false,
      isCreator: json['isCreator'] as bool? ?? false,
    );
  }

  @override
  List<Object?> get props =>
      [userId, displayName, profilePicture, isAnonymous, isCreator];
}

/// Donation entity
class CrowdfundDonation extends Equatable {
  final String id;
  final String crowdfundId;
  final int donorUserId;
  final CrowdfundDonor donor;
  final double amount;
  final String currency;
  final DateTime donationDate;
  final DonationStatus status;
  final String? transactionId;
  final String? receiptId;
  final String? message;
  final bool isAnonymous;
  final String paymentMethod;
  final Map<String, dynamic>? metadata;

  const CrowdfundDonation({
    required this.id,
    required this.crowdfundId,
    required this.donorUserId,
    required this.donor,
    required this.amount,
    required this.currency,
    required this.donationDate,
    required this.status,
    this.transactionId,
    this.receiptId,
    this.message,
    required this.isAnonymous,
    required this.paymentMethod,
    this.metadata,
  });

  bool get isCompleted => status == DonationStatus.completed;
  bool get isPending => status == DonationStatus.pending;
  bool get isProcessing => status == DonationStatus.processing;
  bool get isFailed => status == DonationStatus.failed;

  Map<String, dynamic> toJson() => {
        'id': id,
        'crowdfundId': crowdfundId,
        'donorUserId': donorUserId,
        'donor': donor.toJson(),
        'amount': amount,
        'currency': currency,
        'donationDate': donationDate.toIso8601String(),
        'status': status.name,
        'transactionId': transactionId,
        'receiptId': receiptId,
        'message': message,
        'isAnonymous': isAnonymous,
        'paymentMethod': paymentMethod,
        'metadata': metadata,
      };

  factory CrowdfundDonation.fromJson(Map<String, dynamic> json) {
    return CrowdfundDonation(
      id: json['id'] as String,
      crowdfundId: json['crowdfundId'] as String,
      donorUserId: (json['donorUserId'] as num).toInt(),
      donor: CrowdfundDonor.fromJson(json['donor'] as Map<String, dynamic>),
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'] as String? ?? '',
      donationDate:
          DateTime.tryParse(json['donationDate'] as String? ?? '') ??
              DateTime.now(),
      status: DonationStatus.values.firstWhere(
        (e) => e.name == (json['status'] as String? ?? ''),
        orElse: () => DonationStatus.pending,
      ),
      transactionId: json['transactionId'] as String?,
      receiptId: json['receiptId'] as String?,
      message: json['message'] as String?,
      isAnonymous: json['isAnonymous'] as bool? ?? false,
      paymentMethod: json['paymentMethod'] as String? ?? '',
      metadata: (json['metadata'] as Map?)?.cast<String, dynamic>(),
    );
  }

  @override
  List<Object?> get props => [
        id,
        crowdfundId,
        donorUserId,
        donor,
        amount,
        currency,
        donationDate,
        status,
        transactionId,
        receiptId,
        message,
        isAnonymous,
        paymentMethod,
        metadata,
      ];
}

/// Receipt entity
class CrowdfundReceipt extends Equatable {
  final String id;
  final String donationId;
  final String crowdfundId;
  final String crowdfundTitle;
  final int donorUserId;
  final String donorName;
  final double amount;
  final String currency;
  final DateTime donationDate;
  final DateTime generatedAt;
  final String receiptNumber;
  final Map<String, dynamic>? receiptData;

  const CrowdfundReceipt({
    required this.id,
    required this.donationId,
    required this.crowdfundId,
    required this.crowdfundTitle,
    required this.donorUserId,
    required this.donorName,
    required this.amount,
    required this.currency,
    required this.donationDate,
    required this.generatedAt,
    required this.receiptNumber,
    this.receiptData,
  });

  @override
  List<Object?> get props => [
        id,
        donationId,
        crowdfundId,
        crowdfundTitle,
        donorUserId,
        donorName,
        amount,
        currency,
        donationDate,
        generatedAt,
        receiptNumber,
        receiptData,
      ];
}

/// Crowdfund statistics entity
class CrowdfundStatistics extends Equatable {
  final String crowdfundId;
  final double totalRaised;
  final double targetAmount;
  final double progressPercentage;
  final int donorCount;
  final double averageDonation;
  final double largestDonation;
  final int daysRemaining;
  final bool isCompleted;
  final DateTime createdAt;

  const CrowdfundStatistics({
    required this.crowdfundId,
    required this.totalRaised,
    required this.targetAmount,
    required this.progressPercentage,
    required this.donorCount,
    required this.averageDonation,
    required this.largestDonation,
    required this.daysRemaining,
    required this.isCompleted,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        crowdfundId,
        totalRaised,
        targetAmount,
        progressPercentage,
        donorCount,
        averageDonation,
        largestDonation,
        daysRemaining,
        isCompleted,
        createdAt,
      ];
}

/// Milestone entry for crowdfund reports
class CrowdfundMilestone extends Equatable {
  final String title;
  final String description;
  final double targetAmount;
  final bool isReached;
  final DateTime? reachedAt;

  const CrowdfundMilestone({
    required this.title,
    required this.description,
    required this.targetAmount,
    required this.isReached,
    this.reachedAt,
  });

  factory CrowdfundMilestone.fromJson(Map<String, dynamic> json) {
    return CrowdfundMilestone(
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      targetAmount: (json['target_amount'] as num?)?.toDouble() ?? 0.0,
      isReached: json['is_reached'] as bool? ?? false,
      reachedAt: json['reached_at'] != null
          ? DateTime.tryParse(json['reached_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'target_amount': targetAmount,
        'is_reached': isReached,
        'reached_at': reachedAt?.toIso8601String(),
      };

  @override
  List<Object?> get props => [
        title,
        description,
        targetAmount,
        isReached,
        reachedAt,
      ];
}

/// AI-generated crowdfund campaign report
/// Used for shareable progress updates and impact stories
class CrowdfundReport extends Equatable {
  final String title;
  final String summary;
  final String impactStory;
  final List<String> contributorHighlights;
  final List<CrowdfundMilestone> milestones;
  final String callToAction;
  final CrowdfundSharingText sharingText;
  final List<String> hashtags;
  final bool success;
  final DateTime generatedAt;
  final String? error;

  const CrowdfundReport({
    required this.title,
    required this.summary,
    required this.impactStory,
    required this.contributorHighlights,
    required this.milestones,
    required this.callToAction,
    required this.sharingText,
    required this.hashtags,
    required this.success,
    required this.generatedAt,
    this.error,
  });

  factory CrowdfundReport.fromJson(Map<String, dynamic> json) {
    return CrowdfundReport(
      title: json['title'] as String? ?? '',
      summary: json['summary'] as String? ?? '',
      impactStory: json['impact_story'] as String? ?? '',
      contributorHighlights: (json['contributor_highlights'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      milestones: (json['milestones'] as List<dynamic>?)
              ?.map((e) => CrowdfundMilestone.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      callToAction: json['call_to_action'] as String? ?? '',
      sharingText: CrowdfundSharingText.fromJson(
          json['sharing_text'] as Map<String, dynamic>? ?? {}),
      hashtags: (json['hashtags'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      success: json['success'] as bool? ?? false,
      generatedAt: json['generated_at'] != null
          ? (DateTime.tryParse(json['generated_at'] as String) ?? DateTime.now())
          : DateTime.now(),
      error: json['error'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'summary': summary,
        'impact_story': impactStory,
        'contributor_highlights': contributorHighlights,
        'milestones': milestones.map((e) => e.toJson()).toList(),
        'call_to_action': callToAction,
        'sharing_text': sharingText.toJson(),
        'hashtags': hashtags,
        'success': success,
        'generated_at': generatedAt.toIso8601String(),
        'error': error,
      };

  @override
  List<Object?> get props => [
        title,
        summary,
        impactStory,
        contributorHighlights,
        milestones,
        callToAction,
        sharingText,
        hashtags,
        success,
        generatedAt,
        error,
      ];
}

/// Platform-specific sharing text for crowdfund reports
class CrowdfundSharingText extends Equatable {
  final String whatsapp;
  final String facebook;
  final String telegram;
  final String twitter;
  final String general;

  const CrowdfundSharingText({
    required this.whatsapp,
    required this.facebook,
    required this.telegram,
    required this.twitter,
    required this.general,
  });

  factory CrowdfundSharingText.fromJson(Map<String, dynamic> json) {
    return CrowdfundSharingText(
      whatsapp: json['whatsapp'] as String? ?? '',
      facebook: json['facebook'] as String? ?? '',
      telegram: json['telegram'] as String? ?? '',
      twitter: json['twitter'] as String? ?? '',
      general: json['general'] as String? ?? json['whatsapp'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'whatsapp': whatsapp,
        'facebook': facebook,
        'telegram': telegram,
        'twitter': twitter,
        'general': general,
      };

  @override
  List<Object?> get props => [whatsapp, facebook, telegram, twitter, general];
}

// ============================================================================
// LEADERBOARD ENTITIES
// ============================================================================

enum LeaderboardSortBy { mostFunded, mostDonors, trending, nearlyComplete, newest }

class LeaderboardEntry extends Equatable {
  final int rank;
  final Crowdfund crowdfund;

  const LeaderboardEntry({required this.rank, required this.crowdfund});

  Map<String, dynamic> toJson() => {
        'rank': rank,
        'crowdfund': crowdfund.toJson(),
      };

  factory LeaderboardEntry.fromJson(Map<String, dynamic> json) {
    return LeaderboardEntry(
      rank: json['rank'] as int,
      crowdfund: Crowdfund.fromJson(json['crowdfund'] as Map<String, dynamic>),
    );
  }

  @override
  List<Object?> get props => [rank, crowdfund];
}

// ============================================================================
// CAMPAIGN WALLET ENTITIES
// ============================================================================

/// Result of a withdrawal from a campaign wallet
class CrowdfundWithdrawalResult extends Equatable {
  final String crowdfundId;
  final double amountWithdrawn; // gross amount the user requested
  final double remainingBalance;
  final String destinationAccountId;
  final double destinationNewBalance;
  final String message;
  // Platform-commission snapshot. Zero / empty when no fee applied.
  // [amountWithdrawn] is GROSS; [netAmount] is what hit the
  // destination; [feeAmount] is what the platform booked.
  final double feeAmount;
  final double netAmount;
  final String feeType; // ""|"flat"|"percentage"
  final int feeBasisPoints;
  final int feeFixedKobo;

  const CrowdfundWithdrawalResult({
    required this.crowdfundId,
    required this.amountWithdrawn,
    required this.remainingBalance,
    required this.destinationAccountId,
    required this.destinationNewBalance,
    required this.message,
    this.feeAmount = 0,
    this.netAmount = 0,
    this.feeType = '',
    this.feeBasisPoints = 0,
    this.feeFixedKobo = 0,
  });

  @override
  List<Object?> get props => [
        crowdfundId,
        amountWithdrawn,
        remainingBalance,
        destinationAccountId,
        destinationNewBalance,
        message,
        feeAmount,
        netAmount,
        feeType,
        feeBasisPoints,
        feeFixedKobo,
      ];
}

/// User-scoped custom category created via the "Other → custom"
/// bottom sheet on the create-campaign wizard. Built-in categories
/// (Medical, Education, ...) live in client code and are NOT
/// represented as instances of this class — only persisted custom
/// rows are.
class CrowdfundCustomCategory extends Equatable {
  final String id;
  final String name;
  final DateTime createdAt;

  const CrowdfundCustomCategory({
    required this.id,
    required this.name,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, name, createdAt];
}

/// Result of a category add — returns the row plus whether it was
/// freshly created (false when a case-insensitive duplicate already
/// existed and the server returned the existing row).
class AddCrowdfundCustomCategoryResult extends Equatable {
  final CrowdfundCustomCategory category;
  final bool created;

  const AddCrowdfundCustomCategoryResult({
    required this.category,
    required this.created,
  });

  @override
  List<Object?> get props => [category, created];
}

/// Read-only quote returned by GetCrowdfundWithdrawalFeeQuote. The
/// withdraw sheet renders this so the user sees the platform
/// commission BEFORE they confirm a PIN — the same precedence rule
/// the actual withdrawal uses (flat fee overrides margin if both
/// configured, else whichever single value is set).
class CrowdfundWithdrawalFeeQuote extends Equatable {
  final double grossAmount;
  final double feeAmount;
  final double netAmount;
  final String currency;
  final bool feeEnabled;
  final String feeType; // ""|"flat"|"percentage"
  final int feeBasisPoints;
  final int feeFixedKobo;

  const CrowdfundWithdrawalFeeQuote({
    required this.grossAmount,
    required this.feeAmount,
    required this.netAmount,
    required this.currency,
    required this.feeEnabled,
    required this.feeType,
    required this.feeBasisPoints,
    required this.feeFixedKobo,
  });

  bool get hasFee => feeAmount > 0;

  @override
  List<Object?> get props => [
        grossAmount,
        feeAmount,
        netAmount,
        currency,
        feeEnabled,
        feeType,
        feeBasisPoints,
        feeFixedKobo,
      ];
}

/// Campaign wallet balance information
class CampaignWalletBalance extends Equatable {
  final String crowdfundId;
  final String campaignWalletId;
  final double balance;
  final double availableBalance;
  final String currency;

  const CampaignWalletBalance({
    required this.crowdfundId,
    required this.campaignWalletId,
    required this.balance,
    required this.availableBalance,
    required this.currency,
  });

  /// Whether there are available funds to withdraw
  bool get hasAvailableFunds => availableBalance > 0;

  @override
  List<Object?> get props => [
        crowdfundId,
        campaignWalletId,
        balance,
        availableBalance,
        currency,
      ];
}

/// One row per contribution being refunded as part of a campaign
/// cancellation. Read by the cancel-progress screen + admin refund
/// table. status progresses pending → processing → completed | failed
/// | skipped — workers retry 'failed' rows up to a per-row cap.
class CrowdfundRefund extends Equatable {
  final String id;
  final String contributionId;
  final String crowdfundId;
  final int contributorUserId;
  final String contributorDisplayName;
  final String? destinationAccountId;
  final double amount;
  final String currency;
  final String status;
  final String initiatedBy;
  final String reason;
  final int attemptCount;
  final String? lastError;
  final DateTime createdAt;
  final DateTime updatedAt;

  const CrowdfundRefund({
    required this.id,
    required this.contributionId,
    required this.crowdfundId,
    required this.contributorUserId,
    required this.contributorDisplayName,
    this.destinationAccountId,
    required this.amount,
    required this.currency,
    required this.status,
    required this.initiatedBy,
    required this.reason,
    required this.attemptCount,
    this.lastError,
    required this.createdAt,
    required this.updatedAt,
  });

  bool get isPending => status == 'pending';
  bool get isProcessing => status == 'processing';
  bool get isCompleted => status == 'completed';
  bool get isFailed => status == 'failed';

  @override
  List<Object?> get props => [
        id,
        contributionId,
        crowdfundId,
        contributorUserId,
        amount,
        status,
        attemptCount,
        lastError,
        updatedAt,
      ];
}

/// Result returned from CancelCrowdfund — the updated campaign +
/// how many refund rows were queued for the worker to drain.
class CancelCrowdfundResult extends Equatable {
  final Crowdfund crowdfund;
  final int totalContributions;
  final int refundsQueued;
  final double totalRefundAmount;
  final String message;

  const CancelCrowdfundResult({
    required this.crowdfund,
    required this.totalContributions,
    required this.refundsQueued,
    required this.totalRefundAmount,
    required this.message,
  });

  @override
  List<Object?> get props =>
      [crowdfund, totalContributions, refundsQueued, totalRefundAmount, message];
}
