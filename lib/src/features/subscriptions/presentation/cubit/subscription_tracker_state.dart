import 'package:equatable/equatable.dart';
import 'package:lazervault/src/features/subscriptions/domain/entities/active_subscription_entity.dart';
import 'package:lazervault/src/features/subscriptions/domain/entities/subscription_spending_entity.dart';
import 'package:lazervault/src/features/subscriptions/domain/entities/subscription_summary_entity.dart';

sealed class SubscriptionTrackerState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SubscriptionTrackerInitial extends SubscriptionTrackerState {}

class SubscriptionTrackerLoading extends SubscriptionTrackerState {}

class SubscriptionTrackerError extends SubscriptionTrackerState {
  final String message;

  SubscriptionTrackerError({required this.message});

  @override
  List<Object?> get props => [message];
}

class SubscriptionDashboardLoaded extends SubscriptionTrackerState {
  final SubscriptionSummaryEntity summary;
  final List<ActiveSubscriptionEntity> subscriptions;
  final SubscriptionSpendingEntity spending;
  final bool isStale;

  SubscriptionDashboardLoaded({
    required this.summary,
    required this.subscriptions,
    required this.spending,
    this.isStale = false,
  });

  @override
  List<Object?> get props => [summary, subscriptions, spending, isStale];
}

