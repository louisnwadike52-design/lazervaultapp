import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:lazervault/core/services/endpoint_registry.dart';

/// Delivery state of a chat bubble, mirroring the P2P chat's vocabulary so
/// both chats read the same way to a user.
enum ChatDeliveryStatus {
  /// Optimistic bubble: on screen, not yet acknowledged by the server.
  sending,

  /// Persisted server-side. At least one tick.
  sent,

  /// Every other participant's read watermark has reached it.
  read,

  /// The send failed and can be retried.
  failed,
}

/// One message in a contribution chat.
class ContributionMessage {
  final String id;
  final String contributionId;
  final String senderId;
  final String senderName;

  /// text | voice | image
  final String kind;
  final String body;
  final String mediaUrl;
  final int durationMs;
  final DateTime createdAt;

  /// Echoed back by the server so an optimistic bubble can be reconciled
  /// with its persisted row instead of rendering twice.
  final String clientMessageId;

  // Reply quote — denormalised, so it survives deletion of the original.
  final String replyToMessageId;
  final String replyToBody;
  final String replyToSender;

  /// Ids @-mentioned in [body]. Server-validated against active membership, so
  /// anything here is a real member of this group.
  final List<String> mentionedUserIds;

  /// Non-null ⇒ show an "edited" marker.
  final DateTime? editedAt;

  /// True ⇒ render "This message was deleted" in place of the content.
  final bool deletedForEveryone;

  /// Client-side only: never sent to the server.
  final ChatDeliveryStatus status;

  /// Local file path for an image/voice preview before the upload lands.
  final String? localMediaPath;

  const ContributionMessage({
    required this.id,
    required this.contributionId,
    required this.senderId,
    required this.senderName,
    required this.kind,
    required this.body,
    required this.mediaUrl,
    required this.durationMs,
    required this.createdAt,
    this.clientMessageId = '',
    this.replyToMessageId = '',
    this.replyToBody = '',
    this.replyToSender = '',
    this.editedAt,
    this.deletedForEveryone = false,
    this.status = ChatDeliveryStatus.sent,
    this.localMediaPath,
    this.mentionedUserIds = const [],
  });

  bool get isText => kind == 'text';
  bool get hasReply => replyToMessageId.isNotEmpty;
  bool get isEdited => editedAt != null;

  ContributionMessage copyWith({
    String? id,
    ChatDeliveryStatus? status,
    String? body,
    DateTime? editedAt,
    bool? deletedForEveryone,
  }) {
    return ContributionMessage(
      id: id ?? this.id,
      contributionId: contributionId,
      senderId: senderId,
      senderName: senderName,
      kind: kind,
      body: body ?? this.body,
      mediaUrl: mediaUrl,
      durationMs: durationMs,
      createdAt: createdAt,
      clientMessageId: clientMessageId,
      replyToMessageId: replyToMessageId,
      replyToBody: replyToBody,
      replyToSender: replyToSender,
      editedAt: editedAt ?? this.editedAt,
      deletedForEveryone: deletedForEveryone ?? this.deletedForEveryone,
      status: status ?? this.status,
      localMediaPath: localMediaPath,
    );
  }

  factory ContributionMessage.fromJson(Map<String, dynamic> j) {
    DateTime? ts(dynamic v) =>
        v is String && v.isNotEmpty ? DateTime.tryParse(v)?.toLocal() : null;
    return ContributionMessage(
      id: (j['id'] as String?) ?? '',
      contributionId:
          (j['contributionId'] ?? j['contribution_id']) as String? ?? '',
      senderId: (j['senderId'] ?? j['sender_id']) as String? ?? '',
      senderName: (j['senderName'] ?? j['sender_name']) as String? ?? '',
      kind: (j['kind'] as String?) ?? 'text',
      body: (j['body'] as String?) ?? '',
      // `attachment_url` is what group-accounts' WebSocket fanout emits
      // (fanoutChatMessageToGateway), while the history/list gRPC emits
      // `mediaUrl`. The chat polls today so only the latter is exercised —
      // but the day the socket is consumed, a voice note would arrive with
      // an empty media url and render as a bubble that plays nothing.
      mediaUrl:
          (j['mediaUrl'] ?? j['media_url'] ?? j['attachment_url']) as String? ??
              '',
      durationMs:
          int.tryParse('${j['durationMs'] ?? j['duration_ms'] ?? 0}') ?? 0,
      createdAt: ts(j['createdAt'] ?? j['created_at']) ?? DateTime.now(),
      clientMessageId:
          (j['clientMessageId'] ?? j['client_message_id']) as String? ?? '',
      replyToMessageId:
          (j['replyToMessageId'] ?? j['reply_to_message_id']) as String? ?? '',
      replyToBody: (j['replyToBody'] ?? j['reply_to_body']) as String? ?? '',
      // Tolerates both spellings and a null: an older server simply sends
      // nothing, and a message with no mentions is the common case.
      mentionedUserIds:
          ((j['mentionedUserIds'] ?? j['mentioned_user_ids']) as List<dynamic>?)
                  ?.map((e) => '$e')
                  .where((e) => e.isNotEmpty)
                  .toList() ??
              const [],
      replyToSender:
          (j['replyToSender'] ?? j['reply_to_sender']) as String? ?? '',
      editedAt: ts(j['editedAt'] ?? j['edited_at']),
      deletedForEveryone:
          (j['deletedForEveryone'] ?? j['deleted_for_everyone']) as bool? ??
              false,
    );
  }
}

/// One member's read position — drives ticks and the "seen by" sheet.
class ContributionReader {
  final String userId;
  final String userName;
  final String lastReadMessageId;
  final DateTime? lastReadAt;

  const ContributionReader({
    required this.userId,
    required this.userName,
    required this.lastReadMessageId,
    required this.lastReadAt,
  });

  factory ContributionReader.fromJson(Map<String, dynamic> j) {
    final raw = (j['lastReadAt'] ?? j['last_read_at']) as String?;
    return ContributionReader(
      userId: (j['userId'] ?? j['user_id']) as String? ?? '',
      userName: (j['userName'] ?? j['user_name']) as String? ?? '',
      lastReadMessageId:
          (j['lastReadMessageId'] ?? j['last_read_message_id']) as String? ??
              '',
      lastReadAt: raw != null && raw.isNotEmpty
          ? DateTime.tryParse(raw)?.toLocal()
          : null,
    );
  }
}

/// Who is typing right now (excludes the caller).
class ContributionTyping {
  final String userId;
  final String userName;
  const ContributionTyping({required this.userId, required this.userName});

  factory ContributionTyping.fromJson(Map<String, dynamic> j) =>
      ContributionTyping(
        userId: (j['userId'] ?? j['user_id']) as String? ?? '',
        userName: (j['userName'] ?? j['user_name']) as String? ?? '',
      );
}

/// Everything the chat needs to render state, fetched in ONE poll.
class ContributionChatState {
  final List<ContributionReader> readers;
  final List<ContributionTyping> typing;
  final int unreadCount;

  const ContributionChatState({
    this.readers = const [],
    this.typing = const [],
    this.unreadCount = 0,
  });
}

/// Talks to group-accounts' grpc-gateway HTTP routes for contribution chat.
/// Same transport + base resolution as the other group-funds data sources, so
/// no new gRPC channel (or Dart proto regen) is needed.
class ContributionChatRemoteDataSource {
  ContributionChatRemoteDataSource({http.Client? client})
      : _client = client ?? http.Client();

  final http.Client _client;

  late final String _base = _resolveBase();

  /// Base for the contribution-chat REST calls.
  ///
  /// These endpoints are served by financial-gateway's grpc-gateway mux, and
  /// the group_account proto annotates them WITHOUT the /api prefix
  /// ("/v1/contributions/{id}/messages") — unlike giftcards/invoices, which
  /// annotate "/api/v1/...". endpointRegistry.httpFinancial already ends in
  /// "/api/v1", so appending "/v1/..." produced "/api/v1/v1/contributions/..."
  /// — a path no ingress rule matches, so it fell through to the catch-all and
  /// hit core-gateway, which has no such route. That 404 is what the app
  /// reported as "Can't open this chat" (confirmed in production logs).
  ///
  /// Strip the trailing "/api/v1" so the path we build matches the annotation
  /// the gateway actually serves.
  String _resolveBase() {
    for (final k in const ['FINANCIAL_GATEWAY_HTTP', 'FINANCIAL_HTTP_URL']) {
      final v = dotenv.maybeGet(k);
      if (v != null && v.trim().isNotEmpty) {
        return _stripApiV1(v.trim());
      }
    }
    return _stripApiV1(endpointRegistry.httpFinancial);
  }

  /// Remove a trailing "/api/v1" (and any trailing slash) so callers can append
  /// the gateway's own "/v1/..." path without doubling it.
  static String _stripApiV1(String base) {
    var b = base.replaceAll(RegExp(r'/+$'), '');
    if (b.endsWith('/api/v1')) {
      b = b.substring(0, b.length - '/api/v1'.length);
    }
    return b;
  }

  Map<String, String> _headers(String token) => {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

  /// Fetch messages. [since] enables delta polling — pass the newest message's
  /// createdAt and only newer rows come back.
  Future<List<ContributionMessage>> list({
    required String token,
    required String contributionId,
    DateTime? since,
    int limit = 100,
  }) async {
    final qp = <String, String>{
      'limit': '$limit',
      if (since != null) 'sinceRfc3339': since.toUtc().toIso8601String(),
    };
    final uri = Uri.parse('$_base/v1/contributions/$contributionId/messages')
        .replace(queryParameters: qp);
    final res = await _client.get(uri, headers: _headers(token));
    if (res.statusCode < 200 || res.statusCode >= 300) {
      throw 'Could not load messages (${res.statusCode})';
    }
    final body = jsonDecode(res.body) as Map<String, dynamic>;
    final list = (body['messages'] as List?) ?? const [];
    return list
        .map((m) => ContributionMessage.fromJson(m as Map<String, dynamic>))
        .toList(growable: false);
  }

  /// Send a message. [clientMessageId] makes this IDEMPOTENT: a retry after a
  /// timeout returns the original row rather than posting a duplicate.
  /// Uploads a voice note or image and returns the absolute media URL to hand
  /// to [send].
  ///
  /// The endpoint is plain multipart rather than the gRPC-gateway surface the
  /// rest of this data source uses, because the bytes never belong in a JSON
  /// envelope. group-accounts routes the file to storage-service, so where it
  /// physically lands follows the platform's active storage provider and the
  /// URL returned here is absolute and durable — it keeps resolving even after
  /// an admin switches providers.
  Future<({String mediaUrl, int durationMs})> uploadMedia({
    required String token,
    required String contributionId,
    required File file,
    required String kind, // 'voice' | 'image'
    int durationMs = 0,
  }) async {
    final uri =
        Uri.parse('$_base/v1/contributions/$contributionId/messages/media');
    final req = http.MultipartRequest('POST', uri)
      ..headers['Authorization'] = 'Bearer $token'
      ..fields['kind'] = kind
      ..files.add(await http.MultipartFile.fromPath('file', file.path));
    if (durationMs > 0) {
      req.fields['durationMs'] = durationMs.toString();
    }

    final streamed = await _client.send(req);
    final res = await http.Response.fromStream(streamed);

    if (res.statusCode < 200 || res.statusCode >= 300) {
      // The size guard answers 413 with a plain-text body, so parse
      // defensively rather than assuming JSON.
      String msg = 'Upload failed (${res.statusCode})';
      if (res.statusCode == 413) {
        msg = 'That file is too large to send';
      } else {
        try {
          final b = jsonDecode(res.body) as Map<String, dynamic>;
          final m = (b['message'] ?? b['error']) as String?;
          if (m != null && m.trim().isNotEmpty) msg = m;
        } catch (_) {
          final t = res.body.trim();
          if (t.isNotEmpty && t.length < 160) msg = t;
        }
      }
      throw msg;
    }

    final body = jsonDecode(res.body) as Map<String, dynamic>;
    final url = (body['media_url'] ?? '') as String;
    if (url.isEmpty) {
      throw 'Upload succeeded but returned no media URL';
    }
    return (
      mediaUrl: url,
      durationMs: (body['duration_ms'] as num?)?.toInt() ?? durationMs,
    );
  }

  Future<ContributionMessage> send({
    required String token,
    required String contributionId,
    required String body,
    required String clientMessageId,
    String kind = 'text',
    String mediaUrl = '',
    int durationMs = 0,
    String replyToMessageId = '',
    List<String> mentionedUserIds = const [],
  }) async {
    final uri = Uri.parse('$_base/v1/contributions/$contributionId/messages');
    final res = await _client.post(
      uri,
      headers: _headers(token),
      body: jsonEncode({
        'contribution_id': contributionId,
        'kind': kind,
        'body': body,
        'media_url': mediaUrl,
        'duration_ms': durationMs,
        'client_message_id': clientMessageId,
        'reply_to_message_id': replyToMessageId,
        // Omitted when empty so an older gateway that does not know the field
        // is never sent a null it has to interpret.
        if (mentionedUserIds.isNotEmpty) 'mentioned_user_ids': mentionedUserIds,
      }),
    );
    if (res.statusCode < 200 || res.statusCode >= 300) {
      String msg = 'Could not send (${res.statusCode})';
      try {
        final b = jsonDecode(res.body) as Map<String, dynamic>;
        final m = (b['message'] ?? b['error']) as String?;
        if (m != null && m.trim().isNotEmpty) msg = m;
      } catch (_) {}
      throw msg;
    }
    final b = jsonDecode(res.body) as Map<String, dynamic>;
    return ContributionMessage.fromJson(
        (b['message'] as Map<String, dynamic>?) ?? const {});
  }

  /// Read watermark + typing + unread, in one request.
  Future<ContributionChatState> chatState({
    required String token,
    required String contributionId,
  }) async {
    final uri = Uri.parse('$_base/v1/contributions/$contributionId/chat-state');
    final res = await _client.get(uri, headers: _headers(token));
    if (res.statusCode < 200 || res.statusCode >= 300) {
      return const ContributionChatState();
    }
    final b = jsonDecode(res.body) as Map<String, dynamic>;
    return ContributionChatState(
      readers: ((b['readers'] as List?) ?? const [])
          .map((r) => ContributionReader.fromJson(r as Map<String, dynamic>))
          .toList(growable: false),
      typing: ((b['typing'] as List?) ?? const [])
          .map((t) => ContributionTyping.fromJson(t as Map<String, dynamic>))
          .toList(growable: false),
      unreadCount:
          int.tryParse('${b['unreadCount'] ?? b['unread_count'] ?? 0}') ?? 0,
    );
  }

  /// Advance the caller's read watermark. Safe to call liberally — the server
  /// refuses to move a watermark backwards.
  Future<void> markRead({
    required String token,
    required String contributionId,
    required String messageId,
  }) async {
    final uri =
        Uri.parse('$_base/v1/contributions/$contributionId/messages/read');
    await _client.post(uri,
        headers: _headers(token),
        body: jsonEncode({
          'contribution_id': contributionId,
          'message_id': messageId,
        }));
  }

  /// Ping (or clear) typing presence. Fire-and-forget: a dropped ping just
  /// means the indicator expires a moment early.
  Future<void> setTyping({
    required String token,
    required String contributionId,
    required bool isTyping,
  }) async {
    final uri = Uri.parse('$_base/v1/contributions/$contributionId/typing');
    try {
      await _client.post(uri,
          headers: _headers(token),
          body: jsonEncode({
            'contribution_id': contributionId,
            'is_typing': isTyping,
          }));
    } catch (_) {
      // Presence is cosmetic — never surface a failure to the user.
    }
  }

  Future<ContributionMessage> edit({
    required String token,
    required String contributionId,
    required String messageId,
    required String body,
  }) async {
    final uri = Uri.parse(
        '$_base/v1/contributions/$contributionId/messages/$messageId');
    final res = await _client.patch(uri,
        headers: _headers(token),
        body: jsonEncode({
          'contribution_id': contributionId,
          'message_id': messageId,
          'body': body,
        }));
    if (res.statusCode < 200 || res.statusCode >= 300) {
      throw 'Could not edit this message (${res.statusCode})';
    }
    final b = jsonDecode(res.body) as Map<String, dynamic>;
    return ContributionMessage.fromJson(
        (b['message'] as Map<String, dynamic>?) ?? const {});
  }

  Future<void> deleteForEveryone({
    required String token,
    required String contributionId,
    required String messageId,
  }) async {
    final uri = Uri.parse(
        '$_base/v1/contributions/$contributionId/messages/$messageId/everyone');
    final res = await _client.delete(uri, headers: _headers(token));
    if (res.statusCode < 200 || res.statusCode >= 300) {
      throw 'Could not delete this message (${res.statusCode})';
    }
  }
}
