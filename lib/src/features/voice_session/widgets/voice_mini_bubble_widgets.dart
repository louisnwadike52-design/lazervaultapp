part of 'voice_mini_bubble.dart';

/// Global controller for the floating voice mini-bubble.
///
/// When the full [VoiceCommandSheet] is minimized, it pops itself (WITHOUT
/// ending the app-scoped [VoiceSessionCubit]) and calls [show] to insert a
/// small draggable bubble on the ROOT overlay. The bubble mirrors live
/// speaking/listening state, re-opens the full sheet on tap, snaps to the
/// nearest screen edge when dragged, and auto-removes itself when the session
/// reaches a terminal state.
///
/// Usage:
/// ```dart
/// VoiceMiniBubbleController.instance.show(context, cubit: cubit);
/// VoiceMiniBubbleController.instance.hide();
/// ```
class VoiceMiniBubbleController {
  VoiceMiniBubbleController._();

  static final VoiceMiniBubbleController instance =
      VoiceMiniBubbleController._();

  OverlayEntry? _entry;

  /// Whether the bubble is currently on screen.
  bool get isShowing => _entry != null;

  /// Insert the floating bubble on the root overlay. No-op if already showing.
  /// [cubit] is the app-scoped voice session cubit the bubble watches; the
  /// optional [serviceName] / [conversationId] are re-used when the user taps
  /// the bubble to re-open the full sheet, so the same scoped session resumes.
  void show(
    BuildContext context, {
    required VoiceSessionCubit cubit,
    String? serviceName,
    String? conversationId,
    // When true (push-to-talk modes), dock a bottom BAR that keeps the talk
    // button live while minimized, instead of the floating draggable bubble.
    bool docked = false,
    String interactionMode = 'continuous',
  }) {
    if (_entry != null) return;
    final overlay = Overlay.of(context, rootOverlay: true);
    final entry = OverlayEntry(
      builder: (_) => docked
          ? _VoiceDockedBar(
              cubit: cubit,
              serviceName: serviceName,
              conversationId: conversationId,
              interactionMode: interactionMode,
            )
          : _VoiceMiniBubble(
              cubit: cubit,
              serviceName: serviceName,
              conversationId: conversationId,
            ),
    );
    _entry = entry;
    overlay.insert(entry);
  }

  /// Remove the floating bubble. Safe to call when not showing.
  void hide() {
    _entry?.remove();
    _entry = null;
  }
}

/// The draggable overlay child. Fills the screen with a [Stack] but only the
/// bubble itself is hit-testable, so the app behind it stays interactive.
class _VoiceMiniBubble extends StatefulWidget {
  final VoiceSessionCubit cubit;
  final String? serviceName;
  final String? conversationId;

  const _VoiceMiniBubble({
    required this.cubit,
    this.serviceName,
    this.conversationId,
  });

  @override
  State<_VoiceMiniBubble> createState() => _VoiceMiniBubbleState();
}

/// Docked bottom BAR shown when the sheet is minimized in a push-to-talk mode.
/// Unlike the floating bubble, it keeps the talk button LIVE while minimized so
/// the user can hold/tap to talk without re-opening the full sheet, and offers a
/// maximize control to return to the sheet. Session-scoped cubit survives the
/// minimize (same as the bubble), so the LiveKit room stays connected.
class _VoiceDockedBar extends StatefulWidget {
  final VoiceSessionCubit cubit;
  final String? serviceName;
  final String? conversationId;
  final String interactionMode; // 'hold' | 'tap' | 'double_tap'

  const _VoiceDockedBar({
    required this.cubit,
    required this.interactionMode,
    this.serviceName,
    this.conversationId,
  });

  @override
  State<_VoiceDockedBar> createState() => _VoiceDockedBarState();
}

class _VoiceDockedBarState extends State<_VoiceDockedBar> {
  /// How far the bar sits above the bottom of the screen, in logical pixels.
  ///
  /// Null means "wherever it docks by default" — kept null rather than
  /// pre-seeded so the resting position still follows the safe-area inset when
  /// the keyboard or a system bar changes it, right up until the user drags.
  double? _bottom;

  /// True only between pan start and pan end, so the bar tracks the finger with
  /// no animation while dragging but eases into place when released.
  bool _dragging = false;

  /// Used to measure the bar so it can be clamped on screen by its real height
  /// rather than a guess that goes wrong when the text wraps.
  final GlobalKey _barKey = GlobalKey();

  /// Measured height, falling back to the design height before first layout.
  double get _barHeight {
    final box = _barKey.currentContext?.findRenderObject() as RenderBox?;
    if (box != null && box.hasSize) return box.size.height;
    return 72;
  }

  /// The lowest the bar may sit: its default dock, clear of the home indicator.
  double _minBottom(MediaQueryData media) => media.padding.bottom + 12;

  /// The highest the bar may sit.
  ///
  /// Clamping matters more than it looks: a bar dragged under a notch or past
  /// the top edge cannot be grabbed again, and the only way back would be to
  /// end the call.
  double _maxBottom(MediaQueryData media) =>
      media.size.height - media.padding.top - _barHeight - 12;

  void _onPanStart(DragStartDetails _) => setState(() => _dragging = true);

  void _onPanUpdate(DragUpdateDetails details) {
    final media = MediaQuery.of(context);
    final lowest = _minBottom(media);
    final highest = _maxBottom(media);
    // Dragging DOWN (positive dy) reduces the distance from the bottom.
    final next = (_bottom ?? lowest) - details.delta.dy;
    setState(() =>
        _bottom = highest <= lowest ? lowest : next.clamp(lowest, highest));
  }

  void _onPanEnd(DragEndDetails _) {
    final media = MediaQuery.of(context);
    final lowest = _minBottom(media);
    final highest = _maxBottom(media);
    final current = _bottom ?? lowest;
    // Park at whichever edge is nearer instead of leaving the bar floating in
    // the middle, where it covers content wherever the finger happened to stop.
    // On a screen too short to hold the bar, `highest` falls below `lowest`;
    // the max() keeps the bottom dock rather than snapping off-screen.
    final snapped = (current - lowest) > (highest - current)
        ? max(lowest, highest)
        : lowest;
    setState(() {
      _dragging = false;
      _bottom = snapped;
    });
  }

  void _reopen() {
    VoiceMiniBubbleController.instance.hide();
    Get.bottomSheet(
      VoiceCommandSheet(
        serviceName: widget.serviceName,
        conversationId: widget.conversationId,
        skipActivationCheck: true,
      ),
      isScrollControlled: true,
      enableDrag: false,
      isDismissible: false,
      backgroundColor: Colors.transparent,
      enterBottomSheetDuration: const Duration(milliseconds: 300),
      exitBottomSheetDuration: const Duration(milliseconds: 200),
    );
  }

  /// Delegates to the shared copy so the bubble, the full sheet and settings
  /// cannot drift — this file used to say "Double-tap to talk" while the sheet
  /// said "Double-tap" for the very same mode.
  String _hintFor({required bool capturing}) =>
      VoiceTalkMode.action(widget.interactionMode, capturing: capturing);

  @override
  Widget build(BuildContext context) {
    const active = Color(0xFF10B981);
    final media = MediaQuery.of(context);
    final bottom = _bottom ?? _minBottom(media);

    return BlocListener<VoiceSessionCubit, VoiceSessionState>(
      bloc: widget.cubit,
      listenWhen: (_, s) =>
          s is VoiceSessionEnded ||
          s is VoiceSessionDisconnected ||
          s is VoiceSessionClosedByAgent ||
          s is VoiceSessionInitial ||
          s is VoiceSessionPinRequired,
      listener: (_, state) {
        // A PIN prompt can't render on the bar → re-open the sheet (its mount-time
        // recovery shows the secure PIN sheet). Any other terminal state removes us.
        if (state is VoiceSessionPinRequired) {
          _reopen();
        } else {
          VoiceMiniBubbleController.instance.hide();
        }
      },
      child: Stack(
        children: [
          // Vertical only. The bar spans the full width (left AND right are
          // pinned), so there is nowhere for it to go sideways — moving it up
          // and down is what gets it off whatever it is covering.
          AnimatedPositioned(
            duration: Duration(milliseconds: _dragging ? 0 : 180),
            curve: Curves.easeOut,
            left: 12,
            right: 12,
            bottom: bottom,
            child: Material(
              color: Colors.transparent,
              // Pan lives on the bar body; the mic keeps its own gestures.
              // Flutter's gesture arena settles the overlap: a press that stays
              // put is a talk press, and one that travels past touch slop
              // becomes a drag and cancels the talk — which is the honest
              // reading of "the user dragged away instead of speaking".
              // onTapCancel is already wired to end the capture, so the mic
              // cannot be left open by a drag that started on it.
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onPanStart: _onPanStart,
                onPanUpdate: _onPanUpdate,
                onPanEnd: _onPanEnd,
                child: Container(
                  key: _barKey,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1B1626),
                    borderRadius: BorderRadius.circular(28),
                    border:
                        Border.all(color: Colors.white.withValues(alpha: 0.10)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withValues(alpha: 0.35),
                          blurRadius: 18,
                          offset: const Offset(0, 6)),
                    ],
                  ),
                  child: BlocBuilder<VoiceSessionCubit, VoiceSessionState>(
                    bloc: widget.cubit,
                    builder: (context, state) {
                      final capturing = widget.cubit.isPttCapturing;

                      // The same control as the full sheet, compact: the
                      // pulse is what makes the mic readable as "press me" in a
                      // floating bubble where the whole surface is also tappable
                      // (a tap anywhere else reopens the call).
                      final talkButton = VoiceTalkButton(
                        mode: widget.interactionMode,
                        capturing: capturing,
                        onBegin: widget.cubit.pttBegin,
                        onEnd: widget.cubit.pttEnd,
                        showLabel: false,
                        diameter: 44,
                      );

                      return Row(
                        children: [
                          talkButton,
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Voice assistant',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600)),
                                Text(
                                  _hintFor(capturing: capturing),
                                  style: TextStyle(
                                      color: capturing
                                          ? active
                                          : Colors.white.withValues(alpha: 0.6),
                                      fontSize: 11),
                                ),
                              ],
                            ),
                          ),
                          // Drag affordance. Without it the bar reads as fixed
                          // furniture, and nobody discovers they can move it
                          // off whatever it is covering.
                          Icon(Icons.drag_handle_rounded,
                              color: Colors.white.withValues(alpha: 0.35),
                              size: 18),
                          IconButton(
                            onPressed: _reopen,
                            icon: const Icon(Icons.open_in_full_rounded,
                                color: Colors.white, size: 20),
                            tooltip: 'Open',
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
