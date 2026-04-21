import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/datasources/data_beneficiary_remote_datasource.dart';
import 'data_auto_recharge_state.dart';

/// Cubit for managing data "Rollover" (auto-recharge) schedules. Mirrors
/// the auto-recharge slice of `AirtimeCubit`. Each schedule re-buys the
/// SAME data variation (`variationId` + `planName`) at a recurring
/// cadence — variation-locked by design so users don't get surprise
/// pricing when providers retire bundles.
class DataAutoRechargeCubit extends Cubit<DataAutoRechargeState> {
  final DataBeneficiaryRemoteDataSource datasource;

  DataAutoRechargeCubit({required this.datasource})
      : super(DataAutoRechargeInitial());

  Future<void> load({String? status}) async {
    if (isClosed) return;
    emit(DataAutoRechargesLoading());
    try {
      final list = await datasource.getAutoRecharges(status: status);
      if (isClosed) return;
      emit(DataAutoRechargesLoaded(autoRecharges: list));
    } catch (e) {
      if (isClosed) return;
      emit(DataAutoRechargeError(message: _friendly(e)));
    }
  }

  Future<void> create({
    required String beneficiaryId,
    required String variationId,
    required String planName,
    required double amount,
    required String currency,
    required String frequency,
    int dayOfWeek = 0,
    int dayOfMonth = 1,
    int maxRetries = 3,
    int? executionHour,
    int? executionMinute,
  }) async {
    if (isClosed) return;
    emit(DataAutoRechargeMutating());
    try {
      await datasource.createAutoRecharge(
        beneficiaryId: beneficiaryId,
        variationId: variationId,
        planName: planName,
        amount: amount,
        currency: currency,
        frequency: frequency,
        dayOfWeek: dayOfWeek,
        dayOfMonth: dayOfMonth,
        maxRetries: maxRetries,
        executionHour: executionHour,
        executionMinute: executionMinute,
      );
      if (isClosed) return;
      emit(const DataAutoRechargeMutated(message: 'Rollover scheduled'));
      await load();
    } catch (e) {
      if (isClosed) return;
      emit(DataAutoRechargeError(message: _friendly(e)));
      rethrow;
    }
  }

  Future<void> update({
    required String autoRechargeId,
    String? variationId,
    String? planName,
    double? amount,
    String? frequency,
    int? dayOfWeek,
    int? dayOfMonth,
    int? maxRetries,
    int? executionHour,
    int? executionMinute,
  }) async {
    if (isClosed) return;
    emit(DataAutoRechargeMutating());
    try {
      await datasource.updateAutoRecharge(
        autoRechargeId: autoRechargeId,
        variationId: variationId,
        planName: planName,
        amount: amount,
        frequency: frequency,
        dayOfWeek: dayOfWeek,
        dayOfMonth: dayOfMonth,
        maxRetries: maxRetries,
        executionHour: executionHour,
        executionMinute: executionMinute,
      );
      if (isClosed) return;
      emit(const DataAutoRechargeMutated(message: 'Rollover updated'));
      await load();
    } catch (e) {
      if (isClosed) return;
      emit(DataAutoRechargeError(message: _friendly(e)));
      rethrow;
    }
  }

  Future<void> pause(String id) async {
    try {
      await datasource.pauseAutoRecharge(id);
      if (isClosed) return;
      emit(const DataAutoRechargeMutated(message: 'Rollover paused'));
      await load();
    } catch (e) {
      if (isClosed) return;
      emit(DataAutoRechargeError(message: _friendly(e)));
      rethrow;
    }
  }

  Future<void> resume(String id) async {
    try {
      await datasource.resumeAutoRecharge(id);
      if (isClosed) return;
      emit(const DataAutoRechargeMutated(message: 'Rollover resumed'));
      await load();
    } catch (e) {
      if (isClosed) return;
      emit(DataAutoRechargeError(message: _friendly(e)));
      rethrow;
    }
  }

  Future<void> delete(String id) async {
    try {
      await datasource.deleteAutoRecharge(id);
      if (isClosed) return;
      emit(const DataAutoRechargeMutated(message: 'Rollover deleted'));
      await load();
    } catch (e) {
      if (isClosed) return;
      emit(DataAutoRechargeError(message: _friendly(e)));
      rethrow;
    }
  }

  String _friendly(Object e) =>
      e.toString().replaceFirst(RegExp(r'^Exception:\s*'), '');
}
