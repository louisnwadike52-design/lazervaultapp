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
  final int totalLikes; // distinct likers
  final int totalLikeTaps; // lifetime taps (never resets) — TikTok-style
  final int liveLikeTaps; // current live segment ("at the moment")
  final int participantCount;
  final String coverImageUrl;
  final String currency;
  final DateTime createdAt;
  final DateTime? endedAt;
  // ── Live video streaming ──
  final bool isLive;
  final String streamType; // 'avatar' | 'live_video'
  final String livekitRoomName;
  final String streamTopology; // 'webrtc' | 'hls'
  final String hlsUrl;
  final bool recordingEnabled;
  final String recordingUrl;

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
    this.totalLikeTaps = 0,
    this.liveLikeTaps = 0,
    this.participantCount = 0,
    this.coverImageUrl = '',
    this.currency = 'NGN',
    required this.createdAt,
    this.endedAt,
    this.isLive = false,
    this.streamType = 'avatar',
    this.livekitRoomName = '',
    this.streamTopology = 'webrtc',
    this.hlsUrl = '',
    this.recordingEnabled = false,
    this.recordingUrl = '',
  });

  double get totalSprayedMajor => totalSprayed / 100;
  bool get isActive => status == 'active';
  bool get isEnded => status == 'ended';
  bool get isLiveVideo => isLive && streamType == 'live_video';

  SpraySession copyWith({
    bool? isLive,
    String? streamType,
    String? livekitRoomName,
    String? streamTopology,
    String? hlsUrl,
    bool? recordingEnabled,
    String? recordingUrl,
  }) {
    return SpraySession(
      id: id,
      hostUserId: hostUserId,
      hostName: hostName,
      hostAvatarUrl: hostAvatarUrl,
      title: title,
      description: description,
      occasionType: occasionType,
      sessionCode: sessionCode,
      status: status,
      totalSprayed: totalSprayed,
      totalGifts: totalGifts,
      totalLikes: totalLikes,
      totalLikeTaps: totalLikeTaps,
      liveLikeTaps: liveLikeTaps,
      participantCount: participantCount,
      coverImageUrl: coverImageUrl,
      currency: currency,
      createdAt: createdAt,
      endedAt: endedAt,
      isLive: isLive ?? this.isLive,
      streamType: streamType ?? this.streamType,
      livekitRoomName: livekitRoomName ?? this.livekitRoomName,
      streamTopology: streamTopology ?? this.streamTopology,
      hlsUrl: hlsUrl ?? this.hlsUrl,
      recordingEnabled: recordingEnabled ?? this.recordingEnabled,
      recordingUrl: recordingUrl ?? this.recordingUrl,
    );
  }

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
      totalLikeTaps: (json['total_like_taps'] as num?)?.toInt() ?? 0,
      liveLikeTaps: (json['live_like_taps'] as num?)?.toInt() ?? 0,
      participantCount: (json['participant_count'] as num?)?.toInt() ?? 0,
      coverImageUrl: json['cover_image_url'] as String? ?? '',
      currency: json['currency'] as String? ?? 'NGN',
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'] as String) ?? DateTime.now()
          : DateTime.now(),
      endedAt: json['ended_at'] != null
          ? DateTime.tryParse(json['ended_at'] as String)
          : null,
      isLive: json['is_live'] as bool? ?? false,
      streamType: json['stream_type'] as String? ?? 'avatar',
      livekitRoomName: json['livekit_room_name'] as String? ?? '',
      streamTopology: json['stream_topology'] as String? ?? 'webrtc',
      hlsUrl: json['hls_url'] as String? ?? '',
      recordingEnabled: json['recording_enabled'] as bool? ?? false,
      recordingUrl: json['recording_url'] as String? ?? '',
    );
  }
}
