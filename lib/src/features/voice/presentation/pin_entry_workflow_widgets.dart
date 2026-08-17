part of 'pin_entry_workflow.dart';

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
    super.key,
    required this.workflowManager,
    this.onPINValidated,
    this.onPINBlocked,
    this.onCancelled,
  });

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
