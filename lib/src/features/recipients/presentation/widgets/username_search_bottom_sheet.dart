import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/profile/cubit/profile_cubit.dart';

import 'package:lazervault/src/features/tag_pay/domain/entities/user_search_result_entity.dart';

/// Bottom sheet for searching and selecting LazerVault usernames
class UsernameSearchBottomSheet extends StatefulWidget {
  final Function(UserSearchResultEntity) onUserSelected;

  const UsernameSearchBottomSheet({
    super.key,
    required this.onUserSelected,
  });

  /// Show the bottom sheet and return the selected user
  static Future<UserSearchResultEntity?> show(BuildContext context) async {
    UserSearchResultEntity? selectedUser;

    await Get.bottomSheet(
      UsernameSearchBottomSheet(
        onUserSelected: (user) {
          selectedUser = user;
          Get.back();
        },
      ),
      isScrollControlled: true,
      enableDrag: true,
      isDismissible: true,
      enterBottomSheetDuration: const Duration(milliseconds: 300),
      exitBottomSheetDuration: const Duration(milliseconds: 200),
      backgroundColor: Colors.transparent,
    );

    return selectedUser;
  }

  @override
  State<UsernameSearchBottomSheet> createState() =>
      _UsernameSearchBottomSheetState();
}

class _UsernameSearchBottomSheetState extends State<UsernameSearchBottomSheet> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  Timer? _debounceTimer;
  List<UserSearchResultEntity> _searchResults = [];
  bool _isSearching = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    // Auto-focus the search field when sheet opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    // Cancel previous timer
    _debounceTimer?.cancel();

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
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      _performSearch(cleanQuery);
    });
  }

  Future<void> _performSearch(String query) async {
    try {
      print('[UsernameSearch] Searching for: "$query"');
      final cubit = serviceLocator<ProfileCubit>();
      final results = await cubit.searchUsers(query);
      print('[UsernameSearch] Got ${results.length} results');
      if (mounted) {
        setState(() {
          _searchResults = results;
          _isSearching = false;
          _errorMessage = results.isEmpty ? 'No users found' : null;
        });
      }
    } catch (e) {
      print('[UsernameSearch] Error: $e');
      if (mounted) {
        setState(() {
          _searchResults = [];
          _isSearching = false;
          _errorMessage = 'Failed to search users';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.85,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        children: [
          // Handle bar
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 12.h),
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),

          // Header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Icon(
                        Icons.close,
                        color: Colors.grey[600],
                        size: 24.sp,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Text(
                      'Search Username',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Text(
                  'Find LazerVault users by their username',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),

          // Search Field
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: TextField(
                controller: _searchController,
                focusNode: _focusNode,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 16.sp,
                ),
                decoration: InputDecoration(
                  hintText: 'Enter username to search',
                  hintStyle: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 16.sp,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey[600],
                    size: 22.sp,
                  ),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? GestureDetector(
                          onTap: () {
                            _searchController.clear();
                            _onSearchChanged('');
                          },
                          child: Icon(
                            Icons.clear,
                            color: Colors.grey[600],
                            size: 20.sp,
                          ),
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 14.h,
                  ),
                ),
                onChanged: _onSearchChanged,
              ),
            ),
          ),
          SizedBox(height: 16.h),

          // Results Section
          Expanded(
            child: _buildResultsContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsContent() {
    // Loading state
    if (_isSearching) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(
              color: const Color.fromARGB(255, 78, 3, 208),
            ),
            SizedBox(height: 16.h),
            Text(
              'Searching...',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
      );
    }

    // Empty state - no search yet
    if (_searchController.text.isEmpty) {
      return _buildEmptyState(
        icon: Icons.search,
        title: 'Search for users',
        subtitle: 'Type at least 2 characters to search',
      );
    }

    // Error state
    if (_errorMessage != null && _searchResults.isEmpty) {
      return _buildEmptyState(
        icon: Icons.person_off_outlined,
        title: _errorMessage!,
        subtitle: 'Try a different username',
      );
    }

    // Results list
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        final user = _searchResults[index];
        return _buildUserResultCard(user);
      },
    );
  }

  Widget _buildEmptyState({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Colors.grey[400],
              size: 48.sp,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            title,
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            subtitle,
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserResultCard(UserSearchResultEntity user) {
    return GestureDetector(
      onTap: () => widget.onUserSelected(user),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.grey[200]!),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
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
                  Text(
                    user.fullName,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '@${user.username}',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 78, 3, 208),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            // Select indicator
            Icon(
              Icons.chevron_right,
              color: Colors.grey[400],
              size: 24.sp,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInitialsAvatar(UserSearchResultEntity user) {
    return Center(
      child: Text(
        user.initials,
        style: TextStyle(
          color: const Color.fromARGB(255, 78, 3, 208),
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
