import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/config/feature_flags.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// THE CONTRIBUTION THAT MADE THE CUSTOMER WATCH IT.
///
/// Reported as "why's the processing stage in crowdfund that slow". The RPC
/// is not faster either way — what was wrong is that a dedicated full-screen
/// route owned the wait, with its own watchdog and its own retry panel, while
/// the send-funds flow has always handed the customer a receipt immediately
/// and settled it in place.
///
/// So the processing screen is out of the flow, the receipt opens on a local
/// pending row, and the outcome lands on the receipt itself.
void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await FeatureFlags.init();
  });

  final payment = File(
          'lib/src/features/crowdfund/presentation/views/donation_payment_screen.dart')
      .readAsStringSync();
  final receipt = File(
          'lib/src/features/crowdfund/presentation/views/donation_receipt_screen.dart')
      .readAsStringSync();

  test('async is the default, and it is a dial', () async {
    expect(FeatureFlags.crowdfundAsyncContribution, isTrue,
        reason: 'nobody has chosen, and the fast path is the default');

    await FeatureFlags.applyRemoteSnapshot(
        {'${FeatureFlags.crowdfundAsyncPrefix}_available': 'false'});
    expect(FeatureFlags.crowdfundAsyncContribution, isFalse,
        reason: 'the sync path must stay one console switch away');

    await FeatureFlags.applyRemoteSnapshot(
        {'${FeatureFlags.crowdfundAsyncPrefix}_available': 'true'});
    expect(FeatureFlags.crowdfundAsyncContribution, isTrue);
  });

  test('the payment screen goes to the receipt, not a processing screen', () {
    // ANCHORED on the navigation itself. A grep for the class name alone
    // would match the import that still supplies DonationAttempt.
    expect(payment, contains('child: DonationReceiptScreen('),
        reason: 'the PIN sheet hands straight over to the receipt');
    expect(payment, isNot(contains('child: DonationProcessingScreen(')),
        reason: 'the processing screen is no longer in the contribution flow');
  });

  test('who waits follows the dial', () {
    expect(
        payment,
        contains(
            'showProcessingPhase: !FeatureFlags.crowdfundAsyncContribution'),
        reason: 'async: nobody waits. sync: the PIN sheet does — it is the '
            'only honest place left once the processing screen is gone');
  });

  test('the receipt never claims success before the money moves', () {
    expect(receipt, isNot(contains("'Donation Successful'")),
        reason: 'this was unconditional, and the screen now opens while the '
            'debit is still in flight');
    expect(receipt, contains('String get _statusTitle'));
    expect(receipt, contains('bool get _pending'));
  });

  test('a pending receipt cannot be filed or sent', () {
    expect(receipt, contains('final canFile = _completed;'),
        reason: 'a PDF minted mid-flight reads to its recipient as proof of a '
            'contribution that may not have happened');
  });

  test('the brand appears once, at the top', () {
    expect(receipt, contains('const ReceiptBrandMark()'));
    expect(receipt,
        isNot(contains("Text(\n                                'Lazervault',")),
        reason: 'the wordmark under the amount was a second copy of the one '
            'in the top-right');
  });

  test('the crowdfund facts survive into the shared receipt', () {
    // The generator type-checks List<MapEntry<String,String>> and silently
    // drops anything else — a Map here would be accepted and ignored.
    expect(receipt, contains("'extraRows': <MapEntry<String, String>>["));
    for (final row in const ['Campaign', 'Campaign code', 'Creator']) {
      // dart format may break the MapEntry across lines, so match the label
      // rather than the call shape.
      expect(receipt, contains("'$row',"),
          reason: '\$row is what makes this a crowdfund receipt');
    }
  });
}
