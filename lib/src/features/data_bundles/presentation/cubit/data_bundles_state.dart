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

  DataBundlesPaymentFailed({required this.message});

  @override
  List<Object?> get props => [message];
}
