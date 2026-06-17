class Category {
  final String id;
  final String userId;
  final String name;
  final String? icon;
  final String? color;
  final String type; // event, task, both
  final DateTime createdAt;

  Category({
    required this.id,
    required this.userId,
    required this.name,
    this.icon,
    this.color,
    this.type = 'both',
    required this.createdAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      name: json['name'] as String,
      icon: json['icon'] as String?,
      color: json['color'] as String?,
      type: json['type'] as String? ?? 'both',
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'name': name,
      'icon': icon,
      'color': color,
      'type': type,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
