import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1F2937)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Terms & Conditions',
          style: GoogleFonts.inter(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1F2937),
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
                gradient: const LinearGradient(
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
                    Icons.description_outlined,
                    size: 48.sp,
                    color: Colors.white,
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    'Terms of Service',
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
              'Welcome to LazerVault. By using our mobile application and services, you agree to these Terms and Conditions. Please read them carefully before using our platform.',
            ),

            // Acceptance
            _buildSection(
              '1. Acceptance of Terms',
              'By accessing or using LazerVault, you agree to be bound by these Terms and Conditions and all applicable laws and regulations. If you do not agree with any part of these terms, you may not use our services.',
            ),

            // Account Creation
            _buildSection(
              '2. Account Registration',
              'To use LazerVault, you must:',
            ),
            _buildBulletList([
              'Be at least 18 years of age',
              'Provide accurate and complete information',
              'Maintain the security of your account credentials',
              'Notify us immediately of any unauthorized access',
              'Complete identity verification when required',
              'Accept sole responsibility for all activities under your account',
            ]),

            // Services
            _buildSection(
              '3. Our Services',
              'LazerVault provides the following services:',
            ),
            _buildBulletList([
              'Digital wallet for storing and managing funds',
              'Peer-to-peer money transfers',
              'Payment processing services',
              'Account management tools',
              'Transaction history and statements',
              'Security features including biometric authentication',
            ]),

            // User Responsibilities
            _buildSection(
              '4. User Responsibilities',
              'As a user of LazerVault, you agree to:',
            ),
            _buildBulletList([
              'Use the service only for lawful purposes',
              'Not engage in fraudulent activities',
              'Not attempt to circumvent security measures',
              'Provide truthful information during transactions',
              'Comply with all applicable local, state, and federal laws',
              'Maintain sufficient funds for transactions',
              'Report suspicious activities immediately',
            ]),

            // Prohibited Activities
            _buildSection(
              '5. Prohibited Activities',
              'You may not use LazerVault to:',
            ),
            _buildBulletList([
              'Engage in money laundering or terrorist financing',
              'Purchase illegal goods or services',
              'Violate intellectual property rights',
              'Transmit viruses or malicious code',
              'Impersonate another person or entity',
              'Interfere with the proper functioning of the platform',
              'Harvest user data without authorization',
              'Create multiple accounts to abuse promotions',
            ]),

            // Fees and Charges
            _buildSection(
              '6. Fees and Charges',
              'LazerVault may charge fees for certain services:',
            ),
            _buildBulletList([
              'Transaction fees may apply to specific transfers',
              'Currency conversion fees for international transactions',
              'Premium account features may have subscription fees',
              'ATM withdrawal fees as applicable',
              'Overdraft or insufficient funds fees',
              'All fees will be clearly disclosed before transaction completion',
            ]),

            // Transaction Limits
            _buildSection(
              '7. Transaction Limits',
              'We implement transaction limits based on:\n\n• Your verification level\n• Account age and history\n• Risk assessment\n• Regulatory requirements\n\nLimits may be increased by completing identity verification and maintaining good account standing.',
            ),

            // Refunds and Disputes
            _buildSection(
              '8. Refunds and Disputes',
              'Refund Policy:',
            ),
            _buildBulletList([
              'Completed transactions are generally final',
              'Disputed transactions will be reviewed within 5-10 business days',
              'Unauthorized transactions must be reported within 60 days',
              'Refunds are issued to the original payment method',
              'Service fees are non-refundable unless required by law',
            ]),

            // Account Suspension
            _buildSection(
              '9. Account Suspension and Termination',
              'We reserve the right to suspend or terminate your account if:',
            ),
            _buildBulletList([
              'You violate these Terms and Conditions',
              'Fraudulent activity is detected',
              'You provide false information',
              'Required by law or regulatory authorities',
              'You engage in prohibited activities',
              'Your account remains inactive for extended periods',
            ]),

            // Data and Privacy
            _buildSection(
              '10. Data and Privacy',
              'Your use of LazerVault is subject to our Privacy Policy. We collect, use, and protect your data as described in our Privacy Policy. By using our services, you consent to data processing as outlined.',
            ),

            // Intellectual Property
            _buildSection(
              '11. Intellectual Property',
              'All content, features, and functionality of LazerVault are owned by us and protected by:\n\n• Copyright laws\n• Trademark laws\n• Patent laws\n• Trade secret laws\n\nYou may not copy, modify, distribute, or reverse engineer any part of our platform without explicit written permission.',
            ),

            // Limitation of Liability
            _buildSection(
              '12. Limitation of Liability',
              'LazerVault shall not be liable for:',
            ),
            _buildBulletList([
              'Indirect, incidental, or consequential damages',
              'Loss of profits or business opportunities',
              'Service interruptions or technical failures',
              'Unauthorized access to your account due to your negligence',
              'Actions of third-party service providers',
              'Losses due to circumstances beyond our control',
            ]),

            // Warranties
            _buildSection(
              '13. Warranties Disclaimer',
              'LazerVault is provided "as is" without warranties of any kind. We do not guarantee:\n\n• Uninterrupted or error-free service\n• Specific results or outcomes\n• Compatibility with all devices\n• Third-party service availability',
            ),

            // Indemnification
            _buildSection(
              '14. Indemnification',
              'You agree to indemnify and hold LazerVault harmless from any claims, losses, liabilities, and expenses (including legal fees) arising from:\n\n• Your use of the service\n• Violation of these Terms\n• Violation of any rights of others\n• Any content you submit',
            ),

            // Governing Law
            _buildSection(
              '15. Governing Law',
              'These Terms shall be governed by and construed in accordance with the laws of the State of California, United States, without regard to its conflict of law provisions.',
            ),

            // Dispute Resolution
            _buildSection(
              '16. Dispute Resolution',
              'Any disputes arising from these Terms or use of LazerVault shall be resolved through:\n\n1. Good faith negotiation\n2. Mediation (if negotiation fails)\n3. Binding arbitration in San Francisco, California\n4. Class action waiver applies',
            ),

            // Changes to Terms
            _buildSection(
              '17. Changes to Terms',
              'We reserve the right to modify these Terms at any time. Changes will be effective upon posting in the app. We will notify you of material changes via:\n\n• Email notification\n• In-app notification\n• Push notification\n\nContinued use after changes constitutes acceptance.',
            ),

            // Contact Information
            _buildSection(
              '18. Contact Information',
              'For questions about these Terms and Conditions:',
            ),
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildContactRow(Icons.email_outlined, 'legal@lazervault.com'),
                  SizedBox(height: 12.h),
                  _buildContactRow(Icons.phone_outlined, '+1 (555) 123-4567'),
                  SizedBox(height: 12.h),
                  _buildContactRow(Icons.location_on_outlined, '123 Financial District, San Francisco, CA 94105'),
                ],
              ),
            ),

            SizedBox(height: 32.h),

            // Acknowledgment
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: const Color(0xFF4E03D0).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: const Color(0xFF4E03D0).withValues(alpha: 0.3),
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.verified_outlined,
                    color: const Color(0xFF4E03D0),
                    size: 32.sp,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'By using LazerVault, you acknowledge that you have read, understood, and agree to be bound by these Terms and Conditions.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      color: const Color(0xFF4E03D0),
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
              color: const Color(0xFF1F2937),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            content,
            style: GoogleFonts.inter(
              fontSize: 13.sp,
              color: const Color(0xFF6B7280),
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
                decoration: const BoxDecoration(
                  color: Color(0xFF4E03D0),
                  shape: BoxShape.circle,
                ),
              ),
              Expanded(
                child: Text(
                  item,
                  style: GoogleFonts.inter(
                    fontSize: 13.sp,
                    color: const Color(0xFF6B7280),
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
          color: const Color(0xFF4E03D0),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.inter(
              fontSize: 13.sp,
              color: const Color(0xFF374151),
            ),
          ),
        ),
      ],
    );
  }
}
