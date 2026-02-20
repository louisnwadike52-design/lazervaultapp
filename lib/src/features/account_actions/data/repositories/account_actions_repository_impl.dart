import 'package:dartz/dartz.dart';
import 'package:fixnum/fixnum.dart';
import 'package:grpc/grpc.dart' show CallOptions;
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:lazervault/src/features/account_actions/domain/entities/account_details_entity.dart';
import 'package:lazervault/src/features/account_actions/domain/entities/document_entity.dart';
import 'package:lazervault/src/features/account_actions/domain/repositories/i_account_actions_repository.dart';
import 'package:lazervault/src/generated/account.pbgrpc.dart' as account_pb;
import 'package:lazervault/src/generated/accounts.pbgrpc.dart' as accounts_pb;

/// gRPC implementation of AccountActionsRepository
/// Communicates with accounts-service via Core Gateway
class AccountActionsRepositoryImpl implements IAccountActionsRepository {
  final account_pb.AccountServiceClient _accountClient;
  final accounts_pb.AccountsServiceClient _accountsClient;
  final SecureStorageService _secureStorage;

  AccountActionsRepositoryImpl({
    required account_pb.AccountServiceClient accountClient,
    required accounts_pb.AccountsServiceClient accountsClient,
    required SecureStorageService secureStorage,
  })  : _accountClient = accountClient,
        _accountsClient = accountsClient,
        _secureStorage = secureStorage;

  @override
  Future<Either<Failure, AccountDetailsEntity>> getAccountDetails({
    required String accountId,
    String? accessToken,
  }) async {
    try {
      final token = accessToken ?? await _secureStorage.getAccessToken();

      final request = account_pb.GetAccountDetailsRequest(
        accountId: Int64(int.parse(accountId)),
      );

      final response = await _accountClient.getAccountDetails(
        request,
        options: _getCallOptions(token),
      );

      final accountDetails = _mapProtoToEntity(response.account, accountId);
      return Right(accountDetails);
    } catch (e) {
      return Left(Failure(
        message: 'Failed to fetch account details: ${e.toString()}',
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, AccountDetailsEntity>> updateAccountStatus({
    required String accountId,
    required AccountStatusAction action,
    String? reason,
    String? accessToken,
  }) async {
    try {
      final token = accessToken ?? await _secureStorage.getAccessToken();

      // First get current details
      final currentDetailsResult = await getAccountDetails(
        accountId: accountId,
        accessToken: token,
      );

      return currentDetailsResult.fold(
        (failure) => Left(failure),
        (currentDetails) async {
          try {
            // Use the correct RPC based on action
            switch (action) {
              case AccountStatusAction.freeze:
                final freezeRequest = accounts_pb.FreezeAccountRequest(
                  accountId: accountId,
                  reason: reason ?? 'User action via app',
                );
                await _accountsClient.freezeAccount(
                  freezeRequest,
                  options: _getCallOptions(token),
                );
                break;

              case AccountStatusAction.unfreeze:
                final unfreezeRequest = accounts_pb.UnfreezeAccountRequest(
                  accountId: accountId,
                );
                await _accountsClient.unfreezeAccount(
                  unfreezeRequest,
                  options: _getCallOptions(token),
                );
                break;

              case AccountStatusAction.temporarilyBlock:
              case AccountStatusAction.permanentlyBlock:
              case AccountStatusAction.reportStolen:
                // For these actions, we use freeze for now
                final freezeRequest = accounts_pb.FreezeAccountRequest(
                  accountId: accountId,
                  reason: reason ?? 'User action via app',
                );
                await _accountsClient.freezeAccount(
                  freezeRequest,
                  options: _getCallOptions(token),
                );
                break;
            }

            // Determine new status
            String newStatus;
            switch (action) {
              case AccountStatusAction.freeze:
              case AccountStatusAction.temporarilyBlock:
              case AccountStatusAction.permanentlyBlock:
              case AccountStatusAction.reportStolen:
                newStatus = 'frozen';
                break;
              case AccountStatusAction.unfreeze:
                newStatus = 'active';
                break;
            }

            // Return updated entity
            return Right(currentDetails.copyWith(status: newStatus));
          } catch (e) {
            return Left(Failure(
              message: 'Failed to update account status: ${e.toString()}',
              statusCode: 500,
            ));
          }
        },
      );
    } catch (e) {
      return Left(Failure(
        message: 'Failed to update account status: ${e.toString()}',
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, AccountDetailsEntity>> updateSecuritySettings({
    required String accountId,
    required bool enable3DSecure,
    required bool enableContactless,
    required bool enableOnlinePayments,
    required bool enableATMWithdrawals,
    required bool enableInternationalPayments,
    String? accessToken,
  }) async {
    try {
      final token = accessToken ?? await _secureStorage.getAccessToken();

      final settings = account_pb.SecuritySettings(
        enable3dSecure: enable3DSecure,
        enableContactless: enableContactless,
        enableOnlinePayments: enableOnlinePayments,
      );

      final request = account_pb.UpdateSecuritySettingsRequest(
        accountId: Int64(int.parse(accountId)),
        settings: settings,
      );

      await _accountClient.updateSecuritySettings(
        request,
        options: _getCallOptions(token),
      );

      // Get updated details
      return await getAccountDetails(accountId: accountId, accessToken: token);
    } catch (e) {
      return Left(Failure(
        message: 'Failed to update security settings: ${e.toString()}',
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, AccountDetailsEntity>> updateSpendingLimits({
    required String accountId,
    double? dailyLimit,
    double? monthlyLimit,
    double? singleTransactionLimit,
    String? accessToken,
  }) async {
    try {
      final token = accessToken ?? await _secureStorage.getAccessToken();

      // Get current details first
      final currentResult = await getAccountDetails(
        accountId: accountId,
        accessToken: token,
      );

      return currentResult.fold(
        (failure) => Left(failure),
        (current) async {
          // Build the request with only provided limits
          final request = accounts_pb.UpdateSpendingLimitsRequest(
            accountId: accountId,
            dailyLimit: dailyLimit,
            monthlyLimit: monthlyLimit,
            singleTransactionLimit: singleTransactionLimit,
          );

          final response = await _accountsClient.updateSpendingLimits(
            request,
            options: _getCallOptions(token),
          );

          // Map updated account back to entity
          return Right(current.copyWith(
            dailyLimit: response.account.hasDailyLimit()
                ? response.account.dailyLimit
                : (dailyLimit ?? current.dailyLimit),
            monthlyLimit: response.account.hasMonthlyLimit()
                ? response.account.monthlyLimit
                : (monthlyLimit ?? current.monthlyLimit),
            // singleTransactionLimit is not in proto response, use the value passed in
            singleTransactionLimit: singleTransactionLimit ?? current.singleTransactionLimit,
          ));
        },
      );
    } catch (e) {
      return Left(Failure(
        message: 'Failed to update spending limits: ${e.toString()}',
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, String>> revealPIN({
    required String accountId,
    required String transactionPin,
    String? accessToken,
  }) async {
    try {
      final token = accessToken ?? await _secureStorage.getAccessToken();

      final request = accounts_pb.RevealPINRequest(
        accountId: accountId,
        transactionPin: transactionPin,
      );

      final response = await _accountsClient.revealPIN(
        request,
        options: _getCallOptions(token),
      );

      return Right(response.pin);
    } catch (e) {
      return Left(Failure(
        message: 'Failed to reveal PIN: ${e.toString()}',
        statusCode: 403,
      ));
    }
  }

  @override
  Future<Either<Failure, CardDetailsEntity>> revealCardDetails({
    required String accountId,
    required String transactionPin,
    String? accessToken,
  }) async {
    try {
      final token = accessToken ?? await _secureStorage.getAccessToken();

      final request = accounts_pb.RevealCardDetailsRequest(
        accountId: accountId,
        transactionPin: transactionPin,
      );

      final response = await _accountsClient.revealCardDetails(
        request,
        options: _getCallOptions(token),
      );

      return Right(CardDetailsEntity(
        cardNumber: response.cardNumber,
        expiryDate: response.expiryDate,
        cvv: response.cvv,
        cardHolderName: response.cardHolderName,
      ));
    } catch (e) {
      return Left(Failure(
        message: 'Failed to reveal card details: ${e.toString()}',
        statusCode: 403,
      ));
    }
  }

  @override
  Future<Either<Failure, DocumentEntity>> downloadAccountStatement({
    required String accountId,
    required DateTime startDate,
    required DateTime endDate,
    DocumentFormat format = DocumentFormat.pdf,
    String? accessToken,
  }) async {
    try {
      final token = accessToken ?? await _secureStorage.getAccessToken();

      final request = accounts_pb.GenerateStatementRequest(
        accountId: accountId,
        startDate: Int64(startDate.millisecondsSinceEpoch ~/ 1000),
        endDate: Int64(endDate.millisecondsSinceEpoch ~/ 1000),
        format: format == DocumentFormat.pdf ? 'PDF' : 'CSV',
      );

      final response = await _accountsClient.generateStatement(
        request,
        options: _getCallOptions(token),
      );

      return Right(DocumentEntity(
        id: response.documentId,
        type: DocumentType.accountStatement,
        title: 'Account Statement',
        description: 'Statement from ${startDate.day}/${startDate.month}/${startDate.year} to ${endDate.day}/${endDate.month}/${endDate.year}',
        format: format,
        downloadUrl: response.downloadUrl,
        createdAt: DateTime.now(),
        validUntil: DateTime.fromMillisecondsSinceEpoch(response.validUntil.toInt() * 1000),
      ));
    } catch (e) {
      return Left(Failure(
        message: 'Failed to generate statement: ${e.toString()}',
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, DocumentEntity>> downloadAccountConfirmation({
    required String accountId,
    String? accessToken,
  }) async {
    try {
      final token = accessToken ?? await _secureStorage.getAccessToken();

      final request = accounts_pb.GenerateAccountConfirmationRequest(
        accountId: accountId,
      );

      final response = await _accountsClient.generateAccountConfirmation(
        request,
        options: _getCallOptions(token),
      );

      return Right(DocumentEntity(
        id: response.documentId,
        type: DocumentType.accountConfirmation,
        title: 'Account Confirmation Letter',
        description: 'Official confirmation of your account',
        format: DocumentFormat.pdf,
        downloadUrl: response.downloadUrl,
        createdAt: DateTime.now(),
        validUntil: DateTime.fromMillisecondsSinceEpoch(response.validUntil.toInt() * 1000),
      ));
    } catch (e) {
      return Left(Failure(
        message: 'Failed to generate confirmation: ${e.toString()}',
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, DocumentEntity>> requestProofOfFunds({
    required String accountId,
    String? accessToken,
  }) async {
    try {
      final token = accessToken ?? await _secureStorage.getAccessToken();

      final request = accounts_pb.GenerateProofOfFundsRequest(
        accountId: accountId,
      );

      final response = await _accountsClient.generateProofOfFunds(
        request,
        options: _getCallOptions(token),
      );

      return Right(DocumentEntity(
        id: response.documentId,
        type: DocumentType.proofOfFunds,
        title: 'Proof of Funds',
        description: 'Official proof of funds document',
        format: DocumentFormat.pdf,
        downloadUrl: response.downloadUrl,
        createdAt: DateTime.now(),
        validUntil: DateTime.fromMillisecondsSinceEpoch(response.validUntil.toInt() * 1000),
      ));
    } catch (e) {
      return Left(Failure(
        message: 'Failed to generate proof of funds: ${e.toString()}',
        statusCode: 500,
      ));
    }
  }

  /// Map proto response to AccountDetailsEntity
  AccountDetailsEntity _mapProtoToEntity(account_pb.AccountDetails proto, String accountId) {
    return AccountDetailsEntity(
      id: accountId,
      accountType: proto.accountType.isNotEmpty ? proto.accountType : 'Personal',
      currency: proto.currency.isNotEmpty ? proto.currency : 'NGN',
      balance: proto.balance.toDouble() / 100,
      status: proto.status.isNotEmpty ? proto.status : 'active',
      cardHolderName: proto.cardHolderName.isNotEmpty ? proto.cardHolderName : null,
      cardType: proto.cardType.isNotEmpty ? proto.cardType : null,
      expiryDate: proto.expiryDate.isNotEmpty ? proto.expiryDate : null,
      cardNumber: null, // Never expose full card number
      cvv: null, // Never expose CVV
      accountNumber: proto.accountNumber.isNotEmpty ? proto.accountNumber : null,
      iban: proto.iban.isNotEmpty ? proto.iban : null,
      bicSwift: proto.bicSwift.isNotEmpty ? proto.bicSwift : null,
      dailyLimit: proto.dailyLimit.toDouble() / 100,
      monthlyLimit: proto.monthlyLimit.toDouble() / 100,
      singleTransactionLimit: null, // Not in proto
      enable3DSecure: proto.enable3dSecure,
      enableContactless: proto.enableContactless,
      enableOnlinePayments: proto.enableOnlinePayments,
      enableATMWithdrawals: false, // Not in AccountDetails message
      enableInternationalPayments: false, // Not in AccountDetails message
      createdAt: proto.hasCreatedAt() ? proto.createdAt.toDateTime() : null,
      updatedAt: proto.hasUpdatedAt() ? proto.updatedAt.toDateTime() : null,
    );
  }

  /// Get call options with authorization
  CallOptions _getCallOptions(String? token) {
    // Options would normally come from GrpcCallOptionsHelper
    // For simplicity, returning empty options - token should be injected via interceptor
    return CallOptions();
  }
}
