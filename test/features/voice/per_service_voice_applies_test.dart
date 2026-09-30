import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// A per-service voice setting must actually reach the session.
///
/// The per-service screen (Settings → Per-service voice, and the identical
/// screen from the in-call sheet) wrote languageCode/voiceId/promptHint per
/// service, and NOTHING read them back. A session always used the global
/// language and voice from SharedPreferences, so "Crypto speaks Yoruba" was
/// saved, displayed as saved, and silently ignored on every call — the worst
/// shape for a setting, because nothing prompts the user to check.
///
/// Asserted on the source because the alternative is standing up a LiveKit
/// session: the invariant is "the session start consults the per-service
/// store", and that is visible without a room.
void main() {
  late String cubit;

  setUpAll(() {
    cubit = File('lib/src/features/voice_session/cubit/voice_session_cubit.dart')
        .readAsStringSync();
  });

  test('the session start reads the per-service store', () {
    expect(
      cubit.contains('SharedPrefsPerServiceVoiceSettingsStorage'),
      isTrue,
      reason: 'startVoiceSession must consult the per-service settings, not '
          'only the global language/voice.',
    );
  });

  test('it is applied BEFORE the room is created, not after', () {
    final applyAt = cubit.indexOf('_applyPerServiceVoice(serviceName)');
    final startAt = cubit.indexOf('emit(VoiceSessionLoadingCredentials())');
    expect(applyAt, greaterThan(-1), reason: 'the apply call is missing');
    expect(startAt, greaterThan(-1));
    expect(
      applyAt < startAt,
      isTrue,
      reason: 'the voice must be chosen before the agent is started, or the '
          'setting takes effect only on the NEXT call.',
    );
  });

  test('a settings read can never stop a call starting', () {
    // The apply is wrapped so a corrupt or missing preference degrades to the
    // global choice — today's behaviour — rather than failing the session.
    final i = cubit.indexOf('Future<void> _applyPerServiceVoice');
    expect(i, greaterThan(-1));
    final body = cubit.substring(i, i + 1600);
    expect(body.contains('try {'), isTrue);
    expect(body.contains('catch'), isTrue,
        reason: 'a failed settings read must not take down a voice call');
  });

  test('an unconfigured service falls through to the global choice', () {
    final i = cubit.indexOf('Future<void> _applyPerServiceVoice');
    final body = cubit.substring(i, i + 1600);
    expect(body.contains('isConfigured'), isTrue,
        reason: 'only a configured service may override the global voice');
  });

  test('a stale saved language is not applied blindly', () {
    // Applying a language the agent no longer offers starts a session in a
    // voice that cannot speak.
    final i = cubit.indexOf('Future<void> _applyPerServiceVoice');
    final body = cubit.substring(i, i + 1600);
    expect(body.contains('_availableLanguages'), isTrue,
        reason: 'the saved language must be checked against what is available');
  });
}
