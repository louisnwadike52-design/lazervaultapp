class SessionParticipant {
  final String userId;
  final String userName;
  final String avatarUrl;
  final String role;
  final bool isOnline;
  final int totalSprayed;
  final int totalGifts;
  final int totalLikes;
  final DateTime joinedAt;

  const SessionParticipant({
    required this.userId,
    required this.userName,
    this.avatarUrl = '',
    this.role = 'participant',
    this.isOnline = false,
    this.totalSprayed = 0,
    this.totalGifts = 0,
    this.totalLikes = 0,
    required this.joinedAt,
  });

  bool get isHost => role == 'host';

  factory SessionParticipant.fromJson(Map<String, dynamic> json) {
    return SessionParticipant(
      userId: json['user_id'] as String? ?? '',
      userName: json['user_name'] as String? ?? '',
      avatarUrl: json['avatar_url'] as String? ?? '',
      role: json['role'] as String? ?? 'participant',
      isOnline: json['is_online'] as bool? ?? false,
      totalSprayed: (json['total_sprayed'] as num?)?.toInt() ?? 0,
      totalGifts: (json['total_gifts'] as num?)?.toInt() ?? 0,
      totalLikes: (json['total_likes'] as num?)?.toInt() ?? 0,
      joinedAt: json['joined_at'] != null
          ? DateTime.tryParse(json['joined_at'] as String) ?? DateTime.now()
          : DateTime.now(),
    );
  }
}
