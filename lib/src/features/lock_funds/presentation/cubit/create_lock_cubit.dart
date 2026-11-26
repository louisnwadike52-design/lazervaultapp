import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/core/config/feature_flags.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
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

  // The stable identity of the plan the user picked — the
  // PiggyVaultConfig UUID. This is what the backend resolves the
  // plan by; `_lockType` below is only kept in sync for the legacy
  // enum-keyed getters and cosmetic icons.
  String? _selectedConfigId;
  String? get selectedConfigId => _selectedConfigId;

  /// The plan the user selected, resolved by its id. Null before a
  /// selection (or if the config list dropped it).
  PiggyVaultConfig? get selectedConfig {
    if (_selectedConfigId == null) return null;
    for (final c in _configs) {
      if (c.id == _selectedConfigId) return c;
    }
    return null;
  }

  /// The active plans to render on the selection step, one card per
  /// backend config. Prefers rows for the user's active currency,
  /// then NGN, then any — so the wizard always shows whatever plans
  /// ops have published rather than a hardcoded set.
  List<PiggyVaultConfig> get activePlans {
    final active = _configs.where((c) => c.isActive).toList();
    if (active.isEmpty) return const [];
    final cur = _currency.toUpperCase();
    final inCur = active.where((c) => c.currency.toUpperCase() == cur).toList();
    if (inCur.isNotEmpty) return inCur;
    final ngn = active.where((c) => c.currency.toUpperCase() == 'NGN').toList();
    if (ngn.isNotEmpty) return ngn;
    return active;
  }

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
  /// Re-fetch the plan list after a failed load.
  ///
  /// Public because the wizard offers a retry rather than hardcoding plans it
  /// cannot price — see _PlansUnavailable in lock_type_selector.dart.
  Future<void> reloadConfigs() async {
    _configsLoaded = false;
    if (!isClosed) emit(CreateLockState());
    await _loadConfigs();
  }

  Future<void> _loadConfigs() async {
    try {
      final repo = serviceLocator<LockFundsRepository>();
      // Pass the user's active locale so the backend can return
      // localized plan strings. LocaleManager is the single source of
      // truth for the active locale across the app (it tracks both
      // country and language; see core/services/locale_manager.dart).
      final activeLocale = serviceLocator<LocaleManager>().currentLocale;
      _configs = await repo.getPiggyVaultConfigs(
        currency: '',
        locale: activeLocale,
      );
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
    // Prefer the explicitly-selected config (resolved by id) when it
    // matches the requested type. This disambiguates the case where
    // ops publish more than one plan sharing a lock_type slug — the
    // name-based resolution below would otherwise pick the first.
    //
    // …AND WHEN THE SELECTED PLAN'S SLUG IS NOT IN THE ENUM AT ALL.
    //
    // THE BUG THIS FIXES, on a live plan. `LockType` knows three slugs —
    // savings, investment, goal_based — and selectConfig falls back to
    // `savings` for anything else, calling the enum "a COSMETIC shadow" that
    // "must not be read as the plan's capabilities". But every capability
    // getter on this cubit (min/max amount, duration, rates, penalty, early
    // withdrawal) resolves through THIS function, with that fallback enum.
    //
    // Half-Year Lock ships as `half_year`, which is not in the enum. So
    // selecting it set _lockType = savings, this guard compared 'half_year'
    // against 'savings', failed, fell through to the name lookup, and handed
    // back the FLEX SAVINGS plan — a different product with a different
    // minimum (₦100 against ₦1,000), a different rate and no fixed term. The
    // wizard then validated a Half-Year deposit against Flex Savings' rules,
    // and Flex is `is_active = false`, so just as often it resolved to null
    // and validated against nothing at all.
    //
    // When the selected plan's slug is one the enum has never heard of, the
    // enum value is a meaningless fallback and the selected config is the only
    // truth there is. Returning it is what makes the enum genuinely cosmetic,
    // as its own comment says it should be.
    final sel = selectedConfig;
    if (sel != null &&
        (sel.lockType == _lockTypeToConfigString(type) ||
            LockTypeX.fromBackendKey(sel.lockType) == null)) {
      return sel;
    }
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

  /// The plan's minimum, or null when the plan is not loaded.
  ///
  /// NULL, NOT ZERO. This returned `?? 0`, and the validator below compares
  /// `amount < minAmount` — so a plan whose config had not loaded validated
  /// every amount as acceptable and then produced a message reading "Minimum
  /// amount is 0". The server now refuses a below-minimum deposit outright
  /// (planAmountViolation), so the user got a rejection with no idea which
  /// number they had missed.
  ///
  /// Null makes "we do not know" distinguishable from "there is no minimum",
  /// and the validator skips rather than inventing a bound.
  double? getMinAmount(LockType type) {
    final min = getConfigForType(type)?.minAmount;
    if (min == null || min <= 0) return null;
    return min;
  }

  /// The plan's ceiling, or null when there isn't one.
  ///
  /// 0 means "no maximum" on this column, consistently with every other
  /// optional bound on the plan, so it maps to null rather than to a limit of
  /// nothing.
  double? getMaxAmount(LockType type) {
    final max = getConfigForType(type)?.maxAmount;
    if (max == null || max <= 0) return null;
    return max;
  }

  bool getAllowsEarlyWithdrawal(LockType type) =>
      getConfigForType(type)?.allowsEarlyWithdrawal ?? false;

  bool getSupportsAutoRenew(LockType type) =>
      getConfigForType(type)?.supportsAutoRenew ?? false;

  bool getSupportsTopUp(LockType type) =>
      getConfigForType(type)?.supportsTopUp ?? false;

  bool getSupportsAutoSave(LockType type) =>
      getConfigForType(type)?.supportsAutoSave ?? false;

  bool isTypeActive(LockType type) => getConfigForType(type)?.isActive ?? true;

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
      raw.split('\n').map((s) => s.trim()).where((s) => s.isNotEmpty).toList();

  /// Whether a plan created right now would be held for review before its
  /// term starts.
  ///
  /// Read from the operator's own switch, never assumed — see
  /// [FeatureFlags.piggyvaultManualActivation]. It defaults to TRUE, so an app
  /// that has not yet synced settings warns rather than over-promises.
  ///
  /// WHAT THIS CANNOT SEE, stated plainly because the gap matters. The server
  /// holds a plan when EITHER this operational switch is on OR the plan's own
  /// `requires_approval` / `approval_threshold_minor` risk gate fires at this
  /// amount. Those two config fields are not on `PiggyVaultConfigProto`, so
  /// the app cannot evaluate the second. While this switch is on — which it is
  /// for as long as deposits reach the asset company by hand — the first gate
  /// dominates and the warning is correct for every plan. If an operator ever
  /// turns it off while leaving a per-plan risk gate configured, large
  /// deposits on that plan would be held with no advance warning here. The
  /// created plan's own status is still the truth everywhere after the fact
  /// (receipt, list, details), so nothing MISREPRESENTS a plan — the warning
  /// is simply absent. Closing it properly means two new proto fields.
  bool get planIsHeldForReview => FeatureFlags.piggyvaultPlansAreReviewed;

  /// The bullets explaining the review gate, for the "Before you confirm"
  /// panel.
  ///
  /// Derived, not admin-authored, and that is the point: this describes how
  /// the platform behaves right now, so it must appear whether or not an
  /// operator remembered to type it into the plan's notes field. The
  /// admin-authored notes still render alongside.
  ///
  /// No turnaround promise. The review ends when funds reach the
  /// asset-management company, which no part of this system can predict, and
  /// a bullet saying "within 24 hours" would be a commitment nothing keeps.
  List<String> get reviewGateNotes {
    if (!planIsHeldForReview) return const [];
    return const [
      'Your plan is reviewed before it starts earning. You will be '
          'notified as soon as it is approved.',
      'Your deposit is set aside from your spendable balance straight '
          'away. It stays in your account, and is released in full if the '
          'plan is not approved.',
      'The term and the interest shown start on approval, not today, so '
          'the maturity date moves by however long the review takes.',
    ];
  }

  // Backend slug — re-exposed via the enum's `backendKey` getter.
  String _lockTypeToConfigString(LockType type) => type.backendKey;

  /// Select a plan by its backend config — the id-first path used by
  /// the plan selector. Records the config's UUID as the stable
  /// identity and keeps `_lockType` in sync (derived from the
  /// config's lock_type slug) for the legacy enum-keyed getters and
  /// cosmetic icons.
  void selectConfig(PiggyVaultConfig config) {
    _selectedConfigId = config.id;
    // The id above is the plan's real identity and is what the create call
    // sends. This enum is a COSMETIC shadow for the legacy by-type lookups,
    // and an admin-defined slug the client has never heard of falls back to
    // savings — harmless for identity, but it must not be read as the plan's
    // capabilities. Anything that needs those reads `selectedConfig`.
    _lockType = LockTypeX.fromBackendKey(config.lockType) ?? LockType.savings;
    if (!config.supportsAutoRenew) {
      _autoRenew = false;
    }
    _autoSelectSingleDuration();
    if (isClosed) return;
    emit(CreateLockState());
  }

  void updateLockType(LockType type) {
    _lockType = type;
    // Keep the id-based identity in sync so the create call resolves
    // the exact plan the user is looking at, even when the enum path
    // is used (legacy callers / tests).
    _selectedConfigId = getConfigForType(type)?.id;
    // Drop a stale auto-renew flag when the newly-selected plan doesn't support
    // auto-renewal (e.g. switching to the Year lock). Otherwise a `true` carried
    // over from a previous plan reaches the backend, which rejects with
    // "<plan> does not support auto-renewal" (INVALID_ARGUMENT).
    if (!getSupportsAutoRenew(type)) {
      _autoRenew = false;
    }
    _autoSelectSingleDuration();
    if (isClosed) return;
    emit(CreateLockState());
  }

  /// When the chosen plan offers exactly ONE duration (e.g. Year Lock = a fixed
  /// 365 days), pre-select it — a single option is not a choice, and this keeps
  /// the auto-selection at the source (robust even if the duration widget builds
  /// before configs load). Switching to a multi-duration plan clears the stale
  /// single-plan pick so the user must choose again.
  void _autoSelectSingleDuration() {
    if (_lockType == null) return;
    final opts = getDurationOptions(_lockType!);
    if (opts.length == 1) {
      _lockDurationDays = opts.first;
    } else if (opts.isNotEmpty && !opts.contains(_lockDurationDays)) {
      _lockDurationDays = null;
    }
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
    // Never allow auto-renew on a plan that doesn't support it (defensive — the
    // toggle is also hidden for those plans).
    _autoRenew = value && _lockType != null && getSupportsAutoRenew(_lockType!);
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
      emit(CreateLockValidationError(
          '${getDisplayName(_lockType!)} is currently unavailable'));
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
      // Skipped, not defaulted, when the plan is unknown — the server is the
      // authority either way, and guessing a bound here would either block a
      // valid deposit or quote a figure that is not the plan's.
      if (minAmount != null && _amount! < minAmount) {
        if (isClosed) return false;
        emit(CreateLockValidationError(
            'The minimum for this plan is '
            '${CurrencySymbols.getSymbol(_currency)}'
            '${minAmount.toStringAsFixed(2)}'));
        return false;
      }
      // The maximum was never checked here at all, so an over-limit deposit
      // reached the server and came back as a bare failure.
      final maxAmount = getMaxAmount(_lockType!);
      if (maxAmount != null && _amount! > maxAmount) {
        if (isClosed) return false;
        emit(CreateLockValidationError(
            'The maximum for this plan is '
            '${CurrencySymbols.getSymbol(_currency)}'
            '${maxAmount.toStringAsFixed(2)}'));
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
      emit(CreateLockValidationError(
          'Please select an account to fund your lock'));
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
    _selectedConfigId = null;
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
