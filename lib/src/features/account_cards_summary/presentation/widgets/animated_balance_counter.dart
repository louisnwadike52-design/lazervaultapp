import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:just_audio/just_audio.dart';

import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/panic_balance_service.dart';
import 'package:lazervault/core/services/haptics_service.dart';

/// Repeated haptic pulses for the life of a balance-roll animation — the
/// vibration counterpart to the money-counting sound. Fires a pulse every
/// ~180ms until [duration] elapses (the timer is self-cancelling), so it reads
/// as a continuous "counting" buzz on devices whose only API is discrete taps.
Timer _runAnimationVibration(Duration duration) {
  Haptics.success();
  final end = DateTime.now().add(duration);
  return Timer.periodic(const Duration(milliseconds: 180), (t) {
    if (DateTime.now().isAfter(end)) {
      t.cancel();
      return;
    }
    Haptics.keyTap();
  });
}

/// Animated balance counter widget with Revolut-style rolling digits
/// Digits fall/roll from top to bottom as the value changes
class AnimatedBalanceCounter extends StatefulWidget {
  final double balance;
  final String currencySymbol;
  final TextStyle? style;
  final Duration duration;
  final Duration startDelay;
  final Curve curve;

  /// When true, a money-counting sound plays while the balance rolls UP
  /// (a credit). Toggled by the user in Security → Panic Balance settings.
  final bool enableSound;

  const AnimatedBalanceCounter({
    super.key,
    required this.balance,
    required this.currencySymbol,
    this.style,
    this.duration = const Duration(seconds: 3), // 3 seconds for visible animation
    this.startDelay = const Duration(milliseconds: 500), // Small delay so user sees dashboard first
    this.curve = Curves.easeOutCubic,
    this.enableSound = false,
  });

  @override
  State<AnimatedBalanceCounter> createState() => _AnimatedBalanceCounterState();
}

class _AnimatedBalanceCounterState extends State<AnimatedBalanceCounter> {
  double _displayBalance = 0;
  double _previousBalance = 0;
  bool _isIncreasing = true;
  bool _isAnimating = false;
  AudioPlayer? _sfx;

  @override
  void initState() {
    super.initState();
    _displayBalance = widget.balance;
    _previousBalance = widget.balance;
  }

  @override
  void dispose() {
    _sfx?.dispose();
    super.dispose();
  }

  /// Play the money-counting riffle for the duration of the roll (looped short
  /// tick), then stop. Best-effort: audio init/playback failures never break the
  /// balance render.
  Future<void> _playMoneySound() async {
    try {
      final player = _sfx ??= AudioPlayer();
      await player.setLoopMode(LoopMode.all);
      await player.setAsset(serviceLocator<PanicBalanceService>().soundChoice);
      await player.setVolume(0.6);
      await player.seek(Duration.zero);
      unawaited(player.play());
      Future.delayed(widget.duration, () async {
        try {
          await _sfx?.stop();
        } catch (_) {}
      });
    } catch (_) {
      // ignore — sound is a nice-to-have, never a hard dependency
    }
  }

  @override
  void didUpdateWidget(AnimatedBalanceCounter oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.balance != widget.balance) {
      _previousBalance = _displayBalance;
      _isIncreasing = widget.balance > _previousBalance;

      // Delay the animation start so user sees the dashboard first
      Future.delayed(widget.startDelay, () {
        if (mounted) {
          setState(() {
            _isAnimating = true;
            _displayBalance = widget.balance;
          });

          // Money-counting sound only on a CREDIT (rolling up), when enabled.
          if (widget.enableSound && _isIncreasing) {
            _playMoneySound();
          }

          // Reset animating flag after animation completes
          Future.delayed(widget.duration, () {
            if (mounted) {
              setState(() {
                _isAnimating = false;
              });
            }
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final defaultStyle = TextStyle(
      color: Colors.white,
      fontSize: 28.sp,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.5,
    );

    final textStyle = widget.style ?? defaultStyle;

    // Determine color based on animation state
    Color displayColor = textStyle.color ?? Colors.white;
    if (_isAnimating) {
      displayColor = _isIncreasing
          ? Colors.greenAccent.withValues(alpha: 0.9)
          : Colors.redAccent.withValues(alpha: 0.9);
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Currency symbol
        Text(
          widget.currencySymbol,
          style: textStyle.copyWith(color: displayColor),
        ),
        // Animated flip counter - Revolut style rolling digits
        AnimatedFlipCounter(
          value: _displayBalance,
          duration: widget.duration,
          curve: widget.curve,
          fractionDigits: 2,
          thousandSeparator: ',',
          textStyle: textStyle.copyWith(color: displayColor),
        ),
        // Show direction indicator during animation
        if (_isAnimating) ...[
          SizedBox(width: 8.w),
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 300),
            builder: (context, value, child) {
              return Opacity(
                opacity: value,
                child: Icon(
                  _isIncreasing
                      ? Icons.arrow_upward_rounded
                      : Icons.arrow_downward_rounded,
                  color: _isIncreasing ? Colors.greenAccent : Colors.redAccent,
                  size: 20.sp,
                ),
              );
            },
          ),
        ],
      ],
    );
  }
}

/// A more compact version for smaller displays with Revolut-style animation
class CompactAnimatedBalance extends StatefulWidget {
  final double balance;
  final String currencySymbol;
  final double fontSize;
  final Color? color;
  final Duration duration;
  final Duration startDelay;

  /// Play the money-counting sound while rolling UP (a credit), when enabled.
  final bool enableSound;

  /// Vibrate while the balance-change animation plays, when enabled (the
  /// vibration counterpart to [enableSound]; user toggle in Panic Balance).
  final bool enableVibration;

  /// When false, balance changes apply INSTANTLY — no roll/flip animation, no
  /// start delay, no pulse, no sound. Used for the panic/decoy balance so the
  /// camouflage amount shows immediately on login instead of counting toward
  /// it, AND so a real→decoy switch never rolls THROUGH the real balance and
  /// briefly leaks it to someone watching.
  final bool animate;

  const CompactAnimatedBalance({
    super.key,
    required this.balance,
    required this.currencySymbol,
    this.fontSize = 28,
    this.color,
    this.duration = const Duration(seconds: 3), // 3 seconds for visible animation
    this.startDelay = const Duration(milliseconds: 500), // Small delay so user sees dashboard first
    this.enableSound = false,
    this.enableVibration = false,
    this.animate = true,
  });

  @override
  State<CompactAnimatedBalance> createState() => _CompactAnimatedBalanceState();
}

class _CompactAnimatedBalanceState extends State<CompactAnimatedBalance>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  double _displayBalance = 0;
  double _previousBalance = 0;
  bool _isIncreasing = true;
  bool _isAnimating = false;
  AudioPlayer? _sfx;
  Timer? _vibrationTimer;

  Future<void> _playMoneySound() async {
    try {
      final player = _sfx ??= AudioPlayer();
      await player.setLoopMode(LoopMode.all);
      await player.setAsset(serviceLocator<PanicBalanceService>().soundChoice);
      await player.setVolume(0.6);
      await player.seek(Duration.zero);
      unawaited(player.play());
      Future.delayed(widget.duration, () async {
        try {
          await _sfx?.stop();
        } catch (_) {}
      });
    } catch (_) {
      // best-effort — sound never blocks the balance render
    }
  }

  @override
  void initState() {
    super.initState();
    _displayBalance = widget.balance;
    _previousBalance = widget.balance;

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _pulseAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.08), weight: 30),
      TweenSequenceItem(tween: Tween(begin: 1.08, end: 1.0), weight: 70),
    ]).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void didUpdateWidget(CompactAnimatedBalance oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.balance != widget.balance) {
      // Panic/decoy (or any non-animated) mode: snap instantly — no roll, no
      // delay, no pulse, no sound. This is what makes the panic balance show
      // immediately on login with no "countdown", and prevents a real→decoy
      // roll from counting through (and leaking) the real balance.
      if (!widget.animate) {
        setState(() {
          _isAnimating = false;
          _previousBalance = widget.balance;
          _displayBalance = widget.balance;
        });
        return;
      }

      _previousBalance = _displayBalance;
      _isIncreasing = widget.balance > _previousBalance;

      // Delay the animation start so user sees the dashboard first
      Future.delayed(widget.startDelay, () {
        if (mounted) {
          setState(() {
            _isAnimating = true;
            _displayBalance = widget.balance;
          });

          // Pulse animation at the start
          _pulseController.forward(from: 0);

          // Money-counting sound only on a CREDIT (rolling up), when enabled.
          if (widget.enableSound && _isIncreasing) {
            _playMoneySound();
          }
          // Vibration accompanies ANY animated balance change, when enabled.
          if (widget.enableVibration) {
            _vibrationTimer?.cancel();
            _vibrationTimer = _runAnimationVibration(widget.duration);
          }

          // Reset animating flag after animation completes
          Future.delayed(widget.duration, () {
            if (mounted) {
              setState(() {
                _isAnimating = false;
              });
            }
          });
        }
      });
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _sfx?.dispose();
    _vibrationTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Determine color based on animation state
    final baseColor = widget.color ?? Colors.white;
    Color textColor = baseColor;
    if (_isAnimating) {
      // Use strong colors during animation: green for deposits, red for transfers
      textColor = _isIncreasing
          ? Colors.greenAccent
          : const Color(0xFFFF6B6B); // Soft red for transfers
    }

    return AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _isAnimating ? _pulseAnimation.value : 1.0,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.currencySymbol,
                style: TextStyle(
                  color: textColor,
                  fontSize: widget.fontSize.sp,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              AnimatedFlipCounter(
                value: _displayBalance,
                // Snap (no roll) when animation is disabled — e.g. panic decoy.
                duration: widget.animate ? widget.duration : Duration.zero,
                curve: Curves.easeOutCubic,
                fractionDigits: 2,
                thousandSeparator: ',',
                textStyle: TextStyle(
                  color: textColor,
                  fontSize: widget.fontSize.sp,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
