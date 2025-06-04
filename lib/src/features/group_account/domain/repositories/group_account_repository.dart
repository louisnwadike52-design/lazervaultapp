import '../entities/group_entities.dart';

abstract class GroupAccountRepository {
  // Group Account methods
  Future<List<GroupAccount>> getUserGroups(String userId);
  Future<GroupAccount> getGroupById(String groupId);
  Future<GroupAccount> createGroup({
    required String name,
    required String description,
    required String adminId,
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
  });
  Future<Contribution> updateContribution(Contribution contribution);
  Future<void> deleteContribution(String contributionId);

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
} 