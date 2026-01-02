import 'package:bloc/bloc.dart';
import 'dart:io';
import '../domain/usecases/process_ai_chat_usecase.dart';
import '../domain/usecases/get_ai_chat_history_usecase.dart';
import './ai_chat_state.dart';
// Import domain entity
import '../domain/entities/ai_chat_message_entity.dart';
// Import gRPC generated types (adjust path if needed)
import 'package:lazervault/src/generated/ai_chat.pb.dart';

class AIChatCubit extends Cubit<AIChatState> {
  final ProcessChatUseCase _processChatUseCase;
  final GetAIChatHistoryUseCase _getAIChatHistoryUseCase;

  // Internal state to hold the current messages
  List<ChatMessageEntity> _currentMessages = [];

  AIChatCubit({
    required ProcessChatUseCase processChatUseCase,
    required GetAIChatHistoryUseCase getAIChatHistoryUseCase,
  })  : _processChatUseCase = processChatUseCase,
        _getAIChatHistoryUseCase = getAIChatHistoryUseCase,
        super(const AIChatInitial()); // Start with initial state

  // Load initial message and suggestions - Renamed for clarity
  void initializeChat() {
     // This method is now mainly for ensuring the cubit starts in an initial state.
     // The UI adds the first message or loads history.
     if (state is! AIChatInitial) {
       if (isClosed) return;
       emit(const AIChatInitial());
     }
  }

  // Load chat history
  Future<void> loadChatHistory({required String accessToken}) async {
    // Emit loading state with current messages (if any) and isTyping=true
    if (isClosed) return;
    emit(AIChatHistoryLoading(messages: _currentMessages));
    final result = await _getAIChatHistoryUseCase(accessToken: accessToken);

    if (isClosed) return;
    result.fold(
      (failure) {
        // Emit error state, keeping existing messages, set isTyping=false
        emit(AIChatHistoryError(failure.message, messages: _currentMessages));
      },
      (history) {
        // Update internal messages and emit success state
        _currentMessages = history;
        emit(AIChatHistorySuccess(messages: _currentMessages));
      },
    );
  }

  // Send message to the backend
  Future<void> sendMessage(String text, {required String accessToken, File? image}) async {
    if (text.trim().isEmpty && image == null) return;

    // Add user message to the internal list immediately for responsiveness
    final userMessageEntity = ChatMessageEntity(
      text: text,
      isUser: true,
      timestamp: DateTime.now(),
      // image: image // TODO: Handle image bytes in entity/usecase/grpc
    );
    _currentMessages.add(userMessageEntity);

    // Emit loading state with updated messages list and isTyping=true
    if (isClosed) return;
    emit(AIChatMessageLoading(messages: List.from(_currentMessages)));

    // TODO: Pass image bytes to use case if needed
    final result = await _processChatUseCase(query: text, accessToken: accessToken);

    if (isClosed) return;
    result.fold(
      (failure) {
        // Emit error state, keeping existing messages, set isTyping=false
        emit(AIChatMessageError(errorMessage: failure.message, messages: List.from(_currentMessages)));
      },
      (response) {
        if (response.success) {
          final aiMessageEntity = ChatMessageEntity(
            text: response.response,
            isUser: false,
            timestamp: DateTime.now(),
            // image: null // Assuming no image in response
          );
          // Add AI response to internal list
          _currentMessages.add(aiMessageEntity);
          // Emit success state with the full updated list, isTyping=false
          emit(AIChatMessageSuccess(messages: List.from(_currentMessages)));
        } else {
          // Emit error state, keeping existing messages, set isTyping=false
          emit(AIChatMessageError(
              errorMessage: response.msg.isNotEmpty ? response.msg : "AI service returned an error.",
              messages: List.from(_currentMessages)));
        }
      },
    );
  }

  // Clear chat history (Only resets Cubit state)
  void clearChat() {
    _currentMessages = []; // Clear internal list
    if (isClosed) return;
    emit(AIChatInitial(messages: _currentMessages, isTyping: false)); // Emit initial state with empty messages
  }
} 