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
    final languages = await _service.getSupportedLanguages();

    if (languages.isNotEmpty) {
      emit(VoiceSettingsLoaded(languages: languages));
    } else {
      emit(const VoiceSettingsError('Failed to load languages'));
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
