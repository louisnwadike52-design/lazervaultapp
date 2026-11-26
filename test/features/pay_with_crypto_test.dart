import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/config/feature_flags.dart';
import 'package:lazervault/src/features/crypto_pay/domain/pay_source.dart';
import 'package:lazervault/src/features/crypto_pay/presentation/pay_with_crypto_selector.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

/// PAYING WITH CRYPTO MUST NEVER HAPPEN BY ACCIDENT.
///
/// Selling a customer's crypto is irreversible — the sub→master transfer at
/// confirm is the point of no return — so the client half of this feature is
/// built around two rules: fiat is always the default, and the option is
/// absent unless the server has positively enabled it.
Future<void> pump(WidgetTester tester, Widget child) async {
  await tester.pumpWidget(
    ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (_, __) => MaterialApp(home: Scaffold(body: child)),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await FeatureFlags.debugResetForTest();
  });

  Future<void> setGate(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('feature_cryptopay_available', value);
  }

  group('PaySource', () {
    test('fiat is the default and carries no asset', () {
      expect(PaySource.wallet.isCrypto, isFalse);
      expect(PaySource.wallet.asset, isNull);
      expect(PaySource.wallet.label, 'Wallet');
    });

    test('a crypto source always names its asset', () {
      const s = PaySource.crypto('usdt');
      expect(s.isCrypto, isTrue);
      expect(s.asset, 'usdt');
      // A ticker reads as a typo in lowercase.
      expect(s.label, 'USDT');
    });

    test('sources compare by value, so a rebuild does not look like a change',
        () {
      expect(const PaySource.crypto('usdt'), const PaySource.crypto('usdt'));
      expect(const PaySource.crypto('usdt') == const PaySource.crypto('btc'),
          isFalse);
    });
  });

  group('the selector', () {
    testWidgets('is ABSENT when the gate is off', (tester) async {
      // Default-off. The option must not exist, rather than exist disabled —
      // a disabled control advertises a feature most users cannot use.
      await pump(
        tester,
        PayWithCryptoSelector(
          value: PaySource.wallet,
          onChanged: (_) {},
          amountMinor: 500000,
          onDarkSurface: false,
        ),
      );
      expect(find.text('Pay with'), findsNothing);
      expect(find.text('Crypto'), findsNothing);
    });

    testWidgets('is absent when the key is anything other than "true"',
        (tester) async {
      // gateAllowed(defaultOn: false) enables on the EXACT string "true".
      // A settings poll that returns junk must leave this off.
      await setGate('yes');
      await FeatureFlags.debugResetForTest();
      await setGate('yes');
      await pump(
        tester,
        PayWithCryptoSelector(
          value: PaySource.wallet,
          onChanged: (_) {},
          amountMinor: 500000,
          onDarkSurface: false,
        ),
      );
      expect(find.text('Crypto'), findsNothing);
    });

    testWidgets('is a ROW whose pill reads Wallet, once enabled',
        (tester) async {
      // The control is now a label-and-pill row matching Category and
      // Schedule beside it, not a pair of segments competing with the primary
      // action. The COIN LIST is two taps away on purpose: "where does this
      // come from" and "which coin" are different questions, and somebody
      // paying from their wallet should not have to read their balances.
      await setGate('true');
      await pump(
        tester,
        PayWithCryptoSelector(
          value: PaySource.wallet,
          onChanged: (_) {},
          amountMinor: 500000,
          onDarkSurface: false,
        ),
      );
      expect(find.text('Pay with'), findsOneWidget);
      expect(find.text('Wallet'), findsOneWidget,
          reason: 'the pill states the current source');
      expect(find.text('Crypto available'), findsOneWidget,
          reason: 'the option has to announce itself once, or nobody finds it');
      // Not on the row — it belongs to the dialog.
      expect(find.text('Crypto'), findsNothing);
    });

    testWidgets('the row opens a dialog offering Wallet and Crypto',
        (tester) async {
      await setGate('true');
      await pump(
        tester,
        PayWithCryptoSelector(
          value: PaySource.wallet,
          onChanged: (_) {},
          amountMinor: 500000,
          onDarkSurface: false,
        ),
      );
      await tester.tap(find.text('Pay with'));
      await tester.pumpAndSettle();
      expect(
          find.text('Choose where this payment comes from.'), findsOneWidget);
      expect(find.text('Crypto'), findsOneWidget);
      // Wallet is the preselected one, and says what it holds.
      expect(find.text('Wallet'), findsWidgets);
    });

    testWidgets('dismissing the dialog changes nothing', (tester) async {
      // Backing out has chosen nothing. A source that moved on dismissal is
      // how a payment comes to spend the wrong balance.
      await setGate('true');
      var changed = false;
      await pump(
        tester,
        PayWithCryptoSelector(
          value: PaySource.wallet,
          onChanged: (_) => changed = true,
          amountMinor: 500000,
          onDarkSurface: false,
        ),
      );
      await tester.tap(find.text('Pay with'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();
      expect(changed, isFalse);
    });

    testWidgets('names the chosen coin once one is picked', (tester) async {
      await setGate('true');
      await pump(
        tester,
        PayWithCryptoSelector(
          value: const PaySource.crypto('usdt'),
          onChanged: (_) {},
          amountMinor: 500000,
          onDarkSurface: false,
        ),
      );
      // So the customer can see WHICH asset will be sold without reopening
      // anything.
      expect(find.text('USDT'), findsOneWidget);
      expect(find.text('Crypto'), findsNothing);
      // And the badge stands down once the option has been taken — beside a
      // pill that already says USDT it would be repeating itself.
      expect(find.text('Crypto available'), findsNothing);
    });

    testWidgets('switching back to Wallet is immediate and needs no sheet',
        (tester) async {
      await setGate('true');
      PaySource? got;
      await pump(
        tester,
        PayWithCryptoSelector(
          value: const PaySource.crypto('usdt'),
          onChanged: (s) => got = s,
          amountMinor: 500000,
          onDarkSurface: false,
        ),
      );
      await tester.tap(find.text('USDT'));
      await tester.pumpAndSettle();
      // Wallet is the FIRST option in the dialog and selecting it returns
      // immediately — no coin sheet, nothing to confirm. Leaving crypto must
      // never be harder than entering it.
      await tester.tap(find.text('Wallet').first);
      await tester.pumpAndSettle();
      expect(got, PaySource.wallet,
          reason: 'leaving crypto must never require confirming anything');
    });

    testWidgets('cannot be changed while a payment is in flight',
        (tester) async {
      await setGate('true');
      var changed = false;
      await pump(
        tester,
        PayWithCryptoSelector(
          value: PaySource.wallet,
          onChanged: (_) => changed = true,
          amountMinor: 500000,
          onDarkSurface: false,
          enabled: false,
        ),
      );
      await tester.tap(find.text('Pay with'));
      await tester.pumpAndSettle();
      expect(find.text('Choose where this payment comes from.'), findsNothing,
          reason: 'the dialog must not even open while a request is in '
              'flight — the choice has already been sent');
      expect(changed, isFalse,
          reason: 'the source must not move underneath a request that has '
              'already been sent');
    });
  });

  group('the tester whitelist', () {
    // It overrides the OFF switch — that is how a money pilot runs while the
    // feature stays hidden from everyone else. And it arrives as DIGESTS,
    // because the settings poll it rides answers the open internet and this
    // list names the people running that pilot.
    String digest(String email) =>
        sha256.convert(utf8.encode(email.trim().toLowerCase())).toString();

    Future<void> setWhitelist(String raw) async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('feature_cryptopay_whitelist', raw);
    }

    testWidgets('a whitelisted tester sees it while the switch is off',
        (tester) async {
      await setWhitelist(digest('tester@lazervault.app'));
      await pump(
        tester,
        PayWithCryptoSelector(
          value: PaySource.wallet,
          onChanged: (_) {},
          amountMinor: 500000,
          onDarkSurface: false,
          email: 'Tester@Lazervault.APP', // case must not matter
        ),
      );
      expect(find.text('Pay with'), findsOneWidget);
    });

    testWidgets('someone not on the list still does not', (tester) async {
      await setWhitelist(digest('tester@lazervault.app'));
      await pump(
        tester,
        PayWithCryptoSelector(
          value: PaySource.wallet,
          onChanged: (_) {},
          amountMinor: 500000,
          onDarkSurface: false,
          email: 'someone@else.com',
        ),
      );
      expect(find.text('Crypto'), findsNothing);
    });

    testWidgets('A PLAINTEXT EMAIL DOES NOT MATCH — the privacy change stays',
        (tester) async {
      // If this ever passes, the server is free to go back to publishing
      // tester addresses to every handset.
      await setWhitelist('tester@lazervault.app');
      await pump(
        tester,
        PayWithCryptoSelector(
          value: PaySource.wallet,
          onChanged: (_) {},
          amountMinor: 500000,
          onDarkSurface: false,
          email: 'tester@lazervault.app',
        ),
      );
      expect(find.text('Crypto'), findsNothing);
    });
  });
}
