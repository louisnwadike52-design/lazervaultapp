import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/src/core/errors/failures.dart';
import '../../domain/entities/qr_payment_entity.dart';
import '../../domain/entities/qr_transaction_entity.dart';
import '../../domain/repositories/qr_payment_repository.dart';
import '../../services/qr_pay_websocket_service.dart';
import 'qr_payment_state.dart';

/// Health of the realtime WS overlay. Mirrors `ContactlessWsHealth` —
/// generator screen reads this to decide its polling cadence
/// (`connecting`/`connected` ⇒ 3s, `failed` ⇒ 1s).
enum QrPayWsHealth { connecting, connected, failed }

class QRPaymentCubit extends Cubit<QRPaymentState> {
  final QRPaymentRepository repository;
  /// Realtime WS overlay for the generator-side QR display screen. When
  /// set, `subscribeToGeneratedQR` connects and listens for the payer's
  /// completion event. Polling continues regardless so a WS failure is
  /// pure speedup-loss, never a correctness issue.
  final QrPayWebSocketService? wsService;
  StreamSubscription<QrPayStatusEvent>? _wsSub;
  StreamSubscription<QrPayWebSocketConnectionState>? _wsConnSub;
  Timer? _wsTimeoutTimer;
  bool _wsConnected = false;
  String? _activeQrCode;
  /// Publicly observable WS health. The display screen listens here:
  /// `connected` → keeps the relaxed 3 s poll; `failed` → tightens to 1 s
  /// so a permanently-dead WS still settles within ~1 s of the payer's
  /// debit landing.
  final ValueNotifier<QrPayWsHealth> wsHealth =
      ValueNotifier(QrPayWsHealth.connecting);
  static const Duration _wsConnectTimeout = Duration(seconds: 8);

  QRPaymentCubit({
    required this.repository,
    this.wsService,
  }) : super(QRPaymentInitial());

  /// Connect the WS overlay after a QR has been generated, so the
  /// display screen flips to a "Paid by …" state the moment the payer's
  /// debit lands instead of waiting for the next getQRDetails poll.
  /// Idempotent — safe to call repeatedly on screen re-entry. Drives
  /// `wsHealth` through every state transition so the screen can adapt
  /// its polling cadence.
  Future<void> subscribeToGeneratedQR({
    required String userId,
    required String accessToken,
    required String qrCode,
  }) async {
    if (wsService == null) {
      wsHealth.value = QrPayWsHealth.failed;
      return;
    }
    _activeQrCode = qrCode;
    wsHealth.value = QrPayWsHealth.connecting;
    try {
      await wsService!.connect(userId: userId, accessToken: accessToken);
      _wsSub?.cancel();
      _wsSub = wsService!.updates.listen(_onWsEvent);
      _wsConnSub?.cancel();
      _wsConnSub = wsService!.connectionState.listen((s) {
        if (s == QrPayWebSocketConnectionState.connected) {
          _wsConnected = true;
          wsHealth.value = QrPayWsHealth.connected;
        } else if (s == QrPayWebSocketConnectionState.error ||
            s == QrPayWebSocketConnectionState.disconnected) {
          _wsConnected = false;
          wsHealth.value = QrPayWsHealth.failed;
        }
      });
      _wsConnected = true;
      wsHealth.value = QrPayWsHealth.connected;
      _wsTimeoutTimer?.cancel();
      _wsTimeoutTimer = Timer(_wsConnectTimeout, () {
        if (!_wsConnected) {
          wsHealth.value = QrPayWsHealth.failed;
          // ignore: avoid_print
          print('QRPaymentCubit: WS connect timed out — '
              'screen should tighten polling to 1s');
        }
      });
    } catch (e) {
      wsHealth.value = QrPayWsHealth.failed;
      // ignore: avoid_print
      print('QRPaymentCubit: WS connect failed: $e — '
          'screen should tighten polling to 1s');
    }
  }

  void _onWsEvent(QrPayStatusEvent ev) {
    if (ev.qrCode != _activeQrCode) return;
    if (ev.eventType == 'qr.payment.completed') {
      // Trigger the canonical getQRDetails refresh — the response
      // payload carries the now-paid status so the existing
      // QRDetailsLoaded -> QRPaymentSuccess transition fires naturally.
      // ignore: discarded_futures
      getQRDetails(qrCode: ev.qrCode);
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

  Future<void> generateQR({
    required double amount,
    required String currency,
    String? description,
    QRPaymentType qrType = QRPaymentType.dynamic,
    int? validityMinutes,
  }) async {
    if (isClosed) return;
    emit(QRPaymentLoading());

    final result = await repository.generateQR(
      amount: amount,
      currency: currency,
      description: description,
      qrType: qrType,
      validityMinutes: validityMinutes,
    );

    if (isClosed) return;
    result.fold(
      (failure) => emit(QRPaymentError(message: failure.message)),
      (data) {
        final (qrCode, qrData) = data;
        emit(QRGenerated(qrCode: qrCode, qrData: qrData));
      },
    );
  }

  Future<void> getQRDetails({required String qrCode}) async {
    if (isClosed) return;
    emit(QRPaymentLoading());

    final result = await repository.getQRDetails(qrCode: qrCode);

    if (isClosed) return;
    result.fold(
      (failure) => emit(QRPaymentError(message: failure.message)),
      (qr) => emit(QRDetailsLoaded(qrCode: qr)),
    );
  }

  Future<void> processQRPayment({
    required String qrCode,
    required String sourceAccountId,
    required double amount,
    required String transactionPin,
    String? idempotencyKey,
  }) async {
    if (isClosed) return;
    emit(QRPaymentProcessing());

    final result = await repository.processQRPayment(
      qrCode: qrCode,
      sourceAccountId: sourceAccountId,
      amount: amount,
      transactionPin: transactionPin,
      idempotencyKey: idempotencyKey,
    );

    if (isClosed) return;
    result.fold(
      (failure) => emit(QRPaymentError(message: failure.message)),
      (data) {
        final (transaction, newBalance) = data;
        emit(QRPaymentSuccess(
          transaction: transaction,
          newBalance: newBalance,
        ));
      },
    );
  }

  Future<void> getMyGeneratedQRCodes({
    int? limit,
    int? offset,
    QRPaymentStatus? statusFilter,
  }) async {
    if (isClosed) return;
    emit(QRPaymentLoading());

    final result = await repository.getMyGeneratedQRCodes(
      limit: limit,
      offset: offset,
      statusFilter: statusFilter,
    );

    if (isClosed) return;
    result.fold(
      (failure) => emit(QRPaymentError(message: failure.message)),
      (qrCodes) => emit(GeneratedQRCodesLoaded(qrCodes: qrCodes)),
    );
  }

  Future<void> getMyQRPayments({int? limit, int? offset}) async {
    if (isClosed) return;
    emit(QRPaymentLoading());

    final result = await repository.getMyQRPayments(
      limit: limit,
      offset: offset,
    );

    if (isClosed) return;
    result.fold(
      (failure) => emit(QRPaymentError(message: failure.message)),
      (transactions) => emit(QRPaymentsLoaded(transactions: transactions)),
    );
  }

  Future<void> cancelQR({required String qrId}) async {
    if (isClosed) return;
    emit(QRPaymentLoading());

    final result = await repository.cancelQR(qrId: qrId);

    if (isClosed) return;
    result.fold(
      (failure) => emit(QRPaymentError(message: failure.message)),
      (_) {
        emit(QRCancelled(message: 'QR code cancelled successfully'));
        getMyGeneratedQRCodes();
      },
    );
  }

  Future<void> getTransactionReceipt({required String transactionId}) async {
    if (isClosed) return;
    emit(QRPaymentLoading());

    final result = await repository.getQRTransactionReceipt(
      transactionId: transactionId,
    );

    if (isClosed) return;
    result.fold(
      (failure) => emit(QRPaymentError(message: failure.message)),
      (transaction) =>
          emit(QRTransactionReceiptLoaded(transaction: transaction)),
    );
  }

  Future<void> getRecentActivity() async {
    if (isClosed) return;
    emit(QRPaymentLoading());

    final results = await Future.wait([
      repository.getMyGeneratedQRCodes(limit: 3),
      repository.getMyQRPayments(limit: 3),
    ]);

    if (isClosed) return;

    final qrCodesResult = results[0] as Either<Failure, List<QRPaymentEntity>>;
    final paymentsResult =
        results[1] as Either<Failure, List<QRTransactionEntity>>;

    emit(QRRecentActivityLoaded(
      recentQRCodes: qrCodesResult.getOrElse(() => []),
      recentPayments: paymentsResult.getOrElse(() => []),
    ));
  }

  void reset() {
    if (isClosed) return;
    emit(QRPaymentInitial());
  }
}
