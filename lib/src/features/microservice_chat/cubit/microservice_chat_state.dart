import 'package:equatable/equatable.dart';
import '../domain/entities/microservice_chat_message_entity.dart';

abstract class MicroserviceChatState extends Equatable {
  final List<MicroserviceChatMessageEntity> messages;
  final bool isTyping;

  const MicroserviceChatState({
    this.messages = const [],
    this.isTyping = false,
  });

  @override
  List<Object?> get props => [messages, isTyping];
}

class MicroserviceChatInitial extends MicroserviceChatState {
  const MicroserviceChatInitial({super.messages, super.isTyping = false});
}

class MicroserviceChatHistoryLoading extends MicroserviceChatState {
  const MicroserviceChatHistoryLoading({super.messages, super.isTyping = false});
}

class MicroserviceChatMessageLoading extends MicroserviceChatState {
  const MicroserviceChatMessageLoading({super.messages, super.isTyping = true});
}

class MicroserviceChatMessageSuccess extends MicroserviceChatState {
  const MicroserviceChatMessageSuccess({super.messages, super.isTyping = false});
}

class MicroserviceChatMessageError extends MicroserviceChatState {
  final String errorMessage;

  const MicroserviceChatMessageError({
    required this.errorMessage,
    super.messages,
    super.isTyping = false,
  });

  @override
  List<Object?> get props => [errorMessage, messages, isTyping];
}
