import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/referral/domain/entities/referral_bonus_entities.dart';
import 'package:lazervault/src/features/referral/presentation/widgets/referral_bonus_card.dart';

ReferralBonusBalanceEntity _bal({
  int available = 20000,
  int accrued = 20000,
  int withdrawn = 0,
  int pending = 0,
  bool active = true,
  int minimum = 0,
  String notice = '',
}) {
  return ReferralBonusBalanceEntity(
    availableMinor: available,
    lifetimeAccruedMinor: accrued,
    lifetimeWithdrawnMinor: withdrawn,
    pendingWithdrawalMinor: pending,
    currency: 'NGN',
    programmeActive: active,
    minimumWithdrawalMinor: minimum,
    programmeNotice: notice,
  );
}

Future<void> _pump(WidgetTester t, ReferralBonusBalanceEntity b) async {
  await t.pumpWidget(
    ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (_, __) => MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: ReferralBonusCard(balance: b),
          ),
        ),
      ),
    ),
  );
  // pump, NOT pumpAndSettle: the in-flight row carries a
  // CircularProgressIndicator, whose animation never settles, so
  // pumpAndSettle times out on a card that is rendering perfectly well.
  await t.pump(const Duration(milliseconds: 50));
}

void main() {
  group('amount handling', () {
    test('minor units convert once, and rounding does not lose a kobo', () {
      // (2.30 * 100).toInt() is 229 in binary floating point, which would
      // withdraw a kobo less than the user typed and leave an un-withdrawable
      // remainder behind.
      expect(ReferralBonusBalanceEntity.majorOf(20000), 200.0);
      expect(ReferralBonusBalanceEntity.majorOf(230), 2.30);
      expect((2.30 * 100).round(), 230);
    });
  });

  group('what the balance says', () {
    test('nothing is claimable — deposits are automatic', () {
      // The server always sends 0 here; the app must not invent a claimable
      // amount from the earned total.
      expect(_bal(available: 0, accrued: 20000).availableMinor, 0);
    });

    test('an undeposited bonus is reported as on its way', () {
      expect(_bal(accrued: 20000, pending: 20000).awaitingDeposit, isTrue);
    });

    test('a fully deposited bonus is not pending', () {
      final b = _bal(accrued: 20000, withdrawn: 20000, pending: 0);
      expect(b.awaitingDeposit, isFalse);
      expect(b.hasAnything, isTrue);
    });

    test('nothing earned means nothing to show', () {
      expect(_bal(available: 0, accrued: 0).hasAnything, isFalse);
    });
  });

  group('the card', () {
    testWidgets('reports earnings and offers no action', (t) async {
      // There is deliberately nothing to press: the money is already on its
      // way without the user doing anything.
      await _pump(t, _bal());
      expect(find.text('Referral bonus'), findsOneWidget);
      expect(find.text('Earned from referrals'), findsOneWidget);
      expect(find.textContaining('Withdraw'), findsNothing);
      expect(find.byType(ElevatedButton), findsNothing);
    });

    testWidgets('names the personal wallet as the destination', (t) async {
      await _pump(t, _bal(accrued: 20000, withdrawn: 20000));
      expect(find.text('Personal wallet'), findsOneWidget);
    });

    testWidgets('renders nothing when nothing was ever earned', (t) async {
      // A card reading 0.00 with a dead button implies something broke.
      await _pump(t, _bal(available: 0, accrued: 0));
      expect(find.byType(ReferralBonusCard), findsOneWidget);
      expect(find.text('Referral bonus'), findsNothing);
    });

    testWidgets('explains money earned but not yet deposited', (t) async {
      await _pump(t, _bal(accrued: 20000, pending: 20000));
      expect(find.textContaining('on its way to your personal wallet'), findsOneWidget);
    });

    testWidgets('a discontinued programme says earned money is still paid', (t) async {
      // The programme ending must not read as the money being taken.
      await _pump(t, _bal(active: false));
      expect(find.textContaining('still yours'), findsOneWidget);
    });

    testWidgets('a discontinued programme uses the operator notice when set', (t) async {
      await _pump(t, _bal(active: false, notice: 'Referrals closed on 31 December.'));
      expect(find.text('Referrals closed on 31 December.'), findsOneWidget);
      expect(find.textContaining('still yours to withdraw'), findsNothing);
    });

    testWidgets('a discontinued programme with everything paid still explains itself',
        (t) async {
      await _pump(t, _bal(accrued: 20000, withdrawn: 20000, active: false));
      expect(find.text('Referral bonus'), findsOneWidget);
      expect(find.textContaining('no longer counted'), findsOneWidget);
    });
  });
}
