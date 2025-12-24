import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/src/features/card_settings/domain/entities/account_details_entity.dart';
import 'package:lazervault/src/features/card_settings/domain/repositories/i_card_settings_repository.dart';

class UpdateAccountStatusUseCase {
  final ICardSettingsRepository repository;

  UpdateAccountStatusUseCase(this.repository);

  Future<Either<Failure, AccountDetailsEntity>> call({
    required String accountId,
    required String status,
    required String reason,
    String? accessToken,
  }) async {
    return await repository.updateAccountStatus(
      accountId: accountId,
      status: status,
      reason: reason,
      accessToken: accessToken,
    );
  }
}
