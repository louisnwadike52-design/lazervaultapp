import 'package:flutter/material.dart';
import '../../models/voice_settings_models.dart';

/// Widget for selecting voice language
class VoiceLanguageSelector extends StatelessWidget {
  final List<VoiceLanguage> languages;
  final String? selectedCode;
  final ValueChanged<String> onLanguageSelected;

  const VoiceLanguageSelector({
    super.key,
    required this.languages,
    this.selectedCode,
    required this.onLanguageSelected,
  });

  @override
  Widget build(BuildContext context) {
    if (languages.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(
          child: Text(
            'No languages available',
            style: TextStyle(color: Color(0xFF9CA3AF)),
          ),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: languages.length,
        separatorBuilder: (_, __) => Divider(
          color: const Color(0xFF2D2D2D),
          height: 1,
        ),
        itemBuilder: (context, index) {
          final language = languages[index];
          final isSelected = language.code == selectedCode;

          return ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            leading: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF3B82F6).withOpacity(0.2)
                    : const Color(0xFF2D2D2D),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  language.flagEmoji ?? _getLanguageEmoji(language.code),
                  style: const TextStyle(fontSize: 24),
                ),
              ),
            ),
            title: Text(
              language.name,
              style: TextStyle(
                color: Colors.white,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
            subtitle: Text(
              language.nativeName,
              style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 12),
            ),
            trailing: _buildTrailing(context, language, isSelected),
            onTap: () => onLanguageSelected(language.code),
          );
        },
      ),
    );
  }

  Widget _buildTrailing(BuildContext context, VoiceLanguage language, bool isSelected) {
    if (language.supportsCustomVoice) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF10B981).withOpacity(0.2),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Text(
              'Custom Voice',
              style: TextStyle(
                color: Color(0xFF10B981),
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Icon(
            isSelected ? Icons.check_circle : Icons.circle_outlined,
            color: isSelected ? const Color(0xFF3B82F6) : const Color(0xFF3B82F6).withOpacity(0.5),
          ),
        ],
      );
    }

    return Icon(
      isSelected ? Icons.check_circle : Icons.circle_outlined,
      color: isSelected ? const Color(0xFF3B82F6) : const Color(0xFF3B82F6).withOpacity(0.5),
    );
  }

  String _getLanguageEmoji(String code) {
    const emojis = {
      'en': '🇬🇧',
      'yo': '🇳🇬',
      'ig': '🇳🇬',
      'ha': '🇳🇬',
      'pcm': '🇳🇬',
      'fr': '🇫🇷',
      'es': '🇪🇸',
      'de': '🇩🇪',
      'it': '🇮🇹',
      'pt': '🇵🇹',
      'ar': '🇸🇦',
      'zh': '🇨🇳',
      'ja': '🇯🇵',
      'ko': '🇰🇷',
      'hi': '🇮🇳',
    };
    return emojis[code.toLowerCase()] ?? '🌐';
  }
}
