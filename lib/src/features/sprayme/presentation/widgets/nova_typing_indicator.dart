import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// What Nova is doing right now, in the order it happens.
///
/// The stages are presentational: the gateway returns one response and does not
/// report progress, so these are timed rather than driven by the server. They
/// are still honest — each stage names work that really is happening in that
/// window (the request is in flight, the agent is running tools, the reply is
/// being streamed back) — and they give the user something that visibly moves
/// while a two-hop LLM call completes.
enum NovaThinkingStage {
  reading,
  thinking,
  typing;

  String get label => switch (this) {
        NovaThinkingStage.reading => 'Nova is reading',
        NovaThinkingStage.thinking => 'Nova is thinking',
        NovaThinkingStage.typing => 'Nova is typing',
      };
}

/// Returns the stage to show after [elapsed] time waiting for a reply.
///
/// Pure so it can be tested without pumping a widget tree.
NovaThinkingStage novaStageFor(Duration elapsed) {
  if (elapsed < const Duration(milliseconds: 1200)) {
    return NovaThinkingStage.reading;
  }
  if (elapsed < const Duration(milliseconds: 4000)) {
    return NovaThinkingStage.thinking;
  }
  return NovaThinkingStage.typing;
}

/// An animated "Nova is …" bubble shown while a reply is in flight.
///
/// The previous indicator used a one-shot [TweenAnimationBuilder] per dot: each
/// dot faded in once and then froze, so after the first few hundred
/// milliseconds nothing on screen moved and the sheet looked stuck. This uses a
/// repeating controller so the bubble keeps animating for as long as the
/// request takes, and names the stage so the wait is legible rather than blank.
class NovaTypingIndicator extends StatefulWidget {
  const NovaTypingIndicator({super.key});

  @override
  State<NovaTypingIndicator> createState() => _NovaTypingIndicatorState();
}

class _NovaTypingIndicatorState extends State<NovaTypingIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _dots;
  late final Stopwatch _elapsed;
  NovaThinkingStage _stage = NovaThinkingStage.reading;

  @override
  void initState() {
    super.initState();
    _elapsed = Stopwatch()..start();
    _dots = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
    // Advancing the stage off the same controller avoids a second ticker and a
    // Timer that could outlive the widget.
    _dots.addListener(_advanceStage);
  }

  void _advanceStage() {
    final next = novaStageFor(_elapsed.elapsed);
    if (next != _stage && mounted) {
      setState(() => _stage = next);
    }
  }

  @override
  void dispose() {
    _dots.removeListener(_advanceStage);
    _dots.dispose();
    _elapsed.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Honour the platform's reduced-motion setting: the stage label still
    // updates, but the dots hold still.
    final reduceMotion = MediaQuery.maybeOf(context)?.disableAnimations ?? false;

    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 14.r,
            backgroundColor: const Color(0xFF7C3AED).withValues(alpha: 0.2),
            child: Icon(Icons.auto_awesome,
                size: 14.sp, color: const Color(0xFF7C3AED)),
          ),
          SizedBox(width: 8.w),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: const Color(0xFF2D2D2D)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // The label is the part that carries meaning, so it is
                // announced to screen readers; the dots are decoration.
                Semantics(
                  liveRegion: true,
                  label: _stage.label,
                  child: Text(
                    _stage.label,
                    style: TextStyle(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                ExcludeSemantics(
                  child: AnimatedBuilder(
                    animation: _dots,
                    builder: (context, _) => Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        for (var i = 0; i < 3; i++) ...[
                          if (i > 0) SizedBox(width: 4.w),
                          _dot(i, reduceMotion),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _dot(int index, bool reduceMotion) {
    // Each dot leads the next by a third of a cycle, producing a travelling
    // pulse rather than three dots blinking in unison.
    final phase = (_dots.value + index / 3) % 1.0;
    // Triangle wave: rises over the first half of the cycle, falls over the
    // second, so the pulse has no visible jump when it wraps.
    final intensity = phase < 0.5 ? phase * 2 : (1 - phase) * 2;
    final alpha = reduceMotion ? 0.55 : 0.3 + intensity * 0.6;

    return Container(
      width: 6.w,
      height: 6.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFF9CA3AF).withValues(alpha: alpha),
      ),
    );
  }
}
