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
  });

  @override
  List<Object?> get props => [text, isUser, timestamp, serviceRoutedTo, mediaType];

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
    );
  }
}
