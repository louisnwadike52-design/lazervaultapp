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
  final int seatIndex; // 0-based guest "box" slot; -1 when not seated
  final String seatState; // "" | "requested" | "seated"

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
    this.seatIndex = -1,
    this.seatState = '',
  });

  bool get isHost => role == 'host';
  bool get isSeated => seatState == 'seated';
  bool get hasRequestedSeat => seatState == 'requested';

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
      seatIndex: (json['seat_index'] as num?)?.toInt() ?? -1,
      seatState: json['seat_state'] as String? ?? '',
    );
  }
}
