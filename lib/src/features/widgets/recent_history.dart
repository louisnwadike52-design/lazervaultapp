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
import 'package:lazervault/src/features/widgets/recent_history_list.dart';

class RecentHistory extends StatefulWidget {
  const RecentHistory({super.key});

  @override
  State<RecentHistory> createState() => _RecentHistoryState();
}

class _RecentHistoryState extends State<RecentHistory> {
  late final TransactionHistoryCubit _cubit;
  StreamSubscription<String?>? _accountSub;
  StreamSubscription<String>? _localeSub;

  @override
  void initState() {
    super.initState();
    _cubit = serviceLocator<TransactionHistoryCubit>();

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
  }

  @override
  void dispose() {
    _accountSub?.cancel();
    _localeSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: Container(
        padding: EdgeInsets.fromLTRB(20.w, 20.w, 20.w, 12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent Transactions',
                  style: TextStyle(
                    fontSize: 16.sp,
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
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF581CD9),
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            const RecentHistoryList(),
          ],
        ),
      ),
    );
  }
}
