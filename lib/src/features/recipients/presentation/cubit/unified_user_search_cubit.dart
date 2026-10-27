import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lazervault/core/utils/debouncer.dart';
import 'package:lazervault/core/utils/user_search_query.dart';
import 'package:lazervault/src/features/recipients/data/repositories/unified_user_search_repository.dart';
import 'package:lazervault/src/features/recipients/domain/entities/unified_search_result.dart';

enum UnifiedSearchStatus { initial, loading, loadingMore, success, error }

class UnifiedUserSearchState extends Equatable {
  final UnifiedSearchStatus status;
  final String query;

  /// Saved (local) hits first, then global hits — deduped across pages.
  final List<UnifiedSearchResult> results;

  /// How many leading [results] are saved/local hits (for the section divider).
  final int localCount;

  final bool hasMore;
  final int nextOffset;
  final String? error;

  const UnifiedUserSearchState({
    this.status = UnifiedSearchStatus.initial,
    this.query = '',
    this.results = const [],
    this.localCount = 0,
    this.hasMore = false,
    this.nextOffset = 0,
    this.error,
  });

  UnifiedUserSearchState copyWith({
    UnifiedSearchStatus? status,
    String? query,
    List<UnifiedSearchResult>? results,
    int? localCount,
    bool? hasMore,
    int? nextOffset,
    String? error,
  }) {
    return UnifiedUserSearchState(
      status: status ?? this.status,
      query: query ?? this.query,
      results: results ?? this.results,
      localCount: localCount ?? this.localCount,
      hasMore: hasMore ?? this.hasMore,
      nextOffset: nextOffset ?? this.nextOffset,
      error: error,
    );
  }

  @override
  List<Object?> get props =>
      [status, query, results, localCount, hasMore, nextOffset, error];
}

/// Drives the unified search sheet: debounced query → local-first → global,
/// offset-paginated with scroll-driven load-more and cross-page de-dup.
class UnifiedUserSearchCubit extends Cubit<UnifiedUserSearchState> {
  final UnifiedUserSearchRepository _repo;
  final Debouncer _debouncer = Debouncer.snappy();
  static const int _pageSize = 20;

  /// When true the search returns only LazerVault users (no saved external bank
  /// recipients) — the "find a person" mode for split-bill participants and the
  /// send-funds person search. Leave false where external-bank recipients are a
  /// valid target (the external-bank send flow). Mutable so the shared
  /// serviceLocator instance can be scoped per-sheet on open.
  bool internalOnly;

  /// Sequence token for in-flight requests. Bumped by every new search, by a
  /// clear/reset and by close, so a response that lands late can never
  /// overwrite a newer query's results (or emit on a closed cubit), even when
  /// the user types back to the same text the stale request was for.
  int _searchSeq = 0;

  UnifiedUserSearchCubit(this._repo, {this.internalOnly = false})
      : super(const UnifiedUserSearchState());

  /// Debounced entry point wired to the search field's onChanged.
  void onQueryChanged(String raw) {
    final normalized = normalizeLazerVaultUserSearchQuery(raw);
    if (normalized.length < 2) {
      _debouncer.cancel();
      _searchSeq++;
      emit(const UnifiedUserSearchState()); // clear back to initial
      return;
    }
    _debouncer.run(() => _runSearch(normalized));
  }

  Future<void> _runSearch(String query) async {
    final seq = ++_searchSeq;
    emit(state.copyWith(
      status: UnifiedSearchStatus.loading,
      query: query,
      results: const [],
      localCount: 0,
      hasMore: false,
      nextOffset: 0,
    ));
    try {
      final page = await _repo.search(query,
          limit: _pageSize, offset: 0, internalOnly: internalOnly);
      final seen = <String>{};
      final merged = <UnifiedSearchResult>[];
      for (final r in [...page.local, ...page.global]) {
        if (seen.add(r.dedupeKey)) merged.add(r);
      }
      // Guard against a stale response for a query the user already changed.
      if (seq != _searchSeq) return;
      emit(state.copyWith(
        status: UnifiedSearchStatus.success,
        results: merged,
        localCount: page.local.length,
        hasMore: page.hasMore,
        nextOffset: page.nextOffset,
      ));
    } catch (e) {
      if (seq != _searchSeq) return;
      emit(state.copyWith(
        status: UnifiedSearchStatus.error,
        error: 'Couldn’t search right now. Please try again.',
      ));
    }
  }

  /// Called by the sheet's scroll listener near the bottom.
  Future<void> loadMore() async {
    if (!state.hasMore ||
        state.status == UnifiedSearchStatus.loading ||
        state.status == UnifiedSearchStatus.loadingMore) {
      return;
    }
    final query = state.query;
    final offset = state.nextOffset;
    final seq = _searchSeq; // paging belongs to the current query only
    emit(state.copyWith(status: UnifiedSearchStatus.loadingMore));
    try {
      final page = await _repo.search(query,
          limit: _pageSize, offset: offset, internalOnly: internalOnly);
      if (seq != _searchSeq) return; // query changed or cleared mid-flight
      final seen = state.results.map((r) => r.dedupeKey).toSet();
      final appended = <UnifiedSearchResult>[...state.results];
      // load-more only paginates the GLOBAL directory (local is page-0 only).
      for (final r in page.global) {
        if (seen.add(r.dedupeKey)) appended.add(r);
      }
      emit(state.copyWith(
        status: UnifiedSearchStatus.success,
        results: appended,
        hasMore: page.hasMore,
        nextOffset: page.nextOffset,
      ));
    } catch (_) {
      if (seq != _searchSeq) return;
      // keep existing results; just stop the spinner.
      emit(state.copyWith(status: UnifiedSearchStatus.success));
    }
  }

  void reset() {
    _debouncer.cancel();
    _searchSeq++;
    emit(const UnifiedUserSearchState());
  }

  @override
  Future<void> close() {
    _debouncer.cancel();
    _searchSeq++;
    return super.close();
  }
}
