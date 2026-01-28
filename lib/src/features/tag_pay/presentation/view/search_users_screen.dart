import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/services/injection_container.dart';
import '../../../../../core/types/app_routes.dart';
import '../cubit/tag_pay_cubit.dart';
import '../cubit/tag_pay_state.dart';

class SearchUsersScreen extends StatelessWidget {
  const SearchUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => serviceLocator<TagPayCubit>(),
      child: const _SearchUsersView(),
    );
  }
}

class _SearchUsersView extends StatefulWidget {
  const _SearchUsersView();

  @override
  State<_SearchUsersView> createState() => _SearchUsersViewState();
}

class _SearchUsersViewState extends State<_SearchUsersView> {
  final _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _searchUsers(String query) {
    if (query.isEmpty) {
      setState(() => _isSearching = false);
      return;
    }

    final cleanQuery = query.replaceAll('@', '').replaceAll('\$', '');
    if (cleanQuery.length < 2) {
      setState(() => _isSearching = false);
      return;
    }

    setState(() => _isSearching = true);
    context.read<TagPayCubit>().searchTagPay(cleanQuery);
  }

  void _selectUser(dynamic tagPay) {
    final cubit = context.read<TagPayCubit>();
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1F1F1F),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      builder: (bottomSheetContext) => BlocProvider.value(
        value: cubit,
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
            Text(
              'What do you want to do?',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 24.h),
            _buildActionButton(
              icon: Icons.send,
              label: 'Send Money',
              color: const Color(0xFF10B981),
              onTap: () {
                Get.back();
                Get.toNamed('/cash-tag/send', arguments: tagPay);
              },
            ),
            SizedBox(height: 12.h),
            _buildActionButton(
              icon: Icons.request_page,
              label: 'Request Money',
              color: const Color(0xFFF59E0B),
              onTap: () {
                Get.back();
                Get.toNamed('/cash-tag/request', arguments: tagPay);
              },
            ),
            SizedBox(height: 12.h),
            TextButton(
              onPressed: () => Get.back(),
              child: Text(
                'Cancel',
                style: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: EdgeInsets.symmetric(vertical: 16.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 20.sp),
          SizedBox(width: 8.w),
          Text(
            label,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: BlocConsumer<TagPayCubit, TagPayState>(
        listener: (context, state) {
          if (state is TagPaySearchResults) {
            setState(() => _isSearching = false);
          } else if (state is TagPayError) {
            setState(() => _isSearching = false);
            Get.snackbar(
              'Error',
              state.message,
              backgroundColor: const Color(0xFFEF4444),
              colorText: Colors.white,
            );
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Column(
              children: [
                _buildHeader(context),
                _buildSearchBar(),
                Expanded(child: _buildBody(state)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
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
                borderRadius: BorderRadius.circular(22.r),
                border: Border.all(color: const Color(0xFF2D2D2D)),
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
            child: Text(
              'Search Users',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          GestureDetector(
            onTap: () async {
              // Navigate to QR scanner and wait for result
              final result = await Get.toNamed(AppRoutes.qrScanner);
              if (result != null && result is Map<String, dynamic>) {
                // User scanned a QR code successfully
                // Create a tag pay object from the scanned data
                final scannedUser = {
                  'displayName': result['name'] ?? result['username'],
                  'formattedTagPay': '\$${result['username']}',
                  'recipientId': result['recipientId'],
                  'username': result['username'],
                };
                _selectUser(scannedUser);
              }
            },
            child: Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF4E03D0),
                    Color(0xFF6B21E0),
                  ],
                ),
                borderRadius: BorderRadius.circular(22.r),
              ),
              child: Icon(
                Icons.qr_code_scanner,
                color: Colors.white,
                size: 22.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      child: TextField(
        controller: _searchController,
        style: GoogleFonts.inter(
          color: Colors.white,
          fontSize: 16.sp,
        ),
        decoration: InputDecoration(
          hintText: 'Search by tag pay or name',
          hintStyle: GoogleFonts.inter(
            color: const Color(0xFF6B7280),
          ),
          prefixIcon: Icon(
            Icons.search,
            color: const Color(0xFF9CA3AF),
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
                        const Color(0xFF3B82F6),
                      ),
                    ),
                  ),
                )
              : _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: Icon(
                        Icons.clear,
                        color: const Color(0xFF9CA3AF),
                      ),
                      onPressed: () {
                        _searchController.clear();
                        setState(() {});
                      },
                    )
                  : null,
          filled: true,
          fillColor: const Color(0xFF1F1F1F),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: const Color(0xFF2D2D2D)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: const Color(0xFF2D2D2D)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: const Color(0xFF3B82F6), width: 2),
          ),
        ),
        onChanged: (value) {
          // Debounce the search
          Future.delayed(const Duration(milliseconds: 500), () {
            if (value == _searchController.text) {
              _searchUsers(value);
            }
          });
        },
        onSubmitted: _searchUsers,
      ),
    );
  }

  Widget _buildBody(TagPayState state) {
    if (state is TagPayLoading) {
      return _buildLoadingState();
    }

    if (state is TagPaySearchResults) {
      if (state.results.isEmpty) {
        return _buildNoResultsState();
      }
      return _buildResultsList(state.results);
    }

    return _buildInitialState();
  }

  Widget _buildLoadingState() {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(const Color(0xFF3B82F6)),
      ),
    );
  }

  Widget _buildInitialState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search,
            size: 80.sp,
            color: const Color(0xFF374151),
          ),
          SizedBox(height: 16.h),
          Text(
            'Search for Users',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Enter a tag pay or name to find users',
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoResultsState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 80.sp,
            color: const Color(0xFF374151),
          ),
          SizedBox(height: 16.h),
          Text(
            'No Results Found',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Try searching with a different tag pay',
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsList(List results) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      itemCount: results.length,
      itemBuilder: (context, index) {
        final tagPay = results[index];
        return _buildUserCard(tagPay);
      },
    );
  }

  Widget _buildUserCard(dynamic tagPay) {
    return GestureDetector(
      onTap: () => _selectUser(tagPay),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: const Color(0xFF2D2D2D)),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30.r,
              backgroundColor: const Color(0xFF3B82F6).withValues(alpha: 0.1),
              child: Text(
                tagPay.displayName.isNotEmpty
                    ? tagPay.displayName[0].toUpperCase()
                    : '\$',
                style: GoogleFonts.inter(
                  color: const Color(0xFF3B82F6),
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tagPay.displayName,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    tagPay.formattedTagPay,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: const Color(0xFF9CA3AF),
              size: 16.sp,
            ),
          ],
        ),
      ),
    );
  }
}
