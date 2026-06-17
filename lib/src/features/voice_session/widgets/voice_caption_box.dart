import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/src/features/voice_session/cubit/voice_session_cubit.dart';
import 'package:lazervault/src/features/voice_session/cubit/voice_session_state.dart';

/// YouTube-style real-time caption box that overlays on top of visual feedback.
///
/// Shows:
/// - User captions (what user is saying) in green
/// - Agent captions (what AI is responding with) in blue
/// - Auto-dismisses after sentence completes (5 second timeout)
/// - Always visible above other visual feedback
///
/// Edge cases handled:
/// - Empty/null text filtering
/// - Very long text truncation with ellipsis
/// - Unicode and special characters
/// - Rapid update throttling
/// - Timer cleanup
class VoiceCaptionBox extends StatefulWidget {
  const VoiceCaptionBox({super.key});

  @override
  State<VoiceCaptionBox> createState() => _VoiceCaptionBoxState();
}

class _VoiceCaptionBoxState extends State<VoiceCaptionBox>
    with SingleTickerProviderStateMixin {
  Timer? _dismissTimer;
  Timer? _throttleTimer;
  String? _displayedUserCaption;
  String? _displayedAgentCaption;
  String? _lastProcessedUserCaption;
  String? _lastProcessedAgentCaption;

  // Debounce rapid updates to prevent UI jank
  static const _throttleDuration = Duration(milliseconds: 50);

  @override
  void dispose() {
    _dismissTimer?.cancel();
    _throttleTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<VoiceSessionCubit>();
    final userCaption = cubit.currentUserCaption;
    final agentCaption = cubit.currentAgentCaption;
    final isAgentSpeaking = cubit.isAgentSpeaking;

    // Update displayed captions with debouncing
    _updateCaptions(userCaption, agentCaption, isAgentSpeaking);

    // Don't show if no captions
    if (_displayedUserCaption == null && _displayedAgentCaption == null) {
      return const SizedBox.shrink();
    }

    // Determine which caption to show (agent takes priority)
    final primaryCaption = _displayedAgentCaption ?? _displayedUserCaption;
    final isAgent = _displayedAgentCaption != null;

    if (primaryCaption == null) return const SizedBox.shrink();

    return Positioned(
      top: 80.h, // Position below top bar
      left: 16.w,
      right: 16.w,
      child: _buildCaptionBox(primaryCaption, isAgent),
    );
  }

  /// Updates captions with debouncing to handle rapid updates
  void _updateCaptions(
    String? userCaption,
    String? agentCaption,
    bool isAgentSpeaking,
  ) {
    // Skip if unchanged (except for speaking state change)
    if (userCaption == _lastProcessedUserCaption &&
        agentCaption == _lastProcessedAgentCaption) {
      return;
    }

    // Throttle rapid caption updates
    _throttleTimer?.cancel();
    _throttleTimer = Timer(_throttleDuration, () {
      if (mounted) {
        setState(() {
          _processUserCaption(userCaption);
          _processAgentCaption(agentCaption, isAgentSpeaking);
          _lastProcessedUserCaption = userCaption;
          _lastProcessedAgentCaption = agentCaption;
        });
      }
    });
  }

  void _processUserCaption(String? userCaption) {
    if (userCaption == null || userCaption.isEmpty) {
      if (_displayedUserCaption != null) {
        _displayedUserCaption = null;
        _dismissTimer?.cancel();
      }
      return;
    }

    // Sanitize and truncate if too long
    final sanitized = _sanitizeCaptionText(userCaption);
    if (sanitized != _displayedUserCaption) {
      _displayedUserCaption = sanitized;
      // Auto-clear user caption after 5 seconds
      _dismissTimer?.cancel();
      _dismissTimer = Timer(const Duration(seconds: 5), () {
        if (mounted && _displayedUserCaption != null) {
          setState(() {
            _displayedUserCaption = null;
          });
        }
      });
    }
  }

  void _processAgentCaption(String? agentCaption, bool isAgentSpeaking) {
    if (agentCaption == null || agentCaption.isEmpty) {
      // Only clear if agent is no longer speaking
      if (!isAgentSpeaking && _displayedAgentCaption != null) {
        _displayedAgentCaption = null;
      }
      return;
    }

    // Sanitize and truncate if too long
    final sanitized = _sanitizeCaptionText(agentCaption);
    _displayedAgentCaption = sanitized;
  }

  /// Sanitize caption text - handle edge cases
  String _sanitizeCaptionText(String text) {
    if (text.isEmpty) return text;

    // Remove null characters and invalid Unicode
    final sanitized = text.replaceAll(RegExp(r'[\x00-\x08\x0B\x0C\x0E-\x1F]'), '');

    // Truncate if too long (max 200 chars for display)
    const maxLength = 200;
    if (sanitized.length > maxLength) {
      return '${sanitized.substring(0, maxLength - 3)}...';
    }

    return sanitized;
  }

  Widget _buildCaptionBox(String text, bool isAgent) {
    // Split text into words for YouTube-style word-by-word animation
    final words = text.split(' ');
    final maxWordsPerLine = 8;
    final lines = <String>[];

    for (int i = 0; i < words.length; i += maxWordsPerLine) {
      final end = math.min(i + maxWordsPerLine, words.length);
      final lineWords = words.sublist(i, end);

      // Handle very long words (URLs, etc.)
      final line = lineWords.join(' ');
      if (line.length > 30) {
        // Break long lines
        lines.addAll(_breakLongLine(line, 30));
      } else {
        lines.add(line);
      }
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            (isAgent ? const Color(0xFF4E03D0) : const Color(0xFF10B981)).withValues(alpha: 0.15),
            (isAgent ? const Color(0xFF4E03D0) : const Color(0xFF10B981)).withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: (isAgent ? const Color(0xFF4E03D0) : const Color(0xFF10B981)).withValues(alpha: 0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Caption type indicator
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 6.r,
                height: 6.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isAgent ? const Color(0xFF4E03D0) : const Color(0xFF10B981),
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                isAgent ? 'LazerVault AI' : 'You',
                style: GoogleFonts.inter(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  color: (isAgent ? const Color(0xFFB4A0FF) : const Color(0xFF34D399)),
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          // Caption text - YouTube style with fade animation
          ...lines.map((line) => Padding(
                padding: EdgeInsets.only(bottom: line != lines.last ? 4.h : 0),
                child: _buildAnimatedText(line, isAgent),
              )),
        ],
      ),
    );
  }

  /// Break long lines into chunks (for URLs, etc.)
  List<String> _breakLongLine(String line, int maxLength) {
    final chunks = <String>[];
    for (int i = 0; i < line.length; i += maxLength) {
      final end = math.min(i + maxLength, line.length);
      chunks.add(line.substring(i, end));
    }
    return chunks;
  }

  Widget _buildAnimatedText(String text, bool isAgent) {
    return TweenAnimationBuilder<double>(
      key: ValueKey(text),
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 150),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 4 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          color: Colors.white,
          height: 1.4,
          letterSpacing: -0.2,
        ),
        textAlign: TextAlign.center,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

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
    // Only show for transfer-related states
    final isTransferState = widget.state is VoiceSessionUserSearchRequired ||
        widget.state is VoiceSessionTransferConfirmation ||
        widget.state is VoiceSessionPinRequired ||
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

    return Positioned(
      top: 170.h, // Below caption box
      left: 16.w,
      right: 16.w,
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

enum StepStatus { pending, inProgress, complete }

enum StepType { search, review, pin, processing, complete }

class TransferStep {
  final StepType type;
  final StepStatus status;

  const TransferStep({required this.type, required this.status});

  static const searching = TransferStep(type: StepType.search, status: StepStatus.inProgress);
  static const searchComplete = TransferStep(type: StepType.search, status: StepStatus.complete);
  static const reviewPending = TransferStep(type: StepType.review, status: StepStatus.pending);
  static const reviewing = TransferStep(type: StepType.review, status: StepStatus.inProgress);
  static const reviewComplete = TransferStep(type: StepType.review, status: StepStatus.complete);
  static const pinPending = TransferStep(type: StepType.pin, status: StepStatus.pending);
  static const enteringPin = TransferStep(type: StepType.pin, status: StepStatus.inProgress);
  static const pinComplete = TransferStep(type: StepType.pin, status: StepStatus.complete);
  static const processingPending = TransferStep(type: StepType.processing, status: StepStatus.pending);
  static const processing = TransferStep(type: StepType.processing, status: StepStatus.inProgress);
  static const processingComplete = TransferStep(type: StepType.processing, status: StepStatus.complete);
  static const completePending = TransferStep(type: StepType.complete, status: StepStatus.pending);
  static const complete = TransferStep(type: StepType.complete, status: StepStatus.complete);
}
