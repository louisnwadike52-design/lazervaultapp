import 'package:equatable/equatable.dart';

/// Entity representing a chat response with entity round-tripping support.
/// Used by the direct chat path (Go Chat Proxy Gateway).
class ChatResponseEntity extends Equatable {
  final String response;
  final Map<String, dynamic> entities;
  final String? serviceRoutedTo;
  final String? conversationState;

  /// LLM degradation code from chat_services_shared/llm_failover.py.
  ///
  /// Carried so a per-service chat can render the same "AI is temporarily
  /// down, the rest of the app still works" banner the general chat renders.
  /// The same failure previously looked, in a per-service chat, like an
  /// ordinary answer: the fallback sentence with no chrome explaining it.
  final String? llmErrorCode;

  const ChatResponseEntity({
    required this.response,
    this.entities = const {},
    this.serviceRoutedTo,
    this.conversationState,
    this.llmErrorCode,
  });

  @override
  List<Object?> get props =>
      [response, entities, serviceRoutedTo, conversationState, llmErrorCode];
}
