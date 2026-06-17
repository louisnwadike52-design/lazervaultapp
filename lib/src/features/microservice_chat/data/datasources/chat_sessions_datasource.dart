import 'package:dio/dio.dart';
import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';
import '../../domain/entities/chat_session_summary.dart';

/// Thin HTTP client for the multi-tab chat-sessions endpoints exposed by
/// chat-agent-gateway (port 3011):
///   GET    /chat/sessions
///   POST   /chat/sessions
///   PATCH  /chat/sessions/{id}
///   DELETE /chat/sessions/{id}
///
/// All four are bearer-token authed and bounce off `verify_access_token`
/// on the gateway. Auth metadata is built via the same helper the rest of
/// the chat surface uses (`GrpcCallOptionsHelper`) so we get user-country
/// / locale / account-id headers for free.
class ChatSessionsDataSource {
  final Dio _dio;
  final GrpcCallOptionsHelper _callOptionsHelper;
  final SecureStorageService _secureStorageService;
  final String _baseUrl;

  ChatSessionsDataSource({
    required Dio dio,
    required GrpcCallOptionsHelper callOptionsHelper,
    required SecureStorageService secureStorageService,
    required String baseUrl,
  })  : _dio = dio,
        _callOptionsHelper = callOptionsHelper,
        _secureStorageService = secureStorageService,
        _baseUrl = baseUrl;

  Future<Map<String, String>> _headers() async {
    final opts = await _callOptionsHelper.withAuth();
    return {'Content-Type': 'application/json', ...opts.metadata};
  }

  Future<String> _resolveUserId() async {
    final id = await _secureStorageService.getUserId();
    return id ?? 'unknown';
  }

  Future<String> _resolveAccessToken() async {
    // Required by Pydantic model validators on the gateway. The interceptor
    // header still authenticates the request — `access_token` in the body
    // exists for parity with the legacy /chat endpoint.
    return await _secureStorageService.getAccessToken() ?? '';
  }

  /// List sessions for the current user. Returns drawer-row summaries
  /// sorted by `last_activity` DESC.
  Future<({List<ChatSessionSummary> sessions, String? nextCursor})> list({
    int limit = 20,
    String? cursor,
  }) async {
    final userId = await _resolveUserId();
    final token = await _resolveAccessToken();
    final response = await _dio.get<Map<String, dynamic>>(
      '$_baseUrl/chat/sessions',
      queryParameters: {
        'user_id': userId,
        'access_token': token,
        'limit': limit,
        if (cursor != null && cursor.isNotEmpty) 'cursor': cursor,
      },
      options: Options(headers: await _headers()),
    );
    if (response.statusCode != 200 || response.data == null) {
      throw ChatSessionsException(
        'Failed to list chat sessions',
        statusCode: response.statusCode,
      );
    }
    final raw = response.data!;
    final list = (raw['sessions'] as List? ?? const [])
        .whereType<Map>()
        .map((e) => ChatSessionSummary.fromJson(Map<String, dynamic>.from(e)))
        .toList(growable: false);
    return (sessions: list, nextCursor: raw['next_cursor'] as String?);
  }

  /// Create a new empty session. Returns the freshly-minted summary.
  Future<ChatSessionSummary> create({String? title, String? locale}) async {
    final userId = await _resolveUserId();
    final token = await _resolveAccessToken();
    final response = await _dio.post<Map<String, dynamic>>(
      '$_baseUrl/chat/sessions',
      data: {
        'user_id': userId,
        'access_token': token,
        if (title != null && title.trim().isNotEmpty) 'title': title.trim(),
        if (locale != null && locale.isNotEmpty) 'locale': locale,
        'source': 'flutter',
      },
      options: Options(headers: await _headers()),
    );
    if (response.statusCode != 200 || response.data == null) {
      throw ChatSessionsException(
        'Failed to create chat session',
        statusCode: response.statusCode,
      );
    }
    return ChatSessionSummary.fromJson(response.data!);
  }

  /// Rename a session. Locks the title against auto-derive.
  Future<ChatSessionSummary> rename({
    required String sessionId,
    required String title,
  }) async {
    final userId = await _resolveUserId();
    final token = await _resolveAccessToken();
    final response = await _dio.patch<Map<String, dynamic>>(
      '$_baseUrl/chat/sessions/$sessionId',
      data: {
        'user_id': userId,
        'access_token': token,
        'title': title,
      },
      options: Options(headers: await _headers()),
    );
    if (response.statusCode != 200 || response.data == null) {
      throw ChatSessionsException(
        'Failed to rename chat session',
        statusCode: response.statusCode,
      );
    }
    // Server returns {session_id, title, last_activity} — extend into a full
    // summary using local defaults for the missing fields. Callers (cubit)
    // typically merge this into the existing local row.
    final raw = response.data!;
    return ChatSessionSummary(
      sessionId: raw['session_id'] as String? ?? sessionId,
      title: (raw['title'] as String? ?? 'New chat').trim(),
      firstMessagePreview: '',
      createdAt: DateTime.now().toUtc(),
      lastActivity: DateTime.tryParse(
              '${raw['last_activity'] as String? ?? ''}Z') ??
          DateTime.now().toUtc(),
      messageCount: 0,
      activeService: '',
    );
  }

  /// Delete a session: clears Redis + soft-deletes Postgres rows.
  Future<void> delete(String sessionId) async {
    final userId = await _resolveUserId();
    final token = await _resolveAccessToken();
    final response = await _dio.delete<Map<String, dynamic>>(
      '$_baseUrl/chat/sessions/$sessionId',
      data: {
        'user_id': userId,
        'access_token': token,
      },
      options: Options(headers: await _headers()),
    );
    if (response.statusCode != 200) {
      throw ChatSessionsException(
        'Failed to delete chat session',
        statusCode: response.statusCode,
      );
    }
  }
}

class ChatSessionsException implements Exception {
  final String message;
  final int? statusCode;
  ChatSessionsException(this.message, {this.statusCode});
  @override
  String toString() => message;
}
