import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/datasources/internet_beneficiary_remote_datasource.dart';
import 'internet_auto_recharge_state.dart';

/// Cubit for managing internet "Rollover" (auto-recharge) schedules.
/// Mirrors `DataAutoRechargeCubit`. Each schedule re-buys the SAME
/// internet package (`packageId` + `planName`) at a recurring cadence —
/// package-locked by design so users don't get surprise pricing when
/// ISPs retire packages.
class InternetAutoRechargeCubit extends Cubit<InternetAutoRechargeState> {
  final InternetBeneficiaryRemoteDataSource datasource;

  InternetAutoRechargeCubit({required this.datasource})
      : super(InternetAutoRechargeInitial());

  Future<void> load({String? status}) async {
    if (isClosed) return;
    emit(InternetAutoRechargesLoading());
    try {
      final list = await datasource.getAutoRecharges(status: status);
      if (isClosed) return;
      emit(InternetAutoRechargesLoaded(autoRecharges: list));
    } catch (e) {
      if (isClosed) return;
      emit(InternetAutoRechargeError(message: _friendly(e)));
    }
  }

  Future<void> create({
    required String beneficiaryId,
    required String packageId,
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
    emit(InternetAutoRechargeMutating());
    try {
      await datasource.createAutoRecharge(
        beneficiaryId: beneficiaryId,
        packageId: packageId,
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
      emit(const InternetAutoRechargeMutated(message: 'Rollover scheduled'));
      await load();
    } catch (e) {
      if (isClosed) return;
      emit(InternetAutoRechargeError(message: _friendly(e)));
      rethrow;
    }
  }

  Future<void> update({
    required String autoRechargeId,
    String? packageId,
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
    emit(InternetAutoRechargeMutating());
    try {
      await datasource.updateAutoRecharge(
        autoRechargeId: autoRechargeId,
        packageId: packageId,
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
      emit(const InternetAutoRechargeMutated(message: 'Rollover updated'));
      await load();
    } catch (e) {
      if (isClosed) return;
      emit(InternetAutoRechargeError(message: _friendly(e)));
      rethrow;
    }
  }

  Future<void> pause(String id) async {
    try {
      await datasource.pauseAutoRecharge(id);
      if (isClosed) return;
      emit(const InternetAutoRechargeMutated(message: 'Rollover paused'));
      await load();
    } catch (e) {
      if (isClosed) return;
      emit(InternetAutoRechargeError(message: _friendly(e)));
      rethrow;
    }
  }

  Future<void> resume(String id) async {
    try {
      await datasource.resumeAutoRecharge(id);
      if (isClosed) return;
      emit(const InternetAutoRechargeMutated(message: 'Rollover resumed'));
      await load();
    } catch (e) {
      if (isClosed) return;
      emit(InternetAutoRechargeError(message: _friendly(e)));
      rethrow;
    }
  }

  Future<void> delete(String id) async {
    try {
      await datasource.deleteAutoRecharge(id);
      if (isClosed) return;
      emit(const InternetAutoRechargeMutated(message: 'Rollover deleted'));
      await load();
    } catch (e) {
      if (isClosed) return;
      emit(InternetAutoRechargeError(message: _friendly(e)));
      rethrow;
    }
  }

  String _friendly(Object e) =>
      e.toString().replaceFirst(RegExp(r'^Exception:\s*'), '');
}
