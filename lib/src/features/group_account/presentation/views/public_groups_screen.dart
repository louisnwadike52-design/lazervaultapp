import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/utils/debouncer.dart';
import '../../domain/entities/group_entities.dart';
import '../cubit/group_account_cubit.dart';
import '../cubit/group_account_state.dart';
import '../widgets/public_group_detail_bottom_sheet.dart';

class PublicGroupsScreen extends StatefulWidget {
  const PublicGroupsScreen({super.key});

  @override
  State<PublicGroupsScreen> createState() => _PublicGroupsScreenState();
}

class _PublicGroupsScreenState extends State<PublicGroupsScreen> {
  final TextEditingController _searchController = TextEditingController();
  final Debouncer _debouncer = Debouncer.search();
  final Set<String> _joiningGroupIds = {};
  String _selectedSort = 'most_members';

  static const _sortOptions = {
    'most_members': 'Most Members',
    'most_active': 'Most Active',
    'newest': 'Newest',
  };

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GroupAccountCubit>().loadPublicGroups(sortBy: _selectedSort);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debouncer.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    _debouncer.run(() {
      context.read<GroupAccountCubit>().loadPublicGroups(
            search: query.trim().isEmpty ? null : query.trim(),
            sortBy: _selectedSort,
          );
    });
  }

  void _onSortChanged(String sort) {
    _debouncer.cancel();
    setState(() {
      _selectedSort = sort;
    });
    context.read<GroupAccountCubit>().loadPublicGroups(
          search: _searchController.text.trim().isEmpty
              ? null
              : _searchController.text.trim(),
          sortBy: sort,
        );
  }

  Future<void> _onRefresh() async {
    context.read<GroupAccountCubit>().loadPublicGroups(
          search: _searchController.text.trim().isEmpty
              ? null
              : _searchController.text.trim(),
          sortBy: _selectedSort,
        );
  }

  void _onGroupTap(GroupAccount group) {
    PublicGroupDetailBottomSheet.show(context, group.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(
          'Public Groups',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 14.sp,
              ),
              decoration: InputDecoration(
                hintText: 'Search public groups...',
                hintStyle: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 14.sp,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: const Color(0xFF9CA3AF),
                  size: 20.sp,
                ),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          _searchController.clear();
                          _onSearchChanged('');
                        },
                        icon: Icon(
                          Icons.close,
                          color: const Color(0xFF9CA3AF),
                          size: 18.sp,
                        ),
                      )
                    : null,
                filled: true,
                fillColor: const Color(0xFF1F1F1F),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(
                    color: Color(0xFF2D2D2D),
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(
                    color: Color(0xFF3B82F6),
                    width: 1,
                  ),
                ),
              ),
            ),
          ),

          // Sort chips
          SizedBox(
            height: 40.h,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              children: _sortOptions.entries.map((entry) {
                final isSelected = entry.key == _selectedSort;
                return Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: GestureDetector(
                    onTap: () => _onSortChanged(entry.key),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 14.w),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF3B82F6).withValues(alpha: 0.15)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFF3B82F6)
                              : const Color(0xFF2D2D2D),
                          width: 1,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        entry.value,
                        style: GoogleFonts.inter(
                          color: isSelected
                              ? const Color(0xFF3B82F6)
                              : const Color(0xFF9CA3AF),
                          fontSize: 12.sp,
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          SizedBox(height: 8.h),

          // Groups list
          Expanded(
            child: BlocConsumer<GroupAccountCubit, GroupAccountState>(
              listener: (context, state) {
                if (state is JoinPublicGroupSuccess) {
                  setState(() => _joiningGroupIds.clear());
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: const Color(0xFF10B981),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                  );
                  // Reload public groups after joining
                  _onRefresh();
                } else if (state is GroupAccountError &&
                    _joiningGroupIds.isNotEmpty) {
                  setState(() => _joiningGroupIds.clear());
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: const Color(0xFFEF4444),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is GroupAccountLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Color(0xFF3B82F6)),
                    ),
                  );
                }

                if (state is PublicGroupsLoaded) {
                  if (state.groups.isEmpty) {
                    return _buildEmptyState();
                  }
                  return Column(
                    children: [
                      if (state.isStale)
                        const LinearProgressIndicator(
                          minHeight: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Color(0xFF3B82F6)),
                          backgroundColor: Color(0xFF1F1F1F),
                        ),
                      Expanded(
                        child: RefreshIndicator(
                          onRefresh: _onRefresh,
                          color: const Color(0xFF3B82F6),
                          backgroundColor: const Color(0xFF1F1F1F),
                          child: ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 8.h),
                            itemCount: state.groups.length,
                            itemBuilder: (context, index) {
                              final group = state.groups[index];
                              return _buildGroupCard(group);
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                }

                return _buildEmptyState();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGroupCard(GroupAccount group) {
    return GestureDetector(
      onTap: () => _onGroupTap(group),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Group avatar
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF3B82F6),
                    const Color(0xFF3B82F6).withValues(alpha: 0.7),
                  ],
                ),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Center(
                child: Text(
                  group.name.isNotEmpty
                      ? group.name[0].toUpperCase()
                      : 'G',
                  style: GoogleFonts.inter(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            // Group info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    group.name,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    group.description,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 13.sp,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Icon(
                        Icons.people_outline,
                        color: const Color(0xFF9CA3AF),
                        size: 14.sp,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        '${group.memberCount} members',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF9CA3AF),
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            // Join button
            _buildJoinButton(group),
          ],
        ),
      ),
    );
  }

  Widget _buildJoinButton(GroupAccount group) {
    final isJoining = _joiningGroupIds.contains(group.id);

    return GestureDetector(
      onTap: isJoining
          ? null
          : () {
              setState(() => _joiningGroupIds.add(group.id));
              context
                  .read<GroupAccountCubit>()
                  .joinPublicGroupById(group.id);
            },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: const Color(0xFF3B82F6),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: isJoining
            ? SizedBox(
                width: 16.w,
                height: 16.w,
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(
                'Join',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(height: 120.h),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.groups_outlined,
                size: 56.sp,
                color: const Color(0xFF9CA3AF),
              ),
              SizedBox(height: 16.h),
              Text(
                'No public groups found',
                style: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Try adjusting your search or filters',
                style: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 13.sp,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
