import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/family_account/domain/entities/family_account_entities.dart';
import 'package:lazervault/src/features/family_account/presentation/cubit/family_account_cubit.dart';
import 'package:lazervault/src/features/family_account/presentation/cubit/family_account_state.dart';

class FamilyPendingInvitationsScreen extends StatefulWidget {
  const FamilyPendingInvitationsScreen({super.key});

  @override
  State<FamilyPendingInvitationsScreen> createState() =>
      _FamilyPendingInvitationsScreenState();
}

class _FamilyPendingInvitationsScreenState
    extends State<FamilyPendingInvitationsScreen> {
  final FamilyAccountCubit _cubit = serviceLocator<FamilyAccountCubit>();

  @override
  void initState() {
    super.initState();
    _cubit.loadPendingInvitations();
  }

  Future<void> _onRefresh() async {
    _cubit.loadPendingInvitations();
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
          'Pending Invitations',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocConsumer<FamilyAccountCubit, FamilyAccountState>(
          bloc: _cubit,
          listener: (context, state) {
            if (state is InvitationAccepted) {
              Get.snackbar(
                'Success',
                'Invitation accepted! You have joined the family account.',
                backgroundColor: const Color(0xFF10B981),
                colorText: Colors.white,
                snackPosition: SnackPosition.BOTTOM,
                margin: EdgeInsets.all(16.w),
              );
              _cubit.loadPendingInvitations();
            } else if (state is InvitationDeclined) {
              Get.snackbar(
                'Declined',
                'Invitation has been declined.',
                backgroundColor: const Color(0xFF1F1F1F),
                colorText: Colors.white,
                snackPosition: SnackPosition.BOTTOM,
                margin: EdgeInsets.all(16.w),
              );
              _cubit.loadPendingInvitations();
            } else if (state is FamilyAccountError) {
              Get.snackbar(
                'Error',
                state.message,
                backgroundColor: const Color(0xFFEF4444),
                colorText: Colors.white,
                snackPosition: SnackPosition.BOTTOM,
                margin: EdgeInsets.all(16.w),
              );
            }
          },
          builder: (context, state) {
            if (state is FamilyAccountLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFF3B82F6),
                ),
              );
            }

            if (state is PendingInvitationsLoaded) {
              if (state.invitations.isEmpty) {
                return _buildEmptyState();
              }
              return _buildInvitationsList(state.invitations);
            }

            // For transient states (InvitationAccepted, InvitationDeclined)
            // show a loader while we wait for the reload
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF3B82F6),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      color: const Color(0xFF3B82F6),
      backgroundColor: const Color(0xFF1F1F1F),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          SizedBox(height: 120.h),
          Icon(
            Icons.mail_outline,
            size: 64.sp,
            color: const Color(0xFF9CA3AF),
          ),
          SizedBox(height: 16.h),
          Text(
            'No Pending Invitations',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'You don\'t have any pending family\naccount invitations right now.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: const Color(0xFF9CA3AF),
              fontSize: 14.sp,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInvitationsList(List<PendingInvitation> invitations) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      color: const Color(0xFF3B82F6),
      backgroundColor: const Color(0xFF1F1F1F),
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        itemCount: invitations.length,
        separatorBuilder: (_, __) => SizedBox(height: 12.h),
        itemBuilder: (context, index) {
          return _buildInvitationCard(invitations[index]);
        },
      ),
    );
  }

  Widget _buildInvitationCard(PendingInvitation invitation) {
    final bool expiringsSoon =
        !invitation.isExpired && invitation.daysUntilExpiration < 3;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: const Color(0xFF2D2D2D),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Family name
          Text(
            invitation.familyName,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 6.h),

          // Creator name
          Text(
            'Invited by ${invitation.creatorName}',
            style: TextStyle(
              color: const Color(0xFF9CA3AF),
              fontSize: 13.sp,
            ),
          ),
          SizedBox(height: 12.h),

          // Divider
          Container(
            height: 1,
            color: const Color(0xFF2D2D2D),
          ),
          SizedBox(height: 12.h),

          // Initial allocation
          Row(
            children: [
              Text(
                'Initial Allocation',
                style: TextStyle(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Text(
                '\$${invitation.initialAllocation.toStringAsFixed(2)}',
                style: TextStyle(
                  color: const Color(0xFF10B981),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),

          // Spending limits
          Row(
            children: [
              Text(
                'Spending Limits',
                style: TextStyle(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Text(
                'Daily: \$${invitation.dailyLimit.toStringAsFixed(2)} / Monthly: \$${invitation.monthlyLimit.toStringAsFixed(2)}',
                style: TextStyle(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),

          // Expiry countdown
          Row(
            children: [
              Icon(
                Icons.schedule,
                size: 14.sp,
                color: invitation.isExpired
                    ? const Color(0xFFEF4444)
                    : expiringsSoon
                        ? const Color(0xFFFB923C)
                        : const Color(0xFF9CA3AF),
              ),
              SizedBox(width: 4.w),
              Text(
                invitation.isExpired
                    ? 'Expired'
                    : 'Expires in ${invitation.daysUntilExpiration} days',
                style: TextStyle(
                  color: invitation.isExpired
                      ? const Color(0xFFEF4444)
                      : expiringsSoon
                          ? const Color(0xFFFB923C)
                          : const Color(0xFF9CA3AF),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          // Action buttons
          Row(
            children: [
              // Decline button
              Expanded(
                child: OutlinedButton(
                  onPressed: invitation.isExpired
                      ? null
                      : () {
                          _cubit.declineInvitation(invitation.invitationToken);
                        },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      color: Color(0xFFEF4444),
                      width: 1,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    disabledForegroundColor:
                        const Color(0xFF9CA3AF).withValues(alpha: 0.5),
                  ),
                  child: Text(
                    'Decline',
                    style: TextStyle(
                      color: invitation.isExpired
                          ? const Color(0xFF9CA3AF).withValues(alpha: 0.5)
                          : const Color(0xFFEF4444),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              // Accept button
              Expanded(
                child: ElevatedButton(
                  onPressed: invitation.isExpired
                      ? null
                      : () {
                          _cubit.acceptInvitation(invitation.invitationToken);
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3B82F6),
                    disabledBackgroundColor:
                        const Color(0xFF3B82F6).withValues(alpha: 0.3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                  ),
                  child: Text(
                    'Accept',
                    style: TextStyle(
                      color: invitation.isExpired
                          ? Colors.white.withValues(alpha: 0.4)
                          : Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
