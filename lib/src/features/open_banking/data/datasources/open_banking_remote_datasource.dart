import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:lazervault/core/utils/api_headers.dart';
import '../../domain/entities/linked_bank_account.dart';
import '../../domain/entities/deposit.dart';
import '../../domain/entities/withdrawal.dart';
import '../errors/banking_errors.dart';
import '../network/resilient_client.dart';

/// Remote data source for open banking operations
/// Handles all edge cases for provider switching including:
/// - Automatic retry with exponential backoff
/// - Circuit breaker for failing services
/// - Proper error classification
/// - Offline detection
class OpenBankingRemoteDataSource {
  final ResilientBankingClient _client;
  final String _baseUrl;
  final SecureStorageService _secureStorage;
  final void Function(RequestEvent)? onRequestEvent;

  OpenBankingRemoteDataSource({
    ResilientBankingClient? client,
    String? baseUrl,
    required SecureStorageService secureStorage,
    this.onRequestEvent,
  })  : _client = client ??
            ResilientBankingClient(
              retryConfig: const RetryConfig(
                maxRetries: 3,
                baseDelay: Duration(milliseconds: 500),
                maxDelay: Duration(seconds: 30),
              ),
              timeout: const Duration(seconds: 30),
            ),
        _baseUrl = baseUrl ?? _getBaseUrl(),
        _secureStorage = secureStorage;

  /// Create with custom retry configuration
  factory OpenBankingRemoteDataSource.withConfig({
    required RetryConfig retryConfig,
    Duration timeout = const Duration(seconds: 30),
    String? baseUrl,
    required SecureStorageService secureStorage,
    void Function(RequestEvent)? onRequestEvent,
  }) {
    return OpenBankingRemoteDataSource(
      client: ResilientBankingClient(
        retryConfig: retryConfig,
        timeout: timeout,
        onEvent: onRequestEvent,
      ),
      baseUrl: baseUrl,
      secureStorage: secureStorage,
      onRequestEvent: onRequestEvent,
    );
  }

  static String _getBaseUrl() {
    final host = dotenv.env['BANKING_API_URL'] ?? 'http://10.0.2.2:8082';
    return '$host/api/v1';
  }

  /// Build headers with all required metadata
  Future<Map<String, String>> _getHeaders() async {
    return ApiHeaders.build(secureStorage: _secureStorage);
  }

  /// Check if service is available (circuit breaker not open)
  bool get isServiceAvailable => _client.circuitState != CircuitState.open;

  /// Reset circuit breaker manually
  void resetCircuitBreaker() => _client.resetCircuitBreaker();

  /// Check network connectivity
  Future<bool> hasConnectivity() => _client.hasConnectivity();

  // =====================================================
  // MONO CONNECT CONFIG
  // =====================================================

  /// Get Mono Connect widget configuration
  /// Throws [BankingException] on failure
  Future<Map<String, String>> getConnectWidgetConfig(String accessToken) async {
    final response = await _client.get(
      Uri.parse('$_baseUrl/open-banking/connect-config'),
      headers: await _getHeaders(),
    );

    final data = response.parseJsonOrThrow();
    final publicKey = data['public_key'] as String? ??
        data['publicKey'] as String?;
    final appId = data['app_id'] as String? ??
        data['appId'] as String?;
    if (publicKey == null || publicKey.isEmpty || appId == null || appId.isEmpty) {
      throw const GenericBankingException(
        message: 'Invalid connect configuration received from server',
        isRetryable: true,
      );
    }
    return {
      'public_key': publicKey,
      'app_id': appId,
    };
  }

  // =====================================================
  // LINKED ACCOUNTS
  // =====================================================

  /// Link a bank account using Mono Connect code
  /// Throws [BankingException] on failure
  Future<LinkedBankAccount> linkBankAccount({
    required String userId,
    required String code,
    required String accessToken,
    bool setAsDefault = false,
  }) async {
    // Use shorter retry for linking as user is waiting
    final response = await _client.post(
      Uri.parse('$_baseUrl/open-banking/link'),
      headers: await _getHeaders(),
      body: jsonEncode({
        'user_id': userId,
        'code': code,
        'set_as_default': setAsDefault,
      }),
      retryConfig: const RetryConfig(
        maxRetries: 2,
        baseDelay: Duration(milliseconds: 500),
      ),
    );

    final data = response.parseJsonOrThrow();
    final accountData = data['account'] as Map<String, dynamic>?;
    if (accountData == null) {
      throw const GenericBankingException(
        message: 'Server returned no account data after linking',
        isRetryable: true,
      );
    }
    return LinkedBankAccount.fromJson(accountData);
  }

  /// Get all linked bank accounts for a user
  /// Throws [BankingException] on failure
  Future<List<LinkedBankAccount>> getLinkedAccounts({
    required String userId,
    required String accessToken,
  }) async {
    final response = await _client.get(
      Uri.parse('$_baseUrl/users/$userId/linked-accounts'),
      headers: await _getHeaders(),
    );

    final data = response.parseJsonOrThrow();
    final accountsList = data['accounts'] as List? ?? [];
    return accountsList
        .map((e) => LinkedBankAccount.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// Get a specific linked account
  /// Throws [BankingException] on failure
  Future<LinkedBankAccount> getLinkedAccount({
    required String accountId,
    required String accessToken,
  }) async {
    final response = await _client.get(
      Uri.parse('$_baseUrl/linked-accounts/$accountId'),
      headers: await _getHeaders(),
    );

    final data = response.parseJsonOrThrow();
    final accountData = data['account'] as Map<String, dynamic>?;
    if (accountData == null) {
      throw AccountNotFoundException(
        message: 'Account $accountId not found',
        accountId: accountId,
      );
    }
    return LinkedBankAccount.fromJson(accountData);
  }

  /// Unlink a bank account
  /// Throws [BankingException] on failure
  Future<void> unlinkBankAccount({
    required String accountId,
    required String userId,
    required String accessToken,
  }) async {
    final response = await _client.delete(
      Uri.parse('$_baseUrl/linked-accounts/$accountId?user_id=$userId'),
      headers: await _getHeaders(),
      // No retry for delete operations
      retryConfig: RetryConfig.none,
    );

    response.parseJsonOrThrow();
  }

  /// Set a linked account as default
  /// Throws [BankingException] on failure
  Future<void> setDefaultLinkedAccount({
    required String accountId,
    required String userId,
    required String accessToken,
  }) async {
    final response = await _client.post(
      Uri.parse('$_baseUrl/linked-accounts/$accountId/set-default'),
      headers: await _getHeaders(),
      body: jsonEncode({'user_id': userId}),
    );

    response.parseJsonOrThrow();
  }

  /// Refresh balance for a linked account
  /// Throws [BankingException] on failure
  Future<double> refreshLinkedAccountBalance({
    required String accountId,
    required String userId,
    required String accessToken,
  }) async {
    final response = await _client.post(
      Uri.parse('$_baseUrl/linked-accounts/$accountId/refresh-balance'),
      headers: await _getHeaders(),
      body: jsonEncode({'user_id': userId}),
    );

    final data = response.parseJsonOrThrow();
    // Proto field: new_balance (int64) → JSON: newBalance (camelCase)
    // Proto3 omits default values, so 0 balance won't have the field
    final rawBalance = data['newBalance'] ?? data['new_balance'] ?? 0;
    return (rawBalance as num).toDouble() / 100; // Convert from kobo
  }

  /// Get reauthorization token
  /// Throws [BankingException] on failure
  Future<String> getReauthorizationToken({
    required String accountId,
    required String userId,
    required String accessToken,
  }) async {
    final response = await _client.post(
      Uri.parse('$_baseUrl/linked-accounts/$accountId/reauthorize'),
      headers: await _getHeaders(),
      body: jsonEncode({'user_id': userId}),
    );

    final data = response.parseJsonOrThrow();
    final token = data['token'] as String?;
    if (token == null || token.isEmpty) {
      throw const GenericBankingException(
        message: 'Failed to obtain reauthorization token. Please try again.',
        isRetryable: true,
      );
    }
    return token;
  }

  // =====================================================
  // DEPOSITS
  // =====================================================

  /// Initiate a deposit via direct debit
  /// Uses idempotency key to prevent duplicate transactions
  /// Throws [BankingException] on failure:
  /// - [InsufficientFundsException] if source account has insufficient balance
  /// - [LimitExceededException] if daily/transaction limit exceeded
  /// - [ServiceUnavailableException] if provider is down
  Future<Deposit> initiateDeposit({
    required String userId,
    required String linkedAccountId,
    required String destinationAccountId,
    required int amountInKobo,
    String? narration,
    required String idempotencyKey,
    required String accessToken,
  }) async {
    // For financial transactions, use conservative retry
    // Idempotency key prevents duplicate debits on retry
    final response = await _client.post(
      Uri.parse('$_baseUrl/deposits'),
      headers: await _getHeaders(),
      body: jsonEncode({
        'user_id': userId,
        'linked_account_id': linkedAccountId,
        'destination_account_id': destinationAccountId,
        'amount': amountInKobo,
        'narration': narration ?? 'Deposit to LazerVault',
        'idempotency_key': idempotencyKey,
      }),
      retryConfig: const RetryConfig(
        maxRetries: 2,
        baseDelay: Duration(seconds: 1),
        retryOnServerError: true,
        retryOnNetworkError: true,
      ),
    );

    final data = response.parseJsonOrThrow();
    final depositData = data['deposit'] as Map<String, dynamic>?;
    if (depositData == null) {
      throw const GenericBankingException(
        message: 'Server returned no deposit data',
        isRetryable: true,
      );
    }
    return Deposit.fromJson(depositData);
  }

  /// Get deposit status
  /// Throws [BankingException] on failure
  Future<Deposit> getDepositStatus({
    required String depositId,
    required String userId,
    required String accessToken,
  }) async {
    final response = await _client.get(
      Uri.parse('$_baseUrl/deposits/$depositId?user_id=$userId'),
      headers: await _getHeaders(),
    );

    final data = response.parseJsonOrThrow();
    final depositData = data['deposit'] as Map<String, dynamic>?;
    if (depositData == null) {
      throw const GenericBankingException(
        message: 'Deposit not found',
        isRetryable: false,
      );
    }
    return Deposit.fromJson(depositData);
  }

  /// Get user's deposits
  /// Throws [BankingException] on failure
  Future<(List<Deposit>, int)> getUserDeposits({
    required String userId,
    required String accessToken,
    int limit = 20,
    int offset = 0,
  }) async {
    final response = await _client.get(
      Uri.parse('$_baseUrl/users/$userId/deposits?limit=$limit&offset=$offset'),
      headers: await _getHeaders(),
    );

    final data = response.parseJsonOrThrow();
    final depositsList = data['deposits'] as List? ?? [];
    final deposits = depositsList
        .map((e) => Deposit.fromJson(e as Map<String, dynamic>))
        .toList();
    final total = data['total'] as int? ?? deposits.length;
    return (deposits, total);
  }

  /// Cancel a pending deposit
  /// Throws [BankingException] on failure
  Future<void> cancelDeposit({
    required String depositId,
    required String userId,
    required String accessToken,
  }) async {
    final response = await _client.post(
      Uri.parse('$_baseUrl/deposits/$depositId/cancel'),
      headers: await _getHeaders(),
      body: jsonEncode({'user_id': userId}),
      // No retry for cancel - might result in partial state
      retryConfig: RetryConfig.none,
    );

    response.parseJsonOrThrow();
  }

  /// Calculate deposit fee
  /// Throws [BankingException] on failure
  Future<DepositFeeCalculation> calculateDepositFee({
    required int amountInKobo,
    required String accessToken,
  }) async {
    final response = await _client.get(
      Uri.parse('$_baseUrl/deposits/calculate-fee?amount=$amountInKobo'),
      headers: await _getHeaders(),
    );

    final data = response.parseJsonOrThrow();
    return DepositFeeCalculation.fromJson(data);
  }

  // =====================================================
  // WITHDRAWALS
  // =====================================================

  /// Get list of supported banks
  /// This can be cached on the client side
  /// Throws [BankingException] on failure
  Future<List<Bank>> getBanks({
    required String accessToken,
  }) async {
    final response = await _client.get(
      Uri.parse('$_baseUrl/banks'),
      headers: await _getHeaders(),
      // Aggressive retry - banks list is essential
      retryConfig: RetryConfig.aggressive,
    );

    final data = response.parseJsonOrThrow();
    final banksList = data['banks'] as List? ?? [];
    return banksList
        .map((e) => Bank.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// Resolve account name (name inquiry)
  /// Throws [AccountVerificationException] if account cannot be verified
  /// Throws [BankingException] on other failures
  Future<AccountNameInquiry> resolveAccountName({
    required String accountNumber,
    required String bankCode,
    required String accessToken,
  }) async {
    final response = await _client.post(
      Uri.parse('$_baseUrl/banks/resolve-account'),
      headers: await _getHeaders(),
      body: jsonEncode({
        'account_number': accountNumber,
        'bank_code': bankCode,
      }),
      // Moderate retry - user is waiting but verification can fail legitimately
      retryConfig: const RetryConfig(
        maxRetries: 2,
        baseDelay: Duration(milliseconds: 500),
      ),
    );

    final data = response.parseJsonOrThrow();
    return AccountNameInquiry.fromJson(data);
  }

  /// Initiate a withdrawal (payout to bank)
  /// Uses idempotency key to prevent duplicate transactions
  /// Throws [BankingException] on failure:
  /// - [InsufficientFundsException] if account has insufficient balance
  /// - [LimitExceededException] if daily/transaction limit exceeded
  /// - [AccountFrozenException] if account is frozen
  /// - [ServiceUnavailableException] if provider is down
  Future<Withdrawal> initiateWithdrawal({
    required String userId,
    required String sourceAccountId,
    required String bankCode,
    required String accountNumber,
    required String accountName,
    required int amountInKobo,
    String? narration,
    required String idempotencyKey,
    required String accessToken,
  }) async {
    // For financial transactions, use conservative retry
    // Idempotency key prevents duplicate debits on retry
    final response = await _client.post(
      Uri.parse('$_baseUrl/withdrawals'),
      headers: await _getHeaders(),
      body: jsonEncode({
        'user_id': userId,
        'source_account_id': sourceAccountId,
        'bank_code': bankCode,
        'account_number': accountNumber,
        'account_name': accountName,
        'amount': amountInKobo,
        'narration': narration ?? 'Withdrawal from LazerVault',
        'idempotency_key': idempotencyKey,
      }),
      retryConfig: const RetryConfig(
        maxRetries: 2,
        baseDelay: Duration(seconds: 1),
        retryOnServerError: true,
        retryOnNetworkError: true,
      ),
    );

    final data = response.parseJsonOrThrow();
    final withdrawalData = data['withdrawal'] as Map<String, dynamic>?;
    if (withdrawalData == null) {
      throw const GenericBankingException(
        message: 'Server returned no withdrawal data',
        isRetryable: true,
      );
    }
    return Withdrawal.fromJson(withdrawalData);
  }

  /// Get withdrawal status
  /// Throws [BankingException] on failure
  Future<Withdrawal> getWithdrawalStatus({
    required String withdrawalId,
    required String userId,
    required String accessToken,
  }) async {
    final response = await _client.get(
      Uri.parse('$_baseUrl/withdrawals/$withdrawalId?user_id=$userId'),
      headers: await _getHeaders(),
    );

    final data = response.parseJsonOrThrow();
    final withdrawalData = data['withdrawal'] as Map<String, dynamic>?;
    if (withdrawalData == null) {
      throw const GenericBankingException(
        message: 'Withdrawal not found',
        isRetryable: false,
      );
    }
    return Withdrawal.fromJson(withdrawalData);
  }

  /// Get user's withdrawals
  /// Throws [BankingException] on failure
  Future<(List<Withdrawal>, int)> getUserWithdrawals({
    required String userId,
    required String accessToken,
    int limit = 20,
    int offset = 0,
  }) async {
    final response = await _client.get(
      Uri.parse('$_baseUrl/users/$userId/withdrawals?limit=$limit&offset=$offset'),
      headers: await _getHeaders(),
    );

    final data = response.parseJsonOrThrow();
    final withdrawalsList = data['withdrawals'] as List? ?? [];
    final withdrawals = withdrawalsList
        .map((e) => Withdrawal.fromJson(e as Map<String, dynamic>))
        .toList();
    final total = data['total'] as int? ?? withdrawals.length;
    return (withdrawals, total);
  }

  /// Calculate withdrawal fee
  /// Throws [BankingException] on failure
  Future<WithdrawalFeeCalculation> calculateWithdrawalFee({
    required int amountInKobo,
    required String accessToken,
  }) async {
    final response = await _client.get(
      Uri.parse('$_baseUrl/withdrawals/calculate-fee?amount=$amountInKobo'),
      headers: await _getHeaders(),
    );

    final data = response.parseJsonOrThrow();
    return WithdrawalFeeCalculation.fromJson(data);
  }

  /// Dispose the client
  void dispose() {
    _client.close();
  }
}
