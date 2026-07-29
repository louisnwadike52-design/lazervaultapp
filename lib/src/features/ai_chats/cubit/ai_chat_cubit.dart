import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:lazervault/core/services/app_activity_bus.dart';
import 'package:lazervault/core/services/chat_language_preference.dart';
import 'package:lazervault/core/services/chat_session_manager.dart';
import '../domain/usecases/process_ai_chat_usecase.dart';
import '../domain/usecases/get_ai_chat_history_usecase.dart';
import './ai_chat_state.dart';
import '../domain/entities/ai_chat_message_entity.dart';

class AIChatCubit extends Cubit<AIChatState> {
  final ProcessChatUseCase _processChatUseCase;
  final GetAIChatHistoryUseCase _getAIChatHistoryUseCase;
  final ChatSessionManager? _chatSessionManager;

  /// Decode the `_receipt_card` passthrough (JSON-encoded single dict OR a list
  /// for a batch transfer) from the proto entities map, removing the key so it
  /// doesn't leak into the displayed entities. Returns a Map, a List, or null.
  dynamic _decodeReceiptCard(Map<String, String>? entitiesMap) {
    if (entitiesMap == null || !entitiesMap.containsKey('_receipt_card')) {
      return null;
    }
    dynamic decoded;
    try {
      decoded = jsonDecode(entitiesMap['_receipt_card']!);
    } catch (_) {
      decoded = null;
    }
    entitiesMap.remove('_receipt_card');
    return (decoded is Map || decoded is List) ? decoded : null;
  }

  // Internal state to hold the current messages
  List<ChatMessageEntity> _currentMessages = [];

  // Track session ID for conversation continuity — deterministic for persistence
  String? _sessionId;

  /// User-selected chatbot response language code (en/yo/ig/ha/pcm/fr/es).
  /// Loaded lazily from [ChatLanguagePreference]; defaults to 'en'.
  String _language = ChatLanguagePreference.defaultLanguage;

  /// The currently-selected chatbot language code.
  String get language => _language;

  /// Number of messages fetched per history page (initial load + each scroll-up
  /// "load older"). The gateway returns the newest page at offset 0 and pages
  /// backwards from there.
  static const int historyPageSize = 30;

  /// Whether an older page of history MIGHT still exist (a full page came back
  /// last time). Drives the scroll-up "load older" trigger.
  bool _hasMoreHistory = true;
  bool get hasMoreHistory => _hasMoreHistory;

  /// Re-entrancy guard so a burst of scroll events fires at most one
  /// "load older" fetch at a time.
  bool _isLoadingOlder = false;
  bool get isLoadingOlder => _isLoadingOlder;

  /// True while a [sendMessage] round-trip is in flight. The user bubble is
  /// appended optimistically BEFORE Postgres persists it, so the newest-end
  /// count is momentarily ahead of the server — a "load older" fired in this
  /// window would compute a drifted offset and skip/duplicate a boundary
  /// message. Load-older is suppressed until the send completes.
  bool _isSending = false;

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
     // Load the persisted chatbot language so every request carries it.
     ChatLanguagePreference.getLanguage().then((lang) {
       _language = lang;
     });
     if (state is! AIChatInitial) {
       if (isClosed) return;
       emit(const AIChatInitial());
     }
  }

  /// Persist and apply the user-selected chatbot response language.
  /// The next message sent will instruct the backend to reply in this language.
  Future<void> setLanguage(String code) async {
    await ChatLanguagePreference.setLanguage(code);
    _language = await ChatLanguagePreference.getLanguage();
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
      limit: historyPageSize,
      offset: 0,
    );

    if (isClosed) return;
    result.fold(
      (failure) {
        emit(AIChatHistoryError(failure.message, messages: _currentMessages));
      },
      (history) {
        _currentMessages = history;
        // A full page implies older messages may still exist behind it, so the
        // scroll-up "load older" trigger stays armed.
        _hasMoreHistory = history.length >= historyPageSize;
        // Fresh session/history: drop any in-flight load-older guard so a late
        // older-page from a PREVIOUS session can't prepend onto this one (the
        // stale fetch is also dropped by the session-id check in
        // loadOlderHistory).
        _isLoadingOlder = false;
        emit(AIChatHistorySuccess(messages: _currentMessages));
      },
    );
  }

  /// Fetch the next OLDER page of history and PREPEND it (scroll-up reverse
  /// pagination). The offset is the count of newest messages already loaded, so
  /// live turns appended to the newest end are naturally accounted for and the
  /// next page never overlaps or skips. Prior history is preserved — older
  /// messages are prepended, never replacing what's already on screen.
  Future<void> loadOlderHistory({required String accessToken}) async {
    // Never paginate mid-send: the optimistic user bubble makes the newest-end
    // count run ahead of the server, so the computed offset would drift.
    if (isClosed || _isSending || _isLoadingOlder || !_hasMoreHistory) return;
    _isLoadingOlder = true;

    if (_sessionId == null && _chatSessionManager != null) {
      _sessionId = await _chatSessionManager!.getGeneralSessionId();
    }

    // Capture the session this fetch belongs to. If the user switches sessions
    // (loadChatHistory / clearChat) while the older page is in flight, the
    // result is stale and must NOT prepend onto the now-active session.
    final sessionAtStart = _sessionId;
    final offset = _currentMessages.length;
    final result = await _getAIChatHistoryUseCase(
      accessToken: accessToken,
      sessionId: _sessionId,
      sourceContext: 'general',
      limit: historyPageSize,
      offset: offset,
    );

    if (isClosed) {
      _isLoadingOlder = false;
      return;
    }
    // Session changed during the await — drop this page entirely.
    if (_sessionId != sessionAtStart) {
      _isLoadingOlder = false;
      return;
    }
    result.fold(
      (failure) {
        // Leave loaded history intact; the user can retry by scrolling up again.
        _isLoadingOlder = false;
      },
      (older) {
        if (older.isNotEmpty) {
          _currentMessages = [...older, ..._currentMessages];
        }
        _hasMoreHistory = older.length >= historyPageSize;
        _isLoadingOlder = false;
        emit(AIChatHistorySuccess(messages: List.from(_currentMessages)));
      },
    );
  }

  // Send message to the backend
  Future<void> sendMessage(String text, {required String accessToken}) async {
    if (text.trim().isEmpty) return;
    // Mark a send in flight so load-older pagination doesn't run against the
    // optimistically-appended (not-yet-persisted) user bubble. Cleared on both
    // the success and error paths below.
    _isSending = true;
    // Chatting is engagement — keep the inactivity auto-logout from firing
    // mid-conversation (the reply lands within the next window).
    AppActivityBus.instance.ping();

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
    if (isClosed) {
      _isSending = false;
      return;
    }
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
      language: _language,
    );

    if (isClosed) {
      _isSending = false;
      return;
    }
    result.fold(
      (failure) {
        _isSending = false;
        // Emit error state, keeping existing messages, set isTyping=false
        emit(AIChatMessageError(errorMessage: failure.message, messages: List.from(_currentMessages)));
      },
      (response) {
        _isSending = false;
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

          // Extract receipt_data from entities (passed as JSON string via _receipt_data key)
          Map<String, dynamic>? receiptData;
          final entitiesMap = response.entities.isNotEmpty
              ? Map<String, String>.from(response.entities)
              : null;
          if (entitiesMap != null && entitiesMap.containsKey('_receipt_data')) {
            try {
              receiptData = jsonDecode(entitiesMap['_receipt_data']!) as Map<String, dynamic>;
            } catch (_) {
              // Ignore malformed receipt data
            }
            entitiesMap.remove('_receipt_data');
          }

          // Extract pin_prompt the same way (drives the inline ChatPinPromptCard
          // so a chat-driven money move collects the PIN in the thread).
          Map<String, dynamic>? pinPrompt;
          if (entitiesMap != null && entitiesMap.containsKey('_pin_prompt')) {
            try {
              pinPrompt = jsonDecode(entitiesMap['_pin_prompt']!) as Map<String, dynamic>;
            } catch (_) {
              // Ignore malformed pin prompt
            }
            entitiesMap.remove('_pin_prompt');
          }

          // Extract receipt_card (single dict or list for a batch) — drives the
          // ChatReceiptCardV2 / ChatReceiptCardV2List so batch receipts render.
          final dynamic receiptCard = _decodeReceiptCard(entitiesMap);

          final aiMessageEntity = ChatMessageEntity(
            text: response.response,
            isUser: false,
            timestamp: DateTime.now(),
            type: messageType,
            intent: response.intent.isNotEmpty ? response.intent : null,
            entities: entitiesMap != null && entitiesMap.isNotEmpty ? entitiesMap : null,
            requiresConfirmation: response.requiresConfirmation,
            actionButtons: actionButtons,
            confirmationData: confirmationData,
            conversationState: response.conversationState.isNotEmpty ? response.conversationState : null,
            sessionId: response.sessionId.isNotEmpty ? response.sessionId : null,
            receiptData: receiptData,
            receiptCard: receiptCard,
            pinPrompt: pinPrompt,
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

  /// Continue a chat-driven money move after the user enters their PIN in the
  /// inline ChatPinPromptCard. The native modal returns a single-use
  /// verification token (the PIN never enters chat/LLM context); we re-POST a
  /// sentinel turn carrying the token + the bound callback_intent in metadata.
  /// The gateway copies these into the downstream service entities, where the
  /// deterministic PIN-callback dispatch fires the confirm tool and the agent
  /// replies with the result (usually a ReceiptCard). No user bubble is added —
  /// the user already acted in the modal.
  Future<void> submitPinVerification({
    required String verificationToken,
    required String callbackIntent,
    Map<String, dynamic> callbackArgs = const {},
  }) async {
    if (verificationToken.isEmpty) return;
    if (isClosed) return;
    emit(AIChatMessageLoading(messages: List.from(_currentMessages)));

    if (_sessionId == null && _chatSessionManager != null) {
      _sessionId = await _chatSessionManager!.getGeneralSessionId();
    }

    final result = await _processChatUseCase(
      query: '__pin_verified__', // sentinel the agent's prompt recognises
      accessToken: '', // HTTP datasource resolves the real token from storage
      sessionId: _sessionId,
      sourceContext: 'general',
      language: _language,
      extraMetadata: {
        'pin_verification_token': verificationToken,
        'callback_intent': callbackIntent,
        'callback_args': callbackArgs,
        'execute': true,
      },
    );

    if (isClosed) return;
    result.fold(
      (failure) {
        emit(AIChatMessageError(errorMessage: failure.message, messages: List.from(_currentMessages)));
      },
      (response) {
        if (!response.success) {
          emit(AIChatMessageError(
              errorMessage: response.msg.isNotEmpty ? response.msg : 'Could not complete that.',
              messages: List.from(_currentMessages)));
          return;
        }
        final entitiesMap = response.entities.isNotEmpty
            ? Map<String, String>.from(response.entities)
            : null;
        Map<String, dynamic>? receiptData;
        if (entitiesMap != null && entitiesMap.containsKey('_receipt_data')) {
          try {
            receiptData = jsonDecode(entitiesMap['_receipt_data']!) as Map<String, dynamic>;
          } catch (_) {}
          entitiesMap.remove('_receipt_data');
        }
        Map<String, dynamic>? pinPrompt;
        if (entitiesMap != null && entitiesMap.containsKey('_pin_prompt')) {
          try {
            pinPrompt = jsonDecode(entitiesMap['_pin_prompt']!) as Map<String, dynamic>;
          } catch (_) {}
          entitiesMap.remove('_pin_prompt');
        }
        final dynamic receiptCard = _decodeReceiptCard(entitiesMap);
        _currentMessages.add(ChatMessageEntity(
          text: response.response,
          isUser: false,
          timestamp: DateTime.now(),
          intent: response.intent.isNotEmpty ? response.intent : null,
          entities: entitiesMap != null && entitiesMap.isNotEmpty ? entitiesMap : null,
          conversationState: response.conversationState.isNotEmpty ? response.conversationState : null,
          sessionId: response.sessionId.isNotEmpty ? response.sessionId : null,
          receiptData: receiptData,
          receiptCard: receiptCard,
          pinPrompt: pinPrompt,
        ));
        emit(AIChatMessageSuccess(messages: List.from(_currentMessages)));
      },
    );
  }

  /// Maximum media file size (10MB for images, 25MB for audio).
  static const int _maxImageSize = 10 * 1024 * 1024;
  static const int _maxAudioSize = 25 * 1024 * 1024;

  /// Send a media message (image or voice note) through the Chat Agent Gateway.
  Future<void> sendMediaMessage({
    required String mediaType,
    required String localFilePath,
    required String mimeType,
    required String accessToken,
    String text = '',
    int? audioDurationMs,
  }) async {
    // Validate file exists and check size
    final file = File(localFilePath);
    if (!file.existsSync()) {
      if (isClosed) return;
      emit(AIChatMessageError(
        errorMessage: 'The media file could not be found. Please try again.',
        messages: List.from(_currentMessages),
      ));
      return;
    }

    final fileSize = file.lengthSync();
    final maxSize = mediaType == 'image' ? _maxImageSize : _maxAudioSize;
    if (fileSize > maxSize) {
      final maxMB = maxSize ~/ (1024 * 1024);
      if (isClosed) return;
      emit(AIChatMessageError(
        errorMessage: 'File is too large (max ${maxMB}MB). Please choose a smaller file.',
        messages: List.from(_currentMessages),
      ));
      return;
    }
    if (fileSize == 0) {
      if (isClosed) return;
      emit(AIChatMessageError(
        errorMessage: 'The file appears to be empty. Please try again.',
        messages: List.from(_currentMessages),
      ));
      return;
    }

    // Read file and base64-encode
    final bytes = await file.readAsBytes();
    if (isClosed) return;
    final base64Data = base64Encode(bytes);

    // Add user message with media preview immediately
    final displayText = text.isNotEmpty
        ? text
        : (mediaType == 'image' ? 'Sent an image' : 'Sent a voice note');
    final userMessage = ChatMessageEntity(
      text: displayText,
      isUser: true,
      timestamp: DateTime.now(),
      mediaType: mediaType,
      localMediaPath: localFilePath,
      audioDurationMs: audioDurationMs,
    );
    _currentMessages.add(userMessage);
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
      language: _language,
      mediaBase64: base64Data,
      mediaType: mediaType,
      mediaMimeType: mimeType,
      mediaDurationMs: audioDurationMs,
    );

    if (isClosed) return;
    result.fold(
      (failure) {
        emit(AIChatMessageError(
          errorMessage: failure.message,
          messages: List.from(_currentMessages),
        ));
      },
      (response) {
        if (response.success) {
          if (response.sessionId.isNotEmpty) {
            _sessionId = response.sessionId;
          }

          // Extract receipt_data for media responses too
          Map<String, dynamic>? mediaReceiptData;
          if (response.entities.containsKey('_receipt_data')) {
            try {
              mediaReceiptData = jsonDecode(response.entities['_receipt_data']!) as Map<String, dynamic>;
            } catch (_) {}
          }
          final dynamic mediaReceiptCard =
              _decodeReceiptCard(Map<String, String>.from(response.entities));

          final aiMessage = ChatMessageEntity(
            text: response.response,
            isUser: false,
            timestamp: DateTime.now(),
            sessionId: response.sessionId.isNotEmpty ? response.sessionId : null,
            receiptData: mediaReceiptData,
            receiptCard: mediaReceiptCard,
          );
          _currentMessages.add(aiMessage);
          emit(AIChatMessageSuccess(messages: List.from(_currentMessages)));
        } else {
          emit(AIChatMessageError(
            errorMessage: response.msg.isNotEmpty ? response.msg : 'AI service returned an error.',
            messages: List.from(_currentMessages),
          ));
        }
      },
    );
  }

  /// Clear chat history — deletes it SERVER-SIDE first (Redis hot copy +
  /// Postgres soft-delete of the `general_{userId}` session), THEN resets local
  /// state so the cleared history can't reappear on the next load/pagination.
  /// Returns true on success. On failure the local messages are KEPT (never a
  /// silent local-only clear that reappears on reload) so the UI can surface an
  /// inline retry.
  Future<bool> clearChat() async {
    try {
      await _chatSessionManager?.clearGeneralHistory();
    } catch (_) {
      if (!isClosed) {
        emit(AIChatHistoryError(
          'Could not clear chat. Please try again.',
          messages: _currentMessages,
        ));
      }
      return false;
    }
    _currentMessages = [];
    _sessionId = null;
    _hasMoreHistory = true;
    _isLoadingOlder = false;
    if (isClosed) return true;
    emit(AIChatInitial(messages: _currentMessages, isTyping: false));
    return true;
  }

  /// Fetch the COMPLETE transcript (every page) for export WITHOUT mutating the
  /// visible conversation or emitting UI states. Pages backward from the newest
  /// window until a short page signals the end, then returns the messages in
  /// chronological (oldest→newest) order. Best-effort — a failed page ends the
  /// walk with whatever was collected so export never hard-fails.
  Future<List<ChatMessageEntity>> fetchAllForExport(
      {required String accessToken}) async {
    final sessionId = _sessionId ??
        (_chatSessionManager != null
            ? await _chatSessionManager!.getGeneralSessionId()
            : null);
    final all = <ChatMessageEntity>[];
    var offset = 0;
    // Safety cap (100 pages ≈ 3000 messages) so a misbehaving backend can never
    // spin this unbounded.
    for (var page = 0; page < 100; page++) {
      final res = await _getAIChatHistoryUseCase(
        accessToken: accessToken,
        sessionId: sessionId,
        sourceContext: 'general',
        limit: historyPageSize,
        offset: offset,
      );
      final batch = res.fold((_) => <ChatMessageEntity>[], (h) => h);
      if (batch.isEmpty) break;
      // Each page is a newest-first window; prepend older pages to build the
      // full chronological order.
      all.insertAll(0, batch);
      offset += batch.length;
      if (batch.length < historyPageSize) break;
    }
    return all;
  }

  /// Notify cubit that settings changed. The actual values are persisted locally
  /// via SharedPreferences and read by the datasource on the next API call.
  void updateSettings({required String responseStyle, required bool emojiUsage}) {
    // No-op: settings are read from SharedPreferences by HttpAiChatDataSource.
    // This method exists so the UI can signal the cubit if needed in the future.
  }
} 