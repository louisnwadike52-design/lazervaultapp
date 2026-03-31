import 'dart:convert';

import 'package:lazervault/core/auth/jwt_payload.dart';
import 'package:lazervault/core/types/typedef.dart';
import 'package:lazervault/src/features/authentication/domain/entities/user.dart';
import 'package:lazervault/src/generated/auth.pb.dart' as auth_pb;
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
    super.username,
    super.role,
    super.roles,
    required super.verified,
    required super.isEmailVerified,
    required super.createdAt,
    required super.updatedAt,
    super.language,
    super.currency,
    super.country,
    super.profilePicture,
    super.signupStatus,
    super.hasPasscode = false,
    super.hasTransactionPin = false,
  });

  static final UserModel empty =
      UserModel(
            id: '1',
            firstName: '_empty.firstName',
            lastName: '_empty.lastName',
            email: '_empty.email',
            phoneNumber: '_empty.phoneNumber',
            username: '_empty.username',
            role: '_empty.role',
            roles: null,
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
      username: protoUser.username.isNotEmpty ? protoUser.username : null,
      role: protoUser.hasRole() ? protoUser.role : null,
      roles: protoUser.roles.isNotEmpty
          ? List<String>.from(protoUser.roles)
          : null,
      verified: protoUser.verified,
      isEmailVerified: protoUser.isEmailVerified,
      createdAt: _timestampToDateTime(protoUser.createdAt),
      updatedAt: _timestampToDateTime(protoUser.updatedAt),
      language: protoUser.hasLanguage() && protoUser.language.isNotEmpty ? protoUser.language : null,
      currency: protoUser.hasCurrency() && protoUser.currency.isNotEmpty ? protoUser.currency : null,
      country: protoUser.hasCountry() && protoUser.country.isNotEmpty ? protoUser.country : null,
      profilePicture: protoUser.hasProfilePicture() && protoUser.profilePicture.isNotEmpty ? protoUser.profilePicture : null,
    );
  }

  factory UserModel.fromAuthProto(auth_pb.User user) {
    return UserModel(
      id: user.id,
      firstName: user.firstName,
      lastName: user.lastName,
      email: user.email,
      phoneNumber: user.hasPhone() ? user.phone : null,
      username: user.username.isNotEmpty ? user.username : null,
      role: user.hasRole() && user.role.isNotEmpty ? user.role : null,
      roles: user.roles.isNotEmpty ? List<String>.from(user.roles) : null,
      verified: user.phoneVerified,
      isEmailVerified: user.emailVerified,
      profilePicture:
          user.profilePicture.isEmpty ? null : user.profilePicture,
      createdAt: DateTime.tryParse(user.createdAt) ?? DateTime.now(),
      updatedAt: DateTime.tryParse(user.updatedAt) ?? DateTime.now(),
      signupStatus:
          user.signupStatus.isNotEmpty ? user.signupStatus : null,
    );
  }

  /// Fills [role]/[roles] from JWT when the API user payload omits them.
  UserModel withRolesFromAccessToken(String accessToken) {
    final claims = decodeJwtPayload(accessToken);
    final jwtRoles = rolesFromJwtClaims(claims);
    final jwtRole = primaryRoleFromJwtClaims(claims);
    final needRoles = roles == null || roles!.isEmpty;
    final needRole = role == null || role!.isEmpty;
    if (!needRoles && !needRole) return this;
    return UserModel(
      id: id,
      firstName: firstName,
      lastName: lastName,
      email: email,
      phoneNumber: phoneNumber,
      username: username,
      role: needRole && jwtRole != null ? jwtRole : role,
      roles: needRoles && jwtRoles != null ? jwtRoles : roles,
      verified: verified,
      isEmailVerified: isEmailVerified,
      createdAt: createdAt,
      updatedAt: updatedAt,
      language: language,
      currency: currency,
      country: country,
      profilePicture: profilePicture,
      signupStatus: signupStatus,
      hasPasscode: hasPasscode,
      hasTransactionPin: hasTransactionPin,
    );
  }

  UserModel copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? username,
    String? role,
    List<String>? roles,
    bool? verified,
    bool? isEmailVerified,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? language,
    String? currency,
    String? country,
    String? profilePicture,
    String? signupStatus,
    bool? hasPasscode,
    bool? hasTransactionPin,
  }) {
    return UserModel(
        id: id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        username: username ?? this.username,
        role: role ?? this.role,
        roles: roles ?? this.roles,
        verified: verified ?? this.verified,
        isEmailVerified: isEmailVerified ?? this.isEmailVerified,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        language: language ?? this.language,
        currency: currency ?? this.currency,
        country: country ?? this.country,
        profilePicture: profilePicture ?? this.profilePicture,
        signupStatus: signupStatus ?? this.signupStatus,
        hasPasscode: hasPasscode ?? this.hasPasscode,
        hasTransactionPin: hasTransactionPin ?? this.hasTransactionPin);
  }

  UserModel.fromMap(DataMap map)
      : this(
          id: map['id'] as String,
          firstName: map['firstName'] as String,
          lastName: map['lastName'] as String,
          email: map['email'] as String,
          phoneNumber: map['phoneNumber'] as String?,
          username: map['username'] as String?,
          role: map['role'] as String?,
          roles: (map['roles'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
          verified: map['verified'] as bool,
          isEmailVerified: map['isEmailVerified'] as bool,
          createdAt: map['createdAt'] as DateTime,
          updatedAt: map['updatedAt'] as DateTime,
          signupStatus: map['signupStatus'] as String?,
          hasPasscode: map['hasPasscode'] as bool? ?? false,
          hasTransactionPin: map['hasTransactionPin'] as bool? ?? false);

  DataMap toMap() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "phoneNumber": phoneNumber,
        "username": username,
        "role": role,
        if (roles != null) "roles": roles,
        "verified": verified,
        "isEmailVerified": isEmailVerified,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "signupStatus": signupStatus,
        "hasPasscode": hasPasscode,
        "hasTransactionPin": hasTransactionPin,
      };

  String toJson() => jsonEncode(toMap());
}
