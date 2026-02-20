import 'package:dartz/dartz.dart';
import 'package:lazervault/src/core/errors/failures.dart';
import 'package:lazervault/src/features/cards/domain/entities/card_entity.dart';
import 'package:lazervault/src/features/cards/domain/repositories/i_card_repository.dart';

class GetCardDetailsUseCase {
  final ICardRepository repository;

  GetCardDetailsUseCase(this.repository);

  Future<Either<Failure, Card>> call({
    required String cardUuid,
    bool includeFullDetails = false,
  }) async {
    return await repository.getCardDetails(
      cardUuid: cardUuid,
      includeFullDetails: includeFullDetails,
    );
  }
}
