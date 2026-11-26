import '../../../../../core/services/injection_container.dart';
import '../../../../../core/services/locale_manager.dart';
import '../../domain/entities/lock_fund_entity.dart';
import '../../domain/repositories/lock_funds_repository.dart';

/// Plan bounds for money going INTO a plan that is already open — top-up and
/// auto-save.
///
/// WHY THIS IS NOT the create wizard's validator. `CreateLockCubit.validateStep2`
/// enforces MinAmount, because that is "the least you may OPEN this plan with".
/// A plan that is already open has met it, and re-imposing it per deposit would
/// refuse a ₦500 addition to a ₦1,000,000 plan. With plan minimums at ₦200,000
/// it would refuse every realistic auto-save instalment outright.
///
/// Mirrors the server rule in `PlanTopUpCeilingViolation`
/// (accounts-service/internal/service/lockfunds_amount_bounds.go). The server
/// remains authoritative; this exists so a customer is told before they spend a
/// PIN entry on a request that will be refused.

/// Resolves the plan config backing [lock], or null when it cannot be
/// determined.
///
/// Null is a SKIP, never a refusal: a failed config read must not block a
/// legitimate top-up. That is the same stance `CreateLockCubit.getMinAmount`
/// takes by returning `double?` rather than 0 — inventing a bound would quote
/// the customer a limit nobody set.
Future<PiggyVaultConfig?> resolvePlanConfigFor(LockFund lock) async {
  try {
    final repo = serviceLocator<LockFundsRepository>();
    final locale = serviceLocator<LocaleManager>().currentLocale;
    final configs =
        await repo.getPiggyVaultConfigs(currency: '', locale: locale);
    if (configs.isEmpty) return null;

    // configId is the STABLE plan identity; lockType is a denormalised display
    // label (see LockFund.configId). Match on the id first and fall back to the
    // label only for legacy rows written before config_id existed.
    final id = lock.configId.trim();
    if (id.isNotEmpty) {
      for (final c in configs) {
        if (c.id == id) return c;
      }
    }
    final key = lock.lockType.backendKey;
    for (final c in configs) {
      if (c.lockType == key) return c;
    }
    return null;
  } catch (_) {
    return null;
  }
}

/// Reports why adding [instalment] to a plan holding [currentTotal] is not
/// allowed, or null when it is.
///
/// Only the CEILING applies, and it applies to the resulting total rather than
/// the instalment, because the maximum is a property of the plan — not of a
/// single deposit. Without that, a cap can be walked past in steps.
String? topUpCeilingViolation(
  PiggyVaultConfig? cfg,
  double currentTotal,
  double instalment,
) {
  // 0 means "no ceiling", not "a ceiling of zero". Every live plan carries
  // max_amount 0 today; reading that as a cap would refuse every top-up.
  if (cfg == null || cfg.maxAmount <= 0) return null;
  final resulting = currentTotal + instalment;
  // Compared in minor units for the same reason the server does it: a deposit
  // landing exactly on the ceiling must not be refused by float imprecision.
  if ((resulting * 100).round() > (cfg.maxAmount * 100).round()) {
    return 'This would take the plan to ${resulting.toStringAsFixed(2)}, '
        'above the ${cfg.displayName} maximum of '
        '${cfg.maxAmount.toStringAsFixed(2)}.';
  }
  return null;
}

/// Quick-amount pills for a top-up.
///
/// Deliberately NOT `PiggyVaultConfig.parsedQuickAmountOptions`, which filters
/// against MinAmount so the wizard cannot offer a pill its own validator would
/// reject. For a top-up that filter is wrong twice over: the minimum does not
/// apply, and at a ₦200,000 minimum it would discard every pill and leave the
/// row empty.
List<double> topUpQuickAmounts(PiggyVaultConfig? cfg, List<double> fallback) {
  if (cfg == null) return fallback;
  final max = cfg.maxAmount;
  final pills = cfg.quickAmountOptionsForTopUp
      .where((a) => a > 0 && (max <= 0 || a <= max))
      .toList()
    ..sort();
  return pills.isEmpty ? fallback : pills;
}
