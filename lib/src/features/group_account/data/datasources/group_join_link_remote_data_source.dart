import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:lazervault/core/services/endpoint_registry.dart';

/// A group's shareable invite link.
class GroupJoinLink {
  final String token;
  final String groupId;

  /// Canonical https share URL. Built SERVER-side so the origin can change
  /// without shipping an app update — never re-derive it on the client.
  final String url;
  final String role;
  final DateTime? expiresAt;

  /// 0 = unlimited.
  final int maxUses;
  final int useCount;
  final bool revoked;

  const GroupJoinLink({
    required this.token,
    required this.groupId,
    required this.url,
    required this.role,
    required this.expiresAt,
    required this.maxUses,
    required this.useCount,
    required this.revoked,
  });

  int? get usesRemaining => maxUses <= 0 ? null : (maxUses - useCount);
}

/// What the opener of a shared link sees BEFORE joining. Carries nothing
/// sensitive — no member list, no balances, no contributions.
class GroupJoinLinkPreview {
  final bool valid;

  /// Machine reason when [valid] is false: not_found | expired | revoked |
  /// exhausted. Mapped to copy by the UI.
  final String invalidReason;
  final String groupId;
  final String groupName;
  final String groupDescription;
  final int memberCount;
  final String inviterName;
  final String role;
  final DateTime? expiresAt;
  final bool alreadyMember;

  const GroupJoinLinkPreview({
    required this.valid,
    required this.invalidReason,
    required this.groupId,
    required this.groupName,
    required this.groupDescription,
    required this.memberCount,
    required this.inviterName,
    required this.role,
    required this.expiresAt,
    required this.alreadyMember,
  });

  /// Human copy for an unusable link. One sentence, actionable, never blames
  /// the opener.
  String get invalidMessage {
    switch (invalidReason) {
      case 'expired':
        return 'This invite link has expired. Ask the group admin for a new one.';
      case 'revoked':
        return 'This invite link was turned off by the group admin.';
      case 'exhausted':
        return 'This invite link has already been used the maximum number of times.';
      // A link outlives the group it points at: the server reports the
      // group's state so we can say what actually happened instead of
      // implying the link itself is bad.
      case 'group_suspended':
        return 'This group is suspended right now, so new members can’t join. '
            'Ask the group admin to check with support.';
      case 'group_closed':
        return 'This group has been closed, so it’s no longer accepting members.';
      case 'not_found':
      default:
        return "This invite link isn't valid. Ask the group admin for a new one.";
    }
  }
}

class GroupJoinResult {
  final bool success;
  final String message;
  final String groupId;
  final bool alreadyMember;

  const GroupJoinResult({
    required this.success,
    required this.message,
    required this.groupId,
    required this.alreadyMember,
  });
}

/// Talks to the group-accounts grpc-gateway HTTP routes for shareable invite
/// links. Same transport + base resolution as the past-membership screens, so
/// no new gRPC channel (or Dart proto regen) is needed in the app.
class GroupJoinLinkRemoteDataSource {
  GroupJoinLinkRemoteDataSource({http.Client? client})
      : _client = client ?? http.Client();

  final http.Client _client;

  late final String _base = _resolveBase();

  String _resolveBase() {
    for (final k in const ['FINANCIAL_GATEWAY_HTTP', 'FINANCIAL_HTTP_URL']) {
      final v = dotenv.maybeGet(k);
      if (v != null && v.trim().isNotEmpty) {
        return v.trim().replaceAll(RegExp(r'/$'), '');
      }
    }
    return endpointRegistry.httpFinancial;
  }

  Map<String, String> _headers(String token) => {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

  DateTime? _ts(dynamic v) {
    if (v is String && v.isNotEmpty) return DateTime.tryParse(v);
    return null;
  }

  int _int(dynamic v) => int.tryParse('${v ?? 0}') ?? 0;

  /// Mint (or fetch) the group's active share link. Admin/moderator only —
  /// a 403 means the caller isn't allowed to invite.
  Future<GroupJoinLink> createOrGetLink({
    required String token,
    required String groupId,
    bool rotate = false,
    int expiresInHours = 0,
    int maxUses = 0,
  }) async {
    final uri = Uri.parse('$_base/v1/groups/$groupId/join-link');
    final res = await _client.post(
      uri,
      headers: _headers(token),
      body: jsonEncode({
        'group_id': groupId,
        'rotate': rotate,
        'expires_in_hours': expiresInHours,
        'max_uses': maxUses,
      }),
    );
    if (res.statusCode < 200 || res.statusCode >= 300) {
      throw 'Could not create invite link (${res.statusCode})';
    }
    final body = jsonDecode(res.body) as Map<String, dynamic>;
    final l = (body['link'] as Map<String, dynamic>?) ?? const {};
    return GroupJoinLink(
      token: (l['token'] as String?) ?? '',
      groupId: (l['groupId'] ?? l['group_id']) as String? ?? groupId,
      url: (l['url'] as String?) ?? '',
      role: (l['role'] as String?) ?? 'member',
      expiresAt: _ts(l['expiresAt'] ?? l['expires_at']),
      maxUses: _int(l['maxUses'] ?? l['max_uses']),
      useCount: _int(l['useCount'] ?? l['use_count']),
      revoked: (l['revoked'] as bool?) ?? false,
    );
  }

  /// Resolve a shared token. Never throws for an unusable link — the server
  /// answers 200 with valid=false so the app renders one explanatory screen.
  Future<GroupJoinLinkPreview> preview({
    required String token,
    required String linkToken,
  }) async {
    final uri = Uri.parse('$_base/v1/group-join-links/$linkToken');
    final res = await _client.get(uri, headers: _headers(token));
    if (res.statusCode < 200 || res.statusCode >= 300) {
      throw 'Could not open this invite (${res.statusCode})';
    }
    final b = jsonDecode(res.body) as Map<String, dynamic>;
    return GroupJoinLinkPreview(
      valid: (b['valid'] as bool?) ?? false,
      invalidReason:
          (b['invalidReason'] ?? b['invalid_reason']) as String? ?? '',
      groupId: (b['groupId'] ?? b['group_id']) as String? ?? '',
      groupName: (b['groupName'] ?? b['group_name']) as String? ?? '',
      groupDescription:
          (b['groupDescription'] ?? b['group_description']) as String? ?? '',
      memberCount: _int(b['memberCount'] ?? b['member_count']),
      inviterName: (b['inviterName'] ?? b['inviter_name']) as String? ?? '',
      role: (b['role'] as String?) ?? 'member',
      expiresAt: _ts(b['expiresAt'] ?? b['expires_at']),
      alreadyMember:
          (b['alreadyMember'] ?? b['already_member']) as bool? ?? false,
    );
  }

  /// Consume the link. Idempotent server-side: an existing member comes back
  /// with alreadyMember=true rather than an error.
  Future<GroupJoinResult> join({
    required String token,
    required String linkToken,
  }) async {
    final uri = Uri.parse('$_base/v1/group-join-links/$linkToken/join');
    final res = await _client.post(
      uri,
      headers: _headers(token),
      body: jsonEncode({'token': linkToken}),
    );
    if (res.statusCode < 200 || res.statusCode >= 300) {
      // Surface the server's own sentence when it sent one — it is written
      // for the user ("this invite link is no longer valid. Ask for a new
      // one.") and beats a generic failure string.
      String msg = 'Could not join this group (${res.statusCode})';
      try {
        final b = jsonDecode(res.body) as Map<String, dynamic>;
        final m = (b['message'] ?? b['error']) as String?;
        if (m != null && m.trim().isNotEmpty) msg = m;
      } catch (_) {/* keep the fallback */}
      throw msg;
    }
    final b = jsonDecode(res.body) as Map<String, dynamic>;
    return GroupJoinResult(
      success: (b['success'] as bool?) ?? false,
      message: (b['message'] as String?) ?? '',
      groupId: (b['groupId'] ?? b['group_id']) as String? ?? '',
      alreadyMember:
          (b['alreadyMember'] ?? b['already_member']) as bool? ?? false,
    );
  }

  /// Turn off the group's active link.
  Future<void> revoke({
    required String token,
    required String groupId,
  }) async {
    final uri = Uri.parse('$_base/v1/groups/$groupId/join-link');
    final res = await _client.delete(uri, headers: _headers(token));
    if (res.statusCode < 200 || res.statusCode >= 300) {
      throw 'Could not turn off the invite link (${res.statusCode})';
    }
  }
}
