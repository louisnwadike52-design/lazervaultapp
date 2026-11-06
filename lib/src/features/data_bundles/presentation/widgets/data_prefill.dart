import 'package:flutter/foundation.dart';

/// A Repeat Purchase hand-off to the one-page data buy.
///
/// WHY THIS EXISTS, same reason airtime has one (see airtime_prefill.dart):
/// route arguments are read at construction, and this sheet is usually opened
/// from the recent-purchases card that sits ON the data screen. The only way
/// to deliver arguments to a screen that is already in the stack is to push a
/// SECOND copy of it over the one the user is looking at — which reads as
/// "repeat opened a new screen" and leaves a back stack needing two pops.
///
/// Repeat for data had a second problem airtime did not: it navigated to the
/// plan-SELECTION screen and then auto-advanced to the recipient screen, so
/// "repeat" was a two-screen walk even when it worked. The ask was for the
/// data page with everything filled and nothing left but Continue, exactly
/// like airtime.
class DataPrefillRequest {
  const DataPrefillRequest({this.phone, this.networkCode, this.planId});

  final String? phone;

  /// The DATA CATALOGUE code (`mtn-data`), not the bare ticker — the plan
  /// fetch accepts nothing else.
  final String? networkCode;

  /// The bundle's `variation_id`. Matched against the LIVE plan list rather
  /// than rebuilt from the history row, so a repeat always quotes today's
  /// price and a withdrawn bundle leaves the picker open instead of selling
  /// something that no longer exists.
  final String? planId;

  bool get isEmpty =>
      (phone == null || phone!.trim().isEmpty) &&
      (networkCode == null || networkCode!.trim().isEmpty) &&
      (planId == null || planId!.trim().isEmpty);
}

/// Carries a prefill to whichever data quick-buy is mounted.
class DataPrefillSignal {
  DataPrefillSignal._();

  /// Bumped on every request so two identical repeats in a row are two
  /// events. A ValueNotifier holding the request alone would swallow the
  /// second: `==` on an identical value notifies nobody, and tapping
  /// "repeat" twice would silently do nothing the second time.
  static final ValueNotifier<int> revision = ValueNotifier<int>(0);

  static DataPrefillRequest? _pending;

  /// The request that came with the current [revision].
  static DataPrefillRequest? get pending => _pending;

  static void emit(DataPrefillRequest request) {
    if (request.isEmpty) return;
    _pending = request;
    revision.value++;
  }

  /// Cleared once applied, so a later rebuild cannot re-apply a stale repeat
  /// over something the user has since typed.
  static void consume() => _pending = null;
}
