import 'dart:async';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/contactless_payment_repository.dart';
import 'contactless_payment_state.dart';

class ContactlessPaymentCubit extends Cubit<ContactlessPaymentState> {
  final ContactlessPaymentRepository repository;
  static const int _maxRetries = 3;
  static const Duration _retryDelay = Duration(seconds: 2);

  ContactlessPaymentCubit({required this.repository})
      : super(ContactlessPaymentInitial());

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

    if (errorMessage.contains('not found') || errorMessage.contains('404')) {
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
      if (session.expiresAt.isBefore(DateTime.now())) {
        emit(SessionExpired(
          sessionId: sessionId,
          message: 'This payment request has expired',
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

  /// Reset state to initial
  void reset() {
    if (isClosed) return;
    emit(ContactlessPaymentInitial());
  }
}
