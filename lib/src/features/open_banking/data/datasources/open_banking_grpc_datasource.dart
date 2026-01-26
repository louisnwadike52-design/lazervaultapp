import 'package:fixnum/fixnum.dart';
import 'package:grpc/grpc.dart';
import 'package:uuid/uuid.dart';

import 'package:lazervault/core/network/retry_policy.dart';
import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/src/generated/banking.pbgrpc.dart' as banking;
import 'package:lazervault/src/generated/banking.pb.dart' as banking_pb;
import '../../domain/entities/linked_bank_account.dart';
import '../../domain/entities/deposit.dart';
import '../errors/banking_errors.dart';

/// gRPC data source for open banking operations (deposits via Mono)
/// This replaces REST calls with direct gRPC calls to banking-service
class OpenBankingGrpcDataSource {
  final banking.BankingServiceClient _client;
  final GrpcCallOptionsHelper _callOptionsHelper;
  final _uuid = const Uuid();

  OpenBankingGrpcDataSource(
    this._client,
    this._callOptionsHelper,
  );

  // =====================================================
  // MONO CONNECT CONFIG
  // =====================================================

  /// Get Mono Connect widget configuration
  Future<Map<String, String>> getConnectWidgetConfig() async {
    try {
      final request = banking_pb.GetConnectWidgetConfigRequest();
      final callOptions = await _callOptionsHelper.withAuth();

      final response = await _client.getConnectWidgetConfig(
        request,
        options: callOptions.mergedWith(
          CallOptions(timeout: const Duration(seconds: 15)),
        ),
      );

      return {
        'public_key': response.publicKey,
        'app_id': response.appId,
      };
    } on GrpcError catch (e) {
      throw _mapGrpcError(e, 'getConnectWidgetConfig');
    }
  }

  // =====================================================
  // LINKED ACCOUNTS
  // =====================================================

  /// Link a bank account using Mono Connect code
  Future<LinkedBankAccount> linkBankAccount({
    required String userId,
    required String code,
    bool setAsDefault = false,
  }) async {
    print('[OpenBankingGrpc] linkBankAccount called - userId: $userId, code: ${code.substring(0, 10)}...');
    try {
      final request = banking_pb.LinkBankAccountRequest(
        userId: userId,
        code: code,
        setAsDefault: setAsDefault,
      );
      print('[OpenBankingGrpc] Request created, calling gRPC...');

      final response = await _callOptionsHelper.executeWithTokenRotation(() async {
        final callOptions = await _callOptionsHelper.withAuth();
        print('[OpenBankingGrpc] Got call options, making gRPC call...');
        return await _client.linkBankAccount(
          request,
          options: callOptions.mergedWith(
            CallOptions(timeout: const Duration(seconds: 30)),
          ),
        );
      });
      print('[OpenBankingGrpc] gRPC response received - success: ${response.success}');

      if (!response.success) {
        print('[OpenBankingGrpc] Response not successful - code: ${response.errorCode}, message: ${response.errorMessage}');
        throw GenericBankingException(
          code: response.errorCode,
          message: response.errorMessage,
        );
      }

      print('[OpenBankingGrpc] Mapping linked account response...');
      return _mapLinkedAccount(response.account);
    } on GrpcError catch (e) {
      print('[OpenBankingGrpc] GrpcError: code=${e.code}, message=${e.message}, details=${e.details}');
      throw _mapGrpcError(e, 'linkBankAccount');
    } catch (e, stackTrace) {
      print('[OpenBankingGrpc] Unexpected error: $e');
      print('[OpenBankingGrpc] Stack trace: $stackTrace');
      rethrow;
    }
  }

  /// Get all linked bank accounts for a user
  Future<List<LinkedBankAccount>> getLinkedAccounts({
    required String userId,
  }) async {
    try {
      final request = banking_pb.GetLinkedAccountsRequest(userId: userId);
      final callOptions = await _callOptionsHelper.withAuth();

      final response = await _client.getLinkedAccounts(
        request,
        options: callOptions.mergedWith(
          CallOptions(timeout: const Duration(seconds: 15)),
        ),
      );

      return response.accounts.map(_mapLinkedAccount).toList();
    } on GrpcError catch (e) {
      throw _mapGrpcError(e, 'getLinkedAccounts');
    }
  }

  /// Unlink a bank account
  Future<void> unlinkBankAccount({
    required String accountId,
    required String userId,
  }) async {
    try {
      final request = banking_pb.UnlinkBankAccountRequest(
        accountId: accountId,
        userId: userId,
      );

      final response = await _callOptionsHelper.executeWithTokenRotation(() async {
        final callOptions = await _callOptionsHelper.withAuth();
        return await _client.unlinkBankAccount(
          request,
          options: callOptions.mergedWith(
            CallOptions(timeout: const Duration(seconds: 15)),
          ),
        );
      });

      if (!response.success) {
        throw GenericBankingException(
          code: response.errorCode,
          message: response.errorMessage,
        );
      }
    } on GrpcError catch (e) {
      throw _mapGrpcError(e, 'unlinkBankAccount');
    }
  }

  /// Set a linked account as default
  Future<void> setDefaultLinkedAccount({
    required String accountId,
    required String userId,
  }) async {
    try {
      final request = banking_pb.SetDefaultLinkedAccountRequest(
        accountId: accountId,
        userId: userId,
      );

      final response = await _callOptionsHelper.executeWithTokenRotation(() async {
        final callOptions = await _callOptionsHelper.withAuth();
        return await _client.setDefaultLinkedAccount(
          request,
          options: callOptions.mergedWith(
            CallOptions(timeout: const Duration(seconds: 15)),
          ),
        );
      });

      if (!response.success) {
        throw GenericBankingException(
          code: response.errorCode,
          message: response.errorMessage,
        );
      }
    } on GrpcError catch (e) {
      throw _mapGrpcError(e, 'setDefaultLinkedAccount');
    }
  }

  /// Refresh balance for a linked account
  Future<double> refreshLinkedAccountBalance({
    required String accountId,
    required String userId,
  }) async {
    try {
      final request = banking_pb.RefreshLinkedAccountBalanceRequest(
        accountId: accountId,
        userId: userId,
      );

      final response = await _callOptionsHelper.executeWithTokenRotation(() async {
        final callOptions = await _callOptionsHelper.withAuth();
        return await _client.refreshLinkedAccountBalance(
          request,
          options: callOptions.mergedWith(
            CallOptions(timeout: const Duration(seconds: 30)),
          ),
        );
      });

      if (!response.success) {
        throw GenericBankingException(
          code: response.errorCode,
          message: response.errorMessage,
        );
      }

      return response.newBalance.toInt() / 100; // Convert from kobo to Naira
    } on GrpcError catch (e) {
      throw _mapGrpcError(e, 'refreshLinkedAccountBalance');
    }
  }

  // =====================================================
  // DEPOSITS (via gRPC)
  // =====================================================

  /// Initiate a deposit via direct debit
  /// Uses idempotency key to prevent duplicate transactions
  Future<Deposit> initiateDeposit({
    required String userId,
    required String linkedAccountId,
    required String destinationAccountId,
    required int amountInKobo,
    String? narration,
    String? idempotencyKey,
  }) async {
    return await RetryPolicy.critical.execute(
      () async {
        final request = banking_pb.InitiateDepositRequest(
          userId: userId,
          linkedAccountId: linkedAccountId,
          destinationAccountId: destinationAccountId,
          amount: Int64(amountInKobo),
          narration: narration ?? 'Deposit to LazerVault',
          idempotencyKey: idempotencyKey ?? _uuid.v4(),
        );

        try {
          final response = await _callOptionsHelper.executeWithTokenRotation(() async {
            final callOptions = await _callOptionsHelper.withAuth();
            return await _client.initiateDeposit(
              request,
              options: callOptions.mergedWith(
                CallOptions(timeout: const Duration(seconds: 30)),
              ),
            );
          });

          if (!response.success) {
            throw _mapDepositError(response);
          }

          return _mapDeposit(response.deposit);
        } on GrpcError catch (e) {
          throw _mapGrpcError(e, 'initiateDeposit');
        }
      },
      onRetry: (attempt, error) {
        print('RETRY: Deposit attempt $attempt due to: $error');
      },
      shouldRetry: (error) => _shouldRetryDeposit(error),
    );
  }

  /// Get deposit status
  Future<Deposit> getDepositStatus({
    required String depositId,
    required String userId,
  }) async {
    try {
      final request = banking_pb.GetDepositStatusRequest(
        depositId: depositId,
        userId: userId,
      );

      final callOptions = await _callOptionsHelper.withAuth();

      final response = await _client.getDepositStatus(
        request,
        options: callOptions.mergedWith(
          CallOptions(timeout: const Duration(seconds: 15)),
        ),
      );

      if (!response.success) {
        throw GenericBankingException(
          code: response.errorCode,
          message: response.errorMessage,
        );
      }

      return _mapDeposit(response.deposit);
    } on GrpcError catch (e) {
      throw _mapGrpcError(e, 'getDepositStatus');
    }
  }

  /// Get user's deposits
  Future<(List<Deposit>, int)> getUserDeposits({
    required String userId,
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      final request = banking_pb.GetUserDepositsRequest(
        userId: userId,
        limit: limit,
        offset: offset,
      );

      final callOptions = await _callOptionsHelper.withAuth();

      final response = await _client.getUserDeposits(
        request,
        options: callOptions.mergedWith(
          CallOptions(timeout: const Duration(seconds: 15)),
        ),
      );

      final deposits = response.deposits.map(_mapDeposit).toList();
      return (deposits, response.total);
    } on GrpcError catch (e) {
      throw _mapGrpcError(e, 'getUserDeposits');
    }
  }

  /// Cancel a pending deposit
  Future<void> cancelDeposit({
    required String depositId,
    required String userId,
  }) async {
    try {
      final request = banking_pb.CancelDepositRequest(
        depositId: depositId,
        userId: userId,
      );

      // No retry for cancel - might result in partial state
      final callOptions = await _callOptionsHelper.withAuth();

      final response = await _client.cancelDeposit(
        request,
        options: callOptions.mergedWith(
          CallOptions(timeout: const Duration(seconds: 15)),
        ),
      );

      if (!response.success) {
        throw GenericBankingException(
          code: response.errorCode,
          message: response.errorMessage,
        );
      }
    } on GrpcError catch (e) {
      throw _mapGrpcError(e, 'cancelDeposit');
    }
  }

  /// Calculate deposit fee
  Future<DepositFeeCalculation> calculateDepositFee({
    required int amountInKobo,
  }) async {
    try {
      final request = banking_pb.CalculateDepositFeeRequest(
        amount: Int64(amountInKobo),
      );

      final callOptions = await _callOptionsHelper.withAuth();

      final response = await _client.calculateDepositFee(
        request,
        options: callOptions.mergedWith(
          CallOptions(timeout: const Duration(seconds: 10)),
        ),
      );

      return DepositFeeCalculation(
        amount: response.amount.toInt().toDouble(),
        fee: response.fee.toInt().toDouble(),
        netAmount: response.netAmount.toInt().toDouble(),
      );
    } on GrpcError catch (e) {
      throw _mapGrpcError(e, 'calculateDepositFee');
    }
  }

  // =====================================================
  // HELPER METHODS
  // =====================================================

  /// Map proto LinkedBankAccount to domain entity
  LinkedBankAccount _mapLinkedAccount(banking_pb.LinkedBankAccount proto) {
    return LinkedBankAccount(
      id: proto.id,
      userId: proto.userId,
      provider: proto.provider,
      bankName: proto.bankName,
      bankCode: proto.bankCode,
      accountNumber: proto.accountNumber,
      accountName: proto.accountName,
      accountType: proto.accountType,
      currency: proto.currency,
      lastKnownBalance: proto.lastKnownBalance.toInt() / 100, // Convert from kobo
      balanceUpdatedAt: proto.hasBalanceUpdatedAt()
          ? proto.balanceUpdatedAt.toDateTime()
          : null,
      status: LinkedAccountStatus.fromString(proto.status),
      isDefault: proto.isDefault,
      isVerified: proto.isVerified,
      linkedAt: proto.hasLinkedAt() ? proto.linkedAt.toDateTime() : DateTime.now(),
    );
  }

  /// Map proto Deposit to domain entity
  Deposit _mapDeposit(banking_pb.Deposit proto) {
    return Deposit(
      id: proto.id,
      userId: proto.userId,
      linkedAccountId: proto.linkedAccountId,
      destinationAccountId: proto.destinationAccountId,
      sourceBankName: proto.sourceBankName,
      sourceAccountNumber: proto.sourceAccountNumber,
      amount: proto.amount.toInt() / 100, // Convert from kobo to Naira
      fee: proto.fee.toInt() / 100, // Convert from kobo to Naira
      currency: proto.currency,
      status: DepositStatus.fromString(proto.status),
      reference: proto.reference,
      narration: proto.narration.isNotEmpty ? proto.narration : null,
      failureCode: proto.failureCode.isNotEmpty ? proto.failureCode : null,
      failureReason: proto.failureReason.isNotEmpty ? proto.failureReason : null,
      createdAt: proto.hasCreatedAt() ? proto.createdAt.toDateTime() : DateTime.now(),
      completedAt: proto.hasCompletedAt() ? proto.completedAt.toDateTime() : null,
    );
  }

  /// Map deposit response error to specific exception
  BankingException _mapDepositError(banking_pb.DepositResponse response) {
    final code = response.errorCode;
    final message = response.errorMessage;

    switch (code) {
      case 'INSUFFICIENT_FUNDS':
        return InsufficientFundsException(message: message);
      case 'LIMIT_EXCEEDED':
        return LimitExceededException(message: message, limitType: 'transaction');
      case 'ACCOUNT_NOT_FOUND':
        return AccountNotFoundException(message: message);
      case 'NEEDS_MANDATE':
        return NeedsMandateException(
          message: message,
          mandateId: response.mandateId.isNotEmpty ? response.mandateId : null,
          authorizationUrl: response.authorizationUrl.isNotEmpty
              ? response.authorizationUrl
              : null,
        );
      case 'REAUTHORIZATION_REQUIRED':
        return GenericBankingException(
          code: code,
          message: 'Your bank connection has expired. Please re-authorize.',
        );
      default:
        return GenericBankingException(
          code: code,
          message: message.isNotEmpty ? message : 'Deposit failed. Please try again.',
        );
    }
  }

  /// Map gRPC error to banking exception
  BankingException _mapGrpcError(GrpcError error, String operation) {
    switch (error.code) {
      case StatusCode.unavailable:
        return ServiceUnavailableException(
          message: 'Banking service unavailable: ${error.message}',
        );
      case StatusCode.deadlineExceeded:
        return NetworkException(
          message: 'Request timeout: ${error.message}',
          isTimeout: true,
        );
      case StatusCode.unauthenticated:
        return UnauthorizedException(
          message: 'Authentication failed: ${error.message}',
        );
      case StatusCode.permissionDenied:
        return GenericBankingException(
          code: 'PERMISSION_DENIED',
          message: 'You do not have permission to perform this action.',
        );
      case StatusCode.invalidArgument:
        return GenericBankingException(
          code: 'INVALID_ARGUMENT',
          message: error.message ?? 'Invalid input. Please check your details.',
        );
      case StatusCode.notFound:
        return AccountNotFoundException(
          message: 'Not found: ${error.message}',
        );
      default:
        return GenericBankingException(
          code: 'GRPC_ERROR_${error.code}',
          message: '$operation failed: ${error.message}',
        );
    }
  }

  /// Determine if a deposit operation should be retried
  bool _shouldRetryDeposit(dynamic error) {
    if (error is GrpcError) {
      // Only retry on transient network errors
      return error.code == StatusCode.unavailable ||
          error.code == StatusCode.deadlineExceeded;
    }
    if (error is ServiceUnavailableException || error is NetworkException) {
      return true;
    }
    return false;
  }
}
