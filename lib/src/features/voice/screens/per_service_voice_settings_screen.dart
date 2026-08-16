/// Per-service voice/chat assistant settings screen.
///
/// One generic widget renders the picker for ANY service — the
/// caller pushes `PerServiceVoiceSettingsScreen(serviceName: 'crypto')`
/// from the crypto landing's "Voice Assistant Settings" entry, etc.
///
/// Layout mirrors the general voice settings screen so users find the
/// familiar shape: language picker, an "assistant voice" row that
/// INHERITS the already-set general voice (no provider/model picker —
/// the platform default voice is used), a free-text "prompt hint"
/// field, then a Save row with Reset to defaults / Save buttons.
///
/// THEME: this screen is reached from the settings hub, so it uses the
/// light [SettingsTheme] tokens to match the surrounding settings
/// sections — NOT the dark in-call voice UI.
library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

import '../cubit/per_service_voice_settings_cubit.dart';
import '../models/per_service_voice_settings.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/src/features/settings/presentation/theme/settings_theme.dart';
import 'package:lazervault/core/types/app_routes.dart';

class PerServiceVoiceSettingsScreen extends StatelessWidget {
  final String serviceName;

  const PerServiceVoiceSettingsScreen({
    super.key,
    required this.serviceName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SettingsTheme.bg,
      appBar: AppBar(
        backgroundColor: SettingsTheme.card,
        elevation: 0,
        iconTheme: const IconThemeData(color: SettingsTheme.textPrimary),
        title: Text(
          'Voice & chat settings',
          style: GoogleFonts.inter(
            color: SettingsTheme.textPrimary,
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
              color: SettingsTheme.textPrimary,
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
              color: SettingsTheme.textSecondary,
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
          // Voice is NOT chosen here per service. It inherits the single
          // source of truth — your already-set general assistant voice (or
          // the platform default). This keeps every surface speaking with the
          // same voice and removes provider/model choices from this screen.
          _section(
            title: 'Voice',
            child: _InheritedVoiceRow(
              onOpenVoiceSettings: () => Get.toNamed(AppRoutes.voiceSettings),
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
              style: GoogleFonts.inter(
                  color: SettingsTheme.textPrimary, fontSize: 13.sp),
              decoration: InputDecoration(
                hintText: 'Optional. Folded into the assistant\'s '
                    'system prompt for this service.',
                hintStyle: GoogleFonts.inter(
                  color: SettingsTheme.textTertiary,
                  fontSize: 12.sp,
                ),
                filled: true,
                fillColor: SettingsTheme.surfaceAlt,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: const BorderSide(color: SettingsTheme.divider),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: const BorderSide(color: SettingsTheme.divider),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: const BorderSide(color: SettingsTheme.brand),
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
                  color: SettingsTheme.danger,
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
                    side: const BorderSide(color: SettingsTheme.divider),
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                  ),
                  child: Text(
                    'Reset to defaults',
                    style: GoogleFonts.inter(
                      color: SettingsTheme.textPrimary,
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
                    backgroundColor: SettingsTheme.brand,
                    disabledBackgroundColor:
                        SettingsTheme.brand.withValues(alpha: 0.4),
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                  ),
                  child: widget.state.saving
                      ? LazerVaultLoader(size: 18)
                      : Text(
                          widget.state.dirty ? 'Save' : 'Saved',
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
            color: SettingsTheme.textPrimary,
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        if (help != null) ...[
          SizedBox(height: 4.h),
          Text(
            help,
            style: GoogleFonts.inter(
              color: SettingsTheme.textTertiary,
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
        color: SettingsTheme.surfaceAlt,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: SettingsTheme.divider),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: (selected == null || selected!.isEmpty) ? '' : selected,
          isExpanded: true,
          dropdownColor: SettingsTheme.card,
          style: GoogleFonts.inter(
              color: SettingsTheme.textPrimary, fontSize: 13.sp),
          iconEnabledColor: SettingsTheme.textSecondary,
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

/// Read-only "voice inherits your general assistant voice" row. Replaces the
/// old provider/model voice picker — per the product decision, the platform
/// uses the already-set general voice (or the default) for every service, so
/// there is nothing to pick here. A single affordance jumps to the general
/// Voice & Language setting (the single source of truth) if the user wants to
/// change the voice for everything at once.
class _InheritedVoiceRow extends StatelessWidget {
  final VoidCallback onOpenVoiceSettings;
  const _InheritedVoiceRow({required this.onOpenVoiceSettings});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: SettingsTheme.surfaceAlt,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: SettingsTheme.divider),
      ),
      child: Row(
        children: [
          Icon(Icons.record_voice_over_rounded,
              color: SettingsTheme.brand, size: 20.sp),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Uses your assistant voice',
                  style: GoogleFonts.inter(
                    color: SettingsTheme.textPrimary,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  'Follows your general Voice & Language setting for the '
                  'selected language.',
                  style: GoogleFonts.inter(
                    color: SettingsTheme.textTertiary,
                    fontSize: 11.sp,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: onOpenVoiceSettings,
            child: Text(
              'Change',
              style: GoogleFonts.inter(
                color: SettingsTheme.brand,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
