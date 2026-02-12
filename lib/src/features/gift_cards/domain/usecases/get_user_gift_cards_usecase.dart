import 'package:fpdart/fpdart.dart';
import 'package:lazervault/core/errors/failure.dart';
import '../entities/gift_card_entity.dart';
import '../repositories/i_gift_card_repository.dart';

class GetUserGiftCardsUseCase {
  final IGiftCardRepository _repository;

  GetUserGiftCardsUseCase(this._repository);

  Future<Either<Failure, List<GiftCard>>> call({
    String? status,
    String? brandId,
    int limit = 50,
    int offset = 0,
  }) async {
    return await _repository.getUserGiftCards(
      status: status,
      brandId: brandId,
      limit: limit,
      offset: offset,
    );
  }
}

class GetGiftCardByIdUseCase {
  final IGiftCardRepository _repository;

  GetGiftCardByIdUseCase(this._repository);

  Future<Either<Failure, GiftCard>> call(String giftCardId) async {
    return await _repository.getGiftCardById(giftCardId);
  }
}

class GetGiftCardHistoryUseCase {
  final IGiftCardRepository _repository;

  GetGiftCardHistoryUseCase(this._repository);

  Future<Either<Failure, List<GiftCardTransaction>>> call({
    String? giftCardId,
    String? transactionType,
    int limit = 50,
    int offset = 0,
  }) async {
    return await _repository.getGiftCardHistory(
      giftCardId: giftCardId,
      transactionType: transactionType,
      limit: limit,
      offset: offset,
    );
  }
}
