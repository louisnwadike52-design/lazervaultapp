import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/id_pay_entity.dart';
import '../../domain/entities/id_pay_organization_entity.dart';
import '../../domain/repositories/id_pay_repository.dart';
import '../../services/id_pay_websocket_service.dart';
import 'id_pay_state.dart';

/// WS health for the creator's IDPay screen — drives adaptive polling
/// in the IDPay display widget (parity with QR-pay / contactless).
enum IDPayWsHealth { connecting, connected, failed }

class IDPayCubit extends Cubit<IDPayState> {
  final IDPayRepository repository;
  List<IDPayEntity> _cachedIDPays = [];
  List<IDPayOrganizationEntity> _cachedOrganizations = [];

  /// Optional WS service for realtime payment-completed pushes. Nil-safe
  /// (tests + flows that don't subscribe still work). Mirrors qr_payment.
  final IDPayWebSocketService? wsService;

  /// Public health signal — UI listens to flip its polling cadence.
  final ValueNotifier<IDPayWsHealth> wsHealth =
      ValueNotifier(IDPayWsHealth.connecting);

  StreamSubscription<IDPayStatusEvent>? _wsEvents;
  StreamSubscription<IDPayWebSocketConnectionState>? _wsConn;
  Timer? _wsTimeoutTimer;

  /// How long we wait for a `connected` before flipping wsHealth to
  /// `failed`. Mirrors the contactless + QR timeout.
  static const Duration _wsConnectTimeout = Duration(seconds: 8);

  IDPayCubit({required this.repository, this.wsService})
      : super(IDPayInitial());

  /// Subscribe the creator's screen to realtime "Paid by …" events.
  /// Drives [wsHealth] through every state transition so the screen can
  /// adapt its polling cadence accordingly.
  Future<void> subscribeToCreatedIDPay({
    required String creatorUserId,
    required String accessToken,
    required void Function(IDPayStatusEvent event) onEvent,
  }) async {
    if (wsService == null) {
      wsHealth.value = IDPayWsHealth.failed;
      return;
    }
    wsHealth.value = IDPayWsHealth.connecting;
    _wsTimeoutTimer?.cancel();
    _wsEvents?.cancel();
    _wsConn?.cancel();
    try {
      _wsConn = wsService!.connectionState.listen((cs) {
        if (cs == IDPayWebSocketConnectionState.connected) {
          _wsTimeoutTimer?.cancel();
          wsHealth.value = IDPayWsHealth.connected;
        } else if (cs == IDPayWebSocketConnectionState.error ||
            cs == IDPayWebSocketConnectionState.disconnected) {
          wsHealth.value = IDPayWsHealth.failed;
        }
      });
      _wsEvents = wsService!.updates.listen(onEvent);
      await wsService!.connect(
          userId: creatorUserId, accessToken: accessToken);
      // Connect resolves quickly; rely on the connectionState listener
      // above to confirm `connected` (or flip to failed on timeout).
      _wsTimeoutTimer = Timer(_wsConnectTimeout, () {
        if (wsHealth.value != IDPayWsHealth.connected) {
          wsHealth.value = IDPayWsHealth.failed;
        }
      });
    } catch (_) {
      wsHealth.value = IDPayWsHealth.failed;
    }
  }

  /// Tear down the WS subscription. Safe to call multiple times.
  Future<void> unsubscribeFromIDPay() async {
    _wsTimeoutTimer?.cancel();
    await _wsEvents?.cancel();
    await _wsConn?.cancel();
    _wsEvents = null;
    _wsConn = null;
    await wsService?.disconnect();
  }

  @override
  Future<void> close() async {
    await unsubscribeFromIDPay();
    wsHealth.dispose();
    return super.close();
  }

  Future<void> createIDPay({
    required IDPayType type,
    required IDPayAmountMode amountMode,
    required double amount,
    required String currency,
    double? minAmount,
    double? maxAmount,
    String? description,
    required int validityMinutes,
    bool neverExpires = false,
    String? organizationId,
  }) async {
    if (isClosed) return;
    emit(IDPayLoading());

    final result = await repository.createIDPay(
      type: type,
      amountMode: amountMode,
      amount: amount,
      currency: currency,
      minAmount: minAmount,
      maxAmount: maxAmount,
      description: description,
      validityMinutes: validityMinutes,
      neverExpires: neverExpires,
      organizationId: organizationId,
    );

    if (isClosed) return;
    result.fold(
      (failure) => emit(IDPayError(message: failure.message)),
      (idPay) {
        _cachedIDPays = [idPay, ..._cachedIDPays];
        emit(IDPayCreated(idPay: idPay));
        if (!isClosed) emit(MyIDPaysLoaded(idPays: _cachedIDPays));
      },
    );
  }

  Future<void> lookupIDPay({required String payId}) async {
    if (isClosed) return;
    emit(IDPayLoading());

    final result = await repository.lookupIDPayWithOrg(payId: payId);

    if (isClosed) return;
    result.fold(
      (failure) => emit(IDPayError(message: failure.message)),
      (data) => emit(IDPayLookedUpWithOrg(
        idPay: data.$1,
        organization: data.$2,
      )),
    );
  }

  Future<void> payIDPay({
    required String payId,
    required double amount,
    required String transactionPin,
    required String sourceAccountId,
    String? idempotencyKey,
  }) async {
    if (isClosed) return;
    // Generate an idempotency key when the caller hasn't supplied one so a
    // retry after a network blip becomes a no-op server-side. Previously
    // null was always sent, which meant every retry tried to re-debit the
    // user. Mirrors the electricity-bill / transfer cubit pattern.
    final effectiveKey = idempotencyKey ?? const Uuid().v4();
    emit(IDPayProcessing(payId: payId, amount: amount));

    final result = await repository.payIDPay(
      payId: payId,
      amount: amount,
      transactionPin: transactionPin,
      sourceAccountId: sourceAccountId,
      idempotencyKey: effectiveKey,
    );

    if (isClosed) return;
    result.fold(
      (failure) {
        final msg = failure.message.toLowerCase();
        if (msg.contains('insufficient')) {
          emit(IDPayInsufficientFunds(message: failure.message));
        } else {
          emit(IDPayError(message: failure.message));
        }
      },
      (data) => emit(IDPayPaid(transaction: data.$1, newBalance: data.$2)),
    );
  }

  Future<void> getMyIDPays({
    int? limit,
    int? offset,
    IDPayStatus? statusFilter,
  }) async {
    if (isClosed) return;
    emit(IDPayLoading());

    final result = await repository.getMyIDPays(
      limit: limit,
      offset: offset,
      statusFilter: statusFilter,
    );

    if (isClosed) return;
    result.fold(
      (failure) => emit(IDPayError(message: failure.message)),
      (idPays) {
        _cachedIDPays = idPays;
        emit(MyIDPaysLoaded(idPays: _cachedIDPays));
      },
    );
  }

  Future<void> getIDPayTransactions({
    required String payId,
    int? limit,
    int? offset,
  }) async {
    if (isClosed) return;
    emit(IDPayLoading());

    final result = await repository.getIDPayTransactions(
      payId: payId,
      limit: limit,
      offset: offset,
    );

    if (isClosed) return;
    result.fold(
      (failure) => emit(IDPayError(message: failure.message)),
      (transactions) =>
          emit(IDPayTransactionsLoaded(transactions: transactions)),
    );
  }

  Future<void> cancelIDPay({required String id}) async {
    if (isClosed) return;
    emit(IDPayLoading());

    final result = await repository.cancelIDPay(id: id);

    if (isClosed) return;
    result.fold(
      (failure) => emit(IDPayError(message: failure.message)),
      (_) {
        _cachedIDPays = _cachedIDPays.map((idPay) {
          if (idPay.id == id) {
            return idPay.copyWith(status: IDPayStatus.cancelled);
          }
          return idPay;
        }).toList();
        emit(IDPayCancelled());
        if (!isClosed) emit(MyIDPaysLoaded(idPays: _cachedIDPays));
      },
    );
  }

  Future<void> getIDPayDetails({required String id}) async {
    if (isClosed) return;
    emit(IDPayLoading());

    final result = await repository.getIDPayDetails(id: id);

    if (isClosed) return;
    result.fold(
      (failure) => emit(IDPayError(message: failure.message)),
      (idPay) => emit(IDPayDetailsLoaded(idPay: idPay)),
    );
  }

  // Organization methods

  Future<void> createOrganization({
    required String name,
    required String description,
    String? logoUrl,
    required String accountId,
  }) async {
    if (isClosed) return;
    emit(IDPayLoading());

    final result = await repository.createOrganization(
      name: name,
      description: description,
      logoUrl: logoUrl,
      accountId: accountId,
    );

    if (isClosed) return;
    result.fold(
      (failure) => emit(IDPayError(message: failure.message)),
      (org) {
        _cachedOrganizations = [org, ..._cachedOrganizations];
        emit(IDPayOrganizationCreated(organization: org));
        if (!isClosed) {
          emit(IDPayOrganizationsLoaded(organizations: _cachedOrganizations));
        }
      },
    );
  }

  Future<void> getMyOrganizations({
    required String accountId,
    int? limit,
    int? offset,
  }) async {
    if (isClosed) return;
    emit(IDPayLoading());

    final result = await repository.getMyOrganizations(
      accountId: accountId,
      limit: limit,
      offset: offset,
    );

    if (isClosed) return;
    result.fold(
      (failure) => emit(IDPayError(message: failure.message)),
      (data) {
        _cachedOrganizations = data.$1;
        emit(IDPayOrganizationsLoaded(organizations: _cachedOrganizations));
      },
    );
  }

  Future<void> updateOrganization({
    required String id,
    String? name,
    String? description,
    String? logoUrl,
  }) async {
    if (isClosed) return;
    emit(IDPayLoading());

    final result = await repository.updateOrganization(
      id: id,
      name: name,
      description: description,
      logoUrl: logoUrl,
    );

    if (isClosed) return;
    result.fold(
      (failure) => emit(IDPayError(message: failure.message)),
      (org) {
        _cachedOrganizations = _cachedOrganizations.map((o) {
          return o.id == id ? org : o;
        }).toList();
        emit(IDPayOrganizationUpdated(organization: org));
        if (!isClosed) {
          emit(IDPayOrganizationsLoaded(organizations: _cachedOrganizations));
        }
      },
    );
  }

  Future<void> deleteOrganization({required String id}) async {
    if (isClosed) return;
    emit(IDPayLoading());

    final result = await repository.deleteOrganization(id: id);

    if (isClosed) return;
    result.fold(
      (failure) => emit(IDPayError(message: failure.message)),
      (_) {
        _cachedOrganizations =
            _cachedOrganizations.where((o) => o.id != id).toList();
        emit(IDPayOrganizationDeleted());
        if (!isClosed) {
          emit(IDPayOrganizationsLoaded(organizations: _cachedOrganizations));
        }
      },
    );
  }

  Future<void> getOrganizationDetails({required String id}) async {
    if (isClosed) return;
    emit(IDPayLoading());

    final result = await repository.getOrganizationDetails(id: id);

    if (isClosed) return;
    result.fold(
      (failure) => emit(IDPayError(message: failure.message)),
      (data) => emit(IDPayOrganizationDetailsLoaded(
        organization: data.$1,
        idPays: data.$2,
        totalPaidOut: data.$3,
      )),
    );
  }

  /// Load organizations without emitting loading state.
  /// Used for populating dropdowns without disrupting the main UI flow.
  Future<List<IDPayOrganizationEntity>> loadOrganizationsQuietly({
    required String accountId,
  }) async {
    final result = await repository.getMyOrganizations(
      accountId: accountId,
      limit: 100,
      offset: 0,
    );
    return result.fold(
      (_) => <IDPayOrganizationEntity>[],
      (data) {
        _cachedOrganizations = data.$1;
        return data.$1;
      },
    );
  }

  void reset() {
    if (isClosed) return;
    emit(IDPayInitial());
  }
}
