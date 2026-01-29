import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:animated_flip_counter/animated_flip_counter.dart';

/// Animated balance counter widget with Revolut-style rolling digits
/// Digits fall/roll from top to bottom as the value changes
class AnimatedBalanceCounter extends StatefulWidget {
  final double balance;
  final String currencySymbol;
  final TextStyle? style;
  final Duration duration;
  final Duration startDelay;
  final Curve curve;

  const AnimatedBalanceCounter({
    super.key,
    required this.balance,
    required this.currencySymbol,
    this.style,
    this.duration = const Duration(seconds: 3), // 3 seconds for visible animation
    this.startDelay = const Duration(milliseconds: 500), // Small delay so user sees dashboard first
    this.curve = Curves.easeOutCubic,
  });

  @override
  State<AnimatedBalanceCounter> createState() => _AnimatedBalanceCounterState();
}

class _AnimatedBalanceCounterState extends State<AnimatedBalanceCounter> {
  double _displayBalance = 0;
  double _previousBalance = 0;
  bool _isIncreasing = true;
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();
    _displayBalance = widget.balance;
    _previousBalance = widget.balance;
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

  const CompactAnimatedBalance({
    super.key,
    required this.balance,
    required this.currencySymbol,
    this.fontSize = 28,
    this.color,
    this.duration = const Duration(seconds: 3), // 3 seconds for visible animation
    this.startDelay = const Duration(milliseconds: 500), // Small delay so user sees dashboard first
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
                duration: widget.duration,
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
