import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../network/network_timeouts.dart';
import 'access_token_shape.dart';
import 'endpoint_registry.dart';
import 'injection_container.dart';
import 'secure_storage_service.dart';

/// Whether the holder appears in user search across the platform.
///
/// THE SERVER IS AUTHORITATIVE HERE, unlike PanicBalanceService, which is
/// local-first because it drives a display decoy on this device. This flag
/// decides what OTHER people can see, so the only copy that matters is the one
/// in `users.hidden_from_search`. The cached value exists solely so the
/// Settings switch can paint its current position on the first frame instead
/// of flicking after a round trip.
///
/// Reached at /api/v1/privacy/search, which is auth-service's own Gin mux —
/// NOT core-gateway, whose /api/v1 catch-all is wrapGrpcGateway and only knows
/// grpc-gateway routes. The Cloudflare tunnel carries that prefix straight to
/// auth-service (infrastructure/cloudflared/config-prod.yml), exactly as it
/// does for /api/v1/panic.
class SearchPrivacyService {
  SearchPrivacyService._();
  static final SearchPrivacyService instance = SearchPrivacyService._();

  static const _cacheKey = 'search_privacy_hidden';

  /// Last known value, for painting the switch before the network answers.
  ///
  /// Defaults FALSE — discoverable — which is both the product default and the
  /// safe direction: showing "you are visible" when the server says hidden is
  /// a stale label the next refresh corrects, while showing "you are hidden"
  /// when you are not would be a privacy claim the app cannot keep.
  static bool cachedHidden(SharedPreferences prefs) =>
      prefs.getBool(_cacheKey) ?? false;

  Uri? get _uri {
    final base = EndpointRegistry.instance.httpCore.trim();
    if (base.isEmpty) return null;
    return Uri.parse('${base.replaceAll(RegExp(r'/+$'), '')}/privacy/search');
  }

  Future<String?> get _token =>
      serviceLocator<SecureStorageService>().getAccessToken();

  /// Reads the live value. Returns null when it cannot be determined, which
  /// callers must treat as "leave the switch where it is" rather than as false
  /// — reporting discoverable on a failed read would misstate the holder's
  /// own privacy setting back to them.
  Future<bool?> fetch() async {
    final uri = _uri;
    final token = await _token;
    if (uri == null || token == null || token.isEmpty) return null;
    try {
      final resp = await http
          .get(uri, headers: authHeader(token))
          .timeout(NetworkTimeouts.interactive);
      if (resp.statusCode != 200) return null;
      final body = jsonDecode(resp.body) as Map<String, dynamic>;
      final hidden = body['hidden_from_search'] == true;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_cacheKey, hidden);
      return hidden;
    } catch (_) {
      return null;
    }
  }

  /// Writes the value. Returns true only when the SERVER confirmed it.
  ///
  /// Deliberately not best-effort, unlike the panic push. If this silently
  /// failed, the switch would sit in the position the holder chose while they
  /// remained visible to everyone — the one outcome this feature exists to
  /// prevent. The caller reverts the switch and says so on false.
  Future<bool> setHidden(bool hidden) async {
    final uri = _uri;
    final token = await _token;
    if (uri == null || token == null || token.isEmpty) return false;
    try {
      final resp = await http
          .put(
            uri,
            headers: {
              ...authHeader(token),
              'Content-Type': 'application/json',
            },
            body: jsonEncode({'hidden_from_search': hidden}),
          )
          .timeout(NetworkTimeouts.interactive);
      if (resp.statusCode != 200) return false;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_cacheKey, hidden);
      return true;
    } catch (_) {
      return false;
    }
  }

  /// Clears the cached position on sign-out, so the next holder on a shared
  /// device never sees the previous one's privacy setting.
  static Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cacheKey);
  }
}
