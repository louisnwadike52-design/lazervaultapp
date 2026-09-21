import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// What the talk control is, and how to work it.
///
/// The interaction mode decides a GESTURE — tap, hold, or double-tap — and
/// nothing about the button ever said which. All three modes rendered the same
/// unlabelled mic, so the only way to learn the gesture was to guess and watch
/// whether anything happened. Worse, the talk mic sat beside the mute mic: two
/// circular buttons, both mic glyphs, one of which starts a recording and one
/// of which stops the microphone entirely.
///
/// The copy lived in three places that had already drifted apart (the sheet
/// said "Double-tap", the floating bubble said "Double-tap to talk"). This is
/// the single source: the sheet, the minimized bubble and the settings screen
/// all read from here, so they cannot disagree again.
class VoiceTalkMode {
  VoiceTalkMode._();

  static const String continuous = 'continuous';
  static const String hold = 'hold';
  static const String tap = 'tap';
  static const String doubleTap = 'double_tap';

  /// Canonical order, used by the mode cycler and the settings list.
  static const List<String> all = [continuous, hold, tap, doubleTap];

  static bool isPushToTalk(String mode) => mode != continuous;

  /// Short name for a chip or a settings row — "Tap to talk".
  static String label(String mode) {
    switch (mode) {
      case hold:
        return 'Hold to talk';
      case tap:
        return 'Tap to talk';
      case doubleTap:
        return 'Double-tap to talk';
      default:
        return 'Hands-free';
    }
  }

  /// The instruction shown ON the control, in the imperative, describing the
  /// gesture that starts a recording right now.
  static String action(String mode, {required bool capturing}) {
    if (mode == continuous) return capturing ? 'Listening' : 'Hands-free';
    if (capturing) {
      // While capturing, the useful instruction is how to STOP — which differs
      // per mode and is the half people never discover.
      switch (mode) {
        case hold:
          return 'Release to send';
        case doubleTap:
          return 'Double-tap to send';
        default:
          return 'Tap to send';
      }
    }
    switch (mode) {
      case hold:
        return 'Hold to talk';
      case doubleTap:
        return 'Double-tap to talk';
      default:
        return 'Tap to talk';
    }
  }

  /// One line explaining the whole round trip, for settings and the first-run
  /// hint — where there is room to say what happens after the gesture.
  static String explanation(String mode) {
    switch (mode) {
      case hold:
        return 'Press and hold the mic while you speak. '
            'Let go and your message is sent.';
      case tap:
        return 'Tap the mic to start speaking, then tap again to send.';
      case doubleTap:
        return 'Double-tap the mic to start speaking, '
            'then double-tap again to send.';
      default:
        return 'The mic stays open and replies as you speak — '
            'no button to press.';
    }
  }

  static IconData icon(String mode) {
    switch (mode) {
      case hold:
        return Icons.touch_app_rounded;
      case doubleTap:
        return Icons.ads_click_rounded;
      case tap:
        return Icons.touch_app_outlined;
      default:
        return Icons.graphic_eq_rounded;
    }
  }
}

/// The primary talk control: a mic that says what to do to it.
///
/// Three things make it findable where the bare circle was not:
///
///   * a label underneath naming the gesture for the CURRENT mode, so the
///     button teaches instead of requiring a guess;
///   * a slow pulse while idle, which draws the eye to the one control that
///     starts a conversation and stops the moment it is engaged — motion that
///     continued during capture would compete with the live audio meter;
///   * a larger footprint than its neighbours, so the primary action reads as
///     primary next to end-call and mute.
class VoiceTalkButton extends StatefulWidget {
  const VoiceTalkButton({
    super.key,
    required this.mode,
    required this.capturing,
    required this.onBegin,
    required this.onEnd,
    this.accent = const Color(0xFF5B45C9),
    this.activeColor = const Color(0xFF10B981),
    this.showLabel = true,
    this.diameter = 76,
  });

  final String mode;
  final bool capturing;
  final VoidCallback onBegin;
  final VoidCallback onEnd;
  final Color accent;
  final Color activeColor;
  final bool showLabel;

  /// Logical width of the mic itself, before .w scaling. The floating bubble
  /// passes a smaller value; the pulse ring and glyph scale with it so the
  /// compact form keeps the same proportions rather than a cramped halo.
  final double diameter;

  @override
  State<VoiceTalkButton> createState() => _VoiceTalkButtonState();
}

class _VoiceTalkButtonState extends State<VoiceTalkButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulse;

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    );
    _syncPulse();
  }

  @override
  void didUpdateWidget(covariant VoiceTalkButton old) {
    super.didUpdateWidget(old);
    if (old.capturing != widget.capturing) _syncPulse();
  }

  /// The button animates in BOTH states, but they say different things.
  ///
  /// Idle: one slow expanding ring in the accent colour — "press me".
  /// Capturing: fast staggered waves in the active colour — "I can hear you".
  ///
  /// Running the same slow halo while recording was the problem: it reads as
  /// "still waiting for you" at exactly the moment the mic IS open, so a user
  /// holding the button had nothing telling them it was working. Speed and
  /// colour are what separate the two, so they are never mistaken for each
  /// other even at a glance.
  void _syncPulse() {
    _pulse.stop();
    _pulse.duration = widget.capturing
        ? const Duration(milliseconds: 1100)
        : const Duration(milliseconds: 1600);
    _pulse.repeat();
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  void _toggle() => widget.capturing ? widget.onEnd() : widget.onBegin();

  @override
  Widget build(BuildContext context) {
    final colour = widget.capturing ? widget.activeColor : widget.accent;
    final label =
        VoiceTalkMode.action(widget.mode, capturing: widget.capturing);

    final core = AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      width: widget.diameter.w,
      height: widget.diameter.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: colour.withValues(alpha: widget.capturing ? 0.9 : 0.20),
        border: Border.all(color: colour.withValues(alpha: 0.65), width: 2),
        boxShadow: widget.capturing
            ? [
                BoxShadow(
                  color: widget.activeColor.withValues(alpha: 0.5),
                  blurRadius: 18,
                  spreadRadius: 2,
                )
              ]
            : null,
      ),
      child: Icon(
        widget.capturing ? Icons.graphic_eq_rounded : Icons.mic_none_rounded,
        color: widget.capturing ? Colors.white : colour,
        size: (widget.diameter * 0.42).sp,
      ),
    );

    // The expanding ring sits BEHIND the button and ignores pointers, so the
    // animation can never widen or steal the tap target.
    final pulsing = SizedBox(
      width: (widget.diameter + 28).w,
      height: (widget.diameter + 28).w,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
            animation: _pulse,
            builder: (_, __) {
              // Three staggered waves while capturing, one ring while idle.
              // Staggering is what makes it read as sound LEAVING the mic
              // rather than a single ring breathing.
              final waves = widget.capturing ? 3 : 1;
              return IgnorePointer(
                child: Stack(
                  alignment: Alignment.center,
                  children: List.generate(waves, (i) {
                    // Offset each wave through the cycle and wrap, so they
                    // chase each other continuously instead of restarting
                    // together.
                    final phase = (_pulse.value + i / waves) % 1.0;
                    final t = Curves.easeOut.transform(phase);
                    return Container(
                      width: (widget.diameter + 28 * t).w,
                      height: (widget.diameter + 28 * t).w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: (widget.capturing
                                  ? widget.activeColor
                                  : widget.accent)
                              .withValues(
                                  alpha: (widget.capturing ? 0.55 : 0.45) *
                                      (1 - t)),
                          width: 2,
                        ),
                      ),
                    );
                  }),
                ),
              );
            },
          ),
          core,
        ],
      ),
    );

    // Gesture per mode. `hold` binds down/up so the capture window matches the
    // press exactly; onTapCancel ends it too, otherwise dragging a finger off
    // the button would leave the mic open with nothing on screen saying so.
    final Widget interactive;
    switch (widget.mode) {
      case VoiceTalkMode.hold:
        interactive = GestureDetector(
          onTapDown: (_) => widget.onBegin(),
          onTapUp: (_) => widget.onEnd(),
          onTapCancel: widget.onEnd,
          child: pulsing,
        );
        break;
      case VoiceTalkMode.doubleTap:
        interactive = GestureDetector(onDoubleTap: _toggle, child: pulsing);
        break;
      default:
        interactive = GestureDetector(onTap: _toggle, child: pulsing);
    }

    if (!widget.showLabel) return interactive;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        interactive,
        SizedBox(height: 6.h),
        // Reserves its own line so the row does not reflow when the label
        // swaps between "Tap to talk" and "Tap to send" mid-conversation.
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 180),
          child: Text(
            label,
            key: ValueKey(label),
            style: GoogleFonts.inter(
              color: widget.capturing
                  ? widget.activeColor
                  : Colors.white.withValues(alpha: 0.85),
              fontSize: 11.5.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
