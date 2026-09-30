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

  /// The gRPC status code the backend chose, so the screen can tell an
  /// OUR-FAULT failure from a correctable one from a purchase the provider has
  /// already accepted — and withhold "Try Again" for the last. ePINs exposes no
  /// requery endpoint, so a retry after its duplicate code is how one exam PIN
  /// silently becomes two.
  final dynamic statusCode;

  const EducationPurchaseFailed({required this.message, this.statusCode});

  @override
  List<Object?> get props => [message, statusCode];
}

class EducationError extends EducationState {
  final String message;

  const EducationError({required this.message});

  @override
  List<Object?> get props => [message];
}
