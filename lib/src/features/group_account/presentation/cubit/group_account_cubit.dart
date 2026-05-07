import 'dart:async';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:grpc/grpc.dart';
import 'package:lazervault/core/utils/user_search_query.dart';
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
  final PreviewMemberExit? previewMemberExit;
  final ListPublicGroups? listPublicGroups;
  final GetPublicGroup? getPublicGroup;
  final JoinPublicGroup? joinPublicGroup;
  final GroupAccountReportService? reportService;
  // Live session source-of-truth. Reads the same `user_id` storage key
  // the auth cubit writes (see authentication_cubit.dart `_userIdKey`).
  // Used to detect a user-ID mismatch that bypassed setUserId/clearOnLogout
  // — a critical safeguard because a stale _currentUserId would resolve
  // the WRONG user's source account on payment.
  //
  // Important: this is OPTIONAL evidence, not authoritative. A null read
  // from secure storage may simply mean the read raced (e.g. on a fresh
  // process startup). We never wipe state on a null read, only on a
  // positive mismatch with a non-null live id. The cubit's own
  // `_currentUserId` (set by setUserId from the auth state) is the
  // primary source of truth.
  final FlutterSecureStorage _secureStorage;
  static const String _liveUserIdKey = 'user_id';

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

  // Snapshot of the last GroupAccountGroupLoaded payload. Used by mutation
  // handlers to apply optimistic patches without refetching, and by views
  // (e.g. GroupDetailsScreen) to render the last good state when the
  // cubit's current state is something unrelated (e.g. a payment-flow
  // emission that doesn't carry group data). The getters expose the
  // snapshot read-only — never mutate it from a view.
  GroupAccount? _lastLoadedGroup;
  List<GroupMember>? _lastLoadedMembers;
  List<Contribution>? _lastLoadedContributions;

  GroupAccount? get lastLoadedGroup => _lastLoadedGroup;
  List<GroupMember>? get lastLoadedMembers => _lastLoadedMembers;
  List<Contribution>? get lastLoadedContributions => _lastLoadedContributions;

  /// Set the current user ID and name from authentication state.
  ///
  /// The cubit is a long-lived singleton (see app_router.dart for why) so
  /// any user-ID change must wipe per-user caches before the next load,
  /// otherwise stale data from the previous account leaks into the new one.
  void setUserId(String userId, {String? userName}) {
    final isUserSwitch = _currentUserId != null && _currentUserId != userId;
    if (isUserSwitch) {
      _clearUserScopedState();
    }
    _currentUserId = userId;
    if (userName != null) _currentUserName = userName;
    // Automatically load groups when user ID is set
    loadUserGroups();
  }

  /// Drop every piece of in-memory state owned by the previous user.
  /// Safe to call at any time — used by setUserId on user switch and by
  /// the auth flow on explicit logout.
  void clearOnLogout() {
    _currentUserId = null;
    _currentUserName = null;
    _clearUserScopedState();
    if (!isClosed) {
      emit(GroupAccountInitial());
    }
  }

  void _clearUserScopedState() {
    _cachedGroups = null;
    _cachedReport = null;
    _cachedPublicGroups = null;
    _lastLoadedGroup = null;
    _lastLoadedMembers = null;
    _lastLoadedContributions = null;
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
    this.previewMemberExit,
    this.listPublicGroups,
    this.getPublicGroup,
    this.joinPublicGroup,
    this.reportService,
    FlutterSecureStorage? secureStorage,
  })  : _secureStorage = secureStorage ?? const FlutterSecureStorage(),
        super(GroupAccountInitial());

  /// Verify the cached `_currentUserId` still matches the live session.
  /// Returns the user ID to operate as.
  ///
  /// Three outcomes:
  ///
  ///  1. Live read agrees with the cubit's `_currentUserId` → return it.
  ///  2. Live read disagrees (non-null and != cached) → user actually
  ///     switched without going through setUserId. Wipe per-user state
  ///     and adopt the live id. This is the security guard.
  ///  3. Live read is null OR throws → secure storage isn't yet readable
  ///     (e.g. the app just resumed from background). DON'T treat that
  ///     as a logout. Trust the cubit's `_currentUserId` if we have one;
  ///     only emit "not authenticated" if BOTH are unknown.
  ///
  /// The previous implementation used a TokenManager that read from a
  /// `user_session` storage key the auth flow never writes — so it
  /// returned null on every call, falsely tripping the "Session expired"
  /// path on every group-detail load. The fix reads the SAME `user_id`
  /// key the auth cubit writes, and treats a null/error read as "no
  /// signal" rather than a positive logout.
  Future<String?> _assertSessionUser() async {
    String? liveId;
    try {
      liveId = await _secureStorage.read(key: _liveUserIdKey);
    } catch (e) {
      debugPrint('[GroupAccountCubit] secure storage read failed: $e');
      liveId = null;
    }

    if (liveId == null) {
      // No signal from storage — fall back to the cubit's own state.
      // If we have it, trust it; if we don't, only THEN surface the
      // unauthenticated error (the dashboard router should never have
      // dropped us here without an auth state).
      if (_currentUserId != null) return _currentUserId;
      if (!isClosed) {
        emit(const GroupAccountError('Please log in to view your groups.'));
      }
      return null;
    }

    if (_currentUserId != null && _currentUserId != liveId) {
      // Real user-switch detected. Wipe per-user state so the next op
      // uses the new user's account.
      debugPrint('[GroupAccountCubit] user mismatch '
          'cached=$_currentUserId live=$liveId — clearing caches');
      _clearUserScopedState();
      _currentUserName = null;
    }
    _currentUserId = liveId;
    return liveId;
  }

  /// Snapshot of the loaded group/members/contributions tuple. Used by
  /// optimistic mutations to revert if the server rejects the change.
  _LoadedSnapshot? _snapshotLoaded() {
    if (_lastLoadedGroup == null ||
        _lastLoadedMembers == null ||
        _lastLoadedContributions == null) {
      return null;
    }
    return _LoadedSnapshot(
      group: _lastLoadedGroup!,
      members: List.of(_lastLoadedMembers!),
      contributions: List.of(_lastLoadedContributions!),
    );
  }

  /// Apply a patch to the cached snapshot and emit GroupAccountGroupLoaded
  /// immediately. Optional fields default to the current cached value.
  void _patchLoaded({
    GroupAccount? group,
    List<GroupMember>? members,
    List<Contribution>? contributions,
  }) {
    if (_lastLoadedGroup == null ||
        _lastLoadedMembers == null ||
        _lastLoadedContributions == null) {
      return;
    }
    _lastLoadedGroup = group ?? _lastLoadedGroup;
    _lastLoadedMembers = members ?? _lastLoadedMembers;
    _lastLoadedContributions = contributions ?? _lastLoadedContributions;
    if (!isClosed) {
      emit(GroupAccountGroupLoaded(
        group: _lastLoadedGroup!,
        members: _lastLoadedMembers!,
        contributions: _lastLoadedContributions!,
      ));
    }
  }

  /// Restore the cached snapshot (used after a failed optimistic mutation).
  void _restoreSnapshot(_LoadedSnapshot snapshot) {
    _lastLoadedGroup = snapshot.group;
    _lastLoadedMembers = snapshot.members;
    _lastLoadedContributions = snapshot.contributions;
    if (!isClosed) {
      emit(GroupAccountGroupLoaded(
        group: snapshot.group,
        members: snapshot.members,
        contributions: snapshot.contributions,
      ));
    }
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

  // Group management methods.
  //
  // SWR semantics: if `_cachedGroups` is non-empty, emit it IMMEDIATELY and
  // refetch in the background. The user never sees a spinner on revisits.
  // Only the first cold load shows GroupAccountLoading. On background
  // refresh failure we keep the cached state visible (no error toast for a
  // background blip), the user-visible flow only flips to error on cold
  // failure.
  Future<void> loadUserGroups([String? userId]) async {
    if (isClosed) {
      return;
    }

    final effectiveUserId = userId ?? currentUserId;
    if (effectiveUserId == null) {
      if (isClosed) return;
      emit(const GroupAccountError('User not authenticated. Please log in.'));
      return;
    }

    final hasCache = _cachedGroups != null && _cachedGroups!.isNotEmpty;
    if (hasCache) {
      // Serve from cache immediately. UI renders instantly.
      emit(GroupAccountGroupsLoaded(_cachedGroups!));
    } else {
      emit(const GroupAccountLoading(message: 'Loading groups...'));
    }

    try {
      final groups = await getUserGroups(effectiveUserId);
      if (isClosed) return;
      _cachedGroups = groups;
      emit(GroupAccountGroupsLoaded(groups));
    } catch (e) {
      if (isClosed) return;
      if (hasCache) {
        // Background refresh failed but the user already sees cached data.
        // Stay quiet. Logging only so we don't trigger an error UI for
        // what the user perceives as a working screen.
        debugPrint('[GroupAccountCubit] background refresh of groups failed: $e');
        return;
      }
      emit(GroupAccountError('Failed to load groups: ${e.toString()}'));
    }
  }

  /// Load (or refresh) a group's full details.
  ///
  /// SWR semantics:
  ///   - If we have a snapshot for this exact group already, emit it
  ///     IMMEDIATELY (so back-navigation from a contribution shows the
  ///     group page populated, no spinner) and refresh in the background.
  ///   - Background refresh emits a fresh GroupAccountGroupLoaded only on
  ///     success and only if the data actually changed (Equatable handles
  ///     the diff so the BlocConsumer skips redundant rebuilds).
  ///   - Background refresh failure is silent — the user still sees the
  ///     cached snapshot, no error toast for a transient blip.
  ///   - Cold load (no cache, or cache for a different group) shows
  ///     Loading once, and a real error on failure.
  ///
  /// `silent: true` is preserved for legacy callers that explicitly want
  /// no Loading state even on a cold path. With SWR baked in, most
  /// callers don't need to pass it any more.
  Future<void> loadGroupDetails(String groupId, {bool silent = false}) async {
    if (isClosed) {
      return;
    }

    // Verify session before reading per-user data; clears caches if user
    // changed under us. Skipped on silent reloads to avoid extra storage
    // I/O on rapid sequential refreshes.
    if (!silent) {
      final liveUserId = await _assertSessionUser();
      if (liveUserId == null) return;
    }

    final hasSnapshot = _lastLoadedGroup != null &&
        _lastLoadedGroup!.id == groupId &&
        _lastLoadedMembers != null &&
        _lastLoadedContributions != null;

    if (hasSnapshot) {
      // Serve from cache immediately so the screen renders instantly.
      emit(GroupAccountGroupLoaded(
        group: _lastLoadedGroup!,
        members: _lastLoadedMembers!,
        contributions: _lastLoadedContributions!,
      ));
    } else if (!silent) {
      emit(const GroupAccountLoading(message: 'Loading group details...'));
    }

    try {
      // Three independent reads — fan out so total wall time is one RTT
      // instead of three.
      final results = await Future.wait([
        getGroupById(groupId),
        getGroupMembers(groupId),
        getGroupContributions(groupId),
      ]);

      if (isClosed) {
        return;
      }
      final group = results[0] as GroupAccount;
      final members = results[1] as List<GroupMember>;
      final contributions = results[2] as List<Contribution>;
      _lastLoadedGroup = group;
      _lastLoadedMembers = members;
      _lastLoadedContributions = contributions;
      emit(GroupAccountGroupLoaded(
        group: group,
        members: members,
        contributions: contributions,
      ));
    } catch (e) {
      if (isClosed) return;
      if (hasSnapshot) {
        // Background refresh of a screen that's already showing cached
        // data — don't surface to the UI; just log. The user sees the
        // last good snapshot rather than a regression to an error view.
        debugPrint('[GroupAccountCubit] background refresh of group $groupId failed: $e');
        return;
      }
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

    // No GroupAccountLoading emit. The bottom sheet manages its own
    // button-level "Creating..." state; emitting a global Loading would
    // wipe the My Groups list under the user (regressing UX after the
    // SWR work). The list stays visible.
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

      // Reactively append the new group to the cached list and emit a
      // fresh GroupAccountGroupsLoaded so the My Groups tab updates
      // without a network round-trip. The previous flow's
      // `loadUserGroups()` reload (a full re-fetch + spinner) is now
      // unnecessary — the row we just received from the create RPC is
      // already authoritative.
      final updated = [group, ..._cachedGroups ?? const <GroupAccount>[]];
      _cachedGroups = updated;
      emit(GroupAccountGroupCreated(group));
      emit(GroupAccountGroupsLoaded(updated));

      // Auto-generate group creation report (background, non-blocking
      // for UI rendering).
      unawaited(generateGroupCreationReport(group: group));
    } catch (e) {
      if (isClosed) return;
      emit(GroupAccountError('Failed to create group: ${e.toString()}'));
    }
  }

  Future<void> updateGroupDetails(GroupAccount group) async {
    if (isClosed) return;
    final snapshot = _snapshotLoaded();
    // Optimistic patch: show the new group payload immediately so the
    // group-details screen behind any open bottom sheet reflects the
    // edit while the network call is in flight.
    if (snapshot != null && snapshot.group.id == group.id) {
      _patchLoaded(group: group);
    }
    // Explicit Loading state so callers (e.g. EditGroupBottomSheet)
    // can render a button-level spinner. The optimistic _patchLoaded
    // above ALSO emits GroupAccountGroupLoaded, so listeners that
    // care about save state must filter via listenWhen — see the
    // bottom sheet for the canonical pattern.
    emit(const GroupAccountLoading(message: 'Updating group...'));
    try {
      await updateGroup(group);
      if (isClosed) return;
      // No reload — the local cache already reflects the change.
      await generateSocialLinkedReport(group: group);
      if (isClosed) return;
      // Re-emit the loaded snapshot first so any BlocBuilder reading
      // group state goes back to the rendered tree (otherwise it
      // stays stuck on Loading until something else emits Loaded).
      if (_lastLoadedGroup != null && _lastLoadedGroup!.id == group.id &&
          _lastLoadedMembers != null && _lastLoadedContributions != null) {
        emit(GroupAccountGroupLoaded(
          group: _lastLoadedGroup!,
          members: _lastLoadedMembers!,
          contributions: _lastLoadedContributions!,
        ));
      }
      // Terminal success — bottom sheets listen for this to auto-close.
      emit(const GroupAccountSuccess('Group updated successfully'));
    } catch (e) {
      if (isClosed) return;
      if (snapshot != null) _restoreSnapshot(snapshot);
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
      final users = await searchUsers(query);
      if (isClosed) return;
      emit(UsersFound(users: users, query: query));
    } catch (e) {
      if (isClosed) return;
      emit(GroupAccountError('Failed to search users: ${e.toString()}'));
    }
  }

  /// Adds a member to a group.
  ///
  /// Returns the newly-created [GroupMember] on success, or `null` on
  /// failure. The cubit still emits `MemberAddedSuccess` /
  /// `GroupAccountError` so listeners that care about cross-cutting
  /// effects (snackbars, parent reload) keep working — but callers
  /// that need to know *this specific call's* outcome should await
  /// the return value rather than racing the listener.
  Future<GroupMember?> addMemberToGroupAccount({
    required String groupId,
    required String userId,
    required String userName,
    required String email,
    String? profileImage,
    String? username,  // LazerTag username for user lookup
    GroupMemberRole role = GroupMemberRole.member,
  }) async {
    if (isClosed) return null;
    // No GroupAccountLoading emit: the bottom sheet has its own button-
    // level loading state, and a global Loading would clobber the group-
    // details screen behind the sheet (regression to "Loading group
    // details..." spinner that doesn't recover until the sheet closes).
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
      if (isClosed) return newMember;

      // Optimistically append to the cached snapshot so the group-details
      // members list updates instantly when the bottom sheet pops. The
      // backend has already committed the row.
      if (_lastLoadedGroup != null && _lastLoadedGroup!.id == groupId &&
          _lastLoadedMembers != null) {
        final dedup = _lastLoadedMembers!
            .where((m) => m.userId != newMember.userId)
            .toList()
          ..add(newMember);
        _lastLoadedMembers = dedup;
        if (_lastLoadedContributions != null) {
          emit(GroupAccountGroupLoaded(
            group: _lastLoadedGroup!,
            members: dedup,
            contributions: _lastLoadedContributions!,
          ));
        }
      }

      emit(MemberAddedSuccess(
        member: newMember,
        groupId: groupId,
        message: 'Member added successfully',
      ));
      return newMember;
    } catch (e) {
      if (isClosed) return null;
      emit(GroupAccountError('Failed to add member: ${e.toString()}'));
      return null;
    }
  }

  Future<void> updateMemberRoleInGroup({
    required String groupId,
    required String memberId,
    required GroupMemberRole newRole,
  }) async {
    if (isClosed) return;
    final snapshot = _snapshotLoaded();
    if (snapshot != null && snapshot.group.id == groupId) {
      final patched = snapshot.members
          .map((m) => m.id == memberId ? m.copyWith(role: newRole) : m)
          .toList();
      _patchLoaded(members: patched);
    }
    try {
      await updateMemberRole(UpdateMemberRoleParams(
        groupId: groupId,
        memberId: memberId,
        newRole: newRole,
      ));
      if (isClosed) return;
      emit(const GroupAccountSuccess('Member role updated successfully'));
    } catch (e) {
      if (isClosed) return;
      if (snapshot != null) _restoreSnapshot(snapshot);
      emit(GroupAccountError('Failed to update member role: ${e.toString()}'));
    }
  }

  Future<void> removeMemberFromGroupAccount({
    required String groupId,
    required String memberId,
  }) async {
    if (isClosed) return;
    final snapshot = _snapshotLoaded();
    if (snapshot != null && snapshot.group.id == groupId) {
      final patched =
          snapshot.members.where((m) => m.id != memberId).toList();
      _patchLoaded(members: patched);
    }
    try {
      await removeMemberFromGroup(RemoveMemberParams(
        groupId: groupId,
        memberId: memberId,
      ));
      if (isClosed) return;
      emit(const GroupAccountSuccess('Member removed successfully'));
    } catch (e) {
      if (isClosed) return;
      if (snapshot != null) _restoreSnapshot(snapshot);
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
    bool autoPayoutEnabled = false,
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
        autoPayoutEnabled: autoPayoutEnabled,
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

      // IMPORTANT: refresh the group's contribution list BEFORE emitting
      // ContributionCreated. The bottom sheet listens to that event to
      // dismiss; if we emit early, the sheet closes while the
      // contributions tab is still showing the stale list — the user
      // sees their new pot appear a beat later. Awaiting first means
      // the loader on the Create CTA stays visible until the parent
      // tab is fresh, then the sheet pops with the row already in view.
      await loadGroupDetails(groupId);
      if (isClosed) return;
      emit(GroupAccountContributionCreated(contribution));

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
    final snapshot = _snapshotLoaded();
    if (snapshot != null && snapshot.group.id == contribution.groupId) {
      final patched = snapshot.contributions
          .map((c) => c.id == contribution.id ? contribution : c)
          .toList();
      _patchLoaded(contributions: patched);
    }
    try {
      await updateContribution(contribution);
      if (isClosed) return;
      emit(const GroupAccountSuccess('Contribution updated successfully'));
    } catch (e) {
      if (isClosed) return;
      if (snapshot != null) _restoreSnapshot(snapshot);
      emit(GroupAccountError('Failed to update contribution: ${e.toString()}'));
    }
  }

  Future<void> deleteContributionFromGroup(String contributionId, String groupId) async {
    if (isClosed) return;
    final snapshot = _snapshotLoaded();
    if (snapshot != null && snapshot.group.id == groupId) {
      final patched = snapshot.contributions
          .where((c) => c.id != contributionId)
          .toList();
      _patchLoaded(contributions: patched);
    }
    try {
      await deleteContribution(contributionId);
      if (isClosed) return;
      emit(const GroupAccountSuccess('Contribution deleted successfully'));
    } catch (e) {
      if (isClosed) return;
      if (snapshot != null) _restoreSnapshot(snapshot);
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
    // CRITICAL: assert the cached user ID matches the live session BEFORE
    // touching any money. If the singleton's _currentUserId is stale, the
    // backend will resolve sourceAccountId from the wrong user and debit
    // the wrong account. Refuse the payment outright if we can't confirm
    // who is paying.
    final liveUserId = await _assertSessionUser();
    if (liveUserId == null) return;

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
        userId: liveUserId,
        userName: _currentUserName ?? 'User',
        amount: amount,
        currency: currency,
        notes: notes,
        transactionPin: transactionPin,
        sourceAccountId: sourceAccountId,
        idempotencyKey: idempotencyKey,
      ));
      if (isClosed) return;

      // Branch on the AUTHORITATIVE payment status from the backend.
      // The backend returns the same row on idempotent retries, so a
      // retried in-flight payment correctly stays "in flight" in the UI
      // instead of falsely showing success. This is load-bearing for
      // money-safety messaging.
      final status = payment.status;
      if (status == PaymentStatus.completed) {
        emit(ContributionPaymentSuccess(
          payment: payment,
          message: 'Payment completed successfully',
        ));
      } else if (status == PaymentStatus.failed) {
        emit(ContributionPaymentFailed(
          error: 'Payment failed. Please try again with a different amount or account.',
          isInsufficientBalance: false,
          isPinInvalid: false,
          isDuplicate: false,
        ));
        return;
      } else if (status == PaymentStatus.refunded) {
        emit(const ContributionPaymentFailed(
          error: 'Payment was reversed and refunded to your account.',
          isInsufficientBalance: false,
          isPinInvalid: false,
          isDuplicate: false,
        ));
        return;
      } else if (status == PaymentStatus.refunding) {
        emit(const ContributionPaymentFailed(
          error: 'Payment failed after debit. Your refund is being processed and will appear in your account shortly.',
          isInsufficientBalance: false,
          isPinInvalid: false,
          isDuplicate: false,
        ));
        return;
      } else if (status == PaymentStatus.awaitingVerification ||
          status == PaymentStatus.processing ||
          status == PaymentStatus.pending) {
        // Still in flight at the backend. Surface as processing so the
        // UI keeps a "verifying" state and the user does NOT retry.
        emit(ContributionPaymentProcessing(
          contributionId: contributionId,
          amount: amount,
          message: status == PaymentStatus.awaitingVerification
              ? 'Verifying your payment with our payment provider…'
              : 'Processing your payment…',
        ));
        return;
      } else if (status == PaymentStatus.manualReview) {
        emit(const ContributionPaymentFailed(
          error: 'Your payment is under review by our team. Please contact support; do not retry.',
          isInsufficientBalance: false,
          isPinInvalid: false,
          isDuplicate: false,
        ));
        return;
      } else {
        emit(ContributionPaymentSuccess(
          payment: payment,
          message: 'Payment recorded',
        ));
      }

      // Only the `completed` path warrants patching contribution.current_amount
      // and generating the success report. For any other status the amount
      // either hasn't been credited (in flight / failed) or has been
      // reversed (refunded / refunding) — patching would lie to the user.
      if (status != PaymentStatus.completed) {
        return;
      }

      // Optimistically patch local state from cached GroupAccountGroupLoaded
      // instead of refetching three endpoints. The server already incremented
      // current_amount; we mirror that locally and skip the round trip.
      GroupAccount freshGroup;
      Contribution freshContribution;
      final canPatch = _lastLoadedGroup != null &&
          _lastLoadedGroup!.id == groupId &&
          _lastLoadedContributions != null &&
          _lastLoadedMembers != null;
      final cachedContribution = canPatch
          ? _lastLoadedContributions!.firstWhereOrNull(
              (c) => c.id == contributionId,
            )
          : null;

      if (canPatch && cachedContribution != null) {
        final patchedContributions = _lastLoadedContributions!
            .map((c) => c.id == contributionId
                ? c.copyWith(currentAmount: c.currentAmount + amount)
                : c)
            .toList();
        freshGroup = _lastLoadedGroup!;
        freshContribution = patchedContributions.firstWhere(
          (c) => c.id == contributionId,
        );
        _lastLoadedContributions = patchedContributions;
        emit(GroupAccountGroupLoaded(
          group: freshGroup,
          members: _lastLoadedMembers!,
          contributions: patchedContributions,
        ));
      } else {
        // Cold path: parallel fetch (one RTT) instead of three sequential.
        final results = await Future.wait([
          getGroupById(groupId),
          getContributionById(contributionId),
        ]);
        if (isClosed) return;
        freshGroup = results[0] as GroupAccount;
        freshContribution = results[1] as Contribution;
      }

      if (!isClosed) {
        await generatePaymentMadeReport(
          group: freshGroup,
          contribution: freshContribution,
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

      // Authoritative exact match: API returns masked email; use server flag only.
      final exactMatch = users.cast<GroupMember?>().firstWhere(
            (u) => u?.emailMatchesSearchQuery == true,
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
          searchQuery: normalizeLazerVaultUserSearchQuery(email),
          searchType: UserSearchType.email,
        ));
      }
    } catch (e) {
      if (isClosed) return;
      // If search fails, treat as not found (user can still invite)
      emit(UserSearchNotFound(
        searchQuery: normalizeLazerVaultUserSearchQuery(email),
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
            final exact = users.cast<GroupMember?>().firstWhere(
                  (u) => u?.phoneMatchesSearchQueryExact == true,
                  orElse: () => null,
                );
            if (exact != null) {
              results[phone] = exact;
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
  /// Invites someone (by email/phone) to a group. Returns `true` on
  /// success, `false` on failure. State is still emitted for cross-
  /// cutting listeners; the return value is for callers that need
  /// per-call resolution without listener gymnastics.
  Future<bool> inviteUserToGroup({
    required String groupId,
    required String identifier, // email or phone
    required String fullName,
    required UserSearchType identifierType,
    GroupMemberRole role = GroupMemberRole.member,
  }) async {
    if (isClosed) return false;
    // No GroupAccountLoading emit (see addMemberToGroupAccount above).
    try {
      final invited = await addMemberToGroup(AddMemberParams(
        groupId: groupId,
        userId: '', // Empty: backend creates a pending/partial user
        userName: fullName,
        email: identifierType == UserSearchType.email ? identifier : '',
        role: role,
      ));

      if (isClosed) return true;

      // Optimistic append, same pattern as addMemberToGroupAccount.
      if (_lastLoadedGroup != null && _lastLoadedGroup!.id == groupId &&
          _lastLoadedMembers != null) {
        final dedup = _lastLoadedMembers!
            .where((m) => m.userId != invited.userId || invited.userId.isEmpty)
            .toList()
          ..add(invited);
        _lastLoadedMembers = dedup;
        if (_lastLoadedContributions != null) {
          emit(GroupAccountGroupLoaded(
            group: _lastLoadedGroup!,
            members: dedup,
            contributions: _lastLoadedContributions!,
          ));
        }
      }

      emit(InviteSentSuccess(
        message: 'Invite sent to $fullName',
        identifier: identifier,
      ));
      return true;
    } catch (e) {
      if (isClosed) return false;
      emit(GroupAccountError('Failed to send invite: ${e.toString()}'));
      return false;
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

  // Remove member from contribution. Returns the saga decision so
  // the caller (bottom sheet / dialog) can show a refund-confirmed
  // toast instead of a generic "removed" message.
  //
  // Returns null on failure; emits GroupAccountError with the reason
  // (e.g. "exit blocked: contribution settled") so the listener can
  // surface that to the user without re-decoding the exception.
  Future<MemberExitResult?> removeMemberFromContributionAccount({
    required String contributionId,
    required String groupId,
    required String userId,
  }) async {
    if (isClosed) return null;
    if (removeMemberFromContribution == null) {
      emit(const GroupAccountError('Remove member not available'));
      return null;
    }

    emit(const GroupAccountLoading(message: 'Removing member...'));
    try {
      final result = await removeMemberFromContribution!(
          RemoveMemberFromContributionParams(
        contributionId: contributionId,
        userId: userId,
      ));
      if (isClosed) return result;
      emit(GroupAccountSuccess(_describeExitResult(result)));
      // Reload group details so member list, current_amount, and
      // any cycle state derived from membership all refresh.
      await loadGroupDetails(groupId);
      return result;
    } catch (e) {
      if (isClosed) return null;
      emit(GroupAccountError('Failed to remove member: ${e.toString()}'));
      return null;
    }
  }

  /// Non-side-effecting peek at the saga's decision. Returns null on
  /// failure; the cubit does NOT emit on this path because a preview
  /// is always called inline from a bottom-sheet that owns its own
  /// loading state — letting the cubit emit Loading would race with
  /// other cubit consumers (the contribution detail screen).
  Future<MemberExitPreview?> previewMemberExitForContribution({
    required String contributionId,
    required String userId,
  }) async {
    if (isClosed) return null;
    if (previewMemberExit == null) return null;
    try {
      return await previewMemberExit!(RemoveMemberFromContributionParams(
        contributionId: contributionId,
        userId: userId,
      ));
    } catch (_) {
      return null;
    }
  }

  String _describeExitResult(MemberExitResult r) {
    if (r.refundAmount > 0) {
      final amt = r.refundAmount.toStringAsFixed(2);
      switch (r.refundStatus) {
        case 'completed':
          return 'Member removed. Refunded $amt.';
        case 'pending':
          return 'Member removed. Refund of $amt is pending — we\'ll retry the credit shortly.';
        case 'failed':
          return 'Member removed. Refund of $amt failed; ops has been notified.';
      }
    }
    return 'Member removed from contribution';
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

  /// Get details of a public group (for non-members).
  ///
  /// Emits the dedicated `PublicGroupDetailLoading` / `PublicGroupDetailError`
  /// states (NOT the global `GroupAccountLoading` / `GroupAccountError`)
  /// so the leaderboard list rendered behind the bottom sheet doesn't
  /// rebuild and lose its scroll position when the user taps a row.
  Future<void> loadPublicGroupDetail(String groupId) async {
    if (isClosed) return;
    if (getPublicGroup == null) {
      emit(PublicGroupDetailError(
        groupId: groupId,
        message: 'Public group details not available',
      ));
      return;
    }
    if (groupId.trim().isEmpty) {
      emit(const PublicGroupDetailError(
        groupId: '',
        message: 'Invalid group ID',
      ));
      return;
    }

    emit(PublicGroupDetailLoading(groupId));
    try {
      final detail = await getPublicGroup!(groupId);
      if (isClosed) return;
      emit(PublicGroupDetailLoaded(detail));
    } catch (e) {
      if (isClosed) return;
      emit(PublicGroupDetailError(
        groupId: groupId,
        message: 'Failed to load group details: ${e.toString()}',
      ));
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

/// Holds a copy of the last GroupAccountGroupLoaded payload so a failed
/// optimistic mutation can revert the UI without refetching.
class _LoadedSnapshot {
  final GroupAccount group;
  final List<GroupMember> members;
  final List<Contribution> contributions;

  const _LoadedSnapshot({
    required this.group,
    required this.members,
    required this.contributions,
  });
} 