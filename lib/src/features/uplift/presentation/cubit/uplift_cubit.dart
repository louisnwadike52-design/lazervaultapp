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

  Future<void> loadAll() async {
    emit(state.copyWith(loading: true, clearError: true));
    try {
      _discoverPage = 1;
      final results = await Future.wait([
        _repo.listFunds(status: 'open', page: 1, pageSize: _pageSize, query: state.query, category: state.category),
        _repo.myFunds(),
        _repo.listApplications(mineOnly: true),
      ]);
      final discover = results[0] as List<up.UpliftFundMessage>;
      // Recent receipts power the landing "Recent activity" section — best-effort.
      List<up.UpliftReceiptMessage> receipts = state.recentReceipts;
      try {
        receipts = await _repo.listReceipts(pageSize: 5);
      } catch (_) {}
      emit(state.copyWith(
        loading: false,
        discover: discover,
        myFunds: results[1] as List<up.UpliftFundMessage>,
        myApplications: results[2] as List<up.UpliftApplicationMessage>,
        discoverHasMore: discover.length >= _pageSize,
        recentReceipts: receipts,
      ));
    } catch (e) {
      emit(state.copyWith(loading: false, error: upFriendlyError(e)));
    }
  }

  /// Applies a text query and/or category filter and reloads the discover list
  /// from page 1. Empty string clears the respective filter.
  Future<void> searchDiscover({String? query, String? category}) async {
    final q = query ?? state.query;
    final c = category ?? state.category;
    emit(state.copyWith(query: q, category: c, loading: true, clearError: true));
    try {
      _discoverPage = 1;
      final funds = await _repo.listFunds(status: 'open', page: 1, pageSize: _pageSize, query: q, category: c);
      emit(state.copyWith(loading: false, discover: funds, discoverHasMore: funds.length >= _pageSize));
    } catch (e) {
      emit(state.copyWith(loading: false, error: upFriendlyError(e)));
    }
  }

  Future<void> loadMoreDiscover() async {
    if (state.discoverLoadingMore || !state.discoverHasMore) return;
    emit(state.copyWith(discoverLoadingMore: true));
    try {
      final next = _discoverPage + 1;
      final more = await _repo.listFunds(status: 'open', page: next, pageSize: _pageSize, query: state.query, category: state.category);
      _discoverPage = next;
      emit(state.copyWith(
        discover: [...state.discover, ...more],
        discoverHasMore: more.length >= _pageSize,
        discoverLoadingMore: false,
      ));
    } catch (e) {
      emit(state.copyWith(discoverLoadingMore: false, error: upFriendlyError(e)));
    }
  }

  Future<void> refreshDiscover() => searchDiscover();

  Future<void> refreshMine() async {
    try {
      final funds = await _repo.myFunds();
      final apps = await _repo.listApplications(mineOnly: true);
      emit(state.copyWith(myFunds: funds, myApplications: apps));
    } catch (e) {
      emit(state.copyWith(error: upFriendlyError(e)));
    }
  }
}
