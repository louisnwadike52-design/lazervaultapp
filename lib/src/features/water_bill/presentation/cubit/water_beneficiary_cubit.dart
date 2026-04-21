import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/datasources/water_beneficiary_remote_datasource.dart';
import 'water_beneficiary_state.dart';

/// Cubit for the water-bill-scoped saved-accounts surface.
class WaterBeneficiaryCubit extends Cubit<WaterBeneficiaryState> {
  final WaterBeneficiaryRemoteDataSource datasource;

  WaterBeneficiaryCubit({required this.datasource})
      : super(WaterBeneficiaryInitial());

  Future<void> load({String? providerCode}) async {
    if (isClosed) return;
    emit(WaterBeneficiariesLoading());
    try {
      final list =
          await datasource.getBeneficiaries(providerCode: providerCode);
      if (isClosed) return;
      emit(WaterBeneficiariesLoaded(beneficiaries: list));
    } catch (e) {
      if (isClosed) return;
      emit(WaterBeneficiaryError(message: _friendly(e)));
    }
  }

  Future<void> save({
    required String accountNumber,
    required String providerCode,
    required String providerName,
    String? nickname,
    String? customerName,
  }) async {
    try {
      final saved = await datasource.saveBeneficiary(
        accountNumber: accountNumber,
        providerCode: providerCode,
        providerName: providerName,
        nickname: nickname,
        customerName: customerName,
      );
      if (isClosed) return;
      emit(WaterBeneficiarySaved(beneficiary: saved));
      await load();
    } catch (e) {
      if (isClosed) return;
      emit(WaterBeneficiaryError(message: _friendly(e)));
      rethrow;
    }
  }

  Future<void> update({
    required String beneficiaryId,
    String? nickname,
  }) async {
    try {
      final updated = await datasource.updateBeneficiary(
        beneficiaryId: beneficiaryId,
        nickname: nickname,
      );
      if (isClosed) return;
      emit(WaterBeneficiaryUpdated(beneficiary: updated));
      await load();
    } catch (e) {
      if (isClosed) return;
      emit(WaterBeneficiaryError(message: _friendly(e)));
      rethrow;
    }
  }

  Future<void> delete(String beneficiaryId) async {
    try {
      await datasource.deleteBeneficiary(beneficiaryId);
      if (isClosed) return;
      emit(WaterBeneficiaryDeleted(id: beneficiaryId));
      await load();
    } catch (e) {
      if (isClosed) return;
      emit(WaterBeneficiaryError(message: _friendly(e)));
      rethrow;
    }
  }

  String _friendly(Object e) =>
      e.toString().replaceFirst(RegExp(r'^Exception:\s*'), '');
}
