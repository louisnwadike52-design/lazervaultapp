import 'dart:convert';

import 'dart:async';

import 'package:lazervault/core/config/feature_flags.dart';
import 'package:lazervault/core/auth/jwt_payload.dart';
import 'package:lazervault/core/types/typedef.dart';
import 'package:lazervault/src/features/authentication/domain/entities/postal_address.dart';
import 'package:lazervault/src/features/authentication/domain/entities/user.dart';
import 'package:lazervault/src/generated/auth.pb.dart' as auth_pb;
import 'package:lazervault/src/generated/common.pb.dart' as common_pb;
import 'package:lazervault/src/generated/google/protobuf/timestamp.pb.dart'
    as timestamp_pb;
import 'package:fixnum/fixnum.dart';

// Helper from SessionModel (could be moved to a common place)
DateTime _timestampToDateTime(timestamp_pb.Timestamp timestamp) {
  final seconds = timestamp.hasSeconds() ? timestamp.seconds : Int64.ZERO;
  final nanos = timestamp.hasNanos() ? timestamp.nanos : 0;
  return DateTime.fromMillisecondsSinceEpoch(
    seconds.toInt() * 1000 + nanos ~/ 1000000,
  );
}

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.firstName,
    super.middleName = '',
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
    super.currentSignupStep,
    super.hasPasscode = false,
    super.hasTransactionPin = false,
    super.mustChangeCredentials = false,
    super.hasPassword = false,
    super.preferredLoginMethod,
    super.authType,
    super.twoFactorEnabled = false,
    super.twoFactorMethod,
    super.kycTier = 0,
    super.identityVerified = false,
    super.kycStatus,
    super.dateOfBirth,
    super.address,
  });

  static final UserModel empty = UserModel(
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
    updatedAt: DateTime.fromMillisecondsSinceEpoch(0),
  );

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(jsonDecode(source) as DataMap);

  factory UserModel.fromProto(common_pb.User protoUser) {
    return UserModel(
      // `id` is a uint64 left over from numeric user ids. This platform uses
      // UUIDs, so the gateway's ParseUint always failed and this was literally
      // "0" for every user. The real id now arrives in `user_id`; fall back to
      // the old field only so an app running against an older gateway keeps its
      // existing (wrong, but unchanged) behaviour rather than going blank.
      id: protoUser.userId.isNotEmpty
          ? protoUser.userId
          : protoUser.id.toString(),
      firstName: protoUser.firstName,
      middleName: protoUser.middleName,
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
      language: protoUser.hasLanguage() && protoUser.language.isNotEmpty
          ? protoUser.language
          : null,
      currency: protoUser.hasCurrency() && protoUser.currency.isNotEmpty
          ? protoUser.currency
          : null,
      country: protoUser.hasCountry() && protoUser.country.isNotEmpty
          ? protoUser.country
          : null,
      profilePicture:
          protoUser.hasProfilePicture() && protoUser.profilePicture.isNotEmpty
          ? protoUser.profilePicture
          : null,
      address: PostalAddress(
        line1: protoUser.addressLine1,
        line2: protoUser.addressLine2,
        city: protoUser.addressCity,
        state: protoUser.addressState,
        postalCode: protoUser.addressPostalCode,
        country: protoUser.addressCountry,
      ),
      // NB: common_pb.User has no date_of_birth field — DOB is carried by the
      // auth proto (see fromAuthProto), which is what the profile/GetMe path uses.
    );
  }

  factory UserModel.fromAuthProto(auth_pb.User user) {
    // WHETHER *THIS* ACCOUNT CAN RECEIVE AN SMS CODE, STRAIGHT OFF THE WIRE.
    //
    // Cached HERE because this factory is the one point every auth response
    // passes through — login, 2FA, social, signup, GetMe and token refresh all
    // land on it. Recording it at the call sites instead would be a step each
    // of them has to remember, and the one that forgets is a resumption path
    // that silently falls back to the platform-wide answer.
    //
    // A side effect in a mapper is a real cost, accepted for that reason: see
    // FeatureFlags.smsAvailableForUser for why the client cannot compute this
    // itself, and SmsPolicy for how it is read (permissively, so a stale value
    // can never hide a channel that works).
    //
    // Fire-and-forget: nothing downstream waits on it, and the value is
    // re-sent on every subsequent response.
    unawaited(FeatureFlags.rememberSmsAvailableForUser(user.smsAvailable));

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
      twoFactorEnabled: user.twoFactorEnabled,
      twoFactorMethod: user.twoFactorMethod.isNotEmpty
          ? user.twoFactorMethod
          : null,
      profilePicture: user.profilePicture.isEmpty ? null : user.profilePicture,
      createdAt: DateTime.tryParse(user.createdAt) ?? DateTime.now(),
      updatedAt: DateTime.tryParse(user.updatedAt) ?? DateTime.now(),
      signupStatus: user.signupStatus.isNotEmpty ? user.signupStatus : null,
      currentSignupStep: user.currentSignupStep.isNotEmpty
          ? user.currentSignupStep
          : null,
      hasPassword: user.hasPassword,
      // An ADMIN set this account's login credential and the holder has not
      // replaced it. Read from EVERY auth response, not just login, because
      // biometric unlock, a warm start and a token refresh all rebuild the
      // user from one of these and must reach the same conclusion.
      //
      // REQUIRES A CURRENT auth.pb.dart. The checked-in generated file in git
      // is STALE — it predates the middle-name proto work — so the app does
      // not compile against HEAD's copy at all (auth_repository.dart passes
      // `middleName` to SignupRequest, which HEAD's generated code has no
      // field for). The regeneration from core-gateway's proto is what makes
      // both that and this field exist, and it has simply never been
      // committed. Regenerate before building; do not "restore" the generated
      // files from git.
      mustChangeCredentials: user.mustChangeCredentials,
      preferredLoginMethod: user.preferredLoginMethod.isNotEmpty
          ? user.preferredLoginMethod
          : null,
      // HOW the account was created. Carried because one gate needs it: a
      // SOCIAL account has no password and no passcode, so passcode setup is
      // an offer to it rather than the credential step it is for everyone
      // else. See User.isSocialAccount and resolvePostLoginRoute.
      authType: user.authType.isNotEmpty ? user.authType : null,
      dateOfBirth: user.dateOfBirth.isNotEmpty ? user.dateOfBirth : null,
      // Identity verification, straight off the proto. Every auth response
      // carries these (auth-service userToProto sets them for login, 2FA,
      // social and GetMe alike), so no gate needs a round-trip to learn
      // whether this holder is verified.
      kycTier: user.kycTier,
      // Guarded with has_x: `identity_verified` is a proto3 bool, so an older
      // gateway that never sets it is indistinguishable from one that sets it
      // false. Defaulting to false is the safe read — it leaves the server as
      // the authority on whether the date of birth may change, which is what
      // it was before this field was carried at all.
      identityVerified: user.hasIdentityVerified()
          ? user.identityVerified
          : false,
      kycStatus: user.kycStatus.isNotEmpty ? user.kycStatus : null,
      address: PostalAddress(
        line1: user.addressLine1,
        line2: user.addressLine2,
        city: user.addressCity,
        state: user.addressState,
        postalCode: user.addressPostalCode,
        country: user.addressCountry,
      ),
    );
  }

  /// Fills [role]/[roles] from JWT when the API user payload omits them.
  ///
  /// Uses [copyWith] rather than rebuilding the model field by field, and that
  /// is the whole point of this shape. The hand-written constructor call it
  /// replaced listed the fields it knew about, so every field added to the
  /// model after it was written was silently dropped on the way through —
  /// reset to its default, not carried.
  ///
  /// It had already happened: `twoFactorEnabled` and `twoFactorMethod` were
  /// missing, so for any account whose login response omitted roles — exactly
  /// the case this method exists to handle — a 2FA-enrolled user came out of it
  /// reading as 2FA-off, and Settings showed two-factor disabled for someone
  /// who had it on. The KYC fields would have been the next two to go the same
  /// way, which is what prompted looking.
  ///
  /// With copyWith, a field not named here keeps its value by construction.
  UserModel withRolesFromAccessToken(String accessToken) {
    final claims = decodeJwtPayload(accessToken);
    final jwtRoles = rolesFromJwtClaims(claims);
    final jwtRole = primaryRoleFromJwtClaims(claims);
    final needRoles = roles == null || roles!.isEmpty;
    final needRole = role == null || role!.isEmpty;
    if (!needRoles && !needRole) return this;
    return copyWith(
      role: needRole && jwtRole != null ? jwtRole : role,
      roles: needRoles && jwtRoles != null ? jwtRoles : roles,
      // profilePicture is a sentinel slot in copyWith: omitting it KEEPS the
      // current value, which is what is wanted. Passing it explicitly would
      // clear a null-valued picture, and passing `null` means "remove it".
    );
  }

  @override
  UserModel copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? middleName,
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
    // Signature matches User.copyWith — pass [Object()] to keep the
    // existing value, pass `null` explicitly to clear it.
    Object? profilePicture = _modelSentinel,
    String? signupStatus,
    String? currentSignupStep,
    bool? hasPasscode,
    bool? hasTransactionPin,
    bool? mustChangeCredentials,
    bool? hasPassword,
    String? preferredLoginMethod,
    String? authType,
    bool? twoFactorEnabled,
    String? twoFactorMethod,
    int? kycTier,
    bool? identityVerified,
    String? kycStatus,
    String? dateOfBirth,
    PostalAddress? address,
  }) {
    return UserModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      middleName: middleName ?? this.middleName,
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
      profilePicture: identical(profilePicture, _modelSentinel)
          ? this.profilePicture
          : profilePicture as String?,
      signupStatus: signupStatus ?? this.signupStatus,
      currentSignupStep: currentSignupStep ?? this.currentSignupStep,
      hasPasscode: hasPasscode ?? this.hasPasscode,
      hasTransactionPin: hasTransactionPin ?? this.hasTransactionPin,
      mustChangeCredentials:
          mustChangeCredentials ?? this.mustChangeCredentials,
      hasPassword: hasPassword ?? this.hasPassword,
      preferredLoginMethod: preferredLoginMethod ?? this.preferredLoginMethod,
      authType: authType ?? this.authType,
      twoFactorEnabled: twoFactorEnabled ?? this.twoFactorEnabled,
      twoFactorMethod: twoFactorMethod ?? this.twoFactorMethod,
      kycTier: kycTier ?? this.kycTier,
      identityVerified: identityVerified ?? this.identityVerified,
      kycStatus: kycStatus ?? this.kycStatus,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      address: address ?? this.address,
    );
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
        currentSignupStep: map['currentSignupStep'] as String?,
        hasPasscode: map['hasPasscode'] as bool? ?? false,
        hasTransactionPin: map['hasTransactionPin'] as bool? ?? false,
        mustChangeCredentials: map['mustChangeCredentials'] as bool? ?? false,
        hasPassword: map['hasPassword'] as bool? ?? false,
        preferredLoginMethod: map['preferredLoginMethod'] as String?,
        authType: map['authType'] as String?,
        dateOfBirth: map['dateOfBirth'] as String?,
      );

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
    "currentSignupStep": currentSignupStep,
    "hasPasscode": hasPasscode,
    "hasTransactionPin": hasTransactionPin,
    "mustChangeCredentials": mustChangeCredentials,
    "hasPassword": hasPassword,
    "preferredLoginMethod": preferredLoginMethod,
    "authType": authType,
    "dateOfBirth": dateOfBirth,
  };

  String toJson() => jsonEncode(toMap());
}

/// Private sentinel parallel to the one in [User] — distinguishes
/// "explicit null" (clear the field) from "no value passed" (keep
/// existing) on the nullable `profilePicture` slot.
const Object _modelSentinel = Object();
