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

  /// Request a physical card
  Future<Either<Failure, Card>> requestPhysicalCard({
    required int accountId,
    String? nickname,
    String? currency,
    String? billingAddress,
    String? shippingAddress,
  });

  /// Set card PIN
  Future<Either<Failure, void>> setCardPIN({
    required String cardUuid,
    required String pin,
  });

  /// Reveal card PIN (requires transaction PIN verification)
  Future<Either<Failure, String>> revealCardPIN({
    required String cardUuid,
  });

  /// Reveal full card details (number, CVV)
  Future<Either<Failure, Card>> revealFullCardDetails({
    required String cardUuid,
  });

  /// Fund a card from account balance
  Future<Either<Failure, Card>> fundCard({
    required String cardUuid,
    required double amount,
  });

  /// Withdraw from card to account balance
  Future<Either<Failure, Card>> withdrawFromCard({
    required String cardUuid,
    required double amount,
  });
}
