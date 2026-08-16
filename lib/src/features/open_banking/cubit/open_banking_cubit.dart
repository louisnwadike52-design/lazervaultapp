import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:uuid/uuid.dart';
import 'package:lazervault/src/core/services/analytics_service.dart';
import '../data/datasources/open_banking_remote_datasource.dart';
import '../data/datasources/open_banking_grpc_datasource.dart';
import '../data/datasources/credit_score_ai_service.dart';
import '../data/errors/banking_errors.dart';
import '../domain/entities/linked_bank_account.dart';
import '../domain/entities/deposit.dart';
import '../domain/entities/withdrawal.dart';
import '../domain/entities/credit_score.dart';
import '../domain/entities/credit_score_ai_insights.dart';
import 'open_banking_state.dart';

/// Cubit for managing open banking operations
/// Supports both REST and gRPC backends
class OpenBankingCubit extends Cubit<OpenBankingState> {
  final OpenBankingRemoteDataSource? _restDataSource;
  final OpenBankingGrpcDataSource? _grpcDataSource;
  final bool useGrpc;

  // Cached data
  List<LinkedBankAccount> _linkedAccounts = [];
  LinkedBankAccount? _defaultAccount;
  CreditScoreAIInsights? _cachedAIInsights;

  /// Create cubit with REST data source (legacy)
  OpenBankingCubit(OpenBankingRemoteDataSource dataSource)
      : _restDataSource = dataSource,
        _grpcDataSource = null,
        useGrpc = false,
        super(OpenBankingInitial());

  /// Create cubit with gRPC data source (preferred)
  OpenBankingCubit.withGrpc(OpenBankingGrpcDataSource dataSource)
      : _restDataSource = null,
        _grpcDataSource = dataSource,
        useGrpc = true,
        super(OpenBankingInitial());

  /// Get cached linked accounts
  List<LinkedBankAccount> get linkedAccounts => _linkedAccounts;

  /// Get cached default account
  LinkedBankAccount? get defaultAccount => _defaultAccount;

  /// Get Mono Connect widget configuration
  Future<void> getConnectConfig(String accessToken) async {
    if (isClosed) return;
    emit(OpenBankingLoading());

    try {
      final Map<String, String> config;
      if (useGrpc && _grpcDataSource != null) {
        config = await _grpcDataSource!.getConnectWidgetConfig();
      } else {
        config = await _restDataSource!.getConnectWidgetConfig(accessToken);
      }
      if (isClosed) return;
      final publicKey = config['public_key'];
      final appId = config['app_id'];
      if (publicKey == null || appId == null) {
        emit(const OpenBankingError(
          message: 'Failed to load bank connection settings',
          operation: 'getConnectConfig',
        ));
        return;
      }
      emit(ConnectConfigLoaded(
        publicKey: publicKey,
        appId: appId,
        linkFeeMinor: int.tryParse(config['link_fee'] ?? '0') ?? 0,
      ));
    } catch (e) {
      if (isClosed) return;
      _emitError(e, operation: 'getConnectConfig');
    }
  }

  /// Quote the first-time bank-link fee (minor units, aggregated Mono cost +
  /// LazerVault margin); 0 = free. Lets any link entry point show the cost +
  /// take a txPIN before linking, without emitting a state. Best-effort: any
  /// failure resolves to 0 (free) so a quote hiccup never blocks linking — the
  /// backend still enforces the real charge.
  Future<int> quoteLinkFeeMinor() async {
    try {
      if (useGrpc && _grpcDataSource != null) {
        final config = await _grpcDataSource!.getConnectWidgetConfig();
        return int.tryParse(config['link_fee'] ?? '0') ?? 0;
      }
    } catch (_) {}
    return 0;
  }

  /// Link a bank account using Mono Connect code.
  /// Automatically creates a GSM mandate for the linked account.
  Future<void> linkAccount({
    required String userId,
    required String code,
    required String accessToken,
    bool setAsDefault = false,
    bool autoCreateMandate = true,
    String? userEmail,
    String? userName,
    String? userPhone,
    String? verificationToken,
    String? transactionId,
  }) async {
    if (isClosed) return;
    emit(AccountLinkingInProgress());

    try {
      final LinkedBankAccount account;
      if (useGrpc && _grpcDataSource != null) {
        account = await _grpcDataSource!.linkBankAccount(
          userId: userId,
          code: code,
          setAsDefault: setAsDefault,
          verificationToken: verificationToken,
          transactionId: transactionId,
        );
      } else {
        account = await _restDataSource!.linkBankAccount(
          userId: userId,
          code: code,
          accessToken: accessToken,
          setAsDefault: setAsDefault,
        );
      }

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

      // Auto-create GSM mandate for seamless recurring debits
      if (autoCreateMandate && _grpcDataSource != null) {
        try {
          final mandateResult = await _grpcDataSource!.createMandate(
            userId: userId,
            linkedAccountId: account.id,
            mandateType: 'gsm',
            userEmail: userEmail,
            userName: userName,
            userPhone: userPhone,
          );
          if (isClosed) return;
          emit(AccountLinkedWithMandate(
            account: account,
            mandate: mandateResult.mandate,
            mandateNeedsAuthorization: mandateResult.needsAuthorization,
            mandateAuthorizationUrl: mandateResult.authorizationUrl,
          ));
        } catch (_) {
          if (isClosed) return;
          // Mandate creation failed — account is still linked, just no auto-debit yet
          emit(AccountLinkedWithMandate(
            account: account,
            mandateFailed: true,
            mandateError: 'Auto-debit setup pending. You can set it up later.',
          ));
        }
      } else {
        emit(AccountLinked(account: account, isNewAccount: existingIndex < 0));
      }
    } catch (e) {
      if (isClosed) return;
      _emitError(e, operation: 'linkAccount');
    }
  }

  /// Reauthorize a linked account that has an expired bank session.
  /// Returns the Mono reauth token (callers feed it to the Connect widget in
  /// reauth mode), or null on failure — an error state is emitted too.
  Future<String?> reauthorizeAccount({
    required String accountId,
    required String userId,
    required String accessToken,
  }) async {
    if (isClosed) return null;
    emit(OpenBankingLoading());

    try {
      final String token;
      if (useGrpc && _grpcDataSource != null) {
        token = await _grpcDataSource!.getReauthorizationToken(accountId: accountId);
      } else {
        token = await _restDataSource!.getReauthorizationToken(
          accountId: accountId,
          userId: userId,
          accessToken: accessToken,
        );
      }
      if (isClosed) return null;
      emit(ReauthorizationTokenReceived(accountId: accountId, token: token));
      return token;
    } catch (e) {
      if (isClosed) return null;
      _emitError(e, operation: 'reauthorizeAccount');
      return null;
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
      if (useGrpc && _grpcDataSource != null) {
        _linkedAccounts = await _grpcDataSource!.getLinkedAccounts(
          userId: userId,
        );
      } else {
        _linkedAccounts = await _restDataSource!.getLinkedAccounts(
          userId: userId,
          accessToken: accessToken,
        );
      }

      // Find default account (null if no accounts linked yet)
      if (_linkedAccounts.isNotEmpty) {
        _defaultAccount = _linkedAccounts.firstWhere(
          (a) => a.isDefault,
          orElse: () => _linkedAccounts.first,
        );
      } else {
        _defaultAccount = null;
      }

      if (isClosed) return;
      emit(LinkedAccountsLoaded(
        accounts: _linkedAccounts,
        defaultAccount: _defaultAccount,
      ));

      // COST-AWARE: a live Mono balance read consumes our Connect quota, so we
      // NO LONGER auto-refresh every balance on screen load. Widgets render the
      // last-known (cached) balance with a "not live · refresh" affordance; a
      // fresh read happens ONLY when the user explicitly taps refresh (which is
      // cost-confirmed). `autoRefreshStaleBalances` remains available for that
      // explicit, user-initiated path — it is intentionally NOT called here.
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
      if (useGrpc && _grpcDataSource != null) {
        await _grpcDataSource!.unlinkBankAccount(
          accountId: accountId,
          userId: userId,
        );
      } else {
        await _restDataSource!.unlinkBankAccount(
          accountId: accountId,
          userId: userId,
          accessToken: accessToken,
        );
      }

      // Update local cache (unlink)
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
      if (useGrpc && _grpcDataSource != null) {
        await _grpcDataSource!.setDefaultLinkedAccount(
          accountId: accountId,
          userId: userId,
        );
      } else {
        await _restDataSource!.setDefaultLinkedAccount(
          accountId: accountId,
          userId: userId,
          accessToken: accessToken,
        );
      }

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

  /// Linked-bank balances older than this are refreshed AUTOMATICALLY in the
  /// background whenever a screen loads the accounts — the user should never
  /// be nagged about a stale balance the app can refresh itself.
  static const Duration balanceStaleAfter = Duration(minutes: 10);
  final Set<String> _autoRefreshInFlight = <String>{};

  /// Fire-and-forget background refresh of every STALE linked-account balance.
  /// Runs concurrently and silently: successes update the cache and emit
  /// [BalanceRefreshed] per account (screens just re-render with fresh
  /// figures); a failure flows through the normal refreshBalance error path so
  /// screens surface a notice ONLY when an actual refresh attempt failed.
  /// Deduplicated per account so repeated screen loads can't stack calls.
  void autoRefreshStaleBalances({
    required String userId,
    required String accessToken,
    Duration? staleAfter,
  }) {
    final threshold =
        DateTime.now().subtract(staleAfter ?? balanceStaleAfter);
    for (final account in List.of(_linkedAccounts)) {
      final updatedAt = account.balanceUpdatedAt;
      final isStale = updatedAt == null || updatedAt.isBefore(threshold);
      if (!isStale) continue;
      if (!_autoRefreshInFlight.add(account.id)) continue;
      unawaited(refreshBalance(
        accountId: account.id,
        userId: userId,
        accessToken: accessToken,
      ).whenComplete(() => _autoRefreshInFlight.remove(account.id)));
    }
  }

  /// Quote the balance-refresh fee (kobo) without charging or reading Mono.
  /// The refresh CTA shows this in a cost-confirm modal before taking a txPIN.
  /// Returns 0 (free) on any error so the UI can still offer a free refresh.
  Future<int> quoteRefreshFee({
    required String accountId,
    required String userId,
    required String accessToken,
  }) async {
    try {
      if (useGrpc && _grpcDataSource != null) {
        return await _grpcDataSource!.quoteRefreshFee(
          accountId: accountId,
          userId: userId,
        );
      }
    } catch (_) {/* fall through to free */}
    return 0;
  }

  /// Refresh balance for a linked account.
  ///
  /// Pass `isManual: true` when the user explicitly tapped the Refresh
  /// button so the UI surfaces a snackbar. When a refresh fee applies, pass the
  /// txPIN `verificationToken` + `transactionId` (from the cost-confirm modal)
  /// so the backend charges the fee before the live Mono read.
  ///
  /// [rethrowOnError]: normally a failed refresh is swallowed here and surfaced
  /// only as an emitted error state (background sweeps and free refreshes want
  /// this — an unhandled async throw would crash the fire-and-forget path). The
  /// FEE-GATED tx-PIN sheet, however, `await`s this from its `onPinValidated`
  /// callback and needs the failure to PROPAGATE so the sheet shows an
  /// unsuccessful state instead of a false "balance refreshed". Those callers
  /// pass `rethrowOnError: true`; the error state is still emitted first (so any
  /// listening card also reflects the failure), then the error is rethrown.
  Future<void> refreshBalance({
    required String accountId,
    required String userId,
    required String accessToken,
    bool isManual = false,
    String? verificationToken,
    String? transactionId,
    bool rethrowOnError = false,
  }) async {
    if (isClosed) return;
    emit(BalanceRefreshing(accountId: accountId));

    try {
      final double newBalance;
      if (useGrpc && _grpcDataSource != null) {
        newBalance = await _grpcDataSource!.refreshLinkedAccountBalance(
          accountId: accountId,
          userId: userId,
          verificationToken: verificationToken,
          transactionId: transactionId,
        );
      } else {
        newBalance = await _restDataSource!.refreshLinkedAccountBalance(
          accountId: accountId,
          userId: userId,
          accessToken: accessToken,
        );
      }

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
      emit(BalanceRefreshed(
        accountId: accountId,
        newBalance: newBalance,
        isManual: isManual,
      ));
    } catch (e) {
      // If reauthorization is required, update local account status
      if (e is ReauthorizationRequiredException) {
        final index = _linkedAccounts.indexWhere((a) => a.id == accountId);
        if (index >= 0) {
          _linkedAccounts[index] = _linkedAccounts[index].copyWith(
            status: LinkedAccountStatus.reauthorize,
          );
        }
      }
      if (isClosed) return;
      _emitError(e, operation: 'refreshBalance', accountId: accountId);
      // Fee-gated tx-PIN callers await this and must see the failure so the
      // sheet flips to its unsuccessful state (never a false "balance refreshed").
      if (rethrowOnError) rethrow;
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
      final token = await _restDataSource!.getReauthorizationToken(
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
  /// Uses gRPC when available for better performance
  /// Set useRecurringAccess=false for DirectPay (one-time), true for Mandate (recurring)
  Future<void> initiateDeposit({
    required String userId,
    required String linkedAccountId,
    required String destinationAccountId,
    required double amount, // In major units (Naira)
    String? narration,
    required String accessToken,
    bool useRecurringAccess = false, // false = DirectPay (one-time), true = Mandate (recurring)
    String? currency, // destination wallet currency (e.g. NGN)
    String? countryCode, // derived country (e.g. NG) — routes NGN to Mono
    // Transaction-PIN gate for interactive bank-rail (redeposit) pulls: the
    // fee-disclosed tx-PIN sheet mints a verificationToken bound to transactionId;
    // the backend PreValidates it before creating the debit. Null for paths that
    // aren't PIN-gated (first-time link-and-deposit is bank-auth gated instead).
    String? verificationToken,
    String? transactionId,
  }) async {
    if (isClosed) return;
    emit(OpenBankingLoading());

    try {
      final idempotencyKey = const Uuid().v4();
      final amountInKobo = (amount * 100).toInt();

      final Deposit deposit;
      if (useGrpc && _grpcDataSource != null) {
        // Use gRPC for better performance and type safety
        deposit = await _grpcDataSource!.initiateDeposit(
          userId: userId,
          linkedAccountId: linkedAccountId,
          destinationAccountId: destinationAccountId,
          amountInKobo: amountInKobo,
          narration: narration,
          idempotencyKey: idempotencyKey,
          useRecurringAccess: useRecurringAccess,
          currency: currency,
          countryCode: countryCode,
          verificationToken: verificationToken,
          transactionId: transactionId,
        );
      } else {
        // Fallback to REST
        deposit = await _restDataSource!.initiateDeposit(
          userId: userId,
          linkedAccountId: linkedAccountId,
          destinationAccountId: destinationAccountId,
          amountInKobo: amountInKobo,
          narration: narration,
          idempotencyKey: idempotencyKey,
          accessToken: accessToken,
          verificationToken: verificationToken,
          transactionId: transactionId,
        );
      }

      if (isClosed) return;
      emit(DepositInitiated(deposit: deposit));
      // Telemetry: Mono initiation accepted (mandate vs one-time DirectPay).
      AnalyticsService.instance.trackDepositOutcome(
        method: useRecurringAccess ? 'mandate' : 'directpay',
        outcome: deposit.requiresAuthorization ? 'requires_auth' : 'success',
      );
    } catch (e) {
      if (isClosed) return;
      AnalyticsService.instance.trackDepositOutcome(
        method: useRecurringAccess ? 'mandate' : 'directpay',
        outcome: 'failure',
      );
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
      final Deposit deposit;
      if (useGrpc && _grpcDataSource != null) {
        deposit = await _grpcDataSource!.getDepositStatus(
          depositId: depositId,
          userId: userId,
        );
      } else {
        deposit = await _restDataSource!.getDepositStatus(
          depositId: depositId,
          userId: userId,
          accessToken: accessToken,
        );
      }

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
      List<Deposit> deposits;
      int total;
      if (useGrpc && _grpcDataSource != null) {
        final result = await _grpcDataSource!.getUserDeposits(
          userId: userId,
          limit: limit,
          offset: offset,
        );
        deposits = result.$1;
        total = result.$2;
      } else {
        final result = await _restDataSource!.getUserDeposits(
          userId: userId,
          accessToken: accessToken,
          limit: limit,
          offset: offset,
        );
        deposits = result.$1;
        total = result.$2;
      }

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
      if (useGrpc && _grpcDataSource != null) {
        await _grpcDataSource!.cancelDeposit(
          depositId: depositId,
          userId: userId,
        );
      } else {
        await _restDataSource!.cancelDeposit(
          depositId: depositId,
          userId: userId,
          accessToken: accessToken,
        );
      }

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

  /// Returns the deposit fee calculation (aggregated Mono + LazerVault fee + net)
  /// for an amount WITHOUT emitting a state — used for the inline fee preview
  /// under the amount field. Returns null on error so the UI hides the preview.
  Future<DepositFeeCalculation?> depositFeeQuote(int amountKobo) async {
    if (amountKobo <= 0) return null;
    try {
      if (useGrpc && _grpcDataSource != null) {
        return await _grpcDataSource!.calculateDepositFee(amountInKobo: amountKobo);
      }
    } catch (_) {/* hide preview on error */}
    return null;
  }

  /// Consolidated fee quote (connect + deposit, broken down per rail) for the
  /// pre-link fee-disclosure modal. Returns null on error so the caller can
  /// proceed with a generic notice rather than blocking the deposit.
  Future<DepositFeeQuote?> fetchDepositFeeQuote({
    required int amountKobo,
    required bool useRecurringAccess,
    required bool firstTimeLink,
  }) async {
    if (amountKobo <= 0) return null;
    try {
      if (useGrpc && _grpcDataSource != null) {
        return await _grpcDataSource!.getDepositFeeQuote(
          amountInKobo: amountKobo,
          useRecurringAccess: useRecurringAccess,
          firstTimeLink: firstTimeLink,
        );
      }
    } catch (_) {/* fall back to generic notice on error */}
    return null;
  }

  /// Calculate deposit fee
  Future<void> calculateFee({
    required double amount, // In major units (Naira)
    required String accessToken,
  }) async {
    try {
      final amountInKobo = (amount * 100).toInt();
      final DepositFeeCalculation calculation;
      if (useGrpc && _grpcDataSource != null) {
        calculation = await _grpcDataSource!.calculateDepositFee(
          amountInKobo: amountInKobo,
        );
      } else {
        calculation = await _restDataSource!.calculateDepositFee(
          amountInKobo: amountInKobo,
          accessToken: accessToken,
        );
      }

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
      _banks = await _restDataSource!.getBanks(accessToken: accessToken);

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
      final inquiry = await _restDataSource!.resolveAccountName(
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

      final withdrawal = await _restDataSource!.initiateWithdrawal(
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
      final withdrawal = await _restDataSource!.getWithdrawalStatus(
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
      final (withdrawals, total) = await _restDataSource!.getUserWithdrawals(
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
      final calculation = await _restDataSource!.calculateWithdrawalFee(
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
  // CREDIT SCORE OPERATIONS
  // =====================================================

  /// Fetch the user's credit score
  Future<void> fetchCreditScore({
    required String userId,
    String? linkedAccountId,
  }) async {
    if (isClosed) return;
    emit(OpenBankingLoading());

    try {
      final CreditScoreEntity creditScore;
      if (useGrpc && _grpcDataSource != null) {
        creditScore = await _grpcDataSource!.getCreditScore(
          userId: userId,
          linkedAccountId: linkedAccountId,
        );
      } else {
        throw UnimplementedError('Credit score is only available via gRPC');
      }

      if (isClosed) return;
      emit(CreditScoreLoaded(creditScore: creditScore));
    } catch (e) {
      if (isClosed) return;
      _emitError(e, operation: 'fetchCreditScore');
    }
  }

  /// Fetch credit score history
  Future<void> fetchCreditScoreHistory({
    required String userId,
    int months = 12,
  }) async {
    if (isClosed) return;
    emit(OpenBankingLoading());

    try {
      final CreditScoreHistoryEntity history;
      if (useGrpc && _grpcDataSource != null) {
        history = await _grpcDataSource!.getCreditScoreHistory(
          userId: userId,
          months: months,
        );
      } else {
        throw UnimplementedError('Credit score history is only available via gRPC');
      }

      if (isClosed) return;
      emit(CreditScoreHistoryLoaded(history: history));
    } catch (e) {
      if (isClosed) return;
      _emitError(e, operation: 'fetchCreditScoreHistory');
    }
  }

  /// Refresh credit score by re-analyzing linked account transactions
  Future<void> refreshCreditScore({
    required String userId,
    required String linkedAccountId,
  }) async {
    if (isClosed) return;
    emit(CreditScoreRefreshing());

    try {
      final CreditScoreEntity creditScore;
      if (useGrpc && _grpcDataSource != null) {
        creditScore = await _grpcDataSource!.refreshCreditScore(
          userId: userId,
          linkedAccountId: linkedAccountId,
        );
      } else {
        throw UnimplementedError('Credit score refresh is only available via gRPC');
      }

      if (isClosed) return;
      emit(CreditScoreLoaded(creditScore: creditScore));
    } catch (e) {
      if (isClosed) return;
      _emitError(e, operation: 'refreshCreditScore');
    }
  }

  /// Fetch multi-source credit scores (LazerVault, External, Combined)
  Future<void> fetchMultiSourceCreditScores({
    required String userId,
    String? linkedAccountId,
  }) async {
    if (isClosed) return;
    emit(OpenBankingLoading());

    try {
      final MultiSourceCreditScores scores;
      if (useGrpc && _grpcDataSource != null) {
        scores = await _grpcDataSource!.getMultiSourceCreditScores(
          userId: userId,
          linkedAccountId: linkedAccountId,
        );
      } else {
        throw UnimplementedError('Multi-source credit scores only available via gRPC');
      }

      if (isClosed) return;
      emit(MultiSourceCreditScoresLoaded(scores: scores));
    } catch (e) {
      if (isClosed) return;
      _emitError(e, operation: 'fetchMultiSourceCreditScores');
    }
  }

  // =====================================================
  // AI CREDIT SCORE INSIGHTS
  // =====================================================

  /// Get cached AI insights
  CreditScoreAIInsights? get cachedAIInsights => _cachedAIInsights;

  /// Fetch AI-generated credit score insights
  Future<void> fetchAICreditInsights(CreditScoreEntity score) async {
    if (isClosed) return;

    // Return cached insights if available
    if (_cachedAIInsights != null) {
      emit(CreditScoreAIInsightsLoaded(insights: _cachedAIInsights!));
      return;
    }

    emit(CreditScoreAIInsightsLoading());

    try {
      // Resolve AI service from DI (avoid constructor dependency for backward compat)
      final aiService = _resolveAIService();
      if (aiService == null) {
        emit(const CreditScoreAIInsightsError(
          message: 'AI insights service not available',
        ));
        return;
      }

      final insights = await aiService.getAIInsights(score);
      _cachedAIInsights = insights;

      if (isClosed) return;
      emit(CreditScoreAIInsightsLoaded(insights: insights));
    } catch (e) {
      if (isClosed) return;
      emit(CreditScoreAIInsightsError(message: e.toString()));
    }
  }

  CreditScoreAIService? _resolveAIService() {
    try {
      // Use GetIt to resolve without adding constructor dependency
      // This import is already available in injection_container
      return GetIt.instance<CreditScoreAIService>();
    } catch (_) {
      return null;
    }
  }

  // =====================================================
  // EXTERNAL TRANSACTION SYNC OPERATIONS
  // =====================================================

  // syncAllAccountTransactions REMOVED: refreshing every linked bank at once
  // fanned out cost-incurring live Mono reads with no user fee. Sync a single
  // account explicitly (syncAccountTransactions) or rely on the event-driven
  // mono.events.account_updated webhook + each card's fee-gated balance refresh.

  /// Sync transactions for a specific account
  Future<void> syncAccountTransactions({
    required String accountId,
    required String userId,
    String syncType = 'incremental',
  }) async {
    if (isClosed) return;
    if (!useGrpc || _grpcDataSource == null) {
      emit(const OpenBankingError(
        message: 'Transaction sync is only available via gRPC',
        errorType: BankingErrorType.general,
      ));
      return;
    }

    emit(AccountTransactionsSyncing(accountId: accountId));

    try {
      final result = await _grpcDataSource!.syncAccountTransactions(
        accountId: accountId,
        userId: userId,
        syncType: syncType,
      );

      if (isClosed) return;
      emit(AccountTransactionsSynced(
        accountId: accountId,
        transactionsSynced: result.transactionsSynced,
        newBalance: 0, // Will be updated when balance is refreshed
      ));

      // Refresh linked accounts to get updated sync status
      await fetchLinkedAccounts(userId: userId, accessToken: '');
    } catch (e) {
      if (isClosed) return;
      _emitError(e, operation: 'syncAccountTransactions');
    }
  }

  /// Get account with its external transactions
  Future<void> getAccountWithTransactions({
    required String accountId,
    int limit = 50,
    int offset = 0,
  }) async {
    if (isClosed) return;
    if (!useGrpc || _grpcDataSource == null) {
      emit(const OpenBankingError(
        message: 'Transaction sync is only available via gRPC',
        errorType: BankingErrorType.general,
      ));
      return;
    }

    emit(OpenBankingLoading());

    try {
      final result = await _grpcDataSource!.getAccountWithTransactions(
        accountId: accountId,
        limit: limit,
        offset: offset,
      );

      if (isClosed) return;
      emit(AccountTransactionsLoaded(
        accountId: accountId,
        transactions: result.transactions,
        totalTransactions: result.totalTransactions,
        lastSyncAt: result.lastSyncAt,
      ));
    } catch (e) {
      if (isClosed) return;
      _emitError(e, operation: 'getAccountWithTransactions');
    }
  }

  /// Refresh balance and latest transactions for an account
  Future<void> refreshAccountTransactions({
    required String accountId,
    required String userId,
    required String accessToken,
  }) async {
    if (isClosed) return;
    if (!useGrpc || _grpcDataSource == null) {
      emit(const OpenBankingError(
        message: 'Transaction sync is only available via gRPC',
        errorType: BankingErrorType.general,
      ));
      return;
    }

    emit(AccountTransactionsSyncing(accountId: accountId));

    try {
      final result = await _grpcDataSource!.refreshAccountTransactions(
        accountId: accountId,
        userId: userId,
      );

      // Update local cache with new balance
      final index = _linkedAccounts.indexWhere((a) => a.id == accountId);
      if (index >= 0) {
        _linkedAccounts[index] = _linkedAccounts[index].copyWith(
          lastKnownBalance: result.newBalance,
          balanceUpdatedAt: DateTime.now(),
        );

        if (_defaultAccount?.id == accountId) {
          _defaultAccount = _linkedAccounts[index];
        }
      }

      if (isClosed) return;
      emit(AccountTransactionsSynced(
        accountId: accountId,
        transactionsSynced: result.transactionsSynced,
        newBalance: result.newBalance,
      ));

      // Refresh linked accounts list to show updated sync status
      await fetchLinkedAccounts(userId: userId, accessToken: accessToken);
    } catch (e) {
      if (isClosed) return;
      _emitError(e, operation: 'refreshAccountTransactions');
    }
  }

  // =====================================================
  // HELPER METHODS
  // =====================================================

  /// Check if the service is available (circuit breaker not open)
  bool get isServiceAvailable => _restDataSource?.isServiceAvailable ?? true;

  /// Check network connectivity
  Future<bool> hasConnectivity() =>
      _restDataSource?.hasConnectivity() ?? Future.value(true);

  /// Reset circuit breaker manually (e.g., user requested retry)
  void resetCircuitBreaker() => _restDataSource?.resetCircuitBreaker();

  /// Emit appropriate error state based on exception type
  void _emitError(Object error, {String? operation, String? accountId}) {
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
          circuitBreakerOpen: !(_restDataSource?.isServiceAvailable ?? true),
        ));
        return;
      }

      // Emit detailed error state (carries account_id when a per-account op).
      emit(OpenBankingError.fromException(error,
          operation: operation, accountId: accountId));
    } else {
      // Unknown error - wrap as generic
      emit(OpenBankingError(
        message: error.toString(),
        operation: operation,
        details: accountId != null ? {'account_id': accountId} : null,
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
