import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/profile/cubit/profile_cubit.dart';
import 'package:lazervault/src/features/tag_pay/domain/entities/user_search_result_entity.dart';

/// Step 1: Search & Select User
/// Unified search across username, name, phone, email using ProfileCubit.searchUsers()
class ContactMethodStep extends StatefulWidget {
  final Map<String, dynamic> formData;
  final Function(Map<String, dynamic>) onNext;

  const ContactMethodStep({
    super.key,
    required this.formData,
    required this.onNext,
  });

  @override
  State<ContactMethodStep> createState() => _ContactMethodStepState();
}

class _ContactMethodStepState extends State<ContactMethodStep> {
  final TextEditingController _searchController = TextEditingController();
  final ProfileCubit _profileCubit = serviceLocator<ProfileCubit>();
  Timer? _debounce;

  List<UserSearchResultEntity> _searchResults = [];
  UserSearchResultEntity? _selectedUser;
  bool _isSearching = false;
  String _lastQuery = '';

  @override
  void initState() {
    super.initState();
    // Restore previously selected user if going back
    final destination = widget.formData['invitationDestination'] as String? ?? '';
    if (destination.isNotEmpty) {
      _searchController.text = destination;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    _debounce?.cancel();
    final trimmed = query.trim();
    if (trimmed.length < 2) {
      setState(() {
        _searchResults = [];
        _isSearching = false;
      });
      return;
    }
    setState(() => _isSearching = true);
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _performSearch(trimmed);
    });
  }

  Future<void> _performSearch(String query) async {
    if (query == _lastQuery && _searchResults.isNotEmpty) return;
    _lastQuery = query;

    try {
      final results = await _profileCubit.searchUsers(query, limit: 10);
      if (mounted && query == _lastQuery) {
        setState(() {
          _searchResults = results;
          _isSearching = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _searchResults = [];
          _isSearching = false;
        });
      }
    }
  }

  void _selectUser(UserSearchResultEntity user) {
    setState(() {
      _selectedUser = user;
      _searchResults = [];
      _searchController.text = user.username;
    });
    FocusScope.of(context).unfocus();
  }

  void _clearSelection() {
    setState(() {
      _selectedUser = null;
      _searchController.clear();
      _searchResults = [];
      _lastQuery = '';
    });
  }

  void _submitStep() {
    if (_selectedUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please search and select a user')),
      );
      return;
    }
    widget.onNext({
      'invitationMethod': 'username',
      'invitationDestination': _selectedUser!.username,
      'selectedUserId': _selectedUser!.userId,
      'selectedUserName': _selectedUser!.fullName,
      'selectedUserEmail': _selectedUser!.email,
      'selectedUserProfilePicture': _selectedUser!.profilePicture,
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            'Find a user to invite',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Search by username, name, email, or phone number',
            style: TextStyle(
              color: const Color(0xFF9CA3AF),
              fontSize: 14.sp,
            ),
          ),
          SizedBox(height: 24.h),

          // Selected user card or search
          if (_selectedUser != null) ...[
            _buildSelectedUserCard(),
            SizedBox(height: 40.h),
          ] else ...[
            // Search Field
            _buildSearchField(),
            SizedBox(height: 16.h),

            // Search Results or empty state
            if (_isSearching)
              _buildLoadingIndicator()
            else if (_searchResults.isNotEmpty)
              _buildSearchResults()
            else if (_lastQuery.isNotEmpty)
              _buildNoResults(),
            SizedBox(height: 40.h),
          ],

          // Continue Button
          _buildContinueButton(),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchController,
      onChanged: _onSearchChanged,
      autofocus: true,
      style: TextStyle(
        color: Colors.white,
        fontSize: 16.sp,
      ),
      decoration: InputDecoration(
        hintText: 'Search username, name, email, or phone...',
        hintStyle: TextStyle(
          color: const Color(0xFF6B7280),
          fontSize: 14.sp,
        ),
        prefixIcon: Icon(
          Icons.person_search,
          color: const Color(0xFF3B82F6),
          size: 22.sp,
        ),
        suffixIcon: _searchController.text.isNotEmpty
            ? GestureDetector(
                onTap: () {
                  _searchController.clear();
                  setState(() {
                    _searchResults = [];
                    _lastQuery = '';
                    _isSearching = false;
                  });
                },
                child: Icon(
                  Icons.close,
                  color: const Color(0xFF9CA3AF),
                  size: 20.sp,
                ),
              )
            : null,
        filled: true,
        fillColor: const Color(0xFF1F1F1F),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: const BorderSide(color: Color(0xFF3B82F6), width: 2),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 24.h),
        child: SizedBox(
          width: 28.w,
          height: 28.h,
          child: const CircularProgressIndicator(
            color: Color(0xFF3B82F6),
            strokeWidth: 2,
          ),
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${_searchResults.length} user${_searchResults.length == 1 ? '' : 's'} found',
          style: TextStyle(
            color: const Color(0xFF9CA3AF),
            fontSize: 12.sp,
          ),
        ),
        SizedBox(height: 8.h),
        ...List.generate(
          _searchResults.length > 5 ? 5 : _searchResults.length,
          (index) => _buildUserResultTile(_searchResults[index]),
        ),
      ],
    );
  }

  Widget _buildUserResultTile(UserSearchResultEntity user) {
    return GestureDetector(
      onTap: () => _selectUser(user),
      child: Container(
        margin: EdgeInsets.only(bottom: 8.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: const Color(0xFF2D2D2D)),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20.r,
              backgroundColor: const Color(0xFF3B82F6).withValues(alpha: 0.2),
              backgroundImage: user.profilePicture.isNotEmpty
                  ? NetworkImage(user.profilePicture)
                  : null,
              child: user.profilePicture.isEmpty
                  ? Text(
                      user.initials,
                      style: TextStyle(
                        color: const Color(0xFF3B82F6),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
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
                    user.fullName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    '@${user.username}',
                    style: TextStyle(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 12.sp,
                    ),
                  ),
                  if (user.email.isNotEmpty) ...[
                    SizedBox(height: 2.h),
                    Text(
                      user.email,
                      style: TextStyle(
                        color: const Color(0xFF6B7280),
                        fontSize: 11.sp,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Icon(
              Icons.add_circle_outline,
              color: const Color(0xFF3B82F6),
              size: 24.sp,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedUserCard() {
    final user = _selectedUser!;
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF3B82F6).withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: const Color(0xFF3B82F6).withValues(alpha: 0.4),
          width: 2,
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24.r,
            backgroundColor: const Color(0xFF3B82F6).withValues(alpha: 0.2),
            backgroundImage: user.profilePicture.isNotEmpty
                ? NetworkImage(user.profilePicture)
                : null,
            child: user.profilePicture.isEmpty
                ? Text(
                    user.initials,
                    style: TextStyle(
                      color: const Color(0xFF3B82F6),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
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
                  user.fullName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  '@${user.username}',
                  style: TextStyle(
                    color: const Color(0xFF3B82F6),
                    fontSize: 14.sp,
                  ),
                ),
                if (user.email.isNotEmpty) ...[
                  SizedBox(height: 2.h),
                  Text(
                    user.email,
                    style: TextStyle(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ],
            ),
          ),
          GestureDetector(
            onTap: _clearSelection,
            child: Container(
              width: 32.w,
              height: 32.h,
              decoration: BoxDecoration(
                color: const Color(0xFF2D2D2D),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.close,
                color: const Color(0xFF9CA3AF),
                size: 18.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoResults() {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 24.h),
        child: Column(
          children: [
            Icon(
              Icons.person_off_outlined,
              color: const Color(0xFF9CA3AF),
              size: 40.sp,
            ),
            SizedBox(height: 8.h),
            Text(
              'No users found',
              style: TextStyle(
                color: const Color(0xFF9CA3AF),
                fontSize: 14.sp,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'Try a different name, username, email, or phone',
              style: TextStyle(
                color: const Color(0xFF6B7280),
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContinueButton() {
    final hasSelection = _selectedUser != null;
    return Container(
      width: double.infinity,
      height: 56.h,
      decoration: BoxDecoration(
        gradient: hasSelection
            ? const LinearGradient(
                colors: [Color(0xFF3B82F6), Color(0xFF60A5FA)],
              )
            : null,
        color: hasSelection ? null : const Color(0xFF2D2D2D),
        borderRadius: BorderRadius.circular(28.r),
        boxShadow: hasSelection
            ? [
                BoxShadow(
                  color: const Color(0xFF3B82F6).withValues(alpha: 0.4),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _submitStep,
          borderRadius: BorderRadius.circular(28.r),
          child: Center(
            child: Text(
              'Continue',
              style: TextStyle(
                color: hasSelection ? Colors.white : const Color(0xFF6B7280),
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
