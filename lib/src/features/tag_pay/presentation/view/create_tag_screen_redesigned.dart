import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/user_search_result_entity.dart';
import '../cubit/tag_pay_cubit.dart';
import '../../../../../core/types/app_routes.dart';

class CreateTagScreenRedesigned extends StatefulWidget {
  const CreateTagScreenRedesigned({super.key});

  @override
  State<CreateTagScreenRedesigned> createState() =>
      _CreateTagScreenRedesignedState();
}

class _CreateTagScreenRedesignedState extends State<CreateTagScreenRedesigned> {
  final _searchController = TextEditingController();
  final List<UserSearchResultEntity> _selectedUsers = [];
  List<UserSearchResultEntity> _searchResults = [];
  bool _isSearching = false;

  static const int _maxUsers = 10;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _searchUsers(String query) async {
    if (query.trim().isEmpty) {
      setState(() {
        _searchResults = [];
        _isSearching = false;
      });
      return;
    }

    setState(() {
      _isSearching = true;
    });

    try {
      final results = await context.read<TagPayCubit>().searchUsers(query);
      if (!mounted) return;
      setState(() {
        _searchResults = results;
        _isSearching = false;
      });
    } catch (e) {
      setState(() {
        _isSearching = false;
      });
      Get.snackbar(
        'Search Error',
        e.toString(),
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
      );
    }
  }

  void _toggleUser(UserSearchResultEntity user) {
    if (_selectedUsers.any((u) => u.userId == user.userId)) {
      setState(() {
        _selectedUsers.removeWhere((u) => u.userId == user.userId);
      });
      return;
    }
    if (_selectedUsers.length >= _maxUsers) {
      Get.snackbar(
        'Limit Reached',
        'Maximum $_maxUsers users per batch',
        backgroundColor: const Color(0xFFFB923C),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }
    setState(() {
      _selectedUsers.add(user);
    });
  }

  void _goToAmountScreen() {
    Get.toNamed(
      AppRoutes.tagAmount,
      arguments: {'selectedUsers': _selectedUsers},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              SizedBox(height: 24.h),
              if (_selectedUsers.isNotEmpty) _buildSelectedUsersChips(),
              _buildUserSearch(),
              Expanded(
                child: _searchResults.isNotEmpty || _isSearching
                    ? _buildSearchResults()
                    : _buildEmptyState(),
              ),
              if (_selectedUsers.isNotEmpty) _buildNextButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Get.back(),
          child: Container(
            width: 44.w,
            height: 44.w,
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(22.r),
            ),
            child: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
              size: 18.sp,
            ),
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tag Users',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'Select users to tag',
                style: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSelectedUsersChips() {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Wrap(
        spacing: 8.w,
        runSpacing: 8.h,
        children: _selectedUsers.map((user) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: const Color(0xFF3B82F6), width: 1),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 12.r,
                  backgroundColor:
                      const Color(0xFF3B82F6).withValues(alpha: 0.2),
                  child: Text(
                    user.initials,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF3B82F6),
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(width: 6.w),
                Text(
                  '@${user.username}',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: 4.w),
                GestureDetector(
                  onTap: () => _toggleUser(user),
                  child: Icon(
                    Icons.close,
                    color: const Color(0xFF9CA3AF),
                    size: 16.sp,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildUserSearch() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Search Users',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: TextField(
            controller: _searchController,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
            ),
            decoration: InputDecoration(
              hintText: 'Search by @username or name',
              hintStyle: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 16.sp,
              ),
              prefixIcon: Icon(
                Icons.search,
                color: const Color(0xFF9CA3AF),
                size: 20.sp,
              ),
              suffixIcon: _isSearching
                  ? Padding(
                      padding: EdgeInsets.all(12.w),
                      child: SizedBox(
                        width: 20.w,
                        height: 20.w,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                              const Color(0xFF3B82F6)),
                        ),
                      ),
                    )
                  : null,
              border: InputBorder.none,
            ),
            onChanged: (value) {
              _searchUsers(value);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSearchResults() {
    if (_isSearching) {
      return Padding(
        padding: EdgeInsets.only(top: 32.h),
        child: Center(
          child: CircularProgressIndicator(
            valueColor:
                AlwaysStoppedAnimation<Color>(const Color(0xFF3B82F6)),
          ),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.only(top: 16.h),
      child: ListView.builder(
        itemCount: _searchResults.length,
        itemBuilder: (context, index) {
          final user = _searchResults[index];
          final alreadySelected =
              _selectedUsers.any((u) => u.userId == user.userId);
          return Container(
            margin: EdgeInsets.only(bottom: 4.h),
            decoration: BoxDecoration(
              color: alreadySelected
                  ? const Color(0xFF3B82F6).withValues(alpha: 0.12)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(12.r),
              border: alreadySelected
                  ? Border.all(color: const Color(0xFF3B82F6).withValues(alpha: 0.4), width: 1)
                  : null,
            ),
            child: ListTile(
              onTap: () => _toggleUser(user),
              leading: Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFF3B82F6).withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Icon(
                    Icons.person,
                    color: const Color(0xFF3B82F6),
                    size: 20.sp,
                  ),
                ),
                title: Text(
                  user.fullName,
                  style: GoogleFonts.inter(
                    color: alreadySelected
                        ? const Color(0xFF9CA3AF)
                        : Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  '@${user.username}',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF3B82F6),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                trailing: alreadySelected
                    ? Container(
                        width: 32.w,
                        height: 32.w,
                        decoration: BoxDecoration(
                          color: const Color(0xFF10B981).withValues(alpha: 0.15),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.check,
                            color: const Color(0xFF10B981), size: 20.sp),
                      )
                    : Container(
                        width: 32.w,
                        height: 32.w,
                        decoration: BoxDecoration(
                          color: const Color(0xFF3B82F6).withValues(alpha: 0.15),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.add,
                            color: const Color(0xFF3B82F6), size: 20.sp),
                      ),
              ),
            );
          },
        ),
      );
  }

  Widget _buildEmptyState() {
    if (_selectedUsers.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person_search, color: const Color(0xFF9CA3AF), size: 48.sp),
            SizedBox(height: 16.h),
            Text(
              'Search for users to tag',
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildNextButton() {
    return Padding(
      padding: EdgeInsets.only(top: 16.h),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: _goToAmountScreen,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF3B82F6),
            padding: EdgeInsets.symmetric(vertical: 16.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            elevation: 0,
          ),
          child: Text(
            'Next',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
