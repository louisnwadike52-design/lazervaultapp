import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/utils/currency_formatter.dart';
import '../../domain/entities/group_entities.dart';
import '../cubit/group_account_cubit.dart';
import '../cubit/group_account_state.dart';

class PublicGroupDetailBottomSheet extends StatefulWidget {
  final String groupId;

  const PublicGroupDetailBottomSheet({
    super.key,
    required this.groupId,
  });

  /// Show the bottom sheet for a public group detail.
  static void show(BuildContext context, String groupId) {
    final cubit = context.read<GroupAccountCubit>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => BlocProvider.value(
        value: cubit,
        child: PublicGroupDetailBottomSheet(groupId: groupId),
      ),
    );
  }

  @override
  State<PublicGroupDetailBottomSheet> createState() =>
      _PublicGroupDetailBottomSheetState();
}

class _PublicGroupDetailBottomSheetState
    extends State<PublicGroupDetailBottomSheet> {
  bool _isJoining = false;
  bool _hasJoined = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GroupAccountCubit>().loadPublicGroupDetail(widget.groupId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      child: BlocConsumer<GroupAccountCubit, GroupAccountState>(
        listener: (context, state) {
          if (state is JoinPublicGroupSuccess) {
            setState(() {
              _isJoining = false;
              _hasJoined = true;
            });
            Navigator.of(context).pop();
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
          } else if (state is GroupAccountError && _isJoining) {
            setState(() => _isJoining = false);
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
            return SizedBox(
              height: 300.h,
              child: const Center(
                child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(Color(0xFF3B82F6)),
                ),
              ),
            );
          }

          if (state is PublicGroupDetailLoaded) {
            return _buildContent(state.detail);
          }

          if (state is GroupAccountError) {
            return SizedBox(
              height: 300.h,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 40.sp,
                      color: const Color(0xFFEF4444),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      'Failed to load group details',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    TextButton(
                      onPressed: () {
                        context
                            .read<GroupAccountCubit>()
                            .loadPublicGroupDetail(widget.groupId);
                      },
                      child: Text(
                        'Try Again',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF3B82F6),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          // Loading placeholder while waiting for state
          return SizedBox(
            height: 300.h,
            child: const Center(
              child: CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation<Color>(Color(0xFF3B82F6)),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildContent(PublicGroupDetail detail) {
    final group = detail.group;
    final stats = detail.statistics;
    final activeContributions =
        stats?['active_contributions']?.toString() ?? '0';
    final totalCollected =
        stats?['total_collected']?.toString() ?? group.totalRaised.toStringAsFixed(2);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Drag handle
        Container(
          margin: EdgeInsets.only(top: 12.h),
          width: 40.w,
          height: 4.h,
          decoration: BoxDecoration(
            color: const Color(0xFF9CA3AF).withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(2.r),
          ),
        ),
        SizedBox(height: 16.h),

        // Scrollable content
        Flexible(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Group header
                Row(
                  children: [
                    Container(
                      width: 56.w,
                      height: 56.w,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFF3B82F6),
                            const Color(0xFF3B82F6).withValues(alpha: 0.7),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                      child: Center(
                        child: Text(
                          group.name.isNotEmpty
                              ? group.name[0].toUpperCase()
                              : 'G',
                          style: GoogleFonts.inter(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 14.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            group.name,
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4.h),
                          if (group.visibility == GroupVisibility.public)
                            Row(
                              children: [
                                Icon(
                                  Icons.public,
                                  color: const Color(0xFF10B981),
                                  size: 14.sp,
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  'Public Group',
                                  style: GoogleFonts.inter(
                                    color: const Color(0xFF10B981),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16.h),

                // Description
                Text(
                  group.description,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 14.sp,
                    height: 1.5,
                  ),
                ),

                SizedBox(height: 20.h),

                // Stats row
                Row(
                  children: [
                    _buildStatCard(
                      icon: Icons.people_outline,
                      label: 'Members',
                      value: '${group.memberCount}',
                    ),
                    SizedBox(width: 10.w),
                    _buildStatCard(
                      icon: Icons.trending_up,
                      label: 'Active',
                      value: activeContributions,
                    ),
                    SizedBox(width: 10.w),
                    _buildStatCard(
                      icon: Icons.account_balance_wallet_outlined,
                      label: 'Collected',
                      value: '${CurrencySymbols.currentSymbol}$totalCollected',
                    ),
                  ],
                ),

                SizedBox(height: 20.h),

                // Top contributors
                if (detail.topContributors.isNotEmpty) ...[
                  Text(
                    'Top Contributors',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  ...detail.topContributors.take(5).map(
                        (contributor) => _buildContributorRow(contributor),
                      ),
                  SizedBox(height: 12.h),
                ],

                SizedBox(height: 16.h),
              ],
            ),
          ),
        ),

        // Join button
        _buildJoinButton(detail),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
        decoration: BoxDecoration(
          color: const Color(0xFF0A0A0A),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: const Color(0xFF3B82F6),
              size: 20.sp,
            ),
            SizedBox(height: 6.h),
            Text(
              value,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 2.h),
            Text(
              label,
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 11.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContributorRow(PublicGroupContributor contributor) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Row(
        children: [
          // Avatar
          CircleAvatar(
            radius: 18.r,
            backgroundColor: const Color(0xFF2D2D2D),
            backgroundImage: contributor.profileImage != null
                ? NetworkImage(contributor.profileImage!)
                : null,
            child: contributor.profileImage == null
                ? Text(
                    contributor.displayName.isNotEmpty
                        ? contributor.displayName[0].toUpperCase()
                        : '?',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                : null,
          ),
          SizedBox(width: 10.w),
          // Name
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  contributor.displayName,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '${contributor.contributionCount} contribution${contributor.contributionCount == 1 ? '' : 's'}',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 11.sp,
                  ),
                ),
              ],
            ),
          ),
          // Amount
          Text(
            '${CurrencySymbols.formatAmount(contributor.totalContributed)}',
            style: GoogleFonts.inter(
              color: const Color(0xFF10B981),
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJoinButton(PublicGroupDetail detail) {
    final isMember = detail.isMember || _hasJoined;
    final isDisabled = isMember || _isJoining;

    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 24.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        border: Border(
          top: BorderSide(
            color: const Color(0xFF2D2D2D),
            width: 1,
          ),
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        height: 48.h,
        child: ElevatedButton(
          onPressed: isDisabled
              ? null
              : () {
                  setState(() => _isJoining = true);
                  context
                      .read<GroupAccountCubit>()
                      .joinPublicGroupById(widget.groupId);
                },
          style: ElevatedButton.styleFrom(
            backgroundColor:
                isDisabled ? const Color(0xFF2D2D2D) : const Color(0xFF3B82F6),
            disabledBackgroundColor: const Color(0xFF2D2D2D),
            foregroundColor: Colors.white,
            disabledForegroundColor: const Color(0xFF9CA3AF),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            elevation: 0,
          ),
          child: _isJoining
              ? SizedBox(
                  width: 20.w,
                  height: 20.w,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : Text(
                  isMember ? 'Already a Member' : 'Join Group',
                  style: GoogleFonts.inter(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ),
      ),
    );
  }
}
