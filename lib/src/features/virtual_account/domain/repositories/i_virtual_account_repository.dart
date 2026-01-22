import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';

/// Interface for virtual account repository
/// Handles creation of real virtual NUBAN accounts via Flutterwave/VFD providers
abstract class IVirtualAccountRepository {
  /// Create a virtual account for the user
  ///
  /// Parameters:
  /// - [accountName]: Account holder name
  /// - [accountType]: Type of account (personal, savings, etc.)
  /// - [currency]: Currency code (e.g., "NGN")
  /// - [locale]: BCP 47 locale (e.g., "en-NG")
  /// - [email]: User's email address
  /// - [firstName]: User's first name
  /// - [lastName]: User's last name
  /// - [phoneNumber]: User's phone number
  /// - [bvn]: Bank Verification Number (required for Nigeria)
  /// - [isPrimary]: Whether this is the primary account
  Future<Either<Failure, VirtualAccountEntity>> createVirtualAccount({
    required String accountName,
    required String accountType,
    required String currency,
    required String locale,
    required String email,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String bvn,
    bool isPrimary = false,
  });
}

/// Entity representing a created virtual account
class VirtualAccountEntity {
  final String accountId;
  final String accountNumber;
  final String accountName;
  final String bankCode;
  final String bankName;
  final String provider; // "flutterwave" or "vfd"
  final String providerRef;
  final String currency;
  final String message;

  VirtualAccountEntity({
    required this.accountId,
    required this.accountNumber,
    required this.accountName,
    required this.bankCode,
    required this.bankName,
    required this.provider,
    required this.providerRef,
    required this.currency,
    required this.message,
  });

  @override
  String toString() {
    return 'VirtualAccountEntity(accountNumber: $accountNumber, bankName: $bankName, provider: $provider)';
  }
}
