import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:lazervault/src/features/support/domain/repositories/i_support_repository.dart';
import 'package:lazervault/src/features/support/domain/entities/support_ticket.dart';
import 'package:lazervault/core/services/injection_container.dart';

class HelpSupportScreen extends StatefulWidget {
  const HelpSupportScreen({super.key});

  @override
  State<HelpSupportScreen> createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends State<HelpSupportScreen> {
  String? expandedFaqId;
  late final ISupportRepository _supportRepository;

  @override
  void initState() {
    super.initState();
    _supportRepository = serviceLocator<ISupportRepository>();
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not launch $url', style: GoogleFonts.inter()),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _launchPhone(String phone) async {
    await _launchURL('tel:$phone');
  }

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
          'Help & Support',
          style: GoogleFonts.inter(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1F2937),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF4E03D0),
                    Color(0xFF7C3AED),
                  ],
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.help_outline,
                    size: 56.sp,
                    color: Colors.white,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'How can we help you?',
                    style: GoogleFonts.inter(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Find answers or get in touch with our support team',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 24.h),

            // Quick Actions
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Quick Actions',
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      Expanded(
                        child: _buildQuickActionCard(
                          icon: Icons.chat_bubble_outline,
                          title: 'Live Chat',
                          subtitle: 'Chat with us',
                          color: Color(0xFF3784F9),
                          onTap: () => _showLiveChatDialog(),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: _buildQuickActionCard(
                          icon: Icons.phone_outlined,
                          title: 'Call Us',
                          subtitle: 'Talk to support',
                          color: Color(0xFF10B981),
                          onTap: () => _showCallDialog(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      Expanded(
                        child: _buildQuickActionCard(
                          icon: Icons.email_outlined,
                          title: 'Email',
                          subtitle: 'Send a message',
                          color: Color(0xFFFF7465),
                          onTap: () => _showEmailDialog(),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: _buildQuickActionCard(
                          icon: Icons.description_outlined,
                          title: 'Submit Ticket',
                          subtitle: 'Report an issue',
                          color: Color(0xFF9937FC),
                          onTap: () => _showTicketDialog(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 32.h),

            // FAQ Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Frequently Asked Questions',
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  _buildFaqItem(
                    id: '1',
                    question: 'How do I verify my identity?',
                    answer: 'To verify your identity, navigate to Profile → Identity Verification. You\'ll need to:\n\n1. Upload a government-issued ID (passport, driver\'s license, or national ID)\n2. Complete facial recognition registration\n3. Set up a passcode for added security\n\nThe verification process typically takes 1-2 business days.',
                  ),
                  _buildFaqItem(
                    id: '2',
                    question: 'How do I send money to another user?',
                    answer: 'Sending money is simple:\n\n1. Tap the Send button on the home screen\n2. Enter the recipient\'s \$TagPay or select from your contacts\n3. Enter the amount you want to send\n4. Add an optional note\n5. Review and confirm the transaction\n\nFunds are typically transferred instantly.',
                  ),
                  _buildFaqItem(
                    id: '3',
                    question: 'What payment methods can I add?',
                    answer: 'LazerVault supports multiple payment methods:\n\n• Bank accounts (via ACH)\n• Debit cards\n• Credit cards\n• Digital wallets\n\nTo add a payment method, go to Profile → Payment Methods → Add New.',
                  ),
                  _buildFaqItem(
                    id: '4',
                    question: 'How secure is my financial data?',
                    answer: 'Your security is our top priority. We use:\n\n• Bank-level 256-bit encryption\n• Biometric authentication (Face ID/Touch ID)\n• Two-factor authentication (2FA)\n• PCI DSS compliance\n• Real-time fraud monitoring\n\nYour sensitive data is encrypted both in transit and at rest.',
                  ),
                  _buildFaqItem(
                    id: '5',
                    question: 'How do I enable biometric login?',
                    answer: 'To enable biometric authentication:\n\n1. Go to Profile → Security & Privacy\n2. Tap on Biometric Settings\n3. Toggle on Face ID or Fingerprint\n4. Follow the on-screen prompts\n\nYou can disable this feature at any time from the same menu.',
                  ),
                  _buildFaqItem(
                    id: '6',
                    question: 'What are the transaction limits?',
                    answer: 'Transaction limits vary by account verification level:\n\n• Unverified: \$500/week\n• Basic Verified: \$2,500/week\n• Fully Verified: \$10,000/week\n\nComplete identity verification to increase your limits.',
                  ),
                  _buildFaqItem(
                    id: '7',
                    question: 'How do I report a problem with a transaction?',
                    answer: 'If you encounter an issue with a transaction:\n\n1. Go to Activity → Select the transaction\n2. Tap "Report Issue"\n3. Choose the issue type\n4. Provide details and submit\n\nOur support team will investigate and respond within 24 hours.',
                  ),
                  _buildFaqItem(
                    id: '8',
                    question: 'Can I cancel a transaction?',
                    answer: 'Transaction cancellation depends on the status:\n\n• Pending: Can be canceled from Activity tab\n• Processing: Contact support immediately\n• Completed: Cannot be canceled, request a refund instead\n\nInstant transfers cannot be canceled once confirmed.',
                  ),
                ],
              ),
            ),

            SizedBox(height: 32.h),

            // Additional Resources
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Additional Resources',
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  _buildResourceCard(
                    icon: Icons.menu_book_outlined,
                    title: 'User Guide',
                    subtitle: 'Complete guide to using LazerVault',
                    onTap: () {},
                  ),
                  SizedBox(height: 12.h),
                  _buildResourceCard(
                    icon: Icons.video_library_outlined,
                    title: 'Video Tutorials',
                    subtitle: 'Watch step-by-step guides',
                    onTap: () {},
                  ),
                  SizedBox(height: 12.h),
                  _buildResourceCard(
                    icon: Icons.groups_outlined,
                    title: 'Community Forum',
                    subtitle: 'Connect with other users',
                    onTap: () {},
                  ),
                ],
              ),
            ),

            SizedBox(height: 32.h),

            // Contact Information
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Still need help?',
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  _buildContactInfo(Icons.email_outlined, 'support@lazervault.com'),
                  SizedBox(height: 8.h),
                  _buildContactInfo(Icons.phone_outlined, '+1 (555) 123-4567'),
                  SizedBox(height: 8.h),
                  _buildContactInfo(Icons.access_time, 'Mon-Fri: 9AM-6PM EST'),
                ],
              ),
            ),

            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: color.withValues(alpha: 0.3),
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 32.sp,
              color: color,
            ),
            SizedBox(height: 8.h),
            Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1F2937),
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 11.sp,
                color: Color(0xFF6B7280),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFaqItem({
    required String id,
    required String question,
    required String answer,
  }) {
    final isExpanded = expandedFaqId == id;

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFE5E7EB)),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            expandedFaqId = isExpanded ? null : id;
          });
        },
        borderRadius: BorderRadius.circular(12.r),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      question,
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                  ),
                  Icon(
                    isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: Color(0xFF4E03D0),
                  ),
                ],
              ),
              if (isExpanded) ...[
                SizedBox(height: 12.h),
                Text(
                  answer,
                  style: GoogleFonts.inter(
                    fontSize: 13.sp,
                    color: Color(0xFF6B7280),
                    height: 1.6,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResourceCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xFFE5E7EB)),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Color(0xFF4E03D0).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(
                icon,
                color: Color(0xFF4E03D0),
                size: 24.sp,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    subtitle,
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: Color(0xFF9CA3AF),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactInfo(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16.sp,
          color: Color(0xFF4E03D0),
        ),
        SizedBox(width: 8.w),
        Text(
          text,
          style: GoogleFonts.inter(
            fontSize: 12.sp,
            color: Color(0xFF6B7280),
          ),
        ),
      ],
    );
  }

  void _showLiveChatDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Row(
          children: [
            Icon(Icons.chat_bubble_outline, color: Color(0xFF3784F9)),
            SizedBox(width: 12.w),
            Text(
              'Live Chat',
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: Text(
          'Our live chat feature is coming soon! In the meantime, you can reach us via email or phone.',
          style: GoogleFonts.inter(
            fontSize: 13.sp,
            color: Color(0xFF6B7280),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'OK',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Color(0xFF4E03D0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showCallDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Row(
          children: [
            Icon(Icons.phone_outlined, color: Color(0xFF10B981)),
            SizedBox(width: 12.w),
            Text(
              'Call Support',
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Contact our support team:',
              style: GoogleFonts.inter(
                fontSize: 13.sp,
                color: Color(0xFF6B7280),
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              '+1 (555) 123-4567',
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Available Mon-Fri: 9AM-6PM EST',
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                color: Color(0xFF6B7280),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Close',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Color(0xFF6B7280),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _launchPhone('+15551234567');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF10B981),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text(
              'Call Now',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showEmailDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Row(
          children: [
            Icon(Icons.email_outlined, color: Color(0xFFFF7465)),
            SizedBox(width: 12.w),
            Text(
              'Email Support',
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Send us an email at:',
              style: GoogleFonts.inter(
                fontSize: 13.sp,
                color: Color(0xFF6B7280),
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              'support@lazervault.com',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              'We typically respond within 24 hours.',
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                color: Color(0xFF6B7280),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'OK',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Color(0xFF4E03D0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showTicketDialog() {
    final subjectController = TextEditingController();
    final descriptionController = TextEditingController();
    String selectedCategory = 'General Inquiry';
    bool isSubmitting = false;

    TicketCategory mapCategoryString(String category) {
      switch (category) {
        case 'Transaction Issue':
          return TicketCategory.transactionIssue;
        case 'Account Problem':
          return TicketCategory.accountProblem;
        case 'Technical Support':
          return TicketCategory.technicalSupport;
        case 'Security Concern':
          return TicketCategory.securityConcern;
        case 'Other':
          return TicketCategory.other;
        default:
          return TicketCategory.generalInquiry;
      }
    }

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          title: Row(
            children: [
              Icon(Icons.description_outlined, color: Color(0xFF9937FC)),
              SizedBox(width: 12.w),
              Text(
                'Submit Ticket',
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Category',
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF374151),
                  ),
                ),
                SizedBox(height: 8.h),
                DropdownButtonFormField<String>(
                  initialValue: selectedCategory,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 12.h,
                    ),
                  ),
                  items: [
                    'General Inquiry',
                    'Transaction Issue',
                    'Account Problem',
                    'Technical Support',
                    'Security Concern',
                    'Other',
                  ].map((category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(
                        category,
                        style: GoogleFonts.inter(fontSize: 13.sp),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setDialogState(() {
                      selectedCategory = value!;
                    });
                  },
                ),
                SizedBox(height: 16.h),
                Text(
                  'Subject',
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF374151),
                  ),
                ),
                SizedBox(height: 8.h),
                TextField(
                  controller: subjectController,
                  decoration: InputDecoration(
                    hintText: 'Brief description of the issue',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 12.h,
                    ),
                  ),
                  style: GoogleFonts.inter(fontSize: 13.sp),
                ),
                SizedBox(height: 16.h),
                Text(
                  'Description',
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF374151),
                  ),
                ),
                SizedBox(height: 8.h),
                TextField(
                  controller: descriptionController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: 'Please provide details about your issue...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 12.h,
                    ),
                  ),
                  style: GoogleFonts.inter(fontSize: 13.sp),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: isSubmitting ? null : () {
                subjectController.dispose();
                descriptionController.dispose();
                Navigator.pop(context);
              },
              child: Text(
                'Cancel',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF6B7280),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: isSubmitting ? null : () async {
                if (subjectController.text.isEmpty || descriptionController.text.isEmpty) {
                  ScaffoldMessenger.of(this.context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Please fill in all fields',
                        style: GoogleFonts.inter(),
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                setDialogState(() {
                  isSubmitting = true;
                });

                final result = await _supportRepository.createSupportTicket(
                  category: mapCategoryString(selectedCategory),
                  subject: subjectController.text,
                  description: descriptionController.text,
                );

                setDialogState(() {
                  isSubmitting = false;
                });

                subjectController.dispose();
                descriptionController.dispose();
                if (context.mounted) {
                  Navigator.pop(context);

                  result.fold(
                    (failure) {
                      ScaffoldMessenger.of(this.context).showSnackBar(
                        SnackBar(
                          content: Text(
                            failure.message,
                            style: GoogleFonts.inter(),
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                    },
                    (SupportTicket ticket) {
                      ScaffoldMessenger.of(this.context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Ticket #${ticket.ticketNumber} submitted successfully! We\'ll get back to you soon.',
                            style: GoogleFonts.inter(),
                          ),
                          backgroundColor: Color(0xFF10B981),
                        ),
                      );
                    },
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF9937FC),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: isSubmitting
                  ? SizedBox(
                      height: 16.h,
                      width: 16.w,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Text(
                      'Submit',
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
