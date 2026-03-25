// This is a generated file - do not edit.
//
// Generated from contact_sync.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'contact_sync.pbenum.dart';
import 'google/protobuf/timestamp.pb.dart' as $1;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'contact_sync.pbenum.dart';

/// SyncedContact represents a contact synced to the backend
class SyncedContact extends $pb.GeneratedMessage {
  factory SyncedContact({
    $core.String? id,
    $core.String? userId,
    $core.String? name,
    $core.Iterable<$core.String>? phoneNumbers,
    $core.Iterable<$core.String>? emails,
    $core.String? photoUrl,
    $1.Timestamp? createdAt,
    $1.Timestamp? updatedAt,
    $core.String? deviceContactId,
    $core.bool? isLazervaultUser,
    $core.String? lazervaultUserId,
    $core.String? lazervaultUsername,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (userId != null) result.userId = userId;
    if (name != null) result.name = name;
    if (phoneNumbers != null) result.phoneNumbers.addAll(phoneNumbers);
    if (emails != null) result.emails.addAll(emails);
    if (photoUrl != null) result.photoUrl = photoUrl;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    if (deviceContactId != null) result.deviceContactId = deviceContactId;
    if (isLazervaultUser != null) result.isLazervaultUser = isLazervaultUser;
    if (lazervaultUserId != null) result.lazervaultUserId = lazervaultUserId;
    if (lazervaultUsername != null)
      result.lazervaultUsername = lazervaultUsername;
    return result;
  }

  SyncedContact._();

  factory SyncedContact.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SyncedContact.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SyncedContact',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'lazervault.contact'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'name')
    ..pPS(4, _omitFieldNames ? '' : 'phoneNumbers')
    ..pPS(5, _omitFieldNames ? '' : 'emails')
    ..aOS(6, _omitFieldNames ? '' : 'photoUrl')
    ..aOM<$1.Timestamp>(7, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(8, _omitFieldNames ? '' : 'updatedAt',
        subBuilder: $1.Timestamp.create)
    ..aOS(9, _omitFieldNames ? '' : 'deviceContactId')
    ..aOB(10, _omitFieldNames ? '' : 'isLazervaultUser')
    ..aOS(11, _omitFieldNames ? '' : 'lazervaultUserId')
    ..aOS(12, _omitFieldNames ? '' : 'lazervaultUsername')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SyncedContact clone() => SyncedContact()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SyncedContact copyWith(void Function(SyncedContact) updates) =>
      super.copyWith((message) => updates(message as SyncedContact))
          as SyncedContact;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SyncedContact create() => SyncedContact._();
  @$core.override
  SyncedContact createEmptyInstance() => create();
  static $pb.PbList<SyncedContact> createRepeated() =>
      $pb.PbList<SyncedContact>();
  @$core.pragma('dart2js:noInline')
  static SyncedContact getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SyncedContact>(create);
  static SyncedContact? _defaultInstance;

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
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => $_clearField(3);

  @$pb.TagNumber(4)
  $pb.PbList<$core.String> get phoneNumbers => $_getList(3);

  @$pb.TagNumber(5)
  $pb.PbList<$core.String> get emails => $_getList(4);

  @$pb.TagNumber(6)
  $core.String get photoUrl => $_getSZ(5);
  @$pb.TagNumber(6)
  set photoUrl($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasPhotoUrl() => $_has(5);
  @$pb.TagNumber(6)
  void clearPhotoUrl() => $_clearField(6);

  @$pb.TagNumber(7)
  $1.Timestamp get createdAt => $_getN(6);
  @$pb.TagNumber(7)
  set createdAt($1.Timestamp value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasCreatedAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearCreatedAt() => $_clearField(7);
  @$pb.TagNumber(7)
  $1.Timestamp ensureCreatedAt() => $_ensure(6);

  @$pb.TagNumber(8)
  $1.Timestamp get updatedAt => $_getN(7);
  @$pb.TagNumber(8)
  set updatedAt($1.Timestamp value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasUpdatedAt() => $_has(7);
  @$pb.TagNumber(8)
  void clearUpdatedAt() => $_clearField(8);
  @$pb.TagNumber(8)
  $1.Timestamp ensureUpdatedAt() => $_ensure(7);

  @$pb.TagNumber(9)
  $core.String get deviceContactId => $_getSZ(8);
  @$pb.TagNumber(9)
  set deviceContactId($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasDeviceContactId() => $_has(8);
  @$pb.TagNumber(9)
  void clearDeviceContactId() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.bool get isLazervaultUser => $_getBF(9);
  @$pb.TagNumber(10)
  set isLazervaultUser($core.bool value) => $_setBool(9, value);
  @$pb.TagNumber(10)
  $core.bool hasIsLazervaultUser() => $_has(9);
  @$pb.TagNumber(10)
  void clearIsLazervaultUser() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get lazervaultUserId => $_getSZ(10);
  @$pb.TagNumber(11)
  set lazervaultUserId($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasLazervaultUserId() => $_has(10);
  @$pb.TagNumber(11)
  void clearLazervaultUserId() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get lazervaultUsername => $_getSZ(11);
  @$pb.TagNumber(12)
  set lazervaultUsername($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasLazervaultUsername() => $_has(11);
  @$pb.TagNumber(12)
  void clearLazervaultUsername() => $_clearField(12);
}

/// Request to sync contacts
class SyncContactsRequest extends $pb.GeneratedMessage {
  factory SyncContactsRequest({
    $core.Iterable<ContactToSync>? contacts,
    $core.bool? replaceAll,
  }) {
    final result = create();
    if (contacts != null) result.contacts.addAll(contacts);
    if (replaceAll != null) result.replaceAll = replaceAll;
    return result;
  }

  SyncContactsRequest._();

  factory SyncContactsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SyncContactsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SyncContactsRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'lazervault.contact'),
      createEmptyInstance: create)
    ..pc<ContactToSync>(
        1, _omitFieldNames ? '' : 'contacts', $pb.PbFieldType.PM,
        subBuilder: ContactToSync.create)
    ..aOB(2, _omitFieldNames ? '' : 'replaceAll')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SyncContactsRequest clone() => SyncContactsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SyncContactsRequest copyWith(void Function(SyncContactsRequest) updates) =>
      super.copyWith((message) => updates(message as SyncContactsRequest))
          as SyncContactsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SyncContactsRequest create() => SyncContactsRequest._();
  @$core.override
  SyncContactsRequest createEmptyInstance() => create();
  static $pb.PbList<SyncContactsRequest> createRepeated() =>
      $pb.PbList<SyncContactsRequest>();
  @$core.pragma('dart2js:noInline')
  static SyncContactsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SyncContactsRequest>(create);
  static SyncContactsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<ContactToSync> get contacts => $_getList(0);

  @$pb.TagNumber(2)
  $core.bool get replaceAll => $_getBF(1);
  @$pb.TagNumber(2)
  set replaceAll($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasReplaceAll() => $_has(1);
  @$pb.TagNumber(2)
  void clearReplaceAll() => $_clearField(2);
}

/// Individual contact to sync
class ContactToSync extends $pb.GeneratedMessage {
  factory ContactToSync({
    $core.String? deviceContactId,
    $core.String? name,
    $core.Iterable<$core.String>? phoneNumbers,
    $core.Iterable<$core.String>? emails,
  }) {
    final result = create();
    if (deviceContactId != null) result.deviceContactId = deviceContactId;
    if (name != null) result.name = name;
    if (phoneNumbers != null) result.phoneNumbers.addAll(phoneNumbers);
    if (emails != null) result.emails.addAll(emails);
    return result;
  }

  ContactToSync._();

  factory ContactToSync.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ContactToSync.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ContactToSync',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'lazervault.contact'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'deviceContactId')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..pPS(3, _omitFieldNames ? '' : 'phoneNumbers')
    ..pPS(4, _omitFieldNames ? '' : 'emails')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ContactToSync clone() => ContactToSync()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ContactToSync copyWith(void Function(ContactToSync) updates) =>
      super.copyWith((message) => updates(message as ContactToSync))
          as ContactToSync;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ContactToSync create() => ContactToSync._();
  @$core.override
  ContactToSync createEmptyInstance() => create();
  static $pb.PbList<ContactToSync> createRepeated() =>
      $pb.PbList<ContactToSync>();
  @$core.pragma('dart2js:noInline')
  static ContactToSync getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ContactToSync>(create);
  static ContactToSync? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get deviceContactId => $_getSZ(0);
  @$pb.TagNumber(1)
  set deviceContactId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDeviceContactId() => $_has(0);
  @$pb.TagNumber(1)
  void clearDeviceContactId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $pb.PbList<$core.String> get phoneNumbers => $_getList(2);

  @$pb.TagNumber(4)
  $pb.PbList<$core.String> get emails => $_getList(3);
}

/// Response to sync contacts
class SyncContactsResponse extends $pb.GeneratedMessage {
  factory SyncContactsResponse({
    $core.Iterable<SyncedContact>? syncedContacts,
    $core.int? totalSynced,
    $core.int? totalMatchedUsers,
    $core.Iterable<LazerVaultUserMatch>? matchedUsers,
  }) {
    final result = create();
    if (syncedContacts != null) result.syncedContacts.addAll(syncedContacts);
    if (totalSynced != null) result.totalSynced = totalSynced;
    if (totalMatchedUsers != null) result.totalMatchedUsers = totalMatchedUsers;
    if (matchedUsers != null) result.matchedUsers.addAll(matchedUsers);
    return result;
  }

  SyncContactsResponse._();

  factory SyncContactsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SyncContactsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SyncContactsResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'lazervault.contact'),
      createEmptyInstance: create)
    ..pc<SyncedContact>(
        1, _omitFieldNames ? '' : 'syncedContacts', $pb.PbFieldType.PM,
        subBuilder: SyncedContact.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'totalSynced', $pb.PbFieldType.O3)
    ..a<$core.int>(
        3, _omitFieldNames ? '' : 'totalMatchedUsers', $pb.PbFieldType.O3)
    ..pc<LazerVaultUserMatch>(
        4, _omitFieldNames ? '' : 'matchedUsers', $pb.PbFieldType.PM,
        subBuilder: LazerVaultUserMatch.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SyncContactsResponse clone() =>
      SyncContactsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SyncContactsResponse copyWith(void Function(SyncContactsResponse) updates) =>
      super.copyWith((message) => updates(message as SyncContactsResponse))
          as SyncContactsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SyncContactsResponse create() => SyncContactsResponse._();
  @$core.override
  SyncContactsResponse createEmptyInstance() => create();
  static $pb.PbList<SyncContactsResponse> createRepeated() =>
      $pb.PbList<SyncContactsResponse>();
  @$core.pragma('dart2js:noInline')
  static SyncContactsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SyncContactsResponse>(create);
  static SyncContactsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<SyncedContact> get syncedContacts => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get totalSynced => $_getIZ(1);
  @$pb.TagNumber(2)
  set totalSynced($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotalSynced() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalSynced() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get totalMatchedUsers => $_getIZ(2);
  @$pb.TagNumber(3)
  set totalMatchedUsers($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTotalMatchedUsers() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalMatchedUsers() => $_clearField(3);

  @$pb.TagNumber(4)
  $pb.PbList<LazerVaultUserMatch> get matchedUsers => $_getList(3);
}

/// Matched LazerVault user from contacts
class LazerVaultUserMatch extends $pb.GeneratedMessage {
  factory LazerVaultUserMatch({
    $core.String? contactId,
    $core.String? userId,
    $core.String? username,
    $core.String? name,
    $core.String? profilePhotoUrl,
    $core.bool? isVerified,
    $core.String? matchedBy,
  }) {
    final result = create();
    if (contactId != null) result.contactId = contactId;
    if (userId != null) result.userId = userId;
    if (username != null) result.username = username;
    if (name != null) result.name = name;
    if (profilePhotoUrl != null) result.profilePhotoUrl = profilePhotoUrl;
    if (isVerified != null) result.isVerified = isVerified;
    if (matchedBy != null) result.matchedBy = matchedBy;
    return result;
  }

  LazerVaultUserMatch._();

  factory LazerVaultUserMatch.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory LazerVaultUserMatch.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LazerVaultUserMatch',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'lazervault.contact'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'contactId')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'username')
    ..aOS(4, _omitFieldNames ? '' : 'name')
    ..aOS(5, _omitFieldNames ? '' : 'profilePhotoUrl')
    ..aOB(6, _omitFieldNames ? '' : 'isVerified')
    ..aOS(7, _omitFieldNames ? '' : 'matchedBy')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LazerVaultUserMatch clone() => LazerVaultUserMatch()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LazerVaultUserMatch copyWith(void Function(LazerVaultUserMatch) updates) =>
      super.copyWith((message) => updates(message as LazerVaultUserMatch))
          as LazerVaultUserMatch;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LazerVaultUserMatch create() => LazerVaultUserMatch._();
  @$core.override
  LazerVaultUserMatch createEmptyInstance() => create();
  static $pb.PbList<LazerVaultUserMatch> createRepeated() =>
      $pb.PbList<LazerVaultUserMatch>();
  @$core.pragma('dart2js:noInline')
  static LazerVaultUserMatch getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LazerVaultUserMatch>(create);
  static LazerVaultUserMatch? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get contactId => $_getSZ(0);
  @$pb.TagNumber(1)
  set contactId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasContactId() => $_has(0);
  @$pb.TagNumber(1)
  void clearContactId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get username => $_getSZ(2);
  @$pb.TagNumber(3)
  set username($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasUsername() => $_has(2);
  @$pb.TagNumber(3)
  void clearUsername() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get name => $_getSZ(3);
  @$pb.TagNumber(4)
  set name($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasName() => $_has(3);
  @$pb.TagNumber(4)
  void clearName() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get profilePhotoUrl => $_getSZ(4);
  @$pb.TagNumber(5)
  set profilePhotoUrl($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasProfilePhotoUrl() => $_has(4);
  @$pb.TagNumber(5)
  void clearProfilePhotoUrl() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.bool get isVerified => $_getBF(5);
  @$pb.TagNumber(6)
  set isVerified($core.bool value) => $_setBool(5, value);
  @$pb.TagNumber(6)
  $core.bool hasIsVerified() => $_has(5);
  @$pb.TagNumber(6)
  void clearIsVerified() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get matchedBy => $_getSZ(6);
  @$pb.TagNumber(7)
  set matchedBy($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasMatchedBy() => $_has(6);
  @$pb.TagNumber(7)
  void clearMatchedBy() => $_clearField(7);
}

/// Request to get synced contacts
class GetSyncedContactsRequest extends $pb.GeneratedMessage {
  factory GetSyncedContactsRequest({
    $core.int? page,
    $core.int? pageSize,
    $core.String? searchQuery,
    $core.bool? onlyLazervaultUsers,
  }) {
    final result = create();
    if (page != null) result.page = page;
    if (pageSize != null) result.pageSize = pageSize;
    if (searchQuery != null) result.searchQuery = searchQuery;
    if (onlyLazervaultUsers != null)
      result.onlyLazervaultUsers = onlyLazervaultUsers;
    return result;
  }

  GetSyncedContactsRequest._();

  factory GetSyncedContactsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetSyncedContactsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetSyncedContactsRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'lazervault.contact'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOS(3, _omitFieldNames ? '' : 'searchQuery')
    ..aOB(4, _omitFieldNames ? '' : 'onlyLazervaultUsers')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSyncedContactsRequest clone() =>
      GetSyncedContactsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSyncedContactsRequest copyWith(
          void Function(GetSyncedContactsRequest) updates) =>
      super.copyWith((message) => updates(message as GetSyncedContactsRequest))
          as GetSyncedContactsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSyncedContactsRequest create() => GetSyncedContactsRequest._();
  @$core.override
  GetSyncedContactsRequest createEmptyInstance() => create();
  static $pb.PbList<GetSyncedContactsRequest> createRepeated() =>
      $pb.PbList<GetSyncedContactsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetSyncedContactsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetSyncedContactsRequest>(create);
  static GetSyncedContactsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get page => $_getIZ(0);
  @$pb.TagNumber(1)
  set page($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearPage() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get pageSize => $_getIZ(1);
  @$pb.TagNumber(2)
  set pageSize($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPageSize() => $_has(1);
  @$pb.TagNumber(2)
  void clearPageSize() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get searchQuery => $_getSZ(2);
  @$pb.TagNumber(3)
  set searchQuery($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSearchQuery() => $_has(2);
  @$pb.TagNumber(3)
  void clearSearchQuery() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.bool get onlyLazervaultUsers => $_getBF(3);
  @$pb.TagNumber(4)
  set onlyLazervaultUsers($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasOnlyLazervaultUsers() => $_has(3);
  @$pb.TagNumber(4)
  void clearOnlyLazervaultUsers() => $_clearField(4);
}

/// Response with synced contacts
class GetSyncedContactsResponse extends $pb.GeneratedMessage {
  factory GetSyncedContactsResponse({
    $core.Iterable<SyncedContact>? contacts,
    $core.int? totalCount,
    $core.int? page,
    $core.int? pageSize,
  }) {
    final result = create();
    if (contacts != null) result.contacts.addAll(contacts);
    if (totalCount != null) result.totalCount = totalCount;
    if (page != null) result.page = page;
    if (pageSize != null) result.pageSize = pageSize;
    return result;
  }

  GetSyncedContactsResponse._();

  factory GetSyncedContactsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetSyncedContactsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetSyncedContactsResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'lazervault.contact'),
      createEmptyInstance: create)
    ..pc<SyncedContact>(
        1, _omitFieldNames ? '' : 'contacts', $pb.PbFieldType.PM,
        subBuilder: SyncedContact.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'totalCount', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSyncedContactsResponse clone() =>
      GetSyncedContactsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSyncedContactsResponse copyWith(
          void Function(GetSyncedContactsResponse) updates) =>
      super.copyWith((message) => updates(message as GetSyncedContactsResponse))
          as GetSyncedContactsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSyncedContactsResponse create() => GetSyncedContactsResponse._();
  @$core.override
  GetSyncedContactsResponse createEmptyInstance() => create();
  static $pb.PbList<GetSyncedContactsResponse> createRepeated() =>
      $pb.PbList<GetSyncedContactsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetSyncedContactsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetSyncedContactsResponse>(create);
  static GetSyncedContactsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<SyncedContact> get contacts => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get totalCount => $_getIZ(1);
  @$pb.TagNumber(2)
  set totalCount($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotalCount() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalCount() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get page => $_getIZ(2);
  @$pb.TagNumber(3)
  set page($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPage() => $_has(2);
  @$pb.TagNumber(3)
  void clearPage() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get pageSize => $_getIZ(3);
  @$pb.TagNumber(4)
  set pageSize($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPageSize() => $_has(3);
  @$pb.TagNumber(4)
  void clearPageSize() => $_clearField(4);
}

/// Request to delete synced contacts
class DeleteSyncedContactsRequest extends $pb.GeneratedMessage {
  factory DeleteSyncedContactsRequest({
    $core.Iterable<$core.String>? contactIds,
    $core.bool? deleteAll,
  }) {
    final result = create();
    if (contactIds != null) result.contactIds.addAll(contactIds);
    if (deleteAll != null) result.deleteAll = deleteAll;
    return result;
  }

  DeleteSyncedContactsRequest._();

  factory DeleteSyncedContactsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeleteSyncedContactsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteSyncedContactsRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'lazervault.contact'),
      createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'contactIds')
    ..aOB(2, _omitFieldNames ? '' : 'deleteAll')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteSyncedContactsRequest clone() =>
      DeleteSyncedContactsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteSyncedContactsRequest copyWith(
          void Function(DeleteSyncedContactsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as DeleteSyncedContactsRequest))
          as DeleteSyncedContactsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteSyncedContactsRequest create() =>
      DeleteSyncedContactsRequest._();
  @$core.override
  DeleteSyncedContactsRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteSyncedContactsRequest> createRepeated() =>
      $pb.PbList<DeleteSyncedContactsRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteSyncedContactsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteSyncedContactsRequest>(create);
  static DeleteSyncedContactsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$core.String> get contactIds => $_getList(0);

  @$pb.TagNumber(2)
  $core.bool get deleteAll => $_getBF(1);
  @$pb.TagNumber(2)
  set deleteAll($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDeleteAll() => $_has(1);
  @$pb.TagNumber(2)
  void clearDeleteAll() => $_clearField(2);
}

/// Response to delete synced contacts
class DeleteSyncedContactsResponse extends $pb.GeneratedMessage {
  factory DeleteSyncedContactsResponse({
    $core.int? deletedCount,
    $core.bool? success,
  }) {
    final result = create();
    if (deletedCount != null) result.deletedCount = deletedCount;
    if (success != null) result.success = success;
    return result;
  }

  DeleteSyncedContactsResponse._();

  factory DeleteSyncedContactsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeleteSyncedContactsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteSyncedContactsResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'lazervault.contact'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'deletedCount', $pb.PbFieldType.O3)
    ..aOB(2, _omitFieldNames ? '' : 'success')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteSyncedContactsResponse clone() =>
      DeleteSyncedContactsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteSyncedContactsResponse copyWith(
          void Function(DeleteSyncedContactsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as DeleteSyncedContactsResponse))
          as DeleteSyncedContactsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteSyncedContactsResponse create() =>
      DeleteSyncedContactsResponse._();
  @$core.override
  DeleteSyncedContactsResponse createEmptyInstance() => create();
  static $pb.PbList<DeleteSyncedContactsResponse> createRepeated() =>
      $pb.PbList<DeleteSyncedContactsResponse>();
  @$core.pragma('dart2js:noInline')
  static DeleteSyncedContactsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteSyncedContactsResponse>(create);
  static DeleteSyncedContactsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get deletedCount => $_getIZ(0);
  @$pb.TagNumber(1)
  set deletedCount($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDeletedCount() => $_has(0);
  @$pb.TagNumber(1)
  void clearDeletedCount() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => $_clearField(2);
}

/// Request to convert contact to recipient
class ConvertContactToRecipientRequest extends $pb.GeneratedMessage {
  factory ConvertContactToRecipientRequest({
    $core.String? contactId,
    $core.String? deviceContactId,
    $core.String? name,
    $core.String? phoneNumber,
    $core.String? email,
    $core.String? accountNumber,
    $core.String? bankName,
    $core.String? sortCode,
    $core.bool? autoDetectLazervault,
  }) {
    final result = create();
    if (contactId != null) result.contactId = contactId;
    if (deviceContactId != null) result.deviceContactId = deviceContactId;
    if (name != null) result.name = name;
    if (phoneNumber != null) result.phoneNumber = phoneNumber;
    if (email != null) result.email = email;
    if (accountNumber != null) result.accountNumber = accountNumber;
    if (bankName != null) result.bankName = bankName;
    if (sortCode != null) result.sortCode = sortCode;
    if (autoDetectLazervault != null)
      result.autoDetectLazervault = autoDetectLazervault;
    return result;
  }

  ConvertContactToRecipientRequest._();

  factory ConvertContactToRecipientRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ConvertContactToRecipientRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ConvertContactToRecipientRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'lazervault.contact'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'contactId')
    ..aOS(2, _omitFieldNames ? '' : 'deviceContactId')
    ..aOS(3, _omitFieldNames ? '' : 'name')
    ..aOS(4, _omitFieldNames ? '' : 'phoneNumber')
    ..aOS(5, _omitFieldNames ? '' : 'email')
    ..aOS(6, _omitFieldNames ? '' : 'accountNumber')
    ..aOS(7, _omitFieldNames ? '' : 'bankName')
    ..aOS(8, _omitFieldNames ? '' : 'sortCode')
    ..aOB(9, _omitFieldNames ? '' : 'autoDetectLazervault')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ConvertContactToRecipientRequest clone() =>
      ConvertContactToRecipientRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ConvertContactToRecipientRequest copyWith(
          void Function(ConvertContactToRecipientRequest) updates) =>
      super.copyWith(
              (message) => updates(message as ConvertContactToRecipientRequest))
          as ConvertContactToRecipientRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ConvertContactToRecipientRequest create() =>
      ConvertContactToRecipientRequest._();
  @$core.override
  ConvertContactToRecipientRequest createEmptyInstance() => create();
  static $pb.PbList<ConvertContactToRecipientRequest> createRepeated() =>
      $pb.PbList<ConvertContactToRecipientRequest>();
  @$core.pragma('dart2js:noInline')
  static ConvertContactToRecipientRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ConvertContactToRecipientRequest>(
          create);
  static ConvertContactToRecipientRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get contactId => $_getSZ(0);
  @$pb.TagNumber(1)
  set contactId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasContactId() => $_has(0);
  @$pb.TagNumber(1)
  void clearContactId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get deviceContactId => $_getSZ(1);
  @$pb.TagNumber(2)
  set deviceContactId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDeviceContactId() => $_has(1);
  @$pb.TagNumber(2)
  void clearDeviceContactId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get phoneNumber => $_getSZ(3);
  @$pb.TagNumber(4)
  set phoneNumber($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPhoneNumber() => $_has(3);
  @$pb.TagNumber(4)
  void clearPhoneNumber() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get email => $_getSZ(4);
  @$pb.TagNumber(5)
  set email($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasEmail() => $_has(4);
  @$pb.TagNumber(5)
  void clearEmail() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get accountNumber => $_getSZ(5);
  @$pb.TagNumber(6)
  set accountNumber($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasAccountNumber() => $_has(5);
  @$pb.TagNumber(6)
  void clearAccountNumber() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get bankName => $_getSZ(6);
  @$pb.TagNumber(7)
  set bankName($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasBankName() => $_has(6);
  @$pb.TagNumber(7)
  void clearBankName() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get sortCode => $_getSZ(7);
  @$pb.TagNumber(8)
  set sortCode($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasSortCode() => $_has(7);
  @$pb.TagNumber(8)
  void clearSortCode() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.bool get autoDetectLazervault => $_getBF(8);
  @$pb.TagNumber(9)
  set autoDetectLazervault($core.bool value) => $_setBool(8, value);
  @$pb.TagNumber(9)
  $core.bool hasAutoDetectLazervault() => $_has(8);
  @$pb.TagNumber(9)
  void clearAutoDetectLazervault() => $_clearField(9);
}

/// Response to convert contact to recipient
class ConvertContactToRecipientResponse extends $pb.GeneratedMessage {
  factory ConvertContactToRecipientResponse({
    $core.String? recipientId,
    $core.bool? isLazervaultUser,
    $core.String? lazervaultUserId,
    $core.String? lazervaultUsername,
    RecipientDetails? recipient,
  }) {
    final result = create();
    if (recipientId != null) result.recipientId = recipientId;
    if (isLazervaultUser != null) result.isLazervaultUser = isLazervaultUser;
    if (lazervaultUserId != null) result.lazervaultUserId = lazervaultUserId;
    if (lazervaultUsername != null)
      result.lazervaultUsername = lazervaultUsername;
    if (recipient != null) result.recipient = recipient;
    return result;
  }

  ConvertContactToRecipientResponse._();

  factory ConvertContactToRecipientResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ConvertContactToRecipientResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ConvertContactToRecipientResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'lazervault.contact'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'recipientId')
    ..aOB(2, _omitFieldNames ? '' : 'isLazervaultUser')
    ..aOS(3, _omitFieldNames ? '' : 'lazervaultUserId')
    ..aOS(4, _omitFieldNames ? '' : 'lazervaultUsername')
    ..aOM<RecipientDetails>(5, _omitFieldNames ? '' : 'recipient',
        subBuilder: RecipientDetails.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ConvertContactToRecipientResponse clone() =>
      ConvertContactToRecipientResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ConvertContactToRecipientResponse copyWith(
          void Function(ConvertContactToRecipientResponse) updates) =>
      super.copyWith((message) =>
              updates(message as ConvertContactToRecipientResponse))
          as ConvertContactToRecipientResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ConvertContactToRecipientResponse create() =>
      ConvertContactToRecipientResponse._();
  @$core.override
  ConvertContactToRecipientResponse createEmptyInstance() => create();
  static $pb.PbList<ConvertContactToRecipientResponse> createRepeated() =>
      $pb.PbList<ConvertContactToRecipientResponse>();
  @$core.pragma('dart2js:noInline')
  static ConvertContactToRecipientResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ConvertContactToRecipientResponse>(
          create);
  static ConvertContactToRecipientResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get recipientId => $_getSZ(0);
  @$pb.TagNumber(1)
  set recipientId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRecipientId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRecipientId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get isLazervaultUser => $_getBF(1);
  @$pb.TagNumber(2)
  set isLazervaultUser($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasIsLazervaultUser() => $_has(1);
  @$pb.TagNumber(2)
  void clearIsLazervaultUser() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get lazervaultUserId => $_getSZ(2);
  @$pb.TagNumber(3)
  set lazervaultUserId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLazervaultUserId() => $_has(2);
  @$pb.TagNumber(3)
  void clearLazervaultUserId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get lazervaultUsername => $_getSZ(3);
  @$pb.TagNumber(4)
  set lazervaultUsername($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasLazervaultUsername() => $_has(3);
  @$pb.TagNumber(4)
  void clearLazervaultUsername() => $_clearField(4);

  @$pb.TagNumber(5)
  RecipientDetails get recipient => $_getN(4);
  @$pb.TagNumber(5)
  set recipient(RecipientDetails value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasRecipient() => $_has(4);
  @$pb.TagNumber(5)
  void clearRecipient() => $_clearField(5);
  @$pb.TagNumber(5)
  RecipientDetails ensureRecipient() => $_ensure(4);
}

/// Recipient details
class RecipientDetails extends $pb.GeneratedMessage {
  factory RecipientDetails({
    $core.String? id,
    $core.String? name,
    $core.String? accountNumber,
    $core.String? bankName,
    $core.String? sortCode,
    $core.String? profilePhotoUrl,
    $core.bool? isFavorite,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (accountNumber != null) result.accountNumber = accountNumber;
    if (bankName != null) result.bankName = bankName;
    if (sortCode != null) result.sortCode = sortCode;
    if (profilePhotoUrl != null) result.profilePhotoUrl = profilePhotoUrl;
    if (isFavorite != null) result.isFavorite = isFavorite;
    return result;
  }

  RecipientDetails._();

  factory RecipientDetails.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RecipientDetails.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RecipientDetails',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'lazervault.contact'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'accountNumber')
    ..aOS(4, _omitFieldNames ? '' : 'bankName')
    ..aOS(5, _omitFieldNames ? '' : 'sortCode')
    ..aOS(6, _omitFieldNames ? '' : 'profilePhotoUrl')
    ..aOB(7, _omitFieldNames ? '' : 'isFavorite')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RecipientDetails clone() => RecipientDetails()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RecipientDetails copyWith(void Function(RecipientDetails) updates) =>
      super.copyWith((message) => updates(message as RecipientDetails))
          as RecipientDetails;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RecipientDetails create() => RecipientDetails._();
  @$core.override
  RecipientDetails createEmptyInstance() => create();
  static $pb.PbList<RecipientDetails> createRepeated() =>
      $pb.PbList<RecipientDetails>();
  @$core.pragma('dart2js:noInline')
  static RecipientDetails getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RecipientDetails>(create);
  static RecipientDetails? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get accountNumber => $_getSZ(2);
  @$pb.TagNumber(3)
  set accountNumber($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAccountNumber() => $_has(2);
  @$pb.TagNumber(3)
  void clearAccountNumber() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get bankName => $_getSZ(3);
  @$pb.TagNumber(4)
  set bankName($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasBankName() => $_has(3);
  @$pb.TagNumber(4)
  void clearBankName() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get sortCode => $_getSZ(4);
  @$pb.TagNumber(5)
  set sortCode($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasSortCode() => $_has(4);
  @$pb.TagNumber(5)
  void clearSortCode() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get profilePhotoUrl => $_getSZ(5);
  @$pb.TagNumber(6)
  set profilePhotoUrl($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasProfilePhotoUrl() => $_has(5);
  @$pb.TagNumber(6)
  void clearProfilePhotoUrl() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.bool get isFavorite => $_getBF(6);
  @$pb.TagNumber(7)
  set isFavorite($core.bool value) => $_setBool(6, value);
  @$pb.TagNumber(7)
  $core.bool hasIsFavorite() => $_has(6);
  @$pb.TagNumber(7)
  void clearIsFavorite() => $_clearField(7);
}

/// Request to find LazerVault users
class FindLazerVaultUsersRequest extends $pb.GeneratedMessage {
  factory FindLazerVaultUsersRequest({
    $core.Iterable<$core.String>? phoneNumbers,
    $core.Iterable<$core.String>? emails,
  }) {
    final result = create();
    if (phoneNumbers != null) result.phoneNumbers.addAll(phoneNumbers);
    if (emails != null) result.emails.addAll(emails);
    return result;
  }

  FindLazerVaultUsersRequest._();

  factory FindLazerVaultUsersRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FindLazerVaultUsersRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FindLazerVaultUsersRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'lazervault.contact'),
      createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'phoneNumbers')
    ..pPS(2, _omitFieldNames ? '' : 'emails')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FindLazerVaultUsersRequest clone() =>
      FindLazerVaultUsersRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FindLazerVaultUsersRequest copyWith(
          void Function(FindLazerVaultUsersRequest) updates) =>
      super.copyWith(
              (message) => updates(message as FindLazerVaultUsersRequest))
          as FindLazerVaultUsersRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FindLazerVaultUsersRequest create() => FindLazerVaultUsersRequest._();
  @$core.override
  FindLazerVaultUsersRequest createEmptyInstance() => create();
  static $pb.PbList<FindLazerVaultUsersRequest> createRepeated() =>
      $pb.PbList<FindLazerVaultUsersRequest>();
  @$core.pragma('dart2js:noInline')
  static FindLazerVaultUsersRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FindLazerVaultUsersRequest>(create);
  static FindLazerVaultUsersRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$core.String> get phoneNumbers => $_getList(0);

  @$pb.TagNumber(2)
  $pb.PbList<$core.String> get emails => $_getList(1);
}

/// Response with found LazerVault users
class FindLazerVaultUsersResponse extends $pb.GeneratedMessage {
  factory FindLazerVaultUsersResponse({
    $core.Iterable<LazerVaultUserMatch>? matchedUsers,
    $core.int? totalMatches,
  }) {
    final result = create();
    if (matchedUsers != null) result.matchedUsers.addAll(matchedUsers);
    if (totalMatches != null) result.totalMatches = totalMatches;
    return result;
  }

  FindLazerVaultUsersResponse._();

  factory FindLazerVaultUsersResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FindLazerVaultUsersResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FindLazerVaultUsersResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'lazervault.contact'),
      createEmptyInstance: create)
    ..pc<LazerVaultUserMatch>(
        1, _omitFieldNames ? '' : 'matchedUsers', $pb.PbFieldType.PM,
        subBuilder: LazerVaultUserMatch.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'totalMatches', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FindLazerVaultUsersResponse clone() =>
      FindLazerVaultUsersResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FindLazerVaultUsersResponse copyWith(
          void Function(FindLazerVaultUsersResponse) updates) =>
      super.copyWith(
              (message) => updates(message as FindLazerVaultUsersResponse))
          as FindLazerVaultUsersResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FindLazerVaultUsersResponse create() =>
      FindLazerVaultUsersResponse._();
  @$core.override
  FindLazerVaultUsersResponse createEmptyInstance() => create();
  static $pb.PbList<FindLazerVaultUsersResponse> createRepeated() =>
      $pb.PbList<FindLazerVaultUsersResponse>();
  @$core.pragma('dart2js:noInline')
  static FindLazerVaultUsersResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FindLazerVaultUsersResponse>(create);
  static FindLazerVaultUsersResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<LazerVaultUserMatch> get matchedUsers => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get totalMatches => $_getIZ(1);
  @$pb.TagNumber(2)
  set totalMatches($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotalMatches() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalMatches() => $_clearField(2);
}

/// Request to update sync preferences
class UpdateSyncPreferencesRequest extends $pb.GeneratedMessage {
  factory UpdateSyncPreferencesRequest({
    $core.bool? autoSyncEnabled,
    SyncFrequency? syncFrequency,
    $core.bool? matchWithUsers,
    $core.bool? syncPhotos,
  }) {
    final result = create();
    if (autoSyncEnabled != null) result.autoSyncEnabled = autoSyncEnabled;
    if (syncFrequency != null) result.syncFrequency = syncFrequency;
    if (matchWithUsers != null) result.matchWithUsers = matchWithUsers;
    if (syncPhotos != null) result.syncPhotos = syncPhotos;
    return result;
  }

  UpdateSyncPreferencesRequest._();

  factory UpdateSyncPreferencesRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateSyncPreferencesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateSyncPreferencesRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'lazervault.contact'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'autoSyncEnabled')
    ..e<SyncFrequency>(
        2, _omitFieldNames ? '' : 'syncFrequency', $pb.PbFieldType.OE,
        defaultOrMaker: SyncFrequency.SYNC_FREQUENCY_UNSPECIFIED,
        valueOf: SyncFrequency.valueOf,
        enumValues: SyncFrequency.values)
    ..aOB(3, _omitFieldNames ? '' : 'matchWithUsers')
    ..aOB(4, _omitFieldNames ? '' : 'syncPhotos')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateSyncPreferencesRequest clone() =>
      UpdateSyncPreferencesRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateSyncPreferencesRequest copyWith(
          void Function(UpdateSyncPreferencesRequest) updates) =>
      super.copyWith(
              (message) => updates(message as UpdateSyncPreferencesRequest))
          as UpdateSyncPreferencesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateSyncPreferencesRequest create() =>
      UpdateSyncPreferencesRequest._();
  @$core.override
  UpdateSyncPreferencesRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateSyncPreferencesRequest> createRepeated() =>
      $pb.PbList<UpdateSyncPreferencesRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateSyncPreferencesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateSyncPreferencesRequest>(create);
  static UpdateSyncPreferencesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get autoSyncEnabled => $_getBF(0);
  @$pb.TagNumber(1)
  set autoSyncEnabled($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAutoSyncEnabled() => $_has(0);
  @$pb.TagNumber(1)
  void clearAutoSyncEnabled() => $_clearField(1);

  @$pb.TagNumber(2)
  SyncFrequency get syncFrequency => $_getN(1);
  @$pb.TagNumber(2)
  set syncFrequency(SyncFrequency value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasSyncFrequency() => $_has(1);
  @$pb.TagNumber(2)
  void clearSyncFrequency() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get matchWithUsers => $_getBF(2);
  @$pb.TagNumber(3)
  set matchWithUsers($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMatchWithUsers() => $_has(2);
  @$pb.TagNumber(3)
  void clearMatchWithUsers() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.bool get syncPhotos => $_getBF(3);
  @$pb.TagNumber(4)
  set syncPhotos($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasSyncPhotos() => $_has(3);
  @$pb.TagNumber(4)
  void clearSyncPhotos() => $_clearField(4);
}

/// Response to update sync preferences
class UpdateSyncPreferencesResponse extends $pb.GeneratedMessage {
  factory UpdateSyncPreferencesResponse({
    SyncPreferences? preferences,
    $core.bool? success,
  }) {
    final result = create();
    if (preferences != null) result.preferences = preferences;
    if (success != null) result.success = success;
    return result;
  }

  UpdateSyncPreferencesResponse._();

  factory UpdateSyncPreferencesResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateSyncPreferencesResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateSyncPreferencesResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'lazervault.contact'),
      createEmptyInstance: create)
    ..aOM<SyncPreferences>(1, _omitFieldNames ? '' : 'preferences',
        subBuilder: SyncPreferences.create)
    ..aOB(2, _omitFieldNames ? '' : 'success')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateSyncPreferencesResponse clone() =>
      UpdateSyncPreferencesResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateSyncPreferencesResponse copyWith(
          void Function(UpdateSyncPreferencesResponse) updates) =>
      super.copyWith(
              (message) => updates(message as UpdateSyncPreferencesResponse))
          as UpdateSyncPreferencesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateSyncPreferencesResponse create() =>
      UpdateSyncPreferencesResponse._();
  @$core.override
  UpdateSyncPreferencesResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateSyncPreferencesResponse> createRepeated() =>
      $pb.PbList<UpdateSyncPreferencesResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateSyncPreferencesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateSyncPreferencesResponse>(create);
  static UpdateSyncPreferencesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  SyncPreferences get preferences => $_getN(0);
  @$pb.TagNumber(1)
  set preferences(SyncPreferences value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasPreferences() => $_has(0);
  @$pb.TagNumber(1)
  void clearPreferences() => $_clearField(1);
  @$pb.TagNumber(1)
  SyncPreferences ensurePreferences() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => $_clearField(2);
}

/// Sync preferences
class SyncPreferences extends $pb.GeneratedMessage {
  factory SyncPreferences({
    $core.String? userId,
    $core.bool? autoSyncEnabled,
    SyncFrequency? syncFrequency,
    $core.bool? matchWithUsers,
    $core.bool? syncPhotos,
    $1.Timestamp? lastSyncAt,
    $core.int? totalSyncedContacts,
    $core.int? totalMatchedUsers,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (autoSyncEnabled != null) result.autoSyncEnabled = autoSyncEnabled;
    if (syncFrequency != null) result.syncFrequency = syncFrequency;
    if (matchWithUsers != null) result.matchWithUsers = matchWithUsers;
    if (syncPhotos != null) result.syncPhotos = syncPhotos;
    if (lastSyncAt != null) result.lastSyncAt = lastSyncAt;
    if (totalSyncedContacts != null)
      result.totalSyncedContacts = totalSyncedContacts;
    if (totalMatchedUsers != null) result.totalMatchedUsers = totalMatchedUsers;
    return result;
  }

  SyncPreferences._();

  factory SyncPreferences.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SyncPreferences.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SyncPreferences',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'lazervault.contact'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOB(2, _omitFieldNames ? '' : 'autoSyncEnabled')
    ..e<SyncFrequency>(
        3, _omitFieldNames ? '' : 'syncFrequency', $pb.PbFieldType.OE,
        defaultOrMaker: SyncFrequency.SYNC_FREQUENCY_UNSPECIFIED,
        valueOf: SyncFrequency.valueOf,
        enumValues: SyncFrequency.values)
    ..aOB(4, _omitFieldNames ? '' : 'matchWithUsers')
    ..aOB(5, _omitFieldNames ? '' : 'syncPhotos')
    ..aOM<$1.Timestamp>(6, _omitFieldNames ? '' : 'lastSyncAt',
        subBuilder: $1.Timestamp.create)
    ..a<$core.int>(
        7, _omitFieldNames ? '' : 'totalSyncedContacts', $pb.PbFieldType.O3)
    ..a<$core.int>(
        8, _omitFieldNames ? '' : 'totalMatchedUsers', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SyncPreferences clone() => SyncPreferences()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SyncPreferences copyWith(void Function(SyncPreferences) updates) =>
      super.copyWith((message) => updates(message as SyncPreferences))
          as SyncPreferences;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SyncPreferences create() => SyncPreferences._();
  @$core.override
  SyncPreferences createEmptyInstance() => create();
  static $pb.PbList<SyncPreferences> createRepeated() =>
      $pb.PbList<SyncPreferences>();
  @$core.pragma('dart2js:noInline')
  static SyncPreferences getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SyncPreferences>(create);
  static SyncPreferences? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get autoSyncEnabled => $_getBF(1);
  @$pb.TagNumber(2)
  set autoSyncEnabled($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAutoSyncEnabled() => $_has(1);
  @$pb.TagNumber(2)
  void clearAutoSyncEnabled() => $_clearField(2);

  @$pb.TagNumber(3)
  SyncFrequency get syncFrequency => $_getN(2);
  @$pb.TagNumber(3)
  set syncFrequency(SyncFrequency value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasSyncFrequency() => $_has(2);
  @$pb.TagNumber(3)
  void clearSyncFrequency() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.bool get matchWithUsers => $_getBF(3);
  @$pb.TagNumber(4)
  set matchWithUsers($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMatchWithUsers() => $_has(3);
  @$pb.TagNumber(4)
  void clearMatchWithUsers() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.bool get syncPhotos => $_getBF(4);
  @$pb.TagNumber(5)
  set syncPhotos($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasSyncPhotos() => $_has(4);
  @$pb.TagNumber(5)
  void clearSyncPhotos() => $_clearField(5);

  @$pb.TagNumber(6)
  $1.Timestamp get lastSyncAt => $_getN(5);
  @$pb.TagNumber(6)
  set lastSyncAt($1.Timestamp value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasLastSyncAt() => $_has(5);
  @$pb.TagNumber(6)
  void clearLastSyncAt() => $_clearField(6);
  @$pb.TagNumber(6)
  $1.Timestamp ensureLastSyncAt() => $_ensure(5);

  @$pb.TagNumber(7)
  $core.int get totalSyncedContacts => $_getIZ(6);
  @$pb.TagNumber(7)
  set totalSyncedContacts($core.int value) => $_setSignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasTotalSyncedContacts() => $_has(6);
  @$pb.TagNumber(7)
  void clearTotalSyncedContacts() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.int get totalMatchedUsers => $_getIZ(7);
  @$pb.TagNumber(8)
  set totalMatchedUsers($core.int value) => $_setSignedInt32(7, value);
  @$pb.TagNumber(8)
  $core.bool hasTotalMatchedUsers() => $_has(7);
  @$pb.TagNumber(8)
  void clearTotalMatchedUsers() => $_clearField(8);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
