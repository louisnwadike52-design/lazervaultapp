import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/voice_guide_preference.dart';

/// The one-off tip that tells a first-time user how to talk to the agent.
///
/// There was no guidance at all. The interaction mode decides whether you hold,
/// tap, tap-back or just speak, and nothing on the sheet said which — so the only
/// way to learn was to try one and see what happened. When the wrong guess looked
/// like a broken mic, people concluded the feature did not work.
///
/// Deliberately a BANNER, not a modal. The decision was to drop the pre-sheet
/// dialog: a session that opens behind a dialog you have to dismiss before you can
/// speak is a worse first experience than a line of text you can ignore. This
/// appears with the sheet, self-dismisses, and never blocks the mic.
///
/// Shows once per user per device and is re-showable from either settings screen.
/// Marked seen when it APPEARS, not when it dismisses — the dashboard walkthrough
/// learned that marking on completion traps anyone whose dismiss control fails to
/// render.
class VoiceSessionTipBar extends StatefulWidget {
  const VoiceSessionTipBar({
    super.key,
    required this.userId,
    required this.modeHint,
    this.dismissAfter = const Duration(seconds: 5),
  });

  /// Scopes the "seen" mark, so a second account on this phone gets its own
  /// first run rather than inheriting someone else's.
  final String userId;

  /// The mode-specific instruction, e.g. "Hold the mic while you speak".
  /// Supplied by the caller because VoiceTalkMode owns that copy.
  final String modeHint;

  final Duration dismissAfter;

  @override
  State<VoiceSessionTipBar> createState() => _VoiceSessionTipBarState();
}

class _VoiceSessionTipBarState extends State<VoiceSessionTipBar> {
  Timer? _dismissTimer;
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    _decide();
  }

  Future<void> _decide() async {
    final show = await VoiceGuidePreference.shouldShow(
      widget.userId,
      VoiceGuidePreference.surfaceSessionTip,
    );
    if (!mounted || !show) return;
    // Marked BEFORE the timer, so a tip that is somehow never dismissed still
    // counts as shown rather than reappearing on every session.
    await VoiceGuidePreference.markSeen(
      widget.userId,
      VoiceGuidePreference.surfaceSessionTip,
    );
    if (!mounted) return;
    setState(() => _visible = true);
    _arm();
  }

  void _arm() {
    // Cancel-then-arm: re-entering this widget must not stack two timers, which
    // would fire a setState after the first has already disposed it.
    _dismissTimer?.cancel();
    _dismissTimer = Timer(widget.dismissAfter, () {
      if (mounted) setState(() => _visible = false);
    });
  }

  @override
  void dispose() {
    _dismissTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // AnimatedSize rather than a conditional child, so the sheet's layout settles
    // smoothly instead of the content below it jumping when the tip goes.
    return AnimatedSize(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOutCubic,
      child: !_visible
          ? const SizedBox.shrink()
          : Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: GestureDetector(
                // Tapping dismisses. Someone who has read it should not have to
                // wait out the timer.
                onTap: () {
                  _dismissTimer?.cancel();
                  setState(() => _visible = false);
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 14.w, vertical: 11.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF7C5CFF).withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(14.r),
                    border: Border.all(
                      color: const Color(0xFF7C5CFF).withValues(alpha: 0.30),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.lightbulb_outline_rounded,
                          size: 16.sp, color: const Color(0xFFC4B5FD)),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.modeHint,
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 12.5.sp,
                                fontWeight: FontWeight.w600,
                                height: 1.35,
                              ),
                            ),
                            SizedBox(height: 3.h),
                            Text(
                              // The three things that actually change the outcome,
                              // in the order they matter.
                              'Somewhere quiet helps. Speak at a normal pace — '
                              'pausing mid-sentence is fine.',
                              style: GoogleFonts.inter(
                                color: const Color(0xFFB9B9CC),
                                fontSize: 11.5.sp,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Icon(Icons.close_rounded,
                          size: 15.sp, color: const Color(0xFF8A8AA3)),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
