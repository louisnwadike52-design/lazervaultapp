// This is a generated file - do not edit.
//
// Generated from family_accounts.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'account_card.pb.dart' as $1;
import 'family_accounts.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'family_accounts.pbenum.dart';

/// Admin: list
class AdminListFamilyAccountsRequest extends $pb.GeneratedMessage {
  factory AdminListFamilyAccountsRequest({
    $core.String? status,
    $core.String? creatorId,
    $core.int? minMembers,
    $core.String? createdAfter,
    $core.String? createdBefore,
    $core.String? search,
    $core.int? page,
    $core.int? pageSize,
  }) {
    final result = create();
    if (status != null) result.status = status;
    if (creatorId != null) result.creatorId = creatorId;
    if (minMembers != null) result.minMembers = minMembers;
    if (createdAfter != null) result.createdAfter = createdAfter;
    if (createdBefore != null) result.createdBefore = createdBefore;
    if (search != null) result.search = search;
    if (page != null) result.page = page;
    if (pageSize != null) result.pageSize = pageSize;
    return result;
  }

  AdminListFamilyAccountsRequest._();

  factory AdminListFamilyAccountsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AdminListFamilyAccountsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AdminListFamilyAccountsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'status')
    ..aOS(2, _omitFieldNames ? '' : 'creatorId')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'minMembers', $pb.PbFieldType.O3)
    ..aOS(4, _omitFieldNames ? '' : 'createdAfter')
    ..aOS(5, _omitFieldNames ? '' : 'createdBefore')
    ..aOS(6, _omitFieldNames ? '' : 'search')
    ..a<$core.int>(7, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(8, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminListFamilyAccountsRequest clone() =>
      AdminListFamilyAccountsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminListFamilyAccountsRequest copyWith(
          void Function(AdminListFamilyAccountsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as AdminListFamilyAccountsRequest))
          as AdminListFamilyAccountsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminListFamilyAccountsRequest create() =>
      AdminListFamilyAccountsRequest._();
  @$core.override
  AdminListFamilyAccountsRequest createEmptyInstance() => create();
  static $pb.PbList<AdminListFamilyAccountsRequest> createRepeated() =>
      $pb.PbList<AdminListFamilyAccountsRequest>();
  @$core.pragma('dart2js:noInline')
  static AdminListFamilyAccountsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AdminListFamilyAccountsRequest>(create);
  static AdminListFamilyAccountsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get status => $_getSZ(0);
  @$pb.TagNumber(1)
  set status($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get creatorId => $_getSZ(1);
  @$pb.TagNumber(2)
  set creatorId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCreatorId() => $_has(1);
  @$pb.TagNumber(2)
  void clearCreatorId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get minMembers => $_getIZ(2);
  @$pb.TagNumber(3)
  set minMembers($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMinMembers() => $_has(2);
  @$pb.TagNumber(3)
  void clearMinMembers() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get createdAfter => $_getSZ(3);
  @$pb.TagNumber(4)
  set createdAfter($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCreatedAfter() => $_has(3);
  @$pb.TagNumber(4)
  void clearCreatedAfter() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get createdBefore => $_getSZ(4);
  @$pb.TagNumber(5)
  set createdBefore($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCreatedBefore() => $_has(4);
  @$pb.TagNumber(5)
  void clearCreatedBefore() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get search => $_getSZ(5);
  @$pb.TagNumber(6)
  set search($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasSearch() => $_has(5);
  @$pb.TagNumber(6)
  void clearSearch() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.int get page => $_getIZ(6);
  @$pb.TagNumber(7)
  set page($core.int value) => $_setSignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasPage() => $_has(6);
  @$pb.TagNumber(7)
  void clearPage() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.int get pageSize => $_getIZ(7);
  @$pb.TagNumber(8)
  set pageSize($core.int value) => $_setSignedInt32(7, value);
  @$pb.TagNumber(8)
  $core.bool hasPageSize() => $_has(7);
  @$pb.TagNumber(8)
  void clearPageSize() => $_clearField(8);
}

class AdminListFamilyAccountsResponse extends $pb.GeneratedMessage {
  factory AdminListFamilyAccountsResponse({
    $core.Iterable<FamilyAccount>? familyAccounts,
    $core.int? totalCount,
    $core.int? page,
    $core.int? pageSize,
    $core.int? totalPages,
  }) {
    final result = create();
    if (familyAccounts != null) result.familyAccounts.addAll(familyAccounts);
    if (totalCount != null) result.totalCount = totalCount;
    if (page != null) result.page = page;
    if (pageSize != null) result.pageSize = pageSize;
    if (totalPages != null) result.totalPages = totalPages;
    return result;
  }

  AdminListFamilyAccountsResponse._();

  factory AdminListFamilyAccountsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AdminListFamilyAccountsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AdminListFamilyAccountsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts.v1'),
      createEmptyInstance: create)
    ..pc<FamilyAccount>(
        1, _omitFieldNames ? '' : 'familyAccounts', $pb.PbFieldType.PM,
        subBuilder: FamilyAccount.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'totalCount', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'totalPages', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminListFamilyAccountsResponse clone() =>
      AdminListFamilyAccountsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminListFamilyAccountsResponse copyWith(
          void Function(AdminListFamilyAccountsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as AdminListFamilyAccountsResponse))
          as AdminListFamilyAccountsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminListFamilyAccountsResponse create() =>
      AdminListFamilyAccountsResponse._();
  @$core.override
  AdminListFamilyAccountsResponse createEmptyInstance() => create();
  static $pb.PbList<AdminListFamilyAccountsResponse> createRepeated() =>
      $pb.PbList<AdminListFamilyAccountsResponse>();
  @$core.pragma('dart2js:noInline')
  static AdminListFamilyAccountsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AdminListFamilyAccountsResponse>(
          create);
  static AdminListFamilyAccountsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<FamilyAccount> get familyAccounts => $_getList(0);

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

  @$pb.TagNumber(5)
  $core.int get totalPages => $_getIZ(4);
  @$pb.TagNumber(5)
  set totalPages($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTotalPages() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotalPages() => $_clearField(5);
}

/// Admin: get
class AdminGetFamilyAccountRequest extends $pb.GeneratedMessage {
  factory AdminGetFamilyAccountRequest({
    $core.String? familyId,
  }) {
    final result = create();
    if (familyId != null) result.familyId = familyId;
    return result;
  }

  AdminGetFamilyAccountRequest._();

  factory AdminGetFamilyAccountRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AdminGetFamilyAccountRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AdminGetFamilyAccountRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'familyId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminGetFamilyAccountRequest clone() =>
      AdminGetFamilyAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminGetFamilyAccountRequest copyWith(
          void Function(AdminGetFamilyAccountRequest) updates) =>
      super.copyWith(
              (message) => updates(message as AdminGetFamilyAccountRequest))
          as AdminGetFamilyAccountRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminGetFamilyAccountRequest create() =>
      AdminGetFamilyAccountRequest._();
  @$core.override
  AdminGetFamilyAccountRequest createEmptyInstance() => create();
  static $pb.PbList<AdminGetFamilyAccountRequest> createRepeated() =>
      $pb.PbList<AdminGetFamilyAccountRequest>();
  @$core.pragma('dart2js:noInline')
  static AdminGetFamilyAccountRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AdminGetFamilyAccountRequest>(create);
  static AdminGetFamilyAccountRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get familyId => $_getSZ(0);
  @$pb.TagNumber(1)
  set familyId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFamilyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFamilyId() => $_clearField(1);
}

class AdminGetFamilyAccountResponse extends $pb.GeneratedMessage {
  factory AdminGetFamilyAccountResponse({
    FamilyAccount? familyAccount,
    $core.Iterable<FamilyTransaction>? recentTransactions,
    FamilyAccountSummary? summary,
    $core.String? adminNotes,
    $core.String? adminFrozenReason,
    $core.String? lastAdminActionAt,
    $core.String? lastAdminActionBy,
  }) {
    final result = create();
    if (familyAccount != null) result.familyAccount = familyAccount;
    if (recentTransactions != null)
      result.recentTransactions.addAll(recentTransactions);
    if (summary != null) result.summary = summary;
    if (adminNotes != null) result.adminNotes = adminNotes;
    if (adminFrozenReason != null) result.adminFrozenReason = adminFrozenReason;
    if (lastAdminActionAt != null) result.lastAdminActionAt = lastAdminActionAt;
    if (lastAdminActionBy != null) result.lastAdminActionBy = lastAdminActionBy;
    return result;
  }

  AdminGetFamilyAccountResponse._();

  factory AdminGetFamilyAccountResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AdminGetFamilyAccountResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AdminGetFamilyAccountResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts.v1'),
      createEmptyInstance: create)
    ..aOM<FamilyAccount>(1, _omitFieldNames ? '' : 'familyAccount',
        subBuilder: FamilyAccount.create)
    ..pc<FamilyTransaction>(
        2, _omitFieldNames ? '' : 'recentTransactions', $pb.PbFieldType.PM,
        subBuilder: FamilyTransaction.create)
    ..aOM<FamilyAccountSummary>(3, _omitFieldNames ? '' : 'summary',
        subBuilder: FamilyAccountSummary.create)
    ..aOS(4, _omitFieldNames ? '' : 'adminNotes')
    ..aOS(5, _omitFieldNames ? '' : 'adminFrozenReason')
    ..aOS(6, _omitFieldNames ? '' : 'lastAdminActionAt')
    ..aOS(7, _omitFieldNames ? '' : 'lastAdminActionBy')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminGetFamilyAccountResponse clone() =>
      AdminGetFamilyAccountResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminGetFamilyAccountResponse copyWith(
          void Function(AdminGetFamilyAccountResponse) updates) =>
      super.copyWith(
              (message) => updates(message as AdminGetFamilyAccountResponse))
          as AdminGetFamilyAccountResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminGetFamilyAccountResponse create() =>
      AdminGetFamilyAccountResponse._();
  @$core.override
  AdminGetFamilyAccountResponse createEmptyInstance() => create();
  static $pb.PbList<AdminGetFamilyAccountResponse> createRepeated() =>
      $pb.PbList<AdminGetFamilyAccountResponse>();
  @$core.pragma('dart2js:noInline')
  static AdminGetFamilyAccountResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AdminGetFamilyAccountResponse>(create);
  static AdminGetFamilyAccountResponse? _defaultInstance;

  @$pb.TagNumber(1)
  FamilyAccount get familyAccount => $_getN(0);
  @$pb.TagNumber(1)
  set familyAccount(FamilyAccount value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasFamilyAccount() => $_has(0);
  @$pb.TagNumber(1)
  void clearFamilyAccount() => $_clearField(1);
  @$pb.TagNumber(1)
  FamilyAccount ensureFamilyAccount() => $_ensure(0);

  @$pb.TagNumber(2)
  $pb.PbList<FamilyTransaction> get recentTransactions => $_getList(1);

  @$pb.TagNumber(3)
  FamilyAccountSummary get summary => $_getN(2);
  @$pb.TagNumber(3)
  set summary(FamilyAccountSummary value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasSummary() => $_has(2);
  @$pb.TagNumber(3)
  void clearSummary() => $_clearField(3);
  @$pb.TagNumber(3)
  FamilyAccountSummary ensureSummary() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.String get adminNotes => $_getSZ(3);
  @$pb.TagNumber(4)
  set adminNotes($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAdminNotes() => $_has(3);
  @$pb.TagNumber(4)
  void clearAdminNotes() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get adminFrozenReason => $_getSZ(4);
  @$pb.TagNumber(5)
  set adminFrozenReason($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasAdminFrozenReason() => $_has(4);
  @$pb.TagNumber(5)
  void clearAdminFrozenReason() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get lastAdminActionAt => $_getSZ(5);
  @$pb.TagNumber(6)
  set lastAdminActionAt($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasLastAdminActionAt() => $_has(5);
  @$pb.TagNumber(6)
  void clearLastAdminActionAt() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get lastAdminActionBy => $_getSZ(6);
  @$pb.TagNumber(7)
  set lastAdminActionBy($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasLastAdminActionBy() => $_has(6);
  @$pb.TagNumber(7)
  void clearLastAdminActionBy() => $_clearField(7);
}

/// Admin: freeze
class AdminFreezeFamilyAccountRequest extends $pb.GeneratedMessage {
  factory AdminFreezeFamilyAccountRequest({
    $core.String? familyId,
    $core.String? reason,
  }) {
    final result = create();
    if (familyId != null) result.familyId = familyId;
    if (reason != null) result.reason = reason;
    return result;
  }

  AdminFreezeFamilyAccountRequest._();

  factory AdminFreezeFamilyAccountRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AdminFreezeFamilyAccountRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AdminFreezeFamilyAccountRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'familyId')
    ..aOS(2, _omitFieldNames ? '' : 'reason')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminFreezeFamilyAccountRequest clone() =>
      AdminFreezeFamilyAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminFreezeFamilyAccountRequest copyWith(
          void Function(AdminFreezeFamilyAccountRequest) updates) =>
      super.copyWith(
              (message) => updates(message as AdminFreezeFamilyAccountRequest))
          as AdminFreezeFamilyAccountRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminFreezeFamilyAccountRequest create() =>
      AdminFreezeFamilyAccountRequest._();
  @$core.override
  AdminFreezeFamilyAccountRequest createEmptyInstance() => create();
  static $pb.PbList<AdminFreezeFamilyAccountRequest> createRepeated() =>
      $pb.PbList<AdminFreezeFamilyAccountRequest>();
  @$core.pragma('dart2js:noInline')
  static AdminFreezeFamilyAccountRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AdminFreezeFamilyAccountRequest>(
          create);
  static AdminFreezeFamilyAccountRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get familyId => $_getSZ(0);
  @$pb.TagNumber(1)
  set familyId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFamilyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFamilyId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get reason => $_getSZ(1);
  @$pb.TagNumber(2)
  set reason($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasReason() => $_has(1);
  @$pb.TagNumber(2)
  void clearReason() => $_clearField(2);
}

class AdminFreezeFamilyAccountResponse extends $pb.GeneratedMessage {
  factory AdminFreezeFamilyAccountResponse({
    $core.bool? success,
    FamilyAccount? familyAccount,
    $core.String? message,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (familyAccount != null) result.familyAccount = familyAccount;
    if (message != null) result.message = message;
    return result;
  }

  AdminFreezeFamilyAccountResponse._();

  factory AdminFreezeFamilyAccountResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AdminFreezeFamilyAccountResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AdminFreezeFamilyAccountResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts.v1'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOM<FamilyAccount>(2, _omitFieldNames ? '' : 'familyAccount',
        subBuilder: FamilyAccount.create)
    ..aOS(3, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminFreezeFamilyAccountResponse clone() =>
      AdminFreezeFamilyAccountResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminFreezeFamilyAccountResponse copyWith(
          void Function(AdminFreezeFamilyAccountResponse) updates) =>
      super.copyWith(
              (message) => updates(message as AdminFreezeFamilyAccountResponse))
          as AdminFreezeFamilyAccountResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminFreezeFamilyAccountResponse create() =>
      AdminFreezeFamilyAccountResponse._();
  @$core.override
  AdminFreezeFamilyAccountResponse createEmptyInstance() => create();
  static $pb.PbList<AdminFreezeFamilyAccountResponse> createRepeated() =>
      $pb.PbList<AdminFreezeFamilyAccountResponse>();
  @$core.pragma('dart2js:noInline')
  static AdminFreezeFamilyAccountResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AdminFreezeFamilyAccountResponse>(
          create);
  static AdminFreezeFamilyAccountResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  FamilyAccount get familyAccount => $_getN(1);
  @$pb.TagNumber(2)
  set familyAccount(FamilyAccount value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasFamilyAccount() => $_has(1);
  @$pb.TagNumber(2)
  void clearFamilyAccount() => $_clearField(2);
  @$pb.TagNumber(2)
  FamilyAccount ensureFamilyAccount() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => $_clearField(3);
}

/// Admin: unfreeze
class AdminUnfreezeFamilyAccountRequest extends $pb.GeneratedMessage {
  factory AdminUnfreezeFamilyAccountRequest({
    $core.String? familyId,
    $core.String? reason,
  }) {
    final result = create();
    if (familyId != null) result.familyId = familyId;
    if (reason != null) result.reason = reason;
    return result;
  }

  AdminUnfreezeFamilyAccountRequest._();

  factory AdminUnfreezeFamilyAccountRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AdminUnfreezeFamilyAccountRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AdminUnfreezeFamilyAccountRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'familyId')
    ..aOS(2, _omitFieldNames ? '' : 'reason')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminUnfreezeFamilyAccountRequest clone() =>
      AdminUnfreezeFamilyAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminUnfreezeFamilyAccountRequest copyWith(
          void Function(AdminUnfreezeFamilyAccountRequest) updates) =>
      super.copyWith((message) =>
              updates(message as AdminUnfreezeFamilyAccountRequest))
          as AdminUnfreezeFamilyAccountRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminUnfreezeFamilyAccountRequest create() =>
      AdminUnfreezeFamilyAccountRequest._();
  @$core.override
  AdminUnfreezeFamilyAccountRequest createEmptyInstance() => create();
  static $pb.PbList<AdminUnfreezeFamilyAccountRequest> createRepeated() =>
      $pb.PbList<AdminUnfreezeFamilyAccountRequest>();
  @$core.pragma('dart2js:noInline')
  static AdminUnfreezeFamilyAccountRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AdminUnfreezeFamilyAccountRequest>(
          create);
  static AdminUnfreezeFamilyAccountRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get familyId => $_getSZ(0);
  @$pb.TagNumber(1)
  set familyId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFamilyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFamilyId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get reason => $_getSZ(1);
  @$pb.TagNumber(2)
  set reason($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasReason() => $_has(1);
  @$pb.TagNumber(2)
  void clearReason() => $_clearField(2);
}

class AdminUnfreezeFamilyAccountResponse extends $pb.GeneratedMessage {
  factory AdminUnfreezeFamilyAccountResponse({
    $core.bool? success,
    FamilyAccount? familyAccount,
    $core.String? message,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (familyAccount != null) result.familyAccount = familyAccount;
    if (message != null) result.message = message;
    return result;
  }

  AdminUnfreezeFamilyAccountResponse._();

  factory AdminUnfreezeFamilyAccountResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AdminUnfreezeFamilyAccountResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AdminUnfreezeFamilyAccountResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts.v1'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOM<FamilyAccount>(2, _omitFieldNames ? '' : 'familyAccount',
        subBuilder: FamilyAccount.create)
    ..aOS(3, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminUnfreezeFamilyAccountResponse clone() =>
      AdminUnfreezeFamilyAccountResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminUnfreezeFamilyAccountResponse copyWith(
          void Function(AdminUnfreezeFamilyAccountResponse) updates) =>
      super.copyWith((message) =>
              updates(message as AdminUnfreezeFamilyAccountResponse))
          as AdminUnfreezeFamilyAccountResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminUnfreezeFamilyAccountResponse create() =>
      AdminUnfreezeFamilyAccountResponse._();
  @$core.override
  AdminUnfreezeFamilyAccountResponse createEmptyInstance() => create();
  static $pb.PbList<AdminUnfreezeFamilyAccountResponse> createRepeated() =>
      $pb.PbList<AdminUnfreezeFamilyAccountResponse>();
  @$core.pragma('dart2js:noInline')
  static AdminUnfreezeFamilyAccountResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AdminUnfreezeFamilyAccountResponse>(
          create);
  static AdminUnfreezeFamilyAccountResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  FamilyAccount get familyAccount => $_getN(1);
  @$pb.TagNumber(2)
  set familyAccount(FamilyAccount value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasFamilyAccount() => $_has(1);
  @$pb.TagNumber(2)
  void clearFamilyAccount() => $_clearField(2);
  @$pb.TagNumber(2)
  FamilyAccount ensureFamilyAccount() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => $_clearField(3);
}

/// Admin: delete
class AdminDeleteFamilyAccountRequest extends $pb.GeneratedMessage {
  factory AdminDeleteFamilyAccountRequest({
    $core.String? familyId,
    $core.String? reason,
  }) {
    final result = create();
    if (familyId != null) result.familyId = familyId;
    if (reason != null) result.reason = reason;
    return result;
  }

  AdminDeleteFamilyAccountRequest._();

  factory AdminDeleteFamilyAccountRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AdminDeleteFamilyAccountRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AdminDeleteFamilyAccountRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'familyId')
    ..aOS(2, _omitFieldNames ? '' : 'reason')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminDeleteFamilyAccountRequest clone() =>
      AdminDeleteFamilyAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminDeleteFamilyAccountRequest copyWith(
          void Function(AdminDeleteFamilyAccountRequest) updates) =>
      super.copyWith(
              (message) => updates(message as AdminDeleteFamilyAccountRequest))
          as AdminDeleteFamilyAccountRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminDeleteFamilyAccountRequest create() =>
      AdminDeleteFamilyAccountRequest._();
  @$core.override
  AdminDeleteFamilyAccountRequest createEmptyInstance() => create();
  static $pb.PbList<AdminDeleteFamilyAccountRequest> createRepeated() =>
      $pb.PbList<AdminDeleteFamilyAccountRequest>();
  @$core.pragma('dart2js:noInline')
  static AdminDeleteFamilyAccountRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AdminDeleteFamilyAccountRequest>(
          create);
  static AdminDeleteFamilyAccountRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get familyId => $_getSZ(0);
  @$pb.TagNumber(1)
  set familyId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFamilyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFamilyId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get reason => $_getSZ(1);
  @$pb.TagNumber(2)
  set reason($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasReason() => $_has(1);
  @$pb.TagNumber(2)
  void clearReason() => $_clearField(2);
}

class AdminDeleteFamilyAccountResponse extends $pb.GeneratedMessage {
  factory AdminDeleteFamilyAccountResponse({
    $core.bool? success,
    $core.double? returnedBalance,
    $core.String? message,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (returnedBalance != null) result.returnedBalance = returnedBalance;
    if (message != null) result.message = message;
    return result;
  }

  AdminDeleteFamilyAccountResponse._();

  factory AdminDeleteFamilyAccountResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AdminDeleteFamilyAccountResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AdminDeleteFamilyAccountResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts.v1'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..a<$core.double>(
        2, _omitFieldNames ? '' : 'returnedBalance', $pb.PbFieldType.OD)
    ..aOS(3, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminDeleteFamilyAccountResponse clone() =>
      AdminDeleteFamilyAccountResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminDeleteFamilyAccountResponse copyWith(
          void Function(AdminDeleteFamilyAccountResponse) updates) =>
      super.copyWith(
              (message) => updates(message as AdminDeleteFamilyAccountResponse))
          as AdminDeleteFamilyAccountResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminDeleteFamilyAccountResponse create() =>
      AdminDeleteFamilyAccountResponse._();
  @$core.override
  AdminDeleteFamilyAccountResponse createEmptyInstance() => create();
  static $pb.PbList<AdminDeleteFamilyAccountResponse> createRepeated() =>
      $pb.PbList<AdminDeleteFamilyAccountResponse>();
  @$core.pragma('dart2js:noInline')
  static AdminDeleteFamilyAccountResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AdminDeleteFamilyAccountResponse>(
          create);
  static AdminDeleteFamilyAccountResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get returnedBalance => $_getN(1);
  @$pb.TagNumber(2)
  set returnedBalance($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasReturnedBalance() => $_has(1);
  @$pb.TagNumber(2)
  void clearReturnedBalance() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => $_clearField(3);
}

/// Admin: force allocate
class AdminForceAllocateFundsRequest extends $pb.GeneratedMessage {
  factory AdminForceAllocateFundsRequest({
    $core.String? familyId,
    $core.String? memberId,
    $core.double? amount,
    $core.String? reason,
  }) {
    final result = create();
    if (familyId != null) result.familyId = familyId;
    if (memberId != null) result.memberId = memberId;
    if (amount != null) result.amount = amount;
    if (reason != null) result.reason = reason;
    return result;
  }

  AdminForceAllocateFundsRequest._();

  factory AdminForceAllocateFundsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AdminForceAllocateFundsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AdminForceAllocateFundsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'familyId')
    ..aOS(2, _omitFieldNames ? '' : 'memberId')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(4, _omitFieldNames ? '' : 'reason')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminForceAllocateFundsRequest clone() =>
      AdminForceAllocateFundsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminForceAllocateFundsRequest copyWith(
          void Function(AdminForceAllocateFundsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as AdminForceAllocateFundsRequest))
          as AdminForceAllocateFundsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminForceAllocateFundsRequest create() =>
      AdminForceAllocateFundsRequest._();
  @$core.override
  AdminForceAllocateFundsRequest createEmptyInstance() => create();
  static $pb.PbList<AdminForceAllocateFundsRequest> createRepeated() =>
      $pb.PbList<AdminForceAllocateFundsRequest>();
  @$core.pragma('dart2js:noInline')
  static AdminForceAllocateFundsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AdminForceAllocateFundsRequest>(create);
  static AdminForceAllocateFundsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get familyId => $_getSZ(0);
  @$pb.TagNumber(1)
  set familyId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFamilyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFamilyId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get memberId => $_getSZ(1);
  @$pb.TagNumber(2)
  set memberId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMemberId() => $_has(1);
  @$pb.TagNumber(2)
  void clearMemberId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get amount => $_getN(2);
  @$pb.TagNumber(3)
  set amount($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get reason => $_getSZ(3);
  @$pb.TagNumber(4)
  set reason($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasReason() => $_has(3);
  @$pb.TagNumber(4)
  void clearReason() => $_clearField(4);
}

class AdminForceAllocateFundsResponse extends $pb.GeneratedMessage {
  factory AdminForceAllocateFundsResponse({
    FamilyMember? member,
    FamilyTransaction? transaction,
    $core.double? remainingPoolBalance,
    $core.String? message,
  }) {
    final result = create();
    if (member != null) result.member = member;
    if (transaction != null) result.transaction = transaction;
    if (remainingPoolBalance != null)
      result.remainingPoolBalance = remainingPoolBalance;
    if (message != null) result.message = message;
    return result;
  }

  AdminForceAllocateFundsResponse._();

  factory AdminForceAllocateFundsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AdminForceAllocateFundsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AdminForceAllocateFundsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts.v1'),
      createEmptyInstance: create)
    ..aOM<FamilyMember>(1, _omitFieldNames ? '' : 'member',
        subBuilder: FamilyMember.create)
    ..aOM<FamilyTransaction>(2, _omitFieldNames ? '' : 'transaction',
        subBuilder: FamilyTransaction.create)
    ..a<$core.double>(
        3, _omitFieldNames ? '' : 'remainingPoolBalance', $pb.PbFieldType.OD)
    ..aOS(4, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminForceAllocateFundsResponse clone() =>
      AdminForceAllocateFundsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminForceAllocateFundsResponse copyWith(
          void Function(AdminForceAllocateFundsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as AdminForceAllocateFundsResponse))
          as AdminForceAllocateFundsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminForceAllocateFundsResponse create() =>
      AdminForceAllocateFundsResponse._();
  @$core.override
  AdminForceAllocateFundsResponse createEmptyInstance() => create();
  static $pb.PbList<AdminForceAllocateFundsResponse> createRepeated() =>
      $pb.PbList<AdminForceAllocateFundsResponse>();
  @$core.pragma('dart2js:noInline')
  static AdminForceAllocateFundsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AdminForceAllocateFundsResponse>(
          create);
  static AdminForceAllocateFundsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  FamilyMember get member => $_getN(0);
  @$pb.TagNumber(1)
  set member(FamilyMember value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasMember() => $_has(0);
  @$pb.TagNumber(1)
  void clearMember() => $_clearField(1);
  @$pb.TagNumber(1)
  FamilyMember ensureMember() => $_ensure(0);

  @$pb.TagNumber(2)
  FamilyTransaction get transaction => $_getN(1);
  @$pb.TagNumber(2)
  set transaction(FamilyTransaction value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasTransaction() => $_has(1);
  @$pb.TagNumber(2)
  void clearTransaction() => $_clearField(2);
  @$pb.TagNumber(2)
  FamilyTransaction ensureTransaction() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.double get remainingPoolBalance => $_getN(2);
  @$pb.TagNumber(3)
  set remainingPoolBalance($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasRemainingPoolBalance() => $_has(2);
  @$pb.TagNumber(3)
  void clearRemainingPoolBalance() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get message => $_getSZ(3);
  @$pb.TagNumber(4)
  set message($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMessage() => $_has(3);
  @$pb.TagNumber(4)
  void clearMessage() => $_clearField(4);
}

/// Admin: remove member
class AdminRemoveFamilyMemberRequest extends $pb.GeneratedMessage {
  factory AdminRemoveFamilyMemberRequest({
    $core.String? familyId,
    $core.String? memberId,
    $core.String? reason,
    $core.bool? returnBalanceToPool,
  }) {
    final result = create();
    if (familyId != null) result.familyId = familyId;
    if (memberId != null) result.memberId = memberId;
    if (reason != null) result.reason = reason;
    if (returnBalanceToPool != null)
      result.returnBalanceToPool = returnBalanceToPool;
    return result;
  }

  AdminRemoveFamilyMemberRequest._();

  factory AdminRemoveFamilyMemberRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AdminRemoveFamilyMemberRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AdminRemoveFamilyMemberRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'familyId')
    ..aOS(2, _omitFieldNames ? '' : 'memberId')
    ..aOS(3, _omitFieldNames ? '' : 'reason')
    ..aOB(4, _omitFieldNames ? '' : 'returnBalanceToPool')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminRemoveFamilyMemberRequest clone() =>
      AdminRemoveFamilyMemberRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminRemoveFamilyMemberRequest copyWith(
          void Function(AdminRemoveFamilyMemberRequest) updates) =>
      super.copyWith(
              (message) => updates(message as AdminRemoveFamilyMemberRequest))
          as AdminRemoveFamilyMemberRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminRemoveFamilyMemberRequest create() =>
      AdminRemoveFamilyMemberRequest._();
  @$core.override
  AdminRemoveFamilyMemberRequest createEmptyInstance() => create();
  static $pb.PbList<AdminRemoveFamilyMemberRequest> createRepeated() =>
      $pb.PbList<AdminRemoveFamilyMemberRequest>();
  @$core.pragma('dart2js:noInline')
  static AdminRemoveFamilyMemberRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AdminRemoveFamilyMemberRequest>(create);
  static AdminRemoveFamilyMemberRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get familyId => $_getSZ(0);
  @$pb.TagNumber(1)
  set familyId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFamilyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFamilyId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get memberId => $_getSZ(1);
  @$pb.TagNumber(2)
  set memberId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMemberId() => $_has(1);
  @$pb.TagNumber(2)
  void clearMemberId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get reason => $_getSZ(2);
  @$pb.TagNumber(3)
  set reason($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasReason() => $_has(2);
  @$pb.TagNumber(3)
  void clearReason() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.bool get returnBalanceToPool => $_getBF(3);
  @$pb.TagNumber(4)
  set returnBalanceToPool($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasReturnBalanceToPool() => $_has(3);
  @$pb.TagNumber(4)
  void clearReturnBalanceToPool() => $_clearField(4);
}

class AdminRemoveFamilyMemberResponse extends $pb.GeneratedMessage {
  factory AdminRemoveFamilyMemberResponse({
    $core.bool? success,
    $core.double? returnedBalance,
    $core.String? message,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (returnedBalance != null) result.returnedBalance = returnedBalance;
    if (message != null) result.message = message;
    return result;
  }

  AdminRemoveFamilyMemberResponse._();

  factory AdminRemoveFamilyMemberResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AdminRemoveFamilyMemberResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AdminRemoveFamilyMemberResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts.v1'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..a<$core.double>(
        2, _omitFieldNames ? '' : 'returnedBalance', $pb.PbFieldType.OD)
    ..aOS(3, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminRemoveFamilyMemberResponse clone() =>
      AdminRemoveFamilyMemberResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminRemoveFamilyMemberResponse copyWith(
          void Function(AdminRemoveFamilyMemberResponse) updates) =>
      super.copyWith(
              (message) => updates(message as AdminRemoveFamilyMemberResponse))
          as AdminRemoveFamilyMemberResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminRemoveFamilyMemberResponse create() =>
      AdminRemoveFamilyMemberResponse._();
  @$core.override
  AdminRemoveFamilyMemberResponse createEmptyInstance() => create();
  static $pb.PbList<AdminRemoveFamilyMemberResponse> createRepeated() =>
      $pb.PbList<AdminRemoveFamilyMemberResponse>();
  @$core.pragma('dart2js:noInline')
  static AdminRemoveFamilyMemberResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AdminRemoveFamilyMemberResponse>(
          create);
  static AdminRemoveFamilyMemberResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get returnedBalance => $_getN(1);
  @$pb.TagNumber(2)
  set returnedBalance($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasReturnedBalance() => $_has(1);
  @$pb.TagNumber(2)
  void clearReturnedBalance() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => $_clearField(3);
}

/// Admin: update notes
class AdminUpdateFamilyAccountNotesRequest extends $pb.GeneratedMessage {
  factory AdminUpdateFamilyAccountNotesRequest({
    $core.String? familyId,
    $core.String? adminNotes,
  }) {
    final result = create();
    if (familyId != null) result.familyId = familyId;
    if (adminNotes != null) result.adminNotes = adminNotes;
    return result;
  }

  AdminUpdateFamilyAccountNotesRequest._();

  factory AdminUpdateFamilyAccountNotesRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AdminUpdateFamilyAccountNotesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AdminUpdateFamilyAccountNotesRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'familyId')
    ..aOS(2, _omitFieldNames ? '' : 'adminNotes')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminUpdateFamilyAccountNotesRequest clone() =>
      AdminUpdateFamilyAccountNotesRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminUpdateFamilyAccountNotesRequest copyWith(
          void Function(AdminUpdateFamilyAccountNotesRequest) updates) =>
      super.copyWith((message) =>
              updates(message as AdminUpdateFamilyAccountNotesRequest))
          as AdminUpdateFamilyAccountNotesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminUpdateFamilyAccountNotesRequest create() =>
      AdminUpdateFamilyAccountNotesRequest._();
  @$core.override
  AdminUpdateFamilyAccountNotesRequest createEmptyInstance() => create();
  static $pb.PbList<AdminUpdateFamilyAccountNotesRequest> createRepeated() =>
      $pb.PbList<AdminUpdateFamilyAccountNotesRequest>();
  @$core.pragma('dart2js:noInline')
  static AdminUpdateFamilyAccountNotesRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          AdminUpdateFamilyAccountNotesRequest>(create);
  static AdminUpdateFamilyAccountNotesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get familyId => $_getSZ(0);
  @$pb.TagNumber(1)
  set familyId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFamilyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFamilyId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get adminNotes => $_getSZ(1);
  @$pb.TagNumber(2)
  set adminNotes($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAdminNotes() => $_has(1);
  @$pb.TagNumber(2)
  void clearAdminNotes() => $_clearField(2);
}

class AdminUpdateFamilyAccountNotesResponse extends $pb.GeneratedMessage {
  factory AdminUpdateFamilyAccountNotesResponse({
    FamilyAccount? familyAccount,
    $core.String? message,
  }) {
    final result = create();
    if (familyAccount != null) result.familyAccount = familyAccount;
    if (message != null) result.message = message;
    return result;
  }

  AdminUpdateFamilyAccountNotesResponse._();

  factory AdminUpdateFamilyAccountNotesResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AdminUpdateFamilyAccountNotesResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AdminUpdateFamilyAccountNotesResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts.v1'),
      createEmptyInstance: create)
    ..aOM<FamilyAccount>(1, _omitFieldNames ? '' : 'familyAccount',
        subBuilder: FamilyAccount.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminUpdateFamilyAccountNotesResponse clone() =>
      AdminUpdateFamilyAccountNotesResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminUpdateFamilyAccountNotesResponse copyWith(
          void Function(AdminUpdateFamilyAccountNotesResponse) updates) =>
      super.copyWith((message) =>
              updates(message as AdminUpdateFamilyAccountNotesResponse))
          as AdminUpdateFamilyAccountNotesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminUpdateFamilyAccountNotesResponse create() =>
      AdminUpdateFamilyAccountNotesResponse._();
  @$core.override
  AdminUpdateFamilyAccountNotesResponse createEmptyInstance() => create();
  static $pb.PbList<AdminUpdateFamilyAccountNotesResponse> createRepeated() =>
      $pb.PbList<AdminUpdateFamilyAccountNotesResponse>();
  @$core.pragma('dart2js:noInline')
  static AdminUpdateFamilyAccountNotesResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          AdminUpdateFamilyAccountNotesResponse>(create);
  static AdminUpdateFamilyAccountNotesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  FamilyAccount get familyAccount => $_getN(0);
  @$pb.TagNumber(1)
  set familyAccount(FamilyAccount value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasFamilyAccount() => $_has(0);
  @$pb.TagNumber(1)
  void clearFamilyAccount() => $_clearField(1);
  @$pb.TagNumber(1)
  FamilyAccount ensureFamilyAccount() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);
}

/// Create Family Account
class CreateFamilyAccountRequest extends $pb.GeneratedMessage {
  factory CreateFamilyAccountRequest({
    $core.String? name,
    $core.String? description,
    $core.String? initialCurrency,
    $core.double? initialFunding,
    $core.bool? allowMemberContributions,
    $core.String? fundingPolicy,
    $core.Iterable<$core.String>? specificMemberIds,
  }) {
    final result = create();
    if (name != null) result.name = name;
    if (description != null) result.description = description;
    if (initialCurrency != null) result.initialCurrency = initialCurrency;
    if (initialFunding != null) result.initialFunding = initialFunding;
    if (allowMemberContributions != null)
      result.allowMemberContributions = allowMemberContributions;
    if (fundingPolicy != null) result.fundingPolicy = fundingPolicy;
    if (specificMemberIds != null)
      result.specificMemberIds.addAll(specificMemberIds);
    return result;
  }

  CreateFamilyAccountRequest._();

  factory CreateFamilyAccountRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateFamilyAccountRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateFamilyAccountRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOS(2, _omitFieldNames ? '' : 'description')
    ..aOS(3, _omitFieldNames ? '' : 'initialCurrency')
    ..a<$core.double>(
        4, _omitFieldNames ? '' : 'initialFunding', $pb.PbFieldType.OD)
    ..aOB(5, _omitFieldNames ? '' : 'allowMemberContributions')
    ..aOS(6, _omitFieldNames ? '' : 'fundingPolicy')
    ..pPS(7, _omitFieldNames ? '' : 'specificMemberIds')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateFamilyAccountRequest clone() =>
      CreateFamilyAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateFamilyAccountRequest copyWith(
          void Function(CreateFamilyAccountRequest) updates) =>
      super.copyWith(
              (message) => updates(message as CreateFamilyAccountRequest))
          as CreateFamilyAccountRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateFamilyAccountRequest create() => CreateFamilyAccountRequest._();
  @$core.override
  CreateFamilyAccountRequest createEmptyInstance() => create();
  static $pb.PbList<CreateFamilyAccountRequest> createRepeated() =>
      $pb.PbList<CreateFamilyAccountRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateFamilyAccountRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateFamilyAccountRequest>(create);
  static CreateFamilyAccountRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get description => $_getSZ(1);
  @$pb.TagNumber(2)
  set description($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDescription() => $_has(1);
  @$pb.TagNumber(2)
  void clearDescription() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get initialCurrency => $_getSZ(2);
  @$pb.TagNumber(3)
  set initialCurrency($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasInitialCurrency() => $_has(2);
  @$pb.TagNumber(3)
  void clearInitialCurrency() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get initialFunding => $_getN(3);
  @$pb.TagNumber(4)
  set initialFunding($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasInitialFunding() => $_has(3);
  @$pb.TagNumber(4)
  void clearInitialFunding() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.bool get allowMemberContributions => $_getBF(4);
  @$pb.TagNumber(5)
  set allowMemberContributions($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasAllowMemberContributions() => $_has(4);
  @$pb.TagNumber(5)
  void clearAllowMemberContributions() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get fundingPolicy => $_getSZ(5);
  @$pb.TagNumber(6)
  set fundingPolicy($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasFundingPolicy() => $_has(5);
  @$pb.TagNumber(6)
  void clearFundingPolicy() => $_clearField(6);

  @$pb.TagNumber(7)
  $pb.PbList<$core.String> get specificMemberIds => $_getList(6);
}

class CreateFamilyAccountResponse extends $pb.GeneratedMessage {
  factory CreateFamilyAccountResponse({
    FamilyAccount? familyAccount,
    $core.String? message,
  }) {
    final result = create();
    if (familyAccount != null) result.familyAccount = familyAccount;
    if (message != null) result.message = message;
    return result;
  }

  CreateFamilyAccountResponse._();

  factory CreateFamilyAccountResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateFamilyAccountResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateFamilyAccountResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts.v1'),
      createEmptyInstance: create)
    ..aOM<FamilyAccount>(1, _omitFieldNames ? '' : 'familyAccount',
        subBuilder: FamilyAccount.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateFamilyAccountResponse clone() =>
      CreateFamilyAccountResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateFamilyAccountResponse copyWith(
          void Function(CreateFamilyAccountResponse) updates) =>
      super.copyWith(
              (message) => updates(message as CreateFamilyAccountResponse))
          as CreateFamilyAccountResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateFamilyAccountResponse create() =>
      CreateFamilyAccountResponse._();
  @$core.override
  CreateFamilyAccountResponse createEmptyInstance() => create();
  static $pb.PbList<CreateFamilyAccountResponse> createRepeated() =>
      $pb.PbList<CreateFamilyAccountResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateFamilyAccountResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateFamilyAccountResponse>(create);
  static CreateFamilyAccountResponse? _defaultInstance;

  @$pb.TagNumber(1)
  FamilyAccount get familyAccount => $_getN(0);
  @$pb.TagNumber(1)
  set familyAccount(FamilyAccount value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasFamilyAccount() => $_has(0);
  @$pb.TagNumber(1)
  void clearFamilyAccount() => $_clearField(1);
  @$pb.TagNumber(1)
  FamilyAccount ensureFamilyAccount() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);
}

/// Get Family Accounts
class GetFamilyAccountsRequest extends $pb.GeneratedMessage {
  factory GetFamilyAccountsRequest({
    $core.String? status,
  }) {
    final result = create();
    if (status != null) result.status = status;
    return result;
  }

  GetFamilyAccountsRequest._();

  factory GetFamilyAccountsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetFamilyAccountsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetFamilyAccountsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'status')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetFamilyAccountsRequest clone() =>
      GetFamilyAccountsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetFamilyAccountsRequest copyWith(
          void Function(GetFamilyAccountsRequest) updates) =>
      super.copyWith((message) => updates(message as GetFamilyAccountsRequest))
          as GetFamilyAccountsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetFamilyAccountsRequest create() => GetFamilyAccountsRequest._();
  @$core.override
  GetFamilyAccountsRequest createEmptyInstance() => create();
  static $pb.PbList<GetFamilyAccountsRequest> createRepeated() =>
      $pb.PbList<GetFamilyAccountsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetFamilyAccountsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetFamilyAccountsRequest>(create);
  static GetFamilyAccountsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get status => $_getSZ(0);
  @$pb.TagNumber(1)
  set status($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => $_clearField(1);
}

class GetFamilyAccountsResponse extends $pb.GeneratedMessage {
  factory GetFamilyAccountsResponse({
    $core.Iterable<FamilyAccount>? familyAccounts,
    $core.int? totalCount,
  }) {
    final result = create();
    if (familyAccounts != null) result.familyAccounts.addAll(familyAccounts);
    if (totalCount != null) result.totalCount = totalCount;
    return result;
  }

  GetFamilyAccountsResponse._();

  factory GetFamilyAccountsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetFamilyAccountsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetFamilyAccountsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts.v1'),
      createEmptyInstance: create)
    ..pc<FamilyAccount>(
        1, _omitFieldNames ? '' : 'familyAccounts', $pb.PbFieldType.PM,
        subBuilder: FamilyAccount.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'totalCount', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetFamilyAccountsResponse clone() =>
      GetFamilyAccountsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetFamilyAccountsResponse copyWith(
          void Function(GetFamilyAccountsResponse) updates) =>
      super.copyWith((message) => updates(message as GetFamilyAccountsResponse))
          as GetFamilyAccountsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetFamilyAccountsResponse create() => GetFamilyAccountsResponse._();
  @$core.override
  GetFamilyAccountsResponse createEmptyInstance() => create();
  static $pb.PbList<GetFamilyAccountsResponse> createRepeated() =>
      $pb.PbList<GetFamilyAccountsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetFamilyAccountsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetFamilyAccountsResponse>(create);
  static GetFamilyAccountsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<FamilyAccount> get familyAccounts => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get totalCount => $_getIZ(1);
  @$pb.TagNumber(2)
  set totalCount($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotalCount() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalCount() => $_clearField(2);
}

/// Get Family Account
class GetFamilyAccountRequest extends $pb.GeneratedMessage {
  factory GetFamilyAccountRequest({
    $core.String? familyId,
  }) {
    final result = create();
    if (familyId != null) result.familyId = familyId;
    return result;
  }

  GetFamilyAccountRequest._();

  factory GetFamilyAccountRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetFamilyAccountRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetFamilyAccountRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'familyId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetFamilyAccountRequest clone() =>
      GetFamilyAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetFamilyAccountRequest copyWith(
          void Function(GetFamilyAccountRequest) updates) =>
      super.copyWith((message) => updates(message as GetFamilyAccountRequest))
          as GetFamilyAccountRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetFamilyAccountRequest create() => GetFamilyAccountRequest._();
  @$core.override
  GetFamilyAccountRequest createEmptyInstance() => create();
  static $pb.PbList<GetFamilyAccountRequest> createRepeated() =>
      $pb.PbList<GetFamilyAccountRequest>();
  @$core.pragma('dart2js:noInline')
  static GetFamilyAccountRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetFamilyAccountRequest>(create);
  static GetFamilyAccountRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get familyId => $_getSZ(0);
  @$pb.TagNumber(1)
  set familyId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFamilyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFamilyId() => $_clearField(1);
}

class GetFamilyAccountResponse extends $pb.GeneratedMessage {
  factory GetFamilyAccountResponse({
    FamilyAccount? familyAccount,
    $core.Iterable<FamilyTransaction>? recentTransactions,
    FamilyAccountSummary? summary,
  }) {
    final result = create();
    if (familyAccount != null) result.familyAccount = familyAccount;
    if (recentTransactions != null)
      result.recentTransactions.addAll(recentTransactions);
    if (summary != null) result.summary = summary;
    return result;
  }

  GetFamilyAccountResponse._();

  factory GetFamilyAccountResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetFamilyAccountResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetFamilyAccountResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts.v1'),
      createEmptyInstance: create)
    ..aOM<FamilyAccount>(1, _omitFieldNames ? '' : 'familyAccount',
        subBuilder: FamilyAccount.create)
    ..pc<FamilyTransaction>(
        2, _omitFieldNames ? '' : 'recentTransactions', $pb.PbFieldType.PM,
        subBuilder: FamilyTransaction.create)
    ..aOM<FamilyAccountSummary>(3, _omitFieldNames ? '' : 'summary',
        subBuilder: FamilyAccountSummary.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetFamilyAccountResponse clone() =>
      GetFamilyAccountResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetFamilyAccountResponse copyWith(
          void Function(GetFamilyAccountResponse) updates) =>
      super.copyWith((message) => updates(message as GetFamilyAccountResponse))
          as GetFamilyAccountResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetFamilyAccountResponse create() => GetFamilyAccountResponse._();
  @$core.override
  GetFamilyAccountResponse createEmptyInstance() => create();
  static $pb.PbList<GetFamilyAccountResponse> createRepeated() =>
      $pb.PbList<GetFamilyAccountResponse>();
  @$core.pragma('dart2js:noInline')
  static GetFamilyAccountResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetFamilyAccountResponse>(create);
  static GetFamilyAccountResponse? _defaultInstance;

  @$pb.TagNumber(1)
  FamilyAccount get familyAccount => $_getN(0);
  @$pb.TagNumber(1)
  set familyAccount(FamilyAccount value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasFamilyAccount() => $_has(0);
  @$pb.TagNumber(1)
  void clearFamilyAccount() => $_clearField(1);
  @$pb.TagNumber(1)
  FamilyAccount ensureFamilyAccount() => $_ensure(0);

  @$pb.TagNumber(2)
  $pb.PbList<FamilyTransaction> get recentTransactions => $_getList(1);

  @$pb.TagNumber(3)
  FamilyAccountSummary get summary => $_getN(2);
  @$pb.TagNumber(3)
  set summary(FamilyAccountSummary value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasSummary() => $_has(2);
  @$pb.TagNumber(3)
  void clearSummary() => $_clearField(3);
  @$pb.TagNumber(3)
  FamilyAccountSummary ensureSummary() => $_ensure(2);
}

/// Add Family Member
class AddFamilyMemberRequest extends $pb.GeneratedMessage {
  factory AddFamilyMemberRequest({
    $core.String? familyId,
    $core.String? invitationMethod,
    $core.String? invitationDestination,
    $core.double? initialAllocation,
    $core.double? dailyLimit,
    $core.double? monthlyLimit,
    $core.String? role,
    $core.String? personalMessage,
    $core.double? perTransactionLimit,
    $core.double? allocationPercentageCap,
  }) {
    final result = create();
    if (familyId != null) result.familyId = familyId;
    if (invitationMethod != null) result.invitationMethod = invitationMethod;
    if (invitationDestination != null)
      result.invitationDestination = invitationDestination;
    if (initialAllocation != null) result.initialAllocation = initialAllocation;
    if (dailyLimit != null) result.dailyLimit = dailyLimit;
    if (monthlyLimit != null) result.monthlyLimit = monthlyLimit;
    if (role != null) result.role = role;
    if (personalMessage != null) result.personalMessage = personalMessage;
    if (perTransactionLimit != null)
      result.perTransactionLimit = perTransactionLimit;
    if (allocationPercentageCap != null)
      result.allocationPercentageCap = allocationPercentageCap;
    return result;
  }

  AddFamilyMemberRequest._();

  factory AddFamilyMemberRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AddFamilyMemberRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AddFamilyMemberRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'familyId')
    ..aOS(2, _omitFieldNames ? '' : 'invitationMethod')
    ..aOS(3, _omitFieldNames ? '' : 'invitationDestination')
    ..a<$core.double>(
        4, _omitFieldNames ? '' : 'initialAllocation', $pb.PbFieldType.OD)
    ..a<$core.double>(
        5, _omitFieldNames ? '' : 'dailyLimit', $pb.PbFieldType.OD)
    ..a<$core.double>(
        6, _omitFieldNames ? '' : 'monthlyLimit', $pb.PbFieldType.OD)
    ..aOS(7, _omitFieldNames ? '' : 'role')
    ..aOS(8, _omitFieldNames ? '' : 'personalMessage')
    ..a<$core.double>(
        9, _omitFieldNames ? '' : 'perTransactionLimit', $pb.PbFieldType.OD)
    ..a<$core.double>(10, _omitFieldNames ? '' : 'allocationPercentageCap',
        $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddFamilyMemberRequest clone() =>
      AddFamilyMemberRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddFamilyMemberRequest copyWith(
          void Function(AddFamilyMemberRequest) updates) =>
      super.copyWith((message) => updates(message as AddFamilyMemberRequest))
          as AddFamilyMemberRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddFamilyMemberRequest create() => AddFamilyMemberRequest._();
  @$core.override
  AddFamilyMemberRequest createEmptyInstance() => create();
  static $pb.PbList<AddFamilyMemberRequest> createRepeated() =>
      $pb.PbList<AddFamilyMemberRequest>();
  @$core.pragma('dart2js:noInline')
  static AddFamilyMemberRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AddFamilyMemberRequest>(create);
  static AddFamilyMemberRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get familyId => $_getSZ(0);
  @$pb.TagNumber(1)
  set familyId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFamilyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFamilyId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get invitationMethod => $_getSZ(1);
  @$pb.TagNumber(2)
  set invitationMethod($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasInvitationMethod() => $_has(1);
  @$pb.TagNumber(2)
  void clearInvitationMethod() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get invitationDestination => $_getSZ(2);
  @$pb.TagNumber(3)
  set invitationDestination($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasInvitationDestination() => $_has(2);
  @$pb.TagNumber(3)
  void clearInvitationDestination() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get initialAllocation => $_getN(3);
  @$pb.TagNumber(4)
  set initialAllocation($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasInitialAllocation() => $_has(3);
  @$pb.TagNumber(4)
  void clearInitialAllocation() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get dailyLimit => $_getN(4);
  @$pb.TagNumber(5)
  set dailyLimit($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasDailyLimit() => $_has(4);
  @$pb.TagNumber(5)
  void clearDailyLimit() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.double get monthlyLimit => $_getN(5);
  @$pb.TagNumber(6)
  set monthlyLimit($core.double value) => $_setDouble(5, value);
  @$pb.TagNumber(6)
  $core.bool hasMonthlyLimit() => $_has(5);
  @$pb.TagNumber(6)
  void clearMonthlyLimit() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get role => $_getSZ(6);
  @$pb.TagNumber(7)
  set role($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasRole() => $_has(6);
  @$pb.TagNumber(7)
  void clearRole() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get personalMessage => $_getSZ(7);
  @$pb.TagNumber(8)
  set personalMessage($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasPersonalMessage() => $_has(7);
  @$pb.TagNumber(8)
  void clearPersonalMessage() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.double get perTransactionLimit => $_getN(8);
  @$pb.TagNumber(9)
  set perTransactionLimit($core.double value) => $_setDouble(8, value);
  @$pb.TagNumber(9)
  $core.bool hasPerTransactionLimit() => $_has(8);
  @$pb.TagNumber(9)
  void clearPerTransactionLimit() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.double get allocationPercentageCap => $_getN(9);
  @$pb.TagNumber(10)
  set allocationPercentageCap($core.double value) => $_setDouble(9, value);
  @$pb.TagNumber(10)
  $core.bool hasAllocationPercentageCap() => $_has(9);
  @$pb.TagNumber(10)
  void clearAllocationPercentageCap() => $_clearField(10);
}

class AddFamilyMemberResponse extends $pb.GeneratedMessage {
  factory AddFamilyMemberResponse({
    FamilyMember? member,
    $core.String? invitationMessage,
    $core.String? invitationLink,
  }) {
    final result = create();
    if (member != null) result.member = member;
    if (invitationMessage != null) result.invitationMessage = invitationMessage;
    if (invitationLink != null) result.invitationLink = invitationLink;
    return result;
  }

  AddFamilyMemberResponse._();

  factory AddFamilyMemberResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AddFamilyMemberResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AddFamilyMemberResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts.v1'),
      createEmptyInstance: create)
    ..aOM<FamilyMember>(1, _omitFieldNames ? '' : 'member',
        subBuilder: FamilyMember.create)
    ..aOS(2, _omitFieldNames ? '' : 'invitationMessage')
    ..aOS(3, _omitFieldNames ? '' : 'invitationLink')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddFamilyMemberResponse clone() =>
      AddFamilyMemberResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddFamilyMemberResponse copyWith(
          void Function(AddFamilyMemberResponse) updates) =>
      super.copyWith((message) => updates(message as AddFamilyMemberResponse))
          as AddFamilyMemberResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddFamilyMemberResponse create() => AddFamilyMemberResponse._();
  @$core.override
  AddFamilyMemberResponse createEmptyInstance() => create();
  static $pb.PbList<AddFamilyMemberResponse> createRepeated() =>
      $pb.PbList<AddFamilyMemberResponse>();
  @$core.pragma('dart2js:noInline')
  static AddFamilyMemberResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AddFamilyMemberResponse>(create);
  static AddFamilyMemberResponse? _defaultInstance;

  @$pb.TagNumber(1)
  FamilyMember get member => $_getN(0);
  @$pb.TagNumber(1)
  set member(FamilyMember value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasMember() => $_has(0);
  @$pb.TagNumber(1)
  void clearMember() => $_clearField(1);
  @$pb.TagNumber(1)
  FamilyMember ensureMember() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get invitationMessage => $_getSZ(1);
  @$pb.TagNumber(2)
  set invitationMessage($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasInvitationMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearInvitationMessage() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get invitationLink => $_getSZ(2);
  @$pb.TagNumber(3)
  set invitationLink($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasInvitationLink() => $_has(2);
  @$pb.TagNumber(3)
  void clearInvitationLink() => $_clearField(3);
}

/// Update Family Member
class UpdateFamilyMemberRequest extends $pb.GeneratedMessage {
  factory UpdateFamilyMemberRequest({
    $core.String? familyId,
    $core.String? memberId,
    $core.double? allocatedBalance,
    $core.double? dailySpendingLimit,
    $core.double? monthlySpendingLimit,
    $core.String? role,
    $core.double? perTransactionLimit,
    $core.double? allocationPercentageCap,
  }) {
    final result = create();
    if (familyId != null) result.familyId = familyId;
    if (memberId != null) result.memberId = memberId;
    if (allocatedBalance != null) result.allocatedBalance = allocatedBalance;
    if (dailySpendingLimit != null)
      result.dailySpendingLimit = dailySpendingLimit;
    if (monthlySpendingLimit != null)
      result.monthlySpendingLimit = monthlySpendingLimit;
    if (role != null) result.role = role;
    if (perTransactionLimit != null)
      result.perTransactionLimit = perTransactionLimit;
    if (allocationPercentageCap != null)
      result.allocationPercentageCap = allocationPercentageCap;
    return result;
  }

  UpdateFamilyMemberRequest._();

  factory UpdateFamilyMemberRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateFamilyMemberRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateFamilyMemberRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'familyId')
    ..aOS(2, _omitFieldNames ? '' : 'memberId')
    ..a<$core.double>(
        3, _omitFieldNames ? '' : 'allocatedBalance', $pb.PbFieldType.OD)
    ..a<$core.double>(
        4, _omitFieldNames ? '' : 'dailySpendingLimit', $pb.PbFieldType.OD)
    ..a<$core.double>(
        5, _omitFieldNames ? '' : 'monthlySpendingLimit', $pb.PbFieldType.OD)
    ..aOS(6, _omitFieldNames ? '' : 'role')
    ..a<$core.double>(
        7, _omitFieldNames ? '' : 'perTransactionLimit', $pb.PbFieldType.OD)
    ..a<$core.double>(
        8, _omitFieldNames ? '' : 'allocationPercentageCap', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateFamilyMemberRequest clone() =>
      UpdateFamilyMemberRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateFamilyMemberRequest copyWith(
          void Function(UpdateFamilyMemberRequest) updates) =>
      super.copyWith((message) => updates(message as UpdateFamilyMemberRequest))
          as UpdateFamilyMemberRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateFamilyMemberRequest create() => UpdateFamilyMemberRequest._();
  @$core.override
  UpdateFamilyMemberRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateFamilyMemberRequest> createRepeated() =>
      $pb.PbList<UpdateFamilyMemberRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateFamilyMemberRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateFamilyMemberRequest>(create);
  static UpdateFamilyMemberRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get familyId => $_getSZ(0);
  @$pb.TagNumber(1)
  set familyId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFamilyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFamilyId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get memberId => $_getSZ(1);
  @$pb.TagNumber(2)
  set memberId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMemberId() => $_has(1);
  @$pb.TagNumber(2)
  void clearMemberId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get allocatedBalance => $_getN(2);
  @$pb.TagNumber(3)
  set allocatedBalance($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAllocatedBalance() => $_has(2);
  @$pb.TagNumber(3)
  void clearAllocatedBalance() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get dailySpendingLimit => $_getN(3);
  @$pb.TagNumber(4)
  set dailySpendingLimit($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDailySpendingLimit() => $_has(3);
  @$pb.TagNumber(4)
  void clearDailySpendingLimit() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get monthlySpendingLimit => $_getN(4);
  @$pb.TagNumber(5)
  set monthlySpendingLimit($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasMonthlySpendingLimit() => $_has(4);
  @$pb.TagNumber(5)
  void clearMonthlySpendingLimit() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get role => $_getSZ(5);
  @$pb.TagNumber(6)
  set role($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasRole() => $_has(5);
  @$pb.TagNumber(6)
  void clearRole() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.double get perTransactionLimit => $_getN(6);
  @$pb.TagNumber(7)
  set perTransactionLimit($core.double value) => $_setDouble(6, value);
  @$pb.TagNumber(7)
  $core.bool hasPerTransactionLimit() => $_has(6);
  @$pb.TagNumber(7)
  void clearPerTransactionLimit() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.double get allocationPercentageCap => $_getN(7);
  @$pb.TagNumber(8)
  set allocationPercentageCap($core.double value) => $_setDouble(7, value);
  @$pb.TagNumber(8)
  $core.bool hasAllocationPercentageCap() => $_has(7);
  @$pb.TagNumber(8)
  void clearAllocationPercentageCap() => $_clearField(8);
}

class UpdateFamilyMemberResponse extends $pb.GeneratedMessage {
  factory UpdateFamilyMemberResponse({
    FamilyMember? member,
    $core.String? message,
  }) {
    final result = create();
    if (member != null) result.member = member;
    if (message != null) result.message = message;
    return result;
  }

  UpdateFamilyMemberResponse._();

  factory UpdateFamilyMemberResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateFamilyMemberResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateFamilyMemberResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts.v1'),
      createEmptyInstance: create)
    ..aOM<FamilyMember>(1, _omitFieldNames ? '' : 'member',
        subBuilder: FamilyMember.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateFamilyMemberResponse clone() =>
      UpdateFamilyMemberResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateFamilyMemberResponse copyWith(
          void Function(UpdateFamilyMemberResponse) updates) =>
      super.copyWith(
              (message) => updates(message as UpdateFamilyMemberResponse))
          as UpdateFamilyMemberResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateFamilyMemberResponse create() => UpdateFamilyMemberResponse._();
  @$core.override
  UpdateFamilyMemberResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateFamilyMemberResponse> createRepeated() =>
      $pb.PbList<UpdateFamilyMemberResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateFamilyMemberResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateFamilyMemberResponse>(create);
  static UpdateFamilyMemberResponse? _defaultInstance;

  @$pb.TagNumber(1)
  FamilyMember get member => $_getN(0);
  @$pb.TagNumber(1)
  set member(FamilyMember value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasMember() => $_has(0);
  @$pb.TagNumber(1)
  void clearMember() => $_clearField(1);
  @$pb.TagNumber(1)
  FamilyMember ensureMember() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);
}

/// Remove Family Member
class RemoveFamilyMemberRequest extends $pb.GeneratedMessage {
  factory RemoveFamilyMemberRequest({
    $core.String? familyId,
    $core.String? memberId,
    $core.String? reason,
    $core.bool? returnBalanceToPool,
  }) {
    final result = create();
    if (familyId != null) result.familyId = familyId;
    if (memberId != null) result.memberId = memberId;
    if (reason != null) result.reason = reason;
    if (returnBalanceToPool != null)
      result.returnBalanceToPool = returnBalanceToPool;
    return result;
  }

  RemoveFamilyMemberRequest._();

  factory RemoveFamilyMemberRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RemoveFamilyMemberRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RemoveFamilyMemberRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'familyId')
    ..aOS(2, _omitFieldNames ? '' : 'memberId')
    ..aOS(3, _omitFieldNames ? '' : 'reason')
    ..aOB(4, _omitFieldNames ? '' : 'returnBalanceToPool')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RemoveFamilyMemberRequest clone() =>
      RemoveFamilyMemberRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RemoveFamilyMemberRequest copyWith(
          void Function(RemoveFamilyMemberRequest) updates) =>
      super.copyWith((message) => updates(message as RemoveFamilyMemberRequest))
          as RemoveFamilyMemberRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RemoveFamilyMemberRequest create() => RemoveFamilyMemberRequest._();
  @$core.override
  RemoveFamilyMemberRequest createEmptyInstance() => create();
  static $pb.PbList<RemoveFamilyMemberRequest> createRepeated() =>
      $pb.PbList<RemoveFamilyMemberRequest>();
  @$core.pragma('dart2js:noInline')
  static RemoveFamilyMemberRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RemoveFamilyMemberRequest>(create);
  static RemoveFamilyMemberRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get familyId => $_getSZ(0);
  @$pb.TagNumber(1)
  set familyId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFamilyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFamilyId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get memberId => $_getSZ(1);
  @$pb.TagNumber(2)
  set memberId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMemberId() => $_has(1);
  @$pb.TagNumber(2)
  void clearMemberId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get reason => $_getSZ(2);
  @$pb.TagNumber(3)
  set reason($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasReason() => $_has(2);
  @$pb.TagNumber(3)
  void clearReason() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.bool get returnBalanceToPool => $_getBF(3);
  @$pb.TagNumber(4)
  set returnBalanceToPool($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasReturnBalanceToPool() => $_has(3);
  @$pb.TagNumber(4)
  void clearReturnBalanceToPool() => $_clearField(4);
}

class RemoveFamilyMemberResponse extends $pb.GeneratedMessage {
  factory RemoveFamilyMemberResponse({
    $core.bool? success,
    $core.String? message,
    $core.double? returnedBalance,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (returnedBalance != null) result.returnedBalance = returnedBalance;
    return result;
  }

  RemoveFamilyMemberResponse._();

  factory RemoveFamilyMemberResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RemoveFamilyMemberResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RemoveFamilyMemberResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts.v1'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..a<$core.double>(
        3, _omitFieldNames ? '' : 'returnedBalance', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RemoveFamilyMemberResponse clone() =>
      RemoveFamilyMemberResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RemoveFamilyMemberResponse copyWith(
          void Function(RemoveFamilyMemberResponse) updates) =>
      super.copyWith(
              (message) => updates(message as RemoveFamilyMemberResponse))
          as RemoveFamilyMemberResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RemoveFamilyMemberResponse create() => RemoveFamilyMemberResponse._();
  @$core.override
  RemoveFamilyMemberResponse createEmptyInstance() => create();
  static $pb.PbList<RemoveFamilyMemberResponse> createRepeated() =>
      $pb.PbList<RemoveFamilyMemberResponse>();
  @$core.pragma('dart2js:noInline')
  static RemoveFamilyMemberResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RemoveFamilyMemberResponse>(create);
  static RemoveFamilyMemberResponse? _defaultInstance;

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
  $core.double get returnedBalance => $_getN(2);
  @$pb.TagNumber(3)
  set returnedBalance($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasReturnedBalance() => $_has(2);
  @$pb.TagNumber(3)
  void clearReturnedBalance() => $_clearField(3);
}

/// Accept Family Invitation
class AcceptFamilyInvitationRequest extends $pb.GeneratedMessage {
  factory AcceptFamilyInvitationRequest({
    $core.String? invitationToken,
  }) {
    final result = create();
    if (invitationToken != null) result.invitationToken = invitationToken;
    return result;
  }

  AcceptFamilyInvitationRequest._();

  factory AcceptFamilyInvitationRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AcceptFamilyInvitationRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AcceptFamilyInvitationRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'invitationToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AcceptFamilyInvitationRequest clone() =>
      AcceptFamilyInvitationRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AcceptFamilyInvitationRequest copyWith(
          void Function(AcceptFamilyInvitationRequest) updates) =>
      super.copyWith(
              (message) => updates(message as AcceptFamilyInvitationRequest))
          as AcceptFamilyInvitationRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AcceptFamilyInvitationRequest create() =>
      AcceptFamilyInvitationRequest._();
  @$core.override
  AcceptFamilyInvitationRequest createEmptyInstance() => create();
  static $pb.PbList<AcceptFamilyInvitationRequest> createRepeated() =>
      $pb.PbList<AcceptFamilyInvitationRequest>();
  @$core.pragma('dart2js:noInline')
  static AcceptFamilyInvitationRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AcceptFamilyInvitationRequest>(create);
  static AcceptFamilyInvitationRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get invitationToken => $_getSZ(0);
  @$pb.TagNumber(1)
  set invitationToken($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasInvitationToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvitationToken() => $_clearField(1);
}

class AcceptFamilyInvitationResponse extends $pb.GeneratedMessage {
  factory AcceptFamilyInvitationResponse({
    FamilyAccount? familyAccount,
    FamilyMember? member,
    $core.String? message,
  }) {
    final result = create();
    if (familyAccount != null) result.familyAccount = familyAccount;
    if (member != null) result.member = member;
    if (message != null) result.message = message;
    return result;
  }

  AcceptFamilyInvitationResponse._();

  factory AcceptFamilyInvitationResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AcceptFamilyInvitationResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AcceptFamilyInvitationResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts.v1'),
      createEmptyInstance: create)
    ..aOM<FamilyAccount>(1, _omitFieldNames ? '' : 'familyAccount',
        subBuilder: FamilyAccount.create)
    ..aOM<FamilyMember>(2, _omitFieldNames ? '' : 'member',
        subBuilder: FamilyMember.create)
    ..aOS(3, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AcceptFamilyInvitationResponse clone() =>
      AcceptFamilyInvitationResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AcceptFamilyInvitationResponse copyWith(
          void Function(AcceptFamilyInvitationResponse) updates) =>
      super.copyWith(
              (message) => updates(message as AcceptFamilyInvitationResponse))
          as AcceptFamilyInvitationResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AcceptFamilyInvitationResponse create() =>
      AcceptFamilyInvitationResponse._();
  @$core.override
  AcceptFamilyInvitationResponse createEmptyInstance() => create();
  static $pb.PbList<AcceptFamilyInvitationResponse> createRepeated() =>
      $pb.PbList<AcceptFamilyInvitationResponse>();
  @$core.pragma('dart2js:noInline')
  static AcceptFamilyInvitationResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AcceptFamilyInvitationResponse>(create);
  static AcceptFamilyInvitationResponse? _defaultInstance;

  @$pb.TagNumber(1)
  FamilyAccount get familyAccount => $_getN(0);
  @$pb.TagNumber(1)
  set familyAccount(FamilyAccount value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasFamilyAccount() => $_has(0);
  @$pb.TagNumber(1)
  void clearFamilyAccount() => $_clearField(1);
  @$pb.TagNumber(1)
  FamilyAccount ensureFamilyAccount() => $_ensure(0);

  @$pb.TagNumber(2)
  FamilyMember get member => $_getN(1);
  @$pb.TagNumber(2)
  set member(FamilyMember value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasMember() => $_has(1);
  @$pb.TagNumber(2)
  void clearMember() => $_clearField(2);
  @$pb.TagNumber(2)
  FamilyMember ensureMember() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => $_clearField(3);
}

/// Decline Family Invitation
class DeclineFamilyInvitationRequest extends $pb.GeneratedMessage {
  factory DeclineFamilyInvitationRequest({
    $core.String? invitationToken,
    $core.String? reason,
  }) {
    final result = create();
    if (invitationToken != null) result.invitationToken = invitationToken;
    if (reason != null) result.reason = reason;
    return result;
  }

  DeclineFamilyInvitationRequest._();

  factory DeclineFamilyInvitationRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeclineFamilyInvitationRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeclineFamilyInvitationRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'invitationToken')
    ..aOS(2, _omitFieldNames ? '' : 'reason')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeclineFamilyInvitationRequest clone() =>
      DeclineFamilyInvitationRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeclineFamilyInvitationRequest copyWith(
          void Function(DeclineFamilyInvitationRequest) updates) =>
      super.copyWith(
              (message) => updates(message as DeclineFamilyInvitationRequest))
          as DeclineFamilyInvitationRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeclineFamilyInvitationRequest create() =>
      DeclineFamilyInvitationRequest._();
  @$core.override
  DeclineFamilyInvitationRequest createEmptyInstance() => create();
  static $pb.PbList<DeclineFamilyInvitationRequest> createRepeated() =>
      $pb.PbList<DeclineFamilyInvitationRequest>();
  @$core.pragma('dart2js:noInline')
  static DeclineFamilyInvitationRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeclineFamilyInvitationRequest>(create);
  static DeclineFamilyInvitationRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get invitationToken => $_getSZ(0);
  @$pb.TagNumber(1)
  set invitationToken($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasInvitationToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvitationToken() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get reason => $_getSZ(1);
  @$pb.TagNumber(2)
  set reason($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasReason() => $_has(1);
  @$pb.TagNumber(2)
  void clearReason() => $_clearField(2);
}

class DeclineFamilyInvitationResponse extends $pb.GeneratedMessage {
  factory DeclineFamilyInvitationResponse({
    $core.bool? success,
    $core.String? message,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    return result;
  }

  DeclineFamilyInvitationResponse._();

  factory DeclineFamilyInvitationResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeclineFamilyInvitationResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeclineFamilyInvitationResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts.v1'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeclineFamilyInvitationResponse clone() =>
      DeclineFamilyInvitationResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeclineFamilyInvitationResponse copyWith(
          void Function(DeclineFamilyInvitationResponse) updates) =>
      super.copyWith(
              (message) => updates(message as DeclineFamilyInvitationResponse))
          as DeclineFamilyInvitationResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeclineFamilyInvitationResponse create() =>
      DeclineFamilyInvitationResponse._();
  @$core.override
  DeclineFamilyInvitationResponse createEmptyInstance() => create();
  static $pb.PbList<DeclineFamilyInvitationResponse> createRepeated() =>
      $pb.PbList<DeclineFamilyInvitationResponse>();
  @$core.pragma('dart2js:noInline')
  static DeclineFamilyInvitationResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeclineFamilyInvitationResponse>(
          create);
  static DeclineFamilyInvitationResponse? _defaultInstance;

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

/// Get Pending Invitations
class GetPendingInvitationsRequest extends $pb.GeneratedMessage {
  factory GetPendingInvitationsRequest() => create();

  GetPendingInvitationsRequest._();

  factory GetPendingInvitationsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetPendingInvitationsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetPendingInvitationsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts.v1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPendingInvitationsRequest clone() =>
      GetPendingInvitationsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPendingInvitationsRequest copyWith(
          void Function(GetPendingInvitationsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetPendingInvitationsRequest))
          as GetPendingInvitationsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPendingInvitationsRequest create() =>
      GetPendingInvitationsRequest._();
  @$core.override
  GetPendingInvitationsRequest createEmptyInstance() => create();
  static $pb.PbList<GetPendingInvitationsRequest> createRepeated() =>
      $pb.PbList<GetPendingInvitationsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetPendingInvitationsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetPendingInvitationsRequest>(create);
  static GetPendingInvitationsRequest? _defaultInstance;
}

class GetPendingInvitationsResponse extends $pb.GeneratedMessage {
  factory GetPendingInvitationsResponse({
    $core.Iterable<PendingInvitation>? invitations,
    $core.int? totalCount,
  }) {
    final result = create();
    if (invitations != null) result.invitations.addAll(invitations);
    if (totalCount != null) result.totalCount = totalCount;
    return result;
  }

  GetPendingInvitationsResponse._();

  factory GetPendingInvitationsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetPendingInvitationsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetPendingInvitationsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts.v1'),
      createEmptyInstance: create)
    ..pc<PendingInvitation>(
        1, _omitFieldNames ? '' : 'invitations', $pb.PbFieldType.PM,
        subBuilder: PendingInvitation.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'totalCount', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPendingInvitationsResponse clone() =>
      GetPendingInvitationsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPendingInvitationsResponse copyWith(
          void Function(GetPendingInvitationsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetPendingInvitationsResponse))
          as GetPendingInvitationsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPendingInvitationsResponse create() =>
      GetPendingInvitationsResponse._();
  @$core.override
  GetPendingInvitationsResponse createEmptyInstance() => create();
  static $pb.PbList<GetPendingInvitationsResponse> createRepeated() =>
      $pb.PbList<GetPendingInvitationsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetPendingInvitationsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetPendingInvitationsResponse>(create);
  static GetPendingInvitationsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<PendingInvitation> get invitations => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get totalCount => $_getIZ(1);
  @$pb.TagNumber(2)
  set totalCount($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotalCount() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalCount() => $_clearField(2);
}

/// Invitee-side history. Status defaults to "all" (omit pending+accepted to
/// keep the receivable inbox clean — use GetPendingInvitations for that).
class GetMyInvitationHistoryRequest extends $pb.GeneratedMessage {
  factory GetMyInvitationHistoryRequest({
    $core.String? statusFilter,
    $core.int? page,
    $core.int? pageSize,
  }) {
    final result = create();
    if (statusFilter != null) result.statusFilter = statusFilter;
    if (page != null) result.page = page;
    if (pageSize != null) result.pageSize = pageSize;
    return result;
  }

  GetMyInvitationHistoryRequest._();

  factory GetMyInvitationHistoryRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMyInvitationHistoryRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMyInvitationHistoryRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'statusFilter')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyInvitationHistoryRequest clone() =>
      GetMyInvitationHistoryRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyInvitationHistoryRequest copyWith(
          void Function(GetMyInvitationHistoryRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetMyInvitationHistoryRequest))
          as GetMyInvitationHistoryRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMyInvitationHistoryRequest create() =>
      GetMyInvitationHistoryRequest._();
  @$core.override
  GetMyInvitationHistoryRequest createEmptyInstance() => create();
  static $pb.PbList<GetMyInvitationHistoryRequest> createRepeated() =>
      $pb.PbList<GetMyInvitationHistoryRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMyInvitationHistoryRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMyInvitationHistoryRequest>(create);
  static GetMyInvitationHistoryRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get statusFilter => $_getSZ(0);
  @$pb.TagNumber(1)
  set statusFilter($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasStatusFilter() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatusFilter() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get page => $_getIZ(1);
  @$pb.TagNumber(2)
  set page($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPage() => $_has(1);
  @$pb.TagNumber(2)
  void clearPage() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get pageSize => $_getIZ(2);
  @$pb.TagNumber(3)
  set pageSize($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPageSize() => $_has(2);
  @$pb.TagNumber(3)
  void clearPageSize() => $_clearField(3);
}

class InvitationHistoryEntry extends $pb.GeneratedMessage {
  factory InvitationHistoryEntry({
    $core.String? invitationToken,
    $core.String? familyId,
    $core.String? familyName,
    $core.String? creatorName,
    $core.String? creatorAvatar,
    $core.String? invitedBy,
    $core.String? invitationStatus,
    $core.double? initialAllocation,
    $core.double? dailyLimit,
    $core.double? monthlyLimit,
    $core.String? invitationMethod,
    $core.String? invitationDestination,
    $core.String? createdAt,
    $core.String? expiresAt,
    $core.String? respondedAt,
  }) {
    final result = create();
    if (invitationToken != null) result.invitationToken = invitationToken;
    if (familyId != null) result.familyId = familyId;
    if (familyName != null) result.familyName = familyName;
    if (creatorName != null) result.creatorName = creatorName;
    if (creatorAvatar != null) result.creatorAvatar = creatorAvatar;
    if (invitedBy != null) result.invitedBy = invitedBy;
    if (invitationStatus != null) result.invitationStatus = invitationStatus;
    if (initialAllocation != null) result.initialAllocation = initialAllocation;
    if (dailyLimit != null) result.dailyLimit = dailyLimit;
    if (monthlyLimit != null) result.monthlyLimit = monthlyLimit;
    if (invitationMethod != null) result.invitationMethod = invitationMethod;
    if (invitationDestination != null)
      result.invitationDestination = invitationDestination;
    if (createdAt != null) result.createdAt = createdAt;
    if (expiresAt != null) result.expiresAt = expiresAt;
    if (respondedAt != null) result.respondedAt = respondedAt;
    return result;
  }

  InvitationHistoryEntry._();

  factory InvitationHistoryEntry.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InvitationHistoryEntry.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InvitationHistoryEntry',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'invitationToken')
    ..aOS(2, _omitFieldNames ? '' : 'familyId')
    ..aOS(3, _omitFieldNames ? '' : 'familyName')
    ..aOS(4, _omitFieldNames ? '' : 'creatorName')
    ..aOS(5, _omitFieldNames ? '' : 'creatorAvatar')
    ..aOS(6, _omitFieldNames ? '' : 'invitedBy')
    ..aOS(7, _omitFieldNames ? '' : 'invitationStatus')
    ..a<$core.double>(
        8, _omitFieldNames ? '' : 'initialAllocation', $pb.PbFieldType.OD)
    ..a<$core.double>(
        9, _omitFieldNames ? '' : 'dailyLimit', $pb.PbFieldType.OD)
    ..a<$core.double>(
        10, _omitFieldNames ? '' : 'monthlyLimit', $pb.PbFieldType.OD)
    ..aOS(11, _omitFieldNames ? '' : 'invitationMethod')
    ..aOS(12, _omitFieldNames ? '' : 'invitationDestination')
    ..aOS(13, _omitFieldNames ? '' : 'createdAt')
    ..aOS(14, _omitFieldNames ? '' : 'expiresAt')
    ..aOS(15, _omitFieldNames ? '' : 'respondedAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InvitationHistoryEntry clone() =>
      InvitationHistoryEntry()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InvitationHistoryEntry copyWith(
          void Function(InvitationHistoryEntry) updates) =>
      super.copyWith((message) => updates(message as InvitationHistoryEntry))
          as InvitationHistoryEntry;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InvitationHistoryEntry create() => InvitationHistoryEntry._();
  @$core.override
  InvitationHistoryEntry createEmptyInstance() => create();
  static $pb.PbList<InvitationHistoryEntry> createRepeated() =>
      $pb.PbList<InvitationHistoryEntry>();
  @$core.pragma('dart2js:noInline')
  static InvitationHistoryEntry getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InvitationHistoryEntry>(create);
  static InvitationHistoryEntry? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get invitationToken => $_getSZ(0);
  @$pb.TagNumber(1)
  set invitationToken($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasInvitationToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvitationToken() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get familyId => $_getSZ(1);
  @$pb.TagNumber(2)
  set familyId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasFamilyId() => $_has(1);
  @$pb.TagNumber(2)
  void clearFamilyId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get familyName => $_getSZ(2);
  @$pb.TagNumber(3)
  set familyName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasFamilyName() => $_has(2);
  @$pb.TagNumber(3)
  void clearFamilyName() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get creatorName => $_getSZ(3);
  @$pb.TagNumber(4)
  set creatorName($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCreatorName() => $_has(3);
  @$pb.TagNumber(4)
  void clearCreatorName() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get creatorAvatar => $_getSZ(4);
  @$pb.TagNumber(5)
  set creatorAvatar($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCreatorAvatar() => $_has(4);
  @$pb.TagNumber(5)
  void clearCreatorAvatar() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get invitedBy => $_getSZ(5);
  @$pb.TagNumber(6)
  set invitedBy($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasInvitedBy() => $_has(5);
  @$pb.TagNumber(6)
  void clearInvitedBy() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get invitationStatus => $_getSZ(6);
  @$pb.TagNumber(7)
  set invitationStatus($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasInvitationStatus() => $_has(6);
  @$pb.TagNumber(7)
  void clearInvitationStatus() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.double get initialAllocation => $_getN(7);
  @$pb.TagNumber(8)
  set initialAllocation($core.double value) => $_setDouble(7, value);
  @$pb.TagNumber(8)
  $core.bool hasInitialAllocation() => $_has(7);
  @$pb.TagNumber(8)
  void clearInitialAllocation() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.double get dailyLimit => $_getN(8);
  @$pb.TagNumber(9)
  set dailyLimit($core.double value) => $_setDouble(8, value);
  @$pb.TagNumber(9)
  $core.bool hasDailyLimit() => $_has(8);
  @$pb.TagNumber(9)
  void clearDailyLimit() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.double get monthlyLimit => $_getN(9);
  @$pb.TagNumber(10)
  set monthlyLimit($core.double value) => $_setDouble(9, value);
  @$pb.TagNumber(10)
  $core.bool hasMonthlyLimit() => $_has(9);
  @$pb.TagNumber(10)
  void clearMonthlyLimit() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get invitationMethod => $_getSZ(10);
  @$pb.TagNumber(11)
  set invitationMethod($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasInvitationMethod() => $_has(10);
  @$pb.TagNumber(11)
  void clearInvitationMethod() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get invitationDestination => $_getSZ(11);
  @$pb.TagNumber(12)
  set invitationDestination($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasInvitationDestination() => $_has(11);
  @$pb.TagNumber(12)
  void clearInvitationDestination() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get createdAt => $_getSZ(12);
  @$pb.TagNumber(13)
  set createdAt($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasCreatedAt() => $_has(12);
  @$pb.TagNumber(13)
  void clearCreatedAt() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.String get expiresAt => $_getSZ(13);
  @$pb.TagNumber(14)
  set expiresAt($core.String value) => $_setString(13, value);
  @$pb.TagNumber(14)
  $core.bool hasExpiresAt() => $_has(13);
  @$pb.TagNumber(14)
  void clearExpiresAt() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.String get respondedAt => $_getSZ(14);
  @$pb.TagNumber(15)
  set respondedAt($core.String value) => $_setString(14, value);
  @$pb.TagNumber(15)
  $core.bool hasRespondedAt() => $_has(14);
  @$pb.TagNumber(15)
  void clearRespondedAt() => $_clearField(15);
}

class GetMyInvitationHistoryResponse extends $pb.GeneratedMessage {
  factory GetMyInvitationHistoryResponse({
    $core.Iterable<InvitationHistoryEntry>? entries,
    $core.int? totalCount,
    $core.int? page,
    $core.int? pageSize,
    $core.int? totalPages,
  }) {
    final result = create();
    if (entries != null) result.entries.addAll(entries);
    if (totalCount != null) result.totalCount = totalCount;
    if (page != null) result.page = page;
    if (pageSize != null) result.pageSize = pageSize;
    if (totalPages != null) result.totalPages = totalPages;
    return result;
  }

  GetMyInvitationHistoryResponse._();

  factory GetMyInvitationHistoryResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMyInvitationHistoryResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMyInvitationHistoryResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts.v1'),
      createEmptyInstance: create)
    ..pc<InvitationHistoryEntry>(
        1, _omitFieldNames ? '' : 'entries', $pb.PbFieldType.PM,
        subBuilder: InvitationHistoryEntry.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'totalCount', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'totalPages', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyInvitationHistoryResponse clone() =>
      GetMyInvitationHistoryResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyInvitationHistoryResponse copyWith(
          void Function(GetMyInvitationHistoryResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetMyInvitationHistoryResponse))
          as GetMyInvitationHistoryResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMyInvitationHistoryResponse create() =>
      GetMyInvitationHistoryResponse._();
  @$core.override
  GetMyInvitationHistoryResponse createEmptyInstance() => create();
  static $pb.PbList<GetMyInvitationHistoryResponse> createRepeated() =>
      $pb.PbList<GetMyInvitationHistoryResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMyInvitationHistoryResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMyInvitationHistoryResponse>(create);
  static GetMyInvitationHistoryResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<InvitationHistoryEntry> get entries => $_getList(0);

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

  @$pb.TagNumber(5)
  $core.int get totalPages => $_getIZ(4);
  @$pb.TagNumber(5)
  set totalPages($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTotalPages() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotalPages() => $_clearField(5);
}

/// Inviter-side history. Returns invitations the caller has sent across
/// every family they admin. Optional filter narrows to a single family.
class GetSentInvitationsRequest extends $pb.GeneratedMessage {
  factory GetSentInvitationsRequest({
    $core.String? familyId,
    $core.String? statusFilter,
    $core.int? page,
    $core.int? pageSize,
  }) {
    final result = create();
    if (familyId != null) result.familyId = familyId;
    if (statusFilter != null) result.statusFilter = statusFilter;
    if (page != null) result.page = page;
    if (pageSize != null) result.pageSize = pageSize;
    return result;
  }

  GetSentInvitationsRequest._();

  factory GetSentInvitationsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetSentInvitationsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetSentInvitationsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'familyId')
    ..aOS(2, _omitFieldNames ? '' : 'statusFilter')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSentInvitationsRequest clone() =>
      GetSentInvitationsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSentInvitationsRequest copyWith(
          void Function(GetSentInvitationsRequest) updates) =>
      super.copyWith((message) => updates(message as GetSentInvitationsRequest))
          as GetSentInvitationsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSentInvitationsRequest create() => GetSentInvitationsRequest._();
  @$core.override
  GetSentInvitationsRequest createEmptyInstance() => create();
  static $pb.PbList<GetSentInvitationsRequest> createRepeated() =>
      $pb.PbList<GetSentInvitationsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetSentInvitationsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetSentInvitationsRequest>(create);
  static GetSentInvitationsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get familyId => $_getSZ(0);
  @$pb.TagNumber(1)
  set familyId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFamilyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFamilyId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get statusFilter => $_getSZ(1);
  @$pb.TagNumber(2)
  set statusFilter($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasStatusFilter() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatusFilter() => $_clearField(2);

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

class SentInvitationEntry extends $pb.GeneratedMessage {
  factory SentInvitationEntry({
    $core.String? memberId,
    $core.String? familyId,
    $core.String? familyName,
    $core.String? invitationMethod,
    $core.String? invitationDestination,
    $core.String? invitationStatus,
    $core.String? invitedUserId,
    $core.String? invitedUserName,
    $core.String? invitedUserAvatar,
    $core.double? initialAllocation,
    $core.double? dailyLimit,
    $core.double? monthlyLimit,
    $core.String? role,
    $core.String? createdAt,
    $core.String? expiresAt,
    $core.String? respondedAt,
  }) {
    final result = create();
    if (memberId != null) result.memberId = memberId;
    if (familyId != null) result.familyId = familyId;
    if (familyName != null) result.familyName = familyName;
    if (invitationMethod != null) result.invitationMethod = invitationMethod;
    if (invitationDestination != null)
      result.invitationDestination = invitationDestination;
    if (invitationStatus != null) result.invitationStatus = invitationStatus;
    if (invitedUserId != null) result.invitedUserId = invitedUserId;
    if (invitedUserName != null) result.invitedUserName = invitedUserName;
    if (invitedUserAvatar != null) result.invitedUserAvatar = invitedUserAvatar;
    if (initialAllocation != null) result.initialAllocation = initialAllocation;
    if (dailyLimit != null) result.dailyLimit = dailyLimit;
    if (monthlyLimit != null) result.monthlyLimit = monthlyLimit;
    if (role != null) result.role = role;
    if (createdAt != null) result.createdAt = createdAt;
    if (expiresAt != null) result.expiresAt = expiresAt;
    if (respondedAt != null) result.respondedAt = respondedAt;
    return result;
  }

  SentInvitationEntry._();

  factory SentInvitationEntry.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SentInvitationEntry.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SentInvitationEntry',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'memberId')
    ..aOS(2, _omitFieldNames ? '' : 'familyId')
    ..aOS(3, _omitFieldNames ? '' : 'familyName')
    ..aOS(4, _omitFieldNames ? '' : 'invitationMethod')
    ..aOS(5, _omitFieldNames ? '' : 'invitationDestination')
    ..aOS(6, _omitFieldNames ? '' : 'invitationStatus')
    ..aOS(7, _omitFieldNames ? '' : 'invitedUserId')
    ..aOS(8, _omitFieldNames ? '' : 'invitedUserName')
    ..aOS(9, _omitFieldNames ? '' : 'invitedUserAvatar')
    ..a<$core.double>(
        10, _omitFieldNames ? '' : 'initialAllocation', $pb.PbFieldType.OD)
    ..a<$core.double>(
        11, _omitFieldNames ? '' : 'dailyLimit', $pb.PbFieldType.OD)
    ..a<$core.double>(
        12, _omitFieldNames ? '' : 'monthlyLimit', $pb.PbFieldType.OD)
    ..aOS(13, _omitFieldNames ? '' : 'role')
    ..aOS(14, _omitFieldNames ? '' : 'createdAt')
    ..aOS(15, _omitFieldNames ? '' : 'expiresAt')
    ..aOS(16, _omitFieldNames ? '' : 'respondedAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SentInvitationEntry clone() => SentInvitationEntry()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SentInvitationEntry copyWith(void Function(SentInvitationEntry) updates) =>
      super.copyWith((message) => updates(message as SentInvitationEntry))
          as SentInvitationEntry;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SentInvitationEntry create() => SentInvitationEntry._();
  @$core.override
  SentInvitationEntry createEmptyInstance() => create();
  static $pb.PbList<SentInvitationEntry> createRepeated() =>
      $pb.PbList<SentInvitationEntry>();
  @$core.pragma('dart2js:noInline')
  static SentInvitationEntry getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SentInvitationEntry>(create);
  static SentInvitationEntry? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get memberId => $_getSZ(0);
  @$pb.TagNumber(1)
  set memberId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMemberId() => $_has(0);
  @$pb.TagNumber(1)
  void clearMemberId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get familyId => $_getSZ(1);
  @$pb.TagNumber(2)
  set familyId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasFamilyId() => $_has(1);
  @$pb.TagNumber(2)
  void clearFamilyId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get familyName => $_getSZ(2);
  @$pb.TagNumber(3)
  set familyName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasFamilyName() => $_has(2);
  @$pb.TagNumber(3)
  void clearFamilyName() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get invitationMethod => $_getSZ(3);
  @$pb.TagNumber(4)
  set invitationMethod($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasInvitationMethod() => $_has(3);
  @$pb.TagNumber(4)
  void clearInvitationMethod() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get invitationDestination => $_getSZ(4);
  @$pb.TagNumber(5)
  set invitationDestination($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasInvitationDestination() => $_has(4);
  @$pb.TagNumber(5)
  void clearInvitationDestination() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get invitationStatus => $_getSZ(5);
  @$pb.TagNumber(6)
  set invitationStatus($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasInvitationStatus() => $_has(5);
  @$pb.TagNumber(6)
  void clearInvitationStatus() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get invitedUserId => $_getSZ(6);
  @$pb.TagNumber(7)
  set invitedUserId($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasInvitedUserId() => $_has(6);
  @$pb.TagNumber(7)
  void clearInvitedUserId() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get invitedUserName => $_getSZ(7);
  @$pb.TagNumber(8)
  set invitedUserName($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasInvitedUserName() => $_has(7);
  @$pb.TagNumber(8)
  void clearInvitedUserName() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get invitedUserAvatar => $_getSZ(8);
  @$pb.TagNumber(9)
  set invitedUserAvatar($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasInvitedUserAvatar() => $_has(8);
  @$pb.TagNumber(9)
  void clearInvitedUserAvatar() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.double get initialAllocation => $_getN(9);
  @$pb.TagNumber(10)
  set initialAllocation($core.double value) => $_setDouble(9, value);
  @$pb.TagNumber(10)
  $core.bool hasInitialAllocation() => $_has(9);
  @$pb.TagNumber(10)
  void clearInitialAllocation() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.double get dailyLimit => $_getN(10);
  @$pb.TagNumber(11)
  set dailyLimit($core.double value) => $_setDouble(10, value);
  @$pb.TagNumber(11)
  $core.bool hasDailyLimit() => $_has(10);
  @$pb.TagNumber(11)
  void clearDailyLimit() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.double get monthlyLimit => $_getN(11);
  @$pb.TagNumber(12)
  set monthlyLimit($core.double value) => $_setDouble(11, value);
  @$pb.TagNumber(12)
  $core.bool hasMonthlyLimit() => $_has(11);
  @$pb.TagNumber(12)
  void clearMonthlyLimit() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get role => $_getSZ(12);
  @$pb.TagNumber(13)
  set role($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasRole() => $_has(12);
  @$pb.TagNumber(13)
  void clearRole() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.String get createdAt => $_getSZ(13);
  @$pb.TagNumber(14)
  set createdAt($core.String value) => $_setString(13, value);
  @$pb.TagNumber(14)
  $core.bool hasCreatedAt() => $_has(13);
  @$pb.TagNumber(14)
  void clearCreatedAt() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.String get expiresAt => $_getSZ(14);
  @$pb.TagNumber(15)
  set expiresAt($core.String value) => $_setString(14, value);
  @$pb.TagNumber(15)
  $core.bool hasExpiresAt() => $_has(14);
  @$pb.TagNumber(15)
  void clearExpiresAt() => $_clearField(15);

  @$pb.TagNumber(16)
  $core.String get respondedAt => $_getSZ(15);
  @$pb.TagNumber(16)
  set respondedAt($core.String value) => $_setString(15, value);
  @$pb.TagNumber(16)
  $core.bool hasRespondedAt() => $_has(15);
  @$pb.TagNumber(16)
  void clearRespondedAt() => $_clearField(16);
}

class GetSentInvitationsResponse extends $pb.GeneratedMessage {
  factory GetSentInvitationsResponse({
    $core.Iterable<SentInvitationEntry>? entries,
    $core.int? totalCount,
    $core.int? page,
    $core.int? pageSize,
    $core.int? totalPages,
  }) {
    final result = create();
    if (entries != null) result.entries.addAll(entries);
    if (totalCount != null) result.totalCount = totalCount;
    if (page != null) result.page = page;
    if (pageSize != null) result.pageSize = pageSize;
    if (totalPages != null) result.totalPages = totalPages;
    return result;
  }

  GetSentInvitationsResponse._();

  factory GetSentInvitationsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetSentInvitationsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetSentInvitationsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts.v1'),
      createEmptyInstance: create)
    ..pc<SentInvitationEntry>(
        1, _omitFieldNames ? '' : 'entries', $pb.PbFieldType.PM,
        subBuilder: SentInvitationEntry.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'totalCount', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'totalPages', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSentInvitationsResponse clone() =>
      GetSentInvitationsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSentInvitationsResponse copyWith(
          void Function(GetSentInvitationsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetSentInvitationsResponse))
          as GetSentInvitationsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSentInvitationsResponse create() => GetSentInvitationsResponse._();
  @$core.override
  GetSentInvitationsResponse createEmptyInstance() => create();
  static $pb.PbList<GetSentInvitationsResponse> createRepeated() =>
      $pb.PbList<GetSentInvitationsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetSentInvitationsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetSentInvitationsResponse>(create);
  static GetSentInvitationsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<SentInvitationEntry> get entries => $_getList(0);

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

  @$pb.TagNumber(5)
  $core.int get totalPages => $_getIZ(4);
  @$pb.TagNumber(5)
  set totalPages($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTotalPages() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotalPages() => $_clearField(5);
}

/// Get Family Transactions
class GetFamilyTransactionsRequest extends $pb.GeneratedMessage {
  factory GetFamilyTransactionsRequest({
    $core.String? familyId,
    $core.String? memberId,
    $core.String? type,
    $core.int? page,
    $core.int? pageSize,
    $core.String? startDate,
    $core.String? endDate,
  }) {
    final result = create();
    if (familyId != null) result.familyId = familyId;
    if (memberId != null) result.memberId = memberId;
    if (type != null) result.type = type;
    if (page != null) result.page = page;
    if (pageSize != null) result.pageSize = pageSize;
    if (startDate != null) result.startDate = startDate;
    if (endDate != null) result.endDate = endDate;
    return result;
  }

  GetFamilyTransactionsRequest._();

  factory GetFamilyTransactionsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetFamilyTransactionsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetFamilyTransactionsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'familyId')
    ..aOS(2, _omitFieldNames ? '' : 'memberId')
    ..aOS(3, _omitFieldNames ? '' : 'type')
    ..a<$core.int>(4, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOS(6, _omitFieldNames ? '' : 'startDate')
    ..aOS(7, _omitFieldNames ? '' : 'endDate')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetFamilyTransactionsRequest clone() =>
      GetFamilyTransactionsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetFamilyTransactionsRequest copyWith(
          void Function(GetFamilyTransactionsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetFamilyTransactionsRequest))
          as GetFamilyTransactionsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetFamilyTransactionsRequest create() =>
      GetFamilyTransactionsRequest._();
  @$core.override
  GetFamilyTransactionsRequest createEmptyInstance() => create();
  static $pb.PbList<GetFamilyTransactionsRequest> createRepeated() =>
      $pb.PbList<GetFamilyTransactionsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetFamilyTransactionsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetFamilyTransactionsRequest>(create);
  static GetFamilyTransactionsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get familyId => $_getSZ(0);
  @$pb.TagNumber(1)
  set familyId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFamilyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFamilyId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get memberId => $_getSZ(1);
  @$pb.TagNumber(2)
  set memberId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMemberId() => $_has(1);
  @$pb.TagNumber(2)
  void clearMemberId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get type => $_getSZ(2);
  @$pb.TagNumber(3)
  set type($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasType() => $_has(2);
  @$pb.TagNumber(3)
  void clearType() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get page => $_getIZ(3);
  @$pb.TagNumber(4)
  set page($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPage() => $_has(3);
  @$pb.TagNumber(4)
  void clearPage() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get pageSize => $_getIZ(4);
  @$pb.TagNumber(5)
  set pageSize($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasPageSize() => $_has(4);
  @$pb.TagNumber(5)
  void clearPageSize() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get startDate => $_getSZ(5);
  @$pb.TagNumber(6)
  set startDate($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasStartDate() => $_has(5);
  @$pb.TagNumber(6)
  void clearStartDate() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get endDate => $_getSZ(6);
  @$pb.TagNumber(7)
  set endDate($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasEndDate() => $_has(6);
  @$pb.TagNumber(7)
  void clearEndDate() => $_clearField(7);
}

class GetFamilyTransactionsResponse extends $pb.GeneratedMessage {
  factory GetFamilyTransactionsResponse({
    $core.Iterable<FamilyTransaction>? transactions,
    $core.int? totalCount,
    $core.int? page,
    $core.int? pageSize,
    $core.int? totalPages,
  }) {
    final result = create();
    if (transactions != null) result.transactions.addAll(transactions);
    if (totalCount != null) result.totalCount = totalCount;
    if (page != null) result.page = page;
    if (pageSize != null) result.pageSize = pageSize;
    if (totalPages != null) result.totalPages = totalPages;
    return result;
  }

  GetFamilyTransactionsResponse._();

  factory GetFamilyTransactionsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetFamilyTransactionsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetFamilyTransactionsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts.v1'),
      createEmptyInstance: create)
    ..pc<FamilyTransaction>(
        1, _omitFieldNames ? '' : 'transactions', $pb.PbFieldType.PM,
        subBuilder: FamilyTransaction.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'totalCount', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'totalPages', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetFamilyTransactionsResponse clone() =>
      GetFamilyTransactionsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetFamilyTransactionsResponse copyWith(
          void Function(GetFamilyTransactionsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetFamilyTransactionsResponse))
          as GetFamilyTransactionsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetFamilyTransactionsResponse create() =>
      GetFamilyTransactionsResponse._();
  @$core.override
  GetFamilyTransactionsResponse createEmptyInstance() => create();
  static $pb.PbList<GetFamilyTransactionsResponse> createRepeated() =>
      $pb.PbList<GetFamilyTransactionsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetFamilyTransactionsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetFamilyTransactionsResponse>(create);
  static GetFamilyTransactionsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<FamilyTransaction> get transactions => $_getList(0);

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

  @$pb.TagNumber(5)
  $core.int get totalPages => $_getIZ(4);
  @$pb.TagNumber(5)
  set totalPages($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTotalPages() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotalPages() => $_clearField(5);
}

/// Allocate Funds
class AllocateFundsRequest extends $pb.GeneratedMessage {
  factory AllocateFundsRequest({
    $core.String? familyId,
    $core.String? memberId,
    $core.double? amount,
    $core.String? description,
    $core.String? idempotencyKey,
  }) {
    final result = create();
    if (familyId != null) result.familyId = familyId;
    if (memberId != null) result.memberId = memberId;
    if (amount != null) result.amount = amount;
    if (description != null) result.description = description;
    if (idempotencyKey != null) result.idempotencyKey = idempotencyKey;
    return result;
  }

  AllocateFundsRequest._();

  factory AllocateFundsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AllocateFundsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AllocateFundsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'familyId')
    ..aOS(2, _omitFieldNames ? '' : 'memberId')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(4, _omitFieldNames ? '' : 'description')
    ..aOS(5, _omitFieldNames ? '' : 'idempotencyKey')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AllocateFundsRequest clone() =>
      AllocateFundsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AllocateFundsRequest copyWith(void Function(AllocateFundsRequest) updates) =>
      super.copyWith((message) => updates(message as AllocateFundsRequest))
          as AllocateFundsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AllocateFundsRequest create() => AllocateFundsRequest._();
  @$core.override
  AllocateFundsRequest createEmptyInstance() => create();
  static $pb.PbList<AllocateFundsRequest> createRepeated() =>
      $pb.PbList<AllocateFundsRequest>();
  @$core.pragma('dart2js:noInline')
  static AllocateFundsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AllocateFundsRequest>(create);
  static AllocateFundsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get familyId => $_getSZ(0);
  @$pb.TagNumber(1)
  set familyId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFamilyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFamilyId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get memberId => $_getSZ(1);
  @$pb.TagNumber(2)
  set memberId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMemberId() => $_has(1);
  @$pb.TagNumber(2)
  void clearMemberId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get amount => $_getN(2);
  @$pb.TagNumber(3)
  set amount($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get description => $_getSZ(3);
  @$pb.TagNumber(4)
  set description($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDescription() => $_has(3);
  @$pb.TagNumber(4)
  void clearDescription() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get idempotencyKey => $_getSZ(4);
  @$pb.TagNumber(5)
  set idempotencyKey($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasIdempotencyKey() => $_has(4);
  @$pb.TagNumber(5)
  void clearIdempotencyKey() => $_clearField(5);
}

class AllocateFundsResponse extends $pb.GeneratedMessage {
  factory AllocateFundsResponse({
    FamilyMember? member,
    FamilyTransaction? transaction,
    $core.double? remainingPoolBalance,
    $core.String? message,
  }) {
    final result = create();
    if (member != null) result.member = member;
    if (transaction != null) result.transaction = transaction;
    if (remainingPoolBalance != null)
      result.remainingPoolBalance = remainingPoolBalance;
    if (message != null) result.message = message;
    return result;
  }

  AllocateFundsResponse._();

  factory AllocateFundsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AllocateFundsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AllocateFundsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts.v1'),
      createEmptyInstance: create)
    ..aOM<FamilyMember>(1, _omitFieldNames ? '' : 'member',
        subBuilder: FamilyMember.create)
    ..aOM<FamilyTransaction>(2, _omitFieldNames ? '' : 'transaction',
        subBuilder: FamilyTransaction.create)
    ..a<$core.double>(
        3, _omitFieldNames ? '' : 'remainingPoolBalance', $pb.PbFieldType.OD)
    ..aOS(4, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AllocateFundsResponse clone() =>
      AllocateFundsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AllocateFundsResponse copyWith(
          void Function(AllocateFundsResponse) updates) =>
      super.copyWith((message) => updates(message as AllocateFundsResponse))
          as AllocateFundsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AllocateFundsResponse create() => AllocateFundsResponse._();
  @$core.override
  AllocateFundsResponse createEmptyInstance() => create();
  static $pb.PbList<AllocateFundsResponse> createRepeated() =>
      $pb.PbList<AllocateFundsResponse>();
  @$core.pragma('dart2js:noInline')
  static AllocateFundsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AllocateFundsResponse>(create);
  static AllocateFundsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  FamilyMember get member => $_getN(0);
  @$pb.TagNumber(1)
  set member(FamilyMember value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasMember() => $_has(0);
  @$pb.TagNumber(1)
  void clearMember() => $_clearField(1);
  @$pb.TagNumber(1)
  FamilyMember ensureMember() => $_ensure(0);

  @$pb.TagNumber(2)
  FamilyTransaction get transaction => $_getN(1);
  @$pb.TagNumber(2)
  set transaction(FamilyTransaction value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasTransaction() => $_has(1);
  @$pb.TagNumber(2)
  void clearTransaction() => $_clearField(2);
  @$pb.TagNumber(2)
  FamilyTransaction ensureTransaction() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.double get remainingPoolBalance => $_getN(2);
  @$pb.TagNumber(3)
  set remainingPoolBalance($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasRemainingPoolBalance() => $_has(2);
  @$pb.TagNumber(3)
  void clearRemainingPoolBalance() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get message => $_getSZ(3);
  @$pb.TagNumber(4)
  set message($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMessage() => $_has(3);
  @$pb.TagNumber(4)
  void clearMessage() => $_clearField(4);
}

/// Generate Member Card
class GenerateMemberCardRequest extends $pb.GeneratedMessage {
  factory GenerateMemberCardRequest({
    $core.String? familyId,
    $core.String? memberId,
    $core.String? cardName,
  }) {
    final result = create();
    if (familyId != null) result.familyId = familyId;
    if (memberId != null) result.memberId = memberId;
    if (cardName != null) result.cardName = cardName;
    return result;
  }

  GenerateMemberCardRequest._();

  factory GenerateMemberCardRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GenerateMemberCardRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GenerateMemberCardRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'familyId')
    ..aOS(2, _omitFieldNames ? '' : 'memberId')
    ..aOS(3, _omitFieldNames ? '' : 'cardName')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GenerateMemberCardRequest clone() =>
      GenerateMemberCardRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GenerateMemberCardRequest copyWith(
          void Function(GenerateMemberCardRequest) updates) =>
      super.copyWith((message) => updates(message as GenerateMemberCardRequest))
          as GenerateMemberCardRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GenerateMemberCardRequest create() => GenerateMemberCardRequest._();
  @$core.override
  GenerateMemberCardRequest createEmptyInstance() => create();
  static $pb.PbList<GenerateMemberCardRequest> createRepeated() =>
      $pb.PbList<GenerateMemberCardRequest>();
  @$core.pragma('dart2js:noInline')
  static GenerateMemberCardRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GenerateMemberCardRequest>(create);
  static GenerateMemberCardRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get familyId => $_getSZ(0);
  @$pb.TagNumber(1)
  set familyId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFamilyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFamilyId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get memberId => $_getSZ(1);
  @$pb.TagNumber(2)
  set memberId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMemberId() => $_has(1);
  @$pb.TagNumber(2)
  void clearMemberId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get cardName => $_getSZ(2);
  @$pb.TagNumber(3)
  set cardName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCardName() => $_has(2);
  @$pb.TagNumber(3)
  void clearCardName() => $_clearField(3);
}

class GenerateMemberCardResponse extends $pb.GeneratedMessage {
  factory GenerateMemberCardResponse({
    $1.AccountCard? card,
    FamilyMember? member,
    $core.String? message,
  }) {
    final result = create();
    if (card != null) result.card = card;
    if (member != null) result.member = member;
    if (message != null) result.message = message;
    return result;
  }

  GenerateMemberCardResponse._();

  factory GenerateMemberCardResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GenerateMemberCardResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GenerateMemberCardResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts.v1'),
      createEmptyInstance: create)
    ..aOM<$1.AccountCard>(1, _omitFieldNames ? '' : 'card',
        subBuilder: $1.AccountCard.create)
    ..aOM<FamilyMember>(2, _omitFieldNames ? '' : 'member',
        subBuilder: FamilyMember.create)
    ..aOS(3, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GenerateMemberCardResponse clone() =>
      GenerateMemberCardResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GenerateMemberCardResponse copyWith(
          void Function(GenerateMemberCardResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GenerateMemberCardResponse))
          as GenerateMemberCardResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GenerateMemberCardResponse create() => GenerateMemberCardResponse._();
  @$core.override
  GenerateMemberCardResponse createEmptyInstance() => create();
  static $pb.PbList<GenerateMemberCardResponse> createRepeated() =>
      $pb.PbList<GenerateMemberCardResponse>();
  @$core.pragma('dart2js:noInline')
  static GenerateMemberCardResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GenerateMemberCardResponse>(create);
  static GenerateMemberCardResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $1.AccountCard get card => $_getN(0);
  @$pb.TagNumber(1)
  set card($1.AccountCard value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasCard() => $_has(0);
  @$pb.TagNumber(1)
  void clearCard() => $_clearField(1);
  @$pb.TagNumber(1)
  $1.AccountCard ensureCard() => $_ensure(0);

  @$pb.TagNumber(2)
  FamilyMember get member => $_getN(1);
  @$pb.TagNumber(2)
  set member(FamilyMember value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasMember() => $_has(1);
  @$pb.TagNumber(2)
  void clearMember() => $_clearField(2);
  @$pb.TagNumber(2)
  FamilyMember ensureMember() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => $_clearField(3);
}

/// Freeze Family Account
class FreezeFamilyAccountRequest extends $pb.GeneratedMessage {
  factory FreezeFamilyAccountRequest({
    $core.String? familyId,
    $core.String? reason,
  }) {
    final result = create();
    if (familyId != null) result.familyId = familyId;
    if (reason != null) result.reason = reason;
    return result;
  }

  FreezeFamilyAccountRequest._();

  factory FreezeFamilyAccountRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FreezeFamilyAccountRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FreezeFamilyAccountRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'familyId')
    ..aOS(2, _omitFieldNames ? '' : 'reason')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FreezeFamilyAccountRequest clone() =>
      FreezeFamilyAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FreezeFamilyAccountRequest copyWith(
          void Function(FreezeFamilyAccountRequest) updates) =>
      super.copyWith(
              (message) => updates(message as FreezeFamilyAccountRequest))
          as FreezeFamilyAccountRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FreezeFamilyAccountRequest create() => FreezeFamilyAccountRequest._();
  @$core.override
  FreezeFamilyAccountRequest createEmptyInstance() => create();
  static $pb.PbList<FreezeFamilyAccountRequest> createRepeated() =>
      $pb.PbList<FreezeFamilyAccountRequest>();
  @$core.pragma('dart2js:noInline')
  static FreezeFamilyAccountRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FreezeFamilyAccountRequest>(create);
  static FreezeFamilyAccountRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get familyId => $_getSZ(0);
  @$pb.TagNumber(1)
  set familyId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFamilyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFamilyId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get reason => $_getSZ(1);
  @$pb.TagNumber(2)
  set reason($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasReason() => $_has(1);
  @$pb.TagNumber(2)
  void clearReason() => $_clearField(2);
}

class FreezeFamilyAccountResponse extends $pb.GeneratedMessage {
  factory FreezeFamilyAccountResponse({
    $core.bool? success,
    $core.String? message,
    FamilyAccount? familyAccount,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (familyAccount != null) result.familyAccount = familyAccount;
    return result;
  }

  FreezeFamilyAccountResponse._();

  factory FreezeFamilyAccountResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FreezeFamilyAccountResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FreezeFamilyAccountResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts.v1'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<FamilyAccount>(3, _omitFieldNames ? '' : 'familyAccount',
        subBuilder: FamilyAccount.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FreezeFamilyAccountResponse clone() =>
      FreezeFamilyAccountResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FreezeFamilyAccountResponse copyWith(
          void Function(FreezeFamilyAccountResponse) updates) =>
      super.copyWith(
              (message) => updates(message as FreezeFamilyAccountResponse))
          as FreezeFamilyAccountResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FreezeFamilyAccountResponse create() =>
      FreezeFamilyAccountResponse._();
  @$core.override
  FreezeFamilyAccountResponse createEmptyInstance() => create();
  static $pb.PbList<FreezeFamilyAccountResponse> createRepeated() =>
      $pb.PbList<FreezeFamilyAccountResponse>();
  @$core.pragma('dart2js:noInline')
  static FreezeFamilyAccountResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FreezeFamilyAccountResponse>(create);
  static FreezeFamilyAccountResponse? _defaultInstance;

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
  FamilyAccount get familyAccount => $_getN(2);
  @$pb.TagNumber(3)
  set familyAccount(FamilyAccount value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasFamilyAccount() => $_has(2);
  @$pb.TagNumber(3)
  void clearFamilyAccount() => $_clearField(3);
  @$pb.TagNumber(3)
  FamilyAccount ensureFamilyAccount() => $_ensure(2);
}

/// Unfreeze Family Account
class UnfreezeFamilyAccountRequest extends $pb.GeneratedMessage {
  factory UnfreezeFamilyAccountRequest({
    $core.String? familyId,
  }) {
    final result = create();
    if (familyId != null) result.familyId = familyId;
    return result;
  }

  UnfreezeFamilyAccountRequest._();

  factory UnfreezeFamilyAccountRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UnfreezeFamilyAccountRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UnfreezeFamilyAccountRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'familyId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UnfreezeFamilyAccountRequest clone() =>
      UnfreezeFamilyAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UnfreezeFamilyAccountRequest copyWith(
          void Function(UnfreezeFamilyAccountRequest) updates) =>
      super.copyWith(
              (message) => updates(message as UnfreezeFamilyAccountRequest))
          as UnfreezeFamilyAccountRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UnfreezeFamilyAccountRequest create() =>
      UnfreezeFamilyAccountRequest._();
  @$core.override
  UnfreezeFamilyAccountRequest createEmptyInstance() => create();
  static $pb.PbList<UnfreezeFamilyAccountRequest> createRepeated() =>
      $pb.PbList<UnfreezeFamilyAccountRequest>();
  @$core.pragma('dart2js:noInline')
  static UnfreezeFamilyAccountRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UnfreezeFamilyAccountRequest>(create);
  static UnfreezeFamilyAccountRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get familyId => $_getSZ(0);
  @$pb.TagNumber(1)
  set familyId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFamilyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFamilyId() => $_clearField(1);
}

class UnfreezeFamilyAccountResponse extends $pb.GeneratedMessage {
  factory UnfreezeFamilyAccountResponse({
    $core.bool? success,
    $core.String? message,
    FamilyAccount? familyAccount,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (familyAccount != null) result.familyAccount = familyAccount;
    return result;
  }

  UnfreezeFamilyAccountResponse._();

  factory UnfreezeFamilyAccountResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UnfreezeFamilyAccountResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UnfreezeFamilyAccountResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts.v1'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<FamilyAccount>(3, _omitFieldNames ? '' : 'familyAccount',
        subBuilder: FamilyAccount.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UnfreezeFamilyAccountResponse clone() =>
      UnfreezeFamilyAccountResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UnfreezeFamilyAccountResponse copyWith(
          void Function(UnfreezeFamilyAccountResponse) updates) =>
      super.copyWith(
              (message) => updates(message as UnfreezeFamilyAccountResponse))
          as UnfreezeFamilyAccountResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UnfreezeFamilyAccountResponse create() =>
      UnfreezeFamilyAccountResponse._();
  @$core.override
  UnfreezeFamilyAccountResponse createEmptyInstance() => create();
  static $pb.PbList<UnfreezeFamilyAccountResponse> createRepeated() =>
      $pb.PbList<UnfreezeFamilyAccountResponse>();
  @$core.pragma('dart2js:noInline')
  static UnfreezeFamilyAccountResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UnfreezeFamilyAccountResponse>(create);
  static UnfreezeFamilyAccountResponse? _defaultInstance;

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
  FamilyAccount get familyAccount => $_getN(2);
  @$pb.TagNumber(3)
  set familyAccount(FamilyAccount value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasFamilyAccount() => $_has(2);
  @$pb.TagNumber(3)
  void clearFamilyAccount() => $_clearField(3);
  @$pb.TagNumber(3)
  FamilyAccount ensureFamilyAccount() => $_ensure(2);
}

/// Delete Family Account
class DeleteFamilyAccountRequest extends $pb.GeneratedMessage {
  factory DeleteFamilyAccountRequest({
    $core.String? familyId,
    $core.String? confirmationCode,
  }) {
    final result = create();
    if (familyId != null) result.familyId = familyId;
    if (confirmationCode != null) result.confirmationCode = confirmationCode;
    return result;
  }

  DeleteFamilyAccountRequest._();

  factory DeleteFamilyAccountRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeleteFamilyAccountRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteFamilyAccountRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'familyId')
    ..aOS(2, _omitFieldNames ? '' : 'confirmationCode')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteFamilyAccountRequest clone() =>
      DeleteFamilyAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteFamilyAccountRequest copyWith(
          void Function(DeleteFamilyAccountRequest) updates) =>
      super.copyWith(
              (message) => updates(message as DeleteFamilyAccountRequest))
          as DeleteFamilyAccountRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteFamilyAccountRequest create() => DeleteFamilyAccountRequest._();
  @$core.override
  DeleteFamilyAccountRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteFamilyAccountRequest> createRepeated() =>
      $pb.PbList<DeleteFamilyAccountRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteFamilyAccountRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteFamilyAccountRequest>(create);
  static DeleteFamilyAccountRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get familyId => $_getSZ(0);
  @$pb.TagNumber(1)
  set familyId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFamilyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFamilyId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get confirmationCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set confirmationCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasConfirmationCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearConfirmationCode() => $_clearField(2);
}

class DeleteFamilyAccountResponse extends $pb.GeneratedMessage {
  factory DeleteFamilyAccountResponse({
    $core.bool? success,
    $core.String? message,
    $core.double? returnedBalance,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (returnedBalance != null) result.returnedBalance = returnedBalance;
    return result;
  }

  DeleteFamilyAccountResponse._();

  factory DeleteFamilyAccountResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeleteFamilyAccountResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteFamilyAccountResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts.v1'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..a<$core.double>(
        3, _omitFieldNames ? '' : 'returnedBalance', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteFamilyAccountResponse clone() =>
      DeleteFamilyAccountResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteFamilyAccountResponse copyWith(
          void Function(DeleteFamilyAccountResponse) updates) =>
      super.copyWith(
              (message) => updates(message as DeleteFamilyAccountResponse))
          as DeleteFamilyAccountResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteFamilyAccountResponse create() =>
      DeleteFamilyAccountResponse._();
  @$core.override
  DeleteFamilyAccountResponse createEmptyInstance() => create();
  static $pb.PbList<DeleteFamilyAccountResponse> createRepeated() =>
      $pb.PbList<DeleteFamilyAccountResponse>();
  @$core.pragma('dart2js:noInline')
  static DeleteFamilyAccountResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteFamilyAccountResponse>(create);
  static DeleteFamilyAccountResponse? _defaultInstance;

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
  $core.double get returnedBalance => $_getN(2);
  @$pb.TagNumber(3)
  set returnedBalance($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasReturnedBalance() => $_has(2);
  @$pb.TagNumber(3)
  void clearReturnedBalance() => $_clearField(3);
}

class LeaveFamilyAccountRequest extends $pb.GeneratedMessage {
  factory LeaveFamilyAccountRequest({
    $core.String? familyId,
  }) {
    final result = create();
    if (familyId != null) result.familyId = familyId;
    return result;
  }

  LeaveFamilyAccountRequest._();

  factory LeaveFamilyAccountRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory LeaveFamilyAccountRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LeaveFamilyAccountRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'familyId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LeaveFamilyAccountRequest clone() =>
      LeaveFamilyAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LeaveFamilyAccountRequest copyWith(
          void Function(LeaveFamilyAccountRequest) updates) =>
      super.copyWith((message) => updates(message as LeaveFamilyAccountRequest))
          as LeaveFamilyAccountRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LeaveFamilyAccountRequest create() => LeaveFamilyAccountRequest._();
  @$core.override
  LeaveFamilyAccountRequest createEmptyInstance() => create();
  static $pb.PbList<LeaveFamilyAccountRequest> createRepeated() =>
      $pb.PbList<LeaveFamilyAccountRequest>();
  @$core.pragma('dart2js:noInline')
  static LeaveFamilyAccountRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LeaveFamilyAccountRequest>(create);
  static LeaveFamilyAccountRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get familyId => $_getSZ(0);
  @$pb.TagNumber(1)
  set familyId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFamilyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFamilyId() => $_clearField(1);
}

class LeaveFamilyAccountResponse extends $pb.GeneratedMessage {
  factory LeaveFamilyAccountResponse({
    $core.bool? success,
    $core.String? message,
    $core.double? returnedBalance,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (returnedBalance != null) result.returnedBalance = returnedBalance;
    return result;
  }

  LeaveFamilyAccountResponse._();

  factory LeaveFamilyAccountResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory LeaveFamilyAccountResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LeaveFamilyAccountResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts.v1'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..a<$core.double>(
        3, _omitFieldNames ? '' : 'returnedBalance', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LeaveFamilyAccountResponse clone() =>
      LeaveFamilyAccountResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LeaveFamilyAccountResponse copyWith(
          void Function(LeaveFamilyAccountResponse) updates) =>
      super.copyWith(
              (message) => updates(message as LeaveFamilyAccountResponse))
          as LeaveFamilyAccountResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LeaveFamilyAccountResponse create() => LeaveFamilyAccountResponse._();
  @$core.override
  LeaveFamilyAccountResponse createEmptyInstance() => create();
  static $pb.PbList<LeaveFamilyAccountResponse> createRepeated() =>
      $pb.PbList<LeaveFamilyAccountResponse>();
  @$core.pragma('dart2js:noInline')
  static LeaveFamilyAccountResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<LeaveFamilyAccountResponse>(create);
  static LeaveFamilyAccountResponse? _defaultInstance;

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
  $core.double get returnedBalance => $_getN(2);
  @$pb.TagNumber(3)
  set returnedBalance($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasReturnedBalance() => $_has(2);
  @$pb.TagNumber(3)
  void clearReturnedBalance() => $_clearField(3);
}

/// Process Member Contribution
class ProcessMemberContributionRequest extends $pb.GeneratedMessage {
  factory ProcessMemberContributionRequest({
    $core.String? familyId,
    $core.String? memberId,
    $core.double? amount,
    $core.String? description,
    $core.String? idempotencyKey,
  }) {
    final result = create();
    if (familyId != null) result.familyId = familyId;
    if (memberId != null) result.memberId = memberId;
    if (amount != null) result.amount = amount;
    if (description != null) result.description = description;
    if (idempotencyKey != null) result.idempotencyKey = idempotencyKey;
    return result;
  }

  ProcessMemberContributionRequest._();

  factory ProcessMemberContributionRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ProcessMemberContributionRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ProcessMemberContributionRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'familyId')
    ..aOS(2, _omitFieldNames ? '' : 'memberId')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(4, _omitFieldNames ? '' : 'description')
    ..aOS(5, _omitFieldNames ? '' : 'idempotencyKey')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProcessMemberContributionRequest clone() =>
      ProcessMemberContributionRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProcessMemberContributionRequest copyWith(
          void Function(ProcessMemberContributionRequest) updates) =>
      super.copyWith(
              (message) => updates(message as ProcessMemberContributionRequest))
          as ProcessMemberContributionRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProcessMemberContributionRequest create() =>
      ProcessMemberContributionRequest._();
  @$core.override
  ProcessMemberContributionRequest createEmptyInstance() => create();
  static $pb.PbList<ProcessMemberContributionRequest> createRepeated() =>
      $pb.PbList<ProcessMemberContributionRequest>();
  @$core.pragma('dart2js:noInline')
  static ProcessMemberContributionRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ProcessMemberContributionRequest>(
          create);
  static ProcessMemberContributionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get familyId => $_getSZ(0);
  @$pb.TagNumber(1)
  set familyId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFamilyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFamilyId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get memberId => $_getSZ(1);
  @$pb.TagNumber(2)
  set memberId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMemberId() => $_has(1);
  @$pb.TagNumber(2)
  void clearMemberId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get amount => $_getN(2);
  @$pb.TagNumber(3)
  set amount($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get description => $_getSZ(3);
  @$pb.TagNumber(4)
  set description($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDescription() => $_has(3);
  @$pb.TagNumber(4)
  void clearDescription() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get idempotencyKey => $_getSZ(4);
  @$pb.TagNumber(5)
  set idempotencyKey($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasIdempotencyKey() => $_has(4);
  @$pb.TagNumber(5)
  void clearIdempotencyKey() => $_clearField(5);
}

class ProcessMemberContributionResponse extends $pb.GeneratedMessage {
  factory ProcessMemberContributionResponse({
    FamilyAccount? familyAccount,
    FamilyTransaction? transaction,
    $core.String? message,
  }) {
    final result = create();
    if (familyAccount != null) result.familyAccount = familyAccount;
    if (transaction != null) result.transaction = transaction;
    if (message != null) result.message = message;
    return result;
  }

  ProcessMemberContributionResponse._();

  factory ProcessMemberContributionResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ProcessMemberContributionResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ProcessMemberContributionResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts.v1'),
      createEmptyInstance: create)
    ..aOM<FamilyAccount>(1, _omitFieldNames ? '' : 'familyAccount',
        subBuilder: FamilyAccount.create)
    ..aOM<FamilyTransaction>(2, _omitFieldNames ? '' : 'transaction',
        subBuilder: FamilyTransaction.create)
    ..aOS(3, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProcessMemberContributionResponse clone() =>
      ProcessMemberContributionResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProcessMemberContributionResponse copyWith(
          void Function(ProcessMemberContributionResponse) updates) =>
      super.copyWith((message) =>
              updates(message as ProcessMemberContributionResponse))
          as ProcessMemberContributionResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProcessMemberContributionResponse create() =>
      ProcessMemberContributionResponse._();
  @$core.override
  ProcessMemberContributionResponse createEmptyInstance() => create();
  static $pb.PbList<ProcessMemberContributionResponse> createRepeated() =>
      $pb.PbList<ProcessMemberContributionResponse>();
  @$core.pragma('dart2js:noInline')
  static ProcessMemberContributionResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ProcessMemberContributionResponse>(
          create);
  static ProcessMemberContributionResponse? _defaultInstance;

  @$pb.TagNumber(1)
  FamilyAccount get familyAccount => $_getN(0);
  @$pb.TagNumber(1)
  set familyAccount(FamilyAccount value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasFamilyAccount() => $_has(0);
  @$pb.TagNumber(1)
  void clearFamilyAccount() => $_clearField(1);
  @$pb.TagNumber(1)
  FamilyAccount ensureFamilyAccount() => $_ensure(0);

  @$pb.TagNumber(2)
  FamilyTransaction get transaction => $_getN(1);
  @$pb.TagNumber(2)
  set transaction(FamilyTransaction value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasTransaction() => $_has(1);
  @$pb.TagNumber(2)
  void clearTransaction() => $_clearField(2);
  @$pb.TagNumber(2)
  FamilyTransaction ensureTransaction() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => $_clearField(3);
}

/// Setup Family Account
class SetupFamilyAccountRequest extends $pb.GeneratedMessage {
  factory SetupFamilyAccountRequest({
    $core.String? familyId,
    FundDistributionMode? fundDistributionMode,
    $core.bool? spendingVisibilityEnabled,
    $core.Iterable<MemberAllocation>? allocations,
    $core.String? fundingPolicy,
    $core.Iterable<$core.String>? specificMemberIds,
  }) {
    final result = create();
    if (familyId != null) result.familyId = familyId;
    if (fundDistributionMode != null)
      result.fundDistributionMode = fundDistributionMode;
    if (spendingVisibilityEnabled != null)
      result.spendingVisibilityEnabled = spendingVisibilityEnabled;
    if (allocations != null) result.allocations.addAll(allocations);
    if (fundingPolicy != null) result.fundingPolicy = fundingPolicy;
    if (specificMemberIds != null)
      result.specificMemberIds.addAll(specificMemberIds);
    return result;
  }

  SetupFamilyAccountRequest._();

  factory SetupFamilyAccountRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SetupFamilyAccountRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SetupFamilyAccountRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'familyId')
    ..e<FundDistributionMode>(
        2, _omitFieldNames ? '' : 'fundDistributionMode', $pb.PbFieldType.OE,
        defaultOrMaker: FundDistributionMode.FUND_DISTRIBUTION_MODE_UNSPECIFIED,
        valueOf: FundDistributionMode.valueOf,
        enumValues: FundDistributionMode.values)
    ..aOB(3, _omitFieldNames ? '' : 'spendingVisibilityEnabled')
    ..pc<MemberAllocation>(
        4, _omitFieldNames ? '' : 'allocations', $pb.PbFieldType.PM,
        subBuilder: MemberAllocation.create)
    ..aOS(5, _omitFieldNames ? '' : 'fundingPolicy')
    ..pPS(6, _omitFieldNames ? '' : 'specificMemberIds')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetupFamilyAccountRequest clone() =>
      SetupFamilyAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetupFamilyAccountRequest copyWith(
          void Function(SetupFamilyAccountRequest) updates) =>
      super.copyWith((message) => updates(message as SetupFamilyAccountRequest))
          as SetupFamilyAccountRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SetupFamilyAccountRequest create() => SetupFamilyAccountRequest._();
  @$core.override
  SetupFamilyAccountRequest createEmptyInstance() => create();
  static $pb.PbList<SetupFamilyAccountRequest> createRepeated() =>
      $pb.PbList<SetupFamilyAccountRequest>();
  @$core.pragma('dart2js:noInline')
  static SetupFamilyAccountRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SetupFamilyAccountRequest>(create);
  static SetupFamilyAccountRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get familyId => $_getSZ(0);
  @$pb.TagNumber(1)
  set familyId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFamilyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFamilyId() => $_clearField(1);

  @$pb.TagNumber(2)
  FundDistributionMode get fundDistributionMode => $_getN(1);
  @$pb.TagNumber(2)
  set fundDistributionMode(FundDistributionMode value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasFundDistributionMode() => $_has(1);
  @$pb.TagNumber(2)
  void clearFundDistributionMode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get spendingVisibilityEnabled => $_getBF(2);
  @$pb.TagNumber(3)
  set spendingVisibilityEnabled($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSpendingVisibilityEnabled() => $_has(2);
  @$pb.TagNumber(3)
  void clearSpendingVisibilityEnabled() => $_clearField(3);

  @$pb.TagNumber(4)
  $pb.PbList<MemberAllocation> get allocations => $_getList(3);

  @$pb.TagNumber(5)
  $core.String get fundingPolicy => $_getSZ(4);
  @$pb.TagNumber(5)
  set fundingPolicy($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasFundingPolicy() => $_has(4);
  @$pb.TagNumber(5)
  void clearFundingPolicy() => $_clearField(5);

  @$pb.TagNumber(6)
  $pb.PbList<$core.String> get specificMemberIds => $_getList(5);
}

class MemberAllocation extends $pb.GeneratedMessage {
  factory MemberAllocation({
    $core.String? memberId,
    $core.double? amount,
  }) {
    final result = create();
    if (memberId != null) result.memberId = memberId;
    if (amount != null) result.amount = amount;
    return result;
  }

  MemberAllocation._();

  factory MemberAllocation.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MemberAllocation.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MemberAllocation',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'memberId')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MemberAllocation clone() => MemberAllocation()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MemberAllocation copyWith(void Function(MemberAllocation) updates) =>
      super.copyWith((message) => updates(message as MemberAllocation))
          as MemberAllocation;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MemberAllocation create() => MemberAllocation._();
  @$core.override
  MemberAllocation createEmptyInstance() => create();
  static $pb.PbList<MemberAllocation> createRepeated() =>
      $pb.PbList<MemberAllocation>();
  @$core.pragma('dart2js:noInline')
  static MemberAllocation getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MemberAllocation>(create);
  static MemberAllocation? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get memberId => $_getSZ(0);
  @$pb.TagNumber(1)
  set memberId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMemberId() => $_has(0);
  @$pb.TagNumber(1)
  void clearMemberId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get amount => $_getN(1);
  @$pb.TagNumber(2)
  set amount($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => $_clearField(2);
}

class SetupFamilyAccountResponse extends $pb.GeneratedMessage {
  factory SetupFamilyAccountResponse({
    FamilyAccount? familyAccount,
    $core.String? message,
  }) {
    final result = create();
    if (familyAccount != null) result.familyAccount = familyAccount;
    if (message != null) result.message = message;
    return result;
  }

  SetupFamilyAccountResponse._();

  factory SetupFamilyAccountResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SetupFamilyAccountResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SetupFamilyAccountResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts.v1'),
      createEmptyInstance: create)
    ..aOM<FamilyAccount>(1, _omitFieldNames ? '' : 'familyAccount',
        subBuilder: FamilyAccount.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetupFamilyAccountResponse clone() =>
      SetupFamilyAccountResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetupFamilyAccountResponse copyWith(
          void Function(SetupFamilyAccountResponse) updates) =>
      super.copyWith(
              (message) => updates(message as SetupFamilyAccountResponse))
          as SetupFamilyAccountResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SetupFamilyAccountResponse create() => SetupFamilyAccountResponse._();
  @$core.override
  SetupFamilyAccountResponse createEmptyInstance() => create();
  static $pb.PbList<SetupFamilyAccountResponse> createRepeated() =>
      $pb.PbList<SetupFamilyAccountResponse>();
  @$core.pragma('dart2js:noInline')
  static SetupFamilyAccountResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SetupFamilyAccountResponse>(create);
  static SetupFamilyAccountResponse? _defaultInstance;

  @$pb.TagNumber(1)
  FamilyAccount get familyAccount => $_getN(0);
  @$pb.TagNumber(1)
  set familyAccount(FamilyAccount value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasFamilyAccount() => $_has(0);
  @$pb.TagNumber(1)
  void clearFamilyAccount() => $_clearField(1);
  @$pb.TagNumber(1)
  FamilyAccount ensureFamilyAccount() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);
}

/// Update Fund Distribution Mode
class UpdateFundDistributionModeRequest extends $pb.GeneratedMessage {
  factory UpdateFundDistributionModeRequest({
    $core.String? familyId,
    FundDistributionMode? fundDistributionMode,
    $core.Iterable<MemberAllocation>? allocations,
  }) {
    final result = create();
    if (familyId != null) result.familyId = familyId;
    if (fundDistributionMode != null)
      result.fundDistributionMode = fundDistributionMode;
    if (allocations != null) result.allocations.addAll(allocations);
    return result;
  }

  UpdateFundDistributionModeRequest._();

  factory UpdateFundDistributionModeRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateFundDistributionModeRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateFundDistributionModeRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'familyId')
    ..e<FundDistributionMode>(
        2, _omitFieldNames ? '' : 'fundDistributionMode', $pb.PbFieldType.OE,
        defaultOrMaker: FundDistributionMode.FUND_DISTRIBUTION_MODE_UNSPECIFIED,
        valueOf: FundDistributionMode.valueOf,
        enumValues: FundDistributionMode.values)
    ..pc<MemberAllocation>(
        3, _omitFieldNames ? '' : 'allocations', $pb.PbFieldType.PM,
        subBuilder: MemberAllocation.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateFundDistributionModeRequest clone() =>
      UpdateFundDistributionModeRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateFundDistributionModeRequest copyWith(
          void Function(UpdateFundDistributionModeRequest) updates) =>
      super.copyWith((message) =>
              updates(message as UpdateFundDistributionModeRequest))
          as UpdateFundDistributionModeRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateFundDistributionModeRequest create() =>
      UpdateFundDistributionModeRequest._();
  @$core.override
  UpdateFundDistributionModeRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateFundDistributionModeRequest> createRepeated() =>
      $pb.PbList<UpdateFundDistributionModeRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateFundDistributionModeRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateFundDistributionModeRequest>(
          create);
  static UpdateFundDistributionModeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get familyId => $_getSZ(0);
  @$pb.TagNumber(1)
  set familyId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFamilyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFamilyId() => $_clearField(1);

  @$pb.TagNumber(2)
  FundDistributionMode get fundDistributionMode => $_getN(1);
  @$pb.TagNumber(2)
  set fundDistributionMode(FundDistributionMode value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasFundDistributionMode() => $_has(1);
  @$pb.TagNumber(2)
  void clearFundDistributionMode() => $_clearField(2);

  @$pb.TagNumber(3)
  $pb.PbList<MemberAllocation> get allocations => $_getList(2);
}

class UpdateFundDistributionModeResponse extends $pb.GeneratedMessage {
  factory UpdateFundDistributionModeResponse({
    FamilyAccount? familyAccount,
    $core.String? message,
  }) {
    final result = create();
    if (familyAccount != null) result.familyAccount = familyAccount;
    if (message != null) result.message = message;
    return result;
  }

  UpdateFundDistributionModeResponse._();

  factory UpdateFundDistributionModeResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateFundDistributionModeResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateFundDistributionModeResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts.v1'),
      createEmptyInstance: create)
    ..aOM<FamilyAccount>(1, _omitFieldNames ? '' : 'familyAccount',
        subBuilder: FamilyAccount.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateFundDistributionModeResponse clone() =>
      UpdateFundDistributionModeResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateFundDistributionModeResponse copyWith(
          void Function(UpdateFundDistributionModeResponse) updates) =>
      super.copyWith((message) =>
              updates(message as UpdateFundDistributionModeResponse))
          as UpdateFundDistributionModeResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateFundDistributionModeResponse create() =>
      UpdateFundDistributionModeResponse._();
  @$core.override
  UpdateFundDistributionModeResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateFundDistributionModeResponse> createRepeated() =>
      $pb.PbList<UpdateFundDistributionModeResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateFundDistributionModeResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateFundDistributionModeResponse>(
          create);
  static UpdateFundDistributionModeResponse? _defaultInstance;

  @$pb.TagNumber(1)
  FamilyAccount get familyAccount => $_getN(0);
  @$pb.TagNumber(1)
  set familyAccount(FamilyAccount value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasFamilyAccount() => $_has(0);
  @$pb.TagNumber(1)
  void clearFamilyAccount() => $_clearField(1);
  @$pb.TagNumber(1)
  FamilyAccount ensureFamilyAccount() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);
}

/// Family Account
class FamilyAccount extends $pb.GeneratedMessage {
  factory FamilyAccount({
    $core.String? id,
    $core.String? creatorId,
    $core.String? creatorName,
    $core.String? name,
    $core.String? description,
    $core.double? totalAllocatedBalance,
    $core.double? totalPoolBalance,
    $core.String? status,
    $core.String? createdAt,
    $core.String? updatedAt,
    $core.Iterable<FamilyMember>? members,
    $core.int? memberCount,
    $core.int? activeMemberCount,
    $core.bool? allowMemberContributions,
    $core.double? totalBalance,
    FundDistributionMode? fundDistributionMode,
    $core.bool? setupCompleted,
    $core.bool? spendingVisibilityEnabled,
    $core.String? currency,
    $core.String? virtualAccountId,
    $core.String? fundingPolicy,
    $core.String? accountNumber,
    $core.String? bankName,
    $core.String? virtualAccountStatus,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (creatorId != null) result.creatorId = creatorId;
    if (creatorName != null) result.creatorName = creatorName;
    if (name != null) result.name = name;
    if (description != null) result.description = description;
    if (totalAllocatedBalance != null)
      result.totalAllocatedBalance = totalAllocatedBalance;
    if (totalPoolBalance != null) result.totalPoolBalance = totalPoolBalance;
    if (status != null) result.status = status;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    if (members != null) result.members.addAll(members);
    if (memberCount != null) result.memberCount = memberCount;
    if (activeMemberCount != null) result.activeMemberCount = activeMemberCount;
    if (allowMemberContributions != null)
      result.allowMemberContributions = allowMemberContributions;
    if (totalBalance != null) result.totalBalance = totalBalance;
    if (fundDistributionMode != null)
      result.fundDistributionMode = fundDistributionMode;
    if (setupCompleted != null) result.setupCompleted = setupCompleted;
    if (spendingVisibilityEnabled != null)
      result.spendingVisibilityEnabled = spendingVisibilityEnabled;
    if (currency != null) result.currency = currency;
    if (virtualAccountId != null) result.virtualAccountId = virtualAccountId;
    if (fundingPolicy != null) result.fundingPolicy = fundingPolicy;
    if (accountNumber != null) result.accountNumber = accountNumber;
    if (bankName != null) result.bankName = bankName;
    if (virtualAccountStatus != null)
      result.virtualAccountStatus = virtualAccountStatus;
    return result;
  }

  FamilyAccount._();

  factory FamilyAccount.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FamilyAccount.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FamilyAccount',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'creatorId')
    ..aOS(3, _omitFieldNames ? '' : 'creatorName')
    ..aOS(4, _omitFieldNames ? '' : 'name')
    ..aOS(5, _omitFieldNames ? '' : 'description')
    ..a<$core.double>(
        6, _omitFieldNames ? '' : 'totalAllocatedBalance', $pb.PbFieldType.OD)
    ..a<$core.double>(
        7, _omitFieldNames ? '' : 'totalPoolBalance', $pb.PbFieldType.OD)
    ..aOS(8, _omitFieldNames ? '' : 'status')
    ..aOS(9, _omitFieldNames ? '' : 'createdAt')
    ..aOS(10, _omitFieldNames ? '' : 'updatedAt')
    ..pc<FamilyMember>(11, _omitFieldNames ? '' : 'members', $pb.PbFieldType.PM,
        subBuilder: FamilyMember.create)
    ..a<$core.int>(12, _omitFieldNames ? '' : 'memberCount', $pb.PbFieldType.O3)
    ..a<$core.int>(
        13, _omitFieldNames ? '' : 'activeMemberCount', $pb.PbFieldType.O3)
    ..aOB(14, _omitFieldNames ? '' : 'allowMemberContributions')
    ..a<$core.double>(
        15, _omitFieldNames ? '' : 'totalBalance', $pb.PbFieldType.OD)
    ..e<FundDistributionMode>(
        16, _omitFieldNames ? '' : 'fundDistributionMode', $pb.PbFieldType.OE,
        defaultOrMaker: FundDistributionMode.FUND_DISTRIBUTION_MODE_UNSPECIFIED,
        valueOf: FundDistributionMode.valueOf,
        enumValues: FundDistributionMode.values)
    ..aOB(17, _omitFieldNames ? '' : 'setupCompleted')
    ..aOB(18, _omitFieldNames ? '' : 'spendingVisibilityEnabled')
    ..aOS(19, _omitFieldNames ? '' : 'currency')
    ..aOS(20, _omitFieldNames ? '' : 'virtualAccountId')
    ..aOS(21, _omitFieldNames ? '' : 'fundingPolicy')
    ..aOS(22, _omitFieldNames ? '' : 'accountNumber')
    ..aOS(23, _omitFieldNames ? '' : 'bankName')
    ..aOS(24, _omitFieldNames ? '' : 'virtualAccountStatus')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FamilyAccount clone() => FamilyAccount()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FamilyAccount copyWith(void Function(FamilyAccount) updates) =>
      super.copyWith((message) => updates(message as FamilyAccount))
          as FamilyAccount;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FamilyAccount create() => FamilyAccount._();
  @$core.override
  FamilyAccount createEmptyInstance() => create();
  static $pb.PbList<FamilyAccount> createRepeated() =>
      $pb.PbList<FamilyAccount>();
  @$core.pragma('dart2js:noInline')
  static FamilyAccount getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FamilyAccount>(create);
  static FamilyAccount? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get creatorId => $_getSZ(1);
  @$pb.TagNumber(2)
  set creatorId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCreatorId() => $_has(1);
  @$pb.TagNumber(2)
  void clearCreatorId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get creatorName => $_getSZ(2);
  @$pb.TagNumber(3)
  set creatorName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCreatorName() => $_has(2);
  @$pb.TagNumber(3)
  void clearCreatorName() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get name => $_getSZ(3);
  @$pb.TagNumber(4)
  set name($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasName() => $_has(3);
  @$pb.TagNumber(4)
  void clearName() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get description => $_getSZ(4);
  @$pb.TagNumber(5)
  set description($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasDescription() => $_has(4);
  @$pb.TagNumber(5)
  void clearDescription() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.double get totalAllocatedBalance => $_getN(5);
  @$pb.TagNumber(6)
  set totalAllocatedBalance($core.double value) => $_setDouble(5, value);
  @$pb.TagNumber(6)
  $core.bool hasTotalAllocatedBalance() => $_has(5);
  @$pb.TagNumber(6)
  void clearTotalAllocatedBalance() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.double get totalPoolBalance => $_getN(6);
  @$pb.TagNumber(7)
  set totalPoolBalance($core.double value) => $_setDouble(6, value);
  @$pb.TagNumber(7)
  $core.bool hasTotalPoolBalance() => $_has(6);
  @$pb.TagNumber(7)
  void clearTotalPoolBalance() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get status => $_getSZ(7);
  @$pb.TagNumber(8)
  set status($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasStatus() => $_has(7);
  @$pb.TagNumber(8)
  void clearStatus() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get createdAt => $_getSZ(8);
  @$pb.TagNumber(9)
  set createdAt($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasCreatedAt() => $_has(8);
  @$pb.TagNumber(9)
  void clearCreatedAt() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get updatedAt => $_getSZ(9);
  @$pb.TagNumber(10)
  set updatedAt($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasUpdatedAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearUpdatedAt() => $_clearField(10);

  @$pb.TagNumber(11)
  $pb.PbList<FamilyMember> get members => $_getList(10);

  @$pb.TagNumber(12)
  $core.int get memberCount => $_getIZ(11);
  @$pb.TagNumber(12)
  set memberCount($core.int value) => $_setSignedInt32(11, value);
  @$pb.TagNumber(12)
  $core.bool hasMemberCount() => $_has(11);
  @$pb.TagNumber(12)
  void clearMemberCount() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.int get activeMemberCount => $_getIZ(12);
  @$pb.TagNumber(13)
  set activeMemberCount($core.int value) => $_setSignedInt32(12, value);
  @$pb.TagNumber(13)
  $core.bool hasActiveMemberCount() => $_has(12);
  @$pb.TagNumber(13)
  void clearActiveMemberCount() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.bool get allowMemberContributions => $_getBF(13);
  @$pb.TagNumber(14)
  set allowMemberContributions($core.bool value) => $_setBool(13, value);
  @$pb.TagNumber(14)
  $core.bool hasAllowMemberContributions() => $_has(13);
  @$pb.TagNumber(14)
  void clearAllowMemberContributions() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.double get totalBalance => $_getN(14);
  @$pb.TagNumber(15)
  set totalBalance($core.double value) => $_setDouble(14, value);
  @$pb.TagNumber(15)
  $core.bool hasTotalBalance() => $_has(14);
  @$pb.TagNumber(15)
  void clearTotalBalance() => $_clearField(15);

  @$pb.TagNumber(16)
  FundDistributionMode get fundDistributionMode => $_getN(15);
  @$pb.TagNumber(16)
  set fundDistributionMode(FundDistributionMode value) => $_setField(16, value);
  @$pb.TagNumber(16)
  $core.bool hasFundDistributionMode() => $_has(15);
  @$pb.TagNumber(16)
  void clearFundDistributionMode() => $_clearField(16);

  @$pb.TagNumber(17)
  $core.bool get setupCompleted => $_getBF(16);
  @$pb.TagNumber(17)
  set setupCompleted($core.bool value) => $_setBool(16, value);
  @$pb.TagNumber(17)
  $core.bool hasSetupCompleted() => $_has(16);
  @$pb.TagNumber(17)
  void clearSetupCompleted() => $_clearField(17);

  @$pb.TagNumber(18)
  $core.bool get spendingVisibilityEnabled => $_getBF(17);
  @$pb.TagNumber(18)
  set spendingVisibilityEnabled($core.bool value) => $_setBool(17, value);
  @$pb.TagNumber(18)
  $core.bool hasSpendingVisibilityEnabled() => $_has(17);
  @$pb.TagNumber(18)
  void clearSpendingVisibilityEnabled() => $_clearField(18);

  @$pb.TagNumber(19)
  $core.String get currency => $_getSZ(18);
  @$pb.TagNumber(19)
  set currency($core.String value) => $_setString(18, value);
  @$pb.TagNumber(19)
  $core.bool hasCurrency() => $_has(18);
  @$pb.TagNumber(19)
  void clearCurrency() => $_clearField(19);

  @$pb.TagNumber(20)
  $core.String get virtualAccountId => $_getSZ(19);
  @$pb.TagNumber(20)
  set virtualAccountId($core.String value) => $_setString(19, value);
  @$pb.TagNumber(20)
  $core.bool hasVirtualAccountId() => $_has(19);
  @$pb.TagNumber(20)
  void clearVirtualAccountId() => $_clearField(20);

  @$pb.TagNumber(21)
  $core.String get fundingPolicy => $_getSZ(20);
  @$pb.TagNumber(21)
  set fundingPolicy($core.String value) => $_setString(20, value);
  @$pb.TagNumber(21)
  $core.bool hasFundingPolicy() => $_has(20);
  @$pb.TagNumber(21)
  void clearFundingPolicy() => $_clearField(21);

  @$pb.TagNumber(22)
  $core.String get accountNumber => $_getSZ(21);
  @$pb.TagNumber(22)
  set accountNumber($core.String value) => $_setString(21, value);
  @$pb.TagNumber(22)
  $core.bool hasAccountNumber() => $_has(21);
  @$pb.TagNumber(22)
  void clearAccountNumber() => $_clearField(22);

  @$pb.TagNumber(23)
  $core.String get bankName => $_getSZ(22);
  @$pb.TagNumber(23)
  set bankName($core.String value) => $_setString(22, value);
  @$pb.TagNumber(23)
  $core.bool hasBankName() => $_has(22);
  @$pb.TagNumber(23)
  void clearBankName() => $_clearField(23);

  @$pb.TagNumber(24)
  $core.String get virtualAccountStatus => $_getSZ(23);
  @$pb.TagNumber(24)
  set virtualAccountStatus($core.String value) => $_setString(23, value);
  @$pb.TagNumber(24)
  $core.bool hasVirtualAccountStatus() => $_has(23);
  @$pb.TagNumber(24)
  void clearVirtualAccountStatus() => $_clearField(24);
}

/// Family Member
class FamilyMember extends $pb.GeneratedMessage {
  factory FamilyMember({
    $core.String? id,
    $core.String? familyId,
    $core.String? userId,
    $core.String? fullName,
    $core.String? email,
    $core.String? phone,
    $core.String? username,
    $core.String? avatarUrl,
    $core.String? role,
    $core.double? allocatedBalance,
    $core.double? dailySpendingLimit,
    $core.double? monthlySpendingLimit,
    $core.double? spentThisMonth,
    $core.double? spentToday,
    $core.String? invitationStatus,
    $core.String? invitationToken,
    $core.String? invitationExpiresAt,
    $core.String? cardLastFour,
    $core.bool? hasCard,
    $core.String? joinedAt,
    $core.String? createdAt,
    $core.String? updatedAt,
    $core.double? perTransactionLimit,
    $core.double? allocationPercentageCap,
    $core.double? remainingBalance,
    $core.bool? canContribute,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (familyId != null) result.familyId = familyId;
    if (userId != null) result.userId = userId;
    if (fullName != null) result.fullName = fullName;
    if (email != null) result.email = email;
    if (phone != null) result.phone = phone;
    if (username != null) result.username = username;
    if (avatarUrl != null) result.avatarUrl = avatarUrl;
    if (role != null) result.role = role;
    if (allocatedBalance != null) result.allocatedBalance = allocatedBalance;
    if (dailySpendingLimit != null)
      result.dailySpendingLimit = dailySpendingLimit;
    if (monthlySpendingLimit != null)
      result.monthlySpendingLimit = monthlySpendingLimit;
    if (spentThisMonth != null) result.spentThisMonth = spentThisMonth;
    if (spentToday != null) result.spentToday = spentToday;
    if (invitationStatus != null) result.invitationStatus = invitationStatus;
    if (invitationToken != null) result.invitationToken = invitationToken;
    if (invitationExpiresAt != null)
      result.invitationExpiresAt = invitationExpiresAt;
    if (cardLastFour != null) result.cardLastFour = cardLastFour;
    if (hasCard != null) result.hasCard = hasCard;
    if (joinedAt != null) result.joinedAt = joinedAt;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    if (perTransactionLimit != null)
      result.perTransactionLimit = perTransactionLimit;
    if (allocationPercentageCap != null)
      result.allocationPercentageCap = allocationPercentageCap;
    if (remainingBalance != null) result.remainingBalance = remainingBalance;
    if (canContribute != null) result.canContribute = canContribute;
    return result;
  }

  FamilyMember._();

  factory FamilyMember.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FamilyMember.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FamilyMember',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'familyId')
    ..aOS(3, _omitFieldNames ? '' : 'userId')
    ..aOS(4, _omitFieldNames ? '' : 'fullName')
    ..aOS(5, _omitFieldNames ? '' : 'email')
    ..aOS(6, _omitFieldNames ? '' : 'phone')
    ..aOS(7, _omitFieldNames ? '' : 'username')
    ..aOS(8, _omitFieldNames ? '' : 'avatarUrl')
    ..aOS(9, _omitFieldNames ? '' : 'role')
    ..a<$core.double>(
        10, _omitFieldNames ? '' : 'allocatedBalance', $pb.PbFieldType.OD)
    ..a<$core.double>(
        11, _omitFieldNames ? '' : 'dailySpendingLimit', $pb.PbFieldType.OD)
    ..a<$core.double>(
        12, _omitFieldNames ? '' : 'monthlySpendingLimit', $pb.PbFieldType.OD)
    ..a<$core.double>(
        13, _omitFieldNames ? '' : 'spentThisMonth', $pb.PbFieldType.OD)
    ..a<$core.double>(
        14, _omitFieldNames ? '' : 'spentToday', $pb.PbFieldType.OD)
    ..aOS(15, _omitFieldNames ? '' : 'invitationStatus')
    ..aOS(16, _omitFieldNames ? '' : 'invitationToken')
    ..aOS(17, _omitFieldNames ? '' : 'invitationExpiresAt')
    ..aOS(18, _omitFieldNames ? '' : 'cardLastFour')
    ..aOB(19, _omitFieldNames ? '' : 'hasCard')
    ..aOS(20, _omitFieldNames ? '' : 'joinedAt')
    ..aOS(21, _omitFieldNames ? '' : 'createdAt')
    ..aOS(22, _omitFieldNames ? '' : 'updatedAt')
    ..a<$core.double>(
        23, _omitFieldNames ? '' : 'perTransactionLimit', $pb.PbFieldType.OD)
    ..a<$core.double>(24, _omitFieldNames ? '' : 'allocationPercentageCap',
        $pb.PbFieldType.OD)
    ..a<$core.double>(
        25, _omitFieldNames ? '' : 'remainingBalance', $pb.PbFieldType.OD)
    ..aOB(26, _omitFieldNames ? '' : 'canContribute')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FamilyMember clone() => FamilyMember()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FamilyMember copyWith(void Function(FamilyMember) updates) =>
      super.copyWith((message) => updates(message as FamilyMember))
          as FamilyMember;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FamilyMember create() => FamilyMember._();
  @$core.override
  FamilyMember createEmptyInstance() => create();
  static $pb.PbList<FamilyMember> createRepeated() =>
      $pb.PbList<FamilyMember>();
  @$core.pragma('dart2js:noInline')
  static FamilyMember getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FamilyMember>(create);
  static FamilyMember? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get familyId => $_getSZ(1);
  @$pb.TagNumber(2)
  set familyId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasFamilyId() => $_has(1);
  @$pb.TagNumber(2)
  void clearFamilyId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get userId => $_getSZ(2);
  @$pb.TagNumber(3)
  set userId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasUserId() => $_has(2);
  @$pb.TagNumber(3)
  void clearUserId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get fullName => $_getSZ(3);
  @$pb.TagNumber(4)
  set fullName($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasFullName() => $_has(3);
  @$pb.TagNumber(4)
  void clearFullName() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get email => $_getSZ(4);
  @$pb.TagNumber(5)
  set email($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasEmail() => $_has(4);
  @$pb.TagNumber(5)
  void clearEmail() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get phone => $_getSZ(5);
  @$pb.TagNumber(6)
  set phone($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasPhone() => $_has(5);
  @$pb.TagNumber(6)
  void clearPhone() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get username => $_getSZ(6);
  @$pb.TagNumber(7)
  set username($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasUsername() => $_has(6);
  @$pb.TagNumber(7)
  void clearUsername() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get avatarUrl => $_getSZ(7);
  @$pb.TagNumber(8)
  set avatarUrl($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasAvatarUrl() => $_has(7);
  @$pb.TagNumber(8)
  void clearAvatarUrl() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get role => $_getSZ(8);
  @$pb.TagNumber(9)
  set role($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasRole() => $_has(8);
  @$pb.TagNumber(9)
  void clearRole() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.double get allocatedBalance => $_getN(9);
  @$pb.TagNumber(10)
  set allocatedBalance($core.double value) => $_setDouble(9, value);
  @$pb.TagNumber(10)
  $core.bool hasAllocatedBalance() => $_has(9);
  @$pb.TagNumber(10)
  void clearAllocatedBalance() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.double get dailySpendingLimit => $_getN(10);
  @$pb.TagNumber(11)
  set dailySpendingLimit($core.double value) => $_setDouble(10, value);
  @$pb.TagNumber(11)
  $core.bool hasDailySpendingLimit() => $_has(10);
  @$pb.TagNumber(11)
  void clearDailySpendingLimit() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.double get monthlySpendingLimit => $_getN(11);
  @$pb.TagNumber(12)
  set monthlySpendingLimit($core.double value) => $_setDouble(11, value);
  @$pb.TagNumber(12)
  $core.bool hasMonthlySpendingLimit() => $_has(11);
  @$pb.TagNumber(12)
  void clearMonthlySpendingLimit() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.double get spentThisMonth => $_getN(12);
  @$pb.TagNumber(13)
  set spentThisMonth($core.double value) => $_setDouble(12, value);
  @$pb.TagNumber(13)
  $core.bool hasSpentThisMonth() => $_has(12);
  @$pb.TagNumber(13)
  void clearSpentThisMonth() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.double get spentToday => $_getN(13);
  @$pb.TagNumber(14)
  set spentToday($core.double value) => $_setDouble(13, value);
  @$pb.TagNumber(14)
  $core.bool hasSpentToday() => $_has(13);
  @$pb.TagNumber(14)
  void clearSpentToday() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.String get invitationStatus => $_getSZ(14);
  @$pb.TagNumber(15)
  set invitationStatus($core.String value) => $_setString(14, value);
  @$pb.TagNumber(15)
  $core.bool hasInvitationStatus() => $_has(14);
  @$pb.TagNumber(15)
  void clearInvitationStatus() => $_clearField(15);

  @$pb.TagNumber(16)
  $core.String get invitationToken => $_getSZ(15);
  @$pb.TagNumber(16)
  set invitationToken($core.String value) => $_setString(15, value);
  @$pb.TagNumber(16)
  $core.bool hasInvitationToken() => $_has(15);
  @$pb.TagNumber(16)
  void clearInvitationToken() => $_clearField(16);

  @$pb.TagNumber(17)
  $core.String get invitationExpiresAt => $_getSZ(16);
  @$pb.TagNumber(17)
  set invitationExpiresAt($core.String value) => $_setString(16, value);
  @$pb.TagNumber(17)
  $core.bool hasInvitationExpiresAt() => $_has(16);
  @$pb.TagNumber(17)
  void clearInvitationExpiresAt() => $_clearField(17);

  @$pb.TagNumber(18)
  $core.String get cardLastFour => $_getSZ(17);
  @$pb.TagNumber(18)
  set cardLastFour($core.String value) => $_setString(17, value);
  @$pb.TagNumber(18)
  $core.bool hasCardLastFour() => $_has(17);
  @$pb.TagNumber(18)
  void clearCardLastFour() => $_clearField(18);

  @$pb.TagNumber(19)
  $core.bool get hasCard => $_getBF(18);
  @$pb.TagNumber(19)
  set hasCard($core.bool value) => $_setBool(18, value);
  @$pb.TagNumber(19)
  $core.bool hasHasCard() => $_has(18);
  @$pb.TagNumber(19)
  void clearHasCard() => $_clearField(19);

  @$pb.TagNumber(20)
  $core.String get joinedAt => $_getSZ(19);
  @$pb.TagNumber(20)
  set joinedAt($core.String value) => $_setString(19, value);
  @$pb.TagNumber(20)
  $core.bool hasJoinedAt() => $_has(19);
  @$pb.TagNumber(20)
  void clearJoinedAt() => $_clearField(20);

  @$pb.TagNumber(21)
  $core.String get createdAt => $_getSZ(20);
  @$pb.TagNumber(21)
  set createdAt($core.String value) => $_setString(20, value);
  @$pb.TagNumber(21)
  $core.bool hasCreatedAt() => $_has(20);
  @$pb.TagNumber(21)
  void clearCreatedAt() => $_clearField(21);

  @$pb.TagNumber(22)
  $core.String get updatedAt => $_getSZ(21);
  @$pb.TagNumber(22)
  set updatedAt($core.String value) => $_setString(21, value);
  @$pb.TagNumber(22)
  $core.bool hasUpdatedAt() => $_has(21);
  @$pb.TagNumber(22)
  void clearUpdatedAt() => $_clearField(22);

  @$pb.TagNumber(23)
  $core.double get perTransactionLimit => $_getN(22);
  @$pb.TagNumber(23)
  set perTransactionLimit($core.double value) => $_setDouble(22, value);
  @$pb.TagNumber(23)
  $core.bool hasPerTransactionLimit() => $_has(22);
  @$pb.TagNumber(23)
  void clearPerTransactionLimit() => $_clearField(23);

  @$pb.TagNumber(24)
  $core.double get allocationPercentageCap => $_getN(23);
  @$pb.TagNumber(24)
  set allocationPercentageCap($core.double value) => $_setDouble(23, value);
  @$pb.TagNumber(24)
  $core.bool hasAllocationPercentageCap() => $_has(23);
  @$pb.TagNumber(24)
  void clearAllocationPercentageCap() => $_clearField(24);

  @$pb.TagNumber(25)
  $core.double get remainingBalance => $_getN(24);
  @$pb.TagNumber(25)
  set remainingBalance($core.double value) => $_setDouble(24, value);
  @$pb.TagNumber(25)
  $core.bool hasRemainingBalance() => $_has(24);
  @$pb.TagNumber(25)
  void clearRemainingBalance() => $_clearField(25);

  @$pb.TagNumber(26)
  $core.bool get canContribute => $_getBF(25);
  @$pb.TagNumber(26)
  set canContribute($core.bool value) => $_setBool(25, value);
  @$pb.TagNumber(26)
  $core.bool hasCanContribute() => $_has(25);
  @$pb.TagNumber(26)
  void clearCanContribute() => $_clearField(26);
}

/// Family Transaction
class FamilyTransaction extends $pb.GeneratedMessage {
  factory FamilyTransaction({
    $core.String? id,
    $core.String? familyId,
    $core.String? memberId,
    $core.String? memberName,
    $core.String? memberAvatar,
    $core.String? transactionId,
    $core.double? amount,
    $core.String? type,
    $core.String? description,
    $core.String? merchantName,
    $core.String? merchantCategory,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? metadata,
    $core.String? createdAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (familyId != null) result.familyId = familyId;
    if (memberId != null) result.memberId = memberId;
    if (memberName != null) result.memberName = memberName;
    if (memberAvatar != null) result.memberAvatar = memberAvatar;
    if (transactionId != null) result.transactionId = transactionId;
    if (amount != null) result.amount = amount;
    if (type != null) result.type = type;
    if (description != null) result.description = description;
    if (merchantName != null) result.merchantName = merchantName;
    if (merchantCategory != null) result.merchantCategory = merchantCategory;
    if (metadata != null) result.metadata.addEntries(metadata);
    if (createdAt != null) result.createdAt = createdAt;
    return result;
  }

  FamilyTransaction._();

  factory FamilyTransaction.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FamilyTransaction.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FamilyTransaction',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'familyId')
    ..aOS(3, _omitFieldNames ? '' : 'memberId')
    ..aOS(4, _omitFieldNames ? '' : 'memberName')
    ..aOS(5, _omitFieldNames ? '' : 'memberAvatar')
    ..aOS(6, _omitFieldNames ? '' : 'transactionId')
    ..a<$core.double>(7, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(8, _omitFieldNames ? '' : 'type')
    ..aOS(9, _omitFieldNames ? '' : 'description')
    ..aOS(10, _omitFieldNames ? '' : 'merchantName')
    ..aOS(11, _omitFieldNames ? '' : 'merchantCategory')
    ..m<$core.String, $core.String>(12, _omitFieldNames ? '' : 'metadata',
        entryClassName: 'FamilyTransaction.MetadataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('accounts.v1'))
    ..aOS(13, _omitFieldNames ? '' : 'createdAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FamilyTransaction clone() => FamilyTransaction()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FamilyTransaction copyWith(void Function(FamilyTransaction) updates) =>
      super.copyWith((message) => updates(message as FamilyTransaction))
          as FamilyTransaction;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FamilyTransaction create() => FamilyTransaction._();
  @$core.override
  FamilyTransaction createEmptyInstance() => create();
  static $pb.PbList<FamilyTransaction> createRepeated() =>
      $pb.PbList<FamilyTransaction>();
  @$core.pragma('dart2js:noInline')
  static FamilyTransaction getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FamilyTransaction>(create);
  static FamilyTransaction? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get familyId => $_getSZ(1);
  @$pb.TagNumber(2)
  set familyId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasFamilyId() => $_has(1);
  @$pb.TagNumber(2)
  void clearFamilyId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get memberId => $_getSZ(2);
  @$pb.TagNumber(3)
  set memberId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMemberId() => $_has(2);
  @$pb.TagNumber(3)
  void clearMemberId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get memberName => $_getSZ(3);
  @$pb.TagNumber(4)
  set memberName($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMemberName() => $_has(3);
  @$pb.TagNumber(4)
  void clearMemberName() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get memberAvatar => $_getSZ(4);
  @$pb.TagNumber(5)
  set memberAvatar($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasMemberAvatar() => $_has(4);
  @$pb.TagNumber(5)
  void clearMemberAvatar() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get transactionId => $_getSZ(5);
  @$pb.TagNumber(6)
  set transactionId($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasTransactionId() => $_has(5);
  @$pb.TagNumber(6)
  void clearTransactionId() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.double get amount => $_getN(6);
  @$pb.TagNumber(7)
  set amount($core.double value) => $_setDouble(6, value);
  @$pb.TagNumber(7)
  $core.bool hasAmount() => $_has(6);
  @$pb.TagNumber(7)
  void clearAmount() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get type => $_getSZ(7);
  @$pb.TagNumber(8)
  set type($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasType() => $_has(7);
  @$pb.TagNumber(8)
  void clearType() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get description => $_getSZ(8);
  @$pb.TagNumber(9)
  set description($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasDescription() => $_has(8);
  @$pb.TagNumber(9)
  void clearDescription() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get merchantName => $_getSZ(9);
  @$pb.TagNumber(10)
  set merchantName($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasMerchantName() => $_has(9);
  @$pb.TagNumber(10)
  void clearMerchantName() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get merchantCategory => $_getSZ(10);
  @$pb.TagNumber(11)
  set merchantCategory($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasMerchantCategory() => $_has(10);
  @$pb.TagNumber(11)
  void clearMerchantCategory() => $_clearField(11);

  @$pb.TagNumber(12)
  $pb.PbMap<$core.String, $core.String> get metadata => $_getMap(11);

  @$pb.TagNumber(13)
  $core.String get createdAt => $_getSZ(12);
  @$pb.TagNumber(13)
  set createdAt($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasCreatedAt() => $_has(12);
  @$pb.TagNumber(13)
  void clearCreatedAt() => $_clearField(13);
}

/// Pending Invitation
class PendingInvitation extends $pb.GeneratedMessage {
  factory PendingInvitation({
    $core.String? invitationToken,
    $core.String? familyId,
    $core.String? familyName,
    $core.String? creatorName,
    $core.String? creatorAvatar,
    $core.double? initialAllocation,
    $core.double? dailyLimit,
    $core.double? monthlyLimit,
    $core.String? invitedBy,
    $core.String? expiresAt,
    $core.String? createdAt,
  }) {
    final result = create();
    if (invitationToken != null) result.invitationToken = invitationToken;
    if (familyId != null) result.familyId = familyId;
    if (familyName != null) result.familyName = familyName;
    if (creatorName != null) result.creatorName = creatorName;
    if (creatorAvatar != null) result.creatorAvatar = creatorAvatar;
    if (initialAllocation != null) result.initialAllocation = initialAllocation;
    if (dailyLimit != null) result.dailyLimit = dailyLimit;
    if (monthlyLimit != null) result.monthlyLimit = monthlyLimit;
    if (invitedBy != null) result.invitedBy = invitedBy;
    if (expiresAt != null) result.expiresAt = expiresAt;
    if (createdAt != null) result.createdAt = createdAt;
    return result;
  }

  PendingInvitation._();

  factory PendingInvitation.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PendingInvitation.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PendingInvitation',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'invitationToken')
    ..aOS(2, _omitFieldNames ? '' : 'familyId')
    ..aOS(3, _omitFieldNames ? '' : 'familyName')
    ..aOS(4, _omitFieldNames ? '' : 'creatorName')
    ..aOS(5, _omitFieldNames ? '' : 'creatorAvatar')
    ..a<$core.double>(
        6, _omitFieldNames ? '' : 'initialAllocation', $pb.PbFieldType.OD)
    ..a<$core.double>(
        7, _omitFieldNames ? '' : 'dailyLimit', $pb.PbFieldType.OD)
    ..a<$core.double>(
        8, _omitFieldNames ? '' : 'monthlyLimit', $pb.PbFieldType.OD)
    ..aOS(9, _omitFieldNames ? '' : 'invitedBy')
    ..aOS(10, _omitFieldNames ? '' : 'expiresAt')
    ..aOS(11, _omitFieldNames ? '' : 'createdAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PendingInvitation clone() => PendingInvitation()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PendingInvitation copyWith(void Function(PendingInvitation) updates) =>
      super.copyWith((message) => updates(message as PendingInvitation))
          as PendingInvitation;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PendingInvitation create() => PendingInvitation._();
  @$core.override
  PendingInvitation createEmptyInstance() => create();
  static $pb.PbList<PendingInvitation> createRepeated() =>
      $pb.PbList<PendingInvitation>();
  @$core.pragma('dart2js:noInline')
  static PendingInvitation getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PendingInvitation>(create);
  static PendingInvitation? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get invitationToken => $_getSZ(0);
  @$pb.TagNumber(1)
  set invitationToken($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasInvitationToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvitationToken() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get familyId => $_getSZ(1);
  @$pb.TagNumber(2)
  set familyId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasFamilyId() => $_has(1);
  @$pb.TagNumber(2)
  void clearFamilyId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get familyName => $_getSZ(2);
  @$pb.TagNumber(3)
  set familyName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasFamilyName() => $_has(2);
  @$pb.TagNumber(3)
  void clearFamilyName() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get creatorName => $_getSZ(3);
  @$pb.TagNumber(4)
  set creatorName($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCreatorName() => $_has(3);
  @$pb.TagNumber(4)
  void clearCreatorName() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get creatorAvatar => $_getSZ(4);
  @$pb.TagNumber(5)
  set creatorAvatar($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCreatorAvatar() => $_has(4);
  @$pb.TagNumber(5)
  void clearCreatorAvatar() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.double get initialAllocation => $_getN(5);
  @$pb.TagNumber(6)
  set initialAllocation($core.double value) => $_setDouble(5, value);
  @$pb.TagNumber(6)
  $core.bool hasInitialAllocation() => $_has(5);
  @$pb.TagNumber(6)
  void clearInitialAllocation() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.double get dailyLimit => $_getN(6);
  @$pb.TagNumber(7)
  set dailyLimit($core.double value) => $_setDouble(6, value);
  @$pb.TagNumber(7)
  $core.bool hasDailyLimit() => $_has(6);
  @$pb.TagNumber(7)
  void clearDailyLimit() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.double get monthlyLimit => $_getN(7);
  @$pb.TagNumber(8)
  set monthlyLimit($core.double value) => $_setDouble(7, value);
  @$pb.TagNumber(8)
  $core.bool hasMonthlyLimit() => $_has(7);
  @$pb.TagNumber(8)
  void clearMonthlyLimit() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get invitedBy => $_getSZ(8);
  @$pb.TagNumber(9)
  set invitedBy($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasInvitedBy() => $_has(8);
  @$pb.TagNumber(9)
  void clearInvitedBy() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get expiresAt => $_getSZ(9);
  @$pb.TagNumber(10)
  set expiresAt($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasExpiresAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearExpiresAt() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get createdAt => $_getSZ(10);
  @$pb.TagNumber(11)
  set createdAt($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasCreatedAt() => $_has(10);
  @$pb.TagNumber(11)
  void clearCreatedAt() => $_clearField(11);
}

/// Family Account Summary
class FamilyAccountSummary extends $pb.GeneratedMessage {
  factory FamilyAccountSummary({
    $core.double? totalAllocated,
    $core.double? totalSpentThisMonth,
    $core.double? totalSpentToday,
    $core.int? transactionCountThisMonth,
    $core.Iterable<FamilyMemberSpending>? topSpenders,
    $core.double? totalContributed,
    $core.Iterable<FamilyMemberSpending>? topFunders,
  }) {
    final result = create();
    if (totalAllocated != null) result.totalAllocated = totalAllocated;
    if (totalSpentThisMonth != null)
      result.totalSpentThisMonth = totalSpentThisMonth;
    if (totalSpentToday != null) result.totalSpentToday = totalSpentToday;
    if (transactionCountThisMonth != null)
      result.transactionCountThisMonth = transactionCountThisMonth;
    if (topSpenders != null) result.topSpenders.addAll(topSpenders);
    if (totalContributed != null) result.totalContributed = totalContributed;
    if (topFunders != null) result.topFunders.addAll(topFunders);
    return result;
  }

  FamilyAccountSummary._();

  factory FamilyAccountSummary.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FamilyAccountSummary.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FamilyAccountSummary',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts.v1'),
      createEmptyInstance: create)
    ..a<$core.double>(
        1, _omitFieldNames ? '' : 'totalAllocated', $pb.PbFieldType.OD)
    ..a<$core.double>(
        2, _omitFieldNames ? '' : 'totalSpentThisMonth', $pb.PbFieldType.OD)
    ..a<$core.double>(
        3, _omitFieldNames ? '' : 'totalSpentToday', $pb.PbFieldType.OD)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'transactionCountThisMonth',
        $pb.PbFieldType.O3)
    ..pc<FamilyMemberSpending>(
        5, _omitFieldNames ? '' : 'topSpenders', $pb.PbFieldType.PM,
        subBuilder: FamilyMemberSpending.create)
    ..a<$core.double>(
        6, _omitFieldNames ? '' : 'totalContributed', $pb.PbFieldType.OD)
    ..pc<FamilyMemberSpending>(
        7, _omitFieldNames ? '' : 'topFunders', $pb.PbFieldType.PM,
        subBuilder: FamilyMemberSpending.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FamilyAccountSummary clone() =>
      FamilyAccountSummary()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FamilyAccountSummary copyWith(void Function(FamilyAccountSummary) updates) =>
      super.copyWith((message) => updates(message as FamilyAccountSummary))
          as FamilyAccountSummary;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FamilyAccountSummary create() => FamilyAccountSummary._();
  @$core.override
  FamilyAccountSummary createEmptyInstance() => create();
  static $pb.PbList<FamilyAccountSummary> createRepeated() =>
      $pb.PbList<FamilyAccountSummary>();
  @$core.pragma('dart2js:noInline')
  static FamilyAccountSummary getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FamilyAccountSummary>(create);
  static FamilyAccountSummary? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get totalAllocated => $_getN(0);
  @$pb.TagNumber(1)
  set totalAllocated($core.double value) => $_setDouble(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTotalAllocated() => $_has(0);
  @$pb.TagNumber(1)
  void clearTotalAllocated() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get totalSpentThisMonth => $_getN(1);
  @$pb.TagNumber(2)
  set totalSpentThisMonth($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotalSpentThisMonth() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalSpentThisMonth() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get totalSpentToday => $_getN(2);
  @$pb.TagNumber(3)
  set totalSpentToday($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTotalSpentToday() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalSpentToday() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get transactionCountThisMonth => $_getIZ(3);
  @$pb.TagNumber(4)
  set transactionCountThisMonth($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTransactionCountThisMonth() => $_has(3);
  @$pb.TagNumber(4)
  void clearTransactionCountThisMonth() => $_clearField(4);

  @$pb.TagNumber(5)
  $pb.PbList<FamilyMemberSpending> get topSpenders => $_getList(4);

  @$pb.TagNumber(6)
  $core.double get totalContributed => $_getN(5);
  @$pb.TagNumber(6)
  set totalContributed($core.double value) => $_setDouble(5, value);
  @$pb.TagNumber(6)
  $core.bool hasTotalContributed() => $_has(5);
  @$pb.TagNumber(6)
  void clearTotalContributed() => $_clearField(6);

  @$pb.TagNumber(7)
  $pb.PbList<FamilyMemberSpending> get topFunders => $_getList(6);
}

/// Family Member Spending Stats
class FamilyMemberSpending extends $pb.GeneratedMessage {
  factory FamilyMemberSpending({
    $core.String? memberId,
    $core.String? memberName,
    $core.String? memberAvatar,
    $core.double? amountSpent,
    $core.int? transactionCount,
  }) {
    final result = create();
    if (memberId != null) result.memberId = memberId;
    if (memberName != null) result.memberName = memberName;
    if (memberAvatar != null) result.memberAvatar = memberAvatar;
    if (amountSpent != null) result.amountSpent = amountSpent;
    if (transactionCount != null) result.transactionCount = transactionCount;
    return result;
  }

  FamilyMemberSpending._();

  factory FamilyMemberSpending.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FamilyMemberSpending.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FamilyMemberSpending',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'accounts.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'memberId')
    ..aOS(2, _omitFieldNames ? '' : 'memberName')
    ..aOS(3, _omitFieldNames ? '' : 'memberAvatar')
    ..a<$core.double>(
        4, _omitFieldNames ? '' : 'amountSpent', $pb.PbFieldType.OD)
    ..a<$core.int>(
        5, _omitFieldNames ? '' : 'transactionCount', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FamilyMemberSpending clone() =>
      FamilyMemberSpending()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FamilyMemberSpending copyWith(void Function(FamilyMemberSpending) updates) =>
      super.copyWith((message) => updates(message as FamilyMemberSpending))
          as FamilyMemberSpending;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FamilyMemberSpending create() => FamilyMemberSpending._();
  @$core.override
  FamilyMemberSpending createEmptyInstance() => create();
  static $pb.PbList<FamilyMemberSpending> createRepeated() =>
      $pb.PbList<FamilyMemberSpending>();
  @$core.pragma('dart2js:noInline')
  static FamilyMemberSpending getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FamilyMemberSpending>(create);
  static FamilyMemberSpending? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get memberId => $_getSZ(0);
  @$pb.TagNumber(1)
  set memberId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMemberId() => $_has(0);
  @$pb.TagNumber(1)
  void clearMemberId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get memberName => $_getSZ(1);
  @$pb.TagNumber(2)
  set memberName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMemberName() => $_has(1);
  @$pb.TagNumber(2)
  void clearMemberName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get memberAvatar => $_getSZ(2);
  @$pb.TagNumber(3)
  set memberAvatar($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMemberAvatar() => $_has(2);
  @$pb.TagNumber(3)
  void clearMemberAvatar() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get amountSpent => $_getN(3);
  @$pb.TagNumber(4)
  set amountSpent($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAmountSpent() => $_has(3);
  @$pb.TagNumber(4)
  void clearAmountSpent() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get transactionCount => $_getIZ(4);
  @$pb.TagNumber(5)
  set transactionCount($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTransactionCount() => $_has(4);
  @$pb.TagNumber(5)
  void clearTransactionCount() => $_clearField(5);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
