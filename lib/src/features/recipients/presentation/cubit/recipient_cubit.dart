import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/core/cache/swr_cache_manager.dart';
import 'package:lazervault/core/cache/cache_config.dart';
import 'package:lazervault/src/features/recipients/data/models/recipient_model.dart';
import 'package:lazervault/src/features/recipients/domain/usecases/add_recipient_usecase.dart';
import 'package:lazervault/src/features/recipients/domain/usecases/get_recipients_usecase.dart';
import 'package:lazervault/src/features/recipients/domain/usecases/toggle_favorite_usecase.dart';
import 'package:lazervault/src/features/recipients/domain/usecases/update_alias_usecase.dart';
import 'package:lazervault/src/features/recipients/domain/usecases/delete_recipient_usecase.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/recipient_state.dart';

class PaginatedRecipientsResult {
  final List<RecipientModel> recipients;
  final bool hasMore;
  final int currentPage;
  final int totalItems;
  final int totalPages;

  const PaginatedRecipientsResult({
    required this.recipients,
    required this.hasMore,
    required this.currentPage,
    required this.totalItems,
    required this.totalPages,
  });
}

class RecipientCubit extends Cubit<RecipientState> {
  final GetRecipientsUseCase _getRecipientsUseCase;
  final AddRecipientUseCase _addRecipientUseCase;
  final ToggleFavoriteUseCase _toggleFavoriteUseCase;
  final UpdateAliasUseCase _updateAliasUseCase;
  final DeleteRecipientUseCase _deleteRecipientUseCase;
  final SWRCacheManager? _cacheManager;

  StreamSubscription<SWRResult<List<RecipientModel>>>? _cacheSubscription;

  // Pagination state
  int _currentPage = 1;
  int _pageSize = 20;
  bool _hasMore = true;
  int _totalItems = 0;
  int _totalPages = 0;
  String? _lastCountryCode;
  String? _lastCurrency;
  bool? _lastFavoritesOnly;

  RecipientCubit({
    required GetRecipientsUseCase getRecipientsUseCase,
    required AddRecipientUseCase addRecipientUseCase,
    required ToggleFavoriteUseCase toggleFavoriteUseCase,
    required UpdateAliasUseCase updateAliasUseCase,
    required DeleteRecipientUseCase deleteRecipientUseCase,
    SWRCacheManager? cacheManager,
  })  : _getRecipientsUseCase = getRecipientsUseCase,
        _addRecipientUseCase = addRecipientUseCase,
        _toggleFavoriteUseCase = toggleFavoriteUseCase,
        _updateAliasUseCase = updateAliasUseCase,
        _deleteRecipientUseCase = deleteRecipientUseCase,
        _cacheManager = cacheManager,
        super(RecipientInitial());

  @override
  Future<void> close() {
    _cacheSubscription?.cancel();
    return super.close();
  }

  String _getCacheKey({String? countryCode, String? currency, bool? favoritesOnly, int? page}) {
    return 'recipients:${countryCode ?? 'all'}:${currency ?? 'all'}:${favoritesOnly ?? false}:${page ?? 1}';
  }

  Future<void> getRecipients({
    required String accessToken,
    String? countryCode,
    String? currency,
    bool? favoritesOnly,
    bool forceRefresh = false,
  }) async {
    if (isClosed) return;

    // Reset pagination state for new fetch
    _currentPage = 1;
    _hasMore = true;
    _lastCountryCode = countryCode;
    _lastCurrency = currency;
    _lastFavoritesOnly = favoritesOnly;

    // Cancel any existing subscription
    await _cacheSubscription?.cancel();

    final cacheKey = _getCacheKey(
      countryCode: countryCode,
      currency: currency,
      favoritesOnly: favoritesOnly,
      page: 1,
    );

    // Use SWR cache if available (bypass for paginated queries to avoid complexity)
    // For pagination, we'll fetch directly
    emit(RecipientLoading());
    try {
      final result = await _fetchRecipientsPaginated(
        accessToken: accessToken,
        countryCode: countryCode,
        currency: currency,
        favoritesOnly: favoritesOnly,
        page: 1,
      );
      if (isClosed) return;

      _currentPage = result.currentPage;
      // If fewer items than page size returned, no more pages to fetch
      _hasMore = result.hasMore && result.recipients.length >= _pageSize;
      _totalItems = result.totalItems;
      _totalPages = result.totalPages;

      emit(RecipientLoaded(
        result.recipients,
        hasMore: _hasMore,
        currentPage: result.currentPage,
        totalItems: result.totalItems,
        totalPages: result.totalPages,
      ));
    } catch (e) {
      if (isClosed) return;
      emit(RecipientError(e.toString()));
    }
  }

  Future<void> loadMoreRecipients({
    required String accessToken,
  }) async {
    if (isClosed || !_hasMore) return;

    final currentState = state;
    if (currentState is! RecipientLoaded) return;

    // Show loading more state
    emit(RecipientLoadingMore(
      currentRecipients: currentState.recipients,
      hasMore: currentState.hasMore,
      currentPage: currentState.currentPage,
    ));

    try {
      final nextPage = _currentPage + 1;
      final result = await _fetchRecipientsPaginated(
        accessToken: accessToken,
        countryCode: _lastCountryCode,
        currency: _lastCurrency,
        favoritesOnly: _lastFavoritesOnly,
        page: nextPage,
      );
      if (isClosed) return;

      _currentPage = result.currentPage;
      // If fewer items than page size or empty, no more pages
      _hasMore = result.hasMore && result.recipients.length >= _pageSize;
      _totalItems = result.totalItems;
      _totalPages = result.totalPages;

      // Append new recipients to existing list
      final updatedRecipients = [...currentState.recipients, ...result.recipients];
      emit(RecipientLoaded(
        updatedRecipients,
        hasMore: _hasMore,
        currentPage: result.currentPage,
        totalItems: result.totalItems,
        totalPages: result.totalPages,
      ));
    } catch (e) {
      if (isClosed) return;
      // Revert to previous state on error
      emit(currentState);
    }
  }

  Future<PaginatedRecipientsResult> _fetchRecipientsPaginated({
    required String accessToken,
    String? countryCode,
    String? currency,
    bool? favoritesOnly,
    required int page,
  }) async {
    final result = await _getRecipientsUseCase.callPaginated(
      accessToken: accessToken,
      countryCode: countryCode,
      currency: currency,
      favoritesOnly: favoritesOnly,
      page: page,
      pageSize: _pageSize,
    );
    return result.fold(
      (failure) => throw Exception(failure.message),
      (recipients) => recipients,
    );
  }

  Future<List<RecipientModel>> _fetchRecipients({
    required String accessToken,
    String? countryCode,
    String? currency,
    bool? favoritesOnly,
  }) async {
    final result = await _getRecipientsUseCase(
      accessToken: accessToken,
      countryCode: countryCode,
      currency: currency,
      favoritesOnly: favoritesOnly,
    );
    return result.fold(
      (failure) => throw Exception(failure.message),
      (recipients) => recipients,
    );
  }

  // Getters for pagination state
  bool get hasMore => _hasMore;
  int get currentPage => _currentPage;
  int get totalItems => _totalItems;
  int get totalPages => _totalPages;

  Future<void> addRecipient({
    required RecipientModel recipient,
    required String accessToken,
  }) async {
    if (isClosed) return;
    emit(RecipientLoading());
    try {
      final result = await _addRecipientUseCase(
        recipient: recipient,
        accessToken: accessToken,
      );
      if (isClosed) return;
      result.fold(
        (failure) => emit(RecipientError(failure.message)),
        (newRecipient) {
          // Invalidate cache to ensure fresh data on next fetch
          _cacheManager?.invalidatePattern('recipients:');
          emit(RecipientSuccess('Recipient added successfully', recipient: newRecipient));
          getRecipients(accessToken: accessToken, forceRefresh: true);
        },
      );
    } catch (e) {
      if (isClosed) return;
      emit(RecipientError(e.toString()));
    }
  }

  Future<void> toggleFavorite({
    required String recipientId,
    required bool isFavorite,
    required String accessToken,
  }) async {
    final previousState = state;
    if (previousState is RecipientLoaded) {
       final updatedRecipients = previousState.recipients.map((r) {
         if (r.id == recipientId) {
           return r.copyWith(isFavorite: isFavorite);
         }
         return r;
       }).toList();
       if (isClosed) return;
       emit(previousState.copyWith(recipients: updatedRecipients));
    }

    try {
      final result = await _toggleFavoriteUseCase(
          recipientId: recipientId, isFavorite: isFavorite, accessToken: accessToken);
      if (isClosed) return;
      result.fold(
        (failure) {
            emit(previousState);
            emit(RecipientError(failure.message));
         },
        (_) {
          // Invalidate cache after successful update
          _cacheManager?.invalidatePattern('recipients:');
        },
      );
    } catch (e) {
       if (isClosed) return;
       emit(previousState);
       emit(RecipientError(e.toString()));
    }
  }

  Future<void> updateAlias({
    required String recipientId,
    required String? alias,
    required String accessToken,
  }) async {
    final previousState = state;
    // Optimistic update
    if (previousState is RecipientLoaded) {
      final updatedRecipients = previousState.recipients.map((r) {
        if (r.id == recipientId) {
          return r.copyWith(alias: alias);
        }
        return r;
      }).toList();
      if (isClosed) return;
      emit(previousState.copyWith(recipients: updatedRecipients));
    }

    try {
      final result = await _updateAliasUseCase(
        recipientId: recipientId,
        alias: alias,
        accessToken: accessToken,
      );
      if (isClosed) return;
      result.fold(
        (failure) {
          emit(previousState);
          emit(RecipientError(failure.message));
        },
        (_) {
          // Invalidate cache after successful update
          _cacheManager?.invalidatePattern('recipients:');
        },
      );
    } catch (e) {
      if (isClosed) return;
      emit(previousState);
      emit(RecipientError(e.toString()));
    }
  }

  Future<void> deleteRecipient({
    required String recipientId,
    required String accessToken,
  }) async {
    final previousState = state;
    // Optimistic removal
    if (previousState is RecipientLoaded) {
      final updatedRecipients = previousState.recipients
          .where((r) => r.id != recipientId)
          .toList();
      if (isClosed) return;
      emit(previousState.copyWith(recipients: updatedRecipients));
    }

    try {
      final result = await _deleteRecipientUseCase(
        recipientId: recipientId,
        accessToken: accessToken,
      );
      if (isClosed) return;
      result.fold(
        (failure) {
          emit(previousState);
          emit(RecipientError(failure.message));
        },
        (_) {
          // Invalidate cache after successful deletion
          _cacheManager?.invalidatePattern('recipients:');
        },
      );
    } catch (e) {
      if (isClosed) return;
      emit(previousState);
      emit(RecipientError(e.toString()));
    }
  }
}
