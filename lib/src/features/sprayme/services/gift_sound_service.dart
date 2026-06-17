import 'package:just_audio/just_audio.dart';
import 'package:flutter/services.dart';

class GiftSoundService {
  static final GiftSoundService _instance = GiftSoundService._internal();
  factory GiftSoundService() => _instance;
  GiftSoundService._internal();

  AudioPlayer? _player;
  bool _enabled = true;
  bool _disposed = false;

  AudioPlayer get _audioPlayer {
    if (_player == null || _disposed) {
      _player = AudioPlayer();
      _disposed = false;
    }
    return _player!;
  }

  static const _basePath = 'assets/sounds/sprayme';

  static const _giftSounds = {
    'basic': '$_basePath/pop.mp3',
    'premium': '$_basePath/chime.mp3',
    'luxury': '$_basePath/swoosh.mp3',
    'legendary': '$_basePath/fanfare.mp3',
  };

  static const _likeSound = '$_basePath/bubble_pop.mp3';
  static const _spraySound = '$_basePath/cash_register.mp3';

  static const _giftHaptics = {
    'basic': HapticFeedback.lightImpact,
    'premium': HapticFeedback.mediumImpact,
    'luxury': HapticFeedback.heavyImpact,
    'legendary': HapticFeedback.heavyImpact,
  };

  void setEnabled(bool enabled) {
    _enabled = enabled;
    if (!enabled) {
      _player?.stop();
    }
  }

  Future<void> playGiftSound(String category) async {
    if (!_enabled || category == 'free') return;

    final assetPath = _giftSounds[category];
    if (assetPath == null) return;

    try {
      await _audioPlayer.setAsset(assetPath);
      await _audioPlayer.seek(Duration.zero);
      await _audioPlayer.play();
    } catch (_) {
      try {
        final haptic = _giftHaptics[category];
        if (haptic != null) {
          await haptic();
        }
      } catch (_) {}
    }
  }

  Future<void> playLikeSound() async {
    if (!_enabled) return;

    try {
      await _audioPlayer.setAsset(_likeSound);
      await _audioPlayer.seek(Duration.zero);
      await _audioPlayer.play();
    } catch (_) {
      try {
        await HapticFeedback.lightImpact();
      } catch (_) {}
    }
  }

  Future<void> playSpraySound() async {
    if (!_enabled) return;

    try {
      await _audioPlayer.setAsset(_spraySound);
      await _audioPlayer.seek(Duration.zero);
      await _audioPlayer.play();
    } catch (_) {
      try {
        await HapticFeedback.mediumImpact();
      } catch (_) {}
    }
  }

  /// Stops currently playing audio without disposing the player.
  void stopAll() {
    _player?.stop();
  }

  /// Releases the audio player resources. Safe to call multiple times;
  /// a new player is lazily recreated on the next play call.
  void dispose() {
    _player?.stop();
    _player?.dispose();
    _player = null;
    _disposed = true;
  }
}
