import 'dart:async';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'http_microservice_chat_datasource.dart';

abstract class WebSocketMicroserviceChatDataSource {
  Future<void> connect(String sessionId, String accessToken, String userId, String language, String sourceContext);
  Future<ChatResponse> sendMessage(String message);
  Stream<ChatResponse> get messageStream;
  Future<void> disconnect();
  bool get isConnected;
}

class WebSocketMicroserviceChatDataSourceImpl implements WebSocketMicroserviceChatDataSource {
  final GrpcCallOptionsHelper callOptionsHelper;
  final String baseUrl;
  WebSocketChannel? _channel;
  final StreamController<ChatResponse> _messageController = StreamController<ChatResponse>.broadcast();
  bool _isConnected = false;

  WebSocketMicroserviceChatDataSourceImpl({
    required this.callOptionsHelper,
    this.baseUrl = 'ws://localhost:3011', // WebSocket URL for Chat Agent Gateway
  });

  @override
  bool get isConnected => _isConnected && _channel != null;

  @override
  Future<void> connect(
    String sessionId,
    String accessToken,
    String userId,
    String language,
    String sourceContext,
  ) async {
    if (_isConnected) {
      await disconnect();
    }

    try {
      final wsUrl = Uri.parse('$baseUrl/ws/chat');
      _channel = WebSocketChannel.connect(wsUrl);

      // Send initial authentication message
      final initMessage = jsonEncode({
        'access_token': accessToken,
        'session_id': sessionId,
        'user_id': userId,
        'language': language,
        'source_context': sourceContext,
      });

      _channel!.sink.add(initMessage);

      // Listen for incoming messages
      _channel!.stream.listen(
        (message) {
          _handleIncomingMessage(message);
        },
        onError: (error) {
          _isConnected = false;
          _messageController.addError(error);
        },
        onDone: () {
          _isConnected = false;
        },
        cancelOnError: false,
      );

      _isConnected = true;
    } catch (e) {
      _isConnected = false;
      throw Exception('Failed to connect to WebSocket: $e');
    }
  }

  void _handleIncomingMessage(dynamic message) {
    try {
      final data = jsonDecode(message as String);

      if (data is Map<String, dynamic>) {
        // Handle different message types
        if (data['type'] == 'greeting') {
          // Initial greeting from server
          final greetingResponse = ChatResponse(
            response: data['message'] as String? ?? 'Connected to chat',
            metadata: {'type': 'greeting'},
          );
          _messageController.add(greetingResponse);
        } else if (data['type'] == 'response') {
          // Regular response from agent
          final response = ChatResponse.fromJson(data);
          _messageController.add(response);
        } else if (data.containsKey('error')) {
          // Error message
          throw Exception(data['error'] as String? ?? 'Unknown error');
        }
      }
    } catch (e) {
      _messageController.addError(e);
    }
  }

  @override
  Future<ChatResponse> sendMessage(String message) async {
    if (!isConnected || _channel == null) {
      throw Exception('WebSocket is not connected');
    }

    final messageData = jsonEncode({
      'message': message,
    });

    _channel!.sink.add(messageData);

    // Return a completer that will be resolved when response arrives
    final completer = Completer<ChatResponse>();

    // Listen for the next message
    StreamSubscription? subscription;
    subscription = messageStream.listen(
      (response) {
        if (!completer.isCompleted) {
          completer.complete(response);
          subscription?.cancel();
        }
      },
      onError: (error) {
        if (!completer.isCompleted) {
          completer.completeError(error);
          subscription?.cancel();
        }
      },
    );

    // Timeout after 30 seconds
    Future.delayed(const Duration(seconds: 30), () {
      if (!completer.isCompleted) {
        subscription?.cancel();
        completer.completeError(TimeoutException('Chat response timeout'));
      }
    });

    return completer.future;
  }

  @override
  Stream<ChatResponse> get messageStream => _messageController.stream;

  @override
  Future<void> disconnect() async {
    _isConnected = false;
    await _channel?.sink.close();
    _channel = null;
    await _messageController.close();
  }
}
