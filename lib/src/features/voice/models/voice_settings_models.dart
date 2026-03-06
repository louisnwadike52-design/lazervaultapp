/// Voice language model from backend
class VoiceLanguage {
  final int id;
  final String code;
  final String name;
  final String nativeName;
  final String? flagEmoji;
  final String ttsProvider;
  final bool supportsCustomVoice;
  final bool requiresTranslation;
  final int displayOrder;

  VoiceLanguage({
    required this.id,
    required this.code,
    required this.name,
    required this.nativeName,
    this.flagEmoji,
    required this.ttsProvider,
    required this.supportsCustomVoice,
    required this.requiresTranslation,
    required this.displayOrder,
  });

  factory VoiceLanguage.fromJson(Map<String, dynamic> json) {
    return VoiceLanguage(
      id: json['id'] as int,
      code: json['code'] as String,
      name: json['name'] as String,
      nativeName: json['native_name'] as String? ?? json['name'] as String,
      flagEmoji: json['flag_emoji'] as String?,
      ttsProvider: json['tts_provider'] as String,
      supportsCustomVoice: json['supports_custom_voice'] as bool? ?? false,
      requiresTranslation: json['requires_translation'] as bool? ?? false,
      displayOrder: json['display_order'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'name': name,
      'native_name': nativeName,
      'flag_emoji': flagEmoji,
      'tts_provider': ttsProvider,
      'supports_custom_voice': supportsCustomVoice,
      'requires_translation': requiresTranslation,
      'display_order': displayOrder,
    };
  }
}

/// Voice option for a language
class VoiceOption {
  final int id;
  final String languageCode;
  final String provider;
  final String voiceId;
  final String name;
  final String? gender;
  final String? description;
  final String? previewUrl;
  final bool isCustomCapable;
  final int displayOrder;

  VoiceOption({
    required this.id,
    required this.languageCode,
    required this.provider,
    required this.voiceId,
    required this.name,
    this.gender,
    this.description,
    this.previewUrl,
    required this.isCustomCapable,
    required this.displayOrder,
  });

  factory VoiceOption.fromJson(Map<String, dynamic> json, String languageCode) {
    return VoiceOption(
      id: json['id'] as int,
      languageCode: languageCode,
      provider: json['provider'] as String,
      voiceId: json['voice_id'] as String,
      name: json['name'] as String,
      gender: json['gender'] as String?,
      description: json['description'] as String?,
      previewUrl: json['preview_url'] as String?,
      isCustomCapable: json['is_custom_capable'] as bool? ?? false,
      displayOrder: json['display_order'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'language_code': languageCode,
      'provider': provider,
      'voice_id': voiceId,
      'name': name,
      'gender': gender,
      'description': description,
      'preview_url': previewUrl,
      'is_custom_capable': isCustomCapable,
      'display_order': displayOrder,
    };
  }
}

/// User's voice settings for a language
class UserVoiceSetting {
  final int id;
  final String userId;
  final String languageCode;
  final String voiceProvider;
  final String? voiceId;
  final bool useCustomVoice;
  final String? customVoiceUrl;
  final double voiceTemperature;

  UserVoiceSetting({
    required this.id,
    required this.userId,
    required this.languageCode,
    required this.voiceProvider,
    this.voiceId,
    required this.useCustomVoice,
    this.customVoiceUrl,
    required this.voiceTemperature,
  });

  factory UserVoiceSetting.fromJson(Map<String, dynamic> json) {
    return UserVoiceSetting(
      id: json['id'] as int,
      userId: json['user_id'] as String,
      languageCode: json['language_code'] as String,
      voiceProvider: json['voice_provider'] as String,
      voiceId: json['voice_id'] as String?,
      useCustomVoice: json['use_custom_voice'] as bool? ?? false,
      customVoiceUrl: json['custom_voice_url'] as String?,
      voiceTemperature: (json['voice_temperature'] as num?)?.toDouble() ?? 0.7,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'language_code': languageCode,
      'voice_provider': voiceProvider,
      'voice_id': voiceId,
      'use_custom_voice': useCustomVoice,
      'custom_voice_url': customVoiceUrl,
      'voice_temperature': voiceTemperature,
    };
  }

  UserVoiceSetting copyWith({
    String? voiceProvider,
    String? voiceId,
    bool? useCustomVoice,
    String? customVoiceUrl,
    double? voiceTemperature,
  }) {
    return UserVoiceSetting(
      id: id,
      userId: userId,
      languageCode: languageCode,
      voiceProvider: voiceProvider ?? this.voiceProvider,
      voiceId: voiceId ?? this.voiceId,
      useCustomVoice: useCustomVoice ?? this.useCustomVoice,
      customVoiceUrl: customVoiceUrl ?? this.customVoiceUrl,
      voiceTemperature: voiceTemperature ?? this.voiceTemperature,
    );
  }
}

/// Voice enrollment session
class VoiceEnrollmentSession {
  final String sessionToken;
  final int currentStep;
  final int totalSteps;
  final String status; // pending, in_progress, completed, failed
  final List<String> audioSampleUrls;
  final List<double> qualityScores;
  final DateTime? completedAt;

  VoiceEnrollmentSession({
    required this.sessionToken,
    required this.currentStep,
    required this.totalSteps,
    required this.status,
    required this.audioSampleUrls,
    required this.qualityScores,
    this.completedAt,
  });

  double get progress => totalSteps > 0 ? currentStep / totalSteps : 0;
  bool get isCompleted => status == 'completed';
  double get averageQuality {
    if (qualityScores.isEmpty) return 0;
    return qualityScores.reduce((a, b) => a + b) / qualityScores.length;
  }

  factory VoiceEnrollmentSession.fromJson(Map<String, dynamic> json) {
    return VoiceEnrollmentSession(
      sessionToken: json['session_token'] as String,
      currentStep: json['current_step'] as int,
      totalSteps: json['total_steps'] as int,
      status: json['status'] as String,
      audioSampleUrls: (json['audio_sample_urls'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      qualityScores: (json['quality_scores'] as List<dynamic>?)
              ?.map((e) => (e as num).toDouble())
              .toList() ??
          [],
      completedAt: json['completed_at'] != null
          ? DateTime.parse(json['completed_at'] as String)
          : null,
    );
  }
}

/// Voice authentication result
class VoiceAuthenticationResult {
  final bool success;
  final String? userId;
  final double confidence;
  final String message;

  VoiceAuthenticationResult({
    required this.success,
    this.userId,
    required this.confidence,
    required this.message,
  });

  factory VoiceAuthenticationResult.fromJson(Map<String, dynamic> json) {
    return VoiceAuthenticationResult(
      success: json['success'] as bool,
      userId: json['user_id'] as String?,
      confidence: (json['confidence'] as num).toDouble(),
      message: json['message'] as String,
    );
  }
}

/// Custom voice generation response
class CustomVoiceGenerationResponse {
  final bool success;
  final String? voiceId;
  final String? voiceUrl;
  final int? estimatedEta;
  final String message;

  CustomVoiceGenerationResponse({
    required this.success,
    this.voiceId,
    this.voiceUrl,
    this.estimatedEta,
    required this.message,
  });

  factory CustomVoiceGenerationResponse.fromJson(Map<String, dynamic> json) {
    return CustomVoiceGenerationResponse(
      success: json['success'] as bool,
      voiceId: json['voice_id'] as String?,
      voiceUrl: json['voice_url'] as String?,
      estimatedEta: json['estimated_eta_seconds'] as int?,
      message: json['message'] as String,
    );
  }
}
