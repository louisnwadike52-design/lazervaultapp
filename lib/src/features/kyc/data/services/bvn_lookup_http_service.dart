import 'package:lazervault/core/utils/json_field_lookup.dart';
import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:lazervault/core/services/endpoint_registry.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:lazervault/core/services/access_token_shape.dart';
import 'package:lazervault/core/utils/logger.dart';

/// One OTP delivery route Mono offers for a BVN.
class BvnLookupMethod {
  const BvnLookupMethod({required this.method, required this.hint});

  /// "email" | "phone" | "alternate_phone" — sent back verbatim.
  final String method;

  /// Mono's OWN masked description. Shown verbatim: it is already masked, and
  /// we never see the real address, so any mask we built would be invented.
  final String hint;

  /// A readable label for the chooser when the hint is missing.
  String get label {
    switch (method) {
      case 'email':
        return 'Email';
      case 'phone':
        return 'Text message';
      case 'alternate_phone':
        return 'Alternate phone';
      default:
        return method;
    }
  }
}

/// The outcome of one step, with the server's machine-readable code intact.
class BvnLookupResult {
  const BvnLookupResult({
    required this.ok,
    this.code = '',
    this.message = '',
    this.methods = const [],
  });

  final bool ok;
  final String code;
  final String message;
  final List<BvnLookupMethod> methods;

  /// The session timed out server-side (it is held in memory for ~15 min, and
  /// a service restart drops it). The only move is to start from the BVN.
  bool get sessionExpired => code == 'SESSION_EXPIRED';

  /// Our outage, not the customer's problem — never block onboarding on it.
  bool get infrastructure =>
      code == 'PROVIDER_UNAVAILABLE' || code == 'BANKING_SERVICE_ERROR';

  /// This BVN belongs to another account: a decision, not a retry.
  bool get alreadyRegistered => code == 'BVN_ALREADY_REGISTERED';
}

/// Mono's BVN lookup, which is a THREE-STEP CONSENT FLOW.
///
/// Unlike NIN (one silent call), BVN data is NIBSS-regulated and needs the
/// holder's consent, so **Mono** — not Lazervault — sends them a one-time
/// code and we exchange it for the record. We never see the delivery address
/// or the code.
///
/// The Mono session id is NOT carried here. banking-service holds it
/// server-side keyed by the caller's JWT, because session + OTP is enough to
/// read the holder's identity; the app can only advance its own session.
class BvnLookupHttpService {
  BvnLookupHttpService(this._storage);

  final SecureStorageService _storage;

  static String get _base {
    final host = dotenv.env['HTTP_API_HOST'];
    if (host != null && host.isNotEmpty) {
      return '${host.replaceAll(RegExp(r'/+$'), '')}/api/v1/kyc/bvn-lookup';
    }
    const testHost = String.fromEnvironment('TEST_BACKEND_HOST');
    if (testHost.isNotEmpty) {
      return 'http://$testHost:8073/api/v1/kyc/bvn-lookup';
    }
    // Same resolution as the Prove service: these routes are served by
    // banking-service, not the core gateway.
    final banking = endpointRegistry.httpBanking.replaceAll(RegExp(r'/+$'), '');
    return '$banking/kyc/bvn-lookup';
  }

  Future<Map<String, String>> _headers() async {
    final token = await _storage.getAccessToken();
    if (token == null || token.isEmpty) {
      return const {};
    }
    return {'Content-Type': 'application/json', ...authHeader(token)};
  }

  /// NEVER THROWS. Every caller is on the path to onboarding a customer, and
  /// an exception escaping here would replace a recoverable refusal with a
  /// crashed screen. Transport problems come back as `infrastructure`, which
  /// the UI treats as "let them through".
  Future<BvnLookupResult> _post(
    String path,
    Map<String, dynamic> body, {
    required String op,
  }) async {
    try {
      final headers = await _headers();
      if (headers.isEmpty) {
        return const BvnLookupResult(
          ok: false,
          code: 'NO_TOKEN',
          message: 'Your session expired. Please log in again.',
        );
      }
      final resp = await http
          .post(Uri.parse('$_base/$path'),
              headers: headers, body: jsonEncode(body))
          .timeout(const Duration(seconds: 30));

      final decoded = jsonDecode(resp.body);
      if (decoded is! Map<String, dynamic>) {
        return const BvnLookupResult(
          ok: false,
          code: 'PROVIDER_UNAVAILABLE',
          message: 'Identity verification is temporarily unavailable.',
        );
      }
      if (resp.statusCode < 200 || resp.statusCode >= 300) {
        return BvnLookupResult(
          ok: false,
          code: _orElse(jsonString(decoded, 'errorcode'),
              'PROVIDER_UNAVAILABLE'),
          message: _orElse(jsonString(decoded, 'errormessage'),
              'Identity verification is temporarily unavailable.'),
        );
      }
      final ok = decoded['success'] == true;
      final methods = <BvnLookupMethod>[];
      final raw = decoded['methods'];
      if (raw is List) {
        for (final m in raw) {
          if (m is Map && m['method'] is String) {
            methods.add(BvnLookupMethod(
              method: m['method'] as String,
              hint: (m['hint'] as String?) ?? '',
            ));
          }
        }
      }
      return BvnLookupResult(
        ok: ok,
        code: jsonString(decoded, 'errorcode'),
        message: jsonString(decoded, 'errormessage'),
        methods: methods,
      );
    } catch (e) {
      AppLogger.event('kyc_bvn_lookup', '$op.transport_error',
          level: 'warn', screen: 'bvn_signup');
      return const BvnLookupResult(
        ok: false,
        code: 'PROVIDER_UNAVAILABLE',
        message:
            'We could not reach our verification partner. Please try again shortly.',
      );
    }
  }

  /// Step 1 — open the consent session and get the delivery routes.
  Future<BvnLookupResult> initiate(String bvn) =>
      _post('initiate', {'bvn': bvn}, op: 'initiate');

  /// Step 2 — ask Mono to deliver the code by [method].
  ///
  /// A failure is NOT terminal: the session stays open server-side so the
  /// customer can choose a different route.
  Future<BvnLookupResult> sendOtp(String method) =>
      _post('send-otp', {'method': method}, op: 'send_otp');

  /// Step 3 — exchange the code for the identity record.
  Future<BvnLookupResult> complete({
    required String otp,
    required String firstName,
    required String lastName,
    required String dateOfBirth,
  }) =>
      _post('complete', {
        'otp': otp,
        'first_name': firstName,
        'last_name': lastName,
        'date_of_birth': dateOfBirth,
      }, op: 'complete');
}

/// _orElse keeps a fallback for the genuinely-absent case without letting an
/// empty string through as if it were a value.
String _orElse(String v, String fallback) => v.isEmpty ? fallback : v;
