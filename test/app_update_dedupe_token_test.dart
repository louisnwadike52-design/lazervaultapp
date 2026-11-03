import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/services/app_update_service.dart';

/// The "show the update modal once" check used to key on the BUILD NUMBER
/// alone, starting with `if (latestBuild <= 0) return false;`.
///
/// That is fine on Android, where Play answers with a version code. It is
/// broken on iOS, where the store answer is a VERSION STRING — the iTunes
/// lookup returns "1.0.2" and never a build — and `app_latest_build_ios` is
/// legitimately 0 whenever nothing has been released there yet. It is 0 in
/// production right now, because the app has never shipped on the App Store.
///
/// So on iOS the store could report an available update and the de-dupe would
/// short-circuit to "already seen", and the modal would never appear at all.
/// The store check was live and the prompt was dead.
///
/// These pin the token that fixed it.
AppUpdateInfo _info({int latestBuild = 0, String latestVersion = ''}) =>
    AppUpdateInfo(
      type: AppUpdateType.optional,
      currentBuild: 1,
      latestBuild: latestBuild,
      minBuild: 0,
      latestVersion: latestVersion,
      notes: '',
      storeUrl: '',
      isIOS: true,
    );

void main() {
  group('AppUpdateInfo.dedupeToken', () {
    test('prefers the build number when there is one (Android)', () {
      expect(
          _info(latestBuild: 479, latestVersion: '1.0.1').dedupeToken, 'b479');
    });

    test('falls back to the version string when there is no build (iOS)', () {
      // The case that was broken: no build number, store gave a version.
      expect(_info(latestVersion: '1.0.2').dedupeToken, 'v1.0.2');
    });

    test('is empty when neither is known, so no prompt is de-duped wrongly',
        () {
      expect(_info().dedupeToken, isEmpty);
    });

    test('a build and a version can never collide', () {
      // Unprefixed, build 102 and version "102" would share a key and silently
      // suppress one another.
      expect(_info(latestBuild: 102).dedupeToken,
          isNot(_info(latestVersion: '102').dedupeToken));
    });

    test('version is trimmed, so stray whitespace is not a different version',
        () {
      expect(_info(latestVersion: ' 1.0.2 ').dedupeToken, 'v1.0.2');
    });

    test('distinct iOS versions produce distinct tokens', () {
      // "1.0.10" vs "1.0.9" — the pair a string comparison gets backwards.
      expect(_info(latestVersion: '1.0.10').dedupeToken,
          isNot(_info(latestVersion: '1.0.9').dedupeToken));
    });
  });
}
