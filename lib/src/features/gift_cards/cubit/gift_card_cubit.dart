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

  /// Last-known-good brand list. Survives unrelated state transitions
  /// (purchase, redeem, transfer) so the buy tab can show its catalog
  /// instead of an infinite shimmer when the cubit is on any non-brand
  /// state. Returns an empty list before the first successful load.
  List<GiftCardBrand> get cachedBrands => List.unmodifiable(_accumulatedBrands);
  String? _lastCountryCode;
  String? _lastCategory;

  // Sellable-cards cache. Same shape as [_accumulatedBrands]: lets the sell
  // tab render its grid immediately on re-entry / revalidation instead of
  // flashing a loading state and then re-rendering items. The cubit only
  // emits [SellableCardsLoading] on the *first* load (no cache yet) — once
  // we have data, subsequent loads run silently and re-emit
  // [SellableCardsLoaded] when the network response lands. Per-country.
  List<SellableCard> _accumulatedSellableCards = [];
  String? _lastSellCountryCode;
  List<SellableCard> get cachedSellableCards =>
      List.unmodifiable(_accumulatedSellableCards);

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

      // Stale-while-revalidate: on a fresh (non-paginated) load with
      // the SAME filters as the cached set, keep the cached brands on
      // screen and refresh in the background. Only show the spinner
      // on:
      //   - the very first load (cache empty)
      //   - a filter change (country / category / search)
      //   - explicit pagination (page > 0)
      // Tab switches that re-call loadGiftCardBrands with identical
      // filters serve cache instantly with no loader flicker.
      final filtersUnchanged = countryCode == _lastCountryCode &&
          category == _lastCategory &&
          searchQuery == _lastSearchQuery;
      final hasCache = _accumulatedBrands.isNotEmpty;

      if (isLoadMore) {
        emit(GiftCardBrandsLoadingMore(_accumulatedBrands));
      } else if (hasCache && filtersUnchanged) {
        // Re-emit so a newly mounted listener (tab switch) sees the
        // cache immediately rather than the cubit's last unrelated
        // state. Network call below revalidates silently.
        emit(GiftCardBrandsLoaded(
          _accumulatedBrands,
          selectedCategory: category,
          currentPage: _currentPage,
          totalPages: _totalPages,
          hasNext: _hasNextPage,
        ));
      } else {
        // First load OR filter changed: clear cache + show loader.
        _accumulatedBrands = [];
        _currentPage = 0;
        emit(GiftCardBrandsLoading());
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
          // Revalidation-failure path: when we have cached brands on
          // screen, NEVER replace them with an error state. The user
          // keeps browsing what they had; we'll retry next tab switch.
          if (!isLoadMore && hasCache && filtersUnchanged) {
            return;
          }
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
      // Same defence as fold-failure: don't blast a cached UI with an
      // error state when we have something to show.
      final hasCache = _accumulatedBrands.isNotEmpty;
      if (page == 0 && hasCache) return;
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

      // Single honest "in-flight" state. The previous code emitted
      // four fake progress milestones (10%/30%/60%/90%) back-to-back
      // before the gRPC call even started — pure UI theatre that
      // misled users into thinking distinct steps were happening
      // when in reality everything was just one async round-trip.
      // The processing screen's progress bar now stays at the
      // in-flight level until the API actually returns Completed
      // or an error state.
      if (isClosed) return;
      emit(GiftCardPurchaseProcessing(
        brandId: brandId,
        amount: amount,
        currentStep: 'Processing your purchase…',
        progress: 0.5,
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
          if (isClosed) return;

          // Invalidate user's gift cards cache so next load gets fresh data
          _cacheManager.invalidate('my_gift_cards');

          // Async mode: backend returned the row before the provider
          // call completed (status != "available", no redemption code
          // yet). Stay on the processing screen — it listens on the
          // balance WebSocket for a `giftcard_purchase` event with a
          // matching reference and refetches the card on terminal
          // events. Sync mode skips this branch (status is already
          // "available" and the redemption code is populated).
          final isStillProcessing = giftCard.status != 'available' ||
              (giftCard.redemptionCode == null ||
                  giftCard.redemptionCode!.isEmpty);
          if (isStillProcessing) {
            emit(GiftCardPurchaseAwaitingProvider(
              giftCard: giftCard,
              reference: giftCard.providerTransactionId ?? brandId,
            ));
            return;
          }

          // Sync-mode happy path: receipt is fully ready.
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


  void resetState() {
    if (isClosed) return;
    emit(GiftCardInitial());
  }

  // Pagination accumulator for My Gift Cards. Reset on filter change or
  // pull-to-refresh. The accumulator + page tracker live on the cubit
  // (not in state) so loadMore() can append without reading them back
  // out of MyGiftCardsLoaded.
  static const int _myGiftCardsPageSize = 20;
  List<GiftCard> _myGiftCardsAccumulated = [];
  int _myGiftCardsPage = 0;
  bool _myGiftCardsHasMore = false;
  bool _myGiftCardsLoadingMore = false;
  String? _lastMyGiftCardsStatus;
  String? _lastMyGiftCardsBrandId;

  Future<void> loadMyGiftCards({String? status, String? brandId}) async {
    try {
      if (isClosed) return;
      emit(GiftCardLoading());

      // Reset pagination state — first page only.
      _myGiftCardsAccumulated = [];
      _myGiftCardsPage = 0;
      _myGiftCardsHasMore = false;
      _myGiftCardsLoadingMore = false;
      _lastMyGiftCardsStatus = status;
      _lastMyGiftCardsBrandId = brandId;

      // Skip cache when paginated — cached responses are page-0 only,
      // and merging cached page-0 with subsequent fetched pages risks
      // duplicates. Direct fetch keeps the page-0 source-of-truth on
      // the wire, with offset/limit driven by the cubit.
      final cards = await _repository
          .getUserGiftCards(
        status: status,
        brandId: brandId,
        limit: _myGiftCardsPageSize,
        offset: 0,
      )
          .then((r) => r.fold(
                (failure) => throw Exception(failure.message),
                (list) => list,
              ));

      if (isClosed) return;

      _myGiftCardsAccumulated = List.of(cards);
      _myGiftCardsPage = 1;
      // Pagination heuristic: a full page back means a next page may
      // exist. Repository signals end-of-list with a < pageSize page.
      _myGiftCardsHasMore = cards.length == _myGiftCardsPageSize;

      if (_myGiftCardsAccumulated.isEmpty) {
        emit(const UserGiftCardsEmpty());
      } else {
        emit(MyGiftCardsLoaded(
          List.unmodifiable(_myGiftCardsAccumulated),
          hasMore: _myGiftCardsHasMore,
        ));
      }
      return;
    } catch (e) {
      if (isClosed) return;
      final errorMsg = e.toString();
      if (errorMsg.contains('timed out') ||
          errorMsg.contains('TimeoutException')) {
        emit(GiftCardTimeoutError(operation: 'Loading your gift cards'));
        return;
      } else if (errorMsg.contains('unavailable') ||
          errorMsg.contains('UNAVAILABLE')) {
        emit(GiftCardServerUnavailable(operation: 'Loading your gift cards'));
        return;
      }
      emit(GiftCardNetworkError(
        message: errorMsg,
        canRetry: true,
        operation: 'Loading your gift cards',
      ));
    }
  }

  /// Load the next page of My Gift Cards on scroll-near-end. Bails
  /// when no more pages, when a load is already in flight, or when
  /// the cubit is in a non-loaded state. Emits the existing list
  /// with isLoadingMore=true while fetching, then re-emits with the
  /// appended page on success — no full-screen spinner.
  Future<void> loadMoreMyGiftCards() async {
    if (isClosed) return;
    if (_myGiftCardsLoadingMore) return;
    if (!_myGiftCardsHasMore) return;

    _myGiftCardsLoadingMore = true;
    emit(MyGiftCardsLoaded(
      List.unmodifiable(_myGiftCardsAccumulated),
      hasMore: _myGiftCardsHasMore,
      isLoadingMore: true,
    ));

    try {
      final cards = await _repository
          .getUserGiftCards(
        status: _lastMyGiftCardsStatus,
        brandId: _lastMyGiftCardsBrandId,
        limit: _myGiftCardsPageSize,
        offset: _myGiftCardsPage * _myGiftCardsPageSize,
      )
          .then((r) => r.fold(
                (failure) => throw Exception(failure.message),
                (list) => list,
              ));

      if (isClosed) return;
      _myGiftCardsLoadingMore = false;

      // Defensive de-dupe by id — if the backend returns rows that
      // already exist in the accumulator (race with a refresh), drop
      // them. Keeps the list monotonic.
      final existingIds = _myGiftCardsAccumulated.map((c) => c.id).toSet();
      final fresh =
          cards.where((c) => !existingIds.contains(c.id)).toList();

      _myGiftCardsAccumulated = [..._myGiftCardsAccumulated, ...fresh];
      _myGiftCardsPage++;
      _myGiftCardsHasMore = cards.length == _myGiftCardsPageSize;

      emit(MyGiftCardsLoaded(
        List.unmodifiable(_myGiftCardsAccumulated),
        hasMore: _myGiftCardsHasMore,
      ));
    } catch (e) {
      if (isClosed) return;
      _myGiftCardsLoadingMore = false;
      // Don't blow away the existing list on a load-more failure —
      // re-emit the current accumulator and surface the error via
      // a separate snackbar in the screen layer.
      emit(MyGiftCardsLoaded(
        List.unmodifiable(_myGiftCardsAccumulated),
        hasMore: _myGiftCardsHasMore,
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

  /// Pull-to-refresh / fetch-on-load variant for the details screen.
  /// Mirrors loadGiftCardDetails but skips the GiftCardLoading shimmer
  /// so the screen keeps showing the existing receipt while the
  /// network round-trip is in flight. Used during the async-buy
  /// awaiting-provider flow and on RefreshIndicator pull-down.
  Future<void> refreshGiftCardDetails(String giftCardId) async {
    try {
      if (giftCardId.trim().isEmpty || isClosed) return;
      final result = await _repository.getGiftCardById(giftCardId);
      if (isClosed) return;
      result.fold(
        (_) {
          // Silent failure — the screen keeps its current view.
          // RefreshIndicator's spinner naturally settles.
        },
        (giftCard) {
          // Treat "available + redemption code present" as terminal happy.
          // Treat "failed/refunded/manual_review" as terminal sad.
          // Otherwise stay awaiting so the screen keeps its loading affordance.
          final s = giftCard.status.toLowerCase();
          final hasCode =
              (giftCard.redemptionCode ?? '').trim().isNotEmpty;
          if (s == 'available' && hasCode) {
            emit(GiftCardPurchaseCompleted(
              giftCard: giftCard,
              transactionId: giftCard.providerTransactionId,
            ));
            return;
          }
          if (s == 'failed' || s == 'refunded') {
            emit(GiftCardPurchaseError(
              'The gift card purchase did not complete. Your funds will be returned.',
            ));
            return;
          }
          // Still in-flight: re-emit awaiting with the fresh row.
          emit(GiftCardPurchaseAwaitingProvider(
            giftCard: giftCard,
            reference: giftCard.providerTransactionId ?? giftCard.id,
          ));
        },
      );
    } catch (_) {
      // Network blip on a refresh is non-fatal; the screen retains its
      // existing state and the user can pull again.
    }
  }

  // ============================================
  // SELL FLOW METHODS
  // ============================================

  Future<void> loadSellableCards({String? countryCode}) async {
    try {
      if (isClosed) return;

      // Stale-while-revalidate: if we already have cached cards for this
      // country, keep them on screen and refresh silently. Only show the
      // loading spinner on the very first load, an explicit error retry,
      // or a country switch (where the cached set is for a different list).
      final sameCountry = countryCode == _lastSellCountryCode;
      final hasCache = _accumulatedSellableCards.isNotEmpty;
      if (hasCache && sameCountry) {
        // Re-emit so any newly mounted listener (tab switch) sees the cache
        // immediately rather than the cubit's last unrelated state.
        emit(SellableCardsLoaded(_accumulatedSellableCards));
      } else {
        emit(SellableCardsLoading());
      }

      _lastSellCountryCode = countryCode;

      final result = await _repository.getSellableCards(countryCode: countryCode);
      if (isClosed) return;

      result.fold(
        (failure) {
          // On revalidation failure, keep showing the cached grid so the
          // user is never punished for a transient network blip. Only
          // surface an error when there's nothing to show.
          if (_accumulatedSellableCards.isNotEmpty) return;
          emit(GiftCardNetworkError(
            message: failure.message,
            canRetry: true,
            operation: 'Loading sellable cards',
          ));
        },
        (cards) {
          _accumulatedSellableCards = List<SellableCard>.from(cards);
          if (cards.isEmpty) {
            emit(const SellableCardsEmpty());
          } else {
            emit(SellableCardsLoaded(cards));
          }
        },
      );
    } catch (e) {
      if (isClosed) return;
      if (_accumulatedSellableCards.isNotEmpty) return;
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

          // Branch on the sale row's status. The backend's response
          // shape encodes which downstream UX is correct; we don't
          // need to ask "what mode am I in?" client-side because
          // status already answers it:
          //   - paid / settled  → auto + (sync or async) terminal
          //                       success → receipt
          //   - rejected        → auto rejected → error screen
          //   - manual_review   → auto-escalated; same UX as the manual
          //                       queue (operator owns it)
          //   - pending_review  → manual provider path → "Submitted"
          //   - pending / reviewing → automated mode in flight; sit on
          //                       the processing screen with WebSocket
          //                       and refetch on terminal events.
          switch (sale.status) {
            case 'paid':
            case 'settled':
              emit(GiftCardSellPaid(sale));
              break;
            case 'rejected':
              emit(SellRejected(
                sale: sale,
                // Use the row's rejection_reason — populated by both
                // admin reject (operator-typed user-facing copy) and
                // Prestmit webhook reject (provider's reason). Falls
                // back to a generic message only when the server
                // omitted it (legacy build).
                reason: sale.rejectionReason.isNotEmpty
                    ? sale.rejectionReason
                    : 'Your sale was rejected. Please contact support if you need details.',
              ));
              break;
            case 'manual_review':
              emit(SellEscalatedToManualReview(sale));
              break;
            case 'pending':
            case 'reviewing':
              emit(GiftCardSellAwaitingProvider(
                sale: sale,
                reference: sale.reference,
              ));
              break;
            default:
              // pending_review (manual queue) and any unknown future
              // states fall back to the existing "submitted for
              // review" UX. Safe default.
              emit(SellSubmitted(sale: sale));
          }
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

  /// Re-fetch a sale row by id and emit the appropriate post-terminal
  /// state. Called by the sell processing screen when a `giftcard_sale`
  /// WebSocket event arrives matching the awaited reference, and as
  /// the pull-to-refresh fallback when the WS isn't available.
  ///
  /// Mirrors [refreshGiftCardDetails] for the buy flow but emits the
  /// sell-side terminal states (GiftCardSellPaid / SellRejected /
  /// SellEscalatedToManualReview) instead of buy ones.
  Future<void> refreshSaleDetails(String saleId) async {
    try {
      final result = await _repository.getSellStatus(saleId);
      if (isClosed) return;
      result.fold(
        (failure) {
          // Don't emit a hard error while the user sits on the
          // processing screen — they may simply have lost network
          // mid-poll. The screen will either retry on the next WS
          // tick or the user will pull-to-refresh.
        },
        (sale) {
          switch (sale.status) {
            case 'paid':
            case 'settled':
              emit(GiftCardSellPaid(sale));
              break;
            case 'rejected':
              emit(SellRejected(
                sale: sale,
                // Use the row's rejection_reason — populated by both
                // admin reject (operator-typed user-facing copy) and
                // Prestmit webhook reject (provider's reason). Falls
                // back to a generic message only when the server
                // omitted it (legacy build).
                reason: sale.rejectionReason.isNotEmpty
                    ? sale.rejectionReason
                    : 'Your sale was rejected. Please contact support if you need details.',
              ));
              break;
            case 'manual_review':
              emit(SellEscalatedToManualReview(sale));
              break;
            case 'pending':
            case 'reviewing':
              // Still in flight — keep the awaiting state visible.
              emit(GiftCardSellAwaitingProvider(
                sale: sale,
                reference: sale.reference,
              ));
              break;
            default:
              // pending_review and other intermediate states stay on
              // the same screen; nothing to do.
          }
        },
      );
    } catch (_) {
      // Silent — see comment above.
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
