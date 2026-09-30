import 'package:equatable/equatable.dart';
import '../../domain/entities/data_plan_entity.dart';
import '../../domain/entities/data_purchase_entity.dart';

abstract class DataBundlesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DataBundlesInitial extends DataBundlesState {}

class DataBundlesLoading extends DataBundlesState {}

class DataBundlesError extends DataBundlesState {
  final String message;

  DataBundlesError({required this.message});

  @override
  List<Object?> get props => [message];
}

class DataPlansLoaded extends DataBundlesState {
  final List<DataPlanEntity> plans;

  DataPlansLoaded({required this.plans});

  @override
  List<Object?> get props => [plans];
}

class DataBundlesPaymentProcessing extends DataBundlesState {
  final double progress;
  final String currentStep;

  DataBundlesPaymentProcessing({
    required this.progress,
    required this.currentStep,
  });

  @override
  List<Object?> get props => [progress, currentStep];
}

class DataBundlesPaymentSuccess extends DataBundlesState {
  final DataPurchaseEntity purchase;

  DataBundlesPaymentSuccess({required this.purchase});

  @override
  List<Object?> get props => [purchase];
}

class DataBundlesPaymentFailed extends DataBundlesState {
  final String message;

  /// The gRPC status code the backend chose, carried through so the screen can
  /// tell an OUR-FAULT failure from a correctable one from an already-accepted
  /// purchase — and in particular so it can WITHHOLD "Try Again" for the last.
  ///
  /// Re-deriving that from the message text would break the moment the copy
  /// changed, and on a provider with no requery endpoint an offered retry after
  /// code 104 is how one purchase silently becomes two.
  final dynamic statusCode;

  DataBundlesPaymentFailed({required this.message, this.statusCode});

  @override
  List<Object?> get props => [message, statusCode];
}

// ================= Purchase history states =================
class DataPurchaseHistoryLoading extends DataBundlesState {}

class DataPurchaseHistoryLoaded extends DataBundlesState {
  final List<DataPurchaseEntity> purchases;
  final bool isStale;

  DataPurchaseHistoryLoaded({
    required this.purchases,
    this.isStale = false,
  });

  @override
  List<Object?> get props => [purchases, isStale];
}

class DataPurchaseHistoryError extends DataBundlesState {
  final String message;

  DataPurchaseHistoryError({required this.message});

  @override
  List<Object?> get props => [message];
}
