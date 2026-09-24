import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/src/features/referral/domain/entities/redemption_entities.dart';
import 'package:lazervault/src/features/referral/domain/repositories/i_referral_repository.dart';
import 'package:lazervault/src/features/referral/presentation/widgets/convert_points_sheet.dart';

/// Every state the conversion sheet can land in must SAY something.
///
/// Reported from a device: "clicking the convert CTA just dims the CTA and does
/// nothing". A sheet that reaches a state with no text and no working button is
/// indistinguishable from a tap that was never handled, and this sheet is shown
/// with `backgroundColor: Colors.transparent` — so a state that renders nothing
/// renders literally nothing, not even a panel.
///
/// The cases below are the four the server can produce. `canRedeem: false` is
/// the interesting one: it is a NORMAL outcome for a new account (below the
/// minimum), and the sheet must print the server's own reason rather than
/// showing a button that cannot be pressed.
class _FakeRepo implements IReferralRepository {
  _FakeRepo(this.quote);

  /// Null holds the sheet in its loading state forever, which is how the
  /// loading assertion gets a stable frame to inspect.
  final Either<Failure, RedemptionQuoteEntity>? quote;

  @override
  Future<Either<Failure, RedemptionQuoteEntity>> getRedemptionQuote({
    int points = 0,
  }) async {
    final q = quote;
    if (q == null) {
      // A Completer that is never completed, NOT a long Future.delayed: a
      // delayed future registers a real timer, and the test binding fails the
      // test for leaving one pending. This leaves the sheet on its loader with
      // nothing outstanding for the binding to complain about.
      return Completer<Either<Failure, RedemptionQuoteEntity>>().future;
    }
    return q;
  }

  // The sheet touches exactly one repository method. Declaring noSuchMethod is
  // what lets this fake implement the interface without stubbing the other
  // twenty, and it throws rather than returning null so an accidental new call
  // from the sheet fails loudly instead of silently reading as empty.
  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError(
        'the sheet called ${invocation.memberName} — the fake needs it',
      );
}

RedemptionQuoteEntity _quote({
  required bool canRedeem,
  int points = 5000,
  int cashMinor = 5000,
  String reason = '',
}) =>
    RedemptionQuoteEntity(
      points: points,
      cashMinor: cashMinor,
      currency: 'NGN',
      pointsPerMajorUnit: 100,
      minRedeemPoints: 1000,
      canRedeem: canRedeem,
      reason: reason,
    );

Future<void> pump(
  WidgetTester tester,
  Either<Failure, RedemptionQuoteEntity>? quote, {
  int currentBalance = 5000,
}) async {
  await tester.pumpWidget(
    ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (_, __) => MaterialApp(
        home: Scaffold(
          body: ConvertPointsSheet(
            repository: _FakeRepo(quote),
            currentBalance: currentBalance,
          ),
        ),
      ),
    ),
  );
  // One settle is not enough: ScreenUtilInit builds, then the sheet's initState
  // fires the quote, then SharedPreferences fails its plugin lookup in a test
  // binding and is swallowed by the key fallback.
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 50));
}

void main() {
  // The sheet's own title is always present, so asserting on it would pass in
  // every state including a blank one. Assertions below target the BODY.
  group('the conversion sheet never renders an empty body', () {
    testWidgets('while the quote is in flight it shows a loader, not a void',
        (tester) async {
      await pump(tester, null);
      // Something is on screen besides the grab handle and the title.
      expect(find.text('Convert to cash'), findsOneWidget);
      expect(find.byType(LazerVaultLoader), findsOneWidget);
    });

    testWidgets('a failed quote shows the message and a way to retry',
        (tester) async {
      await pump(
        tester,
        Left(ServerFailure(
          message: 'Could not price that conversion',
          statusCode: 500,
        )),
      );
      expect(find.text('Could not price that conversion'), findsOneWidget);
      expect(find.text('Try again'), findsOneWidget);
    });

    testWidgets(
        'below the minimum it prints the server reason instead of a dead button',
        (tester) async {
      await pump(
        tester,
        Right(_quote(
          canRedeem: false,
          points: 400,
          cashMinor: 400,
          reason: 'You need at least 1000 points to convert.',
        )),
        currentBalance: 400,
      );
      expect(
        find.text('You need at least 1000 points to convert.'),
        findsOneWidget,
      );
      // The whole point: no button that looks pressable and is not.
      expect(find.widgetWithText(ElevatedButton, 'Convert 400 points'),
          findsNothing);
    });

    testWidgets('when it can convert, the button is present AND enabled',
        (tester) async {
      await pump(tester, Right(_quote(canRedeem: true)));
      final button =
          find.widgetWithText(ElevatedButton, 'Convert 5,000 points');
      expect(button, findsOneWidget);
      // A non-null onPressed is the difference between the reported symptom and
      // a working control.
      expect(tester.widget<ElevatedButton>(button).onPressed, isNotNull);
      expect(find.text('₦50.00'), findsOneWidget);
    });

    testWidgets('the rate is stated so nobody has to reverse-engineer it',
        (tester) async {
      await pump(tester, Right(_quote(canRedeem: true)));
      expect(find.text('100 points = ₦1'), findsOneWidget);
    });

    testWidgets('a remainder left behind is named, not silently dropped',
        (tester) async {
      // Quoting 5,000 of a 5,250 balance: 250 points do not divide into a whole
      // kobo and stay put. Without this line they look like they vanished.
      await pump(
        tester,
        Right(_quote(canRedeem: true)),
        currentBalance: 5250,
      );
      expect(find.text('Staying on your balance'), findsOneWidget);
      expect(find.text('250 points'), findsOneWidget);
    });
  });
}
