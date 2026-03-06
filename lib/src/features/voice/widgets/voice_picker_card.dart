import 'package:flutter/material.dart';
import '../../models/voice_settings_models.dart';

/// Card for selecting voice for a language
class VoicePickerCard extends StatelessWidget {
  final VoiceLanguage language;
  final List<VoiceOption> voices;
  final String? selectedVoiceId;
  final UserVoiceSetting? userSetting;
  final bool useCustomVoice;
  final ValueChanged<String>? onVoiceSelected;
  final ValueChanged<bool>? onCustomVoiceToggle;
  final ValueChanged<String>? onProviderSelected;

  const VoicePickerCard({
    super.key,
    required this.language,
    required this.voices,
    this.selectedVoiceId,
    this.userSetting,
    this.useCustomVoice = false,
    this.onVoiceSelected,
    this.onCustomVoiceToggle,
    this.onProviderSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Custom Voice Toggle (English only)
          if (language.supportsCustomVoice) ...[
            _buildCustomVoiceToggle(context),
            const SizedBox(height: 16),
            if (useCustomVoice) ...[
              _buildProviderSelector(context),
              const SizedBox(height: 16),
            ],
          ],

          // Voice List (or message when custom voice is enabled)
          if (!useCustomVoice) ...[
            if (voices.isEmpty)
              const Text(
                'No voices available for this language',
                style: TextStyle(color: Color(0xFF9CA3AF)),
              )
            else
              _buildVoiceList(context),
          ] else
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF3B82F6).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.record_voice_over,
                    color: Color(0xFF3B82F6),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Custom Voice Mode',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'The agent will respond in your enrolled voice',
                          style: TextStyle(
                            color: Color(0xFF9CA3AF),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (userSetting?.customVoiceUrl != null)
                    const Icon(
                      Icons.check_circle,
                      color: Color(0xFF10B981),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCustomVoiceToggle(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF2D2D2D),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.person,
            color: Color(0xFF3B82F6),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Use Your Custom Voice',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Train the system to speak like you',
                  style: TextStyle(
                    color: Color(0xFF9CA3AF),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: useCustomVoice,
            onChanged: onCustomVoiceToggle,
            activeColor: const Color(0xFF3B82F6),
          ),
        ],
      ),
    );
  }

  Widget _buildProviderSelector(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Voice Cloning Provider',
          style: TextStyle(
            color: Color(0xFF9CA3AF),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            _buildProviderOption(
              context,
              'elevenlabs',
              'ElevenLabs',
              'Premium quality, fast',
              true, // isDefault
            ),
            const SizedBox(width: 12),
            _buildProviderOption(
              context,
              'xtts',
              'XTTS (QAN)',
              'Cost-optimized, local',
              false,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProviderOption(
    BuildContext context,
    String provider,
    String name,
    String description,
    bool isDefault,
  ) {
    final isSelected = userSetting?.voiceProvider == provider ||
        (!useCustomVoice && isDefault);

    return Expanded(
      child: GestureDetector(
        onTap: () => onProviderSelected?.call(provider),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFF3B82F6).withOpacity(0.2)
                : const Color(0xFF2D2D2D),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected
                  ? const Color(0xFF3B82F6)
                  : Colors.transparent,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  color: isSelected
                      ? const Color(0xFF3B82F6)
                      : Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(
                  color: Color(0xFF9CA3AF),
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVoiceList(BuildContext context) {
    return Column(
      children: voices.map((voice) {
        final isSelected = voice.voiceId == selectedVoiceId;
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFF3B82F6).withOpacity(0.1)
                : const Color(0xFF2D2D2D),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected
                  ? const Color(0xFF3B82F6)
                  : Colors.transparent,
            ),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 4,
            ),
            leading: CircleAvatar(
              radius: 16,
              backgroundColor: _getGenderColor(voice.gender),
              child: Icon(
                _getGenderIcon(voice.gender),
                color: Colors.white,
                size: 16,
              ),
            ),
            title: Text(
              voice.name,
              style: TextStyle(
                color: isSelected
                    ? const Color(0xFF3B82F6)
                    : Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: voice.description != null
                ? Text(
                    voice.description!,
                    style: const TextStyle(
                      color: Color(0xFF9CA3AF),
                      fontSize: 12,
                    ),
                  )
                : null,
            trailing: voice.previewUrl != null
                ? IconButton(
                    icon: const Icon(Icons.play_arrow, size: 20),
                    color: const Color(0xFF3B82F6),
                    onPressed: () {
                      // TODO: Play voice preview
                    },
                  )
                : null,
            onTap: () => onVoiceSelected?.call(voice.voiceId),
          ),
        );
      }).toList(),
    );
  }

  Color _getGenderColor(String? gender) {
    switch (gender?.toLowerCase()) {
      case 'male':
        return const Color(0xFF3B82F6);
      case 'female':
        return const Color(0xFFEC4899);
      default:
        return const Color(0xFF6B7280);
    }
  }

  IconData _getGenderIcon(String? gender) {
    switch (gender?.toLowerCase()) {
      case 'male':
        return Icons.male;
      case 'female':
        return Icons.female;
      default:
        return Icons.person;
    }
  }
}
