import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/voice_session/services/voice_note_capture.dart';

/// Recording a gesture-bounded turn as a clip, the way a chat voice note is.
///
/// In hold / tap / double-tap the user has already said where their turn starts
/// and ends, so there is nothing for server VAD to decide — and the chat
/// voice-note pipeline transcribes the same audio noticeably better than a
/// gesture-bounded LiveKit window.
///
/// The recorder itself needs a real microphone, so what is asserted here is the
/// contract around it: the guards that stop a useless clip reaching the server,
/// and the fallback rule that means a turn is never lost to a transcription
/// problem.
void main() {
  group('the guards', () {
    test('a mis-tap is shorter than the minimum', () {
      // Opening and closing the mic in the same instant must not become a request.
      expect(VoiceNoteCapture.minDuration, const Duration(milliseconds: 500));
    });

    test('an empty file is caught by the size floor', () {
      // The case duration cannot catch: the mic reports success and writes
      // nothing. A valid half-second of AAC is comfortably over 1KB.
      expect(VoiceNoteCapture.minBytes, 1024);
    });
  });

  group('the clip', () {
    test('carries what the caller needs to judge it', () async {
      final tmp = await Directory.systemTemp.createTemp('clip_test');
      final file = File('${tmp.path}/turn.m4a')
        ..writeAsBytesSync(List.filled(2048, 1));
      final clip = VoiceNoteClip(
        file: file,
        duration: const Duration(seconds: 2),
        bytes: 2048,
      );
      expect(clip.bytes, greaterThan(VoiceNoteCapture.minBytes));
      expect(clip.duration, greaterThan(VoiceNoteCapture.minDuration));
      expect(await clip.file.exists(), isTrue);
      await tmp.delete(recursive: true);
    });
  });

  group('the cubit contract', () {
    late String source;

    setUpAll(() {
      final file = File(
        'lib/src/features/voice_session/cubit/voice_session_cubit.dart',
      );
      expect(file.existsSync(), isTrue);
      source = file.readAsStringSync();
    });

    test('the path is OFF unless the server turns it on', () {
      // It adds a third microphone consumer beside LiveKit and speech_to_text
      // with no explicit AVAudioSession category anywhere in the app, so it must
      // not become the default before it is verified on a device.
      expect(source, contains('bool _voiceNoteCapture = false;'));
      expect(source, contains("data['voiceNoteCapture'] == true"));
    });

    test('on-device STT keeps running alongside it', () {
      // It draws the live captions, so the user still sees words appear. Its
      // dispatch is already disabled in a gesture mode, so the two do not race to
      // submit the turn.
      final body = _methodBody(source, 'Future<void> pttBegin() async {');
      expect(body, isNotEmpty, reason: 'pttBegin not found in the cubit');
      expect(body, contains('_noteCapture!.start()'));
      expect(body, contains('await startLocalListening();'));
    });

    test('an empty or failed transcription falls back, never discards the turn',
        () {
      expect(source,
          contains('if (transcript != null && transcript.trim().isNotEmpty)'),
          reason: 'preferring the clip unconditionally would lose a turn the '
              'on-device recognizer did hear');
      expect(source, contains('_dispatchUserTurn(onDevice);'));
    });

    test('the network call is bounded', () {
      // A slow transcription must not leave the user staring at a turn that never
      // submits, when the fallback is immediate and local.
      expect(source, contains('.timeout(const Duration(seconds: 12))'));
    });

    test('every failure returns null rather than throwing into the turn', () {
      final body = _methodBody(source, 'Future<String?> _transcribeTurnClip(');
      expect(body, isNotEmpty, reason: '_transcribeTurnClip not found');
      expect(body, contains('} catch (e) {'));
      expect(body, contains('return null;'));
      // And the clip is deleted either way — it has done its job.
      expect(body, contains('} finally {'));
    });

    test('the recorder is released on teardown', () {
      // A recorder left open holds the audio session, which is what makes the
      // NEXT session's microphone dead.
      expect(source, contains('unawaited(capture.dispose());'));
    });
  });

  group('the gateway route', () {
    test('is narrow: a transcript and nothing else', () {
      final source = File(
        '../voice-agent-gateway/main.py',
      ).readAsStringSync();
      expect(source, contains('@app.post("/voice/transcribe")'));
      expect(source, contains('return {"text": transcript}'),
          reason:
              'it must not touch the LiveKit session, the reply or the TTS — '
              'so it can fail without taking a conversation down');
      // An empty transcript is a legitimate outcome (held the button, said
      // nothing) and comes back 200 so the app can discard the turn itself.
      expect(source, contains('validate_media('),
          reason: 'size and mime are enforced before Whisper sees the clip');
    });
  });
}

/// The body of a top-level method, from its signature to its closing brace.
///
/// Replaces the fixed-size `substring(start, start + 2000)` these assertions
/// used to take. That window silently stopped covering the end of `pttBegin`
/// the moment a comment was added to it — the call it was checking for was
/// still right there in the source, two lines past the cut. A source assertion
/// that fails because the function grew is a test that punishes explaining
/// yourself, so it reads to the actual closing brace instead.
///
/// Brace counting is adequate here because these are real Dart method bodies
/// whose braces balance; it is not a parser and does not need to be.
String _methodBody(String source, String signature) {
  final start = source.indexOf(signature);
  if (start < 0) return '';
  var depth = 0;
  var seenOpen = false;
  for (var i = start; i < source.length; i++) {
    final c = source[i];
    if (c == '{') {
      depth++;
      seenOpen = true;
    } else if (c == '}') {
      depth--;
      if (seenOpen && depth == 0) return source.substring(start, i + 1);
    }
  }
  return source.substring(start);
}
