import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/services/account_manager.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/locale_manager.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/transaction_history/presentation/cubit/transaction_history_cubit.dart';
import 'package:lazervault/src/features/widgets/dashboard/dashboard_refresh_signal.dart';
import 'package:lazervault/src/features/widgets/recent_history_list.dart';
import 'package:visibility_detector/visibility_detector.dart';

class RecentHistory extends StatefulWidget {
  const RecentHistory({super.key});

  @override
  State<RecentHistory> createState() => _RecentHistoryState();
}

class _RecentHistoryState extends State<RecentHistory> {
  late final TransactionHistoryCubit _cubit;
  StreamSubscription<String?>? _accountSub;
  StreamSubscription<String>? _localeSub;

  // Tracks scroll-into-view so we refetch each time the section becomes visible.
  bool _wasVisible = false;
  DateTime? _lastAutoFetch;

  @override
  void initState() {
    super.initState();
    _cubit = serviceLocator<TransactionHistoryCubit>();
    // Seed the throttle so the initial account/locale load isn't immediately
    // duplicated by the first visibility callback on the same frame.
    _lastAutoFetch = DateTime.now();

    final accountManager = serviceLocator<AccountManager>();
    final localeManager = serviceLocator<LocaleManager>();

    // Reload transactions whenever the active account changes
    _accountSub = accountManager.accountIdStream
        .distinct()
        .where((id) => id != null)
        .listen((_) => _cubit.loadAllTransactions());

    // Reload transactions whenever the locale/country changes
    _localeSub = localeManager.countryStream
        .distinct()
        .listen((_) => _cubit.loadAllTransactions());

    // Explicit dashboard refresh (swipe-down → "Refresh accounts"): hard-reload
    // this list too. Foreground (background:false) so it visibly reloads, and
    // refreshTransactions() clears the repo's scoped cache first — a true
    // revalidation, not a cache-served page.
    DashboardRefreshSignal.instance.listenable.addListener(_onManualRefresh);
  }

  void _onManualRefresh() {
    if (!mounted) return;
    _lastAutoFetch = DateTime.now(); // suppress the visibility auto-fetch racing this
    _cubit.refreshTransactions(background: false);
  }

  /// Fires as the section scrolls in/out of view. On each fresh entry into view
  /// we pull the latest transactions (bypassing the cache) so the dashboard
  /// never shows stale history. Guarded so it triggers once per entry and at
  /// most every couple of seconds (jitter / rapid up-down scrolls).
  void _onVisibilityChanged(VisibilityInfo info) {
    if (!mounted) return;
    final visible = info.visibleFraction > 0.2;
    if (!visible) {
      _wasVisible = false;
      return;
    }
    if (_wasVisible) return; // already counted this entry
    _wasVisible = true;

    final now = DateTime.now();
    if (_lastAutoFetch != null &&
        now.difference(_lastAutoFetch!) < const Duration(seconds: 2)) {
      return;
    }
    _lastAutoFetch = now;
    // Background refresh: pull the latest transactions WITHOUT flashing a loading
    // skeleton — the current list stays on screen and updates in place, so the
    // section doesn't flicker each time it scrolls into view.
    _cubit.refreshTransactions(background: true);
  }

  @override
  void dispose() {
    _accountSub?.cancel();
    _localeSub?.cancel();
    DashboardRefreshSignal.instance.listenable.removeListener(_onManualRefresh);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: VisibilityDetector(
        key: const Key('dashboard-recent-history'),
        onVisibilityChanged: _onVisibilityChanged,
        child: Container(
        padding: EdgeInsets.fromLTRB(20.w, 14.w, 20.w, 10.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Recent Transactions',
                  style: TextStyle(
                    fontSize: 16.sp,
                    height: 1.15,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1A1A1A),
                    fontFamily: 'Inter',
                  ),
                ),
                GestureDetector(
                  onTap: () => Get.toNamed(AppRoutes.dashboardTransactionHistory),
                  child: Text(
                    'See all',
                    style: TextStyle(
                      fontSize: 14.sp,
                      height: 1.15,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF581CD9),
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 18.h),
            const RecentHistoryList(),
          ],
        ),
        ),
      ),
    );
  }
}
