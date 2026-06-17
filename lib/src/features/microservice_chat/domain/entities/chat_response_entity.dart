import 'package:equatable/equatable.dart';

/// Entity representing a chat response with entity round-tripping support.
/// Used by the direct chat path (Go Chat Proxy Gateway).
class ChatResponseEntity extends Equatable {
  final String response;
  final Map<String, dynamic> entities;
  final String? serviceRoutedTo;
  final String? conversationState;

  const ChatResponseEntity({
    required this.response,
    this.entities = const {},
    this.serviceRoutedTo,
    this.conversationState,
  });

  @override
  List<Object?> get props => [response, entities, serviceRoutedTo, conversationState];
}
