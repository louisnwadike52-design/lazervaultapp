import 'dart:async';

import 'package:rxdart/rxdart.dart';

import 'package:lazervault/src/features/voice_session/widgets/voice_talk_affordance.dart';
import 'voice_settings_service.dart';

/// The single source of truth for the voice talk mode.
///
/// THE BUG THIS EXISTS TO FIX
/// --------------------------
/// The mode lived in three places that never spoke to each other:
///
///   1. `VoiceCommandSheet._interactionMode` — local `setState`, drives the chip
///      and the talk button's gesture.
///   2. `VoiceSessionCubit._interactionMode` — the ONLY one that actually gates
///      the microphone.
///   3. `VoiceSettingsService` — the persisted per-user/admin value.
///
/// The settings screen wrote (3) and nothing else. So changing the mode in
/// Settings never reached the cubit, the mic kept auto-listening, and the
/// session behaved as `continuous` no matter what the user picked. Changing it
/// in the sheet updated (1) and (2) but left any open Settings screen showing
/// the old value.
///
/// Everything now reads and writes THIS. One value, one stream, so a change made
/// anywhere re-renders everywhere and reaches the flow that gates the mic.
class VoiceTalkModeController {
  VoiceTalkModeController(this._settings);

  final VoiceSettingsService _settings;

  /// Seeded with the default so every listener has a value immediately — a
  /// null-then-value stream would make each consumer invent its own fallback,
  /// which is how the three copies drifted in the first place.
  final _mode = BehaviorSubject<String>.seeded(VoiceTalkMode.continuous);

  /// True once the persisted value has been loaded, so the UI can tell
  /// "genuinely continuous" from "not loaded yet".
  bool _loaded = false;
  bool get isLoaded => _loaded;

  String get mode => _mode.value;
  Stream<String> get modeStream => _mode.stream;

  bool get isPushToTalk => VoiceTalkMode.isPushToTalk(_mode.value);

  /// Load the effective mode (per-user override → admin default → continuous).
  ///
  /// Safe to call repeatedly; the sheet calls it on open and Settings on mount.
  /// A failure leaves the current value rather than snapping the user back to
  /// continuous mid-session.
  Future<void> load() async {
    try {
      final s = await _settings.getTxPinSettings();
      if (s == null) return;
      _emit(s.effectiveInteractionMode);
    } catch (_) {
      // Keep whatever we have. A network blip must not silently change how the
      // microphone behaves.
    } finally {
      _loaded = true;
    }
  }

  /// Change the mode from anywhere — the sheet chip, the settings sheet, or the
  /// general settings screen.
  ///
  /// Broadcasts FIRST, then persists. The user sees the change immediately and
  /// the session starts honouring it; a failed save leaves the choice applied
  /// for this session rather than silently reverting a control they just used.
  Future<void> setMode(String next) async {
    final normalised = _normalise(next);
    if (normalised == _mode.value) return;
    _emit(normalised);
    try {
      await _settings.updateTxPinSettings(
        requirePin: null,
        thresholdKobo: null,
        interactionMode: normalised,
      );
    } catch (_) {
      // Applied locally; the next load() will re-read the server's value.
    }
  }

  /// Apply a mode WITHOUT persisting.
  ///
  /// For values that came from the server already — re-saving them would write
  /// a per-user override every time a session opened, quietly pinning users to
  /// whatever the admin default happened to be on their first run.
  void applyFromServer(String next) => _emit(_normalise(next));

  void _emit(String next) {
    if (_mode.isClosed || next == _mode.value) return;
    _mode.add(next);
  }

  String _normalise(String raw) {
    final m = raw.trim().toLowerCase();
    return VoiceTalkMode.all.contains(m) ? m : VoiceTalkMode.continuous;
  }

  void dispose() {
    _mode.close();
  }
}
