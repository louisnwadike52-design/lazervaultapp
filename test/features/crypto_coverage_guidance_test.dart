import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/crypto_pay/domain/pay_source.dart';
import 'package:lazervault/src/features/crypto_pay/presentation/crypto_coverage_dialog.dart';

/// TELLING SOMEONE THEIR COIN IS NOT ENOUGH, BEFORE THEY COMMIT.
///
/// Selling crypto is irreversible, so "that was not enough" is the worst
/// thing to learn after the PIN. The server refuses the case correctly; this
/// is about the customer being asked while they can still do something about
/// it. Every branch below decides whether a conversion starts, so the safe
/// direction — let the server decide, do not refuse locally — matters more
/// than being clever.
void main() {
  group('what the coin covers', () {
    test('a coin worth more than the payment needs no dialog', () {
      expect(
        assessCoverage(amountMinor: 50000, coinValueMinor: 90000, walletMinor: 0),
        CryptoCoverage.covers,
      );
    });

    test('exactly the payment is still covered, not partial', () {
      // An off-by-one here puts a dialog in front of somebody whose coin is
      // precisely enough.
      expect(
        assessCoverage(amountMinor: 50000, coinValueMinor: 50000, walletMinor: 0),
        CryptoCoverage.covers,
      );
    });

    test('part-covered with a wallet that can finish it is PARTIAL', () {
      // The case the operator described: take what the coin is worth, the
      // rest from fiat.
      expect(
        assessCoverage(
            amountMinor: 50000, coinValueMinor: 30000, walletMinor: 20000),
        CryptoCoverage.partial,
      );
    });

    test('neither covering it is INSUFFICIENT', () {
      expect(
        assessCoverage(
            amountMinor: 50000, coinValueMinor: 30000, walletMinor: 5000),
        CryptoCoverage.insufficient,
      );
    });

    test('a wallet exactly covering the remainder is partial, not short', () {
      expect(
        assessCoverage(
            amountMinor: 50000, coinValueMinor: 30000, walletMinor: 20000),
        CryptoCoverage.partial,
      );
    });
  });

  group('what cannot be claimed is not claimed', () {
    test('an unpriceable coin is UNKNOWN, and must not refuse', () {
      // A ticker outage must never decline a payment the customer could make.
      // The server makes the real decision.
      expect(
        assessCoverage(amountMinor: 50000, coinValueMinor: null, walletMinor: 0),
        CryptoCoverage.unknown,
      );
      expect(
        assessCoverage(amountMinor: 50000, coinValueMinor: 0, walletMinor: 0),
        CryptoCoverage.unknown,
      );
    });

    test('an unreadable wallet gives the customer the benefit of the doubt',
        () {
      // A wallet we could not read is NOT a wallet with nothing in it.
      // Treating null as zero would refuse a perfectly fundable payment.
      expect(
        assessCoverage(
            amountMinor: 50000, coinValueMinor: 30000, walletMinor: null),
        CryptoCoverage.partial,
      );
    });

    test('a zero amount is unknown rather than covered', () {
      // Nothing to assert about a payment that has no amount yet.
      expect(
        assessCoverage(amountMinor: 0, coinValueMinor: 30000, walletMinor: 0),
        CryptoCoverage.unknown,
      );
    });
  });

  group('the source carries what the picker saw', () {
    test('a coin keeps its indicative value', () {
      const s = PaySource.crypto('usdt', assetFiatValueMinor: 123456);
      expect(s.assetFiatValueMinor, 123456);
      expect(s.isCrypto, isTrue);
    });

    test('the wallet source has no coin value at all', () {
      expect(PaySource.wallet.assetFiatValueMinor, isNull);
    });

    test('value is part of equality, so a re-price is a real change', () {
      // Without this, picking the same coin after its price moved would
      // compare equal and the amount screen would keep validating against a
      // stale figure.
      expect(
        const PaySource.crypto('usdt', assetFiatValueMinor: 100) ==
            const PaySource.crypto('usdt', assetFiatValueMinor: 200),
        isFalse,
      );
    });
  });
}
