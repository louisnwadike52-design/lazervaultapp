part of 'voice_caption_box.dart';

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
                isAgent ? 'Lazervault AI' : 'You',
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
