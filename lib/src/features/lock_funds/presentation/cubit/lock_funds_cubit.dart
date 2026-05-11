import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../account_cards_summary/services/balance_websocket_service.dart';
import '../../domain/entities/lock_fund_entity.dart';
import '../../domain/repositories/lock_funds_repository.dart';
import 'lock_funds_state.dart';

class LockFundsCubit extends Cubit<LockFundsState> {
  final LockFundsRepository _repository;
  final BalanceWebSocketService? _wsService;
  StreamSubscription<LockFundLifecycleEvent>? _lifecycleSub;
  String? currentUserId;

  /// Optionally pass a [BalanceWebSocketService] so the cubit
  /// auto-refreshes the list whenever a lock-fund lifecycle event
  /// arrives (auto-renew, maturity, renewal_skipped, create from
  /// another device). Without it the cubit behaves the same way it
  /// did before — manual loads only.
  LockFundsCubit(this._repository, {BalanceWebSocketService? wsService})
      : _wsService = wsService,
        super(const LockFundsInitial()) {
    _lifecycleSub = _wsService?.lockFundEvents.listen(_onLifecycleEvent);
  }

  void setUserId(String userId) {
    currentUserId = userId;
    loadLockFunds();
  }

  void _onLifecycleEvent(LockFundLifecycleEvent event) {
    // Any state change on the user's locks invalidates the list +
    // the receipt screen's statistics. Re-fetch is cheap (single
    // gRPC call) and avoids the patch-vs-refetch consistency
    // burden of trying to mutate the loaded list inline. The cubit
    // is shared across the list screen and receipt, so a single
    // load covers both surfaces.
    if (isClosed) return;
    if (currentUserId != null && event.userId.isNotEmpty &&
        event.userId != currentUserId) {
      return;
    }
    loadLockFunds();
  }

  @override
  Future<void> close() async {
    await _lifecycleSub?.cancel();
    return super.close();
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
    required String sourceAccountId,
    String transactionPin = '',
    String? interestDestinationAccountId,
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
        sourceAccountId: sourceAccountId,
        transactionPin: transactionPin,
        interestDestinationAccountId: interestDestinationAccountId,
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

  /// Renews an active lock. Returns the updated LockFund so the
  /// caller (details screen) can patch its local state without a
  /// round-trip; also reloads the list cubit-side so other screens
  /// stay consistent. Throws on backend failure so callers can
  /// surface the typed error message to the user.
  Future<LockFund> renewLockFund({
    required String lockFundId,
    required int newDurationDays,
  }) async {
    if (isClosed) {
      throw StateError('LockFundsCubit closed');
    }
    emit(const LockFundsLoading());
    try {
      final lockFund = await _repository.renewLockFund(
        lockFundId: lockFundId,
        newDurationDays: newDurationDays,
      );
      if (isClosed) return lockFund;

      emit(LockFundCreated(lockFund));

      // Reload list
      loadLockFunds();
      return lockFund;
    } catch (e) {
      if (!isClosed) emit(LockFundsError(e.toString()));
      rethrow;
    }
  }

  /// Cancels an active lock. Backend flips status to 'cancelled',
  /// refunds principal less penalty to source, writes a
  /// settlement row capturing the reason. Returns the CancelResult
  /// so the caller can show refund_amount in the confirmation
  /// snackbar. Throws on failure so the UI can surface the typed
  /// message.
  Future<CancelResult> cancelLockFund({
    required String lockFundId,
    required String reason,
  }) async {
    if (isClosed) {
      throw StateError('LockFundsCubit closed');
    }
    emit(const LockFundsLoading());
    try {
      final result = await _repository.cancelLockFund(
        lockFundId: lockFundId,
        reason: reason,
      );
      if (isClosed) return result;
      if (!result.success) {
        emit(LockFundsError(result.message));
        throw Exception(result.message);
      }
      // Reload list so the cancelled lock surfaces under its new
      // filter tab; cubit's WS listener handles other devices.
      loadLockFunds();
      return result;
    } catch (e) {
      if (!isClosed) emit(LockFundsError(e.toString()));
      rethrow;
    }
  }

  /// Top up an existing lock fund
  Future<void> topUpLockFund({
    required String lockFundId,
    required double amount,
    required String sourceAccountId,
    String transactionPin = '',
  }) async {
    try {
      if (isClosed) return;
      emit(const LockFundsLoading());

      final result = await _repository.topUpLockFund(
        lockFundId: lockFundId,
        amount: amount,
        sourceAccountId: sourceAccountId,
        transactionPin: transactionPin,
      );
      if (isClosed) return;

      emit(LockFundTopUpSuccess(
        updatedLockFund: result.updatedLockFund,
        newBalance: result.newBalance,
        message: result.message,
      ));
    } catch (e) {
      if (isClosed) return;
      emit(LockFundsError(e.toString()));
    }
  }

  /// Load PiggyVault product configs from backend
  Future<void> loadPiggyVaultConfigs({String? currency}) async {
    try {
      if (isClosed) return;
      final configs = await _repository.getPiggyVaultConfigs(currency: currency);
      if (isClosed) return;
      emit(PiggyVaultConfigsLoaded(configs));
    } catch (e) {
      if (isClosed) return;
      // Don't emit error — fallback to hardcoded values in UI
    }
  }

  /// Create auto-save for a lock fund
  Future<void> createAutoSave({
    required String lockFundId,
    required String sourceAccountId,
    required double amount,
    required String frequency,
  }) async {
    try {
      if (isClosed) return;
      emit(const LockFundsLoading());

      final autoSave = await _repository.createAutoSave(
        lockFundId: lockFundId,
        sourceAccountId: sourceAccountId,
        amount: amount,
        frequency: frequency,
      );
      if (isClosed) return;

      emit(AutoSaveCreated(autoSave));
    } catch (e) {
      if (isClosed) return;
      emit(LockFundsError(e.toString()));
    }
  }

  /// Get auto-save for a lock fund
  Future<void> loadAutoSave({required String lockFundId}) async {
    try {
      if (isClosed) return;
      final autoSave = await _repository.getAutoSave(lockFundId: lockFundId);
      if (isClosed) return;
      emit(AutoSaveLoaded(autoSave));
    } catch (e) {
      if (isClosed) return;
      emit(AutoSaveLoaded(null));
    }
  }

  /// Update auto-save
  Future<void> updateAutoSave({
    required String autoSaveId,
    double? amount,
    String? frequency,
    String? status,
  }) async {
    try {
      if (isClosed) return;
      emit(const LockFundsLoading());

      final autoSave = await _repository.updateAutoSave(
        autoSaveId: autoSaveId,
        amount: amount,
        frequency: frequency,
        status: status,
      );
      if (isClosed) return;

      emit(AutoSaveCreated(autoSave));
    } catch (e) {
      if (isClosed) return;
      emit(LockFundsError(e.toString()));
    }
  }

  /// Delete auto-save
  Future<void> deleteAutoSave({required String autoSaveId}) async {
    try {
      if (isClosed) return;
      await _repository.deleteAutoSave(autoSaveId: autoSaveId);
      if (isClosed) return;
      emit(AutoSaveLoaded(null));
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
