import 'package:equatable/equatable.dart';

class MicroserviceChatMessageEntity extends Equatable {
  final String text;
  final bool isUser;
  final DateTime timestamp;
  final String? serviceRoutedTo;
  final Map<String, dynamic>? sentiment;

  const MicroserviceChatMessageEntity({
    required this.text,
    required this.isUser,
    required this.timestamp,
    this.serviceRoutedTo,
    this.sentiment,
  });

  @override
  List<Object?> get props => [text, isUser, timestamp, serviceRoutedTo, sentiment];

  MicroserviceChatMessageEntity copyWith({
    String? text,
    bool? isUser,
    DateTime? timestamp,
    String? serviceRoutedTo,
    Map<String, dynamic>? sentiment,
  }) {
    return MicroserviceChatMessageEntity(
      text: text ?? this.text,
      isUser: isUser ?? this.isUser,
      timestamp: timestamp ?? this.timestamp,
      serviceRoutedTo: serviceRoutedTo ?? this.serviceRoutedTo,
      sentiment: sentiment ?? this.sentiment,
    );
  }
}
