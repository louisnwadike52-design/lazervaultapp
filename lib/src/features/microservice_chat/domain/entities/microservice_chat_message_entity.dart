import 'package:equatable/equatable.dart';

class MicroserviceChatMessageEntity extends Equatable {
  final String text;
  final bool isUser;
  final DateTime timestamp;
  final String? serviceRoutedTo;
  final Map<String, dynamic>? sentiment;
  final Map<String, dynamic>? metadata; // receipt_data, visual_feedback, etc.
  final String? mediaType; // 'image' | 'voice' | null
  final String? mediaUrl; // Server URL for stored media
  final String? localMediaPath; // Local file path (before upload / for preview)
  final int? audioDurationMs; // Voice note duration in milliseconds
  final String? transcript; // Voice note transcription text

  const MicroserviceChatMessageEntity({
    required this.text,
    required this.isUser,
    required this.timestamp,
    this.serviceRoutedTo,
    this.sentiment,
    this.metadata,
    this.mediaType,
    this.mediaUrl,
    this.localMediaPath,
    this.audioDurationMs,
    this.transcript,
  });

  @override
  List<Object?> get props => [
        text,
        isUser,
        timestamp,
        serviceRoutedTo,
        sentiment,
        metadata,
        mediaType,
        mediaUrl,
        localMediaPath,
        audioDurationMs,
        transcript,
      ];

  MicroserviceChatMessageEntity copyWith({
    String? text,
    bool? isUser,
    DateTime? timestamp,
    String? serviceRoutedTo,
    Map<String, dynamic>? sentiment,
    Map<String, dynamic>? metadata,
    String? mediaType,
    String? mediaUrl,
    String? localMediaPath,
    int? audioDurationMs,
    String? transcript,
  }) {
    return MicroserviceChatMessageEntity(
      text: text ?? this.text,
      isUser: isUser ?? this.isUser,
      timestamp: timestamp ?? this.timestamp,
      serviceRoutedTo: serviceRoutedTo ?? this.serviceRoutedTo,
      sentiment: sentiment ?? this.sentiment,
      metadata: metadata ?? this.metadata,
      mediaType: mediaType ?? this.mediaType,
      mediaUrl: mediaUrl ?? this.mediaUrl,
      localMediaPath: localMediaPath ?? this.localMediaPath,
      audioDurationMs: audioDurationMs ?? this.audioDurationMs,
      transcript: transcript ?? this.transcript,
    );
  }
}
