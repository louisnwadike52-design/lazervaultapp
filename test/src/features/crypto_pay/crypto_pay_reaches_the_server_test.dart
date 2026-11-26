import 'package:flutter_test/flutter_test.dart';
import 'package:grpc/grpc.dart';
import 'package:lazervault/src/features/crypto_pay/data/funding_call_options.dart';
import 'package:lazervault/src/features/crypto_pay/domain/crypto_quote_preview.dart';
import 'package:lazervault/src/features/crypto_pay/domain/pay_source.dart';

void main() {
  group('the funding headers the whole feature depends on', () {
    // WHY THIS IS THE FIRST TEST IN THE FILE.
    //
    // Pay with Crypto was completely unreachable in production and nothing
    // failed: the app set these two headers, every gateway rebuilt its
    // outgoing metadata from a closed allow-list that did not include them,
    // and seven server handlers therefore never saw them. Each payment took
    // the ordinary wallet path and failed on insufficient funds.
    //
    // A customer testing it with a deliberately emptied wallet hit it on
    // every surface — airtime, data and transfer all "bounced back" — and the
    // zero rows in crypto_funded_payments had been read as "live but unused"
    // when it was "live but impossible".
    //
    // The header NAMES are the contract. A rename here without the matching
    // change in eight gateways and seven handlers puts the feature straight
    // back into that state, silently.
    test('the names are exactly what the servers read', () {
      final opts = CallOptions().withCryptoFunding('usdt');
      expect(opts.metadata['x-funding-source'], 'crypto');
      expect(opts.metadata['x-funding-asset'], 'usdt');
    });

    test('the coin is normalised, so casing cannot miss a server allow-list',
        () {
      final opts = CallOptions().withCryptoFunding('  USDT  ');
      expect(opts.metadata['x-funding-asset'], 'usdt');
    });

    // EMPTY MEANS UNCHANGED. A wallet-funded call must go out byte-for-byte
    // as it did before this feature existed — a stray header would sell a
    // customer's crypto for a purchase they asked to pay for from their
    // wallet.
    for (final blank in <String?>[null, '', '   ']) {
      test('${blank == null ? 'null' : '"$blank"'} adds no header', () {
        final opts = CallOptions().withCryptoFunding(blank);
        expect(opts.metadata.containsKey('x-funding-source'), isFalse);
        expect(opts.metadata.containsKey('x-funding-asset'), isFalse);
      });
    }
  });

  group('the chosen coin travels with the choice', () {
    // The preview used to be built on the conversion sheet and thrown away —
    // only the symbol survived. Everything downstream (the PIN sheet, the
    // failure copy, the receipt, the shared PDF) then had no split to show.
    test('a crypto source carries its quote', () {
      final quote = CryptoQuotePreview.build(
        asset: 'usdt',
        amountMinor: 117500, // the reported ₦1,175.00
        coinValueMinor: 300000,
        balance: '2',
      );
      final source = PaySource.crypto('usdt',
          assetBalance: '2', assetFiatValueMinor: 300000, quote: quote);

      expect(source.isCrypto, isTrue);
      expect(source.quote, isNotNull);
      expect(source.sellQuantity, isNotNull);
      // The coin covers it all, so nothing is taken from the wallet.
      expect(source.walletTopUpMinor, 0);
      expect(source.isSplitFunded, isFalse);
    });

    test('a coin worth less than the payment reports the wallet top-up', () {
      final quote = CryptoQuotePreview.build(
        asset: 'usdt',
        amountMinor: 117500,
        coinValueMinor: 100000, // only ₦1,000 of coin
        balance: '0.6',
      );
      final source = PaySource.crypto('usdt', quote: quote);

      expect(source.isSplitFunded, isTrue,
          reason: 'the customer must be told their wallet finishes the job '
              'BEFORE the PIN, not from a balance that moved afterwards');
      expect(source.walletTopUpMinor, 17500);
      expect(quote.fromCryptoMinor, 100000);
    });

    // A coin that could not be priced yields no quote, and the payment still
    // proceeds — the server prices it properly at quote time. Null must never
    // be read as "there is no crypto".
    test('an unpriceable coin is still a crypto source', () {
      const source = PaySource.crypto('ltc');
      expect(source.isCrypto, isTrue);
      expect(source.quote, isNull);
      expect(source.walletTopUpMinor, isNull,
          reason: 'null and zero are different: zero means the coin covers '
              'it all, null means we could not price it');
      expect(source.isSplitFunded, isFalse);
    });

    test('the wallet source carries nothing', () {
      const source = PaySource.wallet;
      expect(source.isCrypto, isFalse);
      expect(source.quote, isNull);
      expect(source.label, 'Wallet');
    });

    // PaySource is compared by value — a screen holding one must repaint when
    // the quote changes, and not when it has not.
    test('two sources differing only in quote are not equal', () {
      final a = PaySource.crypto('usdt',
          quote: CryptoQuotePreview.build(
              asset: 'usdt', amountMinor: 100, coinValueMinor: 100));
      final b = PaySource.crypto('usdt',
          quote: CryptoQuotePreview.build(
              asset: 'usdt', amountMinor: 200, coinValueMinor: 200));
      expect(a == b, isFalse);
    });

    test('two identical sources are equal', () {
      PaySource make() => PaySource.crypto('usdt',
          assetBalance: '2',
          assetFiatValueMinor: 300000,
          quote: CryptoQuotePreview.build(
              asset: 'usdt', amountMinor: 117500, coinValueMinor: 300000));
      expect(make() == make(), isTrue,
          reason: 'without value equality every pricing pass would look like '
              'a change and repaint every screen holding one');
    });
  });

  group('the split is worked out the way the customer is shown it', () {
    test('a coin worth more than the payment sells only what is needed', () {
      final q = CryptoQuotePreview.build(
        asset: 'btc',
        amountMinor: 50000,
        coinValueMinor: 5000000,
        balance: '0.01',
      );
      expect(q.fromCryptoMinor, 50000);
      expect(q.fromWalletMinor, 0);
      expect(q.isSplit, isFalse);
    });

    test('the label is the ticker, uppercased', () {
      final q = CryptoQuotePreview.build(
          asset: 'usdt', amountMinor: 1, coinValueMinor: 1);
      expect(q.label, 'USDT');
    });
  });
}
