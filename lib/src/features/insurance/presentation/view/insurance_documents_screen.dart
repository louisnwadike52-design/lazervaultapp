import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../domain/entities/insurance_entity.dart';

class InsuranceDocumentsScreen extends StatefulWidget {
  final Insurance insurance;

  const InsuranceDocumentsScreen({
    super.key,
    required this.insurance,
  });

  @override
  State<InsuranceDocumentsScreen> createState() => _InsuranceDocumentsScreenState();
}

class _InsuranceDocumentsScreenState extends State<InsuranceDocumentsScreen> {
  bool _isSharing = false;

  String? get _termsUrl =>
      widget.insurance.coverageDetails['termsUrl']?.toString();

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Could not open document',
            style: GoogleFonts.inter(color: Colors.white),
          ),
          backgroundColor: const Color(0xFFEF4444),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
      );
    }
  }

  void _viewDocument(String? url) {
    if (url == null || url.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Document not available',
            style: GoogleFonts.inter(color: Colors.white),
          ),
          backgroundColor: const Color(0xFF1F1F1F),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
      );
      return;
    }
    _launchUrl(url);
  }

  Future<void> _shareAll() async {
    if (_isSharing) return;
    setState(() => _isSharing = true);

    try {
      final parts = <String>[
        'Insurance Policy Documents',
        '',
        'Policy: ${widget.insurance.policyNumber}',
        'Provider: ${widget.insurance.provider}',
        'Type: ${widget.insurance.type.displayName}',
        'Coverage: \$${widget.insurance.coverageAmount.toStringAsFixed(2)}',
      ];

      if (_termsUrl != null && _termsUrl!.isNotEmpty) {
        parts.add('');
        parts.add('Terms & Conditions: $_termsUrl');
      }

      await SharePlus.instance.share(ShareParams(text: parts.join('\n')));
    } finally {
      if (mounted) setState(() => _isSharing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    SizedBox(height: 20.h),
                    _buildPolicyInfoCard(),
                    SizedBox(height: 24.h),
                    _buildDocumentCard(
                      icon: Icons.verified,
                      iconColor: const Color(0xFF6366F1),
                      title: 'Policy Certificate',
                      description:
                          'Your official insurance policy certificate',
                      onView: () => _viewDocument(_termsUrl),
                    ),
                    SizedBox(height: 12.h),
                    _buildDocumentCard(
                      icon: Icons.summarize,
                      iconColor: const Color(0xFF10B981),
                      title: 'Coverage Summary',
                      description:
                          'Detailed breakdown of your coverage',
                      onView: () => _viewDocument(_termsUrl),
                    ),
                    SizedBox(height: 12.h),
                    _buildDocumentCard(
                      icon: Icons.calendar_month,
                      iconColor: const Color(0xFFFB923C),
                      title: 'Payment Schedule',
                      description:
                          'Upcoming premium payment dates',
                      onView: () => _viewDocument(null),
                    ),
                    if (_termsUrl != null && _termsUrl!.isNotEmpty) ...[
                      SizedBox(height: 12.h),
                      _buildDocumentCard(
                        icon: Icons.description,
                        iconColor: const Color(0xFF8B5CF6),
                        title: 'Terms & Conditions',
                        description:
                            'Full terms and conditions of your policy',
                        onView: () => _viewDocument(_termsUrl),
                      ),
                    ],
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
            _buildShareAllButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(20.w),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(22.r),
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 18.sp,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Policy Documents',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Manage your policy documents',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPolicyInfoCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: const Color(0xFF6366F1).withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Icon(
              Icons.shield,
              color: const Color(0xFF6366F1),
              size: 20.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.insurance.type.displayName,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  '${widget.insurance.provider} \u2022 ${widget.insurance.policyNumber}',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String description,
    required VoidCallback onView,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Row(
        children: [
          Container(
            width: 44.w,
            height: 44.w,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(22.r),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 22.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  description,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          GestureDetector(
            onTap: onView,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              child: Text(
                'View',
                style: GoogleFonts.inter(
                  color: const Color(0xFF6366F1),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShareAllButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 16.h),
      child: GestureDetector(
        onTap: _isSharing ? null : _shareAll,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 16.h),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
            ),
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF6366F1).withValues(alpha: 0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_isSharing)
                SizedBox(
                  width: 20.sp,
                  height: 20.sp,
                  child: const CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
              else
                Icon(
                  Icons.share,
                  color: Colors.white,
                  size: 20.sp,
                ),
              SizedBox(width: 8.w),
              Text(
                _isSharing ? 'Sharing...' : 'Share All Documents',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
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
