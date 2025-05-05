import 'package:equatable/equatable.dart';
import 'dart:io'; // Keep File? for image if needed, or use String path

class ChatMessageEntity extends Equatable {
  final String text;
  final bool isUser;
  final DateTime timestamp;
  final File? image; // Or String? imagePath;

  const ChatMessageEntity({
    required this.text,
    required this.isUser,
    required this.timestamp,
    this.image, // Or imagePath
  });

  @override
  List<Object?> get props => [text, isUser, timestamp, image]; // Add imagePath if used

  // Optional: Add copyWith, toJson, fromJson if needed later
} 