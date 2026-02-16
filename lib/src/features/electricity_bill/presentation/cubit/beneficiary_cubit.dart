import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/bill_payment_entity.dart';
import '../../domain/repositories/electricity_bill_repository.dart';
import 'beneficiary_state.dart';

class BeneficiaryCubit extends Cubit<BeneficiaryState> {
  final ElectricityBillRepository repository;

  BeneficiaryCubit({required this.repository}) : super(BeneficiaryInitial());

  Future<void> saveBeneficiary({
    required String providerId,
    required String meterNumber,
    required MeterType meterType,
    required String customerName,
    String? customerAddress,
    String? phoneNumber,
    required String nickname,
    bool isDefault = false,
    String? providerCode,
    String? providerName,
  }) async {
    if (isClosed) return;
    emit(BeneficiarySaving());

    // Check for duplicate meter number
    final existingResult = await repository.getBeneficiaries();
    final existingBeneficiaries = existingResult.fold(
      (_) => <dynamic>[],
      (list) => list,
    );
    final isDuplicate = existingBeneficiaries.any(
      (b) => b.meterNumber == meterNumber,
    );
    if (isDuplicate) {
      if (isClosed) return;
      emit(BeneficiaryError(
          message: 'A beneficiary with this meter number already exists'));
      return;
    }

    final result = await repository.saveBeneficiary(
      providerId: providerId,
      meterNumber: meterNumber,
      meterType: meterType,
      customerName: customerName,
      customerAddress: customerAddress,
      phoneNumber: phoneNumber,
      nickname: nickname,
      isDefault: isDefault,
      providerCode: providerCode,
      providerName: providerName,
    );

    if (isClosed) return;
    result.fold(
      (failure) => emit(BeneficiaryError(message: failure.message)),
      (beneficiary) => emit(BeneficiarySaved(beneficiary: beneficiary)),
    );
  }

  Future<void> getBeneficiaries() async {
    if (isClosed) return;
    emit(BeneficiaryLoading());

    final result = await repository.getBeneficiaries();

    if (isClosed) return;
    result.fold(
      (failure) => emit(BeneficiaryError(message: failure.message)),
      (beneficiaries) => emit(BeneficiariesLoaded(beneficiaries: beneficiaries)),
    );
  }

  // Alias for saveBeneficiary to match screen usage
  Future<void> addBeneficiary({
    required String providerId,
    required String providerCode,
    required String providerName,
    required String meterNumber,
    required MeterType meterType,
    required String customerName,
    String? customerAddress,
    String? phoneNumber,
    required String nickname,
    bool isDefault = false,
  }) => saveBeneficiary(
    providerId: providerId,
    meterNumber: meterNumber,
    meterType: meterType,
    customerName: customerName,
    customerAddress: customerAddress,
    phoneNumber: phoneNumber,
    nickname: nickname,
    isDefault: isDefault,
    providerCode: providerCode,
    providerName: providerName,
  );

  Future<void> setDefaultBeneficiary(String beneficiaryId) async {
    if (isClosed) return;
    emit(BeneficiaryUpdating());

    final result = await repository.updateBeneficiary(
      beneficiaryId: beneficiaryId,
      isDefault: true,
    );

    if (isClosed) return;
    result.fold(
      (failure) => emit(BeneficiaryError(message: failure.message)),
      (beneficiary) {
        emit(BeneficiaryUpdated(beneficiary: beneficiary));
        // Reload the list
        getBeneficiaries();
      },
    );
  }

  Future<void> updateBeneficiary({
    required String beneficiaryId,
    String? nickname,
    bool? isDefault,
  }) async {
    if (isClosed) return;
    emit(BeneficiaryUpdating());

    final result = await repository.updateBeneficiary(
      beneficiaryId: beneficiaryId,
      nickname: nickname,
      isDefault: isDefault,
    );

    if (isClosed) return;
    result.fold(
      (failure) => emit(BeneficiaryError(message: failure.message)),
      (beneficiary) => emit(BeneficiaryUpdated(beneficiary: beneficiary)),
    );
  }

  Future<void> deleteBeneficiary({required String beneficiaryId}) async {
    if (isClosed) return;
    emit(BeneficiaryDeleting());

    final result = await repository.deleteBeneficiary(beneficiaryId: beneficiaryId);

    if (isClosed) return;
    result.fold(
      (failure) => emit(BeneficiaryError(message: failure.message)),
      (_) => emit(BeneficiaryDeleted()),
    );
  }

  void reset() {
    if (isClosed) return;
    emit(BeneficiaryInitial());
  }
}
