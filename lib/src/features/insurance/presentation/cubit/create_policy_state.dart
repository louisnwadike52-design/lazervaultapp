import 'package:equatable/equatable.dart';
import '../../domain/entities/insurance_entity.dart';

/// Base state for insurance policy creation
abstract class CreatePolicyState extends Equatable {
  const CreatePolicyState();

  @override
  List<Object?> get props => [];
}

/// Initial state when form is first opened
class CreatePolicyInitial extends CreatePolicyState {
  const CreatePolicyInitial();
}

/// State when form data is being loaded (e.g., auto-fill from user profile)
class CreatePolicyLoading extends CreatePolicyState {
  const CreatePolicyLoading();
}

/// State when form data has been updated
class CreatePolicyFormUpdated extends CreatePolicyState {
  final InsuranceType insuranceType;
  final String provider;
  final String policyHolderName;
  final String policyHolderEmail;
  final String policyHolderPhone;
  final double? premiumAmount;
  final double? coverageAmount;
  final String currency;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime nextPaymentDate;
  final List<String> beneficiaries;
  final List<String> features;
  final Map<String, dynamic> optionalFields;
  final bool isAutoFilled;

  const CreatePolicyFormUpdated({
    required this.insuranceType,
    required this.provider,
    required this.policyHolderName,
    required this.policyHolderEmail,
    required this.policyHolderPhone,
    this.premiumAmount,
    this.coverageAmount,
    required this.currency,
    required this.startDate,
    required this.endDate,
    required this.nextPaymentDate,
    required this.beneficiaries,
    required this.features,
    required this.optionalFields,
    this.isAutoFilled = false,
  });

  CreatePolicyFormUpdated copyWith({
    InsuranceType? insuranceType,
    String? provider,
    String? policyHolderName,
    String? policyHolderEmail,
    String? policyHolderPhone,
    double? premiumAmount,
    double? coverageAmount,
    String? currency,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? nextPaymentDate,
    List<String>? beneficiaries,
    List<String>? features,
    Map<String, dynamic>? optionalFields,
    bool? isAutoFilled,
  }) {
    return CreatePolicyFormUpdated(
      insuranceType: insuranceType ?? this.insuranceType,
      provider: provider ?? this.provider,
      policyHolderName: policyHolderName ?? this.policyHolderName,
      policyHolderEmail: policyHolderEmail ?? this.policyHolderEmail,
      policyHolderPhone: policyHolderPhone ?? this.policyHolderPhone,
      premiumAmount: premiumAmount ?? this.premiumAmount,
      coverageAmount: coverageAmount ?? this.coverageAmount,
      currency: currency ?? this.currency,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      nextPaymentDate: nextPaymentDate ?? this.nextPaymentDate,
      beneficiaries: beneficiaries ?? this.beneficiaries,
      features: features ?? this.features,
      optionalFields: optionalFields ?? this.optionalFields,
      isAutoFilled: isAutoFilled ?? this.isAutoFilled,
    );
  }

  @override
  List<Object?> get props => [
        insuranceType,
        provider,
        policyHolderName,
        policyHolderEmail,
        policyHolderPhone,
        premiumAmount,
        coverageAmount,
        currency,
        startDate,
        endDate,
        nextPaymentDate,
        beneficiaries,
        features,
        optionalFields,
        isAutoFilled,
      ];
}

/// State when form validation fails
class CreatePolicyValidationError extends CreatePolicyState {
  final String message;
  final Map<String, String> fieldErrors;

  const CreatePolicyValidationError({
    required this.message,
    this.fieldErrors = const {},
  });

  @override
  List<Object?> get props => [message, fieldErrors];
}

/// State when policy is being created (API call in progress)
class CreatePolicySubmitting extends CreatePolicyState {
  final String message;

  const CreatePolicySubmitting({this.message = 'Creating insurance policy...'});

  @override
  List<Object?> get props => [message];
}

/// State when policy creation is successful
class CreatePolicySuccess extends CreatePolicyState {
  final Insurance insurance;
  final String message;

  const CreatePolicySuccess({
    required this.insurance,
    this.message = 'Insurance policy created successfully',
  });

  @override
  List<Object?> get props => [insurance, message];
}

/// State when policy creation fails
class CreatePolicyError extends CreatePolicyState {
  final String message;
  final String? errorCode;

  const CreatePolicyError({
    required this.message,
    this.errorCode,
  });

  @override
  List<Object?> get props => [message, errorCode];
}
