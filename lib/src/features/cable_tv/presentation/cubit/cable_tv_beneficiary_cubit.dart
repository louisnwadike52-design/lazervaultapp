import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/datasources/cable_tv_beneficiary_remote_datasource.dart';
import 'cable_tv_beneficiary_state.dart';

/// Cubit for the cable-TV-scoped saved-smart-cards surface.
class CableTVBeneficiaryCubit extends Cubit<CableTVBeneficiaryState> {
  final CableTVBeneficiaryRemoteDataSource datasource;

  CableTVBeneficiaryCubit({required this.datasource})
      : super(CableTVBeneficiaryInitial());

  Future<void> load({String? providerCode}) async {
    if (isClosed) return;
    emit(CableTVBeneficiariesLoading());
    try {
      final list =
          await datasource.getBeneficiaries(providerCode: providerCode);
      if (isClosed) return;
      emit(CableTVBeneficiariesLoaded(beneficiaries: list));
    } catch (e) {
      if (isClosed) return;
      emit(CableTVBeneficiaryError(message: _friendly(e)));
    }
  }

  Future<void> save({
    required String smartCardNumber,
    required String providerCode,
    required String providerName,
    String? nickname,
    String? customerName,
  }) async {
    try {
      final saved = await datasource.saveBeneficiary(
        smartCardNumber: smartCardNumber,
        providerCode: providerCode,
        providerName: providerName,
        nickname: nickname,
        customerName: customerName,
      );
      if (isClosed) return;
      emit(CableTVBeneficiarySaved(beneficiary: saved));
      await load();
    } catch (e) {
      if (isClosed) return;
      emit(CableTVBeneficiaryError(message: _friendly(e)));
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
      emit(CableTVBeneficiaryUpdated(beneficiary: updated));
      await load();
    } catch (e) {
      if (isClosed) return;
      emit(CableTVBeneficiaryError(message: _friendly(e)));
      rethrow;
    }
  }

  Future<void> delete(String beneficiaryId) async {
    try {
      await datasource.deleteBeneficiary(beneficiaryId);
      if (isClosed) return;
      emit(CableTVBeneficiaryDeleted(id: beneficiaryId));
      await load();
    } catch (e) {
      if (isClosed) return;
      emit(CableTVBeneficiaryError(message: _friendly(e)));
      rethrow;
    }
  }

  String _friendly(Object e) =>
      e.toString().replaceFirst(RegExp(r'^Exception:\s*'), '');
}
