import 'package:fixnum/fixnum.dart';
import 'package:lazervault/src/generated/contact_sync.pb.dart' as pb;
import 'package:lazervault/src/generated/google/protobuf/timestamp.pb.dart' as timestamp;

/// Model representing a contact synced to the backend
class SyncedContactModel {
  final String id;
  final String userId;
  final String name;
  final List<String> phoneNumbers;
  final List<String> emails;
  final String? photoUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String deviceContactId;
  final bool isLazervaultUser;
  final String? lazervaultUserId;
  final String? lazervaultUsername;

  const SyncedContactModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.phoneNumbers,
    required this.emails,
    this.photoUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.deviceContactId,
    required this.isLazervaultUser,
    this.lazervaultUserId,
    this.lazervaultUsername,
  });

  /// Creates model from proto message
  factory SyncedContactModel.fromProto(pb.SyncedContact proto) {
    return SyncedContactModel(
      id: proto.id,
      userId: proto.userId,
      name: proto.name,
      phoneNumbers: proto.phoneNumbers,
      emails: proto.emails,
      photoUrl: proto.photoUrl.isNotEmpty ? proto.photoUrl : null,
      createdAt: DateTime.fromMillisecondsSinceEpoch(
        proto.createdAt.seconds.toInt() * 1000,
      ),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(
        proto.updatedAt.seconds.toInt() * 1000,
      ),
      deviceContactId: proto.deviceContactId,
      isLazervaultUser: proto.isLazervaultUser,
      lazervaultUserId: proto.lazervaultUserId.isNotEmpty
          ? proto.lazervaultUserId
          : null,
      lazervaultUsername: proto.lazervaultUsername.isNotEmpty
          ? proto.lazervaultUsername
          : null,
    );
  }

  /// Converts model to proto message
  pb.SyncedContact toProto() {
    return pb.SyncedContact()
      ..id = id
      ..userId = userId
      ..name = name
      ..phoneNumbers.addAll(phoneNumbers)
      ..emails.addAll(emails)
      ..photoUrl = photoUrl ?? ''
      ..createdAt = (timestamp.Timestamp()
        ..seconds = Int64(createdAt.millisecondsSinceEpoch ~/ 1000)
        ..nanos = 0)
      ..updatedAt = (timestamp.Timestamp()
        ..seconds = Int64(updatedAt.millisecondsSinceEpoch ~/ 1000)
        ..nanos = 0)
      ..deviceContactId = deviceContactId
      ..isLazervaultUser = isLazervaultUser
      ..lazervaultUserId = lazervaultUserId ?? ''
      ..lazervaultUsername = lazervaultUsername ?? '';
  }

  SyncedContactModel copyWith({
    String? id,
    String? userId,
    String? name,
    List<String>? phoneNumbers,
    List<String>? emails,
    String? photoUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? deviceContactId,
    bool? isLazervaultUser,
    String? lazervaultUserId,
    String? lazervaultUsername,
  }) {
    return SyncedContactModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      phoneNumbers: phoneNumbers ?? this.phoneNumbers,
      emails: emails ?? this.emails,
      photoUrl: photoUrl ?? this.photoUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deviceContactId: deviceContactId ?? this.deviceContactId,
      isLazervaultUser: isLazervaultUser ?? this.isLazervaultUser,
      lazervaultUserId: lazervaultUserId ?? this.lazervaultUserId,
      lazervaultUsername: lazervaultUsername ?? this.lazervaultUsername,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SyncedContactModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
