import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'haptics_service.dart';

/// Sound + haptic feedback preferences for P2P chat, iMessage-style.
///
/// Two levels, per the product spec:
///   * **Global** — a default that applies to every conversation (edited from
///     the general Settings page).
///   * **Per-chat override** — an optional override for a single conversation
///     (edited from that peer's profile sheet in the chat). When unset, the
///     conversation inherits the global value.
///
/// The effective value is `perChatOverride ?? global`. Reads are synchronous
/// off an in-memory cache (hydrated once by [init] at startup) so the send path
/// can fire the click/haptic without awaiting; writes persist to
/// [SharedPreferences] and update the cache immediately.
class ChatSoundSettings {
  ChatSoundSettings._();
  static final ChatSoundSettings instance = ChatSoundSettings._();

  static const String _kGlobalSound = 'p2p_sound_global';
  static const String _kGlobalVibrate = 'p2p_vibrate_global';
  static const String _kGlobalVolume = 'p2p_sound_volume_global';
  static const String _perChatSoundPrefix = 'p2p_sound_chat_';
  static const String _perChatVibratePrefix = 'p2p_vibrate_chat_';

  /// Default message-sound loudness — deliberately gentle (55%), not full blast,
  /// so the send/receive tones are soft by default. User-tunable in Settings.
  static const double _kDefaultVolume = 0.55;

  bool _globalSound = true;
  bool _globalVibrate = true;
  double _globalVolume = _kDefaultVolume;
  final Map<String, bool> _chatSound = {};
  final Map<String, bool> _chatVibrate = {};
  bool _ready = false;

  /// Hydrate the cache from disk. Safe to call more than once (no-ops after the
  /// first). Call during app bootstrap (after `SharedPreferences` is usable).
  Future<void> init() async {
    if (_ready) return;
    try {
      final prefs = await SharedPreferences.getInstance();
      _globalSound = prefs.getBool(_kGlobalSound) ?? true;
      _globalVibrate = prefs.getBool(_kGlobalVibrate) ?? true;
      _globalVolume =
          (prefs.getDouble(_kGlobalVolume) ?? _kDefaultVolume).clamp(0.0, 1.0);
      for (final key in prefs.getKeys()) {
        if (key.startsWith(_perChatSoundPrefix)) {
          final cid = key.substring(_perChatSoundPrefix.length);
          final v = prefs.getBool(key);
          if (v != null) _chatSound[cid] = v;
        } else if (key.startsWith(_perChatVibratePrefix)) {
          final cid = key.substring(_perChatVibratePrefix.length);
          final v = prefs.getBool(key);
          if (v != null) _chatVibrate[cid] = v;
        }
      }
    } catch (_) {
      // Fall back to the safe defaults (both on) if prefs are unavailable.
    }
    _ready = true;
  }

  // ---- Global -----------------------------------------------------------
  bool get globalSound => _globalSound;
  bool get globalVibrate => _globalVibrate;

  Future<void> setGlobalSound(bool enabled) async {
    _globalSound = enabled;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kGlobalSound, enabled);
  }

  Future<void> setGlobalVibrate(bool enabled) async {
    _globalVibrate = enabled;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kGlobalVibrate, enabled);
  }

  /// Message-sound loudness, 0.0 (silent) → 1.0 (full). Applied to every tone.
  double get globalVolume => _globalVolume;

  Future<void> setGlobalVolume(double volume) async {
    _globalVolume = volume.clamp(0.0, 1.0);
    // Apply immediately so a live player reflects the change on the next tone.
    try {
      await _player?.setVolume(_globalVolume);
    } catch (_) {}
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_kGlobalVolume, _globalVolume);
  }

  /// Live (non-persisting) volume update for the drag path. Updates the cached
  /// value + any live player so the slider feels responsive, but does NOT touch
  /// SharedPreferences — a `Slider.onChanged` fires every frame, and awaiting a
  /// disk write per tick is wasteful. Commit with [setGlobalVolume] on
  /// `onChangeEnd`.
  void setGlobalVolumeLive(double volume) {
    _globalVolume = volume.clamp(0.0, 1.0);
    try {
      _player?.setVolume(_globalVolume);
    } catch (_) {}
  }

  // ---- Per-chat overrides ----------------------------------------------
  /// The explicit per-chat override, or null when the chat inherits the global.
  bool? soundOverrideFor(String conversationId) => _chatSound[conversationId];
  bool? vibrateOverrideFor(String conversationId) =>
      _chatVibrate[conversationId];

  /// Effective (override-or-global) values used by the send path.
  bool soundEnabledFor(String? conversationId) {
    if (conversationId != null && _chatSound.containsKey(conversationId)) {
      return _chatSound[conversationId]!;
    }
    return _globalSound;
  }

  bool vibrateEnabledFor(String? conversationId) {
    if (conversationId != null && _chatVibrate.containsKey(conversationId)) {
      return _chatVibrate[conversationId]!;
    }
    return _globalVibrate;
  }

  /// Set (or clear, when [enabled] is null) a per-chat sound override.
  Future<void> setChatSound(String conversationId, bool? enabled) async {
    final prefs = await SharedPreferences.getInstance();
    final key = '$_perChatSoundPrefix$conversationId';
    if (enabled == null) {
      _chatSound.remove(conversationId);
      await prefs.remove(key);
    } else {
      _chatSound[conversationId] = enabled;
      await prefs.setBool(key, enabled);
    }
  }

  Future<void> setChatVibrate(String conversationId, bool? enabled) async {
    final prefs = await SharedPreferences.getInstance();
    final key = '$_perChatVibratePrefix$conversationId';
    if (enabled == null) {
      _chatVibrate.remove(conversationId);
      await prefs.remove(key);
    } else {
      _chatVibrate[conversationId] = enabled;
      await prefs.setBool(key, enabled);
    }
  }

  // ---- Feedback --------------------------------------------------------
  // iMessage-style tones. `SystemSound.play(SystemSoundType.click)` was
  // effectively silent on most Android devices (it needs system touch-sounds
  // enabled and is inaudible), so message feedback "didn't work". We now play a
  // short bundled asset via just_audio — the same reliable path SprayMe uses —
  // with a distinct tone for sent vs received messages.
  //
  // Sent: a soft, airy RISING whoosh (`message_sent.mp3`) that reads as
  // "message flying away", like the standard iMessage send tone — replacing the
  // repurposed SprayMe gift `swoosh.mp3`, which sounded like a flat "dash".
  static const String _sendSound = 'assets/sounds/chat/message_sent.mp3';
  static const String _receiveSound = 'assets/sounds/sprayme/pop.mp3';

  AudioPlayer? _player;
  AudioPlayer get _audio {
    return _player ??= AudioPlayer();
  }

  Future<void> _playAsset(String path) async {
    try {
      await _audio.setAsset(path);
      // Honour the user's tunable loudness (default gentle) so the tone is never
      // a full-blast "scary" blast.
      await _audio.setVolume(_globalVolume);
      await _audio.seek(Duration.zero);
      await _audio.play();
    } catch (_) {
      // Best-effort; never throw on the message path.
    }
  }

  /// Fire the OUTGOING-message feedback for [conversationId] per the effective
  /// settings: an outgoing whoosh and/or a haptic tap. Applies to messages the
  /// user SENDS. Best-effort, never throws.
  void playSendFeedback(String? conversationId) {
    if (soundEnabledFor(conversationId)) {
      _playAsset(_sendSound);
    }
    if (vibrateEnabledFor(conversationId) && Haptics.enabled) {
      try {
        HapticFeedback.mediumImpact();
      } catch (_) {}
    }
  }

  /// Fire the INCOMING-message feedback for [conversationId] per the effective
  /// settings: an incoming pop and/or a haptic tap. Applies to messages the
  /// user RECEIVES. Best-effort, never throws.
  void playReceiveFeedback(String? conversationId) {
    if (soundEnabledFor(conversationId)) {
      _playAsset(_receiveSound);
    }
    if (vibrateEnabledFor(conversationId) && Haptics.enabled) {
      try {
        HapticFeedback.mediumImpact();
      } catch (_) {}
    }
  }
}
