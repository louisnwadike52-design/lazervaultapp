import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/services/injection_container.dart';
import '../../../../../core/services/locale_manager.dart';
import '../../domain/entities/lock_fund_entity.dart';
import '../../domain/repositories/lock_funds_repository.dart';

class CreateLockCubit extends Cubit<CreateLockState> {
  CreateLockCubit() : super(CreateLockState()) {
    _currency = serviceLocator<LocaleManager>().currentCurrency;
    _loadConfigs();
  }

  // Backend-configurable product configs
  List<PiggyVaultConfig> _configs = [];
  List<PiggyVaultConfig> get configs => _configs;
  bool _configsLoaded = false;
  bool get configsLoaded => _configsLoaded;

  // Form data
  LockType? _lockType;
  double? _amount;
  late String _currency;
  int? _lockDurationDays;
  bool _autoRenew = false;
  String? _goalName;
  String? _goalDescription;
  String? _paymentMethod;
  String? _selectedAccountId;
  String? _interestDestinationAccountId;

  // Getters
  LockType? get lockType => _lockType;
  double? get amount => _amount;
  String get currency => _currency;
  int? get lockDurationDays => _lockDurationDays;
  bool get autoRenew => _autoRenew;
  String? get goalName => _goalName;
  String? get goalDescription => _goalDescription;
  String? get paymentMethod => _paymentMethod;
  String? get selectedAccountId => _selectedAccountId;
  String? get interestDestinationAccountId => _interestDestinationAccountId;

  /// Whether the current lock qualifies for upfront interest payment
  bool get qualifiesForUpfrontInterest {
    final config = getConfigForType(_lockType);
    if (config != null) {
      return (_lockDurationDays ?? 0) >= 180 && config.supportsUpfrontInterest;
    }
    return (_lockDurationDays ?? 0) >= 180 &&
        (_lockType?.supportsUpfrontInterest ?? false);
  }

  // Interest calculation fields
  InterestCalculation? _interestCalculation;
  InterestCalculation? get interestCalculation => _interestCalculation;

  /// Load backend-configurable product configs on init
  Future<void> _loadConfigs() async {
    try {
      final repo = serviceLocator<LockFundsRepository>();
      _configs = await repo.getPiggyVaultConfigs(currency: _currency);
      _configsLoaded = true;
      if (!isClosed) emit(CreateLockState());
    } catch (_) {
      // Fallback to hardcoded values — configs remain empty
      _configsLoaded = true;
      if (!isClosed) emit(CreateLockState());
    }
  }

  /// Get backend config for a given lock type. Returns null if not found (uses fallbacks).
  PiggyVaultConfig? getConfigForType(LockType? type) {
    if (type == null || _configs.isEmpty) return null;
    final typeStr = _lockTypeToConfigString(type);
    for (final c in _configs) {
      if (c.lockType == typeStr) return c;
    }
    return null;
  }

  /// Get display name from config or fallback
  String getDisplayName(LockType type) {
    return getConfigForType(type)?.displayName ?? type.displayName;
  }

  /// Get description from config or fallback
  String getDescription(LockType type) {
    return getConfigForType(type)?.description ?? type.description;
  }

  /// Get base interest rate (as percentage, e.g. 10.0) from config or fallback
  double getBaseRate(LockType type) {
    final config = getConfigForType(type);
    if (config != null) return config.baseRatePercent;
    return type.fallbackBaseRate;
  }

  /// Get max interest rate (as percentage) from config or fallback
  double getMaxRate(LockType type) {
    final config = getConfigForType(type);
    if (config != null) return config.maxRatePercent;
    return type.fallbackMaxRate;
  }

  /// Get penalty rate (as percentage) from config or fallback
  double getPenaltyRate(LockType type) {
    final config = getConfigForType(type);
    if (config != null) return config.penaltyPercent;
    return type.fallbackPenalty;
  }

  /// Get min duration from config or fallback
  int getMinDuration(LockType type) {
    final config = getConfigForType(type);
    if (config != null) return config.minDurationDays;
    return type.fallbackMinDuration;
  }

  /// Get max duration from config or fallback
  int getMaxDuration(LockType type) {
    final config = getConfigForType(type);
    if (config != null) return config.maxDurationDays;
    return type.fallbackMaxDuration;
  }

  /// Get min amount from config
  double getMinAmount(LockType type) {
    return getConfigForType(type)?.minAmount ?? 100;
  }

  /// Whether this lock type allows early withdrawal
  bool getAllowsEarlyWithdrawal(LockType type) {
    final config = getConfigForType(type);
    if (config != null) return config.allowsEarlyWithdrawal;
    return type.fallbackAllowsEarlyWithdrawal;
  }

  /// Whether this lock type supports auto-renew
  bool getSupportsAutoRenew(LockType type) {
    final config = getConfigForType(type);
    if (config != null) return config.supportsAutoRenew;
    return type.fallbackSupportsAutoRenew;
  }

  /// Whether this lock type supports top-up
  bool getSupportsTopUp(LockType type) {
    final config = getConfigForType(type);
    if (config != null) return config.supportsTopUp;
    return type.supportsTopUp;
  }

  /// Whether this lock type supports auto-save
  bool getSupportsAutoSave(LockType type) {
    final config = getConfigForType(type);
    if (config != null) return config.supportsAutoSave;
    return type.supportsAutoSave;
  }

  /// Whether this lock type is active (available for creation)
  bool isTypeActive(LockType type) {
    final config = getConfigForType(type);
    if (config != null) return config.isActive;
    return true; // Default to active if no config
  }

  String _lockTypeToConfigString(LockType type) {
    switch (type) {
      case LockType.savings:
        return 'savings';
      case LockType.investment:
        return 'investment';
      case LockType.emergencyFund:
        return 'emergency';
      case LockType.goalBased:
        return 'goal_based';
    }
  }

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

  void updateSelectedAccount(String accountId) {
    _selectedAccountId = accountId;
    _interestDestinationAccountId ??= accountId;
    if (isClosed) return;
    emit(CreateLockState());
  }

  void updateInterestDestinationAccount(String accountId) {
    _interestDestinationAccountId = accountId;
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
    if (!isTypeActive(_lockType!)) {
      if (isClosed) return false;
      emit(CreateLockValidationError('${getDisplayName(_lockType!)} is currently unavailable'));
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
    if (_lockType != null) {
      final minAmount = getMinAmount(_lockType!);
      if (_amount! < minAmount) {
        if (isClosed) return false;
        emit(CreateLockValidationError('Minimum amount is ${minAmount.toStringAsFixed(0)}'));
        return false;
      }
    }
    if (_lockType != LockType.emergencyFund) {
      if (_lockDurationDays == null || _lockDurationDays! <= 0) {
        if (isClosed) return false;
        emit(CreateLockValidationError('Please select a lock duration'));
        return false;
      }
      if (_lockType != null) {
        final minDays = getMinDuration(_lockType!);
        final maxDays = getMaxDuration(_lockType!);
        if (minDays > 0 && _lockDurationDays! < minDays) {
          if (isClosed) return false;
          emit(CreateLockValidationError('Minimum duration is $minDays days'));
          return false;
        }
        if (maxDays > 0 && _lockDurationDays! > maxDays) {
          if (isClosed) return false;
          emit(CreateLockValidationError('Maximum duration is $maxDays days'));
          return false;
        }
      }
    }
    return true;
  }

  bool validateStep3() {
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
    return validateStep1() && validateStep2() && validateStep3();
  }

  bool validateStep5() {
    if (_selectedAccountId == null || _selectedAccountId!.isEmpty) {
      if (isClosed) return false;
      emit(CreateLockValidationError('Please select an account to fund your lock'));
      return false;
    }
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
    _currency = serviceLocator<LocaleManager>().currentCurrency;
    _lockDurationDays = null;
    _autoRenew = false;
    _goalName = null;
    _goalDescription = null;
    _paymentMethod = null;
    _selectedAccountId = null;
    _interestDestinationAccountId = null;
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
