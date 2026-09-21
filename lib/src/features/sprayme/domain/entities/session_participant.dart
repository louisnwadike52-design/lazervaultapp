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
  bool get isCoHost => role == 'cohost';

  /// Host or co-host — i.e. allowed to publish into the live.
  bool get isBroadcaster => isHost || isCoHost;

  bool get isSeated => seatState == 'seated';
  bool get hasRequestedSeat => seatState == 'requested';

  /// Normalises a participant role from the wire.
  ///
  /// lifestyle-gateway emits `p.Role.String()`, which for a protobuf enum is
  /// the CONSTANT NAME — `PARTICIPANT_ROLE_COHOST`, not `cohost`. Every
  /// comparison in the app was written against the short form, so `isHost` was
  /// always false, and the "bring someone on stage" sheet read an existing
  /// co-host as a plain viewer: it offered Invite to someone already on stage
  /// and never offered Remove.
  ///
  /// `seat_state` deliberately gets NO normalisation — it is a plain string
  /// column ("" | "requested" | "seated"), not an enum, so it already arrives
  /// in the form the app compares against.
  static String normalizeRole(String? raw) {
    var s = (raw ?? '').trim();
    if (s.isEmpty) return 'participant';
    s = s.toUpperCase();
    const prefix = 'PARTICIPANT_ROLE_';
    if (s.startsWith(prefix)) s = s.substring(prefix.length);
    if (s == 'UNSPECIFIED') return 'participant';
    return s.toLowerCase();
  }

  factory SessionParticipant.fromJson(Map<String, dynamic> json) {
    return SessionParticipant(
      userId: json['user_id'] as String? ?? '',
      userName: json['user_name'] as String? ?? '',
      avatarUrl: json['avatar_url'] as String? ?? '',
      role: normalizeRole(json['role'] as String?),
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
