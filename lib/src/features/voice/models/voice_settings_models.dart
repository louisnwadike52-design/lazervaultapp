/// Voice language model from backend
class VoiceLanguage {
  final int id;
  final String code;
  final String name;
  final String nativeName;
  final String? flagEmoji;
  final String ttsProvider;
  final bool supportsCustomVoice;
  final bool supportsVoiceCloning;
  final String? cloningProvider;
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
    this.supportsVoiceCloning = false,
    this.cloningProvider,
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
      supportsVoiceCloning: json['supports_voice_cloning'] as bool? ?? false,
      cloningProvider: json['cloning_provider'] as String?,
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
      'supports_voice_cloning': supportsVoiceCloning,
      'cloning_provider': cloningProvider,
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

/// Custom voice cloning status (from voice-agent-gateway)
class CustomVoiceStatus {
  final bool hasCustomVoice;
  final String? customVoiceId;
  final String? customVoiceProvider;
  final String customVoiceStatus; // none/pending/ready/failed/disabled
  final int? customVoiceCreatedAt;
  final String? customVoiceError;
  final bool enabled;

  CustomVoiceStatus({
    required this.hasCustomVoice,
    this.customVoiceId,
    this.customVoiceProvider,
    required this.customVoiceStatus,
    this.customVoiceCreatedAt,
    this.customVoiceError,
    required this.enabled,
  });

  factory CustomVoiceStatus.fromJson(Map<String, dynamic> json) {
    return CustomVoiceStatus(
      hasCustomVoice: json['has_custom_voice'] as bool? ?? false,
      customVoiceId: json['custom_voice_id'] as String?,
      customVoiceProvider: json['custom_voice_provider'] as String?,
      customVoiceStatus: json['custom_voice_status'] as String? ?? 'none',
      customVoiceCreatedAt: json['custom_voice_created_at'] as int?,
      customVoiceError: json['custom_voice_error'] as String?,
      enabled: json['enabled'] as bool? ?? false,
    );
  }

  bool get isReady => customVoiceStatus == 'ready';
  bool get isPending => customVoiceStatus == 'pending';
  bool get isFailed => customVoiceStatus == 'failed';
  bool get isDisabled => customVoiceStatus == 'disabled';
  bool get isNone => customVoiceStatus == 'none';
}

