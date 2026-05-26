// Gift Card TRANSACTION HISTORY + FILTERS E2E Integration Test
// (REAL UI-driven, both BUY history and SELL history)
//
// Drives the production Flutter gift-card history screens THROUGH THE UI —
// not a gRPC script — against the real local backend, exactly as a real
// user would, and asserts the STATUS FILTER TABS on each screen select the
// correct subset of rows:
//
//   • My Sales (SELL history) — route AppRoutes.mySales (/gift-cards/my-sales)
//     TabBar ['All','In Review','Approved','Paid','Rejected'] →
//     backend GetMySales(status:) filters [null,'pending_review','approved',
//     'paid','rejected']. Tab switch RE-QUERIES the backend.
//
//   • My Gift Cards (BUY history) — route AppRoutes.myGiftCards
//     (/gift-cards/my-cards). Tabs ['Available','Expired','Failed','All'].
//     Filtering is CLIENT-side on card.status over loadMyGiftCards(); the
//     'All' tab includes failed and paginates.
//
// DATA STRATEGY — a fresh user has no history, and the sandbox only ever
// yields pending_review (sell) / pending (buy), so the Approved/Paid/Rejected
// and Available/Expired/Failed filters would have nothing to select. So a
// KNOWN user is provisioned up-front on the HOST (grpcurl signup → NGN
// account → CreditBalance fund → CreateTransactionPin), and rows in every
// status are SEEDED for that user_id directly into giftcards_db via host
// psql. This test logs in as that SAME user (via gRPC from the emulator
// against 10.0.2.2) so GetMySales / loadMyGiftCards return the seeded rows.
//
// The known-user credentials + seeded user_id/account are injected via
// --dart-define so the test stays reproducible and doesn't have to do the
// (host-only) provisioning/seeding itself.
//
// Harness mirrors the GREEN giftcard_sell_e2e_test.dart / giftcard_buy_e2e_
// test.dart: ONE testWidgets with a single app.main() at its start (init is
// NOT idempotent); a real-timer boot via tester.runAsync() + navigator-ready
// wait; a BACKGROUND adb Bluetooth-grant watcher (the BT dialog hangs boot
// otherwise); navigate via Get.toNamed; bounded pump() (never pumpAndSettle
// on spinners); tearDownAll prints the summary FIRST then bounds each
// ClientChannel.shutdown() at 3s.
//
// Android emulator run:
//   cd lazervaultapp
//   flutter test integration_test/giftcard_history_e2e_test.dart \
//     -d emulator-5554 \
//     --dart-define=TEST_BACKEND_HOST=10.0.2.2 \
//     --timeout=30m

import 'dart:io';

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
import 'package:lazervault/src/features/gift_cards/cubit/gift_card_cubit.dart';
import 'package:lazervault/src/features/gift_cards/cubit/gift_card_state.dart';
import 'package:lazervault/src/features/gift_cards/domain/entities/gift_card_entity.dart';
import 'package:lazervault/src/features/gift_cards/presentation/view/my_sales_screen.dart';
import 'package:lazervault/src/features/gift_cards/presentation/view/my_gift_cards_screen.dart';

// ============================================================================
// Configuration — the KNOWN seeded user, injected via --dart-define. The
// defaults below are the user provisioned + seeded by the host harness for
// this test run; override at runtime to re-provision a different user.
// ============================================================================

const String grpcHost =
    String.fromEnvironment('TEST_BACKEND_HOST', defaultValue: 'localhost');
const int coreGatewayPort = 50070; // auth login

const String testEmail = String.fromEnvironment('GC_HIST_EMAIL',
    defaultValue: 'gc-hist-e2e-1779778079@lazervault.test');
const String testPassword =
    String.fromEnvironment('GC_HIST_PASSWORD', defaultValue: r'Password1$');
const String testDeviceId = String.fromEnvironment('GC_HIST_DEVICE',
    defaultValue: 'gc-hist-e2e-1779778079');
const String testNgnAccountId = String.fromEnvironment('GC_HIST_NGN_ACCOUNT',
    defaultValue: '439dafad-0136-4b00-8e3d-dff6626bf920');

// What we seeded for this user (host psql). Used to assert counts.
//   SELL (giftcard_sales): one row per status.
const Map<String, String> _seededSaleRefByStatus = {
  'pending_review': 'GC-HIST-SELL-PENDINGREVIEW',
  'approved': 'GC-HIST-SELL-APPROVED',
  'paid': 'GC-HIST-SELL-PAID',
  'rejected': 'GC-HIST-SELL-REJECTED',
};
//   BUY (giftcards): one row per bucket.
const Map<String, String> _seededBuyRefByStatus = {
  'available': 'GC-HIST-BUY-AVAILABLE',
  'expired': 'GC-HIST-BUY-EXPIRED',
  'failed': 'GC-HIST-BUY-FAILED',
  'pending': 'GC-HIST-BUY-PENDING',
};

// ============================================================================
// Result book-keeping (mirrors the green sell/buy e2e tests)
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
    print(
        'RESULTS  passed=$passed/$total  failed=$failed  warns=${warns.length}');
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
// gRPC helpers
// ============================================================================

ClientChannel _channel(int port) => ClientChannel(
      grpcHost,
      port: port,
      options: const ChannelOptions(
        credentials: ChannelCredentials.insecure(),
        connectionTimeout: Duration(seconds: 10),
      ),
    );

// Log in as the KNOWN seeded user and return its access token. The host
// harness already provisioned this user (signup → fund → PIN) and seeded its
// history rows; we just need a fresh token to authenticate the in-app gRPC
// reads (GetMySales / GetGiftCards).
Future<String> _login(ClientChannel core) async {
  final auth = auth_pb.AuthServiceClient(core);
  final resp = await auth.login(LoginRequest(
    email: testEmail,
    password: testPassword,
    deviceId: testDeviceId,
    deviceName: 'GiftCard Hist E2E',
  ));
  final token = resp.hasData() && resp.data.session.accessToken.isNotEmpty
      ? resp.data.session.accessToken
      : resp.accessToken;
  if (token.isEmpty) throw Exception('login: no access token for $testEmail');
  return token;
}

// Seed the app so its in-process gRPC calls authenticate as our known user
// with an active account (the giftcards reads require BOTH the bearer token
// AND x-account-id — set both here).
Future<void> _seedAppAuth(String token, String userId) async {
  const storage = FlutterSecureStorage();
  await storage.write(key: 'access_token', value: token);
  await storage.write(key: 'user_id', value: userId);
  await storage.write(key: 'refresh_token', value: token);
  GetIt.I<AccountManager>().setActiveAccount(testNgnAccountId);
}

// Decode the user_id from the JWT (mid segment, base64url JSON) so we can
// seed secure storage with the matching user id without an extra round-trip.
String _userIdFromJwt(String jwt) {
  try {
    final parts = jwt.split('.');
    if (parts.length < 2) return '';
    var seg = parts[1].replaceAll('-', '+').replaceAll('_', '/');
    while (seg.length % 4 != 0) {
      seg += '=';
    }
    final json = String.fromCharCodes(_b64Decode(seg));
    final m = RegExp(r'"user_id"\s*:\s*"([^"]+)"').firstMatch(json) ??
        RegExp(r'"sub"\s*:\s*"([^"]+)"').firstMatch(json);
    return m?.group(1) ?? '';
  } catch (_) {
    return '';
  }
}

List<int> _b64Decode(String s) {
  // Tiny base64 decoder to avoid extra imports.
  const chars =
      'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';
  final out = <int>[];
  var buffer = 0;
  var bits = 0;
  for (final ch in s.split('')) {
    if (ch == '=') break;
    final v = chars.indexOf(ch);
    if (v < 0) continue;
    buffer = (buffer << 6) | v;
    bits += 6;
    if (bits >= 8) {
      bits -= 8;
      out.add((buffer >> bits) & 0xFF);
    }
  }
  return out;
}

// ============================================================================
// Test
// ============================================================================

void main() {
  final results = _Results();

  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // ── BACKGROUND adb Bluetooth-grant watcher. The Android BT permission
  //    dialog hangs boot; the moment the package is installed, grant the
  //    BLUETOOTH_* perms so the dialog never blocks. Best-effort + detached.
  Process? btWatcher;
  void startBtWatcher() {
    // Loop in the shell so we keep granting as soon as the package appears.
    Process.start('sh', [
      '-c',
      'for i in \$(seq 1 120); do '
          'if adb -s emulator-5554 shell pm list packages 2>/dev/null | grep -q com.example.lazervaultapp; then '
          'adb -s emulator-5554 shell pm grant com.example.lazervaultapp android.permission.BLUETOOTH_CONNECT >/dev/null 2>&1; '
          'adb -s emulator-5554 shell pm grant com.example.lazervaultapp android.permission.BLUETOOTH_SCAN >/dev/null 2>&1; '
          'fi; sleep 1; done',
    ]).then((p) {
      btWatcher = p;
    }).ignore();
  }

  group('Gift Card HISTORY + FILTERS E2E (UI-driven)', () {
    late ClientChannel core;
    late String token;
    late String userId;

    setUpAll(() async {
      // ignore: avoid_print
      print('\n${'=' * 70}');
      // ignore: avoid_print
      print('Gift Card HISTORY E2E — login as KNOWN seeded user');
      // ignore: avoid_print
      print('  email=$testEmail  ngn=$testNgnAccountId');
      // ignore: avoid_print
      print('=' * 70);

      startBtWatcher();
      core = _channel(coreGatewayPort);
      try {
        token = await _login(core);
        userId = _userIdFromJwt(token);
        results.ok('Login as seeded user',
            'token len=${token.length} user=${userId.isNotEmpty ? userId.substring(0, 8) : "?"}');
      } catch (e, st) {
        results.fail('Login as seeded user', '$e');
        // ignore: avoid_print
        print(st);
        results.summary();
        rethrow;
      }
    });

    tearDownAll(() async {
      results.summary();
      try {
        btWatcher?.kill();
      } catch (_) {}
      try {
        await core
            .shutdown()
            .timeout(const Duration(seconds: 3), onTimeout: () {});
      } catch (_) {}
      if (results.failed > 0) {
        fail('Gift Card HISTORY E2E had ${results.failed} failure(s)');
      }
    });

    // ── Single app-driven testWidgets: boot → seed → My Sales filters →
    //    My Gift Cards filters. Everything that depends on the LIVE running
    //    app stays in ONE testWidgets so the GetMaterialApp stays mounted and
    //    Get.key stays live (app.main() can be called exactly once — init()
    //    is NOT idempotent; the framework disposes the tree between tests).
    testWidgets('My Sales + My Gift Cards filter tabs select the right subset',
        (tester) async {
      // 0) Boot the real app HERE (once). app.main() does REAL async work
      //    before runApp() (dotenv, DI init, gRPC channel warmup, locale
      //    fetch) on real timers, so run it inside tester.runAsync() and wait
      //    for the GetMaterialApp/navigator to mount.
      await tester.runAsync(() async {
        app.main();
        // Give the real-async boot (init + gRPC channel warmup + a locale
        // fetch that may stall on token-refresh) generous wall-clock time on
        // the real event loop before runApp() fires.
        final realBootEnd = DateTime.now().add(const Duration(seconds: 75));
        while (DateTime.now().isBefore(realBootEnd)) {
          await Future<void>.delayed(const Duration(milliseconds: 250));
          if (WidgetsBinding.instance.rootElement != null &&
              (Get.key.currentState != null || Get.context != null)) {
            break;
          }
        }
      });

      // 1) Drive the framework with the test clock so the just-mounted
      //    GetMaterialApp lays out and GetX registers its navigator. Bounded
      //    only — never settle on the boot auth-check spinner.
      final bootDeadline = DateTime.now().add(const Duration(seconds: 45));
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
        results.fail('App boots', 'GetMaterialApp/Navigator never mounted');
        return;
      }
      results.ok('App boots');

      // 2) Seed the authenticated session (token + active account) so the
      //    history screens' gRPC reads return the seeded rows.
      try {
        await _seedAppAuth(token, userId);
        results.ok('Seed authenticated session',
            'token+account seeded (acct=$testNgnAccountId)');
      } catch (e) {
        results.fail('Seed authenticated session', '$e');
        return;
      }
      // Let the boot screen finish navigating off the auth-check spinner.
      for (var i = 0; i < 20; i++) {
        await tester.pump(const Duration(milliseconds: 300));
      }

      // ============================================================
      // PART 1 — MY SALES (SELL history) filters
      // ============================================================
      await _testMySales(tester, results);

      // ============================================================
      // PART 2 — MY GIFT CARDS (BUY history) filters
      // ============================================================
      await _testMyGiftCards(tester, results);
    });
  });
}

// ── Read the live MySalesScreen's cubit (source of truth for the loaded
//    sale list under the current tab filter).
GiftCardCubit? _salesCubit(WidgetTester tester) {
  final f = find.byType(MySalesScreen);
  if (f.evaluate().isEmpty) return null;
  try {
    return BlocProvider.of<GiftCardCubit>(tester.element(f.first));
  } catch (_) {
    return null;
  }
}

GiftCardCubit? _buyCubit(WidgetTester tester) {
  final f = find.byType(MyGiftCardsScreen);
  if (f.evaluate().isEmpty) return null;
  try {
    return BlocProvider.of<GiftCardCubit>(tester.element(f.first));
  } catch (_) {
    return null;
  }
}

// Count the DISTINCT visible sale item tiles (keyed mysales_item_<id>).
// Counts unique key strings rather than raw element matches: the
// integration_test tree can carry the same keyed widget across more than
// one render layer (offstage route theater, semantics duplication), which
// would otherwise inflate a raw element count.
int _countSaleTiles(WidgetTester tester) => _distinctKeys(tester, 'mysales_item_');

int _distinctKeys(WidgetTester tester, String prefix) =>
    _distinctTileIds(tester, prefix).length;

// Returns the SET of distinct item IDs visible on screen (the suffix after
// `prefix` in each keyed tile's key string). Using a SET is robust to the
// integration_test tree carrying the same keyed widget across more than one
// render layer (route-transition theater / semantics duplication): identical
// IDs collapse, so the set size equals the number of distinct rows shown.
Set<String> _distinctTileIds(WidgetTester tester, String prefix) {
  final ids = <String>{};
  for (final el in find
      .byWidgetPredicate(
          (w) => w.key is Key && (w.key as Key).toString().contains(prefix))
      .evaluate()) {
    final ks = el.widget.key?.toString() ?? '';
    // ValueKey('mygiftcards_item_<id>').toString() == "[<'mygiftcards_item_<id>'>]"
    final m = RegExp("$prefix([^'>\\]]+)").firstMatch(ks);
    if (m != null) ids.add(m.group(1)!);
  }
  return ids;
}

// ============================================================================
// PART 1 — My Sales (SELL) filters
// ============================================================================

Future<void> _testMySales(WidgetTester tester, _Results results) async {
  // Navigate to the My Sales route.
  try {
    Get.toNamed(AppRoutes.mySales);
  } catch (e) {
    results.fail('My Sales: navigate', 'Get.toNamed threw: $e');
    return;
  }

  // Wait for the screen + its first load (All tab) — bounded pumps, never
  // settle on the spinner.
  final reachDeadline = DateTime.now().add(const Duration(seconds: 40));
  while (DateTime.now().isBefore(reachDeadline)) {
    await tester.pump(const Duration(milliseconds: 400));
    if (find.byKey(const Key('mysales_tab_all')).evaluate().isNotEmpty &&
        _countSaleTiles(tester) > 0) {
      break;
    }
  }
  if (find.byKey(const Key('mysales_tab_all')).evaluate().isEmpty) {
    results.fail('My Sales: reach screen', 'tabs never rendered');
    return;
  }
  results.ok('My Sales: reach screen', 'tab bar + list rendered');

  // The All tab (index 0, no status filter) should show every seeded sale.
  // Assert via the cubit's loaded list (authoritative source the ListView
  // renders from) AND the distinct visible tile-ID set.
  final allVisibleIds = _distinctTileIds(tester, 'mysales_item_');
  final allCubitCount = _salesCubit(tester)?.let((c) {
        final st = c.state;
        return st is MySalesLoaded ? st.sales.length : -1;
      }) ??
      -1;
  if (allCubitCount >= 4 && allVisibleIds.length >= 4) {
    results.ok('My Sales [All]',
        'shows all seeded sales (cubit=$allCubitCount, distinctTiles=${allVisibleIds.length}, expected >=4)');
  } else {
    results.fail('My Sales [All]',
        'expected >=4 seeded sales, cubit=$allCubitCount distinctTiles=${allVisibleIds.length}');
  }

  // Cycle each status tab and assert ONLY that status' sales appear. Tab
  // labels → (key suffix, backend status, status badge text).
  const statusTabs = <(String, String, String)>[
    ('in_review', 'pending_review', 'In Review'),
    ('approved', 'approved', 'Approved'),
    ('paid', 'paid', 'Paid'),
    ('rejected', 'rejected', 'Rejected'),
  ];

  for (final (keySuffix, backendStatus, badgeText) in statusTabs) {
    final tab = find.byKey(Key('mysales_tab_$keySuffix'));
    if (tab.evaluate().isEmpty) {
      results.fail('My Sales [$badgeText]', 'tab key not found');
      continue;
    }
    await tester.tap(tab);
    // Tab switch re-queries the backend (loadMySales(status:)) — bounded wait
    // for the new tab's data. We detect the re-query by the cubit holding a
    // single-status list, or by the seeded reference appearing.
    final tabDeadline = DateTime.now().add(const Duration(seconds: 25));
    final expectedRef = _seededSaleRefByStatus[backendStatus]!;
    var ok = false;
    while (DateTime.now().isBefore(tabDeadline)) {
      await tester.pump(const Duration(milliseconds: 400));
      final c = _salesCubit(tester);
      final st = c?.state;
      if (st is MySalesLoaded) {
        // Every row in this tab must carry the tab's status.
        final mismatched =
            st.sales.where((s) => s.status != backendStatus).toList();
        if (st.sales.length == 1 &&
            mismatched.isEmpty &&
            st.sales.first.status == backendStatus &&
            st.sales.first.reference == expectedRef) {
          ok = true;
          break;
        }
      } else if (st is MySalesEmpty) {
        // Shouldn't happen for our seeded statuses, but bail cleanly.
        break;
      }
    }

    final c = _salesCubit(tester);
    final st = c?.state;
    final tileCount = _countSaleTiles(tester);
    if (ok) {
      final loaded = st as MySalesLoaded;
      results.ok('My Sales [$badgeText]',
          're-queried; exactly 1 $backendStatus sale '
          '(ref=${loaded.sales.first.reference}, tiles=$tileCount)');
    } else {
      final detail = st is MySalesLoaded
          ? 'cubit has ${st.sales.length} rows statuses=${st.sales.map((s) => s.status).toList()}'
          : 'cubit state=${st.runtimeType}';
      results.fail('My Sales [$badgeText]',
          'expected exactly 1 $backendStatus ($expectedRef); $detail tiles=$tileCount');
    }
  }

  // Confirm the rejected sale surfaces its rejection reason / CTA. Switch to
  // the Rejected tab (already there from the loop), open the sale detail
  // sheet, and assert the reason + "Why was this rejected?" CTA render.
  final rejectedTab = find.byKey(const Key('mysales_tab_rejected'));
  if (rejectedTab.evaluate().isNotEmpty) {
    await tester.tap(rejectedTab);
    for (var i = 0; i < 12; i++) {
      await tester.pump(const Duration(milliseconds: 400));
      if (_countSaleTiles(tester) > 0) break;
    }
    final tile = find.byWidgetPredicate((w) =>
        w.key is Key &&
        (w.key as Key).toString().contains('mysales_item_'));
    if (tile.evaluate().isNotEmpty) {
      await tester.tap(tile.first);
      // The sheet calls getSellStatus (transient spinner) — bounded pumps.
      var reasonShown = false;
      final sheetDeadline = DateTime.now().add(const Duration(seconds: 20));
      while (DateTime.now().isBefore(sheetDeadline)) {
        await tester.pump(const Duration(milliseconds: 400));
        if (find.text('Why was this rejected?').evaluate().isNotEmpty ||
            find
                .textContaining('Invalid code: the code you sent is not valid.')
                .evaluate()
                .isNotEmpty ||
            find.text('Reason for rejection').evaluate().isNotEmpty) {
          reasonShown = true;
          break;
        }
      }
      if (reasonShown) {
        final ctaShown =
            find.text('Why was this rejected?').evaluate().isNotEmpty;
        results.ok('My Sales: rejection reason surfaced',
            'reason block + ${ctaShown ? "\"Why was this rejected?\" CTA" : "reason text"} rendered in sale detail');
      } else {
        results.fail('My Sales: rejection reason surfaced',
            'opened rejected sale detail but reason/CTA not found');
      }
      // Close the sheet so it doesn't bleed into Part 2.
      if (find.text('Close').evaluate().isNotEmpty) {
        await tester.tap(find.text('Close').first);
        await tester.pump(const Duration(milliseconds: 400));
      } else {
        Get.back();
        await tester.pump(const Duration(milliseconds: 400));
      }
    } else {
      results.warn('My Sales: rejection reason surfaced',
          'no rejected tile to open');
    }
  }
}

// ============================================================================
// PART 2 — My Gift Cards (BUY) filters (CLIENT-side on card.status)
// ============================================================================

Future<void> _testMyGiftCards(WidgetTester tester, _Results results) async {
  // Navigate to the My Gift Cards route.
  try {
    Get.toNamed(AppRoutes.myGiftCards);
  } catch (e) {
    results.fail('My Gift Cards: navigate', 'Get.toNamed threw: $e');
    return;
  }

  // Wait for the screen + first load (Available tab default).
  final reachDeadline = DateTime.now().add(const Duration(seconds: 40));
  while (DateTime.now().isBefore(reachDeadline)) {
    await tester.pump(const Duration(milliseconds: 400));
    if (find.byKey(const Key('mygiftcards_tab_all')).evaluate().isNotEmpty &&
        _buyCubit(tester) != null) {
      // Cubit must have finished its first load (MyGiftCardsLoaded).
      final st = _buyCubit(tester)?.state;
      if (st is MyGiftCardsLoaded && st.giftCards.isNotEmpty) break;
    }
  }
  if (find.byKey(const Key('mygiftcards_tab_all')).evaluate().isEmpty) {
    results.fail('My Gift Cards: reach screen', 'tabs never rendered');
    return;
  }
  // The cubit holds ALL seeded cards (no backend status filter); the screen
  // filters client-side per tab.
  final buyState = _buyCubit(tester)?.state;
  final totalLoaded =
      buyState is MyGiftCardsLoaded ? buyState.giftCards.length : -1;
  if (totalLoaded >= 4) {
    results.ok('My Gift Cards: reach screen',
        'tab bar rendered; cubit loaded $totalLoaded cards (expected >=4)');
  } else {
    results.fail('My Gift Cards: reach screen',
        'cubit loaded $totalLoaded cards (expected >=4)');
    return;
  }

  // Helper: assert the cubit's loaded cards include the expected statuses.
  final loadedStatuses = (buyState as MyGiftCardsLoaded)
      .giftCards
      .map((c) => c.status)
      .toList();

  // Each tab buckets CLIENT-side. Tab labels → (key suffix, predicate name,
  // expected seeded ref, matcher on a GiftCard).
  bool isExpired(GiftCard c) {
    if (c.status == 'expired') return true;
    if (c.expiryDate.isEmpty) return false;
    final p = DateTime.tryParse(c.expiryDate);
    return p != null && p.isBefore(DateTime.now());
  }

  final buckets = <(String, String, String, bool Function(GiftCard))>[
    (
      'available',
      'Available',
      _seededBuyRefByStatus['available']!,
      (c) => c.status == 'available' && !isExpired(c),
    ),
    (
      'expired',
      'Expired',
      _seededBuyRefByStatus['expired']!,
      (c) => isExpired(c),
    ),
    (
      'failed',
      'Failed',
      _seededBuyRefByStatus['failed']!,
      (c) =>
          c.status.toLowerCase() == 'failed' ||
          c.status.toLowerCase() == 'refunded' ||
          c.status.toLowerCase() == 'reversed',
    ),
    (
      'all',
      'All',
      '', // 'All' = everything incl. failed
      (c) => true,
    ),
  ];

  for (final (keySuffix, label, expectedRef, matcher) in buckets) {
    final tab = find.byKey(Key('mygiftcards_tab_$keySuffix'));
    if (tab.evaluate().isEmpty) {
      results.fail('My Gift Cards [$label]', 'tab key not found');
      continue;
    }
    await tester.tap(tab);
    // Client-side re-filter is synchronous via setState — a few pumps suffice.
    for (var i = 0; i < 8; i++) {
      await tester.pump(const Duration(milliseconds: 300));
    }

    // Expected subset from the cubit's loaded cards (the screen filters this
    // exact list client-side per tab — see _buildGiftCardList).
    final st = _buyCubit(tester)?.state;
    if (st is! MyGiftCardsLoaded) {
      results.fail('My Gift Cards [$label]', 'cubit state=${st.runtimeType}');
      continue;
    }
    final expected = st.giftCards.where(matcher).toList();
    final expectedIds = expected.map((c) => c.id).toSet();
    // Compare the SET of distinct visible tile IDs against the expected set.
    // A set dedupes any duplicated render layers, so this is exact and robust.
    final visibleIds = _distinctTileIds(tester, 'mygiftcards_item_');

    if (label == 'All') {
      // 'All' shows every loaded card incl. failed.
      final allIds = st.giftCards.map((c) => c.id).toSet();
      final allOk = visibleIds.length == allIds.length &&
          visibleIds.containsAll(allIds) &&
          allIds.length >= 4 &&
          loadedStatuses.contains('failed');
      if (allOk) {
        results.ok('My Gift Cards [All]',
            'shows all ${visibleIds.length} cards incl. failed (statuses=$loadedStatuses)');
      } else {
        results.fail('My Gift Cards [All]',
            'visible=${visibleIds.length} loaded=${allIds.length} statuses=$loadedStatuses');
      }
      continue;
    }

    // Status tabs: the visible ID set must equal the client-side bucket's ID
    // set AND include the seeded ref for that bucket.
    final hasSeededRef = expected.any((c) => c.reference == expectedRef);
    final bucketOk = expectedIds.isNotEmpty &&
        visibleIds.length == expectedIds.length &&
        visibleIds.containsAll(expectedIds);
    if (bucketOk) {
      results.ok('My Gift Cards [$label]',
          'shows exactly the ${visibleIds.length}-card bucket '
          '(statuses=${expected.map((c) => c.status).toList()}'
          '${hasSeededRef ? ", seeded ref $expectedRef present" : ""})');
    } else {
      results.fail('My Gift Cards [$label]',
          'visible=${visibleIds.length} expected=${expectedIds.length} '
          'statuses=${expected.map((c) => c.status).toList()}');
    }
  }
}

// Small null-safe helper.
extension _Let<T> on T {
  R let<R>(R Function(T) f) => f(this);
}
