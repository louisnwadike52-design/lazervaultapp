// This is a generated file - do not edit.
//
// Generated from rmb.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $1;
import 'rmb.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'rmb.pbenum.dart';

class GetProviderConfigRequest extends $pb.GeneratedMessage {
  factory GetProviderConfigRequest() => create();

  GetProviderConfigRequest._();

  factory GetProviderConfigRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetProviderConfigRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetProviderConfigRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rmb'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetProviderConfigRequest clone() =>
      GetProviderConfigRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetProviderConfigRequest copyWith(
          void Function(GetProviderConfigRequest) updates) =>
      super.copyWith((message) => updates(message as GetProviderConfigRequest))
          as GetProviderConfigRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetProviderConfigRequest create() => GetProviderConfigRequest._();
  @$core.override
  GetProviderConfigRequest createEmptyInstance() => create();
  static $pb.PbList<GetProviderConfigRequest> createRepeated() =>
      $pb.PbList<GetProviderConfigRequest>();
  @$core.pragma('dart2js:noInline')
  static GetProviderConfigRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetProviderConfigRequest>(create);
  static GetProviderConfigRequest? _defaultInstance;
}

class RailStatus extends $pb.GeneratedMessage {
  factory RailStatus({
    RmbRail? rail,
    $core.bool? enabled,
    $fixnum.Int64? minAmountMinor,
    $fixnum.Int64? maxAmountMinor,
  }) {
    final result = create();
    if (rail != null) result.rail = rail;
    if (enabled != null) result.enabled = enabled;
    if (minAmountMinor != null) result.minAmountMinor = minAmountMinor;
    if (maxAmountMinor != null) result.maxAmountMinor = maxAmountMinor;
    return result;
  }

  RailStatus._();

  factory RailStatus.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RailStatus.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RailStatus',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rmb'),
      createEmptyInstance: create)
    ..e<RmbRail>(1, _omitFieldNames ? '' : 'rail', $pb.PbFieldType.OE,
        defaultOrMaker: RmbRail.RAIL_UNSPECIFIED,
        valueOf: RmbRail.valueOf,
        enumValues: RmbRail.values)
    ..aOB(2, _omitFieldNames ? '' : 'enabled')
    ..aInt64(3, _omitFieldNames ? '' : 'minAmountMinor')
    ..aInt64(4, _omitFieldNames ? '' : 'maxAmountMinor')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RailStatus clone() => RailStatus()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RailStatus copyWith(void Function(RailStatus) updates) =>
      super.copyWith((message) => updates(message as RailStatus)) as RailStatus;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RailStatus create() => RailStatus._();
  @$core.override
  RailStatus createEmptyInstance() => create();
  static $pb.PbList<RailStatus> createRepeated() => $pb.PbList<RailStatus>();
  @$core.pragma('dart2js:noInline')
  static RailStatus getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RailStatus>(create);
  static RailStatus? _defaultInstance;

  @$pb.TagNumber(1)
  RmbRail get rail => $_getN(0);
  @$pb.TagNumber(1)
  set rail(RmbRail value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRail() => $_has(0);
  @$pb.TagNumber(1)
  void clearRail() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get enabled => $_getBF(1);
  @$pb.TagNumber(2)
  set enabled($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasEnabled() => $_has(1);
  @$pb.TagNumber(2)
  void clearEnabled() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get minAmountMinor => $_getI64(2);
  @$pb.TagNumber(3)
  set minAmountMinor($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMinAmountMinor() => $_has(2);
  @$pb.TagNumber(3)
  void clearMinAmountMinor() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get maxAmountMinor => $_getI64(3);
  @$pb.TagNumber(4)
  set maxAmountMinor($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMaxAmountMinor() => $_has(3);
  @$pb.TagNumber(4)
  void clearMaxAmountMinor() => $_clearField(4);
}

/// One row of the amount-based pricing ladder (admin-configured via the
/// rmb.fee.tiers setting). Bigger sends fall in a higher band with a smaller
/// spread, so the effective NGN/CNY rate is better. Drives the rate-tiers chart.
class RateTier extends $pb.GeneratedMessage {
  factory RateTier({
    $fixnum.Int64? minCnyMinor,
    $core.double? marginPercent,
    $core.double? ngnPerCny,
  }) {
    final result = create();
    if (minCnyMinor != null) result.minCnyMinor = minCnyMinor;
    if (marginPercent != null) result.marginPercent = marginPercent;
    if (ngnPerCny != null) result.ngnPerCny = ngnPerCny;
    return result;
  }

  RateTier._();

  factory RateTier.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RateTier.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RateTier',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rmb'),
      createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'minCnyMinor')
    ..a<$core.double>(
        2, _omitFieldNames ? '' : 'marginPercent', $pb.PbFieldType.OD)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'ngnPerCny', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RateTier clone() => RateTier()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RateTier copyWith(void Function(RateTier) updates) =>
      super.copyWith((message) => updates(message as RateTier)) as RateTier;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RateTier create() => RateTier._();
  @$core.override
  RateTier createEmptyInstance() => create();
  static $pb.PbList<RateTier> createRepeated() => $pb.PbList<RateTier>();
  @$core.pragma('dart2js:noInline')
  static RateTier getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RateTier>(create);
  static RateTier? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get minCnyMinor => $_getI64(0);
  @$pb.TagNumber(1)
  set minCnyMinor($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMinCnyMinor() => $_has(0);
  @$pb.TagNumber(1)
  void clearMinCnyMinor() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get marginPercent => $_getN(1);
  @$pb.TagNumber(2)
  set marginPercent($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMarginPercent() => $_has(1);
  @$pb.TagNumber(2)
  void clearMarginPercent() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get ngnPerCny => $_getN(2);
  @$pb.TagNumber(3)
  set ngnPerCny($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasNgnPerCny() => $_has(2);
  @$pb.TagNumber(3)
  void clearNgnPerCny() => $_clearField(3);
}

class ProviderConfigResponse extends $pb.GeneratedMessage {
  factory ProviderConfigResponse({
    $core.String? provider,
    $core.Iterable<RailStatus>? rails,
    $core.bool? maintenance,
    $core.String? maintenanceMessage,
    $core.double? indicativeFxRate,
    $core.Iterable<RateTier>? rateTiers,
  }) {
    final result = create();
    if (provider != null) result.provider = provider;
    if (rails != null) result.rails.addAll(rails);
    if (maintenance != null) result.maintenance = maintenance;
    if (maintenanceMessage != null)
      result.maintenanceMessage = maintenanceMessage;
    if (indicativeFxRate != null) result.indicativeFxRate = indicativeFxRate;
    if (rateTiers != null) result.rateTiers.addAll(rateTiers);
    return result;
  }

  ProviderConfigResponse._();

  factory ProviderConfigResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ProviderConfigResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ProviderConfigResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rmb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'provider')
    ..pc<RailStatus>(2, _omitFieldNames ? '' : 'rails', $pb.PbFieldType.PM,
        subBuilder: RailStatus.create)
    ..aOB(3, _omitFieldNames ? '' : 'maintenance')
    ..aOS(4, _omitFieldNames ? '' : 'maintenanceMessage')
    ..a<$core.double>(
        5, _omitFieldNames ? '' : 'indicativeFxRate', $pb.PbFieldType.OD)
    ..pc<RateTier>(6, _omitFieldNames ? '' : 'rateTiers', $pb.PbFieldType.PM,
        subBuilder: RateTier.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProviderConfigResponse clone() =>
      ProviderConfigResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProviderConfigResponse copyWith(
          void Function(ProviderConfigResponse) updates) =>
      super.copyWith((message) => updates(message as ProviderConfigResponse))
          as ProviderConfigResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProviderConfigResponse create() => ProviderConfigResponse._();
  @$core.override
  ProviderConfigResponse createEmptyInstance() => create();
  static $pb.PbList<ProviderConfigResponse> createRepeated() =>
      $pb.PbList<ProviderConfigResponse>();
  @$core.pragma('dart2js:noInline')
  static ProviderConfigResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ProviderConfigResponse>(create);
  static ProviderConfigResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get provider => $_getSZ(0);
  @$pb.TagNumber(1)
  set provider($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasProvider() => $_has(0);
  @$pb.TagNumber(1)
  void clearProvider() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<RailStatus> get rails => $_getList(1);

  @$pb.TagNumber(3)
  $core.bool get maintenance => $_getBF(2);
  @$pb.TagNumber(3)
  set maintenance($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMaintenance() => $_has(2);
  @$pb.TagNumber(3)
  void clearMaintenance() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get maintenanceMessage => $_getSZ(3);
  @$pb.TagNumber(4)
  set maintenanceMessage($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMaintenanceMessage() => $_has(3);
  @$pb.TagNumber(4)
  void clearMaintenanceMessage() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get indicativeFxRate => $_getN(4);
  @$pb.TagNumber(5)
  set indicativeFxRate($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasIndicativeFxRate() => $_has(4);
  @$pb.TagNumber(5)
  void clearIndicativeFxRate() => $_clearField(5);

  @$pb.TagNumber(6)
  $pb.PbList<RateTier> get rateTiers => $_getList(5);
}

class ResolveBanksRequest extends $pb.GeneratedMessage {
  factory ResolveBanksRequest({
    RmbRail? rail,
  }) {
    final result = create();
    if (rail != null) result.rail = rail;
    return result;
  }

  ResolveBanksRequest._();

  factory ResolveBanksRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ResolveBanksRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ResolveBanksRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rmb'),
      createEmptyInstance: create)
    ..e<RmbRail>(1, _omitFieldNames ? '' : 'rail', $pb.PbFieldType.OE,
        defaultOrMaker: RmbRail.RAIL_UNSPECIFIED,
        valueOf: RmbRail.valueOf,
        enumValues: RmbRail.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ResolveBanksRequest clone() => ResolveBanksRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ResolveBanksRequest copyWith(void Function(ResolveBanksRequest) updates) =>
      super.copyWith((message) => updates(message as ResolveBanksRequest))
          as ResolveBanksRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ResolveBanksRequest create() => ResolveBanksRequest._();
  @$core.override
  ResolveBanksRequest createEmptyInstance() => create();
  static $pb.PbList<ResolveBanksRequest> createRepeated() =>
      $pb.PbList<ResolveBanksRequest>();
  @$core.pragma('dart2js:noInline')
  static ResolveBanksRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ResolveBanksRequest>(create);
  static ResolveBanksRequest? _defaultInstance;

  @$pb.TagNumber(1)
  RmbRail get rail => $_getN(0);
  @$pb.TagNumber(1)
  set rail(RmbRail value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRail() => $_has(0);
  @$pb.TagNumber(1)
  void clearRail() => $_clearField(1);
}

class Bank extends $pb.GeneratedMessage {
  factory Bank({
    $core.String? code,
    $core.String? name,
  }) {
    final result = create();
    if (code != null) result.code = code;
    if (name != null) result.name = name;
    return result;
  }

  Bank._();

  factory Bank.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Bank.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Bank',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rmb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'code')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Bank clone() => Bank()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Bank copyWith(void Function(Bank) updates) =>
      super.copyWith((message) => updates(message as Bank)) as Bank;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Bank create() => Bank._();
  @$core.override
  Bank createEmptyInstance() => create();
  static $pb.PbList<Bank> createRepeated() => $pb.PbList<Bank>();
  @$core.pragma('dart2js:noInline')
  static Bank getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Bank>(create);
  static Bank? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get code => $_getSZ(0);
  @$pb.TagNumber(1)
  set code($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearCode() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);
}

class ResolveBanksResponse extends $pb.GeneratedMessage {
  factory ResolveBanksResponse({
    $core.Iterable<Bank>? banks,
  }) {
    final result = create();
    if (banks != null) result.banks.addAll(banks);
    return result;
  }

  ResolveBanksResponse._();

  factory ResolveBanksResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ResolveBanksResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ResolveBanksResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rmb'),
      createEmptyInstance: create)
    ..pc<Bank>(1, _omitFieldNames ? '' : 'banks', $pb.PbFieldType.PM,
        subBuilder: Bank.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ResolveBanksResponse clone() =>
      ResolveBanksResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ResolveBanksResponse copyWith(void Function(ResolveBanksResponse) updates) =>
      super.copyWith((message) => updates(message as ResolveBanksResponse))
          as ResolveBanksResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ResolveBanksResponse create() => ResolveBanksResponse._();
  @$core.override
  ResolveBanksResponse createEmptyInstance() => create();
  static $pb.PbList<ResolveBanksResponse> createRepeated() =>
      $pb.PbList<ResolveBanksResponse>();
  @$core.pragma('dart2js:noInline')
  static ResolveBanksResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ResolveBanksResponse>(create);
  static ResolveBanksResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Bank> get banks => $_getList(0);
}

class GetQuoteRequest extends $pb.GeneratedMessage {
  factory GetQuoteRequest({
    RmbRail? rail,
    $fixnum.Int64? cnyAmountMinor,
  }) {
    final result = create();
    if (rail != null) result.rail = rail;
    if (cnyAmountMinor != null) result.cnyAmountMinor = cnyAmountMinor;
    return result;
  }

  GetQuoteRequest._();

  factory GetQuoteRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetQuoteRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetQuoteRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rmb'),
      createEmptyInstance: create)
    ..e<RmbRail>(1, _omitFieldNames ? '' : 'rail', $pb.PbFieldType.OE,
        defaultOrMaker: RmbRail.RAIL_UNSPECIFIED,
        valueOf: RmbRail.valueOf,
        enumValues: RmbRail.values)
    ..aInt64(2, _omitFieldNames ? '' : 'cnyAmountMinor')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetQuoteRequest clone() => GetQuoteRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetQuoteRequest copyWith(void Function(GetQuoteRequest) updates) =>
      super.copyWith((message) => updates(message as GetQuoteRequest))
          as GetQuoteRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetQuoteRequest create() => GetQuoteRequest._();
  @$core.override
  GetQuoteRequest createEmptyInstance() => create();
  static $pb.PbList<GetQuoteRequest> createRepeated() =>
      $pb.PbList<GetQuoteRequest>();
  @$core.pragma('dart2js:noInline')
  static GetQuoteRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetQuoteRequest>(create);
  static GetQuoteRequest? _defaultInstance;

  @$pb.TagNumber(1)
  RmbRail get rail => $_getN(0);
  @$pb.TagNumber(1)
  set rail(RmbRail value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRail() => $_has(0);
  @$pb.TagNumber(1)
  void clearRail() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get cnyAmountMinor => $_getI64(1);
  @$pb.TagNumber(2)
  set cnyAmountMinor($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCnyAmountMinor() => $_has(1);
  @$pb.TagNumber(2)
  void clearCnyAmountMinor() => $_clearField(2);
}

class QuoteResponse extends $pb.GeneratedMessage {
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
    final result = create();
    if (quoteId != null) result.quoteId = quoteId;
    if (provider != null) result.provider = provider;
    if (rail != null) result.rail = rail;
    if (fxRate != null) result.fxRate = fxRate;
    if (destAmountMinor != null) result.destAmountMinor = destAmountMinor;
    if (sourceAmountMinor != null) result.sourceAmountMinor = sourceAmountMinor;
    if (providerFeeMinor != null) result.providerFeeMinor = providerFeeMinor;
    if (ourFeeMinor != null) result.ourFeeMinor = ourFeeMinor;
    if (totalMinor != null) result.totalMinor = totalMinor;
    if (expiresAt != null) result.expiresAt = expiresAt;
    return result;
  }

  QuoteResponse._();

  factory QuoteResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory QuoteResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'QuoteResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rmb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'quoteId')
    ..aOS(2, _omitFieldNames ? '' : 'provider')
    ..e<RmbRail>(3, _omitFieldNames ? '' : 'rail', $pb.PbFieldType.OE,
        defaultOrMaker: RmbRail.RAIL_UNSPECIFIED,
        valueOf: RmbRail.valueOf,
        enumValues: RmbRail.values)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'fxRate', $pb.PbFieldType.OD)
    ..aInt64(5, _omitFieldNames ? '' : 'destAmountMinor')
    ..aInt64(6, _omitFieldNames ? '' : 'sourceAmountMinor')
    ..aInt64(7, _omitFieldNames ? '' : 'providerFeeMinor')
    ..aInt64(8, _omitFieldNames ? '' : 'ourFeeMinor')
    ..aInt64(9, _omitFieldNames ? '' : 'totalMinor')
    ..aOM<$1.Timestamp>(10, _omitFieldNames ? '' : 'expiresAt',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  QuoteResponse clone() => QuoteResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  QuoteResponse copyWith(void Function(QuoteResponse) updates) =>
      super.copyWith((message) => updates(message as QuoteResponse))
          as QuoteResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static QuoteResponse create() => QuoteResponse._();
  @$core.override
  QuoteResponse createEmptyInstance() => create();
  static $pb.PbList<QuoteResponse> createRepeated() =>
      $pb.PbList<QuoteResponse>();
  @$core.pragma('dart2js:noInline')
  static QuoteResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<QuoteResponse>(create);
  static QuoteResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get quoteId => $_getSZ(0);
  @$pb.TagNumber(1)
  set quoteId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasQuoteId() => $_has(0);
  @$pb.TagNumber(1)
  void clearQuoteId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get provider => $_getSZ(1);
  @$pb.TagNumber(2)
  set provider($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasProvider() => $_has(1);
  @$pb.TagNumber(2)
  void clearProvider() => $_clearField(2);

  @$pb.TagNumber(3)
  RmbRail get rail => $_getN(2);
  @$pb.TagNumber(3)
  set rail(RmbRail value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasRail() => $_has(2);
  @$pb.TagNumber(3)
  void clearRail() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get fxRate => $_getN(3);
  @$pb.TagNumber(4)
  set fxRate($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasFxRate() => $_has(3);
  @$pb.TagNumber(4)
  void clearFxRate() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get destAmountMinor => $_getI64(4);
  @$pb.TagNumber(5)
  set destAmountMinor($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasDestAmountMinor() => $_has(4);
  @$pb.TagNumber(5)
  void clearDestAmountMinor() => $_clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get sourceAmountMinor => $_getI64(5);
  @$pb.TagNumber(6)
  set sourceAmountMinor($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasSourceAmountMinor() => $_has(5);
  @$pb.TagNumber(6)
  void clearSourceAmountMinor() => $_clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get providerFeeMinor => $_getI64(6);
  @$pb.TagNumber(7)
  set providerFeeMinor($fixnum.Int64 value) => $_setInt64(6, value);
  @$pb.TagNumber(7)
  $core.bool hasProviderFeeMinor() => $_has(6);
  @$pb.TagNumber(7)
  void clearProviderFeeMinor() => $_clearField(7);

  @$pb.TagNumber(8)
  $fixnum.Int64 get ourFeeMinor => $_getI64(7);
  @$pb.TagNumber(8)
  set ourFeeMinor($fixnum.Int64 value) => $_setInt64(7, value);
  @$pb.TagNumber(8)
  $core.bool hasOurFeeMinor() => $_has(7);
  @$pb.TagNumber(8)
  void clearOurFeeMinor() => $_clearField(8);

  @$pb.TagNumber(9)
  $fixnum.Int64 get totalMinor => $_getI64(8);
  @$pb.TagNumber(9)
  set totalMinor($fixnum.Int64 value) => $_setInt64(8, value);
  @$pb.TagNumber(9)
  $core.bool hasTotalMinor() => $_has(8);
  @$pb.TagNumber(9)
  void clearTotalMinor() => $_clearField(9);

  @$pb.TagNumber(10)
  $1.Timestamp get expiresAt => $_getN(9);
  @$pb.TagNumber(10)
  set expiresAt($1.Timestamp value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasExpiresAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearExpiresAt() => $_clearField(10);
  @$pb.TagNumber(10)
  $1.Timestamp ensureExpiresAt() => $_ensure(9);
}

class Beneficiary extends $pb.GeneratedMessage {
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
    final result = create();
    if (id != null) result.id = id;
    if (rail != null) result.rail = rail;
    if (displayName != null) result.displayName = displayName;
    if (favourite != null) result.favourite = favourite;
    if (accountId != null) result.accountId = accountId;
    if (accountIdType != null) result.accountIdType = accountIdType;
    if (accountNumber != null) result.accountNumber = accountNumber;
    if (receiverFirstName != null) result.receiverFirstName = receiverFirstName;
    if (receiverLastName != null) result.receiverLastName = receiverLastName;
    if (receiverIdNumber != null) result.receiverIdNumber = receiverIdNumber;
    if (receiverIdType != null) result.receiverIdType = receiverIdType;
    if (receiverMobile != null) result.receiverMobile = receiverMobile;
    if (receiverRelationship != null)
      result.receiverRelationship = receiverRelationship;
    if (cardNumber != null) result.cardNumber = cardNumber;
    if (cardHolderName != null) result.cardHolderName = cardHolderName;
    if (accountName != null) result.accountName = accountName;
    if (accountType != null) result.accountType = accountType;
    if (bankCode != null) result.bankCode = bankCode;
    if (bankName != null) result.bankName = bankName;
    if (lastUsedAt != null) result.lastUsedAt = lastUsedAt;
    return result;
  }

  Beneficiary._();

  factory Beneficiary.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Beneficiary.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Beneficiary',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rmb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..e<RmbRail>(2, _omitFieldNames ? '' : 'rail', $pb.PbFieldType.OE,
        defaultOrMaker: RmbRail.RAIL_UNSPECIFIED,
        valueOf: RmbRail.valueOf,
        enumValues: RmbRail.values)
    ..aOS(3, _omitFieldNames ? '' : 'displayName')
    ..aOB(4, _omitFieldNames ? '' : 'favourite')
    ..aOS(10, _omitFieldNames ? '' : 'accountId')
    ..aOS(11, _omitFieldNames ? '' : 'accountIdType')
    ..aOS(12, _omitFieldNames ? '' : 'accountNumber')
    ..aOS(20, _omitFieldNames ? '' : 'receiverFirstName')
    ..aOS(21, _omitFieldNames ? '' : 'receiverLastName')
    ..aOS(22, _omitFieldNames ? '' : 'receiverIdNumber')
    ..aOS(23, _omitFieldNames ? '' : 'receiverIdType')
    ..aOS(24, _omitFieldNames ? '' : 'receiverMobile')
    ..aOS(25, _omitFieldNames ? '' : 'receiverRelationship')
    ..aOS(30, _omitFieldNames ? '' : 'cardNumber')
    ..aOS(31, _omitFieldNames ? '' : 'cardHolderName')
    ..aOS(40, _omitFieldNames ? '' : 'accountName')
    ..aOS(41, _omitFieldNames ? '' : 'accountType')
    ..aOS(42, _omitFieldNames ? '' : 'bankCode')
    ..aOS(43, _omitFieldNames ? '' : 'bankName')
    ..aOM<$1.Timestamp>(50, _omitFieldNames ? '' : 'lastUsedAt',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Beneficiary clone() => Beneficiary()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Beneficiary copyWith(void Function(Beneficiary) updates) =>
      super.copyWith((message) => updates(message as Beneficiary))
          as Beneficiary;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Beneficiary create() => Beneficiary._();
  @$core.override
  Beneficiary createEmptyInstance() => create();
  static $pb.PbList<Beneficiary> createRepeated() => $pb.PbList<Beneficiary>();
  @$core.pragma('dart2js:noInline')
  static Beneficiary getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Beneficiary>(create);
  static Beneficiary? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  RmbRail get rail => $_getN(1);
  @$pb.TagNumber(2)
  set rail(RmbRail value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasRail() => $_has(1);
  @$pb.TagNumber(2)
  void clearRail() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get displayName => $_getSZ(2);
  @$pb.TagNumber(3)
  set displayName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDisplayName() => $_has(2);
  @$pb.TagNumber(3)
  void clearDisplayName() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.bool get favourite => $_getBF(3);
  @$pb.TagNumber(4)
  set favourite($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasFavourite() => $_has(3);
  @$pb.TagNumber(4)
  void clearFavourite() => $_clearField(4);

  /// Wallet (Alipay/WeChat)
  @$pb.TagNumber(10)
  $core.String get accountId => $_getSZ(4);
  @$pb.TagNumber(10)
  set accountId($core.String value) => $_setString(4, value);
  @$pb.TagNumber(10)
  $core.bool hasAccountId() => $_has(4);
  @$pb.TagNumber(10)
  void clearAccountId() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get accountIdType => $_getSZ(5);
  @$pb.TagNumber(11)
  set accountIdType($core.String value) => $_setString(5, value);
  @$pb.TagNumber(11)
  $core.bool hasAccountIdType() => $_has(5);
  @$pb.TagNumber(11)
  void clearAccountIdType() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get accountNumber => $_getSZ(6);
  @$pb.TagNumber(12)
  set accountNumber($core.String value) => $_setString(6, value);
  @$pb.TagNumber(12)
  $core.bool hasAccountNumber() => $_has(6);
  @$pb.TagNumber(12)
  void clearAccountNumber() => $_clearField(12);

  /// Receiver identity (all rails)
  @$pb.TagNumber(20)
  $core.String get receiverFirstName => $_getSZ(7);
  @$pb.TagNumber(20)
  set receiverFirstName($core.String value) => $_setString(7, value);
  @$pb.TagNumber(20)
  $core.bool hasReceiverFirstName() => $_has(7);
  @$pb.TagNumber(20)
  void clearReceiverFirstName() => $_clearField(20);

  @$pb.TagNumber(21)
  $core.String get receiverLastName => $_getSZ(8);
  @$pb.TagNumber(21)
  set receiverLastName($core.String value) => $_setString(8, value);
  @$pb.TagNumber(21)
  $core.bool hasReceiverLastName() => $_has(8);
  @$pb.TagNumber(21)
  void clearReceiverLastName() => $_clearField(21);

  @$pb.TagNumber(22)
  $core.String get receiverIdNumber => $_getSZ(9);
  @$pb.TagNumber(22)
  set receiverIdNumber($core.String value) => $_setString(9, value);
  @$pb.TagNumber(22)
  $core.bool hasReceiverIdNumber() => $_has(9);
  @$pb.TagNumber(22)
  void clearReceiverIdNumber() => $_clearField(22);

  @$pb.TagNumber(23)
  $core.String get receiverIdType => $_getSZ(10);
  @$pb.TagNumber(23)
  set receiverIdType($core.String value) => $_setString(10, value);
  @$pb.TagNumber(23)
  $core.bool hasReceiverIdType() => $_has(10);
  @$pb.TagNumber(23)
  void clearReceiverIdType() => $_clearField(23);

  @$pb.TagNumber(24)
  $core.String get receiverMobile => $_getSZ(11);
  @$pb.TagNumber(24)
  set receiverMobile($core.String value) => $_setString(11, value);
  @$pb.TagNumber(24)
  $core.bool hasReceiverMobile() => $_has(11);
  @$pb.TagNumber(24)
  void clearReceiverMobile() => $_clearField(24);

  @$pb.TagNumber(25)
  $core.String get receiverRelationship => $_getSZ(12);
  @$pb.TagNumber(25)
  set receiverRelationship($core.String value) => $_setString(12, value);
  @$pb.TagNumber(25)
  $core.bool hasReceiverRelationship() => $_has(12);
  @$pb.TagNumber(25)
  void clearReceiverRelationship() => $_clearField(25);

  /// Card (UnionPay)
  @$pb.TagNumber(30)
  $core.String get cardNumber => $_getSZ(13);
  @$pb.TagNumber(30)
  set cardNumber($core.String value) => $_setString(13, value);
  @$pb.TagNumber(30)
  $core.bool hasCardNumber() => $_has(13);
  @$pb.TagNumber(30)
  void clearCardNumber() => $_clearField(30);

  @$pb.TagNumber(31)
  $core.String get cardHolderName => $_getSZ(14);
  @$pb.TagNumber(31)
  set cardHolderName($core.String value) => $_setString(14, value);
  @$pb.TagNumber(31)
  $core.bool hasCardHolderName() => $_has(14);
  @$pb.TagNumber(31)
  void clearCardHolderName() => $_clearField(31);

  /// Bank account
  @$pb.TagNumber(40)
  $core.String get accountName => $_getSZ(15);
  @$pb.TagNumber(40)
  set accountName($core.String value) => $_setString(15, value);
  @$pb.TagNumber(40)
  $core.bool hasAccountName() => $_has(15);
  @$pb.TagNumber(40)
  void clearAccountName() => $_clearField(40);

  @$pb.TagNumber(41)
  $core.String get accountType => $_getSZ(16);
  @$pb.TagNumber(41)
  set accountType($core.String value) => $_setString(16, value);
  @$pb.TagNumber(41)
  $core.bool hasAccountType() => $_has(16);
  @$pb.TagNumber(41)
  void clearAccountType() => $_clearField(41);

  @$pb.TagNumber(42)
  $core.String get bankCode => $_getSZ(17);
  @$pb.TagNumber(42)
  set bankCode($core.String value) => $_setString(17, value);
  @$pb.TagNumber(42)
  $core.bool hasBankCode() => $_has(17);
  @$pb.TagNumber(42)
  void clearBankCode() => $_clearField(42);

  @$pb.TagNumber(43)
  $core.String get bankName => $_getSZ(18);
  @$pb.TagNumber(43)
  set bankName($core.String value) => $_setString(18, value);
  @$pb.TagNumber(43)
  $core.bool hasBankName() => $_has(18);
  @$pb.TagNumber(43)
  void clearBankName() => $_clearField(43);

  @$pb.TagNumber(50)
  $1.Timestamp get lastUsedAt => $_getN(19);
  @$pb.TagNumber(50)
  set lastUsedAt($1.Timestamp value) => $_setField(50, value);
  @$pb.TagNumber(50)
  $core.bool hasLastUsedAt() => $_has(19);
  @$pb.TagNumber(50)
  void clearLastUsedAt() => $_clearField(50);
  @$pb.TagNumber(50)
  $1.Timestamp ensureLastUsedAt() => $_ensure(19);
}

class ListBeneficiariesRequest extends $pb.GeneratedMessage {
  factory ListBeneficiariesRequest({
    RmbRail? rail,
  }) {
    final result = create();
    if (rail != null) result.rail = rail;
    return result;
  }

  ListBeneficiariesRequest._();

  factory ListBeneficiariesRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListBeneficiariesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListBeneficiariesRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rmb'),
      createEmptyInstance: create)
    ..e<RmbRail>(1, _omitFieldNames ? '' : 'rail', $pb.PbFieldType.OE,
        defaultOrMaker: RmbRail.RAIL_UNSPECIFIED,
        valueOf: RmbRail.valueOf,
        enumValues: RmbRail.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListBeneficiariesRequest clone() =>
      ListBeneficiariesRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListBeneficiariesRequest copyWith(
          void Function(ListBeneficiariesRequest) updates) =>
      super.copyWith((message) => updates(message as ListBeneficiariesRequest))
          as ListBeneficiariesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListBeneficiariesRequest create() => ListBeneficiariesRequest._();
  @$core.override
  ListBeneficiariesRequest createEmptyInstance() => create();
  static $pb.PbList<ListBeneficiariesRequest> createRepeated() =>
      $pb.PbList<ListBeneficiariesRequest>();
  @$core.pragma('dart2js:noInline')
  static ListBeneficiariesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListBeneficiariesRequest>(create);
  static ListBeneficiariesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  RmbRail get rail => $_getN(0);
  @$pb.TagNumber(1)
  set rail(RmbRail value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRail() => $_has(0);
  @$pb.TagNumber(1)
  void clearRail() => $_clearField(1);
}

class ListBeneficiariesResponse extends $pb.GeneratedMessage {
  factory ListBeneficiariesResponse({
    $core.Iterable<Beneficiary>? beneficiaries,
  }) {
    final result = create();
    if (beneficiaries != null) result.beneficiaries.addAll(beneficiaries);
    return result;
  }

  ListBeneficiariesResponse._();

  factory ListBeneficiariesResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListBeneficiariesResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListBeneficiariesResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rmb'),
      createEmptyInstance: create)
    ..pc<Beneficiary>(
        1, _omitFieldNames ? '' : 'beneficiaries', $pb.PbFieldType.PM,
        subBuilder: Beneficiary.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListBeneficiariesResponse clone() =>
      ListBeneficiariesResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListBeneficiariesResponse copyWith(
          void Function(ListBeneficiariesResponse) updates) =>
      super.copyWith((message) => updates(message as ListBeneficiariesResponse))
          as ListBeneficiariesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListBeneficiariesResponse create() => ListBeneficiariesResponse._();
  @$core.override
  ListBeneficiariesResponse createEmptyInstance() => create();
  static $pb.PbList<ListBeneficiariesResponse> createRepeated() =>
      $pb.PbList<ListBeneficiariesResponse>();
  @$core.pragma('dart2js:noInline')
  static ListBeneficiariesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListBeneficiariesResponse>(create);
  static ListBeneficiariesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Beneficiary> get beneficiaries => $_getList(0);
}

class SaveBeneficiaryRequest extends $pb.GeneratedMessage {
  factory SaveBeneficiaryRequest({
    Beneficiary? beneficiary,
  }) {
    final result = create();
    if (beneficiary != null) result.beneficiary = beneficiary;
    return result;
  }

  SaveBeneficiaryRequest._();

  factory SaveBeneficiaryRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SaveBeneficiaryRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SaveBeneficiaryRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rmb'),
      createEmptyInstance: create)
    ..aOM<Beneficiary>(1, _omitFieldNames ? '' : 'beneficiary',
        subBuilder: Beneficiary.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SaveBeneficiaryRequest clone() =>
      SaveBeneficiaryRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SaveBeneficiaryRequest copyWith(
          void Function(SaveBeneficiaryRequest) updates) =>
      super.copyWith((message) => updates(message as SaveBeneficiaryRequest))
          as SaveBeneficiaryRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SaveBeneficiaryRequest create() => SaveBeneficiaryRequest._();
  @$core.override
  SaveBeneficiaryRequest createEmptyInstance() => create();
  static $pb.PbList<SaveBeneficiaryRequest> createRepeated() =>
      $pb.PbList<SaveBeneficiaryRequest>();
  @$core.pragma('dart2js:noInline')
  static SaveBeneficiaryRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SaveBeneficiaryRequest>(create);
  static SaveBeneficiaryRequest? _defaultInstance;

  @$pb.TagNumber(1)
  Beneficiary get beneficiary => $_getN(0);
  @$pb.TagNumber(1)
  set beneficiary(Beneficiary value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasBeneficiary() => $_has(0);
  @$pb.TagNumber(1)
  void clearBeneficiary() => $_clearField(1);
  @$pb.TagNumber(1)
  Beneficiary ensureBeneficiary() => $_ensure(0);
}

class SaveBeneficiaryResponse extends $pb.GeneratedMessage {
  factory SaveBeneficiaryResponse({
    Beneficiary? beneficiary,
  }) {
    final result = create();
    if (beneficiary != null) result.beneficiary = beneficiary;
    return result;
  }

  SaveBeneficiaryResponse._();

  factory SaveBeneficiaryResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SaveBeneficiaryResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SaveBeneficiaryResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rmb'),
      createEmptyInstance: create)
    ..aOM<Beneficiary>(1, _omitFieldNames ? '' : 'beneficiary',
        subBuilder: Beneficiary.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SaveBeneficiaryResponse clone() =>
      SaveBeneficiaryResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SaveBeneficiaryResponse copyWith(
          void Function(SaveBeneficiaryResponse) updates) =>
      super.copyWith((message) => updates(message as SaveBeneficiaryResponse))
          as SaveBeneficiaryResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SaveBeneficiaryResponse create() => SaveBeneficiaryResponse._();
  @$core.override
  SaveBeneficiaryResponse createEmptyInstance() => create();
  static $pb.PbList<SaveBeneficiaryResponse> createRepeated() =>
      $pb.PbList<SaveBeneficiaryResponse>();
  @$core.pragma('dart2js:noInline')
  static SaveBeneficiaryResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SaveBeneficiaryResponse>(create);
  static SaveBeneficiaryResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Beneficiary get beneficiary => $_getN(0);
  @$pb.TagNumber(1)
  set beneficiary(Beneficiary value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasBeneficiary() => $_has(0);
  @$pb.TagNumber(1)
  void clearBeneficiary() => $_clearField(1);
  @$pb.TagNumber(1)
  Beneficiary ensureBeneficiary() => $_ensure(0);
}

class UpdateBeneficiaryRequest extends $pb.GeneratedMessage {
  factory UpdateBeneficiaryRequest({
    Beneficiary? beneficiary,
  }) {
    final result = create();
    if (beneficiary != null) result.beneficiary = beneficiary;
    return result;
  }

  UpdateBeneficiaryRequest._();

  factory UpdateBeneficiaryRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateBeneficiaryRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateBeneficiaryRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rmb'),
      createEmptyInstance: create)
    ..aOM<Beneficiary>(1, _omitFieldNames ? '' : 'beneficiary',
        subBuilder: Beneficiary.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateBeneficiaryRequest clone() =>
      UpdateBeneficiaryRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateBeneficiaryRequest copyWith(
          void Function(UpdateBeneficiaryRequest) updates) =>
      super.copyWith((message) => updates(message as UpdateBeneficiaryRequest))
          as UpdateBeneficiaryRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateBeneficiaryRequest create() => UpdateBeneficiaryRequest._();
  @$core.override
  UpdateBeneficiaryRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateBeneficiaryRequest> createRepeated() =>
      $pb.PbList<UpdateBeneficiaryRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateBeneficiaryRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateBeneficiaryRequest>(create);
  static UpdateBeneficiaryRequest? _defaultInstance;

  @$pb.TagNumber(1)
  Beneficiary get beneficiary => $_getN(0);
  @$pb.TagNumber(1)
  set beneficiary(Beneficiary value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasBeneficiary() => $_has(0);
  @$pb.TagNumber(1)
  void clearBeneficiary() => $_clearField(1);
  @$pb.TagNumber(1)
  Beneficiary ensureBeneficiary() => $_ensure(0);
}

class UpdateBeneficiaryResponse extends $pb.GeneratedMessage {
  factory UpdateBeneficiaryResponse({
    Beneficiary? beneficiary,
  }) {
    final result = create();
    if (beneficiary != null) result.beneficiary = beneficiary;
    return result;
  }

  UpdateBeneficiaryResponse._();

  factory UpdateBeneficiaryResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateBeneficiaryResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateBeneficiaryResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rmb'),
      createEmptyInstance: create)
    ..aOM<Beneficiary>(1, _omitFieldNames ? '' : 'beneficiary',
        subBuilder: Beneficiary.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateBeneficiaryResponse clone() =>
      UpdateBeneficiaryResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateBeneficiaryResponse copyWith(
          void Function(UpdateBeneficiaryResponse) updates) =>
      super.copyWith((message) => updates(message as UpdateBeneficiaryResponse))
          as UpdateBeneficiaryResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateBeneficiaryResponse create() => UpdateBeneficiaryResponse._();
  @$core.override
  UpdateBeneficiaryResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateBeneficiaryResponse> createRepeated() =>
      $pb.PbList<UpdateBeneficiaryResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateBeneficiaryResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateBeneficiaryResponse>(create);
  static UpdateBeneficiaryResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Beneficiary get beneficiary => $_getN(0);
  @$pb.TagNumber(1)
  set beneficiary(Beneficiary value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasBeneficiary() => $_has(0);
  @$pb.TagNumber(1)
  void clearBeneficiary() => $_clearField(1);
  @$pb.TagNumber(1)
  Beneficiary ensureBeneficiary() => $_ensure(0);
}

class DeleteBeneficiaryRequest extends $pb.GeneratedMessage {
  factory DeleteBeneficiaryRequest({
    $core.String? id,
  }) {
    final result = create();
    if (id != null) result.id = id;
    return result;
  }

  DeleteBeneficiaryRequest._();

  factory DeleteBeneficiaryRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeleteBeneficiaryRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteBeneficiaryRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rmb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteBeneficiaryRequest clone() =>
      DeleteBeneficiaryRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteBeneficiaryRequest copyWith(
          void Function(DeleteBeneficiaryRequest) updates) =>
      super.copyWith((message) => updates(message as DeleteBeneficiaryRequest))
          as DeleteBeneficiaryRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteBeneficiaryRequest create() => DeleteBeneficiaryRequest._();
  @$core.override
  DeleteBeneficiaryRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteBeneficiaryRequest> createRepeated() =>
      $pb.PbList<DeleteBeneficiaryRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteBeneficiaryRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteBeneficiaryRequest>(create);
  static DeleteBeneficiaryRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);
}

class DeleteBeneficiaryResponse extends $pb.GeneratedMessage {
  factory DeleteBeneficiaryResponse({
    $core.bool? success,
  }) {
    final result = create();
    if (success != null) result.success = success;
    return result;
  }

  DeleteBeneficiaryResponse._();

  factory DeleteBeneficiaryResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeleteBeneficiaryResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteBeneficiaryResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rmb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteBeneficiaryResponse clone() =>
      DeleteBeneficiaryResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteBeneficiaryResponse copyWith(
          void Function(DeleteBeneficiaryResponse) updates) =>
      super.copyWith((message) => updates(message as DeleteBeneficiaryResponse))
          as DeleteBeneficiaryResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteBeneficiaryResponse create() => DeleteBeneficiaryResponse._();
  @$core.override
  DeleteBeneficiaryResponse createEmptyInstance() => create();
  static $pb.PbList<DeleteBeneficiaryResponse> createRepeated() =>
      $pb.PbList<DeleteBeneficiaryResponse>();
  @$core.pragma('dart2js:noInline')
  static DeleteBeneficiaryResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteBeneficiaryResponse>(create);
  static DeleteBeneficiaryResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);
}

class FavouriteBeneficiaryRequest extends $pb.GeneratedMessage {
  factory FavouriteBeneficiaryRequest({
    $core.String? id,
    $core.bool? favourite,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (favourite != null) result.favourite = favourite;
    return result;
  }

  FavouriteBeneficiaryRequest._();

  factory FavouriteBeneficiaryRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FavouriteBeneficiaryRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FavouriteBeneficiaryRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rmb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOB(2, _omitFieldNames ? '' : 'favourite')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FavouriteBeneficiaryRequest clone() =>
      FavouriteBeneficiaryRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FavouriteBeneficiaryRequest copyWith(
          void Function(FavouriteBeneficiaryRequest) updates) =>
      super.copyWith(
              (message) => updates(message as FavouriteBeneficiaryRequest))
          as FavouriteBeneficiaryRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FavouriteBeneficiaryRequest create() =>
      FavouriteBeneficiaryRequest._();
  @$core.override
  FavouriteBeneficiaryRequest createEmptyInstance() => create();
  static $pb.PbList<FavouriteBeneficiaryRequest> createRepeated() =>
      $pb.PbList<FavouriteBeneficiaryRequest>();
  @$core.pragma('dart2js:noInline')
  static FavouriteBeneficiaryRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FavouriteBeneficiaryRequest>(create);
  static FavouriteBeneficiaryRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get favourite => $_getBF(1);
  @$pb.TagNumber(2)
  set favourite($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasFavourite() => $_has(1);
  @$pb.TagNumber(2)
  void clearFavourite() => $_clearField(2);
}

class FavouriteBeneficiaryResponse extends $pb.GeneratedMessage {
  factory FavouriteBeneficiaryResponse({
    Beneficiary? beneficiary,
  }) {
    final result = create();
    if (beneficiary != null) result.beneficiary = beneficiary;
    return result;
  }

  FavouriteBeneficiaryResponse._();

  factory FavouriteBeneficiaryResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FavouriteBeneficiaryResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FavouriteBeneficiaryResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rmb'),
      createEmptyInstance: create)
    ..aOM<Beneficiary>(1, _omitFieldNames ? '' : 'beneficiary',
        subBuilder: Beneficiary.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FavouriteBeneficiaryResponse clone() =>
      FavouriteBeneficiaryResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FavouriteBeneficiaryResponse copyWith(
          void Function(FavouriteBeneficiaryResponse) updates) =>
      super.copyWith(
              (message) => updates(message as FavouriteBeneficiaryResponse))
          as FavouriteBeneficiaryResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FavouriteBeneficiaryResponse create() =>
      FavouriteBeneficiaryResponse._();
  @$core.override
  FavouriteBeneficiaryResponse createEmptyInstance() => create();
  static $pb.PbList<FavouriteBeneficiaryResponse> createRepeated() =>
      $pb.PbList<FavouriteBeneficiaryResponse>();
  @$core.pragma('dart2js:noInline')
  static FavouriteBeneficiaryResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FavouriteBeneficiaryResponse>(create);
  static FavouriteBeneficiaryResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Beneficiary get beneficiary => $_getN(0);
  @$pb.TagNumber(1)
  set beneficiary(Beneficiary value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasBeneficiary() => $_has(0);
  @$pb.TagNumber(1)
  void clearBeneficiary() => $_clearField(1);
  @$pb.TagNumber(1)
  Beneficiary ensureBeneficiary() => $_ensure(0);
}

class Address extends $pb.GeneratedMessage {
  factory Address({
    $core.String? city,
    $core.String? countryCode,
    $core.String? postcode,
    $core.String? state,
    $core.String? streetAddress,
  }) {
    final result = create();
    if (city != null) result.city = city;
    if (countryCode != null) result.countryCode = countryCode;
    if (postcode != null) result.postcode = postcode;
    if (state != null) result.state = state;
    if (streetAddress != null) result.streetAddress = streetAddress;
    return result;
  }

  Address._();

  factory Address.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Address.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Address',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rmb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'city')
    ..aOS(2, _omitFieldNames ? '' : 'countryCode')
    ..aOS(3, _omitFieldNames ? '' : 'postcode')
    ..aOS(4, _omitFieldNames ? '' : 'state')
    ..aOS(5, _omitFieldNames ? '' : 'streetAddress')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Address clone() => Address()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Address copyWith(void Function(Address) updates) =>
      super.copyWith((message) => updates(message as Address)) as Address;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Address create() => Address._();
  @$core.override
  Address createEmptyInstance() => create();
  static $pb.PbList<Address> createRepeated() => $pb.PbList<Address>();
  @$core.pragma('dart2js:noInline')
  static Address getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Address>(create);
  static Address? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get city => $_getSZ(0);
  @$pb.TagNumber(1)
  set city($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCity() => $_has(0);
  @$pb.TagNumber(1)
  void clearCity() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get countryCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set countryCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCountryCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearCountryCode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get postcode => $_getSZ(2);
  @$pb.TagNumber(3)
  set postcode($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPostcode() => $_has(2);
  @$pb.TagNumber(3)
  void clearPostcode() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get state => $_getSZ(3);
  @$pb.TagNumber(4)
  set state($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasState() => $_has(3);
  @$pb.TagNumber(4)
  void clearState() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get streetAddress => $_getSZ(4);
  @$pb.TagNumber(5)
  set streetAddress($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasStreetAddress() => $_has(4);
  @$pb.TagNumber(5)
  void clearStreetAddress() => $_clearField(5);
}

class ComplianceProfile extends $pb.GeneratedMessage {
  factory ComplianceProfile({
    $core.String? senderFirstName,
    $core.String? senderLastName,
    $core.String? senderIdNumber,
    $core.String? senderIdType,
    $core.String? senderNationality,
    $core.String? senderBirthDate,
    Address? senderAddress,
    $core.bool? complete,
    $core.Iterable<$core.String>? lockedFields,
  }) {
    final result = create();
    if (senderFirstName != null) result.senderFirstName = senderFirstName;
    if (senderLastName != null) result.senderLastName = senderLastName;
    if (senderIdNumber != null) result.senderIdNumber = senderIdNumber;
    if (senderIdType != null) result.senderIdType = senderIdType;
    if (senderNationality != null) result.senderNationality = senderNationality;
    if (senderBirthDate != null) result.senderBirthDate = senderBirthDate;
    if (senderAddress != null) result.senderAddress = senderAddress;
    if (complete != null) result.complete = complete;
    if (lockedFields != null) result.lockedFields.addAll(lockedFields);
    return result;
  }

  ComplianceProfile._();

  factory ComplianceProfile.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ComplianceProfile.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ComplianceProfile',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rmb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'senderFirstName')
    ..aOS(2, _omitFieldNames ? '' : 'senderLastName')
    ..aOS(3, _omitFieldNames ? '' : 'senderIdNumber')
    ..aOS(4, _omitFieldNames ? '' : 'senderIdType')
    ..aOS(5, _omitFieldNames ? '' : 'senderNationality')
    ..aOS(6, _omitFieldNames ? '' : 'senderBirthDate')
    ..aOM<Address>(7, _omitFieldNames ? '' : 'senderAddress',
        subBuilder: Address.create)
    ..aOB(8, _omitFieldNames ? '' : 'complete')
    ..pPS(9, _omitFieldNames ? '' : 'lockedFields')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ComplianceProfile clone() => ComplianceProfile()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ComplianceProfile copyWith(void Function(ComplianceProfile) updates) =>
      super.copyWith((message) => updates(message as ComplianceProfile))
          as ComplianceProfile;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ComplianceProfile create() => ComplianceProfile._();
  @$core.override
  ComplianceProfile createEmptyInstance() => create();
  static $pb.PbList<ComplianceProfile> createRepeated() =>
      $pb.PbList<ComplianceProfile>();
  @$core.pragma('dart2js:noInline')
  static ComplianceProfile getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ComplianceProfile>(create);
  static ComplianceProfile? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get senderFirstName => $_getSZ(0);
  @$pb.TagNumber(1)
  set senderFirstName($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSenderFirstName() => $_has(0);
  @$pb.TagNumber(1)
  void clearSenderFirstName() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get senderLastName => $_getSZ(1);
  @$pb.TagNumber(2)
  set senderLastName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSenderLastName() => $_has(1);
  @$pb.TagNumber(2)
  void clearSenderLastName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get senderIdNumber => $_getSZ(2);
  @$pb.TagNumber(3)
  set senderIdNumber($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSenderIdNumber() => $_has(2);
  @$pb.TagNumber(3)
  void clearSenderIdNumber() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get senderIdType => $_getSZ(3);
  @$pb.TagNumber(4)
  set senderIdType($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasSenderIdType() => $_has(3);
  @$pb.TagNumber(4)
  void clearSenderIdType() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get senderNationality => $_getSZ(4);
  @$pb.TagNumber(5)
  set senderNationality($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasSenderNationality() => $_has(4);
  @$pb.TagNumber(5)
  void clearSenderNationality() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get senderBirthDate => $_getSZ(5);
  @$pb.TagNumber(6)
  set senderBirthDate($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasSenderBirthDate() => $_has(5);
  @$pb.TagNumber(6)
  void clearSenderBirthDate() => $_clearField(6);

  @$pb.TagNumber(7)
  Address get senderAddress => $_getN(6);
  @$pb.TagNumber(7)
  set senderAddress(Address value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasSenderAddress() => $_has(6);
  @$pb.TagNumber(7)
  void clearSenderAddress() => $_clearField(7);
  @$pb.TagNumber(7)
  Address ensureSenderAddress() => $_ensure(6);

  @$pb.TagNumber(8)
  $core.bool get complete => $_getBF(7);
  @$pb.TagNumber(8)
  set complete($core.bool value) => $_setBool(7, value);
  @$pb.TagNumber(8)
  $core.bool hasComplete() => $_has(7);
  @$pb.TagNumber(8)
  void clearComplete() => $_clearField(8);

  /// Fields fixed by the user's VERIFIED identity (BVN/NIN), which the form
  /// must render read-only. Server-computed and additive: an older client that
  /// ignores it still works, because the server overwrites these on save
  /// regardless of what was sent — the lock is a courtesy to the user, not the
  /// control. Empty for an unverified user, who may edit everything.
  /// Values are model field names, e.g. "sender_first_name".
  @$pb.TagNumber(9)
  $pb.PbList<$core.String> get lockedFields => $_getList(8);
}

class GetComplianceProfileRequest extends $pb.GeneratedMessage {
  factory GetComplianceProfileRequest() => create();

  GetComplianceProfileRequest._();

  factory GetComplianceProfileRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetComplianceProfileRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetComplianceProfileRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rmb'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetComplianceProfileRequest clone() =>
      GetComplianceProfileRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetComplianceProfileRequest copyWith(
          void Function(GetComplianceProfileRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetComplianceProfileRequest))
          as GetComplianceProfileRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetComplianceProfileRequest create() =>
      GetComplianceProfileRequest._();
  @$core.override
  GetComplianceProfileRequest createEmptyInstance() => create();
  static $pb.PbList<GetComplianceProfileRequest> createRepeated() =>
      $pb.PbList<GetComplianceProfileRequest>();
  @$core.pragma('dart2js:noInline')
  static GetComplianceProfileRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetComplianceProfileRequest>(create);
  static GetComplianceProfileRequest? _defaultInstance;
}

class GetComplianceProfileResponse extends $pb.GeneratedMessage {
  factory GetComplianceProfileResponse({
    ComplianceProfile? profile,
  }) {
    final result = create();
    if (profile != null) result.profile = profile;
    return result;
  }

  GetComplianceProfileResponse._();

  factory GetComplianceProfileResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetComplianceProfileResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetComplianceProfileResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rmb'),
      createEmptyInstance: create)
    ..aOM<ComplianceProfile>(1, _omitFieldNames ? '' : 'profile',
        subBuilder: ComplianceProfile.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetComplianceProfileResponse clone() =>
      GetComplianceProfileResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetComplianceProfileResponse copyWith(
          void Function(GetComplianceProfileResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetComplianceProfileResponse))
          as GetComplianceProfileResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetComplianceProfileResponse create() =>
      GetComplianceProfileResponse._();
  @$core.override
  GetComplianceProfileResponse createEmptyInstance() => create();
  static $pb.PbList<GetComplianceProfileResponse> createRepeated() =>
      $pb.PbList<GetComplianceProfileResponse>();
  @$core.pragma('dart2js:noInline')
  static GetComplianceProfileResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetComplianceProfileResponse>(create);
  static GetComplianceProfileResponse? _defaultInstance;

  @$pb.TagNumber(1)
  ComplianceProfile get profile => $_getN(0);
  @$pb.TagNumber(1)
  set profile(ComplianceProfile value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasProfile() => $_has(0);
  @$pb.TagNumber(1)
  void clearProfile() => $_clearField(1);
  @$pb.TagNumber(1)
  ComplianceProfile ensureProfile() => $_ensure(0);
}

class UpsertComplianceProfileRequest extends $pb.GeneratedMessage {
  factory UpsertComplianceProfileRequest({
    ComplianceProfile? profile,
  }) {
    final result = create();
    if (profile != null) result.profile = profile;
    return result;
  }

  UpsertComplianceProfileRequest._();

  factory UpsertComplianceProfileRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpsertComplianceProfileRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpsertComplianceProfileRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rmb'),
      createEmptyInstance: create)
    ..aOM<ComplianceProfile>(1, _omitFieldNames ? '' : 'profile',
        subBuilder: ComplianceProfile.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpsertComplianceProfileRequest clone() =>
      UpsertComplianceProfileRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpsertComplianceProfileRequest copyWith(
          void Function(UpsertComplianceProfileRequest) updates) =>
      super.copyWith(
              (message) => updates(message as UpsertComplianceProfileRequest))
          as UpsertComplianceProfileRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpsertComplianceProfileRequest create() =>
      UpsertComplianceProfileRequest._();
  @$core.override
  UpsertComplianceProfileRequest createEmptyInstance() => create();
  static $pb.PbList<UpsertComplianceProfileRequest> createRepeated() =>
      $pb.PbList<UpsertComplianceProfileRequest>();
  @$core.pragma('dart2js:noInline')
  static UpsertComplianceProfileRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpsertComplianceProfileRequest>(create);
  static UpsertComplianceProfileRequest? _defaultInstance;

  @$pb.TagNumber(1)
  ComplianceProfile get profile => $_getN(0);
  @$pb.TagNumber(1)
  set profile(ComplianceProfile value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasProfile() => $_has(0);
  @$pb.TagNumber(1)
  void clearProfile() => $_clearField(1);
  @$pb.TagNumber(1)
  ComplianceProfile ensureProfile() => $_ensure(0);
}

class UpsertComplianceProfileResponse extends $pb.GeneratedMessage {
  factory UpsertComplianceProfileResponse({
    ComplianceProfile? profile,
  }) {
    final result = create();
    if (profile != null) result.profile = profile;
    return result;
  }

  UpsertComplianceProfileResponse._();

  factory UpsertComplianceProfileResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpsertComplianceProfileResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpsertComplianceProfileResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rmb'),
      createEmptyInstance: create)
    ..aOM<ComplianceProfile>(1, _omitFieldNames ? '' : 'profile',
        subBuilder: ComplianceProfile.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpsertComplianceProfileResponse clone() =>
      UpsertComplianceProfileResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpsertComplianceProfileResponse copyWith(
          void Function(UpsertComplianceProfileResponse) updates) =>
      super.copyWith(
              (message) => updates(message as UpsertComplianceProfileResponse))
          as UpsertComplianceProfileResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpsertComplianceProfileResponse create() =>
      UpsertComplianceProfileResponse._();
  @$core.override
  UpsertComplianceProfileResponse createEmptyInstance() => create();
  static $pb.PbList<UpsertComplianceProfileResponse> createRepeated() =>
      $pb.PbList<UpsertComplianceProfileResponse>();
  @$core.pragma('dart2js:noInline')
  static UpsertComplianceProfileResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpsertComplianceProfileResponse>(
          create);
  static UpsertComplianceProfileResponse? _defaultInstance;

  @$pb.TagNumber(1)
  ComplianceProfile get profile => $_getN(0);
  @$pb.TagNumber(1)
  set profile(ComplianceProfile value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasProfile() => $_has(0);
  @$pb.TagNumber(1)
  void clearProfile() => $_clearField(1);
  @$pb.TagNumber(1)
  ComplianceProfile ensureProfile() => $_ensure(0);
}

class Transfer extends $pb.GeneratedMessage {
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
    final result = create();
    if (id != null) result.id = id;
    if (reference != null) result.reference = reference;
    if (rail != null) result.rail = rail;
    if (provider != null) result.provider = provider;
    if (status != null) result.status = status;
    if (destAmountMinor != null) result.destAmountMinor = destAmountMinor;
    if (sourceAmountMinor != null) result.sourceAmountMinor = sourceAmountMinor;
    if (fxRate != null) result.fxRate = fxRate;
    if (providerFeeMinor != null) result.providerFeeMinor = providerFeeMinor;
    if (ourFeeMinor != null) result.ourFeeMinor = ourFeeMinor;
    if (totalMinor != null) result.totalMinor = totalMinor;
    if (beneficiaryName != null) result.beneficiaryName = beneficiaryName;
    if (beneficiaryId != null) result.beneficiaryId = beneficiaryId;
    if (purpose != null) result.purpose = purpose;
    if (providerRef != null) result.providerRef = providerRef;
    if (failureReason != null) result.failureReason = failureReason;
    if (complianceStatus != null) result.complianceStatus = complianceStatus;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    if (receiverFirstName != null) result.receiverFirstName = receiverFirstName;
    if (receiverLastName != null) result.receiverLastName = receiverLastName;
    if (accountNumber != null) result.accountNumber = accountNumber;
    if (accountIdType != null) result.accountIdType = accountIdType;
    if (bankName != null) result.bankName = bankName;
    if (bankCode != null) result.bankCode = bankCode;
    if (cardHolderName != null) result.cardHolderName = cardHolderName;
    if (accountName != null) result.accountName = accountName;
    if (receiverMobile != null) result.receiverMobile = receiverMobile;
    if (receiverIdNumber != null) result.receiverIdNumber = receiverIdNumber;
    if (receiverIdType != null) result.receiverIdType = receiverIdType;
    if (receiverRelationship != null)
      result.receiverRelationship = receiverRelationship;
    return result;
  }

  Transfer._();

  factory Transfer.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Transfer.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Transfer',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rmb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'reference')
    ..e<RmbRail>(3, _omitFieldNames ? '' : 'rail', $pb.PbFieldType.OE,
        defaultOrMaker: RmbRail.RAIL_UNSPECIFIED,
        valueOf: RmbRail.valueOf,
        enumValues: RmbRail.values)
    ..aOS(4, _omitFieldNames ? '' : 'provider')
    ..e<RmbStatus>(5, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: RmbStatus.RMB_STATUS_UNSPECIFIED,
        valueOf: RmbStatus.valueOf,
        enumValues: RmbStatus.values)
    ..aInt64(6, _omitFieldNames ? '' : 'destAmountMinor')
    ..aInt64(7, _omitFieldNames ? '' : 'sourceAmountMinor')
    ..a<$core.double>(8, _omitFieldNames ? '' : 'fxRate', $pb.PbFieldType.OD)
    ..aInt64(9, _omitFieldNames ? '' : 'providerFeeMinor')
    ..aInt64(10, _omitFieldNames ? '' : 'ourFeeMinor')
    ..aInt64(11, _omitFieldNames ? '' : 'totalMinor')
    ..aOS(12, _omitFieldNames ? '' : 'beneficiaryName')
    ..aOS(13, _omitFieldNames ? '' : 'beneficiaryId')
    ..aOS(14, _omitFieldNames ? '' : 'purpose')
    ..aOS(15, _omitFieldNames ? '' : 'providerRef')
    ..aOS(16, _omitFieldNames ? '' : 'failureReason')
    ..aOS(17, _omitFieldNames ? '' : 'complianceStatus')
    ..aOM<$1.Timestamp>(18, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(19, _omitFieldNames ? '' : 'updatedAt',
        subBuilder: $1.Timestamp.create)
    ..aOS(20, _omitFieldNames ? '' : 'receiverFirstName')
    ..aOS(21, _omitFieldNames ? '' : 'receiverLastName')
    ..aOS(22, _omitFieldNames ? '' : 'accountNumber')
    ..aOS(23, _omitFieldNames ? '' : 'accountIdType')
    ..aOS(24, _omitFieldNames ? '' : 'bankName')
    ..aOS(25, _omitFieldNames ? '' : 'bankCode')
    ..aOS(26, _omitFieldNames ? '' : 'cardHolderName')
    ..aOS(27, _omitFieldNames ? '' : 'accountName')
    ..aOS(28, _omitFieldNames ? '' : 'receiverMobile')
    ..aOS(29, _omitFieldNames ? '' : 'receiverIdNumber')
    ..aOS(30, _omitFieldNames ? '' : 'receiverIdType')
    ..aOS(31, _omitFieldNames ? '' : 'receiverRelationship')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Transfer clone() => Transfer()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Transfer copyWith(void Function(Transfer) updates) =>
      super.copyWith((message) => updates(message as Transfer)) as Transfer;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Transfer create() => Transfer._();
  @$core.override
  Transfer createEmptyInstance() => create();
  static $pb.PbList<Transfer> createRepeated() => $pb.PbList<Transfer>();
  @$core.pragma('dart2js:noInline')
  static Transfer getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Transfer>(create);
  static Transfer? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get reference => $_getSZ(1);
  @$pb.TagNumber(2)
  set reference($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasReference() => $_has(1);
  @$pb.TagNumber(2)
  void clearReference() => $_clearField(2);

  @$pb.TagNumber(3)
  RmbRail get rail => $_getN(2);
  @$pb.TagNumber(3)
  set rail(RmbRail value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasRail() => $_has(2);
  @$pb.TagNumber(3)
  void clearRail() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get provider => $_getSZ(3);
  @$pb.TagNumber(4)
  set provider($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasProvider() => $_has(3);
  @$pb.TagNumber(4)
  void clearProvider() => $_clearField(4);

  @$pb.TagNumber(5)
  RmbStatus get status => $_getN(4);
  @$pb.TagNumber(5)
  set status(RmbStatus value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasStatus() => $_has(4);
  @$pb.TagNumber(5)
  void clearStatus() => $_clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get destAmountMinor => $_getI64(5);
  @$pb.TagNumber(6)
  set destAmountMinor($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasDestAmountMinor() => $_has(5);
  @$pb.TagNumber(6)
  void clearDestAmountMinor() => $_clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get sourceAmountMinor => $_getI64(6);
  @$pb.TagNumber(7)
  set sourceAmountMinor($fixnum.Int64 value) => $_setInt64(6, value);
  @$pb.TagNumber(7)
  $core.bool hasSourceAmountMinor() => $_has(6);
  @$pb.TagNumber(7)
  void clearSourceAmountMinor() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.double get fxRate => $_getN(7);
  @$pb.TagNumber(8)
  set fxRate($core.double value) => $_setDouble(7, value);
  @$pb.TagNumber(8)
  $core.bool hasFxRate() => $_has(7);
  @$pb.TagNumber(8)
  void clearFxRate() => $_clearField(8);

  @$pb.TagNumber(9)
  $fixnum.Int64 get providerFeeMinor => $_getI64(8);
  @$pb.TagNumber(9)
  set providerFeeMinor($fixnum.Int64 value) => $_setInt64(8, value);
  @$pb.TagNumber(9)
  $core.bool hasProviderFeeMinor() => $_has(8);
  @$pb.TagNumber(9)
  void clearProviderFeeMinor() => $_clearField(9);

  @$pb.TagNumber(10)
  $fixnum.Int64 get ourFeeMinor => $_getI64(9);
  @$pb.TagNumber(10)
  set ourFeeMinor($fixnum.Int64 value) => $_setInt64(9, value);
  @$pb.TagNumber(10)
  $core.bool hasOurFeeMinor() => $_has(9);
  @$pb.TagNumber(10)
  void clearOurFeeMinor() => $_clearField(10);

  @$pb.TagNumber(11)
  $fixnum.Int64 get totalMinor => $_getI64(10);
  @$pb.TagNumber(11)
  set totalMinor($fixnum.Int64 value) => $_setInt64(10, value);
  @$pb.TagNumber(11)
  $core.bool hasTotalMinor() => $_has(10);
  @$pb.TagNumber(11)
  void clearTotalMinor() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get beneficiaryName => $_getSZ(11);
  @$pb.TagNumber(12)
  set beneficiaryName($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasBeneficiaryName() => $_has(11);
  @$pb.TagNumber(12)
  void clearBeneficiaryName() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get beneficiaryId => $_getSZ(12);
  @$pb.TagNumber(13)
  set beneficiaryId($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasBeneficiaryId() => $_has(12);
  @$pb.TagNumber(13)
  void clearBeneficiaryId() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.String get purpose => $_getSZ(13);
  @$pb.TagNumber(14)
  set purpose($core.String value) => $_setString(13, value);
  @$pb.TagNumber(14)
  $core.bool hasPurpose() => $_has(13);
  @$pb.TagNumber(14)
  void clearPurpose() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.String get providerRef => $_getSZ(14);
  @$pb.TagNumber(15)
  set providerRef($core.String value) => $_setString(14, value);
  @$pb.TagNumber(15)
  $core.bool hasProviderRef() => $_has(14);
  @$pb.TagNumber(15)
  void clearProviderRef() => $_clearField(15);

  @$pb.TagNumber(16)
  $core.String get failureReason => $_getSZ(15);
  @$pb.TagNumber(16)
  set failureReason($core.String value) => $_setString(15, value);
  @$pb.TagNumber(16)
  $core.bool hasFailureReason() => $_has(15);
  @$pb.TagNumber(16)
  void clearFailureReason() => $_clearField(16);

  @$pb.TagNumber(17)
  $core.String get complianceStatus => $_getSZ(16);
  @$pb.TagNumber(17)
  set complianceStatus($core.String value) => $_setString(16, value);
  @$pb.TagNumber(17)
  $core.bool hasComplianceStatus() => $_has(16);
  @$pb.TagNumber(17)
  void clearComplianceStatus() => $_clearField(17);

  @$pb.TagNumber(18)
  $1.Timestamp get createdAt => $_getN(17);
  @$pb.TagNumber(18)
  set createdAt($1.Timestamp value) => $_setField(18, value);
  @$pb.TagNumber(18)
  $core.bool hasCreatedAt() => $_has(17);
  @$pb.TagNumber(18)
  void clearCreatedAt() => $_clearField(18);
  @$pb.TagNumber(18)
  $1.Timestamp ensureCreatedAt() => $_ensure(17);

  @$pb.TagNumber(19)
  $1.Timestamp get updatedAt => $_getN(18);
  @$pb.TagNumber(19)
  set updatedAt($1.Timestamp value) => $_setField(19, value);
  @$pb.TagNumber(19)
  $core.bool hasUpdatedAt() => $_has(18);
  @$pb.TagNumber(19)
  void clearUpdatedAt() => $_clearField(19);
  @$pb.TagNumber(19)
  $1.Timestamp ensureUpdatedAt() => $_ensure(18);

  /// Beneficiary detail snapshot — populated from the transfer's stored
  /// beneficiary snapshot so "Repeat transaction" can prefill the recipient
  /// (even for one-off / unsaved transfers) and history can filter by bank.
  @$pb.TagNumber(20)
  $core.String get receiverFirstName => $_getSZ(19);
  @$pb.TagNumber(20)
  set receiverFirstName($core.String value) => $_setString(19, value);
  @$pb.TagNumber(20)
  $core.bool hasReceiverFirstName() => $_has(19);
  @$pb.TagNumber(20)
  void clearReceiverFirstName() => $_clearField(20);

  @$pb.TagNumber(21)
  $core.String get receiverLastName => $_getSZ(20);
  @$pb.TagNumber(21)
  set receiverLastName($core.String value) => $_setString(20, value);
  @$pb.TagNumber(21)
  $core.bool hasReceiverLastName() => $_has(20);
  @$pb.TagNumber(21)
  void clearReceiverLastName() => $_clearField(21);

  @$pb.TagNumber(22)
  $core.String get accountNumber => $_getSZ(21);
  @$pb.TagNumber(22)
  set accountNumber($core.String value) => $_setString(21, value);
  @$pb.TagNumber(22)
  $core.bool hasAccountNumber() => $_has(21);
  @$pb.TagNumber(22)
  void clearAccountNumber() => $_clearField(22);

  @$pb.TagNumber(23)
  $core.String get accountIdType => $_getSZ(22);
  @$pb.TagNumber(23)
  set accountIdType($core.String value) => $_setString(22, value);
  @$pb.TagNumber(23)
  $core.bool hasAccountIdType() => $_has(22);
  @$pb.TagNumber(23)
  void clearAccountIdType() => $_clearField(23);

  @$pb.TagNumber(24)
  $core.String get bankName => $_getSZ(23);
  @$pb.TagNumber(24)
  set bankName($core.String value) => $_setString(23, value);
  @$pb.TagNumber(24)
  $core.bool hasBankName() => $_has(23);
  @$pb.TagNumber(24)
  void clearBankName() => $_clearField(24);

  @$pb.TagNumber(25)
  $core.String get bankCode => $_getSZ(24);
  @$pb.TagNumber(25)
  set bankCode($core.String value) => $_setString(24, value);
  @$pb.TagNumber(25)
  $core.bool hasBankCode() => $_has(24);
  @$pb.TagNumber(25)
  void clearBankCode() => $_clearField(25);

  @$pb.TagNumber(26)
  $core.String get cardHolderName => $_getSZ(25);
  @$pb.TagNumber(26)
  set cardHolderName($core.String value) => $_setString(25, value);
  @$pb.TagNumber(26)
  $core.bool hasCardHolderName() => $_has(25);
  @$pb.TagNumber(26)
  void clearCardHolderName() => $_clearField(26);

  @$pb.TagNumber(27)
  $core.String get accountName => $_getSZ(26);
  @$pb.TagNumber(27)
  set accountName($core.String value) => $_setString(26, value);
  @$pb.TagNumber(27)
  $core.bool hasAccountName() => $_has(26);
  @$pb.TagNumber(27)
  void clearAccountName() => $_clearField(27);

  @$pb.TagNumber(28)
  $core.String get receiverMobile => $_getSZ(27);
  @$pb.TagNumber(28)
  set receiverMobile($core.String value) => $_setString(27, value);
  @$pb.TagNumber(28)
  $core.bool hasReceiverMobile() => $_has(27);
  @$pb.TagNumber(28)
  void clearReceiverMobile() => $_clearField(28);

  @$pb.TagNumber(29)
  $core.String get receiverIdNumber => $_getSZ(28);
  @$pb.TagNumber(29)
  set receiverIdNumber($core.String value) => $_setString(28, value);
  @$pb.TagNumber(29)
  $core.bool hasReceiverIdNumber() => $_has(28);
  @$pb.TagNumber(29)
  void clearReceiverIdNumber() => $_clearField(29);

  @$pb.TagNumber(30)
  $core.String get receiverIdType => $_getSZ(29);
  @$pb.TagNumber(30)
  set receiverIdType($core.String value) => $_setString(29, value);
  @$pb.TagNumber(30)
  $core.bool hasReceiverIdType() => $_has(29);
  @$pb.TagNumber(30)
  void clearReceiverIdType() => $_clearField(30);

  @$pb.TagNumber(31)
  $core.String get receiverRelationship => $_getSZ(30);
  @$pb.TagNumber(31)
  set receiverRelationship($core.String value) => $_setString(30, value);
  @$pb.TagNumber(31)
  $core.bool hasReceiverRelationship() => $_has(30);
  @$pb.TagNumber(31)
  void clearReceiverRelationship() => $_clearField(31);
}

class InitiateTransferRequest extends $pb.GeneratedMessage {
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
    final result = create();
    if (quoteId != null) result.quoteId = quoteId;
    if (beneficiaryId != null) result.beneficiaryId = beneficiaryId;
    if (beneficiary != null) result.beneficiary = beneficiary;
    if (saveBeneficiary != null) result.saveBeneficiary = saveBeneficiary;
    if (purpose != null) result.purpose = purpose;
    if (verificationToken != null) result.verificationToken = verificationToken;
    if (idempotencyKey != null) result.idempotencyKey = idempotencyKey;
    if (sourceAccountId != null) result.sourceAccountId = sourceAccountId;
    return result;
  }

  InitiateTransferRequest._();

  factory InitiateTransferRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InitiateTransferRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InitiateTransferRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rmb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'quoteId')
    ..aOS(2, _omitFieldNames ? '' : 'beneficiaryId')
    ..aOM<Beneficiary>(3, _omitFieldNames ? '' : 'beneficiary',
        subBuilder: Beneficiary.create)
    ..aOB(4, _omitFieldNames ? '' : 'saveBeneficiary')
    ..aOS(5, _omitFieldNames ? '' : 'purpose')
    ..aOS(6, _omitFieldNames ? '' : 'verificationToken')
    ..aOS(7, _omitFieldNames ? '' : 'idempotencyKey')
    ..aOS(8, _omitFieldNames ? '' : 'sourceAccountId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InitiateTransferRequest clone() =>
      InitiateTransferRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InitiateTransferRequest copyWith(
          void Function(InitiateTransferRequest) updates) =>
      super.copyWith((message) => updates(message as InitiateTransferRequest))
          as InitiateTransferRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InitiateTransferRequest create() => InitiateTransferRequest._();
  @$core.override
  InitiateTransferRequest createEmptyInstance() => create();
  static $pb.PbList<InitiateTransferRequest> createRepeated() =>
      $pb.PbList<InitiateTransferRequest>();
  @$core.pragma('dart2js:noInline')
  static InitiateTransferRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InitiateTransferRequest>(create);
  static InitiateTransferRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get quoteId => $_getSZ(0);
  @$pb.TagNumber(1)
  set quoteId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasQuoteId() => $_has(0);
  @$pb.TagNumber(1)
  void clearQuoteId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get beneficiaryId => $_getSZ(1);
  @$pb.TagNumber(2)
  set beneficiaryId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasBeneficiaryId() => $_has(1);
  @$pb.TagNumber(2)
  void clearBeneficiaryId() => $_clearField(2);

  @$pb.TagNumber(3)
  Beneficiary get beneficiary => $_getN(2);
  @$pb.TagNumber(3)
  set beneficiary(Beneficiary value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasBeneficiary() => $_has(2);
  @$pb.TagNumber(3)
  void clearBeneficiary() => $_clearField(3);
  @$pb.TagNumber(3)
  Beneficiary ensureBeneficiary() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.bool get saveBeneficiary => $_getBF(3);
  @$pb.TagNumber(4)
  set saveBeneficiary($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasSaveBeneficiary() => $_has(3);
  @$pb.TagNumber(4)
  void clearSaveBeneficiary() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get purpose => $_getSZ(4);
  @$pb.TagNumber(5)
  set purpose($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasPurpose() => $_has(4);
  @$pb.TagNumber(5)
  void clearPurpose() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get verificationToken => $_getSZ(5);
  @$pb.TagNumber(6)
  set verificationToken($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasVerificationToken() => $_has(5);
  @$pb.TagNumber(6)
  void clearVerificationToken() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get idempotencyKey => $_getSZ(6);
  @$pb.TagNumber(7)
  set idempotencyKey($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasIdempotencyKey() => $_has(6);
  @$pb.TagNumber(7)
  void clearIdempotencyKey() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get sourceAccountId => $_getSZ(7);
  @$pb.TagNumber(8)
  set sourceAccountId($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasSourceAccountId() => $_has(7);
  @$pb.TagNumber(8)
  void clearSourceAccountId() => $_clearField(8);
}

class InitiateTransferResponse extends $pb.GeneratedMessage {
  factory InitiateTransferResponse({
    Transfer? transfer,
    $core.String? message,
  }) {
    final result = create();
    if (transfer != null) result.transfer = transfer;
    if (message != null) result.message = message;
    return result;
  }

  InitiateTransferResponse._();

  factory InitiateTransferResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InitiateTransferResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InitiateTransferResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rmb'),
      createEmptyInstance: create)
    ..aOM<Transfer>(1, _omitFieldNames ? '' : 'transfer',
        subBuilder: Transfer.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InitiateTransferResponse clone() =>
      InitiateTransferResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InitiateTransferResponse copyWith(
          void Function(InitiateTransferResponse) updates) =>
      super.copyWith((message) => updates(message as InitiateTransferResponse))
          as InitiateTransferResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InitiateTransferResponse create() => InitiateTransferResponse._();
  @$core.override
  InitiateTransferResponse createEmptyInstance() => create();
  static $pb.PbList<InitiateTransferResponse> createRepeated() =>
      $pb.PbList<InitiateTransferResponse>();
  @$core.pragma('dart2js:noInline')
  static InitiateTransferResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InitiateTransferResponse>(create);
  static InitiateTransferResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Transfer get transfer => $_getN(0);
  @$pb.TagNumber(1)
  set transfer(Transfer value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasTransfer() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransfer() => $_clearField(1);
  @$pb.TagNumber(1)
  Transfer ensureTransfer() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);
}

class GetTransferRequest extends $pb.GeneratedMessage {
  factory GetTransferRequest({
    $core.String? id,
  }) {
    final result = create();
    if (id != null) result.id = id;
    return result;
  }

  GetTransferRequest._();

  factory GetTransferRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTransferRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTransferRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rmb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTransferRequest clone() => GetTransferRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTransferRequest copyWith(void Function(GetTransferRequest) updates) =>
      super.copyWith((message) => updates(message as GetTransferRequest))
          as GetTransferRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTransferRequest create() => GetTransferRequest._();
  @$core.override
  GetTransferRequest createEmptyInstance() => create();
  static $pb.PbList<GetTransferRequest> createRepeated() =>
      $pb.PbList<GetTransferRequest>();
  @$core.pragma('dart2js:noInline')
  static GetTransferRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetTransferRequest>(create);
  static GetTransferRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);
}

class GetTransferResponse extends $pb.GeneratedMessage {
  factory GetTransferResponse({
    Transfer? transfer,
  }) {
    final result = create();
    if (transfer != null) result.transfer = transfer;
    return result;
  }

  GetTransferResponse._();

  factory GetTransferResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTransferResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTransferResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rmb'),
      createEmptyInstance: create)
    ..aOM<Transfer>(1, _omitFieldNames ? '' : 'transfer',
        subBuilder: Transfer.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTransferResponse clone() => GetTransferResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTransferResponse copyWith(void Function(GetTransferResponse) updates) =>
      super.copyWith((message) => updates(message as GetTransferResponse))
          as GetTransferResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTransferResponse create() => GetTransferResponse._();
  @$core.override
  GetTransferResponse createEmptyInstance() => create();
  static $pb.PbList<GetTransferResponse> createRepeated() =>
      $pb.PbList<GetTransferResponse>();
  @$core.pragma('dart2js:noInline')
  static GetTransferResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetTransferResponse>(create);
  static GetTransferResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Transfer get transfer => $_getN(0);
  @$pb.TagNumber(1)
  set transfer(Transfer value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasTransfer() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransfer() => $_clearField(1);
  @$pb.TagNumber(1)
  Transfer ensureTransfer() => $_ensure(0);
}

class ListTransfersRequest extends $pb.GeneratedMessage {
  factory ListTransfersRequest({
    $core.int? page,
    $core.int? pageSize,
    RmbStatus? status,
  }) {
    final result = create();
    if (page != null) result.page = page;
    if (pageSize != null) result.pageSize = pageSize;
    if (status != null) result.status = status;
    return result;
  }

  ListTransfersRequest._();

  factory ListTransfersRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListTransfersRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListTransfersRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rmb'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..e<RmbStatus>(3, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: RmbStatus.RMB_STATUS_UNSPECIFIED,
        valueOf: RmbStatus.valueOf,
        enumValues: RmbStatus.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListTransfersRequest clone() =>
      ListTransfersRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListTransfersRequest copyWith(void Function(ListTransfersRequest) updates) =>
      super.copyWith((message) => updates(message as ListTransfersRequest))
          as ListTransfersRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListTransfersRequest create() => ListTransfersRequest._();
  @$core.override
  ListTransfersRequest createEmptyInstance() => create();
  static $pb.PbList<ListTransfersRequest> createRepeated() =>
      $pb.PbList<ListTransfersRequest>();
  @$core.pragma('dart2js:noInline')
  static ListTransfersRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListTransfersRequest>(create);
  static ListTransfersRequest? _defaultInstance;

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
  RmbStatus get status => $_getN(2);
  @$pb.TagNumber(3)
  set status(RmbStatus value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatus() => $_clearField(3);
}

class ListTransfersResponse extends $pb.GeneratedMessage {
  factory ListTransfersResponse({
    $core.Iterable<Transfer>? transfers,
    $core.int? total,
    $core.int? page,
    $core.int? pageSize,
  }) {
    final result = create();
    if (transfers != null) result.transfers.addAll(transfers);
    if (total != null) result.total = total;
    if (page != null) result.page = page;
    if (pageSize != null) result.pageSize = pageSize;
    return result;
  }

  ListTransfersResponse._();

  factory ListTransfersResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListTransfersResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListTransfersResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'rmb'),
      createEmptyInstance: create)
    ..pc<Transfer>(1, _omitFieldNames ? '' : 'transfers', $pb.PbFieldType.PM,
        subBuilder: Transfer.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListTransfersResponse clone() =>
      ListTransfersResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListTransfersResponse copyWith(
          void Function(ListTransfersResponse) updates) =>
      super.copyWith((message) => updates(message as ListTransfersResponse))
          as ListTransfersResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListTransfersResponse create() => ListTransfersResponse._();
  @$core.override
  ListTransfersResponse createEmptyInstance() => create();
  static $pb.PbList<ListTransfersResponse> createRepeated() =>
      $pb.PbList<ListTransfersResponse>();
  @$core.pragma('dart2js:noInline')
  static ListTransfersResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListTransfersResponse>(create);
  static ListTransfersResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Transfer> get transfers => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);

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

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
