import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// How to physically hold the two phones, stated where the user is looking.
///
/// NFC only couples over a couple of centimetres, between two antennas the
/// user cannot see. Get the alignment wrong and nothing happens at all — no
/// error, no feedback, just a tap that does not land — and both people
/// reasonably conclude the feature is broken rather than that their phones are
/// a few centimetres off. A single line of status text was carrying this, and
/// it read as a status, not as the instruction it is.
///
/// Deliberately NOT a blocking modal. The two people are standing in front of
/// each other trying to pay; a dialog to dismiss on every tap is friction on
/// the fastest path in the product. This is always visible, dominant enough to
/// be read at a glance, and costs nothing to ignore once learned.
///
/// The copy is platform-specific because the antennas are in different places:
///   * Android — typically the UPPER BACK of the handset, so phones go
///     back-to-back with their upper halves aligned.
///   * iPhone — the TOP EDGE, beside the camera. An iPhone reads by its top
///     edge, so "back-to-back" is actively wrong advice for an iPhone payer.
class NfcPositioningGuide extends StatefulWidget {
  const NfcPositioningGuide({
    super.key,
    required this.isPayer,
    this.compact = false,
  });

  /// The payer is the one who moves their phone to the payee's. The
  /// instruction differs: one holds still, one brings their phone in.
  final bool isPayer;

  /// Tighter spacing for screens that are already dense.
  final bool compact;

  @override
  State<NfcPositioningGuide> createState() => _NfcPositioningGuideState();
}

class _NfcPositioningGuideState extends State<NfcPositioningGuide>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // A slow, small nudge of the two phone glyphs toward each other. It shows
    // the MOTION the user has to make, which a static icon cannot, and it is
    // gentle enough not to compete with the amount on screen.
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get _isIOS {
    try {
      return Platform.isIOS;
    } catch (_) {
      return false; // tests / web
    }
  }

  String get _headline =>
      widget.isPayer ? 'Hold your phone to theirs' : 'Ask them to tap now';

  String get _detail {
    if (widget.isPayer) {
      return _isIOS
          ? 'Touch the TOP EDGE of your iPhone to the back of their phone, and hold still.'
          : 'Put the phones back to back, upper halves together, and hold still.';
    }
    return 'Hold your phone steady. They bring their phone to the back of yours, '
        'upper halves together.';
  }

  @override
  Widget build(BuildContext context) {
    const accent = Color(0xFF4E03D0);
    final gap = widget.compact ? 10.h : 14.h;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: widget.compact ? 12.h : 16.h,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            accent.withValues(alpha: 0.20),
            accent.withValues(alpha: 0.08),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: accent.withValues(alpha: 0.35)),
      ),
      child: Row(
        children: [
          _PhonesGlyph(controller: _controller, accent: accent),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _headline,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: gap / 2),
                Text(
                  _detail,
                  style: GoogleFonts.inter(
                    color: Colors.white.withValues(alpha: 0.75),
                    fontSize: 12.sp,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Two phone outlines easing toward each other — the motion, not just an icon.
class _PhonesGlyph extends StatelessWidget {
  const _PhonesGlyph({required this.controller, required this.accent});

  final AnimationController controller;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 46.w,
      height: 46.w,
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, _) {
          // 0 → 1 → 0: the phones close the gap and part again.
          final t = Curves.easeInOut.transform(controller.value);
          final gap = 7.w - (4.w * t);
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _phone(accent.withValues(alpha: 0.55)),
              SizedBox(width: gap),
              _phone(accent.withValues(alpha: 0.95)),
            ],
          );
        },
      ),
    );
  }

  Widget _phone(Color color) => Container(
        width: 13.w,
        height: 30.w,
        decoration: BoxDecoration(
          border: Border.all(color: color, width: 1.6),
          borderRadius: BorderRadius.circular(4.r),
        ),
        // The dot marks the antenna end, so the glyph teaches WHICH part of the
        // phone has to meet the other.
        child: Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.only(top: 3.w),
            child: Container(
              width: 5.w,
              height: 5.w,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
          ),
        ),
      );
}
