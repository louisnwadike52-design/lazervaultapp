import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/datasources/water_beneficiary_remote_datasource.dart';
import 'water_auto_recharge_state.dart';

/// Cubit for managing water bill auto-recharge schedules.
class WaterAutoRechargeCubit extends Cubit<WaterAutoRechargeState> {
  final WaterBeneficiaryRemoteDataSource datasource;

  WaterAutoRechargeCubit({required this.datasource})
      : super(WaterAutoRechargeInitial());

  Future<void> load({String? status}) async {
    if (isClosed) return;
    emit(WaterAutoRechargesLoading());
    try {
      final list = await datasource.getAutoRecharges(status: status);
      if (isClosed) return;
      emit(WaterAutoRechargesLoaded(autoRecharges: list));
    } catch (e) {
      if (isClosed) return;
      emit(WaterAutoRechargeError(message: _friendly(e)));
    }
  }

  Future<void> create({
    required String beneficiaryId,
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
    emit(WaterAutoRechargeMutating());
    try {
      await datasource.createAutoRecharge(
        beneficiaryId: beneficiaryId,
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
      emit(const WaterAutoRechargeMutated(message: 'Auto-pay scheduled'));
      await load();
    } catch (e) {
      if (isClosed) return;
      emit(WaterAutoRechargeError(message: _friendly(e)));
      rethrow;
    }
  }

  Future<void> update({
    required String autoRechargeId,
    double? amount,
    String? frequency,
    int? dayOfWeek,
    int? dayOfMonth,
    int? maxRetries,
    int? executionHour,
    int? executionMinute,
  }) async {
    if (isClosed) return;
    emit(WaterAutoRechargeMutating());
    try {
      await datasource.updateAutoRecharge(
        autoRechargeId: autoRechargeId,
        amount: amount,
        frequency: frequency,
        dayOfWeek: dayOfWeek,
        dayOfMonth: dayOfMonth,
        maxRetries: maxRetries,
        executionHour: executionHour,
        executionMinute: executionMinute,
      );
      if (isClosed) return;
      emit(const WaterAutoRechargeMutated(message: 'Auto-pay updated'));
      await load();
    } catch (e) {
      if (isClosed) return;
      emit(WaterAutoRechargeError(message: _friendly(e)));
      rethrow;
    }
  }

  Future<void> pause(String id) async {
    try {
      await datasource.pauseAutoRecharge(id);
      if (isClosed) return;
      emit(const WaterAutoRechargeMutated(message: 'Auto-pay paused'));
      await load();
    } catch (e) {
      if (isClosed) return;
      emit(WaterAutoRechargeError(message: _friendly(e)));
      rethrow;
    }
  }

  Future<void> resume(String id) async {
    try {
      await datasource.resumeAutoRecharge(id);
      if (isClosed) return;
      emit(const WaterAutoRechargeMutated(message: 'Auto-pay resumed'));
      await load();
    } catch (e) {
      if (isClosed) return;
      emit(WaterAutoRechargeError(message: _friendly(e)));
      rethrow;
    }
  }

  Future<void> delete(String id) async {
    try {
      await datasource.deleteAutoRecharge(id);
      if (isClosed) return;
      emit(const WaterAutoRechargeMutated(message: 'Auto-pay deleted'));
      await load();
    } catch (e) {
      if (isClosed) return;
      emit(WaterAutoRechargeError(message: _friendly(e)));
      rethrow;
    }
  }

  String _friendly(Object e) =>
      e.toString().replaceFirst(RegExp(r'^Exception:\s*'), '');
}
