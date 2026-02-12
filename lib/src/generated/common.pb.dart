//
//  Generated code. Do not modify.
//  source: common.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $0;

export 'common.pbenum.dart';

/// Base user type
class User extends $pb.GeneratedMessage {
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
    $0.Timestamp? createdAt,
    $0.Timestamp? updatedAt,
    $core.String? language,
    $core.String? currency,
    $core.String? country,
    $core.String? profilePicture,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (firstName != null) {
      $result.firstName = firstName;
    }
    if (lastName != null) {
      $result.lastName = lastName;
    }
    if (email != null) {
      $result.email = email;
    }
    if (phoneNumber != null) {
      $result.phoneNumber = phoneNumber;
    }
    if (username != null) {
      $result.username = username;
    }
    if (role != null) {
      $result.role = role;
    }
    if (verified != null) {
      $result.verified = verified;
    }
    if (isEmailVerified != null) {
      $result.isEmailVerified = isEmailVerified;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      $result.updatedAt = updatedAt;
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
  User._() : super();
  factory User.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory User.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'User', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(2, _omitFieldNames ? '' : 'firstName')
    ..aOS(3, _omitFieldNames ? '' : 'lastName')
    ..aOS(4, _omitFieldNames ? '' : 'email')
    ..aOS(5, _omitFieldNames ? '' : 'phoneNumber')
    ..aOS(6, _omitFieldNames ? '' : 'username')
    ..aOS(7, _omitFieldNames ? '' : 'role')
    ..aOB(8, _omitFieldNames ? '' : 'verified')
    ..aOB(9, _omitFieldNames ? '' : 'isEmailVerified')
    ..aOM<$0.Timestamp>(10, _omitFieldNames ? '' : 'createdAt', subBuilder: $0.Timestamp.create)
    ..aOM<$0.Timestamp>(11, _omitFieldNames ? '' : 'updatedAt', subBuilder: $0.Timestamp.create)
    ..aOS(12, _omitFieldNames ? '' : 'language')
    ..aOS(13, _omitFieldNames ? '' : 'currency')
    ..aOS(14, _omitFieldNames ? '' : 'country')
    ..aOS(15, _omitFieldNames ? '' : 'profilePicture')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  User clone() => User()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  User copyWith(void Function(User) updates) => super.copyWith((message) => updates(message as User)) as User;

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
  $0.Timestamp get createdAt => $_getN(9);
  @$pb.TagNumber(10)
  set createdAt($0.Timestamp v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasCreatedAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearCreatedAt() => clearField(10);
  @$pb.TagNumber(10)
  $0.Timestamp ensureCreatedAt() => $_ensure(9);

  @$pb.TagNumber(11)
  $0.Timestamp get updatedAt => $_getN(10);
  @$pb.TagNumber(11)
  set updatedAt($0.Timestamp v) { setField(11, v); }
  @$pb.TagNumber(11)
  $core.bool hasUpdatedAt() => $_has(10);
  @$pb.TagNumber(11)
  void clearUpdatedAt() => clearField(11);
  @$pb.TagNumber(11)
  $0.Timestamp ensureUpdatedAt() => $_ensure(10);

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
  factory Data({
    User? user,
    Session? session,
  }) {
    final $result = create();
    if (user != null) {
      $result.user = user;
    }
    if (session != null) {
      $result.session = session;
    }
    return $result;
  }
  Data._() : super();
  factory Data.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Data.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Data', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<User>(1, _omitFieldNames ? '' : 'user', subBuilder: User.create)
    ..aOM<Session>(2, _omitFieldNames ? '' : 'session', subBuilder: Session.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Data clone() => Data()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Data copyWith(void Function(Data) updates) => super.copyWith((message) => updates(message as Data)) as Data;

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
  factory Session({
    $core.String? id,
    $fixnum.Int64? userId,
    $core.String? accessToken,
    $core.String? refreshToken,
    $0.Timestamp? accessTokenExpiresAt,
    $0.Timestamp? refreshTokenExpiresAt,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (userId != null) {
      $result.userId = userId;
    }
    if (accessToken != null) {
      $result.accessToken = accessToken;
    }
    if (refreshToken != null) {
      $result.refreshToken = refreshToken;
    }
    if (accessTokenExpiresAt != null) {
      $result.accessTokenExpiresAt = accessTokenExpiresAt;
    }
    if (refreshTokenExpiresAt != null) {
      $result.refreshTokenExpiresAt = refreshTokenExpiresAt;
    }
    return $result;
  }
  Session._() : super();
  factory Session.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Session.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Session', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'userId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(3, _omitFieldNames ? '' : 'accessToken')
    ..aOS(4, _omitFieldNames ? '' : 'refreshToken')
    ..aOM<$0.Timestamp>(5, _omitFieldNames ? '' : 'accessTokenExpiresAt', subBuilder: $0.Timestamp.create)
    ..aOM<$0.Timestamp>(6, _omitFieldNames ? '' : 'refreshTokenExpiresAt', subBuilder: $0.Timestamp.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Session clone() => Session()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Session copyWith(void Function(Session) updates) => super.copyWith((message) => updates(message as Session)) as Session;

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
  $0.Timestamp get accessTokenExpiresAt => $_getN(4);
  @$pb.TagNumber(5)
  set accessTokenExpiresAt($0.Timestamp v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasAccessTokenExpiresAt() => $_has(4);
  @$pb.TagNumber(5)
  void clearAccessTokenExpiresAt() => clearField(5);
  @$pb.TagNumber(5)
  $0.Timestamp ensureAccessTokenExpiresAt() => $_ensure(4);

  @$pb.TagNumber(6)
  $0.Timestamp get refreshTokenExpiresAt => $_getN(5);
  @$pb.TagNumber(6)
  set refreshTokenExpiresAt($0.Timestamp v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasRefreshTokenExpiresAt() => $_has(5);
  @$pb.TagNumber(6)
  void clearRefreshTokenExpiresAt() => clearField(6);
  @$pb.TagNumber(6)
  $0.Timestamp ensureRefreshTokenExpiresAt() => $_ensure(5);
}

/// Pagination Info - Common pagination structure
class PaginationInfo extends $pb.GeneratedMessage {
  factory PaginationInfo({
    $core.int? currentPage,
    $core.int? totalPages,
    $core.int? totalItems,
    $core.int? itemsPerPage,
    $core.bool? hasNext,
    $core.bool? hasPrev,
  }) {
    final $result = create();
    if (currentPage != null) {
      $result.currentPage = currentPage;
    }
    if (totalPages != null) {
      $result.totalPages = totalPages;
    }
    if (totalItems != null) {
      $result.totalItems = totalItems;
    }
    if (itemsPerPage != null) {
      $result.itemsPerPage = itemsPerPage;
    }
    if (hasNext != null) {
      $result.hasNext = hasNext;
    }
    if (hasPrev != null) {
      $result.hasPrev = hasPrev;
    }
    return $result;
  }
  PaginationInfo._() : super();
  factory PaginationInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PaginationInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PaginationInfo', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'currentPage', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'totalPages', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'totalItems', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'itemsPerPage', $pb.PbFieldType.O3)
    ..aOB(5, _omitFieldNames ? '' : 'hasNext')
    ..aOB(6, _omitFieldNames ? '' : 'hasPrev')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PaginationInfo clone() => PaginationInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PaginationInfo copyWith(void Function(PaginationInfo) updates) => super.copyWith((message) => updates(message as PaginationInfo)) as PaginationInfo;

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


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
