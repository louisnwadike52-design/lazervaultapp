///
//  Generated code. Do not modify.
//  source: common.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $28;

export 'common.pbenum.dart';

class User extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'User', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'firstName')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lastName')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'email')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'phoneNumber')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'username')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'role')
    ..aOB(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'verified')
    ..aOB(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isEmailVerified')
    ..aOM<$28.Timestamp>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $28.Timestamp.create)
    ..aOM<$28.Timestamp>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedAt', subBuilder: $28.Timestamp.create)
    ..aOS(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'language')
    ..aOS(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOS(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'country')
    ..aOS(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'profilePicture')
    ..hasRequiredFields = false
  ;

  User._() : super();
  factory User({
    $fixnum.Int64? id,
    $core.String? firstName,
    $core.String? lastName,
    $core.String? email,
    $core.String? phoneNumber,
    $core.String? username,
    $core.String? role,
    $core.bool? verified,
    $core.bool? isEmailVerified,
    $28.Timestamp? createdAt,
    $28.Timestamp? updatedAt,
    $core.String? language,
    $core.String? currency,
    $core.String? country,
    $core.String? profilePicture,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (firstName != null) {
      _result.firstName = firstName;
    }
    if (lastName != null) {
      _result.lastName = lastName;
    }
    if (email != null) {
      _result.email = email;
    }
    if (phoneNumber != null) {
      _result.phoneNumber = phoneNumber;
    }
    if (username != null) {
      _result.username = username;
    }
    if (role != null) {
      _result.role = role;
    }
    if (verified != null) {
      _result.verified = verified;
    }
    if (isEmailVerified != null) {
      _result.isEmailVerified = isEmailVerified;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      _result.updatedAt = updatedAt;
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
  $fixnum.Int64 get id => $_getI64(0);
  @$pb.TagNumber(1)
  set id($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

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
  $core.String get email => $_getSZ(3);
  @$pb.TagNumber(4)
  set email($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasEmail() => $_has(3);
  @$pb.TagNumber(4)
  void clearEmail() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get phoneNumber => $_getSZ(4);
  @$pb.TagNumber(5)
  set phoneNumber($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasPhoneNumber() => $_has(4);
  @$pb.TagNumber(5)
  void clearPhoneNumber() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get username => $_getSZ(5);
  @$pb.TagNumber(6)
  set username($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasUsername() => $_has(5);
  @$pb.TagNumber(6)
  void clearUsername() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get role => $_getSZ(6);
  @$pb.TagNumber(7)
  set role($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasRole() => $_has(6);
  @$pb.TagNumber(7)
  void clearRole() => clearField(7);

  @$pb.TagNumber(8)
  $core.bool get verified => $_getBF(7);
  @$pb.TagNumber(8)
  set verified($core.bool v) { $_setBool(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasVerified() => $_has(7);
  @$pb.TagNumber(8)
  void clearVerified() => clearField(8);

  @$pb.TagNumber(9)
  $core.bool get isEmailVerified => $_getBF(8);
  @$pb.TagNumber(9)
  set isEmailVerified($core.bool v) { $_setBool(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasIsEmailVerified() => $_has(8);
  @$pb.TagNumber(9)
  void clearIsEmailVerified() => clearField(9);

  @$pb.TagNumber(10)
  $28.Timestamp get createdAt => $_getN(9);
  @$pb.TagNumber(10)
  set createdAt($28.Timestamp v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasCreatedAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearCreatedAt() => clearField(10);
  @$pb.TagNumber(10)
  $28.Timestamp ensureCreatedAt() => $_ensure(9);

  @$pb.TagNumber(11)
  $28.Timestamp get updatedAt => $_getN(10);
  @$pb.TagNumber(11)
  set updatedAt($28.Timestamp v) { setField(11, v); }
  @$pb.TagNumber(11)
  $core.bool hasUpdatedAt() => $_has(10);
  @$pb.TagNumber(11)
  void clearUpdatedAt() => clearField(11);
  @$pb.TagNumber(11)
  $28.Timestamp ensureUpdatedAt() => $_ensure(10);

  @$pb.TagNumber(12)
  $core.String get language => $_getSZ(11);
  @$pb.TagNumber(12)
  set language($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasLanguage() => $_has(11);
  @$pb.TagNumber(12)
  void clearLanguage() => clearField(12);

  @$pb.TagNumber(13)
  $core.String get currency => $_getSZ(12);
  @$pb.TagNumber(13)
  set currency($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasCurrency() => $_has(12);
  @$pb.TagNumber(13)
  void clearCurrency() => clearField(13);

  @$pb.TagNumber(14)
  $core.String get country => $_getSZ(13);
  @$pb.TagNumber(14)
  set country($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasCountry() => $_has(13);
  @$pb.TagNumber(14)
  void clearCountry() => clearField(14);

  @$pb.TagNumber(15)
  $core.String get profilePicture => $_getSZ(14);
  @$pb.TagNumber(15)
  set profilePicture($core.String v) { $_setString(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasProfilePicture() => $_has(14);
  @$pb.TagNumber(15)
  void clearProfilePicture() => clearField(15);
}

class Data extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Data', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<User>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'user', subBuilder: User.create)
    ..aOM<Session>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'session', subBuilder: Session.create)
    ..hasRequiredFields = false
  ;

  Data._() : super();
  factory Data({
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
  factory Data.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Data.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Data clone() => Data()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Data copyWith(void Function(Data) updates) => super.copyWith((message) => updates(message as Data)) as Data; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Data create() => Data._();
  Data createEmptyInstance() => create();
  static $pb.PbList<Data> createRepeated() => $pb.PbList<Data>();
  @$core.pragma('dart2js:noInline')
  static Data getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Data>(create);
  static Data? _defaultInstance;

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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Session', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..a<$fixnum.Int64>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accessToken')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'refreshToken')
    ..aOM<$28.Timestamp>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accessTokenExpiresAt', subBuilder: $28.Timestamp.create)
    ..aOM<$28.Timestamp>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'refreshTokenExpiresAt', subBuilder: $28.Timestamp.create)
    ..hasRequiredFields = false
  ;

  Session._() : super();
  factory Session({
    $core.String? id,
    $fixnum.Int64? userId,
    $core.String? accessToken,
    $core.String? refreshToken,
    $28.Timestamp? accessTokenExpiresAt,
    $28.Timestamp? refreshTokenExpiresAt,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (accessToken != null) {
      _result.accessToken = accessToken;
    }
    if (refreshToken != null) {
      _result.refreshToken = refreshToken;
    }
    if (accessTokenExpiresAt != null) {
      _result.accessTokenExpiresAt = accessTokenExpiresAt;
    }
    if (refreshTokenExpiresAt != null) {
      _result.refreshTokenExpiresAt = refreshTokenExpiresAt;
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
  $28.Timestamp get accessTokenExpiresAt => $_getN(4);
  @$pb.TagNumber(5)
  set accessTokenExpiresAt($28.Timestamp v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasAccessTokenExpiresAt() => $_has(4);
  @$pb.TagNumber(5)
  void clearAccessTokenExpiresAt() => clearField(5);
  @$pb.TagNumber(5)
  $28.Timestamp ensureAccessTokenExpiresAt() => $_ensure(4);

  @$pb.TagNumber(6)
  $28.Timestamp get refreshTokenExpiresAt => $_getN(5);
  @$pb.TagNumber(6)
  set refreshTokenExpiresAt($28.Timestamp v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasRefreshTokenExpiresAt() => $_has(5);
  @$pb.TagNumber(6)
  void clearRefreshTokenExpiresAt() => clearField(6);
  @$pb.TagNumber(6)
  $28.Timestamp ensureRefreshTokenExpiresAt() => $_ensure(5);
}

class PaginationInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PaginationInfo', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currentPage', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalPages', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalItems', $pb.PbFieldType.O3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'itemsPerPage', $pb.PbFieldType.O3)
    ..aOB(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hasNext')
    ..aOB(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hasPrev')
    ..hasRequiredFields = false
  ;

  PaginationInfo._() : super();
  factory PaginationInfo({
    $core.int? currentPage,
    $core.int? totalPages,
    $core.int? totalItems,
    $core.int? itemsPerPage,
    $core.bool? hasNext,
    $core.bool? hasPrev,
  }) {
    final _result = create();
    if (currentPage != null) {
      _result.currentPage = currentPage;
    }
    if (totalPages != null) {
      _result.totalPages = totalPages;
    }
    if (totalItems != null) {
      _result.totalItems = totalItems;
    }
    if (itemsPerPage != null) {
      _result.itemsPerPage = itemsPerPage;
    }
    if (hasNext != null) {
      _result.hasNext = hasNext;
    }
    if (hasPrev != null) {
      _result.hasPrev = hasPrev;
    }
    return _result;
  }
  factory PaginationInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PaginationInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PaginationInfo clone() => PaginationInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PaginationInfo copyWith(void Function(PaginationInfo) updates) => super.copyWith((message) => updates(message as PaginationInfo)) as PaginationInfo; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PaginationInfo create() => PaginationInfo._();
  PaginationInfo createEmptyInstance() => create();
  static $pb.PbList<PaginationInfo> createRepeated() => $pb.PbList<PaginationInfo>();
  @$core.pragma('dart2js:noInline')
  static PaginationInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PaginationInfo>(create);
  static PaginationInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get currentPage => $_getIZ(0);
  @$pb.TagNumber(1)
  set currentPage($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCurrentPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearCurrentPage() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get totalPages => $_getIZ(1);
  @$pb.TagNumber(2)
  set totalPages($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotalPages() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalPages() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get totalItems => $_getIZ(2);
  @$pb.TagNumber(3)
  set totalItems($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTotalItems() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalItems() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get itemsPerPage => $_getIZ(3);
  @$pb.TagNumber(4)
  set itemsPerPage($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasItemsPerPage() => $_has(3);
  @$pb.TagNumber(4)
  void clearItemsPerPage() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get hasNext => $_getBF(4);
  @$pb.TagNumber(5)
  set hasNext($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasHasNext() => $_has(4);
  @$pb.TagNumber(5)
  void clearHasNext() => clearField(5);

  @$pb.TagNumber(6)
  $core.bool get hasPrev => $_getBF(5);
  @$pb.TagNumber(6)
  set hasPrev($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasHasPrev() => $_has(5);
  @$pb.TagNumber(6)
  void clearHasPrev() => clearField(6);
}

