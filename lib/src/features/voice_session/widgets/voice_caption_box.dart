import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/src/features/voice_session/cubit/voice_session_cubit.dart';
import 'package:lazervault/src/features/voice_session/cubit/voice_session_state.dart';
part 'voice_caption_box_widgets.dart';


/// Visual feedback state indicator for transfer flow.
///
/// Shows animated progress through the transfer stages:
/// 1. Searching/Processing
/// 2. Review Details
/// 3. Enter PIN
/// 4. Processing Payment
/// 5. Complete
///
/// Edge cases handled:
/// - State transitions during error
/// - Cancelled transactions
/// - Multiple rapid state changes
/// - Widget disposal during animation
class VoiceTransferVisualFeedback extends StatefulWidget {
  final VoiceSessionState state;

  const VoiceTransferVisualFeedback({
    super.key,
    required this.state,
  });

  @override
  State<VoiceTransferVisualFeedback> createState() => _VoiceTransferVisualFeedbackState();
}

class _VoiceTransferVisualFeedbackState extends State<VoiceTransferVisualFeedback>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _animationController.forward();
  }

  @override
  void didUpdateWidget(VoiceTransferVisualFeedback oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Restart animation on state change
    _animationController.reset();
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Only show for transfer-related states.
    //
    // NOTE: VoiceSessionPinRequired is intentionally EXCLUDED here. The PIN
    // entry is owned by exactly ONE path — the canonical TransactionPinMixin
    // bottom sheet driven from VoiceCommandSheet (`_showPinEntrySheet`). This
    // widget previously also reacted to the PIN state, which competed with /
    // obscured that single path. It now only renders the transfer PROGRESS
    // stepper and stays out of the PIN flow entirely.
    final isTransferState = widget.state is VoiceSessionUserSearchRequired ||
        widget.state is VoiceSessionTransferConfirmation ||
        widget.state is VoiceSessionTransactionSuccess ||
        widget.state is VoiceSessionTransactionError ||
        widget.state is VoiceSessionAgentProcessing;

    if (!isTransferState) {
      return const SizedBox.shrink();
    }

    // Don't show for error states (let error banner show)
    if (widget.state is VoiceSessionTransactionError) {
      return const SizedBox.shrink();
    }

    // Build step indicators based on state
    final steps = _getStepsForState(widget.state);

    if (steps.isEmpty) {
      return const SizedBox.shrink();
    }

    // Rendered INLINE inside the conversation ListView (no longer a free-
    // floating Stack overlay), so it must not be Positioned.
    return Padding(
      padding: EdgeInsets.only(top: 8.h, bottom: 8.h),
      child: _buildTransferProgress(steps),
    );
  }

  List<TransferStep> _getStepsForState(VoiceSessionState state) {
    if (state is VoiceSessionUserSearchRequired) {
      return [
        TransferStep.searching,
        TransferStep.reviewPending,
        TransferStep.pinPending,
        TransferStep.processingPending,
        TransferStep.completePending,
      ];
    } else if (state is VoiceSessionTransferConfirmation) {
      return [
        TransferStep.searchComplete,
        TransferStep.reviewing,
        TransferStep.pinPending,
        TransferStep.processingPending,
        TransferStep.completePending,
      ];
    } else if (state is VoiceSessionPinRequired) {
      return [
        TransferStep.searchComplete,
        TransferStep.reviewComplete,
        TransferStep.enteringPin,
        TransferStep.processingPending,
        TransferStep.completePending,
      ];
    } else if (state is VoiceSessionAgentProcessing) {
      return [
        TransferStep.searchComplete,
        TransferStep.reviewComplete,
        TransferStep.pinComplete,
        TransferStep.processing,
        TransferStep.completePending,
      ];
    } else if (state is VoiceSessionTransactionSuccess) {
      final success = (state as VoiceSessionTransactionSuccess).result['success'] as bool? ?? true;
      if (success) {
        return [
          TransferStep.searchComplete,
          TransferStep.reviewComplete,
          TransferStep.pinComplete,
          TransferStep.processingComplete,
          TransferStep.complete,
        ];
      } else {
        return [];
      }
    }
    return [];
  }

  Widget _buildTransferProgress(List<TransferStep> steps) {
    // Find current step index for progress bar
    int currentStepIndex = 0;
    for (int i = 0; i < steps.length; i++) {
      if (steps[i].status == StepStatus.inProgress) {
        currentStepIndex = i;
        break;
      } else if (steps[i].status == StepStatus.complete) {
        currentStepIndex = i + 1;
      }
    }

    return AnimatedBuilder(
      animation: _progressAnimation,
      builder: (context, child) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F).withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.08),
              width: 1,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Progress bar
              Container(
                height: 3.h,
                margin: EdgeInsets.only(bottom: 12.h),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(2.r),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(2.r),
                  child: LinearProgressIndicator(
                    value: _progressAnimation.value * (currentStepIndex / (steps.length - 1)),
                    backgroundColor: Colors.transparent,
                    valueColor: AlwaysStoppedAnimation<Color>(const Color(0xFF3B82F6)),
                  ),
                ),
              ),
              Row(
                children: steps.asMap().entries.map((entry) {
                  final index = entry.key;
                  final step = entry.value;
                  final isLast = index == steps.length - 1;

                  return Expanded(
                    child: Row(
                      children: [
                        _buildStepIndicator(step, index),
                        if (!isLast)
                          Expanded(
                            child: Container(
                              height: 2,
                              margin: EdgeInsets.symmetric(horizontal: 4.w),
                              decoration: BoxDecoration(
                                color: _getStepColor(step).withValues(alpha: 0.3),
                                borderRadius: BorderRadius.circular(1),
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 12.h),
              // Current step description
              Text(
                _getCurrentStepDescription(steps),
                style: GoogleFonts.inter(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white.withValues(alpha: 0.9),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStepIndicator(TransferStep step, int index) {
    final color = _getStepColor(step);
    final icon = _getStepIcon(step);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: 32.w,
      height: 32.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withValues(alpha: 0.15),
        border: Border.all(
          color: color,
          width: 2,
        ),
      ),
      child: Center(
        child: Icon(
          icon,
          color: color,
          size: 16.sp,
        ),
      ),
    );
  }

  Color _getStepColor(TransferStep step) {
    switch (step.status) {
      case StepStatus.pending:
        return const Color(0xFF6B7280);
      case StepStatus.inProgress:
        return const Color(0xFF3B82F6);
      case StepStatus.complete:
        return const Color(0xFF10B981);
    }
  }

  IconData _getStepIcon(TransferStep step) {
    switch (step.type) {
      case StepType.search:
        return step.status == StepStatus.complete
            ? Icons.check_circle_rounded
            : Icons.search_rounded;
      case StepType.review:
        return step.status == StepStatus.complete
            ? Icons.check_circle_rounded
            : Icons.visibility_rounded;
      case StepType.pin:
        return step.status == StepStatus.complete
            ? Icons.check_circle_rounded
            : Icons.password_rounded;
      case StepType.processing:
        return step.status == StepStatus.inProgress
            ? Icons.sync_rounded
            : step.status == StepStatus.complete
                ? Icons.check_circle_rounded
                : Icons.pending_rounded;
      case StepType.complete:
        return Icons.check_circle_rounded;
    }
  }

  String _getCurrentStepDescription(List<TransferStep> steps) {
    final currentStep = steps.firstWhere(
      (s) => s.status == StepStatus.inProgress,
      orElse: () => steps.last,
    );

    switch (currentStep.type) {
      case StepType.search:
        return 'Searching for recipient...';
      case StepType.review:
        return 'Reviewing transfer details...';
      case StepType.pin:
        return 'Waiting for PIN entry...';
      case StepType.processing:
        return 'Processing payment...';
      case StepType.complete:
        return 'Transfer complete!';
    }
  }
}
