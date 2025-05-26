import 'package:fpdart/fpdart.dart';
import 'package:lazervault/core/errors/failure.dart';
import '../entities/gift_card_entity.dart';
import '../repositories/i_gift_card_repository.dart';

class PurchaseGiftCardUseCase {
  final IGiftCardRepository _repository;

  PurchaseGiftCardUseCase(this._repository);

  Future<Either<Failure, GiftCard>> call({
    required String brandId,
    required double amount,
    required String currency,
    String? recipientEmail,
    String? recipientName,
    String? message,
  }) async {
    return await _repository.purchaseGiftCard(
      brandId: brandId,
      amount: amount,
      currency: currency,
      recipientEmail: recipientEmail,
      recipientName: recipientName,
      message: message,
    );
  }
}

class RedeemGiftCardUseCase {
  final IGiftCardRepository _repository;

  RedeemGiftCardUseCase(this._repository);

  Future<Either<Failure, GiftCard>> call(String giftCardId, String code) async {
    return await _repository.redeemGiftCard(giftCardId, code);
  }
}

class SendGiftCardUseCase {
  final IGiftCardRepository _repository;

  SendGiftCardUseCase(this._repository);

  Future<Either<Failure, GiftCard>> call({
    required String giftCardId,
    required String recipientEmail,
    String? message,
  }) async {
    return await _repository.sendGiftCard(
      giftCardId: giftCardId,
      recipientEmail: recipientEmail,
      message: message,
    );
  }
}

class SellGiftCardUseCase {
  final IGiftCardRepository _repository;

  SellGiftCardUseCase(this._repository);

  Future<Either<Failure, GiftCard>> call({
    required String giftCardId,
    required double sellingPrice,
  }) async {
    return await _repository.sellGiftCard(
      giftCardId: giftCardId,
      sellingPrice: sellingPrice,
    );
  }
} 