library;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:lazervault/core/shared_widgets/server_refusal_sheet.dart';
import 'package:lazervault/core/types/app_routes.dart';

/// Tells the user how the RECURRING rule went — on the receipt, after the
/// money.
///
/// WHY IT MOVED
/// ------------
/// Both send-funds flows used to hold the user on the screen they had just
/// paid from, with a blocking modal about the recurring rule, and only then
/// navigate to the receipt. Two things wrong with that:
///
///   • The receipt is the thing they are waiting for. A transfer has
///     completed and the app is talking about a scheduling preference
///     instead of confirming the payment.
///   • Anything shown before `Get.offAllNamed(transferProof)` is standing on
///     a route that is about to be torn down, so a non-blocking notice there
///     vanishes the instant the receipt arrives — reported as "the
///     notification dialog ... appears before the receipt which quickly
///     disappears it".
///
/// The receipt now comes first and carries the outcome with it, so the notice
/// opens over a screen that is staying put and can be dismissed in the user's
/// own time.
///
/// WHY RETRY IS A LINK, NOT A BUTTON
/// ---------------------------------
/// Retrying in place needs the transfer's verification token, and a token is
/// a credential — putting one into receipt route arguments would park it in
/// navigation state for the life of the stack. The notice links to Recurring
/// transfers instead, where the rule can be created against the same
/// recipient without any credential travelling with it.
enum RecurringOutcome {
  /// The rule was created. A quiet confirmation.
  created,

  /// The transfer succeeded, the rule did not. The money is fine; the
  /// schedule needs another go.
  failed,
}

/// The route-argument keys the receipt reads. Kept here so the producers and
/// the consumer cannot spell them differently.
const String kRecurringOutcomeArg = 'recurringOutcome';
const String kRecurringErrorArg = 'recurringError';

/// Encodes an outcome for the receipt's route arguments.
Map<String, dynamic> recurringOutcomeArgs(
  RecurringOutcome outcome, {
  String? error,
}) =>
    <String, dynamic>{
      kRecurringOutcomeArg: outcome.name,
      if (error != null && error.trim().isNotEmpty)
        kRecurringErrorArg: error.trim(),
    };

/// Reads the outcome back out, or null when the transfer had no recurring
/// rule attached.
RecurringOutcome? recurringOutcomeFrom(Map<String, dynamic>? args) {
  final raw = args?[kRecurringOutcomeArg];
  if (raw is! String) return null;
  for (final o in RecurringOutcome.values) {
    if (o.name == raw) return o;
  }
  return null;
}

/// Shows the notice over the receipt. Safe to call once the receipt is
/// mounted; does nothing when there was no recurring rule.
Future<void> showRecurringOutcomeNotice(
  BuildContext context,
  Map<String, dynamic>? args,
) async {
  final outcome = recurringOutcomeFrom(args);
  if (outcome == null) return;

  if (outcome == RecurringOutcome.created) {
    // A success needs no decision and no action, so it is a snackbar rather
    // than a sheet — the receipt behind it is the thing worth reading.
    Get.snackbar(
      'Recurring payment set up',
      'This transfer will repeat automatically. Manage it under Recurring '
          'transfers.',
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFF10B981).withValues(alpha: 0.95),
      colorText: Colors.white,
      duration: const Duration(seconds: 4),
    );
    return;
  }

  final err = (args?[kRecurringErrorArg] as String?)?.trim();
  final tapped = await showServerRefusal(
    context,
    title: 'Recurring payment not set up',
    message: 'Your transfer went through. The repeat schedule did not.'
        '${err == null || err.isEmpty ? '' : '\n\n$err'}',
    hint: 'The money has already been sent — only the schedule is missing.',
    actionLabel: 'Set it up',
    dismissLabel: 'Not now',
  );
  if (tapped) Get.toNamed(AppRoutes.recurringTransfers);
}
