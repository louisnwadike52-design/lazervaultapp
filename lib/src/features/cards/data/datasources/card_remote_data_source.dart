import 'package:fixnum/fixnum.dart';
import 'package:lazervault/src/core/network/grpc_client.dart';
import 'package:lazervault/src/features/cards/data/models/card_model.dart';
import 'package:lazervault/src/features/cards/domain/entities/card_entity.dart';
import 'package:lazervault/src/generated/account_card.pb.dart' as pb;

/// Card remote data source interface
abstract class ICardRemoteDataSource {
  /// Create a virtual card
  Future<CardModel> createVirtualCard({
    required int accountId,
    required String cardHolderName,
    String? nickname,
    String? currency,
    String? billingAddress,
  });

  /// Create a disposable card
  Future<CardModel> createDisposableCard({
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
  Future<List<CardModel>> getUserCards({
    CardType? typeFilter,
    CardStatus? statusFilter,
  });

  /// Get detailed information about a specific card
  Future<CardModel> getCardDetails({
    required String cardUuid,
    bool includeFullDetails = false,
  });

  /// Freeze a card
  Future<CardModel> freezeCard({
    required String cardUuid,
    String? reason,
  });

  /// Unfreeze a card
  Future<CardModel> unfreezeCard({
    required String cardUuid,
  });

  /// Cancel a card
  Future<void> cancelCard({
    required String cardUuid,
    String? reason,
  });

  /// Update card nickname
  Future<CardModel> updateCardNickname({
    required String cardUuid,
    required String nickname,
  });

  /// Update card spending limit
  Future<CardModel> updateCardSpendingLimit({
    required String cardUuid,
    required double newLimit,
  });

  /// Set card as default
  Future<CardModel> setDefaultCard({
    required String cardUuid,
  });
}

/// Card remote data source implementation using gRPC
class CardRemoteDataSourceImpl implements ICardRemoteDataSource {
  final GrpcClient grpcClient;

  CardRemoteDataSourceImpl({required this.grpcClient});

  @override
  Future<CardModel> createVirtualCard({
    required int accountId,
    required String cardHolderName,
    String? nickname,
    String? currency,
    String? billingAddress,
  }) async {
    try {
      final request = pb.CreateVirtualCardRequest()
        ..accountId = Int64(accountId);

      if (nickname != null && nickname.isNotEmpty) {
        request.cardNickname = nickname;
      }
      if (currency != null && currency.isNotEmpty) {
        request.currency = currency;
      }
      if (billingAddress != null && billingAddress.isNotEmpty) {
        request.billingAddress = billingAddress;
      }

      final callOptions = await grpcClient.callOptions;
      final response = await grpcClient.accountCardClient.createVirtualCard(
        request,
        options: callOptions,
      );

      return CardModel.fromProto(response.card);
    } catch (e) {
      throw Exception('Failed to create virtual card: ${e.toString()}');
    }
  }

  @override
  Future<CardModel> createDisposableCard({
    required int accountId,
    required String cardHolderName,
    String? nickname,
    double? spendingLimit,
    int? maxUsageCount,
    int? expiresInHours,
    String? currency,
    String? billingAddress,
  }) async {
    try {
      final request = pb.CreateDisposableCardRequest()
        ..accountId = Int64(accountId);

      if (nickname != null && nickname.isNotEmpty) {
        request.cardNickname = nickname;
      }
      if (spendingLimit != null) {
        request.spendingLimit = spendingLimit;
      }
      if (currency != null && currency.isNotEmpty) {
        request.currency = currency;
      }
      if (maxUsageCount != null && maxUsageCount > 0) {
        request.maxUsageCount = maxUsageCount;
      }
      if (expiresInHours != null && expiresInHours > 0) {
        request.expiresInHours = expiresInHours;
      }
      if (billingAddress != null && billingAddress.isNotEmpty) {
        request.billingAddress = billingAddress;
      }

      final callOptions = await grpcClient.callOptions;
      final response = await grpcClient.accountCardClient.createDisposableCard(
        request,
        options: callOptions,
      );

      return CardModel.fromProto(response.card);
    } catch (e) {
      throw Exception('Failed to create disposable card: ${e.toString()}');
    }
  }

  @override
  Future<List<CardModel>> getUserCards({
    CardType? typeFilter,
    CardStatus? statusFilter,
  }) async {
    try {
      final request = pb.GetUserCardsRequest();

      if (typeFilter != null) {
        request.cardTypeFilter = typeFilter.toProtoString();
      }
      if (statusFilter != null) {
        request.statusFilter = statusFilter.toProtoString();
      }

      final callOptions = await grpcClient.callOptions;
      final response = await grpcClient.accountCardClient.getUserCards(
        request,
        options: callOptions,
      );

      return response.cards.map((card) => CardModel.fromProto(card)).toList();
    } catch (e) {
      throw Exception('Failed to get user cards: ${e.toString()}');
    }
  }

  @override
  Future<CardModel> getCardDetails({
    required String cardUuid,
    bool includeFullDetails = false,
  }) async {
    try {
      final request = pb.GetCardDetailsRequest()
        ..cardUuid = cardUuid
        ..includeFullDetails = includeFullDetails;

      final callOptions = await grpcClient.callOptions;
      final response = await grpcClient.accountCardClient.getCardDetails(
        request,
        options: callOptions,
      );

      return CardModel.fromProto(response.card);
    } catch (e) {
      throw Exception('Failed to get card details: ${e.toString()}');
    }
  }

  @override
  Future<CardModel> freezeCard({
    required String cardUuid,
    String? reason,
  }) async {
    try {
      final request = pb.FreezeCardRequest()..cardUuid = cardUuid;

      if (reason != null && reason.isNotEmpty) {
        request.reason = reason;
      }

      final callOptions = await grpcClient.callOptions;
      final response = await grpcClient.accountCardClient.freezeCard(
        request,
        options: callOptions,
      );

      return CardModel.fromProto(response.card);
    } catch (e) {
      throw Exception('Failed to freeze card: ${e.toString()}');
    }
  }

  @override
  Future<CardModel> unfreezeCard({required String cardUuid}) async {
    try {
      final request = pb.UnfreezeCardRequest()..cardUuid = cardUuid;

      final callOptions = await grpcClient.callOptions;
      final response = await grpcClient.accountCardClient.unfreezeCard(
        request,
        options: callOptions,
      );

      return CardModel.fromProto(response.card);
    } catch (e) {
      throw Exception('Failed to unfreeze card: ${e.toString()}');
    }
  }

  @override
  Future<void> cancelCard({
    required String cardUuid,
    String? reason,
  }) async {
    try {
      final request = pb.CancelCardRequest()..cardUuid = cardUuid;

      if (reason != null && reason.isNotEmpty) {
        request.reason = reason;
      }

      final callOptions = await grpcClient.callOptions;
      await grpcClient.accountCardClient.cancelCard(
        request,
        options: callOptions,
      );
    } catch (e) {
      throw Exception('Failed to cancel card: ${e.toString()}');
    }
  }

  @override
  Future<CardModel> updateCardNickname({
    required String cardUuid,
    required String nickname,
  }) async {
    try {
      final request = pb.UpdateCardNicknameRequest()
        ..cardUuid = cardUuid
        ..nickname = nickname;

      final callOptions = await grpcClient.callOptions;
      final response = await grpcClient.accountCardClient.updateCardNickname(
        request,
        options: callOptions,
      );

      return CardModel.fromProto(response.card);
    } catch (e) {
      throw Exception('Failed to update card nickname: ${e.toString()}');
    }
  }

  @override
  Future<CardModel> updateCardSpendingLimit({
    required String cardUuid,
    required double newLimit,
  }) async {
    try {
      final request = pb.UpdateCardSpendingLimitRequest()
        ..cardUuid = cardUuid
        ..newLimit = newLimit;

      final callOptions = await grpcClient.callOptions;
      final response = await grpcClient.accountCardClient.updateCardSpendingLimit(
        request,
        options: callOptions,
      );

      return CardModel.fromProto(response.card);
    } catch (e) {
      throw Exception('Failed to update card spending limit: ${e.toString()}');
    }
  }

  @override
  Future<CardModel> setDefaultCard({required String cardUuid}) async {
    try {
      final request = pb.SetDefaultCardRequest()..cardUuid = cardUuid;

      final callOptions = await grpcClient.callOptions;
      final response = await grpcClient.accountCardClient.setDefaultCard(
        request,
        options: callOptions,
      );

      return CardModel.fromProto(response.card);
    } catch (e) {
      throw Exception('Failed to set default card: ${e.toString()}');
    }
  }
}
