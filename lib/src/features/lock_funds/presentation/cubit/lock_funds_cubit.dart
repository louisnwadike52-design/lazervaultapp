import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/lock_fund_entity.dart';
import '../../domain/repositories/lock_funds_repository.dart';
import 'lock_funds_state.dart';

class LockFundsCubit extends Cubit<LockFundsState> {
  final LockFundsRepository _repository;
  String? currentUserId;

  LockFundsCubit(this._repository) : super(const LockFundsInitial());

  void setUserId(String userId) {
    currentUserId = userId;
    loadLockFunds();
  }

  Future<void> loadLockFunds({LockStatus? status}) async {
    try {
      if (isClosed) return;
      emit(const LockFundsLoading());

      final lockFunds = await _repository.getLockFunds(status: status);
      if (isClosed) return;
      final statistics = await _repository.getStatistics();
      if (isClosed) return;

      final stats = {
        'totalLockedAmount': statistics.totalLockedAmount,
        'totalAccruedInterest': statistics.totalAccruedInterest,
        'activeLocksCount': statistics.activeLocksCount,
        'totalCount': statistics.totalCount,
      };

      emit(LockFundsLoaded(
        lockFunds: lockFunds,
        statistics: stats,
      ));
    } catch (e) {
      if (isClosed) return;
      emit(LockFundsError(e.toString()));
    }
  }

  Future<void> loadLockFundDetails(String lockFundId) async {
    try {
      if (isClosed) return;
      emit(const LockFundsLoading());

      final lockFund = await _repository.getLockFund(lockFundId);
      if (isClosed) return;
      final transactions = await _repository.getTransactions(
        lockFundId: lockFundId,
      );
      if (isClosed) return;

      emit(LockFundDetailsLoaded(
        lockFund: lockFund,
        transactions: transactions,
      ));
    } catch (e) {
      if (isClosed) return;
      emit(LockFundsError(e.toString()));
    }
  }

  Future<void> createLockFund({
    required LockType lockType,
    required double amount,
    required String currency,
    required int lockDurationDays,
    bool autoRenew = false,
    String? goalName,
    String? goalDescription,
    required String paymentMethod,
  }) async {
    try {
      if (isClosed) return;
      emit(const LockFundCreating());

      final lockFund = await _repository.createLockFund(
        lockType: lockType,
        amount: amount,
        currency: currency,
        lockDurationDays: lockDurationDays,
        autoRenew: autoRenew,
        goalName: goalName,
        goalDescription: goalDescription,
        paymentMethod: paymentMethod,
      );
      if (isClosed) return;

      emit(LockFundCreated(lockFund));

      // Reload list
      loadLockFunds();
    } catch (e) {
      if (isClosed) return;
      emit(LockFundsError(e.toString()));
    }
  }

  Future<void> unlockFund({
    required String lockFundId,
    bool forceEarlyUnlock = false,
  }) async {
    try {
      if (isClosed) return;
      emit(const LockFundUnlocking());

      final result = await _repository.unlockFund(
        lockFundId: lockFundId,
        forceEarlyUnlock: forceEarlyUnlock,
      );
      if (isClosed) return;

      emit(LockFundUnlocked(
        amountReturned: result.amountReturned,
        penaltyAmount: result.penaltyAmount,
        interestEarned: result.interestEarned,
      ));

      // Reload list
      loadLockFunds();
    } catch (e) {
      if (isClosed) return;
      emit(LockFundsError(e.toString()));
    }
  }

  Future<void> calculateInterest({
    required LockType lockType,
    required double amount,
    required int lockDurationDays,
  }) async {
    try {
      final calculation = await _repository.calculateInterest(
        lockType: lockType,
        amount: amount,
        lockDurationDays: lockDurationDays,
      );
      if (isClosed) return;

      emit(InterestCalculated(calculation));
    } catch (e) {
      if (isClosed) return;
      emit(LockFundsError(e.toString()));
    }
  }

  Future<void> renewLockFund({
    required String lockFundId,
    required int newDurationDays,
  }) async {
    try {
      if (isClosed) return;
      emit(const LockFundsLoading());

      final lockFund = await _repository.renewLockFund(
        lockFundId: lockFundId,
        newDurationDays: newDurationDays,
      );
      if (isClosed) return;

      emit(LockFundCreated(lockFund));

      // Reload list
      loadLockFunds();
    } catch (e) {
      if (isClosed) return;
      emit(LockFundsError(e.toString()));
    }
  }

  Future<void> cancelLockFund({
    required String lockFundId,
    required String reason,
  }) async {
    try {
      if (isClosed) return;
      emit(const LockFundsLoading());

      final result = await _repository.cancelLockFund(
        lockFundId: lockFundId,
        reason: reason,
      );
      if (isClosed) return;

      if (result.success) {
        // Reload list
        loadLockFunds();
      } else {
        emit(LockFundsError(result.message));
      }
    } catch (e) {
      if (isClosed) return;
      emit(LockFundsError(e.toString()));
    }
  }

  void clearError() {
    if (isClosed) return;
    if (state is LockFundsError) {
      emit(const LockFundsInitial());
    }
  }
}
