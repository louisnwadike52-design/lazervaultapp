import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/datasources/education_beneficiary_remote_datasource.dart';
import 'education_beneficiary_state.dart';

/// Cubit for the education-scoped saved-candidates surface.
class EducationBeneficiaryCubit extends Cubit<EducationBeneficiaryState> {
  final EducationBeneficiaryRemoteDataSource datasource;

  EducationBeneficiaryCubit({required this.datasource})
      : super(EducationBeneficiaryInitial());

  Future<void> load({String? providerCode}) async {
    if (isClosed) return;
    emit(EducationBeneficiariesLoading());
    try {
      final list =
          await datasource.getBeneficiaries(providerCode: providerCode);
      if (isClosed) return;
      emit(EducationBeneficiariesLoaded(beneficiaries: list));
    } catch (e) {
      if (isClosed) return;
      emit(EducationBeneficiaryError(message: _friendly(e)));
    }
  }

  Future<void> save({
    required String candidateNumber,
    required String examType,
    required String providerCode,
    required String providerName,
    String? nickname,
    String? candidateName,
  }) async {
    try {
      final saved = await datasource.saveBeneficiary(
        candidateNumber: candidateNumber,
        examType: examType,
        providerCode: providerCode,
        providerName: providerName,
        nickname: nickname,
        candidateName: candidateName,
      );
      if (isClosed) return;
      emit(EducationBeneficiarySaved(beneficiary: saved));
      await load();
    } catch (e) {
      if (isClosed) return;
      emit(EducationBeneficiaryError(message: _friendly(e)));
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
      emit(EducationBeneficiaryUpdated(beneficiary: updated));
      await load();
    } catch (e) {
      if (isClosed) return;
      emit(EducationBeneficiaryError(message: _friendly(e)));
      rethrow;
    }
  }

  Future<void> delete(String beneficiaryId) async {
    try {
      await datasource.deleteBeneficiary(beneficiaryId);
      if (isClosed) return;
      emit(EducationBeneficiaryDeleted(id: beneficiaryId));
      await load();
    } catch (e) {
      if (isClosed) return;
      emit(EducationBeneficiaryError(message: _friendly(e)));
      rethrow;
    }
  }

  String _friendly(Object e) =>
      e.toString().replaceFirst(RegExp(r'^Exception:\s*'), '');
}
