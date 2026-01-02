import 'package:equatable/equatable.dart';

class ReferralCodeEntity extends Equatable {
  final int id;
  final int userId;
  final String code;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ReferralCodeEntity({
    required this.id,
    required this.userId,
    required this.code,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  ReferralCodeEntity copyWith({
    int? id,
    int? userId,
    String? code,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ReferralCodeEntity(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      code: code ?? this.code,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [id, userId, code, isActive, createdAt, updatedAt];

  @override
  String toString() {
    return 'ReferralCodeEntity(id: $id, userId: $userId, code: $code, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
