//
//  Generated code. Do not modify.
//  source: insurance.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

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
  InsurancePaginationInfo._() : super();
  factory InsurancePaginationInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InsurancePaginationInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'InsurancePaginationInfo', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
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
  InsurancePaginationInfo clone() => InsurancePaginationInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InsurancePaginationInfo copyWith(void Function(InsurancePaginationInfo) updates) => super.copyWith((message) => updates(message as InsurancePaginationInfo)) as InsurancePaginationInfo;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InsurancePaginationInfo create() => InsurancePaginationInfo._();
  InsurancePaginationInfo createEmptyInstance() => create();
  static $pb.PbList<InsurancePaginationInfo> createRepeated() => $pb.PbList<InsurancePaginationInfo>();
  @$core.pragma('dart2js:noInline')
  static InsurancePaginationInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InsurancePaginationInfo>(create);
  static InsurancePaginationInfo? _defaultInstance;

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

/// Insurance Policy Management
class GetUserInsurancesRequest extends $pb.GeneratedMessage {
  factory GetUserInsurancesRequest({
    $core.int? page,
    $core.int? limit,
  }) {
    final $result = create();
    if (page != null) {
      $result.page = page;
    }
    if (limit != null) {
      $result.limit = limit;
    }
    return $result;
  }
  GetUserInsurancesRequest._() : super();
  factory GetUserInsurancesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserInsurancesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetUserInsurancesRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUserInsurancesRequest clone() => GetUserInsurancesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUserInsurancesRequest copyWith(void Function(GetUserInsurancesRequest) updates) => super.copyWith((message) => updates(message as GetUserInsurancesRequest)) as GetUserInsurancesRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserInsurancesRequest create() => GetUserInsurancesRequest._();
  GetUserInsurancesRequest createEmptyInstance() => create();
  static $pb.PbList<GetUserInsurancesRequest> createRepeated() => $pb.PbList<GetUserInsurancesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetUserInsurancesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetUserInsurancesRequest>(create);
  static GetUserInsurancesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get page => $_getIZ(0);
  @$pb.TagNumber(1)
  set page($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearPage() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get limit => $_getIZ(1);
  @$pb.TagNumber(2)
  set limit($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => clearField(2);
}

class GetUserInsurancesResponse extends $pb.GeneratedMessage {
  factory GetUserInsurancesResponse({
    $core.Iterable<Insurance>? insurances,
    InsurancePaginationInfo? pagination,
    $core.bool? success,
    $core.String? msg,
  }) {
    final $result = create();
    if (insurances != null) {
      $result.insurances.addAll(insurances);
    }
    if (pagination != null) {
      $result.pagination = pagination;
    }
    if (success != null) {
      $result.success = success;
    }
    if (msg != null) {
      $result.msg = msg;
    }
    return $result;
  }
  GetUserInsurancesResponse._() : super();
  factory GetUserInsurancesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserInsurancesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetUserInsurancesResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<Insurance>(1, _omitFieldNames ? '' : 'insurances', $pb.PbFieldType.PM, subBuilder: Insurance.create)
    ..aOM<InsurancePaginationInfo>(2, _omitFieldNames ? '' : 'pagination', subBuilder: InsurancePaginationInfo.create)
    ..aOB(3, _omitFieldNames ? '' : 'success')
    ..aOS(4, _omitFieldNames ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUserInsurancesResponse clone() => GetUserInsurancesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUserInsurancesResponse copyWith(void Function(GetUserInsurancesResponse) updates) => super.copyWith((message) => updates(message as GetUserInsurancesResponse)) as GetUserInsurancesResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserInsurancesResponse create() => GetUserInsurancesResponse._();
  GetUserInsurancesResponse createEmptyInstance() => create();
  static $pb.PbList<GetUserInsurancesResponse> createRepeated() => $pb.PbList<GetUserInsurancesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetUserInsurancesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetUserInsurancesResponse>(create);
  static GetUserInsurancesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Insurance> get insurances => $_getList(0);

  @$pb.TagNumber(2)
  InsurancePaginationInfo get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination(InsurancePaginationInfo v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => clearField(2);
  @$pb.TagNumber(2)
  InsurancePaginationInfo ensurePagination() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.bool get success => $_getBF(2);
  @$pb.TagNumber(3)
  set success($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSuccess() => $_has(2);
  @$pb.TagNumber(3)
  void clearSuccess() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get msg => $_getSZ(3);
  @$pb.TagNumber(4)
  set msg($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMsg() => $_has(3);
  @$pb.TagNumber(4)
  void clearMsg() => clearField(4);
}

class GetInsuranceByIdRequest extends $pb.GeneratedMessage {
  factory GetInsuranceByIdRequest({
    $core.String? id,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    return $result;
  }
  GetInsuranceByIdRequest._() : super();
  factory GetInsuranceByIdRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInsuranceByIdRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetInsuranceByIdRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInsuranceByIdRequest clone() => GetInsuranceByIdRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInsuranceByIdRequest copyWith(void Function(GetInsuranceByIdRequest) updates) => super.copyWith((message) => updates(message as GetInsuranceByIdRequest)) as GetInsuranceByIdRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInsuranceByIdRequest create() => GetInsuranceByIdRequest._();
  GetInsuranceByIdRequest createEmptyInstance() => create();
  static $pb.PbList<GetInsuranceByIdRequest> createRepeated() => $pb.PbList<GetInsuranceByIdRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInsuranceByIdRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInsuranceByIdRequest>(create);
  static GetInsuranceByIdRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);
}

class GetInsuranceByIdResponse extends $pb.GeneratedMessage {
  factory GetInsuranceByIdResponse({
    Insurance? insurance,
    $core.bool? success,
    $core.String? msg,
  }) {
    final $result = create();
    if (insurance != null) {
      $result.insurance = insurance;
    }
    if (success != null) {
      $result.success = success;
    }
    if (msg != null) {
      $result.msg = msg;
    }
    return $result;
  }
  GetInsuranceByIdResponse._() : super();
  factory GetInsuranceByIdResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInsuranceByIdResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetInsuranceByIdResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<Insurance>(1, _omitFieldNames ? '' : 'insurance', subBuilder: Insurance.create)
    ..aOB(2, _omitFieldNames ? '' : 'success')
    ..aOS(3, _omitFieldNames ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInsuranceByIdResponse clone() => GetInsuranceByIdResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInsuranceByIdResponse copyWith(void Function(GetInsuranceByIdResponse) updates) => super.copyWith((message) => updates(message as GetInsuranceByIdResponse)) as GetInsuranceByIdResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInsuranceByIdResponse create() => GetInsuranceByIdResponse._();
  GetInsuranceByIdResponse createEmptyInstance() => create();
  static $pb.PbList<GetInsuranceByIdResponse> createRepeated() => $pb.PbList<GetInsuranceByIdResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInsuranceByIdResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInsuranceByIdResponse>(create);
  static GetInsuranceByIdResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Insurance get insurance => $_getN(0);
  @$pb.TagNumber(1)
  set insurance(Insurance v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasInsurance() => $_has(0);
  @$pb.TagNumber(1)
  void clearInsurance() => clearField(1);
  @$pb.TagNumber(1)
  Insurance ensureInsurance() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get msg => $_getSZ(2);
  @$pb.TagNumber(3)
  set msg($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMsg() => $_has(2);
  @$pb.TagNumber(3)
  void clearMsg() => clearField(3);
}

class CreateInsuranceRequest extends $pb.GeneratedMessage {
  factory CreateInsuranceRequest({
    Insurance? insurance,
  }) {
    final $result = create();
    if (insurance != null) {
      $result.insurance = insurance;
    }
    return $result;
  }
  CreateInsuranceRequest._() : super();
  factory CreateInsuranceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateInsuranceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateInsuranceRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<Insurance>(1, _omitFieldNames ? '' : 'insurance', subBuilder: Insurance.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateInsuranceRequest clone() => CreateInsuranceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateInsuranceRequest copyWith(void Function(CreateInsuranceRequest) updates) => super.copyWith((message) => updates(message as CreateInsuranceRequest)) as CreateInsuranceRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateInsuranceRequest create() => CreateInsuranceRequest._();
  CreateInsuranceRequest createEmptyInstance() => create();
  static $pb.PbList<CreateInsuranceRequest> createRepeated() => $pb.PbList<CreateInsuranceRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateInsuranceRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateInsuranceRequest>(create);
  static CreateInsuranceRequest? _defaultInstance;

  @$pb.TagNumber(1)
  Insurance get insurance => $_getN(0);
  @$pb.TagNumber(1)
  set insurance(Insurance v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasInsurance() => $_has(0);
  @$pb.TagNumber(1)
  void clearInsurance() => clearField(1);
  @$pb.TagNumber(1)
  Insurance ensureInsurance() => $_ensure(0);
}

class CreateInsuranceResponse extends $pb.GeneratedMessage {
  factory CreateInsuranceResponse({
    Insurance? insurance,
    $core.bool? success,
    $core.String? msg,
  }) {
    final $result = create();
    if (insurance != null) {
      $result.insurance = insurance;
    }
    if (success != null) {
      $result.success = success;
    }
    if (msg != null) {
      $result.msg = msg;
    }
    return $result;
  }
  CreateInsuranceResponse._() : super();
  factory CreateInsuranceResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateInsuranceResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateInsuranceResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<Insurance>(1, _omitFieldNames ? '' : 'insurance', subBuilder: Insurance.create)
    ..aOB(2, _omitFieldNames ? '' : 'success')
    ..aOS(3, _omitFieldNames ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateInsuranceResponse clone() => CreateInsuranceResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateInsuranceResponse copyWith(void Function(CreateInsuranceResponse) updates) => super.copyWith((message) => updates(message as CreateInsuranceResponse)) as CreateInsuranceResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateInsuranceResponse create() => CreateInsuranceResponse._();
  CreateInsuranceResponse createEmptyInstance() => create();
  static $pb.PbList<CreateInsuranceResponse> createRepeated() => $pb.PbList<CreateInsuranceResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateInsuranceResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateInsuranceResponse>(create);
  static CreateInsuranceResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Insurance get insurance => $_getN(0);
  @$pb.TagNumber(1)
  set insurance(Insurance v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasInsurance() => $_has(0);
  @$pb.TagNumber(1)
  void clearInsurance() => clearField(1);
  @$pb.TagNumber(1)
  Insurance ensureInsurance() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get msg => $_getSZ(2);
  @$pb.TagNumber(3)
  set msg($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMsg() => $_has(2);
  @$pb.TagNumber(3)
  void clearMsg() => clearField(3);
}

class UpdateInsuranceRequest extends $pb.GeneratedMessage {
  factory UpdateInsuranceRequest({
    Insurance? insurance,
  }) {
    final $result = create();
    if (insurance != null) {
      $result.insurance = insurance;
    }
    return $result;
  }
  UpdateInsuranceRequest._() : super();
  factory UpdateInsuranceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateInsuranceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateInsuranceRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<Insurance>(1, _omitFieldNames ? '' : 'insurance', subBuilder: Insurance.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateInsuranceRequest clone() => UpdateInsuranceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateInsuranceRequest copyWith(void Function(UpdateInsuranceRequest) updates) => super.copyWith((message) => updates(message as UpdateInsuranceRequest)) as UpdateInsuranceRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateInsuranceRequest create() => UpdateInsuranceRequest._();
  UpdateInsuranceRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateInsuranceRequest> createRepeated() => $pb.PbList<UpdateInsuranceRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateInsuranceRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateInsuranceRequest>(create);
  static UpdateInsuranceRequest? _defaultInstance;

  @$pb.TagNumber(1)
  Insurance get insurance => $_getN(0);
  @$pb.TagNumber(1)
  set insurance(Insurance v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasInsurance() => $_has(0);
  @$pb.TagNumber(1)
  void clearInsurance() => clearField(1);
  @$pb.TagNumber(1)
  Insurance ensureInsurance() => $_ensure(0);
}

class UpdateInsuranceResponse extends $pb.GeneratedMessage {
  factory UpdateInsuranceResponse({
    Insurance? insurance,
    $core.bool? success,
    $core.String? msg,
  }) {
    final $result = create();
    if (insurance != null) {
      $result.insurance = insurance;
    }
    if (success != null) {
      $result.success = success;
    }
    if (msg != null) {
      $result.msg = msg;
    }
    return $result;
  }
  UpdateInsuranceResponse._() : super();
  factory UpdateInsuranceResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateInsuranceResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateInsuranceResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<Insurance>(1, _omitFieldNames ? '' : 'insurance', subBuilder: Insurance.create)
    ..aOB(2, _omitFieldNames ? '' : 'success')
    ..aOS(3, _omitFieldNames ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateInsuranceResponse clone() => UpdateInsuranceResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateInsuranceResponse copyWith(void Function(UpdateInsuranceResponse) updates) => super.copyWith((message) => updates(message as UpdateInsuranceResponse)) as UpdateInsuranceResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateInsuranceResponse create() => UpdateInsuranceResponse._();
  UpdateInsuranceResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateInsuranceResponse> createRepeated() => $pb.PbList<UpdateInsuranceResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateInsuranceResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateInsuranceResponse>(create);
  static UpdateInsuranceResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Insurance get insurance => $_getN(0);
  @$pb.TagNumber(1)
  set insurance(Insurance v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasInsurance() => $_has(0);
  @$pb.TagNumber(1)
  void clearInsurance() => clearField(1);
  @$pb.TagNumber(1)
  Insurance ensureInsurance() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get msg => $_getSZ(2);
  @$pb.TagNumber(3)
  set msg($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMsg() => $_has(2);
  @$pb.TagNumber(3)
  void clearMsg() => clearField(3);
}

class DeleteInsuranceRequest extends $pb.GeneratedMessage {
  factory DeleteInsuranceRequest({
    $core.String? id,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    return $result;
  }
  DeleteInsuranceRequest._() : super();
  factory DeleteInsuranceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteInsuranceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DeleteInsuranceRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteInsuranceRequest clone() => DeleteInsuranceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteInsuranceRequest copyWith(void Function(DeleteInsuranceRequest) updates) => super.copyWith((message) => updates(message as DeleteInsuranceRequest)) as DeleteInsuranceRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteInsuranceRequest create() => DeleteInsuranceRequest._();
  DeleteInsuranceRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteInsuranceRequest> createRepeated() => $pb.PbList<DeleteInsuranceRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteInsuranceRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteInsuranceRequest>(create);
  static DeleteInsuranceRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);
}

class DeleteInsuranceResponse extends $pb.GeneratedMessage {
  factory DeleteInsuranceResponse({
    $core.bool? success,
    $core.String? msg,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (msg != null) {
      $result.msg = msg;
    }
    return $result;
  }
  DeleteInsuranceResponse._() : super();
  factory DeleteInsuranceResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteInsuranceResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DeleteInsuranceResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteInsuranceResponse clone() => DeleteInsuranceResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteInsuranceResponse copyWith(void Function(DeleteInsuranceResponse) updates) => super.copyWith((message) => updates(message as DeleteInsuranceResponse)) as DeleteInsuranceResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteInsuranceResponse create() => DeleteInsuranceResponse._();
  DeleteInsuranceResponse createEmptyInstance() => create();
  static $pb.PbList<DeleteInsuranceResponse> createRepeated() => $pb.PbList<DeleteInsuranceResponse>();
  @$core.pragma('dart2js:noInline')
  static DeleteInsuranceResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteInsuranceResponse>(create);
  static DeleteInsuranceResponse? _defaultInstance;

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

class SearchInsurancesRequest extends $pb.GeneratedMessage {
  factory SearchInsurancesRequest({
    $core.String? query,
    $core.int? page,
    $core.int? limit,
  }) {
    final $result = create();
    if (query != null) {
      $result.query = query;
    }
    if (page != null) {
      $result.page = page;
    }
    if (limit != null) {
      $result.limit = limit;
    }
    return $result;
  }
  SearchInsurancesRequest._() : super();
  factory SearchInsurancesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SearchInsurancesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SearchInsurancesRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'query')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SearchInsurancesRequest clone() => SearchInsurancesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SearchInsurancesRequest copyWith(void Function(SearchInsurancesRequest) updates) => super.copyWith((message) => updates(message as SearchInsurancesRequest)) as SearchInsurancesRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SearchInsurancesRequest create() => SearchInsurancesRequest._();
  SearchInsurancesRequest createEmptyInstance() => create();
  static $pb.PbList<SearchInsurancesRequest> createRepeated() => $pb.PbList<SearchInsurancesRequest>();
  @$core.pragma('dart2js:noInline')
  static SearchInsurancesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SearchInsurancesRequest>(create);
  static SearchInsurancesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get query => $_getSZ(0);
  @$pb.TagNumber(1)
  set query($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasQuery() => $_has(0);
  @$pb.TagNumber(1)
  void clearQuery() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get page => $_getIZ(1);
  @$pb.TagNumber(2)
  set page($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPage() => $_has(1);
  @$pb.TagNumber(2)
  void clearPage() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get limit => $_getIZ(2);
  @$pb.TagNumber(3)
  set limit($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasLimit() => $_has(2);
  @$pb.TagNumber(3)
  void clearLimit() => clearField(3);
}

class SearchInsurancesResponse extends $pb.GeneratedMessage {
  factory SearchInsurancesResponse({
    $core.Iterable<Insurance>? insurances,
    InsurancePaginationInfo? pagination,
    $core.bool? success,
    $core.String? msg,
  }) {
    final $result = create();
    if (insurances != null) {
      $result.insurances.addAll(insurances);
    }
    if (pagination != null) {
      $result.pagination = pagination;
    }
    if (success != null) {
      $result.success = success;
    }
    if (msg != null) {
      $result.msg = msg;
    }
    return $result;
  }
  SearchInsurancesResponse._() : super();
  factory SearchInsurancesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SearchInsurancesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SearchInsurancesResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<Insurance>(1, _omitFieldNames ? '' : 'insurances', $pb.PbFieldType.PM, subBuilder: Insurance.create)
    ..aOM<InsurancePaginationInfo>(2, _omitFieldNames ? '' : 'pagination', subBuilder: InsurancePaginationInfo.create)
    ..aOB(3, _omitFieldNames ? '' : 'success')
    ..aOS(4, _omitFieldNames ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SearchInsurancesResponse clone() => SearchInsurancesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SearchInsurancesResponse copyWith(void Function(SearchInsurancesResponse) updates) => super.copyWith((message) => updates(message as SearchInsurancesResponse)) as SearchInsurancesResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SearchInsurancesResponse create() => SearchInsurancesResponse._();
  SearchInsurancesResponse createEmptyInstance() => create();
  static $pb.PbList<SearchInsurancesResponse> createRepeated() => $pb.PbList<SearchInsurancesResponse>();
  @$core.pragma('dart2js:noInline')
  static SearchInsurancesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SearchInsurancesResponse>(create);
  static SearchInsurancesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Insurance> get insurances => $_getList(0);

  @$pb.TagNumber(2)
  InsurancePaginationInfo get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination(InsurancePaginationInfo v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => clearField(2);
  @$pb.TagNumber(2)
  InsurancePaginationInfo ensurePagination() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.bool get success => $_getBF(2);
  @$pb.TagNumber(3)
  set success($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSuccess() => $_has(2);
  @$pb.TagNumber(3)
  void clearSuccess() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get msg => $_getSZ(3);
  @$pb.TagNumber(4)
  set msg($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMsg() => $_has(3);
  @$pb.TagNumber(4)
  void clearMsg() => clearField(4);
}

/// Payment Management
class GetInsurancePaymentsRequest extends $pb.GeneratedMessage {
  factory GetInsurancePaymentsRequest({
    $core.String? insuranceId,
    $core.int? page,
    $core.int? limit,
  }) {
    final $result = create();
    if (insuranceId != null) {
      $result.insuranceId = insuranceId;
    }
    if (page != null) {
      $result.page = page;
    }
    if (limit != null) {
      $result.limit = limit;
    }
    return $result;
  }
  GetInsurancePaymentsRequest._() : super();
  factory GetInsurancePaymentsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInsurancePaymentsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetInsurancePaymentsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'insuranceId')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInsurancePaymentsRequest clone() => GetInsurancePaymentsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInsurancePaymentsRequest copyWith(void Function(GetInsurancePaymentsRequest) updates) => super.copyWith((message) => updates(message as GetInsurancePaymentsRequest)) as GetInsurancePaymentsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInsurancePaymentsRequest create() => GetInsurancePaymentsRequest._();
  GetInsurancePaymentsRequest createEmptyInstance() => create();
  static $pb.PbList<GetInsurancePaymentsRequest> createRepeated() => $pb.PbList<GetInsurancePaymentsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInsurancePaymentsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInsurancePaymentsRequest>(create);
  static GetInsurancePaymentsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get insuranceId => $_getSZ(0);
  @$pb.TagNumber(1)
  set insuranceId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasInsuranceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearInsuranceId() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get page => $_getIZ(1);
  @$pb.TagNumber(2)
  set page($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPage() => $_has(1);
  @$pb.TagNumber(2)
  void clearPage() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get limit => $_getIZ(2);
  @$pb.TagNumber(3)
  set limit($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasLimit() => $_has(2);
  @$pb.TagNumber(3)
  void clearLimit() => clearField(3);
}

class GetInsurancePaymentsResponse extends $pb.GeneratedMessage {
  factory GetInsurancePaymentsResponse({
    $core.Iterable<InsurancePayment>? payments,
    InsurancePaginationInfo? pagination,
    $core.bool? success,
    $core.String? msg,
  }) {
    final $result = create();
    if (payments != null) {
      $result.payments.addAll(payments);
    }
    if (pagination != null) {
      $result.pagination = pagination;
    }
    if (success != null) {
      $result.success = success;
    }
    if (msg != null) {
      $result.msg = msg;
    }
    return $result;
  }
  GetInsurancePaymentsResponse._() : super();
  factory GetInsurancePaymentsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInsurancePaymentsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetInsurancePaymentsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<InsurancePayment>(1, _omitFieldNames ? '' : 'payments', $pb.PbFieldType.PM, subBuilder: InsurancePayment.create)
    ..aOM<InsurancePaginationInfo>(2, _omitFieldNames ? '' : 'pagination', subBuilder: InsurancePaginationInfo.create)
    ..aOB(3, _omitFieldNames ? '' : 'success')
    ..aOS(4, _omitFieldNames ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInsurancePaymentsResponse clone() => GetInsurancePaymentsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInsurancePaymentsResponse copyWith(void Function(GetInsurancePaymentsResponse) updates) => super.copyWith((message) => updates(message as GetInsurancePaymentsResponse)) as GetInsurancePaymentsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInsurancePaymentsResponse create() => GetInsurancePaymentsResponse._();
  GetInsurancePaymentsResponse createEmptyInstance() => create();
  static $pb.PbList<GetInsurancePaymentsResponse> createRepeated() => $pb.PbList<GetInsurancePaymentsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInsurancePaymentsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInsurancePaymentsResponse>(create);
  static GetInsurancePaymentsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<InsurancePayment> get payments => $_getList(0);

  @$pb.TagNumber(2)
  InsurancePaginationInfo get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination(InsurancePaginationInfo v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => clearField(2);
  @$pb.TagNumber(2)
  InsurancePaginationInfo ensurePagination() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.bool get success => $_getBF(2);
  @$pb.TagNumber(3)
  set success($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSuccess() => $_has(2);
  @$pb.TagNumber(3)
  void clearSuccess() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get msg => $_getSZ(3);
  @$pb.TagNumber(4)
  set msg($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMsg() => $_has(3);
  @$pb.TagNumber(4)
  void clearMsg() => clearField(4);
}

class GetUserPaymentsRequest extends $pb.GeneratedMessage {
  factory GetUserPaymentsRequest({
    $core.int? page,
    $core.int? limit,
  }) {
    final $result = create();
    if (page != null) {
      $result.page = page;
    }
    if (limit != null) {
      $result.limit = limit;
    }
    return $result;
  }
  GetUserPaymentsRequest._() : super();
  factory GetUserPaymentsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserPaymentsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetUserPaymentsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUserPaymentsRequest clone() => GetUserPaymentsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUserPaymentsRequest copyWith(void Function(GetUserPaymentsRequest) updates) => super.copyWith((message) => updates(message as GetUserPaymentsRequest)) as GetUserPaymentsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserPaymentsRequest create() => GetUserPaymentsRequest._();
  GetUserPaymentsRequest createEmptyInstance() => create();
  static $pb.PbList<GetUserPaymentsRequest> createRepeated() => $pb.PbList<GetUserPaymentsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetUserPaymentsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetUserPaymentsRequest>(create);
  static GetUserPaymentsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get page => $_getIZ(0);
  @$pb.TagNumber(1)
  set page($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearPage() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get limit => $_getIZ(1);
  @$pb.TagNumber(2)
  set limit($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => clearField(2);
}

class GetUserPaymentsResponse extends $pb.GeneratedMessage {
  factory GetUserPaymentsResponse({
    $core.Iterable<InsurancePayment>? payments,
    InsurancePaginationInfo? pagination,
    $core.bool? success,
    $core.String? msg,
  }) {
    final $result = create();
    if (payments != null) {
      $result.payments.addAll(payments);
    }
    if (pagination != null) {
      $result.pagination = pagination;
    }
    if (success != null) {
      $result.success = success;
    }
    if (msg != null) {
      $result.msg = msg;
    }
    return $result;
  }
  GetUserPaymentsResponse._() : super();
  factory GetUserPaymentsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserPaymentsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetUserPaymentsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<InsurancePayment>(1, _omitFieldNames ? '' : 'payments', $pb.PbFieldType.PM, subBuilder: InsurancePayment.create)
    ..aOM<InsurancePaginationInfo>(2, _omitFieldNames ? '' : 'pagination', subBuilder: InsurancePaginationInfo.create)
    ..aOB(3, _omitFieldNames ? '' : 'success')
    ..aOS(4, _omitFieldNames ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUserPaymentsResponse clone() => GetUserPaymentsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUserPaymentsResponse copyWith(void Function(GetUserPaymentsResponse) updates) => super.copyWith((message) => updates(message as GetUserPaymentsResponse)) as GetUserPaymentsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserPaymentsResponse create() => GetUserPaymentsResponse._();
  GetUserPaymentsResponse createEmptyInstance() => create();
  static $pb.PbList<GetUserPaymentsResponse> createRepeated() => $pb.PbList<GetUserPaymentsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetUserPaymentsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetUserPaymentsResponse>(create);
  static GetUserPaymentsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<InsurancePayment> get payments => $_getList(0);

  @$pb.TagNumber(2)
  InsurancePaginationInfo get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination(InsurancePaginationInfo v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => clearField(2);
  @$pb.TagNumber(2)
  InsurancePaginationInfo ensurePagination() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.bool get success => $_getBF(2);
  @$pb.TagNumber(3)
  set success($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSuccess() => $_has(2);
  @$pb.TagNumber(3)
  void clearSuccess() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get msg => $_getSZ(3);
  @$pb.TagNumber(4)
  set msg($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMsg() => $_has(3);
  @$pb.TagNumber(4)
  void clearMsg() => clearField(4);
}

class CreatePaymentRequest extends $pb.GeneratedMessage {
  factory CreatePaymentRequest({
    InsurancePayment? payment,
  }) {
    final $result = create();
    if (payment != null) {
      $result.payment = payment;
    }
    return $result;
  }
  CreatePaymentRequest._() : super();
  factory CreatePaymentRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreatePaymentRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreatePaymentRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<InsurancePayment>(1, _omitFieldNames ? '' : 'payment', subBuilder: InsurancePayment.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreatePaymentRequest clone() => CreatePaymentRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreatePaymentRequest copyWith(void Function(CreatePaymentRequest) updates) => super.copyWith((message) => updates(message as CreatePaymentRequest)) as CreatePaymentRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreatePaymentRequest create() => CreatePaymentRequest._();
  CreatePaymentRequest createEmptyInstance() => create();
  static $pb.PbList<CreatePaymentRequest> createRepeated() => $pb.PbList<CreatePaymentRequest>();
  @$core.pragma('dart2js:noInline')
  static CreatePaymentRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreatePaymentRequest>(create);
  static CreatePaymentRequest? _defaultInstance;

  @$pb.TagNumber(1)
  InsurancePayment get payment => $_getN(0);
  @$pb.TagNumber(1)
  set payment(InsurancePayment v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasPayment() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayment() => clearField(1);
  @$pb.TagNumber(1)
  InsurancePayment ensurePayment() => $_ensure(0);
}

class CreatePaymentResponse extends $pb.GeneratedMessage {
  factory CreatePaymentResponse({
    InsurancePayment? payment,
    $core.bool? success,
    $core.String? msg,
  }) {
    final $result = create();
    if (payment != null) {
      $result.payment = payment;
    }
    if (success != null) {
      $result.success = success;
    }
    if (msg != null) {
      $result.msg = msg;
    }
    return $result;
  }
  CreatePaymentResponse._() : super();
  factory CreatePaymentResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreatePaymentResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreatePaymentResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<InsurancePayment>(1, _omitFieldNames ? '' : 'payment', subBuilder: InsurancePayment.create)
    ..aOB(2, _omitFieldNames ? '' : 'success')
    ..aOS(3, _omitFieldNames ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreatePaymentResponse clone() => CreatePaymentResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreatePaymentResponse copyWith(void Function(CreatePaymentResponse) updates) => super.copyWith((message) => updates(message as CreatePaymentResponse)) as CreatePaymentResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreatePaymentResponse create() => CreatePaymentResponse._();
  CreatePaymentResponse createEmptyInstance() => create();
  static $pb.PbList<CreatePaymentResponse> createRepeated() => $pb.PbList<CreatePaymentResponse>();
  @$core.pragma('dart2js:noInline')
  static CreatePaymentResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreatePaymentResponse>(create);
  static CreatePaymentResponse? _defaultInstance;

  @$pb.TagNumber(1)
  InsurancePayment get payment => $_getN(0);
  @$pb.TagNumber(1)
  set payment(InsurancePayment v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasPayment() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayment() => clearField(1);
  @$pb.TagNumber(1)
  InsurancePayment ensurePayment() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get msg => $_getSZ(2);
  @$pb.TagNumber(3)
  set msg($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMsg() => $_has(2);
  @$pb.TagNumber(3)
  void clearMsg() => clearField(3);
}

class ProcessPaymentRequest extends $pb.GeneratedMessage {
  factory ProcessPaymentRequest({
    $core.String? paymentId,
    $core.String? paymentMethod,
    $core.Map<$core.String, $core.String>? paymentDetails,
  }) {
    final $result = create();
    if (paymentId != null) {
      $result.paymentId = paymentId;
    }
    if (paymentMethod != null) {
      $result.paymentMethod = paymentMethod;
    }
    if (paymentDetails != null) {
      $result.paymentDetails.addAll(paymentDetails);
    }
    return $result;
  }
  ProcessPaymentRequest._() : super();
  factory ProcessPaymentRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProcessPaymentRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ProcessPaymentRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'paymentId')
    ..aOS(2, _omitFieldNames ? '' : 'paymentMethod')
    ..m<$core.String, $core.String>(3, _omitFieldNames ? '' : 'paymentDetails', entryClassName: 'ProcessPaymentRequest.PaymentDetailsEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('pb'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProcessPaymentRequest clone() => ProcessPaymentRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProcessPaymentRequest copyWith(void Function(ProcessPaymentRequest) updates) => super.copyWith((message) => updates(message as ProcessPaymentRequest)) as ProcessPaymentRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProcessPaymentRequest create() => ProcessPaymentRequest._();
  ProcessPaymentRequest createEmptyInstance() => create();
  static $pb.PbList<ProcessPaymentRequest> createRepeated() => $pb.PbList<ProcessPaymentRequest>();
  @$core.pragma('dart2js:noInline')
  static ProcessPaymentRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProcessPaymentRequest>(create);
  static ProcessPaymentRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get paymentId => $_getSZ(0);
  @$pb.TagNumber(1)
  set paymentId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPaymentId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPaymentId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get paymentMethod => $_getSZ(1);
  @$pb.TagNumber(2)
  set paymentMethod($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPaymentMethod() => $_has(1);
  @$pb.TagNumber(2)
  void clearPaymentMethod() => clearField(2);

  @$pb.TagNumber(3)
  $core.Map<$core.String, $core.String> get paymentDetails => $_getMap(2);
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
    final $result = create();
    if (payment != null) {
      $result.payment = payment;
    }
    if (transactionId != null) {
      $result.transactionId = transactionId;
    }
    if (referenceNumber != null) {
      $result.referenceNumber = referenceNumber;
    }
    if (receiptUrl != null) {
      $result.receiptUrl = receiptUrl;
    }
    if (success != null) {
      $result.success = success;
    }
    if (msg != null) {
      $result.msg = msg;
    }
    return $result;
  }
  ProcessPaymentResponse._() : super();
  factory ProcessPaymentResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProcessPaymentResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ProcessPaymentResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<InsurancePayment>(1, _omitFieldNames ? '' : 'payment', subBuilder: InsurancePayment.create)
    ..aOS(2, _omitFieldNames ? '' : 'transactionId')
    ..aOS(3, _omitFieldNames ? '' : 'referenceNumber')
    ..aOS(4, _omitFieldNames ? '' : 'receiptUrl')
    ..aOB(5, _omitFieldNames ? '' : 'success')
    ..aOS(6, _omitFieldNames ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProcessPaymentResponse clone() => ProcessPaymentResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProcessPaymentResponse copyWith(void Function(ProcessPaymentResponse) updates) => super.copyWith((message) => updates(message as ProcessPaymentResponse)) as ProcessPaymentResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProcessPaymentResponse create() => ProcessPaymentResponse._();
  ProcessPaymentResponse createEmptyInstance() => create();
  static $pb.PbList<ProcessPaymentResponse> createRepeated() => $pb.PbList<ProcessPaymentResponse>();
  @$core.pragma('dart2js:noInline')
  static ProcessPaymentResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProcessPaymentResponse>(create);
  static ProcessPaymentResponse? _defaultInstance;

  @$pb.TagNumber(1)
  InsurancePayment get payment => $_getN(0);
  @$pb.TagNumber(1)
  set payment(InsurancePayment v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasPayment() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayment() => clearField(1);
  @$pb.TagNumber(1)
  InsurancePayment ensurePayment() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get transactionId => $_getSZ(1);
  @$pb.TagNumber(2)
  set transactionId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTransactionId() => $_has(1);
  @$pb.TagNumber(2)
  void clearTransactionId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get referenceNumber => $_getSZ(2);
  @$pb.TagNumber(3)
  set referenceNumber($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasReferenceNumber() => $_has(2);
  @$pb.TagNumber(3)
  void clearReferenceNumber() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get receiptUrl => $_getSZ(3);
  @$pb.TagNumber(4)
  set receiptUrl($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasReceiptUrl() => $_has(3);
  @$pb.TagNumber(4)
  void clearReceiptUrl() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get success => $_getBF(4);
  @$pb.TagNumber(5)
  set success($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasSuccess() => $_has(4);
  @$pb.TagNumber(5)
  void clearSuccess() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get msg => $_getSZ(5);
  @$pb.TagNumber(6)
  set msg($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasMsg() => $_has(5);
  @$pb.TagNumber(6)
  void clearMsg() => clearField(6);
}

class GetPaymentByIdRequest extends $pb.GeneratedMessage {
  factory GetPaymentByIdRequest({
    $core.String? id,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    return $result;
  }
  GetPaymentByIdRequest._() : super();
  factory GetPaymentByIdRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPaymentByIdRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetPaymentByIdRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPaymentByIdRequest clone() => GetPaymentByIdRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPaymentByIdRequest copyWith(void Function(GetPaymentByIdRequest) updates) => super.copyWith((message) => updates(message as GetPaymentByIdRequest)) as GetPaymentByIdRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPaymentByIdRequest create() => GetPaymentByIdRequest._();
  GetPaymentByIdRequest createEmptyInstance() => create();
  static $pb.PbList<GetPaymentByIdRequest> createRepeated() => $pb.PbList<GetPaymentByIdRequest>();
  @$core.pragma('dart2js:noInline')
  static GetPaymentByIdRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetPaymentByIdRequest>(create);
  static GetPaymentByIdRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);
}

class GetPaymentByIdResponse extends $pb.GeneratedMessage {
  factory GetPaymentByIdResponse({
    InsurancePayment? payment,
    $core.bool? success,
    $core.String? msg,
  }) {
    final $result = create();
    if (payment != null) {
      $result.payment = payment;
    }
    if (success != null) {
      $result.success = success;
    }
    if (msg != null) {
      $result.msg = msg;
    }
    return $result;
  }
  GetPaymentByIdResponse._() : super();
  factory GetPaymentByIdResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPaymentByIdResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetPaymentByIdResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<InsurancePayment>(1, _omitFieldNames ? '' : 'payment', subBuilder: InsurancePayment.create)
    ..aOB(2, _omitFieldNames ? '' : 'success')
    ..aOS(3, _omitFieldNames ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPaymentByIdResponse clone() => GetPaymentByIdResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPaymentByIdResponse copyWith(void Function(GetPaymentByIdResponse) updates) => super.copyWith((message) => updates(message as GetPaymentByIdResponse)) as GetPaymentByIdResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPaymentByIdResponse create() => GetPaymentByIdResponse._();
  GetPaymentByIdResponse createEmptyInstance() => create();
  static $pb.PbList<GetPaymentByIdResponse> createRepeated() => $pb.PbList<GetPaymentByIdResponse>();
  @$core.pragma('dart2js:noInline')
  static GetPaymentByIdResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetPaymentByIdResponse>(create);
  static GetPaymentByIdResponse? _defaultInstance;

  @$pb.TagNumber(1)
  InsurancePayment get payment => $_getN(0);
  @$pb.TagNumber(1)
  set payment(InsurancePayment v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasPayment() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayment() => clearField(1);
  @$pb.TagNumber(1)
  InsurancePayment ensurePayment() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get msg => $_getSZ(2);
  @$pb.TagNumber(3)
  set msg($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMsg() => $_has(2);
  @$pb.TagNumber(3)
  void clearMsg() => clearField(3);
}

class GetOverduePaymentsRequest extends $pb.GeneratedMessage {
  factory GetOverduePaymentsRequest() => create();
  GetOverduePaymentsRequest._() : super();
  factory GetOverduePaymentsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetOverduePaymentsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetOverduePaymentsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetOverduePaymentsRequest clone() => GetOverduePaymentsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetOverduePaymentsRequest copyWith(void Function(GetOverduePaymentsRequest) updates) => super.copyWith((message) => updates(message as GetOverduePaymentsRequest)) as GetOverduePaymentsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetOverduePaymentsRequest create() => GetOverduePaymentsRequest._();
  GetOverduePaymentsRequest createEmptyInstance() => create();
  static $pb.PbList<GetOverduePaymentsRequest> createRepeated() => $pb.PbList<GetOverduePaymentsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetOverduePaymentsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetOverduePaymentsRequest>(create);
  static GetOverduePaymentsRequest? _defaultInstance;
}

class GetOverduePaymentsResponse extends $pb.GeneratedMessage {
  factory GetOverduePaymentsResponse({
    $core.Iterable<InsurancePayment>? payments,
    $core.bool? success,
    $core.String? msg,
  }) {
    final $result = create();
    if (payments != null) {
      $result.payments.addAll(payments);
    }
    if (success != null) {
      $result.success = success;
    }
    if (msg != null) {
      $result.msg = msg;
    }
    return $result;
  }
  GetOverduePaymentsResponse._() : super();
  factory GetOverduePaymentsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetOverduePaymentsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetOverduePaymentsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<InsurancePayment>(1, _omitFieldNames ? '' : 'payments', $pb.PbFieldType.PM, subBuilder: InsurancePayment.create)
    ..aOB(2, _omitFieldNames ? '' : 'success')
    ..aOS(3, _omitFieldNames ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetOverduePaymentsResponse clone() => GetOverduePaymentsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetOverduePaymentsResponse copyWith(void Function(GetOverduePaymentsResponse) updates) => super.copyWith((message) => updates(message as GetOverduePaymentsResponse)) as GetOverduePaymentsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetOverduePaymentsResponse create() => GetOverduePaymentsResponse._();
  GetOverduePaymentsResponse createEmptyInstance() => create();
  static $pb.PbList<GetOverduePaymentsResponse> createRepeated() => $pb.PbList<GetOverduePaymentsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetOverduePaymentsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetOverduePaymentsResponse>(create);
  static GetOverduePaymentsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<InsurancePayment> get payments => $_getList(0);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get msg => $_getSZ(2);
  @$pb.TagNumber(3)
  set msg($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMsg() => $_has(2);
  @$pb.TagNumber(3)
  void clearMsg() => clearField(3);
}

/// Claims Management
class GetInsuranceClaimsRequest extends $pb.GeneratedMessage {
  factory GetInsuranceClaimsRequest({
    $core.String? insuranceId,
    $core.int? page,
    $core.int? limit,
  }) {
    final $result = create();
    if (insuranceId != null) {
      $result.insuranceId = insuranceId;
    }
    if (page != null) {
      $result.page = page;
    }
    if (limit != null) {
      $result.limit = limit;
    }
    return $result;
  }
  GetInsuranceClaimsRequest._() : super();
  factory GetInsuranceClaimsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInsuranceClaimsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetInsuranceClaimsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'insuranceId')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInsuranceClaimsRequest clone() => GetInsuranceClaimsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInsuranceClaimsRequest copyWith(void Function(GetInsuranceClaimsRequest) updates) => super.copyWith((message) => updates(message as GetInsuranceClaimsRequest)) as GetInsuranceClaimsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInsuranceClaimsRequest create() => GetInsuranceClaimsRequest._();
  GetInsuranceClaimsRequest createEmptyInstance() => create();
  static $pb.PbList<GetInsuranceClaimsRequest> createRepeated() => $pb.PbList<GetInsuranceClaimsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInsuranceClaimsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInsuranceClaimsRequest>(create);
  static GetInsuranceClaimsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get insuranceId => $_getSZ(0);
  @$pb.TagNumber(1)
  set insuranceId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasInsuranceId() => $_has(0);
  @$pb.TagNumber(1)
  void clearInsuranceId() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get page => $_getIZ(1);
  @$pb.TagNumber(2)
  set page($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPage() => $_has(1);
  @$pb.TagNumber(2)
  void clearPage() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get limit => $_getIZ(2);
  @$pb.TagNumber(3)
  set limit($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasLimit() => $_has(2);
  @$pb.TagNumber(3)
  void clearLimit() => clearField(3);
}

class GetInsuranceClaimsResponse extends $pb.GeneratedMessage {
  factory GetInsuranceClaimsResponse({
    $core.Iterable<InsuranceClaim>? claims,
    InsurancePaginationInfo? pagination,
    $core.bool? success,
    $core.String? msg,
  }) {
    final $result = create();
    if (claims != null) {
      $result.claims.addAll(claims);
    }
    if (pagination != null) {
      $result.pagination = pagination;
    }
    if (success != null) {
      $result.success = success;
    }
    if (msg != null) {
      $result.msg = msg;
    }
    return $result;
  }
  GetInsuranceClaimsResponse._() : super();
  factory GetInsuranceClaimsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInsuranceClaimsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetInsuranceClaimsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<InsuranceClaim>(1, _omitFieldNames ? '' : 'claims', $pb.PbFieldType.PM, subBuilder: InsuranceClaim.create)
    ..aOM<InsurancePaginationInfo>(2, _omitFieldNames ? '' : 'pagination', subBuilder: InsurancePaginationInfo.create)
    ..aOB(3, _omitFieldNames ? '' : 'success')
    ..aOS(4, _omitFieldNames ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInsuranceClaimsResponse clone() => GetInsuranceClaimsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInsuranceClaimsResponse copyWith(void Function(GetInsuranceClaimsResponse) updates) => super.copyWith((message) => updates(message as GetInsuranceClaimsResponse)) as GetInsuranceClaimsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInsuranceClaimsResponse create() => GetInsuranceClaimsResponse._();
  GetInsuranceClaimsResponse createEmptyInstance() => create();
  static $pb.PbList<GetInsuranceClaimsResponse> createRepeated() => $pb.PbList<GetInsuranceClaimsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInsuranceClaimsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInsuranceClaimsResponse>(create);
  static GetInsuranceClaimsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<InsuranceClaim> get claims => $_getList(0);

  @$pb.TagNumber(2)
  InsurancePaginationInfo get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination(InsurancePaginationInfo v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => clearField(2);
  @$pb.TagNumber(2)
  InsurancePaginationInfo ensurePagination() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.bool get success => $_getBF(2);
  @$pb.TagNumber(3)
  set success($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSuccess() => $_has(2);
  @$pb.TagNumber(3)
  void clearSuccess() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get msg => $_getSZ(3);
  @$pb.TagNumber(4)
  set msg($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMsg() => $_has(3);
  @$pb.TagNumber(4)
  void clearMsg() => clearField(4);
}

class GetUserClaimsRequest extends $pb.GeneratedMessage {
  factory GetUserClaimsRequest({
    $core.int? page,
    $core.int? limit,
  }) {
    final $result = create();
    if (page != null) {
      $result.page = page;
    }
    if (limit != null) {
      $result.limit = limit;
    }
    return $result;
  }
  GetUserClaimsRequest._() : super();
  factory GetUserClaimsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserClaimsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetUserClaimsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUserClaimsRequest clone() => GetUserClaimsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUserClaimsRequest copyWith(void Function(GetUserClaimsRequest) updates) => super.copyWith((message) => updates(message as GetUserClaimsRequest)) as GetUserClaimsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserClaimsRequest create() => GetUserClaimsRequest._();
  GetUserClaimsRequest createEmptyInstance() => create();
  static $pb.PbList<GetUserClaimsRequest> createRepeated() => $pb.PbList<GetUserClaimsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetUserClaimsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetUserClaimsRequest>(create);
  static GetUserClaimsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get page => $_getIZ(0);
  @$pb.TagNumber(1)
  set page($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearPage() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get limit => $_getIZ(1);
  @$pb.TagNumber(2)
  set limit($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => clearField(2);
}

class GetUserClaimsResponse extends $pb.GeneratedMessage {
  factory GetUserClaimsResponse({
    $core.Iterable<InsuranceClaim>? claims,
    InsurancePaginationInfo? pagination,
    $core.bool? success,
    $core.String? msg,
  }) {
    final $result = create();
    if (claims != null) {
      $result.claims.addAll(claims);
    }
    if (pagination != null) {
      $result.pagination = pagination;
    }
    if (success != null) {
      $result.success = success;
    }
    if (msg != null) {
      $result.msg = msg;
    }
    return $result;
  }
  GetUserClaimsResponse._() : super();
  factory GetUserClaimsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserClaimsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetUserClaimsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<InsuranceClaim>(1, _omitFieldNames ? '' : 'claims', $pb.PbFieldType.PM, subBuilder: InsuranceClaim.create)
    ..aOM<InsurancePaginationInfo>(2, _omitFieldNames ? '' : 'pagination', subBuilder: InsurancePaginationInfo.create)
    ..aOB(3, _omitFieldNames ? '' : 'success')
    ..aOS(4, _omitFieldNames ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUserClaimsResponse clone() => GetUserClaimsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUserClaimsResponse copyWith(void Function(GetUserClaimsResponse) updates) => super.copyWith((message) => updates(message as GetUserClaimsResponse)) as GetUserClaimsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserClaimsResponse create() => GetUserClaimsResponse._();
  GetUserClaimsResponse createEmptyInstance() => create();
  static $pb.PbList<GetUserClaimsResponse> createRepeated() => $pb.PbList<GetUserClaimsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetUserClaimsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetUserClaimsResponse>(create);
  static GetUserClaimsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<InsuranceClaim> get claims => $_getList(0);

  @$pb.TagNumber(2)
  InsurancePaginationInfo get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination(InsurancePaginationInfo v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => clearField(2);
  @$pb.TagNumber(2)
  InsurancePaginationInfo ensurePagination() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.bool get success => $_getBF(2);
  @$pb.TagNumber(3)
  set success($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSuccess() => $_has(2);
  @$pb.TagNumber(3)
  void clearSuccess() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get msg => $_getSZ(3);
  @$pb.TagNumber(4)
  set msg($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMsg() => $_has(3);
  @$pb.TagNumber(4)
  void clearMsg() => clearField(4);
}

class CreateClaimRequest extends $pb.GeneratedMessage {
  factory CreateClaimRequest({
    InsuranceClaim? claim,
  }) {
    final $result = create();
    if (claim != null) {
      $result.claim = claim;
    }
    return $result;
  }
  CreateClaimRequest._() : super();
  factory CreateClaimRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateClaimRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateClaimRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<InsuranceClaim>(1, _omitFieldNames ? '' : 'claim', subBuilder: InsuranceClaim.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateClaimRequest clone() => CreateClaimRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateClaimRequest copyWith(void Function(CreateClaimRequest) updates) => super.copyWith((message) => updates(message as CreateClaimRequest)) as CreateClaimRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateClaimRequest create() => CreateClaimRequest._();
  CreateClaimRequest createEmptyInstance() => create();
  static $pb.PbList<CreateClaimRequest> createRepeated() => $pb.PbList<CreateClaimRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateClaimRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateClaimRequest>(create);
  static CreateClaimRequest? _defaultInstance;

  @$pb.TagNumber(1)
  InsuranceClaim get claim => $_getN(0);
  @$pb.TagNumber(1)
  set claim(InsuranceClaim v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasClaim() => $_has(0);
  @$pb.TagNumber(1)
  void clearClaim() => clearField(1);
  @$pb.TagNumber(1)
  InsuranceClaim ensureClaim() => $_ensure(0);
}

class CreateClaimResponse extends $pb.GeneratedMessage {
  factory CreateClaimResponse({
    InsuranceClaim? claim,
    $core.bool? success,
    $core.String? msg,
  }) {
    final $result = create();
    if (claim != null) {
      $result.claim = claim;
    }
    if (success != null) {
      $result.success = success;
    }
    if (msg != null) {
      $result.msg = msg;
    }
    return $result;
  }
  CreateClaimResponse._() : super();
  factory CreateClaimResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateClaimResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateClaimResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<InsuranceClaim>(1, _omitFieldNames ? '' : 'claim', subBuilder: InsuranceClaim.create)
    ..aOB(2, _omitFieldNames ? '' : 'success')
    ..aOS(3, _omitFieldNames ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateClaimResponse clone() => CreateClaimResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateClaimResponse copyWith(void Function(CreateClaimResponse) updates) => super.copyWith((message) => updates(message as CreateClaimResponse)) as CreateClaimResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateClaimResponse create() => CreateClaimResponse._();
  CreateClaimResponse createEmptyInstance() => create();
  static $pb.PbList<CreateClaimResponse> createRepeated() => $pb.PbList<CreateClaimResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateClaimResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateClaimResponse>(create);
  static CreateClaimResponse? _defaultInstance;

  @$pb.TagNumber(1)
  InsuranceClaim get claim => $_getN(0);
  @$pb.TagNumber(1)
  set claim(InsuranceClaim v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasClaim() => $_has(0);
  @$pb.TagNumber(1)
  void clearClaim() => clearField(1);
  @$pb.TagNumber(1)
  InsuranceClaim ensureClaim() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get msg => $_getSZ(2);
  @$pb.TagNumber(3)
  set msg($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMsg() => $_has(2);
  @$pb.TagNumber(3)
  void clearMsg() => clearField(3);
}

class UpdateClaimRequest extends $pb.GeneratedMessage {
  factory UpdateClaimRequest({
    InsuranceClaim? claim,
  }) {
    final $result = create();
    if (claim != null) {
      $result.claim = claim;
    }
    return $result;
  }
  UpdateClaimRequest._() : super();
  factory UpdateClaimRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateClaimRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateClaimRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<InsuranceClaim>(1, _omitFieldNames ? '' : 'claim', subBuilder: InsuranceClaim.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateClaimRequest clone() => UpdateClaimRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateClaimRequest copyWith(void Function(UpdateClaimRequest) updates) => super.copyWith((message) => updates(message as UpdateClaimRequest)) as UpdateClaimRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateClaimRequest create() => UpdateClaimRequest._();
  UpdateClaimRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateClaimRequest> createRepeated() => $pb.PbList<UpdateClaimRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateClaimRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateClaimRequest>(create);
  static UpdateClaimRequest? _defaultInstance;

  @$pb.TagNumber(1)
  InsuranceClaim get claim => $_getN(0);
  @$pb.TagNumber(1)
  set claim(InsuranceClaim v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasClaim() => $_has(0);
  @$pb.TagNumber(1)
  void clearClaim() => clearField(1);
  @$pb.TagNumber(1)
  InsuranceClaim ensureClaim() => $_ensure(0);
}

class UpdateClaimResponse extends $pb.GeneratedMessage {
  factory UpdateClaimResponse({
    InsuranceClaim? claim,
    $core.bool? success,
    $core.String? msg,
  }) {
    final $result = create();
    if (claim != null) {
      $result.claim = claim;
    }
    if (success != null) {
      $result.success = success;
    }
    if (msg != null) {
      $result.msg = msg;
    }
    return $result;
  }
  UpdateClaimResponse._() : super();
  factory UpdateClaimResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateClaimResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateClaimResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<InsuranceClaim>(1, _omitFieldNames ? '' : 'claim', subBuilder: InsuranceClaim.create)
    ..aOB(2, _omitFieldNames ? '' : 'success')
    ..aOS(3, _omitFieldNames ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateClaimResponse clone() => UpdateClaimResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateClaimResponse copyWith(void Function(UpdateClaimResponse) updates) => super.copyWith((message) => updates(message as UpdateClaimResponse)) as UpdateClaimResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateClaimResponse create() => UpdateClaimResponse._();
  UpdateClaimResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateClaimResponse> createRepeated() => $pb.PbList<UpdateClaimResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateClaimResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateClaimResponse>(create);
  static UpdateClaimResponse? _defaultInstance;

  @$pb.TagNumber(1)
  InsuranceClaim get claim => $_getN(0);
  @$pb.TagNumber(1)
  set claim(InsuranceClaim v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasClaim() => $_has(0);
  @$pb.TagNumber(1)
  void clearClaim() => clearField(1);
  @$pb.TagNumber(1)
  InsuranceClaim ensureClaim() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get msg => $_getSZ(2);
  @$pb.TagNumber(3)
  set msg($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMsg() => $_has(2);
  @$pb.TagNumber(3)
  void clearMsg() => clearField(3);
}

class GetClaimByIdRequest extends $pb.GeneratedMessage {
  factory GetClaimByIdRequest({
    $core.String? id,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    return $result;
  }
  GetClaimByIdRequest._() : super();
  factory GetClaimByIdRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetClaimByIdRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetClaimByIdRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetClaimByIdRequest clone() => GetClaimByIdRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetClaimByIdRequest copyWith(void Function(GetClaimByIdRequest) updates) => super.copyWith((message) => updates(message as GetClaimByIdRequest)) as GetClaimByIdRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetClaimByIdRequest create() => GetClaimByIdRequest._();
  GetClaimByIdRequest createEmptyInstance() => create();
  static $pb.PbList<GetClaimByIdRequest> createRepeated() => $pb.PbList<GetClaimByIdRequest>();
  @$core.pragma('dart2js:noInline')
  static GetClaimByIdRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetClaimByIdRequest>(create);
  static GetClaimByIdRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);
}

class GetClaimByIdResponse extends $pb.GeneratedMessage {
  factory GetClaimByIdResponse({
    InsuranceClaim? claim,
    $core.bool? success,
    $core.String? msg,
  }) {
    final $result = create();
    if (claim != null) {
      $result.claim = claim;
    }
    if (success != null) {
      $result.success = success;
    }
    if (msg != null) {
      $result.msg = msg;
    }
    return $result;
  }
  GetClaimByIdResponse._() : super();
  factory GetClaimByIdResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetClaimByIdResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetClaimByIdResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<InsuranceClaim>(1, _omitFieldNames ? '' : 'claim', subBuilder: InsuranceClaim.create)
    ..aOB(2, _omitFieldNames ? '' : 'success')
    ..aOS(3, _omitFieldNames ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetClaimByIdResponse clone() => GetClaimByIdResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetClaimByIdResponse copyWith(void Function(GetClaimByIdResponse) updates) => super.copyWith((message) => updates(message as GetClaimByIdResponse)) as GetClaimByIdResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetClaimByIdResponse create() => GetClaimByIdResponse._();
  GetClaimByIdResponse createEmptyInstance() => create();
  static $pb.PbList<GetClaimByIdResponse> createRepeated() => $pb.PbList<GetClaimByIdResponse>();
  @$core.pragma('dart2js:noInline')
  static GetClaimByIdResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetClaimByIdResponse>(create);
  static GetClaimByIdResponse? _defaultInstance;

  @$pb.TagNumber(1)
  InsuranceClaim get claim => $_getN(0);
  @$pb.TagNumber(1)
  set claim(InsuranceClaim v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasClaim() => $_has(0);
  @$pb.TagNumber(1)
  void clearClaim() => clearField(1);
  @$pb.TagNumber(1)
  InsuranceClaim ensureClaim() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get msg => $_getSZ(2);
  @$pb.TagNumber(3)
  set msg($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMsg() => $_has(2);
  @$pb.TagNumber(3)
  void clearMsg() => clearField(3);
}

/// Receipt Management
class GeneratePaymentReceiptRequest extends $pb.GeneratedMessage {
  factory GeneratePaymentReceiptRequest({
    $core.String? paymentId,
  }) {
    final $result = create();
    if (paymentId != null) {
      $result.paymentId = paymentId;
    }
    return $result;
  }
  GeneratePaymentReceiptRequest._() : super();
  factory GeneratePaymentReceiptRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GeneratePaymentReceiptRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GeneratePaymentReceiptRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'paymentId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GeneratePaymentReceiptRequest clone() => GeneratePaymentReceiptRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GeneratePaymentReceiptRequest copyWith(void Function(GeneratePaymentReceiptRequest) updates) => super.copyWith((message) => updates(message as GeneratePaymentReceiptRequest)) as GeneratePaymentReceiptRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GeneratePaymentReceiptRequest create() => GeneratePaymentReceiptRequest._();
  GeneratePaymentReceiptRequest createEmptyInstance() => create();
  static $pb.PbList<GeneratePaymentReceiptRequest> createRepeated() => $pb.PbList<GeneratePaymentReceiptRequest>();
  @$core.pragma('dart2js:noInline')
  static GeneratePaymentReceiptRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GeneratePaymentReceiptRequest>(create);
  static GeneratePaymentReceiptRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get paymentId => $_getSZ(0);
  @$pb.TagNumber(1)
  set paymentId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPaymentId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPaymentId() => clearField(1);
}

class GeneratePaymentReceiptResponse extends $pb.GeneratedMessage {
  factory GeneratePaymentReceiptResponse({
    $core.String? receiptUrl,
    $core.String? receiptId,
    $core.bool? success,
    $core.String? msg,
  }) {
    final $result = create();
    if (receiptUrl != null) {
      $result.receiptUrl = receiptUrl;
    }
    if (receiptId != null) {
      $result.receiptId = receiptId;
    }
    if (success != null) {
      $result.success = success;
    }
    if (msg != null) {
      $result.msg = msg;
    }
    return $result;
  }
  GeneratePaymentReceiptResponse._() : super();
  factory GeneratePaymentReceiptResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GeneratePaymentReceiptResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GeneratePaymentReceiptResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'receiptUrl')
    ..aOS(2, _omitFieldNames ? '' : 'receiptId')
    ..aOB(3, _omitFieldNames ? '' : 'success')
    ..aOS(4, _omitFieldNames ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GeneratePaymentReceiptResponse clone() => GeneratePaymentReceiptResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GeneratePaymentReceiptResponse copyWith(void Function(GeneratePaymentReceiptResponse) updates) => super.copyWith((message) => updates(message as GeneratePaymentReceiptResponse)) as GeneratePaymentReceiptResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GeneratePaymentReceiptResponse create() => GeneratePaymentReceiptResponse._();
  GeneratePaymentReceiptResponse createEmptyInstance() => create();
  static $pb.PbList<GeneratePaymentReceiptResponse> createRepeated() => $pb.PbList<GeneratePaymentReceiptResponse>();
  @$core.pragma('dart2js:noInline')
  static GeneratePaymentReceiptResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GeneratePaymentReceiptResponse>(create);
  static GeneratePaymentReceiptResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get receiptUrl => $_getSZ(0);
  @$pb.TagNumber(1)
  set receiptUrl($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasReceiptUrl() => $_has(0);
  @$pb.TagNumber(1)
  void clearReceiptUrl() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get receiptId => $_getSZ(1);
  @$pb.TagNumber(2)
  set receiptId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasReceiptId() => $_has(1);
  @$pb.TagNumber(2)
  void clearReceiptId() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get success => $_getBF(2);
  @$pb.TagNumber(3)
  set success($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSuccess() => $_has(2);
  @$pb.TagNumber(3)
  void clearSuccess() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get msg => $_getSZ(3);
  @$pb.TagNumber(4)
  set msg($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMsg() => $_has(3);
  @$pb.TagNumber(4)
  void clearMsg() => clearField(4);
}

class GetUserReceiptsRequest extends $pb.GeneratedMessage {
  factory GetUserReceiptsRequest({
    $core.int? page,
    $core.int? limit,
  }) {
    final $result = create();
    if (page != null) {
      $result.page = page;
    }
    if (limit != null) {
      $result.limit = limit;
    }
    return $result;
  }
  GetUserReceiptsRequest._() : super();
  factory GetUserReceiptsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserReceiptsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetUserReceiptsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUserReceiptsRequest clone() => GetUserReceiptsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUserReceiptsRequest copyWith(void Function(GetUserReceiptsRequest) updates) => super.copyWith((message) => updates(message as GetUserReceiptsRequest)) as GetUserReceiptsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserReceiptsRequest create() => GetUserReceiptsRequest._();
  GetUserReceiptsRequest createEmptyInstance() => create();
  static $pb.PbList<GetUserReceiptsRequest> createRepeated() => $pb.PbList<GetUserReceiptsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetUserReceiptsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetUserReceiptsRequest>(create);
  static GetUserReceiptsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get page => $_getIZ(0);
  @$pb.TagNumber(1)
  set page($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearPage() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get limit => $_getIZ(1);
  @$pb.TagNumber(2)
  set limit($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => clearField(2);
}

class GetUserReceiptsResponse extends $pb.GeneratedMessage {
  factory GetUserReceiptsResponse({
    $core.Iterable<$core.String>? receiptUrls,
    InsurancePaginationInfo? pagination,
    $core.bool? success,
    $core.String? msg,
  }) {
    final $result = create();
    if (receiptUrls != null) {
      $result.receiptUrls.addAll(receiptUrls);
    }
    if (pagination != null) {
      $result.pagination = pagination;
    }
    if (success != null) {
      $result.success = success;
    }
    if (msg != null) {
      $result.msg = msg;
    }
    return $result;
  }
  GetUserReceiptsResponse._() : super();
  factory GetUserReceiptsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserReceiptsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetUserReceiptsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'receiptUrls')
    ..aOM<InsurancePaginationInfo>(2, _omitFieldNames ? '' : 'pagination', subBuilder: InsurancePaginationInfo.create)
    ..aOB(3, _omitFieldNames ? '' : 'success')
    ..aOS(4, _omitFieldNames ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUserReceiptsResponse clone() => GetUserReceiptsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUserReceiptsResponse copyWith(void Function(GetUserReceiptsResponse) updates) => super.copyWith((message) => updates(message as GetUserReceiptsResponse)) as GetUserReceiptsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserReceiptsResponse create() => GetUserReceiptsResponse._();
  GetUserReceiptsResponse createEmptyInstance() => create();
  static $pb.PbList<GetUserReceiptsResponse> createRepeated() => $pb.PbList<GetUserReceiptsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetUserReceiptsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetUserReceiptsResponse>(create);
  static GetUserReceiptsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.String> get receiptUrls => $_getList(0);

  @$pb.TagNumber(2)
  InsurancePaginationInfo get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination(InsurancePaginationInfo v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => clearField(2);
  @$pb.TagNumber(2)
  InsurancePaginationInfo ensurePagination() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.bool get success => $_getBF(2);
  @$pb.TagNumber(3)
  set success($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSuccess() => $_has(2);
  @$pb.TagNumber(3)
  void clearSuccess() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get msg => $_getSZ(3);
  @$pb.TagNumber(4)
  set msg($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMsg() => $_has(3);
  @$pb.TagNumber(4)
  void clearMsg() => clearField(4);
}

/// Statistics
class GetInsuranceStatisticsRequest extends $pb.GeneratedMessage {
  factory GetInsuranceStatisticsRequest() => create();
  GetInsuranceStatisticsRequest._() : super();
  factory GetInsuranceStatisticsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInsuranceStatisticsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetInsuranceStatisticsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInsuranceStatisticsRequest clone() => GetInsuranceStatisticsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInsuranceStatisticsRequest copyWith(void Function(GetInsuranceStatisticsRequest) updates) => super.copyWith((message) => updates(message as GetInsuranceStatisticsRequest)) as GetInsuranceStatisticsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInsuranceStatisticsRequest create() => GetInsuranceStatisticsRequest._();
  GetInsuranceStatisticsRequest createEmptyInstance() => create();
  static $pb.PbList<GetInsuranceStatisticsRequest> createRepeated() => $pb.PbList<GetInsuranceStatisticsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInsuranceStatisticsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInsuranceStatisticsRequest>(create);
  static GetInsuranceStatisticsRequest? _defaultInstance;
}

class GetInsuranceStatisticsResponse extends $pb.GeneratedMessage {
  factory GetInsuranceStatisticsResponse({
    $core.int? totalPolicies,
    $core.int? activePolicies,
    $core.int? expiredPolicies,
    $core.double? totalCoverageAmount,
    $core.double? totalPremiumAmount,
    $core.Map<$core.String, $core.int>? policiesByType,
    $core.bool? success,
    $core.String? msg,
  }) {
    final $result = create();
    if (totalPolicies != null) {
      $result.totalPolicies = totalPolicies;
    }
    if (activePolicies != null) {
      $result.activePolicies = activePolicies;
    }
    if (expiredPolicies != null) {
      $result.expiredPolicies = expiredPolicies;
    }
    if (totalCoverageAmount != null) {
      $result.totalCoverageAmount = totalCoverageAmount;
    }
    if (totalPremiumAmount != null) {
      $result.totalPremiumAmount = totalPremiumAmount;
    }
    if (policiesByType != null) {
      $result.policiesByType.addAll(policiesByType);
    }
    if (success != null) {
      $result.success = success;
    }
    if (msg != null) {
      $result.msg = msg;
    }
    return $result;
  }
  GetInsuranceStatisticsResponse._() : super();
  factory GetInsuranceStatisticsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInsuranceStatisticsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetInsuranceStatisticsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'totalPolicies', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'activePolicies', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'expiredPolicies', $pb.PbFieldType.O3)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'totalCoverageAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(5, _omitFieldNames ? '' : 'totalPremiumAmount', $pb.PbFieldType.OD)
    ..m<$core.String, $core.int>(6, _omitFieldNames ? '' : 'policiesByType', entryClassName: 'GetInsuranceStatisticsResponse.PoliciesByTypeEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.O3, packageName: const $pb.PackageName('pb'))
    ..aOB(7, _omitFieldNames ? '' : 'success')
    ..aOS(8, _omitFieldNames ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInsuranceStatisticsResponse clone() => GetInsuranceStatisticsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInsuranceStatisticsResponse copyWith(void Function(GetInsuranceStatisticsResponse) updates) => super.copyWith((message) => updates(message as GetInsuranceStatisticsResponse)) as GetInsuranceStatisticsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInsuranceStatisticsResponse create() => GetInsuranceStatisticsResponse._();
  GetInsuranceStatisticsResponse createEmptyInstance() => create();
  static $pb.PbList<GetInsuranceStatisticsResponse> createRepeated() => $pb.PbList<GetInsuranceStatisticsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInsuranceStatisticsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInsuranceStatisticsResponse>(create);
  static GetInsuranceStatisticsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get totalPolicies => $_getIZ(0);
  @$pb.TagNumber(1)
  set totalPolicies($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTotalPolicies() => $_has(0);
  @$pb.TagNumber(1)
  void clearTotalPolicies() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get activePolicies => $_getIZ(1);
  @$pb.TagNumber(2)
  set activePolicies($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasActivePolicies() => $_has(1);
  @$pb.TagNumber(2)
  void clearActivePolicies() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get expiredPolicies => $_getIZ(2);
  @$pb.TagNumber(3)
  set expiredPolicies($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasExpiredPolicies() => $_has(2);
  @$pb.TagNumber(3)
  void clearExpiredPolicies() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get totalCoverageAmount => $_getN(3);
  @$pb.TagNumber(4)
  set totalCoverageAmount($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTotalCoverageAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalCoverageAmount() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get totalPremiumAmount => $_getN(4);
  @$pb.TagNumber(5)
  set totalPremiumAmount($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTotalPremiumAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotalPremiumAmount() => clearField(5);

  @$pb.TagNumber(6)
  $core.Map<$core.String, $core.int> get policiesByType => $_getMap(5);

  @$pb.TagNumber(7)
  $core.bool get success => $_getBF(6);
  @$pb.TagNumber(7)
  set success($core.bool v) { $_setBool(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasSuccess() => $_has(6);
  @$pb.TagNumber(7)
  void clearSuccess() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get msg => $_getSZ(7);
  @$pb.TagNumber(8)
  set msg($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasMsg() => $_has(7);
  @$pb.TagNumber(8)
  void clearMsg() => clearField(8);
}

class GetPaymentStatisticsRequest extends $pb.GeneratedMessage {
  factory GetPaymentStatisticsRequest({
    $core.String? startDate,
    $core.String? endDate,
  }) {
    final $result = create();
    if (startDate != null) {
      $result.startDate = startDate;
    }
    if (endDate != null) {
      $result.endDate = endDate;
    }
    return $result;
  }
  GetPaymentStatisticsRequest._() : super();
  factory GetPaymentStatisticsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPaymentStatisticsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetPaymentStatisticsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'startDate')
    ..aOS(2, _omitFieldNames ? '' : 'endDate')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPaymentStatisticsRequest clone() => GetPaymentStatisticsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPaymentStatisticsRequest copyWith(void Function(GetPaymentStatisticsRequest) updates) => super.copyWith((message) => updates(message as GetPaymentStatisticsRequest)) as GetPaymentStatisticsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPaymentStatisticsRequest create() => GetPaymentStatisticsRequest._();
  GetPaymentStatisticsRequest createEmptyInstance() => create();
  static $pb.PbList<GetPaymentStatisticsRequest> createRepeated() => $pb.PbList<GetPaymentStatisticsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetPaymentStatisticsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetPaymentStatisticsRequest>(create);
  static GetPaymentStatisticsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get startDate => $_getSZ(0);
  @$pb.TagNumber(1)
  set startDate($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStartDate() => $_has(0);
  @$pb.TagNumber(1)
  void clearStartDate() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get endDate => $_getSZ(1);
  @$pb.TagNumber(2)
  set endDate($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasEndDate() => $_has(1);
  @$pb.TagNumber(2)
  void clearEndDate() => clearField(2);
}

class GetPaymentStatisticsResponse extends $pb.GeneratedMessage {
  factory GetPaymentStatisticsResponse({
    $core.int? totalPayments,
    $core.int? completedPayments,
    $core.int? pendingPayments,
    $core.int? failedPayments,
    $core.double? totalAmount,
    $core.double? completedAmount,
    $core.Map<$core.String, $core.int>? paymentsByMethod,
    $core.bool? success,
    $core.String? msg,
  }) {
    final $result = create();
    if (totalPayments != null) {
      $result.totalPayments = totalPayments;
    }
    if (completedPayments != null) {
      $result.completedPayments = completedPayments;
    }
    if (pendingPayments != null) {
      $result.pendingPayments = pendingPayments;
    }
    if (failedPayments != null) {
      $result.failedPayments = failedPayments;
    }
    if (totalAmount != null) {
      $result.totalAmount = totalAmount;
    }
    if (completedAmount != null) {
      $result.completedAmount = completedAmount;
    }
    if (paymentsByMethod != null) {
      $result.paymentsByMethod.addAll(paymentsByMethod);
    }
    if (success != null) {
      $result.success = success;
    }
    if (msg != null) {
      $result.msg = msg;
    }
    return $result;
  }
  GetPaymentStatisticsResponse._() : super();
  factory GetPaymentStatisticsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPaymentStatisticsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetPaymentStatisticsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'totalPayments', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'completedPayments', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'pendingPayments', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'failedPayments', $pb.PbFieldType.O3)
    ..a<$core.double>(5, _omitFieldNames ? '' : 'totalAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(6, _omitFieldNames ? '' : 'completedAmount', $pb.PbFieldType.OD)
    ..m<$core.String, $core.int>(7, _omitFieldNames ? '' : 'paymentsByMethod', entryClassName: 'GetPaymentStatisticsResponse.PaymentsByMethodEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.O3, packageName: const $pb.PackageName('pb'))
    ..aOB(8, _omitFieldNames ? '' : 'success')
    ..aOS(9, _omitFieldNames ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPaymentStatisticsResponse clone() => GetPaymentStatisticsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPaymentStatisticsResponse copyWith(void Function(GetPaymentStatisticsResponse) updates) => super.copyWith((message) => updates(message as GetPaymentStatisticsResponse)) as GetPaymentStatisticsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPaymentStatisticsResponse create() => GetPaymentStatisticsResponse._();
  GetPaymentStatisticsResponse createEmptyInstance() => create();
  static $pb.PbList<GetPaymentStatisticsResponse> createRepeated() => $pb.PbList<GetPaymentStatisticsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetPaymentStatisticsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetPaymentStatisticsResponse>(create);
  static GetPaymentStatisticsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get totalPayments => $_getIZ(0);
  @$pb.TagNumber(1)
  set totalPayments($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTotalPayments() => $_has(0);
  @$pb.TagNumber(1)
  void clearTotalPayments() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get completedPayments => $_getIZ(1);
  @$pb.TagNumber(2)
  set completedPayments($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCompletedPayments() => $_has(1);
  @$pb.TagNumber(2)
  void clearCompletedPayments() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get pendingPayments => $_getIZ(2);
  @$pb.TagNumber(3)
  set pendingPayments($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPendingPayments() => $_has(2);
  @$pb.TagNumber(3)
  void clearPendingPayments() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get failedPayments => $_getIZ(3);
  @$pb.TagNumber(4)
  set failedPayments($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasFailedPayments() => $_has(3);
  @$pb.TagNumber(4)
  void clearFailedPayments() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get totalAmount => $_getN(4);
  @$pb.TagNumber(5)
  set totalAmount($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTotalAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotalAmount() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get completedAmount => $_getN(5);
  @$pb.TagNumber(6)
  set completedAmount($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasCompletedAmount() => $_has(5);
  @$pb.TagNumber(6)
  void clearCompletedAmount() => clearField(6);

  @$pb.TagNumber(7)
  $core.Map<$core.String, $core.int> get paymentsByMethod => $_getMap(6);

  @$pb.TagNumber(8)
  $core.bool get success => $_getBF(7);
  @$pb.TagNumber(8)
  set success($core.bool v) { $_setBool(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasSuccess() => $_has(7);
  @$pb.TagNumber(8)
  void clearSuccess() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get msg => $_getSZ(8);
  @$pb.TagNumber(9)
  set msg($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasMsg() => $_has(8);
  @$pb.TagNumber(9)
  void clearMsg() => clearField(9);
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
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (label != null) {
      $result.label = label;
    }
    if (type != null) {
      $result.type = type;
    }
    if (required != null) {
      $result.required = required;
    }
    if (options != null) {
      $result.options.addAll(options);
    }
    if (defaultValue != null) {
      $result.defaultValue = defaultValue;
    }
    if (validationRegex != null) {
      $result.validationRegex = validationRegex;
    }
    if (placeholder != null) {
      $result.placeholder = placeholder;
    }
    if (description != null) {
      $result.description = description;
    }
    return $result;
  }
  InsuranceProductFormField._() : super();
  factory InsuranceProductFormField.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InsuranceProductFormField.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'InsuranceProductFormField', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOS(2, _omitFieldNames ? '' : 'label')
    ..aOS(3, _omitFieldNames ? '' : 'type')
    ..aOB(4, _omitFieldNames ? '' : 'required')
    ..pPS(5, _omitFieldNames ? '' : 'options')
    ..aOS(6, _omitFieldNames ? '' : 'defaultValue')
    ..aOS(7, _omitFieldNames ? '' : 'validationRegex')
    ..aOS(8, _omitFieldNames ? '' : 'placeholder')
    ..aOS(9, _omitFieldNames ? '' : 'description')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InsuranceProductFormField clone() => InsuranceProductFormField()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InsuranceProductFormField copyWith(void Function(InsuranceProductFormField) updates) => super.copyWith((message) => updates(message as InsuranceProductFormField)) as InsuranceProductFormField;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InsuranceProductFormField create() => InsuranceProductFormField._();
  InsuranceProductFormField createEmptyInstance() => create();
  static $pb.PbList<InsuranceProductFormField> createRepeated() => $pb.PbList<InsuranceProductFormField>();
  @$core.pragma('dart2js:noInline')
  static InsuranceProductFormField getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InsuranceProductFormField>(create);
  static InsuranceProductFormField? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get label => $_getSZ(1);
  @$pb.TagNumber(2)
  set label($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLabel() => $_has(1);
  @$pb.TagNumber(2)
  void clearLabel() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get type => $_getSZ(2);
  @$pb.TagNumber(3)
  set type($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasType() => $_has(2);
  @$pb.TagNumber(3)
  void clearType() => clearField(3);

  @$pb.TagNumber(4)
  $core.bool get required => $_getBF(3);
  @$pb.TagNumber(4)
  set required($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasRequired() => $_has(3);
  @$pb.TagNumber(4)
  void clearRequired() => clearField(4);

  @$pb.TagNumber(5)
  $core.List<$core.String> get options => $_getList(4);

  @$pb.TagNumber(6)
  $core.String get defaultValue => $_getSZ(5);
  @$pb.TagNumber(6)
  set defaultValue($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasDefaultValue() => $_has(5);
  @$pb.TagNumber(6)
  void clearDefaultValue() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get validationRegex => $_getSZ(6);
  @$pb.TagNumber(7)
  set validationRegex($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasValidationRegex() => $_has(6);
  @$pb.TagNumber(7)
  void clearValidationRegex() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get placeholder => $_getSZ(7);
  @$pb.TagNumber(8)
  set placeholder($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasPlaceholder() => $_has(7);
  @$pb.TagNumber(8)
  void clearPlaceholder() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get description => $_getSZ(8);
  @$pb.TagNumber(9)
  set description($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasDescription() => $_has(8);
  @$pb.TagNumber(9)
  void clearDescription() => clearField(9);
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
    $core.Map<$core.String, $core.String>? metadata,
    $core.Iterable<InsuranceProductFormField>? formFields,
    $core.bool? isActive,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (name != null) {
      $result.name = name;
    }
    if (description != null) {
      $result.description = description;
    }
    if (category != null) {
      $result.category = category;
    }
    if (providerName != null) {
      $result.providerName = providerName;
    }
    if (providerLogo != null) {
      $result.providerLogo = providerLogo;
    }
    if (minPremium != null) {
      $result.minPremium = minPremium;
    }
    if (maxPremium != null) {
      $result.maxPremium = maxPremium;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (benefits != null) {
      $result.benefits.addAll(benefits);
    }
    if (termsUrl != null) {
      $result.termsUrl = termsUrl;
    }
    if (metadata != null) {
      $result.metadata.addAll(metadata);
    }
    if (formFields != null) {
      $result.formFields.addAll(formFields);
    }
    if (isActive != null) {
      $result.isActive = isActive;
    }
    return $result;
  }
  InsuranceProduct._() : super();
  factory InsuranceProduct.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InsuranceProduct.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'InsuranceProduct', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..aOS(4, _omitFieldNames ? '' : 'category')
    ..aOS(5, _omitFieldNames ? '' : 'providerName')
    ..aOS(6, _omitFieldNames ? '' : 'providerLogo')
    ..a<$core.double>(7, _omitFieldNames ? '' : 'minPremium', $pb.PbFieldType.OD)
    ..a<$core.double>(8, _omitFieldNames ? '' : 'maxPremium', $pb.PbFieldType.OD)
    ..aOS(9, _omitFieldNames ? '' : 'currency')
    ..pPS(10, _omitFieldNames ? '' : 'benefits')
    ..aOS(11, _omitFieldNames ? '' : 'termsUrl')
    ..m<$core.String, $core.String>(12, _omitFieldNames ? '' : 'metadata', entryClassName: 'InsuranceProduct.MetadataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('pb'))
    ..pc<InsuranceProductFormField>(13, _omitFieldNames ? '' : 'formFields', $pb.PbFieldType.PM, subBuilder: InsuranceProductFormField.create)
    ..aOB(14, _omitFieldNames ? '' : 'isActive')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InsuranceProduct clone() => InsuranceProduct()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InsuranceProduct copyWith(void Function(InsuranceProduct) updates) => super.copyWith((message) => updates(message as InsuranceProduct)) as InsuranceProduct;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InsuranceProduct create() => InsuranceProduct._();
  InsuranceProduct createEmptyInstance() => create();
  static $pb.PbList<InsuranceProduct> createRepeated() => $pb.PbList<InsuranceProduct>();
  @$core.pragma('dart2js:noInline')
  static InsuranceProduct getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InsuranceProduct>(create);
  static InsuranceProduct? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

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
  $core.String get category => $_getSZ(3);
  @$pb.TagNumber(4)
  set category($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCategory() => $_has(3);
  @$pb.TagNumber(4)
  void clearCategory() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get providerName => $_getSZ(4);
  @$pb.TagNumber(5)
  set providerName($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasProviderName() => $_has(4);
  @$pb.TagNumber(5)
  void clearProviderName() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get providerLogo => $_getSZ(5);
  @$pb.TagNumber(6)
  set providerLogo($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasProviderLogo() => $_has(5);
  @$pb.TagNumber(6)
  void clearProviderLogo() => clearField(6);

  @$pb.TagNumber(7)
  $core.double get minPremium => $_getN(6);
  @$pb.TagNumber(7)
  set minPremium($core.double v) { $_setDouble(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasMinPremium() => $_has(6);
  @$pb.TagNumber(7)
  void clearMinPremium() => clearField(7);

  @$pb.TagNumber(8)
  $core.double get maxPremium => $_getN(7);
  @$pb.TagNumber(8)
  set maxPremium($core.double v) { $_setDouble(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasMaxPremium() => $_has(7);
  @$pb.TagNumber(8)
  void clearMaxPremium() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get currency => $_getSZ(8);
  @$pb.TagNumber(9)
  set currency($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasCurrency() => $_has(8);
  @$pb.TagNumber(9)
  void clearCurrency() => clearField(9);

  @$pb.TagNumber(10)
  $core.List<$core.String> get benefits => $_getList(9);

  @$pb.TagNumber(11)
  $core.String get termsUrl => $_getSZ(10);
  @$pb.TagNumber(11)
  set termsUrl($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasTermsUrl() => $_has(10);
  @$pb.TagNumber(11)
  void clearTermsUrl() => clearField(11);

  @$pb.TagNumber(12)
  $core.Map<$core.String, $core.String> get metadata => $_getMap(11);

  @$pb.TagNumber(13)
  $core.List<InsuranceProductFormField> get formFields => $_getList(12);

  @$pb.TagNumber(14)
  $core.bool get isActive => $_getBF(13);
  @$pb.TagNumber(14)
  set isActive($core.bool v) { $_setBool(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasIsActive() => $_has(13);
  @$pb.TagNumber(14)
  void clearIsActive() => clearField(14);
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
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (name != null) {
      $result.name = name;
    }
    if (icon != null) {
      $result.icon = icon;
    }
    if (description != null) {
      $result.description = description;
    }
    if (productCount != null) {
      $result.productCount = productCount;
    }
    return $result;
  }
  InsuranceCategory._() : super();
  factory InsuranceCategory.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InsuranceCategory.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'InsuranceCategory', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'icon')
    ..aOS(4, _omitFieldNames ? '' : 'description')
    ..a<$core.int>(5, _omitFieldNames ? '' : 'productCount', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InsuranceCategory clone() => InsuranceCategory()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InsuranceCategory copyWith(void Function(InsuranceCategory) updates) => super.copyWith((message) => updates(message as InsuranceCategory)) as InsuranceCategory;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InsuranceCategory create() => InsuranceCategory._();
  InsuranceCategory createEmptyInstance() => create();
  static $pb.PbList<InsuranceCategory> createRepeated() => $pb.PbList<InsuranceCategory>();
  @$core.pragma('dart2js:noInline')
  static InsuranceCategory getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InsuranceCategory>(create);
  static InsuranceCategory? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get icon => $_getSZ(2);
  @$pb.TagNumber(3)
  set icon($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasIcon() => $_has(2);
  @$pb.TagNumber(3)
  void clearIcon() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get description => $_getSZ(3);
  @$pb.TagNumber(4)
  set description($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDescription() => $_has(3);
  @$pb.TagNumber(4)
  void clearDescription() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get productCount => $_getIZ(4);
  @$pb.TagNumber(5)
  set productCount($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasProductCount() => $_has(4);
  @$pb.TagNumber(5)
  void clearProductCount() => clearField(5);
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
    $core.Map<$core.String, $core.String>? quoteDetails,
  }) {
    final $result = create();
    if (quoteId != null) {
      $result.quoteId = quoteId;
    }
    if (productId != null) {
      $result.productId = productId;
    }
    if (premium != null) {
      $result.premium = premium;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (coverageSummary != null) {
      $result.coverageSummary = coverageSummary;
    }
    if (coverageItems != null) {
      $result.coverageItems.addAll(coverageItems);
    }
    if (validUntil != null) {
      $result.validUntil = validUntil;
    }
    if (quoteDetails != null) {
      $result.quoteDetails.addAll(quoteDetails);
    }
    return $result;
  }
  InsuranceQuote._() : super();
  factory InsuranceQuote.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InsuranceQuote.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'InsuranceQuote', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'quoteId')
    ..aOS(2, _omitFieldNames ? '' : 'productId')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'premium', $pb.PbFieldType.OD)
    ..aOS(4, _omitFieldNames ? '' : 'currency')
    ..aOS(5, _omitFieldNames ? '' : 'coverageSummary')
    ..pPS(6, _omitFieldNames ? '' : 'coverageItems')
    ..aOS(7, _omitFieldNames ? '' : 'validUntil')
    ..m<$core.String, $core.String>(8, _omitFieldNames ? '' : 'quoteDetails', entryClassName: 'InsuranceQuote.QuoteDetailsEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('pb'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InsuranceQuote clone() => InsuranceQuote()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InsuranceQuote copyWith(void Function(InsuranceQuote) updates) => super.copyWith((message) => updates(message as InsuranceQuote)) as InsuranceQuote;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InsuranceQuote create() => InsuranceQuote._();
  InsuranceQuote createEmptyInstance() => create();
  static $pb.PbList<InsuranceQuote> createRepeated() => $pb.PbList<InsuranceQuote>();
  @$core.pragma('dart2js:noInline')
  static InsuranceQuote getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InsuranceQuote>(create);
  static InsuranceQuote? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get quoteId => $_getSZ(0);
  @$pb.TagNumber(1)
  set quoteId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasQuoteId() => $_has(0);
  @$pb.TagNumber(1)
  void clearQuoteId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get productId => $_getSZ(1);
  @$pb.TagNumber(2)
  set productId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasProductId() => $_has(1);
  @$pb.TagNumber(2)
  void clearProductId() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get premium => $_getN(2);
  @$pb.TagNumber(3)
  set premium($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPremium() => $_has(2);
  @$pb.TagNumber(3)
  void clearPremium() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get currency => $_getSZ(3);
  @$pb.TagNumber(4)
  set currency($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCurrency() => $_has(3);
  @$pb.TagNumber(4)
  void clearCurrency() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get coverageSummary => $_getSZ(4);
  @$pb.TagNumber(5)
  set coverageSummary($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasCoverageSummary() => $_has(4);
  @$pb.TagNumber(5)
  void clearCoverageSummary() => clearField(5);

  @$pb.TagNumber(6)
  $core.List<$core.String> get coverageItems => $_getList(5);

  @$pb.TagNumber(7)
  $core.String get validUntil => $_getSZ(6);
  @$pb.TagNumber(7)
  set validUntil($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasValidUntil() => $_has(6);
  @$pb.TagNumber(7)
  void clearValidUntil() => clearField(7);

  @$pb.TagNumber(8)
  $core.Map<$core.String, $core.String> get quoteDetails => $_getMap(7);
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
    final $result = create();
    if (policyId != null) {
      $result.policyId = policyId;
    }
    if (policyNumber != null) {
      $result.policyNumber = policyNumber;
    }
    if (reference != null) {
      $result.reference = reference;
    }
    if (status != null) {
      $result.status = status;
    }
    if (providerReference != null) {
      $result.providerReference = providerReference;
    }
    if (insurance != null) {
      $result.insurance = insurance;
    }
    return $result;
  }
  InsurancePurchaseResult._() : super();
  factory InsurancePurchaseResult.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InsurancePurchaseResult.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'InsurancePurchaseResult', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'policyId')
    ..aOS(2, _omitFieldNames ? '' : 'policyNumber')
    ..aOS(3, _omitFieldNames ? '' : 'reference')
    ..aOS(4, _omitFieldNames ? '' : 'status')
    ..aOS(5, _omitFieldNames ? '' : 'providerReference')
    ..aOM<Insurance>(6, _omitFieldNames ? '' : 'insurance', subBuilder: Insurance.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InsurancePurchaseResult clone() => InsurancePurchaseResult()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InsurancePurchaseResult copyWith(void Function(InsurancePurchaseResult) updates) => super.copyWith((message) => updates(message as InsurancePurchaseResult)) as InsurancePurchaseResult;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InsurancePurchaseResult create() => InsurancePurchaseResult._();
  InsurancePurchaseResult createEmptyInstance() => create();
  static $pb.PbList<InsurancePurchaseResult> createRepeated() => $pb.PbList<InsurancePurchaseResult>();
  @$core.pragma('dart2js:noInline')
  static InsurancePurchaseResult getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InsurancePurchaseResult>(create);
  static InsurancePurchaseResult? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get policyId => $_getSZ(0);
  @$pb.TagNumber(1)
  set policyId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPolicyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPolicyId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get policyNumber => $_getSZ(1);
  @$pb.TagNumber(2)
  set policyNumber($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPolicyNumber() => $_has(1);
  @$pb.TagNumber(2)
  void clearPolicyNumber() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get reference => $_getSZ(2);
  @$pb.TagNumber(3)
  set reference($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasReference() => $_has(2);
  @$pb.TagNumber(3)
  void clearReference() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get status => $_getSZ(3);
  @$pb.TagNumber(4)
  set status($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearStatus() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get providerReference => $_getSZ(4);
  @$pb.TagNumber(5)
  set providerReference($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasProviderReference() => $_has(4);
  @$pb.TagNumber(5)
  void clearProviderReference() => clearField(5);

  @$pb.TagNumber(6)
  Insurance get insurance => $_getN(5);
  @$pb.TagNumber(6)
  set insurance(Insurance v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasInsurance() => $_has(5);
  @$pb.TagNumber(6)
  void clearInsurance() => clearField(6);
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
    final $result = create();
    if (category != null) {
      $result.category = category;
    }
    if (locale != null) {
      $result.locale = locale;
    }
    if (page != null) {
      $result.page = page;
    }
    if (limit != null) {
      $result.limit = limit;
    }
    return $result;
  }
  GetInsuranceProductsRequest._() : super();
  factory GetInsuranceProductsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInsuranceProductsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetInsuranceProductsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'category')
    ..aOS(2, _omitFieldNames ? '' : 'locale')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInsuranceProductsRequest clone() => GetInsuranceProductsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInsuranceProductsRequest copyWith(void Function(GetInsuranceProductsRequest) updates) => super.copyWith((message) => updates(message as GetInsuranceProductsRequest)) as GetInsuranceProductsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInsuranceProductsRequest create() => GetInsuranceProductsRequest._();
  GetInsuranceProductsRequest createEmptyInstance() => create();
  static $pb.PbList<GetInsuranceProductsRequest> createRepeated() => $pb.PbList<GetInsuranceProductsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInsuranceProductsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInsuranceProductsRequest>(create);
  static GetInsuranceProductsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get category => $_getSZ(0);
  @$pb.TagNumber(1)
  set category($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCategory() => $_has(0);
  @$pb.TagNumber(1)
  void clearCategory() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get locale => $_getSZ(1);
  @$pb.TagNumber(2)
  set locale($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLocale() => $_has(1);
  @$pb.TagNumber(2)
  void clearLocale() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get page => $_getIZ(2);
  @$pb.TagNumber(3)
  set page($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPage() => $_has(2);
  @$pb.TagNumber(3)
  void clearPage() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get limit => $_getIZ(3);
  @$pb.TagNumber(4)
  set limit($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasLimit() => $_has(3);
  @$pb.TagNumber(4)
  void clearLimit() => clearField(4);
}

class GetInsuranceProductsResponse extends $pb.GeneratedMessage {
  factory GetInsuranceProductsResponse({
    $core.Iterable<InsuranceProduct>? products,
    $core.int? total,
    $core.bool? success,
    $core.String? msg,
  }) {
    final $result = create();
    if (products != null) {
      $result.products.addAll(products);
    }
    if (total != null) {
      $result.total = total;
    }
    if (success != null) {
      $result.success = success;
    }
    if (msg != null) {
      $result.msg = msg;
    }
    return $result;
  }
  GetInsuranceProductsResponse._() : super();
  factory GetInsuranceProductsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInsuranceProductsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetInsuranceProductsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<InsuranceProduct>(1, _omitFieldNames ? '' : 'products', $pb.PbFieldType.PM, subBuilder: InsuranceProduct.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..aOB(3, _omitFieldNames ? '' : 'success')
    ..aOS(4, _omitFieldNames ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInsuranceProductsResponse clone() => GetInsuranceProductsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInsuranceProductsResponse copyWith(void Function(GetInsuranceProductsResponse) updates) => super.copyWith((message) => updates(message as GetInsuranceProductsResponse)) as GetInsuranceProductsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInsuranceProductsResponse create() => GetInsuranceProductsResponse._();
  GetInsuranceProductsResponse createEmptyInstance() => create();
  static $pb.PbList<GetInsuranceProductsResponse> createRepeated() => $pb.PbList<GetInsuranceProductsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInsuranceProductsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInsuranceProductsResponse>(create);
  static GetInsuranceProductsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<InsuranceProduct> get products => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get success => $_getBF(2);
  @$pb.TagNumber(3)
  set success($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSuccess() => $_has(2);
  @$pb.TagNumber(3)
  void clearSuccess() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get msg => $_getSZ(3);
  @$pb.TagNumber(4)
  set msg($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMsg() => $_has(3);
  @$pb.TagNumber(4)
  void clearMsg() => clearField(4);
}

class GetInsuranceCategoriesRequest extends $pb.GeneratedMessage {
  factory GetInsuranceCategoriesRequest({
    $core.String? locale,
  }) {
    final $result = create();
    if (locale != null) {
      $result.locale = locale;
    }
    return $result;
  }
  GetInsuranceCategoriesRequest._() : super();
  factory GetInsuranceCategoriesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInsuranceCategoriesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetInsuranceCategoriesRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'locale')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInsuranceCategoriesRequest clone() => GetInsuranceCategoriesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInsuranceCategoriesRequest copyWith(void Function(GetInsuranceCategoriesRequest) updates) => super.copyWith((message) => updates(message as GetInsuranceCategoriesRequest)) as GetInsuranceCategoriesRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInsuranceCategoriesRequest create() => GetInsuranceCategoriesRequest._();
  GetInsuranceCategoriesRequest createEmptyInstance() => create();
  static $pb.PbList<GetInsuranceCategoriesRequest> createRepeated() => $pb.PbList<GetInsuranceCategoriesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInsuranceCategoriesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInsuranceCategoriesRequest>(create);
  static GetInsuranceCategoriesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get locale => $_getSZ(0);
  @$pb.TagNumber(1)
  set locale($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLocale() => $_has(0);
  @$pb.TagNumber(1)
  void clearLocale() => clearField(1);
}

class GetInsuranceCategoriesResponse extends $pb.GeneratedMessage {
  factory GetInsuranceCategoriesResponse({
    $core.Iterable<InsuranceCategory>? categories,
    $core.bool? success,
    $core.String? msg,
  }) {
    final $result = create();
    if (categories != null) {
      $result.categories.addAll(categories);
    }
    if (success != null) {
      $result.success = success;
    }
    if (msg != null) {
      $result.msg = msg;
    }
    return $result;
  }
  GetInsuranceCategoriesResponse._() : super();
  factory GetInsuranceCategoriesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInsuranceCategoriesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetInsuranceCategoriesResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<InsuranceCategory>(1, _omitFieldNames ? '' : 'categories', $pb.PbFieldType.PM, subBuilder: InsuranceCategory.create)
    ..aOB(2, _omitFieldNames ? '' : 'success')
    ..aOS(3, _omitFieldNames ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInsuranceCategoriesResponse clone() => GetInsuranceCategoriesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInsuranceCategoriesResponse copyWith(void Function(GetInsuranceCategoriesResponse) updates) => super.copyWith((message) => updates(message as GetInsuranceCategoriesResponse)) as GetInsuranceCategoriesResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInsuranceCategoriesResponse create() => GetInsuranceCategoriesResponse._();
  GetInsuranceCategoriesResponse createEmptyInstance() => create();
  static $pb.PbList<GetInsuranceCategoriesResponse> createRepeated() => $pb.PbList<GetInsuranceCategoriesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInsuranceCategoriesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInsuranceCategoriesResponse>(create);
  static GetInsuranceCategoriesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<InsuranceCategory> get categories => $_getList(0);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get msg => $_getSZ(2);
  @$pb.TagNumber(3)
  set msg($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMsg() => $_has(2);
  @$pb.TagNumber(3)
  void clearMsg() => clearField(3);
}

class GetInsuranceQuoteRequest extends $pb.GeneratedMessage {
  factory GetInsuranceQuoteRequest({
    $core.String? productId,
    $core.Map<$core.String, $core.String>? formData,
    $core.String? locale,
  }) {
    final $result = create();
    if (productId != null) {
      $result.productId = productId;
    }
    if (formData != null) {
      $result.formData.addAll(formData);
    }
    if (locale != null) {
      $result.locale = locale;
    }
    return $result;
  }
  GetInsuranceQuoteRequest._() : super();
  factory GetInsuranceQuoteRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInsuranceQuoteRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetInsuranceQuoteRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'productId')
    ..m<$core.String, $core.String>(2, _omitFieldNames ? '' : 'formData', entryClassName: 'GetInsuranceQuoteRequest.FormDataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('pb'))
    ..aOS(3, _omitFieldNames ? '' : 'locale')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInsuranceQuoteRequest clone() => GetInsuranceQuoteRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInsuranceQuoteRequest copyWith(void Function(GetInsuranceQuoteRequest) updates) => super.copyWith((message) => updates(message as GetInsuranceQuoteRequest)) as GetInsuranceQuoteRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInsuranceQuoteRequest create() => GetInsuranceQuoteRequest._();
  GetInsuranceQuoteRequest createEmptyInstance() => create();
  static $pb.PbList<GetInsuranceQuoteRequest> createRepeated() => $pb.PbList<GetInsuranceQuoteRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInsuranceQuoteRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInsuranceQuoteRequest>(create);
  static GetInsuranceQuoteRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get productId => $_getSZ(0);
  @$pb.TagNumber(1)
  set productId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasProductId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProductId() => clearField(1);

  @$pb.TagNumber(2)
  $core.Map<$core.String, $core.String> get formData => $_getMap(1);

  @$pb.TagNumber(3)
  $core.String get locale => $_getSZ(2);
  @$pb.TagNumber(3)
  set locale($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasLocale() => $_has(2);
  @$pb.TagNumber(3)
  void clearLocale() => clearField(3);
}

class GetInsuranceQuoteResponse extends $pb.GeneratedMessage {
  factory GetInsuranceQuoteResponse({
    InsuranceQuote? quote,
    $core.bool? success,
    $core.String? msg,
  }) {
    final $result = create();
    if (quote != null) {
      $result.quote = quote;
    }
    if (success != null) {
      $result.success = success;
    }
    if (msg != null) {
      $result.msg = msg;
    }
    return $result;
  }
  GetInsuranceQuoteResponse._() : super();
  factory GetInsuranceQuoteResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInsuranceQuoteResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetInsuranceQuoteResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<InsuranceQuote>(1, _omitFieldNames ? '' : 'quote', subBuilder: InsuranceQuote.create)
    ..aOB(2, _omitFieldNames ? '' : 'success')
    ..aOS(3, _omitFieldNames ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInsuranceQuoteResponse clone() => GetInsuranceQuoteResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInsuranceQuoteResponse copyWith(void Function(GetInsuranceQuoteResponse) updates) => super.copyWith((message) => updates(message as GetInsuranceQuoteResponse)) as GetInsuranceQuoteResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInsuranceQuoteResponse create() => GetInsuranceQuoteResponse._();
  GetInsuranceQuoteResponse createEmptyInstance() => create();
  static $pb.PbList<GetInsuranceQuoteResponse> createRepeated() => $pb.PbList<GetInsuranceQuoteResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInsuranceQuoteResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInsuranceQuoteResponse>(create);
  static GetInsuranceQuoteResponse? _defaultInstance;

  @$pb.TagNumber(1)
  InsuranceQuote get quote => $_getN(0);
  @$pb.TagNumber(1)
  set quote(InsuranceQuote v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasQuote() => $_has(0);
  @$pb.TagNumber(1)
  void clearQuote() => clearField(1);
  @$pb.TagNumber(1)
  InsuranceQuote ensureQuote() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get msg => $_getSZ(2);
  @$pb.TagNumber(3)
  set msg($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMsg() => $_has(2);
  @$pb.TagNumber(3)
  void clearMsg() => clearField(3);
}

class PurchaseInsuranceRequest extends $pb.GeneratedMessage {
  factory PurchaseInsuranceRequest({
    $core.String? quoteId,
    $core.String? productId,
    $core.String? accountId,
    $core.String? transactionPin,
    $core.String? idempotencyKey,
    $core.Map<$core.String, $core.String>? formData,
    $core.String? locale,
  }) {
    final $result = create();
    if (quoteId != null) {
      $result.quoteId = quoteId;
    }
    if (productId != null) {
      $result.productId = productId;
    }
    if (accountId != null) {
      $result.accountId = accountId;
    }
    if (transactionPin != null) {
      $result.transactionPin = transactionPin;
    }
    if (idempotencyKey != null) {
      $result.idempotencyKey = idempotencyKey;
    }
    if (formData != null) {
      $result.formData.addAll(formData);
    }
    if (locale != null) {
      $result.locale = locale;
    }
    return $result;
  }
  PurchaseInsuranceRequest._() : super();
  factory PurchaseInsuranceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PurchaseInsuranceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PurchaseInsuranceRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'quoteId')
    ..aOS(2, _omitFieldNames ? '' : 'productId')
    ..aOS(3, _omitFieldNames ? '' : 'accountId')
    ..aOS(4, _omitFieldNames ? '' : 'transactionPin')
    ..aOS(5, _omitFieldNames ? '' : 'idempotencyKey')
    ..m<$core.String, $core.String>(6, _omitFieldNames ? '' : 'formData', entryClassName: 'PurchaseInsuranceRequest.FormDataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('pb'))
    ..aOS(7, _omitFieldNames ? '' : 'locale')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PurchaseInsuranceRequest clone() => PurchaseInsuranceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PurchaseInsuranceRequest copyWith(void Function(PurchaseInsuranceRequest) updates) => super.copyWith((message) => updates(message as PurchaseInsuranceRequest)) as PurchaseInsuranceRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PurchaseInsuranceRequest create() => PurchaseInsuranceRequest._();
  PurchaseInsuranceRequest createEmptyInstance() => create();
  static $pb.PbList<PurchaseInsuranceRequest> createRepeated() => $pb.PbList<PurchaseInsuranceRequest>();
  @$core.pragma('dart2js:noInline')
  static PurchaseInsuranceRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PurchaseInsuranceRequest>(create);
  static PurchaseInsuranceRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get quoteId => $_getSZ(0);
  @$pb.TagNumber(1)
  set quoteId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasQuoteId() => $_has(0);
  @$pb.TagNumber(1)
  void clearQuoteId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get productId => $_getSZ(1);
  @$pb.TagNumber(2)
  set productId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasProductId() => $_has(1);
  @$pb.TagNumber(2)
  void clearProductId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get accountId => $_getSZ(2);
  @$pb.TagNumber(3)
  set accountId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAccountId() => $_has(2);
  @$pb.TagNumber(3)
  void clearAccountId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get transactionPin => $_getSZ(3);
  @$pb.TagNumber(4)
  set transactionPin($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTransactionPin() => $_has(3);
  @$pb.TagNumber(4)
  void clearTransactionPin() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get idempotencyKey => $_getSZ(4);
  @$pb.TagNumber(5)
  set idempotencyKey($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasIdempotencyKey() => $_has(4);
  @$pb.TagNumber(5)
  void clearIdempotencyKey() => clearField(5);

  @$pb.TagNumber(6)
  $core.Map<$core.String, $core.String> get formData => $_getMap(5);

  @$pb.TagNumber(7)
  $core.String get locale => $_getSZ(6);
  @$pb.TagNumber(7)
  set locale($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasLocale() => $_has(6);
  @$pb.TagNumber(7)
  void clearLocale() => clearField(7);
}

class PurchaseInsuranceResponse extends $pb.GeneratedMessage {
  factory PurchaseInsuranceResponse({
    InsurancePurchaseResult? result,
    $core.bool? success,
    $core.String? msg,
  }) {
    final $result = create();
    if (result != null) {
      $result.result = result;
    }
    if (success != null) {
      $result.success = success;
    }
    if (msg != null) {
      $result.msg = msg;
    }
    return $result;
  }
  PurchaseInsuranceResponse._() : super();
  factory PurchaseInsuranceResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PurchaseInsuranceResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PurchaseInsuranceResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<InsurancePurchaseResult>(1, _omitFieldNames ? '' : 'result', subBuilder: InsurancePurchaseResult.create)
    ..aOB(2, _omitFieldNames ? '' : 'success')
    ..aOS(3, _omitFieldNames ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PurchaseInsuranceResponse clone() => PurchaseInsuranceResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PurchaseInsuranceResponse copyWith(void Function(PurchaseInsuranceResponse) updates) => super.copyWith((message) => updates(message as PurchaseInsuranceResponse)) as PurchaseInsuranceResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PurchaseInsuranceResponse create() => PurchaseInsuranceResponse._();
  PurchaseInsuranceResponse createEmptyInstance() => create();
  static $pb.PbList<PurchaseInsuranceResponse> createRepeated() => $pb.PbList<PurchaseInsuranceResponse>();
  @$core.pragma('dart2js:noInline')
  static PurchaseInsuranceResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PurchaseInsuranceResponse>(create);
  static PurchaseInsuranceResponse? _defaultInstance;

  @$pb.TagNumber(1)
  InsurancePurchaseResult get result => $_getN(0);
  @$pb.TagNumber(1)
  set result(InsurancePurchaseResult v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasResult() => $_has(0);
  @$pb.TagNumber(1)
  void clearResult() => clearField(1);
  @$pb.TagNumber(1)
  InsurancePurchaseResult ensureResult() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get msg => $_getSZ(2);
  @$pb.TagNumber(3)
  set msg($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMsg() => $_has(2);
  @$pb.TagNumber(3)
  void clearMsg() => clearField(3);
}

class GetInsurancePurchaseStatusRequest extends $pb.GeneratedMessage {
  factory GetInsurancePurchaseStatusRequest({
    $core.String? reference,
  }) {
    final $result = create();
    if (reference != null) {
      $result.reference = reference;
    }
    return $result;
  }
  GetInsurancePurchaseStatusRequest._() : super();
  factory GetInsurancePurchaseStatusRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInsurancePurchaseStatusRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetInsurancePurchaseStatusRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'reference')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInsurancePurchaseStatusRequest clone() => GetInsurancePurchaseStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInsurancePurchaseStatusRequest copyWith(void Function(GetInsurancePurchaseStatusRequest) updates) => super.copyWith((message) => updates(message as GetInsurancePurchaseStatusRequest)) as GetInsurancePurchaseStatusRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInsurancePurchaseStatusRequest create() => GetInsurancePurchaseStatusRequest._();
  GetInsurancePurchaseStatusRequest createEmptyInstance() => create();
  static $pb.PbList<GetInsurancePurchaseStatusRequest> createRepeated() => $pb.PbList<GetInsurancePurchaseStatusRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInsurancePurchaseStatusRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInsurancePurchaseStatusRequest>(create);
  static GetInsurancePurchaseStatusRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get reference => $_getSZ(0);
  @$pb.TagNumber(1)
  set reference($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasReference() => $_has(0);
  @$pb.TagNumber(1)
  void clearReference() => clearField(1);
}

class GetInsurancePurchaseStatusResponse extends $pb.GeneratedMessage {
  factory GetInsurancePurchaseStatusResponse({
    InsurancePurchaseResult? result,
    $core.bool? success,
    $core.String? msg,
  }) {
    final $result = create();
    if (result != null) {
      $result.result = result;
    }
    if (success != null) {
      $result.success = success;
    }
    if (msg != null) {
      $result.msg = msg;
    }
    return $result;
  }
  GetInsurancePurchaseStatusResponse._() : super();
  factory GetInsurancePurchaseStatusResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInsurancePurchaseStatusResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetInsurancePurchaseStatusResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<InsurancePurchaseResult>(1, _omitFieldNames ? '' : 'result', subBuilder: InsurancePurchaseResult.create)
    ..aOB(2, _omitFieldNames ? '' : 'success')
    ..aOS(3, _omitFieldNames ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInsurancePurchaseStatusResponse clone() => GetInsurancePurchaseStatusResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInsurancePurchaseStatusResponse copyWith(void Function(GetInsurancePurchaseStatusResponse) updates) => super.copyWith((message) => updates(message as GetInsurancePurchaseStatusResponse)) as GetInsurancePurchaseStatusResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInsurancePurchaseStatusResponse create() => GetInsurancePurchaseStatusResponse._();
  GetInsurancePurchaseStatusResponse createEmptyInstance() => create();
  static $pb.PbList<GetInsurancePurchaseStatusResponse> createRepeated() => $pb.PbList<GetInsurancePurchaseStatusResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInsurancePurchaseStatusResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInsurancePurchaseStatusResponse>(create);
  static GetInsurancePurchaseStatusResponse? _defaultInstance;

  @$pb.TagNumber(1)
  InsurancePurchaseResult get result => $_getN(0);
  @$pb.TagNumber(1)
  set result(InsurancePurchaseResult v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasResult() => $_has(0);
  @$pb.TagNumber(1)
  void clearResult() => clearField(1);
  @$pb.TagNumber(1)
  InsurancePurchaseResult ensureResult() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get msg => $_getSZ(2);
  @$pb.TagNumber(3)
  set msg($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMsg() => $_has(2);
  @$pb.TagNumber(3)
  void clearMsg() => clearField(3);
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
    $core.Map<$core.String, $core.String>? coverageDetails,
    $core.String? description,
    $core.String? userId,
    $core.String? createdAt,
    $core.String? updatedAt,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (policyNumber != null) {
      $result.policyNumber = policyNumber;
    }
    if (policyHolderName != null) {
      $result.policyHolderName = policyHolderName;
    }
    if (policyHolderEmail != null) {
      $result.policyHolderEmail = policyHolderEmail;
    }
    if (policyHolderPhone != null) {
      $result.policyHolderPhone = policyHolderPhone;
    }
    if (type != null) {
      $result.type = type;
    }
    if (provider != null) {
      $result.provider = provider;
    }
    if (providerLogo != null) {
      $result.providerLogo = providerLogo;
    }
    if (premiumAmount != null) {
      $result.premiumAmount = premiumAmount;
    }
    if (coverageAmount != null) {
      $result.coverageAmount = coverageAmount;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (startDate != null) {
      $result.startDate = startDate;
    }
    if (endDate != null) {
      $result.endDate = endDate;
    }
    if (nextPaymentDate != null) {
      $result.nextPaymentDate = nextPaymentDate;
    }
    if (status != null) {
      $result.status = status;
    }
    if (beneficiaries != null) {
      $result.beneficiaries.addAll(beneficiaries);
    }
    if (coverageDetails != null) {
      $result.coverageDetails.addAll(coverageDetails);
    }
    if (description != null) {
      $result.description = description;
    }
    if (userId != null) {
      $result.userId = userId;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      $result.updatedAt = updatedAt;
    }
    return $result;
  }
  Insurance._() : super();
  factory Insurance.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Insurance.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Insurance', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'policyNumber')
    ..aOS(3, _omitFieldNames ? '' : 'policyHolderName')
    ..aOS(4, _omitFieldNames ? '' : 'policyHolderEmail')
    ..aOS(5, _omitFieldNames ? '' : 'policyHolderPhone')
    ..aOS(6, _omitFieldNames ? '' : 'type')
    ..aOS(7, _omitFieldNames ? '' : 'provider')
    ..aOS(8, _omitFieldNames ? '' : 'providerLogo')
    ..a<$core.double>(9, _omitFieldNames ? '' : 'premiumAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(10, _omitFieldNames ? '' : 'coverageAmount', $pb.PbFieldType.OD)
    ..aOS(11, _omitFieldNames ? '' : 'currency')
    ..aOS(12, _omitFieldNames ? '' : 'startDate')
    ..aOS(13, _omitFieldNames ? '' : 'endDate')
    ..aOS(14, _omitFieldNames ? '' : 'nextPaymentDate')
    ..aOS(15, _omitFieldNames ? '' : 'status')
    ..pPS(16, _omitFieldNames ? '' : 'beneficiaries')
    ..m<$core.String, $core.String>(17, _omitFieldNames ? '' : 'coverageDetails', entryClassName: 'Insurance.CoverageDetailsEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('pb'))
    ..aOS(18, _omitFieldNames ? '' : 'description')
    ..aOS(19, _omitFieldNames ? '' : 'userId')
    ..aOS(20, _omitFieldNames ? '' : 'createdAt')
    ..aOS(21, _omitFieldNames ? '' : 'updatedAt')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Insurance clone() => Insurance()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Insurance copyWith(void Function(Insurance) updates) => super.copyWith((message) => updates(message as Insurance)) as Insurance;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Insurance create() => Insurance._();
  Insurance createEmptyInstance() => create();
  static $pb.PbList<Insurance> createRepeated() => $pb.PbList<Insurance>();
  @$core.pragma('dart2js:noInline')
  static Insurance getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Insurance>(create);
  static Insurance? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get policyNumber => $_getSZ(1);
  @$pb.TagNumber(2)
  set policyNumber($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPolicyNumber() => $_has(1);
  @$pb.TagNumber(2)
  void clearPolicyNumber() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get policyHolderName => $_getSZ(2);
  @$pb.TagNumber(3)
  set policyHolderName($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPolicyHolderName() => $_has(2);
  @$pb.TagNumber(3)
  void clearPolicyHolderName() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get policyHolderEmail => $_getSZ(3);
  @$pb.TagNumber(4)
  set policyHolderEmail($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPolicyHolderEmail() => $_has(3);
  @$pb.TagNumber(4)
  void clearPolicyHolderEmail() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get policyHolderPhone => $_getSZ(4);
  @$pb.TagNumber(5)
  set policyHolderPhone($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasPolicyHolderPhone() => $_has(4);
  @$pb.TagNumber(5)
  void clearPolicyHolderPhone() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get type => $_getSZ(5);
  @$pb.TagNumber(6)
  set type($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasType() => $_has(5);
  @$pb.TagNumber(6)
  void clearType() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get provider => $_getSZ(6);
  @$pb.TagNumber(7)
  set provider($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasProvider() => $_has(6);
  @$pb.TagNumber(7)
  void clearProvider() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get providerLogo => $_getSZ(7);
  @$pb.TagNumber(8)
  set providerLogo($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasProviderLogo() => $_has(7);
  @$pb.TagNumber(8)
  void clearProviderLogo() => clearField(8);

  @$pb.TagNumber(9)
  $core.double get premiumAmount => $_getN(8);
  @$pb.TagNumber(9)
  set premiumAmount($core.double v) { $_setDouble(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasPremiumAmount() => $_has(8);
  @$pb.TagNumber(9)
  void clearPremiumAmount() => clearField(9);

  @$pb.TagNumber(10)
  $core.double get coverageAmount => $_getN(9);
  @$pb.TagNumber(10)
  set coverageAmount($core.double v) { $_setDouble(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasCoverageAmount() => $_has(9);
  @$pb.TagNumber(10)
  void clearCoverageAmount() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get currency => $_getSZ(10);
  @$pb.TagNumber(11)
  set currency($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasCurrency() => $_has(10);
  @$pb.TagNumber(11)
  void clearCurrency() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get startDate => $_getSZ(11);
  @$pb.TagNumber(12)
  set startDate($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasStartDate() => $_has(11);
  @$pb.TagNumber(12)
  void clearStartDate() => clearField(12);

  @$pb.TagNumber(13)
  $core.String get endDate => $_getSZ(12);
  @$pb.TagNumber(13)
  set endDate($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasEndDate() => $_has(12);
  @$pb.TagNumber(13)
  void clearEndDate() => clearField(13);

  @$pb.TagNumber(14)
  $core.String get nextPaymentDate => $_getSZ(13);
  @$pb.TagNumber(14)
  set nextPaymentDate($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasNextPaymentDate() => $_has(13);
  @$pb.TagNumber(14)
  void clearNextPaymentDate() => clearField(14);

  @$pb.TagNumber(15)
  $core.String get status => $_getSZ(14);
  @$pb.TagNumber(15)
  set status($core.String v) { $_setString(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasStatus() => $_has(14);
  @$pb.TagNumber(15)
  void clearStatus() => clearField(15);

  @$pb.TagNumber(16)
  $core.List<$core.String> get beneficiaries => $_getList(15);

  @$pb.TagNumber(17)
  $core.Map<$core.String, $core.String> get coverageDetails => $_getMap(16);

  @$pb.TagNumber(18)
  $core.String get description => $_getSZ(17);
  @$pb.TagNumber(18)
  set description($core.String v) { $_setString(17, v); }
  @$pb.TagNumber(18)
  $core.bool hasDescription() => $_has(17);
  @$pb.TagNumber(18)
  void clearDescription() => clearField(18);

  @$pb.TagNumber(19)
  $core.String get userId => $_getSZ(18);
  @$pb.TagNumber(19)
  set userId($core.String v) { $_setString(18, v); }
  @$pb.TagNumber(19)
  $core.bool hasUserId() => $_has(18);
  @$pb.TagNumber(19)
  void clearUserId() => clearField(19);

  @$pb.TagNumber(20)
  $core.String get createdAt => $_getSZ(19);
  @$pb.TagNumber(20)
  set createdAt($core.String v) { $_setString(19, v); }
  @$pb.TagNumber(20)
  $core.bool hasCreatedAt() => $_has(19);
  @$pb.TagNumber(20)
  void clearCreatedAt() => clearField(20);

  @$pb.TagNumber(21)
  $core.String get updatedAt => $_getSZ(20);
  @$pb.TagNumber(21)
  set updatedAt($core.String v) { $_setString(20, v); }
  @$pb.TagNumber(21)
  $core.bool hasUpdatedAt() => $_has(20);
  @$pb.TagNumber(21)
  void clearUpdatedAt() => clearField(21);
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
    $core.Map<$core.String, $core.String>? paymentDetails,
    $core.String? failureReason,
    $core.String? receiptUrl,
    $core.String? userId,
    $core.String? createdAt,
    $core.String? updatedAt,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (insuranceId != null) {
      $result.insuranceId = insuranceId;
    }
    if (policyNumber != null) {
      $result.policyNumber = policyNumber;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (paymentMethod != null) {
      $result.paymentMethod = paymentMethod;
    }
    if (status != null) {
      $result.status = status;
    }
    if (transactionId != null) {
      $result.transactionId = transactionId;
    }
    if (referenceNumber != null) {
      $result.referenceNumber = referenceNumber;
    }
    if (paymentDate != null) {
      $result.paymentDate = paymentDate;
    }
    if (dueDate != null) {
      $result.dueDate = dueDate;
    }
    if (processedAt != null) {
      $result.processedAt = processedAt;
    }
    if (paymentDetails != null) {
      $result.paymentDetails.addAll(paymentDetails);
    }
    if (failureReason != null) {
      $result.failureReason = failureReason;
    }
    if (receiptUrl != null) {
      $result.receiptUrl = receiptUrl;
    }
    if (userId != null) {
      $result.userId = userId;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      $result.updatedAt = updatedAt;
    }
    return $result;
  }
  InsurancePayment._() : super();
  factory InsurancePayment.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InsurancePayment.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'InsurancePayment', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
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
    ..m<$core.String, $core.String>(13, _omitFieldNames ? '' : 'paymentDetails', entryClassName: 'InsurancePayment.PaymentDetailsEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('pb'))
    ..aOS(14, _omitFieldNames ? '' : 'failureReason')
    ..aOS(15, _omitFieldNames ? '' : 'receiptUrl')
    ..aOS(16, _omitFieldNames ? '' : 'userId')
    ..aOS(17, _omitFieldNames ? '' : 'createdAt')
    ..aOS(18, _omitFieldNames ? '' : 'updatedAt')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InsurancePayment clone() => InsurancePayment()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InsurancePayment copyWith(void Function(InsurancePayment) updates) => super.copyWith((message) => updates(message as InsurancePayment)) as InsurancePayment;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InsurancePayment create() => InsurancePayment._();
  InsurancePayment createEmptyInstance() => create();
  static $pb.PbList<InsurancePayment> createRepeated() => $pb.PbList<InsurancePayment>();
  @$core.pragma('dart2js:noInline')
  static InsurancePayment getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InsurancePayment>(create);
  static InsurancePayment? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get insuranceId => $_getSZ(1);
  @$pb.TagNumber(2)
  set insuranceId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasInsuranceId() => $_has(1);
  @$pb.TagNumber(2)
  void clearInsuranceId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get policyNumber => $_getSZ(2);
  @$pb.TagNumber(3)
  set policyNumber($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPolicyNumber() => $_has(2);
  @$pb.TagNumber(3)
  void clearPolicyNumber() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get amount => $_getN(3);
  @$pb.TagNumber(4)
  set amount($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearAmount() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get currency => $_getSZ(4);
  @$pb.TagNumber(5)
  set currency($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasCurrency() => $_has(4);
  @$pb.TagNumber(5)
  void clearCurrency() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get paymentMethod => $_getSZ(5);
  @$pb.TagNumber(6)
  set paymentMethod($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasPaymentMethod() => $_has(5);
  @$pb.TagNumber(6)
  void clearPaymentMethod() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get status => $_getSZ(6);
  @$pb.TagNumber(7)
  set status($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasStatus() => $_has(6);
  @$pb.TagNumber(7)
  void clearStatus() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get transactionId => $_getSZ(7);
  @$pb.TagNumber(8)
  set transactionId($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasTransactionId() => $_has(7);
  @$pb.TagNumber(8)
  void clearTransactionId() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get referenceNumber => $_getSZ(8);
  @$pb.TagNumber(9)
  set referenceNumber($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasReferenceNumber() => $_has(8);
  @$pb.TagNumber(9)
  void clearReferenceNumber() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get paymentDate => $_getSZ(9);
  @$pb.TagNumber(10)
  set paymentDate($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasPaymentDate() => $_has(9);
  @$pb.TagNumber(10)
  void clearPaymentDate() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get dueDate => $_getSZ(10);
  @$pb.TagNumber(11)
  set dueDate($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasDueDate() => $_has(10);
  @$pb.TagNumber(11)
  void clearDueDate() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get processedAt => $_getSZ(11);
  @$pb.TagNumber(12)
  set processedAt($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasProcessedAt() => $_has(11);
  @$pb.TagNumber(12)
  void clearProcessedAt() => clearField(12);

  @$pb.TagNumber(13)
  $core.Map<$core.String, $core.String> get paymentDetails => $_getMap(12);

  @$pb.TagNumber(14)
  $core.String get failureReason => $_getSZ(13);
  @$pb.TagNumber(14)
  set failureReason($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasFailureReason() => $_has(13);
  @$pb.TagNumber(14)
  void clearFailureReason() => clearField(14);

  @$pb.TagNumber(15)
  $core.String get receiptUrl => $_getSZ(14);
  @$pb.TagNumber(15)
  set receiptUrl($core.String v) { $_setString(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasReceiptUrl() => $_has(14);
  @$pb.TagNumber(15)
  void clearReceiptUrl() => clearField(15);

  @$pb.TagNumber(16)
  $core.String get userId => $_getSZ(15);
  @$pb.TagNumber(16)
  set userId($core.String v) { $_setString(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasUserId() => $_has(15);
  @$pb.TagNumber(16)
  void clearUserId() => clearField(16);

  @$pb.TagNumber(17)
  $core.String get createdAt => $_getSZ(16);
  @$pb.TagNumber(17)
  set createdAt($core.String v) { $_setString(16, v); }
  @$pb.TagNumber(17)
  $core.bool hasCreatedAt() => $_has(16);
  @$pb.TagNumber(17)
  void clearCreatedAt() => clearField(17);

  @$pb.TagNumber(18)
  $core.String get updatedAt => $_getSZ(17);
  @$pb.TagNumber(18)
  set updatedAt($core.String v) { $_setString(17, v); }
  @$pb.TagNumber(18)
  $core.bool hasUpdatedAt() => $_has(17);
  @$pb.TagNumber(18)
  void clearUpdatedAt() => clearField(18);
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
    $core.Map<$core.String, $core.String>? additionalInfo,
    $core.String? rejectionReason,
    $core.String? settlementDate,
    $core.String? settlementDetails,
    $core.String? userId,
    $core.String? createdAt,
    $core.String? updatedAt,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (claimNumber != null) {
      $result.claimNumber = claimNumber;
    }
    if (insuranceId != null) {
      $result.insuranceId = insuranceId;
    }
    if (policyNumber != null) {
      $result.policyNumber = policyNumber;
    }
    if (type != null) {
      $result.type = type;
    }
    if (status != null) {
      $result.status = status;
    }
    if (title != null) {
      $result.title = title;
    }
    if (description != null) {
      $result.description = description;
    }
    if (claimAmount != null) {
      $result.claimAmount = claimAmount;
    }
    if (approvedAmount != null) {
      $result.approvedAmount = approvedAmount;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (incidentDate != null) {
      $result.incidentDate = incidentDate;
    }
    if (incidentLocation != null) {
      $result.incidentLocation = incidentLocation;
    }
    if (attachments != null) {
      $result.attachments.addAll(attachments);
    }
    if (documents != null) {
      $result.documents.addAll(documents);
    }
    if (additionalInfo != null) {
      $result.additionalInfo.addAll(additionalInfo);
    }
    if (rejectionReason != null) {
      $result.rejectionReason = rejectionReason;
    }
    if (settlementDate != null) {
      $result.settlementDate = settlementDate;
    }
    if (settlementDetails != null) {
      $result.settlementDetails = settlementDetails;
    }
    if (userId != null) {
      $result.userId = userId;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      $result.updatedAt = updatedAt;
    }
    return $result;
  }
  InsuranceClaim._() : super();
  factory InsuranceClaim.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InsuranceClaim.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'InsuranceClaim', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'claimNumber')
    ..aOS(3, _omitFieldNames ? '' : 'insuranceId')
    ..aOS(4, _omitFieldNames ? '' : 'policyNumber')
    ..aOS(5, _omitFieldNames ? '' : 'type')
    ..aOS(6, _omitFieldNames ? '' : 'status')
    ..aOS(7, _omitFieldNames ? '' : 'title')
    ..aOS(8, _omitFieldNames ? '' : 'description')
    ..a<$core.double>(9, _omitFieldNames ? '' : 'claimAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(10, _omitFieldNames ? '' : 'approvedAmount', $pb.PbFieldType.OD)
    ..aOS(11, _omitFieldNames ? '' : 'currency')
    ..aOS(12, _omitFieldNames ? '' : 'incidentDate')
    ..aOS(13, _omitFieldNames ? '' : 'incidentLocation')
    ..pPS(14, _omitFieldNames ? '' : 'attachments')
    ..pPS(15, _omitFieldNames ? '' : 'documents')
    ..m<$core.String, $core.String>(16, _omitFieldNames ? '' : 'additionalInfo', entryClassName: 'InsuranceClaim.AdditionalInfoEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('pb'))
    ..aOS(17, _omitFieldNames ? '' : 'rejectionReason')
    ..aOS(18, _omitFieldNames ? '' : 'settlementDate')
    ..aOS(19, _omitFieldNames ? '' : 'settlementDetails')
    ..aOS(20, _omitFieldNames ? '' : 'userId')
    ..aOS(21, _omitFieldNames ? '' : 'createdAt')
    ..aOS(22, _omitFieldNames ? '' : 'updatedAt')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InsuranceClaim clone() => InsuranceClaim()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InsuranceClaim copyWith(void Function(InsuranceClaim) updates) => super.copyWith((message) => updates(message as InsuranceClaim)) as InsuranceClaim;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InsuranceClaim create() => InsuranceClaim._();
  InsuranceClaim createEmptyInstance() => create();
  static $pb.PbList<InsuranceClaim> createRepeated() => $pb.PbList<InsuranceClaim>();
  @$core.pragma('dart2js:noInline')
  static InsuranceClaim getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InsuranceClaim>(create);
  static InsuranceClaim? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get claimNumber => $_getSZ(1);
  @$pb.TagNumber(2)
  set claimNumber($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasClaimNumber() => $_has(1);
  @$pb.TagNumber(2)
  void clearClaimNumber() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get insuranceId => $_getSZ(2);
  @$pb.TagNumber(3)
  set insuranceId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasInsuranceId() => $_has(2);
  @$pb.TagNumber(3)
  void clearInsuranceId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get policyNumber => $_getSZ(3);
  @$pb.TagNumber(4)
  set policyNumber($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPolicyNumber() => $_has(3);
  @$pb.TagNumber(4)
  void clearPolicyNumber() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get type => $_getSZ(4);
  @$pb.TagNumber(5)
  set type($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasType() => $_has(4);
  @$pb.TagNumber(5)
  void clearType() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get status => $_getSZ(5);
  @$pb.TagNumber(6)
  set status($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasStatus() => $_has(5);
  @$pb.TagNumber(6)
  void clearStatus() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get title => $_getSZ(6);
  @$pb.TagNumber(7)
  set title($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasTitle() => $_has(6);
  @$pb.TagNumber(7)
  void clearTitle() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get description => $_getSZ(7);
  @$pb.TagNumber(8)
  set description($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasDescription() => $_has(7);
  @$pb.TagNumber(8)
  void clearDescription() => clearField(8);

  @$pb.TagNumber(9)
  $core.double get claimAmount => $_getN(8);
  @$pb.TagNumber(9)
  set claimAmount($core.double v) { $_setDouble(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasClaimAmount() => $_has(8);
  @$pb.TagNumber(9)
  void clearClaimAmount() => clearField(9);

  @$pb.TagNumber(10)
  $core.double get approvedAmount => $_getN(9);
  @$pb.TagNumber(10)
  set approvedAmount($core.double v) { $_setDouble(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasApprovedAmount() => $_has(9);
  @$pb.TagNumber(10)
  void clearApprovedAmount() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get currency => $_getSZ(10);
  @$pb.TagNumber(11)
  set currency($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasCurrency() => $_has(10);
  @$pb.TagNumber(11)
  void clearCurrency() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get incidentDate => $_getSZ(11);
  @$pb.TagNumber(12)
  set incidentDate($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasIncidentDate() => $_has(11);
  @$pb.TagNumber(12)
  void clearIncidentDate() => clearField(12);

  @$pb.TagNumber(13)
  $core.String get incidentLocation => $_getSZ(12);
  @$pb.TagNumber(13)
  set incidentLocation($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasIncidentLocation() => $_has(12);
  @$pb.TagNumber(13)
  void clearIncidentLocation() => clearField(13);

  @$pb.TagNumber(14)
  $core.List<$core.String> get attachments => $_getList(13);

  @$pb.TagNumber(15)
  $core.List<$core.String> get documents => $_getList(14);

  @$pb.TagNumber(16)
  $core.Map<$core.String, $core.String> get additionalInfo => $_getMap(15);

  @$pb.TagNumber(17)
  $core.String get rejectionReason => $_getSZ(16);
  @$pb.TagNumber(17)
  set rejectionReason($core.String v) { $_setString(16, v); }
  @$pb.TagNumber(17)
  $core.bool hasRejectionReason() => $_has(16);
  @$pb.TagNumber(17)
  void clearRejectionReason() => clearField(17);

  @$pb.TagNumber(18)
  $core.String get settlementDate => $_getSZ(17);
  @$pb.TagNumber(18)
  set settlementDate($core.String v) { $_setString(17, v); }
  @$pb.TagNumber(18)
  $core.bool hasSettlementDate() => $_has(17);
  @$pb.TagNumber(18)
  void clearSettlementDate() => clearField(18);

  @$pb.TagNumber(19)
  $core.String get settlementDetails => $_getSZ(18);
  @$pb.TagNumber(19)
  set settlementDetails($core.String v) { $_setString(18, v); }
  @$pb.TagNumber(19)
  $core.bool hasSettlementDetails() => $_has(18);
  @$pb.TagNumber(19)
  void clearSettlementDetails() => clearField(19);

  @$pb.TagNumber(20)
  $core.String get userId => $_getSZ(19);
  @$pb.TagNumber(20)
  set userId($core.String v) { $_setString(19, v); }
  @$pb.TagNumber(20)
  $core.bool hasUserId() => $_has(19);
  @$pb.TagNumber(20)
  void clearUserId() => clearField(20);

  @$pb.TagNumber(21)
  $core.String get createdAt => $_getSZ(20);
  @$pb.TagNumber(21)
  set createdAt($core.String v) { $_setString(20, v); }
  @$pb.TagNumber(21)
  $core.bool hasCreatedAt() => $_has(20);
  @$pb.TagNumber(21)
  void clearCreatedAt() => clearField(21);

  @$pb.TagNumber(22)
  $core.String get updatedAt => $_getSZ(21);
  @$pb.TagNumber(22)
  set updatedAt($core.String v) { $_setString(21, v); }
  @$pb.TagNumber(22)
  $core.bool hasUpdatedAt() => $_has(21);
  @$pb.TagNumber(22)
  void clearUpdatedAt() => clearField(22);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
