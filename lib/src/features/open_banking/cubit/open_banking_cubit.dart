import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../data/datasources/open_banking_remote_datasource.dart';
import '../data/errors/banking_errors.dart';
import '../domain/entities/linked_bank_account.dart';
import '../domain/entities/deposit.dart';
import '../domain/entities/withdrawal.dart';
import 'open_banking_state.dart';

/// Cubit for managing open banking operations
class OpenBankingCubit extends Cubit<OpenBankingState> {
  final OpenBankingRemoteDataSource _dataSource;

  // Cached data
  List<LinkedBankAccount> _linkedAccounts = [];
  LinkedBankAccount? _defaultAccount;

  OpenBankingCubit(this._dataSource) : super(OpenBankingInitial());

  /// Get cached linked accounts
  List<LinkedBankAccount> get linkedAccounts => _linkedAccounts;

  /// Get cached default account
  LinkedBankAccount? get defaultAccount => _defaultAccount;

  /// Get Mono Connect widget configuration
  Future<void> getConnectConfig(String accessToken) async {
    if (isClosed) return;
    emit(OpenBankingLoading());

    try {
      final config = await _dataSource.getConnectWidgetConfig(accessToken);
      if (isClosed) return;
      emit(ConnectConfigLoaded(
        publicKey: config['public_key']!,
        appId: config['app_id']!,
      ));
    } catch (e) {
      if (isClosed) return;
      _emitError(e, operation: 'getConnectConfig');
    }
  }

  /// Link a bank account using Mono Connect code
  Future<void> linkAccount({
    required String userId,
    required String code,
    required String accessToken,
    bool setAsDefault = false,
  }) async {
    if (isClosed) return;
    emit(AccountLinkingInProgress());

    try {
      final account = await _dataSource.linkBankAccount(
        userId: userId,
        code: code,
        accessToken: accessToken,
        setAsDefault: setAsDefault,
      );

      // Update local cache
      final existingIndex = _linkedAccounts.indexWhere((a) => a.id == account.id);
      if (existingIndex >= 0) {
        _linkedAccounts[existingIndex] = account;
      } else {
        _linkedAccounts.add(account);
      }

      if (account.isDefault) {
        _defaultAccount = account;
      }

      if (isClosed) return;
      emit(AccountLinked(account: account, isNewAccount: existingIndex < 0));
    } catch (e) {
      if (isClosed) return;
      _emitError(e, operation: 'linkAccount');
    }
  }

  /// Fetch all linked bank accounts
  Future<void> fetchLinkedAccounts({
    required String userId,
    required String accessToken,
  }) async {
    if (isClosed) return;
    emit(OpenBankingLoading());

    try {
      _linkedAccounts = await _dataSource.getLinkedAccounts(
        userId: userId,
        accessToken: accessToken,
      );

      // Find default account
      _defaultAccount = _linkedAccounts.firstWhere(
        (a) => a.isDefault,
        orElse: () => _linkedAccounts.isNotEmpty ? _linkedAccounts.first : throw Exception('No accounts'),
      );

      if (isClosed) return;
      emit(LinkedAccountsLoaded(
        accounts: _linkedAccounts,
        defaultAccount: _defaultAccount,
      ));
    } catch (e) {
      if (isClosed) return;
      _emitError(e, operation: 'fetchLinkedAccounts');
    }
  }

  /// Unlink a bank account
  Future<void> unlinkAccount({
    required String accountId,
    required String userId,
    required String accessToken,
  }) async {
    if (isClosed) return;
    emit(OpenBankingLoading());

    try {
      await _dataSource.unlinkBankAccount(
        accountId: accountId,
        userId: userId,
        accessToken: accessToken,
      );

      // Update local cache
      _linkedAccounts.removeWhere((a) => a.id == accountId);
      if (_defaultAccount?.id == accountId) {
        _defaultAccount = _linkedAccounts.isNotEmpty ? _linkedAccounts.first : null;
      }

      if (isClosed) return;
      emit(AccountUnlinked(accountId: accountId));
    } catch (e) {
      if (isClosed) return;
      _emitError(e, operation: 'unlinkAccount');
    }
  }

  /// Set a linked account as default
  Future<void> setDefaultAccount({
    required String accountId,
    required String userId,
    required String accessToken,
  }) async {
    if (isClosed) return;
    emit(OpenBankingLoading());

    try {
      await _dataSource.setDefaultLinkedAccount(
        accountId: accountId,
        userId: userId,
        accessToken: accessToken,
      );

      // Update local cache
      _linkedAccounts = _linkedAccounts.map((a) {
        if (a.id == accountId) {
          return a.copyWith(isDefault: true);
        }
        return a.copyWith(isDefault: false);
      }).toList();

      _defaultAccount = _linkedAccounts.firstWhere((a) => a.id == accountId);

      if (isClosed) return;
      emit(LinkedAccountsLoaded(
        accounts: _linkedAccounts,
        defaultAccount: _defaultAccount,
      ));
    } catch (e) {
      if (isClosed) return;
      _emitError(e, operation: 'setDefaultAccount');
    }
  }

  /// Refresh balance for a linked account
  Future<void> refreshBalance({
    required String accountId,
    required String userId,
    required String accessToken,
  }) async {
    try {
      final newBalance = await _dataSource.refreshLinkedAccountBalance(
        accountId: accountId,
        userId: userId,
        accessToken: accessToken,
      );

      // Update local cache
      final index = _linkedAccounts.indexWhere((a) => a.id == accountId);
      if (index >= 0) {
        _linkedAccounts[index] = _linkedAccounts[index].copyWith(
          lastKnownBalance: newBalance,
          balanceUpdatedAt: DateTime.now(),
        );

        if (_defaultAccount?.id == accountId) {
          _defaultAccount = _linkedAccounts[index];
        }
      }

      if (isClosed) return;
      emit(BalanceRefreshed(accountId: accountId, newBalance: newBalance));
    } catch (e) {
      if (isClosed) return;
      _emitError(e, operation: 'refreshBalance');
    }
  }

  /// Get reauthorization token for an account
  Future<void> getReauthorizationToken({
    required String accountId,
    required String userId,
    required String accessToken,
  }) async {
    if (isClosed) return;
    emit(OpenBankingLoading());

    try {
      final token = await _dataSource.getReauthorizationToken(
        accountId: accountId,
        userId: userId,
        accessToken: accessToken,
      );

      if (isClosed) return;
      emit(ReauthorizationTokenReceived(accountId: accountId, token: token));
    } catch (e) {
      if (isClosed) return;
      _emitError(e, operation: 'getReauthorizationToken');
    }
  }

  /// Initiate a deposit from linked account
  Future<void> initiateDeposit({
    required String userId,
    required String linkedAccountId,
    required String destinationAccountId,
    required double amount, // In major units (Naira)
    String? narration,
    required String accessToken,
  }) async {
    if (isClosed) return;
    emit(OpenBankingLoading());

    try {
      final idempotencyKey = const Uuid().v4();
      final amountInKobo = (amount * 100).toInt();

      final deposit = await _dataSource.initiateDeposit(
        userId: userId,
        linkedAccountId: linkedAccountId,
        destinationAccountId: destinationAccountId,
        amountInKobo: amountInKobo,
        narration: narration,
        idempotencyKey: idempotencyKey,
        accessToken: accessToken,
      );

      if (isClosed) return;
      emit(DepositInitiated(deposit: deposit));
    } catch (e) {
      if (isClosed) return;
      _emitError(e, operation: 'initiateDeposit');
    }
  }

  /// Check deposit status
  Future<void> checkDepositStatus({
    required String depositId,
    required String userId,
    required String accessToken,
  }) async {
    try {
      final deposit = await _dataSource.getDepositStatus(
        depositId: depositId,
        userId: userId,
        accessToken: accessToken,
      );

      if (isClosed) return;
      emit(DepositStatusUpdated(deposit: deposit));
    } catch (e) {
      if (isClosed) return;
      _emitError(e, operation: 'checkDepositStatus');
    }
  }

  /// Fetch user's deposit history
  Future<void> fetchDeposits({
    required String userId,
    required String accessToken,
    int limit = 20,
    int offset = 0,
  }) async {
    if (isClosed) return;
    emit(OpenBankingLoading());

    try {
      final (deposits, total) = await _dataSource.getUserDeposits(
        userId: userId,
        accessToken: accessToken,
        limit: limit,
        offset: offset,
      );

      if (isClosed) return;
      emit(DepositsLoaded(deposits: deposits, total: total));
    } catch (e) {
      if (isClosed) return;
      _emitError(e, operation: 'fetchDeposits');
    }
  }

  /// Cancel a pending deposit
  Future<void> cancelDeposit({
    required String depositId,
    required String userId,
    required String accessToken,
  }) async {
    if (isClosed) return;
    emit(OpenBankingLoading());

    try {
      await _dataSource.cancelDeposit(
        depositId: depositId,
        userId: userId,
        accessToken: accessToken,
      );

      // Refresh the deposit to get updated status
      await checkDepositStatus(
        depositId: depositId,
        userId: userId,
        accessToken: accessToken,
      );
    } catch (e) {
      if (isClosed) return;
      _emitError(e, operation: 'cancelDeposit');
    }
  }

  /// Calculate deposit fee
  Future<void> calculateFee({
    required double amount, // In major units (Naira)
    required String accessToken,
  }) async {
    try {
      final amountInKobo = (amount * 100).toInt();
      final calculation = await _dataSource.calculateDepositFee(
        amountInKobo: amountInKobo,
        accessToken: accessToken,
      );

      if (isClosed) return;
      emit(DepositFeeCalculated(calculation: calculation));
    } catch (e) {
      if (isClosed) return;
      _emitError(e, operation: 'calculateFee');
    }
  }

  // =====================================================
  // WITHDRAWAL OPERATIONS
  // =====================================================

  /// Cached banks list
  List<Bank> _banks = [];
  List<Bank> get banks => _banks;

  /// Fetch supported banks list
  Future<void> fetchBanks({
    required String accessToken,
  }) async {
    if (isClosed) return;
    emit(OpenBankingLoading());

    try {
      _banks = await _dataSource.getBanks(accessToken: accessToken);

      if (isClosed) return;
      emit(BanksLoaded(banks: _banks));
    } catch (e) {
      if (isClosed) return;
      _emitError(e, operation: 'fetchBanks');
    }
  }

  /// Resolve account name (name inquiry)
  Future<void> resolveAccountName({
    required String accountNumber,
    required String bankCode,
    required String accessToken,
  }) async {
    if (isClosed) return;
    emit(OpenBankingLoading());

    try {
      final inquiry = await _dataSource.resolveAccountName(
        accountNumber: accountNumber,
        bankCode: bankCode,
        accessToken: accessToken,
      );

      if (isClosed) return;
      emit(AccountNameResolved(inquiry: inquiry));
    } catch (e) {
      if (isClosed) return;
      _emitError(e, operation: 'resolveAccountName');
    }
  }

  /// Initiate withdrawal to external bank
  Future<void> initiateWithdrawal({
    required String userId,
    required String sourceAccountId,
    required String bankCode,
    required String accountNumber,
    required String accountName,
    required double amount, // In major units (Naira)
    String? narration,
    required String accessToken,
  }) async {
    if (isClosed) return;
    emit(OpenBankingLoading());

    try {
      final idempotencyKey = const Uuid().v4();
      final amountInKobo = (amount * 100).toInt();

      final withdrawal = await _dataSource.initiateWithdrawal(
        userId: userId,
        sourceAccountId: sourceAccountId,
        bankCode: bankCode,
        accountNumber: accountNumber,
        accountName: accountName,
        amountInKobo: amountInKobo,
        narration: narration,
        idempotencyKey: idempotencyKey,
        accessToken: accessToken,
      );

      if (isClosed) return;
      emit(WithdrawalInitiated(withdrawal: withdrawal));
    } catch (e) {
      if (isClosed) return;
      _emitError(e, operation: 'initiateWithdrawal');
    }
  }

  /// Check withdrawal status
  Future<void> checkWithdrawalStatus({
    required String withdrawalId,
    required String userId,
    required String accessToken,
  }) async {
    try {
      final withdrawal = await _dataSource.getWithdrawalStatus(
        withdrawalId: withdrawalId,
        userId: userId,
        accessToken: accessToken,
      );

      if (isClosed) return;
      emit(WithdrawalStatusUpdated(withdrawal: withdrawal));
    } catch (e) {
      if (isClosed) return;
      _emitError(e, operation: 'checkWithdrawalStatus');
    }
  }

  /// Fetch user's withdrawal history
  Future<void> fetchWithdrawals({
    required String userId,
    required String accessToken,
    int limit = 20,
    int offset = 0,
  }) async {
    if (isClosed) return;
    emit(OpenBankingLoading());

    try {
      final (withdrawals, total) = await _dataSource.getUserWithdrawals(
        userId: userId,
        accessToken: accessToken,
        limit: limit,
        offset: offset,
      );

      if (isClosed) return;
      emit(WithdrawalsLoaded(withdrawals: withdrawals, total: total));
    } catch (e) {
      if (isClosed) return;
      _emitError(e, operation: 'fetchWithdrawals');
    }
  }

  /// Calculate withdrawal fee
  Future<void> calculateWithdrawalFee({
    required double amount, // In major units (Naira)
    required String accessToken,
  }) async {
    try {
      final amountInKobo = (amount * 100).toInt();
      final calculation = await _dataSource.calculateWithdrawalFee(
        amountInKobo: amountInKobo,
        accessToken: accessToken,
      );

      if (isClosed) return;
      emit(WithdrawalFeeCalculated(calculation: calculation));
    } catch (e) {
      if (isClosed) return;
      _emitError(e, operation: 'calculateWithdrawalFee');
    }
  }

  // =====================================================
  // HELPER METHODS
  // =====================================================

  /// Check if the service is available (circuit breaker not open)
  bool get isServiceAvailable => _dataSource.isServiceAvailable;

  /// Check network connectivity
  Future<bool> hasConnectivity() => _dataSource.hasConnectivity();

  /// Reset circuit breaker manually (e.g., user requested retry)
  void resetCircuitBreaker() => _dataSource.resetCircuitBreaker();

  /// Emit appropriate error state based on exception type
  void _emitError(Object error, {String? operation}) {
    if (error is BankingException) {
      // Check for specific states that need special handling
      if (error is NetworkException) {
        emit(OpenBankingOffline(lastOperation: operation));
        return;
      }

      if (error is ServiceUnavailableException) {
        emit(ServiceUnavailable(
          message: error.userMessage,
          retryAfter: error.retryAfter,
          circuitBreakerOpen: !_dataSource.isServiceAvailable,
        ));
        return;
      }

      // Emit detailed error state
      emit(OpenBankingError.fromException(error, operation: operation));
    } else {
      // Unknown error - wrap as generic
      emit(OpenBankingError(
        message: error.toString(),
        operation: operation,
      ));
    }
  }

  /// Retry a failed operation after checking connectivity
  Future<void> retryLastOperation({
    required Future<void> Function() operation,
    required String operationName,
  }) async {
    // Check connectivity first
    if (!await hasConnectivity()) {
      emit(OpenBankingOffline(lastOperation: operationName));
      return;
    }

    // Reset circuit breaker if it was open
    if (!isServiceAvailable) {
      resetCircuitBreaker();
    }

    // Retry the operation
    await operation();
  }
}
