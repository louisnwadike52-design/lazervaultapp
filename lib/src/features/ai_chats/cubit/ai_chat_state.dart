import 'package:equatable/equatable.dart';
import 'dart:io';
import '../domain/entities/ai_chat_message_entity.dart'; // Import domain entity

// Base class using ChatMessage defined in the view for simplicity
// Ideally, ChatMessage might live in a domain/model layer
// import '../presentation/view/ai_chats_screen.dart' show ChatMessage;


abstract class AIChatState extends Equatable {
  // Keep suggestions accessible in all states
  final List<String> suggestions;
  // Add fields for messages and typing status
  final List<ChatMessageEntity> messages;
  final bool isTyping;

  const AIChatState({
    this.suggestions = const [
      "How do I send money internationally?",
      "What are the best investment options?",
      "Explain cryptocurrency trading",
      "How to manage my spending?",
      "Set up recurring payments",
    ],
    // Default to empty list and not typing
    this.messages = const [],
    this.isTyping = false,
  });

  @override
  // Include new fields in props for Equatable comparison
  List<Object?> get props => [suggestions, messages, isTyping];

  // Optional: Helper method to create a copy with updated values
  AIChatState copyWith({
    List<String>? suggestions,
    List<ChatMessageEntity>? messages,
    bool? isTyping,
  });
}

// Initial state
class AIChatInitial extends AIChatState {
  const AIChatInitial({
    super.suggestions,
    super.messages,
    super.isTyping,
  });

  @override
  AIChatInitial copyWith({
    List<String>? suggestions,
    List<ChatMessageEntity>? messages,
    bool? isTyping,
  }) {
    return AIChatInitial(
      suggestions: suggestions ?? this.suggestions,
      messages: messages ?? this.messages,
      isTyping: isTyping ?? this.isTyping,
    );
  }
}

// --- History States ---
class AIChatHistoryLoading extends AIChatState {
  const AIChatHistoryLoading({
    super.suggestions,
    super.messages, 
    bool isTyping = true // History loading implies typing/loading state
  }) : super(isTyping: isTyping);

  @override
  AIChatHistoryLoading copyWith({
    List<String>? suggestions,
    List<ChatMessageEntity>? messages,
    bool? isTyping,
  }) {
    return AIChatHistoryLoading(
      suggestions: suggestions ?? this.suggestions,
      messages: messages ?? this.messages,
      isTyping: isTyping ?? this.isTyping,
    );
  }
}

class AIChatHistorySuccess extends AIChatState {
  // History is now part of the base 'messages' field
  // final List<ChatMessageEntity> history;
  const AIChatHistorySuccess({
    required List<ChatMessageEntity> messages, // Require messages here
    super.suggestions,
    bool isTyping = false // History loaded, not typing
  }) : super(messages: messages, isTyping: isTyping);

  @override
  List<Object?> get props => [suggestions, messages, isTyping];

  @override
  AIChatHistorySuccess copyWith({
    List<String>? suggestions,
    List<ChatMessageEntity>? messages,
    bool? isTyping,
  }) {
    return AIChatHistorySuccess(
      suggestions: suggestions ?? this.suggestions,
      messages: messages ?? this.messages,
      isTyping: isTyping ?? this.isTyping,
    );
  }
}

class AIChatHistoryError extends AIChatState {
  final String message;
  const AIChatHistoryError(
    this.message, {
    super.suggestions,
    super.messages, // Keep previous messages on error if needed
    bool isTyping = false, // Error occurred, not typing
  }) : super(isTyping: isTyping);

  @override
  List<Object?> get props => [suggestions, messages, isTyping, message];

  @override
  AIChatHistoryError copyWith({
    String? message,
    List<String>? suggestions,
    List<ChatMessageEntity>? messages,
    bool? isTyping,
  }) {
    return AIChatHistoryError(
      message ?? this.message,
      suggestions: suggestions ?? this.suggestions,
      messages: messages ?? this.messages,
      isTyping: isTyping ?? this.isTyping,
    );
  }
}

// --- New Message States ---
// Renamed AIChatLoading to AIChatMessageLoading
class AIChatMessageLoading extends AIChatState {
   // Keep track of messages known to the cubit IF needed for context, but UI manages the list
   // final List<ChatMessageEntity> messages; 
  const AIChatMessageLoading({
    required List<ChatMessageEntity> messages, // Require current messages
    super.suggestions,
    bool isTyping = true // Message is being processed, so typing
  }) : super(messages: messages, isTyping: isTyping);

  @override
  AIChatMessageLoading copyWith({
    List<String>? suggestions,
    List<ChatMessageEntity>? messages,
    bool? isTyping,
  }) {
    return AIChatMessageLoading(
      suggestions: suggestions ?? this.suggestions,
      messages: messages ?? this.messages,
      isTyping: isTyping ?? this.isTyping,
    );
  }
}

// Renamed AIChatSuccess to AIChatMessageSuccess
class AIChatMessageSuccess extends AIChatState {
  // The new message is implicitly the last one in the 'messages' list
  // final ChatMessageEntity newAiMessage; 
  const AIChatMessageSuccess({
    required List<ChatMessageEntity> messages, // Require updated messages list
    super.suggestions,
    bool isTyping = false // Message received, not typing
  }) : super(messages: messages, isTyping: isTyping);

  @override
  List<Object?> get props => [suggestions, messages, isTyping];

   @override
  AIChatMessageSuccess copyWith({
    List<String>? suggestions,
    List<ChatMessageEntity>? messages,
    bool? isTyping,
  }) {
    return AIChatMessageSuccess(
      suggestions: suggestions ?? this.suggestions,
      messages: messages ?? this.messages,
      isTyping: isTyping ?? this.isTyping,
    );
  }
}

// Renamed AIChatError to AIChatMessageError
class AIChatMessageError extends AIChatState {
  final String errorMessage;
  // Keep track of messages known to the cubit IF needed
  // final List<ChatMessageEntity> messages;
  const AIChatMessageError({
    required this.errorMessage,
    required List<ChatMessageEntity> messages, // Require messages list at time of error
    super.suggestions,
    bool isTyping = false, // Error occurred, not typing
  }) : super(messages: messages, isTyping: isTyping);

  @override
  List<Object?> get props => [suggestions, messages, isTyping, errorMessage];

  @override
  AIChatMessageError copyWith({
    String? errorMessage,
    List<String>? suggestions,
    List<ChatMessageEntity>? messages,
    bool? isTyping,
  }) {
    return AIChatMessageError(
      errorMessage: errorMessage ?? this.errorMessage,
      suggestions: suggestions ?? this.suggestions,
      messages: messages ?? this.messages,
      isTyping: isTyping ?? this.isTyping,
    );
  }
}

// --- Deprecated States (to be removed or refactored if logic depends on them) ---
// class AIChatLoading extends AIChatState { ... } 
// class AIChatSuccess extends AIChatState { ... }
// class AIChatError extends AIChatState { ... } 