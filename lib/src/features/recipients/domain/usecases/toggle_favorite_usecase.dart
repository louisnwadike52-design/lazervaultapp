import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/src/features/recipients/domain/repositories/i_recipient_repository.dart';

class ToggleFavoriteUseCase {
  final IRecipientRepository _repository;

  ToggleFavoriteUseCase(this._repository);

  Future<Either<Failure, void>> call(
      {required String recipientId, required String accessToken}) async {
    return await _repository.toggleFavorite(recipientId: recipientId, accessToken: accessToken);
  }
} 