import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../core/types/app_routes.dart';
import '../cubit/betting_cubit.dart';
import '../cubit/betting_state.dart';
import 'betting_theme.dart';

/// Betting funding history + entry to saved-accounts management.
class BettingHistoryScreen extends StatefulWidget {
  const BettingHistoryScreen({super.key});

  @override
  State<BettingHistoryScreen> createState() => _BettingHistoryScreenState();
}

class _BettingHistoryScreenState extends State<BettingHistoryScreen> {
  static const _bg = BettingTheme.bg;
  static const _card = BettingTheme.card;
  static const _divider = BettingTheme.divider;
  static const _primary = BettingTheme.primary;
  static const _success = BettingTheme.success;
  static const _warning = BettingTheme.warning;
  static const _error = BettingTheme.error;
  static const _textSecondary = BettingTheme.textSecondary;

  @override
  void initState() {
    super.initState();
    context.read<BettingCubit>().loadHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: BlocBuilder<BettingCubit, BettingState>(
                buildWhen: (_, s) =>
                    s is BettingHistoryLoading ||
                    s is BettingHistoryLoaded ||
                    s is BettingHistoryError,
                builder: (context, state) {
                  if (state is BettingHistoryLoading) {
                    return const Center(
                      child: CircularProgressIndicator(color: _primary),
                    );
                  }
                  if (state is BettingHistoryError) {
                    return _buildError(state.message);
                  }
                  if (state is BettingHistoryLoaded) {
                    if (state.records.isEmpty) return _buildEmpty();
                    return RefreshIndicator(
                      color: _primary,
                      onRefresh: () =>
                          context.read<BettingCubit>().loadHistory(),
                      child: ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        itemCount: state.records.length,
                        itemBuilder: (context, i) =>
                            _buildTile(state.records[i]),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: _card,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(Icons.arrow_back_ios_new,
                  color: Colors.white, size: 18.sp),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Text(
              'Funding history',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => Get.toNamed(AppRoutes.bettingBeneficiaries),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: _card,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
                children: [
                  Icon(Icons.bookmark, color: _primary, size: 15.sp),
                  SizedBox(width: 4.w),
                  Text('Saved',
                      style: TextStyle(color: _primary, fontSize: 12.sp)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTile(BettingFundingRecord r) {
    final color = r.isFailed ? _error : (r.isPending ? _warning : _success);
    String created = r.createdAt;
    final parsed = DateTime.tryParse(r.createdAt);
    if (parsed != null) {
      created = DateFormat('MMM dd, yyyy HH:mm').format(parsed.toLocal());
    }
    return GestureDetector(
      onTap: () => _openReceipt(r),
      child: Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: _divider),
      ),
      child: Row(
        children: [
          Container(
            width: 42.w,
            height: 42.w,
            decoration: BoxDecoration(
              color: _primary.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(11.r),
            ),
            child: Icon(Icons.sports_soccer, color: _primary, size: 20.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${r.platform} · ${r.customerNumber}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(created,
                    style: TextStyle(color: _textSecondary, fontSize: 11.sp)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '₦${r.amount.toStringAsFixed(0)}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 4.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  r.status,
                  style: TextStyle(
                    color: color,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
    );
  }

  void _openReceipt(BettingFundingRecord r) {
    Get.toNamed(AppRoutes.bettingReceipt, arguments: {
      'result': BettingFundingResult(
        payment: r,
        newBalance: 0,
        providerReference: '',
        message: '',
      ),
      'platformName': r.platform,
      'accountName': '',
    });
  }

  Widget _buildError(String message) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, color: _error, size: 40.sp),
            SizedBox(height: 12.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(color: _textSecondary, fontSize: 14.sp),
            ),
            SizedBox(height: 16.h),
            TextButton(
              onPressed: () => context.read<BettingCubit>().loadHistory(),
              child: const Text('Retry', style: TextStyle(color: _primary)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.history, color: _textSecondary, size: 44.sp),
          SizedBox(height: 12.h),
          Text(
            'No funding history yet',
            style: TextStyle(color: _textSecondary, fontSize: 14.sp),
          ),
        ],
      ),
    );
  }
}
