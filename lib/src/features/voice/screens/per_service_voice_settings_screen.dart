/// Per-service voice/chat assistant settings screen.
///
/// One generic widget renders the picker for ANY service — the
/// caller pushes `PerServiceVoiceSettingsScreen(serviceName: 'crypto')`
/// from the crypto landing's "Voice Assistant Settings" entry, etc.
///
/// Layout mirrors the existing general voice settings screen so
/// users find the familiar shape: language picker, voice picker,
/// free-text "prompt hint" field, then a Save row with Reset to
/// defaults / Revert / Save buttons.
library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../cubit/per_service_voice_settings_cubit.dart';
import '../models/per_service_voice_settings.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

class PerServiceVoiceSettingsScreen extends StatelessWidget {
  final String serviceName;

  const PerServiceVoiceSettingsScreen({
    super.key,
    required this.serviceName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0A0A),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'Voice & chat settings',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: BlocBuilder<PerServiceVoiceSettingsCubit,
          PerServiceVoiceSettingsState>(
        builder: (context, state) {
          if (state is PerServiceVoiceSettingsInitial) {
            // First mount — kick off load.
            // Cubit.load() is idempotent; calling here keeps the
            // mount-time wiring at a single, predictable spot.
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.read<PerServiceVoiceSettingsCubit>().load();
            });
          }
          if (state is PerServiceVoiceSettingsLoading ||
              state is PerServiceVoiceSettingsInitial) {
            return const Center(
              child: LazerVaultLoader.small(),
            );
          }
          if (state is PerServiceVoiceSettingsLoaded) {
            return _LoadedBody(state: state, serviceName: serviceName);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _LoadedBody extends StatefulWidget {
  final PerServiceVoiceSettingsLoaded state;
  final String serviceName;

  const _LoadedBody({required this.state, required this.serviceName});

  @override
  State<_LoadedBody> createState() => _LoadedBodyState();
}

class _LoadedBodyState extends State<_LoadedBody> {
  late final TextEditingController _hintController;

  @override
  void initState() {
    super.initState();
    _hintController =
        TextEditingController(text: widget.state.settings.promptHint);
  }

  @override
  void didUpdateWidget(covariant _LoadedBody oldWidget) {
    super.didUpdateWidget(oldWidget);
    final newText = widget.state.settings.promptHint;
    if (_hintController.text != newText) {
      _hintController.text = newText;
    }
  }

  @override
  void dispose() {
    _hintController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final settings = widget.state.settings;
    return SafeArea(
      child: ListView(
        padding: EdgeInsets.all(16.w),
        children: [
          Text(
            labelForChatService(widget.serviceName),
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            "These preferences apply only when you talk to "
            "${labelForChatService(widget.serviceName)} via the AI "
            "assistant. Leave any field blank to inherit your "
            "general voice settings.",
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 12.sp,
              height: 1.4,
            ),
          ),
          SizedBox(height: 16.h),
          _section(
            title: 'Language',
            child: _LanguageDropdown(
              selected: settings.languageCode,
              onChanged: (c) => context
                  .read<PerServiceVoiceSettingsCubit>()
                  .selectLanguage(c),
            ),
          ),
          SizedBox(height: 12.h),
          _section(
            title: 'Voice',
            child: _VoiceDropdown(
              selected: settings.voiceId,
              languageCode: settings.languageCode,
              onChanged: (v) => context
                  .read<PerServiceVoiceSettingsCubit>()
                  .selectVoice(v),
            ),
          ),
          SizedBox(height: 12.h),
          _section(
            title: 'Custom instructions for this assistant',
            help:
                'Tell the agent how you prefer to be helped here. '
                'Examples: "Always show me the spread before quoting", '
                '"Use short sentences", "I prefer charts over tables".',
            child: TextField(
              controller: _hintController,
              maxLines: 4,
              maxLength: 400,
              onChanged: (v) => context
                  .read<PerServiceVoiceSettingsCubit>()
                  .setPromptHint(v),
              style: GoogleFonts.inter(color: Colors.white, fontSize: 13.sp),
              decoration: InputDecoration(
                hintText: 'Optional. Folded into the assistant\'s '
                    'system prompt for this service.',
                hintStyle: GoogleFonts.inter(
                  color: const Color(0xFF6B7280),
                  fontSize: 12.sp,
                ),
                filled: true,
                fillColor: const Color(0xFF1F1F1F),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide:
                      const BorderSide(color: Color(0xFF2D2D2D)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide:
                      const BorderSide(color: Color(0xFF2D2D2D)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide:
                      const BorderSide(color: Color(0xFF3B82F6)),
                ),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          if (widget.state.error != null)
            Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: Text(
                widget.state.error!,
                style: GoogleFonts.inter(
                  color: const Color(0xFFEF4444),
                  fontSize: 12.sp,
                ),
              ),
            ),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: widget.state.saving
                      ? null
                      : () => context
                          .read<PerServiceVoiceSettingsCubit>()
                          .resetToDefaults(),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF2D2D2D)),
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                  ),
                  child: Text(
                    'Reset to defaults',
                    style: GoogleFonts.inter(
                      color: Colors.white.withValues(alpha: 0.85),
                      fontSize: 13.sp,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: ElevatedButton(
                  onPressed: widget.state.saving || !widget.state.dirty
                      ? null
                      : () => context
                          .read<PerServiceVoiceSettingsCubit>()
                          .save(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3B82F6),
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                  ),
                  child: widget.state.saving
                      ? LazerVaultLoader(size: 18)
                      : Text(
                          widget.state.dirty
                              ? 'Save'
                              : (widget.state.savedAt == null
                                  ? 'Saved'
                                  : 'Saved'),
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _section({
    required String title,
    required Widget child,
    String? help,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            color: Colors.white.withValues(alpha: 0.85),
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        if (help != null) ...[
          SizedBox(height: 4.h),
          Text(
            help,
            style: GoogleFonts.inter(
              color: const Color(0xFF6B7280),
              fontSize: 11.sp,
              height: 1.4,
            ),
          ),
        ],
        SizedBox(height: 8.h),
        child,
      ],
    );
  }
}

/// Static language list — matches the chat-agent-gateway's
/// SUPPORTED_LANGUAGES set + the voice gateway's TTS routing table.
const List<Map<String, String>> _kLanguages = [
  {'code': '', 'label': 'Inherit general settings'},
  {'code': 'en', 'label': 'English'},
  {'code': 'pcm', 'label': 'Nigerian Pidgin'},
  {'code': 'yo', 'label': 'Yoruba'},
  {'code': 'ig', 'label': 'Igbo'},
  {'code': 'ha', 'label': 'Hausa'},
  {'code': 'fr', 'label': 'French'},
  {'code': 'es', 'label': 'Spanish'},
];

class _LanguageDropdown extends StatelessWidget {
  final String? selected;
  final ValueChanged<String?> onChanged;
  const _LanguageDropdown({required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: (selected == null || selected!.isEmpty) ? '' : selected,
          isExpanded: true,
          dropdownColor: const Color(0xFF1F1F1F),
          style: GoogleFonts.inter(color: Colors.white, fontSize: 13.sp),
          items: _kLanguages
              .map((l) => DropdownMenuItem<String>(
                    value: l['code'],
                    child: Text(l['label']!),
                  ))
              .toList(),
          onChanged: (v) {
            // Empty-string sentinel maps to null = inherit.
            onChanged((v == null || v.isEmpty) ? null : v);
          },
        ),
      ),
    );
  }
}

/// Voice list per language. Free-tier voices only — premium options
/// (ElevenLabs custom-cloned voices) appear when the user has
/// completed voice cloning in the general settings.
const Map<String, List<Map<String, String>>> _kVoicesByLang = {
  'en': [
    {'id': '', 'label': 'Default'},
    {'id': 'openai-nova', 'label': 'Nova (OpenAI, warm)'},
    {'id': 'openai-onyx', 'label': 'Onyx (OpenAI, deep)'},
    {'id': 'eleven-rachel', 'label': 'Rachel (ElevenLabs, calm)'},
  ],
  'yo': [
    {'id': '', 'label': 'Default'},
    {'id': 'yarn-yoruba-female', 'label': 'Yoruba (YarnGPT, female)'},
    {'id': 'yarn-yoruba-male', 'label': 'Yoruba (YarnGPT, male)'},
  ],
  'ig': [
    {'id': '', 'label': 'Default'},
    {'id': 'yarn-igbo-female', 'label': 'Igbo (YarnGPT, female)'},
  ],
  'ha': [
    {'id': '', 'label': 'Default'},
    {'id': 'yarn-hausa-male', 'label': 'Hausa (YarnGPT, male)'},
  ],
  'pcm': [
    {'id': '', 'label': 'Default'},
    {'id': 'yarn-pidgin-female', 'label': 'Pidgin (YarnGPT, female)'},
  ],
  'fr': [
    {'id': '', 'label': 'Default'},
    {'id': 'openai-shimmer', 'label': 'Shimmer (OpenAI)'},
  ],
  'es': [
    {'id': '', 'label': 'Default'},
    {'id': 'openai-alloy', 'label': 'Alloy (OpenAI)'},
  ],
};

class _VoiceDropdown extends StatelessWidget {
  final String? selected;
  final String? languageCode;
  final ValueChanged<String?> onChanged;
  const _VoiceDropdown({
    required this.selected,
    required this.languageCode,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final lang = (languageCode == null || languageCode!.isEmpty)
        ? 'en'
        : languageCode!;
    final voices = _kVoicesByLang[lang] ?? _kVoicesByLang['en']!;
    final currentValue = (selected == null || selected!.isEmpty) ? '' : selected;
    final hasMatch = voices.any((v) => v['id'] == currentValue);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: hasMatch ? currentValue : '',
          isExpanded: true,
          dropdownColor: const Color(0xFF1F1F1F),
          style: GoogleFonts.inter(color: Colors.white, fontSize: 13.sp),
          items: voices
              .map((v) => DropdownMenuItem<String>(
                    value: v['id'],
                    child: Text(v['label']!),
                  ))
              .toList(),
          onChanged: (v) {
            onChanged((v == null || v.isEmpty) ? null : v);
          },
        ),
      ),
    );
  }
}
