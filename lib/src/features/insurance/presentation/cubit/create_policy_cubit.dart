import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grpc/grpc.dart';

import '../../domain/entities/insurance_entity.dart';
import '../../domain/entities/insurance_product_entity.dart';
import '../../domain/repositories/insurance_repository.dart';
import '../../../authentication/domain/entities/user.dart';
import '../../../../../core/cache/cache_config.dart';
import '../../../../../core/cache/swr_cache_manager.dart';
import '../../../../../core/offline/mutation.dart';
import '../../../../../core/offline/mutation_queue.dart';
import '../../../../core/utils/form_field_validators.dart';
import 'create_policy_state.dart';

/// Cubit for managing insurance policy creation via MyCover.ai marketplace
class CreatePolicyCubit extends Cubit<CreatePolicyState> {
  final InsuranceRepository _repository;
  final SWRCacheManager _cacheManager;
  final MutationQueue _mutationQueue;

  CreatePolicyCubit({
    required InsuranceRepository repository,
    required SWRCacheManager cacheManager,
    required MutationQueue mutationQueue,
  })  : _repository = repository,
        _cacheManager = cacheManager,
        _mutationQueue = mutationQueue,
        super(const CreatePolicyInitial());

  // Marketplace state
  String _locale = 'NG';
  InsuranceProductCategory? _selectedCategory;
  List<InsuranceProduct> _products = [];
  List<InsuranceCategoryInfo> _categories = [];
  InsuranceProduct? _selectedProduct;
  Map<String, String> _formData = {};
  InsuranceQuote? _quote;
  String? _selectedAccountId;
  bool _quotePending = false;
  bool _isPurchasing = false;
  String? _lastIdempotencyKey;

  // Legacy form data (kept for backward compat)
  InsuranceType _insuranceType = InsuranceType.health;
  String _provider = '';
  String _policyHolderName = '';
  String _policyHolderEmail = '';
  String _policyHolderPhone = '';
  double? _premiumAmount;
  double? _coverageAmount;
  String _currency = 'NGN';
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(const Duration(days: 365));
  DateTime _nextPaymentDate = DateTime.now().add(const Duration(days: 30));
  List<String> _beneficiaries = [];
  List<String> _features = [];
  Map<String, dynamic> _optionalFields = {};
  bool _isAutoFilled = false;

  // Marketplace getters
  String get locale => _locale;
  InsuranceProductCategory? get selectedCategory => _selectedCategory;
  List<InsuranceProduct> get products => List.unmodifiable(_products);
  List<InsuranceCategoryInfo> get categories => List.unmodifiable(_categories);
  InsuranceProduct? get selectedProduct => _selectedProduct;
  Map<String, String> get formData => Map.unmodifiable(_formData);
  InsuranceQuote? get quote => _quote;
  String? get selectedAccountId => _selectedAccountId;

  // Legacy getters
  InsuranceType get insuranceType => _insuranceType;
  String get provider => _provider;
  String get policyHolderName => _policyHolderName;
  String get policyHolderEmail => _policyHolderEmail;
  String get policyHolderPhone => _policyHolderPhone;
  double? get premiumAmount => _premiumAmount;
  double? get coverageAmount => _coverageAmount;
  String get currency => _currency;
  DateTime get startDate => _startDate;
  DateTime get endDate => _endDate;
  DateTime get nextPaymentDate => _nextPaymentDate;
  List<String> get beneficiaries => List.unmodifiable(_beneficiaries);
  List<String> get features => List.unmodifiable(_features);
  Map<String, dynamic> get optionalFields => Map.unmodifiable(_optionalFields);
  bool get isAutoFilled => _isAutoFilled;

  // ============================================================
  // MyCover.ai Marketplace Methods
  // ============================================================

  /// Initialize with user data - derives locale and loads categories
  void initializeWithUserData(User user) {
    if (isClosed) return;
    emit(const CreatePolicyLoading());

    // Derive locale from user currency
    _locale = _deriveLocale(user.currency ?? 'NGN');
    _currency = user.currency ?? 'NGN';

    // Auto-fill legacy form fields
    _policyHolderName = '${user.firstName} ${user.lastName}'.trim();
    _policyHolderEmail = user.email;
    _policyHolderPhone = user.phoneNumber ?? '';
    _isAutoFilled = true;

    // Load categories for the derived locale
    loadCategories();
  }

  /// Derive locale code from currency
  String _deriveLocale(String currency) {
    switch (currency.toUpperCase()) {
      case 'NGN':
        return 'NG';
      case 'USD':
        return 'US';
      case 'GBP':
        return 'GB';
      case 'EUR':
        return 'EU';
      case 'GHS':
        return 'GH';
      case 'KES':
        return 'KE';
      case 'ZAR':
        return 'ZA';
      default:
        return 'NG'; // Default to Nigeria (MyCover.ai primary market)
    }
  }

  /// Load insurance categories
  Future<void> loadCategories() async {
    if (isClosed) return;

    try {
      _categories = await _repository.getInsuranceCategories(locale: _locale);
      if (isClosed) return;
      emit(InsuranceCategoriesLoaded(categories: _categories, locale: _locale));
    } on GrpcError catch (e) {
      if (isClosed) return;
      if (e.code == StatusCode.failedPrecondition) {
        emit(const CreatePolicyError(
          message: 'Insurance marketplace is not available at this time. Please try again later or contact support.',
        ));
      } else if (e.code == StatusCode.unavailable) {
        emit(const CreatePolicyError(
          message: 'Unable to connect to insurance service. Please check your connection and try again.',
        ));
      } else {
        emit(CreatePolicyError(message: 'Failed to load categories: ${e.message ?? e.toString()}'));
      }
    } catch (e) {
      if (isClosed) return;
      final errorStr = e.toString();
      if (errorStr.contains('not available') ||
          errorStr.contains('not configured') ||
          errorStr.contains('marketplace')) {
        emit(const CreatePolicyError(
          message: 'Insurance marketplace is not available at this time. Please try again later or contact support.',
        ));
      } else if (errorStr.contains('temporarily unavailable')) {
        emit(const CreatePolicyError(
          message: 'Unable to connect to insurance service. Please check your connection and try again.',
        ));
      } else {
        emit(CreatePolicyError(message: 'Failed to load categories: $errorStr'));
      }
    }
  }

  /// Load products for a category with SWR caching
  Future<void> loadProducts({InsuranceProductCategory? category}) async {
    if (isClosed) return;

    _selectedCategory = category;
    emit(InsuranceProductsLoading(category: category));

    final cacheKey = 'insurance_products_${_locale}_${category?.name ?? 'all'}';
    final categoryStr = category?.name;

    try {
      await for (final result in _cacheManager.get<List<InsuranceProduct>>(
        key: cacheKey,
        fetcher: () => _repository.getInsuranceProducts(
          locale: _locale,
          category: categoryStr,
        ),
        config: CacheConfig.insuranceProducts,
        serializer: (products) => jsonEncode(
          products.map((p) => {
            'id': p.id,
            'name': p.name,
            'description': p.description,
            'category': p.category.name,
            'providerName': p.providerName,
            'providerLogo': p.providerLogo,
            'minPremium': p.minPremium,
            'maxPremium': p.maxPremium,
            'currency': p.currency,
            'benefits': p.benefits,
            'termsUrl': p.termsUrl,
            'metadata': p.metadata,
            'formFields': p.formFields.map((f) => {
              'name': f.name,
              'label': f.label,
              'type': f.type,
              'required': f.required,
              'options': f.options,
              'defaultValue': f.defaultValue,
              'validationRegex': f.validationRegex,
              'placeholder': f.placeholder,
              'description': f.description,
            }).toList(),
            'isActive': p.isActive,
            'purchaseRoute': p.purchaseRoute,
            'providerId': p.providerId,
            'basePrice': p.basePrice,
            'howItWorks': p.howItWorks,
            'fullBenefits': p.fullBenefits,
            'isRenewable': p.isRenewable,
            'isClaimable': p.isClaimable,
          }).toList(),
        ),
        deserializer: (json) {
          final list = jsonDecode(json) as List;
          return list.map((j) {
            final map = j as Map<String, dynamic>;
            return InsuranceProduct(
              id: map['id'] as String,
              name: map['name'] as String,
              description: map['description'] as String,
              category: InsuranceProductCategory.fromString(map['category'] as String),
              providerName: map['providerName'] as String,
              providerLogo: (map['providerLogo'] as String?) ?? '',
              minPremium: (map['minPremium'] as num).toDouble(),
              maxPremium: (map['maxPremium'] as num).toDouble(),
              currency: map['currency'] as String,
              benefits: List<String>.from(map['benefits'] as List? ?? []),
              termsUrl: (map['termsUrl'] as String?) ?? '',
              metadata: Map<String, String>.from(map['metadata'] as Map? ?? {}),
              formFields: (map['formFields'] as List? ?? []).map((f) {
                final fm = f as Map<String, dynamic>;
                return InsuranceProductFormField(
                  name: fm['name'] as String? ?? '',
                  label: fm['label'] as String? ?? '',
                  type: fm['type'] as String? ?? 'text',
                  required: fm['required'] as bool? ?? false,
                  options: List<String>.from(fm['options'] as List? ?? []),
                  defaultValue: fm['defaultValue'] as String? ?? '',
                  validationRegex: fm['validationRegex'] as String? ?? '',
                  placeholder: fm['placeholder'] as String? ?? '',
                  description: fm['description'] as String? ?? '',
                );
              }).toList(),
              isActive: (map['isActive'] as bool?) ?? true,
              purchaseRoute: (map['purchaseRoute'] as String?) ?? '',
              providerId: (map['providerId'] as String?) ?? '',
              basePrice: (map['basePrice'] as num?)?.toDouble() ?? 0,
              howItWorks: (map['howItWorks'] as String?) ?? '',
              fullBenefits: (map['fullBenefits'] as String?) ?? '',
              isRenewable: (map['isRenewable'] as bool?) ?? false,
              isClaimable: (map['isClaimable'] as bool?) ?? false,
            );
          }).toList();
        },
      )) {
        if (isClosed) return;
        if (result.data != null) {
          _products = result.data!;
          emit(InsuranceProductsLoaded(
            products: _products,
            categories: _categories,
            selectedCategory: _selectedCategory,
            locale: _locale,
            isStale: result.isStale,
          ));
        }
      }
    } catch (e) {
      if (isClosed) return;
      emit(CreatePolicyError(message: 'Failed to load products: $e'));
    }
  }

  /// Select a product and prepare for form filling
  void selectProduct(InsuranceProduct product) {
    if (isClosed) return;
    _selectedProduct = product;
    _formData = {};

    // Pre-fill default values from form fields
    for (final field in product.formFields) {
      if (field.defaultValue.isNotEmpty) {
        _formData[field.name] = field.defaultValue;
      }
    }

    // Auto-fill common fields from user data
    for (final field in product.formFields) {
      final name = field.name.toLowerCase();
      if (name.contains('email') && _policyHolderEmail.isNotEmpty) {
        _formData[field.name] = _policyHolderEmail;
      } else if (name.contains('phone') && _policyHolderPhone.isNotEmpty) {
        _formData[field.name] = _policyHolderPhone;
      } else if ((name.contains('name') || name.contains('first_name')) && _policyHolderName.isNotEmpty) {
        _formData[field.name] = _policyHolderName;
      }
    }

    emit(InsuranceProductSelected(product: product, formData: _formData));
  }

  /// Update a form field value
  void updateFormField(String name, String value) {
    if (isClosed) return;

    // Trim text values (not dropdowns/booleans)
    final trimmedValue = (value == 'true' || value == 'false') ? value : value.trim();
    _formData = {..._formData, name: trimmedValue};

    if (_selectedProduct != null) {
      emit(InsuranceProductSelected(
        product: _selectedProduct!,
        formData: _formData,
      ));
    }
  }

  /// Validate dynamic form fields and return true if valid
  bool validateFormFields() {
    if (_selectedProduct == null) return false;

    final errors = <String, String>{};
    for (final field in _selectedProduct!.formFields) {
      final value = _formData[field.name] ?? '';
      if (field.required && value.isEmpty) {
        errors[field.name] = '${field.label} is required';
      } else if (value.isNotEmpty && field.validationRegex.isNotEmpty) {
        try {
          final regex = RegExp(field.validationRegex);
          if (!regex.hasMatch(value)) {
            errors[field.name] = 'Invalid ${field.label.toLowerCase()}';
          }
        } catch (_) {
          // Malformed regex from provider - skip regex validation
        }
      }
    }

    if (errors.isNotEmpty) {
      if (isClosed) return false;
      emit(InsuranceProductSelected(
        product: _selectedProduct!,
        formData: _formData,
        formErrors: errors,
      ));
      return false;
    }

    return true;
  }

  /// Get a quote for the selected product with current form data
  Future<void> getQuote() async {
    if (isClosed || _selectedProduct == null) return;
    if (_quotePending) return; // Prevent concurrent quote requests

    if (!validateFormFields()) return;

    _quotePending = true;
    emit(InsuranceQuoteLoading(product: _selectedProduct!));

    try {
      _quote = await _repository.getInsuranceQuote(
        productId: _selectedProduct!.id,
        formData: _formData,
        locale: _locale,
      );

      // Reset idempotency key when a new quote is obtained
      _lastIdempotencyKey = null;

      if (isClosed) return;
      emit(InsuranceQuoteLoaded(
        quote: _quote!,
        product: _selectedProduct!,
        formData: _formData,
      ));
    } catch (e) {
      if (isClosed) return;
      emit(CreatePolicyError(message: 'Failed to get quote: $e'));
    } finally {
      _quotePending = false;
    }
  }

  /// Set the selected account for payment
  void selectAccount(String accountId) {
    _selectedAccountId = accountId;
    // Re-emit current state so UI can update
    if (_quote != null && _selectedProduct != null) {
      emit(InsuranceQuoteLoaded(
        quote: _quote!,
        product: _selectedProduct!,
        formData: _formData,
      ));
    }
  }

  /// Check if an error is a network/connectivity error
  bool _isNetworkError(dynamic error) {
    if (error is GrpcError) {
      return error.code == StatusCode.unavailable ||
          error.code == StatusCode.deadlineExceeded ||
          error.code == StatusCode.unknown;
    }
    final s = error.toString().toLowerCase();
    return s.contains('network') || s.contains('connection') || s.contains('socket');
  }

  /// Purchase insurance with the current quote
  Future<void> purchaseInsurance({
    required String accountId,
    required String transactionPin,
  }) async {
    if (isClosed || _selectedProduct == null || _quote == null) return;
    if (_isPurchasing) return;

    // Check quote expiry
    if (_quote!.isExpired) {
      emit(const CreatePolicyError(message: 'Quote has expired. Please get a new quote.'));
      return;
    }

    _isPurchasing = true;

    _selectedAccountId = accountId;

    // Reuse idempotency key on retry, generate new one for genuinely new purchases
    _lastIdempotencyKey ??= _generateIdempotencyKey(
      _quote!.quoteId,
      _selectedProduct!.id,
      _quote!.premium,
    );
    final idempotencyKey = _lastIdempotencyKey!;

    // Emit initial processing state
    emit(InsurancePurchaseProcessing(
      step: InsuranceProcessingStep.initiated,
      product: _selectedProduct!,
      quote: _quote!,
      progress: 0.1,
    ));

    try {
      final result = await _repository.purchaseInsurance(
        quoteId: _quote!.quoteId,
        productId: _selectedProduct!.id,
        accountId: accountId,
        transactionPin: transactionPin,
        idempotencyKey: idempotencyKey,
        formData: _formData,
        locale: _locale,
      );

      if (isClosed) return;

      // Clear idempotency key after successful purchase
      _lastIdempotencyKey = null;

      emit(InsurancePurchaseSuccess(
        purchaseResult: result,
        product: _selectedProduct!,
        quote: _quote!,
      ));

      // Invalidate product cache since user now has a policy
      _cacheManager.invalidatePattern('insurance_products_');
    } on GrpcError catch (e) {
      if (isClosed) return;
      if (_isNetworkError(e)) {
        // Queue for offline retry
        await _mutationQueue.enqueue(QueuedMutation.create(
          type: MutationType.generic,
          payload: {
            'action': 'purchase_insurance',
            'quoteId': _quote!.quoteId,
            'productId': _selectedProduct!.id,
            'accountId': accountId,
            'idempotencyKey': idempotencyKey,
            'formData': _formData,
            'locale': _locale,
          },
          description: 'Insurance purchase: ${_selectedProduct!.name}',
        ));
        emit(const InsurancePurchaseQueued());
      } else {
        emit(CreatePolicyError(
          message: e.message ?? 'Failed to purchase insurance',
          errorCode: e.code.toString(),
        ));
      }
    } catch (e) {
      if (isClosed) return;
      emit(CreatePolicyError(message: 'Failed to purchase insurance: $e'));
    } finally {
      _isPurchasing = false;
    }
  }

  /// Generate idempotency key from purchase parameters
  String _generateIdempotencyKey(String quoteId, String productId, double premium) {
    final now = DateTime.now();
    final minuteTruncated = DateTime(now.year, now.month, now.day, now.hour, now.minute);
    final input = '$quoteId:$productId:$premium:${minuteTruncated.toIso8601String()}';
    return sha256.convert(utf8.encode(input)).toString();
  }

  /// Check purchase status by reference
  Future<void> checkPurchaseStatus(String reference) async {
    if (isClosed) return;

    try {
      final result = await _repository.getInsurancePurchaseStatus(reference: reference);
      if (isClosed) return;

      if (result.isCompleted && _selectedProduct != null && _quote != null) {
        emit(InsurancePurchaseSuccess(
          purchaseResult: result,
          product: _selectedProduct!,
          quote: _quote!,
        ));
      }
    } catch (e) {
      developer.log('checkPurchaseStatus failed for reference=$reference: $e',
          name: 'CreatePolicyCubit');
    }
  }

  // ============================================================
  // Legacy Manual Form Methods (preserved for backward compat)
  // ============================================================

  void updateInsuranceType(InsuranceType type) {
    _insuranceType = type;
    _emitFormUpdated();
  }

  void updateProvider(String provider) {
    _provider = provider;
    _emitFormUpdated();
  }

  void updatePolicyHolderName(String name) {
    _policyHolderName = name;
    _emitFormUpdated();
  }

  void updatePolicyHolderEmail(String email) {
    _policyHolderEmail = email;
    _emitFormUpdated();
  }

  void updatePolicyHolderPhone(String phone) {
    _policyHolderPhone = phone;
    _emitFormUpdated();
  }

  void updatePremiumAmount(double? amount) {
    _premiumAmount = amount;
    _emitFormUpdated();
  }

  void updateCoverageAmount(double? amount) {
    _coverageAmount = amount;
    _emitFormUpdated();
  }

  void updateCurrency(String currency) {
    _currency = currency;
    _emitFormUpdated();
  }

  void updateStartDate(DateTime date) {
    _startDate = date;
    _emitFormUpdated();
  }

  void updateEndDate(DateTime date) {
    _endDate = date;
    _emitFormUpdated();
  }

  void updateNextPaymentDate(DateTime date) {
    _nextPaymentDate = date;
    _emitFormUpdated();
  }

  void addBeneficiary(String beneficiary) {
    if (beneficiary.isNotEmpty && !_beneficiaries.contains(beneficiary)) {
      _beneficiaries = [..._beneficiaries, beneficiary];
      _emitFormUpdated();
    }
  }

  void removeBeneficiary(String beneficiary) {
    _beneficiaries = _beneficiaries.where((b) => b != beneficiary).toList();
    _emitFormUpdated();
  }

  void updateBeneficiaries(List<String> beneficiaries) {
    _beneficiaries = List.from(beneficiaries);
    _emitFormUpdated();
  }

  void addFeature(String feature) {
    if (feature.isNotEmpty && !_features.contains(feature)) {
      _features = [..._features, feature];
      _emitFormUpdated();
    }
  }

  void removeFeature(String feature) {
    _features = _features.where((f) => f != feature).toList();
    _emitFormUpdated();
  }

  void updateFeatures(List<String> features) {
    _features = List.from(features);
    _emitFormUpdated();
  }

  void updateOptionalField(String key, dynamic value) {
    _optionalFields = {..._optionalFields, key: value};
    _emitFormUpdated();
  }

  void removeOptionalField(String key) {
    final newFields = Map<String, dynamic>.from(_optionalFields);
    newFields.remove(key);
    _optionalFields = newFields;
    _emitFormUpdated();
  }

  bool validateScreen1() {
    final errors = <String, String>{};
    if (_provider.isEmpty) {
      errors['provider'] = 'Please select an insurance provider';
    }
    if (errors.isNotEmpty) {
      if (isClosed) return false;
      emit(CreatePolicyValidationError(
        message: 'Please complete all required fields',
        fieldErrors: errors,
      ));
      return false;
    }
    return true;
  }

  bool validateScreen2() {
    final errors = <String, String>{};
    final nameError = FormFieldValidators.validateName(_policyHolderName);
    if (nameError != null) errors['name'] = nameError;
    final emailError = FormFieldValidators.validateEmail(_policyHolderEmail);
    if (emailError != null) errors['email'] = emailError;
    final phoneError = FormFieldValidators.validatePhone(_policyHolderPhone);
    if (phoneError != null) errors['phone'] = phoneError;
    if (errors.isNotEmpty) {
      if (isClosed) return false;
      emit(CreatePolicyValidationError(
        message: 'Please fix the errors in the form',
        fieldErrors: errors,
      ));
      return false;
    }
    return true;
  }

  bool validateScreen3() {
    final errors = <String, String>{};
    final premiumError = FormFieldValidators.validateAmount(
      _premiumAmount?.toString(),
      fieldName: 'Premium amount',
      minValue: 0.01,
      maxValue: 1000000000,
    );
    if (premiumError != null) errors['premium'] = premiumError;
    final coverageError = FormFieldValidators.validateCoverageAmount(
      _coverageAmount?.toString(),
      _premiumAmount?.toString(),
    );
    if (coverageError != null) errors['coverage'] = coverageError;
    final dateRangeError = FormFieldValidators.validateDateRange(
      _startDate, _endDate, minDurationDays: 30,
    );
    if (dateRangeError != null) errors['dateRange'] = dateRangeError;
    final startDateError = FormFieldValidators.validateDateBounds(
      _startDate, fieldName: 'Start date', maxYearsInPast: 1, maxYearsInFuture: 10,
    );
    if (startDateError != null) errors['startDate'] = startDateError;
    final paymentDateError = FormFieldValidators.validatePaymentDate(
      _nextPaymentDate, _startDate, _endDate,
    );
    if (paymentDateError != null) errors['paymentDate'] = paymentDateError;
    if (errors.isNotEmpty) {
      if (isClosed) return false;
      emit(CreatePolicyValidationError(
        message: 'Please fix the errors in the form',
        fieldErrors: errors,
      ));
      return false;
    }
    return true;
  }

  bool validateScreen4() => true;

  bool validateScreen5() {
    return validateScreen1() && validateScreen2() && validateScreen3() && validateScreen4();
  }

  Insurance buildInsurance(String userId) {
    final policyNumber = _generatePolicyNumber();
    final coverageDetails = <String, dynamic>{
      'features': _features,
      ..._optionalFields,
    };
    return Insurance(
      id: '',
      policyNumber: policyNumber,
      policyHolderName: _policyHolderName,
      policyHolderEmail: _policyHolderEmail,
      policyHolderPhone: _policyHolderPhone,
      type: _insuranceType,
      provider: _provider,
      providerLogo: '',
      premiumAmount: _premiumAmount ?? 0,
      coverageAmount: _coverageAmount ?? 0,
      currency: _currency,
      startDate: _startDate,
      endDate: _endDate,
      nextPaymentDate: _nextPaymentDate,
      status: InsuranceStatus.pending,
      beneficiaries: _beneficiaries,
      coverageDetails: coverageDetails,
      description: _optionalFields['description'] as String?,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      userId: userId,
    );
  }

  String _generatePolicyNumber() {
    final random = Random();
    final randomNum = random.nextInt(9999);
    final date = DateTime.now();
    final dateStr =
        '${date.year}${date.month.toString().padLeft(2, '0')}${date.day.toString().padLeft(2, '0')}';
    return 'INS-$dateStr-${randomNum.toString().padLeft(4, '0')}';
  }

  /// Reset form to initial state
  void reset() {
    _insuranceType = InsuranceType.health;
    _provider = '';
    _policyHolderName = '';
    _policyHolderEmail = '';
    _policyHolderPhone = '';
    _premiumAmount = null;
    _coverageAmount = null;
    _currency = 'USD';
    _startDate = DateTime.now();
    _endDate = DateTime.now().add(const Duration(days: 365));
    _nextPaymentDate = DateTime.now().add(const Duration(days: 30));
    _beneficiaries = [];
    _features = [];
    _optionalFields = {};
    _isAutoFilled = false;

    // Reset marketplace state
    _selectedCategory = null;
    _products = [];
    _selectedProduct = null;
    _formData = {};
    _quote = null;
    _selectedAccountId = null;

    if (isClosed) return;
    emit(const CreatePolicyInitial());
  }

  void _emitFormUpdated() {
    if (isClosed) return;
    emit(CreatePolicyFormUpdated(
      insuranceType: _insuranceType,
      provider: _provider,
      policyHolderName: _policyHolderName,
      policyHolderEmail: _policyHolderEmail,
      policyHolderPhone: _policyHolderPhone,
      premiumAmount: _premiumAmount,
      coverageAmount: _coverageAmount,
      currency: _currency,
      startDate: _startDate,
      endDate: _endDate,
      nextPaymentDate: _nextPaymentDate,
      beneficiaries: _beneficiaries,
      features: _features,
      optionalFields: _optionalFields,
      isAutoFilled: _isAutoFilled,
    ));
  }
}
