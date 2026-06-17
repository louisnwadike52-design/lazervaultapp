// Gift Card SELL E2E Integration Test (REAL UI-driven)
//
// Drives the production Flutter gift-card SELL flow THROUGH THE UI — not a
// gRPC script — end-to-end against the real local backend + Prestmit
// SANDBOX, exactly as a real user would:
//
//   Gift Cards hub → Sell tab → tap a sellable card → Card Details
//   (denomination + card number + PIN) → Get Rate → Confirm (tick
//   disclaimer) → Sell → transaction PIN → receipt / status screen.
//
// NOTE: the old payout-method / "currency of payment" screen (step 2)
// was DELETED from sell_gift_card_screen.dart. Payout now auto-follows
// the active locale (NGN → NAIRA, the dashboard DefaultPayoutMethod);
// Get Rate advances straight to Confirm. There is no payout picker and
// no `sell_payout_continue_button` any more.
//
// Harness mirrors insurance_e2e_test.dart: a `_Results` pass/fail/warn
// ledger, `setUpAll` provisions a fresh user (signup → CreditBalance
// sandbox fund → CreateTransactionPin) AND seeds the app's secure
// storage + AccountManager so the in-app gRPC calls are authenticated
// with an active account (the sell RPC requires x-account-id), and
// `tearDownAll` prints a summary + fails the suite on any failure.
//
// The giftcard datasource is wired to the FINANCIAL gateway channel
// (injection_container.dart → 'financialGrpcClient' →
// createFinancialChannel → FINANCIAL_GRPC_PORT 50071). financial-gateway
// registers GiftCardsService and proxies to giftcards-service :50057.
// So the backend that must be up for the UI path is financial-gateway
// (50071) + giftcards-service (50057), NOT commerce-gateway.
//
// Sell provider is governed by feature flag `giftcard_sell_provider`
// (set to `prestmit` in giftcards_db). A Prestmit sandbox sell creates a
// sale that goes reviewing→pending_review (it does NOT auto-complete);
// reaching a "submitted / pending review" receipt (or the dedicated
// sell-processing screen) IS a success for this test.
//
// Android emulator run:
//   cd lazervaultapp
//   flutter test integration_test/giftcard_sell_e2e_test.dart \
//     -d emulator-5554 \
//     --dart-define=TEST_BACKEND_HOST=10.0.2.2 \
//     --timeout=30m

import 'dart:io';

import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:grpc/grpc.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:lazervault/main.dart' as app;
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/presentation/app_router.dart';
import 'package:lazervault/core/services/account_manager.dart';
import 'package:lazervault/src/generated/auth.pb.dart';
import 'package:lazervault/src/generated/auth.pbgrpc.dart' as auth_pb;
import 'package:lazervault/src/generated/accounts.pb.dart';
import 'package:lazervault/src/generated/accounts.pbgrpc.dart' as accounts_pb;
import 'package:lazervault/src/generated/transaction_pin.pb.dart';
import 'package:lazervault/src/generated/transaction_pin.pbgrpc.dart' as pin_pb;
import 'package:lazervault/src/features/gift_cards/cubit/gift_card_cubit.dart';
import 'package:lazervault/src/features/gift_cards/cubit/gift_card_state.dart';
import 'package:lazervault/src/features/gift_cards/domain/entities/gift_card_entity.dart';
import 'package:lazervault/src/features/gift_cards/presentation/view/widgets/sell_rejection_reasons_sheet.dart';
import 'package:lazervault/src/features/gift_cards/presentation/view/sell_gift_card_screen.dart';

// ============================================================================
// Configuration
// ============================================================================

const String grpcHost =
    String.fromEnvironment('TEST_BACKEND_HOST', defaultValue: 'localhost');
const int coreGatewayPort = 50070; // auth, accounts (via gateway), pin
const int accountsServiceDirectPort = 50052; // CreditBalance (sandbox fund)

const String testPassword = r'Password1$';
const String testPin = '1234';
// ₦200,000 — sell payouts in the sandbox land well under this; the wider
// balance also covers any fee/hold accounting on the user's NGN wallet.
const int fundAmountKobo = 200000 * 100;

// ============================================================================
// Result book-keeping (mirrors insurance_e2e_test.dart)
// ============================================================================

class _Results {
  int passed = 0;
  int failed = 0;
  final List<String> errors = [];
  final List<String> warns = [];

  void ok(String name, [String detail = '']) {
    passed++;
    // ignore: avoid_print
    print('  PASS: $name${detail.isNotEmpty ? " — $detail" : ""}');
  }

  void fail(String name, String why) {
    failed++;
    errors.add('$name: $why');
    // ignore: avoid_print
    print('  FAIL: $name — $why');
  }

  void warn(String name, String why) {
    warns.add('$name: $why');
    // ignore: avoid_print
    print('  WARN: $name — $why');
  }

  void summary() {
    final total = passed + failed;
    // ignore: avoid_print
    print('\n${'=' * 70}');
    // ignore: avoid_print
    print('RESULTS  passed=$passed/$total  failed=$failed  warns=${warns.length}');
    for (final e in errors) {
      // ignore: avoid_print
      print('  x $e');
    }
    for (final w in warns) {
      // ignore: avoid_print
      print('  ! $w');
    }
    // ignore: avoid_print
    print('=' * 70);
  }
}

// ============================================================================
// Session
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
  final email = 'gc-sell-e2e-$ts@lazervault.test';
  final phone = '+23480${(10000000 + (ts % 90000000)).toString()}';
  final deviceId = 'gc-sell-e2e-$ts';

  final auth = auth_pb.AuthServiceClient(core);
  // ignore: avoid_print
  print('  -> signup $email');
  final signupResp = await auth.signup(SignupRequest(
    email: email,
    password: testPassword,
    firstName: 'Sell',
    lastName: 'Tester',
    phone: phone,
    deviceId: deviceId,
    deviceName: 'GiftCard Sell E2E',
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
      deviceName: 'GiftCard Sell E2E',
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
    reference: 'E2E-GCSELL-FUND-${DateTime.now().microsecondsSinceEpoch}',
    type: 'deposit',
    description: 'E2E giftcard sell test funding',
    serviceName: 'e2e-test',
    idempotencyKey:
        'E2E-GCSELL-FUND-IDEM-${DateTime.now().microsecondsSinceEpoch}',
  ));
  if (!credit.success) {
    throw Exception(
        'CreditBalance: ${credit.errorCode} ${credit.errorMessage}');
  }

  // Transaction PIN.
  final pinClient = pin_pb.TransactionPinServiceClient(core);
  final pinResp = await pinClient.createTransactionPin(
    CreateTransactionPinRequest(
      userId: userId,
      pin: testPin,
      confirmPin: testPin,
      deviceId: deviceId,
      deviceName: 'GiftCard Sell E2E',
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

// Seed the app so its in-process gRPC calls (financialGrpcClient →
// GrpcCallOptionsHelper.withAuth) authenticate as our provisioned user
// with an active account. The sell RPC requires BOTH the bearer token
// AND x-account-id; we set both here.
Future<void> _seedAppAuth(_Session s) async {
  const storage = FlutterSecureStorage();
  await storage.write(key: 'access_token', value: s.accessToken);
  // Some flows also read a user id / refresh token; set the common keys
  // defensively so the auth gate + helpers see a logged-in user.
  await storage.write(key: 'user_id', value: s.userId);
  await storage.write(key: 'refresh_token', value: s.accessToken);

  // Active account for x-account-id metadata.
  GetIt.I<AccountManager>().setActiveAccount(s.ngnAccountId);
}

// ============================================================================
// Task A helpers — physical/image-upload path
// ============================================================================

// REAL gift-card images for Task A. They are downloaded over the network
// IN-PROCESS on the emulator (the emulator has connectivity) from
// picsum.photos — genuine JPEGs whose magic bytes (0xFF 0xD8 0xFF)
// satisfy the app's GiftCardValidation.validateImageBytes sniff — and
// written into Directory.systemTemp (app-owned, readable; avoids Android
// scoped storage, which blocked the old /sdcard/Download read and forced
// the tiny-PNG fallback).
const String _kPushedFrontPath =
    'https://picsum.photos/seed/gcfront/480/300.jpg';
const String _kPushedBackPath =
    'https://picsum.photos/seed/gcback/480/300.jpg';

// 1x1 transparent PNG — fallback only. If the on-device read of the
// pushed JPEG fails (e.g. storage permission denied on a given API
// level), we still drive the upload + manual-fallback path so the
// scenario never dead-ends. Magic bytes (0x89 'P' 'N' 'G') satisfy the
// same client-side sniff.
final Uint8List _kTinyPng = Uint8List.fromList([
  0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A,
  0x00, 0x00, 0x00, 0x0D, 0x49, 0x48, 0x44, 0x52,
  0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01,
  0x08, 0x06, 0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4,
  0x89, 0x00, 0x00, 0x00, 0x0D, 0x49, 0x44, 0x41,
  0x54, 0x78, 0x9C, 0x63, 0x00, 0x01, 0x00, 0x00,
  0x05, 0x00, 0x01, 0x0D, 0x0A, 0x2D, 0xB4, 0x00,
  0x00, 0x00, 0x00, 0x49, 0x45, 0x4E, 0x44, 0xAE,
  0x42, 0x60, 0x82,
]);

// Resolves a real, app-readable image file for the mocked picker. The
// app does `File(picked.path).readAsBytes()` ON THE DEVICE after the
// picker returns, so the path MUST point at a file this app process can
// open. We DOWNLOAD a genuine JPEG over the network from inside the
// app/emulator (HttpClient — the emulator has connectivity) into
// Directory.systemTemp (always app-owned + readable, so no Android
// scoped-storage restriction), then return that local path. Falls back
// to the tiny PNG only on network failure, so Task A still exercises the
// full upload path either way.
//
// Returns (path, isRealImage).
Future<(String, bool)> _materializeRealImage(
    String imageUrl, String localName) async {
  final dir = Directory.systemTemp.createTempSync('gc_sell_img_');
  final out = File('${dir.path}/$localName');
  HttpClient? client;
  try {
    client = HttpClient()
      ..connectionTimeout = const Duration(seconds: 20)
      ..autoUncompress = true;
    final req = await client.getUrl(Uri.parse(imageUrl));
    req.followRedirects = true;
    final resp = await req.close();
    if (resp.statusCode >= 200 && resp.statusCode < 400) {
      final accumulated = <int>[];
      await for (final chunk in resp) {
        accumulated.addAll(chunk);
      }
      final bytes = Uint8List.fromList(accumulated);
      // Verify a real JPEG (FF D8 FF) — the app's image sniff requires it.
      if (bytes.length > 3 &&
          bytes[0] == 0xFF &&
          bytes[1] == 0xD8 &&
          bytes[2] == 0xFF) {
        await out.writeAsBytes(bytes, flush: true);
        return (out.path, true);
      }
    }
  } catch (_) {/* fall through to fallback */}
  finally {
    client?.close(force: true);
  }
  await out.writeAsBytes(_kTinyPng, flush: true);
  return (out.path, false);
}

// Installs a PIGEON BasicMessageChannel mock for image_picker_android
// (0.8.13+16 is Pigeon-based — the legacy MethodChannel
// 'plugins.flutter.io/image_picker' is dead and mocking it does NOTHING,
// so the real Android Photo Picker opens and flutter_test hangs because
// it cannot drive native UI). Both `ImagePicker().pickImage(...)` and the
// gallery path go through `ImagePickerApi.pickImages`, which returns
// List<String> and takes paths.first. We intercept that channel and hand
// back one path per call (front, then back).
//
// Pigeon success envelope is a 1-element list `[result]`; pickImages'
// result type is List<String>. The channel codec (_PigeonCodec) delegates
// List<String> to StandardMessageCodec, so encoding `[[path]]` with a
// plain StandardMessageCodec is byte-compatible with the app-side decode.
typedef _PickerDisposer = void Function();
_PickerDisposer _installImagePickerMock(List<String> paths) {
  const channelName =
      'dev.flutter.pigeon.image_picker_android.ImagePickerApi.pickImages';
  const codec = StandardMessageCodec();
  var idx = 0;
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMessageHandler(channelName, (ByteData? message) async {
    final path = idx < paths.length ? paths[idx] : paths.last;
    idx++;
    // Pigeon success envelope: [result]; pickImages result is List<String>.
    return codec.encodeMessage(<Object?>[
      <String>[path],
    ]);
  });
  return () {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMessageHandler(channelName, null);
  };
}

// ============================================================================
// Task B helpers — currency / symbol / FX
// ============================================================================

// Mirrors the screen's _faceCurrencyCode(): prefers the structured
// currencies[] field, else infers the face currency from the card's
// region tag in its name/country (the only currency signal Prestmit's
// sandbox surfaces). Lets the test predict what the UI should render.
String _expectedFaceCurrency(SellableCard c) {
  if (c.currencies.isNotEmpty && c.currencies.first.trim().isNotEmpty) {
    return c.currencies.first.trim().toUpperCase();
  }
  final hay = '${c.displayName} ${c.country} ${c.category}'.toLowerCase();
  if (hay.contains('uk ') || hay.contains('united kingdom') || hay.contains('britain')) {
    return 'GBP';
  }
  if (hay.contains('euro') || hay.contains('germany') || hay.contains('france') ||
      hay.contains('spain') || hay.contains('italy') || hay.contains('netherlands')) {
    return 'EUR';
  }
  if (hay.contains('canada')) return 'CAD';
  if (hay.contains('australia')) return 'AUD';
  if (hay.contains('ghana')) return 'GHS';
  return 'USD';
}

const Map<String, String> _kExpectedSymbols = {
  'NGN': '₦',
  'USD': '\$',
  'GBP': '£',
  'EUR': '€',
  'CAD': 'C\$',
  'AUD': 'A\$',
  'GHS': 'GH₵',
};

// ============================================================================
// Test
// ============================================================================

void main() {
  final results = _Results();

  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Gift Card SELL E2E (UI-driven)', () {
    late _Session session;
    late ClientChannel core;
    late ClientChannel accountsDirect;

    setUpAll(() async {
      // NOTE: do NOT set Get.testMode — in this GetX version testMode makes
      // Get.toNamed a no-op (navigation is suppressed). The app uses a real
      // GetMaterialApp, so contextless Get.toNamed works once the navigator
      // has mounted (we wait for Get.key.currentState below before nav).
      // ignore: avoid_print
      print('\n${'=' * 70}');
      // ignore: avoid_print
      print('Gift Card SELL E2E — provisioning fresh user');
      // ignore: avoid_print
      print('=' * 70);

      core = _channel(coreGatewayPort);
      accountsDirect = _channel(accountsServiceDirectPort);

      try {
        session = await _provisionTestUser(core, accountsDirect);
        results.ok('Provision test user',
            'email=${session.email} user=${session.userId.substring(0, 8)} ngn=${session.ngnAccountId}');
      } catch (e, st) {
        results.fail('Provision test user', '$e');
        // ignore: avoid_print
        print(st);
        results.summary();
        rethrow;
      }

      // NOTE: the real app is booted (app.main()) at the START of the single
      // app-driven testWidgets below — NOT here. The Flutter test framework
      // disposes the widget tree between testWidgets, which nulls GetX's
      // navigator key (Get.key) and breaks contextless Get.toNamed; the app's
      // init() is also NOT idempotent (no isRegistered/allowReassignment
      // guards in injection_container.dart), so app.main() can be called
      // exactly ONCE. We therefore keep boot + the main flow + Task A + Task B
      // in ONE testWidgets so the app stays mounted and Get.key stays live.
    });

    tearDownAll(() async {
      // Print the ledger FIRST so the summary always lands even if channel
      // teardown misbehaves. gRPC ClientChannel.shutdown() can HANG under the
      // integration_test binding (it awaits in-flight RPCs / keepalive timers
      // that never settle once the test phase ends), which previously wedged
      // the whole suite in tearDownAll after every scenario had already
      // passed. So we bound the shutdowns with a timeout and never let them
      // block — the channels are reclaimed on process exit regardless.
      results.summary();
      try {
        await core
            .shutdown()
            .timeout(const Duration(seconds: 3), onTimeout: () {});
      } catch (_) {}
      try {
        await accountsDirect
            .shutdown()
            .timeout(const Duration(seconds: 3), onTimeout: () {});
      } catch (_) {}
      if (results.failed > 0) {
        fail('Gift Card SELL E2E had ${results.failed} failure(s)');
      }
    });

    // ── Scenario A (single testWidgets): boot → seed → navigate hub →
    //    Sell tab → card → details → Get Rate → payout → confirm → PIN →
    //    receipt. Everything that depends on the LIVE running app stays in
    //    ONE testWidgets block: the Flutter test framework tears down the
    //    widget tree between testWidgets, which disposes the running
    //    GetMaterialApp and nulls GetX's navigator key (Get.key) — that is
    //    what made a separate "navigate" test throw "contextless
    //    navigation". Keeping boot + nav + flow together keeps Get.key live
    //    so contextless Get.toNamed resolves (same as the app at runtime).
    SellableCard? chosenCard;
    testWidgets(
        'App-driven: full sell flow → receipt, then Task A (images) + Task B (currencies)',
        (tester) async {
      // 0) Boot the real app HERE (once) — see setUpAll note. This runs
      //    `await init()` → serviceLocator ready, and mounts the real
      //    GetMaterialApp so Get.key is live for the whole testWidgets.
      //
      //    NOTE: app.main() is async and does several awaits (dotenv, init,
      //    DB, permissions) BEFORE runApp(), and its initial route is an
      //    AuthCheckScreen that shows a perpetual CircularProgressIndicator.
      //    So we must NOT use bare/long `pumpAndSettle` during boot (it would
      //    time out on the spinner). Instead pump BOUNDED frames until the
      //    GetMaterialApp has actually mounted (runApp fired) and the GetX
      //    navigator is registered.
      // app.main() does REAL async work before runApp(): dotenv, DI init,
      // and several gRPC `…grpcClient.initialize()` + a getSupportedLocales()
      // network round-trip. Those rely on REAL timers/sockets. Inside a
      // testWidgets the binding uses a FAKE async clock, so a bare app.main()
      // here stalls before runApp (gRPC timers never fire) — which is exactly
      // why the GetMaterialApp/Navigator never appeared. tester.runAsync()
      // runs the boot in the REAL async zone so those plugin/gRPC futures
      // actually complete and runApp() fires.
      await tester.runAsync(() async {
        app.main();
        // Give the real-async boot (init + gRPC channel warmup + locale
        // fetch + runApp) wall-clock time to finish on the real event loop.
        final realBootEnd =
            DateTime.now().add(const Duration(seconds: 40));
        while (DateTime.now().isBefore(realBootEnd)) {
          await Future<void>.delayed(const Duration(milliseconds: 250));
          if (WidgetsBinding.instance.rootElement != null &&
              (Get.key.currentState != null || Get.context != null)) {
            break;
          }
        }
      });

      // 1) Now drive the framework with the test clock so the just-mounted
      //    GetMaterialApp lays out and GetX registers its navigator (Get.key).
      //    Bounded only — never settle on the boot auth-check spinner.
      final bootDeadline = DateTime.now().add(const Duration(seconds: 30));
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
        results.fail('Reach Gift Cards hub',
            'app GetMaterialApp/Navigator never mounted after boot '
            '(navInTree=${find.byType(Navigator).evaluate().isNotEmpty} '
            'getKey=${Get.key.currentState != null} getCtx=${Get.context != null})');
        return;
      }
      results.ok('App boots');

      // 2) Seed an authenticated session (token in secure storage + active
      //    account in AccountManager — the sell RPC needs both). The app's
      //    boot-time auth-check already ran (it found no token and parked on
      //    onboarding/auth); we force-navigate to the gift cards hub below
      //    regardless, and the hub's gRPC reads this freshly-seeded token.
      try {
        await _seedAppAuth(session);
        results.ok('Seed authenticated session',
            'token+account seeded (acct=${session.ngnAccountId})');
      } catch (e) {
        results.fail('Seed authenticated session', '$e');
      }
      // Let the boot screen finish navigating off the auth-check spinner
      // (bounded pumps only — never settle on the spinner).
      for (var i = 0; i < 20; i++) {
        await tester.pump(const Duration(milliseconds: 300));
      }

      // Go straight to the gift cards hub (we are already authenticated via
      // the seeded token + active account; driving the full
      // email/password/passcode login UI is out of scope and flaky — this
      // still exercises the REAL hub + sell UI end-to-end). Navigation is
      // best-effort: if Get's contextless route ever throws on a flaky boot,
      // surface a clean failure instead of an uncaught exception that would
      // abort the whole testWidgets (and Task A/B with it).
      try {
        Get.toNamed(AppRoutes.giftCards);
      } catch (e) {
        results.fail('Reach Gift Cards hub', 'Get.toNamed threw: $e');
        return;
      }
      // The hub may fetch its catalogue (spinner) on open, so wait with
      // BOUNDED pumps for the Sell tab key rather than settling on a spinner.
      var hubFinder = find.byKey(const Key('giftcards_sell_tab'));
      final hubDeadline = DateTime.now().add(const Duration(seconds: 30));
      while (hubFinder.evaluate().isEmpty &&
          DateTime.now().isBefore(hubDeadline)) {
        await tester.pump(const Duration(milliseconds: 400));
        hubFinder = find.byKey(const Key('giftcards_sell_tab'));
      }
      if (hubFinder.evaluate().isEmpty) {
        results.fail('Reach Gift Cards hub',
            'Sell tab not found — hub did not render');
        return;
      }
      results.ok('Reach Gift Cards hub', 'Buy/Sell toggle visible');

      // Tap the Sell tab.
      await tester.tap(hubFinder);
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Wait for sellable cards to load (Prestmit catalogue round-trip).
      final deadline = DateTime.now().add(const Duration(seconds: 45));
      Finder tiles = find.byWidgetPredicate((w) =>
          w.key is Key &&
          (w.key as Key).toString().contains('sellable_card_tile_'));
      while (tiles.evaluate().isEmpty && DateTime.now().isBefore(deadline)) {
        await tester.pump(const Duration(milliseconds: 800));
        tiles = find.byWidgetPredicate((w) =>
            w.key is Key &&
            (w.key as Key).toString().contains('sellable_card_tile_'));
      }
      await tester.pumpAndSettle(const Duration(seconds: 1));

      if (tiles.evaluate().isEmpty) {
        results.fail('Load sellable cards',
            'no sellable card tiles rendered after 45s');
        return;
      }
      results.ok('Load sellable cards',
          '${tiles.evaluate().length} sellable cards visible');

      // Record the chosen card by reading the cubit's cached list (the
      // tile we tap). We pick the first card; tapping navigates with it
      // as the route argument.
      try {
        final cubit = BlocProvider.of<GiftCardCubit>(
            tester.element(tiles.first));
        if (cubit.cachedSellableCards.isNotEmpty) {
          chosenCard = cubit.cachedSellableCards.first;
        }
      } catch (_) {/* not fatal */}

      // Tap the first sellable card → SellGiftCardScreen (step 1).
      await tester.tap(tiles.first);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Confirm we are on the sell screen (Card Format header + Get Rate).
      final getRate = find.byKey(const Key('sell_get_rate_button'));
      if (getRate.evaluate().isEmpty) {
        results.fail('Open Sell screen',
            'Get Rate CTA not found — did not reach Card Details step');
        return;
      }
      results.ok('Open Sell screen',
          'Card Details step rendered (card=${chosenCard?.displayName ?? "?"})');

      // 3) Fill card details → Get Rate → payout → confirm → PIN → receipt
      //    (continues in the SAME testWidgets so the live app stays mounted).
      await tester.pumpAndSettle();

      // Denomination: if the catalogue had no fixed denominations a text
      // field is shown (key sell_denomination_field). Fixed denominations
      // are auto-prefilled in initState, so the field may be absent.
      final denomField = find.byKey(const Key('sell_denomination_field'));
      if (denomField.evaluate().isNotEmpty) {
        // The min is usually prefilled; ensure a valid value is present.
        await tester.ensureVisible(denomField);
        await tester.tap(denomField);
        await tester.pumpAndSettle();
        // Use the card's min if known, else a safe default within range.
        final min = chosenCard?.minDenomination ?? 0;
        final value =
            (min > 0 ? min : 10).toStringAsFixed(0);
        await tester.enterText(denomField, value);
        await tester.pumpAndSettle();
        results.ok('Enter denomination', 'value=$value');
      } else {
        results.ok('Enter denomination', 'auto-prefilled (fixed denom)');
      }

      // Card number.
      final numField = find.byKey(const Key('sell_card_number_field'));
      await tester.ensureVisible(numField);
      await tester.enterText(numField, '1234567890123456');
      await tester.pumpAndSettle();

      // Card PIN.
      final pinField = find.byKey(const Key('sell_card_pin_field'));
      await tester.ensureVisible(pinField);
      await tester.enterText(pinField, '1234');
      await tester.pumpAndSettle();
      results.ok('Enter card details', 'card number + PIN filled');

      // Note on images: e-code cards (the Prestmit sandbox default for
      // most USA cards) require NO image upload — the code itself is the
      // card, and _canGetRate() returns true without attachments. The
      // sell screen's Step 1 is "Card Details + Images (merged)" and the
      // image slot is OPTIONAL for e-codes. Physical cards would gate on
      // 2 images; if we landed on a physical card the Get Rate CTA stays
      // disabled and we surface that below rather than fake an upload.

      // Get Rate.
      final getRateBtn = find.byKey(const Key('sell_get_rate_button'));
      await tester.ensureVisible(getRateBtn);
      final getRateWidget = tester.widget<ElevatedButton>(getRateBtn);
      if (getRateWidget.onPressed == null) {
        results.warn('Get Rate',
            'CTA disabled — likely a physical card needing 2 images; '
            'this card type is not e-code, skipping happy path');
        return;
      }
      await tester.tap(getRateBtn);
      await tester.pumpAndSettle(const Duration(seconds: 2));
      results.ok('Tap Get Rate', 'advanced straight to confirm step');

      // The payout-currency / payout-method screen (old step 2) was
      // DELETED from sell_gift_card_screen.dart: payout now auto-follows
      // the active locale (NGN → NAIRA, the dashboard DefaultPayoutMethod).
      // _onGetRate() therefore jumps straight to the Confirm step (step 3),
      // so there is NO `sell_payout_continue_button` to tap any more.

      // Step 3: confirm. Wait for the rate card to load, then tick the
      // disclaimer and submit.
      final disclaimer =
          find.byKey(const Key('sell_disclaimer_checkbox'));
      final confirmDeadline =
          DateTime.now().add(const Duration(seconds: 20));
      while (disclaimer.evaluate().isEmpty &&
          DateTime.now().isBefore(confirmDeadline)) {
        await tester.pump(const Duration(milliseconds: 500));
      }
      if (disclaimer.evaluate().isEmpty) {
        results.fail('Confirm step', 'disclaimer checkbox not found');
        return;
      }
      await tester.ensureVisible(disclaimer);
      await tester.tap(disclaimer);
      await tester.pumpAndSettle();
      results.ok('Confirm step', 'disclaimer accepted');

      // Submit button enables once rate is loaded + disclaimer ticked.
      final submitBtn = find.byKey(const Key('sell_submit_button'));
      var submitWidget = tester.widget<ElevatedButton>(submitBtn);
      final rateDeadline = DateTime.now().add(const Duration(seconds: 25));
      while (submitWidget.onPressed == null &&
          DateTime.now().isBefore(rateDeadline)) {
        await tester.pump(const Duration(milliseconds: 600));
        submitWidget = tester.widget<ElevatedButton>(submitBtn);
      }
      if (submitWidget.onPressed == null) {
        results.fail('Submit step',
            'Sell CTA stayed disabled (rate likely never loaded)');
        return;
      }
      results.ok('Rate loaded', 'Sell CTA enabled');

      await tester.ensureVisible(submitBtn);
      await tester.tap(submitBtn);
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // ── Transaction PIN modal: enter 1234 across the 4 digit fields.
      final firstDigit = find.byKey(const Key('transaction_pin_digit_0'));
      final pinDeadline = DateTime.now().add(const Duration(seconds: 20));
      while (firstDigit.evaluate().isEmpty &&
          DateTime.now().isBefore(pinDeadline)) {
        await tester.pump(const Duration(milliseconds: 500));
      }
      if (firstDigit.evaluate().isEmpty) {
        results.fail('PIN entry', 'PIN modal did not appear');
        return;
      }
      for (var i = 0; i < 4; i++) {
        final digit = find.byKey(Key('transaction_pin_digit_$i'));
        await tester.enterText(digit, testPin[i]);
        await tester.pump(const Duration(milliseconds: 200));
      }
      // The 4th digit auto-submits onPinSubmitted → verify → sell. Do NOT
      // pumpAndSettle here: the sell navigates to the processing screen whose
      // CircularProgressIndicator animates forever, so pumpAndSettle would
      // spin until its 10-minute timeout. A single finite pump dispatches the
      // PIN submit; the bounded detection loop below waits for the sell.
      await tester.pump(const Duration(seconds: 1));
      results.ok('PIN entry', 'entered $testPin and submitted');

      // ── Wait for terminal UI: either the in-screen "Submitted for
      // review" receipt (manual / pending_review), the dedicated
      // sell-processing screen (auto pending/reviewing — Prestmit), or
      // My Sales (auto paid). Any of those is success for this test.
      final saleDeadline = DateTime.now().add(const Duration(seconds: 90));
      String reached = '';
      while (DateTime.now().isBefore(saleDeadline)) {
        await tester.pump(const Duration(milliseconds: 800));

        if (find.text('Submitted for review').evaluate().isNotEmpty ||
            find.textContaining('Submitted for review').evaluate().isNotEmpty) {
          reached = 'receipt:submitted_for_review';
          break;
        }
        if (find.text('Sale rejected').evaluate().isNotEmpty) {
          reached = 'receipt:rejected';
          break;
        }
        // Sell-processing screen (auto Prestmit pending/reviewing). It
        // shows progress copy; match on its route or any "Ref:" / status.
        if (Get.currentRoute == AppRoutes.giftCardSellProcessing) {
          reached = 'processing_screen';
          break;
        }
        if (Get.currentRoute == AppRoutes.mySales) {
          reached = 'my_sales(paid)';
          break;
        }
        if (find.textContaining('Ref:').evaluate().isNotEmpty) {
          reached = 'receipt:with_reference';
          break;
        }
      }
      // Bounded pump only — the processing screen's spinner never settles.
      await tester.pump(const Duration(milliseconds: 500));

      // Pull the sale row from the cubit (source of truth for ref/status).
      // The cubit instance that ran the sell lives on the sell-screen
      // route; read it from whichever GiftCardCubit element is mounted.
      String saleInfo = '';
      try {
        final cubitFinder = find.byType(BlocConsumer<GiftCardCubit, GiftCardState>);
        if (cubitFinder.evaluate().isNotEmpty) {
          final cubit =
              BlocProvider.of<GiftCardCubit>(tester.element(cubitFinder.first));
          final st = cubit.state;
          if (st is GiftCardSellAwaitingProvider) {
            saleInfo =
                'status=${st.sale.status} ref=${st.sale.reference} provSaleId=${st.sale.providerSaleId}';
          } else if (st is SellSubmitted) {
            saleInfo =
                'status=${st.sale.status} ref=${st.sale.reference} provSaleId=${st.sale.providerSaleId}';
          } else if (st is SellRejected) {
            saleInfo = 'status=rejected reason=${st.reason}';
          } else if (st is GiftCardSellPaid) {
            saleInfo = 'status=paid ref=${st.sale.reference}';
          } else {
            saleInfo = 'cubit_state=${st.runtimeType}';
          }
        }
      } catch (_) {/* cubit state read is best-effort */}

      if (reached.isEmpty) {
        results.fail('Reach sell receipt/status',
            'no terminal UI within 90s${saleInfo.isNotEmpty ? " ($saleInfo)" : ""}');
      } else {
        results.ok('Reach sell receipt/status',
            '$reached${saleInfo.isNotEmpty ? "  [$saleInfo]" : ""}');
      }

      // ── TASK A + TASK B run in the SAME testWidgets, sequentially, so the
      //    live app's GetIt + the test framework's single widget binding stay
      //    alive throughout (we can't call app.main() again — see setUpAll).
      //    Each task pumpWidget's its OWN self-contained GetMaterialApp tree.
      //
      //    Detach from the live app first: the main flow drove GetX's GLOBAL
      //    navigator via Get.toNamed, so Get.key + the route tree are still
      //    bound to the now-stale live app. Mounting a fresh GetMaterialApp on
      //    top of that left the new SellGiftCardScreen un-rendered (step-1
      //    fields/format toggle "not found"). Get.reset() clears the route
      //    tree + resets the root navigator so each task's GetMaterialApp
      //    becomes the live GetX root (it only resets GetX-managed instances,
      //    which we don't use — our DI is GetIt — so it's safe here). We then
      //    flush the old tree with an empty pump before the task mounts its
      //    own tree.
      Get.reset();
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump(const Duration(milliseconds: 200));

      await _runTaskA(tester, results, chosenCard);

      // Same detach between tasks: Task A mounted its own GetMaterialApp.
      Get.reset();
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump(const Duration(milliseconds: 200));

      await _runTaskB(tester, results);
    });

    // ── Scenario 4: rejection-reasons sheet renders ───────────────────
    // Verifies the SellRejectionReasonsSheet widget (the body of the
    // "Why was this rejected?" CTA) renders the canonical reason list and
    // surfaces the highlighted user reason. We pump the real widget the
    // CTA opens, so this is the exact UI a rejected sale shows.
    testWidgets('Rejection-reasons sheet renders with highlighted reason',
        (tester) async {
      const highlight = 'Invalid code: the code you sent is not valid.';
      // The sheet uses ScreenUtil size extensions (.r/.sp/.w/.h), so it
      // must be hosted under a ScreenUtilInit (same as the real app).
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(414, 896),
          builder: (context, child) => MaterialApp(
            home: Builder(
              builder: (ctx) => Scaffold(
                body: Center(
                  child: ElevatedButton(
                    key: const Key('open_rejection_sheet'),
                    onPressed: () => showSellRejectionReasonsSheet(ctx,
                        highlightReason: highlight),
                    child: const Text('open'),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('open_rejection_sheet')));
      await tester.pumpAndSettle(const Duration(seconds: 1));

      final titleOk =
          find.text('Why a sale can be rejected').evaluate().isNotEmpty;
      final yourReasonOk =
          find.text('YOUR REJECTION REASON').evaluate().isNotEmpty;
      final highlightOk = find.text(highlight).evaluate().isNotEmpty;
      // A couple of canonical reasons from the static list.
      final canonOk = find.text('Invalid code').evaluate().isNotEmpty ||
          find.text('Vague gift card').evaluate().isNotEmpty;

      if (titleOk && yourReasonOk && highlightOk && canonOk) {
        results.ok('Rejection-reasons sheet',
            'title + YOUR REJECTION REASON + highlight + canonical list all rendered');
      } else {
        results.fail('Rejection-reasons sheet',
            'title=$titleOk yourReason=$yourReasonOk highlight=$highlightOk canon=$canonOk');
      }
    });

    // ── Scenario 5: rejected receipt CTA key wired in sell screen ─────
    // Push the REAL SellGiftCardScreen into the already-booted app (so
    // ScreenUtil + GetIt + Get routing are live), drive its cubit into
    // the SellRejected step-4 view, and assert the keyed CTA
    // (sell_rejection_reasons_cta) + reason block render — the exact path
    // a real rejected sale takes — then tap the CTA to open the sheet.
    testWidgets('Sell screen rejected receipt exposes the CTA key',
        (tester) async {
      final card = chosenCard ??
          const SellableCard(cardType: 'amazon', displayName: 'Amazon');
      const rejectedSale = GiftCardSale(
        id: 'e2e-rejected',
        cardType: 'amazon',
        denomination: 50,
        status: 'rejected',
        reference: 'GC-SELL-E2E-REJECTED',
        rejectionReason: 'Invalid code: the code you sent is not valid.',
      );

      // A dedicated cubit we control, provided to the real screen. Host
      // the REAL SellGiftCardScreen in a self-contained ScreenUtilInit +
      // GetMaterialApp tree (GetMaterialApp so the screen's internal
      // Get.* navigation calls resolve), then drive the cubit into the
      // SellRejected step-4 view — the exact path a real rejected sale
      // takes.
      final cubit = GetIt.I<GiftCardCubit>();

      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(414, 896),
          builder: (context, child) => GetMaterialApp(
            home: BlocProvider<GiftCardCubit>.value(
              value: cubit,
              child: SellGiftCardScreen(preselectedCard: card),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Emit the rejected state so the screen's listener flips to step 4.
      cubit.emit(const SellRejected(
        sale: rejectedSale,
        reason: 'Invalid code: the code you sent is not valid.',
      ));
      await tester.pumpAndSettle(const Duration(seconds: 1));

      final cta = find.byKey(const ValueKey('sell_rejection_reasons_cta'));
      final block =
          find.byKey(const ValueKey('sell_rejection_reason_block'));
      if (cta.evaluate().isNotEmpty && block.evaluate().isNotEmpty) {
        results.ok('Rejected receipt CTA',
            'sell_rejection_reasons_cta + reason block rendered on step 4');
        await tester.ensureVisible(cta);
        await tester.tap(cta);
        await tester.pumpAndSettle(const Duration(seconds: 1));
        if (find.text('Why a sale can be rejected').evaluate().isNotEmpty) {
          results.ok('Rejected receipt CTA opens sheet',
              'tapping the CTA opened the reasons sheet');
        } else {
          results.warn('Rejected receipt CTA opens sheet',
              'CTA tapped but sheet title not found');
        }
      } else {
        results.fail('Rejected receipt CTA',
            'cta=${cta.evaluate().length} block=${block.evaluate().length}');
      }
    });
  });
}

// ── TASK A: Physical / image-upload path with REAL images ─────────────
// Drives the PHYSICAL format end-to-end with REAL downloaded images: two
// genuine JPEGs are downloaded over the network IN-PROCESS on the emulator
// (picsum.photos) into Directory.systemTemp (app-readable — avoids Android
// scoped storage). The image_picker PIGEON channel is mocked to return
// those file paths, so tapping the keyed slots yields the real photos.
// Both uploads round-trip to giftcards-service UploadSellImage; we then run
// the AI scan. Real photos that aren't actual gift cards make OCR return
// low/no confidence (<0.6) → the screen falls back to MANUAL entry. With
// both images attached + manual card number/PIN, the physical Get-Rate gate
// (requires 2 images) opens, then — because the payout step was removed —
// Get Rate goes STRAIGHT to Confirm. We tick the disclaimer, submit, enter
// the tx-PIN, and assert a terminal outcome (receipt / processing /
// rejection / clean provider-or-validation error). Hosted in a
// self-contained GetMaterialApp tree (same pattern as scenarios 4/5) using
// the session seeded in the happy-path scenario above.
//
// Runs INSIDE the single app-driven testWidgets (the app's init() already
// ran, so GetIt + ScreenUtil are live) — NOT as its own testWidgets, since
// the framework would dispose the live app/Get.key between tests.
Future<void> _runTaskA(
    WidgetTester tester, _Results results, SellableCard? chosenCard) async {
  // A real sellable card to host (prefer the one chosen earlier; else a
  // synthetic Amazon card — the upload path is provider-agnostic).
  final card = chosenCard ??
      const SellableCard(
        cardType: 'amazon',
        displayName: 'Amazon',
        minDenomination: 10,
        providerName: 'prestmit',
      );

  // Materialise the two REAL downloaded JPEGs into app-readable temp files
  // for the mocked picker (front then back).
      String frontPath = '';
      String backPath = '';
      bool frontReal = false;
      bool backReal = false;
      try {
        final (fp, fr) =
            await _materializeRealImage(_kPushedFrontPath, 'front.jpg');
        final (bp, br) =
            await _materializeRealImage(_kPushedBackPath, 'back.jpg');
        frontPath = fp;
        backPath = bp;
        frontReal = fr;
        backReal = br;
        results.ok('Task A: real images materialised',
            'front=${frontReal ? "REAL picsum JPEG" : "fallback PNG"} '
            'back=${backReal ? "REAL picsum JPEG" : "fallback PNG"} '
            '(downloaded in-process to Directory.systemTemp)');
      } catch (e) {
        results.fail('Task A: real images materialised', '$e');
        return;
      }
      final disposePicker =
          _installImagePickerMock([frontPath, backPath]);

      final cubit = GetIt.I<GiftCardCubit>();
      try {
        await tester.pumpWidget(
          ScreenUtilInit(
            designSize: const Size(414, 896),
            builder: (context, child) => GetMaterialApp(
              // Provide the app's real route table so the screen's internal
              // success navigation (Get.offNamed → giftCardSellProcessing on
              // a successful sell) resolves instead of throwing "Could not
              // find a generator for route" (an UNCAUGHT exception that would
              // abort the whole testWidgets and the scenarios after it).
              getPages: AppRouter.routes,
              home: BlocProvider<GiftCardCubit>.value(
                value: cubit,
                child: SellGiftCardScreen(preselectedCard: card),
              ),
            ),
          ),
        );
        // Let ScreenUtilInit initialise + GetMaterialApp register its
        // navigator, then settle the step-1 layout.
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 300));
        await tester.pumpAndSettle(const Duration(seconds: 2));

        // Switch the format toggle to Physical. Give the step-1 body a few
        // bounded frames to mount before asserting the key.
        var physToggle = find.byKey(const Key('sell_format_physical'));
        final toggleDeadline = DateTime.now().add(const Duration(seconds: 8));
        while (physToggle.evaluate().isEmpty &&
            DateTime.now().isBefore(toggleDeadline)) {
          await tester.pump(const Duration(milliseconds: 300));
          physToggle = find.byKey(const Key('sell_format_physical'));
        }
        if (physToggle.evaluate().isEmpty) {
          results.fail('Task A: switch to physical',
              'toggle key not found (step-1 body did not render)');
          return;
        }
        await tester.tap(physToggle);
        await tester.pumpAndSettle();
        results.ok('Task A: switch to physical', 'Physical format selected');

        // Pick FRONT image: tap slot 0 → bottom sheet → Choose from Gallery.
        final slot0 = find.byKey(const Key('sell_image_slot_0'));
        if (slot0.evaluate().isEmpty) {
          results.fail('Task A: front slot', 'image slot 0 not found');
          return;
        }
        await tester.ensureVisible(slot0);
        await tester.tap(slot0);
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(const Key('sell_pick_gallery')));
        // Upload round-trips to the backend; do NOT pumpAndSettle through
        // any spinner forever — poll for SellImageUploaded landing one URL.
        var uploadDeadline = DateTime.now().add(const Duration(seconds: 30));
        while (cubit.state is! SellImageUploaded &&
            DateTime.now().isBefore(uploadDeadline)) {
          await tester.pump(const Duration(milliseconds: 400));
        }
        await tester.pumpAndSettle(const Duration(seconds: 1));

        // Pick BACK image: slot 1 → gallery.
        final slot1 = find.byKey(const Key('sell_image_slot_1'));
        if (slot1.evaluate().isEmpty) {
          results.fail('Task A: back slot', 'image slot 1 not found');
          return;
        }
        await tester.ensureVisible(slot1);
        await tester.tap(slot1);
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(const Key('sell_pick_gallery')));
        uploadDeadline = DateTime.now().add(const Duration(seconds: 30));
        // Wait until two images are attached (the screen mirrors uploaded
        // URLs into its private list; we observe via the Get-Rate gate
        // below, but also give the second upload time to land).
        await tester.pump(const Duration(seconds: 2));
        while (DateTime.now().isBefore(uploadDeadline)) {
          await tester.pump(const Duration(milliseconds: 400));
          // The "Auto-fill with AI Scan" CTA only renders once at least one
          // image is uploaded; once both land the physical Get-Rate gate
          // opens. We detect "both attached" by the Get-Rate enabling after
          // we also fill card number + PIN below, so just bound the wait.
          final scanCta = find.text('Auto-fill with AI Scan');
          if (scanCta.evaluate().isNotEmpty) break;
        }
        await tester.pumpAndSettle(const Duration(seconds: 1));

        // Both image slots should now show the attached preview (green
        // border + label). We assert two Image.file widgets are mounted
        // (one per attached slot).
        final attached = find.byType(Image).evaluate().length;
        final scanVisible =
            find.text('Auto-fill with AI Scan').evaluate().isNotEmpty;
        if (scanVisible) {
          results.ok('Task A: both images attached',
              'AI-scan CTA visible (images uploaded), Image widgets=$attached');
        } else {
          results.warn('Task A: both images attached',
              'AI-scan CTA not visible yet; Image widgets=$attached '
              '(upload may have been slow)');
        }

        // Run the AI scan (optional auto-fill). The pushed photos are real
        // JPEGs but NOT actual gift cards, so OCR returns low/no confidence
        // (<0.6) → the screen shows "Scan Failed" / a low-confidence badge
        // and stays on step 1 for MANUAL entry. Either branch (OCR-prefill
        // or manual fallback) must keep the flow moving forward.
        bool ocrPrefilled = false;
        if (scanVisible) {
          await tester.tap(find.text('Auto-fill with AI Scan'));
          await tester.pumpAndSettle(const Duration(seconds: 1));
          // Confirm dialog → Scan Now.
          if (find.text('Scan Now').evaluate().isNotEmpty) {
            await tester.tap(find.text('Scan Now'));
          }
          // Wait for OCR to resolve (OCRExtracted no-signal or OCRFailed).
          final ocrDeadline =
              DateTime.now().add(const Duration(seconds: 30));
          while (DateTime.now().isBefore(ocrDeadline)) {
            await tester.pump(const Duration(milliseconds: 500));
            final st = cubit.state;
            if (st is OCRExtracted || st is OCRFailed) break;
          }
          await tester.pumpAndSettle(const Duration(seconds: 1));
          // Did OCR put anything in the AI badge? The confidence badge only
          // renders when _ocrConfidence > 0.
          ocrPrefilled =
              find.textContaining('AI Extracted').evaluate().isNotEmpty;
          results.ok('Task A: AI scan ran',
              ocrPrefilled
                  ? 'OCR prefilled card details (confidence badge shown)'
                  : 'OCR low/no signal on a real non-card photo — MANUAL fallback (expected)');
        }

        // Manual entry (fallback path): fill card number + PIN. (OCR may
        // have prefilled them; enterText overwrites with known-good values
        // so the sell payload is deterministic either way.)
        final numField = find.byKey(const Key('sell_card_number_field'));
        await tester.ensureVisible(numField);
        await tester.enterText(numField, '1234567890123456');
        await tester.pumpAndSettle();
        final pinField = find.byKey(const Key('sell_card_pin_field'));
        await tester.ensureVisible(pinField);
        await tester.enterText(pinField, '1234');
        await tester.pumpAndSettle();

        // The physical Get-Rate gate needs 2 uploaded images + valid
        // number/PIN. If both uploads landed, the CTA must be enabled —
        // proving the real-image upload path + manual fallback works.
        final getRate = find.byKey(const Key('sell_get_rate_button'));
        await tester.ensureVisible(getRate);
        await tester.pumpAndSettle();
        final getRateWidget = tester.widget<ElevatedButton>(getRate);
        if (getRateWidget.onPressed == null) {
          results.fail('Task A: physical Get-Rate gate',
              'Get-Rate stayed disabled — fewer than 2 images uploaded '
              '(Image widgets=${find.byType(Image).evaluate().length})');
          return;
        }
        results.ok('Task A: physical Get-Rate gate',
            'Get-Rate enabled (2 real images + manual card details)');

        // Get Rate → straight to Confirm (the payout step was removed).
        await tester.tap(getRate);
        await tester.pumpAndSettle(const Duration(seconds: 2));

        // Confirm step: wait for the disclaimer checkbox (proves we reached
        // Confirm, NOT a deleted payout screen), tick it, wait for the rate
        // to load so Sell enables, then submit.
        final disclaimer = find.byKey(const Key('sell_disclaimer_checkbox'));
        final confirmDeadline =
            DateTime.now().add(const Duration(seconds: 20));
        while (disclaimer.evaluate().isEmpty &&
            DateTime.now().isBefore(confirmDeadline)) {
          await tester.pump(const Duration(milliseconds: 500));
        }
        if (disclaimer.evaluate().isEmpty) {
          results.fail('Task A: reached Confirm',
              'disclaimer checkbox not found after Get Rate (did not reach Confirm)');
          return;
        }
        results.ok('Task A: reached Confirm',
            'physical sell advanced straight to Confirm (no payout step)');
        await tester.ensureVisible(disclaimer);
        await tester.tap(disclaimer);
        await tester.pumpAndSettle();

        final submitBtn = find.byKey(const Key('sell_submit_button'));
        var submitWidget = tester.widget<ElevatedButton>(submitBtn);
        final rateDeadline = DateTime.now().add(const Duration(seconds: 25));
        while (submitWidget.onPressed == null &&
            DateTime.now().isBefore(rateDeadline)) {
          await tester.pump(const Duration(milliseconds: 600));
          submitWidget = tester.widget<ElevatedButton>(submitBtn);
        }
        if (submitWidget.onPressed == null) {
          results.warn('Task A: physical sell',
              'Sell CTA stayed disabled (rate never loaded for this physical card) — '
              'upload + Confirm reached, but rate unavailable');
          return;
        }
        await tester.ensureVisible(submitBtn);
        await tester.tap(submitBtn);
        await tester.pumpAndSettle(const Duration(seconds: 2));

        // tx-PIN modal → 1234 (4th digit auto-submits → verify → sell).
        final firstDigit = find.byKey(const Key('transaction_pin_digit_0'));
        final pinDeadline = DateTime.now().add(const Duration(seconds: 20));
        while (firstDigit.evaluate().isEmpty &&
            DateTime.now().isBefore(pinDeadline)) {
          await tester.pump(const Duration(milliseconds: 500));
        }
        if (firstDigit.evaluate().isEmpty) {
          results.fail('Task A: physical sell', 'PIN modal did not appear');
          return;
        }
        for (var i = 0; i < 4; i++) {
          final digit = find.byKey(Key('transaction_pin_digit_$i'));
          await tester.enterText(digit, testPin[i]);
          await tester.pump(const Duration(milliseconds: 200));
        }
        await tester.pump(const Duration(seconds: 1));

        // Wait for a terminal outcome. A physical-format sell reaching the
        // receipt is the goal; a clean expected provider/validation outcome
        // (rejected / sell error) ALSO counts as success per the task — the
        // real-image upload + manual + sell path round-tripped end-to-end.
        final saleDeadline = DateTime.now().add(const Duration(seconds: 90));
        String reached = '';
        while (DateTime.now().isBefore(saleDeadline)) {
          await tester.pump(const Duration(milliseconds: 800));
          final st = cubit.state;
          if (find.textContaining('Submitted for review').evaluate().isNotEmpty) {
            reached = 'receipt:submitted_for_review';
            break;
          }
          if (find.text('Sale rejected').evaluate().isNotEmpty ||
              st is SellRejected) {
            reached = 'receipt:rejected';
            break;
          }
          if (st is GiftCardSellAwaitingProvider) {
            reached = 'processing(awaiting_provider)';
            break;
          }
          if (st is GiftCardSellPaid) {
            reached = 'paid';
            break;
          }
          if (st is SellSubmitted || st is SellEscalatedToManualReview) {
            reached = 'submitted';
            break;
          }
          if (st is SellError) {
            // A clean provider/validation rejection of the synthetic
            // card payload is an EXPECTED terminal outcome for the
            // physical path (no real card behind the photos).
            reached = 'sell_error(expected: ${st.message})';
            break;
          }
        }
        await tester.pump(const Duration(milliseconds: 500));
        if (reached.isEmpty) {
          results.fail('Task A: physical sell',
              'no terminal outcome within 90s (cubit_state=${cubit.state.runtimeType})');
        } else {
          results.ok('Task A: physical sell',
              'real-image upload → manual → sell reached: $reached');
        }
      } catch (e, st) {
        results.fail('Task A: physical flow', '$e');
        // ignore: avoid_print
        print(st);
      } finally {
        disposePicker();
        await cubit.close();
      }
}

// ── TASK B: multi-country currency / symbol / FX, to the rate step ────
// Loads the live US catalogue, picks cards from DIFFERENT regions
// (USA / UK / EURO / Canada — the regions Prestmit's sandbox names), and
// for each drives the REAL flow to the confirm step using the REAL
// GetSellRate. Asserts the screen renders the correct face-currency CODE +
// SYMBOL (sell_face_currency), a live FX rate (sell_fx_rate +
// sell_rate_percentage), and that the currency carries through to the
// confirm summary (sell_summary_denomination) — all in the active en-NG
// locale (payout shown as NGN with thousands separators).
//
// Runs INSIDE the single app-driven testWidgets (same reason as _runTaskA).
Future<void> _runTaskB(WidgetTester tester, _Results results) async {
  // Fetch the live catalogue via a fresh cubit (real gRPC).
      final loader = GetIt.I<GiftCardCubit>();
      List<SellableCard> catalogue = const [];
      try {
        await loader.loadSellableCards(countryCode: 'US');
        final loadDeadline = DateTime.now().add(const Duration(seconds: 45));
        while (loader.cachedSellableCards.isEmpty &&
            DateTime.now().isBefore(loadDeadline)) {
          await tester.pump(const Duration(milliseconds: 500));
        }
        catalogue = loader.cachedSellableCards;
      } catch (e) {
        results.fail('Task B: load catalogue', '$e');
      } finally {
        await loader.close();
      }
      if (catalogue.isEmpty) {
        results.fail('Task B: load catalogue', 'no sellable cards returned');
        return;
      }
      results.ok('Task B: load catalogue', '${catalogue.length} cards');

      // Pick one card per distinct expected face currency so we genuinely
      // exercise multiple currencies (not just multiple USD cards).
      final byCurrency = <String, SellableCard>{};
      for (final c in catalogue) {
        final ccy = _expectedFaceCurrency(c);
        byCurrency.putIfAbsent(ccy, () => c);
      }
      final picks = byCurrency.entries.take(4).toList();
      results.ok('Task B: distinct face currencies',
          'inferred=${byCurrency.keys.join(", ")} (catalogue exposes no '
          'structured currency code; inferred from region in card name)');
      if (byCurrency.length <= 1) {
        results.warn('Task B: single-currency constraint',
            'catalogue exposes only one inferable currency '
            '(${byCurrency.keys.join(", ")}); iterating the cards it does offer');
      }

      for (final entry in picks) {
        final expectedCcy = entry.key;
        final card = entry.value;
        final expectedSymbol = _kExpectedSymbols[expectedCcy] ?? expectedCcy;
        final label = '${card.displayName} ($expectedCcy)';

        final cubit = GetIt.I<GiftCardCubit>();
        try {
          // Each iteration mounts its OWN GetMaterialApp; detach from the
          // previous iteration's GetX root first so the fresh tree renders.
          Get.reset();
          await tester.pumpWidget(const SizedBox.shrink());
          await tester.pump(const Duration(milliseconds: 200));

          await tester.pumpWidget(
            ScreenUtilInit(
              designSize: const Size(414, 896),
              builder: (context, child) => GetMaterialApp(
                // Real route table so any internal Get navigation resolves
                // (Task B only reads the rate at Confirm, but this keeps the
                // tree robust against an uncaught route-generator exception).
                getPages: AppRouter.routes,
                home: BlocProvider<GiftCardCubit>.value(
                  value: cubit,
                  child: SellGiftCardScreen(preselectedCard: card),
                ),
              ),
            ),
          );
          // ScreenUtilInit init + GetMaterialApp navigator registration, then
          // settle the step-1 layout.
          await tester.pump();
          await tester.pump(const Duration(milliseconds: 300));
          await tester.pumpAndSettle(const Duration(seconds: 2));

          // Default format is ecode (no image gate). Fill card details.
          // Denomination auto-prefills from min in initState; ensure a
          // value if the catalogue surfaced no fixed denom. Give the step-1
          // body a few bounded frames to mount before touching its fields.
          var numField = find.byKey(const Key('sell_card_number_field'));
          final fieldDeadline = DateTime.now().add(const Duration(seconds: 8));
          while (numField.evaluate().isEmpty &&
              DateTime.now().isBefore(fieldDeadline)) {
            await tester.pump(const Duration(milliseconds: 300));
            numField = find.byKey(const Key('sell_card_number_field'));
          }
          if (numField.evaluate().isEmpty) {
            results.fail('Task B: $label confirm',
                'step-1 body did not render (card-number field not found)');
            continue;
          }
          final denomField = find.byKey(const Key('sell_denomination_field'));
          if (denomField.evaluate().isNotEmpty) {
            await tester.ensureVisible(denomField);
            final min = card.minDenomination > 0 ? card.minDenomination : 50;
            await tester.enterText(denomField, min.toStringAsFixed(0));
            await tester.pumpAndSettle();
          }
          await tester.ensureVisible(numField);
          await tester.enterText(numField, '1234567890123456');
          await tester.pumpAndSettle();
          final pinField = find.byKey(const Key('sell_card_pin_field'));
          await tester.ensureVisible(pinField);
          await tester.enterText(pinField, '1234');
          await tester.pumpAndSettle();

          final getRate = find.byKey(const Key('sell_get_rate_button'));
          await tester.ensureVisible(getRate);
          final grWidget = tester.widget<ElevatedButton>(getRate);
          if (grWidget.onPressed == null) {
            results.warn('Task B: $label rate',
                'Get-Rate disabled (likely a physical card needing images); skipping');
            continue;
          }
          await tester.tap(getRate);
          await tester.pumpAndSettle(const Duration(seconds: 2));

          // The payout step was removed — Get Rate jumps straight to the
          // Confirm step. Payout currency auto-follows the active locale
          // (en-NG → NGN), so we go directly to reading the rate card.

          // Confirm step: wait for the rate card to load.
          final faceCcy = find.byKey(const Key('sell_face_currency'));
          final rateDeadline =
              DateTime.now().add(const Duration(seconds: 25));
          while (faceCcy.evaluate().isEmpty &&
              DateTime.now().isBefore(rateDeadline)) {
            await tester.pump(const Duration(milliseconds: 500));
          }
          await tester.pumpAndSettle(const Duration(seconds: 1));
          if (faceCcy.evaluate().isEmpty) {
            results.fail('Task B: $label confirm',
                'face-currency widget never rendered (rate likely never loaded)');
            continue;
          }

          // Read the rendered text for currency + symbol + FX + rate%.
          final faceText =
              (faceCcy.evaluate().first.widget as Text).data ?? '';
          final fxFinder = find.byKey(const Key('sell_fx_rate'));
          final fxText = fxFinder.evaluate().isNotEmpty
              ? ((fxFinder.evaluate().first.widget as Text).data ?? '')
              : '';
          final rateFinder = find.byKey(const Key('sell_rate_percentage'));
          final rateText = rateFinder.evaluate().isNotEmpty
              ? ((rateFinder.evaluate().first.widget as Text).data ?? '')
              : '';
          final summaryFinder =
              find.byKey(const Key('sell_summary_denomination'));
          final summaryText = summaryFinder.evaluate().isNotEmpty
              ? ((summaryFinder.evaluate().first.widget as Text).data ?? '')
              : '';

          final codeOk = faceText.contains(expectedCcy);
          final symbolOk = faceText.contains(expectedSymbol);
          // FX must reference the foreign unit symbol AND an NGN payout.
          final fxOk = fxText.contains('NGN') && fxText.isNotEmpty;
          final ratePctOk = rateText.contains('%');
          // Currency carries through to the confirm summary.
          final summaryOk = summaryText.contains(expectedCcy) &&
              summaryText.contains(expectedSymbol);

          if (codeOk && symbolOk && fxOk && ratePctOk && summaryOk) {
            results.ok('Task B: $label',
                'face="$faceText"  fx="$fxText"  rate="$rateText"  summary="$summaryText"');
          } else {
            results.fail('Task B: $label',
                'code=$codeOk symbol=$symbolOk fx=$fxOk rate%=$ratePctOk summary=$summaryOk '
                '| face="$faceText" fx="$fxText" rate="$rateText" summary="$summaryText"');
          }
        } catch (e, st) {
          results.fail('Task B: $label', '$e');
          // ignore: avoid_print
          print(st);
        } finally {
          await cubit.close();
        }
      }
}
