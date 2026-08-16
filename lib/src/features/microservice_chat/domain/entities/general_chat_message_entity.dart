import 'package:equatable/equatable.dart';

/// Message entity for general chat (through gateway)
class GeneralChatMessageEntity extends Equatable {
  final String text;
  final bool isUser;
  final DateTime timestamp;
  final String? serviceRoutedTo;
  final Map<String, dynamic>? metadata;
  final String? mediaType; // 'image' | 'voice' | null
  final String? mediaUrl; // Server URL for stored media
  final String? localMediaPath; // Local file path (before upload / for preview)
  final int? audioDurationMs; // Voice note duration in milliseconds
  final String? transcript; // Voice note transcription text
  // Swipe-to-reply context: snippet + author of the earlier chat message this
  // (user) message was sent in reply to, so the sent bubble renders the quoted
  // "replied message" block above its own text.
  final String? replyToText;
  final bool? replyToIsUser;

  const GeneralChatMessageEntity({
    required this.text,
    required this.isUser,
    required this.timestamp,
    this.serviceRoutedTo,
    this.metadata,
    this.mediaType,
    this.mediaUrl,
    this.localMediaPath,
    this.audioDurationMs,
    this.transcript,
    this.replyToText,
    this.replyToIsUser,
  });

  @override
  List<Object?> get props =>
      [text, isUser, timestamp, serviceRoutedTo, mediaType, replyToText];

  GeneralChatMessageEntity copyWith({
    String? text,
    bool? isUser,
    DateTime? timestamp,
    String? serviceRoutedTo,
    Map<String, dynamic>? metadata,
    String? mediaType,
    String? mediaUrl,
    String? localMediaPath,
    int? audioDurationMs,
    String? transcript,
    String? replyToText,
    bool? replyToIsUser,
  }) {
    return GeneralChatMessageEntity(
      text: text ?? this.text,
      isUser: isUser ?? this.isUser,
      timestamp: timestamp ?? this.timestamp,
      serviceRoutedTo: serviceRoutedTo ?? this.serviceRoutedTo,
      metadata: metadata ?? this.metadata,
      mediaType: mediaType ?? this.mediaType,
      mediaUrl: mediaUrl ?? this.mediaUrl,
      localMediaPath: localMediaPath ?? this.localMediaPath,
      audioDurationMs: audioDurationMs ?? this.audioDurationMs,
      transcript: transcript ?? this.transcript,
      replyToText: replyToText ?? this.replyToText,
      replyToIsUser: replyToIsUser ?? this.replyToIsUser,
    );
  }
}
