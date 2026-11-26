import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// THE TWO PLACES THE APP USED TO REFUSE MONEY IT COULD HAVE SPENT.
///
/// Both were off-by-one-concept rather than off-by-one: each compared against
/// the whole amount when only the DIFFERENCE mattered, and each then told the
/// customer something that was true of the comparison and false of their
/// situation. Neither threw, neither logged, and neither would show up as a
/// failure anywhere — which is why they are pinned here as source-text
/// invariants rather than left to a behavioural test nobody writes.
void main() {
  String read(String p) => File(p).readAsStringSync();

  /// Containment that survives the formatter.
  ///
  /// TWO THINGS HAD TO BE NORMALISED, both learnt the hard way. `dart format`
  /// re-wraps any expression it likes, so all whitespace is dropped rather
  /// than merely collapsed — a space it inserted after an opening bracket is
  /// enough to fail an otherwise correct assertion. And a long string it wraps
  /// becomes two ADJACENT LITERALS, leaving a `''` seam in the middle of a
  /// sentence that is one string in the source and one string at runtime; that
  /// seam is removed too. A source-text test that breaks on reflow is a test
  /// people delete, which costs the invariant it was protecting.
  bool has(String haystack, String needle) {
    String flat(String s) => s
        .replaceAll(RegExp(r'\s+'), '')
        .replaceAll("''", '')
        .replaceAll('""', '');
    return flat(haystack).contains(flat(needle));
  }

  group('pay with crypto combines wallet and crypto', () {
    final sheet = read('lib/src/features/crypto_pay/presentation/'
        'pay_with_crypto_sheet.dart');

    test('each coin is judged against the shortfall, not the whole payment',
        () {
      // fund_mode = shortfall is the DEFAULT: the wallet pays what it can and
      // the conversion covers the rest. Gating on the full amount refused
      // exactly that — ₦2,000 held, ₦2,500 to pay, ₦1,000 of USDT was told
      // "not enough" when ₦500 was all that was needed.
      expect(has(sheet, 'a.fiatValueMinor >= neededMinor'), isTrue,
          reason: 'the gate must use the shortfall');
      expect(has(sheet, 'a.fiatValueMinor >= amountMinor'), isFalse,
          reason: 'gating on the full payment hides coins that would work');
    });

    test('an unknown balance falls back to the full amount, not to zero', () {
      // Unknown must be the CONSERVATIVE direction. Treating it as zero
      // available would ask the coin for the whole payment (safe); treating
      // it as covering everything would offer a coin that cannot fund the
      // conversion and refuse after the customer picked it.
      expect(has(sheet, 'if (held == null || held <= 0) return amountMinor;'),
          isTrue);
    });

    test('the shortfall can never go negative', () {
      expect(has(sheet, 'return short > 0 ? short : 0;'), isTrue,
          reason: 'a wallet that already covers it needs no conversion');
    });

    test('the selector resolves the balance so every surface combines', () {
      // The selector appears on both Send Funds flows and five bill quick-buy
      // sheets, and only the Send Funds screens have a balance in scope.
      final sel = read('lib/src/features/crypto_pay/presentation/'
          'pay_with_crypto_selector.dart');
      expect(has(sel, 'activeAccountSnapshot()'), isTrue,
          reason: 'AccountManager.activeAccountDetails is always null — that '
              'is the accessor that silently gave eighteen other places ₦0');
      expect(has(sel, 'walletBalanceMinor: _walletBalanceMinor'), isTrue);
    });
  });

  group('a send that is short offers to buy the difference', () {
    final screen = read('lib/src/features/crypto/presentation/view/'
        'send_crypto_screen.dart');

    test('the dead-end toast is gone', () {
      // It said what was wrong and nothing about fixing it, while the naira
      // to fix it sat in the wallet.
      final at = screen.indexOf('if (amount > _selected!.quantity)');
      expect(at, greaterThan(-1), reason: 'the balance check was renamed');
      final body = screen.substring(at, at + 900);
      expect(has(body, '_offerTopUp(amount)'), isTrue,
          reason: 'being short must offer the purchase');
    });

    test('only the difference is bought', () {
      expect(has(screen, 'final shortfall = wanted - holding.quantity;'),
          isTrue, reason: 'what the customer already holds is left alone');
      expect(has(screen, 'if (shortfall <= 0) return true;'), isTrue);
    });

    test('the holding is re-read before the send resumes', () {
      // The sheet returns true once the asset has landed, but the amount
      // DELIVERED is the exchange\'s, not ours. Sending over the new balance
      // must still be refused rather than attempted.
      final at = screen.indexOf('_offerTopUp(amount)');
      final body = screen.substring(at, at + 900);
      expect(has(body, 'await _refreshHoldings();'), isTrue);
      expect(has(body, 'if (amount > _selected!.quantity)'), isTrue,
          reason: 're-check after the top-up, do not assume the fill');
    });

    test('the refresh re-points the selection, not just the cubit', () {
      // _selected is a snapshot taken when the asset was picked, so
      // refreshing the cubit alone leaves this screen comparing the send
      // against the one number that just changed.
      expect(has(screen, 'setState(() => _selected = h);'), isTrue);
    });

    test('selection validity is checked against the sendable list', () {
      // Checking the HELD list would reject a coin just chosen at a zero
      // balance and auto-select something else, so the top-up path could
      // never be reached.
      expect(
          has(screen,
              'sendable.any((h) => h.cryptoId == _selected!.cryptoId)'),
          isTrue);
      expect(
          has(screen,
              'final hasValidSelection = _selected != null && holdings.any('),
          isFalse,
          reason: 'validity must not be judged on the held list alone');
    });

    test('a held coin is still preferred when the screen opens', () {
      expect(
          has(screen,
              '_selectAsset(holdings.isNotEmpty ? holdings.first : sendable.first);'),
          isTrue,
          reason: 'nothing about the common case may change');
    });
  });

  group('the purchase is its own authorisation', () {
    final sheet = read('lib/src/features/crypto/presentation/widgets/'
        'top_up_before_send_sheet.dart');

    test('the target is TO-denominated and rounded UP', () {
      // Converting the shortfall to naira at a snapshot price and buying that
      // instead lands a fraction short of what the customer typed, and the
      // send is refused a second time.
      expect(has(sheet, 'toAmountMinorUnits: _targetMinor'), isTrue);
      expect(has(sheet, 'fromAmountMinorUnits: 0'), isTrue,
          reason: 'zero FROM plus a TO target selects the backwards quote');
      expect(has(sheet, '.ceil()'), isTrue,
          reason: 'rounding down buys less than the send needs');
    });

    test('the PIN is raised per purchase and the token is single-use', () {
      expect(has(sheet, 'requestPin('), isTrue);
      expect(has(sheet, 'if (token == null || token.isEmpty)'), isTrue,
          reason: 'declining at the PIN must move nothing');
    });

    test('a still-pending purchase is never described as failed', () {
      // It cannot be cancelled. Saying it failed would be false about money
      // that has left the wallet.
      expect(has(sheet, "is on its way"), isTrue);
      expect(has(sheet, 'Navigator.of(context).pop(false);'), isTrue,
          reason: 'pending must not resume the send');
    });

    test('a failed purchase says the money did not leave', () {
      expect(has(sheet, 'Your money has not left your wallet.'), isTrue);
    });
  });
}
