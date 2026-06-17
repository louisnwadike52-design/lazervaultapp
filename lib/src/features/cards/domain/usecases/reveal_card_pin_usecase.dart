import 'package:dartz/dartz.dart';
import 'package:lazervault/src/core/errors/failures.dart';
import 'package:lazervault/src/features/cards/domain/repositories/i_card_repository.dart';

class RevealCardPINUseCase {
  final ICardRepository repository;

  RevealCardPINUseCase(this.repository);

  Future<Either<Failure, String>> call({
    required String cardUuid,
  }) async {
    return await repository.revealCardPIN(cardUuid: cardUuid);
  }
}
