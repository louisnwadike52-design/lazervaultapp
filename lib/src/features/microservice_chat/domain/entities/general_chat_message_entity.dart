import 'package:equatable/equatable.dart';

/// Message entity for general chat (through gateway)
class GeneralChatMessageEntity extends Equatable {
  final String text;
  final bool isUser;
  final DateTime timestamp;
  final String? serviceRoutedTo;
  final Map<String, dynamic>? metadata;

  const GeneralChatMessageEntity({
    required this.text,
    required this.isUser,
    required this.timestamp,
    this.serviceRoutedTo,
    this.metadata,
  });

  @override
  List<Object?> get props => [text, isUser, timestamp, serviceRoutedTo];

  GeneralChatMessageEntity copyWith({
    String? text,
    bool? isUser,
    DateTime? timestamp,
    String? serviceRoutedTo,
    Map<String, dynamic>? metadata,
  }) {
    return GeneralChatMessageEntity(
      text: text ?? this.text,
      isUser: isUser ?? this.isUser,
      timestamp: timestamp ?? this.timestamp,
      serviceRoutedTo: serviceRoutedTo ?? this.serviceRoutedTo,
      metadata: metadata ?? this.metadata,
    );
  }
}
