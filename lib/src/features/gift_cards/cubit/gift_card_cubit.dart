import 'dart:convert';
import 'dart:typed_data';

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

  // Pagination state for brands
  List<GiftCardBrand> _accumulatedBrands = [];
  int _currentPage = 0;
  bool _hasNextPage = false;
  int _totalPages = 1;

  /// Whether more pages are available (for search results infinite scroll)
  bool get hasNextPage => _hasNextPage;
  String? _lastCountryCode;
  String? _lastCategory;

  GiftCardCubit({
    required IGiftCardRepository repository,
    required SWRCacheManager cacheManager,
    required MutationQueue mutationQueue,
  })  : _repository = repository,
        _cacheManager = cacheManager,
        _mutationQueue = mutationQueue,
        super(GiftCardInitial());

  String? _lastSearchQuery;

  Future<void> loadGiftCardBrands({
    String? countryCode,
    String? category,
    String? searchQuery,
    int page = 0,
    int pageSize = 20,
  }) async {
    try {
      if (isClosed) return;

      final isLoadMore = page > 0;

      if (!isLoadMore) {
        _accumulatedBrands = [];
        _currentPage = 0;
        emit(GiftCardBrandsLoading());
      } else {
        emit(GiftCardBrandsLoadingMore(_accumulatedBrands));
      }

      _lastCountryCode = countryCode;
      _lastCategory = category;
      _lastSearchQuery = searchQuery;

      final result = await _repository.getGiftCardBrands(
        category: category,
        countryCode: countryCode,
        searchQuery: searchQuery,
        page: page,
        pageSize: pageSize,
      );

      if (isClosed) return;

      result.fold(
        (failure) {
          final msg = failure.message;
          if (msg.contains('timed out') || msg.contains('TimeoutException')) {
            emit(GiftCardTimeoutError(operation: 'Loading brands'));
          } else if (msg.contains('unavailable') || msg.contains('UNAVAILABLE')) {
            emit(GiftCardServerUnavailable(operation: 'Loading brands'));
          } else {
            emit(GiftCardNetworkError(
              message: msg,
              canRetry: true,
              operation: 'Loading brands',
            ));
          }
        },
        (paginated) {
          if (isLoadMore) {
            _accumulatedBrands = [..._accumulatedBrands, ...paginated.brands];
          } else {
            _accumulatedBrands = [...paginated.brands];
          }
          _currentPage = paginated.currentPage;
          _hasNextPage = paginated.hasNext;
          _totalPages = paginated.totalPages;

          if (_accumulatedBrands.isEmpty) {
            emit(GiftCardBrandsEmpty(category: category));
          } else {
            emit(GiftCardBrandsLoaded(
              _accumulatedBrands,
              selectedCategory: category,
              currentPage: _currentPage,
              totalPages: _totalPages,
              hasNext: _hasNextPage,
            ));
          }
        },
      );
    } catch (e) {
      if (isClosed) return;
      emit(GiftCardNetworkError(
        message: e.toString(),
        canRetry: true,
        operation: 'Loading brands',
      ));
    }
  }

  bool _isLoadingMore = false;

  /// Load more brands for infinite scroll pagination
  Future<void> loadMoreBrands() async {
    if (!_hasNextPage || _isLoadingMore) return;
    _isLoadingMore = true;
    try {
      await loadGiftCardBrands(
        countryCode: _lastCountryCode,
        category: _lastCategory,
        searchQuery: _lastSearchQuery,
        page: _currentPage + 1,
      );
    } finally {
      _isLoadingMore = false;
    }
  }

  /// Load countries supported for gift cards
  Future<void> loadSupportedCountries() async {
    try {
      final result = await _repository.getSupportedCountries();
      if (isClosed) return;
      result.fold(
        (failure) => null, // Silently fail - countries selector has fallback
        (countries) => emit(SupportedCountriesLoaded(countries)),
      );
    } catch (_) {
      // Silently fail - UI will use fallback
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
        // Clear search — reload brands for current country
        await loadGiftCardBrands(
          countryCode: countryCode ?? _lastCountryCode,
          category: _lastCategory,
        );
        return;
      }

      if (isClosed) return;
      emit(GiftCardBrandsLoading());

      // Server-side search via Reloadly /products?productName=query
      final result = await _repository.getGiftCardBrands(
        countryCode: countryCode ?? _lastCountryCode,
        searchQuery: query.trim(),
        page: 0,
        pageSize: 20,
      );
      if (isClosed) return;

      result.fold(
        (failure) => emit(GiftCardNetworkError(
          message: failure.message,
          canRetry: true,
          operation: 'Searching brands',
        )),
        (paginated) {
          _accumulatedBrands = [...paginated.brands];
          _currentPage = paginated.currentPage;
          _hasNextPage = paginated.hasNext;
          _totalPages = paginated.totalPages;
          _lastSearchQuery = query.trim();

          if (paginated.brands.isEmpty) {
            emit(GiftCardBrandsEmpty(searchQuery: query));
          } else {
            emit(GiftCardBrandsSearched(paginated.brands, query));
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
    double? senderAmount,
    String? senderCurrency,
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
        senderAmount: senderAmount,
        senderCurrency: senderCurrency,
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
          final msg = failure.message;
          if (msg.contains('Insufficient funds')) {
            emit(GiftCardInsufficientFunds(
              required: amount,
              available: userBalance,
              brandName: brand.name,
            ));
          } else if (msg.contains('not found')) {
            emit(GiftCardNotFound(
              identifier: brandId,
              type: 'brand',
            ));
          } else if (msg.contains('sold out')) {
            emit(GiftCardSoldOut(
              brandId: brandId,
              brandName: brand.name,
            ));
          } else if (msg.contains('temporarily unavailable')) {
            emit(GiftCardPurchaseError(
              '${brand.name} is temporarily unavailable. Please try again shortly.',
            ));
          } else if (msg.contains('already being processed')) {
            emit(GiftCardPurchaseError(
              'This order is already being processed. Check your gift cards.',
            ));
          } else {
            emit(GiftCardPurchaseError(msg));
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

  /// Get the merchant redeem code for a purchased gift card (fetches from provider)
  Future<void> getRedeemCode({
    required String transactionId,
    bool forceRefresh = false,
  }) async {
    try {
      if (isClosed) return;
      emit(GiftCardRedeeming());

      final result = await _repository.getRedeemCode(
        transactionId: transactionId,
        forceRefresh: forceRefresh,
      );
      if (isClosed) return;

      result.fold(
        (failure) {
          if (failure.message.contains('not found')) {
            emit(const GiftCardRedeemError('Gift card not found'));
          } else if (failure.message.contains('unauthorized')) {
            emit(const GiftCardRedeemError('You can only view your own gift cards'));
          } else {
            emit(GiftCardRedeemError(failure.message));
          }
        },
        (data) {
          emit(RedeemCodeLoaded(
            redemptionCode: data['redemptionCode'] ?? '',
            redemptionPin: data['redemptionPin'] ?? '',
            transactionId: data['transactionId'] ?? '',
            status: data['status'] ?? 'unavailable',
            message: data['message'] ?? '',
          ));
        },
      );
    } catch (e) {
      if (isClosed) return;
      emit(GiftCardRedeemError(e.toString()));
    }
  }

  /// Transfer a gift card to another user (platform or email)
  Future<void> transferGiftCard({
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
      if (isClosed) return;

      // Pre-validate inputs
      if (giftCardId.isEmpty) {
        emit(const GiftCardTransferError('Gift card ID is missing'));
        return;
      }

      if (transferType == 'platform') {
        if (recipientUserId == null || recipientUserId.isEmpty) {
          emit(const GiftCardTransferError('Recipient user is required'));
          return;
        }
      } else {
        if (recipientEmail.isEmpty || !_isValidEmail(recipientEmail)) {
          emit(const GiftCardTransferError('Please enter a valid email address'));
          return;
        }
      }

      if (recipientName.trim().isEmpty) {
        emit(const GiftCardTransferError('Recipient name is required'));
        return;
      }

      emit(GiftCardTransferring());

      final result = await _repository.transferGiftCard(
        giftCardId: giftCardId,
        recipientEmail: recipientEmail,
        recipientName: recipientName,
        message: message,
        transactionId: transactionId,
        verificationToken: verificationToken,
        recipientUserId: recipientUserId,
        transferType: transferType,
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
          } else if (failure.message.contains('cannot transfer gift card to yourself')) {
            emit(const GiftCardTransferError('You cannot transfer a gift card to yourself'));
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
        } else if (result.error != null) {
          final errorMsg = result.error.toString();
          if (errorMsg.contains('timed out') || errorMsg.contains('TimeoutException')) {
            emit(GiftCardTimeoutError(operation: 'Loading your gift cards'));
          } else if (errorMsg.contains('unavailable') || errorMsg.contains('UNAVAILABLE')) {
            emit(GiftCardServerUnavailable(operation: 'Loading your gift cards'));
          } else {
            emit(GiftCardNetworkError(
              message: errorMsg,
              canRetry: true,
              operation: 'Loading your gift cards',
            ));
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

  Future<void> loadSellableCards({String? countryCode}) async {
    try {
      if (isClosed) return;
      emit(SellableCardsLoading());

      final result = await _repository.getSellableCards(countryCode: countryCode);
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

  /// Loads the active sell-provider's payout methods. Sourced server-side
  /// from Prestmit's rate-calculator-data.sellGiftcardPayoutMethods,
  /// pre-filtered to available==true. The returned list drives the
  /// payout-method picker step on the sell flow.
  Future<void> loadPayoutMethods() async {
    try {
      if (isClosed) return;
      emit(const PayoutMethodsLoading());

      final result = await _repository.getPayoutMethods();
      if (isClosed) return;

      result.fold(
        (failure) => emit(PayoutMethodsError(failure.message)),
        (methods) {
          if (methods.isEmpty) {
            emit(const PayoutMethodsError(
              'No payout methods available. Try again in a moment.',
            ));
          } else {
            emit(PayoutMethodsLoaded(methods));
          }
        },
      );
    } catch (e) {
      if (isClosed) return;
      emit(PayoutMethodsError(e.toString()));
    }
  }

  Future<void> sellGiftCard({
    required String cardType,
    required String cardNumber,
    required String cardPin,
    required double denomination,
    required String transactionId,
    required String verificationToken,
    /// Doc-aligned Prestmit `payoutMethod` (e.g. "NAIRA"). When empty
    /// the backend resolves from system_settings.default_payout_method.
    String? payoutMethod,
    /// Doc-aligned Prestmit `form`: "Physical" or "Ecode". Drives the
    /// multipart shape backend-side.
    String? form,
    /// Doc-aligned Prestmit `giftcard_id` (subcategory). When empty
    /// the backend falls back to cardType.
    String? subcategoryId,
    /// Explicit Ecode value (replaces card_number when both are set).
    String? cardCode,
    /// MUST be true. The backend rejects with FailedPrecondition
    /// otherwise; the legal/UX safety net for the sell flow.
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
    // Backend gate: explicit acceptance required. Mirror it client-side
    // so we can give immediate UX feedback without a round-trip.
    if (!disclaimerAccepted) {
      if (isClosed) return;
      emit(const SellDisclaimerNotAccepted());
      return;
    }
    try {
      // Generate idempotency key if not provided
      final effectiveIdempotencyKey = idempotencyKey ?? generateSellIdempotencyKey(cardType);

      if (isClosed) return;
      emit(SellProcessing(
        cardType: cardType,
        denomination: denomination,
        currentStep: 'Submitting to Prestmit…',
        progress: 0.5,
      ));

      final result = await _repository.sellGiftCard(
        cardType: cardType,
        cardNumber: cardNumber,
        cardPin: cardPin,
        denomination: denomination,
        transactionId: transactionId,
        verificationToken: verificationToken,
        payoutMethod: payoutMethod,
        form: form,
        subcategoryId: subcategoryId,
        cardCode: cardCode,
        disclaimerAccepted: disclaimerAccepted,
        currency: currency,
        images: images,
        idempotencyKey: effectiveIdempotencyKey,
        providerName: providerName,
        cardCountry: cardCountry,
        cardFormat: cardFormat,
        imageUrls: imageUrls,
        imageKeys: imageKeys,
        ocrBrand: ocrBrand,
        ocrCardNumber: ocrCardNumber,
        ocrPin: ocrPin,
        ocrDenomination: ocrDenomination,
        ocrCurrency: ocrCurrency,
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
        } else if (result.error != null) {
          final errorMsg = result.error.toString();
          if (errorMsg.contains('timed out') || errorMsg.contains('TimeoutException')) {
            emit(GiftCardTimeoutError(operation: 'Loading your sales'));
          } else if (errorMsg.contains('unavailable') || errorMsg.contains('UNAVAILABLE')) {
            emit(GiftCardServerUnavailable(operation: 'Loading your sales'));
          } else {
            emit(GiftCardNetworkError(
              message: errorMsg,
              canRetry: true,
              operation: 'Loading your sales',
            ));
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

  Future<void> loadSettlementHistory() async {
    try {
      if (isClosed) return;
      emit(GiftCardLoading());

      final result = await _repository.getSettlementHistory();
      if (isClosed) return;

      result.fold(
        (failure) => emit(GiftCardNetworkError(
          message: failure.message,
          canRetry: true,
          operation: 'Loading settlement history',
        )),
        (settlements) {
          if (settlements.isEmpty) {
            emit(const SettlementHistoryLoaded([]));
          } else {
            emit(SettlementHistoryLoaded(settlements));
          }
        },
      );
    } catch (e) {
      if (isClosed) return;
      emit(GiftCardNetworkError(
        message: e.toString(),
        canRetry: true,
        operation: 'Loading settlement history',
      ));
    }
  }

  // ============================================
  // IMAGE UPLOAD & OCR METHODS
  // ============================================

  Future<void> uploadSellImage({required Uint8List imageBytes, required String filename}) async {
    try {
      if (isClosed) return;
      emit(SellImageUploading());
      final base64Data = base64Encode(imageBytes);
      final contentType = filename.endsWith('.png') ? 'image/png' : 'image/jpeg';
      final result = await _repository.uploadSellImage(
        imageData: base64Data,
        contentType: contentType,
        filename: filename,
      );
      if (isClosed) return;
      result.fold(
        (failure) => emit(SellImageError(failure.message)),
        (data) => emit(SellImageUploaded(imageUrl: data['imageUrl']!, imageKey: data['imageKey']!)),
      );
    } catch (e) {
      if (isClosed) return;
      emit(SellImageError(e.toString()));
    }
  }

  Future<void> extractCardDetails({required List<String> imageUrls}) async {
    try {
      if (isClosed) return;
      emit(OCRExtracting());
      final result = await _repository.extractCardDetails(imageUrls: imageUrls);
      if (isClosed) return;
      result.fold(
        (failure) => emit(OCRFailed(failure.message)),
        (data) => emit(OCRExtracted(
          brand: data['brand'] ?? '',
          cardNumber: data['cardNumber'] ?? '',
          pin: data['pin'] ?? '',
          denomination: (data['denomination'] as num?)?.toDouble() ?? 0.0,
          currency: data['currency'] ?? '',
          confidence: (data['confidence'] as num?)?.toDouble() ?? 0.0,
          rawText: data['rawText'] ?? '',
        )),
      );
    } catch (e) {
      if (isClosed) return;
      emit(OCRFailed(e.toString()));
    }
  }

  static bool _isValidEmail(String email) {
    final regex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return regex.hasMatch(email);
  }

  // Get active sell provider (admin only - returns default for now)
  Future<void> getSellProvider() async {
    try {
      emit(SellProviderLoading());
      // TODO: Implement actual provider fetching from backend
      // For now, return a default value
      emit(const SellProviderLoaded(
        provider: 'manual',
        description: 'Manual review mode',
      ));
    } catch (e) {
      if (isClosed) return;
      emit(SellProviderError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _searchDebouncer.cancel();
    _searchDebouncer.dispose();
    return super.close();
  }
}
