import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

import 'package:lazervault/src/features/microservice_chat/presentation/widgets/chat_pin_prompt_card.dart';
import 'package:lazervault/src/features/transaction_pin/services/transaction_pin_service.dart';
import 'package:lazervault/src/features/transaction_pin/widgets/transaction_pin_modal.dart';

// WHY THIS TEST EXISTS
// --------------------
// chat_pin_auto_opener_test.dart covers the DECISION — which prompt is eligible,
// how a re-ask differs from a rebuild, that history never opens. All 18 of its
// cases pass, and the sheet still did not appear in the app.
//
// Nothing covered the step AFTER the decision: autoOpenFor(txId) -> the live
// card -> openModal() -> a TransactionPinModal actually on screen. That is the
// half that was broken, and it was invisible because the opener's own tests
// assert `debugOpened`, which only records that the opener DECIDED to open.
//
// So this test mounts a real card and asserts the sheet is really there.

class _FakePinService implements ITransactionPinService {
  _FakePinService({this.hasPin = true, this.throwOnCheck = false});

  final bool hasPin;
  final bool throwOnCheck;
  int checkCalls = 0;

  @override
  Future<bool> checkUserHasPin({bool forceRefresh = false}) async {
    checkCalls++;
    if (throwOnCheck) throw Exception('network down');
    return hasPin;
  }

  @override
  void resetPinCache() {}

  @override
  Future<TransactionPinVerificationResult> verifyPin({
    required String pin,
    required String transactionId,
    required String transactionType,
    required double amount,
    required String currency,
  }) async =>
      TransactionPinVerificationResult(
        success: true,
        verificationToken: 'tok_${transactionId}_ok',
      );

  @override
  Future<bool> validateToken({
    required String token,
    required String transactionId,
  }) async =>
      true;

  @override
  Future<bool> createPin({
    required String pin,
    required String confirmPin,
  }) async =>
      true;

  @override
  Future<bool> changePin({
    required String currentPin,
    required String newPin,
    required String confirmNewPin,
  }) async =>
      true;

  @override
  Future<bool> resetPin({
    required String verificationCode,
    required String newPin,
    required String confirmNewPin,
  }) async =>
      true;

  @override
  Future<OTPInitiationResult> initiatePinOTP({
    required String operationType,
    required String channel,
  }) async =>
      OTPInitiationResult(success: true, message: '');

  @override
  Future<PinOTPVerifyResult> verifyPinOTP({
    required String otpCode,
    required String operationType,
    String? currentPin,
    required String newPin,
    required String confirmNewPin,
  }) async =>
      PinOTPVerifyResult(success: true, message: '');

  @override
  Future<List<OTPChannelInfo>> getPinOTPChannels() async => const [];

  @override
  Future<PinOTPVerifyResult> completeForgotPin({
    required String otpCode,
    required String newPin,
    required String confirmNewPin,
  }) async =>
      PinOTPVerifyResult(success: true, message: '');
}

Map<String, dynamic> _payload({
  String txId = 'tx-1',
  String? expiresAt,
}) =>
    {
      'transaction_id': txId,
      'transaction_type': 'transfer',
      'amount': '500',
      'fee': '10',
      'total_amount': '510',
      'currency': 'NGN',
      'recipient_summary': 'Chris Okoye · Alat by Wema',
      'recipient_name': 'Chris Okoye',
      if (expiresAt != null) 'expires_at': expiresAt,
    };

Future<void> _pumpCard(
  WidgetTester tester, {
  required Map<String, dynamic> payload,
}) async {
  await tester.pumpWidget(
    _app(ListView(children: [ChatPinPromptCard(payload: payload)])),
  );
  await tester.pump();
}

/// The PIN pad sizes itself with flutter_screenutil, which throws a
/// LateInitializationError if ScreenUtil was never initialised — so the sheet
/// must be pumped under ScreenUtilInit or the modal fails to BUILD and the test
/// reports "no sheet" for a reason that has nothing to do with the app.
Widget _app(Widget child) => ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (_, __) => MaterialApp(home: Scaffold(body: child)),
    );

void main() {
  late _FakePinService pinService;

  // The pad is a full-height bottom sheet built for a phone. On the 800x600
  // default test surface its own Row/Column overflow, which registers as a
  // framework exception and fails the test for a reason that has nothing to do
  // with whether the sheet opened. Give it a real phone viewport instead.
  setUpAll(() {
    final view = TestWidgetsFlutterBinding.ensureInitialized().platformDispatcher
        .views.first;
    view.physicalSize = const Size(1170, 2532); // iPhone 13 @3x
    view.devicePixelRatio = 3.0;
    addTearDown(() {
      view.resetPhysicalSize();
      view.resetDevicePixelRatio();
    });
  });

  setUp(() {
    ChatPinPromptCard.debugResetAutoOpen();
    pinService = _FakePinService();
    final gi = GetIt.I;
    if (gi.isRegistered<ITransactionPinService>()) {
      gi.unregister<ITransactionPinService>();
    }
    gi.registerSingleton<ITransactionPinService>(pinService);
  });

  tearDown(() {
    ChatPinPromptCard.debugResetAutoOpen();
    if (GetIt.I.isRegistered<ITransactionPinService>()) {
      GetIt.I.unregister<ITransactionPinService>();
    }
  });

  testWidgets('a mounted card opens the PIN sheet when auto-open fires',
      (tester) async {
    await _pumpCard(tester, payload: _payload());

    // The card itself renders — this much already worked, and is exactly what
    // the user saw: the "Enter PIN" CTA and no pad.
    expect(find.byType(ChatPinPromptCard), findsOneWidget);
    expect(find.byType(TransactionPinModal), findsNothing);

    ChatPinPromptCard.autoOpenFor('tx-1');
    await tester.pumpAndSettle();

    expect(
      find.byType(TransactionPinModal),
      findsOneWidget,
      reason: 'autoOpenFor on a mounted card must put the pad on screen — '
          'this is the step no existing test covered',
    );
  });

  testWidgets('a card that mounts AFTER the request claims it', (tester) async {
    // The transcript is a lazy list: a prompt appended below the fold is not
    // built in the frame the opener decides to open, so the request has to
    // survive until the card exists.
    ChatPinPromptCard.autoOpenFor('tx-1');
    expect(ChatPinPromptCard.debugPendingAutoOpen, contains('tx-1'));

    await _pumpCard(tester, payload: _payload());
    await tester.pumpAndSettle();

    expect(find.byType(TransactionPinModal), findsOneWidget);
    expect(ChatPinPromptCard.debugPendingAutoOpen, isEmpty,
        reason: 'a claimed request must not fire a second time');
  });

  testWidgets('an expired prompt never opens the pad', (tester) async {
    await _pumpCard(
      tester,
      payload: _payload(
        expiresAt: DateTime.now()
            .toUtc()
            .subtract(const Duration(minutes: 5))
            .toIso8601String(),
      ),
    );

    ChatPinPromptCard.autoOpenFor('tx-1');
    await tester.pumpAndSettle();

    expect(find.byType(TransactionPinModal), findsNothing);
  });

  testWidgets('two cards with the SAME transaction id both still render',
      (tester) async {
    // The regression that started all of this: a shared GlobalKey made both
    // subtrees fail to build, so the card vanished and took the CTA with it.
    await tester.pumpWidget(
      _app(ListView(
        children: [
          ChatPinPromptCard(payload: _payload()),
          ChatPinPromptCard(payload: _payload()),
        ],
      )),
    );
    await tester.pump();

    expect(find.byType(ChatPinPromptCard), findsNWidgets(2));
    expect(tester.takeException(), isNull);

    ChatPinPromptCard.autoOpenFor('tx-1');
    await tester.pumpAndSettle();

    expect(find.byType(TransactionPinModal), findsOneWidget,
        reason: 'the newest card wins; exactly one pad, never two');
  });

  testWidgets('a failing has-PIN check leaves no sheet, and says so',
      (tester) async {
    // Not a hypothetical: validateTransactionPin awaits checkUserHasPin BEFORE
    // it shows anything, so a throw here is indistinguishable from "auto-open
    // is broken" unless it is named.
    GetIt.I.unregister<ITransactionPinService>();
    GetIt.I.registerSingleton<ITransactionPinService>(
      _FakePinService(throwOnCheck: true),
    );

    await _pumpCard(tester, payload: _payload());
    ChatPinPromptCard.autoOpenFor('tx-1');
    await tester.pumpAndSettle();

    expect(find.byType(TransactionPinModal), findsNothing);
  });
}
