import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/src/features/card_settings/domain/entities/account_details_entity.dart';
import 'package:lazervault/src/features/card_settings/domain/repositories/i_card_settings_repository.dart';

class UpdateSecuritySettingsUseCase {
  final ICardSettingsRepository repository;

  UpdateSecuritySettingsUseCase(this.repository);

  Future<Either<Failure, AccountDetailsEntity>> call({
    required String accountId,
    required bool enable3dSecure,
    required bool enableContactless,
    required bool enableOnlinePayments,
    String? accessToken,
  }) async {
    return await repository.updateSecuritySettings(
      accountId: accountId,
      enable3dSecure: enable3dSecure,
      enableContactless: enableContactless,
      enableOnlinePayments: enableOnlinePayments,
      accessToken: accessToken,
    );
  }
}
