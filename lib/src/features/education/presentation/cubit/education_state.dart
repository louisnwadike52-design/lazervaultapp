import 'package:equatable/equatable.dart';
import '../../domain/entities/education_provider_entity.dart';
import '../../domain/entities/education_purchase_entity.dart';

abstract class EducationState extends Equatable {
  const EducationState();

  @override
  List<Object?> get props => [];
}

class EducationInitial extends EducationState {}

class EducationLoading extends EducationState {}

class EducationProvidersLoaded extends EducationState {
  final List<EducationProviderEntity> providers;

  const EducationProvidersLoaded({required this.providers});

  @override
  List<Object?> get props => [providers];
}

class EducationPurchaseProcessing extends EducationState {
  final double progress;
  final String currentStep;

  const EducationPurchaseProcessing({
    this.progress = 0.1,
    this.currentStep = 'Initializing purchase...',
  });

  EducationPurchaseProcessing copyWith({
    double? progress,
    String? currentStep,
  }) {
    return EducationPurchaseProcessing(
      progress: progress ?? this.progress,
      currentStep: currentStep ?? this.currentStep,
    );
  }

  @override
  List<Object?> get props => [progress, currentStep];
}

class EducationPurchaseSuccess extends EducationState {
  final EducationPurchaseEntity purchase;

  const EducationPurchaseSuccess({required this.purchase});

  @override
  List<Object?> get props => [purchase];
}

class EducationPurchaseFailed extends EducationState {
  final String message;

  const EducationPurchaseFailed({required this.message});

  @override
  List<Object?> get props => [message];
}

class EducationError extends EducationState {
  final String message;

  const EducationError({required this.message});

  @override
  List<Object?> get props => [message];
}
