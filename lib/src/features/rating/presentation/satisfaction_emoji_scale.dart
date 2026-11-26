import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A 1–5 satisfaction scale drawn as faces rather than stars.
///
/// WHY FACES AT ALL. Stars ask "rate us"; faces ask "how was that for you",
/// which is the question this sheet actually wants answered. A face is also
/// read faster than a count of stars, and the difference between 2 and 3 stars
/// is a judgement nobody makes consistently — the difference between a frown
/// and a flat mouth is not.
///
/// WHY A WORD UNDER EACH. Emoji are not universal: the same glyph renders
/// differently per platform and reads differently per culture, and a scale
/// whose meaning is ambiguous produces data that cannot be trusted. The label
/// is what fixes the meaning; the face is what makes it quick.
///
/// WHY GLYPHS AND NOT LOTTIE. lottie is in the project, but there are no face
/// animations in assets/ — only the sprayme effects. Inventing animation JSON
/// for five faces would ship assets nobody designed. Transform-animating the
/// glyph gives real motion with nothing new to maintain.
///
/// ACCESSIBILITY. Each face is a 44px-minimum tap target with a semantic
/// label, so the scale is usable by someone who cannot see the difference
/// between the faces at all.
class SatisfactionEmojiScale extends StatefulWidget {
  /// 0 = nothing chosen yet.
  final int value;
  final ValueChanged<int> onChanged;
  final bool enabled;

  const SatisfactionEmojiScale({
    super.key,
    required this.value,
    required this.onChanged,
    this.enabled = true,
  });

  @override
  State<SatisfactionEmojiScale> createState() => _SatisfactionEmojiScaleState();
}

class _SatisfactionEmojiScaleState extends State<SatisfactionEmojiScale>
    with SingleTickerProviderStateMixin {
  /// Ordered worst → best. The labels carry the meaning; see the class note.
  static const _faces = <({String glyph, String label})>[
    (glyph: '😞', label: 'Bad'),
    (glyph: '🙁', label: 'Poor'),
    (glyph: '😐', label: 'Okay'),
    (glyph: '🙂', label: 'Good'),
    (glyph: '🤩', label: 'Great'),
  ];

  /// Drives the chosen face only.
  ///
  /// One controller, not five: five independently animating glyphs read as a
  /// loading state rather than as feedback — the same reasoning the star row
  /// records for its single row-level pop.
  late final AnimationController _pop = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 420),
  );

  @override
  void dispose() {
    _pop.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant SatisfactionEmojiScale old) {
    super.didUpdateWidget(old);
    if (widget.value != old.value && widget.value > 0) {
      _pop
        ..reset()
        ..forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(_faces.length, (i) {
        final n = i + 1;
        final face = _faces[i];
        final chosen = widget.value == n;
        // Nothing chosen yet: every face at full strength, so the row reads as
        // a question. Once chosen, the others recede so the answer is obvious
        // at a glance — including to someone who has just tapped and is about
        // to look away.
        final dimmed = widget.value != 0 && !chosen;

        return Semantics(
          button: true,
          selected: chosen,
          label: '${face.label}, $n of ${_faces.length}',
          child: InkResponse(
            onTap: widget.enabled ? () => widget.onChanged(n) : null,
            radius: 28.r,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 4.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 180),
                    opacity: dimmed ? 0.38 : 1,
                    child: AnimatedBuilder(
                      animation: _pop,
                      builder: (_, child) {
                        // Overshoot then settle, only on the chosen face.
                        final t = chosen ? _pop.value : 0.0;
                        final bounce = Curves.easeOutBack.transform(
                          t.clamp(0.0, 1.0),
                        );
                        final scale = chosen
                            ? 1.0 + (0.28 * bounce)
                            : (dimmed ? 0.9 : 1.0);
                        return Transform.scale(scale: scale, child: child);
                      },
                      child: SizedBox(
                        // A fixed box so a scaling glyph cannot reflow the row
                        // and shift the other tap targets under the finger.
                        width: 44.w,
                        height: 44.w,
                        child: Center(
                          child: Text(
                            face.glyph,
                            style: TextStyle(fontSize: 30.sp),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 180),
                    style: TextStyle(
                      fontSize: 10.5.sp,
                      fontWeight: chosen ? FontWeight.w700 : FontWeight.w500,
                      color: chosen
                          ? const Color(0xFF4834D4)
                          : const Color(0xFF9A98A8),
                    ),
                    child: Text(face.label),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
