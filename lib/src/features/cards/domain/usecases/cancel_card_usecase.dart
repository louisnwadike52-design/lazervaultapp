import 'package:dartz/dartz.dart';
import 'package:lazervault/src/core/errors/failures.dart';
import 'package:lazervault/src/features/cards/domain/repositories/i_card_repository.dart';

class CancelCardUseCase {
  final ICardRepository repository;

  CancelCardUseCase(this.repository);

  Future<Either<Failure, void>> call({
    required String cardUuid,
    String? reason,
  }) async {
    return await repository.cancelCard(
      cardUuid: cardUuid,
      reason: reason,
    );
  }
}
