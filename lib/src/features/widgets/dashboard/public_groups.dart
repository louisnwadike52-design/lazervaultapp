import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/group_account/presentation/cubit/group_account_cubit.dart';
import 'package:lazervault/src/features/group_account/presentation/cubit/group_account_state.dart';

class PublicGroups extends StatefulWidget {
  const PublicGroups({super.key});

  @override
  State<PublicGroups> createState() => _PublicGroupsState();
}

class _PublicGroupsState extends State<PublicGroups> {
  final Set<String> _joiningGroupIds = {};

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
          if (state is GroupAccountLoading && _joiningGroupIds.isEmpty) {
            return _buildShimmer();
          }
          if (state is PublicGroupsLoaded) {
            final groups = state.groups;
            if (groups.isEmpty) {
              return const SizedBox.shrink();
            }
            return Column(
              children: [
                if (state.isStale)
                  const LinearProgressIndicator(
                    minHeight: 2,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Color(0xFF3B82F6)),
                    backgroundColor: Color(0xFF1F1F1F),
                  ),
                _buildContent(groups),
              ],
            );
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
          height: 140.h,
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
        width: 200.w,
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 120.w,
              height: 14.h,
              decoration: BoxDecoration(
                color: const Color(0xFF2D2D2D),
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
            SizedBox(height: 8.h),
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
              width: 80.w,
              height: 10.h,
              decoration: BoxDecoration(
                color: const Color(0xFF2D2D2D),
                borderRadius: BorderRadius.circular(4.r),
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
              color: Colors.white,
            ),
          ),
          GestureDetector(
            onTap: () => Get.toNamed(AppRoutes.groupAccount),
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

  Widget _buildContent(List<GroupAccount> groups) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        SizedBox(height: 12.h),
        SizedBox(
          height: 140.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: groups.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(right: 12.w),
                child: _buildGroupCard(groups[index]),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildGroupCard(GroupAccount group) {
    return GestureDetector(
      onTap: () => Get.toNamed(
        AppRoutes.groupDetails,
        arguments: group.id,
      ),
      child: Container(
        width: 200.w,
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              group.name,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 4.h),
            Text(
              group.description,
              style: TextStyle(
                fontSize: 12.sp,
                color: const Color(0xFF9CA3AF),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.people_outline,
                      size: 14.sp,
                      color: const Color(0xFF9CA3AF),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      '${group.memberCount} members',
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: const Color(0xFF9CA3AF),
                      ),
                    ),
                  ],
                ),
                _buildJoinButton(group),
              ],
            ),
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
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: const Color(0xFF3B82F6),
            width: 1.5,
          ),
        ),
        child: isJoining
            ? SizedBox(
                width: 14.w,
                height: 14.w,
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(Color(0xFF3B82F6)),
                ),
              )
            : Text(
                'Join',
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF3B82F6),
                ),
              ),
      ),
    );
  }
}
