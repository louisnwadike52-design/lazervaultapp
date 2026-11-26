import 'package:flutter_test/flutter_test.dart';
import 'package:grpc/grpc.dart';
import 'package:lazervault/src/features/crypto_pay/data/funding_call_options.dart';

/// The headers are a contract with seven server handlers. These pin it.
void main() {
  test('a chosen coin travels as the two agreed headers, lowercased', () {
    final o = CallOptions().withCryptoFunding('  USDT ');
    expect(o.metadata['x-funding-source'], 'crypto');
    expect(o.metadata['x-funding-asset'], 'usdt');
  });

  test('a wallet-funded call is left exactly as it was', () {
    // The ordinary path must go out unchanged. A stray header here would sell
    // a customer's crypto for a purchase they asked to pay from their wallet.
    for (final blank in [null, '', '   ']) {
      final o = CallOptions(metadata: {'x-existing': 'kept'})
          .withCryptoFunding(blank);
      expect(o.metadata.containsKey('x-funding-source'), isFalse,
          reason: 'blank: "$blank"');
      expect(o.metadata.containsKey('x-funding-asset'), isFalse);
      expect(o.metadata['x-existing'], 'kept');
    }
  });

  test('existing metadata survives', () {
    final o = CallOptions(metadata: {'x-account-id': 'acct-1'})
        .withCryptoFunding('btc');
    expect(o.metadata['x-account-id'], 'acct-1');
    expect(o.metadata['x-funding-asset'], 'btc');
  });
}
