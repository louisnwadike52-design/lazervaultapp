import 'package:flutter/widgets.dart';
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
  /// Named page routes that belong to EITHER send-funds flow. When a new
  /// journey starts we unwind any of these still on the stack so a short flow is
  /// never launched on top of a long-flow screen (or vice-versa). Leaving one
  /// behind is the root cause of the "long-flow amount page flashes before the
  /// receipt" bug: the terminal `Get.offAllNamed(transferProof)` tears the stale
  /// route down on-screen. Receipts are included so "send again" from a receipt
  /// starts clean too.
  static const Set<String> _sendFlowRoutes = {
    AppRoutes.selectRecipient,
    AppRoutes.quickSend,
    AppRoutes.sendFunds,
    AppRoutes.initiateSendFunds,
    AppRoutes.reviewFundsTransfer,
    AppRoutes.transferProcessing,
    AppRoutes.transferProof,
    AppRoutes.sendFundReceipt,
  };

  /// Stop predicate for [Get.offNamedUntil]: keep unwinding until we reach the
  /// first STABLE base — a named, non-send page (e.g. dashboard, a chat screen)
  /// or the root. Everything above it (a previous flow's send routes + any
  /// transient anonymous bottom sheets like the "Repeat" history sheet the user
  /// launched from) is removed, so the fresh flow always sits on a clean base.
  static bool _isCleanBase(Route<dynamic> route) =>
      isCleanBaseRoute(route.settings.name, route.isFirst);

  /// Pure form of [_isCleanBase] (name + isFirst) so the stack-clean rule that
  /// prevents the long/short flows from coexisting can be unit-tested without a
  /// live Navigator. Returns true for the route to STOP at (keep as the base).
  @visibleForTesting
  static bool isCleanBaseRoute(String? routeName, bool isFirst) {
    if (isFirst) return true;
    if (routeName == null) return false; // transient/anonymous sheet → remove
    return !_sendFlowRoutes.contains(routeName);
  }

  /// Open Send Funds, optionally pre-targeting [recipient].
  static void open({
    RecipientModel? recipient,
    bool autoContinue = false,
    int? prefillAmountMinor,
    String? prefillCurrency,
    bool checkRecurring = false,
  }) {
    // Each flow is launched with `offNamedUntil(_isCleanBase)` rather than a bare
    // `toNamed`: it (a) atomically removes any stale send-flow route/transient
    // sheet from the stack so the two flows can NEVER coexist, and (b) always
    // lands (no preventDuplicates dedup swallowing the tap when "Repeat" is
    // launched from a sheet sitting on the current send screen). Each flow then
    // self-cleans forward: short → Get.offAllNamed(transferProof); long →
    // initiateSendFunds owns its forward nav to confirm + receipt.
    final runsImmediately = recipient != null && autoContinue;

    if (FeatureFlags.sendFlowShortForSession) {
      // Classic (short) flow. A KNOWN recipient we run immediately (chat / QR /
      // repeat) uses the TRANSPARENT quick-send host so the amount sheet opens
      // directly over the caller with no opaque intermediate screen flashing on
      // open/close. Everything else uses the standard (opaque) picker. The
      // destination is decided HERE, up front — we navigate ONCE, never route
      // then re-route based on the flow.
      final route =
          runsImmediately ? AppRoutes.quickSend : AppRoutes.selectRecipient;
      Get.offNamedUntil(
        route,
        _isCleanBase,
        arguments: {
          'shortFlow': true,
          if (recipient != null) 'preselectedRecipient': recipient,
          if (runsImmediately) 'autoContinue': true,
          if (runsImmediately) 'transparentHost': true,
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
      Get.offNamedUntil(
        AppRoutes.initiateSendFunds,
        _isCleanBase,
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
      Get.offNamedUntil(AppRoutes.selectRecipient, _isCleanBase);
    }
  }
}
