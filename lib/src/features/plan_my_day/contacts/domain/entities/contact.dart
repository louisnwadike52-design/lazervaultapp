import 'package:lazervault/src/features/plan_my_day/domain/entities/plan_timestamp.dart';

/// A CRM contact (person) in Plan My Day. Served as JSON by the lifestyle
/// gateway; protobuf Timestamps arrive as {"seconds":N,"nanos":M}, so the date
/// fields go through parsePlanTimestamp (same as Task/Event).
class Contact {
  final String id;
  final String userId;
  final String name;
  final String? email;
  final String? phone;
  final String? company;
  final String? role;
  final String? notes;
  final List<String> tags;
  final String? avatarColor;
  final DateTime? lastContactedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Contact({
    required this.id,
    required this.userId,
    required this.name,
    this.email,
    this.phone,
    this.company,
    this.role,
    this.notes,
    this.tags = const [],
    this.avatarColor,
    this.lastContactedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      id: json['id'] as String? ?? '',
      userId: json['user_id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      email: _nullIfEmpty(json['email']),
      phone: _nullIfEmpty(json['phone']),
      company: _nullIfEmpty(json['company']),
      role: _nullIfEmpty(json['role']),
      notes: _nullIfEmpty(json['notes']),
      tags: (json['tags'] as List<dynamic>?)?.cast<String>() ?? const [],
      avatarColor: _nullIfEmpty(json['avatar_color']),
      lastContactedAt: parsePlanTimestamp(json['last_contacted_at']),
      createdAt: parsePlanTimestamp(json['created_at']),
      updatedAt: parsePlanTimestamp(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        if (email != null) 'email': email,
        if (phone != null) 'phone': phone,
        if (company != null) 'company': company,
        if (role != null) 'role': role,
        if (notes != null) 'notes': notes,
        'tags': tags,
        if (avatarColor != null) 'avatar_color': avatarColor,
      };

  String get initials {
    final parts =
        name.trim().split(RegExp(r'\s+')).where((p) => p.isNotEmpty).toList();
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return (parts.first.substring(0, 1) + parts.last.substring(0, 1))
        .toUpperCase();
  }

  static String? _nullIfEmpty(dynamic v) {
    if (v == null) return null;
    final s = v as String;
    return s.isEmpty ? null : s;
  }
}
