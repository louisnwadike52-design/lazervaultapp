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

Future<void> _pump(WidgetTester t, ReferralBonusBalanceEntity b,
    {VoidCallback? onWithdraw}) async {
  await t.pumpWidget(
    ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (_, __) => MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: ReferralBonusCard(
              balance: b,
              onWithdraw: onWithdraw ?? () {},
            ),
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

  group('when withdrawal is offered', () {
    test('a zero balance cannot be withdrawn', () {
      expect(_bal(available: 0, accrued: 0).canWithdraw, isFalse);
    });

    test('below the minimum cannot be withdrawn, and says so', () {
      final b = _bal(available: 5000, minimum: 10000);
      expect(b.canWithdraw, isFalse);
      expect(b.blockedReason, contains('Minimum'));
    });

    test('at exactly the minimum it can be withdrawn', () {
      expect(_bal(available: 10000, minimum: 10000).canWithdraw, isTrue);
    });

    test('a pending withdrawal explains a zero available balance', () {
      final b = _bal(available: 0, pending: 20000);
      expect(b.canWithdraw, isFalse);
      expect(b.blockedReason, 'Your withdrawal is being processed');
    });
  });

  group('the card', () {
    testWidgets('offers the withdrawal and names the destination', (t) async {
      var tapped = false;
      await _pump(t, _bal(), onWithdraw: () => tapped = true);
      final cta = find.text('Withdraw to personal wallet');
      expect(cta, findsOneWidget);
      await t.tap(cta);
      expect(tapped, isTrue);
    });

    testWidgets('renders nothing when nothing was ever earned', (t) async {
      // A card reading 0.00 with a dead button implies something broke.
      await _pump(t, _bal(available: 0, accrued: 0));
      expect(find.byType(ReferralBonusCard), findsOneWidget);
      expect(find.text('Referral bonus'), findsNothing);
    });

    testWidgets('shows in-flight money rather than a shrinking balance', (t) async {
      await _pump(t, _bal(available: 0, accrued: 20000, pending: 20000));
      expect(find.textContaining('is being sent to your wallet'), findsOneWidget);
    });

    testWidgets('a discontinued programme still offers the withdrawal', (t) async {
      // The programme ending must not read as the money being taken.
      await _pump(t, _bal(active: false));
      expect(find.text('Withdraw to personal wallet'), findsOneWidget);
      expect(find.textContaining('still yours to withdraw'), findsOneWidget);
    });

    testWidgets('a discontinued programme uses the operator notice when set', (t) async {
      await _pump(t, _bal(active: false, notice: 'Referrals closed on 31 December.'));
      expect(find.text('Referrals closed on 31 December.'), findsOneWidget);
      expect(find.textContaining('still yours to withdraw'), findsNothing);
    });

    testWidgets('a discontinued programme with a spent balance still explains itself',
        (t) async {
      await _pump(t, _bal(available: 0, accrued: 20000, withdrawn: 20000, active: false));
      expect(find.text('Referral bonus'), findsOneWidget);
      expect(find.text('Withdraw to personal wallet'), findsNothing);
      expect(find.textContaining('no longer counted'), findsOneWidget);
    });
  });
}
