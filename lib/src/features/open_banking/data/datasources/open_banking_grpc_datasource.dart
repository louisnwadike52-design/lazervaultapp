import 'package:fixnum/fixnum.dart';
import 'package:grpc/grpc.dart';
import 'package:uuid/uuid.dart';

import 'package:lazervault/core/network/retry_policy.dart';
import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/src/generated/banking.pbgrpc.dart' as banking;
import 'package:lazervault/src/generated/banking.pb.dart' as banking_pb;
import '../../domain/entities/linked_bank_account.dart';
import '../../domain/entities/deposit.dart';
import '../../domain/entities/credit_score.dart';
import '../../domain/entities/sync_results.dart';
import '../../domain/entities/external_bank_transaction.dart';
import '../errors/banking_errors.dart';
import 'package:lazervault/src/features/move_money/domain/entities/mandate_entity.dart';

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
  /// Set useRecurringAccess=false for DirectPay (one-time), true for Mandate (recurring)
  Future<Deposit> initiateDeposit({
    required String userId,
    required String linkedAccountId,
    required String destinationAccountId,
    required int amountInKobo,
    String? narration,
    String? idempotencyKey,
    bool useRecurringAccess = false, // false = DirectPay (one-time), true = Mandate
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
          useRecurringAccess: useRecurringAccess,
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

          // Map the deposit and include DirectPay authorization fields from response
          final deposit = _mapDeposit(response.deposit);

          // If DirectPay authorization is required, add the auth fields
          if (response.requiresAuthorization) {
            return deposit.copyWith(
              requiresAuthorization: true,
              paymentUrl: response.paymentUrl.isNotEmpty ? response.paymentUrl : null,
              paymentId: response.paymentId.isNotEmpty ? response.paymentId : null,
            );
          }

          return deposit;
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

  // =====================================================
  // CREDIT SCORE
  // =====================================================

  /// Get credit score for a user
  Future<CreditScoreEntity> getCreditScore({required String userId}) async {
    try {
      final request = banking_pb.GetCreditScoreRequest(userId: userId);
      final callOptions = await _callOptionsHelper.withAuth();

      final response = await _client.getCreditScore(
        request,
        options: callOptions.mergedWith(
          CallOptions(timeout: const Duration(seconds: 30)),
        ),
      );

      if (!response.success) {
        throw GenericBankingException(
          code: response.errorCode,
          message: response.errorMessage,
        );
      }

      return _mapCreditScore(response.creditScore);
    } on GrpcError catch (e) {
      throw _mapGrpcError(e, 'getCreditScore');
    }
  }

  /// Get credit score history
  Future<CreditScoreHistoryEntity> getCreditScoreHistory({
    required String userId,
    int months = 12,
  }) async {
    try {
      final request = banking_pb.GetCreditScoreHistoryRequest(
        userId: userId,
        months: months,
      );
      final callOptions = await _callOptionsHelper.withAuth();

      final response = await _client.getCreditScoreHistory(
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

      return CreditScoreHistoryEntity(
        history: response.history
            .map((p) => CreditScoreHistoryPointEntity(
                  score: p.score,
                  rating: p.rating,
                  date: p.date.toDateTime(),
                ))
            .toList(),
        scoreChange: response.scoreChange,
      );
    } on GrpcError catch (e) {
      throw _mapGrpcError(e, 'getCreditScoreHistory');
    }
  }

  /// Refresh credit score
  Future<CreditScoreEntity> refreshCreditScore({
    required String userId,
    required String linkedAccountId,
  }) async {
    try {
      final request = banking_pb.RefreshCreditScoreRequest(
        userId: userId,
        linkedAccountId: linkedAccountId,
      );

      final response = await _callOptionsHelper.executeWithTokenRotation(() async {
        final callOptions = await _callOptionsHelper.withAuth();
        return await _client.refreshCreditScore(
          request,
          options: callOptions.mergedWith(
            CallOptions(timeout: const Duration(seconds: 60)),
          ),
        );
      });

      if (!response.success) {
        throw GenericBankingException(
          code: response.errorCode,
          message: response.errorMessage,
        );
      }

      return _mapCreditScore(response.creditScore);
    } on GrpcError catch (e) {
      throw _mapGrpcError(e, 'refreshCreditScore');
    }
  }

  /// Get multi-source credit scores (LazerVault, External, Combined)
  Future<MultiSourceCreditScores> getMultiSourceCreditScores({
    required String userId,
  }) async {
    try {
      final request = banking_pb.GetMultiSourceCreditScoresRequest(userId: userId);
      final callOptions = await _callOptionsHelper.withAuth();

      final response = await _client.getMultiSourceCreditScores(
        request,
        options: callOptions.mergedWith(
          CallOptions(timeout: const Duration(seconds: 45)),
        ),
      );

      if (!response.success) {
        throw GenericBankingException(
          code: response.errorCode,
          message: response.errorMessage,
        );
      }

      return MultiSourceCreditScores(
        lazervaultScore: _mapCreditScore(response.lazervaultScore),
        externalScore: response.hasExternalScore()
            ? _mapCreditScore(response.externalScore)
            : null,
        combinedScore: response.hasCombinedScore()
            ? _mapCreditScore(response.combinedScore)
            : null,
        hasLinkedBanks: response.hasLinkedBanks,
      );
    } on GrpcError catch (e) {
      throw _mapGrpcError(e, 'getMultiSourceCreditScores');
    }
  }

  CreditScoreEntity _mapCreditScore(banking_pb.CreditScore cs) {
    // Map proto source enum to string
    String source;
    switch (cs.source) {
      case banking_pb.CreditScoreSource.CREDIT_SCORE_SOURCE_LAZERVAULT:
        source = 'lazervault';
        break;
      case banking_pb.CreditScoreSource.CREDIT_SCORE_SOURCE_EXTERNAL:
        source = 'external';
        break;
      case banking_pb.CreditScoreSource.CREDIT_SCORE_SOURCE_COMBINED:
        source = 'combined';
        break;
      default:
        source = 'external';
    }

    return CreditScoreEntity(
      id: cs.id,
      score: cs.score,
      rating: cs.rating,
      bankName: cs.bankName,
      linkedAccountId: cs.linkedAccountId,
      paymentHistoryScore: cs.paymentHistoryScore,
      incomeStabilityScore: cs.incomeStabilityScore,
      spendingDisciplineScore: cs.spendingDisciplineScore,
      accountAgeScore: cs.accountAgeScore,
      balanceConsistencyScore: cs.balanceConsistencyScore,
      transactionsAnalyzed: cs.transactionsAnalyzed,
      monthsOfData: cs.monthsOfData,
      calculatedAt: cs.calculatedAt.toDateTime(),
      nextRefreshAt: cs.hasNextRefreshAt() ? cs.nextRefreshAt.toDateTime() : null,
      tips: cs.tips
          .map((t) => CreditScoreTipEntity(
                title: t.title,
                description: t.description,
                category: t.category,
                potentialImpact: t.potentialImpact,
              ))
          .toList(),
      source: source,
      sourceLabel: cs.sourceLabel,
      confidence: cs.confidence,
    );
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

  // =====================================================
  // MANDATES (Direct Debit Variable Recurring Payments)
  // =====================================================

  /// Create a direct debit mandate for a linked account.
  ///
  /// Optional [userEmail], [userName], [userPhone] are forwarded as gRPC
  /// metadata so the backend can auto-create a Mono customer if needed.
  Future<({MandateEntity mandate, bool needsAuthorization, String? authorizationUrl})>
      createMandate({
    required String userId,
    required String linkedAccountId,
    String mandateType = 'gsm',
    int amountLimit = 0,
    int debitLimit = 0,
    String? description,
    String? userEmail,
    String? userName,
    String? userPhone,
  }) async {
    try {
      final request = banking_pb.CreateMandateRequest(
        userId: userId,
        linkedAccountId: linkedAccountId,
        mandateType: mandateType,
        amountLimit: Int64(amountLimit),
        debitLimit: debitLimit,
        description: description ?? 'LazerVault auto-debit mandate',
      );

      // Build extra metadata for Mono customer auto-creation
      final extraMeta = <String, String>{};
      if (userEmail != null && userEmail.isNotEmpty) {
        extraMeta['x-user-email'] = userEmail;
      }
      if (userName != null && userName.isNotEmpty) {
        extraMeta['x-user-name'] = userName;
      }
      if (userPhone != null && userPhone.isNotEmpty) {
        extraMeta['x-user-phone'] = userPhone;
      }

      final response = await _callOptionsHelper.executeWithTokenRotation(() async {
        final callOptions = await _callOptionsHelper.withAuth();
        return await _client.createMandate(
          request,
          options: callOptions.mergedWith(
            CallOptions(
              timeout: const Duration(seconds: 30),
              metadata: extraMeta,
            ),
          ),
        );
      });

      if (!response.success) {
        throw GenericBankingException(
          code: response.errorCode,
          message: response.errorMessage,
        );
      }

      return (
        mandate: _mapMandate(response.mandate),
        needsAuthorization: response.needsAuthorization,
        authorizationUrl:
            response.authorizationUrl.isNotEmpty ? response.authorizationUrl : null,
      );
    } on GrpcError catch (e) {
      throw _mapGrpcError(e, 'createMandate');
    }
  }

  /// Get all mandates for a user
  Future<List<MandateEntity>> getUserMandates({
    required String userId,
    bool activeOnly = true,
    int limit = 50,
    int offset = 0,
  }) async {
    try {
      final request = banking_pb.GetUserMandatesRequest(
        userId: userId,
        activeOnly: activeOnly,
        limit: limit,
        offset: offset,
      );

      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _client.getUserMandates(
        request,
        options: callOptions.mergedWith(
          CallOptions(timeout: const Duration(seconds: 15)),
        ),
      );

      return response.mandates.map(_mapMandate).toList();
    } on GrpcError catch (e) {
      throw _mapGrpcError(e, 'getUserMandates');
    }
  }

  /// Get a specific mandate
  Future<MandateEntity> getMandate({
    required String mandateId,
    required String userId,
  }) async {
    try {
      final request = banking_pb.GetMandateRequest(
        mandateId: mandateId,
        userId: userId,
      );

      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _client.getMandate(
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

      return _mapMandate(response.mandate);
    } on GrpcError catch (e) {
      throw _mapGrpcError(e, 'getMandate');
    }
  }

  /// Pause a mandate
  Future<MandateEntity> pauseMandate({
    required String mandateId,
    required String userId,
    String? reason,
  }) async {
    try {
      final request = banking_pb.PauseMandateRequest(
        mandateId: mandateId,
        userId: userId,
        reason: reason ?? '',
      );

      final response = await _callOptionsHelper.executeWithTokenRotation(() async {
        final callOptions = await _callOptionsHelper.withAuth();
        return await _client.pauseMandate(
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

      return _mapMandate(response.mandate);
    } on GrpcError catch (e) {
      throw _mapGrpcError(e, 'pauseMandate');
    }
  }

  /// Reinstate a paused mandate
  Future<MandateEntity> reinstateMandate({
    required String mandateId,
    required String userId,
  }) async {
    try {
      final request = banking_pb.ReinstateMandateRequest(
        mandateId: mandateId,
        userId: userId,
      );

      final response = await _callOptionsHelper.executeWithTokenRotation(() async {
        final callOptions = await _callOptionsHelper.withAuth();
        return await _client.reinstateMandate(
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

      return _mapMandate(response.mandate);
    } on GrpcError catch (e) {
      throw _mapGrpcError(e, 'reinstateMandate');
    }
  }

  /// Cancel a mandate
  Future<void> cancelMandate({
    required String mandateId,
    required String userId,
    String? reason,
  }) async {
    try {
      final request = banking_pb.CancelMandateRequest(
        mandateId: mandateId,
        userId: userId,
        reason: reason ?? '',
      );

      final response = await _callOptionsHelper.executeWithTokenRotation(() async {
        final callOptions = await _callOptionsHelper.withAuth();
        return await _client.cancelMandate(
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
      throw _mapGrpcError(e, 'cancelMandate');
    }
  }

  /// Map proto DirectDebitMandate to domain entity
  MandateEntity _mapMandate(banking_pb.DirectDebitMandate proto) {
    return MandateEntity(
      id: proto.id,
      monoMandateId: proto.monoMandateId,
      userId: proto.userId,
      linkedAccountId: proto.linkedAccountId,
      monoCustomerId: proto.monoCustomerId,
      bankName: proto.bankName,
      bankCode: proto.bankCode,
      accountNumber: proto.accountNumber,
      accountName: proto.accountName,
      mandateType: mandateTypeFromString(proto.mandateType),
      status: mandateStatusFromString(proto.status),
      amountLimit: proto.amountLimit.toInt(),
      debitLimit: proto.debitLimit,
      debitCount: proto.debitCount,
      totalDebited: proto.totalDebited.toInt(),
      remainingLimit: proto.remainingLimit.toInt(),
      canDebit: proto.canDebit,
      isExpired: proto.isExpired,
      startDate: proto.hasStartDate() ? proto.startDate.toDateTime() : DateTime.now(),
      endDate: proto.hasEndDate() ? proto.endDate.toDateTime() : DateTime.now(),
      createdAt: proto.hasCreatedAt() ? proto.createdAt.toDateTime() : DateTime.now(),
      authorizedAt: proto.hasAuthorizedAt() ? proto.authorizedAt.toDateTime() : null,
      readyAt: proto.hasReadyAt() ? proto.readyAt.toDateTime() : null,
      lastDebitAt: proto.hasLastDebitAt() ? proto.lastDebitAt.toDateTime() : null,
      cancelledAt: proto.hasCancelledAt() ? proto.cancelledAt.toDateTime() : null,
      reference: proto.reference,
      description: proto.description.isNotEmpty ? proto.description : null,
    );
  }

  // =====================================================
  // EXTERNAL TRANSACTION SYNC
  // =====================================================

  /// Sync transactions for all linked accounts
  Future<SyncAllAccountsResult> syncAllAccountTransactions({
    required String userId,
    String syncType = 'incremental',
  }) async {
    try {
      final request = banking_pb.SyncAllAccountTransactionsRequest(
        userId: userId,
        syncType: syncType,
      );
      final callOptions = await _callOptionsHelper.withAuth();

      final response = await _client.syncAllAccountTransactions(
        request,
        options: callOptions.mergedWith(
          CallOptions(timeout: const Duration(seconds: 60)),
        ),
      );

      final accountResults = response.accounts.map((a) => AccountSyncResult(
            accountId: a.accountId,
            bankName: a.bankName,
            transactionsSynced: a.transactionsSynced,
            success: a.success,
            error: a.error.isNotEmpty ? a.error : null,
          )).toList();

      return SyncAllAccountsResult(
        success: response.success,
        totalAccountsSynced: response.totalAccountsSynced,
        totalTransactionsSynced: response.totalTransactionsSynced,
        accounts: accountResults,
      );
    } on GrpcError catch (e) {
      throw _mapGrpcError(e, 'syncAllAccountTransactions');
    }
  }

  /// Sync transactions for a specific account
  Future<SyncTransactionsResult> syncAccountTransactions({
    required String accountId,
    required String userId,
    String syncType = 'incremental',
  }) async {
    try {
      final request = banking_pb.SyncExternalTransactionsRequest(
        accountId: accountId,
        syncType: syncType,
      );
      final callOptions = await _callOptionsHelper.withAuth();

      final response = await _client.syncExternalTransactions(
        request,
        options: callOptions.mergedWith(
          CallOptions(timeout: const Duration(seconds: 60)),
        ),
      );

      return SyncTransactionsResult(
        success: response.success,
        transactionsSynced: response.transactionsSynced,
        transactionsSkipped: response.transactionsSkipped,
        syncId: response.syncId.isNotEmpty ? response.syncId : null,
      );
    } on GrpcError catch (e) {
      throw _mapGrpcError(e, 'syncAccountTransactions');
    }
  }

  /// Get account with its external transactions
  Future<AccountWithTransactionsResult> getAccountWithTransactions({
    required String accountId,
    int limit = 50,
    int offset = 0,
  }) async {
    try {
      final request = banking_pb.GetAccountWithTransactionsRequest(
        accountId: accountId,
      );
      final callOptions = await _callOptionsHelper.withAuth();

      final response = await _client.getAccountWithTransactions(
        request,
        options: callOptions.mergedWith(
          CallOptions(timeout: const Duration(seconds: 15)),
        ),
      );

      final transactions = response.transactions.map((t) => ExternalBankTransaction(
            id: t.id,
            userId: t.userId,
            linkedBankAccountId: t.linkedBankAccountId,
            externalTransactionId: t.externalTransactionId,
            externalAccountId: t.externalAccountId,
            amount: t.amount.toInt(),
            currency: t.currency,
            transactionType: t.transactionType,
            category: t.category.isNotEmpty ? t.category : null,
            description: t.description,
            bankName: t.bankName,
            accountName: t.accountName,
            accountNumberMasked: t.accountNumberMasked,
            transactionDate: t.hasTransactionDate() ? t.transactionDate.toDateTime() : null,
            valueDate: t.hasValueDate() ? t.valueDate.toDateTime() : null,
            clearedAt: t.hasClearedAt() ? t.clearedAt.toDateTime() : null,
            createdAt: t.hasCreatedAt() ? t.createdAt.toDateTime() : null,
            syncStatus: t.syncStatus,
            lastSyncAt: t.hasLastSyncAt() ? t.lastSyncAt.toDateTime() : null,
          )).toList();

      return AccountWithTransactionsResult(
        account: _mapLinkedAccount(response.account),
        transactions: transactions,
        totalTransactions: response.totalTransactions.toInt(),
        lastSyncAt: response.hasLastSyncAt() ? response.lastSyncAt.toDateTime() : null,
      );
    } on GrpcError catch (e) {
      throw _mapGrpcError(e, 'getAccountWithTransactions');
    }
  }

  /// Refresh balance and latest transactions for an account
  Future<RefreshAccountResult> refreshAccountTransactions({
    required String accountId,
    required String userId,
  }) async {
    try {
      final request = banking_pb.RefreshAccountTransactionsRequest(
        accountId: accountId,
      );
      final callOptions = await _callOptionsHelper.withAuth();

      final response = await _callOptionsHelper.executeWithTokenRotation(() async {
        return await _client.refreshAccountTransactions(
          request,
          options: callOptions.mergedWith(
            CallOptions(timeout: const Duration(seconds: 45)),
          ),
        );
      });

      return RefreshAccountResult(
        success: response.success,
        transactionsSynced: response.transactionsSynced,
        newBalance: response.newBalance.toInt() / 100, // Convert from kobo
        syncId: response.syncId.isNotEmpty ? response.syncId : null,
      );
    } on GrpcError catch (e) {
      throw _mapGrpcError(e, 'refreshAccountTransactions');
    }
  }
}
