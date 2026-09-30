import 'fcy_account_service.dart';

/// Which currencies can have a foreign virtual account, according to the SERVER.
///
/// WHY THIS EXISTS
/// ---------------
/// account_preview_card decided this itself, with
/// `_fcyCapableCurrencies = {'USD', 'GBP', 'EUR', 'CAD'}`. Fincra issues ten —
/// USD, GBP, EUR, CAD, XAF, GHS, KES, TZS, RWF, UGX — so a user sitting on a
/// GHS or KES wallet was never offered activation at all, for a currency the
/// active provider supports today.
///
/// A hardcoded client list also cannot follow a provider switch. The set
/// belongs to the PROVIDER, and only the server knows which providers are
/// enabled, what each declares, and which per-currency overrides an operator
/// has set — so the server resolves it through the same path a real mint would
/// take, and a currency offered here is one a request would actually route.
///
/// CACHED, because this is read while painting account cards and the answer
/// changes only when an operator changes a setting. One read per app run is
/// enough; [invalidate] exists for when that assumption stops holding.
class FcyCapabilities {
  FcyCapabilities._();
  static final FcyCapabilities instance = FcyCapabilities._();

  /// The last set the server gave us. Null means "never successfully read".
  List<String>? _cached;
  Future<void>? _inFlight;

  /// What to show before the server has answered, and if it never does.
  ///
  /// The four the app has always offered. Deliberately NOT empty: a failed
  /// capability read should not silently remove a feature users already have,
  /// and these four are the ones every configuration so far supports. It is a
  /// floor, not the answer — a successful read replaces it entirely, including
  /// with a SMALLER set if an operator has disabled a rail.
  static const List<String> fallback = ['USD', 'GBP', 'EUR', 'CAD'];

  List<String> get currencies => _cached ?? fallback;

  bool supports(String currency) {
    final c = currency.trim().toUpperCase();
    if (c.isEmpty) return false;
    return currencies.contains(c);
  }

  /// Refresh from the server. Never throws — a capability read is not worth
  /// failing a screen over, and [currencies] keeps its last good answer.
  ///
  /// Concurrent callers share one request: several account cards paint at once
  /// and would otherwise each fire their own.
  Future<void> refresh({FCYAccountService? service, String probeCurrency = 'USD'}) {
    final existing = _inFlight;
    if (existing != null) return existing;
    final f = _refresh(service, probeCurrency).whenComplete(() => _inFlight = null);
    _inFlight = f;
    return f;
  }

  Future<void> _refresh(FCYAccountService? service, String probeCurrency) async {
    try {
      final svc = service ?? FCYAccountService();
      // The capability set rides on the status read — no extra endpoint, and
      // the currency asked about does not change the answer.
      final s = await svc.status(probeCurrency);
      if (s.supportedCurrencies.isNotEmpty) {
        _cached = s.supportedCurrencies;
      }
    } catch (_) {
      // Keep the last good answer, or the fallback. Silence is correct here:
      // nothing the user did failed.
    }
  }

  /// For tests and for an operator-visible settings change mid-session.
  void invalidate() => _cached = null;

  /// Test seam.
  void seedForTest(List<String>? currencies) => _cached = currencies;
}
