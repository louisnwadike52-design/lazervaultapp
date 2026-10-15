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

  /// Decode the `_qr_card` passthrough. Same channel and same removal
  /// discipline as [_decodeReceiptCard] so the raw payload never leaks into
  /// the displayed entities.
  Map<String, dynamic>? _decodeQrCard(Map<String, String>? entitiesMap) {
    if (entitiesMap == null || !entitiesMap.containsKey('_qr_card')) {
      return null;
    }
    dynamic decoded;
    try {
      decoded = jsonDecode(entitiesMap['_qr_card']!);
    } catch (_) {
      decoded = null;
    }
    entitiesMap.remove('_qr_card');
    return decoded is Map ? Map<String, dynamic>.from(decoded) : null;
  }

  /// Decode the `_recipient_card` passthrough — same channel and the same
  /// removal discipline as [_decodeQrCard], so the raw payload never leaks
  /// into the displayed entities.
  Map<String, dynamic>? _decodeRecipientCard(Map<String, String>? entitiesMap) {
    if (entitiesMap == null || !entitiesMap.containsKey('_recipient_card')) {
      return null;
    }
    dynamic decoded;
    try {
      decoded = jsonDecode(entitiesMap['_recipient_card']!);
    } catch (_) {
      decoded = null;
    }
    entitiesMap.remove('_recipient_card');
    return decoded is Map ? Map<String, dynamic>.from(decoded) : null;
  }

  /// Pull the server's message id off the passthrough.
  ///
  /// Same channel and the same removal discipline as the cards, so the raw
  /// value never leaks into displayed entities.
  int? _decodeMessageId(Map<String, String>? entitiesMap) {
    if (entitiesMap == null) return null;
    final raw = entitiesMap.remove('_message_id');
    if (raw == null) return null;
    return int.tryParse(raw);
  }

  /// Decode the `_analytics_card` passthrough — the chart series behind a
  /// "how am I doing?" answer. Same channel and the same removal discipline as
  /// [_decodeQrCard], so the raw payload never leaks into displayed entities.
  Map<String, dynamic>? _decodeAnalyticsCard(Map<String, String>? entitiesMap) {
    if (entitiesMap == null || !entitiesMap.containsKey('_analytics_card')) {
      return null;
    }
    dynamic decoded;
    try {
      decoded = jsonDecode(entitiesMap['_analytics_card']!);
    } catch (_) {
      decoded = null;
    }
    entitiesMap.remove('_analytics_card');
    return decoded is Map ? Map<String, dynamic>.from(decoded) : null;
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

  /// Whether an older page of history still exists. The SERVER says so now —
  /// it fetches one row more than asked for and reports the answer — rather
  /// than being inferred from the page length, which could not tell "the
  /// conversation ends here" from "the server trimmed the page".
  bool _hasMoreHistory = true;
  bool get hasMoreHistory => _hasMoreHistory;

  /// Keyset cursor for the next OLDER page, or '' at the start of the thread.
  ///
  /// This replaced the offset. OFFSET pagination on a live conversation has a
  /// shifting window: a message arriving while the user is scrolled up moves
  /// every row one position, so the next page starts one row late and a
  /// message disappears from the middle of their history. The old code fought
  /// that by refusing to paginate during its own send ([_isSending] below),
  /// which did nothing about a message from another device or an assistant
  /// reply landing between two page reads. A cursor names a position in the
  /// conversation, so nothing arriving at the newest end can move it.
  String _nextBefore = '';

  /// Re-entrancy guard so a burst of scroll events fires at most one
  /// "load older" fetch at a time.
  bool _isLoadingOlder = false;
  bool get isLoadingOlder => _isLoadingOlder;

  /// True while a [sendMessage] round-trip is in flight.
  ///
  /// It no longer HAS to gate pagination — the cursor is immune to the
  /// optimistic user bubble that made the offset drift — but load-older stays
  /// suppressed during a send anyway: two concurrent prepend/append edits to
  /// the same list is a race worth not having, and the user is looking at the
  /// bottom of the thread in that moment regardless.
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
    final result = await _getAIChatHistoryUseCase.page(
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
      (page) {
        _currentMessages = page.messages;
        // The SERVER answers this now, from a probe row. Inferring it from
        // `length >= pageSize` was wrong at both edges: a conversation of
        // exactly one page kept the trigger armed forever, and a page the
        // gateway trimmed disarmed it with history still unread.
        _hasMoreHistory = page.canLoadOlder;
        _nextBefore = page.nextBefore;
        // Fresh session/history: drop any in-flight load-older guard so a late
        // older-page from a PREVIOUS session can't prepend onto this one (the
        // stale fetch is also dropped by the session-id check in
        // loadOlderHistory).
        _isLoadingOlder = false;
        emit(AIChatHistorySuccess(messages: _currentMessages));
      },
    );
  }

  /// Fetch the next OLDER page and PREPEND it (scroll-up reverse pagination).
  ///
  /// Driven by [_nextBefore], a cursor naming the oldest message on screen, so
  /// a page can never overlap or skip however many messages arrive at the
  /// newest end while the user is reading. Prior history is preserved — older
  /// messages are prepended, never replacing what is already on screen.
  Future<void> loadOlderHistory({required String accessToken}) async {
    if (isClosed || _isSending || _isLoadingOlder || !_hasMoreHistory) return;
    // No cursor means the first page has not landed yet, or the thread has
    // reached its start. Either way there is nothing to ask for, and asking
    // without one would re-fetch the NEWEST page and prepend a duplicate of
    // what is already on screen.
    if (_nextBefore.isEmpty) {
      _hasMoreHistory = false;
      return;
    }
    _isLoadingOlder = true;

    if (_sessionId == null && _chatSessionManager != null) {
      _sessionId = await _chatSessionManager!.getGeneralSessionId();
    }

    // Capture the session AND the cursor this fetch belongs to. If the user
    // switches sessions (loadChatHistory / clearChat) while the older page is
    // in flight, the result is stale and must NOT prepend onto the now-active
    // session.
    final sessionAtStart = _sessionId;
    final cursorAtStart = _nextBefore;
    final result = await _getAIChatHistoryUseCase.page(
      accessToken: accessToken,
      sessionId: _sessionId,
      sourceContext: 'general',
      limit: historyPageSize,
      before: cursorAtStart,
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
    // The cursor moved under us (a second load-older slipped past the guard,
    // or the history was reloaded). Prepending now would duplicate a page.
    if (_nextBefore != cursorAtStart) {
      _isLoadingOlder = false;
      return;
    }
    result.fold(
      (failure) {
        // Leave loaded history intact; the user can retry by scrolling up again.
        _isLoadingOlder = false;
      },
      (page) {
        if (page.messages.isNotEmpty) {
          _currentMessages = [...page.messages, ..._currentMessages];
        }
        _hasMoreHistory = page.canLoadOlder;
        _nextBefore = page.nextBefore;
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
    final displayText = RegExp(r'^\d{4,6}$').hasMatch(text.trim())
        ? 'Sensitive data ****'
        : text;

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
        emit(AIChatMessageError(
            errorMessage: failure.message,
            messages: List.from(_currentMessages)));
      },
      (response) {
        _isSending = false;
        if (response.success) {
          // Parse action buttons from proto response
          List<ActionButtonEntity>? actionButtons;
          if (response.actionButtons.isNotEmpty) {
            actionButtons = response.actionButtons
                .map((btn) => ActionButtonEntity(
                      label: btn.label,
                      actionType: btn.actionType,
                      payload: btn.payload,
                      icon: btn.icon.isNotEmpty ? btn.icon : null,
                    ))
                .toList();
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
              extra: cd.extra.isNotEmpty
                  ? Map<String, String>.from(cd.extra)
                  : null,
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
              receiptData = jsonDecode(entitiesMap['_receipt_data']!)
                  as Map<String, dynamic>;
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
              pinPrompt = jsonDecode(entitiesMap['_pin_prompt']!)
                  as Map<String, dynamic>;
            } catch (_) {
              // Ignore malformed pin prompt
            }
            entitiesMap.remove('_pin_prompt');
          }

          // Extract receipt_card (single dict or list for a batch) — drives the
          // ChatReceiptCardV2 / ChatReceiptCardV2List so batch receipts render.
          final dynamic receiptCard = _decodeReceiptCard(entitiesMap);
          final qrCard = _decodeQrCard(entitiesMap);
          final recipientCard = _decodeRecipientCard(entitiesMap);
          final analyticsCard = _decodeAnalyticsCard(entitiesMap);
          final serverMessageId = _decodeMessageId(entitiesMap);

          final aiMessageEntity = ChatMessageEntity(
            text: response.response,
            isUser: false,
            timestamp: DateTime.now(),
            type: messageType,
            intent: response.intent.isNotEmpty ? response.intent : null,
            entities: entitiesMap != null && entitiesMap.isNotEmpty
                ? entitiesMap
                : null,
            requiresConfirmation: response.requiresConfirmation,
            actionButtons: actionButtons,
            confirmationData: confirmationData,
            conversationState: response.conversationState.isNotEmpty
                ? response.conversationState
                : null,
            sessionId:
                response.sessionId.isNotEmpty ? response.sessionId : null,
            receiptData: receiptData,
            receiptCard: receiptCard,
            qrCard: qrCard,
            recipientCard: recipientCard,
            analyticsCard: analyticsCard,
            serverMessageId: serverMessageId,
            pinPrompt: pinPrompt,
          );
          _currentMessages.add(aiMessageEntity);
          emit(AIChatMessageSuccess(messages: List.from(_currentMessages)));
        } else {
          emit(AIChatMessageError(
              errorMessage: response.msg.isNotEmpty
                  ? response.msg
                  : "AI service returned an error.",
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
        emit(AIChatMessageError(
            errorMessage: failure.message,
            messages: List.from(_currentMessages)));
      },
      (response) {
        if (!response.success) {
          emit(AIChatMessageError(
              errorMessage: response.msg.isNotEmpty
                  ? response.msg
                  : 'Could not complete that.',
              messages: List.from(_currentMessages)));
          return;
        }
        final entitiesMap = response.entities.isNotEmpty
            ? Map<String, String>.from(response.entities)
            : null;
        Map<String, dynamic>? receiptData;
        if (entitiesMap != null && entitiesMap.containsKey('_receipt_data')) {
          try {
            receiptData = jsonDecode(entitiesMap['_receipt_data']!)
                as Map<String, dynamic>;
          } catch (_) {}
          entitiesMap.remove('_receipt_data');
        }
        Map<String, dynamic>? pinPrompt;
        if (entitiesMap != null && entitiesMap.containsKey('_pin_prompt')) {
          try {
            pinPrompt =
                jsonDecode(entitiesMap['_pin_prompt']!) as Map<String, dynamic>;
          } catch (_) {}
          entitiesMap.remove('_pin_prompt');
        }
        final dynamic receiptCard = _decodeReceiptCard(entitiesMap);
        final qrCard = _decodeQrCard(entitiesMap);
        final recipientCard = _decodeRecipientCard(entitiesMap);
        final analyticsCard = _decodeAnalyticsCard(entitiesMap);
        _currentMessages.add(ChatMessageEntity(
          text: response.response,
          isUser: false,
          timestamp: DateTime.now(),
          intent: response.intent.isNotEmpty ? response.intent : null,
          entities: entitiesMap != null && entitiesMap.isNotEmpty
              ? entitiesMap
              : null,
          conversationState: response.conversationState.isNotEmpty
              ? response.conversationState
              : null,
          sessionId: response.sessionId.isNotEmpty ? response.sessionId : null,
          receiptData: receiptData,
          receiptCard: receiptCard,
          qrCard: qrCard,
          recipientCard: recipientCard,
          analyticsCard: analyticsCard,
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
        errorMessage:
            'File is too large (max ${maxMB}MB). Please choose a smaller file.',
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
              mediaReceiptData = jsonDecode(response.entities['_receipt_data']!)
                  as Map<String, dynamic>;
            } catch (_) {}
          }
          final dynamic mediaReceiptCard =
              _decodeReceiptCard(Map<String, String>.from(response.entities));

          final aiMessage = ChatMessageEntity(
            text: response.response,
            isUser: false,
            timestamp: DateTime.now(),
            sessionId:
                response.sessionId.isNotEmpty ? response.sessionId : null,
            receiptData: mediaReceiptData,
            receiptCard: mediaReceiptCard,
          );
          _currentMessages.add(aiMessage);
          emit(AIChatMessageSuccess(messages: List.from(_currentMessages)));
        } else {
          emit(AIChatMessageError(
            errorMessage: response.msg.isNotEmpty
                ? response.msg
                : 'AI service returned an error.',
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
    // Must be cleared with the messages. A cursor left behind points into the
    // conversation that was just cleared, so the first scroll-up in the NEW
    // thread would prepend a page of the old one.
    _nextBefore = '';
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
  void updateSettings(
      {required String responseStyle, required bool emojiUsage}) {
    // No-op: settings are read from SharedPreferences by HttpAiChatDataSource.
    // This method exists so the UI can signal the cubit if needed in the future.
  }

  /// Record how useful an answer was, so the assistant can be improved.
  ///
  /// Best-effort and silent: feedback is not the user's errand, so a failure
  /// here must never surface as an error or undo the tap the user just made.
  /// The UI holds the rating; this only reports it.
  ///
  /// Skipped entirely when the answer has no server id — an optimistic bubble
  /// or an error message is not something the server can attribute a rating
  /// to, and inventing one would record a thumb against the wrong row.
  Future<void> rateAnswer({
    required int? serverMessageId,
    required String rating,
  }) async {
    if (serverMessageId == null) return;
    try {
      await _getAIChatHistoryUseCase.rateAnswer(
        messageId: serverMessageId,
        rating: rating,
      );
    } catch (_) {
      // Deliberately swallowed — see the doc above.
    }
  }
}
