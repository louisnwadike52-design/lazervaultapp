import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/services/app_version_compare.dart';

/// THE UPDATE SHEET MUST APPEAR ONLY WHEN THERE IS GENUINELY SOMETHING NEWER.
///
/// Two dimensions can move independently — the version string (1.0.1 → 1.0.2,
/// → 1.1.0) and the build number — and the app must read both correctly. The
/// failure that matters most is the FALSE POSITIVE: prompting someone who is
/// already current is the fastest way to make the feature feel broken, and it
/// is what a user reported on 2026-11-10 ("it keeps telling me to update").
void main() {
  group('semantic ordering', () {
    test('double-digit segments — the plain-string trap', () {
      // "1.0.10".compareTo("1.0.9") is NEGATIVE: '1' sorts before '9'. A
      // string compare says the tenth patch is older than the ninth, so it
      // would never prompt. Any scheme that reaches double digits hits this.
      expect(compareAppVersions('1.0.10', '1.0.9'), greaterThan(0));
      expect(compareAppVersions('1.0.9', '1.0.10'), lessThan(0));
      expect(compareAppVersions('1.10.0', '1.9.0'), greaterThan(0));
      expect(compareAppVersions('2.0.0', '10.0.0'), lessThan(0));
    });

    test('each position is weighed in order', () {
      expect(compareAppVersions('1.0.1', '1.0.2'), lessThan(0));
      expect(compareAppVersions('1.0.1', '1.1.0'), lessThan(0));
      expect(compareAppVersions('1.0.1', '2.0.0'), lessThan(0));
      expect(compareAppVersions('1.1.0', '1.0.9'), greaterThan(0));
    });

    test('a missing segment is zero, not older', () {
      expect(compareAppVersions('1.1', '1.1.0'), 0);
      expect(compareAppVersions('1', '1.0.0'), 0);
      expect(compareAppVersions('1.1', '1.1.1'), lessThan(0));
    });

    test('build metadata on the version is ignored', () {
      // Stores and tooling append these in several shapes.
      expect(compareAppVersions('1.0.1+499', '1.0.1'), 0);
      expect(compareAppVersions('1.0.1 (499)', '1.0.1'), 0);
      expect(compareAppVersions('1.0.1+499', '1.0.2'), lessThan(0));
    });

    test('a pre-release tag never reads as newer than its release', () {
      expect(compareAppVersions('1.0.1-beta', '1.0.1'), 0);
      expect(compareAppVersions('1.0.1-rc2', '1.0.2'), lessThan(0));
    });
  });

  group('isNewerAppVersion — strictly newer, or nothing', () {
    test('equal versions NEVER prompt', () {
      // The false positive that makes the feature feel broken.
      for (final v in ['1.0.1', '1.0.1+499', '2.3.4']) {
        expect(isNewerAppVersion(installed: v, latest: v), isFalse,
            reason: 'nobody should be told to update to what they run');
      }
      expect(isNewerAppVersion(installed: '1.1', latest: '1.1.0'), isFalse);
    });

    test('an installed version AHEAD of latest never prompts', () {
      // Internal testers run ahead of the store routinely.
      expect(isNewerAppVersion(installed: '1.0.2', latest: '1.0.1'), isFalse);
      expect(isNewerAppVersion(installed: '2.0.0', latest: '1.9.9'), isFalse);
    });

    test('a genuinely newer version prompts', () {
      expect(isNewerAppVersion(installed: '1.0.1', latest: '1.0.2'), isTrue);
      expect(isNewerAppVersion(installed: '1.0.9', latest: '1.0.10'), isTrue);
      expect(isNewerAppVersion(installed: '1.0.1', latest: '1.1.0'), isTrue);
    });

    test('unknown or unparseable values never prompt', () {
      // Not knowing is not grounds to interrupt someone.
      for (final pair in [
        ['', '1.0.2'],
        ['1.0.1', ''],
        ['   ', '  '],
        ['abc', '1.0.2'],
        ['1.0.1', 'latest'],
      ]) {
        expect(isNewerAppVersion(installed: pair[0], latest: pair[1]), isFalse,
            reason: 'installed=${pair[0]} latest=${pair[1]}');
      }
    });
  });
}
