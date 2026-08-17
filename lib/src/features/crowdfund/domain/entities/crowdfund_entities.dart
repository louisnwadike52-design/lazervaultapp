import 'package:equatable/equatable.dart';
part 'crowdfund_entities_widgets.dart';


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
  });

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
  double get amountRemaining => (targetAmount - currentAmount).clamp(0.0, double.infinity);
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
      createdAt: DateTime.tryParse(json['createdAt'] as String? ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] as String? ?? '') ?? DateTime.now(),
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
    );
  }

  Crowdfund copyWith({
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
      cancelInitiatorUserId: cancelInitiatorUserId ?? this.cancelInitiatorUserId,
      cancelledAt: cancelledAt ?? this.cancelledAt,
      refundsPending: refundsPending ?? this.refundsPending,
      refundsCompleted: refundsCompleted ?? this.refundsCompleted,
      refundsFailed: refundsFailed ?? this.refundsFailed,
      totalRefunded: totalRefunded ?? this.totalRefunded,
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
      ];
}
