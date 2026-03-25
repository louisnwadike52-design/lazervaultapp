import 'package:equatable/equatable.dart';

/// Represents a single message in the voice conversation
class VoiceConversationMessage extends Equatable {
  final String id;
  final VoiceConversationSender sender;
  final String text;
  final DateTime timestamp;
  final VoiceConversationMetadata? metadata;

  const VoiceConversationMessage({
    required this.id,
    required this.sender,
    required this.text,
    required this.timestamp,
    this.metadata,
  });

  factory VoiceConversationMessage.fromJson(Map<String, dynamic> json) {
    return VoiceConversationMessage(
      id: json['id'] as String,
      sender: VoiceConversationSender.values.firstWhere(
        (e) => e.name == json['sender'],
        orElse: () => VoiceConversationSender.user,
      ),
      text: json['text'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      metadata: json['metadata'] != null
          ? VoiceConversationMetadata.fromJson(json['metadata'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sender': sender.name,
      'text': text,
      'timestamp': timestamp.toIso8601String(),
      if (metadata != null) 'metadata': metadata!.toJson(),
    };
  }

  VoiceConversationMessage copyWith({
    String? id,
    VoiceConversationSender? sender,
    String? text,
    DateTime? timestamp,
    VoiceConversationMetadata? metadata,
  }) {
    return VoiceConversationMessage(
      id: id ?? this.id,
      sender: sender ?? this.sender,
      text: text ?? this.text,
      timestamp: timestamp ?? this.timestamp,
      metadata: metadata ?? this.metadata,
    );
  }

  @override
  List<Object?> get props => [id, sender, text, timestamp, metadata];
}

/// Who sent the message
enum VoiceConversationSender {
  user,
  agent,
}

/// Optional metadata for special messages (e.g., transaction receipts, file attachments)
class VoiceConversationMetadata extends Equatable {
  final String? type; // 'transaction_receipt', 'transfer_summary', 'error', etc.
  final Map<String, dynamic>? data;
  final String? fileUrl; // For attachments (receipts, images, etc.)
  final String? fileName;

  const VoiceConversationMetadata({
    this.type,
    this.data,
    this.fileUrl,
    this.fileName,
  });

  factory VoiceConversationMetadata.fromJson(Map<String, dynamic> json) {
    return VoiceConversationMetadata(
      type: json['type'] as String?,
      data: json['data'] as Map<String, dynamic>?,
      fileUrl: json['file_url'] as String?,
      fileName: json['file_name'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (type != null) 'type': type,
      if (data != null) 'data': data,
      if (fileUrl != null) 'file_url': fileUrl,
      if (fileName != null) 'file_name': fileName,
    };
  }

  @override
  List<Object?> get props => [type, data, fileUrl, fileName];
}

/// Represents a complete voice conversation session
class VoiceConversation extends Equatable {
  final String sessionId;
  final DateTime startedAt;
  final DateTime? endedAt;
  final List<VoiceConversationMessage> messages;
  final String? language;
  final VoiceConversationMetadata? sessionMetadata;

  const VoiceConversation({
    required this.sessionId,
    required this.startedAt,
    this.endedAt,
    this.messages = const [],
    this.language,
    this.sessionMetadata,
  });

  VoiceConversation copyWith({
    String? sessionId,
    DateTime? startedAt,
    DateTime? endedAt,
    List<VoiceConversationMessage>? messages,
    String? language,
    VoiceConversationMetadata? sessionMetadata,
    bool clearEndedAt = false,
  }) {
    return VoiceConversation(
      sessionId: sessionId ?? this.sessionId,
      startedAt: startedAt ?? this.startedAt,
      endedAt: clearEndedAt ? null : (endedAt ?? this.endedAt),
      messages: messages ?? this.messages,
      language: language ?? this.language,
      sessionMetadata: sessionMetadata ?? this.sessionMetadata,
    );
  }

  /// Add a user message to the conversation
  VoiceConversation addUserMessage(String text, {VoiceConversationMetadata? metadata}) {
    return copyWith(
      messages: [
        ...messages,
        VoiceConversationMessage(
          id: '${sessionId}_${DateTime.now().millisecondsSinceEpoch}_user',
          sender: VoiceConversationSender.user,
          text: text,
          timestamp: DateTime.now(),
          metadata: metadata,
        ),
      ],
    );
  }

  /// Add an agent message to the conversation
  VoiceConversation addAgentMessage(String text, {VoiceConversationMetadata? metadata}) {
    return copyWith(
      messages: [
        ...messages,
        VoiceConversationMessage(
          id: '${sessionId}_${DateTime.now().millisecondsSinceEpoch}_agent',
          sender: VoiceConversationSender.agent,
          text: text,
          timestamp: DateTime.now(),
          metadata: metadata,
        ),
      ],
    );
  }

  /// Get the most recent message
  VoiceConversationMessage? get lastMessage =>
      messages.isNotEmpty ? messages.last : null;

  /// Count messages by sender
  int get userMessageCount =>
      messages.where((m) => m.sender == VoiceConversationSender.user).length;
  int get agentMessageCount =>
      messages.where((m) => m.sender == VoiceConversationSender.agent).length;

  @override
  List<Object?> get props => [sessionId, startedAt, endedAt, messages, language, sessionMetadata];
}
