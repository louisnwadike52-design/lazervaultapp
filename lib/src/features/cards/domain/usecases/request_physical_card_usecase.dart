import 'package:dartz/dartz.dart';
import 'package:lazervault/src/core/errors/failures.dart';
import 'package:lazervault/src/features/cards/domain/entities/card_entity.dart';
import 'package:lazervault/src/features/cards/domain/repositories/i_card_repository.dart';

class RequestPhysicalCardUseCase {
  final ICardRepository repository;

  RequestPhysicalCardUseCase(this.repository);

  Future<Either<Failure, Card>> call({
    required int accountId,
    String? nickname,
    String? currency,
    String? billingAddress,
    String? shippingAddress,
  }) async {
    return await repository.requestPhysicalCard(
      accountId: accountId,
      nickname: nickname,
      currency: currency,
      billingAddress: billingAddress,
      shippingAddress: shippingAddress,
    );
  }
}
