import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/voice_settings_models.dart';
import '../services/voice_settings_service.dart';

/// Voice Settings State
abstract class VoiceSettingsState {
  const VoiceSettingsState();
}

class VoiceSettingsInitial extends VoiceSettingsState {
  const VoiceSettingsInitial();
}

class VoiceSettingsLoading extends VoiceSettingsState {
  const VoiceSettingsLoading();
}

class VoiceSettingsLoaded extends VoiceSettingsState {
  final List<VoiceLanguage> languages;
  final String? selectedLanguageCode;
  final String? selectedVoiceId;

  const VoiceSettingsLoaded({
    required this.languages,
    this.selectedLanguageCode,
    this.selectedVoiceId,
  });

  VoiceSettingsLoaded copyWith({
    List<VoiceLanguage>? languages,
    String? selectedLanguageCode,
    String? selectedVoiceId,
  }) {
    return VoiceSettingsLoaded(
      languages: languages ?? this.languages,
      selectedLanguageCode: selectedLanguageCode ?? this.selectedLanguageCode,
      selectedVoiceId: selectedVoiceId ?? this.selectedVoiceId,
    );
  }
}

class VoiceSettingsError extends VoiceSettingsState {
  final String message;
  const VoiceSettingsError(this.message);
}

/// Voice Settings Cubit - Simplified version for basic functionality
class VoiceSettingsCubit extends Cubit<VoiceSettingsState> {
  final VoiceSettingsService _service;

  VoiceSettingsCubit(this._service) : super(const VoiceSettingsInitial()) {
    loadLanguages();
  }

  Future<void> loadLanguages() async {
    emit(const VoiceSettingsLoading());
    try {
      final languages = await _service.getSupportedLanguages();
      // An empty catalogue is a real, successful answer: nothing is configured
      // for this region. It is not a failure, and calling it one sent people
      // to Retry forever against a service that was replying perfectly well.
      // The screen renders its own empty state from an empty list.
      emit(VoiceSettingsLoaded(languages: languages));
    } on VoiceLanguagesUnavailable catch (e) {
      // Already phrased for a person to read, and says which of the two
      // problems it is — expired session versus unreachable service.
      emit(VoiceSettingsError(e.message));
    } catch (_) {
      emit(const VoiceSettingsError(
        'Could not load voice settings. Please try again.',
      ));
    }
  }

  void selectLanguage(String code) {
    final current = state;
    if (current is VoiceSettingsLoaded) {
      emit(current.copyWith(selectedLanguageCode: code));
    }
  }

  void selectVoice(String voiceId) {
    final current = state;
    if (current is VoiceSettingsLoaded) {
      emit(current.copyWith(selectedVoiceId: voiceId));
    }
  }

  void reset() {
    emit(const VoiceSettingsInitial());
  }

  void clearError() {
    if (state is VoiceSettingsError) {
      emit(const VoiceSettingsInitial());
    }
  }
}
