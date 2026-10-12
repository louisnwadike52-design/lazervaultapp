import 'package:dio/dio.dart';

import 'package:lazervault/core/services/endpoint_registry.dart';
import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/src/features/microservice_chat/presentation/widgets/chat_response_actions.dart';

/// Thumbs up / down on an assistant answer, against the chat proxy gateway.
///
/// BEST-EFFORT BY DESIGN. A rating is a nicety; a chat is the product. Every
/// method here swallows its failure and reports it as a bool, so a feedback
/// outage can never break a conversation or surface a scary error over an
/// answer the user was happy with. The UI reflects the tap immediately and
/// quietly reverts if the write did not land.
class ChatFeedbackDataSource {
  final Dio dio;
  final GrpcCallOptionsHelper callOptionsHelper;
  final String baseUrl;

  ChatFeedbackDataSource({
    required this.dio,
    required this.callOptionsHelper,
    String? baseUrl,
  }) : baseUrl = baseUrl ?? endpointRegistry.httpChatAgent;

  static String verdictWire(ChatFeedbackVerdict v) => switch (v) {
        ChatFeedbackVerdict.up => 'up',
        ChatFeedbackVerdict.down => 'down',
        // Retraction. The server deletes the row rather than storing a third
        // state, so an un-toggled thumb leaves no opinion behind.
        ChatFeedbackVerdict.none => 'none',
      };

  static ChatFeedbackVerdict verdictFromWire(String? s) => switch (s) {
        'up' => ChatFeedbackVerdict.up,
        'down' => ChatFeedbackVerdict.down,
        _ => ChatFeedbackVerdict.none,
      };

  Future<bool> submit({
    required String sessionId,
    required String responseKey,
    required ChatFeedbackVerdict verdict,
    required String service,
    String sourceContext = '',
    String locale = 'en-NG',
    String prompt = '',
    String response = '',
    String model = '',
  }) async {
    if (sessionId.trim().isEmpty || responseKey.trim().isEmpty) return false;
    try {
      final options = await callOptionsHelper.withAuth();
      final res = await dio.post(
        '$baseUrl/api/v1/chat/feedback',
        data: {
          'session_id': sessionId,
          'response_key': responseKey,
          'verdict': verdictWire(verdict),
          'service': service,
          'source_context': sourceContext,
          'locale': locale,
          'prompt': prompt,
          'response': response,
          'model': model,
        },
        options: Options(headers: {
          'Content-Type': 'application/json',
          ...options.metadata,
        }),
      );
      return res.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  /// This user's verdicts for a session, keyed by response key. Empty on any
  /// failure, which renders as "not yet rated" — the safe direction, since
  /// showing no thumb invites a vote while showing a wrong one misreports
  /// what they said.
  Future<Map<String, ChatFeedbackVerdict>> forSession(String sessionId) async {
    if (sessionId.trim().isEmpty) return const {};
    try {
      final options = await callOptionsHelper.withAuth();
      final res = await dio.get(
        '$baseUrl/api/v1/chat/feedback',
        queryParameters: {'session_id': sessionId},
        options: Options(headers: {...options.metadata}),
      );
      final raw = (res.data is Map) ? res.data['verdicts'] : null;
      if (raw is! Map) return const {};
      return {
        for (final e in raw.entries)
          e.key.toString(): verdictFromWire(e.value?.toString()),
      };
    } catch (_) {
      return const {};
    }
  }
}
