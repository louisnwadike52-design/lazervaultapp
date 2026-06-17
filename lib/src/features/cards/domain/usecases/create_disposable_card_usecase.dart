import 'package:dartz/dartz.dart';
import 'package:lazervault/src/core/errors/failures.dart';
import 'package:lazervault/src/features/cards/domain/entities/card_entity.dart';
import 'package:lazervault/src/features/cards/domain/repositories/i_card_repository.dart';

/// Use case for creating a disposable card
class CreateDisposableCardUseCase {
  final ICardRepository repository;

  CreateDisposableCardUseCase(this.repository);

  /// Execute the use case
  Future<Either<Failure, Card>> call({
    required int accountId,
    required String cardHolderName,
    String? nickname,
    double? spendingLimit,
    int? maxUsageCount,
    int? expiresInHours,
    String? currency,
    String? billingAddress,
  }) async {
    return await repository.createDisposableCard(
      accountId: accountId,
      cardHolderName: cardHolderName,
      nickname: nickname,
      spendingLimit: spendingLimit,
      maxUsageCount: maxUsageCount,
      expiresInHours: expiresInHours,
      currency: currency,
      billingAddress: billingAddress,
    );
  }
}
