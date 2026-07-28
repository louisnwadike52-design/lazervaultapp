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

  /// Read current spending usage (limits + today's/this month's spend).
  Future<Either<Failure, SpendingUsageEntity>> getSpendingUsage({
    required String accountId,
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

/// Current spending usage for an account (limits + spend so far).
class SpendingUsageEntity {
  final String currency;
  final double dailyLimit; // 0 = no limit
  final double monthlyLimit; // 0 = no limit
  final double singleTransactionLimit; // 0 = no limit
  final double dailySpent;
  final double monthlySpent;
  final double remainingDaily; // -1 when no limit
  final double remainingMonthly; // -1 when no limit

  const SpendingUsageEntity({
    required this.currency,
    required this.dailyLimit,
    required this.monthlyLimit,
    required this.singleTransactionLimit,
    required this.dailySpent,
    required this.monthlySpent,
    required this.remainingDaily,
    required this.remainingMonthly,
  });
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
