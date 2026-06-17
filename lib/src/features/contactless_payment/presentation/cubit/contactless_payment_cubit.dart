import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/contactless_payment_repository.dart';
import '../../services/contactless_websocket_service.dart';
import 'contactless_payment_state.dart';

/// Health of the realtime WS overlay. Receiver screen reads this to
/// decide its polling cadence — `connecting`/`connected` ⇒ 3s normal,
/// `failed` ⇒ 1s tightened polling so the receipt still lands within
/// a single tick of the payer's debit even when push delivery is broken.
enum ContactlessWsHealth { connecting, connected, failed }

class ContactlessPaymentCubit extends Cubit<ContactlessPaymentState> {
  final ContactlessPaymentRepository repository;
  // Realtime WS overlay (optional — null-safe so existing callers and
  // tests that don't pass one still work). When set, [subscribeToSession]
  // wires the channel; an incoming `contactless.session.completed` event
  // triggers a `checkSessionStatus` call so the cubit lands on the same
  // final state the polling path produces.
  final ContactlessWebSocketService? wsService;
  StreamSubscription<ContactlessStatusEvent>? _wsSub;
  StreamSubscription<ContactlessWebSocketConnectionState>? _wsConnSub;
  Timer? _wsTimeoutTimer;
  bool _wsConnected = false;
  String? _activeSessionId;
  /// Publicly observable WS health. The broadcast screen listens here:
  /// `connected` → keeps the relaxed 3s poll; `failed` → tightens to 1s
  /// so a permanently-dead WS still settles within ~1s of the payer's
  /// debit landing.
  final ValueNotifier<ContactlessWsHealth> wsHealth =
      ValueNotifier(ContactlessWsHealth.connecting);
  static const int _maxRetries = 3;
  static const Duration _retryDelay = Duration(seconds: 2);
  // If the WS connect hasn't fired a `connected` state-event within this
  // window, the existing polling path takes over. Polling continues
  // forever on its own cadence so even a permanently-failed WS doesn't
  // break the flow.
  static const Duration _wsConnectTimeout = Duration(seconds: 8);

  ContactlessPaymentCubit({
    required this.repository,
    this.wsService,
  }) : super(ContactlessPaymentInitial());

  /// Connect the WS overlay for the receiver-side session view. Idempotent
  /// — safe to call multiple times; only one subscription is held.
  /// Called from `nfc_broadcast_screen` after `PaymentSessionCreated`
  /// emits. Polling continues regardless so this is pure speedup.
  Future<void> subscribeToSession({
    required String userId,
    required String accessToken,
    required String sessionId,
  }) async {
    if (wsService == null) {
      wsHealth.value = ContactlessWsHealth.failed;
      return;
    }
    _activeSessionId = sessionId;
    wsHealth.value = ContactlessWsHealth.connecting;
    try {
      await wsService!.connect(userId: userId, accessToken: accessToken);
      _wsSub?.cancel();
      _wsSub = wsService!.updates.listen(_onWsEvent);
      _wsConnSub?.cancel();
      _wsConnSub = wsService!.connectionState.listen((s) {
        if (s == ContactlessWebSocketConnectionState.connected) {
          _wsConnected = true;
          wsHealth.value = ContactlessWsHealth.connected;
        } else if (s == ContactlessWebSocketConnectionState.error ||
            s == ContactlessWebSocketConnectionState.disconnected) {
          _wsConnected = false;
          wsHealth.value = ContactlessWsHealth.failed;
        }
      });
      _wsConnected = true;
      wsHealth.value = ContactlessWsHealth.connected;
      _wsTimeoutTimer?.cancel();
      _wsTimeoutTimer = Timer(_wsConnectTimeout, () {
        if (!_wsConnected) {
          wsHealth.value = ContactlessWsHealth.failed;
          // ignore: avoid_print
          print('ContactlessPaymentCubit: WS connect timed out — '
              'screen should tighten polling to 1s');
        }
      });
    } catch (e) {
      wsHealth.value = ContactlessWsHealth.failed;
      // ignore: avoid_print
      print('ContactlessPaymentCubit: WS connect failed: $e — '
          'screen should tighten polling to 1s');
    }
  }

  void _onWsEvent(ContactlessStatusEvent ev) {
    if (ev.sessionId != _activeSessionId) return;
    if (ev.eventType == 'contactless.session.completed' &&
        _activeSessionId != null) {
      // Fast-path: re-pull the session detail so the receipt screen has
      // the canonical transaction record. The polling loop would do the
      // same on its next tick — this just races ahead.
      // ignore: discarded_futures
      checkSessionStatus(_activeSessionId!);
    }
  }

  @override
  Future<void> close() async {
    _wsTimeoutTimer?.cancel();
    await _wsSub?.cancel();
    await _wsConnSub?.cancel();
    wsHealth.dispose();
    await wsService?.disconnect();
    return super.close();
  }

  /// Categorize error and determine if retryable
  (ContactlessErrorType, bool) _categorizeError(dynamic error) {
    final errorMessage = error.toString().toLowerCase();

    if (errorMessage.contains('socket') ||
        errorMessage.contains('connection') ||
        errorMessage.contains('network') ||
        error is SocketException) {
      return (ContactlessErrorType.networkError, true);
    }

    if (errorMessage.contains('timeout') || error is TimeoutException) {
      return (ContactlessErrorType.timeout, true);
    }

    if (errorMessage.contains('server') || errorMessage.contains('500')) {
      return (ContactlessErrorType.serverError, true);
    }

    if (errorMessage.contains('expired') || errorMessage.contains('expir')) {
      return (ContactlessErrorType.sessionExpired, false);
    }

    // Account-related errors must be checked BEFORE generic "not found"
    if (errorMessage.contains('account not found') ||
        errorMessage.contains('receiver account') ||
        errorMessage.contains('payer account') ||
        errorMessage.contains('account does not belong') ||
        errorMessage.contains('account is not active')) {
      return (ContactlessErrorType.accountNotFound, false);
    }

    if (errorMessage.contains('account_id') ||
        errorMessage.contains('account id required')) {
      return (ContactlessErrorType.accountRequired, false);
    }

    if (errorMessage.contains('already been paid') ||
        errorMessage.contains('already completed')) {
      return (ContactlessErrorType.sessionAlreadyPaid, false);
    }

    if (errorMessage.contains('being processed by another') ||
        errorMessage.contains('currently being processed')) {
      return (ContactlessErrorType.sessionAlreadyProcessing, false);
    }

    if (errorMessage.contains('has been cancelled') ||
        errorMessage.contains('session cancelled')) {
      return (ContactlessErrorType.sessionCancelled, false);
    }

    if (errorMessage.contains('cannot be processed')) {
      return (ContactlessErrorType.sessionAlreadyPaid, false);
    }

    if (errorMessage.contains('not in pending')) {
      return (ContactlessErrorType.sessionAlreadyPaid, false);
    }

    if (errorMessage.contains('cannot pay yourself') ||
        errorMessage.contains('self-payment')) {
      return (ContactlessErrorType.selfPayment, false);
    }

    if (errorMessage.contains('currency mismatch')) {
      return (ContactlessErrorType.currencyMismatch, false);
    }

    // Session not found - only for actual session lookup failures
    if (errorMessage.contains('session not found') || errorMessage.contains('404')) {
      return (ContactlessErrorType.sessionNotFound, false);
    }

    if (errorMessage.contains('insufficient') || errorMessage.contains('balance')) {
      return (ContactlessErrorType.insufficientBalance, false);
    }

    if (errorMessage.contains('pin') || errorMessage.contains('verification')) {
      return (ContactlessErrorType.pinValidationFailed, false);
    }

    if (errorMessage.contains('locked') || errorMessage.contains('blocked')) {
      return (ContactlessErrorType.accountLocked, false);
    }

    return (ContactlessErrorType.unknown, false);
  }

  /// Get user-friendly error message
  String _getUserFriendlyErrorMessage(ContactlessErrorType errorType, String originalMessage) {
    switch (errorType) {
      case ContactlessErrorType.nfcNotAvailable:
        return 'NFC is not supported on this device';
      case ContactlessErrorType.nfcDisabled:
        return 'Please enable NFC in your device settings';
      case ContactlessErrorType.networkError:
        return 'Network connection error. Please check your internet connection';
      case ContactlessErrorType.timeout:
        return 'Request timed out. Please try again';
      case ContactlessErrorType.serverError:
        return 'Server error. Please try again later';
      case ContactlessErrorType.insufficientBalance:
        return 'Insufficient balance in selected account';
      case ContactlessErrorType.sessionExpired:
        return 'Payment session has expired. Please create a new payment request';
      case ContactlessErrorType.sessionNotFound:
        return 'Payment session not found or has been cancelled';
      case ContactlessErrorType.accountNotFound:
        return 'Account not found or inactive. Please select a valid account';
      case ContactlessErrorType.accountRequired:
        return 'No active account selected. Please go back to the home screen and select an account';
      case ContactlessErrorType.selfPayment:
        return 'You cannot pay yourself';
      case ContactlessErrorType.sessionAlreadyPaid:
        return 'This payment has already been completed';
      case ContactlessErrorType.sessionAlreadyProcessing:
        return 'This payment is currently being processed by another payer';
      case ContactlessErrorType.sessionCancelled:
        return 'This payment request has been cancelled by the receiver';
      case ContactlessErrorType.currencyMismatch:
        return 'Your account currency does not match the payment currency';
      case ContactlessErrorType.pinValidationFailed:
        return 'Invalid PIN. Please try again';
      case ContactlessErrorType.accountLocked:
        return 'Account is locked due to too many failed attempts';
      case ContactlessErrorType.unknown:
        return originalMessage.isNotEmpty ? originalMessage : 'An unexpected error occurred';
    }
  }

  /// Emit error with proper categorization
  void _emitError(dynamic error) {
    if (isClosed) return;

    final (errorType, retryable) = _categorizeError(error);
    final message = _getUserFriendlyErrorMessage(errorType, error.toString());

    emit(ContactlessPaymentError(
      message,
      errorType: errorType,
      retryable: retryable,
    ));
  }

  /// Retry a function with exponential backoff
  Future<T> _retryWithBackoff<T>(
    Future<T> Function() operation, {
    int maxRetries = _maxRetries,
  }) async {
    int attempts = 0;

    while (true) {
      try {
        return await operation();
      } catch (e) {
        attempts++;
        final (errorType, retryable) = _categorizeError(e);

        if (!retryable || attempts >= maxRetries) {
          rethrow;
        }

        // Exponential backoff
        await Future.delayed(_retryDelay * attempts);
      }
    }
  }

  /// Create a payment session (receiver creates this to receive payment)
  Future<void> createPaymentSession({
    required double amount,
    required String currency,
    String? category,
    String? description,
    int validitySeconds = 120,
  }) async {
    try {
      if (isClosed) return;
      emit(ContactlessPaymentLoading());

      final result = await _retryWithBackoff(() => repository.createPaymentSession(
        amount: amount,
        currency: currency,
        category: category,
        description: description,
        validitySeconds: validitySeconds,
      ));

      if (isClosed) return;
      emit(PaymentSessionCreated(
        session: result.session,
        nfcPayload: result.nfcPayload,
        message: result.message,
      ));
    } catch (e) {
      _emitError(e);
    }
  }

  /// Get payment session by ID (payer reads this from NFC)
  Future<void> getPaymentSession(String sessionId) async {
    try {
      if (isClosed) return;
      emit(ContactlessPaymentLoading());

      final session = await _retryWithBackoff(() => repository.getPaymentSession(sessionId));

      if (isClosed) return;

      // Check if session is expired
      if (session.isExpired || session.expiresAt.isBefore(DateTime.now())) {
        emit(SessionExpired(
          sessionId: sessionId,
          message: 'This payment request has expired',
        ));
        return;
      }

      // Check if session has already been completed/cancelled/is being processed
      if (session.isCompleted) {
        emit(const ContactlessPaymentError(
          'This payment has already been completed',
          errorType: ContactlessErrorType.sessionAlreadyPaid,
        ));
        return;
      }

      if (session.isCancelled) {
        emit(const ContactlessPaymentError(
          'This payment request has been cancelled by the receiver',
          errorType: ContactlessErrorType.sessionCancelled,
        ));
        return;
      }

      if (session.isProcessing) {
        emit(const ContactlessPaymentError(
          'This payment is currently being processed by another payer',
          errorType: ContactlessErrorType.sessionAlreadyProcessing,
        ));
        return;
      }

      emit(PaymentSessionLoaded(session));
    } catch (e) {
      _emitError(e);
    }
  }

  /// Acknowledge that payer has read the session (via NFC)
  Future<void> acknowledgeSessionRead(String sessionId) async {
    try {
      if (isClosed) return;
      emit(ContactlessPaymentLoading());

      final result = await _retryWithBackoff(() => repository.acknowledgeSessionRead(sessionId));

      if (isClosed) return;
      emit(SessionReadAcknowledged(
        session: result.session,
        message: result.message,
      ));
    } catch (e) {
      _emitError(e);
    }
  }

  /// Process the contactless payment (payer confirms payment)
  /// This method does NOT use retry since payment processing should be atomic
  Future<void> processPayment({
    required String sessionId,
    required String sourceAccountId,
    required String transactionId,
    required String verificationToken,
  }) async {
    try {
      if (isClosed) return;
      emit(ContactlessPaymentLoading());

      final result = await repository.processContactlessPayment(
        sessionId: sessionId,
        sourceAccountId: sourceAccountId,
        transactionId: transactionId,
        verificationToken: verificationToken,
      );

      if (isClosed) return;
      emit(PaymentProcessed(
        transaction: result.transaction,
        newBalance: result.newBalance,
        message: result.message,
      ));
    } catch (e) {
      if (isClosed) return;

      final (errorType, _) = _categorizeError(e);

      // Handle PIN validation failures specially
      if (errorType == ContactlessErrorType.pinValidationFailed) {
        // Parse attempts remaining if available in error message
        final attemptsMatch = RegExp(r'(\d+)\s*attempts?\s*remaining', caseSensitive: false)
            .firstMatch(e.toString());
        final attempts = attemptsMatch != null ? int.tryParse(attemptsMatch.group(1) ?? '3') ?? 3 : 3;

        emit(PinValidationFailed(
          message: 'Invalid PIN. Please try again.',
          attemptsRemaining: attempts,
          accountLocked: attempts == 0,
        ));
        return;
      }

      // Handle account locked
      if (errorType == ContactlessErrorType.accountLocked) {
        emit(const PinValidationFailed(
          message: 'Account locked due to too many failed PIN attempts. Please contact support.',
          attemptsRemaining: 0,
          accountLocked: true,
        ));
        return;
      }

      _emitError(e);
    }
  }

  /// Cancel a payment session (receiver cancels)
  Future<void> cancelSession(String sessionId) async {
    try {
      if (isClosed) return;
      emit(ContactlessPaymentLoading());

      final message = await repository.cancelPaymentSession(sessionId);

      if (isClosed) return;
      emit(SessionCancelled(message));
    } catch (e) {
      _emitError(e);
    }
  }

  /// Get my payment sessions (receiver's sessions)
  Future<void> getMyPaymentSessions({
    int limit = 20,
    int offset = 0,
    String? statusFilter,
  }) async {
    try {
      if (isClosed) return;
      emit(ContactlessPaymentLoading());

      final result = await _retryWithBackoff(() => repository.getMyPaymentSessions(
        limit: limit,
        offset: offset,
        statusFilter: statusFilter,
      ));

      if (isClosed) return;
      emit(PaymentSessionsLoaded(
        sessions: result.sessions,
        total: result.total,
      ));
    } catch (e) {
      _emitError(e);
    }
  }

  /// Get my contactless payments (transactions I've made or received)
  Future<void> getMyContactlessPayments({
    int limit = 20,
    int offset = 0,
    String? roleFilter,
  }) async {
    try {
      if (isClosed) return;
      emit(ContactlessPaymentLoading());

      final result = await _retryWithBackoff(() => repository.getMyContactlessPayments(
        limit: limit,
        offset: offset,
        roleFilter: roleFilter,
      ));

      if (isClosed) return;
      emit(ContactlessPaymentsLoaded(
        transactions: result.transactions,
        total: result.total,
      ));
    } catch (e) {
      _emitError(e);
    }
  }

  /// Check session status (for polling)
  /// Silent errors for polling to avoid UI disruption
  Future<void> checkSessionStatus(String sessionId) async {
    try {
      if (isClosed) return;
      // Don't emit loading for polling to avoid UI flicker

      final result = await repository.checkSessionStatus(sessionId);

      if (isClosed) return;

      // Check if session expired
      if (result.status == 'expired') {
        emit(SessionExpired(
          sessionId: sessionId,
          message: 'Payment session has expired',
        ));
        return;
      }

      // If payment is completed, fetch the full transaction details
      if (result.status == 'completed') {
        try {
          // Get the transactions for this session
          final transactionsResult = await _retryWithBackoff(() => repository.getMyContactlessPayments(
            limit: 1,
            offset: 0,
            roleFilter: 'receiver',
          ));

          // Find the transaction for this session
          final transaction = transactionsResult.transactions.firstWhere(
            (t) => t.sessionId == sessionId,
            orElse: () => transactionsResult.transactions.first,
          );

          if (isClosed) return;
          emit(PaymentProcessedForReceiver(
            transaction: transaction,
            message: 'Payment received successfully',
          ));
          return;
        } catch (_) {
          // If we can't get the transaction, just emit the status checked state
        }
      }

      emit(SessionStatusChecked(
        status: result.status,
        payerName: result.payerName,
        updatedAt: result.updatedAt,
      ));
    } catch (e) {
      // Silent failure for polling - don't disrupt user experience
      // Only emit error for critical failures
      final (errorType, _) = _categorizeError(e);
      if (errorType == ContactlessErrorType.sessionNotFound ||
          errorType == ContactlessErrorType.sessionExpired) {
        if (isClosed) return;
        emit(SessionExpired(
          sessionId: sessionId,
          message: 'Payment session not found or expired',
        ));
      }
      // Network errors during polling are silently ignored
    }
  }

  /// Get transaction details for a specific session (for receiver to get completed payment details)
  Future<void> getTransactionForSession(String sessionId) async {
    try {
      if (isClosed) return;
      emit(ContactlessPaymentLoading());

      final transactionsResult = await _retryWithBackoff(() => repository.getMyContactlessPayments(
        limit: 10,
        offset: 0,
        roleFilter: 'receiver',
      ));

      // Find the transaction for this session
      final transaction = transactionsResult.transactions.firstWhere(
        (t) => t.sessionId == sessionId,
        orElse: () => throw Exception('Transaction not found for this session'),
      );

      if (isClosed) return;
      emit(PaymentProcessedForReceiver(
        transaction: transaction,
        message: 'Transaction details loaded',
      ));
    } catch (e) {
      _emitError(e);
    }
  }

  /// Reset state to initial
  void reset() {
    if (isClosed) return;
    emit(ContactlessPaymentInitial());
  }
}
