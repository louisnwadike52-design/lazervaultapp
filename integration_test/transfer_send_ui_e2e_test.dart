// TRANSFER SEND UI E2E — proves the transfer success-prediction alert renders
// on the RECIPIENT-SEND confirmation bottom sheet.
//
// WHAT THIS PROVES (the core assertion):
//   For an EXTERNAL bank recipient (bankName != 'LazerVault'), the
//   InitiateSendFunds confirmation dialog renders a TransferPredictionAlert
//   AFTER the recipient/amount/fee rows and BEFORE the PIN/Send action. The
//   alert is informational + non-blocking, so its mere PRESENCE in the
//   confirmation column is the proof — whether the backend returns a real
//   prediction (Loaded card) or the cold-start neutral card, the widget is in
//   the tree.
//
// HOW IT WORKS (mirrors integration_test/insurance_buy_ui_sweep_test.dart):
//   • app.main() boots ONCE inside ONE testWidgets (init() is not idempotent).
//   • A fresh user is provisioned + funded over gRPC (auth signup → ensure NGN
//     wallet → accounts-direct CreditBalance → create transaction PIN), exactly
//     like the insurance harness.
//   • A REAL in-app login drives AuthenticationCubit to AuthenticationSuccess
//     (InitiateSendFunds.initState + the account fetch both require it).
//   • We navigate to AppRoutes.initiateSendFunds with an EXTERNAL RecipientModel
//     as Get.arguments. The route wraps the screen in the TransferCubit /
//     RecurringTransferCubit / BudgetCubit MultiBlocProvider; AccountCards-
//     SummaryCubit + AuthenticationCubit are global (main.dart) so the screen
//     has everything it needs.
//   • We enter an amount (>= NGN 1,500) into the on-screen TextField, tap
//     "Confirm Transfer", and ASSERT find.byType(TransferPredictionAlert) is in
//     the confirmation dialog. We then OPTIONALLY enter the PIN and reach a
//     terminal (best-effort — a backend decline is a WARN, not a failure).
//
// CLASSIFICATION:
//   FAIL = the alert is MISSING from the external-recipient confirmation, a
//          Flutter crash / ErrorWidget, or a navigation bug that never reaches
//          the confirmation dialog.
//   WARN = backend / cold-start reality: the prediction call returns nothing
//          (neutral card still renders → still a PASS for the assertion), the
//          fee/transfer backend declines, or the PIN/terminal step can't
//          complete in the sandbox. These never fail the suite.
//   PASS = the alert rendered in the external-recipient confirmation with no
//          crash.
//
// dart-defines:
//   --dart-define=TEST_BACKEND_HOST=10.0.2.2   emulator → host machine
//
// Android emulator run (transfer stack must be up — do NOT run start_all):
//   cd lazervaultapp
//   flutter test integration_test/transfer_send_ui_e2e_test.dart \
//     -d emulator-5554 \
//     --dart-define=TEST_BACKEND_HOST=10.0.2.2 \
//     --timeout=20m

import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:grpc/grpc.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lazervault/main.dart' as app;
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/services/account_manager.dart';
import 'package:lazervault/src/generated/auth.pb.dart';
import 'package:lazervault/src/generated/auth.pbgrpc.dart' as auth_pb;
import 'package:lazervault/src/generated/accounts.pb.dart';
import 'package:lazervault/src/generated/accounts.pbgrpc.dart' as accounts_pb;
import 'package:lazervault/src/generated/transaction_pin.pb.dart';
import 'package:lazervault/src/generated/transaction_pin.pbgrpc.dart' as pin_pb;
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/features/recipients/data/models/recipient_model.dart';
import 'package:lazervault/src/features/funds/presentation/widgets/send_funds/initiate_send_funds.dart';
import 'package:lazervault/src/features/funds/presentation/widgets/send_funds/transfer_prediction_alert.dart';

// ============================================================================
// Configuration (same channel constants as the insurance harness)
// ============================================================================

const String grpcHost =
    String.fromEnvironment('TEST_BACKEND_HOST', defaultValue: 'localhost');
const int coreGatewayPort = 50070; // auth, accounts (via gateway), pin
const int accountsServiceDirectPort = 50052; // CreditBalance (sandbox fund)

const String testPassword = r'Password1$';
const String testPin = '1111';
const int fundAmountKobo = 50000 * 100; // ₦50,000 float for the transfer

// External recipient under test. bankName != 'LazerVault' is what makes the
// prediction alert show. The sort code is a real NIBSS bank code (GTBank 058)
// so the prediction endpoint has a valid bank to band; the account number is a
// well-formed 10-digit NUBAN. The prediction is best-effort: even an unknown
// bank/recipient renders the neutral card, which still satisfies the assertion.
const String recipientName = 'Transfer E2E Beneficiary';
const String recipientAccountNumber = '0123456789';
const String recipientBankName = 'Guaranty Trust Bank';
const String recipientSortCode = '058';

// ============================================================================
// Result book-keeping (mirrors the insurance harness ledger)
// ============================================================================

class _Results {
  int passed = 0;
  int failed = 0;
  int warned = 0;
  final List<String> uiBugs = [];
  final List<String> setupErrors = [];
  final List<String> warns = [];

  void ok(String name, [String detail = '']) {
    passed++;
    // ignore: avoid_print
    print('  PASS: $name${detail.isNotEmpty ? " — $detail" : ""}');
  }

  void uiBug(String what, String why) {
    failed++;
    uiBugs.add('$what: $why');
    // ignore: avoid_print
    print('  FAIL(UI-BUG): $what — $why');
  }

  void setupFail(String name, String why) {
    failed++;
    setupErrors.add('$name: $why');
    // ignore: avoid_print
    print('  FAIL(SETUP): $name — $why');
  }

  void warn(String name, String why) {
    warned++;
    warns.add('$name: $why');
    // ignore: avoid_print
    print('  WARN: $name — $why');
  }

  void summary() {
    final total = passed + failed + warned;
    // ignore: avoid_print
    print('\n${'=' * 72}');
    // ignore: avoid_print
    print('TRANSFER SEND UI E2E  pass=$passed  fail=$failed  warn=$warned  '
        '(steps logged=$total)');
    // ignore: avoid_print
    print('-' * 72);
    if (uiBugs.isEmpty && setupErrors.isEmpty) {
      // ignore: avoid_print
      print('UI BUGS: none — the prediction alert rendered on the external '
          'recipient confirmation with no crash');
    } else {
      // ignore: avoid_print
      print('UI BUGS / SETUP FAILURES (${uiBugs.length + setupErrors.length}) '
          '— lead must fix:');
      for (final e in setupErrors) {
        // ignore: avoid_print
        print('  x SETUP $e');
      }
      for (final e in uiBugs) {
        // ignore: avoid_print
        print('  x $e');
      }
    }
    if (warns.isNotEmpty) {
      // ignore: avoid_print
      print('-' * 72);
      // ignore: avoid_print
      print('WARNS (${warns.length}) — backend / cold-start (not bugs):');
      for (final w in warns) {
        // ignore: avoid_print
        print('  ! $w');
      }
    }
    // ignore: avoid_print
    print('=' * 72);
  }

  bool get hasHardFailures => uiBugs.isNotEmpty || setupErrors.isNotEmpty;
}

// ============================================================================
// Session + gRPC helpers (lifted from the insurance harness)
// ============================================================================

class _Session {
  final String email;
  final String userId;
  final String accessToken;
  final String ngnAccountId;
  _Session({
    required this.email,
    required this.userId,
    required this.accessToken,
    required this.ngnAccountId,
  });
}

ClientChannel _channel(int port) => ClientChannel(
      grpcHost,
      port: port,
      options: const ChannelOptions(
        credentials: ChannelCredentials.insecure(),
        connectionTimeout: Duration(seconds: 10),
      ),
    );

CallOptions _authOpts(String token) => CallOptions(
      metadata: {
        'authorization': 'Bearer $token',
        'x-locale': 'en-NG',
      },
      timeout: const Duration(seconds: 30),
    );

Future<_Session> _provisionTestUser(
  ClientChannel core,
  ClientChannel accountsDirect,
) async {
  final ts = DateTime.now().millisecondsSinceEpoch;
  final email = 'transfer-send-ui-e2e-$ts@lazervault.test';
  final phone = '+23480${(10000000 + (ts % 90000000)).toString()}';
  final deviceId = 'transfer-send-ui-e2e-$ts';

  final auth = auth_pb.AuthServiceClient(core);
  // ignore: avoid_print
  print('  -> signup $email');
  final signupResp = await auth.signup(SignupRequest(
    email: email,
    password: testPassword,
    firstName: 'TransferSend',
    lastName: 'Tester',
    phone: phone,
    deviceId: deviceId,
    deviceName: 'Transfer Send UI E2E',
    locale: 'en-NG',
    dateOfBirth: '1995-01-01',
  ));

  String accessToken = signupResp.accessToken;
  String userId = signupResp.userId;
  if (userId.isEmpty && signupResp.hasUser()) userId = signupResp.user.id;
  if (accessToken.isEmpty) {
    final loginResp = await auth.login(LoginRequest(
      email: email,
      password: testPassword,
      deviceId: deviceId,
      deviceName: 'Transfer Send UI E2E',
    ));
    accessToken = loginResp.hasData() &&
            loginResp.data.session.accessToken.isNotEmpty
        ? loginResp.data.session.accessToken
        : loginResp.accessToken;
    if (userId.isEmpty && loginResp.hasData()) {
      userId = loginResp.data.session.userId.isNotEmpty
          ? loginResp.data.session.userId
          : loginResp.data.user.id;
    }
  }
  if (accessToken.isEmpty) throw Exception('signup: no access token');
  if (userId.isEmpty) throw Exception('signup: no user id');

  // Ensure NGN wallet exists.
  final accountsViaGateway = accounts_pb.AccountsServiceClient(core);
  final accountsResp = await accountsViaGateway.getUserAccounts(
    GetUserAccountsRequest(),
    options: _authOpts(accessToken),
  );
  String? ngnAccountId;
  for (final a in accountsResp.accounts) {
    if (a.currency.toUpperCase() == 'NGN') {
      ngnAccountId = a.uuid.isNotEmpty ? a.uuid : a.id.toString();
      break;
    }
  }
  ngnAccountId ??= (await accountsViaGateway.createAccount(
    CreateAccountRequest(
      accountName: 'E2E NGN Wallet',
      accountType: 'personal',
      currency: 'NGN',
      locale: 'en-NG',
      isPrimary: false,
    ),
    options: _authOpts(accessToken),
  ))
      .account
      .id;

  // Fund the wallet directly via accounts-service (sandbox credit).
  // ignore: avoid_print
  print('  -> credit ₦${fundAmountKobo / 100} to $ngnAccountId');
  final ad = accounts_pb.AccountsServiceClient(accountsDirect);
  final credit = await ad.creditBalance(CreditBalanceRequest(
    accountId: ngnAccountId,
    userId: userId,
    amount: Int64(fundAmountKobo),
    currency: 'NGN',
    reference: 'E2E-TRSEND-FUND-${DateTime.now().microsecondsSinceEpoch}',
    type: 'deposit',
    description: 'E2E transfer send UI funding',
    serviceName: 'e2e-test',
    idempotencyKey:
        'E2E-TRSEND-FUND-IDEM-${DateTime.now().microsecondsSinceEpoch}',
  ));
  if (!credit.success) {
    throw Exception('CreditBalance: ${credit.errorCode} ${credit.errorMessage}');
  }

  // Transaction PIN.
  final pinClient = pin_pb.TransactionPinServiceClient(core);
  final pinResp = await pinClient.createTransactionPin(
    CreateTransactionPinRequest(
      userId: userId,
      pin: testPin,
      confirmPin: testPin,
      deviceId: deviceId,
      deviceName: 'Transfer Send UI E2E',
      channelType: PinChannelType.PIN_CHANNEL_APP,
    ),
    options: _authOpts(accessToken),
  );
  if (!pinResp.success) {
    throw Exception('CreateTransactionPin: ${pinResp.message}');
  }

  return _Session(
    email: email,
    userId: userId,
    accessToken: accessToken,
    ngnAccountId: ngnAccountId,
  );
}

// Seed the app so its in-process gRPC calls authenticate as our provisioned
// user with an active account.
Future<void> _seedAppAuth(_Session s) async {
  const storage = FlutterSecureStorage();
  await storage.write(key: 'access_token', value: s.accessToken);
  await storage.write(key: 'user_id', value: s.userId);
  await storage.write(key: 'refresh_token', value: s.accessToken);
  GetIt.I<AccountManager>().setActiveAccount(s.ngnAccountId);
}

// ============================================================================
// Test
// ============================================================================

void main() {
  final results = _Results();

  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Transfer SEND UI E2E (prediction alert on confirmation)', () {
    late _Session session;
    late ClientChannel core;
    late ClientChannel accountsDirect;

    setUpAll(() async {
      // ignore: avoid_print
      print('\n${'=' * 72}');
      // ignore: avoid_print
      print('Transfer SEND UI E2E — provisioning fresh user');
      // ignore: avoid_print
      print('=' * 72);

      core = _channel(coreGatewayPort);
      accountsDirect = _channel(accountsServiceDirectPort);

      try {
        session = await _provisionTestUser(core, accountsDirect);
        results.ok('Provision test user',
            'email=${session.email} user=${session.userId.substring(0, 8)} ngn=${session.ngnAccountId}');
      } catch (e, st) {
        results.setupFail('Provision test user', '$e');
        // ignore: avoid_print
        print(st);
        results.summary();
        rethrow;
      }
    });

    tearDownAll(() async {
      // Print the ledger FIRST so it lands even if channel teardown misbehaves.
      results.summary();
      for (final ch in [core, accountsDirect]) {
        try {
          await ch
              .shutdown()
              .timeout(const Duration(seconds: 3), onTimeout: () {});
        } catch (_) {}
      }
      if (results.hasHardFailures) {
        fail('Transfer SEND UI E2E found '
            '${results.uiBugs.length + results.setupErrors.length} UI/app bug(s)');
      }
    });

    // ── ONE app-driven testWidgets: boot once, log in, drive the send-funds
    //    confirmation, assert the prediction alert.
    testWidgets('External recipient confirmation renders TransferPredictionAlert',
        (tester) async {
      // 1) Boot the real app inside runAsync, then pump until the Navigator
      //    mounts.
      await tester.runAsync(() async {
        app.main();
        // Cold emulator boot (DI init + JWKS + several gRPC channel handshakes)
        // routinely needs > 70s on this machine; give it generous headroom so
        // boot detection isn't a near-miss timeout (the previous 40s here +
        // 30s pump loop fired exactly at the boundary).
        final realBootEnd = DateTime.now().add(const Duration(seconds: 90));
        while (DateTime.now().isBefore(realBootEnd)) {
          await Future<void>.delayed(const Duration(milliseconds: 250));
          if (WidgetsBinding.instance.rootElement != null &&
              (Get.key.currentState != null || Get.context != null)) {
            break;
          }
        }
      });
      final bootDeadline = DateTime.now().add(const Duration(seconds: 60));
      while (DateTime.now().isBefore(bootDeadline)) {
        if (find.byType(Navigator).evaluate().isNotEmpty &&
            (Get.key.currentState != null || Get.context != null)) {
          break;
        }
        await tester.pump(const Duration(milliseconds: 300));
      }
      final navReady = find.byType(Navigator).evaluate().isNotEmpty &&
          (Get.key.currentState != null || Get.context != null);
      if (!navReady) {
        results.setupFail('App boots',
            'GetMaterialApp/Navigator never mounted after boot');
        return;
      }
      results.ok('App boots');

      // 2) Seed token + active account so in-app gRPC carries our user.
      try {
        await _seedAppAuth(session);
        results.ok('Seed authenticated session',
            'token+account seeded (acct=${session.ngnAccountId})');
      } catch (e) {
        results.setupFail('Seed authenticated session', '$e');
        return;
      }
      for (var i = 0; i < 20; i++) {
        await tester.pump(const Duration(milliseconds: 300));
      }

      // 3) Drive a REAL in-app login so AuthenticationCubit emits
      //    AuthenticationSuccess (InitiateSendFunds.initState fetches accounts
      //    only when authenticated).
      AuthenticationCubit? authCubit;
      try {
        final navFinder = find.byType(Navigator);
        if (navFinder.evaluate().isNotEmpty) {
          authCubit = BlocProvider.of<AuthenticationCubit>(
              tester.element(navFinder.first));
        }
      } catch (_) {/* fall through */}
      if (authCubit == null) {
        results.setupFail('Login (AuthenticationSuccess)',
            'could not locate live AuthenticationCubit in the tree');
        return;
      }
      await tester.runAsync(() async {
        await authCubit!
            .loginUser(email: session.email, password: testPassword);
      });
      final loginDeadline = DateTime.now().add(const Duration(seconds: 20));
      while (DateTime.now().isBefore(loginDeadline) &&
          authCubit.state is! AuthenticationSuccess) {
        await tester.pump(const Duration(milliseconds: 300));
      }
      if (authCubit.state is! AuthenticationSuccess) {
        results.setupFail('Login (AuthenticationSuccess)',
            'cubit state=${authCubit.state.runtimeType} after loginUser');
        return;
      }
      results.ok('Login (AuthenticationSuccess)',
          'logged in as ${session.email}');

      // 4) Navigate to the SEND-FUNDS flow for an EXTERNAL bank recipient.
      //    The route (AppRoutes.initiateSendFunds) wraps the screen in the
      //    TransferCubit / RecurringTransferCubit / BudgetCubit providers;
      //    AccountCardsSummaryCubit + AuthenticationCubit are global.
      const recipient = RecipientModel(
        id: '',
        name: recipientName,
        accountNumber: recipientAccountNumber,
        bankName: recipientBankName, // != 'LazerVault' → external
        sortCode: recipientSortCode,
        isFavorite: false,
        isSaved: false,
        type: 'external',
        currency: 'NGN',
      );
      try {
        Get.toNamed(AppRoutes.initiateSendFunds, arguments: recipient);
      } catch (e) {
        results.uiBug('Navigate to send funds', 'Get.toNamed threw: $e');
        return;
      }
      // Wait (bounded) for the InitiateSendFunds widget to mount.
      final sendFinder = find.byType(InitiateSendFunds);
      final sendDeadline = DateTime.now().add(const Duration(seconds: 25));
      while (sendFinder.evaluate().isEmpty &&
          DateTime.now().isBefore(sendDeadline)) {
        await tester.pump(const Duration(milliseconds: 400));
      }
      if (sendFinder.evaluate().isEmpty) {
        results.uiBug('Navigate to send funds',
            'InitiateSendFunds never mounted after Get.toNamed — nav bug');
        return;
      }
      results.ok('Reach send-funds screen',
          'external recipient $recipientBankName ••••'
          '${recipientAccountNumber.substring(recipientAccountNumber.length - 4)}');

      // 5) Wait for account summaries to load so the "Confirm Transfer" button
      //    enables (it requires summaries.isNotEmpty + a non-zero amount).
      //    A render crash here surfaces as an ErrorWidget → UI bug.
      if (find.byType(ErrorWidget).evaluate().isNotEmpty) {
        results.uiBug('Send-funds screen', 'ErrorWidget on render — build threw');
        return;
      }
      // Give the AccountCardsSummaryCubit fetch time to land.
      final acctLoadDeadline = DateTime.now().add(const Duration(seconds: 30));
      while (DateTime.now().isBefore(acctLoadDeadline)) {
        await tester.pump(const Duration(milliseconds: 500));
        // The amount field is present once the screen body is built.
        if (find.byType(TextField).evaluate().isNotEmpty) break;
      }

      // 6) Enter an amount (>= NGN 1,500). Typing "2000" → ₦2,000.
      final amountField = find.byType(TextField);
      if (amountField.evaluate().isEmpty) {
        results.uiBug('Enter amount',
            'amount TextField not found on send-funds screen — render bug');
        return;
      }
      try {
        await tester.enterText(amountField.first, '2000');
        await tester.pump(const Duration(milliseconds: 500));
        results.ok('Enter amount', '₦2,000 entered');
      } catch (e) {
        results.uiBug('Enter amount', 'enterText threw: $e');
        return;
      }

      // 7) Tap "Confirm Transfer" to open the confirmation dialog. Retry once
      //    in case account summaries needed an extra beat to enable the button.
      bool dialogOpened = false;
      for (var attempt = 1; attempt <= 2 && !dialogOpened; attempt++) {
        final confirmBtn = find.text('Confirm Transfer');
        if (confirmBtn.evaluate().isEmpty) {
          await tester.pump(const Duration(seconds: 1));
          continue;
        }
        try {
          await tester.ensureVisible(confirmBtn.first);
        } catch (_) {/* best-effort */}
        try {
          await tester.tap(confirmBtn.first, warnIfMissed: false);
        } catch (_) {/* button may be disabled this beat */}
        // The confirmation is a showDialog with a "Transfer Confirmation"
        // header. Wait (bounded) for it.
        final dlgDeadline = DateTime.now().add(const Duration(seconds: 12));
        while (DateTime.now().isBefore(dlgDeadline)) {
          await tester.pump(const Duration(milliseconds: 400));
          if (find.text('Transfer Confirmation').evaluate().isNotEmpty) {
            dialogOpened = true;
            break;
          }
        }
        if (!dialogOpened && attempt < 2) {
          // Likely the button was still disabled (summaries not loaded). Wait
          // and retry the tap.
          await tester.pump(const Duration(seconds: 2));
        }
      }
      if (!dialogOpened) {
        results.uiBug('Open confirmation',
            '"Transfer Confirmation" dialog never opened after tapping '
            '"Confirm Transfer" (button disabled or nav bug)');
        return;
      }
      results.ok('Open confirmation', 'Transfer Confirmation dialog shown');

      // A render crash inside the dialog (e.g. the alert throwing) shows an
      // ErrorWidget — that's a UI bug.
      if (find.byType(ErrorWidget).evaluate().isNotEmpty) {
        results.uiBug('Confirmation dialog',
            'ErrorWidget inside the confirmation — alert/dialog build threw');
        return;
      }

      // 8) THE CORE PROOF — the prediction alert is in the confirmation column.
      //    The cubit fetch is best-effort (8s timeout); the widget renders
      //    nothing on Initial/Loading and a card on Loaded/Unavailable, so we
      //    give it a moment to resolve to a card before asserting. If the fetch
      //    flakes it lands on the neutral Unavailable card, which still proves
      //    placement.
      final alertFinder = find.byType(TransferPredictionAlert);
      final alertDeadline = DateTime.now().add(const Duration(seconds: 12));
      while (alertFinder.evaluate().isEmpty &&
          DateTime.now().isBefore(alertDeadline)) {
        await tester.pump(const Duration(milliseconds: 400));
      }
      if (alertFinder.evaluate().isEmpty) {
        results.uiBug('Prediction alert renders',
            'TransferPredictionAlert NOT present in the external-recipient '
            'confirmation — the alert is missing on the send-funds confirmation '
            '(this is the bug the task asks to fix)');
        return;
      }
      results.ok('Prediction alert renders',
          'TransferPredictionAlert found in the external-recipient '
          'confirmation (core proof)');

      // 9) OPTIONAL — enter the PIN and reach a terminal. Best-effort; any
      //    backend decline / cold-start is a WARN, never a failure. The core
      //    assertion already passed above.
      try {
        final confirmPay = find.text('Confirm Transfer');
        // The dialog's action button is also labelled — find the one inside the
        // dialog (last in the tree). Tap it to advance to the PIN modal.
        final dialogActions = find.descendant(
          of: find.byType(Dialog),
          matching: find.byType(ElevatedButton),
        );
        if (dialogActions.evaluate().isNotEmpty) {
          await tester.tap(dialogActions.last, warnIfMissed: false);
        } else if (confirmPay.evaluate().isNotEmpty) {
          await tester.tap(confirmPay.last, warnIfMissed: false);
        }
        await tester.pump(const Duration(seconds: 1));

        final firstDigit = find.byKey(const Key('transaction_pin_digit_0'));
        final pinDeadline = DateTime.now().add(const Duration(seconds: 20));
        while (firstDigit.evaluate().isEmpty &&
            DateTime.now().isBefore(pinDeadline)) {
          await tester.pump(const Duration(milliseconds: 500));
          if (find
              .textContaining('Failed to check PIN status')
              .evaluate()
              .isNotEmpty) {
            break;
          }
        }
        if (firstDigit.evaluate().isEmpty) {
          results.warn('PIN + terminal',
              'PIN modal did not appear (PIN-status check or fee backend) — '
              'core assertion already passed; not a failure');
        } else {
          for (var i = 0; i < 4; i++) {
            final digit = find.byKey(Key('transaction_pin_digit_$i'));
            await tester.enterText(digit, testPin[i]);
            await tester.pump(const Duration(milliseconds: 200));
          }
          await tester.pump(const Duration(seconds: 2));
          // Wait (bounded) for any terminal signal.
          final termDeadline = DateTime.now().add(const Duration(seconds: 60));
          String reached = '';
          while (DateTime.now().isBefore(termDeadline)) {
            await tester.pump(const Duration(milliseconds: 800));
            if (find.textContaining('successful').evaluate().isNotEmpty ||
                find.textContaining('Successful').evaluate().isNotEmpty ||
                Get.currentRoute.contains('receipt')) {
              reached = 'success/receipt';
              break;
            }
            if (find.textContaining('failed').evaluate().isNotEmpty ||
                find.textContaining('Failed').evaluate().isNotEmpty ||
                find.textContaining('insufficient').evaluate().isNotEmpty) {
              reached = 'declined/error';
              break;
            }
          }
          if (reached.isEmpty) {
            results.warn('PIN + terminal',
                'no terminal within 60s (backend slow) — core assertion '
                'already passed');
          } else if (reached == 'declined/error') {
            results.warn('PIN + terminal',
                'clean provider/balance decline ($reached) — expected sandbox '
                'reality; core assertion already passed');
          } else {
            results.ok('PIN + terminal', 'reached $reached');
          }
        }
      } catch (e) {
        results.warn('PIN + terminal',
            'best-effort terminal step threw (non-fatal): $e');
      }

      results.ok('E2E complete',
          'prediction alert proven on the external-recipient send-funds '
          'confirmation');
    });
  });
}
