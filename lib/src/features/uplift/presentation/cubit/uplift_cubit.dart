import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/src/features/uplift/data/uplift_repository.dart';
import 'package:lazervault/src/features/uplift/presentation/widgets/uplift_widgets.dart';
import 'package:lazervault/src/generated/uplift.pbgrpc.dart' as up;

/// Lightweight state for the Uplift home surfaces. Holds the three list views
/// (discover / my funds / my applications) plus loading + error flags.
class UpliftState {
  const UpliftState({
    this.loading = false,
    this.error,
    this.discover = const [],
    this.myFunds = const [],
    this.myApplications = const [],
    this.discoverHasMore = false,
    this.discoverLoadingMore = false,
    this.query = '',
    this.category = '',
    this.recentReceipts = const [],
  });

  final bool loading;
  final String? error;
  final List<up.UpliftFundMessage> discover;
  final List<up.UpliftFundMessage> myFunds;
  final List<up.UpliftApplicationMessage> myApplications;
  final bool discoverHasMore;
  final bool discoverLoadingMore;
  final String query;
  final String category;
  final List<up.UpliftReceiptMessage> recentReceipts;

  UpliftState copyWith({
    bool? loading,
    String? error,
    List<up.UpliftFundMessage>? discover,
    List<up.UpliftFundMessage>? myFunds,
    List<up.UpliftApplicationMessage>? myApplications,
    bool? discoverHasMore,
    bool? discoverLoadingMore,
    String? query,
    String? category,
    List<up.UpliftReceiptMessage>? recentReceipts,
    bool clearError = false,
  }) {
    return UpliftState(
      loading: loading ?? this.loading,
      error: clearError ? null : (error ?? this.error),
      discover: discover ?? this.discover,
      myFunds: myFunds ?? this.myFunds,
      myApplications: myApplications ?? this.myApplications,
      discoverHasMore: discoverHasMore ?? this.discoverHasMore,
      discoverLoadingMore: discoverLoadingMore ?? this.discoverLoadingMore,
      query: query ?? this.query,
      category: category ?? this.category,
      recentReceipts: recentReceipts ?? this.recentReceipts,
    );
  }
}

class UpliftCubit extends Cubit<UpliftState> {
  UpliftCubit(this._repo) : super(const UpliftState());

  final UpliftRepository _repo;

  UpliftRepository get repo => _repo;

  static const _pageSize = 20;
  int _discoverPage = 1;

  /// Every load path here emits AFTER an await, and the screen closes this cubit
  /// in `dispose()` — so popping LazerFunds while a refresh is in flight would
  /// throw `Cannot emit new states after calling close`. Dropping the late state
  /// is correct: nothing is listening any more.
  void _safeEmit(UpliftState next) {
    if (isClosed) return;
    emit(next);
  }

  Future<void> loadAll() async {
    _safeEmit(state.copyWith(loading: true, clearError: true));
    try {
      _discoverPage = 1;
      final results = await Future.wait([
        _repo.listFunds(
            status: 'open',
            page: 1,
            pageSize: _pageSize,
            query: state.query,
            category: state.category),
        _repo.myFunds(),
        _repo.listApplications(mineOnly: true),
      ]);
      final discover = results[0] as List<up.UpliftFundMessage>;
      // Recent receipts power the landing "Recent activity" section — best-effort.
      List<up.UpliftReceiptMessage> receipts = state.recentReceipts;
      try {
        receipts = await _repo.listReceipts(pageSize: 5);
      } catch (_) {}
      _safeEmit(state.copyWith(
        loading: false,
        discover: discover,
        myFunds: results[1] as List<up.UpliftFundMessage>,
        myApplications: results[2] as List<up.UpliftApplicationMessage>,
        discoverHasMore: discover.length >= _pageSize,
        recentReceipts: receipts,
      ));
    } catch (e) {
      _safeEmit(state.copyWith(loading: false, error: upFriendlyError(e)));
    }
  }

  /// Applies a text query and/or category filter and reloads the discover list
  /// from page 1. Empty string clears the respective filter.
  Future<void> searchDiscover({String? query, String? category}) async {
    final q = query ?? state.query;
    final c = category ?? state.category;
    _safeEmit(
        state.copyWith(query: q, category: c, loading: true, clearError: true));
    try {
      _discoverPage = 1;
      final funds = await _repo.listFunds(
          status: 'open', page: 1, pageSize: _pageSize, query: q, category: c);
      _safeEmit(state.copyWith(
          loading: false,
          discover: funds,
          discoverHasMore: funds.length >= _pageSize));
    } catch (e) {
      _safeEmit(state.copyWith(loading: false, error: upFriendlyError(e)));
    }
  }

  Future<void> loadMoreDiscover() async {
    if (state.discoverLoadingMore || !state.discoverHasMore) return;
    _safeEmit(state.copyWith(discoverLoadingMore: true));
    try {
      final next = _discoverPage + 1;
      final more = await _repo.listFunds(
          status: 'open',
          page: next,
          pageSize: _pageSize,
          query: state.query,
          category: state.category);
      _discoverPage = next;
      _safeEmit(state.copyWith(
        discover: [...state.discover, ...more],
        discoverHasMore: more.length >= _pageSize,
        discoverLoadingMore: false,
      ));
    } catch (e) {
      _safeEmit(state.copyWith(
          discoverLoadingMore: false, error: upFriendlyError(e)));
    }
  }

  Future<void> refreshDiscover() => searchDiscover();

  Future<void> refreshMine() async {
    try {
      final funds = await _repo.myFunds();
      final apps = await _repo.listApplications(mineOnly: true);
      _safeEmit(state.copyWith(myFunds: funds, myApplications: apps));
    } catch (e) {
      _safeEmit(state.copyWith(error: upFriendlyError(e)));
    }
  }

  /// Re-reads EVERY list after the user creates, edits or cancels a fund.
  ///
  /// A fund is created with status OPEN, so it lands in Discover as well as in
  /// My Funds. Refreshing only "mine" left the tab the user was most likely
  /// looking at showing a list without the thing they had just made, which
  /// reads as a failed save until they pull to refresh.
  ///
  /// Unlike [loadAll] this never raises `loading`: the lists are already on
  /// screen and swapping them for a full-screen spinner is a flash, not
  /// feedback. Discover paging resets to page 1 because the list it was paging
  /// through no longer exists.
  Future<void> refreshAfterFundChange() async {
    try {
      final results = await Future.wait([
        _repo.listFunds(
            status: 'open',
            page: 1,
            pageSize: _pageSize,
            query: state.query,
            category: state.category),
        _repo.myFunds(),
        _repo.listApplications(mineOnly: true),
      ]);
      _discoverPage = 1;
      final discover = results[0] as List<up.UpliftFundMessage>;
      _safeEmit(state.copyWith(
        discover: discover,
        myFunds: results[1] as List<up.UpliftFundMessage>,
        myApplications: results[2] as List<up.UpliftApplicationMessage>,
        discoverHasMore: discover.length >= _pageSize,
        clearError: true,
      ));
    } catch (e) {
      _safeEmit(state.copyWith(error: upFriendlyError(e)));
    }
  }
}
