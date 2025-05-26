import 'package:fpdart/fpdart.dart';
import 'package:lazervault/core/errors/failure.dart';
import '../entities/gift_card_entity.dart';
import '../repositories/i_gift_card_repository.dart';

class GetUserGiftCardsUseCase {
  final IGiftCardRepository _repository;

  GetUserGiftCardsUseCase(this._repository);

  Future<Either<Failure, List<GiftCard>>> call() async {
    return await _repository.getUserGiftCards();
  }
}

class GetGiftCardByIdUseCase {
  final IGiftCardRepository _repository;

  GetGiftCardByIdUseCase(this._repository);

  Future<Either<Failure, GiftCard>> call(String giftCardId) async {
    return await _repository.getGiftCardById(giftCardId);
  }
}

class GetGiftCardTransactionsUseCase {
  final IGiftCardRepository _repository;

  GetGiftCardTransactionsUseCase(this._repository);

  Future<Either<Failure, List<GiftCardTransaction>>> call() async {
    return await _repository.getGiftCardTransactions();
  }
}

class ValidateGiftCardCodeUseCase {
  final IGiftCardRepository _repository;

  ValidateGiftCardCodeUseCase(this._repository);

  Future<Either<Failure, bool>> call(String code) async {
    return await _repository.validateGiftCardCode(code);
  }
}

class GetGiftCardBalanceUseCase {
  final IGiftCardRepository _repository;

  GetGiftCardBalanceUseCase(this._repository);

  Future<Either<Failure, double>> call(String giftCardId) async {
    return await _repository.getGiftCardBalance(giftCardId);
  }
} 