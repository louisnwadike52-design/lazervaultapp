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
    test('recognises the real server refusals', () {
      const samples = [
        'You have 20.00 left of your 200.00 allowance',
        'Insufficient funds in the family pool',
        'That is more than your remaining allocation',
        'This exceeds your single-transaction limit of 5,000.00',
        'Not enough available balance',
      ];
      for (final s in samples) {
        expect(familyRefusalIsAboutFunds(s), isTrue, reason: s);
      }
    });

    test('does not claim a non-funds refusal is about money', () {
      // Both arrive under the same gRPC code as an allowance shortfall, and
      // neither is fixed by topping anything up.
      const samples = [
        'This account is frozen',
        'Spending is switched off for this member',
        'You are not a member of this family account',
      ];
      for (final s in samples) {
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
