// This is a generated file - do not edit.
//
// Generated from insurance.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

/// Inline pagination to avoid cross-proto package dependency
class InsurancePaginationInfo extends $pb.GeneratedMessage {
  factory InsurancePaginationInfo({
    $core.int? currentPage,
    $core.int? totalPages,
    $core.int? totalItems,
    $core.int? itemsPerPage,
    $core.bool? hasNext,
    $core.bool? hasPrev,
  }) {
    final result = create();
    if (currentPage != null) result.currentPage = currentPage;
    if (totalPages != null) result.totalPages = totalPages;
    if (totalItems != null) result.totalItems = totalItems;
    if (itemsPerPage != null) result.itemsPerPage = itemsPerPage;
    if (hasNext != null) result.hasNext = hasNext;
    if (hasPrev != null) result.hasPrev = hasPrev;
    return result;
  }

  InsurancePaginationInfo._();

  factory InsurancePaginationInfo.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InsurancePaginationInfo.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InsurancePaginationInfo',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'currentPage', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'totalPages', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'totalItems', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'itemsPerPage', $pb.PbFieldType.O3)
    ..aOB(5, _omitFieldNames ? '' : 'hasNext')
    ..aOB(6, _omitFieldNames ? '' : 'hasPrev')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InsurancePaginationInfo clone() =>
      InsurancePaginationInfo()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InsurancePaginationInfo copyWith(
          void Function(InsurancePaginationInfo) updates) =>
      super.copyWith((message) => updates(message as InsurancePaginationInfo))
          as InsurancePaginationInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InsurancePaginationInfo create() => InsurancePaginationInfo._();
  @$core.override
  InsurancePaginationInfo createEmptyInstance() => create();
  static $pb.PbList<InsurancePaginationInfo> createRepeated() =>
      $pb.PbList<InsurancePaginationInfo>();
  @$core.pragma('dart2js:noInline')
  static InsurancePaginationInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InsurancePaginationInfo>(create);
  static InsurancePaginationInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get currentPage => $_getIZ(0);
  @$pb.TagNumber(1)
  set currentPage($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCurrentPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearCurrentPage() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get totalPages => $_getIZ(1);
  @$pb.TagNumber(2)
  set totalPages($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotalPages() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalPages() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get totalItems => $_getIZ(2);
  @$pb.TagNumber(3)
  set totalItems($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTotalItems() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalItems() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get itemsPerPage => $_getIZ(3);
  @$pb.TagNumber(4)
  set itemsPerPage($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasItemsPerPage() => $_has(3);
  @$pb.TagNumber(4)
  void clearItemsPerPage() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.bool get hasNext => $_getBF(4);
  @$pb.TagNumber(5)
  set hasNext($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasHasNext() => $_has(4);
  @$pb.TagNumber(5)
  void clearHasNext() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.bool get hasPrev => $_getBF(5);
  @$pb.TagNumber(6)
  set hasPrev($core.bool value) => $_setBool(5, value);
  @$pb.TagNumber(6)
  $core.bool hasHasPrev() => $_has(5);
  @$pb.TagNumber(6)
  void clearHasPrev() => $_clearField(6);
}

/// Insurance Policy Management
class GetUserInsurancesRequest extends $pb.GeneratedMessage {
  factory GetUserInsurancesRequest({
    $core.int? page,
    $core.int? limit,
  }) {
    final result = create();
    if (page != null) result.page = page;
    if (limit != null) result.limit = limit;
    return result;
  }

  GetUserInsurancesRequest._();

  factory GetUserInsurancesRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetUserInsurancesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUserInsurancesRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserInsurancesRequest clone() =>
      GetUserInsurancesRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserInsurancesRequest copyWith(
          void Function(GetUserInsurancesRequest) updates) =>
      super.copyWith((message) => updates(message as GetUserInsurancesRequest))
          as GetUserInsurancesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserInsurancesRequest create() => GetUserInsurancesRequest._();
  @$core.override
  GetUserInsurancesRequest createEmptyInstance() => create();
  static $pb.PbList<GetUserInsurancesRequest> createRepeated() =>
      $pb.PbList<GetUserInsurancesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetUserInsurancesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUserInsurancesRequest>(create);
  static GetUserInsurancesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get page => $_getIZ(0);
  @$pb.TagNumber(1)
  set page($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearPage() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get limit => $_getIZ(1);
  @$pb.TagNumber(2)
  set limit($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => $_clearField(2);
}

class GetUserInsurancesResponse extends $pb.GeneratedMessage {
  factory GetUserInsurancesResponse({
    $core.Iterable<Insurance>? insurances,
    InsurancePaginationInfo? pagination,
    $core.bool? success,
    $core.String? msg,
  }) {
    final result = create();
    if (insurances != null) result.insurances.addAll(insurances);
    if (pagination != null) result.pagination = pagination;
    if (success != null) result.success = success;
    if (msg != null) result.msg = msg;
    return result;
  }

  GetUserInsurancesResponse._();

  factory GetUserInsurancesResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetUserInsurancesResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUserInsurancesResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<Insurance>(1, _omitFieldNames ? '' : 'insurances', $pb.PbFieldType.PM,
        subBuilder: Insurance.create)
    ..aOM<InsurancePaginationInfo>(2, _omitFieldNames ? '' : 'pagination',
        subBuilder: InsurancePaginationInfo.create)
    ..aOB(3, _omitFieldNames ? '' : 'success')
    ..aOS(4, _omitFieldNames ? '' : 'msg')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserInsurancesResponse clone() =>
      GetUserInsurancesResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserInsurancesResponse copyWith(
          void Function(GetUserInsurancesResponse) updates) =>
      super.copyWith((message) => updates(message as GetUserInsurancesResponse))
          as GetUserInsurancesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserInsurancesResponse create() => GetUserInsurancesResponse._();
  @$core.override
  GetUserInsurancesResponse createEmptyInstance() => create();
  static $pb.PbList<GetUserInsurancesResponse> createRepeated() =>
      $pb.PbList<GetUserInsurancesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetUserInsurancesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUserInsurancesResponse>(create);
  static GetUserInsurancesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Insurance> get insurances => $_getList(0);

  @$pb.TagNumber(2)
  InsurancePaginationInfo get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination(InsurancePaginationInfo value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => $_clearField(2);
  @$pb.TagNumber(2)
  InsurancePaginationInfo ensurePagination() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.bool get success => $_getBF(2);
  @$pb.TagNumber(3)
  set success($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSuccess() => $_has(2);
  @$pb.TagNumber(3)
  void clearSuccess() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get msg => $_getSZ(3);
  @$pb.TagNumber(4)
  set msg($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMsg() => $_has(3);
  @$pb.TagNumber(4)
  void clearMsg() => $_clearField(4);
}

class GetInsuranceByIdRequest extends $pb.GeneratedMessage {
  factory GetInsuranceByIdRequest({
    $core.String? id,
  }) {
    final result = create();
    if (id != null) result.id = id;
    return result;
  }

  GetInsuranceByIdRequest._();

  factory GetInsuranceByIdRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInsuranceByIdRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInsuranceByIdRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsuranceByIdRequest clone() =>
      GetInsuranceByIdRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsuranceByIdRequest copyWith(
          void Function(GetInsuranceByIdRequest) updates) =>
      super.copyWith((message) => updates(message as GetInsuranceByIdRequest))
          as GetInsuranceByIdRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInsuranceByIdRequest create() => GetInsuranceByIdRequest._();
  @$core.override
  GetInsuranceByIdRequest createEmptyInstance() => create();
  static $pb.PbList<GetInsuranceByIdRequest> createRepeated() =>
      $pb.PbList<GetInsuranceByIdRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInsuranceByIdRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetInsuranceByIdRequest>(create);
  static GetInsuranceByIdRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);
}

class GetInsuranceByIdResponse extends $pb.GeneratedMessage {
  factory GetInsuranceByIdResponse({
    Insurance? insurance,
    $core.bool? success,
    $core.String? msg,
  }) {
    final result = create();
    if (insurance != null) result.insurance = insurance;
    if (success != null) result.success = success;
    if (msg != null) result.msg = msg;
    return result;
  }

  GetInsuranceByIdResponse._();

  factory GetInsuranceByIdResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInsuranceByIdResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInsuranceByIdResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<Insurance>(1, _omitFieldNames ? '' : 'insurance',
        subBuilder: Insurance.create)
    ..aOB(2, _omitFieldNames ? '' : 'success')
    ..aOS(3, _omitFieldNames ? '' : 'msg')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsuranceByIdResponse clone() =>
      GetInsuranceByIdResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsuranceByIdResponse copyWith(
          void Function(GetInsuranceByIdResponse) updates) =>
      super.copyWith((message) => updates(message as GetInsuranceByIdResponse))
          as GetInsuranceByIdResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInsuranceByIdResponse create() => GetInsuranceByIdResponse._();
  @$core.override
  GetInsuranceByIdResponse createEmptyInstance() => create();
  static $pb.PbList<GetInsuranceByIdResponse> createRepeated() =>
      $pb.PbList<GetInsuranceByIdResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInsuranceByIdResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetInsuranceByIdResponse>(create);
  static GetInsuranceByIdResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Insurance get insurance => $_getN(0);
  @$pb.TagNumber(1)
  set insurance(Insurance value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasInsurance() => $_has(0);
  @$pb.TagNumber(1)
  void clearInsurance() => $_clearField(1);
  @$pb.TagNumber(1)
  Insurance ensureInsurance() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get msg => $_getSZ(2);
  @$pb.TagNumber(3)
  set msg($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMsg() => $_has(2);
  @$pb.TagNumber(3)
  void clearMsg() => $_clearField(3);
}

class CreateInsuranceRequest extends $pb.GeneratedMessage {
  factory CreateInsuranceRequest({
    Insurance? insurance,
  }) {
    final result = create();
    if (insurance != null) result.insurance = insurance;
    return result;
  }

  CreateInsuranceRequest._();

  factory CreateInsuranceRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateInsuranceRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateInsuranceRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<Insurance>(1, _omitFieldNames ? '' : 'insurance',
        subBuilder: Insurance.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateInsuranceRequest clone() =>
      CreateInsuranceRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateInsuranceRequest copyWith(
          void Function(CreateInsuranceRequest) updates) =>
      super.copyWith((message) => updates(message as CreateInsuranceRequest))
          as CreateInsuranceRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateInsuranceRequest create() => CreateInsuranceRequest._();
  @$core.override
  CreateInsuranceRequest createEmptyInstance() => create();
  static $pb.PbList<CreateInsuranceRequest> createRepeated() =>
      $pb.PbList<CreateInsuranceRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateInsuranceRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateInsuranceRequest>(create);
  static CreateInsuranceRequest? _defaultInstance;

  @$pb.TagNumber(1)
  Insurance get insurance => $_getN(0);
  @$pb.TagNumber(1)
  set insurance(Insurance value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasInsurance() => $_has(0);
  @$pb.TagNumber(1)
  void clearInsurance() => $_clearField(1);
  @$pb.TagNumber(1)
  Insurance ensureInsurance() => $_ensure(0);
}

class CreateInsuranceResponse extends $pb.GeneratedMessage {
  factory CreateInsuranceResponse({
    Insurance? insurance,
    $core.bool? success,
    $core.String? msg,
  }) {
    final result = create();
    if (insurance != null) result.insurance = insurance;
    if (success != null) result.success = success;
    if (msg != null) result.msg = msg;
    return result;
  }

  CreateInsuranceResponse._();

  factory CreateInsuranceResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateInsuranceResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateInsuranceResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<Insurance>(1, _omitFieldNames ? '' : 'insurance',
        subBuilder: Insurance.create)
    ..aOB(2, _omitFieldNames ? '' : 'success')
    ..aOS(3, _omitFieldNames ? '' : 'msg')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateInsuranceResponse clone() =>
      CreateInsuranceResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateInsuranceResponse copyWith(
          void Function(CreateInsuranceResponse) updates) =>
      super.copyWith((message) => updates(message as CreateInsuranceResponse))
          as CreateInsuranceResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateInsuranceResponse create() => CreateInsuranceResponse._();
  @$core.override
  CreateInsuranceResponse createEmptyInstance() => create();
  static $pb.PbList<CreateInsuranceResponse> createRepeated() =>
      $pb.PbList<CreateInsuranceResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateInsuranceResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateInsuranceResponse>(create);
  static CreateInsuranceResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Insurance get insurance => $_getN(0);
  @$pb.TagNumber(1)
  set insurance(Insurance value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasInsurance() => $_has(0);
  @$pb.TagNumber(1)
  void clearInsurance() => $_clearField(1);
  @$pb.TagNumber(1)
  Insurance ensureInsurance() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get msg => $_getSZ(2);
  @$pb.TagNumber(3)
  set msg($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMsg() => $_has(2);
  @$pb.TagNumber(3)
  void clearMsg() => $_clearField(3);
}

class UpdateInsuranceRequest extends $pb.GeneratedMessage {
  factory UpdateInsuranceRequest({
    Insurance? insurance,
  }) {
    final result = create();
    if (insurance != null) result.insurance = insurance;
    return result;
  }

  UpdateInsuranceRequest._();

  factory UpdateInsuranceRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateInsuranceRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateInsuranceRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<Insurance>(1, _omitFieldNames ? '' : 'insurance',
        subBuilder: Insurance.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateInsuranceRequest clone() =>
      UpdateInsuranceRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateInsuranceRequest copyWith(
          void Function(UpdateInsuranceRequest) updates) =>
      super.copyWith((message) => updates(message as UpdateInsuranceRequest))
          as UpdateInsuranceRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateInsuranceRequest create() => UpdateInsuranceRequest._();
  @$core.override
  UpdateInsuranceRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateInsuranceRequest> createRepeated() =>
      $pb.PbList<UpdateInsuranceRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateInsuranceRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateInsuranceRequest>(create);
  static UpdateInsuranceRequest? _defaultInstance;

  @$pb.TagNumber(1)
  Insurance get insurance => $_getN(0);
  @$pb.TagNumber(1)
  set insurance(Insurance value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasInsurance() => $_has(0);
  @$pb.TagNumber(1)
  void clearInsurance() => $_clearField(1);
  @$pb.TagNumber(1)
  Insurance ensureInsurance() => $_ensure(0);
}

class UpdateInsuranceResponse extends $pb.GeneratedMessage {
  factory UpdateInsuranceResponse({
    Insurance? insurance,
    $core.bool? success,
    $core.String? msg,
  }) {
    final result = create();
    if (insurance != null) result.insurance = insurance;
    if (success != null) result.success = success;
    if (msg != null) result.msg = msg;
    return result;
  }

  UpdateInsuranceResponse._();

  factory UpdateInsuranceResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateInsuranceResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateInsuranceResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<Insurance>(1, _omitFieldNames ? '' : 'insurance',
        subBuilder: Insurance.create)
    ..aOB(2, _omitFieldNames ? '' : 'success')
    ..aOS(3, _omitFieldNames ? '' : 'msg')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateInsuranceResponse clone() =>
      UpdateInsuranceResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateInsuranceResponse copyWith(
          void Function(UpdateInsuranceResponse) updates) =>
      super.copyWith((message) => updates(message as UpdateInsuranceResponse))
          as UpdateInsuranceResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateInsuranceResponse create() => UpdateInsuranceResponse._();
  @$core.override
  UpdateInsuranceResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateInsuranceResponse> createRepeated() =>
      $pb.PbList<UpdateInsuranceResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateInsuranceResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateInsuranceResponse>(create);
  static UpdateInsuranceResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Insurance get insurance => $_getN(0);
  @$pb.TagNumber(1)
  set insurance(Insurance value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasInsurance() => $_has(0);
  @$pb.TagNumber(1)
  void clearInsurance() => $_clearField(1);
  @$pb.TagNumber(1)
  Insurance ensureInsurance() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get msg => $_getSZ(2);
  @$pb.TagNumber(3)
  set msg($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMsg() => $_has(2);
  @$pb.TagNumber(3)
  void clearMsg() => $_clearField(3);
}

class DeleteInsuranceRequest extends $pb.GeneratedMessage {
  factory DeleteInsuranceRequest({
    $core.String? id,
  }) {
    final result = create();
    if (id != null) result.id = id;
    return result;
  }

  DeleteInsuranceRequest._();

  factory DeleteInsuranceRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeleteInsuranceRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteInsuranceRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteInsuranceRequest clone() =>
      DeleteInsuranceRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteInsuranceRequest copyWith(
          void Function(DeleteInsuranceRequest) updates) =>
      super.copyWith((message) => updates(message as DeleteInsuranceRequest))
          as DeleteInsuranceRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteInsuranceRequest create() => DeleteInsuranceRequest._();
  @$core.override
  DeleteInsuranceRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteInsuranceRequest> createRepeated() =>
      $pb.PbList<DeleteInsuranceRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteInsuranceRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteInsuranceRequest>(create);
  static DeleteInsuranceRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);
}

class DeleteInsuranceResponse extends $pb.GeneratedMessage {
  factory DeleteInsuranceResponse({
    $core.bool? success,
    $core.String? msg,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (msg != null) result.msg = msg;
    return result;
  }

  DeleteInsuranceResponse._();

  factory DeleteInsuranceResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeleteInsuranceResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteInsuranceResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'msg')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteInsuranceResponse clone() =>
      DeleteInsuranceResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteInsuranceResponse copyWith(
          void Function(DeleteInsuranceResponse) updates) =>
      super.copyWith((message) => updates(message as DeleteInsuranceResponse))
          as DeleteInsuranceResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteInsuranceResponse create() => DeleteInsuranceResponse._();
  @$core.override
  DeleteInsuranceResponse createEmptyInstance() => create();
  static $pb.PbList<DeleteInsuranceResponse> createRepeated() =>
      $pb.PbList<DeleteInsuranceResponse>();
  @$core.pragma('dart2js:noInline')
  static DeleteInsuranceResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteInsuranceResponse>(create);
  static DeleteInsuranceResponse? _defaultInstance;

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

class SearchInsurancesRequest extends $pb.GeneratedMessage {
  factory SearchInsurancesRequest({
    $core.String? query,
    $core.int? page,
    $core.int? limit,
  }) {
    final result = create();
    if (query != null) result.query = query;
    if (page != null) result.page = page;
    if (limit != null) result.limit = limit;
    return result;
  }

  SearchInsurancesRequest._();

  factory SearchInsurancesRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SearchInsurancesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SearchInsurancesRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'query')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchInsurancesRequest clone() =>
      SearchInsurancesRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchInsurancesRequest copyWith(
          void Function(SearchInsurancesRequest) updates) =>
      super.copyWith((message) => updates(message as SearchInsurancesRequest))
          as SearchInsurancesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SearchInsurancesRequest create() => SearchInsurancesRequest._();
  @$core.override
  SearchInsurancesRequest createEmptyInstance() => create();
  static $pb.PbList<SearchInsurancesRequest> createRepeated() =>
      $pb.PbList<SearchInsurancesRequest>();
  @$core.pragma('dart2js:noInline')
  static SearchInsurancesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SearchInsurancesRequest>(create);
  static SearchInsurancesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get query => $_getSZ(0);
  @$pb.TagNumber(1)
  set query($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasQuery() => $_has(0);
  @$pb.TagNumber(1)
  void clearQuery() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get page => $_getIZ(1);
  @$pb.TagNumber(2)
  set page($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPage() => $_has(1);
  @$pb.TagNumber(2)
  void clearPage() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get limit => $_getIZ(2);
  @$pb.TagNumber(3)
  set limit($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLimit() => $_has(2);
  @$pb.TagNumber(3)
  void clearLimit() => $_clearField(3);
}

class SearchInsurancesResponse extends $pb.GeneratedMessage {
  factory SearchInsurancesResponse({
    $core.Iterable<Insurance>? insurances,
    InsurancePaginationInfo? pagination,
    $core.bool? success,
    $core.String? msg,
  }) {
    final result = create();
    if (insurances != null) result.insurances.addAll(insurances);
    if (pagination != null) result.pagination = pagination;
    if (success != null) result.success = success;
    if (msg != null) result.msg = msg;
    return result;
  }

  SearchInsurancesResponse._();

  factory SearchInsurancesResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SearchInsurancesResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SearchInsurancesResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<Insurance>(1, _omitFieldNames ? '' : 'insurances', $pb.PbFieldType.PM,
        subBuilder: Insurance.create)
    ..aOM<InsurancePaginationInfo>(2, _omitFieldNames ? '' : 'pagination',
        subBuilder: InsurancePaginationInfo.create)
    ..aOB(3, _omitFieldNames ? '' : 'success')
    ..aOS(4, _omitFieldNames ? '' : 'msg')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchInsurancesResponse clone() =>
      SearchInsurancesResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchInsurancesResponse copyWith(
          void Function(SearchInsurancesResponse) updates) =>
      super.copyWith((message) => updates(message as SearchInsurancesResponse))
          as SearchInsurancesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SearchInsurancesResponse create() => SearchInsurancesResponse._();
  @$core.override
  SearchInsurancesResponse createEmptyInstance() => create();
  static $pb.PbList<SearchInsurancesResponse> createRepeated() =>
      $pb.PbList<SearchInsurancesResponse>();
  @$core.pragma('dart2js:noInline')
  static SearchInsurancesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SearchInsurancesResponse>(create);
  static SearchInsurancesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Insurance> get insurances => $_getList(0);

  @$pb.TagNumber(2)
  InsurancePaginationInfo get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination(InsurancePaginationInfo value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => $_clearField(2);
  @$pb.TagNumber(2)
  InsurancePaginationInfo ensurePagination() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.bool get success => $_getBF(2);
  @$pb.TagNumber(3)
  set success($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSuccess() => $_has(2);
  @$pb.TagNumber(3)
  void clearSuccess() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get msg => $_getSZ(3);
  @$pb.TagNumber(4)
  set msg($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMsg() => $_has(3);
  @$pb.TagNumber(4)
  void clearMsg() => $_clearField(4);
}

/// Payment Management
class GetInsurancePaymentsRequest extends $pb.GeneratedMessage {
  factory GetInsurancePaymentsRequest({
    $core.String? insuranceId,
    $core.int? page,
    $core.int? limit,
  }) {
    final result = create();
    if (insuranceId != null) result.insuranceId = insuranceId;
    if (page != null) result.page = page;
    if (limit != null) result.limit = limit;
    return result;
  }

  GetInsurancePaymentsRequest._();

  factory GetInsurancePaymentsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInsurancePaymentsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInsurancePaymentsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'insuranceId')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsurancePaymentsRequest clone() =>
      GetInsurancePaymentsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsurancePaymentsRequest copyWith(
          void Function(GetInsurancePaymentsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetInsurancePaymentsRequest))
          as GetInsurancePaymentsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInsurancePaymentsRequest create() =>
      GetInsurancePaymentsRequest._();
  @$core.override
  GetInsurancePaymentsRequest createEmptyInstance() => create();
  static $pb.PbList<GetInsurancePaymentsRequest> createRepeated() =>
      $pb.PbList<GetInsurancePaymentsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInsurancePaymentsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetInsurancePaymentsRequest>(create);
  static GetInsurancePaymentsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get insuranceId => $_getSZ(0);
  @$pb.TagNumber(1)
  set insuranceId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasInsuranceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearInsuranceId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get page => $_getIZ(1);
  @$pb.TagNumber(2)
  set page($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPage() => $_has(1);
  @$pb.TagNumber(2)
  void clearPage() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get limit => $_getIZ(2);
  @$pb.TagNumber(3)
  set limit($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLimit() => $_has(2);
  @$pb.TagNumber(3)
  void clearLimit() => $_clearField(3);
}

class GetInsurancePaymentsResponse extends $pb.GeneratedMessage {
  factory GetInsurancePaymentsResponse({
    $core.Iterable<InsurancePayment>? payments,
    InsurancePaginationInfo? pagination,
    $core.bool? success,
    $core.String? msg,
  }) {
    final result = create();
    if (payments != null) result.payments.addAll(payments);
    if (pagination != null) result.pagination = pagination;
    if (success != null) result.success = success;
    if (msg != null) result.msg = msg;
    return result;
  }

  GetInsurancePaymentsResponse._();

  factory GetInsurancePaymentsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInsurancePaymentsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInsurancePaymentsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<InsurancePayment>(
        1, _omitFieldNames ? '' : 'payments', $pb.PbFieldType.PM,
        subBuilder: InsurancePayment.create)
    ..aOM<InsurancePaginationInfo>(2, _omitFieldNames ? '' : 'pagination',
        subBuilder: InsurancePaginationInfo.create)
    ..aOB(3, _omitFieldNames ? '' : 'success')
    ..aOS(4, _omitFieldNames ? '' : 'msg')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsurancePaymentsResponse clone() =>
      GetInsurancePaymentsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsurancePaymentsResponse copyWith(
          void Function(GetInsurancePaymentsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetInsurancePaymentsResponse))
          as GetInsurancePaymentsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInsurancePaymentsResponse create() =>
      GetInsurancePaymentsResponse._();
  @$core.override
  GetInsurancePaymentsResponse createEmptyInstance() => create();
  static $pb.PbList<GetInsurancePaymentsResponse> createRepeated() =>
      $pb.PbList<GetInsurancePaymentsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInsurancePaymentsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetInsurancePaymentsResponse>(create);
  static GetInsurancePaymentsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<InsurancePayment> get payments => $_getList(0);

  @$pb.TagNumber(2)
  InsurancePaginationInfo get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination(InsurancePaginationInfo value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => $_clearField(2);
  @$pb.TagNumber(2)
  InsurancePaginationInfo ensurePagination() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.bool get success => $_getBF(2);
  @$pb.TagNumber(3)
  set success($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSuccess() => $_has(2);
  @$pb.TagNumber(3)
  void clearSuccess() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get msg => $_getSZ(3);
  @$pb.TagNumber(4)
  set msg($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMsg() => $_has(3);
  @$pb.TagNumber(4)
  void clearMsg() => $_clearField(4);
}

class GetUserPaymentsRequest extends $pb.GeneratedMessage {
  factory GetUserPaymentsRequest({
    $core.int? page,
    $core.int? limit,
  }) {
    final result = create();
    if (page != null) result.page = page;
    if (limit != null) result.limit = limit;
    return result;
  }

  GetUserPaymentsRequest._();

  factory GetUserPaymentsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetUserPaymentsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUserPaymentsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserPaymentsRequest clone() =>
      GetUserPaymentsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserPaymentsRequest copyWith(
          void Function(GetUserPaymentsRequest) updates) =>
      super.copyWith((message) => updates(message as GetUserPaymentsRequest))
          as GetUserPaymentsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserPaymentsRequest create() => GetUserPaymentsRequest._();
  @$core.override
  GetUserPaymentsRequest createEmptyInstance() => create();
  static $pb.PbList<GetUserPaymentsRequest> createRepeated() =>
      $pb.PbList<GetUserPaymentsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetUserPaymentsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUserPaymentsRequest>(create);
  static GetUserPaymentsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get page => $_getIZ(0);
  @$pb.TagNumber(1)
  set page($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearPage() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get limit => $_getIZ(1);
  @$pb.TagNumber(2)
  set limit($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => $_clearField(2);
}

class GetUserPaymentsResponse extends $pb.GeneratedMessage {
  factory GetUserPaymentsResponse({
    $core.Iterable<InsurancePayment>? payments,
    InsurancePaginationInfo? pagination,
    $core.bool? success,
    $core.String? msg,
  }) {
    final result = create();
    if (payments != null) result.payments.addAll(payments);
    if (pagination != null) result.pagination = pagination;
    if (success != null) result.success = success;
    if (msg != null) result.msg = msg;
    return result;
  }

  GetUserPaymentsResponse._();

  factory GetUserPaymentsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetUserPaymentsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUserPaymentsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<InsurancePayment>(
        1, _omitFieldNames ? '' : 'payments', $pb.PbFieldType.PM,
        subBuilder: InsurancePayment.create)
    ..aOM<InsurancePaginationInfo>(2, _omitFieldNames ? '' : 'pagination',
        subBuilder: InsurancePaginationInfo.create)
    ..aOB(3, _omitFieldNames ? '' : 'success')
    ..aOS(4, _omitFieldNames ? '' : 'msg')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserPaymentsResponse clone() =>
      GetUserPaymentsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserPaymentsResponse copyWith(
          void Function(GetUserPaymentsResponse) updates) =>
      super.copyWith((message) => updates(message as GetUserPaymentsResponse))
          as GetUserPaymentsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserPaymentsResponse create() => GetUserPaymentsResponse._();
  @$core.override
  GetUserPaymentsResponse createEmptyInstance() => create();
  static $pb.PbList<GetUserPaymentsResponse> createRepeated() =>
      $pb.PbList<GetUserPaymentsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetUserPaymentsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUserPaymentsResponse>(create);
  static GetUserPaymentsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<InsurancePayment> get payments => $_getList(0);

  @$pb.TagNumber(2)
  InsurancePaginationInfo get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination(InsurancePaginationInfo value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => $_clearField(2);
  @$pb.TagNumber(2)
  InsurancePaginationInfo ensurePagination() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.bool get success => $_getBF(2);
  @$pb.TagNumber(3)
  set success($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSuccess() => $_has(2);
  @$pb.TagNumber(3)
  void clearSuccess() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get msg => $_getSZ(3);
  @$pb.TagNumber(4)
  set msg($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMsg() => $_has(3);
  @$pb.TagNumber(4)
  void clearMsg() => $_clearField(4);
}

class CreatePaymentRequest extends $pb.GeneratedMessage {
  factory CreatePaymentRequest({
    InsurancePayment? payment,
  }) {
    final result = create();
    if (payment != null) result.payment = payment;
    return result;
  }

  CreatePaymentRequest._();

  factory CreatePaymentRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreatePaymentRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreatePaymentRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<InsurancePayment>(1, _omitFieldNames ? '' : 'payment',
        subBuilder: InsurancePayment.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreatePaymentRequest clone() =>
      CreatePaymentRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreatePaymentRequest copyWith(void Function(CreatePaymentRequest) updates) =>
      super.copyWith((message) => updates(message as CreatePaymentRequest))
          as CreatePaymentRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreatePaymentRequest create() => CreatePaymentRequest._();
  @$core.override
  CreatePaymentRequest createEmptyInstance() => create();
  static $pb.PbList<CreatePaymentRequest> createRepeated() =>
      $pb.PbList<CreatePaymentRequest>();
  @$core.pragma('dart2js:noInline')
  static CreatePaymentRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreatePaymentRequest>(create);
  static CreatePaymentRequest? _defaultInstance;

  @$pb.TagNumber(1)
  InsurancePayment get payment => $_getN(0);
  @$pb.TagNumber(1)
  set payment(InsurancePayment value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasPayment() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayment() => $_clearField(1);
  @$pb.TagNumber(1)
  InsurancePayment ensurePayment() => $_ensure(0);
}

class CreatePaymentResponse extends $pb.GeneratedMessage {
  factory CreatePaymentResponse({
    InsurancePayment? payment,
    $core.bool? success,
    $core.String? msg,
  }) {
    final result = create();
    if (payment != null) result.payment = payment;
    if (success != null) result.success = success;
    if (msg != null) result.msg = msg;
    return result;
  }

  CreatePaymentResponse._();

  factory CreatePaymentResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreatePaymentResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreatePaymentResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<InsurancePayment>(1, _omitFieldNames ? '' : 'payment',
        subBuilder: InsurancePayment.create)
    ..aOB(2, _omitFieldNames ? '' : 'success')
    ..aOS(3, _omitFieldNames ? '' : 'msg')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreatePaymentResponse clone() =>
      CreatePaymentResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreatePaymentResponse copyWith(
          void Function(CreatePaymentResponse) updates) =>
      super.copyWith((message) => updates(message as CreatePaymentResponse))
          as CreatePaymentResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreatePaymentResponse create() => CreatePaymentResponse._();
  @$core.override
  CreatePaymentResponse createEmptyInstance() => create();
  static $pb.PbList<CreatePaymentResponse> createRepeated() =>
      $pb.PbList<CreatePaymentResponse>();
  @$core.pragma('dart2js:noInline')
  static CreatePaymentResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreatePaymentResponse>(create);
  static CreatePaymentResponse? _defaultInstance;

  @$pb.TagNumber(1)
  InsurancePayment get payment => $_getN(0);
  @$pb.TagNumber(1)
  set payment(InsurancePayment value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasPayment() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayment() => $_clearField(1);
  @$pb.TagNumber(1)
  InsurancePayment ensurePayment() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get msg => $_getSZ(2);
  @$pb.TagNumber(3)
  set msg($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMsg() => $_has(2);
  @$pb.TagNumber(3)
  void clearMsg() => $_clearField(3);
}

class ProcessPaymentRequest extends $pb.GeneratedMessage {
  factory ProcessPaymentRequest({
    $core.String? paymentId,
    $core.String? paymentMethod,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? paymentDetails,
  }) {
    final result = create();
    if (paymentId != null) result.paymentId = paymentId;
    if (paymentMethod != null) result.paymentMethod = paymentMethod;
    if (paymentDetails != null)
      result.paymentDetails.addEntries(paymentDetails);
    return result;
  }

  ProcessPaymentRequest._();

  factory ProcessPaymentRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ProcessPaymentRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ProcessPaymentRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'paymentId')
    ..aOS(2, _omitFieldNames ? '' : 'paymentMethod')
    ..m<$core.String, $core.String>(3, _omitFieldNames ? '' : 'paymentDetails',
        entryClassName: 'ProcessPaymentRequest.PaymentDetailsEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('pb'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProcessPaymentRequest clone() =>
      ProcessPaymentRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProcessPaymentRequest copyWith(
          void Function(ProcessPaymentRequest) updates) =>
      super.copyWith((message) => updates(message as ProcessPaymentRequest))
          as ProcessPaymentRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProcessPaymentRequest create() => ProcessPaymentRequest._();
  @$core.override
  ProcessPaymentRequest createEmptyInstance() => create();
  static $pb.PbList<ProcessPaymentRequest> createRepeated() =>
      $pb.PbList<ProcessPaymentRequest>();
  @$core.pragma('dart2js:noInline')
  static ProcessPaymentRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ProcessPaymentRequest>(create);
  static ProcessPaymentRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get paymentId => $_getSZ(0);
  @$pb.TagNumber(1)
  set paymentId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPaymentId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPaymentId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get paymentMethod => $_getSZ(1);
  @$pb.TagNumber(2)
  set paymentMethod($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPaymentMethod() => $_has(1);
  @$pb.TagNumber(2)
  void clearPaymentMethod() => $_clearField(2);

  @$pb.TagNumber(3)
  $pb.PbMap<$core.String, $core.String> get paymentDetails => $_getMap(2);
}

class ProcessPaymentResponse extends $pb.GeneratedMessage {
  factory ProcessPaymentResponse({
    InsurancePayment? payment,
    $core.String? transactionId,
    $core.String? referenceNumber,
    $core.String? receiptUrl,
    $core.bool? success,
    $core.String? msg,
  }) {
    final result = create();
    if (payment != null) result.payment = payment;
    if (transactionId != null) result.transactionId = transactionId;
    if (referenceNumber != null) result.referenceNumber = referenceNumber;
    if (receiptUrl != null) result.receiptUrl = receiptUrl;
    if (success != null) result.success = success;
    if (msg != null) result.msg = msg;
    return result;
  }

  ProcessPaymentResponse._();

  factory ProcessPaymentResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ProcessPaymentResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ProcessPaymentResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<InsurancePayment>(1, _omitFieldNames ? '' : 'payment',
        subBuilder: InsurancePayment.create)
    ..aOS(2, _omitFieldNames ? '' : 'transactionId')
    ..aOS(3, _omitFieldNames ? '' : 'referenceNumber')
    ..aOS(4, _omitFieldNames ? '' : 'receiptUrl')
    ..aOB(5, _omitFieldNames ? '' : 'success')
    ..aOS(6, _omitFieldNames ? '' : 'msg')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProcessPaymentResponse clone() =>
      ProcessPaymentResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProcessPaymentResponse copyWith(
          void Function(ProcessPaymentResponse) updates) =>
      super.copyWith((message) => updates(message as ProcessPaymentResponse))
          as ProcessPaymentResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProcessPaymentResponse create() => ProcessPaymentResponse._();
  @$core.override
  ProcessPaymentResponse createEmptyInstance() => create();
  static $pb.PbList<ProcessPaymentResponse> createRepeated() =>
      $pb.PbList<ProcessPaymentResponse>();
  @$core.pragma('dart2js:noInline')
  static ProcessPaymentResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ProcessPaymentResponse>(create);
  static ProcessPaymentResponse? _defaultInstance;

  @$pb.TagNumber(1)
  InsurancePayment get payment => $_getN(0);
  @$pb.TagNumber(1)
  set payment(InsurancePayment value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasPayment() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayment() => $_clearField(1);
  @$pb.TagNumber(1)
  InsurancePayment ensurePayment() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get transactionId => $_getSZ(1);
  @$pb.TagNumber(2)
  set transactionId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTransactionId() => $_has(1);
  @$pb.TagNumber(2)
  void clearTransactionId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get referenceNumber => $_getSZ(2);
  @$pb.TagNumber(3)
  set referenceNumber($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasReferenceNumber() => $_has(2);
  @$pb.TagNumber(3)
  void clearReferenceNumber() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get receiptUrl => $_getSZ(3);
  @$pb.TagNumber(4)
  set receiptUrl($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasReceiptUrl() => $_has(3);
  @$pb.TagNumber(4)
  void clearReceiptUrl() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.bool get success => $_getBF(4);
  @$pb.TagNumber(5)
  set success($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasSuccess() => $_has(4);
  @$pb.TagNumber(5)
  void clearSuccess() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get msg => $_getSZ(5);
  @$pb.TagNumber(6)
  set msg($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasMsg() => $_has(5);
  @$pb.TagNumber(6)
  void clearMsg() => $_clearField(6);
}

class GetPaymentByIdRequest extends $pb.GeneratedMessage {
  factory GetPaymentByIdRequest({
    $core.String? id,
  }) {
    final result = create();
    if (id != null) result.id = id;
    return result;
  }

  GetPaymentByIdRequest._();

  factory GetPaymentByIdRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetPaymentByIdRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetPaymentByIdRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPaymentByIdRequest clone() =>
      GetPaymentByIdRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPaymentByIdRequest copyWith(
          void Function(GetPaymentByIdRequest) updates) =>
      super.copyWith((message) => updates(message as GetPaymentByIdRequest))
          as GetPaymentByIdRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPaymentByIdRequest create() => GetPaymentByIdRequest._();
  @$core.override
  GetPaymentByIdRequest createEmptyInstance() => create();
  static $pb.PbList<GetPaymentByIdRequest> createRepeated() =>
      $pb.PbList<GetPaymentByIdRequest>();
  @$core.pragma('dart2js:noInline')
  static GetPaymentByIdRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetPaymentByIdRequest>(create);
  static GetPaymentByIdRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);
}

class GetPaymentByIdResponse extends $pb.GeneratedMessage {
  factory GetPaymentByIdResponse({
    InsurancePayment? payment,
    $core.bool? success,
    $core.String? msg,
  }) {
    final result = create();
    if (payment != null) result.payment = payment;
    if (success != null) result.success = success;
    if (msg != null) result.msg = msg;
    return result;
  }

  GetPaymentByIdResponse._();

  factory GetPaymentByIdResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetPaymentByIdResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetPaymentByIdResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<InsurancePayment>(1, _omitFieldNames ? '' : 'payment',
        subBuilder: InsurancePayment.create)
    ..aOB(2, _omitFieldNames ? '' : 'success')
    ..aOS(3, _omitFieldNames ? '' : 'msg')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPaymentByIdResponse clone() =>
      GetPaymentByIdResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPaymentByIdResponse copyWith(
          void Function(GetPaymentByIdResponse) updates) =>
      super.copyWith((message) => updates(message as GetPaymentByIdResponse))
          as GetPaymentByIdResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPaymentByIdResponse create() => GetPaymentByIdResponse._();
  @$core.override
  GetPaymentByIdResponse createEmptyInstance() => create();
  static $pb.PbList<GetPaymentByIdResponse> createRepeated() =>
      $pb.PbList<GetPaymentByIdResponse>();
  @$core.pragma('dart2js:noInline')
  static GetPaymentByIdResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetPaymentByIdResponse>(create);
  static GetPaymentByIdResponse? _defaultInstance;

  @$pb.TagNumber(1)
  InsurancePayment get payment => $_getN(0);
  @$pb.TagNumber(1)
  set payment(InsurancePayment value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasPayment() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayment() => $_clearField(1);
  @$pb.TagNumber(1)
  InsurancePayment ensurePayment() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get msg => $_getSZ(2);
  @$pb.TagNumber(3)
  set msg($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMsg() => $_has(2);
  @$pb.TagNumber(3)
  void clearMsg() => $_clearField(3);
}

class GetOverduePaymentsRequest extends $pb.GeneratedMessage {
  factory GetOverduePaymentsRequest() => create();

  GetOverduePaymentsRequest._();

  factory GetOverduePaymentsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetOverduePaymentsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetOverduePaymentsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetOverduePaymentsRequest clone() =>
      GetOverduePaymentsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetOverduePaymentsRequest copyWith(
          void Function(GetOverduePaymentsRequest) updates) =>
      super.copyWith((message) => updates(message as GetOverduePaymentsRequest))
          as GetOverduePaymentsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetOverduePaymentsRequest create() => GetOverduePaymentsRequest._();
  @$core.override
  GetOverduePaymentsRequest createEmptyInstance() => create();
  static $pb.PbList<GetOverduePaymentsRequest> createRepeated() =>
      $pb.PbList<GetOverduePaymentsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetOverduePaymentsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetOverduePaymentsRequest>(create);
  static GetOverduePaymentsRequest? _defaultInstance;
}

class GetOverduePaymentsResponse extends $pb.GeneratedMessage {
  factory GetOverduePaymentsResponse({
    $core.Iterable<InsurancePayment>? payments,
    $core.bool? success,
    $core.String? msg,
  }) {
    final result = create();
    if (payments != null) result.payments.addAll(payments);
    if (success != null) result.success = success;
    if (msg != null) result.msg = msg;
    return result;
  }

  GetOverduePaymentsResponse._();

  factory GetOverduePaymentsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetOverduePaymentsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetOverduePaymentsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<InsurancePayment>(
        1, _omitFieldNames ? '' : 'payments', $pb.PbFieldType.PM,
        subBuilder: InsurancePayment.create)
    ..aOB(2, _omitFieldNames ? '' : 'success')
    ..aOS(3, _omitFieldNames ? '' : 'msg')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetOverduePaymentsResponse clone() =>
      GetOverduePaymentsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetOverduePaymentsResponse copyWith(
          void Function(GetOverduePaymentsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetOverduePaymentsResponse))
          as GetOverduePaymentsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetOverduePaymentsResponse create() => GetOverduePaymentsResponse._();
  @$core.override
  GetOverduePaymentsResponse createEmptyInstance() => create();
  static $pb.PbList<GetOverduePaymentsResponse> createRepeated() =>
      $pb.PbList<GetOverduePaymentsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetOverduePaymentsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetOverduePaymentsResponse>(create);
  static GetOverduePaymentsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<InsurancePayment> get payments => $_getList(0);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get msg => $_getSZ(2);
  @$pb.TagNumber(3)
  set msg($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMsg() => $_has(2);
  @$pb.TagNumber(3)
  void clearMsg() => $_clearField(3);
}

/// Claims Management
class GetInsuranceClaimsRequest extends $pb.GeneratedMessage {
  factory GetInsuranceClaimsRequest({
    $core.String? insuranceId,
    $core.int? page,
    $core.int? limit,
  }) {
    final result = create();
    if (insuranceId != null) result.insuranceId = insuranceId;
    if (page != null) result.page = page;
    if (limit != null) result.limit = limit;
    return result;
  }

  GetInsuranceClaimsRequest._();

  factory GetInsuranceClaimsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInsuranceClaimsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInsuranceClaimsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'insuranceId')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsuranceClaimsRequest clone() =>
      GetInsuranceClaimsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsuranceClaimsRequest copyWith(
          void Function(GetInsuranceClaimsRequest) updates) =>
      super.copyWith((message) => updates(message as GetInsuranceClaimsRequest))
          as GetInsuranceClaimsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInsuranceClaimsRequest create() => GetInsuranceClaimsRequest._();
  @$core.override
  GetInsuranceClaimsRequest createEmptyInstance() => create();
  static $pb.PbList<GetInsuranceClaimsRequest> createRepeated() =>
      $pb.PbList<GetInsuranceClaimsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInsuranceClaimsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetInsuranceClaimsRequest>(create);
  static GetInsuranceClaimsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get insuranceId => $_getSZ(0);
  @$pb.TagNumber(1)
  set insuranceId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasInsuranceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearInsuranceId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get page => $_getIZ(1);
  @$pb.TagNumber(2)
  set page($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPage() => $_has(1);
  @$pb.TagNumber(2)
  void clearPage() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get limit => $_getIZ(2);
  @$pb.TagNumber(3)
  set limit($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLimit() => $_has(2);
  @$pb.TagNumber(3)
  void clearLimit() => $_clearField(3);
}

class GetInsuranceClaimsResponse extends $pb.GeneratedMessage {
  factory GetInsuranceClaimsResponse({
    $core.Iterable<InsuranceClaim>? claims,
    InsurancePaginationInfo? pagination,
    $core.bool? success,
    $core.String? msg,
  }) {
    final result = create();
    if (claims != null) result.claims.addAll(claims);
    if (pagination != null) result.pagination = pagination;
    if (success != null) result.success = success;
    if (msg != null) result.msg = msg;
    return result;
  }

  GetInsuranceClaimsResponse._();

  factory GetInsuranceClaimsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInsuranceClaimsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInsuranceClaimsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<InsuranceClaim>(1, _omitFieldNames ? '' : 'claims', $pb.PbFieldType.PM,
        subBuilder: InsuranceClaim.create)
    ..aOM<InsurancePaginationInfo>(2, _omitFieldNames ? '' : 'pagination',
        subBuilder: InsurancePaginationInfo.create)
    ..aOB(3, _omitFieldNames ? '' : 'success')
    ..aOS(4, _omitFieldNames ? '' : 'msg')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsuranceClaimsResponse clone() =>
      GetInsuranceClaimsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsuranceClaimsResponse copyWith(
          void Function(GetInsuranceClaimsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetInsuranceClaimsResponse))
          as GetInsuranceClaimsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInsuranceClaimsResponse create() => GetInsuranceClaimsResponse._();
  @$core.override
  GetInsuranceClaimsResponse createEmptyInstance() => create();
  static $pb.PbList<GetInsuranceClaimsResponse> createRepeated() =>
      $pb.PbList<GetInsuranceClaimsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInsuranceClaimsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetInsuranceClaimsResponse>(create);
  static GetInsuranceClaimsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<InsuranceClaim> get claims => $_getList(0);

  @$pb.TagNumber(2)
  InsurancePaginationInfo get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination(InsurancePaginationInfo value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => $_clearField(2);
  @$pb.TagNumber(2)
  InsurancePaginationInfo ensurePagination() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.bool get success => $_getBF(2);
  @$pb.TagNumber(3)
  set success($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSuccess() => $_has(2);
  @$pb.TagNumber(3)
  void clearSuccess() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get msg => $_getSZ(3);
  @$pb.TagNumber(4)
  set msg($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMsg() => $_has(3);
  @$pb.TagNumber(4)
  void clearMsg() => $_clearField(4);
}

class GetUserClaimsRequest extends $pb.GeneratedMessage {
  factory GetUserClaimsRequest({
    $core.int? page,
    $core.int? limit,
  }) {
    final result = create();
    if (page != null) result.page = page;
    if (limit != null) result.limit = limit;
    return result;
  }

  GetUserClaimsRequest._();

  factory GetUserClaimsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetUserClaimsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUserClaimsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserClaimsRequest clone() =>
      GetUserClaimsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserClaimsRequest copyWith(void Function(GetUserClaimsRequest) updates) =>
      super.copyWith((message) => updates(message as GetUserClaimsRequest))
          as GetUserClaimsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserClaimsRequest create() => GetUserClaimsRequest._();
  @$core.override
  GetUserClaimsRequest createEmptyInstance() => create();
  static $pb.PbList<GetUserClaimsRequest> createRepeated() =>
      $pb.PbList<GetUserClaimsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetUserClaimsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUserClaimsRequest>(create);
  static GetUserClaimsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get page => $_getIZ(0);
  @$pb.TagNumber(1)
  set page($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearPage() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get limit => $_getIZ(1);
  @$pb.TagNumber(2)
  set limit($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => $_clearField(2);
}

class GetUserClaimsResponse extends $pb.GeneratedMessage {
  factory GetUserClaimsResponse({
    $core.Iterable<InsuranceClaim>? claims,
    InsurancePaginationInfo? pagination,
    $core.bool? success,
    $core.String? msg,
  }) {
    final result = create();
    if (claims != null) result.claims.addAll(claims);
    if (pagination != null) result.pagination = pagination;
    if (success != null) result.success = success;
    if (msg != null) result.msg = msg;
    return result;
  }

  GetUserClaimsResponse._();

  factory GetUserClaimsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetUserClaimsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUserClaimsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<InsuranceClaim>(1, _omitFieldNames ? '' : 'claims', $pb.PbFieldType.PM,
        subBuilder: InsuranceClaim.create)
    ..aOM<InsurancePaginationInfo>(2, _omitFieldNames ? '' : 'pagination',
        subBuilder: InsurancePaginationInfo.create)
    ..aOB(3, _omitFieldNames ? '' : 'success')
    ..aOS(4, _omitFieldNames ? '' : 'msg')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserClaimsResponse clone() =>
      GetUserClaimsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserClaimsResponse copyWith(
          void Function(GetUserClaimsResponse) updates) =>
      super.copyWith((message) => updates(message as GetUserClaimsResponse))
          as GetUserClaimsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserClaimsResponse create() => GetUserClaimsResponse._();
  @$core.override
  GetUserClaimsResponse createEmptyInstance() => create();
  static $pb.PbList<GetUserClaimsResponse> createRepeated() =>
      $pb.PbList<GetUserClaimsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetUserClaimsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUserClaimsResponse>(create);
  static GetUserClaimsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<InsuranceClaim> get claims => $_getList(0);

  @$pb.TagNumber(2)
  InsurancePaginationInfo get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination(InsurancePaginationInfo value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => $_clearField(2);
  @$pb.TagNumber(2)
  InsurancePaginationInfo ensurePagination() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.bool get success => $_getBF(2);
  @$pb.TagNumber(3)
  set success($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSuccess() => $_has(2);
  @$pb.TagNumber(3)
  void clearSuccess() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get msg => $_getSZ(3);
  @$pb.TagNumber(4)
  set msg($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMsg() => $_has(3);
  @$pb.TagNumber(4)
  void clearMsg() => $_clearField(4);
}

class CreateClaimRequest extends $pb.GeneratedMessage {
  factory CreateClaimRequest({
    InsuranceClaim? claim,
  }) {
    final result = create();
    if (claim != null) result.claim = claim;
    return result;
  }

  CreateClaimRequest._();

  factory CreateClaimRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateClaimRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateClaimRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<InsuranceClaim>(1, _omitFieldNames ? '' : 'claim',
        subBuilder: InsuranceClaim.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateClaimRequest clone() => CreateClaimRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateClaimRequest copyWith(void Function(CreateClaimRequest) updates) =>
      super.copyWith((message) => updates(message as CreateClaimRequest))
          as CreateClaimRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateClaimRequest create() => CreateClaimRequest._();
  @$core.override
  CreateClaimRequest createEmptyInstance() => create();
  static $pb.PbList<CreateClaimRequest> createRepeated() =>
      $pb.PbList<CreateClaimRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateClaimRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateClaimRequest>(create);
  static CreateClaimRequest? _defaultInstance;

  @$pb.TagNumber(1)
  InsuranceClaim get claim => $_getN(0);
  @$pb.TagNumber(1)
  set claim(InsuranceClaim value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasClaim() => $_has(0);
  @$pb.TagNumber(1)
  void clearClaim() => $_clearField(1);
  @$pb.TagNumber(1)
  InsuranceClaim ensureClaim() => $_ensure(0);
}

class CreateClaimResponse extends $pb.GeneratedMessage {
  factory CreateClaimResponse({
    InsuranceClaim? claim,
    $core.bool? success,
    $core.String? msg,
  }) {
    final result = create();
    if (claim != null) result.claim = claim;
    if (success != null) result.success = success;
    if (msg != null) result.msg = msg;
    return result;
  }

  CreateClaimResponse._();

  factory CreateClaimResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateClaimResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateClaimResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<InsuranceClaim>(1, _omitFieldNames ? '' : 'claim',
        subBuilder: InsuranceClaim.create)
    ..aOB(2, _omitFieldNames ? '' : 'success')
    ..aOS(3, _omitFieldNames ? '' : 'msg')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateClaimResponse clone() => CreateClaimResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateClaimResponse copyWith(void Function(CreateClaimResponse) updates) =>
      super.copyWith((message) => updates(message as CreateClaimResponse))
          as CreateClaimResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateClaimResponse create() => CreateClaimResponse._();
  @$core.override
  CreateClaimResponse createEmptyInstance() => create();
  static $pb.PbList<CreateClaimResponse> createRepeated() =>
      $pb.PbList<CreateClaimResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateClaimResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateClaimResponse>(create);
  static CreateClaimResponse? _defaultInstance;

  @$pb.TagNumber(1)
  InsuranceClaim get claim => $_getN(0);
  @$pb.TagNumber(1)
  set claim(InsuranceClaim value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasClaim() => $_has(0);
  @$pb.TagNumber(1)
  void clearClaim() => $_clearField(1);
  @$pb.TagNumber(1)
  InsuranceClaim ensureClaim() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get msg => $_getSZ(2);
  @$pb.TagNumber(3)
  set msg($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMsg() => $_has(2);
  @$pb.TagNumber(3)
  void clearMsg() => $_clearField(3);
}

class UpdateClaimRequest extends $pb.GeneratedMessage {
  factory UpdateClaimRequest({
    InsuranceClaim? claim,
  }) {
    final result = create();
    if (claim != null) result.claim = claim;
    return result;
  }

  UpdateClaimRequest._();

  factory UpdateClaimRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateClaimRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateClaimRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<InsuranceClaim>(1, _omitFieldNames ? '' : 'claim',
        subBuilder: InsuranceClaim.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateClaimRequest clone() => UpdateClaimRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateClaimRequest copyWith(void Function(UpdateClaimRequest) updates) =>
      super.copyWith((message) => updates(message as UpdateClaimRequest))
          as UpdateClaimRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateClaimRequest create() => UpdateClaimRequest._();
  @$core.override
  UpdateClaimRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateClaimRequest> createRepeated() =>
      $pb.PbList<UpdateClaimRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateClaimRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateClaimRequest>(create);
  static UpdateClaimRequest? _defaultInstance;

  @$pb.TagNumber(1)
  InsuranceClaim get claim => $_getN(0);
  @$pb.TagNumber(1)
  set claim(InsuranceClaim value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasClaim() => $_has(0);
  @$pb.TagNumber(1)
  void clearClaim() => $_clearField(1);
  @$pb.TagNumber(1)
  InsuranceClaim ensureClaim() => $_ensure(0);
}

class UpdateClaimResponse extends $pb.GeneratedMessage {
  factory UpdateClaimResponse({
    InsuranceClaim? claim,
    $core.bool? success,
    $core.String? msg,
  }) {
    final result = create();
    if (claim != null) result.claim = claim;
    if (success != null) result.success = success;
    if (msg != null) result.msg = msg;
    return result;
  }

  UpdateClaimResponse._();

  factory UpdateClaimResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateClaimResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateClaimResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<InsuranceClaim>(1, _omitFieldNames ? '' : 'claim',
        subBuilder: InsuranceClaim.create)
    ..aOB(2, _omitFieldNames ? '' : 'success')
    ..aOS(3, _omitFieldNames ? '' : 'msg')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateClaimResponse clone() => UpdateClaimResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateClaimResponse copyWith(void Function(UpdateClaimResponse) updates) =>
      super.copyWith((message) => updates(message as UpdateClaimResponse))
          as UpdateClaimResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateClaimResponse create() => UpdateClaimResponse._();
  @$core.override
  UpdateClaimResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateClaimResponse> createRepeated() =>
      $pb.PbList<UpdateClaimResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateClaimResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateClaimResponse>(create);
  static UpdateClaimResponse? _defaultInstance;

  @$pb.TagNumber(1)
  InsuranceClaim get claim => $_getN(0);
  @$pb.TagNumber(1)
  set claim(InsuranceClaim value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasClaim() => $_has(0);
  @$pb.TagNumber(1)
  void clearClaim() => $_clearField(1);
  @$pb.TagNumber(1)
  InsuranceClaim ensureClaim() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get msg => $_getSZ(2);
  @$pb.TagNumber(3)
  set msg($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMsg() => $_has(2);
  @$pb.TagNumber(3)
  void clearMsg() => $_clearField(3);
}

class GetClaimByIdRequest extends $pb.GeneratedMessage {
  factory GetClaimByIdRequest({
    $core.String? id,
  }) {
    final result = create();
    if (id != null) result.id = id;
    return result;
  }

  GetClaimByIdRequest._();

  factory GetClaimByIdRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetClaimByIdRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetClaimByIdRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetClaimByIdRequest clone() => GetClaimByIdRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetClaimByIdRequest copyWith(void Function(GetClaimByIdRequest) updates) =>
      super.copyWith((message) => updates(message as GetClaimByIdRequest))
          as GetClaimByIdRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetClaimByIdRequest create() => GetClaimByIdRequest._();
  @$core.override
  GetClaimByIdRequest createEmptyInstance() => create();
  static $pb.PbList<GetClaimByIdRequest> createRepeated() =>
      $pb.PbList<GetClaimByIdRequest>();
  @$core.pragma('dart2js:noInline')
  static GetClaimByIdRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetClaimByIdRequest>(create);
  static GetClaimByIdRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);
}

class GetClaimByIdResponse extends $pb.GeneratedMessage {
  factory GetClaimByIdResponse({
    InsuranceClaim? claim,
    $core.bool? success,
    $core.String? msg,
  }) {
    final result = create();
    if (claim != null) result.claim = claim;
    if (success != null) result.success = success;
    if (msg != null) result.msg = msg;
    return result;
  }

  GetClaimByIdResponse._();

  factory GetClaimByIdResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetClaimByIdResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetClaimByIdResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<InsuranceClaim>(1, _omitFieldNames ? '' : 'claim',
        subBuilder: InsuranceClaim.create)
    ..aOB(2, _omitFieldNames ? '' : 'success')
    ..aOS(3, _omitFieldNames ? '' : 'msg')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetClaimByIdResponse clone() =>
      GetClaimByIdResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetClaimByIdResponse copyWith(void Function(GetClaimByIdResponse) updates) =>
      super.copyWith((message) => updates(message as GetClaimByIdResponse))
          as GetClaimByIdResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetClaimByIdResponse create() => GetClaimByIdResponse._();
  @$core.override
  GetClaimByIdResponse createEmptyInstance() => create();
  static $pb.PbList<GetClaimByIdResponse> createRepeated() =>
      $pb.PbList<GetClaimByIdResponse>();
  @$core.pragma('dart2js:noInline')
  static GetClaimByIdResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetClaimByIdResponse>(create);
  static GetClaimByIdResponse? _defaultInstance;

  @$pb.TagNumber(1)
  InsuranceClaim get claim => $_getN(0);
  @$pb.TagNumber(1)
  set claim(InsuranceClaim value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasClaim() => $_has(0);
  @$pb.TagNumber(1)
  void clearClaim() => $_clearField(1);
  @$pb.TagNumber(1)
  InsuranceClaim ensureClaim() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get msg => $_getSZ(2);
  @$pb.TagNumber(3)
  set msg($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMsg() => $_has(2);
  @$pb.TagNumber(3)
  void clearMsg() => $_clearField(3);
}

/// Receipt Management
class GeneratePaymentReceiptRequest extends $pb.GeneratedMessage {
  factory GeneratePaymentReceiptRequest({
    $core.String? paymentId,
  }) {
    final result = create();
    if (paymentId != null) result.paymentId = paymentId;
    return result;
  }

  GeneratePaymentReceiptRequest._();

  factory GeneratePaymentReceiptRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GeneratePaymentReceiptRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GeneratePaymentReceiptRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'paymentId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GeneratePaymentReceiptRequest clone() =>
      GeneratePaymentReceiptRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GeneratePaymentReceiptRequest copyWith(
          void Function(GeneratePaymentReceiptRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GeneratePaymentReceiptRequest))
          as GeneratePaymentReceiptRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GeneratePaymentReceiptRequest create() =>
      GeneratePaymentReceiptRequest._();
  @$core.override
  GeneratePaymentReceiptRequest createEmptyInstance() => create();
  static $pb.PbList<GeneratePaymentReceiptRequest> createRepeated() =>
      $pb.PbList<GeneratePaymentReceiptRequest>();
  @$core.pragma('dart2js:noInline')
  static GeneratePaymentReceiptRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GeneratePaymentReceiptRequest>(create);
  static GeneratePaymentReceiptRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get paymentId => $_getSZ(0);
  @$pb.TagNumber(1)
  set paymentId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPaymentId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPaymentId() => $_clearField(1);
}

class GeneratePaymentReceiptResponse extends $pb.GeneratedMessage {
  factory GeneratePaymentReceiptResponse({
    $core.String? receiptUrl,
    $core.String? receiptId,
    $core.bool? success,
    $core.String? msg,
  }) {
    final result = create();
    if (receiptUrl != null) result.receiptUrl = receiptUrl;
    if (receiptId != null) result.receiptId = receiptId;
    if (success != null) result.success = success;
    if (msg != null) result.msg = msg;
    return result;
  }

  GeneratePaymentReceiptResponse._();

  factory GeneratePaymentReceiptResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GeneratePaymentReceiptResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GeneratePaymentReceiptResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'receiptUrl')
    ..aOS(2, _omitFieldNames ? '' : 'receiptId')
    ..aOB(3, _omitFieldNames ? '' : 'success')
    ..aOS(4, _omitFieldNames ? '' : 'msg')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GeneratePaymentReceiptResponse clone() =>
      GeneratePaymentReceiptResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GeneratePaymentReceiptResponse copyWith(
          void Function(GeneratePaymentReceiptResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GeneratePaymentReceiptResponse))
          as GeneratePaymentReceiptResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GeneratePaymentReceiptResponse create() =>
      GeneratePaymentReceiptResponse._();
  @$core.override
  GeneratePaymentReceiptResponse createEmptyInstance() => create();
  static $pb.PbList<GeneratePaymentReceiptResponse> createRepeated() =>
      $pb.PbList<GeneratePaymentReceiptResponse>();
  @$core.pragma('dart2js:noInline')
  static GeneratePaymentReceiptResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GeneratePaymentReceiptResponse>(create);
  static GeneratePaymentReceiptResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get receiptUrl => $_getSZ(0);
  @$pb.TagNumber(1)
  set receiptUrl($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasReceiptUrl() => $_has(0);
  @$pb.TagNumber(1)
  void clearReceiptUrl() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get receiptId => $_getSZ(1);
  @$pb.TagNumber(2)
  set receiptId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasReceiptId() => $_has(1);
  @$pb.TagNumber(2)
  void clearReceiptId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get success => $_getBF(2);
  @$pb.TagNumber(3)
  set success($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSuccess() => $_has(2);
  @$pb.TagNumber(3)
  void clearSuccess() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get msg => $_getSZ(3);
  @$pb.TagNumber(4)
  set msg($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMsg() => $_has(3);
  @$pb.TagNumber(4)
  void clearMsg() => $_clearField(4);
}

class GetUserReceiptsRequest extends $pb.GeneratedMessage {
  factory GetUserReceiptsRequest({
    $core.int? page,
    $core.int? limit,
  }) {
    final result = create();
    if (page != null) result.page = page;
    if (limit != null) result.limit = limit;
    return result;
  }

  GetUserReceiptsRequest._();

  factory GetUserReceiptsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetUserReceiptsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUserReceiptsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserReceiptsRequest clone() =>
      GetUserReceiptsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserReceiptsRequest copyWith(
          void Function(GetUserReceiptsRequest) updates) =>
      super.copyWith((message) => updates(message as GetUserReceiptsRequest))
          as GetUserReceiptsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserReceiptsRequest create() => GetUserReceiptsRequest._();
  @$core.override
  GetUserReceiptsRequest createEmptyInstance() => create();
  static $pb.PbList<GetUserReceiptsRequest> createRepeated() =>
      $pb.PbList<GetUserReceiptsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetUserReceiptsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUserReceiptsRequest>(create);
  static GetUserReceiptsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get page => $_getIZ(0);
  @$pb.TagNumber(1)
  set page($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearPage() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get limit => $_getIZ(1);
  @$pb.TagNumber(2)
  set limit($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => $_clearField(2);
}

class GetUserReceiptsResponse extends $pb.GeneratedMessage {
  factory GetUserReceiptsResponse({
    $core.Iterable<$core.String>? receiptUrls,
    InsurancePaginationInfo? pagination,
    $core.bool? success,
    $core.String? msg,
  }) {
    final result = create();
    if (receiptUrls != null) result.receiptUrls.addAll(receiptUrls);
    if (pagination != null) result.pagination = pagination;
    if (success != null) result.success = success;
    if (msg != null) result.msg = msg;
    return result;
  }

  GetUserReceiptsResponse._();

  factory GetUserReceiptsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetUserReceiptsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUserReceiptsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'receiptUrls')
    ..aOM<InsurancePaginationInfo>(2, _omitFieldNames ? '' : 'pagination',
        subBuilder: InsurancePaginationInfo.create)
    ..aOB(3, _omitFieldNames ? '' : 'success')
    ..aOS(4, _omitFieldNames ? '' : 'msg')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserReceiptsResponse clone() =>
      GetUserReceiptsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserReceiptsResponse copyWith(
          void Function(GetUserReceiptsResponse) updates) =>
      super.copyWith((message) => updates(message as GetUserReceiptsResponse))
          as GetUserReceiptsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserReceiptsResponse create() => GetUserReceiptsResponse._();
  @$core.override
  GetUserReceiptsResponse createEmptyInstance() => create();
  static $pb.PbList<GetUserReceiptsResponse> createRepeated() =>
      $pb.PbList<GetUserReceiptsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetUserReceiptsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUserReceiptsResponse>(create);
  static GetUserReceiptsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$core.String> get receiptUrls => $_getList(0);

  @$pb.TagNumber(2)
  InsurancePaginationInfo get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination(InsurancePaginationInfo value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => $_clearField(2);
  @$pb.TagNumber(2)
  InsurancePaginationInfo ensurePagination() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.bool get success => $_getBF(2);
  @$pb.TagNumber(3)
  set success($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSuccess() => $_has(2);
  @$pb.TagNumber(3)
  void clearSuccess() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get msg => $_getSZ(3);
  @$pb.TagNumber(4)
  set msg($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMsg() => $_has(3);
  @$pb.TagNumber(4)
  void clearMsg() => $_clearField(4);
}

/// Statistics
class GetInsuranceStatisticsRequest extends $pb.GeneratedMessage {
  factory GetInsuranceStatisticsRequest() => create();

  GetInsuranceStatisticsRequest._();

  factory GetInsuranceStatisticsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInsuranceStatisticsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInsuranceStatisticsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsuranceStatisticsRequest clone() =>
      GetInsuranceStatisticsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsuranceStatisticsRequest copyWith(
          void Function(GetInsuranceStatisticsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetInsuranceStatisticsRequest))
          as GetInsuranceStatisticsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInsuranceStatisticsRequest create() =>
      GetInsuranceStatisticsRequest._();
  @$core.override
  GetInsuranceStatisticsRequest createEmptyInstance() => create();
  static $pb.PbList<GetInsuranceStatisticsRequest> createRepeated() =>
      $pb.PbList<GetInsuranceStatisticsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInsuranceStatisticsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetInsuranceStatisticsRequest>(create);
  static GetInsuranceStatisticsRequest? _defaultInstance;
}

class GetInsuranceStatisticsResponse extends $pb.GeneratedMessage {
  factory GetInsuranceStatisticsResponse({
    $core.int? totalPolicies,
    $core.int? activePolicies,
    $core.int? expiredPolicies,
    $core.double? totalCoverageAmount,
    $core.double? totalPremiumAmount,
    $core.Iterable<$core.MapEntry<$core.String, $core.int>>? policiesByType,
    $core.bool? success,
    $core.String? msg,
  }) {
    final result = create();
    if (totalPolicies != null) result.totalPolicies = totalPolicies;
    if (activePolicies != null) result.activePolicies = activePolicies;
    if (expiredPolicies != null) result.expiredPolicies = expiredPolicies;
    if (totalCoverageAmount != null)
      result.totalCoverageAmount = totalCoverageAmount;
    if (totalPremiumAmount != null)
      result.totalPremiumAmount = totalPremiumAmount;
    if (policiesByType != null)
      result.policiesByType.addEntries(policiesByType);
    if (success != null) result.success = success;
    if (msg != null) result.msg = msg;
    return result;
  }

  GetInsuranceStatisticsResponse._();

  factory GetInsuranceStatisticsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInsuranceStatisticsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInsuranceStatisticsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..a<$core.int>(
        1, _omitFieldNames ? '' : 'totalPolicies', $pb.PbFieldType.O3)
    ..a<$core.int>(
        2, _omitFieldNames ? '' : 'activePolicies', $pb.PbFieldType.O3)
    ..a<$core.int>(
        3, _omitFieldNames ? '' : 'expiredPolicies', $pb.PbFieldType.O3)
    ..a<$core.double>(
        4, _omitFieldNames ? '' : 'totalCoverageAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(
        5, _omitFieldNames ? '' : 'totalPremiumAmount', $pb.PbFieldType.OD)
    ..m<$core.String, $core.int>(6, _omitFieldNames ? '' : 'policiesByType',
        entryClassName: 'GetInsuranceStatisticsResponse.PoliciesByTypeEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.O3,
        packageName: const $pb.PackageName('pb'))
    ..aOB(7, _omitFieldNames ? '' : 'success')
    ..aOS(8, _omitFieldNames ? '' : 'msg')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsuranceStatisticsResponse clone() =>
      GetInsuranceStatisticsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsuranceStatisticsResponse copyWith(
          void Function(GetInsuranceStatisticsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetInsuranceStatisticsResponse))
          as GetInsuranceStatisticsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInsuranceStatisticsResponse create() =>
      GetInsuranceStatisticsResponse._();
  @$core.override
  GetInsuranceStatisticsResponse createEmptyInstance() => create();
  static $pb.PbList<GetInsuranceStatisticsResponse> createRepeated() =>
      $pb.PbList<GetInsuranceStatisticsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInsuranceStatisticsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetInsuranceStatisticsResponse>(create);
  static GetInsuranceStatisticsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get totalPolicies => $_getIZ(0);
  @$pb.TagNumber(1)
  set totalPolicies($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTotalPolicies() => $_has(0);
  @$pb.TagNumber(1)
  void clearTotalPolicies() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get activePolicies => $_getIZ(1);
  @$pb.TagNumber(2)
  set activePolicies($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasActivePolicies() => $_has(1);
  @$pb.TagNumber(2)
  void clearActivePolicies() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get expiredPolicies => $_getIZ(2);
  @$pb.TagNumber(3)
  set expiredPolicies($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasExpiredPolicies() => $_has(2);
  @$pb.TagNumber(3)
  void clearExpiredPolicies() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get totalCoverageAmount => $_getN(3);
  @$pb.TagNumber(4)
  set totalCoverageAmount($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTotalCoverageAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalCoverageAmount() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get totalPremiumAmount => $_getN(4);
  @$pb.TagNumber(5)
  set totalPremiumAmount($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTotalPremiumAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotalPremiumAmount() => $_clearField(5);

  @$pb.TagNumber(6)
  $pb.PbMap<$core.String, $core.int> get policiesByType => $_getMap(5);

  @$pb.TagNumber(7)
  $core.bool get success => $_getBF(6);
  @$pb.TagNumber(7)
  set success($core.bool value) => $_setBool(6, value);
  @$pb.TagNumber(7)
  $core.bool hasSuccess() => $_has(6);
  @$pb.TagNumber(7)
  void clearSuccess() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get msg => $_getSZ(7);
  @$pb.TagNumber(8)
  set msg($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasMsg() => $_has(7);
  @$pb.TagNumber(8)
  void clearMsg() => $_clearField(8);
}

class GetPaymentStatisticsRequest extends $pb.GeneratedMessage {
  factory GetPaymentStatisticsRequest({
    $core.String? startDate,
    $core.String? endDate,
  }) {
    final result = create();
    if (startDate != null) result.startDate = startDate;
    if (endDate != null) result.endDate = endDate;
    return result;
  }

  GetPaymentStatisticsRequest._();

  factory GetPaymentStatisticsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetPaymentStatisticsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetPaymentStatisticsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'startDate')
    ..aOS(2, _omitFieldNames ? '' : 'endDate')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPaymentStatisticsRequest clone() =>
      GetPaymentStatisticsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPaymentStatisticsRequest copyWith(
          void Function(GetPaymentStatisticsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetPaymentStatisticsRequest))
          as GetPaymentStatisticsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPaymentStatisticsRequest create() =>
      GetPaymentStatisticsRequest._();
  @$core.override
  GetPaymentStatisticsRequest createEmptyInstance() => create();
  static $pb.PbList<GetPaymentStatisticsRequest> createRepeated() =>
      $pb.PbList<GetPaymentStatisticsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetPaymentStatisticsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetPaymentStatisticsRequest>(create);
  static GetPaymentStatisticsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get startDate => $_getSZ(0);
  @$pb.TagNumber(1)
  set startDate($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasStartDate() => $_has(0);
  @$pb.TagNumber(1)
  void clearStartDate() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get endDate => $_getSZ(1);
  @$pb.TagNumber(2)
  set endDate($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasEndDate() => $_has(1);
  @$pb.TagNumber(2)
  void clearEndDate() => $_clearField(2);
}

class GetPaymentStatisticsResponse extends $pb.GeneratedMessage {
  factory GetPaymentStatisticsResponse({
    $core.int? totalPayments,
    $core.int? completedPayments,
    $core.int? pendingPayments,
    $core.int? failedPayments,
    $core.double? totalAmount,
    $core.double? completedAmount,
    $core.Iterable<$core.MapEntry<$core.String, $core.int>>? paymentsByMethod,
    $core.bool? success,
    $core.String? msg,
  }) {
    final result = create();
    if (totalPayments != null) result.totalPayments = totalPayments;
    if (completedPayments != null) result.completedPayments = completedPayments;
    if (pendingPayments != null) result.pendingPayments = pendingPayments;
    if (failedPayments != null) result.failedPayments = failedPayments;
    if (totalAmount != null) result.totalAmount = totalAmount;
    if (completedAmount != null) result.completedAmount = completedAmount;
    if (paymentsByMethod != null)
      result.paymentsByMethod.addEntries(paymentsByMethod);
    if (success != null) result.success = success;
    if (msg != null) result.msg = msg;
    return result;
  }

  GetPaymentStatisticsResponse._();

  factory GetPaymentStatisticsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetPaymentStatisticsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetPaymentStatisticsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..a<$core.int>(
        1, _omitFieldNames ? '' : 'totalPayments', $pb.PbFieldType.O3)
    ..a<$core.int>(
        2, _omitFieldNames ? '' : 'completedPayments', $pb.PbFieldType.O3)
    ..a<$core.int>(
        3, _omitFieldNames ? '' : 'pendingPayments', $pb.PbFieldType.O3)
    ..a<$core.int>(
        4, _omitFieldNames ? '' : 'failedPayments', $pb.PbFieldType.O3)
    ..a<$core.double>(
        5, _omitFieldNames ? '' : 'totalAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(
        6, _omitFieldNames ? '' : 'completedAmount', $pb.PbFieldType.OD)
    ..m<$core.String, $core.int>(7, _omitFieldNames ? '' : 'paymentsByMethod',
        entryClassName: 'GetPaymentStatisticsResponse.PaymentsByMethodEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.O3,
        packageName: const $pb.PackageName('pb'))
    ..aOB(8, _omitFieldNames ? '' : 'success')
    ..aOS(9, _omitFieldNames ? '' : 'msg')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPaymentStatisticsResponse clone() =>
      GetPaymentStatisticsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPaymentStatisticsResponse copyWith(
          void Function(GetPaymentStatisticsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetPaymentStatisticsResponse))
          as GetPaymentStatisticsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPaymentStatisticsResponse create() =>
      GetPaymentStatisticsResponse._();
  @$core.override
  GetPaymentStatisticsResponse createEmptyInstance() => create();
  static $pb.PbList<GetPaymentStatisticsResponse> createRepeated() =>
      $pb.PbList<GetPaymentStatisticsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetPaymentStatisticsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetPaymentStatisticsResponse>(create);
  static GetPaymentStatisticsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get totalPayments => $_getIZ(0);
  @$pb.TagNumber(1)
  set totalPayments($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTotalPayments() => $_has(0);
  @$pb.TagNumber(1)
  void clearTotalPayments() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get completedPayments => $_getIZ(1);
  @$pb.TagNumber(2)
  set completedPayments($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCompletedPayments() => $_has(1);
  @$pb.TagNumber(2)
  void clearCompletedPayments() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get pendingPayments => $_getIZ(2);
  @$pb.TagNumber(3)
  set pendingPayments($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPendingPayments() => $_has(2);
  @$pb.TagNumber(3)
  void clearPendingPayments() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get failedPayments => $_getIZ(3);
  @$pb.TagNumber(4)
  set failedPayments($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasFailedPayments() => $_has(3);
  @$pb.TagNumber(4)
  void clearFailedPayments() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get totalAmount => $_getN(4);
  @$pb.TagNumber(5)
  set totalAmount($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTotalAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotalAmount() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.double get completedAmount => $_getN(5);
  @$pb.TagNumber(6)
  set completedAmount($core.double value) => $_setDouble(5, value);
  @$pb.TagNumber(6)
  $core.bool hasCompletedAmount() => $_has(5);
  @$pb.TagNumber(6)
  void clearCompletedAmount() => $_clearField(6);

  @$pb.TagNumber(7)
  $pb.PbMap<$core.String, $core.int> get paymentsByMethod => $_getMap(6);

  @$pb.TagNumber(8)
  $core.bool get success => $_getBF(7);
  @$pb.TagNumber(8)
  set success($core.bool value) => $_setBool(7, value);
  @$pb.TagNumber(8)
  $core.bool hasSuccess() => $_has(7);
  @$pb.TagNumber(8)
  void clearSuccess() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get msg => $_getSZ(8);
  @$pb.TagNumber(9)
  set msg($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasMsg() => $_has(8);
  @$pb.TagNumber(9)
  void clearMsg() => $_clearField(9);
}

/// MyCover.ai product form field definition for dynamic forms
class InsuranceProductFormField extends $pb.GeneratedMessage {
  factory InsuranceProductFormField({
    $core.String? name,
    $core.String? label,
    $core.String? type,
    $core.bool? required,
    $core.Iterable<$core.String>? options,
    $core.String? defaultValue,
    $core.String? validationRegex,
    $core.String? placeholder,
    $core.String? description,
  }) {
    final result = create();
    if (name != null) result.name = name;
    if (label != null) result.label = label;
    if (type != null) result.type = type;
    if (required != null) result.required = required;
    if (options != null) result.options.addAll(options);
    if (defaultValue != null) result.defaultValue = defaultValue;
    if (validationRegex != null) result.validationRegex = validationRegex;
    if (placeholder != null) result.placeholder = placeholder;
    if (description != null) result.description = description;
    return result;
  }

  InsuranceProductFormField._();

  factory InsuranceProductFormField.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InsuranceProductFormField.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InsuranceProductFormField',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOS(2, _omitFieldNames ? '' : 'label')
    ..aOS(3, _omitFieldNames ? '' : 'type')
    ..aOB(4, _omitFieldNames ? '' : 'required')
    ..pPS(5, _omitFieldNames ? '' : 'options')
    ..aOS(6, _omitFieldNames ? '' : 'defaultValue')
    ..aOS(7, _omitFieldNames ? '' : 'validationRegex')
    ..aOS(8, _omitFieldNames ? '' : 'placeholder')
    ..aOS(9, _omitFieldNames ? '' : 'description')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InsuranceProductFormField clone() =>
      InsuranceProductFormField()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InsuranceProductFormField copyWith(
          void Function(InsuranceProductFormField) updates) =>
      super.copyWith((message) => updates(message as InsuranceProductFormField))
          as InsuranceProductFormField;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InsuranceProductFormField create() => InsuranceProductFormField._();
  @$core.override
  InsuranceProductFormField createEmptyInstance() => create();
  static $pb.PbList<InsuranceProductFormField> createRepeated() =>
      $pb.PbList<InsuranceProductFormField>();
  @$core.pragma('dart2js:noInline')
  static InsuranceProductFormField getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InsuranceProductFormField>(create);
  static InsuranceProductFormField? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get label => $_getSZ(1);
  @$pb.TagNumber(2)
  set label($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLabel() => $_has(1);
  @$pb.TagNumber(2)
  void clearLabel() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get type => $_getSZ(2);
  @$pb.TagNumber(3)
  set type($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasType() => $_has(2);
  @$pb.TagNumber(3)
  void clearType() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.bool get required => $_getBF(3);
  @$pb.TagNumber(4)
  set required($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasRequired() => $_has(3);
  @$pb.TagNumber(4)
  void clearRequired() => $_clearField(4);

  @$pb.TagNumber(5)
  $pb.PbList<$core.String> get options => $_getList(4);

  @$pb.TagNumber(6)
  $core.String get defaultValue => $_getSZ(5);
  @$pb.TagNumber(6)
  set defaultValue($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasDefaultValue() => $_has(5);
  @$pb.TagNumber(6)
  void clearDefaultValue() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get validationRegex => $_getSZ(6);
  @$pb.TagNumber(7)
  set validationRegex($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasValidationRegex() => $_has(6);
  @$pb.TagNumber(7)
  void clearValidationRegex() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get placeholder => $_getSZ(7);
  @$pb.TagNumber(8)
  set placeholder($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasPlaceholder() => $_has(7);
  @$pb.TagNumber(8)
  void clearPlaceholder() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get description => $_getSZ(8);
  @$pb.TagNumber(9)
  set description($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasDescription() => $_has(8);
  @$pb.TagNumber(9)
  void clearDescription() => $_clearField(9);
}

/// MyCover.ai insurance product
class InsuranceProduct extends $pb.GeneratedMessage {
  factory InsuranceProduct({
    $core.String? id,
    $core.String? name,
    $core.String? description,
    $core.String? category,
    $core.String? providerName,
    $core.String? providerLogo,
    $core.double? minPremium,
    $core.double? maxPremium,
    $core.String? currency,
    $core.Iterable<$core.String>? benefits,
    $core.String? termsUrl,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? metadata,
    $core.Iterable<InsuranceProductFormField>? formFields,
    $core.bool? isActive,
    $core.String? purchaseRoute,
    $core.String? providerId,
    $core.double? basePrice,
    $core.String? howItWorks,
    $core.String? fullBenefits,
    $core.bool? isRenewable,
    $core.bool? isClaimable,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (description != null) result.description = description;
    if (category != null) result.category = category;
    if (providerName != null) result.providerName = providerName;
    if (providerLogo != null) result.providerLogo = providerLogo;
    if (minPremium != null) result.minPremium = minPremium;
    if (maxPremium != null) result.maxPremium = maxPremium;
    if (currency != null) result.currency = currency;
    if (benefits != null) result.benefits.addAll(benefits);
    if (termsUrl != null) result.termsUrl = termsUrl;
    if (metadata != null) result.metadata.addEntries(metadata);
    if (formFields != null) result.formFields.addAll(formFields);
    if (isActive != null) result.isActive = isActive;
    if (purchaseRoute != null) result.purchaseRoute = purchaseRoute;
    if (providerId != null) result.providerId = providerId;
    if (basePrice != null) result.basePrice = basePrice;
    if (howItWorks != null) result.howItWorks = howItWorks;
    if (fullBenefits != null) result.fullBenefits = fullBenefits;
    if (isRenewable != null) result.isRenewable = isRenewable;
    if (isClaimable != null) result.isClaimable = isClaimable;
    return result;
  }

  InsuranceProduct._();

  factory InsuranceProduct.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InsuranceProduct.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InsuranceProduct',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..aOS(4, _omitFieldNames ? '' : 'category')
    ..aOS(5, _omitFieldNames ? '' : 'providerName')
    ..aOS(6, _omitFieldNames ? '' : 'providerLogo')
    ..a<$core.double>(
        7, _omitFieldNames ? '' : 'minPremium', $pb.PbFieldType.OD)
    ..a<$core.double>(
        8, _omitFieldNames ? '' : 'maxPremium', $pb.PbFieldType.OD)
    ..aOS(9, _omitFieldNames ? '' : 'currency')
    ..pPS(10, _omitFieldNames ? '' : 'benefits')
    ..aOS(11, _omitFieldNames ? '' : 'termsUrl')
    ..m<$core.String, $core.String>(12, _omitFieldNames ? '' : 'metadata',
        entryClassName: 'InsuranceProduct.MetadataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('pb'))
    ..pc<InsuranceProductFormField>(
        13, _omitFieldNames ? '' : 'formFields', $pb.PbFieldType.PM,
        subBuilder: InsuranceProductFormField.create)
    ..aOB(14, _omitFieldNames ? '' : 'isActive')
    ..aOS(15, _omitFieldNames ? '' : 'purchaseRoute')
    ..aOS(16, _omitFieldNames ? '' : 'providerId')
    ..a<$core.double>(
        17, _omitFieldNames ? '' : 'basePrice', $pb.PbFieldType.OD)
    ..aOS(18, _omitFieldNames ? '' : 'howItWorks')
    ..aOS(19, _omitFieldNames ? '' : 'fullBenefits')
    ..aOB(20, _omitFieldNames ? '' : 'isRenewable')
    ..aOB(21, _omitFieldNames ? '' : 'isClaimable')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InsuranceProduct clone() => InsuranceProduct()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InsuranceProduct copyWith(void Function(InsuranceProduct) updates) =>
      super.copyWith((message) => updates(message as InsuranceProduct))
          as InsuranceProduct;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InsuranceProduct create() => InsuranceProduct._();
  @$core.override
  InsuranceProduct createEmptyInstance() => create();
  static $pb.PbList<InsuranceProduct> createRepeated() =>
      $pb.PbList<InsuranceProduct>();
  @$core.pragma('dart2js:noInline')
  static InsuranceProduct getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InsuranceProduct>(create);
  static InsuranceProduct? _defaultInstance;

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
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get category => $_getSZ(3);
  @$pb.TagNumber(4)
  set category($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCategory() => $_has(3);
  @$pb.TagNumber(4)
  void clearCategory() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get providerName => $_getSZ(4);
  @$pb.TagNumber(5)
  set providerName($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasProviderName() => $_has(4);
  @$pb.TagNumber(5)
  void clearProviderName() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get providerLogo => $_getSZ(5);
  @$pb.TagNumber(6)
  set providerLogo($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasProviderLogo() => $_has(5);
  @$pb.TagNumber(6)
  void clearProviderLogo() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.double get minPremium => $_getN(6);
  @$pb.TagNumber(7)
  set minPremium($core.double value) => $_setDouble(6, value);
  @$pb.TagNumber(7)
  $core.bool hasMinPremium() => $_has(6);
  @$pb.TagNumber(7)
  void clearMinPremium() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.double get maxPremium => $_getN(7);
  @$pb.TagNumber(8)
  set maxPremium($core.double value) => $_setDouble(7, value);
  @$pb.TagNumber(8)
  $core.bool hasMaxPremium() => $_has(7);
  @$pb.TagNumber(8)
  void clearMaxPremium() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get currency => $_getSZ(8);
  @$pb.TagNumber(9)
  set currency($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasCurrency() => $_has(8);
  @$pb.TagNumber(9)
  void clearCurrency() => $_clearField(9);

  @$pb.TagNumber(10)
  $pb.PbList<$core.String> get benefits => $_getList(9);

  @$pb.TagNumber(11)
  $core.String get termsUrl => $_getSZ(10);
  @$pb.TagNumber(11)
  set termsUrl($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasTermsUrl() => $_has(10);
  @$pb.TagNumber(11)
  void clearTermsUrl() => $_clearField(11);

  @$pb.TagNumber(12)
  $pb.PbMap<$core.String, $core.String> get metadata => $_getMap(11);

  @$pb.TagNumber(13)
  $pb.PbList<InsuranceProductFormField> get formFields => $_getList(12);

  @$pb.TagNumber(14)
  $core.bool get isActive => $_getBF(13);
  @$pb.TagNumber(14)
  set isActive($core.bool value) => $_setBool(13, value);
  @$pb.TagNumber(14)
  $core.bool hasIsActive() => $_has(13);
  @$pb.TagNumber(14)
  void clearIsActive() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.String get purchaseRoute => $_getSZ(14);
  @$pb.TagNumber(15)
  set purchaseRoute($core.String value) => $_setString(14, value);
  @$pb.TagNumber(15)
  $core.bool hasPurchaseRoute() => $_has(14);
  @$pb.TagNumber(15)
  void clearPurchaseRoute() => $_clearField(15);

  @$pb.TagNumber(16)
  $core.String get providerId => $_getSZ(15);
  @$pb.TagNumber(16)
  set providerId($core.String value) => $_setString(15, value);
  @$pb.TagNumber(16)
  $core.bool hasProviderId() => $_has(15);
  @$pb.TagNumber(16)
  void clearProviderId() => $_clearField(16);

  @$pb.TagNumber(17)
  $core.double get basePrice => $_getN(16);
  @$pb.TagNumber(17)
  set basePrice($core.double value) => $_setDouble(16, value);
  @$pb.TagNumber(17)
  $core.bool hasBasePrice() => $_has(16);
  @$pb.TagNumber(17)
  void clearBasePrice() => $_clearField(17);

  @$pb.TagNumber(18)
  $core.String get howItWorks => $_getSZ(17);
  @$pb.TagNumber(18)
  set howItWorks($core.String value) => $_setString(17, value);
  @$pb.TagNumber(18)
  $core.bool hasHowItWorks() => $_has(17);
  @$pb.TagNumber(18)
  void clearHowItWorks() => $_clearField(18);

  @$pb.TagNumber(19)
  $core.String get fullBenefits => $_getSZ(18);
  @$pb.TagNumber(19)
  set fullBenefits($core.String value) => $_setString(18, value);
  @$pb.TagNumber(19)
  $core.bool hasFullBenefits() => $_has(18);
  @$pb.TagNumber(19)
  void clearFullBenefits() => $_clearField(19);

  @$pb.TagNumber(20)
  $core.bool get isRenewable => $_getBF(19);
  @$pb.TagNumber(20)
  set isRenewable($core.bool value) => $_setBool(19, value);
  @$pb.TagNumber(20)
  $core.bool hasIsRenewable() => $_has(19);
  @$pb.TagNumber(20)
  void clearIsRenewable() => $_clearField(20);

  @$pb.TagNumber(21)
  $core.bool get isClaimable => $_getBF(20);
  @$pb.TagNumber(21)
  set isClaimable($core.bool value) => $_setBool(20, value);
  @$pb.TagNumber(21)
  $core.bool hasIsClaimable() => $_has(20);
  @$pb.TagNumber(21)
  void clearIsClaimable() => $_clearField(21);
}

/// Insurance category metadata
class InsuranceCategory extends $pb.GeneratedMessage {
  factory InsuranceCategory({
    $core.String? id,
    $core.String? name,
    $core.String? icon,
    $core.String? description,
    $core.int? productCount,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (icon != null) result.icon = icon;
    if (description != null) result.description = description;
    if (productCount != null) result.productCount = productCount;
    return result;
  }

  InsuranceCategory._();

  factory InsuranceCategory.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InsuranceCategory.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InsuranceCategory',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'icon')
    ..aOS(4, _omitFieldNames ? '' : 'description')
    ..a<$core.int>(5, _omitFieldNames ? '' : 'productCount', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InsuranceCategory clone() => InsuranceCategory()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InsuranceCategory copyWith(void Function(InsuranceCategory) updates) =>
      super.copyWith((message) => updates(message as InsuranceCategory))
          as InsuranceCategory;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InsuranceCategory create() => InsuranceCategory._();
  @$core.override
  InsuranceCategory createEmptyInstance() => create();
  static $pb.PbList<InsuranceCategory> createRepeated() =>
      $pb.PbList<InsuranceCategory>();
  @$core.pragma('dart2js:noInline')
  static InsuranceCategory getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InsuranceCategory>(create);
  static InsuranceCategory? _defaultInstance;

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
  $core.String get icon => $_getSZ(2);
  @$pb.TagNumber(3)
  set icon($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasIcon() => $_has(2);
  @$pb.TagNumber(3)
  void clearIcon() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get description => $_getSZ(3);
  @$pb.TagNumber(4)
  set description($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDescription() => $_has(3);
  @$pb.TagNumber(4)
  void clearDescription() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get productCount => $_getIZ(4);
  @$pb.TagNumber(5)
  set productCount($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasProductCount() => $_has(4);
  @$pb.TagNumber(5)
  void clearProductCount() => $_clearField(5);
}

/// Quote result from MyCover.ai
class InsuranceQuote extends $pb.GeneratedMessage {
  factory InsuranceQuote({
    $core.String? quoteId,
    $core.String? productId,
    $core.double? premium,
    $core.String? currency,
    $core.String? coverageSummary,
    $core.Iterable<$core.String>? coverageItems,
    $core.String? validUntil,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? quoteDetails,
  }) {
    final result = create();
    if (quoteId != null) result.quoteId = quoteId;
    if (productId != null) result.productId = productId;
    if (premium != null) result.premium = premium;
    if (currency != null) result.currency = currency;
    if (coverageSummary != null) result.coverageSummary = coverageSummary;
    if (coverageItems != null) result.coverageItems.addAll(coverageItems);
    if (validUntil != null) result.validUntil = validUntil;
    if (quoteDetails != null) result.quoteDetails.addEntries(quoteDetails);
    return result;
  }

  InsuranceQuote._();

  factory InsuranceQuote.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InsuranceQuote.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InsuranceQuote',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'quoteId')
    ..aOS(2, _omitFieldNames ? '' : 'productId')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'premium', $pb.PbFieldType.OD)
    ..aOS(4, _omitFieldNames ? '' : 'currency')
    ..aOS(5, _omitFieldNames ? '' : 'coverageSummary')
    ..pPS(6, _omitFieldNames ? '' : 'coverageItems')
    ..aOS(7, _omitFieldNames ? '' : 'validUntil')
    ..m<$core.String, $core.String>(8, _omitFieldNames ? '' : 'quoteDetails',
        entryClassName: 'InsuranceQuote.QuoteDetailsEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('pb'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InsuranceQuote clone() => InsuranceQuote()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InsuranceQuote copyWith(void Function(InsuranceQuote) updates) =>
      super.copyWith((message) => updates(message as InsuranceQuote))
          as InsuranceQuote;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InsuranceQuote create() => InsuranceQuote._();
  @$core.override
  InsuranceQuote createEmptyInstance() => create();
  static $pb.PbList<InsuranceQuote> createRepeated() =>
      $pb.PbList<InsuranceQuote>();
  @$core.pragma('dart2js:noInline')
  static InsuranceQuote getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InsuranceQuote>(create);
  static InsuranceQuote? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get quoteId => $_getSZ(0);
  @$pb.TagNumber(1)
  set quoteId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasQuoteId() => $_has(0);
  @$pb.TagNumber(1)
  void clearQuoteId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get productId => $_getSZ(1);
  @$pb.TagNumber(2)
  set productId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasProductId() => $_has(1);
  @$pb.TagNumber(2)
  void clearProductId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get premium => $_getN(2);
  @$pb.TagNumber(3)
  set premium($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPremium() => $_has(2);
  @$pb.TagNumber(3)
  void clearPremium() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get currency => $_getSZ(3);
  @$pb.TagNumber(4)
  set currency($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCurrency() => $_has(3);
  @$pb.TagNumber(4)
  void clearCurrency() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get coverageSummary => $_getSZ(4);
  @$pb.TagNumber(5)
  set coverageSummary($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCoverageSummary() => $_has(4);
  @$pb.TagNumber(5)
  void clearCoverageSummary() => $_clearField(5);

  @$pb.TagNumber(6)
  $pb.PbList<$core.String> get coverageItems => $_getList(5);

  @$pb.TagNumber(7)
  $core.String get validUntil => $_getSZ(6);
  @$pb.TagNumber(7)
  set validUntil($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasValidUntil() => $_has(6);
  @$pb.TagNumber(7)
  void clearValidUntil() => $_clearField(7);

  @$pb.TagNumber(8)
  $pb.PbMap<$core.String, $core.String> get quoteDetails => $_getMap(7);
}

/// Purchase result
class InsurancePurchaseResult extends $pb.GeneratedMessage {
  factory InsurancePurchaseResult({
    $core.String? policyId,
    $core.String? policyNumber,
    $core.String? reference,
    $core.String? status,
    $core.String? providerReference,
    Insurance? insurance,
  }) {
    final result = create();
    if (policyId != null) result.policyId = policyId;
    if (policyNumber != null) result.policyNumber = policyNumber;
    if (reference != null) result.reference = reference;
    if (status != null) result.status = status;
    if (providerReference != null) result.providerReference = providerReference;
    if (insurance != null) result.insurance = insurance;
    return result;
  }

  InsurancePurchaseResult._();

  factory InsurancePurchaseResult.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InsurancePurchaseResult.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InsurancePurchaseResult',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'policyId')
    ..aOS(2, _omitFieldNames ? '' : 'policyNumber')
    ..aOS(3, _omitFieldNames ? '' : 'reference')
    ..aOS(4, _omitFieldNames ? '' : 'status')
    ..aOS(5, _omitFieldNames ? '' : 'providerReference')
    ..aOM<Insurance>(6, _omitFieldNames ? '' : 'insurance',
        subBuilder: Insurance.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InsurancePurchaseResult clone() =>
      InsurancePurchaseResult()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InsurancePurchaseResult copyWith(
          void Function(InsurancePurchaseResult) updates) =>
      super.copyWith((message) => updates(message as InsurancePurchaseResult))
          as InsurancePurchaseResult;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InsurancePurchaseResult create() => InsurancePurchaseResult._();
  @$core.override
  InsurancePurchaseResult createEmptyInstance() => create();
  static $pb.PbList<InsurancePurchaseResult> createRepeated() =>
      $pb.PbList<InsurancePurchaseResult>();
  @$core.pragma('dart2js:noInline')
  static InsurancePurchaseResult getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InsurancePurchaseResult>(create);
  static InsurancePurchaseResult? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get policyId => $_getSZ(0);
  @$pb.TagNumber(1)
  set policyId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPolicyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPolicyId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get policyNumber => $_getSZ(1);
  @$pb.TagNumber(2)
  set policyNumber($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPolicyNumber() => $_has(1);
  @$pb.TagNumber(2)
  void clearPolicyNumber() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get reference => $_getSZ(2);
  @$pb.TagNumber(3)
  set reference($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasReference() => $_has(2);
  @$pb.TagNumber(3)
  void clearReference() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get status => $_getSZ(3);
  @$pb.TagNumber(4)
  set status($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearStatus() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get providerReference => $_getSZ(4);
  @$pb.TagNumber(5)
  set providerReference($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasProviderReference() => $_has(4);
  @$pb.TagNumber(5)
  void clearProviderReference() => $_clearField(5);

  @$pb.TagNumber(6)
  Insurance get insurance => $_getN(5);
  @$pb.TagNumber(6)
  set insurance(Insurance value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasInsurance() => $_has(5);
  @$pb.TagNumber(6)
  void clearInsurance() => $_clearField(6);
  @$pb.TagNumber(6)
  Insurance ensureInsurance() => $_ensure(5);
}

class GetInsuranceProductsRequest extends $pb.GeneratedMessage {
  factory GetInsuranceProductsRequest({
    $core.String? category,
    $core.String? locale,
    $core.int? page,
    $core.int? limit,
  }) {
    final result = create();
    if (category != null) result.category = category;
    if (locale != null) result.locale = locale;
    if (page != null) result.page = page;
    if (limit != null) result.limit = limit;
    return result;
  }

  GetInsuranceProductsRequest._();

  factory GetInsuranceProductsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInsuranceProductsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInsuranceProductsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'category')
    ..aOS(2, _omitFieldNames ? '' : 'locale')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsuranceProductsRequest clone() =>
      GetInsuranceProductsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsuranceProductsRequest copyWith(
          void Function(GetInsuranceProductsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetInsuranceProductsRequest))
          as GetInsuranceProductsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInsuranceProductsRequest create() =>
      GetInsuranceProductsRequest._();
  @$core.override
  GetInsuranceProductsRequest createEmptyInstance() => create();
  static $pb.PbList<GetInsuranceProductsRequest> createRepeated() =>
      $pb.PbList<GetInsuranceProductsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInsuranceProductsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetInsuranceProductsRequest>(create);
  static GetInsuranceProductsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get category => $_getSZ(0);
  @$pb.TagNumber(1)
  set category($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCategory() => $_has(0);
  @$pb.TagNumber(1)
  void clearCategory() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get locale => $_getSZ(1);
  @$pb.TagNumber(2)
  set locale($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLocale() => $_has(1);
  @$pb.TagNumber(2)
  void clearLocale() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get page => $_getIZ(2);
  @$pb.TagNumber(3)
  set page($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPage() => $_has(2);
  @$pb.TagNumber(3)
  void clearPage() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get limit => $_getIZ(3);
  @$pb.TagNumber(4)
  set limit($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasLimit() => $_has(3);
  @$pb.TagNumber(4)
  void clearLimit() => $_clearField(4);
}

class GetInsuranceProductsResponse extends $pb.GeneratedMessage {
  factory GetInsuranceProductsResponse({
    $core.Iterable<InsuranceProduct>? products,
    $core.int? total,
    $core.bool? success,
    $core.String? msg,
  }) {
    final result = create();
    if (products != null) result.products.addAll(products);
    if (total != null) result.total = total;
    if (success != null) result.success = success;
    if (msg != null) result.msg = msg;
    return result;
  }

  GetInsuranceProductsResponse._();

  factory GetInsuranceProductsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInsuranceProductsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInsuranceProductsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<InsuranceProduct>(
        1, _omitFieldNames ? '' : 'products', $pb.PbFieldType.PM,
        subBuilder: InsuranceProduct.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..aOB(3, _omitFieldNames ? '' : 'success')
    ..aOS(4, _omitFieldNames ? '' : 'msg')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsuranceProductsResponse clone() =>
      GetInsuranceProductsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsuranceProductsResponse copyWith(
          void Function(GetInsuranceProductsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetInsuranceProductsResponse))
          as GetInsuranceProductsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInsuranceProductsResponse create() =>
      GetInsuranceProductsResponse._();
  @$core.override
  GetInsuranceProductsResponse createEmptyInstance() => create();
  static $pb.PbList<GetInsuranceProductsResponse> createRepeated() =>
      $pb.PbList<GetInsuranceProductsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInsuranceProductsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetInsuranceProductsResponse>(create);
  static GetInsuranceProductsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<InsuranceProduct> get products => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get success => $_getBF(2);
  @$pb.TagNumber(3)
  set success($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSuccess() => $_has(2);
  @$pb.TagNumber(3)
  void clearSuccess() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get msg => $_getSZ(3);
  @$pb.TagNumber(4)
  set msg($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMsg() => $_has(3);
  @$pb.TagNumber(4)
  void clearMsg() => $_clearField(4);
}

class GetInsuranceCategoriesRequest extends $pb.GeneratedMessage {
  factory GetInsuranceCategoriesRequest({
    $core.String? locale,
  }) {
    final result = create();
    if (locale != null) result.locale = locale;
    return result;
  }

  GetInsuranceCategoriesRequest._();

  factory GetInsuranceCategoriesRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInsuranceCategoriesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInsuranceCategoriesRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'locale')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsuranceCategoriesRequest clone() =>
      GetInsuranceCategoriesRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsuranceCategoriesRequest copyWith(
          void Function(GetInsuranceCategoriesRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetInsuranceCategoriesRequest))
          as GetInsuranceCategoriesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInsuranceCategoriesRequest create() =>
      GetInsuranceCategoriesRequest._();
  @$core.override
  GetInsuranceCategoriesRequest createEmptyInstance() => create();
  static $pb.PbList<GetInsuranceCategoriesRequest> createRepeated() =>
      $pb.PbList<GetInsuranceCategoriesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInsuranceCategoriesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetInsuranceCategoriesRequest>(create);
  static GetInsuranceCategoriesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get locale => $_getSZ(0);
  @$pb.TagNumber(1)
  set locale($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasLocale() => $_has(0);
  @$pb.TagNumber(1)
  void clearLocale() => $_clearField(1);
}

class GetInsuranceCategoriesResponse extends $pb.GeneratedMessage {
  factory GetInsuranceCategoriesResponse({
    $core.Iterable<InsuranceCategory>? categories,
    $core.bool? success,
    $core.String? msg,
  }) {
    final result = create();
    if (categories != null) result.categories.addAll(categories);
    if (success != null) result.success = success;
    if (msg != null) result.msg = msg;
    return result;
  }

  GetInsuranceCategoriesResponse._();

  factory GetInsuranceCategoriesResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInsuranceCategoriesResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInsuranceCategoriesResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<InsuranceCategory>(
        1, _omitFieldNames ? '' : 'categories', $pb.PbFieldType.PM,
        subBuilder: InsuranceCategory.create)
    ..aOB(2, _omitFieldNames ? '' : 'success')
    ..aOS(3, _omitFieldNames ? '' : 'msg')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsuranceCategoriesResponse clone() =>
      GetInsuranceCategoriesResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsuranceCategoriesResponse copyWith(
          void Function(GetInsuranceCategoriesResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetInsuranceCategoriesResponse))
          as GetInsuranceCategoriesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInsuranceCategoriesResponse create() =>
      GetInsuranceCategoriesResponse._();
  @$core.override
  GetInsuranceCategoriesResponse createEmptyInstance() => create();
  static $pb.PbList<GetInsuranceCategoriesResponse> createRepeated() =>
      $pb.PbList<GetInsuranceCategoriesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInsuranceCategoriesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetInsuranceCategoriesResponse>(create);
  static GetInsuranceCategoriesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<InsuranceCategory> get categories => $_getList(0);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get msg => $_getSZ(2);
  @$pb.TagNumber(3)
  set msg($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMsg() => $_has(2);
  @$pb.TagNumber(3)
  void clearMsg() => $_clearField(3);
}

class GetInsuranceQuoteRequest extends $pb.GeneratedMessage {
  factory GetInsuranceQuoteRequest({
    $core.String? productId,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? formData,
    $core.String? locale,
  }) {
    final result = create();
    if (productId != null) result.productId = productId;
    if (formData != null) result.formData.addEntries(formData);
    if (locale != null) result.locale = locale;
    return result;
  }

  GetInsuranceQuoteRequest._();

  factory GetInsuranceQuoteRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInsuranceQuoteRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInsuranceQuoteRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'productId')
    ..m<$core.String, $core.String>(2, _omitFieldNames ? '' : 'formData',
        entryClassName: 'GetInsuranceQuoteRequest.FormDataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('pb'))
    ..aOS(3, _omitFieldNames ? '' : 'locale')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsuranceQuoteRequest clone() =>
      GetInsuranceQuoteRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsuranceQuoteRequest copyWith(
          void Function(GetInsuranceQuoteRequest) updates) =>
      super.copyWith((message) => updates(message as GetInsuranceQuoteRequest))
          as GetInsuranceQuoteRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInsuranceQuoteRequest create() => GetInsuranceQuoteRequest._();
  @$core.override
  GetInsuranceQuoteRequest createEmptyInstance() => create();
  static $pb.PbList<GetInsuranceQuoteRequest> createRepeated() =>
      $pb.PbList<GetInsuranceQuoteRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInsuranceQuoteRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetInsuranceQuoteRequest>(create);
  static GetInsuranceQuoteRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get productId => $_getSZ(0);
  @$pb.TagNumber(1)
  set productId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasProductId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProductId() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbMap<$core.String, $core.String> get formData => $_getMap(1);

  @$pb.TagNumber(3)
  $core.String get locale => $_getSZ(2);
  @$pb.TagNumber(3)
  set locale($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLocale() => $_has(2);
  @$pb.TagNumber(3)
  void clearLocale() => $_clearField(3);
}

class GetInsuranceQuoteResponse extends $pb.GeneratedMessage {
  factory GetInsuranceQuoteResponse({
    InsuranceQuote? quote,
    $core.bool? success,
    $core.String? msg,
  }) {
    final result = create();
    if (quote != null) result.quote = quote;
    if (success != null) result.success = success;
    if (msg != null) result.msg = msg;
    return result;
  }

  GetInsuranceQuoteResponse._();

  factory GetInsuranceQuoteResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInsuranceQuoteResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInsuranceQuoteResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<InsuranceQuote>(1, _omitFieldNames ? '' : 'quote',
        subBuilder: InsuranceQuote.create)
    ..aOB(2, _omitFieldNames ? '' : 'success')
    ..aOS(3, _omitFieldNames ? '' : 'msg')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsuranceQuoteResponse clone() =>
      GetInsuranceQuoteResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsuranceQuoteResponse copyWith(
          void Function(GetInsuranceQuoteResponse) updates) =>
      super.copyWith((message) => updates(message as GetInsuranceQuoteResponse))
          as GetInsuranceQuoteResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInsuranceQuoteResponse create() => GetInsuranceQuoteResponse._();
  @$core.override
  GetInsuranceQuoteResponse createEmptyInstance() => create();
  static $pb.PbList<GetInsuranceQuoteResponse> createRepeated() =>
      $pb.PbList<GetInsuranceQuoteResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInsuranceQuoteResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetInsuranceQuoteResponse>(create);
  static GetInsuranceQuoteResponse? _defaultInstance;

  @$pb.TagNumber(1)
  InsuranceQuote get quote => $_getN(0);
  @$pb.TagNumber(1)
  set quote(InsuranceQuote value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasQuote() => $_has(0);
  @$pb.TagNumber(1)
  void clearQuote() => $_clearField(1);
  @$pb.TagNumber(1)
  InsuranceQuote ensureQuote() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get msg => $_getSZ(2);
  @$pb.TagNumber(3)
  set msg($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMsg() => $_has(2);
  @$pb.TagNumber(3)
  void clearMsg() => $_clearField(3);
}

class PurchaseInsuranceRequest extends $pb.GeneratedMessage {
  factory PurchaseInsuranceRequest({
    $core.String? quoteId,
    $core.String? productId,
    $core.String? accountId,
    $core.String? transactionPin,
    $core.String? idempotencyKey,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? formData,
    $core.String? locale,
  }) {
    final result = create();
    if (quoteId != null) result.quoteId = quoteId;
    if (productId != null) result.productId = productId;
    if (accountId != null) result.accountId = accountId;
    if (transactionPin != null) result.transactionPin = transactionPin;
    if (idempotencyKey != null) result.idempotencyKey = idempotencyKey;
    if (formData != null) result.formData.addEntries(formData);
    if (locale != null) result.locale = locale;
    return result;
  }

  PurchaseInsuranceRequest._();

  factory PurchaseInsuranceRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PurchaseInsuranceRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PurchaseInsuranceRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'quoteId')
    ..aOS(2, _omitFieldNames ? '' : 'productId')
    ..aOS(3, _omitFieldNames ? '' : 'accountId')
    ..aOS(4, _omitFieldNames ? '' : 'transactionPin')
    ..aOS(5, _omitFieldNames ? '' : 'idempotencyKey')
    ..m<$core.String, $core.String>(6, _omitFieldNames ? '' : 'formData',
        entryClassName: 'PurchaseInsuranceRequest.FormDataEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('pb'))
    ..aOS(7, _omitFieldNames ? '' : 'locale')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PurchaseInsuranceRequest clone() =>
      PurchaseInsuranceRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PurchaseInsuranceRequest copyWith(
          void Function(PurchaseInsuranceRequest) updates) =>
      super.copyWith((message) => updates(message as PurchaseInsuranceRequest))
          as PurchaseInsuranceRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PurchaseInsuranceRequest create() => PurchaseInsuranceRequest._();
  @$core.override
  PurchaseInsuranceRequest createEmptyInstance() => create();
  static $pb.PbList<PurchaseInsuranceRequest> createRepeated() =>
      $pb.PbList<PurchaseInsuranceRequest>();
  @$core.pragma('dart2js:noInline')
  static PurchaseInsuranceRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PurchaseInsuranceRequest>(create);
  static PurchaseInsuranceRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get quoteId => $_getSZ(0);
  @$pb.TagNumber(1)
  set quoteId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasQuoteId() => $_has(0);
  @$pb.TagNumber(1)
  void clearQuoteId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get productId => $_getSZ(1);
  @$pb.TagNumber(2)
  set productId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasProductId() => $_has(1);
  @$pb.TagNumber(2)
  void clearProductId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get accountId => $_getSZ(2);
  @$pb.TagNumber(3)
  set accountId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAccountId() => $_has(2);
  @$pb.TagNumber(3)
  void clearAccountId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get transactionPin => $_getSZ(3);
  @$pb.TagNumber(4)
  set transactionPin($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTransactionPin() => $_has(3);
  @$pb.TagNumber(4)
  void clearTransactionPin() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get idempotencyKey => $_getSZ(4);
  @$pb.TagNumber(5)
  set idempotencyKey($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasIdempotencyKey() => $_has(4);
  @$pb.TagNumber(5)
  void clearIdempotencyKey() => $_clearField(5);

  @$pb.TagNumber(6)
  $pb.PbMap<$core.String, $core.String> get formData => $_getMap(5);

  @$pb.TagNumber(7)
  $core.String get locale => $_getSZ(6);
  @$pb.TagNumber(7)
  set locale($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasLocale() => $_has(6);
  @$pb.TagNumber(7)
  void clearLocale() => $_clearField(7);
}

class PurchaseInsuranceResponse extends $pb.GeneratedMessage {
  factory PurchaseInsuranceResponse({
    InsurancePurchaseResult? result,
    $core.bool? success,
    $core.String? msg,
  }) {
    final result$ = create();
    if (result != null) result$.result = result;
    if (success != null) result$.success = success;
    if (msg != null) result$.msg = msg;
    return result$;
  }

  PurchaseInsuranceResponse._();

  factory PurchaseInsuranceResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PurchaseInsuranceResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PurchaseInsuranceResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<InsurancePurchaseResult>(1, _omitFieldNames ? '' : 'result',
        subBuilder: InsurancePurchaseResult.create)
    ..aOB(2, _omitFieldNames ? '' : 'success')
    ..aOS(3, _omitFieldNames ? '' : 'msg')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PurchaseInsuranceResponse clone() =>
      PurchaseInsuranceResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PurchaseInsuranceResponse copyWith(
          void Function(PurchaseInsuranceResponse) updates) =>
      super.copyWith((message) => updates(message as PurchaseInsuranceResponse))
          as PurchaseInsuranceResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PurchaseInsuranceResponse create() => PurchaseInsuranceResponse._();
  @$core.override
  PurchaseInsuranceResponse createEmptyInstance() => create();
  static $pb.PbList<PurchaseInsuranceResponse> createRepeated() =>
      $pb.PbList<PurchaseInsuranceResponse>();
  @$core.pragma('dart2js:noInline')
  static PurchaseInsuranceResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PurchaseInsuranceResponse>(create);
  static PurchaseInsuranceResponse? _defaultInstance;

  @$pb.TagNumber(1)
  InsurancePurchaseResult get result => $_getN(0);
  @$pb.TagNumber(1)
  set result(InsurancePurchaseResult value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasResult() => $_has(0);
  @$pb.TagNumber(1)
  void clearResult() => $_clearField(1);
  @$pb.TagNumber(1)
  InsurancePurchaseResult ensureResult() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get msg => $_getSZ(2);
  @$pb.TagNumber(3)
  set msg($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMsg() => $_has(2);
  @$pb.TagNumber(3)
  void clearMsg() => $_clearField(3);
}

class GetInsurancePurchaseStatusRequest extends $pb.GeneratedMessage {
  factory GetInsurancePurchaseStatusRequest({
    $core.String? reference,
  }) {
    final result = create();
    if (reference != null) result.reference = reference;
    return result;
  }

  GetInsurancePurchaseStatusRequest._();

  factory GetInsurancePurchaseStatusRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInsurancePurchaseStatusRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInsurancePurchaseStatusRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'reference')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsurancePurchaseStatusRequest clone() =>
      GetInsurancePurchaseStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsurancePurchaseStatusRequest copyWith(
          void Function(GetInsurancePurchaseStatusRequest) updates) =>
      super.copyWith((message) =>
              updates(message as GetInsurancePurchaseStatusRequest))
          as GetInsurancePurchaseStatusRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInsurancePurchaseStatusRequest create() =>
      GetInsurancePurchaseStatusRequest._();
  @$core.override
  GetInsurancePurchaseStatusRequest createEmptyInstance() => create();
  static $pb.PbList<GetInsurancePurchaseStatusRequest> createRepeated() =>
      $pb.PbList<GetInsurancePurchaseStatusRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInsurancePurchaseStatusRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetInsurancePurchaseStatusRequest>(
          create);
  static GetInsurancePurchaseStatusRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get reference => $_getSZ(0);
  @$pb.TagNumber(1)
  set reference($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasReference() => $_has(0);
  @$pb.TagNumber(1)
  void clearReference() => $_clearField(1);
}

class GetInsurancePurchaseStatusResponse extends $pb.GeneratedMessage {
  factory GetInsurancePurchaseStatusResponse({
    InsurancePurchaseResult? result,
    $core.bool? success,
    $core.String? msg,
  }) {
    final result$ = create();
    if (result != null) result$.result = result;
    if (success != null) result$.success = success;
    if (msg != null) result$.msg = msg;
    return result$;
  }

  GetInsurancePurchaseStatusResponse._();

  factory GetInsurancePurchaseStatusResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInsurancePurchaseStatusResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInsurancePurchaseStatusResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<InsurancePurchaseResult>(1, _omitFieldNames ? '' : 'result',
        subBuilder: InsurancePurchaseResult.create)
    ..aOB(2, _omitFieldNames ? '' : 'success')
    ..aOS(3, _omitFieldNames ? '' : 'msg')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsurancePurchaseStatusResponse clone() =>
      GetInsurancePurchaseStatusResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsurancePurchaseStatusResponse copyWith(
          void Function(GetInsurancePurchaseStatusResponse) updates) =>
      super.copyWith((message) =>
              updates(message as GetInsurancePurchaseStatusResponse))
          as GetInsurancePurchaseStatusResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInsurancePurchaseStatusResponse create() =>
      GetInsurancePurchaseStatusResponse._();
  @$core.override
  GetInsurancePurchaseStatusResponse createEmptyInstance() => create();
  static $pb.PbList<GetInsurancePurchaseStatusResponse> createRepeated() =>
      $pb.PbList<GetInsurancePurchaseStatusResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInsurancePurchaseStatusResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetInsurancePurchaseStatusResponse>(
          create);
  static GetInsurancePurchaseStatusResponse? _defaultInstance;

  @$pb.TagNumber(1)
  InsurancePurchaseResult get result => $_getN(0);
  @$pb.TagNumber(1)
  set result(InsurancePurchaseResult value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasResult() => $_has(0);
  @$pb.TagNumber(1)
  void clearResult() => $_clearField(1);
  @$pb.TagNumber(1)
  InsurancePurchaseResult ensureResult() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get msg => $_getSZ(2);
  @$pb.TagNumber(3)
  set msg($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMsg() => $_has(2);
  @$pb.TagNumber(3)
  void clearMsg() => $_clearField(3);
}

/// Upload insurance document (ID, proof of purchase, claim evidence, device photo)
class UploadInsuranceDocumentRequest extends $pb.GeneratedMessage {
  factory UploadInsuranceDocumentRequest({
    $core.List<$core.int>? fileData,
    $core.String? filename,
    $core.String? documentType,
  }) {
    final result = create();
    if (fileData != null) result.fileData = fileData;
    if (filename != null) result.filename = filename;
    if (documentType != null) result.documentType = documentType;
    return result;
  }

  UploadInsuranceDocumentRequest._();

  factory UploadInsuranceDocumentRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UploadInsuranceDocumentRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UploadInsuranceDocumentRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..a<$core.List<$core.int>>(
        1, _omitFieldNames ? '' : 'fileData', $pb.PbFieldType.OY)
    ..aOS(2, _omitFieldNames ? '' : 'filename')
    ..aOS(3, _omitFieldNames ? '' : 'documentType')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UploadInsuranceDocumentRequest clone() =>
      UploadInsuranceDocumentRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UploadInsuranceDocumentRequest copyWith(
          void Function(UploadInsuranceDocumentRequest) updates) =>
      super.copyWith(
              (message) => updates(message as UploadInsuranceDocumentRequest))
          as UploadInsuranceDocumentRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UploadInsuranceDocumentRequest create() =>
      UploadInsuranceDocumentRequest._();
  @$core.override
  UploadInsuranceDocumentRequest createEmptyInstance() => create();
  static $pb.PbList<UploadInsuranceDocumentRequest> createRepeated() =>
      $pb.PbList<UploadInsuranceDocumentRequest>();
  @$core.pragma('dart2js:noInline')
  static UploadInsuranceDocumentRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UploadInsuranceDocumentRequest>(create);
  static UploadInsuranceDocumentRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get fileData => $_getN(0);
  @$pb.TagNumber(1)
  set fileData($core.List<$core.int> value) => $_setBytes(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFileData() => $_has(0);
  @$pb.TagNumber(1)
  void clearFileData() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get filename => $_getSZ(1);
  @$pb.TagNumber(2)
  set filename($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasFilename() => $_has(1);
  @$pb.TagNumber(2)
  void clearFilename() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get documentType => $_getSZ(2);
  @$pb.TagNumber(3)
  set documentType($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDocumentType() => $_has(2);
  @$pb.TagNumber(3)
  void clearDocumentType() => $_clearField(3);
}

class UploadInsuranceDocumentResponse extends $pb.GeneratedMessage {
  factory UploadInsuranceDocumentResponse({
    $core.String? uploadId,
    $core.String? fileUrl,
    $core.bool? success,
    $core.String? msg,
  }) {
    final result = create();
    if (uploadId != null) result.uploadId = uploadId;
    if (fileUrl != null) result.fileUrl = fileUrl;
    if (success != null) result.success = success;
    if (msg != null) result.msg = msg;
    return result;
  }

  UploadInsuranceDocumentResponse._();

  factory UploadInsuranceDocumentResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UploadInsuranceDocumentResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UploadInsuranceDocumentResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'uploadId')
    ..aOS(2, _omitFieldNames ? '' : 'fileUrl')
    ..aOB(3, _omitFieldNames ? '' : 'success')
    ..aOS(4, _omitFieldNames ? '' : 'msg')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UploadInsuranceDocumentResponse clone() =>
      UploadInsuranceDocumentResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UploadInsuranceDocumentResponse copyWith(
          void Function(UploadInsuranceDocumentResponse) updates) =>
      super.copyWith(
              (message) => updates(message as UploadInsuranceDocumentResponse))
          as UploadInsuranceDocumentResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UploadInsuranceDocumentResponse create() =>
      UploadInsuranceDocumentResponse._();
  @$core.override
  UploadInsuranceDocumentResponse createEmptyInstance() => create();
  static $pb.PbList<UploadInsuranceDocumentResponse> createRepeated() =>
      $pb.PbList<UploadInsuranceDocumentResponse>();
  @$core.pragma('dart2js:noInline')
  static UploadInsuranceDocumentResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UploadInsuranceDocumentResponse>(
          create);
  static UploadInsuranceDocumentResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get uploadId => $_getSZ(0);
  @$pb.TagNumber(1)
  set uploadId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUploadId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUploadId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get fileUrl => $_getSZ(1);
  @$pb.TagNumber(2)
  set fileUrl($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasFileUrl() => $_has(1);
  @$pb.TagNumber(2)
  void clearFileUrl() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get success => $_getBF(2);
  @$pb.TagNumber(3)
  set success($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSuccess() => $_has(2);
  @$pb.TagNumber(3)
  void clearSuccess() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get msg => $_getSZ(3);
  @$pb.TagNumber(4)
  set msg($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMsg() => $_has(3);
  @$pb.TagNumber(4)
  void clearMsg() => $_clearField(4);
}

/// Get auxiliary data (states, vehicle makes/models, genders, etc.)
class GetInsuranceAuxiliaryDataRequest extends $pb.GeneratedMessage {
  factory GetInsuranceAuxiliaryDataRequest({
    $core.String? utilityId,
    $core.String? query,
  }) {
    final result = create();
    if (utilityId != null) result.utilityId = utilityId;
    if (query != null) result.query = query;
    return result;
  }

  GetInsuranceAuxiliaryDataRequest._();

  factory GetInsuranceAuxiliaryDataRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInsuranceAuxiliaryDataRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInsuranceAuxiliaryDataRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'utilityId')
    ..aOS(2, _omitFieldNames ? '' : 'query')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsuranceAuxiliaryDataRequest clone() =>
      GetInsuranceAuxiliaryDataRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsuranceAuxiliaryDataRequest copyWith(
          void Function(GetInsuranceAuxiliaryDataRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetInsuranceAuxiliaryDataRequest))
          as GetInsuranceAuxiliaryDataRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInsuranceAuxiliaryDataRequest create() =>
      GetInsuranceAuxiliaryDataRequest._();
  @$core.override
  GetInsuranceAuxiliaryDataRequest createEmptyInstance() => create();
  static $pb.PbList<GetInsuranceAuxiliaryDataRequest> createRepeated() =>
      $pb.PbList<GetInsuranceAuxiliaryDataRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInsuranceAuxiliaryDataRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetInsuranceAuxiliaryDataRequest>(
          create);
  static GetInsuranceAuxiliaryDataRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get utilityId => $_getSZ(0);
  @$pb.TagNumber(1)
  set utilityId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUtilityId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUtilityId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get query => $_getSZ(1);
  @$pb.TagNumber(2)
  set query($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasQuery() => $_has(1);
  @$pb.TagNumber(2)
  void clearQuery() => $_clearField(2);
}

class GetInsuranceAuxiliaryDataResponse extends $pb.GeneratedMessage {
  factory GetInsuranceAuxiliaryDataResponse({
    $core.Iterable<InsuranceAuxiliaryItem>? items,
    $core.bool? success,
    $core.String? msg,
  }) {
    final result = create();
    if (items != null) result.items.addAll(items);
    if (success != null) result.success = success;
    if (msg != null) result.msg = msg;
    return result;
  }

  GetInsuranceAuxiliaryDataResponse._();

  factory GetInsuranceAuxiliaryDataResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInsuranceAuxiliaryDataResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInsuranceAuxiliaryDataResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<InsuranceAuxiliaryItem>(
        1, _omitFieldNames ? '' : 'items', $pb.PbFieldType.PM,
        subBuilder: InsuranceAuxiliaryItem.create)
    ..aOB(2, _omitFieldNames ? '' : 'success')
    ..aOS(3, _omitFieldNames ? '' : 'msg')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsuranceAuxiliaryDataResponse clone() =>
      GetInsuranceAuxiliaryDataResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsuranceAuxiliaryDataResponse copyWith(
          void Function(GetInsuranceAuxiliaryDataResponse) updates) =>
      super.copyWith((message) =>
              updates(message as GetInsuranceAuxiliaryDataResponse))
          as GetInsuranceAuxiliaryDataResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInsuranceAuxiliaryDataResponse create() =>
      GetInsuranceAuxiliaryDataResponse._();
  @$core.override
  GetInsuranceAuxiliaryDataResponse createEmptyInstance() => create();
  static $pb.PbList<GetInsuranceAuxiliaryDataResponse> createRepeated() =>
      $pb.PbList<GetInsuranceAuxiliaryDataResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInsuranceAuxiliaryDataResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetInsuranceAuxiliaryDataResponse>(
          create);
  static GetInsuranceAuxiliaryDataResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<InsuranceAuxiliaryItem> get items => $_getList(0);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get msg => $_getSZ(2);
  @$pb.TagNumber(3)
  set msg($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMsg() => $_has(2);
  @$pb.TagNumber(3)
  void clearMsg() => $_clearField(3);
}

class InsuranceAuxiliaryItem extends $pb.GeneratedMessage {
  factory InsuranceAuxiliaryItem({
    $core.String? label,
    $core.String? value,
  }) {
    final result = create();
    if (label != null) result.label = label;
    if (value != null) result.value = value;
    return result;
  }

  InsuranceAuxiliaryItem._();

  factory InsuranceAuxiliaryItem.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InsuranceAuxiliaryItem.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InsuranceAuxiliaryItem',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'label')
    ..aOS(2, _omitFieldNames ? '' : 'value')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InsuranceAuxiliaryItem clone() =>
      InsuranceAuxiliaryItem()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InsuranceAuxiliaryItem copyWith(
          void Function(InsuranceAuxiliaryItem) updates) =>
      super.copyWith((message) => updates(message as InsuranceAuxiliaryItem))
          as InsuranceAuxiliaryItem;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InsuranceAuxiliaryItem create() => InsuranceAuxiliaryItem._();
  @$core.override
  InsuranceAuxiliaryItem createEmptyInstance() => create();
  static $pb.PbList<InsuranceAuxiliaryItem> createRepeated() =>
      $pb.PbList<InsuranceAuxiliaryItem>();
  @$core.pragma('dart2js:noInline')
  static InsuranceAuxiliaryItem getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InsuranceAuxiliaryItem>(create);
  static InsuranceAuxiliaryItem? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get label => $_getSZ(0);
  @$pb.TagNumber(1)
  set label($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasLabel() => $_has(0);
  @$pb.TagNumber(1)
  void clearLabel() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get value => $_getSZ(1);
  @$pb.TagNumber(2)
  set value($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearValue() => $_clearField(2);
}

/// Data Models
class Insurance extends $pb.GeneratedMessage {
  factory Insurance({
    $core.String? id,
    $core.String? policyNumber,
    $core.String? policyHolderName,
    $core.String? policyHolderEmail,
    $core.String? policyHolderPhone,
    $core.String? type,
    $core.String? provider,
    $core.String? providerLogo,
    $core.double? premiumAmount,
    $core.double? coverageAmount,
    $core.String? currency,
    $core.String? startDate,
    $core.String? endDate,
    $core.String? nextPaymentDate,
    $core.String? status,
    $core.Iterable<$core.String>? beneficiaries,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? coverageDetails,
    $core.String? description,
    $core.String? userId,
    $core.String? createdAt,
    $core.String? updatedAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (policyNumber != null) result.policyNumber = policyNumber;
    if (policyHolderName != null) result.policyHolderName = policyHolderName;
    if (policyHolderEmail != null) result.policyHolderEmail = policyHolderEmail;
    if (policyHolderPhone != null) result.policyHolderPhone = policyHolderPhone;
    if (type != null) result.type = type;
    if (provider != null) result.provider = provider;
    if (providerLogo != null) result.providerLogo = providerLogo;
    if (premiumAmount != null) result.premiumAmount = premiumAmount;
    if (coverageAmount != null) result.coverageAmount = coverageAmount;
    if (currency != null) result.currency = currency;
    if (startDate != null) result.startDate = startDate;
    if (endDate != null) result.endDate = endDate;
    if (nextPaymentDate != null) result.nextPaymentDate = nextPaymentDate;
    if (status != null) result.status = status;
    if (beneficiaries != null) result.beneficiaries.addAll(beneficiaries);
    if (coverageDetails != null)
      result.coverageDetails.addEntries(coverageDetails);
    if (description != null) result.description = description;
    if (userId != null) result.userId = userId;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    return result;
  }

  Insurance._();

  factory Insurance.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Insurance.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Insurance',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'policyNumber')
    ..aOS(3, _omitFieldNames ? '' : 'policyHolderName')
    ..aOS(4, _omitFieldNames ? '' : 'policyHolderEmail')
    ..aOS(5, _omitFieldNames ? '' : 'policyHolderPhone')
    ..aOS(6, _omitFieldNames ? '' : 'type')
    ..aOS(7, _omitFieldNames ? '' : 'provider')
    ..aOS(8, _omitFieldNames ? '' : 'providerLogo')
    ..a<$core.double>(
        9, _omitFieldNames ? '' : 'premiumAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(
        10, _omitFieldNames ? '' : 'coverageAmount', $pb.PbFieldType.OD)
    ..aOS(11, _omitFieldNames ? '' : 'currency')
    ..aOS(12, _omitFieldNames ? '' : 'startDate')
    ..aOS(13, _omitFieldNames ? '' : 'endDate')
    ..aOS(14, _omitFieldNames ? '' : 'nextPaymentDate')
    ..aOS(15, _omitFieldNames ? '' : 'status')
    ..pPS(16, _omitFieldNames ? '' : 'beneficiaries')
    ..m<$core.String, $core.String>(
        17, _omitFieldNames ? '' : 'coverageDetails',
        entryClassName: 'Insurance.CoverageDetailsEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('pb'))
    ..aOS(18, _omitFieldNames ? '' : 'description')
    ..aOS(19, _omitFieldNames ? '' : 'userId')
    ..aOS(20, _omitFieldNames ? '' : 'createdAt')
    ..aOS(21, _omitFieldNames ? '' : 'updatedAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Insurance clone() => Insurance()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Insurance copyWith(void Function(Insurance) updates) =>
      super.copyWith((message) => updates(message as Insurance)) as Insurance;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Insurance create() => Insurance._();
  @$core.override
  Insurance createEmptyInstance() => create();
  static $pb.PbList<Insurance> createRepeated() => $pb.PbList<Insurance>();
  @$core.pragma('dart2js:noInline')
  static Insurance getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Insurance>(create);
  static Insurance? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get policyNumber => $_getSZ(1);
  @$pb.TagNumber(2)
  set policyNumber($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPolicyNumber() => $_has(1);
  @$pb.TagNumber(2)
  void clearPolicyNumber() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get policyHolderName => $_getSZ(2);
  @$pb.TagNumber(3)
  set policyHolderName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPolicyHolderName() => $_has(2);
  @$pb.TagNumber(3)
  void clearPolicyHolderName() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get policyHolderEmail => $_getSZ(3);
  @$pb.TagNumber(4)
  set policyHolderEmail($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPolicyHolderEmail() => $_has(3);
  @$pb.TagNumber(4)
  void clearPolicyHolderEmail() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get policyHolderPhone => $_getSZ(4);
  @$pb.TagNumber(5)
  set policyHolderPhone($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasPolicyHolderPhone() => $_has(4);
  @$pb.TagNumber(5)
  void clearPolicyHolderPhone() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get type => $_getSZ(5);
  @$pb.TagNumber(6)
  set type($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasType() => $_has(5);
  @$pb.TagNumber(6)
  void clearType() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get provider => $_getSZ(6);
  @$pb.TagNumber(7)
  set provider($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasProvider() => $_has(6);
  @$pb.TagNumber(7)
  void clearProvider() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get providerLogo => $_getSZ(7);
  @$pb.TagNumber(8)
  set providerLogo($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasProviderLogo() => $_has(7);
  @$pb.TagNumber(8)
  void clearProviderLogo() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.double get premiumAmount => $_getN(8);
  @$pb.TagNumber(9)
  set premiumAmount($core.double value) => $_setDouble(8, value);
  @$pb.TagNumber(9)
  $core.bool hasPremiumAmount() => $_has(8);
  @$pb.TagNumber(9)
  void clearPremiumAmount() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.double get coverageAmount => $_getN(9);
  @$pb.TagNumber(10)
  set coverageAmount($core.double value) => $_setDouble(9, value);
  @$pb.TagNumber(10)
  $core.bool hasCoverageAmount() => $_has(9);
  @$pb.TagNumber(10)
  void clearCoverageAmount() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get currency => $_getSZ(10);
  @$pb.TagNumber(11)
  set currency($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasCurrency() => $_has(10);
  @$pb.TagNumber(11)
  void clearCurrency() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get startDate => $_getSZ(11);
  @$pb.TagNumber(12)
  set startDate($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasStartDate() => $_has(11);
  @$pb.TagNumber(12)
  void clearStartDate() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get endDate => $_getSZ(12);
  @$pb.TagNumber(13)
  set endDate($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasEndDate() => $_has(12);
  @$pb.TagNumber(13)
  void clearEndDate() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.String get nextPaymentDate => $_getSZ(13);
  @$pb.TagNumber(14)
  set nextPaymentDate($core.String value) => $_setString(13, value);
  @$pb.TagNumber(14)
  $core.bool hasNextPaymentDate() => $_has(13);
  @$pb.TagNumber(14)
  void clearNextPaymentDate() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.String get status => $_getSZ(14);
  @$pb.TagNumber(15)
  set status($core.String value) => $_setString(14, value);
  @$pb.TagNumber(15)
  $core.bool hasStatus() => $_has(14);
  @$pb.TagNumber(15)
  void clearStatus() => $_clearField(15);

  @$pb.TagNumber(16)
  $pb.PbList<$core.String> get beneficiaries => $_getList(15);

  @$pb.TagNumber(17)
  $pb.PbMap<$core.String, $core.String> get coverageDetails => $_getMap(16);

  @$pb.TagNumber(18)
  $core.String get description => $_getSZ(17);
  @$pb.TagNumber(18)
  set description($core.String value) => $_setString(17, value);
  @$pb.TagNumber(18)
  $core.bool hasDescription() => $_has(17);
  @$pb.TagNumber(18)
  void clearDescription() => $_clearField(18);

  @$pb.TagNumber(19)
  $core.String get userId => $_getSZ(18);
  @$pb.TagNumber(19)
  set userId($core.String value) => $_setString(18, value);
  @$pb.TagNumber(19)
  $core.bool hasUserId() => $_has(18);
  @$pb.TagNumber(19)
  void clearUserId() => $_clearField(19);

  @$pb.TagNumber(20)
  $core.String get createdAt => $_getSZ(19);
  @$pb.TagNumber(20)
  set createdAt($core.String value) => $_setString(19, value);
  @$pb.TagNumber(20)
  $core.bool hasCreatedAt() => $_has(19);
  @$pb.TagNumber(20)
  void clearCreatedAt() => $_clearField(20);

  @$pb.TagNumber(21)
  $core.String get updatedAt => $_getSZ(20);
  @$pb.TagNumber(21)
  set updatedAt($core.String value) => $_setString(20, value);
  @$pb.TagNumber(21)
  $core.bool hasUpdatedAt() => $_has(20);
  @$pb.TagNumber(21)
  void clearUpdatedAt() => $_clearField(21);
}

class InsurancePayment extends $pb.GeneratedMessage {
  factory InsurancePayment({
    $core.String? id,
    $core.String? insuranceId,
    $core.String? policyNumber,
    $core.double? amount,
    $core.String? currency,
    $core.String? paymentMethod,
    $core.String? status,
    $core.String? transactionId,
    $core.String? referenceNumber,
    $core.String? paymentDate,
    $core.String? dueDate,
    $core.String? processedAt,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? paymentDetails,
    $core.String? failureReason,
    $core.String? receiptUrl,
    $core.String? userId,
    $core.String? createdAt,
    $core.String? updatedAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (insuranceId != null) result.insuranceId = insuranceId;
    if (policyNumber != null) result.policyNumber = policyNumber;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    if (paymentMethod != null) result.paymentMethod = paymentMethod;
    if (status != null) result.status = status;
    if (transactionId != null) result.transactionId = transactionId;
    if (referenceNumber != null) result.referenceNumber = referenceNumber;
    if (paymentDate != null) result.paymentDate = paymentDate;
    if (dueDate != null) result.dueDate = dueDate;
    if (processedAt != null) result.processedAt = processedAt;
    if (paymentDetails != null)
      result.paymentDetails.addEntries(paymentDetails);
    if (failureReason != null) result.failureReason = failureReason;
    if (receiptUrl != null) result.receiptUrl = receiptUrl;
    if (userId != null) result.userId = userId;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    return result;
  }

  InsurancePayment._();

  factory InsurancePayment.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InsurancePayment.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InsurancePayment',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'insuranceId')
    ..aOS(3, _omitFieldNames ? '' : 'policyNumber')
    ..a<$core.double>(4, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(5, _omitFieldNames ? '' : 'currency')
    ..aOS(6, _omitFieldNames ? '' : 'paymentMethod')
    ..aOS(7, _omitFieldNames ? '' : 'status')
    ..aOS(8, _omitFieldNames ? '' : 'transactionId')
    ..aOS(9, _omitFieldNames ? '' : 'referenceNumber')
    ..aOS(10, _omitFieldNames ? '' : 'paymentDate')
    ..aOS(11, _omitFieldNames ? '' : 'dueDate')
    ..aOS(12, _omitFieldNames ? '' : 'processedAt')
    ..m<$core.String, $core.String>(13, _omitFieldNames ? '' : 'paymentDetails',
        entryClassName: 'InsurancePayment.PaymentDetailsEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('pb'))
    ..aOS(14, _omitFieldNames ? '' : 'failureReason')
    ..aOS(15, _omitFieldNames ? '' : 'receiptUrl')
    ..aOS(16, _omitFieldNames ? '' : 'userId')
    ..aOS(17, _omitFieldNames ? '' : 'createdAt')
    ..aOS(18, _omitFieldNames ? '' : 'updatedAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InsurancePayment clone() => InsurancePayment()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InsurancePayment copyWith(void Function(InsurancePayment) updates) =>
      super.copyWith((message) => updates(message as InsurancePayment))
          as InsurancePayment;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InsurancePayment create() => InsurancePayment._();
  @$core.override
  InsurancePayment createEmptyInstance() => create();
  static $pb.PbList<InsurancePayment> createRepeated() =>
      $pb.PbList<InsurancePayment>();
  @$core.pragma('dart2js:noInline')
  static InsurancePayment getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InsurancePayment>(create);
  static InsurancePayment? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get insuranceId => $_getSZ(1);
  @$pb.TagNumber(2)
  set insuranceId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasInsuranceId() => $_has(1);
  @$pb.TagNumber(2)
  void clearInsuranceId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get policyNumber => $_getSZ(2);
  @$pb.TagNumber(3)
  set policyNumber($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPolicyNumber() => $_has(2);
  @$pb.TagNumber(3)
  void clearPolicyNumber() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get amount => $_getN(3);
  @$pb.TagNumber(4)
  set amount($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearAmount() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get currency => $_getSZ(4);
  @$pb.TagNumber(5)
  set currency($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCurrency() => $_has(4);
  @$pb.TagNumber(5)
  void clearCurrency() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get paymentMethod => $_getSZ(5);
  @$pb.TagNumber(6)
  set paymentMethod($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasPaymentMethod() => $_has(5);
  @$pb.TagNumber(6)
  void clearPaymentMethod() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get status => $_getSZ(6);
  @$pb.TagNumber(7)
  set status($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasStatus() => $_has(6);
  @$pb.TagNumber(7)
  void clearStatus() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get transactionId => $_getSZ(7);
  @$pb.TagNumber(8)
  set transactionId($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasTransactionId() => $_has(7);
  @$pb.TagNumber(8)
  void clearTransactionId() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get referenceNumber => $_getSZ(8);
  @$pb.TagNumber(9)
  set referenceNumber($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasReferenceNumber() => $_has(8);
  @$pb.TagNumber(9)
  void clearReferenceNumber() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get paymentDate => $_getSZ(9);
  @$pb.TagNumber(10)
  set paymentDate($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasPaymentDate() => $_has(9);
  @$pb.TagNumber(10)
  void clearPaymentDate() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get dueDate => $_getSZ(10);
  @$pb.TagNumber(11)
  set dueDate($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasDueDate() => $_has(10);
  @$pb.TagNumber(11)
  void clearDueDate() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get processedAt => $_getSZ(11);
  @$pb.TagNumber(12)
  set processedAt($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasProcessedAt() => $_has(11);
  @$pb.TagNumber(12)
  void clearProcessedAt() => $_clearField(12);

  @$pb.TagNumber(13)
  $pb.PbMap<$core.String, $core.String> get paymentDetails => $_getMap(12);

  @$pb.TagNumber(14)
  $core.String get failureReason => $_getSZ(13);
  @$pb.TagNumber(14)
  set failureReason($core.String value) => $_setString(13, value);
  @$pb.TagNumber(14)
  $core.bool hasFailureReason() => $_has(13);
  @$pb.TagNumber(14)
  void clearFailureReason() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.String get receiptUrl => $_getSZ(14);
  @$pb.TagNumber(15)
  set receiptUrl($core.String value) => $_setString(14, value);
  @$pb.TagNumber(15)
  $core.bool hasReceiptUrl() => $_has(14);
  @$pb.TagNumber(15)
  void clearReceiptUrl() => $_clearField(15);

  @$pb.TagNumber(16)
  $core.String get userId => $_getSZ(15);
  @$pb.TagNumber(16)
  set userId($core.String value) => $_setString(15, value);
  @$pb.TagNumber(16)
  $core.bool hasUserId() => $_has(15);
  @$pb.TagNumber(16)
  void clearUserId() => $_clearField(16);

  @$pb.TagNumber(17)
  $core.String get createdAt => $_getSZ(16);
  @$pb.TagNumber(17)
  set createdAt($core.String value) => $_setString(16, value);
  @$pb.TagNumber(17)
  $core.bool hasCreatedAt() => $_has(16);
  @$pb.TagNumber(17)
  void clearCreatedAt() => $_clearField(17);

  @$pb.TagNumber(18)
  $core.String get updatedAt => $_getSZ(17);
  @$pb.TagNumber(18)
  set updatedAt($core.String value) => $_setString(17, value);
  @$pb.TagNumber(18)
  $core.bool hasUpdatedAt() => $_has(17);
  @$pb.TagNumber(18)
  void clearUpdatedAt() => $_clearField(18);
}

class InsuranceClaim extends $pb.GeneratedMessage {
  factory InsuranceClaim({
    $core.String? id,
    $core.String? claimNumber,
    $core.String? insuranceId,
    $core.String? policyNumber,
    $core.String? type,
    $core.String? status,
    $core.String? title,
    $core.String? description,
    $core.double? claimAmount,
    $core.double? approvedAmount,
    $core.String? currency,
    $core.String? incidentDate,
    $core.String? incidentLocation,
    $core.Iterable<$core.String>? attachments,
    $core.Iterable<$core.String>? documents,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? additionalInfo,
    $core.String? rejectionReason,
    $core.String? settlementDate,
    $core.String? settlementDetails,
    $core.String? userId,
    $core.String? createdAt,
    $core.String? updatedAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (claimNumber != null) result.claimNumber = claimNumber;
    if (insuranceId != null) result.insuranceId = insuranceId;
    if (policyNumber != null) result.policyNumber = policyNumber;
    if (type != null) result.type = type;
    if (status != null) result.status = status;
    if (title != null) result.title = title;
    if (description != null) result.description = description;
    if (claimAmount != null) result.claimAmount = claimAmount;
    if (approvedAmount != null) result.approvedAmount = approvedAmount;
    if (currency != null) result.currency = currency;
    if (incidentDate != null) result.incidentDate = incidentDate;
    if (incidentLocation != null) result.incidentLocation = incidentLocation;
    if (attachments != null) result.attachments.addAll(attachments);
    if (documents != null) result.documents.addAll(documents);
    if (additionalInfo != null)
      result.additionalInfo.addEntries(additionalInfo);
    if (rejectionReason != null) result.rejectionReason = rejectionReason;
    if (settlementDate != null) result.settlementDate = settlementDate;
    if (settlementDetails != null) result.settlementDetails = settlementDetails;
    if (userId != null) result.userId = userId;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    return result;
  }

  InsuranceClaim._();

  factory InsuranceClaim.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InsuranceClaim.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InsuranceClaim',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'claimNumber')
    ..aOS(3, _omitFieldNames ? '' : 'insuranceId')
    ..aOS(4, _omitFieldNames ? '' : 'policyNumber')
    ..aOS(5, _omitFieldNames ? '' : 'type')
    ..aOS(6, _omitFieldNames ? '' : 'status')
    ..aOS(7, _omitFieldNames ? '' : 'title')
    ..aOS(8, _omitFieldNames ? '' : 'description')
    ..a<$core.double>(
        9, _omitFieldNames ? '' : 'claimAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(
        10, _omitFieldNames ? '' : 'approvedAmount', $pb.PbFieldType.OD)
    ..aOS(11, _omitFieldNames ? '' : 'currency')
    ..aOS(12, _omitFieldNames ? '' : 'incidentDate')
    ..aOS(13, _omitFieldNames ? '' : 'incidentLocation')
    ..pPS(14, _omitFieldNames ? '' : 'attachments')
    ..pPS(15, _omitFieldNames ? '' : 'documents')
    ..m<$core.String, $core.String>(16, _omitFieldNames ? '' : 'additionalInfo',
        entryClassName: 'InsuranceClaim.AdditionalInfoEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('pb'))
    ..aOS(17, _omitFieldNames ? '' : 'rejectionReason')
    ..aOS(18, _omitFieldNames ? '' : 'settlementDate')
    ..aOS(19, _omitFieldNames ? '' : 'settlementDetails')
    ..aOS(20, _omitFieldNames ? '' : 'userId')
    ..aOS(21, _omitFieldNames ? '' : 'createdAt')
    ..aOS(22, _omitFieldNames ? '' : 'updatedAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InsuranceClaim clone() => InsuranceClaim()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InsuranceClaim copyWith(void Function(InsuranceClaim) updates) =>
      super.copyWith((message) => updates(message as InsuranceClaim))
          as InsuranceClaim;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InsuranceClaim create() => InsuranceClaim._();
  @$core.override
  InsuranceClaim createEmptyInstance() => create();
  static $pb.PbList<InsuranceClaim> createRepeated() =>
      $pb.PbList<InsuranceClaim>();
  @$core.pragma('dart2js:noInline')
  static InsuranceClaim getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InsuranceClaim>(create);
  static InsuranceClaim? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get claimNumber => $_getSZ(1);
  @$pb.TagNumber(2)
  set claimNumber($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasClaimNumber() => $_has(1);
  @$pb.TagNumber(2)
  void clearClaimNumber() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get insuranceId => $_getSZ(2);
  @$pb.TagNumber(3)
  set insuranceId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasInsuranceId() => $_has(2);
  @$pb.TagNumber(3)
  void clearInsuranceId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get policyNumber => $_getSZ(3);
  @$pb.TagNumber(4)
  set policyNumber($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPolicyNumber() => $_has(3);
  @$pb.TagNumber(4)
  void clearPolicyNumber() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get type => $_getSZ(4);
  @$pb.TagNumber(5)
  set type($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasType() => $_has(4);
  @$pb.TagNumber(5)
  void clearType() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get status => $_getSZ(5);
  @$pb.TagNumber(6)
  set status($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasStatus() => $_has(5);
  @$pb.TagNumber(6)
  void clearStatus() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get title => $_getSZ(6);
  @$pb.TagNumber(7)
  set title($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasTitle() => $_has(6);
  @$pb.TagNumber(7)
  void clearTitle() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get description => $_getSZ(7);
  @$pb.TagNumber(8)
  set description($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasDescription() => $_has(7);
  @$pb.TagNumber(8)
  void clearDescription() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.double get claimAmount => $_getN(8);
  @$pb.TagNumber(9)
  set claimAmount($core.double value) => $_setDouble(8, value);
  @$pb.TagNumber(9)
  $core.bool hasClaimAmount() => $_has(8);
  @$pb.TagNumber(9)
  void clearClaimAmount() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.double get approvedAmount => $_getN(9);
  @$pb.TagNumber(10)
  set approvedAmount($core.double value) => $_setDouble(9, value);
  @$pb.TagNumber(10)
  $core.bool hasApprovedAmount() => $_has(9);
  @$pb.TagNumber(10)
  void clearApprovedAmount() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get currency => $_getSZ(10);
  @$pb.TagNumber(11)
  set currency($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasCurrency() => $_has(10);
  @$pb.TagNumber(11)
  void clearCurrency() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get incidentDate => $_getSZ(11);
  @$pb.TagNumber(12)
  set incidentDate($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasIncidentDate() => $_has(11);
  @$pb.TagNumber(12)
  void clearIncidentDate() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get incidentLocation => $_getSZ(12);
  @$pb.TagNumber(13)
  set incidentLocation($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasIncidentLocation() => $_has(12);
  @$pb.TagNumber(13)
  void clearIncidentLocation() => $_clearField(13);

  @$pb.TagNumber(14)
  $pb.PbList<$core.String> get attachments => $_getList(13);

  @$pb.TagNumber(15)
  $pb.PbList<$core.String> get documents => $_getList(14);

  @$pb.TagNumber(16)
  $pb.PbMap<$core.String, $core.String> get additionalInfo => $_getMap(15);

  @$pb.TagNumber(17)
  $core.String get rejectionReason => $_getSZ(16);
  @$pb.TagNumber(17)
  set rejectionReason($core.String value) => $_setString(16, value);
  @$pb.TagNumber(17)
  $core.bool hasRejectionReason() => $_has(16);
  @$pb.TagNumber(17)
  void clearRejectionReason() => $_clearField(17);

  @$pb.TagNumber(18)
  $core.String get settlementDate => $_getSZ(17);
  @$pb.TagNumber(18)
  set settlementDate($core.String value) => $_setString(17, value);
  @$pb.TagNumber(18)
  $core.bool hasSettlementDate() => $_has(17);
  @$pb.TagNumber(18)
  void clearSettlementDate() => $_clearField(18);

  @$pb.TagNumber(19)
  $core.String get settlementDetails => $_getSZ(18);
  @$pb.TagNumber(19)
  set settlementDetails($core.String value) => $_setString(18, value);
  @$pb.TagNumber(19)
  $core.bool hasSettlementDetails() => $_has(18);
  @$pb.TagNumber(19)
  void clearSettlementDetails() => $_clearField(19);

  @$pb.TagNumber(20)
  $core.String get userId => $_getSZ(19);
  @$pb.TagNumber(20)
  set userId($core.String value) => $_setString(19, value);
  @$pb.TagNumber(20)
  $core.bool hasUserId() => $_has(19);
  @$pb.TagNumber(20)
  void clearUserId() => $_clearField(20);

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
}

/// MyCover Customer
class MyCoverCustomerInfo extends $pb.GeneratedMessage {
  factory MyCoverCustomerInfo({
    $core.String? id,
    $core.String? firstName,
    $core.String? lastName,
    $core.String? email,
    $core.String? phoneNumber,
    $core.String? gender,
    $core.String? dateOfBirth,
    $core.String? createdAt,
    $core.String? updatedAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (firstName != null) result.firstName = firstName;
    if (lastName != null) result.lastName = lastName;
    if (email != null) result.email = email;
    if (phoneNumber != null) result.phoneNumber = phoneNumber;
    if (gender != null) result.gender = gender;
    if (dateOfBirth != null) result.dateOfBirth = dateOfBirth;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    return result;
  }

  MyCoverCustomerInfo._();

  factory MyCoverCustomerInfo.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MyCoverCustomerInfo.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MyCoverCustomerInfo',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'firstName')
    ..aOS(3, _omitFieldNames ? '' : 'lastName')
    ..aOS(4, _omitFieldNames ? '' : 'email')
    ..aOS(5, _omitFieldNames ? '' : 'phoneNumber')
    ..aOS(6, _omitFieldNames ? '' : 'gender')
    ..aOS(7, _omitFieldNames ? '' : 'dateOfBirth')
    ..aOS(8, _omitFieldNames ? '' : 'createdAt')
    ..aOS(9, _omitFieldNames ? '' : 'updatedAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MyCoverCustomerInfo clone() => MyCoverCustomerInfo()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MyCoverCustomerInfo copyWith(void Function(MyCoverCustomerInfo) updates) =>
      super.copyWith((message) => updates(message as MyCoverCustomerInfo))
          as MyCoverCustomerInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MyCoverCustomerInfo create() => MyCoverCustomerInfo._();
  @$core.override
  MyCoverCustomerInfo createEmptyInstance() => create();
  static $pb.PbList<MyCoverCustomerInfo> createRepeated() =>
      $pb.PbList<MyCoverCustomerInfo>();
  @$core.pragma('dart2js:noInline')
  static MyCoverCustomerInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MyCoverCustomerInfo>(create);
  static MyCoverCustomerInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

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
  $core.String get phoneNumber => $_getSZ(4);
  @$pb.TagNumber(5)
  set phoneNumber($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasPhoneNumber() => $_has(4);
  @$pb.TagNumber(5)
  void clearPhoneNumber() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get gender => $_getSZ(5);
  @$pb.TagNumber(6)
  set gender($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasGender() => $_has(5);
  @$pb.TagNumber(6)
  void clearGender() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get dateOfBirth => $_getSZ(6);
  @$pb.TagNumber(7)
  set dateOfBirth($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasDateOfBirth() => $_has(6);
  @$pb.TagNumber(7)
  void clearDateOfBirth() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get createdAt => $_getSZ(7);
  @$pb.TagNumber(8)
  set createdAt($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasCreatedAt() => $_has(7);
  @$pb.TagNumber(8)
  void clearCreatedAt() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get updatedAt => $_getSZ(8);
  @$pb.TagNumber(9)
  set updatedAt($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasUpdatedAt() => $_has(8);
  @$pb.TagNumber(9)
  void clearUpdatedAt() => $_clearField(9);
}

/// MyCover Purchase
class MyCoverPurchaseInfo extends $pb.GeneratedMessage {
  factory MyCoverPurchaseInfo({
    $core.String? id,
    $core.String? appMode,
    $core.bool? isRenewal,
    $core.String? amount,
    $core.String? customerId,
    $core.String? distributorId,
    $core.String? paymentChannel,
    $core.String? paymentOption,
    $core.String? policyId,
    $core.String? productCategoryId,
    $core.String? productId,
    $core.String? providerId,
    $core.String? countryId,
    $core.String? currencyId,
    $core.String? createdAt,
    $core.String? updatedAt,
    $core.String? customerName,
    $core.String? customerEmail,
    $core.String? customerPhone,
    $core.String? policyNumber,
    $core.String? certificateUrl,
    $core.bool? policyIsActive,
    $core.String? policyAmount,
    $core.String? providerName,
    $core.String? productName,
    $core.String? productCategoryName,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (appMode != null) result.appMode = appMode;
    if (isRenewal != null) result.isRenewal = isRenewal;
    if (amount != null) result.amount = amount;
    if (customerId != null) result.customerId = customerId;
    if (distributorId != null) result.distributorId = distributorId;
    if (paymentChannel != null) result.paymentChannel = paymentChannel;
    if (paymentOption != null) result.paymentOption = paymentOption;
    if (policyId != null) result.policyId = policyId;
    if (productCategoryId != null) result.productCategoryId = productCategoryId;
    if (productId != null) result.productId = productId;
    if (providerId != null) result.providerId = providerId;
    if (countryId != null) result.countryId = countryId;
    if (currencyId != null) result.currencyId = currencyId;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    if (customerName != null) result.customerName = customerName;
    if (customerEmail != null) result.customerEmail = customerEmail;
    if (customerPhone != null) result.customerPhone = customerPhone;
    if (policyNumber != null) result.policyNumber = policyNumber;
    if (certificateUrl != null) result.certificateUrl = certificateUrl;
    if (policyIsActive != null) result.policyIsActive = policyIsActive;
    if (policyAmount != null) result.policyAmount = policyAmount;
    if (providerName != null) result.providerName = providerName;
    if (productName != null) result.productName = productName;
    if (productCategoryName != null)
      result.productCategoryName = productCategoryName;
    return result;
  }

  MyCoverPurchaseInfo._();

  factory MyCoverPurchaseInfo.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MyCoverPurchaseInfo.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MyCoverPurchaseInfo',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'appMode')
    ..aOB(3, _omitFieldNames ? '' : 'isRenewal')
    ..aOS(4, _omitFieldNames ? '' : 'amount')
    ..aOS(5, _omitFieldNames ? '' : 'customerId')
    ..aOS(6, _omitFieldNames ? '' : 'distributorId')
    ..aOS(7, _omitFieldNames ? '' : 'paymentChannel')
    ..aOS(8, _omitFieldNames ? '' : 'paymentOption')
    ..aOS(9, _omitFieldNames ? '' : 'policyId')
    ..aOS(10, _omitFieldNames ? '' : 'productCategoryId')
    ..aOS(11, _omitFieldNames ? '' : 'productId')
    ..aOS(12, _omitFieldNames ? '' : 'providerId')
    ..aOS(13, _omitFieldNames ? '' : 'countryId')
    ..aOS(14, _omitFieldNames ? '' : 'currencyId')
    ..aOS(15, _omitFieldNames ? '' : 'createdAt')
    ..aOS(16, _omitFieldNames ? '' : 'updatedAt')
    ..aOS(17, _omitFieldNames ? '' : 'customerName')
    ..aOS(18, _omitFieldNames ? '' : 'customerEmail')
    ..aOS(19, _omitFieldNames ? '' : 'customerPhone')
    ..aOS(20, _omitFieldNames ? '' : 'policyNumber')
    ..aOS(21, _omitFieldNames ? '' : 'certificateUrl')
    ..aOB(22, _omitFieldNames ? '' : 'policyIsActive')
    ..aOS(23, _omitFieldNames ? '' : 'policyAmount')
    ..aOS(24, _omitFieldNames ? '' : 'providerName')
    ..aOS(25, _omitFieldNames ? '' : 'productName')
    ..aOS(26, _omitFieldNames ? '' : 'productCategoryName')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MyCoverPurchaseInfo clone() => MyCoverPurchaseInfo()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MyCoverPurchaseInfo copyWith(void Function(MyCoverPurchaseInfo) updates) =>
      super.copyWith((message) => updates(message as MyCoverPurchaseInfo))
          as MyCoverPurchaseInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MyCoverPurchaseInfo create() => MyCoverPurchaseInfo._();
  @$core.override
  MyCoverPurchaseInfo createEmptyInstance() => create();
  static $pb.PbList<MyCoverPurchaseInfo> createRepeated() =>
      $pb.PbList<MyCoverPurchaseInfo>();
  @$core.pragma('dart2js:noInline')
  static MyCoverPurchaseInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MyCoverPurchaseInfo>(create);
  static MyCoverPurchaseInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get appMode => $_getSZ(1);
  @$pb.TagNumber(2)
  set appMode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAppMode() => $_has(1);
  @$pb.TagNumber(2)
  void clearAppMode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get isRenewal => $_getBF(2);
  @$pb.TagNumber(3)
  set isRenewal($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasIsRenewal() => $_has(2);
  @$pb.TagNumber(3)
  void clearIsRenewal() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get amount => $_getSZ(3);
  @$pb.TagNumber(4)
  set amount($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearAmount() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get customerId => $_getSZ(4);
  @$pb.TagNumber(5)
  set customerId($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCustomerId() => $_has(4);
  @$pb.TagNumber(5)
  void clearCustomerId() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get distributorId => $_getSZ(5);
  @$pb.TagNumber(6)
  set distributorId($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasDistributorId() => $_has(5);
  @$pb.TagNumber(6)
  void clearDistributorId() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get paymentChannel => $_getSZ(6);
  @$pb.TagNumber(7)
  set paymentChannel($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasPaymentChannel() => $_has(6);
  @$pb.TagNumber(7)
  void clearPaymentChannel() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get paymentOption => $_getSZ(7);
  @$pb.TagNumber(8)
  set paymentOption($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasPaymentOption() => $_has(7);
  @$pb.TagNumber(8)
  void clearPaymentOption() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get policyId => $_getSZ(8);
  @$pb.TagNumber(9)
  set policyId($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasPolicyId() => $_has(8);
  @$pb.TagNumber(9)
  void clearPolicyId() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get productCategoryId => $_getSZ(9);
  @$pb.TagNumber(10)
  set productCategoryId($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasProductCategoryId() => $_has(9);
  @$pb.TagNumber(10)
  void clearProductCategoryId() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get productId => $_getSZ(10);
  @$pb.TagNumber(11)
  set productId($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasProductId() => $_has(10);
  @$pb.TagNumber(11)
  void clearProductId() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get providerId => $_getSZ(11);
  @$pb.TagNumber(12)
  set providerId($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasProviderId() => $_has(11);
  @$pb.TagNumber(12)
  void clearProviderId() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get countryId => $_getSZ(12);
  @$pb.TagNumber(13)
  set countryId($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasCountryId() => $_has(12);
  @$pb.TagNumber(13)
  void clearCountryId() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.String get currencyId => $_getSZ(13);
  @$pb.TagNumber(14)
  set currencyId($core.String value) => $_setString(13, value);
  @$pb.TagNumber(14)
  $core.bool hasCurrencyId() => $_has(13);
  @$pb.TagNumber(14)
  void clearCurrencyId() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.String get createdAt => $_getSZ(14);
  @$pb.TagNumber(15)
  set createdAt($core.String value) => $_setString(14, value);
  @$pb.TagNumber(15)
  $core.bool hasCreatedAt() => $_has(14);
  @$pb.TagNumber(15)
  void clearCreatedAt() => $_clearField(15);

  @$pb.TagNumber(16)
  $core.String get updatedAt => $_getSZ(15);
  @$pb.TagNumber(16)
  set updatedAt($core.String value) => $_setString(15, value);
  @$pb.TagNumber(16)
  $core.bool hasUpdatedAt() => $_has(15);
  @$pb.TagNumber(16)
  void clearUpdatedAt() => $_clearField(16);

  @$pb.TagNumber(17)
  $core.String get customerName => $_getSZ(16);
  @$pb.TagNumber(17)
  set customerName($core.String value) => $_setString(16, value);
  @$pb.TagNumber(17)
  $core.bool hasCustomerName() => $_has(16);
  @$pb.TagNumber(17)
  void clearCustomerName() => $_clearField(17);

  @$pb.TagNumber(18)
  $core.String get customerEmail => $_getSZ(17);
  @$pb.TagNumber(18)
  set customerEmail($core.String value) => $_setString(17, value);
  @$pb.TagNumber(18)
  $core.bool hasCustomerEmail() => $_has(17);
  @$pb.TagNumber(18)
  void clearCustomerEmail() => $_clearField(18);

  @$pb.TagNumber(19)
  $core.String get customerPhone => $_getSZ(18);
  @$pb.TagNumber(19)
  set customerPhone($core.String value) => $_setString(18, value);
  @$pb.TagNumber(19)
  $core.bool hasCustomerPhone() => $_has(18);
  @$pb.TagNumber(19)
  void clearCustomerPhone() => $_clearField(19);

  @$pb.TagNumber(20)
  $core.String get policyNumber => $_getSZ(19);
  @$pb.TagNumber(20)
  set policyNumber($core.String value) => $_setString(19, value);
  @$pb.TagNumber(20)
  $core.bool hasPolicyNumber() => $_has(19);
  @$pb.TagNumber(20)
  void clearPolicyNumber() => $_clearField(20);

  @$pb.TagNumber(21)
  $core.String get certificateUrl => $_getSZ(20);
  @$pb.TagNumber(21)
  set certificateUrl($core.String value) => $_setString(20, value);
  @$pb.TagNumber(21)
  $core.bool hasCertificateUrl() => $_has(20);
  @$pb.TagNumber(21)
  void clearCertificateUrl() => $_clearField(21);

  @$pb.TagNumber(22)
  $core.bool get policyIsActive => $_getBF(21);
  @$pb.TagNumber(22)
  set policyIsActive($core.bool value) => $_setBool(21, value);
  @$pb.TagNumber(22)
  $core.bool hasPolicyIsActive() => $_has(21);
  @$pb.TagNumber(22)
  void clearPolicyIsActive() => $_clearField(22);

  @$pb.TagNumber(23)
  $core.String get policyAmount => $_getSZ(22);
  @$pb.TagNumber(23)
  set policyAmount($core.String value) => $_setString(22, value);
  @$pb.TagNumber(23)
  $core.bool hasPolicyAmount() => $_has(22);
  @$pb.TagNumber(23)
  void clearPolicyAmount() => $_clearField(23);

  @$pb.TagNumber(24)
  $core.String get providerName => $_getSZ(23);
  @$pb.TagNumber(24)
  set providerName($core.String value) => $_setString(23, value);
  @$pb.TagNumber(24)
  $core.bool hasProviderName() => $_has(23);
  @$pb.TagNumber(24)
  void clearProviderName() => $_clearField(24);

  @$pb.TagNumber(25)
  $core.String get productName => $_getSZ(24);
  @$pb.TagNumber(25)
  set productName($core.String value) => $_setString(24, value);
  @$pb.TagNumber(25)
  $core.bool hasProductName() => $_has(24);
  @$pb.TagNumber(25)
  void clearProductName() => $_clearField(25);

  @$pb.TagNumber(26)
  $core.String get productCategoryName => $_getSZ(25);
  @$pb.TagNumber(26)
  set productCategoryName($core.String value) => $_setString(25, value);
  @$pb.TagNumber(26)
  $core.bool hasProductCategoryName() => $_has(25);
  @$pb.TagNumber(26)
  void clearProductCategoryName() => $_clearField(26);
}

/// MyCover Policy Detail
class MyCoverPolicyDetailInfo extends $pb.GeneratedMessage {
  factory MyCoverPolicyDetailInfo({
    $core.String? id,
    $core.String? appMode,
    $core.String? firstName,
    $core.String? lastName,
    $core.String? email,
    $core.String? phoneNumber,
    $core.String? dateOfBirth,
    $core.String? activationDate,
    $core.String? startDate,
    $core.String? expirationDate,
    $core.String? amount,
    $core.bool? isActive,
    $core.bool? isSubmittedToProvider,
    $core.String? customerId,
    $core.String? productId,
    $core.String? productCategoryId,
    $core.String? providerId,
    $core.String? purchaseId,
    $core.String? policyNumber,
    $core.String? certificateUrl,
    $core.String? createdAt,
    $core.String? updatedAt,
    $core.String? providerName,
    $core.String? productName,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (appMode != null) result.appMode = appMode;
    if (firstName != null) result.firstName = firstName;
    if (lastName != null) result.lastName = lastName;
    if (email != null) result.email = email;
    if (phoneNumber != null) result.phoneNumber = phoneNumber;
    if (dateOfBirth != null) result.dateOfBirth = dateOfBirth;
    if (activationDate != null) result.activationDate = activationDate;
    if (startDate != null) result.startDate = startDate;
    if (expirationDate != null) result.expirationDate = expirationDate;
    if (amount != null) result.amount = amount;
    if (isActive != null) result.isActive = isActive;
    if (isSubmittedToProvider != null)
      result.isSubmittedToProvider = isSubmittedToProvider;
    if (customerId != null) result.customerId = customerId;
    if (productId != null) result.productId = productId;
    if (productCategoryId != null) result.productCategoryId = productCategoryId;
    if (providerId != null) result.providerId = providerId;
    if (purchaseId != null) result.purchaseId = purchaseId;
    if (policyNumber != null) result.policyNumber = policyNumber;
    if (certificateUrl != null) result.certificateUrl = certificateUrl;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    if (providerName != null) result.providerName = providerName;
    if (productName != null) result.productName = productName;
    return result;
  }

  MyCoverPolicyDetailInfo._();

  factory MyCoverPolicyDetailInfo.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MyCoverPolicyDetailInfo.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MyCoverPolicyDetailInfo',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'appMode')
    ..aOS(3, _omitFieldNames ? '' : 'firstName')
    ..aOS(4, _omitFieldNames ? '' : 'lastName')
    ..aOS(5, _omitFieldNames ? '' : 'email')
    ..aOS(6, _omitFieldNames ? '' : 'phoneNumber')
    ..aOS(7, _omitFieldNames ? '' : 'dateOfBirth')
    ..aOS(8, _omitFieldNames ? '' : 'activationDate')
    ..aOS(9, _omitFieldNames ? '' : 'startDate')
    ..aOS(10, _omitFieldNames ? '' : 'expirationDate')
    ..aOS(11, _omitFieldNames ? '' : 'amount')
    ..aOB(12, _omitFieldNames ? '' : 'isActive')
    ..aOB(13, _omitFieldNames ? '' : 'isSubmittedToProvider')
    ..aOS(14, _omitFieldNames ? '' : 'customerId')
    ..aOS(15, _omitFieldNames ? '' : 'productId')
    ..aOS(16, _omitFieldNames ? '' : 'productCategoryId')
    ..aOS(17, _omitFieldNames ? '' : 'providerId')
    ..aOS(18, _omitFieldNames ? '' : 'purchaseId')
    ..aOS(19, _omitFieldNames ? '' : 'policyNumber')
    ..aOS(20, _omitFieldNames ? '' : 'certificateUrl')
    ..aOS(21, _omitFieldNames ? '' : 'createdAt')
    ..aOS(22, _omitFieldNames ? '' : 'updatedAt')
    ..aOS(23, _omitFieldNames ? '' : 'providerName')
    ..aOS(24, _omitFieldNames ? '' : 'productName')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MyCoverPolicyDetailInfo clone() =>
      MyCoverPolicyDetailInfo()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MyCoverPolicyDetailInfo copyWith(
          void Function(MyCoverPolicyDetailInfo) updates) =>
      super.copyWith((message) => updates(message as MyCoverPolicyDetailInfo))
          as MyCoverPolicyDetailInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MyCoverPolicyDetailInfo create() => MyCoverPolicyDetailInfo._();
  @$core.override
  MyCoverPolicyDetailInfo createEmptyInstance() => create();
  static $pb.PbList<MyCoverPolicyDetailInfo> createRepeated() =>
      $pb.PbList<MyCoverPolicyDetailInfo>();
  @$core.pragma('dart2js:noInline')
  static MyCoverPolicyDetailInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MyCoverPolicyDetailInfo>(create);
  static MyCoverPolicyDetailInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get appMode => $_getSZ(1);
  @$pb.TagNumber(2)
  set appMode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAppMode() => $_has(1);
  @$pb.TagNumber(2)
  void clearAppMode() => $_clearField(2);

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
  $core.String get email => $_getSZ(4);
  @$pb.TagNumber(5)
  set email($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasEmail() => $_has(4);
  @$pb.TagNumber(5)
  void clearEmail() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get phoneNumber => $_getSZ(5);
  @$pb.TagNumber(6)
  set phoneNumber($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasPhoneNumber() => $_has(5);
  @$pb.TagNumber(6)
  void clearPhoneNumber() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get dateOfBirth => $_getSZ(6);
  @$pb.TagNumber(7)
  set dateOfBirth($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasDateOfBirth() => $_has(6);
  @$pb.TagNumber(7)
  void clearDateOfBirth() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get activationDate => $_getSZ(7);
  @$pb.TagNumber(8)
  set activationDate($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasActivationDate() => $_has(7);
  @$pb.TagNumber(8)
  void clearActivationDate() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get startDate => $_getSZ(8);
  @$pb.TagNumber(9)
  set startDate($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasStartDate() => $_has(8);
  @$pb.TagNumber(9)
  void clearStartDate() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get expirationDate => $_getSZ(9);
  @$pb.TagNumber(10)
  set expirationDate($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasExpirationDate() => $_has(9);
  @$pb.TagNumber(10)
  void clearExpirationDate() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get amount => $_getSZ(10);
  @$pb.TagNumber(11)
  set amount($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasAmount() => $_has(10);
  @$pb.TagNumber(11)
  void clearAmount() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.bool get isActive => $_getBF(11);
  @$pb.TagNumber(12)
  set isActive($core.bool value) => $_setBool(11, value);
  @$pb.TagNumber(12)
  $core.bool hasIsActive() => $_has(11);
  @$pb.TagNumber(12)
  void clearIsActive() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.bool get isSubmittedToProvider => $_getBF(12);
  @$pb.TagNumber(13)
  set isSubmittedToProvider($core.bool value) => $_setBool(12, value);
  @$pb.TagNumber(13)
  $core.bool hasIsSubmittedToProvider() => $_has(12);
  @$pb.TagNumber(13)
  void clearIsSubmittedToProvider() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.String get customerId => $_getSZ(13);
  @$pb.TagNumber(14)
  set customerId($core.String value) => $_setString(13, value);
  @$pb.TagNumber(14)
  $core.bool hasCustomerId() => $_has(13);
  @$pb.TagNumber(14)
  void clearCustomerId() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.String get productId => $_getSZ(14);
  @$pb.TagNumber(15)
  set productId($core.String value) => $_setString(14, value);
  @$pb.TagNumber(15)
  $core.bool hasProductId() => $_has(14);
  @$pb.TagNumber(15)
  void clearProductId() => $_clearField(15);

  @$pb.TagNumber(16)
  $core.String get productCategoryId => $_getSZ(15);
  @$pb.TagNumber(16)
  set productCategoryId($core.String value) => $_setString(15, value);
  @$pb.TagNumber(16)
  $core.bool hasProductCategoryId() => $_has(15);
  @$pb.TagNumber(16)
  void clearProductCategoryId() => $_clearField(16);

  @$pb.TagNumber(17)
  $core.String get providerId => $_getSZ(16);
  @$pb.TagNumber(17)
  set providerId($core.String value) => $_setString(16, value);
  @$pb.TagNumber(17)
  $core.bool hasProviderId() => $_has(16);
  @$pb.TagNumber(17)
  void clearProviderId() => $_clearField(17);

  @$pb.TagNumber(18)
  $core.String get purchaseId => $_getSZ(17);
  @$pb.TagNumber(18)
  set purchaseId($core.String value) => $_setString(17, value);
  @$pb.TagNumber(18)
  $core.bool hasPurchaseId() => $_has(17);
  @$pb.TagNumber(18)
  void clearPurchaseId() => $_clearField(18);

  @$pb.TagNumber(19)
  $core.String get policyNumber => $_getSZ(18);
  @$pb.TagNumber(19)
  set policyNumber($core.String value) => $_setString(18, value);
  @$pb.TagNumber(19)
  $core.bool hasPolicyNumber() => $_has(18);
  @$pb.TagNumber(19)
  void clearPolicyNumber() => $_clearField(19);

  @$pb.TagNumber(20)
  $core.String get certificateUrl => $_getSZ(19);
  @$pb.TagNumber(20)
  set certificateUrl($core.String value) => $_setString(19, value);
  @$pb.TagNumber(20)
  $core.bool hasCertificateUrl() => $_has(19);
  @$pb.TagNumber(20)
  void clearCertificateUrl() => $_clearField(20);

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
  $core.String get providerName => $_getSZ(22);
  @$pb.TagNumber(23)
  set providerName($core.String value) => $_setString(22, value);
  @$pb.TagNumber(23)
  $core.bool hasProviderName() => $_has(22);
  @$pb.TagNumber(23)
  void clearProviderName() => $_clearField(23);

  @$pb.TagNumber(24)
  $core.String get productName => $_getSZ(23);
  @$pb.TagNumber(24)
  set productName($core.String value) => $_setString(23, value);
  @$pb.TagNumber(24)
  $core.bool hasProductName() => $_has(23);
  @$pb.TagNumber(24)
  void clearProductName() => $_clearField(24);
}

/// MyCover Claim
class MyCoverClaimInfo extends $pb.GeneratedMessage {
  factory MyCoverClaimInfo({
    $core.String? id,
    $core.String? status,
    $core.String? type,
    $core.double? amount,
    $core.String? description,
    $core.String? policyId,
    $core.String? customerId,
    $core.String? claimNumber,
    $core.Iterable<$core.String>? documents,
    $core.String? rejectionReason,
    $core.double? approvedAmount,
    $core.String? createdAt,
    $core.String? updatedAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (status != null) result.status = status;
    if (type != null) result.type = type;
    if (amount != null) result.amount = amount;
    if (description != null) result.description = description;
    if (policyId != null) result.policyId = policyId;
    if (customerId != null) result.customerId = customerId;
    if (claimNumber != null) result.claimNumber = claimNumber;
    if (documents != null) result.documents.addAll(documents);
    if (rejectionReason != null) result.rejectionReason = rejectionReason;
    if (approvedAmount != null) result.approvedAmount = approvedAmount;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    return result;
  }

  MyCoverClaimInfo._();

  factory MyCoverClaimInfo.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MyCoverClaimInfo.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MyCoverClaimInfo',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'status')
    ..aOS(3, _omitFieldNames ? '' : 'type')
    ..a<$core.double>(4, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(5, _omitFieldNames ? '' : 'description')
    ..aOS(6, _omitFieldNames ? '' : 'policyId')
    ..aOS(7, _omitFieldNames ? '' : 'customerId')
    ..aOS(8, _omitFieldNames ? '' : 'claimNumber')
    ..pPS(9, _omitFieldNames ? '' : 'documents')
    ..aOS(10, _omitFieldNames ? '' : 'rejectionReason')
    ..a<$core.double>(
        11, _omitFieldNames ? '' : 'approvedAmount', $pb.PbFieldType.OD)
    ..aOS(12, _omitFieldNames ? '' : 'createdAt')
    ..aOS(13, _omitFieldNames ? '' : 'updatedAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MyCoverClaimInfo clone() => MyCoverClaimInfo()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MyCoverClaimInfo copyWith(void Function(MyCoverClaimInfo) updates) =>
      super.copyWith((message) => updates(message as MyCoverClaimInfo))
          as MyCoverClaimInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MyCoverClaimInfo create() => MyCoverClaimInfo._();
  @$core.override
  MyCoverClaimInfo createEmptyInstance() => create();
  static $pb.PbList<MyCoverClaimInfo> createRepeated() =>
      $pb.PbList<MyCoverClaimInfo>();
  @$core.pragma('dart2js:noInline')
  static MyCoverClaimInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MyCoverClaimInfo>(create);
  static MyCoverClaimInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get status => $_getSZ(1);
  @$pb.TagNumber(2)
  set status($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get type => $_getSZ(2);
  @$pb.TagNumber(3)
  set type($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasType() => $_has(2);
  @$pb.TagNumber(3)
  void clearType() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get amount => $_getN(3);
  @$pb.TagNumber(4)
  set amount($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearAmount() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get description => $_getSZ(4);
  @$pb.TagNumber(5)
  set description($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasDescription() => $_has(4);
  @$pb.TagNumber(5)
  void clearDescription() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get policyId => $_getSZ(5);
  @$pb.TagNumber(6)
  set policyId($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasPolicyId() => $_has(5);
  @$pb.TagNumber(6)
  void clearPolicyId() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get customerId => $_getSZ(6);
  @$pb.TagNumber(7)
  set customerId($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasCustomerId() => $_has(6);
  @$pb.TagNumber(7)
  void clearCustomerId() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get claimNumber => $_getSZ(7);
  @$pb.TagNumber(8)
  set claimNumber($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasClaimNumber() => $_has(7);
  @$pb.TagNumber(8)
  void clearClaimNumber() => $_clearField(8);

  @$pb.TagNumber(9)
  $pb.PbList<$core.String> get documents => $_getList(8);

  @$pb.TagNumber(10)
  $core.String get rejectionReason => $_getSZ(9);
  @$pb.TagNumber(10)
  set rejectionReason($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasRejectionReason() => $_has(9);
  @$pb.TagNumber(10)
  void clearRejectionReason() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.double get approvedAmount => $_getN(10);
  @$pb.TagNumber(11)
  set approvedAmount($core.double value) => $_setDouble(10, value);
  @$pb.TagNumber(11)
  $core.bool hasApprovedAmount() => $_has(10);
  @$pb.TagNumber(11)
  void clearApprovedAmount() => $_clearField(11);

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
}

/// Customers
class GetMyCoverCustomersRequest extends $pb.GeneratedMessage {
  factory GetMyCoverCustomersRequest({
    $core.int? page,
    $core.int? limit,
  }) {
    final result = create();
    if (page != null) result.page = page;
    if (limit != null) result.limit = limit;
    return result;
  }

  GetMyCoverCustomersRequest._();

  factory GetMyCoverCustomersRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMyCoverCustomersRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMyCoverCustomersRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyCoverCustomersRequest clone() =>
      GetMyCoverCustomersRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyCoverCustomersRequest copyWith(
          void Function(GetMyCoverCustomersRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetMyCoverCustomersRequest))
          as GetMyCoverCustomersRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMyCoverCustomersRequest create() => GetMyCoverCustomersRequest._();
  @$core.override
  GetMyCoverCustomersRequest createEmptyInstance() => create();
  static $pb.PbList<GetMyCoverCustomersRequest> createRepeated() =>
      $pb.PbList<GetMyCoverCustomersRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMyCoverCustomersRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMyCoverCustomersRequest>(create);
  static GetMyCoverCustomersRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get page => $_getIZ(0);
  @$pb.TagNumber(1)
  set page($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearPage() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get limit => $_getIZ(1);
  @$pb.TagNumber(2)
  set limit($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => $_clearField(2);
}

class GetMyCoverCustomersResponse extends $pb.GeneratedMessage {
  factory GetMyCoverCustomersResponse({
    $core.Iterable<MyCoverCustomerInfo>? customers,
    $core.int? total,
    $core.bool? success,
    $core.String? msg,
  }) {
    final result = create();
    if (customers != null) result.customers.addAll(customers);
    if (total != null) result.total = total;
    if (success != null) result.success = success;
    if (msg != null) result.msg = msg;
    return result;
  }

  GetMyCoverCustomersResponse._();

  factory GetMyCoverCustomersResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMyCoverCustomersResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMyCoverCustomersResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<MyCoverCustomerInfo>(
        1, _omitFieldNames ? '' : 'customers', $pb.PbFieldType.PM,
        subBuilder: MyCoverCustomerInfo.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..aOB(3, _omitFieldNames ? '' : 'success')
    ..aOS(4, _omitFieldNames ? '' : 'msg')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyCoverCustomersResponse clone() =>
      GetMyCoverCustomersResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyCoverCustomersResponse copyWith(
          void Function(GetMyCoverCustomersResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetMyCoverCustomersResponse))
          as GetMyCoverCustomersResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMyCoverCustomersResponse create() =>
      GetMyCoverCustomersResponse._();
  @$core.override
  GetMyCoverCustomersResponse createEmptyInstance() => create();
  static $pb.PbList<GetMyCoverCustomersResponse> createRepeated() =>
      $pb.PbList<GetMyCoverCustomersResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMyCoverCustomersResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMyCoverCustomersResponse>(create);
  static GetMyCoverCustomersResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<MyCoverCustomerInfo> get customers => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get success => $_getBF(2);
  @$pb.TagNumber(3)
  set success($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSuccess() => $_has(2);
  @$pb.TagNumber(3)
  void clearSuccess() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get msg => $_getSZ(3);
  @$pb.TagNumber(4)
  set msg($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMsg() => $_has(3);
  @$pb.TagNumber(4)
  void clearMsg() => $_clearField(4);
}

class GetMyCoverCustomerByIdRequest extends $pb.GeneratedMessage {
  factory GetMyCoverCustomerByIdRequest({
    $core.String? customerId,
  }) {
    final result = create();
    if (customerId != null) result.customerId = customerId;
    return result;
  }

  GetMyCoverCustomerByIdRequest._();

  factory GetMyCoverCustomerByIdRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMyCoverCustomerByIdRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMyCoverCustomerByIdRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'customerId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyCoverCustomerByIdRequest clone() =>
      GetMyCoverCustomerByIdRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyCoverCustomerByIdRequest copyWith(
          void Function(GetMyCoverCustomerByIdRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetMyCoverCustomerByIdRequest))
          as GetMyCoverCustomerByIdRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMyCoverCustomerByIdRequest create() =>
      GetMyCoverCustomerByIdRequest._();
  @$core.override
  GetMyCoverCustomerByIdRequest createEmptyInstance() => create();
  static $pb.PbList<GetMyCoverCustomerByIdRequest> createRepeated() =>
      $pb.PbList<GetMyCoverCustomerByIdRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMyCoverCustomerByIdRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMyCoverCustomerByIdRequest>(create);
  static GetMyCoverCustomerByIdRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get customerId => $_getSZ(0);
  @$pb.TagNumber(1)
  set customerId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCustomerId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCustomerId() => $_clearField(1);
}

class GetMyCoverCustomerByIdResponse extends $pb.GeneratedMessage {
  factory GetMyCoverCustomerByIdResponse({
    MyCoverCustomerInfo? customer,
    $core.bool? success,
    $core.String? msg,
  }) {
    final result = create();
    if (customer != null) result.customer = customer;
    if (success != null) result.success = success;
    if (msg != null) result.msg = msg;
    return result;
  }

  GetMyCoverCustomerByIdResponse._();

  factory GetMyCoverCustomerByIdResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMyCoverCustomerByIdResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMyCoverCustomerByIdResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<MyCoverCustomerInfo>(1, _omitFieldNames ? '' : 'customer',
        subBuilder: MyCoverCustomerInfo.create)
    ..aOB(2, _omitFieldNames ? '' : 'success')
    ..aOS(3, _omitFieldNames ? '' : 'msg')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyCoverCustomerByIdResponse clone() =>
      GetMyCoverCustomerByIdResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyCoverCustomerByIdResponse copyWith(
          void Function(GetMyCoverCustomerByIdResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetMyCoverCustomerByIdResponse))
          as GetMyCoverCustomerByIdResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMyCoverCustomerByIdResponse create() =>
      GetMyCoverCustomerByIdResponse._();
  @$core.override
  GetMyCoverCustomerByIdResponse createEmptyInstance() => create();
  static $pb.PbList<GetMyCoverCustomerByIdResponse> createRepeated() =>
      $pb.PbList<GetMyCoverCustomerByIdResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMyCoverCustomerByIdResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMyCoverCustomerByIdResponse>(create);
  static GetMyCoverCustomerByIdResponse? _defaultInstance;

  @$pb.TagNumber(1)
  MyCoverCustomerInfo get customer => $_getN(0);
  @$pb.TagNumber(1)
  set customer(MyCoverCustomerInfo value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasCustomer() => $_has(0);
  @$pb.TagNumber(1)
  void clearCustomer() => $_clearField(1);
  @$pb.TagNumber(1)
  MyCoverCustomerInfo ensureCustomer() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get msg => $_getSZ(2);
  @$pb.TagNumber(3)
  set msg($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMsg() => $_has(2);
  @$pb.TagNumber(3)
  void clearMsg() => $_clearField(3);
}

class GetMyCoverCustomerPoliciesRequest extends $pb.GeneratedMessage {
  factory GetMyCoverCustomerPoliciesRequest({
    $core.String? customerId,
    $core.int? page,
    $core.int? limit,
  }) {
    final result = create();
    if (customerId != null) result.customerId = customerId;
    if (page != null) result.page = page;
    if (limit != null) result.limit = limit;
    return result;
  }

  GetMyCoverCustomerPoliciesRequest._();

  factory GetMyCoverCustomerPoliciesRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMyCoverCustomerPoliciesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMyCoverCustomerPoliciesRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'customerId')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyCoverCustomerPoliciesRequest clone() =>
      GetMyCoverCustomerPoliciesRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyCoverCustomerPoliciesRequest copyWith(
          void Function(GetMyCoverCustomerPoliciesRequest) updates) =>
      super.copyWith((message) =>
              updates(message as GetMyCoverCustomerPoliciesRequest))
          as GetMyCoverCustomerPoliciesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMyCoverCustomerPoliciesRequest create() =>
      GetMyCoverCustomerPoliciesRequest._();
  @$core.override
  GetMyCoverCustomerPoliciesRequest createEmptyInstance() => create();
  static $pb.PbList<GetMyCoverCustomerPoliciesRequest> createRepeated() =>
      $pb.PbList<GetMyCoverCustomerPoliciesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMyCoverCustomerPoliciesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMyCoverCustomerPoliciesRequest>(
          create);
  static GetMyCoverCustomerPoliciesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get customerId => $_getSZ(0);
  @$pb.TagNumber(1)
  set customerId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCustomerId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCustomerId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get page => $_getIZ(1);
  @$pb.TagNumber(2)
  set page($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPage() => $_has(1);
  @$pb.TagNumber(2)
  void clearPage() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get limit => $_getIZ(2);
  @$pb.TagNumber(3)
  set limit($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLimit() => $_has(2);
  @$pb.TagNumber(3)
  void clearLimit() => $_clearField(3);
}

class GetMyCoverCustomerPoliciesResponse extends $pb.GeneratedMessage {
  factory GetMyCoverCustomerPoliciesResponse({
    $core.Iterable<MyCoverPolicyDetailInfo>? policies,
    $core.int? total,
    $core.bool? success,
    $core.String? msg,
  }) {
    final result = create();
    if (policies != null) result.policies.addAll(policies);
    if (total != null) result.total = total;
    if (success != null) result.success = success;
    if (msg != null) result.msg = msg;
    return result;
  }

  GetMyCoverCustomerPoliciesResponse._();

  factory GetMyCoverCustomerPoliciesResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMyCoverCustomerPoliciesResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMyCoverCustomerPoliciesResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<MyCoverPolicyDetailInfo>(
        1, _omitFieldNames ? '' : 'policies', $pb.PbFieldType.PM,
        subBuilder: MyCoverPolicyDetailInfo.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..aOB(3, _omitFieldNames ? '' : 'success')
    ..aOS(4, _omitFieldNames ? '' : 'msg')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyCoverCustomerPoliciesResponse clone() =>
      GetMyCoverCustomerPoliciesResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyCoverCustomerPoliciesResponse copyWith(
          void Function(GetMyCoverCustomerPoliciesResponse) updates) =>
      super.copyWith((message) =>
              updates(message as GetMyCoverCustomerPoliciesResponse))
          as GetMyCoverCustomerPoliciesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMyCoverCustomerPoliciesResponse create() =>
      GetMyCoverCustomerPoliciesResponse._();
  @$core.override
  GetMyCoverCustomerPoliciesResponse createEmptyInstance() => create();
  static $pb.PbList<GetMyCoverCustomerPoliciesResponse> createRepeated() =>
      $pb.PbList<GetMyCoverCustomerPoliciesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMyCoverCustomerPoliciesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMyCoverCustomerPoliciesResponse>(
          create);
  static GetMyCoverCustomerPoliciesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<MyCoverPolicyDetailInfo> get policies => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get success => $_getBF(2);
  @$pb.TagNumber(3)
  set success($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSuccess() => $_has(2);
  @$pb.TagNumber(3)
  void clearSuccess() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get msg => $_getSZ(3);
  @$pb.TagNumber(4)
  set msg($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMsg() => $_has(3);
  @$pb.TagNumber(4)
  void clearMsg() => $_clearField(4);
}

class GetMyCoverCustomerPurchasesRequest extends $pb.GeneratedMessage {
  factory GetMyCoverCustomerPurchasesRequest({
    $core.String? customerId,
    $core.int? page,
    $core.int? limit,
  }) {
    final result = create();
    if (customerId != null) result.customerId = customerId;
    if (page != null) result.page = page;
    if (limit != null) result.limit = limit;
    return result;
  }

  GetMyCoverCustomerPurchasesRequest._();

  factory GetMyCoverCustomerPurchasesRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMyCoverCustomerPurchasesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMyCoverCustomerPurchasesRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'customerId')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyCoverCustomerPurchasesRequest clone() =>
      GetMyCoverCustomerPurchasesRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyCoverCustomerPurchasesRequest copyWith(
          void Function(GetMyCoverCustomerPurchasesRequest) updates) =>
      super.copyWith((message) =>
              updates(message as GetMyCoverCustomerPurchasesRequest))
          as GetMyCoverCustomerPurchasesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMyCoverCustomerPurchasesRequest create() =>
      GetMyCoverCustomerPurchasesRequest._();
  @$core.override
  GetMyCoverCustomerPurchasesRequest createEmptyInstance() => create();
  static $pb.PbList<GetMyCoverCustomerPurchasesRequest> createRepeated() =>
      $pb.PbList<GetMyCoverCustomerPurchasesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMyCoverCustomerPurchasesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMyCoverCustomerPurchasesRequest>(
          create);
  static GetMyCoverCustomerPurchasesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get customerId => $_getSZ(0);
  @$pb.TagNumber(1)
  set customerId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCustomerId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCustomerId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get page => $_getIZ(1);
  @$pb.TagNumber(2)
  set page($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPage() => $_has(1);
  @$pb.TagNumber(2)
  void clearPage() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get limit => $_getIZ(2);
  @$pb.TagNumber(3)
  set limit($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLimit() => $_has(2);
  @$pb.TagNumber(3)
  void clearLimit() => $_clearField(3);
}

class GetMyCoverCustomerPurchasesResponse extends $pb.GeneratedMessage {
  factory GetMyCoverCustomerPurchasesResponse({
    $core.Iterable<MyCoverPurchaseInfo>? purchases,
    $core.int? total,
    $core.bool? success,
    $core.String? msg,
  }) {
    final result = create();
    if (purchases != null) result.purchases.addAll(purchases);
    if (total != null) result.total = total;
    if (success != null) result.success = success;
    if (msg != null) result.msg = msg;
    return result;
  }

  GetMyCoverCustomerPurchasesResponse._();

  factory GetMyCoverCustomerPurchasesResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMyCoverCustomerPurchasesResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMyCoverCustomerPurchasesResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<MyCoverPurchaseInfo>(
        1, _omitFieldNames ? '' : 'purchases', $pb.PbFieldType.PM,
        subBuilder: MyCoverPurchaseInfo.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..aOB(3, _omitFieldNames ? '' : 'success')
    ..aOS(4, _omitFieldNames ? '' : 'msg')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyCoverCustomerPurchasesResponse clone() =>
      GetMyCoverCustomerPurchasesResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyCoverCustomerPurchasesResponse copyWith(
          void Function(GetMyCoverCustomerPurchasesResponse) updates) =>
      super.copyWith((message) =>
              updates(message as GetMyCoverCustomerPurchasesResponse))
          as GetMyCoverCustomerPurchasesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMyCoverCustomerPurchasesResponse create() =>
      GetMyCoverCustomerPurchasesResponse._();
  @$core.override
  GetMyCoverCustomerPurchasesResponse createEmptyInstance() => create();
  static $pb.PbList<GetMyCoverCustomerPurchasesResponse> createRepeated() =>
      $pb.PbList<GetMyCoverCustomerPurchasesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMyCoverCustomerPurchasesResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          GetMyCoverCustomerPurchasesResponse>(create);
  static GetMyCoverCustomerPurchasesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<MyCoverPurchaseInfo> get purchases => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get success => $_getBF(2);
  @$pb.TagNumber(3)
  set success($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSuccess() => $_has(2);
  @$pb.TagNumber(3)
  void clearSuccess() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get msg => $_getSZ(3);
  @$pb.TagNumber(4)
  set msg($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMsg() => $_has(3);
  @$pb.TagNumber(4)
  void clearMsg() => $_clearField(4);
}

/// Purchases
class GetMyCoverPurchasesRequest extends $pb.GeneratedMessage {
  factory GetMyCoverPurchasesRequest({
    $core.int? page,
    $core.int? limit,
  }) {
    final result = create();
    if (page != null) result.page = page;
    if (limit != null) result.limit = limit;
    return result;
  }

  GetMyCoverPurchasesRequest._();

  factory GetMyCoverPurchasesRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMyCoverPurchasesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMyCoverPurchasesRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyCoverPurchasesRequest clone() =>
      GetMyCoverPurchasesRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyCoverPurchasesRequest copyWith(
          void Function(GetMyCoverPurchasesRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetMyCoverPurchasesRequest))
          as GetMyCoverPurchasesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMyCoverPurchasesRequest create() => GetMyCoverPurchasesRequest._();
  @$core.override
  GetMyCoverPurchasesRequest createEmptyInstance() => create();
  static $pb.PbList<GetMyCoverPurchasesRequest> createRepeated() =>
      $pb.PbList<GetMyCoverPurchasesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMyCoverPurchasesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMyCoverPurchasesRequest>(create);
  static GetMyCoverPurchasesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get page => $_getIZ(0);
  @$pb.TagNumber(1)
  set page($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearPage() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get limit => $_getIZ(1);
  @$pb.TagNumber(2)
  set limit($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => $_clearField(2);
}

class GetMyCoverPurchasesResponse extends $pb.GeneratedMessage {
  factory GetMyCoverPurchasesResponse({
    $core.Iterable<MyCoverPurchaseInfo>? purchases,
    $core.int? total,
    $core.bool? success,
    $core.String? msg,
  }) {
    final result = create();
    if (purchases != null) result.purchases.addAll(purchases);
    if (total != null) result.total = total;
    if (success != null) result.success = success;
    if (msg != null) result.msg = msg;
    return result;
  }

  GetMyCoverPurchasesResponse._();

  factory GetMyCoverPurchasesResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMyCoverPurchasesResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMyCoverPurchasesResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<MyCoverPurchaseInfo>(
        1, _omitFieldNames ? '' : 'purchases', $pb.PbFieldType.PM,
        subBuilder: MyCoverPurchaseInfo.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..aOB(3, _omitFieldNames ? '' : 'success')
    ..aOS(4, _omitFieldNames ? '' : 'msg')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyCoverPurchasesResponse clone() =>
      GetMyCoverPurchasesResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyCoverPurchasesResponse copyWith(
          void Function(GetMyCoverPurchasesResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetMyCoverPurchasesResponse))
          as GetMyCoverPurchasesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMyCoverPurchasesResponse create() =>
      GetMyCoverPurchasesResponse._();
  @$core.override
  GetMyCoverPurchasesResponse createEmptyInstance() => create();
  static $pb.PbList<GetMyCoverPurchasesResponse> createRepeated() =>
      $pb.PbList<GetMyCoverPurchasesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMyCoverPurchasesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMyCoverPurchasesResponse>(create);
  static GetMyCoverPurchasesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<MyCoverPurchaseInfo> get purchases => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get success => $_getBF(2);
  @$pb.TagNumber(3)
  set success($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSuccess() => $_has(2);
  @$pb.TagNumber(3)
  void clearSuccess() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get msg => $_getSZ(3);
  @$pb.TagNumber(4)
  set msg($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMsg() => $_has(3);
  @$pb.TagNumber(4)
  void clearMsg() => $_clearField(4);
}

class GetMyCoverPurchaseByIdRequest extends $pb.GeneratedMessage {
  factory GetMyCoverPurchaseByIdRequest({
    $core.String? purchaseId,
  }) {
    final result = create();
    if (purchaseId != null) result.purchaseId = purchaseId;
    return result;
  }

  GetMyCoverPurchaseByIdRequest._();

  factory GetMyCoverPurchaseByIdRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMyCoverPurchaseByIdRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMyCoverPurchaseByIdRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'purchaseId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyCoverPurchaseByIdRequest clone() =>
      GetMyCoverPurchaseByIdRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyCoverPurchaseByIdRequest copyWith(
          void Function(GetMyCoverPurchaseByIdRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetMyCoverPurchaseByIdRequest))
          as GetMyCoverPurchaseByIdRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMyCoverPurchaseByIdRequest create() =>
      GetMyCoverPurchaseByIdRequest._();
  @$core.override
  GetMyCoverPurchaseByIdRequest createEmptyInstance() => create();
  static $pb.PbList<GetMyCoverPurchaseByIdRequest> createRepeated() =>
      $pb.PbList<GetMyCoverPurchaseByIdRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMyCoverPurchaseByIdRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMyCoverPurchaseByIdRequest>(create);
  static GetMyCoverPurchaseByIdRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get purchaseId => $_getSZ(0);
  @$pb.TagNumber(1)
  set purchaseId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPurchaseId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPurchaseId() => $_clearField(1);
}

class GetMyCoverPurchaseByIdResponse extends $pb.GeneratedMessage {
  factory GetMyCoverPurchaseByIdResponse({
    MyCoverPurchaseInfo? purchase,
    $core.bool? success,
    $core.String? msg,
  }) {
    final result = create();
    if (purchase != null) result.purchase = purchase;
    if (success != null) result.success = success;
    if (msg != null) result.msg = msg;
    return result;
  }

  GetMyCoverPurchaseByIdResponse._();

  factory GetMyCoverPurchaseByIdResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMyCoverPurchaseByIdResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMyCoverPurchaseByIdResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<MyCoverPurchaseInfo>(1, _omitFieldNames ? '' : 'purchase',
        subBuilder: MyCoverPurchaseInfo.create)
    ..aOB(2, _omitFieldNames ? '' : 'success')
    ..aOS(3, _omitFieldNames ? '' : 'msg')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyCoverPurchaseByIdResponse clone() =>
      GetMyCoverPurchaseByIdResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyCoverPurchaseByIdResponse copyWith(
          void Function(GetMyCoverPurchaseByIdResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetMyCoverPurchaseByIdResponse))
          as GetMyCoverPurchaseByIdResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMyCoverPurchaseByIdResponse create() =>
      GetMyCoverPurchaseByIdResponse._();
  @$core.override
  GetMyCoverPurchaseByIdResponse createEmptyInstance() => create();
  static $pb.PbList<GetMyCoverPurchaseByIdResponse> createRepeated() =>
      $pb.PbList<GetMyCoverPurchaseByIdResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMyCoverPurchaseByIdResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMyCoverPurchaseByIdResponse>(create);
  static GetMyCoverPurchaseByIdResponse? _defaultInstance;

  @$pb.TagNumber(1)
  MyCoverPurchaseInfo get purchase => $_getN(0);
  @$pb.TagNumber(1)
  set purchase(MyCoverPurchaseInfo value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasPurchase() => $_has(0);
  @$pb.TagNumber(1)
  void clearPurchase() => $_clearField(1);
  @$pb.TagNumber(1)
  MyCoverPurchaseInfo ensurePurchase() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get msg => $_getSZ(2);
  @$pb.TagNumber(3)
  set msg($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMsg() => $_has(2);
  @$pb.TagNumber(3)
  void clearMsg() => $_clearField(3);
}

/// MyCover Claims
class GetMyCoverClaimsRequest extends $pb.GeneratedMessage {
  factory GetMyCoverClaimsRequest({
    $core.String? status,
    $core.int? page,
    $core.int? limit,
  }) {
    final result = create();
    if (status != null) result.status = status;
    if (page != null) result.page = page;
    if (limit != null) result.limit = limit;
    return result;
  }

  GetMyCoverClaimsRequest._();

  factory GetMyCoverClaimsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMyCoverClaimsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMyCoverClaimsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'status')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyCoverClaimsRequest clone() =>
      GetMyCoverClaimsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyCoverClaimsRequest copyWith(
          void Function(GetMyCoverClaimsRequest) updates) =>
      super.copyWith((message) => updates(message as GetMyCoverClaimsRequest))
          as GetMyCoverClaimsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMyCoverClaimsRequest create() => GetMyCoverClaimsRequest._();
  @$core.override
  GetMyCoverClaimsRequest createEmptyInstance() => create();
  static $pb.PbList<GetMyCoverClaimsRequest> createRepeated() =>
      $pb.PbList<GetMyCoverClaimsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMyCoverClaimsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMyCoverClaimsRequest>(create);
  static GetMyCoverClaimsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get status => $_getSZ(0);
  @$pb.TagNumber(1)
  set status($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get page => $_getIZ(1);
  @$pb.TagNumber(2)
  set page($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPage() => $_has(1);
  @$pb.TagNumber(2)
  void clearPage() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get limit => $_getIZ(2);
  @$pb.TagNumber(3)
  set limit($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLimit() => $_has(2);
  @$pb.TagNumber(3)
  void clearLimit() => $_clearField(3);
}

class GetMyCoverClaimsResponse extends $pb.GeneratedMessage {
  factory GetMyCoverClaimsResponse({
    $core.Iterable<MyCoverClaimInfo>? claims,
    $core.int? total,
    $core.bool? success,
    $core.String? msg,
  }) {
    final result = create();
    if (claims != null) result.claims.addAll(claims);
    if (total != null) result.total = total;
    if (success != null) result.success = success;
    if (msg != null) result.msg = msg;
    return result;
  }

  GetMyCoverClaimsResponse._();

  factory GetMyCoverClaimsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMyCoverClaimsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMyCoverClaimsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<MyCoverClaimInfo>(
        1, _omitFieldNames ? '' : 'claims', $pb.PbFieldType.PM,
        subBuilder: MyCoverClaimInfo.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..aOB(3, _omitFieldNames ? '' : 'success')
    ..aOS(4, _omitFieldNames ? '' : 'msg')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyCoverClaimsResponse clone() =>
      GetMyCoverClaimsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyCoverClaimsResponse copyWith(
          void Function(GetMyCoverClaimsResponse) updates) =>
      super.copyWith((message) => updates(message as GetMyCoverClaimsResponse))
          as GetMyCoverClaimsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMyCoverClaimsResponse create() => GetMyCoverClaimsResponse._();
  @$core.override
  GetMyCoverClaimsResponse createEmptyInstance() => create();
  static $pb.PbList<GetMyCoverClaimsResponse> createRepeated() =>
      $pb.PbList<GetMyCoverClaimsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMyCoverClaimsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMyCoverClaimsResponse>(create);
  static GetMyCoverClaimsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<MyCoverClaimInfo> get claims => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get success => $_getBF(2);
  @$pb.TagNumber(3)
  set success($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSuccess() => $_has(2);
  @$pb.TagNumber(3)
  void clearSuccess() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get msg => $_getSZ(3);
  @$pb.TagNumber(4)
  set msg($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMsg() => $_has(3);
  @$pb.TagNumber(4)
  void clearMsg() => $_clearField(4);
}

class GetMyCoverClaimByIdRequest extends $pb.GeneratedMessage {
  factory GetMyCoverClaimByIdRequest({
    $core.String? claimId,
  }) {
    final result = create();
    if (claimId != null) result.claimId = claimId;
    return result;
  }

  GetMyCoverClaimByIdRequest._();

  factory GetMyCoverClaimByIdRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMyCoverClaimByIdRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMyCoverClaimByIdRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'claimId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyCoverClaimByIdRequest clone() =>
      GetMyCoverClaimByIdRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyCoverClaimByIdRequest copyWith(
          void Function(GetMyCoverClaimByIdRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetMyCoverClaimByIdRequest))
          as GetMyCoverClaimByIdRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMyCoverClaimByIdRequest create() => GetMyCoverClaimByIdRequest._();
  @$core.override
  GetMyCoverClaimByIdRequest createEmptyInstance() => create();
  static $pb.PbList<GetMyCoverClaimByIdRequest> createRepeated() =>
      $pb.PbList<GetMyCoverClaimByIdRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMyCoverClaimByIdRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMyCoverClaimByIdRequest>(create);
  static GetMyCoverClaimByIdRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get claimId => $_getSZ(0);
  @$pb.TagNumber(1)
  set claimId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasClaimId() => $_has(0);
  @$pb.TagNumber(1)
  void clearClaimId() => $_clearField(1);
}

class GetMyCoverClaimByIdResponse extends $pb.GeneratedMessage {
  factory GetMyCoverClaimByIdResponse({
    MyCoverClaimInfo? claim,
    $core.bool? success,
    $core.String? msg,
  }) {
    final result = create();
    if (claim != null) result.claim = claim;
    if (success != null) result.success = success;
    if (msg != null) result.msg = msg;
    return result;
  }

  GetMyCoverClaimByIdResponse._();

  factory GetMyCoverClaimByIdResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMyCoverClaimByIdResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMyCoverClaimByIdResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<MyCoverClaimInfo>(1, _omitFieldNames ? '' : 'claim',
        subBuilder: MyCoverClaimInfo.create)
    ..aOB(2, _omitFieldNames ? '' : 'success')
    ..aOS(3, _omitFieldNames ? '' : 'msg')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyCoverClaimByIdResponse clone() =>
      GetMyCoverClaimByIdResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyCoverClaimByIdResponse copyWith(
          void Function(GetMyCoverClaimByIdResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetMyCoverClaimByIdResponse))
          as GetMyCoverClaimByIdResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMyCoverClaimByIdResponse create() =>
      GetMyCoverClaimByIdResponse._();
  @$core.override
  GetMyCoverClaimByIdResponse createEmptyInstance() => create();
  static $pb.PbList<GetMyCoverClaimByIdResponse> createRepeated() =>
      $pb.PbList<GetMyCoverClaimByIdResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMyCoverClaimByIdResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMyCoverClaimByIdResponse>(create);
  static GetMyCoverClaimByIdResponse? _defaultInstance;

  @$pb.TagNumber(1)
  MyCoverClaimInfo get claim => $_getN(0);
  @$pb.TagNumber(1)
  set claim(MyCoverClaimInfo value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasClaim() => $_has(0);
  @$pb.TagNumber(1)
  void clearClaim() => $_clearField(1);
  @$pb.TagNumber(1)
  MyCoverClaimInfo ensureClaim() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get msg => $_getSZ(2);
  @$pb.TagNumber(3)
  set msg($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMsg() => $_has(2);
  @$pb.TagNumber(3)
  void clearMsg() => $_clearField(3);
}

/// Credit-Life Claim
class FileCreditLifeClaimRequest extends $pb.GeneratedMessage {
  factory FileCreditLifeClaimRequest({
    $core.String? policyId,
    $core.String? claimType,
    $core.String? description,
    $core.double? amount,
    $core.Iterable<$core.String>? documents,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? additionalInfo,
  }) {
    final result = create();
    if (policyId != null) result.policyId = policyId;
    if (claimType != null) result.claimType = claimType;
    if (description != null) result.description = description;
    if (amount != null) result.amount = amount;
    if (documents != null) result.documents.addAll(documents);
    if (additionalInfo != null)
      result.additionalInfo.addEntries(additionalInfo);
    return result;
  }

  FileCreditLifeClaimRequest._();

  factory FileCreditLifeClaimRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FileCreditLifeClaimRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FileCreditLifeClaimRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'policyId')
    ..aOS(2, _omitFieldNames ? '' : 'claimType')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..a<$core.double>(4, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..pPS(5, _omitFieldNames ? '' : 'documents')
    ..m<$core.String, $core.String>(6, _omitFieldNames ? '' : 'additionalInfo',
        entryClassName: 'FileCreditLifeClaimRequest.AdditionalInfoEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('pb'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FileCreditLifeClaimRequest clone() =>
      FileCreditLifeClaimRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FileCreditLifeClaimRequest copyWith(
          void Function(FileCreditLifeClaimRequest) updates) =>
      super.copyWith(
              (message) => updates(message as FileCreditLifeClaimRequest))
          as FileCreditLifeClaimRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FileCreditLifeClaimRequest create() => FileCreditLifeClaimRequest._();
  @$core.override
  FileCreditLifeClaimRequest createEmptyInstance() => create();
  static $pb.PbList<FileCreditLifeClaimRequest> createRepeated() =>
      $pb.PbList<FileCreditLifeClaimRequest>();
  @$core.pragma('dart2js:noInline')
  static FileCreditLifeClaimRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FileCreditLifeClaimRequest>(create);
  static FileCreditLifeClaimRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get policyId => $_getSZ(0);
  @$pb.TagNumber(1)
  set policyId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPolicyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPolicyId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get claimType => $_getSZ(1);
  @$pb.TagNumber(2)
  set claimType($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasClaimType() => $_has(1);
  @$pb.TagNumber(2)
  void clearClaimType() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get amount => $_getN(3);
  @$pb.TagNumber(4)
  set amount($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearAmount() => $_clearField(4);

  @$pb.TagNumber(5)
  $pb.PbList<$core.String> get documents => $_getList(4);

  @$pb.TagNumber(6)
  $pb.PbMap<$core.String, $core.String> get additionalInfo => $_getMap(5);
}

class FileCreditLifeClaimResponse extends $pb.GeneratedMessage {
  factory FileCreditLifeClaimResponse({
    $core.String? claimId,
    $core.String? claimNumber,
    $core.String? status,
    $core.String? message,
    $core.bool? success,
  }) {
    final result = create();
    if (claimId != null) result.claimId = claimId;
    if (claimNumber != null) result.claimNumber = claimNumber;
    if (status != null) result.status = status;
    if (message != null) result.message = message;
    if (success != null) result.success = success;
    return result;
  }

  FileCreditLifeClaimResponse._();

  factory FileCreditLifeClaimResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FileCreditLifeClaimResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FileCreditLifeClaimResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'claimId')
    ..aOS(2, _omitFieldNames ? '' : 'claimNumber')
    ..aOS(3, _omitFieldNames ? '' : 'status')
    ..aOS(4, _omitFieldNames ? '' : 'message')
    ..aOB(5, _omitFieldNames ? '' : 'success')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FileCreditLifeClaimResponse clone() =>
      FileCreditLifeClaimResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FileCreditLifeClaimResponse copyWith(
          void Function(FileCreditLifeClaimResponse) updates) =>
      super.copyWith(
              (message) => updates(message as FileCreditLifeClaimResponse))
          as FileCreditLifeClaimResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FileCreditLifeClaimResponse create() =>
      FileCreditLifeClaimResponse._();
  @$core.override
  FileCreditLifeClaimResponse createEmptyInstance() => create();
  static $pb.PbList<FileCreditLifeClaimResponse> createRepeated() =>
      $pb.PbList<FileCreditLifeClaimResponse>();
  @$core.pragma('dart2js:noInline')
  static FileCreditLifeClaimResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FileCreditLifeClaimResponse>(create);
  static FileCreditLifeClaimResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get claimId => $_getSZ(0);
  @$pb.TagNumber(1)
  set claimId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasClaimId() => $_has(0);
  @$pb.TagNumber(1)
  void clearClaimId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get claimNumber => $_getSZ(1);
  @$pb.TagNumber(2)
  set claimNumber($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasClaimNumber() => $_has(1);
  @$pb.TagNumber(2)
  void clearClaimNumber() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get status => $_getSZ(2);
  @$pb.TagNumber(3)
  set status($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatus() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get message => $_getSZ(3);
  @$pb.TagNumber(4)
  set message($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMessage() => $_has(3);
  @$pb.TagNumber(4)
  void clearMessage() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.bool get success => $_getBF(4);
  @$pb.TagNumber(5)
  set success($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasSuccess() => $_has(4);
  @$pb.TagNumber(5)
  void clearSuccess() => $_clearField(5);
}

/// Auxiliary: States
class GetInsuranceStatesRequest extends $pb.GeneratedMessage {
  factory GetInsuranceStatesRequest() => create();

  GetInsuranceStatesRequest._();

  factory GetInsuranceStatesRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInsuranceStatesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInsuranceStatesRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsuranceStatesRequest clone() =>
      GetInsuranceStatesRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsuranceStatesRequest copyWith(
          void Function(GetInsuranceStatesRequest) updates) =>
      super.copyWith((message) => updates(message as GetInsuranceStatesRequest))
          as GetInsuranceStatesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInsuranceStatesRequest create() => GetInsuranceStatesRequest._();
  @$core.override
  GetInsuranceStatesRequest createEmptyInstance() => create();
  static $pb.PbList<GetInsuranceStatesRequest> createRepeated() =>
      $pb.PbList<GetInsuranceStatesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInsuranceStatesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetInsuranceStatesRequest>(create);
  static GetInsuranceStatesRequest? _defaultInstance;
}

class GetInsuranceStatesResponse extends $pb.GeneratedMessage {
  factory GetInsuranceStatesResponse({
    $core.Iterable<InsuranceAuxiliaryItem>? states,
    $core.bool? success,
    $core.String? msg,
  }) {
    final result = create();
    if (states != null) result.states.addAll(states);
    if (success != null) result.success = success;
    if (msg != null) result.msg = msg;
    return result;
  }

  GetInsuranceStatesResponse._();

  factory GetInsuranceStatesResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInsuranceStatesResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInsuranceStatesResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<InsuranceAuxiliaryItem>(
        1, _omitFieldNames ? '' : 'states', $pb.PbFieldType.PM,
        subBuilder: InsuranceAuxiliaryItem.create)
    ..aOB(2, _omitFieldNames ? '' : 'success')
    ..aOS(3, _omitFieldNames ? '' : 'msg')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsuranceStatesResponse clone() =>
      GetInsuranceStatesResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsuranceStatesResponse copyWith(
          void Function(GetInsuranceStatesResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetInsuranceStatesResponse))
          as GetInsuranceStatesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInsuranceStatesResponse create() => GetInsuranceStatesResponse._();
  @$core.override
  GetInsuranceStatesResponse createEmptyInstance() => create();
  static $pb.PbList<GetInsuranceStatesResponse> createRepeated() =>
      $pb.PbList<GetInsuranceStatesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInsuranceStatesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetInsuranceStatesResponse>(create);
  static GetInsuranceStatesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<InsuranceAuxiliaryItem> get states => $_getList(0);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get msg => $_getSZ(2);
  @$pb.TagNumber(3)
  set msg($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMsg() => $_has(2);
  @$pb.TagNumber(3)
  void clearMsg() => $_clearField(3);
}

/// Auxiliary: Vehicle Makes
class GetInsuranceVehicleMakesRequest extends $pb.GeneratedMessage {
  factory GetInsuranceVehicleMakesRequest() => create();

  GetInsuranceVehicleMakesRequest._();

  factory GetInsuranceVehicleMakesRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInsuranceVehicleMakesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInsuranceVehicleMakesRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsuranceVehicleMakesRequest clone() =>
      GetInsuranceVehicleMakesRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsuranceVehicleMakesRequest copyWith(
          void Function(GetInsuranceVehicleMakesRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetInsuranceVehicleMakesRequest))
          as GetInsuranceVehicleMakesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInsuranceVehicleMakesRequest create() =>
      GetInsuranceVehicleMakesRequest._();
  @$core.override
  GetInsuranceVehicleMakesRequest createEmptyInstance() => create();
  static $pb.PbList<GetInsuranceVehicleMakesRequest> createRepeated() =>
      $pb.PbList<GetInsuranceVehicleMakesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInsuranceVehicleMakesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetInsuranceVehicleMakesRequest>(
          create);
  static GetInsuranceVehicleMakesRequest? _defaultInstance;
}

class GetInsuranceVehicleMakesResponse extends $pb.GeneratedMessage {
  factory GetInsuranceVehicleMakesResponse({
    $core.Iterable<InsuranceAuxiliaryItem>? makes,
    $core.bool? success,
    $core.String? msg,
  }) {
    final result = create();
    if (makes != null) result.makes.addAll(makes);
    if (success != null) result.success = success;
    if (msg != null) result.msg = msg;
    return result;
  }

  GetInsuranceVehicleMakesResponse._();

  factory GetInsuranceVehicleMakesResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInsuranceVehicleMakesResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInsuranceVehicleMakesResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<InsuranceAuxiliaryItem>(
        1, _omitFieldNames ? '' : 'makes', $pb.PbFieldType.PM,
        subBuilder: InsuranceAuxiliaryItem.create)
    ..aOB(2, _omitFieldNames ? '' : 'success')
    ..aOS(3, _omitFieldNames ? '' : 'msg')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsuranceVehicleMakesResponse clone() =>
      GetInsuranceVehicleMakesResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsuranceVehicleMakesResponse copyWith(
          void Function(GetInsuranceVehicleMakesResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetInsuranceVehicleMakesResponse))
          as GetInsuranceVehicleMakesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInsuranceVehicleMakesResponse create() =>
      GetInsuranceVehicleMakesResponse._();
  @$core.override
  GetInsuranceVehicleMakesResponse createEmptyInstance() => create();
  static $pb.PbList<GetInsuranceVehicleMakesResponse> createRepeated() =>
      $pb.PbList<GetInsuranceVehicleMakesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInsuranceVehicleMakesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetInsuranceVehicleMakesResponse>(
          create);
  static GetInsuranceVehicleMakesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<InsuranceAuxiliaryItem> get makes => $_getList(0);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get msg => $_getSZ(2);
  @$pb.TagNumber(3)
  set msg($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMsg() => $_has(2);
  @$pb.TagNumber(3)
  void clearMsg() => $_clearField(3);
}

class MyCoverNotificationPreference extends $pb.GeneratedMessage {
  factory MyCoverNotificationPreference({
    $core.String? key,
    $core.String? category,
    $core.String? label,
    $core.String? description,
    $core.bool? enabled,
  }) {
    final result = create();
    if (key != null) result.key = key;
    if (category != null) result.category = category;
    if (label != null) result.label = label;
    if (description != null) result.description = description;
    if (enabled != null) result.enabled = enabled;
    return result;
  }

  MyCoverNotificationPreference._();

  factory MyCoverNotificationPreference.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MyCoverNotificationPreference.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MyCoverNotificationPreference',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'key')
    ..aOS(2, _omitFieldNames ? '' : 'category')
    ..aOS(3, _omitFieldNames ? '' : 'label')
    ..aOS(4, _omitFieldNames ? '' : 'description')
    ..aOB(5, _omitFieldNames ? '' : 'enabled')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MyCoverNotificationPreference clone() =>
      MyCoverNotificationPreference()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MyCoverNotificationPreference copyWith(
          void Function(MyCoverNotificationPreference) updates) =>
      super.copyWith(
              (message) => updates(message as MyCoverNotificationPreference))
          as MyCoverNotificationPreference;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MyCoverNotificationPreference create() =>
      MyCoverNotificationPreference._();
  @$core.override
  MyCoverNotificationPreference createEmptyInstance() => create();
  static $pb.PbList<MyCoverNotificationPreference> createRepeated() =>
      $pb.PbList<MyCoverNotificationPreference>();
  @$core.pragma('dart2js:noInline')
  static MyCoverNotificationPreference getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MyCoverNotificationPreference>(create);
  static MyCoverNotificationPreference? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get key => $_getSZ(0);
  @$pb.TagNumber(1)
  set key($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearKey() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get category => $_getSZ(1);
  @$pb.TagNumber(2)
  set category($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCategory() => $_has(1);
  @$pb.TagNumber(2)
  void clearCategory() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get label => $_getSZ(2);
  @$pb.TagNumber(3)
  set label($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLabel() => $_has(2);
  @$pb.TagNumber(3)
  void clearLabel() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get description => $_getSZ(3);
  @$pb.TagNumber(4)
  set description($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDescription() => $_has(3);
  @$pb.TagNumber(4)
  void clearDescription() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.bool get enabled => $_getBF(4);
  @$pb.TagNumber(5)
  set enabled($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasEnabled() => $_has(4);
  @$pb.TagNumber(5)
  void clearEnabled() => $_clearField(5);
}

class GetMyCoverNotificationPreferencesRequest extends $pb.GeneratedMessage {
  factory GetMyCoverNotificationPreferencesRequest() => create();

  GetMyCoverNotificationPreferencesRequest._();

  factory GetMyCoverNotificationPreferencesRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMyCoverNotificationPreferencesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMyCoverNotificationPreferencesRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyCoverNotificationPreferencesRequest clone() =>
      GetMyCoverNotificationPreferencesRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyCoverNotificationPreferencesRequest copyWith(
          void Function(GetMyCoverNotificationPreferencesRequest) updates) =>
      super.copyWith((message) =>
              updates(message as GetMyCoverNotificationPreferencesRequest))
          as GetMyCoverNotificationPreferencesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMyCoverNotificationPreferencesRequest create() =>
      GetMyCoverNotificationPreferencesRequest._();
  @$core.override
  GetMyCoverNotificationPreferencesRequest createEmptyInstance() => create();
  static $pb.PbList<GetMyCoverNotificationPreferencesRequest>
      createRepeated() =>
          $pb.PbList<GetMyCoverNotificationPreferencesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMyCoverNotificationPreferencesRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          GetMyCoverNotificationPreferencesRequest>(create);
  static GetMyCoverNotificationPreferencesRequest? _defaultInstance;
}

class GetMyCoverNotificationPreferencesResponse extends $pb.GeneratedMessage {
  factory GetMyCoverNotificationPreferencesResponse({
    $core.Iterable<MyCoverNotificationPreference>? preferences,
    $core.bool? success,
    $core.String? msg,
  }) {
    final result = create();
    if (preferences != null) result.preferences.addAll(preferences);
    if (success != null) result.success = success;
    if (msg != null) result.msg = msg;
    return result;
  }

  GetMyCoverNotificationPreferencesResponse._();

  factory GetMyCoverNotificationPreferencesResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMyCoverNotificationPreferencesResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMyCoverNotificationPreferencesResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<MyCoverNotificationPreference>(
        1, _omitFieldNames ? '' : 'preferences', $pb.PbFieldType.PM,
        subBuilder: MyCoverNotificationPreference.create)
    ..aOB(2, _omitFieldNames ? '' : 'success')
    ..aOS(3, _omitFieldNames ? '' : 'msg')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyCoverNotificationPreferencesResponse clone() =>
      GetMyCoverNotificationPreferencesResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyCoverNotificationPreferencesResponse copyWith(
          void Function(GetMyCoverNotificationPreferencesResponse) updates) =>
      super.copyWith((message) =>
              updates(message as GetMyCoverNotificationPreferencesResponse))
          as GetMyCoverNotificationPreferencesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMyCoverNotificationPreferencesResponse create() =>
      GetMyCoverNotificationPreferencesResponse._();
  @$core.override
  GetMyCoverNotificationPreferencesResponse createEmptyInstance() => create();
  static $pb.PbList<GetMyCoverNotificationPreferencesResponse>
      createRepeated() =>
          $pb.PbList<GetMyCoverNotificationPreferencesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMyCoverNotificationPreferencesResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          GetMyCoverNotificationPreferencesResponse>(create);
  static GetMyCoverNotificationPreferencesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<MyCoverNotificationPreference> get preferences => $_getList(0);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get msg => $_getSZ(2);
  @$pb.TagNumber(3)
  set msg($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMsg() => $_has(2);
  @$pb.TagNumber(3)
  void clearMsg() => $_clearField(3);
}

class UpdateMyCoverNotificationPreferencesRequest extends $pb.GeneratedMessage {
  factory UpdateMyCoverNotificationPreferencesRequest({
    $core.Iterable<MyCoverNotificationPreference>? preferences,
  }) {
    final result = create();
    if (preferences != null) result.preferences.addAll(preferences);
    return result;
  }

  UpdateMyCoverNotificationPreferencesRequest._();

  factory UpdateMyCoverNotificationPreferencesRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateMyCoverNotificationPreferencesRequest.fromJson(
          $core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateMyCoverNotificationPreferencesRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..pc<MyCoverNotificationPreference>(
        1, _omitFieldNames ? '' : 'preferences', $pb.PbFieldType.PM,
        subBuilder: MyCoverNotificationPreference.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateMyCoverNotificationPreferencesRequest clone() =>
      UpdateMyCoverNotificationPreferencesRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateMyCoverNotificationPreferencesRequest copyWith(
          void Function(UpdateMyCoverNotificationPreferencesRequest) updates) =>
      super.copyWith((message) =>
              updates(message as UpdateMyCoverNotificationPreferencesRequest))
          as UpdateMyCoverNotificationPreferencesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateMyCoverNotificationPreferencesRequest create() =>
      UpdateMyCoverNotificationPreferencesRequest._();
  @$core.override
  UpdateMyCoverNotificationPreferencesRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateMyCoverNotificationPreferencesRequest>
      createRepeated() =>
          $pb.PbList<UpdateMyCoverNotificationPreferencesRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateMyCoverNotificationPreferencesRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          UpdateMyCoverNotificationPreferencesRequest>(create);
  static UpdateMyCoverNotificationPreferencesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<MyCoverNotificationPreference> get preferences => $_getList(0);
}

class UpdateMyCoverNotificationPreferencesResponse
    extends $pb.GeneratedMessage {
  factory UpdateMyCoverNotificationPreferencesResponse({
    $core.bool? success,
    $core.String? msg,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (msg != null) result.msg = msg;
    return result;
  }

  UpdateMyCoverNotificationPreferencesResponse._();

  factory UpdateMyCoverNotificationPreferencesResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateMyCoverNotificationPreferencesResponse.fromJson(
          $core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateMyCoverNotificationPreferencesResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'msg')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateMyCoverNotificationPreferencesResponse clone() =>
      UpdateMyCoverNotificationPreferencesResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateMyCoverNotificationPreferencesResponse copyWith(
          void Function(UpdateMyCoverNotificationPreferencesResponse)
              updates) =>
      super.copyWith((message) =>
              updates(message as UpdateMyCoverNotificationPreferencesResponse))
          as UpdateMyCoverNotificationPreferencesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateMyCoverNotificationPreferencesResponse create() =>
      UpdateMyCoverNotificationPreferencesResponse._();
  @$core.override
  UpdateMyCoverNotificationPreferencesResponse createEmptyInstance() =>
      create();
  static $pb.PbList<UpdateMyCoverNotificationPreferencesResponse>
      createRepeated() =>
          $pb.PbList<UpdateMyCoverNotificationPreferencesResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateMyCoverNotificationPreferencesResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          UpdateMyCoverNotificationPreferencesResponse>(create);
  static UpdateMyCoverNotificationPreferencesResponse? _defaultInstance;

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

class GetMyCoverWalletBalanceRequest extends $pb.GeneratedMessage {
  factory GetMyCoverWalletBalanceRequest() => create();

  GetMyCoverWalletBalanceRequest._();

  factory GetMyCoverWalletBalanceRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMyCoverWalletBalanceRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMyCoverWalletBalanceRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyCoverWalletBalanceRequest clone() =>
      GetMyCoverWalletBalanceRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyCoverWalletBalanceRequest copyWith(
          void Function(GetMyCoverWalletBalanceRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetMyCoverWalletBalanceRequest))
          as GetMyCoverWalletBalanceRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMyCoverWalletBalanceRequest create() =>
      GetMyCoverWalletBalanceRequest._();
  @$core.override
  GetMyCoverWalletBalanceRequest createEmptyInstance() => create();
  static $pb.PbList<GetMyCoverWalletBalanceRequest> createRepeated() =>
      $pb.PbList<GetMyCoverWalletBalanceRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMyCoverWalletBalanceRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMyCoverWalletBalanceRequest>(create);
  static GetMyCoverWalletBalanceRequest? _defaultInstance;
}

class GetMyCoverWalletBalanceResponse extends $pb.GeneratedMessage {
  factory GetMyCoverWalletBalanceResponse({
    $core.double? balance,
    $core.String? currency,
    $core.bool? success,
    $core.String? msg,
  }) {
    final result = create();
    if (balance != null) result.balance = balance;
    if (currency != null) result.currency = currency;
    if (success != null) result.success = success;
    if (msg != null) result.msg = msg;
    return result;
  }

  GetMyCoverWalletBalanceResponse._();

  factory GetMyCoverWalletBalanceResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMyCoverWalletBalanceResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMyCoverWalletBalanceResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'balance', $pb.PbFieldType.OD)
    ..aOS(2, _omitFieldNames ? '' : 'currency')
    ..aOB(3, _omitFieldNames ? '' : 'success')
    ..aOS(4, _omitFieldNames ? '' : 'msg')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyCoverWalletBalanceResponse clone() =>
      GetMyCoverWalletBalanceResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMyCoverWalletBalanceResponse copyWith(
          void Function(GetMyCoverWalletBalanceResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetMyCoverWalletBalanceResponse))
          as GetMyCoverWalletBalanceResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMyCoverWalletBalanceResponse create() =>
      GetMyCoverWalletBalanceResponse._();
  @$core.override
  GetMyCoverWalletBalanceResponse createEmptyInstance() => create();
  static $pb.PbList<GetMyCoverWalletBalanceResponse> createRepeated() =>
      $pb.PbList<GetMyCoverWalletBalanceResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMyCoverWalletBalanceResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMyCoverWalletBalanceResponse>(
          create);
  static GetMyCoverWalletBalanceResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get balance => $_getN(0);
  @$pb.TagNumber(1)
  set balance($core.double value) => $_setDouble(0, value);
  @$pb.TagNumber(1)
  $core.bool hasBalance() => $_has(0);
  @$pb.TagNumber(1)
  void clearBalance() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get currency => $_getSZ(1);
  @$pb.TagNumber(2)
  set currency($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCurrency() => $_has(1);
  @$pb.TagNumber(2)
  void clearCurrency() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get success => $_getBF(2);
  @$pb.TagNumber(3)
  set success($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSuccess() => $_has(2);
  @$pb.TagNumber(3)
  void clearSuccess() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get msg => $_getSZ(3);
  @$pb.TagNumber(4)
  set msg($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMsg() => $_has(3);
  @$pb.TagNumber(4)
  void clearMsg() => $_clearField(4);
}

class RequestInsuranceRefundRequest extends $pb.GeneratedMessage {
  factory RequestInsuranceRefundRequest({
    $core.String? policyReference,
    $core.String? reason,
  }) {
    final result = create();
    if (policyReference != null) result.policyReference = policyReference;
    if (reason != null) result.reason = reason;
    return result;
  }

  RequestInsuranceRefundRequest._();

  factory RequestInsuranceRefundRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RequestInsuranceRefundRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RequestInsuranceRefundRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'policyReference')
    ..aOS(2, _omitFieldNames ? '' : 'reason')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RequestInsuranceRefundRequest clone() =>
      RequestInsuranceRefundRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RequestInsuranceRefundRequest copyWith(
          void Function(RequestInsuranceRefundRequest) updates) =>
      super.copyWith(
              (message) => updates(message as RequestInsuranceRefundRequest))
          as RequestInsuranceRefundRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RequestInsuranceRefundRequest create() =>
      RequestInsuranceRefundRequest._();
  @$core.override
  RequestInsuranceRefundRequest createEmptyInstance() => create();
  static $pb.PbList<RequestInsuranceRefundRequest> createRepeated() =>
      $pb.PbList<RequestInsuranceRefundRequest>();
  @$core.pragma('dart2js:noInline')
  static RequestInsuranceRefundRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RequestInsuranceRefundRequest>(create);
  static RequestInsuranceRefundRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get policyReference => $_getSZ(0);
  @$pb.TagNumber(1)
  set policyReference($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPolicyReference() => $_has(0);
  @$pb.TagNumber(1)
  void clearPolicyReference() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get reason => $_getSZ(1);
  @$pb.TagNumber(2)
  set reason($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasReason() => $_has(1);
  @$pb.TagNumber(2)
  void clearReason() => $_clearField(2);
}

class RequestInsuranceRefundResponse extends $pb.GeneratedMessage {
  factory RequestInsuranceRefundResponse({
    InsuranceRefundInfo? refund,
    $core.bool? success,
    $core.String? msg,
  }) {
    final result = create();
    if (refund != null) result.refund = refund;
    if (success != null) result.success = success;
    if (msg != null) result.msg = msg;
    return result;
  }

  RequestInsuranceRefundResponse._();

  factory RequestInsuranceRefundResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RequestInsuranceRefundResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RequestInsuranceRefundResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<InsuranceRefundInfo>(1, _omitFieldNames ? '' : 'refund',
        subBuilder: InsuranceRefundInfo.create)
    ..aOB(2, _omitFieldNames ? '' : 'success')
    ..aOS(3, _omitFieldNames ? '' : 'msg')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RequestInsuranceRefundResponse clone() =>
      RequestInsuranceRefundResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RequestInsuranceRefundResponse copyWith(
          void Function(RequestInsuranceRefundResponse) updates) =>
      super.copyWith(
              (message) => updates(message as RequestInsuranceRefundResponse))
          as RequestInsuranceRefundResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RequestInsuranceRefundResponse create() =>
      RequestInsuranceRefundResponse._();
  @$core.override
  RequestInsuranceRefundResponse createEmptyInstance() => create();
  static $pb.PbList<RequestInsuranceRefundResponse> createRepeated() =>
      $pb.PbList<RequestInsuranceRefundResponse>();
  @$core.pragma('dart2js:noInline')
  static RequestInsuranceRefundResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RequestInsuranceRefundResponse>(create);
  static RequestInsuranceRefundResponse? _defaultInstance;

  @$pb.TagNumber(1)
  InsuranceRefundInfo get refund => $_getN(0);
  @$pb.TagNumber(1)
  set refund(InsuranceRefundInfo value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRefund() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefund() => $_clearField(1);
  @$pb.TagNumber(1)
  InsuranceRefundInfo ensureRefund() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get msg => $_getSZ(2);
  @$pb.TagNumber(3)
  set msg($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMsg() => $_has(2);
  @$pb.TagNumber(3)
  void clearMsg() => $_clearField(3);
}

class GetInsuranceRefundStatusRequest extends $pb.GeneratedMessage {
  factory GetInsuranceRefundStatusRequest({
    $core.String? policyReference,
  }) {
    final result = create();
    if (policyReference != null) result.policyReference = policyReference;
    return result;
  }

  GetInsuranceRefundStatusRequest._();

  factory GetInsuranceRefundStatusRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInsuranceRefundStatusRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInsuranceRefundStatusRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'policyReference')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsuranceRefundStatusRequest clone() =>
      GetInsuranceRefundStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsuranceRefundStatusRequest copyWith(
          void Function(GetInsuranceRefundStatusRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetInsuranceRefundStatusRequest))
          as GetInsuranceRefundStatusRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInsuranceRefundStatusRequest create() =>
      GetInsuranceRefundStatusRequest._();
  @$core.override
  GetInsuranceRefundStatusRequest createEmptyInstance() => create();
  static $pb.PbList<GetInsuranceRefundStatusRequest> createRepeated() =>
      $pb.PbList<GetInsuranceRefundStatusRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInsuranceRefundStatusRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetInsuranceRefundStatusRequest>(
          create);
  static GetInsuranceRefundStatusRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get policyReference => $_getSZ(0);
  @$pb.TagNumber(1)
  set policyReference($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPolicyReference() => $_has(0);
  @$pb.TagNumber(1)
  void clearPolicyReference() => $_clearField(1);
}

class GetInsuranceRefundStatusResponse extends $pb.GeneratedMessage {
  factory GetInsuranceRefundStatusResponse({
    InsuranceRefundInfo? refund,
    $core.bool? success,
    $core.String? msg,
  }) {
    final result = create();
    if (refund != null) result.refund = refund;
    if (success != null) result.success = success;
    if (msg != null) result.msg = msg;
    return result;
  }

  GetInsuranceRefundStatusResponse._();

  factory GetInsuranceRefundStatusResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInsuranceRefundStatusResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInsuranceRefundStatusResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<InsuranceRefundInfo>(1, _omitFieldNames ? '' : 'refund',
        subBuilder: InsuranceRefundInfo.create)
    ..aOB(2, _omitFieldNames ? '' : 'success')
    ..aOS(3, _omitFieldNames ? '' : 'msg')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsuranceRefundStatusResponse clone() =>
      GetInsuranceRefundStatusResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInsuranceRefundStatusResponse copyWith(
          void Function(GetInsuranceRefundStatusResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetInsuranceRefundStatusResponse))
          as GetInsuranceRefundStatusResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInsuranceRefundStatusResponse create() =>
      GetInsuranceRefundStatusResponse._();
  @$core.override
  GetInsuranceRefundStatusResponse createEmptyInstance() => create();
  static $pb.PbList<GetInsuranceRefundStatusResponse> createRepeated() =>
      $pb.PbList<GetInsuranceRefundStatusResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInsuranceRefundStatusResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetInsuranceRefundStatusResponse>(
          create);
  static GetInsuranceRefundStatusResponse? _defaultInstance;

  @$pb.TagNumber(1)
  InsuranceRefundInfo get refund => $_getN(0);
  @$pb.TagNumber(1)
  set refund(InsuranceRefundInfo value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRefund() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefund() => $_clearField(1);
  @$pb.TagNumber(1)
  InsuranceRefundInfo ensureRefund() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get msg => $_getSZ(2);
  @$pb.TagNumber(3)
  set msg($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMsg() => $_has(2);
  @$pb.TagNumber(3)
  void clearMsg() => $_clearField(3);
}

class InsuranceRefundInfo extends $pb.GeneratedMessage {
  factory InsuranceRefundInfo({
    $core.String? refundId,
    $core.String? policyReference,
    $core.String? status,
    $core.double? amount,
    $core.String? currency,
    $core.bool? providerRefunded,
    $core.bool? walletCredited,
    $core.String? reason,
    $core.String? failureReason,
    $core.String? initiatedAt,
    $core.String? completedAt,
  }) {
    final result = create();
    if (refundId != null) result.refundId = refundId;
    if (policyReference != null) result.policyReference = policyReference;
    if (status != null) result.status = status;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    if (providerRefunded != null) result.providerRefunded = providerRefunded;
    if (walletCredited != null) result.walletCredited = walletCredited;
    if (reason != null) result.reason = reason;
    if (failureReason != null) result.failureReason = failureReason;
    if (initiatedAt != null) result.initiatedAt = initiatedAt;
    if (completedAt != null) result.completedAt = completedAt;
    return result;
  }

  InsuranceRefundInfo._();

  factory InsuranceRefundInfo.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InsuranceRefundInfo.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InsuranceRefundInfo',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'refundId')
    ..aOS(2, _omitFieldNames ? '' : 'policyReference')
    ..aOS(3, _omitFieldNames ? '' : 'status')
    ..a<$core.double>(4, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(5, _omitFieldNames ? '' : 'currency')
    ..aOB(6, _omitFieldNames ? '' : 'providerRefunded')
    ..aOB(7, _omitFieldNames ? '' : 'walletCredited')
    ..aOS(8, _omitFieldNames ? '' : 'reason')
    ..aOS(9, _omitFieldNames ? '' : 'failureReason')
    ..aOS(10, _omitFieldNames ? '' : 'initiatedAt')
    ..aOS(11, _omitFieldNames ? '' : 'completedAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InsuranceRefundInfo clone() => InsuranceRefundInfo()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InsuranceRefundInfo copyWith(void Function(InsuranceRefundInfo) updates) =>
      super.copyWith((message) => updates(message as InsuranceRefundInfo))
          as InsuranceRefundInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InsuranceRefundInfo create() => InsuranceRefundInfo._();
  @$core.override
  InsuranceRefundInfo createEmptyInstance() => create();
  static $pb.PbList<InsuranceRefundInfo> createRepeated() =>
      $pb.PbList<InsuranceRefundInfo>();
  @$core.pragma('dart2js:noInline')
  static InsuranceRefundInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InsuranceRefundInfo>(create);
  static InsuranceRefundInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refundId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refundId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRefundId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefundId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get policyReference => $_getSZ(1);
  @$pb.TagNumber(2)
  set policyReference($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPolicyReference() => $_has(1);
  @$pb.TagNumber(2)
  void clearPolicyReference() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get status => $_getSZ(2);
  @$pb.TagNumber(3)
  set status($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatus() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get amount => $_getN(3);
  @$pb.TagNumber(4)
  set amount($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearAmount() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get currency => $_getSZ(4);
  @$pb.TagNumber(5)
  set currency($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCurrency() => $_has(4);
  @$pb.TagNumber(5)
  void clearCurrency() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.bool get providerRefunded => $_getBF(5);
  @$pb.TagNumber(6)
  set providerRefunded($core.bool value) => $_setBool(5, value);
  @$pb.TagNumber(6)
  $core.bool hasProviderRefunded() => $_has(5);
  @$pb.TagNumber(6)
  void clearProviderRefunded() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.bool get walletCredited => $_getBF(6);
  @$pb.TagNumber(7)
  set walletCredited($core.bool value) => $_setBool(6, value);
  @$pb.TagNumber(7)
  $core.bool hasWalletCredited() => $_has(6);
  @$pb.TagNumber(7)
  void clearWalletCredited() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get reason => $_getSZ(7);
  @$pb.TagNumber(8)
  set reason($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasReason() => $_has(7);
  @$pb.TagNumber(8)
  void clearReason() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get failureReason => $_getSZ(8);
  @$pb.TagNumber(9)
  set failureReason($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasFailureReason() => $_has(8);
  @$pb.TagNumber(9)
  void clearFailureReason() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get initiatedAt => $_getSZ(9);
  @$pb.TagNumber(10)
  set initiatedAt($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasInitiatedAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearInitiatedAt() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get completedAt => $_getSZ(10);
  @$pb.TagNumber(11)
  set completedAt($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasCompletedAt() => $_has(10);
  @$pb.TagNumber(11)
  void clearCompletedAt() => $_clearField(11);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
