import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/src/features/recipients/data/models/recipient_model.dart';
import 'package:lazervault/src/features/recipients/domain/repositories/i_recipient_repository.dart';

class AddRecipientUseCase {
  final IRecipientRepository _repository;

  AddRecipientUseCase(this._repository);

  Future<Either<Failure, RecipientModel>> call(
      {required RecipientModel recipient, required String accessToken}) async {
    return await _repository.addRecipient(recipient: recipient, accessToken: accessToken);
  }
} 