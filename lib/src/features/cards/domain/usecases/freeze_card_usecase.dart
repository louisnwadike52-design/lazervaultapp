import 'package:dartz/dartz.dart';
import 'package:lazervault/src/core/errors/failures.dart';
import 'package:lazervault/src/features/cards/domain/entities/card_entity.dart';
import 'package:lazervault/src/features/cards/domain/repositories/i_card_repository.dart';

class FreezeCardUseCase {
  final ICardRepository repository;

  FreezeCardUseCase(this.repository);

  Future<Either<Failure, Card>> call({
    required String cardUuid,
    String? reason,
  }) async {
    return await repository.freezeCard(
      cardUuid: cardUuid,
      reason: reason,
    );
  }
}
