/// Per-service voice + chat assistant preferences for a single user.
///
/// Mirrors the general-voice settings model but lets each user pick
/// per-feature overrides — e.g. switch the Crypto assistant to Igbo
/// while keeping the general assistant in English, or add a
/// crypto-specific prompt hint like "I prefer chart-driven analysis"
/// that the agent's system prompt incorporates.
///
/// State lives in SharedPreferences under the
/// `per_service_voice/<service_name>` key as a JSON blob, AND syncs
/// to the backend via the (forthcoming) UpdateVoicePreferences RPC
/// so the chat-*-service agent can read it when assembling its
/// turn-by-turn prompt.
library;

import 'dart:convert';

class PerServiceVoiceSettings {
  /// The chat-*-service this preference targets. One of:
  /// transfers, crypto, investments, insurance, exchange, banking,
  /// commerce, products, business, statistics, notifications,
  /// lifestyle, sprayme, accounts, onboarding.
  final String serviceName;

  /// BCP-47-ish language code. null = inherit user's locale.
  /// Examples: 'en', 'yo', 'ig', 'ha', 'pcm', 'fr'.
  final String? languageCode;

  /// TTS voice id (provider-specific). null = use the provider default
  /// for the selected language. Examples: 'eleven-rachel',
  /// 'yarn-pidgin-female', 'qwen-yo-male-1'.
  final String? voiceId;

  /// Free-text user preference hint folded into the chat-*-service
  /// agent's system prompt. Example for crypto:
  /// "I prefer chart-driven analysis. Always show me the spread bps
  /// before quoting." For exchange: "Always disclose the FX margin."
  final String promptHint;

  /// Whether the user has explicitly configured this — false = all
  /// defaults, true = at least one field set. Lets the entry button
  /// surface a "configured" badge.
  final bool isConfigured;

  /// ISO 8601 UTC timestamp of the last save. Used to break ties
  /// between local-cache vs server state on conflict.
  final String? updatedAt;

  const PerServiceVoiceSettings({
    required this.serviceName,
    this.languageCode,
    this.voiceId,
    this.promptHint = '',
    this.isConfigured = false,
    this.updatedAt,
  });

  /// Sentinel default — used when no row exists yet.
  factory PerServiceVoiceSettings.defaultFor(String serviceName) {
    return PerServiceVoiceSettings(serviceName: serviceName);
  }

  PerServiceVoiceSettings copyWith({
    String? languageCode,
    String? voiceId,
    String? promptHint,
    bool? isConfigured,
    String? updatedAt,
  }) {
    return PerServiceVoiceSettings(
      serviceName: serviceName,
      languageCode: languageCode ?? this.languageCode,
      voiceId: voiceId ?? this.voiceId,
      promptHint: promptHint ?? this.promptHint,
      isConfigured: isConfigured ?? this.isConfigured,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() => {
        'service_name': serviceName,
        'language_code': languageCode,
        'voice_id': voiceId,
        'prompt_hint': promptHint,
        'is_configured': isConfigured,
        'updated_at': updatedAt,
      };

  String toJsonString() => jsonEncode(toJson());

  factory PerServiceVoiceSettings.fromJson(Map<String, dynamic> json) {
    return PerServiceVoiceSettings(
      serviceName: (json['service_name'] as String?) ?? '',
      languageCode: json['language_code'] as String?,
      voiceId: json['voice_id'] as String?,
      promptHint: (json['prompt_hint'] as String?) ?? '',
      isConfigured: (json['is_configured'] as bool?) ?? false,
      updatedAt: json['updated_at'] as String?,
    );
  }

  static PerServiceVoiceSettings? fromJsonString(String? raw) {
    if (raw == null || raw.isEmpty) return null;
    try {
      final m = jsonDecode(raw);
      if (m is Map<String, dynamic>) return PerServiceVoiceSettings.fromJson(m);
    } catch (_) {
      // Corrupt SharedPreferences entry — treat as no row.
    }
    return null;
  }

  /// True iff at least one substantive field is set. Used by
  /// is_configured derivation when the user saves.
  bool hasAnyOverride() {
    return (languageCode != null && languageCode!.isNotEmpty) ||
        (voiceId != null && voiceId!.isNotEmpty) ||
        promptHint.trim().isNotEmpty;
  }
}

/// Canonical list of chat-*-service names that have a per-service
/// voice/chat assistant. UI uses this to enumerate available entries.
const List<String> kSupportedChatServices = <String>[
  'transfers',
  'crypto',
  'investments',
  'insurance',
  'exchange',
  'banking',
  'commerce',
  'products',
  'business',
  'statistics',
  'notifications',
  'lifestyle',
  'sprayme',
  'accounts',
  'onboarding',
];

/// Human-readable label per service. Sourced once here so every entry
/// point spells it the same.
String labelForChatService(String serviceName) {
  switch (serviceName) {
    case 'transfers':
      return 'Send funds & transfers';
    case 'crypto':
    case 'investments':
      return 'Crypto & investments';
    case 'insurance':
      return 'Insurance';
    case 'exchange':
      return 'Currency exchange';
    case 'banking':
      return 'Banking (deposits & withdrawals)';
    case 'commerce':
      return 'Invoices & gift cards';
    case 'products':
      return 'Bills & utilities';
    case 'business':
      return 'Business (payroll & customers)';
    case 'statistics':
      return 'Spending insights';
    case 'notifications':
      return 'Notifications';
    case 'lifestyle':
      return 'Lifestyle';
    case 'sprayme':
      return 'Lazerspray';
    case 'accounts':
      return 'Accounts & cards';
    case 'onboarding':
      return 'Onboarding';
    default:
      return serviceName;
  }
}
