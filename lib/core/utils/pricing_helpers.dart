import 'dart:math' as math;

/// Client mirror of the server's [PresentationPricing] helper
/// (`internal/service/pricing_helpers.go`). Used across the bill-payment
/// flows (data, cable TV, internet, education) to display a round-NGN
/// amount to the user while the raw catalog price (e.g. 49.99) is still
/// sent to the backend.
///
/// Why mirror server-side logic on the client:
///  * UIs need to render the rounded price BEFORE any RPC round-trip
///    — plan selection, confirmation, processing screens all render
///    from the in-memory entity.
///  * Keeping the math in one Dart function avoids drift between screens.
///  * Server remains the source of truth for the charge: it re-derives
///    presentation + markup when processing the purchase, so a stale
///    client copy can't be exploited to underpay.
double roundUpToNearestTen(double amount) {
  if (amount <= 0) return 0;
  return (math.max<num>(1, (amount / 10).ceil()) * 10).toDouble();
}
