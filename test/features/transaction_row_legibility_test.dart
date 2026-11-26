import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:lazervault/src/features/transaction_history/presentation/widgets/transaction_card.dart';

/// THE DENSEST MONEY SURFACE IN THE APP HAS TO BE READABLE AT A GLANCE.
///
/// Three things in the live list were not, all visible in one screenshot:
/// a six-figure transfer rendered "₦100023.00", every row printing its title
/// twice, and a direction pip whose colour depended on the bank logo under it.
UnifiedTransaction _tx({
  required double amount,
  String title = 'Transfer to GRACE C. ONWUANAKU',
  String? description,
  TransactionFlow flow = TransactionFlow.outgoing,
}) =>
    UnifiedTransaction(
      id: 't',
      serviceType: TransactionServiceType.transfer,
      title: title,
      description: description,
      amount: amount,
      currency: 'NGN',
      createdAt: DateTime(2026, 11, 21, 19, 1),
      status: UnifiedTransactionStatus.completed,
      flow: flow,
    );

Future<void> _pump(WidgetTester tester, UnifiedTransaction tx) =>
    tester.pumpWidget(ScreenUtilInit(
      designSize: const Size(414, 896),
      builder: (_, __) => MaterialApp(
        home: Scaffold(
          backgroundColor: const Color(0xFF0A0A0A),
          body: TransactionCard(transaction: tx),
        ),
      ),
    ));

void main() {
  group('amounts are grouped', () {
    testWidgets('a six-figure amount gets its separators', (tester) async {
      // "₦100023.00" makes a reader count digits to tell ₦100,023 from
      // ₦10,023. Every other money surface groups; this one did not.
      await _pump(tester, _tx(amount: 100023));
      expect(find.textContaining('100,023.00'), findsOneWidget);
      expect(find.textContaining('100023.00'), findsNothing);
    });

    testWidgets('an incoming amount keeps its + and its grouping',
        (tester) async {
      await _pump(tester, _tx(amount: 99850, flow: TransactionFlow.incoming));
      expect(find.textContaining('+'), findsOneWidget);
      expect(find.textContaining('99,850.00'), findsOneWidget);
    });

    testWidgets('a small amount is unchanged', (tester) async {
      await _pump(tester, _tx(amount: 123));
      expect(find.textContaining('123.00'), findsOneWidget);
    });
  });

  group('the subtitle says something new, or nothing', () {
    testWidgets('an exact repeat of the title is dropped', (tester) async {
      await _pump(tester, _tx(
        amount: 123,
        title: 'Transfer to GRACE C. ONWUANAKU',
        description: 'Transfer to GRACE C. ONWUANAKU',
      ));
      expect(find.text('Transfer to GRACE C. ONWUANAKU'), findsOneWidget,
          reason: 'the same sentence was printed twice, the top one '
              'ellipsised, so the second line only showed the ending the '
              'first had cut off');
    });

    testWidgets('a prefix repeat is dropped too', (tester) async {
      // What an ellipsised title actually produces.
      await _pump(tester, _tx(
        amount: 123,
        title: 'Transfer to GRACE C. ONWUA',
        description: 'Transfer to GRACE C. ONWUANAKU',
      ));
      expect(find.textContaining('ONWUANAKU'), findsNothing);
    });

    testWidgets('a subtitle that adds information is kept', (tester) async {
      await _pump(tester, _tx(
        amount: 100,
        title: 'Payment',
        description: 'Airtime 07067334850',
      ));
      expect(find.text('Airtime 07067334850'), findsOneWidget,
          reason: 'this is the line that makes the row recognisable');
    });

    testWidgets('case and punctuation cannot smuggle a duplicate through',
        (tester) async {
      await _pump(tester, _tx(
        amount: 123,
        title: 'Transfer to Louis Nwadike',
        description: 'transfer to louis nwadike.',
      ));
      expect(find.textContaining('louis nwadike'), findsNothing);
    });
  });

  group('a crypto-funded row says so', () {
    testWidgets('the badge names the coin', (tester) async {
      // A customer scrolling for "the one I paid with USDT" has nothing to
      // scan for otherwise — the row is identical to every wallet payment.
      await _pump(tester, _tx(amount: 5023, description: 'Transfer', ).copyWith(
        metadata: const {
          'funding_source': 'crypto',
          'funding_asset': 'usdt',
          'funding_crypto_minor': 300000,
          'funding_fiat_minor': 202300,
          'funding_total_minor': 502300,
        },
      ));
      expect(find.textContaining('USDT'), findsOneWidget);
      expect(find.textContaining('wallet'), findsOneWidget,
          reason: 'a split must name BOTH legs, or the row implies the coin '
              'paid for all of it');
    });

    testWidgets('an ordinary payment gets no badge', (tester) async {
      await _pump(tester, _tx(amount: 123, description: 'Airtime 0706'));
      expect(find.textContaining('Paid with'), findsNothing);
      expect(find.text('Airtime 0706'), findsOneWidget,
          reason: 'the subtitle is still the row\'s second line');
    });

    testWidgets('the badge replaces the subtitle rather than stacking',
        (tester) async {
      // The row has ONE second line. Rendering both would push the row
      // taller than every other row in the list.
      await _pump(tester, _tx(amount: 5023, description: 'Some note').copyWith(
        metadata: const {
          'funding_source': 'crypto',
          'funding_asset': 'btc',
          'funding_crypto_minor': 502300,
          'funding_fiat_minor': 0,
          'funding_total_minor': 502300,
        },
      ));
      expect(find.textContaining('BTC'), findsOneWidget);
      expect(find.text('Some note'), findsNothing);
    });
  });

  group('the direction pip is legible on any avatar', () {
    testWidgets('its fill is opaque, not a wash over the logo',
        (tester) async {
      // A 12%-white fill takes its real colour from whatever is beneath it,
      // and beneath it are bank logos, brand tiles and photos. Over a dark
      // logo the outgoing pip became a grey arrow on a near-identical grey.
      await _pump(tester, _tx(amount: 123));
      final pip = tester.widgetList<Container>(find.byType(Container)).where(
          (c) =>
              c.decoration is BoxDecoration &&
              (c.decoration as BoxDecoration).shape == BoxShape.circle &&
              (c.decoration as BoxDecoration).border != null);
      expect(pip, isNotEmpty, reason: 'no direction pip rendered');
      final d = pip.first.decoration as BoxDecoration;
      expect(d.color!.a, 1.0,
          reason: 'a translucent pip inherits the avatar underneath it');
    });
  });
}
