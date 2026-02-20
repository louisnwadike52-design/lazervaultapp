import 'package:dartz/dartz.dart';
import 'package:lazervault/src/core/errors/failures.dart';
import 'package:lazervault/src/features/cards/domain/repositories/i_card_repository.dart';

class SetCardPINUseCase {
  final ICardRepository repository;

  SetCardPINUseCase(this.repository);

  Future<Either<Failure, void>> call({
    required String cardUuid,
    required String pin,
  }) async {
    return await repository.setCardPIN(
      cardUuid: cardUuid,
      pin: pin,
    );
  }
}
