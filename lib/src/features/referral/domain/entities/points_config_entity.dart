import 'package:equatable/equatable.dart';

class PointsConfigEntity extends Equatable {
  final String source;
  final int pointsAmount;
  final String description;
  final bool isActive;

  const PointsConfigEntity({
    required this.source,
    required this.pointsAmount,
    required this.description,
    this.isActive = true,
  });

  @override
  List<Object?> get props => [source, pointsAmount, description, isActive];

  @override
  String toString() {
    return 'PointsConfigEntity(source: $source, points: $pointsAmount, description: $description)';
  }
}
