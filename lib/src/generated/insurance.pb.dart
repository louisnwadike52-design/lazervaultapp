///
//  Generated code. Do not modify.
//  source: insurance.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'common.pb.dart' as $2;

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
    ..aOM<$2.PaginationInfo>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pagination', subBuilder: $2.PaginationInfo.create)
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  GetUserInsurancesResponse._() : super();
  factory GetUserInsurancesResponse({
    $core.Iterable<Insurance>? insurances,
    $2.PaginationInfo? pagination,
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
  $2.PaginationInfo get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination($2.PaginationInfo v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => clearField(2);
  @$pb.TagNumber(2)
  $2.PaginationInfo ensurePagination() => $_ensure(1);

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
    ..aOM<$2.PaginationInfo>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pagination', subBuilder: $2.PaginationInfo.create)
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  SearchInsurancesResponse._() : super();
  factory SearchInsurancesResponse({
    $core.Iterable<Insurance>? insurances,
    $2.PaginationInfo? pagination,
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
  $2.PaginationInfo get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination($2.PaginationInfo v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => clearField(2);
  @$pb.TagNumber(2)
  $2.PaginationInfo ensurePagination() => $_ensure(1);

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
    ..aOM<$2.PaginationInfo>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pagination', subBuilder: $2.PaginationInfo.create)
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  GetInsurancePaymentsResponse._() : super();
  factory GetInsurancePaymentsResponse({
    $core.Iterable<InsurancePayment>? payments,
    $2.PaginationInfo? pagination,
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
  $2.PaginationInfo get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination($2.PaginationInfo v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => clearField(2);
  @$pb.TagNumber(2)
  $2.PaginationInfo ensurePagination() => $_ensure(1);

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
    ..aOM<$2.PaginationInfo>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pagination', subBuilder: $2.PaginationInfo.create)
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  GetUserPaymentsResponse._() : super();
  factory GetUserPaymentsResponse({
    $core.Iterable<InsurancePayment>? payments,
    $2.PaginationInfo? pagination,
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
  $2.PaginationInfo get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination($2.PaginationInfo v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => clearField(2);
  @$pb.TagNumber(2)
  $2.PaginationInfo ensurePagination() => $_ensure(1);

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
    ..aOM<$2.PaginationInfo>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pagination', subBuilder: $2.PaginationInfo.create)
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  GetInsuranceClaimsResponse._() : super();
  factory GetInsuranceClaimsResponse({
    $core.Iterable<InsuranceClaim>? claims,
    $2.PaginationInfo? pagination,
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
  $2.PaginationInfo get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination($2.PaginationInfo v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => clearField(2);
  @$pb.TagNumber(2)
  $2.PaginationInfo ensurePagination() => $_ensure(1);

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
    ..aOM<$2.PaginationInfo>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pagination', subBuilder: $2.PaginationInfo.create)
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  GetUserClaimsResponse._() : super();
  factory GetUserClaimsResponse({
    $core.Iterable<InsuranceClaim>? claims,
    $2.PaginationInfo? pagination,
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
  $2.PaginationInfo get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination($2.PaginationInfo v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => clearField(2);
  @$pb.TagNumber(2)
  $2.PaginationInfo ensurePagination() => $_ensure(1);

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
    ..aOM<$2.PaginationInfo>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pagination', subBuilder: $2.PaginationInfo.create)
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'msg')
    ..hasRequiredFields = false
  ;

  GetUserReceiptsResponse._() : super();
  factory GetUserReceiptsResponse({
    $core.Iterable<$core.String>? receiptUrls,
    $2.PaginationInfo? pagination,
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
  $2.PaginationInfo get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination($2.PaginationInfo v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => clearField(2);
  @$pb.TagNumber(2)
  $2.PaginationInfo ensurePagination() => $_ensure(1);

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

