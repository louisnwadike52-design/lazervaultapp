import 'package:lazervault/src/features/authentication/domain/entities/session_entity.dart';
import 'package:lazervault/src/generated/common.pb.dart' as common_pb; // Import common proto containing Session
import 'package:lazervault/src/generated/google/protobuf/timestamp.pb.dart' as timestamp_pb; // Import timestamp proto
import 'package:fixnum/fixnum.dart';

// Helper to convert Protobuf Timestamp to Dart DateTime
DateTime _timestampToDateTime(timestamp_pb.Timestamp timestamp) { // Use correct Timestamp type
  // Ensure seconds and nanos are not null before conversion
  final seconds = timestamp.hasSeconds() ? timestamp.seconds : Int64.ZERO;
  final nanos = timestamp.hasNanos() ? timestamp.nanos : 0;
  return DateTime.fromMillisecondsSinceEpoch(
      seconds.toInt() * 1000 + nanos ~/ 1000000);
}

class SessionModel extends SessionEntity {
  const SessionModel({
    required super.id,
    required super.userId,
    required super.accessToken,
    required super.refreshToken,
    required super.accessTokenExpiresAt,
    required super.refreshTokenExpiresAt,
  });

  // Factory now correctly takes the Session message from common.pb.dart
  factory SessionModel.fromProto(common_pb.Session protoSession) {
    return SessionModel(
      id: protoSession.id,
      userId: protoSession.userId.toString(), // Convert Int64 userId if needed
      accessToken: protoSession.accessToken,
      refreshToken: protoSession.refreshToken,
      accessTokenExpiresAt: _timestampToDateTime(protoSession.accessTokenExpiresAt),
      refreshTokenExpiresAt: _timestampToDateTime(protoSession.refreshTokenExpiresAt),
    );
  }
} 