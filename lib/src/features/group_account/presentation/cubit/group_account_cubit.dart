import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/group_account_usecases.dart';
import '../../domain/entities/group_entities.dart';
import 'group_account_state.dart';

class GroupAccountCubit extends Cubit<GroupAccountState> {
  final GetUserGroups getUserGroups;
  final GetGroupById getGroupById;
  final CreateGroup createGroup;
  final UpdateGroup updateGroup;
  final DeleteGroup deleteGroup;
  final GetGroupMembers getGroupMembers;
  final AddMemberToGroup addMemberToGroup;
  final UpdateMemberRole updateMemberRole;
  final RemoveMemberFromGroup removeMemberFromGroup;
  final SearchUsers searchUsers;
  final GetGroupContributions getGroupContributions;
  final GetContributionById getContributionById;
  final CreateContribution createContribution;
  final UpdateContribution updateContribution;
  final DeleteContribution deleteContribution;
  final GetContributionPayments getContributionPayments;
  final MakeContributionPayment makeContributionPayment;
  final UpdatePaymentStatus updatePaymentStatus;
  final GenerateReceipt generateReceipt;
  final GetUserReceipts getUserReceipts;
  final GenerateContributionTranscript generateContributionTranscript;
  final GetGroupStatistics getGroupStatistics;
  final GetUserContributionStats getUserContributionStats;

  // Current user ID - in real app, get from auth service
  String get currentUserId => 'current_user_123';

  GroupAccountCubit({
    required this.getUserGroups,
    required this.getGroupById,
    required this.createGroup,
    required this.updateGroup,
    required this.deleteGroup,
    required this.getGroupMembers,
    required this.addMemberToGroup,
    required this.updateMemberRole,
    required this.removeMemberFromGroup,
    required this.searchUsers,
    required this.getGroupContributions,
    required this.getContributionById,
    required this.createContribution,
    required this.updateContribution,
    required this.deleteContribution,
    required this.getContributionPayments,
    required this.makeContributionPayment,
    required this.updatePaymentStatus,
    required this.generateReceipt,
    required this.getUserReceipts,
    required this.generateContributionTranscript,
    required this.getGroupStatistics,
    required this.getUserContributionStats,
  }) : super(GroupAccountInitial());

  // Group management methods
  Future<void> loadUserGroups([String? userId]) async {
    emit(const GroupAccountLoading(message: 'Loading groups...'));
    try {
      final groups = await getUserGroups(userId ?? currentUserId);
      emit(GroupAccountGroupsLoaded(groups));
    } catch (e) {
      emit(GroupAccountError('Failed to load groups: ${e.toString()}'));
    }
  }

  Future<void> loadGroupDetails(String groupId) async {
    emit(const GroupAccountLoading(message: 'Loading group details...'));
    try {
      final group = await getGroupById(groupId);
      final members = await getGroupMembers(groupId);
      final contributions = await getGroupContributions(groupId);
      
      emit(GroupAccountGroupLoaded(
        group: group,
        members: members,
        contributions: contributions,
      ));
    } catch (e) {
      emit(GroupAccountError('Failed to load group details: ${e.toString()}'));
    }
  }

  Future<void> createNewGroup({
    required String name,
    required String description,
  }) async {
    emit(const GroupAccountLoading(message: 'Creating group...'));
    try {
      final group = await createGroup(CreateGroupParams(
        name: name,
        description: description,
        adminId: currentUserId,
      ));
      emit(GroupAccountGroupCreated(group));
    } catch (e) {
      emit(GroupAccountError('Failed to create group: ${e.toString()}'));
    }
  }

  Future<void> updateGroupDetails(GroupAccount group) async {
    emit(const GroupAccountLoading(message: 'Updating group...'));
    try {
      final updatedGroup = await updateGroup(group);
      emit(GroupAccountSuccess('Group updated successfully'));
      // Reload group details
      await loadGroupDetails(group.id);
    } catch (e) {
      emit(GroupAccountError('Failed to update group: ${e.toString()}'));
    }
  }

  Future<void> deleteGroupAccount(String groupId) async {
    emit(const GroupAccountLoading(message: 'Deleting group...'));
    try {
      await deleteGroup(groupId);
      emit(const GroupAccountSuccess('Group deleted successfully'));
      // Reload user groups
      await loadUserGroups();
    } catch (e) {
      emit(GroupAccountError('Failed to delete group: ${e.toString()}'));
    }
  }

  // Member management methods
  Future<void> searchUsersToAdd(String query) async {
    if (query.length < 2) return;
    
    emit(const GroupAccountLoading(message: 'Searching users...'));
    try {
      final users = await searchUsers(query);
      emit(GroupAccountSuccess('Users found'));
    } catch (e) {
      emit(GroupAccountError('Failed to search users: ${e.toString()}'));
    }
  }

  Future<void> addMemberToGroupAccount({
    required String groupId,
    required String userId,
    required String userName,
    required String email,
    String? profileImage,
    GroupMemberRole role = GroupMemberRole.member,
  }) async {
    emit(const GroupAccountLoading(message: 'Adding member...'));
    try {
      await addMemberToGroup(AddMemberParams(
        groupId: groupId,
        userId: userId,
        userName: userName,
        email: email,
        profileImage: profileImage,
        role: role,
      ));
      emit(const GroupAccountSuccess('Member added successfully'));
      // Reload group details
      await loadGroupDetails(groupId);
    } catch (e) {
      emit(GroupAccountError('Failed to add member: ${e.toString()}'));
    }
  }

  Future<void> updateMemberRoleInGroup({
    required String groupId,
    required String memberId,
    required GroupMemberRole newRole,
  }) async {
    emit(const GroupAccountLoading(message: 'Updating member role...'));
    try {
      await updateMemberRole(UpdateMemberRoleParams(
        groupId: groupId,
        memberId: memberId,
        newRole: newRole,
      ));
      emit(const GroupAccountSuccess('Member role updated successfully'));
      // Reload group details
      await loadGroupDetails(groupId);
    } catch (e) {
      emit(GroupAccountError('Failed to update member role: ${e.toString()}'));
    }
  }

  Future<void> removeMemberFromGroupAccount({
    required String groupId,
    required String memberId,
  }) async {
    emit(const GroupAccountLoading(message: 'Removing member...'));
    try {
      await removeMemberFromGroup(RemoveMemberParams(
        groupId: groupId,
        memberId: memberId,
      ));
      emit(const GroupAccountSuccess('Member removed successfully'));
      // Reload group details
      await loadGroupDetails(groupId);
    } catch (e) {
      emit(GroupAccountError('Failed to remove member: ${e.toString()}'));
    }
  }

  // Contribution management methods
  Future<void> createNewContribution({
    required String groupId,
    required String title,
    required String description,
    required double targetAmount,
    required String currency,
    required DateTime deadline,
  }) async {
    emit(const GroupAccountLoading(message: 'Creating contribution...'));
    try {
      final contribution = await createContribution(CreateContributionParams(
        groupId: groupId,
        title: title,
        description: description,
        targetAmount: targetAmount,
        currency: currency,
        deadline: deadline,
        createdBy: currentUserId,
      ));
      emit(GroupAccountContributionCreated(contribution));
      // Reload group details to show the new contribution
      await loadGroupDetails(groupId);
    } catch (e) {
      emit(GroupAccountError('Failed to create contribution: ${e.toString()}'));
    }
  }

  Future<void> updateContributionDetails(Contribution contribution) async {
    emit(const GroupAccountLoading(message: 'Updating contribution...'));
    try {
      await updateContribution(contribution);
      emit(const GroupAccountSuccess('Contribution updated successfully'));
      // Reload group details
      await loadGroupDetails(contribution.groupId);
    } catch (e) {
      emit(GroupAccountError('Failed to update contribution: ${e.toString()}'));
    }
  }

  Future<void> deleteContributionFromGroup(String contributionId, String groupId) async {
    emit(const GroupAccountLoading(message: 'Deleting contribution...'));
    try {
      await deleteContribution(contributionId);
      emit(const GroupAccountSuccess('Contribution deleted successfully'));
      // Reload group details
      await loadGroupDetails(groupId);
    } catch (e) {
      emit(GroupAccountError('Failed to delete contribution: ${e.toString()}'));
    }
  }

  Future<void> loadContributionDetails(String contributionId) async {
    emit(const GroupAccountLoading(message: 'Loading contribution details...'));
    try {
      final contribution = await getContributionById(contributionId);
      final payments = await getContributionPayments(contributionId);
      emit(GroupAccountSuccess('Contribution loaded'));
    } catch (e) {
      emit(GroupAccountError('Failed to load contribution: ${e.toString()}'));
    }
  }

  // Payment methods
  Future<void> makePaymentToContribution({
    required String contributionId,
    required String groupId,
    required double amount,
    required String currency,
    String? notes,
  }) async {
    emit(const GroupAccountLoading(message: 'Processing payment...'));
    try {
      final payment = await makeContributionPayment(MakePaymentParams(
        contributionId: contributionId,
        groupId: groupId,
        userId: currentUserId,
        userName: 'Current User', // In real app, get from user service
        amount: amount,
        currency: currency,
        notes: notes,
      ));
      emit(GroupAccountPaymentCompleted(payment));
      // Reload group details to show updated contribution amounts
      await loadGroupDetails(groupId);
    } catch (e) {
      emit(GroupAccountError('Failed to process payment: ${e.toString()}'));
    }
  }

  Future<void> updatePaymentStatusById({
    required String paymentId,
    required PaymentStatus status,
    String? transactionId,
  }) async {
    emit(const GroupAccountLoading(message: 'Updating payment status...'));
    try {
      await updatePaymentStatus(UpdatePaymentStatusParams(
        paymentId: paymentId,
        status: status,
        transactionId: transactionId,
      ));
      emit(const GroupAccountSuccess('Payment status updated'));
    } catch (e) {
      emit(GroupAccountError('Failed to update payment status: ${e.toString()}'));
    }
  }

  // Receipt generation
  Future<void> generatePaymentReceipt(String paymentId) async {
    emit(const GroupAccountLoading(message: 'Generating receipt...'));
    try {
      final receipt = await generateReceipt(paymentId);
      emit(GroupAccountReceiptGenerated(receipt));
    } catch (e) {
      emit(GroupAccountError('Failed to generate receipt: ${e.toString()}'));
    }
  }

  Future<void> loadUserReceipts([String? userId]) async {
    emit(const GroupAccountLoading(message: 'Loading receipts...'));
    try {
      final receipts = await getUserReceipts(userId ?? currentUserId);
      emit(GroupAccountSuccess('Receipts loaded'));
    } catch (e) {
      emit(GroupAccountError('Failed to load receipts: ${e.toString()}'));
    }
  }

  // Transcript generation
  Future<void> generateTranscriptForContribution(String contributionId) async {
    emit(const GroupAccountLoading(message: 'Generating transcript...'));
    try {
      final transcript = await generateContributionTranscript(contributionId);
      emit(GroupAccountTranscriptGenerated(transcript));
    } catch (e) {
      emit(GroupAccountError('Failed to generate transcript: ${e.toString()}'));
    }
  }

  // Statistics
  Future<void> loadGroupStatistics(String groupId) async {
    emit(const GroupAccountLoading(message: 'Loading statistics...'));
    try {
      final stats = await getGroupStatistics(groupId);
      emit(GroupAccountSuccess('Statistics loaded'));
    } catch (e) {
      emit(GroupAccountError('Failed to load statistics: ${e.toString()}'));
    }
  }

  Future<void> loadUserStats([String? userId]) async {
    emit(const GroupAccountLoading(message: 'Loading user statistics...'));
    try {
      final stats = await getUserContributionStats(userId ?? currentUserId);
      emit(GroupAccountSuccess('User statistics loaded'));
    } catch (e) {
      emit(GroupAccountError('Failed to load user statistics: ${e.toString()}'));
    }
  }

  // Utility methods
  void clearState() {
    emit(GroupAccountInitial());
  }

  void showSuccess(String message) {
    emit(GroupAccountSuccess(message));
  }

  void showError(String message) {
    emit(GroupAccountError(message));
  }
} 