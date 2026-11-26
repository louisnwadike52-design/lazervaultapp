import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:lazervault/core/config/feature_flags.dart';
import 'package:lazervault/src/features/crowdfund/data/services/crowdfund_pdf_service.dart';
import 'package:lazervault/src/features/crowdfund/domain/entities/crowdfund_entities.dart';
import 'package:lazervault/src/features/crowdfund/presentation/cubit/crowdfund_cubit.dart';
import 'package:lazervault/src/features/crowdfund/presentation/cubit/crowdfund_state.dart';
import 'package:lazervault/src/features/crowdfund/presentation/views/donation_processing_screen.dart'
    show DonationAttempt, pendingDonationFor;
import 'package:lazervault/src/features/crowdfund/presentation/views/donation_receipt_screen.dart';

import 'crowdfund_money_summary_test.dart' show campaign;

/// THE RECEIPT HAS TO RENDER — THE DONOR HAS ALREADY PAID BY THE TIME IT OPENS.
///
/// Reported with a screenshot 2026-11-24: a black screen reading "Something
/// went wrong here. Pull to refresh, or try again in a moment." immediately
/// after the PIN sheet on a crowdfund contribution. That is the app's global
/// ErrorWidget, which means the screen itself threw while building.
///
/// The cause was two lines in `initState`:
///
///     _donation = _donation;   // a `late` field read before it was written
///     _receipt  = _receipt;
///
/// so every donation threw LateInitializationError. `makeDonation` is
/// dispatched BEFORE this screen is pushed, so the money was already on its
/// way and the only thing the donor saw was an error.
///
/// The source-text guards in `crowdfund_contribution_is_async_test.dart`
/// passed throughout: they pin that the payment screen goes to the receipt,
/// not that the receipt can be built. This one renders it.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await FeatureFlags.init();
    if (!GetIt.I.isRegistered<CrowdfundPdfService>()) {
      GetIt.I.registerSingleton<CrowdfundPdfService>(CrowdfundPdfService());
    }
  });

  tearDown(() async {
    await GetIt.I.reset();
  });

  final cf = campaign(id: 'books', current: 250);

  DonationAttempt attemptFor() => DonationAttempt(
        crowdfundId: cf.id,
        amount: 5000,
        message: 'All the best',
        isAnonymous: false,
        sourceAccountId: 'acct-1',
        transactionPin: 'tok-1',
        transactionId: 'CF-DONATE-books-1',
      );

  Future<void> pumpReceipt(WidgetTester tester, {DonationAttempt? attempt}) {
    final a = attempt ?? attemptFor();
    return tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(390, 844),
        builder: (_, __) => MaterialApp(
          home: BlocProvider<CrowdfundCubit>.value(
            value: _StubCrowdfundCubit(),
            child: DonationReceiptScreen(
              donation: pendingDonationFor(a, cf),
              crowdfund: cf,
              attempt: a,
            ),
          ),
        ),
      ),
    );
  }

  testWidgets('it builds on the pending row the PIN sheet hands over',
      (tester) async {
    await pumpReceipt(tester);
    await tester.pump();

    expect(tester.takeException(), isNull,
        reason: 'the donor has already been debited by the time this opens — '
            'a throw here shows them the global error widget instead of '
            'their receipt');
    expect(find.byType(DonationReceiptScreen), findsOneWidget);
  });

  testWidgets('it opens in the in-flight state, not as a success',
      (tester) async {
    await pumpReceipt(tester);
    await tester.pump();

    // Nothing has been confirmed yet, so it must not claim success.
    expect(find.textContaining('Sending your donation'), findsWidgets);
    expect(find.textContaining('Donation successful'), findsNothing,
        reason: 'at this moment nothing has been debited');
  });

  testWidgets('a settled receipt from history also builds', (tester) async {
    // The other way in: no attempt, a completed donation, as opened from
    // My Donations. `widget.receipt` has to reach `_receipt` for the share
    // and download actions to have anything to work with.
    final a = attemptFor();
    final settled = CrowdfundDonation(
      id: 'srv-1',
      crowdfundId: cf.id,
      donorUserId: 7,
      donor: const CrowdfundDonor(
        userId: 7,
        displayName: 'Praiz Onah',
        isAnonymous: false,
        isCreator: false,
      ),
      amount: a.amount,
      currency: cf.currency,
      donationDate: DateTime(2026, 11, 24),
      status: DonationStatus.completed,
      transactionId: a.transactionId,
      message: a.message,
      isAnonymous: false,
      paymentMethod: 'wallet',
    );
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(390, 844),
        builder: (_, __) => MaterialApp(
          home: BlocProvider<CrowdfundCubit>.value(
            value: _StubCrowdfundCubit(),
            child: DonationReceiptScreen(donation: settled, crowdfund: cf),
          ),
        ),
      ),
    );
    await tester.pump();

    expect(tester.takeException(), isNull);
    expect(find.textContaining('Donation successful'), findsWidgets);
  });
}

/// A cubit that holds a state and nothing else. The receipt only listens.
class _StubCrowdfundCubit extends Cubit<CrowdfundState>
    implements CrowdfundCubit {
  _StubCrowdfundCubit() : super(const CrowdfundInitial());

  @override
  dynamic noSuchMethod(Invocation invocation) => null;
}
