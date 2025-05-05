class ChatMessageModel {
  final int? id;
  final String userFrom;
  final String userTo;
  final String message;
  final DateTime timestamp;
  final int? replyToId;
  final String messageType;

  ChatMessageModel({
    this.id,
    required this.userFrom,
    required this.userTo,
    required this.message,
    required this.timestamp,
    this.replyToId,
    required this.messageType,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_from': userFrom,
      'user_to': userTo,
      'message': message,
      'timestamp': timestamp.toIso8601String(),
      'reply_to_id': replyToId,
      'message_type': messageType,
    };
  }

  factory ChatMessageModel.fromMap(Map<String, dynamic> map) {
    return ChatMessageModel(
      id: map['id'],
      userFrom: map['user_from'],
      userTo: map['user_to'],
      message: map['message'],
      timestamp: DateTime.parse(map['timestamp']),
      replyToId: map['reply_to_id'],
      messageType: map['message_type'],
    );
  }

  ChatMessageModel copyWith({int? id}) {
    return ChatMessageModel(
      id: id ?? this.id,
      userFrom: userFrom,
      userTo: userTo,
      message: message,
      timestamp: timestamp,
      replyToId: replyToId,
      messageType: messageType,
    );
  }
}
