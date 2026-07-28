import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lazervault/core/services/account_manager.dart';
import 'package:lazervault/core/services/chat_sound_settings.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/locale_manager.dart';
import 'package:lazervault/core/services/pending_chat_transfers.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:lazervault/src/core/grpc/accounts_grpc_client.dart';
import 'package:lazervault/src/features/p2p_chat/data/services/p2p_chat_media_upload_service.dart';
import 'package:lazervault/src/features/p2p_chat/domain/entities/p2p_message_entity.dart';
import 'package:lazervault/src/features/p2p_chat/domain/repositories/p2p_chat_repository.dart';
import 'package:lazervault/src/features/p2p_chat/presentation/cubit/p2p_chat_snapshot_cache.dart';
import 'package:lazervault/src/features/p2p_chat/presentation/cubit/p2p_chat_state.dart';
import 'package:lazervault/src/features/p2p_chat/presentation/cubit/p2p_conversations_cubit.dart';
import 'package:lazervault/src/features/p2p_chat/services/p2p_chat_websocket_service.dart';
import 'package:uuid/uuid.dart';

class P2PChatCubit extends Cubit<P2PChatState> {
  final P2PChatRepository _repository;
  final P2PChatWebSocketService _wsService;
  final SecureStorageService _secureStorage;
  final AccountsGrpcClient _accountsClient;
  final AccountManager _accountManager;
  final LocaleManager _localeManager;
  // MUST use the DI-configured FlutterSecureStorage singleton (Android:
  // EncryptedSharedPreferences). A bare `P2PChatMediaUploadService()` falls back
  // to `const FlutterSecureStorage()` (default Android keystore-backed store) and
  // reads a DIFFERENT store than where the access_token was written → null token
  // → media upload aborts with "You must be signed in" (silently → bubble goes
  // "failed"). This broke ALL P2P image AND voice-note sends on Android. See the
  // secure-storage-single-instance rule.
  final P2PChatMediaUploadService _mediaUploadService =
      P2PChatMediaUploadService(storage: serviceLocator<FlutterSecureStorage>());
  String _currentUserId;

  /// The authoritative current-user id used to stamp outgoing messages'
  /// `senderId`. The UI MUST align bubbles on THIS value (not a separately
  /// derived id) so optimistic + server-echoed messages render on the same
  /// side. This is the JWT/profile identity (the same id the backend stamps
  /// onto `sender_id`); it only falls back to secure storage when the caller
  /// constructed the cubit without one.
  String get currentUserId => _currentUserId;

  StreamSubscription? _messageSubscription;
  StreamSubscription? _deliverySubscription;
  StreamSubscription? _readReceiptSubscription;
  StreamSubscription? _messageSentSubscription;
  StreamSubscription? _connectionSubscription;
  StreamSubscription? _connectionAcceptedSubscription;
  StreamSubscription? _serverErrorSubscription;
  StreamSubscription? _editedSubscription;
  StreamSubscription? _reactionSubscription;
  String? _conversationId;
  String? _otherUserId;
  String _otherUserName = '';
  int _currentPage = 1;
  static const int _pageSize = 50;
  // Cursor-pagination page size for the conversation view (initial open AND
  // each scroll-up "load older" fetch). MUST match the `limit` passed to
  // getMessagesPage so the "hasMore" heuristic (a full page came back ⇒ there
  // may be more) is correct — a mismatch (initial limit 30 vs a `>= 50` check)
  // silently pinned hasMore=false and made scroll-up load nothing.
  static const int _cursorPageSize = 30;

  P2PChatCubit({
    required P2PChatRepository repository,
    required P2PChatWebSocketService wsService,
    required SecureStorageService secureStorage,
    required AccountsGrpcClient accountsClient,
    required AccountManager accountManager,
    required LocaleManager localeManager,
    required String currentUserId,
  })  : _repository = repository,
        _wsService = wsService,
        _secureStorage = secureStorage,
        _accountsClient = accountsClient,
        _accountManager = accountManager,
        _localeManager = localeManager,
        _currentUserId = currentUserId,
        super(P2PChatInitial()) {
    // Provide fresh token for WebSocket reconnection
    _wsService.onTokenRefresh = () => _secureStorage.getAccessToken();
  }

  /// Initialize chat with another user.
  ///
  /// [currentUserId] is the caller's authoritative JWT/profile identity
  /// (`profile.userId`). When provided it is used to stamp outgoing messages'
  /// `senderId` AND should be the value the UI aligns bubbles on (via
  /// [currentUserId] getter) — guaranteeing optimistic + server-echoed
  /// messages render on the same side on BOTH participants' devices. It must
  /// match the JWT id the backend stamps onto `sender_id`. Falls back to
  /// secure storage only when neither the constructor nor this param supply one.
  Future<void> initializeChat(
    String otherUserId, {
    String? otherUserName,
    String? otherUserAvatar,
    String? myName,
    String? myAvatar,
    bool isSavedRecipient = false,
    String? currentUserId,
  }) async {
    // Prefer the authoritative JWT/profile id passed by the caller so the id we
    // stamp on outgoing messages is identical to the one the UI aligns on (and
    // to the one the backend echoes as sender_id). Never let a possibly-stale
    // secure-storage value win over it.
    if (currentUserId != null && currentUserId.isNotEmpty) {
      _currentUserId = currentUserId;
    }

    // If currentUserId still wasn't available (e.g. factory DI with no caller
    // value), fall back to secure storage as a last resort.
    if (_currentUserId.isEmpty) {
      final storedUserId = await _secureStorage.getUserId();
      if (storedUserId != null && storedUserId.isNotEmpty) {
        _currentUserId = storedUserId;
      } else {
        emit(P2PChatError(message: 'Not authenticated'));
        return;
      }
    }

    if (otherUserId.isEmpty) {
      emit(P2PChatError(
          message:
              'Unable to start chat. The recipient\'s user ID could not be resolved.'));
      return;
    }

    // Guard against malformed ids (a saved-recipient field that isn't a real
    // Lazervault user UUID) and self-chats before firing a doomed request.
    if (!_isUuid(otherUserId)) {
      emit(P2PChatError(
          message:
              'This contact isn\'t a Lazervault user yet, so chat isn\'t available.'));
      return;
    }
    if (otherUserId == _currentUserId) {
      emit(P2PChatError(message: 'You can\'t start a chat with yourself.'));
      return;
    }

    _otherUserId = otherUserId;
    _otherUserName = otherUserName ?? _otherUserName;

    // INSTANT RESUME: if we have a cached snapshot for this peer, paint it
    // immediately (no full-screen spinner / blank) and refresh silently in the
    // background below. Only a cold first open shows the loading state. This is
    // what removes the "entire reload every time you go back and forth".
    final cachedSnapshot = P2PChatSnapshotCache.instance.get(otherUserId);
    final snapshotAge = P2PChatSnapshotCache.instance.ageOf(otherUserId);
    if (cachedSnapshot != null) {
      _conversationId = cachedSnapshot.conversationId;
      _currentPage = 1;
      emit(cachedSnapshot);
    } else {
      emit(P2PChatLoading());
    }

    try {
      // Connect WebSocket if not already connected
      await _ensureWebSocketConnected();

      final conversation = await _repository.getOrCreateConversation(
        otherUserId,
        otherUserName: otherUserName,
        otherUserAvatar: otherUserAvatar,
        myName: myName,
        myAvatar: myAvatar,
        isSavedRecipient: isSavedRecipient,
      );
      _conversationId = conversation.id;
      // Tell the global badge which conversation is open, so a live message for
      // it doesn't double-bump the badge (this chat marks it read itself).
      try {
        serviceLocator<P2PConversationsCubit>()
            .setOpenConversation(conversation.id);
      } catch (_) {}
      // Tell the SERVER we're viewing this chat so an inbound message doesn't
      // fire a redundant push while it's on screen (per-conversation presence).
      _wsService.sendFocus(conversation.id);

      // Load the LATEST page only (cursor pagination). A small initial page
      // keeps open-latency low and avoids scanning the whole thread; older
      // messages stream in as the user scrolls up (loadOlderMessages).
      final messages = await _repository.getMessagesPage(conversation.id,
          limit: _cursorPageSize);

      // Determine if user can send messages based on connection status
      final canSend = _computeCanSend(
        conversation.connectionStatus,
        conversation.initiatedBy,
        messages.length,
      );

      // Listen for WebSocket connection state changes
      _connectionSubscription?.cancel();
      _connectionSubscription = _wsService.connectionState.listen((connState) {
        final current = state;
        if (current is P2PChatLoaded) {
          _safeEmit(current.copyWith(connectionState: connState));
        }
        // Auto-reconnect if disconnected unexpectedly
        if (connState == P2PChatConnectionState.disconnected) {
          _ensureWebSocketConnected();
        }
        // Re-assert viewing focus after a reconnect so the server keeps
        // suppressing redundant pushes while this chat is on screen.
        if (connState == P2PChatConnectionState.connected &&
            _conversationId != null) {
          _wsService.sendFocus(_conversationId!);
        }
      });

      // Listen for connection_accepted events
      _connectionAcceptedSubscription?.cancel();
      _connectionAcceptedSubscription =
          _wsService.connectionAcceptedStream.listen((event) {
        if (event['conversation_id'] == _conversationId) {
          final current = state;
          if (current is P2PChatLoaded) {
            _safeEmit(current.copyWith(
              connectionStatus: 'accepted',
              canSendMessage: true,
            ));
          }
        }
      });

      // Listen for server errors (e.g., CONNECTION_PENDING via WebSocket)
      _serverErrorSubscription?.cancel();
      _serverErrorSubscription = _wsService.serverErrorStream.listen((error) {
        final code = error['code'] as String?;
        if (code == 'CONNECTION_PENDING') {
          final current = state;
          if (current is P2PChatLoaded) {
            _safeEmit(current.copyWith(canSendMessage: false));
          }
        }
      });

      // Listen for new WebSocket messages
      _messageSubscription?.cancel();
      _messageSubscription = _wsService.messageStream.listen((message) {
        if (message.conversationId == _conversationId) {
          final added = _addMessage(message);

          // Auto-mark as read if from other user
          if (message.senderId != _currentUserId) {
            // Incoming-message tone + haptic (honoring per-chat/global setting).
            // Only when actually appended, so a duplicate WS delivery of the
            // same message never double-buzzes.
            if (added) {
              ChatSoundSettings.instance.playReceiveFeedback(_conversationId);
            }
            try {
              _repository.markRead(_conversationId!, message.id);
              _wsService.markRead(_conversationId!, message.id);
              _refreshConversationsCubit();
            } catch (_) {
              // Silently handle mark-read failures
            }
          }
        }
      });

      // Listen for delivery status updates
      _deliverySubscription?.cancel();
      _deliverySubscription = _wsService.deliveryStream.listen((update) {
        _updateDeliveryStatus(update.messageId, update.status);
      });

      // Listen for read receipts
      _readReceiptSubscription?.cancel();
      _readReceiptSubscription =
          _wsService.readReceiptStream.listen((receipt) {
        if (receipt.conversationId == _conversationId) {
          _updateDeliveryStatus(receipt.messageId, 'read');
        }
      });

      // Listen for message sent confirmations
      _messageSentSubscription?.cancel();
      _messageSentSubscription =
          _wsService.messageSentStream.listen((confirmation) {
        if (confirmation.conversationId == _conversationId) {
          _handleMessageSentConfirmation(confirmation);
        }
      });

      // Live edits from the other party (or this user's other devices).
      _editedSubscription?.cancel();
      _editedSubscription = _wsService.editedStream.listen((edited) {
        if (edited.conversationId == _conversationId) {
          _applyEditedMessage(edited);
        }
      });

      // Live reaction changes.
      _reactionSubscription?.cancel();
      _reactionSubscription = _wsService.reactionStream.listen((ev) {
        if (ev.conversationId == _conversationId) {
          _applyReactions(ev.messageId, ev.reactions);
        }
      });

      // Merge transfer history from accounts-service (best-effort, non-blocking)
      // First, deduplicate legacy transfer_sent/transfer_received pairs from backend
      final chatMessages = _deduplicateLegacyTransfers(messages.reversed.toList());
      List<P2PMessageEntity> allMessages = chatMessages;
      try {
        // On a FRESH re-open (snapshot < 30s) reuse the cached transfer rows
        // instead of re-hitting the transaction-history gRPC — the biggest
        // per-open cost. Cold opens (or stale snapshots) refetch as before.
        final bool reuseCachedTransfers = cachedSnapshot != null &&
            snapshotAge != null &&
            snapshotAge < const Duration(seconds: 30);
        final List<P2PMessageEntity> transferMessages = reuseCachedTransfers
            ? cachedSnapshot.messages.where((m) => m.isTransfer).toList()
            : await _fetchTransfersWithUser(otherUserId, otherUserName);
        if (transferMessages.isNotEmpty) {
          // Deduplicate: skip transfers already present as chat transfer messages
          // Normalize refs by stripping "-recv" suffix for comparison
          final existingRefs = chatMessages
              .where((m) => m.isTransfer && m.transferRef != null)
              .map((m) => _baseTransferRef(m.transferRef!))
              .toSet();
          final newTransfers = transferMessages
              .where((t) => t.transferRef == null || !existingRefs.contains(_baseTransferRef(t.transferRef!)))
              .toList();
          allMessages = [...chatMessages, ...newTransfers];
          allMessages.sort((a, b) => a.createdAt.compareTo(b.createdAt));
        }
      } catch (e) {
        debugPrint('P2PChatCubit: Failed to fetch transfers: $e');
      }

      // Inject any just-completed local transfers so the money bubble shows
      // immediately on open (independent of the history fetch above, which may
      // be skipped by the 30s snapshot reuse or lag behind the send).
      allMessages =
          _injectPendingTransfers(allMessages, otherUserId, conversation.id);

      // Mark all messages as read when opening the conversation
      // Find the last message from the other user and mark it as read
      _markConversationAsRead(allMessages);

      final loaded = P2PChatLoaded(
        messages: allMessages,
        conversationId: conversation.id,
        // A full initial page came back ⇒ there may be older messages to load
        // on scroll-up. (Was `>= _pageSize` (50) while only 30 were fetched, so
        // it was always false and scroll-up never paged.)
        hasMore: messages.length >= _cursorPageSize,
        connectionState: _wsService.isConnected
            ? P2PChatConnectionState.connected
            : P2PChatConnectionState.disconnected,
        connectionStatus: conversation.connectionStatus,
        initiatedBy: conversation.initiatedBy,
        canSendMessage: canSend,
        safetyWarning: conversation.safetyWarning,
        safetyWarningReason: conversation.safetyWarningReason,
      );
      emit(loaded);
      // Cache the freshly-loaded state so the next open of this peer paints
      // instantly instead of cold-reloading.
      P2PChatSnapshotCache.instance.put(otherUserId, loaded);
    } catch (e) {
      final errorMsg = e.toString();
      if (errorMsg.contains('Unauthorized') || errorMsg.contains('401')) {
        emit(P2PChatError(message: 'Session expired. Please log in again.'));
      } else if (errorMsg.contains('SocketException') ||
          errorMsg.contains('Connection refused') ||
          errorMsg.contains('TimeoutException')) {
        emit(P2PChatError(
            message: 'Chat service is unavailable. Please try again later.'));
      } else if (errorMsg.contains('yourself')) {
        emit(P2PChatError(message: 'You can\'t start a chat with yourself.'));
      } else if (errorMsg.contains('invalid other_user_id') ||
          errorMsg.contains('other_user_id is required')) {
        emit(P2PChatError(
            message:
                'This contact isn\'t a Lazervault user yet, so chat isn\'t available.'));
      } else {
        emit(P2PChatError(message: 'Failed to load chat. Please try again.'));
      }
    }
  }

  static final RegExp _uuidRe = RegExp(
      r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$');

  bool _isUuid(String s) => _uuidRe.hasMatch(s.trim());

  bool _computeCanSend(String connectionStatus, String? initiatedBy, int messageCount) {
    if (connectionStatus == 'accepted') return true;
    // Pending: initiator can send 1 message only
    if (initiatedBy == _currentUserId) {
      return messageCount == 0;
    }
    // Recipient can always reply (auto-accepts)
    return true;
  }

  /// Connect WebSocket with stored auth token.
  Future<void> _ensureWebSocketConnected() async {
    if (_wsService.isConnected) return;
    try {
      final token = await _secureStorage.getAccessToken();
      if (token != null && token.isNotEmpty) {
        await _wsService.connect(token);
      }
    } catch (_) {
      // WebSocket failure is non-fatal — REST fallback will handle messages
    }
  }

  /// Mark all unread messages in the conversation as read.
  /// Finds the last message from the other user and marks up to it as read.
  Future<void> _markConversationAsRead(List<P2PMessageEntity> messages) async {
    if (_conversationId == null) return;

    // Optimistically drop this conversation from the app badge NOW, so opening
    // the chat clears the badge instantly regardless of the network round-trip.
    try {
      serviceLocator<P2PConversationsCubit>()
          .markConversationReadLocally(_conversationId!);
    } catch (_) {}

    // Find the last message sent by the other user (the last-read pointer).
    // IMPORTANT: only consider REAL chat messages (UUID id). `allMessages` is
    // merged with synthetic transfer rows from _fetchTransfersWithUser() whose
    // ids are `transfer_<txid>` (not UUIDs). In a financial connection the newest
    // inbound "message" is often a received transfer — posting its fake id to
    // markRead makes the backend uuid.Parse fail (400) so unread_count is never
    // zeroed and the per-tile badge never clears.
    P2PMessageEntity? lastOtherMessage;
    for (int i = messages.length - 1; i >= 0; i--) {
      final m = messages[i];
      if (m.senderId != _currentUserId && _isUuid(m.id)) {
        lastOtherMessage = m;
        break;
      }
    }

    try {
      // ALWAYS mark the conversation read server-side. When a real (UUID)
      // inbound message exists, pass its id so the backend also advances the
      // read pointer + flips delivery receipts; otherwise (transfer-only
      // threads, whose newest inbound row is a synthetic `transfer_<txid>`)
      // mark read at the CONVERSATION level — the backend zeroes unread_count
      // either way. Previously this branch was skipped entirely when no UUID
      // message was found, so the server count never cleared and the follow-up
      // refresh reverted the optimistic badge drop. AWAIT it so the sequenced
      // refresh reads the committed (zeroed) count, not the pre-markRead value.
      await _repository.markRead(_conversationId!, lastOtherMessage?.id);
      if (lastOtherMessage != null) {
        _wsService.markRead(_conversationId!, lastOtherMessage.id);
      }
      // Sequenced silent refresh reconciles the exact badge across the app.
      _refreshConversationsCubit();
    } catch (_) {
      // Non-critical — the optimistic clear above already dropped the badge.
    }
  }

  /// Refresh the shared P2PConversationsCubit singleton so unread counts
  /// and badge numbers update on select_recipients and financial_connections.
  void _refreshConversationsCubit() {
    try {
      // Silent: reconcile the badge/counts WITHOUT blanking the list to a
      // spinner (the list stays on screen while the numbers update in place).
      serviceLocator<P2PConversationsCubit>().loadConversations(silent: true);
    } catch (_) {
      // Cubit may not be registered yet — non-critical
    }
  }

  /// Silently re-pull this conversation's messages + transfers and swap them
  /// into the loaded state (no spinner). Call after an EXTERNAL change the live
  /// WS might not have surfaced on-screen — e.g. a transfer or message the user
  /// just made through the in-chat AI assistant (bottom sheet), so the new
  /// transfer bubble / message shows the moment they close the sheet.
  Future<void> reloadConversation() async {
    final convId = _conversationId;
    if (convId == null) return;
    try {
      final messages =
          await _repository.getMessages(convId, page: 1, limit: _pageSize);
      final chatMessages =
          _deduplicateLegacyTransfers(messages.reversed.toList());
      List<P2PMessageEntity> allMessages = chatMessages;
      try {
        final transferMessages =
            await _fetchTransfersWithUser(_otherUserId ?? '', _otherUserName);
        if (transferMessages.isNotEmpty) {
          final existingRefs = chatMessages
              .where((m) => m.isTransfer && m.transferRef != null)
              .map((m) => _baseTransferRef(m.transferRef!))
              .toSet();
          final newTransfers = transferMessages
              .where((t) =>
                  t.transferRef == null ||
                  !existingRefs.contains(_baseTransferRef(t.transferRef!)))
              .toList();
          allMessages = [...chatMessages, ...newTransfers];
          allMessages.sort((a, b) => a.createdAt.compareTo(b.createdAt));
        }
      } catch (_) {/* transfers best-effort */}

      allMessages = _injectPendingTransfers(
          allMessages, _otherUserId ?? '', convId);

      final current = state;
      if (current is P2PChatLoaded) {
        _safeEmit(current.copyWith(
          messages: allMessages,
          hasMore: messages.length >= _pageSize,
        ));
        P2PChatSnapshotCache.instance
            .put(_otherUserId ?? '', current.copyWith(messages: allMessages));
      }
      // A fresh transfer likely arrived → clear its unread + refresh badges.
      _markConversationAsRead(allMessages);
    } catch (_) {
      // Non-critical — the live WS will still deliver updates.
    }
  }

  /// Send a text message.
  /// Forward [messages] to each of [targetUserIds] (WhatsApp-style). For each
  /// recipient it resolves/creates the conversation then re-sends each message's
  /// text OR media (media reuses the existing media_url — NO re-upload) with
  /// forwarded=true. Transfer/system messages are skipped. Returns how many
  /// (message × recipient) sends succeeded.
  Future<int> forwardMessages(
      List<String> targetUserIds, List<P2PMessageEntity> messages) async {
    var ok = 0;
    for (final uid in targetUserIds) {
      if (uid.isEmpty || uid == _currentUserId) continue;
      try {
        final conv = await _repository.getOrCreateConversation(
          uid,
          isSavedRecipient: true,
        );
        for (final m in messages) {
          // Only forward text + media; money transfers / system rows aren't
          // forwardable content.
          final isMedia = (m.mediaUrl ?? '').isNotEmpty && m.isMedia;
          final text = (m.content ?? '').trim();
          if (!isMedia && text.isEmpty) continue;
          try {
            await _repository.sendMessage(
              conv.id,
              isMedia ? '' : text,
              clientMessageId: const Uuid().v4(),
              mediaUrl: isMedia ? m.mediaUrl : null,
              mediaType: isMedia ? m.mediaType : null,
              forwarded: true,
            );
            ok++;
          } catch (_) {/* skip a single failed send */}
        }
      } catch (_) {/* skip a recipient whose conversation couldn't resolve */}
    }
    return ok;
  }

  /// Fast AI draft-reply grounded in this conversation's history (dedicated
  /// backend endpoint — no agent loop / greeting). Returns the drafted text.
  Future<String> draftAiReply({String? targetMessageId}) async {
    if (_conversationId == null) {
      throw Exception('no_conversation');
    }
    return _repository.draftReply(_conversationId!,
        targetMessageId: targetMessageId);
  }

  Future<void> sendMessage(String content) async {
    if (_conversationId == null || _currentUserId.isEmpty) return;
    final trimmed = content.trim();
    if (trimmed.isEmpty) return;

    // Capture + clear any active reply context so the composer banner drops
    // the instant the message is sent (WhatsApp-style).
    final cur = state;
    final P2PMessageEntity? replyTo =
        cur is P2PChatLoaded ? cur.replyingTo : null;
    if (cur is P2PChatLoaded && cur.replyingTo != null) {
      _safeEmit(cur.copyWith(clearReplyingTo: true));
    }

    final clientMessageId = const Uuid().v4();

    // Optimistic: add message locally with 'sending' status (+ denormalized
    // reply snippet so the quote renders immediately).
    final optimisticMsg = P2PMessageEntity(
      id: clientMessageId,
      conversationId: _conversationId!,
      senderId: _currentUserId,
      messageType: 'text',
      content: trimmed,
      deliveryStatus: 'sending',
      clientMessageId: clientMessageId,
      createdAt: DateTime.now(),
      replyToMessageId: replyTo?.id,
      replyToSenderId: replyTo?.senderId,
      replyToContent: replyTo == null
          ? null
          : (replyTo.content?.trim().isNotEmpty == true
              ? replyTo.content
              : (replyTo.isImage
                  ? '📷 Photo'
                  : replyTo.isVoice
                      ? '🎤 Voice note'
                      : replyTo.isTransfer
                          ? replyTo.transferSnippet
                          : '')),
    );
    _addMessage(optimisticMsg);
    // iMessage-style outgoing feedback (click + light haptic), honoring the
    // per-chat override then the global setting.
    ChatSoundSettings.instance.playSendFeedback(_conversationId);

    // Send via WebSocket (real-time)
    if (_wsService.isConnected) {
      _wsService.sendMessage(_conversationId!, trimmed, clientMessageId,
          replyToMessageId: replyTo?.id);
      // After sending, check if initiator hit the 1-message limit for pending connections
      final current = state;
      if (current is P2PChatLoaded &&
          current.connectionStatus == 'pending' &&
          current.initiatedBy == _currentUserId) {
        _safeEmit(current.copyWith(canSendMessage: false));
      }
    } else {
      // REST fallback when WebSocket is disconnected
      try {
        await _repository.sendMessage(_conversationId!, trimmed,
            clientMessageId: clientMessageId, replyToMessageId: replyTo?.id);
        _updateMessageByClientId(clientMessageId, deliveryStatus: 'sent');
      } on HttpException catch (e) {
        if (e.message == 'CONNECTION_PENDING') {
          _updateMessageByClientId(clientMessageId, deliveryStatus: 'failed');
          // Update state to reflect the block
          final current = state;
          if (current is P2PChatLoaded) {
            _safeEmit(current.copyWith(canSendMessage: false));
          }
        } else {
          _updateMessageByClientId(clientMessageId, deliveryStatus: 'failed');
        }
      } catch (e) {
        _updateMessageByClientId(clientMessageId, deliveryStatus: 'failed');
      }
    }
  }

  /// Send a media message (image or voice note).
  ///
  /// Flow: optimistically add the message with the LOCAL file path so the
  /// user sees their picture / voice note instantly, upload the file to
  /// storage to obtain the canonical `media_url`, then send the message
  /// (with the URL) via WebSocket (or REST fallback). On upload failure the
  /// optimistic message is marked `failed` and NO broken message is sent.
  Future<void> sendMediaMessage({
    required String mediaType, // 'image' | 'voice'
    required String localFilePath,
    String? contentType,
    int? voiceDurationMs,
    String? caption, // optional text attached to an image
  }) async {
    if (_conversationId == null || _currentUserId.isEmpty) return;
    if (mediaType != 'image' && mediaType != 'voice') return;

    final clientMessageId = const Uuid().v4();
    final cap = caption?.trim() ?? '';

    // Optimistic: show the local file immediately while we upload.
    final optimisticMsg = P2PMessageEntity(
      id: clientMessageId,
      conversationId: _conversationId!,
      senderId: _currentUserId,
      messageType: mediaType,
      mediaType: mediaType,
      content: cap.isEmpty ? null : cap,
      localMediaPath: localFilePath,
      deliveryStatus: 'sending',
      clientMessageId: clientMessageId,
      createdAt: DateTime.now(),
    );
    _addMessage(optimisticMsg);
    // iMessage-style outgoing feedback (click + light haptic), honoring the
    // per-chat override then the global setting.
    ChatSoundSettings.instance.playSendFeedback(_conversationId);

    // Upload the file to storage. On any failure, mark failed and bail —
    // never send a message with a missing/broken media URL.
    String mediaUrl;
    try {
      final result = await _mediaUploadService.uploadFromFile(
        File(localFilePath),
        contentType: contentType,
      );
      mediaUrl = result.publicUrl;
    } catch (e) {
      debugPrint('P2PChatCubit: media upload failed: $e');
      _updateMessageByClientId(clientMessageId, deliveryStatus: 'failed');
      return;
    }

    // Attach the resolved URL to the optimistic message.
    _attachMediaUrl(clientMessageId, mediaUrl);

    // Send via WebSocket (real-time), else REST fallback.
    if (_wsService.isConnected) {
      _wsService.sendMessage(
        _conversationId!,
        cap,
        clientMessageId,
        mediaUrl: mediaUrl,
        mediaType: mediaType,
      );
      // Same pending-connection 1-message limit handling as text.
      final current = state;
      if (current is P2PChatLoaded &&
          current.connectionStatus == 'pending' &&
          current.initiatedBy == _currentUserId) {
        _safeEmit(current.copyWith(canSendMessage: false));
      }
    } else {
      try {
        await _repository.sendMessage(
          _conversationId!,
          cap,
          clientMessageId: clientMessageId,
          mediaUrl: mediaUrl,
          mediaType: mediaType,
        );
        _updateMessageByClientId(clientMessageId, deliveryStatus: 'sent');
      } on HttpException catch (e) {
        if (e.message == 'CONNECTION_PENDING') {
          _updateMessageByClientId(clientMessageId, deliveryStatus: 'failed');
          final current = state;
          if (current is P2PChatLoaded) {
            _safeEmit(current.copyWith(canSendMessage: false));
          }
        } else {
          _updateMessageByClientId(clientMessageId, deliveryStatus: 'failed');
        }
      } catch (e) {
        _updateMessageByClientId(clientMessageId, deliveryStatus: 'failed');
      }
    }
  }

  /// Retry a failed media message by re-uploading its local file and
  /// re-sending. Removes the failed optimistic message first, then runs the
  /// full media send flow again with a fresh client message id.
  Future<void> retryMediaMessage(String clientMessageId) async {
    final currentState = state;
    if (currentState is! P2PChatLoaded) return;

    final msg = currentState.messages
        .where((m) => m.clientMessageId == clientMessageId)
        .firstOrNull;
    if (msg == null ||
        !msg.isMedia ||
        msg.localMediaPath == null ||
        msg.localMediaPath!.isEmpty) {
      return;
    }

    // Drop the old failed message, then re-run the send flow.
    final remaining = currentState.messages
        .where((m) => m.clientMessageId != clientMessageId)
        .toList();
    _safeEmit(currentState.copyWith(messages: remaining));

    await sendMediaMessage(
      mediaType: msg.mediaType ?? 'image',
      localFilePath: msg.localMediaPath!,
    );
  }

  /// Attach the uploaded media URL to a pending optimistic message.
  void _attachMediaUrl(String clientMessageId, String mediaUrl) {
    final currentState = state;
    if (currentState is P2PChatLoaded) {
      final messages = currentState.messages.map((m) {
        if (m.clientMessageId == clientMessageId) {
          return m.copyWith(mediaUrl: mediaUrl);
        }
        return m;
      }).toList();
      _safeEmit(currentState.copyWith(messages: messages));
    }
  }

  /// Retry a failed message.
  Future<void> retryMessage(String clientMessageId) async {
    if (_conversationId == null) return;

    final currentState = state;
    if (currentState is! P2PChatLoaded) return;

    final msg = currentState.messages
        .where((m) => m.clientMessageId == clientMessageId)
        .firstOrNull;
    if (msg == null || msg.deliveryStatus != 'failed') return;

    final content = msg.content;
    if (content == null || content.isEmpty) return;

    _updateMessageByClientId(clientMessageId, deliveryStatus: 'sending');

    if (_wsService.isConnected) {
      _wsService.sendMessage(_conversationId!, content, clientMessageId);
    } else {
      try {
        await _repository.sendMessage(_conversationId!, content,
            clientMessageId: clientMessageId);
        _updateMessageByClientId(clientMessageId, deliveryStatus: 'sent');
      } catch (_) {
        _updateMessageByClientId(clientMessageId, deliveryStatus: 'failed');
      }
    }
  }

  /// Load older messages (pagination).
  /// Back-compat entry point used by the page's scroll listener; delegates to
  /// the cursor-based loader below.
  Future<void> loadMore() => loadOlderMessages();

  /// Send typing indicator.
  void sendTyping(bool isTyping) {
    if (_conversationId != null) {
      _wsService.sendTyping(_conversationId!, isTyping);
    }
  }

  /// Fetch transfers between the current user and the other user from accounts-service.
  /// Returns P2PMessageEntity list with transfer_sent/transfer_received types.
  Future<List<P2PMessageEntity>> _fetchTransfersWithUser(
    String otherUserId,
    String? otherUserName,
  ) async {
    final accountId = _accountManager.activeAccountId;
    if (accountId == null || accountId.isEmpty) return [];

    // Get the account currency for transfer display
    String currency = 'NGN';
    try {
      final account = await _accountsClient.getAccount(accountId: accountId);
      if (account.currency.isNotEmpty) {
        currency = account.currency;
      }
    } catch (_) {
      // Use default currency
    }

    final response = await _accountsClient.getTransactionHistory(
      accountId: accountId,
      locale: _localeManager.currentLocale,
      category: 'transfer',
      limit: 50,
    );

    final transfers = <P2PMessageEntity>[];
    for (final tx in response.transactions) {
      // Match by counterpartyName (case-insensitive contains check)
      final txCounterparty = tx.counterpartyName.toLowerCase().trim();
      final searchName = (otherUserName ?? '').toLowerCase().trim();
      if (txCounterparty.isEmpty || searchName.isEmpty) continue;
      if (!txCounterparty.contains(searchName) && !searchName.contains(txCounterparty)) {
        continue;
      }

      final isSent = tx.type.toLowerCase() == 'debit';
      // Amount is in major units (double) from proto; convert to minor units (kobo)
      final amountMinor = (tx.amount * 100).toInt();

      DateTime createdAt;
      try {
        // UTC server time → LOCAL, consistent with message bubbles + optimistic.
        createdAt = DateTime.parse(tx.createdAt).toLocal();
      } catch (_) {
        createdAt = DateTime.now();
      }

      transfers.add(P2PMessageEntity(
        id: 'transfer_${tx.id}',
        conversationId: _conversationId ?? '',
        senderId: isSent ? _currentUserId : otherUserId,
        messageType: 'transfer',
        content: tx.description.isNotEmpty ? tx.description : null,
        transferRef: tx.reference,
        transferAmount: amountMinor,
        transferCurrency: currency,
        transferStatus: tx.status,
        deliveryStatus: 'delivered',
        createdAt: createdAt,
      ));
    }

    return transfers;
  }

  /// Merge any locally-recorded pending transfers to [peerUserId] into
  /// [messages]. These are transfers the user JUST completed via the send-funds
  /// flow (which wipes the stack, so the chat can't reload on return) — this
  /// renders the money bubble the instant the chat opens, without waiting on
  /// transaction-history. Deduped against existing transfer rows by base ref so
  /// nothing double-renders once history reflects the tx.
  List<P2PMessageEntity> _injectPendingTransfers(
    List<P2PMessageEntity> messages,
    String peerUserId,
    String conversationId,
  ) {
    if (peerUserId.isEmpty) return messages;
    final pending = PendingChatTransfers.instance.peek(peerUserId);
    if (pending.isEmpty) return messages;

    final existingRefs = messages
        .where((m) => m.isTransfer && m.transferRef != null)
        .map((m) => _baseTransferRef(m.transferRef!))
        .toSet();

    final injected = <P2PMessageEntity>[];
    for (final p in pending) {
      if (p.reference != null &&
          p.reference!.isNotEmpty &&
          existingRefs.contains(_baseTransferRef(p.reference!))) {
        continue;
      }
      injected.add(P2PMessageEntity(
        id: 'pending_transfer_${p.reference ?? p.createdAt.millisecondsSinceEpoch}',
        conversationId: conversationId,
        // Recorded transfers are always ones the current user SENT.
        senderId: _currentUserId,
        messageType: 'transfer',
        content: p.note,
        transferRef: p.reference,
        transferAmount: p.amountMinor,
        transferCurrency: p.currency,
        // Use the recorded status so a scheduled (not-yet-fired) send renders
        // "Money Scheduled"; fall back to completed for legacy/instant sends.
        transferStatus: p.status ?? 'completed',
        deliveryStatus: 'delivered',
        createdAt: p.createdAt,
      ));
    }
    if (injected.isEmpty) return messages;
    final merged = [...messages, ...injected];
    merged.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    return merged;
  }

  /// Strip legacy "-recv" suffix from a transfer ref to get the base reference.
  static String _baseTransferRef(String ref) =>
      ref.endsWith('-recv') ? ref.substring(0, ref.length - 5) : ref;

  /// Deduplicate legacy transfer_sent/transfer_received pairs.
  /// For pairs sharing the same base transferRef (one with "-recv" suffix),
  /// keep only the transfer_sent one — display logic handles perspective via senderId.
  List<P2PMessageEntity> _deduplicateLegacyTransfers(List<P2PMessageEntity> messages) {
    // Single pass to collect base refs of BOTH sides (O(n)); previously this
    // did a nested `.any` per received row (O(n²)) on every load / loadMore /
    // incoming message.
    final recvRefs = <String>{};
    final sentRefs = <String>{};
    for (final m in messages) {
      if (m.transferRef == null) continue;
      final base = _baseTransferRef(m.transferRef!);
      if (m.messageType == 'transfer_received') {
        recvRefs.add(base);
      } else if (m.messageType == 'transfer_sent') {
        sentRefs.add(base);
      }
    }
    if (recvRefs.isEmpty) return messages;

    return messages.where((m) {
      if (m.messageType != 'transfer_received') return true;
      // Drop a transfer_received when a matching transfer_sent exists (display
      // handles perspective via senderId).
      final base = m.transferRef != null ? _baseTransferRef(m.transferRef!) : null;
      return base == null || !sentRefs.contains(base);
    }).toList();
  }

  /// Append [message] in chronological order, unless it duplicates one already
  /// present. Returns true when the message was actually added, false when it
  /// was a duplicate (or the cubit is not in a loaded state) — callers use this
  /// to avoid firing incoming-message feedback twice on a duplicate delivery.
  bool _addMessage(P2PMessageEntity message) {
    final currentState = state;
    if (currentState is P2PChatLoaded) {
      // Don't add duplicates (check by id, clientMessageId, or transferRef)
      final exists = currentState.messages.any((m) =>
          m.id == message.id ||
          (message.clientMessageId != null &&
              message.clientMessageId!.isNotEmpty &&
              m.clientMessageId == message.clientMessageId) ||
          (message.isTransfer &&
              message.transferRef != null &&
              message.transferRef!.isNotEmpty &&
              m.isTransfer &&
              m.transferRef != null &&
              _baseTransferRef(m.transferRef!) == _baseTransferRef(message.transferRef!)));
      if (exists) return false;

      // Insert in chronological order
      final messages = [...currentState.messages, message];
      messages.sort((a, b) => a.createdAt.compareTo(b.createdAt));

      _safeEmit(currentState.copyWith(messages: messages));
      return true;
    }
    return false;
  }

  /// Update delivery status of a message by its ID.
  void _updateDeliveryStatus(String messageId, String status) {
    final currentState = state;
    if (currentState is P2PChatLoaded) {
      final messages = currentState.messages.map((m) {
        if (m.id == messageId) {
          return m.copyWith(deliveryStatus: status);
        }
        return m;
      }).toList();

      _safeEmit(currentState.copyWith(messages: messages));
    }
  }

  /// Update a message found by clientMessageId.
  void _updateMessageByClientId(String clientMessageId,
      {String? deliveryStatus, String? serverId}) {
    final currentState = state;
    if (currentState is P2PChatLoaded) {
      final messages = currentState.messages.map((m) {
        if (m.clientMessageId == clientMessageId) {
          return m.copyWith(
            id: serverId ?? m.id,
            deliveryStatus: deliveryStatus ?? m.deliveryStatus,
          );
        }
        return m;
      }).toList();

      _safeEmit(currentState.copyWith(messages: messages));
    }
  }

  /// Handle server confirmation of a sent message.
  void _handleMessageSentConfirmation(P2PMessageSentConfirmation conf) {
    _updateMessageByClientId(
      conf.clientMessageId,
      deliveryStatus: 'sent',
      serverId: conf.messageId,
    );
  }

  // ─────────────────────────── Reply / Edit state ───────────────────────────

  /// Whether [message] is still editable by this user (own text message within
  /// the 1-hour window). Mirrors the server-side rule so the UI hides the
  /// option once it can't succeed.
  bool canEditMessage(P2PMessageEntity message) {
    if (message.senderId != _currentUserId) return false;
    if (message.messageType != 'text') return false;
    if (message.deliveryStatus == 'failed' || message.deliveryStatus == 'sending') {
      return false;
    }
    return DateTime.now().difference(message.createdAt) <=
        const Duration(hours: 1);
  }

  void startReply(P2PMessageEntity message) {
    final s = state;
    if (s is P2PChatLoaded) {
      _safeEmit(s.copyWith(replyingTo: message, clearEditingMessage: true));
    }
  }

  void cancelReply() {
    final s = state;
    if (s is P2PChatLoaded) _safeEmit(s.copyWith(clearReplyingTo: true));
  }

  void startEdit(P2PMessageEntity message) {
    final s = state;
    if (s is P2PChatLoaded) {
      _safeEmit(s.copyWith(editingMessage: message, clearReplyingTo: true));
    }
  }

  void cancelEdit() {
    final s = state;
    if (s is P2PChatLoaded) _safeEmit(s.copyWith(clearEditingMessage: true));
  }

  // ─────────────────────────────── Edit ─────────────────────────────────────

  /// Commit an edit to the currently-edited message (or [messageId] if given).
  Future<void> commitEdit(String newContent, {String? messageId}) async {
    final s = state;
    if (s is! P2PChatLoaded || _conversationId == null) return;
    final target = messageId ??
        (s.editingMessage != null ? s.editingMessage!.id : null);
    if (target == null) return;
    final trimmed = newContent.trim();
    if (trimmed.isEmpty) return;

    // Optimistic: update content + stamp edited locally, drop edit mode.
    final now = DateTime.now();
    final updated = s.messages
        .map((m) => m.id == target
            ? m.copyWith(content: trimmed, editedAt: now)
            : m)
        .toList();
    _safeEmit(s.copyWith(messages: updated, clearEditingMessage: true));

    try {
      final server =
          await _repository.editMessage(_conversationId!, target, trimmed);
      _applyEditedMessage(server);
    } on HttpException catch (e) {
      if (e.message == 'EDIT_WINDOW_EXPIRED') {
        // REVERT the optimistic edit to the original content. NEVER emit
        // P2PChatError here — that would flash the full-screen error over the
        // whole conversation. The 1h window is also enforced client-side
        // (canEditMessage), so this only trips on a rare boundary race.
        final cur = state;
        if (cur is P2PChatLoaded) _safeEmit(cur.copyWith(messages: s.messages));
      }
    } catch (_) {
      // Non-fatal: the optimistic edit stays; a live edit event / refresh
      // reconciles it. Never surfaces as a full-screen error.
    }
  }

  void _applyEditedMessage(P2PMessageEntity edited) {
    final s = state;
    if (s is! P2PChatLoaded) return;
    final messages = s.messages
        .map((m) => m.id == edited.id
            ? m.copyWith(content: edited.content, editedAt: edited.editedAt)
            : m)
        .toList();
    _safeEmit(s.copyWith(messages: messages));
  }

  // ───────────────────────────── Reactions ──────────────────────────────────

  /// Toggle a reaction on a message (optimistic + server sync).
  Future<void> reactToMessage(String messageId, String emoji) async {
    final s = state;
    if (s is! P2PChatLoaded || _conversationId == null) return;

    // Optimistic: apply the same WhatsApp toggle rule locally.
    final optimistic = s.messages.map((m) {
      if (m.id != messageId) return m;
      final next = <P2PReaction>[];
      var had = false;
      for (final r in m.reactions) {
        if (r.userId == _currentUserId) {
          if (r.emoji == emoji) had = true;
          continue;
        }
        next.add(r);
      }
      if (!had) next.add(P2PReaction(userId: _currentUserId, emoji: emoji));
      return m.copyWith(reactions: next);
    }).toList();
    _safeEmit(s.copyWith(messages: optimistic));

    try {
      final server =
          await _repository.reactToMessage(_conversationId!, messageId, emoji);
      _applyReactions(messageId, server);
    } catch (_) {
      // Ignore — the optimistic state stays; a reaction event will reconcile.
    }
  }

  void _applyReactions(String messageId, List<P2PReaction> reactions) {
    final s = state;
    if (s is! P2PChatLoaded) return;
    final messages = s.messages
        .map((m) => m.id == messageId ? m.copyWith(reactions: reactions) : m)
        .toList();
    _safeEmit(s.copyWith(messages: messages));
  }

  // ──────────────────────────── Emoji stream ────────────────────────────────

  /// Fire an ephemeral floating-emoji burst to the other party (WhatsApp-style).
  void sendEmojiStream(String emoji) {
    if (_conversationId == null || emoji.isEmpty) return;
    _wsService.sendEmojiStream(_conversationId!, emoji);
  }

  /// Inbound ephemeral emoji bursts for THIS conversation (page animates them).
  Stream<String> get incomingEmojiBursts => _wsService.emojiStream
      .where((e) => e.conversationId == _conversationId)
      .map((e) => e.emoji);

  // ─────────────────────────── Pagination (older) ───────────────────────────

  /// AI "jump to message": ensure the target message(s) are loaded (paging
  /// older until found, bounded), then flash a highlight on the matches. The
  /// page listens for [P2PChatLoaded.highlightedMessageIds] turning non-empty
  /// and scrolls to the earliest match. Best-effort: unfound ids are ignored,
  /// the flash auto-clears so it never sticks.
  Future<void> jumpToAndHighlight(List<String> ids) async {
    if (ids.isEmpty) return;
    // Page-until-found (bounded) so a target deep in history gets loaded.
    var guard = 0;
    while (guard < 12) {
      final s = state;
      if (s is! P2PChatLoaded) return;
      final loaded = s.messages.map((m) => m.id).toSet();
      final missing = ids.where((id) => !loaded.contains(id));
      if (missing.isEmpty || !s.hasMore || s.isLoadingMore) break;
      await loadOlderMessages();
      guard++;
    }
    final s = state;
    if (s is! P2PChatLoaded) return;
    final found =
        ids.where((id) => s.messages.any((m) => m.id == id)).toSet();
    if (found.isEmpty) return;
    _safeEmit(s.copyWith(highlightedMessageIds: found));
    // Clear the flash after a few seconds so it's transient, not permanent.
    Timer(const Duration(seconds: 4), () {
      final cur = state;
      if (cur is P2PChatLoaded && cur.highlightedMessageIds.isNotEmpty) {
        _safeEmit(cur.copyWith(highlightedMessageIds: const <String>{}));
      }
    });
  }

  /// Load an older page of messages (cursor = oldest loaded message's time).
  /// Prepends without disturbing the current view; safe to call repeatedly.
  Future<void> loadOlderMessages() async {
    final s = state;
    if (s is! P2PChatLoaded ||
        _conversationId == null ||
        s.isLoadingMore ||
        !s.hasMore ||
        s.messages.isEmpty) {
      return;
    }
    _safeEmit(s.copyWith(isLoadingMore: true));
    try {
      final oldest = s.messages.first.createdAt;
      final older = await _repository.getMessagesPage(_conversationId!,
          limit: _cursorPageSize, before: oldest);
      final s2 = state;
      if (s2 is! P2PChatLoaded) return;
      if (older.isEmpty) {
        _safeEmit(s2.copyWith(isLoadingMore: false, hasMore: false));
        return;
      }
      // Merge older messages (dedup by id + legacy transfer pairs), keep order.
      final existingIds = s2.messages.map((m) => m.id).toSet();
      final merged = _deduplicateLegacyTransfers([
        ...older.reversed.where((m) => !existingIds.contains(m.id)),
        ...s2.messages,
      ])
        ..sort((a, b) => a.createdAt.compareTo(b.createdAt));
      _safeEmit(s2.copyWith(
        messages: merged,
        isLoadingMore: false,
        hasMore: older.length >= _cursorPageSize,
      ));
    } catch (_) {
      final s2 = state;
      if (s2 is P2PChatLoaded) _safeEmit(s2.copyWith(isLoadingMore: false));
    }
  }

  /// Emit only if the cubit is not closed.
  void _safeEmit(P2PChatState newState) {
    if (!isClosed) {
      emit(newState);
    }
  }

  @override
  Future<void> close() {
    // Persist the latest loaded state so re-opening this peer paints instantly
    // (includes any messages/transfers received while the screen was open).
    final s = state;
    if (s is P2PChatLoaded && (_otherUserId?.isNotEmpty ?? false)) {
      P2PChatSnapshotCache.instance.put(_otherUserId!, s);
    }
    // No conversation is open anymore → live messages resume bumping the badge.
    try {
      serviceLocator<P2PConversationsCubit>().setOpenConversation(null);
    } catch (_) {}
    // Clear server-side viewing focus → pushes resume for this conversation.
    try {
      _wsService.sendBlur();
    } catch (_) {}
    // Refresh conversations list so unread badges update after leaving chat
    _refreshConversationsCubit();
    _messageSubscription?.cancel();
    _deliverySubscription?.cancel();
    _readReceiptSubscription?.cancel();
    _messageSentSubscription?.cancel();
    _connectionSubscription?.cancel();
    _connectionAcceptedSubscription?.cancel();
    _serverErrorSubscription?.cancel();
    _editedSubscription?.cancel();
    _reactionSubscription?.cancel();
    return super.close();
  }
}
