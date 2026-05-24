// Cubit for the user-facing Purchase History list.
//
// Source: the existing paginated `getUserInsurancesPage(userId)` repo
// method — same entry point the Policies tab uses, but presented in
// chronological "transaction history" style with the option to open
// each policy's live MyCover detail (and certificate) on tap.
//
// We deliberately don't go through `getMyCoverCustomerPurchases` here
// because that requires the user's MyCover customer_id which we don't
// store on the user record. Instead we lean on our internal
// `insurance_purchases` rows (already scoped by user_id) which carry
// every purchase the user has ever made.
//
// Pagination: existing repo method already supports page/limit + hasMore.
// Slice-4 generation-token race guard applied.

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/insurance_entity.dart';
import '../../domain/entities/insurance_product_entity.dart';
import '../../domain/repositories/insurance_repository.dart';

sealed class PurchaseHistoryState extends Equatable {
  const PurchaseHistoryState();
  @override
  List<Object?> get props => const [];
}

class PurchaseHistoryInitial extends PurchaseHistoryState {
  const PurchaseHistoryInitial();
}

class PurchaseHistoryLoading extends PurchaseHistoryState {
  const PurchaseHistoryLoading();
}

class PurchaseHistoryEmpty extends PurchaseHistoryState {
  const PurchaseHistoryEmpty();
}

class PurchaseHistoryLoaded extends PurchaseHistoryState {
  final List<Insurance> purchases; // Insurance entity is the source of truth
  final int total;
  final bool hasMore;
  final bool isLoadingMore;
  final int currentPage;

  const PurchaseHistoryLoaded({
    required this.purchases,
    required this.total,
    this.hasMore = false,
    this.isLoadingMore = false,
    this.currentPage = 1,
  });

  PurchaseHistoryLoaded copyWith({
    List<Insurance>? purchases,
    int? total,
    bool? hasMore,
    bool? isLoadingMore,
    int? currentPage,
  }) {
    return PurchaseHistoryLoaded(
      purchases: purchases ?? this.purchases,
      total: total ?? this.total,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  @override
  List<Object?> get props =>
      [purchases, total, hasMore, isLoadingMore, currentPage];
}

class PurchaseHistoryError extends PurchaseHistoryState {
  final String message;
  const PurchaseHistoryError(this.message);
  @override
  List<Object?> get props => [message];
}

class PurchaseHistoryCubit extends Cubit<PurchaseHistoryState> {
  final InsuranceRepository _repository;
  String? _userId;

  int _generation = 0;
  static const int _pageSize = 20;

  PurchaseHistoryCubit(this._repository) : super(const PurchaseHistoryInitial());

  void setUserId(String userId) {
    _userId = userId;
  }

  Future<void> load() async {
    if (isClosed) return;
    final uid = _userId;
    if (uid == null || uid.isEmpty) {
      emit(const PurchaseHistoryEmpty());
      return;
    }
    emit(const PurchaseHistoryLoading());
    _generation++;
    final myGen = _generation;
    try {
      final UserInsurancesPage page = await _repository.getUserInsurancesPage(
        userId: uid, page: 1, limit: _pageSize,
      );
      if (isClosed || myGen != _generation) return;
      if (page.insurances.isEmpty) {
        emit(const PurchaseHistoryEmpty());
        return;
      }
      emit(PurchaseHistoryLoaded(
        purchases: page.insurances,
        total: page.totalItems,
        hasMore: page.hasMore,
        isLoadingMore: false,
        currentPage: page.currentPage,
      ));
    } catch (e) {
      if (isClosed || myGen != _generation) return;
      emit(PurchaseHistoryError(_friendlyError(e)));
    }
  }

  Future<void> loadMore() async {
    if (isClosed) return;
    final current = state;
    if (current is! PurchaseHistoryLoaded) return;
    if (!current.hasMore || current.isLoadingMore) return;
    final uid = _userId;
    if (uid == null || uid.isEmpty) return;
    emit(current.copyWith(isLoadingMore: true));
    final myGen = _generation;
    try {
      final nextPage = current.currentPage + 1;
      final page = await _repository.getUserInsurancesPage(
        userId: uid, page: nextPage, limit: _pageSize,
      );
      if (isClosed || myGen != _generation) return;
      final latest = state;
      if (latest is! PurchaseHistoryLoaded) return;
      emit(latest.copyWith(
        purchases: [...latest.purchases, ...page.insurances],
        currentPage: nextPage,
        hasMore: page.hasMore,
        isLoadingMore: false,
      ));
    } catch (_) {
      if (isClosed || myGen != _generation) return;
      final latest = state;
      if (latest is PurchaseHistoryLoaded) {
        emit(latest.copyWith(isLoadingMore: false));
      }
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
    return 'Failed to load your purchase history. Please try again.';
  }
}
