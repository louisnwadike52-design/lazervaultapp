import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Animated balance counter widget that smoothly transitions between values
/// Similar to Revolut's balance animation
class AnimatedBalanceCounter extends StatefulWidget {
  final double balance;
  final String currencySymbol;
  final TextStyle? style;
  final Duration duration;
  final Curve curve;

  const AnimatedBalanceCounter({
    super.key,
    required this.balance,
    required this.currencySymbol,
    this.style,
    this.duration = const Duration(milliseconds: 800),
    this.curve = Curves.easeOutCubic,
  });

  @override
  State<AnimatedBalanceCounter> createState() => _AnimatedBalanceCounterState();
}

class _AnimatedBalanceCounterState extends State<AnimatedBalanceCounter>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double _previousBalance = 0;
  double _currentBalance = 0;
  bool _isIncreasing = true;

  @override
  void initState() {
    super.initState();
    _currentBalance = widget.balance;
    _previousBalance = widget.balance;

    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _animation = Tween<double>(
      begin: _previousBalance,
      end: _currentBalance,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    ));
  }

  @override
  void didUpdateWidget(AnimatedBalanceCounter oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.balance != widget.balance) {
      _previousBalance = _currentBalance;
      _currentBalance = widget.balance;
      _isIncreasing = _currentBalance > _previousBalance;

      _animation = Tween<double>(
        begin: _previousBalance,
        end: _currentBalance,
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: widget.curve,
      ));

      _controller.reset();
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _formatBalance(double value) {
    // Format with thousands separator and 2 decimal places
    final parts = value.toStringAsFixed(2).split('.');
    final intPart = parts[0];
    final decPart = parts[1];

    // Add thousands separators
    final buffer = StringBuffer();
    final digits = intPart.replaceAll('-', '');
    final isNegative = intPart.startsWith('-');

    for (int i = 0; i < digits.length; i++) {
      if (i > 0 && (digits.length - i) % 3 == 0) {
        buffer.write(',');
      }
      buffer.write(digits[i]);
    }

    return '${isNegative ? '-' : ''}${buffer.toString()}.$decPart';
  }

  @override
  Widget build(BuildContext context) {
    final defaultStyle = TextStyle(
      color: Colors.white,
      fontSize: 28.sp,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.5,
    );

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final currentValue = _animation.value;
        final isAnimating = _controller.isAnimating;

        return Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            // Currency symbol
            Text(
              widget.currencySymbol,
              style: widget.style ?? defaultStyle,
            ),
            // Animated balance value
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 150),
              child: Text(
                _formatBalance(currentValue),
                key: ValueKey<String>(_formatBalance(currentValue)),
                style: (widget.style ?? defaultStyle).copyWith(
                  // Add subtle color tint during animation
                  color: isAnimating
                      ? (_isIncreasing
                          ? Colors.greenAccent.withValues(alpha: 0.9)
                          : Colors.redAccent.withValues(alpha: 0.9))
                      : (widget.style?.color ?? Colors.white),
                ),
              ),
            ),
            // Show direction indicator during animation
            if (isAnimating) ...[
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
      },
    );
  }
}

/// A more compact version for smaller displays
class CompactAnimatedBalance extends StatefulWidget {
  final double balance;
  final String currencySymbol;
  final double fontSize;
  final Color? color;
  final Duration duration;

  const CompactAnimatedBalance({
    super.key,
    required this.balance,
    required this.currencySymbol,
    this.fontSize = 28,
    this.color,
    this.duration = const Duration(milliseconds: 600),
  });

  @override
  State<CompactAnimatedBalance> createState() => _CompactAnimatedBalanceState();
}

class _CompactAnimatedBalanceState extends State<CompactAnimatedBalance>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _balanceAnimation;
  late Animation<double> _pulseAnimation;
  double _previousBalance = 0;
  bool _isIncreasing = true;

  @override
  void initState() {
    super.initState();
    _previousBalance = widget.balance;

    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _setupAnimations();
  }

  void _setupAnimations() {
    _balanceAnimation = Tween<double>(
      begin: _previousBalance,
      end: widget.balance,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));

    _pulseAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.05), weight: 30),
      TweenSequenceItem(tween: Tween(begin: 1.05, end: 1.0), weight: 70),
    ]).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void didUpdateWidget(CompactAnimatedBalance oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.balance != widget.balance) {
      _previousBalance = oldWidget.balance;
      _isIncreasing = widget.balance > _previousBalance;
      _setupAnimations();
      _controller.reset();
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _formatBalance(double value) {
    final parts = value.toStringAsFixed(2).split('.');
    final intPart = parts[0];
    final decPart = parts[1];

    final buffer = StringBuffer();
    final digits = intPart.replaceAll('-', '');
    final isNegative = intPart.startsWith('-');

    for (int i = 0; i < digits.length; i++) {
      if (i > 0 && (digits.length - i) % 3 == 0) {
        buffer.write(',');
      }
      buffer.write(digits[i]);
    }

    return '${isNegative ? '-' : ''}${buffer.toString()}.$decPart';
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final isAnimating = _controller.isAnimating;

        // Determine color based on animation state
        Color textColor = widget.color ?? Colors.white;
        if (isAnimating) {
          textColor = _isIncreasing
              ? Color.lerp(textColor, Colors.greenAccent, _controller.value * 0.5)!
              : Color.lerp(textColor, Colors.redAccent, _controller.value * 0.5)!;
        }

        return Transform.scale(
          scale: _pulseAnimation.value,
          child: Text(
            '${widget.currencySymbol}${_formatBalance(_balanceAnimation.value)}',
            style: TextStyle(
              color: textColor,
              fontSize: widget.fontSize.sp,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        );
      },
    );
  }
}
