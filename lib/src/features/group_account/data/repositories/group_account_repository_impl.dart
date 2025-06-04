import '../../domain/entities/group_entities.dart';
import '../../domain/repositories/group_account_repository.dart';
import '../datasources/group_account_remote_data_source.dart';
import '../models/group_account_models.dart';

class GroupAccountRepositoryImpl implements GroupAccountRepository {
  final GroupAccountRemoteDataSource remoteDataSource;

  GroupAccountRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<List<GroupAccount>> getUserGroups(String userId) async {
    try {
      final groupModels = await remoteDataSource.getUserGroups(userId);
      return groupModels.cast<GroupAccount>();
    } catch (e) {
      throw Exception('Failed to get user groups: $e');
    }
  }

  @override
  Future<GroupAccount> getGroupById(String groupId) async {
    try {
      final groupModel = await remoteDataSource.getGroupById(groupId);
      return groupModel;
    } catch (e) {
      throw Exception('Failed to get group: $e');
    }
  }

  @override
  Future<GroupAccount> createGroup({
    required String name,
    required String description,
    required String adminId,
  }) async {
    try {
      final groupModel = await remoteDataSource.createGroup(
        name: name,
        description: description,
        adminId: adminId,
      );
      return groupModel;
    } catch (e) {
      throw Exception('Failed to create group: $e');
    }
  }

  @override
  Future<GroupAccount> updateGroup(GroupAccount group) async {
    try {
      final groupModel = GroupAccountModel.fromEntity(group);
      final updatedGroupModel = await remoteDataSource.updateGroup(groupModel);
      return updatedGroupModel;
    } catch (e) {
      throw Exception('Failed to update group: $e');
    }
  }

  @override
  Future<void> deleteGroup(String groupId) async {
    try {
      await remoteDataSource.deleteGroup(groupId);
    } catch (e) {
      throw Exception('Failed to delete group: $e');
    }
  }

  @override
  Future<List<GroupMember>> getGroupMembers(String groupId) async {
    try {
      final memberModels = await remoteDataSource.getGroupMembers(groupId);
      return memberModels.cast<GroupMember>();
    } catch (e) {
      throw Exception('Failed to get group members: $e');
    }
  }

  @override
  Future<GroupMember> addMemberToGroup({
    required String groupId,
    required String userId,
    required String userName,
    required String email,
    String? profileImage,
    GroupMemberRole role = GroupMemberRole.member,
  }) async {
    try {
      final memberModel = await remoteDataSource.addMemberToGroup(
        groupId: groupId,
        userId: userId,
        userName: userName,
        email: email,
        profileImage: profileImage,
        role: role,
      );
      return memberModel;
    } catch (e) {
      throw Exception('Failed to add member to group: $e');
    }
  }

  @override
  Future<GroupMember> updateMemberRole({
    required String groupId,
    required String memberId,
    required GroupMemberRole newRole,
  }) async {
    try {
      final memberModel = await remoteDataSource.updateMemberRole(
        groupId: groupId,
        memberId: memberId,
        newRole: newRole,
      );
      return memberModel;
    } catch (e) {
      throw Exception('Failed to update member role: $e');
    }
  }

  @override
  Future<void> removeMemberFromGroup({
    required String groupId,
    required String memberId,
  }) async {
    try {
      await remoteDataSource.removeMemberFromGroup(
        groupId: groupId,
        memberId: memberId,
      );
    } catch (e) {
      throw Exception('Failed to remove member from group: $e');
    }
  }

  @override
  Future<List<GroupMember>> searchUsers(String query) async {
    try {
      final memberModels = await remoteDataSource.searchUsers(query);
      return memberModels.cast<GroupMember>();
    } catch (e) {
      throw Exception('Failed to search users: $e');
    }
  }

  @override
  Future<List<Contribution>> getGroupContributions(String groupId) async {
    try {
      final contributionModels = await remoteDataSource.getGroupContributions(groupId);
      return contributionModels.cast<Contribution>();
    } catch (e) {
      throw Exception('Failed to get group contributions: $e');
    }
  }

  @override
  Future<Contribution> getContributionById(String contributionId) async {
    try {
      final contributionModel = await remoteDataSource.getContributionById(contributionId);
      return contributionModel;
    } catch (e) {
      throw Exception('Failed to get contribution: $e');
    }
  }

  @override
  Future<Contribution> createContribution({
    required String groupId,
    required String title,
    required String description,
    required double targetAmount,
    required String currency,
    required DateTime deadline,
    required String createdBy,
  }) async {
    try {
      final contributionModel = await remoteDataSource.createContribution(
        groupId: groupId,
        title: title,
        description: description,
        targetAmount: targetAmount,
        currency: currency,
        deadline: deadline,
        createdBy: createdBy,
      );
      return contributionModel;
    } catch (e) {
      throw Exception('Failed to create contribution: $e');
    }
  }

  @override
  Future<Contribution> updateContribution(Contribution contribution) async {
    try {
      final contributionModel = ContributionModel.fromEntity(contribution);
      final updatedContributionModel = await remoteDataSource.updateContribution(contributionModel);
      return updatedContributionModel;
    } catch (e) {
      throw Exception('Failed to update contribution: $e');
    }
  }

  @override
  Future<void> deleteContribution(String contributionId) async {
    try {
      await remoteDataSource.deleteContribution(contributionId);
    } catch (e) {
      throw Exception('Failed to delete contribution: $e');
    }
  }

  @override
  Future<List<ContributionPayment>> getContributionPayments(String contributionId) async {
    try {
      final paymentModels = await remoteDataSource.getContributionPayments(contributionId);
      return paymentModels.cast<ContributionPayment>();
    } catch (e) {
      throw Exception('Failed to get contribution payments: $e');
    }
  }

  @override
  Future<ContributionPayment> makeContributionPayment({
    required String contributionId,
    required String groupId,
    required String userId,
    required String userName,
    required double amount,
    required String currency,
    String? notes,
  }) async {
    try {
      final paymentModel = await remoteDataSource.makeContributionPayment(
        contributionId: contributionId,
        groupId: groupId,
        userId: userId,
        userName: userName,
        amount: amount,
        currency: currency,
        notes: notes,
      );
      return paymentModel;
    } catch (e) {
      throw Exception('Failed to make contribution payment: $e');
    }
  }

  @override
  Future<ContributionPayment> updatePaymentStatus({
    required String paymentId,
    required PaymentStatus status,
    String? transactionId,
  }) async {
    try {
      final paymentModel = await remoteDataSource.updatePaymentStatus(
        paymentId: paymentId,
        status: status,
        transactionId: transactionId,
      );
      return paymentModel;
    } catch (e) {
      throw Exception('Failed to update payment status: $e');
    }
  }

  @override
  Future<ContributionReceipt> generateReceipt(String paymentId) async {
    try {
      final receiptModel = await remoteDataSource.generateReceipt(paymentId);
      return receiptModel;
    } catch (e) {
      throw Exception('Failed to generate receipt: $e');
    }
  }

  @override
  Future<List<ContributionReceipt>> getUserReceipts(String userId) async {
    try {
      final receiptModels = await remoteDataSource.getUserReceipts(userId);
      return receiptModels.cast<ContributionReceipt>();
    } catch (e) {
      throw Exception('Failed to get user receipts: $e');
    }
  }

  @override
  Future<ContributionTranscript> generateContributionTranscript(String contributionId) async {
    try {
      final transcriptModel = await remoteDataSource.generateContributionTranscript(contributionId);
      return transcriptModel;
    } catch (e) {
      throw Exception('Failed to generate contribution transcript: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> getGroupStatistics(String groupId) async {
    try {
      return await remoteDataSource.getGroupStatistics(groupId);
    } catch (e) {
      throw Exception('Failed to get group statistics: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> getUserContributionStats(String userId) async {
    try {
      return await remoteDataSource.getUserContributionStats(userId);
    } catch (e) {
      throw Exception('Failed to get user contribution stats: $e');
    }
  }
} 