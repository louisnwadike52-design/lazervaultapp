import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/entities/family_account_entities.dart' as entities;

class FamilyAccountCard extends StatelessWidget {
  final entities.FamilyAccount familyAccount;
  final entities.FamilyMember? currentUserMember;
  final bool isActive;
  final VoidCallback? onManage;
  final VoidCallback? onAddFunds;
  final VoidCallback? onShowDetails;

  const FamilyAccountCard({
    super.key,
    required this.familyAccount,
    this.currentUserMember,
    this.isActive = false,
    this.onManage,
    this.onAddFunds,
    this.onShowDetails,
  });

  @override
  Widget build(BuildContext context) {
    final totalBalance = familyAccount.totalBalance;
    final memberAllocated = currentUserMember?.allocatedBalance ?? 0;
    final memberRemaining = currentUserMember?.remainingBalance ?? 0;
    final memberCount = familyAccount.activeMemberCount;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF6C5CE7).withOpacity(0.15),
            const Color(0xFFA29BFE).withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20.r),
        border: isActive
            ? Border.all(
                color: Colors.green.withOpacity(0.6),
                width: 2,
              )
            : null,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6C5CE7).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          SizedBox(height: 20.h),
          _buildTotalBalance(totalBalance),
          SizedBox(height: 16.h),
          _buildMemberAllocation(memberAllocated, memberRemaining),
          const Spacer(),
          _buildFooter(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.family_restroom,
                    color: Colors.white,
                    size: 20.sp,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'Family & Friends',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.h),
              Text(
                familyAccount.name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        Row(
          children: [
            if (isActive)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: Colors.green.withOpacity(0.6),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Colors.green[300],
                      size: 14.sp,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      'ACTIVE',
                      style: TextStyle(
                        color: Colors.green[300],
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            SizedBox(width: 8.w),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: Colors.purple.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.people,
                    color: Colors.purple[200],
                    size: 16.sp,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    '$familyAccount.activeMemberCount',
                    style: TextStyle(
                      color: Colors.purple[200],
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTotalBalance(double balance) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Total Family Balance',
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          '\$${balance.toStringAsFixed(2)}',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28.sp,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildMemberAllocation(double allocated, double remaining) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.person,
                color: Colors.white.withOpacity(0.7),
                size: 16.sp,
              ),
              SizedBox(width: 6.w),
              Text(
                'Your Share',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Text(
                '\$$allocated.toStringAsFixed(2)',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Icon(
                Icons.account_balance_wallet,
                color: Colors.white.withOpacity(0.7),
                size: 16.sp,
              ),
              SizedBox(width: 6.w),
              Text(
                'Remaining',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Text(
                '\$$remaining.toStringAsFixed(2)',
                style: TextStyle(
                  color: remaining > allocated * 0.2
                      ? Colors.green[300]
                      : Colors.orange[300],
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: onShowDetails,
          child: Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.info_outline,
              color: Colors.white,
              size: 18.sp,
            ),
          ),
        ),
        Row(
          children: [
            _buildActionButton(
              'Add Funds',
              Icons.add_rounded,
              onTap: onAddFunds,
            ),
            SizedBox(width: 12.w),
            _buildActionButton(
              'Manage',
              Icons.settings_rounded,
              onTap: onManage,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton(String label, IconData icon, {required VoidCallback? onTap}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20.r),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: Colors.white,
                size: 16.sp,
              ),
              SizedBox(width: 6.w),
              Text(
                label,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Family Account Setup Card (CTA when user doesn't have a family account)
class FamilySetupCard extends StatelessWidget {
  final VoidCallback onGetStarted;

  const FamilySetupCard({
    super.key,
    required this.onGetStarted,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onGetStarted,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.w),
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF6C5CE7).withOpacity(0.3),
              const Color(0xFFA29BFE).withOpacity(0.15),
            ],
          ),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: const Color(0xFF6C5CE7).withOpacity(0.5),
            width: 2,
            style: BorderStyle.solid,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF6C5CE7).withOpacity(0.4),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 64.w,
              height: 64.h,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.family_restroom,
                color: Colors.white,
                size: 32.sp,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'Setup Family & Friends',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Share money with loved ones',
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 13.sp,
              ),
            ),
            SizedBox(height: 16.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Get Started',
                    style: TextStyle(
                      color: const Color(0xFF6C5CE7),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Icon(
                    Icons.arrow_forward,
                    color: const Color(0xFF6C5CE7),
                    size: 18.sp,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
