import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/src/features/voice_session/models/voice_language.dart';
import 'package:lazervault/src/features/voice_session/widgets/voice_customization_sheet.dart'
    show kMyVoiceSentinelId;
part 'voice_language_voice_sheet_widgets.dart';


/// ONE central in-call control consolidating language + voice selection.
///
/// Replaces the separate "Language" and "Voice" chips/sheets: pick a language
/// (top), its voices filter in below (incl. the user's cloned "Your Voice" when
/// available), confirm once. The caller applies the result as a LIVE swap during
/// a call (no session restart) or as the initial language+voice when starting.
class VoiceLanguageVoiceSheet extends StatefulWidget {
  final List<VoiceLanguage> languages;
  final String? selectedLanguageCode;
  final String? selectedVoiceId;

  /// Resolve the user's cloned voice for a given language (null when none/not
  /// supported). Called again whenever the language changes inside the sheet.
  final Future<YourVoiceInfo?> Function(VoiceLanguage language) resolveYourVoice;

  /// Whether a call is live. When true the sheet applies every language/voice
  /// tap INSTANTLY via [onLiveChange] (no Apply button); when false the user
  /// confirms once via the "Start conversation" button.
  final bool isSessionActive;

  /// Applied on EACH language/voice tap while a call is live, so the switch
  /// reflects in the conversation immediately (no Apply step). Ignored when no
  /// session is active.
  final void Function(VoiceLangVoiceResult result)? onLiveChange;

  /// Opens the deeper per-service / global voice settings screen.
  final VoidCallback onAdvancedSettings;

  const VoiceLanguageVoiceSheet({
    super.key,
    required this.languages,
    required this.selectedLanguageCode,
    required this.selectedVoiceId,
    required this.resolveYourVoice,
    required this.isSessionActive,
    required this.onAdvancedSettings,
    this.onLiveChange,
  });

  static Future<VoiceLangVoiceResult?> show(
    BuildContext context, {
    required List<VoiceLanguage> languages,
    required String? selectedLanguageCode,
    required String? selectedVoiceId,
    required Future<YourVoiceInfo?> Function(VoiceLanguage) resolveYourVoice,
    required bool isSessionActive,
    required VoidCallback onAdvancedSettings,
    void Function(VoiceLangVoiceResult result)? onLiveChange,
  }) {
    return showModalBottomSheet<VoiceLangVoiceResult>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => VoiceLanguageVoiceSheet(
        languages: languages,
        selectedLanguageCode: selectedLanguageCode,
        selectedVoiceId: selectedVoiceId,
        resolveYourVoice: resolveYourVoice,
        isSessionActive: isSessionActive,
        onAdvancedSettings: onAdvancedSettings,
        onLiveChange: onLiveChange,
      ),
    );
  }

  @override
  State<VoiceLanguageVoiceSheet> createState() =>
      _VoiceLanguageVoiceSheetState();
}

class _VoiceLanguageVoiceSheetState extends State<VoiceLanguageVoiceSheet> {
  static const Color _accent = Color(0xFF3B82F6);
  static const Color _clone = Color(0xFF10B981);

  late String _langCode;
  String? _voiceId;
  YourVoiceInfo? _yourVoice;
  bool _resolving = false;

  @override
  void initState() {
    super.initState();
    _langCode = widget.selectedLanguageCode ??
        (widget.languages.isNotEmpty ? widget.languages.first.code : '');
    _voiceId = widget.selectedVoiceId;
    _resolveYourVoiceForCurrent();
  }

  VoiceLanguage? get _currentLang {
    for (final l in widget.languages) {
      if (l.code == _langCode) return l;
    }
    return widget.languages.isNotEmpty ? widget.languages.first : null;
  }

  Future<void> _resolveYourVoiceForCurrent() async {
    final lang = _currentLang;
    if (lang == null) return;
    setState(() => _resolving = true);
    YourVoiceInfo? info;
    try {
      info = await widget.resolveYourVoice(lang);
    } catch (_) {
      info = null;
    }
    if (!mounted) return;
    setState(() {
      _yourVoice = info;
      _resolving = false;
      _ensureValidVoice(lang);
    });
  }

  /// Keep the selected voice valid for the active language: clear a stale clone
  /// sentinel when no clone is offered; fall back to the language default when
  /// the current preset isn't in this language's list.
  void _ensureValidVoice(VoiceLanguage lang) {
    if (_voiceId == kMyVoiceSentinelId) {
      if (_yourVoice != null) return; // clone valid here
    } else if (_voiceId != null &&
        lang.availableVoices.any((v) => v.id == _voiceId)) {
      return; // preset valid here
    }
    _voiceId = lang.defaultVoiceOption?.id ??
        (lang.availableVoices.isNotEmpty ? lang.availableVoices.first.id : null);
  }

  void _onLanguageTap(VoiceLanguage lang) async {
    if (lang.code == _langCode) return;
    setState(() => _langCode = lang.code);
    // Resolve the clone availability + reconcile a valid voice for the new
    // language, THEN push the live swap so the agent switches immediately.
    await _resolveYourVoiceForCurrent();
    _emitLiveChange();
  }

  /// Build the current language+voice selection as a result.
  VoiceLangVoiceResult? _currentResult() {
    final lang = _currentLang;
    if (lang == null) return null;
    VoiceOption voice;
    if (_voiceId == kMyVoiceSentinelId && _yourVoice != null) {
      voice = const VoiceOption(id: kMyVoiceSentinelId, name: 'Your Voice');
    } else {
      voice = lang.availableVoices.firstWhere(
        (v) => v.id == _voiceId,
        orElse: () => lang.defaultVoiceOption ??
            (lang.availableVoices.isNotEmpty
                ? lang.availableVoices.first
                : const VoiceOption(id: '', name: 'Default')),
      );
    }
    return VoiceLangVoiceResult(lang, voice);
  }

  /// Apply the current selection LIVE during a call (no Apply button). The
  /// caller pushes language_changed / voice_changed over the WebSocket so the
  /// very next voice reply uses the new language/voice.
  void _emitLiveChange() {
    if (!widget.isSessionActive) return;
    final r = _currentResult();
    if (r != null) widget.onLiveChange?.call(r);
  }

  /// Confirm + close — only used in the START flow (no live session yet).
  void _confirm() {
    final r = _currentResult();
    if (r == null) {
      Navigator.of(context).pop();
      return;
    }
    Navigator.of(context).pop(r);
  }

  @override
  Widget build(BuildContext context) {
    final lang = _currentLang;
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      maxChildSize: 0.95,
      minChildSize: 0.45,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A1A),
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          ),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 12.h, bottom: 8.h),
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              // Header
              Padding(
                padding: EdgeInsets.fromLTRB(20.w, 8.h, 12.w, 4.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Voice & Language',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(Icons.close_rounded,
                          color: Colors.white.withValues(alpha: 0.5),
                          size: 22.sp),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 16.h),
                  children: [
                    _sectionLabel('Language'),
                    SizedBox(height: 10.h),
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children: widget.languages
                          .map((l) => _languagePill(l, l.code == _langCode))
                          .toList(),
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        _sectionLabel('Voice'),
                        if (lang != null) ...[
                          SizedBox(width: 8.w),
                          Text(
                            'for ${lang.nativeName}',
                            style: GoogleFonts.inter(
                              color: Colors.white.withValues(alpha: 0.4),
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                        const Spacer(),
                        if (_resolving)
                          SizedBox(
                            width: 14.w,
                            height: 14.w,
                            child: const CircularProgressIndicator(
                                strokeWidth: 2, color: _accent),
                          ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    // Make it obvious the voice is changeable for the CURRENT
                    // language — users shouldn't have to re-pick their language to
                    // switch voice. Only shown when there's an actual choice (2+).
                    if (lang != null &&
                        (lang.availableVoices.length +
                                (_yourVoice != null ? 1 : 0)) >=
                            2)
                      _voiceHint(lang.nativeName),
                    if (lang == null)
                      _emptyVoices()
                    else ...[
                      if (_yourVoice != null) _yourVoiceTile(),
                      if (lang.availableVoices.isEmpty && _yourVoice == null)
                        _emptyVoices()
                      else
                        ...lang.availableVoices
                            .map((v) => _voiceTile(v, v.id == _voiceId)),
                    ],
                    SizedBox(height: 8.h),
                    // Advanced settings link → deeper per-service / global screen.
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                        widget.onAdvancedSettings();
                      },
                      borderRadius: BorderRadius.circular(12.r),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
                        child: Row(
                          children: [
                            Icon(Icons.settings_rounded,
                                color: Colors.white.withValues(alpha: 0.5),
                                size: 18.sp),
                            SizedBox(width: 10.w),
                            Text(
                              'Advanced voice settings',
                              style: GoogleFonts.inter(
                                color: Colors.white.withValues(alpha: 0.7),
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Spacer(),
                            Icon(Icons.chevron_right_rounded,
                                color: Colors.white.withValues(alpha: 0.4),
                                size: 20.sp),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Primary action.
              //  • Live call → NO Apply button: every tap above applies the
              //    language/voice instantly (reflected in the next reply). We
              //    just show an instant-apply hint + a Done affordance.
              //  • No session yet → "Start conversation" confirms the pick.
              SafeArea(
                top: false,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 12.h),
                  child: widget.isSessionActive
                      ? Row(
                          children: [
                            Icon(Icons.bolt_rounded, color: _clone, size: 16.sp),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: Text(
                                'Changes apply instantly to your conversation',
                                style: GoogleFonts.inter(
                                  color: Colors.white.withValues(alpha: 0.6),
                                  fontSize: 12.5.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: Text(
                                'Done',
                                style: GoogleFonts.inter(
                                  color: _accent,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        )
                      : SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _voiceId == null ? null : _confirm,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _accent,
                              disabledBackgroundColor:
                                  _accent.withValues(alpha: 0.3),
                              padding: EdgeInsets.symmetric(vertical: 14.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14.r),
                              ),
                            ),
                            child: Text(
                              'Start conversation',
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _sectionLabel(String text) => Text(
        text,
        style: GoogleFonts.inter(
          color: Colors.white.withValues(alpha: 0.85),
          fontSize: 14.sp,
          fontWeight: FontWeight.w700,
        ),
      );

  /// CTA hint making it explicit the voice is changeable for the CURRENT
  /// language — users don't need to reselect their language to switch voice.
  Widget _voiceHint(String langName) => Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: _accent.withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: _accent.withValues(alpha: 0.25), width: 1),
        ),
        child: Row(
          children: [
            Icon(Icons.info_outline_rounded, color: _accent, size: 16.sp),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                'Tap any voice below to change how $langName sounds — you can '
                'switch the voice anytime, even without changing your language.',
                style: GoogleFonts.inter(
                  color: Colors.white.withValues(alpha: 0.75),
                  fontSize: 12.sp,
                  height: 1.35,
                ),
              ),
            ),
          ],
        ),
      );

  Widget _languagePill(VoiceLanguage l, bool selected) {
    return GestureDetector(
      onTap: () => _onLanguageTap(l),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: selected
              ? _accent.withValues(alpha: 0.15)
              : Colors.white.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: selected
                ? _accent.withValues(alpha: 0.4)
                : Colors.white.withValues(alpha: 0.08),
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (selected) ...[
              Icon(Icons.check_circle_rounded, color: _accent, size: 15.sp),
              SizedBox(width: 6.w),
            ],
            Text(
              l.nativeName,
              style: GoogleFonts.inter(
                color: selected ? Colors.white : Colors.white.withValues(alpha: 0.7),
                fontSize: 13.sp,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _emptyVoices() => Padding(
        padding: EdgeInsets.symmetric(vertical: 18.h),
        child: Center(
          child: Text(
            'No selectable voices for this language',
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.4),
              fontSize: 13.sp,
            ),
          ),
        ),
      );

  Widget _voiceTile(VoiceOption voice, bool selected) {
    return GestureDetector(
      onTap: () {
        setState(() => _voiceId = voice.id);
        _emitLiveChange();
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: _tileDecoration(selected),
        child: Row(
          children: [
            Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selected
                    ? _accent.withValues(alpha: 0.2)
                    : Colors.white.withValues(alpha: 0.06),
              ),
              child: Center(child: _genderIcon(voice.gender, selected)),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    voice.name,
                    style: GoogleFonts.inter(
                      color: selected
                          ? Colors.white
                          : Colors.white.withValues(alpha: 0.85),
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if ((voice.accent ?? '').isNotEmpty ||
                      (voice.gender ?? '').isNotEmpty) ...[
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        if ((voice.accent ?? '').isNotEmpty)
                          _detailChip(voice.accent!),
                        if ((voice.gender ?? '').isNotEmpty)
                          _detailChip(_cap(voice.gender!)),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            _radio(selected),
          ],
        ),
      ),
    );
  }

  Widget _yourVoiceTile() {
    final selected = _voiceId == kMyVoiceSentinelId;
    final info = _yourVoice!;
    final subtitle = info.name.trim().isNotEmpty
        ? info.name
        : ((info.username ?? '').isNotEmpty
            ? '@${info.username}'
            : 'Speak in your own voice');
    return GestureDetector(
      onTap: () {
        setState(() => _voiceId = kMyVoiceSentinelId);
        _emitLiveChange();
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: _tileDecoration(selected),
        child: Row(
          children: [
            _cloneAvatar(info, selected),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Your Voice',
                        style: GoogleFonts.inter(
                          color: selected
                              ? Colors.white
                              : Colors.white.withValues(alpha: 0.85),
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: _clone.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(4.r),
                          border: Border.all(
                              color: _clone.withValues(alpha: 0.3), width: 1),
                        ),
                        child: Text(
                          'CLONED',
                          style: GoogleFonts.inter(
                            color: _clone,
                            fontSize: 9.sp,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      color: Colors.white.withValues(alpha: 0.5),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            _radio(selected),
          ],
        ),
      ),
    );
  }

  BoxDecoration _tileDecoration(bool selected) => BoxDecoration(
        color: selected
            ? _accent.withValues(alpha: 0.12)
            : Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: selected
              ? _accent.withValues(alpha: 0.4)
              : Colors.white.withValues(alpha: 0.06),
          width: 1.5,
        ),
      );

  Widget _radio(bool selected) => Container(
        width: 28.w,
        height: 28.w,
        decoration: BoxDecoration(
          color: selected ? _accent : Colors.transparent,
          shape: BoxShape.circle,
          border: selected
              ? null
              : Border.all(
                  color: Colors.white.withValues(alpha: 0.15), width: 1.5),
        ),
        child: selected
            ? Icon(Icons.check_rounded, color: Colors.white, size: 16.sp)
            : null,
      );

  Widget _genderIcon(String? gender, bool selected) {
    final icon = gender == 'female'
        ? Icons.woman_rounded
        : gender == 'male'
            ? Icons.man_rounded
            : Icons.person_rounded;
    return Icon(icon,
        color: selected ? _accent : Colors.white.withValues(alpha: 0.4),
        size: 22.sp);
  }

  Widget _cloneAvatar(YourVoiceInfo info, bool selected) {
    final url = (info.avatarUrl ?? '').trim();
    Widget initials() => Container(
          width: 44.w,
          height: 44.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _accent.withValues(alpha: selected ? 0.25 : 0.15),
          ),
          alignment: Alignment.center,
          child: Text(
            _initials(info.name, info.username ?? ''),
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 15.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        );
    return ClipOval(
      child: url.isEmpty
          ? initials()
          : CachedNetworkImage(
              imageUrl: url,
              width: 44.w,
              height: 44.w,
              fit: BoxFit.cover,
              placeholder: (_, __) => initials(),
              errorWidget: (_, __, ___) => initials(),
            ),
    );
  }

  String _initials(String name, String username) {
    final src = name.isNotEmpty ? name : username;
    final parts =
        src.trim().split(RegExp(r'\s+')).where((p) => p.isNotEmpty).toList();
    if (parts.isEmpty) return '?';
    if (parts.length == 1) {
      final p = parts.first;
      return (p.length >= 2 ? p.substring(0, 2) : p.substring(0, 1))
          .toUpperCase();
    }
    return (parts.first[0] + parts.last[0]).toUpperCase();
  }

  Widget _detailChip(String text) => Container(
        margin: EdgeInsets.only(right: 6.w),
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: Text(
          text,
          style: GoogleFonts.inter(
            color: Colors.white.withValues(alpha: 0.5),
            fontSize: 11.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      );

  String _cap(String s) =>
      s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);
}
