import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Status of field validation for real-time feedback
enum ValidationStatus {
  neutral, // No validation yet or field is empty
  valid, // Field passes validation
  invalid, // Field fails validation
}

/// Widget that displays validation status icon with animation
///
/// Shows:
/// - Neutral: No icon
/// - Valid: Green checkmark
/// - Invalid: Red X
class ValidationStatusIcon extends StatefulWidget {
  final ValidationStatus status;
  final double size;

  const ValidationStatusIcon({
    super.key,
    required this.status,
    this.size = 20,
  });

  @override
  State<ValidationStatusIcon> createState() => _ValidationStatusIconState();
}

class _ValidationStatusIconState extends State<ValidationStatusIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  ValidationStatus _previousStatus = ValidationStatus.neutral;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );
  }

  @override
  void didUpdateWidget(ValidationStatusIcon oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Animate when status changes from neutral to valid/invalid
    if (widget.status != oldWidget.status &&
        oldWidget.status == ValidationStatus.neutral &&
        widget.status != ValidationStatus.neutral) {
      _controller.forward(from: 0.0);
    } else if (widget.status != oldWidget.status &&
        widget.status == ValidationStatus.neutral) {
      _controller.reverse();
    } else if (widget.status != oldWidget.status &&
        widget.status != ValidationStatus.neutral) {
      _controller.forward(from: 0.5);
    }

    _previousStatus = oldWidget.status;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.status == ValidationStatus.neutral) {
      return SizedBox(width: widget.size.w, height: widget.size.w);
    }

    return ScaleTransition(
      scale: _scaleAnimation,
      child: Container(
        width: widget.size.w,
        height: widget.size.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: widget.status == ValidationStatus.valid
              ? Colors.green.withValues(alpha: 0.2)
              : Colors.red.withValues(alpha: 0.2),
        ),
        child: Icon(
          widget.status == ValidationStatus.valid
              ? Icons.check
              : Icons.close,
          size: (widget.size * 0.7).sp,
          color: widget.status == ValidationStatus.valid
              ? Colors.green
              : Colors.red,
        ),
      ),
    );
  }
}

/// Extension to get border color based on validation status
extension ValidationStatusExtension on ValidationStatus {
  Color getBorderColor({
    Color neutralColor = Colors.grey,
    Color? validColor,
    Color? invalidColor,
  }) {
    switch (this) {
      case ValidationStatus.neutral:
        return neutralColor;
      case ValidationStatus.valid:
        return validColor ?? Colors.green;
      case ValidationStatus.invalid:
        return invalidColor ?? Colors.red;
    }
  }

  Color? getBackgroundTint() {
    switch (this) {
      case ValidationStatus.neutral:
        return null;
      case ValidationStatus.valid:
        return Colors.green.withValues(alpha: 0.05);
      case ValidationStatus.invalid:
        return Colors.red.withValues(alpha: 0.05);
    }
  }
}
