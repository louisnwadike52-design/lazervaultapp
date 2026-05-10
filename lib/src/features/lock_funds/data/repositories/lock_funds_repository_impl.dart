import 'package:lazervault/src/core/network/grpc_client.dart';
import 'package:lazervault/src/generated/lock_funds.pbgrpc.dart' as pb;
import '../../domain/entities/lock_fund_entity.dart';
import '../../domain/repositories/lock_funds_repository.dart';
import '../models/lock_fund_model.dart';

class LockFundsRepositoryImpl implements LockFundsRepository {
  final GrpcClient _grpcClient;

  LockFundsRepositoryImpl({required GrpcClient grpcClient})
      : _grpcClient = grpcClient;

  @override
  Future<List<LockFund>> getLockFunds({
    LockStatus? status,
    int page = 1,
    int perPage = 20,
  }) async {
    try {
      final request = pb.GetLockFundsRequest()
        ..page = page
        ..perPage = perPage;

      if (status != null) {
        request.status = LockFundModel.convertLockStatusToProto(status);
      }

      final response = await _grpcClient.lockFundsClient.getLockFunds(
        request,
        options: await _grpcClient.callOptions,
      );

      return response.lockFunds
          .map((proto) => LockFundModel.fromProto(proto))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch lock funds: $e');
    }
  }

  @override
  Future<LockFund> getLockFund(String id) async {
    try {
      final request = pb.GetLockFundRequest()..lockFundId = id;

      final response = await _grpcClient.lockFundsClient.getLockFund(
        request,
        options: await _grpcClient.callOptions,
      );

      if (!response.success) {
        throw Exception('Failed to fetch lock fund');
      }

      return LockFundModel.fromProto(response.lockFund);
    } catch (e) {
      throw Exception('Failed to fetch lock fund: $e');
    }
  }

  @override
  Future<LockFund> createLockFund({
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
  }) async {
    try {
      final request = LockFundModel.toCreateRequest(
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
      );

      final response =
          await _grpcClient.lockFundsClient.createLockFund(
            request,
            options: await _grpcClient.callOptions,
          );

      if (!response.success) {
        throw Exception(response.message);
      }

      return LockFundModel.fromProto(response.lockFund);
    } catch (e) {
      throw Exception('Failed to create lock fund: $e');
    }
  }

  @override
  Future<UnlockResult> unlockFund({
    required String lockFundId,
    bool forceEarlyUnlock = false,
  }) async {
    try {
      final request = pb.UnlockFundRequest()
        ..lockFundId = lockFundId
        ..forceEarlyUnlock = forceEarlyUnlock;

      final response = await _grpcClient.lockFundsClient.unlockFund(
        request,
        options: await _grpcClient.callOptions,
      );

      if (!response.success) {
        throw Exception(response.message);
      }

      return UnlockResult(
        amountReturned: response.amountReturned,
        penaltyAmount: response.penaltyAmount,
        interestEarned: response.interestEarned,
        updatedLockFund: LockFundModel.fromProto(response.updatedLockFund),
      );
    } catch (e) {
      throw Exception('Failed to unlock fund: $e');
    }
  }

  @override
  Future<List<LockTransaction>> getTransactions({
    String? lockFundId,
    int page = 1,
    int perPage = 20,
  }) async {
    try {
      final request = pb.GetLockTransactionsRequest()
        ..page = page
        ..perPage = perPage;

      if (lockFundId != null && lockFundId.isNotEmpty) {
        request.lockFundId = lockFundId;
      }

      final response =
          await _grpcClient.lockFundsClient.getLockTransactions(
            request,
            options: await _grpcClient.callOptions,
          );

      return response.transactions
          .map((proto) => LockFundModel.transactionFromProto(proto))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch transactions: $e');
    }
  }

  @override
  Future<InterestCalculation> calculateInterest({
    required LockType lockType,
    required double amount,
    required int lockDurationDays,
  }) async {
    try {
      final request = pb.CalculateInterestRequest()
        ..lockType = LockFundModel.convertLockTypeToProto(lockType)
        ..amount = amount
        ..lockDurationDays = lockDurationDays;

      final response =
          await _grpcClient.lockFundsClient.calculateInterest(
            request,
            options: await _grpcClient.callOptions,
          );

      return LockFundModel.interestFromProto(
        response,
        principalAmount: amount,
        lockDurationDays: lockDurationDays,
      );
    } catch (e) {
      throw Exception('Failed to calculate interest: $e');
    }
  }

  @override
  Future<LockFund> renewLockFund({
    required String lockFundId,
    required int newDurationDays,
  }) async {
    try {
      final request = pb.RenewLockFundRequest()
        ..lockFundId = lockFundId
        ..newDurationDays = newDurationDays;

      final response = await _grpcClient.lockFundsClient.renewLockFund(
        request,
        options: await _grpcClient.callOptions,
      );

      if (!response.success) {
        throw Exception(response.message);
      }

      return LockFundModel.fromProto(response.renewedLockFund);
    } catch (e) {
      throw Exception('Failed to renew lock fund: $e');
    }
  }

  @override
  Future<CancelResult> cancelLockFund({
    required String lockFundId,
    required String reason,
  }) async {
    try {
      final request = pb.CancelLockFundRequest()
        ..lockFundId = lockFundId
        ..reason = reason;

      final response =
          await _grpcClient.lockFundsClient.cancelLockFund(
            request,
            options: await _grpcClient.callOptions,
          );

      return CancelResult(
        success: response.success,
        message: response.message,
        refundAmount: response.refundAmount,
      );
    } catch (e) {
      throw Exception('Failed to cancel lock fund: $e');
    }
  }

  @override
  Future<LockFundsStatistics> getStatistics() async {
    try {
      final request = pb.GetLockFundsRequest()
        ..page = 1
        ..perPage = 100;

      final response = await _grpcClient.lockFundsClient.getLockFunds(
        request,
        options: await _grpcClient.callOptions,
      );

      return LockFundsStatistics(
        totalLockedAmount: response.totalLockedAmount,
        totalAccruedInterest: response.totalAccruedInterest,
        activeLocksCount: response.activeLocksCount,
        totalCount: response.totalCount,
      );
    } catch (e) {
      throw Exception('Failed to fetch statistics: $e');
    }
  }

  @override
  Future<TopUpResult> topUpLockFund({
    required String lockFundId,
    required double amount,
    required String sourceAccountId,
    String transactionPin = '',
  }) async {
    try {
      final request = pb.TopUpLockFundRequest()
        ..lockFundId = lockFundId
        ..amount = amount
        ..sourceAccountId = sourceAccountId
        ..transactionPin = transactionPin;

      final response = await _grpcClient.lockFundsClient.topUpLockFund(
        request,
        options: await _grpcClient.callOptions,
      );

      return TopUpResult(
        updatedLockFund: LockFundModel.fromProto(response.updatedLockFund),
        newBalance: response.newBalance,
        message: response.message,
      );
    } catch (e) {
      throw Exception('Failed to top up: $e');
    }
  }

  @override
  Future<List<PiggyVaultConfig>> getPiggyVaultConfigs({String? currency}) async {
    try {
      final request = pb.GetPiggyVaultConfigsRequest();
      if (currency != null) request.currency = currency;

      final response = await _grpcClient.lockFundsClient.getPiggyVaultConfigs(
        request,
        options: await _grpcClient.callOptions,
      );

      return response.configs.map((c) => PiggyVaultConfig(
        id: c.id,
        lockType: c.lockType,
        currency: c.currency,
        displayName: c.displayName,
        baseInterestRate: c.baseInterestRate,
        maxInterestRate: c.maxInterestRate,
        earlyWithdrawalPenalty: c.earlyWithdrawalPenalty,
        minDurationDays: c.minDurationDays,
        maxDurationDays: c.maxDurationDays,
        minAmount: c.minAmount,
        maxAmount: c.maxAmount,
        isFixedAmount: c.isFixedAmount,
        fixedAmount: c.fixedAmount,
        durationOptions: c.durationOptions,
        quickAmountOptions: c.quickAmountOptions,
        allowsEarlyWithdrawal: c.allowsEarlyWithdrawal,
        supportsAutoRenew: c.supportsAutoRenew,
        supportsTopUp: c.supportsTopUp,
        supportsAutoSave: c.supportsAutoSave,
        supportsUpfrontInterest: c.supportsUpfrontInterest,
        durationBonusTiers: c.durationBonusTiers,
        isActive: c.isActive,
        description: c.description,
      )).toList();
    } catch (e) {
      throw Exception('Failed to fetch configs: $e');
    }
  }

  @override
  Future<LockFundAutoSaveConfig> createAutoSave({
    required String lockFundId,
    required String sourceAccountId,
    required double amount,
    required String frequency,
  }) async {
    try {
      final request = pb.CreateLockFundAutoSaveRequest()
        ..lockFundId = lockFundId
        ..sourceAccountId = sourceAccountId
        ..amount = amount
        ..frequency = frequency;

      final response = await _grpcClient.lockFundsClient.createLockFundAutoSave(
        request,
        options: await _grpcClient.callOptions,
      );

      return _mapAutoSaveProto(response.autosave);
    } catch (e) {
      throw Exception('Failed to create auto-save: $e');
    }
  }

  @override
  Future<LockFundAutoSaveConfig?> getAutoSave({required String lockFundId}) async {
    try {
      final request = pb.GetLockFundAutoSaveRequest()
        ..lockFundId = lockFundId;

      final response = await _grpcClient.lockFundsClient.getLockFundAutoSave(
        request,
        options: await _grpcClient.callOptions,
      );

      if (!response.hasAutosave()) return null;
      return _mapAutoSaveProto(response.autosave);
    } catch (e) {
      return null; // No auto-save configured
    }
  }

  @override
  Future<LockFundAutoSaveConfig> updateAutoSave({
    required String autoSaveId,
    double? amount,
    String? frequency,
    String? status,
  }) async {
    try {
      final request = pb.UpdateLockFundAutoSaveRequest()
        ..autosaveId = autoSaveId;
      if (amount != null) request.amount = amount;
      if (frequency != null) request.frequency = frequency;
      if (status != null) request.status = status;

      final response = await _grpcClient.lockFundsClient.updateLockFundAutoSave(
        request,
        options: await _grpcClient.callOptions,
      );

      return _mapAutoSaveProto(response.autosave);
    } catch (e) {
      throw Exception('Failed to update auto-save: $e');
    }
  }

  @override
  Future<void> deleteAutoSave({required String autoSaveId}) async {
    try {
      final request = pb.DeleteLockFundAutoSaveRequest()
        ..autosaveId = autoSaveId;

      await _grpcClient.lockFundsClient.deleteLockFundAutoSave(
        request,
        options: await _grpcClient.callOptions,
      );
    } catch (e) {
      throw Exception('Failed to delete auto-save: $e');
    }
  }

  LockFundAutoSaveConfig _mapAutoSaveProto(pb.LockFundAutoSave a) {
    return LockFundAutoSaveConfig(
      id: a.id,
      lockFundId: a.lockFundId,
      sourceAccountId: a.sourceAccountId,
      amount: a.amount,
      frequency: a.frequency,
      status: a.status,
      nextRunAt: a.nextRunAt.isNotEmpty ? DateTime.tryParse(a.nextRunAt) : null,
      lastRunAt: a.lastRunAt.isNotEmpty ? DateTime.tryParse(a.lastRunAt) : null,
      totalSaved: a.totalSaved,
      runCount: a.runCount,
    );
  }
}
