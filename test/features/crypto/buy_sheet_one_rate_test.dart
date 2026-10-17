import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// ONE RATE PER SCREEN.
///
/// Reported from production: the buy sheet quoted "1 USDT ≈ 1,378 NGN" and
/// charged ₦275,509.73 for 200 USDT (₦1,377.55/USDT), while the limits hint
/// read "Min 1 USDT (≈₦1402)". The parenthetical looked like a conversion and
/// was not — ₦1402 is 1 USDT × rate × 1.02, the deliverability headroom that
/// [_minFiat] adds so rate drift between quote refreshes cannot land a buy
/// just under Quidax's network minimum.
///
/// The headroom is legitimate; presenting it as an exchange rate is not. The
/// fix derives the displayed crypto minimum from the ENFORCED fiat minimum at
/// the quoted rate, so minFiat / minCrypto is always the quoted rate no matter
/// which floor binds.
void main() {
  String read(String p) => File(p).readAsStringSync();

  const buy = 'lib/src/features/crypto/presentation/view/buy_crypto_sheet.dart';
  const sell =
      'lib/src/features/crypto/presentation/view/sell_crypto_sheet.dart';

  test('the buy sheet derives its crypto minimum from the fiat minimum', () {
    final s = read(buy);
    final i = s.indexOf('double _minCrypto()');
    expect(i, greaterThan(-1), reason: '_minCrypto is gone');
    final body = s.substring(i, s.indexOf('\n  }', i));
    expect(body, contains('minFiat / rate'),
        reason: 'the displayed crypto minimum must be the enforced fiat '
            'minimum divided by the QUOTED rate, or the pair shows a second '
            'exchange rate the user cannot reproduce');
  });

  test('the raw deliverability floor is only a no-rate fallback', () {
    // Returning it unconditionally is the original defect: it is not padded,
    // while the fiat half of the same label is.
    final s = read(buy);
    final i = s.indexOf('double _minCrypto()');
    final body = s.substring(i, s.indexOf('\n  }', i));
    final fallbackAt = body.indexOf('minDeliverableFor');
    final derivedAt = body.indexOf('minFiat / rate');
    expect(fallbackAt, greaterThan(derivedAt),
        reason: 'the derived value must come FIRST; the raw floor is only for '
            'when there is no live rate yet');
  });

  test('the headroom still exists — this fixes the display, not the floor', () {
    // Removing the 2% would let a buy execute and auto-refund when the rate
    // drifts between the quote and the confirm.
    expect(read(buy), contains('* 1.02'),
        reason: 'the deliverability headroom must remain in _minFiat');
  });

  test('the sell sheet already derived it the same way', () {
    // Sell was correct all along: minC = min / price. Buy now matches it, and
    // this asserts they cannot diverge again.
    expect(read(sell), contains('min / price'),
        reason: 'sell derives its crypto minimum from the fiat minimum at the '
            'quoted price; buy must use the same construction');
  });
}
