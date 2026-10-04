import 'package:flutter_test/flutter_test.dart';
import 'dart:io';

// Impersonation is a USER SWITCH, and the app caches per-user state that must
// not cross one: SWR holds the previous person's profile, accounts, tier,
// limits and balances, and AccountManager holds their active account id.
//
// purgeStaleUserCache exists for exactly this and is called on the login
// switch paths — but impersonation called it in NEITHER direction. So an admin
// entering impersonation saw their OWN cached figures while authenticated as
// the target (defeating the point of the feature), and on the way out the
// target's figures persisted into the admin's own session.
//
// It must be the CACHE-ONLY purge: purgeStaleUserCache also deletes the
// admin's remembered login and biometric session, which they need intact to
// come back to. Clearing those on the way into a 15-minute session would log
// the admin out of their own identity.
void main() {
  String codeOf(String path) {
    final raw = File(path).readAsStringSync();
    return raw
        .split('\n')
        .where((l) => !l.trimLeft().startsWith('//'))
        .join('\n');
  }

  const servicePath =
      'lib/src/features/impersonation/data/impersonation_service.dart';
  const purgePath = 'lib/core/services/user_switch_purge.dart';

  group('impersonation purges per-user caches', () {
    test('both directions call the cache purge', () {
      final code = codeOf(servicePath);
      final calls = RegExp(r'await purgeUserScopedCaches\(\);')
          .allMatches(code)
          .length;
      expect(calls, 2,
          reason: 'expected a purge on BOTH enter and exit; found $calls. '
              'Entering shows the admin their own cached balances as the '
              'target; exiting leaves the target\'s balances in the admin\'s '
              'session.');
    });

    test('it does NOT use the credential-clearing purge', () {
      // purgeStaleUserCache deletes stored_email / user_passcode /
      // login_method and the biometric session. Using it here would log the
      // admin out of their own remembered login mid-impersonation.
      expect(codeOf(servicePath), isNot(contains('purgeStaleUserCache(')),
          reason: 'impersonation is TEMPORARY — the operator\'s own '
              'credentials must survive it');
    });

    test('the cache purge leaves credentials alone', () {
      final purge = codeOf(purgePath);
      final start = purge.indexOf('Future<void> purgeUserScopedCaches() async {');
      expect(start, greaterThan(-1), reason: 'purgeUserScopedCaches is missing');
      final end = purge.indexOf('Future<void> purgeStaleUserCache(', start);
      final body = purge.substring(start, end > start ? end : purge.length);

      for (final forbidden in [
        'kPerUserStorageKeys',
        'clearBiometricSession',
        'deleteIdentityNumbers',
        'storage.delete',
      ]) {
        expect(body, isNot(contains(forbidden)),
            reason: 'purgeUserScopedCaches must not touch credentials '
                '($forbidden) — that is purgeStaleUserCache\'s job');
      }
      // And it must actually clear the caches that matter.
      for (final required in [
        'SWRCacheManager',
        'invalidateAll',
        'AccountManager',
        'clearActiveAccount',
      ]) {
        expect(body, contains(required),
            reason: 'purgeUserScopedCaches must clear $required');
      }
    });

    test('the comment strip actually strips (self-check)', () {
      const commented = '// await purgeUserScopedCaches();\n  final x = 1;\n';
      final stripped = commented
          .split('\n')
          .where((l) => !l.trimLeft().startsWith('//'))
          .join('\n');
      expect(stripped, isNot(contains('purgeUserScopedCaches')));
      expect(stripped, contains('final x = 1;'));
    });
  });
}
