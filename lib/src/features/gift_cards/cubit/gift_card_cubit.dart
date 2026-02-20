import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grpc/grpc.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/cache/cache_config.dart';
import '../../../../core/cache/swr_cache_manager.dart';
import '../../../../core/offline/mutation_queue.dart';
import '../../../../core/utils/debouncer.dart';
import '../domain/entities/gift_card_entity.dart';
import '../domain/repositories/i_gift_card_repository.dart';
import '../domain/validation/gift_card_validation.dart';
import 'gift_card_state.dart';

class GiftCardCubit extends Cubit<GiftCardState> {
  final IGiftCardRepository _repository;
  final SWRCacheManager _cacheManager;
  final MutationQueue _mutationQueue;
  final Debouncer _searchDebouncer = Debouncer.search();

  GiftCardCubit({
    required IGiftCardRepository repository,
    required SWRCacheManager cacheManager,
    required MutationQueue mutationQueue,
  })  : _repository = repository,
        _cacheManager = cacheManager,
        _mutationQueue = mutationQueue,
        super(GiftCardInitial());

  Future<void> loadGiftCardBrands({String? countryCode, String? category}) async {
    try {
      if (isClosed) return;
      emit(GiftCardBrandsLoading());

      final cacheKey = 'gift_card_brands_${countryCode ?? 'all'}_${category ?? 'all'}';

      await for (final result in _cacheManager.get<List<GiftCardBrand>>(
        key: cacheKey,
        fetcher: () async {
          final r = await _repository.getGiftCardBrands(
            category: category,
            countryCode: countryCode,
          );
          return r.fold(
            (failure) => throw Exception(failure.message),
            (brands) => brands,
          );
        },
        config: CacheConfig.giftCardBrands,
        serializer: (brands) => jsonEncode(brands.map((b) => b.toJson()).toList()),
        deserializer: (json) {
          final list = jsonDecode(json) as List;
          return list.map((j) => GiftCardBrand.fromJson(j as Map<String, dynamic>)).toList();
        },
      )) {
        if (isClosed) return;
        if (result.data != null) {
          final brands = result.data!;
          if (brands.isEmpty) {
            emit(GiftCardBrandsEmpty(category: category));
          } else {
            emit(GiftCardBrandsLoaded(brands, selectedCategory: category, isStale: result.isStale));
          }
        }
      }
    } catch (e) {
      if (isClosed) return;
      emit(GiftCardNetworkError(
        message: e.toString(),
        canRetry: true,
        operation: 'Loading brands',
      ));
    }
  }

  void searchGiftCardBrandsDebounced(String query, {String? countryCode}) {
    if (query.trim().isEmpty) {
      return;
    }
    _searchDebouncer.run(() => searchGiftCardBrands(query, countryCode: countryCode));
  }

  Future<void> searchGiftCardBrands(String query, {String? countryCode}) async {
    try {
      if (query.trim().isEmpty) {
        if (isClosed) return;
        emit(const GiftCardValidationError(
          message: 'Search query cannot be empty',
          field: 'query',
        ));
        return;
      }

      if (isClosed) return;
      emit(GiftCardBrandsLoading());

      // Use getGiftCardBrands and filter client-side for search
      final result = await _repository.getGiftCardBrands(
        countryCode: countryCode,
      );
      if (isClosed) return;

      result.fold(
        (failure) => emit(GiftCardNetworkError(
          message: failure.message,
          canRetry: true,
          operation: 'Searching brands',
        )),
        (brands) {
          final lowerQuery = query.toLowerCase();
          final filtered = brands
              .where((b) =>
                  b.name.toLowerCase().contains(lowerQuery) ||
                  b.description.toLowerCase().contains(lowerQuery) ||
                  b.category.toLowerCase().contains(lowerQuery))
              .toList();
          if (filtered.isEmpty) {
            emit(GiftCardBrandsEmpty(searchQuery: query));
          } else {
            emit(GiftCardBrandsSearched(filtered, query));
          }
        },
      );
    } catch (e) {
      if (isClosed) return;
      emit(GiftCardNetworkError(
        message: e.toString(),
        canRetry: true,
        operation: 'Searching brands',
      ));
    }
  }

  /// Generate an idempotency key for gift card purchases.
  /// Format: gc-purchase-{brandId short}-{uuid}
  static String generateIdempotencyKey(String brandId) {
    final shortBrand = brandId.length > 8 ? brandId.substring(0, 8) : brandId;
    return 'gc-purchase-$shortBrand-${const Uuid().v4()}';
  }

  /// Generate an idempotency key for gift card sell operations.
  static String generateSellIdempotencyKey(String cardType) {
    return 'gc-sell-$cardType-${const Uuid().v4()}';
  }

  /// Purchase gift card with verification token (PIN-validated transaction)
  Future<void> purchaseGiftCardWithToken({
    required String brandId,
    required double amount,
    required GiftCardBrand brand,
    required double userBalance,
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
  }) async {
    try {
      // Validate purchase request before processing
      final validation = GiftCardValidation.validatePurchaseRequest(
        amount: amount,
        brand: brand,
        currency: brand.currencyCode.isNotEmpty ? brand.currencyCode : 'NGN',
        userBalance: userBalance,
        recipientEmail: recipientEmail,
        recipientName: recipientName,
        message: giftMessage,
      );

      if (validation.isLeft()) {
        if (isClosed) return;
        final error = validation.fold(
          (l) => l,
          (r) => const GeneralValidationError('Validation failed'),
        );
        emit(GiftCardValidationError(
          message: GiftCardValidation.getErrorMessage(error),
          field: error.field ?? 'unknown',
        ));
        return;
      }

      // Generate idempotency key if not provided
      final effectiveIdempotencyKey = idempotencyKey ?? generateIdempotencyKey(brandId);

      // Step 1: Validating (10%)
      if (isClosed) return;
      emit(GiftCardPurchaseProcessing(
        brandId: brandId,
        amount: amount,
        currentStep: 'Validating purchase...',
        progress: 0.1,
      ));

      // Step 2: Debiting (30%)
      if (isClosed) return;
      emit(GiftCardPurchaseProcessing(
        brandId: brandId,
        amount: amount,
        currentStep: 'Debiting your account...',
        progress: 0.3,
      ));

      // Step 3: Purchasing (60%)
      if (isClosed) return;
      emit(GiftCardPurchaseProcessing(
        brandId: brandId,
        amount: amount,
        currentStep: 'Purchasing gift card...',
        progress: 0.6,
      ));

      // Make the actual purchase
      final result = await _repository.buyGiftCard(
        brandId: brandId,
        amount: amount,
        transactionId: transactionId,
        verificationToken: verificationToken,
        productId: productId,
        recipientEmail: recipientEmail,
        recipientName: recipientName,
        giftMessage: giftMessage,
        senderName: senderName,
        recipientPhone: recipientPhone,
        countryCode: countryCode,
        idempotencyKey: effectiveIdempotencyKey,
        quantity: quantity,
        providerName: providerName,
      );
      if (isClosed) return;

      result.fold(
        (failure) {
          // Provider mismatch error - user should refresh brands
          if (failure.message.contains('Provider mismatch') ||
              failure.message.contains('provider mismatch')) {
            emit(GiftCardPurchaseError(
              'Gift card catalog has been updated. Please go back and browse brands again, then retry your purchase.',
            ));
            return;
          }
          if (failure.message.contains('Insufficient funds')) {
            emit(GiftCardInsufficientFunds(
              required: amount,
              available: userBalance,
              brandName: brand.name,
            ));
          } else if (failure.message.contains('not found')) {
            emit(GiftCardNotFound(
              identifier: brandId,
              type: 'brand',
            ));
          } else if (failure.message.contains('unavailable')) {
            emit(GiftCardSoldOut(
              brandId: brandId,
              brandName: brand.name,
            ));
          } else {
            emit(GiftCardPurchaseError(failure.message));
          }
        },
        (giftCard) async {
          // Step 4: Delivering (90%)
          if (isClosed) return;
          emit(GiftCardPurchaseProcessing(
            brandId: brandId,
            amount: amount,
            currentStep: 'Delivering your gift card...',
            progress: 0.9,
          ));
          await Future.delayed(const Duration(milliseconds: 300));
          if (isClosed) return;

          // Invalidate user's gift cards cache so next load gets fresh data
          _cacheManager.invalidate('my_gift_cards');

          // Complete
          emit(GiftCardPurchaseCompleted(
            giftCard: giftCard,
            transactionId: giftCard.providerTransactionId,
          ));
        },
      );
    } catch (e) {
      if (isClosed) return;
      emit(GiftCardPurchaseError(e.toString()));
    }
  }

  /// Redeem a gift card — credits the card balance to the user's account
  Future<void> redeemGiftCard({
    required String accountId,
    required String cardNumber,
    required String cardPin,
  }) async {
    try {
      if (isClosed) return;
      emit(GiftCardRedeeming());

      final result = await _repository.redeemGiftCard(
        accountId: accountId,
        cardNumber: cardNumber,
        cardPin: cardPin,
      );
      if (isClosed) return;

      result.fold(
        (failure) {
          if (failure.message.contains('not found')) {
            emit(const GiftCardRedeemError('Gift card not found'));
          } else if (failure.message.contains('invalid PIN') ||
              failure.message.contains('Invalid PIN')) {
            emit(const GiftCardRedeemError('Invalid PIN'));
          } else if (failure.message.contains('not active')) {
            emit(const GiftCardRedeemError('This gift card is no longer active'));
          } else if (failure.message.contains('zero balance')) {
            emit(const GiftCardRedeemError('This gift card has no remaining balance'));
          } else if (failure.message.contains('expired')) {
            emit(const GiftCardRedeemError('This gift card has expired'));
          } else {
            emit(GiftCardRedeemError(failure.message));
          }
        },
        (giftCard) {
          // Invalidate cache after redemption
          _cacheManager.invalidate('my_gift_cards');

          emit(GiftCardRedeemed(
            giftCard: giftCard,
            amountRedeemed: giftCard.currentBalance,
          ));
        },
      );
    } catch (e) {
      if (isClosed) return;
      emit(GiftCardRedeemError(e.toString()));
    }
  }

  /// Transfer a gift card to another user
  Future<void> transferGiftCard({
    required String giftCardId,
    required String recipientEmail,
    required String recipientName,
    required String message,
    required String transactionId,
    required String verificationToken,
  }) async {
    try {
      if (isClosed) return;
      emit(GiftCardTransferring());

      final result = await _repository.transferGiftCard(
        giftCardId: giftCardId,
        recipientEmail: recipientEmail,
        recipientName: recipientName,
        message: message,
        transactionId: transactionId,
        verificationToken: verificationToken,
      );
      if (isClosed) return;

      result.fold(
        (failure) {
          if (failure.message.contains('Invalid transaction PIN')) {
            emit(const GiftCardTransferError('Invalid transaction PIN'));
          } else if (failure.message.contains('not found')) {
            emit(const GiftCardTransferError('Gift card not found'));
          } else if (failure.message.contains('not active') ||
              failure.message.contains('only transfer active')) {
            emit(const GiftCardTransferError('Only active gift cards can be transferred'));
          } else {
            emit(GiftCardTransferError(failure.message));
          }
        },
        (giftCard) {
          // Invalidate cache after transfer
          _cacheManager.invalidate('my_gift_cards');

          emit(GiftCardTransferred(giftCard: giftCard));
        },
      );
    } catch (e) {
      if (isClosed) return;
      emit(GiftCardTransferError(e.toString()));
    }
  }

  /// Check the balance of a gift card by card number and PIN
  Future<void> checkGiftCardBalance({
    required String cardNumber,
    required String cardPin,
  }) async {
    try {
      if (isClosed) return;
      emit(GiftCardBalanceLoading());

      final result = await _repository.getGiftCardBalance(
        cardNumber: cardNumber,
        cardPin: cardPin,
      );
      if (isClosed) return;

      result.fold(
        (failure) {
          if (failure.message.contains('not found')) {
            emit(const GiftCardBalanceError('Gift card not found'));
          } else if (failure.message.contains('Invalid') ||
              failure.message.contains('invalid')) {
            emit(const GiftCardBalanceError('Invalid card number or PIN'));
          } else {
            emit(GiftCardBalanceError(failure.message));
          }
        },
        (balance) => emit(GiftCardBalanceLoaded(
          balance: balance.balance,
          brandName: balance.brandName,
          expiryDate: balance.expiryDate,
          status: balance.status,
        )),
      );
    } catch (e) {
      if (isClosed) return;
      emit(GiftCardBalanceError(e.toString()));
    }
  }

  void resetState() {
    if (isClosed) return;
    emit(GiftCardInitial());
  }

  Future<void> loadMyGiftCards({String? status, String? brandId}) async {
    try {
      if (isClosed) return;
      emit(GiftCardLoading());

      final cacheKey = 'my_gift_cards${status != null ? '_$status' : ''}${brandId != null ? '_$brandId' : ''}';

      await for (final result in _cacheManager.get<List<GiftCard>>(
        key: cacheKey,
        fetcher: () async {
          final r = await _repository.getUserGiftCards(
            status: status,
            brandId: brandId,
          );
          return r.fold(
            (failure) => throw Exception(failure.message),
            (cards) => cards,
          );
        },
        config: CacheConfig.giftCards,
        serializer: (cards) => jsonEncode(cards.map((c) => c.toJson()).toList()),
        deserializer: (json) {
          final list = jsonDecode(json) as List;
          return list.map((j) => GiftCard.fromJson(j as Map<String, dynamic>)).toList();
        },
      )) {
        if (isClosed) return;
        if (result.data != null) {
          final giftCards = result.data!;
          if (giftCards.isEmpty) {
            emit(const UserGiftCardsEmpty());
          } else {
            emit(MyGiftCardsLoaded(giftCards));
          }
        }
      }
    } catch (e) {
      if (isClosed) return;
      emit(GiftCardNetworkError(
        message: e.toString(),
        canRetry: true,
        operation: 'Loading your gift cards',
      ));
    }
  }

  Future<void> loadGiftCardDetails(String giftCardId) async {
    try {
      if (giftCardId.trim().isEmpty) {
        if (isClosed) return;
        emit(const GiftCardValidationError(
          message: 'Gift card ID cannot be empty',
          field: 'giftCardId',
        ));
        return;
      }

      if (isClosed) return;
      emit(GiftCardLoading());

      final result = await _repository.getGiftCardById(giftCardId);
      if (isClosed) return;

      result.fold(
        (failure) {
          if (failure.message.contains('not found')) {
            emit(GiftCardNotFound(identifier: giftCardId, type: 'card'));
          } else {
            emit(GiftCardNetworkError(
              message: failure.message,
              canRetry: true,
              operation: 'Loading gift card details',
            ));
          }
        },
        (giftCard) => emit(GiftCardDetailsLoaded(giftCard)),
      );
    } catch (e) {
      if (isClosed) return;
      emit(GiftCardNetworkError(
        message: e.toString(),
        canRetry: true,
        operation: 'Loading gift card details',
      ));
    }
  }

  // ============================================
  // SELL FLOW METHODS
  // ============================================

  Future<void> loadSellableCards() async {
    try {
      if (isClosed) return;
      emit(SellableCardsLoading());

      final result = await _repository.getSellableCards();
      if (isClosed) return;

      result.fold(
        (failure) => emit(GiftCardNetworkError(
          message: failure.message,
          canRetry: true,
          operation: 'Loading sellable cards',
        )),
        (cards) {
          if (cards.isEmpty) {
            emit(const SellableCardsEmpty());
          } else {
            emit(SellableCardsLoaded(cards));
          }
        },
      );
    } catch (e) {
      if (isClosed) return;
      emit(GiftCardNetworkError(
        message: e.toString(),
        canRetry: true,
        operation: 'Loading sellable cards',
      ));
    }
  }

  Future<void> getSellRate({
    required String cardType,
    required double denomination,
    String? currency,
  }) async {
    try {
      if (isClosed) return;
      emit(SellRateLoading());

      final result = await _repository.getSellRate(
        cardType: cardType,
        denomination: denomination,
        currency: currency,
      );
      if (isClosed) return;

      result.fold(
        (failure) => emit(SellError(failure.message)),
        (rate) => emit(SellRateLoaded(rate)),
      );
    } catch (e) {
      if (isClosed) return;
      emit(SellError(e.toString()));
    }
  }

  Future<void> sellGiftCard({
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
  }) async {
    try {
      // Generate idempotency key if not provided
      final effectiveIdempotencyKey = idempotencyKey ?? generateSellIdempotencyKey(cardType);

      if (isClosed) return;
      emit(SellProcessing(
        cardType: cardType,
        denomination: denomination,
        currentStep: 'Validating card details...',
        progress: 0.2,
      ));

      if (isClosed) return;
      emit(SellProcessing(
        cardType: cardType,
        denomination: denomination,
        currentStep: 'Submitting card for review...',
        progress: 0.5,
      ));

      final result = await _repository.sellGiftCard(
        cardType: cardType,
        cardNumber: cardNumber,
        cardPin: cardPin,
        denomination: denomination,
        transactionId: transactionId,
        verificationToken: verificationToken,
        currency: currency,
        images: images,
        idempotencyKey: effectiveIdempotencyKey,
        providerName: providerName,
      );
      if (isClosed) return;

      result.fold(
        (failure) {
          // Provider mismatch error - user should refresh sellable cards
          if (failure.message.contains('Provider mismatch') ||
              failure.message.contains('provider mismatch')) {
            emit(const SellError(
              'Sellable cards catalog has been updated. Please go back and check available card types again, then retry your sell.',
            ));
            return;
          }
          if (failure.message.contains('Invalid transaction PIN')) {
            emit(const SellError('Invalid transaction PIN'));
          } else if (failure.message.contains('unavailable')) {
            emit(const SellError('Sell service temporarily unavailable. Please try again later.'));
          } else {
            emit(SellError(failure.message));
          }
        },
        (sale) {
          emit(SellProcessing(
            cardType: cardType,
            denomination: denomination,
            currentStep: 'Card submitted successfully!',
            progress: 1.0,
          ));

          // Invalidate sales cache
          _cacheManager.invalidate('my_sales');

          emit(SellSubmitted(sale: sale));
        },
      );
    } on GrpcError catch (e) {
      if (isClosed) return;
      // Queue sell submission for retry when offline
      if (e.code == StatusCode.unavailable || e.code == StatusCode.deadlineExceeded) {
        await _mutationQueue.enqueueGiftCardSell(
          cardType: cardType,
          cardNumber: cardNumber,
          cardPin: cardPin,
          denomination: denomination,
          currency: currency,
          images: images,
          idempotencyKey: idempotencyKey,
        );
        emit(const SellQueued(message: 'Sell queued. Will submit when back online.'));
      } else {
        emit(SellError(e.message ?? e.toString()));
      }
    } catch (e) {
      if (isClosed) return;
      emit(SellError(e.toString()));
    }
  }

  Future<void> getSellStatus(String saleId) async {
    try {
      if (isClosed) return;
      emit(GiftCardLoading());

      final result = await _repository.getSellStatus(saleId);
      if (isClosed) return;

      result.fold(
        (failure) => emit(SellError(failure.message)),
        (sale) => emit(SellStatusLoaded(sale)),
      );
    } catch (e) {
      if (isClosed) return;
      emit(SellError(e.toString()));
    }
  }

  Future<void> loadMySales({String? status}) async {
    try {
      if (isClosed) return;
      emit(GiftCardLoading());

      final cacheKey = 'my_sales${status != null ? '_$status' : ''}';

      await for (final result in _cacheManager.get<List<GiftCardSale>>(
        key: cacheKey,
        fetcher: () async {
          final r = await _repository.getMySales(status: status);
          return r.fold(
            (failure) => throw Exception(failure.message),
            (sales) => sales,
          );
        },
        config: CacheConfig.giftCardSales,
        serializer: (sales) => jsonEncode(sales.map((s) => s.toJson()).toList()),
        deserializer: (json) {
          final list = jsonDecode(json) as List;
          return list.map((j) => GiftCardSale.fromJson(j as Map<String, dynamic>)).toList();
        },
      )) {
        if (isClosed) return;
        if (result.data != null) {
          final sales = result.data!;
          if (sales.isEmpty) {
            emit(const MySalesEmpty());
          } else {
            emit(MySalesLoaded(sales));
          }
        }
      }
    } catch (e) {
      if (isClosed) return;
      emit(GiftCardNetworkError(
        message: e.toString(),
        canRetry: true,
        operation: 'Loading your sales',
      ));
    }
  }

  Future<void> loadGiftCardHistory({
    String? giftCardId,
    String? transactionType,
  }) async {
    try {
      if (isClosed) return;
      emit(GiftCardLoading());

      final result = await _repository.getGiftCardHistory(
        giftCardId: giftCardId,
        transactionType: transactionType,
      );
      if (isClosed) return;

      result.fold(
        (failure) => emit(GiftCardNetworkError(
          message: failure.message,
          canRetry: true,
          operation: 'Loading transactions',
        )),
        (transactions) {
          if (transactions.isEmpty) {
            emit(const TransactionsEmpty());
          } else {
            emit(GiftCardTransactionsLoaded(transactions));
          }
        },
      );
    } catch (e) {
      if (isClosed) return;
      emit(GiftCardNetworkError(
        message: e.toString(),
        canRetry: true,
        operation: 'Loading transactions',
      ));
    }
  }

  @override
  Future<void> close() {
    _searchDebouncer.dispose();
    return super.close();
  }
}
