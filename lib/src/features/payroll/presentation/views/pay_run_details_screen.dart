import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/services/account_manager.dart';
import '../../../../../core/services/injection_container.dart';
import '../cubit/payroll_cubit.dart';
import '../cubit/payroll_state.dart';
import '../../domain/entities/pay_run_entity.dart';
import '../../domain/entities/pay_slip_entity.dart';
import 'pay_slip_details_screen.dart';

class PayRunDetailsScreen extends StatefulWidget {
  final String payRunId;

  const PayRunDetailsScreen({super.key, required this.payRunId});

  @override
  State<PayRunDetailsScreen> createState() => _PayRunDetailsScreenState();
}

class _PayRunDetailsScreenState extends State<PayRunDetailsScreen> {
  final _pinController = TextEditingController();
  final _accountIdController = TextEditingController();
  late final AccountManager _accountManager;
  String _pinError = '';
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _accountManager = serviceLocator<AccountManager>();

    // Auto-fill account ID from AccountManager
    final activeAccountId = _accountManager.activeAccountId;
    if (activeAccountId != null && activeAccountId.isNotEmpty) {
      _accountIdController.text = activeAccountId;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PayrollCubit>().getPayRun(widget.payRunId);
    });
  }

  @override
  void dispose() {
    _pinController.dispose();
    _accountIdController.dispose();
    super.dispose();
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
          'Pay Run Details',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocConsumer<PayrollCubit, PayrollState>(
          listener: (context, state) {
            if (state is PayRunApproved) {
              setState(() => _isProcessing = false);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: const Color(0xFF10B981),
                ),
              );
              context.read<PayrollCubit>().getPayRun(widget.payRunId);
            } else if (state is PayRunProcessed) {
              setState(() => _isProcessing = false);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    '${state.message}\nSuccessful: ${state.successfulPayments} | Failed: ${state.failedPayments}',
                  ),
                  backgroundColor: const Color(0xFF10B981),
                  duration: const Duration(seconds: 4),
                ),
              );
              context.read<PayrollCubit>().getPayRun(widget.payRunId);
            } else if (state is PayRunCalculated) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Pay run calculated successfully'),
                  backgroundColor: Color(0xFF10B981),
                ),
              );
            } else if (state is PayrollError) {
              setState(() => _isProcessing = false);
              final msg = state.message.toLowerCase();
              final isPinError = msg.contains('pin') || msg.contains('locked');
              if (isPinError) {
                _showPinErrorDialog(state.message);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: const Color(0xFFEF4444),
                  ),
                );
              }
            }
          },
          builder: (context, state) {
            if (state is PayrollLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(Color(0xFF3B82F6)),
                ),
              );
            }

            if (state is PayRunLoaded) {
              return _buildPayRunContent(state.payRun, []);
            }

            if (state is PayRunCalculated) {
              return _buildPayRunContent(state.payRun, state.paySlips);
            }

            if (state is PaySlipsLoaded) {
              // If we end up here from listing pay slips, re-fetch pay run
              context.read<PayrollCubit>().getPayRun(widget.payRunId);
              return const Center(
                child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(Color(0xFF3B82F6)),
                ),
              );
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

  Widget _buildPayRunContent(PayRunEntity payRun, List<PaySlipEntity> paySlips) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Summary Card
                _buildSummaryCard(payRun),
                SizedBox(height: 16.h),

                // Financial Breakdown
                _buildFinancialBreakdown(payRun),
                SizedBox(height: 16.h),

                // Pay Slips Section
                if (paySlips.isNotEmpty) ...[
                  Text(
                    'Pay Slips (${paySlips.length})',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  ...paySlips.map((slip) => _buildPaySlipItem(slip)),
                ] else ...[
                  _buildViewPaySlipsButton(),
                ],
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),

        // Action Buttons
        _buildActionButtons(payRun),
      ],
    );
  }

  Widget _buildSummaryCard(PayRunEntity payRun) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1E3A8A), Color(0xFF3B82F6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Pay Period',
                style: GoogleFonts.inter(
                  color: Colors.white.withValues(alpha: 0.7),
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              _buildPayRunStatusChip(payRun.status),
            ],
          ),
          SizedBox(height: 6.h),
          Text(
            '${payRun.payPeriodStart} to ${payRun.payPeriodEnd}',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: _buildSummaryItem(
                  'Employees',
                  payRun.employeeCount.toString(),
                  Icons.people_outline,
                ),
              ),
              Expanded(
                child: _buildSummaryItem(
                  'Net Pay',
                  payRun.formattedTotalNet,
                  Icons.account_balance_wallet,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Colors.white.withValues(alpha: 0.7), size: 18.sp),
        SizedBox(width: 8.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: GoogleFonts.inter(
                color: Colors.white.withValues(alpha: 0.6),
                fontSize: 12.sp,
              ),
            ),
            Text(
              value,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 15.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPayRunStatusChip(PayRunStatus status) {
    Color badgeColor;
    switch (status) {
      case PayRunStatus.draft:
        badgeColor = const Color(0xFF9CA3AF);
        break;
      case PayRunStatus.calculating:
        badgeColor = const Color(0xFFFB923C);
        break;
      case PayRunStatus.ready:
        badgeColor = const Color(0xFF3B82F6);
        break;
      case PayRunStatus.approved:
        badgeColor = const Color(0xFFFB923C);
        break;
      case PayRunStatus.processing:
        badgeColor = const Color(0xFFFACC15);
        break;
      case PayRunStatus.completed:
        badgeColor = const Color(0xFF10B981);
        break;
      case PayRunStatus.failed:
        badgeColor = const Color(0xFFEF4444);
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        status.name[0].toUpperCase() + status.name.substring(1),
        style: GoogleFonts.inter(
          color: badgeColor,
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildFinancialBreakdown(PayRunEntity payRun) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Financial Breakdown',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 14.h),
          _buildBreakdownRow('Total Gross', payRun.formattedTotalGross,
              const Color(0xFF3B82F6)),
          _buildBreakdownRow('Total Deductions',
              '-${payRun.formattedTotalDeductions}', const Color(0xFFEF4444)),
          Divider(color: const Color(0xFF2D2D2D), height: 20.h),
          _buildBreakdownRow(
              'Total Net Pay', payRun.formattedTotalNet, const Color(0xFF10B981),
              isBold: true),
          SizedBox(height: 8.h),
          _buildBreakdownRow(
            'Employer Contributions',
            '\u20A6${payRun.totalEmployerContributions.toStringAsFixed(2)}',
            const Color(0xFFFB923C),
          ),
        ],
      ),
    );
  }

  Widget _buildBreakdownRow(String label, String value, Color valueColor,
      {bool isBold = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 14.sp,
              fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.inter(
              color: valueColor,
              fontSize: isBold ? 16.sp : 14.sp,
              fontWeight: isBold ? FontWeight.w700 : FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaySlipItem(PaySlipEntity slip) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: context.read<PayrollCubit>(),
              child: PaySlipDetailsScreen(paySlipId: slip.id),
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 8.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 18.r,
              backgroundColor:
                  const Color(0xFF3B82F6).withValues(alpha: 0.2),
              child: Text(
                slip.employeeName.isNotEmpty
                    ? slip.employeeName[0].toUpperCase()
                    : '?',
                style: GoogleFonts.inter(
                  color: const Color(0xFF3B82F6),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    slip.employeeName,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'Net: ${slip.formattedNet}',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF10B981),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            _buildPaymentStatusChip(slip.paymentStatus),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentStatusChip(PaymentStatus status) {
    Color color;
    String label;
    switch (status) {
      case PaymentStatus.pending:
        color = const Color(0xFFFB923C);
        label = 'Pending';
        break;
      case PaymentStatus.paid:
        color = const Color(0xFF10B981);
        label = 'Paid';
        break;
      case PaymentStatus.failed:
        color = const Color(0xFFEF4444);
        label = 'Failed';
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          color: color,
          fontSize: 11.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildViewPaySlipsButton() {
    return SizedBox(
      width: double.infinity,
      height: 44.h,
      child: OutlinedButton.icon(
        onPressed: () {
          context.read<PayrollCubit>().listPaySlips(payRunId: widget.payRunId);
        },
        icon: Icon(Icons.receipt_outlined,
            color: const Color(0xFF3B82F6), size: 18.sp),
        label: Text(
          'View Pay Slips',
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
    );
  }

  Widget _buildActionButtons(PayRunEntity payRun) {
    if (payRun.isCompleted) return const SizedBox.shrink();

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: const BoxDecoration(
        color: Color(0xFF0A0A0A),
        border: Border(
          top: BorderSide(color: Color(0xFF2D2D2D)),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (payRun.isDraft)
            _buildActionButton(
              'Calculate Payroll',
              Icons.calculate_outlined,
              const Color(0xFF3B82F6),
              () => context
                  .read<PayrollCubit>()
                  .calculatePayRun(widget.payRunId),
            ),
          if (payRun.canApprove)
            _buildActionButton(
              'Approve Pay Run',
              Icons.check_circle_outline,
              const Color(0xFF10B981),
              () => context
                  .read<PayrollCubit>()
                  .approvePayRun(widget.payRunId),
            ),
          if (payRun.canProcess)
            _buildActionButton(
              'Process Payments',
              Icons.send_outlined,
              const Color(0xFF3B82F6),
              () => _showProcessDialog(payRun),
            ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    String label,
    IconData icon,
    Color color,
    VoidCallback onPressed,
  ) {
    return SizedBox(
      width: double.infinity,
      height: 52.h,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, color: Colors.white, size: 20.sp),
        label: Text(
          label,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.r),
          ),
          elevation: 0,
        ),
      ),
    );
  }

  void _showProcessDialog(PayRunEntity payRun) {
    _pinController.clear();
    setState(() {
      _pinError = '';
      _isProcessing = false;
    });

    // Ensure account ID is current
    final activeAccountId = _accountManager.activeAccountId;
    if (activeAccountId != null && activeAccountId.isNotEmpty) {
      _accountIdController.text = activeAccountId;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => StatefulBuilder(
        builder: (sheetContext, setSheetState) => Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(sheetContext).viewInsets.bottom,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          ),
          child: Padding(
            padding: EdgeInsets.all(24.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFF3D3D3D),
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                Text(
                  'Process Pay Run',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 12.h),

                // Payment breakdown summary
                Container(
                  padding: EdgeInsets.all(14.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0A0A0A),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Column(
                    children: [
                      _buildProcessDialogRow(
                        'Total Gross Pay',
                        payRun.formattedTotalGross,
                        const Color(0xFF3B82F6),
                      ),
                      _buildProcessDialogRow(
                        'Total Deductions',
                        '-${payRun.formattedTotalDeductions}',
                        const Color(0xFFEF4444),
                      ),
                      Divider(color: const Color(0xFF2D2D2D), height: 16.h),
                      _buildProcessDialogRow(
                        'Total Net Pay',
                        payRun.formattedTotalNet,
                        const Color(0xFF10B981),
                        isBold: true,
                      ),
                      _buildProcessDialogRow(
                        'Employees',
                        '${payRun.employeeCount}',
                        Colors.white,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  'This will debit the total net amount from your business account.',
                  style: GoogleFonts.inter(
                    color: const Color(0xFFFB923C),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 16.h),

                // Source Account — read-only card from AccountManager
                _buildSourceAccountCard(),
                SizedBox(height: 14.h),

                // Transaction PIN input
                TextField(
                  controller: _pinController,
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  maxLength: 4,
                  style: GoogleFonts.inter(
                      color: Colors.white, fontSize: 15.sp),
                  onChanged: (value) {
                    if (_pinError.isNotEmpty) {
                      setSheetState(() => _pinError = '');
                      setState(() => _pinError = '');
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Transaction PIN',
                    labelStyle: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 14.sp,
                    ),
                    counterText: '',
                    filled: true,
                    fillColor: const Color(0xFF2D2D2D),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide(
                        color: _pinError.isNotEmpty
                            ? const Color(0xFFEF4444)
                            : const Color(0xFF3B82F6),
                        width: 1.5,
                      ),
                    ),
                    errorText: _pinError.isNotEmpty ? _pinError : null,
                    errorStyle: GoogleFonts.inter(
                      color: const Color(0xFFEF4444),
                      fontSize: 12.sp,
                    ),
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      color: const Color(0xFF9CA3AF),
                      size: 20.sp,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),

                // Process button with loading state
                SizedBox(
                  width: double.infinity,
                  height: 52.h,
                  child: ElevatedButton(
                    onPressed: _isProcessing
                        ? null
                        : () {
                            // Validate account
                            if (_accountIdController.text.trim().isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'No account selected. Please select an account from your dashboard first.'),
                                  backgroundColor: Color(0xFFEF4444),
                                ),
                              );
                              return;
                            }

                            // Validate PIN presence
                            final pin = _pinController.text.trim();
                            if (pin.isEmpty) {
                              setSheetState(
                                  () => _pinError = 'Please enter your PIN');
                              setState(
                                  () => _pinError = 'Please enter your PIN');
                              return;
                            }

                            // Validate PIN is exactly 4 digits
                            if (pin.length != 4 ||
                                !RegExp(r'^\d{4}$').hasMatch(pin)) {
                              setSheetState(() =>
                                  _pinError = 'PIN must be exactly 4 digits');
                              setState(() =>
                                  _pinError = 'PIN must be exactly 4 digits');
                              return;
                            }

                            setSheetState(() => _isProcessing = true);
                            setState(() => _isProcessing = true);
                            Navigator.of(sheetContext).pop();
                            context.read<PayrollCubit>().processPayRun(
                                  id: widget.payRunId,
                                  pin: pin,
                                  accountId:
                                      _accountIdController.text.trim(),
                                );
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isProcessing
                          ? const Color(0xFF3B82F6).withValues(alpha: 0.5)
                          : const Color(0xFF3B82F6),
                      disabledBackgroundColor:
                          const Color(0xFF3B82F6).withValues(alpha: 0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                      elevation: 0,
                    ),
                    child: _isProcessing
                        ? SizedBox(
                            width: 24.w,
                            height: 24.w,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2.5,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white),
                            ),
                          )
                        : Text(
                            'Confirm & Process',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
                SizedBox(height: 16.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSourceAccountCard() {
    final accountDetails = _accountManager.activeAccountDetails;
    final hasAccount =
        _accountIdController.text.trim().isNotEmpty && accountDetails != null;

    if (hasAccount) {
      final accountNumber = accountDetails.accountNumber;
      final maskedNumber = accountNumber.length >= 4
          ? '•••• ${accountNumber.substring(accountNumber.length - 4)}'
          : accountNumber;

      return Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: const Color(0xFF0A0A0A),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: const Color(0xFF2D2D2D),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: const Color(0xFF3B82F6).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(
                Icons.account_balance,
                color: const Color(0xFF3B82F6),
                size: 20.sp,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Source Account',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    '${accountDetails.accountType} $maskedNumber',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '${accountDetails.currency.toUpperCase()} ${accountDetails.balance.toStringAsFixed(2)}',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF10B981),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.check_circle,
              color: const Color(0xFF10B981),
              size: 20.sp,
            ),
          ],
        ),
      );
    }

    // No account selected — show warning card
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: const Color(0xFFEF4444).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: const Color(0xFFEF4444).withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.warning_amber_rounded,
            color: const Color(0xFFEF4444),
            size: 24.sp,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              'No account selected. Please go back to your dashboard and select an account first.',
              style: GoogleFonts.inter(
                color: const Color(0xFFEF4444),
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showPinErrorDialog(String errorMessage) {
    // Extract remaining attempts if present in the error message
    final attemptsMatch =
        RegExp(r'(\d+)\s*(?:attempt|tries|remaining)', caseSensitive: false)
            .firstMatch(errorMessage);
    final isLocked = errorMessage.toLowerCase().contains('locked') ||
        errorMessage.toLowerCase().contains('blocked');

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Row(
          children: [
            Icon(
              isLocked ? Icons.lock : Icons.error_outline,
              color: const Color(0xFFEF4444),
              size: 24.sp,
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                isLocked ? 'Account Locked' : 'Invalid PIN',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              errorMessage,
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 14.sp,
              ),
            ),
            if (attemptsMatch != null) ...[
              SizedBox(height: 12.h),
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color:
                      const Color(0xFFFB923C).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline,
                        color: const Color(0xFFFB923C), size: 18.sp),
                    SizedBox(width: 8.w),
                    Text(
                      '${attemptsMatch.group(1)} attempts remaining',
                      style: GoogleFonts.inter(
                        color: const Color(0xFFFB923C),
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            if (isLocked) ...[
              SizedBox(height: 12.h),
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color:
                      const Color(0xFFEF4444).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  children: [
                    Icon(Icons.lock_clock,
                        color: const Color(0xFFEF4444), size: 18.sp),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        'Your transaction PIN has been locked. Please contact support.',
                        style: GoogleFonts.inter(
                          color: const Color(0xFFEF4444),
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(
              isLocked ? 'Close' : 'Try Again',
              style: GoogleFonts.inter(
                color: const Color(0xFF3B82F6),
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProcessDialogRow(String label, String value, Color valueColor,
      {bool isBold = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 13.sp,
              fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.inter(
              color: valueColor,
              fontSize: isBold ? 15.sp : 13.sp,
              fontWeight: isBold ? FontWeight.w700 : FontWeight.w600,
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
                context.read<PayrollCubit>().getPayRun(widget.payRunId),
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
