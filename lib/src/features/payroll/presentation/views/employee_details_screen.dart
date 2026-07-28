import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/theme/invoice_theme_colors.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import '../../domain/entities/employee_entity.dart';
import '../../domain/entities/pay_slip_entity.dart';
import '../../domain/repositories/payroll_repository.dart';
import '../cubit/payroll_cubit.dart';
import '../cubit/payroll_state.dart';
import 'edit_employee_screen.dart';
import 'pay_slip_details_screen.dart';

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
              backgroundColor: InvoiceThemeColors.successGreen,
            ),
          );
        } else if (state is PayrollError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.message,
                style: GoogleFonts.inter(color: Colors.white),
              ),
              backgroundColor: InvoiceThemeColors.errorRed,
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: InvoiceThemeColors.primaryBackground,
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
                        title: employee.isInternalPayout
                            ? 'Payout'
                            : 'Banking Details',
                        icon: employee.isInternalPayout
                            ? Icons.account_balance_wallet_outlined
                            : Icons.account_balance_outlined,
                        rows: employee.isInternalPayout
                            ? const [
                                _DetailRow('Method', 'Lazervault wallet'),
                              ]
                            : [
                                _DetailRow(
                                    'Account Number', employee.bankAccountNumber),
                                _DetailRow('Account Name', employee.bankAccountName),
                                _DetailRow('Bank Name', employee.bankName),
                                _DetailRow('Bank Code', employee.bankCode),
                              ],
                      ),
                      SizedBox(height: 16.h),
                      _EmployeePayHistory(employeeId: employee.id),
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
                InvoiceThemeColors.primaryPurple.withValues(alpha: 0.2),
            child: Text(
              employee.fullName.isNotEmpty
                  ? employee.fullName[0].toUpperCase()
                  : '?',
              style: GoogleFonts.inter(
                color: InvoiceThemeColors.primaryPurpleLight,
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
                color: InvoiceThemeColors.textGray400,
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
        color = InvoiceThemeColors.successGreen;
        break;
      case EmployeeStatus.inactive:
        color = InvoiceThemeColors.warningOrange;
        break;
      case EmployeeStatus.terminated:
        color = InvoiceThemeColors.errorRed;
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
        color: InvoiceThemeColors.secondaryBackground,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: InvoiceThemeColors.primaryPurpleLight, size: 18.sp),
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
              color: InvoiceThemeColors.textGray400,
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
        color: InvoiceThemeColors.primaryBackground,
        border: Border(
          top: BorderSide(color: InvoiceThemeColors.borderColor),
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
                            ? InvoiceThemeColors.borderColor
                            : InvoiceThemeColors.errorRed,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      'Remove Employee',
                      style: GoogleFonts.inter(
                        color: isLoading
                            ? InvoiceThemeColors.textGray500
                            : InvoiceThemeColors.errorRed,
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
                        : () async {
                            final result = await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => BlocProvider.value(
                                  value: context.read<PayrollCubit>(),
                                  child: EditEmployeeScreen(
                                      employee: employee),
                                ),
                              ),
                            );
                            if (result == true) {
                              // Refresh employee data after edit
                              if (context.mounted) {
                                context.read<PayrollCubit>().getEmployee(
                                    employee.id);
                              }
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: InvoiceThemeColors.primaryPurple,
                      disabledBackgroundColor:
                          InvoiceThemeColors.primaryPurple.withValues(alpha: 0.4),
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
          backgroundColor: InvoiceThemeColors.secondaryBackground,
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
              color: InvoiceThemeColors.textGray400,
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
                  color: InvoiceThemeColors.textGray400,
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
                  color: InvoiceThemeColors.errorRed,
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

/// An employee's pay history across all pay runs. Self-loads via the repository
/// (NOT the shared PayrollCubit that drives the details screen's remove/edit
/// states, so it can't clobber the surrounding screen). Each slip opens its
/// PaySlipDetailsScreen.
class _EmployeePayHistory extends StatefulWidget {
  final String employeeId;
  const _EmployeePayHistory({required this.employeeId});

  @override
  State<_EmployeePayHistory> createState() => _EmployeePayHistoryState();
}

class _EmployeePayHistoryState extends State<_EmployeePayHistory> {
  bool _loading = true;
  String? _error;
  List<PaySlipEntity> _slips = const [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final result = await serviceLocator<PayrollRepository>()
          .listPaySlips(employeeId: widget.employeeId, limit: 50);
      if (!mounted) return;
      setState(() {
        _slips = result.paySlips;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  void _openSlip(PaySlipEntity slip) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (_) => serviceLocator<PayrollCubit>(),
          child: PaySlipDetailsScreen(paySlipId: slip.id),
        ),
      ),
    );
  }

  Color _statusColor(PaymentStatus s) {
    switch (s) {
      case PaymentStatus.paid:
        return InvoiceThemeColors.successGreen;
      case PaymentStatus.failed:
        return InvoiceThemeColors.errorRed;
      case PaymentStatus.pending:
        return InvoiceThemeColors.warningOrange;
    }
  }

  String _statusLabel(PaymentStatus s) {
    switch (s) {
      case PaymentStatus.paid:
        return 'Paid';
      case PaymentStatus.failed:
        return 'Failed';
      case PaymentStatus.pending:
        return 'Pending';
    }
  }

  String _fmtDate(DateTime d) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${d.day} ${months[d.month - 1]} ${d.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: InvoiceThemeColors.secondaryBackground,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.receipt_long_outlined,
                  color: InvoiceThemeColors.primaryPurpleLight, size: 18.sp),
              SizedBox(width: 8.w),
              Text(
                'Pay History',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              if (!_loading && _error == null && _slips.isNotEmpty)
                Text(
                  '${_slips.length}',
                  style: GoogleFonts.inter(
                      color: InvoiceThemeColors.textGray400, fontSize: 13.sp),
                ),
            ],
          ),
          SizedBox(height: 14.h),
          if (_loading)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: Center(child: LazerVaultLoader.small()),
            )
          else if (_error != null)
            Text(
              'Could not load pay history',
              style: GoogleFonts.inter(
                  color: InvoiceThemeColors.textGray500, fontSize: 13.sp),
            )
          else if (_slips.isEmpty)
            Text(
              'No pay slips yet',
              style: GoogleFonts.inter(
                  color: InvoiceThemeColors.textGray500, fontSize: 13.sp),
            )
          else
            ..._slips.asMap().entries.map(
                  (e) => _row(e.value, e.key == _slips.length - 1),
                ),
        ],
      ),
    );
  }

  Widget _row(PaySlipEntity slip, bool isLast) {
    final color = _statusColor(slip.paymentStatus);
    return GestureDetector(
      onTap: () => _openSlip(slip),
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.only(bottom: isLast ? 0 : 12.h),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    slip.formattedNet,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    _fmtDate(slip.createdAt),
                    style: GoogleFonts.inter(
                        color: InvoiceThemeColors.textGray400, fontSize: 12.sp),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                _statusLabel(slip.paymentStatus),
                style: GoogleFonts.inter(
                    color: color, fontSize: 12.sp, fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(width: 6.w),
            Icon(Icons.chevron_right_rounded,
                color: InvoiceThemeColors.textGray500, size: 20.sp),
          ],
        ),
      ),
    );
  }
}
