import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:lazervault/core/services/account_manager.dart';
import 'package:lazervault/core/services/endpoint_registry.dart';
import 'package:lazervault/core/services/grpc_call_options_helper.dart';

import 'package:lazervault/src/features/plan_my_day/email/data/models/email_models.dart';
import 'package:lazervault/src/features/plan_my_day/email/domain/entities/email_entities.dart';

/// HTTP client for the Gmail / email integration inside Plan My Day.
///
/// Mirrors `PlanMyDayRepository`: same lifestyle-gateway base URL, the same
/// shared encrypted secure storage for the bearer token, and the same
/// `/api/v1` de-duplication of the base URL. Every path already carries the
/// `/api/v1/planning/email/...` prefix.
class EmailRepository {
  final String _baseUrl;
  // Kept for parity with PlanMyDayRepository's DI shape and available if a call
  // needs gRPC-style metadata / account scoping later.
  // ignore: unused_field
  final GrpcCallOptionsHelper _callOptionsHelper;
  // ignore: unused_field
  final AccountManager _accountManager;
  final http.Client _client;
  final FlutterSecureStorage _storage;

  static const Duration _timeout = Duration(seconds: 30);
  static const String _accessTokenKey = 'access_token';

  /// See `PlanMyDayRepository._normalizeBase`: both the injected base and the
  /// endpoint-registry fallback end in `/api/v1`, so strip a trailing one to
  /// avoid `.../api/v1/api/v1/...`.
  static String _normalizeBase(String base) {
    final trimmed = base.replaceAll(RegExp(r'/+$'), '');
    return trimmed.replaceAll(RegExp(r'/api/v1$'), '');
  }

  EmailRepository({
    String? baseUrl,
    required GrpcCallOptionsHelper callOptionsHelper,
    required AccountManager accountManager,
    http.Client? client,
    FlutterSecureStorage? storage,
  })  : _baseUrl = _normalizeBase(baseUrl ?? endpointRegistry.httpLifestyle),
        _callOptionsHelper = callOptionsHelper,
        _accountManager = accountManager,
        _client = client ?? http.Client(),
        _storage = storage ?? const FlutterSecureStorage();

  Future<Map<String, String>> _authHeaders() async {
    final token = await _storage.read(key: _accessTokenKey);
    if (token == null || token.isEmpty) {
      throw EmailAuthException('No authentication token found');
    }
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  Uri _uri(String path, [Map<String, String>? query]) {
    final uri = Uri.parse('$_baseUrl$path');
    if (query == null || query.isEmpty) return uri;
    return uri.replace(queryParameters: query);
  }

  /// Decodes a successful JSON body or throws a typed exception.
  Map<String, dynamic> _decode(http.Response response, String errorMessage) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) return const {};
      try {
        final decoded = jsonDecode(response.body);
        return decoded is Map<String, dynamic>
            ? decoded
            : <String, dynamic>{'data': decoded};
      } catch (e) {
        throw EmailException('Failed to parse response: $e');
      }
    }
    if (response.statusCode == 401) {
      throw EmailAuthException('Authentication failed');
    }
    if (response.statusCode == 404) {
      throw EmailNotFoundException('Not found');
    }
    String message = errorMessage;
    try {
      final data = jsonDecode(response.body);
      if (data is Map && data['error'] != null) {
        message = data['error'].toString();
      }
    } catch (_) {
      // keep default message
    }
    throw EmailApiException(message, statusCode: response.statusCode);
  }

  Future<T> _run<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on EmailException {
      rethrow;
    } on SocketException catch (e) {
      throw EmailNetworkException('Network error: ${e.message}');
    } on http.ClientException catch (e) {
      throw EmailNetworkException('Network error: ${e.message}');
    } catch (e) {
      throw EmailException('Unexpected error: $e');
    }
  }

  // ==================== CONNECT / STATUS ====================

  Future<EmailConnectionStatus> connect({
    required String serverAuthCode,
    String redirectUri = '',
  }) async {
    return _run(() async {
      final response = await _client
          .post(
            _uri('/api/v1/planning/email/connect'),
            headers: await _authHeaders(),
            body: jsonEncode({
              'server_auth_code': serverAuthCode,
              'redirect_uri': redirectUri,
            }),
          )
          .timeout(_timeout);
      final data = _decode(response, 'Failed to connect Gmail');
      // The connect response carries success/email/status; fold it into a
      // status entity so callers get a consistent connected view.
      return EmailConnectionStatus.disconnected.copyWith(
        connected: data['success'] == true || data['connected'] == true,
        email: (data['email'] ?? '').toString(),
        status: (data['status'] ?? 'connected').toString(),
      );
    });
  }

  Future<EmailConnectionStatus> getStatus() async {
    return _run(() async {
      final response = await _client
          .get(
            _uri('/api/v1/planning/email/status'),
            headers: await _authHeaders(),
          )
          .timeout(_timeout);
      final data = _decode(response, 'Failed to load email status');
      return EmailConnectionStatusModel.fromJson(data);
    });
  }

  Future<void> disconnect() async {
    return _run(() async {
      final response = await _client
          .post(
            _uri('/api/v1/planning/email/disconnect'),
            headers: await _authHeaders(),
          )
          .timeout(_timeout);
      _decode(response, 'Failed to disconnect Gmail');
    });
  }

  Future<void> updateSettings({
    required bool autoReplyEnabled,
    required int digestHour,
  }) async {
    return _run(() async {
      final response = await _client
          .put(
            _uri('/api/v1/planning/email/settings'),
            headers: await _authHeaders(),
            body: jsonEncode({
              'auto_reply_enabled': autoReplyEnabled,
              'digest_hour': digestHour,
            }),
          )
          .timeout(_timeout);
      _decode(response, 'Failed to update settings');
    });
  }

  /// Returns the number of newly synced messages.
  Future<int> sync() async {
    return _run(() async {
      final response = await _client
          .post(
            _uri('/api/v1/planning/email/sync'),
            headers: await _authHeaders(),
          )
          .timeout(_timeout);
      final data = _decode(response, 'Failed to sync emails');
      final v = data['new_count'];
      if (v is int) return v;
      if (v is num) return v.toInt();
      if (v is String) return int.tryParse(v) ?? 0;
      return 0;
    });
  }

  // ==================== SUMMARIES / MESSAGES ====================

  Future<EmailSummariesResult> getSummaries({
    String range = 'today',
    int? hours,
    String? start,
    String? end,
    int limit = 20,
    int offset = 0,
    bool includeDigest = true,
  }) async {
    return _run(() async {
      final query = <String, String>{
        'range': range,
        'limit': limit.toString(),
        'offset': offset.toString(),
        'include_digest': includeDigest.toString(),
      };
      if (hours != null) query['hours'] = hours.toString();
      if (start != null && start.isNotEmpty) query['start'] = start;
      if (end != null && end.isNotEmpty) query['end'] = end;

      final response = await _client
          .get(
            _uri('/api/v1/planning/email/summaries', query),
            headers: await _authHeaders(),
          )
          .timeout(_timeout);
      final data = _decode(response, 'Failed to load emails');
      return EmailSummariesResultModel.fromJson(data);
    });
  }

  Future<EmailMessageDetail> getMessage(String gmailMessageId) async {
    return _run(() async {
      final response = await _client
          .get(
            _uri('/api/v1/planning/email/messages/$gmailMessageId'),
            headers: await _authHeaders(),
          )
          .timeout(_timeout);
      final data = _decode(response, 'Failed to load message');
      return EmailMessageDetailModel.fromJson(data);
    });
  }

  // ==================== DRAFTS / REPLIES ====================

  Future<EmailDraft> draftReply({
    required String gmailMessageId,
    String tone = 'professional',
    String instructions = '',
  }) async {
    return _run(() async {
      final response = await _client
          .post(
            _uri('/api/v1/planning/email/draft-reply'),
            headers: await _authHeaders(),
            body: jsonEncode({
              'gmail_message_id': gmailMessageId,
              'tone': tone,
              'instructions': instructions,
            }),
          )
          .timeout(_timeout);
      final data = _decode(response, 'Failed to draft reply');
      final raw = data['draft'];
      if (raw is Map) {
        return EmailDraftModel.fromJson(Map<String, dynamic>.from(raw));
      }
      throw EmailException('Failed to draft reply');
    });
  }

  /// Sends a reply. Provide [draftId] OR [gmailMessageId]; [body] is the final
  /// text. Returns the sent message id.
  Future<String> sendReply({
    String? draftId,
    String? gmailMessageId,
    required String body,
  }) async {
    return _run(() async {
      final payload = <String, dynamic>{'body': body};
      if (draftId != null && draftId.isNotEmpty) payload['draft_id'] = draftId;
      if (gmailMessageId != null && gmailMessageId.isNotEmpty) {
        payload['gmail_message_id'] = gmailMessageId;
      }
      final response = await _client
          .post(
            _uri('/api/v1/planning/email/send-reply'),
            headers: await _authHeaders(),
            body: jsonEncode(payload),
          )
          .timeout(_timeout);
      final data = _decode(response, 'Failed to send reply');
      return (data['sent_id'] ?? '').toString();
    });
  }

  Future<List<EmailDraft>> getDrafts() async {
    return _run(() async {
      final response = await _client
          .get(
            _uri('/api/v1/planning/email/drafts'),
            headers: await _authHeaders(),
          )
          .timeout(_timeout);
      final data = _decode(response, 'Failed to load drafts');
      final raw = data['drafts'];
      if (raw is List) {
        return raw
            .whereType<Map>()
            .map((d) => EmailDraftModel.fromJson(Map<String, dynamic>.from(d)))
            .toList();
      }
      return const [];
    });
  }

  /// Approve a queued draft (optionally edited) and send it. Returns sent id.
  Future<String> approveDraft(String draftId, {String? editedBody}) async {
    return _run(() async {
      final payload = <String, dynamic>{};
      if (editedBody != null) payload['edited_body'] = editedBody;
      final response = await _client
          .post(
            _uri('/api/v1/planning/email/drafts/$draftId/approve'),
            headers: await _authHeaders(),
            body: jsonEncode(payload),
          )
          .timeout(_timeout);
      final data = _decode(response, 'Failed to approve draft');
      return (data['sent_id'] ?? '').toString();
    });
  }

  Future<void> discardDraft(String draftId) async {
    return _run(() async {
      final response = await _client
          .post(
            _uri('/api/v1/planning/email/drafts/$draftId/discard'),
            headers: await _authHeaders(),
          )
          .timeout(_timeout);
      _decode(response, 'Failed to discard draft');
    });
  }

  // ==================== BUILD MY DAY ====================

  Future<EmailBuildDayResult> buildDay({
    String range = 'today',
    int? hours,
  }) async {
    return _run(() async {
      final payload = <String, dynamic>{'range': range};
      if (hours != null) payload['hours'] = hours;
      final response = await _client
          .post(
            _uri('/api/v1/planning/email/build-day'),
            headers: await _authHeaders(),
            body: jsonEncode(payload),
          )
          .timeout(_timeout);
      final data = _decode(response, 'Failed to build day from emails');
      return EmailBuildDayResultModel.fromJson(data);
    });
  }

  // ==================== RULES ====================

  Future<List<EmailRule>> getRules() async {
    return _run(() async {
      final response = await _client
          .get(
            _uri('/api/v1/planning/email/rules'),
            headers: await _authHeaders(),
          )
          .timeout(_timeout);
      final data = _decode(response, 'Failed to load rules');
      final raw = data['rules'];
      if (raw is List) {
        return raw
            .whereType<Map>()
            .map((r) => EmailRuleModel.fromJson(Map<String, dynamic>.from(r)))
            .toList();
      }
      return const [];
    });
  }

  Future<EmailRule> saveRule(EmailRule rule) async {
    return _run(() async {
      final response = await _client
          .post(
            _uri('/api/v1/planning/email/rules'),
            headers: await _authHeaders(),
            body: jsonEncode(EmailRuleModel.toJson(rule)),
          )
          .timeout(_timeout);
      final data = _decode(response, 'Failed to save rule');
      final raw = data['rule'];
      if (raw is Map) {
        return EmailRuleModel.fromJson(Map<String, dynamic>.from(raw));
      }
      throw EmailException('Failed to save rule');
    });
  }

  Future<void> deleteRule(String ruleId) async {
    return _run(() async {
      final response = await _client
          .delete(
            _uri('/api/v1/planning/email/rules/$ruleId'),
            headers: await _authHeaders(),
          )
          .timeout(_timeout);
      _decode(response, 'Failed to delete rule');
    });
  }
}

// ==================== EXCEPTIONS ====================

class EmailException implements Exception {
  final String message;
  EmailException(this.message);
  @override
  String toString() => message;
}

class EmailNetworkException extends EmailException {
  EmailNetworkException(super.message);
}

class EmailAuthException extends EmailException {
  EmailAuthException(super.message);
}

class EmailNotFoundException extends EmailException {
  EmailNotFoundException(super.message);
}

class EmailApiException extends EmailException {
  final int statusCode;
  EmailApiException(super.message, {this.statusCode = 500});
}
