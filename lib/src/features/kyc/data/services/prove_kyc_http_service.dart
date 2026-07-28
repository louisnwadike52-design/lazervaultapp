import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'package:lazervault/core/services/endpoint_registry.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';

/// Result of starting a Mono Prove session.
class ProveInitiateResult {
  ProveInitiateResult({
    required this.monoUrl,
    required this.reference,
    this.sessionId = '',
  });
  final String monoUrl;
  final String reference;
  final String sessionId;
}

/// Result of completing / fetching a Mono Prove session, with tier progress.
class ProveCompleteResult {
  ProveCompleteResult({
    required this.verified,
    required this.status,
    this.tier = 0,
    this.tierName = '',
    this.message = '',
    this.completedSteps = const [],
    this.nextTier = 0,
    this.nextRequirements = const [],
  });
  final bool verified;
  final String status;
  final int tier;
  final String tierName;
  final String message;
  final List<String> completedSteps;
  final int nextTier;
  final List<String> nextRequirements;

  /// True once the user reached the platform's "fully verified" tier.
  bool get isMaxTier => tier >= 3;
}

/// The user's current KYC standing (tier + remaining requirements).
class ProveKycStatus {
  ProveKycStatus({
    required this.verified,
    required this.tier,
    required this.tierName,
    required this.completedSteps,
    required this.nextTier,
    required this.nextRequirements,
    required this.message,
  });
  final bool verified;
  final int tier;
  final String tierName;
  final List<String> completedSteps;
  final int nextTier;
  final List<String> nextRequirements;
  final String message;

  bool get isMaxTier => tier >= 3;
}

/// Thrown for any Prove KYC failure, with a clean user-facing message.
class ProveKycException implements Exception {
  ProveKycException(this.message, {this.code});
  final String message;
  final String? code;
  @override
  String toString() => message;
}

/// HTTP client for the Mono Prove 3-tier KYC flow.
///
/// We deliberately talk to banking-service's HTTP gateway directly (the same
/// transport login + legal links use) rather than the app's gRPC clients, which
/// have been silently dropping authenticated KYC calls. The backend endpoints
/// are real (POST /api/v1/kyc/prove/{initiate,complete}) and return live
/// prove.mono.co sessions.
class ProveKycHttpService {
  ProveKycHttpService(this._storage);

  final SecureStorageService _storage;

  /// Base for the KYC (Mono Prove) endpoints. In a real build this resolves to
  /// the cloudflared host (e.g. https://dev.lazervault.app/api/v1/kyc/prove) via
  /// HTTP_API_HOST in .env — the previous `http://10.0.2.2:8073` only worked on
  /// the Android emulator and made the on-device KYC status spin forever.
  static String get _base {
    final host = dotenv.env['HTTP_API_HOST'];
    if (host != null && host.isNotEmpty) {
      return '${host.replaceAll(RegExp(r'/+$'), '')}/api/v1/kyc/prove';
    }
    // Test-only override (compile-time): a non-empty TEST_BACKEND_HOST pins the
    // legacy host:port shape so harnesses can target a local gateway.
    const testHost = String.fromEnvironment('TEST_BACKEND_HOST');
    if (testHost.isNotEmpty) {
      return 'http://$testHost:8073/api/v1/kyc/prove';
    }
    // Otherwise route through the central registry's BANKING gateway base
    // (already ends in /api/v1) — no hardcoded host/port. /api/v1/kyc/prove/*
    // is served by banking-service (see banking.pb.gw.go InitiateProveKYC /
    // CompleteProveKYC / GetProveKYCStatus), NOT the core gateway, so use
    // httpBanking so a local/dev build (distinct host:port) and any admin
    // repoint of the banking URL resolve to the right backend.
    final banking = endpointRegistry.httpBanking.replaceAll(RegExp(r'/+$'), '');
    return '$banking/kyc/prove';
  }

  Future<Map<String, String>> _headers() async {
    final token = await _storage.getAccessToken();
    if (token == null || token.isEmpty) {
      throw ProveKycException('Your session expired. Please log in again.',
          code: 'NO_TOKEN');
    }
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  /// Start a Prove session and return the hosted URL + reference.
  Future<ProveInitiateResult> initiate({
    required String idNumber,
    required String firstName,
    required String lastName,
    required String phone,
    String idType = 'bvn',
    String email = '',
    // Advisory only. The Mono Prove billing level is pinned server-side by an
    // admin setting (kyc.mono.prove_level, default tier_1); this does not select it.
    String tier = 'tier_1',
  }) async {
    final body = jsonEncode({
      'id_type': idType,
      'id_number': idNumber,
      'first_name': firstName,
      'last_name': lastName,
      'phone': phone,
      'email': email,
      'tier': tier,
      'redirect_url': 'lazervault://kyc/callback',
    });

    final res = await http
        .post(Uri.parse('$_base/initiate'),
            headers: await _headers(), body: body)
        .timeout(const Duration(seconds: 40));

    final data = _decode(res);
    if (res.statusCode != 200 || data['success'] != true) {
      throw ProveKycException(
        _friendly(_pick(data, 'error_message', 'errorMessage'), res.statusCode),
        code: _pick(data, 'error_code', 'errorCode'),
      );
    }
    final monoUrl = _pick(data, 'mono_url', 'monoUrl') ?? '';
    final reference = (data['reference'] ?? '').toString();
    if (monoUrl.isEmpty || reference.isEmpty) {
      throw ProveKycException('Could not start verification. Please try again.');
    }
    return ProveInitiateResult(
      monoUrl: monoUrl,
      reference: reference,
      sessionId: _pick(data, 'session_id', 'sessionId') ?? '',
    );
  }

  /// Fetch a Prove session result by reference; verified once the user finishes.
  Future<ProveCompleteResult> complete({required String reference}) async {
    final res = await http
        .post(Uri.parse('$_base/complete'),
            headers: await _headers(),
            body: jsonEncode({'reference': reference}))
        .timeout(const Duration(seconds: 40));

    final data = _decode(res);
    if (res.statusCode != 200 || data['success'] != true) {
      throw ProveKycException(
        _friendly(_pick(data, 'error_message', 'errorMessage'), res.statusCode),
        code: _pick(data, 'error_code', 'errorCode'),
      );
    }
    return ProveCompleteResult(
      verified: data['verified'] == true,
      status: (data['status'] ?? '').toString(),
      tier: _asInt(data['tier']),
      tierName: (data['tierName'] ?? data['tier_name'] ?? '').toString(),
      message: (data['message'] ?? '').toString(),
      completedSteps: _asStringList(data['completedSteps'] ?? data['completed_steps']),
      nextTier: _asInt(data['nextTier'] ?? data['next_tier']),
      nextRequirements:
          _asStringList(data['nextRequirements'] ?? data['next_requirements']),
    );
  }

  /// Read the user's current KYC tier + what's left for the next tier. Used to
  /// show "where you are / what's next" and to resume from the remaining step.
  Future<ProveKycStatus> status() async {
    final res = await http
        .get(Uri.parse('$_base/status'), headers: await _headers())
        .timeout(const Duration(seconds: 30));
    final data = _decode(res);
    if (res.statusCode != 200 || data['success'] != true) {
      throw ProveKycException(
        _friendly(_pick(data, 'error_message', 'errorMessage'), res.statusCode),
        code: _pick(data, 'error_code', 'errorCode'),
      );
    }
    return ProveKycStatus(
      verified: data['verified'] == true,
      tier: _asInt(data['tier']),
      tierName: (data['tierName'] ?? data['tier_name'] ?? '').toString(),
      completedSteps: _asStringList(data['completedSteps'] ?? data['completed_steps']),
      nextTier: _asInt(data['nextTier'] ?? data['next_tier']),
      nextRequirements:
          _asStringList(data['nextRequirements'] ?? data['next_requirements']),
      message: (data['message'] ?? '').toString(),
    );
  }

  int _asInt(Object? v) {
    if (v is int) return v;
    if (v is num) return v.toInt();
    return int.tryParse(v?.toString() ?? '') ?? 0;
  }

  List<String> _asStringList(Object? v) {
    if (v is List) return v.map((e) => e.toString()).toList();
    return const [];
  }

  /// grpc-gateway serializes proto JSON as lowerCamelCase, but older handlers /
  /// hand-written endpoints use snake_case. Read whichever is present.
  String? _pick(Map<String, dynamic> data, String snake, String camel) {
    final v = data[snake] ?? data[camel];
    final s = v?.toString();
    return (s == null || s.isEmpty) ? null : s;
  }

  Map<String, dynamic> _decode(http.Response res) {
    try {
      final v = jsonDecode(res.body);
      return v is Map<String, dynamic> ? v : <String, dynamic>{};
    } catch (_) {
      return <String, dynamic>{};
    }
  }

  String _friendly(String? backendMessage, int status) {
    if (backendMessage != null && backendMessage.trim().isNotEmpty) {
      return backendMessage;
    }
    if (status == 401) return 'Your session expired. Please log in again.';
    if (status >= 500) return 'We couldn\'t reach the verification service. Please try again.';
    return 'We couldn\'t verify your BVN. Please check it and try again.';
  }
}
