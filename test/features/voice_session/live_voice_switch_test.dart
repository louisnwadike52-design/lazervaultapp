import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Switching voice (or adopting a clone) mid-call has to reach the RUNNING
/// agent, not just SharedPreferences. setVoice had seven callers and only three
/// followed up with the notify, so a voice changed from any of the other four —
/// including the fallback picks a language switch forces — persisted and left
/// the agent speaking in the old voice until the session restarted.
void main() {
  late String cubit;
  late String sheet;
  late String screen;

  setUpAll(() {
    cubit =
        File('lib/src/features/voice_session/cubit/voice_session_cubit.dart')
            .readAsStringSync();
    sheet = File(
            'lib/src/features/voice_session/widgets/voice_command_sheet.dart')
        .readAsStringSync();
    screen =
        File('lib/src/features/voice/screens/voice_settings_screen.dart')
            .readAsStringSync();
  });

  test('setVoice applies the choice to a live session itself', () {
    expect(cubit.contains('Future<void> _applyVoiceToLiveSession('), isTrue);
    // The call must be inside setVoice, after the preference writes.
    final setVoiceAt = cubit.indexOf('Future<void> setVoice(String voiceId)');
    final applyCallAt = cubit.indexOf('await _applyVoiceToLiveSession(voiceId);');
    expect(setVoiceAt, greaterThan(-1));
    expect(applyCallAt, greaterThan(setVoiceAt),
        reason: 'setVoice no longer applies the voice to a live session');
  });

  test('the sentinel-vs-preset branch exists in exactly one place', () {
    // Which event a voice needs is a property of the voice, not of the screen
    // that picked it. Copies at each call site are how the four silent callers
    // happened in the first place.
    final branches = RegExp(r'notifyCustomVoiceChanged\(true\)')
        .allMatches(cubit + sheet + screen)
        .length;
    expect(branches, 2,
        reason: 'expected _applyVoiceToLiveSession plus the clone '
            'auto-adoption in adoptClonedVoiceIfReady. Found $branches — a '
            'call site has grown its own copy of the branch again.');
  });

  test('the UI no longer dispatches voice events itself', () {
    for (final entry in {'voice_command_sheet': sheet, 'voice_settings_screen': screen}.entries) {
      expect(entry.value.contains('cubit.notifyVoiceChanged('), isFalse,
          reason: '${entry.key} still dispatches the voice event directly; '
              'setVoice does it, so this double-sends');
    }
  });

  test('an empty voice id sends nothing', () {
    // setVoice('') means "no explicit voice" — the backend re-resolves one for
    // the language. Sending it would override that with nothing.
    expect(
      cubit.contains("if (voiceId.isEmpty || !hasActiveVoiceSession) return;"),
      isTrue,
    );
  });
}
