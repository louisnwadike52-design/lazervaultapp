class SpraySession {
  final String id;
  final String hostUserId;
  final String hostName;
  final String hostAvatarUrl;
  final String title;
  final String description;
  final String occasionType;
  final String sessionCode;
  final String status;
  final int totalSprayed;
  final int totalGifts;
  final int totalLikes;
  final int participantCount;
  final String coverImageUrl;
  final String currency;
  final DateTime createdAt;
  final DateTime? endedAt;

  const SpraySession({
    required this.id,
    required this.hostUserId,
    required this.hostName,
    this.hostAvatarUrl = '',
    required this.title,
    this.description = '',
    required this.occasionType,
    required this.sessionCode,
    required this.status,
    this.totalSprayed = 0,
    this.totalGifts = 0,
    this.totalLikes = 0,
    this.participantCount = 0,
    this.coverImageUrl = '',
    this.currency = 'NGN',
    required this.createdAt,
    this.endedAt,
  });

  double get totalSprayedMajor => totalSprayed / 100;
  bool get isActive => status == 'active';
  bool get isEnded => status == 'ended';

  factory SpraySession.fromJson(Map<String, dynamic> json) {
    return SpraySession(
      id: json['id'] as String? ?? '',
      hostUserId: json['host_user_id'] as String? ?? '',
      hostName: json['host_name'] as String? ?? '',
      hostAvatarUrl: json['host_avatar_url'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      occasionType: json['occasion_type'] as String? ?? '',
      sessionCode: json['session_code'] as String? ?? '',
      status: json['status'] as String? ?? 'active',
      totalSprayed: (json['total_sprayed'] as num?)?.toInt() ?? 0,
      totalGifts: (json['total_gifts'] as num?)?.toInt() ?? 0,
      totalLikes: (json['total_likes'] as num?)?.toInt() ?? 0,
      participantCount: (json['participant_count'] as num?)?.toInt() ?? 0,
      coverImageUrl: json['cover_image_url'] as String? ?? '',
      currency: json['currency'] as String? ?? 'NGN',
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'] as String) ?? DateTime.now()
          : DateTime.now(),
      endedAt: json['ended_at'] != null
          ? DateTime.tryParse(json['ended_at'] as String)
          : null,
    );
  }
}
