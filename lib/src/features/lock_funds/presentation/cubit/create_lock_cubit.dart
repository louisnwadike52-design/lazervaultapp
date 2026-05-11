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

  /// Whether the current lock qualifies for upfront interest
  /// payment. The dashboard's `supports_upfront_interest` toggle
  /// is the single source of truth — no client-side duration
  /// gate, no per-type override. Operators can configure the rule
  /// (eg "only Year Lock pays upfront") without a Flutter deploy.
  bool get qualifiesForUpfrontInterest {
    final config = getConfigForType(_lockType);
    return config?.supportsUpfrontInterest ?? false;
  }

  // Interest calculation fields
  InterestCalculation? _interestCalculation;
  InterestCalculation? get interestCalculation => _interestCalculation;

  /// Load every plan config from the backend.
  ///
  /// We fetch ALL currencies (not just the user's locale) so a
  /// device set to a currency the admin hasn't configured rows for
  /// still sees the platform's default plans. The
  /// per-currency match happens client-side in [getConfigForType].
  /// Net effect: the wizard always renders SOMETHING as long as
  /// the dashboard has at least one row per plan.
  Future<void> _loadConfigs() async {
    try {
      final repo = serviceLocator<LockFundsRepository>();
      _configs = await repo.getPiggyVaultConfigs(currency: '');
      _configsLoaded = true;
      if (!isClosed) emit(CreateLockState());
    } catch (_) {
      _configsLoaded = true;
      if (!isClosed) emit(CreateLockState());
    }
  }

  /// Resolve the right config row for [type] under the user's
  /// active currency. Three-step preference:
  ///
  ///   1. Exact match on (lockType, currency).
  ///   2. lockType match against NGN — the platform's default
  ///      currency. Operators may not have rolled out per-currency
  ///      pricing yet; falling back here keeps the wizard usable
  ///      instead of dropping to fallback defaults.
  ///   3. First lockType match regardless of currency. Last-resort
  ///      so the wizard still renders chips for an actively
  ///      operating plan even on currencies the dashboard hasn't
  ///      mirrored.
  PiggyVaultConfig? getConfigForType(LockType? type) {
    if (type == null || _configs.isEmpty) return null;
    final typeStr = _lockTypeToConfigString(type);
    final upperCurrency = _currency.toUpperCase();
    PiggyVaultConfig? ngnFallback;
    PiggyVaultConfig? anyFallback;
    for (final c in _configs) {
      if (c.lockType != typeStr) continue;
      if (c.currency.toUpperCase() == upperCurrency) return c;
      if (c.currency.toUpperCase() == 'NGN') {
        ngnFallback ??= c;
      }
      anyFallback ??= c;
    }
    return ngnFallback ?? anyFallback;
  }

  // Every getter below routes through PiggyVaultConfig — the admin
  // dashboard is the single source of truth. The fallbacks
  // sprinkled in are only used during the cold-start window before
  // the config fetch resolves; once the cubit emits with configs
  // loaded, every UI surface re-paints with the real values.
  //
  // Hardcoded fallbacks stay generic (no per-type magic numbers)
  // so changing a plan's rate / duration in the admin dashboard
  // takes effect without a Flutter deploy.

  /// Display name from config; falls back to the enum's static
  /// label (matches the seed) when config hasn't loaded yet.
  String getDisplayName(LockType type) {
    return getConfigForType(type)?.displayName ?? type.displayName;
  }

  /// Description from config. Empty string while loading — UI
  /// hides the description block in that case rather than showing
  /// stale copy.
  String getDescription(LockType type) {
    return getConfigForType(type)?.description ?? '';
  }

  double getBaseRate(LockType type) =>
      getConfigForType(type)?.baseRatePercent ?? 0;

  double getMaxRate(LockType type) =>
      getConfigForType(type)?.maxRatePercent ?? 0;

  double getPenaltyRate(LockType type) =>
      getConfigForType(type)?.penaltyPercent ?? 0;

  int getMinDuration(LockType type) =>
      getConfigForType(type)?.minDurationDays ?? 0;

  int getMaxDuration(LockType type) =>
      getConfigForType(type)?.maxDurationDays ?? 0;

  double getMinAmount(LockType type) =>
      getConfigForType(type)?.minAmount ?? 0;

  bool getAllowsEarlyWithdrawal(LockType type) =>
      getConfigForType(type)?.allowsEarlyWithdrawal ?? false;

  bool getSupportsAutoRenew(LockType type) =>
      getConfigForType(type)?.supportsAutoRenew ?? false;

  bool getSupportsTopUp(LockType type) =>
      getConfigForType(type)?.supportsTopUp ?? false;

  bool getSupportsAutoSave(LockType type) =>
      getConfigForType(type)?.supportsAutoSave ?? false;

  bool isTypeActive(LockType type) =>
      getConfigForType(type)?.isActive ?? true;

  /// True when the plan locks every deposit to the configured
  /// fixed amount; the wizard hides the amount field in this case.
  bool getIsFixedAmount(LockType type) =>
      getConfigForType(type)?.isFixedAmount ?? false;

  double getFixedAmount(LockType type) =>
      getConfigForType(type)?.fixedAmount ?? 0;

  /// Admin-supplied duration chips (days). Empty list means "no
  /// admin override" — callers fall back to a generic preset
  /// filtered by min/max duration.
  List<int> getDurationOptions(LockType type) =>
      getConfigForType(type)?.parsedDurationOptions ?? const [];

  /// Admin-supplied quick-amount pills. Empty list means "free-
  /// form only", which the wizard treats as no-pills.
  List<double> getQuickAmountOptions(LockType type) =>
      getConfigForType(type)?.parsedQuickAmountOptions ?? const [];

  /// Bullets for the Pay & confirm slide's "Before you confirm"
  /// panel. Combines the always-on notes with the auto-renew
  /// variant the admin configured. Each line in the source string
  /// becomes its own bullet; empty lines are dropped so a stray
  /// trailing newline doesn't render an empty bullet.
  List<String> getConfirmationNotes(LockType? type, {required bool autoRenew}) {
    final config = getConfigForType(type);
    if (config == null) return const [];
    final parts = <String>[];
    parts.addAll(_splitNotes(config.confirmationNotes));
    parts.addAll(_splitNotes(
      autoRenew
          ? config.confirmationNotesRenewOn
          : config.confirmationNotesRenewOff,
    ));
    return parts;
  }

  static List<String> _splitNotes(String raw) =>
      raw
          .split('\n')
          .map((s) => s.trim())
          .where((s) => s.isNotEmpty)
          .toList();

  // Backend slug — re-exposed via the enum's `backendKey` getter.
  String _lockTypeToConfigString(LockType type) => type.backendKey;

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
    // Plans whose admin config sets min_duration=0 AND max_duration=0
    // are treated as flex-style (Flex Savings today) — no fixed
    // term required. Any other plan must have a duration selected.
    if (_lockType != null) {
      final minDays = getMinDuration(_lockType!);
      final maxDays = getMaxDuration(_lockType!);
      final isFlex = minDays == 0 && maxDays == 0;
      if (!isFlex) {
        if (_lockDurationDays == null || _lockDurationDays! <= 0) {
          if (isClosed) return false;
          emit(CreateLockValidationError('Please select a lock duration'));
          return false;
        }
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
    // Every lock needs a name, regardless of plan type — the
    // backend column is NOT NULL, the receipt + transaction history
    // both read from it, and "Untitled lock" is a poor UX.
    // Description stays optional; ops asked for the friction-free
    // version so users can lock funds in two taps when they don't
    // have anything specific to add.
    if (_goalName == null || _goalName!.trim().isEmpty) {
      if (isClosed) return false;
      emit(CreateLockValidationError('Please enter a name for this lock'));
      return false;
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
