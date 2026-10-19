import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/settings/presentation/view/settings_search_vocabulary.dart';

/// THE SAME TWO-STAGE DRIFT, IN FOUR MORE SECTIONS.
///
/// Settings search filters in two stages: `_SectionSpec.matches` decides
/// whether a SECTION renders at all, and only then does `_filterableColumn`
/// filter the tiles inside it. A tile can therefore declare perfectly good
/// keywords and still be unreachable, because its section's hand-written
/// keyword list was never told about it.
///
/// Customize was fixed earlier (see settings_search_finds_customization_test).
/// Auditing the remaining nine sections the same way found **26 more tokens**
/// that no query could reach, measured 2026-10-19:
///
///   Security                — anomaly, freeze, protection, inactivity, lock
///   Notifications & Display — the WHOLE escrow-notice tile (escrow,
///                             liability, middleman, payment channel, terms,
///                             rules, notice) and message-sound volume
///                             (volume, loud, quiet)
///   Voice & Chat Assistant  — prompt, hint
///   Group Funds             — first, visit, dont/don't show again
///
/// Each list is now hoisted into [SettingsSearchVocabulary] and spread into
/// its section, so one edit adds a term in both places. These assertions run
/// against the REAL lists the screen uses.
void main() {
  /// Mirrors `_SectionSpec.matches`, which is passed
  /// `[title, subtitle, ...keywords]`.
  bool finds(String title, List<String> keywords, String query) =>
      settingsQueryMatches(query, [title, '', ...keywords]);

  group('Security', () {
    bool security(String q) =>
        finds('Security', SettingsSearchVocabulary.security, q);

    test('fraud detection is reachable by what it actually does', () {
      // "freeze" and "anomaly" are the words in the tile's own subtitle
      // ("pause unusually large transfers ... for review").
      for (final q in ['fraud', 'anomaly', 'freeze', 'protection', 'risk']) {
        expect(security(q), isTrue, reason: '"$q" must find Fraud detection');
      }
    });

    test('auto-logout is reachable by idle, inactivity and session', () {
      for (final q in ['auto logout', 'idle', 'inactivity', 'session', 'timeout']) {
        expect(security(q), isTrue, reason: '"$q" must find Auto-logout');
      }
    });

    test('social and biometric sign-in are reachable', () {
      for (final q in [
        'google', 'apple', 'sign in with google', 'biometric',
        'fingerprint', 'face id', 'voice login',
      ]) {
        expect(security(q), isTrue, reason: '"$q" must find the login tile');
      }
    });

    test('two-factor is reachable by every name it goes by', () {
      for (final q in ['2fa', 'mfa', 'otp', 'authenticator', 'totp']) {
        expect(security(q), isTrue, reason: '"$q" must find 2FA');
      }
    });
  });

  group('Notifications & Display', () {
    bool notif(String q) => finds(
        'Notifications & Display', SettingsSearchVocabulary.notifications, q);

    test('the escrow "how it works" notice toggle is reachable', () {
      // This whole tile was unreachable: NONE of its keywords were in the
      // section list, so the section was filtered out before it was reached.
      for (final q in [
        'escrow', 'escrow notice', 'liability', 'middleman',
        'payment channel', 'show again',
      ]) {
        expect(notif(q), isTrue, reason: '"$q" must find the escrow notice');
      }
    });

    test('message sound volume is reachable by loudness words', () {
      for (final q in ['volume', 'loud', 'quiet', 'sound']) {
        expect(notif(q), isTrue, reason: '"$q" must find message sound volume');
      }
    });
  });

  group('Voice & Chat Assistant', () {
    bool voice(String q) =>
        finds('Voice & Chat Assistant', SettingsSearchVocabulary.voiceAssistant, q);

    test('prompt hints are reachable', () {
      for (final q in ['prompt', 'hint', 'prompt hint']) {
        expect(voice(q), isTrue, reason: '"$q" must reach per-service voice');
      }
    });

    test('a per-service voice tile is reachable by its own service name', () {
      // These tiles build keywords dynamically from s.label/s.slug, so the
      // section cannot spread the tile's list — the names are mirrored in
      // perServiceServiceNames instead. Without that, searching "insurance"
      // or "payroll" was filtered out at stage one.
      for (final q in [
        'insurance', 'payroll', 'lazerspray', 'crypto', 'investments',
        'withdrawals', 'gift cards', 'spending insights', 'lifestyle',
      ]) {
        expect(voice(q), isTrue,
            reason: '"$q" must reach its per-service voice tile');
      }
    });

    test('the PIN controls stay reachable', () {
      for (final q in ['skip pin', 'voice pin', 'ask for my pin']) {
        expect(voice(q), isTrue, reason: '"$q" must find the voice PIN controls');
      }
    });
  });

  group('Group Funds', () {
    bool group(String q) =>
        finds('Group Funds', SettingsSearchVocabulary.groupFunds, q);

    test('the first-visit terms reset is reachable', () {
      for (final q in [
        'first visit', 'show terms again', 'reset terms',
        "don't show again", 'dont show again',
      ]) {
        expect(group(q), isTrue, reason: '"$q" must find the terms reset');
      }
    });
  });

  group('the matching rule itself', () {
    test('a query no section claims still finds nothing', () {
      // The guard must not pass by making everything match everything.
      expect(
        finds('Security', SettingsSearchVocabulary.security, 'escrow liability'),
        isFalse,
        reason: 'Security must not answer to another section\'s tile',
      );
      expect(
        finds('Group Funds', SettingsSearchVocabulary.groupFunds, 'fingerprint'),
        isFalse,
      );
    });

    test('every tile list is a subset of the section that renders it', () {
      // The structural invariant behind all of the above: composing the
      // section from the tile lists is what keeps the two stages in step.
      void subset(List<String> tile, List<String> section, String label) {
        for (final term in tile) {
          expect(section, contains(term),
              reason: '$label: "$term" is not in its section list');
        }
      }
      subset(SettingsSearchVocabulary.fraudDetection,
          SettingsSearchVocabulary.security, 'fraudDetection');
      subset(SettingsSearchVocabulary.autoLogout,
          SettingsSearchVocabulary.security, 'autoLogout');
      subset(SettingsSearchVocabulary.socialAndBiometricLogin,
          SettingsSearchVocabulary.security, 'socialAndBiometricLogin');
      subset(SettingsSearchVocabulary.twoFactor,
          SettingsSearchVocabulary.security, 'twoFactor');
      subset(SettingsSearchVocabulary.escrowNotice,
          SettingsSearchVocabulary.notifications, 'escrowNotice');
      subset(SettingsSearchVocabulary.chatToneVolume,
          SettingsSearchVocabulary.notifications, 'chatToneVolume');
      subset(SettingsSearchVocabulary.voiceSetup,
          SettingsSearchVocabulary.voiceAssistant, 'voiceSetup');
      subset(SettingsSearchVocabulary.perServiceVoice,
          SettingsSearchVocabulary.voiceAssistant, 'perServiceVoice');
      subset(SettingsSearchVocabulary.perServiceServiceNames,
          SettingsSearchVocabulary.voiceAssistant, 'perServiceServiceNames');
      subset(SettingsSearchVocabulary.groupFundsTerms,
          SettingsSearchVocabulary.groupFunds, 'groupFundsTerms');
    });
  });
}
