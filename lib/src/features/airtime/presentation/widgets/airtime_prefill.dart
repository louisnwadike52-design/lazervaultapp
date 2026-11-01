import 'package:flutter/foundation.dart';

/// A repeat-purchase hand-off to an airtime screen that is ALREADY OPEN.
///
/// THE TWO BUGS THIS FIXES, which are one bug.
///
/// Repeat Purchase navigated with `Get.toNamed(AppRoutes.airtime,
/// preventDuplicates: false)`, carrying the phone, amount and network as
/// route arguments. Those arguments are read in `initState`, so they only
/// land when a NEW quick-buy widget is constructed — which is exactly why
/// `preventDuplicates: false` was there.
///
/// But the sheet is most often opened from the recent-transactions card ON
/// the airtime screen. So "repeat" pushed a SECOND airtime screen on top of
/// the one the user was already looking at: the reported "repeat purchase
/// seems like a new screen showing", with a back stack that now needs two
/// pops to leave.
///
/// Prefill tied to construction is what forced the duplicate. Decoupling them
/// fixes both: an open screen takes the values through here and the caller
/// returns to it instead of stacking another copy.
@immutable
class AirtimePrefillRequest {
  const AirtimePrefillRequest({this.phone, this.amount, this.networkCode});

  final String? phone;
  final double? amount;
  final String? networkCode;

  bool get isEmpty =>
      (phone == null || phone!.trim().isEmpty) &&
      (amount == null || amount! <= 0) &&
      (networkCode == null || networkCode!.trim().isEmpty);
}

/// Carries a prefill to whichever quick-buy is mounted.
///
/// Modelled on [AirtimeScreen.dataChangedTick], the cross-route nudge this
/// feature already uses — same shape, so there is one way to poke this screen
/// from elsewhere rather than two.
class AirtimePrefillSignal {
  AirtimePrefillSignal._();

  /// Bumped on every request so two identical repeats in a row are two
  /// events. A ValueNotifier holding the request alone would swallow the
  /// second: `==` on an identical const value notifies nobody, and tapping
  /// "repeat" twice would silently do nothing the second time.
  static final ValueNotifier<int> revision = ValueNotifier<int>(0);

  static AirtimePrefillRequest? _pending;

  /// The request that came with the current [revision].
  static AirtimePrefillRequest? get pending => _pending;

  static void emit(AirtimePrefillRequest request) {
    if (request.isEmpty) return;
    _pending = request;
    revision.value++;
  }

  /// Cleared once applied, so a later rebuild cannot re-apply a stale repeat
  /// over something the user has since typed.
  static void consume() => _pending = null;
}
