// Corridor-matrix pre-check helper (#108 / #114 boundary).
//
// Queries the new IsCorridorSupported RPC (#114) over HTTP via the
// financial-gateway passthrough so a test can SKIP a corridor cleanly
// instead of "try, fail with a 400, classify the message". The matrix
// answer is the authoritative source — exchange-service reads it from
// the exchange_corridor_support table with a 60s cache, so a check
// here is consistent with the production code path.
//
// HTTP shape (per microservices/exchange-service/.../exchange.proto §455):
//   GET /v1/exchange/corridor-supported
//       ?source_currency=NGN&destination_currency=USD&flow_type=conversion
//   ->  { "supported": true,  "reason": "" }
//       { "supported": false, "reason": "corridor not configured" }
//
// The HTTP host/port mirrors the existing currency_exchange_e2e_test.dart
// constants so the same `TEST_BACKEND_HOST` / `TEST_EXCHANGE_HTTP_PORT`
// dart-defines apply.

import 'dart:async';
import 'dart:convert';
import 'dart:io';

/// Result of a corridor pre-check.
class CorridorCheck {
  final bool supported;
  final String reason;
  final bool checkFailed; // true if the RPC itself errored

  const CorridorCheck({
    required this.supported,
    required this.reason,
    this.checkFailed = false,
  });

  /// Conservative default when the check itself errors: the caller should
  /// try the corridor anyway (matches the production fallback "ok, try
  /// it" when the pre-flight read flakes).
  factory CorridorCheck.errored(String why) =>
      CorridorCheck(supported: true, reason: 'precheck-errored: $why', checkFailed: true);
}

/// Query the corridor matrix for a single (source, dest, flow) tuple.
///
/// [grpcHost] usually comes from `String.fromEnvironment('TEST_BACKEND_HOST')`.
/// [exchangeGatewayHttp] is the financial-gateway HTTP port (default 8016).
/// [bearer] is the session access token (used for the auth header — the
/// route requires JWT per the proto config).
Future<CorridorCheck> queryCorridor({
  required String grpcHost,
  required int exchangeGatewayHttp,
  required String bearer,
  required String source,
  required String dest,
  required String flowType, // "conversion" or "international"
}) async {
  final client = HttpClient();
  try {
    final uri = Uri.parse(
      'http://$grpcHost:$exchangeGatewayHttp/v1/exchange/corridor-supported'
      '?source_currency=${Uri.encodeQueryComponent(source)}'
      '&destination_currency=${Uri.encodeQueryComponent(dest)}'
      '&flow_type=${Uri.encodeQueryComponent(flowType)}',
    );
    final req = await client.getUrl(uri);
    req.headers.set('authorization', 'Bearer $bearer');
    final resp = await req.close().timeout(const Duration(seconds: 10));
    final text = await resp.transform(utf8.decoder).join();

    if (text.isEmpty) {
      return CorridorCheck.errored('empty body HTTP ${resp.statusCode}');
    }

    Map<String, dynamic>? decoded;
    try {
      final parsed = jsonDecode(text);
      if (parsed is Map<String, dynamic>) decoded = parsed;
    } catch (_) {
      // Not JSON — treat as errored so caller defaults to "try it".
      return CorridorCheck.errored('non-json body: ${text.substring(0, text.length.clamp(0, 80))}');
    }
    if (decoded == null) {
      return CorridorCheck.errored('non-object body');
    }
    // grpc-gateway envelope: top-level fields supported + reason.
    final supported = decoded['supported'];
    final reason = decoded['reason'];
    if (supported is bool) {
      return CorridorCheck(
        supported: supported,
        reason: reason is String ? reason : '',
      );
    }
    // grpc error envelope shape ({code:N, message:""}). Caller can still
    // decide; we surface as errored.
    if (decoded.containsKey('code') && decoded.containsKey('message')) {
      return CorridorCheck.errored('grpc-error: ${decoded['message']}');
    }
    return CorridorCheck.errored('no supported field in body');
  } catch (e) {
    return CorridorCheck.errored('exception: $e');
  } finally {
    client.close();
  }
}

/// Bulk pre-check helper for the cross-corridor matrix. Iterates ordered
/// (from, to) pairs and returns the set classified as NOT supported by
/// the matrix — these should be SKIPPED (not failed) by the caller.
Future<Set<String>> unsupportedPairs({
  required String grpcHost,
  required int exchangeGatewayHttp,
  required String bearer,
  required List<String> currencies,
  required String flowType,
}) async {
  final unsupported = <String>{};
  for (final from in currencies) {
    for (final to in currencies) {
      if (from == to) continue;
      final r = await queryCorridor(
        grpcHost: grpcHost,
        exchangeGatewayHttp: exchangeGatewayHttp,
        bearer: bearer,
        source: from,
        dest: to,
        flowType: flowType,
      );
      if (!r.checkFailed && !r.supported) {
        unsupported.add('$from->$to');
      }
    }
  }
  return unsupported;
}
