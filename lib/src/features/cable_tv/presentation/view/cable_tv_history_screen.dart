import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../core/widgets/bill_history_item.dart';
import '../../domain/entities/cable_tv_payment_entity.dart';
import '../cubit/cable_tv_cubit.dart';
import '../cubit/cable_tv_state.dart';
import '../widgets/cable_tv_history_actions_sheet.dart';

/// Full cable TV payment history. Uses CableTVCubit.loadPaymentHistory.
/// Scope toggle: All / Subscriptions.
class CableTVHistoryScreen extends StatefulWidget {
  const CableTVHistoryScreen({super.key});

  @override
  State<CableTVHistoryScreen> createState() => _CableTVHistoryScreenState();
}

class _CableTVHistoryScreenState extends State<CableTVHistoryScreen> {
  static const Color _bg = Color(0xFF0A0A0A);
  static const Color _card = Color(0xFF1F1F1F);
  static const Color _primary = Color(0xFF4E03D0);
  static const Color _textSecondary = Color(0xFF9CA3AF);

  String _scope = 'all';
  String? _filterSmartCardNumber;
  String? _filterNickname;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map<String, dynamic>?;
    final s = args?['scope'] as String?;
    if (s == 'subscriptions') _scope = s!;
    _filterSmartCardNumber = args?['smartCardNumber'] as String?;
    _filterNickname = args?['nickname'] as String?;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<CableTVCubit>().loadPaymentHistory(limit: 50);
    });
  }

  Future<void> _refresh() async {
    await context.read<CableTVCubit>().loadPaymentHistory(limit: 50);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            SizedBox(height: 8.h),
            _buildScopeToggle(),
            SizedBox(height: 16.h),
            Expanded(
              child: BlocBuilder<CableTVCubit, CableTVState>(
                buildWhen: (prev, next) =>
                    next is CableTVPaymentHistoryLoading ||
                    next is CableTVPaymentHistoryLoaded ||
                    next is CableTVPaymentHistoryError,
                builder: (context, state) {
                  List<CableTVPaymentEntity>? source;
                  bool isFresh = false;
                  String? errorMsg;
                  if (state is CableTVPaymentHistoryLoaded) {
                    source = state.payments;
                    isFresh = !state.isStale;
                  } else if (state is CableTVPaymentHistoryError) {
                    errorMsg = state.message;
                    source = context.read<CableTVCubit>().cachedPayments;
                  } else {
                    source = context.read<CableTVCubit>().cachedPayments;
                  }

                  if (source == null && errorMsg == null) {
                    return _buildLoading();
                  }
                  if (source == null && errorMsg != null) {
                    return _buildError(errorMsg);
                  }

                  var filtered = source ?? const <CableTVPaymentEntity>[];

                  if (_filterSmartCardNumber != null) {
                    final target = _filterSmartCardNumber!.trim();
                    filtered = filtered
                        .where((p) => p.customerNumber.trim() == target)
                        .toList();
                  }

                  if (filtered.isEmpty && isFresh) {
                    return _buildEmpty();
                  }
                  if (filtered.isEmpty) {
                    return _buildLoading();
                  }

                  return RefreshIndicator(
                    onRefresh: _refresh,
                    color: _primary,
                    backgroundColor: _card,
                    child: ListView.separated(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 8.h),
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: filtered.length,
                      separatorBuilder: (_, __) => SizedBox(height: 10.h),
                      itemBuilder: (_, i) => _buildRow(filtered[i]),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final isFiltered = _filterSmartCardNumber != null;
    final label = isFiltered
        ? (_filterNickname ?? _filterSmartCardNumber!)
        : 'Cable TV History';
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(Icons.arrow_back_ios_new,
                  color: Colors.white, size: 20.sp),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (isFiltered) ...[
                  SizedBox(height: 2.h),
                  Text(
                    _filterSmartCardNumber!,
                    style: TextStyle(
                        fontSize: 12.sp, color: const Color(0xFF9CA3AF)),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
          if (isFiltered)
            GestureDetector(
              onTap: () => setState(() {
                _filterSmartCardNumber = null;
                _filterNickname = null;
              }),
              child: Container(
                width: 36.w,
                height: 36.w,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(Icons.close, color: const Color(0xFF9CA3AF),
                    size: 16.sp),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildScopeToggle() {
    Widget chip(String value, String label) {
      final selected = _scope == value;
      return GestureDetector(
        onTap: () => setState(() => _scope = value),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: selected ? _primary : _card,
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(
              color: selected
                  ? _primary
                  : Colors.white.withValues(alpha: 0.08),
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: selected ? Colors.white : _textSecondary,
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          chip('all', 'All'),
          SizedBox(width: 8.w),
          chip('subscriptions', 'Subscriptions'),
        ],
      ),
    );
  }

  Widget _buildRow(CableTVPaymentEntity p) {
    return BillHistoryItem(
      leadingIcon: Container(
        decoration: BoxDecoration(
          color: _primary.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Icon(Icons.live_tv, color: _primary, size: 20.sp),
      ),
      title: p.customerNumber.isEmpty
          ? 'Cable TV payment'
          : p.customerNumber,
      subtitle: p.reference,
      date: p.createdAt,
      amount: p.amount,
      status: p.status,
      onTap: () => CableTVHistoryActionsSheet.show(context, p),
    );
  }

  Widget _buildLoading() => Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation(_primary),
        ),
      );

  Widget _buildEmpty() {
    final isFiltered = _filterSmartCardNumber != null;
    final title = isFiltered
        ? 'No purchases for this card'
        : 'No cable TV payments yet';
    final subtitle = isFiltered
        ? 'No transactions found for smart card ${_filterSmartCardNumber!}.'
        : 'Pay your first cable TV subscription and it will show up here.';
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.history, color: _textSecondary, size: 56.sp),
            SizedBox(height: 16.h),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: _textSecondary,
                fontSize: 12.sp,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildError(String message) => Center(
        child: Padding(
          padding: EdgeInsets.all(32.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline,
                  color: const Color(0xFFEF4444), size: 56.sp),
              SizedBox(height: 16.h),
              Text(
                'Couldn\u2019t load history',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 6.h),
              Text(message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: _textSecondary, fontSize: 12.sp, height: 1.5)),
              SizedBox(height: 16.h),
              ElevatedButton(
                onPressed: _refresh,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primary,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(
                      horizontal: 20.w, vertical: 12.h),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r)),
                ),
                child: Text('Retry',
                    style: TextStyle(
                        fontSize: 13.sp, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        ),
      );
}
