import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Voice Transaction State Cubit
/// Manages reactive state for voice-initiated transactions with comprehensive edge case handling

// ==============================================================================
// Enums
// ==============================================================================

/// States for voice action lifecycle
enum VoiceActionState {
  /// Ready for input, no active action
  idle,

  /// Capturing user voice input
  listening,

  /// STT, intent classification in progress
  processing,

  /// Voice biometric verification in progress
  verifying,

  /// Waiting for PIN confirmation
  awaitingPin,

  /// Processing transaction/calling backend
  executing,

  /// Awaiting user confirmation for transaction
  pendingConfirmation,

  /// Action completed successfully
  success,

  /// Action failed (recoverable)
  error,

  /// Unrecoverable error
  fatal,

  /// User cancelled the action
  cancelled,

  /// Operation timed out
  timeout,

  /// Retrying failed operation
  retrying,
}

/// Types of voice-initiated transactions
enum VoiceTransactionType {
  transfer,
  billPayment,
  airtime,
  balanceCheck,
  investment,
  accountLookup,
  genericQuery,
  pinSetup,
  voiceEnrollment,
  unknown,
}

/// Error severity levels
enum ErrorSeverity {
  low, // User may not notice, auto-recoverable
  medium, // Degraded experience, partial functionality
  high, // Significant impact, user intervention needed
  critical, // Complete failure, require action
}

// ==============================================================================
// Models
// ==============================================================================

/// Context for current voice action
class VoiceActionContext extends Equatable {
  final String actionId;
  final String userId;
  final String sessionId;
  final String language;
  final String locale;
  final VoiceTransactionType transactionType;
  final DateTime startedAt;
  final DateTime updatedAt;
  final VoiceActionState state;

  // Intent extraction
  final String? transcript;
  final String? intent;
  final double confidence;

  // Transaction details
  final String? recipient;
  final double? amount;
  final String? currency;
  final String? reference;

  // Verification
  final bool voiceVerified;
  final double voiceConfidence;
  final bool pinVerified;

  // Error handling
  final String? errorCode;
  final String? errorMessage;
  final ErrorSeverity? errorSeverity;
  final int retryCount;
  final int maxRetries;

  // Metadata
  final Map<String, dynamic> metadata;

  const VoiceActionContext({
    required this.actionId,
    required this.userId,
    required this.sessionId,
    required this.language,
    required this.locale,
    required this.transactionType,
    required this.startedAt,
    required this.updatedAt,
    required this.state,
    this.transcript,
    this.intent,
    this.confidence = 0.0,
    this.recipient,
    this.amount,
    this.currency,
    this.reference,
    this.voiceVerified = false,
    this.voiceConfidence = 0.0,
    this.pinVerified = false,
    this.errorCode,
    this.errorMessage,
    this.errorSeverity,
    this.retryCount = 0,
    this.maxRetries = 3,
    this.metadata = const {},
  });

  VoiceActionContext copyWith({
    String? actionId,
    String? userId,
    String? sessionId,
    String? language,
    String? locale,
    VoiceTransactionType? transactionType,
    DateTime? startedAt,
    DateTime? updatedAt,
    VoiceActionState? state,
    String? transcript,
    String? intent,
    double? confidence,
    String? recipient,
    double? amount,
    String? currency,
    String? reference,
    bool? voiceVerified,
    double? voiceConfidence,
    bool? pinVerified,
    String? errorCode,
    String? errorMessage,
    ErrorSeverity? errorSeverity,
    int? retryCount,
    int? maxRetries,
    Map<String, dynamic>? metadata,
  }) {
    return VoiceActionContext(
      actionId: actionId ?? this.actionId,
      userId: userId ?? this.userId,
      sessionId: sessionId ?? this.sessionId,
      language: language ?? this.language,
      locale: locale ?? this.locale,
      transactionType: transactionType ?? this.transactionType,
      startedAt: startedAt ?? this.startedAt,
      updatedAt: updatedAt ?? this.updatedAt,
      state: state ?? this.state,
      transcript: transcript ?? this.transcript,
      intent: intent ?? this.intent,
      confidence: confidence ?? this.confidence,
      recipient: recipient ?? this.recipient,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      reference: reference ?? this.reference,
      voiceVerified: voiceVerified ?? this.voiceVerified,
      voiceConfidence: voiceConfidence ?? this.voiceConfidence,
      pinVerified: pinVerified ?? this.pinVerified,
      errorCode: errorCode ?? this.errorCode,
      errorMessage: errorMessage ?? this.errorMessage,
      errorSeverity: errorSeverity ?? this.errorSeverity,
      retryCount: retryCount ?? this.retryCount,
      maxRetries: maxRetries ?? this.maxRetries,
      metadata: metadata ?? this.metadata,
    );
  }

  Duration get elapsed => updatedAt.difference(startedAt);

  bool get canRetry => retryCount < maxRetries && state == VoiceActionState.error;

  @override
  List<Object?> get props => [
        actionId,
        userId,
        sessionId,
        language,
        locale,
        transactionType,
        startedAt,
        updatedAt,
        state,
        transcript,
        intent,
        confidence,
        recipient,
        amount,
        currency,
        reference,
        voiceVerified,
        voiceConfidence,
        pinVerified,
        errorCode,
        errorMessage,
        errorSeverity,
        retryCount,
        maxRetries,
        metadata,
      ];

  Map<String, dynamic> toJson() {
    return {
      'actionId': actionId,
      'userId': userId,
      'sessionId': sessionId,
      'language': language,
      'locale': locale,
      'transactionType': transactionType.name,
      'startedAt': startedAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'state': state.name,
      'transcript': transcript,
      'intent': intent,
      'confidence': confidence,
      'recipient': recipient,
      'amount': amount,
      'currency': currency,
      'reference': reference,
      'voiceVerified': voiceVerified,
      'voiceConfidence': voiceConfidence,
      'pinVerified': pinVerified,
      'errorCode': errorCode,
      'errorMessage': errorMessage,
      'errorSeverity': errorSeverity?.name,
      'retryCount': retryCount,
      'maxRetries': maxRetries,
      'metadata': metadata,
    };
  }

  factory VoiceActionContext.fromJson(Map<String, dynamic> json) {
    return VoiceActionContext(
      actionId: json['action_id'] as String,
      userId: json['user_id'] as String,
      sessionId: json['session_id'] as String,
      language: json['language'] as String? ?? 'en',
      locale: json['locale'] as String? ?? 'en-US',
      transactionType: VoiceTransactionType.values.firstWhere(
        (e) => e.name == json['transaction_type'],
        orElse: () => VoiceTransactionType.unknown,
      ),
      startedAt: DateTime.parse(json['started_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      state: VoiceActionState.values.firstWhere(
        (e) => e.name == json['state'],
        orElse: () => VoiceActionState.idle,
      ),
      transcript: json['transcript'] as String?,
      intent: json['intent'] as String?,
      confidence: (json['confidence'] as num?)?.toDouble() ?? 0.0,
      recipient: json['recipient'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      currency: json['currency'] as String?,
      reference: json['reference'] as String?,
      voiceVerified: json['voice_verified'] as bool? ?? false,
      voiceConfidence: (json['voice_confidence'] as num?)?.toDouble() ?? 0.0,
      pinVerified: json['pin_verified'] as bool? ?? false,
      errorCode: json['error_code'] as String?,
      errorMessage: json['error_message'] as String?,
      errorSeverity: json['error_severity'] != null
          ? ErrorSeverity.values.firstWhere(
              (e) => e.name == json['error_severity'],
              orElse: () => ErrorSeverity.medium,
            )
          : null,
      retryCount: json['retry_count'] as int? ?? 0,
      maxRetries: json['max_retries'] as int? ?? 3,
      metadata: json['metadata'] as Map<String, dynamic>? ?? {},
    );
  }
}

/// Result of a completed voice action
class VoiceActionResult extends Equatable {
  final String actionId;
  final bool success;
  final VoiceActionState state;
  final String? transactionReference;
  final double? amount;
  final String? currency;
  final String? recipient;
  final double? newBalance;
  final String? message;
  final String? errorCode;
  final Map<String, dynamic>? errorDetails;
  final DateTime completedAt;
  final Map<String, dynamic> metadata;

  const VoiceActionResult({
    required this.actionId,
    required this.success,
    required this.state,
    this.transactionReference,
    this.amount,
    this.currency,
    this.recipient,
    this.newBalance,
    this.message,
    this.errorCode,
    this.errorDetails,
    required this.completedAt,
    this.metadata = const {},
  });

  @override
  List<Object?> get props => [
        actionId,
        success,
        state,
        transactionReference,
        amount,
        currency,
        recipient,
        newBalance,
        message,
        errorCode,
        errorDetails,
        completedAt,
        metadata,
      ];

  Map<String, dynamic> toJson() {
    return {
      'actionId': actionId,
      'success': success,
      'state': state.name,
      'transactionReference': transactionReference,
      'amount': amount,
      'currency': currency,
      'recipient': recipient,
      'newBalance': newBalance,
      'message': message,
      'errorCode': errorCode,
      'errorDetails': errorDetails,
      'completedAt': completedAt.toIso8601String(),
      'metadata': metadata,
    };
  }

  factory VoiceActionResult.fromJson(Map<String, dynamic> json) {
    return VoiceActionResult(
      actionId: json['action_id'] as String,
      success: json['success'] as bool? ?? false,
      state: VoiceActionState.values.firstWhere(
        (e) => e.name == json['state'],
        orElse: () => VoiceActionState.error,
      ),
      transactionReference: json['transaction_reference'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      currency: json['currency'] as String?,
      recipient: json['recipient'] as String?,
      newBalance: (json['new_balance'] as num?)?.toDouble(),
      message: json['message'] as String?,
      errorCode: json['error_code'] as String?,
      errorDetails: json['error_details'] as Map<String, dynamic>?,
      completedAt: DateTime.parse(json['completed_at'] as String),
      metadata: json['metadata'] as Map<String, dynamic>? ?? {},
    );
  }
}

/// Confirmation request for user action
class VoiceConfirmationRequest extends Equatable {
  final String actionId;
  final String title;
  final String message;
  final Map<String, dynamic> details;
  final int timeoutSeconds;
  final DateTime createdAt;

  const VoiceConfirmationRequest({
    required this.actionId,
    required this.title,
    required this.message,
    required this.details,
    this.timeoutSeconds = 30,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        actionId,
        title,
        message,
        details,
        timeoutSeconds,
        createdAt,
      ];

  bool get isExpired =>
      DateTime.now().difference(createdAt).inSeconds > timeoutSeconds;

  VoiceConfirmationRequest copyWith({
    String? actionId,
    String? title,
    String? message,
    Map<String, dynamic>? details,
    int? timeoutSeconds,
    DateTime? createdAt,
  }) {
    return VoiceConfirmationRequest(
      actionId: actionId ?? this.actionId,
      title: title ?? this.title,
      message: message ?? this.message,
      details: details ?? this.details,
      timeoutSeconds: timeoutSeconds ?? this.timeoutSeconds,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

// ==============================================================================
// State
// ==============================================================================

/// Voice Transaction State
class VoiceTransactionState extends Equatable {
  final VoiceActionState currentState;
  final VoiceActionContext? context;
  final VoiceActionResult? result;
  final VoiceConfirmationRequest? pendingConfirmation;
  final String? errorMessage;
  final bool isLoading;
  final bool isConnected;
  final double audioLevel; // 0.0 to 1.0 for visualizer

  const VoiceTransactionState({
    this.currentState = VoiceActionState.idle,
    this.context,
    this.result,
    this.pendingConfirmation,
    this.errorMessage,
    this.isLoading = false,
    this.isConnected = false,
    this.audioLevel = 0.0,
  });

  VoiceTransactionState copyWith({
    VoiceActionState? currentState,
    VoiceActionContext? context,
    VoiceActionResult? result,
    VoiceConfirmationRequest? pendingConfirmation,
    String? errorMessage,
    bool? isLoading,
    bool? isConnected,
    double? audioLevel,
    bool clearResult = false,
    bool clearError = false,
    bool clearConfirmation = false,
  }) {
    return VoiceTransactionState(
      currentState: currentState ?? this.currentState,
      context: context ?? this.context,
      result: clearResult ? null : (result ?? this.result),
      pendingConfirmation:
          clearConfirmation ? null : (pendingConfirmation ?? this.pendingConfirmation),
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      isLoading: isLoading ?? this.isLoading,
      isConnected: isConnected ?? this.isConnected,
      audioLevel: audioLevel ?? this.audioLevel,
    );
  }

  @override
  List<Object?> get props => [
        currentState,
        context,
        result,
        pendingConfirmation,
        errorMessage,
        isLoading,
        isConnected,
        audioLevel,
      ];

  // Convenience getters
  bool get isIdle => currentState == VoiceActionState.idle;
  bool get isListening => currentState == VoiceActionState.listening;
  bool get isProcessing => currentState == VoiceActionState.processing;
  bool get isVerifying => currentState == VoiceActionState.verifying;
  bool get isAwaitingPin => currentState == VoiceActionState.awaitingPin;
  bool get isExecuting => currentState == VoiceActionState.executing;
  bool get isPendingConfirmation => currentState == VoiceActionState.pendingConfirmation;
  bool get isSuccess => currentState == VoiceActionState.success;
  bool get isError => currentState == VoiceActionState.error;
  bool get isFatal => currentState == VoiceActionState.fatal;
  bool get isCancelled => currentState == VoiceActionState.cancelled;
  bool get isTimeout => currentState == VoiceActionState.timeout;
  bool get isRetrying => currentState == VoiceActionState.retrying;
  bool get isTerminal => currentState == VoiceActionState.success ||
                        currentState == VoiceActionState.fatal ||
                        currentState == VoiceActionState.cancelled;
  bool get isActive => !isIdle && !isTerminal && !isError;
  bool get canRetry => context?.canRetry ?? false;
  bool get hasAudio => audioLevel > 0.01;
}

// ==============================================================================
// Events
// ==============================================================================

abstract class VoiceTransactionEvent extends Equatable {
  const VoiceTransactionEvent();
}

class VoiceTransactionStarted extends VoiceTransactionEvent {
  final String actionId;
  final String userId;
  final String sessionId;
  final String language;
  final String locale;
  final VoiceTransactionType transactionType;

  const VoiceTransactionStarted({
    required this.actionId,
    required this.userId,
    required this.sessionId,
    this.language = 'en',
    this.locale = 'en-US',
    this.transactionType = VoiceTransactionType.unknown,
  });

  @override
  List<Object?> get props => [actionId, userId, sessionId, language, locale, transactionType];
}

class VoiceTransactionStateChanged extends VoiceTransactionEvent {
  final VoiceActionState newState;
  final Map<String, dynamic>? data;

  const VoiceTransactionStateChanged({
    required this.newState,
    this.data,
  });

  @override
  List<Object?> get props => [newState, data];
}

class VoiceTranscriptReceived extends VoiceTransactionEvent {
  final String transcript;
  final bool isFinal;

  const VoiceTranscriptReceived({
    required this.transcript,
    this.isFinal = false,
  });

  @override
  List<Object?> get props => [transcript, isFinal];
}

class VoiceVerificationCompleted extends VoiceTransactionEvent {
  final bool verified;
  final double confidence;
  final bool requiresPin;

  const VoiceVerificationCompleted({
    required this.verified,
    required this.confidence,
    this.requiresPin = false,
  });

  @override
  List<Object?> get props => [verified, confidence, requiresPin];
}

class VoicePinRequired extends VoiceTransactionEvent {
  final String reason;
  final int attemptsRemaining;

  const VoicePinRequired({
    this.reason = 'security',
    this.attemptsRemaining = 3,
  });

  @override
  List<Object?> get props => [reason, attemptsRemaining];
}

class VoiceConfirmationRequested extends VoiceTransactionEvent {
  final String title;
  final String message;
  final Map<String, dynamic> details;
  final int timeoutSeconds;

  const VoiceConfirmationRequested({
    required this.title,
    required this.message,
    required this.details,
    this.timeoutSeconds = 30,
  });

  @override
  List<Object?> get props => [title, message, details, timeoutSeconds];
}

class VoiceTransactionCompleted extends VoiceTransactionEvent {
  final VoiceActionResult result;

  const VoiceTransactionCompleted({required this.result});

  @override
  List<Object?> get props => [result];
}

class VoiceTransactionError extends VoiceTransactionEvent {
  final String errorCode;
  final String errorMessage;
  final ErrorSeverity severity;
  final bool recoverable;

  const VoiceTransactionError({
    required this.errorCode,
    required this.errorMessage,
    this.severity = ErrorSeverity.medium,
    this.recoverable = true,
  });

  @override
  List<Object?> get props => [errorCode, errorMessage, severity, recoverable];
}

class VoiceTransactionCancelled extends VoiceTransactionEvent {
  const VoiceTransactionCancelled();

  @override
  List<Object?> get props => [];
}

class VoiceTransactionTimeout extends VoiceTransactionEvent {
  final String operation;

  const VoiceTransactionTimeout({this.operation = 'operation'});

  @override
  List<Object?> get props => [operation];
}

class VoiceTransactionRetrying extends VoiceTransactionEvent {
  const VoiceTransactionRetrying();

  @override
  List<Object?> get props => [];
}

class VoiceConnectionChanged extends VoiceTransactionEvent {
  final bool connected;

  const VoiceConnectionChanged({required this.connected});

  @override
  List<Object?> get props => [connected];
}

class VoiceAudioLevelUpdated extends VoiceTransactionEvent {
  final double level;

  const VoiceAudioLevelUpdated({required this.level});

  @override
  List<Object?> get props => [level];
}

class VoiceReset extends VoiceTransactionEvent {
  const VoiceReset();

  @override
  List<Object?> get props => [];
}

// ==============================================================================
// BLoC / Cubit
// ==============================================================================

class VoiceTransactionCubit extends Cubit<VoiceTransactionState> {
  Timer? _timeoutTimer;
  Timer? _audioLevelDecayTimer;
  StreamSubscription? _eventSubscription;

  VoiceTransactionCubit() : super(const VoiceTransactionState());

  // Initialize with connection to voice gateway
  Future<void> initialize({
    required String userId,
    required String sessionId,
    Duration timeout = const Duration(seconds: 120),
  }) async {
    emit(state.copyWith(isConnected: false, isLoading: true));

    try {
      // TODO: Connect to voice gateway WebSocket/SSE
      // For now, simulate connection
      await Future.delayed(const Duration(milliseconds: 500));

      emit(state.copyWith(isConnected: true, isLoading: false));

      // Setup auto-timeout
      _timeoutTimer?.cancel();
      if (timeout.inSeconds > 0) {
        _timeoutTimer = Timer(timeout, () {
          if (state.isActive) {
            add(VoiceTransactionTimeout(operation: 'session'));
          }
        });
      }
    } catch (e) {
      emit(state.copyWith(
        isConnected: false,
        isLoading: false,
        errorMessage: 'Failed to connect: $e',
      ));
    }
  }

  // Handle incoming events
  Future<void> onEvent(VoiceTransactionEvent event) async {
    if (event is VoiceTransactionStarted) {
      await _onStarted(event);
    } else if (event is VoiceTransactionStateChanged) {
      await _onStateChanged(event);
    } else if (event is VoiceTranscriptReceived) {
      await _onTranscriptReceived(event);
    } else if (event is VoiceVerificationCompleted) {
      await _onVerificationCompleted(event);
    } else if (event is VoicePinRequired) {
      await _onPinRequired(event);
    } else if (event is VoiceConfirmationRequested) {
      await _onConfirmationRequested(event);
    } else if (event is VoiceTransactionCompleted) {
      await _onCompleted(event);
    } else if (event is VoiceTransactionError) {
      await _onError(event);
    } else if (event is VoiceTransactionCancelled) {
      await _onCancelled();
    } else if (event is VoiceTransactionTimeout) {
      await _onTimeout(event);
    } else if (event is VoiceTransactionRetrying) {
      await _onRetrying();
    } else if (event is VoiceConnectionChanged) {
      emit(state.copyWith(isConnected: event.connected));
    } else if (event is VoiceAudioLevelUpdated) {
      _onAudioLevelUpdated(event);
    } else if (event is VoiceReset) {
      reset();
    }
  }

  Future<void> _onStarted(VoiceTransactionStarted event) async {
    final context = VoiceActionContext(
      actionId: event.actionId,
      userId: event.userId,
      sessionId: event.sessionId,
      language: event.language,
      locale: event.locale,
      transactionType: event.transactionType,
      startedAt: DateTime.now(),
      updatedAt: DateTime.now(),
      state: VoiceActionState.listening,
    );

    emit(state.copyWith(
      currentState: VoiceActionState.listening,
      context: context,
      clearResult: true,
      clearError: true,
      clearConfirmation: true,
    ));
  }

  Future<void> _onStateChanged(VoiceTransactionStateChanged event) async {
    final newState = event.newState;
    final currentContext = state.context;

    if (currentContext == null) return;

    final updatedContext = currentContext.copyWith(
      state: newState,
      updatedAt: DateTime.now(),
      // Update additional data if provided
      transcript: event.data?['transcript'] as String?,
      intent: event.data?['intent'] as String?,
      confidence: (event.data?['confidence'] as num?)?.toDouble() ?? currentContext.confidence,
      recipient: event.data?['recipient'] as String?,
      amount: (event.data?['amount'] as num?)?.toDouble(),
      currency: event.data?['currency'] as String?,
      reference: event.data?['reference'] as String?,
      voiceVerified: event.data?['voice_verified'] as bool? ?? currentContext.voiceVerified,
      voiceConfidence: (event.data?['voice_confidence'] as num?)?.toDouble() ?? currentContext.voiceConfidence,
      pinVerified: event.data?['pin_verified'] as bool? ?? currentContext.pinVerified,
    );

    emit(state.copyWith(
      currentState: newState,
      context: updatedContext,
    ));
  }

  Future<void> _onTranscriptReceived(VoiceTranscriptReceived event) async {
    final currentContext = state.context;
    if (currentContext == null) return;

    final updatedContext = currentContext.copyWith(
      transcript: event.transcript,
      updatedAt: DateTime.now(),
    );

    emit(state.copyWith(context: updatedContext));
  }

  Future<void> _onVerificationCompleted(VoiceVerificationCompleted event) async {
    final currentContext = state.context;
    if (currentContext == null) return;

    final updatedContext = currentContext.copyWith(
      voiceVerified: event.verified,
      voiceConfidence: event.confidence,
      updatedAt: DateTime.now(),
    );

    // If verified but requires PIN, transition to awaiting PIN
    final newState = event.requiresPin
        ? VoiceActionState.awaitingPin
        : (event.verified ? VoiceActionState.executing : VoiceActionState.error);

    emit(state.copyWith(
      currentState: newState,
      context: updatedContext,
    ));

    if (!event.verified && !event.requiresPin) {
      emit(state.copyWith(
        errorMessage: 'Voice verification failed (${(event.confidence * 100).toStringAsFixed(0)}% confidence)',
      ));
    }
  }

  Future<void> _onPinRequired(VoicePinRequired event) async {
    emit(state.copyWith(
      currentState: VoiceActionState.awaitingPin,
    ));
  }

  Future<void> _onConfirmationRequested(VoiceConfirmationRequested event) async {
    final confirmation = VoiceConfirmationRequest(
      actionId: state.context?.actionId ?? '',
      title: event.title,
      message: event.message,
      details: event.details,
      timeoutSeconds: event.timeoutSeconds,
      createdAt: DateTime.now(),
    );

    emit(state.copyWith(
      currentState: VoiceActionState.pendingConfirmation,
      pendingConfirmation: confirmation,
    ));
  }

  Future<void> _onCompleted(VoiceTransactionCompleted event) async {
    _timeoutTimer?.cancel();

    emit(state.copyWith(
      currentState: event.result.success
          ? VoiceActionState.success
          : VoiceActionState.error,
      result: event.result,
      clearError: true,
    ));
  }

  Future<void> _onError(VoiceTransactionError event) async {
    final currentContext = state.context;
    VoiceActionContext? updatedContext;

    if (currentContext != null) {
      updatedContext = currentContext.copyWith(
        errorCode: event.errorCode,
        errorMessage: event.errorMessage,
        errorSeverity: event.severity,
        updatedAt: DateTime.now(),
      );
    }

    emit(state.copyWith(
      currentState: VoiceActionState.error,
      context: updatedContext,
      errorMessage: event.errorMessage,
    ));

    // Auto-retry if recoverable and retries available
    if (event.recoverable && (currentContext?.canRetry ?? false)) {
      await Future.delayed(const Duration(seconds: 2));
      add(const VoiceTransactionRetrying());
    }
  }

  Future<void> _onCancelled() async {
    _timeoutTimer?.cancel();

    emit(state.copyWith(
      currentState: VoiceActionState.cancelled,
      clearError: true,
      clearConfirmation: true,
    ));
  }

  Future<void> _onTimeout(VoiceTransactionTimeout event) async {
    _timeoutTimer?.cancel();

    final currentContext = state.context;

    // If we have retries left, transition to retrying
    if (currentContext?.canRetry ?? false) {
      add(const VoiceTransactionRetrying());
    } else {
      emit(state.copyWith(
        currentState: VoiceActionState.timeout,
        errorMessage: '${event.operation} timed out',
      ));
    }
  }

  Future<void> _onRetrying() async {
    final currentContext = state.context;
    VoiceActionContext? updatedContext;

    if (currentContext != null) {
      updatedContext = currentContext.copyWith(
        retryCount: currentContext.retryCount + 1,
        updatedAt: DateTime.now(),
      );
    }

    emit(state.copyWith(
      currentState: VoiceActionState.retrying,
      context: updatedContext,
      clearError: true,
    ));

    // Reset back to processing after a brief delay
    await Future.delayed(const Duration(milliseconds: 500));
    emit(state.copyWith(
      currentState: VoiceActionState.processing,
    ));
  }

  void _onAudioLevelUpdated(VoiceAudioLevelUpdated event) {
    emit(state.copyWith(audioLevel: event.level));

    // Decay audio level visual smoothly
    _audioLevelDecayTimer?.cancel();
    _audioLevelDecayTimer = Timer(const Duration(milliseconds: 100), () {
      if (state.audioLevel > 0) {
        emit(state.copyWith(audioLevel: state.audioLevel * 0.7));
      }
    });
  }

  // User actions
  void confirmTransaction() {
    if (state.isPendingConfirmation && state.pendingConfirmation != null) {
      final confirmation = state.pendingConfirmation!;
      if (!confirmation.isExpired) {
        // User confirmed, proceed with execution
        emit(state.copyWith(
          currentState: VoiceActionState.executing,
          clearConfirmation: true,
        ));
      } else {
        // Confirmation expired
        emit(state.copyWith(
          currentState: VoiceActionState.timeout,
          errorMessage: 'Confirmation timed out',
          clearConfirmation: true,
        ));
      }
    }
  }

  void cancelTransaction() {
    add(const VoiceTransactionCancelled());
  }

  void retry() {
    if (state.canRetry) {
      add(const VoiceTransactionRetrying());
    }
  }

  void reset() {
    _timeoutTimer?.cancel();
    _audioLevelDecayTimer?.cancel();
    emit(const VoiceTransactionState());
  }

  @override
  Future<void> close() {
    _timeoutTimer?.cancel();
    _audioLevelDecayTimer?.cancel();
    _eventSubscription?.cancel();
    return super.close();
  }
}
