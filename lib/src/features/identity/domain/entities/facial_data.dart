import 'package:equatable/equatable.dart';

class FacialData extends Equatable {
  final String id;
  final int userId;
  final String? faceId;
  final String? imageUrl;
  final bool isVerified;
  final DateTime createdAt;
  final DateTime? lastVerifiedAt;

  const FacialData({
    required this.id,
    required this.userId,
    this.faceId,
    this.imageUrl,
    required this.isVerified,
    required this.createdAt,
    this.lastVerifiedAt,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        faceId,
        imageUrl,
        isVerified,
        createdAt,
        lastVerifiedAt,
      ];

  FacialData copyWith({
    String? id,
    int? userId,
    String? faceId,
    String? imageUrl,
    bool? isVerified,
    DateTime? createdAt,
    DateTime? lastVerifiedAt,
  }) {
    return FacialData(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      faceId: faceId ?? this.faceId,
      imageUrl: imageUrl ?? this.imageUrl,
      isVerified: isVerified ?? this.isVerified,
      createdAt: createdAt ?? this.createdAt,
      lastVerifiedAt: lastVerifiedAt ?? this.lastVerifiedAt,
    );
  }
}
