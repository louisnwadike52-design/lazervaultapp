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
    if (!restricted) return true;
    return !FeatureFlags.localeNonNgnDisabledNav
        .contains(tabLabel.toLowerCase());
  }

  /// Whether an AI-insights scope has anything to show in the current region.
  static bool aiScopeAllowed(String scope) {
    if (!restricted) return true;
    return FeatureFlags.localeNonNgnAiScopeNames.contains(scope.toLowerCase());
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
