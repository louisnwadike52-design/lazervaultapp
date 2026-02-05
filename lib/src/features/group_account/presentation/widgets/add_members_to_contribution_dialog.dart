import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/utils/debouncer.dart';
import 'package:lazervault/src/features/profile/cubit/profile_cubit.dart';
import 'package:lazervault/src/features/tag_pay/domain/entities/user_search_result_entity.dart';
import '../../domain/entities/group_entities.dart';
import '../cubit/group_account_cubit.dart';
import '../cubit/group_account_state.dart';

class AddMembersToContributionDialog extends StatefulWidget {
  final Contribution contribution;
  final VoidCallback? onMembersAdded;

  const AddMembersToContributionDialog({
    super.key,
    required this.contribution,
    this.onMembersAdded,
  });

  @override
  State<AddMembersToContributionDialog> createState() => _AddMembersToContributionDialogState();
}

class _AddMembersToContributionDialogState extends State<AddMembersToContributionDialog>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Existing group members tab
  List<GroupMember> _groupMembers = [];
  Set<String> _selectedMemberIds = {};
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

  void _loadGroupMembers() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Get existing contribution members
      _existingMemberUserIds = widget.contribution.members
          .map((m) => m.userId)
          .toSet();

      // Get group members from the cubit
      final cubit = context.read<GroupAccountCubit>();
      await cubit.loadGroupDetails(widget.contribution.groupId);
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _showError('Failed to load group members: $e');
    }
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
        _selectedMemberIds = _groupMembers.map((m) => m.id).toSet();
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

    final cleanQuery = query.replaceAll('@', '').replaceAll('\$', '').trim();

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

    _debouncer.run(() => _performSearch(cleanQuery));
  }

  Future<void> _performSearch(String query) async {
    try {
      final cubit = serviceLocator<ProfileCubit>();
      final results = await cubit.searchUsers(query);

      if (mounted) {
        setState(() {
          _searchResults = results;
          _isSearching = false;
          if (results.isEmpty) {
            if (_isValidEmail(query)) {
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
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _searchResults = [];
          _isSearching = false;
          _errorMessage = 'Failed to search users';
        });
      }
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
          // Add existing LazerVault user to the group
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
          // Invite non-LazerVault user
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
        debugPrint('🔵 AddMembers: Member id=${m.id}, userId=${m.userId}, name=${m.userName}, isPartial=${m.isPartial}');
      }

      // Add selected group members - use more robust filtering
      final selectedMembers = _groupMembers
          .where((m) => _selectedMemberIds.contains(m.id))
          .toList();

      debugPrint('🔵 AddMembers: selectedMembers (by id) count=${selectedMembers.length}');

      // Filter to only valid user IDs
      final validSelectedUserIds = selectedMembers
          .where((m) {
            final isValid = m.userId.isNotEmpty &&
                           m.userId != '00000000-0000-0000-0000-000000000000' &&
                           !m.isPartial;
            if (!isValid) {
              debugPrint('🟡 AddMembers: Skipping member ${m.userName} - userId=${m.userId}, isPartial=${m.isPartial}');
            }
            return isValid;
          })
          .map((m) => m.userId)
          .toList();

      debugPrint('🔵 AddMembers: validSelectedUserIds=$validSelectedUserIds');
      allUserIdsToAdd.addAll(validSelectedUserIds);

      // Add newly added LazerVault users
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

          final inviteCount = _newMembersToAdd.where((m) => m.email != null).length;
          if (inviteCount > 0) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('$inviteCount invite(s) sent. They will be added to the contribution when they join.'),
                backgroundColor: const Color(0xFF10B981),
              ),
            );
          } else {
            // Show a message if no members could be added
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Selected members could not be added. They may have invalid user IDs.'),
                backgroundColor: const Color(0xFFF59E0B),
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
          color: const Color(0xFF6C5CE7),
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
            // Filter out members already in the contribution
            _groupMembers = state.members
                .where((m) => !_existingMemberUserIds.contains(m.userId))
                .toList();
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
        child: CircularProgressIndicator(
          color: Color(0xFF6C5CE7),
        ),
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
                    color: _selectAll ? const Color(0xFF6C5CE7) : Colors.transparent,
                    border: Border.all(
                      color: _selectAll ? const Color(0xFF6C5CE7) : Colors.grey[600]!,
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
    final isSelected = _selectedMemberIds.contains(member.id);

    return GestureDetector(
      onTap: () => _toggleMember(member.id),
      onLongPress: () => _showMemberDetails(member),
      child: Container(
        margin: EdgeInsets.only(bottom: 8.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF6C5CE7).withValues(alpha: 0.1)
              : const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF6C5CE7).withValues(alpha: 0.3)
                : Colors.transparent,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 20.w,
              height: 20.w,
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF6C5CE7) : Colors.transparent,
                border: Border.all(
                  color: isSelected ? const Color(0xFF6C5CE7) : Colors.grey[600]!,
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
              backgroundColor: const Color(0xFF6C5CE7),
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
                  if (member.email.isNotEmpty)
                    Text(
                      member.email,
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        color: Colors.grey[400],
                      ),
                    )
                  else if (member.userUsername != null && member.userUsername!.isNotEmpty)
                    Text(
                      '@${member.userUsername}',
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        color: const Color(0xFF6C5CE7),
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
              style: GoogleFonts.inter(fontSize: 14.sp, color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Enter email, @username, or phone',
                hintStyle: GoogleFonts.inter(fontSize: 14.sp, color: Colors.grey[500]),
                prefixIcon: Icon(Icons.search, color: Colors.grey[500], size: 20.sp),
                suffixIcon: _searchController.text.isNotEmpty
                    ? GestureDetector(
                        onTap: () {
                          _searchController.clear();
                          _onSearchChanged('');
                        },
                        child: Icon(Icons.clear, color: Colors.grey[500], size: 18.sp),
                      )
                    : null,
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
              ),
              onChanged: _onSearchChanged,
            ),
          ),

          SizedBox(height: 16.h),

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
                    color: const Color(0xFF6C5CE7),
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
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
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
                        isOnLazerVault ? Icons.check_circle : Icons.mail_outline,
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
              const CircularProgressIndicator(color: Color(0xFF6C5CE7)),
              SizedBox(height: 12.h),
              Text(
                'Searching...',
                style: GoogleFonts.inter(fontSize: 12.sp, color: Colors.grey[500]),
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
              Icon(Icons.person_off_outlined, color: Colors.grey[500], size: 32.sp),
              SizedBox(height: 8.h),
              Text(
                _errorMessage!,
                style: GoogleFonts.inter(fontSize: 13.sp, color: Colors.grey[400]),
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
                style: GoogleFonts.inter(fontSize: 13.sp, color: Colors.grey[400]),
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

    return GestureDetector(
      onTap: (isAlreadyInContribution || isAlreadySelected)
          ? null
          : () => _selectNewUser(user),
      child: Container(
        margin: EdgeInsets.only(bottom: 8.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: isAlreadyInContribution
              ? const Color(0xFFF59E0B).withValues(alpha: 0.1)
              : isAlreadySelected
                  ? const Color(0xFF10B981).withValues(alpha: 0.1)
                  : const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: isAlreadyInContribution
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
              backgroundColor: const Color(0xFF6C5CE7).withValues(alpha: 0.2),
              backgroundImage: user.profilePicture.isNotEmpty
                  ? NetworkImage(user.profilePicture)
                  : null,
              child: user.profilePicture.isEmpty
                  ? Text(
                      user.initials,
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF6C5CE7),
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
                          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: const Color(0xFF3B82F6).withValues(alpha: 0.2),
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
                      color: const Color(0xFF6C5CE7),
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
                color: const Color(0xFF6C5CE7),
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
        border: Border.all(color: const Color(0xFFF59E0B).withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.mail_outline, color: const Color(0xFFF59E0B), size: 20.sp),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'User not on LazerVault',
                      style: GoogleFonts.inter(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Add them to send an invite',
                      style: GoogleFonts.inter(fontSize: 11.sp, color: Colors.grey[400]),
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
                  style: GoogleFonts.inter(fontSize: 13.sp, color: Colors.white),
                  onChanged: (_) => setState(() {}),
                  decoration: InputDecoration(
                    hintText: 'Full name',
                    hintStyle: GoogleFonts.inter(fontSize: 13.sp, color: Colors.grey[600]),
                    filled: true,
                    fillColor: const Color(0xFF1F1F1F),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                    prefixIcon: Icon(Icons.person_outline, color: Colors.grey[500], size: 16.sp),
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              GestureDetector(
                onTap: _fullNameController.text.trim().isNotEmpty ? _addPendingInvite : null,
                child: Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: _fullNameController.text.trim().isNotEmpty
                        ? const Color(0xFF6C5CE7)
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
                backgroundColor: const Color(0xFF6C5CE7),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                disabledBackgroundColor: Colors.grey[800],
              ),
              child: _isAdding
                  ? SizedBox(
                      height: 18.h,
                      width: 18.w,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
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

/// Helper class to track new members to add
class _NewMemberSelection {
  final UserSearchResultEntity? user;
  final String? email;
  final String? fullName;

  _NewMemberSelection({this.user, this.email, this.fullName});
}

/// Member details bottom sheet
class _MemberDetailsSheet extends StatelessWidget {
  final GroupMember member;

  const _MemberDetailsSheet({required this.member});

  /// Helper to get display name with fallback for empty names
  String _getDisplayName() {
    if (member.userName.isNotEmpty) return member.userName;
    if (member.userUsername != null && member.userUsername!.isNotEmpty) {
      return '@${member.userUsername}';
    }
    if (member.email.isNotEmpty) {
      final atIndex = member.email.indexOf('@');
      if (atIndex > 0) {
        return member.email.substring(0, atIndex);
      }
      return member.email;
    }
    return 'Unknown User';
  }

  /// Helper to get initials for avatar
  String _getInitials() {
    final displayName = _getDisplayName();
    if (displayName.startsWith('@')) {
      return displayName.length > 1 ? displayName[1].toUpperCase() : 'U';
    }
    return displayName.isNotEmpty ? displayName[0].toUpperCase() : 'U';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.grey[600],
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(height: 24.h),

          // Avatar
          CircleAvatar(
            radius: 40.r,
            backgroundColor: const Color(0xFF6C5CE7),
            backgroundImage: member.profileImage != null
                ? NetworkImage(member.profileImage!)
                : null,
            child: member.profileImage == null
                ? Text(
                    _getInitials(),
                    style: GoogleFonts.inter(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  )
                : null,
          ),
          SizedBox(height: 16.h),

          // Name
          Text(
            _getDisplayName(),
            style: GoogleFonts.inter(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 4.h),

          // Email or username
          if (member.email.isNotEmpty)
            Text(
              member.email,
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                color: Colors.grey[400],
              ),
            )
          else if (member.userUsername != null && member.userUsername!.isNotEmpty)
            Text(
              '@${member.userUsername}',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                color: const Color(0xFF6C5CE7),
              ),
            ),
          SizedBox(height: 8.h),

          // Role badge
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: _getRoleColor(member.role).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              member.role.displayName,
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: _getRoleColor(member.role),
              ),
            ),
          ),
          SizedBox(height: 24.h),

          // Details
          _buildDetailRow(Icons.calendar_today, 'Joined', _formatDate(member.joinedAt)),
          if (member.phoneNumber != null && member.phoneNumber!.isNotEmpty)
            _buildDetailRow(Icons.phone, 'Phone', member.phoneNumber!),
          if (member.userUsername != null && member.userUsername!.isNotEmpty)
            _buildDetailRow(Icons.alternate_email, 'Username', '@${member.userUsername}'),
          _buildDetailRow(
            Icons.check_circle,
            'Status',
            member.status.displayName,
            valueColor: member.status == GroupMemberStatus.active
                ? const Color(0xFF10B981)
                : Colors.grey[400],
          ),

          SizedBox(height: 24.h),

          // Close button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6C5CE7),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                'Close',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value, {Color? valueColor}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey[500], size: 18.sp),
          SizedBox(width: 12.w),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 13.sp,
              color: Colors.grey[400],
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: valueColor ?? Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Color _getRoleColor(GroupMemberRole role) {
    switch (role) {
      case GroupMemberRole.admin:
        return const Color(0xFFEF4444);
      case GroupMemberRole.moderator:
        return const Color(0xFFF59E0B);
      case GroupMemberRole.member:
        return const Color(0xFF10B981);
    }
  }

  String _formatDate(DateTime date) {
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}
