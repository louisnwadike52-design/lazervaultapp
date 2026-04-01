///
//  Generated code. Do not modify.
//  source: insurance.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class InsurancePaginationInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'InsurancePaginationInfo', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currentPage', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalPages', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalItems', $pb.PbFieldType.O3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'itemsPerPage', $pb.PbFieldType.O3)
    ..aOB(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hasNext')
    ..aOB(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hasPrev')
    ..hasRequiredFields = false
  ;

  InsurancePaginationInfo._() : super();
  factory InsurancePaginationInfo({
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
  factory InsurancePaginationInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InsurancePaginationInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InsurancePaginationInfo clone() => InsurancePaginationInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InsurancePaginationInfo copyWith(void Function(InsurancePaginationInfo) updates) => super.copyWith((message) => updates(message as InsurancePaginationInfo)) as InsurancePaginationInfo; // ignore: deprecated_member_use
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

class GetUserInsurancesRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetUserInsurancesRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetUserInsurancesRequest._() : super();
  factory GetUserInsurancesRequest({
    $core.int? page,
    $core.int? limit,
  }) {
    final _result = create();
    if (page != null) {
      _result.page = page;
    }
    if (limit != null) {
      _result.limit = limit;
    }
    return _result;
  }
  factory GetUserInsurancesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserInsurancesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUserInsurancesRequest clone() => GetUserInsurancesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUserInsurancesRequest copyWith(void Function(GetUserInsurancesRequest) updates) => super.copyWith((message) => updates(message as GetUserInsurancesRequest)) as GetUserInsurancesRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetUserInsurancesResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<Insurance>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'insurances', $pb.PbFieldType.PM, subBuilder: Insurance.create)
    ..aOM<InsurancePaginationInfo>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pagination', subBuilder: InsurancePaginationInfo.create)
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  GetUserInsurancesResponse._() : super();
  factory GetUserInsurancesResponse({
    $core.Iterable<Insurance>? insurances,
    InsurancePaginationInfo? pagination,
    $core.bool? success,
    $core.String? msg,
  }) {
    final _result = create();
    if (insurances != null) {
      _result.insurances.addAll(insurances);
    }
    if (pagination != null) {
      _result.pagination = pagination;
    }
    if (success != null) {
      _result.success = success;
    }
    if (msg != null) {
      _result.msg = msg;
    }
    return _result;
  }
  factory GetUserInsurancesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserInsurancesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUserInsurancesResponse clone() => GetUserInsurancesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUserInsurancesResponse copyWith(void Function(GetUserInsurancesResponse) updates) => super.copyWith((message) => updates(message as GetUserInsurancesResponse)) as GetUserInsurancesResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInsuranceByIdRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..hasRequiredFields = false
  ;

  GetInsuranceByIdRequest._() : super();
  factory GetInsuranceByIdRequest({
    $core.String? id,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    return _result;
  }
  factory GetInsuranceByIdRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInsuranceByIdRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInsuranceByIdRequest clone() => GetInsuranceByIdRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInsuranceByIdRequest copyWith(void Function(GetInsuranceByIdRequest) updates) => super.copyWith((message) => updates(message as GetInsuranceByIdRequest)) as GetInsuranceByIdRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInsuranceByIdResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<Insurance>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'insurance', subBuilder: Insurance.create)
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  GetInsuranceByIdResponse._() : super();
  factory GetInsuranceByIdResponse({
    Insurance? insurance,
    $core.bool? success,
    $core.String? msg,
  }) {
    final _result = create();
    if (insurance != null) {
      _result.insurance = insurance;
    }
    if (success != null) {
      _result.success = success;
    }
    if (msg != null) {
      _result.msg = msg;
    }
    return _result;
  }
  factory GetInsuranceByIdResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInsuranceByIdResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInsuranceByIdResponse clone() => GetInsuranceByIdResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInsuranceByIdResponse copyWith(void Function(GetInsuranceByIdResponse) updates) => super.copyWith((message) => updates(message as GetInsuranceByIdResponse)) as GetInsuranceByIdResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateInsuranceRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<Insurance>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'insurance', subBuilder: Insurance.create)
    ..hasRequiredFields = false
  ;

  CreateInsuranceRequest._() : super();
  factory CreateInsuranceRequest({
    Insurance? insurance,
  }) {
    final _result = create();
    if (insurance != null) {
      _result.insurance = insurance;
    }
    return _result;
  }
  factory CreateInsuranceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateInsuranceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateInsuranceRequest clone() => CreateInsuranceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateInsuranceRequest copyWith(void Function(CreateInsuranceRequest) updates) => super.copyWith((message) => updates(message as CreateInsuranceRequest)) as CreateInsuranceRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateInsuranceResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<Insurance>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'insurance', subBuilder: Insurance.create)
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  CreateInsuranceResponse._() : super();
  factory CreateInsuranceResponse({
    Insurance? insurance,
    $core.bool? success,
    $core.String? msg,
  }) {
    final _result = create();
    if (insurance != null) {
      _result.insurance = insurance;
    }
    if (success != null) {
      _result.success = success;
    }
    if (msg != null) {
      _result.msg = msg;
    }
    return _result;
  }
  factory CreateInsuranceResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateInsuranceResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateInsuranceResponse clone() => CreateInsuranceResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateInsuranceResponse copyWith(void Function(CreateInsuranceResponse) updates) => super.copyWith((message) => updates(message as CreateInsuranceResponse)) as CreateInsuranceResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateInsuranceRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<Insurance>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'insurance', subBuilder: Insurance.create)
    ..hasRequiredFields = false
  ;

  UpdateInsuranceRequest._() : super();
  factory UpdateInsuranceRequest({
    Insurance? insurance,
  }) {
    final _result = create();
    if (insurance != null) {
      _result.insurance = insurance;
    }
    return _result;
  }
  factory UpdateInsuranceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateInsuranceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateInsuranceRequest clone() => UpdateInsuranceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateInsuranceRequest copyWith(void Function(UpdateInsuranceRequest) updates) => super.copyWith((message) => updates(message as UpdateInsuranceRequest)) as UpdateInsuranceRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateInsuranceResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<Insurance>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'insurance', subBuilder: Insurance.create)
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  UpdateInsuranceResponse._() : super();
  factory UpdateInsuranceResponse({
    Insurance? insurance,
    $core.bool? success,
    $core.String? msg,
  }) {
    final _result = create();
    if (insurance != null) {
      _result.insurance = insurance;
    }
    if (success != null) {
      _result.success = success;
    }
    if (msg != null) {
      _result.msg = msg;
    }
    return _result;
  }
  factory UpdateInsuranceResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateInsuranceResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateInsuranceResponse clone() => UpdateInsuranceResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateInsuranceResponse copyWith(void Function(UpdateInsuranceResponse) updates) => super.copyWith((message) => updates(message as UpdateInsuranceResponse)) as UpdateInsuranceResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DeleteInsuranceRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..hasRequiredFields = false
  ;

  DeleteInsuranceRequest._() : super();
  factory DeleteInsuranceRequest({
    $core.String? id,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    return _result;
  }
  factory DeleteInsuranceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteInsuranceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteInsuranceRequest clone() => DeleteInsuranceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteInsuranceRequest copyWith(void Function(DeleteInsuranceRequest) updates) => super.copyWith((message) => updates(message as DeleteInsuranceRequest)) as DeleteInsuranceRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DeleteInsuranceResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  DeleteInsuranceResponse._() : super();
  factory DeleteInsuranceResponse({
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
  factory DeleteInsuranceResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteInsuranceResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteInsuranceResponse clone() => DeleteInsuranceResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteInsuranceResponse copyWith(void Function(DeleteInsuranceResponse) updates) => super.copyWith((message) => updates(message as DeleteInsuranceResponse)) as DeleteInsuranceResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SearchInsurancesRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'query')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  SearchInsurancesRequest._() : super();
  factory SearchInsurancesRequest({
    $core.String? query,
    $core.int? page,
    $core.int? limit,
  }) {
    final _result = create();
    if (query != null) {
      _result.query = query;
    }
    if (page != null) {
      _result.page = page;
    }
    if (limit != null) {
      _result.limit = limit;
    }
    return _result;
  }
  factory SearchInsurancesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SearchInsurancesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SearchInsurancesRequest clone() => SearchInsurancesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SearchInsurancesRequest copyWith(void Function(SearchInsurancesRequest) updates) => super.copyWith((message) => updates(message as SearchInsurancesRequest)) as SearchInsurancesRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SearchInsurancesResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<Insurance>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'insurances', $pb.PbFieldType.PM, subBuilder: Insurance.create)
    ..aOM<InsurancePaginationInfo>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pagination', subBuilder: InsurancePaginationInfo.create)
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  SearchInsurancesResponse._() : super();
  factory SearchInsurancesResponse({
    $core.Iterable<Insurance>? insurances,
    InsurancePaginationInfo? pagination,
    $core.bool? success,
    $core.String? msg,
  }) {
    final _result = create();
    if (insurances != null) {
      _result.insurances.addAll(insurances);
    }
    if (pagination != null) {
      _result.pagination = pagination;
    }
    if (success != null) {
      _result.success = success;
    }
    if (msg != null) {
      _result.msg = msg;
    }
    return _result;
  }
  factory SearchInsurancesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SearchInsurancesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SearchInsurancesResponse clone() => SearchInsurancesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SearchInsurancesResponse copyWith(void Function(SearchInsurancesResponse) updates) => super.copyWith((message) => updates(message as SearchInsurancesResponse)) as SearchInsurancesResponse; // ignore: deprecated_member_use
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

class GetInsurancePaymentsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInsurancePaymentsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'insuranceId')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetInsurancePaymentsRequest._() : super();
  factory GetInsurancePaymentsRequest({
    $core.String? insuranceId,
    $core.int? page,
    $core.int? limit,
  }) {
    final _result = create();
    if (insuranceId != null) {
      _result.insuranceId = insuranceId;
    }
    if (page != null) {
      _result.page = page;
    }
    if (limit != null) {
      _result.limit = limit;
    }
    return _result;
  }
  factory GetInsurancePaymentsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInsurancePaymentsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInsurancePaymentsRequest clone() => GetInsurancePaymentsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInsurancePaymentsRequest copyWith(void Function(GetInsurancePaymentsRequest) updates) => super.copyWith((message) => updates(message as GetInsurancePaymentsRequest)) as GetInsurancePaymentsRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInsurancePaymentsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<InsurancePayment>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payments', $pb.PbFieldType.PM, subBuilder: InsurancePayment.create)
    ..aOM<InsurancePaginationInfo>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pagination', subBuilder: InsurancePaginationInfo.create)
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  GetInsurancePaymentsResponse._() : super();
  factory GetInsurancePaymentsResponse({
    $core.Iterable<InsurancePayment>? payments,
    InsurancePaginationInfo? pagination,
    $core.bool? success,
    $core.String? msg,
  }) {
    final _result = create();
    if (payments != null) {
      _result.payments.addAll(payments);
    }
    if (pagination != null) {
      _result.pagination = pagination;
    }
    if (success != null) {
      _result.success = success;
    }
    if (msg != null) {
      _result.msg = msg;
    }
    return _result;
  }
  factory GetInsurancePaymentsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInsurancePaymentsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInsurancePaymentsResponse clone() => GetInsurancePaymentsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInsurancePaymentsResponse copyWith(void Function(GetInsurancePaymentsResponse) updates) => super.copyWith((message) => updates(message as GetInsurancePaymentsResponse)) as GetInsurancePaymentsResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetUserPaymentsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetUserPaymentsRequest._() : super();
  factory GetUserPaymentsRequest({
    $core.int? page,
    $core.int? limit,
  }) {
    final _result = create();
    if (page != null) {
      _result.page = page;
    }
    if (limit != null) {
      _result.limit = limit;
    }
    return _result;
  }
  factory GetUserPaymentsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserPaymentsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUserPaymentsRequest clone() => GetUserPaymentsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUserPaymentsRequest copyWith(void Function(GetUserPaymentsRequest) updates) => super.copyWith((message) => updates(message as GetUserPaymentsRequest)) as GetUserPaymentsRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetUserPaymentsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<InsurancePayment>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payments', $pb.PbFieldType.PM, subBuilder: InsurancePayment.create)
    ..aOM<InsurancePaginationInfo>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pagination', subBuilder: InsurancePaginationInfo.create)
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  GetUserPaymentsResponse._() : super();
  factory GetUserPaymentsResponse({
    $core.Iterable<InsurancePayment>? payments,
    InsurancePaginationInfo? pagination,
    $core.bool? success,
    $core.String? msg,
  }) {
    final _result = create();
    if (payments != null) {
      _result.payments.addAll(payments);
    }
    if (pagination != null) {
      _result.pagination = pagination;
    }
    if (success != null) {
      _result.success = success;
    }
    if (msg != null) {
      _result.msg = msg;
    }
    return _result;
  }
  factory GetUserPaymentsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserPaymentsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUserPaymentsResponse clone() => GetUserPaymentsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUserPaymentsResponse copyWith(void Function(GetUserPaymentsResponse) updates) => super.copyWith((message) => updates(message as GetUserPaymentsResponse)) as GetUserPaymentsResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreatePaymentRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<InsurancePayment>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payment', subBuilder: InsurancePayment.create)
    ..hasRequiredFields = false
  ;

  CreatePaymentRequest._() : super();
  factory CreatePaymentRequest({
    InsurancePayment? payment,
  }) {
    final _result = create();
    if (payment != null) {
      _result.payment = payment;
    }
    return _result;
  }
  factory CreatePaymentRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreatePaymentRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreatePaymentRequest clone() => CreatePaymentRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreatePaymentRequest copyWith(void Function(CreatePaymentRequest) updates) => super.copyWith((message) => updates(message as CreatePaymentRequest)) as CreatePaymentRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreatePaymentResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<InsurancePayment>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payment', subBuilder: InsurancePayment.create)
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  CreatePaymentResponse._() : super();
  factory CreatePaymentResponse({
    InsurancePayment? payment,
    $core.bool? success,
    $core.String? msg,
  }) {
    final _result = create();
    if (payment != null) {
      _result.payment = payment;
    }
    if (success != null) {
      _result.success = success;
    }
    if (msg != null) {
      _result.msg = msg;
    }
    return _result;
  }
  factory CreatePaymentResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreatePaymentResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreatePaymentResponse clone() => CreatePaymentResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreatePaymentResponse copyWith(void Function(CreatePaymentResponse) updates) => super.copyWith((message) => updates(message as CreatePaymentResponse)) as CreatePaymentResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProcessPaymentRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paymentId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paymentMethod')
    ..m<$core.String, $core.String>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paymentDetails', entryClassName: 'ProcessPaymentRequest.PaymentDetailsEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('pb'))
    ..hasRequiredFields = false
  ;

  ProcessPaymentRequest._() : super();
  factory ProcessPaymentRequest({
    $core.String? paymentId,
    $core.String? paymentMethod,
    $core.Map<$core.String, $core.String>? paymentDetails,
  }) {
    final _result = create();
    if (paymentId != null) {
      _result.paymentId = paymentId;
    }
    if (paymentMethod != null) {
      _result.paymentMethod = paymentMethod;
    }
    if (paymentDetails != null) {
      _result.paymentDetails.addAll(paymentDetails);
    }
    return _result;
  }
  factory ProcessPaymentRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProcessPaymentRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProcessPaymentRequest clone() => ProcessPaymentRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProcessPaymentRequest copyWith(void Function(ProcessPaymentRequest) updates) => super.copyWith((message) => updates(message as ProcessPaymentRequest)) as ProcessPaymentRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProcessPaymentResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<InsurancePayment>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payment', subBuilder: InsurancePayment.create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'referenceNumber')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'receiptUrl')
    ..aOB(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  ProcessPaymentResponse._() : super();
  factory ProcessPaymentResponse({
    InsurancePayment? payment,
    $core.String? transactionId,
    $core.String? referenceNumber,
    $core.String? receiptUrl,
    $core.bool? success,
    $core.String? msg,
  }) {
    final _result = create();
    if (payment != null) {
      _result.payment = payment;
    }
    if (transactionId != null) {
      _result.transactionId = transactionId;
    }
    if (referenceNumber != null) {
      _result.referenceNumber = referenceNumber;
    }
    if (receiptUrl != null) {
      _result.receiptUrl = receiptUrl;
    }
    if (success != null) {
      _result.success = success;
    }
    if (msg != null) {
      _result.msg = msg;
    }
    return _result;
  }
  factory ProcessPaymentResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProcessPaymentResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProcessPaymentResponse clone() => ProcessPaymentResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProcessPaymentResponse copyWith(void Function(ProcessPaymentResponse) updates) => super.copyWith((message) => updates(message as ProcessPaymentResponse)) as ProcessPaymentResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetPaymentByIdRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..hasRequiredFields = false
  ;

  GetPaymentByIdRequest._() : super();
  factory GetPaymentByIdRequest({
    $core.String? id,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    return _result;
  }
  factory GetPaymentByIdRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPaymentByIdRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPaymentByIdRequest clone() => GetPaymentByIdRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPaymentByIdRequest copyWith(void Function(GetPaymentByIdRequest) updates) => super.copyWith((message) => updates(message as GetPaymentByIdRequest)) as GetPaymentByIdRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetPaymentByIdResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<InsurancePayment>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payment', subBuilder: InsurancePayment.create)
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  GetPaymentByIdResponse._() : super();
  factory GetPaymentByIdResponse({
    InsurancePayment? payment,
    $core.bool? success,
    $core.String? msg,
  }) {
    final _result = create();
    if (payment != null) {
      _result.payment = payment;
    }
    if (success != null) {
      _result.success = success;
    }
    if (msg != null) {
      _result.msg = msg;
    }
    return _result;
  }
  factory GetPaymentByIdResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPaymentByIdResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPaymentByIdResponse clone() => GetPaymentByIdResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPaymentByIdResponse copyWith(void Function(GetPaymentByIdResponse) updates) => super.copyWith((message) => updates(message as GetPaymentByIdResponse)) as GetPaymentByIdResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetOverduePaymentsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetOverduePaymentsRequest._() : super();
  factory GetOverduePaymentsRequest() => create();
  factory GetOverduePaymentsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetOverduePaymentsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetOverduePaymentsRequest clone() => GetOverduePaymentsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetOverduePaymentsRequest copyWith(void Function(GetOverduePaymentsRequest) updates) => super.copyWith((message) => updates(message as GetOverduePaymentsRequest)) as GetOverduePaymentsRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetOverduePaymentsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<InsurancePayment>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payments', $pb.PbFieldType.PM, subBuilder: InsurancePayment.create)
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  GetOverduePaymentsResponse._() : super();
  factory GetOverduePaymentsResponse({
    $core.Iterable<InsurancePayment>? payments,
    $core.bool? success,
    $core.String? msg,
  }) {
    final _result = create();
    if (payments != null) {
      _result.payments.addAll(payments);
    }
    if (success != null) {
      _result.success = success;
    }
    if (msg != null) {
      _result.msg = msg;
    }
    return _result;
  }
  factory GetOverduePaymentsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetOverduePaymentsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetOverduePaymentsResponse clone() => GetOverduePaymentsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetOverduePaymentsResponse copyWith(void Function(GetOverduePaymentsResponse) updates) => super.copyWith((message) => updates(message as GetOverduePaymentsResponse)) as GetOverduePaymentsResponse; // ignore: deprecated_member_use
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

class GetInsuranceClaimsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInsuranceClaimsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'insuranceId')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetInsuranceClaimsRequest._() : super();
  factory GetInsuranceClaimsRequest({
    $core.String? insuranceId,
    $core.int? page,
    $core.int? limit,
  }) {
    final _result = create();
    if (insuranceId != null) {
      _result.insuranceId = insuranceId;
    }
    if (page != null) {
      _result.page = page;
    }
    if (limit != null) {
      _result.limit = limit;
    }
    return _result;
  }
  factory GetInsuranceClaimsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInsuranceClaimsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInsuranceClaimsRequest clone() => GetInsuranceClaimsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInsuranceClaimsRequest copyWith(void Function(GetInsuranceClaimsRequest) updates) => super.copyWith((message) => updates(message as GetInsuranceClaimsRequest)) as GetInsuranceClaimsRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInsuranceClaimsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<InsuranceClaim>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'claims', $pb.PbFieldType.PM, subBuilder: InsuranceClaim.create)
    ..aOM<InsurancePaginationInfo>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pagination', subBuilder: InsurancePaginationInfo.create)
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  GetInsuranceClaimsResponse._() : super();
  factory GetInsuranceClaimsResponse({
    $core.Iterable<InsuranceClaim>? claims,
    InsurancePaginationInfo? pagination,
    $core.bool? success,
    $core.String? msg,
  }) {
    final _result = create();
    if (claims != null) {
      _result.claims.addAll(claims);
    }
    if (pagination != null) {
      _result.pagination = pagination;
    }
    if (success != null) {
      _result.success = success;
    }
    if (msg != null) {
      _result.msg = msg;
    }
    return _result;
  }
  factory GetInsuranceClaimsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInsuranceClaimsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInsuranceClaimsResponse clone() => GetInsuranceClaimsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInsuranceClaimsResponse copyWith(void Function(GetInsuranceClaimsResponse) updates) => super.copyWith((message) => updates(message as GetInsuranceClaimsResponse)) as GetInsuranceClaimsResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetUserClaimsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetUserClaimsRequest._() : super();
  factory GetUserClaimsRequest({
    $core.int? page,
    $core.int? limit,
  }) {
    final _result = create();
    if (page != null) {
      _result.page = page;
    }
    if (limit != null) {
      _result.limit = limit;
    }
    return _result;
  }
  factory GetUserClaimsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserClaimsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUserClaimsRequest clone() => GetUserClaimsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUserClaimsRequest copyWith(void Function(GetUserClaimsRequest) updates) => super.copyWith((message) => updates(message as GetUserClaimsRequest)) as GetUserClaimsRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetUserClaimsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<InsuranceClaim>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'claims', $pb.PbFieldType.PM, subBuilder: InsuranceClaim.create)
    ..aOM<InsurancePaginationInfo>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pagination', subBuilder: InsurancePaginationInfo.create)
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  GetUserClaimsResponse._() : super();
  factory GetUserClaimsResponse({
    $core.Iterable<InsuranceClaim>? claims,
    InsurancePaginationInfo? pagination,
    $core.bool? success,
    $core.String? msg,
  }) {
    final _result = create();
    if (claims != null) {
      _result.claims.addAll(claims);
    }
    if (pagination != null) {
      _result.pagination = pagination;
    }
    if (success != null) {
      _result.success = success;
    }
    if (msg != null) {
      _result.msg = msg;
    }
    return _result;
  }
  factory GetUserClaimsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserClaimsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUserClaimsResponse clone() => GetUserClaimsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUserClaimsResponse copyWith(void Function(GetUserClaimsResponse) updates) => super.copyWith((message) => updates(message as GetUserClaimsResponse)) as GetUserClaimsResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateClaimRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<InsuranceClaim>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'claim', subBuilder: InsuranceClaim.create)
    ..hasRequiredFields = false
  ;

  CreateClaimRequest._() : super();
  factory CreateClaimRequest({
    InsuranceClaim? claim,
  }) {
    final _result = create();
    if (claim != null) {
      _result.claim = claim;
    }
    return _result;
  }
  factory CreateClaimRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateClaimRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateClaimRequest clone() => CreateClaimRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateClaimRequest copyWith(void Function(CreateClaimRequest) updates) => super.copyWith((message) => updates(message as CreateClaimRequest)) as CreateClaimRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateClaimResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<InsuranceClaim>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'claim', subBuilder: InsuranceClaim.create)
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  CreateClaimResponse._() : super();
  factory CreateClaimResponse({
    InsuranceClaim? claim,
    $core.bool? success,
    $core.String? msg,
  }) {
    final _result = create();
    if (claim != null) {
      _result.claim = claim;
    }
    if (success != null) {
      _result.success = success;
    }
    if (msg != null) {
      _result.msg = msg;
    }
    return _result;
  }
  factory CreateClaimResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateClaimResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateClaimResponse clone() => CreateClaimResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateClaimResponse copyWith(void Function(CreateClaimResponse) updates) => super.copyWith((message) => updates(message as CreateClaimResponse)) as CreateClaimResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateClaimRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<InsuranceClaim>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'claim', subBuilder: InsuranceClaim.create)
    ..hasRequiredFields = false
  ;

  UpdateClaimRequest._() : super();
  factory UpdateClaimRequest({
    InsuranceClaim? claim,
  }) {
    final _result = create();
    if (claim != null) {
      _result.claim = claim;
    }
    return _result;
  }
  factory UpdateClaimRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateClaimRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateClaimRequest clone() => UpdateClaimRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateClaimRequest copyWith(void Function(UpdateClaimRequest) updates) => super.copyWith((message) => updates(message as UpdateClaimRequest)) as UpdateClaimRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateClaimResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<InsuranceClaim>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'claim', subBuilder: InsuranceClaim.create)
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  UpdateClaimResponse._() : super();
  factory UpdateClaimResponse({
    InsuranceClaim? claim,
    $core.bool? success,
    $core.String? msg,
  }) {
    final _result = create();
    if (claim != null) {
      _result.claim = claim;
    }
    if (success != null) {
      _result.success = success;
    }
    if (msg != null) {
      _result.msg = msg;
    }
    return _result;
  }
  factory UpdateClaimResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateClaimResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateClaimResponse clone() => UpdateClaimResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateClaimResponse copyWith(void Function(UpdateClaimResponse) updates) => super.copyWith((message) => updates(message as UpdateClaimResponse)) as UpdateClaimResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetClaimByIdRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..hasRequiredFields = false
  ;

  GetClaimByIdRequest._() : super();
  factory GetClaimByIdRequest({
    $core.String? id,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    return _result;
  }
  factory GetClaimByIdRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetClaimByIdRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetClaimByIdRequest clone() => GetClaimByIdRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetClaimByIdRequest copyWith(void Function(GetClaimByIdRequest) updates) => super.copyWith((message) => updates(message as GetClaimByIdRequest)) as GetClaimByIdRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetClaimByIdResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<InsuranceClaim>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'claim', subBuilder: InsuranceClaim.create)
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  GetClaimByIdResponse._() : super();
  factory GetClaimByIdResponse({
    InsuranceClaim? claim,
    $core.bool? success,
    $core.String? msg,
  }) {
    final _result = create();
    if (claim != null) {
      _result.claim = claim;
    }
    if (success != null) {
      _result.success = success;
    }
    if (msg != null) {
      _result.msg = msg;
    }
    return _result;
  }
  factory GetClaimByIdResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetClaimByIdResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetClaimByIdResponse clone() => GetClaimByIdResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetClaimByIdResponse copyWith(void Function(GetClaimByIdResponse) updates) => super.copyWith((message) => updates(message as GetClaimByIdResponse)) as GetClaimByIdResponse; // ignore: deprecated_member_use
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

class GeneratePaymentReceiptRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GeneratePaymentReceiptRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paymentId')
    ..hasRequiredFields = false
  ;

  GeneratePaymentReceiptRequest._() : super();
  factory GeneratePaymentReceiptRequest({
    $core.String? paymentId,
  }) {
    final _result = create();
    if (paymentId != null) {
      _result.paymentId = paymentId;
    }
    return _result;
  }
  factory GeneratePaymentReceiptRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GeneratePaymentReceiptRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GeneratePaymentReceiptRequest clone() => GeneratePaymentReceiptRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GeneratePaymentReceiptRequest copyWith(void Function(GeneratePaymentReceiptRequest) updates) => super.copyWith((message) => updates(message as GeneratePaymentReceiptRequest)) as GeneratePaymentReceiptRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GeneratePaymentReceiptResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'receiptUrl')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'receiptId')
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  GeneratePaymentReceiptResponse._() : super();
  factory GeneratePaymentReceiptResponse({
    $core.String? receiptUrl,
    $core.String? receiptId,
    $core.bool? success,
    $core.String? msg,
  }) {
    final _result = create();
    if (receiptUrl != null) {
      _result.receiptUrl = receiptUrl;
    }
    if (receiptId != null) {
      _result.receiptId = receiptId;
    }
    if (success != null) {
      _result.success = success;
    }
    if (msg != null) {
      _result.msg = msg;
    }
    return _result;
  }
  factory GeneratePaymentReceiptResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GeneratePaymentReceiptResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GeneratePaymentReceiptResponse clone() => GeneratePaymentReceiptResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GeneratePaymentReceiptResponse copyWith(void Function(GeneratePaymentReceiptResponse) updates) => super.copyWith((message) => updates(message as GeneratePaymentReceiptResponse)) as GeneratePaymentReceiptResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetUserReceiptsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetUserReceiptsRequest._() : super();
  factory GetUserReceiptsRequest({
    $core.int? page,
    $core.int? limit,
  }) {
    final _result = create();
    if (page != null) {
      _result.page = page;
    }
    if (limit != null) {
      _result.limit = limit;
    }
    return _result;
  }
  factory GetUserReceiptsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserReceiptsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUserReceiptsRequest clone() => GetUserReceiptsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUserReceiptsRequest copyWith(void Function(GetUserReceiptsRequest) updates) => super.copyWith((message) => updates(message as GetUserReceiptsRequest)) as GetUserReceiptsRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetUserReceiptsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pPS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'receiptUrls')
    ..aOM<InsurancePaginationInfo>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pagination', subBuilder: InsurancePaginationInfo.create)
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  GetUserReceiptsResponse._() : super();
  factory GetUserReceiptsResponse({
    $core.Iterable<$core.String>? receiptUrls,
    InsurancePaginationInfo? pagination,
    $core.bool? success,
    $core.String? msg,
  }) {
    final _result = create();
    if (receiptUrls != null) {
      _result.receiptUrls.addAll(receiptUrls);
    }
    if (pagination != null) {
      _result.pagination = pagination;
    }
    if (success != null) {
      _result.success = success;
    }
    if (msg != null) {
      _result.msg = msg;
    }
    return _result;
  }
  factory GetUserReceiptsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserReceiptsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUserReceiptsResponse clone() => GetUserReceiptsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUserReceiptsResponse copyWith(void Function(GetUserReceiptsResponse) updates) => super.copyWith((message) => updates(message as GetUserReceiptsResponse)) as GetUserReceiptsResponse; // ignore: deprecated_member_use
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

class GetInsuranceStatisticsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInsuranceStatisticsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetInsuranceStatisticsRequest._() : super();
  factory GetInsuranceStatisticsRequest() => create();
  factory GetInsuranceStatisticsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInsuranceStatisticsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInsuranceStatisticsRequest clone() => GetInsuranceStatisticsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInsuranceStatisticsRequest copyWith(void Function(GetInsuranceStatisticsRequest) updates) => super.copyWith((message) => updates(message as GetInsuranceStatisticsRequest)) as GetInsuranceStatisticsRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInsuranceStatisticsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalPolicies', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'activePolicies', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'expiredPolicies', $pb.PbFieldType.O3)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalCoverageAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalPremiumAmount', $pb.PbFieldType.OD)
    ..m<$core.String, $core.int>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'policiesByType', entryClassName: 'GetInsuranceStatisticsResponse.PoliciesByTypeEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.O3, packageName: const $pb.PackageName('pb'))
    ..aOB(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  GetInsuranceStatisticsResponse._() : super();
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
    final _result = create();
    if (totalPolicies != null) {
      _result.totalPolicies = totalPolicies;
    }
    if (activePolicies != null) {
      _result.activePolicies = activePolicies;
    }
    if (expiredPolicies != null) {
      _result.expiredPolicies = expiredPolicies;
    }
    if (totalCoverageAmount != null) {
      _result.totalCoverageAmount = totalCoverageAmount;
    }
    if (totalPremiumAmount != null) {
      _result.totalPremiumAmount = totalPremiumAmount;
    }
    if (policiesByType != null) {
      _result.policiesByType.addAll(policiesByType);
    }
    if (success != null) {
      _result.success = success;
    }
    if (msg != null) {
      _result.msg = msg;
    }
    return _result;
  }
  factory GetInsuranceStatisticsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInsuranceStatisticsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInsuranceStatisticsResponse clone() => GetInsuranceStatisticsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInsuranceStatisticsResponse copyWith(void Function(GetInsuranceStatisticsResponse) updates) => super.copyWith((message) => updates(message as GetInsuranceStatisticsResponse)) as GetInsuranceStatisticsResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetPaymentStatisticsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'startDate')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'endDate')
    ..hasRequiredFields = false
  ;

  GetPaymentStatisticsRequest._() : super();
  factory GetPaymentStatisticsRequest({
    $core.String? startDate,
    $core.String? endDate,
  }) {
    final _result = create();
    if (startDate != null) {
      _result.startDate = startDate;
    }
    if (endDate != null) {
      _result.endDate = endDate;
    }
    return _result;
  }
  factory GetPaymentStatisticsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPaymentStatisticsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPaymentStatisticsRequest clone() => GetPaymentStatisticsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPaymentStatisticsRequest copyWith(void Function(GetPaymentStatisticsRequest) updates) => super.copyWith((message) => updates(message as GetPaymentStatisticsRequest)) as GetPaymentStatisticsRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetPaymentStatisticsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalPayments', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'completedPayments', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pendingPayments', $pb.PbFieldType.O3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'failedPayments', $pb.PbFieldType.O3)
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'completedAmount', $pb.PbFieldType.OD)
    ..m<$core.String, $core.int>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paymentsByMethod', entryClassName: 'GetPaymentStatisticsResponse.PaymentsByMethodEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.O3, packageName: const $pb.PackageName('pb'))
    ..aOB(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  GetPaymentStatisticsResponse._() : super();
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
    final _result = create();
    if (totalPayments != null) {
      _result.totalPayments = totalPayments;
    }
    if (completedPayments != null) {
      _result.completedPayments = completedPayments;
    }
    if (pendingPayments != null) {
      _result.pendingPayments = pendingPayments;
    }
    if (failedPayments != null) {
      _result.failedPayments = failedPayments;
    }
    if (totalAmount != null) {
      _result.totalAmount = totalAmount;
    }
    if (completedAmount != null) {
      _result.completedAmount = completedAmount;
    }
    if (paymentsByMethod != null) {
      _result.paymentsByMethod.addAll(paymentsByMethod);
    }
    if (success != null) {
      _result.success = success;
    }
    if (msg != null) {
      _result.msg = msg;
    }
    return _result;
  }
  factory GetPaymentStatisticsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPaymentStatisticsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPaymentStatisticsResponse clone() => GetPaymentStatisticsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPaymentStatisticsResponse copyWith(void Function(GetPaymentStatisticsResponse) updates) => super.copyWith((message) => updates(message as GetPaymentStatisticsResponse)) as GetPaymentStatisticsResponse; // ignore: deprecated_member_use
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

class InsuranceProductFormField extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'InsuranceProductFormField', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'label')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type')
    ..aOB(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'required')
    ..pPS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'options')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'defaultValue')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'validationRegex')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'placeholder')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..hasRequiredFields = false
  ;

  InsuranceProductFormField._() : super();
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
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    if (label != null) {
      _result.label = label;
    }
    if (type != null) {
      _result.type = type;
    }
    if (required != null) {
      _result.required = required;
    }
    if (options != null) {
      _result.options.addAll(options);
    }
    if (defaultValue != null) {
      _result.defaultValue = defaultValue;
    }
    if (validationRegex != null) {
      _result.validationRegex = validationRegex;
    }
    if (placeholder != null) {
      _result.placeholder = placeholder;
    }
    if (description != null) {
      _result.description = description;
    }
    return _result;
  }
  factory InsuranceProductFormField.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InsuranceProductFormField.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InsuranceProductFormField clone() => InsuranceProductFormField()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InsuranceProductFormField copyWith(void Function(InsuranceProductFormField) updates) => super.copyWith((message) => updates(message as InsuranceProductFormField)) as InsuranceProductFormField; // ignore: deprecated_member_use
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

class InsuranceProduct extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'InsuranceProduct', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'category')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerName')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerLogo')
    ..a<$core.double>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'minPremium', $pb.PbFieldType.OD)
    ..a<$core.double>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'maxPremium', $pb.PbFieldType.OD)
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..pPS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'benefits')
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'termsUrl')
    ..m<$core.String, $core.String>(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'metadata', entryClassName: 'InsuranceProduct.MetadataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('pb'))
    ..pc<InsuranceProductFormField>(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'formFields', $pb.PbFieldType.PM, subBuilder: InsuranceProductFormField.create)
    ..aOB(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isActive')
    ..aOS(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'purchaseRoute')
    ..aOS(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerId')
    ..a<$core.double>(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'basePrice', $pb.PbFieldType.OD)
    ..aOS(18, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'howItWorks')
    ..aOS(19, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fullBenefits')
    ..aOB(20, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isRenewable')
    ..aOB(21, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isClaimable')
    ..hasRequiredFields = false
  ;

  InsuranceProduct._() : super();
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
    $core.String? purchaseRoute,
    $core.String? providerId,
    $core.double? basePrice,
    $core.String? howItWorks,
    $core.String? fullBenefits,
    $core.bool? isRenewable,
    $core.bool? isClaimable,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (name != null) {
      _result.name = name;
    }
    if (description != null) {
      _result.description = description;
    }
    if (category != null) {
      _result.category = category;
    }
    if (providerName != null) {
      _result.providerName = providerName;
    }
    if (providerLogo != null) {
      _result.providerLogo = providerLogo;
    }
    if (minPremium != null) {
      _result.minPremium = minPremium;
    }
    if (maxPremium != null) {
      _result.maxPremium = maxPremium;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (benefits != null) {
      _result.benefits.addAll(benefits);
    }
    if (termsUrl != null) {
      _result.termsUrl = termsUrl;
    }
    if (metadata != null) {
      _result.metadata.addAll(metadata);
    }
    if (formFields != null) {
      _result.formFields.addAll(formFields);
    }
    if (isActive != null) {
      _result.isActive = isActive;
    }
    if (purchaseRoute != null) {
      _result.purchaseRoute = purchaseRoute;
    }
    if (providerId != null) {
      _result.providerId = providerId;
    }
    if (basePrice != null) {
      _result.basePrice = basePrice;
    }
    if (howItWorks != null) {
      _result.howItWorks = howItWorks;
    }
    if (fullBenefits != null) {
      _result.fullBenefits = fullBenefits;
    }
    if (isRenewable != null) {
      _result.isRenewable = isRenewable;
    }
    if (isClaimable != null) {
      _result.isClaimable = isClaimable;
    }
    return _result;
  }
  factory InsuranceProduct.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InsuranceProduct.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InsuranceProduct clone() => InsuranceProduct()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InsuranceProduct copyWith(void Function(InsuranceProduct) updates) => super.copyWith((message) => updates(message as InsuranceProduct)) as InsuranceProduct; // ignore: deprecated_member_use
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

  @$pb.TagNumber(15)
  $core.String get purchaseRoute => $_getSZ(14);
  @$pb.TagNumber(15)
  set purchaseRoute($core.String v) { $_setString(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasPurchaseRoute() => $_has(14);
  @$pb.TagNumber(15)
  void clearPurchaseRoute() => clearField(15);

  @$pb.TagNumber(16)
  $core.String get providerId => $_getSZ(15);
  @$pb.TagNumber(16)
  set providerId($core.String v) { $_setString(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasProviderId() => $_has(15);
  @$pb.TagNumber(16)
  void clearProviderId() => clearField(16);

  @$pb.TagNumber(17)
  $core.double get basePrice => $_getN(16);
  @$pb.TagNumber(17)
  set basePrice($core.double v) { $_setDouble(16, v); }
  @$pb.TagNumber(17)
  $core.bool hasBasePrice() => $_has(16);
  @$pb.TagNumber(17)
  void clearBasePrice() => clearField(17);

  @$pb.TagNumber(18)
  $core.String get howItWorks => $_getSZ(17);
  @$pb.TagNumber(18)
  set howItWorks($core.String v) { $_setString(17, v); }
  @$pb.TagNumber(18)
  $core.bool hasHowItWorks() => $_has(17);
  @$pb.TagNumber(18)
  void clearHowItWorks() => clearField(18);

  @$pb.TagNumber(19)
  $core.String get fullBenefits => $_getSZ(18);
  @$pb.TagNumber(19)
  set fullBenefits($core.String v) { $_setString(18, v); }
  @$pb.TagNumber(19)
  $core.bool hasFullBenefits() => $_has(18);
  @$pb.TagNumber(19)
  void clearFullBenefits() => clearField(19);

  @$pb.TagNumber(20)
  $core.bool get isRenewable => $_getBF(19);
  @$pb.TagNumber(20)
  set isRenewable($core.bool v) { $_setBool(19, v); }
  @$pb.TagNumber(20)
  $core.bool hasIsRenewable() => $_has(19);
  @$pb.TagNumber(20)
  void clearIsRenewable() => clearField(20);

  @$pb.TagNumber(21)
  $core.bool get isClaimable => $_getBF(20);
  @$pb.TagNumber(21)
  set isClaimable($core.bool v) { $_setBool(20, v); }
  @$pb.TagNumber(21)
  $core.bool hasIsClaimable() => $_has(20);
  @$pb.TagNumber(21)
  void clearIsClaimable() => clearField(21);
}

class InsuranceCategory extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'InsuranceCategory', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'icon')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'productCount', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  InsuranceCategory._() : super();
  factory InsuranceCategory({
    $core.String? id,
    $core.String? name,
    $core.String? icon,
    $core.String? description,
    $core.int? productCount,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (name != null) {
      _result.name = name;
    }
    if (icon != null) {
      _result.icon = icon;
    }
    if (description != null) {
      _result.description = description;
    }
    if (productCount != null) {
      _result.productCount = productCount;
    }
    return _result;
  }
  factory InsuranceCategory.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InsuranceCategory.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InsuranceCategory clone() => InsuranceCategory()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InsuranceCategory copyWith(void Function(InsuranceCategory) updates) => super.copyWith((message) => updates(message as InsuranceCategory)) as InsuranceCategory; // ignore: deprecated_member_use
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

class InsuranceQuote extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'InsuranceQuote', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'quoteId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'productId')
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'premium', $pb.PbFieldType.OD)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'coverageSummary')
    ..pPS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'coverageItems')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'validUntil')
    ..m<$core.String, $core.String>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'quoteDetails', entryClassName: 'InsuranceQuote.QuoteDetailsEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('pb'))
    ..hasRequiredFields = false
  ;

  InsuranceQuote._() : super();
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
    final _result = create();
    if (quoteId != null) {
      _result.quoteId = quoteId;
    }
    if (productId != null) {
      _result.productId = productId;
    }
    if (premium != null) {
      _result.premium = premium;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (coverageSummary != null) {
      _result.coverageSummary = coverageSummary;
    }
    if (coverageItems != null) {
      _result.coverageItems.addAll(coverageItems);
    }
    if (validUntil != null) {
      _result.validUntil = validUntil;
    }
    if (quoteDetails != null) {
      _result.quoteDetails.addAll(quoteDetails);
    }
    return _result;
  }
  factory InsuranceQuote.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InsuranceQuote.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InsuranceQuote clone() => InsuranceQuote()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InsuranceQuote copyWith(void Function(InsuranceQuote) updates) => super.copyWith((message) => updates(message as InsuranceQuote)) as InsuranceQuote; // ignore: deprecated_member_use
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

class InsurancePurchaseResult extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'InsurancePurchaseResult', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'policyId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'policyNumber')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reference')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerReference')
    ..aOM<Insurance>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'insurance', subBuilder: Insurance.create)
    ..hasRequiredFields = false
  ;

  InsurancePurchaseResult._() : super();
  factory InsurancePurchaseResult({
    $core.String? policyId,
    $core.String? policyNumber,
    $core.String? reference,
    $core.String? status,
    $core.String? providerReference,
    Insurance? insurance,
  }) {
    final _result = create();
    if (policyId != null) {
      _result.policyId = policyId;
    }
    if (policyNumber != null) {
      _result.policyNumber = policyNumber;
    }
    if (reference != null) {
      _result.reference = reference;
    }
    if (status != null) {
      _result.status = status;
    }
    if (providerReference != null) {
      _result.providerReference = providerReference;
    }
    if (insurance != null) {
      _result.insurance = insurance;
    }
    return _result;
  }
  factory InsurancePurchaseResult.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InsurancePurchaseResult.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InsurancePurchaseResult clone() => InsurancePurchaseResult()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InsurancePurchaseResult copyWith(void Function(InsurancePurchaseResult) updates) => super.copyWith((message) => updates(message as InsurancePurchaseResult)) as InsurancePurchaseResult; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInsuranceProductsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'category')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'locale')
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetInsuranceProductsRequest._() : super();
  factory GetInsuranceProductsRequest({
    $core.String? category,
    $core.String? locale,
    $core.int? page,
    $core.int? limit,
  }) {
    final _result = create();
    if (category != null) {
      _result.category = category;
    }
    if (locale != null) {
      _result.locale = locale;
    }
    if (page != null) {
      _result.page = page;
    }
    if (limit != null) {
      _result.limit = limit;
    }
    return _result;
  }
  factory GetInsuranceProductsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInsuranceProductsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInsuranceProductsRequest clone() => GetInsuranceProductsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInsuranceProductsRequest copyWith(void Function(GetInsuranceProductsRequest) updates) => super.copyWith((message) => updates(message as GetInsuranceProductsRequest)) as GetInsuranceProductsRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInsuranceProductsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<InsuranceProduct>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'products', $pb.PbFieldType.PM, subBuilder: InsuranceProduct.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'total', $pb.PbFieldType.O3)
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  GetInsuranceProductsResponse._() : super();
  factory GetInsuranceProductsResponse({
    $core.Iterable<InsuranceProduct>? products,
    $core.int? total,
    $core.bool? success,
    $core.String? msg,
  }) {
    final _result = create();
    if (products != null) {
      _result.products.addAll(products);
    }
    if (total != null) {
      _result.total = total;
    }
    if (success != null) {
      _result.success = success;
    }
    if (msg != null) {
      _result.msg = msg;
    }
    return _result;
  }
  factory GetInsuranceProductsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInsuranceProductsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInsuranceProductsResponse clone() => GetInsuranceProductsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInsuranceProductsResponse copyWith(void Function(GetInsuranceProductsResponse) updates) => super.copyWith((message) => updates(message as GetInsuranceProductsResponse)) as GetInsuranceProductsResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInsuranceCategoriesRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'locale')
    ..hasRequiredFields = false
  ;

  GetInsuranceCategoriesRequest._() : super();
  factory GetInsuranceCategoriesRequest({
    $core.String? locale,
  }) {
    final _result = create();
    if (locale != null) {
      _result.locale = locale;
    }
    return _result;
  }
  factory GetInsuranceCategoriesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInsuranceCategoriesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInsuranceCategoriesRequest clone() => GetInsuranceCategoriesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInsuranceCategoriesRequest copyWith(void Function(GetInsuranceCategoriesRequest) updates) => super.copyWith((message) => updates(message as GetInsuranceCategoriesRequest)) as GetInsuranceCategoriesRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInsuranceCategoriesResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<InsuranceCategory>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'categories', $pb.PbFieldType.PM, subBuilder: InsuranceCategory.create)
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  GetInsuranceCategoriesResponse._() : super();
  factory GetInsuranceCategoriesResponse({
    $core.Iterable<InsuranceCategory>? categories,
    $core.bool? success,
    $core.String? msg,
  }) {
    final _result = create();
    if (categories != null) {
      _result.categories.addAll(categories);
    }
    if (success != null) {
      _result.success = success;
    }
    if (msg != null) {
      _result.msg = msg;
    }
    return _result;
  }
  factory GetInsuranceCategoriesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInsuranceCategoriesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInsuranceCategoriesResponse clone() => GetInsuranceCategoriesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInsuranceCategoriesResponse copyWith(void Function(GetInsuranceCategoriesResponse) updates) => super.copyWith((message) => updates(message as GetInsuranceCategoriesResponse)) as GetInsuranceCategoriesResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInsuranceQuoteRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'productId')
    ..m<$core.String, $core.String>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'formData', entryClassName: 'GetInsuranceQuoteRequest.FormDataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('pb'))
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'locale')
    ..hasRequiredFields = false
  ;

  GetInsuranceQuoteRequest._() : super();
  factory GetInsuranceQuoteRequest({
    $core.String? productId,
    $core.Map<$core.String, $core.String>? formData,
    $core.String? locale,
  }) {
    final _result = create();
    if (productId != null) {
      _result.productId = productId;
    }
    if (formData != null) {
      _result.formData.addAll(formData);
    }
    if (locale != null) {
      _result.locale = locale;
    }
    return _result;
  }
  factory GetInsuranceQuoteRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInsuranceQuoteRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInsuranceQuoteRequest clone() => GetInsuranceQuoteRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInsuranceQuoteRequest copyWith(void Function(GetInsuranceQuoteRequest) updates) => super.copyWith((message) => updates(message as GetInsuranceQuoteRequest)) as GetInsuranceQuoteRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInsuranceQuoteResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<InsuranceQuote>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'quote', subBuilder: InsuranceQuote.create)
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  GetInsuranceQuoteResponse._() : super();
  factory GetInsuranceQuoteResponse({
    InsuranceQuote? quote,
    $core.bool? success,
    $core.String? msg,
  }) {
    final _result = create();
    if (quote != null) {
      _result.quote = quote;
    }
    if (success != null) {
      _result.success = success;
    }
    if (msg != null) {
      _result.msg = msg;
    }
    return _result;
  }
  factory GetInsuranceQuoteResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInsuranceQuoteResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInsuranceQuoteResponse clone() => GetInsuranceQuoteResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInsuranceQuoteResponse copyWith(void Function(GetInsuranceQuoteResponse) updates) => super.copyWith((message) => updates(message as GetInsuranceQuoteResponse)) as GetInsuranceQuoteResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PurchaseInsuranceRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'quoteId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'productId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountId')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionPin')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'idempotencyKey')
    ..m<$core.String, $core.String>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'formData', entryClassName: 'PurchaseInsuranceRequest.FormDataEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('pb'))
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'locale')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionId')
    ..hasRequiredFields = false
  ;

  PurchaseInsuranceRequest._() : super();
  factory PurchaseInsuranceRequest({
    $core.String? quoteId,
    $core.String? productId,
    $core.String? accountId,
    $core.String? transactionPin,
    $core.String? idempotencyKey,
    $core.Map<$core.String, $core.String>? formData,
    $core.String? locale,
    $core.String? transactionId,
  }) {
    final _result = create();
    if (quoteId != null) {
      _result.quoteId = quoteId;
    }
    if (productId != null) {
      _result.productId = productId;
    }
    if (accountId != null) {
      _result.accountId = accountId;
    }
    if (transactionPin != null) {
      _result.transactionPin = transactionPin;
    }
    if (idempotencyKey != null) {
      _result.idempotencyKey = idempotencyKey;
    }
    if (formData != null) {
      _result.formData.addAll(formData);
    }
    if (locale != null) {
      _result.locale = locale;
    }
    if (transactionId != null) {
      _result.transactionId = transactionId;
    }
    return _result;
  }
  factory PurchaseInsuranceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PurchaseInsuranceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PurchaseInsuranceRequest clone() => PurchaseInsuranceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PurchaseInsuranceRequest copyWith(void Function(PurchaseInsuranceRequest) updates) => super.copyWith((message) => updates(message as PurchaseInsuranceRequest)) as PurchaseInsuranceRequest; // ignore: deprecated_member_use
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

  @$pb.TagNumber(8)
  $core.String get transactionId => $_getSZ(7);
  @$pb.TagNumber(8)
  set transactionId($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasTransactionId() => $_has(7);
  @$pb.TagNumber(8)
  void clearTransactionId() => clearField(8);
}

class PurchaseInsuranceResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PurchaseInsuranceResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<InsurancePurchaseResult>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'result', subBuilder: InsurancePurchaseResult.create)
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  PurchaseInsuranceResponse._() : super();
  factory PurchaseInsuranceResponse({
    InsurancePurchaseResult? result,
    $core.bool? success,
    $core.String? msg,
  }) {
    final _result = create();
    if (result != null) {
      _result.result = result;
    }
    if (success != null) {
      _result.success = success;
    }
    if (msg != null) {
      _result.msg = msg;
    }
    return _result;
  }
  factory PurchaseInsuranceResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PurchaseInsuranceResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PurchaseInsuranceResponse clone() => PurchaseInsuranceResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PurchaseInsuranceResponse copyWith(void Function(PurchaseInsuranceResponse) updates) => super.copyWith((message) => updates(message as PurchaseInsuranceResponse)) as PurchaseInsuranceResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInsurancePurchaseStatusRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reference')
    ..hasRequiredFields = false
  ;

  GetInsurancePurchaseStatusRequest._() : super();
  factory GetInsurancePurchaseStatusRequest({
    $core.String? reference,
  }) {
    final _result = create();
    if (reference != null) {
      _result.reference = reference;
    }
    return _result;
  }
  factory GetInsurancePurchaseStatusRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInsurancePurchaseStatusRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInsurancePurchaseStatusRequest clone() => GetInsurancePurchaseStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInsurancePurchaseStatusRequest copyWith(void Function(GetInsurancePurchaseStatusRequest) updates) => super.copyWith((message) => updates(message as GetInsurancePurchaseStatusRequest)) as GetInsurancePurchaseStatusRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInsurancePurchaseStatusResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<InsurancePurchaseResult>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'result', subBuilder: InsurancePurchaseResult.create)
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  GetInsurancePurchaseStatusResponse._() : super();
  factory GetInsurancePurchaseStatusResponse({
    InsurancePurchaseResult? result,
    $core.bool? success,
    $core.String? msg,
  }) {
    final _result = create();
    if (result != null) {
      _result.result = result;
    }
    if (success != null) {
      _result.success = success;
    }
    if (msg != null) {
      _result.msg = msg;
    }
    return _result;
  }
  factory GetInsurancePurchaseStatusResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInsurancePurchaseStatusResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInsurancePurchaseStatusResponse clone() => GetInsurancePurchaseStatusResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInsurancePurchaseStatusResponse copyWith(void Function(GetInsurancePurchaseStatusResponse) updates) => super.copyWith((message) => updates(message as GetInsurancePurchaseStatusResponse)) as GetInsurancePurchaseStatusResponse; // ignore: deprecated_member_use
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

class UploadInsuranceDocumentRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UploadInsuranceDocumentRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fileData', $pb.PbFieldType.OY)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'filename')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'documentType')
    ..hasRequiredFields = false
  ;

  UploadInsuranceDocumentRequest._() : super();
  factory UploadInsuranceDocumentRequest({
    $core.List<$core.int>? fileData,
    $core.String? filename,
    $core.String? documentType,
  }) {
    final _result = create();
    if (fileData != null) {
      _result.fileData = fileData;
    }
    if (filename != null) {
      _result.filename = filename;
    }
    if (documentType != null) {
      _result.documentType = documentType;
    }
    return _result;
  }
  factory UploadInsuranceDocumentRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UploadInsuranceDocumentRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UploadInsuranceDocumentRequest clone() => UploadInsuranceDocumentRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UploadInsuranceDocumentRequest copyWith(void Function(UploadInsuranceDocumentRequest) updates) => super.copyWith((message) => updates(message as UploadInsuranceDocumentRequest)) as UploadInsuranceDocumentRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UploadInsuranceDocumentRequest create() => UploadInsuranceDocumentRequest._();
  UploadInsuranceDocumentRequest createEmptyInstance() => create();
  static $pb.PbList<UploadInsuranceDocumentRequest> createRepeated() => $pb.PbList<UploadInsuranceDocumentRequest>();
  @$core.pragma('dart2js:noInline')
  static UploadInsuranceDocumentRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UploadInsuranceDocumentRequest>(create);
  static UploadInsuranceDocumentRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get fileData => $_getN(0);
  @$pb.TagNumber(1)
  set fileData($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFileData() => $_has(0);
  @$pb.TagNumber(1)
  void clearFileData() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get filename => $_getSZ(1);
  @$pb.TagNumber(2)
  set filename($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFilename() => $_has(1);
  @$pb.TagNumber(2)
  void clearFilename() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get documentType => $_getSZ(2);
  @$pb.TagNumber(3)
  set documentType($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDocumentType() => $_has(2);
  @$pb.TagNumber(3)
  void clearDocumentType() => clearField(3);
}

class UploadInsuranceDocumentResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UploadInsuranceDocumentResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'uploadId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fileUrl')
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  UploadInsuranceDocumentResponse._() : super();
  factory UploadInsuranceDocumentResponse({
    $core.String? uploadId,
    $core.String? fileUrl,
    $core.bool? success,
    $core.String? msg,
  }) {
    final _result = create();
    if (uploadId != null) {
      _result.uploadId = uploadId;
    }
    if (fileUrl != null) {
      _result.fileUrl = fileUrl;
    }
    if (success != null) {
      _result.success = success;
    }
    if (msg != null) {
      _result.msg = msg;
    }
    return _result;
  }
  factory UploadInsuranceDocumentResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UploadInsuranceDocumentResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UploadInsuranceDocumentResponse clone() => UploadInsuranceDocumentResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UploadInsuranceDocumentResponse copyWith(void Function(UploadInsuranceDocumentResponse) updates) => super.copyWith((message) => updates(message as UploadInsuranceDocumentResponse)) as UploadInsuranceDocumentResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UploadInsuranceDocumentResponse create() => UploadInsuranceDocumentResponse._();
  UploadInsuranceDocumentResponse createEmptyInstance() => create();
  static $pb.PbList<UploadInsuranceDocumentResponse> createRepeated() => $pb.PbList<UploadInsuranceDocumentResponse>();
  @$core.pragma('dart2js:noInline')
  static UploadInsuranceDocumentResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UploadInsuranceDocumentResponse>(create);
  static UploadInsuranceDocumentResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get uploadId => $_getSZ(0);
  @$pb.TagNumber(1)
  set uploadId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUploadId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUploadId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get fileUrl => $_getSZ(1);
  @$pb.TagNumber(2)
  set fileUrl($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFileUrl() => $_has(1);
  @$pb.TagNumber(2)
  void clearFileUrl() => clearField(2);

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

class GetInsuranceAuxiliaryDataRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInsuranceAuxiliaryDataRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'utilityId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'query')
    ..hasRequiredFields = false
  ;

  GetInsuranceAuxiliaryDataRequest._() : super();
  factory GetInsuranceAuxiliaryDataRequest({
    $core.String? utilityId,
    $core.String? query,
  }) {
    final _result = create();
    if (utilityId != null) {
      _result.utilityId = utilityId;
    }
    if (query != null) {
      _result.query = query;
    }
    return _result;
  }
  factory GetInsuranceAuxiliaryDataRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInsuranceAuxiliaryDataRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInsuranceAuxiliaryDataRequest clone() => GetInsuranceAuxiliaryDataRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInsuranceAuxiliaryDataRequest copyWith(void Function(GetInsuranceAuxiliaryDataRequest) updates) => super.copyWith((message) => updates(message as GetInsuranceAuxiliaryDataRequest)) as GetInsuranceAuxiliaryDataRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetInsuranceAuxiliaryDataRequest create() => GetInsuranceAuxiliaryDataRequest._();
  GetInsuranceAuxiliaryDataRequest createEmptyInstance() => create();
  static $pb.PbList<GetInsuranceAuxiliaryDataRequest> createRepeated() => $pb.PbList<GetInsuranceAuxiliaryDataRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInsuranceAuxiliaryDataRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInsuranceAuxiliaryDataRequest>(create);
  static GetInsuranceAuxiliaryDataRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get utilityId => $_getSZ(0);
  @$pb.TagNumber(1)
  set utilityId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUtilityId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUtilityId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get query => $_getSZ(1);
  @$pb.TagNumber(2)
  set query($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasQuery() => $_has(1);
  @$pb.TagNumber(2)
  void clearQuery() => clearField(2);
}

class GetInsuranceAuxiliaryDataResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInsuranceAuxiliaryDataResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<InsuranceAuxiliaryItem>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'items', $pb.PbFieldType.PM, subBuilder: InsuranceAuxiliaryItem.create)
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  GetInsuranceAuxiliaryDataResponse._() : super();
  factory GetInsuranceAuxiliaryDataResponse({
    $core.Iterable<InsuranceAuxiliaryItem>? items,
    $core.bool? success,
    $core.String? msg,
  }) {
    final _result = create();
    if (items != null) {
      _result.items.addAll(items);
    }
    if (success != null) {
      _result.success = success;
    }
    if (msg != null) {
      _result.msg = msg;
    }
    return _result;
  }
  factory GetInsuranceAuxiliaryDataResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInsuranceAuxiliaryDataResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInsuranceAuxiliaryDataResponse clone() => GetInsuranceAuxiliaryDataResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInsuranceAuxiliaryDataResponse copyWith(void Function(GetInsuranceAuxiliaryDataResponse) updates) => super.copyWith((message) => updates(message as GetInsuranceAuxiliaryDataResponse)) as GetInsuranceAuxiliaryDataResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetInsuranceAuxiliaryDataResponse create() => GetInsuranceAuxiliaryDataResponse._();
  GetInsuranceAuxiliaryDataResponse createEmptyInstance() => create();
  static $pb.PbList<GetInsuranceAuxiliaryDataResponse> createRepeated() => $pb.PbList<GetInsuranceAuxiliaryDataResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInsuranceAuxiliaryDataResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInsuranceAuxiliaryDataResponse>(create);
  static GetInsuranceAuxiliaryDataResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<InsuranceAuxiliaryItem> get items => $_getList(0);

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

class InsuranceAuxiliaryItem extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'InsuranceAuxiliaryItem', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'label')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'value')
    ..hasRequiredFields = false
  ;

  InsuranceAuxiliaryItem._() : super();
  factory InsuranceAuxiliaryItem({
    $core.String? label,
    $core.String? value,
  }) {
    final _result = create();
    if (label != null) {
      _result.label = label;
    }
    if (value != null) {
      _result.value = value;
    }
    return _result;
  }
  factory InsuranceAuxiliaryItem.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InsuranceAuxiliaryItem.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InsuranceAuxiliaryItem clone() => InsuranceAuxiliaryItem()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InsuranceAuxiliaryItem copyWith(void Function(InsuranceAuxiliaryItem) updates) => super.copyWith((message) => updates(message as InsuranceAuxiliaryItem)) as InsuranceAuxiliaryItem; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static InsuranceAuxiliaryItem create() => InsuranceAuxiliaryItem._();
  InsuranceAuxiliaryItem createEmptyInstance() => create();
  static $pb.PbList<InsuranceAuxiliaryItem> createRepeated() => $pb.PbList<InsuranceAuxiliaryItem>();
  @$core.pragma('dart2js:noInline')
  static InsuranceAuxiliaryItem getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InsuranceAuxiliaryItem>(create);
  static InsuranceAuxiliaryItem? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get label => $_getSZ(0);
  @$pb.TagNumber(1)
  set label($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLabel() => $_has(0);
  @$pb.TagNumber(1)
  void clearLabel() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get value => $_getSZ(1);
  @$pb.TagNumber(2)
  set value($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearValue() => clearField(2);
}

class Insurance extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Insurance', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'policyNumber')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'policyHolderName')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'policyHolderEmail')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'policyHolderPhone')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'provider')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerLogo')
    ..a<$core.double>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'premiumAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'coverageAmount', $pb.PbFieldType.OD)
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOS(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'startDate')
    ..aOS(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'endDate')
    ..aOS(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'nextPaymentDate')
    ..aOS(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..pPS(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'beneficiaries')
    ..m<$core.String, $core.String>(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'coverageDetails', entryClassName: 'Insurance.CoverageDetailsEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('pb'))
    ..aOS(18, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..aOS(19, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(20, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt')
    ..aOS(21, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedAt')
    ..hasRequiredFields = false
  ;

  Insurance._() : super();
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
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (policyNumber != null) {
      _result.policyNumber = policyNumber;
    }
    if (policyHolderName != null) {
      _result.policyHolderName = policyHolderName;
    }
    if (policyHolderEmail != null) {
      _result.policyHolderEmail = policyHolderEmail;
    }
    if (policyHolderPhone != null) {
      _result.policyHolderPhone = policyHolderPhone;
    }
    if (type != null) {
      _result.type = type;
    }
    if (provider != null) {
      _result.provider = provider;
    }
    if (providerLogo != null) {
      _result.providerLogo = providerLogo;
    }
    if (premiumAmount != null) {
      _result.premiumAmount = premiumAmount;
    }
    if (coverageAmount != null) {
      _result.coverageAmount = coverageAmount;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (startDate != null) {
      _result.startDate = startDate;
    }
    if (endDate != null) {
      _result.endDate = endDate;
    }
    if (nextPaymentDate != null) {
      _result.nextPaymentDate = nextPaymentDate;
    }
    if (status != null) {
      _result.status = status;
    }
    if (beneficiaries != null) {
      _result.beneficiaries.addAll(beneficiaries);
    }
    if (coverageDetails != null) {
      _result.coverageDetails.addAll(coverageDetails);
    }
    if (description != null) {
      _result.description = description;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      _result.updatedAt = updatedAt;
    }
    return _result;
  }
  factory Insurance.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Insurance.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Insurance clone() => Insurance()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Insurance copyWith(void Function(Insurance) updates) => super.copyWith((message) => updates(message as Insurance)) as Insurance; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'InsurancePayment', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'insuranceId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'policyNumber')
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paymentMethod')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionId')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'referenceNumber')
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paymentDate')
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dueDate')
    ..aOS(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'processedAt')
    ..m<$core.String, $core.String>(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paymentDetails', entryClassName: 'InsurancePayment.PaymentDetailsEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('pb'))
    ..aOS(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'failureReason')
    ..aOS(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'receiptUrl')
    ..aOS(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt')
    ..aOS(18, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedAt')
    ..hasRequiredFields = false
  ;

  InsurancePayment._() : super();
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
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (insuranceId != null) {
      _result.insuranceId = insuranceId;
    }
    if (policyNumber != null) {
      _result.policyNumber = policyNumber;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (paymentMethod != null) {
      _result.paymentMethod = paymentMethod;
    }
    if (status != null) {
      _result.status = status;
    }
    if (transactionId != null) {
      _result.transactionId = transactionId;
    }
    if (referenceNumber != null) {
      _result.referenceNumber = referenceNumber;
    }
    if (paymentDate != null) {
      _result.paymentDate = paymentDate;
    }
    if (dueDate != null) {
      _result.dueDate = dueDate;
    }
    if (processedAt != null) {
      _result.processedAt = processedAt;
    }
    if (paymentDetails != null) {
      _result.paymentDetails.addAll(paymentDetails);
    }
    if (failureReason != null) {
      _result.failureReason = failureReason;
    }
    if (receiptUrl != null) {
      _result.receiptUrl = receiptUrl;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      _result.updatedAt = updatedAt;
    }
    return _result;
  }
  factory InsurancePayment.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InsurancePayment.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InsurancePayment clone() => InsurancePayment()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InsurancePayment copyWith(void Function(InsurancePayment) updates) => super.copyWith((message) => updates(message as InsurancePayment)) as InsurancePayment; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'InsuranceClaim', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'claimNumber')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'insuranceId')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'policyNumber')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'title')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..a<$core.double>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'claimAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'approvedAmount', $pb.PbFieldType.OD)
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOS(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'incidentDate')
    ..aOS(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'incidentLocation')
    ..pPS(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'attachments')
    ..pPS(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'documents')
    ..m<$core.String, $core.String>(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'additionalInfo', entryClassName: 'InsuranceClaim.AdditionalInfoEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('pb'))
    ..aOS(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'rejectionReason')
    ..aOS(18, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'settlementDate')
    ..aOS(19, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'settlementDetails')
    ..aOS(20, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(21, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt')
    ..aOS(22, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedAt')
    ..hasRequiredFields = false
  ;

  InsuranceClaim._() : super();
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
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (claimNumber != null) {
      _result.claimNumber = claimNumber;
    }
    if (insuranceId != null) {
      _result.insuranceId = insuranceId;
    }
    if (policyNumber != null) {
      _result.policyNumber = policyNumber;
    }
    if (type != null) {
      _result.type = type;
    }
    if (status != null) {
      _result.status = status;
    }
    if (title != null) {
      _result.title = title;
    }
    if (description != null) {
      _result.description = description;
    }
    if (claimAmount != null) {
      _result.claimAmount = claimAmount;
    }
    if (approvedAmount != null) {
      _result.approvedAmount = approvedAmount;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (incidentDate != null) {
      _result.incidentDate = incidentDate;
    }
    if (incidentLocation != null) {
      _result.incidentLocation = incidentLocation;
    }
    if (attachments != null) {
      _result.attachments.addAll(attachments);
    }
    if (documents != null) {
      _result.documents.addAll(documents);
    }
    if (additionalInfo != null) {
      _result.additionalInfo.addAll(additionalInfo);
    }
    if (rejectionReason != null) {
      _result.rejectionReason = rejectionReason;
    }
    if (settlementDate != null) {
      _result.settlementDate = settlementDate;
    }
    if (settlementDetails != null) {
      _result.settlementDetails = settlementDetails;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      _result.updatedAt = updatedAt;
    }
    return _result;
  }
  factory InsuranceClaim.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InsuranceClaim.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InsuranceClaim clone() => InsuranceClaim()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InsuranceClaim copyWith(void Function(InsuranceClaim) updates) => super.copyWith((message) => updates(message as InsuranceClaim)) as InsuranceClaim; // ignore: deprecated_member_use
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

class MyCoverCustomerInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MyCoverCustomerInfo', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'firstName')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lastName')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'email')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'phoneNumber')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'gender')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dateOfBirth')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedAt')
    ..hasRequiredFields = false
  ;

  MyCoverCustomerInfo._() : super();
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
    if (gender != null) {
      _result.gender = gender;
    }
    if (dateOfBirth != null) {
      _result.dateOfBirth = dateOfBirth;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      _result.updatedAt = updatedAt;
    }
    return _result;
  }
  factory MyCoverCustomerInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MyCoverCustomerInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MyCoverCustomerInfo clone() => MyCoverCustomerInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MyCoverCustomerInfo copyWith(void Function(MyCoverCustomerInfo) updates) => super.copyWith((message) => updates(message as MyCoverCustomerInfo)) as MyCoverCustomerInfo; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MyCoverCustomerInfo create() => MyCoverCustomerInfo._();
  MyCoverCustomerInfo createEmptyInstance() => create();
  static $pb.PbList<MyCoverCustomerInfo> createRepeated() => $pb.PbList<MyCoverCustomerInfo>();
  @$core.pragma('dart2js:noInline')
  static MyCoverCustomerInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MyCoverCustomerInfo>(create);
  static MyCoverCustomerInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
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
  $core.String get gender => $_getSZ(5);
  @$pb.TagNumber(6)
  set gender($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasGender() => $_has(5);
  @$pb.TagNumber(6)
  void clearGender() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get dateOfBirth => $_getSZ(6);
  @$pb.TagNumber(7)
  set dateOfBirth($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasDateOfBirth() => $_has(6);
  @$pb.TagNumber(7)
  void clearDateOfBirth() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get createdAt => $_getSZ(7);
  @$pb.TagNumber(8)
  set createdAt($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasCreatedAt() => $_has(7);
  @$pb.TagNumber(8)
  void clearCreatedAt() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get updatedAt => $_getSZ(8);
  @$pb.TagNumber(9)
  set updatedAt($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasUpdatedAt() => $_has(8);
  @$pb.TagNumber(9)
  void clearUpdatedAt() => clearField(9);
}

class MyCoverPurchaseInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MyCoverPurchaseInfo', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'appMode')
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isRenewal')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'customerId')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'distributorId')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paymentChannel')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paymentOption')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'policyId')
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'productCategoryId')
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'productId')
    ..aOS(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerId')
    ..aOS(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'countryId')
    ..aOS(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currencyId')
    ..aOS(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt')
    ..aOS(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedAt')
    ..aOS(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'customerName')
    ..aOS(18, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'customerEmail')
    ..aOS(19, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'customerPhone')
    ..aOS(20, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'policyNumber')
    ..aOS(21, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'certificateUrl')
    ..aOB(22, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'policyIsActive')
    ..aOS(23, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'policyAmount')
    ..aOS(24, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerName')
    ..aOS(25, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'productName')
    ..aOS(26, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'productCategoryName')
    ..hasRequiredFields = false
  ;

  MyCoverPurchaseInfo._() : super();
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
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (appMode != null) {
      _result.appMode = appMode;
    }
    if (isRenewal != null) {
      _result.isRenewal = isRenewal;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (customerId != null) {
      _result.customerId = customerId;
    }
    if (distributorId != null) {
      _result.distributorId = distributorId;
    }
    if (paymentChannel != null) {
      _result.paymentChannel = paymentChannel;
    }
    if (paymentOption != null) {
      _result.paymentOption = paymentOption;
    }
    if (policyId != null) {
      _result.policyId = policyId;
    }
    if (productCategoryId != null) {
      _result.productCategoryId = productCategoryId;
    }
    if (productId != null) {
      _result.productId = productId;
    }
    if (providerId != null) {
      _result.providerId = providerId;
    }
    if (countryId != null) {
      _result.countryId = countryId;
    }
    if (currencyId != null) {
      _result.currencyId = currencyId;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      _result.updatedAt = updatedAt;
    }
    if (customerName != null) {
      _result.customerName = customerName;
    }
    if (customerEmail != null) {
      _result.customerEmail = customerEmail;
    }
    if (customerPhone != null) {
      _result.customerPhone = customerPhone;
    }
    if (policyNumber != null) {
      _result.policyNumber = policyNumber;
    }
    if (certificateUrl != null) {
      _result.certificateUrl = certificateUrl;
    }
    if (policyIsActive != null) {
      _result.policyIsActive = policyIsActive;
    }
    if (policyAmount != null) {
      _result.policyAmount = policyAmount;
    }
    if (providerName != null) {
      _result.providerName = providerName;
    }
    if (productName != null) {
      _result.productName = productName;
    }
    if (productCategoryName != null) {
      _result.productCategoryName = productCategoryName;
    }
    return _result;
  }
  factory MyCoverPurchaseInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MyCoverPurchaseInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MyCoverPurchaseInfo clone() => MyCoverPurchaseInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MyCoverPurchaseInfo copyWith(void Function(MyCoverPurchaseInfo) updates) => super.copyWith((message) => updates(message as MyCoverPurchaseInfo)) as MyCoverPurchaseInfo; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MyCoverPurchaseInfo create() => MyCoverPurchaseInfo._();
  MyCoverPurchaseInfo createEmptyInstance() => create();
  static $pb.PbList<MyCoverPurchaseInfo> createRepeated() => $pb.PbList<MyCoverPurchaseInfo>();
  @$core.pragma('dart2js:noInline')
  static MyCoverPurchaseInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MyCoverPurchaseInfo>(create);
  static MyCoverPurchaseInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get appMode => $_getSZ(1);
  @$pb.TagNumber(2)
  set appMode($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAppMode() => $_has(1);
  @$pb.TagNumber(2)
  void clearAppMode() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get isRenewal => $_getBF(2);
  @$pb.TagNumber(3)
  set isRenewal($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasIsRenewal() => $_has(2);
  @$pb.TagNumber(3)
  void clearIsRenewal() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get amount => $_getSZ(3);
  @$pb.TagNumber(4)
  set amount($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearAmount() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get customerId => $_getSZ(4);
  @$pb.TagNumber(5)
  set customerId($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasCustomerId() => $_has(4);
  @$pb.TagNumber(5)
  void clearCustomerId() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get distributorId => $_getSZ(5);
  @$pb.TagNumber(6)
  set distributorId($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasDistributorId() => $_has(5);
  @$pb.TagNumber(6)
  void clearDistributorId() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get paymentChannel => $_getSZ(6);
  @$pb.TagNumber(7)
  set paymentChannel($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasPaymentChannel() => $_has(6);
  @$pb.TagNumber(7)
  void clearPaymentChannel() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get paymentOption => $_getSZ(7);
  @$pb.TagNumber(8)
  set paymentOption($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasPaymentOption() => $_has(7);
  @$pb.TagNumber(8)
  void clearPaymentOption() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get policyId => $_getSZ(8);
  @$pb.TagNumber(9)
  set policyId($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasPolicyId() => $_has(8);
  @$pb.TagNumber(9)
  void clearPolicyId() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get productCategoryId => $_getSZ(9);
  @$pb.TagNumber(10)
  set productCategoryId($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasProductCategoryId() => $_has(9);
  @$pb.TagNumber(10)
  void clearProductCategoryId() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get productId => $_getSZ(10);
  @$pb.TagNumber(11)
  set productId($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasProductId() => $_has(10);
  @$pb.TagNumber(11)
  void clearProductId() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get providerId => $_getSZ(11);
  @$pb.TagNumber(12)
  set providerId($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasProviderId() => $_has(11);
  @$pb.TagNumber(12)
  void clearProviderId() => clearField(12);

  @$pb.TagNumber(13)
  $core.String get countryId => $_getSZ(12);
  @$pb.TagNumber(13)
  set countryId($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasCountryId() => $_has(12);
  @$pb.TagNumber(13)
  void clearCountryId() => clearField(13);

  @$pb.TagNumber(14)
  $core.String get currencyId => $_getSZ(13);
  @$pb.TagNumber(14)
  set currencyId($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasCurrencyId() => $_has(13);
  @$pb.TagNumber(14)
  void clearCurrencyId() => clearField(14);

  @$pb.TagNumber(15)
  $core.String get createdAt => $_getSZ(14);
  @$pb.TagNumber(15)
  set createdAt($core.String v) { $_setString(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasCreatedAt() => $_has(14);
  @$pb.TagNumber(15)
  void clearCreatedAt() => clearField(15);

  @$pb.TagNumber(16)
  $core.String get updatedAt => $_getSZ(15);
  @$pb.TagNumber(16)
  set updatedAt($core.String v) { $_setString(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasUpdatedAt() => $_has(15);
  @$pb.TagNumber(16)
  void clearUpdatedAt() => clearField(16);

  @$pb.TagNumber(17)
  $core.String get customerName => $_getSZ(16);
  @$pb.TagNumber(17)
  set customerName($core.String v) { $_setString(16, v); }
  @$pb.TagNumber(17)
  $core.bool hasCustomerName() => $_has(16);
  @$pb.TagNumber(17)
  void clearCustomerName() => clearField(17);

  @$pb.TagNumber(18)
  $core.String get customerEmail => $_getSZ(17);
  @$pb.TagNumber(18)
  set customerEmail($core.String v) { $_setString(17, v); }
  @$pb.TagNumber(18)
  $core.bool hasCustomerEmail() => $_has(17);
  @$pb.TagNumber(18)
  void clearCustomerEmail() => clearField(18);

  @$pb.TagNumber(19)
  $core.String get customerPhone => $_getSZ(18);
  @$pb.TagNumber(19)
  set customerPhone($core.String v) { $_setString(18, v); }
  @$pb.TagNumber(19)
  $core.bool hasCustomerPhone() => $_has(18);
  @$pb.TagNumber(19)
  void clearCustomerPhone() => clearField(19);

  @$pb.TagNumber(20)
  $core.String get policyNumber => $_getSZ(19);
  @$pb.TagNumber(20)
  set policyNumber($core.String v) { $_setString(19, v); }
  @$pb.TagNumber(20)
  $core.bool hasPolicyNumber() => $_has(19);
  @$pb.TagNumber(20)
  void clearPolicyNumber() => clearField(20);

  @$pb.TagNumber(21)
  $core.String get certificateUrl => $_getSZ(20);
  @$pb.TagNumber(21)
  set certificateUrl($core.String v) { $_setString(20, v); }
  @$pb.TagNumber(21)
  $core.bool hasCertificateUrl() => $_has(20);
  @$pb.TagNumber(21)
  void clearCertificateUrl() => clearField(21);

  @$pb.TagNumber(22)
  $core.bool get policyIsActive => $_getBF(21);
  @$pb.TagNumber(22)
  set policyIsActive($core.bool v) { $_setBool(21, v); }
  @$pb.TagNumber(22)
  $core.bool hasPolicyIsActive() => $_has(21);
  @$pb.TagNumber(22)
  void clearPolicyIsActive() => clearField(22);

  @$pb.TagNumber(23)
  $core.String get policyAmount => $_getSZ(22);
  @$pb.TagNumber(23)
  set policyAmount($core.String v) { $_setString(22, v); }
  @$pb.TagNumber(23)
  $core.bool hasPolicyAmount() => $_has(22);
  @$pb.TagNumber(23)
  void clearPolicyAmount() => clearField(23);

  @$pb.TagNumber(24)
  $core.String get providerName => $_getSZ(23);
  @$pb.TagNumber(24)
  set providerName($core.String v) { $_setString(23, v); }
  @$pb.TagNumber(24)
  $core.bool hasProviderName() => $_has(23);
  @$pb.TagNumber(24)
  void clearProviderName() => clearField(24);

  @$pb.TagNumber(25)
  $core.String get productName => $_getSZ(24);
  @$pb.TagNumber(25)
  set productName($core.String v) { $_setString(24, v); }
  @$pb.TagNumber(25)
  $core.bool hasProductName() => $_has(24);
  @$pb.TagNumber(25)
  void clearProductName() => clearField(25);

  @$pb.TagNumber(26)
  $core.String get productCategoryName => $_getSZ(25);
  @$pb.TagNumber(26)
  set productCategoryName($core.String v) { $_setString(25, v); }
  @$pb.TagNumber(26)
  $core.bool hasProductCategoryName() => $_has(25);
  @$pb.TagNumber(26)
  void clearProductCategoryName() => clearField(26);
}

class MyCoverPolicyDetailInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MyCoverPolicyDetailInfo', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'appMode')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'firstName')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lastName')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'email')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'phoneNumber')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dateOfBirth')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'activationDate')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'startDate')
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'expirationDate')
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount')
    ..aOB(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isActive')
    ..aOB(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isSubmittedToProvider')
    ..aOS(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'customerId')
    ..aOS(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'productId')
    ..aOS(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'productCategoryId')
    ..aOS(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerId')
    ..aOS(18, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'purchaseId')
    ..aOS(19, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'policyNumber')
    ..aOS(20, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'certificateUrl')
    ..aOS(21, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt')
    ..aOS(22, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedAt')
    ..aOS(23, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerName')
    ..aOS(24, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'productName')
    ..hasRequiredFields = false
  ;

  MyCoverPolicyDetailInfo._() : super();
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
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (appMode != null) {
      _result.appMode = appMode;
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
    if (dateOfBirth != null) {
      _result.dateOfBirth = dateOfBirth;
    }
    if (activationDate != null) {
      _result.activationDate = activationDate;
    }
    if (startDate != null) {
      _result.startDate = startDate;
    }
    if (expirationDate != null) {
      _result.expirationDate = expirationDate;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (isActive != null) {
      _result.isActive = isActive;
    }
    if (isSubmittedToProvider != null) {
      _result.isSubmittedToProvider = isSubmittedToProvider;
    }
    if (customerId != null) {
      _result.customerId = customerId;
    }
    if (productId != null) {
      _result.productId = productId;
    }
    if (productCategoryId != null) {
      _result.productCategoryId = productCategoryId;
    }
    if (providerId != null) {
      _result.providerId = providerId;
    }
    if (purchaseId != null) {
      _result.purchaseId = purchaseId;
    }
    if (policyNumber != null) {
      _result.policyNumber = policyNumber;
    }
    if (certificateUrl != null) {
      _result.certificateUrl = certificateUrl;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      _result.updatedAt = updatedAt;
    }
    if (providerName != null) {
      _result.providerName = providerName;
    }
    if (productName != null) {
      _result.productName = productName;
    }
    return _result;
  }
  factory MyCoverPolicyDetailInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MyCoverPolicyDetailInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MyCoverPolicyDetailInfo clone() => MyCoverPolicyDetailInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MyCoverPolicyDetailInfo copyWith(void Function(MyCoverPolicyDetailInfo) updates) => super.copyWith((message) => updates(message as MyCoverPolicyDetailInfo)) as MyCoverPolicyDetailInfo; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MyCoverPolicyDetailInfo create() => MyCoverPolicyDetailInfo._();
  MyCoverPolicyDetailInfo createEmptyInstance() => create();
  static $pb.PbList<MyCoverPolicyDetailInfo> createRepeated() => $pb.PbList<MyCoverPolicyDetailInfo>();
  @$core.pragma('dart2js:noInline')
  static MyCoverPolicyDetailInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MyCoverPolicyDetailInfo>(create);
  static MyCoverPolicyDetailInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get appMode => $_getSZ(1);
  @$pb.TagNumber(2)
  set appMode($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAppMode() => $_has(1);
  @$pb.TagNumber(2)
  void clearAppMode() => clearField(2);

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
  $core.String get email => $_getSZ(4);
  @$pb.TagNumber(5)
  set email($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasEmail() => $_has(4);
  @$pb.TagNumber(5)
  void clearEmail() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get phoneNumber => $_getSZ(5);
  @$pb.TagNumber(6)
  set phoneNumber($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasPhoneNumber() => $_has(5);
  @$pb.TagNumber(6)
  void clearPhoneNumber() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get dateOfBirth => $_getSZ(6);
  @$pb.TagNumber(7)
  set dateOfBirth($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasDateOfBirth() => $_has(6);
  @$pb.TagNumber(7)
  void clearDateOfBirth() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get activationDate => $_getSZ(7);
  @$pb.TagNumber(8)
  set activationDate($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasActivationDate() => $_has(7);
  @$pb.TagNumber(8)
  void clearActivationDate() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get startDate => $_getSZ(8);
  @$pb.TagNumber(9)
  set startDate($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasStartDate() => $_has(8);
  @$pb.TagNumber(9)
  void clearStartDate() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get expirationDate => $_getSZ(9);
  @$pb.TagNumber(10)
  set expirationDate($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasExpirationDate() => $_has(9);
  @$pb.TagNumber(10)
  void clearExpirationDate() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get amount => $_getSZ(10);
  @$pb.TagNumber(11)
  set amount($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasAmount() => $_has(10);
  @$pb.TagNumber(11)
  void clearAmount() => clearField(11);

  @$pb.TagNumber(12)
  $core.bool get isActive => $_getBF(11);
  @$pb.TagNumber(12)
  set isActive($core.bool v) { $_setBool(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasIsActive() => $_has(11);
  @$pb.TagNumber(12)
  void clearIsActive() => clearField(12);

  @$pb.TagNumber(13)
  $core.bool get isSubmittedToProvider => $_getBF(12);
  @$pb.TagNumber(13)
  set isSubmittedToProvider($core.bool v) { $_setBool(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasIsSubmittedToProvider() => $_has(12);
  @$pb.TagNumber(13)
  void clearIsSubmittedToProvider() => clearField(13);

  @$pb.TagNumber(14)
  $core.String get customerId => $_getSZ(13);
  @$pb.TagNumber(14)
  set customerId($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasCustomerId() => $_has(13);
  @$pb.TagNumber(14)
  void clearCustomerId() => clearField(14);

  @$pb.TagNumber(15)
  $core.String get productId => $_getSZ(14);
  @$pb.TagNumber(15)
  set productId($core.String v) { $_setString(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasProductId() => $_has(14);
  @$pb.TagNumber(15)
  void clearProductId() => clearField(15);

  @$pb.TagNumber(16)
  $core.String get productCategoryId => $_getSZ(15);
  @$pb.TagNumber(16)
  set productCategoryId($core.String v) { $_setString(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasProductCategoryId() => $_has(15);
  @$pb.TagNumber(16)
  void clearProductCategoryId() => clearField(16);

  @$pb.TagNumber(17)
  $core.String get providerId => $_getSZ(16);
  @$pb.TagNumber(17)
  set providerId($core.String v) { $_setString(16, v); }
  @$pb.TagNumber(17)
  $core.bool hasProviderId() => $_has(16);
  @$pb.TagNumber(17)
  void clearProviderId() => clearField(17);

  @$pb.TagNumber(18)
  $core.String get purchaseId => $_getSZ(17);
  @$pb.TagNumber(18)
  set purchaseId($core.String v) { $_setString(17, v); }
  @$pb.TagNumber(18)
  $core.bool hasPurchaseId() => $_has(17);
  @$pb.TagNumber(18)
  void clearPurchaseId() => clearField(18);

  @$pb.TagNumber(19)
  $core.String get policyNumber => $_getSZ(18);
  @$pb.TagNumber(19)
  set policyNumber($core.String v) { $_setString(18, v); }
  @$pb.TagNumber(19)
  $core.bool hasPolicyNumber() => $_has(18);
  @$pb.TagNumber(19)
  void clearPolicyNumber() => clearField(19);

  @$pb.TagNumber(20)
  $core.String get certificateUrl => $_getSZ(19);
  @$pb.TagNumber(20)
  set certificateUrl($core.String v) { $_setString(19, v); }
  @$pb.TagNumber(20)
  $core.bool hasCertificateUrl() => $_has(19);
  @$pb.TagNumber(20)
  void clearCertificateUrl() => clearField(20);

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

  @$pb.TagNumber(23)
  $core.String get providerName => $_getSZ(22);
  @$pb.TagNumber(23)
  set providerName($core.String v) { $_setString(22, v); }
  @$pb.TagNumber(23)
  $core.bool hasProviderName() => $_has(22);
  @$pb.TagNumber(23)
  void clearProviderName() => clearField(23);

  @$pb.TagNumber(24)
  $core.String get productName => $_getSZ(23);
  @$pb.TagNumber(24)
  set productName($core.String v) { $_setString(23, v); }
  @$pb.TagNumber(24)
  $core.bool hasProductName() => $_has(23);
  @$pb.TagNumber(24)
  void clearProductName() => clearField(24);
}

class MyCoverClaimInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MyCoverClaimInfo', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type')
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'policyId')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'customerId')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'claimNumber')
    ..pPS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'documents')
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'rejectionReason')
    ..a<$core.double>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'approvedAmount', $pb.PbFieldType.OD)
    ..aOS(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt')
    ..aOS(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedAt')
    ..hasRequiredFields = false
  ;

  MyCoverClaimInfo._() : super();
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
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (status != null) {
      _result.status = status;
    }
    if (type != null) {
      _result.type = type;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (description != null) {
      _result.description = description;
    }
    if (policyId != null) {
      _result.policyId = policyId;
    }
    if (customerId != null) {
      _result.customerId = customerId;
    }
    if (claimNumber != null) {
      _result.claimNumber = claimNumber;
    }
    if (documents != null) {
      _result.documents.addAll(documents);
    }
    if (rejectionReason != null) {
      _result.rejectionReason = rejectionReason;
    }
    if (approvedAmount != null) {
      _result.approvedAmount = approvedAmount;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      _result.updatedAt = updatedAt;
    }
    return _result;
  }
  factory MyCoverClaimInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MyCoverClaimInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MyCoverClaimInfo clone() => MyCoverClaimInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MyCoverClaimInfo copyWith(void Function(MyCoverClaimInfo) updates) => super.copyWith((message) => updates(message as MyCoverClaimInfo)) as MyCoverClaimInfo; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MyCoverClaimInfo create() => MyCoverClaimInfo._();
  MyCoverClaimInfo createEmptyInstance() => create();
  static $pb.PbList<MyCoverClaimInfo> createRepeated() => $pb.PbList<MyCoverClaimInfo>();
  @$core.pragma('dart2js:noInline')
  static MyCoverClaimInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MyCoverClaimInfo>(create);
  static MyCoverClaimInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get status => $_getSZ(1);
  @$pb.TagNumber(2)
  set status($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get type => $_getSZ(2);
  @$pb.TagNumber(3)
  set type($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasType() => $_has(2);
  @$pb.TagNumber(3)
  void clearType() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get amount => $_getN(3);
  @$pb.TagNumber(4)
  set amount($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearAmount() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get description => $_getSZ(4);
  @$pb.TagNumber(5)
  set description($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasDescription() => $_has(4);
  @$pb.TagNumber(5)
  void clearDescription() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get policyId => $_getSZ(5);
  @$pb.TagNumber(6)
  set policyId($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasPolicyId() => $_has(5);
  @$pb.TagNumber(6)
  void clearPolicyId() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get customerId => $_getSZ(6);
  @$pb.TagNumber(7)
  set customerId($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasCustomerId() => $_has(6);
  @$pb.TagNumber(7)
  void clearCustomerId() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get claimNumber => $_getSZ(7);
  @$pb.TagNumber(8)
  set claimNumber($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasClaimNumber() => $_has(7);
  @$pb.TagNumber(8)
  void clearClaimNumber() => clearField(8);

  @$pb.TagNumber(9)
  $core.List<$core.String> get documents => $_getList(8);

  @$pb.TagNumber(10)
  $core.String get rejectionReason => $_getSZ(9);
  @$pb.TagNumber(10)
  set rejectionReason($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasRejectionReason() => $_has(9);
  @$pb.TagNumber(10)
  void clearRejectionReason() => clearField(10);

  @$pb.TagNumber(11)
  $core.double get approvedAmount => $_getN(10);
  @$pb.TagNumber(11)
  set approvedAmount($core.double v) { $_setDouble(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasApprovedAmount() => $_has(10);
  @$pb.TagNumber(11)
  void clearApprovedAmount() => clearField(11);

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
}

class GetMyCoverCustomersRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetMyCoverCustomersRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetMyCoverCustomersRequest._() : super();
  factory GetMyCoverCustomersRequest({
    $core.int? page,
    $core.int? limit,
  }) {
    final _result = create();
    if (page != null) {
      _result.page = page;
    }
    if (limit != null) {
      _result.limit = limit;
    }
    return _result;
  }
  factory GetMyCoverCustomersRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyCoverCustomersRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyCoverCustomersRequest clone() => GetMyCoverCustomersRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyCoverCustomersRequest copyWith(void Function(GetMyCoverCustomersRequest) updates) => super.copyWith((message) => updates(message as GetMyCoverCustomersRequest)) as GetMyCoverCustomersRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetMyCoverCustomersRequest create() => GetMyCoverCustomersRequest._();
  GetMyCoverCustomersRequest createEmptyInstance() => create();
  static $pb.PbList<GetMyCoverCustomersRequest> createRepeated() => $pb.PbList<GetMyCoverCustomersRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMyCoverCustomersRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMyCoverCustomersRequest>(create);
  static GetMyCoverCustomersRequest? _defaultInstance;

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

class GetMyCoverCustomersResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetMyCoverCustomersResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<MyCoverCustomerInfo>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'customers', $pb.PbFieldType.PM, subBuilder: MyCoverCustomerInfo.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'total', $pb.PbFieldType.O3)
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  GetMyCoverCustomersResponse._() : super();
  factory GetMyCoverCustomersResponse({
    $core.Iterable<MyCoverCustomerInfo>? customers,
    $core.int? total,
    $core.bool? success,
    $core.String? msg,
  }) {
    final _result = create();
    if (customers != null) {
      _result.customers.addAll(customers);
    }
    if (total != null) {
      _result.total = total;
    }
    if (success != null) {
      _result.success = success;
    }
    if (msg != null) {
      _result.msg = msg;
    }
    return _result;
  }
  factory GetMyCoverCustomersResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyCoverCustomersResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyCoverCustomersResponse clone() => GetMyCoverCustomersResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyCoverCustomersResponse copyWith(void Function(GetMyCoverCustomersResponse) updates) => super.copyWith((message) => updates(message as GetMyCoverCustomersResponse)) as GetMyCoverCustomersResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetMyCoverCustomersResponse create() => GetMyCoverCustomersResponse._();
  GetMyCoverCustomersResponse createEmptyInstance() => create();
  static $pb.PbList<GetMyCoverCustomersResponse> createRepeated() => $pb.PbList<GetMyCoverCustomersResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMyCoverCustomersResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMyCoverCustomersResponse>(create);
  static GetMyCoverCustomersResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<MyCoverCustomerInfo> get customers => $_getList(0);

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

class GetMyCoverCustomerByIdRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetMyCoverCustomerByIdRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'customerId')
    ..hasRequiredFields = false
  ;

  GetMyCoverCustomerByIdRequest._() : super();
  factory GetMyCoverCustomerByIdRequest({
    $core.String? customerId,
  }) {
    final _result = create();
    if (customerId != null) {
      _result.customerId = customerId;
    }
    return _result;
  }
  factory GetMyCoverCustomerByIdRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyCoverCustomerByIdRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyCoverCustomerByIdRequest clone() => GetMyCoverCustomerByIdRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyCoverCustomerByIdRequest copyWith(void Function(GetMyCoverCustomerByIdRequest) updates) => super.copyWith((message) => updates(message as GetMyCoverCustomerByIdRequest)) as GetMyCoverCustomerByIdRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetMyCoverCustomerByIdRequest create() => GetMyCoverCustomerByIdRequest._();
  GetMyCoverCustomerByIdRequest createEmptyInstance() => create();
  static $pb.PbList<GetMyCoverCustomerByIdRequest> createRepeated() => $pb.PbList<GetMyCoverCustomerByIdRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMyCoverCustomerByIdRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMyCoverCustomerByIdRequest>(create);
  static GetMyCoverCustomerByIdRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get customerId => $_getSZ(0);
  @$pb.TagNumber(1)
  set customerId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCustomerId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCustomerId() => clearField(1);
}

class GetMyCoverCustomerByIdResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetMyCoverCustomerByIdResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<MyCoverCustomerInfo>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'customer', subBuilder: MyCoverCustomerInfo.create)
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  GetMyCoverCustomerByIdResponse._() : super();
  factory GetMyCoverCustomerByIdResponse({
    MyCoverCustomerInfo? customer,
    $core.bool? success,
    $core.String? msg,
  }) {
    final _result = create();
    if (customer != null) {
      _result.customer = customer;
    }
    if (success != null) {
      _result.success = success;
    }
    if (msg != null) {
      _result.msg = msg;
    }
    return _result;
  }
  factory GetMyCoverCustomerByIdResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyCoverCustomerByIdResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyCoverCustomerByIdResponse clone() => GetMyCoverCustomerByIdResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyCoverCustomerByIdResponse copyWith(void Function(GetMyCoverCustomerByIdResponse) updates) => super.copyWith((message) => updates(message as GetMyCoverCustomerByIdResponse)) as GetMyCoverCustomerByIdResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetMyCoverCustomerByIdResponse create() => GetMyCoverCustomerByIdResponse._();
  GetMyCoverCustomerByIdResponse createEmptyInstance() => create();
  static $pb.PbList<GetMyCoverCustomerByIdResponse> createRepeated() => $pb.PbList<GetMyCoverCustomerByIdResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMyCoverCustomerByIdResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMyCoverCustomerByIdResponse>(create);
  static GetMyCoverCustomerByIdResponse? _defaultInstance;

  @$pb.TagNumber(1)
  MyCoverCustomerInfo get customer => $_getN(0);
  @$pb.TagNumber(1)
  set customer(MyCoverCustomerInfo v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasCustomer() => $_has(0);
  @$pb.TagNumber(1)
  void clearCustomer() => clearField(1);
  @$pb.TagNumber(1)
  MyCoverCustomerInfo ensureCustomer() => $_ensure(0);

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

class GetMyCoverCustomerPoliciesRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetMyCoverCustomerPoliciesRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'customerId')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetMyCoverCustomerPoliciesRequest._() : super();
  factory GetMyCoverCustomerPoliciesRequest({
    $core.String? customerId,
    $core.int? page,
    $core.int? limit,
  }) {
    final _result = create();
    if (customerId != null) {
      _result.customerId = customerId;
    }
    if (page != null) {
      _result.page = page;
    }
    if (limit != null) {
      _result.limit = limit;
    }
    return _result;
  }
  factory GetMyCoverCustomerPoliciesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyCoverCustomerPoliciesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyCoverCustomerPoliciesRequest clone() => GetMyCoverCustomerPoliciesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyCoverCustomerPoliciesRequest copyWith(void Function(GetMyCoverCustomerPoliciesRequest) updates) => super.copyWith((message) => updates(message as GetMyCoverCustomerPoliciesRequest)) as GetMyCoverCustomerPoliciesRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetMyCoverCustomerPoliciesRequest create() => GetMyCoverCustomerPoliciesRequest._();
  GetMyCoverCustomerPoliciesRequest createEmptyInstance() => create();
  static $pb.PbList<GetMyCoverCustomerPoliciesRequest> createRepeated() => $pb.PbList<GetMyCoverCustomerPoliciesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMyCoverCustomerPoliciesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMyCoverCustomerPoliciesRequest>(create);
  static GetMyCoverCustomerPoliciesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get customerId => $_getSZ(0);
  @$pb.TagNumber(1)
  set customerId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCustomerId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCustomerId() => clearField(1);

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

class GetMyCoverCustomerPoliciesResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetMyCoverCustomerPoliciesResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<MyCoverPolicyDetailInfo>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'policies', $pb.PbFieldType.PM, subBuilder: MyCoverPolicyDetailInfo.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'total', $pb.PbFieldType.O3)
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  GetMyCoverCustomerPoliciesResponse._() : super();
  factory GetMyCoverCustomerPoliciesResponse({
    $core.Iterable<MyCoverPolicyDetailInfo>? policies,
    $core.int? total,
    $core.bool? success,
    $core.String? msg,
  }) {
    final _result = create();
    if (policies != null) {
      _result.policies.addAll(policies);
    }
    if (total != null) {
      _result.total = total;
    }
    if (success != null) {
      _result.success = success;
    }
    if (msg != null) {
      _result.msg = msg;
    }
    return _result;
  }
  factory GetMyCoverCustomerPoliciesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyCoverCustomerPoliciesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyCoverCustomerPoliciesResponse clone() => GetMyCoverCustomerPoliciesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyCoverCustomerPoliciesResponse copyWith(void Function(GetMyCoverCustomerPoliciesResponse) updates) => super.copyWith((message) => updates(message as GetMyCoverCustomerPoliciesResponse)) as GetMyCoverCustomerPoliciesResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetMyCoverCustomerPoliciesResponse create() => GetMyCoverCustomerPoliciesResponse._();
  GetMyCoverCustomerPoliciesResponse createEmptyInstance() => create();
  static $pb.PbList<GetMyCoverCustomerPoliciesResponse> createRepeated() => $pb.PbList<GetMyCoverCustomerPoliciesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMyCoverCustomerPoliciesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMyCoverCustomerPoliciesResponse>(create);
  static GetMyCoverCustomerPoliciesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<MyCoverPolicyDetailInfo> get policies => $_getList(0);

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

class GetMyCoverCustomerPurchasesRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetMyCoverCustomerPurchasesRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'customerId')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetMyCoverCustomerPurchasesRequest._() : super();
  factory GetMyCoverCustomerPurchasesRequest({
    $core.String? customerId,
    $core.int? page,
    $core.int? limit,
  }) {
    final _result = create();
    if (customerId != null) {
      _result.customerId = customerId;
    }
    if (page != null) {
      _result.page = page;
    }
    if (limit != null) {
      _result.limit = limit;
    }
    return _result;
  }
  factory GetMyCoverCustomerPurchasesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyCoverCustomerPurchasesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyCoverCustomerPurchasesRequest clone() => GetMyCoverCustomerPurchasesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyCoverCustomerPurchasesRequest copyWith(void Function(GetMyCoverCustomerPurchasesRequest) updates) => super.copyWith((message) => updates(message as GetMyCoverCustomerPurchasesRequest)) as GetMyCoverCustomerPurchasesRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetMyCoverCustomerPurchasesRequest create() => GetMyCoverCustomerPurchasesRequest._();
  GetMyCoverCustomerPurchasesRequest createEmptyInstance() => create();
  static $pb.PbList<GetMyCoverCustomerPurchasesRequest> createRepeated() => $pb.PbList<GetMyCoverCustomerPurchasesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMyCoverCustomerPurchasesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMyCoverCustomerPurchasesRequest>(create);
  static GetMyCoverCustomerPurchasesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get customerId => $_getSZ(0);
  @$pb.TagNumber(1)
  set customerId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCustomerId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCustomerId() => clearField(1);

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

class GetMyCoverCustomerPurchasesResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetMyCoverCustomerPurchasesResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<MyCoverPurchaseInfo>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'purchases', $pb.PbFieldType.PM, subBuilder: MyCoverPurchaseInfo.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'total', $pb.PbFieldType.O3)
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  GetMyCoverCustomerPurchasesResponse._() : super();
  factory GetMyCoverCustomerPurchasesResponse({
    $core.Iterable<MyCoverPurchaseInfo>? purchases,
    $core.int? total,
    $core.bool? success,
    $core.String? msg,
  }) {
    final _result = create();
    if (purchases != null) {
      _result.purchases.addAll(purchases);
    }
    if (total != null) {
      _result.total = total;
    }
    if (success != null) {
      _result.success = success;
    }
    if (msg != null) {
      _result.msg = msg;
    }
    return _result;
  }
  factory GetMyCoverCustomerPurchasesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyCoverCustomerPurchasesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyCoverCustomerPurchasesResponse clone() => GetMyCoverCustomerPurchasesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyCoverCustomerPurchasesResponse copyWith(void Function(GetMyCoverCustomerPurchasesResponse) updates) => super.copyWith((message) => updates(message as GetMyCoverCustomerPurchasesResponse)) as GetMyCoverCustomerPurchasesResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetMyCoverCustomerPurchasesResponse create() => GetMyCoverCustomerPurchasesResponse._();
  GetMyCoverCustomerPurchasesResponse createEmptyInstance() => create();
  static $pb.PbList<GetMyCoverCustomerPurchasesResponse> createRepeated() => $pb.PbList<GetMyCoverCustomerPurchasesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMyCoverCustomerPurchasesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMyCoverCustomerPurchasesResponse>(create);
  static GetMyCoverCustomerPurchasesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<MyCoverPurchaseInfo> get purchases => $_getList(0);

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

class GetMyCoverPurchasesRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetMyCoverPurchasesRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetMyCoverPurchasesRequest._() : super();
  factory GetMyCoverPurchasesRequest({
    $core.int? page,
    $core.int? limit,
  }) {
    final _result = create();
    if (page != null) {
      _result.page = page;
    }
    if (limit != null) {
      _result.limit = limit;
    }
    return _result;
  }
  factory GetMyCoverPurchasesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyCoverPurchasesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyCoverPurchasesRequest clone() => GetMyCoverPurchasesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyCoverPurchasesRequest copyWith(void Function(GetMyCoverPurchasesRequest) updates) => super.copyWith((message) => updates(message as GetMyCoverPurchasesRequest)) as GetMyCoverPurchasesRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetMyCoverPurchasesRequest create() => GetMyCoverPurchasesRequest._();
  GetMyCoverPurchasesRequest createEmptyInstance() => create();
  static $pb.PbList<GetMyCoverPurchasesRequest> createRepeated() => $pb.PbList<GetMyCoverPurchasesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMyCoverPurchasesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMyCoverPurchasesRequest>(create);
  static GetMyCoverPurchasesRequest? _defaultInstance;

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

class GetMyCoverPurchasesResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetMyCoverPurchasesResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<MyCoverPurchaseInfo>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'purchases', $pb.PbFieldType.PM, subBuilder: MyCoverPurchaseInfo.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'total', $pb.PbFieldType.O3)
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  GetMyCoverPurchasesResponse._() : super();
  factory GetMyCoverPurchasesResponse({
    $core.Iterable<MyCoverPurchaseInfo>? purchases,
    $core.int? total,
    $core.bool? success,
    $core.String? msg,
  }) {
    final _result = create();
    if (purchases != null) {
      _result.purchases.addAll(purchases);
    }
    if (total != null) {
      _result.total = total;
    }
    if (success != null) {
      _result.success = success;
    }
    if (msg != null) {
      _result.msg = msg;
    }
    return _result;
  }
  factory GetMyCoverPurchasesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyCoverPurchasesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyCoverPurchasesResponse clone() => GetMyCoverPurchasesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyCoverPurchasesResponse copyWith(void Function(GetMyCoverPurchasesResponse) updates) => super.copyWith((message) => updates(message as GetMyCoverPurchasesResponse)) as GetMyCoverPurchasesResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetMyCoverPurchasesResponse create() => GetMyCoverPurchasesResponse._();
  GetMyCoverPurchasesResponse createEmptyInstance() => create();
  static $pb.PbList<GetMyCoverPurchasesResponse> createRepeated() => $pb.PbList<GetMyCoverPurchasesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMyCoverPurchasesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMyCoverPurchasesResponse>(create);
  static GetMyCoverPurchasesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<MyCoverPurchaseInfo> get purchases => $_getList(0);

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

class GetMyCoverPurchaseByIdRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetMyCoverPurchaseByIdRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'purchaseId')
    ..hasRequiredFields = false
  ;

  GetMyCoverPurchaseByIdRequest._() : super();
  factory GetMyCoverPurchaseByIdRequest({
    $core.String? purchaseId,
  }) {
    final _result = create();
    if (purchaseId != null) {
      _result.purchaseId = purchaseId;
    }
    return _result;
  }
  factory GetMyCoverPurchaseByIdRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyCoverPurchaseByIdRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyCoverPurchaseByIdRequest clone() => GetMyCoverPurchaseByIdRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyCoverPurchaseByIdRequest copyWith(void Function(GetMyCoverPurchaseByIdRequest) updates) => super.copyWith((message) => updates(message as GetMyCoverPurchaseByIdRequest)) as GetMyCoverPurchaseByIdRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetMyCoverPurchaseByIdRequest create() => GetMyCoverPurchaseByIdRequest._();
  GetMyCoverPurchaseByIdRequest createEmptyInstance() => create();
  static $pb.PbList<GetMyCoverPurchaseByIdRequest> createRepeated() => $pb.PbList<GetMyCoverPurchaseByIdRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMyCoverPurchaseByIdRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMyCoverPurchaseByIdRequest>(create);
  static GetMyCoverPurchaseByIdRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get purchaseId => $_getSZ(0);
  @$pb.TagNumber(1)
  set purchaseId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPurchaseId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPurchaseId() => clearField(1);
}

class GetMyCoverPurchaseByIdResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetMyCoverPurchaseByIdResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<MyCoverPurchaseInfo>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'purchase', subBuilder: MyCoverPurchaseInfo.create)
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  GetMyCoverPurchaseByIdResponse._() : super();
  factory GetMyCoverPurchaseByIdResponse({
    MyCoverPurchaseInfo? purchase,
    $core.bool? success,
    $core.String? msg,
  }) {
    final _result = create();
    if (purchase != null) {
      _result.purchase = purchase;
    }
    if (success != null) {
      _result.success = success;
    }
    if (msg != null) {
      _result.msg = msg;
    }
    return _result;
  }
  factory GetMyCoverPurchaseByIdResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyCoverPurchaseByIdResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyCoverPurchaseByIdResponse clone() => GetMyCoverPurchaseByIdResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyCoverPurchaseByIdResponse copyWith(void Function(GetMyCoverPurchaseByIdResponse) updates) => super.copyWith((message) => updates(message as GetMyCoverPurchaseByIdResponse)) as GetMyCoverPurchaseByIdResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetMyCoverPurchaseByIdResponse create() => GetMyCoverPurchaseByIdResponse._();
  GetMyCoverPurchaseByIdResponse createEmptyInstance() => create();
  static $pb.PbList<GetMyCoverPurchaseByIdResponse> createRepeated() => $pb.PbList<GetMyCoverPurchaseByIdResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMyCoverPurchaseByIdResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMyCoverPurchaseByIdResponse>(create);
  static GetMyCoverPurchaseByIdResponse? _defaultInstance;

  @$pb.TagNumber(1)
  MyCoverPurchaseInfo get purchase => $_getN(0);
  @$pb.TagNumber(1)
  set purchase(MyCoverPurchaseInfo v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasPurchase() => $_has(0);
  @$pb.TagNumber(1)
  void clearPurchase() => clearField(1);
  @$pb.TagNumber(1)
  MyCoverPurchaseInfo ensurePurchase() => $_ensure(0);

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

class GetMyCoverClaimsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetMyCoverClaimsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetMyCoverClaimsRequest._() : super();
  factory GetMyCoverClaimsRequest({
    $core.String? status,
    $core.int? page,
    $core.int? limit,
  }) {
    final _result = create();
    if (status != null) {
      _result.status = status;
    }
    if (page != null) {
      _result.page = page;
    }
    if (limit != null) {
      _result.limit = limit;
    }
    return _result;
  }
  factory GetMyCoverClaimsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyCoverClaimsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyCoverClaimsRequest clone() => GetMyCoverClaimsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyCoverClaimsRequest copyWith(void Function(GetMyCoverClaimsRequest) updates) => super.copyWith((message) => updates(message as GetMyCoverClaimsRequest)) as GetMyCoverClaimsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetMyCoverClaimsRequest create() => GetMyCoverClaimsRequest._();
  GetMyCoverClaimsRequest createEmptyInstance() => create();
  static $pb.PbList<GetMyCoverClaimsRequest> createRepeated() => $pb.PbList<GetMyCoverClaimsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMyCoverClaimsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMyCoverClaimsRequest>(create);
  static GetMyCoverClaimsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get status => $_getSZ(0);
  @$pb.TagNumber(1)
  set status($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => clearField(1);

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

class GetMyCoverClaimsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetMyCoverClaimsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<MyCoverClaimInfo>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'claims', $pb.PbFieldType.PM, subBuilder: MyCoverClaimInfo.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'total', $pb.PbFieldType.O3)
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  GetMyCoverClaimsResponse._() : super();
  factory GetMyCoverClaimsResponse({
    $core.Iterable<MyCoverClaimInfo>? claims,
    $core.int? total,
    $core.bool? success,
    $core.String? msg,
  }) {
    final _result = create();
    if (claims != null) {
      _result.claims.addAll(claims);
    }
    if (total != null) {
      _result.total = total;
    }
    if (success != null) {
      _result.success = success;
    }
    if (msg != null) {
      _result.msg = msg;
    }
    return _result;
  }
  factory GetMyCoverClaimsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyCoverClaimsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyCoverClaimsResponse clone() => GetMyCoverClaimsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyCoverClaimsResponse copyWith(void Function(GetMyCoverClaimsResponse) updates) => super.copyWith((message) => updates(message as GetMyCoverClaimsResponse)) as GetMyCoverClaimsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetMyCoverClaimsResponse create() => GetMyCoverClaimsResponse._();
  GetMyCoverClaimsResponse createEmptyInstance() => create();
  static $pb.PbList<GetMyCoverClaimsResponse> createRepeated() => $pb.PbList<GetMyCoverClaimsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMyCoverClaimsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMyCoverClaimsResponse>(create);
  static GetMyCoverClaimsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<MyCoverClaimInfo> get claims => $_getList(0);

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

class GetMyCoverClaimByIdRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetMyCoverClaimByIdRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'claimId')
    ..hasRequiredFields = false
  ;

  GetMyCoverClaimByIdRequest._() : super();
  factory GetMyCoverClaimByIdRequest({
    $core.String? claimId,
  }) {
    final _result = create();
    if (claimId != null) {
      _result.claimId = claimId;
    }
    return _result;
  }
  factory GetMyCoverClaimByIdRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyCoverClaimByIdRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyCoverClaimByIdRequest clone() => GetMyCoverClaimByIdRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyCoverClaimByIdRequest copyWith(void Function(GetMyCoverClaimByIdRequest) updates) => super.copyWith((message) => updates(message as GetMyCoverClaimByIdRequest)) as GetMyCoverClaimByIdRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetMyCoverClaimByIdRequest create() => GetMyCoverClaimByIdRequest._();
  GetMyCoverClaimByIdRequest createEmptyInstance() => create();
  static $pb.PbList<GetMyCoverClaimByIdRequest> createRepeated() => $pb.PbList<GetMyCoverClaimByIdRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMyCoverClaimByIdRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMyCoverClaimByIdRequest>(create);
  static GetMyCoverClaimByIdRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get claimId => $_getSZ(0);
  @$pb.TagNumber(1)
  set claimId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasClaimId() => $_has(0);
  @$pb.TagNumber(1)
  void clearClaimId() => clearField(1);
}

class GetMyCoverClaimByIdResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetMyCoverClaimByIdResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<MyCoverClaimInfo>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'claim', subBuilder: MyCoverClaimInfo.create)
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  GetMyCoverClaimByIdResponse._() : super();
  factory GetMyCoverClaimByIdResponse({
    MyCoverClaimInfo? claim,
    $core.bool? success,
    $core.String? msg,
  }) {
    final _result = create();
    if (claim != null) {
      _result.claim = claim;
    }
    if (success != null) {
      _result.success = success;
    }
    if (msg != null) {
      _result.msg = msg;
    }
    return _result;
  }
  factory GetMyCoverClaimByIdResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyCoverClaimByIdResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyCoverClaimByIdResponse clone() => GetMyCoverClaimByIdResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyCoverClaimByIdResponse copyWith(void Function(GetMyCoverClaimByIdResponse) updates) => super.copyWith((message) => updates(message as GetMyCoverClaimByIdResponse)) as GetMyCoverClaimByIdResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetMyCoverClaimByIdResponse create() => GetMyCoverClaimByIdResponse._();
  GetMyCoverClaimByIdResponse createEmptyInstance() => create();
  static $pb.PbList<GetMyCoverClaimByIdResponse> createRepeated() => $pb.PbList<GetMyCoverClaimByIdResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMyCoverClaimByIdResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMyCoverClaimByIdResponse>(create);
  static GetMyCoverClaimByIdResponse? _defaultInstance;

  @$pb.TagNumber(1)
  MyCoverClaimInfo get claim => $_getN(0);
  @$pb.TagNumber(1)
  set claim(MyCoverClaimInfo v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasClaim() => $_has(0);
  @$pb.TagNumber(1)
  void clearClaim() => clearField(1);
  @$pb.TagNumber(1)
  MyCoverClaimInfo ensureClaim() => $_ensure(0);

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

class FileCreditLifeClaimRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'FileCreditLifeClaimRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'policyId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'claimType')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..pPS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'documents')
    ..m<$core.String, $core.String>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'additionalInfo', entryClassName: 'FileCreditLifeClaimRequest.AdditionalInfoEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('pb'))
    ..hasRequiredFields = false
  ;

  FileCreditLifeClaimRequest._() : super();
  factory FileCreditLifeClaimRequest({
    $core.String? policyId,
    $core.String? claimType,
    $core.String? description,
    $core.double? amount,
    $core.Iterable<$core.String>? documents,
    $core.Map<$core.String, $core.String>? additionalInfo,
  }) {
    final _result = create();
    if (policyId != null) {
      _result.policyId = policyId;
    }
    if (claimType != null) {
      _result.claimType = claimType;
    }
    if (description != null) {
      _result.description = description;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (documents != null) {
      _result.documents.addAll(documents);
    }
    if (additionalInfo != null) {
      _result.additionalInfo.addAll(additionalInfo);
    }
    return _result;
  }
  factory FileCreditLifeClaimRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FileCreditLifeClaimRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FileCreditLifeClaimRequest clone() => FileCreditLifeClaimRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FileCreditLifeClaimRequest copyWith(void Function(FileCreditLifeClaimRequest) updates) => super.copyWith((message) => updates(message as FileCreditLifeClaimRequest)) as FileCreditLifeClaimRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FileCreditLifeClaimRequest create() => FileCreditLifeClaimRequest._();
  FileCreditLifeClaimRequest createEmptyInstance() => create();
  static $pb.PbList<FileCreditLifeClaimRequest> createRepeated() => $pb.PbList<FileCreditLifeClaimRequest>();
  @$core.pragma('dart2js:noInline')
  static FileCreditLifeClaimRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FileCreditLifeClaimRequest>(create);
  static FileCreditLifeClaimRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get policyId => $_getSZ(0);
  @$pb.TagNumber(1)
  set policyId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPolicyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPolicyId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get claimType => $_getSZ(1);
  @$pb.TagNumber(2)
  set claimType($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasClaimType() => $_has(1);
  @$pb.TagNumber(2)
  void clearClaimType() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get amount => $_getN(3);
  @$pb.TagNumber(4)
  set amount($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearAmount() => clearField(4);

  @$pb.TagNumber(5)
  $core.List<$core.String> get documents => $_getList(4);

  @$pb.TagNumber(6)
  $core.Map<$core.String, $core.String> get additionalInfo => $_getMap(5);
}

class FileCreditLifeClaimResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'FileCreditLifeClaimResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'claimId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'claimNumber')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOB(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..hasRequiredFields = false
  ;

  FileCreditLifeClaimResponse._() : super();
  factory FileCreditLifeClaimResponse({
    $core.String? claimId,
    $core.String? claimNumber,
    $core.String? status,
    $core.String? message,
    $core.bool? success,
  }) {
    final _result = create();
    if (claimId != null) {
      _result.claimId = claimId;
    }
    if (claimNumber != null) {
      _result.claimNumber = claimNumber;
    }
    if (status != null) {
      _result.status = status;
    }
    if (message != null) {
      _result.message = message;
    }
    if (success != null) {
      _result.success = success;
    }
    return _result;
  }
  factory FileCreditLifeClaimResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FileCreditLifeClaimResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FileCreditLifeClaimResponse clone() => FileCreditLifeClaimResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FileCreditLifeClaimResponse copyWith(void Function(FileCreditLifeClaimResponse) updates) => super.copyWith((message) => updates(message as FileCreditLifeClaimResponse)) as FileCreditLifeClaimResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FileCreditLifeClaimResponse create() => FileCreditLifeClaimResponse._();
  FileCreditLifeClaimResponse createEmptyInstance() => create();
  static $pb.PbList<FileCreditLifeClaimResponse> createRepeated() => $pb.PbList<FileCreditLifeClaimResponse>();
  @$core.pragma('dart2js:noInline')
  static FileCreditLifeClaimResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FileCreditLifeClaimResponse>(create);
  static FileCreditLifeClaimResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get claimId => $_getSZ(0);
  @$pb.TagNumber(1)
  set claimId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasClaimId() => $_has(0);
  @$pb.TagNumber(1)
  void clearClaimId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get claimNumber => $_getSZ(1);
  @$pb.TagNumber(2)
  set claimNumber($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasClaimNumber() => $_has(1);
  @$pb.TagNumber(2)
  void clearClaimNumber() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get status => $_getSZ(2);
  @$pb.TagNumber(3)
  set status($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatus() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get message => $_getSZ(3);
  @$pb.TagNumber(4)
  set message($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMessage() => $_has(3);
  @$pb.TagNumber(4)
  void clearMessage() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get success => $_getBF(4);
  @$pb.TagNumber(5)
  set success($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasSuccess() => $_has(4);
  @$pb.TagNumber(5)
  void clearSuccess() => clearField(5);
}

class GetInsuranceStatesRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInsuranceStatesRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetInsuranceStatesRequest._() : super();
  factory GetInsuranceStatesRequest() => create();
  factory GetInsuranceStatesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInsuranceStatesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInsuranceStatesRequest clone() => GetInsuranceStatesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInsuranceStatesRequest copyWith(void Function(GetInsuranceStatesRequest) updates) => super.copyWith((message) => updates(message as GetInsuranceStatesRequest)) as GetInsuranceStatesRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetInsuranceStatesRequest create() => GetInsuranceStatesRequest._();
  GetInsuranceStatesRequest createEmptyInstance() => create();
  static $pb.PbList<GetInsuranceStatesRequest> createRepeated() => $pb.PbList<GetInsuranceStatesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInsuranceStatesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInsuranceStatesRequest>(create);
  static GetInsuranceStatesRequest? _defaultInstance;
}

class GetInsuranceStatesResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInsuranceStatesResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<InsuranceAuxiliaryItem>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'states', $pb.PbFieldType.PM, subBuilder: InsuranceAuxiliaryItem.create)
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  GetInsuranceStatesResponse._() : super();
  factory GetInsuranceStatesResponse({
    $core.Iterable<InsuranceAuxiliaryItem>? states,
    $core.bool? success,
    $core.String? msg,
  }) {
    final _result = create();
    if (states != null) {
      _result.states.addAll(states);
    }
    if (success != null) {
      _result.success = success;
    }
    if (msg != null) {
      _result.msg = msg;
    }
    return _result;
  }
  factory GetInsuranceStatesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInsuranceStatesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInsuranceStatesResponse clone() => GetInsuranceStatesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInsuranceStatesResponse copyWith(void Function(GetInsuranceStatesResponse) updates) => super.copyWith((message) => updates(message as GetInsuranceStatesResponse)) as GetInsuranceStatesResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetInsuranceStatesResponse create() => GetInsuranceStatesResponse._();
  GetInsuranceStatesResponse createEmptyInstance() => create();
  static $pb.PbList<GetInsuranceStatesResponse> createRepeated() => $pb.PbList<GetInsuranceStatesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInsuranceStatesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInsuranceStatesResponse>(create);
  static GetInsuranceStatesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<InsuranceAuxiliaryItem> get states => $_getList(0);

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

class GetInsuranceVehicleMakesRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInsuranceVehicleMakesRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetInsuranceVehicleMakesRequest._() : super();
  factory GetInsuranceVehicleMakesRequest() => create();
  factory GetInsuranceVehicleMakesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInsuranceVehicleMakesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInsuranceVehicleMakesRequest clone() => GetInsuranceVehicleMakesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInsuranceVehicleMakesRequest copyWith(void Function(GetInsuranceVehicleMakesRequest) updates) => super.copyWith((message) => updates(message as GetInsuranceVehicleMakesRequest)) as GetInsuranceVehicleMakesRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetInsuranceVehicleMakesRequest create() => GetInsuranceVehicleMakesRequest._();
  GetInsuranceVehicleMakesRequest createEmptyInstance() => create();
  static $pb.PbList<GetInsuranceVehicleMakesRequest> createRepeated() => $pb.PbList<GetInsuranceVehicleMakesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInsuranceVehicleMakesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInsuranceVehicleMakesRequest>(create);
  static GetInsuranceVehicleMakesRequest? _defaultInstance;
}

class GetInsuranceVehicleMakesResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInsuranceVehicleMakesResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<InsuranceAuxiliaryItem>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'makes', $pb.PbFieldType.PM, subBuilder: InsuranceAuxiliaryItem.create)
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  GetInsuranceVehicleMakesResponse._() : super();
  factory GetInsuranceVehicleMakesResponse({
    $core.Iterable<InsuranceAuxiliaryItem>? makes,
    $core.bool? success,
    $core.String? msg,
  }) {
    final _result = create();
    if (makes != null) {
      _result.makes.addAll(makes);
    }
    if (success != null) {
      _result.success = success;
    }
    if (msg != null) {
      _result.msg = msg;
    }
    return _result;
  }
  factory GetInsuranceVehicleMakesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInsuranceVehicleMakesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInsuranceVehicleMakesResponse clone() => GetInsuranceVehicleMakesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInsuranceVehicleMakesResponse copyWith(void Function(GetInsuranceVehicleMakesResponse) updates) => super.copyWith((message) => updates(message as GetInsuranceVehicleMakesResponse)) as GetInsuranceVehicleMakesResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetInsuranceVehicleMakesResponse create() => GetInsuranceVehicleMakesResponse._();
  GetInsuranceVehicleMakesResponse createEmptyInstance() => create();
  static $pb.PbList<GetInsuranceVehicleMakesResponse> createRepeated() => $pb.PbList<GetInsuranceVehicleMakesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInsuranceVehicleMakesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInsuranceVehicleMakesResponse>(create);
  static GetInsuranceVehicleMakesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<InsuranceAuxiliaryItem> get makes => $_getList(0);

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

class MyCoverNotificationPreference extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MyCoverNotificationPreference', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'key')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'category')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'label')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..aOB(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'enabled')
    ..hasRequiredFields = false
  ;

  MyCoverNotificationPreference._() : super();
  factory MyCoverNotificationPreference({
    $core.String? key,
    $core.String? category,
    $core.String? label,
    $core.String? description,
    $core.bool? enabled,
  }) {
    final _result = create();
    if (key != null) {
      _result.key = key;
    }
    if (category != null) {
      _result.category = category;
    }
    if (label != null) {
      _result.label = label;
    }
    if (description != null) {
      _result.description = description;
    }
    if (enabled != null) {
      _result.enabled = enabled;
    }
    return _result;
  }
  factory MyCoverNotificationPreference.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MyCoverNotificationPreference.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MyCoverNotificationPreference clone() => MyCoverNotificationPreference()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MyCoverNotificationPreference copyWith(void Function(MyCoverNotificationPreference) updates) => super.copyWith((message) => updates(message as MyCoverNotificationPreference)) as MyCoverNotificationPreference; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MyCoverNotificationPreference create() => MyCoverNotificationPreference._();
  MyCoverNotificationPreference createEmptyInstance() => create();
  static $pb.PbList<MyCoverNotificationPreference> createRepeated() => $pb.PbList<MyCoverNotificationPreference>();
  @$core.pragma('dart2js:noInline')
  static MyCoverNotificationPreference getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MyCoverNotificationPreference>(create);
  static MyCoverNotificationPreference? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get key => $_getSZ(0);
  @$pb.TagNumber(1)
  set key($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearKey() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get category => $_getSZ(1);
  @$pb.TagNumber(2)
  set category($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCategory() => $_has(1);
  @$pb.TagNumber(2)
  void clearCategory() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get label => $_getSZ(2);
  @$pb.TagNumber(3)
  set label($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasLabel() => $_has(2);
  @$pb.TagNumber(3)
  void clearLabel() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get description => $_getSZ(3);
  @$pb.TagNumber(4)
  set description($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDescription() => $_has(3);
  @$pb.TagNumber(4)
  void clearDescription() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get enabled => $_getBF(4);
  @$pb.TagNumber(5)
  set enabled($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasEnabled() => $_has(4);
  @$pb.TagNumber(5)
  void clearEnabled() => clearField(5);
}

class GetMyCoverNotificationPreferencesRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetMyCoverNotificationPreferencesRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetMyCoverNotificationPreferencesRequest._() : super();
  factory GetMyCoverNotificationPreferencesRequest() => create();
  factory GetMyCoverNotificationPreferencesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyCoverNotificationPreferencesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyCoverNotificationPreferencesRequest clone() => GetMyCoverNotificationPreferencesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyCoverNotificationPreferencesRequest copyWith(void Function(GetMyCoverNotificationPreferencesRequest) updates) => super.copyWith((message) => updates(message as GetMyCoverNotificationPreferencesRequest)) as GetMyCoverNotificationPreferencesRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetMyCoverNotificationPreferencesRequest create() => GetMyCoverNotificationPreferencesRequest._();
  GetMyCoverNotificationPreferencesRequest createEmptyInstance() => create();
  static $pb.PbList<GetMyCoverNotificationPreferencesRequest> createRepeated() => $pb.PbList<GetMyCoverNotificationPreferencesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMyCoverNotificationPreferencesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMyCoverNotificationPreferencesRequest>(create);
  static GetMyCoverNotificationPreferencesRequest? _defaultInstance;
}

class GetMyCoverNotificationPreferencesResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetMyCoverNotificationPreferencesResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<MyCoverNotificationPreference>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'preferences', $pb.PbFieldType.PM, subBuilder: MyCoverNotificationPreference.create)
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  GetMyCoverNotificationPreferencesResponse._() : super();
  factory GetMyCoverNotificationPreferencesResponse({
    $core.Iterable<MyCoverNotificationPreference>? preferences,
    $core.bool? success,
    $core.String? msg,
  }) {
    final _result = create();
    if (preferences != null) {
      _result.preferences.addAll(preferences);
    }
    if (success != null) {
      _result.success = success;
    }
    if (msg != null) {
      _result.msg = msg;
    }
    return _result;
  }
  factory GetMyCoverNotificationPreferencesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyCoverNotificationPreferencesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyCoverNotificationPreferencesResponse clone() => GetMyCoverNotificationPreferencesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyCoverNotificationPreferencesResponse copyWith(void Function(GetMyCoverNotificationPreferencesResponse) updates) => super.copyWith((message) => updates(message as GetMyCoverNotificationPreferencesResponse)) as GetMyCoverNotificationPreferencesResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetMyCoverNotificationPreferencesResponse create() => GetMyCoverNotificationPreferencesResponse._();
  GetMyCoverNotificationPreferencesResponse createEmptyInstance() => create();
  static $pb.PbList<GetMyCoverNotificationPreferencesResponse> createRepeated() => $pb.PbList<GetMyCoverNotificationPreferencesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMyCoverNotificationPreferencesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMyCoverNotificationPreferencesResponse>(create);
  static GetMyCoverNotificationPreferencesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<MyCoverNotificationPreference> get preferences => $_getList(0);

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

class UpdateMyCoverNotificationPreferencesRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateMyCoverNotificationPreferencesRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<MyCoverNotificationPreference>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'preferences', $pb.PbFieldType.PM, subBuilder: MyCoverNotificationPreference.create)
    ..hasRequiredFields = false
  ;

  UpdateMyCoverNotificationPreferencesRequest._() : super();
  factory UpdateMyCoverNotificationPreferencesRequest({
    $core.Iterable<MyCoverNotificationPreference>? preferences,
  }) {
    final _result = create();
    if (preferences != null) {
      _result.preferences.addAll(preferences);
    }
    return _result;
  }
  factory UpdateMyCoverNotificationPreferencesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateMyCoverNotificationPreferencesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateMyCoverNotificationPreferencesRequest clone() => UpdateMyCoverNotificationPreferencesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateMyCoverNotificationPreferencesRequest copyWith(void Function(UpdateMyCoverNotificationPreferencesRequest) updates) => super.copyWith((message) => updates(message as UpdateMyCoverNotificationPreferencesRequest)) as UpdateMyCoverNotificationPreferencesRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpdateMyCoverNotificationPreferencesRequest create() => UpdateMyCoverNotificationPreferencesRequest._();
  UpdateMyCoverNotificationPreferencesRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateMyCoverNotificationPreferencesRequest> createRepeated() => $pb.PbList<UpdateMyCoverNotificationPreferencesRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateMyCoverNotificationPreferencesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateMyCoverNotificationPreferencesRequest>(create);
  static UpdateMyCoverNotificationPreferencesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<MyCoverNotificationPreference> get preferences => $_getList(0);
}

class UpdateMyCoverNotificationPreferencesResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateMyCoverNotificationPreferencesResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  UpdateMyCoverNotificationPreferencesResponse._() : super();
  factory UpdateMyCoverNotificationPreferencesResponse({
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
  factory UpdateMyCoverNotificationPreferencesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateMyCoverNotificationPreferencesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateMyCoverNotificationPreferencesResponse clone() => UpdateMyCoverNotificationPreferencesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateMyCoverNotificationPreferencesResponse copyWith(void Function(UpdateMyCoverNotificationPreferencesResponse) updates) => super.copyWith((message) => updates(message as UpdateMyCoverNotificationPreferencesResponse)) as UpdateMyCoverNotificationPreferencesResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpdateMyCoverNotificationPreferencesResponse create() => UpdateMyCoverNotificationPreferencesResponse._();
  UpdateMyCoverNotificationPreferencesResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateMyCoverNotificationPreferencesResponse> createRepeated() => $pb.PbList<UpdateMyCoverNotificationPreferencesResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateMyCoverNotificationPreferencesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateMyCoverNotificationPreferencesResponse>(create);
  static UpdateMyCoverNotificationPreferencesResponse? _defaultInstance;

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

class GetMyCoverWalletBalanceRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetMyCoverWalletBalanceRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetMyCoverWalletBalanceRequest._() : super();
  factory GetMyCoverWalletBalanceRequest() => create();
  factory GetMyCoverWalletBalanceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyCoverWalletBalanceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyCoverWalletBalanceRequest clone() => GetMyCoverWalletBalanceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyCoverWalletBalanceRequest copyWith(void Function(GetMyCoverWalletBalanceRequest) updates) => super.copyWith((message) => updates(message as GetMyCoverWalletBalanceRequest)) as GetMyCoverWalletBalanceRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetMyCoverWalletBalanceRequest create() => GetMyCoverWalletBalanceRequest._();
  GetMyCoverWalletBalanceRequest createEmptyInstance() => create();
  static $pb.PbList<GetMyCoverWalletBalanceRequest> createRepeated() => $pb.PbList<GetMyCoverWalletBalanceRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMyCoverWalletBalanceRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMyCoverWalletBalanceRequest>(create);
  static GetMyCoverWalletBalanceRequest? _defaultInstance;
}

class GetMyCoverWalletBalanceResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetMyCoverWalletBalanceResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.double>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'balance', $pb.PbFieldType.OD)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  GetMyCoverWalletBalanceResponse._() : super();
  factory GetMyCoverWalletBalanceResponse({
    $core.double? balance,
    $core.String? currency,
    $core.bool? success,
    $core.String? msg,
  }) {
    final _result = create();
    if (balance != null) {
      _result.balance = balance;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (success != null) {
      _result.success = success;
    }
    if (msg != null) {
      _result.msg = msg;
    }
    return _result;
  }
  factory GetMyCoverWalletBalanceResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMyCoverWalletBalanceResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMyCoverWalletBalanceResponse clone() => GetMyCoverWalletBalanceResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMyCoverWalletBalanceResponse copyWith(void Function(GetMyCoverWalletBalanceResponse) updates) => super.copyWith((message) => updates(message as GetMyCoverWalletBalanceResponse)) as GetMyCoverWalletBalanceResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetMyCoverWalletBalanceResponse create() => GetMyCoverWalletBalanceResponse._();
  GetMyCoverWalletBalanceResponse createEmptyInstance() => create();
  static $pb.PbList<GetMyCoverWalletBalanceResponse> createRepeated() => $pb.PbList<GetMyCoverWalletBalanceResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMyCoverWalletBalanceResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMyCoverWalletBalanceResponse>(create);
  static GetMyCoverWalletBalanceResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get balance => $_getN(0);
  @$pb.TagNumber(1)
  set balance($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasBalance() => $_has(0);
  @$pb.TagNumber(1)
  void clearBalance() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get currency => $_getSZ(1);
  @$pb.TagNumber(2)
  set currency($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCurrency() => $_has(1);
  @$pb.TagNumber(2)
  void clearCurrency() => clearField(2);

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

class RequestInsuranceRefundRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RequestInsuranceRefundRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'policyReference')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reason')
    ..hasRequiredFields = false
  ;

  RequestInsuranceRefundRequest._() : super();
  factory RequestInsuranceRefundRequest({
    $core.String? policyReference,
    $core.String? reason,
  }) {
    final _result = create();
    if (policyReference != null) {
      _result.policyReference = policyReference;
    }
    if (reason != null) {
      _result.reason = reason;
    }
    return _result;
  }
  factory RequestInsuranceRefundRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RequestInsuranceRefundRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RequestInsuranceRefundRequest clone() => RequestInsuranceRefundRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RequestInsuranceRefundRequest copyWith(void Function(RequestInsuranceRefundRequest) updates) => super.copyWith((message) => updates(message as RequestInsuranceRefundRequest)) as RequestInsuranceRefundRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RequestInsuranceRefundRequest create() => RequestInsuranceRefundRequest._();
  RequestInsuranceRefundRequest createEmptyInstance() => create();
  static $pb.PbList<RequestInsuranceRefundRequest> createRepeated() => $pb.PbList<RequestInsuranceRefundRequest>();
  @$core.pragma('dart2js:noInline')
  static RequestInsuranceRefundRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RequestInsuranceRefundRequest>(create);
  static RequestInsuranceRefundRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get policyReference => $_getSZ(0);
  @$pb.TagNumber(1)
  set policyReference($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPolicyReference() => $_has(0);
  @$pb.TagNumber(1)
  void clearPolicyReference() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get reason => $_getSZ(1);
  @$pb.TagNumber(2)
  set reason($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasReason() => $_has(1);
  @$pb.TagNumber(2)
  void clearReason() => clearField(2);
}

class RequestInsuranceRefundResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RequestInsuranceRefundResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<InsuranceRefundInfo>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'refund', subBuilder: InsuranceRefundInfo.create)
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  RequestInsuranceRefundResponse._() : super();
  factory RequestInsuranceRefundResponse({
    InsuranceRefundInfo? refund,
    $core.bool? success,
    $core.String? msg,
  }) {
    final _result = create();
    if (refund != null) {
      _result.refund = refund;
    }
    if (success != null) {
      _result.success = success;
    }
    if (msg != null) {
      _result.msg = msg;
    }
    return _result;
  }
  factory RequestInsuranceRefundResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RequestInsuranceRefundResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RequestInsuranceRefundResponse clone() => RequestInsuranceRefundResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RequestInsuranceRefundResponse copyWith(void Function(RequestInsuranceRefundResponse) updates) => super.copyWith((message) => updates(message as RequestInsuranceRefundResponse)) as RequestInsuranceRefundResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RequestInsuranceRefundResponse create() => RequestInsuranceRefundResponse._();
  RequestInsuranceRefundResponse createEmptyInstance() => create();
  static $pb.PbList<RequestInsuranceRefundResponse> createRepeated() => $pb.PbList<RequestInsuranceRefundResponse>();
  @$core.pragma('dart2js:noInline')
  static RequestInsuranceRefundResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RequestInsuranceRefundResponse>(create);
  static RequestInsuranceRefundResponse? _defaultInstance;

  @$pb.TagNumber(1)
  InsuranceRefundInfo get refund => $_getN(0);
  @$pb.TagNumber(1)
  set refund(InsuranceRefundInfo v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasRefund() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefund() => clearField(1);
  @$pb.TagNumber(1)
  InsuranceRefundInfo ensureRefund() => $_ensure(0);

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

class GetInsuranceRefundStatusRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInsuranceRefundStatusRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'policyReference')
    ..hasRequiredFields = false
  ;

  GetInsuranceRefundStatusRequest._() : super();
  factory GetInsuranceRefundStatusRequest({
    $core.String? policyReference,
  }) {
    final _result = create();
    if (policyReference != null) {
      _result.policyReference = policyReference;
    }
    return _result;
  }
  factory GetInsuranceRefundStatusRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInsuranceRefundStatusRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInsuranceRefundStatusRequest clone() => GetInsuranceRefundStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInsuranceRefundStatusRequest copyWith(void Function(GetInsuranceRefundStatusRequest) updates) => super.copyWith((message) => updates(message as GetInsuranceRefundStatusRequest)) as GetInsuranceRefundStatusRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetInsuranceRefundStatusRequest create() => GetInsuranceRefundStatusRequest._();
  GetInsuranceRefundStatusRequest createEmptyInstance() => create();
  static $pb.PbList<GetInsuranceRefundStatusRequest> createRepeated() => $pb.PbList<GetInsuranceRefundStatusRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInsuranceRefundStatusRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInsuranceRefundStatusRequest>(create);
  static GetInsuranceRefundStatusRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get policyReference => $_getSZ(0);
  @$pb.TagNumber(1)
  set policyReference($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPolicyReference() => $_has(0);
  @$pb.TagNumber(1)
  void clearPolicyReference() => clearField(1);
}

class GetInsuranceRefundStatusResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetInsuranceRefundStatusResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<InsuranceRefundInfo>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'refund', subBuilder: InsuranceRefundInfo.create)
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  GetInsuranceRefundStatusResponse._() : super();
  factory GetInsuranceRefundStatusResponse({
    InsuranceRefundInfo? refund,
    $core.bool? success,
    $core.String? msg,
  }) {
    final _result = create();
    if (refund != null) {
      _result.refund = refund;
    }
    if (success != null) {
      _result.success = success;
    }
    if (msg != null) {
      _result.msg = msg;
    }
    return _result;
  }
  factory GetInsuranceRefundStatusResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInsuranceRefundStatusResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInsuranceRefundStatusResponse clone() => GetInsuranceRefundStatusResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInsuranceRefundStatusResponse copyWith(void Function(GetInsuranceRefundStatusResponse) updates) => super.copyWith((message) => updates(message as GetInsuranceRefundStatusResponse)) as GetInsuranceRefundStatusResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetInsuranceRefundStatusResponse create() => GetInsuranceRefundStatusResponse._();
  GetInsuranceRefundStatusResponse createEmptyInstance() => create();
  static $pb.PbList<GetInsuranceRefundStatusResponse> createRepeated() => $pb.PbList<GetInsuranceRefundStatusResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInsuranceRefundStatusResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInsuranceRefundStatusResponse>(create);
  static GetInsuranceRefundStatusResponse? _defaultInstance;

  @$pb.TagNumber(1)
  InsuranceRefundInfo get refund => $_getN(0);
  @$pb.TagNumber(1)
  set refund(InsuranceRefundInfo v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasRefund() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefund() => clearField(1);
  @$pb.TagNumber(1)
  InsuranceRefundInfo ensureRefund() => $_ensure(0);

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

class InsuranceRefundInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'InsuranceRefundInfo', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'refundId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'policyReference')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOB(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerRefunded')
    ..aOB(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'walletCredited')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reason')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'failureReason')
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'initiatedAt')
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'completedAt')
    ..hasRequiredFields = false
  ;

  InsuranceRefundInfo._() : super();
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
    final _result = create();
    if (refundId != null) {
      _result.refundId = refundId;
    }
    if (policyReference != null) {
      _result.policyReference = policyReference;
    }
    if (status != null) {
      _result.status = status;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (providerRefunded != null) {
      _result.providerRefunded = providerRefunded;
    }
    if (walletCredited != null) {
      _result.walletCredited = walletCredited;
    }
    if (reason != null) {
      _result.reason = reason;
    }
    if (failureReason != null) {
      _result.failureReason = failureReason;
    }
    if (initiatedAt != null) {
      _result.initiatedAt = initiatedAt;
    }
    if (completedAt != null) {
      _result.completedAt = completedAt;
    }
    return _result;
  }
  factory InsuranceRefundInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InsuranceRefundInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InsuranceRefundInfo clone() => InsuranceRefundInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InsuranceRefundInfo copyWith(void Function(InsuranceRefundInfo) updates) => super.copyWith((message) => updates(message as InsuranceRefundInfo)) as InsuranceRefundInfo; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static InsuranceRefundInfo create() => InsuranceRefundInfo._();
  InsuranceRefundInfo createEmptyInstance() => create();
  static $pb.PbList<InsuranceRefundInfo> createRepeated() => $pb.PbList<InsuranceRefundInfo>();
  @$core.pragma('dart2js:noInline')
  static InsuranceRefundInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InsuranceRefundInfo>(create);
  static InsuranceRefundInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get refundId => $_getSZ(0);
  @$pb.TagNumber(1)
  set refundId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRefundId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefundId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get policyReference => $_getSZ(1);
  @$pb.TagNumber(2)
  set policyReference($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPolicyReference() => $_has(1);
  @$pb.TagNumber(2)
  void clearPolicyReference() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get status => $_getSZ(2);
  @$pb.TagNumber(3)
  set status($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatus() => clearField(3);

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
  $core.bool get providerRefunded => $_getBF(5);
  @$pb.TagNumber(6)
  set providerRefunded($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasProviderRefunded() => $_has(5);
  @$pb.TagNumber(6)
  void clearProviderRefunded() => clearField(6);

  @$pb.TagNumber(7)
  $core.bool get walletCredited => $_getBF(6);
  @$pb.TagNumber(7)
  set walletCredited($core.bool v) { $_setBool(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasWalletCredited() => $_has(6);
  @$pb.TagNumber(7)
  void clearWalletCredited() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get reason => $_getSZ(7);
  @$pb.TagNumber(8)
  set reason($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasReason() => $_has(7);
  @$pb.TagNumber(8)
  void clearReason() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get failureReason => $_getSZ(8);
  @$pb.TagNumber(9)
  set failureReason($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasFailureReason() => $_has(8);
  @$pb.TagNumber(9)
  void clearFailureReason() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get initiatedAt => $_getSZ(9);
  @$pb.TagNumber(10)
  set initiatedAt($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasInitiatedAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearInitiatedAt() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get completedAt => $_getSZ(10);
  @$pb.TagNumber(11)
  set completedAt($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasCompletedAt() => $_has(10);
  @$pb.TagNumber(11)
  void clearCompletedAt() => clearField(11);
}

