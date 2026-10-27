import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mocktail/mocktail.dart';

import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:lazervault/src/features/recipients/data/repositories/unified_user_search_repository.dart';
import 'package:lazervault/src/features/recipients/domain/entities/unified_search_result.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/unified_user_search_cubit.dart';
import 'package:lazervault/src/features/recipients/presentation/widgets/unified_user_search_sheet.dart';
import 'package:lazervault/src/features/recipients/presentation/widgets/user_search_selection_guard.dart';

// WHY THIS TEST EXISTS
// --------------------
// On a slow link, picking a person from the shared search sheet used to leave
// the screen still for seconds: the sheet popped at once and the caller's
// backend lookup ran against a blank screen before the next sheet appeared.
// The sheet now keeps the tapped row busy until the caller's prepareSelection
// settles. These cases pin the parts that are easy to break silently: the
// spinner is really on the row, a second tap does nothing, a false outcome
// keeps the sheet open, and a sheet swiped away mid-flight never resolves a
// result for a screen to navigate on.

class _MockStorage extends Mock implements SecureStorageService {}

const _ada = UnifiedSearchResult(
  source: 'global',
  userId: 'u-ada',
  displayName: 'Ada Obi',
  name: 'Ada Obi',
  username: 'ada',
  isLazervault: true,
  type: 'internal',
);

const _bola = UnifiedSearchResult(
  source: 'global',
  userId: 'u-bola',
  displayName: 'Bola Ade',
  name: 'Bola Ade',
  username: 'bola',
  isLazervault: true,
  type: 'internal',
);

/// Answers every query with the same two people, through an optional gate so
/// a test can hold a response back and release it later.
class _FakeRepo extends UnifiedUserSearchRepository {
  _FakeRepo() : super(_MockStorage());

  final Map<String, Completer<UnifiedSearchPage>> gates = {};
  final List<String> queries = [];

  @override
  Future<UnifiedSearchPage> search(
    String query, {
    int limit = 20,
    int offset = 0,
    bool internalOnly = false,
  }) {
    queries.add(query);
    final gate = gates[query];
    if (gate != null) return gate.future;
    return Future.value(_page([_ada, _bola]));
  }
}

UnifiedSearchPage _page(List<UnifiedSearchResult> global) => UnifiedSearchPage(
      local: const [],
      global: global,
      hasMore: false,
      nextOffset: 0,
    );

final _busyRow = find.byKey(const ValueKey('user-search-row-busy'));

Future<Future<UnifiedSearchResult?>> _openSheet(
  WidgetTester tester, {
  Future<bool> Function(UnifiedSearchResult)? prepare,
}) async {
  late Future<UnifiedSearchResult?> shown;
  // Phone-sized surface at 1:1 so ScreenUtil's 414x896 design scale is 1.0
  // (the default 800x600 surface scales the sheet ~1.9x and pushes rows out
  // of the viewport).
  tester.view.physicalSize = const Size(414, 896);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    ScreenUtilInit(
      designSize: const Size(414, 896),
      builder: (_, __) => MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (ctx) => TextButton(
              onPressed: () {
                shown = UnifiedUserSearchSheet.show(
                  ctx,
                  mode: RecipientPickerMode.lazervaultUsers,
                  prepareSelection: prepare,
                );
              },
              child: const Text('open'),
            ),
          ),
        ),
      ),
    ),
  );
  await tester.tap(find.text('open'));
  await tester.pumpAndSettle();
  await tester.enterText(find.byType(TextField), 'ad');
  // Debouncer.snappy() is 250ms; then one frame for the results to paint.
  await tester.pump(const Duration(milliseconds: 300));
  await tester.pump();
  expect(find.text('Ada Obi'), findsOneWidget);
  expect(find.text('Bola Ade'), findsOneWidget);
  return shown;
}

/// Counts route pops so a sheet that hands its pick over twice is visible.
class _PopCounter extends NavigatorObserver {
  int pops = 0;
  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    pops++;
    super.didPop(route, previousRoute);
  }
}

void main() {
  late _FakeRepo repo;

  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  setUp(() {
    repo = _FakeRepo();
    GetIt.I.registerFactory<UnifiedUserSearchCubit>(
        () => UnifiedUserSearchCubit(repo));
  });

  tearDown(() async {
    await GetIt.I.reset();
  });

  // THE PLAIN PATH POPS THE SHEET, AND ONLY THE SHEET.
  //
  // `onSelected` is `Navigator.pop`, so a second hand-off pops a second route
  // — the CALLER'S screen — and drops the person out of Send Funds. On the
  // path with no prepareSelection (22 of the 24 callers) the busy guard never
  // arms, so this pins the outcome from the outside: rapid taps on two rows
  // leave the caller's route standing and resolve the first pick, once.
  //
  // Flutter also ignores pointers over a route in its reverse transition, so
  // the second tap below is expected to miss — which is why the sheet's own
  // latch is defence against a change in that behaviour rather than the thing
  // this test demonstrates.
  testWidgets('rapid taps with no prepareSelection pop only the sheet',
      (tester) async {
    final observer = _PopCounter();
    tester.view.physicalSize = const Size(414, 896);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    late Future<UnifiedSearchResult?> shown;
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(414, 896),
        builder: (_, __) => MaterialApp(
          navigatorObservers: [observer],
          home: Scaffold(
            body: Builder(
              builder: (ctx) => TextButton(
                // The sheet is opened from a PUSHED route, which is what a
                // second pop would close.
                onPressed: () => Navigator.of(ctx).push(
                  MaterialPageRoute<void>(
                    builder: (inner) => Scaffold(
                      body: Center(
                        child: TextButton(
                          onPressed: () {
                            shown = UnifiedUserSearchSheet.show(
                              inner,
                              mode: RecipientPickerMode.lazervaultUsers,
                            );
                          },
                          child: const Text('open'),
                        ),
                      ),
                    ),
                  ),
                ),
                child: const Text('push'),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('push'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'ad');
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pump();
    expect(find.text('Ada Obi'), findsOneWidget);

    // Two taps inside one frame, before the exit transition has run. The
    // second is expected not to land (see above) — warnIfMissed is off for
    // exactly that reason, not to hide a broken finder.
    await tester.tap(find.text('Ada Obi'));
    await tester.tap(find.text('Bola Ade'), warnIfMissed: false);
    await tester.pumpAndSettle();

    expect(observer.pops, 1, reason: 'the sheet pops once, and only the sheet');
    expect((await shown)?.userId, 'u-ada',
        reason: 'the FIRST pick wins; the second tap is ignored');
    expect(find.text('open'), findsOneWidget,
        reason: "the caller's own screen is still there");
  });

  group('UnifiedUserSearchSheet with prepareSelection', () {
    testWidgets('tapped row spins, other rows ignore taps, closes once on true',
        (tester) async {
      final gate = Completer<bool>();
      final prepared = <String>[];
      final shown = await _openSheet(tester, prepare: (r) {
        prepared.add(r.userId);
        return gate.future;
      });

      await tester.tap(find.text('Ada Obi'));
      await tester.pump();
      expect(_busyRow, findsOneWidget,
          reason: 'the tapped row shows a spinner');
      expect(prepared, ['u-ada']);
      expect(find.byType(UnifiedUserSearchSheet), findsOneWidget,
          reason: 'the sheet stays open while the work runs');

      // (c) a second tap while busy does nothing.
      await tester.tap(find.text('Bola Ade'));
      await tester.tap(find.text('Ada Obi'));
      await tester.pump();
      expect(prepared, ['u-ada']);
      expect(_busyRow, findsOneWidget);

      // (e) slow call: still spinning well after the tap.
      await tester.pump(const Duration(seconds: 5));
      expect(_busyRow, findsOneWidget);

      gate.complete(true);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400)); // sheet closes
      expect(find.byType(UnifiedUserSearchSheet), findsNothing);
      expect((await shown)?.userId, 'u-ada');
      expect(prepared, ['u-ada'], reason: 'the destination opens exactly once');
    });

    testWidgets('a false outcome keeps the sheet open with the row idle',
        (tester) async {
      var gate = Completer<bool>();
      var resolved = false;
      final shown = await _openSheet(tester, prepare: (_) => gate.future);
      // ignore: unawaited_futures
      shown.then((_) => resolved = true);

      await tester.tap(find.text('Ada Obi'));
      await tester.pump();
      expect(_busyRow, findsOneWidget);

      gate.complete(false); // (a) the caller's work failed
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));
      expect(_busyRow, findsNothing, reason: 'row returns to normal');
      expect(find.byType(UnifiedUserSearchSheet), findsOneWidget,
          reason: 'no navigation: the sheet is still up');
      expect(resolved, isFalse);

      // The same sheet accepts a new pick afterwards.
      gate = Completer<bool>();
      await tester.tap(find.text('Bola Ade'));
      await tester.pump();
      expect(_busyRow, findsOneWidget);
      gate.complete(true);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));
      expect(find.byType(UnifiedUserSearchSheet), findsNothing);
      expect((await shown)?.userId, 'u-bola');
    });

    testWidgets('a throwing prepare keeps the sheet open', (tester) async {
      await _openSheet(tester,
          prepare: (_) async => throw StateError('network down'));
      await tester.tap(find.text('Ada Obi'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));
      expect(_busyRow, findsNothing);
      expect(find.byType(UnifiedUserSearchSheet), findsOneWidget);
      expect(tester.takeException(), isNull);
      await tester.tap(find.byIcon(Icons.close));
      await tester.pumpAndSettle();
    });

    testWidgets('dismissed while busy: result discarded, resolves null',
        (tester) async {
      final gate = Completer<bool>();
      final shown = await _openSheet(tester, prepare: (_) => gate.future);

      await tester.tap(find.text('Ada Obi'));
      await tester.pump();
      expect(_busyRow, findsOneWidget);

      // (b) the user closes the sheet while the work is in flight.
      await tester.tap(find.byIcon(Icons.close));
      await tester.pumpAndSettle();
      expect(find.byType(UnifiedUserSearchSheet), findsNothing);
      expect(await shown, isNull, reason: 'a dismissed sheet never picks');

      // The late result lands on a sheet that is gone: nothing happens.
      gate.complete(true);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));
      expect(tester.takeException(), isNull);
    });
  });

  testWidgets('without prepareSelection a tap closes at once (old path)',
      (tester) async {
    final shown = await _openSheet(tester);
    await tester.tap(find.text('Bola Ade'));
    await tester.pumpAndSettle();
    expect(find.byType(UnifiedUserSearchSheet), findsNothing);
    expect((await shown)?.userId, 'u-bola');
  });

  group('SelectionGuard', () {
    test('cancel discards a late result; a fresh run works after', () async {
      final guard = SelectionGuard();
      final gate = Completer<bool>();
      final first = guard.run(
        key: 'a',
        work: () => gate.future,
        isAlive: () => true,
        onChanged: () {},
      );
      expect(guard.isBusyFor('a'), isTrue);
      // (c) a second run while busy is discarded without running its work.
      var secondRan = false;
      expect(
        await guard.run(
          key: 'b',
          work: () async {
            secondRan = true;
            return true;
          },
          isAlive: () => true,
          onChanged: () {},
        ),
        SelectionOutcome.discarded,
      );
      expect(secondRan, isFalse);

      guard.cancel(); // (b)/(d) host gone
      gate.complete(true);
      expect(await first, SelectionOutcome.discarded);
      expect(guard.isBusy, isFalse);
    });
  });

  group('UnifiedUserSearchCubit stale responses', () {
    test('an older query answered late never overwrites the newer one',
        () async {
      final slowAb = repo.gates['ab'] = Completer<UnifiedSearchPage>();
      final cubit = UnifiedUserSearchCubit(repo);
      cubit.onQueryChanged('ab');
      await Future<void>.delayed(const Duration(milliseconds: 300));
      expect(cubit.state.status, UnifiedSearchStatus.loading);

      cubit.onQueryChanged('abc'); // answered immediately by the fake
      await Future<void>.delayed(const Duration(milliseconds: 300));
      expect(cubit.state.status, UnifiedSearchStatus.success);
      expect(cubit.state.query, 'abc');

      slowAb.complete(_page([_ada])); // the stale 'ab' lands now
      await Future<void>.delayed(Duration.zero);
      expect(cubit.state.query, 'abc');
      expect(cubit.state.results.length, 2, reason: 'abc results kept');
      await cubit.close();
    });

    test('typing back to the same text does not accept the old response',
        () async {
      final slowAb = repo.gates['ab'] = Completer<UnifiedSearchPage>();
      final cubit = UnifiedUserSearchCubit(repo);
      cubit.onQueryChanged('ab');
      await Future<void>.delayed(const Duration(milliseconds: 300));
      cubit.onQueryChanged('abc');
      await Future<void>.delayed(const Duration(milliseconds: 300));
      // Back to 'ab': a NEW request (still gated) is the one that counts.
      cubit.onQueryChanged('ab');
      await Future<void>.delayed(const Duration(milliseconds: 300));
      expect(cubit.state.status, UnifiedSearchStatus.loading);
      expect(repo.queries.where((q) => q == 'ab').length, 2);

      // Release the gate: both 'ab' requests share it, but only the sequence
      // token of the newest one is current, so exactly one emit happens.
      slowAb.complete(_page([_bola]));
      await Future<void>.delayed(Duration.zero);
      expect(cubit.state.status, UnifiedSearchStatus.success);
      expect(cubit.state.results.map((r) => r.userId), ['u-bola']);
      await cubit.close();
    });
  });
}
