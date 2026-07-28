import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../cubit/payroll_cubit.dart';
import '../../domain/entities/pay_run_entity.dart';
import '../../domain/repositories/payroll_repository.dart';
import 'pay_run_details_screen.dart';
import 'create_pay_run_screen.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/core/theme/invoice_theme_colors.dart';
import 'package:lazervault/core/widgets/infinite_scroll_mixin.dart';

class PayRunListScreen extends StatefulWidget {
  const PayRunListScreen({super.key});

  @override
  State<PayRunListScreen> createState() => _PayRunListScreenState();
}

class _PayRunListScreenState extends State<PayRunListScreen>
    with InfiniteScrollMixin<PayRunListScreen> {
  static const int _limit = 20;

  List<PayRunEntity> _items = [];
  bool _loading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    attachInfiniteScroll();
    _loadFirst();
  }

  @override
  void dispose() {
    detachInfiniteScroll();
    super.dispose();
  }

  Future<void> _loadFirst() async {
    resetPagination();
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final res = await serviceLocator<PayrollRepository>().listPayRuns(
        page: 1,
        limit: _limit,
      );
      if (!mounted) return;
      setState(() {
        _items = res.payRuns;
        _loading = false;
        hasMore = res.currentPage < res.totalPages;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _error = e.toString().replaceFirst('Exception: ', '');
      });
    }
  }

  @override
  Future<void> onLoadMore() => runLoadMore(() async {
        final res = await serviceLocator<PayrollRepository>().listPayRuns(
          page: page + 1,
          limit: _limit,
        );
        if (!mounted) return;
        setState(() {
          _items.addAll(res.payRuns);
          page += 1;
          hasMore = page < res.totalPages;
        });
      });

  Future<void> _onRefresh() async {
    await _loadFirst();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: InvoiceThemeColors.primaryBackground,
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
            icon: const Icon(Icons.add, color: InvoiceThemeColors.primaryPurple),
          ),
        ],
      ),
      body: SafeArea(
        child: Builder(
          builder: (context) {
            if (_loading) {
              return const Center(
                child: LazerVaultLoader.small(),
              );
            }

            if (_error != null) {
              return _buildError(_error!);
            }

            if (_items.isEmpty) {
              return _buildEmpty();
            }

            return RefreshIndicator(
              onRefresh: _onRefresh,
              color: InvoiceThemeColors.primaryPurpleLight,
              backgroundColor: InvoiceThemeColors.secondaryBackground,
              child: ListView.builder(
                controller: scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 8.h,
                ),
                itemCount: _items.length + (isLoadingMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index >= _items.length) {
                    return Padding(
                      padding: EdgeInsets.all(16.w),
                      child: const Center(
                        child: LazerVaultLoader.small(),
                      ),
                    );
                  }
                  return _buildPayRunCard(_items[index]);
                },
              ),
            );
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
          color: InvoiceThemeColors.secondaryBackground,
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
            Divider(color: InvoiceThemeColors.borderColor, height: 1.h),
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
                    color: InvoiceThemeColors.textGray500,
                    fontSize: 12.sp,
                  ),
                ),
                Text(
                  'Deductions: ${payRun.formattedTotalDeductions}',
                  style: GoogleFonts.inter(
                    color: InvoiceThemeColors.textGray500,
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
        Icon(icon, color: InvoiceThemeColors.textGray400, size: 16.sp),
        SizedBox(width: 6.w),
        Text(
          text,
          style: GoogleFonts.inter(
            color: InvoiceThemeColors.textGray400,
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
        badgeColor = InvoiceThemeColors.textGray400;
        break;
      case PayRunStatus.calculating:
        badgeColor = InvoiceThemeColors.warningOrange;
        break;
      case PayRunStatus.ready:
        badgeColor = InvoiceThemeColors.primaryPurpleLight;
        break;
      case PayRunStatus.approved:
        badgeColor = InvoiceThemeColors.warningOrange;
        break;
      case PayRunStatus.processing:
        badgeColor = InvoiceThemeColors.warningOrange;
        break;
      case PayRunStatus.completed:
        badgeColor = InvoiceThemeColors.successGreen;
        break;
      case PayRunStatus.failed:
        badgeColor = InvoiceThemeColors.errorRed;
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
                  color: InvoiceThemeColors.secondaryBackground,
                  borderRadius: BorderRadius.circular(36.r),
                ),
                child: Icon(
                  Icons.receipt_long_outlined,
                  size: 32.sp,
                  color: InvoiceThemeColors.textGray500,
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
                  color: InvoiceThemeColors.textGray400,
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
          Icon(Icons.error_outline, size: 48.sp, color: InvoiceThemeColors.errorRed),
          SizedBox(height: 16.h),
          Text(
            message,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: InvoiceThemeColors.textGray400,
              fontSize: 14.sp,
            ),
          ),
          SizedBox(height: 16.h),
          ElevatedButton(
            onPressed: _onRefresh,
            style: ElevatedButton.styleFrom(
              backgroundColor: InvoiceThemeColors.primaryPurple,
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
