import 'package:dio/dio.dart';
import 'package:lazervault/core/services/endpoint_registry.dart';
import 'package:lazervault/core/services/grpc_call_options_helper.dart';

// Define models
class ChatRequest {
  final String message;
  final String sessionId;
  final String userId;
  final String accessToken;
  final String sourceContext;
  final String language;
  final String locale;
  final Map<String, dynamic> metadata;
  final String? mediaBase64;
  final String? mediaType; // 'image' | 'voice'
  final String? mediaMimeType;

  ChatRequest({
    required this.message,
    required this.sessionId,
    required this.userId,
    required this.accessToken,
    required this.sourceContext,
    this.language = 'en',
    this.locale = 'en-NG',
    this.metadata = const {},
    this.mediaBase64,
    this.mediaType,
    this.mediaMimeType,
  });

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'session_id': sessionId,
      'user_id': userId,
      'access_token': accessToken,
      'source_context': sourceContext,
      'language': language,
      'locale': locale,
      'metadata': metadata,
      if (mediaBase64 != null && mediaBase64!.isNotEmpty)
        'media_base64': mediaBase64,
      if (mediaType != null && mediaType!.isNotEmpty) 'media_type': mediaType,
      if (mediaMimeType != null && mediaMimeType!.isNotEmpty)
        'media_mime_type': mediaMimeType,
    };
  }
}

class ChatResponse {
  final String response;
  final Map<String, dynamic> metadata;
  final Map<String, dynamic>? receiptData;

  /// LLM degradation code from chat_services_shared/llm_failover.py, so a
  /// per-service chat can show the same "AI is temporarily down" banner the
  /// general chat shows. The chat proxy dropped this field entirely, so the
  /// per-service user saw the fallback sentence with nothing explaining it.
  final String? llmErrorCode;

  ChatResponse({
    required this.response,
    required this.metadata,
    this.receiptData,
    this.llmErrorCode,
  });

  factory ChatResponse.fromJson(Map<String, dynamic> json) {
    // Accept both the proxy's top-level field and the nested shape the
    // Python services emit, so either route renders the banner.
    String? code = json['llm_error_code'] as String?;
    if (code == null || code.isEmpty) {
      final meta = json['metadata'];
      if (meta is Map && meta['llm_error_code'] is String) {
        code = meta['llm_error_code'] as String;
      }
    }
    return ChatResponse(
      response: json['response'] as String? ?? '',
      metadata: json['metadata'] as Map<String, dynamic>? ?? {},
      receiptData: json['receipt_data'] as Map<String, dynamic>?,
      llmErrorCode: (code == null || code.isEmpty) ? null : code,
    );
  }
}

class ChatHistoryResponse {
  /// Chronological ASC (oldest→newest) — the order the thread renders. The
  /// NEWEST page comes back first; older pages are fetched with [nextBefore]
  /// and prepended.
  final List<ChatHistoryMessage> history;

  /// Count of the whole thread, not of this page.
  final int totalCount;
  final String sessionId;

  /// Pass back as `before` to fetch the next OLDER page. Empty when this page
  /// reached the start of the conversation.
  final String nextBefore;

  /// Whether an older page exists. A scroll-up loop must stop on false rather
  /// than keep asking — and a server error answers false for exactly that
  /// reason, so a failing query is not retried on every scroll event.
  final bool hasMore;

  ChatHistoryResponse({
    required this.history,
    required this.totalCount,
    required this.sessionId,
    this.nextBefore = '',
    this.hasMore = false,
  });

  factory ChatHistoryResponse.fromJson(Map<String, dynamic> json) {
    final historyList = (json['history'] as List<dynamic>?) ?? [];
    final total = json['total_count'] as int? ?? 0;
    final messages = historyList
        .map((e) => ChatHistoryMessage.fromJson(e as Map<String, dynamic>))
        .toList();
    // `has_more` is authoritative when the server sends it. An older gateway
    // build does not, and the count comparison is the honest fallback: it is
    // right for the first page (the only page such a build could serve, since
    // it has no cursor to give) and conservative after that.
    final serverHasMore = json['has_more'] as bool?;
    return ChatHistoryResponse(
      history: messages,
      totalCount: total,
      sessionId: json['session_id'] as String? ?? '',
      nextBefore: (json['next_before'] as String?) ?? '',
      hasMore: serverHasMore ?? (messages.length < total),
    );
  }
}

class ChatHistoryMessage {
  /// The row's own id, or 0 when the surface did not send one.
  ///
  /// It is the handle `POST /chat/feedback` rates by, so a message restored
  /// from history with no id cannot be rated at all — the per-service gRPC
  /// history dropped it entirely until the proto gained `message_id`.
  final int messageId;
  final String role;
  final String content;
  final String service;
  final String sourceContext;
  final String timestamp;
  final Map<String, dynamic>? mediaMetadata;
  final Map<String, dynamic>? entities;
  final Map<String, dynamic>? metadata;

  ChatHistoryMessage({
    this.messageId = 0,
    required this.role,
    required this.content,
    required this.service,
    required this.sourceContext,
    required this.timestamp,
    this.mediaMetadata,
    this.entities,
    this.metadata,
  });

  factory ChatHistoryMessage.fromJson(Map<String, dynamic> json) {
    final metadata = json['metadata'] as Map<String, dynamic>?;
    return ChatHistoryMessage(
      messageId: (json['message_id'] as num?)?.toInt() ?? 0,
      role: json['role'] as String? ?? '',
      content: json['content'] as String? ?? '',
      service: json['service'] as String? ?? '',
      sourceContext: json['source_context'] as String? ?? '',
      timestamp: json['timestamp'] as String? ?? '',
      mediaMetadata:
          metadata != null ? metadata['media'] as Map<String, dynamic>? : null,
      entities: json['entities'] as Map<String, dynamic>?,
      metadata: metadata,
    );
  }
}

abstract class MicroserviceChatDataSource {
  Future<ChatResponse> processChat(ChatRequest request);
  Future<void> sendTypingIndicator(String sessionId, bool isTyping);
  /// One page of a thread, newest page first.
  ///
  /// [before] is the `nextBefore` from the previous page and fetches the next
  /// OLDER page. Prefer it over [offset]: OFFSET walks and discards rows to
  /// reach the page, and the window SHIFTS when a new message arrives, so
  /// sending a message while scrolled up makes the next "load older" page
  /// start one row late and silently drops a message out of the middle of the
  /// history.
  Future<ChatHistoryResponse> getHistory({
    required String sourceContext,
    required String sessionId,
    required String accessToken,
    String? locale,
    int limit = 30,
    String? before,
  });
}

class HttpMicroserviceChatDataSource implements MicroserviceChatDataSource {
  final Dio dio;
  final GrpcCallOptionsHelper callOptionsHelper;
  final String baseUrl;

  HttpMicroserviceChatDataSource({
    required this.dio,
    required this.callOptionsHelper,
    String? baseUrl,
  }) : baseUrl = baseUrl ?? endpointRegistry.httpChatAgent;

  @override
  Future<ChatResponse> processChat(ChatRequest request) async {
    try {
      final options = await callOptionsHelper.withAuth();

      // Media messages need longer timeouts:
      // - sendTimeout: uploading large base64 over 2G/3G can be slow
      // - receiveTimeout: server processes GCS upload + Whisper/Vision + agent
      final hasMedia =
          request.mediaBase64 != null && request.mediaBase64!.isNotEmpty;

      final response = await dio.post(
        '$baseUrl/chat',
        data: request.toJson(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            ...options.metadata,
          },
          sendTimeout: hasMedia ? const Duration(seconds: 120) : null,
          receiveTimeout: hasMedia ? const Duration(seconds: 90) : null,
        ),
      );

      if (response.statusCode == 200) {
        return ChatResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to process chat: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.sendTimeout) {
        throw Exception(
            'Upload timed out. Your connection may be too slow, try a smaller file or better network.');
      }
      if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception(
            'The server took too long to respond. Please try again.');
      }
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Error processing chat: $e');
    }
  }

  @override
  Future<ChatHistoryResponse> getHistory({
    required String sourceContext,
    required String sessionId,
    required String accessToken,
    String? locale,
    int limit = 30,
    String? before,
  }) async {
    try {
      final options = await callOptionsHelper.withAuth();

      final queryParams = <String, dynamic>{
        'user_id': '', // Will be extracted from token on backend
        'session_id': sessionId,
        'source_context': sourceContext,
      // NO `access_token` HERE. uvicorn prints the full request line, so a
      // token in the query string was written into the gateway's access log
      // in plaintext — a live JWT with 24h of full account access, in a file
      // that persists. The Authorization header below authenticates the call
      // (the gateway reads it first); the query parameter was pure
      // duplication.
        'limit': limit,
      };
      // Cursor when we have one; otherwise the newest page. `offset` is NOT
      // sent alongside a cursor — the server ignores it, and sending both
      // invites a future build to apply them together, which would skip a
      // whole page past the cursor.
      if (before != null && before.isNotEmpty) {
        queryParams['before'] = before;
      } else {
        queryParams['offset'] = 0;
      }

      // Filter history by locale when provided
      if (locale != null && locale.isNotEmpty) {
        queryParams['locale'] = locale;
      }

      final response = await dio.get(
        '$baseUrl/chat/history',
        queryParameters: queryParams,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            ...options.metadata,
          },
        ),
      );

      if (response.statusCode == 200) {
        return ChatHistoryResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to get history: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    } catch (e) {
      throw Exception('Error fetching history: $e');
    }
  }

  @override
  Future<void> sendTypingIndicator(String sessionId, bool isTyping) async {
    // Optional: Implement typing indicator via WebSocket
    // For now, this is a no-op as typing indicators are handled locally
  }
}
