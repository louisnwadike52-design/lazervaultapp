import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/uplift/presentation/views/uplift_detail_screen.dart';

/// A closed fund must say what happened to the MONEY, not just why it closed.
///
/// The defect this pins: every expired or cancelled fund told the funder that
/// "anything in the pool that had not been released was refunded to your
/// wallet" — a fixed sentence attached to the status, with no reference to
/// whether anything had ever been committed.
///
/// Measured on production 2026-10-16: all four expired funds had
/// committed_pool = 0 and no escrow account, and `uplift_escrow_refunds` held
/// ZERO rows platform-wide. A funder read that sentence and went looking
/// through the refunds page for a refund that had never existed.
void main() {
  group('a fund nobody funded promises no refund', () {
    test('committed = 0 says there is nothing to refund, and says it plainly',
        () {
      final msg = upliftMoneyOutcome(
        committedKobo: 0,
        releasedKobo: 0,
        refundedKobo: 0,
        currency: 'NGN',
      );
      expect(msg, contains('nothing to refund'));
      // THE regression: it must not claim money came back.
      expect(msg.toLowerCase(), isNot(contains('returned to your wallet')));
      expect(msg.toLowerCase(), isNot(contains('on its way back')));
    });

    test('silence is not acceptable either — it must explain', () {
      expect(
        upliftMoneyOutcome(
            committedKobo: 0,
            releasedKobo: 0,
            refundedKobo: 0,
            currency: 'NGN'),
        contains('No money was committed'),
      );
    });
  });

  group('a fund that held money reports the real figure', () {
    test('a settled refund names the amount that came back', () {
      final msg = upliftMoneyOutcome(
        committedKobo: 50000, // ₦500
        releasedKobo: 0,
        refundedKobo: 50000,
        currency: 'NGN',
      );
      expect(msg, contains('was returned to your wallet'));
      expect(msg, contains('500'));
    });

    test('an unsettled refund does NOT claim the money already arrived', () {
      final msg = upliftMoneyOutcome(
        committedKobo: 50000,
        releasedKobo: 0,
        refundedKobo: 0,
        currency: 'NGN',
      );
      // Queued, not settled — the expensive direction of wrong is saying it
      // landed when the worker has not drained the row yet.
      expect(msg, contains('on its way back'));
      expect(msg, isNot(contains('was returned to your wallet')));
      expect(msg, contains('500'));
    });

    test('fully released to businesses is not a refund', () {
      final msg = upliftMoneyOutcome(
        committedKobo: 50000,
        releasedKobo: 50000,
        refundedKobo: 0,
        currency: 'NGN',
      );
      expect(msg, contains('already been released to businesses'));
      expect(msg, isNot(contains('returned to your wallet')));
    });

    test('partly released, remainder refunded, names the refund', () {
      final msg = upliftMoneyOutcome(
        committedKobo: 50000,
        releasedKobo: 30000,
        refundedKobo: 20000,
        currency: 'NGN',
      );
      expect(msg, contains('was returned to your wallet'));
      expect(msg, contains('200'));
    });
  });

  test('the four arms are mutually exclusive — no case falls through', () {
    final cases = <List<int>>[
      [0, 0, 0],
      [50000, 0, 0],
      [50000, 0, 50000],
      [50000, 50000, 0],
      [50000, 30000, 20000],
    ];
    for (final c in cases) {
      final msg = upliftMoneyOutcome(
        committedKobo: c[0],
        releasedKobo: c[1],
        refundedKobo: c[2],
        currency: 'NGN',
      );
      expect(msg.trim(), isNotEmpty,
          reason: 'committed=${c[0]} released=${c[1]} refunded=${c[2]} '
              'produced no sentence');
    }
  });
}
