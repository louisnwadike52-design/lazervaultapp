import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/datasources/data_beneficiary_remote_datasource.dart';
import 'data_beneficiary_state.dart';

/// Cubit for the data-scoped saved-contacts surface. Mirrors the
/// beneficiary slice of `AirtimeCubit` but with a dedicated, narrower
/// state space (`DataBeneficiaryState`) so screens don't have to
/// pattern-match against unrelated airtime states.
class DataBeneficiaryCubit extends Cubit<DataBeneficiaryState> {
  final DataBeneficiaryRemoteDataSource datasource;

  DataBeneficiaryCubit({required this.datasource})
      : super(DataBeneficiaryInitial());

  Future<void> load({String? networkCode}) async {
    if (isClosed) return;
    emit(DataBeneficiariesLoading());
    try {
      final list = await datasource.getBeneficiaries(networkCode: networkCode);
      if (isClosed) return;
      emit(DataBeneficiariesLoaded(beneficiaries: list));
    } catch (e) {
      if (isClosed) return;
      emit(DataBeneficiaryError(message: _friendly(e)));
    }
  }

  Future<void> save({
    required String phoneNumber,
    required String networkCode,
    required String networkName,
    String? nickname,
    String countryCode = 'NG',
    String? operatorId,
  }) async {
    try {
      final saved = await datasource.saveBeneficiary(
        phoneNumber: phoneNumber,
        networkCode: networkCode,
        networkName: networkName,
        nickname: nickname,
        countryCode: countryCode,
        operatorId: operatorId,
      );
      if (isClosed) return;
      emit(DataBeneficiarySaved(beneficiary: saved));
      await load();
    } catch (e) {
      if (isClosed) return;
      emit(DataBeneficiaryError(message: _friendly(e)));
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
      emit(DataBeneficiaryUpdated(beneficiary: updated));
      await load();
    } catch (e) {
      if (isClosed) return;
      emit(DataBeneficiaryError(message: _friendly(e)));
      rethrow;
    }
  }

  Future<void> delete(String beneficiaryId) async {
    try {
      await datasource.deleteBeneficiary(beneficiaryId);
      if (isClosed) return;
      emit(DataBeneficiaryDeleted(id: beneficiaryId));
      await load();
    } catch (e) {
      if (isClosed) return;
      emit(DataBeneficiaryError(message: _friendly(e)));
      rethrow;
    }
  }

  String _friendly(Object e) =>
      e.toString().replaceFirst(RegExp(r'^Exception:\s*'), '');
}
