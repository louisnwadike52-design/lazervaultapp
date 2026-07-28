import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:lazervault/src/features/voice_session/cubit/voice_session_cubit.dart';
import 'package:lazervault/src/features/voice_session/cubit/voice_session_state.dart';
import 'package:lazervault/src/features/voice_session/widgets/voice_command_sheet.dart';

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
  }) {
    if (_entry != null) return;
    final overlay = Overlay.of(context, rootOverlay: true);
    final entry = OverlayEntry(
      builder: (_) => _VoiceMiniBubble(
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

class _VoiceMiniBubbleState extends State<_VoiceMiniBubble>
    with SingleTickerProviderStateMixin {
  // Drives the orb pulse + side-wave oscillation (independent of the sheet's
  // controllers, which are disposed once the sheet is popped to minimize).
  late final AnimationController _waveController;

  // Top-left position of the bubble. Null until the first build seeds it.
  Offset? _pos;

  static const double _margin = 12.0;

  @override
  void initState() {
    super.initState();
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();
  }

  @override
  void dispose() {
    _waveController.dispose();
    super.dispose();
  }

  double _bubbleSize(Size screen) => screen.width * 0.20;

  /// Re-open the full voice sheet with the same options and remove the bubble.
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

  /// Snap the bubble to the nearest horizontal edge on release, clamped inside
  /// the safe vertical bounds.
  void _snapToEdge(Size screen) {
    final pos = _pos;
    if (pos == null) return;
    final size = _bubbleSize(screen);
    final topInset = MediaQuery.of(context).padding.top + _margin;
    final bottomBound = screen.height - size - _margin;
    final center = pos.dx + size / 2;
    final toLeft = center < screen.width / 2;
    final x = toLeft ? _margin : screen.width - size - _margin;
    final y = pos.dy.clamp(topInset, bottomBound.clamp(topInset, screen.height));
    setState(() => _pos = Offset(x, y));
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    final size = _bubbleSize(screen);
    // Seed the initial position toward the lower-right, above the nav area.
    _pos ??= Offset(screen.width - size - 16, screen.height * 0.62);

    return BlocListener<VoiceSessionCubit, VoiceSessionState>(
      bloc: widget.cubit,
      listenWhen: (_, s) =>
          s is VoiceSessionEnded ||
          s is VoiceSessionDisconnected ||
          s is VoiceSessionClosedByAgent ||
          s is VoiceSessionInitial,
      // Session reached a terminal state — the bubble must auto-remove itself.
      listener: (_, __) => VoiceMiniBubbleController.instance.hide(),
      child: Stack(
        children: [
          Positioned(
            left: _pos!.dx,
            top: _pos!.dy,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: _reopen,
              onPanUpdate: (d) => setState(() => _pos = _pos! + d.delta),
              onPanEnd: (_) => _snapToEdge(screen),
              child: _buildBubble(size),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBubble(double size) {
    return BlocBuilder<VoiceSessionCubit, VoiceSessionState>(
      bloc: widget.cubit,
      builder: (context, state) {
        final cubit = widget.cubit;
        final isSpeaking = cubit.isAgentSpeaking;
        final isListening = state is VoiceSessionLocalUserSpeaking;
        final active = isSpeaking || isListening;
        final color = isSpeaking
            ? const Color(0xFF5B45C9)
            : isListening
                ? const Color(0xFF10B981)
                : const Color(0xFF3D2F8B);

        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFF1F1F1F),
            border: Border.all(color: color.withValues(alpha: 0.6), width: 2),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: active ? 0.4 : 0.22),
                blurRadius: 18,
                spreadRadius: 2,
              ),
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.45),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildWaves(leftSide: true, color: color, active: active, size: size),
              SizedBox(width: size * 0.05),
              _buildOrb(color, size),
              SizedBox(width: size * 0.05),
              _buildWaves(leftSide: false, color: color, active: active, size: size),
            ],
          ),
        );
      },
    );
  }

  /// Compact voice-waves flanking the mini orb — mirror of the full sheet's
  /// side waves, scaled to the bubble.
  Widget _buildWaves({
    required bool leftSide,
    required Color color,
    required bool active,
    required double size,
  }) {
    const int barCount = 3;
    final double maxH = size * 0.34;
    final double minH = size * 0.10;
    return AnimatedBuilder(
      animation: _waveController,
      builder: (context, _) {
        final phaseT = _waveController.value;
        return Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(barCount, (i) {
            final idx = leftSide ? (barCount - 1 - i) : i;
            final phase = idx * (pi / 2.5);
            final wave = sin(phaseT * 2 * pi + phase) * 0.5 + 0.5;
            final amp = active ? 1.0 : 0.2;
            final h = minH + (maxH - minH) * wave * amp;
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: size * 0.012),
              child: Container(
                width: size * 0.045,
                height: h,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: active ? 0.85 : 0.35),
                  borderRadius: BorderRadius.circular(size),
                ),
              ),
            );
          }),
        );
      },
    );
  }

  /// The central mini orb — the Nova avatar with a gentle pulse, mirroring the
  /// full sheet's avatar treatment.
  Widget _buildOrb(Color color, double size) {
    final d = size * 0.48;
    return AnimatedBuilder(
      animation: _waveController,
      builder: (context, _) {
        final t = _waveController.value;
        final scale = 1.0 + (sin(t * 2 * pi) * 0.5 + 0.5) * 0.06;
        return Transform.scale(
          scale: scale,
          child: Container(
            width: d,
            height: d,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: color.withValues(alpha: 0.7), width: 1.5),
            ),
            child: ClipOval(
              child: SvgPicture.asset(
                'assets/images/nova_rep.svg',
                fit: BoxFit.cover,
                placeholderBuilder: (_) => Container(
                  color: const Color(0xFF1F1F1F),
                  child: Icon(
                    Icons.support_agent_rounded,
                    color: color,
                    size: d * 0.5,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
