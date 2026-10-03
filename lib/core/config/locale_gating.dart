import '../config/feature_flags.dart';
import '../services/locale_manager.dart';
import '../services/injection_container.dart';

/// What the product offers outside Nigeria.
///
/// Why this exists
/// ---------------
/// Outside NGN the platform is not fully operational. The provider cannot
/// issue per-customer foreign-currency virtual accounts, so there is no
/// deposit rail in another region and most services have nothing to move money
/// with. Showing them anyway means a user taps into a flow that cannot
/// complete — the worst version of unavailable, because they only find out
/// after committing attention (and sometimes an amount) to it.
///
/// One place, not three
/// --------------------
/// The restriction touches three unrelated surfaces: the dashboard's quick
/// services, the bottom navigation, and the AI-insights scopes. Each could
/// have asked "is the currency NGN?" for itself, and they would have drifted —
/// a corridor opening would have been remembered in two of the three. Every
/// surface resolves through here instead, so the answer cannot disagree with
/// itself and an admin change lands everywhere at once.
///
/// Admin-tunable by design
/// -----------------------
/// "What works outside NGN" is a commercial fact that changes when a corridor
/// opens, not a property of the code. Every list is a system setting read in
/// the background, so it changes without an app release. See FeatureFlags.
class LocaleGating {
  LocaleGating._();

  static const String _homeCurrency = 'NGN';

  /// The active wallet currency, or the home currency when the locale service
  /// is not resolvable.
  ///
  /// Falling back to NGN means "unrestricted" — the right failure direction.
  /// A DI lookup failing (early startup, a widget test) must not black out the
  /// dashboard for a Nigerian user, who is the overwhelming majority.
  static String get currentCurrency {
    try {
      return serviceLocator<LocaleManager>().currentCurrency.toUpperCase();
    } catch (_) {
      return _homeCurrency;
    }
  }

  /// True when the current region is restricted to the reduced product.
  static bool get restricted =>
      FeatureFlags.localeGatingOn && currentCurrency != _homeCurrency;

  /// Whether a quick service should be offered in the current region.
  static bool serviceAllowed(String serviceName) {
    if (!restricted) return true;
    return FeatureFlags.localeNonNgnServiceNames
        .contains(serviceName.toLowerCase());
  }

  /// Whether a bottom-nav destination is usable in the current region.
  ///
  /// Disabled destinations stay VISIBLE and keep their index: the nav is
  /// addressed by index (deep links and receipt returns pass `initialTab`), so
  /// removing an entry would silently retarget those at the wrong screen.
  static bool navAllowed(String tabLabel) {
    // ADMIN GATE FIRST, and in THIS function rather than at the call sites.
    //
    // navAllowed is consulted at five places — the icon, the tap handler, the
    // deep-link path, letIndexChange and the highlight guard — and a gate
    // added to only some of them lets a disabled destination still be reached
    // by a deep link while its icon shows a lock.
    //
    // Destinations are DISABLED, never removed: the nav is addressed by INDEX
    // and deep links pass `initialTab`, so dropping an entry would silently
    // retarget those links at the wrong screen.
    if (!FeatureFlags.bottomNavEnabled(tabLabel,
        email: FeatureFlags.currentUserEmail())) {
      return false;
    }
    if (!restricted) return true;
    return !FeatureFlags.localeNonNgnDisabledNav
        .contains(tabLabel.toLowerCase());
  }

  /// Whether an AI-insights scope has anything to show in the current region.
  static bool aiScopeAllowed(String scope) {
    if (!restricted) return true;
    return FeatureFlags.localeNonNgnAiScopeNames.contains(scope.toLowerCase());
  }

  /// Whether a dashboard discovery section belongs in the current region.
  ///
  /// Crowdfunds and public groups are NGN-denominated communal pots — a user
  /// on a USD account cannot contribute to or withdraw from one — so showing
  /// the rail offers a scroll of things they can look at and not join.
  static bool sectionAllowed(String section) {
    if (!restricted) return true;
    return FeatureFlags.localeNonNgnDashboardSectionNames
        .contains(section.toLowerCase());
  }

  /// Whether an ACCOUNT TYPE can be held and operated in the current region.
  ///
  /// Personal only, by default. Every other type rests on a rail that stops
  /// at the Nigerian border — a business account settles to a Nigerian
  /// corporate payout, savings and investments are NGN-denominated products,
  /// family and group pots are contributed to in Naira — so offering one
  /// abroad creates an account that can be opened and then not used.
  ///
  /// Matching is on the type NAME, lower-cased and trimmed, because the same
  /// value arrives as 'Personal', 'personal' and ' personal ' from the three
  /// places that produce it (the proto, the picker, the cached summary).
  static bool accountTypeAllowed(String accountType) {
    if (!restricted) return true;
    return FeatureFlags.localeNonNgnAccountTypeNames
        .contains(accountType.trim().toLowerCase());
  }

  /// Whether a money-movement action (`deposit` / `withdraw`) is offered in
  /// the current region.
  ///
  /// NEITHER, by default, outside Naira. There is no per-customer virtual
  /// account abroad, so a foreign wallet has no number to be paid into — and
  /// with nothing in it there is nothing to pay out. Every method on the
  /// deposit sheet (card, Apple Pay, bank transfer) is integrated for NGN
  /// only, so the buttons lead to a screen whose every route is a dead end.
  ///
  /// Hidden rather than dimmed, unlike the bottom nav: nav entries are
  /// addressed by index and a user needs to see that Beam still exists, while
  /// a Deposit button is addressed by nothing and carries no such meaning.
  static bool moneyActionAllowed(String action) {
    if (!restricted) return true;
    return FeatureFlags.localeNonNgnMoneyActionNames
        .contains(action.trim().toLowerCase());
  }

  /// Whether an account-details tab is worth showing in the current region.
  static bool accountTabAllowed(String tab) {
    if (!restricted) return true;
    return FeatureFlags.localeNonNgnAccountTabNames
        .contains(tab.trim().toLowerCase());
  }

  /// Whether an account denominated in [accountCurrency] belongs on screen in
  /// the CURRENT locale.
  ///
  /// A wallet is denominated in one currency and can only be spent in it. A
  /// Naira Family & Friends pot shown to a user who has switched to GBP is a
  /// card they can select, send from, and have refused — and worse, its
  /// balance reads as if it were part of their GBP money. Reported from a
  /// device: NGN family accounts appearing in the GBP locale.
  ///
  /// Applies in EVERY locale, not just the restricted ones: a GBP wallet has
  /// no business on a Naira dashboard either. The restriction is symmetric
  /// because the reason is — you cannot spend one currency's wallet in
  /// another's locale.
  ///
  /// An account with no currency at all is SHOWN. Those are provisioning
  /// placeholders, and hiding a real account because a field has not been
  /// stamped yet is the worse failure of the two.
  static bool accountCurrencyAllowed(String? accountCurrency) {
    final c = (accountCurrency ?? '').trim().toUpperCase();
    if (c.isEmpty) return true;
    return c == currentCurrency;
  }

  /// One sentence explaining the restriction, for the UI to show.
  ///
  /// Names the currency rather than saying "your region", because a user who
  /// has switched region deliberately needs to recognise WHICH one they are
  /// in to know that switching back is the fix.
  static String reasonFor(String what) =>
      '$what is not available for $currentCurrency accounts yet. '
      'Switch to your Naira account to use it.';
}
