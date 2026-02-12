import 'package:equatable/equatable.dart';

// ============================================================================
// ENUMS
// ============================================================================

enum CrowdfundStatus {
  active,
  paused,
  completed,
  cancelled,
}

enum CrowdfundVisibility {
  public,
  private,
  unlisted,
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
      userId: json['userId'] as int,
      username: json['username'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      profilePicture: json['profilePicture'] as String?,
      verified: json['verified'] as bool,
      verifiedAt: json['verifiedAt'] != null
          ? DateTime.parse(json['verifiedAt'] as String)
          : null,
      facialRecognitionEnabled: json['facialRecognitionEnabled'] as bool,
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
  final CrowdfundVisibility visibility;
  final Map<String, dynamic>? metadata;
  final int donorCount;
  final double progressPercentage;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<CrowdfundDonation> recentDonations;

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
    required this.visibility,
    this.metadata,
    required this.donorCount,
    required this.progressPercentage,
    required this.createdAt,
    required this.updatedAt,
    this.recentDonations = const [],
  });

  bool get isActive => status == CrowdfundStatus.active;
  bool get isCompleted => status == CrowdfundStatus.completed;
  bool get isPaused => status == CrowdfundStatus.paused;
  bool get isCancelled => status == CrowdfundStatus.cancelled;
  bool get hasDeadline => deadline != null;
  bool get isExpired =>
      hasDeadline && DateTime.now().isAfter(deadline!);
  int get daysRemaining => hasDeadline
      ? deadline!.difference(DateTime.now()).inDays
      : 0;
  double get amountRemaining => targetAmount - currentAmount;
  bool get isTargetReached => currentAmount >= targetAmount;

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
        'visibility': visibility.name,
        'donorCount': donorCount,
        'progressPercentage': progressPercentage,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
      };

  factory Crowdfund.fromJson(Map<String, dynamic> json) {
    return Crowdfund(
      id: json['id'] as String,
      creatorUserId: json['creatorUserId'] as int,
      creator: CrowdfundCreator.fromJson(json['creator'] as Map<String, dynamic>),
      title: json['title'] as String,
      description: json['description'] as String,
      story: json['story'] as String? ?? '',
      crowdfundCode: json['crowdfundCode'] as String? ?? '',
      targetAmount: (json['targetAmount'] as num).toDouble(),
      currentAmount: (json['currentAmount'] as num).toDouble(),
      currency: json['currency'] as String,
      deadline: json['deadline'] != null
          ? DateTime.parse(json['deadline'] as String)
          : null,
      category: json['category'] as String,
      status: CrowdfundStatus.values.firstWhere(
        (s) => s.name == json['status'],
        orElse: () => CrowdfundStatus.active,
      ),
      imageUrl: json['imageUrl'] as String?,
      visibility: CrowdfundVisibility.values.firstWhere(
        (v) => v.name == json['visibility'],
        orElse: () => CrowdfundVisibility.public,
      ),
      donorCount: json['donorCount'] as int,
      progressPercentage: (json['progressPercentage'] as num).toDouble(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
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
        visibility,
        metadata,
        donorCount,
        progressPercentage,
        createdAt,
        updatedAt,
        recentDonations,
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
          ? DateTime.parse(json['generated_at'] as String)
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
  final double amountWithdrawn;
  final double remainingBalance;
  final String destinationAccountId;
  final double destinationNewBalance;
  final String message;

  const CrowdfundWithdrawalResult({
    required this.crowdfundId,
    required this.amountWithdrawn,
    required this.remainingBalance,
    required this.destinationAccountId,
    required this.destinationNewBalance,
    required this.message,
  });

  @override
  List<Object?> get props => [
        crowdfundId,
        amountWithdrawn,
        remainingBalance,
        destinationAccountId,
        destinationNewBalance,
        message,
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
