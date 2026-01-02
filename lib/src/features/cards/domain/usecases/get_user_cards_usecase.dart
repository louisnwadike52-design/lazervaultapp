import 'package:dartz/dartz.dart';
import 'package:lazervault/src/core/errors/failures.dart';
import 'package:lazervault/src/features/cards/domain/entities/card_entity.dart';
import 'package:lazervault/src/features/cards/domain/repositories/i_card_repository.dart';

/// Use case for getting user's cards
class GetUserCardsUseCase {
  final ICardRepository repository;

  GetUserCardsUseCase(this.repository);

  /// Execute the use case
  Future<Either<Failure, List<Card>>> call({
    CardType? typeFilter,
    CardStatus? statusFilter,
  }) async {
    return await repository.getUserCards(
      typeFilter: typeFilter,
      statusFilter: statusFilter,
    );
  }
}
