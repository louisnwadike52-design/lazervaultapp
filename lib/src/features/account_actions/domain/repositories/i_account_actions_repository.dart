import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import '../entities/account_details_entity.dart';
import '../entities/document_entity.dart';

/// Repository interface for account actions (card settings, security, documents)
abstract class IAccountActionsRepository {
  /// Get detailed account information including card details
  Future<Either<Failure, AccountDetailsEntity>> getAccountDetails({
    required String accountId,
    String? accessToken,
  });

  /// Freeze/unfreeze account
  Future<Either<Failure, AccountDetailsEntity>> updateAccountStatus({
    required String accountId,
    required AccountStatusAction action,
    String? reason,
    String? accessToken,
  });

  /// Update security settings (toggles)
  Future<Either<Failure, AccountDetailsEntity>> updateSecuritySettings({
    required String accountId,
    required bool enable3DSecure,
    required bool enableContactless,
    required bool enableOnlinePayments,
    required bool enableATMWithdrawals,
    required bool enableInternationalPayments,
    String? accessToken,
  });

  /// Update spending limits
  Future<Either<Failure, AccountDetailsEntity>> updateSpendingLimits({
    required String accountId,
    double? dailyLimit,
    double? monthlyLimit,
    double? singleTransactionLimit,
    String? accessToken,
  });

  /// Reveal card PIN (with authentication)
  Future<Either<Failure, String>> revealPIN({
    required String accountId,
    required String transactionPin, // User's PIN to authorize
    String? accessToken,
  });

  /// Reveal full card details (number, expiry, cvv) - with authentication
  Future<Either<Failure, CardDetailsEntity>> revealCardDetails({
    required String accountId,
    required String transactionPin, // User's PIN to authorize
    String? accessToken,
  });

  /// Download account statement
  Future<Either<Failure, DocumentEntity>> downloadAccountStatement({
    required String accountId,
    required DateTime startDate,
    required DateTime endDate,
    DocumentFormat format = DocumentFormat.pdf,
    String? accessToken,
  });

  /// Download account confirmation letter
  Future<Either<Failure, DocumentEntity>> downloadAccountConfirmation({
    required String accountId,
    String? accessToken,
  });

  /// Request proof of funds document
  Future<Either<Failure, DocumentEntity>> requestProofOfFunds({
    required String accountId,
    String? accessToken,
  });
}

/// Account status actions
enum AccountStatusAction {
  freeze,
  unfreeze,
  temporarilyBlock,
  permanentlyBlock,
  reportStolen,
}

/// Card details revealed after authentication
class CardDetailsEntity {
  final String cardNumber;
  final String expiryDate;
  final String cvv;
  final String cardHolderName;

  const CardDetailsEntity({
    required this.cardNumber,
    required this.expiryDate,
    required this.cvv,
    required this.cardHolderName,
  });
}
