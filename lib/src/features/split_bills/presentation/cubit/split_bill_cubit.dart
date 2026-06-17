import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/split_bill_entity.dart';
import '../../domain/exceptions/split_bill_exceptions.dart';
import '../../domain/repositories/split_bill_repository.dart';
import 'split_bill_state.dart';

class SplitBillCubit extends Cubit<SplitBillState> {
  final SplitBillRepository repository;

  bool _isPaymentInProgress = false;

  SplitBillCubit({required this.repository}) : super(SplitBillInitial());

  Future<void> loadCreatedBills({int page = 1, int limit = 20}) async {
    try {
      if (isClosed) return;
      final safePage = page.clamp(1, 9999);
      final safeLimit = limit.clamp(1, 100);
      emit(SplitBillListLoading());
      final result = await repository.getMyCreatedSplitBills(
        page: safePage,
        limit: safeLimit,
      );
      if (isClosed) return;
      emit(CreatedSplitBillsLoaded(
        bills: result.bills,
        total: result.total,
        page: result.page,
        totalPages: result.totalPages,
      ));
    } on SplitBillServiceUnavailableException catch (_) {
      if (isClosed) return;
      emit(const SplitBillError('Service temporarily unavailable. Please try again.'));
    } catch (e) {
      if (isClosed) return;
      emit(SplitBillError(e.toString()));
    }
  }

  Future<void> loadIncomingBills({int page = 1, int limit = 20}) async {
    try {
      if (isClosed) return;
      final safePage = page.clamp(1, 9999);
      final safeLimit = limit.clamp(1, 100);
      emit(SplitBillListLoading());
      final result = await repository.getMyIncomingSplitBills(
        page: safePage,
        limit: safeLimit,
      );
      if (isClosed) return;
      emit(IncomingSplitBillsLoaded(
        bills: result.bills,
        total: result.total,
        page: result.page,
        totalPages: result.totalPages,
      ));
    } on SplitBillServiceUnavailableException catch (_) {
      if (isClosed) return;
      emit(const SplitBillError('Service temporarily unavailable. Please try again.'));
    } catch (e) {
      if (isClosed) return;
      emit(SplitBillError(e.toString()));
    }
  }

  Future<void> loadBillDetail(String splitBillId) async {
    try {
      if (isClosed) return;
      emit(SplitBillDetailLoading());
      final bill = await repository.getSplitBill(splitBillId: splitBillId);
      if (isClosed) return;
      emit(SplitBillDetailLoaded(bill));
    } on SplitBillNotFoundException catch (_) {
      if (isClosed) return;
      emit(const SplitBillError('Split bill not found. It may have been cancelled.'));
    } on SplitBillPermissionDeniedException catch (e) {
      if (isClosed) return;
      emit(SplitBillError(e.message));
    } on SplitBillServiceUnavailableException catch (_) {
      if (isClosed) return;
      emit(const SplitBillError('Service temporarily unavailable. Please try again.'));
    } catch (e) {
      if (isClosed) return;
      emit(SplitBillError(e.toString()));
    }
  }

  Future<void> createSplitBill({
    required double totalAmount,
    required String currency,
    required String description,
    required SplitMethodType splitMethod,
    required double creatorShare,
    required List<SplitBillParticipantInput> participants,
  }) async {
    try {
      if (isClosed) return;
      emit(SplitBillLoading());
      final bill = await repository.createSplitBill(
        totalAmount: totalAmount,
        currency: currency,
        description: description,
        splitMethod: splitMethod,
        creatorShare: creatorShare,
        participants: participants,
      );
      if (isClosed) return;
      emit(SplitBillCreated(
        bill: bill,
        message: 'Split bill created successfully',
      ));
    } on SplitBillServiceUnavailableException catch (_) {
      if (isClosed) return;
      emit(const SplitBillError('Service temporarily unavailable. Please try again.'));
    } catch (e) {
      if (isClosed) return;
      emit(SplitBillError(e.toString()));
    }
  }

  Future<void> payShare({
    required String splitBillId,
    required String sourceAccountId,
    required String transactionPin,
  }) async {
    if (_isPaymentInProgress) return;
    _isPaymentInProgress = true;
    try {
      if (isClosed) return;
      emit(SplitBillPaymentProcessing());
      final result = await repository.paySplitBillShare(
        splitBillId: splitBillId,
        sourceAccountId: sourceAccountId,
        transactionPin: transactionPin,
      );
      if (isClosed) return;
      emit(SplitBillSharePaid(
        transactionReference: result.transactionReference,
        message: result.message,
        updatedBill: result.updatedBill,
      ));
    } on SplitBillNotFoundException catch (_) {
      if (isClosed) return;
      emit(const SplitBillError('Split bill not found. It may have been cancelled.'));
    } on SplitBillStateException catch (e) {
      if (isClosed) return;
      emit(SplitBillError(e.message));
    } on SplitBillPermissionDeniedException catch (e) {
      if (isClosed) return;
      emit(SplitBillError(e.message));
    } on SplitBillServiceUnavailableException catch (_) {
      if (isClosed) return;
      emit(const SplitBillError('Service temporarily unavailable. Please try again.'));
    } catch (e) {
      if (isClosed) return;
      emit(SplitBillError(e.toString()));
    } finally {
      _isPaymentInProgress = false;
    }
  }

  Future<void> cancelBill(String splitBillId) async {
    try {
      if (isClosed) return;
      emit(SplitBillLoading());
      await repository.cancelSplitBill(splitBillId: splitBillId);
      if (isClosed) return;
      emit(const SplitBillCancelled('Split bill cancelled'));
    } on SplitBillNotFoundException catch (_) {
      if (isClosed) return;
      emit(const SplitBillError('Split bill not found. It may have been cancelled.'));
    } on SplitBillPermissionDeniedException catch (e) {
      if (isClosed) return;
      emit(SplitBillError(e.message));
    } on SplitBillStateException catch (e) {
      if (isClosed) return;
      emit(SplitBillError(e.message));
    } catch (e) {
      if (isClosed) return;
      emit(SplitBillError(e.toString()));
    }
  }

  Future<void> declineShare(String splitBillId, {String? reason}) async {
    try {
      if (isClosed) return;
      emit(SplitBillLoading());
      await repository.declineSplitBillShare(
        splitBillId: splitBillId,
        reason: reason,
      );
      if (isClosed) return;
      emit(const SplitBillShareDeclined('Share declined'));
    } on SplitBillNotFoundException catch (_) {
      if (isClosed) return;
      emit(const SplitBillError('Split bill not found.'));
    } on SplitBillStateException catch (e) {
      if (isClosed) return;
      emit(SplitBillError(e.message));
    } catch (e) {
      if (isClosed) return;
      emit(SplitBillError(e.toString()));
    }
  }

  Future<void> sendReminder(String splitBillId) async {
    try {
      if (isClosed) return;
      emit(SplitBillLoading());
      final count = await repository.sendSplitBillReminder(
        splitBillId: splitBillId,
      );
      if (isClosed) return;
      emit(SplitBillReminderSent(
        count: count,
        message: 'Sent $count reminder(s)',
      ));
    } on SplitBillPermissionDeniedException catch (e) {
      if (isClosed) return;
      emit(SplitBillError(e.message));
    } catch (e) {
      if (isClosed) return;
      emit(SplitBillError(e.toString()));
    }
  }
}
