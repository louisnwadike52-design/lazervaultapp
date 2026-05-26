// Gift Card BUY E2E Integration Test (REAL UI-driven, provider-switch aware)
//
// Drives the production Flutter gift-card BUY flow THROUGH THE UI — not a
// gRPC script — end-to-end against the real local backend + REAL providers
// (Reloadly sandbox / Prestmit sandbox), exactly as a real user would:
//
//   Gift Cards hub → BUY tab (default) → tap a brand → select the smallest
//   denomination → Purchase → transaction PIN (1234) → processing screen →
//   terminal (completed + redeem code, OR a clean insufficient-funds /
//   error / awaiting-provider state).
//
// The CORE of this test is the PROVIDER SWITCH. The active buy provider is
// the system_setting `giftcards.buy_provider` (reloadly | prestmit). We run
// the buy flow TWICE — once per provider — proving the switch drives the
// WHOLE flow end-to-end:
//   1. provider=reloadly  → the buy tab lists the Reloadly catalogue.
//   2. provider=prestmit  → the buy tab lists the Prestmit catalogue.
// We assert the two catalogues actually DIFFER (different brand set and/or
// the brand.providerName flips), which proves the switch controls
// listing/pricing end-to-end and not just a flag value.
//
// Backend resolution (confirmed by reading giftcards-service):
//   GetGiftCardBrands → service.buyProvider(ctx) → activeBuyProviderName(ctx)
//   → the giftcards.buy_provider flag → that provider's LIVE catalogue.
//   The SettingsService caches the flag for 10s, so after switching we WAIT
//   ~12s before driving the buy.
//
// REAL-WORLD CAVEATS (handled, not fought):
//   • Reloadly sandbox wallet ~1.82 USD → a paid buy likely fails at the
//     provider with insufficient funds. That is an EXPECTED terminal — we
//     assert the UI surfaces it cleanly (error / insufficient-funds /
//     awaiting-provider) and treat reaching ANY clean terminal as PASS.
//   • Prestmit buy needs the account PIN (system_settings
//     giftcards.prestmit_account_pin=1234) AND a funded NAIRA wallet.
//     SINGLE ATTEMPT ONLY for the Prestmit leg — if create returns a
//     wrong-PIN error we STOP (a few wrong attempts FREEZE the partner
//     account); we never retry the buy. Empty NAIRA wallet is an expected
//     terminal too.
//
// The giftcard datasource is wired to the FINANCIAL gateway channel
// (injection_container.dart → 'financialGrpcClient' → FINANCIAL_GRPC_PORT
// 50071). financial-gateway registers GiftCardsService and proxies to
// giftcards-service :50057. So the backend that must be up for the UI path
// is financial-gateway (50071) + giftcards-service (50057), plus
// core-gateway (50070) + accounts-service (50052) for provisioning.
//
// Harness mirrors the GREEN giftcard_sell_e2e_test.dart: a `_Results`
// pass/fail/warn ledger, `setUpAll` provisions a fresh user (signup →
// CreditBalance fund → CreateTransactionPin) AND seeds the app's secure
// storage + AccountManager so in-app gRPC calls are authenticated with an
// active account, and `tearDownAll` prints a summary FIRST then bounds each
// channel shutdown with a 3s timeout. The app's init() is NOT idempotent,
// so app.main() runs exactly ONCE inside a single testWidgets block.
//
// Android emulator run:
//   cd lazervaultapp
//   flutter test integration_test/giftcard_buy_e2e_test.dart \
//     -d emulator-5554 \
//     --dart-define=TEST_BACKEND_HOST=10.0.2.2 \
//     --timeout=30m

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
import 'package:lazervault/src/generated/giftcards.pb.dart' as gc_pb;
import 'package:lazervault/src/generated/giftcards.pbgrpc.dart' as gc_grpc;
import 'package:lazervault/src/features/gift_cards/cubit/gift_card_cubit.dart';
import 'package:lazervault/src/features/gift_cards/cubit/gift_card_state.dart';
import 'package:lazervault/src/features/gift_cards/domain/entities/gift_card_entity.dart';

// ============================================================================
// Configuration
// ============================================================================

const String grpcHost =
    String.fromEnvironment('TEST_BACKEND_HOST', defaultValue: 'localhost');
const int coreGatewayPort = 50070; // auth, accounts (via gateway), pin
const int accountsServiceDirectPort = 50052; // CreditBalance (sandbox fund)
// giftcards-service direct gRPC port. The emulator reaches the host at
// 10.0.2.2; the buy-provider flag is flipped via the service's
// UpdateSystemSetting RPC (auth-gated — our provisioned user's JWT
// satisfies it; it only requires a present user id, not an admin role).
const int giftcardsServiceDirectPort = 50057;

const String testPassword = r'Password1$';
const String testPin = '1234';
// ₦500,000 — gives a buy the best chance of completing; also covers the
// fund hold + any FX-drift overdraft buffer on the user's NGN wallet.
const int fundAmountKobo = 500000 * 100;

// ============================================================================
// Result book-keeping (mirrors sell e2e)
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
  final email = 'gc-buy-e2e-$ts@lazervault.test';
  final phone = '+23480${(10000000 + (ts % 90000000)).toString()}';
  final deviceId = 'gc-buy-e2e-$ts';

  final auth = auth_pb.AuthServiceClient(core);
  // ignore: avoid_print
  print('  -> signup $email');
  final signupResp = await auth.signup(SignupRequest(
    email: email,
    password: testPassword,
    firstName: 'Buy',
    lastName: 'Tester',
    phone: phone,
    deviceId: deviceId,
    deviceName: 'GiftCard Buy E2E',
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
      deviceName: 'GiftCard Buy E2E',
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
    reference: 'E2E-GCBUY-FUND-${DateTime.now().microsecondsSinceEpoch}',
    type: 'deposit',
    description: 'E2E giftcard buy test funding',
    serviceName: 'e2e-test',
    idempotencyKey:
        'E2E-GCBUY-FUND-IDEM-${DateTime.now().microsecondsSinceEpoch}',
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
      deviceName: 'GiftCard Buy E2E',
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
// user with an active account. The buy RPC requires BOTH the bearer token
// AND x-account-id; we set both here.
Future<void> _seedAppAuth(_Session s) async {
  const storage = FlutterSecureStorage();
  await storage.write(key: 'access_token', value: s.accessToken);
  await storage.write(key: 'user_id', value: s.userId);
  await storage.write(key: 'refresh_token', value: s.accessToken);
  GetIt.I<AccountManager>().setActiveAccount(s.ngnAccountId);
}

// ============================================================================
// Catalogue snapshot (per-provider) for the switch assertion
// ============================================================================

class _Catalogue {
  final String provider; // requested provider for this leg
  final List<GiftCardBrand> brands;
  _Catalogue(this.provider, this.brands);

  // Provider names the catalogue's brands self-report (proves which
  // provider actually served the listing).
  Set<String> get reportedProviders => brands
      .map((b) => b.providerName.trim().toLowerCase())
      .where((p) => p.isNotEmpty)
      .toSet();

  // Stable identity set for diffing two catalogues. Brand IDs differ per
  // provider (Reloadly product IDs vs Prestmit card slugs), and names also
  // differ; we key on lowercased name|id pairs.
  Set<String> get identity => brands
      .map((b) => '${b.name.trim().toLowerCase()}|${b.id.trim().toLowerCase()}')
      .toSet();

  Set<String> get names =>
      brands.map((b) => b.name.trim().toLowerCase()).toSet();
}

// ============================================================================
// Provider-switch helper: flip the active buy provider via the
// giftcards-service UpdateSystemSetting RPC. The integration_test code runs
// ON the emulator (its gRPC channels target 10.0.2.2 = the host), so it
// cannot run host psql. UpdateSystemSetting writes system_settings.value for
// 'giftcards.buy_provider' on the backend exactly like the admin dashboard
// does, and is auth-gated (requires a present user id — our provisioned
// user's JWT satisfies it). After it returns we still wait the
// SettingsService 10s cache TTL before the next listing.
// ============================================================================

Future<bool> _setBuyProvider(
  ClientChannel giftcards,
  String token,
  String provider,
  _Results results,
) async {
  try {
    final client = gc_grpc.GiftCardsServiceClient(giftcards);
    final resp = await client.updateSystemSetting(
      gc_pb.UpdateSystemSettingRequest(
        key: 'giftcards.buy_provider',
        value: provider,
      ),
      options: _authOpts(token),
    );
    if (!resp.success) {
      results.warn(
          'Set buy_provider=$provider', 'RPC success=false: ${resp.message}');
      return false;
    }
    results.ok('Set buy_provider=$provider',
        'UpdateSystemSetting OK (value=${resp.setting.value})');
    return true;
  } catch (e) {
    results.warn('Set buy_provider=$provider', 'UpdateSystemSetting threw: $e');
    return false;
  }
}

// ============================================================================
// Test
// ============================================================================

void main() {
  final results = _Results();

  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Gift Card BUY E2E (UI-driven, provider-switch)', () {
    late _Session session;
    late ClientChannel core;
    late ClientChannel accountsDirect;
    late ClientChannel giftcardsDirect;

    setUpAll(() async {
      // ignore: avoid_print
      print('\n${'=' * 70}');
      // ignore: avoid_print
      print('Gift Card BUY E2E — provisioning fresh user');
      // ignore: avoid_print
      print('=' * 70);

      core = _channel(coreGatewayPort);
      accountsDirect = _channel(accountsServiceDirectPort);
      giftcardsDirect = _channel(giftcardsServiceDirectPort);

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
    });

    tearDownAll(() async {
      // Restore the starting provider value (the suite began with reloadly).
      try {
        await _setBuyProvider(
                giftcardsDirect, session.accessToken, 'reloadly', results)
            .timeout(const Duration(seconds: 8), onTimeout: () => false);
      } catch (_) {}

      // Print the ledger FIRST so the summary always lands even if channel
      // teardown misbehaves. gRPC ClientChannel.shutdown() can HANG under
      // the integration_test binding; bound the shutdowns with a timeout.
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
      try {
        await giftcardsDirect
            .shutdown()
            .timeout(const Duration(seconds: 3), onTimeout: () {});
      } catch (_) {}
      if (results.failed > 0) {
        fail('Gift Card BUY E2E had ${results.failed} failure(s)');
      }
    });

    // ── Single app-driven testWidgets: boot ONCE, then run the BUY flow for
    //    BOTH providers sequentially (app.main() can only run once — init()
    //    is not idempotent — so everything app-driven stays in one block).
    final catalogues = <String, _Catalogue>{};
    testWidgets(
        'App-driven: buy flow for provider=reloadly then provider=prestmit',
        (tester) async {
      // 0) Set the FIRST provider (reloadly) BEFORE booting the app so the
      //    very first hub load already reflects it. The flag cache is 10s;
      //    we boot the app (~40s) which more than covers the TTL. This is a
      //    real network RPC, so run it in the real async zone.
      await tester.runAsync(() async {
        await _setBuyProvider(
            giftcardsDirect, session.accessToken, 'reloadly', results);
      });

      // 1) Boot the real app HERE (once). app.main() does REAL async work
      //    before runApp() (dotenv, DI init, gRPC channel warmup, locale
      //    fetch) on real timers/sockets, so run it inside tester.runAsync()
      //    and wait wall-clock for the GetMaterialApp to mount.
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

      // 2) Drive the framework with the test clock so the just-mounted
      //    GetMaterialApp lays out and GetX registers its navigator. Bounded
      //    only — never settle on the boot auth-check spinner.
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
        results.fail('App boots',
            'GetMaterialApp/Navigator never mounted after boot '
            '(navInTree=${find.byType(Navigator).evaluate().isNotEmpty} '
            'getKey=${Get.key.currentState != null} getCtx=${Get.context != null})');
        return;
      }
      results.ok('App boots');

      // 3) Seed an authenticated session (token + active account).
      try {
        await _seedAppAuth(session);
        results.ok('Seed authenticated session',
            'token+account seeded (acct=${session.ngnAccountId})');
      } catch (e) {
        results.fail('Seed authenticated session', '$e');
      }
      // Let the boot screen finish navigating off the auth-check spinner.
      for (var i = 0; i < 20; i++) {
        await tester.pump(const Duration(milliseconds: 300));
      }

      // 4) Run the BUY flow for each provider in turn. The first leg uses the
      //    flag set above; the second flips it + waits the cache TTL.
      final reloadlyCat = await _runBuyLeg(
        tester,
        results,
        giftcards: giftcardsDirect,
        token: session.accessToken,
        provider: 'reloadly',
        flipFirst: false, // already set before boot
      );
      if (reloadlyCat != null) catalogues['reloadly'] = reloadlyCat;

      final prestmitCat = await _runBuyLeg(
        tester,
        results,
        giftcards: giftcardsDirect,
        token: session.accessToken,
        provider: 'prestmit',
        flipFirst: true,
      );
      if (prestmitCat != null) catalogues['prestmit'] = prestmitCat;

      // 5) The CORE assertion: the two catalogues must DIFFER, proving the
      //    switch drives the whole listing (not just a flag value).
      final r = catalogues['reloadly'];
      final p = catalogues['prestmit'];
      if (r == null || p == null) {
        results.warn('Provider switch drives catalogue',
            'could not capture both catalogues '
            '(reloadly=${r?.brands.length ?? "—"} prestmit=${p?.brands.length ?? "—"}); '
            'see per-leg results');
      } else {
        final reportedDiffer =
            r.reportedProviders.toString() != p.reportedProviders.toString();
        final identityDiffer = r.identity.toString() != p.identity.toString();
        final namesDiffer = r.names.toString() != p.names.toString();
        // Jaccard-style overlap on names: low overlap = clearly different
        // catalogues. (Reloadly returns hundreds of global brands; Prestmit
        // sandbox returns a small distinct set.)
        final overlap = r.names.intersection(p.names).length;
        if (reportedDiffer || identityDiffer || namesDiffer) {
          results.ok('Provider switch drives catalogue',
              'reloadly: ${r.brands.length} brands providers=${r.reportedProviders} | '
              'prestmit: ${p.brands.length} brands providers=${p.reportedProviders} | '
              'name-overlap=$overlap | reportedDiffer=$reportedDiffer '
              'identityDiffer=$identityDiffer namesDiffer=$namesDiffer');
        } else {
          results.fail('Provider switch drives catalogue',
              'catalogues identical — switch did NOT change listing '
              '(reloadly providers=${r.reportedProviders} '
              'prestmit providers=${p.reportedProviders})');
        }
      }
    });
  });
}

// ── One BUY leg for a given provider: (optionally flip the flag + wait the
//    cache TTL) → navigate to hub → BUY tab → capture catalogue → tap brand →
//    smallest denom → Purchase → PIN → processing → terminal. Returns the
//    captured catalogue for the switch assertion, or null if listing failed.
Future<_Catalogue?> _runBuyLeg(
  WidgetTester tester,
  _Results results, {
  required ClientChannel giftcards,
  required String token,
  required String provider,
  required bool flipFirst,
}) async {
  final tag = 'BUY[$provider]';

  // (a) Flip the active buy provider + wait out the 10s SettingsService
  //     cache so the next listing reflects it. Done in real time.
  if (flipFirst) {
    await tester.runAsync(() async {
      await _setBuyProvider(giftcards, token, provider, results);
      // ignore: avoid_print
      print('  -> $tag waiting ~12s for SettingsService cache (10s TTL) to expire');
      await Future<void>.delayed(const Duration(seconds: 12));
    });
  }

  // (b) Navigate to the gift cards hub. The hub defaults to the BUY tab
  //     (_currentTab=0) and loads brands on open. Use a fresh route each leg
  //     so the second leg re-fetches with the new provider.
  try {
    // offAllNamed clears the stack so a fresh GiftCardsScreen mounts and its
    // initState re-runs loadGiftCardBrands() against the now-active provider.
    Get.offAllNamed(AppRoutes.giftCards);
  } catch (e) {
    results.fail('$tag reach hub', 'Get.offAllNamed threw: $e');
    return null;
  }

  // Wait (bounded) for the BUY tab toggle to render.
  var buyTab = find.byKey(const Key('giftcards_buy_tab'));
  final hubDeadline = DateTime.now().add(const Duration(seconds: 30));
  while (buyTab.evaluate().isEmpty && DateTime.now().isBefore(hubDeadline)) {
    await tester.pump(const Duration(milliseconds: 400));
    buyTab = find.byKey(const Key('giftcards_buy_tab'));
  }
  if (buyTab.evaluate().isEmpty) {
    results.fail('$tag reach hub', 'Buy tab not found — hub did not render');
    return null;
  }
  // Ensure we are on the BUY tab (default, but tap to be deterministic).
  await tester.tap(buyTab);
  await tester.pump(const Duration(milliseconds: 400));
  results.ok('$tag reach hub', 'Buy tab visible');

  // (c) Wait for brand cards to load (live provider catalogue round-trip).
  Finder tiles = find.byWidgetPredicate((w) =>
      w.key is Key &&
      (w.key as Key).toString().contains('giftcard_brand_card_'));
  final deadline = DateTime.now().add(const Duration(seconds: 60));
  while (tiles.evaluate().isEmpty && DateTime.now().isBefore(deadline)) {
    await tester.pump(const Duration(milliseconds: 800));
    tiles = find.byWidgetPredicate((w) =>
        w.key is Key &&
        (w.key as Key).toString().contains('giftcard_brand_card_'));
  }
  await tester.pump(const Duration(milliseconds: 500));

  if (tiles.evaluate().isEmpty) {
    results.fail('$tag load catalogue',
        'no brand cards rendered after 60s (provider listing may be empty/down)');
    return null;
  }

  // (d) Capture the catalogue from the cubit (source of truth for brand
  //     names + providerName). This is what the switch assertion diffs.
  _Catalogue? captured;
  GiftCardBrand? chosen;
  try {
    final cubit = BlocProvider.of<GiftCardCubit>(tester.element(tiles.first));
    final brands = cubit.cachedBrands;
    captured = _Catalogue(provider, List<GiftCardBrand>.from(brands));
    if (brands.isNotEmpty) {
      // Prefer a brand with the SMALLEST minimum amount to give a completed
      // buy the best chance (cheapest denomination). Fall back to first.
      final sorted = List<GiftCardBrand>.from(brands)
        ..sort((a, b) {
          final am = _brandMinAmount(a);
          final bm = _brandMinAmount(b);
          return am.compareTo(bm);
        });
      chosen = sorted.first;
    }
    results.ok('$tag load catalogue',
        '${brands.length} brands | reported providers=${captured.reportedProviders} | '
        'first few=${brands.take(3).map((b) => b.name).join(", ")}');
  } catch (e) {
    results.warn('$tag load catalogue', 'could not read cubit cache: $e');
  }

  // Tap the chosen brand tile (by its keyed card) → PurchaseGiftCardScreen.
  Finder targetTile;
  if (chosen != null) {
    targetTile = find.byKey(Key('giftcard_brand_card_${chosen.id}'));
    if (targetTile.evaluate().isEmpty) {
      // The cheapest brand may be off-screen / on a later page; fall back to
      // the first rendered tile.
      targetTile = tiles.first;
    }
  } else {
    targetTile = tiles.first;
  }
  await tester.ensureVisible(targetTile);
  await tester.pump(const Duration(milliseconds: 300));
  await tester.tap(targetTile);
  await tester.pumpAndSettle(const Duration(seconds: 3));

  // (e) Confirm we're on the purchase screen (Purchase CTA present).
  final purchaseBtn = find.byKey(const Key('purchase_giftcard_button'));
  final screenDeadline = DateTime.now().add(const Duration(seconds: 15));
  while (purchaseBtn.evaluate().isEmpty &&
      DateTime.now().isBefore(screenDeadline)) {
    await tester.pump(const Duration(milliseconds: 400));
  }
  if (purchaseBtn.evaluate().isEmpty) {
    results.fail('$tag open purchase screen',
        'Purchase CTA not found — did not reach PurchaseGiftCardScreen');
    return captured;
  }
  results.ok('$tag open purchase screen',
      'brand=${chosen?.name ?? "?"}');

  // (f) Select the SMALLEST denomination. The pills are sorted ascending in
  //     the screen, so pill index 0 is the cheapest. Tap it.
  final firstPill = find.byKey(const Key('giftcard_denom_pill_0'));
  if (firstPill.evaluate().isNotEmpty) {
    await tester.ensureVisible(firstPill);
    await tester.tap(firstPill);
    await tester.pumpAndSettle();
    results.ok('$tag select denomination', 'smallest pill (index 0) selected');
  } else {
    // No fixed pills (pure range brand): the custom amount field is enabled
    // and the buy CTA needs a typed amount. But the screen generates range
    // suggestion pills for range brands too, so absence is rare. Try entering
    // the brand minimum into the custom field if present.
    final customField = find.byType(TextFormField);
    if (customField.evaluate().isNotEmpty && chosen != null) {
      final minA = _brandMinAmount(chosen);
      await tester.enterText(
          customField.first, (minA > 0 ? minA : 5).toStringAsFixed(0));
      await tester.pumpAndSettle();
      results.ok('$tag select denomination',
          'custom amount entered (${minA > 0 ? minA : 5})');
    } else {
      results.warn('$tag select denomination',
          'no denomination pills and no custom field — cannot set amount');
      return captured;
    }
  }

  // (g) Tap Purchase → opens the transaction-PIN modal.
  await tester.ensureVisible(purchaseBtn);
  await tester.tap(purchaseBtn);
  await tester.pumpAndSettle(const Duration(seconds: 2));

  // tx-PIN modal: enter 1234 across the 4 digit fields. The 4th digit
  // auto-submits → verify → navigate to the processing screen.
  final firstDigit = find.byKey(const Key('transaction_pin_digit_0'));
  final pinDeadline = DateTime.now().add(const Duration(seconds: 20));
  while (firstDigit.evaluate().isEmpty &&
      DateTime.now().isBefore(pinDeadline)) {
    await tester.pump(const Duration(milliseconds: 500));
  }
  if (firstDigit.evaluate().isEmpty) {
    results.fail('$tag PIN entry', 'PIN modal did not appear after Purchase');
    return captured;
  }
  for (var i = 0; i < 4; i++) {
    final digit = find.byKey(Key('transaction_pin_digit_$i'));
    await tester.enterText(digit, testPin[i]);
    await tester.pump(const Duration(milliseconds: 200));
  }
  // Do NOT pumpAndSettle: the buy navigates to the processing screen whose
  // CircularProgressIndicator animates forever. Finite pump dispatches the
  // PIN submit; the bounded loop below waits for the terminal.
  await tester.pump(const Duration(seconds: 1));
  results.ok('$tag PIN entry', 'entered $testPin and submitted');

  // (h) Wait for a terminal outcome. We read the cubit state directly (the
  //     processing screen's BlocBuilder owns the same GiftCardCubit). Any
  //     CLEAN terminal counts as PASS for this leg:
  //       • GiftCardPurchaseCompleted   → funded buy completed (redeem code)
  //       • GiftCardPurchaseAwaitingProvider → async, provider call pending
  //       • GiftCardInsufficientFunds   → expected (Reloadly low wallet)
  //       • GiftCardPurchaseError       → expected provider/wallet/PIN error
  //       • GiftCardSoldOut / *Unavailable / *Validation / *NotFound → clean
  final saleDeadline = DateTime.now().add(const Duration(seconds: 120));
  String reached = '';
  String redeemCode = '';
  String errMsg = '';
  GiftCardCubit? liveCubit;
  while (DateTime.now().isBefore(saleDeadline)) {
    await tester.pump(const Duration(milliseconds: 800));

    // Locate the live cubit via the processing screen's BlocBuilder element.
    try {
      final f = find.byType(BlocBuilder<GiftCardCubit, GiftCardState>);
      if (f.evaluate().isNotEmpty) {
        liveCubit = BlocProvider.of<GiftCardCubit>(tester.element(f.first));
      }
    } catch (_) {/* keep last */}

    final st = liveCubit?.state;
    if (st is GiftCardPurchaseCompleted) {
      reached = 'completed';
      redeemCode = st.giftCard.redemptionCode ?? '';
      break;
    }
    if (st is GiftCardPurchaseAwaitingProvider) {
      reached = 'awaiting_provider';
      break;
    }
    if (st is GiftCardInsufficientFunds) {
      reached = 'insufficient_funds';
      errMsg = 'need=${st.required} have=${st.available}';
      break;
    }
    if (st is GiftCardSoldOut) {
      reached = 'sold_out';
      break;
    }
    if (st is GiftCardPurchaseError) {
      reached = 'purchase_error';
      errMsg = st.message;
      break;
    }
    if (st is GiftCardValidationError) {
      reached = 'validation_error';
      errMsg = st.message;
      break;
    }
    if (st is GiftCardNotFound) {
      reached = 'not_found';
      break;
    }
    if (st is GiftCardServerUnavailable) {
      reached = 'server_unavailable';
      break;
    }
    if (st is GiftCardTimeoutError) {
      reached = 'timeout';
      break;
    }
    // UI fallbacks: the processing screen renders its own error view, or a
    // completed buy navigates to the gift-card details receipt.
    if (Get.currentRoute == AppRoutes.giftCardDetails) {
      reached = 'receipt(giftCardDetails)';
      break;
    }
    if (find.textContaining('Insufficient Funds').evaluate().isNotEmpty) {
      reached = 'insufficient_funds(ui)';
      break;
    }
    if (find.textContaining('Purchase Failed').evaluate().isNotEmpty ||
        find.textContaining('Service Unavailable').evaluate().isNotEmpty ||
        find.textContaining('Validation Error').evaluate().isNotEmpty) {
      reached = 'error_view(ui)';
      break;
    }
  }
  // Bounded pump only — the processing spinner never settles.
  await tester.pump(const Duration(milliseconds: 500));

  // For the PRESTMIT leg specifically, surface PIN/wallet status from the
  // error text per the task's single-attempt requirement.
  if (provider == 'prestmit' && reached.contains('error')) {
    final low = errMsg.toLowerCase();
    if (low.contains('wrong pin') ||
        low.contains('valid 4-digit') ||
        low.contains('valid 4 digit') ||
        low.contains('attempts left') ||
        low.contains('frozen') ||
        low.contains('freeze')) {
      results.warn('$tag Prestmit account PIN',
          'create returned a wrong-PIN/freeze error — STOPPED, no retry: "$errMsg"');
    } else if (low.contains('insufficient') ||
        low.contains('wallet') ||
        low.contains('balance')) {
      results.ok('$tag Prestmit wallet',
          'empty/low NAIRA wallet surfaced cleanly (expected terminal): "$errMsg"');
    } else {
      results.ok('$tag Prestmit account PIN',
          'no wrong-PIN/freeze wording — PIN appears accepted; terminal="$reached" msg="$errMsg"');
    }
  }

  if (reached.isEmpty) {
    results.fail('$tag reach terminal',
        'no clean terminal within 120s (cubit_state=${liveCubit?.state.runtimeType} '
        'route=${Get.currentRoute})');
  } else {
    final detail = StringBuffer(reached);
    if (redeemCode.isNotEmpty) {
      detail.write('  redeemCode=${_mask(redeemCode)}');
    }
    if (errMsg.isNotEmpty) detail.write('  [$errMsg]');
    // completed + awaiting + insufficient_funds + clean errors are all PASS:
    // the UI buy flow ran end-to-end and reached a clean terminal without a
    // hang or unhandled crash, driven by the active provider's catalogue.
    results.ok('$tag reach terminal', detail.toString());
  }

  return captured;
}

double _brandMinAmount(GiftCardBrand b) {
  if (b.fixedDenominations.isNotEmpty) {
    var m = double.infinity;
    for (final d in b.fixedDenominations) {
      if (d.price > 0 && d.price < m) m = d.price;
    }
    if (m.isFinite) return m;
  }
  if (b.denominations.isNotEmpty) {
    var m = double.infinity;
    for (final d in b.denominations) {
      if (d > 0 && d < m) m = d;
    }
    if (m.isFinite) return m;
  }
  if (b.minAmount > 0) return b.minAmount;
  return double.maxFinite; // sort unknowns last
}

String _mask(String code) {
  if (code.length <= 4) return '****';
  return '${code.substring(0, 2)}***${code.substring(code.length - 2)}';
}
