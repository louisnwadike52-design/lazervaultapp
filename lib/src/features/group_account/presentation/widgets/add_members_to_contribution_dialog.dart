import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/utils/debouncer.dart';
import 'package:lazervault/core/utils/user_search_query.dart';
import 'package:lazervault/src/features/profile/cubit/profile_cubit.dart';
import 'package:lazervault/src/features/tag_pay/domain/entities/user_search_result_entity.dart';
import '../../domain/entities/group_entities.dart';
import '../cubit/group_account_cubit.dart';
import '../cubit/group_account_state.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/src/features/recipients/presentation/widgets/unified_user_search_sheet.dart';
import 'package:lazervault/src/features/widgets/pay_flow_theme.dart';
import 'contact_picker_bottom_sheet.dart';
part 'add_members_to_contribution_dialog_widgets.dart';

class AddMembersToContributionDialog extends StatefulWidget {
  final Contribution contribution;
  final VoidCallback? onMembersAdded;

  const AddMembersToContributionDialog({
    super.key,
    required this.contribution,
    this.onMembersAdded,
  });

  @override
  State<AddMembersToContributionDialog> createState() =>
      _AddMembersToContributionDialogState();
}

class _AddMembersToContributionDialogState
    extends State<AddMembersToContributionDialog>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Existing group members tab
  List<GroupMember> _groupMembers = [];
  Set<String> _selectedMemberIds = {};
  /// Names dropped by the validity filter in the last submit, so the failure
  /// message can name them instead of blaming "invalid user IDs".
  final List<String> _skippedPartial = [];
  Set<String> _existingMemberUserIds = {};
  bool _isLoading = true;
  bool _isAdding = false;
  bool _selectAll = false;

  /// Helper to get display name with fallback for empty names
  String _getDisplayName(GroupMember member) {
    if (member.userName.isNotEmpty) return member.userName;
    if (member.userUsername != null && member.userUsername!.isNotEmpty) {
      return '@${member.userUsername}';
    }
    if (member.email.isNotEmpty) {
      // Use part before @ as display name
      final atIndex = member.email.indexOf('@');
      if (atIndex > 0) {
        return member.email.substring(0, atIndex);
      }
      return member.email;
    }
    return 'Unknown User';
  }

  /// Helper to get initials for avatar
  String _getInitials(GroupMember member) {
    final displayName = _getDisplayName(member);
    if (displayName.startsWith('@')) {
      return displayName.length > 1 ? displayName[1].toUpperCase() : 'U';
    }
    return displayName.isNotEmpty ? displayName[0].toUpperCase() : 'U';
  }

  // Add new member tab
  final _searchController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _focusNode = FocusNode();
  final _debouncer = Debouncer.search();
  List<UserSearchResultEntity> _searchResults = [];
  bool _isSearching = false;
  String? _errorMessage;
  bool _showInviteUI = false;

  // Selected new members to add
  final List<_NewMemberSelection> _newMembersToAdd = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadGroupMembers();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    _fullNameController.dispose();
    _focusNode.dispose();
    _debouncer.dispose();
    super.dispose();
  }

  Future<void> _loadGroupMembers() async {
    if (mounted) {
      setState(() {
        _isLoading = true;
      });
    }

    try {
      final cubit = context.read<GroupAccountCubit>();

      // Seed the "already in this contribution" set from the snapshot the
      // caller handed us, then refresh it from the cubit below.
      _refreshExistingMemberIds(cubit);

      // Paint from the parent's cache when it's for THIS group, but never
      // trust it as final: someone added to the group moments ago is not in
      // it yet, and the picker would silently omit the very person the user
      // came here to add — which surfaced as "could not be added. They may
      // have invalid user IDs". The BlocListener below swaps in the fresh
      // roster when loadGroupDetails lands.
      var members = cubit.lastLoadedMembers;
      final haveUsableCache = members != null &&
          cubit.lastLoadedGroup?.id == widget.contribution.groupId;
      if (haveUsableCache) {
        unawaited(cubit.loadGroupDetails(widget.contribution.groupId));
      }
      if (members == null ||
          cubit.lastLoadedGroup?.id != widget.contribution.groupId) {
        // Cold path: parent's cache is empty or for a different group.
        // Trigger a reload + await the cubit's stream until the matching
        // GroupAccountGroupLoaded lands.
        final completer = Completer<List<GroupMember>>();
        late final StreamSubscription<GroupAccountState> sub;
        sub = cubit.stream.listen((state) {
          if (state is GroupAccountGroupLoaded &&
              state.group.id == widget.contribution.groupId) {
            if (!completer.isCompleted) completer.complete(state.members);
          } else if (state is GroupAccountError) {
            if (!completer.isCompleted) completer.completeError(state.message);
          }
        });
        // Kick the cubit; it'll emit Loading → Loaded → ContributionLoaded.
        unawaited(cubit.loadGroupDetails(widget.contribution.groupId));
        try {
          members = await completer.future.timeout(const Duration(seconds: 15));
        } finally {
          await sub.cancel();
        }
      }

      if (!mounted) return;
      setState(() {
        _groupMembers = members ?? const <GroupMember>[];
        // Re-derive AFTER the (re)load above so the exclusion set reflects
        // the live roster, not the snapshot we were constructed with.
        _refreshExistingMemberIds(cubit);
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
      _showError('Failed to load group members: $e');
    }
  }

  /// Rebuild the "already in this contribution" exclusion set from the
  /// CURRENT server state.
  ///
  /// This used to read `widget.contribution.members` only — the snapshot
  /// captured when the dialog was constructed. Removing a member soft-
  /// deletes their row server-side (`removed_at` + `deleted_at`) and every
  /// members query filters `deleted_at IS NULL`, so the live list is
  /// correct; but if the parent screen was holding a pre-removal
  /// contribution (e.g. the refreshed group page didn't carry this
  /// contribution, so `_currentContribution` never re-assigned) the sheet
  /// kept reporting the removed user as "Already in this contribution" and
  /// they could never be added back.
  ///
  /// [GroupAccountCubit.lastLoadedContributions] is refreshed by the
  /// `loadGroupDetails` that the exit saga fires on success, so it is the
  /// freshest thing the dialog can see. Falls back to the constructor
  /// snapshot when the cache holds a different group.
  ///
  /// Members are keyed by USER ID only — never name or email.
  void _refreshExistingMemberIds(GroupAccountCubit cubit) {
    final live = cubit.lastLoadedContributions
        ?.where((c) => c.id == widget.contribution.id)
        .firstOrNull;
    final source = live?.members ?? widget.contribution.members;
    _existingMemberUserIds = source
        .map((m) => m.userId)
        .where((id) => id.isNotEmpty)
        .toSet();
  }

  void _showError(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: const Color(0xFFEF4444),
        ),
      );
    }
  }

  void _toggleSelectAll() {
    setState(() {
      _selectAll = !_selectAll;
      if (_selectAll) {
        _selectedMemberIds = _groupMembers
            .where((m) => !_existingMemberUserIds.contains(m.userId))
            .map((m) => m.id)
            .toSet();
      } else {
        _selectedMemberIds.clear();
      }
    });
  }

  void _toggleMember(String memberId) {
    setState(() {
      if (_selectedMemberIds.contains(memberId)) {
        _selectedMemberIds.remove(memberId);
        _selectAll = false;
      } else {
        _selectedMemberIds.add(memberId);
        _selectAll = _selectedMemberIds.length == _groupMembers.length;
      }
    });
  }

  // Search functionality for new members
  void _onSearchChanged(String query) {
    _debouncer.cancel();

    setState(() {
      _showInviteUI = false;
    });

    final cleanQuery = normalizeLazerVaultUserSearchQuery(query);

    if (cleanQuery.isEmpty) {
      setState(() {
        _searchResults = [];
        _isSearching = false;
        _errorMessage = null;
      });
      return;
    }

    if (cleanQuery.length < 2) {
      setState(() {
        _searchResults = [];
        _isSearching = false;
        _errorMessage = null;
      });
      return;
    }

    setState(() {
      _isSearching = true;
      _errorMessage = null;
    });

    _debouncer.run(() => _performSearch(query));
  }

  Future<void> _performSearch(String query) async {
    // Snapshot the in-flight query so a stale debounce-fire (user kept
    // typing) doesn't clobber the latest results. Each call captures
    // its own query; we only commit results if it still matches the
    // controller's current text after the await resolves.
    final inFlightQuery = query;
    try {
      // Use the SAME ProfileCubit + repository path that the recipient
      // username search bottom sheet uses (the canonical app-wide
      // profile search, backed by auth-service.SearchUsers gRPC).
      // Resolving from serviceLocator here (not BlocProvider.of) so
      // the cubit reaches us even when the dialog is mounted inside
      // a tab whose BLoC scope doesn't include ProfileCubit.
      final cubit = serviceLocator<ProfileCubit>();
      // ignore: avoid_print
      print('[AddMembersDialog] searchUsers("$inFlightQuery") starting');
      final results = await cubit.searchUsers(inFlightQuery);
      // ignore: avoid_print
      print(
          '[AddMembersDialog] searchUsers("$inFlightQuery") -> ${results.length} result(s)');

      if (!mounted) return;
      // Drop stale fires: if the user has kept typing past this query,
      // a more recent _performSearch is already in flight. Letting the
      // older fire commit would briefly flash old results into the UI.
      if (_searchController.text.trim() != inFlightQuery.trim()) {
        return;
      }
      setState(() {
        _searchResults = results;
        _isSearching = false;
        if (results.isEmpty) {
          if (_isValidEmail(inFlightQuery)) {
            _showInviteUI = true;
            _fullNameController.clear();
            _errorMessage = null;
          } else {
            _showInviteUI = false;
            _errorMessage = 'No users found';
          }
        } else {
          _showInviteUI = false;
          _errorMessage = null;
        }
      });
    } catch (e, st) {
      // ignore: avoid_print
      print('[AddMembersDialog] searchUsers("$inFlightQuery") FAILED: $e\n$st');
      if (!mounted) return;
      // Same staleness guard on the error path.
      if (_searchController.text.trim() != inFlightQuery.trim()) {
        return;
      }
      setState(() {
        _searchResults = [];
        _isSearching = false;
        _errorMessage = 'Failed to search users';
      });
    }
  }

  bool _isValidEmail(String value) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value);
  }

  void _selectNewUser(UserSearchResultEntity user) {
    if (_newMembersToAdd.any((m) => m.user?.userId == user.userId)) {
      return;
    }

    setState(() {
      _newMembersToAdd.add(_NewMemberSelection(user: user));
      _searchResults = [];
      _searchController.clear();
    });
  }

  /// Opens the shared unified search (saved contacts incl. alias → global),
  /// then adds the picked user to the new-members list.
  ///
  /// internalOnly: a contribution participant MUST be a LazerVault user —
  /// the member row is keyed on their user id and they have to be able to
  /// sign in and pay. The shared sheet's default (false) also surfaces
  /// saved EXTERNAL bank beneficiaries, which resolve to an empty userId
  /// and would enrol an unidentifiable member. Scoped here rather than in
  /// the sheet so send-funds / split-bill keep their bank results.
  Future<void> _openUnifiedSearch() async {
    final result = await UnifiedUserSearchSheet.show(context,
        title: 'Add member', internalOnly: true);
    if (result == null || !mounted) return;
    _selectNewUser(result.toUserSearchResultEntity());
  }

  void _openContactPicker() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ContactPickerBottomSheet(
        onContactSelected: _applyPickedContact,
      ),
    );
  }

  /// Takes a confirmed contact straight to a staged selection — same contract
  /// as the group-level sheet, so the two levels behave identically.
  ///
  /// The contact already supplied both a handle and a name and the user has
  /// already confirmed them in the picker, so there is nothing left to ask
  /// unless the handle is genuinely ambiguous.
  Future<void> _applyPickedContact(
    String name,
    String identifier,
    ContactIdentifierType type,
  ) async {
    if (!mounted) return;
    setState(() {
      _searchController.text = identifier;
      _fullNameController.text = name;
      _isSearching = true;
      _errorMessage = null;
      _showInviteUI = false;
      _searchResults = [];
    });

    List<UserSearchResultEntity> results = const [];
    try {
      results = await serviceLocator<ProfileCubit>()
          .searchUsers(normalizeLazerVaultUserSearchQuery(identifier));
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _isSearching = false;
        _errorMessage = 'Could not check that contact. Try searching instead.';
      });
      return;
    }
    if (!mounted) return;

    if (results.length == 1) {
      final user = results.first;
      if (_newMembersToAdd.any((m) => m.user?.userId == user.userId)) {
        setState(() {
          _isSearching = false;
          _searchController.clear();
          _fullNameController.clear();
          _errorMessage = '${user.fullName} is already in your list.';
        });
        return;
      }
      setState(() {
        _isSearching = false;
        _searchController.clear();
        _fullNameController.clear();
      });
      _selectNewUser(user);
      return;
    }

    if (results.length > 1) {
      setState(() {
        _isSearching = false;
        _searchResults = results;
      });
      return;
    }

    // Not on LazerVault. A contribution participant must be a real user, so we
    // cannot stage them as a member — but we CAN invite them to the group, and
    // they join the contribution once they accept. Say that plainly instead of
    // dead-ending on "no users found".
    setState(() {
      _isSearching = false;
      _showInviteUI = _isValidEmail(identifier) || _isValidPhone(identifier);
      _errorMessage = _showInviteUI
          ? null
          : "$name has no email or phone we can send an invite to.";
    });
  }

  /// A phone handle we can send an invite to: 7-15 digits, optional leading
  /// '+', tolerating the spaces/dashes/parens device contacts carry. Mirrors
  /// the group-level sheet so both surfaces accept the same handles.
  bool _isValidPhone(String value) {
    final digits = value.replaceAll(RegExp(r'[^0-9+]'), '');
    return RegExp(r'^\+?[0-9]{7,15}$').hasMatch(digits);
  }

  void _addPendingInvite() {
    final email = _searchController.text.trim();
    final fullName = _fullNameController.text.trim();

    if (email.isEmpty || fullName.isEmpty) return;

    if (_newMembersToAdd.any((m) => m.email == email)) {
      return;
    }

    setState(() {
      _newMembersToAdd.add(_NewMemberSelection(
        email: email,
        fullName: fullName,
      ));
      _searchController.clear();
      _fullNameController.clear();
      _showInviteUI = false;
    });
  }

  void _removeNewMember(int index) {
    setState(() {
      _newMembersToAdd.removeAt(index);
    });
  }

  bool _isUserAlreadyInGroup(UserSearchResultEntity user) {
    return _groupMembers.any((m) => m.userId == user.userId);
  }

  bool _isUserAlreadyInContribution(UserSearchResultEntity user) {
    return _existingMemberUserIds.contains(user.userId);
  }

  bool _isUserAlreadySelected(UserSearchResultEntity user) {
    return _newMembersToAdd.any((m) => m.user?.userId == user.userId);
  }

  void _addSelectedMembers() async {
    final hasGroupMembers = _selectedMemberIds.isNotEmpty;
    final hasNewMembers = _newMembersToAdd.isNotEmpty;

    if (!hasGroupMembers && !hasNewMembers) {
      _showError('Please select at least one member');
      return;
    }

    setState(() {
      _isAdding = true;
    });

    final cubit = context.read<GroupAccountCubit>();

    try {
      // Step 1: Add new members to the group first (if any)
      final newMemberUserIds = <String>[];

      for (final newMember in _newMembersToAdd) {
        if (newMember.user != null) {
          // Add existing Lazervault user to the group
          await cubit.addMemberToGroupAccount(
            groupId: widget.contribution.groupId,
            userId: newMember.user!.userId,
            userName: newMember.user!.fullName,
            email: newMember.user!.email,
            profileImage: newMember.user!.profilePicture,
            username: newMember.user!.username,
            role: GroupMemberRole.member,
          );
          newMemberUserIds.add(newMember.user!.userId);
        } else if (newMember.email != null && newMember.fullName != null) {
          // Invite non-Lazervault user
          await cubit.inviteUserToGroup(
            groupId: widget.contribution.groupId,
            identifier: newMember.email!,
            fullName: newMember.fullName!,
            identifierType: UserSearchType.email,
            role: GroupMemberRole.member,
          );
          // Note: Can't add to contribution until they accept the invite
        }
      }

      // Step 2: Collect all user IDs to add to contribution
      final allUserIdsToAdd = <String>[];

      // Debug: Log selected member IDs and group members
      debugPrint('🔵 AddMembers: _selectedMemberIds=$_selectedMemberIds');
      debugPrint('🔵 AddMembers: _groupMembers count=${_groupMembers.length}');
      for (final m in _groupMembers) {
        debugPrint(
            '🔵 AddMembers: Member id=${m.id}, userId=${m.userId}, name=${m.userName}, isPartial=${m.isPartial}');
      }

      // Add selected group members - use more robust filtering
      final selectedMembers = _groupMembers
          .where((m) => _selectedMemberIds.contains(m.id))
          .toList();

      debugPrint(
          '🔵 AddMembers: selectedMembers (by id) count=${selectedMembers.length}');

      // Filter to only valid user IDs, REMEMBERING why anyone was dropped.
      // Previously every rejection collapsed into one "they may have invalid
      // user IDs" snackbar, which is both wrong and unactionable: the real
      // reasons are distinct and each has a different remedy.
      _skippedPartial.clear();
      final validSelectedUserIds = selectedMembers
          .where((m) {
            final hasUserId = m.userId.isNotEmpty &&
                m.userId != '00000000-0000-0000-0000-000000000000';
            if (!hasUserId) {
              debugPrint(
                  '🟡 AddMembers: Skipping ${m.userName} — no resolvable user id');
              _skippedPartial.add(m.userName.trim().isEmpty
                  ? 'A selected member'
                  : m.userName);
              return false;
            }
            if (m.isPartial) {
              debugPrint(
                  '🟡 AddMembers: Skipping ${m.userName} — account not completed');
              _skippedPartial.add(m.userName.trim().isEmpty
                  ? 'A selected member'
                  : m.userName);
              return false;
            }
            return true;
          })
          .map((m) => m.userId)
          .toList();

      debugPrint('🔵 AddMembers: validSelectedUserIds=$validSelectedUserIds');
      allUserIdsToAdd.addAll(validSelectedUserIds);

      // Add newly added Lazervault users
      allUserIdsToAdd.addAll(newMemberUserIds);

      debugPrint('🔵 AddMembers: Final allUserIdsToAdd=$allUserIdsToAdd');

      // Step 3: Add all members to the contribution
      if (allUserIdsToAdd.isNotEmpty) {
        // Await the cubit call to properly handle the response
        await cubit.addMembersToContributionAccount(
          contributionId: widget.contribution.id,
          groupId: widget.contribution.groupId,
          memberUserIds: allUserIdsToAdd,
        );
        debugPrint('🟢 AddMembers: addMembersToContributionAccount completed');
      } else {
        // No valid users to add to contribution
        debugPrint('🟡 AddMembers: No valid user IDs to add');
        if (mounted) {
          setState(() => _isAdding = false);
          Navigator.of(context).pop();

          final inviteCount =
              _newMembersToAdd.where((m) => m.email != null).length;
          if (inviteCount > 0) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                    '$inviteCount invite(s) sent. They will be added to the contribution when they join.'),
                backgroundColor: const Color(0xFF10B981),
              ),
            );
          } else if (_skippedPartial.isNotEmpty) {
            // Real reason: the account exists but hasn't finished signing up,
            // so there is no user to attach to the contribution yet.
            final names = _skippedPartial.join(', ');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                    '$names hasn\'t finished setting up their LazerVault account, '
                    'so they can\'t be added yet. They\'ll be able to join once they do.'),
                backgroundColor: const Color(0xFFF59E0B),
                duration: const Duration(seconds: 5),
              ),
            );
          } else {
            // Nothing was selected at all — say that plainly rather than
            // blaming the data.
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Pick at least one person to add.'),
                backgroundColor: Color(0xFFF59E0B),
              ),
            );
          }

          if (widget.onMembersAdded != null) {
            widget.onMembersAdded!();
          }
        }
      }
    } catch (e) {
      debugPrint('🔴 AddMembers: Error adding members: $e');
      if (mounted) {
        setState(() => _isAdding = false);
        _showError('Failed to add members: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 40.h),
      // The app-root tap-to-dismiss (main.dart GetMaterialApp.builder)
      // cannot reach inside modal dialogs - the opaque dialog surface
      // occludes it - so unfocus here to dismiss the keyboard on a tap
      // in the dialog's empty area. Wrapped inside the Dialog (not
      // around it) so taps on the barrier outside the card still
      // dismiss the dialog.
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          width: double.infinity,
          height: 650.h,
          decoration: BoxDecoration(
            color: const Color(0xFF0A0A0A),
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: const Color(0xFF2D2D2D)),
          ),
          child: Column(
            children: [
              _buildHeader(),
              _buildTabBar(),
              Expanded(child: _buildContent()),
              _buildActions(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: const Color(0xFF2D2D2D),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add Members',
                  style: GoogleFonts.inter(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Add members to "${widget.contribution.title}"',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    color: Colors.grey[400],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                Icons.close,
                color: Colors.white,
                size: 20.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: PayFlowTheme.accentCta,
          borderRadius: BorderRadius.circular(10.r),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.grey[400],
        labelStyle: GoogleFonts.inter(
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
        ),
        tabs: [
          Tab(text: 'Group Members'),
          Tab(text: 'Add New'),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return BlocListener<GroupAccountCubit, GroupAccountState>(
      listener: (context, state) {
        if (state is GroupAccountGroupLoaded) {
          setState(() {
            // Show all group members. Members already in this contribution
            // render as a disabled "Already in contribution" tile so the
            // user can see they're accounted for without re-adding them.
            _groupMembers = state.members.toList();
            _isLoading = false;
          });
        } else if (state is ContributionMembersAdded) {
          setState(() {
            _isAdding = false;
          });
          Navigator.of(context).pop();
          if (widget.onMembersAdded != null) {
            widget.onMembersAdded!();
          }
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: const Color(0xFF10B981),
            ),
          );
        } else if (state is GroupAccountError) {
          setState(() {
            _isLoading = false;
            _isAdding = false;
          });
          _showError(state.message);
        }
      },
      child: TabBarView(
        controller: _tabController,
        children: [
          _buildGroupMembersTab(),
          _buildAddNewMemberTab(),
        ],
      ),
    );
  }

  Widget _buildGroupMembersTab() {
    if (_isLoading) {
      return const Center(
        child: LazerVaultLoader.small(),
      );
    }

    if (_groupMembers.isEmpty) {
      return _buildEmptyGroupMembersState();
    }

    return Column(
      children: [
        // Select All header
        Container(
          padding: EdgeInsets.all(16.w),
          child: Row(
            children: [
              GestureDetector(
                onTap: _toggleSelectAll,
                child: Container(
                  width: 20.w,
                  height: 20.w,
                  decoration: BoxDecoration(
                    color: _selectAll
                        ? PayFlowTheme.accentCta
                        : Colors.transparent,
                    border: Border.all(
                      color: _selectAll
                          ? PayFlowTheme.accentOnDark
                          : Colors.grey[600]!,
                    ),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: _selectAll
                      ? Icon(Icons.check, color: Colors.white, size: 14.sp)
                      : null,
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                'Select All (${_groupMembers.length})',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              Text(
                '${_selectedMemberIds.length} selected',
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  color: Colors.grey[400],
                ),
              ),
            ],
          ),
        ),

        // Members list
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: _groupMembers.length,
            itemBuilder: (context, index) {
              final member = _groupMembers[index];
              return _buildGroupMemberItem(member);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildGroupMemberItem(GroupMember member) {
    final isAlreadyAdded = _existingMemberUserIds.contains(member.userId);
    final isSelected =
        !isAlreadyAdded && _selectedMemberIds.contains(member.id);

    return Opacity(
      opacity: isAlreadyAdded ? 0.5 : 1.0,
      child: GestureDetector(
        onTap: isAlreadyAdded ? null : () => _toggleMember(member.id),
        onLongPress: () => _showMemberDetails(member),
        child: Container(
          margin: EdgeInsets.only(bottom: 8.h),
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: isSelected
                ? PayFlowTheme.accentOnDark.withValues(alpha: 0.1)
                : const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: isSelected
                  ? PayFlowTheme.accentOnDark.withValues(alpha: 0.3)
                  : Colors.transparent,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 20.w,
                height: 20.w,
                decoration: BoxDecoration(
                  color: isSelected
                      ? PayFlowTheme.accentCta
                      : Colors.transparent,
                  border: Border.all(
                    color: isSelected
                        ? PayFlowTheme.accentOnDark
                        : Colors.grey[600]!,
                  ),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: isSelected
                    ? Icon(Icons.check, color: Colors.white, size: 14.sp)
                    : null,
              ),
              SizedBox(width: 12.w),
              CircleAvatar(
                radius: 18.r,
                backgroundColor: PayFlowTheme.accentCta,
                backgroundImage: member.profileImage != null
                    ? NetworkImage(member.profileImage!)
                    : null,
                child: member.profileImage == null
                    ? Text(
                        _getInitials(member),
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      )
                    : null,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _getDisplayName(member),
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    if (isAlreadyAdded)
                      Text(
                        'Already in contribution',
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          color: const Color(0xFFFB923C),
                        ),
                      )
                    else if (member.email.isNotEmpty)
                      Text(
                        member.email,
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          color: Colors.grey[400],
                        ),
                      )
                    else if (member.userUsername != null &&
                        member.userUsername!.isNotEmpty)
                      Text(
                        '@${member.userUsername}',
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          color: PayFlowTheme.accentOnDark,
                        ),
                      )
                    else
                      Text(
                        member.role.displayName,
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          color: Colors.grey[400],
                        ),
                      ),
                  ],
                ),
              ),
              Icon(
                Icons.info_outline,
                color: Colors.grey[500],
                size: 18.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyGroupMembersState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.people_outline,
              size: 48.sp,
              color: Colors.grey[600],
            ),
            SizedBox(height: 16.h),
            Text(
              'All group members are already in this contribution',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                color: Colors.grey[400],
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              'Use the "Add New" tab to add new members',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddNewMemberTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Info banner
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: const Color(0xFF3B82F6).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(
                color: const Color(0xFF3B82F6).withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: const Color(0xFF3B82F6),
                  size: 20.sp,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    'New members will be added to the group and this contribution',
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      color: const Color(0xFF3B82F6),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 16.h),

          // Search field
          Text(
            'Search by email, username, or phone',
            style: GoogleFonts.inter(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.h),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: const Color(0xFF2D2D2D)),
            ),
            child: TextField(
              controller: _searchController,
              focusNode: _focusNode,
              readOnly: true,
              onTap: _openUnifiedSearch,
              style: GoogleFonts.inter(fontSize: 14.sp, color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search people to add',
                hintStyle:
                    GoogleFonts.inter(fontSize: 14.sp, color: Colors.grey[500]),
                prefixIcon:
                    Icon(Icons.search, color: Colors.grey[500], size: 20.sp),
                suffixIcon: _searchController.text.isNotEmpty
                    ? GestureDetector(
                        onTap: () {
                          _searchController.clear();
                          _onSearchChanged('');
                        },
                        child: Icon(Icons.clear,
                            color: Colors.grey[500], size: 18.sp),
                      )
                    : null,
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
              ),
              onChanged: _onSearchChanged,
            ),
          ),

          SizedBox(height: 10.h),
          // Contacts entry, matching the group-level sheet. Adding someone was
          // search-only here, so a creator who had the person in their phone
          // still had to recall their exact handle — the two levels behaved
          // differently for the same task.
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              onPressed: _openContactPicker,
              icon: Icon(Icons.contacts_outlined,
                  size: 18.sp, color: PayFlowTheme.accentOnDark),
              label: Text(
                'Pick from contacts',
                style: GoogleFonts.inter(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: PayFlowTheme.accentOnDark,
                ),
              ),
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
          ),

          SizedBox(height: 10.h),

          // Selected new members
          if (_newMembersToAdd.isNotEmpty) ...[
            Row(
              children: [
                Text(
                  'New Members to Add',
                  style: GoogleFonts.inter(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 8.w),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: PayFlowTheme.accentCta,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Text(
                    '${_newMembersToAdd.length}',
                    style: GoogleFonts.inter(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: List.generate(_newMembersToAdd.length, (index) {
                final member = _newMembersToAdd[index];
                final name = member.user?.fullName ?? member.fullName ?? '';
                final isOnLazerVault = member.user != null;

                return Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: isOnLazerVault
                        ? const Color(0xFF10B981).withValues(alpha: 0.1)
                        : const Color(0xFFF59E0B).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: isOnLazerVault
                          ? const Color(0xFF10B981).withValues(alpha: 0.3)
                          : const Color(0xFFF59E0B).withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isOnLazerVault
                            ? Icons.check_circle
                            : Icons.mail_outline,
                        color: isOnLazerVault
                            ? const Color(0xFF10B981)
                            : const Color(0xFFF59E0B),
                        size: 14.sp,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        name,
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      GestureDetector(
                        onTap: () => _removeNewMember(index),
                        child: Icon(
                          Icons.close,
                          color: Colors.grey[400],
                          size: 14.sp,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
            SizedBox(height: 16.h),
          ],

          // Search results or invite UI
          _buildSearchResultsOrInvite(),
        ],
      ),
    );
  }

  Widget _buildSearchResultsOrInvite() {
    if (_isSearching) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 32.h),
        child: Center(
          child: Column(
            children: [
              LazerVaultLoader.small(),
              SizedBox(height: 12.h),
              Text(
                'Searching...',
                style:
                    GoogleFonts.inter(fontSize: 12.sp, color: Colors.grey[500]),
              ),
            ],
          ),
        ),
      );
    }

    if (_showInviteUI) {
      return _buildInviteUI();
    }

    if (_searchResults.isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Search Results',
            style: GoogleFonts.inter(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey[400],
            ),
          ),
          SizedBox(height: 8.h),
          ..._searchResults.take(5).map((user) => _buildUserResultCard(user)),
        ],
      );
    }

    if (_errorMessage != null) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24.h),
          child: Column(
            children: [
              Icon(Icons.person_off_outlined,
                  color: Colors.grey[500], size: 32.sp),
              SizedBox(height: 8.h),
              Text(
                _errorMessage!,
                style:
                    GoogleFonts.inter(fontSize: 13.sp, color: Colors.grey[400]),
              ),
            ],
          ),
        ),
      );
    }

    if (_searchController.text.isEmpty && _newMembersToAdd.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24.h),
          child: Column(
            children: [
              Icon(Icons.search, color: Colors.grey[500], size: 32.sp),
              SizedBox(height: 8.h),
              Text(
                'Search for users to add',
                style:
                    GoogleFonts.inter(fontSize: 13.sp, color: Colors.grey[400]),
              ),
            ],
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildUserResultCard(UserSearchResultEntity user) {
    final isAlreadyInGroup = _isUserAlreadyInGroup(user);
    final isAlreadyInContribution = _isUserAlreadyInContribution(user);
    final isAlreadySelected = _isUserAlreadySelected(user);

    // Add-New tab is for users who are NOT yet in the group. Anyone
    // already in the group should switch to the Group Members tab —
    // adding them again here would be a no-op (the cubit would see
    // them as a duplicate group_member). Disable tap and tint amber
    // to match the "already in contribution" treatment.
    final disabledForAdd =
        isAlreadyInContribution || isAlreadySelected || isAlreadyInGroup;

    return GestureDetector(
      onTap: disabledForAdd ? null : () => _selectNewUser(user),
      child: Container(
        margin: EdgeInsets.only(bottom: 8.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: isAlreadyInContribution || isAlreadyInGroup
              ? const Color(0xFFF59E0B).withValues(alpha: 0.1)
              : isAlreadySelected
                  ? const Color(0xFF10B981).withValues(alpha: 0.1)
                  : const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: isAlreadyInContribution || isAlreadyInGroup
                ? const Color(0xFFF59E0B).withValues(alpha: 0.3)
                : isAlreadySelected
                    ? const Color(0xFF10B981).withValues(alpha: 0.3)
                    : const Color(0xFF2D2D2D),
          ),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 18.r,
              backgroundColor:
                  PayFlowTheme.accentOnDark.withValues(alpha: 0.2),
              backgroundImage: user.profilePicture.isNotEmpty
                  ? NetworkImage(user.profilePicture)
                  : null,
              child: user.profilePicture.isEmpty
                  ? Text(
                      user.initials,
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: PayFlowTheme.accentOnDark,
                      ),
                    )
                  : null,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          user.fullName,
                          style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      if (isAlreadyInGroup && !isAlreadyInContribution)
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 6.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color:
                                const Color(0xFF3B82F6).withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text(
                            'In Group',
                            style: GoogleFonts.inter(
                              fontSize: 9.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF3B82F6),
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    user.searchMatchInfo,
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      color: PayFlowTheme.accentOnDark,
                    ),
                  ),
                  if (isAlreadyInContribution) ...[
                    SizedBox(height: 4.h),
                    Text(
                      'Already in this contribution',
                      style: GoogleFonts.inter(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFFF59E0B),
                      ),
                    ),
                  ] else if (isAlreadyInGroup) ...[
                    // In-group users are added via the Group Members tab,
                    // not Add New. Tap is disabled above; this hint
                    // tells the operator where to go instead.
                    SizedBox(height: 4.h),
                    Text(
                      'Already in group. Use Group Members tab',
                      style: GoogleFonts.inter(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFFF59E0B),
                      ),
                    ),
                  ],
                  if (isAlreadySelected) ...[
                    SizedBox(height: 4.h),
                    Text(
                      'Selected',
                      style: GoogleFonts.inter(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF10B981),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (!isAlreadyInContribution && !isAlreadySelected)
              Icon(
                Icons.add_circle_outline,
                color: PayFlowTheme.accentOnDark,
                size: 22.sp,
              )
            else if (isAlreadySelected)
              Icon(
                Icons.check_circle,
                color: const Color(0xFF10B981),
                size: 22.sp,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildInviteUI() {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF59E0B).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10.r),
        border:
            Border.all(color: const Color(0xFFF59E0B).withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.mail_outline,
                  color: const Color(0xFFF59E0B), size: 20.sp),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'User not on Lazervault',
                      style: GoogleFonts.inter(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Add them to send an invite',
                      style: GoogleFonts.inter(
                          fontSize: 11.sp, color: Colors.grey[400]),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _fullNameController,
                  style:
                      GoogleFonts.inter(fontSize: 13.sp, color: Colors.white),
                  onChanged: (_) => setState(() {}),
                  decoration: InputDecoration(
                    hintText: 'Full name',
                    hintStyle: GoogleFonts.inter(
                        fontSize: 13.sp, color: Colors.grey[600]),
                    filled: true,
                    fillColor: const Color(0xFF1F1F1F),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                    prefixIcon: Icon(Icons.person_outline,
                        color: Colors.grey[500], size: 16.sp),
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              GestureDetector(
                onTap: _fullNameController.text.trim().isNotEmpty
                    ? _addPendingInvite
                    : null,
                child: Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: _fullNameController.text.trim().isNotEmpty
                        ? PayFlowTheme.accentCta
                        : Colors.grey[800],
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 18.sp,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showMemberDetails(GroupMember member) {
    HapticFeedback.lightImpact();
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => _MemberDetailsSheet(member: member),
    );
  }

  Widget _buildActions() {
    final totalSelected = _selectedMemberIds.length + _newMembersToAdd.length;
    final canAdd = totalSelected > 0;

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF0A0A0A),
        border: Border(
          top: BorderSide(
            color: const Color(0xFF2D2D2D),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: _isAdding ? null : () => Navigator.of(context).pop(),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.grey[700]!),
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                'Cancel',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: ElevatedButton(
              onPressed: _isAdding || !canAdd ? null : _addSelectedMembers,
              style: ElevatedButton.styleFrom(
                backgroundColor: PayFlowTheme.accentCta,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                disabledBackgroundColor: Colors.grey[800],
              ),
              child: _isAdding
                  ? LazerVaultLoader(size: 18)
                  : Text(
                      totalSelected == 0
                          ? 'Add Members'
                          : 'Add $totalSelected Member${totalSelected == 1 ? '' : 's'}',
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
