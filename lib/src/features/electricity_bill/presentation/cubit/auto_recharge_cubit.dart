import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/auto_recharge_entity.dart';
import '../../domain/repositories/electricity_bill_repository.dart';
import 'auto_recharge_state.dart';

class AutoRechargeCubit extends Cubit<AutoRechargeState> {
  final ElectricityBillRepository repository;

  AutoRechargeCubit({required this.repository}) : super(AutoRechargeInitial());

  Future<void> createAutoRecharge({
    required String beneficiaryId,
    required double amount,
    required String currency,
    required RechargeFrequency frequency,
    int? dayOfWeek,
    int? dayOfMonth,
    int maxRetries = 3,
  }) async {
    if (isClosed) return;
    emit(AutoRechargeCreating());

    final result = await repository.createAutoRecharge(
      beneficiaryId: beneficiaryId,
      amount: amount,
      currency: currency,
      frequency: frequency,
      dayOfWeek: dayOfWeek,
      dayOfMonth: dayOfMonth,
      maxRetries: maxRetries,
    );

    if (isClosed) return;
    result.fold(
      (failure) => emit(AutoRechargeError(message: failure.message)),
      (autoRecharge) => emit(AutoRechargeCreated(autoRecharge: autoRecharge)),
    );
  }

  Future<void> getAutoRecharges() async {
    if (isClosed) return;
    emit(AutoRechargeLoading());

    final result = await repository.getAutoRecharges();

    if (isClosed) return;
    result.fold(
      (failure) => emit(AutoRechargeError(message: failure.message)),
      (autoRecharges) => emit(AutoRechargesLoaded(autoRecharges: autoRecharges)),
    );
  }


  Future<void> updateAutoRecharge({
    required String autoRechargeId,
    double? amount,
    RechargeFrequency? frequency,
    int? dayOfWeek,
    int? dayOfMonth,
    int? maxRetries,
  }) async {
    if (isClosed) return;
    emit(AutoRechargeUpdating());

    final result = await repository.updateAutoRecharge(
      autoRechargeId: autoRechargeId,
      amount: amount,
      frequency: frequency,
      dayOfWeek: dayOfWeek,
      dayOfMonth: dayOfMonth,
      maxRetries: maxRetries,
    );

    if (isClosed) return;
    result.fold(
      (failure) => emit(AutoRechargeError(message: failure.message)),
      (autoRecharge) => emit(AutoRechargeUpdated(autoRecharge: autoRecharge)),
    );
  }

  Future<void> pauseAutoRecharge({required String autoRechargeId}) async {
    if (isClosed) return;
    emit(AutoRechargePausing());

    final result = await repository.pauseAutoRecharge(autoRechargeId: autoRechargeId);

    if (isClosed) return;
    result.fold(
      (failure) => emit(AutoRechargeError(message: failure.message)),
      (_) => emit(AutoRechargePaused()),
    );
  }

  Future<void> resumeAutoRecharge({required String autoRechargeId}) async {
    if (isClosed) return;
    emit(AutoRechargeResuming());

    final result = await repository.resumeAutoRecharge(autoRechargeId: autoRechargeId);

    if (isClosed) return;
    result.fold(
      (failure) => emit(AutoRechargeError(message: failure.message)),
      (_) => emit(AutoRechargeResumed()),
    );
  }

  Future<void> deleteAutoRecharge({required String autoRechargeId}) async {
    if (isClosed) return;
    emit(AutoRechargeDeleting());

    final result = await repository.deleteAutoRecharge(autoRechargeId: autoRechargeId);

    if (isClosed) return;
    result.fold(
      (failure) => emit(AutoRechargeError(message: failure.message)),
      (_) => emit(AutoRechargeDeleted()),
    );
  }

  void reset() {
    if (isClosed) return;
    emit(AutoRechargeInitial());
  }
}
