import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import '../entities/account_details_entity.dart';

abstract class ICardSettingsRepository {
  /// Get detailed account information for a specific account
  Future<Either<Failure, AccountDetailsEntity>> getAccountDetails({
    required String accountId,
    String? accessToken,
  });

  /// Update security settings for a specific account/card
  Future<Either<Failure, AccountDetailsEntity>> updateSecuritySettings({
    required String accountId,
    required bool enable3dSecure,
    required bool enableContactless,
    required bool enableOnlinePayments,
    String? accessToken,
  });

  /// Update account status (active/frozen)
  Future<Either<Failure, AccountDetailsEntity>> updateAccountStatus({
    required String accountId,
    required String status,
    required String reason,
    String? accessToken,
  });
}
