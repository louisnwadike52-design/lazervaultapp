import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/core/services/account_manager.dart';
import 'package:lazervault/core/services/chat_language_preference.dart';
import 'package:lazervault/core/services/chat_session_manager.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/cache/swr_cache_manager.dart';
import 'package:lazervault/core/services/locale_manager.dart';
import 'package:lazervault/core/utils/pin_mask_utils.dart';
import '../domain/entities/general_chat_message_entity.dart';
import '../domain/usecases/send_general_chat_message_usecase.dart';
import '../domain/usecases/load_microservice_chat_history_usecase.dart';
import 'general_chat_state.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';

/// Cubit for managing general chat state through the Enhanced Chat Gateway
///
/// Features:
/// - LLM-based intent classification
/// - Conversation state management (Redis)
/// - Service switching detection
/// - Multi-service conversation support
///
/// This differs from MicroserviceChatCubit in that:
/// - All messages flow through the intelligent gateway
/// - Gateway uses LLM to classify intent and route appropriately
/// - Conversation state maintained across service switches
/// - Supports multi-service conversations with context awareness
class GeneralChatCubit extends Cubit<GeneralChatState> {
  final SendGeneralChatMessageUseCase sendMessageUseCase;
  final LoadMicroserviceChatHistoryUseCase? loadHistoryUseCase;
  final AuthenticationCubit authCubit;

  /// Multi-tab chat: manages the active session id, drawer list, and
  /// the "switch session" stream this cubit subscribes to. Optional so
  /// callers without the manager (e.g. tests) still build.
  final ChatSessionManager? sessionManager;

  StreamSubscription<String?>? _sessionIdSub;

  List<GeneralChatMessageEntity> _currentMessages = [];
  late String _sessionId;

  /// User-selected chatbot response language code (en/yo/ig/ha/pcm/fr/es).
  /// Loaded from [ChatLanguagePreference]; defaults to 'en'.
  String _language = ChatLanguagePreference.defaultLanguage;

  /// The currently-selected chatbot language code.
  String get language => _language;

  String? _currentService;
  final List<String> _conversationServices = [];

  /// Guard against concurrent sendMessage calls from rapid taps.
  bool _isSending = false;

  GeneralChatCubit({
    required this.sendMessageUseCase,
    this.loadHistoryUseCase,
    required this.authCubit,
    this.sessionManager,
  }) : super(const GeneralChatInitial());

  /// Build the *seed* session id used when the multi-tab manager has no
  /// active session yet — falls back to the legacy deterministic id so
  /// existing-user chat history maps cleanly to their "first tab".
  String _buildLegacySessionId() {
    final locale = serviceLocator<LocaleManager>().currentLocale;
    final authState = authCubit.state;
    if (authState is AuthenticationSuccess) {
      return 'general_${authState.profile.user.id}_$locale';
    }
    return 'general_unknown_$locale';
  }

  /// Pick the best starting session id: prefer the multi-tab manager's
  /// active id (restored from SecureStorage), fall back to the legacy
  /// deterministic id so an existing user lands on their existing
  /// rolling conversation — mapped into the multi-tab UI as their
  /// "first session".
  String _resolveInitialSessionId() {
    final sm = sessionManager;
    if (sm != null) {
      final active = sm.currentSessionId;
      if (active != null && active.isNotEmpty) return active;
    }
    return _buildLegacySessionId();
  }

  /// Active dashboard region + virtual account. Data scoping (which region's
  /// accounts/history/board the request reads and writes) rides these — a DIFFERENT
  /// axis from the reply [language]. The general path previously sent the *language*
  /// locale as the region and omitted account/country/currency, so scoping depended
  /// on header fallback and broke when a non-English language was selected.
  ({String locale, String accountId, String currency, String country})
      _regionScope() {
    final lm = serviceLocator<LocaleManager>();
    final am = serviceLocator<AccountManager>();
    return (
      locale: lm.currentLocale,
      accountId: am.activeAccountId ?? '',
      currency: lm.currentCurrency,
      country: lm.currentCountry,
    );
  }

  /// Persist and apply the user-selected chatbot response language. The next
  /// message sent will instruct the backend to reply in this language.
  Future<void> setLanguage(String code) async {
    await ChatLanguagePreference.setLanguage(code);
    _language = await ChatLanguagePreference.getLanguage();
  }

  void initializeChat() {
    // Load the persisted chatbot language so every request carries it.
    ChatLanguagePreference.getLanguage().then((lang) {
      _language = lang;
    });
    _sessionId = _resolveInitialSessionId();
    _currentMessages = [];
    _currentService = null;
    _conversationServices.clear();
    _isSending = false;
    emit(GeneralChatInitial(messages: _currentMessages));

    // Subscribe to session switches from the drawer. When the user picks
    // another tab (or creates / deletes one), the manager broadcasts the
    // new id; we reset local state and reload history for that session.
    final sm = sessionManager;
    if (sm != null) {
      _sessionIdSub?.cancel();
      _sessionIdSub = sm.currentSessionIdStream.listen((newId) {
        if (newId == null || newId.isEmpty) return;
        if (newId == _sessionId) return;
        _sessionId = newId;
        _currentMessages = [];
        _currentService = null;
        _conversationServices.clear();
        emit(GeneralChatInitial(messages: _currentMessages));
        // Reload the chosen session's transcript from the gateway.
        loadHistory();
      });
    }

    // Add welcome message for Enhanced Gateway
    final welcomeMessage = GeneralChatMessageEntity(
      text: '''👋 Hi! I'm Lazer, your Lazervault assistant!

I use AI to understand what you need and route you to the right service:

🏦 **Banking** - Check balances, transfer money
📈 **Investments** - Manage your portfolio
💳 **Payments** - Pay bills, buy airtime
🎁 **Gift Cards** - Purchase and redeem cards
📋 **Invoices** - Create and track invoices
🏡 **Insurance** - Get insurance policies
💰 **Savings** - Autosave, lock funds, crowdfunding

Just ask me anything naturally! I'll understand your intent and help you.''',
      isUser: false,
      timestamp: DateTime.now(),
      serviceRoutedTo: 'gateway',
      metadata: {
        'type': 'welcome',
        'gateway_version': 'enhanced',
        'isSystemMessage': true,
      },
    );
    _currentMessages.add(welcomeMessage);
    emit(GeneralChatInitial(messages: List.from(_currentMessages)));
  }

  /// Load chat history from backend.
  Future<void> loadHistory() async {
    if (loadHistoryUseCase == null) return;

    emit(GeneralChatHistoryLoading(messages: _currentMessages));

    final locale = serviceLocator<LocaleManager>().currentLocale;

    final result = await loadHistoryUseCase!(
      sourceContext: 'general',
      sessionId: _sessionId,
      accessToken: '', // Token injected by interceptor
      locale: locale,
    );

    if (isClosed) return;
    result.fold(
      (failure) {
        // History load failed — keep welcome message
        emit(GeneralChatInitial(messages: _currentMessages));
      },
      (history) {
        if (history.isNotEmpty) {
          // Map MicroserviceChatMessageEntity to GeneralChatMessageEntity
          final historyMessages = history.map((msg) => GeneralChatMessageEntity(
            text: msg.isUser ? maskIfPin(msg.text) : msg.text,
            isUser: msg.isUser,
            timestamp: msg.timestamp,
            serviceRoutedTo: msg.serviceRoutedTo,
            metadata: msg.metadata,
            // Preserve media fields from history
            mediaType: msg.mediaType,
            mediaUrl: msg.mediaUrl,
            localMediaPath: msg.localMediaPath,
            audioDurationMs: msg.audioDurationMs,
            transcript: msg.transcript,
          )).toList();

          // Replace welcome message with actual history
          _currentMessages = historyMessages;
          emit(GeneralChatSuccess(messages: List.from(_currentMessages)));
        } else {
          // No history — keep welcome message
          emit(GeneralChatInitial(messages: _currentMessages));
        }
      },
    );
  }

  /// Send a chat message. [replyToText] / [replyToIsUser] carry the
  /// swipe-to-reply context: the earlier message the user swiped to reply to.
  /// When present (and the input isn't a PIN) the quoted text is prepended to
  /// the message the AI sees so its reply is grounded in that specific message,
  /// and it's stored on the user bubble so the quote persists in history.
  Future<void> sendMessage(
    String text, {
    String? replyToText,
    bool? replyToIsUser,
  }) async {
    if (text.trim().isEmpty || _isSending) return;
    _isSending = true;

    try {
    final authState = authCubit.state;
    if (authState is! AuthenticationSuccess) {
      emit(GeneralChatError(
        errorMessage: 'User not authenticated',
        messages: List.from(_currentMessages),
      ));
      return;
    }

    // Swipe-to-reply: never fold a quote into a PIN turn. The AI sees the quote
    // prepended so its reply is grounded in the referenced message; the stored
    // bubble keeps only the typed text.
    final isReply = replyToText != null &&
        replyToText.trim().isNotEmpty &&
        !isPinText(text.trim());
    final messageForAI = isReply
        ? _withReplyContext(text, replyToText, replyToIsUser ?? false)
        : text;

    // Add user message immediately
    final userMessage = GeneralChatMessageEntity(
      text: text,
      isUser: true,
      timestamp: DateTime.now(),
      replyToText: isReply ? replyToText.trim() : null,
      replyToIsUser: isReply ? (replyToIsUser ?? false) : null,
    );
    _currentMessages.add(userMessage);

    emit(GeneralChatLoading(messages: List.from(_currentMessages)));

    // Reply language and data-scoping region are DISTINCT axes: `language` picks
    // the response language; `locale` (+ account/country/currency) picks which
    // region's data the request reads/writes. Region comes from the active
    // dashboard, NOT the chosen language.
    final scope = _regionScope();

    final result = await sendMessageUseCase(
      message: messageForAI,
      sessionId: _sessionId,
      userId: authState.profile.user.id,
      accessToken: '', // Access token is managed by GrpcCallOptionsHelper
      sourceContext: 'general', // Always 'general' for this screen
      language: _language,
      locale: scope.locale,
      accountId: scope.accountId,
      currency: scope.currency,
      userCountry: scope.country,
    );

    result.fold(
      (failure) {
        emit(GeneralChatError(
          errorMessage: failure.message,
          messages: List.from(_currentMessages),
        ));
      },
      (response) {
        // Extract enhanced response fields
        final serviceRoutedTo = response.serviceRoutedTo;
        final intentClassification = response.intentClassification;
        final conversationState = response.conversationState;
        final shouldSwitchService = response.shouldSwitchService;
        final previousService = response.previousService;

        // Update current service if switched
        if (shouldSwitchService == true && previousService != null) {
          _currentService = serviceRoutedTo;
          if (!_conversationServices.contains(serviceRoutedTo)) {
            _conversationServices.add(serviceRoutedTo);
          }
        }

        // Add system message if service switched
        List<GeneralChatMessageEntity> updatedMessages = List.from(_currentMessages);

        if (shouldSwitchService == true && previousService != null && previousService.isNotEmpty) {
          final switchMessage = GeneralChatMessageEntity(
            text: '🔄 Switching to ${_getServiceDisplayName(serviceRoutedTo)} service...\n\n${intentClassification.reasoning}',
            isUser: false,
            timestamp: DateTime.now(),
            serviceRoutedTo: 'gateway',
            metadata: {
              'type': 'service_switch',
              'from': previousService,
              'to': serviceRoutedTo,
              'confidence': intentClassification.confidence,
              'isSystemMessage': true,
            },
          );
          updatedMessages.add(switchMessage);
        }

        // Add bot response with enhanced metadata
        // Debug log receipt data ALWAYS
        print('🧾 [RECEIPT] response.receiptData is null: ${response.receiptData == null}');
        if (response.receiptData != null) {
          print('🧾 [RECEIPT] Receipt data keys: ${response.receiptData!.keys}');
        }

        // Pluck bill-payment metadata fields (surfaced by chat-products-service
        // via main.py) so the chat UI can render quick-action chips and a
        // deep-link button under the receipt card.
        final responseMeta = response.metadata ?? const {};
        final quickActions = (responseMeta['quick_actions'] as List?)
            ?.whereType<String>()
            .toList(growable: false);
        final billType = responseMeta['bill_type'] as String?;
        final lastPaymentId = responseMeta['last_payment_id'] as String?;

        final botMessage = GeneralChatMessageEntity(
          text: response.response,
          isUser: false,
          timestamp: DateTime.now(),
          serviceRoutedTo: serviceRoutedTo,
          metadata: {
            'intent_confidence': intentClassification.confidence,
            'intent_service': intentClassification.service,
            'intent_reasoning': intentClassification.reasoning,
            'suggested_action': intentClassification.suggestedAction,
            'message_count': conversationState.messageCount,
            'key_entities': conversationState.keyEntities,
            'isSystemMessage': false,
            if (response.receiptData != null)
              'receipt_data': response.receiptData,
            // Surface the PIN prompt so general_chat_content renders the
            // transaction PIN bottom sheet (_buildPinPromptCard reads
            // metadata['pin_prompt']). Without this the general path collected
            // the prompt server-side but never showed the sheet.
            if (response.pinPrompt != null)
              'pin_prompt': response.pinPrompt,
            // Surface the ReceiptCard V2 payload (single dict or batch list) so
            // general_chat_content renders ChatReceiptCardV2 / …List. Without
            // this the batch flow completed but showed no receipt cards.
            if (response.receiptCard != null)
              'receipt_card': response.receiptCard,
            // Surface the classified LLM-provider error code (set by
            // chat-agent-gateway's llm_failover module) so the chat content
            // widget can render the downgrade banner + retry CTA. The
            // gateway already swapped the assistant response_text for a
            // friendly user-facing message; this signal lets the UI add
            // an inline note explaining the provider degradation without
            // exposing raw error strings.
            if (response.llmErrorCode != null && response.llmErrorCode!.isNotEmpty)
              'llm_error_code': response.llmErrorCode,
            if (quickActions != null && quickActions.isNotEmpty)
              'quick_actions': quickActions,
            if (billType != null && billType.isNotEmpty)
              'bill_type': billType,
            if (lastPaymentId != null && lastPaymentId.isNotEmpty)
              'last_payment_id': lastPaymentId,
          },
        );
        updatedMessages.add(botMessage);
        print('🧾 [RECEIPT] Bot message metadata keys: ${botMessage.metadata?.keys.toList()}');
        print('🧾 [RECEIPT] Bot message has receipt_data: ${botMessage.metadata?['receipt_data'] != null}');

        // Invalidate recipient cache after successful transfer (auto-save may have added a new one)
        if (response.receiptData != null) {
          print('🧾 [RECEIPT] Invalidating transfer caches...');
          _invalidateTransferRelatedCaches();
        }

        _currentMessages = updatedMessages;
        emit(GeneralChatSuccess(
          messages: List.from(_currentMessages),
          currentService: _currentService,
          conversationServices: List.from(_conversationServices),
          intentClassification: {
            'service': intentClassification.service,
            'confidence': intentClassification.confidence,
            'reasoning': intentClassification.reasoning,
            'suggestedAction': intentClassification.suggestedAction,
          },
        ));
      },
    );
    } finally {
      _isSending = false;
    }
  }

  /// Submit a PIN verification token in response to a pin_prompt the
  /// agent emitted. Sends a follow-up chat message with
  /// metadata.pin_verification_token + the original callback_intent +
  /// callback_args; the chat gateway forwards these as `entities` to
  /// the downstream chat service, whose agent re-invokes the bound
  /// callback tool with the token (NOT the raw PIN) attached. The PIN
  /// never leaves the native modal, never enters the LLM context, and
  /// never lands in chat history.
  ///
  /// Surfaces as a near-empty assistant message (or a ReceiptCard) on
  /// success; on failure the agent returns a user-facing error string.
  Future<void> submitPinVerification({
    required String verificationToken,
    required String callbackIntent,
    Map<String, dynamic> callbackArgs = const {},
    String userPromptText = '',
  }) async {
    if (verificationToken.isEmpty || _isSending) return;
    _isSending = true;
    try {
      final authState = authCubit.state;
      if (authState is! AuthenticationSuccess) return;

      // We don't emit a user bubble for the PIN submission — the user
      // already tapped through a native modal; another bubble showing
      // "submitted PIN" would clutter the conversation. Just go straight
      // to loading + the bot response.
      emit(GeneralChatLoading(messages: List.from(_currentMessages)));

      final scope = _regionScope();

      // The downstream chat-*-service reads pin_verification_token,
      // callback_intent and callback_args from `entities`; the gateway
      // copies them out of metadata into entities (see chat-agent-gateway
      // main.py). userPromptText is what the LLM sees as the "user
      // message" — usually empty / a token sentinel so the agent
      // recognises this is a PIN-callback turn rather than a fresh ask.
      final result = await sendMessageUseCase(
        message: userPromptText.isEmpty
            ? '__pin_verified__'  // sentinel the agent's prompt recognises
            : userPromptText,
        sessionId: _sessionId,
        userId: authState.profile.user.id,
        accessToken: '',
        sourceContext: 'general',
        language: _language,
        locale: scope.locale,
        accountId: scope.accountId,
        currency: scope.currency,
        userCountry: scope.country,
        metadata: {
          'pin_verification_token': verificationToken,
          'callback_intent': callbackIntent,
          'callback_args': callbackArgs,
          'execute': true,
        },
      );

      result.fold(
        (failure) {
          emit(GeneralChatError(
            errorMessage: failure.message,
            messages: List.from(_currentMessages),
          ));
        },
        (response) {
          final responseMeta = response.metadata ?? const {};
          final botMessage = GeneralChatMessageEntity(
            text: response.response,
            isUser: false,
            timestamp: DateTime.now(),
            serviceRoutedTo: response.serviceRoutedTo,
            metadata: {
              ...responseMeta,
              if (response.receiptData != null)
                'receipt_data': response.receiptData,
              if (response.receiptCard != null)
                'receipt_card': response.receiptCard,
            },
          );
          _currentMessages.add(botMessage);
          emit(GeneralChatSuccess(
            messages: List.from(_currentMessages),
            currentService: _currentService,
            conversationServices: List.from(_conversationServices),
          ));
        },
      );
    } finally {
      _isSending = false;
    }
  }

  /// Maximum media file size (10MB for images, 25MB for audio).
  static const int _maxImageSize = 10 * 1024 * 1024;
  static const int _maxAudioSize = 25 * 1024 * 1024;

  /// Send a media message (image or voice note) through the Enhanced Chat Gateway.
  Future<void> sendMediaMessage({
    required String mediaType, // 'image' | 'voice'
    required String localFilePath,
    required String mimeType,
    String text = '',
    int? audioDurationMs,
  }) async {
    if (_isSending) return;
    _isSending = true;

    try {
    final authState = authCubit.state;
    if (authState is! AuthenticationSuccess) {
      emit(GeneralChatError(
        errorMessage: 'User not authenticated',
        messages: List.from(_currentMessages),
      ));
      return;
    }

    // Validate file exists and check size before reading into memory
    final file = File(localFilePath);
    if (!file.existsSync()) {
      emit(GeneralChatError(
        errorMessage: 'The media file could not be found. Please try again.',
        messages: List.from(_currentMessages),
      ));
      return;
    }

    final fileSize = file.lengthSync();
    final maxSize = mediaType == 'image' ? _maxImageSize : _maxAudioSize;
    if (fileSize > maxSize) {
      final maxMB = maxSize ~/ (1024 * 1024);
      emit(GeneralChatError(
        errorMessage: 'File is too large (max ${maxMB}MB). Please choose a smaller file.',
        messages: List.from(_currentMessages),
      ));
      return;
    }
    if (fileSize == 0) {
      emit(GeneralChatError(
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
    final userMessage = GeneralChatMessageEntity(
      text: displayText,
      isUser: true,
      timestamp: DateTime.now(),
      mediaType: mediaType,
      localMediaPath: localFilePath,
      audioDurationMs: audioDurationMs,
    );
    _currentMessages.add(userMessage);
    emit(GeneralChatLoading(messages: List.from(_currentMessages)));

    final scope = _regionScope();

    final result = await sendMessageUseCase(
      message: text,
      sessionId: _sessionId,
      userId: authState.profile.user.id,
      accessToken: '',
      sourceContext: 'general',
      language: _language,
      locale: scope.locale,
      accountId: scope.accountId,
      currency: scope.currency,
      userCountry: scope.country,
      mediaBase64: base64Data,
      mediaType: mediaType,
      mediaMimeType: mimeType,
    );

    if (isClosed) return;
    result.fold(
      (failure) {
        emit(GeneralChatError(
          errorMessage: failure.message,
          messages: List.from(_currentMessages),
        ));
      },
      (response) {
        // Update the user message with the media URL returned by backend
        // The backend stores media and returns the URL in metadata.media.url
        final mediaMetadata = response.metadata?['media'] as Map<String, dynamic>?;
        final mediaUrl = mediaMetadata?['url'] as String?;

        // Find and update the user message we added earlier
        final userMsgIndex = _currentMessages.indexWhere(
          (m) => m.isUser && m.timestamp == _currentMessages.lastWhere((m) => m.isUser).timestamp,
        );

        if (userMsgIndex >= 0 && mediaUrl != null) {
          final updatedUserMsg = _currentMessages[userMsgIndex].copyWith(mediaUrl: mediaUrl);
          _currentMessages[userMsgIndex] = updatedUserMsg;
        }

        final botMessage = GeneralChatMessageEntity(
          text: response.response,
          isUser: false,
          timestamp: DateTime.now(),
          serviceRoutedTo: response.serviceRoutedTo,
        );
        _currentMessages.add(botMessage);
        emit(GeneralChatSuccess(
          messages: List.from(_currentMessages),
          currentService: _currentService,
          conversationServices: List.from(_conversationServices),
        ));
      },
    );
    } finally {
      _isSending = false;
    }
  }

  /// Invalidate caches after a successful chatbot transfer (auto-saved recipient).
  void _invalidateTransferRelatedCaches() {
    try {
      final cacheManager = serviceLocator<SWRCacheManager>();
      cacheManager.invalidatePattern('recipients:');
      cacheManager.invalidatePattern('accounts:');
      cacheManager.invalidatePattern('transactions:');
    } catch (_) {
      // Non-blocking
    }
  }

  /// Prepend the swipe-to-reply quote as an explicit context preamble so the
  /// AI's reply is grounded in the referenced message. The send path carries a
  /// single `message` string end-to-end, so the quote rides along there — no
  /// proto/API change needed. The quote is capped so a long referenced message
  /// can't blow up the prompt.
  String _withReplyContext(String userText, String replyToText, bool fromUser) {
    final quoted = replyToText.trim();
    if (quoted.isEmpty) return userText;
    final capped = quoted.length > 600 ? '${quoted.substring(0, 600)}…' : quoted;
    final author = fromUser ? 'the user' : 'the assistant';
    return 'Replying to $author\'s earlier message: "$capped"\n\n$userText';
  }

  void clearChat() {
    _currentMessages = [];
    _sessionId = _resolveInitialSessionId();
    _currentService = null;
    _conversationServices.clear();
    emit(GeneralChatInitial(messages: _currentMessages));
    initializeChat();
  }

  /// Local-only helper: returns the currently-loaded session id so the
  /// chat screen's AppBar can display "Rename current session" against
  /// the right row. Source of truth is still `ChatSessionManager`.
  String get currentSessionId => _sessionId;

  @override
  Future<void> close() async {
    await _sessionIdSub?.cancel();
    return super.close();
  }

  String _getServiceDisplayName(String service) {
    final displayNames = {
      'accounts': 'Accounts',
      'payments': 'Payments',
      'transfers': 'Transfers',
      'investments': 'Investments',
      'financial_products': 'Financial Products',
      'giftcards': 'Gift Cards',
      'invoices': 'Invoices',
      'utility': 'Utility Bills',
    };
    return displayNames[service] ?? service;
  }
}
