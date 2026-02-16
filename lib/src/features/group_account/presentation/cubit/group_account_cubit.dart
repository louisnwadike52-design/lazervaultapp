import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grpc/grpc.dart';
import '../../../../../core/cache/swr_cache_manager.dart';
import '../../../../../core/offline/mutation_queue.dart';
import '../../domain/usecases/group_account_usecases.dart';
import '../../domain/entities/group_entities.dart';
import '../../services/group_account_report_service.dart';
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
  final AddMembersToContribution addMembersToContribution;
  final GetContributionMembers getContributionMembers;
  final GetContributionPayments getContributionPayments;
  final MakeContributionPayment makeContributionPayment;
  final UpdatePaymentStatus updatePaymentStatus;
  final GenerateReceipt generateReceipt;
  final GetUserReceipts getUserReceipts;
  final GenerateContributionTranscript generateContributionTranscript;
  final GetGroupStatistics getGroupStatistics;
  final GetUserContributionStats getUserContributionStats;
  final GetGroupActivityLogs? getGroupActivityLogs;
  final GetContributionActivityLogs? getContributionActivityLogs;
  final RemoveMemberFromContribution? removeMemberFromContribution;
  final ListPublicGroups? listPublicGroups;
  final GetPublicGroup? getPublicGroup;
  final JoinPublicGroup? joinPublicGroup;
  final SWRCacheManager? cacheManager;
  final MutationQueue? mutationQueue;
  final GroupAccountReportService? reportService;

  StreamSubscription<SWRResult<List<GroupAccount>>>? _cacheSubscription;

  // Current user ID and name - set from authentication state
  String? _currentUserId;
  String? get currentUserId => _currentUserId;
  String? _currentUserName;
  String? get currentUserName => _currentUserName;

  // Cached groups list for restoring state when returning from details
  List<GroupAccount>? _cachedGroups;
  List<GroupAccount>? get cachedGroups => _cachedGroups;

  // Cached report for auto-generation events
  GroupAccountReport? _cachedReport;
  GroupAccountReport? get cachedReport => _cachedReport;

  /// Set the current user ID and name from authentication state
  void setUserId(String userId, {String? userName}) {
    _currentUserId = userId;
    if (userName != null) _currentUserName = userName;
    // Automatically load groups when user ID is set
    loadUserGroups();
  }

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
    required this.addMembersToContribution,
    required this.getContributionMembers,
    required this.getContributionPayments,
    required this.makeContributionPayment,
    required this.updatePaymentStatus,
    required this.generateReceipt,
    required this.getUserReceipts,
    required this.generateContributionTranscript,
    required this.getGroupStatistics,
    required this.getUserContributionStats,
    this.getGroupActivityLogs,
    this.getContributionActivityLogs,
    this.removeMemberFromContribution,
    this.listPublicGroups,
    this.getPublicGroup,
    this.joinPublicGroup,
    this.cacheManager,
    this.mutationQueue,
    this.reportService,
  }) : super(GroupAccountInitial());

  @override
  Future<void> close() {
    _cacheSubscription?.cancel();
    return super.close();
  }

  String _getGroupsCacheKey() {
    return 'groups:${_currentUserId ?? 'unknown'}';
  }

  /// Check if an error is a network-related error that should trigger offline queuing
  bool _isNetworkError(dynamic error) {
    if (error is GrpcError) {
      return error.code == StatusCode.unavailable ||
          error.code == StatusCode.deadlineExceeded ||
          error.code == StatusCode.unknown;
    }
    final errorStr = error.toString().toLowerCase();
    return errorStr.contains('network') ||
        errorStr.contains('connection') ||
        errorStr.contains('timeout') ||
        errorStr.contains('unavailable') ||
        errorStr.contains('failed to connect') ||
        errorStr.contains('socket') ||
        errorStr.contains('unreachable');
  }

  // Group management methods
  Future<void> loadUserGroups([String? userId]) async {
    if (isClosed) {
      return;
    }

    // Check if user is authenticated
    final effectiveUserId = userId ?? currentUserId;
    if (effectiveUserId == null) {
      if (isClosed) return;
      emit(const GroupAccountError('User not authenticated. Please log in.'));
      return;
    }

    emit(const GroupAccountLoading(message: 'Loading groups...'));
    try {
      final groups = await getUserGroups(effectiveUserId);
      if (isClosed) return;
      _cachedGroups = groups; // Cache the groups list
      emit(GroupAccountGroupsLoaded(groups));
    } catch (e) {
      if (isClosed) return;
      emit(GroupAccountError('Failed to load groups: ${e.toString()}'));
    }
  }

  Future<void> loadGroupDetails(String groupId, {bool silent = false}) async {
    if (isClosed) {
      return;
    }
    if (!silent) {
      emit(const GroupAccountLoading(message: 'Loading group details...'));
    }
    try {
      final group = await getGroupById(groupId);

      final members = await getGroupMembers(groupId);

      final contributions = await getGroupContributions(groupId);

      if (isClosed) {
        return;
      }
      emit(GroupAccountGroupLoaded(
        group: group,
        members: members,
        contributions: contributions,
      ));
    } catch (e) {
      if (isClosed) return;
      if (!silent) {
        emit(GroupAccountError('Failed to load group details: ${e.toString()}'));
      }
    }
  }

  Future<void> createNewGroup({
    required String name,
    required String description,
    Map<String, dynamic>? metadata,
    GroupVisibility? visibility,
    String? imageUrl,
  }) async {
    if (isClosed) {
      return;
    }
    if (currentUserId == null) {
      emit(const GroupAccountError('User not authenticated'));
      return;
    }
    emit(const GroupAccountLoading(message: 'Creating group...'));
    try {
      final group = await createGroup(CreateGroupParams(
        name: name,
        description: description,
        adminId: currentUserId!,
        metadata: metadata,
        visibility: visibility,
        imageUrl: imageUrl,
      ));
      if (isClosed) return;
      emit(GroupAccountGroupCreated(group));

      // Auto-generate group creation report
      await generateGroupCreationReport(group: group);
    } catch (e) {
      if (isClosed) return;
      emit(GroupAccountError('Failed to create group: ${e.toString()}'));
    }
  }

  Future<void> updateGroupDetails(GroupAccount group) async {
    if (isClosed) return;
    emit(const GroupAccountLoading(message: 'Updating group...'));
    try {
      await updateGroup(group);
      if (isClosed) return;
      // Reload group details silently to preserve UI
      await loadGroupDetails(group.id, silent: true);

      // Check if social links were added and trigger report
      await generateSocialLinkedReport(group: group);
    } catch (e) {
      if (isClosed) return;
      emit(GroupAccountError('Failed to update group: ${e.toString()}'));
    }
  }

  Future<void> deleteGroupAccount(String groupId) async {
    if (isClosed) return;
    emit(const GroupAccountLoading(message: 'Deleting group...'));
    try {
      await deleteGroup(groupId);
      if (isClosed) return;
      emit(const GroupAccountSuccess('Group deleted successfully'));
      // Reload user groups
      await loadUserGroups();
    } catch (e) {
      if (isClosed) return;
      emit(GroupAccountError('Failed to delete group: ${e.toString()}'));
    }
  }

  // Member management methods
  Future<void> searchUsersToAdd(String query) async {
    if (query.length < 2) return;
    
    if (isClosed) return;
    emit(const GroupAccountLoading(message: 'Searching users...'));
    try {
      await searchUsers(query);
      if (isClosed) return;
      emit(GroupAccountSuccess('Users found'));
    } catch (e) {
      if (isClosed) return;
      emit(GroupAccountError('Failed to search users: ${e.toString()}'));
    }
  }

  Future<void> addMemberToGroupAccount({
    required String groupId,
    required String userId,
    required String userName,
    required String email,
    String? profileImage,
    String? username,  // LazerTag username for user lookup
    GroupMemberRole role = GroupMemberRole.member,
  }) async {
    if (isClosed) return;
    emit(const GroupAccountLoading(message: 'Adding member...'));
    try {
      final newMember = await addMemberToGroup(AddMemberParams(
        groupId: groupId,
        userId: userId,
        userName: userName,
        email: email,
        profileImage: profileImage,
        username: username,
        role: role,
      ));
      if (isClosed) return;

      // Emit success with the new member for reactive UI updates
      emit(MemberAddedSuccess(
        member: newMember,
        groupId: groupId,
        message: 'Member added successfully',
      ));
    } catch (e) {
      if (isClosed) return;
      emit(GroupAccountError('Failed to add member: ${e.toString()}'));
    }
  }

  Future<void> updateMemberRoleInGroup({
    required String groupId,
    required String memberId,
    required GroupMemberRole newRole,
  }) async {
    if (isClosed) return;
    emit(const GroupAccountLoading(message: 'Updating member role...'));
    try {
      await updateMemberRole(UpdateMemberRoleParams(
        groupId: groupId,
        memberId: memberId,
        newRole: newRole,
      ));
      if (isClosed) return;
      emit(const GroupAccountSuccess('Member role updated successfully'));
      // Reload group details
      await loadGroupDetails(groupId);
    } catch (e) {
      if (isClosed) return;
      emit(GroupAccountError('Failed to update member role: ${e.toString()}'));
    }
  }

  Future<void> removeMemberFromGroupAccount({
    required String groupId,
    required String memberId,
  }) async {
    if (isClosed) return;
    emit(const GroupAccountLoading(message: 'Removing member...'));
    try {
      await removeMemberFromGroup(RemoveMemberParams(
        groupId: groupId,
        memberId: memberId,
      ));
      if (isClosed) return;
      emit(const GroupAccountSuccess('Member removed successfully'));
      // Reload group details
      await loadGroupDetails(groupId);
    } catch (e) {
      if (isClosed) return;
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
  }) async {
    if (isClosed) return;
    if (currentUserId == null) {
      emit(const GroupAccountError('User not authenticated'));
      return;
    }
    emit(const GroupAccountLoading(message: 'Creating contribution...'));
    try {
      var contribution = await createContribution(CreateContributionParams(
        groupId: groupId,
        title: title,
        description: description,
        targetAmount: targetAmount,
        currency: currency,
        deadline: deadline,
        createdBy: currentUserId!,
        type: type,
        frequency: frequency,
        regularAmount: regularAmount,
        startDate: startDate,
        totalCycles: totalCycles,
        memberRotationOrder: memberRotationOrder,
        autoPayEnabled: autoPayEnabled,
        penaltyAmount: penaltyAmount,
        gracePeriodDays: gracePeriodDays,
        allowPartialPayments: allowPartialPayments,
        minimumBalance: minimumBalance,
        metadata: metadata,
      ));
      if (isClosed) return;

      // Automatically add members from rotation order to the contribution
      if (memberRotationOrder != null && memberRotationOrder.isNotEmpty) {
        debugPrint('🔵 Auto-adding ${memberRotationOrder.length} members to contribution ${contribution.id}');
        try {
          final addedMembers = await addMembersToContribution(AddMembersToContributionParams(
            contributionId: contribution.id,
            memberUserIds: memberRotationOrder,
          ));
          debugPrint('🟢 Successfully added ${addedMembers.length} members to contribution');

          // Update contribution with the added members
          contribution = contribution.copyWith(
            members: addedMembers,
          );
        } catch (e) {
          debugPrint('🟡 Failed to auto-add members: $e (contribution still created)');
          // Don't fail the whole operation if member addition fails
        }
      }

      emit(GroupAccountContributionCreated(contribution));
      // Reload group details to show the new contribution with all data
      await loadGroupDetails(groupId);

      // Get group for auto-generated report
      final group = await getGroupById(groupId);
      if (!isClosed) {
        // Auto-generate contribution created report
        await generateContributionCreatedReport(
          group: group,
          contribution: contribution,
        );
      }
    } catch (e) {
      if (isClosed) return;
      emit(GroupAccountError('Failed to create contribution: ${e.toString()}'));
    }
  }

  Future<void> updateContributionDetails(Contribution contribution) async {
    if (isClosed) return;
    emit(const GroupAccountLoading(message: 'Updating contribution...'));
    try {
      await updateContribution(contribution);
      if (isClosed) return;
      emit(const GroupAccountSuccess('Contribution updated successfully'));
      // Reload group details
      await loadGroupDetails(contribution.groupId);
    } catch (e) {
      if (isClosed) return;
      emit(GroupAccountError('Failed to update contribution: ${e.toString()}'));
    }
  }

  Future<void> deleteContributionFromGroup(String contributionId, String groupId) async {
    if (isClosed) return;
    emit(const GroupAccountLoading(message: 'Deleting contribution...'));
    try {
      await deleteContribution(contributionId);
      if (isClosed) return;
      emit(const GroupAccountSuccess('Contribution deleted successfully'));
      // Reload group details
      await loadGroupDetails(groupId);
    } catch (e) {
      if (isClosed) return;
      emit(GroupAccountError('Failed to delete contribution: ${e.toString()}'));
    }
  }

  // Contribution Member management methods
  Future<void> addMembersToContributionAccount({
    required String contributionId,
    required String groupId,
    required List<String> memberUserIds,
  }) async {
    if (isClosed) return;
    emit(const GroupAccountLoading(message: 'Adding members to contribution...'));
    try {
      final members = await addMembersToContribution(AddMembersToContributionParams(
        contributionId: contributionId,
        memberUserIds: memberUserIds,
      ));
      if (isClosed) return;
      emit(ContributionMembersAdded(
        members: members,
        message: '${members.length} member(s) added to contribution',
      ));
      // Reload group details to refresh the UI
      await loadGroupDetails(groupId);
    } catch (e) {
      if (isClosed) return;
      emit(GroupAccountError('Failed to add members to contribution: ${e.toString()}'));
    }
  }

  Future<List<ContributionMember>> loadContributionMembers(String contributionId) async {
    try {
      final members = await getContributionMembers(contributionId);
      return members;
    } catch (e) {
      return [];
    }
  }

  Future<void> loadContributionDetails(String contributionId) async {
    if (isClosed) return;
    emit(const GroupAccountLoading(message: 'Loading contribution details...'));
    try {
      await getContributionById(contributionId);
      await getContributionPayments(contributionId);
      if (isClosed) return;
      emit(GroupAccountSuccess('Contribution loaded'));
    } catch (e) {
      if (isClosed) return;
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
    String? transactionPin,
    String? sourceAccountId,
    String? idempotencyKey,
  }) async {
    if (isClosed) return;
    if (currentUserId == null) {
      emit(const GroupAccountError('User not authenticated'));
      return;
    }

    // Emit processing state
    emit(ContributionPaymentProcessing(
      contributionId: contributionId,
      amount: amount,
      message: 'Processing payment...',
    ));

    try {
      final payment = await makeContributionPayment(MakePaymentParams(
        contributionId: contributionId,
        groupId: groupId,
        userId: currentUserId!,
        userName: _currentUserName ?? 'User',
        amount: amount,
        currency: currency,
        notes: notes,
        transactionPin: transactionPin,
        sourceAccountId: sourceAccountId,
        idempotencyKey: idempotencyKey,
      ));
      if (isClosed) return;

      // Emit success state with payment details
      emit(ContributionPaymentSuccess(
        payment: payment,
        message: 'Payment completed successfully',
      ));

      // Reload group details to show updated contribution amounts
      await loadGroupDetails(groupId);

      // Get contribution for auto-generated report
      final contribution = await getContributionById(contributionId);
      final group = await getGroupById(groupId);

      if (!isClosed) {
        // Auto-generate payment made report
        await generatePaymentMadeReport(
          group: group,
          contribution: contribution,
          payment: payment,
        );
      }
    } catch (e) {
      if (isClosed) return;

      // For financial operations, show clear error and let user retry manually
      // NEVER queue payments offline - security tokens expire, balances change
      if (_isNetworkError(e)) {
        emit(const ContributionPaymentFailed(
          error: 'No internet connection. Please check your network and try again.',
          isInsufficientBalance: false,
          isPinInvalid: false,
          isDuplicate: false,
        ));
        return;
      }

      // Parse error for specific failure types
      final errorMessage = e.toString();
      final isInsufficientBalance = errorMessage.contains('insufficient') ||
          errorMessage.contains('balance');
      final isPinInvalid =
          errorMessage.contains('PIN') || errorMessage.contains('pin');
      final isDuplicate =
          errorMessage.contains('duplicate') || errorMessage.contains('already');

      emit(ContributionPaymentFailed(
        error: 'Failed to process payment: $errorMessage',
        isInsufficientBalance: isInsufficientBalance,
        isPinInvalid: isPinInvalid,
        isDuplicate: isDuplicate,
      ));
    }
  }

  Future<void> updatePaymentStatusById({
    required String paymentId,
    required PaymentStatus status,
    String? transactionId,
  }) async {
    if (isClosed) return;
    emit(const GroupAccountLoading(message: 'Updating payment status...'));
    try {
      await updatePaymentStatus(UpdatePaymentStatusParams(
        paymentId: paymentId,
        status: status,
        transactionId: transactionId,
      ));
      if (isClosed) return;
      emit(const GroupAccountSuccess('Payment status updated'));
    } catch (e) {
      if (isClosed) return;
      emit(GroupAccountError('Failed to update payment status: ${e.toString()}'));
    }
  }

  // Receipt generation
  Future<void> generatePaymentReceipt(String paymentId) async {
    if (isClosed) return;
    emit(const GroupAccountLoading(message: 'Generating receipt...'));
    try {
      final receipt = await generateReceipt(paymentId);
      if (isClosed) return;
      emit(GroupAccountReceiptGenerated(receipt));
    } catch (e) {
      if (isClosed) return;
      emit(GroupAccountError('Failed to generate receipt: ${e.toString()}'));
    }
  }

  Future<void> loadUserReceipts([String? userId]) async {
    if (isClosed) return;
    final effectiveUserId = userId ?? currentUserId;
    if (effectiveUserId == null) {
      emit(const GroupAccountError('User not authenticated'));
      return;
    }
    emit(const GroupAccountLoading(message: 'Loading receipts...'));
    try {
      await getUserReceipts(effectiveUserId);
      if (isClosed) return;
      emit(GroupAccountSuccess('Receipts loaded'));
    } catch (e) {
      if (isClosed) return;
      emit(GroupAccountError('Failed to load receipts: ${e.toString()}'));
    }
  }

  // Transcript generation
  Future<void> generateTranscriptForContribution(String contributionId) async {
    if (isClosed) return;
    emit(const GroupAccountLoading(message: 'Generating transcript...'));
    try {
      final transcript = await generateContributionTranscript(contributionId);
      if (isClosed) return;
      emit(GroupAccountTranscriptGenerated(transcript));
    } catch (e) {
      if (isClosed) return;
      emit(GroupAccountError('Failed to generate transcript: ${e.toString()}'));
    }
  }

  // Statistics
  Future<void> loadGroupStatistics(String groupId) async {
    if (isClosed) return;
    emit(const GroupAccountLoading(message: 'Loading statistics...'));
    try {
      await getGroupStatistics(groupId);
      if (isClosed) return;
      emit(GroupAccountSuccess('Statistics loaded'));
    } catch (e) {
      if (isClosed) return;
      emit(GroupAccountError('Failed to load statistics: ${e.toString()}'));
    }
  }

  Future<void> loadUserStats([String? userId]) async {
    if (isClosed) return;
    final effectiveUserId = userId ?? currentUserId;
    if (effectiveUserId == null) {
      emit(const GroupAccountError('User not authenticated'));
      return;
    }
    emit(const GroupAccountLoading(message: 'Loading user statistics...'));
    try {
      await getUserContributionStats(effectiveUserId);
      if (isClosed) return;
      emit(GroupAccountSuccess('User statistics loaded'));
    } catch (e) {
      if (isClosed) return;
      emit(GroupAccountError('Failed to load user statistics: ${e.toString()}'));
    }
  }

  // User lookup methods for Add Member feature

  /// Look up user by email address
  /// Returns UserSearchFound if user exists, UserSearchNotFound if not
  Future<void> lookupUserByEmail(String email) async {
    if (email.isEmpty) return;
    if (isClosed) return;

    emit(const UserSearchLoading());
    try {
      // Call searchUsers with email query
      final users = await searchUsers(email);

      if (isClosed) return;

      // Find exact email match
      final exactMatch = users.cast<GroupMember?>().firstWhere(
            (u) => u?.email.toLowerCase() == email.toLowerCase(),
            orElse: () => null,
          );

      if (exactMatch != null) {
        emit(UserSearchFound(
          userId: exactMatch.userId,
          userName: exactMatch.userName,
          email: exactMatch.email,
          profileImage: exactMatch.profileImage,
        ));
      } else {
        emit(UserSearchNotFound(
          searchQuery: email,
          searchType: UserSearchType.email,
        ));
      }
    } catch (e) {
      if (isClosed) return;
      // If search fails, treat as not found (user can still invite)
      emit(UserSearchNotFound(
        searchQuery: email,
        searchType: UserSearchType.email,
      ));
    }
  }

  /// Look up user by LazerTag (username)
  /// Returns UserSearchFound if user exists, UserSearchNotFound if not
  Future<void> lookupUserByLazerTag(String lazerTag) async {
    if (lazerTag.isEmpty) return;
    if (isClosed) return;

    // Remove @ prefix if present
    final cleanTag = lazerTag.startsWith('@') ? lazerTag.substring(1) : lazerTag;

    emit(const UserSearchLoading());
    try {
      // Call searchUsers with username query
      final users = await searchUsers(cleanTag);

      if (isClosed) return;

      // Find exact username match (case-insensitive)
      final exactMatch = users.cast<GroupMember?>().firstWhere(
            (u) => u?.userName.toLowerCase() == cleanTag.toLowerCase(),
            orElse: () => null,
          );

      if (exactMatch != null) {
        emit(UserSearchFound(
          userId: exactMatch.userId,
          userName: exactMatch.userName,
          email: exactMatch.email,
          profileImage: exactMatch.profileImage,
          lazerTag: exactMatch.userName,
        ));
      } else {
        emit(UserSearchNotFound(
          searchQuery: cleanTag,
          searchType: UserSearchType.lazerTag,
        ));
      }
    } catch (e) {
      if (isClosed) return;
      emit(UserSearchNotFound(
        searchQuery: cleanTag,
        searchType: UserSearchType.lazerTag,
      ));
    }
  }

  /// Look up users by phone numbers (batch lookup for contacts)
  /// Returns map of phone -> user info for matching platform users
  Future<Map<String, GroupMember>> lookupUsersByPhones(
      List<String> phoneNumbers) async {
    if (phoneNumbers.isEmpty) return {};

    try {
      final Map<String, GroupMember> results = {};

      // Normalize phone numbers for comparison
      final normalizedPhones = phoneNumbers
          .map((p) => p.replaceAll(RegExp(r'[\s\-\(\)]'), ''))
          .toList();

      // Search for each phone (in batches for efficiency)
      for (final phone in normalizedPhones) {
        if (phone.length >= 7) {
          // Only search valid phone lengths
          try {
            final users = await searchUsers(phone);
            for (final user in users) {
              // Match by partial phone number
              results[phone] = user;
            }
          } catch (_) {
            // Continue with other phones if one fails
          }
        }
      }

      return results;
    } catch (e) {
      return {};
    }
  }

  /// Clear user search state
  void clearUserSearch() {
    if (isClosed) return;
    emit(const UserSearchCleared());
  }

  /// Check if user is already a member of the group
  bool isUserAlreadyMember(String userId, List<GroupMember> members) {
    return members.any((m) => m.userId == userId);
  }

  /// Invite user to group (creates partial member with pending invite)
  Future<void> inviteUserToGroup({
    required String groupId,
    required String identifier, // email or phone
    required String fullName,
    required UserSearchType identifierType,
    GroupMemberRole role = GroupMemberRole.member,
  }) async {
    if (isClosed) return;
    emit(const GroupAccountLoading(message: 'Sending invite...'));

    try {
      // Create a partial member with invite status
      // The backend will handle sending the actual invite notification
      await addMemberToGroup(AddMemberParams(
        groupId: groupId,
        userId: '', // Empty - backend will create pending user
        userName: fullName,
        email: identifierType == UserSearchType.email ? identifier : '',
        role: role,
      ));

      if (isClosed) return;
      emit(InviteSentSuccess(
        message: 'Invite sent to $fullName',
        identifier: identifier,
      ));

      // Reload group details to show the pending member
      await loadGroupDetails(groupId);
    } catch (e) {
      if (isClosed) return;
      emit(GroupAccountError('Failed to send invite: ${e.toString()}'));
    }
  }

  // Utility methods

  /// Restore the groups list state from cache (used when returning from details)
  /// If cache exists, immediately shows cached data. Otherwise triggers a reload.
  void restoreGroupsListState() {
    if (isClosed) return;

    if (_cachedGroups != null && _cachedGroups!.isNotEmpty) {
      emit(GroupAccountGroupsLoaded(_cachedGroups!));
    } else {
      loadUserGroups();
    }
  }

  void clearState() {
    if (isClosed) return;
    emit(GroupAccountInitial());
  }

  void showSuccess(String message) {
    if (isClosed) return;
    emit(GroupAccountSuccess(message));
  }

  void showError(String message) {
    if (isClosed) return;
    emit(GroupAccountError(message));
  }

  // Activity Log methods
  Future<void> loadGroupActivityLogs(String groupId) async {
    if (isClosed) return;
    if (getGroupActivityLogs == null) {
      emit(const GroupAccountError('Activity logs not available'));
      return;
    }

    emit(const ActivityLogsLoading());
    try {
      final logs = await getGroupActivityLogs!(groupId);
      if (isClosed) return;
      emit(GroupActivityLogsLoaded(logs: logs, groupId: groupId));
    } catch (e) {
      if (isClosed) return;
      emit(GroupAccountError('Failed to load activity logs: ${e.toString()}'));
    }
  }

  Future<void> loadContributionActivityLogs(String contributionId) async {
    if (isClosed) return;
    if (getContributionActivityLogs == null) {
      emit(const GroupAccountError('Activity logs not available'));
      return;
    }

    emit(const ActivityLogsLoading());
    try {
      final logs = await getContributionActivityLogs!(contributionId);
      if (isClosed) return;
      emit(ContributionActivityLogsLoaded(logs: logs, contributionId: contributionId));
    } catch (e) {
      if (isClosed) return;
      emit(GroupAccountError('Failed to load activity logs: ${e.toString()}'));
    }
  }

  // Remove member from contribution
  Future<void> removeMemberFromContributionAccount({
    required String contributionId,
    required String groupId,
    required String userId,
  }) async {
    if (isClosed) return;
    if (removeMemberFromContribution == null) {
      emit(const GroupAccountError('Remove member not available'));
      return;
    }

    emit(const GroupAccountLoading(message: 'Removing member...'));
    try {
      await removeMemberFromContribution!(RemoveMemberFromContributionParams(
        contributionId: contributionId,
        userId: userId,
      ));
      if (isClosed) return;
      emit(const GroupAccountSuccess('Member removed from contribution'));
      // Reload group details
      await loadGroupDetails(groupId);
    } catch (e) {
      if (isClosed) return;
      emit(GroupAccountError('Failed to remove member: ${e.toString()}'));
    }
  }

  // Report generation methods

  /// Generate an AI-powered group report
  Future<void> generateReport({
    required GroupAccount group,
    required List<Contribution> contributions,
    List<GroupMember>? members,
    String reportType = 'creation',
    ContributionPayment? payment,
    String? groupUrl,
  }) async {
    if (isClosed) return;
    if (reportService == null) {
      emit(const GroupAccountError('Report service not available'));
      return;
    }

    emit(const GroupAccountReportLoading(message: 'Generating report...'));
    try {
      final report = await reportService!.generateReport(
        group: group,
        contributions: contributions,
        members: members,
        reportType: reportType,
        payment: payment,
      );
      if (isClosed) return;

      _cachedReport = report;
      emit(GroupAccountReportGenerated(
        report: report,
        group: group,
        contributions: contributions,
        groupUrl: groupUrl,
      ));
    } catch (e) {
      if (isClosed) return;
      emit(GroupAccountReportShareError('Failed to generate report: ${e.toString()}'));
    }
  }

  /// Auto-generate report after group creation
  Future<void> generateGroupCreationReport({
    required GroupAccount group,
    List<Contribution>? contributions,
    List<GroupMember>? members,
  }) async {
    if (isClosed) return;
    if (reportService == null) return;

    // Don't emit loading state for auto-generation
    try {
      final report = await reportService!.generateReport(
        group: group,
        contributions: contributions ?? [],
        members: members,
        reportType: 'creation',
      );
      if (isClosed) return;
      _cachedReport = report;
      debugPrint('🟢 Group creation report generated successfully');
    } catch (e) {
      // Silently fail for auto-generation
      debugPrint('🟡 Failed to generate group creation report: $e');
    }
  }

  /// Auto-generate report after social media links are added
  Future<void> generateSocialLinkedReport({
    required GroupAccount group,
    List<Contribution>? contributions,
    List<GroupMember>? members,
  }) async {
    if (isClosed) return;
    if (reportService == null) return;

    // Check if group has social links
    final hasSocialLinks = group.metadata != null &&
        (group.metadata!['whatsapp_group_link'] != null ||
            group.metadata!['telegram_group_link'] != null ||
            group.metadata!['facebook_group_link'] != null);

    if (!hasSocialLinks) return;

    try {
      final report = await reportService!.generateReport(
        group: group,
        contributions: contributions ?? [],
        members: members,
        reportType: 'social_linked',
      );
      if (isClosed) return;
      _cachedReport = report;
      debugPrint('🟢 Social linked report generated successfully');
    } catch (e) {
      debugPrint('🟡 Failed to generate social linked report: $e');
    }
  }

  /// Auto-generate report after contribution creation
  Future<void> generateContributionCreatedReport({
    required GroupAccount group,
    required Contribution contribution,
    List<GroupMember>? members,
  }) async {
    if (isClosed) return;
    if (reportService == null) return;

    try {
      final report = await reportService!.generateReport(
        group: group,
        contributions: [contribution],
        members: members,
        reportType: 'contribution_created',
      );
      if (isClosed) return;
      _cachedReport = report;
      debugPrint('🟢 Contribution created report generated successfully');
    } catch (e) {
      debugPrint('🟡 Failed to generate contribution created report: $e');
    }
  }

  /// Auto-generate report after payment is made
  Future<void> generatePaymentMadeReport({
    required GroupAccount group,
    required Contribution contribution,
    required ContributionPayment payment,
    List<GroupMember>? members,
  }) async {
    if (isClosed) return;
    if (reportService == null) return;

    try {
      final report = await reportService!.generateReport(
        group: group,
        contributions: [contribution],
        members: members,
        reportType: 'payment_made',
        payment: payment,
      );
      if (isClosed) return;
      _cachedReport = report;
      debugPrint('🟢 Payment made report generated successfully');
    } catch (e) {
      debugPrint('🟡 Failed to generate payment made report: $e');
    }
  }

  /// Share report to WhatsApp
  Future<void> shareReportToWhatsApp(
    GroupAccountReport report,
    String? groupUrl,
  ) async {
    if (isClosed) return;
    if (reportService == null) {
      emit(const GroupAccountReportShareError('Report service not available'));
      return;
    }

    try {
      await reportService!.shareToWhatsApp(report, groupUrl: groupUrl);
      if (isClosed) return;
      emit(const GroupAccountReportShared(message: 'Shared to WhatsApp'));
    } catch (e) {
      if (isClosed) return;
      emit(GroupAccountReportShareError('Failed to share: ${e.toString()}'));
    }
  }

  /// Share report to Telegram
  Future<void> shareReportToTelegram(
    GroupAccountReport report,
    String? groupUrl,
  ) async {
    if (isClosed) return;
    if (reportService == null) {
      emit(const GroupAccountReportShareError('Report service not available'));
      return;
    }

    try {
      await reportService!.shareToTelegram(report, groupUrl: groupUrl);
      if (isClosed) return;
      emit(const GroupAccountReportShared(message: 'Shared to Telegram'));
    } catch (e) {
      if (isClosed) return;
      emit(GroupAccountReportShareError('Failed to share: ${e.toString()}'));
    }
  }

  /// Share report to Facebook
  Future<void> shareReportToFacebook(
    GroupAccountReport report,
    String? groupUrl,
  ) async {
    if (isClosed) return;
    if (reportService == null) {
      emit(const GroupAccountReportShareError('Report service not available'));
      return;
    }

    try {
      await reportService!.shareToFacebook(report, groupUrl: groupUrl);
      if (isClosed) return;
      emit(const GroupAccountReportShared(message: 'Shared to Facebook'));
    } catch (e) {
      if (isClosed) return;
      emit(GroupAccountReportShareError('Failed to share: ${e.toString()}'));
    }
  }

  /// Share report to Twitter/X
  Future<void> shareReportToTwitter(
    GroupAccountReport report,
    String? groupUrl,
  ) async {
    if (isClosed) return;
    if (reportService == null) {
      emit(const GroupAccountReportShareError('Report service not available'));
      return;
    }

    try {
      await reportService!.shareToTwitter(report, groupUrl: groupUrl);
      if (isClosed) return;
      emit(const GroupAccountReportShared(message: 'Shared to Twitter'));
    } catch (e) {
      if (isClosed) return;
      emit(GroupAccountReportShareError('Failed to share: ${e.toString()}'));
    }
  }

  /// General share using system share sheet
  Future<void> shareReportGeneral(
    GroupAccountReport report,
    String? groupUrl,
  ) async {
    if (isClosed) return;
    if (reportService == null) {
      emit(const GroupAccountReportShareError('Report service not available'));
      return;
    }

    try {
      await reportService!.shareGeneral(report, groupUrl: groupUrl);
      if (isClosed) return;
      emit(const GroupAccountReportShared(message: 'Report shared'));
    } catch (e) {
      if (isClosed) return;
      emit(GroupAccountReportShareError('Failed to share: ${e.toString()}'));
    }
  }

  /// Get shareable text for clipboard
  String? getShareableText(GroupAccountReport report, String? groupUrl) {
    if (reportService == null) return null;
    return reportService!.getShareableText(report, groupUrl: groupUrl);
  }

  // ============================================================================
  // PUBLIC GROUP DISCOVERY
  // ============================================================================

  // SWR cache for public groups
  List<GroupAccount>? _cachedPublicGroups;

  /// Load public groups for discovery/browse (with SWR caching)
  Future<void> loadPublicGroups({
    String? sortBy,
    String? search,
    int page = 1,
    int pageSize = 20,
  }) async {
    if (isClosed) return;
    if (listPublicGroups == null) {
      emit(const GroupAccountError('Public groups not available'));
      return;
    }

    // SWR: emit cached data immediately if available (fresh load, no search, page 1)
    final isFreshLoad = search == null && page == 1;
    if (isFreshLoad && _cachedPublicGroups != null && _cachedPublicGroups!.isNotEmpty) {
      emit(PublicGroupsLoaded(
        groups: _cachedPublicGroups!,
        totalCount: _cachedPublicGroups!.length,
        isStale: true,
      ));
    } else {
      emit(const GroupAccountLoading(message: 'Loading public groups...'));
    }

    try {
      final groups = await listPublicGroups!(
        page: page,
        pageSize: pageSize,
        sortBy: sortBy,
        searchQuery: search,
      );
      if (isClosed) return;
      // Cache only fresh page-1 loads without search
      if (isFreshLoad) {
        _cachedPublicGroups = groups;
      }
      emit(PublicGroupsLoaded(groups: groups, totalCount: groups.length, isStale: false));
    } catch (e) {
      if (isClosed) return;
      // On error with cached data, keep showing cached
      if (isFreshLoad && _cachedPublicGroups != null && _cachedPublicGroups!.isNotEmpty) {
        return;
      }
      emit(GroupAccountError('Failed to load public groups: ${e.toString()}'));
    }
  }

  /// Get details of a public group (for non-members)
  Future<void> loadPublicGroupDetail(String groupId) async {
    if (isClosed) return;
    if (getPublicGroup == null) {
      emit(const GroupAccountError('Public group details not available'));
      return;
    }
    if (groupId.trim().isEmpty) {
      emit(const GroupAccountError('Invalid group ID'));
      return;
    }

    emit(const GroupAccountLoading(message: 'Loading group details...'));
    try {
      final detail = await getPublicGroup!(groupId);
      if (isClosed) return;
      emit(PublicGroupDetailLoaded(detail));
    } catch (e) {
      if (isClosed) return;
      emit(GroupAccountError('Failed to load group details: ${e.toString()}'));
    }
  }

  /// Join a public group
  Future<void> joinPublicGroupById(String groupId) async {
    if (isClosed) return;
    if (joinPublicGroup == null) {
      emit(const GroupAccountError('Join group not available'));
      return;
    }
    if (groupId.trim().isEmpty) {
      emit(const GroupAccountError('Invalid group ID'));
      return;
    }

    emit(const GroupAccountLoading(message: 'Joining group...'));
    try {
      final group = await joinPublicGroup!(groupId);
      if (isClosed) return;
      // Invalidate public groups cache so next load fetches fresh data
      _cachedPublicGroups = null;
      emit(JoinPublicGroupSuccess(group: group));
      // Reload user groups to include the new one
      await loadUserGroups();
    } catch (e) {
      if (isClosed) return;
      final errorMsg = e.toString();
      // Distinguish "already a member" errors
      if (errorMsg.contains('AlreadyExists') || errorMsg.contains('already a member')) {
        emit(const GroupAccountError('You are already a member of this group'));
      } else {
        emit(GroupAccountError('Failed to join group: $errorMsg'));
      }
    }
  }
} 