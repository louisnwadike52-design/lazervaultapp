import 'package:flutter/material.dart';
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
import 'contact_picker_bottom_sheet.dart';

class AddMemberBottomSheet extends StatefulWidget {
  final GroupAccount group;
  final List<GroupMember> existingMembers;

  const AddMemberBottomSheet({
    super.key,
    required this.group,
    this.existingMembers = const [],
  });

  @override
  State<AddMemberBottomSheet> createState() => _AddMemberBottomSheetState();
}

/// Helper class to track selected users with their assigned roles
class _SelectedMember {
  final UserSearchResultEntity user;
  GroupMemberRole role;

  _SelectedMember({required this.user, required this.role});
}

/// Helper class to track pending invites (users not on LazerVault)
class _PendingInvite {
  final String email;
  final String fullName;
  GroupMemberRole role;

  _PendingInvite({required this.email, required this.fullName, required this.role});
}

class _AddMemberBottomSheetState extends State<AddMemberBottomSheet> {
  final _searchController = TextEditingController();
  final _focusNode = FocusNode();
  final _debouncer = Debouncer.search();
  final _fullNameController = TextEditingController();

  GroupMemberRole _selectedRole = GroupMemberRole.member;
  bool _isLoading = false;
  bool _isSearching = false;

  // Search results from ProfileCubit
  List<UserSearchResultEntity> _searchResults = [];
  String? _errorMessage;

  // Multiple selected users
  final List<_SelectedMember> _selectedMembers = [];
  final List<_PendingInvite> _pendingInvites = [];

  bool _showInviteUI = false;

  // Track how many members have been added successfully
  int _addedCount = 0;
  int _totalToAdd = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    _debouncer.dispose();
    _fullNameController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    _debouncer.cancel();

    // Clear invite UI when search changes
    setState(() {
      _showInviteUI = false;
    });

    // Clean the query - remove @ and $ symbols
    final cleanQuery = query.replaceAll('@', '').replaceAll('\$', '').trim();

    if (cleanQuery.isEmpty) {
      setState(() {
        _searchResults = [];
        _isSearching = false;
        _errorMessage = null;
      });
      return;
    }

    // Minimum 2 characters required
    if (cleanQuery.length < 2) {
      setState(() {
        _searchResults = [];
        _isSearching = false;
        _errorMessage = null;
      });
      return;
    }

    // Start searching indicator
    setState(() {
      _isSearching = true;
      _errorMessage = null;
    });

    // Debounce the search - wait 500ms after user stops typing
    _debouncer.run(() => _performSearch(cleanQuery));
  }

  Future<void> _performSearch(String query) async {
    try {
      print('[AddMember] Searching for: "$query"');
      final cubit = serviceLocator<ProfileCubit>();
      final results = await cubit.searchUsers(query);
      print('[AddMember] Got ${results.length} results');

      if (mounted) {
        setState(() {
          _searchResults = results;
          _isSearching = false;
          if (results.isEmpty) {
            // Check if it looks like an email
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
      print('[AddMember] Error: $e');
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

  void _selectUser(UserSearchResultEntity user) {
    // Check if already selected
    if (_selectedMembers.any((m) => m.user.userId == user.userId)) {
      return;
    }

    setState(() {
      _selectedMembers.add(_SelectedMember(user: user, role: _selectedRole));
      _searchResults = [];
      _searchController.clear();
    });
  }

  void _removeSelectedMember(int index) {
    setState(() {
      _selectedMembers.removeAt(index);
    });
  }

  void _removePendingInvite(int index) {
    setState(() {
      _pendingInvites.removeAt(index);
    });
  }

  void _addPendingInvite() {
    final email = _searchController.text.trim();
    final fullName = _fullNameController.text.trim();

    if (email.isEmpty || fullName.isEmpty) return;

    // Check if already added
    if (_pendingInvites.any((i) => i.email == email)) {
      return;
    }

    setState(() {
      _pendingInvites.add(_PendingInvite(
        email: email,
        fullName: fullName,
        role: _selectedRole,
      ));
      _searchController.clear();
      _fullNameController.clear();
      _showInviteUI = false;
    });
  }

  bool _isUserAlreadyMember(UserSearchResultEntity user) {
    return widget.existingMembers.any((m) => m.userId == user.userId);
  }

  bool _isUserAlreadySelected(UserSearchResultEntity user) {
    return _selectedMembers.any((m) => m.user.userId == user.userId);
  }

  void _openContactPicker() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ContactPickerBottomSheet(
        onContactSelected: (name, identifier, type) {
          setState(() {
            _searchController.text = identifier;
            _fullNameController.text = name;
          });
          // Trigger search for the contact
          _onSearchChanged(identifier);
        },
      ),
    );
  }

  void _addMembers() {
    if (_selectedMembers.isEmpty && _pendingInvites.isEmpty) return;

    setState(() {
      _isLoading = true;
      _addedCount = 0;
      _totalToAdd = _selectedMembers.length + _pendingInvites.length;
    });

    final cubit = context.read<GroupAccountCubit>();

    // Add all selected LazerVault users
    for (final member in _selectedMembers) {
      cubit.addMemberToGroupAccount(
        groupId: widget.group.id,
        userId: member.user.userId,
        userName: member.user.fullName,
        email: member.user.email,
        profileImage: member.user.profilePicture,
        username: member.user.username,
        role: member.role,
      );
    }

    // Send invites to non-LazerVault users
    for (final invite in _pendingInvites) {
      cubit.inviteUserToGroup(
        groupId: widget.group.id,
        identifier: invite.email,
        fullName: invite.fullName,
        identifierType: UserSearchType.email,
        role: invite.role,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GroupAccountCubit, GroupAccountState>(
      listener: (context, state) {
        if (state is MemberAddedSuccess || state is InviteSentSuccess) {
          _addedCount++;

          if (_addedCount >= _totalToAdd) {
            setState(() => _isLoading = false);
            Navigator.pop(context, true);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(_totalToAdd == 1
                    ? 'Member added successfully'
                    : '$_totalToAdd members added successfully'),
                backgroundColor: const Color(0xFF10B981),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        } else if (state is GroupAccountError) {
          setState(() => _isLoading = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: const Color(0xFFEF4444),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
              behavior: SnackBarBehavior.floating,
            ),
          );
        } else if (state is UserAlreadyMember) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.userName} is already a member'),
              backgroundColor: const Color(0xFFF59E0B),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      child: Container(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        height: MediaQuery.of(context).size.height * 0.85,
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSearchField(),
                    if (_selectedMembers.isNotEmpty || _pendingInvites.isNotEmpty) ...[
                      SizedBox(height: 16.h),
                      _buildSelectedMembersSection(),
                    ],
                    SizedBox(height: 16.h),
                    _buildSearchResults(),
                    SizedBox(height: 20.h),
                    _buildRoleSelection(),
                  ],
                ),
              ),
            ),
            // Fixed bottom action buttons
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color.fromARGB(255, 78, 3, 208),
            const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.8),
          ],
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(Icons.person_add, color: Colors.white, size: 24.sp),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add Members',
                  style: GoogleFonts.inter(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Invite people to ${widget.group.name}',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(Icons.close, color: Colors.white, size: 20.sp),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Search by email, username, or phone',
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF0A0A0A),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: const Color(0xFF2D2D2D)),
                ),
                child: TextField(
                  controller: _searchController,
                  focusNode: _focusNode,
                  style: GoogleFonts.inter(fontSize: 16.sp, color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Enter email, @username, or phone',
                    hintStyle: GoogleFonts.inter(fontSize: 16.sp, color: Colors.grey[500]),
                    prefixIcon: Icon(Icons.search, color: Colors.grey[500], size: 22.sp),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? GestureDetector(
                            onTap: () {
                              _searchController.clear();
                              _onSearchChanged('');
                            },
                            child: Icon(Icons.clear, color: Colors.grey[500], size: 20.sp),
                          )
                        : null,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  ),
                  onChanged: _onSearchChanged,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            // Contact picker button
            GestureDetector(
              onTap: _openContactPicker,
              child: Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.3)),
                ),
                child: Icon(
                  Icons.contacts,
                  color: const Color.fromARGB(255, 78, 3, 208),
                  size: 22.sp,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSelectedMembersSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Selected Members',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 8.w),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 78, 3, 208),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Text(
                '${_selectedMembers.length + _pendingInvites.length}',
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: [
            // Selected LazerVault users
            ...List.generate(_selectedMembers.length, (index) {
              final member = _selectedMembers[index];
              return _buildSelectedMemberChip(
                name: member.user.fullName,
                role: member.role,
                isOnLazerVault: true,
                onRemove: () => _removeSelectedMember(index),
              );
            }),
            // Pending invites
            ...List.generate(_pendingInvites.length, (index) {
              final invite = _pendingInvites[index];
              return _buildSelectedMemberChip(
                name: invite.fullName,
                role: invite.role,
                isOnLazerVault: false,
                onRemove: () => _removePendingInvite(index),
              );
            }),
          ],
        ),
      ],
    );
  }

  Widget _buildSelectedMemberChip({
    required String name,
    required GroupMemberRole role,
    required bool isOnLazerVault,
    required VoidCallback onRemove,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: isOnLazerVault
            ? const Color(0xFF10B981).withValues(alpha: 0.1)
            : const Color(0xFFF59E0B).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20.r),
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
            color: isOnLazerVault ? const Color(0xFF10B981) : const Color(0xFFF59E0B),
            size: 16.sp,
          ),
          SizedBox(width: 6.w),
          Text(
            name,
            style: GoogleFonts.inter(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 4.w),
          Text(
            '(${role.displayName})',
            style: GoogleFonts.inter(
              fontSize: 11.sp,
              color: Colors.grey[400],
            ),
          ),
          SizedBox(width: 6.w),
          GestureDetector(
            onTap: onRemove,
            child: Icon(
              Icons.close,
              color: Colors.grey[400],
              size: 16.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    // Loading state
    if (_isSearching) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 40.h),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(color: Color.fromARGB(255, 78, 3, 208)),
              SizedBox(height: 16.h),
              Text(
                'Searching...',
                style: GoogleFonts.inter(fontSize: 14.sp, color: Colors.grey[500]),
              ),
            ],
          ),
        ),
      );
    }

    // Invite UI for email not found
    if (_showInviteUI) {
      return _buildInviteUI();
    }

    // Search results
    if (_searchResults.isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Search Results',
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey[400],
            ),
          ),
          SizedBox(height: 12.h),
          ...(_searchResults.take(5).map((user) => _buildUserResultCard(user))),
        ],
      );
    }

    // Error state
    if (_errorMessage != null) {
      return _buildEmptyState(
        icon: Icons.person_off_outlined,
        title: _errorMessage!,
        subtitle: 'Try searching by email, username, or phone',
      );
    }

    // Initial empty state (only show if no members selected yet)
    if (_searchController.text.isEmpty && _selectedMembers.isEmpty && _pendingInvites.isEmpty) {
      return _buildEmptyState(
        icon: Icons.search,
        title: 'Search for users',
        subtitle: 'Type at least 2 characters to search',
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildEmptyState({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 40.h),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: const Color(0xFF0A0A0A),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.grey[500], size: 40.sp),
            ),
            SizedBox(height: 16.h),
            Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              subtitle,
              style: GoogleFonts.inter(fontSize: 14.sp, color: Colors.grey[500]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserResultCard(UserSearchResultEntity user) {
    final isAlreadyMember = _isUserAlreadyMember(user);
    final isAlreadySelected = _isUserAlreadySelected(user);

    return GestureDetector(
      onTap: (isAlreadyMember || isAlreadySelected) ? null : () => _selectUser(user),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isAlreadyMember
              ? const Color(0xFFF59E0B).withValues(alpha: 0.1)
              : isAlreadySelected
                  ? const Color(0xFF10B981).withValues(alpha: 0.1)
                  : const Color(0xFF0A0A0A),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isAlreadyMember
                ? const Color(0xFFF59E0B).withValues(alpha: 0.3)
                : isAlreadySelected
                    ? const Color(0xFF10B981).withValues(alpha: 0.3)
                    : const Color(0xFF2D2D2D),
          ),
        ),
        child: Row(
          children: [
            // Avatar
            Container(
              width: 48.w,
              height: 48.h,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: user.profilePicture.isNotEmpty
                  ? ClipOval(
                      child: Image.network(
                        user.profilePicture,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => _buildInitialsAvatar(user),
                      ),
                    )
                  : _buildInitialsAvatar(user),
            ),
            SizedBox(width: 12.w),
            // User Info
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
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: const Color(0xFF10B981).withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Text(
                          'On LazerVault',
                          style: GoogleFonts.inter(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF10B981),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    user.searchMatchInfo,
                    style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      color: const Color.fromARGB(255, 78, 3, 208),
                    ),
                  ),
                  if (isAlreadyMember) ...[
                    SizedBox(height: 6.h),
                    Text(
                      'Already a member',
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFFF59E0B),
                      ),
                    ),
                  ],
                  if (isAlreadySelected) ...[
                    SizedBox(height: 6.h),
                    Text(
                      'Selected',
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF10B981),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (!isAlreadyMember && !isAlreadySelected)
              Icon(Icons.add_circle_outline, color: const Color.fromARGB(255, 78, 3, 208), size: 24.sp)
            else if (isAlreadySelected)
              Icon(Icons.check_circle, color: const Color(0xFF10B981), size: 24.sp),
          ],
        ),
      ),
    );
  }

  Widget _buildInitialsAvatar(UserSearchResultEntity user) {
    return Center(
      child: Text(
        user.initials,
        style: GoogleFonts.inter(
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
          color: const Color.fromARGB(255, 78, 3, 208),
        ),
      ),
    );
  }

  Widget _buildInviteUI() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF59E0B).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFF59E0B).withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.mail_outline, color: const Color(0xFFF59E0B), size: 24.sp),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'User not on LazerVault',
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Add them to send an invite',
                      style: GoogleFonts.inter(fontSize: 12.sp, color: Colors.grey[400]),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Text(
            'Full Name *',
            style: GoogleFonts.inter(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey[400],
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _fullNameController,
                  style: GoogleFonts.inter(fontSize: 14.sp, color: Colors.white),
                  onChanged: (_) => setState(() {}),
                  decoration: InputDecoration(
                    hintText: 'Enter their full name',
                    hintStyle: GoogleFonts.inter(fontSize: 14.sp, color: Colors.grey[600]),
                    filled: true,
                    fillColor: const Color(0xFF0A0A0A),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: const BorderSide(color: Color.fromARGB(255, 78, 3, 208), width: 2),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                    prefixIcon: Icon(Icons.person_outline, color: Colors.grey[500], size: 18.sp),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              GestureDetector(
                onTap: _fullNameController.text.trim().isNotEmpty ? _addPendingInvite : null,
                child: Container(
                  padding: EdgeInsets.all(14.w),
                  decoration: BoxDecoration(
                    color: _fullNameController.text.trim().isNotEmpty
                        ? const Color.fromARGB(255, 78, 3, 208)
                        : Colors.grey[800],
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 20.sp,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRoleSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Default Role for New Members',
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8.h),
        _buildCompactRoleSelector(),
      ],
    );
  }

  Widget _buildCompactRoleSelector() {
    IconData icon;
    Color color;
    String description;

    switch (_selectedRole) {
      case GroupMemberRole.admin:
        icon = Icons.admin_panel_settings;
        color = const Color(0xFFEF4444);
        description = 'Full control over group';
        break;
      case GroupMemberRole.moderator:
        icon = Icons.shield;
        color = const Color(0xFFF59E0B);
        description = 'Can manage contributions';
        break;
      case GroupMemberRole.member:
        icon = Icons.person;
        color = const Color(0xFF10B981);
        description = 'Can view and contribute';
        break;
    }

    return GestureDetector(
      onTap: _showRoleSelectionModal,
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: const Color(0xFF0A0A0A),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: const Color(0xFF2D2D2D)),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(icon, color: color, size: 20.sp),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _selectedRole.displayName,
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    description,
                    style: GoogleFonts.inter(fontSize: 11.sp, color: Colors.grey[500]),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                'Change',
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color.fromARGB(255, 78, 3, 208),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showRoleSelectionModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.grey[600],
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'Select Role',
              style: GoogleFonts.inter(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 16.h),
            ...GroupMemberRole.values.map((role) => Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: _buildRoleOptionInModal(role),
            )),
            SizedBox(height: 8.h),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleOptionInModal(GroupMemberRole role) {
    final isSelected = _selectedRole == role;
    Color color;
    String description;
    IconData icon;

    switch (role) {
      case GroupMemberRole.admin:
        color = const Color(0xFFEF4444);
        description = 'Full control over group settings and members';
        icon = Icons.admin_panel_settings;
        break;
      case GroupMemberRole.moderator:
        color = const Color(0xFFF59E0B);
        description = 'Can manage contributions and moderate discussions';
        icon = Icons.shield;
        break;
      case GroupMemberRole.member:
        color = const Color(0xFF10B981);
        description = 'Can view group content and make contributions';
        icon = Icons.person;
        break;
    }

    return GestureDetector(
      onTap: () {
        setState(() => _selectedRole = role);
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: isSelected ? color.withValues(alpha: 0.1) : const Color(0xFF0A0A0A),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? color.withValues(alpha: 0.5) : const Color(0xFF2D2D2D),
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? color : Colors.grey[500], size: 24.sp),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    role.displayName,
                    style: GoogleFonts.inter(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    description,
                    style: GoogleFonts.inter(fontSize: 12.sp, color: Colors.grey[400]),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle, color: color, size: 20.sp),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    final totalCount = _selectedMembers.length + _pendingInvites.length;
    final canAdd = totalCount > 0;
    final buttonText = totalCount == 0
        ? 'Add Members'
        : totalCount == 1
            ? 'Add Member'
            : 'Add $totalCount Members';

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        border: Border(
          top: BorderSide(color: const Color(0xFF2D2D2D), width: 1),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: _isLoading ? null : () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.grey[700]!),
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                ),
                child: Text(
                  'Cancel',
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: ElevatedButton(
                onPressed: _isLoading || !canAdd ? null : _addMembers,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 78, 3, 208),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                  disabledBackgroundColor: Colors.grey[800],
                ),
                child: _isLoading
                    ? SizedBox(
                        height: 20.h,
                        width: 20.w,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : Text(
                        buttonText,
                        style: GoogleFonts.inter(fontSize: 16.sp, fontWeight: FontWeight.w600),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
