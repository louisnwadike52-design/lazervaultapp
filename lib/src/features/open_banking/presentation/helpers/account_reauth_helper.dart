import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' hide Trans;
import 'package:lazervault/src/core/config/mono_config.dart';
import 'package:lazervault/src/features/ai_scan_to_pay/presentation/widgets/mono_connect_widget.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/features/open_banking/cubit/open_banking_cubit.dart';
import 'package:lazervault/src/features/open_banking/domain/entities/linked_bank_account.dart';

/// Drives the FULL reconnect flow for a linked bank whose Mono session
/// expired (REAUTHORIZATION_REQUIRED):
///
///   1. Fetch a reauth token from banking-service (Mono /accounts/{id}/reauthorise)
///   2. Open the shared Mono Connect sheet in REAUTH mode (same widget the
///      link flow uses — ONE PIPELINE, reauth is just a variant)
///   3. On success, run the normal linkAccount exchange — the backend's
///      same-bank dedup updates the existing row instead of duplicating it
///   4. Refresh the live balance so the card shows real figures again
///
/// Safe to call from any screen that has OpenBankingCubit + AuthenticationCubit
/// in scope (Beam dashboard/flow, deposit, withdraw, linked-accounts, stats).
Future<void> startAccountReauthorization(
  BuildContext context,
  LinkedBankAccount account,
) async {
  final authState = context.read<AuthenticationCubit>().state;
  if (authState is! AuthenticationSuccess) return;
  final cubit = context.read<OpenBankingCubit>();
  final user = authState.profile.user;
  final accessToken = authState.profile.session.accessToken;

  // 1. Reauth token (loading feedback while we round-trip)
  Get.snackbar(
    'Reconnecting ${account.bankName}',
    'Preparing a secure session with your bank…',
    backgroundColor: const Color(0xFF1F1F1F),
    colorText: Colors.white,
    snackPosition: SnackPosition.BOTTOM,
    showProgressIndicator: true,
    progressIndicatorBackgroundColor: const Color(0xFF2D2D2D),
    duration: const Duration(seconds: 10),
  );
  final token = await cubit.reauthorizeAccount(
    accountId: account.id,
    userId: user.id,
    accessToken: accessToken,
  );
  Get.closeAllSnackbars();
  if (token == null || token.isEmpty) {
    Get.snackbar(
      'Reconnect Failed',
      'Could not start the secure session. Please try again.',
      backgroundColor: const Color(0xFFEF4444),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
    return;
  }
  if (!context.mounted) return;

  // 2. Shared Connect sheet in reauth mode
  final customerName =
      '${user.firstName} ${user.lastName}'.trim();
  final result = await showMonoConnectBottomSheet(
    context: context,
    publicKey: MonoConfig.publicKey,
    customerName: customerName.isNotEmpty ? customerName : null,
    customerEmail: user.email.isNotEmpty ? user.email : null,
    reference: 'lzv_reauth_${DateTime.now().millisecondsSinceEpoch}',
    reauthAccountId: token,
  );
  if (result == null) return; // user cancelled at the bank — no state change
  if (!context.mounted) return;

  // 3. Standard exchange — backend dedups to the SAME linked-account row
  await cubit.linkAccount(
    userId: user.id,
    code: result.code,
    accessToken: accessToken,
    // Reauth must NOT change the account's debit mode — keep whatever
    // mandate (or DirectPay-only setup) the account already has.
    autoCreateMandate: false,
    userEmail: user.email.isNotEmpty ? user.email : null,
    userName: customerName.isNotEmpty ? customerName : null,
  );

  // 4. Fresh live balance for the reconnected account
  await cubit.refreshBalance(
    accountId: account.id,
    userId: user.id,
    accessToken: accessToken,
  );
}
