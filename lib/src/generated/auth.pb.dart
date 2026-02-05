///
//  Generated code. Do not modify.
//  source: auth.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'auth.pbenum.dart';

export 'auth.pbenum.dart';

class SignupRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SignupRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'email')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'password')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'firstName')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lastName')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'phone')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'deviceId')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'deviceName')
    ..e<PrimaryContactType>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'primaryContactType', $pb.PbFieldType.OE, defaultOrMaker: PrimaryContactType.EMAIL, valueOf: PrimaryContactType.valueOf, enumValues: PrimaryContactType.values)
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'username')
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'referralCode')
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dateOfBirth')
    ..aOS(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'locale')
    ..aOS(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bvn')
    ..aOS(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'nin')
    ..aOS(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'countryCode')
    ..aOS(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currencyCode')
    ..hasRequiredFields = false
  ;

  SignupRequest._() : super();
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
  @$core.Deprecated('This field is deprecated.')
    $core.String? countryCode,
  @$core.Deprecated('This field is deprecated.')
    $core.String? currencyCode,
  }) {
    final _result = create();
    if (email != null) {
      _result.email = email;
    }
    if (password != null) {
      _result.password = password;
    }
    if (firstName != null) {
      _result.firstName = firstName;
    }
    if (lastName != null) {
      _result.lastName = lastName;
    }
    if (phone != null) {
      _result.phone = phone;
    }
    if (deviceId != null) {
      _result.deviceId = deviceId;
    }
    if (deviceName != null) {
      _result.deviceName = deviceName;
    }
    if (primaryContactType != null) {
      _result.primaryContactType = primaryContactType;
    }
    if (username != null) {
      _result.username = username;
    }
    if (referralCode != null) {
      _result.referralCode = referralCode;
    }
    if (dateOfBirth != null) {
      _result.dateOfBirth = dateOfBirth;
    }
    if (locale != null) {
      _result.locale = locale;
    }
    if (bvn != null) {
      _result.bvn = bvn;
    }
    if (nin != null) {
      _result.nin = nin;
    }
    if (countryCode != null) {
      // ignore: deprecated_member_use_from_same_package
      _result.countryCode = countryCode;
    }
    if (currencyCode != null) {
      // ignore: deprecated_member_use_from_same_package
      _result.currencyCode = currencyCode;
    }
    return _result;
  }
  factory SignupRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SignupRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SignupRequest clone() => SignupRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SignupRequest copyWith(void Function(SignupRequest) updates) => super.copyWith((message) => updates(message as SignupRequest)) as SignupRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SignupRequest create() => SignupRequest._();
  SignupRequest createEmptyInstance() => create();
  static $pb.PbList<SignupRequest> createRepeated() => $pb.PbList<SignupRequest>();
  @$core.pragma('dart2js:noInline')
  static SignupRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SignupRequest>(create);
  static SignupRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get email => $_getSZ(0);
  @$pb.TagNumber(1)
  set email($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasEmail() => $_has(0);
  @$pb.TagNumber(1)
  void clearEmail() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get password => $_getSZ(1);
  @$pb.TagNumber(2)
  set password($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPassword() => $_has(1);
  @$pb.TagNumber(2)
  void clearPassword() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get firstName => $_getSZ(2);
  @$pb.TagNumber(3)
  set firstName($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasFirstName() => $_has(2);
  @$pb.TagNumber(3)
  void clearFirstName() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get lastName => $_getSZ(3);
  @$pb.TagNumber(4)
  set lastName($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasLastName() => $_has(3);
  @$pb.TagNumber(4)
  void clearLastName() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get phone => $_getSZ(4);
  @$pb.TagNumber(5)
  set phone($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasPhone() => $_has(4);
  @$pb.TagNumber(5)
  void clearPhone() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get deviceId => $_getSZ(5);
  @$pb.TagNumber(6)
  set deviceId($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasDeviceId() => $_has(5);
  @$pb.TagNumber(6)
  void clearDeviceId() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get deviceName => $_getSZ(6);
  @$pb.TagNumber(7)
  set deviceName($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasDeviceName() => $_has(6);
  @$pb.TagNumber(7)
  void clearDeviceName() => clearField(7);

  @$pb.TagNumber(8)
  PrimaryContactType get primaryContactType => $_getN(7);
  @$pb.TagNumber(8)
  set primaryContactType(PrimaryContactType v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasPrimaryContactType() => $_has(7);
  @$pb.TagNumber(8)
  void clearPrimaryContactType() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get username => $_getSZ(8);
  @$pb.TagNumber(9)
  set username($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasUsername() => $_has(8);
  @$pb.TagNumber(9)
  void clearUsername() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get referralCode => $_getSZ(9);
  @$pb.TagNumber(10)
  set referralCode($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasReferralCode() => $_has(9);
  @$pb.TagNumber(10)
  void clearReferralCode() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get dateOfBirth => $_getSZ(10);
  @$pb.TagNumber(11)
  set dateOfBirth($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasDateOfBirth() => $_has(10);
  @$pb.TagNumber(11)
  void clearDateOfBirth() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get locale => $_getSZ(11);
  @$pb.TagNumber(12)
  set locale($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasLocale() => $_has(11);
  @$pb.TagNumber(12)
  void clearLocale() => clearField(12);

  @$pb.TagNumber(13)
  $core.String get bvn => $_getSZ(12);
  @$pb.TagNumber(13)
  set bvn($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasBvn() => $_has(12);
  @$pb.TagNumber(13)
  void clearBvn() => clearField(13);

  @$pb.TagNumber(14)
  $core.String get nin => $_getSZ(13);
  @$pb.TagNumber(14)
  set nin($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasNin() => $_has(13);
  @$pb.TagNumber(14)
  void clearNin() => clearField(14);

  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(15)
  $core.String get countryCode => $_getSZ(14);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(15)
  set countryCode($core.String v) { $_setString(14, v); }
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(15)
  $core.bool hasCountryCode() => $_has(14);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(15)
  void clearCountryCode() => clearField(15);

  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(16)
  $core.String get currencyCode => $_getSZ(15);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(16)
  set currencyCode($core.String v) { $_setString(15, v); }
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(16)
  $core.bool hasCurrencyCode() => $_has(15);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(16)
  void clearCurrencyCode() => clearField(16);
}

class SignupResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SignupResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'email')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOB(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'emailVerificationRequired')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accessToken')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'refreshToken')
    ..aInt64(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'expiresIn')
    ..aOM<User>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'user', subBuilder: User.create)
    ..aOB(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'phoneVerificationRequired')
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'verificationSentTo')
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'phoneVerificationId')
    ..aInt64(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'phoneVerificationExpiresIn')
    ..hasRequiredFields = false
  ;

  SignupResponse._() : super();
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
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    if (email != null) {
      _result.email = email;
    }
    if (message != null) {
      _result.message = message;
    }
    if (emailVerificationRequired != null) {
      _result.emailVerificationRequired = emailVerificationRequired;
    }
    if (accessToken != null) {
      _result.accessToken = accessToken;
    }
    if (refreshToken != null) {
      _result.refreshToken = refreshToken;
    }
    if (expiresIn != null) {
      _result.expiresIn = expiresIn;
    }
    if (user != null) {
      _result.user = user;
    }
    if (phoneVerificationRequired != null) {
      _result.phoneVerificationRequired = phoneVerificationRequired;
    }
    if (verificationSentTo != null) {
      _result.verificationSentTo = verificationSentTo;
    }
    if (phoneVerificationId != null) {
      _result.phoneVerificationId = phoneVerificationId;
    }
    if (phoneVerificationExpiresIn != null) {
      _result.phoneVerificationExpiresIn = phoneVerificationExpiresIn;
    }
    return _result;
  }
  factory SignupResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SignupResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SignupResponse clone() => SignupResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SignupResponse copyWith(void Function(SignupResponse) updates) => super.copyWith((message) => updates(message as SignupResponse)) as SignupResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SignupResponse create() => SignupResponse._();
  SignupResponse createEmptyInstance() => create();
  static $pb.PbList<SignupResponse> createRepeated() => $pb.PbList<SignupResponse>();
  @$core.pragma('dart2js:noInline')
  static SignupResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SignupResponse>(create);
  static SignupResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get email => $_getSZ(1);
  @$pb.TagNumber(2)
  set email($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasEmail() => $_has(1);
  @$pb.TagNumber(2)
  void clearEmail() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => clearField(3);

  @$pb.TagNumber(4)
  $core.bool get emailVerificationRequired => $_getBF(3);
  @$pb.TagNumber(4)
  set emailVerificationRequired($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasEmailVerificationRequired() => $_has(3);
  @$pb.TagNumber(4)
  void clearEmailVerificationRequired() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get accessToken => $_getSZ(4);
  @$pb.TagNumber(5)
  set accessToken($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasAccessToken() => $_has(4);
  @$pb.TagNumber(5)
  void clearAccessToken() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get refreshToken => $_getSZ(5);
  @$pb.TagNumber(6)
  set refreshToken($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasRefreshToken() => $_has(5);
  @$pb.TagNumber(6)
  void clearRefreshToken() => clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get expiresIn => $_getI64(6);
  @$pb.TagNumber(7)
  set expiresIn($fixnum.Int64 v) { $_setInt64(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasExpiresIn() => $_has(6);
  @$pb.TagNumber(7)
  void clearExpiresIn() => clearField(7);

  @$pb.TagNumber(8)
  User get user => $_getN(7);
  @$pb.TagNumber(8)
  set user(User v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasUser() => $_has(7);
  @$pb.TagNumber(8)
  void clearUser() => clearField(8);
  @$pb.TagNumber(8)
  User ensureUser() => $_ensure(7);

  @$pb.TagNumber(9)
  $core.bool get phoneVerificationRequired => $_getBF(8);
  @$pb.TagNumber(9)
  set phoneVerificationRequired($core.bool v) { $_setBool(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasPhoneVerificationRequired() => $_has(8);
  @$pb.TagNumber(9)
  void clearPhoneVerificationRequired() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get verificationSentTo => $_getSZ(9);
  @$pb.TagNumber(10)
  set verificationSentTo($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasVerificationSentTo() => $_has(9);
  @$pb.TagNumber(10)
  void clearVerificationSentTo() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get phoneVerificationId => $_getSZ(10);
  @$pb.TagNumber(11)
  set phoneVerificationId($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasPhoneVerificationId() => $_has(10);
  @$pb.TagNumber(11)
  void clearPhoneVerificationId() => clearField(11);

  @$pb.TagNumber(12)
  $fixnum.Int64 get phoneVerificationExpiresIn => $_getI64(11);
  @$pb.TagNumber(12)
  set phoneVerificationExpiresIn($fixnum.Int64 v) { $_setInt64(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasPhoneVerificationExpiresIn() => $_has(11);
  @$pb.TagNumber(12)
  void clearPhoneVerificationExpiresIn() => clearField(12);
}

class LoginRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'LoginRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'email')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'password')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'deviceId')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'deviceName')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'phone')
    ..hasRequiredFields = false
  ;

  LoginRequest._() : super();
  factory LoginRequest({
    $core.String? email,
    $core.String? password,
    $core.String? deviceId,
    $core.String? deviceName,
    $core.String? phone,
  }) {
    final _result = create();
    if (email != null) {
      _result.email = email;
    }
    if (password != null) {
      _result.password = password;
    }
    if (deviceId != null) {
      _result.deviceId = deviceId;
    }
    if (deviceName != null) {
      _result.deviceName = deviceName;
    }
    if (phone != null) {
      _result.phone = phone;
    }
    return _result;
  }
  factory LoginRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LoginRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LoginRequest clone() => LoginRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LoginRequest copyWith(void Function(LoginRequest) updates) => super.copyWith((message) => updates(message as LoginRequest)) as LoginRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static LoginRequest create() => LoginRequest._();
  LoginRequest createEmptyInstance() => create();
  static $pb.PbList<LoginRequest> createRepeated() => $pb.PbList<LoginRequest>();
  @$core.pragma('dart2js:noInline')
  static LoginRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LoginRequest>(create);
  static LoginRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get email => $_getSZ(0);
  @$pb.TagNumber(1)
  set email($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasEmail() => $_has(0);
  @$pb.TagNumber(1)
  void clearEmail() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get password => $_getSZ(1);
  @$pb.TagNumber(2)
  set password($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPassword() => $_has(1);
  @$pb.TagNumber(2)
  void clearPassword() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get deviceId => $_getSZ(2);
  @$pb.TagNumber(3)
  set deviceId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDeviceId() => $_has(2);
  @$pb.TagNumber(3)
  void clearDeviceId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get deviceName => $_getSZ(3);
  @$pb.TagNumber(4)
  set deviceName($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDeviceName() => $_has(3);
  @$pb.TagNumber(4)
  void clearDeviceName() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get phone => $_getSZ(4);
  @$pb.TagNumber(5)
  set phone($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasPhone() => $_has(4);
  @$pb.TagNumber(5)
  void clearPhone() => clearField(5);
}

class LoginResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'LoginResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'msg')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accessToken')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'refreshToken')
    ..aInt64(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'expiresIn')
    ..aOM<LoginData>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'data', subBuilder: LoginData.create)
    ..aOB(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'twoFactorRequired')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'twoFactorToken')
    ..hasRequiredFields = false
  ;

  LoginResponse._() : super();
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
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (msg != null) {
      _result.msg = msg;
    }
    if (accessToken != null) {
      _result.accessToken = accessToken;
    }
    if (refreshToken != null) {
      _result.refreshToken = refreshToken;
    }
    if (expiresIn != null) {
      _result.expiresIn = expiresIn;
    }
    if (data != null) {
      _result.data = data;
    }
    if (twoFactorRequired != null) {
      _result.twoFactorRequired = twoFactorRequired;
    }
    if (twoFactorToken != null) {
      _result.twoFactorToken = twoFactorToken;
    }
    return _result;
  }
  factory LoginResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LoginResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LoginResponse clone() => LoginResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LoginResponse copyWith(void Function(LoginResponse) updates) => super.copyWith((message) => updates(message as LoginResponse)) as LoginResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static LoginResponse create() => LoginResponse._();
  LoginResponse createEmptyInstance() => create();
  static $pb.PbList<LoginResponse> createRepeated() => $pb.PbList<LoginResponse>();
  @$core.pragma('dart2js:noInline')
  static LoginResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LoginResponse>(create);
  static LoginResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get msg => $_getSZ(1);
  @$pb.TagNumber(2)
  set msg($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMsg() => $_has(1);
  @$pb.TagNumber(2)
  void clearMsg() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get accessToken => $_getSZ(2);
  @$pb.TagNumber(3)
  set accessToken($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAccessToken() => $_has(2);
  @$pb.TagNumber(3)
  void clearAccessToken() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get refreshToken => $_getSZ(3);
  @$pb.TagNumber(4)
  set refreshToken($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasRefreshToken() => $_has(3);
  @$pb.TagNumber(4)
  void clearRefreshToken() => clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get expiresIn => $_getI64(4);
  @$pb.TagNumber(5)
  set expiresIn($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasExpiresIn() => $_has(4);
  @$pb.TagNumber(5)
  void clearExpiresIn() => clearField(5);

  @$pb.TagNumber(6)
  LoginData get data => $_getN(5);
  @$pb.TagNumber(6)
  set data(LoginData v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasData() => $_has(5);
  @$pb.TagNumber(6)
  void clearData() => clearField(6);
  @$pb.TagNumber(6)
  LoginData ensureData() => $_ensure(5);

  @$pb.TagNumber(7)
  $core.bool get twoFactorRequired => $_getBF(6);
  @$pb.TagNumber(7)
  set twoFactorRequired($core.bool v) { $_setBool(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasTwoFactorRequired() => $_has(6);
  @$pb.TagNumber(7)
  void clearTwoFactorRequired() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get twoFactorToken => $_getSZ(7);
  @$pb.TagNumber(8)
  set twoFactorToken($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasTwoFactorToken() => $_has(7);
  @$pb.TagNumber(8)
  void clearTwoFactorToken() => clearField(8);
}

class LoginData extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'LoginData', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOM<User>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'user', subBuilder: User.create)
    ..aOM<Session>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'session', subBuilder: Session.create)
    ..hasRequiredFields = false
  ;

  LoginData._() : super();
  factory LoginData({
    User? user,
    Session? session,
  }) {
    final _result = create();
    if (user != null) {
      _result.user = user;
    }
    if (session != null) {
      _result.session = session;
    }
    return _result;
  }
  factory LoginData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LoginData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LoginData clone() => LoginData()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LoginData copyWith(void Function(LoginData) updates) => super.copyWith((message) => updates(message as LoginData)) as LoginData; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static LoginData create() => LoginData._();
  LoginData createEmptyInstance() => create();
  static $pb.PbList<LoginData> createRepeated() => $pb.PbList<LoginData>();
  @$core.pragma('dart2js:noInline')
  static LoginData getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LoginData>(create);
  static LoginData? _defaultInstance;

  @$pb.TagNumber(1)
  User get user => $_getN(0);
  @$pb.TagNumber(1)
  set user(User v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasUser() => $_has(0);
  @$pb.TagNumber(1)
  void clearUser() => clearField(1);
  @$pb.TagNumber(1)
  User ensureUser() => $_ensure(0);

  @$pb.TagNumber(2)
  Session get session => $_getN(1);
  @$pb.TagNumber(2)
  set session(Session v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasSession() => $_has(1);
  @$pb.TagNumber(2)
  void clearSession() => clearField(2);
  @$pb.TagNumber(2)
  Session ensureSession() => $_ensure(1);
}

class Session extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Session', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accessToken')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'refreshToken')
    ..aInt64(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'expiresIn')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..hasRequiredFields = false
  ;

  Session._() : super();
  factory Session({
    $core.String? accessToken,
    $core.String? refreshToken,
    $fixnum.Int64? expiresIn,
    $core.String? userId,
  }) {
    final _result = create();
    if (accessToken != null) {
      _result.accessToken = accessToken;
    }
    if (refreshToken != null) {
      _result.refreshToken = refreshToken;
    }
    if (expiresIn != null) {
      _result.expiresIn = expiresIn;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    return _result;
  }
  factory Session.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Session.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Session clone() => Session()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Session copyWith(void Function(Session) updates) => super.copyWith((message) => updates(message as Session)) as Session; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Session create() => Session._();
  Session createEmptyInstance() => create();
  static $pb.PbList<Session> createRepeated() => $pb.PbList<Session>();
  @$core.pragma('dart2js:noInline')
  static Session getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Session>(create);
  static Session? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accessToken => $_getSZ(0);
  @$pb.TagNumber(1)
  set accessToken($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccessToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccessToken() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get refreshToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set refreshToken($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasRefreshToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearRefreshToken() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get expiresIn => $_getI64(2);
  @$pb.TagNumber(3)
  set expiresIn($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasExpiresIn() => $_has(2);
  @$pb.TagNumber(3)
  void clearExpiresIn() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get userId => $_getSZ(3);
  @$pb.TagNumber(4)
  set userId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasUserId() => $_has(3);
  @$pb.TagNumber(4)
  void clearUserId() => clearField(4);
}

class RefreshTokenRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RefreshTokenRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'refreshToken')
    ..hasRequiredFields = false
  ;

  RefreshTokenRequest._() : super();
  factory RefreshTokenRequest({
    $core.String? refreshToken,
  }) {
    final _result = create();
    if (refreshToken != null) {
      _result.refreshToken = refreshToken;
    }
    return _result;
  }
  factory RefreshTokenRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RefreshTokenRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RefreshTokenRequest clone() => RefreshTokenRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RefreshTokenRequest copyWith(void Function(RefreshTokenRequest) updates) => super.copyWith((message) => updates(message as RefreshTokenRequest)) as RefreshTokenRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RefreshTokenRequest create() => RefreshTokenRequest._();
  RefreshTokenRequest createEmptyInstance() => create();
  static $pb.PbList<RefreshTokenRequest> createRepeated() => $pb.PbList<RefreshTokenRequest>();
  @$core.pragma('dart2js:noInline')
  static RefreshTokenRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RefreshTokenRequest>(create);
  static RefreshTokenRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refreshToken => $_getSZ(0);
  @$pb.TagNumber(1)
  set refreshToken($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRefreshToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefreshToken() => clearField(1);
}

class RefreshTokenResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RefreshTokenResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accessToken')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'refreshToken')
    ..aInt64(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'expiresIn')
    ..aOM<User>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'user', subBuilder: User.create)
    ..hasRequiredFields = false
  ;

  RefreshTokenResponse._() : super();
  factory RefreshTokenResponse({
    $core.String? accessToken,
    $core.String? refreshToken,
    $fixnum.Int64? expiresIn,
    User? user,
  }) {
    final _result = create();
    if (accessToken != null) {
      _result.accessToken = accessToken;
    }
    if (refreshToken != null) {
      _result.refreshToken = refreshToken;
    }
    if (expiresIn != null) {
      _result.expiresIn = expiresIn;
    }
    if (user != null) {
      _result.user = user;
    }
    return _result;
  }
  factory RefreshTokenResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RefreshTokenResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RefreshTokenResponse clone() => RefreshTokenResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RefreshTokenResponse copyWith(void Function(RefreshTokenResponse) updates) => super.copyWith((message) => updates(message as RefreshTokenResponse)) as RefreshTokenResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RefreshTokenResponse create() => RefreshTokenResponse._();
  RefreshTokenResponse createEmptyInstance() => create();
  static $pb.PbList<RefreshTokenResponse> createRepeated() => $pb.PbList<RefreshTokenResponse>();
  @$core.pragma('dart2js:noInline')
  static RefreshTokenResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RefreshTokenResponse>(create);
  static RefreshTokenResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accessToken => $_getSZ(0);
  @$pb.TagNumber(1)
  set accessToken($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccessToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccessToken() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get refreshToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set refreshToken($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasRefreshToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearRefreshToken() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get expiresIn => $_getI64(2);
  @$pb.TagNumber(3)
  set expiresIn($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasExpiresIn() => $_has(2);
  @$pb.TagNumber(3)
  void clearExpiresIn() => clearField(3);

  @$pb.TagNumber(4)
  User get user => $_getN(3);
  @$pb.TagNumber(4)
  set user(User v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasUser() => $_has(3);
  @$pb.TagNumber(4)
  void clearUser() => clearField(4);
  @$pb.TagNumber(4)
  User ensureUser() => $_ensure(3);
}

class LogoutRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'LogoutRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'refreshToken')
    ..hasRequiredFields = false
  ;

  LogoutRequest._() : super();
  factory LogoutRequest({
    $core.String? userId,
    $core.String? refreshToken,
  }) {
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    if (refreshToken != null) {
      _result.refreshToken = refreshToken;
    }
    return _result;
  }
  factory LogoutRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LogoutRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LogoutRequest clone() => LogoutRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LogoutRequest copyWith(void Function(LogoutRequest) updates) => super.copyWith((message) => updates(message as LogoutRequest)) as LogoutRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static LogoutRequest create() => LogoutRequest._();
  LogoutRequest createEmptyInstance() => create();
  static $pb.PbList<LogoutRequest> createRepeated() => $pb.PbList<LogoutRequest>();
  @$core.pragma('dart2js:noInline')
  static LogoutRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LogoutRequest>(create);
  static LogoutRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get refreshToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set refreshToken($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasRefreshToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearRefreshToken() => clearField(2);
}

class LogoutResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'LogoutResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  LogoutResponse._() : super();
  factory LogoutResponse({
    $core.String? message,
  }) {
    final _result = create();
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory LogoutResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LogoutResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LogoutResponse clone() => LogoutResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LogoutResponse copyWith(void Function(LogoutResponse) updates) => super.copyWith((message) => updates(message as LogoutResponse)) as LogoutResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static LogoutResponse create() => LogoutResponse._();
  LogoutResponse createEmptyInstance() => create();
  static $pb.PbList<LogoutResponse> createRepeated() => $pb.PbList<LogoutResponse>();
  @$core.pragma('dart2js:noInline')
  static LogoutResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LogoutResponse>(create);
  static LogoutResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get message => $_getSZ(0);
  @$pb.TagNumber(1)
  set message($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessage() => clearField(1);
}

class VerifyEmailRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'VerifyEmailRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'verificationCode', protoName: 'verificationCode')
    ..hasRequiredFields = false
  ;

  VerifyEmailRequest._() : super();
  factory VerifyEmailRequest({
    $core.String? verificationCode,
  }) {
    final _result = create();
    if (verificationCode != null) {
      _result.verificationCode = verificationCode;
    }
    return _result;
  }
  factory VerifyEmailRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VerifyEmailRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VerifyEmailRequest clone() => VerifyEmailRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VerifyEmailRequest copyWith(void Function(VerifyEmailRequest) updates) => super.copyWith((message) => updates(message as VerifyEmailRequest)) as VerifyEmailRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static VerifyEmailRequest create() => VerifyEmailRequest._();
  VerifyEmailRequest createEmptyInstance() => create();
  static $pb.PbList<VerifyEmailRequest> createRepeated() => $pb.PbList<VerifyEmailRequest>();
  @$core.pragma('dart2js:noInline')
  static VerifyEmailRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VerifyEmailRequest>(create);
  static VerifyEmailRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get verificationCode => $_getSZ(0);
  @$pb.TagNumber(1)
  set verificationCode($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasVerificationCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearVerificationCode() => clearField(1);
}

class VerifyEmailResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'VerifyEmailResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'msg')
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..hasRequiredFields = false
  ;

  VerifyEmailResponse._() : super();
  factory VerifyEmailResponse({
    $core.String? msg,
    $core.bool? success,
  }) {
    final _result = create();
    if (msg != null) {
      _result.msg = msg;
    }
    if (success != null) {
      _result.success = success;
    }
    return _result;
  }
  factory VerifyEmailResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VerifyEmailResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VerifyEmailResponse clone() => VerifyEmailResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VerifyEmailResponse copyWith(void Function(VerifyEmailResponse) updates) => super.copyWith((message) => updates(message as VerifyEmailResponse)) as VerifyEmailResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static VerifyEmailResponse create() => VerifyEmailResponse._();
  VerifyEmailResponse createEmptyInstance() => create();
  static $pb.PbList<VerifyEmailResponse> createRepeated() => $pb.PbList<VerifyEmailResponse>();
  @$core.pragma('dart2js:noInline')
  static VerifyEmailResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VerifyEmailResponse>(create);
  static VerifyEmailResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get msg => $_getSZ(0);
  @$pb.TagNumber(1)
  set msg($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMsg() => $_has(0);
  @$pb.TagNumber(1)
  void clearMsg() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => clearField(2);
}

class ResendVerificationEmailRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ResendVerificationEmailRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'email')
    ..hasRequiredFields = false
  ;

  ResendVerificationEmailRequest._() : super();
  factory ResendVerificationEmailRequest({
    $core.String? email,
  }) {
    final _result = create();
    if (email != null) {
      _result.email = email;
    }
    return _result;
  }
  factory ResendVerificationEmailRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ResendVerificationEmailRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ResendVerificationEmailRequest clone() => ResendVerificationEmailRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ResendVerificationEmailRequest copyWith(void Function(ResendVerificationEmailRequest) updates) => super.copyWith((message) => updates(message as ResendVerificationEmailRequest)) as ResendVerificationEmailRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ResendVerificationEmailRequest create() => ResendVerificationEmailRequest._();
  ResendVerificationEmailRequest createEmptyInstance() => create();
  static $pb.PbList<ResendVerificationEmailRequest> createRepeated() => $pb.PbList<ResendVerificationEmailRequest>();
  @$core.pragma('dart2js:noInline')
  static ResendVerificationEmailRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ResendVerificationEmailRequest>(create);
  static ResendVerificationEmailRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get email => $_getSZ(0);
  @$pb.TagNumber(1)
  set email($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasEmail() => $_has(0);
  @$pb.TagNumber(1)
  void clearEmail() => clearField(1);
}

class ResendVerificationEmailResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ResendVerificationEmailResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cooldownSeconds', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  ResendVerificationEmailResponse._() : super();
  factory ResendVerificationEmailResponse({
    $core.bool? success,
    $core.String? message,
    $core.int? cooldownSeconds,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (cooldownSeconds != null) {
      _result.cooldownSeconds = cooldownSeconds;
    }
    return _result;
  }
  factory ResendVerificationEmailResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ResendVerificationEmailResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ResendVerificationEmailResponse clone() => ResendVerificationEmailResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ResendVerificationEmailResponse copyWith(void Function(ResendVerificationEmailResponse) updates) => super.copyWith((message) => updates(message as ResendVerificationEmailResponse)) as ResendVerificationEmailResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ResendVerificationEmailResponse create() => ResendVerificationEmailResponse._();
  ResendVerificationEmailResponse createEmptyInstance() => create();
  static $pb.PbList<ResendVerificationEmailResponse> createRepeated() => $pb.PbList<ResendVerificationEmailResponse>();
  @$core.pragma('dart2js:noInline')
  static ResendVerificationEmailResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ResendVerificationEmailResponse>(create);
  static ResendVerificationEmailResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get cooldownSeconds => $_getIZ(2);
  @$pb.TagNumber(3)
  set cooldownSeconds($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCooldownSeconds() => $_has(2);
  @$pb.TagNumber(3)
  void clearCooldownSeconds() => clearField(3);
}

class VerifyPhoneRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'VerifyPhoneRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'code')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'phone')
    ..hasRequiredFields = false
  ;

  VerifyPhoneRequest._() : super();
  factory VerifyPhoneRequest({
    $core.String? userId,
    $core.String? code,
    $core.String? phone,
  }) {
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    if (code != null) {
      _result.code = code;
    }
    if (phone != null) {
      _result.phone = phone;
    }
    return _result;
  }
  factory VerifyPhoneRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VerifyPhoneRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VerifyPhoneRequest clone() => VerifyPhoneRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VerifyPhoneRequest copyWith(void Function(VerifyPhoneRequest) updates) => super.copyWith((message) => updates(message as VerifyPhoneRequest)) as VerifyPhoneRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static VerifyPhoneRequest create() => VerifyPhoneRequest._();
  VerifyPhoneRequest createEmptyInstance() => create();
  static $pb.PbList<VerifyPhoneRequest> createRepeated() => $pb.PbList<VerifyPhoneRequest>();
  @$core.pragma('dart2js:noInline')
  static VerifyPhoneRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VerifyPhoneRequest>(create);
  static VerifyPhoneRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get code => $_getSZ(1);
  @$pb.TagNumber(2)
  set code($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearCode() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get phone => $_getSZ(2);
  @$pb.TagNumber(3)
  set phone($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPhone() => $_has(2);
  @$pb.TagNumber(3)
  void clearPhone() => clearField(3);
}

class VerifyPhoneResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'VerifyPhoneResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..hasRequiredFields = false
  ;

  VerifyPhoneResponse._() : super();
  factory VerifyPhoneResponse({
    $core.String? message,
    $core.bool? success,
  }) {
    final _result = create();
    if (message != null) {
      _result.message = message;
    }
    if (success != null) {
      _result.success = success;
    }
    return _result;
  }
  factory VerifyPhoneResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VerifyPhoneResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VerifyPhoneResponse clone() => VerifyPhoneResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VerifyPhoneResponse copyWith(void Function(VerifyPhoneResponse) updates) => super.copyWith((message) => updates(message as VerifyPhoneResponse)) as VerifyPhoneResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static VerifyPhoneResponse create() => VerifyPhoneResponse._();
  VerifyPhoneResponse createEmptyInstance() => create();
  static $pb.PbList<VerifyPhoneResponse> createRepeated() => $pb.PbList<VerifyPhoneResponse>();
  @$core.pragma('dart2js:noInline')
  static VerifyPhoneResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VerifyPhoneResponse>(create);
  static VerifyPhoneResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get message => $_getSZ(0);
  @$pb.TagNumber(1)
  set message($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessage() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => clearField(2);
}

class ResendPhoneVerificationRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ResendPhoneVerificationRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'phone')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..hasRequiredFields = false
  ;

  ResendPhoneVerificationRequest._() : super();
  factory ResendPhoneVerificationRequest({
    $core.String? phone,
    $core.String? userId,
  }) {
    final _result = create();
    if (phone != null) {
      _result.phone = phone;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    return _result;
  }
  factory ResendPhoneVerificationRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ResendPhoneVerificationRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ResendPhoneVerificationRequest clone() => ResendPhoneVerificationRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ResendPhoneVerificationRequest copyWith(void Function(ResendPhoneVerificationRequest) updates) => super.copyWith((message) => updates(message as ResendPhoneVerificationRequest)) as ResendPhoneVerificationRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ResendPhoneVerificationRequest create() => ResendPhoneVerificationRequest._();
  ResendPhoneVerificationRequest createEmptyInstance() => create();
  static $pb.PbList<ResendPhoneVerificationRequest> createRepeated() => $pb.PbList<ResendPhoneVerificationRequest>();
  @$core.pragma('dart2js:noInline')
  static ResendPhoneVerificationRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ResendPhoneVerificationRequest>(create);
  static ResendPhoneVerificationRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get phone => $_getSZ(0);
  @$pb.TagNumber(1)
  set phone($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPhone() => $_has(0);
  @$pb.TagNumber(1)
  void clearPhone() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => clearField(2);
}

class ResendPhoneVerificationResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ResendPhoneVerificationResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..hasRequiredFields = false
  ;

  ResendPhoneVerificationResponse._() : super();
  factory ResendPhoneVerificationResponse({
    $core.String? message,
    $core.bool? success,
  }) {
    final _result = create();
    if (message != null) {
      _result.message = message;
    }
    if (success != null) {
      _result.success = success;
    }
    return _result;
  }
  factory ResendPhoneVerificationResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ResendPhoneVerificationResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ResendPhoneVerificationResponse clone() => ResendPhoneVerificationResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ResendPhoneVerificationResponse copyWith(void Function(ResendPhoneVerificationResponse) updates) => super.copyWith((message) => updates(message as ResendPhoneVerificationResponse)) as ResendPhoneVerificationResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ResendPhoneVerificationResponse create() => ResendPhoneVerificationResponse._();
  ResendPhoneVerificationResponse createEmptyInstance() => create();
  static $pb.PbList<ResendPhoneVerificationResponse> createRepeated() => $pb.PbList<ResendPhoneVerificationResponse>();
  @$core.pragma('dart2js:noInline')
  static ResendPhoneVerificationResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ResendPhoneVerificationResponse>(create);
  static ResendPhoneVerificationResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get message => $_getSZ(0);
  @$pb.TagNumber(1)
  set message($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessage() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => clearField(2);
}

class ForgotPasswordRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ForgotPasswordRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'email')
    ..hasRequiredFields = false
  ;

  ForgotPasswordRequest._() : super();
  factory ForgotPasswordRequest({
    $core.String? email,
  }) {
    final _result = create();
    if (email != null) {
      _result.email = email;
    }
    return _result;
  }
  factory ForgotPasswordRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ForgotPasswordRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ForgotPasswordRequest clone() => ForgotPasswordRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ForgotPasswordRequest copyWith(void Function(ForgotPasswordRequest) updates) => super.copyWith((message) => updates(message as ForgotPasswordRequest)) as ForgotPasswordRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ForgotPasswordRequest create() => ForgotPasswordRequest._();
  ForgotPasswordRequest createEmptyInstance() => create();
  static $pb.PbList<ForgotPasswordRequest> createRepeated() => $pb.PbList<ForgotPasswordRequest>();
  @$core.pragma('dart2js:noInline')
  static ForgotPasswordRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ForgotPasswordRequest>(create);
  static ForgotPasswordRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get email => $_getSZ(0);
  @$pb.TagNumber(1)
  set email($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasEmail() => $_has(0);
  @$pb.TagNumber(1)
  void clearEmail() => clearField(1);
}

class ForgotPasswordResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ForgotPasswordResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  ForgotPasswordResponse._() : super();
  factory ForgotPasswordResponse({
    $core.String? message,
  }) {
    final _result = create();
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory ForgotPasswordResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ForgotPasswordResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ForgotPasswordResponse clone() => ForgotPasswordResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ForgotPasswordResponse copyWith(void Function(ForgotPasswordResponse) updates) => super.copyWith((message) => updates(message as ForgotPasswordResponse)) as ForgotPasswordResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ForgotPasswordResponse create() => ForgotPasswordResponse._();
  ForgotPasswordResponse createEmptyInstance() => create();
  static $pb.PbList<ForgotPasswordResponse> createRepeated() => $pb.PbList<ForgotPasswordResponse>();
  @$core.pragma('dart2js:noInline')
  static ForgotPasswordResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ForgotPasswordResponse>(create);
  static ForgotPasswordResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get message => $_getSZ(0);
  @$pb.TagNumber(1)
  set message($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessage() => clearField(1);
}

class ResetPasswordRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ResetPasswordRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'token')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'newPassword')
    ..hasRequiredFields = false
  ;

  ResetPasswordRequest._() : super();
  factory ResetPasswordRequest({
    $core.String? token,
    $core.String? newPassword,
  }) {
    final _result = create();
    if (token != null) {
      _result.token = token;
    }
    if (newPassword != null) {
      _result.newPassword = newPassword;
    }
    return _result;
  }
  factory ResetPasswordRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ResetPasswordRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ResetPasswordRequest clone() => ResetPasswordRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ResetPasswordRequest copyWith(void Function(ResetPasswordRequest) updates) => super.copyWith((message) => updates(message as ResetPasswordRequest)) as ResetPasswordRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ResetPasswordRequest create() => ResetPasswordRequest._();
  ResetPasswordRequest createEmptyInstance() => create();
  static $pb.PbList<ResetPasswordRequest> createRepeated() => $pb.PbList<ResetPasswordRequest>();
  @$core.pragma('dart2js:noInline')
  static ResetPasswordRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ResetPasswordRequest>(create);
  static ResetPasswordRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get token => $_getSZ(0);
  @$pb.TagNumber(1)
  set token($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearToken() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get newPassword => $_getSZ(1);
  @$pb.TagNumber(2)
  set newPassword($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNewPassword() => $_has(1);
  @$pb.TagNumber(2)
  void clearNewPassword() => clearField(2);
}

class ResetPasswordResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ResetPasswordResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'msg')
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..hasRequiredFields = false
  ;

  ResetPasswordResponse._() : super();
  factory ResetPasswordResponse({
    $core.String? msg,
    $core.bool? success,
  }) {
    final _result = create();
    if (msg != null) {
      _result.msg = msg;
    }
    if (success != null) {
      _result.success = success;
    }
    return _result;
  }
  factory ResetPasswordResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ResetPasswordResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ResetPasswordResponse clone() => ResetPasswordResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ResetPasswordResponse copyWith(void Function(ResetPasswordResponse) updates) => super.copyWith((message) => updates(message as ResetPasswordResponse)) as ResetPasswordResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ResetPasswordResponse create() => ResetPasswordResponse._();
  ResetPasswordResponse createEmptyInstance() => create();
  static $pb.PbList<ResetPasswordResponse> createRepeated() => $pb.PbList<ResetPasswordResponse>();
  @$core.pragma('dart2js:noInline')
  static ResetPasswordResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ResetPasswordResponse>(create);
  static ResetPasswordResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get msg => $_getSZ(0);
  @$pb.TagNumber(1)
  set msg($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMsg() => $_has(0);
  @$pb.TagNumber(1)
  void clearMsg() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => clearField(2);
}

class ChangePasswordRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ChangePasswordRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currentPassword')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'newPassword')
    ..hasRequiredFields = false
  ;

  ChangePasswordRequest._() : super();
  factory ChangePasswordRequest({
    $core.String? userId,
    $core.String? currentPassword,
    $core.String? newPassword,
  }) {
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    if (currentPassword != null) {
      _result.currentPassword = currentPassword;
    }
    if (newPassword != null) {
      _result.newPassword = newPassword;
    }
    return _result;
  }
  factory ChangePasswordRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ChangePasswordRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ChangePasswordRequest clone() => ChangePasswordRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ChangePasswordRequest copyWith(void Function(ChangePasswordRequest) updates) => super.copyWith((message) => updates(message as ChangePasswordRequest)) as ChangePasswordRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ChangePasswordRequest create() => ChangePasswordRequest._();
  ChangePasswordRequest createEmptyInstance() => create();
  static $pb.PbList<ChangePasswordRequest> createRepeated() => $pb.PbList<ChangePasswordRequest>();
  @$core.pragma('dart2js:noInline')
  static ChangePasswordRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChangePasswordRequest>(create);
  static ChangePasswordRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get currentPassword => $_getSZ(1);
  @$pb.TagNumber(2)
  set currentPassword($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCurrentPassword() => $_has(1);
  @$pb.TagNumber(2)
  void clearCurrentPassword() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get newPassword => $_getSZ(2);
  @$pb.TagNumber(3)
  set newPassword($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasNewPassword() => $_has(2);
  @$pb.TagNumber(3)
  void clearNewPassword() => clearField(3);
}

class ChangePasswordResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ChangePasswordResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  ChangePasswordResponse._() : super();
  factory ChangePasswordResponse({
    $core.String? message,
  }) {
    final _result = create();
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory ChangePasswordResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ChangePasswordResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ChangePasswordResponse clone() => ChangePasswordResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ChangePasswordResponse copyWith(void Function(ChangePasswordResponse) updates) => super.copyWith((message) => updates(message as ChangePasswordResponse)) as ChangePasswordResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ChangePasswordResponse create() => ChangePasswordResponse._();
  ChangePasswordResponse createEmptyInstance() => create();
  static $pb.PbList<ChangePasswordResponse> createRepeated() => $pb.PbList<ChangePasswordResponse>();
  @$core.pragma('dart2js:noInline')
  static ChangePasswordResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChangePasswordResponse>(create);
  static ChangePasswordResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get message => $_getSZ(0);
  @$pb.TagNumber(1)
  set message($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessage() => clearField(1);
}

class GetMeRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetMeRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..hasRequiredFields = false
  ;

  GetMeRequest._() : super();
  factory GetMeRequest({
    $core.String? userId,
  }) {
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    return _result;
  }
  factory GetMeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMeRequest clone() => GetMeRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMeRequest copyWith(void Function(GetMeRequest) updates) => super.copyWith((message) => updates(message as GetMeRequest)) as GetMeRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetMeRequest create() => GetMeRequest._();
  GetMeRequest createEmptyInstance() => create();
  static $pb.PbList<GetMeRequest> createRepeated() => $pb.PbList<GetMeRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMeRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMeRequest>(create);
  static GetMeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);
}

class GetMeResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetMeResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOM<User>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'user', subBuilder: User.create)
    ..hasRequiredFields = false
  ;

  GetMeResponse._() : super();
  factory GetMeResponse({
    User? user,
  }) {
    final _result = create();
    if (user != null) {
      _result.user = user;
    }
    return _result;
  }
  factory GetMeResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMeResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMeResponse clone() => GetMeResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMeResponse copyWith(void Function(GetMeResponse) updates) => super.copyWith((message) => updates(message as GetMeResponse)) as GetMeResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetMeResponse create() => GetMeResponse._();
  GetMeResponse createEmptyInstance() => create();
  static $pb.PbList<GetMeResponse> createRepeated() => $pb.PbList<GetMeResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMeResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMeResponse>(create);
  static GetMeResponse? _defaultInstance;

  @$pb.TagNumber(1)
  User get user => $_getN(0);
  @$pb.TagNumber(1)
  set user(User v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasUser() => $_has(0);
  @$pb.TagNumber(1)
  void clearUser() => clearField(1);
  @$pb.TagNumber(1)
  User ensureUser() => $_ensure(0);
}

class UpdateProfileRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateProfileRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'firstName')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lastName')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'username')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'phone')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'profilePicture')
    ..hasRequiredFields = false
  ;

  UpdateProfileRequest._() : super();
  factory UpdateProfileRequest({
    $core.String? userId,
    $core.String? firstName,
    $core.String? lastName,
    $core.String? username,
    $core.String? phone,
    $core.String? profilePicture,
  }) {
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    if (firstName != null) {
      _result.firstName = firstName;
    }
    if (lastName != null) {
      _result.lastName = lastName;
    }
    if (username != null) {
      _result.username = username;
    }
    if (phone != null) {
      _result.phone = phone;
    }
    if (profilePicture != null) {
      _result.profilePicture = profilePicture;
    }
    return _result;
  }
  factory UpdateProfileRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateProfileRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateProfileRequest clone() => UpdateProfileRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateProfileRequest copyWith(void Function(UpdateProfileRequest) updates) => super.copyWith((message) => updates(message as UpdateProfileRequest)) as UpdateProfileRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpdateProfileRequest create() => UpdateProfileRequest._();
  UpdateProfileRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateProfileRequest> createRepeated() => $pb.PbList<UpdateProfileRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateProfileRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateProfileRequest>(create);
  static UpdateProfileRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get firstName => $_getSZ(1);
  @$pb.TagNumber(2)
  set firstName($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFirstName() => $_has(1);
  @$pb.TagNumber(2)
  void clearFirstName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get lastName => $_getSZ(2);
  @$pb.TagNumber(3)
  set lastName($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasLastName() => $_has(2);
  @$pb.TagNumber(3)
  void clearLastName() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get username => $_getSZ(3);
  @$pb.TagNumber(4)
  set username($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasUsername() => $_has(3);
  @$pb.TagNumber(4)
  void clearUsername() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get phone => $_getSZ(4);
  @$pb.TagNumber(5)
  set phone($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasPhone() => $_has(4);
  @$pb.TagNumber(5)
  void clearPhone() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get profilePicture => $_getSZ(5);
  @$pb.TagNumber(6)
  set profilePicture($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasProfilePicture() => $_has(5);
  @$pb.TagNumber(6)
  void clearProfilePicture() => clearField(6);
}

class UpdateProfileResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateProfileResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'msg')
    ..aOM<User>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'user', subBuilder: User.create)
    ..hasRequiredFields = false
  ;

  UpdateProfileResponse._() : super();
  factory UpdateProfileResponse({
    $core.bool? success,
    $core.String? msg,
    User? user,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (msg != null) {
      _result.msg = msg;
    }
    if (user != null) {
      _result.user = user;
    }
    return _result;
  }
  factory UpdateProfileResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateProfileResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateProfileResponse clone() => UpdateProfileResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateProfileResponse copyWith(void Function(UpdateProfileResponse) updates) => super.copyWith((message) => updates(message as UpdateProfileResponse)) as UpdateProfileResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpdateProfileResponse create() => UpdateProfileResponse._();
  UpdateProfileResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateProfileResponse> createRepeated() => $pb.PbList<UpdateProfileResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateProfileResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateProfileResponse>(create);
  static UpdateProfileResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get msg => $_getSZ(1);
  @$pb.TagNumber(2)
  set msg($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMsg() => $_has(1);
  @$pb.TagNumber(2)
  void clearMsg() => clearField(2);

  @$pb.TagNumber(3)
  User get user => $_getN(2);
  @$pb.TagNumber(3)
  set user(User v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasUser() => $_has(2);
  @$pb.TagNumber(3)
  void clearUser() => clearField(3);
  @$pb.TagNumber(3)
  User ensureUser() => $_ensure(2);
}

class FacialLoginRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'FacialLoginRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'facialData', $pb.PbFieldType.OY)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'deviceId')
    ..hasRequiredFields = false
  ;

  FacialLoginRequest._() : super();
  factory FacialLoginRequest({
    $core.List<$core.int>? facialData,
    $core.String? deviceId,
  }) {
    final _result = create();
    if (facialData != null) {
      _result.facialData = facialData;
    }
    if (deviceId != null) {
      _result.deviceId = deviceId;
    }
    return _result;
  }
  factory FacialLoginRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FacialLoginRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FacialLoginRequest clone() => FacialLoginRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FacialLoginRequest copyWith(void Function(FacialLoginRequest) updates) => super.copyWith((message) => updates(message as FacialLoginRequest)) as FacialLoginRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FacialLoginRequest create() => FacialLoginRequest._();
  FacialLoginRequest createEmptyInstance() => create();
  static $pb.PbList<FacialLoginRequest> createRepeated() => $pb.PbList<FacialLoginRequest>();
  @$core.pragma('dart2js:noInline')
  static FacialLoginRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FacialLoginRequest>(create);
  static FacialLoginRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get facialData => $_getN(0);
  @$pb.TagNumber(1)
  set facialData($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFacialData() => $_has(0);
  @$pb.TagNumber(1)
  void clearFacialData() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get deviceId => $_getSZ(1);
  @$pb.TagNumber(2)
  set deviceId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasDeviceId() => $_has(1);
  @$pb.TagNumber(2)
  void clearDeviceId() => clearField(2);
}

class FacialLoginResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'FacialLoginResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accessToken')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'refreshToken')
    ..aInt64(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'expiresIn')
    ..aOM<User>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'user', subBuilder: User.create)
    ..hasRequiredFields = false
  ;

  FacialLoginResponse._() : super();
  factory FacialLoginResponse({
    $core.String? accessToken,
    $core.String? refreshToken,
    $fixnum.Int64? expiresIn,
    User? user,
  }) {
    final _result = create();
    if (accessToken != null) {
      _result.accessToken = accessToken;
    }
    if (refreshToken != null) {
      _result.refreshToken = refreshToken;
    }
    if (expiresIn != null) {
      _result.expiresIn = expiresIn;
    }
    if (user != null) {
      _result.user = user;
    }
    return _result;
  }
  factory FacialLoginResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FacialLoginResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FacialLoginResponse clone() => FacialLoginResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FacialLoginResponse copyWith(void Function(FacialLoginResponse) updates) => super.copyWith((message) => updates(message as FacialLoginResponse)) as FacialLoginResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FacialLoginResponse create() => FacialLoginResponse._();
  FacialLoginResponse createEmptyInstance() => create();
  static $pb.PbList<FacialLoginResponse> createRepeated() => $pb.PbList<FacialLoginResponse>();
  @$core.pragma('dart2js:noInline')
  static FacialLoginResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FacialLoginResponse>(create);
  static FacialLoginResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accessToken => $_getSZ(0);
  @$pb.TagNumber(1)
  set accessToken($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccessToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccessToken() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get refreshToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set refreshToken($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasRefreshToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearRefreshToken() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get expiresIn => $_getI64(2);
  @$pb.TagNumber(3)
  set expiresIn($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasExpiresIn() => $_has(2);
  @$pb.TagNumber(3)
  void clearExpiresIn() => clearField(3);

  @$pb.TagNumber(4)
  User get user => $_getN(3);
  @$pb.TagNumber(4)
  set user(User v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasUser() => $_has(3);
  @$pb.TagNumber(4)
  void clearUser() => clearField(4);
  @$pb.TagNumber(4)
  User ensureUser() => $_ensure(3);
}

class SocialLoginRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SocialLoginRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'provider')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerToken')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'email')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'firstName')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lastName')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerUserId')
    ..hasRequiredFields = false
  ;

  SocialLoginRequest._() : super();
  factory SocialLoginRequest({
    $core.String? provider,
    $core.String? providerToken,
    $core.String? email,
    $core.String? firstName,
    $core.String? lastName,
    $core.String? providerUserId,
  }) {
    final _result = create();
    if (provider != null) {
      _result.provider = provider;
    }
    if (providerToken != null) {
      _result.providerToken = providerToken;
    }
    if (email != null) {
      _result.email = email;
    }
    if (firstName != null) {
      _result.firstName = firstName;
    }
    if (lastName != null) {
      _result.lastName = lastName;
    }
    if (providerUserId != null) {
      _result.providerUserId = providerUserId;
    }
    return _result;
  }
  factory SocialLoginRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SocialLoginRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SocialLoginRequest clone() => SocialLoginRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SocialLoginRequest copyWith(void Function(SocialLoginRequest) updates) => super.copyWith((message) => updates(message as SocialLoginRequest)) as SocialLoginRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SocialLoginRequest create() => SocialLoginRequest._();
  SocialLoginRequest createEmptyInstance() => create();
  static $pb.PbList<SocialLoginRequest> createRepeated() => $pb.PbList<SocialLoginRequest>();
  @$core.pragma('dart2js:noInline')
  static SocialLoginRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SocialLoginRequest>(create);
  static SocialLoginRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get provider => $_getSZ(0);
  @$pb.TagNumber(1)
  set provider($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasProvider() => $_has(0);
  @$pb.TagNumber(1)
  void clearProvider() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get providerToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set providerToken($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasProviderToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearProviderToken() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get email => $_getSZ(2);
  @$pb.TagNumber(3)
  set email($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasEmail() => $_has(2);
  @$pb.TagNumber(3)
  void clearEmail() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get firstName => $_getSZ(3);
  @$pb.TagNumber(4)
  set firstName($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasFirstName() => $_has(3);
  @$pb.TagNumber(4)
  void clearFirstName() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get lastName => $_getSZ(4);
  @$pb.TagNumber(5)
  set lastName($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasLastName() => $_has(4);
  @$pb.TagNumber(5)
  void clearLastName() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get providerUserId => $_getSZ(5);
  @$pb.TagNumber(6)
  set providerUserId($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasProviderUserId() => $_has(5);
  @$pb.TagNumber(6)
  void clearProviderUserId() => clearField(6);
}

class SocialLoginResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SocialLoginResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accessToken')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'refreshToken')
    ..aInt64(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'expiresIn')
    ..aOM<User>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'user', subBuilder: User.create)
    ..aOB(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isNewUser')
    ..hasRequiredFields = false
  ;

  SocialLoginResponse._() : super();
  factory SocialLoginResponse({
    $core.String? accessToken,
    $core.String? refreshToken,
    $fixnum.Int64? expiresIn,
    User? user,
    $core.bool? isNewUser,
  }) {
    final _result = create();
    if (accessToken != null) {
      _result.accessToken = accessToken;
    }
    if (refreshToken != null) {
      _result.refreshToken = refreshToken;
    }
    if (expiresIn != null) {
      _result.expiresIn = expiresIn;
    }
    if (user != null) {
      _result.user = user;
    }
    if (isNewUser != null) {
      _result.isNewUser = isNewUser;
    }
    return _result;
  }
  factory SocialLoginResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SocialLoginResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SocialLoginResponse clone() => SocialLoginResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SocialLoginResponse copyWith(void Function(SocialLoginResponse) updates) => super.copyWith((message) => updates(message as SocialLoginResponse)) as SocialLoginResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SocialLoginResponse create() => SocialLoginResponse._();
  SocialLoginResponse createEmptyInstance() => create();
  static $pb.PbList<SocialLoginResponse> createRepeated() => $pb.PbList<SocialLoginResponse>();
  @$core.pragma('dart2js:noInline')
  static SocialLoginResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SocialLoginResponse>(create);
  static SocialLoginResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accessToken => $_getSZ(0);
  @$pb.TagNumber(1)
  set accessToken($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccessToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccessToken() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get refreshToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set refreshToken($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasRefreshToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearRefreshToken() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get expiresIn => $_getI64(2);
  @$pb.TagNumber(3)
  set expiresIn($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasExpiresIn() => $_has(2);
  @$pb.TagNumber(3)
  void clearExpiresIn() => clearField(3);

  @$pb.TagNumber(4)
  User get user => $_getN(3);
  @$pb.TagNumber(4)
  set user(User v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasUser() => $_has(3);
  @$pb.TagNumber(4)
  void clearUser() => clearField(4);
  @$pb.TagNumber(4)
  User ensureUser() => $_ensure(3);

  @$pb.TagNumber(5)
  $core.bool get isNewUser => $_getBF(4);
  @$pb.TagNumber(5)
  set isNewUser($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasIsNewUser() => $_has(4);
  @$pb.TagNumber(5)
  void clearIsNewUser() => clearField(5);
}

class LinkedSocialAccount extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'LinkedSocialAccount', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'provider')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerUserId')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerEmail')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'displayName')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'profilePictureUrl')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'profileUrl')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..aOB(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isPrimary')
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'linkedAt')
    ..aOS(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lastUsedAt')
    ..hasRequiredFields = false
  ;

  LinkedSocialAccount._() : super();
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
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (provider != null) {
      _result.provider = provider;
    }
    if (providerUserId != null) {
      _result.providerUserId = providerUserId;
    }
    if (providerEmail != null) {
      _result.providerEmail = providerEmail;
    }
    if (displayName != null) {
      _result.displayName = displayName;
    }
    if (profilePictureUrl != null) {
      _result.profilePictureUrl = profilePictureUrl;
    }
    if (profileUrl != null) {
      _result.profileUrl = profileUrl;
    }
    if (status != null) {
      _result.status = status;
    }
    if (isPrimary != null) {
      _result.isPrimary = isPrimary;
    }
    if (linkedAt != null) {
      _result.linkedAt = linkedAt;
    }
    if (lastUsedAt != null) {
      _result.lastUsedAt = lastUsedAt;
    }
    return _result;
  }
  factory LinkedSocialAccount.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LinkedSocialAccount.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LinkedSocialAccount clone() => LinkedSocialAccount()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LinkedSocialAccount copyWith(void Function(LinkedSocialAccount) updates) => super.copyWith((message) => updates(message as LinkedSocialAccount)) as LinkedSocialAccount; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static LinkedSocialAccount create() => LinkedSocialAccount._();
  LinkedSocialAccount createEmptyInstance() => create();
  static $pb.PbList<LinkedSocialAccount> createRepeated() => $pb.PbList<LinkedSocialAccount>();
  @$core.pragma('dart2js:noInline')
  static LinkedSocialAccount getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LinkedSocialAccount>(create);
  static LinkedSocialAccount? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get provider => $_getSZ(2);
  @$pb.TagNumber(3)
  set provider($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasProvider() => $_has(2);
  @$pb.TagNumber(3)
  void clearProvider() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get providerUserId => $_getSZ(3);
  @$pb.TagNumber(4)
  set providerUserId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasProviderUserId() => $_has(3);
  @$pb.TagNumber(4)
  void clearProviderUserId() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get providerEmail => $_getSZ(4);
  @$pb.TagNumber(5)
  set providerEmail($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasProviderEmail() => $_has(4);
  @$pb.TagNumber(5)
  void clearProviderEmail() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get displayName => $_getSZ(5);
  @$pb.TagNumber(6)
  set displayName($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasDisplayName() => $_has(5);
  @$pb.TagNumber(6)
  void clearDisplayName() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get profilePictureUrl => $_getSZ(6);
  @$pb.TagNumber(7)
  set profilePictureUrl($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasProfilePictureUrl() => $_has(6);
  @$pb.TagNumber(7)
  void clearProfilePictureUrl() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get profileUrl => $_getSZ(7);
  @$pb.TagNumber(8)
  set profileUrl($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasProfileUrl() => $_has(7);
  @$pb.TagNumber(8)
  void clearProfileUrl() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get status => $_getSZ(8);
  @$pb.TagNumber(9)
  set status($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasStatus() => $_has(8);
  @$pb.TagNumber(9)
  void clearStatus() => clearField(9);

  @$pb.TagNumber(10)
  $core.bool get isPrimary => $_getBF(9);
  @$pb.TagNumber(10)
  set isPrimary($core.bool v) { $_setBool(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasIsPrimary() => $_has(9);
  @$pb.TagNumber(10)
  void clearIsPrimary() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get linkedAt => $_getSZ(10);
  @$pb.TagNumber(11)
  set linkedAt($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasLinkedAt() => $_has(10);
  @$pb.TagNumber(11)
  void clearLinkedAt() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get lastUsedAt => $_getSZ(11);
  @$pb.TagNumber(12)
  set lastUsedAt($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasLastUsedAt() => $_has(11);
  @$pb.TagNumber(12)
  void clearLastUsedAt() => clearField(12);
}

class GetLinkedSocialAccountsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetLinkedSocialAccountsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetLinkedSocialAccountsRequest._() : super();
  factory GetLinkedSocialAccountsRequest() => create();
  factory GetLinkedSocialAccountsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetLinkedSocialAccountsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetLinkedSocialAccountsRequest clone() => GetLinkedSocialAccountsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetLinkedSocialAccountsRequest copyWith(void Function(GetLinkedSocialAccountsRequest) updates) => super.copyWith((message) => updates(message as GetLinkedSocialAccountsRequest)) as GetLinkedSocialAccountsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetLinkedSocialAccountsRequest create() => GetLinkedSocialAccountsRequest._();
  GetLinkedSocialAccountsRequest createEmptyInstance() => create();
  static $pb.PbList<GetLinkedSocialAccountsRequest> createRepeated() => $pb.PbList<GetLinkedSocialAccountsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetLinkedSocialAccountsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetLinkedSocialAccountsRequest>(create);
  static GetLinkedSocialAccountsRequest? _defaultInstance;
}

class GetLinkedSocialAccountsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetLinkedSocialAccountsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..pc<LinkedSocialAccount>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accounts', $pb.PbFieldType.PM, subBuilder: LinkedSocialAccount.create)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalCount', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetLinkedSocialAccountsResponse._() : super();
  factory GetLinkedSocialAccountsResponse({
    $core.bool? success,
    $core.Iterable<LinkedSocialAccount>? accounts,
    $core.int? totalCount,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (accounts != null) {
      _result.accounts.addAll(accounts);
    }
    if (totalCount != null) {
      _result.totalCount = totalCount;
    }
    return _result;
  }
  factory GetLinkedSocialAccountsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetLinkedSocialAccountsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetLinkedSocialAccountsResponse clone() => GetLinkedSocialAccountsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetLinkedSocialAccountsResponse copyWith(void Function(GetLinkedSocialAccountsResponse) updates) => super.copyWith((message) => updates(message as GetLinkedSocialAccountsResponse)) as GetLinkedSocialAccountsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetLinkedSocialAccountsResponse create() => GetLinkedSocialAccountsResponse._();
  GetLinkedSocialAccountsResponse createEmptyInstance() => create();
  static $pb.PbList<GetLinkedSocialAccountsResponse> createRepeated() => $pb.PbList<GetLinkedSocialAccountsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetLinkedSocialAccountsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetLinkedSocialAccountsResponse>(create);
  static GetLinkedSocialAccountsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<LinkedSocialAccount> get accounts => $_getList(1);

  @$pb.TagNumber(3)
  $core.int get totalCount => $_getIZ(2);
  @$pb.TagNumber(3)
  set totalCount($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTotalCount() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalCount() => clearField(3);
}

class LinkSocialAccountRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'LinkSocialAccountRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'provider')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerToken')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerUserId')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerEmail')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'displayName')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'profilePictureUrl')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'profileUrl')
    ..aOB(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'setAsPrimary')
    ..hasRequiredFields = false
  ;

  LinkSocialAccountRequest._() : super();
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
    final _result = create();
    if (provider != null) {
      _result.provider = provider;
    }
    if (providerToken != null) {
      _result.providerToken = providerToken;
    }
    if (providerUserId != null) {
      _result.providerUserId = providerUserId;
    }
    if (providerEmail != null) {
      _result.providerEmail = providerEmail;
    }
    if (displayName != null) {
      _result.displayName = displayName;
    }
    if (profilePictureUrl != null) {
      _result.profilePictureUrl = profilePictureUrl;
    }
    if (profileUrl != null) {
      _result.profileUrl = profileUrl;
    }
    if (setAsPrimary != null) {
      _result.setAsPrimary = setAsPrimary;
    }
    return _result;
  }
  factory LinkSocialAccountRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LinkSocialAccountRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LinkSocialAccountRequest clone() => LinkSocialAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LinkSocialAccountRequest copyWith(void Function(LinkSocialAccountRequest) updates) => super.copyWith((message) => updates(message as LinkSocialAccountRequest)) as LinkSocialAccountRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static LinkSocialAccountRequest create() => LinkSocialAccountRequest._();
  LinkSocialAccountRequest createEmptyInstance() => create();
  static $pb.PbList<LinkSocialAccountRequest> createRepeated() => $pb.PbList<LinkSocialAccountRequest>();
  @$core.pragma('dart2js:noInline')
  static LinkSocialAccountRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LinkSocialAccountRequest>(create);
  static LinkSocialAccountRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get provider => $_getSZ(0);
  @$pb.TagNumber(1)
  set provider($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasProvider() => $_has(0);
  @$pb.TagNumber(1)
  void clearProvider() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get providerToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set providerToken($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasProviderToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearProviderToken() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get providerUserId => $_getSZ(2);
  @$pb.TagNumber(3)
  set providerUserId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasProviderUserId() => $_has(2);
  @$pb.TagNumber(3)
  void clearProviderUserId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get providerEmail => $_getSZ(3);
  @$pb.TagNumber(4)
  set providerEmail($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasProviderEmail() => $_has(3);
  @$pb.TagNumber(4)
  void clearProviderEmail() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get displayName => $_getSZ(4);
  @$pb.TagNumber(5)
  set displayName($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasDisplayName() => $_has(4);
  @$pb.TagNumber(5)
  void clearDisplayName() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get profilePictureUrl => $_getSZ(5);
  @$pb.TagNumber(6)
  set profilePictureUrl($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasProfilePictureUrl() => $_has(5);
  @$pb.TagNumber(6)
  void clearProfilePictureUrl() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get profileUrl => $_getSZ(6);
  @$pb.TagNumber(7)
  set profileUrl($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasProfileUrl() => $_has(6);
  @$pb.TagNumber(7)
  void clearProfileUrl() => clearField(7);

  @$pb.TagNumber(8)
  $core.bool get setAsPrimary => $_getBF(7);
  @$pb.TagNumber(8)
  set setAsPrimary($core.bool v) { $_setBool(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasSetAsPrimary() => $_has(7);
  @$pb.TagNumber(8)
  void clearSetAsPrimary() => clearField(8);
}

class LinkSocialAccountResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'LinkSocialAccountResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOM<LinkedSocialAccount>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'account', subBuilder: LinkedSocialAccount.create)
    ..hasRequiredFields = false
  ;

  LinkSocialAccountResponse._() : super();
  factory LinkSocialAccountResponse({
    $core.bool? success,
    $core.String? message,
    LinkedSocialAccount? account,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (account != null) {
      _result.account = account;
    }
    return _result;
  }
  factory LinkSocialAccountResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LinkSocialAccountResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LinkSocialAccountResponse clone() => LinkSocialAccountResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LinkSocialAccountResponse copyWith(void Function(LinkSocialAccountResponse) updates) => super.copyWith((message) => updates(message as LinkSocialAccountResponse)) as LinkSocialAccountResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static LinkSocialAccountResponse create() => LinkSocialAccountResponse._();
  LinkSocialAccountResponse createEmptyInstance() => create();
  static $pb.PbList<LinkSocialAccountResponse> createRepeated() => $pb.PbList<LinkSocialAccountResponse>();
  @$core.pragma('dart2js:noInline')
  static LinkSocialAccountResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LinkSocialAccountResponse>(create);
  static LinkSocialAccountResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);

  @$pb.TagNumber(3)
  LinkedSocialAccount get account => $_getN(2);
  @$pb.TagNumber(3)
  set account(LinkedSocialAccount v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasAccount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAccount() => clearField(3);
  @$pb.TagNumber(3)
  LinkedSocialAccount ensureAccount() => $_ensure(2);
}

class UnlinkSocialAccountRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UnlinkSocialAccountRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountId')
    ..hasRequiredFields = false
  ;

  UnlinkSocialAccountRequest._() : super();
  factory UnlinkSocialAccountRequest({
    $core.String? accountId,
  }) {
    final _result = create();
    if (accountId != null) {
      _result.accountId = accountId;
    }
    return _result;
  }
  factory UnlinkSocialAccountRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UnlinkSocialAccountRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UnlinkSocialAccountRequest clone() => UnlinkSocialAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UnlinkSocialAccountRequest copyWith(void Function(UnlinkSocialAccountRequest) updates) => super.copyWith((message) => updates(message as UnlinkSocialAccountRequest)) as UnlinkSocialAccountRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UnlinkSocialAccountRequest create() => UnlinkSocialAccountRequest._();
  UnlinkSocialAccountRequest createEmptyInstance() => create();
  static $pb.PbList<UnlinkSocialAccountRequest> createRepeated() => $pb.PbList<UnlinkSocialAccountRequest>();
  @$core.pragma('dart2js:noInline')
  static UnlinkSocialAccountRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UnlinkSocialAccountRequest>(create);
  static UnlinkSocialAccountRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => clearField(1);
}

class UnlinkSocialAccountResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UnlinkSocialAccountResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  UnlinkSocialAccountResponse._() : super();
  factory UnlinkSocialAccountResponse({
    $core.bool? success,
    $core.String? message,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory UnlinkSocialAccountResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UnlinkSocialAccountResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UnlinkSocialAccountResponse clone() => UnlinkSocialAccountResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UnlinkSocialAccountResponse copyWith(void Function(UnlinkSocialAccountResponse) updates) => super.copyWith((message) => updates(message as UnlinkSocialAccountResponse)) as UnlinkSocialAccountResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UnlinkSocialAccountResponse create() => UnlinkSocialAccountResponse._();
  UnlinkSocialAccountResponse createEmptyInstance() => create();
  static $pb.PbList<UnlinkSocialAccountResponse> createRepeated() => $pb.PbList<UnlinkSocialAccountResponse>();
  @$core.pragma('dart2js:noInline')
  static UnlinkSocialAccountResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UnlinkSocialAccountResponse>(create);
  static UnlinkSocialAccountResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

class SetPrimarySocialAccountRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SetPrimarySocialAccountRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountId')
    ..hasRequiredFields = false
  ;

  SetPrimarySocialAccountRequest._() : super();
  factory SetPrimarySocialAccountRequest({
    $core.String? accountId,
  }) {
    final _result = create();
    if (accountId != null) {
      _result.accountId = accountId;
    }
    return _result;
  }
  factory SetPrimarySocialAccountRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SetPrimarySocialAccountRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SetPrimarySocialAccountRequest clone() => SetPrimarySocialAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SetPrimarySocialAccountRequest copyWith(void Function(SetPrimarySocialAccountRequest) updates) => super.copyWith((message) => updates(message as SetPrimarySocialAccountRequest)) as SetPrimarySocialAccountRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SetPrimarySocialAccountRequest create() => SetPrimarySocialAccountRequest._();
  SetPrimarySocialAccountRequest createEmptyInstance() => create();
  static $pb.PbList<SetPrimarySocialAccountRequest> createRepeated() => $pb.PbList<SetPrimarySocialAccountRequest>();
  @$core.pragma('dart2js:noInline')
  static SetPrimarySocialAccountRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SetPrimarySocialAccountRequest>(create);
  static SetPrimarySocialAccountRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => clearField(1);
}

class SetPrimarySocialAccountResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SetPrimarySocialAccountResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOM<LinkedSocialAccount>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'account', subBuilder: LinkedSocialAccount.create)
    ..hasRequiredFields = false
  ;

  SetPrimarySocialAccountResponse._() : super();
  factory SetPrimarySocialAccountResponse({
    $core.bool? success,
    $core.String? message,
    LinkedSocialAccount? account,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (account != null) {
      _result.account = account;
    }
    return _result;
  }
  factory SetPrimarySocialAccountResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SetPrimarySocialAccountResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SetPrimarySocialAccountResponse clone() => SetPrimarySocialAccountResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SetPrimarySocialAccountResponse copyWith(void Function(SetPrimarySocialAccountResponse) updates) => super.copyWith((message) => updates(message as SetPrimarySocialAccountResponse)) as SetPrimarySocialAccountResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SetPrimarySocialAccountResponse create() => SetPrimarySocialAccountResponse._();
  SetPrimarySocialAccountResponse createEmptyInstance() => create();
  static $pb.PbList<SetPrimarySocialAccountResponse> createRepeated() => $pb.PbList<SetPrimarySocialAccountResponse>();
  @$core.pragma('dart2js:noInline')
  static SetPrimarySocialAccountResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SetPrimarySocialAccountResponse>(create);
  static SetPrimarySocialAccountResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);

  @$pb.TagNumber(3)
  LinkedSocialAccount get account => $_getN(2);
  @$pb.TagNumber(3)
  set account(LinkedSocialAccount v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasAccount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAccount() => clearField(3);
  @$pb.TagNumber(3)
  LinkedSocialAccount ensureAccount() => $_ensure(2);
}

class ReauthorizeSocialAccountRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ReauthorizeSocialAccountRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerToken')
    ..hasRequiredFields = false
  ;

  ReauthorizeSocialAccountRequest._() : super();
  factory ReauthorizeSocialAccountRequest({
    $core.String? accountId,
    $core.String? providerToken,
  }) {
    final _result = create();
    if (accountId != null) {
      _result.accountId = accountId;
    }
    if (providerToken != null) {
      _result.providerToken = providerToken;
    }
    return _result;
  }
  factory ReauthorizeSocialAccountRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ReauthorizeSocialAccountRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ReauthorizeSocialAccountRequest clone() => ReauthorizeSocialAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ReauthorizeSocialAccountRequest copyWith(void Function(ReauthorizeSocialAccountRequest) updates) => super.copyWith((message) => updates(message as ReauthorizeSocialAccountRequest)) as ReauthorizeSocialAccountRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ReauthorizeSocialAccountRequest create() => ReauthorizeSocialAccountRequest._();
  ReauthorizeSocialAccountRequest createEmptyInstance() => create();
  static $pb.PbList<ReauthorizeSocialAccountRequest> createRepeated() => $pb.PbList<ReauthorizeSocialAccountRequest>();
  @$core.pragma('dart2js:noInline')
  static ReauthorizeSocialAccountRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ReauthorizeSocialAccountRequest>(create);
  static ReauthorizeSocialAccountRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get providerToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set providerToken($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasProviderToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearProviderToken() => clearField(2);
}

class ReauthorizeSocialAccountResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ReauthorizeSocialAccountResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOM<LinkedSocialAccount>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'account', subBuilder: LinkedSocialAccount.create)
    ..hasRequiredFields = false
  ;

  ReauthorizeSocialAccountResponse._() : super();
  factory ReauthorizeSocialAccountResponse({
    $core.bool? success,
    $core.String? message,
    LinkedSocialAccount? account,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (account != null) {
      _result.account = account;
    }
    return _result;
  }
  factory ReauthorizeSocialAccountResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ReauthorizeSocialAccountResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ReauthorizeSocialAccountResponse clone() => ReauthorizeSocialAccountResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ReauthorizeSocialAccountResponse copyWith(void Function(ReauthorizeSocialAccountResponse) updates) => super.copyWith((message) => updates(message as ReauthorizeSocialAccountResponse)) as ReauthorizeSocialAccountResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ReauthorizeSocialAccountResponse create() => ReauthorizeSocialAccountResponse._();
  ReauthorizeSocialAccountResponse createEmptyInstance() => create();
  static $pb.PbList<ReauthorizeSocialAccountResponse> createRepeated() => $pb.PbList<ReauthorizeSocialAccountResponse>();
  @$core.pragma('dart2js:noInline')
  static ReauthorizeSocialAccountResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ReauthorizeSocialAccountResponse>(create);
  static ReauthorizeSocialAccountResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);

  @$pb.TagNumber(3)
  LinkedSocialAccount get account => $_getN(2);
  @$pb.TagNumber(3)
  set account(LinkedSocialAccount v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasAccount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAccount() => clearField(3);
  @$pb.TagNumber(3)
  LinkedSocialAccount ensureAccount() => $_ensure(2);
}

class EnableTwoFactorRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'EnableTwoFactorRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'method')
    ..hasRequiredFields = false
  ;

  EnableTwoFactorRequest._() : super();
  factory EnableTwoFactorRequest({
    $core.String? userId,
    $core.String? method,
  }) {
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    if (method != null) {
      _result.method = method;
    }
    return _result;
  }
  factory EnableTwoFactorRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EnableTwoFactorRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EnableTwoFactorRequest clone() => EnableTwoFactorRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EnableTwoFactorRequest copyWith(void Function(EnableTwoFactorRequest) updates) => super.copyWith((message) => updates(message as EnableTwoFactorRequest)) as EnableTwoFactorRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static EnableTwoFactorRequest create() => EnableTwoFactorRequest._();
  EnableTwoFactorRequest createEmptyInstance() => create();
  static $pb.PbList<EnableTwoFactorRequest> createRepeated() => $pb.PbList<EnableTwoFactorRequest>();
  @$core.pragma('dart2js:noInline')
  static EnableTwoFactorRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EnableTwoFactorRequest>(create);
  static EnableTwoFactorRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get method => $_getSZ(1);
  @$pb.TagNumber(2)
  set method($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMethod() => $_has(1);
  @$pb.TagNumber(2)
  void clearMethod() => clearField(2);
}

class EnableTwoFactorResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'EnableTwoFactorResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'qrCode')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'secret')
    ..pPS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'backupCodes')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'methodName')
    ..aOB(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'verificationRequired')
    ..hasRequiredFields = false
  ;

  EnableTwoFactorResponse._() : super();
  factory EnableTwoFactorResponse({
    $core.String? message,
    $core.String? qrCode,
    $core.String? secret,
    $core.Iterable<$core.String>? backupCodes,
    $core.String? methodName,
    $core.bool? verificationRequired,
  }) {
    final _result = create();
    if (message != null) {
      _result.message = message;
    }
    if (qrCode != null) {
      _result.qrCode = qrCode;
    }
    if (secret != null) {
      _result.secret = secret;
    }
    if (backupCodes != null) {
      _result.backupCodes.addAll(backupCodes);
    }
    if (methodName != null) {
      _result.methodName = methodName;
    }
    if (verificationRequired != null) {
      _result.verificationRequired = verificationRequired;
    }
    return _result;
  }
  factory EnableTwoFactorResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EnableTwoFactorResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EnableTwoFactorResponse clone() => EnableTwoFactorResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EnableTwoFactorResponse copyWith(void Function(EnableTwoFactorResponse) updates) => super.copyWith((message) => updates(message as EnableTwoFactorResponse)) as EnableTwoFactorResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static EnableTwoFactorResponse create() => EnableTwoFactorResponse._();
  EnableTwoFactorResponse createEmptyInstance() => create();
  static $pb.PbList<EnableTwoFactorResponse> createRepeated() => $pb.PbList<EnableTwoFactorResponse>();
  @$core.pragma('dart2js:noInline')
  static EnableTwoFactorResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EnableTwoFactorResponse>(create);
  static EnableTwoFactorResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get message => $_getSZ(0);
  @$pb.TagNumber(1)
  set message($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessage() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get qrCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set qrCode($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasQrCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearQrCode() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get secret => $_getSZ(2);
  @$pb.TagNumber(3)
  set secret($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSecret() => $_has(2);
  @$pb.TagNumber(3)
  void clearSecret() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<$core.String> get backupCodes => $_getList(3);

  @$pb.TagNumber(5)
  $core.String get methodName => $_getSZ(4);
  @$pb.TagNumber(5)
  set methodName($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasMethodName() => $_has(4);
  @$pb.TagNumber(5)
  void clearMethodName() => clearField(5);

  @$pb.TagNumber(6)
  $core.bool get verificationRequired => $_getBF(5);
  @$pb.TagNumber(6)
  set verificationRequired($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasVerificationRequired() => $_has(5);
  @$pb.TagNumber(6)
  void clearVerificationRequired() => clearField(6);
}

class VerifyTwoFactorRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'VerifyTwoFactorRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'twoFactorToken')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'code')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'method')
    ..hasRequiredFields = false
  ;

  VerifyTwoFactorRequest._() : super();
  factory VerifyTwoFactorRequest({
    $core.String? twoFactorToken,
    $core.String? code,
    $core.String? method,
  }) {
    final _result = create();
    if (twoFactorToken != null) {
      _result.twoFactorToken = twoFactorToken;
    }
    if (code != null) {
      _result.code = code;
    }
    if (method != null) {
      _result.method = method;
    }
    return _result;
  }
  factory VerifyTwoFactorRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VerifyTwoFactorRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VerifyTwoFactorRequest clone() => VerifyTwoFactorRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VerifyTwoFactorRequest copyWith(void Function(VerifyTwoFactorRequest) updates) => super.copyWith((message) => updates(message as VerifyTwoFactorRequest)) as VerifyTwoFactorRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static VerifyTwoFactorRequest create() => VerifyTwoFactorRequest._();
  VerifyTwoFactorRequest createEmptyInstance() => create();
  static $pb.PbList<VerifyTwoFactorRequest> createRepeated() => $pb.PbList<VerifyTwoFactorRequest>();
  @$core.pragma('dart2js:noInline')
  static VerifyTwoFactorRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VerifyTwoFactorRequest>(create);
  static VerifyTwoFactorRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get twoFactorToken => $_getSZ(0);
  @$pb.TagNumber(1)
  set twoFactorToken($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTwoFactorToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearTwoFactorToken() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get code => $_getSZ(1);
  @$pb.TagNumber(2)
  set code($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearCode() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get method => $_getSZ(2);
  @$pb.TagNumber(3)
  set method($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMethod() => $_has(2);
  @$pb.TagNumber(3)
  void clearMethod() => clearField(3);
}

class VerifyTwoFactorResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'VerifyTwoFactorResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accessToken')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'refreshToken')
    ..aInt64(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'expiresIn')
    ..aOM<User>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'user', subBuilder: User.create)
    ..hasRequiredFields = false
  ;

  VerifyTwoFactorResponse._() : super();
  factory VerifyTwoFactorResponse({
    $core.String? accessToken,
    $core.String? refreshToken,
    $fixnum.Int64? expiresIn,
    User? user,
  }) {
    final _result = create();
    if (accessToken != null) {
      _result.accessToken = accessToken;
    }
    if (refreshToken != null) {
      _result.refreshToken = refreshToken;
    }
    if (expiresIn != null) {
      _result.expiresIn = expiresIn;
    }
    if (user != null) {
      _result.user = user;
    }
    return _result;
  }
  factory VerifyTwoFactorResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VerifyTwoFactorResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VerifyTwoFactorResponse clone() => VerifyTwoFactorResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VerifyTwoFactorResponse copyWith(void Function(VerifyTwoFactorResponse) updates) => super.copyWith((message) => updates(message as VerifyTwoFactorResponse)) as VerifyTwoFactorResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static VerifyTwoFactorResponse create() => VerifyTwoFactorResponse._();
  VerifyTwoFactorResponse createEmptyInstance() => create();
  static $pb.PbList<VerifyTwoFactorResponse> createRepeated() => $pb.PbList<VerifyTwoFactorResponse>();
  @$core.pragma('dart2js:noInline')
  static VerifyTwoFactorResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VerifyTwoFactorResponse>(create);
  static VerifyTwoFactorResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accessToken => $_getSZ(0);
  @$pb.TagNumber(1)
  set accessToken($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccessToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccessToken() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get refreshToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set refreshToken($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasRefreshToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearRefreshToken() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get expiresIn => $_getI64(2);
  @$pb.TagNumber(3)
  set expiresIn($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasExpiresIn() => $_has(2);
  @$pb.TagNumber(3)
  void clearExpiresIn() => clearField(3);

  @$pb.TagNumber(4)
  User get user => $_getN(3);
  @$pb.TagNumber(4)
  set user(User v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasUser() => $_has(3);
  @$pb.TagNumber(4)
  void clearUser() => clearField(4);
  @$pb.TagNumber(4)
  User ensureUser() => $_ensure(3);
}

class CompleteTwoFactorSetupRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CompleteTwoFactorSetupRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'code')
    ..hasRequiredFields = false
  ;

  CompleteTwoFactorSetupRequest._() : super();
  factory CompleteTwoFactorSetupRequest({
    $core.String? code,
  }) {
    final _result = create();
    if (code != null) {
      _result.code = code;
    }
    return _result;
  }
  factory CompleteTwoFactorSetupRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CompleteTwoFactorSetupRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CompleteTwoFactorSetupRequest clone() => CompleteTwoFactorSetupRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CompleteTwoFactorSetupRequest copyWith(void Function(CompleteTwoFactorSetupRequest) updates) => super.copyWith((message) => updates(message as CompleteTwoFactorSetupRequest)) as CompleteTwoFactorSetupRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CompleteTwoFactorSetupRequest create() => CompleteTwoFactorSetupRequest._();
  CompleteTwoFactorSetupRequest createEmptyInstance() => create();
  static $pb.PbList<CompleteTwoFactorSetupRequest> createRepeated() => $pb.PbList<CompleteTwoFactorSetupRequest>();
  @$core.pragma('dart2js:noInline')
  static CompleteTwoFactorSetupRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CompleteTwoFactorSetupRequest>(create);
  static CompleteTwoFactorSetupRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get code => $_getSZ(0);
  @$pb.TagNumber(1)
  set code($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearCode() => clearField(1);
}

class CompleteTwoFactorSetupResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CompleteTwoFactorSetupResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  CompleteTwoFactorSetupResponse._() : super();
  factory CompleteTwoFactorSetupResponse({
    $core.bool? success,
    $core.String? message,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory CompleteTwoFactorSetupResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CompleteTwoFactorSetupResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CompleteTwoFactorSetupResponse clone() => CompleteTwoFactorSetupResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CompleteTwoFactorSetupResponse copyWith(void Function(CompleteTwoFactorSetupResponse) updates) => super.copyWith((message) => updates(message as CompleteTwoFactorSetupResponse)) as CompleteTwoFactorSetupResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CompleteTwoFactorSetupResponse create() => CompleteTwoFactorSetupResponse._();
  CompleteTwoFactorSetupResponse createEmptyInstance() => create();
  static $pb.PbList<CompleteTwoFactorSetupResponse> createRepeated() => $pb.PbList<CompleteTwoFactorSetupResponse>();
  @$core.pragma('dart2js:noInline')
  static CompleteTwoFactorSetupResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CompleteTwoFactorSetupResponse>(create);
  static CompleteTwoFactorSetupResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

class DisableTwoFactorRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DisableTwoFactorRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'code')
    ..hasRequiredFields = false
  ;

  DisableTwoFactorRequest._() : super();
  factory DisableTwoFactorRequest({
    $core.String? code,
  }) {
    final _result = create();
    if (code != null) {
      _result.code = code;
    }
    return _result;
  }
  factory DisableTwoFactorRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DisableTwoFactorRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DisableTwoFactorRequest clone() => DisableTwoFactorRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DisableTwoFactorRequest copyWith(void Function(DisableTwoFactorRequest) updates) => super.copyWith((message) => updates(message as DisableTwoFactorRequest)) as DisableTwoFactorRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DisableTwoFactorRequest create() => DisableTwoFactorRequest._();
  DisableTwoFactorRequest createEmptyInstance() => create();
  static $pb.PbList<DisableTwoFactorRequest> createRepeated() => $pb.PbList<DisableTwoFactorRequest>();
  @$core.pragma('dart2js:noInline')
  static DisableTwoFactorRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DisableTwoFactorRequest>(create);
  static DisableTwoFactorRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get code => $_getSZ(0);
  @$pb.TagNumber(1)
  set code($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearCode() => clearField(1);
}

class DisableTwoFactorResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DisableTwoFactorResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  DisableTwoFactorResponse._() : super();
  factory DisableTwoFactorResponse({
    $core.bool? success,
    $core.String? message,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory DisableTwoFactorResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DisableTwoFactorResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DisableTwoFactorResponse clone() => DisableTwoFactorResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DisableTwoFactorResponse copyWith(void Function(DisableTwoFactorResponse) updates) => super.copyWith((message) => updates(message as DisableTwoFactorResponse)) as DisableTwoFactorResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DisableTwoFactorResponse create() => DisableTwoFactorResponse._();
  DisableTwoFactorResponse createEmptyInstance() => create();
  static $pb.PbList<DisableTwoFactorResponse> createRepeated() => $pb.PbList<DisableTwoFactorResponse>();
  @$core.pragma('dart2js:noInline')
  static DisableTwoFactorResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DisableTwoFactorResponse>(create);
  static DisableTwoFactorResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

class GetTwoFactorStatusRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetTwoFactorStatusRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetTwoFactorStatusRequest._() : super();
  factory GetTwoFactorStatusRequest() => create();
  factory GetTwoFactorStatusRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTwoFactorStatusRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetTwoFactorStatusRequest clone() => GetTwoFactorStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetTwoFactorStatusRequest copyWith(void Function(GetTwoFactorStatusRequest) updates) => super.copyWith((message) => updates(message as GetTwoFactorStatusRequest)) as GetTwoFactorStatusRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetTwoFactorStatusRequest create() => GetTwoFactorStatusRequest._();
  GetTwoFactorStatusRequest createEmptyInstance() => create();
  static $pb.PbList<GetTwoFactorStatusRequest> createRepeated() => $pb.PbList<GetTwoFactorStatusRequest>();
  @$core.pragma('dart2js:noInline')
  static GetTwoFactorStatusRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTwoFactorStatusRequest>(create);
  static GetTwoFactorStatusRequest? _defaultInstance;
}

class GetTwoFactorStatusResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetTwoFactorStatusResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'enabled')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'method')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'methodName')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'methodDescription')
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'backupCodesCount', $pb.PbFieldType.O3)
    ..aOB(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hasBackupCodes')
    ..hasRequiredFields = false
  ;

  GetTwoFactorStatusResponse._() : super();
  factory GetTwoFactorStatusResponse({
    $core.bool? enabled,
    $core.String? method,
    $core.String? methodName,
    $core.String? methodDescription,
    $core.int? backupCodesCount,
    $core.bool? hasBackupCodes,
  }) {
    final _result = create();
    if (enabled != null) {
      _result.enabled = enabled;
    }
    if (method != null) {
      _result.method = method;
    }
    if (methodName != null) {
      _result.methodName = methodName;
    }
    if (methodDescription != null) {
      _result.methodDescription = methodDescription;
    }
    if (backupCodesCount != null) {
      _result.backupCodesCount = backupCodesCount;
    }
    if (hasBackupCodes != null) {
      _result.hasBackupCodes = hasBackupCodes;
    }
    return _result;
  }
  factory GetTwoFactorStatusResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTwoFactorStatusResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetTwoFactorStatusResponse clone() => GetTwoFactorStatusResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetTwoFactorStatusResponse copyWith(void Function(GetTwoFactorStatusResponse) updates) => super.copyWith((message) => updates(message as GetTwoFactorStatusResponse)) as GetTwoFactorStatusResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetTwoFactorStatusResponse create() => GetTwoFactorStatusResponse._();
  GetTwoFactorStatusResponse createEmptyInstance() => create();
  static $pb.PbList<GetTwoFactorStatusResponse> createRepeated() => $pb.PbList<GetTwoFactorStatusResponse>();
  @$core.pragma('dart2js:noInline')
  static GetTwoFactorStatusResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTwoFactorStatusResponse>(create);
  static GetTwoFactorStatusResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get enabled => $_getBF(0);
  @$pb.TagNumber(1)
  set enabled($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasEnabled() => $_has(0);
  @$pb.TagNumber(1)
  void clearEnabled() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get method => $_getSZ(1);
  @$pb.TagNumber(2)
  set method($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMethod() => $_has(1);
  @$pb.TagNumber(2)
  void clearMethod() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get methodName => $_getSZ(2);
  @$pb.TagNumber(3)
  set methodName($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMethodName() => $_has(2);
  @$pb.TagNumber(3)
  void clearMethodName() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get methodDescription => $_getSZ(3);
  @$pb.TagNumber(4)
  set methodDescription($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMethodDescription() => $_has(3);
  @$pb.TagNumber(4)
  void clearMethodDescription() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get backupCodesCount => $_getIZ(4);
  @$pb.TagNumber(5)
  set backupCodesCount($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasBackupCodesCount() => $_has(4);
  @$pb.TagNumber(5)
  void clearBackupCodesCount() => clearField(5);

  @$pb.TagNumber(6)
  $core.bool get hasBackupCodes => $_getBF(5);
  @$pb.TagNumber(6)
  set hasBackupCodes($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasHasBackupCodes() => $_has(5);
  @$pb.TagNumber(6)
  void clearHasBackupCodes() => clearField(6);
}

class RegenerateBackupCodesRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RegenerateBackupCodesRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'code')
    ..hasRequiredFields = false
  ;

  RegenerateBackupCodesRequest._() : super();
  factory RegenerateBackupCodesRequest({
    $core.String? code,
  }) {
    final _result = create();
    if (code != null) {
      _result.code = code;
    }
    return _result;
  }
  factory RegenerateBackupCodesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RegenerateBackupCodesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RegenerateBackupCodesRequest clone() => RegenerateBackupCodesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RegenerateBackupCodesRequest copyWith(void Function(RegenerateBackupCodesRequest) updates) => super.copyWith((message) => updates(message as RegenerateBackupCodesRequest)) as RegenerateBackupCodesRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RegenerateBackupCodesRequest create() => RegenerateBackupCodesRequest._();
  RegenerateBackupCodesRequest createEmptyInstance() => create();
  static $pb.PbList<RegenerateBackupCodesRequest> createRepeated() => $pb.PbList<RegenerateBackupCodesRequest>();
  @$core.pragma('dart2js:noInline')
  static RegenerateBackupCodesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RegenerateBackupCodesRequest>(create);
  static RegenerateBackupCodesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get code => $_getSZ(0);
  @$pb.TagNumber(1)
  set code($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearCode() => clearField(1);
}

class RegenerateBackupCodesResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RegenerateBackupCodesResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..pPS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'backupCodes')
    ..hasRequiredFields = false
  ;

  RegenerateBackupCodesResponse._() : super();
  factory RegenerateBackupCodesResponse({
    $core.bool? success,
    $core.String? message,
    $core.Iterable<$core.String>? backupCodes,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (backupCodes != null) {
      _result.backupCodes.addAll(backupCodes);
    }
    return _result;
  }
  factory RegenerateBackupCodesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RegenerateBackupCodesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RegenerateBackupCodesResponse clone() => RegenerateBackupCodesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RegenerateBackupCodesResponse copyWith(void Function(RegenerateBackupCodesResponse) updates) => super.copyWith((message) => updates(message as RegenerateBackupCodesResponse)) as RegenerateBackupCodesResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RegenerateBackupCodesResponse create() => RegenerateBackupCodesResponse._();
  RegenerateBackupCodesResponse createEmptyInstance() => create();
  static $pb.PbList<RegenerateBackupCodesResponse> createRepeated() => $pb.PbList<RegenerateBackupCodesResponse>();
  @$core.pragma('dart2js:noInline')
  static RegenerateBackupCodesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RegenerateBackupCodesResponse>(create);
  static RegenerateBackupCodesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.String> get backupCodes => $_getList(2);
}

class SendTwoFactorCodeRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SendTwoFactorCodeRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  SendTwoFactorCodeRequest._() : super();
  factory SendTwoFactorCodeRequest() => create();
  factory SendTwoFactorCodeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SendTwoFactorCodeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SendTwoFactorCodeRequest clone() => SendTwoFactorCodeRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SendTwoFactorCodeRequest copyWith(void Function(SendTwoFactorCodeRequest) updates) => super.copyWith((message) => updates(message as SendTwoFactorCodeRequest)) as SendTwoFactorCodeRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SendTwoFactorCodeRequest create() => SendTwoFactorCodeRequest._();
  SendTwoFactorCodeRequest createEmptyInstance() => create();
  static $pb.PbList<SendTwoFactorCodeRequest> createRepeated() => $pb.PbList<SendTwoFactorCodeRequest>();
  @$core.pragma('dart2js:noInline')
  static SendTwoFactorCodeRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SendTwoFactorCodeRequest>(create);
  static SendTwoFactorCodeRequest? _defaultInstance;
}

class SendTwoFactorCodeResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SendTwoFactorCodeResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aInt64(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'expiresIn')
    ..hasRequiredFields = false
  ;

  SendTwoFactorCodeResponse._() : super();
  factory SendTwoFactorCodeResponse({
    $core.bool? success,
    $core.String? message,
    $fixnum.Int64? expiresIn,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (expiresIn != null) {
      _result.expiresIn = expiresIn;
    }
    return _result;
  }
  factory SendTwoFactorCodeResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SendTwoFactorCodeResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SendTwoFactorCodeResponse clone() => SendTwoFactorCodeResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SendTwoFactorCodeResponse copyWith(void Function(SendTwoFactorCodeResponse) updates) => super.copyWith((message) => updates(message as SendTwoFactorCodeResponse)) as SendTwoFactorCodeResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SendTwoFactorCodeResponse create() => SendTwoFactorCodeResponse._();
  SendTwoFactorCodeResponse createEmptyInstance() => create();
  static $pb.PbList<SendTwoFactorCodeResponse> createRepeated() => $pb.PbList<SendTwoFactorCodeResponse>();
  @$core.pragma('dart2js:noInline')
  static SendTwoFactorCodeResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SendTwoFactorCodeResponse>(create);
  static SendTwoFactorCodeResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get expiresIn => $_getI64(2);
  @$pb.TagNumber(3)
  set expiresIn($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasExpiresIn() => $_has(2);
  @$pb.TagNumber(3)
  void clearExpiresIn() => clearField(3);
}

class GetAvailable2FAMethodsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetAvailable2FAMethodsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetAvailable2FAMethodsRequest._() : super();
  factory GetAvailable2FAMethodsRequest() => create();
  factory GetAvailable2FAMethodsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAvailable2FAMethodsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAvailable2FAMethodsRequest clone() => GetAvailable2FAMethodsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAvailable2FAMethodsRequest copyWith(void Function(GetAvailable2FAMethodsRequest) updates) => super.copyWith((message) => updates(message as GetAvailable2FAMethodsRequest)) as GetAvailable2FAMethodsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetAvailable2FAMethodsRequest create() => GetAvailable2FAMethodsRequest._();
  GetAvailable2FAMethodsRequest createEmptyInstance() => create();
  static $pb.PbList<GetAvailable2FAMethodsRequest> createRepeated() => $pb.PbList<GetAvailable2FAMethodsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetAvailable2FAMethodsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAvailable2FAMethodsRequest>(create);
  static GetAvailable2FAMethodsRequest? _defaultInstance;
}

class TwoFactorMethodInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TwoFactorMethodInfo', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'method')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'icon')
    ..aOB(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'available')
    ..hasRequiredFields = false
  ;

  TwoFactorMethodInfo._() : super();
  factory TwoFactorMethodInfo({
    $core.String? method,
    $core.String? name,
    $core.String? description,
    $core.String? icon,
    $core.bool? available,
  }) {
    final _result = create();
    if (method != null) {
      _result.method = method;
    }
    if (name != null) {
      _result.name = name;
    }
    if (description != null) {
      _result.description = description;
    }
    if (icon != null) {
      _result.icon = icon;
    }
    if (available != null) {
      _result.available = available;
    }
    return _result;
  }
  factory TwoFactorMethodInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TwoFactorMethodInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TwoFactorMethodInfo clone() => TwoFactorMethodInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TwoFactorMethodInfo copyWith(void Function(TwoFactorMethodInfo) updates) => super.copyWith((message) => updates(message as TwoFactorMethodInfo)) as TwoFactorMethodInfo; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TwoFactorMethodInfo create() => TwoFactorMethodInfo._();
  TwoFactorMethodInfo createEmptyInstance() => create();
  static $pb.PbList<TwoFactorMethodInfo> createRepeated() => $pb.PbList<TwoFactorMethodInfo>();
  @$core.pragma('dart2js:noInline')
  static TwoFactorMethodInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TwoFactorMethodInfo>(create);
  static TwoFactorMethodInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get method => $_getSZ(0);
  @$pb.TagNumber(1)
  set method($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMethod() => $_has(0);
  @$pb.TagNumber(1)
  void clearMethod() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get icon => $_getSZ(3);
  @$pb.TagNumber(4)
  set icon($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasIcon() => $_has(3);
  @$pb.TagNumber(4)
  void clearIcon() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get available => $_getBF(4);
  @$pb.TagNumber(5)
  set available($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasAvailable() => $_has(4);
  @$pb.TagNumber(5)
  void clearAvailable() => clearField(5);
}

class GetAvailable2FAMethodsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetAvailable2FAMethodsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..pc<TwoFactorMethodInfo>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'methods', $pb.PbFieldType.PM, subBuilder: TwoFactorMethodInfo.create)
    ..hasRequiredFields = false
  ;

  GetAvailable2FAMethodsResponse._() : super();
  factory GetAvailable2FAMethodsResponse({
    $core.Iterable<TwoFactorMethodInfo>? methods,
  }) {
    final _result = create();
    if (methods != null) {
      _result.methods.addAll(methods);
    }
    return _result;
  }
  factory GetAvailable2FAMethodsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAvailable2FAMethodsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAvailable2FAMethodsResponse clone() => GetAvailable2FAMethodsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAvailable2FAMethodsResponse copyWith(void Function(GetAvailable2FAMethodsResponse) updates) => super.copyWith((message) => updates(message as GetAvailable2FAMethodsResponse)) as GetAvailable2FAMethodsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetAvailable2FAMethodsResponse create() => GetAvailable2FAMethodsResponse._();
  GetAvailable2FAMethodsResponse createEmptyInstance() => create();
  static $pb.PbList<GetAvailable2FAMethodsResponse> createRepeated() => $pb.PbList<GetAvailable2FAMethodsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetAvailable2FAMethodsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAvailable2FAMethodsResponse>(create);
  static GetAvailable2FAMethodsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<TwoFactorMethodInfo> get methods => $_getList(0);
}

class ValidateTokenRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ValidateTokenRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'token')
    ..hasRequiredFields = false
  ;

  ValidateTokenRequest._() : super();
  factory ValidateTokenRequest({
    $core.String? token,
  }) {
    final _result = create();
    if (token != null) {
      _result.token = token;
    }
    return _result;
  }
  factory ValidateTokenRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ValidateTokenRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ValidateTokenRequest clone() => ValidateTokenRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ValidateTokenRequest copyWith(void Function(ValidateTokenRequest) updates) => super.copyWith((message) => updates(message as ValidateTokenRequest)) as ValidateTokenRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ValidateTokenRequest create() => ValidateTokenRequest._();
  ValidateTokenRequest createEmptyInstance() => create();
  static $pb.PbList<ValidateTokenRequest> createRepeated() => $pb.PbList<ValidateTokenRequest>();
  @$core.pragma('dart2js:noInline')
  static ValidateTokenRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ValidateTokenRequest>(create);
  static ValidateTokenRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get token => $_getSZ(0);
  @$pb.TagNumber(1)
  set token($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearToken() => clearField(1);
}

class ValidateTokenResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ValidateTokenResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'valid')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'email')
    ..aInt64(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'expiresAt')
    ..hasRequiredFields = false
  ;

  ValidateTokenResponse._() : super();
  factory ValidateTokenResponse({
    $core.bool? valid,
    $core.String? userId,
    $core.String? email,
    $fixnum.Int64? expiresAt,
  }) {
    final _result = create();
    if (valid != null) {
      _result.valid = valid;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (email != null) {
      _result.email = email;
    }
    if (expiresAt != null) {
      _result.expiresAt = expiresAt;
    }
    return _result;
  }
  factory ValidateTokenResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ValidateTokenResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ValidateTokenResponse clone() => ValidateTokenResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ValidateTokenResponse copyWith(void Function(ValidateTokenResponse) updates) => super.copyWith((message) => updates(message as ValidateTokenResponse)) as ValidateTokenResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ValidateTokenResponse create() => ValidateTokenResponse._();
  ValidateTokenResponse createEmptyInstance() => create();
  static $pb.PbList<ValidateTokenResponse> createRepeated() => $pb.PbList<ValidateTokenResponse>();
  @$core.pragma('dart2js:noInline')
  static ValidateTokenResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ValidateTokenResponse>(create);
  static ValidateTokenResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get valid => $_getBF(0);
  @$pb.TagNumber(1)
  set valid($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasValid() => $_has(0);
  @$pb.TagNumber(1)
  void clearValid() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get email => $_getSZ(2);
  @$pb.TagNumber(3)
  set email($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasEmail() => $_has(2);
  @$pb.TagNumber(3)
  void clearEmail() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get expiresAt => $_getI64(3);
  @$pb.TagNumber(4)
  set expiresAt($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasExpiresAt() => $_has(3);
  @$pb.TagNumber(4)
  void clearExpiresAt() => clearField(4);
}

class LoginWithPasscodeRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'LoginWithPasscodeRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'email')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'passcode')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'deviceId')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'deviceName')
    ..hasRequiredFields = false
  ;

  LoginWithPasscodeRequest._() : super();
  factory LoginWithPasscodeRequest({
    $core.String? email,
    $core.String? passcode,
    $core.String? deviceId,
    $core.String? deviceName,
  }) {
    final _result = create();
    if (email != null) {
      _result.email = email;
    }
    if (passcode != null) {
      _result.passcode = passcode;
    }
    if (deviceId != null) {
      _result.deviceId = deviceId;
    }
    if (deviceName != null) {
      _result.deviceName = deviceName;
    }
    return _result;
  }
  factory LoginWithPasscodeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LoginWithPasscodeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LoginWithPasscodeRequest clone() => LoginWithPasscodeRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LoginWithPasscodeRequest copyWith(void Function(LoginWithPasscodeRequest) updates) => super.copyWith((message) => updates(message as LoginWithPasscodeRequest)) as LoginWithPasscodeRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static LoginWithPasscodeRequest create() => LoginWithPasscodeRequest._();
  LoginWithPasscodeRequest createEmptyInstance() => create();
  static $pb.PbList<LoginWithPasscodeRequest> createRepeated() => $pb.PbList<LoginWithPasscodeRequest>();
  @$core.pragma('dart2js:noInline')
  static LoginWithPasscodeRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LoginWithPasscodeRequest>(create);
  static LoginWithPasscodeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get email => $_getSZ(0);
  @$pb.TagNumber(1)
  set email($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasEmail() => $_has(0);
  @$pb.TagNumber(1)
  void clearEmail() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get passcode => $_getSZ(1);
  @$pb.TagNumber(2)
  set passcode($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPasscode() => $_has(1);
  @$pb.TagNumber(2)
  void clearPasscode() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get deviceId => $_getSZ(2);
  @$pb.TagNumber(3)
  set deviceId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDeviceId() => $_has(2);
  @$pb.TagNumber(3)
  void clearDeviceId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get deviceName => $_getSZ(3);
  @$pb.TagNumber(4)
  set deviceName($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDeviceName() => $_has(3);
  @$pb.TagNumber(4)
  void clearDeviceName() => clearField(4);
}

class RegisterPasscodeRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RegisterPasscodeRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'passcode')
    ..hasRequiredFields = false
  ;

  RegisterPasscodeRequest._() : super();
  factory RegisterPasscodeRequest({
    $core.String? passcode,
  }) {
    final _result = create();
    if (passcode != null) {
      _result.passcode = passcode;
    }
    return _result;
  }
  factory RegisterPasscodeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RegisterPasscodeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RegisterPasscodeRequest clone() => RegisterPasscodeRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RegisterPasscodeRequest copyWith(void Function(RegisterPasscodeRequest) updates) => super.copyWith((message) => updates(message as RegisterPasscodeRequest)) as RegisterPasscodeRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RegisterPasscodeRequest create() => RegisterPasscodeRequest._();
  RegisterPasscodeRequest createEmptyInstance() => create();
  static $pb.PbList<RegisterPasscodeRequest> createRepeated() => $pb.PbList<RegisterPasscodeRequest>();
  @$core.pragma('dart2js:noInline')
  static RegisterPasscodeRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RegisterPasscodeRequest>(create);
  static RegisterPasscodeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get passcode => $_getSZ(0);
  @$pb.TagNumber(1)
  set passcode($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPasscode() => $_has(0);
  @$pb.TagNumber(1)
  void clearPasscode() => clearField(1);
}

class RegisterPasscodeResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RegisterPasscodeResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  RegisterPasscodeResponse._() : super();
  factory RegisterPasscodeResponse({
    $core.bool? success,
    $core.String? msg,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (msg != null) {
      _result.msg = msg;
    }
    return _result;
  }
  factory RegisterPasscodeResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RegisterPasscodeResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RegisterPasscodeResponse clone() => RegisterPasscodeResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RegisterPasscodeResponse copyWith(void Function(RegisterPasscodeResponse) updates) => super.copyWith((message) => updates(message as RegisterPasscodeResponse)) as RegisterPasscodeResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RegisterPasscodeResponse create() => RegisterPasscodeResponse._();
  RegisterPasscodeResponse createEmptyInstance() => create();
  static $pb.PbList<RegisterPasscodeResponse> createRepeated() => $pb.PbList<RegisterPasscodeResponse>();
  @$core.pragma('dart2js:noInline')
  static RegisterPasscodeResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RegisterPasscodeResponse>(create);
  static RegisterPasscodeResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get msg => $_getSZ(1);
  @$pb.TagNumber(2)
  set msg($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMsg() => $_has(1);
  @$pb.TagNumber(2)
  void clearMsg() => clearField(2);
}

class ChangePasscodeRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ChangePasscodeRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currentPasscode')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'newPasscode')
    ..hasRequiredFields = false
  ;

  ChangePasscodeRequest._() : super();
  factory ChangePasscodeRequest({
    $core.String? currentPasscode,
    $core.String? newPasscode,
  }) {
    final _result = create();
    if (currentPasscode != null) {
      _result.currentPasscode = currentPasscode;
    }
    if (newPasscode != null) {
      _result.newPasscode = newPasscode;
    }
    return _result;
  }
  factory ChangePasscodeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ChangePasscodeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ChangePasscodeRequest clone() => ChangePasscodeRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ChangePasscodeRequest copyWith(void Function(ChangePasscodeRequest) updates) => super.copyWith((message) => updates(message as ChangePasscodeRequest)) as ChangePasscodeRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ChangePasscodeRequest create() => ChangePasscodeRequest._();
  ChangePasscodeRequest createEmptyInstance() => create();
  static $pb.PbList<ChangePasscodeRequest> createRepeated() => $pb.PbList<ChangePasscodeRequest>();
  @$core.pragma('dart2js:noInline')
  static ChangePasscodeRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChangePasscodeRequest>(create);
  static ChangePasscodeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get currentPasscode => $_getSZ(0);
  @$pb.TagNumber(1)
  set currentPasscode($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCurrentPasscode() => $_has(0);
  @$pb.TagNumber(1)
  void clearCurrentPasscode() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get newPasscode => $_getSZ(1);
  @$pb.TagNumber(2)
  set newPasscode($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNewPasscode() => $_has(1);
  @$pb.TagNumber(2)
  void clearNewPasscode() => clearField(2);
}

class ChangePasscodeResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ChangePasscodeResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  ChangePasscodeResponse._() : super();
  factory ChangePasscodeResponse({
    $core.bool? success,
    $core.String? msg,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (msg != null) {
      _result.msg = msg;
    }
    return _result;
  }
  factory ChangePasscodeResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ChangePasscodeResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ChangePasscodeResponse clone() => ChangePasscodeResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ChangePasscodeResponse copyWith(void Function(ChangePasscodeResponse) updates) => super.copyWith((message) => updates(message as ChangePasscodeResponse)) as ChangePasscodeResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ChangePasscodeResponse create() => ChangePasscodeResponse._();
  ChangePasscodeResponse createEmptyInstance() => create();
  static $pb.PbList<ChangePasscodeResponse> createRepeated() => $pb.PbList<ChangePasscodeResponse>();
  @$core.pragma('dart2js:noInline')
  static ChangePasscodeResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChangePasscodeResponse>(create);
  static ChangePasscodeResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get msg => $_getSZ(1);
  @$pb.TagNumber(2)
  set msg($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMsg() => $_has(1);
  @$pb.TagNumber(2)
  void clearMsg() => clearField(2);
}

class RequestPasswordResetRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RequestPasswordResetRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'email')
    ..hasRequiredFields = false
  ;

  RequestPasswordResetRequest._() : super();
  factory RequestPasswordResetRequest({
    $core.String? email,
  }) {
    final _result = create();
    if (email != null) {
      _result.email = email;
    }
    return _result;
  }
  factory RequestPasswordResetRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RequestPasswordResetRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RequestPasswordResetRequest clone() => RequestPasswordResetRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RequestPasswordResetRequest copyWith(void Function(RequestPasswordResetRequest) updates) => super.copyWith((message) => updates(message as RequestPasswordResetRequest)) as RequestPasswordResetRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RequestPasswordResetRequest create() => RequestPasswordResetRequest._();
  RequestPasswordResetRequest createEmptyInstance() => create();
  static $pb.PbList<RequestPasswordResetRequest> createRepeated() => $pb.PbList<RequestPasswordResetRequest>();
  @$core.pragma('dart2js:noInline')
  static RequestPasswordResetRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RequestPasswordResetRequest>(create);
  static RequestPasswordResetRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get email => $_getSZ(0);
  @$pb.TagNumber(1)
  set email($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasEmail() => $_has(0);
  @$pb.TagNumber(1)
  void clearEmail() => clearField(1);
}

class RequestPasswordResetResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RequestPasswordResetResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  RequestPasswordResetResponse._() : super();
  factory RequestPasswordResetResponse({
    $core.bool? success,
    $core.String? msg,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (msg != null) {
      _result.msg = msg;
    }
    return _result;
  }
  factory RequestPasswordResetResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RequestPasswordResetResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RequestPasswordResetResponse clone() => RequestPasswordResetResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RequestPasswordResetResponse copyWith(void Function(RequestPasswordResetResponse) updates) => super.copyWith((message) => updates(message as RequestPasswordResetResponse)) as RequestPasswordResetResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RequestPasswordResetResponse create() => RequestPasswordResetResponse._();
  RequestPasswordResetResponse createEmptyInstance() => create();
  static $pb.PbList<RequestPasswordResetResponse> createRepeated() => $pb.PbList<RequestPasswordResetResponse>();
  @$core.pragma('dart2js:noInline')
  static RequestPasswordResetResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RequestPasswordResetResponse>(create);
  static RequestPasswordResetResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get msg => $_getSZ(1);
  @$pb.TagNumber(2)
  set msg($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMsg() => $_has(1);
  @$pb.TagNumber(2)
  void clearMsg() => clearField(2);
}

class RequestEmailVerificationRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RequestEmailVerificationRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'email')
    ..hasRequiredFields = false
  ;

  RequestEmailVerificationRequest._() : super();
  factory RequestEmailVerificationRequest({
    $core.String? email,
  }) {
    final _result = create();
    if (email != null) {
      _result.email = email;
    }
    return _result;
  }
  factory RequestEmailVerificationRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RequestEmailVerificationRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RequestEmailVerificationRequest clone() => RequestEmailVerificationRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RequestEmailVerificationRequest copyWith(void Function(RequestEmailVerificationRequest) updates) => super.copyWith((message) => updates(message as RequestEmailVerificationRequest)) as RequestEmailVerificationRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RequestEmailVerificationRequest create() => RequestEmailVerificationRequest._();
  RequestEmailVerificationRequest createEmptyInstance() => create();
  static $pb.PbList<RequestEmailVerificationRequest> createRepeated() => $pb.PbList<RequestEmailVerificationRequest>();
  @$core.pragma('dart2js:noInline')
  static RequestEmailVerificationRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RequestEmailVerificationRequest>(create);
  static RequestEmailVerificationRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get email => $_getSZ(0);
  @$pb.TagNumber(1)
  set email($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasEmail() => $_has(0);
  @$pb.TagNumber(1)
  void clearEmail() => clearField(1);
}

class RequestEmailVerificationResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RequestEmailVerificationResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  RequestEmailVerificationResponse._() : super();
  factory RequestEmailVerificationResponse({
    $core.bool? success,
    $core.String? msg,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (msg != null) {
      _result.msg = msg;
    }
    return _result;
  }
  factory RequestEmailVerificationResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RequestEmailVerificationResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RequestEmailVerificationResponse clone() => RequestEmailVerificationResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RequestEmailVerificationResponse copyWith(void Function(RequestEmailVerificationResponse) updates) => super.copyWith((message) => updates(message as RequestEmailVerificationResponse)) as RequestEmailVerificationResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RequestEmailVerificationResponse create() => RequestEmailVerificationResponse._();
  RequestEmailVerificationResponse createEmptyInstance() => create();
  static $pb.PbList<RequestEmailVerificationResponse> createRepeated() => $pb.PbList<RequestEmailVerificationResponse>();
  @$core.pragma('dart2js:noInline')
  static RequestEmailVerificationResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RequestEmailVerificationResponse>(create);
  static RequestEmailVerificationResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get msg => $_getSZ(1);
  @$pb.TagNumber(2)
  set msg($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMsg() => $_has(1);
  @$pb.TagNumber(2)
  void clearMsg() => clearField(2);
}

class CheckEmailAvailabilityRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CheckEmailAvailabilityRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'email')
    ..hasRequiredFields = false
  ;

  CheckEmailAvailabilityRequest._() : super();
  factory CheckEmailAvailabilityRequest({
    $core.String? email,
  }) {
    final _result = create();
    if (email != null) {
      _result.email = email;
    }
    return _result;
  }
  factory CheckEmailAvailabilityRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CheckEmailAvailabilityRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CheckEmailAvailabilityRequest clone() => CheckEmailAvailabilityRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CheckEmailAvailabilityRequest copyWith(void Function(CheckEmailAvailabilityRequest) updates) => super.copyWith((message) => updates(message as CheckEmailAvailabilityRequest)) as CheckEmailAvailabilityRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CheckEmailAvailabilityRequest create() => CheckEmailAvailabilityRequest._();
  CheckEmailAvailabilityRequest createEmptyInstance() => create();
  static $pb.PbList<CheckEmailAvailabilityRequest> createRepeated() => $pb.PbList<CheckEmailAvailabilityRequest>();
  @$core.pragma('dart2js:noInline')
  static CheckEmailAvailabilityRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CheckEmailAvailabilityRequest>(create);
  static CheckEmailAvailabilityRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get email => $_getSZ(0);
  @$pb.TagNumber(1)
  set email($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasEmail() => $_has(0);
  @$pb.TagNumber(1)
  void clearEmail() => clearField(1);
}

class CheckEmailAvailabilityResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CheckEmailAvailabilityResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'available')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  CheckEmailAvailabilityResponse._() : super();
  factory CheckEmailAvailabilityResponse({
    $core.bool? available,
    $core.String? msg,
  }) {
    final _result = create();
    if (available != null) {
      _result.available = available;
    }
    if (msg != null) {
      _result.msg = msg;
    }
    return _result;
  }
  factory CheckEmailAvailabilityResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CheckEmailAvailabilityResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CheckEmailAvailabilityResponse clone() => CheckEmailAvailabilityResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CheckEmailAvailabilityResponse copyWith(void Function(CheckEmailAvailabilityResponse) updates) => super.copyWith((message) => updates(message as CheckEmailAvailabilityResponse)) as CheckEmailAvailabilityResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CheckEmailAvailabilityResponse create() => CheckEmailAvailabilityResponse._();
  CheckEmailAvailabilityResponse createEmptyInstance() => create();
  static $pb.PbList<CheckEmailAvailabilityResponse> createRepeated() => $pb.PbList<CheckEmailAvailabilityResponse>();
  @$core.pragma('dart2js:noInline')
  static CheckEmailAvailabilityResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CheckEmailAvailabilityResponse>(create);
  static CheckEmailAvailabilityResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get available => $_getBF(0);
  @$pb.TagNumber(1)
  set available($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAvailable() => $_has(0);
  @$pb.TagNumber(1)
  void clearAvailable() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get msg => $_getSZ(1);
  @$pb.TagNumber(2)
  set msg($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMsg() => $_has(1);
  @$pb.TagNumber(2)
  void clearMsg() => clearField(2);
}

class RequestPhoneVerificationRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RequestPhoneVerificationRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'phone')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'countryCode')
    ..hasRequiredFields = false
  ;

  RequestPhoneVerificationRequest._() : super();
  factory RequestPhoneVerificationRequest({
    $core.String? phone,
    $core.String? countryCode,
  }) {
    final _result = create();
    if (phone != null) {
      _result.phone = phone;
    }
    if (countryCode != null) {
      _result.countryCode = countryCode;
    }
    return _result;
  }
  factory RequestPhoneVerificationRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RequestPhoneVerificationRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RequestPhoneVerificationRequest clone() => RequestPhoneVerificationRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RequestPhoneVerificationRequest copyWith(void Function(RequestPhoneVerificationRequest) updates) => super.copyWith((message) => updates(message as RequestPhoneVerificationRequest)) as RequestPhoneVerificationRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RequestPhoneVerificationRequest create() => RequestPhoneVerificationRequest._();
  RequestPhoneVerificationRequest createEmptyInstance() => create();
  static $pb.PbList<RequestPhoneVerificationRequest> createRepeated() => $pb.PbList<RequestPhoneVerificationRequest>();
  @$core.pragma('dart2js:noInline')
  static RequestPhoneVerificationRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RequestPhoneVerificationRequest>(create);
  static RequestPhoneVerificationRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get phone => $_getSZ(0);
  @$pb.TagNumber(1)
  set phone($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPhone() => $_has(0);
  @$pb.TagNumber(1)
  void clearPhone() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get countryCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set countryCode($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCountryCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearCountryCode() => clearField(2);
}

class RequestPhoneVerificationResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RequestPhoneVerificationResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'msg')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'verificationId')
    ..aInt64(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'expiresIn')
    ..hasRequiredFields = false
  ;

  RequestPhoneVerificationResponse._() : super();
  factory RequestPhoneVerificationResponse({
    $core.bool? success,
    $core.String? msg,
    $core.String? verificationId,
    $fixnum.Int64? expiresIn,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (msg != null) {
      _result.msg = msg;
    }
    if (verificationId != null) {
      _result.verificationId = verificationId;
    }
    if (expiresIn != null) {
      _result.expiresIn = expiresIn;
    }
    return _result;
  }
  factory RequestPhoneVerificationResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RequestPhoneVerificationResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RequestPhoneVerificationResponse clone() => RequestPhoneVerificationResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RequestPhoneVerificationResponse copyWith(void Function(RequestPhoneVerificationResponse) updates) => super.copyWith((message) => updates(message as RequestPhoneVerificationResponse)) as RequestPhoneVerificationResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RequestPhoneVerificationResponse create() => RequestPhoneVerificationResponse._();
  RequestPhoneVerificationResponse createEmptyInstance() => create();
  static $pb.PbList<RequestPhoneVerificationResponse> createRepeated() => $pb.PbList<RequestPhoneVerificationResponse>();
  @$core.pragma('dart2js:noInline')
  static RequestPhoneVerificationResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RequestPhoneVerificationResponse>(create);
  static RequestPhoneVerificationResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get msg => $_getSZ(1);
  @$pb.TagNumber(2)
  set msg($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMsg() => $_has(1);
  @$pb.TagNumber(2)
  void clearMsg() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get verificationId => $_getSZ(2);
  @$pb.TagNumber(3)
  set verificationId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasVerificationId() => $_has(2);
  @$pb.TagNumber(3)
  void clearVerificationId() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get expiresIn => $_getI64(3);
  @$pb.TagNumber(4)
  set expiresIn($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasExpiresIn() => $_has(3);
  @$pb.TagNumber(4)
  void clearExpiresIn() => clearField(4);
}

class VerifyPhoneNumberRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'VerifyPhoneNumberRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'phone')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'countryCode')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'code')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'verificationId')
    ..hasRequiredFields = false
  ;

  VerifyPhoneNumberRequest._() : super();
  factory VerifyPhoneNumberRequest({
    $core.String? phone,
    $core.String? countryCode,
    $core.String? code,
    $core.String? verificationId,
  }) {
    final _result = create();
    if (phone != null) {
      _result.phone = phone;
    }
    if (countryCode != null) {
      _result.countryCode = countryCode;
    }
    if (code != null) {
      _result.code = code;
    }
    if (verificationId != null) {
      _result.verificationId = verificationId;
    }
    return _result;
  }
  factory VerifyPhoneNumberRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VerifyPhoneNumberRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VerifyPhoneNumberRequest clone() => VerifyPhoneNumberRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VerifyPhoneNumberRequest copyWith(void Function(VerifyPhoneNumberRequest) updates) => super.copyWith((message) => updates(message as VerifyPhoneNumberRequest)) as VerifyPhoneNumberRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static VerifyPhoneNumberRequest create() => VerifyPhoneNumberRequest._();
  VerifyPhoneNumberRequest createEmptyInstance() => create();
  static $pb.PbList<VerifyPhoneNumberRequest> createRepeated() => $pb.PbList<VerifyPhoneNumberRequest>();
  @$core.pragma('dart2js:noInline')
  static VerifyPhoneNumberRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VerifyPhoneNumberRequest>(create);
  static VerifyPhoneNumberRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get phone => $_getSZ(0);
  @$pb.TagNumber(1)
  set phone($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPhone() => $_has(0);
  @$pb.TagNumber(1)
  void clearPhone() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get countryCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set countryCode($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCountryCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearCountryCode() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get code => $_getSZ(2);
  @$pb.TagNumber(3)
  set code($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCode() => $_has(2);
  @$pb.TagNumber(3)
  void clearCode() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get verificationId => $_getSZ(3);
  @$pb.TagNumber(4)
  set verificationId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasVerificationId() => $_has(3);
  @$pb.TagNumber(4)
  void clearVerificationId() => clearField(4);
}

class VerifyPhoneNumberResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'VerifyPhoneNumberResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'msg')
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isVerified')
    ..hasRequiredFields = false
  ;

  VerifyPhoneNumberResponse._() : super();
  factory VerifyPhoneNumberResponse({
    $core.bool? success,
    $core.String? msg,
    $core.bool? isVerified,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (msg != null) {
      _result.msg = msg;
    }
    if (isVerified != null) {
      _result.isVerified = isVerified;
    }
    return _result;
  }
  factory VerifyPhoneNumberResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VerifyPhoneNumberResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VerifyPhoneNumberResponse clone() => VerifyPhoneNumberResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VerifyPhoneNumberResponse copyWith(void Function(VerifyPhoneNumberResponse) updates) => super.copyWith((message) => updates(message as VerifyPhoneNumberResponse)) as VerifyPhoneNumberResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static VerifyPhoneNumberResponse create() => VerifyPhoneNumberResponse._();
  VerifyPhoneNumberResponse createEmptyInstance() => create();
  static $pb.PbList<VerifyPhoneNumberResponse> createRepeated() => $pb.PbList<VerifyPhoneNumberResponse>();
  @$core.pragma('dart2js:noInline')
  static VerifyPhoneNumberResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VerifyPhoneNumberResponse>(create);
  static VerifyPhoneNumberResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get msg => $_getSZ(1);
  @$pb.TagNumber(2)
  set msg($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMsg() => $_has(1);
  @$pb.TagNumber(2)
  void clearMsg() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get isVerified => $_getBF(2);
  @$pb.TagNumber(3)
  set isVerified($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasIsVerified() => $_has(2);
  @$pb.TagNumber(3)
  void clearIsVerified() => clearField(3);
}

class User extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'User', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'email')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'firstName')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lastName')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'phone')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'countryCode')
    ..aOB(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'emailVerified')
    ..aOB(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'phoneVerified')
    ..aOB(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'twoFactorEnabled')
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'twoFactorMethod')
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'profilePicture')
    ..aOS(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt')
    ..aOS(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedAt')
    ..aOS(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'signupStatus')
    ..aOS(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currentSignupStep')
    ..aOS(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'username')
    ..aOB(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'identityVerified')
    ..aOS(18, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'identityType')
    ..aOS(19, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'identityVerifiedAt')
    ..aOS(20, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dateOfBirth')
    ..hasRequiredFields = false
  ;

  User._() : super();
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
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (email != null) {
      _result.email = email;
    }
    if (firstName != null) {
      _result.firstName = firstName;
    }
    if (lastName != null) {
      _result.lastName = lastName;
    }
    if (phone != null) {
      _result.phone = phone;
    }
    if (countryCode != null) {
      _result.countryCode = countryCode;
    }
    if (emailVerified != null) {
      _result.emailVerified = emailVerified;
    }
    if (phoneVerified != null) {
      _result.phoneVerified = phoneVerified;
    }
    if (twoFactorEnabled != null) {
      _result.twoFactorEnabled = twoFactorEnabled;
    }
    if (twoFactorMethod != null) {
      _result.twoFactorMethod = twoFactorMethod;
    }
    if (profilePicture != null) {
      _result.profilePicture = profilePicture;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      _result.updatedAt = updatedAt;
    }
    if (signupStatus != null) {
      _result.signupStatus = signupStatus;
    }
    if (currentSignupStep != null) {
      _result.currentSignupStep = currentSignupStep;
    }
    if (username != null) {
      _result.username = username;
    }
    if (identityVerified != null) {
      _result.identityVerified = identityVerified;
    }
    if (identityType != null) {
      _result.identityType = identityType;
    }
    if (identityVerifiedAt != null) {
      _result.identityVerifiedAt = identityVerifiedAt;
    }
    if (dateOfBirth != null) {
      _result.dateOfBirth = dateOfBirth;
    }
    return _result;
  }
  factory User.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory User.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  User clone() => User()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  User copyWith(void Function(User) updates) => super.copyWith((message) => updates(message as User)) as User; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static User create() => User._();
  User createEmptyInstance() => create();
  static $pb.PbList<User> createRepeated() => $pb.PbList<User>();
  @$core.pragma('dart2js:noInline')
  static User getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<User>(create);
  static User? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get email => $_getSZ(1);
  @$pb.TagNumber(2)
  set email($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasEmail() => $_has(1);
  @$pb.TagNumber(2)
  void clearEmail() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get firstName => $_getSZ(2);
  @$pb.TagNumber(3)
  set firstName($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasFirstName() => $_has(2);
  @$pb.TagNumber(3)
  void clearFirstName() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get lastName => $_getSZ(3);
  @$pb.TagNumber(4)
  set lastName($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasLastName() => $_has(3);
  @$pb.TagNumber(4)
  void clearLastName() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get phone => $_getSZ(4);
  @$pb.TagNumber(5)
  set phone($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasPhone() => $_has(4);
  @$pb.TagNumber(5)
  void clearPhone() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get countryCode => $_getSZ(5);
  @$pb.TagNumber(6)
  set countryCode($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasCountryCode() => $_has(5);
  @$pb.TagNumber(6)
  void clearCountryCode() => clearField(6);

  @$pb.TagNumber(7)
  $core.bool get emailVerified => $_getBF(6);
  @$pb.TagNumber(7)
  set emailVerified($core.bool v) { $_setBool(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasEmailVerified() => $_has(6);
  @$pb.TagNumber(7)
  void clearEmailVerified() => clearField(7);

  @$pb.TagNumber(8)
  $core.bool get phoneVerified => $_getBF(7);
  @$pb.TagNumber(8)
  set phoneVerified($core.bool v) { $_setBool(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasPhoneVerified() => $_has(7);
  @$pb.TagNumber(8)
  void clearPhoneVerified() => clearField(8);

  @$pb.TagNumber(9)
  $core.bool get twoFactorEnabled => $_getBF(8);
  @$pb.TagNumber(9)
  set twoFactorEnabled($core.bool v) { $_setBool(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasTwoFactorEnabled() => $_has(8);
  @$pb.TagNumber(9)
  void clearTwoFactorEnabled() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get twoFactorMethod => $_getSZ(9);
  @$pb.TagNumber(10)
  set twoFactorMethod($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasTwoFactorMethod() => $_has(9);
  @$pb.TagNumber(10)
  void clearTwoFactorMethod() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get profilePicture => $_getSZ(10);
  @$pb.TagNumber(11)
  set profilePicture($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasProfilePicture() => $_has(10);
  @$pb.TagNumber(11)
  void clearProfilePicture() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get createdAt => $_getSZ(11);
  @$pb.TagNumber(12)
  set createdAt($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasCreatedAt() => $_has(11);
  @$pb.TagNumber(12)
  void clearCreatedAt() => clearField(12);

  @$pb.TagNumber(13)
  $core.String get updatedAt => $_getSZ(12);
  @$pb.TagNumber(13)
  set updatedAt($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasUpdatedAt() => $_has(12);
  @$pb.TagNumber(13)
  void clearUpdatedAt() => clearField(13);

  @$pb.TagNumber(14)
  $core.String get signupStatus => $_getSZ(13);
  @$pb.TagNumber(14)
  set signupStatus($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasSignupStatus() => $_has(13);
  @$pb.TagNumber(14)
  void clearSignupStatus() => clearField(14);

  @$pb.TagNumber(15)
  $core.String get currentSignupStep => $_getSZ(14);
  @$pb.TagNumber(15)
  set currentSignupStep($core.String v) { $_setString(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasCurrentSignupStep() => $_has(14);
  @$pb.TagNumber(15)
  void clearCurrentSignupStep() => clearField(15);

  @$pb.TagNumber(16)
  $core.String get username => $_getSZ(15);
  @$pb.TagNumber(16)
  set username($core.String v) { $_setString(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasUsername() => $_has(15);
  @$pb.TagNumber(16)
  void clearUsername() => clearField(16);

  @$pb.TagNumber(17)
  $core.bool get identityVerified => $_getBF(16);
  @$pb.TagNumber(17)
  set identityVerified($core.bool v) { $_setBool(16, v); }
  @$pb.TagNumber(17)
  $core.bool hasIdentityVerified() => $_has(16);
  @$pb.TagNumber(17)
  void clearIdentityVerified() => clearField(17);

  @$pb.TagNumber(18)
  $core.String get identityType => $_getSZ(17);
  @$pb.TagNumber(18)
  set identityType($core.String v) { $_setString(17, v); }
  @$pb.TagNumber(18)
  $core.bool hasIdentityType() => $_has(17);
  @$pb.TagNumber(18)
  void clearIdentityType() => clearField(18);

  @$pb.TagNumber(19)
  $core.String get identityVerifiedAt => $_getSZ(18);
  @$pb.TagNumber(19)
  set identityVerifiedAt($core.String v) { $_setString(18, v); }
  @$pb.TagNumber(19)
  $core.bool hasIdentityVerifiedAt() => $_has(18);
  @$pb.TagNumber(19)
  void clearIdentityVerifiedAt() => clearField(19);

  @$pb.TagNumber(20)
  $core.String get dateOfBirth => $_getSZ(19);
  @$pb.TagNumber(20)
  set dateOfBirth($core.String v) { $_setString(19, v); }
  @$pb.TagNumber(20)
  $core.bool hasDateOfBirth() => $_has(19);
  @$pb.TagNumber(20)
  void clearDateOfBirth() => clearField(20);
}

class SignupStepProgress extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SignupStepProgress', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'stepName')
    ..e<StepStatus>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: StepStatus.STEP_STATUS_UNSPECIFIED, valueOf: StepStatus.valueOf, enumValues: StepStatus.values)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'stepData')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'completedAt')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedAt')
    ..hasRequiredFields = false
  ;

  SignupStepProgress._() : super();
  factory SignupStepProgress({
    $core.String? stepName,
    StepStatus? status,
    $core.String? stepData,
    $core.String? completedAt,
    $core.String? createdAt,
    $core.String? updatedAt,
  }) {
    final _result = create();
    if (stepName != null) {
      _result.stepName = stepName;
    }
    if (status != null) {
      _result.status = status;
    }
    if (stepData != null) {
      _result.stepData = stepData;
    }
    if (completedAt != null) {
      _result.completedAt = completedAt;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      _result.updatedAt = updatedAt;
    }
    return _result;
  }
  factory SignupStepProgress.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SignupStepProgress.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SignupStepProgress clone() => SignupStepProgress()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SignupStepProgress copyWith(void Function(SignupStepProgress) updates) => super.copyWith((message) => updates(message as SignupStepProgress)) as SignupStepProgress; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SignupStepProgress create() => SignupStepProgress._();
  SignupStepProgress createEmptyInstance() => create();
  static $pb.PbList<SignupStepProgress> createRepeated() => $pb.PbList<SignupStepProgress>();
  @$core.pragma('dart2js:noInline')
  static SignupStepProgress getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SignupStepProgress>(create);
  static SignupStepProgress? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get stepName => $_getSZ(0);
  @$pb.TagNumber(1)
  set stepName($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStepName() => $_has(0);
  @$pb.TagNumber(1)
  void clearStepName() => clearField(1);

  @$pb.TagNumber(2)
  StepStatus get status => $_getN(1);
  @$pb.TagNumber(2)
  set status(StepStatus v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get stepData => $_getSZ(2);
  @$pb.TagNumber(3)
  set stepData($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasStepData() => $_has(2);
  @$pb.TagNumber(3)
  void clearStepData() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get completedAt => $_getSZ(3);
  @$pb.TagNumber(4)
  set completedAt($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCompletedAt() => $_has(3);
  @$pb.TagNumber(4)
  void clearCompletedAt() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get createdAt => $_getSZ(4);
  @$pb.TagNumber(5)
  set createdAt($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasCreatedAt() => $_has(4);
  @$pb.TagNumber(5)
  void clearCreatedAt() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get updatedAt => $_getSZ(5);
  @$pb.TagNumber(6)
  set updatedAt($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasUpdatedAt() => $_has(5);
  @$pb.TagNumber(6)
  void clearUpdatedAt() => clearField(6);
}

class SignupProgress extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SignupProgress', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..e<SignupStatus>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: SignupStatus.SIGNUP_STATUS_UNSPECIFIED, valueOf: SignupStatus.valueOf, enumValues: SignupStatus.values)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currentStep')
    ..pc<SignupStepProgress>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'steps', $pb.PbFieldType.PM, subBuilder: SignupStepProgress.create)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'signupCompletedAt')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedAt')
    ..hasRequiredFields = false
  ;

  SignupProgress._() : super();
  factory SignupProgress({
    $core.String? userId,
    SignupStatus? status,
    $core.String? currentStep,
    $core.Iterable<SignupStepProgress>? steps,
    $core.String? signupCompletedAt,
    $core.String? createdAt,
    $core.String? updatedAt,
  }) {
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    if (status != null) {
      _result.status = status;
    }
    if (currentStep != null) {
      _result.currentStep = currentStep;
    }
    if (steps != null) {
      _result.steps.addAll(steps);
    }
    if (signupCompletedAt != null) {
      _result.signupCompletedAt = signupCompletedAt;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      _result.updatedAt = updatedAt;
    }
    return _result;
  }
  factory SignupProgress.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SignupProgress.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SignupProgress clone() => SignupProgress()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SignupProgress copyWith(void Function(SignupProgress) updates) => super.copyWith((message) => updates(message as SignupProgress)) as SignupProgress; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SignupProgress create() => SignupProgress._();
  SignupProgress createEmptyInstance() => create();
  static $pb.PbList<SignupProgress> createRepeated() => $pb.PbList<SignupProgress>();
  @$core.pragma('dart2js:noInline')
  static SignupProgress getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SignupProgress>(create);
  static SignupProgress? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  SignupStatus get status => $_getN(1);
  @$pb.TagNumber(2)
  set status(SignupStatus v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get currentStep => $_getSZ(2);
  @$pb.TagNumber(3)
  set currentStep($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCurrentStep() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrentStep() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<SignupStepProgress> get steps => $_getList(3);

  @$pb.TagNumber(5)
  $core.String get signupCompletedAt => $_getSZ(4);
  @$pb.TagNumber(5)
  set signupCompletedAt($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasSignupCompletedAt() => $_has(4);
  @$pb.TagNumber(5)
  void clearSignupCompletedAt() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get createdAt => $_getSZ(5);
  @$pb.TagNumber(6)
  set createdAt($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasCreatedAt() => $_has(5);
  @$pb.TagNumber(6)
  void clearCreatedAt() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get updatedAt => $_getSZ(6);
  @$pb.TagNumber(7)
  set updatedAt($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasUpdatedAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearUpdatedAt() => clearField(7);
}

class GetSignupProgressRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetSignupProgressRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetSignupProgressRequest._() : super();
  factory GetSignupProgressRequest() => create();
  factory GetSignupProgressRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetSignupProgressRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetSignupProgressRequest clone() => GetSignupProgressRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetSignupProgressRequest copyWith(void Function(GetSignupProgressRequest) updates) => super.copyWith((message) => updates(message as GetSignupProgressRequest)) as GetSignupProgressRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetSignupProgressRequest create() => GetSignupProgressRequest._();
  GetSignupProgressRequest createEmptyInstance() => create();
  static $pb.PbList<GetSignupProgressRequest> createRepeated() => $pb.PbList<GetSignupProgressRequest>();
  @$core.pragma('dart2js:noInline')
  static GetSignupProgressRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetSignupProgressRequest>(create);
  static GetSignupProgressRequest? _defaultInstance;
}

class GetSignupProgressResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetSignupProgressResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'msg')
    ..aOM<SignupProgress>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'progress', subBuilder: SignupProgress.create)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'nextStep')
    ..aOB(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isComplete')
    ..hasRequiredFields = false
  ;

  GetSignupProgressResponse._() : super();
  factory GetSignupProgressResponse({
    $core.bool? success,
    $core.String? msg,
    SignupProgress? progress,
    $core.String? nextStep,
    $core.bool? isComplete,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (msg != null) {
      _result.msg = msg;
    }
    if (progress != null) {
      _result.progress = progress;
    }
    if (nextStep != null) {
      _result.nextStep = nextStep;
    }
    if (isComplete != null) {
      _result.isComplete = isComplete;
    }
    return _result;
  }
  factory GetSignupProgressResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetSignupProgressResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetSignupProgressResponse clone() => GetSignupProgressResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetSignupProgressResponse copyWith(void Function(GetSignupProgressResponse) updates) => super.copyWith((message) => updates(message as GetSignupProgressResponse)) as GetSignupProgressResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetSignupProgressResponse create() => GetSignupProgressResponse._();
  GetSignupProgressResponse createEmptyInstance() => create();
  static $pb.PbList<GetSignupProgressResponse> createRepeated() => $pb.PbList<GetSignupProgressResponse>();
  @$core.pragma('dart2js:noInline')
  static GetSignupProgressResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetSignupProgressResponse>(create);
  static GetSignupProgressResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get msg => $_getSZ(1);
  @$pb.TagNumber(2)
  set msg($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMsg() => $_has(1);
  @$pb.TagNumber(2)
  void clearMsg() => clearField(2);

  @$pb.TagNumber(3)
  SignupProgress get progress => $_getN(2);
  @$pb.TagNumber(3)
  set progress(SignupProgress v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasProgress() => $_has(2);
  @$pb.TagNumber(3)
  void clearProgress() => clearField(3);
  @$pb.TagNumber(3)
  SignupProgress ensureProgress() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.String get nextStep => $_getSZ(3);
  @$pb.TagNumber(4)
  set nextStep($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasNextStep() => $_has(3);
  @$pb.TagNumber(4)
  void clearNextStep() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get isComplete => $_getBF(4);
  @$pb.TagNumber(5)
  set isComplete($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasIsComplete() => $_has(4);
  @$pb.TagNumber(5)
  void clearIsComplete() => clearField(5);
}

class UpdateSignupStepRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateSignupStepRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'stepName')
    ..e<StepStatus>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: StepStatus.STEP_STATUS_UNSPECIFIED, valueOf: StepStatus.valueOf, enumValues: StepStatus.values)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'stepData')
    ..hasRequiredFields = false
  ;

  UpdateSignupStepRequest._() : super();
  factory UpdateSignupStepRequest({
    $core.String? stepName,
    StepStatus? status,
    $core.String? stepData,
  }) {
    final _result = create();
    if (stepName != null) {
      _result.stepName = stepName;
    }
    if (status != null) {
      _result.status = status;
    }
    if (stepData != null) {
      _result.stepData = stepData;
    }
    return _result;
  }
  factory UpdateSignupStepRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateSignupStepRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateSignupStepRequest clone() => UpdateSignupStepRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateSignupStepRequest copyWith(void Function(UpdateSignupStepRequest) updates) => super.copyWith((message) => updates(message as UpdateSignupStepRequest)) as UpdateSignupStepRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpdateSignupStepRequest create() => UpdateSignupStepRequest._();
  UpdateSignupStepRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateSignupStepRequest> createRepeated() => $pb.PbList<UpdateSignupStepRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateSignupStepRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateSignupStepRequest>(create);
  static UpdateSignupStepRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get stepName => $_getSZ(0);
  @$pb.TagNumber(1)
  set stepName($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStepName() => $_has(0);
  @$pb.TagNumber(1)
  void clearStepName() => clearField(1);

  @$pb.TagNumber(2)
  StepStatus get status => $_getN(1);
  @$pb.TagNumber(2)
  set status(StepStatus v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get stepData => $_getSZ(2);
  @$pb.TagNumber(3)
  set stepData($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasStepData() => $_has(2);
  @$pb.TagNumber(3)
  void clearStepData() => clearField(3);
}

class UpdateSignupStepResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateSignupStepResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'msg')
    ..aOM<SignupProgress>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'progress', subBuilder: SignupProgress.create)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'nextStep')
    ..hasRequiredFields = false
  ;

  UpdateSignupStepResponse._() : super();
  factory UpdateSignupStepResponse({
    $core.bool? success,
    $core.String? msg,
    SignupProgress? progress,
    $core.String? nextStep,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (msg != null) {
      _result.msg = msg;
    }
    if (progress != null) {
      _result.progress = progress;
    }
    if (nextStep != null) {
      _result.nextStep = nextStep;
    }
    return _result;
  }
  factory UpdateSignupStepResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateSignupStepResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateSignupStepResponse clone() => UpdateSignupStepResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateSignupStepResponse copyWith(void Function(UpdateSignupStepResponse) updates) => super.copyWith((message) => updates(message as UpdateSignupStepResponse)) as UpdateSignupStepResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpdateSignupStepResponse create() => UpdateSignupStepResponse._();
  UpdateSignupStepResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateSignupStepResponse> createRepeated() => $pb.PbList<UpdateSignupStepResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateSignupStepResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateSignupStepResponse>(create);
  static UpdateSignupStepResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get msg => $_getSZ(1);
  @$pb.TagNumber(2)
  set msg($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMsg() => $_has(1);
  @$pb.TagNumber(2)
  void clearMsg() => clearField(2);

  @$pb.TagNumber(3)
  SignupProgress get progress => $_getN(2);
  @$pb.TagNumber(3)
  set progress(SignupProgress v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasProgress() => $_has(2);
  @$pb.TagNumber(3)
  void clearProgress() => clearField(3);
  @$pb.TagNumber(3)
  SignupProgress ensureProgress() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.String get nextStep => $_getSZ(3);
  @$pb.TagNumber(4)
  set nextStep($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasNextStep() => $_has(3);
  @$pb.TagNumber(4)
  void clearNextStep() => clearField(4);
}

class CompleteSignupRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CompleteSignupRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  CompleteSignupRequest._() : super();
  factory CompleteSignupRequest() => create();
  factory CompleteSignupRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CompleteSignupRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CompleteSignupRequest clone() => CompleteSignupRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CompleteSignupRequest copyWith(void Function(CompleteSignupRequest) updates) => super.copyWith((message) => updates(message as CompleteSignupRequest)) as CompleteSignupRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CompleteSignupRequest create() => CompleteSignupRequest._();
  CompleteSignupRequest createEmptyInstance() => create();
  static $pb.PbList<CompleteSignupRequest> createRepeated() => $pb.PbList<CompleteSignupRequest>();
  @$core.pragma('dart2js:noInline')
  static CompleteSignupRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CompleteSignupRequest>(create);
  static CompleteSignupRequest? _defaultInstance;
}

class CompleteSignupResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CompleteSignupResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'msg')
    ..aOM<SignupProgress>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'progress', subBuilder: SignupProgress.create)
    ..hasRequiredFields = false
  ;

  CompleteSignupResponse._() : super();
  factory CompleteSignupResponse({
    $core.bool? success,
    $core.String? msg,
    SignupProgress? progress,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (msg != null) {
      _result.msg = msg;
    }
    if (progress != null) {
      _result.progress = progress;
    }
    return _result;
  }
  factory CompleteSignupResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CompleteSignupResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CompleteSignupResponse clone() => CompleteSignupResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CompleteSignupResponse copyWith(void Function(CompleteSignupResponse) updates) => super.copyWith((message) => updates(message as CompleteSignupResponse)) as CompleteSignupResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CompleteSignupResponse create() => CompleteSignupResponse._();
  CompleteSignupResponse createEmptyInstance() => create();
  static $pb.PbList<CompleteSignupResponse> createRepeated() => $pb.PbList<CompleteSignupResponse>();
  @$core.pragma('dart2js:noInline')
  static CompleteSignupResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CompleteSignupResponse>(create);
  static CompleteSignupResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get msg => $_getSZ(1);
  @$pb.TagNumber(2)
  set msg($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMsg() => $_has(1);
  @$pb.TagNumber(2)
  void clearMsg() => clearField(2);

  @$pb.TagNumber(3)
  SignupProgress get progress => $_getN(2);
  @$pb.TagNumber(3)
  set progress(SignupProgress v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasProgress() => $_has(2);
  @$pb.TagNumber(3)
  void clearProgress() => clearField(3);
  @$pb.TagNumber(3)
  SignupProgress ensureProgress() => $_ensure(2);
}

class VerifyIdentityRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'VerifyIdentityRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..e<IdentityType>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'identityType', $pb.PbFieldType.OE, defaultOrMaker: IdentityType.IDENTITY_TYPE_UNSPECIFIED, valueOf: IdentityType.valueOf, enumValues: IdentityType.values)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'identityNumber')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dateOfBirth')
    ..hasRequiredFields = false
  ;

  VerifyIdentityRequest._() : super();
  factory VerifyIdentityRequest({
    IdentityType? identityType,
    $core.String? identityNumber,
    $core.String? dateOfBirth,
  }) {
    final _result = create();
    if (identityType != null) {
      _result.identityType = identityType;
    }
    if (identityNumber != null) {
      _result.identityNumber = identityNumber;
    }
    if (dateOfBirth != null) {
      _result.dateOfBirth = dateOfBirth;
    }
    return _result;
  }
  factory VerifyIdentityRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VerifyIdentityRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VerifyIdentityRequest clone() => VerifyIdentityRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VerifyIdentityRequest copyWith(void Function(VerifyIdentityRequest) updates) => super.copyWith((message) => updates(message as VerifyIdentityRequest)) as VerifyIdentityRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static VerifyIdentityRequest create() => VerifyIdentityRequest._();
  VerifyIdentityRequest createEmptyInstance() => create();
  static $pb.PbList<VerifyIdentityRequest> createRepeated() => $pb.PbList<VerifyIdentityRequest>();
  @$core.pragma('dart2js:noInline')
  static VerifyIdentityRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VerifyIdentityRequest>(create);
  static VerifyIdentityRequest? _defaultInstance;

  @$pb.TagNumber(1)
  IdentityType get identityType => $_getN(0);
  @$pb.TagNumber(1)
  set identityType(IdentityType v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasIdentityType() => $_has(0);
  @$pb.TagNumber(1)
  void clearIdentityType() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get identityNumber => $_getSZ(1);
  @$pb.TagNumber(2)
  set identityNumber($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasIdentityNumber() => $_has(1);
  @$pb.TagNumber(2)
  void clearIdentityNumber() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get dateOfBirth => $_getSZ(2);
  @$pb.TagNumber(3)
  set dateOfBirth($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDateOfBirth() => $_has(2);
  @$pb.TagNumber(3)
  void clearDateOfBirth() => clearField(3);
}

class VerifiedIdentity extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'VerifiedIdentity', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'firstName')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lastName')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'middleName')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'phoneNumber')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dateOfBirth')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'gender')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'photoUrl')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'address')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'stateOfOrigin')
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lgaOfOrigin')
    ..hasRequiredFields = false
  ;

  VerifiedIdentity._() : super();
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
    final _result = create();
    if (firstName != null) {
      _result.firstName = firstName;
    }
    if (lastName != null) {
      _result.lastName = lastName;
    }
    if (middleName != null) {
      _result.middleName = middleName;
    }
    if (phoneNumber != null) {
      _result.phoneNumber = phoneNumber;
    }
    if (dateOfBirth != null) {
      _result.dateOfBirth = dateOfBirth;
    }
    if (gender != null) {
      _result.gender = gender;
    }
    if (photoUrl != null) {
      _result.photoUrl = photoUrl;
    }
    if (address != null) {
      _result.address = address;
    }
    if (stateOfOrigin != null) {
      _result.stateOfOrigin = stateOfOrigin;
    }
    if (lgaOfOrigin != null) {
      _result.lgaOfOrigin = lgaOfOrigin;
    }
    return _result;
  }
  factory VerifiedIdentity.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VerifiedIdentity.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VerifiedIdentity clone() => VerifiedIdentity()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VerifiedIdentity copyWith(void Function(VerifiedIdentity) updates) => super.copyWith((message) => updates(message as VerifiedIdentity)) as VerifiedIdentity; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static VerifiedIdentity create() => VerifiedIdentity._();
  VerifiedIdentity createEmptyInstance() => create();
  static $pb.PbList<VerifiedIdentity> createRepeated() => $pb.PbList<VerifiedIdentity>();
  @$core.pragma('dart2js:noInline')
  static VerifiedIdentity getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VerifiedIdentity>(create);
  static VerifiedIdentity? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get firstName => $_getSZ(0);
  @$pb.TagNumber(1)
  set firstName($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFirstName() => $_has(0);
  @$pb.TagNumber(1)
  void clearFirstName() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get lastName => $_getSZ(1);
  @$pb.TagNumber(2)
  set lastName($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLastName() => $_has(1);
  @$pb.TagNumber(2)
  void clearLastName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get middleName => $_getSZ(2);
  @$pb.TagNumber(3)
  set middleName($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMiddleName() => $_has(2);
  @$pb.TagNumber(3)
  void clearMiddleName() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get phoneNumber => $_getSZ(3);
  @$pb.TagNumber(4)
  set phoneNumber($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPhoneNumber() => $_has(3);
  @$pb.TagNumber(4)
  void clearPhoneNumber() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get dateOfBirth => $_getSZ(4);
  @$pb.TagNumber(5)
  set dateOfBirth($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasDateOfBirth() => $_has(4);
  @$pb.TagNumber(5)
  void clearDateOfBirth() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get gender => $_getSZ(5);
  @$pb.TagNumber(6)
  set gender($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasGender() => $_has(5);
  @$pb.TagNumber(6)
  void clearGender() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get photoUrl => $_getSZ(6);
  @$pb.TagNumber(7)
  set photoUrl($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasPhotoUrl() => $_has(6);
  @$pb.TagNumber(7)
  void clearPhotoUrl() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get address => $_getSZ(7);
  @$pb.TagNumber(8)
  set address($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasAddress() => $_has(7);
  @$pb.TagNumber(8)
  void clearAddress() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get stateOfOrigin => $_getSZ(8);
  @$pb.TagNumber(9)
  set stateOfOrigin($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasStateOfOrigin() => $_has(8);
  @$pb.TagNumber(9)
  void clearStateOfOrigin() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get lgaOfOrigin => $_getSZ(9);
  @$pb.TagNumber(10)
  set lgaOfOrigin($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasLgaOfOrigin() => $_has(9);
  @$pb.TagNumber(10)
  void clearLgaOfOrigin() => clearField(10);
}

class VerifyIdentityResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'VerifyIdentityResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'verified')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorCode')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorMessage')
    ..aOM<VerifiedIdentity>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'identity', subBuilder: VerifiedIdentity.create)
    ..aOM<VirtualAccountInfo>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'virtualAccount', subBuilder: VirtualAccountInfo.create)
    ..hasRequiredFields = false
  ;

  VerifyIdentityResponse._() : super();
  factory VerifyIdentityResponse({
    $core.bool? success,
    $core.bool? verified,
    $core.String? errorCode,
    $core.String? errorMessage,
    VerifiedIdentity? identity,
    VirtualAccountInfo? virtualAccount,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (verified != null) {
      _result.verified = verified;
    }
    if (errorCode != null) {
      _result.errorCode = errorCode;
    }
    if (errorMessage != null) {
      _result.errorMessage = errorMessage;
    }
    if (identity != null) {
      _result.identity = identity;
    }
    if (virtualAccount != null) {
      _result.virtualAccount = virtualAccount;
    }
    return _result;
  }
  factory VerifyIdentityResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VerifyIdentityResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VerifyIdentityResponse clone() => VerifyIdentityResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VerifyIdentityResponse copyWith(void Function(VerifyIdentityResponse) updates) => super.copyWith((message) => updates(message as VerifyIdentityResponse)) as VerifyIdentityResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static VerifyIdentityResponse create() => VerifyIdentityResponse._();
  VerifyIdentityResponse createEmptyInstance() => create();
  static $pb.PbList<VerifyIdentityResponse> createRepeated() => $pb.PbList<VerifyIdentityResponse>();
  @$core.pragma('dart2js:noInline')
  static VerifyIdentityResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VerifyIdentityResponse>(create);
  static VerifyIdentityResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get verified => $_getBF(1);
  @$pb.TagNumber(2)
  set verified($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasVerified() => $_has(1);
  @$pb.TagNumber(2)
  void clearVerified() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorCode => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorCode($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasErrorCode() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorCode() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get errorMessage => $_getSZ(3);
  @$pb.TagNumber(4)
  set errorMessage($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasErrorMessage() => $_has(3);
  @$pb.TagNumber(4)
  void clearErrorMessage() => clearField(4);

  @$pb.TagNumber(5)
  VerifiedIdentity get identity => $_getN(4);
  @$pb.TagNumber(5)
  set identity(VerifiedIdentity v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasIdentity() => $_has(4);
  @$pb.TagNumber(5)
  void clearIdentity() => clearField(5);
  @$pb.TagNumber(5)
  VerifiedIdentity ensureIdentity() => $_ensure(4);

  @$pb.TagNumber(6)
  VirtualAccountInfo get virtualAccount => $_getN(5);
  @$pb.TagNumber(6)
  set virtualAccount(VirtualAccountInfo v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasVirtualAccount() => $_has(5);
  @$pb.TagNumber(6)
  void clearVirtualAccount() => clearField(6);
  @$pb.TagNumber(6)
  VirtualAccountInfo ensureVirtualAccount() => $_ensure(5);
}

class VirtualAccountInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'VirtualAccountInfo', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountNumber')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bankName')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bankCode')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountName')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'provider')
    ..hasRequiredFields = false
  ;

  VirtualAccountInfo._() : super();
  factory VirtualAccountInfo({
    $core.String? accountNumber,
    $core.String? bankName,
    $core.String? bankCode,
    $core.String? accountName,
    $core.String? currency,
    $core.String? provider,
  }) {
    final _result = create();
    if (accountNumber != null) {
      _result.accountNumber = accountNumber;
    }
    if (bankName != null) {
      _result.bankName = bankName;
    }
    if (bankCode != null) {
      _result.bankCode = bankCode;
    }
    if (accountName != null) {
      _result.accountName = accountName;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (provider != null) {
      _result.provider = provider;
    }
    return _result;
  }
  factory VirtualAccountInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VirtualAccountInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VirtualAccountInfo clone() => VirtualAccountInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VirtualAccountInfo copyWith(void Function(VirtualAccountInfo) updates) => super.copyWith((message) => updates(message as VirtualAccountInfo)) as VirtualAccountInfo; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static VirtualAccountInfo create() => VirtualAccountInfo._();
  VirtualAccountInfo createEmptyInstance() => create();
  static $pb.PbList<VirtualAccountInfo> createRepeated() => $pb.PbList<VirtualAccountInfo>();
  @$core.pragma('dart2js:noInline')
  static VirtualAccountInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VirtualAccountInfo>(create);
  static VirtualAccountInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountNumber => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountNumber($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccountNumber() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountNumber() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get bankName => $_getSZ(1);
  @$pb.TagNumber(2)
  set bankName($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasBankName() => $_has(1);
  @$pb.TagNumber(2)
  void clearBankName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get bankCode => $_getSZ(2);
  @$pb.TagNumber(3)
  set bankCode($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasBankCode() => $_has(2);
  @$pb.TagNumber(3)
  void clearBankCode() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get accountName => $_getSZ(3);
  @$pb.TagNumber(4)
  set accountName($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAccountName() => $_has(3);
  @$pb.TagNumber(4)
  void clearAccountName() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get currency => $_getSZ(4);
  @$pb.TagNumber(5)
  set currency($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasCurrency() => $_has(4);
  @$pb.TagNumber(5)
  void clearCurrency() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get provider => $_getSZ(5);
  @$pb.TagNumber(6)
  set provider($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasProvider() => $_has(5);
  @$pb.TagNumber(6)
  void clearProvider() => clearField(6);
}

class GetIdentityVerificationStatusRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetIdentityVerificationStatusRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetIdentityVerificationStatusRequest._() : super();
  factory GetIdentityVerificationStatusRequest() => create();
  factory GetIdentityVerificationStatusRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetIdentityVerificationStatusRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetIdentityVerificationStatusRequest clone() => GetIdentityVerificationStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetIdentityVerificationStatusRequest copyWith(void Function(GetIdentityVerificationStatusRequest) updates) => super.copyWith((message) => updates(message as GetIdentityVerificationStatusRequest)) as GetIdentityVerificationStatusRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetIdentityVerificationStatusRequest create() => GetIdentityVerificationStatusRequest._();
  GetIdentityVerificationStatusRequest createEmptyInstance() => create();
  static $pb.PbList<GetIdentityVerificationStatusRequest> createRepeated() => $pb.PbList<GetIdentityVerificationStatusRequest>();
  @$core.pragma('dart2js:noInline')
  static GetIdentityVerificationStatusRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetIdentityVerificationStatusRequest>(create);
  static GetIdentityVerificationStatusRequest? _defaultInstance;
}

class GetIdentityVerificationStatusResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetIdentityVerificationStatusResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'msg')
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'identityVerified')
    ..e<IdentityType>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'identityType', $pb.PbFieldType.OE, defaultOrMaker: IdentityType.IDENTITY_TYPE_UNSPECIFIED, valueOf: IdentityType.valueOf, enumValues: IdentityType.values)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'identityVerifiedAt')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'maskedIdentityNumber')
    ..hasRequiredFields = false
  ;

  GetIdentityVerificationStatusResponse._() : super();
  factory GetIdentityVerificationStatusResponse({
    $core.bool? success,
    $core.String? msg,
    $core.bool? identityVerified,
    IdentityType? identityType,
    $core.String? identityVerifiedAt,
    $core.String? maskedIdentityNumber,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (msg != null) {
      _result.msg = msg;
    }
    if (identityVerified != null) {
      _result.identityVerified = identityVerified;
    }
    if (identityType != null) {
      _result.identityType = identityType;
    }
    if (identityVerifiedAt != null) {
      _result.identityVerifiedAt = identityVerifiedAt;
    }
    if (maskedIdentityNumber != null) {
      _result.maskedIdentityNumber = maskedIdentityNumber;
    }
    return _result;
  }
  factory GetIdentityVerificationStatusResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetIdentityVerificationStatusResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetIdentityVerificationStatusResponse clone() => GetIdentityVerificationStatusResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetIdentityVerificationStatusResponse copyWith(void Function(GetIdentityVerificationStatusResponse) updates) => super.copyWith((message) => updates(message as GetIdentityVerificationStatusResponse)) as GetIdentityVerificationStatusResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetIdentityVerificationStatusResponse create() => GetIdentityVerificationStatusResponse._();
  GetIdentityVerificationStatusResponse createEmptyInstance() => create();
  static $pb.PbList<GetIdentityVerificationStatusResponse> createRepeated() => $pb.PbList<GetIdentityVerificationStatusResponse>();
  @$core.pragma('dart2js:noInline')
  static GetIdentityVerificationStatusResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetIdentityVerificationStatusResponse>(create);
  static GetIdentityVerificationStatusResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get msg => $_getSZ(1);
  @$pb.TagNumber(2)
  set msg($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMsg() => $_has(1);
  @$pb.TagNumber(2)
  void clearMsg() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get identityVerified => $_getBF(2);
  @$pb.TagNumber(3)
  set identityVerified($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasIdentityVerified() => $_has(2);
  @$pb.TagNumber(3)
  void clearIdentityVerified() => clearField(3);

  @$pb.TagNumber(4)
  IdentityType get identityType => $_getN(3);
  @$pb.TagNumber(4)
  set identityType(IdentityType v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasIdentityType() => $_has(3);
  @$pb.TagNumber(4)
  void clearIdentityType() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get identityVerifiedAt => $_getSZ(4);
  @$pb.TagNumber(5)
  set identityVerifiedAt($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasIdentityVerifiedAt() => $_has(4);
  @$pb.TagNumber(5)
  void clearIdentityVerifiedAt() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get maskedIdentityNumber => $_getSZ(5);
  @$pb.TagNumber(6)
  set maskedIdentityNumber($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasMaskedIdentityNumber() => $_has(5);
  @$pb.TagNumber(6)
  void clearMaskedIdentityNumber() => clearField(6);
}

class LookupUserByUsernameRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'LookupUserByUsernameRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'username')
    ..hasRequiredFields = false
  ;

  LookupUserByUsernameRequest._() : super();
  factory LookupUserByUsernameRequest({
    $core.String? username,
  }) {
    final _result = create();
    if (username != null) {
      _result.username = username;
    }
    return _result;
  }
  factory LookupUserByUsernameRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LookupUserByUsernameRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LookupUserByUsernameRequest clone() => LookupUserByUsernameRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LookupUserByUsernameRequest copyWith(void Function(LookupUserByUsernameRequest) updates) => super.copyWith((message) => updates(message as LookupUserByUsernameRequest)) as LookupUserByUsernameRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static LookupUserByUsernameRequest create() => LookupUserByUsernameRequest._();
  LookupUserByUsernameRequest createEmptyInstance() => create();
  static $pb.PbList<LookupUserByUsernameRequest> createRepeated() => $pb.PbList<LookupUserByUsernameRequest>();
  @$core.pragma('dart2js:noInline')
  static LookupUserByUsernameRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LookupUserByUsernameRequest>(create);
  static LookupUserByUsernameRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get username => $_getSZ(0);
  @$pb.TagNumber(1)
  set username($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUsername() => $_has(0);
  @$pb.TagNumber(1)
  void clearUsername() => clearField(1);
}

class LookupUserByPhoneRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'LookupUserByPhoneRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'phone')
    ..hasRequiredFields = false
  ;

  LookupUserByPhoneRequest._() : super();
  factory LookupUserByPhoneRequest({
    $core.String? phone,
  }) {
    final _result = create();
    if (phone != null) {
      _result.phone = phone;
    }
    return _result;
  }
  factory LookupUserByPhoneRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LookupUserByPhoneRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LookupUserByPhoneRequest clone() => LookupUserByPhoneRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LookupUserByPhoneRequest copyWith(void Function(LookupUserByPhoneRequest) updates) => super.copyWith((message) => updates(message as LookupUserByPhoneRequest)) as LookupUserByPhoneRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static LookupUserByPhoneRequest create() => LookupUserByPhoneRequest._();
  LookupUserByPhoneRequest createEmptyInstance() => create();
  static $pb.PbList<LookupUserByPhoneRequest> createRepeated() => $pb.PbList<LookupUserByPhoneRequest>();
  @$core.pragma('dart2js:noInline')
  static LookupUserByPhoneRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LookupUserByPhoneRequest>(create);
  static LookupUserByPhoneRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get phone => $_getSZ(0);
  @$pb.TagNumber(1)
  set phone($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPhone() => $_has(0);
  @$pb.TagNumber(1)
  void clearPhone() => clearField(1);
}

class UserLookupResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UserLookupResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'msg')
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'found')
    ..aOM<UserLookupResult>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'user', subBuilder: UserLookupResult.create)
    ..hasRequiredFields = false
  ;

  UserLookupResponse._() : super();
  factory UserLookupResponse({
    $core.bool? success,
    $core.String? msg,
    $core.bool? found,
    UserLookupResult? user,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (msg != null) {
      _result.msg = msg;
    }
    if (found != null) {
      _result.found = found;
    }
    if (user != null) {
      _result.user = user;
    }
    return _result;
  }
  factory UserLookupResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UserLookupResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UserLookupResponse clone() => UserLookupResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UserLookupResponse copyWith(void Function(UserLookupResponse) updates) => super.copyWith((message) => updates(message as UserLookupResponse)) as UserLookupResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UserLookupResponse create() => UserLookupResponse._();
  UserLookupResponse createEmptyInstance() => create();
  static $pb.PbList<UserLookupResponse> createRepeated() => $pb.PbList<UserLookupResponse>();
  @$core.pragma('dart2js:noInline')
  static UserLookupResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UserLookupResponse>(create);
  static UserLookupResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get msg => $_getSZ(1);
  @$pb.TagNumber(2)
  set msg($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMsg() => $_has(1);
  @$pb.TagNumber(2)
  void clearMsg() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get found => $_getBF(2);
  @$pb.TagNumber(3)
  set found($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasFound() => $_has(2);
  @$pb.TagNumber(3)
  void clearFound() => clearField(3);

  @$pb.TagNumber(4)
  UserLookupResult get user => $_getN(3);
  @$pb.TagNumber(4)
  set user(UserLookupResult v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasUser() => $_has(3);
  @$pb.TagNumber(4)
  void clearUser() => clearField(4);
  @$pb.TagNumber(4)
  UserLookupResult ensureUser() => $_ensure(3);
}

class UserLookupResult extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UserLookupResult', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'username')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'firstName')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lastName')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'profilePicture')
    ..aOB(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isLazervaultUser')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'phoneNumber')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'email')
    ..hasRequiredFields = false
  ;

  UserLookupResult._() : super();
  factory UserLookupResult({
    $core.String? userId,
    $core.String? username,
    $core.String? firstName,
    $core.String? lastName,
    $core.String? profilePicture,
    $core.bool? isLazervaultUser,
    $core.String? phoneNumber,
    $core.String? email,
  }) {
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    if (username != null) {
      _result.username = username;
    }
    if (firstName != null) {
      _result.firstName = firstName;
    }
    if (lastName != null) {
      _result.lastName = lastName;
    }
    if (profilePicture != null) {
      _result.profilePicture = profilePicture;
    }
    if (isLazervaultUser != null) {
      _result.isLazervaultUser = isLazervaultUser;
    }
    if (phoneNumber != null) {
      _result.phoneNumber = phoneNumber;
    }
    if (email != null) {
      _result.email = email;
    }
    return _result;
  }
  factory UserLookupResult.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UserLookupResult.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UserLookupResult clone() => UserLookupResult()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UserLookupResult copyWith(void Function(UserLookupResult) updates) => super.copyWith((message) => updates(message as UserLookupResult)) as UserLookupResult; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UserLookupResult create() => UserLookupResult._();
  UserLookupResult createEmptyInstance() => create();
  static $pb.PbList<UserLookupResult> createRepeated() => $pb.PbList<UserLookupResult>();
  @$core.pragma('dart2js:noInline')
  static UserLookupResult getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UserLookupResult>(create);
  static UserLookupResult? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get username => $_getSZ(1);
  @$pb.TagNumber(2)
  set username($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUsername() => $_has(1);
  @$pb.TagNumber(2)
  void clearUsername() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get firstName => $_getSZ(2);
  @$pb.TagNumber(3)
  set firstName($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasFirstName() => $_has(2);
  @$pb.TagNumber(3)
  void clearFirstName() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get lastName => $_getSZ(3);
  @$pb.TagNumber(4)
  set lastName($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasLastName() => $_has(3);
  @$pb.TagNumber(4)
  void clearLastName() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get profilePicture => $_getSZ(4);
  @$pb.TagNumber(5)
  set profilePicture($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasProfilePicture() => $_has(4);
  @$pb.TagNumber(5)
  void clearProfilePicture() => clearField(5);

  @$pb.TagNumber(6)
  $core.bool get isLazervaultUser => $_getBF(5);
  @$pb.TagNumber(6)
  set isLazervaultUser($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasIsLazervaultUser() => $_has(5);
  @$pb.TagNumber(6)
  void clearIsLazervaultUser() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get phoneNumber => $_getSZ(6);
  @$pb.TagNumber(7)
  set phoneNumber($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasPhoneNumber() => $_has(6);
  @$pb.TagNumber(7)
  void clearPhoneNumber() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get email => $_getSZ(7);
  @$pb.TagNumber(8)
  set email($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasEmail() => $_has(7);
  @$pb.TagNumber(8)
  void clearEmail() => clearField(8);
}

class SearchUsersByUsernameRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SearchUsersByUsernameRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'query')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'searchType')
    ..hasRequiredFields = false
  ;

  SearchUsersByUsernameRequest._() : super();
  factory SearchUsersByUsernameRequest({
    $core.String? query,
    $core.int? limit,
    $core.String? searchType,
  }) {
    final _result = create();
    if (query != null) {
      _result.query = query;
    }
    if (limit != null) {
      _result.limit = limit;
    }
    if (searchType != null) {
      _result.searchType = searchType;
    }
    return _result;
  }
  factory SearchUsersByUsernameRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SearchUsersByUsernameRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SearchUsersByUsernameRequest clone() => SearchUsersByUsernameRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SearchUsersByUsernameRequest copyWith(void Function(SearchUsersByUsernameRequest) updates) => super.copyWith((message) => updates(message as SearchUsersByUsernameRequest)) as SearchUsersByUsernameRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SearchUsersByUsernameRequest create() => SearchUsersByUsernameRequest._();
  SearchUsersByUsernameRequest createEmptyInstance() => create();
  static $pb.PbList<SearchUsersByUsernameRequest> createRepeated() => $pb.PbList<SearchUsersByUsernameRequest>();
  @$core.pragma('dart2js:noInline')
  static SearchUsersByUsernameRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SearchUsersByUsernameRequest>(create);
  static SearchUsersByUsernameRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get query => $_getSZ(0);
  @$pb.TagNumber(1)
  set query($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasQuery() => $_has(0);
  @$pb.TagNumber(1)
  void clearQuery() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get limit => $_getIZ(1);
  @$pb.TagNumber(2)
  set limit($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get searchType => $_getSZ(2);
  @$pb.TagNumber(3)
  set searchType($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSearchType() => $_has(2);
  @$pb.TagNumber(3)
  void clearSearchType() => clearField(3);
}

class SearchUsersByUsernameResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SearchUsersByUsernameResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'msg')
    ..pc<UserLookupResult>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'users', $pb.PbFieldType.PM, subBuilder: UserLookupResult.create)
    ..hasRequiredFields = false
  ;

  SearchUsersByUsernameResponse._() : super();
  factory SearchUsersByUsernameResponse({
    $core.bool? success,
    $core.String? msg,
    $core.Iterable<UserLookupResult>? users,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (msg != null) {
      _result.msg = msg;
    }
    if (users != null) {
      _result.users.addAll(users);
    }
    return _result;
  }
  factory SearchUsersByUsernameResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SearchUsersByUsernameResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SearchUsersByUsernameResponse clone() => SearchUsersByUsernameResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SearchUsersByUsernameResponse copyWith(void Function(SearchUsersByUsernameResponse) updates) => super.copyWith((message) => updates(message as SearchUsersByUsernameResponse)) as SearchUsersByUsernameResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SearchUsersByUsernameResponse create() => SearchUsersByUsernameResponse._();
  SearchUsersByUsernameResponse createEmptyInstance() => create();
  static $pb.PbList<SearchUsersByUsernameResponse> createRepeated() => $pb.PbList<SearchUsersByUsernameResponse>();
  @$core.pragma('dart2js:noInline')
  static SearchUsersByUsernameResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SearchUsersByUsernameResponse>(create);
  static SearchUsersByUsernameResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get msg => $_getSZ(1);
  @$pb.TagNumber(2)
  set msg($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMsg() => $_has(1);
  @$pb.TagNumber(2)
  void clearMsg() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<UserLookupResult> get users => $_getList(2);
}

class InitiateKYCRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'InitiateKYCRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..e<KYCTier>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'targetTier', $pb.PbFieldType.OE, defaultOrMaker: KYCTier.KYC_TIER_UNKNOWN, valueOf: KYCTier.valueOf, enumValues: KYCTier.values)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'countryCode')
    ..hasRequiredFields = false
  ;

  InitiateKYCRequest._() : super();
  factory InitiateKYCRequest({
    KYCTier? targetTier,
    $core.String? countryCode,
  }) {
    final _result = create();
    if (targetTier != null) {
      _result.targetTier = targetTier;
    }
    if (countryCode != null) {
      _result.countryCode = countryCode;
    }
    return _result;
  }
  factory InitiateKYCRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InitiateKYCRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InitiateKYCRequest clone() => InitiateKYCRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InitiateKYCRequest copyWith(void Function(InitiateKYCRequest) updates) => super.copyWith((message) => updates(message as InitiateKYCRequest)) as InitiateKYCRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static InitiateKYCRequest create() => InitiateKYCRequest._();
  InitiateKYCRequest createEmptyInstance() => create();
  static $pb.PbList<InitiateKYCRequest> createRepeated() => $pb.PbList<InitiateKYCRequest>();
  @$core.pragma('dart2js:noInline')
  static InitiateKYCRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InitiateKYCRequest>(create);
  static InitiateKYCRequest? _defaultInstance;

  @$pb.TagNumber(1)
  KYCTier get targetTier => $_getN(0);
  @$pb.TagNumber(1)
  set targetTier(KYCTier v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasTargetTier() => $_has(0);
  @$pb.TagNumber(1)
  void clearTargetTier() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get countryCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set countryCode($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCountryCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearCountryCode() => clearField(2);
}

class InitiateKYCResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'InitiateKYCResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sessionId')
    ..pPS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'requiredDocuments')
    ..pPS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'requiredFields')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'redirectUrl')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorMessage')
    ..hasRequiredFields = false
  ;

  InitiateKYCResponse._() : super();
  factory InitiateKYCResponse({
    $core.bool? success,
    $core.String? sessionId,
    $core.Iterable<$core.String>? requiredDocuments,
    $core.Iterable<$core.String>? requiredFields,
    $core.String? redirectUrl,
    $core.String? errorMessage,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (sessionId != null) {
      _result.sessionId = sessionId;
    }
    if (requiredDocuments != null) {
      _result.requiredDocuments.addAll(requiredDocuments);
    }
    if (requiredFields != null) {
      _result.requiredFields.addAll(requiredFields);
    }
    if (redirectUrl != null) {
      _result.redirectUrl = redirectUrl;
    }
    if (errorMessage != null) {
      _result.errorMessage = errorMessage;
    }
    return _result;
  }
  factory InitiateKYCResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InitiateKYCResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InitiateKYCResponse clone() => InitiateKYCResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InitiateKYCResponse copyWith(void Function(InitiateKYCResponse) updates) => super.copyWith((message) => updates(message as InitiateKYCResponse)) as InitiateKYCResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static InitiateKYCResponse create() => InitiateKYCResponse._();
  InitiateKYCResponse createEmptyInstance() => create();
  static $pb.PbList<InitiateKYCResponse> createRepeated() => $pb.PbList<InitiateKYCResponse>();
  @$core.pragma('dart2js:noInline')
  static InitiateKYCResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InitiateKYCResponse>(create);
  static InitiateKYCResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get sessionId => $_getSZ(1);
  @$pb.TagNumber(2)
  set sessionId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSessionId() => $_has(1);
  @$pb.TagNumber(2)
  void clearSessionId() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.String> get requiredDocuments => $_getList(2);

  @$pb.TagNumber(4)
  $core.List<$core.String> get requiredFields => $_getList(3);

  @$pb.TagNumber(5)
  $core.String get redirectUrl => $_getSZ(4);
  @$pb.TagNumber(5)
  set redirectUrl($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasRedirectUrl() => $_has(4);
  @$pb.TagNumber(5)
  void clearRedirectUrl() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get errorMessage => $_getSZ(5);
  @$pb.TagNumber(6)
  set errorMessage($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasErrorMessage() => $_has(5);
  @$pb.TagNumber(6)
  void clearErrorMessage() => clearField(6);
}

class UploadDocumentRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UploadDocumentRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..e<DocumentType>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'documentType', $pb.PbFieldType.OE, defaultOrMaker: DocumentType.DOCUMENT_TYPE_UNKNOWN, valueOf: DocumentType.valueOf, enumValues: DocumentType.values)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'documentFrontUrl')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'documentBackUrl')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'selfieUrl')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'proofOfAddressUrl')
    ..hasRequiredFields = false
  ;

  UploadDocumentRequest._() : super();
  factory UploadDocumentRequest({
    DocumentType? documentType,
    $core.String? documentFrontUrl,
    $core.String? documentBackUrl,
    $core.String? selfieUrl,
    $core.String? proofOfAddressUrl,
  }) {
    final _result = create();
    if (documentType != null) {
      _result.documentType = documentType;
    }
    if (documentFrontUrl != null) {
      _result.documentFrontUrl = documentFrontUrl;
    }
    if (documentBackUrl != null) {
      _result.documentBackUrl = documentBackUrl;
    }
    if (selfieUrl != null) {
      _result.selfieUrl = selfieUrl;
    }
    if (proofOfAddressUrl != null) {
      _result.proofOfAddressUrl = proofOfAddressUrl;
    }
    return _result;
  }
  factory UploadDocumentRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UploadDocumentRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UploadDocumentRequest clone() => UploadDocumentRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UploadDocumentRequest copyWith(void Function(UploadDocumentRequest) updates) => super.copyWith((message) => updates(message as UploadDocumentRequest)) as UploadDocumentRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UploadDocumentRequest create() => UploadDocumentRequest._();
  UploadDocumentRequest createEmptyInstance() => create();
  static $pb.PbList<UploadDocumentRequest> createRepeated() => $pb.PbList<UploadDocumentRequest>();
  @$core.pragma('dart2js:noInline')
  static UploadDocumentRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UploadDocumentRequest>(create);
  static UploadDocumentRequest? _defaultInstance;

  @$pb.TagNumber(1)
  DocumentType get documentType => $_getN(0);
  @$pb.TagNumber(1)
  set documentType(DocumentType v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasDocumentType() => $_has(0);
  @$pb.TagNumber(1)
  void clearDocumentType() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get documentFrontUrl => $_getSZ(1);
  @$pb.TagNumber(2)
  set documentFrontUrl($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasDocumentFrontUrl() => $_has(1);
  @$pb.TagNumber(2)
  void clearDocumentFrontUrl() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get documentBackUrl => $_getSZ(2);
  @$pb.TagNumber(3)
  set documentBackUrl($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDocumentBackUrl() => $_has(2);
  @$pb.TagNumber(3)
  void clearDocumentBackUrl() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get selfieUrl => $_getSZ(3);
  @$pb.TagNumber(4)
  set selfieUrl($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasSelfieUrl() => $_has(3);
  @$pb.TagNumber(4)
  void clearSelfieUrl() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get proofOfAddressUrl => $_getSZ(4);
  @$pb.TagNumber(5)
  set proofOfAddressUrl($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasProofOfAddressUrl() => $_has(4);
  @$pb.TagNumber(5)
  void clearProofOfAddressUrl() => clearField(5);
}

class UploadDocumentResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UploadDocumentResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'documentId')
    ..e<DocumentStatus>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: DocumentStatus.DOCUMENT_STATUS_UNKNOWN, valueOf: DocumentStatus.valueOf, enumValues: DocumentStatus.values)
    ..hasRequiredFields = false
  ;

  UploadDocumentResponse._() : super();
  factory UploadDocumentResponse({
    $core.bool? success,
    $core.String? message,
    $core.String? documentId,
    DocumentStatus? status,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (documentId != null) {
      _result.documentId = documentId;
    }
    if (status != null) {
      _result.status = status;
    }
    return _result;
  }
  factory UploadDocumentResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UploadDocumentResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UploadDocumentResponse clone() => UploadDocumentResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UploadDocumentResponse copyWith(void Function(UploadDocumentResponse) updates) => super.copyWith((message) => updates(message as UploadDocumentResponse)) as UploadDocumentResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UploadDocumentResponse create() => UploadDocumentResponse._();
  UploadDocumentResponse createEmptyInstance() => create();
  static $pb.PbList<UploadDocumentResponse> createRepeated() => $pb.PbList<UploadDocumentResponse>();
  @$core.pragma('dart2js:noInline')
  static UploadDocumentResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UploadDocumentResponse>(create);
  static UploadDocumentResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get documentId => $_getSZ(2);
  @$pb.TagNumber(3)
  set documentId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDocumentId() => $_has(2);
  @$pb.TagNumber(3)
  void clearDocumentId() => clearField(3);

  @$pb.TagNumber(4)
  DocumentStatus get status => $_getN(3);
  @$pb.TagNumber(4)
  set status(DocumentStatus v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearStatus() => clearField(4);
}

class SkipKYCUpgradeRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SkipKYCUpgradeRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'skipTier2', protoName: 'skip_tier_2')
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'skipTier3', protoName: 'skip_tier_3')
    ..hasRequiredFields = false
  ;

  SkipKYCUpgradeRequest._() : super();
  factory SkipKYCUpgradeRequest({
    $core.bool? skipTier2,
    $core.bool? skipTier3,
  }) {
    final _result = create();
    if (skipTier2 != null) {
      _result.skipTier2 = skipTier2;
    }
    if (skipTier3 != null) {
      _result.skipTier3 = skipTier3;
    }
    return _result;
  }
  factory SkipKYCUpgradeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SkipKYCUpgradeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SkipKYCUpgradeRequest clone() => SkipKYCUpgradeRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SkipKYCUpgradeRequest copyWith(void Function(SkipKYCUpgradeRequest) updates) => super.copyWith((message) => updates(message as SkipKYCUpgradeRequest)) as SkipKYCUpgradeRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SkipKYCUpgradeRequest create() => SkipKYCUpgradeRequest._();
  SkipKYCUpgradeRequest createEmptyInstance() => create();
  static $pb.PbList<SkipKYCUpgradeRequest> createRepeated() => $pb.PbList<SkipKYCUpgradeRequest>();
  @$core.pragma('dart2js:noInline')
  static SkipKYCUpgradeRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SkipKYCUpgradeRequest>(create);
  static SkipKYCUpgradeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get skipTier2 => $_getBF(0);
  @$pb.TagNumber(1)
  set skipTier2($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSkipTier2() => $_has(0);
  @$pb.TagNumber(1)
  void clearSkipTier2() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get skipTier3 => $_getBF(1);
  @$pb.TagNumber(2)
  set skipTier3($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSkipTier3() => $_has(1);
  @$pb.TagNumber(2)
  void clearSkipTier3() => clearField(2);
}

class SkipKYCUpgradeResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SkipKYCUpgradeResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..e<KYCTier>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'assignedTier', $pb.PbFieldType.OE, defaultOrMaker: KYCTier.KYC_TIER_UNKNOWN, valueOf: KYCTier.valueOf, enumValues: KYCTier.values)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..pPS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'nextSteps')
    ..hasRequiredFields = false
  ;

  SkipKYCUpgradeResponse._() : super();
  factory SkipKYCUpgradeResponse({
    $core.bool? success,
    KYCTier? assignedTier,
    $core.String? message,
    $core.Iterable<$core.String>? nextSteps,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (assignedTier != null) {
      _result.assignedTier = assignedTier;
    }
    if (message != null) {
      _result.message = message;
    }
    if (nextSteps != null) {
      _result.nextSteps.addAll(nextSteps);
    }
    return _result;
  }
  factory SkipKYCUpgradeResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SkipKYCUpgradeResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SkipKYCUpgradeResponse clone() => SkipKYCUpgradeResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SkipKYCUpgradeResponse copyWith(void Function(SkipKYCUpgradeResponse) updates) => super.copyWith((message) => updates(message as SkipKYCUpgradeResponse)) as SkipKYCUpgradeResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SkipKYCUpgradeResponse create() => SkipKYCUpgradeResponse._();
  SkipKYCUpgradeResponse createEmptyInstance() => create();
  static $pb.PbList<SkipKYCUpgradeResponse> createRepeated() => $pb.PbList<SkipKYCUpgradeResponse>();
  @$core.pragma('dart2js:noInline')
  static SkipKYCUpgradeResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SkipKYCUpgradeResponse>(create);
  static SkipKYCUpgradeResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  KYCTier get assignedTier => $_getN(1);
  @$pb.TagNumber(2)
  set assignedTier(KYCTier v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasAssignedTier() => $_has(1);
  @$pb.TagNumber(2)
  void clearAssignedTier() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<$core.String> get nextSteps => $_getList(3);
}

class GetUserDocumentsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetUserDocumentsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetUserDocumentsRequest._() : super();
  factory GetUserDocumentsRequest() => create();
  factory GetUserDocumentsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserDocumentsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUserDocumentsRequest clone() => GetUserDocumentsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUserDocumentsRequest copyWith(void Function(GetUserDocumentsRequest) updates) => super.copyWith((message) => updates(message as GetUserDocumentsRequest)) as GetUserDocumentsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetUserDocumentsRequest create() => GetUserDocumentsRequest._();
  GetUserDocumentsRequest createEmptyInstance() => create();
  static $pb.PbList<GetUserDocumentsRequest> createRepeated() => $pb.PbList<GetUserDocumentsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetUserDocumentsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetUserDocumentsRequest>(create);
  static GetUserDocumentsRequest? _defaultInstance;
}

class VerificationDocument extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'VerificationDocument', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..e<DocumentType>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'documentType', $pb.PbFieldType.OE, defaultOrMaker: DocumentType.DOCUMENT_TYPE_UNKNOWN, valueOf: DocumentType.valueOf, enumValues: DocumentType.values)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'documentUrl')
    ..e<DocumentStatus>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: DocumentStatus.DOCUMENT_STATUS_UNKNOWN, valueOf: DocumentStatus.valueOf, enumValues: DocumentStatus.values)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'uploadedAt')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'verifiedAt')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'rejectionReason')
    ..hasRequiredFields = false
  ;

  VerificationDocument._() : super();
  factory VerificationDocument({
    $core.String? id,
    DocumentType? documentType,
    $core.String? documentUrl,
    DocumentStatus? status,
    $core.String? uploadedAt,
    $core.String? verifiedAt,
    $core.String? rejectionReason,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (documentType != null) {
      _result.documentType = documentType;
    }
    if (documentUrl != null) {
      _result.documentUrl = documentUrl;
    }
    if (status != null) {
      _result.status = status;
    }
    if (uploadedAt != null) {
      _result.uploadedAt = uploadedAt;
    }
    if (verifiedAt != null) {
      _result.verifiedAt = verifiedAt;
    }
    if (rejectionReason != null) {
      _result.rejectionReason = rejectionReason;
    }
    return _result;
  }
  factory VerificationDocument.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VerificationDocument.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VerificationDocument clone() => VerificationDocument()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VerificationDocument copyWith(void Function(VerificationDocument) updates) => super.copyWith((message) => updates(message as VerificationDocument)) as VerificationDocument; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static VerificationDocument create() => VerificationDocument._();
  VerificationDocument createEmptyInstance() => create();
  static $pb.PbList<VerificationDocument> createRepeated() => $pb.PbList<VerificationDocument>();
  @$core.pragma('dart2js:noInline')
  static VerificationDocument getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VerificationDocument>(create);
  static VerificationDocument? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  DocumentType get documentType => $_getN(1);
  @$pb.TagNumber(2)
  set documentType(DocumentType v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasDocumentType() => $_has(1);
  @$pb.TagNumber(2)
  void clearDocumentType() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get documentUrl => $_getSZ(2);
  @$pb.TagNumber(3)
  set documentUrl($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDocumentUrl() => $_has(2);
  @$pb.TagNumber(3)
  void clearDocumentUrl() => clearField(3);

  @$pb.TagNumber(4)
  DocumentStatus get status => $_getN(3);
  @$pb.TagNumber(4)
  set status(DocumentStatus v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearStatus() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get uploadedAt => $_getSZ(4);
  @$pb.TagNumber(5)
  set uploadedAt($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasUploadedAt() => $_has(4);
  @$pb.TagNumber(5)
  void clearUploadedAt() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get verifiedAt => $_getSZ(5);
  @$pb.TagNumber(6)
  set verifiedAt($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasVerifiedAt() => $_has(5);
  @$pb.TagNumber(6)
  void clearVerifiedAt() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get rejectionReason => $_getSZ(6);
  @$pb.TagNumber(7)
  set rejectionReason($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasRejectionReason() => $_has(6);
  @$pb.TagNumber(7)
  void clearRejectionReason() => clearField(7);
}

class GetUserDocumentsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetUserDocumentsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'auth'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..pc<VerificationDocument>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'documents', $pb.PbFieldType.PM, subBuilder: VerificationDocument.create)
    ..hasRequiredFields = false
  ;

  GetUserDocumentsResponse._() : super();
  factory GetUserDocumentsResponse({
    $core.bool? success,
    $core.Iterable<VerificationDocument>? documents,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (documents != null) {
      _result.documents.addAll(documents);
    }
    return _result;
  }
  factory GetUserDocumentsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserDocumentsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUserDocumentsResponse clone() => GetUserDocumentsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUserDocumentsResponse copyWith(void Function(GetUserDocumentsResponse) updates) => super.copyWith((message) => updates(message as GetUserDocumentsResponse)) as GetUserDocumentsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetUserDocumentsResponse create() => GetUserDocumentsResponse._();
  GetUserDocumentsResponse createEmptyInstance() => create();
  static $pb.PbList<GetUserDocumentsResponse> createRepeated() => $pb.PbList<GetUserDocumentsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetUserDocumentsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetUserDocumentsResponse>(create);
  static GetUserDocumentsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<VerificationDocument> get documents => $_getList(1);
}

