import '../entities/group_entities.dart';

abstract class GroupAccountRepository {
  // Group Account methods
  Future<List<GroupAccount>> getUserGroups(String userId);
  Future<GroupAccount> getGroupById(String groupId);
  Future<GroupAccount> createGroup({
    required String name,
    required String description,
    required String adminId,
    Map<String, dynamic>? metadata,
    GroupVisibility? visibility,
    String? imageUrl,
  });
  Future<GroupAccount> updateGroup(GroupAccount group);
  Future<void> deleteGroup(String groupId);

  // Group Member methods
  Future<List<GroupMember>> getGroupMembers(String groupId);
  Future<GroupMember> addMemberToGroup({
    required String groupId,
    required String userId,
    required String userName,
    required String email,
    String? profileImage,
    String? username,
    GroupMemberRole role = GroupMemberRole.member,
  });
  Future<GroupMember> updateMemberRole({
    required String groupId,
    required String memberId,
    required GroupMemberRole newRole,
  });
  Future<void> removeMemberFromGroup({
    required String groupId,
    required String memberId,
  });
  Future<List<GroupMember>> searchUsers(String query);

  // Contribution methods
  Future<List<Contribution>> getGroupContributions(String groupId);
  Future<Contribution> getContributionById(String contributionId);
  Future<Contribution> createContribution({
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
  Future<Contribution> updateContribution(Contribution contribution);
  Future<void> deleteContribution(String contributionId);

  // Contribution Member methods
  Future<List<ContributionMember>> addMembersToContribution({
    required String contributionId,
    required List<String> memberUserIds,
  });
  Future<List<ContributionMember>> getContributionMembers(String contributionId);
  Future<void> removeMemberFromContribution({
    required String contributionId,
    required String userId,
  });

  // Payment methods
  Future<List<ContributionPayment>> getContributionPayments(String contributionId);
  Future<ContributionPayment> makeContributionPayment({
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
  Future<ContributionPayment> updatePaymentStatus({
    required String paymentId,
    required PaymentStatus status,
    String? transactionId,
  });

  // Receipt methods
  Future<ContributionReceipt> generateReceipt(String paymentId);
  Future<List<ContributionReceipt>> getUserReceipts(String userId);

  // Transcript methods
  Future<ContributionTranscript> generateContributionTranscript(String contributionId);
  
  // Statistics methods
  Future<Map<String, dynamic>> getGroupStatistics(String groupId);
  Future<Map<String, dynamic>> getUserContributionStats(String userId);

  // Activity Log methods
  Future<List<ActivityLogEntry>> getGroupActivityLogs(String groupId);
  Future<List<ActivityLogEntry>> getContributionActivityLogs(String contributionId);

  // Public Group Discovery methods
  Future<List<GroupAccount>> listPublicGroups({
    int page = 1,
    int pageSize = 20,
    String? sortBy,
    String? searchQuery,
  });
  Future<PublicGroupDetail> getPublicGroup(String groupId);
  Future<GroupAccount> joinPublicGroup(String groupId);
}