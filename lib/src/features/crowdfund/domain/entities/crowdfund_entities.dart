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
