part of 'voice_language_voice_sheet.dart';

/// The user's own cloned-voice info for the "Your Voice" row (resolved per
/// language by the caller, since clone availability is a global status that the
/// caller looks up).
class YourVoiceInfo {
  final String name;
  final String? username;
  final String? avatarUrl;
  const YourVoiceInfo({required this.name, this.username, this.avatarUrl});
}

/// The chosen language + voice returned when the user confirms.
class VoiceLangVoiceResult {
  final VoiceLanguage language;
  final VoiceOption voice; // may be the kMyVoiceSentinelId clone sentinel
  const VoiceLangVoiceResult(this.language, this.voice);
}
