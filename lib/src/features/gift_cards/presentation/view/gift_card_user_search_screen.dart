import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/services/injection_container.dart';
import '../../../../../core/utils/debouncer.dart';
import '../../../../../core/utils/user_search_query.dart';
import '../../../profile/cubit/profile_cubit.dart';
import '../../../tag_pay/domain/entities/user_search_result_entity.dart';

/// Screen for searching LazerVault users to transfer a gift card to.
/// Uses ProfileCubit.searchUsers (same as internal transfer flow).
/// Returns the selected user as a Map with userId, username, firstName, lastName, email.
class GiftCardUserSearchScreen extends StatefulWidget {
  const GiftCardUserSearchScreen({super.key});

  @override
  State<GiftCardUserSearchScreen> createState() =>
      _GiftCardUserSearchScreenState();
}

class _GiftCardUserSearchScreenState extends State<GiftCardUserSearchScreen> {
  final _searchController = TextEditingController();
  final _debouncer = Debouncer.search();
  bool _isSearching = false;
  List<UserSearchResultEntity> _results = [];
  String? _error;

  late final ProfileCubit _profileCubit;

  @override
  void initState() {
    super.initState();
    _profileCubit = serviceLocator<ProfileCubit>();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debouncer.dispose();
    super.dispose();
  }

  Future<void> _searchUsers(String query) async {
    if (query.isEmpty) {
      setState(() {
        _isSearching = false;
        _results = [];
        _error = null;
      });
      return;
    }

    final normalized = normalizeLazerVaultUserSearchQuery(query);
    if (normalized.length < 2) {
      setState(() {
        _isSearching = false;
        _results = [];
      });
      return;
    }

    setState(() {
      _isSearching = true;
      _error = null;
    });

    try {
      final results = await _profileCubit.searchUsers(query, limit: 15);
      if (mounted) {
        setState(() {
          _results = results;
          _isSearching = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = 'Search failed. Please try again.';
          _isSearching = false;
        });
      }
    }
  }

  void _selectUser(UserSearchResultEntity user) {
    Get.back(result: {
      'userId': user.userId,
      'username': user.username,
      'firstName': user.firstName,
      'lastName': user.lastName,
      'email': user.email,
      'fullName': user.fullName.trim().isNotEmpty
          ? user.fullName.trim()
          : user.username,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildSearchBar(),
            Expanded(child: _buildBody()),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(20.w),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: const Icon(Icons.arrow_back_ios_new,
                  color: Colors.white, size: 18),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Text(
              'Select Recipient',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: TextField(
        controller: _searchController,
        style: GoogleFonts.inter(color: Colors.white, fontSize: 16.sp),
        decoration: InputDecoration(
          hintText: 'Search by username, email or phone...',
          hintStyle: GoogleFonts.inter(
            color: const Color(0xFF6B7280),
            fontSize: 14.sp,
          ),
          filled: true,
          fillColor: const Color(0xFF1F1F1F),
          prefixIcon: Icon(Icons.search,
              color: const Color(0xFF6B7280), size: 20.sp),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    _searchController.clear();
                    setState(() {
                      _isSearching = false;
                      _results = [];
                      _error = null;
                    });
                  },
                  icon: Icon(Icons.clear,
                      color: const Color(0xFF6B7280), size: 18.sp),
                )
              : null,
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
            borderSide: const BorderSide(color: Color(0xFF3B82F6)),
          ),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        ),
        onChanged: (query) {
          setState(() {}); // Rebuild suffix icon
          _debouncer.run(() => _searchUsers(query));
        },
      ),
    );
  }

  Widget _buildBody() {
    if (_isSearching) {
      return const Center(
        child: CircularProgressIndicator(color: Color(0xFF3B82F6)),
      );
    }

    if (_error != null) {
      return Center(
        child: Text(
          _error!,
          style: GoogleFonts.inter(
              color: const Color(0xFFEF4444), fontSize: 14.sp),
        ),
      );
    }

    if (_results.isNotEmpty) {
      return ListView.builder(
        padding: EdgeInsets.all(20.w),
        itemCount: _results.length,
        itemBuilder: (context, index) => _buildUserCard(_results[index]),
      );
    }

    if (_searchController.text.isNotEmpty &&
        _searchController.text.length >= 2) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.person_search,
                color: const Color(0xFF6B7280), size: 48.sp),
            SizedBox(height: 16.h),
            Text(
              'No users found',
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 16.sp,
              ),
            ),
          ],
        ),
      );
    }

    // Empty state
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.person_search,
              color: const Color(0xFF2D2D2D), size: 64.sp),
          SizedBox(height: 16.h),
          Text(
            'Search for a LazerVault user',
            style: GoogleFonts.inter(
              color: const Color(0xFF6B7280),
              fontSize: 16.sp,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'Enter username, email, or phone number',
            style: GoogleFonts.inter(
              color: const Color(0xFF4B5563),
              fontSize: 13.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserCard(UserSearchResultEntity user) {
    final fullName = user.fullName.trim().isNotEmpty
        ? user.fullName.trim()
        : user.username;

    return GestureDetector(
      onTap: () => _selectUser(user),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: const Color(0xFF2D2D2D)),
        ),
        child: Row(
          children: [
            // Avatar
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                color: const Color(0xFF3B82F6).withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(24.r),
              ),
              child: user.profilePicture.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(24.r),
                      child: Image.network(
                        user.profilePicture,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Center(
                          child: Text(
                            user.initials.isNotEmpty ? user.initials : '?',
                            style: GoogleFonts.inter(
                              color: const Color(0xFF3B82F6),
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    )
                  : Center(
                      child: Text(
                        user.initials.isNotEmpty ? user.initials : '?',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF3B82F6),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    fullName,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    user.searchMatchInfo,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 12.sp,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right,
                color: const Color(0xFF6B7280), size: 20.sp),
          ],
        ),
      ),
    );
  }
}
