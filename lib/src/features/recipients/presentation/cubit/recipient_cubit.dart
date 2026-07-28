import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/core/cache/swr_cache_manager.dart';
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
  final int _pageSize = 20;
  bool _hasMore = true;
  int _totalItems = 0;
  int _totalPages = 0;
  String? _lastCountryCode;
  String? _lastCurrency;
  bool? _lastFavoritesOnly;

  // Monotonic token so a slow/failed fetch from a PREVIOUS screen mount (rapid
  // back-and-forth navigation fires getRecipients on every re-entry) can't
  // clobber a newer one's result — the root of the intermittent "something
  // went wrong" after navigating in/out several times.
  int _loadSeq = 0;

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

  Future<void> getRecipients({
    required String accessToken,
    String? countryCode,
    String? currency,
    bool? favoritesOnly,
    bool forceRefresh = false,
  }) async {
    if (isClosed) return;
    final seq = ++_loadSeq;
    // Remember the last good list so a transient failure on re-entry doesn't
    // wipe a working screen to a full error.
    final priorState = state;

    // Reset pagination state for new fetch
    _currentPage = 1;
    _hasMore = true;
    _lastCountryCode = countryCode;
    _lastCurrency = currency;
    _lastFavoritesOnly = favoritesOnly;

    // Cancel any existing subscription
    await _cacheSubscription?.cancel();

    // Note: SWR cache was bypassed for paginated queries (added
    // complexity outweighed the win). The page-1 cache key derivation
    // lived here previously; it's removed since nothing reads it.
    //
    // Pull-to-refresh (forceRefresh) of an already-loaded view keeps the
    // current list on screen while the new page loads — the RefreshIndicator
    // spinner already signals progress, so blanking to a full loader would
    // just make the list flicker empty. Initial loads and filter/account
    // switches (forceRefresh=false) still show the loading state, so stale
    // data from a different view is never shown.
    final keepCurrentWhileLoading = forceRefresh && state is RecipientLoaded;
    if (!keepCurrentWhileLoading) {
      emit(RecipientLoading());
    }
    try {
      final result = await _fetchRecipientsPaginated(
        accessToken: accessToken,
        countryCode: countryCode,
        currency: currency,
        favoritesOnly: favoritesOnly,
        page: 1,
      );
      if (isClosed || seq != _loadSeq) return; // a newer load superseded us

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
      if (isClosed || seq != _loadSeq) return; // stale failure — ignore
      // Don't nuke a working screen to "something went wrong" on a transient
      // failure during rapid re-navigation: if we already had recipients, keep
      // them (a background re-fetch hiccup shouldn't blow away the list). Only a
      // cold first load with no prior data surfaces the error state.
      if (priorState is RecipientLoaded) {
        emit(priorState);
      } else {
        emit(RecipientError(e.toString()));
      }
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
