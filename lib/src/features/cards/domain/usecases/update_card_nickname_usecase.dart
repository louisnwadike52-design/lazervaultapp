import 'package:dartz/dartz.dart';
import 'package:lazervault/src/core/errors/failures.dart';
import 'package:lazervault/src/features/cards/domain/entities/card_entity.dart';
import 'package:lazervault/src/features/cards/domain/repositories/i_card_repository.dart';

class UpdateCardNicknameUseCase {
  final ICardRepository repository;

  UpdateCardNicknameUseCase(this.repository);

  Future<Either<Failure, Card>> call({
    required String cardUuid,
    required String nickname,
  }) async {
    return await repository.updateCardNickname(
      cardUuid: cardUuid,
      nickname: nickname,
    );
  }
}
