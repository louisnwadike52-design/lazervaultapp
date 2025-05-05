import 'package:equatable/equatable.dart';

class SessionEntity extends Equatable {
  final String id;
  final String userId;
  final String accessToken;
  final String refreshToken;
  final DateTime accessTokenExpiresAt;
  final DateTime refreshTokenExpiresAt;

  const SessionEntity({
    required this.id,
    required this.userId,
    required this.accessToken,
    required this.refreshToken,
    required this.accessTokenExpiresAt,
    required this.refreshTokenExpiresAt,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        accessToken,
        refreshToken,
        accessTokenExpiresAt,
        refreshTokenExpiresAt,
      ];
} 