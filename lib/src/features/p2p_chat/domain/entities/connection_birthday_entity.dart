/// One financial connection's upcoming birthday, as served by
/// p2p-chat-service `GET /api/v1/chat/connections/birthdays`.
class ConnectionBirthdayEntity {
  final String userId;
  final String name;
  final String dateOfBirth; // ISO YYYY-MM-DD
  final int daysUntil; // 0 = today, 1 = tomorrow, …
  final bool isToday;
  final String nextBirthday; // ISO date of the next occurrence

  const ConnectionBirthdayEntity({
    required this.userId,
    required this.name,
    required this.dateOfBirth,
    required this.daysUntil,
    required this.isToday,
    required this.nextBirthday,
  });

  factory ConnectionBirthdayEntity.fromJson(Map<String, dynamic> j) {
    return ConnectionBirthdayEntity(
      userId: (j['user_id'] ?? '').toString(),
      name: (j['name'] ?? '').toString(),
      dateOfBirth: (j['date_of_birth'] ?? '').toString(),
      daysUntil: (j['days_until'] as num?)?.toInt() ?? 0,
      isToday: j['is_today'] == true,
      nextBirthday: (j['next_birthday'] ?? '').toString(),
    );
  }

  /// "Today", "Tomorrow", or "in N days".
  String get whenLabel {
    if (isToday || daysUntil == 0) return 'Today';
    if (daysUntil == 1) return 'Tomorrow';
    return 'in $daysUntil days';
  }
}
