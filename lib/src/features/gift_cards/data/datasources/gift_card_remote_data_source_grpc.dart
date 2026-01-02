import 'package:grpc/grpc.dart';
import '../../../../core/network/grpc_client.dart';
import '../../../../generated/giftcard.pb.dart' as pb;
import '../models/gift_card_model.dart';
import '../../domain/entities/gift_card_entity.dart';
import 'gift_card_remote_data_source.dart';

/// gRPC implementation of the gift card remote data source
class GiftCardRemoteDataSourceGrpc implements IGiftCardRemoteDataSource {
  final GrpcClient grpcClient;

  GiftCardRemoteDataSourceGrpc({required this.grpcClient});

  @override
  Future<List<GiftCardBrandModel>> getGiftCardBrands() async {
    try {
      final request = pb.GetBrandsRequest();
      final options = await grpcClient.callOptions;

      final response = await grpcClient.giftCardClient.getBrands(
        request,
        options: options,
      );

      return response.brands
          .map((brand) => GiftCardBrandModel.fromProto(brand))
          .toList();
    } on GrpcError catch (e) {
      throw Exception('Failed to fetch gift card brands: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error fetching brands: $e');
    }
  }

  @override
  Future<List<GiftCardBrandModel>> getGiftCardBrandsByCategory(
    GiftCardCategory category,
  ) async {
    try {
      final request = pb.GetBrandsRequest()
        ..category = _categoryToProto(category);
      final options = await grpcClient.callOptions;

      final response = await grpcClient.giftCardClient.getBrands(
        request,
        options: options,
      );

      return response.brands
          .map((brand) => GiftCardBrandModel.fromProto(brand))
          .toList();
    } on GrpcError catch (e) {
      throw Exception('Failed to fetch brands by category: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  @override
  Future<List<GiftCardBrandModel>> searchGiftCardBrands(String query) async {
    try {
      final request = pb.SearchBrandsRequest()
        ..query = query;
      final options = await grpcClient.callOptions;

      final response = await grpcClient.giftCardClient.searchBrands(
        request,
        options: options,
      );

      return response.brands
          .map((brand) => GiftCardBrandModel.fromProto(brand))
          .toList();
    } on GrpcError catch (e) {
      throw Exception('Failed to search brands: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  @override
  Future<GiftCardBrandModel> getGiftCardBrandById(String brandId) async {
    try {
      final request = pb.GetBrandByIdRequest()
        ..brandId = brandId;
      final options = await grpcClient.callOptions;

      final response = await grpcClient.giftCardClient.getBrandById(
        request,
        options: options,
      );

      return GiftCardBrandModel.fromProto(response.brand);
    } on GrpcError catch (e) {
      throw Exception('Failed to fetch brand: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  @override
  Future<GiftCardModel> purchaseGiftCard({
    required String brandId,
    required double amount,
    required String currency,
    String? recipientEmail,
    String? recipientName,
    String? message,
  }) async {
    try {
      final request = pb.PurchaseGiftCardRequest()
        ..brandId = brandId
        ..amount = amount
        ..currency = currency
        ..paymentMethod = pb.PaymentMethod.PAYMENT_METHOD_WALLET
        ..isForSelf = recipientEmail == null || recipientEmail.isEmpty;

      if (recipientEmail != null && recipientEmail.isNotEmpty) {
        request.recipientEmail = recipientEmail;
      }
      if (recipientName != null && recipientName.isNotEmpty) {
        request.recipientName = recipientName;
      }
      if (message != null && message.isNotEmpty) {
        request.message = message;
      }

      final options = await grpcClient.callOptions;

      final response = await grpcClient.giftCardClient.purchaseGiftCard(
        request,
        options: options,
      );

      return GiftCardModel.fromProto(response.giftCard);
    } on GrpcError catch (e) {
      if (e.code == StatusCode.failedPrecondition && e.message != null && e.message!.toLowerCase().contains('insufficient funds')) {
        throw Exception('Insufficient funds for purchase');
      } else if (e.code == StatusCode.notFound) {
        throw Exception('Gift card brand not found');
      }
      throw Exception('Purchase failed: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error during purchase: $e');
    }
  }

  @override
  Future<List<GiftCardModel>> getUserGiftCards() async {
    try {
      final request = pb.GetUserGiftCardsRequest();
      final options = await grpcClient.callOptions;

      final response = await grpcClient.giftCardClient.getUserGiftCards(
        request,
        options: options,
      );

      return response.giftCards
          .map((card) => GiftCardModel.fromProto(card))
          .toList();
    } on GrpcError catch (e) {
      throw Exception('Failed to fetch user gift cards: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  @override
  Future<GiftCardModel> getGiftCardById(String giftCardId) async {
    try {
      final request = pb.GetGiftCardByIdRequest()
        ..giftCardId = giftCardId;
      final options = await grpcClient.callOptions;

      final response = await grpcClient.giftCardClient.getGiftCardById(
        request,
        options: options,
      );

      return GiftCardModel.fromProto(response.giftCard);
    } on GrpcError catch (e) {
      if (e.code == StatusCode.notFound) {
        throw Exception('Gift card not found');
      }
      throw Exception('Failed to fetch gift card: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  @override
  Future<GiftCardModel> redeemGiftCard(String giftCardId, String code) async {
    try {
      final request = pb.RedeemGiftCardRequest()
        ..giftCardId = giftCardId
        ..code = code;
      final options = await grpcClient.callOptions;

      final response = await grpcClient.giftCardClient.redeemGiftCard(
        request,
        options: options,
      );

      return GiftCardModel.fromProto(response.giftCard);
    } on GrpcError catch (e) {
      if (e.code == StatusCode.invalidArgument) {
        throw Exception('Invalid gift card code');
      } else if (e.code == StatusCode.failedPrecondition) {
        throw Exception('Gift card already redeemed or expired');
      }
      throw Exception('Redemption failed: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error during redemption: $e');
    }
  }

  @override
  Future<List<GiftCardTransactionModel>> getGiftCardTransactions() async {
    try {
      final request = pb.GetTransactionsRequest();
      final options = await grpcClient.callOptions;

      final response = await grpcClient.giftCardClient.getTransactions(
        request,
        options: options,
      );

      return response.transactions
          .map((transaction) => GiftCardTransactionModel.fromProto(transaction))
          .toList();
    } on GrpcError catch (e) {
      throw Exception('Failed to fetch transactions: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  @override
  Future<GiftCardTransactionModel> getTransactionById(
    String transactionId,
  ) async {
    try {
      final request = pb.GetTransactionByIdRequest()
        ..transactionId = transactionId;
      final options = await grpcClient.callOptions;

      final response = await grpcClient.giftCardClient.getTransactionById(
        request,
        options: options,
      );

      return GiftCardTransactionModel.fromProto(response.transaction);
    } on GrpcError catch (e) {
      if (e.code == StatusCode.notFound) {
        throw Exception('Transaction not found');
      }
      throw Exception('Failed to fetch transaction: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  @override
  Future<GiftCardModel> sendGiftCard({
    required String giftCardId,
    required String recipientEmail,
    String? message,
  }) async {
    try {
      final request = pb.TransferGiftCardRequest()
        ..giftCardId = giftCardId
        ..recipientEmail = recipientEmail;

      if (message != null && message.isNotEmpty) {
        request.message = message;
      }

      final options = await grpcClient.callOptions;

      final response = await grpcClient.giftCardClient.transferGiftCard(
        request,
        options: options,
      );

      return GiftCardModel.fromProto(response.giftCard);
    } on GrpcError catch (e) {
      if (e.code == StatusCode.notFound) {
        throw Exception('Gift card or recipient not found');
      }
      throw Exception('Transfer failed: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error during transfer: $e');
    }
  }

  @override
  Future<bool> validateGiftCardCode(String code) async {
    try {
      final request = pb.ValidateCodeRequest()
        ..code = code;
      final options = await grpcClient.callOptions;

      final response = await grpcClient.giftCardClient.validateCode(
        request,
        options: options,
      );

      return response.isValid && !response.isExpired && !response.isRedeemed;
    } on GrpcError catch (e) {
      throw Exception('Code validation failed: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  @override
  Future<double> getGiftCardBalance(String giftCardId) async {
    try {
      final request = pb.CheckBalanceRequest()
        ..giftCardId = giftCardId;
      final options = await grpcClient.callOptions;

      final response = await grpcClient.giftCardClient.checkBalance(
        request,
        options: options,
      );

      return response.remainingBalance;
    } on GrpcError catch (e) {
      if (e.code == StatusCode.notFound) {
        throw Exception('Gift card not found');
      }
      throw Exception('Failed to check balance: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  @override
  Future<GiftCardModel> sellGiftCard({
    required String giftCardId,
    required double sellingPrice,
  }) async {
    try {
      final request = pb.SellGiftCardRequest()
        ..giftCardId = giftCardId
        ..askingPrice = sellingPrice;
      final options = await grpcClient.callOptions;

      final response = await grpcClient.giftCardClient.sellGiftCard(
        request,
        options: options,
      );

      // For now, we'll need to fetch the updated gift card
      return getGiftCardById(giftCardId);
    } on GrpcError catch (e) {
      if (e.code == StatusCode.notFound) {
        throw Exception('Gift card not found');
      } else if (e.code == StatusCode.failedPrecondition) {
        throw Exception('Gift card cannot be sold (already used or expired)');
      }
      throw Exception('Sell failed: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error during sell: $e');
    }
  }

  @override
  Future<List<GiftCardModel>> getResellableGiftCards() async {
    try {
      final request = pb.GetResellableCardsRequest();
      final options = await grpcClient.callOptions;

      final response = await grpcClient.giftCardClient.getResellableCards(
        request,
        options: options,
      );

      return response.giftCards
          .map((card) => GiftCardModel.fromProto(card))
          .toList();
    } on GrpcError catch (e) {
      throw Exception('Failed to fetch resellable cards: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  // Helper method to convert domain category to proto category
  pb.GiftCardCategory _categoryToProto(GiftCardCategory category) {
    switch (category) {
      case GiftCardCategory.entertainment:
        return pb.GiftCardCategory.GIFTCARD_CATEGORY_ENTERTAINMENT;
      case GiftCardCategory.shopping:
        return pb.GiftCardCategory.GIFTCARD_CATEGORY_SHOPPING;
      case GiftCardCategory.dining:
        return pb.GiftCardCategory.GIFTCARD_CATEGORY_DINING;
      case GiftCardCategory.travel:
        return pb.GiftCardCategory.GIFTCARD_CATEGORY_TRAVEL;
      case GiftCardCategory.gaming:
        return pb.GiftCardCategory.GIFTCARD_CATEGORY_GAMING;
      case GiftCardCategory.other:
        return pb.GiftCardCategory.GIFTCARD_CATEGORY_OTHER;
    }
  }
}
