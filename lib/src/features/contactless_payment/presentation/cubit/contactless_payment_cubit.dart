import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/contactless_payment_repository.dart';
import 'contactless_payment_state.dart';

class ContactlessPaymentCubit extends Cubit<ContactlessPaymentState> {
  final ContactlessPaymentRepository repository;

  ContactlessPaymentCubit({required this.repository})
      : super(ContactlessPaymentInitial());

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

      final result = await repository.createPaymentSession(
        amount: amount,
        currency: currency,
        category: category,
        description: description,
        validitySeconds: validitySeconds,
      );

      if (isClosed) return;
      emit(PaymentSessionCreated(
        session: result.session,
        nfcPayload: result.nfcPayload,
        message: result.message,
      ));
    } catch (e) {
      if (isClosed) return;
      emit(ContactlessPaymentError(e.toString()));
    }
  }

  /// Get payment session by ID (payer reads this from NFC)
  Future<void> getPaymentSession(String sessionId) async {
    try {
      if (isClosed) return;
      emit(ContactlessPaymentLoading());

      final session = await repository.getPaymentSession(sessionId);

      if (isClosed) return;
      emit(PaymentSessionLoaded(session));
    } catch (e) {
      if (isClosed) return;
      emit(ContactlessPaymentError(e.toString()));
    }
  }

  /// Acknowledge that payer has read the session (via NFC)
  Future<void> acknowledgeSessionRead(String sessionId) async {
    try {
      if (isClosed) return;
      emit(ContactlessPaymentLoading());

      final result = await repository.acknowledgeSessionRead(sessionId);

      if (isClosed) return;
      emit(SessionReadAcknowledged(
        session: result.session,
        message: result.message,
      ));
    } catch (e) {
      if (isClosed) return;
      emit(ContactlessPaymentError(e.toString()));
    }
  }

  /// Process the contactless payment (payer confirms payment)
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
      emit(ContactlessPaymentError(e.toString()));
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
      if (isClosed) return;
      emit(ContactlessPaymentError(e.toString()));
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

      final result = await repository.getMyPaymentSessions(
        limit: limit,
        offset: offset,
        statusFilter: statusFilter,
      );

      if (isClosed) return;
      emit(PaymentSessionsLoaded(
        sessions: result.sessions,
        total: result.total,
      ));
    } catch (e) {
      if (isClosed) return;
      emit(ContactlessPaymentError(e.toString()));
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

      final result = await repository.getMyContactlessPayments(
        limit: limit,
        offset: offset,
        roleFilter: roleFilter,
      );

      if (isClosed) return;
      emit(ContactlessPaymentsLoaded(
        transactions: result.transactions,
        total: result.total,
      ));
    } catch (e) {
      if (isClosed) return;
      emit(ContactlessPaymentError(e.toString()));
    }
  }

  /// Check session status (for polling)
  Future<void> checkSessionStatus(String sessionId) async {
    try {
      if (isClosed) return;
      // Don't emit loading for polling to avoid UI flicker

      final result = await repository.checkSessionStatus(sessionId);

      if (isClosed) return;
      emit(SessionStatusChecked(
        status: result.status,
        payerName: result.payerName,
        updatedAt: result.updatedAt,
      ));
    } catch (e) {
      if (isClosed) return;
      emit(ContactlessPaymentError(e.toString()));
    }
  }

  /// Reset state to initial
  void reset() {
    if (isClosed) return;
    emit(ContactlessPaymentInitial());
  }
}
