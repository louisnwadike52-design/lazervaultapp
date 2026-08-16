import 'dart:convert';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/core/services/app_activity_bus.dart';
import 'package:lazervault/core/cache/swr_cache_manager.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/account_manager.dart';
import 'package:lazervault/core/services/locale_manager.dart';
import 'package:lazervault/core/utils/pin_mask_utils.dart';
import '../domain/entities/microservice_chat_message_entity.dart';
import '../domain/usecases/send_microservice_chat_message_usecase.dart';
import '../domain/usecases/send_direct_chat_message_usecase.dart';
import '../domain/usecases/load_microservice_chat_history_usecase.dart';
import '../domain/usecases/load_direct_chat_history_usecase.dart';
import 'microservice_chat_state.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';

class MicroserviceChatCubit extends Cubit<MicroserviceChatState> {
  final SendMicroserviceChatMessageUseCase sendMessageUseCase;
  final SendDirectChatMessageUseCase? directMessageUseCase;
  final LoadMicroserviceChatHistoryUseCase? loadHistoryUseCase;
  final LoadDirectChatHistoryUseCase? loadDirectHistoryUseCase;
  final AuthenticationCubit authCubit;
  final String sourceContext;
  final bool isDirect;

  /// Scoped context seeded into the round-tripped entities on init — used by
  /// the P2P-chat assistant to pin the agent to one conversation
  /// (conversation_id / peer_user_id). Null for normal service chats.
  final Map<String, dynamic>? seedEntities;

  List<MicroserviceChatMessageEntity> _currentMessages = [];
  late String _sessionId;

  /// Entity storage for direct chat round-tripping.
  Map<String, dynamic> _entities = {};

  /// Immutable scoping context (e.g. P2P `conversation_id` / `peer_user_id`).
  /// Unlike normal entities — which the agent OWNS and replaces every turn —
  /// these fix WHICH conversation the assistant is scoped to and must ride
  /// along on EVERY outbound turn, even after the agent returns entities that
  /// omit them. Captured once from [seedEntities]; always merged in on send
  /// and re-applied after each response replaces [_entities].
  Map<String, dynamic> _scopeEntities = {};

  /// Guard against concurrent sendMessage calls from rapid taps.
  bool _isSending = false;

  MicroserviceChatCubit({
    required this.sendMessageUseCase,
    this.directMessageUseCase,
    this.loadHistoryUseCase,
    this.loadDirectHistoryUseCase,
    required this.authCubit,
    required this.sourceContext,
    this.isDirect = false,
    this.seedEntities,
    this.sessionScopeId,
  }) : super(const MicroserviceChatInitial());

  /// Optional per-instance scope (e.g. a P2P conversation id) folded into the
  /// session id so each scope keeps its OWN session + persisted history. Two
  /// P2P chats with the same source_context would otherwise share one session
  /// and leak each other's history.
  final String? sessionScopeId;

  /// Initialize chat with a deterministic or provided session ID.
  /// Includes locale in session_id so each locale gets its own session.
  void initializeChat({String? persistentSessionId}) {
    final locale = serviceLocator<LocaleManager>().currentLocale;
    if (persistentSessionId != null) {
      _sessionId = persistentSessionId;
    } else {
      final authState = authCubit.state;
      final prefix = isDirect ? 'direct' : 'svc';
      // Per-scope suffix keeps each P2P conversation's AI session + history
      // separate (else all `p2p_chat` chats collide on one session id).
      final scope = (sessionScopeId != null && sessionScopeId!.isNotEmpty)
          ? '_${sessionScopeId!}'
          : '';
      if (authState is AuthenticationSuccess) {
        _sessionId =
            '${prefix}_${authState.profile.user.id}_${sourceContext}$scope\_$locale';
      } else {
        _sessionId = '${prefix}_unknown_${sourceContext}$scope\_$locale';
      }
    }
    _currentMessages = [];
    // Seed scoped context (P2P conversation id / peer) so it round-trips to the
    // agent as entities from the very first message.
    _entities = seedEntities != null
        ? Map<String, dynamic>.from(seedEntities!)
        : {};
    // Capture the seed as immutable scope so it survives the agent's
    // replace-every-turn entity ownership (see [_scopeEntities]).
    _scopeEntities = seedEntities != null
        ? Map<String, dynamic>.from(seedEntities!)
        : {};
    _isSending = false;
    emit(MicroserviceChatInitial(messages: _currentMessages));
  }

  /// Load chat history from backend.
  Future<void> loadHistory() async {
    emit(MicroserviceChatHistoryLoading(messages: _currentMessages));

    final locale = serviceLocator<LocaleManager>().currentLocale;

    // Use direct history use case when in direct mode
    if (isDirect && loadDirectHistoryUseCase != null) {
      final result = await loadDirectHistoryUseCase!(
        sourceContext: sourceContext,
        sessionId: _sessionId,
        accessToken: '',
        locale: locale,
      );

      if (isClosed) return;
      result.fold(
        (failure) {
          emit(MicroserviceChatInitial(messages: _currentMessages));
        },
        (history) {
          _currentMessages = history;
          if (_currentMessages.isEmpty) {
            emit(MicroserviceChatInitial(messages: _currentMessages));
          } else {
            emit(MicroserviceChatMessageSuccess(messages: List.from(_currentMessages)));
          }
        },
      );
      return;
    }

    // Fallback to standard history loading
    if (loadHistoryUseCase == null) return;

    final result = await loadHistoryUseCase!(
      sourceContext: sourceContext,
      sessionId: _sessionId,
      accessToken: '',
      locale: locale,
    );

    if (isClosed) return;
    result.fold(
      (failure) {
        emit(MicroserviceChatInitial(messages: _currentMessages));
      },
      (history) {
        _currentMessages = history;
        if (_currentMessages.isEmpty) {
          emit(MicroserviceChatInitial(messages: _currentMessages));
        } else {
          emit(MicroserviceChatMessageSuccess(messages: List.from(_currentMessages)));
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
    // Active chatting is engagement — don't let inactivity auto-logout fire
    // mid-conversation.
    AppActivityBus.instance.ping();

    try {
      final authState = authCubit.state;
      if (authState is! AuthenticationSuccess) {
        emit(MicroserviceChatMessageError(
          errorMessage: 'User not authenticated',
          messages: List.from(_currentMessages),
        ));
        return;
      }

      // Swipe-to-reply: never fold a quote into a PIN turn.
      final isReply = replyToText != null &&
          replyToText.trim().isNotEmpty &&
          !isPinText(text.trim());
      // What the AI sees — quoted context prepended so the reply is grounded in
      // the referenced message. The stored bubble keeps only the typed text.
      final messageForAI = isReply
          ? _withReplyContext(text, replyToText, replyToIsUser ?? false)
          : text;

      // Add user message immediately — mask PIN-like input for display security
      final displayText = maskIfPin(text);
      final userMessage = MicroserviceChatMessageEntity(
        text: displayText,
        isUser: true,
        timestamp: DateTime.now(),
        replyToText: isReply ? replyToText.trim() : null,
        replyToIsUser: isReply ? (replyToIsUser ?? false) : null,
      );
      _currentMessages.add(userMessage);

      emit(MicroserviceChatMessageLoading(messages: List.from(_currentMessages)));

      final localeManager = serviceLocator<LocaleManager>();
      final locale = localeManager.currentLocale;
      // Resolve the ACTIVE account + ACTIVE locale so the agent operates on the
      // wallet/currency the user is currently looking at — not a JWT-default or
      // a stale user-profile value. The active account is the source of truth on
      // every service screen (the dashboard carousel drives AccountManager); the
      // active locale/country/currency come from LocaleManager (region switcher).
      // Fall back to the user profile only when the active values are unset.
      final activeAccountId =
          serviceLocator<AccountManager>().activeAccountId ?? '';
      final activeCountry = localeManager.currentCountry.isNotEmpty
          ? localeManager.currentCountry
          : (authState.profile.user.country ?? '');
      final activeCurrency = localeManager.currentCurrency.isNotEmpty
          ? localeManager.currentCurrency
          : (authState.profile.user.currency ?? '');

      // Use direct path if enabled and use case available
      if (isDirect && directMessageUseCase != null) {
        // For PIN messages, send empty entities to let Go proxy use its
        // authoritative server-side session entities. This prevents desync
        // where Flutter's local _entities are stale (e.g. after cancel).
        // For PIN messages, send only the scope (no stale flow entities) so the
        // Go proxy uses its authoritative server-side session for the transfer;
        // scope keys still ride along so the turn stays conversation-bound.
        // Otherwise send accumulated entities. Scope is ALWAYS merged in — it
        // must never be dropped by the agent's replace-every-turn ownership.
        final entitiesToSend = <String, dynamic>{
          if (isPinText(text.trim()))
            ..._scopeEntities
          else ...{
            ..._entities,
            ..._scopeEntities,
          },
        };

        final result = await directMessageUseCase!(
          message: messageForAI,
          sessionId: _sessionId,
          userId: authState.profile.user.id,
          accessToken: '',
          sourceContext: sourceContext,
          entities: entitiesToSend,
          // Active account wins; Go gateway still falls back to JWT if empty.
          accountId: activeAccountId,
          userCountry: activeCountry,
          currency: activeCurrency,
          language: 'en',
          locale: locale,
        );

        if (isClosed) return;
        result.fold(
          (failure) {
            emit(MicroserviceChatMessageError(
              errorMessage: failure.message,
              messages: List.from(_currentMessages),
            ));
          },
          (chatResponse) {
            // REPLACE, not merge — agent is source of truth
            // Always replace, even with empty map (agent clears state after completed operations)
            _entities = Map<String, dynamic>.from(chatResponse.entities);
            // Re-apply immutable scope: the agent may omit conversation_id /
            // peer_user_id from its returned entities, but the assistant must
            // stay bound to this conversation on the next turn.
            _entities.addAll(_scopeEntities);

            // Extract transient receipt_data from entities (not round-tripped)
            final receiptData = _entities.remove('_receipt_data');
            // Bill-payment signals surfaced by chat-products-service.
            final quickActions = (_entities.remove('_quick_actions') as List?)
                ?.whereType<String>()
                .toList(growable: false);
            final billType = _entities['last_bill_type'] as String?;
            final lastPaymentId = _entities['last_payment_id'] as String?;
            // New chat protocol — pin_prompt + receipt_card sentinels
            // from chat_services_shared/protocol_emit.py. Direct gRPC
            // path doesn't carry top-level metadata so we read straight
            // off entities under the sentinel keys. Strip them so the
            // next round-trip doesn't re-send.
            final pinPrompt = _entities.remove('_pin_prompt_pending');
            final receiptCard = _entities.remove('_receipt_card_pending');

            final messageMetadata = <String, dynamic>{};
            if (receiptData is Map<String, dynamic>) {
              messageMetadata['receipt_data'] = receiptData;
              _invalidateTransferRelatedCaches();
            }
            if (quickActions != null && quickActions.isNotEmpty) {
              messageMetadata['quick_actions'] = quickActions;
            }
            if (billType != null && billType.isNotEmpty) {
              messageMetadata['bill_type'] = billType;
            }
            if (lastPaymentId != null && lastPaymentId.isNotEmpty) {
              messageMetadata['last_payment_id'] = lastPaymentId;
            }
            if (pinPrompt is Map) {
              messageMetadata['pin_prompt'] =
                  Map<String, dynamic>.from(pinPrompt);
            }
            if (receiptCard != null) {
              messageMetadata['receipt_card'] = receiptCard;
              _invalidateTransferRelatedCaches();
            }

            final botMessage = MicroserviceChatMessageEntity(
              text: chatResponse.response,
              isUser: false,
              timestamp: DateTime.now(),
              serviceRoutedTo: chatResponse.serviceRoutedTo,
              metadata: messageMetadata.isEmpty ? null : messageMetadata,
            );
            _currentMessages.add(botMessage);

            emit(MicroserviceChatMessageSuccess(messages: List.from(_currentMessages)));
          },
        );
        return;
      }

      // Standard path (Python gateway) — clear entities since this path doesn't support round-tripping
      _entities = {};

      final result = await sendMessageUseCase(
        message: messageForAI,
        sessionId: _sessionId,
        userId: authState.profile.user.id,
        accessToken: '',
        sourceContext: sourceContext,
        language: 'en',
        locale: locale,
      );

      if (isClosed) return;
      result.fold(
        (failure) {
          emit(MicroserviceChatMessageError(
            errorMessage: failure.message,
            messages: List.from(_currentMessages),
          ));
        },
        (chatResponse) {
          // Extract transient receipt_data from entities (same pattern as direct path)
          final responseEntities = Map<String, dynamic>.from(chatResponse.entities);
          final receiptData = responseEntities.remove('_receipt_data');
          final quickActions = (responseEntities.remove('_quick_actions') as List?)
              ?.whereType<String>()
              .toList(growable: false);
          final billType = responseEntities['last_bill_type'] as String?;
          final lastPaymentId = responseEntities['last_payment_id'] as String?;
          // New chat protocol — pin_prompt + receipt_card sentinels.
          final pinPrompt = responseEntities.remove('_pin_prompt_pending');
          final receiptCard = responseEntities.remove('_receipt_card_pending');

          final messageMetadata = <String, dynamic>{};
          if (receiptData is Map<String, dynamic>) {
            messageMetadata['receipt_data'] = receiptData;
            _invalidateTransferRelatedCaches();
          }
          if (quickActions != null && quickActions.isNotEmpty) {
            messageMetadata['quick_actions'] = quickActions;
          }
          if (billType != null && billType.isNotEmpty) {
            messageMetadata['bill_type'] = billType;
          }
          if (lastPaymentId != null && lastPaymentId.isNotEmpty) {
            messageMetadata['last_payment_id'] = lastPaymentId;
          }
          if (pinPrompt is Map) {
            messageMetadata['pin_prompt'] =
                Map<String, dynamic>.from(pinPrompt);
          }
          if (receiptCard != null) {
            messageMetadata['receipt_card'] = receiptCard;
            _invalidateTransferRelatedCaches();
          }
          // AI "jump to message": the locate tool returns deterministic anchors
          // under the TRANSIENT `_jump_to_messages` key. Remove it (so it never
          // persists into a later turn and re-shows a stale "Show in chat") and
          // carry it (+ the conversation id) on THIS message only.
          final jumpAnchors = responseEntities.remove('_jump_to_messages');
          if (jumpAnchors is List && jumpAnchors.isNotEmpty) {
            messageMetadata['jump_to_messages'] = jumpAnchors;
            final cid = responseEntities['conversation_id'] ??
                _entities['conversation_id'];
            if (cid is String && cid.isNotEmpty) {
              messageMetadata['jump_conversation_id'] = cid;
            }
          }

          final botMessage = MicroserviceChatMessageEntity(
            text: chatResponse.response,
            isUser: false,
            timestamp: DateTime.now(),
            metadata: messageMetadata.isEmpty ? null : messageMetadata,
          );
          _currentMessages.add(botMessage);

          emit(MicroserviceChatMessageSuccess(messages: List.from(_currentMessages)));
        },
      );
    } finally {
      _isSending = false;
    }
  }

  /// Round-trip a PIN verification token back to the agent after the
  /// user tapped through the native modal (PinPromptIntent protocol).
  ///
  /// Used by the chat-pin-prompt-card widget. The raw PIN never enters
  /// the LLM context — the native modal hands us a single-use token
  /// that the chat-*-service's bound callback tool consumes via
  /// `extract_verification_token` and spends on the saga's
  /// /verify-pincode + execute endpoints.
  ///
  /// On the direct gRPC path the token + intent + args ride along in
  /// `entities` so the agent's tool reads them out of
  /// accumulated_entities. On the Python gateway path the gateway
  /// already moves these from request.metadata into outbound entities
  /// (see chat-agent-gateway/main.py).
  Future<void> submitPinVerification({
    required String verificationToken,
    required String callbackIntent,
    Map<String, dynamic> callbackArgs = const {},
  }) async {
    if (verificationToken.isEmpty || _isSending) return;
    _isSending = true;
    try {
      final authState = authCubit.state;
      if (authState is! AuthenticationSuccess) return;

      // No user bubble for the PIN submission — the user already
      // tapped through a native modal; another bubble would clutter.
      emit(MicroserviceChatMessageLoading(messages: List.from(_currentMessages)));

      final locale = serviceLocator<LocaleManager>().currentLocale;

      // Inject the protocol fields into the cubit's entities map so
      // the direct path (which forwards entities) carries them.
      final outboundEntities = <String, dynamic>{
        ..._entities,
        'pin_verification_token': verificationToken,
        'pin_callback_intent': callbackIntent,
        'pin_callback_args': callbackArgs,
      };

      if (isDirect && directMessageUseCase != null) {
        final result = await directMessageUseCase!(
          message: '__pin_verified__', // sentinel — agent recognises this
          sessionId: _sessionId,
          userId: authState.profile.user.id,
          accessToken: '',
          sourceContext: sourceContext,
          entities: outboundEntities,
          accountId: '',
          userCountry: authState.profile.user.country ?? '',
          currency: authState.profile.user.currency ?? '',
          language: 'en',
          locale: locale,
        );
        if (isClosed) return;
        result.fold(
          (failure) {
            emit(MicroserviceChatMessageError(
              errorMessage: failure.message,
              messages: List.from(_currentMessages),
            ));
          },
          (chatResponse) {
            // Re-use the same extraction path the regular sendMessage
            // walks — emit a bot message with extracted metadata.
            _entities = Map<String, dynamic>.from(chatResponse.entities);
            _entities.addAll(_scopeEntities); // keep conversation scope bound
            final receiptData = _entities.remove('_receipt_data');
            final receiptCard = _entities.remove('_receipt_card_pending');
            final pinPrompt = _entities.remove('_pin_prompt_pending');
            final messageMetadata = <String, dynamic>{};
            if (receiptData is Map<String, dynamic>) {
              messageMetadata['receipt_data'] = receiptData;
              _invalidateTransferRelatedCaches();
            }
            if (receiptCard != null) {
              messageMetadata['receipt_card'] = receiptCard;
              _invalidateTransferRelatedCaches();
            }
            if (pinPrompt is Map) {
              messageMetadata['pin_prompt'] =
                  Map<String, dynamic>.from(pinPrompt);
            }
            final botMessage = MicroserviceChatMessageEntity(
              text: chatResponse.response,
              isUser: false,
              timestamp: DateTime.now(),
              serviceRoutedTo: chatResponse.serviceRoutedTo,
              metadata: messageMetadata.isEmpty ? null : messageMetadata,
            );
            _currentMessages.add(botMessage);
            emit(MicroserviceChatMessageSuccess(
              messages: List.from(_currentMessages),
            ));
          },
        );
        return;
      }

      // Python gateway fallback path — sendMessageUseCase doesn't
      // accept entities today, so the token rides via the gateway's
      // request.metadata bridge (see chat-agent-gateway/main.py which
      // moves metadata.pin_verification_token into outbound entities).
      final result = await sendMessageUseCase(
        message: '__pin_verified__',
        sessionId: _sessionId,
        userId: authState.profile.user.id,
        accessToken: '',
        sourceContext: sourceContext,
        language: 'en',
        locale: locale,
      );
      if (isClosed) return;
      result.fold(
        (failure) {
          emit(MicroserviceChatMessageError(
            errorMessage: failure.message,
            messages: List.from(_currentMessages),
          ));
        },
        (chatResponse) {
          final responseEntities =
              Map<String, dynamic>.from(chatResponse.entities);
          final receiptCard = responseEntities.remove('_receipt_card_pending');
          final messageMetadata = <String, dynamic>{};
          if (receiptCard != null) {
            messageMetadata['receipt_card'] = receiptCard;
            _invalidateTransferRelatedCaches();
          }
          final botMessage = MicroserviceChatMessageEntity(
            text: chatResponse.response,
            isUser: false,
            timestamp: DateTime.now(),
            metadata: messageMetadata.isEmpty ? null : messageMetadata,
          );
          _currentMessages.add(botMessage);
          emit(MicroserviceChatMessageSuccess(
            messages: List.from(_currentMessages),
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

  /// Send a media message (image or voice note) through the Python gateway path.
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
      emit(MicroserviceChatMessageError(
        errorMessage: 'User not authenticated',
        messages: List.from(_currentMessages),
      ));
      return;
    }

    // Validate file exists and check size before reading into memory
    final file = File(localFilePath);
    if (!file.existsSync()) {
      emit(MicroserviceChatMessageError(
        errorMessage: 'The media file could not be found. Please try again.',
        messages: List.from(_currentMessages),
      ));
      return;
    }

    final fileSize = file.lengthSync();
    final maxSize = mediaType == 'image' ? _maxImageSize : _maxAudioSize;
    if (fileSize > maxSize) {
      final maxMB = maxSize ~/ (1024 * 1024);
      emit(MicroserviceChatMessageError(
        errorMessage: 'File is too large (max ${maxMB}MB). Please choose a smaller file.',
        messages: List.from(_currentMessages),
      ));
      return;
    }
    if (fileSize == 0) {
      emit(MicroserviceChatMessageError(
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
    final userMessage = MicroserviceChatMessageEntity(
      text: displayText,
      isUser: true,
      timestamp: DateTime.now(),
      mediaType: mediaType,
      localMediaPath: localFilePath,
      audioDurationMs: audioDurationMs,
    );
    _currentMessages.add(userMessage);
    emit(MicroserviceChatMessageLoading(messages: List.from(_currentMessages)));

    final locale = serviceLocator<LocaleManager>().currentLocale;

    // Always use standard (Python gateway) path for media
    final result = await sendMessageUseCase(
      message: text,
      sessionId: _sessionId,
      userId: authState.profile.user.id,
      accessToken: '',
      sourceContext: sourceContext,
      language: 'en',
      locale: locale,
      mediaBase64: base64Data,
      mediaType: mediaType,
      mediaMimeType: mimeType,
    );

    if (isClosed) return;
    result.fold(
      (failure) {
        emit(MicroserviceChatMessageError(
          errorMessage: failure.message,
          messages: List.from(_currentMessages),
        ));
      },
      (chatResponse) {
        // Extract transient receipt_data (same pattern as sendMessage)
        final responseEntities = Map<String, dynamic>.from(chatResponse.entities);
        final receiptData = responseEntities.remove('_receipt_data');
        final quickActions = (responseEntities.remove('_quick_actions') as List?)
            ?.whereType<String>()
            .toList(growable: false);
        final billType = responseEntities['last_bill_type'] as String?;
        final lastPaymentId = responseEntities['last_payment_id'] as String?;

        final messageMetadata = <String, dynamic>{};
        if (receiptData is Map<String, dynamic>) {
          messageMetadata['receipt_data'] = receiptData;
          _invalidateTransferRelatedCaches();
        }
        if (quickActions != null && quickActions.isNotEmpty) {
          messageMetadata['quick_actions'] = quickActions;
        }
        if (billType != null && billType.isNotEmpty) {
          messageMetadata['bill_type'] = billType;
        }
        if (lastPaymentId != null && lastPaymentId.isNotEmpty) {
          messageMetadata['last_payment_id'] = lastPaymentId;
        }

        final botMessage = MicroserviceChatMessageEntity(
          text: chatResponse.response,
          isUser: false,
          timestamp: DateTime.now(),
          metadata: messageMetadata.isEmpty ? null : messageMetadata,
        );
        _currentMessages.add(botMessage);
        emit(MicroserviceChatMessageSuccess(messages: List.from(_currentMessages)));
      },
    );
    } finally {
      _isSending = false;
    }
  }

  /// Invalidate caches that may be stale after a successful chatbot transfer.
  /// Called when receipt_data is present (indicates a transfer completed and
  /// may have auto-saved a new recipient).
  void _invalidateTransferRelatedCaches() {
    try {
      final cacheManager = serviceLocator<SWRCacheManager>();
      cacheManager.invalidatePattern('recipients:');
      cacheManager.invalidatePattern('accounts:');
      cacheManager.invalidatePattern('transactions:');
    } catch (_) {
      // Cache manager may not be registered; non-blocking
    }
  }

  /// Prepend the swipe-to-reply quote as an explicit context preamble so the
  /// AI's reply is grounded in the referenced message. The send paths carry a
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
    _entities = {};
    _isSending = false;
    emit(MicroserviceChatInitial(messages: _currentMessages));
  }
}
