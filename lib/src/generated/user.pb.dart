///
//  Generated code. Do not modify.
//  source: user.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'common.pb.dart' as $29;
import 'google/protobuf/timestamp.pb.dart' as $28;

import 'user.pbenum.dart';

export 'user.pbenum.dart';

class CreateUserRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateUserRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'firstName')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lastName')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'email')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'password')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'phoneNumber')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'role')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'loginPasscode')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'username')
    ..hasRequiredFields = false
  ;

  CreateUserRequest._() : super();
  factory CreateUserRequest({
    $core.String? firstName,
    $core.String? lastName,
    $core.String? email,
    $core.String? password,
    $core.String? phoneNumber,
    $core.String? role,
    $core.String? loginPasscode,
    $core.String? username,
  }) {
    final _result = create();
    if (firstName != null) {
      _result.firstName = firstName;
    }
    if (lastName != null) {
      _result.lastName = lastName;
    }
    if (email != null) {
      _result.email = email;
    }
    if (password != null) {
      _result.password = password;
    }
    if (phoneNumber != null) {
      _result.phoneNumber = phoneNumber;
    }
    if (role != null) {
      _result.role = role;
    }
    if (loginPasscode != null) {
      _result.loginPasscode = loginPasscode;
    }
    if (username != null) {
      _result.username = username;
    }
    return _result;
  }
  factory CreateUserRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateUserRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateUserRequest clone() => CreateUserRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateUserRequest copyWith(void Function(CreateUserRequest) updates) => super.copyWith((message) => updates(message as CreateUserRequest)) as CreateUserRequest; // ignore: deprecated_member_use
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
}

class CreateUserResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateUserResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOM<$29.Data>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'data', subBuilder: $29.Data.create)
    ..hasRequiredFields = false
  ;

  CreateUserResponse._() : super();
  factory CreateUserResponse({
    $core.bool? success,
    $core.String? message,
    $29.Data? data,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (data != null) {
      _result.data = data;
    }
    return _result;
  }
  factory CreateUserResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateUserResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateUserResponse clone() => CreateUserResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateUserResponse copyWith(void Function(CreateUserResponse) updates) => super.copyWith((message) => updates(message as CreateUserResponse)) as CreateUserResponse; // ignore: deprecated_member_use
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
  $29.Data get data => $_getN(2);
  @$pb.TagNumber(3)
  set data($29.Data v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasData() => $_has(2);
  @$pb.TagNumber(3)
  void clearData() => clearField(3);
  @$pb.TagNumber(3)
  $29.Data ensureData() => $_ensure(2);
}

class GetUserProfileRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetUserProfileRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetUserProfileRequest._() : super();
  factory GetUserProfileRequest() => create();
  factory GetUserProfileRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserProfileRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUserProfileRequest clone() => GetUserProfileRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUserProfileRequest copyWith(void Function(GetUserProfileRequest) updates) => super.copyWith((message) => updates(message as GetUserProfileRequest)) as GetUserProfileRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetUserProfileResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOM<$29.User>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'user', subBuilder: $29.User.create)
    ..aOM<UserPreferences>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'preferences', subBuilder: UserPreferences.create)
    ..hasRequiredFields = false
  ;

  GetUserProfileResponse._() : super();
  factory GetUserProfileResponse({
    $core.bool? success,
    $core.String? message,
    $29.User? user,
    UserPreferences? preferences,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (user != null) {
      _result.user = user;
    }
    if (preferences != null) {
      _result.preferences = preferences;
    }
    return _result;
  }
  factory GetUserProfileResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserProfileResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUserProfileResponse clone() => GetUserProfileResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUserProfileResponse copyWith(void Function(GetUserProfileResponse) updates) => super.copyWith((message) => updates(message as GetUserProfileResponse)) as GetUserProfileResponse; // ignore: deprecated_member_use
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
  $29.User get user => $_getN(2);
  @$pb.TagNumber(3)
  set user($29.User v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasUser() => $_has(2);
  @$pb.TagNumber(3)
  void clearUser() => clearField(3);
  @$pb.TagNumber(3)
  $29.User ensureUser() => $_ensure(2);

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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateUserProfileRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'firstName')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lastName')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'username')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'phoneNumber')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'language')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'country')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'profilePicture')
    ..hasRequiredFields = false
  ;

  UpdateUserProfileRequest._() : super();
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
    final _result = create();
    if (firstName != null) {
      _result.firstName = firstName;
    }
    if (lastName != null) {
      _result.lastName = lastName;
    }
    if (username != null) {
      _result.username = username;
    }
    if (phoneNumber != null) {
      _result.phoneNumber = phoneNumber;
    }
    if (language != null) {
      _result.language = language;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (country != null) {
      _result.country = country;
    }
    if (profilePicture != null) {
      _result.profilePicture = profilePicture;
    }
    return _result;
  }
  factory UpdateUserProfileRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateUserProfileRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateUserProfileRequest clone() => UpdateUserProfileRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateUserProfileRequest copyWith(void Function(UpdateUserProfileRequest) updates) => super.copyWith((message) => updates(message as UpdateUserProfileRequest)) as UpdateUserProfileRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateUserProfileResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOM<$29.User>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'user', subBuilder: $29.User.create)
    ..hasRequiredFields = false
  ;

  UpdateUserProfileResponse._() : super();
  factory UpdateUserProfileResponse({
    $core.bool? success,
    $core.String? message,
    $29.User? user,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (user != null) {
      _result.user = user;
    }
    return _result;
  }
  factory UpdateUserProfileResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateUserProfileResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateUserProfileResponse clone() => UpdateUserProfileResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateUserProfileResponse copyWith(void Function(UpdateUserProfileResponse) updates) => super.copyWith((message) => updates(message as UpdateUserProfileResponse)) as UpdateUserProfileResponse; // ignore: deprecated_member_use
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
  $29.User get user => $_getN(2);
  @$pb.TagNumber(3)
  set user($29.User v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasUser() => $_has(2);
  @$pb.TagNumber(3)
  void clearUser() => clearField(3);
  @$pb.TagNumber(3)
  $29.User ensureUser() => $_ensure(2);
}

class UpdatePasswordRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdatePasswordRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currentPassword')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'newPassword')
    ..hasRequiredFields = false
  ;

  UpdatePasswordRequest._() : super();
  factory UpdatePasswordRequest({
    $core.String? currentPassword,
    $core.String? newPassword,
  }) {
    final _result = create();
    if (currentPassword != null) {
      _result.currentPassword = currentPassword;
    }
    if (newPassword != null) {
      _result.newPassword = newPassword;
    }
    return _result;
  }
  factory UpdatePasswordRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdatePasswordRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdatePasswordRequest clone() => UpdatePasswordRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdatePasswordRequest copyWith(void Function(UpdatePasswordRequest) updates) => super.copyWith((message) => updates(message as UpdatePasswordRequest)) as UpdatePasswordRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdatePasswordResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  UpdatePasswordResponse._() : super();
  factory UpdatePasswordResponse({
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
  factory UpdatePasswordResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdatePasswordResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdatePasswordResponse clone() => UpdatePasswordResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdatePasswordResponse copyWith(void Function(UpdatePasswordResponse) updates) => super.copyWith((message) => updates(message as UpdatePasswordResponse)) as UpdatePasswordResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdatePreferencesRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pushNotifications')
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'emailNotifications')
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'smsNotifications')
    ..aOB(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'darkMode')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'language')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..pPS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'preferredCountries')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'activeCountry')
    ..hasRequiredFields = false
  ;

  UpdatePreferencesRequest._() : super();
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
    final _result = create();
    if (pushNotifications != null) {
      _result.pushNotifications = pushNotifications;
    }
    if (emailNotifications != null) {
      _result.emailNotifications = emailNotifications;
    }
    if (smsNotifications != null) {
      _result.smsNotifications = smsNotifications;
    }
    if (darkMode != null) {
      _result.darkMode = darkMode;
    }
    if (language != null) {
      _result.language = language;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (preferredCountries != null) {
      _result.preferredCountries.addAll(preferredCountries);
    }
    if (activeCountry != null) {
      _result.activeCountry = activeCountry;
    }
    return _result;
  }
  factory UpdatePreferencesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdatePreferencesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdatePreferencesRequest clone() => UpdatePreferencesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdatePreferencesRequest copyWith(void Function(UpdatePreferencesRequest) updates) => super.copyWith((message) => updates(message as UpdatePreferencesRequest)) as UpdatePreferencesRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdatePreferencesResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOM<UserPreferences>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'preferences', subBuilder: UserPreferences.create)
    ..hasRequiredFields = false
  ;

  UpdatePreferencesResponse._() : super();
  factory UpdatePreferencesResponse({
    $core.bool? success,
    $core.String? message,
    UserPreferences? preferences,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (preferences != null) {
      _result.preferences = preferences;
    }
    return _result;
  }
  factory UpdatePreferencesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdatePreferencesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdatePreferencesResponse clone() => UpdatePreferencesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdatePreferencesResponse copyWith(void Function(UpdatePreferencesResponse) updates) => super.copyWith((message) => updates(message as UpdatePreferencesResponse)) as UpdatePreferencesResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UserPreferences', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pushNotifications')
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'emailNotifications')
    ..aOB(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'smsNotifications')
    ..aOB(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'darkMode')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'language')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'country')
    ..pPS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'preferredCountries')
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'activeCountry')
    ..hasRequiredFields = false
  ;

  UserPreferences._() : super();
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
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    if (pushNotifications != null) {
      _result.pushNotifications = pushNotifications;
    }
    if (emailNotifications != null) {
      _result.emailNotifications = emailNotifications;
    }
    if (smsNotifications != null) {
      _result.smsNotifications = smsNotifications;
    }
    if (darkMode != null) {
      _result.darkMode = darkMode;
    }
    if (language != null) {
      _result.language = language;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (country != null) {
      _result.country = country;
    }
    if (preferredCountries != null) {
      _result.preferredCountries.addAll(preferredCountries);
    }
    if (activeCountry != null) {
      _result.activeCountry = activeCountry;
    }
    return _result;
  }
  factory UserPreferences.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UserPreferences.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UserPreferences clone() => UserPreferences()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UserPreferences copyWith(void Function(UserPreferences) updates) => super.copyWith((message) => updates(message as UserPreferences)) as UserPreferences; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'IDDocument', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..a<$fixnum.Int64>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..e<DocumentType>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'documentType', $pb.PbFieldType.OE, defaultOrMaker: DocumentType.DOCUMENT_TYPE_PASSPORT, valueOf: DocumentType.valueOf, enumValues: DocumentType.values)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'documentNumber')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fullName')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dateOfBirth')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'issueDate')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'expiryDate')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'issuingCountry')
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'documentFrontUrl')
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'documentBackUrl')
    ..e<VerificationStatus>(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'verificationStatus', $pb.PbFieldType.OE, defaultOrMaker: VerificationStatus.VERIFICATION_STATUS_PENDING, valueOf: VerificationStatus.valueOf, enumValues: VerificationStatus.values)
    ..aOS(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'rejectionReason')
    ..aOM<$28.Timestamp>(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $28.Timestamp.create)
    ..aOM<$28.Timestamp>(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'verifiedAt', subBuilder: $28.Timestamp.create)
    ..hasRequiredFields = false
  ;

  IDDocument._() : super();
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
    $28.Timestamp? createdAt,
    $28.Timestamp? verifiedAt,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (documentType != null) {
      _result.documentType = documentType;
    }
    if (documentNumber != null) {
      _result.documentNumber = documentNumber;
    }
    if (fullName != null) {
      _result.fullName = fullName;
    }
    if (dateOfBirth != null) {
      _result.dateOfBirth = dateOfBirth;
    }
    if (issueDate != null) {
      _result.issueDate = issueDate;
    }
    if (expiryDate != null) {
      _result.expiryDate = expiryDate;
    }
    if (issuingCountry != null) {
      _result.issuingCountry = issuingCountry;
    }
    if (documentFrontUrl != null) {
      _result.documentFrontUrl = documentFrontUrl;
    }
    if (documentBackUrl != null) {
      _result.documentBackUrl = documentBackUrl;
    }
    if (verificationStatus != null) {
      _result.verificationStatus = verificationStatus;
    }
    if (rejectionReason != null) {
      _result.rejectionReason = rejectionReason;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (verifiedAt != null) {
      _result.verifiedAt = verifiedAt;
    }
    return _result;
  }
  factory IDDocument.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory IDDocument.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  IDDocument clone() => IDDocument()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  IDDocument copyWith(void Function(IDDocument) updates) => super.copyWith((message) => updates(message as IDDocument)) as IDDocument; // ignore: deprecated_member_use
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
  $28.Timestamp get createdAt => $_getN(13);
  @$pb.TagNumber(14)
  set createdAt($28.Timestamp v) { setField(14, v); }
  @$pb.TagNumber(14)
  $core.bool hasCreatedAt() => $_has(13);
  @$pb.TagNumber(14)
  void clearCreatedAt() => clearField(14);
  @$pb.TagNumber(14)
  $28.Timestamp ensureCreatedAt() => $_ensure(13);

  @$pb.TagNumber(15)
  $28.Timestamp get verifiedAt => $_getN(14);
  @$pb.TagNumber(15)
  set verifiedAt($28.Timestamp v) { setField(15, v); }
  @$pb.TagNumber(15)
  $core.bool hasVerifiedAt() => $_has(14);
  @$pb.TagNumber(15)
  void clearVerifiedAt() => clearField(15);
  @$pb.TagNumber(15)
  $28.Timestamp ensureVerifiedAt() => $_ensure(14);
}

class UploadIDDocumentRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UploadIDDocumentRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..e<DocumentType>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'documentType', $pb.PbFieldType.OE, defaultOrMaker: DocumentType.DOCUMENT_TYPE_PASSPORT, valueOf: DocumentType.valueOf, enumValues: DocumentType.values)
    ..a<$core.List<$core.int>>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'frontImage', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'backImage', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  UploadIDDocumentRequest._() : super();
  factory UploadIDDocumentRequest({
    DocumentType? documentType,
    $core.List<$core.int>? frontImage,
    $core.List<$core.int>? backImage,
  }) {
    final _result = create();
    if (documentType != null) {
      _result.documentType = documentType;
    }
    if (frontImage != null) {
      _result.frontImage = frontImage;
    }
    if (backImage != null) {
      _result.backImage = backImage;
    }
    return _result;
  }
  factory UploadIDDocumentRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UploadIDDocumentRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UploadIDDocumentRequest clone() => UploadIDDocumentRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UploadIDDocumentRequest copyWith(void Function(UploadIDDocumentRequest) updates) => super.copyWith((message) => updates(message as UploadIDDocumentRequest)) as UploadIDDocumentRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UploadIDDocumentResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOM<IDDocument>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'document', subBuilder: IDDocument.create)
    ..hasRequiredFields = false
  ;

  UploadIDDocumentResponse._() : super();
  factory UploadIDDocumentResponse({
    $core.bool? success,
    $core.String? message,
    IDDocument? document,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (document != null) {
      _result.document = document;
    }
    return _result;
  }
  factory UploadIDDocumentResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UploadIDDocumentResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UploadIDDocumentResponse clone() => UploadIDDocumentResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UploadIDDocumentResponse copyWith(void Function(UploadIDDocumentResponse) updates) => super.copyWith((message) => updates(message as UploadIDDocumentResponse)) as UploadIDDocumentResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetIDDocumentsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetIDDocumentsRequest._() : super();
  factory GetIDDocumentsRequest() => create();
  factory GetIDDocumentsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetIDDocumentsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetIDDocumentsRequest clone() => GetIDDocumentsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetIDDocumentsRequest copyWith(void Function(GetIDDocumentsRequest) updates) => super.copyWith((message) => updates(message as GetIDDocumentsRequest)) as GetIDDocumentsRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetIDDocumentsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..pc<IDDocument>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'documents', $pb.PbFieldType.PM, subBuilder: IDDocument.create)
    ..hasRequiredFields = false
  ;

  GetIDDocumentsResponse._() : super();
  factory GetIDDocumentsResponse({
    $core.bool? success,
    $core.String? message,
    $core.Iterable<IDDocument>? documents,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (documents != null) {
      _result.documents.addAll(documents);
    }
    return _result;
  }
  factory GetIDDocumentsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetIDDocumentsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetIDDocumentsResponse clone() => GetIDDocumentsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetIDDocumentsResponse copyWith(void Function(GetIDDocumentsResponse) updates) => super.copyWith((message) => updates(message as GetIDDocumentsResponse)) as GetIDDocumentsResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'VerifyIDDocumentRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'documentId')
    ..hasRequiredFields = false
  ;

  VerifyIDDocumentRequest._() : super();
  factory VerifyIDDocumentRequest({
    $core.String? documentId,
  }) {
    final _result = create();
    if (documentId != null) {
      _result.documentId = documentId;
    }
    return _result;
  }
  factory VerifyIDDocumentRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VerifyIDDocumentRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VerifyIDDocumentRequest clone() => VerifyIDDocumentRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VerifyIDDocumentRequest copyWith(void Function(VerifyIDDocumentRequest) updates) => super.copyWith((message) => updates(message as VerifyIDDocumentRequest)) as VerifyIDDocumentRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'VerifyIDDocumentResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOM<IDDocument>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'document', subBuilder: IDDocument.create)
    ..hasRequiredFields = false
  ;

  VerifyIDDocumentResponse._() : super();
  factory VerifyIDDocumentResponse({
    $core.bool? success,
    $core.String? message,
    IDDocument? document,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (document != null) {
      _result.document = document;
    }
    return _result;
  }
  factory VerifyIDDocumentResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VerifyIDDocumentResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VerifyIDDocumentResponse clone() => VerifyIDDocumentResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VerifyIDDocumentResponse copyWith(void Function(VerifyIDDocumentResponse) updates) => super.copyWith((message) => updates(message as VerifyIDDocumentResponse)) as VerifyIDDocumentResponse; // ignore: deprecated_member_use
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

class FacialData extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'FacialData', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..a<$fixnum.Int64>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'faceId')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'faceEncoding')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'imageUrl')
    ..aOB(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isVerified')
    ..aOM<$28.Timestamp>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $28.Timestamp.create)
    ..aOM<$28.Timestamp>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lastVerifiedAt', subBuilder: $28.Timestamp.create)
    ..hasRequiredFields = false
  ;

  FacialData._() : super();
  factory FacialData({
    $core.String? id,
    $fixnum.Int64? userId,
    $core.String? faceId,
    $core.String? faceEncoding,
    $core.String? imageUrl,
    $core.bool? isVerified,
    $28.Timestamp? createdAt,
    $28.Timestamp? lastVerifiedAt,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (faceId != null) {
      _result.faceId = faceId;
    }
    if (faceEncoding != null) {
      _result.faceEncoding = faceEncoding;
    }
    if (imageUrl != null) {
      _result.imageUrl = imageUrl;
    }
    if (isVerified != null) {
      _result.isVerified = isVerified;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (lastVerifiedAt != null) {
      _result.lastVerifiedAt = lastVerifiedAt;
    }
    return _result;
  }
  factory FacialData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FacialData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FacialData clone() => FacialData()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FacialData copyWith(void Function(FacialData) updates) => super.copyWith((message) => updates(message as FacialData)) as FacialData; // ignore: deprecated_member_use
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
  $28.Timestamp get createdAt => $_getN(6);
  @$pb.TagNumber(7)
  set createdAt($28.Timestamp v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasCreatedAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearCreatedAt() => clearField(7);
  @$pb.TagNumber(7)
  $28.Timestamp ensureCreatedAt() => $_ensure(6);

  @$pb.TagNumber(8)
  $28.Timestamp get lastVerifiedAt => $_getN(7);
  @$pb.TagNumber(8)
  set lastVerifiedAt($28.Timestamp v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasLastVerifiedAt() => $_has(7);
  @$pb.TagNumber(8)
  void clearLastVerifiedAt() => clearField(8);
  @$pb.TagNumber(8)
  $28.Timestamp ensureLastVerifiedAt() => $_ensure(7);
}

class UserRegisterFaceRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UserRegisterFaceRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'faceImage', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  UserRegisterFaceRequest._() : super();
  factory UserRegisterFaceRequest({
    $core.List<$core.int>? faceImage,
  }) {
    final _result = create();
    if (faceImage != null) {
      _result.faceImage = faceImage;
    }
    return _result;
  }
  factory UserRegisterFaceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UserRegisterFaceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UserRegisterFaceRequest clone() => UserRegisterFaceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UserRegisterFaceRequest copyWith(void Function(UserRegisterFaceRequest) updates) => super.copyWith((message) => updates(message as UserRegisterFaceRequest)) as UserRegisterFaceRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UserRegisterFaceResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOM<FacialData>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'facialData', subBuilder: FacialData.create)
    ..hasRequiredFields = false
  ;

  UserRegisterFaceResponse._() : super();
  factory UserRegisterFaceResponse({
    $core.bool? success,
    $core.String? message,
    FacialData? facialData,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (facialData != null) {
      _result.facialData = facialData;
    }
    return _result;
  }
  factory UserRegisterFaceResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UserRegisterFaceResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UserRegisterFaceResponse clone() => UserRegisterFaceResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UserRegisterFaceResponse copyWith(void Function(UserRegisterFaceResponse) updates) => super.copyWith((message) => updates(message as UserRegisterFaceResponse)) as UserRegisterFaceResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UserVerifyFaceRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'faceImage', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  UserVerifyFaceRequest._() : super();
  factory UserVerifyFaceRequest({
    $core.List<$core.int>? faceImage,
  }) {
    final _result = create();
    if (faceImage != null) {
      _result.faceImage = faceImage;
    }
    return _result;
  }
  factory UserVerifyFaceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UserVerifyFaceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UserVerifyFaceRequest clone() => UserVerifyFaceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UserVerifyFaceRequest copyWith(void Function(UserVerifyFaceRequest) updates) => super.copyWith((message) => updates(message as UserVerifyFaceRequest)) as UserVerifyFaceRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UserVerifyFaceResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isMatch')
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'confidence', $pb.PbFieldType.OF)
    ..hasRequiredFields = false
  ;

  UserVerifyFaceResponse._() : super();
  factory UserVerifyFaceResponse({
    $core.bool? success,
    $core.String? message,
    $core.bool? isMatch,
    $core.double? confidence,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (isMatch != null) {
      _result.isMatch = isMatch;
    }
    if (confidence != null) {
      _result.confidence = confidence;
    }
    return _result;
  }
  factory UserVerifyFaceResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UserVerifyFaceResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UserVerifyFaceResponse clone() => UserVerifyFaceResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UserVerifyFaceResponse copyWith(void Function(UserVerifyFaceResponse) updates) => super.copyWith((message) => updates(message as UserVerifyFaceResponse)) as UserVerifyFaceResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetFacialDataRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetFacialDataRequest._() : super();
  factory GetFacialDataRequest() => create();
  factory GetFacialDataRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetFacialDataRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetFacialDataRequest clone() => GetFacialDataRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetFacialDataRequest copyWith(void Function(GetFacialDataRequest) updates) => super.copyWith((message) => updates(message as GetFacialDataRequest)) as GetFacialDataRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetFacialDataResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOM<FacialData>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'facialData', subBuilder: FacialData.create)
    ..hasRequiredFields = false
  ;

  GetFacialDataResponse._() : super();
  factory GetFacialDataResponse({
    $core.bool? success,
    $core.String? message,
    FacialData? facialData,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (facialData != null) {
      _result.facialData = facialData;
    }
    return _result;
  }
  factory GetFacialDataResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetFacialDataResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetFacialDataResponse clone() => GetFacialDataResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetFacialDataResponse copyWith(void Function(GetFacialDataResponse) updates) => super.copyWith((message) => updates(message as GetFacialDataResponse)) as GetFacialDataResponse; // ignore: deprecated_member_use
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

class SetPasscodeRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SetPasscodeRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'passcode')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'password')
    ..hasRequiredFields = false
  ;

  SetPasscodeRequest._() : super();
  factory SetPasscodeRequest({
    $core.String? passcode,
    $core.String? password,
  }) {
    final _result = create();
    if (passcode != null) {
      _result.passcode = passcode;
    }
    if (password != null) {
      _result.password = password;
    }
    return _result;
  }
  factory SetPasscodeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SetPasscodeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SetPasscodeRequest clone() => SetPasscodeRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SetPasscodeRequest copyWith(void Function(SetPasscodeRequest) updates) => super.copyWith((message) => updates(message as SetPasscodeRequest)) as SetPasscodeRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SetPasscodeResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  SetPasscodeResponse._() : super();
  factory SetPasscodeResponse({
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
  factory SetPasscodeResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SetPasscodeResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SetPasscodeResponse clone() => SetPasscodeResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SetPasscodeResponse copyWith(void Function(SetPasscodeResponse) updates) => super.copyWith((message) => updates(message as SetPasscodeResponse)) as SetPasscodeResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'VerifyPasscodeRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'passcode')
    ..hasRequiredFields = false
  ;

  VerifyPasscodeRequest._() : super();
  factory VerifyPasscodeRequest({
    $core.String? passcode,
  }) {
    final _result = create();
    if (passcode != null) {
      _result.passcode = passcode;
    }
    return _result;
  }
  factory VerifyPasscodeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VerifyPasscodeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VerifyPasscodeRequest clone() => VerifyPasscodeRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VerifyPasscodeRequest copyWith(void Function(VerifyPasscodeRequest) updates) => super.copyWith((message) => updates(message as VerifyPasscodeRequest)) as VerifyPasscodeRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'VerifyPasscodeResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isValid')
    ..hasRequiredFields = false
  ;

  VerifyPasscodeResponse._() : super();
  factory VerifyPasscodeResponse({
    $core.bool? success,
    $core.String? message,
    $core.bool? isValid,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (isValid != null) {
      _result.isValid = isValid;
    }
    return _result;
  }
  factory VerifyPasscodeResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VerifyPasscodeResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VerifyPasscodeResponse clone() => VerifyPasscodeResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VerifyPasscodeResponse copyWith(void Function(VerifyPasscodeResponse) updates) => super.copyWith((message) => updates(message as VerifyPasscodeResponse)) as VerifyPasscodeResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RemovePasscodeRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'password')
    ..hasRequiredFields = false
  ;

  RemovePasscodeRequest._() : super();
  factory RemovePasscodeRequest({
    $core.String? password,
  }) {
    final _result = create();
    if (password != null) {
      _result.password = password;
    }
    return _result;
  }
  factory RemovePasscodeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RemovePasscodeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RemovePasscodeRequest clone() => RemovePasscodeRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RemovePasscodeRequest copyWith(void Function(RemovePasscodeRequest) updates) => super.copyWith((message) => updates(message as RemovePasscodeRequest)) as RemovePasscodeRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RemovePasscodeResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  RemovePasscodeResponse._() : super();
  factory RemovePasscodeResponse({
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
  factory RemovePasscodeResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RemovePasscodeResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RemovePasscodeResponse clone() => RemovePasscodeResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RemovePasscodeResponse copyWith(void Function(RemovePasscodeResponse) updates) => super.copyWith((message) => updates(message as RemovePasscodeResponse)) as RemovePasscodeResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CheckPasscodeExistsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  CheckPasscodeExistsRequest._() : super();
  factory CheckPasscodeExistsRequest() => create();
  factory CheckPasscodeExistsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CheckPasscodeExistsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CheckPasscodeExistsRequest clone() => CheckPasscodeExistsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CheckPasscodeExistsRequest copyWith(void Function(CheckPasscodeExistsRequest) updates) => super.copyWith((message) => updates(message as CheckPasscodeExistsRequest)) as CheckPasscodeExistsRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CheckPasscodeExistsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hasPasscode')
    ..hasRequiredFields = false
  ;

  CheckPasscodeExistsResponse._() : super();
  factory CheckPasscodeExistsResponse({
    $core.bool? success,
    $core.bool? hasPasscode,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (hasPasscode != null) {
      _result.hasPasscode = hasPasscode;
    }
    return _result;
  }
  factory CheckPasscodeExistsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CheckPasscodeExistsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CheckPasscodeExistsResponse clone() => CheckPasscodeExistsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CheckPasscodeExistsResponse copyWith(void Function(CheckPasscodeExistsResponse) updates) => super.copyWith((message) => updates(message as CheckPasscodeExistsResponse)) as CheckPasscodeExistsResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DevicePermission', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..e<PermissionType>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'permissionType', $pb.PbFieldType.OE, defaultOrMaker: PermissionType.PERMISSION_TYPE_CAMERA, valueOf: PermissionType.valueOf, enumValues: PermissionType.values)
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isGranted')
    ..aOM<$28.Timestamp>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'grantedAt', subBuilder: $28.Timestamp.create)
    ..hasRequiredFields = false
  ;

  DevicePermission._() : super();
  factory DevicePermission({
    PermissionType? permissionType,
    $core.bool? isGranted,
    $28.Timestamp? grantedAt,
  }) {
    final _result = create();
    if (permissionType != null) {
      _result.permissionType = permissionType;
    }
    if (isGranted != null) {
      _result.isGranted = isGranted;
    }
    if (grantedAt != null) {
      _result.grantedAt = grantedAt;
    }
    return _result;
  }
  factory DevicePermission.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DevicePermission.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DevicePermission clone() => DevicePermission()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DevicePermission copyWith(void Function(DevicePermission) updates) => super.copyWith((message) => updates(message as DevicePermission)) as DevicePermission; // ignore: deprecated_member_use
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
  $28.Timestamp get grantedAt => $_getN(2);
  @$pb.TagNumber(3)
  set grantedAt($28.Timestamp v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasGrantedAt() => $_has(2);
  @$pb.TagNumber(3)
  void clearGrantedAt() => clearField(3);
  @$pb.TagNumber(3)
  $28.Timestamp ensureGrantedAt() => $_ensure(2);
}

class UpdateDevicePermissionsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateDevicePermissionsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<DevicePermission>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'permissions', $pb.PbFieldType.PM, subBuilder: DevicePermission.create)
    ..hasRequiredFields = false
  ;

  UpdateDevicePermissionsRequest._() : super();
  factory UpdateDevicePermissionsRequest({
    $core.Iterable<DevicePermission>? permissions,
  }) {
    final _result = create();
    if (permissions != null) {
      _result.permissions.addAll(permissions);
    }
    return _result;
  }
  factory UpdateDevicePermissionsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateDevicePermissionsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateDevicePermissionsRequest clone() => UpdateDevicePermissionsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateDevicePermissionsRequest copyWith(void Function(UpdateDevicePermissionsRequest) updates) => super.copyWith((message) => updates(message as UpdateDevicePermissionsRequest)) as UpdateDevicePermissionsRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateDevicePermissionsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  UpdateDevicePermissionsResponse._() : super();
  factory UpdateDevicePermissionsResponse({
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
  factory UpdateDevicePermissionsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateDevicePermissionsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateDevicePermissionsResponse clone() => UpdateDevicePermissionsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateDevicePermissionsResponse copyWith(void Function(UpdateDevicePermissionsResponse) updates) => super.copyWith((message) => updates(message as UpdateDevicePermissionsResponse)) as UpdateDevicePermissionsResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetDevicePermissionsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetDevicePermissionsRequest._() : super();
  factory GetDevicePermissionsRequest() => create();
  factory GetDevicePermissionsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetDevicePermissionsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetDevicePermissionsRequest clone() => GetDevicePermissionsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetDevicePermissionsRequest copyWith(void Function(GetDevicePermissionsRequest) updates) => super.copyWith((message) => updates(message as GetDevicePermissionsRequest)) as GetDevicePermissionsRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetDevicePermissionsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..pc<DevicePermission>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'permissions', $pb.PbFieldType.PM, subBuilder: DevicePermission.create)
    ..hasRequiredFields = false
  ;

  GetDevicePermissionsResponse._() : super();
  factory GetDevicePermissionsResponse({
    $core.bool? success,
    $core.String? message,
    $core.Iterable<DevicePermission>? permissions,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (permissions != null) {
      _result.permissions.addAll(permissions);
    }
    return _result;
  }
  factory GetDevicePermissionsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetDevicePermissionsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetDevicePermissionsResponse clone() => GetDevicePermissionsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetDevicePermissionsResponse copyWith(void Function(GetDevicePermissionsResponse) updates) => super.copyWith((message) => updates(message as GetDevicePermissionsResponse)) as GetDevicePermissionsResponse; // ignore: deprecated_member_use
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

