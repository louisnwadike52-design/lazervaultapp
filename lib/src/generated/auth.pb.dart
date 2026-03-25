// This is a generated file - do not edit.
//
// Generated from auth.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'auth.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'auth.pbenum.dart';

class SignupRequest extends $pb.GeneratedMessage {
  factory SignupRequest({
    $core.String? email,
    $core.String? password,
    $core.String? firstName,
    $core.String? lastName,
    $core.String? phone,
    $core.String? deviceId,
    $core.String? deviceName,
    PrimaryContactType? primaryContactType,
    $core.String? username,
    $core.String? referralCode,
    $core.String? dateOfBirth,
    $core.String? locale,
    $core.String? bvn,
    $core.String? nin,
    @$core.Deprecated('This field is deprecated.') $core.String? countryCode,
    @$core.Deprecated('This field is deprecated.') $core.String? currencyCode,
  }) {
    final result = create();
    if (email != null) result.email = email;
    if (password != null) result.password = password;
    if (firstName != null) result.firstName = firstName;
    if (lastName != null) result.lastName = lastName;
    if (phone != null) result.phone = phone;
    if (deviceId != null) result.deviceId = deviceId;
    if (deviceName != null) result.deviceName = deviceName;
    if (primaryContactType != null)
      result.primaryContactType = primaryContactType;
    if (username != null) result.username = username;
    if (referralCode != null) result.referralCode = referralCode;
    if (dateOfBirth != null) result.dateOfBirth = dateOfBirth;
    if (locale != null) result.locale = locale;
    if (bvn != null) result.bvn = bvn;
    if (nin != null) result.nin = nin;
    if (countryCode != null) result.countryCode = countryCode;
    if (currencyCode != null) result.currencyCode = currencyCode;
    return result;
  }

  SignupRequest._();

  factory SignupRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SignupRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SignupRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'email')
    ..aOS(2, _omitFieldNames ? '' : 'password')
    ..aOS(3, _omitFieldNames ? '' : 'firstName')
    ..aOS(4, _omitFieldNames ? '' : 'lastName')
    ..aOS(5, _omitFieldNames ? '' : 'phone')
    ..aOS(6, _omitFieldNames ? '' : 'deviceId')
    ..aOS(7, _omitFieldNames ? '' : 'deviceName')
    ..e<PrimaryContactType>(
        8, _omitFieldNames ? '' : 'primaryContactType', $pb.PbFieldType.OE,
        defaultOrMaker: PrimaryContactType.EMAIL,
        valueOf: PrimaryContactType.valueOf,
        enumValues: PrimaryContactType.values)
    ..aOS(9, _omitFieldNames ? '' : 'username')
    ..aOS(10, _omitFieldNames ? '' : 'referralCode')
    ..aOS(11, _omitFieldNames ? '' : 'dateOfBirth')
    ..aOS(12, _omitFieldNames ? '' : 'locale')
    ..aOS(13, _omitFieldNames ? '' : 'bvn')
    ..aOS(14, _omitFieldNames ? '' : 'nin')
    ..aOS(15, _omitFieldNames ? '' : 'countryCode')
    ..aOS(16, _omitFieldNames ? '' : 'currencyCode')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SignupRequest clone() => SignupRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SignupRequest copyWith(void Function(SignupRequest) updates) =>
      super.copyWith((message) => updates(message as SignupRequest))
          as SignupRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SignupRequest create() => SignupRequest._();
  @$core.override
  SignupRequest createEmptyInstance() => create();
  static $pb.PbList<SignupRequest> createRepeated() =>
      $pb.PbList<SignupRequest>();
  @$core.pragma('dart2js:noInline')
  static SignupRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SignupRequest>(create);
  static SignupRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get email => $_getSZ(0);
  @$pb.TagNumber(1)
  set email($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEmail() => $_has(0);
  @$pb.TagNumber(1)
  void clearEmail() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get password => $_getSZ(1);
  @$pb.TagNumber(2)
  set password($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPassword() => $_has(1);
  @$pb.TagNumber(2)
  void clearPassword() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get firstName => $_getSZ(2);
  @$pb.TagNumber(3)
  set firstName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasFirstName() => $_has(2);
  @$pb.TagNumber(3)
  void clearFirstName() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get lastName => $_getSZ(3);
  @$pb.TagNumber(4)
  set lastName($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasLastName() => $_has(3);
  @$pb.TagNumber(4)
  void clearLastName() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get phone => $_getSZ(4);
  @$pb.TagNumber(5)
  set phone($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasPhone() => $_has(4);
  @$pb.TagNumber(5)
  void clearPhone() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get deviceId => $_getSZ(5);
  @$pb.TagNumber(6)
  set deviceId($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasDeviceId() => $_has(5);
  @$pb.TagNumber(6)
  void clearDeviceId() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get deviceName => $_getSZ(6);
  @$pb.TagNumber(7)
  set deviceName($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasDeviceName() => $_has(6);
  @$pb.TagNumber(7)
  void clearDeviceName() => $_clearField(7);

  @$pb.TagNumber(8)
  PrimaryContactType get primaryContactType => $_getN(7);
  @$pb.TagNumber(8)
  set primaryContactType(PrimaryContactType value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasPrimaryContactType() => $_has(7);
  @$pb.TagNumber(8)
  void clearPrimaryContactType() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get username => $_getSZ(8);
  @$pb.TagNumber(9)
  set username($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasUsername() => $_has(8);
  @$pb.TagNumber(9)
  void clearUsername() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get referralCode => $_getSZ(9);
  @$pb.TagNumber(10)
  set referralCode($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasReferralCode() => $_has(9);
  @$pb.TagNumber(10)
  void clearReferralCode() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get dateOfBirth => $_getSZ(10);
  @$pb.TagNumber(11)
  set dateOfBirth($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasDateOfBirth() => $_has(10);
  @$pb.TagNumber(11)
  void clearDateOfBirth() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get locale => $_getSZ(11);
  @$pb.TagNumber(12)
  set locale($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasLocale() => $_has(11);
  @$pb.TagNumber(12)
  void clearLocale() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get bvn => $_getSZ(12);
  @$pb.TagNumber(13)
  set bvn($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasBvn() => $_has(12);
  @$pb.TagNumber(13)
  void clearBvn() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.String get nin => $_getSZ(13);
  @$pb.TagNumber(14)
  set nin($core.String value) => $_setString(13, value);
  @$pb.TagNumber(14)
  $core.bool hasNin() => $_has(13);
  @$pb.TagNumber(14)
  void clearNin() => $_clearField(14);

  /// Deprecated: Use locale instead. Frontend should only send locale.
  /// Kept for backward compatibility during migration.
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(15)
  $core.String get countryCode => $_getSZ(14);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(15)
  set countryCode($core.String value) => $_setString(14, value);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(15)
  $core.bool hasCountryCode() => $_has(14);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(15)
  void clearCountryCode() => $_clearField(15);

  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(16)
  $core.String get currencyCode => $_getSZ(15);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(16)
  set currencyCode($core.String value) => $_setString(15, value);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(16)
  $core.bool hasCurrencyCode() => $_has(15);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(16)
  void clearCurrencyCode() => $_clearField(16);
}

class SignupResponse extends $pb.GeneratedMessage {
  factory SignupResponse({
    $core.String? userId,
    $core.String? email,
    $core.String? message,
    $core.bool? emailVerificationRequired,
    $core.String? accessToken,
    $core.String? refreshToken,
    $fixnum.Int64? expiresIn,
    User? user,
    $core.bool? phoneVerificationRequired,
    $core.String? verificationSentTo,
    $core.String? phoneVerificationId,
    $fixnum.Int64? phoneVerificationExpiresIn,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (email != null) result.email = email;
    if (message != null) result.message = message;
    if (emailVerificationRequired != null)
      result.emailVerificationRequired = emailVerificationRequired;
    if (accessToken != null) result.accessToken = accessToken;
    if (refreshToken != null) result.refreshToken = refreshToken;
    if (expiresIn != null) result.expiresIn = expiresIn;
    if (user != null) result.user = user;
    if (phoneVerificationRequired != null)
      result.phoneVerificationRequired = phoneVerificationRequired;
    if (verificationSentTo != null)
      result.verificationSentTo = verificationSentTo;
    if (phoneVerificationId != null)
      result.phoneVerificationId = phoneVerificationId;
    if (phoneVerificationExpiresIn != null)
      result.phoneVerificationExpiresIn = phoneVerificationExpiresIn;
    return result;
  }

  SignupResponse._();

  factory SignupResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SignupResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SignupResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'email')
    ..aOS(3, _omitFieldNames ? '' : 'message')
    ..aOB(4, _omitFieldNames ? '' : 'emailVerificationRequired')
    ..aOS(5, _omitFieldNames ? '' : 'accessToken')
    ..aOS(6, _omitFieldNames ? '' : 'refreshToken')
    ..aInt64(7, _omitFieldNames ? '' : 'expiresIn')
    ..aOM<User>(8, _omitFieldNames ? '' : 'user', subBuilder: User.create)
    ..aOB(9, _omitFieldNames ? '' : 'phoneVerificationRequired')
    ..aOS(10, _omitFieldNames ? '' : 'verificationSentTo')
    ..aOS(11, _omitFieldNames ? '' : 'phoneVerificationId')
    ..aInt64(12, _omitFieldNames ? '' : 'phoneVerificationExpiresIn')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SignupResponse clone() => SignupResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SignupResponse copyWith(void Function(SignupResponse) updates) =>
      super.copyWith((message) => updates(message as SignupResponse))
          as SignupResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SignupResponse create() => SignupResponse._();
  @$core.override
  SignupResponse createEmptyInstance() => create();
  static $pb.PbList<SignupResponse> createRepeated() =>
      $pb.PbList<SignupResponse>();
  @$core.pragma('dart2js:noInline')
  static SignupResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SignupResponse>(create);
  static SignupResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get email => $_getSZ(1);
  @$pb.TagNumber(2)
  set email($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasEmail() => $_has(1);
  @$pb.TagNumber(2)
  void clearEmail() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.bool get emailVerificationRequired => $_getBF(3);
  @$pb.TagNumber(4)
  set emailVerificationRequired($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasEmailVerificationRequired() => $_has(3);
  @$pb.TagNumber(4)
  void clearEmailVerificationRequired() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get accessToken => $_getSZ(4);
  @$pb.TagNumber(5)
  set accessToken($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasAccessToken() => $_has(4);
  @$pb.TagNumber(5)
  void clearAccessToken() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get refreshToken => $_getSZ(5);
  @$pb.TagNumber(6)
  set refreshToken($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasRefreshToken() => $_has(5);
  @$pb.TagNumber(6)
  void clearRefreshToken() => $_clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get expiresIn => $_getI64(6);
  @$pb.TagNumber(7)
  set expiresIn($fixnum.Int64 value) => $_setInt64(6, value);
  @$pb.TagNumber(7)
  $core.bool hasExpiresIn() => $_has(6);
  @$pb.TagNumber(7)
  void clearExpiresIn() => $_clearField(7);

  @$pb.TagNumber(8)
  User get user => $_getN(7);
  @$pb.TagNumber(8)
  set user(User value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasUser() => $_has(7);
  @$pb.TagNumber(8)
  void clearUser() => $_clearField(8);
  @$pb.TagNumber(8)
  User ensureUser() => $_ensure(7);

  @$pb.TagNumber(9)
  $core.bool get phoneVerificationRequired => $_getBF(8);
  @$pb.TagNumber(9)
  set phoneVerificationRequired($core.bool value) => $_setBool(8, value);
  @$pb.TagNumber(9)
  $core.bool hasPhoneVerificationRequired() => $_has(8);
  @$pb.TagNumber(9)
  void clearPhoneVerificationRequired() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get verificationSentTo => $_getSZ(9);
  @$pb.TagNumber(10)
  set verificationSentTo($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasVerificationSentTo() => $_has(9);
  @$pb.TagNumber(10)
  void clearVerificationSentTo() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get phoneVerificationId => $_getSZ(10);
  @$pb.TagNumber(11)
  set phoneVerificationId($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasPhoneVerificationId() => $_has(10);
  @$pb.TagNumber(11)
  void clearPhoneVerificationId() => $_clearField(11);

  @$pb.TagNumber(12)
  $fixnum.Int64 get phoneVerificationExpiresIn => $_getI64(11);
  @$pb.TagNumber(12)
  set phoneVerificationExpiresIn($fixnum.Int64 value) => $_setInt64(11, value);
  @$pb.TagNumber(12)
  $core.bool hasPhoneVerificationExpiresIn() => $_has(11);
  @$pb.TagNumber(12)
  void clearPhoneVerificationExpiresIn() => $_clearField(12);
}

/// ===== Login =====
class LoginRequest extends $pb.GeneratedMessage {
  factory LoginRequest({
    $core.String? email,
    $core.String? password,
    $core.String? deviceId,
    $core.String? deviceName,
    $core.String? phone,
  }) {
    final result = create();
    if (email != null) result.email = email;
    if (password != null) result.password = password;
    if (deviceId != null) result.deviceId = deviceId;
    if (deviceName != null) result.deviceName = deviceName;
    if (phone != null) result.phone = phone;
    return result;
  }

  LoginRequest._();

  factory LoginRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory LoginRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LoginRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'email')
    ..aOS(2, _omitFieldNames ? '' : 'password')
    ..aOS(3, _omitFieldNames ? '' : 'deviceId')
    ..aOS(4, _omitFieldNames ? '' : 'deviceName')
    ..aOS(5, _omitFieldNames ? '' : 'phone')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LoginRequest clone() => LoginRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LoginRequest copyWith(void Function(LoginRequest) updates) =>
      super.copyWith((message) => updates(message as LoginRequest))
          as LoginRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LoginRequest create() => LoginRequest._();
  @$core.override
  LoginRequest createEmptyInstance() => create();
  static $pb.PbList<LoginRequest> createRepeated() =>
      $pb.PbList<LoginRequest>();
  @$core.pragma('dart2js:noInline')
  static LoginRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LoginRequest>(create);
  static LoginRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get email => $_getSZ(0);
  @$pb.TagNumber(1)
  set email($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEmail() => $_has(0);
  @$pb.TagNumber(1)
  void clearEmail() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get password => $_getSZ(1);
  @$pb.TagNumber(2)
  set password($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPassword() => $_has(1);
  @$pb.TagNumber(2)
  void clearPassword() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get deviceId => $_getSZ(2);
  @$pb.TagNumber(3)
  set deviceId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDeviceId() => $_has(2);
  @$pb.TagNumber(3)
  void clearDeviceId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get deviceName => $_getSZ(3);
  @$pb.TagNumber(4)
  set deviceName($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDeviceName() => $_has(3);
  @$pb.TagNumber(4)
  void clearDeviceName() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get phone => $_getSZ(4);
  @$pb.TagNumber(5)
  set phone($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasPhone() => $_has(4);
  @$pb.TagNumber(5)
  void clearPhone() => $_clearField(5);
}

class LoginResponse extends $pb.GeneratedMessage {
  factory LoginResponse({
    $core.bool? success,
    $core.String? msg,
    $core.String? accessToken,
    $core.String? refreshToken,
    $fixnum.Int64? expiresIn,
    LoginData? data,
    $core.bool? twoFactorRequired,
    $core.String? twoFactorToken,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (msg != null) result.msg = msg;
    if (accessToken != null) result.accessToken = accessToken;
    if (refreshToken != null) result.refreshToken = refreshToken;
    if (expiresIn != null) result.expiresIn = expiresIn;
    if (data != null) result.data = data;
    if (twoFactorRequired != null) result.twoFactorRequired = twoFactorRequired;
    if (twoFactorToken != null) result.twoFactorToken = twoFactorToken;
    return result;
  }

  LoginResponse._();

  factory LoginResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory LoginResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LoginResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'msg')
    ..aOS(3, _omitFieldNames ? '' : 'accessToken')
    ..aOS(4, _omitFieldNames ? '' : 'refreshToken')
    ..aInt64(5, _omitFieldNames ? '' : 'expiresIn')
    ..aOM<LoginData>(6, _omitFieldNames ? '' : 'data',
        subBuilder: LoginData.create)
    ..aOB(7, _omitFieldNames ? '' : 'twoFactorRequired')
    ..aOS(8, _omitFieldNames ? '' : 'twoFactorToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LoginResponse clone() => LoginResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LoginResponse copyWith(void Function(LoginResponse) updates) =>
      super.copyWith((message) => updates(message as LoginResponse))
          as LoginResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LoginResponse create() => LoginResponse._();
  @$core.override
  LoginResponse createEmptyInstance() => create();
  static $pb.PbList<LoginResponse> createRepeated() =>
      $pb.PbList<LoginResponse>();
  @$core.pragma('dart2js:noInline')
  static LoginResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LoginResponse>(create);
  static LoginResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get msg => $_getSZ(1);
  @$pb.TagNumber(2)
  set msg($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMsg() => $_has(1);
  @$pb.TagNumber(2)
  void clearMsg() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get accessToken => $_getSZ(2);
  @$pb.TagNumber(3)
  set accessToken($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAccessToken() => $_has(2);
  @$pb.TagNumber(3)
  void clearAccessToken() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get refreshToken => $_getSZ(3);
  @$pb.TagNumber(4)
  set refreshToken($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasRefreshToken() => $_has(3);
  @$pb.TagNumber(4)
  void clearRefreshToken() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get expiresIn => $_getI64(4);
  @$pb.TagNumber(5)
  set expiresIn($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasExpiresIn() => $_has(4);
  @$pb.TagNumber(5)
  void clearExpiresIn() => $_clearField(5);

  @$pb.TagNumber(6)
  LoginData get data => $_getN(5);
  @$pb.TagNumber(6)
  set data(LoginData value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasData() => $_has(5);
  @$pb.TagNumber(6)
  void clearData() => $_clearField(6);
  @$pb.TagNumber(6)
  LoginData ensureData() => $_ensure(5);

  @$pb.TagNumber(7)
  $core.bool get twoFactorRequired => $_getBF(6);
  @$pb.TagNumber(7)
  set twoFactorRequired($core.bool value) => $_setBool(6, value);
  @$pb.TagNumber(7)
  $core.bool hasTwoFactorRequired() => $_has(6);
  @$pb.TagNumber(7)
  void clearTwoFactorRequired() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get twoFactorToken => $_getSZ(7);
  @$pb.TagNumber(8)
  set twoFactorToken($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasTwoFactorToken() => $_has(7);
  @$pb.TagNumber(8)
  void clearTwoFactorToken() => $_clearField(8);
}

class LoginData extends $pb.GeneratedMessage {
  factory LoginData({
    User? user,
    Session? session,
    $core.bool? hasPasscode,
    $core.bool? hasTransactionPin,
  }) {
    final result = create();
    if (user != null) result.user = user;
    if (session != null) result.session = session;
    if (hasPasscode != null) result.hasPasscode = hasPasscode;
    if (hasTransactionPin != null) result.hasTransactionPin = hasTransactionPin;
    return result;
  }

  LoginData._();

  factory LoginData.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory LoginData.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LoginData',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOM<User>(1, _omitFieldNames ? '' : 'user', subBuilder: User.create)
    ..aOM<Session>(2, _omitFieldNames ? '' : 'session',
        subBuilder: Session.create)
    ..aOB(3, _omitFieldNames ? '' : 'hasPasscode')
    ..aOB(4, _omitFieldNames ? '' : 'hasTransactionPin')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LoginData clone() => LoginData()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LoginData copyWith(void Function(LoginData) updates) =>
      super.copyWith((message) => updates(message as LoginData)) as LoginData;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LoginData create() => LoginData._();
  @$core.override
  LoginData createEmptyInstance() => create();
  static $pb.PbList<LoginData> createRepeated() => $pb.PbList<LoginData>();
  @$core.pragma('dart2js:noInline')
  static LoginData getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LoginData>(create);
  static LoginData? _defaultInstance;

  @$pb.TagNumber(1)
  User get user => $_getN(0);
  @$pb.TagNumber(1)
  set user(User value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasUser() => $_has(0);
  @$pb.TagNumber(1)
  void clearUser() => $_clearField(1);
  @$pb.TagNumber(1)
  User ensureUser() => $_ensure(0);

  @$pb.TagNumber(2)
  Session get session => $_getN(1);
  @$pb.TagNumber(2)
  set session(Session value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasSession() => $_has(1);
  @$pb.TagNumber(2)
  void clearSession() => $_clearField(2);
  @$pb.TagNumber(2)
  Session ensureSession() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.bool get hasPasscode => $_getBF(2);
  @$pb.TagNumber(3)
  set hasPasscode($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasHasPasscode() => $_has(2);
  @$pb.TagNumber(3)
  void clearHasPasscode() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.bool get hasTransactionPin => $_getBF(3);
  @$pb.TagNumber(4)
  set hasTransactionPin($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasHasTransactionPin() => $_has(3);
  @$pb.TagNumber(4)
  void clearHasTransactionPin() => $_clearField(4);
}

class Session extends $pb.GeneratedMessage {
  factory Session({
    $core.String? accessToken,
    $core.String? refreshToken,
    $fixnum.Int64? expiresIn,
    $core.String? userId,
  }) {
    final result = create();
    if (accessToken != null) result.accessToken = accessToken;
    if (refreshToken != null) result.refreshToken = refreshToken;
    if (expiresIn != null) result.expiresIn = expiresIn;
    if (userId != null) result.userId = userId;
    return result;
  }

  Session._();

  factory Session.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Session.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Session',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accessToken')
    ..aOS(2, _omitFieldNames ? '' : 'refreshToken')
    ..aInt64(3, _omitFieldNames ? '' : 'expiresIn')
    ..aOS(4, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Session clone() => Session()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Session copyWith(void Function(Session) updates) =>
      super.copyWith((message) => updates(message as Session)) as Session;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Session create() => Session._();
  @$core.override
  Session createEmptyInstance() => create();
  static $pb.PbList<Session> createRepeated() => $pb.PbList<Session>();
  @$core.pragma('dart2js:noInline')
  static Session getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Session>(create);
  static Session? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accessToken => $_getSZ(0);
  @$pb.TagNumber(1)
  set accessToken($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAccessToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccessToken() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get refreshToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set refreshToken($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRefreshToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearRefreshToken() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get expiresIn => $_getI64(2);
  @$pb.TagNumber(3)
  set expiresIn($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasExpiresIn() => $_has(2);
  @$pb.TagNumber(3)
  void clearExpiresIn() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get userId => $_getSZ(3);
  @$pb.TagNumber(4)
  set userId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasUserId() => $_has(3);
  @$pb.TagNumber(4)
  void clearUserId() => $_clearField(4);
}

/// ===== Refresh Token =====
class RefreshTokenRequest extends $pb.GeneratedMessage {
  factory RefreshTokenRequest({
    $core.String? refreshToken,
  }) {
    final result = create();
    if (refreshToken != null) result.refreshToken = refreshToken;
    return result;
  }

  RefreshTokenRequest._();

  factory RefreshTokenRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RefreshTokenRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RefreshTokenRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refreshToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RefreshTokenRequest clone() => RefreshTokenRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RefreshTokenRequest copyWith(void Function(RefreshTokenRequest) updates) =>
      super.copyWith((message) => updates(message as RefreshTokenRequest))
          as RefreshTokenRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RefreshTokenRequest create() => RefreshTokenRequest._();
  @$core.override
  RefreshTokenRequest createEmptyInstance() => create();
  static $pb.PbList<RefreshTokenRequest> createRepeated() =>
      $pb.PbList<RefreshTokenRequest>();
  @$core.pragma('dart2js:noInline')
  static RefreshTokenRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RefreshTokenRequest>(create);
  static RefreshTokenRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refreshToken => $_getSZ(0);
  @$pb.TagNumber(1)
  set refreshToken($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefreshToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefreshToken() => $_clearField(1);
}

class RefreshTokenResponse extends $pb.GeneratedMessage {
  factory RefreshTokenResponse({
    $core.String? accessToken,
    $core.String? refreshToken,
    $fixnum.Int64? expiresIn,
    User? user,
  }) {
    final result = create();
    if (accessToken != null) result.accessToken = accessToken;
    if (refreshToken != null) result.refreshToken = refreshToken;
    if (expiresIn != null) result.expiresIn = expiresIn;
    if (user != null) result.user = user;
    return result;
  }

  RefreshTokenResponse._();

  factory RefreshTokenResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RefreshTokenResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RefreshTokenResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accessToken')
    ..aOS(2, _omitFieldNames ? '' : 'refreshToken')
    ..aInt64(3, _omitFieldNames ? '' : 'expiresIn')
    ..aOM<User>(4, _omitFieldNames ? '' : 'user', subBuilder: User.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RefreshTokenResponse clone() =>
      RefreshTokenResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RefreshTokenResponse copyWith(void Function(RefreshTokenResponse) updates) =>
      super.copyWith((message) => updates(message as RefreshTokenResponse))
          as RefreshTokenResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RefreshTokenResponse create() => RefreshTokenResponse._();
  @$core.override
  RefreshTokenResponse createEmptyInstance() => create();
  static $pb.PbList<RefreshTokenResponse> createRepeated() =>
      $pb.PbList<RefreshTokenResponse>();
  @$core.pragma('dart2js:noInline')
  static RefreshTokenResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RefreshTokenResponse>(create);
  static RefreshTokenResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accessToken => $_getSZ(0);
  @$pb.TagNumber(1)
  set accessToken($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAccessToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccessToken() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get refreshToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set refreshToken($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRefreshToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearRefreshToken() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get expiresIn => $_getI64(2);
  @$pb.TagNumber(3)
  set expiresIn($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasExpiresIn() => $_has(2);
  @$pb.TagNumber(3)
  void clearExpiresIn() => $_clearField(3);

  @$pb.TagNumber(4)
  User get user => $_getN(3);
  @$pb.TagNumber(4)
  set user(User value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasUser() => $_has(3);
  @$pb.TagNumber(4)
  void clearUser() => $_clearField(4);
  @$pb.TagNumber(4)
  User ensureUser() => $_ensure(3);
}

/// ===== Logout =====
class LogoutRequest extends $pb.GeneratedMessage {
  factory LogoutRequest({
    $core.String? userId,
    $core.String? refreshToken,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (refreshToken != null) result.refreshToken = refreshToken;
    return result;
  }

  LogoutRequest._();

  factory LogoutRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory LogoutRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LogoutRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'refreshToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LogoutRequest clone() => LogoutRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LogoutRequest copyWith(void Function(LogoutRequest) updates) =>
      super.copyWith((message) => updates(message as LogoutRequest))
          as LogoutRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LogoutRequest create() => LogoutRequest._();
  @$core.override
  LogoutRequest createEmptyInstance() => create();
  static $pb.PbList<LogoutRequest> createRepeated() =>
      $pb.PbList<LogoutRequest>();
  @$core.pragma('dart2js:noInline')
  static LogoutRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LogoutRequest>(create);
  static LogoutRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get refreshToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set refreshToken($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRefreshToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearRefreshToken() => $_clearField(2);
}

class LogoutResponse extends $pb.GeneratedMessage {
  factory LogoutResponse({
    $core.String? message,
  }) {
    final result = create();
    if (message != null) result.message = message;
    return result;
  }

  LogoutResponse._();

  factory LogoutResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory LogoutResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LogoutResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LogoutResponse clone() => LogoutResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LogoutResponse copyWith(void Function(LogoutResponse) updates) =>
      super.copyWith((message) => updates(message as LogoutResponse))
          as LogoutResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LogoutResponse create() => LogoutResponse._();
  @$core.override
  LogoutResponse createEmptyInstance() => create();
  static $pb.PbList<LogoutResponse> createRepeated() =>
      $pb.PbList<LogoutResponse>();
  @$core.pragma('dart2js:noInline')
  static LogoutResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LogoutResponse>(create);
  static LogoutResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get message => $_getSZ(0);
  @$pb.TagNumber(1)
  set message($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessage() => $_clearField(1);
}

/// ===== Email Verification =====
class VerifyEmailRequest extends $pb.GeneratedMessage {
  factory VerifyEmailRequest({
    $core.String? verificationCode,
  }) {
    final result = create();
    if (verificationCode != null) result.verificationCode = verificationCode;
    return result;
  }

  VerifyEmailRequest._();

  factory VerifyEmailRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VerifyEmailRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VerifyEmailRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'verificationCode',
        protoName: 'verificationCode')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyEmailRequest clone() => VerifyEmailRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyEmailRequest copyWith(void Function(VerifyEmailRequest) updates) =>
      super.copyWith((message) => updates(message as VerifyEmailRequest))
          as VerifyEmailRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VerifyEmailRequest create() => VerifyEmailRequest._();
  @$core.override
  VerifyEmailRequest createEmptyInstance() => create();
  static $pb.PbList<VerifyEmailRequest> createRepeated() =>
      $pb.PbList<VerifyEmailRequest>();
  @$core.pragma('dart2js:noInline')
  static VerifyEmailRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VerifyEmailRequest>(create);
  static VerifyEmailRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get verificationCode => $_getSZ(0);
  @$pb.TagNumber(1)
  set verificationCode($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasVerificationCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearVerificationCode() => $_clearField(1);
}

class VerifyEmailResponse extends $pb.GeneratedMessage {
  factory VerifyEmailResponse({
    $core.String? msg,
    $core.bool? success,
  }) {
    final result = create();
    if (msg != null) result.msg = msg;
    if (success != null) result.success = success;
    return result;
  }

  VerifyEmailResponse._();

  factory VerifyEmailResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VerifyEmailResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VerifyEmailResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'msg')
    ..aOB(2, _omitFieldNames ? '' : 'success')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyEmailResponse clone() => VerifyEmailResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyEmailResponse copyWith(void Function(VerifyEmailResponse) updates) =>
      super.copyWith((message) => updates(message as VerifyEmailResponse))
          as VerifyEmailResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VerifyEmailResponse create() => VerifyEmailResponse._();
  @$core.override
  VerifyEmailResponse createEmptyInstance() => create();
  static $pb.PbList<VerifyEmailResponse> createRepeated() =>
      $pb.PbList<VerifyEmailResponse>();
  @$core.pragma('dart2js:noInline')
  static VerifyEmailResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VerifyEmailResponse>(create);
  static VerifyEmailResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get msg => $_getSZ(0);
  @$pb.TagNumber(1)
  set msg($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMsg() => $_has(0);
  @$pb.TagNumber(1)
  void clearMsg() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => $_clearField(2);
}

class ResendVerificationEmailRequest extends $pb.GeneratedMessage {
  factory ResendVerificationEmailRequest({
    $core.String? email,
  }) {
    final result = create();
    if (email != null) result.email = email;
    return result;
  }

  ResendVerificationEmailRequest._();

  factory ResendVerificationEmailRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ResendVerificationEmailRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ResendVerificationEmailRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'email')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ResendVerificationEmailRequest clone() =>
      ResendVerificationEmailRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ResendVerificationEmailRequest copyWith(
          void Function(ResendVerificationEmailRequest) updates) =>
      super.copyWith(
              (message) => updates(message as ResendVerificationEmailRequest))
          as ResendVerificationEmailRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ResendVerificationEmailRequest create() =>
      ResendVerificationEmailRequest._();
  @$core.override
  ResendVerificationEmailRequest createEmptyInstance() => create();
  static $pb.PbList<ResendVerificationEmailRequest> createRepeated() =>
      $pb.PbList<ResendVerificationEmailRequest>();
  @$core.pragma('dart2js:noInline')
  static ResendVerificationEmailRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ResendVerificationEmailRequest>(create);
  static ResendVerificationEmailRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get email => $_getSZ(0);
  @$pb.TagNumber(1)
  set email($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEmail() => $_has(0);
  @$pb.TagNumber(1)
  void clearEmail() => $_clearField(1);
}

class ResendVerificationEmailResponse extends $pb.GeneratedMessage {
  factory ResendVerificationEmailResponse({
    $core.bool? success,
    $core.String? message,
    $core.int? cooldownSeconds,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (cooldownSeconds != null) result.cooldownSeconds = cooldownSeconds;
    return result;
  }

  ResendVerificationEmailResponse._();

  factory ResendVerificationEmailResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ResendVerificationEmailResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ResendVerificationEmailResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..a<$core.int>(
        3, _omitFieldNames ? '' : 'cooldownSeconds', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ResendVerificationEmailResponse clone() =>
      ResendVerificationEmailResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ResendVerificationEmailResponse copyWith(
          void Function(ResendVerificationEmailResponse) updates) =>
      super.copyWith(
              (message) => updates(message as ResendVerificationEmailResponse))
          as ResendVerificationEmailResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ResendVerificationEmailResponse create() =>
      ResendVerificationEmailResponse._();
  @$core.override
  ResendVerificationEmailResponse createEmptyInstance() => create();
  static $pb.PbList<ResendVerificationEmailResponse> createRepeated() =>
      $pb.PbList<ResendVerificationEmailResponse>();
  @$core.pragma('dart2js:noInline')
  static ResendVerificationEmailResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ResendVerificationEmailResponse>(
          create);
  static ResendVerificationEmailResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get cooldownSeconds => $_getIZ(2);
  @$pb.TagNumber(3)
  set cooldownSeconds($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCooldownSeconds() => $_has(2);
  @$pb.TagNumber(3)
  void clearCooldownSeconds() => $_clearField(3);
}

/// ===== Phone Verification =====
class VerifyPhoneRequest extends $pb.GeneratedMessage {
  factory VerifyPhoneRequest({
    $core.String? userId,
    $core.String? code,
    $core.String? phone,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (code != null) result.code = code;
    if (phone != null) result.phone = phone;
    return result;
  }

  VerifyPhoneRequest._();

  factory VerifyPhoneRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VerifyPhoneRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VerifyPhoneRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'code')
    ..aOS(3, _omitFieldNames ? '' : 'phone')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyPhoneRequest clone() => VerifyPhoneRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyPhoneRequest copyWith(void Function(VerifyPhoneRequest) updates) =>
      super.copyWith((message) => updates(message as VerifyPhoneRequest))
          as VerifyPhoneRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VerifyPhoneRequest create() => VerifyPhoneRequest._();
  @$core.override
  VerifyPhoneRequest createEmptyInstance() => create();
  static $pb.PbList<VerifyPhoneRequest> createRepeated() =>
      $pb.PbList<VerifyPhoneRequest>();
  @$core.pragma('dart2js:noInline')
  static VerifyPhoneRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VerifyPhoneRequest>(create);
  static VerifyPhoneRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get code => $_getSZ(1);
  @$pb.TagNumber(2)
  set code($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearCode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get phone => $_getSZ(2);
  @$pb.TagNumber(3)
  set phone($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPhone() => $_has(2);
  @$pb.TagNumber(3)
  void clearPhone() => $_clearField(3);
}

class VerifyPhoneResponse extends $pb.GeneratedMessage {
  factory VerifyPhoneResponse({
    $core.String? message,
    $core.bool? success,
  }) {
    final result = create();
    if (message != null) result.message = message;
    if (success != null) result.success = success;
    return result;
  }

  VerifyPhoneResponse._();

  factory VerifyPhoneResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VerifyPhoneResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VerifyPhoneResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'message')
    ..aOB(2, _omitFieldNames ? '' : 'success')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyPhoneResponse clone() => VerifyPhoneResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyPhoneResponse copyWith(void Function(VerifyPhoneResponse) updates) =>
      super.copyWith((message) => updates(message as VerifyPhoneResponse))
          as VerifyPhoneResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VerifyPhoneResponse create() => VerifyPhoneResponse._();
  @$core.override
  VerifyPhoneResponse createEmptyInstance() => create();
  static $pb.PbList<VerifyPhoneResponse> createRepeated() =>
      $pb.PbList<VerifyPhoneResponse>();
  @$core.pragma('dart2js:noInline')
  static VerifyPhoneResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VerifyPhoneResponse>(create);
  static VerifyPhoneResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get message => $_getSZ(0);
  @$pb.TagNumber(1)
  set message($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessage() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => $_clearField(2);
}

class ResendPhoneVerificationRequest extends $pb.GeneratedMessage {
  factory ResendPhoneVerificationRequest({
    $core.String? phone,
    $core.String? userId,
  }) {
    final result = create();
    if (phone != null) result.phone = phone;
    if (userId != null) result.userId = userId;
    return result;
  }

  ResendPhoneVerificationRequest._();

  factory ResendPhoneVerificationRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ResendPhoneVerificationRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ResendPhoneVerificationRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'phone')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ResendPhoneVerificationRequest clone() =>
      ResendPhoneVerificationRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ResendPhoneVerificationRequest copyWith(
          void Function(ResendPhoneVerificationRequest) updates) =>
      super.copyWith(
              (message) => updates(message as ResendPhoneVerificationRequest))
          as ResendPhoneVerificationRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ResendPhoneVerificationRequest create() =>
      ResendPhoneVerificationRequest._();
  @$core.override
  ResendPhoneVerificationRequest createEmptyInstance() => create();
  static $pb.PbList<ResendPhoneVerificationRequest> createRepeated() =>
      $pb.PbList<ResendPhoneVerificationRequest>();
  @$core.pragma('dart2js:noInline')
  static ResendPhoneVerificationRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ResendPhoneVerificationRequest>(create);
  static ResendPhoneVerificationRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get phone => $_getSZ(0);
  @$pb.TagNumber(1)
  set phone($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPhone() => $_has(0);
  @$pb.TagNumber(1)
  void clearPhone() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);
}

class ResendPhoneVerificationResponse extends $pb.GeneratedMessage {
  factory ResendPhoneVerificationResponse({
    $core.String? message,
    $core.bool? success,
  }) {
    final result = create();
    if (message != null) result.message = message;
    if (success != null) result.success = success;
    return result;
  }

  ResendPhoneVerificationResponse._();

  factory ResendPhoneVerificationResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ResendPhoneVerificationResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ResendPhoneVerificationResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'message')
    ..aOB(2, _omitFieldNames ? '' : 'success')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ResendPhoneVerificationResponse clone() =>
      ResendPhoneVerificationResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ResendPhoneVerificationResponse copyWith(
          void Function(ResendPhoneVerificationResponse) updates) =>
      super.copyWith(
              (message) => updates(message as ResendPhoneVerificationResponse))
          as ResendPhoneVerificationResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ResendPhoneVerificationResponse create() =>
      ResendPhoneVerificationResponse._();
  @$core.override
  ResendPhoneVerificationResponse createEmptyInstance() => create();
  static $pb.PbList<ResendPhoneVerificationResponse> createRepeated() =>
      $pb.PbList<ResendPhoneVerificationResponse>();
  @$core.pragma('dart2js:noInline')
  static ResendPhoneVerificationResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ResendPhoneVerificationResponse>(
          create);
  static ResendPhoneVerificationResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get message => $_getSZ(0);
  @$pb.TagNumber(1)
  set message($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessage() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => $_clearField(2);
}

class ForgotPasswordRequest extends $pb.GeneratedMessage {
  factory ForgotPasswordRequest({
    $core.String? email,
    $core.String? phone,
    PasswordResetDeliveryMethod? deliveryMethod,
  }) {
    final result = create();
    if (email != null) result.email = email;
    if (phone != null) result.phone = phone;
    if (deliveryMethod != null) result.deliveryMethod = deliveryMethod;
    return result;
  }

  ForgotPasswordRequest._();

  factory ForgotPasswordRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ForgotPasswordRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ForgotPasswordRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'email')
    ..aOS(2, _omitFieldNames ? '' : 'phone')
    ..e<PasswordResetDeliveryMethod>(
        3, _omitFieldNames ? '' : 'deliveryMethod', $pb.PbFieldType.OE,
        defaultOrMaker: PasswordResetDeliveryMethod.DELIVERY_METHOD_UNSPECIFIED,
        valueOf: PasswordResetDeliveryMethod.valueOf,
        enumValues: PasswordResetDeliveryMethod.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ForgotPasswordRequest clone() =>
      ForgotPasswordRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ForgotPasswordRequest copyWith(
          void Function(ForgotPasswordRequest) updates) =>
      super.copyWith((message) => updates(message as ForgotPasswordRequest))
          as ForgotPasswordRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ForgotPasswordRequest create() => ForgotPasswordRequest._();
  @$core.override
  ForgotPasswordRequest createEmptyInstance() => create();
  static $pb.PbList<ForgotPasswordRequest> createRepeated() =>
      $pb.PbList<ForgotPasswordRequest>();
  @$core.pragma('dart2js:noInline')
  static ForgotPasswordRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ForgotPasswordRequest>(create);
  static ForgotPasswordRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get email => $_getSZ(0);
  @$pb.TagNumber(1)
  set email($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEmail() => $_has(0);
  @$pb.TagNumber(1)
  void clearEmail() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get phone => $_getSZ(1);
  @$pb.TagNumber(2)
  set phone($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPhone() => $_has(1);
  @$pb.TagNumber(2)
  void clearPhone() => $_clearField(2);

  @$pb.TagNumber(3)
  PasswordResetDeliveryMethod get deliveryMethod => $_getN(2);
  @$pb.TagNumber(3)
  set deliveryMethod(PasswordResetDeliveryMethod value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasDeliveryMethod() => $_has(2);
  @$pb.TagNumber(3)
  void clearDeliveryMethod() => $_clearField(3);
}

class ForgotPasswordResponse extends $pb.GeneratedMessage {
  factory ForgotPasswordResponse({
    $core.String? message,
    $core.bool? success,
    $core.String? deliveryMethod,
    $core.String? maskedContact,
    $fixnum.Int64? expiresInSeconds,
    $core.bool? userFound,
  }) {
    final result = create();
    if (message != null) result.message = message;
    if (success != null) result.success = success;
    if (deliveryMethod != null) result.deliveryMethod = deliveryMethod;
    if (maskedContact != null) result.maskedContact = maskedContact;
    if (expiresInSeconds != null) result.expiresInSeconds = expiresInSeconds;
    if (userFound != null) result.userFound = userFound;
    return result;
  }

  ForgotPasswordResponse._();

  factory ForgotPasswordResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ForgotPasswordResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ForgotPasswordResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'message')
    ..aOB(2, _omitFieldNames ? '' : 'success')
    ..aOS(3, _omitFieldNames ? '' : 'deliveryMethod')
    ..aOS(4, _omitFieldNames ? '' : 'maskedContact')
    ..aInt64(5, _omitFieldNames ? '' : 'expiresInSeconds')
    ..aOB(6, _omitFieldNames ? '' : 'userFound')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ForgotPasswordResponse clone() =>
      ForgotPasswordResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ForgotPasswordResponse copyWith(
          void Function(ForgotPasswordResponse) updates) =>
      super.copyWith((message) => updates(message as ForgotPasswordResponse))
          as ForgotPasswordResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ForgotPasswordResponse create() => ForgotPasswordResponse._();
  @$core.override
  ForgotPasswordResponse createEmptyInstance() => create();
  static $pb.PbList<ForgotPasswordResponse> createRepeated() =>
      $pb.PbList<ForgotPasswordResponse>();
  @$core.pragma('dart2js:noInline')
  static ForgotPasswordResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ForgotPasswordResponse>(create);
  static ForgotPasswordResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get message => $_getSZ(0);
  @$pb.TagNumber(1)
  set message($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessage() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get deliveryMethod => $_getSZ(2);
  @$pb.TagNumber(3)
  set deliveryMethod($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDeliveryMethod() => $_has(2);
  @$pb.TagNumber(3)
  void clearDeliveryMethod() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get maskedContact => $_getSZ(3);
  @$pb.TagNumber(4)
  set maskedContact($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMaskedContact() => $_has(3);
  @$pb.TagNumber(4)
  void clearMaskedContact() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get expiresInSeconds => $_getI64(4);
  @$pb.TagNumber(5)
  set expiresInSeconds($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasExpiresInSeconds() => $_has(4);
  @$pb.TagNumber(5)
  void clearExpiresInSeconds() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.bool get userFound => $_getBF(5);
  @$pb.TagNumber(6)
  set userFound($core.bool value) => $_setBool(5, value);
  @$pb.TagNumber(6)
  $core.bool hasUserFound() => $_has(5);
  @$pb.TagNumber(6)
  void clearUserFound() => $_clearField(6);
}

class VerifyPasswordResetCodeRequest extends $pb.GeneratedMessage {
  factory VerifyPasswordResetCodeRequest({
    $core.String? contact,
    $core.String? code,
    PasswordResetDeliveryMethod? deliveryMethod,
  }) {
    final result = create();
    if (contact != null) result.contact = contact;
    if (code != null) result.code = code;
    if (deliveryMethod != null) result.deliveryMethod = deliveryMethod;
    return result;
  }

  VerifyPasswordResetCodeRequest._();

  factory VerifyPasswordResetCodeRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VerifyPasswordResetCodeRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VerifyPasswordResetCodeRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'contact')
    ..aOS(2, _omitFieldNames ? '' : 'code')
    ..e<PasswordResetDeliveryMethod>(
        3, _omitFieldNames ? '' : 'deliveryMethod', $pb.PbFieldType.OE,
        defaultOrMaker: PasswordResetDeliveryMethod.DELIVERY_METHOD_UNSPECIFIED,
        valueOf: PasswordResetDeliveryMethod.valueOf,
        enumValues: PasswordResetDeliveryMethod.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyPasswordResetCodeRequest clone() =>
      VerifyPasswordResetCodeRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyPasswordResetCodeRequest copyWith(
          void Function(VerifyPasswordResetCodeRequest) updates) =>
      super.copyWith(
              (message) => updates(message as VerifyPasswordResetCodeRequest))
          as VerifyPasswordResetCodeRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VerifyPasswordResetCodeRequest create() =>
      VerifyPasswordResetCodeRequest._();
  @$core.override
  VerifyPasswordResetCodeRequest createEmptyInstance() => create();
  static $pb.PbList<VerifyPasswordResetCodeRequest> createRepeated() =>
      $pb.PbList<VerifyPasswordResetCodeRequest>();
  @$core.pragma('dart2js:noInline')
  static VerifyPasswordResetCodeRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VerifyPasswordResetCodeRequest>(create);
  static VerifyPasswordResetCodeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get contact => $_getSZ(0);
  @$pb.TagNumber(1)
  set contact($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasContact() => $_has(0);
  @$pb.TagNumber(1)
  void clearContact() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get code => $_getSZ(1);
  @$pb.TagNumber(2)
  set code($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearCode() => $_clearField(2);

  @$pb.TagNumber(3)
  PasswordResetDeliveryMethod get deliveryMethod => $_getN(2);
  @$pb.TagNumber(3)
  set deliveryMethod(PasswordResetDeliveryMethod value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasDeliveryMethod() => $_has(2);
  @$pb.TagNumber(3)
  void clearDeliveryMethod() => $_clearField(3);
}

class VerifyPasswordResetCodeResponse extends $pb.GeneratedMessage {
  factory VerifyPasswordResetCodeResponse({
    $core.bool? success,
    $core.String? message,
    $core.String? resetToken,
    $fixnum.Int64? expiresInSeconds,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (resetToken != null) result.resetToken = resetToken;
    if (expiresInSeconds != null) result.expiresInSeconds = expiresInSeconds;
    return result;
  }

  VerifyPasswordResetCodeResponse._();

  factory VerifyPasswordResetCodeResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VerifyPasswordResetCodeResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VerifyPasswordResetCodeResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOS(3, _omitFieldNames ? '' : 'resetToken')
    ..aInt64(4, _omitFieldNames ? '' : 'expiresInSeconds')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyPasswordResetCodeResponse clone() =>
      VerifyPasswordResetCodeResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyPasswordResetCodeResponse copyWith(
          void Function(VerifyPasswordResetCodeResponse) updates) =>
      super.copyWith(
              (message) => updates(message as VerifyPasswordResetCodeResponse))
          as VerifyPasswordResetCodeResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VerifyPasswordResetCodeResponse create() =>
      VerifyPasswordResetCodeResponse._();
  @$core.override
  VerifyPasswordResetCodeResponse createEmptyInstance() => create();
  static $pb.PbList<VerifyPasswordResetCodeResponse> createRepeated() =>
      $pb.PbList<VerifyPasswordResetCodeResponse>();
  @$core.pragma('dart2js:noInline')
  static VerifyPasswordResetCodeResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VerifyPasswordResetCodeResponse>(
          create);
  static VerifyPasswordResetCodeResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get resetToken => $_getSZ(2);
  @$pb.TagNumber(3)
  set resetToken($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasResetToken() => $_has(2);
  @$pb.TagNumber(3)
  void clearResetToken() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get expiresInSeconds => $_getI64(3);
  @$pb.TagNumber(4)
  set expiresInSeconds($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasExpiresInSeconds() => $_has(3);
  @$pb.TagNumber(4)
  void clearExpiresInSeconds() => $_clearField(4);
}

class ResetPasswordRequest extends $pb.GeneratedMessage {
  factory ResetPasswordRequest({
    $core.String? resetToken,
    $core.String? newPassword,
  }) {
    final result = create();
    if (resetToken != null) result.resetToken = resetToken;
    if (newPassword != null) result.newPassword = newPassword;
    return result;
  }

  ResetPasswordRequest._();

  factory ResetPasswordRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ResetPasswordRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ResetPasswordRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'resetToken')
    ..aOS(2, _omitFieldNames ? '' : 'newPassword')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ResetPasswordRequest clone() =>
      ResetPasswordRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ResetPasswordRequest copyWith(void Function(ResetPasswordRequest) updates) =>
      super.copyWith((message) => updates(message as ResetPasswordRequest))
          as ResetPasswordRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ResetPasswordRequest create() => ResetPasswordRequest._();
  @$core.override
  ResetPasswordRequest createEmptyInstance() => create();
  static $pb.PbList<ResetPasswordRequest> createRepeated() =>
      $pb.PbList<ResetPasswordRequest>();
  @$core.pragma('dart2js:noInline')
  static ResetPasswordRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ResetPasswordRequest>(create);
  static ResetPasswordRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get resetToken => $_getSZ(0);
  @$pb.TagNumber(1)
  set resetToken($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasResetToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearResetToken() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get newPassword => $_getSZ(1);
  @$pb.TagNumber(2)
  set newPassword($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNewPassword() => $_has(1);
  @$pb.TagNumber(2)
  void clearNewPassword() => $_clearField(2);
}

class ResetPasswordResponse extends $pb.GeneratedMessage {
  factory ResetPasswordResponse({
    $core.String? msg,
    $core.bool? success,
  }) {
    final result = create();
    if (msg != null) result.msg = msg;
    if (success != null) result.success = success;
    return result;
  }

  ResetPasswordResponse._();

  factory ResetPasswordResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ResetPasswordResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ResetPasswordResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'msg')
    ..aOB(2, _omitFieldNames ? '' : 'success')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ResetPasswordResponse clone() =>
      ResetPasswordResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ResetPasswordResponse copyWith(
          void Function(ResetPasswordResponse) updates) =>
      super.copyWith((message) => updates(message as ResetPasswordResponse))
          as ResetPasswordResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ResetPasswordResponse create() => ResetPasswordResponse._();
  @$core.override
  ResetPasswordResponse createEmptyInstance() => create();
  static $pb.PbList<ResetPasswordResponse> createRepeated() =>
      $pb.PbList<ResetPasswordResponse>();
  @$core.pragma('dart2js:noInline')
  static ResetPasswordResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ResetPasswordResponse>(create);
  static ResetPasswordResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get msg => $_getSZ(0);
  @$pb.TagNumber(1)
  set msg($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMsg() => $_has(0);
  @$pb.TagNumber(1)
  void clearMsg() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => $_clearField(2);
}

class ChangePasswordRequest extends $pb.GeneratedMessage {
  factory ChangePasswordRequest({
    $core.String? userId,
    $core.String? currentPassword,
    $core.String? newPassword,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (currentPassword != null) result.currentPassword = currentPassword;
    if (newPassword != null) result.newPassword = newPassword;
    return result;
  }

  ChangePasswordRequest._();

  factory ChangePasswordRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ChangePasswordRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChangePasswordRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'currentPassword')
    ..aOS(3, _omitFieldNames ? '' : 'newPassword')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChangePasswordRequest clone() =>
      ChangePasswordRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChangePasswordRequest copyWith(
          void Function(ChangePasswordRequest) updates) =>
      super.copyWith((message) => updates(message as ChangePasswordRequest))
          as ChangePasswordRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChangePasswordRequest create() => ChangePasswordRequest._();
  @$core.override
  ChangePasswordRequest createEmptyInstance() => create();
  static $pb.PbList<ChangePasswordRequest> createRepeated() =>
      $pb.PbList<ChangePasswordRequest>();
  @$core.pragma('dart2js:noInline')
  static ChangePasswordRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ChangePasswordRequest>(create);
  static ChangePasswordRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get currentPassword => $_getSZ(1);
  @$pb.TagNumber(2)
  set currentPassword($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCurrentPassword() => $_has(1);
  @$pb.TagNumber(2)
  void clearCurrentPassword() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get newPassword => $_getSZ(2);
  @$pb.TagNumber(3)
  set newPassword($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasNewPassword() => $_has(2);
  @$pb.TagNumber(3)
  void clearNewPassword() => $_clearField(3);
}

class ChangePasswordResponse extends $pb.GeneratedMessage {
  factory ChangePasswordResponse({
    $core.String? message,
  }) {
    final result = create();
    if (message != null) result.message = message;
    return result;
  }

  ChangePasswordResponse._();

  factory ChangePasswordResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ChangePasswordResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChangePasswordResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChangePasswordResponse clone() =>
      ChangePasswordResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChangePasswordResponse copyWith(
          void Function(ChangePasswordResponse) updates) =>
      super.copyWith((message) => updates(message as ChangePasswordResponse))
          as ChangePasswordResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChangePasswordResponse create() => ChangePasswordResponse._();
  @$core.override
  ChangePasswordResponse createEmptyInstance() => create();
  static $pb.PbList<ChangePasswordResponse> createRepeated() =>
      $pb.PbList<ChangePasswordResponse>();
  @$core.pragma('dart2js:noInline')
  static ChangePasswordResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ChangePasswordResponse>(create);
  static ChangePasswordResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get message => $_getSZ(0);
  @$pb.TagNumber(1)
  set message($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessage() => $_clearField(1);
}

/// ===== Get User Info =====
class GetMeRequest extends $pb.GeneratedMessage {
  factory GetMeRequest({
    $core.String? userId,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    return result;
  }

  GetMeRequest._();

  factory GetMeRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMeRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMeRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMeRequest clone() => GetMeRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMeRequest copyWith(void Function(GetMeRequest) updates) =>
      super.copyWith((message) => updates(message as GetMeRequest))
          as GetMeRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMeRequest create() => GetMeRequest._();
  @$core.override
  GetMeRequest createEmptyInstance() => create();
  static $pb.PbList<GetMeRequest> createRepeated() =>
      $pb.PbList<GetMeRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMeRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMeRequest>(create);
  static GetMeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);
}

class GetMeResponse extends $pb.GeneratedMessage {
  factory GetMeResponse({
    User? user,
  }) {
    final result = create();
    if (user != null) result.user = user;
    return result;
  }

  GetMeResponse._();

  factory GetMeResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMeResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMeResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOM<User>(1, _omitFieldNames ? '' : 'user', subBuilder: User.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMeResponse clone() => GetMeResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMeResponse copyWith(void Function(GetMeResponse) updates) =>
      super.copyWith((message) => updates(message as GetMeResponse))
          as GetMeResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMeResponse create() => GetMeResponse._();
  @$core.override
  GetMeResponse createEmptyInstance() => create();
  static $pb.PbList<GetMeResponse> createRepeated() =>
      $pb.PbList<GetMeResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMeResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMeResponse>(create);
  static GetMeResponse? _defaultInstance;

  @$pb.TagNumber(1)
  User get user => $_getN(0);
  @$pb.TagNumber(1)
  set user(User value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasUser() => $_has(0);
  @$pb.TagNumber(1)
  void clearUser() => $_clearField(1);
  @$pb.TagNumber(1)
  User ensureUser() => $_ensure(0);
}

/// ===== Update Profile =====
class UpdateProfileRequest extends $pb.GeneratedMessage {
  factory UpdateProfileRequest({
    $core.String? userId,
    $core.String? firstName,
    $core.String? lastName,
    $core.String? username,
    $core.String? phone,
    $core.String? profilePicture,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (firstName != null) result.firstName = firstName;
    if (lastName != null) result.lastName = lastName;
    if (username != null) result.username = username;
    if (phone != null) result.phone = phone;
    if (profilePicture != null) result.profilePicture = profilePicture;
    return result;
  }

  UpdateProfileRequest._();

  factory UpdateProfileRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateProfileRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateProfileRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'firstName')
    ..aOS(3, _omitFieldNames ? '' : 'lastName')
    ..aOS(4, _omitFieldNames ? '' : 'username')
    ..aOS(5, _omitFieldNames ? '' : 'phone')
    ..aOS(6, _omitFieldNames ? '' : 'profilePicture')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateProfileRequest clone() =>
      UpdateProfileRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateProfileRequest copyWith(void Function(UpdateProfileRequest) updates) =>
      super.copyWith((message) => updates(message as UpdateProfileRequest))
          as UpdateProfileRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateProfileRequest create() => UpdateProfileRequest._();
  @$core.override
  UpdateProfileRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateProfileRequest> createRepeated() =>
      $pb.PbList<UpdateProfileRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateProfileRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateProfileRequest>(create);
  static UpdateProfileRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get firstName => $_getSZ(1);
  @$pb.TagNumber(2)
  set firstName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasFirstName() => $_has(1);
  @$pb.TagNumber(2)
  void clearFirstName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get lastName => $_getSZ(2);
  @$pb.TagNumber(3)
  set lastName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLastName() => $_has(2);
  @$pb.TagNumber(3)
  void clearLastName() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get username => $_getSZ(3);
  @$pb.TagNumber(4)
  set username($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasUsername() => $_has(3);
  @$pb.TagNumber(4)
  void clearUsername() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get phone => $_getSZ(4);
  @$pb.TagNumber(5)
  set phone($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasPhone() => $_has(4);
  @$pb.TagNumber(5)
  void clearPhone() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get profilePicture => $_getSZ(5);
  @$pb.TagNumber(6)
  set profilePicture($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasProfilePicture() => $_has(5);
  @$pb.TagNumber(6)
  void clearProfilePicture() => $_clearField(6);
}

class UpdateProfileResponse extends $pb.GeneratedMessage {
  factory UpdateProfileResponse({
    $core.bool? success,
    $core.String? msg,
    User? user,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (msg != null) result.msg = msg;
    if (user != null) result.user = user;
    return result;
  }

  UpdateProfileResponse._();

  factory UpdateProfileResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateProfileResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateProfileResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'msg')
    ..aOM<User>(3, _omitFieldNames ? '' : 'user', subBuilder: User.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateProfileResponse clone() =>
      UpdateProfileResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateProfileResponse copyWith(
          void Function(UpdateProfileResponse) updates) =>
      super.copyWith((message) => updates(message as UpdateProfileResponse))
          as UpdateProfileResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateProfileResponse create() => UpdateProfileResponse._();
  @$core.override
  UpdateProfileResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateProfileResponse> createRepeated() =>
      $pb.PbList<UpdateProfileResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateProfileResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateProfileResponse>(create);
  static UpdateProfileResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get msg => $_getSZ(1);
  @$pb.TagNumber(2)
  set msg($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMsg() => $_has(1);
  @$pb.TagNumber(2)
  void clearMsg() => $_clearField(2);

  @$pb.TagNumber(3)
  User get user => $_getN(2);
  @$pb.TagNumber(3)
  set user(User value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasUser() => $_has(2);
  @$pb.TagNumber(3)
  void clearUser() => $_clearField(3);
  @$pb.TagNumber(3)
  User ensureUser() => $_ensure(2);
}

/// ===== Facial Login =====
class FacialLoginRequest extends $pb.GeneratedMessage {
  factory FacialLoginRequest({
    $core.List<$core.int>? facialData,
    $core.String? deviceId,
  }) {
    final result = create();
    if (facialData != null) result.facialData = facialData;
    if (deviceId != null) result.deviceId = deviceId;
    return result;
  }

  FacialLoginRequest._();

  factory FacialLoginRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FacialLoginRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FacialLoginRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..a<$core.List<$core.int>>(
        1, _omitFieldNames ? '' : 'facialData', $pb.PbFieldType.OY)
    ..aOS(2, _omitFieldNames ? '' : 'deviceId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FacialLoginRequest clone() => FacialLoginRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FacialLoginRequest copyWith(void Function(FacialLoginRequest) updates) =>
      super.copyWith((message) => updates(message as FacialLoginRequest))
          as FacialLoginRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FacialLoginRequest create() => FacialLoginRequest._();
  @$core.override
  FacialLoginRequest createEmptyInstance() => create();
  static $pb.PbList<FacialLoginRequest> createRepeated() =>
      $pb.PbList<FacialLoginRequest>();
  @$core.pragma('dart2js:noInline')
  static FacialLoginRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FacialLoginRequest>(create);
  static FacialLoginRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get facialData => $_getN(0);
  @$pb.TagNumber(1)
  set facialData($core.List<$core.int> value) => $_setBytes(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFacialData() => $_has(0);
  @$pb.TagNumber(1)
  void clearFacialData() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get deviceId => $_getSZ(1);
  @$pb.TagNumber(2)
  set deviceId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDeviceId() => $_has(1);
  @$pb.TagNumber(2)
  void clearDeviceId() => $_clearField(2);
}

class FacialLoginResponse extends $pb.GeneratedMessage {
  factory FacialLoginResponse({
    $core.String? accessToken,
    $core.String? refreshToken,
    $fixnum.Int64? expiresIn,
    User? user,
  }) {
    final result = create();
    if (accessToken != null) result.accessToken = accessToken;
    if (refreshToken != null) result.refreshToken = refreshToken;
    if (expiresIn != null) result.expiresIn = expiresIn;
    if (user != null) result.user = user;
    return result;
  }

  FacialLoginResponse._();

  factory FacialLoginResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FacialLoginResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FacialLoginResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accessToken')
    ..aOS(2, _omitFieldNames ? '' : 'refreshToken')
    ..aInt64(3, _omitFieldNames ? '' : 'expiresIn')
    ..aOM<User>(4, _omitFieldNames ? '' : 'user', subBuilder: User.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FacialLoginResponse clone() => FacialLoginResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FacialLoginResponse copyWith(void Function(FacialLoginResponse) updates) =>
      super.copyWith((message) => updates(message as FacialLoginResponse))
          as FacialLoginResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FacialLoginResponse create() => FacialLoginResponse._();
  @$core.override
  FacialLoginResponse createEmptyInstance() => create();
  static $pb.PbList<FacialLoginResponse> createRepeated() =>
      $pb.PbList<FacialLoginResponse>();
  @$core.pragma('dart2js:noInline')
  static FacialLoginResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FacialLoginResponse>(create);
  static FacialLoginResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accessToken => $_getSZ(0);
  @$pb.TagNumber(1)
  set accessToken($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAccessToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccessToken() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get refreshToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set refreshToken($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRefreshToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearRefreshToken() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get expiresIn => $_getI64(2);
  @$pb.TagNumber(3)
  set expiresIn($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasExpiresIn() => $_has(2);
  @$pb.TagNumber(3)
  void clearExpiresIn() => $_clearField(3);

  @$pb.TagNumber(4)
  User get user => $_getN(3);
  @$pb.TagNumber(4)
  set user(User value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasUser() => $_has(3);
  @$pb.TagNumber(4)
  void clearUser() => $_clearField(4);
  @$pb.TagNumber(4)
  User ensureUser() => $_ensure(3);
}

/// ===== Social Login =====
class SocialLoginRequest extends $pb.GeneratedMessage {
  factory SocialLoginRequest({
    $core.String? provider,
    $core.String? providerToken,
    $core.String? email,
    $core.String? firstName,
    $core.String? lastName,
    $core.String? providerUserId,
  }) {
    final result = create();
    if (provider != null) result.provider = provider;
    if (providerToken != null) result.providerToken = providerToken;
    if (email != null) result.email = email;
    if (firstName != null) result.firstName = firstName;
    if (lastName != null) result.lastName = lastName;
    if (providerUserId != null) result.providerUserId = providerUserId;
    return result;
  }

  SocialLoginRequest._();

  factory SocialLoginRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SocialLoginRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SocialLoginRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'provider')
    ..aOS(2, _omitFieldNames ? '' : 'providerToken')
    ..aOS(3, _omitFieldNames ? '' : 'email')
    ..aOS(4, _omitFieldNames ? '' : 'firstName')
    ..aOS(5, _omitFieldNames ? '' : 'lastName')
    ..aOS(6, _omitFieldNames ? '' : 'providerUserId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SocialLoginRequest clone() => SocialLoginRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SocialLoginRequest copyWith(void Function(SocialLoginRequest) updates) =>
      super.copyWith((message) => updates(message as SocialLoginRequest))
          as SocialLoginRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SocialLoginRequest create() => SocialLoginRequest._();
  @$core.override
  SocialLoginRequest createEmptyInstance() => create();
  static $pb.PbList<SocialLoginRequest> createRepeated() =>
      $pb.PbList<SocialLoginRequest>();
  @$core.pragma('dart2js:noInline')
  static SocialLoginRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SocialLoginRequest>(create);
  static SocialLoginRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get provider => $_getSZ(0);
  @$pb.TagNumber(1)
  set provider($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasProvider() => $_has(0);
  @$pb.TagNumber(1)
  void clearProvider() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get providerToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set providerToken($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasProviderToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearProviderToken() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get email => $_getSZ(2);
  @$pb.TagNumber(3)
  set email($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasEmail() => $_has(2);
  @$pb.TagNumber(3)
  void clearEmail() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get firstName => $_getSZ(3);
  @$pb.TagNumber(4)
  set firstName($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasFirstName() => $_has(3);
  @$pb.TagNumber(4)
  void clearFirstName() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get lastName => $_getSZ(4);
  @$pb.TagNumber(5)
  set lastName($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasLastName() => $_has(4);
  @$pb.TagNumber(5)
  void clearLastName() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get providerUserId => $_getSZ(5);
  @$pb.TagNumber(6)
  set providerUserId($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasProviderUserId() => $_has(5);
  @$pb.TagNumber(6)
  void clearProviderUserId() => $_clearField(6);
}

class SocialLoginResponse extends $pb.GeneratedMessage {
  factory SocialLoginResponse({
    $core.String? accessToken,
    $core.String? refreshToken,
    $fixnum.Int64? expiresIn,
    User? user,
    $core.bool? isNewUser,
  }) {
    final result = create();
    if (accessToken != null) result.accessToken = accessToken;
    if (refreshToken != null) result.refreshToken = refreshToken;
    if (expiresIn != null) result.expiresIn = expiresIn;
    if (user != null) result.user = user;
    if (isNewUser != null) result.isNewUser = isNewUser;
    return result;
  }

  SocialLoginResponse._();

  factory SocialLoginResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SocialLoginResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SocialLoginResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accessToken')
    ..aOS(2, _omitFieldNames ? '' : 'refreshToken')
    ..aInt64(3, _omitFieldNames ? '' : 'expiresIn')
    ..aOM<User>(4, _omitFieldNames ? '' : 'user', subBuilder: User.create)
    ..aOB(5, _omitFieldNames ? '' : 'isNewUser')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SocialLoginResponse clone() => SocialLoginResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SocialLoginResponse copyWith(void Function(SocialLoginResponse) updates) =>
      super.copyWith((message) => updates(message as SocialLoginResponse))
          as SocialLoginResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SocialLoginResponse create() => SocialLoginResponse._();
  @$core.override
  SocialLoginResponse createEmptyInstance() => create();
  static $pb.PbList<SocialLoginResponse> createRepeated() =>
      $pb.PbList<SocialLoginResponse>();
  @$core.pragma('dart2js:noInline')
  static SocialLoginResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SocialLoginResponse>(create);
  static SocialLoginResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accessToken => $_getSZ(0);
  @$pb.TagNumber(1)
  set accessToken($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAccessToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccessToken() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get refreshToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set refreshToken($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRefreshToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearRefreshToken() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get expiresIn => $_getI64(2);
  @$pb.TagNumber(3)
  set expiresIn($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasExpiresIn() => $_has(2);
  @$pb.TagNumber(3)
  void clearExpiresIn() => $_clearField(3);

  @$pb.TagNumber(4)
  User get user => $_getN(3);
  @$pb.TagNumber(4)
  set user(User value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasUser() => $_has(3);
  @$pb.TagNumber(4)
  void clearUser() => $_clearField(4);
  @$pb.TagNumber(4)
  User ensureUser() => $_ensure(3);

  @$pb.TagNumber(5)
  $core.bool get isNewUser => $_getBF(4);
  @$pb.TagNumber(5)
  set isNewUser($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasIsNewUser() => $_has(4);
  @$pb.TagNumber(5)
  void clearIsNewUser() => $_clearField(5);
}

/// ===== Social Account Linking =====
class LinkedSocialAccount extends $pb.GeneratedMessage {
  factory LinkedSocialAccount({
    $core.String? id,
    $core.String? userId,
    $core.String? provider,
    $core.String? providerUserId,
    $core.String? providerEmail,
    $core.String? displayName,
    $core.String? profilePictureUrl,
    $core.String? profileUrl,
    $core.String? status,
    $core.bool? isPrimary,
    $core.String? linkedAt,
    $core.String? lastUsedAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (userId != null) result.userId = userId;
    if (provider != null) result.provider = provider;
    if (providerUserId != null) result.providerUserId = providerUserId;
    if (providerEmail != null) result.providerEmail = providerEmail;
    if (displayName != null) result.displayName = displayName;
    if (profilePictureUrl != null) result.profilePictureUrl = profilePictureUrl;
    if (profileUrl != null) result.profileUrl = profileUrl;
    if (status != null) result.status = status;
    if (isPrimary != null) result.isPrimary = isPrimary;
    if (linkedAt != null) result.linkedAt = linkedAt;
    if (lastUsedAt != null) result.lastUsedAt = lastUsedAt;
    return result;
  }

  LinkedSocialAccount._();

  factory LinkedSocialAccount.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory LinkedSocialAccount.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LinkedSocialAccount',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'provider')
    ..aOS(4, _omitFieldNames ? '' : 'providerUserId')
    ..aOS(5, _omitFieldNames ? '' : 'providerEmail')
    ..aOS(6, _omitFieldNames ? '' : 'displayName')
    ..aOS(7, _omitFieldNames ? '' : 'profilePictureUrl')
    ..aOS(8, _omitFieldNames ? '' : 'profileUrl')
    ..aOS(9, _omitFieldNames ? '' : 'status')
    ..aOB(10, _omitFieldNames ? '' : 'isPrimary')
    ..aOS(11, _omitFieldNames ? '' : 'linkedAt')
    ..aOS(12, _omitFieldNames ? '' : 'lastUsedAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LinkedSocialAccount clone() => LinkedSocialAccount()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LinkedSocialAccount copyWith(void Function(LinkedSocialAccount) updates) =>
      super.copyWith((message) => updates(message as LinkedSocialAccount))
          as LinkedSocialAccount;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LinkedSocialAccount create() => LinkedSocialAccount._();
  @$core.override
  LinkedSocialAccount createEmptyInstance() => create();
  static $pb.PbList<LinkedSocialAccount> createRepeated() =>
      $pb.PbList<LinkedSocialAccount>();
  @$core.pragma('dart2js:noInline')
  static LinkedSocialAccount getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LinkedSocialAccount>(create);
  static LinkedSocialAccount? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get provider => $_getSZ(2);
  @$pb.TagNumber(3)
  set provider($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasProvider() => $_has(2);
  @$pb.TagNumber(3)
  void clearProvider() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get providerUserId => $_getSZ(3);
  @$pb.TagNumber(4)
  set providerUserId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasProviderUserId() => $_has(3);
  @$pb.TagNumber(4)
  void clearProviderUserId() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get providerEmail => $_getSZ(4);
  @$pb.TagNumber(5)
  set providerEmail($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasProviderEmail() => $_has(4);
  @$pb.TagNumber(5)
  void clearProviderEmail() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get displayName => $_getSZ(5);
  @$pb.TagNumber(6)
  set displayName($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasDisplayName() => $_has(5);
  @$pb.TagNumber(6)
  void clearDisplayName() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get profilePictureUrl => $_getSZ(6);
  @$pb.TagNumber(7)
  set profilePictureUrl($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasProfilePictureUrl() => $_has(6);
  @$pb.TagNumber(7)
  void clearProfilePictureUrl() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get profileUrl => $_getSZ(7);
  @$pb.TagNumber(8)
  set profileUrl($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasProfileUrl() => $_has(7);
  @$pb.TagNumber(8)
  void clearProfileUrl() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get status => $_getSZ(8);
  @$pb.TagNumber(9)
  set status($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasStatus() => $_has(8);
  @$pb.TagNumber(9)
  void clearStatus() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.bool get isPrimary => $_getBF(9);
  @$pb.TagNumber(10)
  set isPrimary($core.bool value) => $_setBool(9, value);
  @$pb.TagNumber(10)
  $core.bool hasIsPrimary() => $_has(9);
  @$pb.TagNumber(10)
  void clearIsPrimary() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get linkedAt => $_getSZ(10);
  @$pb.TagNumber(11)
  set linkedAt($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasLinkedAt() => $_has(10);
  @$pb.TagNumber(11)
  void clearLinkedAt() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get lastUsedAt => $_getSZ(11);
  @$pb.TagNumber(12)
  set lastUsedAt($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasLastUsedAt() => $_has(11);
  @$pb.TagNumber(12)
  void clearLastUsedAt() => $_clearField(12);
}

class GetLinkedSocialAccountsRequest extends $pb.GeneratedMessage {
  factory GetLinkedSocialAccountsRequest() => create();

  GetLinkedSocialAccountsRequest._();

  factory GetLinkedSocialAccountsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetLinkedSocialAccountsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetLinkedSocialAccountsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetLinkedSocialAccountsRequest clone() =>
      GetLinkedSocialAccountsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetLinkedSocialAccountsRequest copyWith(
          void Function(GetLinkedSocialAccountsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetLinkedSocialAccountsRequest))
          as GetLinkedSocialAccountsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetLinkedSocialAccountsRequest create() =>
      GetLinkedSocialAccountsRequest._();
  @$core.override
  GetLinkedSocialAccountsRequest createEmptyInstance() => create();
  static $pb.PbList<GetLinkedSocialAccountsRequest> createRepeated() =>
      $pb.PbList<GetLinkedSocialAccountsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetLinkedSocialAccountsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetLinkedSocialAccountsRequest>(create);
  static GetLinkedSocialAccountsRequest? _defaultInstance;
}

class GetLinkedSocialAccountsResponse extends $pb.GeneratedMessage {
  factory GetLinkedSocialAccountsResponse({
    $core.bool? success,
    $core.Iterable<LinkedSocialAccount>? accounts,
    $core.int? totalCount,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (accounts != null) result.accounts.addAll(accounts);
    if (totalCount != null) result.totalCount = totalCount;
    return result;
  }

  GetLinkedSocialAccountsResponse._();

  factory GetLinkedSocialAccountsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetLinkedSocialAccountsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetLinkedSocialAccountsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..pc<LinkedSocialAccount>(
        2, _omitFieldNames ? '' : 'accounts', $pb.PbFieldType.PM,
        subBuilder: LinkedSocialAccount.create)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'totalCount', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetLinkedSocialAccountsResponse clone() =>
      GetLinkedSocialAccountsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetLinkedSocialAccountsResponse copyWith(
          void Function(GetLinkedSocialAccountsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetLinkedSocialAccountsResponse))
          as GetLinkedSocialAccountsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetLinkedSocialAccountsResponse create() =>
      GetLinkedSocialAccountsResponse._();
  @$core.override
  GetLinkedSocialAccountsResponse createEmptyInstance() => create();
  static $pb.PbList<GetLinkedSocialAccountsResponse> createRepeated() =>
      $pb.PbList<GetLinkedSocialAccountsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetLinkedSocialAccountsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetLinkedSocialAccountsResponse>(
          create);
  static GetLinkedSocialAccountsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<LinkedSocialAccount> get accounts => $_getList(1);

  @$pb.TagNumber(3)
  $core.int get totalCount => $_getIZ(2);
  @$pb.TagNumber(3)
  set totalCount($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTotalCount() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalCount() => $_clearField(3);
}

class LinkSocialAccountRequest extends $pb.GeneratedMessage {
  factory LinkSocialAccountRequest({
    $core.String? provider,
    $core.String? providerToken,
    $core.String? providerUserId,
    $core.String? providerEmail,
    $core.String? displayName,
    $core.String? profilePictureUrl,
    $core.String? profileUrl,
    $core.bool? setAsPrimary,
  }) {
    final result = create();
    if (provider != null) result.provider = provider;
    if (providerToken != null) result.providerToken = providerToken;
    if (providerUserId != null) result.providerUserId = providerUserId;
    if (providerEmail != null) result.providerEmail = providerEmail;
    if (displayName != null) result.displayName = displayName;
    if (profilePictureUrl != null) result.profilePictureUrl = profilePictureUrl;
    if (profileUrl != null) result.profileUrl = profileUrl;
    if (setAsPrimary != null) result.setAsPrimary = setAsPrimary;
    return result;
  }

  LinkSocialAccountRequest._();

  factory LinkSocialAccountRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory LinkSocialAccountRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LinkSocialAccountRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'provider')
    ..aOS(2, _omitFieldNames ? '' : 'providerToken')
    ..aOS(3, _omitFieldNames ? '' : 'providerUserId')
    ..aOS(4, _omitFieldNames ? '' : 'providerEmail')
    ..aOS(5, _omitFieldNames ? '' : 'displayName')
    ..aOS(6, _omitFieldNames ? '' : 'profilePictureUrl')
    ..aOS(7, _omitFieldNames ? '' : 'profileUrl')
    ..aOB(8, _omitFieldNames ? '' : 'setAsPrimary')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LinkSocialAccountRequest clone() =>
      LinkSocialAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LinkSocialAccountRequest copyWith(
          void Function(LinkSocialAccountRequest) updates) =>
      super.copyWith((message) => updates(message as LinkSocialAccountRequest))
          as LinkSocialAccountRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LinkSocialAccountRequest create() => LinkSocialAccountRequest._();
  @$core.override
  LinkSocialAccountRequest createEmptyInstance() => create();
  static $pb.PbList<LinkSocialAccountRequest> createRepeated() =>
      $pb.PbList<LinkSocialAccountRequest>();
  @$core.pragma('dart2js:noInline')
  static LinkSocialAccountRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LinkSocialAccountRequest>(create);
  static LinkSocialAccountRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get provider => $_getSZ(0);
  @$pb.TagNumber(1)
  set provider($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasProvider() => $_has(0);
  @$pb.TagNumber(1)
  void clearProvider() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get providerToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set providerToken($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasProviderToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearProviderToken() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get providerUserId => $_getSZ(2);
  @$pb.TagNumber(3)
  set providerUserId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasProviderUserId() => $_has(2);
  @$pb.TagNumber(3)
  void clearProviderUserId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get providerEmail => $_getSZ(3);
  @$pb.TagNumber(4)
  set providerEmail($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasProviderEmail() => $_has(3);
  @$pb.TagNumber(4)
  void clearProviderEmail() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get displayName => $_getSZ(4);
  @$pb.TagNumber(5)
  set displayName($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasDisplayName() => $_has(4);
  @$pb.TagNumber(5)
  void clearDisplayName() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get profilePictureUrl => $_getSZ(5);
  @$pb.TagNumber(6)
  set profilePictureUrl($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasProfilePictureUrl() => $_has(5);
  @$pb.TagNumber(6)
  void clearProfilePictureUrl() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get profileUrl => $_getSZ(6);
  @$pb.TagNumber(7)
  set profileUrl($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasProfileUrl() => $_has(6);
  @$pb.TagNumber(7)
  void clearProfileUrl() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.bool get setAsPrimary => $_getBF(7);
  @$pb.TagNumber(8)
  set setAsPrimary($core.bool value) => $_setBool(7, value);
  @$pb.TagNumber(8)
  $core.bool hasSetAsPrimary() => $_has(7);
  @$pb.TagNumber(8)
  void clearSetAsPrimary() => $_clearField(8);
}

class LinkSocialAccountResponse extends $pb.GeneratedMessage {
  factory LinkSocialAccountResponse({
    $core.bool? success,
    $core.String? message,
    LinkedSocialAccount? account,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (account != null) result.account = account;
    return result;
  }

  LinkSocialAccountResponse._();

  factory LinkSocialAccountResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory LinkSocialAccountResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LinkSocialAccountResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<LinkedSocialAccount>(3, _omitFieldNames ? '' : 'account',
        subBuilder: LinkedSocialAccount.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LinkSocialAccountResponse clone() =>
      LinkSocialAccountResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LinkSocialAccountResponse copyWith(
          void Function(LinkSocialAccountResponse) updates) =>
      super.copyWith((message) => updates(message as LinkSocialAccountResponse))
          as LinkSocialAccountResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LinkSocialAccountResponse create() => LinkSocialAccountResponse._();
  @$core.override
  LinkSocialAccountResponse createEmptyInstance() => create();
  static $pb.PbList<LinkSocialAccountResponse> createRepeated() =>
      $pb.PbList<LinkSocialAccountResponse>();
  @$core.pragma('dart2js:noInline')
  static LinkSocialAccountResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LinkSocialAccountResponse>(create);
  static LinkSocialAccountResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);

  @$pb.TagNumber(3)
  LinkedSocialAccount get account => $_getN(2);
  @$pb.TagNumber(3)
  set account(LinkedSocialAccount value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasAccount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAccount() => $_clearField(3);
  @$pb.TagNumber(3)
  LinkedSocialAccount ensureAccount() => $_ensure(2);
}

class UnlinkSocialAccountRequest extends $pb.GeneratedMessage {
  factory UnlinkSocialAccountRequest({
    $core.String? accountId,
  }) {
    final result = create();
    if (accountId != null) result.accountId = accountId;
    return result;
  }

  UnlinkSocialAccountRequest._();

  factory UnlinkSocialAccountRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UnlinkSocialAccountRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UnlinkSocialAccountRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UnlinkSocialAccountRequest clone() =>
      UnlinkSocialAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UnlinkSocialAccountRequest copyWith(
          void Function(UnlinkSocialAccountRequest) updates) =>
      super.copyWith(
              (message) => updates(message as UnlinkSocialAccountRequest))
          as UnlinkSocialAccountRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UnlinkSocialAccountRequest create() => UnlinkSocialAccountRequest._();
  @$core.override
  UnlinkSocialAccountRequest createEmptyInstance() => create();
  static $pb.PbList<UnlinkSocialAccountRequest> createRepeated() =>
      $pb.PbList<UnlinkSocialAccountRequest>();
  @$core.pragma('dart2js:noInline')
  static UnlinkSocialAccountRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UnlinkSocialAccountRequest>(create);
  static UnlinkSocialAccountRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => $_clearField(1);
}

class UnlinkSocialAccountResponse extends $pb.GeneratedMessage {
  factory UnlinkSocialAccountResponse({
    $core.bool? success,
    $core.String? message,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    return result;
  }

  UnlinkSocialAccountResponse._();

  factory UnlinkSocialAccountResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UnlinkSocialAccountResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UnlinkSocialAccountResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UnlinkSocialAccountResponse clone() =>
      UnlinkSocialAccountResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UnlinkSocialAccountResponse copyWith(
          void Function(UnlinkSocialAccountResponse) updates) =>
      super.copyWith(
              (message) => updates(message as UnlinkSocialAccountResponse))
          as UnlinkSocialAccountResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UnlinkSocialAccountResponse create() =>
      UnlinkSocialAccountResponse._();
  @$core.override
  UnlinkSocialAccountResponse createEmptyInstance() => create();
  static $pb.PbList<UnlinkSocialAccountResponse> createRepeated() =>
      $pb.PbList<UnlinkSocialAccountResponse>();
  @$core.pragma('dart2js:noInline')
  static UnlinkSocialAccountResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UnlinkSocialAccountResponse>(create);
  static UnlinkSocialAccountResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);
}

class SetPrimarySocialAccountRequest extends $pb.GeneratedMessage {
  factory SetPrimarySocialAccountRequest({
    $core.String? accountId,
  }) {
    final result = create();
    if (accountId != null) result.accountId = accountId;
    return result;
  }

  SetPrimarySocialAccountRequest._();

  factory SetPrimarySocialAccountRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SetPrimarySocialAccountRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SetPrimarySocialAccountRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetPrimarySocialAccountRequest clone() =>
      SetPrimarySocialAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetPrimarySocialAccountRequest copyWith(
          void Function(SetPrimarySocialAccountRequest) updates) =>
      super.copyWith(
              (message) => updates(message as SetPrimarySocialAccountRequest))
          as SetPrimarySocialAccountRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SetPrimarySocialAccountRequest create() =>
      SetPrimarySocialAccountRequest._();
  @$core.override
  SetPrimarySocialAccountRequest createEmptyInstance() => create();
  static $pb.PbList<SetPrimarySocialAccountRequest> createRepeated() =>
      $pb.PbList<SetPrimarySocialAccountRequest>();
  @$core.pragma('dart2js:noInline')
  static SetPrimarySocialAccountRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SetPrimarySocialAccountRequest>(create);
  static SetPrimarySocialAccountRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => $_clearField(1);
}

class SetPrimarySocialAccountResponse extends $pb.GeneratedMessage {
  factory SetPrimarySocialAccountResponse({
    $core.bool? success,
    $core.String? message,
    LinkedSocialAccount? account,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (account != null) result.account = account;
    return result;
  }

  SetPrimarySocialAccountResponse._();

  factory SetPrimarySocialAccountResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SetPrimarySocialAccountResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SetPrimarySocialAccountResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<LinkedSocialAccount>(3, _omitFieldNames ? '' : 'account',
        subBuilder: LinkedSocialAccount.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetPrimarySocialAccountResponse clone() =>
      SetPrimarySocialAccountResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetPrimarySocialAccountResponse copyWith(
          void Function(SetPrimarySocialAccountResponse) updates) =>
      super.copyWith(
              (message) => updates(message as SetPrimarySocialAccountResponse))
          as SetPrimarySocialAccountResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SetPrimarySocialAccountResponse create() =>
      SetPrimarySocialAccountResponse._();
  @$core.override
  SetPrimarySocialAccountResponse createEmptyInstance() => create();
  static $pb.PbList<SetPrimarySocialAccountResponse> createRepeated() =>
      $pb.PbList<SetPrimarySocialAccountResponse>();
  @$core.pragma('dart2js:noInline')
  static SetPrimarySocialAccountResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SetPrimarySocialAccountResponse>(
          create);
  static SetPrimarySocialAccountResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);

  @$pb.TagNumber(3)
  LinkedSocialAccount get account => $_getN(2);
  @$pb.TagNumber(3)
  set account(LinkedSocialAccount value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasAccount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAccount() => $_clearField(3);
  @$pb.TagNumber(3)
  LinkedSocialAccount ensureAccount() => $_ensure(2);
}

class ReauthorizeSocialAccountRequest extends $pb.GeneratedMessage {
  factory ReauthorizeSocialAccountRequest({
    $core.String? accountId,
    $core.String? providerToken,
  }) {
    final result = create();
    if (accountId != null) result.accountId = accountId;
    if (providerToken != null) result.providerToken = providerToken;
    return result;
  }

  ReauthorizeSocialAccountRequest._();

  factory ReauthorizeSocialAccountRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ReauthorizeSocialAccountRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ReauthorizeSocialAccountRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..aOS(2, _omitFieldNames ? '' : 'providerToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReauthorizeSocialAccountRequest clone() =>
      ReauthorizeSocialAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReauthorizeSocialAccountRequest copyWith(
          void Function(ReauthorizeSocialAccountRequest) updates) =>
      super.copyWith(
              (message) => updates(message as ReauthorizeSocialAccountRequest))
          as ReauthorizeSocialAccountRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ReauthorizeSocialAccountRequest create() =>
      ReauthorizeSocialAccountRequest._();
  @$core.override
  ReauthorizeSocialAccountRequest createEmptyInstance() => create();
  static $pb.PbList<ReauthorizeSocialAccountRequest> createRepeated() =>
      $pb.PbList<ReauthorizeSocialAccountRequest>();
  @$core.pragma('dart2js:noInline')
  static ReauthorizeSocialAccountRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ReauthorizeSocialAccountRequest>(
          create);
  static ReauthorizeSocialAccountRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get providerToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set providerToken($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasProviderToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearProviderToken() => $_clearField(2);
}

class ReauthorizeSocialAccountResponse extends $pb.GeneratedMessage {
  factory ReauthorizeSocialAccountResponse({
    $core.bool? success,
    $core.String? message,
    LinkedSocialAccount? account,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (account != null) result.account = account;
    return result;
  }

  ReauthorizeSocialAccountResponse._();

  factory ReauthorizeSocialAccountResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ReauthorizeSocialAccountResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ReauthorizeSocialAccountResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<LinkedSocialAccount>(3, _omitFieldNames ? '' : 'account',
        subBuilder: LinkedSocialAccount.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReauthorizeSocialAccountResponse clone() =>
      ReauthorizeSocialAccountResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReauthorizeSocialAccountResponse copyWith(
          void Function(ReauthorizeSocialAccountResponse) updates) =>
      super.copyWith(
              (message) => updates(message as ReauthorizeSocialAccountResponse))
          as ReauthorizeSocialAccountResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ReauthorizeSocialAccountResponse create() =>
      ReauthorizeSocialAccountResponse._();
  @$core.override
  ReauthorizeSocialAccountResponse createEmptyInstance() => create();
  static $pb.PbList<ReauthorizeSocialAccountResponse> createRepeated() =>
      $pb.PbList<ReauthorizeSocialAccountResponse>();
  @$core.pragma('dart2js:noInline')
  static ReauthorizeSocialAccountResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ReauthorizeSocialAccountResponse>(
          create);
  static ReauthorizeSocialAccountResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);

  @$pb.TagNumber(3)
  LinkedSocialAccount get account => $_getN(2);
  @$pb.TagNumber(3)
  set account(LinkedSocialAccount value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasAccount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAccount() => $_clearField(3);
  @$pb.TagNumber(3)
  LinkedSocialAccount ensureAccount() => $_ensure(2);
}

/// ===== Two-Factor Authentication =====
class EnableTwoFactorRequest extends $pb.GeneratedMessage {
  factory EnableTwoFactorRequest({
    $core.String? userId,
    $core.String? method,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (method != null) result.method = method;
    return result;
  }

  EnableTwoFactorRequest._();

  factory EnableTwoFactorRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory EnableTwoFactorRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EnableTwoFactorRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'method')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EnableTwoFactorRequest clone() =>
      EnableTwoFactorRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EnableTwoFactorRequest copyWith(
          void Function(EnableTwoFactorRequest) updates) =>
      super.copyWith((message) => updates(message as EnableTwoFactorRequest))
          as EnableTwoFactorRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EnableTwoFactorRequest create() => EnableTwoFactorRequest._();
  @$core.override
  EnableTwoFactorRequest createEmptyInstance() => create();
  static $pb.PbList<EnableTwoFactorRequest> createRepeated() =>
      $pb.PbList<EnableTwoFactorRequest>();
  @$core.pragma('dart2js:noInline')
  static EnableTwoFactorRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EnableTwoFactorRequest>(create);
  static EnableTwoFactorRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get method => $_getSZ(1);
  @$pb.TagNumber(2)
  set method($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMethod() => $_has(1);
  @$pb.TagNumber(2)
  void clearMethod() => $_clearField(2);
}

class EnableTwoFactorResponse extends $pb.GeneratedMessage {
  factory EnableTwoFactorResponse({
    $core.String? message,
    $core.String? qrCode,
    $core.String? secret,
    $core.Iterable<$core.String>? backupCodes,
    $core.String? methodName,
    $core.bool? verificationRequired,
  }) {
    final result = create();
    if (message != null) result.message = message;
    if (qrCode != null) result.qrCode = qrCode;
    if (secret != null) result.secret = secret;
    if (backupCodes != null) result.backupCodes.addAll(backupCodes);
    if (methodName != null) result.methodName = methodName;
    if (verificationRequired != null)
      result.verificationRequired = verificationRequired;
    return result;
  }

  EnableTwoFactorResponse._();

  factory EnableTwoFactorResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory EnableTwoFactorResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EnableTwoFactorResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'message')
    ..aOS(2, _omitFieldNames ? '' : 'qrCode')
    ..aOS(3, _omitFieldNames ? '' : 'secret')
    ..pPS(4, _omitFieldNames ? '' : 'backupCodes')
    ..aOS(5, _omitFieldNames ? '' : 'methodName')
    ..aOB(6, _omitFieldNames ? '' : 'verificationRequired')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EnableTwoFactorResponse clone() =>
      EnableTwoFactorResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EnableTwoFactorResponse copyWith(
          void Function(EnableTwoFactorResponse) updates) =>
      super.copyWith((message) => updates(message as EnableTwoFactorResponse))
          as EnableTwoFactorResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EnableTwoFactorResponse create() => EnableTwoFactorResponse._();
  @$core.override
  EnableTwoFactorResponse createEmptyInstance() => create();
  static $pb.PbList<EnableTwoFactorResponse> createRepeated() =>
      $pb.PbList<EnableTwoFactorResponse>();
  @$core.pragma('dart2js:noInline')
  static EnableTwoFactorResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EnableTwoFactorResponse>(create);
  static EnableTwoFactorResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get message => $_getSZ(0);
  @$pb.TagNumber(1)
  set message($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessage() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get qrCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set qrCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasQrCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearQrCode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get secret => $_getSZ(2);
  @$pb.TagNumber(3)
  set secret($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSecret() => $_has(2);
  @$pb.TagNumber(3)
  void clearSecret() => $_clearField(3);

  @$pb.TagNumber(4)
  $pb.PbList<$core.String> get backupCodes => $_getList(3);

  @$pb.TagNumber(5)
  $core.String get methodName => $_getSZ(4);
  @$pb.TagNumber(5)
  set methodName($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasMethodName() => $_has(4);
  @$pb.TagNumber(5)
  void clearMethodName() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.bool get verificationRequired => $_getBF(5);
  @$pb.TagNumber(6)
  set verificationRequired($core.bool value) => $_setBool(5, value);
  @$pb.TagNumber(6)
  $core.bool hasVerificationRequired() => $_has(5);
  @$pb.TagNumber(6)
  void clearVerificationRequired() => $_clearField(6);
}

class VerifyTwoFactorRequest extends $pb.GeneratedMessage {
  factory VerifyTwoFactorRequest({
    $core.String? twoFactorToken,
    $core.String? code,
    $core.String? method,
  }) {
    final result = create();
    if (twoFactorToken != null) result.twoFactorToken = twoFactorToken;
    if (code != null) result.code = code;
    if (method != null) result.method = method;
    return result;
  }

  VerifyTwoFactorRequest._();

  factory VerifyTwoFactorRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VerifyTwoFactorRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VerifyTwoFactorRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'twoFactorToken')
    ..aOS(2, _omitFieldNames ? '' : 'code')
    ..aOS(3, _omitFieldNames ? '' : 'method')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyTwoFactorRequest clone() =>
      VerifyTwoFactorRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyTwoFactorRequest copyWith(
          void Function(VerifyTwoFactorRequest) updates) =>
      super.copyWith((message) => updates(message as VerifyTwoFactorRequest))
          as VerifyTwoFactorRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VerifyTwoFactorRequest create() => VerifyTwoFactorRequest._();
  @$core.override
  VerifyTwoFactorRequest createEmptyInstance() => create();
  static $pb.PbList<VerifyTwoFactorRequest> createRepeated() =>
      $pb.PbList<VerifyTwoFactorRequest>();
  @$core.pragma('dart2js:noInline')
  static VerifyTwoFactorRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VerifyTwoFactorRequest>(create);
  static VerifyTwoFactorRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get twoFactorToken => $_getSZ(0);
  @$pb.TagNumber(1)
  set twoFactorToken($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTwoFactorToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearTwoFactorToken() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get code => $_getSZ(1);
  @$pb.TagNumber(2)
  set code($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearCode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get method => $_getSZ(2);
  @$pb.TagNumber(3)
  set method($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMethod() => $_has(2);
  @$pb.TagNumber(3)
  void clearMethod() => $_clearField(3);
}

class VerifyTwoFactorResponse extends $pb.GeneratedMessage {
  factory VerifyTwoFactorResponse({
    $core.String? accessToken,
    $core.String? refreshToken,
    $fixnum.Int64? expiresIn,
    User? user,
  }) {
    final result = create();
    if (accessToken != null) result.accessToken = accessToken;
    if (refreshToken != null) result.refreshToken = refreshToken;
    if (expiresIn != null) result.expiresIn = expiresIn;
    if (user != null) result.user = user;
    return result;
  }

  VerifyTwoFactorResponse._();

  factory VerifyTwoFactorResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VerifyTwoFactorResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VerifyTwoFactorResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accessToken')
    ..aOS(2, _omitFieldNames ? '' : 'refreshToken')
    ..aInt64(3, _omitFieldNames ? '' : 'expiresIn')
    ..aOM<User>(4, _omitFieldNames ? '' : 'user', subBuilder: User.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyTwoFactorResponse clone() =>
      VerifyTwoFactorResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyTwoFactorResponse copyWith(
          void Function(VerifyTwoFactorResponse) updates) =>
      super.copyWith((message) => updates(message as VerifyTwoFactorResponse))
          as VerifyTwoFactorResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VerifyTwoFactorResponse create() => VerifyTwoFactorResponse._();
  @$core.override
  VerifyTwoFactorResponse createEmptyInstance() => create();
  static $pb.PbList<VerifyTwoFactorResponse> createRepeated() =>
      $pb.PbList<VerifyTwoFactorResponse>();
  @$core.pragma('dart2js:noInline')
  static VerifyTwoFactorResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VerifyTwoFactorResponse>(create);
  static VerifyTwoFactorResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accessToken => $_getSZ(0);
  @$pb.TagNumber(1)
  set accessToken($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAccessToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccessToken() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get refreshToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set refreshToken($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRefreshToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearRefreshToken() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get expiresIn => $_getI64(2);
  @$pb.TagNumber(3)
  set expiresIn($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasExpiresIn() => $_has(2);
  @$pb.TagNumber(3)
  void clearExpiresIn() => $_clearField(3);

  @$pb.TagNumber(4)
  User get user => $_getN(3);
  @$pb.TagNumber(4)
  set user(User value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasUser() => $_has(3);
  @$pb.TagNumber(4)
  void clearUser() => $_clearField(4);
  @$pb.TagNumber(4)
  User ensureUser() => $_ensure(3);
}

class CompleteTwoFactorSetupRequest extends $pb.GeneratedMessage {
  factory CompleteTwoFactorSetupRequest({
    $core.String? code,
  }) {
    final result = create();
    if (code != null) result.code = code;
    return result;
  }

  CompleteTwoFactorSetupRequest._();

  factory CompleteTwoFactorSetupRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CompleteTwoFactorSetupRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CompleteTwoFactorSetupRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'code')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CompleteTwoFactorSetupRequest clone() =>
      CompleteTwoFactorSetupRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CompleteTwoFactorSetupRequest copyWith(
          void Function(CompleteTwoFactorSetupRequest) updates) =>
      super.copyWith(
              (message) => updates(message as CompleteTwoFactorSetupRequest))
          as CompleteTwoFactorSetupRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CompleteTwoFactorSetupRequest create() =>
      CompleteTwoFactorSetupRequest._();
  @$core.override
  CompleteTwoFactorSetupRequest createEmptyInstance() => create();
  static $pb.PbList<CompleteTwoFactorSetupRequest> createRepeated() =>
      $pb.PbList<CompleteTwoFactorSetupRequest>();
  @$core.pragma('dart2js:noInline')
  static CompleteTwoFactorSetupRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CompleteTwoFactorSetupRequest>(create);
  static CompleteTwoFactorSetupRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get code => $_getSZ(0);
  @$pb.TagNumber(1)
  set code($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearCode() => $_clearField(1);
}

class CompleteTwoFactorSetupResponse extends $pb.GeneratedMessage {
  factory CompleteTwoFactorSetupResponse({
    $core.bool? success,
    $core.String? message,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    return result;
  }

  CompleteTwoFactorSetupResponse._();

  factory CompleteTwoFactorSetupResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CompleteTwoFactorSetupResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CompleteTwoFactorSetupResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CompleteTwoFactorSetupResponse clone() =>
      CompleteTwoFactorSetupResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CompleteTwoFactorSetupResponse copyWith(
          void Function(CompleteTwoFactorSetupResponse) updates) =>
      super.copyWith(
              (message) => updates(message as CompleteTwoFactorSetupResponse))
          as CompleteTwoFactorSetupResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CompleteTwoFactorSetupResponse create() =>
      CompleteTwoFactorSetupResponse._();
  @$core.override
  CompleteTwoFactorSetupResponse createEmptyInstance() => create();
  static $pb.PbList<CompleteTwoFactorSetupResponse> createRepeated() =>
      $pb.PbList<CompleteTwoFactorSetupResponse>();
  @$core.pragma('dart2js:noInline')
  static CompleteTwoFactorSetupResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CompleteTwoFactorSetupResponse>(create);
  static CompleteTwoFactorSetupResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);
}

class DisableTwoFactorRequest extends $pb.GeneratedMessage {
  factory DisableTwoFactorRequest({
    $core.String? code,
  }) {
    final result = create();
    if (code != null) result.code = code;
    return result;
  }

  DisableTwoFactorRequest._();

  factory DisableTwoFactorRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DisableTwoFactorRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DisableTwoFactorRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'code')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DisableTwoFactorRequest clone() =>
      DisableTwoFactorRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DisableTwoFactorRequest copyWith(
          void Function(DisableTwoFactorRequest) updates) =>
      super.copyWith((message) => updates(message as DisableTwoFactorRequest))
          as DisableTwoFactorRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DisableTwoFactorRequest create() => DisableTwoFactorRequest._();
  @$core.override
  DisableTwoFactorRequest createEmptyInstance() => create();
  static $pb.PbList<DisableTwoFactorRequest> createRepeated() =>
      $pb.PbList<DisableTwoFactorRequest>();
  @$core.pragma('dart2js:noInline')
  static DisableTwoFactorRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DisableTwoFactorRequest>(create);
  static DisableTwoFactorRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get code => $_getSZ(0);
  @$pb.TagNumber(1)
  set code($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearCode() => $_clearField(1);
}

class DisableTwoFactorResponse extends $pb.GeneratedMessage {
  factory DisableTwoFactorResponse({
    $core.bool? success,
    $core.String? message,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    return result;
  }

  DisableTwoFactorResponse._();

  factory DisableTwoFactorResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DisableTwoFactorResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DisableTwoFactorResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DisableTwoFactorResponse clone() =>
      DisableTwoFactorResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DisableTwoFactorResponse copyWith(
          void Function(DisableTwoFactorResponse) updates) =>
      super.copyWith((message) => updates(message as DisableTwoFactorResponse))
          as DisableTwoFactorResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DisableTwoFactorResponse create() => DisableTwoFactorResponse._();
  @$core.override
  DisableTwoFactorResponse createEmptyInstance() => create();
  static $pb.PbList<DisableTwoFactorResponse> createRepeated() =>
      $pb.PbList<DisableTwoFactorResponse>();
  @$core.pragma('dart2js:noInline')
  static DisableTwoFactorResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DisableTwoFactorResponse>(create);
  static DisableTwoFactorResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);
}

class GetTwoFactorStatusRequest extends $pb.GeneratedMessage {
  factory GetTwoFactorStatusRequest() => create();

  GetTwoFactorStatusRequest._();

  factory GetTwoFactorStatusRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTwoFactorStatusRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTwoFactorStatusRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTwoFactorStatusRequest clone() =>
      GetTwoFactorStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTwoFactorStatusRequest copyWith(
          void Function(GetTwoFactorStatusRequest) updates) =>
      super.copyWith((message) => updates(message as GetTwoFactorStatusRequest))
          as GetTwoFactorStatusRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTwoFactorStatusRequest create() => GetTwoFactorStatusRequest._();
  @$core.override
  GetTwoFactorStatusRequest createEmptyInstance() => create();
  static $pb.PbList<GetTwoFactorStatusRequest> createRepeated() =>
      $pb.PbList<GetTwoFactorStatusRequest>();
  @$core.pragma('dart2js:noInline')
  static GetTwoFactorStatusRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetTwoFactorStatusRequest>(create);
  static GetTwoFactorStatusRequest? _defaultInstance;
}

class GetTwoFactorStatusResponse extends $pb.GeneratedMessage {
  factory GetTwoFactorStatusResponse({
    $core.bool? enabled,
    $core.String? method,
    $core.String? methodName,
    $core.String? methodDescription,
    $core.int? backupCodesCount,
    $core.bool? hasBackupCodes,
  }) {
    final result = create();
    if (enabled != null) result.enabled = enabled;
    if (method != null) result.method = method;
    if (methodName != null) result.methodName = methodName;
    if (methodDescription != null) result.methodDescription = methodDescription;
    if (backupCodesCount != null) result.backupCodesCount = backupCodesCount;
    if (hasBackupCodes != null) result.hasBackupCodes = hasBackupCodes;
    return result;
  }

  GetTwoFactorStatusResponse._();

  factory GetTwoFactorStatusResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTwoFactorStatusResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTwoFactorStatusResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'enabled')
    ..aOS(2, _omitFieldNames ? '' : 'method')
    ..aOS(3, _omitFieldNames ? '' : 'methodName')
    ..aOS(4, _omitFieldNames ? '' : 'methodDescription')
    ..a<$core.int>(
        5, _omitFieldNames ? '' : 'backupCodesCount', $pb.PbFieldType.O3)
    ..aOB(6, _omitFieldNames ? '' : 'hasBackupCodes')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTwoFactorStatusResponse clone() =>
      GetTwoFactorStatusResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTwoFactorStatusResponse copyWith(
          void Function(GetTwoFactorStatusResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetTwoFactorStatusResponse))
          as GetTwoFactorStatusResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTwoFactorStatusResponse create() => GetTwoFactorStatusResponse._();
  @$core.override
  GetTwoFactorStatusResponse createEmptyInstance() => create();
  static $pb.PbList<GetTwoFactorStatusResponse> createRepeated() =>
      $pb.PbList<GetTwoFactorStatusResponse>();
  @$core.pragma('dart2js:noInline')
  static GetTwoFactorStatusResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetTwoFactorStatusResponse>(create);
  static GetTwoFactorStatusResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get enabled => $_getBF(0);
  @$pb.TagNumber(1)
  set enabled($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEnabled() => $_has(0);
  @$pb.TagNumber(1)
  void clearEnabled() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get method => $_getSZ(1);
  @$pb.TagNumber(2)
  set method($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMethod() => $_has(1);
  @$pb.TagNumber(2)
  void clearMethod() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get methodName => $_getSZ(2);
  @$pb.TagNumber(3)
  set methodName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMethodName() => $_has(2);
  @$pb.TagNumber(3)
  void clearMethodName() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get methodDescription => $_getSZ(3);
  @$pb.TagNumber(4)
  set methodDescription($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMethodDescription() => $_has(3);
  @$pb.TagNumber(4)
  void clearMethodDescription() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get backupCodesCount => $_getIZ(4);
  @$pb.TagNumber(5)
  set backupCodesCount($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasBackupCodesCount() => $_has(4);
  @$pb.TagNumber(5)
  void clearBackupCodesCount() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.bool get hasBackupCodes => $_getBF(5);
  @$pb.TagNumber(6)
  set hasBackupCodes($core.bool value) => $_setBool(5, value);
  @$pb.TagNumber(6)
  $core.bool hasHasBackupCodes() => $_has(5);
  @$pb.TagNumber(6)
  void clearHasBackupCodes() => $_clearField(6);
}

class RegenerateBackupCodesRequest extends $pb.GeneratedMessage {
  factory RegenerateBackupCodesRequest({
    $core.String? code,
  }) {
    final result = create();
    if (code != null) result.code = code;
    return result;
  }

  RegenerateBackupCodesRequest._();

  factory RegenerateBackupCodesRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RegenerateBackupCodesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RegenerateBackupCodesRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'code')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RegenerateBackupCodesRequest clone() =>
      RegenerateBackupCodesRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RegenerateBackupCodesRequest copyWith(
          void Function(RegenerateBackupCodesRequest) updates) =>
      super.copyWith(
              (message) => updates(message as RegenerateBackupCodesRequest))
          as RegenerateBackupCodesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RegenerateBackupCodesRequest create() =>
      RegenerateBackupCodesRequest._();
  @$core.override
  RegenerateBackupCodesRequest createEmptyInstance() => create();
  static $pb.PbList<RegenerateBackupCodesRequest> createRepeated() =>
      $pb.PbList<RegenerateBackupCodesRequest>();
  @$core.pragma('dart2js:noInline')
  static RegenerateBackupCodesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RegenerateBackupCodesRequest>(create);
  static RegenerateBackupCodesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get code => $_getSZ(0);
  @$pb.TagNumber(1)
  set code($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearCode() => $_clearField(1);
}

class RegenerateBackupCodesResponse extends $pb.GeneratedMessage {
  factory RegenerateBackupCodesResponse({
    $core.bool? success,
    $core.String? message,
    $core.Iterable<$core.String>? backupCodes,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (backupCodes != null) result.backupCodes.addAll(backupCodes);
    return result;
  }

  RegenerateBackupCodesResponse._();

  factory RegenerateBackupCodesResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RegenerateBackupCodesResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RegenerateBackupCodesResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..pPS(3, _omitFieldNames ? '' : 'backupCodes')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RegenerateBackupCodesResponse clone() =>
      RegenerateBackupCodesResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RegenerateBackupCodesResponse copyWith(
          void Function(RegenerateBackupCodesResponse) updates) =>
      super.copyWith(
              (message) => updates(message as RegenerateBackupCodesResponse))
          as RegenerateBackupCodesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RegenerateBackupCodesResponse create() =>
      RegenerateBackupCodesResponse._();
  @$core.override
  RegenerateBackupCodesResponse createEmptyInstance() => create();
  static $pb.PbList<RegenerateBackupCodesResponse> createRepeated() =>
      $pb.PbList<RegenerateBackupCodesResponse>();
  @$core.pragma('dart2js:noInline')
  static RegenerateBackupCodesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RegenerateBackupCodesResponse>(create);
  static RegenerateBackupCodesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);

  @$pb.TagNumber(3)
  $pb.PbList<$core.String> get backupCodes => $_getList(2);
}

class SendTwoFactorCodeRequest extends $pb.GeneratedMessage {
  factory SendTwoFactorCodeRequest() => create();

  SendTwoFactorCodeRequest._();

  factory SendTwoFactorCodeRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SendTwoFactorCodeRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SendTwoFactorCodeRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SendTwoFactorCodeRequest clone() =>
      SendTwoFactorCodeRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SendTwoFactorCodeRequest copyWith(
          void Function(SendTwoFactorCodeRequest) updates) =>
      super.copyWith((message) => updates(message as SendTwoFactorCodeRequest))
          as SendTwoFactorCodeRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SendTwoFactorCodeRequest create() => SendTwoFactorCodeRequest._();
  @$core.override
  SendTwoFactorCodeRequest createEmptyInstance() => create();
  static $pb.PbList<SendTwoFactorCodeRequest> createRepeated() =>
      $pb.PbList<SendTwoFactorCodeRequest>();
  @$core.pragma('dart2js:noInline')
  static SendTwoFactorCodeRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SendTwoFactorCodeRequest>(create);
  static SendTwoFactorCodeRequest? _defaultInstance;
}

class SendTwoFactorCodeResponse extends $pb.GeneratedMessage {
  factory SendTwoFactorCodeResponse({
    $core.bool? success,
    $core.String? message,
    $fixnum.Int64? expiresIn,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (expiresIn != null) result.expiresIn = expiresIn;
    return result;
  }

  SendTwoFactorCodeResponse._();

  factory SendTwoFactorCodeResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SendTwoFactorCodeResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SendTwoFactorCodeResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aInt64(3, _omitFieldNames ? '' : 'expiresIn')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SendTwoFactorCodeResponse clone() =>
      SendTwoFactorCodeResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SendTwoFactorCodeResponse copyWith(
          void Function(SendTwoFactorCodeResponse) updates) =>
      super.copyWith((message) => updates(message as SendTwoFactorCodeResponse))
          as SendTwoFactorCodeResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SendTwoFactorCodeResponse create() => SendTwoFactorCodeResponse._();
  @$core.override
  SendTwoFactorCodeResponse createEmptyInstance() => create();
  static $pb.PbList<SendTwoFactorCodeResponse> createRepeated() =>
      $pb.PbList<SendTwoFactorCodeResponse>();
  @$core.pragma('dart2js:noInline')
  static SendTwoFactorCodeResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SendTwoFactorCodeResponse>(create);
  static SendTwoFactorCodeResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get expiresIn => $_getI64(2);
  @$pb.TagNumber(3)
  set expiresIn($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasExpiresIn() => $_has(2);
  @$pb.TagNumber(3)
  void clearExpiresIn() => $_clearField(3);
}

class GetAvailable2FAMethodsRequest extends $pb.GeneratedMessage {
  factory GetAvailable2FAMethodsRequest() => create();

  GetAvailable2FAMethodsRequest._();

  factory GetAvailable2FAMethodsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetAvailable2FAMethodsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetAvailable2FAMethodsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAvailable2FAMethodsRequest clone() =>
      GetAvailable2FAMethodsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAvailable2FAMethodsRequest copyWith(
          void Function(GetAvailable2FAMethodsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetAvailable2FAMethodsRequest))
          as GetAvailable2FAMethodsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAvailable2FAMethodsRequest create() =>
      GetAvailable2FAMethodsRequest._();
  @$core.override
  GetAvailable2FAMethodsRequest createEmptyInstance() => create();
  static $pb.PbList<GetAvailable2FAMethodsRequest> createRepeated() =>
      $pb.PbList<GetAvailable2FAMethodsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetAvailable2FAMethodsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetAvailable2FAMethodsRequest>(create);
  static GetAvailable2FAMethodsRequest? _defaultInstance;
}

class TwoFactorMethodInfo extends $pb.GeneratedMessage {
  factory TwoFactorMethodInfo({
    $core.String? method,
    $core.String? name,
    $core.String? description,
    $core.String? icon,
    $core.bool? available,
  }) {
    final result = create();
    if (method != null) result.method = method;
    if (name != null) result.name = name;
    if (description != null) result.description = description;
    if (icon != null) result.icon = icon;
    if (available != null) result.available = available;
    return result;
  }

  TwoFactorMethodInfo._();

  factory TwoFactorMethodInfo.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TwoFactorMethodInfo.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TwoFactorMethodInfo',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'method')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..aOS(4, _omitFieldNames ? '' : 'icon')
    ..aOB(5, _omitFieldNames ? '' : 'available')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TwoFactorMethodInfo clone() => TwoFactorMethodInfo()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TwoFactorMethodInfo copyWith(void Function(TwoFactorMethodInfo) updates) =>
      super.copyWith((message) => updates(message as TwoFactorMethodInfo))
          as TwoFactorMethodInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TwoFactorMethodInfo create() => TwoFactorMethodInfo._();
  @$core.override
  TwoFactorMethodInfo createEmptyInstance() => create();
  static $pb.PbList<TwoFactorMethodInfo> createRepeated() =>
      $pb.PbList<TwoFactorMethodInfo>();
  @$core.pragma('dart2js:noInline')
  static TwoFactorMethodInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TwoFactorMethodInfo>(create);
  static TwoFactorMethodInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get method => $_getSZ(0);
  @$pb.TagNumber(1)
  set method($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMethod() => $_has(0);
  @$pb.TagNumber(1)
  void clearMethod() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get icon => $_getSZ(3);
  @$pb.TagNumber(4)
  set icon($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasIcon() => $_has(3);
  @$pb.TagNumber(4)
  void clearIcon() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.bool get available => $_getBF(4);
  @$pb.TagNumber(5)
  set available($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasAvailable() => $_has(4);
  @$pb.TagNumber(5)
  void clearAvailable() => $_clearField(5);
}

class GetAvailable2FAMethodsResponse extends $pb.GeneratedMessage {
  factory GetAvailable2FAMethodsResponse({
    $core.Iterable<TwoFactorMethodInfo>? methods,
  }) {
    final result = create();
    if (methods != null) result.methods.addAll(methods);
    return result;
  }

  GetAvailable2FAMethodsResponse._();

  factory GetAvailable2FAMethodsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetAvailable2FAMethodsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetAvailable2FAMethodsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..pc<TwoFactorMethodInfo>(
        1, _omitFieldNames ? '' : 'methods', $pb.PbFieldType.PM,
        subBuilder: TwoFactorMethodInfo.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAvailable2FAMethodsResponse clone() =>
      GetAvailable2FAMethodsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAvailable2FAMethodsResponse copyWith(
          void Function(GetAvailable2FAMethodsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetAvailable2FAMethodsResponse))
          as GetAvailable2FAMethodsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAvailable2FAMethodsResponse create() =>
      GetAvailable2FAMethodsResponse._();
  @$core.override
  GetAvailable2FAMethodsResponse createEmptyInstance() => create();
  static $pb.PbList<GetAvailable2FAMethodsResponse> createRepeated() =>
      $pb.PbList<GetAvailable2FAMethodsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetAvailable2FAMethodsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetAvailable2FAMethodsResponse>(create);
  static GetAvailable2FAMethodsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<TwoFactorMethodInfo> get methods => $_getList(0);
}

/// ===== Validate Token (for gateway) =====
class ValidateTokenRequest extends $pb.GeneratedMessage {
  factory ValidateTokenRequest({
    $core.String? token,
  }) {
    final result = create();
    if (token != null) result.token = token;
    return result;
  }

  ValidateTokenRequest._();

  factory ValidateTokenRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ValidateTokenRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ValidateTokenRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'token')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ValidateTokenRequest clone() =>
      ValidateTokenRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ValidateTokenRequest copyWith(void Function(ValidateTokenRequest) updates) =>
      super.copyWith((message) => updates(message as ValidateTokenRequest))
          as ValidateTokenRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ValidateTokenRequest create() => ValidateTokenRequest._();
  @$core.override
  ValidateTokenRequest createEmptyInstance() => create();
  static $pb.PbList<ValidateTokenRequest> createRepeated() =>
      $pb.PbList<ValidateTokenRequest>();
  @$core.pragma('dart2js:noInline')
  static ValidateTokenRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ValidateTokenRequest>(create);
  static ValidateTokenRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get token => $_getSZ(0);
  @$pb.TagNumber(1)
  set token($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearToken() => $_clearField(1);
}

class ValidateTokenResponse extends $pb.GeneratedMessage {
  factory ValidateTokenResponse({
    $core.bool? valid,
    $core.String? userId,
    $core.String? email,
    $fixnum.Int64? expiresAt,
  }) {
    final result = create();
    if (valid != null) result.valid = valid;
    if (userId != null) result.userId = userId;
    if (email != null) result.email = email;
    if (expiresAt != null) result.expiresAt = expiresAt;
    return result;
  }

  ValidateTokenResponse._();

  factory ValidateTokenResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ValidateTokenResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ValidateTokenResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'valid')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'email')
    ..aInt64(4, _omitFieldNames ? '' : 'expiresAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ValidateTokenResponse clone() =>
      ValidateTokenResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ValidateTokenResponse copyWith(
          void Function(ValidateTokenResponse) updates) =>
      super.copyWith((message) => updates(message as ValidateTokenResponse))
          as ValidateTokenResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ValidateTokenResponse create() => ValidateTokenResponse._();
  @$core.override
  ValidateTokenResponse createEmptyInstance() => create();
  static $pb.PbList<ValidateTokenResponse> createRepeated() =>
      $pb.PbList<ValidateTokenResponse>();
  @$core.pragma('dart2js:noInline')
  static ValidateTokenResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ValidateTokenResponse>(create);
  static ValidateTokenResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get valid => $_getBF(0);
  @$pb.TagNumber(1)
  set valid($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasValid() => $_has(0);
  @$pb.TagNumber(1)
  void clearValid() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get email => $_getSZ(2);
  @$pb.TagNumber(3)
  set email($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasEmail() => $_has(2);
  @$pb.TagNumber(3)
  void clearEmail() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get expiresAt => $_getI64(3);
  @$pb.TagNumber(4)
  set expiresAt($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasExpiresAt() => $_has(3);
  @$pb.TagNumber(4)
  void clearExpiresAt() => $_clearField(4);
}

/// ===== Passcode Login =====
class LoginWithPasscodeRequest extends $pb.GeneratedMessage {
  factory LoginWithPasscodeRequest({
    $core.String? email,
    $core.String? passcode,
    $core.String? deviceId,
    $core.String? deviceName,
  }) {
    final result = create();
    if (email != null) result.email = email;
    if (passcode != null) result.passcode = passcode;
    if (deviceId != null) result.deviceId = deviceId;
    if (deviceName != null) result.deviceName = deviceName;
    return result;
  }

  LoginWithPasscodeRequest._();

  factory LoginWithPasscodeRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory LoginWithPasscodeRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LoginWithPasscodeRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'email')
    ..aOS(2, _omitFieldNames ? '' : 'passcode')
    ..aOS(3, _omitFieldNames ? '' : 'deviceId')
    ..aOS(4, _omitFieldNames ? '' : 'deviceName')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LoginWithPasscodeRequest clone() =>
      LoginWithPasscodeRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LoginWithPasscodeRequest copyWith(
          void Function(LoginWithPasscodeRequest) updates) =>
      super.copyWith((message) => updates(message as LoginWithPasscodeRequest))
          as LoginWithPasscodeRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LoginWithPasscodeRequest create() => LoginWithPasscodeRequest._();
  @$core.override
  LoginWithPasscodeRequest createEmptyInstance() => create();
  static $pb.PbList<LoginWithPasscodeRequest> createRepeated() =>
      $pb.PbList<LoginWithPasscodeRequest>();
  @$core.pragma('dart2js:noInline')
  static LoginWithPasscodeRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LoginWithPasscodeRequest>(create);
  static LoginWithPasscodeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get email => $_getSZ(0);
  @$pb.TagNumber(1)
  set email($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEmail() => $_has(0);
  @$pb.TagNumber(1)
  void clearEmail() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get passcode => $_getSZ(1);
  @$pb.TagNumber(2)
  set passcode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPasscode() => $_has(1);
  @$pb.TagNumber(2)
  void clearPasscode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get deviceId => $_getSZ(2);
  @$pb.TagNumber(3)
  set deviceId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDeviceId() => $_has(2);
  @$pb.TagNumber(3)
  void clearDeviceId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get deviceName => $_getSZ(3);
  @$pb.TagNumber(4)
  set deviceName($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDeviceName() => $_has(3);
  @$pb.TagNumber(4)
  void clearDeviceName() => $_clearField(4);
}

class RegisterPasscodeRequest extends $pb.GeneratedMessage {
  factory RegisterPasscodeRequest({
    $core.String? passcode,
  }) {
    final result = create();
    if (passcode != null) result.passcode = passcode;
    return result;
  }

  RegisterPasscodeRequest._();

  factory RegisterPasscodeRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RegisterPasscodeRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RegisterPasscodeRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'passcode')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RegisterPasscodeRequest clone() =>
      RegisterPasscodeRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RegisterPasscodeRequest copyWith(
          void Function(RegisterPasscodeRequest) updates) =>
      super.copyWith((message) => updates(message as RegisterPasscodeRequest))
          as RegisterPasscodeRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RegisterPasscodeRequest create() => RegisterPasscodeRequest._();
  @$core.override
  RegisterPasscodeRequest createEmptyInstance() => create();
  static $pb.PbList<RegisterPasscodeRequest> createRepeated() =>
      $pb.PbList<RegisterPasscodeRequest>();
  @$core.pragma('dart2js:noInline')
  static RegisterPasscodeRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RegisterPasscodeRequest>(create);
  static RegisterPasscodeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get passcode => $_getSZ(0);
  @$pb.TagNumber(1)
  set passcode($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPasscode() => $_has(0);
  @$pb.TagNumber(1)
  void clearPasscode() => $_clearField(1);
}

class RegisterPasscodeResponse extends $pb.GeneratedMessage {
  factory RegisterPasscodeResponse({
    $core.bool? success,
    $core.String? msg,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (msg != null) result.msg = msg;
    return result;
  }

  RegisterPasscodeResponse._();

  factory RegisterPasscodeResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RegisterPasscodeResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RegisterPasscodeResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'msg')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RegisterPasscodeResponse clone() =>
      RegisterPasscodeResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RegisterPasscodeResponse copyWith(
          void Function(RegisterPasscodeResponse) updates) =>
      super.copyWith((message) => updates(message as RegisterPasscodeResponse))
          as RegisterPasscodeResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RegisterPasscodeResponse create() => RegisterPasscodeResponse._();
  @$core.override
  RegisterPasscodeResponse createEmptyInstance() => create();
  static $pb.PbList<RegisterPasscodeResponse> createRepeated() =>
      $pb.PbList<RegisterPasscodeResponse>();
  @$core.pragma('dart2js:noInline')
  static RegisterPasscodeResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RegisterPasscodeResponse>(create);
  static RegisterPasscodeResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get msg => $_getSZ(1);
  @$pb.TagNumber(2)
  set msg($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMsg() => $_has(1);
  @$pb.TagNumber(2)
  void clearMsg() => $_clearField(2);
}

class ChangePasscodeRequest extends $pb.GeneratedMessage {
  factory ChangePasscodeRequest({
    $core.String? currentPasscode,
    $core.String? newPasscode,
  }) {
    final result = create();
    if (currentPasscode != null) result.currentPasscode = currentPasscode;
    if (newPasscode != null) result.newPasscode = newPasscode;
    return result;
  }

  ChangePasscodeRequest._();

  factory ChangePasscodeRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ChangePasscodeRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChangePasscodeRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'currentPasscode')
    ..aOS(2, _omitFieldNames ? '' : 'newPasscode')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChangePasscodeRequest clone() =>
      ChangePasscodeRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChangePasscodeRequest copyWith(
          void Function(ChangePasscodeRequest) updates) =>
      super.copyWith((message) => updates(message as ChangePasscodeRequest))
          as ChangePasscodeRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChangePasscodeRequest create() => ChangePasscodeRequest._();
  @$core.override
  ChangePasscodeRequest createEmptyInstance() => create();
  static $pb.PbList<ChangePasscodeRequest> createRepeated() =>
      $pb.PbList<ChangePasscodeRequest>();
  @$core.pragma('dart2js:noInline')
  static ChangePasscodeRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ChangePasscodeRequest>(create);
  static ChangePasscodeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get currentPasscode => $_getSZ(0);
  @$pb.TagNumber(1)
  set currentPasscode($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCurrentPasscode() => $_has(0);
  @$pb.TagNumber(1)
  void clearCurrentPasscode() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get newPasscode => $_getSZ(1);
  @$pb.TagNumber(2)
  set newPasscode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNewPasscode() => $_has(1);
  @$pb.TagNumber(2)
  void clearNewPasscode() => $_clearField(2);
}

class ChangePasscodeResponse extends $pb.GeneratedMessage {
  factory ChangePasscodeResponse({
    $core.bool? success,
    $core.String? msg,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (msg != null) result.msg = msg;
    return result;
  }

  ChangePasscodeResponse._();

  factory ChangePasscodeResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ChangePasscodeResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChangePasscodeResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'msg')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChangePasscodeResponse clone() =>
      ChangePasscodeResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChangePasscodeResponse copyWith(
          void Function(ChangePasscodeResponse) updates) =>
      super.copyWith((message) => updates(message as ChangePasscodeResponse))
          as ChangePasscodeResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChangePasscodeResponse create() => ChangePasscodeResponse._();
  @$core.override
  ChangePasscodeResponse createEmptyInstance() => create();
  static $pb.PbList<ChangePasscodeResponse> createRepeated() =>
      $pb.PbList<ChangePasscodeResponse>();
  @$core.pragma('dart2js:noInline')
  static ChangePasscodeResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ChangePasscodeResponse>(create);
  static ChangePasscodeResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get msg => $_getSZ(1);
  @$pb.TagNumber(2)
  set msg($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMsg() => $_has(1);
  @$pb.TagNumber(2)
  void clearMsg() => $_clearField(2);
}

/// ===== Password Reset =====
class RequestPasswordResetRequest extends $pb.GeneratedMessage {
  factory RequestPasswordResetRequest({
    $core.String? email,
  }) {
    final result = create();
    if (email != null) result.email = email;
    return result;
  }

  RequestPasswordResetRequest._();

  factory RequestPasswordResetRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RequestPasswordResetRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RequestPasswordResetRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'email')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RequestPasswordResetRequest clone() =>
      RequestPasswordResetRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RequestPasswordResetRequest copyWith(
          void Function(RequestPasswordResetRequest) updates) =>
      super.copyWith(
              (message) => updates(message as RequestPasswordResetRequest))
          as RequestPasswordResetRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RequestPasswordResetRequest create() =>
      RequestPasswordResetRequest._();
  @$core.override
  RequestPasswordResetRequest createEmptyInstance() => create();
  static $pb.PbList<RequestPasswordResetRequest> createRepeated() =>
      $pb.PbList<RequestPasswordResetRequest>();
  @$core.pragma('dart2js:noInline')
  static RequestPasswordResetRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RequestPasswordResetRequest>(create);
  static RequestPasswordResetRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get email => $_getSZ(0);
  @$pb.TagNumber(1)
  set email($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEmail() => $_has(0);
  @$pb.TagNumber(1)
  void clearEmail() => $_clearField(1);
}

class RequestPasswordResetResponse extends $pb.GeneratedMessage {
  factory RequestPasswordResetResponse({
    $core.bool? success,
    $core.String? msg,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (msg != null) result.msg = msg;
    return result;
  }

  RequestPasswordResetResponse._();

  factory RequestPasswordResetResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RequestPasswordResetResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RequestPasswordResetResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'msg')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RequestPasswordResetResponse clone() =>
      RequestPasswordResetResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RequestPasswordResetResponse copyWith(
          void Function(RequestPasswordResetResponse) updates) =>
      super.copyWith(
              (message) => updates(message as RequestPasswordResetResponse))
          as RequestPasswordResetResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RequestPasswordResetResponse create() =>
      RequestPasswordResetResponse._();
  @$core.override
  RequestPasswordResetResponse createEmptyInstance() => create();
  static $pb.PbList<RequestPasswordResetResponse> createRepeated() =>
      $pb.PbList<RequestPasswordResetResponse>();
  @$core.pragma('dart2js:noInline')
  static RequestPasswordResetResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RequestPasswordResetResponse>(create);
  static RequestPasswordResetResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get msg => $_getSZ(1);
  @$pb.TagNumber(2)
  set msg($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMsg() => $_has(1);
  @$pb.TagNumber(2)
  void clearMsg() => $_clearField(2);
}

/// ===== Email Verification Request =====
class RequestEmailVerificationRequest extends $pb.GeneratedMessage {
  factory RequestEmailVerificationRequest({
    $core.String? email,
  }) {
    final result = create();
    if (email != null) result.email = email;
    return result;
  }

  RequestEmailVerificationRequest._();

  factory RequestEmailVerificationRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RequestEmailVerificationRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RequestEmailVerificationRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'email')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RequestEmailVerificationRequest clone() =>
      RequestEmailVerificationRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RequestEmailVerificationRequest copyWith(
          void Function(RequestEmailVerificationRequest) updates) =>
      super.copyWith(
              (message) => updates(message as RequestEmailVerificationRequest))
          as RequestEmailVerificationRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RequestEmailVerificationRequest create() =>
      RequestEmailVerificationRequest._();
  @$core.override
  RequestEmailVerificationRequest createEmptyInstance() => create();
  static $pb.PbList<RequestEmailVerificationRequest> createRepeated() =>
      $pb.PbList<RequestEmailVerificationRequest>();
  @$core.pragma('dart2js:noInline')
  static RequestEmailVerificationRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RequestEmailVerificationRequest>(
          create);
  static RequestEmailVerificationRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get email => $_getSZ(0);
  @$pb.TagNumber(1)
  set email($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEmail() => $_has(0);
  @$pb.TagNumber(1)
  void clearEmail() => $_clearField(1);
}

class RequestEmailVerificationResponse extends $pb.GeneratedMessage {
  factory RequestEmailVerificationResponse({
    $core.bool? success,
    $core.String? msg,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (msg != null) result.msg = msg;
    return result;
  }

  RequestEmailVerificationResponse._();

  factory RequestEmailVerificationResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RequestEmailVerificationResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RequestEmailVerificationResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'msg')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RequestEmailVerificationResponse clone() =>
      RequestEmailVerificationResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RequestEmailVerificationResponse copyWith(
          void Function(RequestEmailVerificationResponse) updates) =>
      super.copyWith(
              (message) => updates(message as RequestEmailVerificationResponse))
          as RequestEmailVerificationResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RequestEmailVerificationResponse create() =>
      RequestEmailVerificationResponse._();
  @$core.override
  RequestEmailVerificationResponse createEmptyInstance() => create();
  static $pb.PbList<RequestEmailVerificationResponse> createRepeated() =>
      $pb.PbList<RequestEmailVerificationResponse>();
  @$core.pragma('dart2js:noInline')
  static RequestEmailVerificationResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RequestEmailVerificationResponse>(
          create);
  static RequestEmailVerificationResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get msg => $_getSZ(1);
  @$pb.TagNumber(2)
  set msg($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMsg() => $_has(1);
  @$pb.TagNumber(2)
  void clearMsg() => $_clearField(2);
}

/// ===== Email Availability Check =====
class CheckEmailAvailabilityRequest extends $pb.GeneratedMessage {
  factory CheckEmailAvailabilityRequest({
    $core.String? email,
  }) {
    final result = create();
    if (email != null) result.email = email;
    return result;
  }

  CheckEmailAvailabilityRequest._();

  factory CheckEmailAvailabilityRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CheckEmailAvailabilityRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CheckEmailAvailabilityRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'email')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CheckEmailAvailabilityRequest clone() =>
      CheckEmailAvailabilityRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CheckEmailAvailabilityRequest copyWith(
          void Function(CheckEmailAvailabilityRequest) updates) =>
      super.copyWith(
              (message) => updates(message as CheckEmailAvailabilityRequest))
          as CheckEmailAvailabilityRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CheckEmailAvailabilityRequest create() =>
      CheckEmailAvailabilityRequest._();
  @$core.override
  CheckEmailAvailabilityRequest createEmptyInstance() => create();
  static $pb.PbList<CheckEmailAvailabilityRequest> createRepeated() =>
      $pb.PbList<CheckEmailAvailabilityRequest>();
  @$core.pragma('dart2js:noInline')
  static CheckEmailAvailabilityRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CheckEmailAvailabilityRequest>(create);
  static CheckEmailAvailabilityRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get email => $_getSZ(0);
  @$pb.TagNumber(1)
  set email($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEmail() => $_has(0);
  @$pb.TagNumber(1)
  void clearEmail() => $_clearField(1);
}

class CheckEmailAvailabilityResponse extends $pb.GeneratedMessage {
  factory CheckEmailAvailabilityResponse({
    $core.bool? available,
    $core.String? msg,
  }) {
    final result = create();
    if (available != null) result.available = available;
    if (msg != null) result.msg = msg;
    return result;
  }

  CheckEmailAvailabilityResponse._();

  factory CheckEmailAvailabilityResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CheckEmailAvailabilityResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CheckEmailAvailabilityResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'available')
    ..aOS(2, _omitFieldNames ? '' : 'msg')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CheckEmailAvailabilityResponse clone() =>
      CheckEmailAvailabilityResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CheckEmailAvailabilityResponse copyWith(
          void Function(CheckEmailAvailabilityResponse) updates) =>
      super.copyWith(
              (message) => updates(message as CheckEmailAvailabilityResponse))
          as CheckEmailAvailabilityResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CheckEmailAvailabilityResponse create() =>
      CheckEmailAvailabilityResponse._();
  @$core.override
  CheckEmailAvailabilityResponse createEmptyInstance() => create();
  static $pb.PbList<CheckEmailAvailabilityResponse> createRepeated() =>
      $pb.PbList<CheckEmailAvailabilityResponse>();
  @$core.pragma('dart2js:noInline')
  static CheckEmailAvailabilityResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CheckEmailAvailabilityResponse>(create);
  static CheckEmailAvailabilityResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get available => $_getBF(0);
  @$pb.TagNumber(1)
  set available($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAvailable() => $_has(0);
  @$pb.TagNumber(1)
  void clearAvailable() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get msg => $_getSZ(1);
  @$pb.TagNumber(2)
  set msg($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMsg() => $_has(1);
  @$pb.TagNumber(2)
  void clearMsg() => $_clearField(2);
}

/// ===== Phone Verification =====
class RequestPhoneVerificationRequest extends $pb.GeneratedMessage {
  factory RequestPhoneVerificationRequest({
    $core.String? phone,
    $core.String? countryCode,
  }) {
    final result = create();
    if (phone != null) result.phone = phone;
    if (countryCode != null) result.countryCode = countryCode;
    return result;
  }

  RequestPhoneVerificationRequest._();

  factory RequestPhoneVerificationRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RequestPhoneVerificationRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RequestPhoneVerificationRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'phone')
    ..aOS(2, _omitFieldNames ? '' : 'countryCode')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RequestPhoneVerificationRequest clone() =>
      RequestPhoneVerificationRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RequestPhoneVerificationRequest copyWith(
          void Function(RequestPhoneVerificationRequest) updates) =>
      super.copyWith(
              (message) => updates(message as RequestPhoneVerificationRequest))
          as RequestPhoneVerificationRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RequestPhoneVerificationRequest create() =>
      RequestPhoneVerificationRequest._();
  @$core.override
  RequestPhoneVerificationRequest createEmptyInstance() => create();
  static $pb.PbList<RequestPhoneVerificationRequest> createRepeated() =>
      $pb.PbList<RequestPhoneVerificationRequest>();
  @$core.pragma('dart2js:noInline')
  static RequestPhoneVerificationRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RequestPhoneVerificationRequest>(
          create);
  static RequestPhoneVerificationRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get phone => $_getSZ(0);
  @$pb.TagNumber(1)
  set phone($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPhone() => $_has(0);
  @$pb.TagNumber(1)
  void clearPhone() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get countryCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set countryCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCountryCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearCountryCode() => $_clearField(2);
}

class RequestPhoneVerificationResponse extends $pb.GeneratedMessage {
  factory RequestPhoneVerificationResponse({
    $core.bool? success,
    $core.String? msg,
    $core.String? verificationId,
    $fixnum.Int64? expiresIn,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (msg != null) result.msg = msg;
    if (verificationId != null) result.verificationId = verificationId;
    if (expiresIn != null) result.expiresIn = expiresIn;
    return result;
  }

  RequestPhoneVerificationResponse._();

  factory RequestPhoneVerificationResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RequestPhoneVerificationResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RequestPhoneVerificationResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'msg')
    ..aOS(3, _omitFieldNames ? '' : 'verificationId')
    ..aInt64(4, _omitFieldNames ? '' : 'expiresIn')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RequestPhoneVerificationResponse clone() =>
      RequestPhoneVerificationResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RequestPhoneVerificationResponse copyWith(
          void Function(RequestPhoneVerificationResponse) updates) =>
      super.copyWith(
              (message) => updates(message as RequestPhoneVerificationResponse))
          as RequestPhoneVerificationResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RequestPhoneVerificationResponse create() =>
      RequestPhoneVerificationResponse._();
  @$core.override
  RequestPhoneVerificationResponse createEmptyInstance() => create();
  static $pb.PbList<RequestPhoneVerificationResponse> createRepeated() =>
      $pb.PbList<RequestPhoneVerificationResponse>();
  @$core.pragma('dart2js:noInline')
  static RequestPhoneVerificationResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RequestPhoneVerificationResponse>(
          create);
  static RequestPhoneVerificationResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get msg => $_getSZ(1);
  @$pb.TagNumber(2)
  set msg($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMsg() => $_has(1);
  @$pb.TagNumber(2)
  void clearMsg() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get verificationId => $_getSZ(2);
  @$pb.TagNumber(3)
  set verificationId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasVerificationId() => $_has(2);
  @$pb.TagNumber(3)
  void clearVerificationId() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get expiresIn => $_getI64(3);
  @$pb.TagNumber(4)
  set expiresIn($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasExpiresIn() => $_has(3);
  @$pb.TagNumber(4)
  void clearExpiresIn() => $_clearField(4);
}

class VerifyPhoneNumberRequest extends $pb.GeneratedMessage {
  factory VerifyPhoneNumberRequest({
    $core.String? phone,
    $core.String? countryCode,
    $core.String? code,
    $core.String? verificationId,
  }) {
    final result = create();
    if (phone != null) result.phone = phone;
    if (countryCode != null) result.countryCode = countryCode;
    if (code != null) result.code = code;
    if (verificationId != null) result.verificationId = verificationId;
    return result;
  }

  VerifyPhoneNumberRequest._();

  factory VerifyPhoneNumberRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VerifyPhoneNumberRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VerifyPhoneNumberRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'phone')
    ..aOS(2, _omitFieldNames ? '' : 'countryCode')
    ..aOS(3, _omitFieldNames ? '' : 'code')
    ..aOS(4, _omitFieldNames ? '' : 'verificationId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyPhoneNumberRequest clone() =>
      VerifyPhoneNumberRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyPhoneNumberRequest copyWith(
          void Function(VerifyPhoneNumberRequest) updates) =>
      super.copyWith((message) => updates(message as VerifyPhoneNumberRequest))
          as VerifyPhoneNumberRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VerifyPhoneNumberRequest create() => VerifyPhoneNumberRequest._();
  @$core.override
  VerifyPhoneNumberRequest createEmptyInstance() => create();
  static $pb.PbList<VerifyPhoneNumberRequest> createRepeated() =>
      $pb.PbList<VerifyPhoneNumberRequest>();
  @$core.pragma('dart2js:noInline')
  static VerifyPhoneNumberRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VerifyPhoneNumberRequest>(create);
  static VerifyPhoneNumberRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get phone => $_getSZ(0);
  @$pb.TagNumber(1)
  set phone($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPhone() => $_has(0);
  @$pb.TagNumber(1)
  void clearPhone() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get countryCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set countryCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCountryCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearCountryCode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get code => $_getSZ(2);
  @$pb.TagNumber(3)
  set code($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCode() => $_has(2);
  @$pb.TagNumber(3)
  void clearCode() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get verificationId => $_getSZ(3);
  @$pb.TagNumber(4)
  set verificationId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasVerificationId() => $_has(3);
  @$pb.TagNumber(4)
  void clearVerificationId() => $_clearField(4);
}

class VerifyPhoneNumberResponse extends $pb.GeneratedMessage {
  factory VerifyPhoneNumberResponse({
    $core.bool? success,
    $core.String? msg,
    $core.bool? isVerified,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (msg != null) result.msg = msg;
    if (isVerified != null) result.isVerified = isVerified;
    return result;
  }

  VerifyPhoneNumberResponse._();

  factory VerifyPhoneNumberResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VerifyPhoneNumberResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VerifyPhoneNumberResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'msg')
    ..aOB(3, _omitFieldNames ? '' : 'isVerified')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyPhoneNumberResponse clone() =>
      VerifyPhoneNumberResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyPhoneNumberResponse copyWith(
          void Function(VerifyPhoneNumberResponse) updates) =>
      super.copyWith((message) => updates(message as VerifyPhoneNumberResponse))
          as VerifyPhoneNumberResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VerifyPhoneNumberResponse create() => VerifyPhoneNumberResponse._();
  @$core.override
  VerifyPhoneNumberResponse createEmptyInstance() => create();
  static $pb.PbList<VerifyPhoneNumberResponse> createRepeated() =>
      $pb.PbList<VerifyPhoneNumberResponse>();
  @$core.pragma('dart2js:noInline')
  static VerifyPhoneNumberResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VerifyPhoneNumberResponse>(create);
  static VerifyPhoneNumberResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get msg => $_getSZ(1);
  @$pb.TagNumber(2)
  set msg($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMsg() => $_has(1);
  @$pb.TagNumber(2)
  void clearMsg() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get isVerified => $_getBF(2);
  @$pb.TagNumber(3)
  set isVerified($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasIsVerified() => $_has(2);
  @$pb.TagNumber(3)
  void clearIsVerified() => $_clearField(3);
}

/// ===== User Model =====
class User extends $pb.GeneratedMessage {
  factory User({
    $core.String? id,
    $core.String? email,
    $core.String? firstName,
    $core.String? lastName,
    $core.String? phone,
    $core.String? countryCode,
    $core.bool? emailVerified,
    $core.bool? phoneVerified,
    $core.bool? twoFactorEnabled,
    $core.String? twoFactorMethod,
    $core.String? profilePicture,
    $core.String? createdAt,
    $core.String? updatedAt,
    $core.String? signupStatus,
    $core.String? currentSignupStep,
    $core.String? username,
    $core.bool? identityVerified,
    $core.String? identityType,
    $core.String? identityVerifiedAt,
    $core.String? dateOfBirth,
    $core.int? kycTier,
    $core.String? kycStatus,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (email != null) result.email = email;
    if (firstName != null) result.firstName = firstName;
    if (lastName != null) result.lastName = lastName;
    if (phone != null) result.phone = phone;
    if (countryCode != null) result.countryCode = countryCode;
    if (emailVerified != null) result.emailVerified = emailVerified;
    if (phoneVerified != null) result.phoneVerified = phoneVerified;
    if (twoFactorEnabled != null) result.twoFactorEnabled = twoFactorEnabled;
    if (twoFactorMethod != null) result.twoFactorMethod = twoFactorMethod;
    if (profilePicture != null) result.profilePicture = profilePicture;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    if (signupStatus != null) result.signupStatus = signupStatus;
    if (currentSignupStep != null) result.currentSignupStep = currentSignupStep;
    if (username != null) result.username = username;
    if (identityVerified != null) result.identityVerified = identityVerified;
    if (identityType != null) result.identityType = identityType;
    if (identityVerifiedAt != null)
      result.identityVerifiedAt = identityVerifiedAt;
    if (dateOfBirth != null) result.dateOfBirth = dateOfBirth;
    if (kycTier != null) result.kycTier = kycTier;
    if (kycStatus != null) result.kycStatus = kycStatus;
    return result;
  }

  User._();

  factory User.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory User.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'User',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'email')
    ..aOS(3, _omitFieldNames ? '' : 'firstName')
    ..aOS(4, _omitFieldNames ? '' : 'lastName')
    ..aOS(5, _omitFieldNames ? '' : 'phone')
    ..aOS(6, _omitFieldNames ? '' : 'countryCode')
    ..aOB(7, _omitFieldNames ? '' : 'emailVerified')
    ..aOB(8, _omitFieldNames ? '' : 'phoneVerified')
    ..aOB(9, _omitFieldNames ? '' : 'twoFactorEnabled')
    ..aOS(10, _omitFieldNames ? '' : 'twoFactorMethod')
    ..aOS(11, _omitFieldNames ? '' : 'profilePicture')
    ..aOS(12, _omitFieldNames ? '' : 'createdAt')
    ..aOS(13, _omitFieldNames ? '' : 'updatedAt')
    ..aOS(14, _omitFieldNames ? '' : 'signupStatus')
    ..aOS(15, _omitFieldNames ? '' : 'currentSignupStep')
    ..aOS(16, _omitFieldNames ? '' : 'username')
    ..aOB(17, _omitFieldNames ? '' : 'identityVerified')
    ..aOS(18, _omitFieldNames ? '' : 'identityType')
    ..aOS(19, _omitFieldNames ? '' : 'identityVerifiedAt')
    ..aOS(20, _omitFieldNames ? '' : 'dateOfBirth')
    ..a<$core.int>(21, _omitFieldNames ? '' : 'kycTier', $pb.PbFieldType.O3)
    ..aOS(22, _omitFieldNames ? '' : 'kycStatus')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  User clone() => User()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  User copyWith(void Function(User) updates) =>
      super.copyWith((message) => updates(message as User)) as User;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static User create() => User._();
  @$core.override
  User createEmptyInstance() => create();
  static $pb.PbList<User> createRepeated() => $pb.PbList<User>();
  @$core.pragma('dart2js:noInline')
  static User getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<User>(create);
  static User? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get email => $_getSZ(1);
  @$pb.TagNumber(2)
  set email($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasEmail() => $_has(1);
  @$pb.TagNumber(2)
  void clearEmail() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get firstName => $_getSZ(2);
  @$pb.TagNumber(3)
  set firstName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasFirstName() => $_has(2);
  @$pb.TagNumber(3)
  void clearFirstName() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get lastName => $_getSZ(3);
  @$pb.TagNumber(4)
  set lastName($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasLastName() => $_has(3);
  @$pb.TagNumber(4)
  void clearLastName() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get phone => $_getSZ(4);
  @$pb.TagNumber(5)
  set phone($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasPhone() => $_has(4);
  @$pb.TagNumber(5)
  void clearPhone() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get countryCode => $_getSZ(5);
  @$pb.TagNumber(6)
  set countryCode($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasCountryCode() => $_has(5);
  @$pb.TagNumber(6)
  void clearCountryCode() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.bool get emailVerified => $_getBF(6);
  @$pb.TagNumber(7)
  set emailVerified($core.bool value) => $_setBool(6, value);
  @$pb.TagNumber(7)
  $core.bool hasEmailVerified() => $_has(6);
  @$pb.TagNumber(7)
  void clearEmailVerified() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.bool get phoneVerified => $_getBF(7);
  @$pb.TagNumber(8)
  set phoneVerified($core.bool value) => $_setBool(7, value);
  @$pb.TagNumber(8)
  $core.bool hasPhoneVerified() => $_has(7);
  @$pb.TagNumber(8)
  void clearPhoneVerified() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.bool get twoFactorEnabled => $_getBF(8);
  @$pb.TagNumber(9)
  set twoFactorEnabled($core.bool value) => $_setBool(8, value);
  @$pb.TagNumber(9)
  $core.bool hasTwoFactorEnabled() => $_has(8);
  @$pb.TagNumber(9)
  void clearTwoFactorEnabled() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get twoFactorMethod => $_getSZ(9);
  @$pb.TagNumber(10)
  set twoFactorMethod($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasTwoFactorMethod() => $_has(9);
  @$pb.TagNumber(10)
  void clearTwoFactorMethod() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get profilePicture => $_getSZ(10);
  @$pb.TagNumber(11)
  set profilePicture($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasProfilePicture() => $_has(10);
  @$pb.TagNumber(11)
  void clearProfilePicture() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get createdAt => $_getSZ(11);
  @$pb.TagNumber(12)
  set createdAt($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasCreatedAt() => $_has(11);
  @$pb.TagNumber(12)
  void clearCreatedAt() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get updatedAt => $_getSZ(12);
  @$pb.TagNumber(13)
  set updatedAt($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasUpdatedAt() => $_has(12);
  @$pb.TagNumber(13)
  void clearUpdatedAt() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.String get signupStatus => $_getSZ(13);
  @$pb.TagNumber(14)
  set signupStatus($core.String value) => $_setString(13, value);
  @$pb.TagNumber(14)
  $core.bool hasSignupStatus() => $_has(13);
  @$pb.TagNumber(14)
  void clearSignupStatus() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.String get currentSignupStep => $_getSZ(14);
  @$pb.TagNumber(15)
  set currentSignupStep($core.String value) => $_setString(14, value);
  @$pb.TagNumber(15)
  $core.bool hasCurrentSignupStep() => $_has(14);
  @$pb.TagNumber(15)
  void clearCurrentSignupStep() => $_clearField(15);

  @$pb.TagNumber(16)
  $core.String get username => $_getSZ(15);
  @$pb.TagNumber(16)
  set username($core.String value) => $_setString(15, value);
  @$pb.TagNumber(16)
  $core.bool hasUsername() => $_has(15);
  @$pb.TagNumber(16)
  void clearUsername() => $_clearField(16);

  @$pb.TagNumber(17)
  $core.bool get identityVerified => $_getBF(16);
  @$pb.TagNumber(17)
  set identityVerified($core.bool value) => $_setBool(16, value);
  @$pb.TagNumber(17)
  $core.bool hasIdentityVerified() => $_has(16);
  @$pb.TagNumber(17)
  void clearIdentityVerified() => $_clearField(17);

  @$pb.TagNumber(18)
  $core.String get identityType => $_getSZ(17);
  @$pb.TagNumber(18)
  set identityType($core.String value) => $_setString(17, value);
  @$pb.TagNumber(18)
  $core.bool hasIdentityType() => $_has(17);
  @$pb.TagNumber(18)
  void clearIdentityType() => $_clearField(18);

  @$pb.TagNumber(19)
  $core.String get identityVerifiedAt => $_getSZ(18);
  @$pb.TagNumber(19)
  set identityVerifiedAt($core.String value) => $_setString(18, value);
  @$pb.TagNumber(19)
  $core.bool hasIdentityVerifiedAt() => $_has(18);
  @$pb.TagNumber(19)
  void clearIdentityVerifiedAt() => $_clearField(19);

  @$pb.TagNumber(20)
  $core.String get dateOfBirth => $_getSZ(19);
  @$pb.TagNumber(20)
  set dateOfBirth($core.String value) => $_setString(19, value);
  @$pb.TagNumber(20)
  $core.bool hasDateOfBirth() => $_has(19);
  @$pb.TagNumber(20)
  void clearDateOfBirth() => $_clearField(20);

  @$pb.TagNumber(21)
  $core.int get kycTier => $_getIZ(20);
  @$pb.TagNumber(21)
  set kycTier($core.int value) => $_setSignedInt32(20, value);
  @$pb.TagNumber(21)
  $core.bool hasKycTier() => $_has(20);
  @$pb.TagNumber(21)
  void clearKycTier() => $_clearField(21);

  @$pb.TagNumber(22)
  $core.String get kycStatus => $_getSZ(21);
  @$pb.TagNumber(22)
  set kycStatus($core.String value) => $_setString(21, value);
  @$pb.TagNumber(22)
  $core.bool hasKycStatus() => $_has(21);
  @$pb.TagNumber(22)
  void clearKycStatus() => $_clearField(22);
}

/// Individual signup step progress
class SignupStepProgress extends $pb.GeneratedMessage {
  factory SignupStepProgress({
    $core.String? stepName,
    StepStatus? status,
    $core.String? stepData,
    $core.String? completedAt,
    $core.String? createdAt,
    $core.String? updatedAt,
  }) {
    final result = create();
    if (stepName != null) result.stepName = stepName;
    if (status != null) result.status = status;
    if (stepData != null) result.stepData = stepData;
    if (completedAt != null) result.completedAt = completedAt;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    return result;
  }

  SignupStepProgress._();

  factory SignupStepProgress.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SignupStepProgress.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SignupStepProgress',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'stepName')
    ..e<StepStatus>(2, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: StepStatus.STEP_STATUS_UNSPECIFIED,
        valueOf: StepStatus.valueOf,
        enumValues: StepStatus.values)
    ..aOS(3, _omitFieldNames ? '' : 'stepData')
    ..aOS(4, _omitFieldNames ? '' : 'completedAt')
    ..aOS(5, _omitFieldNames ? '' : 'createdAt')
    ..aOS(6, _omitFieldNames ? '' : 'updatedAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SignupStepProgress clone() => SignupStepProgress()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SignupStepProgress copyWith(void Function(SignupStepProgress) updates) =>
      super.copyWith((message) => updates(message as SignupStepProgress))
          as SignupStepProgress;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SignupStepProgress create() => SignupStepProgress._();
  @$core.override
  SignupStepProgress createEmptyInstance() => create();
  static $pb.PbList<SignupStepProgress> createRepeated() =>
      $pb.PbList<SignupStepProgress>();
  @$core.pragma('dart2js:noInline')
  static SignupStepProgress getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SignupStepProgress>(create);
  static SignupStepProgress? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get stepName => $_getSZ(0);
  @$pb.TagNumber(1)
  set stepName($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasStepName() => $_has(0);
  @$pb.TagNumber(1)
  void clearStepName() => $_clearField(1);

  @$pb.TagNumber(2)
  StepStatus get status => $_getN(1);
  @$pb.TagNumber(2)
  set status(StepStatus value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get stepData => $_getSZ(2);
  @$pb.TagNumber(3)
  set stepData($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasStepData() => $_has(2);
  @$pb.TagNumber(3)
  void clearStepData() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get completedAt => $_getSZ(3);
  @$pb.TagNumber(4)
  set completedAt($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCompletedAt() => $_has(3);
  @$pb.TagNumber(4)
  void clearCompletedAt() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get createdAt => $_getSZ(4);
  @$pb.TagNumber(5)
  set createdAt($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCreatedAt() => $_has(4);
  @$pb.TagNumber(5)
  void clearCreatedAt() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get updatedAt => $_getSZ(5);
  @$pb.TagNumber(6)
  set updatedAt($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasUpdatedAt() => $_has(5);
  @$pb.TagNumber(6)
  void clearUpdatedAt() => $_clearField(6);
}

/// Overall signup progress
class SignupProgress extends $pb.GeneratedMessage {
  factory SignupProgress({
    $core.String? userId,
    SignupStatus? status,
    $core.String? currentStep,
    $core.Iterable<SignupStepProgress>? steps,
    $core.String? signupCompletedAt,
    $core.String? createdAt,
    $core.String? updatedAt,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (status != null) result.status = status;
    if (currentStep != null) result.currentStep = currentStep;
    if (steps != null) result.steps.addAll(steps);
    if (signupCompletedAt != null) result.signupCompletedAt = signupCompletedAt;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    return result;
  }

  SignupProgress._();

  factory SignupProgress.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SignupProgress.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SignupProgress',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..e<SignupStatus>(2, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: SignupStatus.SIGNUP_STATUS_UNSPECIFIED,
        valueOf: SignupStatus.valueOf,
        enumValues: SignupStatus.values)
    ..aOS(3, _omitFieldNames ? '' : 'currentStep')
    ..pc<SignupStepProgress>(
        4, _omitFieldNames ? '' : 'steps', $pb.PbFieldType.PM,
        subBuilder: SignupStepProgress.create)
    ..aOS(5, _omitFieldNames ? '' : 'signupCompletedAt')
    ..aOS(6, _omitFieldNames ? '' : 'createdAt')
    ..aOS(7, _omitFieldNames ? '' : 'updatedAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SignupProgress clone() => SignupProgress()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SignupProgress copyWith(void Function(SignupProgress) updates) =>
      super.copyWith((message) => updates(message as SignupProgress))
          as SignupProgress;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SignupProgress create() => SignupProgress._();
  @$core.override
  SignupProgress createEmptyInstance() => create();
  static $pb.PbList<SignupProgress> createRepeated() =>
      $pb.PbList<SignupProgress>();
  @$core.pragma('dart2js:noInline')
  static SignupProgress getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SignupProgress>(create);
  static SignupProgress? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  SignupStatus get status => $_getN(1);
  @$pb.TagNumber(2)
  set status(SignupStatus value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get currentStep => $_getSZ(2);
  @$pb.TagNumber(3)
  set currentStep($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCurrentStep() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrentStep() => $_clearField(3);

  @$pb.TagNumber(4)
  $pb.PbList<SignupStepProgress> get steps => $_getList(3);

  @$pb.TagNumber(5)
  $core.String get signupCompletedAt => $_getSZ(4);
  @$pb.TagNumber(5)
  set signupCompletedAt($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasSignupCompletedAt() => $_has(4);
  @$pb.TagNumber(5)
  void clearSignupCompletedAt() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get createdAt => $_getSZ(5);
  @$pb.TagNumber(6)
  set createdAt($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasCreatedAt() => $_has(5);
  @$pb.TagNumber(6)
  void clearCreatedAt() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get updatedAt => $_getSZ(6);
  @$pb.TagNumber(7)
  set updatedAt($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasUpdatedAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearUpdatedAt() => $_clearField(7);
}

/// Get signup progress request
class GetSignupProgressRequest extends $pb.GeneratedMessage {
  factory GetSignupProgressRequest() => create();

  GetSignupProgressRequest._();

  factory GetSignupProgressRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetSignupProgressRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetSignupProgressRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSignupProgressRequest clone() =>
      GetSignupProgressRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSignupProgressRequest copyWith(
          void Function(GetSignupProgressRequest) updates) =>
      super.copyWith((message) => updates(message as GetSignupProgressRequest))
          as GetSignupProgressRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSignupProgressRequest create() => GetSignupProgressRequest._();
  @$core.override
  GetSignupProgressRequest createEmptyInstance() => create();
  static $pb.PbList<GetSignupProgressRequest> createRepeated() =>
      $pb.PbList<GetSignupProgressRequest>();
  @$core.pragma('dart2js:noInline')
  static GetSignupProgressRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetSignupProgressRequest>(create);
  static GetSignupProgressRequest? _defaultInstance;
}

/// Get signup progress response
class GetSignupProgressResponse extends $pb.GeneratedMessage {
  factory GetSignupProgressResponse({
    $core.bool? success,
    $core.String? msg,
    SignupProgress? progress,
    $core.String? nextStep,
    $core.bool? isComplete,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (msg != null) result.msg = msg;
    if (progress != null) result.progress = progress;
    if (nextStep != null) result.nextStep = nextStep;
    if (isComplete != null) result.isComplete = isComplete;
    return result;
  }

  GetSignupProgressResponse._();

  factory GetSignupProgressResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetSignupProgressResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetSignupProgressResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'msg')
    ..aOM<SignupProgress>(3, _omitFieldNames ? '' : 'progress',
        subBuilder: SignupProgress.create)
    ..aOS(4, _omitFieldNames ? '' : 'nextStep')
    ..aOB(5, _omitFieldNames ? '' : 'isComplete')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSignupProgressResponse clone() =>
      GetSignupProgressResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSignupProgressResponse copyWith(
          void Function(GetSignupProgressResponse) updates) =>
      super.copyWith((message) => updates(message as GetSignupProgressResponse))
          as GetSignupProgressResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSignupProgressResponse create() => GetSignupProgressResponse._();
  @$core.override
  GetSignupProgressResponse createEmptyInstance() => create();
  static $pb.PbList<GetSignupProgressResponse> createRepeated() =>
      $pb.PbList<GetSignupProgressResponse>();
  @$core.pragma('dart2js:noInline')
  static GetSignupProgressResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetSignupProgressResponse>(create);
  static GetSignupProgressResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get msg => $_getSZ(1);
  @$pb.TagNumber(2)
  set msg($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMsg() => $_has(1);
  @$pb.TagNumber(2)
  void clearMsg() => $_clearField(2);

  @$pb.TagNumber(3)
  SignupProgress get progress => $_getN(2);
  @$pb.TagNumber(3)
  set progress(SignupProgress value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasProgress() => $_has(2);
  @$pb.TagNumber(3)
  void clearProgress() => $_clearField(3);
  @$pb.TagNumber(3)
  SignupProgress ensureProgress() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.String get nextStep => $_getSZ(3);
  @$pb.TagNumber(4)
  set nextStep($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasNextStep() => $_has(3);
  @$pb.TagNumber(4)
  void clearNextStep() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.bool get isComplete => $_getBF(4);
  @$pb.TagNumber(5)
  set isComplete($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasIsComplete() => $_has(4);
  @$pb.TagNumber(5)
  void clearIsComplete() => $_clearField(5);
}

/// Update signup step request
class UpdateSignupStepRequest extends $pb.GeneratedMessage {
  factory UpdateSignupStepRequest({
    $core.String? stepName,
    StepStatus? status,
    $core.String? stepData,
  }) {
    final result = create();
    if (stepName != null) result.stepName = stepName;
    if (status != null) result.status = status;
    if (stepData != null) result.stepData = stepData;
    return result;
  }

  UpdateSignupStepRequest._();

  factory UpdateSignupStepRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateSignupStepRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateSignupStepRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'stepName')
    ..e<StepStatus>(2, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: StepStatus.STEP_STATUS_UNSPECIFIED,
        valueOf: StepStatus.valueOf,
        enumValues: StepStatus.values)
    ..aOS(3, _omitFieldNames ? '' : 'stepData')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateSignupStepRequest clone() =>
      UpdateSignupStepRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateSignupStepRequest copyWith(
          void Function(UpdateSignupStepRequest) updates) =>
      super.copyWith((message) => updates(message as UpdateSignupStepRequest))
          as UpdateSignupStepRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateSignupStepRequest create() => UpdateSignupStepRequest._();
  @$core.override
  UpdateSignupStepRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateSignupStepRequest> createRepeated() =>
      $pb.PbList<UpdateSignupStepRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateSignupStepRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateSignupStepRequest>(create);
  static UpdateSignupStepRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get stepName => $_getSZ(0);
  @$pb.TagNumber(1)
  set stepName($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasStepName() => $_has(0);
  @$pb.TagNumber(1)
  void clearStepName() => $_clearField(1);

  @$pb.TagNumber(2)
  StepStatus get status => $_getN(1);
  @$pb.TagNumber(2)
  set status(StepStatus value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get stepData => $_getSZ(2);
  @$pb.TagNumber(3)
  set stepData($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasStepData() => $_has(2);
  @$pb.TagNumber(3)
  void clearStepData() => $_clearField(3);
}

/// Update signup step response
class UpdateSignupStepResponse extends $pb.GeneratedMessage {
  factory UpdateSignupStepResponse({
    $core.bool? success,
    $core.String? msg,
    SignupProgress? progress,
    $core.String? nextStep,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (msg != null) result.msg = msg;
    if (progress != null) result.progress = progress;
    if (nextStep != null) result.nextStep = nextStep;
    return result;
  }

  UpdateSignupStepResponse._();

  factory UpdateSignupStepResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateSignupStepResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateSignupStepResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'msg')
    ..aOM<SignupProgress>(3, _omitFieldNames ? '' : 'progress',
        subBuilder: SignupProgress.create)
    ..aOS(4, _omitFieldNames ? '' : 'nextStep')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateSignupStepResponse clone() =>
      UpdateSignupStepResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateSignupStepResponse copyWith(
          void Function(UpdateSignupStepResponse) updates) =>
      super.copyWith((message) => updates(message as UpdateSignupStepResponse))
          as UpdateSignupStepResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateSignupStepResponse create() => UpdateSignupStepResponse._();
  @$core.override
  UpdateSignupStepResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateSignupStepResponse> createRepeated() =>
      $pb.PbList<UpdateSignupStepResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateSignupStepResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateSignupStepResponse>(create);
  static UpdateSignupStepResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get msg => $_getSZ(1);
  @$pb.TagNumber(2)
  set msg($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMsg() => $_has(1);
  @$pb.TagNumber(2)
  void clearMsg() => $_clearField(2);

  @$pb.TagNumber(3)
  SignupProgress get progress => $_getN(2);
  @$pb.TagNumber(3)
  set progress(SignupProgress value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasProgress() => $_has(2);
  @$pb.TagNumber(3)
  void clearProgress() => $_clearField(3);
  @$pb.TagNumber(3)
  SignupProgress ensureProgress() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.String get nextStep => $_getSZ(3);
  @$pb.TagNumber(4)
  set nextStep($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasNextStep() => $_has(3);
  @$pb.TagNumber(4)
  void clearNextStep() => $_clearField(4);
}

/// Complete signup request
class CompleteSignupRequest extends $pb.GeneratedMessage {
  factory CompleteSignupRequest() => create();

  CompleteSignupRequest._();

  factory CompleteSignupRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CompleteSignupRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CompleteSignupRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CompleteSignupRequest clone() =>
      CompleteSignupRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CompleteSignupRequest copyWith(
          void Function(CompleteSignupRequest) updates) =>
      super.copyWith((message) => updates(message as CompleteSignupRequest))
          as CompleteSignupRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CompleteSignupRequest create() => CompleteSignupRequest._();
  @$core.override
  CompleteSignupRequest createEmptyInstance() => create();
  static $pb.PbList<CompleteSignupRequest> createRepeated() =>
      $pb.PbList<CompleteSignupRequest>();
  @$core.pragma('dart2js:noInline')
  static CompleteSignupRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CompleteSignupRequest>(create);
  static CompleteSignupRequest? _defaultInstance;
}

/// Complete signup response
class CompleteSignupResponse extends $pb.GeneratedMessage {
  factory CompleteSignupResponse({
    $core.bool? success,
    $core.String? msg,
    SignupProgress? progress,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (msg != null) result.msg = msg;
    if (progress != null) result.progress = progress;
    return result;
  }

  CompleteSignupResponse._();

  factory CompleteSignupResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CompleteSignupResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CompleteSignupResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'msg')
    ..aOM<SignupProgress>(3, _omitFieldNames ? '' : 'progress',
        subBuilder: SignupProgress.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CompleteSignupResponse clone() =>
      CompleteSignupResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CompleteSignupResponse copyWith(
          void Function(CompleteSignupResponse) updates) =>
      super.copyWith((message) => updates(message as CompleteSignupResponse))
          as CompleteSignupResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CompleteSignupResponse create() => CompleteSignupResponse._();
  @$core.override
  CompleteSignupResponse createEmptyInstance() => create();
  static $pb.PbList<CompleteSignupResponse> createRepeated() =>
      $pb.PbList<CompleteSignupResponse>();
  @$core.pragma('dart2js:noInline')
  static CompleteSignupResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CompleteSignupResponse>(create);
  static CompleteSignupResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get msg => $_getSZ(1);
  @$pb.TagNumber(2)
  set msg($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMsg() => $_has(1);
  @$pb.TagNumber(2)
  void clearMsg() => $_clearField(2);

  @$pb.TagNumber(3)
  SignupProgress get progress => $_getN(2);
  @$pb.TagNumber(3)
  set progress(SignupProgress value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasProgress() => $_has(2);
  @$pb.TagNumber(3)
  void clearProgress() => $_clearField(3);
  @$pb.TagNumber(3)
  SignupProgress ensureProgress() => $_ensure(2);
}

/// Verify identity request
class VerifyIdentityRequest extends $pb.GeneratedMessage {
  factory VerifyIdentityRequest({
    IdentityType? identityType,
    $core.String? identityNumber,
    $core.String? dateOfBirth,
    $core.String? countryCode,
    $core.String? firstName,
    $core.String? lastName,
    $core.String? phoneNumber,
  }) {
    final result = create();
    if (identityType != null) result.identityType = identityType;
    if (identityNumber != null) result.identityNumber = identityNumber;
    if (dateOfBirth != null) result.dateOfBirth = dateOfBirth;
    if (countryCode != null) result.countryCode = countryCode;
    if (firstName != null) result.firstName = firstName;
    if (lastName != null) result.lastName = lastName;
    if (phoneNumber != null) result.phoneNumber = phoneNumber;
    return result;
  }

  VerifyIdentityRequest._();

  factory VerifyIdentityRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VerifyIdentityRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VerifyIdentityRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..e<IdentityType>(
        1, _omitFieldNames ? '' : 'identityType', $pb.PbFieldType.OE,
        defaultOrMaker: IdentityType.IDENTITY_TYPE_UNSPECIFIED,
        valueOf: IdentityType.valueOf,
        enumValues: IdentityType.values)
    ..aOS(2, _omitFieldNames ? '' : 'identityNumber')
    ..aOS(3, _omitFieldNames ? '' : 'dateOfBirth')
    ..aOS(4, _omitFieldNames ? '' : 'countryCode')
    ..aOS(5, _omitFieldNames ? '' : 'firstName')
    ..aOS(6, _omitFieldNames ? '' : 'lastName')
    ..aOS(7, _omitFieldNames ? '' : 'phoneNumber')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyIdentityRequest clone() =>
      VerifyIdentityRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyIdentityRequest copyWith(
          void Function(VerifyIdentityRequest) updates) =>
      super.copyWith((message) => updates(message as VerifyIdentityRequest))
          as VerifyIdentityRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VerifyIdentityRequest create() => VerifyIdentityRequest._();
  @$core.override
  VerifyIdentityRequest createEmptyInstance() => create();
  static $pb.PbList<VerifyIdentityRequest> createRepeated() =>
      $pb.PbList<VerifyIdentityRequest>();
  @$core.pragma('dart2js:noInline')
  static VerifyIdentityRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VerifyIdentityRequest>(create);
  static VerifyIdentityRequest? _defaultInstance;

  @$pb.TagNumber(1)
  IdentityType get identityType => $_getN(0);
  @$pb.TagNumber(1)
  set identityType(IdentityType value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasIdentityType() => $_has(0);
  @$pb.TagNumber(1)
  void clearIdentityType() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get identityNumber => $_getSZ(1);
  @$pb.TagNumber(2)
  set identityNumber($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasIdentityNumber() => $_has(1);
  @$pb.TagNumber(2)
  void clearIdentityNumber() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get dateOfBirth => $_getSZ(2);
  @$pb.TagNumber(3)
  set dateOfBirth($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDateOfBirth() => $_has(2);
  @$pb.TagNumber(3)
  void clearDateOfBirth() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get countryCode => $_getSZ(3);
  @$pb.TagNumber(4)
  set countryCode($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCountryCode() => $_has(3);
  @$pb.TagNumber(4)
  void clearCountryCode() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get firstName => $_getSZ(4);
  @$pb.TagNumber(5)
  set firstName($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasFirstName() => $_has(4);
  @$pb.TagNumber(5)
  void clearFirstName() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get lastName => $_getSZ(5);
  @$pb.TagNumber(6)
  set lastName($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasLastName() => $_has(5);
  @$pb.TagNumber(6)
  void clearLastName() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get phoneNumber => $_getSZ(6);
  @$pb.TagNumber(7)
  set phoneNumber($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasPhoneNumber() => $_has(6);
  @$pb.TagNumber(7)
  void clearPhoneNumber() => $_clearField(7);
}

/// Verified identity details returned from provider
class VerifiedIdentity extends $pb.GeneratedMessage {
  factory VerifiedIdentity({
    $core.String? firstName,
    $core.String? lastName,
    $core.String? middleName,
    $core.String? phoneNumber,
    $core.String? dateOfBirth,
    $core.String? gender,
    $core.String? photoUrl,
    $core.String? address,
    $core.String? stateOfOrigin,
    $core.String? lgaOfOrigin,
  }) {
    final result = create();
    if (firstName != null) result.firstName = firstName;
    if (lastName != null) result.lastName = lastName;
    if (middleName != null) result.middleName = middleName;
    if (phoneNumber != null) result.phoneNumber = phoneNumber;
    if (dateOfBirth != null) result.dateOfBirth = dateOfBirth;
    if (gender != null) result.gender = gender;
    if (photoUrl != null) result.photoUrl = photoUrl;
    if (address != null) result.address = address;
    if (stateOfOrigin != null) result.stateOfOrigin = stateOfOrigin;
    if (lgaOfOrigin != null) result.lgaOfOrigin = lgaOfOrigin;
    return result;
  }

  VerifiedIdentity._();

  factory VerifiedIdentity.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VerifiedIdentity.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VerifiedIdentity',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'firstName')
    ..aOS(2, _omitFieldNames ? '' : 'lastName')
    ..aOS(3, _omitFieldNames ? '' : 'middleName')
    ..aOS(4, _omitFieldNames ? '' : 'phoneNumber')
    ..aOS(5, _omitFieldNames ? '' : 'dateOfBirth')
    ..aOS(6, _omitFieldNames ? '' : 'gender')
    ..aOS(7, _omitFieldNames ? '' : 'photoUrl')
    ..aOS(8, _omitFieldNames ? '' : 'address')
    ..aOS(9, _omitFieldNames ? '' : 'stateOfOrigin')
    ..aOS(10, _omitFieldNames ? '' : 'lgaOfOrigin')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifiedIdentity clone() => VerifiedIdentity()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifiedIdentity copyWith(void Function(VerifiedIdentity) updates) =>
      super.copyWith((message) => updates(message as VerifiedIdentity))
          as VerifiedIdentity;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VerifiedIdentity create() => VerifiedIdentity._();
  @$core.override
  VerifiedIdentity createEmptyInstance() => create();
  static $pb.PbList<VerifiedIdentity> createRepeated() =>
      $pb.PbList<VerifiedIdentity>();
  @$core.pragma('dart2js:noInline')
  static VerifiedIdentity getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VerifiedIdentity>(create);
  static VerifiedIdentity? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get firstName => $_getSZ(0);
  @$pb.TagNumber(1)
  set firstName($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFirstName() => $_has(0);
  @$pb.TagNumber(1)
  void clearFirstName() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get lastName => $_getSZ(1);
  @$pb.TagNumber(2)
  set lastName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLastName() => $_has(1);
  @$pb.TagNumber(2)
  void clearLastName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get middleName => $_getSZ(2);
  @$pb.TagNumber(3)
  set middleName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMiddleName() => $_has(2);
  @$pb.TagNumber(3)
  void clearMiddleName() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get phoneNumber => $_getSZ(3);
  @$pb.TagNumber(4)
  set phoneNumber($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPhoneNumber() => $_has(3);
  @$pb.TagNumber(4)
  void clearPhoneNumber() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get dateOfBirth => $_getSZ(4);
  @$pb.TagNumber(5)
  set dateOfBirth($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasDateOfBirth() => $_has(4);
  @$pb.TagNumber(5)
  void clearDateOfBirth() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get gender => $_getSZ(5);
  @$pb.TagNumber(6)
  set gender($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasGender() => $_has(5);
  @$pb.TagNumber(6)
  void clearGender() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get photoUrl => $_getSZ(6);
  @$pb.TagNumber(7)
  set photoUrl($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasPhotoUrl() => $_has(6);
  @$pb.TagNumber(7)
  void clearPhotoUrl() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get address => $_getSZ(7);
  @$pb.TagNumber(8)
  set address($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasAddress() => $_has(7);
  @$pb.TagNumber(8)
  void clearAddress() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get stateOfOrigin => $_getSZ(8);
  @$pb.TagNumber(9)
  set stateOfOrigin($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasStateOfOrigin() => $_has(8);
  @$pb.TagNumber(9)
  void clearStateOfOrigin() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get lgaOfOrigin => $_getSZ(9);
  @$pb.TagNumber(10)
  set lgaOfOrigin($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasLgaOfOrigin() => $_has(9);
  @$pb.TagNumber(10)
  void clearLgaOfOrigin() => $_clearField(10);
}

/// Verify identity response
class VerifyIdentityResponse extends $pb.GeneratedMessage {
  factory VerifyIdentityResponse({
    $core.bool? success,
    $core.bool? verified,
    $core.String? errorCode,
    $core.String? errorMessage,
    VerifiedIdentity? identity,
    VirtualAccountInfo? virtualAccount,
    $core.String? verificationId,
    $core.String? status,
    $core.String? sessionUrl,
    $core.String? sessionToken,
    DataReconciliation? reconciliation,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (verified != null) result.verified = verified;
    if (errorCode != null) result.errorCode = errorCode;
    if (errorMessage != null) result.errorMessage = errorMessage;
    if (identity != null) result.identity = identity;
    if (virtualAccount != null) result.virtualAccount = virtualAccount;
    if (verificationId != null) result.verificationId = verificationId;
    if (status != null) result.status = status;
    if (sessionUrl != null) result.sessionUrl = sessionUrl;
    if (sessionToken != null) result.sessionToken = sessionToken;
    if (reconciliation != null) result.reconciliation = reconciliation;
    return result;
  }

  VerifyIdentityResponse._();

  factory VerifyIdentityResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VerifyIdentityResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VerifyIdentityResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOB(2, _omitFieldNames ? '' : 'verified')
    ..aOS(3, _omitFieldNames ? '' : 'errorCode')
    ..aOS(4, _omitFieldNames ? '' : 'errorMessage')
    ..aOM<VerifiedIdentity>(5, _omitFieldNames ? '' : 'identity',
        subBuilder: VerifiedIdentity.create)
    ..aOM<VirtualAccountInfo>(6, _omitFieldNames ? '' : 'virtualAccount',
        subBuilder: VirtualAccountInfo.create)
    ..aOS(7, _omitFieldNames ? '' : 'verificationId')
    ..aOS(8, _omitFieldNames ? '' : 'status')
    ..aOS(9, _omitFieldNames ? '' : 'sessionUrl')
    ..aOS(10, _omitFieldNames ? '' : 'sessionToken')
    ..aOM<DataReconciliation>(11, _omitFieldNames ? '' : 'reconciliation',
        subBuilder: DataReconciliation.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyIdentityResponse clone() =>
      VerifyIdentityResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyIdentityResponse copyWith(
          void Function(VerifyIdentityResponse) updates) =>
      super.copyWith((message) => updates(message as VerifyIdentityResponse))
          as VerifyIdentityResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VerifyIdentityResponse create() => VerifyIdentityResponse._();
  @$core.override
  VerifyIdentityResponse createEmptyInstance() => create();
  static $pb.PbList<VerifyIdentityResponse> createRepeated() =>
      $pb.PbList<VerifyIdentityResponse>();
  @$core.pragma('dart2js:noInline')
  static VerifyIdentityResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VerifyIdentityResponse>(create);
  static VerifyIdentityResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get verified => $_getBF(1);
  @$pb.TagNumber(2)
  set verified($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasVerified() => $_has(1);
  @$pb.TagNumber(2)
  void clearVerified() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorCode => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorCode($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasErrorCode() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorCode() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get errorMessage => $_getSZ(3);
  @$pb.TagNumber(4)
  set errorMessage($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasErrorMessage() => $_has(3);
  @$pb.TagNumber(4)
  void clearErrorMessage() => $_clearField(4);

  @$pb.TagNumber(5)
  VerifiedIdentity get identity => $_getN(4);
  @$pb.TagNumber(5)
  set identity(VerifiedIdentity value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasIdentity() => $_has(4);
  @$pb.TagNumber(5)
  void clearIdentity() => $_clearField(5);
  @$pb.TagNumber(5)
  VerifiedIdentity ensureIdentity() => $_ensure(4);

  @$pb.TagNumber(6)
  VirtualAccountInfo get virtualAccount => $_getN(5);
  @$pb.TagNumber(6)
  set virtualAccount(VirtualAccountInfo value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasVirtualAccount() => $_has(5);
  @$pb.TagNumber(6)
  void clearVirtualAccount() => $_clearField(6);
  @$pb.TagNumber(6)
  VirtualAccountInfo ensureVirtualAccount() => $_ensure(5);

  /// Async verification fields (Onfido/Persona - UK/US)
  @$pb.TagNumber(7)
  $core.String get verificationId => $_getSZ(6);
  @$pb.TagNumber(7)
  set verificationId($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasVerificationId() => $_has(6);
  @$pb.TagNumber(7)
  void clearVerificationId() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get status => $_getSZ(7);
  @$pb.TagNumber(8)
  set status($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasStatus() => $_has(7);
  @$pb.TagNumber(8)
  void clearStatus() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get sessionUrl => $_getSZ(8);
  @$pb.TagNumber(9)
  set sessionUrl($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasSessionUrl() => $_has(8);
  @$pb.TagNumber(9)
  void clearSessionUrl() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get sessionToken => $_getSZ(9);
  @$pb.TagNumber(10)
  set sessionToken($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasSessionToken() => $_has(9);
  @$pb.TagNumber(10)
  void clearSessionToken() => $_clearField(10);

  /// BVN data reconciliation (populated when name/DOB mismatch detected)
  @$pb.TagNumber(11)
  DataReconciliation get reconciliation => $_getN(10);
  @$pb.TagNumber(11)
  set reconciliation(DataReconciliation value) => $_setField(11, value);
  @$pb.TagNumber(11)
  $core.bool hasReconciliation() => $_has(10);
  @$pb.TagNumber(11)
  void clearReconciliation() => $_clearField(11);
  @$pb.TagNumber(11)
  DataReconciliation ensureReconciliation() => $_ensure(10);
}

/// BVN data reconciliation result
class DataReconciliation extends $pb.GeneratedMessage {
  factory DataReconciliation({
    $core.String? nameAction,
    $core.double? nameMatchScore,
    $core.String? verifiedName,
    $core.String? profileName,
    $core.bool? dobMismatch,
    $core.String? verifiedDob,
    $core.String? profileDob,
    $core.bool? phoneMismatch,
  }) {
    final result = create();
    if (nameAction != null) result.nameAction = nameAction;
    if (nameMatchScore != null) result.nameMatchScore = nameMatchScore;
    if (verifiedName != null) result.verifiedName = verifiedName;
    if (profileName != null) result.profileName = profileName;
    if (dobMismatch != null) result.dobMismatch = dobMismatch;
    if (verifiedDob != null) result.verifiedDob = verifiedDob;
    if (profileDob != null) result.profileDob = profileDob;
    if (phoneMismatch != null) result.phoneMismatch = phoneMismatch;
    return result;
  }

  DataReconciliation._();

  factory DataReconciliation.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DataReconciliation.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DataReconciliation',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'nameAction')
    ..a<$core.double>(
        2, _omitFieldNames ? '' : 'nameMatchScore', $pb.PbFieldType.OD)
    ..aOS(3, _omitFieldNames ? '' : 'verifiedName')
    ..aOS(4, _omitFieldNames ? '' : 'profileName')
    ..aOB(5, _omitFieldNames ? '' : 'dobMismatch')
    ..aOS(6, _omitFieldNames ? '' : 'verifiedDob')
    ..aOS(7, _omitFieldNames ? '' : 'profileDob')
    ..aOB(8, _omitFieldNames ? '' : 'phoneMismatch')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DataReconciliation clone() => DataReconciliation()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DataReconciliation copyWith(void Function(DataReconciliation) updates) =>
      super.copyWith((message) => updates(message as DataReconciliation))
          as DataReconciliation;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DataReconciliation create() => DataReconciliation._();
  @$core.override
  DataReconciliation createEmptyInstance() => create();
  static $pb.PbList<DataReconciliation> createRepeated() =>
      $pb.PbList<DataReconciliation>();
  @$core.pragma('dart2js:noInline')
  static DataReconciliation getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DataReconciliation>(create);
  static DataReconciliation? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get nameAction => $_getSZ(0);
  @$pb.TagNumber(1)
  set nameAction($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasNameAction() => $_has(0);
  @$pb.TagNumber(1)
  void clearNameAction() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get nameMatchScore => $_getN(1);
  @$pb.TagNumber(2)
  set nameMatchScore($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNameMatchScore() => $_has(1);
  @$pb.TagNumber(2)
  void clearNameMatchScore() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get verifiedName => $_getSZ(2);
  @$pb.TagNumber(3)
  set verifiedName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasVerifiedName() => $_has(2);
  @$pb.TagNumber(3)
  void clearVerifiedName() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get profileName => $_getSZ(3);
  @$pb.TagNumber(4)
  set profileName($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasProfileName() => $_has(3);
  @$pb.TagNumber(4)
  void clearProfileName() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.bool get dobMismatch => $_getBF(4);
  @$pb.TagNumber(5)
  set dobMismatch($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasDobMismatch() => $_has(4);
  @$pb.TagNumber(5)
  void clearDobMismatch() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get verifiedDob => $_getSZ(5);
  @$pb.TagNumber(6)
  set verifiedDob($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasVerifiedDob() => $_has(5);
  @$pb.TagNumber(6)
  void clearVerifiedDob() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get profileDob => $_getSZ(6);
  @$pb.TagNumber(7)
  set profileDob($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasProfileDob() => $_has(6);
  @$pb.TagNumber(7)
  void clearProfileDob() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.bool get phoneMismatch => $_getBF(7);
  @$pb.TagNumber(8)
  set phoneMismatch($core.bool value) => $_setBool(7, value);
  @$pb.TagNumber(8)
  $core.bool hasPhoneMismatch() => $_has(7);
  @$pb.TagNumber(8)
  void clearPhoneMismatch() => $_clearField(8);
}

/// Confirm BVN name after reconciliation
class ConfirmBVNNameRequest extends $pb.GeneratedMessage {
  factory ConfirmBVNNameRequest({
    $core.String? action,
    $core.String? verificationId,
  }) {
    final result = create();
    if (action != null) result.action = action;
    if (verificationId != null) result.verificationId = verificationId;
    return result;
  }

  ConfirmBVNNameRequest._();

  factory ConfirmBVNNameRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ConfirmBVNNameRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ConfirmBVNNameRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'action')
    ..aOS(2, _omitFieldNames ? '' : 'verificationId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ConfirmBVNNameRequest clone() =>
      ConfirmBVNNameRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ConfirmBVNNameRequest copyWith(
          void Function(ConfirmBVNNameRequest) updates) =>
      super.copyWith((message) => updates(message as ConfirmBVNNameRequest))
          as ConfirmBVNNameRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ConfirmBVNNameRequest create() => ConfirmBVNNameRequest._();
  @$core.override
  ConfirmBVNNameRequest createEmptyInstance() => create();
  static $pb.PbList<ConfirmBVNNameRequest> createRepeated() =>
      $pb.PbList<ConfirmBVNNameRequest>();
  @$core.pragma('dart2js:noInline')
  static ConfirmBVNNameRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ConfirmBVNNameRequest>(create);
  static ConfirmBVNNameRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get action => $_getSZ(0);
  @$pb.TagNumber(1)
  set action($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAction() => $_has(0);
  @$pb.TagNumber(1)
  void clearAction() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get verificationId => $_getSZ(1);
  @$pb.TagNumber(2)
  set verificationId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasVerificationId() => $_has(1);
  @$pb.TagNumber(2)
  void clearVerificationId() => $_clearField(2);
}

/// Confirm BVN name response
class ConfirmBVNNameResponse extends $pb.GeneratedMessage {
  factory ConfirmBVNNameResponse({
    $core.bool? success,
    $core.String? message,
    KYCVerificationStatus? status,
    KYCTier? currentTier,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (status != null) result.status = status;
    if (currentTier != null) result.currentTier = currentTier;
    return result;
  }

  ConfirmBVNNameResponse._();

  factory ConfirmBVNNameResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ConfirmBVNNameResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ConfirmBVNNameResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..e<KYCVerificationStatus>(
        3, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: KYCVerificationStatus.KYC_STATUS_UNKNOWN,
        valueOf: KYCVerificationStatus.valueOf,
        enumValues: KYCVerificationStatus.values)
    ..e<KYCTier>(4, _omitFieldNames ? '' : 'currentTier', $pb.PbFieldType.OE,
        defaultOrMaker: KYCTier.KYC_TIER_UNKNOWN,
        valueOf: KYCTier.valueOf,
        enumValues: KYCTier.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ConfirmBVNNameResponse clone() =>
      ConfirmBVNNameResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ConfirmBVNNameResponse copyWith(
          void Function(ConfirmBVNNameResponse) updates) =>
      super.copyWith((message) => updates(message as ConfirmBVNNameResponse))
          as ConfirmBVNNameResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ConfirmBVNNameResponse create() => ConfirmBVNNameResponse._();
  @$core.override
  ConfirmBVNNameResponse createEmptyInstance() => create();
  static $pb.PbList<ConfirmBVNNameResponse> createRepeated() =>
      $pb.PbList<ConfirmBVNNameResponse>();
  @$core.pragma('dart2js:noInline')
  static ConfirmBVNNameResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ConfirmBVNNameResponse>(create);
  static ConfirmBVNNameResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);

  @$pb.TagNumber(3)
  KYCVerificationStatus get status => $_getN(2);
  @$pb.TagNumber(3)
  set status(KYCVerificationStatus value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatus() => $_clearField(3);

  @$pb.TagNumber(4)
  KYCTier get currentTier => $_getN(3);
  @$pb.TagNumber(4)
  set currentTier(KYCTier value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasCurrentTier() => $_has(3);
  @$pb.TagNumber(4)
  void clearCurrentTier() => $_clearField(4);
}

/// Virtual account info (returned after identity verification)
class VirtualAccountInfo extends $pb.GeneratedMessage {
  factory VirtualAccountInfo({
    $core.String? accountNumber,
    $core.String? bankName,
    $core.String? bankCode,
    $core.String? accountName,
    $core.String? currency,
    $core.String? provider,
  }) {
    final result = create();
    if (accountNumber != null) result.accountNumber = accountNumber;
    if (bankName != null) result.bankName = bankName;
    if (bankCode != null) result.bankCode = bankCode;
    if (accountName != null) result.accountName = accountName;
    if (currency != null) result.currency = currency;
    if (provider != null) result.provider = provider;
    return result;
  }

  VirtualAccountInfo._();

  factory VirtualAccountInfo.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VirtualAccountInfo.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VirtualAccountInfo',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountNumber')
    ..aOS(2, _omitFieldNames ? '' : 'bankName')
    ..aOS(3, _omitFieldNames ? '' : 'bankCode')
    ..aOS(4, _omitFieldNames ? '' : 'accountName')
    ..aOS(5, _omitFieldNames ? '' : 'currency')
    ..aOS(6, _omitFieldNames ? '' : 'provider')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VirtualAccountInfo clone() => VirtualAccountInfo()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VirtualAccountInfo copyWith(void Function(VirtualAccountInfo) updates) =>
      super.copyWith((message) => updates(message as VirtualAccountInfo))
          as VirtualAccountInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VirtualAccountInfo create() => VirtualAccountInfo._();
  @$core.override
  VirtualAccountInfo createEmptyInstance() => create();
  static $pb.PbList<VirtualAccountInfo> createRepeated() =>
      $pb.PbList<VirtualAccountInfo>();
  @$core.pragma('dart2js:noInline')
  static VirtualAccountInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VirtualAccountInfo>(create);
  static VirtualAccountInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountNumber => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountNumber($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAccountNumber() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountNumber() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get bankName => $_getSZ(1);
  @$pb.TagNumber(2)
  set bankName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasBankName() => $_has(1);
  @$pb.TagNumber(2)
  void clearBankName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get bankCode => $_getSZ(2);
  @$pb.TagNumber(3)
  set bankCode($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasBankCode() => $_has(2);
  @$pb.TagNumber(3)
  void clearBankCode() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get accountName => $_getSZ(3);
  @$pb.TagNumber(4)
  set accountName($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAccountName() => $_has(3);
  @$pb.TagNumber(4)
  void clearAccountName() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get currency => $_getSZ(4);
  @$pb.TagNumber(5)
  set currency($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCurrency() => $_has(4);
  @$pb.TagNumber(5)
  void clearCurrency() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get provider => $_getSZ(5);
  @$pb.TagNumber(6)
  set provider($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasProvider() => $_has(5);
  @$pb.TagNumber(6)
  void clearProvider() => $_clearField(6);
}

/// Get identity verification status request
class GetIdentityVerificationStatusRequest extends $pb.GeneratedMessage {
  factory GetIdentityVerificationStatusRequest() => create();

  GetIdentityVerificationStatusRequest._();

  factory GetIdentityVerificationStatusRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetIdentityVerificationStatusRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetIdentityVerificationStatusRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetIdentityVerificationStatusRequest clone() =>
      GetIdentityVerificationStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetIdentityVerificationStatusRequest copyWith(
          void Function(GetIdentityVerificationStatusRequest) updates) =>
      super.copyWith((message) =>
              updates(message as GetIdentityVerificationStatusRequest))
          as GetIdentityVerificationStatusRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetIdentityVerificationStatusRequest create() =>
      GetIdentityVerificationStatusRequest._();
  @$core.override
  GetIdentityVerificationStatusRequest createEmptyInstance() => create();
  static $pb.PbList<GetIdentityVerificationStatusRequest> createRepeated() =>
      $pb.PbList<GetIdentityVerificationStatusRequest>();
  @$core.pragma('dart2js:noInline')
  static GetIdentityVerificationStatusRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          GetIdentityVerificationStatusRequest>(create);
  static GetIdentityVerificationStatusRequest? _defaultInstance;
}

/// Get identity verification status response
class GetIdentityVerificationStatusResponse extends $pb.GeneratedMessage {
  factory GetIdentityVerificationStatusResponse({
    $core.bool? success,
    $core.String? msg,
    $core.bool? identityVerified,
    IdentityType? identityType,
    $core.String? identityVerifiedAt,
    $core.String? maskedIdentityNumber,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (msg != null) result.msg = msg;
    if (identityVerified != null) result.identityVerified = identityVerified;
    if (identityType != null) result.identityType = identityType;
    if (identityVerifiedAt != null)
      result.identityVerifiedAt = identityVerifiedAt;
    if (maskedIdentityNumber != null)
      result.maskedIdentityNumber = maskedIdentityNumber;
    return result;
  }

  GetIdentityVerificationStatusResponse._();

  factory GetIdentityVerificationStatusResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetIdentityVerificationStatusResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetIdentityVerificationStatusResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'msg')
    ..aOB(3, _omitFieldNames ? '' : 'identityVerified')
    ..e<IdentityType>(
        4, _omitFieldNames ? '' : 'identityType', $pb.PbFieldType.OE,
        defaultOrMaker: IdentityType.IDENTITY_TYPE_UNSPECIFIED,
        valueOf: IdentityType.valueOf,
        enumValues: IdentityType.values)
    ..aOS(5, _omitFieldNames ? '' : 'identityVerifiedAt')
    ..aOS(6, _omitFieldNames ? '' : 'maskedIdentityNumber')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetIdentityVerificationStatusResponse clone() =>
      GetIdentityVerificationStatusResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetIdentityVerificationStatusResponse copyWith(
          void Function(GetIdentityVerificationStatusResponse) updates) =>
      super.copyWith((message) =>
              updates(message as GetIdentityVerificationStatusResponse))
          as GetIdentityVerificationStatusResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetIdentityVerificationStatusResponse create() =>
      GetIdentityVerificationStatusResponse._();
  @$core.override
  GetIdentityVerificationStatusResponse createEmptyInstance() => create();
  static $pb.PbList<GetIdentityVerificationStatusResponse> createRepeated() =>
      $pb.PbList<GetIdentityVerificationStatusResponse>();
  @$core.pragma('dart2js:noInline')
  static GetIdentityVerificationStatusResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          GetIdentityVerificationStatusResponse>(create);
  static GetIdentityVerificationStatusResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get msg => $_getSZ(1);
  @$pb.TagNumber(2)
  set msg($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMsg() => $_has(1);
  @$pb.TagNumber(2)
  void clearMsg() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get identityVerified => $_getBF(2);
  @$pb.TagNumber(3)
  set identityVerified($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasIdentityVerified() => $_has(2);
  @$pb.TagNumber(3)
  void clearIdentityVerified() => $_clearField(3);

  @$pb.TagNumber(4)
  IdentityType get identityType => $_getN(3);
  @$pb.TagNumber(4)
  set identityType(IdentityType value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasIdentityType() => $_has(3);
  @$pb.TagNumber(4)
  void clearIdentityType() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get identityVerifiedAt => $_getSZ(4);
  @$pb.TagNumber(5)
  set identityVerifiedAt($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasIdentityVerifiedAt() => $_has(4);
  @$pb.TagNumber(5)
  void clearIdentityVerifiedAt() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get maskedIdentityNumber => $_getSZ(5);
  @$pb.TagNumber(6)
  set maskedIdentityNumber($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasMaskedIdentityNumber() => $_has(5);
  @$pb.TagNumber(6)
  void clearMaskedIdentityNumber() => $_clearField(6);
}

/// Lookup user by username request
class LookupUserByUsernameRequest extends $pb.GeneratedMessage {
  factory LookupUserByUsernameRequest({
    $core.String? username,
  }) {
    final result = create();
    if (username != null) result.username = username;
    return result;
  }

  LookupUserByUsernameRequest._();

  factory LookupUserByUsernameRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory LookupUserByUsernameRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LookupUserByUsernameRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'username')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LookupUserByUsernameRequest clone() =>
      LookupUserByUsernameRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LookupUserByUsernameRequest copyWith(
          void Function(LookupUserByUsernameRequest) updates) =>
      super.copyWith(
              (message) => updates(message as LookupUserByUsernameRequest))
          as LookupUserByUsernameRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LookupUserByUsernameRequest create() =>
      LookupUserByUsernameRequest._();
  @$core.override
  LookupUserByUsernameRequest createEmptyInstance() => create();
  static $pb.PbList<LookupUserByUsernameRequest> createRepeated() =>
      $pb.PbList<LookupUserByUsernameRequest>();
  @$core.pragma('dart2js:noInline')
  static LookupUserByUsernameRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LookupUserByUsernameRequest>(create);
  static LookupUserByUsernameRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get username => $_getSZ(0);
  @$pb.TagNumber(1)
  set username($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUsername() => $_has(0);
  @$pb.TagNumber(1)
  void clearUsername() => $_clearField(1);
}

/// Lookup user by phone request
class LookupUserByPhoneRequest extends $pb.GeneratedMessage {
  factory LookupUserByPhoneRequest({
    $core.String? phone,
  }) {
    final result = create();
    if (phone != null) result.phone = phone;
    return result;
  }

  LookupUserByPhoneRequest._();

  factory LookupUserByPhoneRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory LookupUserByPhoneRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LookupUserByPhoneRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'phone')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LookupUserByPhoneRequest clone() =>
      LookupUserByPhoneRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LookupUserByPhoneRequest copyWith(
          void Function(LookupUserByPhoneRequest) updates) =>
      super.copyWith((message) => updates(message as LookupUserByPhoneRequest))
          as LookupUserByPhoneRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LookupUserByPhoneRequest create() => LookupUserByPhoneRequest._();
  @$core.override
  LookupUserByPhoneRequest createEmptyInstance() => create();
  static $pb.PbList<LookupUserByPhoneRequest> createRepeated() =>
      $pb.PbList<LookupUserByPhoneRequest>();
  @$core.pragma('dart2js:noInline')
  static LookupUserByPhoneRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LookupUserByPhoneRequest>(create);
  static LookupUserByPhoneRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get phone => $_getSZ(0);
  @$pb.TagNumber(1)
  set phone($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPhone() => $_has(0);
  @$pb.TagNumber(1)
  void clearPhone() => $_clearField(1);
}

/// User lookup response (common for both username and phone lookup)
class UserLookupResponse extends $pb.GeneratedMessage {
  factory UserLookupResponse({
    $core.bool? success,
    $core.String? msg,
    $core.bool? found,
    UserLookupResult? user,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (msg != null) result.msg = msg;
    if (found != null) result.found = found;
    if (user != null) result.user = user;
    return result;
  }

  UserLookupResponse._();

  factory UserLookupResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UserLookupResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UserLookupResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'msg')
    ..aOB(3, _omitFieldNames ? '' : 'found')
    ..aOM<UserLookupResult>(4, _omitFieldNames ? '' : 'user',
        subBuilder: UserLookupResult.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserLookupResponse clone() => UserLookupResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserLookupResponse copyWith(void Function(UserLookupResponse) updates) =>
      super.copyWith((message) => updates(message as UserLookupResponse))
          as UserLookupResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UserLookupResponse create() => UserLookupResponse._();
  @$core.override
  UserLookupResponse createEmptyInstance() => create();
  static $pb.PbList<UserLookupResponse> createRepeated() =>
      $pb.PbList<UserLookupResponse>();
  @$core.pragma('dart2js:noInline')
  static UserLookupResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UserLookupResponse>(create);
  static UserLookupResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get msg => $_getSZ(1);
  @$pb.TagNumber(2)
  set msg($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMsg() => $_has(1);
  @$pb.TagNumber(2)
  void clearMsg() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get found => $_getBF(2);
  @$pb.TagNumber(3)
  set found($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasFound() => $_has(2);
  @$pb.TagNumber(3)
  void clearFound() => $_clearField(3);

  @$pb.TagNumber(4)
  UserLookupResult get user => $_getN(3);
  @$pb.TagNumber(4)
  set user(UserLookupResult value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasUser() => $_has(3);
  @$pb.TagNumber(4)
  void clearUser() => $_clearField(4);
  @$pb.TagNumber(4)
  UserLookupResult ensureUser() => $_ensure(3);
}

/// User lookup result - minimal info for transfers
class UserLookupResult extends $pb.GeneratedMessage {
  factory UserLookupResult({
    $core.String? userId,
    $core.String? username,
    $core.String? firstName,
    $core.String? lastName,
    $core.String? profilePicture,
    $core.bool? isLazervaultUser,
    $core.String? phoneNumber,
    $core.String? email,
    $core.String? primaryAccountId,
    $core.String? countryCode,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (username != null) result.username = username;
    if (firstName != null) result.firstName = firstName;
    if (lastName != null) result.lastName = lastName;
    if (profilePicture != null) result.profilePicture = profilePicture;
    if (isLazervaultUser != null) result.isLazervaultUser = isLazervaultUser;
    if (phoneNumber != null) result.phoneNumber = phoneNumber;
    if (email != null) result.email = email;
    if (primaryAccountId != null) result.primaryAccountId = primaryAccountId;
    if (countryCode != null) result.countryCode = countryCode;
    return result;
  }

  UserLookupResult._();

  factory UserLookupResult.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UserLookupResult.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UserLookupResult',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'username')
    ..aOS(3, _omitFieldNames ? '' : 'firstName')
    ..aOS(4, _omitFieldNames ? '' : 'lastName')
    ..aOS(5, _omitFieldNames ? '' : 'profilePicture')
    ..aOB(6, _omitFieldNames ? '' : 'isLazervaultUser')
    ..aOS(7, _omitFieldNames ? '' : 'phoneNumber')
    ..aOS(8, _omitFieldNames ? '' : 'email')
    ..aOS(9, _omitFieldNames ? '' : 'primaryAccountId')
    ..aOS(10, _omitFieldNames ? '' : 'countryCode')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserLookupResult clone() => UserLookupResult()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserLookupResult copyWith(void Function(UserLookupResult) updates) =>
      super.copyWith((message) => updates(message as UserLookupResult))
          as UserLookupResult;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UserLookupResult create() => UserLookupResult._();
  @$core.override
  UserLookupResult createEmptyInstance() => create();
  static $pb.PbList<UserLookupResult> createRepeated() =>
      $pb.PbList<UserLookupResult>();
  @$core.pragma('dart2js:noInline')
  static UserLookupResult getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UserLookupResult>(create);
  static UserLookupResult? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get username => $_getSZ(1);
  @$pb.TagNumber(2)
  set username($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUsername() => $_has(1);
  @$pb.TagNumber(2)
  void clearUsername() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get firstName => $_getSZ(2);
  @$pb.TagNumber(3)
  set firstName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasFirstName() => $_has(2);
  @$pb.TagNumber(3)
  void clearFirstName() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get lastName => $_getSZ(3);
  @$pb.TagNumber(4)
  set lastName($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasLastName() => $_has(3);
  @$pb.TagNumber(4)
  void clearLastName() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get profilePicture => $_getSZ(4);
  @$pb.TagNumber(5)
  set profilePicture($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasProfilePicture() => $_has(4);
  @$pb.TagNumber(5)
  void clearProfilePicture() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.bool get isLazervaultUser => $_getBF(5);
  @$pb.TagNumber(6)
  set isLazervaultUser($core.bool value) => $_setBool(5, value);
  @$pb.TagNumber(6)
  $core.bool hasIsLazervaultUser() => $_has(5);
  @$pb.TagNumber(6)
  void clearIsLazervaultUser() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get phoneNumber => $_getSZ(6);
  @$pb.TagNumber(7)
  set phoneNumber($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasPhoneNumber() => $_has(6);
  @$pb.TagNumber(7)
  void clearPhoneNumber() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get email => $_getSZ(7);
  @$pb.TagNumber(8)
  set email($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasEmail() => $_has(7);
  @$pb.TagNumber(8)
  void clearEmail() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get primaryAccountId => $_getSZ(8);
  @$pb.TagNumber(9)
  set primaryAccountId($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasPrimaryAccountId() => $_has(8);
  @$pb.TagNumber(9)
  void clearPrimaryAccountId() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get countryCode => $_getSZ(9);
  @$pb.TagNumber(10)
  set countryCode($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasCountryCode() => $_has(9);
  @$pb.TagNumber(10)
  void clearCountryCode() => $_clearField(10);
}

/// Search users by multiple fields request
class UserSearchRequest extends $pb.GeneratedMessage {
  factory UserSearchRequest({
    $core.String? query,
    $core.int? limit,
    $core.String? searchType,
    $core.String? countryCode,
  }) {
    final result = create();
    if (query != null) result.query = query;
    if (limit != null) result.limit = limit;
    if (searchType != null) result.searchType = searchType;
    if (countryCode != null) result.countryCode = countryCode;
    return result;
  }

  UserSearchRequest._();

  factory UserSearchRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UserSearchRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UserSearchRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'query')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..aOS(3, _omitFieldNames ? '' : 'searchType')
    ..aOS(4, _omitFieldNames ? '' : 'countryCode')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserSearchRequest clone() => UserSearchRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserSearchRequest copyWith(void Function(UserSearchRequest) updates) =>
      super.copyWith((message) => updates(message as UserSearchRequest))
          as UserSearchRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UserSearchRequest create() => UserSearchRequest._();
  @$core.override
  UserSearchRequest createEmptyInstance() => create();
  static $pb.PbList<UserSearchRequest> createRepeated() =>
      $pb.PbList<UserSearchRequest>();
  @$core.pragma('dart2js:noInline')
  static UserSearchRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UserSearchRequest>(create);
  static UserSearchRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get query => $_getSZ(0);
  @$pb.TagNumber(1)
  set query($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasQuery() => $_has(0);
  @$pb.TagNumber(1)
  void clearQuery() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get limit => $_getIZ(1);
  @$pb.TagNumber(2)
  set limit($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get searchType => $_getSZ(2);
  @$pb.TagNumber(3)
  set searchType($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSearchType() => $_has(2);
  @$pb.TagNumber(3)
  void clearSearchType() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get countryCode => $_getSZ(3);
  @$pb.TagNumber(4)
  set countryCode($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCountryCode() => $_has(3);
  @$pb.TagNumber(4)
  void clearCountryCode() => $_clearField(4);
}

/// Search users response
class UserSearchResponse extends $pb.GeneratedMessage {
  factory UserSearchResponse({
    $core.bool? success,
    $core.String? msg,
    $core.Iterable<UserLookupResult>? users,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (msg != null) result.msg = msg;
    if (users != null) result.users.addAll(users);
    return result;
  }

  UserSearchResponse._();

  factory UserSearchResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UserSearchResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UserSearchResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'msg')
    ..pc<UserLookupResult>(
        3, _omitFieldNames ? '' : 'users', $pb.PbFieldType.PM,
        subBuilder: UserLookupResult.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserSearchResponse clone() => UserSearchResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserSearchResponse copyWith(void Function(UserSearchResponse) updates) =>
      super.copyWith((message) => updates(message as UserSearchResponse))
          as UserSearchResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UserSearchResponse create() => UserSearchResponse._();
  @$core.override
  UserSearchResponse createEmptyInstance() => create();
  static $pb.PbList<UserSearchResponse> createRepeated() =>
      $pb.PbList<UserSearchResponse>();
  @$core.pragma('dart2js:noInline')
  static UserSearchResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UserSearchResponse>(create);
  static UserSearchResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get msg => $_getSZ(1);
  @$pb.TagNumber(2)
  set msg($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMsg() => $_has(1);
  @$pb.TagNumber(2)
  void clearMsg() => $_clearField(2);

  @$pb.TagNumber(3)
  $pb.PbList<UserLookupResult> get users => $_getList(2);
}

/// Initiate KYC request
class InitiateKYCRequest extends $pb.GeneratedMessage {
  factory InitiateKYCRequest({
    KYCTier? targetTier,
    $core.String? countryCode,
  }) {
    final result = create();
    if (targetTier != null) result.targetTier = targetTier;
    if (countryCode != null) result.countryCode = countryCode;
    return result;
  }

  InitiateKYCRequest._();

  factory InitiateKYCRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InitiateKYCRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InitiateKYCRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..e<KYCTier>(1, _omitFieldNames ? '' : 'targetTier', $pb.PbFieldType.OE,
        defaultOrMaker: KYCTier.KYC_TIER_UNKNOWN,
        valueOf: KYCTier.valueOf,
        enumValues: KYCTier.values)
    ..aOS(2, _omitFieldNames ? '' : 'countryCode')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InitiateKYCRequest clone() => InitiateKYCRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InitiateKYCRequest copyWith(void Function(InitiateKYCRequest) updates) =>
      super.copyWith((message) => updates(message as InitiateKYCRequest))
          as InitiateKYCRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InitiateKYCRequest create() => InitiateKYCRequest._();
  @$core.override
  InitiateKYCRequest createEmptyInstance() => create();
  static $pb.PbList<InitiateKYCRequest> createRepeated() =>
      $pb.PbList<InitiateKYCRequest>();
  @$core.pragma('dart2js:noInline')
  static InitiateKYCRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InitiateKYCRequest>(create);
  static InitiateKYCRequest? _defaultInstance;

  @$pb.TagNumber(1)
  KYCTier get targetTier => $_getN(0);
  @$pb.TagNumber(1)
  set targetTier(KYCTier value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasTargetTier() => $_has(0);
  @$pb.TagNumber(1)
  void clearTargetTier() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get countryCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set countryCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCountryCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearCountryCode() => $_clearField(2);
}

/// Initiate KYC response
class InitiateKYCResponse extends $pb.GeneratedMessage {
  factory InitiateKYCResponse({
    $core.bool? success,
    $core.String? sessionId,
    $core.Iterable<$core.String>? requiredDocuments,
    $core.Iterable<$core.String>? requiredFields,
    $core.String? redirectUrl,
    $core.String? errorMessage,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (sessionId != null) result.sessionId = sessionId;
    if (requiredDocuments != null)
      result.requiredDocuments.addAll(requiredDocuments);
    if (requiredFields != null) result.requiredFields.addAll(requiredFields);
    if (redirectUrl != null) result.redirectUrl = redirectUrl;
    if (errorMessage != null) result.errorMessage = errorMessage;
    return result;
  }

  InitiateKYCResponse._();

  factory InitiateKYCResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InitiateKYCResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InitiateKYCResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'sessionId')
    ..pPS(3, _omitFieldNames ? '' : 'requiredDocuments')
    ..pPS(4, _omitFieldNames ? '' : 'requiredFields')
    ..aOS(5, _omitFieldNames ? '' : 'redirectUrl')
    ..aOS(6, _omitFieldNames ? '' : 'errorMessage')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InitiateKYCResponse clone() => InitiateKYCResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InitiateKYCResponse copyWith(void Function(InitiateKYCResponse) updates) =>
      super.copyWith((message) => updates(message as InitiateKYCResponse))
          as InitiateKYCResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InitiateKYCResponse create() => InitiateKYCResponse._();
  @$core.override
  InitiateKYCResponse createEmptyInstance() => create();
  static $pb.PbList<InitiateKYCResponse> createRepeated() =>
      $pb.PbList<InitiateKYCResponse>();
  @$core.pragma('dart2js:noInline')
  static InitiateKYCResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InitiateKYCResponse>(create);
  static InitiateKYCResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get sessionId => $_getSZ(1);
  @$pb.TagNumber(2)
  set sessionId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSessionId() => $_has(1);
  @$pb.TagNumber(2)
  void clearSessionId() => $_clearField(2);

  @$pb.TagNumber(3)
  $pb.PbList<$core.String> get requiredDocuments => $_getList(2);

  @$pb.TagNumber(4)
  $pb.PbList<$core.String> get requiredFields => $_getList(3);

  @$pb.TagNumber(5)
  $core.String get redirectUrl => $_getSZ(4);
  @$pb.TagNumber(5)
  set redirectUrl($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasRedirectUrl() => $_has(4);
  @$pb.TagNumber(5)
  void clearRedirectUrl() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get errorMessage => $_getSZ(5);
  @$pb.TagNumber(6)
  set errorMessage($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasErrorMessage() => $_has(5);
  @$pb.TagNumber(6)
  void clearErrorMessage() => $_clearField(6);
}

/// Upload document request
class UploadDocumentRequest extends $pb.GeneratedMessage {
  factory UploadDocumentRequest({
    DocumentType? documentType,
    $core.String? documentFrontUrl,
    $core.String? documentBackUrl,
    $core.String? selfieUrl,
    $core.String? proofOfAddressUrl,
  }) {
    final result = create();
    if (documentType != null) result.documentType = documentType;
    if (documentFrontUrl != null) result.documentFrontUrl = documentFrontUrl;
    if (documentBackUrl != null) result.documentBackUrl = documentBackUrl;
    if (selfieUrl != null) result.selfieUrl = selfieUrl;
    if (proofOfAddressUrl != null) result.proofOfAddressUrl = proofOfAddressUrl;
    return result;
  }

  UploadDocumentRequest._();

  factory UploadDocumentRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UploadDocumentRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UploadDocumentRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..e<DocumentType>(
        1, _omitFieldNames ? '' : 'documentType', $pb.PbFieldType.OE,
        defaultOrMaker: DocumentType.DOCUMENT_TYPE_UNKNOWN,
        valueOf: DocumentType.valueOf,
        enumValues: DocumentType.values)
    ..aOS(2, _omitFieldNames ? '' : 'documentFrontUrl')
    ..aOS(3, _omitFieldNames ? '' : 'documentBackUrl')
    ..aOS(4, _omitFieldNames ? '' : 'selfieUrl')
    ..aOS(5, _omitFieldNames ? '' : 'proofOfAddressUrl')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UploadDocumentRequest clone() =>
      UploadDocumentRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UploadDocumentRequest copyWith(
          void Function(UploadDocumentRequest) updates) =>
      super.copyWith((message) => updates(message as UploadDocumentRequest))
          as UploadDocumentRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UploadDocumentRequest create() => UploadDocumentRequest._();
  @$core.override
  UploadDocumentRequest createEmptyInstance() => create();
  static $pb.PbList<UploadDocumentRequest> createRepeated() =>
      $pb.PbList<UploadDocumentRequest>();
  @$core.pragma('dart2js:noInline')
  static UploadDocumentRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UploadDocumentRequest>(create);
  static UploadDocumentRequest? _defaultInstance;

  @$pb.TagNumber(1)
  DocumentType get documentType => $_getN(0);
  @$pb.TagNumber(1)
  set documentType(DocumentType value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasDocumentType() => $_has(0);
  @$pb.TagNumber(1)
  void clearDocumentType() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get documentFrontUrl => $_getSZ(1);
  @$pb.TagNumber(2)
  set documentFrontUrl($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDocumentFrontUrl() => $_has(1);
  @$pb.TagNumber(2)
  void clearDocumentFrontUrl() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get documentBackUrl => $_getSZ(2);
  @$pb.TagNumber(3)
  set documentBackUrl($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDocumentBackUrl() => $_has(2);
  @$pb.TagNumber(3)
  void clearDocumentBackUrl() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get selfieUrl => $_getSZ(3);
  @$pb.TagNumber(4)
  set selfieUrl($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasSelfieUrl() => $_has(3);
  @$pb.TagNumber(4)
  void clearSelfieUrl() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get proofOfAddressUrl => $_getSZ(4);
  @$pb.TagNumber(5)
  set proofOfAddressUrl($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasProofOfAddressUrl() => $_has(4);
  @$pb.TagNumber(5)
  void clearProofOfAddressUrl() => $_clearField(5);
}

/// Upload document response
class UploadDocumentResponse extends $pb.GeneratedMessage {
  factory UploadDocumentResponse({
    $core.bool? success,
    $core.String? message,
    $core.String? documentId,
    DocumentStatus? status,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (documentId != null) result.documentId = documentId;
    if (status != null) result.status = status;
    return result;
  }

  UploadDocumentResponse._();

  factory UploadDocumentResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UploadDocumentResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UploadDocumentResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOS(3, _omitFieldNames ? '' : 'documentId')
    ..e<DocumentStatus>(4, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: DocumentStatus.DOCUMENT_STATUS_UNKNOWN,
        valueOf: DocumentStatus.valueOf,
        enumValues: DocumentStatus.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UploadDocumentResponse clone() =>
      UploadDocumentResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UploadDocumentResponse copyWith(
          void Function(UploadDocumentResponse) updates) =>
      super.copyWith((message) => updates(message as UploadDocumentResponse))
          as UploadDocumentResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UploadDocumentResponse create() => UploadDocumentResponse._();
  @$core.override
  UploadDocumentResponse createEmptyInstance() => create();
  static $pb.PbList<UploadDocumentResponse> createRepeated() =>
      $pb.PbList<UploadDocumentResponse>();
  @$core.pragma('dart2js:noInline')
  static UploadDocumentResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UploadDocumentResponse>(create);
  static UploadDocumentResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get documentId => $_getSZ(2);
  @$pb.TagNumber(3)
  set documentId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDocumentId() => $_has(2);
  @$pb.TagNumber(3)
  void clearDocumentId() => $_clearField(3);

  @$pb.TagNumber(4)
  DocumentStatus get status => $_getN(3);
  @$pb.TagNumber(4)
  set status(DocumentStatus value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearStatus() => $_clearField(4);
}

/// Skip KYC upgrade request
class SkipKYCUpgradeRequest extends $pb.GeneratedMessage {
  factory SkipKYCUpgradeRequest({
    $core.bool? skipTier2,
    $core.bool? skipTier3,
  }) {
    final result = create();
    if (skipTier2 != null) result.skipTier2 = skipTier2;
    if (skipTier3 != null) result.skipTier3 = skipTier3;
    return result;
  }

  SkipKYCUpgradeRequest._();

  factory SkipKYCUpgradeRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SkipKYCUpgradeRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SkipKYCUpgradeRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'skipTier2', protoName: 'skip_tier_2')
    ..aOB(2, _omitFieldNames ? '' : 'skipTier3', protoName: 'skip_tier_3')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SkipKYCUpgradeRequest clone() =>
      SkipKYCUpgradeRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SkipKYCUpgradeRequest copyWith(
          void Function(SkipKYCUpgradeRequest) updates) =>
      super.copyWith((message) => updates(message as SkipKYCUpgradeRequest))
          as SkipKYCUpgradeRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SkipKYCUpgradeRequest create() => SkipKYCUpgradeRequest._();
  @$core.override
  SkipKYCUpgradeRequest createEmptyInstance() => create();
  static $pb.PbList<SkipKYCUpgradeRequest> createRepeated() =>
      $pb.PbList<SkipKYCUpgradeRequest>();
  @$core.pragma('dart2js:noInline')
  static SkipKYCUpgradeRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SkipKYCUpgradeRequest>(create);
  static SkipKYCUpgradeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get skipTier2 => $_getBF(0);
  @$pb.TagNumber(1)
  set skipTier2($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSkipTier2() => $_has(0);
  @$pb.TagNumber(1)
  void clearSkipTier2() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get skipTier3 => $_getBF(1);
  @$pb.TagNumber(2)
  set skipTier3($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSkipTier3() => $_has(1);
  @$pb.TagNumber(2)
  void clearSkipTier3() => $_clearField(2);
}

/// Skip KYC upgrade response
class SkipKYCUpgradeResponse extends $pb.GeneratedMessage {
  factory SkipKYCUpgradeResponse({
    $core.bool? success,
    KYCTier? assignedTier,
    $core.String? message,
    $core.Iterable<$core.String>? nextSteps,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (assignedTier != null) result.assignedTier = assignedTier;
    if (message != null) result.message = message;
    if (nextSteps != null) result.nextSteps.addAll(nextSteps);
    return result;
  }

  SkipKYCUpgradeResponse._();

  factory SkipKYCUpgradeResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SkipKYCUpgradeResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SkipKYCUpgradeResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..e<KYCTier>(2, _omitFieldNames ? '' : 'assignedTier', $pb.PbFieldType.OE,
        defaultOrMaker: KYCTier.KYC_TIER_UNKNOWN,
        valueOf: KYCTier.valueOf,
        enumValues: KYCTier.values)
    ..aOS(3, _omitFieldNames ? '' : 'message')
    ..pPS(4, _omitFieldNames ? '' : 'nextSteps')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SkipKYCUpgradeResponse clone() =>
      SkipKYCUpgradeResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SkipKYCUpgradeResponse copyWith(
          void Function(SkipKYCUpgradeResponse) updates) =>
      super.copyWith((message) => updates(message as SkipKYCUpgradeResponse))
          as SkipKYCUpgradeResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SkipKYCUpgradeResponse create() => SkipKYCUpgradeResponse._();
  @$core.override
  SkipKYCUpgradeResponse createEmptyInstance() => create();
  static $pb.PbList<SkipKYCUpgradeResponse> createRepeated() =>
      $pb.PbList<SkipKYCUpgradeResponse>();
  @$core.pragma('dart2js:noInline')
  static SkipKYCUpgradeResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SkipKYCUpgradeResponse>(create);
  static SkipKYCUpgradeResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  KYCTier get assignedTier => $_getN(1);
  @$pb.TagNumber(2)
  set assignedTier(KYCTier value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasAssignedTier() => $_has(1);
  @$pb.TagNumber(2)
  void clearAssignedTier() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => $_clearField(3);

  @$pb.TagNumber(4)
  $pb.PbList<$core.String> get nextSteps => $_getList(3);
}

/// Get user documents request
class GetUserDocumentsRequest extends $pb.GeneratedMessage {
  factory GetUserDocumentsRequest() => create();

  GetUserDocumentsRequest._();

  factory GetUserDocumentsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetUserDocumentsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUserDocumentsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserDocumentsRequest clone() =>
      GetUserDocumentsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserDocumentsRequest copyWith(
          void Function(GetUserDocumentsRequest) updates) =>
      super.copyWith((message) => updates(message as GetUserDocumentsRequest))
          as GetUserDocumentsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserDocumentsRequest create() => GetUserDocumentsRequest._();
  @$core.override
  GetUserDocumentsRequest createEmptyInstance() => create();
  static $pb.PbList<GetUserDocumentsRequest> createRepeated() =>
      $pb.PbList<GetUserDocumentsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetUserDocumentsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUserDocumentsRequest>(create);
  static GetUserDocumentsRequest? _defaultInstance;
}

/// Verification document info
class VerificationDocument extends $pb.GeneratedMessage {
  factory VerificationDocument({
    $core.String? id,
    DocumentType? documentType,
    $core.String? documentUrl,
    DocumentStatus? status,
    $core.String? uploadedAt,
    $core.String? verifiedAt,
    $core.String? rejectionReason,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (documentType != null) result.documentType = documentType;
    if (documentUrl != null) result.documentUrl = documentUrl;
    if (status != null) result.status = status;
    if (uploadedAt != null) result.uploadedAt = uploadedAt;
    if (verifiedAt != null) result.verifiedAt = verifiedAt;
    if (rejectionReason != null) result.rejectionReason = rejectionReason;
    return result;
  }

  VerificationDocument._();

  factory VerificationDocument.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VerificationDocument.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VerificationDocument',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..e<DocumentType>(
        2, _omitFieldNames ? '' : 'documentType', $pb.PbFieldType.OE,
        defaultOrMaker: DocumentType.DOCUMENT_TYPE_UNKNOWN,
        valueOf: DocumentType.valueOf,
        enumValues: DocumentType.values)
    ..aOS(3, _omitFieldNames ? '' : 'documentUrl')
    ..e<DocumentStatus>(4, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: DocumentStatus.DOCUMENT_STATUS_UNKNOWN,
        valueOf: DocumentStatus.valueOf,
        enumValues: DocumentStatus.values)
    ..aOS(5, _omitFieldNames ? '' : 'uploadedAt')
    ..aOS(6, _omitFieldNames ? '' : 'verifiedAt')
    ..aOS(7, _omitFieldNames ? '' : 'rejectionReason')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerificationDocument clone() =>
      VerificationDocument()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerificationDocument copyWith(void Function(VerificationDocument) updates) =>
      super.copyWith((message) => updates(message as VerificationDocument))
          as VerificationDocument;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VerificationDocument create() => VerificationDocument._();
  @$core.override
  VerificationDocument createEmptyInstance() => create();
  static $pb.PbList<VerificationDocument> createRepeated() =>
      $pb.PbList<VerificationDocument>();
  @$core.pragma('dart2js:noInline')
  static VerificationDocument getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VerificationDocument>(create);
  static VerificationDocument? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  DocumentType get documentType => $_getN(1);
  @$pb.TagNumber(2)
  set documentType(DocumentType value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasDocumentType() => $_has(1);
  @$pb.TagNumber(2)
  void clearDocumentType() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get documentUrl => $_getSZ(2);
  @$pb.TagNumber(3)
  set documentUrl($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDocumentUrl() => $_has(2);
  @$pb.TagNumber(3)
  void clearDocumentUrl() => $_clearField(3);

  @$pb.TagNumber(4)
  DocumentStatus get status => $_getN(3);
  @$pb.TagNumber(4)
  set status(DocumentStatus value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearStatus() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get uploadedAt => $_getSZ(4);
  @$pb.TagNumber(5)
  set uploadedAt($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasUploadedAt() => $_has(4);
  @$pb.TagNumber(5)
  void clearUploadedAt() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get verifiedAt => $_getSZ(5);
  @$pb.TagNumber(6)
  set verifiedAt($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasVerifiedAt() => $_has(5);
  @$pb.TagNumber(6)
  void clearVerifiedAt() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get rejectionReason => $_getSZ(6);
  @$pb.TagNumber(7)
  set rejectionReason($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasRejectionReason() => $_has(6);
  @$pb.TagNumber(7)
  void clearRejectionReason() => $_clearField(7);
}

/// Get user documents response
class GetUserDocumentsResponse extends $pb.GeneratedMessage {
  factory GetUserDocumentsResponse({
    $core.bool? success,
    $core.Iterable<VerificationDocument>? documents,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (documents != null) result.documents.addAll(documents);
    return result;
  }

  GetUserDocumentsResponse._();

  factory GetUserDocumentsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetUserDocumentsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUserDocumentsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..pc<VerificationDocument>(
        2, _omitFieldNames ? '' : 'documents', $pb.PbFieldType.PM,
        subBuilder: VerificationDocument.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserDocumentsResponse clone() =>
      GetUserDocumentsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserDocumentsResponse copyWith(
          void Function(GetUserDocumentsResponse) updates) =>
      super.copyWith((message) => updates(message as GetUserDocumentsResponse))
          as GetUserDocumentsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserDocumentsResponse create() => GetUserDocumentsResponse._();
  @$core.override
  GetUserDocumentsResponse createEmptyInstance() => create();
  static $pb.PbList<GetUserDocumentsResponse> createRepeated() =>
      $pb.PbList<GetUserDocumentsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetUserDocumentsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUserDocumentsResponse>(create);
  static GetUserDocumentsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<VerificationDocument> get documents => $_getList(1);
}

/// KYC Tier info with limits and benefits
class KYCTierInfo extends $pb.GeneratedMessage {
  factory KYCTierInfo({
    KYCTier? tier,
    KYCVerificationStatus? status,
    $core.String? displayName,
    $core.String? description,
    $core.Iterable<$core.String>? benefits,
    $fixnum.Int64? dailyTransactionLimit,
    $fixnum.Int64? dailyReceiveLimit,
    $fixnum.Int64? maxBalance,
    $core.String? verifiedAt,
    $core.String? expiresAt,
    $core.bool? isCurrent,
    $core.bool? isLocked,
  }) {
    final result = create();
    if (tier != null) result.tier = tier;
    if (status != null) result.status = status;
    if (displayName != null) result.displayName = displayName;
    if (description != null) result.description = description;
    if (benefits != null) result.benefits.addAll(benefits);
    if (dailyTransactionLimit != null)
      result.dailyTransactionLimit = dailyTransactionLimit;
    if (dailyReceiveLimit != null) result.dailyReceiveLimit = dailyReceiveLimit;
    if (maxBalance != null) result.maxBalance = maxBalance;
    if (verifiedAt != null) result.verifiedAt = verifiedAt;
    if (expiresAt != null) result.expiresAt = expiresAt;
    if (isCurrent != null) result.isCurrent = isCurrent;
    if (isLocked != null) result.isLocked = isLocked;
    return result;
  }

  KYCTierInfo._();

  factory KYCTierInfo.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory KYCTierInfo.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'KYCTierInfo',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..e<KYCTier>(1, _omitFieldNames ? '' : 'tier', $pb.PbFieldType.OE,
        defaultOrMaker: KYCTier.KYC_TIER_UNKNOWN,
        valueOf: KYCTier.valueOf,
        enumValues: KYCTier.values)
    ..e<KYCVerificationStatus>(
        2, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: KYCVerificationStatus.KYC_STATUS_UNKNOWN,
        valueOf: KYCVerificationStatus.valueOf,
        enumValues: KYCVerificationStatus.values)
    ..aOS(3, _omitFieldNames ? '' : 'displayName')
    ..aOS(4, _omitFieldNames ? '' : 'description')
    ..pPS(5, _omitFieldNames ? '' : 'benefits')
    ..aInt64(6, _omitFieldNames ? '' : 'dailyTransactionLimit')
    ..aInt64(7, _omitFieldNames ? '' : 'dailyReceiveLimit')
    ..aInt64(8, _omitFieldNames ? '' : 'maxBalance')
    ..aOS(9, _omitFieldNames ? '' : 'verifiedAt')
    ..aOS(10, _omitFieldNames ? '' : 'expiresAt')
    ..aOB(11, _omitFieldNames ? '' : 'isCurrent')
    ..aOB(12, _omitFieldNames ? '' : 'isLocked')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  KYCTierInfo clone() => KYCTierInfo()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  KYCTierInfo copyWith(void Function(KYCTierInfo) updates) =>
      super.copyWith((message) => updates(message as KYCTierInfo))
          as KYCTierInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static KYCTierInfo create() => KYCTierInfo._();
  @$core.override
  KYCTierInfo createEmptyInstance() => create();
  static $pb.PbList<KYCTierInfo> createRepeated() => $pb.PbList<KYCTierInfo>();
  @$core.pragma('dart2js:noInline')
  static KYCTierInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<KYCTierInfo>(create);
  static KYCTierInfo? _defaultInstance;

  @$pb.TagNumber(1)
  KYCTier get tier => $_getN(0);
  @$pb.TagNumber(1)
  set tier(KYCTier value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasTier() => $_has(0);
  @$pb.TagNumber(1)
  void clearTier() => $_clearField(1);

  @$pb.TagNumber(2)
  KYCVerificationStatus get status => $_getN(1);
  @$pb.TagNumber(2)
  set status(KYCVerificationStatus value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get displayName => $_getSZ(2);
  @$pb.TagNumber(3)
  set displayName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDisplayName() => $_has(2);
  @$pb.TagNumber(3)
  void clearDisplayName() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get description => $_getSZ(3);
  @$pb.TagNumber(4)
  set description($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDescription() => $_has(3);
  @$pb.TagNumber(4)
  void clearDescription() => $_clearField(4);

  @$pb.TagNumber(5)
  $pb.PbList<$core.String> get benefits => $_getList(4);

  @$pb.TagNumber(6)
  $fixnum.Int64 get dailyTransactionLimit => $_getI64(5);
  @$pb.TagNumber(6)
  set dailyTransactionLimit($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasDailyTransactionLimit() => $_has(5);
  @$pb.TagNumber(6)
  void clearDailyTransactionLimit() => $_clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get dailyReceiveLimit => $_getI64(6);
  @$pb.TagNumber(7)
  set dailyReceiveLimit($fixnum.Int64 value) => $_setInt64(6, value);
  @$pb.TagNumber(7)
  $core.bool hasDailyReceiveLimit() => $_has(6);
  @$pb.TagNumber(7)
  void clearDailyReceiveLimit() => $_clearField(7);

  @$pb.TagNumber(8)
  $fixnum.Int64 get maxBalance => $_getI64(7);
  @$pb.TagNumber(8)
  set maxBalance($fixnum.Int64 value) => $_setInt64(7, value);
  @$pb.TagNumber(8)
  $core.bool hasMaxBalance() => $_has(7);
  @$pb.TagNumber(8)
  void clearMaxBalance() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get verifiedAt => $_getSZ(8);
  @$pb.TagNumber(9)
  set verifiedAt($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasVerifiedAt() => $_has(8);
  @$pb.TagNumber(9)
  void clearVerifiedAt() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get expiresAt => $_getSZ(9);
  @$pb.TagNumber(10)
  set expiresAt($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasExpiresAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearExpiresAt() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.bool get isCurrent => $_getBF(10);
  @$pb.TagNumber(11)
  set isCurrent($core.bool value) => $_setBool(10, value);
  @$pb.TagNumber(11)
  $core.bool hasIsCurrent() => $_has(10);
  @$pb.TagNumber(11)
  void clearIsCurrent() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.bool get isLocked => $_getBF(11);
  @$pb.TagNumber(12)
  set isLocked($core.bool value) => $_setBool(11, value);
  @$pb.TagNumber(12)
  $core.bool hasIsLocked() => $_has(11);
  @$pb.TagNumber(12)
  void clearIsLocked() => $_clearField(12);
}

/// Get KYC status request
class GetKYCStatusRequest extends $pb.GeneratedMessage {
  factory GetKYCStatusRequest() => create();

  GetKYCStatusRequest._();

  factory GetKYCStatusRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetKYCStatusRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetKYCStatusRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetKYCStatusRequest clone() => GetKYCStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetKYCStatusRequest copyWith(void Function(GetKYCStatusRequest) updates) =>
      super.copyWith((message) => updates(message as GetKYCStatusRequest))
          as GetKYCStatusRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetKYCStatusRequest create() => GetKYCStatusRequest._();
  @$core.override
  GetKYCStatusRequest createEmptyInstance() => create();
  static $pb.PbList<GetKYCStatusRequest> createRepeated() =>
      $pb.PbList<GetKYCStatusRequest>();
  @$core.pragma('dart2js:noInline')
  static GetKYCStatusRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetKYCStatusRequest>(create);
  static GetKYCStatusRequest? _defaultInstance;
}

/// Get KYC status response
class GetKYCStatusResponse extends $pb.GeneratedMessage {
  factory GetKYCStatusResponse({
    $core.bool? success,
    KYCVerificationStatus? status,
    KYCTier? currentTier,
    $core.Iterable<KYCTierInfo>? tierInfo,
    $core.String? lastUpdated,
    $core.String? rejectionReason,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (status != null) result.status = status;
    if (currentTier != null) result.currentTier = currentTier;
    if (tierInfo != null) result.tierInfo.addAll(tierInfo);
    if (lastUpdated != null) result.lastUpdated = lastUpdated;
    if (rejectionReason != null) result.rejectionReason = rejectionReason;
    return result;
  }

  GetKYCStatusResponse._();

  factory GetKYCStatusResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetKYCStatusResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetKYCStatusResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..e<KYCVerificationStatus>(
        2, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: KYCVerificationStatus.KYC_STATUS_UNKNOWN,
        valueOf: KYCVerificationStatus.valueOf,
        enumValues: KYCVerificationStatus.values)
    ..e<KYCTier>(3, _omitFieldNames ? '' : 'currentTier', $pb.PbFieldType.OE,
        defaultOrMaker: KYCTier.KYC_TIER_UNKNOWN,
        valueOf: KYCTier.valueOf,
        enumValues: KYCTier.values)
    ..pc<KYCTierInfo>(4, _omitFieldNames ? '' : 'tierInfo', $pb.PbFieldType.PM,
        subBuilder: KYCTierInfo.create)
    ..aOS(5, _omitFieldNames ? '' : 'lastUpdated')
    ..aOS(6, _omitFieldNames ? '' : 'rejectionReason')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetKYCStatusResponse clone() =>
      GetKYCStatusResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetKYCStatusResponse copyWith(void Function(GetKYCStatusResponse) updates) =>
      super.copyWith((message) => updates(message as GetKYCStatusResponse))
          as GetKYCStatusResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetKYCStatusResponse create() => GetKYCStatusResponse._();
  @$core.override
  GetKYCStatusResponse createEmptyInstance() => create();
  static $pb.PbList<GetKYCStatusResponse> createRepeated() =>
      $pb.PbList<GetKYCStatusResponse>();
  @$core.pragma('dart2js:noInline')
  static GetKYCStatusResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetKYCStatusResponse>(create);
  static GetKYCStatusResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  KYCVerificationStatus get status => $_getN(1);
  @$pb.TagNumber(2)
  set status(KYCVerificationStatus value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => $_clearField(2);

  @$pb.TagNumber(3)
  KYCTier get currentTier => $_getN(2);
  @$pb.TagNumber(3)
  set currentTier(KYCTier value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasCurrentTier() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrentTier() => $_clearField(3);

  @$pb.TagNumber(4)
  $pb.PbList<KYCTierInfo> get tierInfo => $_getList(3);

  @$pb.TagNumber(5)
  $core.String get lastUpdated => $_getSZ(4);
  @$pb.TagNumber(5)
  set lastUpdated($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasLastUpdated() => $_has(4);
  @$pb.TagNumber(5)
  void clearLastUpdated() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get rejectionReason => $_getSZ(5);
  @$pb.TagNumber(6)
  set rejectionReason($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasRejectionReason() => $_has(5);
  @$pb.TagNumber(6)
  void clearRejectionReason() => $_clearField(6);
}

/// Country KYC requirements
class CountryKYCRequirements extends $pb.GeneratedMessage {
  factory CountryKYCRequirements({
    $core.String? countryCode,
    $core.Iterable<IdentityType>? acceptedIdTypes,
    $core.Iterable<IdentityType>? mandatoryIdTypes,
    $core.bool? addressProofRequired,
    $core.bool? livenessCheckRequired,
    $fixnum.Int64? tier1DailyLimit,
    $fixnum.Int64? tier2DailyLimit,
    $fixnum.Int64? tier3DailyLimit,
  }) {
    final result = create();
    if (countryCode != null) result.countryCode = countryCode;
    if (acceptedIdTypes != null) result.acceptedIdTypes.addAll(acceptedIdTypes);
    if (mandatoryIdTypes != null)
      result.mandatoryIdTypes.addAll(mandatoryIdTypes);
    if (addressProofRequired != null)
      result.addressProofRequired = addressProofRequired;
    if (livenessCheckRequired != null)
      result.livenessCheckRequired = livenessCheckRequired;
    if (tier1DailyLimit != null) result.tier1DailyLimit = tier1DailyLimit;
    if (tier2DailyLimit != null) result.tier2DailyLimit = tier2DailyLimit;
    if (tier3DailyLimit != null) result.tier3DailyLimit = tier3DailyLimit;
    return result;
  }

  CountryKYCRequirements._();

  factory CountryKYCRequirements.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CountryKYCRequirements.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CountryKYCRequirements',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'countryCode')
    ..pc<IdentityType>(
        2, _omitFieldNames ? '' : 'acceptedIdTypes', $pb.PbFieldType.KE,
        valueOf: IdentityType.valueOf,
        enumValues: IdentityType.values,
        defaultEnumValue: IdentityType.IDENTITY_TYPE_UNSPECIFIED)
    ..pc<IdentityType>(
        3, _omitFieldNames ? '' : 'mandatoryIdTypes', $pb.PbFieldType.KE,
        valueOf: IdentityType.valueOf,
        enumValues: IdentityType.values,
        defaultEnumValue: IdentityType.IDENTITY_TYPE_UNSPECIFIED)
    ..aOB(4, _omitFieldNames ? '' : 'addressProofRequired')
    ..aOB(5, _omitFieldNames ? '' : 'livenessCheckRequired')
    ..aInt64(6, _omitFieldNames ? '' : 'tier1DailyLimit',
        protoName: 'tier_1_daily_limit')
    ..aInt64(7, _omitFieldNames ? '' : 'tier2DailyLimit',
        protoName: 'tier_2_daily_limit')
    ..aInt64(8, _omitFieldNames ? '' : 'tier3DailyLimit',
        protoName: 'tier_3_daily_limit')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CountryKYCRequirements clone() =>
      CountryKYCRequirements()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CountryKYCRequirements copyWith(
          void Function(CountryKYCRequirements) updates) =>
      super.copyWith((message) => updates(message as CountryKYCRequirements))
          as CountryKYCRequirements;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CountryKYCRequirements create() => CountryKYCRequirements._();
  @$core.override
  CountryKYCRequirements createEmptyInstance() => create();
  static $pb.PbList<CountryKYCRequirements> createRepeated() =>
      $pb.PbList<CountryKYCRequirements>();
  @$core.pragma('dart2js:noInline')
  static CountryKYCRequirements getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CountryKYCRequirements>(create);
  static CountryKYCRequirements? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get countryCode => $_getSZ(0);
  @$pb.TagNumber(1)
  set countryCode($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCountryCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearCountryCode() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<IdentityType> get acceptedIdTypes => $_getList(1);

  @$pb.TagNumber(3)
  $pb.PbList<IdentityType> get mandatoryIdTypes => $_getList(2);

  @$pb.TagNumber(4)
  $core.bool get addressProofRequired => $_getBF(3);
  @$pb.TagNumber(4)
  set addressProofRequired($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAddressProofRequired() => $_has(3);
  @$pb.TagNumber(4)
  void clearAddressProofRequired() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.bool get livenessCheckRequired => $_getBF(4);
  @$pb.TagNumber(5)
  set livenessCheckRequired($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasLivenessCheckRequired() => $_has(4);
  @$pb.TagNumber(5)
  void clearLivenessCheckRequired() => $_clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get tier1DailyLimit => $_getI64(5);
  @$pb.TagNumber(6)
  set tier1DailyLimit($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasTier1DailyLimit() => $_has(5);
  @$pb.TagNumber(6)
  void clearTier1DailyLimit() => $_clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get tier2DailyLimit => $_getI64(6);
  @$pb.TagNumber(7)
  set tier2DailyLimit($fixnum.Int64 value) => $_setInt64(6, value);
  @$pb.TagNumber(7)
  $core.bool hasTier2DailyLimit() => $_has(6);
  @$pb.TagNumber(7)
  void clearTier2DailyLimit() => $_clearField(7);

  @$pb.TagNumber(8)
  $fixnum.Int64 get tier3DailyLimit => $_getI64(7);
  @$pb.TagNumber(8)
  set tier3DailyLimit($fixnum.Int64 value) => $_setInt64(7, value);
  @$pb.TagNumber(8)
  $core.bool hasTier3DailyLimit() => $_has(7);
  @$pb.TagNumber(8)
  void clearTier3DailyLimit() => $_clearField(8);
}

/// Get country requirements request
class GetCountryRequirementsRequest extends $pb.GeneratedMessage {
  factory GetCountryRequirementsRequest({
    $core.String? countryCode,
  }) {
    final result = create();
    if (countryCode != null) result.countryCode = countryCode;
    return result;
  }

  GetCountryRequirementsRequest._();

  factory GetCountryRequirementsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetCountryRequirementsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetCountryRequirementsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'countryCode')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCountryRequirementsRequest clone() =>
      GetCountryRequirementsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCountryRequirementsRequest copyWith(
          void Function(GetCountryRequirementsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetCountryRequirementsRequest))
          as GetCountryRequirementsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCountryRequirementsRequest create() =>
      GetCountryRequirementsRequest._();
  @$core.override
  GetCountryRequirementsRequest createEmptyInstance() => create();
  static $pb.PbList<GetCountryRequirementsRequest> createRepeated() =>
      $pb.PbList<GetCountryRequirementsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetCountryRequirementsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetCountryRequirementsRequest>(create);
  static GetCountryRequirementsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get countryCode => $_getSZ(0);
  @$pb.TagNumber(1)
  set countryCode($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCountryCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearCountryCode() => $_clearField(1);
}

/// Get country requirements response
class GetCountryRequirementsResponse extends $pb.GeneratedMessage {
  factory GetCountryRequirementsResponse({
    $core.bool? success,
    CountryKYCRequirements? requirements,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (requirements != null) result.requirements = requirements;
    return result;
  }

  GetCountryRequirementsResponse._();

  factory GetCountryRequirementsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetCountryRequirementsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetCountryRequirementsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOM<CountryKYCRequirements>(2, _omitFieldNames ? '' : 'requirements',
        subBuilder: CountryKYCRequirements.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCountryRequirementsResponse clone() =>
      GetCountryRequirementsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCountryRequirementsResponse copyWith(
          void Function(GetCountryRequirementsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetCountryRequirementsResponse))
          as GetCountryRequirementsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCountryRequirementsResponse create() =>
      GetCountryRequirementsResponse._();
  @$core.override
  GetCountryRequirementsResponse createEmptyInstance() => create();
  static $pb.PbList<GetCountryRequirementsResponse> createRepeated() =>
      $pb.PbList<GetCountryRequirementsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetCountryRequirementsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetCountryRequirementsResponse>(create);
  static GetCountryRequirementsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  CountryKYCRequirements get requirements => $_getN(1);
  @$pb.TagNumber(2)
  set requirements(CountryKYCRequirements value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasRequirements() => $_has(1);
  @$pb.TagNumber(2)
  void clearRequirements() => $_clearField(2);
  @$pb.TagNumber(2)
  CountryKYCRequirements ensureRequirements() => $_ensure(1);
}

/// Create verification session request (async provider flow)
class CreateVerificationSessionRequest extends $pb.GeneratedMessage {
  factory CreateVerificationSessionRequest({
    KYCTier? targetTier,
    $core.String? countryCode,
    IdentityType? idType,
    $core.String? idNumber,
    $core.String? firstName,
    $core.String? lastName,
    $core.String? dateOfBirth,
    $core.String? phoneNumber,
  }) {
    final result = create();
    if (targetTier != null) result.targetTier = targetTier;
    if (countryCode != null) result.countryCode = countryCode;
    if (idType != null) result.idType = idType;
    if (idNumber != null) result.idNumber = idNumber;
    if (firstName != null) result.firstName = firstName;
    if (lastName != null) result.lastName = lastName;
    if (dateOfBirth != null) result.dateOfBirth = dateOfBirth;
    if (phoneNumber != null) result.phoneNumber = phoneNumber;
    return result;
  }

  CreateVerificationSessionRequest._();

  factory CreateVerificationSessionRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateVerificationSessionRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateVerificationSessionRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..e<KYCTier>(1, _omitFieldNames ? '' : 'targetTier', $pb.PbFieldType.OE,
        defaultOrMaker: KYCTier.KYC_TIER_UNKNOWN,
        valueOf: KYCTier.valueOf,
        enumValues: KYCTier.values)
    ..aOS(2, _omitFieldNames ? '' : 'countryCode')
    ..e<IdentityType>(3, _omitFieldNames ? '' : 'idType', $pb.PbFieldType.OE,
        defaultOrMaker: IdentityType.IDENTITY_TYPE_UNSPECIFIED,
        valueOf: IdentityType.valueOf,
        enumValues: IdentityType.values)
    ..aOS(4, _omitFieldNames ? '' : 'idNumber')
    ..aOS(5, _omitFieldNames ? '' : 'firstName')
    ..aOS(6, _omitFieldNames ? '' : 'lastName')
    ..aOS(7, _omitFieldNames ? '' : 'dateOfBirth')
    ..aOS(8, _omitFieldNames ? '' : 'phoneNumber')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateVerificationSessionRequest clone() =>
      CreateVerificationSessionRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateVerificationSessionRequest copyWith(
          void Function(CreateVerificationSessionRequest) updates) =>
      super.copyWith(
              (message) => updates(message as CreateVerificationSessionRequest))
          as CreateVerificationSessionRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateVerificationSessionRequest create() =>
      CreateVerificationSessionRequest._();
  @$core.override
  CreateVerificationSessionRequest createEmptyInstance() => create();
  static $pb.PbList<CreateVerificationSessionRequest> createRepeated() =>
      $pb.PbList<CreateVerificationSessionRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateVerificationSessionRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateVerificationSessionRequest>(
          create);
  static CreateVerificationSessionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  KYCTier get targetTier => $_getN(0);
  @$pb.TagNumber(1)
  set targetTier(KYCTier value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasTargetTier() => $_has(0);
  @$pb.TagNumber(1)
  void clearTargetTier() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get countryCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set countryCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCountryCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearCountryCode() => $_clearField(2);

  @$pb.TagNumber(3)
  IdentityType get idType => $_getN(2);
  @$pb.TagNumber(3)
  set idType(IdentityType value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasIdType() => $_has(2);
  @$pb.TagNumber(3)
  void clearIdType() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get idNumber => $_getSZ(3);
  @$pb.TagNumber(4)
  set idNumber($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasIdNumber() => $_has(3);
  @$pb.TagNumber(4)
  void clearIdNumber() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get firstName => $_getSZ(4);
  @$pb.TagNumber(5)
  set firstName($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasFirstName() => $_has(4);
  @$pb.TagNumber(5)
  void clearFirstName() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get lastName => $_getSZ(5);
  @$pb.TagNumber(6)
  set lastName($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasLastName() => $_has(5);
  @$pb.TagNumber(6)
  void clearLastName() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get dateOfBirth => $_getSZ(6);
  @$pb.TagNumber(7)
  set dateOfBirth($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasDateOfBirth() => $_has(6);
  @$pb.TagNumber(7)
  void clearDateOfBirth() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get phoneNumber => $_getSZ(7);
  @$pb.TagNumber(8)
  set phoneNumber($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasPhoneNumber() => $_has(7);
  @$pb.TagNumber(8)
  void clearPhoneNumber() => $_clearField(8);
}

/// Create verification session response
class CreateVerificationSessionResponse extends $pb.GeneratedMessage {
  factory CreateVerificationSessionResponse({
    $core.bool? success,
    $core.String? verificationId,
    $core.String? sessionUrl,
    $core.String? sessionToken,
    $core.String? provider,
    KYCVerificationStatus? status,
    $core.String? errorMessage,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (verificationId != null) result.verificationId = verificationId;
    if (sessionUrl != null) result.sessionUrl = sessionUrl;
    if (sessionToken != null) result.sessionToken = sessionToken;
    if (provider != null) result.provider = provider;
    if (status != null) result.status = status;
    if (errorMessage != null) result.errorMessage = errorMessage;
    return result;
  }

  CreateVerificationSessionResponse._();

  factory CreateVerificationSessionResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateVerificationSessionResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateVerificationSessionResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'verificationId')
    ..aOS(3, _omitFieldNames ? '' : 'sessionUrl')
    ..aOS(4, _omitFieldNames ? '' : 'sessionToken')
    ..aOS(5, _omitFieldNames ? '' : 'provider')
    ..e<KYCVerificationStatus>(
        6, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: KYCVerificationStatus.KYC_STATUS_UNKNOWN,
        valueOf: KYCVerificationStatus.valueOf,
        enumValues: KYCVerificationStatus.values)
    ..aOS(7, _omitFieldNames ? '' : 'errorMessage')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateVerificationSessionResponse clone() =>
      CreateVerificationSessionResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateVerificationSessionResponse copyWith(
          void Function(CreateVerificationSessionResponse) updates) =>
      super.copyWith((message) =>
              updates(message as CreateVerificationSessionResponse))
          as CreateVerificationSessionResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateVerificationSessionResponse create() =>
      CreateVerificationSessionResponse._();
  @$core.override
  CreateVerificationSessionResponse createEmptyInstance() => create();
  static $pb.PbList<CreateVerificationSessionResponse> createRepeated() =>
      $pb.PbList<CreateVerificationSessionResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateVerificationSessionResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateVerificationSessionResponse>(
          create);
  static CreateVerificationSessionResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get verificationId => $_getSZ(1);
  @$pb.TagNumber(2)
  set verificationId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasVerificationId() => $_has(1);
  @$pb.TagNumber(2)
  void clearVerificationId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get sessionUrl => $_getSZ(2);
  @$pb.TagNumber(3)
  set sessionUrl($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSessionUrl() => $_has(2);
  @$pb.TagNumber(3)
  void clearSessionUrl() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get sessionToken => $_getSZ(3);
  @$pb.TagNumber(4)
  set sessionToken($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasSessionToken() => $_has(3);
  @$pb.TagNumber(4)
  void clearSessionToken() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get provider => $_getSZ(4);
  @$pb.TagNumber(5)
  set provider($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasProvider() => $_has(4);
  @$pb.TagNumber(5)
  void clearProvider() => $_clearField(5);

  @$pb.TagNumber(6)
  KYCVerificationStatus get status => $_getN(5);
  @$pb.TagNumber(6)
  set status(KYCVerificationStatus value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasStatus() => $_has(5);
  @$pb.TagNumber(6)
  void clearStatus() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get errorMessage => $_getSZ(6);
  @$pb.TagNumber(7)
  set errorMessage($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasErrorMessage() => $_has(6);
  @$pb.TagNumber(7)
  void clearErrorMessage() => $_clearField(7);
}

/// Confirm verification request (after SDK/WebView completion)
class ConfirmVerificationRequest extends $pb.GeneratedMessage {
  factory ConfirmVerificationRequest({
    $core.String? verificationId,
    $core.String? provider,
    $core.String? providerAuthCode,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? metadata,
  }) {
    final result = create();
    if (verificationId != null) result.verificationId = verificationId;
    if (provider != null) result.provider = provider;
    if (providerAuthCode != null) result.providerAuthCode = providerAuthCode;
    if (metadata != null) result.metadata.addEntries(metadata);
    return result;
  }

  ConfirmVerificationRequest._();

  factory ConfirmVerificationRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ConfirmVerificationRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ConfirmVerificationRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'verificationId')
    ..aOS(2, _omitFieldNames ? '' : 'provider')
    ..aOS(3, _omitFieldNames ? '' : 'providerAuthCode')
    ..m<$core.String, $core.String>(4, _omitFieldNames ? '' : 'metadata',
        entryClassName: 'ConfirmVerificationRequest.MetadataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('auth'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ConfirmVerificationRequest clone() =>
      ConfirmVerificationRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ConfirmVerificationRequest copyWith(
          void Function(ConfirmVerificationRequest) updates) =>
      super.copyWith(
              (message) => updates(message as ConfirmVerificationRequest))
          as ConfirmVerificationRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ConfirmVerificationRequest create() => ConfirmVerificationRequest._();
  @$core.override
  ConfirmVerificationRequest createEmptyInstance() => create();
  static $pb.PbList<ConfirmVerificationRequest> createRepeated() =>
      $pb.PbList<ConfirmVerificationRequest>();
  @$core.pragma('dart2js:noInline')
  static ConfirmVerificationRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ConfirmVerificationRequest>(create);
  static ConfirmVerificationRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get verificationId => $_getSZ(0);
  @$pb.TagNumber(1)
  set verificationId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasVerificationId() => $_has(0);
  @$pb.TagNumber(1)
  void clearVerificationId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get provider => $_getSZ(1);
  @$pb.TagNumber(2)
  set provider($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasProvider() => $_has(1);
  @$pb.TagNumber(2)
  void clearProvider() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get providerAuthCode => $_getSZ(2);
  @$pb.TagNumber(3)
  set providerAuthCode($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasProviderAuthCode() => $_has(2);
  @$pb.TagNumber(3)
  void clearProviderAuthCode() => $_clearField(3);

  @$pb.TagNumber(4)
  $pb.PbMap<$core.String, $core.String> get metadata => $_getMap(3);
}

/// Confirm verification response
class ConfirmVerificationResponse extends $pb.GeneratedMessage {
  factory ConfirmVerificationResponse({
    $core.bool? success,
    KYCVerificationStatus? status,
    KYCTier? currentTier,
    $core.String? message,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (status != null) result.status = status;
    if (currentTier != null) result.currentTier = currentTier;
    if (message != null) result.message = message;
    return result;
  }

  ConfirmVerificationResponse._();

  factory ConfirmVerificationResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ConfirmVerificationResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ConfirmVerificationResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..e<KYCVerificationStatus>(
        2, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: KYCVerificationStatus.KYC_STATUS_UNKNOWN,
        valueOf: KYCVerificationStatus.valueOf,
        enumValues: KYCVerificationStatus.values)
    ..e<KYCTier>(3, _omitFieldNames ? '' : 'currentTier', $pb.PbFieldType.OE,
        defaultOrMaker: KYCTier.KYC_TIER_UNKNOWN,
        valueOf: KYCTier.valueOf,
        enumValues: KYCTier.values)
    ..aOS(4, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ConfirmVerificationResponse clone() =>
      ConfirmVerificationResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ConfirmVerificationResponse copyWith(
          void Function(ConfirmVerificationResponse) updates) =>
      super.copyWith(
              (message) => updates(message as ConfirmVerificationResponse))
          as ConfirmVerificationResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ConfirmVerificationResponse create() =>
      ConfirmVerificationResponse._();
  @$core.override
  ConfirmVerificationResponse createEmptyInstance() => create();
  static $pb.PbList<ConfirmVerificationResponse> createRepeated() =>
      $pb.PbList<ConfirmVerificationResponse>();
  @$core.pragma('dart2js:noInline')
  static ConfirmVerificationResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ConfirmVerificationResponse>(create);
  static ConfirmVerificationResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  KYCVerificationStatus get status => $_getN(1);
  @$pb.TagNumber(2)
  set status(KYCVerificationStatus value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => $_clearField(2);

  @$pb.TagNumber(3)
  KYCTier get currentTier => $_getN(2);
  @$pb.TagNumber(3)
  set currentTier(KYCTier value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasCurrentTier() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrentTier() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get message => $_getSZ(3);
  @$pb.TagNumber(4)
  set message($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMessage() => $_has(3);
  @$pb.TagNumber(4)
  void clearMessage() => $_clearField(4);
}

/// Get presigned document upload URL request (Tier 3)
class GetDocumentUploadURLRequest extends $pb.GeneratedMessage {
  factory GetDocumentUploadURLRequest({
    $core.String? documentType,
    $core.String? contentType,
  }) {
    final result = create();
    if (documentType != null) result.documentType = documentType;
    if (contentType != null) result.contentType = contentType;
    return result;
  }

  GetDocumentUploadURLRequest._();

  factory GetDocumentUploadURLRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetDocumentUploadURLRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetDocumentUploadURLRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'documentType')
    ..aOS(2, _omitFieldNames ? '' : 'contentType')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetDocumentUploadURLRequest clone() =>
      GetDocumentUploadURLRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetDocumentUploadURLRequest copyWith(
          void Function(GetDocumentUploadURLRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetDocumentUploadURLRequest))
          as GetDocumentUploadURLRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetDocumentUploadURLRequest create() =>
      GetDocumentUploadURLRequest._();
  @$core.override
  GetDocumentUploadURLRequest createEmptyInstance() => create();
  static $pb.PbList<GetDocumentUploadURLRequest> createRepeated() =>
      $pb.PbList<GetDocumentUploadURLRequest>();
  @$core.pragma('dart2js:noInline')
  static GetDocumentUploadURLRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetDocumentUploadURLRequest>(create);
  static GetDocumentUploadURLRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get documentType => $_getSZ(0);
  @$pb.TagNumber(1)
  set documentType($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDocumentType() => $_has(0);
  @$pb.TagNumber(1)
  void clearDocumentType() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get contentType => $_getSZ(1);
  @$pb.TagNumber(2)
  set contentType($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasContentType() => $_has(1);
  @$pb.TagNumber(2)
  void clearContentType() => $_clearField(2);
}

/// Get presigned document upload URL response
class GetDocumentUploadURLResponse extends $pb.GeneratedMessage {
  factory GetDocumentUploadURLResponse({
    $core.bool? success,
    $core.String? uploadUrl,
    $core.String? storageKey,
    $fixnum.Int64? expiresAt,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (uploadUrl != null) result.uploadUrl = uploadUrl;
    if (storageKey != null) result.storageKey = storageKey;
    if (expiresAt != null) result.expiresAt = expiresAt;
    return result;
  }

  GetDocumentUploadURLResponse._();

  factory GetDocumentUploadURLResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetDocumentUploadURLResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetDocumentUploadURLResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'uploadUrl')
    ..aOS(3, _omitFieldNames ? '' : 'storageKey')
    ..aInt64(4, _omitFieldNames ? '' : 'expiresAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetDocumentUploadURLResponse clone() =>
      GetDocumentUploadURLResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetDocumentUploadURLResponse copyWith(
          void Function(GetDocumentUploadURLResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetDocumentUploadURLResponse))
          as GetDocumentUploadURLResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetDocumentUploadURLResponse create() =>
      GetDocumentUploadURLResponse._();
  @$core.override
  GetDocumentUploadURLResponse createEmptyInstance() => create();
  static $pb.PbList<GetDocumentUploadURLResponse> createRepeated() =>
      $pb.PbList<GetDocumentUploadURLResponse>();
  @$core.pragma('dart2js:noInline')
  static GetDocumentUploadURLResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetDocumentUploadURLResponse>(create);
  static GetDocumentUploadURLResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get uploadUrl => $_getSZ(1);
  @$pb.TagNumber(2)
  set uploadUrl($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUploadUrl() => $_has(1);
  @$pb.TagNumber(2)
  void clearUploadUrl() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get storageKey => $_getSZ(2);
  @$pb.TagNumber(3)
  set storageKey($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasStorageKey() => $_has(2);
  @$pb.TagNumber(3)
  void clearStorageKey() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get expiresAt => $_getI64(3);
  @$pb.TagNumber(4)
  set expiresAt($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasExpiresAt() => $_has(3);
  @$pb.TagNumber(4)
  void clearExpiresAt() => $_clearField(4);
}

/// Document submission item for batch review
class DocumentSubmissionItem extends $pb.GeneratedMessage {
  factory DocumentSubmissionItem({
    $core.String? storageKey,
    $core.String? documentType,
    $core.String? contentType,
  }) {
    final result = create();
    if (storageKey != null) result.storageKey = storageKey;
    if (documentType != null) result.documentType = documentType;
    if (contentType != null) result.contentType = contentType;
    return result;
  }

  DocumentSubmissionItem._();

  factory DocumentSubmissionItem.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DocumentSubmissionItem.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DocumentSubmissionItem',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'storageKey')
    ..aOS(2, _omitFieldNames ? '' : 'documentType')
    ..aOS(3, _omitFieldNames ? '' : 'contentType')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DocumentSubmissionItem clone() =>
      DocumentSubmissionItem()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DocumentSubmissionItem copyWith(
          void Function(DocumentSubmissionItem) updates) =>
      super.copyWith((message) => updates(message as DocumentSubmissionItem))
          as DocumentSubmissionItem;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DocumentSubmissionItem create() => DocumentSubmissionItem._();
  @$core.override
  DocumentSubmissionItem createEmptyInstance() => create();
  static $pb.PbList<DocumentSubmissionItem> createRepeated() =>
      $pb.PbList<DocumentSubmissionItem>();
  @$core.pragma('dart2js:noInline')
  static DocumentSubmissionItem getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DocumentSubmissionItem>(create);
  static DocumentSubmissionItem? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get storageKey => $_getSZ(0);
  @$pb.TagNumber(1)
  set storageKey($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasStorageKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearStorageKey() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get documentType => $_getSZ(1);
  @$pb.TagNumber(2)
  set documentType($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDocumentType() => $_has(1);
  @$pb.TagNumber(2)
  void clearDocumentType() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get contentType => $_getSZ(2);
  @$pb.TagNumber(3)
  set contentType($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasContentType() => $_has(2);
  @$pb.TagNumber(3)
  void clearContentType() => $_clearField(3);
}

/// Submit documents for review request (Tier 3)
class SubmitDocumentsForReviewRequest extends $pb.GeneratedMessage {
  factory SubmitDocumentsForReviewRequest({
    $core.Iterable<DocumentSubmissionItem>? documents,
  }) {
    final result = create();
    if (documents != null) result.documents.addAll(documents);
    return result;
  }

  SubmitDocumentsForReviewRequest._();

  factory SubmitDocumentsForReviewRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SubmitDocumentsForReviewRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SubmitDocumentsForReviewRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..pc<DocumentSubmissionItem>(
        1, _omitFieldNames ? '' : 'documents', $pb.PbFieldType.PM,
        subBuilder: DocumentSubmissionItem.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubmitDocumentsForReviewRequest clone() =>
      SubmitDocumentsForReviewRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubmitDocumentsForReviewRequest copyWith(
          void Function(SubmitDocumentsForReviewRequest) updates) =>
      super.copyWith(
              (message) => updates(message as SubmitDocumentsForReviewRequest))
          as SubmitDocumentsForReviewRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SubmitDocumentsForReviewRequest create() =>
      SubmitDocumentsForReviewRequest._();
  @$core.override
  SubmitDocumentsForReviewRequest createEmptyInstance() => create();
  static $pb.PbList<SubmitDocumentsForReviewRequest> createRepeated() =>
      $pb.PbList<SubmitDocumentsForReviewRequest>();
  @$core.pragma('dart2js:noInline')
  static SubmitDocumentsForReviewRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SubmitDocumentsForReviewRequest>(
          create);
  static SubmitDocumentsForReviewRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<DocumentSubmissionItem> get documents => $_getList(0);
}

/// Submit documents for review response
class SubmitDocumentsForReviewResponse extends $pb.GeneratedMessage {
  factory SubmitDocumentsForReviewResponse({
    $core.bool? success,
    $core.String? message,
    KYCVerificationStatus? status,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (status != null) result.status = status;
    return result;
  }

  SubmitDocumentsForReviewResponse._();

  factory SubmitDocumentsForReviewResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SubmitDocumentsForReviewResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SubmitDocumentsForReviewResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..e<KYCVerificationStatus>(
        3, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: KYCVerificationStatus.KYC_STATUS_UNKNOWN,
        valueOf: KYCVerificationStatus.valueOf,
        enumValues: KYCVerificationStatus.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubmitDocumentsForReviewResponse clone() =>
      SubmitDocumentsForReviewResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SubmitDocumentsForReviewResponse copyWith(
          void Function(SubmitDocumentsForReviewResponse) updates) =>
      super.copyWith(
              (message) => updates(message as SubmitDocumentsForReviewResponse))
          as SubmitDocumentsForReviewResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SubmitDocumentsForReviewResponse create() =>
      SubmitDocumentsForReviewResponse._();
  @$core.override
  SubmitDocumentsForReviewResponse createEmptyInstance() => create();
  static $pb.PbList<SubmitDocumentsForReviewResponse> createRepeated() =>
      $pb.PbList<SubmitDocumentsForReviewResponse>();
  @$core.pragma('dart2js:noInline')
  static SubmitDocumentsForReviewResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SubmitDocumentsForReviewResponse>(
          create);
  static SubmitDocumentsForReviewResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);

  @$pb.TagNumber(3)
  KYCVerificationStatus get status => $_getN(2);
  @$pb.TagNumber(3)
  set status(KYCVerificationStatus value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatus() => $_clearField(3);
}

/// Channel login request - authenticate via phone number
class ChannelLoginRequest extends $pb.GeneratedMessage {
  factory ChannelLoginRequest({
    $core.String? phoneNumber,
    $core.String? channelType,
  }) {
    final result = create();
    if (phoneNumber != null) result.phoneNumber = phoneNumber;
    if (channelType != null) result.channelType = channelType;
    return result;
  }

  ChannelLoginRequest._();

  factory ChannelLoginRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ChannelLoginRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChannelLoginRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'phoneNumber')
    ..aOS(2, _omitFieldNames ? '' : 'channelType')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChannelLoginRequest clone() => ChannelLoginRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChannelLoginRequest copyWith(void Function(ChannelLoginRequest) updates) =>
      super.copyWith((message) => updates(message as ChannelLoginRequest))
          as ChannelLoginRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChannelLoginRequest create() => ChannelLoginRequest._();
  @$core.override
  ChannelLoginRequest createEmptyInstance() => create();
  static $pb.PbList<ChannelLoginRequest> createRepeated() =>
      $pb.PbList<ChannelLoginRequest>();
  @$core.pragma('dart2js:noInline')
  static ChannelLoginRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ChannelLoginRequest>(create);
  static ChannelLoginRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get phoneNumber => $_getSZ(0);
  @$pb.TagNumber(1)
  set phoneNumber($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPhoneNumber() => $_has(0);
  @$pb.TagNumber(1)
  void clearPhoneNumber() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get channelType => $_getSZ(1);
  @$pb.TagNumber(2)
  set channelType($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasChannelType() => $_has(1);
  @$pb.TagNumber(2)
  void clearChannelType() => $_clearField(2);
}

/// Channel login response - returns access token for channel operations
class ChannelLoginResponse extends $pb.GeneratedMessage {
  factory ChannelLoginResponse({
    $core.bool? success,
    $core.String? message,
    $core.String? accessToken,
    $core.String? refreshToken,
    $core.String? userId,
    $core.String? accountId,
    $core.String? currency,
    $core.String? userCountry,
    $core.int? expiresIn,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (accessToken != null) result.accessToken = accessToken;
    if (refreshToken != null) result.refreshToken = refreshToken;
    if (userId != null) result.userId = userId;
    if (accountId != null) result.accountId = accountId;
    if (currency != null) result.currency = currency;
    if (userCountry != null) result.userCountry = userCountry;
    if (expiresIn != null) result.expiresIn = expiresIn;
    return result;
  }

  ChannelLoginResponse._();

  factory ChannelLoginResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ChannelLoginResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChannelLoginResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOS(3, _omitFieldNames ? '' : 'accessToken')
    ..aOS(4, _omitFieldNames ? '' : 'refreshToken')
    ..aOS(5, _omitFieldNames ? '' : 'userId')
    ..aOS(6, _omitFieldNames ? '' : 'accountId')
    ..aOS(7, _omitFieldNames ? '' : 'currency')
    ..aOS(8, _omitFieldNames ? '' : 'userCountry')
    ..a<$core.int>(9, _omitFieldNames ? '' : 'expiresIn', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChannelLoginResponse clone() =>
      ChannelLoginResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChannelLoginResponse copyWith(void Function(ChannelLoginResponse) updates) =>
      super.copyWith((message) => updates(message as ChannelLoginResponse))
          as ChannelLoginResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChannelLoginResponse create() => ChannelLoginResponse._();
  @$core.override
  ChannelLoginResponse createEmptyInstance() => create();
  static $pb.PbList<ChannelLoginResponse> createRepeated() =>
      $pb.PbList<ChannelLoginResponse>();
  @$core.pragma('dart2js:noInline')
  static ChannelLoginResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ChannelLoginResponse>(create);
  static ChannelLoginResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get accessToken => $_getSZ(2);
  @$pb.TagNumber(3)
  set accessToken($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAccessToken() => $_has(2);
  @$pb.TagNumber(3)
  void clearAccessToken() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get refreshToken => $_getSZ(3);
  @$pb.TagNumber(4)
  set refreshToken($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasRefreshToken() => $_has(3);
  @$pb.TagNumber(4)
  void clearRefreshToken() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get userId => $_getSZ(4);
  @$pb.TagNumber(5)
  set userId($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasUserId() => $_has(4);
  @$pb.TagNumber(5)
  void clearUserId() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get accountId => $_getSZ(5);
  @$pb.TagNumber(6)
  set accountId($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasAccountId() => $_has(5);
  @$pb.TagNumber(6)
  void clearAccountId() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get currency => $_getSZ(6);
  @$pb.TagNumber(7)
  set currency($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasCurrency() => $_has(6);
  @$pb.TagNumber(7)
  void clearCurrency() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get userCountry => $_getSZ(7);
  @$pb.TagNumber(8)
  set userCountry($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasUserCountry() => $_has(7);
  @$pb.TagNumber(8)
  void clearUserCountry() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.int get expiresIn => $_getIZ(8);
  @$pb.TagNumber(9)
  set expiresIn($core.int value) => $_setSignedInt32(8, value);
  @$pb.TagNumber(9)
  $core.bool hasExpiresIn() => $_has(8);
  @$pb.TagNumber(9)
  void clearExpiresIn() => $_clearField(9);
}

/// Channel register request - register new user via phone channel
class ChannelRegisterRequest extends $pb.GeneratedMessage {
  factory ChannelRegisterRequest({
    $core.String? phoneNumber,
    $core.String? firstName,
    $core.String? lastName,
    $core.String? email,
    $core.String? channelType,
    $core.String? countryCode,
  }) {
    final result = create();
    if (phoneNumber != null) result.phoneNumber = phoneNumber;
    if (firstName != null) result.firstName = firstName;
    if (lastName != null) result.lastName = lastName;
    if (email != null) result.email = email;
    if (channelType != null) result.channelType = channelType;
    if (countryCode != null) result.countryCode = countryCode;
    return result;
  }

  ChannelRegisterRequest._();

  factory ChannelRegisterRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ChannelRegisterRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChannelRegisterRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'phoneNumber')
    ..aOS(2, _omitFieldNames ? '' : 'firstName')
    ..aOS(3, _omitFieldNames ? '' : 'lastName')
    ..aOS(4, _omitFieldNames ? '' : 'email')
    ..aOS(5, _omitFieldNames ? '' : 'channelType')
    ..aOS(6, _omitFieldNames ? '' : 'countryCode')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChannelRegisterRequest clone() =>
      ChannelRegisterRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChannelRegisterRequest copyWith(
          void Function(ChannelRegisterRequest) updates) =>
      super.copyWith((message) => updates(message as ChannelRegisterRequest))
          as ChannelRegisterRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChannelRegisterRequest create() => ChannelRegisterRequest._();
  @$core.override
  ChannelRegisterRequest createEmptyInstance() => create();
  static $pb.PbList<ChannelRegisterRequest> createRepeated() =>
      $pb.PbList<ChannelRegisterRequest>();
  @$core.pragma('dart2js:noInline')
  static ChannelRegisterRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ChannelRegisterRequest>(create);
  static ChannelRegisterRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get phoneNumber => $_getSZ(0);
  @$pb.TagNumber(1)
  set phoneNumber($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPhoneNumber() => $_has(0);
  @$pb.TagNumber(1)
  void clearPhoneNumber() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get firstName => $_getSZ(1);
  @$pb.TagNumber(2)
  set firstName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasFirstName() => $_has(1);
  @$pb.TagNumber(2)
  void clearFirstName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get lastName => $_getSZ(2);
  @$pb.TagNumber(3)
  set lastName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLastName() => $_has(2);
  @$pb.TagNumber(3)
  void clearLastName() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get email => $_getSZ(3);
  @$pb.TagNumber(4)
  set email($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasEmail() => $_has(3);
  @$pb.TagNumber(4)
  void clearEmail() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get channelType => $_getSZ(4);
  @$pb.TagNumber(5)
  set channelType($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasChannelType() => $_has(4);
  @$pb.TagNumber(5)
  void clearChannelType() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get countryCode => $_getSZ(5);
  @$pb.TagNumber(6)
  set countryCode($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasCountryCode() => $_has(5);
  @$pb.TagNumber(6)
  void clearCountryCode() => $_clearField(6);
}

/// Channel register response - sends OTP to email
class ChannelRegisterResponse extends $pb.GeneratedMessage {
  factory ChannelRegisterResponse({
    $core.bool? success,
    $core.String? message,
    $core.String? userId,
    $core.bool? otpSent,
    $core.String? maskedEmail,
    $core.int? otpExpiresInSeconds,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (userId != null) result.userId = userId;
    if (otpSent != null) result.otpSent = otpSent;
    if (maskedEmail != null) result.maskedEmail = maskedEmail;
    if (otpExpiresInSeconds != null)
      result.otpExpiresInSeconds = otpExpiresInSeconds;
    return result;
  }

  ChannelRegisterResponse._();

  factory ChannelRegisterResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ChannelRegisterResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChannelRegisterResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOS(3, _omitFieldNames ? '' : 'userId')
    ..aOB(4, _omitFieldNames ? '' : 'otpSent')
    ..aOS(5, _omitFieldNames ? '' : 'maskedEmail')
    ..a<$core.int>(
        6, _omitFieldNames ? '' : 'otpExpiresInSeconds', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChannelRegisterResponse clone() =>
      ChannelRegisterResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChannelRegisterResponse copyWith(
          void Function(ChannelRegisterResponse) updates) =>
      super.copyWith((message) => updates(message as ChannelRegisterResponse))
          as ChannelRegisterResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChannelRegisterResponse create() => ChannelRegisterResponse._();
  @$core.override
  ChannelRegisterResponse createEmptyInstance() => create();
  static $pb.PbList<ChannelRegisterResponse> createRepeated() =>
      $pb.PbList<ChannelRegisterResponse>();
  @$core.pragma('dart2js:noInline')
  static ChannelRegisterResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ChannelRegisterResponse>(create);
  static ChannelRegisterResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get userId => $_getSZ(2);
  @$pb.TagNumber(3)
  set userId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasUserId() => $_has(2);
  @$pb.TagNumber(3)
  void clearUserId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.bool get otpSent => $_getBF(3);
  @$pb.TagNumber(4)
  set otpSent($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasOtpSent() => $_has(3);
  @$pb.TagNumber(4)
  void clearOtpSent() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get maskedEmail => $_getSZ(4);
  @$pb.TagNumber(5)
  set maskedEmail($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasMaskedEmail() => $_has(4);
  @$pb.TagNumber(5)
  void clearMaskedEmail() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get otpExpiresInSeconds => $_getIZ(5);
  @$pb.TagNumber(6)
  set otpExpiresInSeconds($core.int value) => $_setSignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasOtpExpiresInSeconds() => $_has(5);
  @$pb.TagNumber(6)
  void clearOtpExpiresInSeconds() => $_clearField(6);
}

/// Channel verify registration request - verify OTP for new account
class ChannelVerifyRegistrationRequest extends $pb.GeneratedMessage {
  factory ChannelVerifyRegistrationRequest({
    $core.String? phoneNumber,
    $core.String? otpCode,
    $core.String? channelType,
  }) {
    final result = create();
    if (phoneNumber != null) result.phoneNumber = phoneNumber;
    if (otpCode != null) result.otpCode = otpCode;
    if (channelType != null) result.channelType = channelType;
    return result;
  }

  ChannelVerifyRegistrationRequest._();

  factory ChannelVerifyRegistrationRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ChannelVerifyRegistrationRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChannelVerifyRegistrationRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'phoneNumber')
    ..aOS(2, _omitFieldNames ? '' : 'otpCode')
    ..aOS(3, _omitFieldNames ? '' : 'channelType')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChannelVerifyRegistrationRequest clone() =>
      ChannelVerifyRegistrationRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChannelVerifyRegistrationRequest copyWith(
          void Function(ChannelVerifyRegistrationRequest) updates) =>
      super.copyWith(
              (message) => updates(message as ChannelVerifyRegistrationRequest))
          as ChannelVerifyRegistrationRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChannelVerifyRegistrationRequest create() =>
      ChannelVerifyRegistrationRequest._();
  @$core.override
  ChannelVerifyRegistrationRequest createEmptyInstance() => create();
  static $pb.PbList<ChannelVerifyRegistrationRequest> createRepeated() =>
      $pb.PbList<ChannelVerifyRegistrationRequest>();
  @$core.pragma('dart2js:noInline')
  static ChannelVerifyRegistrationRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ChannelVerifyRegistrationRequest>(
          create);
  static ChannelVerifyRegistrationRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get phoneNumber => $_getSZ(0);
  @$pb.TagNumber(1)
  set phoneNumber($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPhoneNumber() => $_has(0);
  @$pb.TagNumber(1)
  void clearPhoneNumber() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get otpCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set otpCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasOtpCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearOtpCode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get channelType => $_getSZ(2);
  @$pb.TagNumber(3)
  set channelType($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasChannelType() => $_has(2);
  @$pb.TagNumber(3)
  void clearChannelType() => $_clearField(3);
}

/// Channel verify registration response - activates account and returns tokens
class ChannelVerifyRegistrationResponse extends $pb.GeneratedMessage {
  factory ChannelVerifyRegistrationResponse({
    $core.bool? success,
    $core.String? message,
    $core.String? accessToken,
    $core.String? refreshToken,
    $core.String? userId,
    $core.String? accountId,
    $core.String? currency,
    $core.String? userCountry,
    $core.int? expiresIn,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (accessToken != null) result.accessToken = accessToken;
    if (refreshToken != null) result.refreshToken = refreshToken;
    if (userId != null) result.userId = userId;
    if (accountId != null) result.accountId = accountId;
    if (currency != null) result.currency = currency;
    if (userCountry != null) result.userCountry = userCountry;
    if (expiresIn != null) result.expiresIn = expiresIn;
    return result;
  }

  ChannelVerifyRegistrationResponse._();

  factory ChannelVerifyRegistrationResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ChannelVerifyRegistrationResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChannelVerifyRegistrationResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOS(3, _omitFieldNames ? '' : 'accessToken')
    ..aOS(4, _omitFieldNames ? '' : 'refreshToken')
    ..aOS(5, _omitFieldNames ? '' : 'userId')
    ..aOS(6, _omitFieldNames ? '' : 'accountId')
    ..aOS(7, _omitFieldNames ? '' : 'currency')
    ..aOS(8, _omitFieldNames ? '' : 'userCountry')
    ..a<$core.int>(9, _omitFieldNames ? '' : 'expiresIn', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChannelVerifyRegistrationResponse clone() =>
      ChannelVerifyRegistrationResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChannelVerifyRegistrationResponse copyWith(
          void Function(ChannelVerifyRegistrationResponse) updates) =>
      super.copyWith((message) =>
              updates(message as ChannelVerifyRegistrationResponse))
          as ChannelVerifyRegistrationResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChannelVerifyRegistrationResponse create() =>
      ChannelVerifyRegistrationResponse._();
  @$core.override
  ChannelVerifyRegistrationResponse createEmptyInstance() => create();
  static $pb.PbList<ChannelVerifyRegistrationResponse> createRepeated() =>
      $pb.PbList<ChannelVerifyRegistrationResponse>();
  @$core.pragma('dart2js:noInline')
  static ChannelVerifyRegistrationResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ChannelVerifyRegistrationResponse>(
          create);
  static ChannelVerifyRegistrationResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get accessToken => $_getSZ(2);
  @$pb.TagNumber(3)
  set accessToken($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAccessToken() => $_has(2);
  @$pb.TagNumber(3)
  void clearAccessToken() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get refreshToken => $_getSZ(3);
  @$pb.TagNumber(4)
  set refreshToken($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasRefreshToken() => $_has(3);
  @$pb.TagNumber(4)
  void clearRefreshToken() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get userId => $_getSZ(4);
  @$pb.TagNumber(5)
  set userId($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasUserId() => $_has(4);
  @$pb.TagNumber(5)
  void clearUserId() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get accountId => $_getSZ(5);
  @$pb.TagNumber(6)
  set accountId($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasAccountId() => $_has(5);
  @$pb.TagNumber(6)
  void clearAccountId() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get currency => $_getSZ(6);
  @$pb.TagNumber(7)
  set currency($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasCurrency() => $_has(6);
  @$pb.TagNumber(7)
  void clearCurrency() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get userCountry => $_getSZ(7);
  @$pb.TagNumber(8)
  set userCountry($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasUserCountry() => $_has(7);
  @$pb.TagNumber(8)
  void clearUserCountry() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.int get expiresIn => $_getIZ(8);
  @$pb.TagNumber(9)
  set expiresIn($core.int value) => $_setSignedInt32(8, value);
  @$pb.TagNumber(9)
  $core.bool hasExpiresIn() => $_has(8);
  @$pb.TagNumber(9)
  void clearExpiresIn() => $_clearField(9);
}

/// Admin: Generate token for user by phone number (for telephony voice agents)
class AdminGenerateTokenByPhoneRequest extends $pb.GeneratedMessage {
  factory AdminGenerateTokenByPhoneRequest({
    $core.String? phoneNumber,
    $core.String? adminSecret,
    $core.String? channelType,
  }) {
    final result = create();
    if (phoneNumber != null) result.phoneNumber = phoneNumber;
    if (adminSecret != null) result.adminSecret = adminSecret;
    if (channelType != null) result.channelType = channelType;
    return result;
  }

  AdminGenerateTokenByPhoneRequest._();

  factory AdminGenerateTokenByPhoneRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AdminGenerateTokenByPhoneRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AdminGenerateTokenByPhoneRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'phoneNumber')
    ..aOS(2, _omitFieldNames ? '' : 'adminSecret')
    ..aOS(3, _omitFieldNames ? '' : 'channelType')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminGenerateTokenByPhoneRequest clone() =>
      AdminGenerateTokenByPhoneRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminGenerateTokenByPhoneRequest copyWith(
          void Function(AdminGenerateTokenByPhoneRequest) updates) =>
      super.copyWith(
              (message) => updates(message as AdminGenerateTokenByPhoneRequest))
          as AdminGenerateTokenByPhoneRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminGenerateTokenByPhoneRequest create() =>
      AdminGenerateTokenByPhoneRequest._();
  @$core.override
  AdminGenerateTokenByPhoneRequest createEmptyInstance() => create();
  static $pb.PbList<AdminGenerateTokenByPhoneRequest> createRepeated() =>
      $pb.PbList<AdminGenerateTokenByPhoneRequest>();
  @$core.pragma('dart2js:noInline')
  static AdminGenerateTokenByPhoneRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AdminGenerateTokenByPhoneRequest>(
          create);
  static AdminGenerateTokenByPhoneRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get phoneNumber => $_getSZ(0);
  @$pb.TagNumber(1)
  set phoneNumber($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPhoneNumber() => $_has(0);
  @$pb.TagNumber(1)
  void clearPhoneNumber() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get adminSecret => $_getSZ(1);
  @$pb.TagNumber(2)
  set adminSecret($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAdminSecret() => $_has(1);
  @$pb.TagNumber(2)
  void clearAdminSecret() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get channelType => $_getSZ(2);
  @$pb.TagNumber(3)
  set channelType($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasChannelType() => $_has(2);
  @$pb.TagNumber(3)
  void clearChannelType() => $_clearField(3);
}

class AdminGenerateTokenByPhoneResponse extends $pb.GeneratedMessage {
  factory AdminGenerateTokenByPhoneResponse({
    $core.bool? success,
    $core.String? message,
    $core.String? accessToken,
    $core.String? refreshToken,
    $core.String? userId,
    $core.String? accountId,
    $core.String? currency,
    $core.String? userCountry,
    $core.int? expiresIn,
    $core.bool? userFound,
    $core.String? firstName,
    $core.String? lastName,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (accessToken != null) result.accessToken = accessToken;
    if (refreshToken != null) result.refreshToken = refreshToken;
    if (userId != null) result.userId = userId;
    if (accountId != null) result.accountId = accountId;
    if (currency != null) result.currency = currency;
    if (userCountry != null) result.userCountry = userCountry;
    if (expiresIn != null) result.expiresIn = expiresIn;
    if (userFound != null) result.userFound = userFound;
    if (firstName != null) result.firstName = firstName;
    if (lastName != null) result.lastName = lastName;
    return result;
  }

  AdminGenerateTokenByPhoneResponse._();

  factory AdminGenerateTokenByPhoneResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AdminGenerateTokenByPhoneResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AdminGenerateTokenByPhoneResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'auth'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOS(3, _omitFieldNames ? '' : 'accessToken')
    ..aOS(4, _omitFieldNames ? '' : 'refreshToken')
    ..aOS(5, _omitFieldNames ? '' : 'userId')
    ..aOS(6, _omitFieldNames ? '' : 'accountId')
    ..aOS(7, _omitFieldNames ? '' : 'currency')
    ..aOS(8, _omitFieldNames ? '' : 'userCountry')
    ..a<$core.int>(9, _omitFieldNames ? '' : 'expiresIn', $pb.PbFieldType.O3)
    ..aOB(10, _omitFieldNames ? '' : 'userFound')
    ..aOS(11, _omitFieldNames ? '' : 'firstName')
    ..aOS(12, _omitFieldNames ? '' : 'lastName')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminGenerateTokenByPhoneResponse clone() =>
      AdminGenerateTokenByPhoneResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminGenerateTokenByPhoneResponse copyWith(
          void Function(AdminGenerateTokenByPhoneResponse) updates) =>
      super.copyWith((message) =>
              updates(message as AdminGenerateTokenByPhoneResponse))
          as AdminGenerateTokenByPhoneResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminGenerateTokenByPhoneResponse create() =>
      AdminGenerateTokenByPhoneResponse._();
  @$core.override
  AdminGenerateTokenByPhoneResponse createEmptyInstance() => create();
  static $pb.PbList<AdminGenerateTokenByPhoneResponse> createRepeated() =>
      $pb.PbList<AdminGenerateTokenByPhoneResponse>();
  @$core.pragma('dart2js:noInline')
  static AdminGenerateTokenByPhoneResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AdminGenerateTokenByPhoneResponse>(
          create);
  static AdminGenerateTokenByPhoneResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get accessToken => $_getSZ(2);
  @$pb.TagNumber(3)
  set accessToken($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAccessToken() => $_has(2);
  @$pb.TagNumber(3)
  void clearAccessToken() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get refreshToken => $_getSZ(3);
  @$pb.TagNumber(4)
  set refreshToken($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasRefreshToken() => $_has(3);
  @$pb.TagNumber(4)
  void clearRefreshToken() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get userId => $_getSZ(4);
  @$pb.TagNumber(5)
  set userId($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasUserId() => $_has(4);
  @$pb.TagNumber(5)
  void clearUserId() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get accountId => $_getSZ(5);
  @$pb.TagNumber(6)
  set accountId($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasAccountId() => $_has(5);
  @$pb.TagNumber(6)
  void clearAccountId() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get currency => $_getSZ(6);
  @$pb.TagNumber(7)
  set currency($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasCurrency() => $_has(6);
  @$pb.TagNumber(7)
  void clearCurrency() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get userCountry => $_getSZ(7);
  @$pb.TagNumber(8)
  set userCountry($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasUserCountry() => $_has(7);
  @$pb.TagNumber(8)
  void clearUserCountry() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.int get expiresIn => $_getIZ(8);
  @$pb.TagNumber(9)
  set expiresIn($core.int value) => $_setSignedInt32(8, value);
  @$pb.TagNumber(9)
  $core.bool hasExpiresIn() => $_has(8);
  @$pb.TagNumber(9)
  void clearExpiresIn() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.bool get userFound => $_getBF(9);
  @$pb.TagNumber(10)
  set userFound($core.bool value) => $_setBool(9, value);
  @$pb.TagNumber(10)
  $core.bool hasUserFound() => $_has(9);
  @$pb.TagNumber(10)
  void clearUserFound() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get firstName => $_getSZ(10);
  @$pb.TagNumber(11)
  set firstName($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasFirstName() => $_has(10);
  @$pb.TagNumber(11)
  void clearFirstName() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get lastName => $_getSZ(11);
  @$pb.TagNumber(12)
  set lastName($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasLastName() => $_has(11);
  @$pb.TagNumber(12)
  void clearLastName() => $_clearField(12);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
