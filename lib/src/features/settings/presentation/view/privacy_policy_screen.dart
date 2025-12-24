import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF1F2937)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Privacy Policy',
          style: GoogleFonts.inter(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1F2937),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF4E03D0),
                    Color(0xFF7C3AED),
                  ],
                ),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.shield_outlined,
                    size: 48.sp,
                    color: Colors.white,
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    'Your Privacy Matters',
                    style: GoogleFonts.inter(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Last updated: December 17, 2025',
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),

            // Introduction
            _buildSection(
              'Introduction',
              'LazerVault ("we," "our," or "us") is committed to protecting your privacy. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our mobile application and services.',
            ),

            // Data Collection
            _buildSection(
              '1. Information We Collect',
              'We collect several types of information to provide and improve our services:',
            ),
            _buildSubsection(
              'Personal Information',
              '• Full name, email address, and phone number\n• Date of birth and address\n• Government-issued ID documents (for verification)\n• Financial account information\n• Transaction history',
            ),
            _buildSubsection(
              'Biometric Information',
              '• Facial recognition data (for identity verification)\n• Fingerprint data (for device authentication)\n• Passcode information (encrypted)',
            ),
            _buildSubsection(
              'Device Information',
              '• Device type, operating system, and version\n• Unique device identifiers\n• IP address and location data\n• App usage statistics',
            ),

            // How We Use Data
            _buildSection(
              '2. How We Use Your Information',
              'We use your information for the following purposes:',
            ),
            _buildBulletList([
              'To provide, maintain, and improve our services',
              'To verify your identity and prevent fraud',
              'To process your transactions',
              'To send you important notifications and updates',
              'To comply with legal and regulatory requirements',
              'To analyze usage patterns and improve user experience',
              'To provide customer support',
            ]),

            // Data Security
            _buildSection(
              '3. Data Security',
              'We implement industry-standard security measures to protect your information:',
            ),
            _buildBulletList([
              'End-to-end encryption for sensitive data',
              'Secure storage with encrypted databases',
              'Regular security audits and penetration testing',
              'Multi-factor authentication options',
              'Biometric data stored locally on your device',
              'Limited employee access to personal data',
            ]),

            // Data Sharing
            _buildSection(
              '4. Information Sharing',
              'We do not sell your personal information. We may share your data with:',
            ),
            _buildBulletList([
              'Service providers who assist in operating our platform',
              'Financial institutions for transaction processing',
              'Law enforcement when required by law',
              'Third parties with your explicit consent',
            ]),

            // User Rights
            _buildSection(
              '5. Your Rights',
              'You have the following rights regarding your personal information:',
            ),
            _buildBulletList([
              'Access: Request a copy of your personal data',
              'Correction: Update or correct inaccurate information',
              'Deletion: Request deletion of your account and data',
              'Portability: Receive your data in a machine-readable format',
              'Opt-out: Unsubscribe from marketing communications',
              'Restrict Processing: Limit how we use your data',
            ]),

            // Data Retention
            _buildSection(
              '6. Data Retention',
              'We retain your personal information for as long as necessary to:\n\n• Provide our services to you\n• Comply with legal obligations\n• Resolve disputes and enforce agreements\n\nWhen you delete your account, we will delete or anonymize your personal information within 30 days, except where retention is required by law.',
            ),

            // Cookies and Tracking
            _buildSection(
              '7. Cookies and Tracking Technologies',
              'We use cookies and similar technologies to:\n\n• Remember your preferences\n• Analyze app performance\n• Understand user behavior\n• Improve our services\n\nYou can manage cookie preferences through your device settings.',
            ),

            // Children's Privacy
            _buildSection(
              '8. Children\'s Privacy',
              'LazerVault is not intended for individuals under the age of 18. We do not knowingly collect personal information from children. If you believe we have collected information from a child, please contact us immediately.',
            ),

            // International Transfers
            _buildSection(
              '9. International Data Transfers',
              'Your information may be transferred to and processed in countries other than your country of residence. We ensure appropriate safeguards are in place to protect your data in accordance with this Privacy Policy.',
            ),

            // Changes to Policy
            _buildSection(
              '10. Changes to This Privacy Policy',
              'We may update this Privacy Policy from time to time. We will notify you of any material changes by:\n\n• Posting the new policy in the app\n• Sending you an email notification\n• Displaying an in-app notification\n\nYour continued use of our services after changes become effective constitutes acceptance of the revised policy.',
            ),

            // Contact Information
            _buildSection(
              '11. Contact Us',
              'If you have questions or concerns about this Privacy Policy, please contact us:',
            ),
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildContactRow(Icons.email_outlined, 'privacy@lazervault.com'),
                  SizedBox(height: 12.h),
                  _buildContactRow(Icons.phone_outlined, '+1 (555) 123-4567'),
                  SizedBox(height: 12.h),
                  _buildContactRow(Icons.location_on_outlined, '123 Financial District, San Francisco, CA 94105'),
                ],
              ),
            ),

            SizedBox(height: 32.h),

            // Acceptance Button
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Color(0xFF4E03D0).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: Color(0xFF4E03D0).withValues(alpha: 0.3),
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    color: Color(0xFF4E03D0),
                    size: 32.sp,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'By using LazerVault, you acknowledge that you have read and understood this Privacy Policy.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      color: Color(0xFF4E03D0),
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2937),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            content,
            style: GoogleFonts.inter(
              fontSize: 13.sp,
              color: Color(0xFF6B7280),
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubsection(String title, String content) {
    return Padding(
      padding: EdgeInsets.only(left: 16.w, bottom: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Color(0xFF374151),
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            content,
            style: GoogleFonts.inter(
              fontSize: 13.sp,
              color: Color(0xFF6B7280),
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBulletList(List<String> items) {
    return Padding(
      padding: EdgeInsets.only(left: 16.w, bottom: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items.map((item) => Padding(
          padding: EdgeInsets.only(bottom: 8.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 6.h, right: 8.w),
                width: 6.w,
                height: 6.w,
                decoration: BoxDecoration(
                  color: Color(0xFF4E03D0),
                  shape: BoxShape.circle,
                ),
              ),
              Expanded(
                child: Text(
                  item,
                  style: GoogleFonts.inter(
                    fontSize: 13.sp,
                    color: Color(0xFF6B7280),
                    height: 1.6,
                  ),
                ),
              ),
            ],
          ),
        )).toList(),
      ),
    );
  }

  Widget _buildContactRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18.sp,
          color: Color(0xFF4E03D0),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.inter(
              fontSize: 13.sp,
              color: Color(0xFF374151),
            ),
          ),
        ),
      ],
    );
  }
}
