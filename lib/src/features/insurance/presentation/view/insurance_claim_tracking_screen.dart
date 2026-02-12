import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../domain/entities/insurance_claim_entity.dart';
import '../cubit/insurance_cubit.dart';
import '../cubit/insurance_state.dart';

class InsuranceClaimTrackingScreen extends StatefulWidget {
  final InsuranceClaim claim;

  const InsuranceClaimTrackingScreen({
    super.key,
    required this.claim,
  });

  @override
  State<InsuranceClaimTrackingScreen> createState() =>
      _InsuranceClaimTrackingScreenState();
}

class _InsuranceClaimTrackingScreenState
    extends State<InsuranceClaimTrackingScreen> {
  late InsuranceClaim _claim;
  bool _isCancelling = false;

  @override
  void initState() {
    super.initState();
    _claim = widget.claim;
  }

  Future<void> _refreshClaim() async {
    final cubit = context.read<InsuranceCubit>();
    final updated = await cubit.getClaimById(_claim.id);
    if (updated != null && mounted) {
      setState(() => _claim = updated);
    }
  }

  Future<void> _cancelClaim() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'Cancel Claim',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Text(
          'Cancel this claim? This action cannot be undone.',
          style: GoogleFonts.inter(color: const Color(0xFF9CA3AF)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Keep Claim',
                style: GoogleFonts.inter(color: const Color(0xFF9CA3AF))),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text('Cancel Claim',
                style: GoogleFonts.inter(color: const Color(0xFFEF4444))),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) return;

    setState(() => _isCancelling = true);
    try {
      await context.read<InsuranceCubit>().updateClaim(
            _claim.copyWith(status: ClaimStatus.cancelled),
          );
      if (!mounted) return;
      Get.back();
      Get.snackbar(
        'Claim Cancelled',
        'Your claim has been cancelled',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF1F1F1F),
        colorText: Colors.white,
        margin: EdgeInsets.all(16.w),
        borderRadius: 12.r,
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to cancel claim: $e',
              style: GoogleFonts.inter(color: Colors.white)),
          backgroundColor: const Color(0xFFEF4444),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } finally {
      if (mounted) setState(() => _isCancelling = false);
    }
  }

  void _contactAboutClaim() {
    Get.snackbar(
      'Contact Provider',
      'Reach out to your insurance provider about claim ${_claim.claimNumber}',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF1F1F1F),
      colorText: Colors.white,
      margin: EdgeInsets.all(16.w),
      borderRadius: 12.r,
      mainButton: TextButton(
        onPressed: () {
          final email = 'mailto:?subject=Claim ${_claim.claimNumber}&body=Regarding claim ${_claim.claimNumber} for ${_claim.title}';
          launchUrl(Uri.parse(email), mode: LaunchMode.externalApplication);
        },
        child: Text('Email', style: GoogleFonts.inter(color: const Color(0xFF6366F1))),
      ),
    );
  }

  void _openDocument(String filename) {
    if (filename.startsWith('http://') || filename.startsWith('https://')) {
      launchUrl(Uri.parse(filename), mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Document preview not available',
              style: GoogleFonts.inter(color: Colors.white)),
          backgroundColor: const Color(0xFF1F1F1F),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _refreshClaim,
          color: const Color(0xFF6366F1),
          backgroundColor: const Color(0xFF1F1F1F),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              SizedBox(height: 20.h),
              _buildClaimSummaryCard(),
              SizedBox(height: 24.h),
              _buildTimelineStepper(),
              SizedBox(height: 24.h),
              _buildClaimDetailsSection(),
              SizedBox(height: 24.h),
              _buildDocumentsSection(),
              SizedBox(height: 24.h),
              _buildFinancialSummarySection(),
              SizedBox(height: 24.h),
              _buildActionButtons(context),
              SizedBox(height: 32.h),
            ],
          ),
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
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
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
                  'Claim Tracking',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  _claim.claimNumber,
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

  Widget _buildClaimSummaryCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6366F1).withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  _claim.title,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              _buildClaimStatusBadge(_claim.status),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            _claim.type.displayName,
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.8),
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Claim Amount',
                    style: GoogleFonts.inter(
                      color: Colors.white.withValues(alpha: 0.7),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '${_claim.currency} ${_claim.claimAmount.toStringAsFixed(2)}',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Incident Date',
                    style: GoogleFonts.inter(
                      color: Colors.white.withValues(alpha: 0.7),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    _formatDate(_claim.incidentDate),
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildClaimStatusBadge(ClaimStatus status) {
    Color color;
    switch (status) {
      case ClaimStatus.submitted:
        color = const Color(0xFF6366F1);
        break;
      case ClaimStatus.underReview:
        color = const Color(0xFFFB923C);
        break;
      case ClaimStatus.approved:
        color = const Color(0xFF10B981);
        break;
      case ClaimStatus.rejected:
        color = const Color(0xFFEF4444);
        break;
      case ClaimStatus.settled:
        color = const Color(0xFF8B5CF6);
        break;
      case ClaimStatus.cancelled:
        color = const Color(0xFF6B7280);
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        status.displayName,
        style: GoogleFonts.inter(
          fontSize: 11.sp,
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildTimelineStepper() {
    final steps = _getTimelineSteps();

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Claim Progress',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 20.h),
          ...List.generate(steps.length, (index) {
            final step = steps[index];
            final isLast = index == steps.length - 1;
            return _buildTimelineStep(
              title: step['title'] as String,
              description: step['description'] as String,
              state: step['state'] as _StepState,
              isLast: isLast,
              extraInfo: step['extraInfo'] as String?,
              extraInfoColor: step['extraInfoColor'] as Color?,
            );
          }),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getTimelineSteps() {
    final currentStepIndex = _getCurrentStepIndex();
    final isCancelled = _claim.status == ClaimStatus.cancelled;

    final steps = <Map<String, dynamic>>[
      {
        'title': 'Submitted',
        'description': 'Your claim has been received and logged',
        'state': isCancelled
            ? _StepState.done
            : (currentStepIndex > 0
                ? _StepState.done
                : (currentStepIndex == 0
                    ? _StepState.current
                    : _StepState.future)),
        'extraInfo': null,
        'extraInfoColor': null,
      },
      {
        'title': 'Under Review',
        'description': 'Our team is reviewing your claim documents',
        'state': isCancelled
            ? _StepState.future
            : (currentStepIndex > 1
                ? _StepState.done
                : (currentStepIndex == 1
                    ? _StepState.current
                    : _StepState.future)),
        'extraInfo': null,
        'extraInfoColor': null,
      },
      {
        'title': 'Assessment',
        'description': 'Claim is being assessed by our adjusters',
        'state': isCancelled
            ? _StepState.future
            : (currentStepIndex > 2
                ? _StepState.done
                : (currentStepIndex == 2
                    ? _StepState.current
                    : _StepState.future)),
        'extraInfo': null,
        'extraInfoColor': null,
      },
      {
        'title': 'Decision',
        'description': 'A decision has been made on your claim',
        'state': isCancelled
            ? _StepState.future
            : (currentStepIndex > 3
                ? _StepState.done
                : (currentStepIndex == 3
                    ? _StepState.current
                    : _StepState.future)),
        'extraInfo': _getDecisionExtraInfo(),
        'extraInfoColor': _getDecisionExtraInfoColor(),
      },
      {
        'title': 'Settlement',
        'description': 'Claim settlement and payout',
        'state': isCancelled
            ? _StepState.future
            : (currentStepIndex >= 4
                ? _StepState.done
                : _StepState.future),
        'extraInfo': _getSettlementExtraInfo(),
        'extraInfoColor': const Color(0xFF10B981),
      },
    ];

    return steps;
  }

  int _getCurrentStepIndex() {
    switch (_claim.status) {
      case ClaimStatus.submitted:
        return 0;
      case ClaimStatus.underReview:
        return 1;
      case ClaimStatus.approved:
        return 3;
      case ClaimStatus.rejected:
        return 3;
      case ClaimStatus.settled:
        return 4;
      case ClaimStatus.cancelled:
        return 0;
    }
  }

  String? _getDecisionExtraInfo() {
    if (_claim.isApproved) {
      final amount = _claim.approvedAmount != null
          ? '${_claim.currency} ${_claim.approvedAmount!.toStringAsFixed(2)}'
          : 'Amount pending';
      return 'Approved: $amount';
    } else if (_claim.isRejected) {
      return 'Rejected: ${_claim.rejectionReason ?? 'No reason provided'}';
    }
    return null;
  }

  Color? _getDecisionExtraInfoColor() {
    if (_claim.isApproved) return const Color(0xFF10B981);
    if (_claim.isRejected) return const Color(0xFFEF4444);
    return null;
  }

  String? _getSettlementExtraInfo() {
    if (_claim.isSettled) {
      final parts = <String>[];
      if (_claim.settlementDate != null) {
        parts.add('Settled on ${_formatDate(_claim.settlementDate!)}');
      }
      if (_claim.settlementDetails != null &&
          _claim.settlementDetails!.isNotEmpty) {
        parts.add(_claim.settlementDetails!);
      }
      return parts.isNotEmpty ? parts.join('\n') : null;
    }
    return null;
  }

  Widget _buildTimelineStep({
    required String title,
    required String description,
    required _StepState state,
    required bool isLast,
    String? extraInfo,
    Color? extraInfoColor,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              _buildStepCircle(state),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2.w,
                    color: state == _StepState.done
                        ? const Color(0xFF10B981)
                        : const Color(0xFF2D2D2D),
                  ),
                ),
            ],
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 24.h),
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
                  if (extraInfo != null) ...[
                    SizedBox(height: 8.h),
                    Text(
                      extraInfo,
                      style: GoogleFonts.inter(
                        color: extraInfoColor ?? const Color(0xFF9CA3AF),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepCircle(_StepState state) {
    switch (state) {
      case _StepState.done:
        return Container(
          width: 24.w,
          height: 24.w,
          decoration: BoxDecoration(
            color: const Color(0xFF10B981),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Icon(
            Icons.check,
            color: Colors.white,
            size: 14.sp,
          ),
        );
      case _StepState.current:
        return Container(
          width: 24.w,
          height: 24.w,
          decoration: BoxDecoration(
            color: const Color(0xFF6366F1),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Center(
            child: Container(
              width: 8.w,
              height: 8.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
          ),
        );
      case _StepState.future:
        return Container(
          width: 24.w,
          height: 24.w,
          decoration: BoxDecoration(
            color: const Color(0xFF2D2D2D),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Center(
            child: Container(
              width: 8.w,
              height: 8.w,
              decoration: BoxDecoration(
                color: const Color(0xFF6B7280),
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
          ),
        );
    }
  }

  Widget _buildClaimDetailsSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Claim Details',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16.h),
          _buildDetailRow('Type', _claim.type.displayName),
          SizedBox(height: 12.h),
          _buildDetailRow('Description', _claim.description),
          SizedBox(height: 12.h),
          _buildDetailRow('Incident Date', _formatDate(_claim.incidentDate)),
          SizedBox(height: 12.h),
          _buildDetailRow('Location', _claim.incidentLocation),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 110.w,
          child: Text(
            label,
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDocumentsSection() {
    final allFiles = [..._claim.attachments, ..._claim.documents];

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Documents & Attachments',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16.h),
          if (allFiles.isEmpty)
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: Column(
                  children: [
                    Icon(
                      Icons.folder_open,
                      color: const Color(0xFF6B7280),
                      size: 32.sp,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'No documents attached',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            ...allFiles.map((file) => _buildFileItem(file)),
        ],
      ),
    );
  }

  Widget _buildFileItem(String filename) {
    return GestureDetector(
      onTap: () => _openDocument(filename),
      child: Container(
        margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Row(
        children: [
          Container(
            width: 36.w,
            height: 36.w,
            decoration: BoxDecoration(
              color: const Color(0xFF6366F1).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              Icons.description,
              color: const Color(0xFF6366F1),
              size: 18.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              filename,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      ),
    );
  }

  Widget _buildFinancialSummarySection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Financial Summary',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16.h),
          _buildFinancialRow(
            'Claimed Amount',
            '${_claim.currency} ${_claim.claimAmount.toStringAsFixed(2)}',
            const Color(0xFF9CA3AF),
          ),
          SizedBox(height: 12.h),
          _buildFinancialRow(
            'Approved Amount',
            _claim.approvedAmount != null
                ? '${_claim.currency} ${_claim.approvedAmount!.toStringAsFixed(2)}'
                : 'Pending',
            _claim.approvedAmount != null
                ? const Color(0xFF10B981)
                : const Color(0xFFFB923C),
          ),
          SizedBox(height: 12.h),
          _buildFinancialRow(
            'Settlement Amount',
            _claim.isSettled && _claim.approvedAmount != null
                ? '${_claim.currency} ${_claim.approvedAmount!.toStringAsFixed(2)}'
                : 'N/A',
            _claim.isSettled
                ? const Color(0xFF10B981)
                : const Color(0xFF6B7280),
          ),
        ],
      ),
    );
  }

  Widget _buildFinancialRow(String label, String value, Color valueColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: const Color(0xFF9CA3AF),
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.inter(
            color: valueColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                ),
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF6366F1).withValues(alpha: 0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: _contactAboutClaim,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
                child: Text(
                  'Contact About Claim',
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          if (_claim.isPending) ...[
            SizedBox(height: 12.h),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: _isCancelling ? null : _cancelClaim,
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFFEF4444)),
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
                child: _isCancelling
                    ? SizedBox(
                        width: 20.sp,
                        height: 20.sp,
                        child: const CircularProgressIndicator(
                          color: Color(0xFFEF4444),
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
                        'Cancel Claim',
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFFEF4444),
                        ),
                      ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }
}

enum _StepState { done, current, future }
