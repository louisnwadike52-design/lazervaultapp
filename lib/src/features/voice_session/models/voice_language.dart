/// Voice language and voice option models for the multi-provider voice system.
///
/// [VoiceLanguage] represents a language available for voice sessions.
/// [VoiceOption] represents a selectable TTS voice within a language.
class VoiceLanguage {
  final String code;
  final String name;
  final String nativeName;
  final String flag;
  final bool supportsVoiceCustomization;
  final bool supportsVoiceCloning;
  final String? cloningProvider;
  final List<VoiceOption> availableVoices;
  final String provider; // "elevenlabs", "yarngpt", "openai"
  final String defaultVoice;

  const VoiceLanguage({
    required this.code,
    required this.name,
    required this.nativeName,
    required this.flag,
    required this.supportsVoiceCustomization,
    this.supportsVoiceCloning = false,
    this.cloningProvider,
    this.availableVoices = const [],
    this.provider = 'openai',
    this.defaultVoice = '',
  });

  factory VoiceLanguage.fromJson(Map<String, dynamic> json) {
    return VoiceLanguage(
      code: json['code'] as String? ?? '',
      name: json['name'] as String? ?? '',
      nativeName: json['nativeName'] as String? ?? '',
      flag: json['flag'] as String? ?? '',
      supportsVoiceCustomization:
          json['supportsVoiceCustomization'] as bool? ?? false,
      supportsVoiceCloning:
          json['supportsVoiceCloning'] as bool? ?? false,
      cloningProvider: json['cloningProvider'] as String?,
      availableVoices: (json['availableVoices'] as List<dynamic>?)
              ?.map((v) => VoiceOption.fromJson(v as Map<String, dynamic>))
              .toList() ??
          [],
      provider: json['provider'] as String? ?? 'openai',
      defaultVoice: json['defaultVoice'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'code': code,
        'name': name,
        'nativeName': nativeName,
        'flag': flag,
        'supportsVoiceCustomization': supportsVoiceCustomization,
        'supportsVoiceCloning': supportsVoiceCloning,
        'cloningProvider': cloningProvider,
        'availableVoices': availableVoices.map((v) => v.toJson()).toList(),
        'provider': provider,
        'defaultVoice': defaultVoice,
      };

  /// Get the default voice for this language
  VoiceOption? get defaultVoiceOption {
    if (defaultVoice.isEmpty) {
      return availableVoices.isNotEmpty ? availableVoices.first : null;
    }
    return availableVoices
            .where((v) => v.id == defaultVoice)
            .firstOrNull ??
        (availableVoices.isNotEmpty ? availableVoices.first : null);
  }
}

class VoiceOption {
  final String id;
  final String name;
  final String? previewUrl;
  final String? gender; // "male", "female", "neutral"
  final String? accent; // e.g., "Nigerian", "American", "British"

  const VoiceOption({
    required this.id,
    required this.name,
    this.previewUrl,
    this.gender,
    this.accent,
  });

  factory VoiceOption.fromJson(Map<String, dynamic> json) {
    return VoiceOption(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      previewUrl: json['previewUrl'] as String?,
      gender: json['gender'] as String?,
      accent: json['accent'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'previewUrl': previewUrl,
        'gender': gender,
        'accent': accent,
      };

  /// Get display text with accent info
  String get displayName {
    if (accent != null && accent!.isNotEmpty) {
      return '$name ($accent)';
    }
    return name;
  }

  /// Check if this voice matches the given ID
  bool matchesId(String? voiceId) {
    return voiceId != null && voiceId.isNotEmpty && id == voiceId;
  }
}

/// Hardcoded fallback language list (used when API is unreachable).
/// Matches LANGUAGE_DISPLAY_NAMES in voice-agent-gateway/providers/language_config.py.
///
/// All languages support voice customization with their available voices:
/// - English (ElevenLabs): 12 voices
/// - Yoruba (YarnGPT): 5 voices
/// - Igbo (YarnGPT): 3 voices
/// - Hausa (YarnGPT): 4 voices
/// - Pidgin (YarnGPT): 13 Nigerian-accented English voices
/// - French (OpenAI): 6 voices
/// - Spanish (OpenAI): 6 voices
class VoiceLanguageDefaults {
  static const Map<String, List<VoiceLanguage>> countryLanguages = {
    'NG': [
      VoiceLanguage(
        code: 'en',
        name: 'English',
        nativeName: 'English',
        flag: '',
        supportsVoiceCustomization: true,
        supportsVoiceCloning: true,
        cloningProvider: 'elevenlabs',
        provider: 'openai',
        defaultVoice: 'alloy',
        availableVoices: [
          VoiceOption(id: 'alloy', name: 'Alloy', gender: 'neutral', accent: 'American'),
          VoiceOption(id: 'echo', name: 'Echo', gender: 'male', accent: 'American'),
          VoiceOption(id: 'fable', name: 'Fable', gender: 'male', accent: 'British'),
          VoiceOption(id: 'onyx', name: 'Onyx', gender: 'male', accent: 'American'),
          VoiceOption(id: 'nova', name: 'Nova', gender: 'female', accent: 'American'),
          VoiceOption(id: 'shimmer', name: 'Shimmer', gender: 'female', accent: 'American'),
        ],
      ),
      VoiceLanguage(
        code: 'yo',
        name: 'Yoruba',
        nativeName: 'Yorùbá',
        flag: '',
        supportsVoiceCustomization: true,
        provider: 'yarngpt',
        defaultVoice: 'yoruba_female1',
        availableVoices: [
          VoiceOption(id: 'yoruba_female1', name: 'Yoruba Female 1', gender: 'female', accent: 'Yoruba'),
          VoiceOption(id: 'yoruba_female2', name: 'Yoruba Female 2', gender: 'female', accent: 'Yoruba'),
          VoiceOption(id: 'yoruba_male1', name: 'Yoruba Male 1', gender: 'male', accent: 'Yoruba'),
          VoiceOption(id: 'yoruba_male2', name: 'Yoruba Male 2', gender: 'male', accent: 'Yoruba'),
          VoiceOption(id: 'yoruba_male3', name: 'Yoruba Male 3', gender: 'male', accent: 'Yoruba'),
        ],
      ),
      VoiceLanguage(
        code: 'ig',
        name: 'Igbo',
        nativeName: 'Igbo',
        flag: '',
        supportsVoiceCustomization: true,
        supportsVoiceCloning: true,
        cloningProvider: 'elevenlabs',
        provider: 'yarngpt',
        defaultVoice: 'igbo_female1',
        availableVoices: [
          VoiceOption(id: 'igbo_female1', name: 'Igbo Female 1', gender: 'female', accent: 'Igbo'),
          VoiceOption(id: 'igbo_female2', name: 'Igbo Female 2', gender: 'female', accent: 'Igbo'),
          VoiceOption(id: 'igbo_male2', name: 'Igbo Male', gender: 'male', accent: 'Igbo'),
        ],
      ),
      VoiceLanguage(
        code: 'ha',
        name: 'Hausa',
        nativeName: 'Hausa',
        flag: '',
        supportsVoiceCustomization: true,
        supportsVoiceCloning: true,
        cloningProvider: 'elevenlabs',
        provider: 'yarngpt',
        defaultVoice: 'hausa_female1',
        availableVoices: [
          VoiceOption(id: 'hausa_female1', name: 'Hausa Female 1', gender: 'female', accent: 'Hausa'),
          VoiceOption(id: 'hausa_female2', name: 'Hausa Female 2', gender: 'female', accent: 'Hausa'),
          VoiceOption(id: 'hausa_male1', name: 'Hausa Male 1', gender: 'male', accent: 'Hausa'),
          VoiceOption(id: 'hausa_male2', name: 'Hausa Male 2', gender: 'male', accent: 'Hausa'),
        ],
      ),
      VoiceLanguage(
        code: 'pcm',
        name: 'Nigerian Pidgin',
        nativeName: 'Naija Pidgin',
        flag: '',
        supportsVoiceCustomization: true,
        provider: 'yarngpt',
        defaultVoice: 'idera',
        availableVoices: [
          VoiceOption(id: 'idera', name: 'Idera', gender: 'female', accent: 'Nigerian'),
          VoiceOption(id: 'emma', name: 'Emma', gender: 'female', accent: 'Nigerian'),
          VoiceOption(id: 'onye', name: 'Onye', gender: 'female', accent: 'Nigerian'),
          VoiceOption(id: 'jude', name: 'Jude', gender: 'male', accent: 'Nigerian'),
          VoiceOption(id: 'osagie', name: 'Osagie', gender: 'male', accent: 'Nigerian'),
          VoiceOption(id: 'tayo', name: 'Tayo', gender: 'male', accent: 'Nigerian'),
          VoiceOption(id: 'zainab', name: 'Zainab', gender: 'female', accent: 'Nigerian'),
          VoiceOption(id: 'joke', name: 'Joke', gender: 'female', accent: 'Nigerian'),
          VoiceOption(id: 'regina', name: 'Regina', gender: 'female', accent: 'Nigerian'),
          VoiceOption(id: 'remi', name: 'Remi', gender: 'male', accent: 'Nigerian'),
          VoiceOption(id: 'umar', name: 'Umar', gender: 'male', accent: 'Nigerian'),
          VoiceOption(id: 'chinenye', name: 'Chinenye', gender: 'female', accent: 'Nigerian'),
          VoiceOption(id: 'saheed', name: 'Saheed', gender: 'male', accent: 'Nigerian'),
        ],
      ),
    ],
    'US': [
      VoiceLanguage(
        code: 'en',
        name: 'English',
        nativeName: 'English',
        flag: '',
        supportsVoiceCustomization: true,
        supportsVoiceCloning: true,
        cloningProvider: 'elevenlabs',
        provider: 'openai',
        defaultVoice: 'alloy',
        availableVoices: [
          VoiceOption(id: 'alloy', name: 'Alloy', gender: 'neutral', accent: 'American'),
          VoiceOption(id: 'echo', name: 'Echo', gender: 'male', accent: 'American'),
          VoiceOption(id: 'fable', name: 'Fable', gender: 'male', accent: 'British'),
          VoiceOption(id: 'onyx', name: 'Onyx', gender: 'male', accent: 'American'),
          VoiceOption(id: 'nova', name: 'Nova', gender: 'female', accent: 'American'),
          VoiceOption(id: 'shimmer', name: 'Shimmer', gender: 'female', accent: 'American'),
        ],
      ),
      VoiceLanguage(
        code: 'es',
        name: 'Spanish',
        nativeName: 'Español',
        flag: '',
        supportsVoiceCustomization: true,
        supportsVoiceCloning: true,
        cloningProvider: 'elevenlabs',
        provider: 'openai',
        defaultVoice: 'nova',
        availableVoices: [
          VoiceOption(id: 'alloy', name: 'Alloy', gender: 'neutral', accent: 'American'),
          VoiceOption(id: 'echo', name: 'Echo', gender: 'male', accent: 'American'),
          VoiceOption(id: 'fable', name: 'Fable', gender: 'male', accent: 'British'),
          VoiceOption(id: 'onyx', name: 'Onyx', gender: 'male', accent: 'American'),
          VoiceOption(id: 'nova', name: 'Nova', gender: 'female', accent: 'American'),
          VoiceOption(id: 'shimmer', name: 'Shimmer', gender: 'female', accent: 'American'),
        ],
      ),
    ],
    'GB': [
      VoiceLanguage(
        code: 'en',
        name: 'English',
        nativeName: 'English',
        flag: '',
        supportsVoiceCustomization: true,
        supportsVoiceCloning: true,
        cloningProvider: 'elevenlabs',
        provider: 'openai',
        defaultVoice: 'alloy',
        availableVoices: [
          VoiceOption(id: 'alloy', name: 'Alloy', gender: 'neutral', accent: 'American'),
          VoiceOption(id: 'echo', name: 'Echo', gender: 'male', accent: 'American'),
          VoiceOption(id: 'fable', name: 'Fable', gender: 'male', accent: 'British'),
          VoiceOption(id: 'onyx', name: 'Onyx', gender: 'male', accent: 'American'),
          VoiceOption(id: 'nova', name: 'Nova', gender: 'female', accent: 'American'),
          VoiceOption(id: 'shimmer', name: 'Shimmer', gender: 'female', accent: 'American'),
        ],
      ),
    ],
    'GH': [
      VoiceLanguage(
        code: 'en',
        name: 'English',
        nativeName: 'English',
        flag: '',
        supportsVoiceCustomization: true,
        supportsVoiceCloning: true,
        cloningProvider: 'elevenlabs',
        provider: 'openai',
        defaultVoice: 'alloy',
        availableVoices: [
          VoiceOption(id: 'alloy', name: 'Alloy', gender: 'neutral', accent: 'American'),
          VoiceOption(id: 'echo', name: 'Echo', gender: 'male', accent: 'American'),
          VoiceOption(id: 'fable', name: 'Fable', gender: 'male', accent: 'British'),
          VoiceOption(id: 'onyx', name: 'Onyx', gender: 'male', accent: 'American'),
          VoiceOption(id: 'nova', name: 'Nova', gender: 'female', accent: 'American'),
          VoiceOption(id: 'shimmer', name: 'Shimmer', gender: 'female', accent: 'American'),
        ],
      ),
    ],
    'KE': [
      VoiceLanguage(
        code: 'en',
        name: 'English',
        nativeName: 'English',
        flag: '',
        supportsVoiceCustomization: true,
        supportsVoiceCloning: true,
        cloningProvider: 'elevenlabs',
        provider: 'openai',
        defaultVoice: 'alloy',
        availableVoices: [
          VoiceOption(id: 'alloy', name: 'Alloy', gender: 'neutral', accent: 'American'),
          VoiceOption(id: 'echo', name: 'Echo', gender: 'male', accent: 'American'),
          VoiceOption(id: 'fable', name: 'Fable', gender: 'male', accent: 'British'),
          VoiceOption(id: 'onyx', name: 'Onyx', gender: 'male', accent: 'American'),
          VoiceOption(id: 'nova', name: 'Nova', gender: 'female', accent: 'American'),
          VoiceOption(id: 'shimmer', name: 'Shimmer', gender: 'female', accent: 'American'),
        ],
      ),
    ],
    'ZA': [
      VoiceLanguage(
        code: 'en',
        name: 'English',
        nativeName: 'English',
        flag: '',
        supportsVoiceCustomization: true,
        supportsVoiceCloning: true,
        cloningProvider: 'elevenlabs',
        provider: 'openai',
        defaultVoice: 'alloy',
        availableVoices: [
          VoiceOption(id: 'alloy', name: 'Alloy', gender: 'neutral', accent: 'American'),
          VoiceOption(id: 'echo', name: 'Echo', gender: 'male', accent: 'American'),
          VoiceOption(id: 'fable', name: 'Fable', gender: 'male', accent: 'British'),
          VoiceOption(id: 'onyx', name: 'Onyx', gender: 'male', accent: 'American'),
          VoiceOption(id: 'nova', name: 'Nova', gender: 'female', accent: 'American'),
          VoiceOption(id: 'shimmer', name: 'Shimmer', gender: 'female', accent: 'American'),
        ],
      ),
    ],
  };

  static List<VoiceLanguage> forCountry(String countryCode) {
    return countryLanguages[countryCode.toUpperCase()] ??
        countryLanguages['NG']!;
  }

  /// Get a specific language by code from the defaults
  static VoiceLanguage? getLanguage(String languageCode, String countryCode) {
    final languages = forCountry(countryCode);
    for (final lang in languages) {
      if (lang.code == languageCode) {
        return lang;
      }
    }
    return null;
  }
}
