import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/id_pay_entity.dart';
import '../../domain/entities/id_pay_organization_entity.dart';
import '../../domain/repositories/id_pay_repository.dart';
import 'id_pay_state.dart';

class IDPayCubit extends Cubit<IDPayState> {
  final IDPayRepository repository;
  List<IDPayEntity> _cachedIDPays = [];
  List<IDPayOrganizationEntity> _cachedOrganizations = [];

  IDPayCubit({required this.repository}) : super(IDPayInitial());

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
    emit(IDPayLoading());

    final result = await repository.payIDPay(
      payId: payId,
      amount: amount,
      transactionPin: transactionPin,
      sourceAccountId: sourceAccountId,
      idempotencyKey: idempotencyKey,
    );

    if (isClosed) return;
    result.fold(
      (failure) => emit(IDPayError(message: failure.message)),
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

  void reset() {
    if (isClosed) return;
    emit(IDPayInitial());
  }
}
