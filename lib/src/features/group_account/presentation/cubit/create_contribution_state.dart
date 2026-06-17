import 'package:equatable/equatable.dart';
import '../../domain/entities/group_entities.dart';

/// Base state for contribution creation form
abstract class CreateContributionState extends Equatable {
  const CreateContributionState();

  @override
  List<Object?> get props => [];
}

/// Initial state when form is first opened
class CreateContributionInitial extends CreateContributionState {
  const CreateContributionInitial();
}

/// State when form data is being loaded
class CreateContributionLoading extends CreateContributionState {
  const CreateContributionLoading();
}

/// State when form data has been updated
class CreateContributionFormUpdated extends CreateContributionState {
  // Step 1: Type Selection
  final ContributionType type;

  // Step 2: Basic Information (Required)
  final String title;
  final String description;
  final double? targetAmount;
  final String currency;
  final DateTime deadline;

  // Step 3: Schedule Settings (Conditional - skip for oneTime)
  final ContributionFrequency? frequency;
  final double? regularAmount;
  final DateTime? startDate;
  final int? totalCycles;
  final List<String> memberRotationOrder;

  // Step 4: Advanced Settings (Optional with Switches)
  final bool autoPayEnabled;
  final bool allowPartialPayments;
  final double? penaltyAmount;
  final int? gracePeriodDays;
  final double? minimumBalance;

  // UI State
  final bool showAdvancedFields;
  final int currentStep;

  const CreateContributionFormUpdated({
    required this.type,
    required this.title,
    required this.description,
    this.targetAmount,
    required this.currency,
    required this.deadline,
    this.frequency,
    this.regularAmount,
    this.startDate,
    this.totalCycles,
    this.memberRotationOrder = const [],
    this.autoPayEnabled = false,
    this.allowPartialPayments = true,
    this.penaltyAmount,
    this.gracePeriodDays,
    this.minimumBalance,
    this.showAdvancedFields = false,
    this.currentStep = 0,
  });

  CreateContributionFormUpdated copyWith({
    ContributionType? type,
    String? title,
    String? description,
    double? targetAmount,
    String? currency,
    DateTime? deadline,
    ContributionFrequency? frequency,
    double? regularAmount,
    DateTime? startDate,
    int? totalCycles,
    List<String>? memberRotationOrder,
    bool? autoPayEnabled,
    bool? allowPartialPayments,
    double? penaltyAmount,
    int? gracePeriodDays,
    double? minimumBalance,
    bool? showAdvancedFields,
    int? currentStep,
  }) {
    return CreateContributionFormUpdated(
      type: type ?? this.type,
      title: title ?? this.title,
      description: description ?? this.description,
      targetAmount: targetAmount ?? this.targetAmount,
      currency: currency ?? this.currency,
      deadline: deadline ?? this.deadline,
      frequency: frequency ?? this.frequency,
      regularAmount: regularAmount ?? this.regularAmount,
      startDate: startDate ?? this.startDate,
      totalCycles: totalCycles ?? this.totalCycles,
      memberRotationOrder: memberRotationOrder ?? this.memberRotationOrder,
      autoPayEnabled: autoPayEnabled ?? this.autoPayEnabled,
      allowPartialPayments: allowPartialPayments ?? this.allowPartialPayments,
      penaltyAmount: penaltyAmount ?? this.penaltyAmount,
      gracePeriodDays: gracePeriodDays ?? this.gracePeriodDays,
      minimumBalance: minimumBalance ?? this.minimumBalance,
      showAdvancedFields: showAdvancedFields ?? this.showAdvancedFields,
      currentStep: currentStep ?? this.currentStep,
    );
  }

  /// Check if schedule step should be shown (not for one-time contributions)
  bool get shouldShowScheduleStep => type != ContributionType.oneTime;

  /// Check if rotation order step should be shown (only for rotating savings)
  bool get shouldShowRotationStep => type == ContributionType.rotatingSavings;

  /// Get total number of steps based on contribution type
  int get totalSteps {
    if (type == ContributionType.oneTime) {
      return 4; // Type, Basic, Advanced, Review
    } else {
      return 5; // Type, Basic, Schedule, Advanced, Review
    }
  }

  @override
  List<Object?> get props => [
        type,
        title,
        description,
        targetAmount,
        currency,
        deadline,
        frequency,
        regularAmount,
        startDate,
        totalCycles,
        memberRotationOrder,
        autoPayEnabled,
        allowPartialPayments,
        penaltyAmount,
        gracePeriodDays,
        minimumBalance,
        showAdvancedFields,
        currentStep,
      ];
}

/// State when form validation fails
class CreateContributionValidationError extends CreateContributionState {
  final String message;
  final Map<String, String> fieldErrors;

  const CreateContributionValidationError({
    required this.message,
    this.fieldErrors = const {},
  });

  @override
  List<Object?> get props => [message, fieldErrors];
}

/// State when contribution is being created
class CreateContributionSubmitting extends CreateContributionState {
  final String message;

  const CreateContributionSubmitting({
    this.message = 'Creating contribution...',
  });

  @override
  List<Object?> get props => [message];
}

/// State when contribution creation is successful
class CreateContributionSuccess extends CreateContributionState {
  final Contribution contribution;
  final String message;

  const CreateContributionSuccess({
    required this.contribution,
    this.message = 'Contribution created successfully',
  });

  @override
  List<Object?> get props => [contribution, message];
}

/// State when contribution creation fails
class CreateContributionError extends CreateContributionState {
  final String message;
  final String? errorCode;

  const CreateContributionError({
    required this.message,
    this.errorCode,
  });

  @override
  List<Object?> get props => [message, errorCode];
}
