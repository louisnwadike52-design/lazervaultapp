import 'package:dartz/dartz.dart';
import 'package:lazervault/src/core/errors/failures.dart';
import 'package:lazervault/src/features/cards/domain/entities/card_entity.dart';
import 'package:lazervault/src/features/cards/domain/repositories/i_card_repository.dart';

class SetDefaultCardUseCase {
  final ICardRepository repository;

  SetDefaultCardUseCase(this.repository);

  Future<Either<Failure, Card>> call({
    required String cardUuid,
  }) async {
    return await repository.setDefaultCard(cardUuid: cardUuid);
  }
}
