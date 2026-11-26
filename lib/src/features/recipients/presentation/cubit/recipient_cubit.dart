import 'dart:async';

import 'package:lazervault/core/config/feature_flags.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/core/cache/session_user_id.dart';
import 'package:lazervault/core/cache/swr_cache_manager.dart';
import 'package:lazervault/src/features/recipients/data/models/recipient_model.dart';
import 'package:lazervault/src/features/recipients/domain/usecases/add_recipient_usecase.dart';
import 'package:lazervault/src/features/recipients/domain/usecases/get_recipients_usecase.dart';
import 'package:lazervault/src/features/recipients/domain/usecases/toggle_favorite_usecase.dart';
import 'package:lazervault/src/features/recipients/domain/usecases/update_alias_usecase.dart';
import 'package:lazervault/src/features/recipients/domain/usecases/delete_recipient_usecase.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/recipient_page_store.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/recipient_state.dart';
import 'package:lazervault/core/services/saved_recipients_snapshot.dart';

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
  /// 100, which is the largest page the service will serve
  /// (recipientRepository clamps pageSize to 100 and defaults it to 20).
  ///
  /// It was 20, and the screen splits the loaded page into the Bank and
  /// Lazervault tabs CLIENT-SIDE, so each tab showed whatever fraction of
  /// those 20 happened to be its type. A customer with 149 saved recipients
  /// reported one they had transferred to repeatedly and saved — she was
  /// there, saved twice, but sat past the first page and so appeared in
  /// neither tab. At 100 that customer is two requests instead of eight.
  final int _pageSize = 100;
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

  /// Publish every loaded set so the account-number suggestion list can read
  /// the payer's saved payees SYNCHRONOUSLY — see SavedRecipientsSnapshot.
  ///
  /// Hooked on onChange rather than at each emit site: this cubit emits a
  /// loaded state from six places (initial, cached, revalidated, add, rename,
  /// delete) and patching them individually is how one gets missed.
  @override
  void onChange(Change<RecipientState> change) {
    super.onChange(change);
    final next = change.nextState;
    if (next is RecipientLoaded) {
      SavedRecipientsSnapshot.publish(next.recipients);
    }
  }

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

    // Note: SWR cache was bypassed for paginated queries (added
    // complexity outweighed the win). The page-1 cache key derivation
    // lived here previously; it's removed since nothing reads it.
    //
    // Pull-to-refresh (forceRefresh) of an already-loaded view keeps the
    // current list on screen while the new page loads — the RefreshIndicator
    // spinner already signals progress, so blanking to a full loader would
    // just make the list flicker empty. Initial loads and filter/account
    // switches (forceRefresh=false) show the loading state unless THIS exact
    // view's page one is remembered (below), so stale data from a different
    // view is never shown.
    final keepCurrentWhileLoading = forceRefresh && state is RecipientLoaded;
    // Paint the remembered page one for THIS view (same user, same
    // country/currency/favourites key) instead of a loader, and refresh
    // behind it. The list's freshness still comes from the fetch below on
    // every call — nothing here decides whether to fetch, only what the user
    // looks at while it runs. A different view's rows can never be painted:
    // the scope key is the same key the fetch is parameterised on.
    final userId = SessionUserId.current();
    final scope = recipientsPageScope(
      countryCode: countryCode,
      currency: currency,
      favoritesOnly: favoritesOnly,
    );
    var paintedCached = keepCurrentWhileLoading;
    if (!keepCurrentWhileLoading) {
      final cached = recipientsPageStore.peek(userId: userId, scope: scope) ??
          await recipientsPageStore.hydrate(userId: userId, scope: scope);
      if (isClosed || seq != _loadSeq) return;
      if (cached != null) {
        paintedCached = true;
        // No load-more until the fresh page lands, so a scroll during the
        // refresh cannot append page 2 onto a page 1 about to be replaced.
        _hasMore = false;
        emit(RecipientLoaded(cached, isRevalidating: true, hasMore: false));
      } else {
        emit(RecipientLoading());
      }
    }
    // Cancel any existing subscription. After the paint above on purpose:
    // the first `await` in this method is what lets the screen's first frame
    // build, and that frame should already hold the remembered page.
    await _cacheSubscription?.cancel();
    if (isClosed || seq != _loadSeq) return;
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
      recipientsPageStore.put(result.recipients, userId: userId, scope: scope);

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
      final shown = state;
      if (paintedCached && shown is RecipientLoaded) {
        // The remembered page is on screen; a failed refresh keeps it there.
        emit(shown.copyWith(isRevalidating: false));
      } else if (priorState is RecipientLoaded) {
        emit(priorState);
      } else {
        emit(RecipientError(e.toString()));
      }
    }
  }

  /// Keep fetching until the service has no more pages.
  ///
  /// WHY A SEARCH NEEDS THIS. The search box and the Bank / Lazervault tabs
  /// both filter the list the cubit has ALREADY loaded. Filtering one page and
  /// calling the result "no matches" is a lie: the row is in the table, it is
  /// simply on page two. So a search exhausts the pages first and then
  /// filters, which is the difference between "nothing matched" and "nothing
  /// matched yet".
  ///
  /// Safe to call repeatedly: it returns immediately once `_hasMore` is false,
  /// and every page is deduped by id on append. [maxPages] is a stop so a
  /// service that keeps reporting hasMore cannot spin forever — at 100 a page
  /// it covers 2,000 recipients, far past any real list.
  Future<void> loadAllRecipients({
    required String accessToken,
    int maxPages = 20,
  }) async {
    final seq = _loadSeq;
    var guard = 0;
    while (!isClosed && _hasMore && guard < maxPages) {
      guard++;
      if (state is! RecipientLoaded) return;
      await loadMoreRecipients(accessToken: accessToken);
      // A filter change or a reload landed while we were paging; the list we
      // would keep appending to is no longer the one on screen.
      if (seq != _loadSeq) return;
    }
  }

  Future<void> loadMoreRecipients({
    required String accessToken,
  }) async {
    if (isClosed || !_hasMore) return;

    final currentState = state;
    if (currentState is! RecipientLoaded) return;

    // TAKE A TICKET, as `getRecipients` does. This appends onto a list it
    // captured BEFORE awaiting, so a filter change, a favourites toggle or a
    // region switch landing mid-flight would be overwritten by the stale list
    // plus a page belonging to the view the reader has just left.
    final seq = _loadSeq;

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
      if (isClosed || seq != _loadSeq) return;

      _currentPage = result.currentPage;
      // If fewer items than page size or empty, no more pages
      _hasMore = result.hasMore && result.recipients.length >= _pageSize;
      _totalItems = result.totalItems;
      _totalPages = result.totalPages;

      // APPEND, WITHOUT RE-ADDING ROWS ALREADY HELD. Pages are offsets into a
      // table that takes new rows at the top, so saving a recipient between
      // page one and page two shifts everything down and page two re-sends
      // the row that was last on page one. Appending blind shows it twice and
      // makes the duplicate tappable as if it were a second recipient.
      final seen = currentState.recipients.map((r) => r.id).toSet();
      final updatedRecipients = [
        ...currentState.recipients,
        for (final r in result.recipients)
          if (r.id.isEmpty || seen.add(r.id)) r,
      ];
      emit(RecipientLoaded(
        updatedRecipients,
        hasMore: _hasMore,
        currentPage: result.currentPage,
        totalItems: result.totalItems,
        totalPages: result.totalPages,
      ));
    } catch (e) {
      if (isClosed || seq != _loadSeq) return;
      // Revert to the list we had: an append that failed must not take the
      // pages already read down with it.
      emit(currentState);
    }
  }

  /// FILL THE SAVED-PAYEE SNAPSHOT, WHICH IS A DIFFERENT JOB FROM THE LIST.
  ///
  /// The list on screen is paged twenty at a time because that is what a
  /// reader scrolls. The snapshot behind the as-you-type account matcher is
  /// not read by a reader — it is scanned for a number — and it was being fed
  /// from that same first page, because [SavedRecipientsSnapshot] is published
  /// out of `onChange`. So a payer with more than twenty saved payees could
  /// type the exact account number of the twenty-first and be offered nothing,
  /// which reads precisely like the feature being broken rather than like a
  /// page boundary.
  ///
  /// This fetches the payee book in one go and publishes it straight to the
  /// snapshot WITHOUT emitting. That separation is deliberate: emitting would
  /// drop a few hundred rows into the list widget and reset `_hasMore`,
  /// `_currentPage` and the reader's scroll position as a side effect of
  /// warming a cache.
  ///
  /// Returns whether a fetch was actually dispatched, so the caller can tell
  /// "the payer has no saved payees" from "I could not look".
  Future<bool> warmSavedRecipientsSnapshot({
    required String accessToken,
    String? countryCode,
    String? currency,
  }) async {
    if (isClosed) return false;
    try {
      final result = await _getRecipientsUseCase.callPaginated(
        accessToken: accessToken,
        countryCode: countryCode,
        currency: currency,
        page: 1,
        pageSize: FeatureFlags.savedPayeeSnapshotRows,
      );
      return result.fold((failure) => false, (paged) {
        SavedRecipientsSnapshot.publish(paged.recipients);
        return true;
      });
    } catch (_) {
      // A snapshot that could not be warmed costs a suggestion, never a
      // payment — the bank name-enquiry behind it is untouched.
      return false;
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
    // Send-funds auto-save passes true so no "Recipient added" snackbar fires
    // on top of the transfer receipt.
    bool silent = false,
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
          emit(RecipientSuccess('Recipient added successfully',
              recipient: newRecipient, silent: silent));
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
          recipientId: recipientId,
          isFavorite: isFavorite,
          accessToken: accessToken);
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
      final updatedRecipients =
          previousState.recipients.where((r) => r.id != recipientId).toList();
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
