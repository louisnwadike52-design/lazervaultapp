import 'package:fixnum/fixnum.dart';
import 'package:grpc/grpc.dart';
import '../../../../core/network/grpc_client.dart';
import '../../../../generated/giftcards.pb.dart' as pb;
import '../models/gift_card_model.dart';
import 'gift_card_remote_data_source.dart';

/// gRPC implementation of the gift card remote data source
class GiftCardRemoteDataSourceGrpc implements IGiftCardRemoteDataSource {
  final GrpcClient grpcClient;

  GiftCardRemoteDataSourceGrpc({required this.grpcClient});

  @override
  Future<List<GiftCardBrandModel>> getGiftCardBrands({
    String? category,
    String? countryCode,
  }) async {
    try {
      final request = pb.GetGiftCardBrandsRequest(
        category: category ?? '',
        activeOnly: true,
        countryCode: countryCode ?? '',
      );
      final options = await grpcClient.callOptions;

      final response = await grpcClient.giftCardClient.getGiftCardBrands(
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
  Future<GiftCardModel> buyGiftCard({
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
    try {
      final request = pb.BuyGiftCardRequest(
        brandId: brandId,
        amount: amount,
        transactionId: transactionId,
        verificationToken: verificationToken,
        recipientEmail: recipientEmail ?? '',
        recipientName: recipientName ?? '',
        giftMessage: giftMessage ?? '',
        senderName: senderName ?? '',
        recipientPhone: recipientPhone ?? '',
        countryCode: countryCode ?? '',
        idempotencyKey: idempotencyKey ?? '',
        quantity: quantity,
      );

      if (productId != null && productId > 0) {
        request.productId = Int64(productId);
      }

      final options = await grpcClient.callOptions;

      final response = await grpcClient.giftCardClient.buyGiftCard(
        request,
        options: options,
      );

      return GiftCardModel.fromProto(response.giftCard);
    } on GrpcError catch (e) {
      if (e.code == StatusCode.failedPrecondition &&
          e.message != null &&
          e.message!.toLowerCase().contains('insufficient')) {
        throw Exception('Insufficient funds for purchase');
      } else if (e.code == StatusCode.notFound) {
        throw Exception('Gift card brand not found');
      } else if (e.code == StatusCode.unavailable) {
        throw Exception('Gift card service temporarily unavailable');
      }
      throw Exception('Purchase failed: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error during purchase: $e');
    }
  }

  @override
  Future<List<GiftCardModel>> getUserGiftCards({
    String? status,
    String? brandId,
    int limit = 50,
    int offset = 0,
  }) async {
    try {
      final request = pb.GetGiftCardsRequest(
        status: status ?? '',
        brandId: brandId ?? '',
        limit: limit,
        offset: offset,
      );
      final options = await grpcClient.callOptions;

      final response = await grpcClient.giftCardClient.getGiftCards(
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
      final request = pb.GetGiftCardRequest(giftCardId: giftCardId);
      final options = await grpcClient.callOptions;

      final response = await grpcClient.giftCardClient.getGiftCard(
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
  Future<List<GiftCardTransactionModel>> getGiftCardHistory({
    String? giftCardId,
    String? transactionType,
    int limit = 50,
    int offset = 0,
  }) async {
    try {
      final request = pb.GetGiftCardHistoryRequest(
        giftCardId: giftCardId ?? '',
        transactionType: transactionType ?? '',
        limit: limit,
        offset: offset,
      );
      final options = await grpcClient.callOptions;

      final response = await grpcClient.giftCardClient.getGiftCardHistory(
        request,
        options: options,
      );

      return response.transactions
          .map((tx) => GiftCardTransactionModel.fromProto(tx))
          .toList();
    } on GrpcError catch (e) {
      throw Exception('Failed to fetch history: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  @override
  Future<GiftCardModel> redeemGiftCard({
    required String accountId,
    required String cardNumber,
    required String cardPin,
  }) async {
    try {
      final request = pb.RedeemGiftCardRequest(
        accountId: accountId,
        cardNumber: cardNumber,
        cardPin: cardPin,
      );
      final options = await grpcClient.callOptions;

      final response = await grpcClient.giftCardClient.redeemGiftCard(
        request,
        options: options,
      );

      return GiftCardModel.fromProto(response.giftCard);
    } on GrpcError catch (e) {
      if (e.code == StatusCode.notFound) {
        throw Exception('Gift card not found');
      } else if (e.code == StatusCode.failedPrecondition) {
        throw Exception(e.message ?? 'Gift card cannot be redeemed');
      }
      throw Exception('Redemption failed: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error during redemption: $e');
    }
  }

  @override
  Future<GiftCardModel> transferGiftCard({
    required String giftCardId,
    required String recipientEmail,
    required String recipientName,
    required String message,
    required String transactionId,
    required String verificationToken,
  }) async {
    try {
      final request = pb.TransferGiftCardRequest(
        giftCardId: giftCardId,
        recipientEmail: recipientEmail,
        recipientName: recipientName,
        message: message,
        transactionId: transactionId,
        verificationToken: verificationToken,
      );
      final options = await grpcClient.callOptions;

      final response = await grpcClient.giftCardClient.transferGiftCard(
        request,
        options: options,
      );

      return GiftCardModel.fromProto(response.giftCard);
    } on GrpcError catch (e) {
      if (e.code == StatusCode.notFound) {
        throw Exception('Gift card not found');
      } else if (e.code == StatusCode.permissionDenied) {
        throw Exception('Invalid transaction PIN');
      } else if (e.code == StatusCode.failedPrecondition) {
        throw Exception(e.message ?? 'Gift card cannot be transferred');
      }
      throw Exception('Transfer failed: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error during transfer: $e');
    }
  }

  @override
  Future<GiftCardBalanceModel> getGiftCardBalance({
    required String cardNumber,
    required String cardPin,
  }) async {
    try {
      final request = pb.GetGiftCardBalanceRequest(
        cardNumber: cardNumber,
        cardPin: cardPin,
      );
      final options = await grpcClient.callOptions;

      final response = await grpcClient.giftCardClient.getGiftCardBalance(
        request,
        options: options,
      );

      return GiftCardBalanceModel.fromProto(response);
    } on GrpcError catch (e) {
      if (e.code == StatusCode.notFound) {
        throw Exception('Gift card not found');
      } else if (e.code == StatusCode.invalidArgument) {
        throw Exception('Invalid card number or PIN');
      }
      throw Exception('Failed to check balance: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error checking balance: $e');
    }
  }

  // Sell flow methods

  @override
  Future<List<SellableCardModel>> getSellableCards() async {
    try {
      final request = pb.GetSellableCardsRequest();
      final options = await grpcClient.callOptions;

      final response = await grpcClient.giftCardClient.getSellableCards(
        request,
        options: options,
      );

      return response.cards
          .map((card) => SellableCardModel.fromProto(card))
          .toList();
    } on GrpcError catch (e) {
      throw Exception('Failed to fetch sellable cards: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error fetching sellable cards: $e');
    }
  }

  @override
  Future<SellRateModel> getSellRate({
    required String cardType,
    required double denomination,
    String? currency,
  }) async {
    try {
      final request = pb.GetSellRateRequest(
        cardType: cardType,
        denomination: denomination,
      );
      final options = await grpcClient.callOptions;

      final response = await grpcClient.giftCardClient.getSellRate(
        request,
        options: options,
      );

      return SellRateModel.fromProto(response.rate);
    } on GrpcError catch (e) {
      throw Exception('Failed to fetch sell rate: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error fetching sell rate: $e');
    }
  }

  @override
  Future<GiftCardSaleModel> sellGiftCard({
    required String cardType,
    required String cardNumber,
    required String cardPin,
    required double denomination,
    required String transactionId,
    required String verificationToken,
    String? currency,
    List<String>? images,
    String? idempotencyKey,
  }) async {
    try {
      final request = pb.SellGiftCardRequest(
        cardType: cardType,
        cardNumber: cardNumber,
        cardPin: cardPin,
        denomination: denomination,
        transactionId: transactionId,
        verificationToken: verificationToken,
        currency: currency ?? 'USD',
        idempotencyKey: idempotencyKey ?? '',
      );

      if (images != null && images.isNotEmpty) {
        request.images.addAll(images);
      }

      final options = await grpcClient.callOptions;

      final response = await grpcClient.giftCardClient.sellGiftCard(
        request,
        options: options,
      );

      return GiftCardSaleModel.fromProto(response.sale);
    } on GrpcError catch (e) {
      if (e.code == StatusCode.permissionDenied) {
        throw Exception('Invalid transaction PIN');
      } else if (e.code == StatusCode.unavailable) {
        throw Exception('Sell service temporarily unavailable');
      }
      throw Exception('Sell failed: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error during sell: $e');
    }
  }

  @override
  Future<GiftCardSaleModel> getSellStatus(String saleId) async {
    try {
      final request = pb.GetSellStatusRequest(saleId: saleId);
      final options = await grpcClient.callOptions;

      final response = await grpcClient.giftCardClient.getSellStatus(
        request,
        options: options,
      );

      return GiftCardSaleModel.fromProto(response.sale);
    } on GrpcError catch (e) {
      if (e.code == StatusCode.notFound) {
        throw Exception('Sale not found');
      }
      throw Exception('Failed to fetch sell status: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  @override
  Future<List<GiftCardSaleModel>> getMySales({
    String? status,
    int limit = 50,
    int offset = 0,
  }) async {
    try {
      final request = pb.GetMySalesRequest(
        status: status ?? '',
        limit: limit,
        offset: offset,
      );
      final options = await grpcClient.callOptions;

      final response = await grpcClient.giftCardClient.getMySales(
        request,
        options: options,
      );

      return response.sales
          .map((sale) => GiftCardSaleModel.fromProto(sale))
          .toList();
    } on GrpcError catch (e) {
      throw Exception('Failed to fetch sales: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
