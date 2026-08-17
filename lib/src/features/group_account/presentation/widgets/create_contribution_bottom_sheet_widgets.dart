part of 'create_contribution_bottom_sheet.dart';

/// TextInputFormatter that auto-inserts thousands separators as the
/// user types an amount. Kept inline (not in core/utils) because the
/// behaviour is specific to amount-input UX and the implementation is
/// small. Allows digits + at most one '.' + at most 2 fractional
/// digits — same surface as the previous FilteringTextInputFormatter,
/// just with the thousands separators on the integer portion.
///
/// The TextEditingValue's selection is placed at the end after each
/// edit. Mid-string editing (cursor in the middle of "30,000") will
/// snap to end on next keystroke; preserving exact cursor position
/// across reformatting is a known sharp edge of this approach but
/// acceptable for an amount field where typing is almost always
/// linear / append-only.
class _ThousandsAmountFormatter extends TextInputFormatter {
  static final NumberFormat _fmt = NumberFormat.decimalPattern();

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final raw = newValue.text;
    if (raw.isEmpty) {
      return newValue;
    }

    // Remove anything that isn't a digit or a '.'.
    final cleaned = raw.replaceAll(RegExp(r'[^\d.]'), '');
    if (cleaned.isEmpty) {
      return const TextEditingValue(text: '');
    }
    // At most one '.'.
    final dotCount = '.'.allMatches(cleaned).length;
    if (dotCount > 1) return oldValue;

    final parts = cleaned.split('.');
    final intPart = parts[0];
    final hasDecPoint = parts.length > 1;
    String? decPart = hasDecPoint ? parts[1] : null;
    if (decPart != null && decPart.length > 2) {
      // Reject extra decimal places.
      return oldValue;
    }

    String intFormatted;
    if (intPart.isEmpty) {
      intFormatted = '';
    } else {
      // Strip leading zeros so "00030" doesn't render "0,030".
      final stripped = intPart.replaceFirst(RegExp(r'^0+'), '');
      final n = int.tryParse(stripped.isEmpty ? '0' : stripped);
      if (n == null) return oldValue;
      intFormatted = _fmt.format(n);
    }

    final result = StringBuffer(intFormatted);
    if (hasDecPoint) {
      result.write('.');
      if (decPart != null) result.write(decPart);
    }
    final out = result.toString();
    return TextEditingValue(
      text: out,
      selection: TextSelection.collapsed(offset: out.length),
    );
  }
}

class _ChipField {
  final String key;
  final String label;
  final IconData icon;
  const _ChipField(this.key, this.label, this.icon);
}

class _ReviewItem {
  final String label;
  final String value;
  const _ReviewItem(this.label, this.value);
}

/// Where the resolved total_cycles came from. Drives review-page
/// disclosure copy so the operator knows whether they explicitly set
/// the cycle count or whether a fallback kicked in.
enum _TotalCyclesSource { manual, fromRotation, industryDefault }

/// Add member sheet for contribution creation flow with search-on-type
/// Uses the same user search service as TagPay and Transfer flows
class _AddMemberForContributionSheet extends StatefulWidget {
  final GroupAccount group;
  final List<GroupMember> existingMembers;
  final List<String> rotationOrder; // User IDs already in rotation
  final void Function(String userId, String userName, String email, String? profileImage) onMemberAdded;

  const _AddMemberForContributionSheet({
    required this.group,
    required this.existingMembers,
    required this.rotationOrder,
    required this.onMemberAdded,
  });

  @override
  State<_AddMemberForContributionSheet> createState() => _AddMemberForContributionSheetState();
}

class _AddMemberForContributionSheetState extends State<_AddMemberForContributionSheet> {
  final _searchController = TextEditingController();
  Timer? _debounceTimer;

  // Search state
  bool _isSearching = false;
  List<UserSearchResultEntity> _searchResults = [];
  String _searchQuery = '';
  String? _errorMessage;

  // Selected user state
  UserSearchResultEntity? _selectedUser;
  bool _isAddingMember = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text;
    setState(() {
      _searchQuery = query;
      _selectedUser = null; // Clear selection when search changes
      _errorMessage = null;
    });

    // Cancel previous timer
    _debounceTimer?.cancel();

    final cleanQuery = normalizeLazerVaultUserSearchQuery(query);

    if (cleanQuery.isEmpty) {
      setState(() {
        _searchResults = [];
        _isSearching = false;
      });
      return;
    }

    // Minimum 2 characters required
    if (cleanQuery.length < 2) {
      setState(() {
        _searchResults = [];
        _isSearching = false;
      });
      return;
    }

    // Set loading state
    setState(() => _isSearching = true);

    // Debounce: 500ms delay after user stops typing
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      _performSearch(query);
    });
  }

  Future<void> _performSearch(String query) async {
    try {
      final tagPayCubit = GetIt.I<TagPayCubit>();
      final results = await tagPayCubit.searchUsers(query, limit: 20);

      if (mounted) {
        setState(() {
          _searchResults = results;
          _isSearching = false;
          _errorMessage = null;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _searchResults = [];
          _isSearching = false;
          _errorMessage = 'Search failed. Please try again.';
        });
      }
    }
  }

  bool _isUserAlreadyMember(String userId, {String? email}) {
    // Check both existing members and rotation order
    // Also check by email since userId might be null UUID
    final inExistingMembers = widget.existingMembers.any((m) =>
        m.userId == userId || (email != null && email.isNotEmpty && m.email == email));
    final inRotationOrder = widget.rotationOrder.contains(userId);
    return inExistingMembers || inRotationOrder;
  }

  void _selectUser(UserSearchResultEntity user) {
    setState(() {
      _selectedUser = user;
    });
  }

  /// Opens the shared unified search (saved contacts incl. alias → global)
  /// and selects the picked user (the existing Add flow then confirms).
  Future<void> _openUnifiedSearch() async {
    final result =
        await UnifiedUserSearchSheet.show(context, title: 'Add member');
    if (result == null || !mounted) return;
    _selectUser(result.toUserSearchResultEntity());
  }

  Future<void> _addMember() async {
    if (_selectedUser == null) return;

    setState(() => _isAddingMember = true);

    // Store user info for fallback if needed
    final userName = _selectedUser!.fullName;
    final userEmail = _selectedUser!.email;
    final profilePicture = _selectedUser!.profilePicture;
    final userUsername = _selectedUser!.username;

    try {
      final cubit = context.read<GroupAccountCubit>();

      // Set up a listener for when the member is added
      late final void Function() cancelListener;
      final completer = Completer<GroupMember?>();

      cancelListener = () {
        // Listen for MemberAddedSuccess which contains the newly added member directly
        final subscription = cubit.stream.listen((state) {
          if (state is MemberAddedSuccess) {
            // Use the member directly from the success state
            if (!completer.isCompleted) {
              completer.complete(state.member);
            }
          } else if (state is GroupAccountError) {
            if (!completer.isCompleted) {
              completer.completeError(state.message);
            }
          }
        });

        // Auto-cancel after 10 seconds
        Future.delayed(const Duration(seconds: 10), () {
          if (!completer.isCompleted) {
            subscription.cancel();
            completer.complete(null);
          }
        });

        completer.future.then((_) => subscription.cancel());
      };

      // Start listening before adding member
      cancelListener();

      // Add member to group - emits MemberAddedSuccess on success
      await cubit.addMemberToGroupAccount(
        groupId: widget.group.id,
        userId: _selectedUser!.userId,
        userName: userName,
        email: userEmail,
        username: userUsername,
        role: GroupMemberRole.member,
      );

      // Wait for the member to be added
      final addedMember = await completer.future;

      // IMPORTANT: Always use the ORIGINAL user ID from search result (_selectedUser!.userId)
      // The server response may return a null UUID, but the search result has the real user ID
      final originalUserId = _selectedUser!.userId;

      if (addedMember != null && mounted) {
        // Use search result data as primary, server response as fallback
        final memberName = userName.isNotEmpty ? userName : addedMember.userName;
        final memberEmail = userEmail.isNotEmpty ? userEmail : addedMember.email;
        debugPrint('🔵 _addMember success: originalUserId=$originalUserId, serverUserId=${addedMember.userId}, name=$memberName');
        widget.onMemberAdded(
          originalUserId, // Use the REAL user ID from search, not the server's null UUID
          memberName,
          memberEmail,
          profilePicture.isNotEmpty ? profilePicture : addedMember.profileImage,
        );
        Navigator.pop(context);
      } else if (mounted) {
        // Fallback: member was likely added but listener timed out
        // Use the original user info
        debugPrint('🟡 _addMember fallback: originalUserId=$originalUserId, name=$userName');
        widget.onMemberAdded(
          originalUserId, // Use the REAL user ID from search
          userName,
          userEmail,
          profilePicture.isNotEmpty ? profilePicture : null,
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isAddingMember = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to add member: ${e.toString()}'),
            backgroundColor: const Color(0xFFEF4444),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(),
          Flexible(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSearchField(),
                  SizedBox(height: 16.h),
                  _buildSearchResults(),
                  SizedBox(height: 24.h),
                  _buildActionButtons(),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF6366F1), Color.fromARGB(255, 78, 3, 208)],
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
                  'Add to Rotation',
                  style: GoogleFonts.inter(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Search for Lazervault users by name or @tag',
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
          'Search Users',
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          'Type at least 2 characters to search',
          style: GoogleFonts.inter(
            fontSize: 12.sp,
            color: Colors.grey[500],
          ),
        ),
        SizedBox(height: 8.h),
        TextField(
          controller: _searchController,
          readOnly: true,
          onTap: _openUnifiedSearch,
          style: GoogleFonts.inter(fontSize: 16.sp, color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Search people to add',
            hintStyle: GoogleFonts.inter(fontSize: 16.sp, color: Colors.grey[500]),
            filled: true,
            fillColor: const Color(0xFF0A0A0A),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Color(0xFF6366F1), width: 2),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            prefixIcon: Icon(Icons.search, color: Colors.grey[500], size: 20.sp),
            suffixIcon: _isSearching
                ? Padding(
                    padding: EdgeInsets.all(12.w),
                    child: LazerVaultLoader.small(),
                  )
                : _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.clear, color: Colors.grey[500], size: 20.sp),
                        onPressed: () {
                          _searchController.clear();
                        },
                      )
                    : null,
          ),
        ),
      ],
    );
  }

  Widget _buildSearchResults() {
    // Error state
    if (_errorMessage != null) {
      return Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFFEF4444).withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: const Color(0xFFEF4444).withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            Icon(Icons.error_outline, color: const Color(0xFFEF4444), size: 24.sp),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                _errorMessage!,
                style: GoogleFonts.inter(fontSize: 14.sp, color: Colors.white),
              ),
            ),
          ],
        ),
      );
    }

    // Initial state - no search yet
    if (_searchQuery.isEmpty) {
      return Container(
        padding: EdgeInsets.all(24.w),
        child: Column(
          children: [
            Icon(Icons.person_search, color: Colors.grey[600], size: 48.sp),
            SizedBox(height: 12.h),
            Text(
              'Search for users',
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.grey[400],
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'Type a name or @username to find Lazervault users',
              style: GoogleFonts.inter(fontSize: 13.sp, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    // Loading state
    if (_isSearching) {
      return Container(
        padding: EdgeInsets.all(24.w),
        child: Column(
          children: [
            LazerVaultLoader(size: 32),
            SizedBox(height: 12.h),
            Text(
              'Searching...',
              style: GoogleFonts.inter(fontSize: 14.sp, color: Colors.grey[400]),
            ),
          ],
        ),
      );
    }

    // Query too short
    final cleanQuery = normalizeLazerVaultUserSearchQuery(_searchQuery);
    if (cleanQuery.length < 2) {
      return Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1E293B),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Icon(Icons.info_outline, color: Colors.grey[500], size: 20.sp),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                'Type at least 2 characters to search',
                style: GoogleFonts.inter(fontSize: 13.sp, color: Colors.grey[400]),
              ),
            ),
          ],
        ),
      );
    }

    // No results
    if (_searchResults.isEmpty) {
      return Container(
        padding: EdgeInsets.all(24.w),
        child: Column(
          children: [
            Icon(Icons.person_off, color: Colors.grey[600], size: 48.sp),
            SizedBox(height: 12.h),
            Text(
              'No users found',
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.grey[400],
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'Try a different search term',
              style: GoogleFonts.inter(fontSize: 13.sp, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    // Results list
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${_searchResults.length} user${_searchResults.length == 1 ? '' : 's'} found',
          style: GoogleFonts.inter(fontSize: 12.sp, color: Colors.grey[500]),
        ),
        SizedBox(height: 8.h),
        ...List.generate(_searchResults.length, (index) {
          final user = _searchResults[index];
          final isAlreadyMember = _isUserAlreadyMember(user.userId, email: user.email);
          final isSelected = _selectedUser?.userId == user.userId;

          return Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: _buildUserCard(user, isAlreadyMember, isSelected),
          );
        }),
      ],
    );
  }

  Widget _buildUserCard(UserSearchResultEntity user, bool isAlreadyMember, bool isSelected) {
    return GestureDetector(
      onTap: isAlreadyMember ? null : () => _selectUser(user),
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF6366F1).withValues(alpha: 0.2)
              : isAlreadyMember
                  ? const Color(0xFFF59E0B).withValues(alpha: 0.1)
                  : const Color(0xFF0A0A0A),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF6366F1)
                : isAlreadyMember
                    ? const Color(0xFFF59E0B).withValues(alpha: 0.3)
                    : const Color(0xFF2D2D2D),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            // Avatar
            Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF6366F1), Color.fromARGB(255, 78, 3, 208)],
                ),
                borderRadius: BorderRadius.circular(22.r),
              ),
              child: user.profilePicture.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(22.r),
                      child: Image.network(
                        user.profilePicture,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Center(
                          child: Text(
                            user.initials,
                            style: GoogleFonts.inter(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  : Center(
                      child: Text(
                        user.initials,
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
            ),
            SizedBox(width: 12.w),
            // User info
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
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            color: isAlreadyMember ? Colors.grey[400] : Colors.white,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (isAlreadyMember) ...[
                        SizedBox(width: 8.w),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF59E0B).withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text(
                            'Already added',
                            style: GoogleFonts.inter(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFFF59E0B),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    user.username.isNotEmpty ? '@${user.username}' : user.email,
                    style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      color: const Color(0xFF6366F1),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            // Selection indicator
            if (isSelected)
              Icon(Icons.check_circle, color: const Color(0xFF6366F1), size: 24.sp)
            else if (!isAlreadyMember)
              Icon(Icons.radio_button_unchecked, color: Colors.grey[600], size: 24.sp),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    final canAdd = _selectedUser != null && !_isUserAlreadyMember(_selectedUser!.userId, email: _selectedUser!.email);

    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: _isAddingMember ? null : () => Navigator.pop(context),
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
            onPressed: _isAddingMember || !canAdd ? null : _addMember,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6366F1),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
              disabledBackgroundColor: Colors.grey[800],
            ),
            child: _isAddingMember
                ? LazerVaultLoader.small()
                : Text(
                    _selectedUser != null ? 'Add to Rotation' : 'Select a User',
                    style: GoogleFonts.inter(fontSize: 16.sp, fontWeight: FontWeight.w600),
                  ),
          ),
        ),
      ],
    );
  }
}
