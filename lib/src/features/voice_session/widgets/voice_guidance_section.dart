import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/voice_guide_preference.dart';

/// The "show me the voice tips again" control, for a settings screen.
///
/// One widget with a `dark` flag, following the established two-screen pattern
/// (VoiceTxPinSection) — the central settings hub renders light, the voice
/// settings screen renders dark, and writing it twice is how the two drift apart.
///
/// This is the REPLAY control specifically. The standing on/off switch lives in
/// the central settings hub's Guides group with the other guide toggles; what is
/// missing without this is a way for someone who has already seen the tip to ask
/// for it again, which is the thing a help affordance is for.
class VoiceGuidanceSection extends StatefulWidget {
  const VoiceGuidanceSection({
    super.key,
    required this.userId,
    this.dark = false,
  });

  /// Scopes the preference. An empty id disables the control rather than writing
  /// to a shared key — the screen can render before the profile lands.
  final String userId;

  final bool dark;

  @override
  State<VoiceGuidanceSection> createState() => _VoiceGuidanceSectionState();
}

class _VoiceGuidanceSectionState extends State<VoiceGuidanceSection> {
  bool _busy = false;
  bool _justReplayed = false;

  Color get _titleColor => widget.dark ? Colors.white : const Color(0xFF111827);
  Color get _bodyColor => widget.dark
      ? Colors.white.withValues(alpha: 0.55)
      : const Color(0xFF6B7280);
  Color get _surface =>
      widget.dark ? const Color(0xFF16162A) : const Color(0xFFF9FAFB);
  Color get _border => widget.dark
      ? Colors.white.withValues(alpha: 0.08)
      : const Color(0xFFE5E7EB);

  Future<void> _replay() async {
    if (widget.userId.isEmpty || _busy) return;
    setState(() => _busy = true);
    // replayAll, not setDismissed(false): someone who never turned the tips off
    // still needs the per-surface "seen" marks cleared, or this button appears to
    // do nothing for exactly the people most likely to press it.
    await VoiceGuidePreference.replayAll(widget.userId);
    if (!mounted) return;
    setState(() {
      _busy = false;
      _justReplayed = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final disabled = widget.userId.isEmpty;

    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: _border),
      ),
      child: Row(
        children: [
          Icon(Icons.school_outlined,
              size: 20.sp, color: const Color(0xFF7C5CFF)),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Voice tips',
                  style: GoogleFonts.inter(
                    color: _titleColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 3.h),
                Text(
                  _justReplayed
                      // Names WHERE it will appear. "Done" on its own leaves the
                      // user waiting for something on this screen.
                      ? 'The tip will show the next time you open a voice session.'
                      : disabled
                          ? 'Available once your profile has loaded.'
                          : 'Show the how-to-talk tip again in your next voice '
                              'session.',
                  style: GoogleFonts.inter(
                    color: _bodyColor,
                    fontSize: 11.5.sp,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 10.w),
          if (_busy)
            SizedBox(
              width: 18.w,
              height: 18.w,
              child: const CircularProgressIndicator(strokeWidth: 2),
            )
          else
            TextButton(
              onPressed: disabled || _justReplayed ? null : _replay,
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF7C5CFF),
                padding: EdgeInsets.symmetric(horizontal: 10.w),
              ),
              child: Text(
                _justReplayed ? 'Ready' : 'Show again',
                style: GoogleFonts.inter(
                  fontSize: 12.5.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
