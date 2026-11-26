import 'package:shared_preferences/shared_preferences.dart';

/// Whether the signed-in user is an enrolled VENDOR, cached so the services
/// grid can ask synchronously while it builds.
///
/// WHY THIS EXISTS AT ALL. Every other per-user tile decision in this app is
/// one of three things — a global admin switch, an email whitelist, or the
/// active account type. None of them is a ROLE, and "is this user a vendor"
/// is a role that only the server knows. So the answer is fetched once per
/// session and parked in SharedPreferences, exactly the way FeatureFlags
/// parks its remote snapshot, because nothing on a gesture or build path may
/// await.
///
/// DEFAULTS TO FALSE, ALWAYS. An unresolved answer must hide the tile. The
/// services builder states the same rule for account type: hiding a section
/// for a frame and then showing it is correct; showing it on the wrong
/// account and then taking it away is not. Here the stakes are higher — the
/// tile opens a scanner that commits platform money.
///
/// CLEARED ON LOGOUT. Without that, a vendor logging out of a shared device
/// would leave the tile visible to whoever signs in next, and the backend
/// would then refuse every scan — which looks like a broken feature rather
/// than a flag that was never theirs.
class VendorAccess {
  VendorAccess._();

  static const String _activeKey = 'vendor_access_is_active_vendor';
  static const String _nameKey = 'vendor_access_business_name';

  static SharedPreferences? _prefs;

  /// Loads the cache. Safe to call more than once.
  static Future<void> init() async {
    try {
      _prefs ??= await SharedPreferences.getInstance();
    } catch (_) {
      // A platform channel failure must not take the app down. Everything
      // below then answers false, which is the safe direction.
    }
  }

  /// Whether to show the Vendor Campaigns tile. Synchronous by design.
  static bool get isActiveVendor {
    try {
      return _prefs?.getBool(_activeKey) ?? false;
    } catch (_) {
      return false;
    }
  }

  /// The business name, for the tile's destination header.
  static String get businessName {
    try {
      return _prefs?.getString(_nameKey) ?? '';
    } catch (_) {
      return '';
    }
  }

  /// Records what the server said.
  ///
  /// Call this ONLY with a real answer from GetVendorStatus. A failed call
  /// must not reach here: leaving the previous value in place is better than
  /// writing false and hiding the tile from a vendor mid-service because one
  /// request timed out.
  static Future<void> remember({
    required bool isActive,
    String businessName = '',
  }) async {
    await init();
    try {
      await _prefs?.setBool(_activeKey, isActive);
      await _prefs?.setString(_nameKey, businessName);
    } catch (_) {/* cache-only; the next session re-asks */}
  }

  /// Forgets everything. Called on logout.
  static Future<void> clear() async {
    await init();
    try {
      await _prefs?.remove(_activeKey);
      await _prefs?.remove(_nameKey);
    } catch (_) {/* best effort */}
  }

  /// Test seam — mirrors FeatureFlags.debugResetForTest.
  static Future<void> debugResetForTest() async {
    _prefs = null;
    await init();
    await clear();
  }
}
