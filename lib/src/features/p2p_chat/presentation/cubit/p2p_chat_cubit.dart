import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/core/services/account_manager.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:lazervault/src/core/grpc/accounts_grpc_client.dart';
import 'package:lazervault/src/features/p2p_chat/domain/entities/p2p_message_entity.dart';
import 'package:lazervault/src/features/p2p_chat/domain/repositories/p2p_chat_repository.dart';
import 'package:lazervault/src/features/p2p_chat/presentation/cubit/p2p_chat_state.dart';
import 'package:lazervault/src/features/p2p_chat/services/p2p_chat_websocket_service.dart';
import 'package:uuid/uuid.dart';

class P2PChatCubit extends Cubit<P2PChatState> {
  final P2PChatRepository _repository;
  final P2PChatWebSocketService _wsService;
  final SecureStorageService _secureStorage;
  final AccountsGrpcClient _accountsClient;
  final AccountManager _accountManager;
  String _currentUserId;

  StreamSubscription? _messageSubscription;
  StreamSubscription? _deliverySubscription;
  StreamSubscription? _readReceiptSubscription;
  StreamSubscription? _messageSentSubscription;
  StreamSubscription? _connectionSubscription;
  StreamSubscription? _connectionAcceptedSubscription;
  StreamSubscription? _serverErrorSubscription;
  String? _conversationId;
  String? _otherUserId;
  int _currentPage = 1;
  static const int _pageSize = 50;

  P2PChatCubit({
    required P2PChatRepository repository,
    required P2PChatWebSocketService wsService,
    required SecureStorageService secureStorage,
    required AccountsGrpcClient accountsClient,
    required AccountManager accountManager,
    required String currentUserId,
  })  : _repository = repository,
        _wsService = wsService,
        _secureStorage = secureStorage,
        _accountsClient = accountsClient,
        _accountManager = accountManager,
        _currentUserId = currentUserId,
        super(P2PChatInitial()) {
    // Provide fresh token for WebSocket reconnection
    _wsService.onTokenRefresh = () => _secureStorage.getAccessToken();
  }

  /// Initialize chat with another user.
  Future<void> initializeChat(
    String otherUserId, {
    String? otherUserName,
    String? otherUserAvatar,
    String? myName,
    String? myAvatar,
  }) async {
    // If currentUserId wasn't available at construction time (e.g. factory DI),
    // fetch it from secure storage.
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

    _otherUserId = otherUserId;
    emit(P2PChatLoading());

    try {
      // Connect WebSocket if not already connected
      await _ensureWebSocketConnected();

      final conversation = await _repository.getOrCreateConversation(
        otherUserId,
        otherUserName: otherUserName,
        otherUserAvatar: otherUserAvatar,
        myName: myName,
        myAvatar: myAvatar,
      );
      _conversationId = conversation.id;

      // Load initial messages
      final messages = await _repository.getMessages(conversation.id,
          page: 1, limit: _pageSize);

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
          _addMessage(message);

          // Auto-mark as read if from other user
          if (message.senderId != _currentUserId) {
            try {
              _repository.markRead(_conversationId!, message.id);
              _wsService.markRead(_conversationId!, message.id);
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

      // Merge transfer history from accounts-service (best-effort, non-blocking)
      final chatMessages = messages.reversed.toList(); // Chronological order
      List<P2PMessageEntity> allMessages = chatMessages;
      try {
        final transferMessages = await _fetchTransfersWithUser(otherUserId, otherUserName);
        if (transferMessages.isNotEmpty) {
          // Deduplicate: skip transfers already present as chat transfer messages
          final existingRefs = chatMessages
              .where((m) => m.isTransfer && m.transferRef != null)
              .map((m) => m.transferRef)
              .toSet();
          final newTransfers = transferMessages
              .where((t) => t.transferRef == null || !existingRefs.contains(t.transferRef))
              .toList();
          allMessages = [...chatMessages, ...newTransfers];
          allMessages.sort((a, b) => a.createdAt.compareTo(b.createdAt));
        }
      } catch (e) {
        debugPrint('P2PChatCubit: Failed to fetch transfers: $e');
      }

      emit(P2PChatLoaded(
        messages: allMessages,
        conversationId: conversation.id,
        hasMore: messages.length >= _pageSize,
        connectionState: _wsService.isConnected
            ? P2PChatConnectionState.connected
            : P2PChatConnectionState.disconnected,
        connectionStatus: conversation.connectionStatus,
        initiatedBy: conversation.initiatedBy,
        canSendMessage: canSend,
      ));
    } catch (e) {
      final errorMsg = e.toString();
      if (errorMsg.contains('Unauthorized') || errorMsg.contains('401')) {
        emit(P2PChatError(message: 'Session expired. Please log in again.'));
      } else if (errorMsg.contains('SocketException') ||
          errorMsg.contains('Connection refused') ||
          errorMsg.contains('TimeoutException')) {
        emit(P2PChatError(
            message: 'Chat service is unavailable. Please try again later.'));
      } else {
        emit(P2PChatError(message: 'Failed to load chat. Please try again.'));
      }
    }
  }

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

  /// Send a text message.
  Future<void> sendMessage(String content) async {
    if (_conversationId == null || _currentUserId.isEmpty) return;
    final trimmed = content.trim();
    if (trimmed.isEmpty) return;

    final clientMessageId = const Uuid().v4();

    // Optimistic: add message locally with 'sending' status
    final optimisticMsg = P2PMessageEntity(
      id: clientMessageId,
      conversationId: _conversationId!,
      senderId: _currentUserId,
      messageType: 'text',
      content: trimmed,
      deliveryStatus: 'sending',
      clientMessageId: clientMessageId,
      createdAt: DateTime.now(),
    );
    _addMessage(optimisticMsg);

    // Send via WebSocket (real-time)
    if (_wsService.isConnected) {
      _wsService.sendMessage(_conversationId!, trimmed, clientMessageId);
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
            clientMessageId: clientMessageId);
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
  Future<void> loadMore() async {
    final currentState = state;
    if (currentState is! P2PChatLoaded ||
        currentState.isLoadingMore ||
        !currentState.hasMore) {
      return;
    }

    emit(currentState.copyWith(isLoadingMore: true));
    final nextPage = _currentPage + 1;

    try {
      final olderMessages = await _repository.getMessages(
        _conversationId!,
        page: nextPage,
        limit: _pageSize,
      );

      // Only increment page on success
      _currentPage = nextPage;

      final allMessages = [
        ...olderMessages.reversed,
        ...currentState.messages,
      ];

      _safeEmit(P2PChatLoaded(
        messages: allMessages,
        conversationId: _conversationId!,
        hasMore: olderMessages.length >= _pageSize,
        isLoadingMore: false,
        connectionState: currentState.connectionState,
        connectionStatus: currentState.connectionStatus,
        initiatedBy: currentState.initiatedBy,
        canSendMessage: currentState.canSendMessage,
      ));
    } catch (e) {
      _safeEmit(currentState.copyWith(isLoadingMore: false));
    }
  }

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
      final messageType = isSent ? 'transfer_sent' : 'transfer_received';
      // Amount is in major units (double) from proto; convert to minor units (kobo)
      final amountMinor = (tx.amount * 100).toInt();

      DateTime createdAt;
      try {
        createdAt = DateTime.parse(tx.createdAt);
      } catch (_) {
        createdAt = DateTime.now();
      }

      transfers.add(P2PMessageEntity(
        id: 'transfer_${tx.id}',
        conversationId: _conversationId ?? '',
        senderId: isSent ? _currentUserId : otherUserId,
        messageType: messageType,
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

  void _addMessage(P2PMessageEntity message) {
    final currentState = state;
    if (currentState is P2PChatLoaded) {
      // Don't add duplicates (check by clientMessageId or id)
      final exists = currentState.messages.any((m) =>
          m.id == message.id ||
          (message.clientMessageId != null &&
              message.clientMessageId!.isNotEmpty &&
              m.clientMessageId == message.clientMessageId));
      if (exists) return;

      // Insert in chronological order
      final messages = [...currentState.messages, message];
      messages.sort((a, b) => a.createdAt.compareTo(b.createdAt));

      _safeEmit(currentState.copyWith(messages: messages));
    }
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

  /// Emit only if the cubit is not closed.
  void _safeEmit(P2PChatState newState) {
    if (!isClosed) {
      emit(newState);
    }
  }

  @override
  Future<void> close() {
    _messageSubscription?.cancel();
    _deliverySubscription?.cancel();
    _readReceiptSubscription?.cancel();
    _messageSentSubscription?.cancel();
    _connectionSubscription?.cancel();
    _connectionAcceptedSubscription?.cancel();
    _serverErrorSubscription?.cancel();
    return super.close();
  }
}
