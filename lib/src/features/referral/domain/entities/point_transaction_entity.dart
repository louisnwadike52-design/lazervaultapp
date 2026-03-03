import 'package:equatable/equatable.dart';

enum PointSource {
  referral,
  signupBonus,
  firstTransaction,
  monthlyActive,
  achievement,
  redemption,
}

class PointTransactionEntity extends Equatable {
  final int id;
  final int userId;
  final int points;
  final PointSource source;
  final String referenceId;
  final String description;
  final DateTime createdAt;

  const PointTransactionEntity({
    required this.id,
    required this.userId,
    required this.points,
    required this.source,
    this.referenceId = '',
    this.description = '',
    required this.createdAt,
  });

  bool get isEarning => points > 0;
  bool get isRedemption => points < 0;

  PointTransactionEntity copyWith({
    int? id,
    int? userId,
    int? points,
    PointSource? source,
    String? referenceId,
    String? description,
    DateTime? createdAt,
  }) {
    return PointTransactionEntity(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      points: points ?? this.points,
      source: source ?? this.source,
      referenceId: referenceId ?? this.referenceId,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [id, userId, points, source, referenceId, description, createdAt];

  @override
  String toString() {
    return 'PointTransactionEntity(id: $id, points: $points, source: $source, description: $description)';
  }
}
