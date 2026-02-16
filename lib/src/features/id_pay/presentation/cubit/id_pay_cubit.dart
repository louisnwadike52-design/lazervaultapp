import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/id_pay_entity.dart';
import '../../domain/repositories/id_pay_repository.dart';
import 'id_pay_state.dart';

class IDPayCubit extends Cubit<IDPayState> {
  final IDPayRepository repository;

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
    );

    if (isClosed) return;
    result.fold(
      (failure) => emit(IDPayError(message: failure.message)),
      (idPay) => emit(IDPayCreated(idPay: idPay)),
    );
  }

  Future<void> lookupIDPay({required String payId}) async {
    if (isClosed) return;
    emit(IDPayLoading());

    final result = await repository.lookupIDPay(payId: payId);

    if (isClosed) return;
    result.fold(
      (failure) => emit(IDPayError(message: failure.message)),
      (idPay) => emit(IDPayLookedUp(idPay: idPay)),
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
      (idPays) => emit(MyIDPaysLoaded(idPays: idPays)),
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
      (_) => emit(IDPayCancelled()),
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

  void reset() {
    if (isClosed) return;
    emit(IDPayInitial());
  }
}
