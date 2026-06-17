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
    required String transactionId,
    required String verificationToken,
    int? productId,
    String? recipientEmail,
    String? recipientName,
    String? giftMessage,
    String? senderName,
    String? recipientPhone,
    String? countryCode,
    String? idempotencyKey,
    int quantity = 1,
  }) async {
    return await _repository.buyGiftCard(
      brandId: brandId,
      amount: amount,
      transactionId: transactionId,
      verificationToken: verificationToken,
      productId: productId,
      recipientEmail: recipientEmail,
      recipientName: recipientName,
      giftMessage: giftMessage,
      senderName: senderName,
      recipientPhone: recipientPhone,
      countryCode: countryCode,
      idempotencyKey: idempotencyKey,
      quantity: quantity,
    );
  }
}
