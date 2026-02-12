import 'package:equatable/equatable.dart';
import '../../domain/entities/insurance_entity.dart';
import '../../domain/entities/insurance_product_entity.dart';

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

/// State when data is being loaded
class CreatePolicyLoading extends CreatePolicyState {
  const CreatePolicyLoading();
}

/// State when form data has been updated (legacy manual form flow)
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

// ============================================================
// MyCover.ai Marketplace States
// ============================================================

/// State when insurance categories have been loaded
class InsuranceCategoriesLoaded extends CreatePolicyState {
  final List<InsuranceCategoryInfo> categories;
  final String locale;

  const InsuranceCategoriesLoaded({
    required this.categories,
    required this.locale,
  });

  @override
  List<Object?> get props => [categories, locale];
}

/// State when insurance products are being fetched
class InsuranceProductsLoading extends CreatePolicyState {
  final InsuranceProductCategory? category;

  const InsuranceProductsLoading({this.category});

  @override
  List<Object?> get props => [category];
}

/// State when insurance products have been loaded
class InsuranceProductsLoaded extends CreatePolicyState {
  final List<InsuranceProduct> products;
  final List<InsuranceCategoryInfo> categories;
  final InsuranceProductCategory? selectedCategory;
  final String locale;
  final bool isStale;

  const InsuranceProductsLoaded({
    required this.products,
    required this.categories,
    this.selectedCategory,
    required this.locale,
    this.isStale = false,
  });

  @override
  List<Object?> get props => [products, categories, selectedCategory, locale, isStale];
}

/// State when a product is selected and its form fields are shown
class InsuranceProductSelected extends CreatePolicyState {
  final InsuranceProduct product;
  final Map<String, String> formData;
  final Map<String, String> formErrors;

  const InsuranceProductSelected({
    required this.product,
    this.formData = const {},
    this.formErrors = const {},
  });

  @override
  List<Object?> get props => [product, formData, formErrors];
}

/// State when insurance quote is being fetched
class InsuranceQuoteLoading extends CreatePolicyState {
  final InsuranceProduct product;

  const InsuranceQuoteLoading({required this.product});

  @override
  List<Object?> get props => [product];
}

/// State when insurance quote has been loaded
class InsuranceQuoteLoaded extends CreatePolicyState {
  final InsuranceQuote quote;
  final InsuranceProduct product;
  final Map<String, String> formData;

  const InsuranceQuoteLoaded({
    required this.quote,
    required this.product,
    required this.formData,
  });

  @override
  List<Object?> get props => [quote, product, formData];
}

/// Processing step for insurance purchase progress display
enum InsuranceProcessingStep {
  initiated,
  validatingPin,
  holdingFunds,
  purchasingPolicy,
  completed,
  failed,
}

/// State when insurance purchase is in progress
class InsurancePurchaseProcessing extends CreatePolicyState {
  final InsuranceProcessingStep step;
  final InsuranceProduct product;
  final InsuranceQuote quote;
  final double progress;

  const InsurancePurchaseProcessing({
    required this.step,
    required this.product,
    required this.quote,
    this.progress = 0.0,
  });

  @override
  List<Object?> get props => [step, product, quote, progress];
}

/// State when insurance purchase is successful
class InsurancePurchaseSuccess extends CreatePolicyState {
  final InsurancePurchaseResult purchaseResult;
  final InsuranceProduct product;
  final InsuranceQuote quote;

  const InsurancePurchaseSuccess({
    required this.purchaseResult,
    required this.product,
    required this.quote,
  });

  @override
  List<Object?> get props => [purchaseResult, product, quote];
}

/// State when insurance purchase has been queued for offline retry
class InsurancePurchaseQueued extends CreatePolicyState {
  final String message;

  const InsurancePurchaseQueued({
    this.message = 'Purchase queued. Will retry when online.',
  });

  @override
  List<Object?> get props => [message];
}
