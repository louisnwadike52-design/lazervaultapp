import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/src/features/subscriptions/domain/entities/active_subscription_entity.dart';
import 'package:lazervault/src/features/subscriptions/domain/entities/subscription_spending_entity.dart';
import 'package:lazervault/src/features/subscriptions/domain/entities/subscription_summary_entity.dart';
import 'package:lazervault/src/features/subscriptions/domain/usecases/get_active_subscriptions_usecase.dart';
import 'package:lazervault/src/features/subscriptions/domain/usecases/get_subscription_spending_usecase.dart';
import 'package:lazervault/src/features/subscriptions/domain/usecases/get_subscription_summary_usecase.dart';
import 'package:lazervault/src/features/subscriptions/presentation/cubit/subscription_tracker_state.dart';

class SubscriptionTrackerCubit extends Cubit<SubscriptionTrackerState> {
  final GetActiveSubscriptionsUsecase _getActiveSubscriptions;
  final GetSubscriptionSummaryUsecase _getSubscriptionSummary;
  final GetSubscriptionSpendingUsecase _getSubscriptionSpending;

  SubscriptionTrackerCubit({
    required GetActiveSubscriptionsUsecase getActiveSubscriptions,
    required GetSubscriptionSummaryUsecase getSubscriptionSummary,
    required GetSubscriptionSpendingUsecase getSubscriptionSpending,
  })  : _getActiveSubscriptions = getActiveSubscriptions,
        _getSubscriptionSummary = getSubscriptionSummary,
        _getSubscriptionSpending = getSubscriptionSpending,
        super(SubscriptionTrackerInitial());

  Future<void> loadDashboard() async {
    if (isClosed) return;
    emit(SubscriptionTrackerLoading());

    // Call each use case separately to get proper types
    final summaryResult = await _getSubscriptionSummary();
    final subscriptionsResult = await _getActiveSubscriptions();
    final spendingResult = await _getSubscriptionSpending();

    if (isClosed) return;

    String? errorMessage;
    SubscriptionSummaryEntity? summary;
    List<ActiveSubscriptionEntity>? subscriptions;
    SubscriptionSpendingEntity? spending;

    summaryResult.fold(
      (failure) => errorMessage = failure.message,
      (data) => summary = data,
    );

    subscriptionsResult.fold(
      (failure) => errorMessage ??= failure.message,
      (data) => subscriptions = data.$1,
    );

    spendingResult.fold(
      (failure) => errorMessage ??= failure.message,
      (data) => spending = data,
    );

    if (isClosed) return;

    if (summary != null && subscriptions != null && spending != null) {
      emit(SubscriptionDashboardLoaded(
        summary: summary!,
        subscriptions: subscriptions!,
        spending: spending!,
      ));
    } else {
      emit(SubscriptionTrackerError(
        message: errorMessage ?? 'Failed to load subscription data',
      ));
    }
  }

  Future<void> loadByType(String? type) async {
    if (isClosed) return;
    emit(SubscriptionTrackerLoading());

    final result = await _getActiveSubscriptions(type: type);

    if (isClosed) return;

    List<ActiveSubscriptionEntity>? subscriptions;
    String? subsError;

    result.fold(
      (failure) => subsError = failure.message,
      (data) => subscriptions = data.$1,
    );

    if (subsError != null || subscriptions == null) {
      if (!isClosed) {
        emit(SubscriptionTrackerError(
          message: subsError ?? 'Failed to load subscriptions',
        ));
      }
      return;
    }

    // Load summary and spending for full dashboard context
    final summaryResult = await _getSubscriptionSummary();
    final spendingResult = await _getSubscriptionSpending();

    if (isClosed) return;

    SubscriptionSummaryEntity? summary;
    SubscriptionSpendingEntity? spending;

    summaryResult.fold(
      (failure) {},
      (data) => summary = data,
    );

    spendingResult.fold(
      (failure) {},
      (data) => spending = data,
    );

    if (isClosed) return;

    if (summary != null && spending != null) {
      emit(SubscriptionDashboardLoaded(
        summary: summary!,
        subscriptions: subscriptions!,
        spending: spending!,
      ));
    } else {
      emit(SubscriptionTrackerError(
        message: 'Failed to load subscription data',
      ));
    }
  }

  Future<void> refreshAll() async {
    await loadDashboard();
  }
}
