import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/src/features/recipients/domain/repositories/i_recipient_repository.dart';
import 'package:lazervault/src/features/recipients/data/models/recipient_model.dart';

class GetRecipientsUseCase {
  final IRecipientRepository _repository;

  GetRecipientsUseCase(this._repository);

  Future<Either<Failure, List<RecipientModel>>> call({required String accessToken}) async {
    return await _repository.getRecipients(accessToken: accessToken);
  }
} 