import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import '../cubit/voice_transaction_cubit.dart';

// ==============================================================================
// Voice Action Feedback Widgets
// ==============================================================================

/// Main voice action feedback widget that reacts to state changes
class VoiceActionFeedback extends StatelessWidget {
  final Widget child;
  final VoidCallback? onRetry;
  final VoidCallback? onCancel;

  const VoiceActionFeedback({
    super.key,
    required this.child,
    this.onRetry,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VoiceTransactionCubit, VoiceTransactionState>(
      listener: (context, state) {
        // Handle state-based side effects
        if (state.isSuccess) {
          _showSuccessSnackBar(context, state);
        } else if (state.isError && state.errorMessage != null) {
          _showErrorSnackBar(context, state.errorMessage!);
        } else if (state.isTimeout) {
          _showTimeoutSnackBar(context);
        } else if (state.isFatal) {
          _showFatalErrorDialog(context, state);
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            child,
            if (state.isListening)
              const Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: VoiceListeningIndicator(),
              ),
            if (state.isProcessing || state.isVerifying || state.isExecuting)
              const VoiceProcessingOverlay(),
            if (state.isAwaitingPin)
              const VoicePinPromptOverlay(),
            if (state.isPendingConfirmation && state.pendingConfirmation != null)
              VoiceConfirmationOverlay(
                confirmation: state.pendingConfirmation!,
                onConfirm: () => context.read<VoiceTransactionCubit>().confirmTransaction(),
                onCancel: () => context.read<VoiceTransactionCubit>().cancelTransaction(),
              ),
            if (state.isAudioActive && state.hasAudio)
              Positioned(
                bottom: 100,
                left: 0,
                right: 0,
                child: VoiceAudioVisualizer(level: state.audioLevel),
              ),
          ],
        );
      },
    );
  }

  bool get isAudioActive => true;

  void _showSuccessSnackBar(BuildContext context, VoiceTransactionState state) {
    final message = state.result?.message ?? 'Transaction completed successfully';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
        action: state.result?.transactionReference != null
            ? SnackBarAction(
                label: 'View',
                textColor: Colors.white,
                onPressed: () {
                  // Navigate to receipt
                },
              )
            : null,
      ),
    );
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 4),
        action: SnackBarAction(
          label: 'Retry',
          textColor: Colors.white,
          onPressed: onRetry ?? () {},
        ),
      ),
    );
  }

  void _showTimeoutSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Operation timed out. Please try again.'),
        backgroundColor: Colors.orange,
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 3),
      ),
    );
  }

  void _showFatalErrorDialog(BuildContext context, VoiceTransactionState state) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Something went wrong'),
        content: Text(
          state.errorMessage ?? 'An unexpected error occurred.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              onCancel?.call();
            },
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

// ==============================================================================
// Listening Indicator
// ==============================================================================

class VoiceListeningIndicator extends StatelessWidget {
  const VoiceListeningIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 4,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.red.withValues(alpha: 0.3),
            Colors.red,
            Colors.red.withValues(alpha: 0.3),
          ],
        ),
      ),
      child: const _ListeningPulseAnimation(),
    );
  }
}

class _ListeningPulseAnimation extends StatefulWidget {
  const _ListeningPulseAnimation();

  @override
  State<_ListeningPulseAnimation> createState() => _ListeningPulseAnimationState();
}

class _ListeningPulseAnimationState extends State<_ListeningPulseAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          height: 4,
          decoration: BoxDecoration(
            color: Colors.red.withValues(alpha: _animation.value),
            boxShadow: [
              BoxShadow(
                color: Colors.red.withValues(alpha: _animation.value * 0.5),
                blurRadius: 8,
                spreadRadius: 2,
              ),
            ],
          ),
        );
      },
    );
  }
}

// ==============================================================================
// Processing Overlay
// ==============================================================================

class VoiceProcessingOverlay extends StatelessWidget {
  const VoiceProcessingOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VoiceTransactionCubit, VoiceTransactionState>(
      builder: (context, state) {
        String message;
        IconData icon;
        Color color;

        if (state.isProcessing) {
          message = 'Processing your request...';
          icon = Icons.psychology_outlined;
          color = Colors.blue;
        } else if (state.isVerifying) {
          message = 'Verifying your voice...';
          icon = Icons.verified_user_outlined;
          color = Colors.purple;
        } else if (state.isExecuting) {
          message = 'Executing transaction...';
          icon = Icons.sync_outlined;
          color = Colors.orange;
        } else if (state.isRetrying) {
          message = 'Retrying...';
          icon = Icons.refresh_outlined;
          color = Colors.amber;
        } else {
          message = 'Processing...';
          icon = Icons.hourglass_empty_outlined;
          color = Colors.grey;
        }

        return Material(
          color: Colors.black.withValues(alpha: 0.7),
          child: Center(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 32.w),
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: color.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _ProcessingSpinner(color: color),
                  SizedBox(height: 20.h),
                  Icon(icon, color: color, size: 32.sp),
                  SizedBox(height: 16.h),
                  Text(
                    message,
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  if (state.context != null) ...[
                    SizedBox(height: 8.h),
                    Text(
                      _getElapsedTime(state.context!.startedAt),
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String _getElapsedTime(DateTime started) {
    final elapsed = DateTime.now().difference(started);
    if (elapsed.inSeconds < 60) {
      return '${elapsed.inSeconds}s';
    }
    return '${elapsed.inMinutes}:${(elapsed.inSeconds % 60).toString().padLeft(2, '0')}';
  }
}

class _ProcessingSpinner extends StatefulWidget {
  final Color color;

  const _ProcessingSpinner({required this.color});

  @override
  State<_ProcessingSpinner> createState() => _ProcessingSpinnerState();
}

class _ProcessingSpinnerState extends State<_ProcessingSpinner>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48.sp,
      height: 48.sp,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(widget.color),
        strokeWidth: 3,
      ),
    );
  }
}

// ==============================================================================
// PIN Prompt Overlay
// ==============================================================================

class VoicePinPromptOverlay extends StatefulWidget {
  const VoicePinPromptOverlay({super.key});

  @override
  State<VoicePinPromptOverlay> createState() => _VoicePinPromptOverlayState();
}

class _VoicePinPromptOverlayState extends State<VoicePinPromptOverlay> {
  final TextEditingController _pinController = TextEditingController();
  bool _isObscured = true;

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  void _submitPin() {
    if (_pinController.length == 4) {
      // TODO: Submit PIN to backend
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withValues(alpha: 0.7),
      child: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 32.w),
          padding: EdgeInsets.all(24.w),
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: Colors.purple.withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.lock_outlined,
                color: Colors.purple,
                size: 40.sp,
              ),
              SizedBox(height: 16.h),
              Text(
                'PIN Required',
                style: GoogleFonts.inter(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'For your security, please enter your 4-digit PIN to complete this transaction.',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  color: Colors.grey[400],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.h),
              Container(
                width: 200.w,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF0A0A0A),
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: Colors.grey[800]!),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _pinController,
                        obscureText: _isObscured,
                        maxLength: 4,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 8,
                        ),
                        decoration: const InputDecoration(
                          counterText: '',
                          border: InputBorder.none,
                        ),
                        onChanged: (_) => setState(() {}),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => setState(() => _isObscured = !_isObscured),
                      child: Icon(
                        _isObscured ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        context.read<VoiceTransactionCubit>().cancelTransaction();
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.grey[400],
                        side: BorderSide(color: Colors.grey[800]!),
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      child: Text('Cancel', style: GoogleFonts.inter(fontSize: 14.sp)),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: _pinController.length == 4 ? _submitPin : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        foregroundColor: Colors.white,
                        disabledBackgroundColor: Colors.grey[800],
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      child: Text(
                        'Confirm',
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==============================================================================
// Confirmation Overlay
// ==============================================================================

class VoiceConfirmationOverlay extends StatefulWidget {
  final VoiceConfirmationRequest confirmation;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const VoiceConfirmationOverlay({
    super.key,
    required this.confirmation,
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  State<VoiceConfirmationOverlay> createState() => _VoiceConfirmationOverlayState();
}

class _VoiceConfirmationOverlayState extends State<VoiceConfirmationOverlay> {
  late Timer _timeoutTimer;
  int _remainingSeconds = 0;

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.confirmation.timeoutSeconds;
    _startTimeoutTimer();
  }

  @override
  void dispose() {
    _timeoutTimer.cancel();
    super.dispose();
  }

  void _startTimeoutTimer() {
    _timeoutTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      setState(() {
        _remainingSeconds--;
      });

      if (_remainingSeconds <= 0) {
        timer.cancel();
        widget.onCancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withValues(alpha: 0.8),
      child: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 24.w),
          constraints: BoxConstraints(maxWidth: 400.w),
          padding: EdgeInsets.all(24.w),
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: Colors.orange.withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Timeout indicator
              Container(
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(2),
                ),
                child: FractionallySizedBox(
                  widthFactor: _remainingSeconds / widget.confirmation.timeoutSeconds,
                  alignment: Alignment.centerLeft,
                  child: Container(
                    decoration: BoxDecoration(
                      color: _remainingSeconds <= 10 ? Colors.red : Colors.orange,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Icon(
                Icons.info_outline,
                color: Colors.orange,
                size: 40.sp,
              ),
              SizedBox(height: 16.h),
              Text(
                widget.confirmation.title,
                style: GoogleFonts.inter(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.h),
              Text(
                widget.confirmation.message,
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  color: Colors.grey[400],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.h),
              _buildDetailsCard(),
              SizedBox(height: 24.h),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: widget.onCancel,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.grey[400],
                        side: BorderSide(color: Colors.grey[800]!),
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      child: Text('Cancel', style: GoogleFonts.inter(fontSize: 14.sp)),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: widget.onConfirm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      child: Text(
                        'Confirm',
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              Text(
                'Expires in $_remainingSeconds seconds',
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailsCard() {
    final details = widget.confirmation.details;
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF0A0A0A),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final entry in details.entries)
            if (entry.key != 'type' && entry.value != null)
              Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _formatKey(entry.key),
                      style: GoogleFonts.inter(
                        fontSize: 13.sp,
                        color: Colors.grey[400],
                      ),
                    ),
                    Text(
                      _formatValue(entry.value),
                      style: GoogleFonts.inter(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
        ],
      ),
    );
  }

  String _formatKey(String key) {
    return key
        .replaceAll('_', ' ')
        .split(' ')
        .map((word) => word.isEmpty ? '' : '${word[0].toUpperCase()}${word.substring(1)}')
        .join(' ');
  }

  String _formatValue(dynamic value) {
    if (value is double) {
      return '₦${value.toStringAsFixed(2)}';
    } else if (value is int && value > 1000) {
      return '₦${(value / 100).toStringAsFixed(2)}';
    }
    return value.toString();
  }
}

// ==============================================================================
// Audio Visualizer
// ==============================================================================

class VoiceAudioVisualizer extends StatelessWidget {
  final double level;

  const VoiceAudioVisualizer({super.key, required this.level});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        size: Size(200.w, 60.h),
        painter: _AudioVisualizerPainter(level: level),
      ),
    );
  }
}

class _AudioVisualizerPainter extends CustomPainter {
  final double level;

  _AudioVisualizerPainter({required this.level});

  @override
  void paint(Canvas canvas, Size size) {
    final barCount = 20;
    final barWidth = size.width / barCount - 2;
    final maxBarHeight = size.height;

    for (int i = 0; i < barCount; i++) {
      // Create wave effect based on position and level
      final wave = (i / barCount) * 3.14159 * 2;
      final heightMod = (1 + (wave * 0.3).sin()) * 0.5 + 0.5;
      final barHeight = maxBarHeight * level * heightMod;

      final x = i * (barWidth + 2);
      final y = (size.height - barHeight) / 2;

      final paint = Paint()
        ..color = Colors.purple.withValues(
          alpha: 0.3 + (level * 0.7).clamp(0, 1),
        )
        ..style = PaintingStyle.fill;

      final rRect = RRect.fromRectAndRadius(
        Rect.fromLTWH(x, y, barWidth, barHeight),
        Radius.circular(barWidth / 2),
      );

      canvas.drawRRect(rRect, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _AudioVisualizerPainter oldDelegate) {
    return oldDelegate.level != level;
  }
}

// ==============================================================================
// Voice Status Badge
// ==============================================================================

class VoiceStatusBadge extends StatelessWidget {
  final VoiceActionState state;

  const VoiceStatusBadge({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final (label, color, icon) = _getStateInfo();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14.sp, color: color),
            SizedBox(width: 4.w),
          ],
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  (String, Color, IconData?) _getStateInfo() {
    switch (state) {
      case VoiceActionState.idle:
        return ('Ready', Colors.grey, Icons.mic);
      case VoiceActionState.listening:
        return ('Listening...', Colors.red, Icons.mic);
      case VoiceActionState.processing:
        return ('Processing...', Colors.blue, Icons.psychology);
      case VoiceActionState.verifying:
        return ('Verifying...', Colors.purple, Icons.verified_user);
      case VoiceActionState.awaitingPin:
        return ('PIN Required', Colors.orange, Icons.lock);
      case VoiceActionState.executing:
        return ('Executing...', Colors.orange, Icons.sync);
      case VoiceActionState.pendingConfirmation:
        return ('Confirm?', Colors.orange, Icons.help);
      case VoiceActionState.success:
        return ('Success', Colors.green, Icons.check_circle);
      case VoiceActionState.error:
        return ('Error', Colors.red, Icons.error);
      case VoiceActionState.fatal:
        return ('Failed', Colors.red, Icons.error);
      case VoiceActionState.cancelled:
        return ('Cancelled', Colors.grey, Icons.cancel);
      case VoiceActionState.timeout:
        return ('Timed Out', Colors.orange, Icons.timer);
      case VoiceActionState.retrying:
        return ('Retrying...', Colors.amber, Icons.refresh);
    }
  }
}
