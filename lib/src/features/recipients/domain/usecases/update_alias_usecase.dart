import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/src/features/recipients/data/models/recipient_model.dart';
import 'package:lazervault/src/features/recipients/domain/repositories/i_recipient_repository.dart';

class UpdateAliasUseCase {
  final IRecipientRepository _repository;

  UpdateAliasUseCase(this._repository);

  Future<Either<Failure, RecipientModel>> call(
      {required String recipientId, required String? alias, required String accessToken}) async {
    return await _repository.updateAlias(recipientId: recipientId, alias: alias, accessToken: accessToken);
  }
}
