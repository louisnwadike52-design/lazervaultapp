import 'package:get/get.dart';

import '../../../../../core/services/injection_container.dart';
import '../../../../../core/types/app_routes.dart';
import '../../cubit/transaction_pin_cubit.dart';

/// Resolve the PIN step BEFORE navigating to it, so the user waits once.
///
/// ## The second loading screen
///
/// `TransactionPinSetupScreen` asks the server, on mount, whether this user
/// already has a PIN — authoritatively, with `forceRefresh`, because a stale
/// cached "yes" would skip setup and strand somebody with no PIN. While that
/// round trip is in flight it renders a full-black page with a centred logo.
///
/// Arriving from the email-OTP step that meant two waits for one decision:
/// the Verify spinner, then a black screen that reads like the app relaunching,
/// and only then the keypad. The check is right; paying for it there is not.
///
/// This runs the same check behind the CALLER's existing spinner — the one the
/// user is already watching — and the caller passes the answer forward in the
/// route arguments. The PIN screen then paints on its first frame.
///
/// ## What this deliberately does not do
///
/// It never decides anything. A failure, a timeout, or a caller that does not
/// use it all leave the PIN screen asking for itself, exactly as before, so
/// the authoritative check still happens on every path — it is simply skipped
/// when a fresh answer already exists. Returning null is a normal outcome and
/// means "navigate without arguments".
Future<bool?> prefetchHasTransactionPin({
  Duration timeout = const Duration(seconds: 6),
}) async {
  try {
    final cubit = serviceLocator<TransactionPinCubit>();
    await cubit.checkUserHasPin(forceRefresh: true).timeout(timeout);
    // The cubit swallows its own errors into `errorMessage` rather than
    // throwing, so a failed call leaves `hasPin` at its default false — which
    // would be read as "no PIN, go straight to setup". That is the wrong
    // conclusion to draw from a network failure on a screen whose whole job is
    // to be authoritative, so an error means "unknown" and the PIN screen asks
    // again itself.
    if (cubit.state.errorMessage != null) return null;
    return cubit.state.hasPin;
  } catch (_) {
    return null;
  }
}

/// Route arguments carrying a prefetched answer, or null when there isn't one.
///
/// Merged with any arguments the caller already passes (`returnOnComplete`,
/// for instance) rather than replacing them.
Map<String, dynamic> pinSetupArgs(bool? hasPin, [Map<String, dynamic>? extra]) {
  return {
    ...?extra,
    if (hasPin != null) ...{'pinCheckDone': true, 'hasPin': hasPin},
  };
}

/// Continue an ONBOARDING flow into the PIN step, having resolved it first.
///
/// Uses `offAllNamed` because every caller of this is a forward-only signup
/// step with nothing to pop back to. A mid-flow push that must return to its
/// caller (a payment needing a PIN) is a different shape and keeps using
/// `Get.toNamed` with `returnOnComplete` — do not route those through here.
Future<void> continueToPinSetup({Map<String, dynamic>? extra}) async {
  final hasPin = await prefetchHasTransactionPin();
  await Get.offAllNamed(
    AppRoutes.transactionPinSetup,
    arguments: pinSetupArgs(hasPin, extra),
  );
}
