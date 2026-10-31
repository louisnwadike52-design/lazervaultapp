import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/core/chat/chat_history_page.dart';
import 'package:lazervault/src/core/errors/failures.dart';
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

  /// Messages per history page — the initial load and each scroll-up
  /// "load older".
  ///
  /// The per-service chat had NO pagination: both datasources hardcoded
  /// `limit: 50, offset: 0`, so a conversation longer than 50 messages showed
  /// one page and the rest was unreachable. Worse, the Go gateway ordered that
  /// page `created_at ASC`, so the one page you got was the OLDEST fifty —
  /// open a long service chat and you were reading the start of the
  /// conversation with the recent turns nowhere to be found.
  static const int historyPageSize = 30;

  /// Keyset cursor for the next OLDER page, '' at the start of the thread.
  ///
  /// A cursor rather than an offset because the window shifts: a message
  /// arriving while the user is scrolled up moves every row one position, so
  /// an offset page would start one row late and silently drop a message out
  /// of the middle of the history.
  String _nextBefore = '';

  /// Whether an older page exists. The SERVER answers this, from a probe row.
  bool _hasMoreHistory = false;
  bool get hasMoreHistory => _hasMoreHistory;

  /// Re-entrancy guard so a burst of scroll events fires at most one fetch.
  bool _isLoadingOlder = false;
  bool get isLoadingOlder => _isLoadingOlder;

  /// The conversation this cubit is bound to. Exposed read-only so the chat
  /// surface can scope per-answer feedback to it — a verdict with no session
  /// cannot be stored, and one stored against the wrong session trains on
  /// the wrong exchange.
  String get sessionId => _sessionId;

  /// Re-keys the conversation when the user switches REGION.
  ///
  /// Same reason as GeneralChatCubit: the session id embeds the locale and
  /// the gateway filters history by it, but a service chat held open across a
  /// region switch kept the old id and the old messages on screen. A sheet
  /// re-opened after the switch was always fine — it is the live one that
  /// lied.
  StreamSubscription<String>? _localeSub;

  /// The deterministic id for the CURRENT region, used to detect a switch.
  String _sessionIdForCurrentLocale() {
    final locale = serviceLocator<LocaleManager>().currentLocale;
    final authState = authCubit.state;
    final prefix = isDirect ? 'direct' : 'svc';
    final scope = (sessionScopeId != null && sessionScopeId!.isNotEmpty)
        ? '_${sessionScopeId!}'
        : '';
    if (authState is AuthenticationSuccess) {
      return '${prefix}_${authState.profile.user.id}_${sourceContext}$scope\_$locale';
    }
    return '${prefix}_unknown_${sourceContext}$scope\_$locale';
  }

  void _watchLocaleChanges() {
    _localeSub?.cancel();
    try {
      _localeSub = serviceLocator<LocaleManager>().localeStream.listen((_) {
        if (isClosed) return;
        final rekeyed = _sessionIdForCurrentLocale();
        if (rekeyed == _sessionId) return;
        _sessionId = rekeyed;
        _currentMessages = [];
        // The cursor points into the OLD conversation. Left behind, the first
        // scroll-up after a region switch would prepend a page of a thread the
        // user has just navigated away from.
        _resetPaging();
        emit(MicroserviceChatInitial(messages: _currentMessages));
        loadHistory();
      });
    } catch (_) {
      // LocaleManager unresolvable (early startup, a widget test).
    }
  }

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
    // Only a DERIVED id can be re-keyed on a region switch. An explicitly
    // supplied persistentSessionId is the caller's own scope (a P2P thread,
    // a resumed tab) and is left alone.
    if (persistentSessionId == null) _watchLocaleChanges();
    _currentMessages = [];
    // Seed scoped context (P2P conversation id / peer) so it round-trips to the
    // agent as entities from the very first message.
    _entities =
        seedEntities != null ? Map<String, dynamic>.from(seedEntities!) : {};
    // Capture the seed as immutable scope so it survives the agent's
    // replace-every-turn entity ownership (see [_scopeEntities]).
    _scopeEntities =
        seedEntities != null ? Map<String, dynamic>.from(seedEntities!) : {};
    _isSending = false;
    emit(MicroserviceChatInitial(messages: _currentMessages));
  }

  /// Load the NEWEST page of history.
  Future<void> loadHistory() async {
    emit(MicroserviceChatHistoryLoading(messages: _currentMessages));

    final locale = serviceLocator<LocaleManager>().currentLocale;
    final result = await _fetchHistoryPage(locale: locale);
    if (result == null || isClosed) return;

    result.fold(
      (failure) {
        emit(MicroserviceChatInitial(messages: _currentMessages));
      },
      (page) {
        _currentMessages = page.messages;
        _hasMoreHistory = page.canLoadOlder;
        _nextBefore = page.nextBefore;
        // A fresh load invalidates any load-older still in flight; the cursor
        // check in loadOlderHistory drops that page when it lands.
        _isLoadingOlder = false;
        if (_currentMessages.isEmpty) {
          emit(MicroserviceChatInitial(messages: _currentMessages));
        } else {
          emit(MicroserviceChatMessageSuccess(
              messages: List.from(_currentMessages)));
        }
      },
    );
  }

  /// Fetch the next OLDER page and PREPEND it.
  ///
  /// Prior history is preserved — older messages are prepended, never
  /// replacing what is already on screen.
  Future<void> loadOlderHistory() async {
    if (isClosed || _isLoadingOlder || !_hasMoreHistory) return;
    // No cursor means the first page has not landed, or the thread has reached
    // its start. Asking without one would re-fetch the NEWEST page and prepend
    // a duplicate of what is already on screen.
    if (_nextBefore.isEmpty) {
      _hasMoreHistory = false;
      return;
    }
    _isLoadingOlder = true;

    final locale = serviceLocator<LocaleManager>().currentLocale;
    // Capture the session AND the cursor: either can change during the await
    // (a region switch re-keys the session, a reload moves the cursor), and
    // prepending a page from a different point in a different conversation is
    // worse than not prepending at all.
    final sessionAtStart = _sessionId;
    final cursorAtStart = _nextBefore;

    final result = await _fetchHistoryPage(
      locale: locale,
      before: cursorAtStart,
    );
    if (result == null || isClosed) {
      _isLoadingOlder = false;
      return;
    }
    if (_sessionId != sessionAtStart || _nextBefore != cursorAtStart) {
      _isLoadingOlder = false;
      return;
    }

    result.fold(
      (failure) {
        // Leave loaded history intact; scrolling up again retries.
        _isLoadingOlder = false;
      },
      (page) {
        if (page.messages.isNotEmpty) {
          _currentMessages = [...page.messages, ..._currentMessages];
        }
        _hasMoreHistory = page.canLoadOlder;
        _nextBefore = page.nextBefore;
        _isLoadingOlder = false;
        emit(MicroserviceChatMessageSuccess(
            messages: List.from(_currentMessages)));
      },
    );
  }

  /// One fetch, whichever path this cubit is on.
  ///
  /// Returns null when no use case is wired for the active path — the caller
  /// then leaves the state alone, exactly as the old code did by returning
  /// early.
  Future<Either<Failure, ChatHistoryPage<MicroserviceChatMessageEntity>>?>
      _fetchHistoryPage({
    required String locale,
    String? before,
  }) async {
    if (isDirect && loadDirectHistoryUseCase != null) {
      return loadDirectHistoryUseCase!.page(
        sourceContext: sourceContext,
        sessionId: _sessionId,
        accessToken: '',
        locale: locale,
        limit: historyPageSize,
        before: before,
      );
    }
    if (loadHistoryUseCase == null) return null;
    return loadHistoryUseCase!.page(
      sourceContext: sourceContext,
      sessionId: _sessionId,
      accessToken: '',
      locale: locale,
      limit: historyPageSize,
      before: before,
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

      emit(MicroserviceChatMessageLoading(
          messages: List.from(_currentMessages)));

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
            // next round-trip doesn't re-send. Shared with the media path.
            final messageMetadata = _drainSentinelMetadata(_entities);
            // Degradation chrome, matching the general chat: the same LLM
            // failure must explain itself here too rather than leaving the
            // fallback sentence looking like an ordinary answer.
            if ((chatResponse.llmErrorCode ?? '').isNotEmpty) {
              messageMetadata['llm_error_code'] = chatResponse.llmErrorCode;
            }
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
              serviceRoutedTo: chatResponse.serviceRoutedTo,
              metadata: messageMetadata.isEmpty ? null : messageMetadata,
            );
            _currentMessages.add(botMessage);

            emit(MicroserviceChatMessageSuccess(
                messages: List.from(_currentMessages)));
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
          final responseEntities =
              Map<String, dynamic>.from(chatResponse.entities);
          final receiptData = responseEntities.remove('_receipt_data');
          final quickActions =
              (responseEntities.remove('_quick_actions') as List?)
                  ?.whereType<String>()
                  .toList(growable: false);
          final billType = responseEntities['last_bill_type'] as String?;
          final lastPaymentId = responseEntities['last_payment_id'] as String?;
          // New chat protocol — pin_prompt + receipt_card sentinels, drained
          // through the shared helper so every branch carries the same set.
          final messageMetadata = _drainSentinelMetadata(responseEntities);
          // Degradation chrome, matching the general chat: the same LLM
          // failure must explain itself here too rather than leaving the
          // fallback sentence looking like an ordinary answer.
          if ((chatResponse.llmErrorCode ?? '').isNotEmpty) {
            messageMetadata['llm_error_code'] = chatResponse.llmErrorCode;
          }
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

          emit(MicroserviceChatMessageSuccess(
              messages: List.from(_currentMessages)));
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
      emit(MicroserviceChatMessageLoading(
          messages: List.from(_currentMessages)));

      final localeManager = serviceLocator<LocaleManager>();
      final locale = localeManager.currentLocale;

      // THE CONFIRM TURN IS THE ONE THAT MOVES THE MONEY, so it has to carry
      // the same active-account scope as the turns before it. This sent
      // accountId: '' with the USER PROFILE's country and currency — the exact
      // defect that was fixed for the ordinary send path (see the block around
      // `activeAccountId` above) and left in place here, on the most important
      // call site of all. An empty account id makes the agent resolve a source
      // account on its own, and a profile currency formats and validates a GBP
      // transfer in the profile's currency.
      final activeAccountId =
          serviceLocator<AccountManager>().activeAccountId ?? '';
      final activeCountry = localeManager.currentCountry.isNotEmpty
          ? localeManager.currentCountry
          : (authState.profile.user.country ?? '');
      final activeCurrency = localeManager.currentCurrency.isNotEmpty
          ? localeManager.currentCurrency
          : (authState.profile.user.currency ?? '');

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
            // Re-use the same extraction path the regular sendMessage
            // walks — emit a bot message with extracted metadata.
            _entities = Map<String, dynamic>.from(chatResponse.entities);
            _entities.addAll(_scopeEntities); // keep conversation scope bound
            final receiptData = _entities.remove('_receipt_data');
            final messageMetadata = _drainSentinelMetadata(_entities);
            // Degradation chrome, matching the general chat: the same LLM
            // failure must explain itself here too rather than leaving the
            // fallback sentence looking like an ordinary answer.
            if ((chatResponse.llmErrorCode ?? '').isNotEmpty) {
              messageMetadata['llm_error_code'] = chatResponse.llmErrorCode;
            }
            if (receiptData is Map<String, dynamic>) {
              messageMetadata['receipt_data'] = receiptData;
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
          // This branch drained four sentinels and NOT `_pin_prompt_pending`
          // or `_pin_setup_pending`, so a PIN round-trip that came back asking
          // for another PIN — the next leg of a batch, or a re-ask after a
          // declined token — showed no sheet and stranded the user mid-flow.
          final messageMetadata = _drainSentinelMetadata(responseEntities);
          // Degradation chrome, matching the general chat: the same LLM
          // failure must explain itself here too rather than leaving the
          // fallback sentence looking like an ordinary answer.
          if ((chatResponse.llmErrorCode ?? '').isNotEmpty) {
            messageMetadata['llm_error_code'] = chatResponse.llmErrorCode;
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
          errorMessage:
              'File is too large (max ${maxMB}MB). Please choose a smaller file.',
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
      emit(MicroserviceChatMessageLoading(
          messages: List.from(_currentMessages)));

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
          // Mirror sendMessage exactly. This path used to build a LOCAL copy
          // of the response entities and leave `_entities` untouched, so a
          // voice note or photo turn dropped the accumulated conversation
          // state — the recipient and amount the agent had just confirmed
          // were gone by the next turn.
          //
          // REPLACE, not merge — the agent is the source of truth, and it
          // clears state deliberately after a completed operation.
          _entities = Map<String, dynamic>.from(chatResponse.entities);
          // Re-apply the immutable scope: the agent may omit conversation_id /
          // peer_user_id, but the assistant must stay bound to this
          // conversation on the next turn.
          _entities.addAll(_scopeEntities);

          final receiptData = _entities.remove('_receipt_data');
          final quickActions = (_entities.remove('_quick_actions') as List?)
              ?.whereType<String>()
              .toList(growable: false);
          final billType = _entities['last_bill_type'] as String?;
          final lastPaymentId = _entities['last_payment_id'] as String?;

          // The protocol sentinels — above all `_pin_prompt_pending`, which
          // this path dropped entirely, so a media-started money move could
          // never open the PIN sheet.
          final messageMetadata = _drainSentinelMetadata(_entities);
          // Degradation chrome, matching the general chat: the same LLM
          // failure must explain itself here too rather than leaving the
          // fallback sentence looking like an ordinary answer.
          if ((chatResponse.llmErrorCode ?? '').isNotEmpty) {
            messageMetadata['llm_error_code'] = chatResponse.llmErrorCode;
          }
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
          emit(MicroserviceChatMessageSuccess(
              messages: List.from(_currentMessages)));
        },
      );
    } finally {
      _isSending = false;
    }
  }

  /// Drain the `*_pending` protocol sentinels out of [entities] into message
  /// metadata, stripping them so the next round-trip cannot re-send them.
  ///
  /// WHY THIS IS SHARED — it is a money fix, not a refactor.
  ///
  /// `sendMessage` drained all six sentinels; `sendMediaMessage` drained none.
  /// So a transfer begun with a VOICE NOTE or a PHOTO lost `_pin_prompt_pending`
  /// and the PIN sheet could never open: the card reads
  /// `metadata['pin_prompt']`, and with no card in the tree
  /// `ChatPinPromptCard.autoOpenFor` had nothing to drive. The agent still said
  /// "enter your PIN to confirm" — the server HAD minted the prompt — so the
  /// transfer looked stuck while every layer reported success.
  ///
  /// Both paths now drain through here, so a sentinel added for one is
  /// honoured by the other.
  Map<String, dynamic> _drainSentinelMetadata(Map<String, dynamic> entities) {
    final out = <String, dynamic>{};
    final pinPrompt = entities.remove('_pin_prompt_pending');
    final pinSetup = entities.remove('_pin_setup_pending');
    final receiptCard = entities.remove('_receipt_card_pending');
    final recipientCard = entities.remove('_recipient_card_pending');
    final analyticsCard = entities.remove('_analytics_card_pending');
    final qrCard = entities.remove('_qr_card_pending');

    if (pinPrompt is Map) {
      out['pin_prompt'] = Map<String, dynamic>.from(pinPrompt);
    }
    // The PIN-setup hand-off rides the same rail, so it lands in message
    // metadata and therefore survives in history — a card the user scrolls
    // back to still works.
    if (pinSetup is Map) {
      out['pin_setup'] = Map<String, dynamic>.from(pinSetup);
    }
    if (receiptCard != null) {
      out['receipt_card'] = receiptCard;
      _invalidateTransferRelatedCaches();
    }
    if (recipientCard is Map) {
      out['recipient_card'] = Map<String, dynamic>.from(recipientCard);
    }
    if (analyticsCard is Map) {
      out['analytics_card'] = Map<String, dynamic>.from(analyticsCard);
    }
    // A QR is the one answer that cannot be delivered as text, and the
    // agent's reply already says to share it from the card.
    if (qrCard is Map) {
      out['qr_card'] = Map<String, dynamic>.from(qrCard);
    }
    return out;
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
    final capped =
        quoted.length > 600 ? '${quoted.substring(0, 600)}…' : quoted;
    final author = fromUser ? 'the user' : 'the assistant';
    return 'Replying to $author\'s earlier message: "$capped"\n\n$userText';
  }

  void clearChat() {
    _currentMessages = [];
    _entities = {};
    _isSending = false;
    _resetPaging();
    emit(MicroserviceChatInitial(messages: _currentMessages));
  }

  /// Forget where we were in the history.
  ///
  /// Must happen wherever [_currentMessages] is emptied: a cursor outlives the
  /// messages it was derived from, and one left behind names a position in a
  /// conversation that is no longer on screen.
  void _resetPaging() {
    _nextBefore = '';
    _hasMoreHistory = false;
    _isLoadingOlder = false;
  }

  /// Cancel the region watcher so a closed sheet's cubit stops reacting to
  /// locale switches (and stops holding a reference to itself).
  @override
  Future<void> close() async {
    await _localeSub?.cancel();
    return super.close();
  }
}
