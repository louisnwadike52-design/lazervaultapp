import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/services/voice_record_configs.dart';
import 'package:record/record.dart';

/// Why voice notes "did not send" on Android.
///
/// RecordConfig defaults to STEREO, and stereo silently fails to initialise on
/// most Android mics and emulators — AudioRecord returns without an error and the
/// file ends up empty. iOS's AVAudioRecorder is lenient and works anyway, so the
/// symptom was Android-only, log-free, and not reproducible on a simulator.
///
/// Four chat recorders used a bare `RecordConfig(encoder: AudioEncoder.aacLc)`:
/// the general assistant, the per-service chat, the service bottom sheet and the
/// AI chat. The P2P recorder and every voice-biometrics path set numChannels: 1,
/// which is why voice notes worked in a P2P conversation and not in a chat with
/// the assistant.
void main() {
  group('the shared profiles', () {
    test('voice notes are mono', () {
      // The whole bug in one assertion.
      expect(kVoiceNoteRecordConfig.numChannels, 1);
    });

    test('voice notes stay AAC at a transcribable rate', () {
      expect(kVoiceNoteRecordConfig.encoder, AudioEncoder.aacLc);
      expect(kVoiceNoteRecordConfig.sampleRate, 44100);
      expect(kVoiceNoteRecordConfig.bitRate, 128000);
    });

    test('biometrics use uncompressed 16k mono, not the voice-note profile',
        () {
      // AAC is lossy, and its artefacts move a speaker embedding enough to fail a
      // legitimate speaker against their own enrolment.
      expect(kVoiceBiometricRecordConfig.encoder, AudioEncoder.wav);
      expect(kVoiceBiometricRecordConfig.sampleRate, 16000);
      expect(kVoiceBiometricRecordConfig.numChannels, 1);
    });

    test('the two profiles are genuinely different', () {
      expect(kVoiceBiometricRecordConfig.encoder,
          isNot(kVoiceNoteRecordConfig.encoder));
    });
  });

  group('no recorder in the app captures in stereo', () {
    test('every RecordConfig sets numChannels, or uses a shared profile', () {
      // A guard rather than a unit test: the failure mode is an empty audio file
      // on one platform, which no unit test of the recorder itself would catch.
      final bad = <String>[];
      final dir = Directory('lib');
      for (final entity in dir.listSync(recursive: true)) {
        if (entity is! File || !entity.path.endsWith('.dart')) continue;
        final source = entity.readAsStringSync();
        if (!source.contains('RecordConfig(')) continue;

        // The shared profiles themselves are where numChannels is declared.
        if (entity.path.endsWith('voice_record_configs.dart')) continue;

        for (final match
            in RegExp(r'RecordConfig\(([^)]*)\)').allMatches(source)) {
          final body = match.group(1) ?? '';
          if (!body.contains('numChannels')) {
            final line = source.substring(0, match.start).split('\n').length;
            bad.add('${entity.path}:$line');
          }
        }
      }
      expect(
        bad,
        isEmpty,
        reason: 'these record in STEREO, which silently produces an empty file '
            'on most Android mics — use kVoiceNoteRecordConfig or '
            'kVoiceBiometricRecordConfig:\n${bad.join('\n')}',
      );
    });
  });
}
