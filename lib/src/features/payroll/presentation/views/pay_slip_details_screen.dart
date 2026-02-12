import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../cubit/payroll_cubit.dart';
import '../cubit/payroll_state.dart';
import '../../domain/entities/pay_slip_entity.dart';
import '../../services/payroll_pdf_service.dart';

class PaySlipDetailsScreen extends StatefulWidget {
  final String paySlipId;

  const PaySlipDetailsScreen({super.key, required this.paySlipId});

  @override
  State<PaySlipDetailsScreen> createState() => _PaySlipDetailsScreenState();
}

class _PaySlipDetailsScreenState extends State<PaySlipDetailsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PayrollCubit>().getPaySlip(widget.paySlipId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(
          'Pay Slip',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocBuilder<PayrollCubit, PayrollState>(
          builder: (context, state) {
            if (state is PayrollLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(Color(0xFF3B82F6)),
                ),
              );
            }

            if (state is PaySlipLoaded) {
              return _buildPaySlipContent(state.paySlip);
            }

            if (state is PayrollError) {
              return _buildError(state.message);
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildPaySlipContent(PaySlipEntity slip) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Employee Header
                _buildEmployeeHeader(slip),
                SizedBox(height: 20.h),

                // Net Pay Highlight
                _buildNetPayCard(slip),
                SizedBox(height: 20.h),

                // Earnings Section
                _buildSection(
                  title: 'Earnings',
                  icon: Icons.trending_up,
                  iconColor: const Color(0xFF10B981),
                  rows: [
                    _SectionRow('Base / Gross Pay', slip.formattedGross),
                    if (slip.overtimeHours > 0)
                      _SectionRow(
                        'Overtime (${slip.overtimeHours.toStringAsFixed(1)} hrs)',
                        '\u20A6${slip.overtimePay.toStringAsFixed(2)}',
                      ),
                    if (slip.bonuses > 0)
                      _SectionRow(
                        'Bonuses',
                        '\u20A6${slip.bonuses.toStringAsFixed(2)}',
                      ),
                    if (slip.commissions > 0)
                      _SectionRow(
                        'Commissions',
                        '\u20A6${slip.commissions.toStringAsFixed(2)}',
                      ),
                  ],
                ),
                SizedBox(height: 16.h),

                // Deductions Section
                _buildSection(
                  title: 'Deductions',
                  icon: Icons.trending_down,
                  iconColor: const Color(0xFFEF4444),
                  rows: [
                    _SectionRow(
                      'PAYE (Income Tax)',
                      '-\u20A6${slip.incomeTax.toStringAsFixed(2)}',
                    ),
                    _SectionRow(
                      'NHF (National Housing Fund)',
                      '-\u20A6${slip.nationalInsurance.toStringAsFixed(2)}',
                    ),
                    if (slip.studentLoanRepayment > 0)
                      _SectionRow(
                        'Student Loan',
                        '-\u20A6${slip.studentLoanRepayment.toStringAsFixed(2)}',
                      ),
                    _SectionRow(
                      'Pension Contribution',
                      '-\u20A6${slip.pensionContribution.toStringAsFixed(2)}',
                    ),
                    if (slip.otherDeductions > 0)
                      _SectionRow(
                        'Other Deductions',
                        '-\u20A6${slip.otherDeductions.toStringAsFixed(2)}',
                      ),
                    _SectionRow(
                      'Total Deductions',
                      '-${slip.formattedDeductions}',
                      isBold: true,
                    ),
                  ],
                ),
                SizedBox(height: 16.h),

                // Employer Contributions Section
                _buildSection(
                  title: 'Employer Contributions',
                  icon: Icons.business,
                  iconColor: const Color(0xFFFB923C),
                  rows: [
                    _SectionRow(
                      'Employer NIC / NSITF',
                      '\u20A6${slip.employerNIC.toStringAsFixed(2)}',
                    ),
                    _SectionRow(
                      'Employer Pension',
                      '\u20A6${slip.employerPension.toStringAsFixed(2)}',
                    ),
                  ],
                ),
                SizedBox(height: 16.h),

                // Additional Info
                if (slip.hoursWorked > 0)
                  _buildInfoCard(
                    'Hours Worked',
                    '${slip.hoursWorked.toStringAsFixed(1)} hours',
                    Icons.access_time,
                  ),
                SizedBox(height: 8.h),
                _buildInfoCard(
                  'Payment Reference',
                  slip.paymentReference,
                  Icons.tag,
                ),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),

        // Bottom Actions
        _buildBottomActions(slip),
      ],
    );
  }

  Widget _buildEmployeeHeader(PaySlipEntity slip) {
    Color statusColor;
    String statusLabel;
    switch (slip.paymentStatus) {
      case PaymentStatus.pending:
        statusColor = const Color(0xFFFB923C);
        statusLabel = 'Pending';
        break;
      case PaymentStatus.paid:
        statusColor = const Color(0xFF10B981);
        statusLabel = 'Paid';
        break;
      case PaymentStatus.failed:
        statusColor = const Color(0xFFEF4444);
        statusLabel = 'Failed';
        break;
    }

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 26.r,
            backgroundColor:
                const Color(0xFF3B82F6).withValues(alpha: 0.2),
            child: Text(
              slip.employeeName.isNotEmpty
                  ? slip.employeeName[0].toUpperCase()
                  : '?',
              style: GoogleFonts.inter(
                color: const Color(0xFF3B82F6),
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  slip.employeeName,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Pay Run: ${slip.payRunId.length > 8 ? slip.payRunId.substring(0, 8) : slip.payRunId}...',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF6B7280),
                    fontSize: 13.sp,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              statusLabel,
              style: GoogleFonts.inter(
                color: statusColor,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNetPayCard(PaySlipEntity slip) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF065F46), Color(0xFF10B981)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Text(
            'Net Pay',
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.8),
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            slip.formattedNet,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 32.sp,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required Color iconColor,
    required List<_SectionRow> rows,
  }) {
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
              Icon(icon, color: iconColor, size: 18.sp),
              SizedBox(width: 8.w),
              Text(
                title,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),
          ...rows.map((row) => _buildRow(row)),
        ],
      ),
    );
  }

  Widget _buildRow(_SectionRow row) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            row.label,
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 13.sp,
              fontWeight: row.isBold ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
          Text(
            row.value,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 13.sp,
              fontWeight: row.isBold ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String label, String value, IconData icon) {
    if (value.isEmpty) return const SizedBox.shrink();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF9CA3AF), size: 18.sp),
          SizedBox(width: 10.w),
          Text(
            label,
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 13.sp,
            ),
          ),
          const Spacer(),
          Flexible(
            child: Text(
              value,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActions(PaySlipEntity slip) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: const BoxDecoration(
        color: Color(0xFF0A0A0A),
        border: Border(
          top: BorderSide(color: Color(0xFF2D2D2D)),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 48.h,
              child: OutlinedButton.icon(
                onPressed: () async {
                  try {
                    final path =
                        await PayrollPdfService.downloadPaySlip(slip);
                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Saved to $path'),
                        backgroundColor: const Color(0xFF10B981),
                      ),
                    );
                  } catch (e) {
                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Download failed: $e'),
                        backgroundColor: const Color(0xFFEF4444),
                      ),
                    );
                  }
                },
                icon: Icon(
                  Icons.download_outlined,
                  color: const Color(0xFF3B82F6),
                  size: 18.sp,
                ),
                label: Text(
                  'Download',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF3B82F6),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF3B82F6)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: SizedBox(
              height: 48.h,
              child: ElevatedButton.icon(
                onPressed: () async {
                  try {
                    await PayrollPdfService.sharePaySlip(slip);
                  } catch (e) {
                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Share failed: $e'),
                        backgroundColor: const Color(0xFFEF4444),
                      ),
                    );
                  }
                },
                icon: Icon(
                  Icons.share_outlined,
                  color: Colors.white,
                  size: 18.sp,
                ),
                label: Text(
                  'Share',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B82F6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildError(String message) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error_outline, size: 48.sp, color: const Color(0xFFEF4444)),
          SizedBox(height: 16.h),
          Text(
            message,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 14.sp,
            ),
          ),
          SizedBox(height: 16.h),
          ElevatedButton(
            onPressed: () =>
                context.read<PayrollCubit>().getPaySlip(widget.paySlipId),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3B82F6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Text(
              'Retry',
              style: GoogleFonts.inter(
                color: Colors.white,
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

class _SectionRow {
  final String label;
  final String value;
  final bool isBold;

  const _SectionRow(this.label, this.value, {this.isBold = false});
}
