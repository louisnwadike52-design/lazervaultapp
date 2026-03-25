class SprayComment {
  final String id;
  final String sessionId;
  final String userId;
  final String userName;
  final String avatarUrl;
  final String text;
  final DateTime createdAt;

  const SprayComment({
    required this.id,
    required this.sessionId,
    required this.userId,
    required this.userName,
    this.avatarUrl = '',
    required this.text,
    required this.createdAt,
  });

  factory SprayComment.fromJson(Map<String, dynamic> json) {
    return SprayComment(
      id: json['id'] as String? ?? '',
      sessionId: json['session_id'] as String? ?? '',
      userId: json['user_id'] as String? ?? '',
      userName: json['user_name'] as String? ?? '',
      avatarUrl: json['avatar_url'] as String? ?? '',
      text: json['text'] as String? ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'] as String) ?? DateTime.now()
          : DateTime.now(),
    );
  }
}
