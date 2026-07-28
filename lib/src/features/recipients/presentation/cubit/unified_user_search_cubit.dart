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

  UnifiedUserSearchCubit(this._repo) : super(const UnifiedUserSearchState());

  /// Debounced entry point wired to the search field's onChanged.
  void onQueryChanged(String raw) {
    final normalized = normalizeLazerVaultUserSearchQuery(raw);
    if (normalized.length < 2) {
      _debouncer.cancel();
      emit(const UnifiedUserSearchState()); // clear back to initial
      return;
    }
    _debouncer.run(() => _runSearch(normalized));
  }

  Future<void> _runSearch(String query) async {
    emit(state.copyWith(
      status: UnifiedSearchStatus.loading,
      query: query,
      results: const [],
      localCount: 0,
      hasMore: false,
      nextOffset: 0,
    ));
    try {
      final page = await _repo.search(query, limit: _pageSize, offset: 0);
      final seen = <String>{};
      final merged = <UnifiedSearchResult>[];
      for (final r in [...page.local, ...page.global]) {
        if (seen.add(r.dedupeKey)) merged.add(r);
      }
      // Guard against a stale response for a query the user already changed.
      if (state.query != query) return;
      emit(state.copyWith(
        status: UnifiedSearchStatus.success,
        results: merged,
        localCount: page.local.length,
        hasMore: page.hasMore,
        nextOffset: page.nextOffset,
      ));
    } catch (e) {
      if (state.query != query) return;
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
    emit(state.copyWith(status: UnifiedSearchStatus.loadingMore));
    try {
      final page = await _repo.search(query, limit: _pageSize, offset: offset);
      if (state.query != query) return; // query changed mid-flight
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
      if (state.query != query) return;
      // keep existing results; just stop the spinner.
      emit(state.copyWith(status: UnifiedSearchStatus.success));
    }
  }

  void reset() {
    _debouncer.cancel();
    emit(const UnifiedUserSearchState());
  }

  @override
  Future<void> close() {
    _debouncer.cancel();
    return super.close();
  }
}
