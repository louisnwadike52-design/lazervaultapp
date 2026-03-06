part of 'voice_settings_cubit.dart';

/// Extension on VoiceSettingsState for convenience methods
extension VoiceSettingsStateX on VoiceSettingsState {
  VoiceLanguage? get selectedLanguage {
    return maybeWhen(
      loaded: (languages, selectedLanguageCode, selectedVoiceId) {
        return languages
            .where((l) => l.code == selectedLanguageCode)
            .firstOrNull;
      },
      orElse: () => null,
    );
  }

  T? maybeWhen<T>({
    required T Function() orElse,
    T Function(VoiceSettingsLoaded)? loaded,
  }) {
    if (this is VoiceSettingsLoaded && loaded != null) {
      return loaded(this as VoiceSettingsLoaded);
    }
    return orElse();
  }
}
