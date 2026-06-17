class P2PConversationEntity {
  final String id;
  final String participant1Id;
  final String participant2Id;
  final String? lastMessagePreview;
  final DateTime? lastMessageAt;
  final DateTime createdAt;
  final int unreadCount;
  final String otherUserId;
  final String? otherUserName;
  final String? otherUserAvatar;
  final String connectionStatus;
  final String? initiatedBy;

  const P2PConversationEntity({
    required this.id,
    required this.participant1Id,
    required this.participant2Id,
    this.lastMessagePreview,
    this.lastMessageAt,
    required this.createdAt,
    this.unreadCount = 0,
    required this.otherUserId,
    this.otherUserName,
    this.otherUserAvatar,
    this.connectionStatus = 'accepted',
    this.initiatedBy,
  });
}
