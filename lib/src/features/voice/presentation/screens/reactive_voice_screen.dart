import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../../../core/services/voice_biometrics_service.dart';
import '../cubit/voice_transaction_cubit.dart';
import '../widgets/voice_action_feedback_widgets.dart';
import '../services/voice_feedback_websocket_service.dart';

/// Reactive Voice Screen - Uses VoiceTransactionCubit for state management
/// and provides real-time visual feedback for voice actions
class ReactiveVoiceScreen extends StatefulWidget {
  final String userId;
  final String sessionId;
  final String? voiceGatewayUrl;
  final VoidCallback? onClose;

  const ReactiveVoiceScreen({
    super.key,
    required this.userId,
    required this.sessionId,
    this.voiceGatewayUrl,
    this.onClose,
  });

  @override
  State<ReactiveVoiceScreen> createState() => _ReactiveVoiceScreenState();
}

class _ReactiveVoiceScreenState extends State<ReactiveVoiceScreen> {
  final VoiceBiometricsService _voiceService = GetIt.I<VoiceBiometricsService>();
  late final VoiceTransactionCubit _cubit;
  late final VoiceFeedbackWebSocketService _wsService;

  @override
  void initState() {
    super.initState();
    _cubit = VoiceTransactionCubit();
    _wsService = VoiceFeedbackWebSocketService(
      baseUrl: widget.voiceGatewayUrl ?? 'http://10.0.2.2:3010',
    );

    _initialize();
  }

  @override
  void dispose() {
    _cubit.close();
    _wsService.dispose();
    super.dispose();
  }

  Future<void> _initialize() async {
    // Check voice enrollment first
    try {
      final status = await _voiceService.checkEnrollmentStatus(widget.userId);

      if (!status.isEnrolled && mounted) {
        _showNotEnrolledDialog();
        return;
      }
    } catch (e) {
      if (mounted) {
        _showError('Failed to check voice enrollment. Please try again.');
      }
      return;
    }

    // Connect to WebSocket feedback service
    try {
      await _wsService.connect(
        userId: widget.userId,
        sessionId: widget.sessionId,
      );

      await _cubit.initialize(
        userId: widget.userId,
        sessionId: widget.sessionId,
      );

      // Listen to WebSocket events and forward to cubit
      _wsService.eventStream().listen((event) {
        if (mounted) {
          _cubit.onEvent(event);
        }
      });
    } catch (e) {
      if (mounted) {
        _showError('Failed to connect to voice service. Please try again.');
      }
    }
  }

  void _showNotEnrolledDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Voice Not Registered'),
        content: const Text(
          'You need to register your voice before using voice transactions.\n\n'
          'Would you like to register now?',
        ),
        actions: [
          TextButton(
            onPressed: () => _handleClose(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => _navigateToEnrollment(),
            child: const Text('Register Voice'),
          ),
        ],
      ),
    );
  }

  void _navigateToEnrollment() {
    Navigator.pop(context);
    // Navigate to enrollment screen
    // Navigator.push(...);
  }

  void _handleClose() {
    Navigator.pop(context);
    widget.onClose?.call();
  }

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<VoiceTransactionCubit>.value(
      value: _cubit,
      child: VoiceActionFeedback(
        onRetry: () => _cubit.retry(),
        onCancel: () => _cubit.cancelTransaction(),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Voice Assistant'),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.close),
              onPressed: _handleClose,
            ),
            actions: [
              BlocBuilder<VoiceTransactionCubit, VoiceTransactionState>(
                buildWhen: (previous, current) =>
                    previous.isConnected != current.isConnected,
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(
                      state.isConnected ? Icons.wifi : Icons.wifi_off,
                      color: state.isConnected ? Colors.green : Colors.red,
                    ),
                  );
                },
              ),
            ],
          ),
          body: BlocBuilder<VoiceTransactionCubit, VoiceTransactionState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 16),
                      Text('Connecting...'),
                    ],
                  ),
                );
              }

              if (!state.isConnected) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.wifi_off,
                        size: 64,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 16),
                      const Text('Disconnected from voice service'),
                      const SizedBox(height: 8),
                      TextButton.icon(
                        onPressed: _initialize,
                        icon: const Icon(Icons.refresh),
                        label: const Text('Reconnect'),
                      ),
                    ],
                  ),
                );
              }

              return Column(
                children: [
                  // Status bar
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Expanded(
                          child: VoiceStatusBadge(state: state.currentState),
                        ),
                        if (state.context != null)
                          Text(
                            _formatDuration(state.context!.elapsed),
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.grey[600],
                            ),
                          ),
                      ],
                    ),
                  ),

                  // Transcript display
                  if (state.context?.transcript != null)
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.blue.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'You said:',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.blue,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '"${state.context!.transcript}"',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ),

                  const Spacer(),

                  // Voice input button
                  Center(
                    child: _VoiceInputButton(
                      isListening: state.isListening,
                      isActive: state.isActive && !state.isTerminal,
                      onTap: () => _handleVoiceInput(state),
                    ),
                  ),

                  // Bottom instruction
                  Container(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        if (state.isIdle) ...[
                          const Icon(Icons.mic, size: 32, color: Colors.grey),
                          const SizedBox(height: 8),
                          Text(
                            'Tap to speak',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            'Try: "Send 1000 Naira to John"',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.grey[600],
                            ),
                          ),
                        ] else if (state.isListening) ...[
                          const Icon(Icons.hearing, size: 32, color: Colors.red),
                          const SizedBox(height: 8),
                          Text(
                            'Listening...',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: Colors.red,
                            ),
                          ),
                        ] else if (state.isProcessing || state.isVerifying || state.isExecuting) ...[
                          const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _getStateText(state.currentState),
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ] else if (state.isSuccess) ...[
                          const Icon(Icons.check_circle, size: 32, color: Colors.green),
                          const SizedBox(height: 8),
                          Text(
                            'Completed!',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: Colors.green,
                            ),
                          ),
                        ] else if (state.isError || state.isFatal) ...[
                          const Icon(Icons.error, size: 32, color: Colors.red),
                          const SizedBox(height: 8),
                          Text(
                            'Something went wrong',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: Colors.red,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextButton.icon(
                            onPressed: () => _cubit.retry(),
                            icon: const Icon(Icons.refresh),
                            label: const Text('Try Again'),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void _handleVoiceInput(VoiceTransactionState state) {
    if (state.isListening) {
      _cubit.cancelTransaction();
    } else if (state.isIdle || state.isError || state.isFatal) {
      // Start listening - would trigger recording
      _cubit.onEvent(const VoiceTransactionStateChanged(newState: VoiceActionState.listening));
    }
  }

  String _getStateText(VoiceActionState state) {
    switch (state) {
      case VoiceActionState.processing:
        return 'Processing...';
      case VoiceActionState.verifying:
        return 'Verifying your voice...';
      case VoiceActionState.awaitingPin:
        return 'Waiting for PIN...';
      case VoiceActionState.executing:
        return 'Executing transaction...';
      case VoiceActionState.retrying:
        return 'Retrying...';
      default:
        return 'Processing...';
    }
  }

  String _formatDuration(Duration duration) {
    final seconds = duration.inSeconds;
    if (seconds < 60) {
      return '${seconds}s';
    }
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes}m ${remainingSeconds}s';
  }
}


class _VoiceInputButton extends StatefulWidget {
  final bool isListening;
  final bool isActive;
  final VoidCallback onTap;

  const _VoiceInputButton({
    required this.isListening,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<_VoiceInputButton> createState() => _VoiceInputButtonState();
}

class _VoiceInputButtonState extends State<_VoiceInputButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    if (widget.isListening) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(_VoiceInputButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isListening != oldWidget.isListening) {
      if (widget.isListening) {
        _controller.repeat(reverse: true);
      } else {
        _controller.stop();
        _controller.reset();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.isActive ? widget.onTap : null,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.isListening
                    ? Colors.red
                    : widget.isActive
                        ? Theme.of(context).colorScheme.primary
                        : Colors.grey[400],
                boxShadow: [
                  if (widget.isListening)
                    BoxShadow(
                      color: Colors.red.withValues(alpha: 0.4),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  if (widget.isActive)
                    BoxShadow(
                      color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
                      blurRadius: 15,
                      spreadRadius: 3,
                    ),
                ],
              ),
              child: Icon(
                widget.isListening ? Icons.stop : Icons.mic,
                size: 36,
                color: Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }
}


// Voice status badge widget
class VoiceStatusBadge extends StatelessWidget {
  final VoiceActionState state;

  const VoiceStatusBadge({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final (label, color, icon) = _getStateInfo();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: color),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w500,
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
