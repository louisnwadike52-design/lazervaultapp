import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';

/// App-wide single-instance player for chat voice notes.
///
/// Why a singleton: a chat voice-note bubble lives inside a scrolling list, and
/// the list DISPOSES off-screen widgets. When each bubble owned its own
/// [AudioPlayer], scrolling the playing note off-screen disposed it and the
/// audio stopped. By keeping ONE player here — outside any widget's lifecycle —
/// playback continues while the user scrolls. The bubbles only observe this
/// player (via the value notifiers below) and drive it (play/pause). Playback
/// stops only when: the user taps the same note's pause, another note is played,
/// or the chat page/tab is left (callers invoke [stop]).
class ChatVoiceNotePlayer {
  ChatVoiceNotePlayer._();
  static final ChatVoiceNotePlayer instance = ChatVoiceNotePlayer._();

  final AudioPlayer _player = AudioPlayer();

  /// Stable id of the note currently loaded/playing (its remote URL or local
  /// path). Null when nothing is loaded. Bubbles compare their own id to this.
  final ValueNotifier<String?> currentId = ValueNotifier<String?>(null);
  final ValueNotifier<bool> playing = ValueNotifier<bool>(false);
  final ValueNotifier<Duration> position = ValueNotifier<Duration>(Duration.zero);
  final ValueNotifier<Duration> duration = ValueNotifier<Duration>(Duration.zero);

  /// Id whose last load failed (unplayable URL / missing file) — the bubble for
  /// this id renders the error affordance.
  final ValueNotifier<String?> errorId = ValueNotifier<String?>(null);

  String? _loadedId; // the id actually loaded into the player
  bool _wired = false;

  void _ensureWired() {
    if (_wired) return;
    _wired = true;
    _player.positionStream.listen((p) {
      if (currentId.value != null) position.value = p;
    });
    _player.durationStream.listen((d) {
      if (d != null && d > Duration.zero) duration.value = d;
    });
    _player.playerStateStream.listen((s) {
      playing.value = s.playing;
      if (s.processingState == ProcessingState.completed) {
        // Reset to the start and pause so the same note can be replayed; keep
        // it as the current note so its bar shows 0 progress, not blank.
        _player.pause();
        _player.seek(Duration.zero);
        playing.value = false;
        position.value = Duration.zero;
      }
    });
  }

  /// Toggle play/pause for [id]. If [id] is the current note, flips play/pause;
  /// otherwise loads it (from [localPath] preferred, else [mediaUrl]) and plays.
  /// [fallbackDurationMs] seeds the duration label before the stream resolves.
  Future<void> toggle(
    String id, {
    String? localPath,
    String? mediaUrl,
    int? fallbackDurationMs,
  }) async {
    _ensureWired();

    if (currentId.value == id && _loadedId == id) {
      if (_player.playing) {
        await _player.pause();
      } else {
        await _player.play();
      }
      return;
    }

    // Switching to a different note.
    errorId.value = null;
    currentId.value = id;
    _loadedId = null;
    position.value = Duration.zero;
    duration.value = fallbackDurationMs != null
        ? Duration(milliseconds: fallbackDurationMs)
        : Duration.zero;

    try {
      final hasLocal = localPath != null && localPath.isNotEmpty;
      if (hasLocal && File(localPath).existsSync()) {
        await _player.setFilePath(localPath);
      } else if (mediaUrl != null &&
          (mediaUrl.startsWith('http://') || mediaUrl.startsWith('https://'))) {
        await _player.setUrl(mediaUrl);
      } else {
        throw 'no playable source';
      }
      _loadedId = id;
      final d = _player.duration;
      if (d != null && d > Duration.zero) duration.value = d;
      await _player.play();
    } catch (_) {
      _loadedId = null;
      errorId.value = id;
      // Leave currentId so the failed bubble shows its error state.
    }
  }

  /// Stop playback and unbind the current note. Call when leaving the chat
  /// page/tab so audio doesn't keep playing in the background.
  Future<void> stop() async {
    try {
      await _player.stop();
    } catch (_) {}
    _loadedId = null;
    currentId.value = null;
    playing.value = false;
    position.value = Duration.zero;
    errorId.value = null;
  }
}
