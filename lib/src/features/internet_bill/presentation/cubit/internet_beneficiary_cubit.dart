import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/datasources/internet_beneficiary_remote_datasource.dart';
import 'internet_beneficiary_state.dart';

/// Cubit for the internet-scoped saved-contacts surface. Mirrors
/// `DataBeneficiaryCubit` — dedicated state space so the ISP flows
/// don't have to pattern-match against data/airtime states.
class InternetBeneficiaryCubit extends Cubit<InternetBeneficiaryState> {
  final InternetBeneficiaryRemoteDataSource datasource;

  InternetBeneficiaryCubit({required this.datasource})
      : super(InternetBeneficiaryInitial());

  Future<void> load({String? providerCode}) async {
    if (isClosed) return;
    emit(InternetBeneficiariesLoading());
    try {
      final list =
          await datasource.getBeneficiaries(providerCode: providerCode);
      if (isClosed) return;
      emit(InternetBeneficiariesLoaded(beneficiaries: list));
    } catch (e) {
      if (isClosed) return;
      emit(InternetBeneficiaryError(message: _friendly(e)));
    }
  }

  Future<void> save({
    required String accountNumber,
    required String providerCode,
    required String providerName,
    String? nickname,
  }) async {
    try {
      final saved = await datasource.saveBeneficiary(
        accountNumber: accountNumber,
        providerCode: providerCode,
        providerName: providerName,
        nickname: nickname,
      );
      if (isClosed) return;
      emit(InternetBeneficiarySaved(beneficiary: saved));
      await load();
    } catch (e) {
      if (isClosed) return;
      emit(InternetBeneficiaryError(message: _friendly(e)));
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
      emit(InternetBeneficiaryUpdated(beneficiary: updated));
      await load();
    } catch (e) {
      if (isClosed) return;
      emit(InternetBeneficiaryError(message: _friendly(e)));
      rethrow;
    }
  }

  Future<void> delete(String beneficiaryId) async {
    try {
      await datasource.deleteBeneficiary(beneficiaryId);
      if (isClosed) return;
      emit(InternetBeneficiaryDeleted(id: beneficiaryId));
      await load();
    } catch (e) {
      if (isClosed) return;
      emit(InternetBeneficiaryError(message: _friendly(e)));
      rethrow;
    }
  }

  String _friendly(Object e) =>
      e.toString().replaceFirst(RegExp(r'^Exception:\s*'), '');
}
