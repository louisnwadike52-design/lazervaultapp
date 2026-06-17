import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/src/features/card_settings/domain/entities/account_details_entity.dart';
import 'package:lazervault/src/features/card_settings/domain/repositories/i_card_settings_repository.dart';

class GetAccountDetailsUseCase {
  final ICardSettingsRepository repository;

  GetAccountDetailsUseCase(this.repository);

  Future<Either<Failure, AccountDetailsEntity>> call({
    required String accountId,
    String? accessToken,
  }) async {
    return await repository.getAccountDetails(
      accountId: accountId,
      accessToken: accessToken,
    );
  }
}
