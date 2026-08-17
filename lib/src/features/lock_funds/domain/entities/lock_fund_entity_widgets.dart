part of 'lock_fund_entity.dart';

/// Lock types matching the three plans the platform offers today.
/// Every visible attribute (display name, %, duration, amount range,
/// description) is loaded from PiggyVaultConfig at runtime — see
/// `loadPiggyVaultConfigsUseCase`. This enum only carries the stable
/// backend slug, plus a couple of safe defaults used when the
/// network is unreachable on first paint.
enum LockType {
  /// Flex Savings — withdraw anytime; mirrors a regular savings
  /// account. Default rate is 10% but the actual figure is admin-
  /// configurable via piggyvault_configs.
  savings,

  /// Treasury Lock — treasury-bills-linked. Locked for the
  /// configured timeframe; no early withdrawal.
  investment,

  /// Year Lock — fixed one-year lock. Highest return on the
  /// platform; least flexibility.
  goalBased;

  /// Backend slug. The seed in accounts-service uses these strings
  /// verbatim; never localise them.
  String get backendKey {
    switch (this) {
      case LockType.savings:
        return 'savings';
      case LockType.investment:
        return 'investment';
      case LockType.goalBased:
        return 'goal_based';
    }
  }

  /// Fallback display name when the live PiggyVaultConfig hasn't
  /// loaded yet (cold-start, offline). The admin-supplied
  /// display_name takes precedence — see PiggyVaultConfig.displayName.
  String get displayName {
    switch (this) {
      case LockType.savings:
        return 'Flex Savings';
      case LockType.investment:
        return 'Treasury Lock';
      case LockType.goalBased:
        return 'Year Lock';
    }
  }

  /// Static glyph used as a chip icon. Cosmetic, so kept in code
  /// rather than driven by config — easy to change here without an
  /// admin-side migration.
  String get icon {
    switch (this) {
      case LockType.savings:
        return '🔐';
      case LockType.investment:
        return '💎';
      case LockType.goalBased:
        return '🎯';
    }
  }

  /// Whether mid-lock top-up is offered for this plan, used as the
  /// UI affordance gate on the details screen. Mirrors the
  /// supports_top_up flag the admin dashboard sets on
  /// piggyvault_configs for each plan. The backend is the
  /// authoritative gate — this just keeps the button hidden when
  /// the action would be rejected. Defaults track the seed:
  ///   savings  → Flex top-up supported
  ///   others   → rate locked at issue, no top-up
  bool get defaultSupportsTopUp => this == LockType.savings;

  /// Whether recurring auto-save into this lock is offered. Same
  /// seed-aligned defaults as defaultSupportsTopUp: only the Flex
  /// plan supports recurring deposits today.
  bool get defaultSupportsAutoSave => this == LockType.savings;

  /// Whether the user can renew the lock for another term. Flex
  /// has no fixed term so "renew" doesn't apply; the other two
  /// plans both support manual renewal.
  bool get defaultSupportsRenewal {
    switch (this) {
      case LockType.savings:
        return false;
      case LockType.investment:
      case LockType.goalBased:
        return true;
    }
  }
}

/// Helpers for mapping the backend `lock_type` slug onto the legacy
/// display enum. Plans are identified by their config UUID end-to-end;
/// this mapping only drives cosmetic bits (icon) and the enum-keyed
/// getters kept for back-compat.
extension LockTypeX on LockType {
  /// Resolve the display enum from a backend lock_type slug. Returns
  /// null for admin-defined slugs the enum doesn't know about — the
  /// caller decides the fallback (typically savings for icons).
  static LockType? fromBackendKey(String key) {
    switch (key.trim().toLowerCase()) {
      case 'savings':
        return LockType.savings;
      case 'investment':
        return LockType.investment;
      case 'goal_based':
        return LockType.goalBased;
      default:
        return null;
    }
  }
}

enum LockStatus {
  active,
  matured,
  unlocked,
  cancelled;

  String get displayName {
    switch (this) {
      case LockStatus.active:
        return 'Active';
      case LockStatus.matured:
        return 'Matured';
      case LockStatus.unlocked:
        return 'Withdrawn';
      case LockStatus.cancelled:
        return 'Cancelled';
    }
  }

  String get description {
    switch (this) {
      case LockStatus.active:
        return 'Your funds are locked and earning interest';
      case LockStatus.matured:
        return 'Lock period complete! Withdraw or renew';
      case LockStatus.unlocked:
        return 'Funds have been withdrawn to your account';
      case LockStatus.cancelled:
        return 'This lock was cancelled';
    }
  }

  bool get isTerminal => this == LockStatus.unlocked || this == LockStatus.cancelled;
}

/// Backend-configurable PiggyVault product configuration
class PiggyVaultConfig {
  final String id;
  final String lockType;
  final String currency;
  final String displayName;
  final double baseInterestRate; // Decimal (0.10 = 10%)
  final double maxInterestRate;
  final double earlyWithdrawalPenalty;
  final int minDurationDays;
  final int maxDurationDays;
  final double minAmount;
  final double maxAmount;
  /// When true, the wizard hides the amount input and locks every
  /// deposit to [fixedAmount]. Useful for promotional fixed-headline
  /// plans configured by ops via the admin dashboard.
  final bool isFixedAmount;
  final double fixedAmount;
  /// Raw JSON arrays from the admin dashboard. Empty arrays mean
  /// "no chips defined; client falls back to a generic preset".
  /// See [parsedDurationOptions] / [parsedQuickAmountOptions] for
  /// safe accessors.
  final String durationOptions;
  final String quickAmountOptions;
  /// Newline-separated bullets the admin sets for the
  /// "Before you confirm" panel. confirmationNotes is always shown;
  /// confirmationNotesRenewOn / confirmationNotesRenewOff are
  /// appended below it based on the user's auto-renew toggle.
  final String confirmationNotes;
  final String confirmationNotesRenewOn;
  final String confirmationNotesRenewOff;
  final bool allowsEarlyWithdrawal;
  final bool supportsAutoRenew;
  final bool supportsTopUp;
  final bool supportsAutoSave;
  final bool supportsUpfrontInterest;
  final String durationBonusTiers; // JSON string
  final bool isActive;
  final String description;

  const PiggyVaultConfig({
    required this.id,
    required this.lockType,
    required this.currency,
    required this.displayName,
    required this.baseInterestRate,
    required this.maxInterestRate,
    required this.earlyWithdrawalPenalty,
    required this.minDurationDays,
    required this.maxDurationDays,
    required this.minAmount,
    this.maxAmount = 0,
    this.isFixedAmount = false,
    this.fixedAmount = 0,
    this.durationOptions = '[]',
    this.quickAmountOptions = '[]',
    this.confirmationNotes = '',
    this.confirmationNotesRenewOn = '',
    this.confirmationNotesRenewOff = '',
    required this.allowsEarlyWithdrawal,
    required this.supportsAutoRenew,
    this.supportsTopUp = false,
    this.supportsAutoSave = false,
    this.supportsUpfrontInterest = false,
    this.durationBonusTiers = '[]',
    this.isActive = true,
    this.description = '',
  });

  /// Base rate as percentage (e.g. 10.0 for 10%)
  double get baseRatePercent => baseInterestRate * 100;

  /// Max rate as percentage (e.g. 13.0 for 13%)
  double get maxRatePercent => maxInterestRate * 100;

  /// Penalty as percentage (e.g. 5.0 for 5%)
  double get penaltyPercent => earlyWithdrawalPenalty * 100;

  /// Display string for interest range (e.g. "10% - 13% p.a.")
  String get interestRangeText {
    if (baseRatePercent == maxRatePercent) {
      return '${baseRatePercent.toStringAsFixed(0)}% p.a.';
    }
    return '${baseRatePercent.toStringAsFixed(0)}% - ${maxRatePercent.toStringAsFixed(0)}% p.a.';
  }

  /// Parsed duration chip set from the admin-supplied JSON array.
  /// Out-of-range values are dropped so a typo on the admin form
  /// can't slip a 1000-day chip into a plan capped at 365. Returns
  /// an empty list when the JSON is empty / malformed — callers
  /// fall back to their own preset in that case.
  List<int> get parsedDurationOptions {
    final raw = durationOptions.trim();
    if (raw.isEmpty || raw == '[]') return const [];
    try {
      final decoded = _safeDecode(raw);
      if (decoded is! List) return const [];
      return decoded
          .map((v) {
            if (v is num) return v.toInt();
            return int.tryParse('$v') ?? -1;
          })
          .where((d) => d > 0 &&
              d >= minDurationDays &&
              (maxDurationDays == 0 || d <= maxDurationDays))
          .toList()
        ..sort();
    } catch (_) {
      return const [];
    }
  }

  /// Parsed quick-amount pills from the admin-supplied JSON array.
  /// Filters against [minAmount] / [maxAmount] so an out-of-range
  /// pill can't sneak past the wizard's per-step validators.
  List<double> get parsedQuickAmountOptions {
    final raw = quickAmountOptions.trim();
    if (raw.isEmpty || raw == '[]') return const [];
    try {
      final decoded = _safeDecode(raw);
      if (decoded is! List) return const [];
      return decoded
          .map((v) {
            if (v is num) return v.toDouble();
            return double.tryParse('$v') ?? -1;
          })
          .where((a) =>
              a > 0 &&
              a >= minAmount &&
              (maxAmount == 0 || a <= maxAmount))
          .toList()
        ..sort();
    } catch (_) {
      return const [];
    }
  }
}

/// Lock fund auto-save configuration
class LockFundAutoSaveConfig {
  final String id;
  final String lockFundId;
  final String sourceAccountId;
  final double amount;
  final String frequency; // "daily", "weekly", "monthly"
  final String status; // "active", "paused", "stopped"
  final DateTime? nextRunAt;
  final DateTime? lastRunAt;
  final double totalSaved;
  final int runCount;

  const LockFundAutoSaveConfig({
    required this.id,
    required this.lockFundId,
    required this.sourceAccountId,
    required this.amount,
    required this.frequency,
    required this.status,
    this.nextRunAt,
    this.lastRunAt,
    this.totalSaved = 0,
    this.runCount = 0,
  });

  bool get isActive => status == 'active';
  bool get isPaused => status == 'paused';

  String get frequencyDisplayName {
    switch (frequency) {
      case 'daily':
        return 'Daily';
      case 'weekly':
        return 'Weekly';
      case 'monthly':
        return 'Monthly';
      default:
        return frequency;
    }
  }
}

class LockTransaction {
  final String id;
  final String lockFundId;
  final String userId;
  final String transactionType;
  final double amount;
  final String currency;
  final String? paymentMethod;
  final String status;
  final DateTime transactionDate;
  final String description;

  const LockTransaction({
    required this.id,
    required this.lockFundId,
    required this.userId,
    required this.transactionType,
    required this.amount,
    required this.currency,
    this.paymentMethod,
    required this.status,
    required this.transactionDate,
    required this.description,
  });
}

class InterestCalculation {
  final double interestRate;
  final double estimatedInterest;
  final double totalReturn;
  final double apy;
  final double principalAmount;
  final double interestAmount;
  final double totalAmount;
  final bool isUpfrontInterest;
  final int lockDurationDays;

  const InterestCalculation({
    required this.interestRate,
    required this.estimatedInterest,
    required this.totalReturn,
    required this.apy,
    required this.principalAmount,
    required this.interestAmount,
    required this.totalAmount,
    this.isUpfrontInterest = false,
    this.lockDurationDays = 0,
  });

  bool get qualifiesForUpfrontInterest => lockDurationDays >= 180;

  /// Upfront-interest amount surfaced on the receipt + detail
  /// screens. When isUpfrontInterest is true, this equals
  /// interestAmount; otherwise 0. Saves callers from
  /// re-implementing the conditional everywhere.
  double get upfrontInterestAmount =>
      isUpfrontInterest ? interestAmount : 0;
}
