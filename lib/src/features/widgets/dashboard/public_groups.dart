import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/group_account/presentation/cubit/group_account_cubit.dart';
import 'package:lazervault/src/features/group_account/presentation/cubit/group_account_state.dart';
import 'package:lazervault/src/features/group_account/presentation/widgets/public_group_detail_bottom_sheet.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

class PublicGroups extends StatefulWidget {
  const PublicGroups({super.key});

  @override
  State<PublicGroups> createState() => _PublicGroupsState();
}

class _PublicGroupsState extends State<PublicGroups> {
  final Set<String> _joiningGroupIds = {};

  // Retain the last loaded list so the section doesn't collapse to an
  // empty gap while a transient "Joining…" load is in flight (the cubit
  // is shared, so an inline join briefly emits GroupAccountLoading).
  PublicGroupsLoaded? _lastLoaded;

  @override
  void initState() {
    super.initState();
    context.read<GroupAccountCubit>().loadPublicGroups();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GroupAccountCubit, GroupAccountState>(
      listener: (context, state) {
        if (state is JoinPublicGroupSuccess) {
          setState(() => _joiningGroupIds.clear());
          Get.snackbar(
            'Success',
            state.message,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: const Color(0xFF10B981),
            colorText: Colors.white,
            duration: const Duration(seconds: 2),
          );
          // Refresh so the freshly-joined group flips from "Join" to
          // "Joined" (membership is recomputed from the user's groups,
          // which joinPublicGroupById has already refreshed).
          context.read<GroupAccountCubit>().loadPublicGroups();
        } else if (state is GroupAccountError &&
            _joiningGroupIds.isNotEmpty) {
          setState(() => _joiningGroupIds.clear());
          Get.snackbar(
            'Error',
            state.message,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: const Color(0xFFEF4444),
            colorText: Colors.white,
            duration: const Duration(seconds: 2),
          );
        }
      },
      child: BlocBuilder<GroupAccountCubit, GroupAccountState>(
        builder: (context, state) {
          if (state is PublicGroupsLoaded) {
            _lastLoaded = state;
          }

          final loaded = state is PublicGroupsLoaded ? state : _lastLoaded;

          if (loaded != null) {
            if (loaded.groups.isEmpty) {
              return const SizedBox.shrink();
            }
            return Column(
              children: [
                if (loaded.isStale)
                  const LinearProgressIndicator(
                    minHeight: 2,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Color(0xFF3B82F6)),
                    backgroundColor: Color(0xFF1F1F1F),
                  ),
                _buildContent(loaded),
              ],
            );
          }

          if (state is GroupAccountLoading && _joiningGroupIds.isEmpty) {
            return _buildShimmer();
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildShimmer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        SizedBox(height: 12.h),
        SizedBox(
          height: 158.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: 3,
            itemBuilder: (_, __) => _buildShimmerCard(),
          ),
        ),
      ],
    );
  }

  Widget _buildShimmerCard() {
    return Padding(
      padding: EdgeInsets.only(right: 12.w),
      child: Container(
        width: 220.w,
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2D2D2D),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                SizedBox(width: 10.w),
                Container(
                  width: 100.w,
                  height: 14.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2D2D2D),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Container(
              width: 160.w,
              height: 10.h,
              decoration: BoxDecoration(
                color: const Color(0xFF2D2D2D),
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
            const Spacer(),
            Container(
              width: double.infinity,
              height: 30.h,
              decoration: BoxDecoration(
                color: const Color(0xFF2D2D2D),
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Public Groups',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1F2937),
            ),
          ),
          GestureDetector(
            onTap: () => Get.toNamed(AppRoutes.publicGroups),
            child: Text(
              'View All',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF3B82F6),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(PublicGroupsLoaded loaded) {
    final groups = loaded.groups;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        SizedBox(height: 12.h),
        SizedBox(
          height: 158.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: groups.length,
            itemBuilder: (context, index) {
              final group = groups[index];
              return Padding(
                padding: EdgeInsets.only(right: 12.w),
                child: _buildGroupCard(group, loaded.isMemberOf(group.id)),
              );
            },
          ),
        ),
      ],
    );
  }

  /// Tap destination differs by membership: members go straight to the
  /// full group workspace; non-members get the public preview sheet
  /// (stats + join CTA) — the member-only details screen isn't the right
  /// surface for someone who hasn't joined.
  void _openGroup(GroupAccount group, bool isMember) {
    if (isMember) {
      Get.toNamed(AppRoutes.groupDetails, arguments: group.id);
    } else {
      PublicGroupDetailBottomSheet.show(context, group.id);
    }
  }

  Widget _buildGroupCard(GroupAccount group, bool isMember) {
    return GestureDetector(
      onTap: () => _openGroup(group, isMember),
      child: Container(
        width: 220.w,
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar + name
            Row(
              children: [
                Container(
                  width: 40.w,
                  height: 40.w,
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
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Text(
                    group.name,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            // Description
            Text(
              group.description,
              style: TextStyle(
                fontSize: 12.sp,
                color: const Color(0xFF9CA3AF),
                height: 1.3,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            // Footer: member count + CTA
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.people_outline,
                        size: 14.sp,
                        color: const Color(0xFF9CA3AF),
                      ),
                      SizedBox(width: 4.w),
                      Flexible(
                        child: Text(
                          '${group.memberCount} '
                          '${group.memberCount == 1 ? 'member' : 'members'}',
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: const Color(0xFF9CA3AF),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8.w),
                _buildCta(group, isMember),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Members see a non-actionable "Joined" chip; non-members see the
  /// interactive "Join" button. We never render a Join CTA for a group
  /// the user already belongs to.
  Widget _buildCta(GroupAccount group, bool isMember) {
    if (isMember) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: const Color(0xFF10B981).withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.check_circle,
              size: 13.sp,
              color: const Color(0xFF10B981),
            ),
            SizedBox(width: 4.w),
            Text(
              'Joined',
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF10B981),
              ),
            ),
          ],
        ),
      );
    }

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
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: const Color(0xFF3B82F6),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: isJoining
            ? LazerVaultLoader(size: 14)
            : Text(
                'Join',
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }
}
