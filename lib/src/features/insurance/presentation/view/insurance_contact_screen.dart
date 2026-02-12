import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../domain/entities/insurance_entity.dart';

class InsuranceContactScreen extends StatefulWidget {
  final Insurance insurance;

  const InsuranceContactScreen({
    super.key,
    required this.insurance,
  });

  @override
  State<InsuranceContactScreen> createState() => _InsuranceContactScreenState();
}

class _InsuranceContactScreenState extends State<InsuranceContactScreen> {
  String get _providerPhone =>
      widget.insurance.coverageDetails['phone']?.toString() ?? '';
  String get _providerEmail =>
      widget.insurance.coverageDetails['email']?.toString() ?? '';
  String get _providerWebsite =>
      widget.insurance.coverageDetails['website']?.toString() ?? '';
  String get _providerHours =>
      widget.insurance.coverageDetails['hours']?.toString() ??
      'Mon-Fri, 9:00 AM - 5:00 PM';

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Could not open $url',
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

  void _callProvider() {
    if (_providerPhone.isEmpty) {
      _showUnavailable('Phone number');
      return;
    }
    _launchUrl('tel:$_providerPhone');
  }

  void _emailProvider() {
    if (_providerEmail.isEmpty) {
      _showUnavailable('Email address');
      return;
    }
    _launchUrl('mailto:$_providerEmail');
  }

  void _whatsAppProvider() {
    if (_providerPhone.isEmpty) {
      _showUnavailable('Phone number');
      return;
    }
    final cleanPhone = _providerPhone.replaceAll(RegExp(r'[^0-9+]'), '');
    _launchUrl('https://wa.me/$cleanPhone');
  }

  void _openWebsite() {
    if (_providerWebsite.isEmpty) {
      _showUnavailable('Website');
      return;
    }
    final url = _providerWebsite.startsWith('http')
        ? _providerWebsite
        : 'https://$_providerWebsite';
    _launchUrl(url);
  }

  void _showUnavailable(String detail) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '$detail not available for ${widget.insurance.provider}',
          style: GoogleFonts.inter(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF1F1F1F),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              SizedBox(height: 24.h),
              _buildPolicyInfoCard(),
              SizedBox(height: 24.h),
              _buildQuickActions(),
              SizedBox(height: 24.h),
              _buildProviderInformation(),
              SizedBox(height: 24.h),
              _buildCommonReasons(),
              SizedBox(height: 24.h),
              _buildEmergencyAssistance(),
              SizedBox(height: 32.h),
            ],
          ),
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
                  'Contact Provider',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  widget.insurance.provider,
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
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Column(
        children: [
          _buildPolicyInfoRow('Policy Number', widget.insurance.policyNumber),
          SizedBox(height: 12.h),
          _buildPolicyInfoRow('Type', widget.insurance.type.displayName),
          SizedBox(height: 12.h),
          _buildPolicyInfoRow('Provider', widget.insurance.provider),
          SizedBox(height: 12.h),
          _buildPolicyInfoRow('Status', widget.insurance.status.displayName),
        ],
      ),
    );
  }

  Widget _buildPolicyInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            color: const Color(0xFF9CA3AF),
          ),
        ),
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Actions',
            style: GoogleFonts.inter(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16.h),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12.w,
            mainAxisSpacing: 12.h,
            childAspectRatio: 1.3,
            children: [
              _buildQuickActionItem(
                icon: Icons.phone,
                label: 'Call',
                color: const Color(0xFF10B981),
                onTap: _callProvider,
              ),
              _buildQuickActionItem(
                icon: Icons.email,
                label: 'Email',
                color: const Color(0xFF6366F1),
                onTap: _emailProvider,
              ),
              _buildQuickActionItem(
                icon: Icons.chat,
                label: 'WhatsApp',
                color: const Color(0xFF10B981),
                onTap: _whatsAppProvider,
              ),
              _buildQuickActionItem(
                icon: Icons.assignment,
                label: 'File Claim',
                color: const Color(0xFFFB923C),
                onTap: () {
                  Get.toNamed(AppRoutes.createClaim, arguments: widget.insurance.id);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionItem({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: const Color(0xFF2D2D2D)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(24.r),
              ),
              child: Icon(
                icon,
                color: color,
                size: 24.sp,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProviderInformation() {
    final hasContactInfo = _providerPhone.isNotEmpty ||
        _providerEmail.isNotEmpty ||
        _providerWebsite.isNotEmpty;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Provider Information',
            style: GoogleFonts.inter(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16.h),
          if (!hasContactInfo)
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: const Color(0xFF2D2D2D)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: const Color(0xFFFB923C),
                    size: 20.sp,
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      'Contact details not available for ${widget.insurance.provider}',
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        color: const Color(0xFF9CA3AF),
                      ),
                    ),
                  ),
                ],
              ),
            )
          else ...[
            if (_providerPhone.isNotEmpty) ...[
              _buildContactDetailRow(
                icon: Icons.phone,
                label: 'Phone',
                value: _providerPhone,
                onTap: _callProvider,
              ),
              SizedBox(height: 12.h),
            ],
            if (_providerEmail.isNotEmpty) ...[
              _buildContactDetailRow(
                icon: Icons.email,
                label: 'Email',
                value: _providerEmail,
                onTap: _emailProvider,
              ),
              SizedBox(height: 12.h),
            ],
            _buildContactDetailRow(
              icon: Icons.access_time,
              label: 'Hours',
              value: _providerHours,
            ),
            SizedBox(height: 12.h),
            if (_providerWebsite.isNotEmpty)
              _buildContactDetailRow(
                icon: Icons.language,
                label: 'Website',
                value: _providerWebsite,
                onTap: _openWebsite,
              ),
          ],
        ],
      ),
    );
  }

  Widget _buildContactDetailRow({
    required IconData icon,
    required String label,
    required String value,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: const Color(0xFF2D2D2D)),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: const Color(0xFF6366F1),
              size: 20.sp,
            ),
            SizedBox(width: 12.w),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                color: const Color(0xFF9CA3AF),
              ),
            ),
            const Spacer(),
            Flexible(
              child: Text(
                value,
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: onTap != null
                      ? const Color(0xFF6366F1)
                      : Colors.white,
                ),
                textAlign: TextAlign.right,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (onTap != null) ...[
              SizedBox(width: 8.w),
              Icon(
                Icons.open_in_new,
                color: const Color(0xFF6366F1),
                size: 16.sp,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildCommonReasons() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Common Reasons to Contact',
            style: GoogleFonts.inter(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16.h),
          _buildReasonCard(
            icon: Icons.assignment,
            title: 'Claims Assistance',
            description: 'Get help filing or tracking a claim',
          ),
          SizedBox(height: 12.h),
          _buildReasonCard(
            icon: Icons.edit,
            title: 'Policy Changes',
            description: 'Update your coverage or personal details',
          ),
          SizedBox(height: 12.h),
          _buildReasonCard(
            icon: Icons.help,
            title: 'Coverage Questions',
            description: 'Understand what your policy covers',
          ),
          SizedBox(height: 12.h),
          _buildReasonCard(
            icon: Icons.payment,
            title: 'Billing & Payments',
            description: 'Payment issues or billing inquiries',
          ),
        ],
      ),
    );
  }

  Widget _buildReasonCard({
    required IconData icon,
    required String title,
    required String description,
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
              color: const Color(0xFF6366F1).withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(22.r),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF6366F1),
              size: 22.sp,
            ),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  description,
                  style: GoogleFonts.inter(
                    fontSize: 13.sp,
                    color: const Color(0xFF9CA3AF),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmergencyAssistance() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: const Color(0xFFEF4444).withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: const Color(0xFFEF4444).withValues(alpha: 0.4),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: const Color(0xFFEF4444).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(22.r),
              ),
              child: Icon(
                Icons.emergency,
                color: const Color(0xFFEF4444),
                size: 24.sp,
              ),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Emergency Assistance',
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFFEF4444),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'For emergencies, call your local emergency number. Your insurance provider\'s emergency line is available 24/7.',
                    style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      color: const Color(0xFF9CA3AF),
                      height: 1.5,
                    ),
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
