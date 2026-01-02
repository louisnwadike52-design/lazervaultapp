import 'package:dartz/dartz.dart';
import 'package:lazervault/src/core/errors/failures.dart';
import 'package:lazervault/src/features/cards/domain/entities/card_entity.dart';
import 'package:lazervault/src/features/cards/domain/repositories/i_card_repository.dart';

/// Use case for creating a virtual card
class CreateVirtualCardUseCase {
  final ICardRepository repository;

  CreateVirtualCardUseCase(this.repository);

  /// Execute the use case
  Future<Either<Failure, Card>> call({
    required int accountId,
    required String cardHolderName,
    String? nickname,
    String? currency,
    String? billingAddress,
  }) async {
    return await repository.createVirtualCard(
      accountId: accountId,
      cardHolderName: cardHolderName,
      nickname: nickname,
      currency: currency,
      billingAddress: billingAddress,
    );
  }
}
