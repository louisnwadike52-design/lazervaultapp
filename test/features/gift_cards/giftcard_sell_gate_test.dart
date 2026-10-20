import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// THE SELL TAB IS OFF UNTIL AN OPERATOR TURNS IT ON.
///
/// Selling is the side with the manual settlement queue, the per-brand sell
/// rates and the reversal path behind it, so the tab stays closed until that
/// is staffed. The gate is the generic feature family, which brings a
/// whitelist with it — the people running a pilot keep access while it stays
/// hidden from everyone else.
///
/// Three doors have to agree, and this pins all three: the toggle that
/// switches tabs, the content behind it, and a deep link carrying
/// initialTab=sell.
void main() {
  String strip(String src) => src
      .split('\n')
      .where((l) => !l.trimLeft().startsWith('//'))
      .join('\n');

  final screen = strip(File(
          'lib/src/features/gift_cards/presentation/view/gift_cards_screen.dart')
      .readAsStringSync());
  final flags =
      strip(File('lib/core/config/feature_flags.dart').readAsStringSync());

  test('the gate is default OFF', () {
    expect(
        flags.contains(
            "gateAllowed(giftcardSellPrefix, email: email, defaultOn: false)"),
        isTrue,
        reason: 'defaulting ON would ship the Sell tab to everyone the moment '
            'a settings fetch failed');
    expect(flags.contains("giftcardSellPrefix = 'feature_giftcard_sell'"), isTrue,
        reason: 'the prefix is what the dashboard builds its keys from — '
            'feature_giftcard_sell_(available|whitelist|message)');
  });

  test('the tab toggle is hidden when the gate is off', () {
    expect(screen.contains('if (_sellVisible) _buildBuySellToggle()'), isTrue,
        reason: 'the Buy/Sell toggle must disappear, not just its content');
  });

  test('the deep link cannot open the hidden tab', () {
    // Landing on a hidden tab leaves the user with no way back, because the
    // control that switches tabs is the thing being hidden.
    final i = screen.indexOf('_sellVisible &&');
    expect(i, greaterThan(-1),
        reason: 'initialTab=sell is honoured without checking the gate');
    final around = screen.substring(i, (i + 220).clamp(0, screen.length));
    expect(around.contains("initialTab"), isTrue);
  });

  test('the gate is read once, not re-read mid-screen', () {
    // late final: re-reading per build would let the tab appear or vanish
    // under the user's finger when a settings poll lands.
    expect(screen.contains('late final bool _sellVisible'), isTrue);
  });
}
