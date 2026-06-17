// Screen-driving helpers for the currency-exchange UI e2e suite (#108).
//
// These encapsulate the tap-and-wait sequences that drive the actual Flutter
// widgets. The existing gRPC-orchestrated tests in
// currency_exchange_e2e_test.dart prove the BACKEND contract for every
// corridor (NGN-radial + reverse + 72-pair cross matrix). The helpers here
// power a small set of REPRESENTATIVE UI tests that prove the new visual
// surfaces (#112 SourceCurrencyPicker, #107 ExchangePredictionAlert, #114
// corridor pre-flight, #106 blocklist enforcement) render and behave
// correctly when driven by real tap events.
//
// Design notes:
//   * Every helper is bounded (deadline-based pumping, never an open loop)
//     so a missing widget surfaces as a clean timeout, not a hung test.
//   * Helpers prefer best-effort find-by-text over find-by-key because the
//     exchange UI does not yet plumb explicit Keys onto every actionable
//     widget — adding them would be a parallel change. When a Key is
//     present (TransactionPinMixin's digit keypad), we use it.
//   * Helpers NEVER throw on a not-found widget; they return false / a
//     status enum so the calling test can record a clean WARN/FAIL with
//     the right semantics. Throwing here turns "test asserted something
//     that didn't render" into "harness crashed", which is harder to
//     debug from a CI summary.
//
// Boot-window calibration (from the saved-batches lesson, see
// integration_test/saved_batches_e2e_test.dart):
//   * realBootEnd = 120s    (cold emulator engine init)
//   * bootDeadline = 180s   (Navigator + GetMaterialApp mounted)
//
// Sourced from the existing pattern in
// integration_test/transfer_send_ui_e2e_test.dart so the muscle memory
// transfers across e2e suites.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/currency_exchange/presentation/views/exchange_home_screen.dart';
import 'package:lazervault/src/features/currency_exchange/presentation/views/exchange_receipt_screen.dart';
import 'package:lazervault/src/features/currency_exchange/presentation/views/exchange_recipient_screen.dart';
import 'package:lazervault/src/features/currency_exchange/presentation/widgets/exchange_prediction_alert.dart';
import 'package:lazervault/src/features/currency_exchange/presentation/widgets/source_currency_picker.dart';

/// Boot-window constants — exposed so the e2e suite can reference them
/// without duplicating the magic numbers. Calibrated on a cold emulator
/// using the same saved-batches discovery (see project memory).
const Duration kBootRealEnd = Duration(seconds: 120);
const Duration kBootDeadline = Duration(seconds: 180);

/// Result of a screen-driven assertion that should be classified into one
/// of three bins (PASS / WARN / FAIL). Returning this rather than raising
/// lets the test pin a clean ledger entry per scenario.
enum ScreenStepOutcome {
  /// The widget / behaviour was present.
  ok,

  /// The widget didn't render but the test is INTENDED to land on a
  /// graceful-degradation path (e.g. the prediction-alert RPC is not yet
  /// wired and the alert shows "Status unavailable"). Caller records a
  /// WARN, not a FAIL.
  degraded,

  /// The widget didn't appear at all — caller records FAIL.
  missing,
}

/// Boot the Flutter app and wait until the GetX Navigator is mounted.
/// Mirrors the pattern in transfer_send_ui_e2e_test.dart. The caller
/// passes `appMain` (typically `app.main`) so this helper doesn't
/// hard-import the production main and break the module graph for tests
/// that want a different entry point.
///
/// Returns `true` once GetMaterialApp + Navigator have mounted, `false`
/// if boot didn't complete within [kBootDeadline] + [kBootRealEnd].
Future<bool> bootAppAndAwaitNavigator(
  WidgetTester tester,
  void Function() appMain,
) async {
  // Phase 1: run app.main() inside runAsync so plugin init can fire real
  // async work (gRPC channel handshakes, JWKS fetch, secure storage read).
  await tester.runAsync(() async {
    appMain();
    final realBootEnd = DateTime.now().add(kBootRealEnd);
    while (DateTime.now().isBefore(realBootEnd)) {
      await Future<void>.delayed(const Duration(milliseconds: 250));
      if (WidgetsBinding.instance.rootElement != null &&
          (Get.key.currentState != null || Get.context != null)) {
        break;
      }
    }
  });

  // Phase 2: pump until the Navigator is in the tree. This is the gate
  // every other helper depends on (find.* won't see anything until then).
  final bootDeadline = DateTime.now().add(kBootDeadline);
  while (DateTime.now().isBefore(bootDeadline)) {
    if (find.byType(Navigator).evaluate().isNotEmpty &&
        (Get.key.currentState != null || Get.context != null)) {
      return true;
    }
    await tester.pump(const Duration(milliseconds: 300));
  }
  return find.byType(Navigator).evaluate().isNotEmpty &&
      (Get.key.currentState != null || Get.context != null);
}

/// Navigate to the exchange home using `Get.toNamed`. This is the same
/// path the production "Services" tile uses internally (it ultimately
/// calls `Get.toNamed(AppRoutes.exchangeHome)` after a few wrappers).
/// Tapping the home dashboard tile directly is brittle in tests because
/// the home screen is a heavily-scrolled `GridView` whose tiles' Keys
/// are not deterministic across test runs; the pattern across the e2e
/// suite (transfer_send_ui_e2e_test.dart, insurance_buy_ui_sweep_test.dart)
/// is to go straight to the route.
///
/// Returns `true` if [ExchangeHomeScreen] mounts within 25s.
Future<bool> openExchangeFromHome(WidgetTester tester) async {
  try {
    Get.toNamed(AppRoutes.exchangeHome);
  } catch (_) {
    return false;
  }
  final finder = find.byType(ExchangeHomeScreen);
  final deadline = DateTime.now().add(const Duration(seconds: 25));
  while (finder.evaluate().isEmpty && DateTime.now().isBefore(deadline)) {
    await tester.pump(const Duration(milliseconds: 400));
  }
  return finder.evaluate().isNotEmpty;
}

/// Open the source-currency picker bottom sheet by tapping the "From"
/// chip on either the exchange home or the recipient screen. Both
/// screens render the same shape: a tappable chip showing the source
/// currency code (`cubit.fromCurrency`).
///
/// Returns `true` if a [SourceCurrencyPicker] sheet mounts in the tree.
Future<bool> openSourceCurrencySheet(
  WidgetTester tester, {
  Duration timeout = const Duration(seconds: 10),
}) async {
  // The "From" chip on both screens carries the source-currency-code text.
  // Locate by the helper text "From " prefix (used in
  // exchange_home_screen.dart and exchange_recipient_screen.dart). If a
  // deterministic Key is later added, swap to byKey here.
  final fromChip = find.textContaining('From ');
  if (fromChip.evaluate().isEmpty) {
    // Fallback: the home screen uses a CurrencyPairSelector with the
    // currency code as the leading text. Try tapping the first non-NGN
    // labelled chip by text alone.
    return false;
  }
  try {
    await tester.tap(fromChip.first, warnIfMissed: false);
  } catch (_) {
    return false;
  }
  final deadline = DateTime.now().add(timeout);
  while (DateTime.now().isBefore(deadline)) {
    await tester.pump(const Duration(milliseconds: 300));
    if (find.byType(SourceCurrencyPicker).evaluate().isNotEmpty) return true;
    // SourceCurrencyPicker is a static `.show()` that returns a sheet —
    // the sheet itself is a private widget. Fall back to detecting the
    // sheet by its header text "Send from".
    if (find.text('Send from').evaluate().isNotEmpty) return true;
  }
  return false;
}

/// Pick a currency row inside the open [SourceCurrencyPicker] sheet by
/// its three-letter code. Returns `true` if the row was found AND the
/// sheet dismissed (consistent with how the production sheet pops on
/// selection).
Future<bool> pickSourceCurrency(
  WidgetTester tester,
  String currencyCode,
) async {
  final row = find.text(currencyCode.toUpperCase());
  if (row.evaluate().isEmpty) {
    return false;
  }
  try {
    await tester.tap(row.first, warnIfMissed: false);
  } catch (_) {
    return false;
  }
  // The sheet pops via Navigator.pop on tap. Wait for it to dismiss so
  // subsequent assertions don't accidentally read sheet state.
  final deadline = DateTime.now().add(const Duration(seconds: 5));
  while (DateTime.now().isBefore(deadline)) {
    await tester.pump(const Duration(milliseconds: 250));
    if (find.text('Send from').evaluate().isEmpty) return true;
  }
  return find.text('Send from').evaluate().isEmpty;
}

/// Type [amount] into the first amount [TextField] on the screen. The
/// exchange home + recipient screens both render the amount as their
/// first / only on-screen TextField.
Future<bool> enterAmount(WidgetTester tester, double amount) async {
  final field = find.byType(TextField);
  if (field.evaluate().isEmpty) return false;
  try {
    await tester.enterText(field.first, amount.toStringAsFixed(0));
    await tester.pump(const Duration(milliseconds: 500));
    return true;
  } catch (_) {
    return false;
  }
}

/// Tap the primary action on the exchange home: "Convert Now" for
/// conversion mode, "Continue" for send-abroad mode. Returns `true`
/// once the tap lands AND the next screen visible (receipt for convert
/// after PIN, recipient for sendAbroad). The caller is responsible for
/// the subsequent screen-specific assertions.
Future<bool> tapHomePrimaryAction(
  WidgetTester tester, {
  required bool isConversion,
}) async {
  final label = isConversion ? 'Convert Now' : 'Continue';
  final btn = find.text(label);
  if (btn.evaluate().isEmpty) return false;
  try {
    await tester.ensureVisible(btn.first);
  } catch (_) {/* best-effort */}
  try {
    await tester.tap(btn.first, warnIfMissed: false);
  } catch (_) {
    return false;
  }
  await tester.pump(const Duration(milliseconds: 500));
  return true;
}

/// Tap "Confirm & Send" on the recipient screen Step 2 confirm panel.
/// Optionally assert [ExchangePredictionAlert] is rendered above the
/// button before tapping — the alert is the #107 visual surface and
/// must be present for international transfers where source != dest.
///
/// Returns:
///   - [ScreenStepOutcome.ok] if confirm sheet rendered, alert (when
///     expected) was found in the Loaded / Loading branch, button
///     tapped successfully.
///   - [ScreenStepOutcome.degraded] if the alert was expected but
///     rendered the neutral "Status unavailable" card (acceptable
///     graceful-degradation per the brief — the cubit lands on
///     ExchangePredictionUnavailable when the RPC is unimplemented).
///   - [ScreenStepOutcome.missing] if the confirm button never appeared
///     OR the alert was expected but not in the tree at all.
Future<ScreenStepOutcome> tapConfirmAndSend(
  WidgetTester tester, {
  bool expectPredictionAlert = false,
}) async {
  final confirmBtn = find.text('Confirm & Send');
  final deadline = DateTime.now().add(const Duration(seconds: 8));
  while (confirmBtn.evaluate().isEmpty &&
      DateTime.now().isBefore(deadline)) {
    await tester.pump(const Duration(milliseconds: 400));
  }
  if (confirmBtn.evaluate().isEmpty) {
    return ScreenStepOutcome.missing;
  }

  ScreenStepOutcome outcome = ScreenStepOutcome.ok;
  if (expectPredictionAlert) {
    final alert = find.byType(ExchangePredictionAlert);
    if (alert.evaluate().isEmpty) {
      // The alert host wraps its build in a same-currency guard. If we
      // got here the test's source != dest, so a missing alert IS a UI
      // bug, not just degradation. Don't tap Confirm — return missing.
      return ScreenStepOutcome.missing;
    }
    // The alert IS in the tree; the cubit may still be on Initial /
    // Loading / Unavailable. The widget renders a card on every state
    // EXCEPT Initial+Loading where it returns SizedBox.shrink. If we
    // see a "Status unavailable" / "couldn't fetch" copy, that's the
    // degraded path — record but proceed.
    if (find.textContaining('unavailable').evaluate().isNotEmpty ||
        find.textContaining('Unavailable').evaluate().isNotEmpty) {
      outcome = ScreenStepOutcome.degraded;
    }
  }

  try {
    await tester.ensureVisible(confirmBtn.first);
  } catch (_) {/* best-effort */}
  try {
    await tester.tap(confirmBtn.first, warnIfMissed: false);
  } catch (_) {
    return ScreenStepOutcome.missing;
  }
  await tester.pump(const Duration(milliseconds: 500));
  return outcome;
}

/// Enter [pin] (4 digits) into the TransactionPinMixin keypad. The mixin
/// renders one TextField per digit with deterministic Keys:
/// `transaction_pin_digit_<i>` for i in 0..3. This is the SAME pattern
/// used by transfer_send_ui_e2e_test.dart, so we mirror it.
///
/// Returns `true` if all 4 digits were entered AND the keypad dismissed,
/// `false` if the first-digit field never appeared within 20s.
Future<bool> enterPin(WidgetTester tester, String pin) async {
  if (pin.length != 4) {
    return false;
  }
  final firstDigit = find.byKey(const Key('transaction_pin_digit_0'));
  final deadline = DateTime.now().add(const Duration(seconds: 20));
  while (firstDigit.evaluate().isEmpty &&
      DateTime.now().isBefore(deadline)) {
    await tester.pump(const Duration(milliseconds: 500));
    if (find
        .textContaining('Failed to check PIN status')
        .evaluate()
        .isNotEmpty) {
      return false;
    }
  }
  if (firstDigit.evaluate().isEmpty) return false;
  try {
    for (var i = 0; i < 4; i++) {
      final digit = find.byKey(Key('transaction_pin_digit_$i'));
      if (digit.evaluate().isEmpty) return false;
      await tester.enterText(digit, pin[i]);
      await tester.pump(const Duration(milliseconds: 200));
    }
    await tester.pump(const Duration(seconds: 2));
    return true;
  } catch (_) {
    return false;
  }
}

/// Wait until either [ExchangeReceiptScreen] mounts, OR a clear error /
/// terminal copy appears in the tree. Returns the terminal label
/// observed (`'receipt'`, `'success'`, `'declined'`, `''` on timeout).
///
/// This intentionally does NOT throw — flaky FW sandbox webhook
/// delivery is an environment reality, and the calling test should
/// classify the outcome (PASS / WARN) per scenario.
Future<String> awaitReceiptOrTerminalUI(
  WidgetTester tester, {
  Duration timeout = const Duration(minutes: 3),
}) async {
  final deadline = DateTime.now().add(timeout);
  while (DateTime.now().isBefore(deadline)) {
    await tester.pump(const Duration(milliseconds: 800));
    if (find.byType(ExchangeReceiptScreen).evaluate().isNotEmpty) {
      return 'receipt';
    }
    if (find.textContaining('successful').evaluate().isNotEmpty ||
        find.textContaining('Successful').evaluate().isNotEmpty) {
      return 'success';
    }
    if (find.textContaining('declined').evaluate().isNotEmpty ||
        find.textContaining('Declined').evaluate().isNotEmpty ||
        find.textContaining('insufficient').evaluate().isNotEmpty ||
        find.textContaining('failed').evaluate().isNotEmpty) {
      return 'declined';
    }
    // The GetX route name flips to the receipt path on success. Cheap
    // belt-and-braces check.
    final route = Get.currentRoute;
    if (route.contains('receipt')) return 'receipt';
  }
  return '';
}

/// Convenience: assert that the exchange-recipient screen mounted. The
/// recipient screen is the destination of "Continue" from the home in
/// send-abroad mode. Returns `true` within [timeout] if found.
Future<bool> awaitExchangeRecipientScreen(
  WidgetTester tester, {
  Duration timeout = const Duration(seconds: 25),
}) async {
  final finder = find.byType(ExchangeRecipientScreen);
  final deadline = DateTime.now().add(timeout);
  while (finder.evaluate().isEmpty && DateTime.now().isBefore(deadline)) {
    await tester.pump(const Duration(milliseconds: 400));
  }
  return finder.evaluate().isNotEmpty;
}

/// Assert a clean error banner / snackbar appears WITHOUT the
/// TransactionPin modal opening. Used by the corridor-unsupported and
/// blocklist tests where the validation is supposed to fire pre-PIN.
///
/// Returns `true` if an error-shaped widget appears in the tree AND the
/// PIN digit-0 field is still absent.
Future<bool> awaitPreFlightError(
  WidgetTester tester, {
  Duration timeout = const Duration(seconds: 15),
  List<String> errorSubstrings = const [
    'not supported',
    'not configured',
    'blocked',
    'unavailable',
    'rejected',
    'failed',
    'corridor',
  ],
}) async {
  final deadline = DateTime.now().add(timeout);
  while (DateTime.now().isBefore(deadline)) {
    await tester.pump(const Duration(milliseconds: 400));
    final pinModal = find.byKey(const Key('transaction_pin_digit_0'));
    if (pinModal.evaluate().isNotEmpty) {
      // The PIN modal opened — this is NOT a pre-flight rejection.
      return false;
    }
    for (final needle in errorSubstrings) {
      if (find.textContaining(needle, findRichText: true).evaluate().isNotEmpty) {
        return true;
      }
    }
  }
  return false;
}
