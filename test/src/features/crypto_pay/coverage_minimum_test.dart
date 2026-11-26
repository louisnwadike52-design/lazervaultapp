import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/crypto_pay/presentation/crypto_coverage_dialog.dart';

/// A PAYMENT UNDER THE FLOOR CANNOT BE FUNDED BY SELLING CRYPTO.
///
/// crypto-service refuses it with `below_minimum`, but only after the customer
/// has chosen a coin, read a split and entered their PIN — and a refusal
/// earned that way reads as a failed payment rather than a rule. Reported from
/// a ₦223 transfer whose sheet offered Confirm on 0.1549 USDT.
void main() {
  const min = 100000; // ₦1,000, the live crypto.min_order.ngn.minor_units

  group('below the minimum', () {
    test('is reported even when the coin covers the payment outright', () {
      expect(
        assessCoverage(
          amountMinor: 22300, // ₦223
          coinValueMinor: 5000000, // plenty of coin
          walletMinor: 0,
          minFiatMinor: min,
        ),
        CryptoCoverage.belowMinimum,
      );
    });

    // THE REPORTED CASE. The wallet covering it does not make a ₦223
    // conversion possible, and walletAlreadyCovers would have offered Confirm.
    test('wins over walletAlreadyCovers', () {
      expect(
        assessCoverage(
          amountMinor: 22300,
          coinValueMinor: 5000000,
          walletMinor: 762063, // ₦7,620.63, as in the report
          minFiatMinor: min,
        ),
        CryptoCoverage.belowMinimum,
      );
    });

    test('wins over insufficient, which would say the wrong thing', () {
      expect(
        assessCoverage(
          amountMinor: 22300,
          coinValueMinor: 100,
          walletMinor: 0,
          minFiatMinor: min,
        ),
        CryptoCoverage.belowMinimum,
      );
    });

    test('exactly at the floor is allowed through', () {
      expect(
        assessCoverage(
          amountMinor: min,
          coinValueMinor: 5000000,
          walletMinor: 0,
          minFiatMinor: min,
        ),
        isNot(CryptoCoverage.belowMinimum),
      );
    });
  });

  group('the floor never invents a refusal', () {
    // A client that refused on a rule the server does not have would decline
    // payments the server would have taken.
    test('an unknown floor (0) changes nothing', () {
      expect(
        assessCoverage(
          amountMinor: 22300,
          coinValueMinor: 5000000,
          walletMinor: 0,
          minFiatMinor: 0,
        ),
        CryptoCoverage.covers,
      );
    });

    test('omitting it entirely preserves the old behaviour', () {
      expect(
        assessCoverage(
          amountMinor: 22300,
          coinValueMinor: 5000000,
          walletMinor: 762063,
        ),
        CryptoCoverage.walletAlreadyCovers,
      );
    });

    test('a payment above the floor is assessed normally', () {
      expect(
        assessCoverage(
          amountMinor: 500000, // ₦5,000
          coinValueMinor: 200000,
          walletMinor: 400000,
          minFiatMinor: min,
        ),
        CryptoCoverage.partial,
      );
    });
  });
}
