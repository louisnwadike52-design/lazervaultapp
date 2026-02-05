import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/group_entities.dart';
import '../../data/datasources/group_account_remote_data_source.dart';
import 'create_contribution_state.dart';

/// Cubit for managing contribution creation form state across multiple screens
class CreateContributionCubit extends Cubit<CreateContributionState> {
  final GroupAccountRemoteDataSource _dataSource;
  final String groupId;
  final List<GroupMember> groupMembers;
  final String createdBy;

  CreateContributionCubit({
    required GroupAccountRemoteDataSource dataSource,
    required this.groupId,
    required this.groupMembers,
    required this.createdBy,
  })  : _dataSource = dataSource,
        super(const CreateContributionInitial()) {
    _initializeForm();
  }

  // Form data
  ContributionType _type = ContributionType.oneTime;
  String _title = '';
  String _description = '';
  double? _targetAmount;
  String _currency = 'USD';
  DateTime _deadline = DateTime.now().add(const Duration(days: 30));
  ContributionFrequency? _frequency;
  double? _regularAmount;
  DateTime? _startDate;
  int? _totalCycles;
  List<String> _memberRotationOrder = [];
  bool _autoPayEnabled = false;
  bool _allowPartialPayments = true;
  double? _penaltyAmount;
  int? _gracePeriodDays;
  double? _minimumBalance;
  bool _showAdvancedFields = false;
  int _currentStep = 0;

  // Getters for current form data
  ContributionType get type => _type;
  String get title => _title;
  String get description => _description;
  double? get targetAmount => _targetAmount;
  String get currency => _currency;
  DateTime get deadline => _deadline;
  ContributionFrequency? get frequency => _frequency;
  double? get regularAmount => _regularAmount;
  DateTime? get startDate => _startDate;
  int? get totalCycles => _totalCycles;
  List<String> get memberRotationOrder => List.unmodifiable(_memberRotationOrder);
  bool get autoPayEnabled => _autoPayEnabled;
  bool get allowPartialPayments => _allowPartialPayments;
  double? get penaltyAmount => _penaltyAmount;
  int? get gracePeriodDays => _gracePeriodDays;
  double? get minimumBalance => _minimumBalance;
  bool get showAdvancedFields => _showAdvancedFields;
  int get currentStep => _currentStep;

  /// Check if schedule step should be shown
  bool get shouldShowScheduleStep => _type != ContributionType.oneTime;

  /// Get total number of steps based on contribution type
  int get totalSteps {
    if (_type == ContributionType.oneTime) {
      return 4; // Type, Basic, Advanced, Review
    } else {
      return 5; // Type, Basic, Schedule, Advanced, Review
    }
  }

  /// Initialize form with default values
  void _initializeForm() {
    if (isClosed) return;

    // Initialize rotation order with active members
    _memberRotationOrder = groupMembers
        .where((m) => m.status == GroupMemberStatus.active)
        .map((m) => m.userId)
        .toList();

    _emitFormUpdated();
  }

  /// Update contribution type
  void updateType(ContributionType type) {
    _type = type;

    // Reset type-specific fields
    if (type == ContributionType.oneTime) {
      _frequency = null;
      _autoPayEnabled = false;
    } else if (type == ContributionType.rotatingSavings) {
      _frequency ??= ContributionFrequency.monthly;
      _autoPayEnabled = false; // Manual payments for transparency in rotating savings
    } else {
      _frequency ??= ContributionFrequency.monthly;
    }

    _emitFormUpdated();
  }

  /// Update title
  void updateTitle(String title) {
    _title = title;
    _emitFormUpdated();
  }

  /// Update description
  void updateDescription(String description) {
    _description = description;
    _emitFormUpdated();
  }

  /// Update target amount
  void updateTargetAmount(double? amount) {
    _targetAmount = amount;
    _emitFormUpdated();
  }

  /// Update currency
  void updateCurrency(String currency) {
    _currency = currency;
    _emitFormUpdated();
  }

  /// Update deadline
  void updateDeadline(DateTime deadline) {
    _deadline = deadline;
    _emitFormUpdated();
  }

  /// Update frequency
  void updateFrequency(ContributionFrequency? frequency) {
    _frequency = frequency;
    _emitFormUpdated();
  }

  /// Update regular amount
  void updateRegularAmount(double? amount) {
    _regularAmount = amount;
    _emitFormUpdated();
  }

  /// Update start date
  void updateStartDate(DateTime? date) {
    _startDate = date;
    _emitFormUpdated();
  }

  /// Update total cycles
  void updateTotalCycles(int? cycles) {
    _totalCycles = cycles;
    _emitFormUpdated();
  }

  /// Update member rotation order
  void updateMemberRotationOrder(List<String> order) {
    _memberRotationOrder = List.from(order);
    _emitFormUpdated();
  }

  /// Reorder member in rotation
  void reorderMember(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) newIndex--;
    final item = _memberRotationOrder.removeAt(oldIndex);
    _memberRotationOrder.insert(newIndex, item);
    _emitFormUpdated();
  }

  /// Update auto-pay enabled
  void updateAutoPayEnabled(bool enabled) {
    // For rotating savings, auto-pay should remain off for transparency
    if (_type == ContributionType.rotatingSavings) {
      _autoPayEnabled = false;
    } else {
      _autoPayEnabled = enabled;
    }
    _emitFormUpdated();
  }

  /// Update allow partial payments
  void updateAllowPartialPayments(bool allowed) {
    _allowPartialPayments = allowed;
    _emitFormUpdated();
  }

  /// Update penalty amount
  void updatePenaltyAmount(double? amount) {
    _penaltyAmount = amount;
    _emitFormUpdated();
  }

  /// Update grace period days
  void updateGracePeriodDays(int? days) {
    _gracePeriodDays = days;
    _emitFormUpdated();
  }

  /// Update minimum balance
  void updateMinimumBalance(double? amount) {
    _minimumBalance = amount;
    _emitFormUpdated();
  }

  /// Toggle advanced fields visibility
  void toggleAdvancedFields() {
    _showAdvancedFields = !_showAdvancedFields;
    _emitFormUpdated();
  }

  /// Update current step
  void updateCurrentStep(int step) {
    _currentStep = step;
    _emitFormUpdated();
  }

  /// Navigate to next step if validation passes
  bool goToNextStep() {
    if (!validateCurrentStep()) {
      return false;
    }

    if (_currentStep < totalSteps - 1) {
      _currentStep++;
      _emitFormUpdated();
      return true;
    }
    return false;
  }

  /// Navigate to previous step
  void goToPreviousStep() {
    if (_currentStep > 0) {
      _currentStep--;
      _emitFormUpdated();
    }
  }

  /// Validate current step
  bool validateCurrentStep() {
    switch (_currentStep) {
      case 0:
        return validateStep1();
      case 1:
        return validateStep2();
      case 2:
        if (shouldShowScheduleStep) {
          return validateStep3();
        } else {
          return validateStep4(); // Skip to advanced for one-time
        }
      case 3:
        if (shouldShowScheduleStep) {
          return validateStep4();
        } else {
          return validateStep5(); // Review for one-time
        }
      case 4:
        return validateStep5();
      default:
        return true;
    }
  }

  /// Validate Step 1: Type Selection
  bool validateStep1() {
    // Type is always selected, so always valid
    return true;
  }

  /// Validate Step 2: Basic Information
  bool validateStep2() {
    final errors = <String, String>{};

    // Title validation (max 100 chars)
    if (_title.trim().isEmpty) {
      errors['title'] = 'Title is required';
    } else if (_title.length > 100) {
      errors['title'] = 'Title must be at most 100 characters';
    }

    // Description validation (max 500 chars)
    if (_description.trim().isEmpty) {
      errors['description'] = 'Description is required';
    } else if (_description.length > 500) {
      errors['description'] = 'Description must be at most 500 characters';
    }

    // Target amount validation
    if (_targetAmount == null || _targetAmount! <= 0) {
      errors['targetAmount'] = 'Target amount must be greater than 0';
    }

    // Deadline validation (must be today or later)
    if (_deadline.isBefore(DateTime.now().subtract(const Duration(days: 1)))) {
      errors['deadline'] = 'Deadline must be today or in the future';
    }

    if (errors.isNotEmpty) {
      if (isClosed) return false;
      emit(CreateContributionValidationError(
        message: 'Please fix the errors in the form',
        fieldErrors: errors,
      ));
      return false;
    }

    return true;
  }

  /// Validate Step 3: Schedule Settings
  bool validateStep3() {
    if (_type == ContributionType.oneTime) {
      return true; // Skip validation for one-time contributions
    }

    final errors = <String, String>{};

    // Frequency validation
    if (_frequency == null) {
      errors['frequency'] = 'Payment frequency is required';
    }

    // Regular amount validation
    if (_regularAmount == null || _regularAmount! <= 0) {
      errors['regularAmount'] = 'Regular payment amount must be greater than 0';
    }

    // Start date validation (if provided)
    if (_startDate != null && _startDate!.isBefore(DateTime.now().subtract(const Duration(days: 1)))) {
      errors['startDate'] = 'Start date must be today or in the future';
    }

    // Total cycles validation (if provided)
    if (_totalCycles != null && _totalCycles! <= 0) {
      errors['totalCycles'] = 'Total cycles must be a positive number';
    }

    if (errors.isNotEmpty) {
      if (isClosed) return false;
      emit(CreateContributionValidationError(
        message: 'Please fix the errors in the form',
        fieldErrors: errors,
      ));
      return false;
    }

    return true;
  }

  /// Validate Step 4: Advanced Settings
  bool validateStep4() {
    final errors = <String, String>{};

    // Penalty amount validation (if provided)
    if (_penaltyAmount != null && _penaltyAmount! < 0) {
      errors['penaltyAmount'] = 'Penalty amount cannot be negative';
    }

    // Grace period validation (if provided)
    if (_gracePeriodDays != null && _gracePeriodDays! < 0) {
      errors['gracePeriodDays'] = 'Grace period cannot be negative';
    }

    // Minimum balance validation (if provided)
    if (_minimumBalance != null && _minimumBalance! < 0) {
      errors['minimumBalance'] = 'Minimum balance cannot be negative';
    }

    if (errors.isNotEmpty) {
      if (isClosed) return false;
      emit(CreateContributionValidationError(
        message: 'Please fix the errors in the form',
        fieldErrors: errors,
      ));
      return false;
    }

    return true;
  }

  /// Validate Step 5: Review (validates all previous steps)
  bool validateStep5() {
    return validateStep1() && validateStep2() &&
           (shouldShowScheduleStep ? validateStep3() : true) &&
           validateStep4();
  }

  /// Submit the contribution
  Future<void> submitContribution() async {
    if (!validateStep5()) return;

    if (isClosed) return;
    emit(const CreateContributionSubmitting());

    try {
      final contribution = await _dataSource.createContribution(
        groupId: groupId,
        title: _title.trim(),
        description: _description.trim(),
        targetAmount: _targetAmount!,
        currency: _currency,
        deadline: _deadline,
        createdBy: createdBy,
        type: _type,
        frequency: _frequency,
        regularAmount: _regularAmount,
        startDate: _startDate,
        totalCycles: _totalCycles,
        memberRotationOrder: _type == ContributionType.rotatingSavings ? _memberRotationOrder : null,
        autoPayEnabled: _autoPayEnabled,
        penaltyAmount: _penaltyAmount,
        gracePeriodDays: _gracePeriodDays,
        allowPartialPayments: _allowPartialPayments,
        minimumBalance: _minimumBalance,
      );

      if (isClosed) return;
      emit(CreateContributionSuccess(
        contribution: contribution,
        message: 'Contribution created successfully',
      ));
    } catch (e) {
      if (isClosed) return;
      emit(CreateContributionError(
        message: 'Failed to create contribution: ${e.toString()}',
      ));
    }
  }

  /// Reset form to initial state
  void reset() {
    _type = ContributionType.oneTime;
    _title = '';
    _description = '';
    _targetAmount = null;
    _currency = 'USD';
    _deadline = DateTime.now().add(const Duration(days: 30));
    _frequency = null;
    _regularAmount = null;
    _startDate = null;
    _totalCycles = null;
    _memberRotationOrder = groupMembers
        .where((m) => m.status == GroupMemberStatus.active)
        .map((m) => m.userId)
        .toList();
    _autoPayEnabled = false;
    _allowPartialPayments = true;
    _penaltyAmount = null;
    _gracePeriodDays = null;
    _minimumBalance = null;
    _showAdvancedFields = false;
    _currentStep = 0;

    if (isClosed) return;
    emit(const CreateContributionInitial());
    _emitFormUpdated();
  }

  /// Emit form updated state
  void _emitFormUpdated() {
    if (isClosed) return;
    emit(CreateContributionFormUpdated(
      type: _type,
      title: _title,
      description: _description,
      targetAmount: _targetAmount,
      currency: _currency,
      deadline: _deadline,
      frequency: _frequency,
      regularAmount: _regularAmount,
      startDate: _startDate,
      totalCycles: _totalCycles,
      memberRotationOrder: _memberRotationOrder,
      autoPayEnabled: _autoPayEnabled,
      allowPartialPayments: _allowPartialPayments,
      penaltyAmount: _penaltyAmount,
      gracePeriodDays: _gracePeriodDays,
      minimumBalance: _minimumBalance,
      showAdvancedFields: _showAdvancedFields,
      currentStep: _currentStep,
    ));
  }
}
