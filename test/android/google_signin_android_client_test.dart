import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// GOOGLE SIGN-IN ON ANDROID NEEDS AN ANDROID OAUTH CLIENT. IT HAD NONE.
///
/// Reported 2026-11-08: tapping "Continue with Google" on Android showed a
/// spinner and returned to the passcode screen. auth-service logged nothing,
/// which was the clue — the SDK refuses before any request leaves the device,
/// so the only successful SocialLogin in the logs that day came from an iOS
/// device (`device_uuid: ios-…`).
///
/// `android/app/google-services.json` carried exactly one oauth_client, of
/// `client_type: 3` (WEB), and `certificate_hash` was empty. Android resolves
/// the caller by package name + signing-certificate SHA-1 against an
/// `client_type: 1` (ANDROID) client in the same project; with none registered
/// the platform returns a configuration error (ApiException 10,
/// DEVELOPER_ERROR). `serverClientId` alone does not substitute for it.
///
/// Registering the client is a Google Cloud / Firebase console action, and the
/// SHA-1 that matters is the PLAY APP SIGNING certificate's — not the upload
/// certificate's — for anything installed from Play. This test is the guard
/// that the regenerated google-services.json actually came back with it, so
/// the same silent breakage cannot ship twice.
void main() {
  // Google's client_type enum: 1 = ANDROID, 2 = iOS, 3 = WEB.
  const androidClientType = 1;
  const webClientType = 3;

  late Map<String, dynamic> config;

  setUpAll(() {
    final file = File('android/app/google-services.json');
    expect(file.existsSync(), isTrue,
        reason: 'android/app/google-services.json is missing — the Android '
            'build cannot resolve any Google client without it.');
    config = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
  });

  List<Map<String, dynamic>> clientsFor(String packageName) {
    final out = <Map<String, dynamic>>[];
    for (final client in (config['client'] as List).cast<Map<String, dynamic>>()) {
      final info = client['client_info'] as Map<String, dynamic>;
      final android = info['android_client_info'] as Map<String, dynamic>?;
      if (android?['package_name'] == packageName) {
        out.add(client);
      }
    }
    return out;
  }

  test('the app package is present in google-services.json', () {
    expect(clientsFor('com.lazervault.app'), isNotEmpty,
        reason: 'no entry for com.lazervault.app');
  });

  test('an ANDROID oauth client with a certificate SHA-1 is registered', () {
    final androidOauthClients = <Map<String, dynamic>>[];
    for (final client in clientsFor('com.lazervault.app')) {
      for (final oauth
          in (client['oauth_client'] as List? ?? []).cast<Map<String, dynamic>>()) {
        if (oauth.containsKey('android_info')) androidOauthClients.add(oauth);
      }
    }

    expect(
      androidOauthClients,
      isNotEmpty,
      reason: 'google-services.json has NO android_info oauth client for '
          'com.lazervault.app. Native Google Sign-In on Android will fail with '
          'a configuration error before any network call. Fix: in the Firebase '
          'console (or Google Cloud → Credentials) add the SHA-1 fingerprint '
          'of the PLAY APP SIGNING certificate — Play Console → Setup → App '
          'signing — to the Android app, plus the upload certificate SHA-1 for '
          'locally-signed builds, then re-download google-services.json. '
          'A web client (client_type 3) and serverClientId are NOT a '
          'substitute: Android matches on package + certificate.',
    );

    for (final oauth in androidOauthClients) {
      final hash =
          (oauth['android_info'] as Map<String, dynamic>)['certificate_hash'];
      expect(hash, isA<String>(),
          reason: 'an android_info client with no certificate_hash cannot '
              'match any build');
      expect((hash as String).length, 40,
          reason: 'certificate_hash must be a 40-char hex SHA-1 (no colons); '
              'got "$hash"');
      expect(RegExp(r'^[0-9a-fA-F]{40}$').hasMatch(hash), isTrue,
          reason: 'certificate_hash "$hash" is not hex');
    }
  });

  test('a WEB client is still present for serverClientId', () {
    // auth-service verifies the ID token's audience against
    // GOOGLE_OAUTH_AUDIENCES, which is the web client. Losing it while fixing
    // the Android client would move the breakage rather than fix it.
    final webClients = <Map<String, dynamic>>[];
    for (final client in clientsFor('com.lazervault.app')) {
      for (final oauth
          in (client['oauth_client'] as List? ?? []).cast<Map<String, dynamic>>()) {
        if (oauth['client_type'] == webClientType &&
            !oauth.containsKey('android_info')) {
          webClients.add(oauth);
        }
      }
    }
    expect(webClients, isNotEmpty,
        reason: 'no web oauth client — serverClientId has nothing to point at '
            'and the ID token audience will not match GOOGLE_OAUTH_AUDIENCES');
  });

  test('client_type constants are the ones this file assumes', () {
    // Documented so a future reader does not have to rediscover the mapping.
    // The android assertion above keys on the presence of `android_info`
    // rather than on client_type, because that is the field Google actually
    // populates with the certificate hash.
    expect(androidClientType, 1, reason: 'ANDROID');
    expect(webClientType, 3, reason: 'WEB');
  });
}
