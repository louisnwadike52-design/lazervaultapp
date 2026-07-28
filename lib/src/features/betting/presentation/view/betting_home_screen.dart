import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../core/types/app_routes.dart';
import '../cubit/betting_cubit.dart';
import '../cubit/betting_state.dart';
import '../widgets/betting_quick_buy.dart';
import 'betting_theme.dart';

/// Fund betting account hub — streamlined single-page flow.
///
/// All of the funding UX (platform picker, account id + auto name-verify,
/// amount, inline confirm, TX-PIN sheet → receipt) lives inside
/// [BettingQuickBuy], along with the "use a saved account" shortcut. This
/// screen just loads the platform catalogue and hosts the widget, plus a
/// recent-funding strip (mirrors EPinHomeScreen) that is the entry point into
/// the full history screen — which in turn hosts the saved-accounts manager.
class BettingHomeScreen extends StatefulWidget {
  const BettingHomeScreen({super.key});

  @override
  State<BettingHomeScreen> createState() => _BettingHomeScreenState();
}

class _BettingHomeScreenState extends State<BettingHomeScreen> {
  static const _bg = BettingTheme.bg;
  static const _card = BettingTheme.card;
  static const _divider = BettingTheme.divider;
  static const _primary = BettingTheme.primary;
  static const _success = BettingTheme.success;
  static const _warning = BettingTheme.warning;
  static const _error = BettingTheme.error;
  static const _textSecondary = BettingTheme.textSecondary;

  // Recent-funding strip state (the funding itself lives in BettingQuickBuy).
  Future<List<BettingFundingRecord>>? _recentFuture;

  @override
  void initState() {
    super.initState();
    context.read<BettingCubit>().loadPlatforms();
    _loadRecent();
  }

  void _loadRecent() {
    _recentFuture = context.read<BettingCubit>().repository.getHistory();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: SafeArea(
        child: Column(
          children: [
            // Chat + voice (and the old history icon) intentionally omitted —
            // the Utility Payments per-service assistant and the general
            // chat/voice agents already cover betting funding. Header stays
            // clean.
            const BettingHeader(
              title: 'Fund betting account',
              subtitle: 'Top up your betting wallet instantly',
            ),
            Expanded(
              child: BlocBuilder<BettingCubit, BettingState>(
                buildWhen: (_, s) =>
                    s is BettingPlatformsLoading ||
                    s is BettingPlatformsLoaded ||
                    s is BettingPlatformsError,
                builder: (context, state) {
                  if (state is BettingPlatformsLoading) {
                    return const Center(
                      child: CircularProgressIndicator(color: _primary),
                    );
                  }
                  if (state is BettingPlatformsError) {
                    return _buildError(state.message);
                  }
                  if (state is BettingPlatformsLoaded) {
                    if (state.platforms.isEmpty) return _buildEmpty();
                    return _buildBody();
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

  Widget _buildBody() {
    // Streamlined single-page purchase (see BettingQuickBuy): platform →
    // account → auto-verify → amount → inline confirm → TX-PIN sheet funds →
    // receipt. The saved-account shortcut lives inside the widget.
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 4.h),
          const BettingQuickBuy(),
          SizedBox(height: 28.h),
          _buildRecentSection(),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  Widget _sectionTitle(String text, {Widget? trailing}) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          if (trailing != null) trailing,
        ],
      );

  /// Recent funding records — first 3, with a "View all" into the full
  /// history screen (which also hosts the saved-accounts manager).
  Widget _buildRecentSection() {
    return FutureBuilder<List<BettingFundingRecord>>(
      future: _recentFuture,
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting ||
            !snap.hasData ||
            snap.data!.isEmpty) {
          return const SizedBox.shrink();
        }
        final recent = snap.data!.take(3).toList();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle(
              'Recent',
              trailing: GestureDetector(
                onTap: () async {
                  await Get.toNamed(AppRoutes.bettingHistory);
                  if (mounted) setState(_loadRecent);
                },
                child: Text(
                  'View all',
                  style: TextStyle(
                    color: _primary,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(height: 12.h),
            ...recent.map(_buildRecentTile),
          ],
        );
      },
    );
  }

  Widget _buildRecentTile(BettingFundingRecord r) {
    final color = r.isFailed ? _error : (r.isPending ? _warning : _success);
    String created = r.createdAt;
    final parsed = DateTime.tryParse(r.createdAt);
    if (parsed != null) {
      created = DateFormat('MMM dd, HH:mm').format(parsed.toLocal());
    }
    return GestureDetector(
      onTap: () => _openReceipt(r),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: _card,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: _divider),
        ),
        child: Row(
          children: [
            Container(
              width: 36.w,
              height: 36.w,
              decoration: BoxDecoration(
                color: _primary.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(Icons.sports_soccer, color: _primary, size: 18.sp),
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
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    created,
                    style: TextStyle(color: _textSecondary, fontSize: 10.sp),
                  ),
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
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4.h),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    r.status,
                    style: TextStyle(
                      color: color,
                      fontSize: 9.5.sp,
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
              onPressed: () => context.read<BettingCubit>().loadPlatforms(),
              child: const Text('Retry', style: TextStyle(color: _primary)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Text(
        'No betting platforms available right now',
        style: TextStyle(color: _textSecondary, fontSize: 14.sp),
      ),
    );
  }
}
