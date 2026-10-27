import 'dart:io';
import 'package:flutter_test/flutter_test.dart';

/// Every LAZY SINGLETON cubit must be cleared when the user changes.
///
/// A lazy singleton outlives the session that populated it, so anything
/// per-user it holds is shown to the NEXT person who signs in on the device
/// until a refetch happens to land. Reported in production: Chris's family
/// account appeared on Ella's dashboard after she logged in on the same phone.
///
/// The purge had four singletons in it and the container had ten. Nothing
/// connected "register a singleton" to "clear it on a switch", so the gap was
/// invisible — which is what this test exists to change. It reads the two
/// files and fails when they disagree.
String stripComments(String src) {
  final noBlock = src.replaceAll(RegExp(r'/\*.*?\*/', dotAll: true), '');
  return noBlock
      .split('\n')
      .where((l) => !l.trimLeft().startsWith('//'))
      .join('\n');
}

void main() {
  test('every lazy-singleton cubit is purged on a user switch', () {
    final container =
        File('lib/core/services/injection_container.dart').readAsStringSync();
    final purge =
        File('lib/core/services/user_switch_purge.dart').readAsStringSync();

    final registered = RegExp(r'registerLazySingleton<([A-Za-z0-9_]+Cubit)>')
        .allMatches(container)
        .map((m) => m.group(1)!)
        .toSet();

    expect(registered, isNotEmpty,
        reason: 'no lazy-singleton cubits found — has the registration syntax '
            'changed? This test would then be silently passing.');

    // Cubits whose state is NOT per-user. Each needs a reason, because the
    // cheap way to pass this test is to add a name here.
    const notUserScoped = <String, String>{
      // Platform crypto fee config (mode/bps/flat) — the same for everyone,
      // fetched from admin settings, and holds nothing about a user.
      'CryptoConfigCubit': 'platform-wide fee config, identical for all users',
      // Owns a live LiveKit room + mic, torn down by its own lifecycle on
      // logout; clearing it here would fight that teardown.
      'VoiceSessionCubit': 'owns a live session torn down by its own lifecycle',
    };

    final missing = <String>[];
    for (final cubit in registered) {
      if (notUserScoped.containsKey(cubit)) continue;
      if (!purge.contains(cubit)) missing.add(cubit);
    }

    expect(
      missing,
      isEmpty,
      reason: 'These lazy-singleton cubits are never cleared on a user '
          'switch, so the next person to sign in on the device inherits the '
          'previous user\'s data:\n'
          '  ${missing.join('\n  ')}\n\n'
          'Add each to _purgeSessionScopedSingletons in '
          'lib/core/services/user_switch_purge.dart, or — if it genuinely '
          'holds nothing per-user — to notUserScoped in this test WITH a '
          'reason.',
    );
  });

  test('the budget purge drops the emitted LIST, not just the lookup caches',
      () {
    // `clearCategoryCache()` empties the service-category maps and leaves the
    // emitted `BudgetsLoaded` alone. That was harmless while `loadBudgets`
    // opened with an unconditional `BudgetLoading`; it now PAINTS what the
    // cubit holds, so a retained state here is the previous user's budget
    // amounts on the next person's screen until their fetch lands.
    final purge =
        File('lib/core/services/user_switch_purge.dart').readAsStringSync();
    final start = purge.indexOf('isRegistered<BudgetCubit>()');
    expect(start, greaterThan(-1), reason: 'the BudgetCubit purge moved');
    final block = purge.substring(start, start + 900);
    expect(block, contains('.reset()'),
        reason: 'a user switch must reset BudgetCubit, not only clear its '
            'category cache — the Budgets list paints the retained state');
  });

  test('a teardown empties the process-wide account rows', () {
    // AccountSummariesStore is what the money sheets resolve a FUNDING SOURCE
    // from, and it is ALSO the fallback `SessionUserId.current()` reads — the
    // stamp every first-page store is keyed on. Left populated after a
    // teardown it keeps naming the DEPARTING user, so the stamp stops being a
    // defence. `_clearSession` is the chokepoint every teardown goes through.
    final auth =
        File('lib/src/features/authentication/cubit/authentication_cubit.dart')
            .readAsStringSync();
    final start = auth.indexOf('Future<void> _clearSession(');
    expect(start, greaterThan(-1), reason: '_clearSession moved');
    final end = auth.indexOf('\n  // --- Main Auth Methods ---', start);
    final body = auth.substring(start, end > start ? end : auth.length);
    expect(stripComments(body), contains('AccountSummariesStore.clear()'),
        reason: 'every session teardown must empty the account rows');
  });

  test('the purge is actually invoked by both switch paths', () {
    final purge =
        File('lib/core/services/user_switch_purge.dart').readAsStringSync();
    // Two entry points exist for a reason (see the file's own comment): a
    // permanent switch and impersonation. A sweep wired into only one of them
    // would leak on the other.
    final calls = '_purgeSessionScopedSingletons()'.allMatches(purge).length;
    expect(calls, greaterThanOrEqualTo(3),
        reason: 'expected the definition plus a call from BOTH '
            'purgeUserScopedCaches and purgeStaleUserCache');
  });
}

extension on String {
  Iterable<Match> allMatches(String input) =>
      RegExp(RegExp.escape(this)).allMatches(input);
}
