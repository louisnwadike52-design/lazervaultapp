import 'package:dartz/dartz.dart';
import 'package:lazervault/src/core/errors/failures.dart';
import 'package:lazervault/src/features/cards/domain/entities/card_entity.dart';

/// Card repository interface
abstract class ICardRepository {
  /// Create a new virtual card
  Future<Either<Failure, Card>> createVirtualCard({
    required int accountId,
    required String cardHolderName,
    String? nickname,
    String? currency,
    String? billingAddress,
  });

  /// Create a new disposable card
  Future<Either<Failure, Card>> createDisposableCard({
    required int accountId,
    required String cardHolderName,
    String? nickname,
    double? spendingLimit,
    int? maxUsageCount,
    int? expiresInHours,
    String? currency,
    String? billingAddress,
  });

  /// Get all cards for the authenticated user
  Future<Either<Failure, List<Card>>> getUserCards({
    CardType? typeFilter,
    CardStatus? statusFilter,
  });

  /// Get detailed information about a specific card
  Future<Either<Failure, Card>> getCardDetails({
    required String cardUuid,
    bool includeFullDetails = false,
  });

  /// Freeze a card
  Future<Either<Failure, Card>> freezeCard({
    required String cardUuid,
    String? reason,
  });

  /// Unfreeze a card
  Future<Either<Failure, Card>> unfreezeCard({
    required String cardUuid,
  });

  /// Cancel a card permanently
  Future<Either<Failure, void>> cancelCard({
    required String cardUuid,
    String? reason,
  });

  /// Update card nickname
  Future<Either<Failure, Card>> updateCardNickname({
    required String cardUuid,
    required String nickname,
  });

  /// Update spending limit (for disposable cards)
  Future<Either<Failure, Card>> updateCardSpendingLimit({
    required String cardUuid,
    required double newLimit,
  });

  /// Set a card as default
  Future<Either<Failure, Card>> setDefaultCard({
    required String cardUuid,
  });
}
