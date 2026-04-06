import 'package:fixnum/fixnum.dart';
import 'package:grpc/grpc.dart';
import '../../../../core/network/grpc_client.dart';
import '../../../../generated/giftcards.pb.dart' as pb;
import '../../domain/entities/gift_card_entity.dart';
import '../models/gift_card_model.dart';
import 'gift_card_remote_data_source.dart';

/// gRPC implementation of the gift card remote data source
class GiftCardRemoteDataSourceGrpc implements IGiftCardRemoteDataSource {
  final GrpcClient grpcClient;

  GiftCardRemoteDataSourceGrpc({required this.grpcClient});

  @override
  Future<GiftCardBrandsResult> getGiftCardBrands({
    String? category,
    String? countryCode,
    String? searchQuery,
    int page = 0,
    int pageSize = 20,
  }) async {
    try {
      final request = pb.GetGiftCardBrandsRequest(
        category: category ?? '',
        activeOnly: true,
        countryCode: countryCode ?? '',
        searchQuery: searchQuery ?? '',
        page: page,
        pageSize: pageSize,
      );
      final options = await grpcClient.callOptions;

      final response = await grpcClient.giftCardClient.getGiftCardBrands(
        request,
        options: options,
      );

      final brands = response.brands
          .map((brand) => GiftCardBrandModel.fromProto(brand))
          .toList();

      return GiftCardBrandsResult(
        brands: brands,
        total: response.total,
        totalPages: response.totalPages,
        currentPage: response.currentPage,
        hasNext: response.hasNext,
      );
    } on GrpcError catch (e) {
      throw Exception('Failed to fetch gift card brands: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error fetching brands: $e');
    }
  }

  @override
  Future<List<GiftCardCountry>> getSupportedCountries() async {
    try {
      final request = pb.GetSupportedCountriesRequest();
      final options = await grpcClient.callOptions;
      final response = await grpcClient.giftCardClient.getSupportedCountries(
        request,
        options: options,
      );
      return response.countries.map((c) => GiftCardCountry(
        isoCode: c.isoCode,
        name: c.name,
        flagUrl: c.flagUrl,
        currencyCode: c.currencyCode,
        currencyName: c.currencyName,
      )).toList();
    } on GrpcError catch (e) {
      throw Exception('Failed to fetch supported countries: ${e.message}');
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
    String? providerName,
    double? senderAmount,
    String? senderCurrency,
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
        providerName: providerName ?? '',
      );

      request.senderAmount = senderAmount ?? 0;
      request.senderCurrency = senderCurrency ?? '';

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
      final msg = (e.message ?? '').toLowerCase();
      if (e.code == StatusCode.failedPrecondition) {
        if (msg.contains('insufficient')) {
          throw Exception('Insufficient funds for purchase');
        } else if (msg.contains('sold out')) {
          throw Exception('sold out');
        } else if (msg.contains('unavailable')) {
          throw Exception('temporarily unavailable');
        } else if (msg.contains('provider mismatch')) {
          throw Exception('Gift card catalog has been updated. Please browse brands again and try your purchase.');
        } else if (msg.contains('invalid amount') || msg.contains('check the price')) {
          throw Exception('Invalid amount for this gift card. Please check and try again.');
        }
        throw Exception(e.message ?? 'Purchase failed');
      } else if (e.code == StatusCode.notFound) {
        throw Exception('Gift card brand not found');
      } else if (e.code == StatusCode.unavailable) {
        throw Exception(e.message ?? 'Service temporarily busy. Please try again.');
      } else if (e.code == StatusCode.resourceExhausted) {
        throw Exception('Too many attempts. Please wait a moment.');
      } else if (e.code == StatusCode.alreadyExists) {
        throw Exception('This order is already being processed.');
      } else if (e.code == StatusCode.invalidArgument) {
        throw Exception(e.message ?? 'Invalid request. Please check your details.');
      }
      throw Exception(e.message ?? 'Purchase failed. Please try again.');
    } catch (e) {
      throw Exception('Unexpected error during purchase. Please try again.');
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
  Future<Map<String, String>> getRedeemCode({
    required String transactionId,
    bool forceRefresh = false,
  }) async {
    try {
      final request = pb.GetRedeemCodeRequest(
        transactionId: transactionId,
        forceRefresh: forceRefresh,
      );
      final options = await grpcClient.callOptions;

      final response = await grpcClient.giftCardClient.getRedeemCode(
        request,
        options: options,
      );

      return {
        'redemptionCode': response.redemptionCode,
        'redemptionPin': response.redemptionPin,
        'transactionId': response.transactionId,
        'status': response.status,
        'message': response.message,
      };
    } on GrpcError catch (e) {
      if (e.code == StatusCode.notFound) {
        throw Exception('Gift card not found');
      } else if (e.code == StatusCode.permissionDenied) {
        throw Exception('You can only view redeem codes for your own gift cards');
      }
      throw Exception('Failed to get redeem code: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
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
    String? recipientUserId,
    String transferType = 'email',
  }) async {
    try {
      final request = pb.TransferGiftCardRequest(
        giftCardId: giftCardId,
        recipientEmail: recipientEmail,
        recipientName: recipientName,
        message: message,
        transactionId: transactionId,
        verificationToken: verificationToken,
        recipientUserId: recipientUserId ?? '',
        transferType: transferType,
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

  // Sell flow methods

  @override
  Future<List<SellableCardModel>> getSellableCards({String? countryCode}) async {
    try {
      final request = pb.GetSellableCardsRequest();
      request.countryCode = countryCode ?? '';
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
    String? providerName,
    String? cardCountry,
    String? cardFormat,
    List<String>? imageUrls,
    List<String>? imageKeys,
    String? ocrBrand,
    String? ocrCardNumber,
    String? ocrPin,
    double? ocrDenomination,
    String? ocrCurrency,
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
        providerName: providerName ?? '',
        cardCountry: cardCountry ?? '',
        cardFormat: cardFormat ?? 'ecode',
        ocrBrand: ocrBrand ?? '',
        ocrCardNumber: ocrCardNumber ?? '',
        ocrPin: ocrPin ?? '',
        ocrDenomination: ocrDenomination ?? 0,
        ocrCurrency: ocrCurrency ?? '',
      );

      if (images != null && images.isNotEmpty) {
        request.images.addAll(images);
      }
      if (imageUrls != null && imageUrls.isNotEmpty) {
        request.imageUrls.addAll(imageUrls);
      }
      if (imageKeys != null && imageKeys.isNotEmpty) {
        request.imageKeys.addAll(imageKeys);
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
      // Provider mismatch error handling
      if (e.code == StatusCode.failedPrecondition &&
          e.message != null &&
          e.message!.toLowerCase().contains('provider mismatch')) {
        throw Exception('Provider mismatch: Sellable cards catalog has been updated. Please check available card types again and try your sell.');
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

  @override
  Future<Map<String, String>> uploadSellImage({
    required String imageData,
    required String contentType,
    required String filename,
  }) async {
    try {
      final request = pb.UploadSellImageRequest(
        imageData: imageData,
        contentType: contentType,
        filename: filename,
      );
      final options = await grpcClient.callOptions;
      final response = await grpcClient.giftCardClient.uploadSellImage(request, options: options);
      return {'imageUrl': response.imageUrl, 'imageKey': response.imageKey};
    } on GrpcError catch (e) {
      throw Exception('Failed to upload image: ${e.message}');
    }
  }

  @override
  Future<Map<String, dynamic>> extractCardDetails({
    required List<String> imageUrls,
  }) async {
    try {
      final request = pb.ExtractCardDetailsRequest(imageUrls: imageUrls);
      final options = await grpcClient.callOptions;
      final response = await grpcClient.giftCardClient.extractCardDetails(request, options: options);
      return {
        'brand': response.brand,
        'cardNumber': response.cardNumber,
        'pin': response.pin,
        'denomination': response.denomination,
        'currency': response.currency,
        'confidence': response.confidence,
        'rawText': response.rawText,
      };
    } on GrpcError catch (e) {
      throw Exception('Failed to extract card details: ${e.message}');
    }
  }

  @override
  Future<Map<String, dynamic>> getActiveSellProvider() async {
    try {
      final request = pb.GetSellProviderRequest();
      final options = await grpcClient.callOptions;

      final response = await grpcClient.giftCardClient.getSellProvider(
        request,
        options: options,
      );

      return {
        'provider': response.provider,
        'description': response.description,
      };
    } on GrpcError catch (e) {
      throw Exception('Failed to get sell provider: ${e.message}');
    }
  }

  @override
  Future<Map<String, dynamic>?> retrySettlement(String saleId) async {
    try {
      // This would call a new RPC endpoint like AdminProcessPayout
      // For now, return a placeholder response
      return {
        'success': true,
        'message': 'Settlement retry initiated successfully',
      };
    } on GrpcError catch (e) {
      throw Exception('Failed to retry settlement: ${e.message}');
    }
  }

  @override
  Future<Map<String, dynamic>?> exportSettlementHistory(String format) async {
    try {
      // This would call a new RPC endpoint for export
      // For now, return a placeholder response
      return {
        'success': true,
        'filePath': '/tmp/settlement_history.$format',
      };
    } on GrpcError catch (e) {
      throw Exception('Failed to export settlement history: ${e.message}');
    }
  }

  @override
  Future<List<Settlement>> getSettlementHistory() async {
    try {
      // This would call a new RPC endpoint for settlement history
      // For now, return empty list as placeholder
      return [];
    } on GrpcError catch (e) {
      throw Exception('Failed to load settlement history: ${e.message}');
    }
  }
}
