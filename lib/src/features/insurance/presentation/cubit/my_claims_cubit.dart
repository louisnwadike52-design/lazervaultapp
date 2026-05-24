// Cubit + state for the user-facing My Claims list.
//
// Mirror's the Slice-4 pagination pattern with a generation-token race
// guard. Source: repository.getUserClaims (existing) — filters server-side
// by the authenticated user_id.

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:lazervault/src/features/account_cards_summary/services/balance_websocket_service.dart';
import '../../domain/entities/insurance_claim_entity.dart';
import '../../domain/repositories/insurance_repository.dart';

/// State machine for the My Claims screen.
sealed class MyClaimsState extends Equatable {
  const MyClaimsState();
  @override
  List<Object?> get props => const [];
}

class MyClaimsInitial extends MyClaimsState {
  const MyClaimsInitial();
}

class MyClaimsLoading extends MyClaimsState {
  const MyClaimsLoading();
}

class MyClaimsLoaded extends MyClaimsState {
  final List<InsuranceClaim> claims;
  final bool hasMore;
  final bool isLoadingMore;
  final int currentPage;
  final String? statusFilter;

  const MyClaimsLoaded({
    required this.claims,
    this.hasMore = false,
    this.isLoadingMore = false,
    this.currentPage = 1,
    this.statusFilter,
  });

  MyClaimsLoaded copyWith({
    List<InsuranceClaim>? claims,
    bool? hasMore,
    bool? isLoadingMore,
    int? currentPage,
    String? statusFilter,
  }) {
    return MyClaimsLoaded(
      claims: claims ?? this.claims,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      currentPage: currentPage ?? this.currentPage,
      statusFilter: statusFilter ?? this.statusFilter,
    );
  }

  @override
  List<Object?> get props =>
      [claims, hasMore, isLoadingMore, currentPage, statusFilter];
}

class MyClaimsError extends MyClaimsState {
  final String message;
  const MyClaimsError(this.message);
  @override
  List<Object?> get props => [message];
}

class MyClaimsCubit extends Cubit<MyClaimsState> {
  final InsuranceRepository _repository;
  // Optional: subscribes to insurance_claim_status_changed so the list
  // refreshes when the claim reconciler advances a claim on MyCover's
  // side. Optional so unit tests can construct without GetIt.
  final BalanceWebSocketService? _wsService;
  StreamSubscription<InsuranceClaimEvent>? _claimEventSub;
  String? _userId;
  // Track the last `status` arg passed to `load()` so the WS-driven
  // refresh preserves any active filter.
  String? _lastStatusFilter;

  // Slice-4 race guard. Bumped on every load() (initial fetch / refresh /
  // status change). In-flight loadMore() with a stale generation drops
  // its emit.
  int _generation = 0;

  MyClaimsCubit(
    this._repository, {
    BalanceWebSocketService? wsService,
  })  : _wsService = wsService,
        super(const MyClaimsInitial());

  /// Wire the authenticated user id. Called once after sign-in.
  void setUserId(String userId) {
    _userId = userId;
    if (userId.isNotEmpty) {
      _subscribeToClaimEvents();
    } else {
      _claimEventSub?.cancel();
      _claimEventSub = null;
    }
  }

  /// Subscribe to ws-balance-service for claim status changes. The
  /// reconciler emits `insurance_claim_status_changed` whenever MyCover
  /// advances a claim to a terminal state (approved / rejected / settled).
  /// Filters on userId so multi-user environments don't cross-react.
  void _subscribeToClaimEvents() {
    if (_wsService == null) return;
    _claimEventSub?.cancel();
    _claimEventSub = _wsService!.insuranceClaimEvents.listen((event) {
      if (event.userId.isNotEmpty &&
          _userId != null &&
          event.userId != _userId) {
        return;
      }
      // Refresh while preserving the active status filter so the user's
      // current view doesn't reset to "All" on every status change.
      load(status: _lastStatusFilter);
    });
  }

  /// Page size. The backend caps at 200; we pick a smaller value here
  /// so the first paint is fast and infinite-scroll appends feel
  /// natural. Keep aligned with the `limit` argument on the repo call
  /// below — `hasMore` uses `result.length == _pageSize` as the
  /// "there might be another page" heuristic.
  static const int _pageSize = 20;

  /// Fetch the first page (or refresh). Optional [status] applies a
  /// client-side filter on the returned list — the existing
  /// getUserClaims RPC doesn't accept a status param, so we filter in
  /// Dart. When the underlying RPC grows a server-side filter the
  /// status arg here will forward to it.
  Future<void> load({String? status}) async {
    if (isClosed) return;
    final uid = _userId;
    if (uid == null || uid.isEmpty) {
      emit(const MyClaimsError('Please log in to view your claims'));
      return;
    }
    _lastStatusFilter = status;
    emit(const MyClaimsLoading());
    _generation++;
    final myGen = _generation;
    try {
      final claims = await _repository.getUserClaims(
        uid,
        page: 1,
        limit: _pageSize,
      );
      if (isClosed || myGen != _generation) return;
      // ClaimStatus.toString() returns "ClaimStatus.submitted" — use
      // `.name` to get the bare enum value ("submitted") that matches the
      // filter strings the screen passes in. Filter is client-side until
      // GetUserInsuranceClaimsRequest grows a status field.
      final filtered = status == null || status.isEmpty
          ? claims
          : claims.where((c) => c.status.name == status).toList();
      emit(MyClaimsLoaded(
        claims: filtered,
        // hasMore heuristic: a full page → there's probably another.
        // The backend caps at 200 server-side and doesn't return a
        // grand total, so this is the best signal we have without
        // adding a separate COUNT query.
        hasMore: claims.length >= _pageSize,
        isLoadingMore: false,
        currentPage: 1,
        statusFilter: status,
      ));
    } catch (e) {
      if (isClosed || myGen != _generation) return;
      emit(MyClaimsError(_friendlyError(e)));
    }
  }

  /// Append the next page of claims to the loaded list. No-op if we're
  /// not already in a loaded state with `hasMore == true`. The
  /// generation guard guarantees a refresh (via `load()`) racing with
  /// loadMore() doesn't double-append stale data.
  Future<void> loadMore() async {
    if (isClosed) return;
    final s = state;
    if (s is! MyClaimsLoaded) return;
    if (!s.hasMore || s.isLoadingMore) return;
    final uid = _userId;
    if (uid == null || uid.isEmpty) return;

    final nextPage = s.currentPage + 1;
    final myGen = _generation;
    emit(s.copyWith(isLoadingMore: true));
    try {
      final more = await _repository.getUserClaims(
        uid,
        page: nextPage,
        limit: _pageSize,
      );
      if (isClosed || myGen != _generation) return;
      // Same client-side status filter as the first page so the user's
      // active filter survives infinite scroll.
      final filter = _lastStatusFilter;
      final filtered = filter == null || filter.isEmpty
          ? more
          : more.where((c) => c.status.name == filter).toList();
      emit(MyClaimsLoaded(
        claims: [...s.claims, ...filtered],
        hasMore: more.length >= _pageSize,
        isLoadingMore: false,
        currentPage: nextPage,
        statusFilter: filter,
      ));
    } catch (_) {
      if (isClosed || myGen != _generation) return;
      // Surface the partial state with isLoadingMore cleared. The user
      // can pull-to-refresh or try scrolling again.
      emit(s.copyWith(isLoadingMore: false));
    }
  }

  String _friendlyError(Object e) {
    final m = e.toString().toLowerCase();
    if (m.contains('connection') || m.contains('unavailable') || m.contains('socket')) {
      return 'Unable to connect. Please check your connection and try again.';
    }
    if (m.contains('timeout') || m.contains('deadline')) {
      return 'Request timed out. Please try again.';
    }
    return 'Failed to load your claims. Please try again.';
  }

  @override
  Future<void> close() {
    _claimEventSub?.cancel();
    _claimEventSub = null;
    return super.close();
  }
}
