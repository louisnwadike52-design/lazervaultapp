import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'package:lazervault/core/services/account_manager.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/account_actions/presentation/cubit/account_actions_cubit.dart';
import 'package:lazervault/src/features/account_actions/presentation/widgets/account_actions_bottom_sheet.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_cubit.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_state.dart';
import 'package:lazervault/src/features/account_cards_summary/domain/entities/account_summary_entity.dart';

/// Opens the SAME account-details bottom sheet the dashboard card's "Details"
/// chip opens — used by the provider-change dialogs so "View updated account
/// details" actually shows the account details (number, bank, copy/share)
/// instead of dumping the user on a settings page. Picks [preferAccountId]
/// first, then the dashboard-active account, then personal/primary, then the
/// first summary. Falls back to the My Account screen only when summaries
/// aren't loaded yet, so the tap is never dead.
Future<void> openAccountDetailsSheet(BuildContext context,
    {String? preferAccountId}) async {
  List<AccountSummaryEntity>? accounts;
  try {
    final st = context.read<AccountCardsSummaryCubit>().state;
    if (st is AccountCardsSummaryLoaded) {
      accounts = st.accountSummaries;
    } else if (st is AccountBalanceUpdated) {
      accounts = st.accountSummaries;
    }
  } catch (_) {/* cubit not in scope — fall through to the screen */}
  if (accounts == null || accounts.isEmpty) {
    Get.toNamed(AppRoutes.myAccount);
    return;
  }

  AccountSummaryEntity? pick(String? id) {
    if (id == null || id.isEmpty) return null;
    for (final a in accounts!) {
      if (a.id.toString() == id) return a;
    }
    return null;
  }

  final activeId = serviceLocator<AccountManager>().activeAccountId;
  final acct = pick(preferAccountId) ??
      pick(activeId) ??
      accounts.firstWhere(
        (a) => a.accountType.toLowerCase().contains('personal') || a.isPrimary,
        orElse: () => accounts!.first,
      );

  // Same argument shape the dashboard carousel builds for its Details chip.
  final args = <String, dynamic>{
    'id': acct.id,
    'accountType': acct.accountType,
    'currency': acct.currency,
    'balance': acct.balance,
    'availableBalance': acct.availableBalance,
    'reservedBalance': acct.reservedBalance,
    'accountNumber': acct.accountNumber ?? '',
    'accountNumberMasked': '•••• ${acct.accountNumberLast4}',
    'bankName': acct.bankName ?? '',
    'accountName': acct.accountName ?? '',
  };

  await Get.bottomSheet(
    BlocProvider.value(
      value: serviceLocator<AccountActionsCubit>(),
      child: AccountActionsBottomSheet(accountArgs: args),
    ),
    isScrollControlled: true,
    enableDrag: true,
    isDismissible: true,
    backgroundColor: Colors.transparent,
  );
}
