part of 'notification_route_resolver.dart';

/// The account itself: security events, KYC, budgets, planning reminders and
/// operator alerts.
///
/// Security is the domain where landing on the right page matters most and
/// where the payload is richest — `security` notifications carry an
/// `event_type` that says exactly what happened, so most of these are exact.
NotificationTarget? _resolveAccount(String type, Map<String, String> data) {
  // ---- Security ------------------------------------------------------------
  // The `event_type` is what makes these actionable. A PIN reset must land on
  // PIN setup so the user can re-enrol immediately; a login alert belongs in
  // account settings where sessions and devices live.
  if (_is(type, 'security')) {
    final event = (data['event_type'] ?? '').toLowerCase();

    // A super-admin cleared this user's transaction PIN. Straight to setup —
    // the session's "has PIN" cache is invalidated by the navigator before it
    // routes, so the setup screen does not bounce off a stale true.
    if (event.contains('transaction_pin')) {
      if (event.contains('reset') || event.contains('cleared')) {
        return _record(AppRoutes.transactionPinSetup);
      }
      return _landing(AppRoutes.pinManagement);
    }
    if (event.contains('passcode')) {
      return _landing(AppRoutes.changePasscode);
    }
    if (event.contains('biometric') || event.contains('face')) {
      return _landing(AppRoutes.setFingerPrint);
    }
    // Login alerts, new-device sign-ins, session revocations.
    return _landing(AppRoutes.myAccount);
  }

  // ---- KYC -----------------------------------------------------------------
  // "Your verification succeeded / needs another document" — the progressive
  // KYC screen is the one page that explains where the user stands and what is
  // still missing.
  //
  // Not kycStatus or kycDocuments: those are AppRoutes constants with no
  // GetPage behind them and no other caller in the app, so naming them would
  // compile and then dead-end at runtime.
  if (_is(type, 'kyc') || _is(type, 'verification') || _is(type, 'bvn')) {
    return _landing(AppRoutes.kycProgressive);
  }

  // ---- Account -------------------------------------------------------------
  // Generic account events: tier upgrades, limit changes, account status.
  if (_is(type, 'account')) {
    return _landing(AppRoutes.myAccount);
  }

  // ---- Budgets -------------------------------------------------------------
  // budget_alert | budget_exceeded | budget_threshold | budget_warning
  //
  // BudgetDetailScreen is driven by the shared BudgetCubit rather than by
  // arguments, so it cannot be addressed by id from here — the list is the
  // correct landing and the breached budget is the one flagged on it.
  if (type.startsWith('budget')) {
    return _landing(AppRoutes.budgetList);
  }

  // ---- Planning ------------------------------------------------------------
  if (_is(type, 'planning_reminder') ||
      _is(type, 'planning') ||
      _is(type, 'reminder')) {
    return _landing(AppRoutes.planReminders);
  }

  // ---- Operator alerts -----------------------------------------------------
  // Admin-only. Kept here rather than in main.dart's tap handler so it obeys
  // the same auth gate and cold-start stashing as everything else.
  if (_is(type, 'ops_alert') || _is(type, 'prometheus_alert')) {
    return _landing(AppRoutes.adminAlerts);
  }

  // ---- Statements / documents ---------------------------------------------
  if (_is(type, 'statement')) {
    return _landing(AppRoutes.statementExport);
  }

  // ---- Referral-adjacent and purely informational --------------------------
  // `plain` and `test` carry no destination by definition — the message IS the
  // content. They land on the feed so the user can read it in full, which is
  // the only sensible "page" for them.
  if (type == 'plain' || type == 'test' || type == 'general') {
    return _landing(AppRoutes.notificationsFeed);
  }

  return null;
}
