import 'package:equatable/equatable.dart';
import 'package:lazervault/src/features/microservice_chat/domain/entities/general_chat_message_entity.dart';

/// Base state for general chat
abstract class GeneralChatState extends Equatable {
  final List<GeneralChatMessageEntity> messages;

  const GeneralChatState({this.messages = const []});

  @override
  List<Object?> get props => [messages];
}

/// Initial state
class GeneralChatInitial extends GeneralChatState {
  const GeneralChatInitial({super.messages});
}

/// Loading state
class GeneralChatLoading extends GeneralChatState {
  const GeneralChatLoading({super.messages});
}

/// Success state with additional metadata
class GeneralChatSuccess extends GeneralChatState {
  final String? currentService;
  final List<String> conversationServices;
  final Map<String, dynamic>? intentClassification;

  const GeneralChatSuccess({
    required super.messages,
    this.currentService,
    this.conversationServices = const [],
    this.intentClassification,
  });

  @override
  List<Object?> get props => [
    messages,
    currentService,
    conversationServices,
    intentClassification,
  ];
}

/// Error state
class GeneralChatError extends GeneralChatState {
  final String errorMessage;

  const GeneralChatError({
    required this.errorMessage,
    required super.messages,
  });

  @override
  List<Object?> get props => [errorMessage, messages];
}
