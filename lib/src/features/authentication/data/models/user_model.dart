import 'dart:convert';

import 'package:lazervault/core/types/typedef.dart';
import 'package:lazervault/src/features/authentication/domain/entities/user.dart';
import 'package:lazervault/src/generated/common.pb.dart' as common_pb;
import 'package:lazervault/src/generated/google/protobuf/timestamp.pb.dart' as timestamp_pb;
import 'package:fixnum/fixnum.dart';

// Helper from SessionModel (could be moved to a common place)
DateTime _timestampToDateTime(timestamp_pb.Timestamp timestamp) {
  final seconds = timestamp.hasSeconds() ? timestamp.seconds : Int64.ZERO;
  final nanos = timestamp.hasNanos() ? timestamp.nanos : 0;
  return DateTime.fromMillisecondsSinceEpoch(
      seconds.toInt() * 1000 + nanos ~/ 1000000);
}

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.firstName,
    required super.lastName,
      required super.email,
    super.phoneNumber,
    super.role,
    required super.verified,
    required super.isEmailVerified,
    required super.createdAt,
    required super.updatedAt,
  });

  static final UserModel empty =
      UserModel(
            id: '1',
            firstName: '_empty.firstName',
            lastName: '_empty.lastName',
            email: '_empty.email',
            phoneNumber: '_empty.phoneNumber',
            role: '_empty.role',
            verified: false,
            isEmailVerified: false,
            createdAt: DateTime.fromMillisecondsSinceEpoch(0),
            updatedAt: DateTime.fromMillisecondsSinceEpoch(0));

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(jsonDecode(source) as DataMap);

  factory UserModel.fromProto(common_pb.User protoUser) {
    return UserModel(
      id: protoUser.id.toString(), // Convert Int64 id
      firstName: protoUser.firstName,
      lastName: protoUser.lastName,
      email: protoUser.email,
      phoneNumber: protoUser.hasPhoneNumber() ? protoUser.phoneNumber : null,
      role: protoUser.hasRole() ? protoUser.role : null,
      verified: protoUser.verified,
      isEmailVerified: protoUser.isEmailVerified,
      createdAt: _timestampToDateTime(protoUser.createdAt),
      updatedAt: _timestampToDateTime(protoUser.updatedAt),
    );
  }

  UserModel copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? role,
    bool? verified,
    bool? isEmailVerified,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserModel(
        id: id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        role: role ?? this.role,
        verified: verified ?? this.verified,
        isEmailVerified: isEmailVerified ?? this.isEmailVerified,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt);
  }

  UserModel.fromMap(DataMap map)
      : this(
          id: map['id'] as String,
          firstName: map['firstName'] as String,
          lastName: map['lastName'] as String,
          email: map['email'] as String,
          phoneNumber: map['phoneNumber'] as String?,
          role: map['role'] as String?,
          verified: map['verified'] as bool,
          isEmailVerified: map['isEmailVerified'] as bool,
          createdAt: map['createdAt'] as DateTime,
          updatedAt: map['updatedAt'] as DateTime);

  DataMap toMap() =>
      {"id": id, "firstName": firstName, "lastName": lastName, "email": email, "phoneNumber": phoneNumber, "role": role, "verified": verified, "isEmailVerified": isEmailVerified, "createdAt": createdAt, "updatedAt": updatedAt};

  String toJson() => jsonEncode(toMap());
}
