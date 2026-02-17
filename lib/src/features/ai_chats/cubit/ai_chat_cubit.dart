import 'package:bloc/bloc.dart';
import 'package:lazervault/core/services/chat_session_manager.dart';
import '../domain/usecases/process_ai_chat_usecase.dart';
import '../domain/usecases/get_ai_chat_history_usecase.dart';
import './ai_chat_state.dart';
import '../domain/entities/ai_chat_message_entity.dart';

class AIChatCubit extends Cubit<AIChatState> {
  final ProcessChatUseCase _processChatUseCase;
  final GetAIChatHistoryUseCase _getAIChatHistoryUseCase;
  final ChatSessionManager? _chatSessionManager;

  // Internal state to hold the current messages
  List<ChatMessageEntity> _currentMessages = [];

  // Track session ID for conversation continuity — deterministic for persistence
  String? _sessionId;

  AIChatCubit({
    required ProcessChatUseCase processChatUseCase,
    required GetAIChatHistoryUseCase getAIChatHistoryUseCase,
    ChatSessionManager? chatSessionManager,
  })  : _processChatUseCase = processChatUseCase,
        _getAIChatHistoryUseCase = getAIChatHistoryUseCase,
        _chatSessionManager = chatSessionManager,
        super(const AIChatInitial()); // Start with initial state

  // Load initial message and suggestions
  void initializeChat() {
     if (state is! AIChatInitial) {
       if (isClosed) return;
       emit(const AIChatInitial());
     }
  }

  // Load chat history using deterministic session ID
  Future<void> loadChatHistory({required String accessToken}) async {
    if (isClosed) return;

    // Use deterministic session ID so history persists across app restarts
    if (_sessionId == null && _chatSessionManager != null) {
      _sessionId = await _chatSessionManager!.getGeneralSessionId();
    }

    emit(AIChatHistoryLoading(messages: _currentMessages));
    final result = await _getAIChatHistoryUseCase(
      accessToken: accessToken,
      sessionId: _sessionId,
      sourceContext: 'general',
    );

    if (isClosed) return;
    result.fold(
      (failure) {
        emit(AIChatHistoryError(failure.message, messages: _currentMessages));
      },
      (history) {
        _currentMessages = history;
        emit(AIChatHistorySuccess(messages: _currentMessages));
      },
    );
  }

  // Send message to the backend
  Future<void> sendMessage(String text, {required String accessToken}) async {
    if (text.trim().isEmpty) return;

    // Mask PIN-like input (4-6 digits) in the displayed message for security
    final displayText = RegExp(r'^\d{4,6}$').hasMatch(text.trim()) ? 'Sensitive data ****' : text;

    // Add user message to the internal list immediately for responsiveness
    final userMessageEntity = ChatMessageEntity(
      text: displayText,
      isUser: true,
      timestamp: DateTime.now(),
    );
    _currentMessages.add(userMessageEntity);

    // Emit loading state with updated messages list and isTyping=true
    if (isClosed) return;
    emit(AIChatMessageLoading(messages: List.from(_currentMessages)));

    // Ensure we have a deterministic session ID
    if (_sessionId == null && _chatSessionManager != null) {
      _sessionId = await _chatSessionManager!.getGeneralSessionId();
    }

    final result = await _processChatUseCase(
      query: text,
      accessToken: accessToken,
      sessionId: _sessionId,
      sourceContext: 'general',
      language: 'en',
    );

    if (isClosed) return;
    result.fold(
      (failure) {
        // Emit error state, keeping existing messages, set isTyping=false
        emit(AIChatMessageError(errorMessage: failure.message, messages: List.from(_currentMessages)));
      },
      (response) {
        if (response.success) {
          // Parse action buttons from proto response
          List<ActionButtonEntity>? actionButtons;
          if (response.actionButtons.isNotEmpty) {
            actionButtons = response.actionButtons.map((btn) => ActionButtonEntity(
              label: btn.label,
              actionType: btn.actionType,
              payload: btn.payload,
              icon: btn.icon.isNotEmpty ? btn.icon : null,
            )).toList();
          }

          // Parse confirmation data from proto response
          ConfirmationDataEntity? confirmationData;
          if (response.hasConfirmationData()) {
            final cd = response.confirmationData;
            confirmationData = ConfirmationDataEntity(
              actionType: cd.actionType,
              amount: cd.amount,
              currency: cd.currency,
              recipientName: cd.recipientName,
              recipientId: cd.recipientId.isNotEmpty ? cd.recipientId : null,
              description: cd.description.isNotEmpty ? cd.description : null,
              extra: cd.extra.isNotEmpty ? Map<String, String>.from(cd.extra) : null,
            );
          }

          // Determine message type
          ChatMessageType messageType = ChatMessageType.text;
          if (response.requiresConfirmation) {
            messageType = ChatMessageType.confirmation;
          } else if (actionButtons != null && actionButtons.isNotEmpty) {
            messageType = ChatMessageType.actionCard;
          }

          // Track session ID for conversation continuity
          if (response.sessionId.isNotEmpty) {
            _sessionId = response.sessionId;
          }

          final aiMessageEntity = ChatMessageEntity(
            text: response.response,
            isUser: false,
            timestamp: DateTime.now(),
            type: messageType,
            intent: response.intent.isNotEmpty ? response.intent : null,
            entities: response.entities.isNotEmpty ? Map<String, String>.from(response.entities) : null,
            requiresConfirmation: response.requiresConfirmation,
            actionButtons: actionButtons,
            confirmationData: confirmationData,
            conversationState: response.conversationState.isNotEmpty ? response.conversationState : null,
            sessionId: response.sessionId.isNotEmpty ? response.sessionId : null,
          );
          _currentMessages.add(aiMessageEntity);
          emit(AIChatMessageSuccess(messages: List.from(_currentMessages)));
        } else {
          emit(AIChatMessageError(
              errorMessage: response.msg.isNotEmpty ? response.msg : "AI service returned an error.",
              messages: List.from(_currentMessages)));
        }
      },
    );
  }

  // Clear chat history (Only resets Cubit state)
  void clearChat() {
    _currentMessages = [];
    _sessionId = null;
    if (isClosed) return;
    emit(AIChatInitial(messages: _currentMessages, isTyping: false));
  }

  /// Notify cubit that settings changed. The actual values are persisted locally
  /// via SharedPreferences and read by the datasource on the next API call.
  void updateSettings({required String responseStyle, required bool emojiUsage}) {
    // No-op: settings are read from SharedPreferences by HttpAiChatDataSource.
    // This method exists so the UI can signal the cubit if needed in the future.
  }
} 