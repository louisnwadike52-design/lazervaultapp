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
class _VoiceDockedBar extends StatelessWidget {
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

  void _reopen() {
    VoiceMiniBubbleController.instance.hide();
    Get.bottomSheet(
      VoiceCommandSheet(
        serviceName: serviceName,
        conversationId: conversationId,
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

  String get _hint {
    switch (interactionMode) {
      case 'hold':
        return 'Hold to talk';
      case 'double_tap':
        return 'Double-tap to talk';
      case 'tap':
      default:
        return 'Tap to talk';
    }
  }

  @override
  Widget build(BuildContext context) {
    const accent = Color(0xFF5B45C9);
    const active = Color(0xFF10B981);
    final bottomInset = MediaQuery.of(context).padding.bottom;

    return BlocListener<VoiceSessionCubit, VoiceSessionState>(
      bloc: cubit,
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
          Positioned(
            left: 12,
            right: 12,
            bottom: bottomInset + 12,
            child: Material(
              color: Colors.transparent,
              child: Container(
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
                  bloc: cubit,
                  builder: (context, state) {
                    final capturing = cubit.isPttCapturing;
                    final bg = capturing ? active : accent;

                    final talk = AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: bg.withValues(alpha: capturing ? 0.9 : 0.20),
                        border: Border.all(
                            color: bg.withValues(alpha: 0.6), width: 2),
                      ),
                      child: Icon(
                        capturing
                            ? Icons.graphic_eq_rounded
                            : Icons.mic_none_rounded,
                        color: capturing ? Colors.white : bg,
                        size: 22,
                      ),
                    );

                    void begin() => cubit.pttBegin();
                    void end() => cubit.pttEnd();
                    void toggle() => capturing ? end() : begin();

                    Widget talkButton;
                    switch (interactionMode) {
                      case 'hold':
                        talkButton = GestureDetector(
                          onTapDown: (_) => begin(),
                          onTapUp: (_) => end(),
                          onTapCancel: end,
                          child: talk,
                        );
                        break;
                      case 'double_tap':
                        talkButton =
                            GestureDetector(onDoubleTap: toggle, child: talk);
                        break;
                      case 'tap':
                      default:
                        talkButton =
                            GestureDetector(onTap: toggle, child: talk);
                    }

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
                                capturing ? 'Listening…' : _hint,
                                style: TextStyle(
                                    color: capturing
                                        ? active
                                        : Colors.white
                                            .withValues(alpha: 0.6),
                                    fontSize: 11),
                              ),
                            ],
                          ),
                        ),
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
        ],
      ),
    );
  }
}
