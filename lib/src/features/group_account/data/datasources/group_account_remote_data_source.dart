import '../models/group_account_models.dart';
import '../../domain/entities/group_entities.dart';

abstract class GroupAccountRemoteDataSource {
  Future<List<GroupAccountModel>> getUserGroups(String userId);
  Future<GroupAccountModel> getGroupById(String groupId);
  Future<GroupAccountModel> createGroup({
    required String name,
    required String description,
    required String adminId,
    Map<String, dynamic>? metadata,
    GroupVisibility? visibility,
    String? imageUrl,
  });
  Future<GroupAccountModel> updateGroup(GroupAccountModel group);
  Future<void> deleteGroup(String groupId);
  
  Future<List<GroupMemberModel>> getGroupMembers(String groupId);
  Future<GroupMemberModel> addMemberToGroup({
    required String groupId,
    required String userId,
    required String userName,
    required String email,
    String? profileImage,
    String? username,  // LazerTag username for user lookup
    GroupMemberRole role = GroupMemberRole.member,
  });
  Future<GroupMemberModel> updateMemberRole({
    required String groupId,
    required String memberId,
    required GroupMemberRole newRole,
  });
  Future<void> removeMemberFromGroup({
    required String groupId,
    required String memberId,
  });
  Future<List<GroupMemberModel>> searchUsers(String query);
  
  Future<List<ContributionModel>> getGroupContributions(String groupId);
  Future<ContributionModel> getContributionById(String contributionId);
  Future<ContributionModel> createContribution({
    required String groupId,
    required String title,
    required String description,
    required double targetAmount,
    required String currency,
    required DateTime deadline,
    required String createdBy,
    ContributionType type = ContributionType.oneTime,
    ContributionFrequency? frequency,
    double? regularAmount,
    DateTime? startDate,
    int? totalCycles,
    List<String>? memberRotationOrder,
    bool autoPayEnabled = false,
    double? penaltyAmount,
    int? gracePeriodDays,
    bool allowPartialPayments = true,
    double? minimumBalance,
    Map<String, dynamic>? metadata,
  });
  Future<ContributionModel> updateContribution(ContributionModel contribution);
  Future<void> deleteContribution(String contributionId);

  // Contribution Member methods
  Future<List<ContributionMemberModel>> addMembersToContribution({
    required String contributionId,
    required List<String> memberUserIds,
  });
  Future<List<ContributionMemberModel>> getContributionMembers(String contributionId);
  Future<void> removeMemberFromContribution({
    required String contributionId,
    required String userId,
  });

  Future<List<ContributionPaymentModel>> getContributionPayments(String contributionId);
  Future<ContributionPaymentModel> makeContributionPayment({
    required String contributionId,
    required String groupId,
    required String userId,
    required String userName,
    required double amount,
    required String currency,
    String? notes,
    String? transactionPin,
    String? sourceAccountId,
    String? idempotencyKey,
  });
  Future<ContributionPaymentModel> updatePaymentStatus({
    required String paymentId,
    required PaymentStatus status,
    String? transactionId,
  });
  
  Future<ContributionModel> processScheduledPayments(String contributionId);
  Future<List<ContributionModel>> getOverdueContributions(String userId);
  Future<ContributionModel> updatePaymentSchedule({
    required String contributionId,
    required DateTime nextPaymentDate,
    int? currentCycle,
  });
  
  Future<List<PayoutScheduleModel>> getPayoutSchedule(String contributionId);
  Future<PayoutTransactionModel> processPayoutTransaction({
    required String contributionId,
    required String recipientUserId,
    required double amount,
    String? paymentMethod,
  });
  Future<PayoutTransactionModel> updatePayoutStatus({
    required String payoutId,
    required PayoutTransactionStatus status,
    String? transactionId,
    String? failureReason,
  });
  Future<ContributionModel> calculateAndProcessPayout(String contributionId);
  Future<ContributionModel> advancePayoutRotation(String contributionId);
  
  Future<ContributionReceiptModel> generateReceipt(String paymentId);
  Future<List<ContributionReceiptModel>> getUserReceipts(String userId);
  
  Future<ContributionTranscriptModel> generateContributionTranscript(String contributionId);
  
  Future<Map<String, dynamic>> getGroupStatistics(String groupId);
  Future<Map<String, dynamic>> getUserContributionStats(String userId);
  Future<Map<String, dynamic>> getContributionAnalytics(String contributionId);

  // Activity Log methods
  Future<List<ActivityLogEntryModel>> getGroupActivityLogs(String groupId);
  Future<List<ActivityLogEntryModel>> getContributionActivityLogs(String contributionId);

  // Public Group Discovery methods
  Future<List<GroupAccountModel>> listPublicGroups({
    int page = 1,
    int pageSize = 20,
    String? sortBy,
    String? searchQuery,
  });
  Future<PublicGroupDetailModel> getPublicGroup(String groupId);
  Future<GroupAccountModel> joinPublicGroup(String groupId);
}

// Activity Log Entry Model
class ActivityLogEntryModel {
  final String id;
  final String groupId;
  final String? contributionId;
  final String actorUserId;
  final String actorName;
  final String actionType;
  final String? targetType;
  final String? targetId;
  final Map<String, dynamic>? details;
  final DateTime createdAt;

  ActivityLogEntryModel({
    required this.id,
    required this.groupId,
    this.contributionId,
    required this.actorUserId,
    required this.actorName,
    required this.actionType,
    this.targetType,
    this.targetId,
    this.details,
    required this.createdAt,
  });

  ActivityLogEntry toEntity() {
    return ActivityLogEntry(
      id: id,
      groupId: groupId,
      contributionId: contributionId,
      actorUserId: actorUserId,
      actorName: actorName,
      actionType: actionType,
      targetType: targetType,
      targetId: targetId,
      details: details,
      createdAt: createdAt,
    );
  }
} 