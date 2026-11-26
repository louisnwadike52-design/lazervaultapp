import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// THE ORDER AND THE KEY ARE WHAT STOP MONEY BEING LOST.
///
/// A crypto sale is irreversible — the sub→master transfer at confirm is the
/// point of no return — so the client half has exactly two obligations:
///
///   1. Never ask for a conversion before the payment it funds exists. A
///      conversion with nothing waiting for it sells someone's crypto for an
///      errand nothing tracks, and it cannot be undone.
///   2. Derive the idempotency key from the payment reference. A fresh uuid
///      per attempt turns every retry into a second sale.
///
/// Source guards, because both properties live in the ORDER of two network
/// calls and in how one string is built. Neither is observable from a widget,
/// and a mock would only re-assert what the mock was told.
void main() {
  String read(String p) => File(p).readAsStringSync();

  final fund = read(
      'lib/src/features/crypto_pay/domain/fund_payment_with_crypto.dart');
  final ds = read(
      'lib/src/features/funds/data/datasources/payments_transfer_data_source.dart');

  test('the idempotency key is derived from the payment reference', () {
    expect(fund, contains(r"'fund:$paymentReference'"),
        reason: 'a generated key would make every retry a second conversion');
    for (final generated in ['Uuid(', 'uuid.v4', 'DateTime.now']) {
      expect(fund.contains(generated), isFalse,
          reason: '$generated in the key would break idempotency');
    }
  });

  test('funding always names the payment it funds', () {
    // Not optional and not defaulted: there is no funding "a payment" in the
    // abstract — the reference IS the thing being funded.
    expect(fund, contains('required String paymentReference'));
    expect(fund, contains('required int requiredMinor'));
    expect(fund, contains('required String asset'));
  });

  test('the ordering rule is recorded where it must not be undone', () {
    expect(fund, contains('ORDER IS THE SAFETY PROPERTY'));
    expect(fund.toLowerCase(), contains('authorised'));
  });

  test('a repeat is surfaced, not hidden', () {
    // The caller must be able to tell the original conversion coming back
    // from a new one, or a retry looks like a second sale in the UI.
    expect(fund, contains('alreadyExists'));
  });

  test('the asset travels as metadata, not a request field', () {
    // THE RULE MOVED, THE RULE DID NOT CHANGE. These headers are a contract
    // with seven server handlers — transfers, airtime, data, electricity,
    // cable TV, internet and water — so they live in ONE place now rather
    // than being copied into each data source, where they would drift. The
    // behaviour this test exists to protect is asserted at that one place,
    // and separately in crypto_funding_call_options_test.
    final helper = File(
      'lib/src/features/crypto_pay/data/funding_call_options.dart',
    ).readAsStringSync();
    expect(helper, contains("'x-funding-source': 'crypto'"));
    expect(helper, contains("'x-funding-asset': normalised"));
    // "crypto" with no coin cannot be priced; the server refuses it, so the
    // app must never send it.
    expect(helper, contains('if (normalised.isEmpty) return this;'));

    // And the transfer path must actually go through it rather than keeping
    // a private copy that could diverge.
    expect(ds, contains('withCryptoFunding(fundingAsset)'));
    expect(ds, isNot(contains("'x-funding-source'")),
        reason: 'a second copy of the header rule is how the two drift');
  });
}
