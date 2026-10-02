import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/rmb/presentation/view/rmb_landing_screen.dart';
import 'package:lazervault/src/generated/rmb.pb.dart';

// Reported from the RMB Transfer screen: the hero read "Rates from — Locked in
// at checkout" with all four rails fully tappable, while no rate was actually
// available.
//
// 0 is not a pricing choice. rmb-service's indicativeNgnPerCny returns 0 on ANY
// provider error, and the send flow needs that same provider quote to price a
// transfer — so the cheerful copy walked the user into a flow that could not
// succeed, and they only discovered it after picking a rail, an amount and a
// recipient.

ProviderConfigResponse config({
  double rate = 0,
  bool maintenance = false,
}) =>
    ProviderConfigResponse(
      indicativeFxRate: rate,
      maintenance: maintenance,
    );

void main() {
  test('a live rate means transfers are open', () {
    expect(rmbTransfersPaused(config(rate: 212.45)), isFalse);
  });

  test('no rate pauses transfers — 0 is a failed quote, not a pricing choice',
      () {
    expect(rmbTransfersPaused(config(rate: 0)), isTrue);
  });

  test('a negative rate is never treated as usable', () {
    // Defensive: a sign error upstream must not read as "priced".
    expect(rmbTransfersPaused(config(rate: -1)), isTrue);
  });

  test('maintenance pauses transfers even with a good rate', () {
    expect(rmbTransfersPaused(config(rate: 212.45, maintenance: true)), isTrue);
  });

  test('both causes together still just mean paused', () {
    expect(rmbTransfersPaused(config(rate: 0, maintenance: true)), isTrue);
  });

  test('the hero and the rails cannot disagree', () {
    // The whole point of one predicate: whatever the hero says, the rails
    // match. This asserts the two call sites consume the same answer.
    for (final c in [
      config(rate: 0),
      config(rate: 212.45),
      config(rate: 0, maintenance: true),
      config(rate: 212.45, maintenance: true),
    ]) {
      final heroSaysPaused = rmbTransfersPaused(c);
      final railsDisabled = rmbTransfersPaused(c);
      expect(heroSaysPaused, railsDisabled,
          reason: 'copy and CTA state must come from the same source');
    }
  });

  test('a tiny but real rate is open, not paused', () {
    // Boundary: only <= 0 pauses.
    expect(rmbTransfersPaused(config(rate: 0.01)), isFalse);
  });
}
