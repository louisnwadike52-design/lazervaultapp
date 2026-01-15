import 'dart:async';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

/// PIN Workflow Event Types
enum PINWorkflowEventType {
  pinRequired,
  pinStateChange,
  pinValidated,
  pinInvalid,
  pinBlocked,
  workflowComplete,
  workflowCancelled,
  sessionExpired,
}

/// PIN Workflow Event
class PINWorkflowEvent {
  final PINWorkflowEventType type;
  final String? sessionId;
  final String? userId;
  final String? state;
  final String? message;
  final Map<String, dynamic>? data;
  final DateTime? timestamp;

  PINWorkflowEvent({
    required this.type,
    this.sessionId,
    this.userId,
    this.state,
    this.message,
    this.data,
    this.timestamp,
  });

  factory PINWorkflowEvent.fromJson(Map<String, dynamic> json) {
    final typeStr = json['type'] as String?;
    PINWorkflowEventType? eventType;

    if (typeStr != null) {
      switch (typeStr) {
        case 'PIN_REQUIRED':
          eventType = PINWorkflowEventType.pinRequired;
          break;
        case 'PIN_STATE_CHANGE':
          eventType = PINWorkflowEventType.pinStateChange;
          break;
        case 'PIN_VALIDATED':
          eventType = PINWorkflowEventType.pinValidated;
          break;
        case 'PIN_INVALID':
          eventType = PINWorkflowEventType.pinInvalid;
          break;
        case 'PIN_BLOCKED':
          eventType = PINWorkflowEventType.pinBlocked;
          break;
        case 'PIN_WORKFLOW_COMPLETE':
          eventType = PINWorkflowEventType.workflowComplete;
          break;
        case 'PIN_WORKFLOW_CANCELLED':
          eventType = PINWorkflowEventType.workflowCancelled;
          break;
        case 'PIN_SESSION_EXPIRED':
          eventType = PINWorkflowEventType.sessionExpired;
          break;
      }
    }

    return PINWorkflowEvent(
      type: eventType ?? PINWorkflowEventType.pinStateChange,
      sessionId: json['session_id'] as String?,
      userId: json['user_id'] as String?,
      state: json['state'] as String?,
      message: json['message'] as String?,
      data: json['result_data'] as Map<String, dynamic>?,
      timestamp: json['timestamp'] != null
          ? DateTime.tryParse(json['timestamp'])
          : null,
    );
  }
}

/// PIN Workflow Manager
class PINWorkflowManager {
  final WebSocketChannel? channel;
  final String sessionId;
  final String userId;

  final _eventController = StreamController<PINWorkflowEvent>.broadcast();
  String? _currentIntent;
  Map<String, dynamic>? _paymentData;

  PINWorkflowManager({
    required this.channel,
    required this.sessionId,
    required this.userId,
  }) {
    // Listen for PIN workflow events from WebSocket
    channel?.stream.listen(
      (data) {
        final json = data as Map<String, dynamic>;
        final event = PINWorkflowEvent.fromJson(json);
        _eventController.add(event);

        // Store payment data if PIN required
        if (event.type == PINWorkflowEventType.pinRequired) {
          _currentIntent = event.data?['intent'] as String?;
          _paymentData = event.data?['payment_data'] as Map<String, dynamic>?;
        }
      },
      onError: (error) {
        _eventController.addError(error);
      },
    );
  }

  Stream<PINWorkflowEvent> get events => _eventController.stream;

  String? get currentIntent => _currentIntent;
  Map<String, dynamic>? get paymentData => _paymentData;

  Future<void> submitPIN(String pin) async {
    if (channel == null) {
      throw Exception('WebSocket channel not connected');
    }

    channel?.sink.add({
      'type': 'submit_pin',
      'session_id': sessionId,
      'user_id': userId,
      'pin': pin,
    });
  }

  Future<void> cancelPIN() async {
    if (channel == null) {
      throw Exception('WebSocket channel not connected');
    }

    channel?.sink.add({
      'type': 'cancel_pin',
      'session_id': sessionId,
      'user_id': userId,
    });
  }

  void dispose() {
    _eventController.close();
  }
}

/// PIN Entry Screen
class PINEntryScreen extends StatefulWidget {
  final PINWorkflowManager workflowManager;
  final VoidCallback? onPINValidated;
  final VoidCallback? onPINBlocked;
  final VoidCallback? onCancelled;

  const PINEntryScreen({
    Key? key,
    required this.workflowManager,
    this.onPINValidated,
    this.onPINBlocked,
    this.onCancelled,
  }) : super(key: key);

  @override
  State<PINEntryScreen> createState() => _PINEntryScreenState();
}

class _PINEntryScreenState extends State<PINEntryScreen> {
  final TextEditingController _pinController = TextEditingController();
  final List<FocusNode> _pinFocusNodes = List.generate(4, (_) => FocusNode());

  String _currentPIN = '';
  String? _errorMessage;
  bool _isLoading = false;
  int _retriesRemaining = 3;
  bool _isBlocked = false;

  @override
  void initState() {
    super.initState();

    // Listen to PIN workflow events
    widget.workflowManager.events.listen((event) {
      if (!mounted) return;

      switch (event.type) {
        case PINWorkflowEventType.pinInvalid:
          setState(() {
            _errorMessage = event.message ?? 'Invalid PIN';
            _retriesRemaining = event.data?['retries_remaining'] ?? _retriesRemaining - 1;
            _isLoading = false;
            _clearPIN();
          });
          break;

        case PINWorkflowEventType.pinValidated:
          setState(() {
            _isLoading = false;
          });
          widget.onPINValidated?.call();
          break;

        case PINWorkflowEventType.pinBlocked:
          setState(() {
            _isBlocked = true;
            _isLoading = false;
            _errorMessage = event.message ?? 'Too many invalid attempts';
          });
          widget.onPINBlocked?.call();
          break;

        case PINWorkflowEventType.workflowComplete:
          // Transaction completed
          Navigator.of(context).pop(event.data);
          break;

        case PINWorkflowEventType.workflowCancelled:
          Navigator.of(context).pop();
          break;

        case PINWorkflowEventType.sessionExpired:
          setState(() {
            _errorMessage = 'PIN entry session expired. Please try again.';
            _isLoading = false;
          });
          break;

        default:
          break;
      }
    });
  }

  @override
  void dispose() {
    _pinController.dispose();
    for (var node in _pinFocusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _clearPIN() {
    _currentPIN = '';
    _pinController.clear();
    for (var node in _pinFocusNodes) {
      node.unfocus();
    }
    _pinFocusNodes[0].requestFocus();
  }

  void _onPINDigitChanged(String value) {
    if (value.length > 4) return;

    setState(() {
      _currentPIN = value;
    });

    // Auto-focus next field
    if (value.length < 4) {
      _pinFocusNodes[value.length].requestFocus();
    }

    // Auto-submit when 4 digits entered
    if (value.length == 4 && !_isLoading && !_isBlocked) {
      _submitPIN();
    }
  }

  Future<void> _submitPIN() async {
    if (_currentPIN.length != 4 || _isLoading || _isBlocked) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await widget.workflowManager.submitPIN(_currentPIN);
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Failed to submit PIN. Please try again.';
      });
    }
  }

  void _cancel() {
    widget.workflowManager.cancelPIN();
    widget.onCancelled?.call();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return WillPopScope(
      onWillPop: () async {
        _cancel();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Enter Transaction PIN'),
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: _cancel,
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Icon
                Icon(
                  _isBlocked ? Icons.block : Icons.lock_outline,
                  size: 80,
                  color: _isBlocked
                      ? theme.colorScheme.error
                      : theme.colorScheme.primary,
                ),
                const SizedBox(height: 24),

                // Title
                Text(
                  _isBlocked ? 'PIN Blocked' : 'Enter Your PIN',
                  style: theme.textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),

                // Description
                Text(
                  _isBlocked
                      ? 'Too many invalid PIN attempts. This transaction has been cancelled for your security.'
                      : 'Please enter your 4-digit transaction PIN to authorize this payment.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),

                // PIN Input Fields
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(4, (index) {
                    return _PINDigitField(
                      focusNode: _pinFocusNodes[index],
                      value: _currentPIN.length > index ? _currentPIN[index] : '',
                      isLoading: _isLoading && index == _currentPIN.length - 1,
                      onChanged: (value) {
                        if (value.isEmpty) return;
                        _onPINDigitChanged(_currentPIN + value);
                      },
                    );
                  }),
                ),
                const SizedBox(height: 24),

                // Error Message
                if (_errorMessage != null) ...[
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: _isBlocked
                          ? theme.colorScheme.errorContainer
                          : theme.colorScheme.errorContainer.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          _isBlocked ? Icons.block : Icons.error_outline,
                          color: _isBlocked
                              ? theme.colorScheme.error
                              : theme.colorScheme.error,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            _errorMessage!,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: _isBlocked
                                  ? theme.colorScheme.error
                                  : theme.colorScheme.error,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],

                // Retries Remaining
                if (!_isBlocked && _retriesRemaining < 3)
                  Text(
                    '$_retriesRemaining attempts remaining',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.error,
                    ),
                    textAlign: TextAlign.center,
                  ),

                const SizedBox(height: 24),

                // Cancel Button
                OutlinedButton.icon(
                  onPressed: _isLoading || _isBlocked ? null : _cancel,
                  icon: const Icon(Icons.cancel_outlined),
                  label: const Text('Cancel Transaction'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),

                // Loading Indicator
                if (_isLoading) ...[
                  const SizedBox(height: 24),
                  const Center(
                    child: Column(
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 12),
                        Text('Validating PIN...'),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Individual PIN Digit Field
class _PINDigitField extends StatelessWidget {
  final FocusNode focusNode;
  final String value;
  final bool isLoading;
  final ValueChanged<String> onChanged;

  const _PINDigitField({
    required this.focusNode,
    required this.value,
    required this.isLoading,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        border: Border.all(
          color: focusNode.hasFocus
              ? theme.colorScheme.primary
              : theme.colorScheme.outline,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        focusNode: focusNode,
        textAlign: TextAlign.center,
        style: theme.textTheme.headlineMedium,
        keyboardType: TextInputType.number,
        maxLength: 1,
        obscureText: true,
        decoration: const InputDecoration(
          counterText: '',
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
        ),
        onChanged: onChanged,
      ),
    );
  }
}

/// PIN Entry Bottom Sheet (Alternative to full screen)
class PINEntryBottomSheet extends StatelessWidget {
  final PINWorkflowManager workflowManager;
  final VoidCallback? onPINValidated;
  final VoidCallback? onPINBlocked;
  final VoidCallback? onCancelled;

  const PINEntryBottomSheet({
    Key? key,
    required this.workflowManager,
    this.onPINValidated,
    this.onPINBlocked,
    this.onCancelled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.outlineVariant,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 24),

          Expanded(
            child: PINEntryScreen(
              workflowManager: workflowManager,
              onPINValidated: onPINValidated,
              onPINBlocked: onPINBlocked,
              onCancelled: onCancelled,
            ),
          ),
        ],
      ),
    );
  }

  /// Show the bottom sheet
  static Future<void> show(
    BuildContext context, {
    required PINWorkflowManager workflowManager,
    VoidCallback? onPINValidated,
    VoidCallback? onPINBlocked,
    VoidCallback? onCancelled,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => PINEntryBottomSheet(
        workflowManager: workflowManager,
        onPINValidated: onPINValidated,
        onPINBlocked: onPINBlocked,
        onCancelled: onCancelled,
      ),
    );
  }
}
