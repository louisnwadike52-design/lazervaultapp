import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HowItWorksCard extends StatelessWidget {
  final String currency;
  final int referrerReward;
  final int refereeReward;

  const HowItWorksCard({
    super.key,
    this.currency = 'GBP',
    this.referrerReward = 10000, // £100 in minor units
    this.refereeReward = 5000,   // £50 in minor units
  });

  String _getCurrencySymbol() {
    switch (currency.toUpperCase()) {
      case 'GBP':
        return '£';
      case 'USD':
        return '\$';
      case 'EUR':
        return '€';
      case 'NGN':
        return '₦';
      case 'CAD':
        return 'C\$';
      default:
        return '\$';
    }
  }

  String _formatAmount(int amount) {
    return '${_getCurrencySymbol()}${(amount / 100).toStringAsFixed(0)}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'How It Works',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF4E03D0),
            ),
          ),
          SizedBox(height: 12.h),
          _buildStep(
            '1',
            'Share your code',
            'Send your unique referral code to friends',
            Icons.share_rounded,
          ),
          SizedBox(height: 10.h),
          _buildStep(
            '2',
            'They sign up',
            'Your friend creates an account with your code',
            Icons.person_add_rounded,
          ),
          SizedBox(height: 10.h),
          _buildStep(
            '3',
            'Both get rewarded',
            'You get ${_formatAmount(referrerReward)}, they get ${_formatAmount(refereeReward)} instantly!',
            Icons.celebration_rounded,
          ),
        ],
      ),
    );
  }

  Widget _buildStep(String number, String title, String description, IconData icon) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32.w,
          height: 32.w,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF4E03D0), Color(0xFF6B21E0)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Icon(
              icon,
              size: 16.sp,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                description,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[600],
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
