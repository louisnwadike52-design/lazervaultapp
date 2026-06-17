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
      // Prefer the structured BuyError attached to status details
      // (server emits via grpcstatus.WithDetails). Falls back to the
      // legacy substring branch only if the server didn't attach one
      // (older deploy, gateway stripped it, etc.) — that path stays
      // for backward compat but should be unreachable post-rollout.
      final structured = _readBuyError(e);
      if (structured != null) {
        throw Exception(_messageFor(structured));
      }
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

  /// Pulls the typed BuyError out of the gRPC status details list, if
  /// the server attached one. Returns null when not present (older
  /// build, no details on the wire).
  pb.BuyError? _readBuyError(GrpcError e) {
    final details = e.details;
    if (details == null) return null;
    for (final d in details) {
      if (d is pb.BuyError) return d;
    }
    return null;
  }

  /// Maps a structured BuyError to user-facing copy. The server's
  /// English `message` is the fallback — but we override per code so
  /// the wording stays consistent regardless of upstream changes.
  String _messageFor(pb.BuyError err) {
    switch (err.code) {
      case pb.BuyErrorCode.BUY_ERROR_INSUFFICIENT_FUNDS:
        return 'Insufficient funds for purchase';
      case pb.BuyErrorCode.BUY_ERROR_PROVIDER_WALLET_LOW:
        return 'This gift card is temporarily unavailable. Please try again shortly.';
      case pb.BuyErrorCode.BUY_ERROR_INVALID_AMOUNT:
        return 'Invalid amount for this gift card. Please check the price and try again.';
      case pb.BuyErrorCode.BUY_ERROR_PROVIDER_BUSY:
        return 'Gift card service is temporarily busy. Please try again in a moment.';
      case pb.BuyErrorCode.BUY_ERROR_PROVIDER_MISMATCH:
        return 'Gift card catalog has been updated. Please browse brands again and try your purchase.';
      case pb.BuyErrorCode.BUY_ERROR_OUT_OF_STOCK:
        return 'This gift card is currently sold out. Please try a different card.';
      case pb.BuyErrorCode.BUY_ERROR_PRODUCT_UNAVAILABLE:
        return 'This gift card is temporarily unavailable. Please try again later.';
      case pb.BuyErrorCode.BUY_ERROR_DUPLICATE_ORDER:
        return 'This order is already being processed.';
      case pb.BuyErrorCode.BUY_ERROR_RATE_LIMITED:
        return 'Too many purchase attempts. Please wait a moment and try again.';
      case pb.BuyErrorCode.BUY_ERROR_SELF_SEND:
        return 'You cannot send a gift card to your own email. Choose a different recipient.';
      case pb.BuyErrorCode.BUY_ERROR_ACCOUNT_NOT_ACTIVE:
        return 'Your account is not active. Contact support to resolve.';
      case pb.BuyErrorCode.BUY_ERROR_SPENDING_LIMIT:
        return 'Spending limit exceeded. Try a smaller amount or wait until your limit resets.';
      default:
        return err.message.isNotEmpty
            ? err.message
            : 'Gift card purchase failed. Please try again.';
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
  Future<List<PayoutMethodEntity>> getPayoutMethods() async {
    try {
      final options = await grpcClient.callOptions;
      final response = await grpcClient.giftCardClient.getPayoutMethods(
        pb.GetPayoutMethodsRequest(),
        options: options,
      );
      return response.methods
          .map((m) => PayoutMethodEntity(
                name: m.name,
                currency: m.currency,
                available: m.available,
              ))
          .toList();
    } on GrpcError catch (e) {
      throw Exception('Failed to fetch payout methods: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error fetching payout methods: $e');
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
    String? payoutMethod,
    String? form,
    String? subcategoryId,
    String? cardCode,
    bool disclaimerAccepted = false,
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
        // currency here is the card's face-value currency (e.g. USD).
        // Payout currency is selected via payoutMethod (e.g. NAIRA).
        currency: currency ?? '',
        idempotencyKey: idempotencyKey ?? '',
        providerName: providerName ?? '',
        cardCountry: cardCountry ?? '',
        cardFormat: cardFormat ?? '',
        ocrBrand: ocrBrand ?? '',
        ocrCardNumber: ocrCardNumber ?? '',
        ocrPin: ocrPin ?? '',
        ocrDenomination: ocrDenomination ?? 0,
        ocrCurrency: ocrCurrency ?? '',
        // Doc-aligned Prestmit fields per documentation.prestmit.io.
        subcategoryId: subcategoryId ?? '',
        form: form ?? '',
        payoutMethod: payoutMethod ?? '',
        cardCode: cardCode ?? '',
        disclaimerAccepted: disclaimerAccepted,
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
