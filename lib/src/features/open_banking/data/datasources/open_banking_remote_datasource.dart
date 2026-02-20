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
    final host = dotenv.env['API_BASE_URL'] ?? 'http://10.0.2.2:8080';
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
    return {
      'public_key': data['public_key'] as String,
      'app_id': data['app_id'] as String,
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
    return LinkedBankAccount.fromJson(data['account']);
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
    final accounts = (data['accounts'] as List)
        .map((e) => LinkedBankAccount.fromJson(e))
        .toList();
    return accounts;
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
    return LinkedBankAccount.fromJson(data['account']);
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
    return (data['balance'] as num).toDouble() / 100; // Convert from kobo
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
    return data['token'] as String;
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
    return Deposit.fromJson(data['deposit']);
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
    return Deposit.fromJson(data['deposit']);
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
    final deposits = (data['deposits'] as List)
        .map((e) => Deposit.fromJson(e))
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
    final banks = (data['banks'] as List)
        .map((e) => Bank.fromJson(e))
        .toList();
    return banks;
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
    return Withdrawal.fromJson(data['withdrawal']);
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
    return Withdrawal.fromJson(data['withdrawal']);
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
    final withdrawals = (data['withdrawals'] as List)
        .map((e) => Withdrawal.fromJson(e))
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
