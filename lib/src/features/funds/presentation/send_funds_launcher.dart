import 'package:get/get.dart';

import 'package:lazervault/core/config/feature_flags.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/recipients/data/models/recipient_model.dart';

/// Single entry point for starting a Send Funds journey. Resolves the user's
/// transfer-style choice ([FeatureFlags.sendFlowShortForSession], the value
/// pinned at login) — "classic" (short) vs "standard" (long) — and routes to
/// the correct flow, so every "send" affordance in the app honors the setting
/// consistently AND stably for the whole session (a background config refresh
/// can't flip the flow mid-journey).
class SendFundsLauncher {
  const SendFundsLauncher._();

  /// Open Send Funds, optionally pre-targeting [recipient].
  ///
  /// - Classic (short): the inline recipient → amount → PIN → receipt sheet.
  ///   With a [recipient], it can [autoContinue] straight to the amount step.
  /// - Standard (long): the full initiate-send-funds form (with a recipient),
  ///   or the recipient picker first when none is provided.
  ///
  /// [prefillAmountMinor] / [prefillCurrency] pre-fill the amount step — used by
  /// "Repeat" from a recipient's transaction history so a repeat honors whichever
  /// flow the user has selected instead of always opening the long form.
  ///
  /// [checkRecurring] only applies to the long flow's initiate screen (it offers
  /// to set up a recurring transfer); the short flow ignores it.
  static void open({
    RecipientModel? recipient,
    bool autoContinue = false,
    int? prefillAmountMinor,
    String? prefillCurrency,
    bool checkRecurring = false,
  }) {
    // "Repeat" and the empty-state "Send Money" are launched from a sheet
    // sitting ON TOP of the send-flow screen the launcher navigates to, so the
    // destination route is frequently the one we're already on. GetX's
    // preventDuplicates (default true) silently swallows a navigation to the
    // current route — the flow would never continue and the tap looks dead.
    // For that auto-continue case (a recipient we intend to run immediately) we
    // disable dedup so the navigation always lands. Each flow then continues via
    // its OWN navigation and self-cleans: short → Get.offAllNamed(transferProof)
    // on success / Get.back() on cancel; long → initiateSendFunds owns its
    // forward nav to the confirmation + receipt.
    final runsImmediately = recipient != null && autoContinue;

    if (FeatureFlags.sendFlowShortForSession) {
      // Classic (short) flow: the Select Recipient screen owns amount → PIN →
      // receipt. autoContinue jumps straight to the amount step with the
      // repeated amount (minor units) pre-filled.
      Get.toNamed(
        AppRoutes.selectRecipient,
        preventDuplicates: !runsImmediately,
        arguments: {
          'shortFlow': true,
          if (recipient != null) 'preselectedRecipient': recipient,
          if (runsImmediately) 'autoContinue': true,
          if (prefillAmountMinor != null) 'prefillAmount': prefillAmountMinor,
          if (prefillCurrency != null) 'prefillCurrency': prefillCurrency,
        },
      );
      return;
    }

    // Standard (long) flow.
    if (recipient != null) {
      // Go straight to the amount/confirm screen. prefillAmount (minor units) +
      // autoShowConfirm make it open the confirmation sheet pre-filled, so a
      // Repeat only needs the user to confirm; checkRecurring lets it offer a
      // recurring rule.
      Get.toNamed(
        AppRoutes.initiateSendFunds,
        preventDuplicates: !runsImmediately,
        arguments: {
          'recipient': recipient,
          if (prefillAmountMinor != null) 'prefillAmount': prefillAmountMinor,
          if (prefillCurrency != null) 'prefillCurrency': prefillCurrency,
          if (prefillAmountMinor != null) 'autoShowConfirm': true,
          if (checkRecurring) 'checkRecurring': true,
        },
      );
    } else {
      // No recipient → the long-flow recipient picker
      // (SelectRecipients defaults to shortFlow:false).
      Get.toNamed(AppRoutes.selectRecipient);
    }
  }
}
