import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/lock_fund_entity.dart';

class CreateLockCubit extends Cubit<CreateLockState> {
  CreateLockCubit() : super(CreateLockState());

  // Form data
  LockType? _lockType;
  double? _amount;
  String _currency = 'USD';
  int? _lockDurationDays;
  bool _autoRenew = false;
  String? _goalName;
  String? _goalDescription;
  String? _paymentMethod;

  // Getters
  LockType? get lockType => _lockType;
  double? get amount => _amount;
  String get currency => _currency;
  int? get lockDurationDays => _lockDurationDays;
  bool get autoRenew => _autoRenew;
  String? get goalName => _goalName;
  String? get goalDescription => _goalDescription;
  String? get paymentMethod => _paymentMethod;

  // Interest calculation fields
  InterestCalculation? _interestCalculation;
  InterestCalculation? get interestCalculation => _interestCalculation;

  void updateLockType(LockType type) {
    _lockType = type;
    if (isClosed) return;
    emit(CreateLockState());
  }

  void updateAmount(double amount) {
    _amount = amount;
    if (isClosed) return;
    emit(CreateLockState());
  }

  void updateCurrency(String currency) {
    _currency = currency;
    if (isClosed) return;
    emit(CreateLockState());
  }

  void initializeWithUserCurrency(String? userCurrency) {
    if (userCurrency != null && userCurrency.isNotEmpty) {
      _currency = userCurrency;
      if (isClosed) return;
      emit(CreateLockState());
    }
  }

  void updateLockDuration(int days) {
    _lockDurationDays = days;
    if (isClosed) return;
    emit(CreateLockState());
  }

  void updateAutoRenew(bool value) {
    _autoRenew = value;
    if (isClosed) return;
    emit(CreateLockState());
  }

  void updateGoalName(String? name) {
    _goalName = name;
    if (isClosed) return;
    emit(CreateLockState());
  }

  void updateGoalDescription(String? description) {
    _goalDescription = description;
    if (isClosed) return;
    emit(CreateLockState());
  }

  void updatePaymentMethod(String method) {
    _paymentMethod = method;
    if (isClosed) return;
    emit(CreateLockState());
  }

  void updateInterestCalculation(InterestCalculation calculation) {
    _interestCalculation = calculation;
    if (isClosed) return;
    emit(CreateLockState());
  }

  // Validation methods
  bool validateStep1() {
    if (_lockType == null) {
      if (isClosed) return false;
      emit(CreateLockValidationError('Please select a lock type'));
      return false;
    }
    return true;
  }

  bool validateStep2() {
    if (_amount == null || _amount! <= 0) {
      if (isClosed) return false;
      emit(CreateLockValidationError('Please enter a valid amount'));
      return false;
    }
    if (_lockDurationDays == null || _lockDurationDays! <= 0) {
      if (isClosed) return false;
      emit(CreateLockValidationError('Please select a lock duration'));
      return false;
    }
    return true;
  }

  bool validateStep3() {
    // Step 3 is for goal details - only required if lock type is goal-based
    if (_lockType == LockType.goalBased) {
      if (_goalName == null || _goalName!.trim().isEmpty) {
        if (isClosed) return false;
        emit(CreateLockValidationError('Please enter a goal name'));
        return false;
      }
    }
    return true;
  }

  bool validateStep4() {
    // Step 4 is review - validate all fields
    return validateStep1() && validateStep2() && validateStep3();
  }

  bool validateStep5() {
    if (_paymentMethod == null || _paymentMethod!.isEmpty) {
      if (isClosed) return false;
      emit(CreateLockValidationError('Please select a payment method'));
      return false;
    }
    return true;
  }

  void clearValidationError() {
    if (state is CreateLockValidationError) {
      if (isClosed) return;
      emit(CreateLockState());
    }
  }

  void reset() {
    _lockType = null;
    _amount = null;
    _currency = 'USD';
    _lockDurationDays = null;
    _autoRenew = false;
    _goalName = null;
    _goalDescription = null;
    _paymentMethod = null;
    _interestCalculation = null;
    if (isClosed) return;
    emit(CreateLockState());
  }
}

class CreateLockState {}

class CreateLockValidationError extends CreateLockState {
  final String message;
  CreateLockValidationError(this.message);
}
