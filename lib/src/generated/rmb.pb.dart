///
//  Generated code. Do not modify.
//  source: rmb.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $1;

import 'rmb.pbenum.dart';

export 'rmb.pbenum.dart';

class GetProviderConfigRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetProviderConfigRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rmb'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetProviderConfigRequest._() : super();
  factory GetProviderConfigRequest() => create();
  factory GetProviderConfigRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetProviderConfigRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetProviderConfigRequest clone() => GetProviderConfigRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetProviderConfigRequest copyWith(void Function(GetProviderConfigRequest) updates) => super.copyWith((message) => updates(message as GetProviderConfigRequest)) as GetProviderConfigRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetProviderConfigRequest create() => GetProviderConfigRequest._();
  GetProviderConfigRequest createEmptyInstance() => create();
  static $pb.PbList<GetProviderConfigRequest> createRepeated() => $pb.PbList<GetProviderConfigRequest>();
  @$core.pragma('dart2js:noInline')
  static GetProviderConfigRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetProviderConfigRequest>(create);
  static GetProviderConfigRequest? _defaultInstance;
}

class RailStatus extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RailStatus', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rmb'), createEmptyInstance: create)
    ..e<RmbRail>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'rail', $pb.PbFieldType.OE, defaultOrMaker: RmbRail.RAIL_UNSPECIFIED, valueOf: RmbRail.valueOf, enumValues: RmbRail.values)
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'enabled')
    ..aInt64(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'minAmountMinor')
    ..aInt64(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'maxAmountMinor')
    ..hasRequiredFields = false
  ;

  RailStatus._() : super();
  factory RailStatus({
    RmbRail? rail,
    $core.bool? enabled,
    $fixnum.Int64? minAmountMinor,
    $fixnum.Int64? maxAmountMinor,
  }) {
    final _result = create();
    if (rail != null) {
      _result.rail = rail;
    }
    if (enabled != null) {
      _result.enabled = enabled;
    }
    if (minAmountMinor != null) {
      _result.minAmountMinor = minAmountMinor;
    }
    if (maxAmountMinor != null) {
      _result.maxAmountMinor = maxAmountMinor;
    }
    return _result;
  }
  factory RailStatus.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RailStatus.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RailStatus clone() => RailStatus()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RailStatus copyWith(void Function(RailStatus) updates) => super.copyWith((message) => updates(message as RailStatus)) as RailStatus; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RailStatus create() => RailStatus._();
  RailStatus createEmptyInstance() => create();
  static $pb.PbList<RailStatus> createRepeated() => $pb.PbList<RailStatus>();
  @$core.pragma('dart2js:noInline')
  static RailStatus getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RailStatus>(create);
  static RailStatus? _defaultInstance;

  @$pb.TagNumber(1)
  RmbRail get rail => $_getN(0);
  @$pb.TagNumber(1)
  set rail(RmbRail v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasRail() => $_has(0);
  @$pb.TagNumber(1)
  void clearRail() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get enabled => $_getBF(1);
  @$pb.TagNumber(2)
  set enabled($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasEnabled() => $_has(1);
  @$pb.TagNumber(2)
  void clearEnabled() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get minAmountMinor => $_getI64(2);
  @$pb.TagNumber(3)
  set minAmountMinor($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMinAmountMinor() => $_has(2);
  @$pb.TagNumber(3)
  void clearMinAmountMinor() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get maxAmountMinor => $_getI64(3);
  @$pb.TagNumber(4)
  set maxAmountMinor($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMaxAmountMinor() => $_has(3);
  @$pb.TagNumber(4)
  void clearMaxAmountMinor() => clearField(4);
}

class RateTier extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RateTier', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rmb'), createEmptyInstance: create)
    ..aInt64(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'minCnyMinor')
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'marginPercent', $pb.PbFieldType.OD)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ngnPerCny', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  RateTier._() : super();
  factory RateTier({
    $fixnum.Int64? minCnyMinor,
    $core.double? marginPercent,
    $core.double? ngnPerCny,
  }) {
    final _result = create();
    if (minCnyMinor != null) {
      _result.minCnyMinor = minCnyMinor;
    }
    if (marginPercent != null) {
      _result.marginPercent = marginPercent;
    }
    if (ngnPerCny != null) {
      _result.ngnPerCny = ngnPerCny;
    }
    return _result;
  }
  factory RateTier.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RateTier.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RateTier clone() => RateTier()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RateTier copyWith(void Function(RateTier) updates) => super.copyWith((message) => updates(message as RateTier)) as RateTier; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RateTier create() => RateTier._();
  RateTier createEmptyInstance() => create();
  static $pb.PbList<RateTier> createRepeated() => $pb.PbList<RateTier>();
  @$core.pragma('dart2js:noInline')
  static RateTier getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RateTier>(create);
  static RateTier? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get minCnyMinor => $_getI64(0);
  @$pb.TagNumber(1)
  set minCnyMinor($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMinCnyMinor() => $_has(0);
  @$pb.TagNumber(1)
  void clearMinCnyMinor() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get marginPercent => $_getN(1);
  @$pb.TagNumber(2)
  set marginPercent($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMarginPercent() => $_has(1);
  @$pb.TagNumber(2)
  void clearMarginPercent() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get ngnPerCny => $_getN(2);
  @$pb.TagNumber(3)
  set ngnPerCny($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasNgnPerCny() => $_has(2);
  @$pb.TagNumber(3)
  void clearNgnPerCny() => clearField(3);
}

class ProviderConfigResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProviderConfigResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rmb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'provider')
    ..pc<RailStatus>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'rails', $pb.PbFieldType.PM, subBuilder: RailStatus.create)
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'maintenance')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'maintenanceMessage')
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'indicativeFxRate', $pb.PbFieldType.OD)
    ..pc<RateTier>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'rateTiers', $pb.PbFieldType.PM, subBuilder: RateTier.create)
    ..hasRequiredFields = false
  ;

  ProviderConfigResponse._() : super();
  factory ProviderConfigResponse({
    $core.String? provider,
    $core.Iterable<RailStatus>? rails,
    $core.bool? maintenance,
    $core.String? maintenanceMessage,
    $core.double? indicativeFxRate,
    $core.Iterable<RateTier>? rateTiers,
  }) {
    final _result = create();
    if (provider != null) {
      _result.provider = provider;
    }
    if (rails != null) {
      _result.rails.addAll(rails);
    }
    if (maintenance != null) {
      _result.maintenance = maintenance;
    }
    if (maintenanceMessage != null) {
      _result.maintenanceMessage = maintenanceMessage;
    }
    if (indicativeFxRate != null) {
      _result.indicativeFxRate = indicativeFxRate;
    }
    if (rateTiers != null) {
      _result.rateTiers.addAll(rateTiers);
    }
    return _result;
  }
  factory ProviderConfigResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProviderConfigResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProviderConfigResponse clone() => ProviderConfigResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProviderConfigResponse copyWith(void Function(ProviderConfigResponse) updates) => super.copyWith((message) => updates(message as ProviderConfigResponse)) as ProviderConfigResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProviderConfigResponse create() => ProviderConfigResponse._();
  ProviderConfigResponse createEmptyInstance() => create();
  static $pb.PbList<ProviderConfigResponse> createRepeated() => $pb.PbList<ProviderConfigResponse>();
  @$core.pragma('dart2js:noInline')
  static ProviderConfigResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProviderConfigResponse>(create);
  static ProviderConfigResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get provider => $_getSZ(0);
  @$pb.TagNumber(1)
  set provider($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasProvider() => $_has(0);
  @$pb.TagNumber(1)
  void clearProvider() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<RailStatus> get rails => $_getList(1);

  @$pb.TagNumber(3)
  $core.bool get maintenance => $_getBF(2);
  @$pb.TagNumber(3)
  set maintenance($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMaintenance() => $_has(2);
  @$pb.TagNumber(3)
  void clearMaintenance() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get maintenanceMessage => $_getSZ(3);
  @$pb.TagNumber(4)
  set maintenanceMessage($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMaintenanceMessage() => $_has(3);
  @$pb.TagNumber(4)
  void clearMaintenanceMessage() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get indicativeFxRate => $_getN(4);
  @$pb.TagNumber(5)
  set indicativeFxRate($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasIndicativeFxRate() => $_has(4);
  @$pb.TagNumber(5)
  void clearIndicativeFxRate() => clearField(5);

  @$pb.TagNumber(6)
  $core.List<RateTier> get rateTiers => $_getList(5);
}

class ResolveBanksRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ResolveBanksRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rmb'), createEmptyInstance: create)
    ..e<RmbRail>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'rail', $pb.PbFieldType.OE, defaultOrMaker: RmbRail.RAIL_UNSPECIFIED, valueOf: RmbRail.valueOf, enumValues: RmbRail.values)
    ..hasRequiredFields = false
  ;

  ResolveBanksRequest._() : super();
  factory ResolveBanksRequest({
    RmbRail? rail,
  }) {
    final _result = create();
    if (rail != null) {
      _result.rail = rail;
    }
    return _result;
  }
  factory ResolveBanksRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ResolveBanksRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ResolveBanksRequest clone() => ResolveBanksRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ResolveBanksRequest copyWith(void Function(ResolveBanksRequest) updates) => super.copyWith((message) => updates(message as ResolveBanksRequest)) as ResolveBanksRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ResolveBanksRequest create() => ResolveBanksRequest._();
  ResolveBanksRequest createEmptyInstance() => create();
  static $pb.PbList<ResolveBanksRequest> createRepeated() => $pb.PbList<ResolveBanksRequest>();
  @$core.pragma('dart2js:noInline')
  static ResolveBanksRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ResolveBanksRequest>(create);
  static ResolveBanksRequest? _defaultInstance;

  @$pb.TagNumber(1)
  RmbRail get rail => $_getN(0);
  @$pb.TagNumber(1)
  set rail(RmbRail v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasRail() => $_has(0);
  @$pb.TagNumber(1)
  void clearRail() => clearField(1);
}

class Bank extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Bank', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rmb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'code')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..hasRequiredFields = false
  ;

  Bank._() : super();
  factory Bank({
    $core.String? code,
    $core.String? name,
  }) {
    final _result = create();
    if (code != null) {
      _result.code = code;
    }
    if (name != null) {
      _result.name = name;
    }
    return _result;
  }
  factory Bank.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Bank.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Bank clone() => Bank()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Bank copyWith(void Function(Bank) updates) => super.copyWith((message) => updates(message as Bank)) as Bank; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Bank create() => Bank._();
  Bank createEmptyInstance() => create();
  static $pb.PbList<Bank> createRepeated() => $pb.PbList<Bank>();
  @$core.pragma('dart2js:noInline')
  static Bank getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Bank>(create);
  static Bank? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get code => $_getSZ(0);
  @$pb.TagNumber(1)
  set code($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearCode() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);
}

class ResolveBanksResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ResolveBanksResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rmb'), createEmptyInstance: create)
    ..pc<Bank>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'banks', $pb.PbFieldType.PM, subBuilder: Bank.create)
    ..hasRequiredFields = false
  ;

  ResolveBanksResponse._() : super();
  factory ResolveBanksResponse({
    $core.Iterable<Bank>? banks,
  }) {
    final _result = create();
    if (banks != null) {
      _result.banks.addAll(banks);
    }
    return _result;
  }
  factory ResolveBanksResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ResolveBanksResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ResolveBanksResponse clone() => ResolveBanksResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ResolveBanksResponse copyWith(void Function(ResolveBanksResponse) updates) => super.copyWith((message) => updates(message as ResolveBanksResponse)) as ResolveBanksResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ResolveBanksResponse create() => ResolveBanksResponse._();
  ResolveBanksResponse createEmptyInstance() => create();
  static $pb.PbList<ResolveBanksResponse> createRepeated() => $pb.PbList<ResolveBanksResponse>();
  @$core.pragma('dart2js:noInline')
  static ResolveBanksResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ResolveBanksResponse>(create);
  static ResolveBanksResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Bank> get banks => $_getList(0);
}

class GetQuoteRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetQuoteRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rmb'), createEmptyInstance: create)
    ..e<RmbRail>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'rail', $pb.PbFieldType.OE, defaultOrMaker: RmbRail.RAIL_UNSPECIFIED, valueOf: RmbRail.valueOf, enumValues: RmbRail.values)
    ..aInt64(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cnyAmountMinor')
    ..hasRequiredFields = false
  ;

  GetQuoteRequest._() : super();
  factory GetQuoteRequest({
    RmbRail? rail,
    $fixnum.Int64? cnyAmountMinor,
  }) {
    final _result = create();
    if (rail != null) {
      _result.rail = rail;
    }
    if (cnyAmountMinor != null) {
      _result.cnyAmountMinor = cnyAmountMinor;
    }
    return _result;
  }
  factory GetQuoteRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetQuoteRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetQuoteRequest clone() => GetQuoteRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetQuoteRequest copyWith(void Function(GetQuoteRequest) updates) => super.copyWith((message) => updates(message as GetQuoteRequest)) as GetQuoteRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetQuoteRequest create() => GetQuoteRequest._();
  GetQuoteRequest createEmptyInstance() => create();
  static $pb.PbList<GetQuoteRequest> createRepeated() => $pb.PbList<GetQuoteRequest>();
  @$core.pragma('dart2js:noInline')
  static GetQuoteRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetQuoteRequest>(create);
  static GetQuoteRequest? _defaultInstance;

  @$pb.TagNumber(1)
  RmbRail get rail => $_getN(0);
  @$pb.TagNumber(1)
  set rail(RmbRail v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasRail() => $_has(0);
  @$pb.TagNumber(1)
  void clearRail() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get cnyAmountMinor => $_getI64(1);
  @$pb.TagNumber(2)
  set cnyAmountMinor($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCnyAmountMinor() => $_has(1);
  @$pb.TagNumber(2)
  void clearCnyAmountMinor() => clearField(2);
}

class QuoteResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'QuoteResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rmb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'quoteId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'provider')
    ..e<RmbRail>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'rail', $pb.PbFieldType.OE, defaultOrMaker: RmbRail.RAIL_UNSPECIFIED, valueOf: RmbRail.valueOf, enumValues: RmbRail.values)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fxRate', $pb.PbFieldType.OD)
    ..aInt64(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'destAmountMinor')
    ..aInt64(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sourceAmountMinor')
    ..aInt64(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerFeeMinor')
    ..aInt64(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ourFeeMinor')
    ..aInt64(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalMinor')
    ..aOM<$1.Timestamp>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'expiresAt', subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false
  ;

  QuoteResponse._() : super();
  factory QuoteResponse({
    $core.String? quoteId,
    $core.String? provider,
    RmbRail? rail,
    $core.double? fxRate,
    $fixnum.Int64? destAmountMinor,
    $fixnum.Int64? sourceAmountMinor,
    $fixnum.Int64? providerFeeMinor,
    $fixnum.Int64? ourFeeMinor,
    $fixnum.Int64? totalMinor,
    $1.Timestamp? expiresAt,
  }) {
    final _result = create();
    if (quoteId != null) {
      _result.quoteId = quoteId;
    }
    if (provider != null) {
      _result.provider = provider;
    }
    if (rail != null) {
      _result.rail = rail;
    }
    if (fxRate != null) {
      _result.fxRate = fxRate;
    }
    if (destAmountMinor != null) {
      _result.destAmountMinor = destAmountMinor;
    }
    if (sourceAmountMinor != null) {
      _result.sourceAmountMinor = sourceAmountMinor;
    }
    if (providerFeeMinor != null) {
      _result.providerFeeMinor = providerFeeMinor;
    }
    if (ourFeeMinor != null) {
      _result.ourFeeMinor = ourFeeMinor;
    }
    if (totalMinor != null) {
      _result.totalMinor = totalMinor;
    }
    if (expiresAt != null) {
      _result.expiresAt = expiresAt;
    }
    return _result;
  }
  factory QuoteResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory QuoteResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  QuoteResponse clone() => QuoteResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  QuoteResponse copyWith(void Function(QuoteResponse) updates) => super.copyWith((message) => updates(message as QuoteResponse)) as QuoteResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static QuoteResponse create() => QuoteResponse._();
  QuoteResponse createEmptyInstance() => create();
  static $pb.PbList<QuoteResponse> createRepeated() => $pb.PbList<QuoteResponse>();
  @$core.pragma('dart2js:noInline')
  static QuoteResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<QuoteResponse>(create);
  static QuoteResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get quoteId => $_getSZ(0);
  @$pb.TagNumber(1)
  set quoteId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasQuoteId() => $_has(0);
  @$pb.TagNumber(1)
  void clearQuoteId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get provider => $_getSZ(1);
  @$pb.TagNumber(2)
  set provider($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasProvider() => $_has(1);
  @$pb.TagNumber(2)
  void clearProvider() => clearField(2);

  @$pb.TagNumber(3)
  RmbRail get rail => $_getN(2);
  @$pb.TagNumber(3)
  set rail(RmbRail v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasRail() => $_has(2);
  @$pb.TagNumber(3)
  void clearRail() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get fxRate => $_getN(3);
  @$pb.TagNumber(4)
  set fxRate($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasFxRate() => $_has(3);
  @$pb.TagNumber(4)
  void clearFxRate() => clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get destAmountMinor => $_getI64(4);
  @$pb.TagNumber(5)
  set destAmountMinor($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasDestAmountMinor() => $_has(4);
  @$pb.TagNumber(5)
  void clearDestAmountMinor() => clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get sourceAmountMinor => $_getI64(5);
  @$pb.TagNumber(6)
  set sourceAmountMinor($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasSourceAmountMinor() => $_has(5);
  @$pb.TagNumber(6)
  void clearSourceAmountMinor() => clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get providerFeeMinor => $_getI64(6);
  @$pb.TagNumber(7)
  set providerFeeMinor($fixnum.Int64 v) { $_setInt64(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasProviderFeeMinor() => $_has(6);
  @$pb.TagNumber(7)
  void clearProviderFeeMinor() => clearField(7);

  @$pb.TagNumber(8)
  $fixnum.Int64 get ourFeeMinor => $_getI64(7);
  @$pb.TagNumber(8)
  set ourFeeMinor($fixnum.Int64 v) { $_setInt64(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasOurFeeMinor() => $_has(7);
  @$pb.TagNumber(8)
  void clearOurFeeMinor() => clearField(8);

  @$pb.TagNumber(9)
  $fixnum.Int64 get totalMinor => $_getI64(8);
  @$pb.TagNumber(9)
  set totalMinor($fixnum.Int64 v) { $_setInt64(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasTotalMinor() => $_has(8);
  @$pb.TagNumber(9)
  void clearTotalMinor() => clearField(9);

  @$pb.TagNumber(10)
  $1.Timestamp get expiresAt => $_getN(9);
  @$pb.TagNumber(10)
  set expiresAt($1.Timestamp v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasExpiresAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearExpiresAt() => clearField(10);
  @$pb.TagNumber(10)
  $1.Timestamp ensureExpiresAt() => $_ensure(9);
}

class Beneficiary extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Beneficiary', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rmb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..e<RmbRail>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'rail', $pb.PbFieldType.OE, defaultOrMaker: RmbRail.RAIL_UNSPECIFIED, valueOf: RmbRail.valueOf, enumValues: RmbRail.values)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'displayName')
    ..aOB(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'favourite')
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountId')
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountIdType')
    ..aOS(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountNumber')
    ..aOS(20, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'receiverFirstName')
    ..aOS(21, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'receiverLastName')
    ..aOS(22, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'receiverIdNumber')
    ..aOS(23, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'receiverIdType')
    ..aOS(24, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'receiverMobile')
    ..aOS(25, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'receiverRelationship')
    ..aOS(30, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cardNumber')
    ..aOS(31, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cardHolderName')
    ..aOS(40, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountName')
    ..aOS(41, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountType')
    ..aOS(42, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bankCode')
    ..aOS(43, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bankName')
    ..aOM<$1.Timestamp>(50, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lastUsedAt', subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false
  ;

  Beneficiary._() : super();
  factory Beneficiary({
    $core.String? id,
    RmbRail? rail,
    $core.String? displayName,
    $core.bool? favourite,
    $core.String? accountId,
    $core.String? accountIdType,
    $core.String? accountNumber,
    $core.String? receiverFirstName,
    $core.String? receiverLastName,
    $core.String? receiverIdNumber,
    $core.String? receiverIdType,
    $core.String? receiverMobile,
    $core.String? receiverRelationship,
    $core.String? cardNumber,
    $core.String? cardHolderName,
    $core.String? accountName,
    $core.String? accountType,
    $core.String? bankCode,
    $core.String? bankName,
    $1.Timestamp? lastUsedAt,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (rail != null) {
      _result.rail = rail;
    }
    if (displayName != null) {
      _result.displayName = displayName;
    }
    if (favourite != null) {
      _result.favourite = favourite;
    }
    if (accountId != null) {
      _result.accountId = accountId;
    }
    if (accountIdType != null) {
      _result.accountIdType = accountIdType;
    }
    if (accountNumber != null) {
      _result.accountNumber = accountNumber;
    }
    if (receiverFirstName != null) {
      _result.receiverFirstName = receiverFirstName;
    }
    if (receiverLastName != null) {
      _result.receiverLastName = receiverLastName;
    }
    if (receiverIdNumber != null) {
      _result.receiverIdNumber = receiverIdNumber;
    }
    if (receiverIdType != null) {
      _result.receiverIdType = receiverIdType;
    }
    if (receiverMobile != null) {
      _result.receiverMobile = receiverMobile;
    }
    if (receiverRelationship != null) {
      _result.receiverRelationship = receiverRelationship;
    }
    if (cardNumber != null) {
      _result.cardNumber = cardNumber;
    }
    if (cardHolderName != null) {
      _result.cardHolderName = cardHolderName;
    }
    if (accountName != null) {
      _result.accountName = accountName;
    }
    if (accountType != null) {
      _result.accountType = accountType;
    }
    if (bankCode != null) {
      _result.bankCode = bankCode;
    }
    if (bankName != null) {
      _result.bankName = bankName;
    }
    if (lastUsedAt != null) {
      _result.lastUsedAt = lastUsedAt;
    }
    return _result;
  }
  factory Beneficiary.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Beneficiary.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Beneficiary clone() => Beneficiary()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Beneficiary copyWith(void Function(Beneficiary) updates) => super.copyWith((message) => updates(message as Beneficiary)) as Beneficiary; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Beneficiary create() => Beneficiary._();
  Beneficiary createEmptyInstance() => create();
  static $pb.PbList<Beneficiary> createRepeated() => $pb.PbList<Beneficiary>();
  @$core.pragma('dart2js:noInline')
  static Beneficiary getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Beneficiary>(create);
  static Beneficiary? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  RmbRail get rail => $_getN(1);
  @$pb.TagNumber(2)
  set rail(RmbRail v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasRail() => $_has(1);
  @$pb.TagNumber(2)
  void clearRail() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get displayName => $_getSZ(2);
  @$pb.TagNumber(3)
  set displayName($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDisplayName() => $_has(2);
  @$pb.TagNumber(3)
  void clearDisplayName() => clearField(3);

  @$pb.TagNumber(4)
  $core.bool get favourite => $_getBF(3);
  @$pb.TagNumber(4)
  set favourite($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasFavourite() => $_has(3);
  @$pb.TagNumber(4)
  void clearFavourite() => clearField(4);

  @$pb.TagNumber(10)
  $core.String get accountId => $_getSZ(4);
  @$pb.TagNumber(10)
  set accountId($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(10)
  $core.bool hasAccountId() => $_has(4);
  @$pb.TagNumber(10)
  void clearAccountId() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get accountIdType => $_getSZ(5);
  @$pb.TagNumber(11)
  set accountIdType($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(11)
  $core.bool hasAccountIdType() => $_has(5);
  @$pb.TagNumber(11)
  void clearAccountIdType() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get accountNumber => $_getSZ(6);
  @$pb.TagNumber(12)
  set accountNumber($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(12)
  $core.bool hasAccountNumber() => $_has(6);
  @$pb.TagNumber(12)
  void clearAccountNumber() => clearField(12);

  @$pb.TagNumber(20)
  $core.String get receiverFirstName => $_getSZ(7);
  @$pb.TagNumber(20)
  set receiverFirstName($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(20)
  $core.bool hasReceiverFirstName() => $_has(7);
  @$pb.TagNumber(20)
  void clearReceiverFirstName() => clearField(20);

  @$pb.TagNumber(21)
  $core.String get receiverLastName => $_getSZ(8);
  @$pb.TagNumber(21)
  set receiverLastName($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(21)
  $core.bool hasReceiverLastName() => $_has(8);
  @$pb.TagNumber(21)
  void clearReceiverLastName() => clearField(21);

  @$pb.TagNumber(22)
  $core.String get receiverIdNumber => $_getSZ(9);
  @$pb.TagNumber(22)
  set receiverIdNumber($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(22)
  $core.bool hasReceiverIdNumber() => $_has(9);
  @$pb.TagNumber(22)
  void clearReceiverIdNumber() => clearField(22);

  @$pb.TagNumber(23)
  $core.String get receiverIdType => $_getSZ(10);
  @$pb.TagNumber(23)
  set receiverIdType($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(23)
  $core.bool hasReceiverIdType() => $_has(10);
  @$pb.TagNumber(23)
  void clearReceiverIdType() => clearField(23);

  @$pb.TagNumber(24)
  $core.String get receiverMobile => $_getSZ(11);
  @$pb.TagNumber(24)
  set receiverMobile($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(24)
  $core.bool hasReceiverMobile() => $_has(11);
  @$pb.TagNumber(24)
  void clearReceiverMobile() => clearField(24);

  @$pb.TagNumber(25)
  $core.String get receiverRelationship => $_getSZ(12);
  @$pb.TagNumber(25)
  set receiverRelationship($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(25)
  $core.bool hasReceiverRelationship() => $_has(12);
  @$pb.TagNumber(25)
  void clearReceiverRelationship() => clearField(25);

  @$pb.TagNumber(30)
  $core.String get cardNumber => $_getSZ(13);
  @$pb.TagNumber(30)
  set cardNumber($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(30)
  $core.bool hasCardNumber() => $_has(13);
  @$pb.TagNumber(30)
  void clearCardNumber() => clearField(30);

  @$pb.TagNumber(31)
  $core.String get cardHolderName => $_getSZ(14);
  @$pb.TagNumber(31)
  set cardHolderName($core.String v) { $_setString(14, v); }
  @$pb.TagNumber(31)
  $core.bool hasCardHolderName() => $_has(14);
  @$pb.TagNumber(31)
  void clearCardHolderName() => clearField(31);

  @$pb.TagNumber(40)
  $core.String get accountName => $_getSZ(15);
  @$pb.TagNumber(40)
  set accountName($core.String v) { $_setString(15, v); }
  @$pb.TagNumber(40)
  $core.bool hasAccountName() => $_has(15);
  @$pb.TagNumber(40)
  void clearAccountName() => clearField(40);

  @$pb.TagNumber(41)
  $core.String get accountType => $_getSZ(16);
  @$pb.TagNumber(41)
  set accountType($core.String v) { $_setString(16, v); }
  @$pb.TagNumber(41)
  $core.bool hasAccountType() => $_has(16);
  @$pb.TagNumber(41)
  void clearAccountType() => clearField(41);

  @$pb.TagNumber(42)
  $core.String get bankCode => $_getSZ(17);
  @$pb.TagNumber(42)
  set bankCode($core.String v) { $_setString(17, v); }
  @$pb.TagNumber(42)
  $core.bool hasBankCode() => $_has(17);
  @$pb.TagNumber(42)
  void clearBankCode() => clearField(42);

  @$pb.TagNumber(43)
  $core.String get bankName => $_getSZ(18);
  @$pb.TagNumber(43)
  set bankName($core.String v) { $_setString(18, v); }
  @$pb.TagNumber(43)
  $core.bool hasBankName() => $_has(18);
  @$pb.TagNumber(43)
  void clearBankName() => clearField(43);

  @$pb.TagNumber(50)
  $1.Timestamp get lastUsedAt => $_getN(19);
  @$pb.TagNumber(50)
  set lastUsedAt($1.Timestamp v) { setField(50, v); }
  @$pb.TagNumber(50)
  $core.bool hasLastUsedAt() => $_has(19);
  @$pb.TagNumber(50)
  void clearLastUsedAt() => clearField(50);
  @$pb.TagNumber(50)
  $1.Timestamp ensureLastUsedAt() => $_ensure(19);
}

class ListBeneficiariesRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ListBeneficiariesRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rmb'), createEmptyInstance: create)
    ..e<RmbRail>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'rail', $pb.PbFieldType.OE, defaultOrMaker: RmbRail.RAIL_UNSPECIFIED, valueOf: RmbRail.valueOf, enumValues: RmbRail.values)
    ..hasRequiredFields = false
  ;

  ListBeneficiariesRequest._() : super();
  factory ListBeneficiariesRequest({
    RmbRail? rail,
  }) {
    final _result = create();
    if (rail != null) {
      _result.rail = rail;
    }
    return _result;
  }
  factory ListBeneficiariesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListBeneficiariesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListBeneficiariesRequest clone() => ListBeneficiariesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListBeneficiariesRequest copyWith(void Function(ListBeneficiariesRequest) updates) => super.copyWith((message) => updates(message as ListBeneficiariesRequest)) as ListBeneficiariesRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ListBeneficiariesRequest create() => ListBeneficiariesRequest._();
  ListBeneficiariesRequest createEmptyInstance() => create();
  static $pb.PbList<ListBeneficiariesRequest> createRepeated() => $pb.PbList<ListBeneficiariesRequest>();
  @$core.pragma('dart2js:noInline')
  static ListBeneficiariesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListBeneficiariesRequest>(create);
  static ListBeneficiariesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  RmbRail get rail => $_getN(0);
  @$pb.TagNumber(1)
  set rail(RmbRail v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasRail() => $_has(0);
  @$pb.TagNumber(1)
  void clearRail() => clearField(1);
}

class ListBeneficiariesResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ListBeneficiariesResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rmb'), createEmptyInstance: create)
    ..pc<Beneficiary>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'beneficiaries', $pb.PbFieldType.PM, subBuilder: Beneficiary.create)
    ..hasRequiredFields = false
  ;

  ListBeneficiariesResponse._() : super();
  factory ListBeneficiariesResponse({
    $core.Iterable<Beneficiary>? beneficiaries,
  }) {
    final _result = create();
    if (beneficiaries != null) {
      _result.beneficiaries.addAll(beneficiaries);
    }
    return _result;
  }
  factory ListBeneficiariesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListBeneficiariesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListBeneficiariesResponse clone() => ListBeneficiariesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListBeneficiariesResponse copyWith(void Function(ListBeneficiariesResponse) updates) => super.copyWith((message) => updates(message as ListBeneficiariesResponse)) as ListBeneficiariesResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ListBeneficiariesResponse create() => ListBeneficiariesResponse._();
  ListBeneficiariesResponse createEmptyInstance() => create();
  static $pb.PbList<ListBeneficiariesResponse> createRepeated() => $pb.PbList<ListBeneficiariesResponse>();
  @$core.pragma('dart2js:noInline')
  static ListBeneficiariesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListBeneficiariesResponse>(create);
  static ListBeneficiariesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Beneficiary> get beneficiaries => $_getList(0);
}

class SaveBeneficiaryRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SaveBeneficiaryRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rmb'), createEmptyInstance: create)
    ..aOM<Beneficiary>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'beneficiary', subBuilder: Beneficiary.create)
    ..hasRequiredFields = false
  ;

  SaveBeneficiaryRequest._() : super();
  factory SaveBeneficiaryRequest({
    Beneficiary? beneficiary,
  }) {
    final _result = create();
    if (beneficiary != null) {
      _result.beneficiary = beneficiary;
    }
    return _result;
  }
  factory SaveBeneficiaryRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SaveBeneficiaryRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SaveBeneficiaryRequest clone() => SaveBeneficiaryRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SaveBeneficiaryRequest copyWith(void Function(SaveBeneficiaryRequest) updates) => super.copyWith((message) => updates(message as SaveBeneficiaryRequest)) as SaveBeneficiaryRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SaveBeneficiaryRequest create() => SaveBeneficiaryRequest._();
  SaveBeneficiaryRequest createEmptyInstance() => create();
  static $pb.PbList<SaveBeneficiaryRequest> createRepeated() => $pb.PbList<SaveBeneficiaryRequest>();
  @$core.pragma('dart2js:noInline')
  static SaveBeneficiaryRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SaveBeneficiaryRequest>(create);
  static SaveBeneficiaryRequest? _defaultInstance;

  @$pb.TagNumber(1)
  Beneficiary get beneficiary => $_getN(0);
  @$pb.TagNumber(1)
  set beneficiary(Beneficiary v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasBeneficiary() => $_has(0);
  @$pb.TagNumber(1)
  void clearBeneficiary() => clearField(1);
  @$pb.TagNumber(1)
  Beneficiary ensureBeneficiary() => $_ensure(0);
}

class SaveBeneficiaryResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SaveBeneficiaryResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rmb'), createEmptyInstance: create)
    ..aOM<Beneficiary>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'beneficiary', subBuilder: Beneficiary.create)
    ..hasRequiredFields = false
  ;

  SaveBeneficiaryResponse._() : super();
  factory SaveBeneficiaryResponse({
    Beneficiary? beneficiary,
  }) {
    final _result = create();
    if (beneficiary != null) {
      _result.beneficiary = beneficiary;
    }
    return _result;
  }
  factory SaveBeneficiaryResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SaveBeneficiaryResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SaveBeneficiaryResponse clone() => SaveBeneficiaryResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SaveBeneficiaryResponse copyWith(void Function(SaveBeneficiaryResponse) updates) => super.copyWith((message) => updates(message as SaveBeneficiaryResponse)) as SaveBeneficiaryResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SaveBeneficiaryResponse create() => SaveBeneficiaryResponse._();
  SaveBeneficiaryResponse createEmptyInstance() => create();
  static $pb.PbList<SaveBeneficiaryResponse> createRepeated() => $pb.PbList<SaveBeneficiaryResponse>();
  @$core.pragma('dart2js:noInline')
  static SaveBeneficiaryResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SaveBeneficiaryResponse>(create);
  static SaveBeneficiaryResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Beneficiary get beneficiary => $_getN(0);
  @$pb.TagNumber(1)
  set beneficiary(Beneficiary v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasBeneficiary() => $_has(0);
  @$pb.TagNumber(1)
  void clearBeneficiary() => clearField(1);
  @$pb.TagNumber(1)
  Beneficiary ensureBeneficiary() => $_ensure(0);
}

class UpdateBeneficiaryRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateBeneficiaryRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rmb'), createEmptyInstance: create)
    ..aOM<Beneficiary>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'beneficiary', subBuilder: Beneficiary.create)
    ..hasRequiredFields = false
  ;

  UpdateBeneficiaryRequest._() : super();
  factory UpdateBeneficiaryRequest({
    Beneficiary? beneficiary,
  }) {
    final _result = create();
    if (beneficiary != null) {
      _result.beneficiary = beneficiary;
    }
    return _result;
  }
  factory UpdateBeneficiaryRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateBeneficiaryRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateBeneficiaryRequest clone() => UpdateBeneficiaryRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateBeneficiaryRequest copyWith(void Function(UpdateBeneficiaryRequest) updates) => super.copyWith((message) => updates(message as UpdateBeneficiaryRequest)) as UpdateBeneficiaryRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpdateBeneficiaryRequest create() => UpdateBeneficiaryRequest._();
  UpdateBeneficiaryRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateBeneficiaryRequest> createRepeated() => $pb.PbList<UpdateBeneficiaryRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateBeneficiaryRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateBeneficiaryRequest>(create);
  static UpdateBeneficiaryRequest? _defaultInstance;

  @$pb.TagNumber(1)
  Beneficiary get beneficiary => $_getN(0);
  @$pb.TagNumber(1)
  set beneficiary(Beneficiary v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasBeneficiary() => $_has(0);
  @$pb.TagNumber(1)
  void clearBeneficiary() => clearField(1);
  @$pb.TagNumber(1)
  Beneficiary ensureBeneficiary() => $_ensure(0);
}

class UpdateBeneficiaryResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateBeneficiaryResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rmb'), createEmptyInstance: create)
    ..aOM<Beneficiary>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'beneficiary', subBuilder: Beneficiary.create)
    ..hasRequiredFields = false
  ;

  UpdateBeneficiaryResponse._() : super();
  factory UpdateBeneficiaryResponse({
    Beneficiary? beneficiary,
  }) {
    final _result = create();
    if (beneficiary != null) {
      _result.beneficiary = beneficiary;
    }
    return _result;
  }
  factory UpdateBeneficiaryResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateBeneficiaryResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateBeneficiaryResponse clone() => UpdateBeneficiaryResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateBeneficiaryResponse copyWith(void Function(UpdateBeneficiaryResponse) updates) => super.copyWith((message) => updates(message as UpdateBeneficiaryResponse)) as UpdateBeneficiaryResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpdateBeneficiaryResponse create() => UpdateBeneficiaryResponse._();
  UpdateBeneficiaryResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateBeneficiaryResponse> createRepeated() => $pb.PbList<UpdateBeneficiaryResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateBeneficiaryResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateBeneficiaryResponse>(create);
  static UpdateBeneficiaryResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Beneficiary get beneficiary => $_getN(0);
  @$pb.TagNumber(1)
  set beneficiary(Beneficiary v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasBeneficiary() => $_has(0);
  @$pb.TagNumber(1)
  void clearBeneficiary() => clearField(1);
  @$pb.TagNumber(1)
  Beneficiary ensureBeneficiary() => $_ensure(0);
}

class DeleteBeneficiaryRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DeleteBeneficiaryRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rmb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..hasRequiredFields = false
  ;

  DeleteBeneficiaryRequest._() : super();
  factory DeleteBeneficiaryRequest({
    $core.String? id,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    return _result;
  }
  factory DeleteBeneficiaryRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteBeneficiaryRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteBeneficiaryRequest clone() => DeleteBeneficiaryRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteBeneficiaryRequest copyWith(void Function(DeleteBeneficiaryRequest) updates) => super.copyWith((message) => updates(message as DeleteBeneficiaryRequest)) as DeleteBeneficiaryRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DeleteBeneficiaryRequest create() => DeleteBeneficiaryRequest._();
  DeleteBeneficiaryRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteBeneficiaryRequest> createRepeated() => $pb.PbList<DeleteBeneficiaryRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteBeneficiaryRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteBeneficiaryRequest>(create);
  static DeleteBeneficiaryRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);
}

class DeleteBeneficiaryResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DeleteBeneficiaryResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rmb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..hasRequiredFields = false
  ;

  DeleteBeneficiaryResponse._() : super();
  factory DeleteBeneficiaryResponse({
    $core.bool? success,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    return _result;
  }
  factory DeleteBeneficiaryResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteBeneficiaryResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteBeneficiaryResponse clone() => DeleteBeneficiaryResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteBeneficiaryResponse copyWith(void Function(DeleteBeneficiaryResponse) updates) => super.copyWith((message) => updates(message as DeleteBeneficiaryResponse)) as DeleteBeneficiaryResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DeleteBeneficiaryResponse create() => DeleteBeneficiaryResponse._();
  DeleteBeneficiaryResponse createEmptyInstance() => create();
  static $pb.PbList<DeleteBeneficiaryResponse> createRepeated() => $pb.PbList<DeleteBeneficiaryResponse>();
  @$core.pragma('dart2js:noInline')
  static DeleteBeneficiaryResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteBeneficiaryResponse>(create);
  static DeleteBeneficiaryResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);
}

class FavouriteBeneficiaryRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'FavouriteBeneficiaryRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rmb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'favourite')
    ..hasRequiredFields = false
  ;

  FavouriteBeneficiaryRequest._() : super();
  factory FavouriteBeneficiaryRequest({
    $core.String? id,
    $core.bool? favourite,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (favourite != null) {
      _result.favourite = favourite;
    }
    return _result;
  }
  factory FavouriteBeneficiaryRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FavouriteBeneficiaryRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FavouriteBeneficiaryRequest clone() => FavouriteBeneficiaryRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FavouriteBeneficiaryRequest copyWith(void Function(FavouriteBeneficiaryRequest) updates) => super.copyWith((message) => updates(message as FavouriteBeneficiaryRequest)) as FavouriteBeneficiaryRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FavouriteBeneficiaryRequest create() => FavouriteBeneficiaryRequest._();
  FavouriteBeneficiaryRequest createEmptyInstance() => create();
  static $pb.PbList<FavouriteBeneficiaryRequest> createRepeated() => $pb.PbList<FavouriteBeneficiaryRequest>();
  @$core.pragma('dart2js:noInline')
  static FavouriteBeneficiaryRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FavouriteBeneficiaryRequest>(create);
  static FavouriteBeneficiaryRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get favourite => $_getBF(1);
  @$pb.TagNumber(2)
  set favourite($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFavourite() => $_has(1);
  @$pb.TagNumber(2)
  void clearFavourite() => clearField(2);
}

class FavouriteBeneficiaryResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'FavouriteBeneficiaryResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rmb'), createEmptyInstance: create)
    ..aOM<Beneficiary>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'beneficiary', subBuilder: Beneficiary.create)
    ..hasRequiredFields = false
  ;

  FavouriteBeneficiaryResponse._() : super();
  factory FavouriteBeneficiaryResponse({
    Beneficiary? beneficiary,
  }) {
    final _result = create();
    if (beneficiary != null) {
      _result.beneficiary = beneficiary;
    }
    return _result;
  }
  factory FavouriteBeneficiaryResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FavouriteBeneficiaryResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FavouriteBeneficiaryResponse clone() => FavouriteBeneficiaryResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FavouriteBeneficiaryResponse copyWith(void Function(FavouriteBeneficiaryResponse) updates) => super.copyWith((message) => updates(message as FavouriteBeneficiaryResponse)) as FavouriteBeneficiaryResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FavouriteBeneficiaryResponse create() => FavouriteBeneficiaryResponse._();
  FavouriteBeneficiaryResponse createEmptyInstance() => create();
  static $pb.PbList<FavouriteBeneficiaryResponse> createRepeated() => $pb.PbList<FavouriteBeneficiaryResponse>();
  @$core.pragma('dart2js:noInline')
  static FavouriteBeneficiaryResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FavouriteBeneficiaryResponse>(create);
  static FavouriteBeneficiaryResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Beneficiary get beneficiary => $_getN(0);
  @$pb.TagNumber(1)
  set beneficiary(Beneficiary v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasBeneficiary() => $_has(0);
  @$pb.TagNumber(1)
  void clearBeneficiary() => clearField(1);
  @$pb.TagNumber(1)
  Beneficiary ensureBeneficiary() => $_ensure(0);
}

class Address extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Address', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rmb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'city')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'countryCode')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'postcode')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'state')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'streetAddress')
    ..hasRequiredFields = false
  ;

  Address._() : super();
  factory Address({
    $core.String? city,
    $core.String? countryCode,
    $core.String? postcode,
    $core.String? state,
    $core.String? streetAddress,
  }) {
    final _result = create();
    if (city != null) {
      _result.city = city;
    }
    if (countryCode != null) {
      _result.countryCode = countryCode;
    }
    if (postcode != null) {
      _result.postcode = postcode;
    }
    if (state != null) {
      _result.state = state;
    }
    if (streetAddress != null) {
      _result.streetAddress = streetAddress;
    }
    return _result;
  }
  factory Address.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Address.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Address clone() => Address()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Address copyWith(void Function(Address) updates) => super.copyWith((message) => updates(message as Address)) as Address; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Address create() => Address._();
  Address createEmptyInstance() => create();
  static $pb.PbList<Address> createRepeated() => $pb.PbList<Address>();
  @$core.pragma('dart2js:noInline')
  static Address getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Address>(create);
  static Address? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get city => $_getSZ(0);
  @$pb.TagNumber(1)
  set city($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCity() => $_has(0);
  @$pb.TagNumber(1)
  void clearCity() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get countryCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set countryCode($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCountryCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearCountryCode() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get postcode => $_getSZ(2);
  @$pb.TagNumber(3)
  set postcode($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPostcode() => $_has(2);
  @$pb.TagNumber(3)
  void clearPostcode() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get state => $_getSZ(3);
  @$pb.TagNumber(4)
  set state($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasState() => $_has(3);
  @$pb.TagNumber(4)
  void clearState() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get streetAddress => $_getSZ(4);
  @$pb.TagNumber(5)
  set streetAddress($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasStreetAddress() => $_has(4);
  @$pb.TagNumber(5)
  void clearStreetAddress() => clearField(5);
}

class ComplianceProfile extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ComplianceProfile', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rmb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'senderFirstName')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'senderLastName')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'senderIdNumber')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'senderIdType')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'senderNationality')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'senderBirthDate')
    ..aOM<Address>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'senderAddress', subBuilder: Address.create)
    ..aOB(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'complete')
    ..hasRequiredFields = false
  ;

  ComplianceProfile._() : super();
  factory ComplianceProfile({
    $core.String? senderFirstName,
    $core.String? senderLastName,
    $core.String? senderIdNumber,
    $core.String? senderIdType,
    $core.String? senderNationality,
    $core.String? senderBirthDate,
    Address? senderAddress,
    $core.bool? complete,
  }) {
    final _result = create();
    if (senderFirstName != null) {
      _result.senderFirstName = senderFirstName;
    }
    if (senderLastName != null) {
      _result.senderLastName = senderLastName;
    }
    if (senderIdNumber != null) {
      _result.senderIdNumber = senderIdNumber;
    }
    if (senderIdType != null) {
      _result.senderIdType = senderIdType;
    }
    if (senderNationality != null) {
      _result.senderNationality = senderNationality;
    }
    if (senderBirthDate != null) {
      _result.senderBirthDate = senderBirthDate;
    }
    if (senderAddress != null) {
      _result.senderAddress = senderAddress;
    }
    if (complete != null) {
      _result.complete = complete;
    }
    return _result;
  }
  factory ComplianceProfile.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ComplianceProfile.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ComplianceProfile clone() => ComplianceProfile()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ComplianceProfile copyWith(void Function(ComplianceProfile) updates) => super.copyWith((message) => updates(message as ComplianceProfile)) as ComplianceProfile; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ComplianceProfile create() => ComplianceProfile._();
  ComplianceProfile createEmptyInstance() => create();
  static $pb.PbList<ComplianceProfile> createRepeated() => $pb.PbList<ComplianceProfile>();
  @$core.pragma('dart2js:noInline')
  static ComplianceProfile getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ComplianceProfile>(create);
  static ComplianceProfile? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get senderFirstName => $_getSZ(0);
  @$pb.TagNumber(1)
  set senderFirstName($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSenderFirstName() => $_has(0);
  @$pb.TagNumber(1)
  void clearSenderFirstName() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get senderLastName => $_getSZ(1);
  @$pb.TagNumber(2)
  set senderLastName($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSenderLastName() => $_has(1);
  @$pb.TagNumber(2)
  void clearSenderLastName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get senderIdNumber => $_getSZ(2);
  @$pb.TagNumber(3)
  set senderIdNumber($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSenderIdNumber() => $_has(2);
  @$pb.TagNumber(3)
  void clearSenderIdNumber() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get senderIdType => $_getSZ(3);
  @$pb.TagNumber(4)
  set senderIdType($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasSenderIdType() => $_has(3);
  @$pb.TagNumber(4)
  void clearSenderIdType() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get senderNationality => $_getSZ(4);
  @$pb.TagNumber(5)
  set senderNationality($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasSenderNationality() => $_has(4);
  @$pb.TagNumber(5)
  void clearSenderNationality() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get senderBirthDate => $_getSZ(5);
  @$pb.TagNumber(6)
  set senderBirthDate($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasSenderBirthDate() => $_has(5);
  @$pb.TagNumber(6)
  void clearSenderBirthDate() => clearField(6);

  @$pb.TagNumber(7)
  Address get senderAddress => $_getN(6);
  @$pb.TagNumber(7)
  set senderAddress(Address v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasSenderAddress() => $_has(6);
  @$pb.TagNumber(7)
  void clearSenderAddress() => clearField(7);
  @$pb.TagNumber(7)
  Address ensureSenderAddress() => $_ensure(6);

  @$pb.TagNumber(8)
  $core.bool get complete => $_getBF(7);
  @$pb.TagNumber(8)
  set complete($core.bool v) { $_setBool(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasComplete() => $_has(7);
  @$pb.TagNumber(8)
  void clearComplete() => clearField(8);
}

class GetComplianceProfileRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetComplianceProfileRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rmb'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetComplianceProfileRequest._() : super();
  factory GetComplianceProfileRequest() => create();
  factory GetComplianceProfileRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetComplianceProfileRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetComplianceProfileRequest clone() => GetComplianceProfileRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetComplianceProfileRequest copyWith(void Function(GetComplianceProfileRequest) updates) => super.copyWith((message) => updates(message as GetComplianceProfileRequest)) as GetComplianceProfileRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetComplianceProfileRequest create() => GetComplianceProfileRequest._();
  GetComplianceProfileRequest createEmptyInstance() => create();
  static $pb.PbList<GetComplianceProfileRequest> createRepeated() => $pb.PbList<GetComplianceProfileRequest>();
  @$core.pragma('dart2js:noInline')
  static GetComplianceProfileRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetComplianceProfileRequest>(create);
  static GetComplianceProfileRequest? _defaultInstance;
}

class GetComplianceProfileResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetComplianceProfileResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rmb'), createEmptyInstance: create)
    ..aOM<ComplianceProfile>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'profile', subBuilder: ComplianceProfile.create)
    ..hasRequiredFields = false
  ;

  GetComplianceProfileResponse._() : super();
  factory GetComplianceProfileResponse({
    ComplianceProfile? profile,
  }) {
    final _result = create();
    if (profile != null) {
      _result.profile = profile;
    }
    return _result;
  }
  factory GetComplianceProfileResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetComplianceProfileResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetComplianceProfileResponse clone() => GetComplianceProfileResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetComplianceProfileResponse copyWith(void Function(GetComplianceProfileResponse) updates) => super.copyWith((message) => updates(message as GetComplianceProfileResponse)) as GetComplianceProfileResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetComplianceProfileResponse create() => GetComplianceProfileResponse._();
  GetComplianceProfileResponse createEmptyInstance() => create();
  static $pb.PbList<GetComplianceProfileResponse> createRepeated() => $pb.PbList<GetComplianceProfileResponse>();
  @$core.pragma('dart2js:noInline')
  static GetComplianceProfileResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetComplianceProfileResponse>(create);
  static GetComplianceProfileResponse? _defaultInstance;

  @$pb.TagNumber(1)
  ComplianceProfile get profile => $_getN(0);
  @$pb.TagNumber(1)
  set profile(ComplianceProfile v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasProfile() => $_has(0);
  @$pb.TagNumber(1)
  void clearProfile() => clearField(1);
  @$pb.TagNumber(1)
  ComplianceProfile ensureProfile() => $_ensure(0);
}

class UpsertComplianceProfileRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpsertComplianceProfileRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rmb'), createEmptyInstance: create)
    ..aOM<ComplianceProfile>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'profile', subBuilder: ComplianceProfile.create)
    ..hasRequiredFields = false
  ;

  UpsertComplianceProfileRequest._() : super();
  factory UpsertComplianceProfileRequest({
    ComplianceProfile? profile,
  }) {
    final _result = create();
    if (profile != null) {
      _result.profile = profile;
    }
    return _result;
  }
  factory UpsertComplianceProfileRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpsertComplianceProfileRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpsertComplianceProfileRequest clone() => UpsertComplianceProfileRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpsertComplianceProfileRequest copyWith(void Function(UpsertComplianceProfileRequest) updates) => super.copyWith((message) => updates(message as UpsertComplianceProfileRequest)) as UpsertComplianceProfileRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpsertComplianceProfileRequest create() => UpsertComplianceProfileRequest._();
  UpsertComplianceProfileRequest createEmptyInstance() => create();
  static $pb.PbList<UpsertComplianceProfileRequest> createRepeated() => $pb.PbList<UpsertComplianceProfileRequest>();
  @$core.pragma('dart2js:noInline')
  static UpsertComplianceProfileRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpsertComplianceProfileRequest>(create);
  static UpsertComplianceProfileRequest? _defaultInstance;

  @$pb.TagNumber(1)
  ComplianceProfile get profile => $_getN(0);
  @$pb.TagNumber(1)
  set profile(ComplianceProfile v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasProfile() => $_has(0);
  @$pb.TagNumber(1)
  void clearProfile() => clearField(1);
  @$pb.TagNumber(1)
  ComplianceProfile ensureProfile() => $_ensure(0);
}

class UpsertComplianceProfileResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpsertComplianceProfileResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rmb'), createEmptyInstance: create)
    ..aOM<ComplianceProfile>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'profile', subBuilder: ComplianceProfile.create)
    ..hasRequiredFields = false
  ;

  UpsertComplianceProfileResponse._() : super();
  factory UpsertComplianceProfileResponse({
    ComplianceProfile? profile,
  }) {
    final _result = create();
    if (profile != null) {
      _result.profile = profile;
    }
    return _result;
  }
  factory UpsertComplianceProfileResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpsertComplianceProfileResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpsertComplianceProfileResponse clone() => UpsertComplianceProfileResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpsertComplianceProfileResponse copyWith(void Function(UpsertComplianceProfileResponse) updates) => super.copyWith((message) => updates(message as UpsertComplianceProfileResponse)) as UpsertComplianceProfileResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpsertComplianceProfileResponse create() => UpsertComplianceProfileResponse._();
  UpsertComplianceProfileResponse createEmptyInstance() => create();
  static $pb.PbList<UpsertComplianceProfileResponse> createRepeated() => $pb.PbList<UpsertComplianceProfileResponse>();
  @$core.pragma('dart2js:noInline')
  static UpsertComplianceProfileResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpsertComplianceProfileResponse>(create);
  static UpsertComplianceProfileResponse? _defaultInstance;

  @$pb.TagNumber(1)
  ComplianceProfile get profile => $_getN(0);
  @$pb.TagNumber(1)
  set profile(ComplianceProfile v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasProfile() => $_has(0);
  @$pb.TagNumber(1)
  void clearProfile() => clearField(1);
  @$pb.TagNumber(1)
  ComplianceProfile ensureProfile() => $_ensure(0);
}

class Transfer extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Transfer', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rmb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reference')
    ..e<RmbRail>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'rail', $pb.PbFieldType.OE, defaultOrMaker: RmbRail.RAIL_UNSPECIFIED, valueOf: RmbRail.valueOf, enumValues: RmbRail.values)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'provider')
    ..e<RmbStatus>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: RmbStatus.RMB_STATUS_UNSPECIFIED, valueOf: RmbStatus.valueOf, enumValues: RmbStatus.values)
    ..aInt64(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'destAmountMinor')
    ..aInt64(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sourceAmountMinor')
    ..a<$core.double>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fxRate', $pb.PbFieldType.OD)
    ..aInt64(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerFeeMinor')
    ..aInt64(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ourFeeMinor')
    ..aInt64(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalMinor')
    ..aOS(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'beneficiaryName')
    ..aOS(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'beneficiaryId')
    ..aOS(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'purpose')
    ..aOS(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerRef')
    ..aOS(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'failureReason')
    ..aOS(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'complianceStatus')
    ..aOM<$1.Timestamp>(18, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(19, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedAt', subBuilder: $1.Timestamp.create)
    ..aOS(20, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'receiverFirstName')
    ..aOS(21, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'receiverLastName')
    ..aOS(22, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountNumber')
    ..aOS(23, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountIdType')
    ..aOS(24, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bankName')
    ..aOS(25, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bankCode')
    ..aOS(26, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cardHolderName')
    ..aOS(27, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountName')
    ..aOS(28, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'receiverMobile')
    ..aOS(29, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'receiverIdNumber')
    ..aOS(30, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'receiverIdType')
    ..aOS(31, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'receiverRelationship')
    ..hasRequiredFields = false
  ;

  Transfer._() : super();
  factory Transfer({
    $core.String? id,
    $core.String? reference,
    RmbRail? rail,
    $core.String? provider,
    RmbStatus? status,
    $fixnum.Int64? destAmountMinor,
    $fixnum.Int64? sourceAmountMinor,
    $core.double? fxRate,
    $fixnum.Int64? providerFeeMinor,
    $fixnum.Int64? ourFeeMinor,
    $fixnum.Int64? totalMinor,
    $core.String? beneficiaryName,
    $core.String? beneficiaryId,
    $core.String? purpose,
    $core.String? providerRef,
    $core.String? failureReason,
    $core.String? complianceStatus,
    $1.Timestamp? createdAt,
    $1.Timestamp? updatedAt,
    $core.String? receiverFirstName,
    $core.String? receiverLastName,
    $core.String? accountNumber,
    $core.String? accountIdType,
    $core.String? bankName,
    $core.String? bankCode,
    $core.String? cardHolderName,
    $core.String? accountName,
    $core.String? receiverMobile,
    $core.String? receiverIdNumber,
    $core.String? receiverIdType,
    $core.String? receiverRelationship,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (reference != null) {
      _result.reference = reference;
    }
    if (rail != null) {
      _result.rail = rail;
    }
    if (provider != null) {
      _result.provider = provider;
    }
    if (status != null) {
      _result.status = status;
    }
    if (destAmountMinor != null) {
      _result.destAmountMinor = destAmountMinor;
    }
    if (sourceAmountMinor != null) {
      _result.sourceAmountMinor = sourceAmountMinor;
    }
    if (fxRate != null) {
      _result.fxRate = fxRate;
    }
    if (providerFeeMinor != null) {
      _result.providerFeeMinor = providerFeeMinor;
    }
    if (ourFeeMinor != null) {
      _result.ourFeeMinor = ourFeeMinor;
    }
    if (totalMinor != null) {
      _result.totalMinor = totalMinor;
    }
    if (beneficiaryName != null) {
      _result.beneficiaryName = beneficiaryName;
    }
    if (beneficiaryId != null) {
      _result.beneficiaryId = beneficiaryId;
    }
    if (purpose != null) {
      _result.purpose = purpose;
    }
    if (providerRef != null) {
      _result.providerRef = providerRef;
    }
    if (failureReason != null) {
      _result.failureReason = failureReason;
    }
    if (complianceStatus != null) {
      _result.complianceStatus = complianceStatus;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      _result.updatedAt = updatedAt;
    }
    if (receiverFirstName != null) {
      _result.receiverFirstName = receiverFirstName;
    }
    if (receiverLastName != null) {
      _result.receiverLastName = receiverLastName;
    }
    if (accountNumber != null) {
      _result.accountNumber = accountNumber;
    }
    if (accountIdType != null) {
      _result.accountIdType = accountIdType;
    }
    if (bankName != null) {
      _result.bankName = bankName;
    }
    if (bankCode != null) {
      _result.bankCode = bankCode;
    }
    if (cardHolderName != null) {
      _result.cardHolderName = cardHolderName;
    }
    if (accountName != null) {
      _result.accountName = accountName;
    }
    if (receiverMobile != null) {
      _result.receiverMobile = receiverMobile;
    }
    if (receiverIdNumber != null) {
      _result.receiverIdNumber = receiverIdNumber;
    }
    if (receiverIdType != null) {
      _result.receiverIdType = receiverIdType;
    }
    if (receiverRelationship != null) {
      _result.receiverRelationship = receiverRelationship;
    }
    return _result;
  }
  factory Transfer.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Transfer.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Transfer clone() => Transfer()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Transfer copyWith(void Function(Transfer) updates) => super.copyWith((message) => updates(message as Transfer)) as Transfer; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Transfer create() => Transfer._();
  Transfer createEmptyInstance() => create();
  static $pb.PbList<Transfer> createRepeated() => $pb.PbList<Transfer>();
  @$core.pragma('dart2js:noInline')
  static Transfer getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Transfer>(create);
  static Transfer? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get reference => $_getSZ(1);
  @$pb.TagNumber(2)
  set reference($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasReference() => $_has(1);
  @$pb.TagNumber(2)
  void clearReference() => clearField(2);

  @$pb.TagNumber(3)
  RmbRail get rail => $_getN(2);
  @$pb.TagNumber(3)
  set rail(RmbRail v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasRail() => $_has(2);
  @$pb.TagNumber(3)
  void clearRail() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get provider => $_getSZ(3);
  @$pb.TagNumber(4)
  set provider($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasProvider() => $_has(3);
  @$pb.TagNumber(4)
  void clearProvider() => clearField(4);

  @$pb.TagNumber(5)
  RmbStatus get status => $_getN(4);
  @$pb.TagNumber(5)
  set status(RmbStatus v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasStatus() => $_has(4);
  @$pb.TagNumber(5)
  void clearStatus() => clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get destAmountMinor => $_getI64(5);
  @$pb.TagNumber(6)
  set destAmountMinor($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasDestAmountMinor() => $_has(5);
  @$pb.TagNumber(6)
  void clearDestAmountMinor() => clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get sourceAmountMinor => $_getI64(6);
  @$pb.TagNumber(7)
  set sourceAmountMinor($fixnum.Int64 v) { $_setInt64(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasSourceAmountMinor() => $_has(6);
  @$pb.TagNumber(7)
  void clearSourceAmountMinor() => clearField(7);

  @$pb.TagNumber(8)
  $core.double get fxRate => $_getN(7);
  @$pb.TagNumber(8)
  set fxRate($core.double v) { $_setDouble(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasFxRate() => $_has(7);
  @$pb.TagNumber(8)
  void clearFxRate() => clearField(8);

  @$pb.TagNumber(9)
  $fixnum.Int64 get providerFeeMinor => $_getI64(8);
  @$pb.TagNumber(9)
  set providerFeeMinor($fixnum.Int64 v) { $_setInt64(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasProviderFeeMinor() => $_has(8);
  @$pb.TagNumber(9)
  void clearProviderFeeMinor() => clearField(9);

  @$pb.TagNumber(10)
  $fixnum.Int64 get ourFeeMinor => $_getI64(9);
  @$pb.TagNumber(10)
  set ourFeeMinor($fixnum.Int64 v) { $_setInt64(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasOurFeeMinor() => $_has(9);
  @$pb.TagNumber(10)
  void clearOurFeeMinor() => clearField(10);

  @$pb.TagNumber(11)
  $fixnum.Int64 get totalMinor => $_getI64(10);
  @$pb.TagNumber(11)
  set totalMinor($fixnum.Int64 v) { $_setInt64(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasTotalMinor() => $_has(10);
  @$pb.TagNumber(11)
  void clearTotalMinor() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get beneficiaryName => $_getSZ(11);
  @$pb.TagNumber(12)
  set beneficiaryName($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasBeneficiaryName() => $_has(11);
  @$pb.TagNumber(12)
  void clearBeneficiaryName() => clearField(12);

  @$pb.TagNumber(13)
  $core.String get beneficiaryId => $_getSZ(12);
  @$pb.TagNumber(13)
  set beneficiaryId($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasBeneficiaryId() => $_has(12);
  @$pb.TagNumber(13)
  void clearBeneficiaryId() => clearField(13);

  @$pb.TagNumber(14)
  $core.String get purpose => $_getSZ(13);
  @$pb.TagNumber(14)
  set purpose($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasPurpose() => $_has(13);
  @$pb.TagNumber(14)
  void clearPurpose() => clearField(14);

  @$pb.TagNumber(15)
  $core.String get providerRef => $_getSZ(14);
  @$pb.TagNumber(15)
  set providerRef($core.String v) { $_setString(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasProviderRef() => $_has(14);
  @$pb.TagNumber(15)
  void clearProviderRef() => clearField(15);

  @$pb.TagNumber(16)
  $core.String get failureReason => $_getSZ(15);
  @$pb.TagNumber(16)
  set failureReason($core.String v) { $_setString(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasFailureReason() => $_has(15);
  @$pb.TagNumber(16)
  void clearFailureReason() => clearField(16);

  @$pb.TagNumber(17)
  $core.String get complianceStatus => $_getSZ(16);
  @$pb.TagNumber(17)
  set complianceStatus($core.String v) { $_setString(16, v); }
  @$pb.TagNumber(17)
  $core.bool hasComplianceStatus() => $_has(16);
  @$pb.TagNumber(17)
  void clearComplianceStatus() => clearField(17);

  @$pb.TagNumber(18)
  $1.Timestamp get createdAt => $_getN(17);
  @$pb.TagNumber(18)
  set createdAt($1.Timestamp v) { setField(18, v); }
  @$pb.TagNumber(18)
  $core.bool hasCreatedAt() => $_has(17);
  @$pb.TagNumber(18)
  void clearCreatedAt() => clearField(18);
  @$pb.TagNumber(18)
  $1.Timestamp ensureCreatedAt() => $_ensure(17);

  @$pb.TagNumber(19)
  $1.Timestamp get updatedAt => $_getN(18);
  @$pb.TagNumber(19)
  set updatedAt($1.Timestamp v) { setField(19, v); }
  @$pb.TagNumber(19)
  $core.bool hasUpdatedAt() => $_has(18);
  @$pb.TagNumber(19)
  void clearUpdatedAt() => clearField(19);
  @$pb.TagNumber(19)
  $1.Timestamp ensureUpdatedAt() => $_ensure(18);

  @$pb.TagNumber(20)
  $core.String get receiverFirstName => $_getSZ(19);
  @$pb.TagNumber(20)
  set receiverFirstName($core.String v) { $_setString(19, v); }
  @$pb.TagNumber(20)
  $core.bool hasReceiverFirstName() => $_has(19);
  @$pb.TagNumber(20)
  void clearReceiverFirstName() => clearField(20);

  @$pb.TagNumber(21)
  $core.String get receiverLastName => $_getSZ(20);
  @$pb.TagNumber(21)
  set receiverLastName($core.String v) { $_setString(20, v); }
  @$pb.TagNumber(21)
  $core.bool hasReceiverLastName() => $_has(20);
  @$pb.TagNumber(21)
  void clearReceiverLastName() => clearField(21);

  @$pb.TagNumber(22)
  $core.String get accountNumber => $_getSZ(21);
  @$pb.TagNumber(22)
  set accountNumber($core.String v) { $_setString(21, v); }
  @$pb.TagNumber(22)
  $core.bool hasAccountNumber() => $_has(21);
  @$pb.TagNumber(22)
  void clearAccountNumber() => clearField(22);

  @$pb.TagNumber(23)
  $core.String get accountIdType => $_getSZ(22);
  @$pb.TagNumber(23)
  set accountIdType($core.String v) { $_setString(22, v); }
  @$pb.TagNumber(23)
  $core.bool hasAccountIdType() => $_has(22);
  @$pb.TagNumber(23)
  void clearAccountIdType() => clearField(23);

  @$pb.TagNumber(24)
  $core.String get bankName => $_getSZ(23);
  @$pb.TagNumber(24)
  set bankName($core.String v) { $_setString(23, v); }
  @$pb.TagNumber(24)
  $core.bool hasBankName() => $_has(23);
  @$pb.TagNumber(24)
  void clearBankName() => clearField(24);

  @$pb.TagNumber(25)
  $core.String get bankCode => $_getSZ(24);
  @$pb.TagNumber(25)
  set bankCode($core.String v) { $_setString(24, v); }
  @$pb.TagNumber(25)
  $core.bool hasBankCode() => $_has(24);
  @$pb.TagNumber(25)
  void clearBankCode() => clearField(25);

  @$pb.TagNumber(26)
  $core.String get cardHolderName => $_getSZ(25);
  @$pb.TagNumber(26)
  set cardHolderName($core.String v) { $_setString(25, v); }
  @$pb.TagNumber(26)
  $core.bool hasCardHolderName() => $_has(25);
  @$pb.TagNumber(26)
  void clearCardHolderName() => clearField(26);

  @$pb.TagNumber(27)
  $core.String get accountName => $_getSZ(26);
  @$pb.TagNumber(27)
  set accountName($core.String v) { $_setString(26, v); }
  @$pb.TagNumber(27)
  $core.bool hasAccountName() => $_has(26);
  @$pb.TagNumber(27)
  void clearAccountName() => clearField(27);

  @$pb.TagNumber(28)
  $core.String get receiverMobile => $_getSZ(27);
  @$pb.TagNumber(28)
  set receiverMobile($core.String v) { $_setString(27, v); }
  @$pb.TagNumber(28)
  $core.bool hasReceiverMobile() => $_has(27);
  @$pb.TagNumber(28)
  void clearReceiverMobile() => clearField(28);

  @$pb.TagNumber(29)
  $core.String get receiverIdNumber => $_getSZ(28);
  @$pb.TagNumber(29)
  set receiverIdNumber($core.String v) { $_setString(28, v); }
  @$pb.TagNumber(29)
  $core.bool hasReceiverIdNumber() => $_has(28);
  @$pb.TagNumber(29)
  void clearReceiverIdNumber() => clearField(29);

  @$pb.TagNumber(30)
  $core.String get receiverIdType => $_getSZ(29);
  @$pb.TagNumber(30)
  set receiverIdType($core.String v) { $_setString(29, v); }
  @$pb.TagNumber(30)
  $core.bool hasReceiverIdType() => $_has(29);
  @$pb.TagNumber(30)
  void clearReceiverIdType() => clearField(30);

  @$pb.TagNumber(31)
  $core.String get receiverRelationship => $_getSZ(30);
  @$pb.TagNumber(31)
  set receiverRelationship($core.String v) { $_setString(30, v); }
  @$pb.TagNumber(31)
  $core.bool hasReceiverRelationship() => $_has(30);
  @$pb.TagNumber(31)
  void clearReceiverRelationship() => clearField(31);
}

class InitiateTransferRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'InitiateTransferRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rmb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'quoteId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'beneficiaryId')
    ..aOM<Beneficiary>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'beneficiary', subBuilder: Beneficiary.create)
    ..aOB(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'saveBeneficiary')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'purpose')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'verificationToken')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'idempotencyKey')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sourceAccountId')
    ..hasRequiredFields = false
  ;

  InitiateTransferRequest._() : super();
  factory InitiateTransferRequest({
    $core.String? quoteId,
    $core.String? beneficiaryId,
    Beneficiary? beneficiary,
    $core.bool? saveBeneficiary,
    $core.String? purpose,
    $core.String? verificationToken,
    $core.String? idempotencyKey,
    $core.String? sourceAccountId,
  }) {
    final _result = create();
    if (quoteId != null) {
      _result.quoteId = quoteId;
    }
    if (beneficiaryId != null) {
      _result.beneficiaryId = beneficiaryId;
    }
    if (beneficiary != null) {
      _result.beneficiary = beneficiary;
    }
    if (saveBeneficiary != null) {
      _result.saveBeneficiary = saveBeneficiary;
    }
    if (purpose != null) {
      _result.purpose = purpose;
    }
    if (verificationToken != null) {
      _result.verificationToken = verificationToken;
    }
    if (idempotencyKey != null) {
      _result.idempotencyKey = idempotencyKey;
    }
    if (sourceAccountId != null) {
      _result.sourceAccountId = sourceAccountId;
    }
    return _result;
  }
  factory InitiateTransferRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InitiateTransferRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InitiateTransferRequest clone() => InitiateTransferRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InitiateTransferRequest copyWith(void Function(InitiateTransferRequest) updates) => super.copyWith((message) => updates(message as InitiateTransferRequest)) as InitiateTransferRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static InitiateTransferRequest create() => InitiateTransferRequest._();
  InitiateTransferRequest createEmptyInstance() => create();
  static $pb.PbList<InitiateTransferRequest> createRepeated() => $pb.PbList<InitiateTransferRequest>();
  @$core.pragma('dart2js:noInline')
  static InitiateTransferRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InitiateTransferRequest>(create);
  static InitiateTransferRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get quoteId => $_getSZ(0);
  @$pb.TagNumber(1)
  set quoteId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasQuoteId() => $_has(0);
  @$pb.TagNumber(1)
  void clearQuoteId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get beneficiaryId => $_getSZ(1);
  @$pb.TagNumber(2)
  set beneficiaryId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasBeneficiaryId() => $_has(1);
  @$pb.TagNumber(2)
  void clearBeneficiaryId() => clearField(2);

  @$pb.TagNumber(3)
  Beneficiary get beneficiary => $_getN(2);
  @$pb.TagNumber(3)
  set beneficiary(Beneficiary v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasBeneficiary() => $_has(2);
  @$pb.TagNumber(3)
  void clearBeneficiary() => clearField(3);
  @$pb.TagNumber(3)
  Beneficiary ensureBeneficiary() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.bool get saveBeneficiary => $_getBF(3);
  @$pb.TagNumber(4)
  set saveBeneficiary($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasSaveBeneficiary() => $_has(3);
  @$pb.TagNumber(4)
  void clearSaveBeneficiary() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get purpose => $_getSZ(4);
  @$pb.TagNumber(5)
  set purpose($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasPurpose() => $_has(4);
  @$pb.TagNumber(5)
  void clearPurpose() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get verificationToken => $_getSZ(5);
  @$pb.TagNumber(6)
  set verificationToken($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasVerificationToken() => $_has(5);
  @$pb.TagNumber(6)
  void clearVerificationToken() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get idempotencyKey => $_getSZ(6);
  @$pb.TagNumber(7)
  set idempotencyKey($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasIdempotencyKey() => $_has(6);
  @$pb.TagNumber(7)
  void clearIdempotencyKey() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get sourceAccountId => $_getSZ(7);
  @$pb.TagNumber(8)
  set sourceAccountId($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasSourceAccountId() => $_has(7);
  @$pb.TagNumber(8)
  void clearSourceAccountId() => clearField(8);
}

class InitiateTransferResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'InitiateTransferResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rmb'), createEmptyInstance: create)
    ..aOM<Transfer>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transfer', subBuilder: Transfer.create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  InitiateTransferResponse._() : super();
  factory InitiateTransferResponse({
    Transfer? transfer,
    $core.String? message,
  }) {
    final _result = create();
    if (transfer != null) {
      _result.transfer = transfer;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory InitiateTransferResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InitiateTransferResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InitiateTransferResponse clone() => InitiateTransferResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InitiateTransferResponse copyWith(void Function(InitiateTransferResponse) updates) => super.copyWith((message) => updates(message as InitiateTransferResponse)) as InitiateTransferResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static InitiateTransferResponse create() => InitiateTransferResponse._();
  InitiateTransferResponse createEmptyInstance() => create();
  static $pb.PbList<InitiateTransferResponse> createRepeated() => $pb.PbList<InitiateTransferResponse>();
  @$core.pragma('dart2js:noInline')
  static InitiateTransferResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InitiateTransferResponse>(create);
  static InitiateTransferResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Transfer get transfer => $_getN(0);
  @$pb.TagNumber(1)
  set transfer(Transfer v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasTransfer() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransfer() => clearField(1);
  @$pb.TagNumber(1)
  Transfer ensureTransfer() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

class GetTransferRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetTransferRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rmb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..hasRequiredFields = false
  ;

  GetTransferRequest._() : super();
  factory GetTransferRequest({
    $core.String? id,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    return _result;
  }
  factory GetTransferRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTransferRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetTransferRequest clone() => GetTransferRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetTransferRequest copyWith(void Function(GetTransferRequest) updates) => super.copyWith((message) => updates(message as GetTransferRequest)) as GetTransferRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetTransferRequest create() => GetTransferRequest._();
  GetTransferRequest createEmptyInstance() => create();
  static $pb.PbList<GetTransferRequest> createRepeated() => $pb.PbList<GetTransferRequest>();
  @$core.pragma('dart2js:noInline')
  static GetTransferRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTransferRequest>(create);
  static GetTransferRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);
}

class GetTransferResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetTransferResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rmb'), createEmptyInstance: create)
    ..aOM<Transfer>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transfer', subBuilder: Transfer.create)
    ..hasRequiredFields = false
  ;

  GetTransferResponse._() : super();
  factory GetTransferResponse({
    Transfer? transfer,
  }) {
    final _result = create();
    if (transfer != null) {
      _result.transfer = transfer;
    }
    return _result;
  }
  factory GetTransferResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTransferResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetTransferResponse clone() => GetTransferResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetTransferResponse copyWith(void Function(GetTransferResponse) updates) => super.copyWith((message) => updates(message as GetTransferResponse)) as GetTransferResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetTransferResponse create() => GetTransferResponse._();
  GetTransferResponse createEmptyInstance() => create();
  static $pb.PbList<GetTransferResponse> createRepeated() => $pb.PbList<GetTransferResponse>();
  @$core.pragma('dart2js:noInline')
  static GetTransferResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTransferResponse>(create);
  static GetTransferResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Transfer get transfer => $_getN(0);
  @$pb.TagNumber(1)
  set transfer(Transfer v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasTransfer() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransfer() => clearField(1);
  @$pb.TagNumber(1)
  Transfer ensureTransfer() => $_ensure(0);
}

class ListTransfersRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ListTransfersRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rmb'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..e<RmbStatus>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: RmbStatus.RMB_STATUS_UNSPECIFIED, valueOf: RmbStatus.valueOf, enumValues: RmbStatus.values)
    ..hasRequiredFields = false
  ;

  ListTransfersRequest._() : super();
  factory ListTransfersRequest({
    $core.int? page,
    $core.int? pageSize,
    RmbStatus? status,
  }) {
    final _result = create();
    if (page != null) {
      _result.page = page;
    }
    if (pageSize != null) {
      _result.pageSize = pageSize;
    }
    if (status != null) {
      _result.status = status;
    }
    return _result;
  }
  factory ListTransfersRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListTransfersRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListTransfersRequest clone() => ListTransfersRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListTransfersRequest copyWith(void Function(ListTransfersRequest) updates) => super.copyWith((message) => updates(message as ListTransfersRequest)) as ListTransfersRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ListTransfersRequest create() => ListTransfersRequest._();
  ListTransfersRequest createEmptyInstance() => create();
  static $pb.PbList<ListTransfersRequest> createRepeated() => $pb.PbList<ListTransfersRequest>();
  @$core.pragma('dart2js:noInline')
  static ListTransfersRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListTransfersRequest>(create);
  static ListTransfersRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get page => $_getIZ(0);
  @$pb.TagNumber(1)
  set page($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearPage() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get pageSize => $_getIZ(1);
  @$pb.TagNumber(2)
  set pageSize($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPageSize() => $_has(1);
  @$pb.TagNumber(2)
  void clearPageSize() => clearField(2);

  @$pb.TagNumber(3)
  RmbStatus get status => $_getN(2);
  @$pb.TagNumber(3)
  set status(RmbStatus v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatus() => clearField(3);
}

class ListTransfersResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ListTransfersResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'rmb'), createEmptyInstance: create)
    ..pc<Transfer>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transfers', $pb.PbFieldType.PM, subBuilder: Transfer.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'total', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  ListTransfersResponse._() : super();
  factory ListTransfersResponse({
    $core.Iterable<Transfer>? transfers,
    $core.int? total,
    $core.int? page,
    $core.int? pageSize,
  }) {
    final _result = create();
    if (transfers != null) {
      _result.transfers.addAll(transfers);
    }
    if (total != null) {
      _result.total = total;
    }
    if (page != null) {
      _result.page = page;
    }
    if (pageSize != null) {
      _result.pageSize = pageSize;
    }
    return _result;
  }
  factory ListTransfersResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListTransfersResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListTransfersResponse clone() => ListTransfersResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListTransfersResponse copyWith(void Function(ListTransfersResponse) updates) => super.copyWith((message) => updates(message as ListTransfersResponse)) as ListTransfersResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ListTransfersResponse create() => ListTransfersResponse._();
  ListTransfersResponse createEmptyInstance() => create();
  static $pb.PbList<ListTransfersResponse> createRepeated() => $pb.PbList<ListTransfersResponse>();
  @$core.pragma('dart2js:noInline')
  static ListTransfersResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListTransfersResponse>(create);
  static ListTransfersResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Transfer> get transfers => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get page => $_getIZ(2);
  @$pb.TagNumber(3)
  set page($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPage() => $_has(2);
  @$pb.TagNumber(3)
  void clearPage() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get pageSize => $_getIZ(3);
  @$pb.TagNumber(4)
  set pageSize($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPageSize() => $_has(3);
  @$pb.TagNumber(4)
  void clearPageSize() => clearField(4);
}

