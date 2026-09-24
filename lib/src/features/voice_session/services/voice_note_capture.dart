import 'dart:io';

import 'package:lazervault/core/services/voice_record_configs.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

/// Records one push-to-talk turn as a clip, the way a chat voice note is recorded.
///
/// In hold / tap / double-tap the user has already told us exactly where their turn
/// starts and ends, so there is nothing for server-side voice-activity detection to
/// decide. Capturing the whole turn as a clip and transcribing it in one go is both
/// simpler and better than streaming a gesture-bounded window — the chat voice-note
/// pipeline it reuses produces noticeably cleaner text on the same audio.
///
/// Guards copied from the P2P recorder, because they are the ones that stop a
/// useless clip reaching the server:
///   * the shared MONO profile — stereo silently records an empty file on most
///     Android mics (see voice_record_configs.dart);
///   * a minimum duration, so a mis-tap that opens and closes the mic in the same
///     instant does not become a request;
///   * a minimum file size, which is what actually catches a mic that reported
///     success and produced nothing.
class VoiceNoteCapture {
  VoiceNoteCapture({AudioRecorder? recorder})
      : _recorder = recorder ?? AudioRecorder();

  final AudioRecorder _recorder;

  /// Below this the clip is a mis-tap, not a turn.
  static const Duration minDuration = Duration(milliseconds: 500);

  /// Below this the file is silence or a failed capture. A valid half-second of
  /// AAC is comfortably larger than this.
  static const int minBytes = 1024;

  DateTime? _startedAt;
  String? _path;

  bool get isRecording => _startedAt != null;

  /// Starts recording. Returns false when the mic could not be opened, so the
  /// caller can fall back to on-device transcription rather than believing a turn
  /// is being captured when it is not.
  Future<bool> start() async {
    if (_startedAt != null) return true;
    try {
      if (!await _recorder.hasPermission()) return false;
      final dir = await getTemporaryDirectory();
      final path =
          '${dir.path}/voice_turn_${DateTime.now().millisecondsSinceEpoch}.m4a';
      await _recorder.start(kVoiceNoteRecordConfig, path: path);
      _path = path;
      _startedAt = DateTime.now();
      return true;
    } catch (_) {
      // Never throw into a turn boundary. A failed start means "no clip", and the
      // caller's fallback handles that.
      await _cleanUp();
      return false;
    }
  }

  /// Stops recording and returns the clip, or null when there is nothing usable.
  ///
  /// Null covers every reason a clip should not be sent — too short, too small,
  /// missing, or the recorder failing — because the caller's response to all of
  /// them is the same: use the on-device transcript instead.
  Future<VoiceNoteClip?> stop() async {
    final startedAt = _startedAt;
    final path = _path;
    _startedAt = null;
    _path = null;
    if (startedAt == null || path == null) return null;

    final held = DateTime.now().difference(startedAt);
    try {
      await _recorder.stop();
    } catch (_) {
      // Stop can throw if the session was torn down under us; the file may still
      // be on disk and valid, so fall through and judge it on its contents.
    }

    if (held < minDuration) {
      await _deleteQuietly(path);
      return null;
    }
    final file = File(path);
    if (!await file.exists()) return null;
    final length = await file.length();
    if (length < minBytes) {
      // The case the duration check cannot catch: the mic reported success and
      // wrote nothing.
      await _deleteQuietly(path);
      return null;
    }
    return VoiceNoteClip(file: file, duration: held, bytes: length);
  }

  /// Abandons a recording in progress — a cancelled gesture, a teardown.
  Future<void> discard() async {
    final path = _path;
    _startedAt = null;
    _path = null;
    try {
      await _recorder.stop();
    } catch (_) {/* already stopped */}
    if (path != null) await _deleteQuietly(path);
  }

  Future<void> dispose() async {
    await discard();
    try {
      await _recorder.dispose();
    } catch (_) {/* already disposed */}
  }

  Future<void> _cleanUp() async {
    final path = _path;
    _startedAt = null;
    _path = null;
    if (path != null) await _deleteQuietly(path);
  }

  Future<void> _deleteQuietly(String path) async {
    try {
      final f = File(path);
      if (await f.exists()) await f.delete();
    } catch (_) {
      // A temp file we failed to delete is the OS's problem, not a reason to fail
      // a turn.
    }
  }
}

/// A recorded turn, ready to upload.
class VoiceNoteClip {
  const VoiceNoteClip({
    required this.file,
    required this.duration,
    required this.bytes,
  });

  final File file;
  final Duration duration;
  final int bytes;
}
