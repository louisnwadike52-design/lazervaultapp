import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/family_account/presentation/widgets/family_spend_refusal_dialog.dart';

/// A family wallet refusal has to say the right thing or it is worse than
/// silence: telling a member to "add money to the pool" when their OWNER sets
/// their allowance sends them somewhere they can do nothing, and titling a frozen
/// account "Not enough in your allowance" is simply false.
void main() {
  group('familyFundModeFrom', () {
    test('shared_pool is the only mode anyone can top up', () {
      expect(familyFundModeFrom('shared_pool'), FamilyFundMode.sharedPool);
    });

    test('both allocation modes are individual allowances', () {
      // equal_split and custom_allocation differ in how the allowance is
      // CALCULATED and not at all in who can change it, which is the only thing
      // this distinction is used for.
      expect(familyFundModeFrom('equal_split'),
          FamilyFundMode.individualAllocation);
      expect(familyFundModeFrom('custom_allocation'),
          FamilyFundMode.individualAllocation);
    });

    test('missing or unrecognised stays unknown, never a guess', () {
      for (final raw in [null, '', '   ', 'whatever_new_mode']) {
        expect(familyFundModeFrom(raw), FamilyFundMode.unknown, reason: '$raw');
      }
    });
  });

  group('familyRefusalIsAboutFunds', () {
    // The strings below are the REAL ones, copied from the two generators that
    // produce them, so the classification is pinned to the server rather than to
    // my idea of what the server says:
    //
    //   utility-payments  service.FamilyRefusalMessage  (bills — customer copy)
    //   accounts-service  classifyFamilySpendRefusal    (the terser Reason that
    //                     core-payments forwards verbatim for send-funds/TagPay)
    const fundsMessages = [
      // utility-payments, all five funds codes
      'The family pool has ₦180.00 left, which doesn\'t cover this payment. '
          'Anyone in the family can add money to the pool.',
      'You have ₦20.00 left of your allocation, which doesn\'t cover this '
          'payment. Ask a family admin to allocate more.',
      'This is above your ₦5000.00 limit for a single payment. Try a smaller '
          'amount, or ask a family admin to raise it.',
      'This would put you over your ₦10000.00 daily limit — you have ₦250.00 '
          'left today. Try a smaller amount, or again tomorrow.',
      'This would put you over your ₦50000.00 monthly limit — you have ₦250.00 '
          'left this month. Try a smaller amount, or ask a family admin to raise it.',
      // accounts-service Reason strings, as core-payments forwards them
      'amount 500.00 exceeds per-transaction limit 200.00',
      'this would exceed your daily limit of 1000.00 (already spent 900.00)',
      'this would exceed your monthly limit of 20000.00 (already spent 19900.00)',
      'amount 500.00 exceeds remaining balance 20.00',
      'family pool balance is too low for this spend',
    ];

    const nonFundsMessages = [
      // utility-payments
      'Your membership of this family account isn\'t active, so you can\'t spend '
          'from it yet. A family admin can reactivate you.',
      'You\'re not a member of this family account.',
      'This family account is frozen, so payments from it are paused. A family '
          'admin can unfreeze it.',
      // accounts-service
      'not a member of this family account',
      'your family membership is not active',
    ];

    test('recognises every funds refusal the server actually sends', () {
      for (final s in fundsMessages) {
        expect(familyRefusalIsAboutFunds(s), isTrue, reason: s);
      }
    });

    test('does not claim a non-funds refusal is about money', () {
      // These arrive under the same gRPC code as an allowance shortfall, and
      // none of them is fixed by topping anything up — titling one "Not enough
      // in your allowance" would send someone to add money they already have.
      for (final s in nonFundsMessages) {
        expect(familyRefusalIsAboutFunds(s), isFalse, reason: s);
      }
    });
  });

  group('dialog copy', () {
    Future<void> pump(WidgetTester tester,
        {required String message, required FamilyFundMode mode}) async {
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(390, 844),
          builder: (_, __) => MaterialApp(
            home: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () => showFamilySpendRefusalDialog(
                  context,
                  message: message,
                  mode: mode,
                  familyName: 'Smith Family',
                ),
                child: const Text('go'),
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.text('go'));
      await tester.pumpAndSettle();
    }

    testWidgets('a shared pool offers topping the pool up', (tester) async {
      await pump(tester,
          message: 'Insufficient funds in the family pool',
          mode: FamilyFundMode.sharedPool);
      expect(find.text('Not enough in the family pool'), findsOneWidget);
      expect(find.text('Add money to the pool'), findsOneWidget);
    });

    testWidgets('an individual allowance does NOT offer topping the pool up',
        (tester) async {
      await pump(tester,
          message: 'You have 20.00 left of your 200.00 allowance',
          mode: FamilyFundMode.individualAllocation);
      expect(find.text('Not enough in your allowance'), findsOneWidget);
      // The member cannot raise their own allowance; offering the pool action
      // would send them to a screen where they can do nothing.
      expect(find.text('Add money to the pool'), findsNothing);
      expect(find.text('View family account'), findsOneWidget);
    });

    testWidgets('a non-funds refusal keeps the neutral title', (tester) async {
      await pump(tester,
          message: 'This account is frozen',
          mode: FamilyFundMode.sharedPool);
      expect(find.text("This payment wasn't allowed"), findsOneWidget);
      expect(find.text('Not enough in the family pool'), findsNothing);
      expect(find.text('Add money to the pool'), findsNothing);
    });

    testWidgets('the server sentence is always shown verbatim', (tester) async {
      const msg = 'You have 20.00 left of your 200.00 allowance';
      await pump(tester, message: msg, mode: FamilyFundMode.individualAllocation);
      // It carries the figure, which is the whole reason the dialog exists.
      expect(find.text(msg), findsOneWidget);
    });
  });
}
