import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math';
import '../../domain/entities/insurance_entity.dart';
import '../../../authentication/domain/entities/user.dart';
import 'create_policy_state.dart';
import '../../../../core/utils/form_field_validators.dart';

/// Cubit for managing insurance policy creation form state across multiple screens
class CreatePolicyCubit extends Cubit<CreatePolicyState> {
  CreatePolicyCubit() : super(const CreatePolicyInitial());

  // Form data
  InsuranceType _insuranceType = InsuranceType.health;
  String _provider = '';
  String _policyHolderName = '';
  String _policyHolderEmail = '';
  String _policyHolderPhone = '';
  double? _premiumAmount;
  double? _coverageAmount;
  String _currency = 'USD';
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(const Duration(days: 365));
  DateTime _nextPaymentDate = DateTime.now().add(const Duration(days: 30));
  List<String> _beneficiaries = [];
  List<String> _features = [];
  Map<String, dynamic> _optionalFields = {};
  bool _isAutoFilled = false;

  // Getters for current form data
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
  Map<String, dynamic> get optionalFields =>
      Map.unmodifiable(_optionalFields);
  bool get isAutoFilled => _isAutoFilled;

  /// Initialize form with auto-fill data from user profile
  void initializeWithUserData(User user) {
    emit(const CreatePolicyLoading());

    _policyHolderName = '${user.firstName} ${user.lastName}'.trim();
    _policyHolderEmail = user.email;
    _policyHolderPhone = user.phoneNumber ?? '';
    _currency = user.currency ?? 'USD';
    _isAutoFilled = true;

    _emitFormUpdated();
  }

  /// Update insurance type
  void updateInsuranceType(InsuranceType type) {
    _insuranceType = type;
    _emitFormUpdated();
  }

  /// Update provider
  void updateProvider(String provider) {
    _provider = provider;
    _emitFormUpdated();
  }

  /// Update policy holder name
  void updatePolicyHolderName(String name) {
    _policyHolderName = name;
    _emitFormUpdated();
  }

  /// Update policy holder email
  void updatePolicyHolderEmail(String email) {
    _policyHolderEmail = email;
    _emitFormUpdated();
  }

  /// Update policy holder phone
  void updatePolicyHolderPhone(String phone) {
    _policyHolderPhone = phone;
    _emitFormUpdated();
  }

  /// Update premium amount
  void updatePremiumAmount(double? amount) {
    _premiumAmount = amount;
    _emitFormUpdated();
  }

  /// Update coverage amount
  void updateCoverageAmount(double? amount) {
    _coverageAmount = amount;
    _emitFormUpdated();
  }

  /// Update currency
  void updateCurrency(String currency) {
    _currency = currency;
    _emitFormUpdated();
  }

  /// Update start date
  void updateStartDate(DateTime date) {
    _startDate = date;
    _emitFormUpdated();
  }

  /// Update end date
  void updateEndDate(DateTime date) {
    _endDate = date;
    _emitFormUpdated();
  }

  /// Update next payment date
  void updateNextPaymentDate(DateTime date) {
    _nextPaymentDate = date;
    _emitFormUpdated();
  }

  /// Add beneficiary
  void addBeneficiary(String beneficiary) {
    if (beneficiary.isNotEmpty && !_beneficiaries.contains(beneficiary)) {
      _beneficiaries = [..._beneficiaries, beneficiary];
      _emitFormUpdated();
    }
  }

  /// Remove beneficiary
  void removeBeneficiary(String beneficiary) {
    _beneficiaries = _beneficiaries.where((b) => b != beneficiary).toList();
    _emitFormUpdated();
  }

  /// Update beneficiaries list
  void updateBeneficiaries(List<String> beneficiaries) {
    _beneficiaries = List.from(beneficiaries);
    _emitFormUpdated();
  }

  /// Add feature
  void addFeature(String feature) {
    if (feature.isNotEmpty && !_features.contains(feature)) {
      _features = [..._features, feature];
      _emitFormUpdated();
    }
  }

  /// Remove feature
  void removeFeature(String feature) {
    _features = _features.where((f) => f != feature).toList();
    _emitFormUpdated();
  }

  /// Update features list
  void updateFeatures(List<String> features) {
    _features = List.from(features);
    _emitFormUpdated();
  }

  /// Update optional field
  void updateOptionalField(String key, dynamic value) {
    _optionalFields = {..._optionalFields, key: value};
    _emitFormUpdated();
  }

  /// Remove optional field
  void removeOptionalField(String key) {
    final newFields = Map<String, dynamic>.from(_optionalFields);
    newFields.remove(key);
    _optionalFields = newFields;
    _emitFormUpdated();
  }

  /// Validate screen 1: Policy Type & Provider
  bool validateScreen1() {
    final errors = <String, String>{};

    if (_provider.isEmpty) {
      errors['provider'] = 'Please select an insurance provider';
    }

    if (errors.isNotEmpty) {
      emit(CreatePolicyValidationError(
        message: 'Please complete all required fields',
        fieldErrors: errors,
      ));
      return false;
    }

    return true;
  }

  /// Validate screen 2: Policy Holder Info
  bool validateScreen2() {
    final errors = <String, String>{};

    // Validate name
    final nameError = FormFieldValidators.validateName(_policyHolderName);
    if (nameError != null) {
      errors['name'] = nameError;
    }

    // Validate email
    final emailError = FormFieldValidators.validateEmail(_policyHolderEmail);
    if (emailError != null) {
      errors['email'] = emailError;
    }

    // Validate phone
    final phoneError = FormFieldValidators.validatePhone(_policyHolderPhone);
    if (phoneError != null) {
      errors['phone'] = phoneError;
    }

    if (errors.isNotEmpty) {
      emit(CreatePolicyValidationError(
        message: 'Please fix the errors in the form',
        fieldErrors: errors,
      ));
      return false;
    }

    return true;
  }

  /// Validate screen 3: Coverage Details
  bool validateScreen3() {
    final errors = <String, String>{};

    // Validate premium amount
    final premiumError = FormFieldValidators.validateAmount(
      _premiumAmount?.toString(),
      fieldName: 'Premium amount',
      minValue: 0.01,
      maxValue: 1000000000,
    );
    if (premiumError != null) {
      errors['premium'] = premiumError;
    }

    // Validate coverage amount
    final coverageError = FormFieldValidators.validateCoverageAmount(
      _coverageAmount?.toString(),
      _premiumAmount?.toString(),
    );
    if (coverageError != null) {
      errors['coverage'] = coverageError;
    }

    // Validate date range
    final dateRangeError = FormFieldValidators.validateDateRange(
      _startDate,
      _endDate,
      minDurationDays: 30,
    );
    if (dateRangeError != null) {
      errors['dateRange'] = dateRangeError;
    }

    // Validate start date bounds
    final startDateError = FormFieldValidators.validateDateBounds(
      _startDate,
      fieldName: 'Start date',
      maxYearsInPast: 1,
      maxYearsInFuture: 10,
    );
    if (startDateError != null) {
      errors['startDate'] = startDateError;
    }

    // Validate payment date
    final paymentDateError = FormFieldValidators.validatePaymentDate(
      _nextPaymentDate,
      _startDate,
      _endDate,
    );
    if (paymentDateError != null) {
      errors['paymentDate'] = paymentDateError;
    }

    if (errors.isNotEmpty) {
      emit(CreatePolicyValidationError(
        message: 'Please fix the errors in the form',
        fieldErrors: errors,
      ));
      return false;
    }

    return true;
  }

  /// Validate screen 4: Beneficiaries & Features (Optional)
  bool validateScreen4() {
    // This screen has no required fields, so always valid
    return true;
  }

  /// Validate screen 5: Review & Optional Fields
  bool validateScreen5() {
    // Validate all previous screens
    return validateScreen1() &&
        validateScreen2() &&
        validateScreen3() &&
        validateScreen4();
  }

  /// Build Insurance entity from form data
  Insurance buildInsurance(String userId) {
    // Generate a unique policy number
    final policyNumber = _generatePolicyNumber();

    // Build coverage details map
    final coverageDetails = <String, dynamic>{
      'features': _features,
      ..._optionalFields,
    };

    return Insurance(
      id: '', // Will be set by backend
      policyNumber: policyNumber,
      policyHolderName: _policyHolderName,
      policyHolderEmail: _policyHolderEmail,
      policyHolderPhone: _policyHolderPhone,
      type: _insuranceType,
      provider: _provider,
      providerLogo: '', // Could be set based on provider name
      premiumAmount: _premiumAmount ?? 0,
      coverageAmount: _coverageAmount ?? 0,
      currency: _currency,
      startDate: _startDate,
      endDate: _endDate,
      nextPaymentDate: _nextPaymentDate,
      status: InsuranceStatus.pending, // Will be active after payment
      beneficiaries: _beneficiaries,
      coverageDetails: coverageDetails,
      description: _optionalFields['description'] as String?,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      userId: userId,
    );
  }

  /// Generate a unique policy number
  String _generatePolicyNumber() {
    final random = Random();
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final randomNum = random.nextInt(9999);

    // Format: INS-YYYYMMDD-XXXX
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

    emit(const CreatePolicyInitial());
  }

  /// Emit form updated state
  void _emitFormUpdated() {
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
