import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../cubit/payroll_cubit.dart';
import '../cubit/payroll_state.dart';
import '../../domain/entities/pay_run_entity.dart';
import 'pay_run_details_screen.dart';
import 'create_pay_run_screen.dart';

class PayRunListScreen extends StatefulWidget {
  const PayRunListScreen({super.key});

  @override
  State<PayRunListScreen> createState() => _PayRunListScreenState();
}

class _PayRunListScreenState extends State<PayRunListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PayrollCubit>().listPayRuns();
    });
  }

  Future<void> _onRefresh() async {
    context.read<PayrollCubit>().listPayRuns();
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
          'Pay Runs',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                    builder: (_) => BlocProvider.value(
                      value: context.read<PayrollCubit>(),
                      child: const CreatePayRunScreen(),
                    ),
                  ))
                  .then((_) => _onRefresh());
            },
            icon: const Icon(Icons.add, color: Color(0xFF3B82F6)),
          ),
        ],
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

            if (state is PayRunsLoaded) {
              final payRuns = state.payRuns;
              if (payRuns.isEmpty) {
                return _buildEmpty();
              }
              return RefreshIndicator(
                onRefresh: _onRefresh,
                color: const Color(0xFF3B82F6),
                backgroundColor: const Color(0xFF1F1F1F),
                child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 8.h,
                  ),
                  itemCount: payRuns.length,
                  itemBuilder: (context, index) {
                    return _buildPayRunCard(payRuns[index]);
                  },
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

  Widget _buildPayRunCard(PayRunEntity payRun) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: context.read<PayrollCubit>(),
              child: PayRunDetailsScreen(payRunId: payRun.id),
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    '${payRun.payPeriodStart} - ${payRun.payPeriodEnd}',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                _buildStatusBadge(payRun.status),
              ],
            ),
            SizedBox(height: 12.h),
            Divider(color: const Color(0xFF2D2D2D), height: 1.h),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatItem(
                  Icons.people_outline,
                  '${payRun.employeeCount} employees',
                ),
                _buildStatItem(
                  Icons.account_balance_wallet_outlined,
                  payRun.formattedTotalNet,
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Gross: ${payRun.formattedTotalGross}',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF6B7280),
                    fontSize: 12.sp,
                  ),
                ),
                Text(
                  'Deductions: ${payRun.formattedTotalDeductions}',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF6B7280),
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF9CA3AF), size: 16.sp),
        SizedBox(width: 6.w),
        Text(
          text,
          style: GoogleFonts.inter(
            color: const Color(0xFF9CA3AF),
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusBadge(PayRunStatus status) {
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
        color: badgeColor.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        payRunStatusLabel(status),
        style: GoogleFonts.inter(
          color: badgeColor,
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  String payRunStatusLabel(PayRunStatus status) {
    switch (status) {
      case PayRunStatus.draft:
        return 'Draft';
      case PayRunStatus.calculating:
        return 'Calculating';
      case PayRunStatus.ready:
        return 'Ready';
      case PayRunStatus.approved:
        return 'Approved';
      case PayRunStatus.processing:
        return 'Processing';
      case PayRunStatus.completed:
        return 'Completed';
      case PayRunStatus.failed:
        return 'Failed';
    }
  }

  Widget _buildEmpty() {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(height: 80.h),
        Center(
          child: Column(
            children: [
              Container(
                width: 72.w,
                height: 72.w,
                decoration: BoxDecoration(
                  color: const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(36.r),
                ),
                child: Icon(
                  Icons.receipt_long_outlined,
                  size: 32.sp,
                  color: const Color(0xFF6B7280),
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'No Pay Runs',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Create your first pay run to process payroll',
                style: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
        ),
      ],
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
            onPressed: _onRefresh,
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
