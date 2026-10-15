import 'dart:convert';

import 'package:grpc/grpc.dart';
import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/src/generated/direct_chat.pbgrpc.dart';
import 'package:lazervault/src/generated/direct_chat.pb.dart' as dc;
import 'package:lazervault/src/generated/google/protobuf/struct.pb.dart'
    as struct_pb;

import 'http_microservice_chat_datasource.dart';
import 'http_direct_chat_datasource.dart';

/// gRPC datasource for the Go Chat Proxy Gateway (port 50074).
/// Replaces HttpDirectChatDataSource, matching the platform pattern where
/// Flutter always calls Go gateways via gRPC with JWT metadata, gzip
/// compression, and keepalive.
class GrpcDirectChatDataSource implements MicroserviceChatDataSource {
  final DirectChatServiceClient _client;
  final GrpcCallOptionsHelper _callOptionsHelper;

  GrpcDirectChatDataSource({
    required DirectChatServiceClient client,
    required GrpcCallOptionsHelper callOptionsHelper,
  })  : _client = client,
        _callOptionsHelper = callOptionsHelper;

  /// Send a direct chat message with entity round-tripping via gRPC.
  Future<DirectChatResponse> processDirectChat(
      DirectChatRequest request) async {
    try {
      final response =
          await _callOptionsHelper.executeWithTokenRotation(() async {
        final callOptions = await _callOptionsHelper.withAuth();

        final grpcReq = dc.SendDirectMessageRequest(
          message: request.message,
          sessionId: request.sessionId,
          sourceContext: request.sourceContext,
          language: request.language,
          locale: request.locale,
          accountId: request.accountId,
          userCountry: request.userCountry,
          currency: request.currency,
          responseStyleInstruction: request.responseStyleInstruction,
        );

        // Convert entities map to protobuf Struct (safe conversion)
        if (request.entities.isNotEmpty) {
          final struct = _mapToStruct(request.entities);
          if (struct != null) {
            grpcReq.entities = struct;
          }
        }

        return await _client.sendDirectMessage(
          grpcReq,
          options: callOptions.mergedWith(
            CallOptions(timeout: const Duration(seconds: 70)),
          ),
        );
      });

      // Convert response Struct back to map (safe conversion)
      Map<String, dynamic> entities;
      try {
        entities = response.hasEntities()
            ? _structToMap(response.entities)
            : <String, dynamic>{};
      } catch (_) {
        entities = <String, dynamic>{};
      }

      return DirectChatResponse(
        response: response.response,
        serviceRoutedTo: response.serviceRoutedTo,
        sessionId: response.sessionId,
        entities: entities,
        conversationState: response.conversationState.isNotEmpty
            ? response.conversationState
            : 'IDLE',
      );
    } on GrpcError catch (e) {
      throw _mapGrpcException(e);
    }
  }

  /// Implements MicroserviceChatDataSource.processChat for backward compatibility.
  @override
  Future<ChatResponse> processChat(ChatRequest request) async {
    try {
      final directReq = DirectChatRequest(
        message: request.message,
        sessionId: request.sessionId,
        userId: request.userId,
        accessToken: request.accessToken,
        sourceContext: request.sourceContext,
        language: request.language,
        locale: request.locale,
      );

      final directResp = await processDirectChat(directReq);

      return ChatResponse(
        response: directResp.response,
        metadata: {'entities': directResp.entities},
      );
    } on GrpcError catch (e) {
      throw _mapGrpcException(e);
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
      final response =
          await _callOptionsHelper.executeWithTokenRotation(() async {
        final callOptions = await _callOptionsHelper.withAuth();

        // Cursor when we have one; otherwise the newest page. `offset` is
        // left unset alongside a cursor — the server ignores it, and sending
        // both invites a future build to apply them together, which would
        // skip a whole page past the cursor.
        final grpcReq = dc.GetDirectChatHistoryRequest(
          sessionId: sessionId,
          sourceContext: sourceContext,
          locale: locale ?? 'en-NG',
          limit: limit,
          before: before ?? '',
        );

        return await _client.getDirectChatHistory(
          grpcReq,
          options: callOptions.mergedWith(
            CallOptions(timeout: const Duration(seconds: 15)),
          ),
        );
      });

      final messages = response.messages.map((msg) {
        // Extract entities from history message (contains _receipt_data for receipts)
        Map<String, dynamic>? msgEntities;
        if (msg.hasEntities()) {
          try {
            msgEntities = _structToMap(msg.entities);
          } catch (_) {
            msgEntities = null;
          }
        }
        return ChatHistoryMessage(
          // The proto dropped the row id until it gained `message_id`, which
          // is why a per-service message restored from history could not be
          // rated: the id is the handle the feedback call rates by.
          messageId: msg.messageId.toInt(),
          role: msg.role,
          content: msg.content,
          service: msg.service,
          sourceContext: msg.sourceContext,
          timestamp: msg.createdAt,
          entities: msgEntities,
        );
      }).toList();

      return ChatHistoryResponse(
        history: messages,
        totalCount: response.total,
        sessionId:
            response.sessionId.isNotEmpty ? response.sessionId : sessionId,
        nextBefore: response.nextBefore,
        hasMore: response.hasMore,
      );
    } on GrpcError catch (e) {
      throw _mapGrpcException(e);
    }
  }

  @override
  Future<void> sendTypingIndicator(String sessionId, bool isTyping) async {
    // No-op for direct chat
  }

  /// Convert a Dart Map to protobuf Struct using JSON serialization.
  /// Returns null if conversion fails instead of throwing.
  struct_pb.Struct? _mapToStruct(Map<String, dynamic> map) {
    try {
      final jsonStr = jsonEncode(map);
      return struct_pb.Struct()..mergeFromProto3Json(jsonDecode(jsonStr));
    } catch (e) {
      // Entity map may contain non-JSON-serializable values; skip gracefully
      return null;
    }
  }

  /// Convert a protobuf Struct to a Dart Map using JSON serialization.
  /// Returns empty map if conversion fails.
  Map<String, dynamic> _structToMap(struct_pb.Struct struct) {
    try {
      final jsonObj = struct.toProto3Json();
      if (jsonObj is Map<String, dynamic>) {
        return jsonObj;
      }
      // Handle case where toProto3Json returns Map<String, Object?>
      if (jsonObj is Map) {
        return Map<String, dynamic>.from(jsonObj);
      }
      return <String, dynamic>{};
    } catch (_) {
      return <String, dynamic>{};
    }
  }

  /// Map gRPC errors to descriptive exceptions with appropriate context.
  Exception _mapGrpcException(GrpcError e) {
    switch (e.code) {
      case StatusCode.unavailable:
        return Exception(
            'Chat service temporarily unavailable. Please try again.');
      case StatusCode.deadlineExceeded:
        return Exception(
            'Chat service took too long to respond. Please try again.');
      case StatusCode.unauthenticated:
        return Exception('Session expired. Please log in again.');
      case StatusCode.resourceExhausted:
        return Exception('Too many requests. Please wait a moment.');
      case StatusCode.cancelled:
        return Exception('Request was cancelled.');
      case StatusCode.invalidArgument:
        return Exception(e.message ?? 'Invalid request.');
      default:
        return Exception(
            'Chat error (${e.code}): ${e.message ?? 'Unknown error'}');
    }
  }
}
