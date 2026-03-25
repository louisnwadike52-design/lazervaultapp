class SessionStats {
  final String sessionId;
  final int totalSprayed;
  final int totalGiftsValue;
  final int totalGiftsCount;
  final int totalLikes;
  final int totalParticipants;
  final int activeParticipants;
  final List<TopSprayer> topSprayers;
  final List<GiftBreakdown> giftBreakdown;
  final String currency;

  const SessionStats({
    required this.sessionId,
    this.totalSprayed = 0,
    this.totalGiftsValue = 0,
    this.totalGiftsCount = 0,
    this.totalLikes = 0,
    this.totalParticipants = 0,
    this.activeParticipants = 0,
    this.topSprayers = const [],
    this.giftBreakdown = const [],
    this.currency = 'NGN',
  });

  factory SessionStats.fromJson(Map<String, dynamic> json) {
    return SessionStats(
      sessionId: json['session_id'] as String? ?? '',
      totalSprayed: (json['total_sprayed'] as num?)?.toInt() ?? 0,
      totalGiftsValue: (json['total_gifts_value'] as num?)?.toInt() ?? 0,
      totalGiftsCount: (json['total_gifts_count'] as num?)?.toInt() ?? 0,
      totalLikes: (json['total_likes'] as num?)?.toInt() ?? 0,
      totalParticipants: (json['total_participants'] as num?)?.toInt() ?? 0,
      activeParticipants: (json['active_participants'] as num?)?.toInt() ?? 0,
      topSprayers: (json['top_sprayers'] as List<dynamic>?)
              ?.map((e) => TopSprayer.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      giftBreakdown: (json['gift_breakdown'] as List<dynamic>?)
              ?.map((e) => GiftBreakdown.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      currency: json['currency'] as String? ?? 'NGN',
    );
  }
}

class TopSprayer {
  final String userId;
  final String userName;
  final String avatarUrl;
  final int totalAmount;
  final int rank;

  const TopSprayer({
    required this.userId,
    required this.userName,
    this.avatarUrl = '',
    this.totalAmount = 0,
    this.rank = 0,
  });

  factory TopSprayer.fromJson(Map<String, dynamic> json) {
    return TopSprayer(
      userId: json['user_id'] as String? ?? '',
      userName: json['user_name'] as String? ?? '',
      avatarUrl: json['avatar_url'] as String? ?? '',
      totalAmount: (json['total_amount'] as num?)?.toInt() ?? 0,
      rank: (json['rank'] as num?)?.toInt() ?? 0,
    );
  }
}

class GiftBreakdown {
  final String giftId;
  final String giftName;
  final String giftEmoji;
  final int count;
  final int totalValue;

  const GiftBreakdown({
    required this.giftId,
    required this.giftName,
    this.giftEmoji = '',
    this.count = 0,
    this.totalValue = 0,
  });

  factory GiftBreakdown.fromJson(Map<String, dynamic> json) {
    return GiftBreakdown(
      giftId: json['gift_id'] as String? ?? '',
      giftName: json['gift_name'] as String? ?? '',
      giftEmoji: json['gift_emoji'] as String? ?? '',
      count: (json['count'] as num?)?.toInt() ?? 0,
      totalValue: (json['total_value'] as num?)?.toInt() ?? 0,
    );
  }
}

class MySprayStats {
  final int totalSprayed;
  final int totalReceived;
  final int totalFunded;
  final int totalWithdrawn;
  final int sessionsHosted;
  final int sessionsJoined;
  final int totalGiftsSent;
  final int totalGiftsReceived;
  final int totalLikesGiven;
  final int totalLikesReceived;
  final String currency;

  const MySprayStats({
    this.totalSprayed = 0,
    this.totalReceived = 0,
    this.totalFunded = 0,
    this.totalWithdrawn = 0,
    this.sessionsHosted = 0,
    this.sessionsJoined = 0,
    this.totalGiftsSent = 0,
    this.totalGiftsReceived = 0,
    this.totalLikesGiven = 0,
    this.totalLikesReceived = 0,
    this.currency = 'NGN',
  });

  int get totalSessions => sessionsHosted + sessionsJoined;

  factory MySprayStats.fromJson(Map<String, dynamic> json) {
    return MySprayStats(
      totalSprayed: (json['total_sprayed'] as num?)?.toInt() ?? 0,
      totalReceived: (json['total_received'] as num?)?.toInt() ?? 0,
      totalFunded: (json['total_funded'] as num?)?.toInt() ?? 0,
      totalWithdrawn: (json['total_withdrawn'] as num?)?.toInt() ?? 0,
      sessionsHosted: (json['sessions_hosted'] as num?)?.toInt() ?? 0,
      sessionsJoined: (json['sessions_joined'] as num?)?.toInt() ?? 0,
      totalGiftsSent: (json['total_gifts_sent'] as num?)?.toInt() ?? 0,
      totalGiftsReceived: (json['total_gifts_received'] as num?)?.toInt() ?? 0,
      totalLikesGiven: (json['total_likes_given'] as num?)?.toInt() ?? 0,
      totalLikesReceived: (json['total_likes_received'] as num?)?.toInt() ?? 0,
      currency: json['currency'] as String? ?? 'NGN',
    );
  }
}
