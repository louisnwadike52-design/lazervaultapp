import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/datasources/cable_tv_beneficiary_remote_datasource.dart';
import 'cable_tv_auto_recharge_state.dart';

/// Cubit for managing cable TV auto-renew schedules.
class CableTVAutoRechargeCubit extends Cubit<CableTVAutoRechargeState> {
  final CableTVBeneficiaryRemoteDataSource datasource;

  CableTVAutoRechargeCubit({required this.datasource})
      : super(CableTVAutoRechargeInitial());

  Future<void> load({String? status}) async {
    if (isClosed) return;
    emit(CableTVAutoRechargesLoading());
    try {
      final list = await datasource.getAutoRecharges(status: status);
      if (isClosed) return;
      emit(CableTVAutoRechargesLoaded(autoRecharges: list));
    } catch (e) {
      if (isClosed) return;
      emit(CableTVAutoRechargeError(message: _friendly(e)));
    }
  }

  Future<void> create({
    required String beneficiaryId,
    required String variationCode,
    required String packageName,
    required double amount,
    required String currency,
    required String subscriptionType,
    required String frequency,
    int dayOfWeek = 0,
    int dayOfMonth = 1,
    int maxRetries = 3,
    int? executionHour,
    int? executionMinute,
  }) async {
    if (isClosed) return;
    emit(CableTVAutoRechargeMutating());
    try {
      await datasource.createAutoRecharge(
        beneficiaryId: beneficiaryId,
        variationCode: variationCode,
        packageName: packageName,
        amount: amount,
        currency: currency,
        subscriptionType: subscriptionType,
        frequency: frequency,
        dayOfWeek: dayOfWeek,
        dayOfMonth: dayOfMonth,
        maxRetries: maxRetries,
        executionHour: executionHour,
        executionMinute: executionMinute,
      );
      if (isClosed) return;
      emit(const CableTVAutoRechargeMutated(message: 'Auto-renew scheduled'));
      await load();
    } catch (e) {
      if (isClosed) return;
      emit(CableTVAutoRechargeError(message: _friendly(e)));
      rethrow;
    }
  }

  Future<void> update({
    required String autoRechargeId,
    String? variationCode,
    String? packageName,
    double? amount,
    String? frequency,
    int? dayOfWeek,
    int? dayOfMonth,
    int? maxRetries,
    int? executionHour,
    int? executionMinute,
  }) async {
    if (isClosed) return;
    emit(CableTVAutoRechargeMutating());
    try {
      await datasource.updateAutoRecharge(
        autoRechargeId: autoRechargeId,
        variationCode: variationCode,
        packageName: packageName,
        amount: amount,
        frequency: frequency,
        dayOfWeek: dayOfWeek,
        dayOfMonth: dayOfMonth,
        maxRetries: maxRetries,
        executionHour: executionHour,
        executionMinute: executionMinute,
      );
      if (isClosed) return;
      emit(const CableTVAutoRechargeMutated(message: 'Auto-renew updated'));
      await load();
    } catch (e) {
      if (isClosed) return;
      emit(CableTVAutoRechargeError(message: _friendly(e)));
      rethrow;
    }
  }

  Future<void> pause(String id) async {
    try {
      await datasource.pauseAutoRecharge(id);
      if (isClosed) return;
      emit(const CableTVAutoRechargeMutated(message: 'Auto-renew paused'));
      await load();
    } catch (e) {
      if (isClosed) return;
      emit(CableTVAutoRechargeError(message: _friendly(e)));
      rethrow;
    }
  }

  Future<void> resume(String id) async {
    try {
      await datasource.resumeAutoRecharge(id);
      if (isClosed) return;
      emit(const CableTVAutoRechargeMutated(message: 'Auto-renew resumed'));
      await load();
    } catch (e) {
      if (isClosed) return;
      emit(CableTVAutoRechargeError(message: _friendly(e)));
      rethrow;
    }
  }

  Future<void> delete(String id) async {
    try {
      await datasource.deleteAutoRecharge(id);
      if (isClosed) return;
      emit(const CableTVAutoRechargeMutated(message: 'Auto-renew deleted'));
      await load();
    } catch (e) {
      if (isClosed) return;
      emit(CableTVAutoRechargeError(message: _friendly(e)));
      rethrow;
    }
  }

  String _friendly(Object e) =>
      e.toString().replaceFirst(RegExp(r'^Exception:\s*'), '');
}
