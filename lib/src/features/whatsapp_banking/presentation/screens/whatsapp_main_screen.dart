import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/app_routes.dart';

class WhatsAppMainScreen extends StatefulWidget {
  const WhatsAppMainScreen({super.key});

  @override
  State<WhatsAppMainScreen> createState() => _WhatsAppMainScreenState();
}

class _WhatsAppMainScreenState extends State<WhatsAppMainScreen> {
  // TODO: Replace with actual provider state
  bool isLinked = false;
  String? linkedPhoneNumber;
  DateTime? linkedAt;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 78, 3, 208),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'WhatsApp Banking',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: isLinked ? _buildLinkedView() : _buildUnlinkedView(),
    );
  }

  Widget _buildUnlinkedView() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Hero Section
          Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 78, 3, 208),
                  Color.fromARGB(255, 120, 40, 230),
                ],
              ),
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.3),
                  blurRadius: 20,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              children: [
                Icon(
                  Icons.chat_bubble_outline,
                  size: 64.sp,
                  color: Colors.white,
                ),
                SizedBox(height: 16.h),
                Text(
                  'Bank via WhatsApp',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Access all LazerVault services directly from WhatsApp. Fast, secure, and convenient.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.white.withValues(alpha: 0.9),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),

          // Link Account CTA
          ElevatedButton(
            onPressed: () => Get.toNamed(AppRoutes.whatsappLinking),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 78, 3, 208),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              elevation: 4,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.link, size: 20.sp),
                SizedBox(width: 8.w),
                Text(
                  'Link WhatsApp Account',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 32.h),

          // Features Section
          Text(
            'What You Can Do',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 16.h),

          _buildFeatureCard(
            icon: Icons.send,
            title: 'Send Money',
            description: 'Transfer funds to anyone, anytime via simple WhatsApp messages',
          ),
          SizedBox(height: 12.h),

          _buildFeatureCard(
            icon: Icons.receipt_long,
            title: 'Pay Bills',
            description: 'Settle electricity bills, buy airtime, and more in seconds',
          ),
          SizedBox(height: 12.h),

          _buildFeatureCard(
            icon: Icons.account_balance_wallet,
            title: 'Check Balance',
            description: 'View your account balance and transaction history instantly',
          ),
          SizedBox(height: 12.h),

          _buildFeatureCard(
            icon: Icons.trending_up,
            title: 'Investments',
            description: 'Buy stocks, crypto, gift cards, and manage investments',
          ),
          SizedBox(height: 12.h),

          _buildFeatureCard(
            icon: Icons.receipt,
            title: 'Invoices',
            description: 'Create, send, and track invoices directly from WhatsApp',
          ),
          SizedBox(height: 12.h),

          _buildFeatureCard(
            icon: Icons.shield_outlined,
            title: 'Secure & Private',
            description: 'Banking-grade security with PIN, biometric, and transaction limits',
          ),
        ],
      ),
    );
  }

  Widget _buildLinkedView() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Account Status Card
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 48.w,
                      height: 48.w,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(255, 78, 3, 208),
                            Color.fromARGB(255, 120, 40, 230),
                          ],
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.check_circle,
                        color: Colors.white,
                        size: 24.sp,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Account Linked',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            linkedPhoneNumber ?? '+234 XXX XXX XXXX',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                Divider(color: Colors.grey.shade200),
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Linked on',
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.black54,
                      ),
                    ),
                    Text(
                      linkedAt != null
                          ? '${linkedAt!.day}/${linkedAt!.month}/${linkedAt!.year}'
                          : 'Today',
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),

          // Security Settings Card
          GestureDetector(
            onTap: () => Get.toNamed(AppRoutes.whatsappSecurity),
            child: Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 48.w,
                    height: 48.w,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.security,
                      color: Color.fromARGB(255, 78, 3, 208),
                      size: 24.sp,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Security Settings',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          'Manage limits and PIN settings',
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 16.sp,
                    color: Colors.black38,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20.h),

          // Quick Start Guide
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.1),
                  Color.fromARGB(255, 120, 40, 230).withValues(alpha: 0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.2),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.lightbulb_outline,
                      color: Color.fromARGB(255, 78, 3, 208),
                      size: 20.sp,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'Quick Start Guide',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255, 78, 3, 208),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                _buildGuideStep('1', 'Open WhatsApp and message your linked number'),
                SizedBox(height: 12.h),
                _buildGuideStep('2', 'Type "menu" to see all available services'),
                SizedBox(height: 12.h),
                _buildGuideStep('3', 'Send commands like "send \$50 to John"'),
                SizedBox(height: 12.h),
                _buildGuideStep('4', 'Confirm transactions with your PIN'),
              ],
            ),
          ),
          SizedBox(height: 20.h),

          // Unlink Button
          OutlinedButton(
            onPressed: _showUnlinkDialog,
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.red,
              side: BorderSide(color: Colors.red, width: 1.5),
              padding: EdgeInsets.symmetric(vertical: 14.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.link_off, size: 18.sp),
                SizedBox(width: 8.w),
                Text(
                  'Unlink WhatsApp Account',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.15),
                  Color.fromARGB(255, 120, 40, 230).withValues(alpha: 0.1),
                ],
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Color.fromARGB(255, 78, 3, 208),
              size: 20.sp,
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
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.black54,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGuideStep(String number, String text) {
    return Row(
      children: [
        Container(
          width: 24.w,
          height: 24.w,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 78, 3, 208),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              number,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13.sp,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }

  void _showUnlinkDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'Unlink WhatsApp Account?',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Text(
          'You will no longer be able to access LazerVault services via WhatsApp. You can re-link anytime.',
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.black87,
            height: 1.4,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.black54,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Implement unlink logic
              Navigator.pop(context);
              setState(() {
                isLinked = false;
                linkedPhoneNumber = null;
                linkedAt = null;
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text(
              'Unlink',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
