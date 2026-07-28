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
  // Fraud-detection ⚠️ warning for the current viewer (set when the OTHER
  // participant's message was flagged). Silent for the flagged sender.
  final bool safetyWarning;
  final String? safetyWarningLevel;
  final String? safetyWarningReason;
  // This viewer's per-user archive flag — drives the Chats vs Archived pill.
  // (Per-user "deleted" conversations aren't returned by the server at all.)
  final bool isArchived;

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
    this.safetyWarning = false,
    this.safetyWarningLevel,
    this.safetyWarningReason,
    this.isArchived = false,
  });

  P2PConversationEntity copyWith({
    String? id,
    String? participant1Id,
    String? participant2Id,
    String? lastMessagePreview,
    DateTime? lastMessageAt,
    DateTime? createdAt,
    int? unreadCount,
    String? otherUserId,
    String? otherUserName,
    String? otherUserAvatar,
    String? connectionStatus,
    String? initiatedBy,
    bool? safetyWarning,
    String? safetyWarningLevel,
    String? safetyWarningReason,
    bool? isArchived,
  }) {
    return P2PConversationEntity(
      id: id ?? this.id,
      participant1Id: participant1Id ?? this.participant1Id,
      participant2Id: participant2Id ?? this.participant2Id,
      lastMessagePreview: lastMessagePreview ?? this.lastMessagePreview,
      lastMessageAt: lastMessageAt ?? this.lastMessageAt,
      createdAt: createdAt ?? this.createdAt,
      unreadCount: unreadCount ?? this.unreadCount,
      otherUserId: otherUserId ?? this.otherUserId,
      otherUserName: otherUserName ?? this.otherUserName,
      otherUserAvatar: otherUserAvatar ?? this.otherUserAvatar,
      connectionStatus: connectionStatus ?? this.connectionStatus,
      initiatedBy: initiatedBy ?? this.initiatedBy,
      safetyWarning: safetyWarning ?? this.safetyWarning,
      safetyWarningLevel: safetyWarningLevel ?? this.safetyWarningLevel,
      safetyWarningReason: safetyWarningReason ?? this.safetyWarningReason,
      isArchived: isArchived ?? this.isArchived,
    );
  }
}
