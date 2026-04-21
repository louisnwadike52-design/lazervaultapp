import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/beneficiary_entity.dart';
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

  /// Patch a single beneficiary in the current `BeneficiariesLoaded` list
  /// in place. Used after inline edits (e.g. rename sheet) so the UI
  /// re-renders the affected row without bouncing through
  /// `BeneficiaryLoading` — which would blank the whole screen to a
  /// spinner for a one-word nickname change. No-op if the current state
  /// isn't `BeneficiariesLoaded` or the id isn't in the list.
  void applyBeneficiaryUpdate(BillBeneficiaryEntity updated) {
    if (isClosed) return;
    final current = state;
    if (current is! BeneficiariesLoaded) return;
    final idx =
        current.beneficiaries.indexWhere((b) => b.id == updated.id);
    if (idx < 0) return;
    final next = List<BillBeneficiaryEntity>.of(current.beneficiaries);
    next[idx] = updated;
    emit(BeneficiariesLoaded(beneficiaries: next));
  }

  /// Remove a beneficiary from the current `BeneficiariesLoaded` list in
  /// place — no refetch, no loading state. Caller is responsible for
  /// persisting the delete (via [deleteBeneficiary] or the repo directly)
  /// before invoking this. Keeps the screen from blanking out for a
  /// trivial single-row removal.
  void applyBeneficiaryDelete(String beneficiaryId) {
    if (isClosed) return;
    final current = state;
    if (current is! BeneficiariesLoaded) return;
    final next = current.beneficiaries
        .where((b) => b.id != beneficiaryId)
        .toList(growable: false);
    if (next.length == current.beneficiaries.length) return;
    emit(BeneficiariesLoaded(beneficiaries: next));
  }

  /// Promote a beneficiary to default in place: marks the target
  /// `isDefault=true` and clears the flag on every other row. Mirrors
  /// what the backend does server-side (there's only ever one default),
  /// so the UI stays consistent without refetching.
  void applySetDefault(BillBeneficiaryEntity updated) {
    if (isClosed) return;
    final current = state;
    if (current is! BeneficiariesLoaded) return;
    final next = current.beneficiaries.map((b) {
      if (b.id == updated.id) return updated;
      if (!b.isDefault) return b;
      return BillBeneficiaryEntity(
        id: b.id,
        userId: b.userId,
        providerId: b.providerId,
        providerCode: b.providerCode,
        providerName: b.providerName,
        meterNumber: b.meterNumber,
        customerName: b.customerName,
        customerAddress: b.customerAddress,
        phoneNumber: b.phoneNumber,
        meterType: b.meterType,
        nickname: b.nickname,
        isDefault: false,
        createdAt: b.createdAt,
        updatedAt: b.updatedAt,
        lastUsedAt: b.lastUsedAt,
      );
    }).toList(growable: false);
    emit(BeneficiariesLoaded(beneficiaries: next));
  }

  void reset() {
    if (isClosed) return;
    emit(BeneficiaryInitial());
  }
}
