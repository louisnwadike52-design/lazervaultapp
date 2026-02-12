import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/employee_entity.dart';
import '../cubit/payroll_cubit.dart';
import '../cubit/payroll_state.dart';

class EmployeeDetailsScreen extends StatelessWidget {
  final EmployeeEntity employee;

  const EmployeeDetailsScreen({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    return BlocListener<PayrollCubit, PayrollState>(
      listener: (context, state) {
        if (state is EmployeeRemoved) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.message,
                style: GoogleFonts.inter(color: Colors.white),
              ),
              backgroundColor: const Color(0xFF10B981),
            ),
          );
        } else if (state is PayrollError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.message,
                style: GoogleFonts.inter(color: Colors.white),
              ),
              backgroundColor: const Color(0xFFEF4444),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0A0A),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back, color: Colors.white),
          ),
          title: Text(
            'Employee Details',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildProfileHeader(),
                      SizedBox(height: 24.h),
                      _buildSectionCard(
                        title: 'Personal Information',
                        icon: Icons.person_outline,
                        rows: [
                          _DetailRow('Email', employee.email),
                          _DetailRow('Phone', employee.phone),
                          _DetailRow('NIN', employee.nin),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      _buildSectionCard(
                        title: 'Employment',
                        icon: Icons.work_outline,
                        rows: [
                          _DetailRow('Type', employee.employmentTypeDisplay),
                          _DetailRow('Department', employee.department),
                          _DetailRow('Job Title', employee.jobTitle),
                          if (employee.startDate != null)
                            _DetailRow('Start Date', employee.startDate!),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      _buildSectionCard(
                        title: 'Compensation',
                        icon: Icons.payments_outlined,
                        rows: [
                          _DetailRow('Pay Rate', employee.formattedPayRate),
                          _DetailRow(
                              'Frequency', employee.payFrequencyDisplay),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      _buildSectionCard(
                        title: 'Banking Details',
                        icon: Icons.account_balance_outlined,
                        rows: [
                          _DetailRow(
                              'Account Number', employee.bankAccountNumber),
                          _DetailRow('Bank Name', employee.bankName),
                          _DetailRow('Bank Code', employee.bankCode),
                        ],
                      ),
                      SizedBox(height: 24.h),
                    ],
                  ),
                ),
              ),
              _buildBottomActions(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 8.h),
          CircleAvatar(
            radius: 40.r,
            backgroundColor:
                const Color(0xFF3B82F6).withValues(alpha: 0.2),
            child: Text(
              employee.fullName.isNotEmpty
                  ? employee.fullName[0].toUpperCase()
                  : '?',
              style: GoogleFonts.inter(
                color: const Color(0xFF3B82F6),
                fontSize: 32.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(height: 14.h),
          Text(
            employee.fullName,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 8.h),
          _buildStatusBadge(),
          SizedBox(height: 8.h),
          if (employee.department.isNotEmpty || employee.jobTitle.isNotEmpty)
            Text(
              '${employee.department}${employee.department.isNotEmpty && employee.jobTitle.isNotEmpty ? ' - ' : ''}${employee.jobTitle}',
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge() {
    Color color;
    switch (employee.status) {
      case EmployeeStatus.active:
        color = const Color(0xFF10B981);
        break;
      case EmployeeStatus.inactive:
        color = const Color(0xFFFB923C);
        break;
      case EmployeeStatus.terminated:
        color = const Color(0xFFEF4444);
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        employee.statusDisplay,
        style: GoogleFonts.inter(
          color: color,
          fontSize: 13.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required List<_DetailRow> rows,
  }) {
    // Filter out rows with empty values
    final visibleRows = rows.where((r) => r.value.isNotEmpty).toList();
    if (visibleRows.isEmpty) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
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
              Icon(icon, color: const Color(0xFF3B82F6), size: 18.sp),
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
          ...visibleRows.asMap().entries.map((entry) {
            final isLast = entry.key == visibleRows.length - 1;
            return _buildDetailRow(entry.value, isLast: isLast);
          }),
        ],
      ),
    );
  }

  Widget _buildDetailRow(_DetailRow row, {bool isLast = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            row.label,
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(width: 16.w),
          Flexible(
            child: Text(
              row.value,
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

  Widget _buildBottomActions(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: const BoxDecoration(
        color: Color(0xFF0A0A0A),
        border: Border(
          top: BorderSide(color: Color(0xFF2D2D2D)),
        ),
      ),
      child: BlocBuilder<PayrollCubit, PayrollState>(
        builder: (context, state) {
          final isLoading = state is PayrollLoading;
          return Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 48.h,
                  child: OutlinedButton(
                    onPressed: isLoading
                        ? null
                        : () => _showRemoveConfirmation(context),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: isLoading
                            ? const Color(0xFF2D2D2D)
                            : const Color(0xFFEF4444),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      'Remove Employee',
                      style: GoogleFonts.inter(
                        color: isLoading
                            ? const Color(0xFF6B7280)
                            : const Color(0xFFEF4444),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: SizedBox(
                  height: 48.h,
                  child: ElevatedButton(
                    onPressed: isLoading
                        ? null
                        : () => Navigator.of(context).pop(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3B82F6),
                      disabledBackgroundColor:
                          const Color(0xFF3B82F6).withValues(alpha: 0.4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Edit Employee',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showRemoveConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1F1F1F),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          title: Text(
            'Remove Employee',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          content: Text(
            'Are you sure you want to remove ${employee.fullName}? This action cannot be undone.',
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(
                'Cancel',
                style: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                context.read<PayrollCubit>().removeEmployee(employee.id);
              },
              child: Text(
                'Remove',
                style: GoogleFonts.inter(
                  color: const Color(0xFFEF4444),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _DetailRow {
  final String label;
  final String value;

  const _DetailRow(this.label, this.value);
}
