import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

/// Help & Support Tab - Get help and view card info
class HelpTab extends StatelessWidget {
  const HelpTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Support options
          Text(
            'Support',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16.h),

          _buildHelpOption(
            context,
            icon: Icons.support_agent_outlined,
            title: 'Get Help with this Card',
            subtitle: 'Chat with our support team',
            trailing: 'Chat →',
            onTap: () => _onGetHelp(context),
          ),
          SizedBox(height: 12.h),

          _buildHelpOption(
            context,
            icon: Icons.bug_report_outlined,
            title: 'Report a Problem',
            subtitle: 'Report an issue with your card',
            trailing: 'Report →',
            onTap: () => _onReportProblem(context),
          ),
          SizedBox(height: 24.h),

          // Card info
          Text(
            'Card Information',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16.h),

          _buildHelpOption(
            context,
            icon: Icons.local_atm_outlined,
            title: 'ATM Withdrawal Fees',
            subtitle: 'View fees for ATM withdrawals',
            trailing: 'View →',
            onTap: () => _onViewFees(context),
          ),
          SizedBox(height: 12.h),

          _buildHelpOption(
            context,
            icon: Icons.currency_exchange_outlined,
            title: 'International Fees',
            subtitle: 'Foreign transaction fees',
            trailing: 'View →',
            onTap: () => _onViewInternationalFees(context),
          ),
          SizedBox(height: 24.h),

          // FAQ Section
          Text(
            'Frequently Asked Questions',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16.h),

          _buildFAQItem(
            'How do I freeze my card?',
            'Go to the "Manage Card" tab and tap "Freeze Card". Your card will be temporarily blocked until you unfreeze it.',
          ),
          SizedBox(height: 12.h),

          _buildFAQItem(
            'What if my card is lost or stolen?',
            'Use the "Report Lost/Stolen" option in the Manage Card tab. Your card will be blocked and a replacement will be shipped to you.',
          ),
          SizedBox(height: 12.h),

          _buildFAQItem(
            'How do I change my PIN?',
            'For security reasons, PIN changes must be done through our verified banking channels. Contact support for assistance.',
          ),
          SizedBox(height: 32.h),

          // Contact info
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.phone_outlined,
                      color: const Color(0xFF3B82F6),
                      size: 20.sp,
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      '24/7 Support',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Text(
                  'Call: +234 XXX XXX XXXX',
                  style: TextStyle(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 13.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Email: support@lazervault.com',
                  style: TextStyle(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 13.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHelpOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required String trailing,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: const Color(0xFF3B82F6).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  icon,
                  color: const Color(0xFF3B82F6),
                  size: 20.sp,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                trailing,
                style: TextStyle(
                  color: const Color(0xFF3B82F6),
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFAQItem(String question, String answer) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 20.w,
                height: 20.w,
                decoration: BoxDecoration(
                  color: const Color(0xFF3B82F6).withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    'Q',
                    style: TextStyle(
                      color: const Color(0xFF3B82F6),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  question,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Padding(
            padding: EdgeInsets.only(left: 32.w),
            child: Text(
              answer,
              style: TextStyle(
                color: const Color(0xFF9CA3AF),
                fontSize: 12.sp,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onGetHelp(BuildContext context) {
    Get.snackbar(
      'Support',
      'Connecting you to our support team...',
      backgroundColor: const Color(0xFF3B82F6).withValues(alpha: 0.1),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void _onReportProblem(BuildContext context) {
    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF1A1A1A),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'Report a Problem',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Describe your issue...',
                  hintStyle: TextStyle(
                    color: const Color(0xFF4A4A4A),
                  ),
                ),
                maxLines: 4,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: const Color(0xFF9CA3AF),
                fontSize: 14.sp,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              Get.snackbar(
                'Report Submitted',
                'We\'ll get back to you within 24 hours',
                backgroundColor: const Color(0xFF10B981).withValues(alpha: 0.1),
                colorText: Colors.white,
              );
            },
            child: Text(
              'Submit',
              style: TextStyle(
                color: const Color(0xFF3B82F6),
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onViewFees(BuildContext context) {
    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF1A1A1A),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'ATM Withdrawal Fees',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildFeeRow('LazerVault ATMs', 'Free'),
            SizedBox(height: 8.h),
            _buildFeeRow('Other bank ATMs', '₦50 per withdrawal'),
            SizedBox(height: 8.h),
            _buildFeeRow('International ATMs', '₦200 + 2% of amount'),
            SizedBox(height: 16.h),
            Text(
              'Fees are subject to change. Check the app before each withdrawal for the most current fees.',
              style: TextStyle(
                color: const Color(0xFF9CA3AF),
                fontSize: 11.sp,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Close',
              style: TextStyle(
                color: const Color(0xFF3B82F6),
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onViewInternationalFees(BuildContext context) {
    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF1A1A1A),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'International Transaction Fees',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildFeeRow('USD transactions', r'0.5% (min $5)'),
            SizedBox(height: 8.h),
            _buildFeeRow('GBP transactions', '0.5% (min £3)'),
            SizedBox(height: 8.h),
            _buildFeeRow('EUR transactions', '0.5% (min €3)'),
            SizedBox(height: 8.h),
            _buildFeeRow('Other currencies', r'1% (min $10)'),
            SizedBox(height: 16.h),
            Text(
              'Exchange rates apply. Final amount may vary based on your bank\'s exchange rate.',
              style: TextStyle(
                color: const Color(0xFF9CA3AF),
                fontSize: 11.sp,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Close',
              style: TextStyle(
                color: const Color(0xFF3B82F6),
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeeRow(String label, String fee) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.sp,
          ),
        ),
        Text(
          fee,
          style: TextStyle(
            color: const Color(0xFF9CA3AF),
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
