//
//  Generated code. Do not modify.
//  source: user.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'common.pb.dart' as $1;
import 'google/protobuf/timestamp.pb.dart' as $2;
import 'user.pbenum.dart';

export 'user.pbenum.dart';

class CreateUserRequest extends $pb.GeneratedMessage {
  factory CreateUserRequest({
    $core.String? firstName,
    $core.String? lastName,
    $core.String? email,
    $core.String? password,
    $core.String? phoneNumber,
    $core.String? role,
    $core.String? loginPasscode,
    $core.String? username,
    $core.String? referralCode,
  }) {
    final $result = create();
    if (firstName != null) {
      $result.firstName = firstName;
    }
    if (lastName != null) {
      $result.lastName = lastName;
    }
    if (email != null) {
      $result.email = email;
    }
    if (password != null) {
      $result.password = password;
    }
    if (phoneNumber != null) {
      $result.phoneNumber = phoneNumber;
    }
    if (role != null) {
      $result.role = role;
    }
    if (loginPasscode != null) {
      $result.loginPasscode = loginPasscode;
    }
    if (username != null) {
      $result.username = username;
    }
    if (referralCode != null) {
      $result.referralCode = referralCode;
    }
    return $result;
  }
  CreateUserRequest._() : super();
  factory CreateUserRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateUserRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateUserRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'firstName')
    ..aOS(2, _omitFieldNames ? '' : 'lastName')
    ..aOS(3, _omitFieldNames ? '' : 'email')
    ..aOS(4, _omitFieldNames ? '' : 'password')
    ..aOS(5, _omitFieldNames ? '' : 'phoneNumber')
    ..aOS(6, _omitFieldNames ? '' : 'role')
    ..aOS(7, _omitFieldNames ? '' : 'loginPasscode')
    ..aOS(8, _omitFieldNames ? '' : 'username')
    ..aOS(9, _omitFieldNames ? '' : 'referralCode')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateUserRequest clone() => CreateUserRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateUserRequest copyWith(void Function(CreateUserRequest) updates) => super.copyWith((message) => updates(message as CreateUserRequest)) as CreateUserRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateUserRequest create() => CreateUserRequest._();
  CreateUserRequest createEmptyInstance() => create();
  static $pb.PbList<CreateUserRequest> createRepeated() => $pb.PbList<CreateUserRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateUserRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateUserRequest>(create);
  static CreateUserRequest? _defaultInstance;

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
  $core.String get email => $_getSZ(2);
  @$pb.TagNumber(3)
  set email($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasEmail() => $_has(2);
  @$pb.TagNumber(3)
  void clearEmail() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get password => $_getSZ(3);
  @$pb.TagNumber(4)
  set password($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPassword() => $_has(3);
  @$pb.TagNumber(4)
  void clearPassword() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get phoneNumber => $_getSZ(4);
  @$pb.TagNumber(5)
  set phoneNumber($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasPhoneNumber() => $_has(4);
  @$pb.TagNumber(5)
  void clearPhoneNumber() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get role => $_getSZ(5);
  @$pb.TagNumber(6)
  set role($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasRole() => $_has(5);
  @$pb.TagNumber(6)
  void clearRole() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get loginPasscode => $_getSZ(6);
  @$pb.TagNumber(7)
  set loginPasscode($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasLoginPasscode() => $_has(6);
  @$pb.TagNumber(7)
  void clearLoginPasscode() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get username => $_getSZ(7);
  @$pb.TagNumber(8)
  set username($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasUsername() => $_has(7);
  @$pb.TagNumber(8)
  void clearUsername() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get referralCode => $_getSZ(8);
  @$pb.TagNumber(9)
  set referralCode($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasReferralCode() => $_has(8);
  @$pb.TagNumber(9)
  void clearReferralCode() => clearField(9);
}

class CreateUserResponse extends $pb.GeneratedMessage {
  factory CreateUserResponse({
    $core.bool? success,
    $core.String? message,
    $1.Data? data,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    if (data != null) {
      $result.data = data;
    }
    return $result;
  }
  CreateUserResponse._() : super();
  factory CreateUserResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateUserResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateUserResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<$1.Data>(3, _omitFieldNames ? '' : 'data', subBuilder: $1.Data.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateUserResponse clone() => CreateUserResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateUserResponse copyWith(void Function(CreateUserResponse) updates) => super.copyWith((message) => updates(message as CreateUserResponse)) as CreateUserResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateUserResponse create() => CreateUserResponse._();
  CreateUserResponse createEmptyInstance() => create();
  static $pb.PbList<CreateUserResponse> createRepeated() => $pb.PbList<CreateUserResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateUserResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateUserResponse>(create);
  static CreateUserResponse? _defaultInstance;

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
  $1.Data get data => $_getN(2);
  @$pb.TagNumber(3)
  set data($1.Data v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasData() => $_has(2);
  @$pb.TagNumber(3)
  void clearData() => clearField(3);
  @$pb.TagNumber(3)
  $1.Data ensureData() => $_ensure(2);
}

class GetUserProfileRequest extends $pb.GeneratedMessage {
  factory GetUserProfileRequest() => create();
  GetUserProfileRequest._() : super();
  factory GetUserProfileRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserProfileRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetUserProfileRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUserProfileRequest clone() => GetUserProfileRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUserProfileRequest copyWith(void Function(GetUserProfileRequest) updates) => super.copyWith((message) => updates(message as GetUserProfileRequest)) as GetUserProfileRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserProfileRequest create() => GetUserProfileRequest._();
  GetUserProfileRequest createEmptyInstance() => create();
  static $pb.PbList<GetUserProfileRequest> createRepeated() => $pb.PbList<GetUserProfileRequest>();
  @$core.pragma('dart2js:noInline')
  static GetUserProfileRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetUserProfileRequest>(create);
  static GetUserProfileRequest? _defaultInstance;
}

class GetUserProfileResponse extends $pb.GeneratedMessage {
  factory GetUserProfileResponse({
    $core.bool? success,
    $core.String? message,
    $1.User? user,
    UserPreferences? preferences,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    if (user != null) {
      $result.user = user;
    }
    if (preferences != null) {
      $result.preferences = preferences;
    }
    return $result;
  }
  GetUserProfileResponse._() : super();
  factory GetUserProfileResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserProfileResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetUserProfileResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<$1.User>(3, _omitFieldNames ? '' : 'user', subBuilder: $1.User.create)
    ..aOM<UserPreferences>(4, _omitFieldNames ? '' : 'preferences', subBuilder: UserPreferences.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUserProfileResponse clone() => GetUserProfileResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUserProfileResponse copyWith(void Function(GetUserProfileResponse) updates) => super.copyWith((message) => updates(message as GetUserProfileResponse)) as GetUserProfileResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserProfileResponse create() => GetUserProfileResponse._();
  GetUserProfileResponse createEmptyInstance() => create();
  static $pb.PbList<GetUserProfileResponse> createRepeated() => $pb.PbList<GetUserProfileResponse>();
  @$core.pragma('dart2js:noInline')
  static GetUserProfileResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetUserProfileResponse>(create);
  static GetUserProfileResponse? _defaultInstance;

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
  $1.User get user => $_getN(2);
  @$pb.TagNumber(3)
  set user($1.User v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasUser() => $_has(2);
  @$pb.TagNumber(3)
  void clearUser() => clearField(3);
  @$pb.TagNumber(3)
  $1.User ensureUser() => $_ensure(2);

  @$pb.TagNumber(4)
  UserPreferences get preferences => $_getN(3);
  @$pb.TagNumber(4)
  set preferences(UserPreferences v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasPreferences() => $_has(3);
  @$pb.TagNumber(4)
  void clearPreferences() => clearField(4);
  @$pb.TagNumber(4)
  UserPreferences ensurePreferences() => $_ensure(3);
}

class UpdateUserProfileRequest extends $pb.GeneratedMessage {
  factory UpdateUserProfileRequest({
    $core.String? firstName,
    $core.String? lastName,
    $core.String? username,
    $core.String? phoneNumber,
    $core.String? language,
    $core.String? currency,
    $core.String? country,
    $core.String? profilePicture,
  }) {
    final $result = create();
    if (firstName != null) {
      $result.firstName = firstName;
    }
    if (lastName != null) {
      $result.lastName = lastName;
    }
    if (username != null) {
      $result.username = username;
    }
    if (phoneNumber != null) {
      $result.phoneNumber = phoneNumber;
    }
    if (language != null) {
      $result.language = language;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (country != null) {
      $result.country = country;
    }
    if (profilePicture != null) {
      $result.profilePicture = profilePicture;
    }
    return $result;
  }
  UpdateUserProfileRequest._() : super();
  factory UpdateUserProfileRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateUserProfileRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateUserProfileRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'firstName')
    ..aOS(2, _omitFieldNames ? '' : 'lastName')
    ..aOS(3, _omitFieldNames ? '' : 'username')
    ..aOS(4, _omitFieldNames ? '' : 'phoneNumber')
    ..aOS(5, _omitFieldNames ? '' : 'language')
    ..aOS(6, _omitFieldNames ? '' : 'currency')
    ..aOS(7, _omitFieldNames ? '' : 'country')
    ..aOS(8, _omitFieldNames ? '' : 'profilePicture')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateUserProfileRequest clone() => UpdateUserProfileRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateUserProfileRequest copyWith(void Function(UpdateUserProfileRequest) updates) => super.copyWith((message) => updates(message as UpdateUserProfileRequest)) as UpdateUserProfileRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateUserProfileRequest create() => UpdateUserProfileRequest._();
  UpdateUserProfileRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateUserProfileRequest> createRepeated() => $pb.PbList<UpdateUserProfileRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateUserProfileRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateUserProfileRequest>(create);
  static UpdateUserProfileRequest? _defaultInstance;

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
  $core.String get username => $_getSZ(2);
  @$pb.TagNumber(3)
  set username($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasUsername() => $_has(2);
  @$pb.TagNumber(3)
  void clearUsername() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get phoneNumber => $_getSZ(3);
  @$pb.TagNumber(4)
  set phoneNumber($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPhoneNumber() => $_has(3);
  @$pb.TagNumber(4)
  void clearPhoneNumber() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get language => $_getSZ(4);
  @$pb.TagNumber(5)
  set language($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasLanguage() => $_has(4);
  @$pb.TagNumber(5)
  void clearLanguage() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get currency => $_getSZ(5);
  @$pb.TagNumber(6)
  set currency($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasCurrency() => $_has(5);
  @$pb.TagNumber(6)
  void clearCurrency() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get country => $_getSZ(6);
  @$pb.TagNumber(7)
  set country($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasCountry() => $_has(6);
  @$pb.TagNumber(7)
  void clearCountry() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get profilePicture => $_getSZ(7);
  @$pb.TagNumber(8)
  set profilePicture($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasProfilePicture() => $_has(7);
  @$pb.TagNumber(8)
  void clearProfilePicture() => clearField(8);
}

class UpdateUserProfileResponse extends $pb.GeneratedMessage {
  factory UpdateUserProfileResponse({
    $core.bool? success,
    $core.String? message,
    $1.User? user,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    if (user != null) {
      $result.user = user;
    }
    return $result;
  }
  UpdateUserProfileResponse._() : super();
  factory UpdateUserProfileResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateUserProfileResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateUserProfileResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<$1.User>(3, _omitFieldNames ? '' : 'user', subBuilder: $1.User.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateUserProfileResponse clone() => UpdateUserProfileResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateUserProfileResponse copyWith(void Function(UpdateUserProfileResponse) updates) => super.copyWith((message) => updates(message as UpdateUserProfileResponse)) as UpdateUserProfileResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateUserProfileResponse create() => UpdateUserProfileResponse._();
  UpdateUserProfileResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateUserProfileResponse> createRepeated() => $pb.PbList<UpdateUserProfileResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateUserProfileResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateUserProfileResponse>(create);
  static UpdateUserProfileResponse? _defaultInstance;

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
  $1.User get user => $_getN(2);
  @$pb.TagNumber(3)
  set user($1.User v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasUser() => $_has(2);
  @$pb.TagNumber(3)
  void clearUser() => clearField(3);
  @$pb.TagNumber(3)
  $1.User ensureUser() => $_ensure(2);
}

class UpdatePasswordRequest extends $pb.GeneratedMessage {
  factory UpdatePasswordRequest({
    $core.String? currentPassword,
    $core.String? newPassword,
  }) {
    final $result = create();
    if (currentPassword != null) {
      $result.currentPassword = currentPassword;
    }
    if (newPassword != null) {
      $result.newPassword = newPassword;
    }
    return $result;
  }
  UpdatePasswordRequest._() : super();
  factory UpdatePasswordRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdatePasswordRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdatePasswordRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'currentPassword')
    ..aOS(2, _omitFieldNames ? '' : 'newPassword')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdatePasswordRequest clone() => UpdatePasswordRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdatePasswordRequest copyWith(void Function(UpdatePasswordRequest) updates) => super.copyWith((message) => updates(message as UpdatePasswordRequest)) as UpdatePasswordRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdatePasswordRequest create() => UpdatePasswordRequest._();
  UpdatePasswordRequest createEmptyInstance() => create();
  static $pb.PbList<UpdatePasswordRequest> createRepeated() => $pb.PbList<UpdatePasswordRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdatePasswordRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdatePasswordRequest>(create);
  static UpdatePasswordRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get currentPassword => $_getSZ(0);
  @$pb.TagNumber(1)
  set currentPassword($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCurrentPassword() => $_has(0);
  @$pb.TagNumber(1)
  void clearCurrentPassword() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get newPassword => $_getSZ(1);
  @$pb.TagNumber(2)
  set newPassword($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNewPassword() => $_has(1);
  @$pb.TagNumber(2)
  void clearNewPassword() => clearField(2);
}

class UpdatePasswordResponse extends $pb.GeneratedMessage {
  factory UpdatePasswordResponse({
    $core.bool? success,
    $core.String? message,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  UpdatePasswordResponse._() : super();
  factory UpdatePasswordResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdatePasswordResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdatePasswordResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdatePasswordResponse clone() => UpdatePasswordResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdatePasswordResponse copyWith(void Function(UpdatePasswordResponse) updates) => super.copyWith((message) => updates(message as UpdatePasswordResponse)) as UpdatePasswordResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdatePasswordResponse create() => UpdatePasswordResponse._();
  UpdatePasswordResponse createEmptyInstance() => create();
  static $pb.PbList<UpdatePasswordResponse> createRepeated() => $pb.PbList<UpdatePasswordResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdatePasswordResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdatePasswordResponse>(create);
  static UpdatePasswordResponse? _defaultInstance;

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

class UpdatePreferencesRequest extends $pb.GeneratedMessage {
  factory UpdatePreferencesRequest({
    $core.bool? pushNotifications,
    $core.bool? emailNotifications,
    $core.bool? smsNotifications,
    $core.bool? darkMode,
    $core.String? language,
    $core.String? currency,
    $core.Iterable<$core.String>? preferredCountries,
    $core.String? activeCountry,
  }) {
    final $result = create();
    if (pushNotifications != null) {
      $result.pushNotifications = pushNotifications;
    }
    if (emailNotifications != null) {
      $result.emailNotifications = emailNotifications;
    }
    if (smsNotifications != null) {
      $result.smsNotifications = smsNotifications;
    }
    if (darkMode != null) {
      $result.darkMode = darkMode;
    }
    if (language != null) {
      $result.language = language;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (preferredCountries != null) {
      $result.preferredCountries.addAll(preferredCountries);
    }
    if (activeCountry != null) {
      $result.activeCountry = activeCountry;
    }
    return $result;
  }
  UpdatePreferencesRequest._() : super();
  factory UpdatePreferencesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdatePreferencesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdatePreferencesRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'pushNotifications')
    ..aOB(2, _omitFieldNames ? '' : 'emailNotifications')
    ..aOB(3, _omitFieldNames ? '' : 'smsNotifications')
    ..aOB(4, _omitFieldNames ? '' : 'darkMode')
    ..aOS(5, _omitFieldNames ? '' : 'language')
    ..aOS(6, _omitFieldNames ? '' : 'currency')
    ..pPS(7, _omitFieldNames ? '' : 'preferredCountries')
    ..aOS(8, _omitFieldNames ? '' : 'activeCountry')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdatePreferencesRequest clone() => UpdatePreferencesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdatePreferencesRequest copyWith(void Function(UpdatePreferencesRequest) updates) => super.copyWith((message) => updates(message as UpdatePreferencesRequest)) as UpdatePreferencesRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdatePreferencesRequest create() => UpdatePreferencesRequest._();
  UpdatePreferencesRequest createEmptyInstance() => create();
  static $pb.PbList<UpdatePreferencesRequest> createRepeated() => $pb.PbList<UpdatePreferencesRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdatePreferencesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdatePreferencesRequest>(create);
  static UpdatePreferencesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get pushNotifications => $_getBF(0);
  @$pb.TagNumber(1)
  set pushNotifications($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPushNotifications() => $_has(0);
  @$pb.TagNumber(1)
  void clearPushNotifications() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get emailNotifications => $_getBF(1);
  @$pb.TagNumber(2)
  set emailNotifications($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasEmailNotifications() => $_has(1);
  @$pb.TagNumber(2)
  void clearEmailNotifications() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get smsNotifications => $_getBF(2);
  @$pb.TagNumber(3)
  set smsNotifications($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSmsNotifications() => $_has(2);
  @$pb.TagNumber(3)
  void clearSmsNotifications() => clearField(3);

  @$pb.TagNumber(4)
  $core.bool get darkMode => $_getBF(3);
  @$pb.TagNumber(4)
  set darkMode($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDarkMode() => $_has(3);
  @$pb.TagNumber(4)
  void clearDarkMode() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get language => $_getSZ(4);
  @$pb.TagNumber(5)
  set language($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasLanguage() => $_has(4);
  @$pb.TagNumber(5)
  void clearLanguage() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get currency => $_getSZ(5);
  @$pb.TagNumber(6)
  set currency($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasCurrency() => $_has(5);
  @$pb.TagNumber(6)
  void clearCurrency() => clearField(6);

  @$pb.TagNumber(7)
  $core.List<$core.String> get preferredCountries => $_getList(6);

  @$pb.TagNumber(8)
  $core.String get activeCountry => $_getSZ(7);
  @$pb.TagNumber(8)
  set activeCountry($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasActiveCountry() => $_has(7);
  @$pb.TagNumber(8)
  void clearActiveCountry() => clearField(8);
}

class UpdatePreferencesResponse extends $pb.GeneratedMessage {
  factory UpdatePreferencesResponse({
    $core.bool? success,
    $core.String? message,
    UserPreferences? preferences,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    if (preferences != null) {
      $result.preferences = preferences;
    }
    return $result;
  }
  UpdatePreferencesResponse._() : super();
  factory UpdatePreferencesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdatePreferencesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdatePreferencesResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<UserPreferences>(3, _omitFieldNames ? '' : 'preferences', subBuilder: UserPreferences.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdatePreferencesResponse clone() => UpdatePreferencesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdatePreferencesResponse copyWith(void Function(UpdatePreferencesResponse) updates) => super.copyWith((message) => updates(message as UpdatePreferencesResponse)) as UpdatePreferencesResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdatePreferencesResponse create() => UpdatePreferencesResponse._();
  UpdatePreferencesResponse createEmptyInstance() => create();
  static $pb.PbList<UpdatePreferencesResponse> createRepeated() => $pb.PbList<UpdatePreferencesResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdatePreferencesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdatePreferencesResponse>(create);
  static UpdatePreferencesResponse? _defaultInstance;

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
  UserPreferences get preferences => $_getN(2);
  @$pb.TagNumber(3)
  set preferences(UserPreferences v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasPreferences() => $_has(2);
  @$pb.TagNumber(3)
  void clearPreferences() => clearField(3);
  @$pb.TagNumber(3)
  UserPreferences ensurePreferences() => $_ensure(2);
}

class UserPreferences extends $pb.GeneratedMessage {
  factory UserPreferences({
    $core.String? userId,
    $core.bool? pushNotifications,
    $core.bool? emailNotifications,
    $core.bool? smsNotifications,
    $core.bool? darkMode,
    $core.String? language,
    $core.String? currency,
    $core.String? country,
    $core.Iterable<$core.String>? preferredCountries,
    $core.String? activeCountry,
  }) {
    final $result = create();
    if (userId != null) {
      $result.userId = userId;
    }
    if (pushNotifications != null) {
      $result.pushNotifications = pushNotifications;
    }
    if (emailNotifications != null) {
      $result.emailNotifications = emailNotifications;
    }
    if (smsNotifications != null) {
      $result.smsNotifications = smsNotifications;
    }
    if (darkMode != null) {
      $result.darkMode = darkMode;
    }
    if (language != null) {
      $result.language = language;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (country != null) {
      $result.country = country;
    }
    if (preferredCountries != null) {
      $result.preferredCountries.addAll(preferredCountries);
    }
    if (activeCountry != null) {
      $result.activeCountry = activeCountry;
    }
    return $result;
  }
  UserPreferences._() : super();
  factory UserPreferences.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UserPreferences.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UserPreferences', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOB(2, _omitFieldNames ? '' : 'pushNotifications')
    ..aOB(3, _omitFieldNames ? '' : 'emailNotifications')
    ..aOB(4, _omitFieldNames ? '' : 'smsNotifications')
    ..aOB(5, _omitFieldNames ? '' : 'darkMode')
    ..aOS(6, _omitFieldNames ? '' : 'language')
    ..aOS(7, _omitFieldNames ? '' : 'currency')
    ..aOS(8, _omitFieldNames ? '' : 'country')
    ..pPS(9, _omitFieldNames ? '' : 'preferredCountries')
    ..aOS(10, _omitFieldNames ? '' : 'activeCountry')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UserPreferences clone() => UserPreferences()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UserPreferences copyWith(void Function(UserPreferences) updates) => super.copyWith((message) => updates(message as UserPreferences)) as UserPreferences;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UserPreferences create() => UserPreferences._();
  UserPreferences createEmptyInstance() => create();
  static $pb.PbList<UserPreferences> createRepeated() => $pb.PbList<UserPreferences>();
  @$core.pragma('dart2js:noInline')
  static UserPreferences getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UserPreferences>(create);
  static UserPreferences? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get pushNotifications => $_getBF(1);
  @$pb.TagNumber(2)
  set pushNotifications($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPushNotifications() => $_has(1);
  @$pb.TagNumber(2)
  void clearPushNotifications() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get emailNotifications => $_getBF(2);
  @$pb.TagNumber(3)
  set emailNotifications($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasEmailNotifications() => $_has(2);
  @$pb.TagNumber(3)
  void clearEmailNotifications() => clearField(3);

  @$pb.TagNumber(4)
  $core.bool get smsNotifications => $_getBF(3);
  @$pb.TagNumber(4)
  set smsNotifications($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasSmsNotifications() => $_has(3);
  @$pb.TagNumber(4)
  void clearSmsNotifications() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get darkMode => $_getBF(4);
  @$pb.TagNumber(5)
  set darkMode($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasDarkMode() => $_has(4);
  @$pb.TagNumber(5)
  void clearDarkMode() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get language => $_getSZ(5);
  @$pb.TagNumber(6)
  set language($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasLanguage() => $_has(5);
  @$pb.TagNumber(6)
  void clearLanguage() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get currency => $_getSZ(6);
  @$pb.TagNumber(7)
  set currency($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasCurrency() => $_has(6);
  @$pb.TagNumber(7)
  void clearCurrency() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get country => $_getSZ(7);
  @$pb.TagNumber(8)
  set country($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasCountry() => $_has(7);
  @$pb.TagNumber(8)
  void clearCountry() => clearField(8);

  @$pb.TagNumber(9)
  $core.List<$core.String> get preferredCountries => $_getList(8);

  @$pb.TagNumber(10)
  $core.String get activeCountry => $_getSZ(9);
  @$pb.TagNumber(10)
  set activeCountry($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasActiveCountry() => $_has(9);
  @$pb.TagNumber(10)
  void clearActiveCountry() => clearField(10);
}

class IDDocument extends $pb.GeneratedMessage {
  factory IDDocument({
    $core.String? id,
    $fixnum.Int64? userId,
    DocumentType? documentType,
    $core.String? documentNumber,
    $core.String? fullName,
    $core.String? dateOfBirth,
    $core.String? issueDate,
    $core.String? expiryDate,
    $core.String? issuingCountry,
    $core.String? documentFrontUrl,
    $core.String? documentBackUrl,
    VerificationStatus? verificationStatus,
    $core.String? rejectionReason,
    $2.Timestamp? createdAt,
    $2.Timestamp? verifiedAt,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (userId != null) {
      $result.userId = userId;
    }
    if (documentType != null) {
      $result.documentType = documentType;
    }
    if (documentNumber != null) {
      $result.documentNumber = documentNumber;
    }
    if (fullName != null) {
      $result.fullName = fullName;
    }
    if (dateOfBirth != null) {
      $result.dateOfBirth = dateOfBirth;
    }
    if (issueDate != null) {
      $result.issueDate = issueDate;
    }
    if (expiryDate != null) {
      $result.expiryDate = expiryDate;
    }
    if (issuingCountry != null) {
      $result.issuingCountry = issuingCountry;
    }
    if (documentFrontUrl != null) {
      $result.documentFrontUrl = documentFrontUrl;
    }
    if (documentBackUrl != null) {
      $result.documentBackUrl = documentBackUrl;
    }
    if (verificationStatus != null) {
      $result.verificationStatus = verificationStatus;
    }
    if (rejectionReason != null) {
      $result.rejectionReason = rejectionReason;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    if (verifiedAt != null) {
      $result.verifiedAt = verifiedAt;
    }
    return $result;
  }
  IDDocument._() : super();
  factory IDDocument.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory IDDocument.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'IDDocument', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'userId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..e<DocumentType>(3, _omitFieldNames ? '' : 'documentType', $pb.PbFieldType.OE, defaultOrMaker: DocumentType.DOCUMENT_TYPE_PASSPORT, valueOf: DocumentType.valueOf, enumValues: DocumentType.values)
    ..aOS(4, _omitFieldNames ? '' : 'documentNumber')
    ..aOS(5, _omitFieldNames ? '' : 'fullName')
    ..aOS(6, _omitFieldNames ? '' : 'dateOfBirth')
    ..aOS(7, _omitFieldNames ? '' : 'issueDate')
    ..aOS(8, _omitFieldNames ? '' : 'expiryDate')
    ..aOS(9, _omitFieldNames ? '' : 'issuingCountry')
    ..aOS(10, _omitFieldNames ? '' : 'documentFrontUrl')
    ..aOS(11, _omitFieldNames ? '' : 'documentBackUrl')
    ..e<VerificationStatus>(12, _omitFieldNames ? '' : 'verificationStatus', $pb.PbFieldType.OE, defaultOrMaker: VerificationStatus.VERIFICATION_STATUS_PENDING, valueOf: VerificationStatus.valueOf, enumValues: VerificationStatus.values)
    ..aOS(13, _omitFieldNames ? '' : 'rejectionReason')
    ..aOM<$2.Timestamp>(14, _omitFieldNames ? '' : 'createdAt', subBuilder: $2.Timestamp.create)
    ..aOM<$2.Timestamp>(15, _omitFieldNames ? '' : 'verifiedAt', subBuilder: $2.Timestamp.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  IDDocument clone() => IDDocument()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  IDDocument copyWith(void Function(IDDocument) updates) => super.copyWith((message) => updates(message as IDDocument)) as IDDocument;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static IDDocument create() => IDDocument._();
  IDDocument createEmptyInstance() => create();
  static $pb.PbList<IDDocument> createRepeated() => $pb.PbList<IDDocument>();
  @$core.pragma('dart2js:noInline')
  static IDDocument getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<IDDocument>(create);
  static IDDocument? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get userId => $_getI64(1);
  @$pb.TagNumber(2)
  set userId($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => clearField(2);

  @$pb.TagNumber(3)
  DocumentType get documentType => $_getN(2);
  @$pb.TagNumber(3)
  set documentType(DocumentType v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasDocumentType() => $_has(2);
  @$pb.TagNumber(3)
  void clearDocumentType() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get documentNumber => $_getSZ(3);
  @$pb.TagNumber(4)
  set documentNumber($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDocumentNumber() => $_has(3);
  @$pb.TagNumber(4)
  void clearDocumentNumber() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get fullName => $_getSZ(4);
  @$pb.TagNumber(5)
  set fullName($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasFullName() => $_has(4);
  @$pb.TagNumber(5)
  void clearFullName() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get dateOfBirth => $_getSZ(5);
  @$pb.TagNumber(6)
  set dateOfBirth($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasDateOfBirth() => $_has(5);
  @$pb.TagNumber(6)
  void clearDateOfBirth() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get issueDate => $_getSZ(6);
  @$pb.TagNumber(7)
  set issueDate($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasIssueDate() => $_has(6);
  @$pb.TagNumber(7)
  void clearIssueDate() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get expiryDate => $_getSZ(7);
  @$pb.TagNumber(8)
  set expiryDate($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasExpiryDate() => $_has(7);
  @$pb.TagNumber(8)
  void clearExpiryDate() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get issuingCountry => $_getSZ(8);
  @$pb.TagNumber(9)
  set issuingCountry($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasIssuingCountry() => $_has(8);
  @$pb.TagNumber(9)
  void clearIssuingCountry() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get documentFrontUrl => $_getSZ(9);
  @$pb.TagNumber(10)
  set documentFrontUrl($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasDocumentFrontUrl() => $_has(9);
  @$pb.TagNumber(10)
  void clearDocumentFrontUrl() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get documentBackUrl => $_getSZ(10);
  @$pb.TagNumber(11)
  set documentBackUrl($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasDocumentBackUrl() => $_has(10);
  @$pb.TagNumber(11)
  void clearDocumentBackUrl() => clearField(11);

  @$pb.TagNumber(12)
  VerificationStatus get verificationStatus => $_getN(11);
  @$pb.TagNumber(12)
  set verificationStatus(VerificationStatus v) { setField(12, v); }
  @$pb.TagNumber(12)
  $core.bool hasVerificationStatus() => $_has(11);
  @$pb.TagNumber(12)
  void clearVerificationStatus() => clearField(12);

  @$pb.TagNumber(13)
  $core.String get rejectionReason => $_getSZ(12);
  @$pb.TagNumber(13)
  set rejectionReason($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasRejectionReason() => $_has(12);
  @$pb.TagNumber(13)
  void clearRejectionReason() => clearField(13);

  @$pb.TagNumber(14)
  $2.Timestamp get createdAt => $_getN(13);
  @$pb.TagNumber(14)
  set createdAt($2.Timestamp v) { setField(14, v); }
  @$pb.TagNumber(14)
  $core.bool hasCreatedAt() => $_has(13);
  @$pb.TagNumber(14)
  void clearCreatedAt() => clearField(14);
  @$pb.TagNumber(14)
  $2.Timestamp ensureCreatedAt() => $_ensure(13);

  @$pb.TagNumber(15)
  $2.Timestamp get verifiedAt => $_getN(14);
  @$pb.TagNumber(15)
  set verifiedAt($2.Timestamp v) { setField(15, v); }
  @$pb.TagNumber(15)
  $core.bool hasVerifiedAt() => $_has(14);
  @$pb.TagNumber(15)
  void clearVerifiedAt() => clearField(15);
  @$pb.TagNumber(15)
  $2.Timestamp ensureVerifiedAt() => $_ensure(14);
}

class UploadIDDocumentRequest extends $pb.GeneratedMessage {
  factory UploadIDDocumentRequest({
    DocumentType? documentType,
    $core.List<$core.int>? frontImage,
    $core.List<$core.int>? backImage,
  }) {
    final $result = create();
    if (documentType != null) {
      $result.documentType = documentType;
    }
    if (frontImage != null) {
      $result.frontImage = frontImage;
    }
    if (backImage != null) {
      $result.backImage = backImage;
    }
    return $result;
  }
  UploadIDDocumentRequest._() : super();
  factory UploadIDDocumentRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UploadIDDocumentRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UploadIDDocumentRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..e<DocumentType>(1, _omitFieldNames ? '' : 'documentType', $pb.PbFieldType.OE, defaultOrMaker: DocumentType.DOCUMENT_TYPE_PASSPORT, valueOf: DocumentType.valueOf, enumValues: DocumentType.values)
    ..a<$core.List<$core.int>>(2, _omitFieldNames ? '' : 'frontImage', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(3, _omitFieldNames ? '' : 'backImage', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UploadIDDocumentRequest clone() => UploadIDDocumentRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UploadIDDocumentRequest copyWith(void Function(UploadIDDocumentRequest) updates) => super.copyWith((message) => updates(message as UploadIDDocumentRequest)) as UploadIDDocumentRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UploadIDDocumentRequest create() => UploadIDDocumentRequest._();
  UploadIDDocumentRequest createEmptyInstance() => create();
  static $pb.PbList<UploadIDDocumentRequest> createRepeated() => $pb.PbList<UploadIDDocumentRequest>();
  @$core.pragma('dart2js:noInline')
  static UploadIDDocumentRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UploadIDDocumentRequest>(create);
  static UploadIDDocumentRequest? _defaultInstance;

  @$pb.TagNumber(1)
  DocumentType get documentType => $_getN(0);
  @$pb.TagNumber(1)
  set documentType(DocumentType v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasDocumentType() => $_has(0);
  @$pb.TagNumber(1)
  void clearDocumentType() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get frontImage => $_getN(1);
  @$pb.TagNumber(2)
  set frontImage($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFrontImage() => $_has(1);
  @$pb.TagNumber(2)
  void clearFrontImage() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.int> get backImage => $_getN(2);
  @$pb.TagNumber(3)
  set backImage($core.List<$core.int> v) { $_setBytes(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasBackImage() => $_has(2);
  @$pb.TagNumber(3)
  void clearBackImage() => clearField(3);
}

class UploadIDDocumentResponse extends $pb.GeneratedMessage {
  factory UploadIDDocumentResponse({
    $core.bool? success,
    $core.String? message,
    IDDocument? document,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    if (document != null) {
      $result.document = document;
    }
    return $result;
  }
  UploadIDDocumentResponse._() : super();
  factory UploadIDDocumentResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UploadIDDocumentResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UploadIDDocumentResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<IDDocument>(3, _omitFieldNames ? '' : 'document', subBuilder: IDDocument.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UploadIDDocumentResponse clone() => UploadIDDocumentResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UploadIDDocumentResponse copyWith(void Function(UploadIDDocumentResponse) updates) => super.copyWith((message) => updates(message as UploadIDDocumentResponse)) as UploadIDDocumentResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UploadIDDocumentResponse create() => UploadIDDocumentResponse._();
  UploadIDDocumentResponse createEmptyInstance() => create();
  static $pb.PbList<UploadIDDocumentResponse> createRepeated() => $pb.PbList<UploadIDDocumentResponse>();
  @$core.pragma('dart2js:noInline')
  static UploadIDDocumentResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UploadIDDocumentResponse>(create);
  static UploadIDDocumentResponse? _defaultInstance;

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
  IDDocument get document => $_getN(2);
  @$pb.TagNumber(3)
  set document(IDDocument v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasDocument() => $_has(2);
  @$pb.TagNumber(3)
  void clearDocument() => clearField(3);
  @$pb.TagNumber(3)
  IDDocument ensureDocument() => $_ensure(2);
}

class GetIDDocumentsRequest extends $pb.GeneratedMessage {
  factory GetIDDocumentsRequest() => create();
  GetIDDocumentsRequest._() : super();
  factory GetIDDocumentsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetIDDocumentsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetIDDocumentsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetIDDocumentsRequest clone() => GetIDDocumentsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetIDDocumentsRequest copyWith(void Function(GetIDDocumentsRequest) updates) => super.copyWith((message) => updates(message as GetIDDocumentsRequest)) as GetIDDocumentsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetIDDocumentsRequest create() => GetIDDocumentsRequest._();
  GetIDDocumentsRequest createEmptyInstance() => create();
  static $pb.PbList<GetIDDocumentsRequest> createRepeated() => $pb.PbList<GetIDDocumentsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetIDDocumentsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetIDDocumentsRequest>(create);
  static GetIDDocumentsRequest? _defaultInstance;
}

class GetIDDocumentsResponse extends $pb.GeneratedMessage {
  factory GetIDDocumentsResponse({
    $core.bool? success,
    $core.String? message,
    $core.Iterable<IDDocument>? documents,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    if (documents != null) {
      $result.documents.addAll(documents);
    }
    return $result;
  }
  GetIDDocumentsResponse._() : super();
  factory GetIDDocumentsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetIDDocumentsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetIDDocumentsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..pc<IDDocument>(3, _omitFieldNames ? '' : 'documents', $pb.PbFieldType.PM, subBuilder: IDDocument.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetIDDocumentsResponse clone() => GetIDDocumentsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetIDDocumentsResponse copyWith(void Function(GetIDDocumentsResponse) updates) => super.copyWith((message) => updates(message as GetIDDocumentsResponse)) as GetIDDocumentsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetIDDocumentsResponse create() => GetIDDocumentsResponse._();
  GetIDDocumentsResponse createEmptyInstance() => create();
  static $pb.PbList<GetIDDocumentsResponse> createRepeated() => $pb.PbList<GetIDDocumentsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetIDDocumentsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetIDDocumentsResponse>(create);
  static GetIDDocumentsResponse? _defaultInstance;

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
  $core.List<IDDocument> get documents => $_getList(2);
}

class VerifyIDDocumentRequest extends $pb.GeneratedMessage {
  factory VerifyIDDocumentRequest({
    $core.String? documentId,
  }) {
    final $result = create();
    if (documentId != null) {
      $result.documentId = documentId;
    }
    return $result;
  }
  VerifyIDDocumentRequest._() : super();
  factory VerifyIDDocumentRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VerifyIDDocumentRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'VerifyIDDocumentRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'documentId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VerifyIDDocumentRequest clone() => VerifyIDDocumentRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VerifyIDDocumentRequest copyWith(void Function(VerifyIDDocumentRequest) updates) => super.copyWith((message) => updates(message as VerifyIDDocumentRequest)) as VerifyIDDocumentRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VerifyIDDocumentRequest create() => VerifyIDDocumentRequest._();
  VerifyIDDocumentRequest createEmptyInstance() => create();
  static $pb.PbList<VerifyIDDocumentRequest> createRepeated() => $pb.PbList<VerifyIDDocumentRequest>();
  @$core.pragma('dart2js:noInline')
  static VerifyIDDocumentRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VerifyIDDocumentRequest>(create);
  static VerifyIDDocumentRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get documentId => $_getSZ(0);
  @$pb.TagNumber(1)
  set documentId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDocumentId() => $_has(0);
  @$pb.TagNumber(1)
  void clearDocumentId() => clearField(1);
}

class VerifyIDDocumentResponse extends $pb.GeneratedMessage {
  factory VerifyIDDocumentResponse({
    $core.bool? success,
    $core.String? message,
    IDDocument? document,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    if (document != null) {
      $result.document = document;
    }
    return $result;
  }
  VerifyIDDocumentResponse._() : super();
  factory VerifyIDDocumentResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VerifyIDDocumentResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'VerifyIDDocumentResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<IDDocument>(3, _omitFieldNames ? '' : 'document', subBuilder: IDDocument.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VerifyIDDocumentResponse clone() => VerifyIDDocumentResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VerifyIDDocumentResponse copyWith(void Function(VerifyIDDocumentResponse) updates) => super.copyWith((message) => updates(message as VerifyIDDocumentResponse)) as VerifyIDDocumentResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VerifyIDDocumentResponse create() => VerifyIDDocumentResponse._();
  VerifyIDDocumentResponse createEmptyInstance() => create();
  static $pb.PbList<VerifyIDDocumentResponse> createRepeated() => $pb.PbList<VerifyIDDocumentResponse>();
  @$core.pragma('dart2js:noInline')
  static VerifyIDDocumentResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VerifyIDDocumentResponse>(create);
  static VerifyIDDocumentResponse? _defaultInstance;

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
  IDDocument get document => $_getN(2);
  @$pb.TagNumber(3)
  set document(IDDocument v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasDocument() => $_has(2);
  @$pb.TagNumber(3)
  void clearDocument() => clearField(3);
  @$pb.TagNumber(3)
  IDDocument ensureDocument() => $_ensure(2);
}

/// Facial Recognition Messages
class FacialData extends $pb.GeneratedMessage {
  factory FacialData({
    $core.String? id,
    $fixnum.Int64? userId,
    $core.String? faceId,
    $core.String? faceEncoding,
    $core.String? imageUrl,
    $core.bool? isVerified,
    $2.Timestamp? createdAt,
    $2.Timestamp? lastVerifiedAt,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (userId != null) {
      $result.userId = userId;
    }
    if (faceId != null) {
      $result.faceId = faceId;
    }
    if (faceEncoding != null) {
      $result.faceEncoding = faceEncoding;
    }
    if (imageUrl != null) {
      $result.imageUrl = imageUrl;
    }
    if (isVerified != null) {
      $result.isVerified = isVerified;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    if (lastVerifiedAt != null) {
      $result.lastVerifiedAt = lastVerifiedAt;
    }
    return $result;
  }
  FacialData._() : super();
  factory FacialData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FacialData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FacialData', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'userId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(3, _omitFieldNames ? '' : 'faceId')
    ..aOS(4, _omitFieldNames ? '' : 'faceEncoding')
    ..aOS(5, _omitFieldNames ? '' : 'imageUrl')
    ..aOB(6, _omitFieldNames ? '' : 'isVerified')
    ..aOM<$2.Timestamp>(7, _omitFieldNames ? '' : 'createdAt', subBuilder: $2.Timestamp.create)
    ..aOM<$2.Timestamp>(8, _omitFieldNames ? '' : 'lastVerifiedAt', subBuilder: $2.Timestamp.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FacialData clone() => FacialData()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FacialData copyWith(void Function(FacialData) updates) => super.copyWith((message) => updates(message as FacialData)) as FacialData;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FacialData create() => FacialData._();
  FacialData createEmptyInstance() => create();
  static $pb.PbList<FacialData> createRepeated() => $pb.PbList<FacialData>();
  @$core.pragma('dart2js:noInline')
  static FacialData getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FacialData>(create);
  static FacialData? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get userId => $_getI64(1);
  @$pb.TagNumber(2)
  set userId($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get faceId => $_getSZ(2);
  @$pb.TagNumber(3)
  set faceId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasFaceId() => $_has(2);
  @$pb.TagNumber(3)
  void clearFaceId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get faceEncoding => $_getSZ(3);
  @$pb.TagNumber(4)
  set faceEncoding($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasFaceEncoding() => $_has(3);
  @$pb.TagNumber(4)
  void clearFaceEncoding() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get imageUrl => $_getSZ(4);
  @$pb.TagNumber(5)
  set imageUrl($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasImageUrl() => $_has(4);
  @$pb.TagNumber(5)
  void clearImageUrl() => clearField(5);

  @$pb.TagNumber(6)
  $core.bool get isVerified => $_getBF(5);
  @$pb.TagNumber(6)
  set isVerified($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasIsVerified() => $_has(5);
  @$pb.TagNumber(6)
  void clearIsVerified() => clearField(6);

  @$pb.TagNumber(7)
  $2.Timestamp get createdAt => $_getN(6);
  @$pb.TagNumber(7)
  set createdAt($2.Timestamp v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasCreatedAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearCreatedAt() => clearField(7);
  @$pb.TagNumber(7)
  $2.Timestamp ensureCreatedAt() => $_ensure(6);

  @$pb.TagNumber(8)
  $2.Timestamp get lastVerifiedAt => $_getN(7);
  @$pb.TagNumber(8)
  set lastVerifiedAt($2.Timestamp v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasLastVerifiedAt() => $_has(7);
  @$pb.TagNumber(8)
  void clearLastVerifiedAt() => clearField(8);
  @$pb.TagNumber(8)
  $2.Timestamp ensureLastVerifiedAt() => $_ensure(7);
}

class UserRegisterFaceRequest extends $pb.GeneratedMessage {
  factory UserRegisterFaceRequest({
    $core.List<$core.int>? faceImage,
  }) {
    final $result = create();
    if (faceImage != null) {
      $result.faceImage = faceImage;
    }
    return $result;
  }
  UserRegisterFaceRequest._() : super();
  factory UserRegisterFaceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UserRegisterFaceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UserRegisterFaceRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'faceImage', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UserRegisterFaceRequest clone() => UserRegisterFaceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UserRegisterFaceRequest copyWith(void Function(UserRegisterFaceRequest) updates) => super.copyWith((message) => updates(message as UserRegisterFaceRequest)) as UserRegisterFaceRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UserRegisterFaceRequest create() => UserRegisterFaceRequest._();
  UserRegisterFaceRequest createEmptyInstance() => create();
  static $pb.PbList<UserRegisterFaceRequest> createRepeated() => $pb.PbList<UserRegisterFaceRequest>();
  @$core.pragma('dart2js:noInline')
  static UserRegisterFaceRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UserRegisterFaceRequest>(create);
  static UserRegisterFaceRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get faceImage => $_getN(0);
  @$pb.TagNumber(1)
  set faceImage($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFaceImage() => $_has(0);
  @$pb.TagNumber(1)
  void clearFaceImage() => clearField(1);
}

class UserRegisterFaceResponse extends $pb.GeneratedMessage {
  factory UserRegisterFaceResponse({
    $core.bool? success,
    $core.String? message,
    FacialData? facialData,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    if (facialData != null) {
      $result.facialData = facialData;
    }
    return $result;
  }
  UserRegisterFaceResponse._() : super();
  factory UserRegisterFaceResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UserRegisterFaceResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UserRegisterFaceResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<FacialData>(3, _omitFieldNames ? '' : 'facialData', subBuilder: FacialData.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UserRegisterFaceResponse clone() => UserRegisterFaceResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UserRegisterFaceResponse copyWith(void Function(UserRegisterFaceResponse) updates) => super.copyWith((message) => updates(message as UserRegisterFaceResponse)) as UserRegisterFaceResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UserRegisterFaceResponse create() => UserRegisterFaceResponse._();
  UserRegisterFaceResponse createEmptyInstance() => create();
  static $pb.PbList<UserRegisterFaceResponse> createRepeated() => $pb.PbList<UserRegisterFaceResponse>();
  @$core.pragma('dart2js:noInline')
  static UserRegisterFaceResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UserRegisterFaceResponse>(create);
  static UserRegisterFaceResponse? _defaultInstance;

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
  FacialData get facialData => $_getN(2);
  @$pb.TagNumber(3)
  set facialData(FacialData v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasFacialData() => $_has(2);
  @$pb.TagNumber(3)
  void clearFacialData() => clearField(3);
  @$pb.TagNumber(3)
  FacialData ensureFacialData() => $_ensure(2);
}

class UserVerifyFaceRequest extends $pb.GeneratedMessage {
  factory UserVerifyFaceRequest({
    $core.List<$core.int>? faceImage,
  }) {
    final $result = create();
    if (faceImage != null) {
      $result.faceImage = faceImage;
    }
    return $result;
  }
  UserVerifyFaceRequest._() : super();
  factory UserVerifyFaceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UserVerifyFaceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UserVerifyFaceRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'faceImage', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UserVerifyFaceRequest clone() => UserVerifyFaceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UserVerifyFaceRequest copyWith(void Function(UserVerifyFaceRequest) updates) => super.copyWith((message) => updates(message as UserVerifyFaceRequest)) as UserVerifyFaceRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UserVerifyFaceRequest create() => UserVerifyFaceRequest._();
  UserVerifyFaceRequest createEmptyInstance() => create();
  static $pb.PbList<UserVerifyFaceRequest> createRepeated() => $pb.PbList<UserVerifyFaceRequest>();
  @$core.pragma('dart2js:noInline')
  static UserVerifyFaceRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UserVerifyFaceRequest>(create);
  static UserVerifyFaceRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get faceImage => $_getN(0);
  @$pb.TagNumber(1)
  set faceImage($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFaceImage() => $_has(0);
  @$pb.TagNumber(1)
  void clearFaceImage() => clearField(1);
}

class UserVerifyFaceResponse extends $pb.GeneratedMessage {
  factory UserVerifyFaceResponse({
    $core.bool? success,
    $core.String? message,
    $core.bool? isMatch,
    $core.double? confidence,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    if (isMatch != null) {
      $result.isMatch = isMatch;
    }
    if (confidence != null) {
      $result.confidence = confidence;
    }
    return $result;
  }
  UserVerifyFaceResponse._() : super();
  factory UserVerifyFaceResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UserVerifyFaceResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UserVerifyFaceResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOB(3, _omitFieldNames ? '' : 'isMatch')
    ..a<$core.double>(4, _omitFieldNames ? '' : 'confidence', $pb.PbFieldType.OF)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UserVerifyFaceResponse clone() => UserVerifyFaceResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UserVerifyFaceResponse copyWith(void Function(UserVerifyFaceResponse) updates) => super.copyWith((message) => updates(message as UserVerifyFaceResponse)) as UserVerifyFaceResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UserVerifyFaceResponse create() => UserVerifyFaceResponse._();
  UserVerifyFaceResponse createEmptyInstance() => create();
  static $pb.PbList<UserVerifyFaceResponse> createRepeated() => $pb.PbList<UserVerifyFaceResponse>();
  @$core.pragma('dart2js:noInline')
  static UserVerifyFaceResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UserVerifyFaceResponse>(create);
  static UserVerifyFaceResponse? _defaultInstance;

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
  $core.bool get isMatch => $_getBF(2);
  @$pb.TagNumber(3)
  set isMatch($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasIsMatch() => $_has(2);
  @$pb.TagNumber(3)
  void clearIsMatch() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get confidence => $_getN(3);
  @$pb.TagNumber(4)
  set confidence($core.double v) { $_setFloat(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasConfidence() => $_has(3);
  @$pb.TagNumber(4)
  void clearConfidence() => clearField(4);
}

class GetFacialDataRequest extends $pb.GeneratedMessage {
  factory GetFacialDataRequest() => create();
  GetFacialDataRequest._() : super();
  factory GetFacialDataRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetFacialDataRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetFacialDataRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetFacialDataRequest clone() => GetFacialDataRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetFacialDataRequest copyWith(void Function(GetFacialDataRequest) updates) => super.copyWith((message) => updates(message as GetFacialDataRequest)) as GetFacialDataRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetFacialDataRequest create() => GetFacialDataRequest._();
  GetFacialDataRequest createEmptyInstance() => create();
  static $pb.PbList<GetFacialDataRequest> createRepeated() => $pb.PbList<GetFacialDataRequest>();
  @$core.pragma('dart2js:noInline')
  static GetFacialDataRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetFacialDataRequest>(create);
  static GetFacialDataRequest? _defaultInstance;
}

class GetFacialDataResponse extends $pb.GeneratedMessage {
  factory GetFacialDataResponse({
    $core.bool? success,
    $core.String? message,
    FacialData? facialData,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    if (facialData != null) {
      $result.facialData = facialData;
    }
    return $result;
  }
  GetFacialDataResponse._() : super();
  factory GetFacialDataResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetFacialDataResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetFacialDataResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<FacialData>(3, _omitFieldNames ? '' : 'facialData', subBuilder: FacialData.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetFacialDataResponse clone() => GetFacialDataResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetFacialDataResponse copyWith(void Function(GetFacialDataResponse) updates) => super.copyWith((message) => updates(message as GetFacialDataResponse)) as GetFacialDataResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetFacialDataResponse create() => GetFacialDataResponse._();
  GetFacialDataResponse createEmptyInstance() => create();
  static $pb.PbList<GetFacialDataResponse> createRepeated() => $pb.PbList<GetFacialDataResponse>();
  @$core.pragma('dart2js:noInline')
  static GetFacialDataResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetFacialDataResponse>(create);
  static GetFacialDataResponse? _defaultInstance;

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
  FacialData get facialData => $_getN(2);
  @$pb.TagNumber(3)
  set facialData(FacialData v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasFacialData() => $_has(2);
  @$pb.TagNumber(3)
  void clearFacialData() => clearField(3);
  @$pb.TagNumber(3)
  FacialData ensureFacialData() => $_ensure(2);
}

/// Passcode Messages
class SetPasscodeRequest extends $pb.GeneratedMessage {
  factory SetPasscodeRequest({
    $core.String? passcode,
    $core.String? password,
  }) {
    final $result = create();
    if (passcode != null) {
      $result.passcode = passcode;
    }
    if (password != null) {
      $result.password = password;
    }
    return $result;
  }
  SetPasscodeRequest._() : super();
  factory SetPasscodeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SetPasscodeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SetPasscodeRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'passcode')
    ..aOS(2, _omitFieldNames ? '' : 'password')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SetPasscodeRequest clone() => SetPasscodeRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SetPasscodeRequest copyWith(void Function(SetPasscodeRequest) updates) => super.copyWith((message) => updates(message as SetPasscodeRequest)) as SetPasscodeRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SetPasscodeRequest create() => SetPasscodeRequest._();
  SetPasscodeRequest createEmptyInstance() => create();
  static $pb.PbList<SetPasscodeRequest> createRepeated() => $pb.PbList<SetPasscodeRequest>();
  @$core.pragma('dart2js:noInline')
  static SetPasscodeRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SetPasscodeRequest>(create);
  static SetPasscodeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get passcode => $_getSZ(0);
  @$pb.TagNumber(1)
  set passcode($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPasscode() => $_has(0);
  @$pb.TagNumber(1)
  void clearPasscode() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get password => $_getSZ(1);
  @$pb.TagNumber(2)
  set password($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPassword() => $_has(1);
  @$pb.TagNumber(2)
  void clearPassword() => clearField(2);
}

class SetPasscodeResponse extends $pb.GeneratedMessage {
  factory SetPasscodeResponse({
    $core.bool? success,
    $core.String? message,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  SetPasscodeResponse._() : super();
  factory SetPasscodeResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SetPasscodeResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SetPasscodeResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SetPasscodeResponse clone() => SetPasscodeResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SetPasscodeResponse copyWith(void Function(SetPasscodeResponse) updates) => super.copyWith((message) => updates(message as SetPasscodeResponse)) as SetPasscodeResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SetPasscodeResponse create() => SetPasscodeResponse._();
  SetPasscodeResponse createEmptyInstance() => create();
  static $pb.PbList<SetPasscodeResponse> createRepeated() => $pb.PbList<SetPasscodeResponse>();
  @$core.pragma('dart2js:noInline')
  static SetPasscodeResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SetPasscodeResponse>(create);
  static SetPasscodeResponse? _defaultInstance;

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

class VerifyPasscodeRequest extends $pb.GeneratedMessage {
  factory VerifyPasscodeRequest({
    $core.String? passcode,
  }) {
    final $result = create();
    if (passcode != null) {
      $result.passcode = passcode;
    }
    return $result;
  }
  VerifyPasscodeRequest._() : super();
  factory VerifyPasscodeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VerifyPasscodeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'VerifyPasscodeRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'passcode')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VerifyPasscodeRequest clone() => VerifyPasscodeRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VerifyPasscodeRequest copyWith(void Function(VerifyPasscodeRequest) updates) => super.copyWith((message) => updates(message as VerifyPasscodeRequest)) as VerifyPasscodeRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VerifyPasscodeRequest create() => VerifyPasscodeRequest._();
  VerifyPasscodeRequest createEmptyInstance() => create();
  static $pb.PbList<VerifyPasscodeRequest> createRepeated() => $pb.PbList<VerifyPasscodeRequest>();
  @$core.pragma('dart2js:noInline')
  static VerifyPasscodeRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VerifyPasscodeRequest>(create);
  static VerifyPasscodeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get passcode => $_getSZ(0);
  @$pb.TagNumber(1)
  set passcode($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPasscode() => $_has(0);
  @$pb.TagNumber(1)
  void clearPasscode() => clearField(1);
}

class VerifyPasscodeResponse extends $pb.GeneratedMessage {
  factory VerifyPasscodeResponse({
    $core.bool? success,
    $core.String? message,
    $core.bool? isValid,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    if (isValid != null) {
      $result.isValid = isValid;
    }
    return $result;
  }
  VerifyPasscodeResponse._() : super();
  factory VerifyPasscodeResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VerifyPasscodeResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'VerifyPasscodeResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOB(3, _omitFieldNames ? '' : 'isValid')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VerifyPasscodeResponse clone() => VerifyPasscodeResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VerifyPasscodeResponse copyWith(void Function(VerifyPasscodeResponse) updates) => super.copyWith((message) => updates(message as VerifyPasscodeResponse)) as VerifyPasscodeResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VerifyPasscodeResponse create() => VerifyPasscodeResponse._();
  VerifyPasscodeResponse createEmptyInstance() => create();
  static $pb.PbList<VerifyPasscodeResponse> createRepeated() => $pb.PbList<VerifyPasscodeResponse>();
  @$core.pragma('dart2js:noInline')
  static VerifyPasscodeResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VerifyPasscodeResponse>(create);
  static VerifyPasscodeResponse? _defaultInstance;

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
  $core.bool get isValid => $_getBF(2);
  @$pb.TagNumber(3)
  set isValid($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasIsValid() => $_has(2);
  @$pb.TagNumber(3)
  void clearIsValid() => clearField(3);
}

class RemovePasscodeRequest extends $pb.GeneratedMessage {
  factory RemovePasscodeRequest({
    $core.String? password,
  }) {
    final $result = create();
    if (password != null) {
      $result.password = password;
    }
    return $result;
  }
  RemovePasscodeRequest._() : super();
  factory RemovePasscodeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RemovePasscodeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RemovePasscodeRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'password')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RemovePasscodeRequest clone() => RemovePasscodeRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RemovePasscodeRequest copyWith(void Function(RemovePasscodeRequest) updates) => super.copyWith((message) => updates(message as RemovePasscodeRequest)) as RemovePasscodeRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RemovePasscodeRequest create() => RemovePasscodeRequest._();
  RemovePasscodeRequest createEmptyInstance() => create();
  static $pb.PbList<RemovePasscodeRequest> createRepeated() => $pb.PbList<RemovePasscodeRequest>();
  @$core.pragma('dart2js:noInline')
  static RemovePasscodeRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RemovePasscodeRequest>(create);
  static RemovePasscodeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get password => $_getSZ(0);
  @$pb.TagNumber(1)
  set password($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPassword() => $_has(0);
  @$pb.TagNumber(1)
  void clearPassword() => clearField(1);
}

class RemovePasscodeResponse extends $pb.GeneratedMessage {
  factory RemovePasscodeResponse({
    $core.bool? success,
    $core.String? message,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  RemovePasscodeResponse._() : super();
  factory RemovePasscodeResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RemovePasscodeResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RemovePasscodeResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RemovePasscodeResponse clone() => RemovePasscodeResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RemovePasscodeResponse copyWith(void Function(RemovePasscodeResponse) updates) => super.copyWith((message) => updates(message as RemovePasscodeResponse)) as RemovePasscodeResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RemovePasscodeResponse create() => RemovePasscodeResponse._();
  RemovePasscodeResponse createEmptyInstance() => create();
  static $pb.PbList<RemovePasscodeResponse> createRepeated() => $pb.PbList<RemovePasscodeResponse>();
  @$core.pragma('dart2js:noInline')
  static RemovePasscodeResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RemovePasscodeResponse>(create);
  static RemovePasscodeResponse? _defaultInstance;

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

class CheckPasscodeExistsRequest extends $pb.GeneratedMessage {
  factory CheckPasscodeExistsRequest() => create();
  CheckPasscodeExistsRequest._() : super();
  factory CheckPasscodeExistsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CheckPasscodeExistsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CheckPasscodeExistsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CheckPasscodeExistsRequest clone() => CheckPasscodeExistsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CheckPasscodeExistsRequest copyWith(void Function(CheckPasscodeExistsRequest) updates) => super.copyWith((message) => updates(message as CheckPasscodeExistsRequest)) as CheckPasscodeExistsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CheckPasscodeExistsRequest create() => CheckPasscodeExistsRequest._();
  CheckPasscodeExistsRequest createEmptyInstance() => create();
  static $pb.PbList<CheckPasscodeExistsRequest> createRepeated() => $pb.PbList<CheckPasscodeExistsRequest>();
  @$core.pragma('dart2js:noInline')
  static CheckPasscodeExistsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CheckPasscodeExistsRequest>(create);
  static CheckPasscodeExistsRequest? _defaultInstance;
}

class CheckPasscodeExistsResponse extends $pb.GeneratedMessage {
  factory CheckPasscodeExistsResponse({
    $core.bool? success,
    $core.bool? hasPasscode,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (hasPasscode != null) {
      $result.hasPasscode = hasPasscode;
    }
    return $result;
  }
  CheckPasscodeExistsResponse._() : super();
  factory CheckPasscodeExistsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CheckPasscodeExistsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CheckPasscodeExistsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOB(2, _omitFieldNames ? '' : 'hasPasscode')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CheckPasscodeExistsResponse clone() => CheckPasscodeExistsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CheckPasscodeExistsResponse copyWith(void Function(CheckPasscodeExistsResponse) updates) => super.copyWith((message) => updates(message as CheckPasscodeExistsResponse)) as CheckPasscodeExistsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CheckPasscodeExistsResponse create() => CheckPasscodeExistsResponse._();
  CheckPasscodeExistsResponse createEmptyInstance() => create();
  static $pb.PbList<CheckPasscodeExistsResponse> createRepeated() => $pb.PbList<CheckPasscodeExistsResponse>();
  @$core.pragma('dart2js:noInline')
  static CheckPasscodeExistsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CheckPasscodeExistsResponse>(create);
  static CheckPasscodeExistsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get hasPasscode => $_getBF(1);
  @$pb.TagNumber(2)
  set hasPasscode($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasHasPasscode() => $_has(1);
  @$pb.TagNumber(2)
  void clearHasPasscode() => clearField(2);
}

class DevicePermission extends $pb.GeneratedMessage {
  factory DevicePermission({
    PermissionType? permissionType,
    $core.bool? isGranted,
    $2.Timestamp? grantedAt,
  }) {
    final $result = create();
    if (permissionType != null) {
      $result.permissionType = permissionType;
    }
    if (isGranted != null) {
      $result.isGranted = isGranted;
    }
    if (grantedAt != null) {
      $result.grantedAt = grantedAt;
    }
    return $result;
  }
  DevicePermission._() : super();
  factory DevicePermission.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DevicePermission.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DevicePermission', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..e<PermissionType>(1, _omitFieldNames ? '' : 'permissionType', $pb.PbFieldType.OE, defaultOrMaker: PermissionType.PERMISSION_TYPE_CAMERA, valueOf: PermissionType.valueOf, enumValues: PermissionType.values)
    ..aOB(2, _omitFieldNames ? '' : 'isGranted')
    ..aOM<$2.Timestamp>(3, _omitFieldNames ? '' : 'grantedAt', subBuilder: $2.Timestamp.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DevicePermission clone() => DevicePermission()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DevicePermission copyWith(void Function(DevicePermission) updates) => super.copyWith((message) => updates(message as DevicePermission)) as DevicePermission;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DevicePermission create() => DevicePermission._();
  DevicePermission createEmptyInstance() => create();
  static $pb.PbList<DevicePermission> createRepeated() => $pb.PbList<DevicePermission>();
  @$core.pragma('dart2js:noInline')
  static DevicePermission getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DevicePermission>(create);
  static DevicePermission? _defaultInstance;

  @$pb.TagNumber(1)
  PermissionType get permissionType => $_getN(0);
  @$pb.TagNumber(1)
  set permissionType(PermissionType v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasPermissionType() => $_has(0);
  @$pb.TagNumber(1)
  void clearPermissionType() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get isGranted => $_getBF(1);
  @$pb.TagNumber(2)
  set isGranted($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasIsGranted() => $_has(1);
  @$pb.TagNumber(2)
  void clearIsGranted() => clearField(2);

  @$pb.TagNumber(3)
  $2.Timestamp get grantedAt => $_getN(2);
  @$pb.TagNumber(3)
  set grantedAt($2.Timestamp v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasGrantedAt() => $_has(2);
  @$pb.TagNumber(3)
  void clearGrantedAt() => clearField(3);
  @$pb.TagNumber(3)
  $2.Timestamp ensureGrantedAt() => $_ensure(2);
}

class UpdateDevicePermissionsRequest extends $pb.GeneratedMessage {
  factory UpdateDevicePermissionsRequest({
    $core.Iterable<DevicePermission>? permissions,
  }) {
    final $result = create();
    if (permissions != null) {
      $result.permissions.addAll(permissions);
    }
    return $result;
  }
  UpdateDevicePermissionsRequest._() : super();
  factory UpdateDevicePermissionsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateDevicePermissionsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateDevicePermissionsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<DevicePermission>(1, _omitFieldNames ? '' : 'permissions', $pb.PbFieldType.PM, subBuilder: DevicePermission.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateDevicePermissionsRequest clone() => UpdateDevicePermissionsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateDevicePermissionsRequest copyWith(void Function(UpdateDevicePermissionsRequest) updates) => super.copyWith((message) => updates(message as UpdateDevicePermissionsRequest)) as UpdateDevicePermissionsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateDevicePermissionsRequest create() => UpdateDevicePermissionsRequest._();
  UpdateDevicePermissionsRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateDevicePermissionsRequest> createRepeated() => $pb.PbList<UpdateDevicePermissionsRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateDevicePermissionsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateDevicePermissionsRequest>(create);
  static UpdateDevicePermissionsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<DevicePermission> get permissions => $_getList(0);
}

class UpdateDevicePermissionsResponse extends $pb.GeneratedMessage {
  factory UpdateDevicePermissionsResponse({
    $core.bool? success,
    $core.String? message,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  UpdateDevicePermissionsResponse._() : super();
  factory UpdateDevicePermissionsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateDevicePermissionsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateDevicePermissionsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateDevicePermissionsResponse clone() => UpdateDevicePermissionsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateDevicePermissionsResponse copyWith(void Function(UpdateDevicePermissionsResponse) updates) => super.copyWith((message) => updates(message as UpdateDevicePermissionsResponse)) as UpdateDevicePermissionsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateDevicePermissionsResponse create() => UpdateDevicePermissionsResponse._();
  UpdateDevicePermissionsResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateDevicePermissionsResponse> createRepeated() => $pb.PbList<UpdateDevicePermissionsResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateDevicePermissionsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateDevicePermissionsResponse>(create);
  static UpdateDevicePermissionsResponse? _defaultInstance;

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

class GetDevicePermissionsRequest extends $pb.GeneratedMessage {
  factory GetDevicePermissionsRequest() => create();
  GetDevicePermissionsRequest._() : super();
  factory GetDevicePermissionsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetDevicePermissionsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetDevicePermissionsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetDevicePermissionsRequest clone() => GetDevicePermissionsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetDevicePermissionsRequest copyWith(void Function(GetDevicePermissionsRequest) updates) => super.copyWith((message) => updates(message as GetDevicePermissionsRequest)) as GetDevicePermissionsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetDevicePermissionsRequest create() => GetDevicePermissionsRequest._();
  GetDevicePermissionsRequest createEmptyInstance() => create();
  static $pb.PbList<GetDevicePermissionsRequest> createRepeated() => $pb.PbList<GetDevicePermissionsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetDevicePermissionsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetDevicePermissionsRequest>(create);
  static GetDevicePermissionsRequest? _defaultInstance;
}

class GetDevicePermissionsResponse extends $pb.GeneratedMessage {
  factory GetDevicePermissionsResponse({
    $core.bool? success,
    $core.String? message,
    $core.Iterable<DevicePermission>? permissions,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    if (permissions != null) {
      $result.permissions.addAll(permissions);
    }
    return $result;
  }
  GetDevicePermissionsResponse._() : super();
  factory GetDevicePermissionsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetDevicePermissionsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetDevicePermissionsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..pc<DevicePermission>(3, _omitFieldNames ? '' : 'permissions', $pb.PbFieldType.PM, subBuilder: DevicePermission.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetDevicePermissionsResponse clone() => GetDevicePermissionsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetDevicePermissionsResponse copyWith(void Function(GetDevicePermissionsResponse) updates) => super.copyWith((message) => updates(message as GetDevicePermissionsResponse)) as GetDevicePermissionsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetDevicePermissionsResponse create() => GetDevicePermissionsResponse._();
  GetDevicePermissionsResponse createEmptyInstance() => create();
  static $pb.PbList<GetDevicePermissionsResponse> createRepeated() => $pb.PbList<GetDevicePermissionsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetDevicePermissionsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetDevicePermissionsResponse>(create);
  static GetDevicePermissionsResponse? _defaultInstance;

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
  $core.List<DevicePermission> get permissions => $_getList(2);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
