import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'voice_transaction_cubit_widgets.dart';


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
            onEvent(VoiceTransactionTimeout(operation: 'session'));
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
      onEvent(const VoiceTransactionRetrying());
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
      onEvent(const VoiceTransactionRetrying());
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
    onEvent(const VoiceTransactionCancelled());
  }

  void retry() {
    if (state.canRetry) {
      onEvent(const VoiceTransactionRetrying());
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
