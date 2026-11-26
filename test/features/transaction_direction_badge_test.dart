import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
// unified_transaction.dart ONLY — `unified_transaction_widgets.dart` is a
// `part` of it, and importing a part directly is a compile error. The flow
// and status enums come through the parent library.
import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:lazervault/src/features/transaction_history/presentation/widgets/transaction_card.dart';

/// MONEY IN AND MONEY OUT HAVE TO READ AT A GLANCE.
///
/// Direction used to be carried only by the amount's colour and a `+` prefix,
/// which asks somebody to compare two numbers to tell a refund from a payment
/// — and says nothing at all to anyone who does not separate that green from
/// that white.
///
/// The row now carries the same arrow pair the deposit history and both
/// receipts already use, so a list and the receipt it opens agree. These pin
/// the four decisions in it, each of which looks like a detail worth
/// simplifying and is not.
void main() {
  // THE AVATAR AND ITS PIP MOVED, AND THAT IS WHY THIS GUARD MATTERS MORE.
  //
  // Both were private to transaction_card.dart, which is exactly why the
  // dashboard's first five rows drew a generic glyph and no direction at all
  // while the full history drew a bank logo and an arrow — the logic was
  // reachable from one file only. TransactionAvatar is now the single
  // implementation both lists render, so every assertion below holds for
  // both at once rather than for the full history alone.
  final card = File('lib/src/features/transaction_history/presentation/'
          'widgets/transaction_avatar.dart')
      .readAsStringSync();

  /// Source with comments stripped: the prose below explains the arrows and
  /// names them, so a raw search would pass on the explanation.
  String code(String src) =>
      src.split('\n').where((l) => !l.trimLeft().startsWith('//')).join('\n');

  final body = code(card);

  _renderTests();

  test('it uses the arrow pair the rest of the app already uses', () {
    // south_west = in, north_east = out — deposit_history_screen,
    // deposit_receipt_screen and withdrawal_receipt_screen all speak this.
    // A new pair here would make the list and the receipt disagree.
    expect(body.contains('Icons.south_west_rounded'), isTrue);
    expect(body.contains('Icons.north_east_rounded'), isTrue);
  });

  test('the badge sits ON the avatar rather than replacing it', () {
    // The left slot answers a question worth keeping — which bank, or which
    // service. Swapping it for an arrow trades "which" for "which way" on a
    // row with room for both.
    expect(body.contains('BankLogo('), isTrue,
        reason: 'the bank logo must survive');
    expect(body.contains('transaction.serviceIcon'), isTrue,
        reason: 'the service glyph must survive');
    expect(body.contains('Stack('), isTrue);
    expect(body.contains('clipBehavior: Clip.none'), isTrue,
        reason: 'the pip hangs off the corner; a clipping Stack cuts it');
  });

  test('a neutral transaction gets no arrow', () {
    // A balance enquiry has no direction, and an arrow pointing either way
    // would assert something the row does not know.
    expect(body.contains('if (!incoming && !outgoing) return null;'), isTrue);
    expect(body.contains('Widget? _directionBadge()'), isTrue,
        reason: 'the badge has to be nullable for that to be expressible');
  });

  test('outgoing is NOT red', () {
    // This list already shows failures in red (_statusColor). Painting an
    // ordinary payment red too would give one colour two meanings, and an
    // everyday spend would read as something having gone wrong.
    final badge = body.substring(body.indexOf('Widget? _directionBadge()'));
    expect(badge.contains('0xFFEF4444'), isFalse,
        reason: 'that red is the failure colour in this very widget');
    // Incoming stays the green the amount already uses, so the pip and the
    // figure are visibly one statement.
    expect(badge.contains('0xFF34C759'), isTrue);
    // The AMOUNT's green lives in the card, the BADGE's in the avatar — two
    // files since the avatar was extracted, and they must still agree or the
    // row makes the same point twice in two shades.
    final cardSrc = File('lib/src/features/transaction_history/presentation/'
            'widgets/transaction_card.dart')
        .readAsStringSync();
    expect(cardSrc.contains('const Color(0xFF34C759)'), isTrue,
        reason: 'the amount colour and the badge colour must be the same '
            'green, or the row makes the same point twice in two shades');
  });

  test('the ring comes from the caller, not from one hardcoded ground', () {
    // The pip needs to read as sitting ON the avatar rather than being part
    // of it, which takes a ring in the PAGE'S ground. That was a hardcoded
    // near-black, correct only while every caller was on the same dark
    // surface — and the note here said so: "if a caller moves to a different
    // ground, the ring has to come from the theme instead of being hardcoded
    // here."
    //
    // A caller has. The dashboard's first five rows sit on a WHITE card, and
    // the same widget now draws them, so the ring is a required parameter: a
    // caller that does not say gets a compile error rather than a near-black
    // ring on white.
    final badge = body.substring(body.indexOf('Widget? _directionBadge()'));
    expect(badge.contains('border: Border.all(color: ringColor'), isTrue,
        reason: 'the ring is hardcoded again, so one of the two lists is '
            'drawing a pip ringed in the other page\'s background');
    expect(body.contains('required this.ringColor'), isTrue,
        reason: 'optional with a default is how the wrong ground gets used '
            'silently; required makes a caller state it');

    // And both callers pass their own.
    final cardSrc = File('lib/src/features/transaction_history/presentation/'
            'widgets/transaction_card.dart')
        .readAsStringSync();
    final recentSrc =
        File('lib/src/features/widgets/recent_history_list.dart')
            .readAsStringSync();
    expect(cardSrc.contains('ringColor: const Color(0xFF0A0A0A)'), isTrue,
        reason: 'the full history is on the dark ground');
    expect(recentSrc.contains('ringColor: Colors.white'), isTrue,
        reason: 'the dashboard card is white');
  });
}

/// AND IT ACTUALLY RENDERS.
///
/// The assertions above describe the code's shape; these pump the row and look
/// for the arrow. Both matter: a source check cannot tell whether a widget
/// reached the tree, and a render check cannot say why red was avoided.
void _renderTests() {
  Future<void> pump(WidgetTester tester, TransactionFlow flow) async {
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(414, 896),
        builder: (_, __) => MaterialApp(
          home: Scaffold(
            backgroundColor: const Color(0xFF0A0A0A),
            body: TransactionCard(
              transaction: UnifiedTransaction(
                id: 't1',
                serviceType: TransactionServiceType.transfer,
                title: 'Lawrence N',
                amount: 2500,
                currency: 'NGN',
                createdAt: DateTime(2026, 11, 20, 14, 30),
                status: UnifiedTransactionStatus.completed,
                flow: flow,
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pump();
  }

  testWidgets('money in shows the inward arrow', (tester) async {
    await pump(tester, TransactionFlow.incoming);
    expect(find.byIcon(Icons.south_west_rounded), findsOneWidget);
    expect(find.byIcon(Icons.north_east_rounded), findsNothing);
  });

  testWidgets('money out shows the outward arrow', (tester) async {
    await pump(tester, TransactionFlow.outgoing);
    expect(find.byIcon(Icons.north_east_rounded), findsOneWidget);
    expect(find.byIcon(Icons.south_west_rounded), findsNothing);
  });

  testWidgets('a neutral transaction shows neither', (tester) async {
    // An arrow either way would assert a direction the row does not have.
    await pump(tester, TransactionFlow.neutral);
    expect(find.byIcon(Icons.south_west_rounded), findsNothing);
    expect(find.byIcon(Icons.north_east_rounded), findsNothing);
  });

  testWidgets('the service glyph survives beside the badge', (tester) async {
    // The regression this guards: replacing the avatar with the arrow, which
    // loses "which service" to gain "which way".
    await pump(tester, TransactionFlow.outgoing);
    expect(find.byType(Icon), findsNWidgets(2),
        reason: 'the row should carry the service glyph AND the direction '
            'pip — one Icon means the avatar was replaced');
  });
}
