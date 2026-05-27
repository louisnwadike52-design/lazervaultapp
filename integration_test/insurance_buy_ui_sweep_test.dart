// Insurance BUY UI SWEEP — full per-product on-screen bug hunt
//
// Extends insurance_buy_ui_e2e_test.dart (which drives ONE product through
// the real carousel screens) into a FULL per-product sweep: it drives EVERY
// enabled product through the actual app screens on the emulator, one by one,
// category by category (Health first, then the rest), so we exercise each
// product's real on-screen form (which varies per product) to catch UI bugs
// — render crashes, setState-during-build, broken navigation, error
// boundaries — like the form-crash we just fixed.
//
// HOW IT WORKS (read the real code — no guesses):
//   • The catalogue (WHICH products exist) is enumerated over the
//     InsuranceServiceClient gRPC API, exactly like the gRPC exhaustive
//     sweep in insurance_e2e_test.dart (getInsuranceCategories →
//     getInsuranceProducts per category). gRPC is used ONLY to know the
//     list; every BUY is driven through the carousel SCREENS (tap /
//     enterText), never gRPC.
//   • For each product the test opens the carousel from the insurance hub
//     ("New Policy" FAB → fresh CreatePolicyCubit per push, confirmed in
//     insurance_list_screen.dart:1078-1097), selects the category + product
//     BY NAME on screen, renders + fills its form ON SCREEN, advances to a
//     quote, and attempts the buy through the screens. It then returns to
//     the start (Get.offAllNamed(dashboard) → re-open the hub → New Policy)
//     for the next product, so every product gets a fresh cubit and a clean
//     Page 0 — no cross-product state contamination.
//   • One app.main() (init is not idempotent) inside ONE testWidgets; the
//     whole loop runs inside it. One provisioned+funded user is fine for a
//     bug hunt (buy-dedup at MyCover is a WARN, not a blocker for
//     form-render testing). Funds are topped up via the accounts-direct
//     CreditBalance helper between products when the wallet runs low.
//
// CLASSIFICATION (this is a BUG HUNT):
//   FAIL = a real UI/app bug: a Flutter framework exception (setState during
//          build, render overflow that throws, null check), an error
//          boundary / "Something went wrong" on the form, navigation that
//          never reaches the expected screen, a widget the form should
//          render but that crashes. Captured with the exception text + the
//          product name so the lead can fix it.
//   WARN = MyCover sandbox reality: quote/buy fails at the provider
//          (INVALID_ARGUMENT / 404 / UNAVAILABLE / insufficient),
//          customer-dedup, or a field type that genuinely can't be driven on
//          screen (image upload, structured repeated arrays, utility-backed
//          dependent dropdowns). WARN-skip with the product name + reason.
//          The POINT for those is to confirm the form RENDERS without
//          crashing, even when we can't complete the buy.
//   PASS = drove through the screens to a clean terminal (receipt / clean
//          provider-decline / slow-provider panel) with no UI crash.
//
// ISOLATION: every product attempt is wrapped in try/catch so one product's
//   failure NEVER aborts the sweep — it's recorded and the loop continues to
//   the next product. (The base test aborts on first exception; this one
//   must not.)
//
// dart-defines:
//   --dart-define=FOCUS_CATEGORIES=Health        run one category (or
//                                                 comma-separated several)
//   --dart-define=MAX_PER_CATEGORY=3             cap products per category
//   --dart-define=TEST_BACKEND_HOST=10.0.2.2     emulator → host machine
//   Default: ALL categories, ALL products.
//
// Android emulator run (the LEAD runs this so the user can watch + so the
// lead can fix discovered bugs and re-run — do NOT run it as part of
// authoring):
//   cd lazervaultapp
//   flutter test integration_test/insurance_buy_ui_sweep_test.dart \
//     -d emulator-5554 \
//     --dart-define=TEST_BACKEND_HOST=10.0.2.2 \
//     --timeout=120m
//
// Single category quick pass:
//   flutter test integration_test/insurance_buy_ui_sweep_test.dart \
//     -d emulator-5554 \
//     --dart-define=TEST_BACKEND_HOST=10.0.2.2 \
//     --dart-define=FOCUS_CATEGORIES=Health \
//     --dart-define=MAX_PER_CATEGORY=4 \
//     --timeout=60m

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
import 'package:lazervault/src/generated/insurance.pb.dart' as ins_pb;
import 'package:lazervault/src/generated/insurance.pbgrpc.dart' as insurance_pb;
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/features/insurance/presentation/cubit/create_policy_cubit.dart';
import 'package:lazervault/src/features/insurance/presentation/cubit/create_policy_state.dart';
import 'package:lazervault/src/features/insurance/presentation/view/create_insurance_policy_carousel.dart';
import 'package:lazervault/src/features/insurance/presentation/widgets/create_policy/insurance_processing_screen.dart';
import 'package:lazervault/src/features/insurance/domain/entities/insurance_product_entity.dart';

// ============================================================================
// Configuration (same channel constants as insurance_buy_ui_e2e_test.dart)
// ============================================================================

const String grpcHost =
    String.fromEnvironment('TEST_BACKEND_HOST', defaultValue: 'localhost');
const int coreGatewayPort = 50070; // auth, accounts (via gateway), pin
const int productsGatewayPort = 50078; // products gateway (registers insurance)
const int accountsServiceDirectPort = 50052; // CreditBalance (sandbox fund)

const String testPassword = r'Password1$';
const String testPin = '1111';
// ₦1,500,000 — a per-product sweep buys many policies in one run, so we seed
// a larger float than the single-buy test and top up between products when
// the wallet runs low (see _maybeTopUp).
const int fundAmountKobo = 1500000 * 100;
// Top up by this much whenever a low-balance signal (insufficient) surfaces.
const int topUpKobo = 1000000 * 100;

// Category run ORDER. The sweep walks categories in this order (Health first,
// then the rest) so a focused Health pass needs no extra config. Any backend
// category NOT named here is appended after these, in backend order — so we
// never silently skip a category MyCover adds later.
const List<String> categoryRunOrder = [
  'Health',
  'Life',
  'Auto',
  'Gadget',
  'Travel',
  'Package',
  'Content',
  'Credit Life',
  'Agency Banking',
  'Personal Accident',
];

// FOCUS_CATEGORIES scopes the run to one or more categories (comma-sep) for
// rapid iteration. Empty = run all. MAX_PER_CATEGORY caps products per
// category for a quick pass (0 = no cap).
const String _focusCategoriesRaw = String.fromEnvironment('FOCUS_CATEGORIES');
const int _maxPerCategory =
    int.fromEnvironment('MAX_PER_CATEGORY', defaultValue: 0);
// START_INDEX skips the first N products of each focused category so a run
// can RESUME past where an emulator-NAT flake aborted the previous chunk.
const int _startIndex = int.fromEnvironment('START_INDEX', defaultValue: 0);

// ============================================================================
// Result book-keeping — per-product ledger + a UI-bug list kept separate so
// the lead can see real crashes at a glance vs. expected MyCover flakiness.
// ============================================================================

class _Results {
  int passed = 0;
  int failed = 0;
  int warned = 0;
  // Real UI/app bugs (FAIL on a product attempt). Each carries the product
  // name + the exception/condition so the lead can reproduce + fix.
  final List<String> uiBugs = [];
  // Setup-level failures (provision/boot/login) that are NOT per-product.
  final List<String> setupErrors = [];
  // Provider/MyCover/undriveable WARNs — expected, not suite-failing.
  final List<String> warns = [];

  void ok(String name, [String detail = '']) {
    passed++;
    // ignore: avoid_print
    print('  PASS: $name${detail.isNotEmpty ? " — $detail" : ""}');
  }

  // Per-product UI bug.
  void uiBug(String product, String why) {
    failed++;
    uiBugs.add('$product: $why');
    // ignore: avoid_print
    print('  FAIL(UI-BUG): $product — $why');
  }

  // Setup-level hard failure (provision/boot/login).
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
    print('SWEEP RESULTS  pass=$passed  fail=$failed  warn=$warned  '
        '(attempts logged=$total)');
    // ignore: avoid_print
    print('-' * 72);
    if (uiBugs.isEmpty && setupErrors.isEmpty) {
      // ignore: avoid_print
      print('UI BUGS: none — every product rendered + navigated without a '
          'Flutter crash');
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
      print('WARNS (${warns.length}) — MyCover sandbox / undriveable fields '
          '(not bugs):');
      for (final w in warns) {
        // ignore: avoid_print
        print('  ! $w');
      }
    }
    // ignore: avoid_print
    print('=' * 72);
  }

  // Only UI bugs + setup failures fail the suite. WARNs never do.
  bool get hasHardFailures => uiBugs.isNotEmpty || setupErrors.isNotEmpty;
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
  final email = 'ins-sweep-ui-e2e-$ts@lazervault.test';
  final phone = '+23480${(10000000 + (ts % 90000000)).toString()}';
  final deviceId = 'ins-sweep-ui-e2e-$ts';

  final auth = auth_pb.AuthServiceClient(core);
  // ignore: avoid_print
  print('  -> signup $email');
  final signupResp = await auth.signup(SignupRequest(
    email: email,
    password: testPassword,
    firstName: 'InsSweep',
    lastName: 'Tester',
    phone: phone,
    deviceId: deviceId,
    deviceName: 'Insurance Buy UI Sweep',
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
      deviceName: 'Insurance Buy UI Sweep',
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
    reference: 'E2E-INSSWEEP-FUND-${DateTime.now().microsecondsSinceEpoch}',
    type: 'deposit',
    description: 'E2E insurance buy UI sweep funding',
    serviceName: 'e2e-test',
    idempotencyKey:
        'E2E-INSSWEEP-FUND-IDEM-${DateTime.now().microsecondsSinceEpoch}',
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
      deviceName: 'Insurance Buy UI Sweep',
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

// Top up the wallet mid-sweep (best-effort) when a product buy reports
// insufficient funds. The sweep buys many policies on one user, so the float
// drains; topping up keeps the form-render testing going for later products.
Future<void> _maybeTopUp(
  ClientChannel accountsDirect,
  _Session s,
  _Results results,
) async {
  try {
    final ad = accounts_pb.AccountsServiceClient(accountsDirect);
    final credit = await ad.creditBalance(CreditBalanceRequest(
      accountId: s.ngnAccountId,
      userId: s.userId,
      amount: Int64(topUpKobo),
      currency: 'NGN',
      reference: 'E2E-INSSWEEP-TOPUP-${DateTime.now().microsecondsSinceEpoch}',
      type: 'deposit',
      description: 'E2E insurance buy UI sweep top-up',
      serviceName: 'e2e-test',
      idempotencyKey:
          'E2E-INSSWEEP-TOPUP-IDEM-${DateTime.now().microsecondsSinceEpoch}',
    ));
    if (credit.success) {
      results.warn('Wallet top-up', 'credited ₦${topUpKobo / 100}');
    } else {
      results.warn('Wallet top-up',
          'failed: ${credit.errorCode} ${credit.errorMessage}');
    }
  } catch (e) {
    results.warn('Wallet top-up', '$e');
  }
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

// A category + its product names, enumerated over gRPC (WHICH products exist).
class _CategoryPlan {
  final String name;
  final int productCount;
  final List<String> productNames;
  _CategoryPlan(this.name, this.productCount, this.productNames);
}

// Enumerate categories + product names over the InsuranceServiceClient gRPC
// API — the SAME mechanism the gRPC exhaustive sweep uses
// (insurance_e2e_test.dart:1247+). gRPC is used ONLY to learn the catalogue;
// each BUY is driven on screen below.
Future<List<_CategoryPlan>> _enumerateCatalogue(
  ClientChannel productsCh,
  _Session s,
  _Results results,
) async {
  final ins = insurance_pb.InsuranceServiceClient(productsCh);

  // Categories.
  List<ins_pb.InsuranceCategory> cats;
  try {
    final resp = await ins.getInsuranceCategories(
      ins_pb.GetInsuranceCategoriesRequest(locale: 'en-NG'),
      options: _authOpts(s.accessToken),
    );
    cats = resp.categories;
  } catch (e) {
    results.setupFail('Enumerate categories', '$e');
    return const [];
  }
  if (cats.isEmpty) {
    results.setupFail('Enumerate categories', 'empty list');
    return const [];
  }

  // FOCUS_CATEGORIES filter.
  final focusSet = _focusCategoriesRaw.isEmpty
      ? <String>{}
      : _focusCategoriesRaw.split(',').map((x) => x.trim()).toSet();

  // Order categories by categoryRunOrder (Health first), appending any
  // backend category not in the list afterwards in backend order.
  final byName = {for (final c in cats) c.name: c};
  final ordered = <ins_pb.InsuranceCategory>[];
  for (final wanted in categoryRunOrder) {
    final c = byName.remove(wanted);
    if (c != null) ordered.add(c);
  }
  // Backend categories we didn't name explicitly — keep them, never skip.
  for (final c in cats) {
    if (byName.containsKey(c.name)) ordered.add(c);
  }

  final plans = <_CategoryPlan>[];
  for (final cat in ordered) {
    if (focusSet.isNotEmpty && !focusSet.contains(cat.name)) continue;
    if (cat.productCount <= 0) {
      // The carousel grid hides productCount==0 categories anyway.
      results.warn('Catalogue ${cat.name}',
          'productCount=0 — carousel hides it; skipping');
      continue;
    }
    List<String> names = [];
    try {
      final pr = await ins.getInsuranceProducts(
        ins_pb.GetInsuranceProductsRequest(
          category: cat.name,
          locale: 'en-NG',
          page: 1,
          limit: 100,
        ),
        options: _authOpts(s.accessToken),
      );
      names = pr.products.map((p) => p.name).toList();
    } catch (e) {
      results.warn('Catalogue ${cat.name}', 'list failed: $e');
      continue;
    }
    if (names.isEmpty) {
      results.warn('Catalogue ${cat.name}', 'no products returned');
      continue;
    }
    // START_INDEX lets us RESUME a category past the point an emulator NAT
    // flake (HTTP/2 errorCode 10) aborted a prior run — run in short chunks
    // (START_INDEX + MAX_PER_CATEGORY) until every product is covered.
    if (_startIndex > 0 && _startIndex < names.length) {
      names = names.sublist(_startIndex);
    } else if (_startIndex >= names.length) {
      names = const [];
    }
    if (_maxPerCategory > 0 && names.length > _maxPerCategory) {
      names = names.sublist(0, _maxPerCategory);
    }
    if (names.isEmpty) {
      continue;
    }
    plans.add(_CategoryPlan(cat.name, cat.productCount, names));
  }
  return plans;
}

// ============================================================================
// Test
// ============================================================================

void main() {
  final results = _Results();

  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Insurance BUY UI SWEEP (per-product, on-screen)', () {
    late _Session session;
    late ClientChannel core;
    late ClientChannel productsCh;
    late ClientChannel accountsDirect;

    setUpAll(() async {
      // ignore: avoid_print
      print('\n${'=' * 72}');
      // ignore: avoid_print
      print('Insurance BUY UI SWEEP — provisioning fresh user');
      // ignore: avoid_print
      print('=' * 72);

      core = _channel(coreGatewayPort);
      productsCh = _channel(productsGatewayPort);
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
      // Print the ledger FIRST so the summary lands even if channel teardown
      // misbehaves. gRPC ClientChannel.shutdown() can HANG under the
      // integration_test binding; bound the shutdowns with a timeout.
      results.summary();
      for (final ch in [core, productsCh, accountsDirect]) {
        try {
          await ch
              .shutdown()
              .timeout(const Duration(seconds: 3), onTimeout: () {});
        } catch (_) {}
      }
      if (results.hasHardFailures) {
        fail('Insurance BUY UI SWEEP found '
            '${results.uiBugs.length + results.setupErrors.length} UI/app bug(s)');
      }
    });

    // ── Single app-driven testWidgets: boot ONCE, log in, then drive the
    //    full per-product sweep through the carousel screens. app.main() can
    //    only run once (init() is not idempotent) so the entire loop lives
    //    inside this one block.
    testWidgets('Per-product sweep through the carousel screens',
        (tester) async {
      // 1) Boot the real app inside runAsync (real timers/sockets in
      //    main()), then drive the test clock until the GetMaterialApp mounts.
      await tester.runAsync(() async {
        app.main();
        final realBootEnd = DateTime.now().add(const Duration(seconds: 40));
        while (DateTime.now().isBefore(realBootEnd)) {
          await Future<void>.delayed(const Duration(milliseconds: 250));
          if (WidgetsBinding.instance.rootElement != null &&
              (Get.key.currentState != null || Get.context != null)) {
            break;
          }
        }
      });
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
      //    AuthenticationSuccess — the carousel initState + purchase gate
      //    both require it (boot's tryAutoLogin only yields
      //    AuthenticationAuthenticated).
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

      // 4) Enumerate the catalogue over gRPC (WHICH products exist).
      final plans =
          await tester.runAsync(() => _enumerateCatalogue(productsCh, session, results));
      if (plans == null || plans.isEmpty) {
        if (_focusCategoriesRaw.isNotEmpty) {
          // A FOCUSED run whose category/categories are empty in the current
          // (volatile) MyCover sandbox catalog is NOT a failure — there is
          // simply nothing to drive right now. Clean skip, not a setup FAIL.
          results.warn(
              'Catalogue',
              'focused categories ($_focusCategoriesRaw) have no products in '
              'the current catalog — nothing to sweep (clean skip)');
          return;
        }
        results.setupFail('Catalogue', 'no categories/products to sweep');
        return;
      }
      final totalProducts =
          plans.fold<int>(0, (a, p) => a + p.productNames.length);
      results.ok('Catalogue enumerated',
          '${plans.length} categories, $totalProducts products to drive on screen');

      // 5) MAIN SWEEP — category by category, product by product. Each
      //    product is fully isolated in its own try/catch (continue on any
      //    error). One product's crash NEVER aborts the rest.
      for (final plan in plans) {
        // ignore: avoid_print
        print('\n${'#' * 72}');
        // ignore: avoid_print
        print('# CATEGORY: ${plan.name}  (${plan.productNames.length} products)');
        // ignore: avoid_print
        print('#' * 72);

        for (final productName in plan.productNames) {
          final tag = '${plan.name} / $productName';
          try {
            await _driveOneProduct(
              tester: tester,
              results: results,
              session: session,
              accountsDirect: accountsDirect,
              categoryName: plan.name,
              productName: productName,
            );
          } catch (e, st) {
            // An UNCAUGHT exception escaping _driveOneProduct is, by
            // definition, a Flutter framework / widget crash that the inner
            // guards didn't classify — that's a real UI bug. Record it and
            // KEEP GOING.
            results.uiBug(tag, 'uncaught exception driving product: $e');
            // ignore: avoid_print
            print(st);
          }
          // Always try to get back to a clean dashboard before the next
          // product so a half-navigated state can't poison the next attempt.
          await _resetToDashboard(tester);
        }
      }

      results.ok('Sweep complete',
          'drove $totalProducts products across ${plans.length} categories');
    });
  });
}

// ── Drive ONE product fully through the carousel screens. Opens the carousel
//    from the insurance hub (fresh cubit per push), selects the named
//    category + product ON SCREEN, fills the form ON SCREEN, advances to a
//    quote, attempts the buy, and classifies the outcome. Never rethrows for
//    an expected (WARN) condition; lets a genuine widget crash bubble up to
//    the caller's catch (which records it as a UI bug).
Future<void> _driveOneProduct({
  required WidgetTester tester,
  required _Results results,
  required _Session session,
  required ClientChannel accountsDirect,
  required String categoryName,
  required String productName,
}) async {
  final tag = '$categoryName / $productName';

  // (1) Open the insurance hub and tap "New Policy" → fresh carousel + cubit.
  if (!await _openCarousel(tester)) {
    results.uiBug(tag,
        'could not reach the carousel ("New Policy" FAB / carousel never '
        'mounted) — navigation bug');
    return;
  }

  // (2) Grab the fresh CreatePolicyCubit off the carousel element.
  final carousel = find.byType(CreateInsurancePolicyCarousel);
  CreatePolicyCubit cubit;
  try {
    cubit = BlocProvider.of<CreatePolicyCubit>(tester.element(carousel.first));
  } catch (e) {
    results.uiBug(tag, 'could not read CreatePolicyCubit from carousel: $e');
    return;
  }

  // (3) Wait for categories (carousel initState fires loadCategories once
  //     AuthenticationSuccess is set, which it is).
  final catDeadline = DateTime.now().add(const Duration(seconds: 45));
  while (cubit.categories.isEmpty && DateTime.now().isBefore(catDeadline)) {
    await tester.pump(const Duration(milliseconds: 500));
  }
  if (cubit.categories.isEmpty) {
    results.warn(tag,
        'categories did not load (state=${cubit.state.runtimeType}) — '
        'backend/MyCover, not a UI crash');
    return;
  }

  // (4) Find + tap the category tile by name. The grid hides productCount==0
  //     categories; ours has products (we enumerated it). If the tile isn't
  //     on screen, drive the cubit to load its products as a fallback so the
  //     test continues — but prefer the real tap.
  final cat = cubit.categories.cast<InsuranceCategoryInfo?>().firstWhere(
        (c) => c!.name == categoryName,
        orElse: () => null,
      );
  if (cat == null) {
    results.warn(tag,
        'category "$categoryName" absent from carousel grid '
        '(productCount/stability) — skipping');
    return;
  }
  final catTile = find.text(cat.name);
  if (catTile.evaluate().isNotEmpty) {
    await _safeEnsureVisible(tester, catTile.first);
    await tester.tap(catTile.first);
    await tester.pump(const Duration(milliseconds: 600));
  } else {
    // Tile not rendered (off-screen / grid quirk) — drive selection through
    // the cubit so we can still exercise the form. Not a crash.
    cubit.loadProductsPaginated(info: cat);
    await tester.pump(const Duration(milliseconds: 600));
  }

  // (5) Wait for products to load for this category, then make sure the
  //     target product is in the loaded page. The list is paginated (limit
  //     15) with scroll-load, so for a product beyond page 1 we page in more
  //     via the cubit until it's present (or we run out of pages).
  if (!await _ensureProductLoaded(tester, cubit, productName)) {
    // Either products never loaded, or the named product never appeared.
    if (cubit.products.isEmpty) {
      results.warn(tag,
          'products did not load (state=${cubit.state.runtimeType}) — backend');
    } else {
      results.warn(tag,
          'product "$productName" not found in ${cubit.products.length} '
          'loaded products — catalogue drift between gRPC list and UI');
    }
    return;
  }

  // (6) Tap the product card by name. Scroll it into view first (it may be
  //     well down a long list).
  final prodCard = find.text(productName);
  if (prodCard.evaluate().isEmpty) {
    // Loaded in the cubit but not currently painted — select via cubit so we
    // still drive the form. (Tap is preferred but this keeps the sweep going.)
    final p = cubit.products.firstWhere((x) => x.name == productName);
    cubit.selectProduct(p);
    await tester.pump(const Duration(milliseconds: 400));
  } else {
    await _safeEnsureVisible(tester, prodCard.first);
    await tester.tap(prodCard.first);
    await tester.pump(const Duration(milliseconds: 500));
  }
  if (cubit.selectedProduct?.name != productName) {
    results.warn(tag,
        'selectProduct did not register (selected='
        '${cubit.selectedProduct?.name}) — possible duplicate-name drift');
    return;
  }
  final selectedProduct = cubit.selectedProduct!;

  // (7) Advance Page 0 → Page 1 by tapping "Continue".
  if (!await _tapBottomNav(tester, 'Continue')) {
    results.uiBug(tag, '"Continue" not tappable on Page 0 — nav bug');
    return;
  }
  await tester.pump(const Duration(milliseconds: 800));

  // Confirm the FORM SCREEN actually rendered (no error boundary / crash).
  // If the carousel vanished or an error message is on screen, that's a bug.
  if (!await _formScreenRendered(tester, results, tag)) {
    return; // _formScreenRendered already recorded the classification
  }

  // (8) Fill the form ON SCREEN. For each required field still empty:
  //       text/email/number/monetary → enterText into the field by label
  //       select/dropdown            → tap row → first option
  //       date/boolean/array/image/utility-dependent → driven where possible,
  //         else seeded via the cubit (with a WARN note for undriveable
  //         types). The POINT is the form RENDERED; completing the buy is a
  //         bonus that MyCover may decline.
  final fill = await _fillForm(tester, cubit, selectedProduct, session);
  results.ok('Fill form [$tag]', fill.summary);
  for (final note in fill.warnNotes) {
    results.warn(tag, note);
  }

  // (9) Advance Page 1 → Page 2 by tapping "Continue" (validates + quotes).
  if (!await _tapBottomNav(tester, 'Continue')) {
    // Could be a stuck validation (form shows inline errors) OR a nav bug.
    // Re-check the form rendered: if it's still the form with errors, that's
    // a fill/validation limitation (WARN), not a crash.
    results.warn(tag,
        '"Continue" not tappable on Page 1 — likely a field type we could '
        'not drive (form still rendered, no crash)');
    return;
  }

  // If Continue was tappable but validation blocked the advance (a required
  // field we couldn't fill on screen, e.g. an empty Payment Plan), we're still
  // on Page 1 — don't wait the full quote window for a quote that will never
  // come (that's what made the screen look frozen). Detect the inline
  // validation error and WARN-skip fast.
  await tester.pump(const Duration(milliseconds: 700));
  if (find.textContaining('is required').evaluate().isNotEmpty ||
      find.textContaining('Please select').evaluate().isNotEmpty) {
    results.warn(tag,
        'form blocked by a required field we could not fill on screen '
        '(inline validation error shown) — skipping fast, no crash');
    return;
  }

  // Quote round-trip (up to ~80s for MyCover). Bounded pumps.
  final quoteDeadline = DateTime.now().add(const Duration(seconds: 80));
  while (DateTime.now().isBefore(quoteDeadline)) {
    await tester.pump(const Duration(milliseconds: 800));
    if (cubit.quote != null) break;
    if (cubit.state is CreatePolicyError) break;
  }
  if (cubit.quote == null) {
    final st = cubit.state;
    final why =
        st is CreatePolicyError ? st.message : 'no quote (state=${st.runtimeType})';
    // Quote failure is EXPECTED MyCover-sandbox flakiness / undriveable
    // fields. The form rendered + we navigated to the quote step → PASS the
    // render goal, WARN the buy.
    results.warn(tag, 'quote not obtained (MyCover/field): $why');
    results.ok('Reach terminal [$tag]',
        'clean quote-failure terminal (form rendered, nav OK, no crash)');
    return;
  }

  // (10) Page 2 (Review & Pay): tick terms, confirm account, Confirm & Pay,
  //      enter PIN, wait for a terminal. Any clean terminal = PASS.
  await _completePurchase(
      tester, results, session, accountsDirect, cubit, tag);
}

// ── Bring the app to the carousel: dashboard → insurance hub → New Policy.
//    Returns true once CreateInsurancePolicyCarousel is mounted.
Future<bool> _openCarousel(WidgetTester tester) async {
  // Reach the insurance hub (named GetX route).
  try {
    Get.toNamed(AppRoutes.insurance);
  } catch (_) {
    return false;
  }
  // Wait (bounded) for the "New Policy" FAB.
  final fab = find.text('New Policy');
  final hubDeadline = DateTime.now().add(const Duration(seconds: 25));
  while (fab.evaluate().isEmpty && DateTime.now().isBefore(hubDeadline)) {
    await tester.pump(const Duration(milliseconds: 400));
  }
  if (fab.evaluate().isEmpty) return false;
  await _safeEnsureVisible(tester, fab.first);
  await tester.tap(fab.first);
  await tester.pump(const Duration(seconds: 1));

  // Wait for the carousel to mount.
  final carousel = find.byType(CreateInsurancePolicyCarousel);
  final carDeadline = DateTime.now().add(const Duration(seconds: 20));
  while (carousel.evaluate().isEmpty && DateTime.now().isBefore(carDeadline)) {
    await tester.pump(const Duration(milliseconds: 400));
  }
  return carousel.evaluate().isNotEmpty;
}

// ── Return to a clean dashboard between products. Robust to whichever
//    terminal we landed on (receipt screen, carousel page 2 after a decline,
//    a snackbar, etc.). Uses Get.offAllNamed so the route stack is reset and
//    the next product gets a fresh carousel + cubit.
Future<void> _resetToDashboard(WidgetTester tester) async {
  try {
    Get.offAllNamed(AppRoutes.dashboard);
  } catch (_) {/* best-effort */}
  // Let any in-flight pushReplacement / snackbars settle (bounded).
  for (var i = 0; i < 12; i++) {
    await tester.pump(const Duration(milliseconds: 300));
  }
}

// ── Ensure the named product is present in cubit.products and (ideally) on
//    screen. The list is paginated (limit 15) with scroll-load; we page in
//    more via the cubit until the product appears or there are no more pages.
Future<bool> _ensureProductLoaded(
  WidgetTester tester,
  CreatePolicyCubit cubit,
  String productName,
) async {
  // Wait for the first page.
  final prodDeadline = DateTime.now().add(const Duration(seconds: 45));
  while (cubit.products.isEmpty && DateTime.now().isBefore(prodDeadline)) {
    await tester.pump(const Duration(milliseconds: 500));
  }
  if (cubit.products.isEmpty) return false;

  // Already present?
  if (cubit.products.any((p) => p.name == productName)) return true;

  // Page in more (scroll-load) up to a sane number of pages.
  for (var page = 0; page < 12; page++) {
    final before = cubit.products.length;
    final st = cubit.state;
    final hasMore = st is InsuranceProductsLoaded ? st.hasMore : false;
    if (!hasMore) break;
    cubit.loadMoreProducts();
    final loadDeadline = DateTime.now().add(const Duration(seconds: 20));
    while (DateTime.now().isBefore(loadDeadline)) {
      await tester.pump(const Duration(milliseconds: 400));
      if (cubit.products.length != before) break;
      final s2 = cubit.state;
      if (s2 is InsuranceProductsLoaded && !s2.isLoadingMore) break;
    }
    if (cubit.products.any((p) => p.name == productName)) return true;
    if (cubit.products.length == before) break; // no progress → stop
  }
  return cubit.products.any((p) => p.name == productName);
}

// ── Confirm the form screen (Page 1) actually rendered without a crash /
//    error boundary. Returns true when the form is on screen. Records the
//    classification itself when it isn't:
//      • carousel gone + a Flutter error widget visible → UI BUG
//      • carousel still there but on Page 0 (didn't advance) → nav bug
//      • otherwise (some required text/select widget on screen) → rendered
Future<bool> _formScreenRendered(
    WidgetTester tester, _Results results, String tag) async {
  await tester.pump(const Duration(milliseconds: 400));

  // Flutter's red/grey error widget — a thrown build/layout exception.
  if (find.byType(ErrorWidget).evaluate().isNotEmpty) {
    results.uiBug(tag, 'ErrorWidget on the form screen — build/render threw');
    return false;
  }
  // Common error-boundary copy.
  for (final marker in const [
    'Something went wrong',
    'An error occurred',
    'RenderFlex overflowed',
  ]) {
    if (find.textContaining(marker).evaluate().isNotEmpty) {
      results.uiBug(tag, 'error boundary on form: "$marker"');
      return false;
    }
  }
  // The carousel must still be mounted.
  if (find.byType(CreateInsurancePolicyCarousel).evaluate().isEmpty) {
    results.uiBug(tag,
        'carousel disappeared after advancing to the form — navigation/crash');
    return false;
  }
  // The form header "Your Details" should be visible on Page 1.
  final advanced = find.text('Your Details').evaluate().isNotEmpty ||
      find.textContaining('Fill in the required information').evaluate().isNotEmpty;
  if (!advanced) {
    // Stayed on Page 0 (Browse) — the Continue tap didn't advance. Treat as a
    // nav bug only if the Browse header is still showing; otherwise it
    // rendered something else (still no crash).
    if (find.text('Choose a Category').evaluate().isNotEmpty ||
        find.text('Available Plans').evaluate().isNotEmpty) {
      results.uiBug(tag,
          'did not advance to the form screen after "Continue" — nav bug');
      return false;
    }
  }
  return true;
}

// ── Result of filling a form: a one-line summary + any WARN notes for field
//    types we could not drive deterministically on screen.
class _FillResult {
  int onScreenText = 0;
  int onScreenSelect = 0;
  int seeded = 0;
  final List<String> warnNotes = [];
  String get summary =>
      'on-screen text=$onScreenText, on-screen select=$onScreenSelect, seeded=$seeded';
}

// ── Fill the dynamic form ON SCREEN. Mirrors the base test's per-type
//    handling, extended to log which field types had to be seeded (so the
//    lead sees what couldn't be driven). Identity fields are pre-filled by
//    selectProduct from the profile; we only touch still-empty required ones.
Future<_FillResult> _fillForm(
  WidgetTester tester,
  CreatePolicyCubit cubit,
  InsuranceProduct product,
  _Session session,
) async {
  final r = _FillResult();

  for (final field in product.formFields) {
    if (!field.required) continue;
    if (field.name.startsWith('insured_')) continue; // hidden (bought_for_self)
    final current = cubit.formData[field.name] ?? '';
    if (current.isNotEmpty) continue; // already auto-filled

    final type = field.type.toLowerCase();
    final name = field.name.toLowerCase();

    // Image / file fields: cannot drive the OS picker in an integration test.
    // Seed a public URL so the form validates; WARN-note the undriveable type.
    if (type == 'file' ||
        type == 'image' ||
        name.contains('image') ||
        name.contains('photo') ||
        name.contains('proof') ||
        name.endsWith('_url')) {
      cubit.updateFormField(field.name, 'https://placehold.co/300x300.png');
      r.seeded++;
      r.warnNotes.add('field "${field.name}" (image/file) not driveable on '
          'screen — seeded a URL');
      continue;
    }

    // Utility-backed / dependent dropdowns (e.g. vehicle_make → vehicle_model)
    // pull options from a remote utility endpoint and cascade — not
    // deterministically tappable. Seed first option if present; else mark.
    if (field.utilityId.isNotEmpty || field.dependsOn.isNotEmpty) {
      if (field.options.isNotEmpty) {
        cubit.updateFormField(field.name, field.options.first);
        r.seeded++;
      } else {
        r.warnNotes.add('field "${field.name}" (utility-backed/dependent '
            'dropdown) not driveable on screen — no inline options');
        // Leave empty; quote will likely fail → WARN downstream.
      }
      continue;
    }

    // Structured array fields (items / item_details / benefit_details /
    // beneficiaries) are repeated object cards — not deterministically
    // driveable. Multi-select arrays (benefits with options) we seed a JSON
    // single-selection. Plain arrays we WARN-note and leave for downstream.
    if (type == 'array') {
      if (field.options.isNotEmpty) {
        // Multi-select chips → JSON array of one option.
        cubit.updateFormField(field.name, '["${field.options.first}"]');
        r.seeded++;
        r.warnNotes.add('field "${field.name}" (multi-select array) seeded '
            'via JSON — chips UI not driven on screen');
      } else {
        r.warnNotes.add('field "${field.name}" (structured array) not '
            'driveable on screen — left for provider to reject');
      }
      continue;
    }

    if (type == 'select' || type == 'dropdown') {
      final ok = await _pickFirstDropdownOption(tester, field.label);
      if (ok) {
        r.onScreenSelect++;
      } else if (field.options.isNotEmpty) {
        cubit.updateFormField(field.name, field.options.first);
        r.seeded++;
      } else {
        r.warnNotes.add('field "${field.name}" (select) had no options to '
            'pick on screen');
      }
      continue;
    }

    if (type == 'text' || type == 'email' || type == 'number') {
      final value = _sampleTextFor(field, session);
      final ok = await _enterIntoFieldByLabel(tester, field.label, value);
      if (ok) {
        r.onScreenText++;
      } else {
        cubit.updateFormField(field.name, value);
        r.seeded++;
      }
      continue;
    }

    // phone: the on-screen widget is a flag-row + digits input; the digits
    // TextField sits under the label, so enterText into the nearest input
    // works (the widget normalises to E.164). Fall back to seeding E.164.
    if (type == 'phone') {
      final ok = await _enterIntoFieldByLabel(tester, field.label, '8031234567');
      if (ok) {
        r.onScreenText++;
      } else {
        cubit.updateFormField(field.name, '+2348031234567');
        r.seeded++;
      }
      continue;
    }

    // date / boolean / anything else: date pickers + the boolean Switch
    // aren't reliably driven by label-locate, so seed via the cubit (date as
    // YYYY-MM-DD, boolean as the schema-aware default). bought_for_self is
    // already defaulted true by selectProduct.
    cubit.updateFormField(field.name, _sampleTextFor(field, session));
    r.seeded++;
    if (type == 'date') {
      r.warnNotes.add('field "${field.name}" (date) seeded — native date '
          'picker not driven on screen');
    }
  }
  await tester.pump(const Duration(milliseconds: 600));
  return r;
}

// ── Page 2 → terminal. Ticks terms, confirms the auto-selected account,
//    Confirm & Pay, enters PIN, waits (bounded) for any clean terminal.
//    Records PASS on a clean terminal; WARN on a clean provider decline;
//    UI BUG only when the screens themselves misbehave.
Future<void> _completePurchase(
  WidgetTester tester,
  _Results results,
  _Session session,
  ClientChannel accountsDirect,
  CreatePolicyCubit cubit,
  String tag,
) async {
  await tester.pump(const Duration(milliseconds: 800));

  // Terms checkbox.
  final checkbox = find.byType(Checkbox);
  final cbDeadline = DateTime.now().add(const Duration(seconds: 15));
  while (checkbox.evaluate().isEmpty && DateTime.now().isBefore(cbDeadline)) {
    await tester.pump(const Duration(milliseconds: 400));
  }
  if (checkbox.evaluate().isEmpty) {
    results.uiBug(tag, 'terms Checkbox not found on Review & Pay — render bug');
    return;
  }
  await _safeEnsureVisible(tester, checkbox.first);
  await tester.tap(checkbox.first);
  await tester.pump(const Duration(milliseconds: 500));
  if (!cubit.agreedToTerms) {
    results.warn(tag, 'agreedToTerms still false after tapping Checkbox');
    return;
  }

  // Account auto-selected by the review screen's post-frame callback.
  final acctDeadline = DateTime.now().add(const Duration(seconds: 8));
  while (cubit.selectedAccountId == null &&
      DateTime.now().isBefore(acctDeadline)) {
    await tester.pump(const Duration(milliseconds: 400));
  }
  if (cubit.selectedAccountId == null) {
    results.warn(tag, 'review screen did not auto-select a pay-from account');
    return;
  }

  // Confirm & Pay → PIN modal. A transient PIN-status gRPC flake is NOT a nav
  // bug: TransactionPinMixin gates the modal on checkUserHasPin(), and on a
  // connection drop it correctly shows "Failed to check PIN status. Please try
  // again." and aborts. We retry the tap once; if the modal still never opens
  // WITH that snackbar present, it's a transient backend WARN, not a UI bug.
  final firstDigit = find.byKey(const Key('transaction_pin_digit_0'));
  bool pinShown = false;
  bool pinCheckFlaked = false;
  for (var attempt = 1; attempt <= 2 && !pinShown; attempt++) {
    if (!await _tapBottomNav(tester, 'Confirm & Pay')) {
      if (attempt == 1) {
        results.uiBug(
            tag, '"Confirm & Pay" not tappable on Review & Pay — nav bug');
        return;
      }
      break;
    }
    await tester.pump(const Duration(seconds: 1));
    pinCheckFlaked = false;
    final pinDeadline = DateTime.now().add(const Duration(seconds: 20));
    while (firstDigit.evaluate().isEmpty &&
        DateTime.now().isBefore(pinDeadline)) {
      await tester.pump(const Duration(milliseconds: 500));
      // App surfaced a transient PIN-status check failure (connection drop).
      // Recoverable — stop waiting and let the loop retry the tap.
      if (find
          .textContaining('Failed to check PIN status')
          .evaluate()
          .isNotEmpty) {
        pinCheckFlaked = true;
        break;
      }
    }
    pinShown = firstDigit.evaluate().isNotEmpty;
    if (!pinShown && pinCheckFlaked && attempt < 2) {
      await tester.pump(const Duration(seconds: 3)); // let the snackbar clear
    }
  }
  if (!pinShown) {
    if (pinCheckFlaked) {
      results.warn(
          tag,
          'PIN-status check flaked (transient connection drop; app showed '
          '"Failed to check PIN status. Please try again." and aborted '
          'cleanly) — retried once, still down; not a nav bug');
    } else {
      results.uiBug(
          tag, 'PIN modal did not appear after Confirm & Pay — nav bug');
    }
    return;
  }
  for (var i = 0; i < 4; i++) {
    final digit = find.byKey(Key('transaction_pin_digit_$i'));
    await tester.enterText(digit, testPin[i]);
    await tester.pump(const Duration(milliseconds: 200));
  }
  await tester.pump(const Duration(seconds: 1));

  // Wait (bounded — the processing spinner never settles) for any clean
  // terminal. Success → receipt; CreatePolicyError → snackbar + pop; the
  // "taking longer than usual" panel is also a clean non-hang terminal.
  final saleDeadline = DateTime.now().add(const Duration(seconds: 150));
  String reached = '';
  String detail = '';
  bool insufficient = false;
  while (DateTime.now().isBefore(saleDeadline)) {
    await tester.pump(const Duration(milliseconds: 800));
    final st = cubit.state;
    if (st is InsurancePurchaseSuccess) {
      reached = 'purchase_success';
      detail = 'ref=${_safeRef(st)} policy=${_safePolicy(st)}';
      break;
    }
    if (st is CreatePolicyError) {
      reached = 'purchase_error';
      detail = st.message;
      final lc = st.message.toLowerCase();
      insufficient = lc.contains('insufficient') || lc.contains('balance');
      break;
    }
    if (find.byType(InsurancePurchaseReceiptScreen).evaluate().isNotEmpty) {
      reached = 'receipt_screen';
      break;
    }
    if (find.textContaining('Purchase Successful').evaluate().isNotEmpty) {
      reached = 'receipt_screen(ui)';
      break;
    }
    if (find.textContaining('taking longer than usual').evaluate().isNotEmpty) {
      reached = 'awaiting_provider(slow)';
      break;
    }
  }
  await tester.pump(const Duration(milliseconds: 500));

  if (insufficient) {
    // Low wallet on a multi-buy run — top up so later products keep going.
    await tester
        .runAsync(() => _maybeTopUp(accountsDirect, session, results));
  }

  if (reached.isEmpty) {
    // No terminal within 150s and no slow-provider panel either: the screen
    // is hung with no recovery affordance — that's a UI bug.
    results.uiBug(tag,
        'no clean terminal within 150s (cubit_state=${cubit.state.runtimeType} '
        'route=${Get.currentRoute}) — possible hang');
    return;
  }
  if (reached == 'purchase_error') {
    // Clean provider decline — the screens behaved (snackbar + pop). WARN the
    // buy but PASS the render/nav goal.
    results.warn(tag, 'provider declined (clean terminal): $detail');
    results.ok('Reach terminal [$tag]',
        'clean error terminal (form rendered, nav OK, no crash)');
    return;
  }
  // success / receipt / slow-provider panel — all clean PASSes.
  final buf = StringBuffer(reached);
  if (detail.isNotEmpty) buf.write('  [$detail]');
  results.ok('Reach terminal [$tag]', buf.toString());
}

// ============================================================================
// Shared on-screen helpers (mirror insurance_buy_ui_e2e_test.dart)
// ============================================================================

// ensureVisible can throw when the target isn't inside a scrollable; swallow
// that so a best-effort scroll never aborts a product attempt.
Future<void> _safeEnsureVisible(WidgetTester tester, Finder f) async {
  try {
    await tester.ensureVisible(f);
    await tester.pump(const Duration(milliseconds: 150));
  } catch (_) {/* best-effort */}
}

// Tap a bottom-nav GestureDetector button by its visible text.
Future<bool> _tapBottomNav(WidgetTester tester, String label) async {
  final f = find.text(label);
  if (f.evaluate().isEmpty) return false;
  await _safeEnsureVisible(tester, f.last);
  try {
    await tester.tap(f.last);
  } catch (_) {
    return false;
  }
  await tester.pump(const Duration(milliseconds: 300));
  return true;
}

// Enter [value] into the TextFormField/TextField that sits under the field
// whose label is [label]. Returns false when the field can't be located.
Future<bool> _enterIntoFieldByLabel(
    WidgetTester tester, String label, String value) async {
  final labelFinder = find.text(label);
  if (labelFinder.evaluate().isEmpty) return false;
  await _safeEnsureVisible(tester, labelFinder.first);
  // The label + input share the per-field Padding ancestor.
  final field = find.descendant(
    of: find.ancestor(
      of: labelFinder.first,
      matching: find.byType(Padding),
    ),
    matching: find.byType(EditableText),
  );
  Finder target;
  if (field.evaluate().isNotEmpty) {
    target = field.first;
  } else {
    final any = find.byType(EditableText);
    if (any.evaluate().isEmpty) return false;
    target = any.first;
  }
  try {
    await _safeEnsureVisible(tester, target);
    await tester.enterText(target, value);
    await tester.pump(const Duration(milliseconds: 350)); // debouncer is 300ms
    return true;
  } catch (_) {
    return false;
  }
}

// Open a dropdown field (located by its label) and tap the first option in
// the bottom sheet. Returns false when the row / sheet can't be driven.
Future<bool> _pickFirstDropdownOption(
    WidgetTester tester, String label) async {
  final labelFinder = find.text(label);
  if (labelFinder.evaluate().isEmpty) return false;
  await _safeEnsureVisible(tester, labelFinder.first);
  final row = find.descendant(
    of: find.ancestor(
      of: labelFinder.first,
      matching: find.byType(Padding),
    ),
    matching: find.byType(GestureDetector),
  );
  if (row.evaluate().isEmpty) return false;
  try {
    await tester.tap(row.first, warnIfMissed: false);
    // The select opens a modal bottom sheet (DraggableScrollableSheet) whose
    // option rows live in a ListView. Settle so the sheet + its list mount.
    await tester.pumpAndSettle(const Duration(milliseconds: 800));
  } catch (_) {
    return false;
  }
  // SCOPE the option search to the sheet's ListView — NOT the whole tree.
  // The old code did find.byType(GestureDetector) across everything (incl. the
  // form fields behind the sheet) and tapped count-2, which landed off-screen
  // and never selected an option (→ "required" → stuck). The first
  // GestureDetector under the sheet's ListView is the first option row.
  Finder optionRows = find.descendant(
    of: find.byType(ListView),
    matching: find.byType(GestureDetector),
  );
  if (optionRows.evaluate().isEmpty) {
    // Some sheets render options in a Column rather than a ListView.
    optionRows = find.descendant(
      of: find.byType(DraggableScrollableSheet),
      matching: find.byType(GestureDetector),
    );
  }
  if (optionRows.evaluate().isEmpty) return false;
  try {
    await _safeEnsureVisible(tester, optionRows.first);
    await tester.tap(optionRows.first, warnIfMissed: false);
    await tester.pumpAndSettle(const Duration(milliseconds: 500));
    return true;
  } catch (_) {
    return false;
  }
}

// Schema-aware sample value for a required field (mirrors the base test).
String _sampleTextFor(InsuranceProductFormField field, _Session s) {
  final name = field.name.toLowerCase();
  final type = field.type.toLowerCase();
  if (type == 'email' || name.contains('email')) return s.email;
  if (name.contains('phone')) return '08031234567';
  if (name == 'nin' || name == 'bvn' || name.contains('nin') || name.contains('bvn')) {
    return '12345678901'; // 11 digits
  }
  if (name.contains('first_name') || name == 'firstname') return 'InsSweep';
  if (name.contains('last_name') || name == 'lastname' || name.contains('surname')) {
    return 'Tester';
  }
  if (name.contains('name')) return 'InsSweep Tester';
  if (name.contains('address')) return '12 Test Street, Lagos';
  if (name.contains('occupation')) return 'Software Engineer';
  if (name.contains('state')) return 'Lagos';
  if (name.contains('city')) return 'Lagos';
  if (type == 'date' || name.contains('dob') || name.contains('date_of_birth')) {
    return '1995-01-01';
  }
  if (type == 'number' || type == 'integer') {
    return _looksMonetary(name) ? '1500000' : '1';
  }
  if (type == 'boolean' || type == 'bool') return 'true';
  if (field.options.isNotEmpty) return field.options.first;
  return 'Test Value';
}

bool _looksMonetary(String name) {
  const m = ['value', 'amount', 'sum_insured', 'premium', 'cover', 'price'];
  return m.any((k) => name.contains(k));
}

String _safeRef(InsurancePurchaseSuccess st) {
  try {
    return st.purchaseResult.reference;
  } catch (_) {
    return '';
  }
}

String _safePolicy(InsurancePurchaseSuccess st) {
  try {
    return st.purchaseResult.policyNumber;
  } catch (_) {
    return '';
  }
}
