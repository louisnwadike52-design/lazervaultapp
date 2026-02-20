import 'package:dartz/dartz.dart';
import 'package:lazervault/src/core/errors/failures.dart';
import 'package:lazervault/src/features/cards/domain/entities/card_entity.dart';
import 'package:lazervault/src/features/cards/domain/repositories/i_card_repository.dart';

class FundCardUseCase {
  final ICardRepository repository;

  FundCardUseCase(this.repository);

  Future<Either<Failure, Card>> call({
    required String cardUuid,
    required double amount,
  }) async {
    return await repository.fundCard(
      cardUuid: cardUuid,
      amount: amount,
    );
  }
}
