// This is a generated file - do not edit.
//
// Generated from portfolio.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $1;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class PortfolioAsset extends $pb.GeneratedMessage {
  factory PortfolioAsset({
    $core.String? id,
    $core.String? assetType,
    $core.String? name,
    $core.String? symbol,
    $core.double? currentValue,
    $core.double? quantity,
    $core.double? currentPrice,
    $core.double? initialValue,
    $core.double? gainLoss,
    $core.double? gainLossPercent,
    $core.String? currency,
    $1.Timestamp? lastUpdated,
    $core.String? iconUrl,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (assetType != null) result.assetType = assetType;
    if (name != null) result.name = name;
    if (symbol != null) result.symbol = symbol;
    if (currentValue != null) result.currentValue = currentValue;
    if (quantity != null) result.quantity = quantity;
    if (currentPrice != null) result.currentPrice = currentPrice;
    if (initialValue != null) result.initialValue = initialValue;
    if (gainLoss != null) result.gainLoss = gainLoss;
    if (gainLossPercent != null) result.gainLossPercent = gainLossPercent;
    if (currency != null) result.currency = currency;
    if (lastUpdated != null) result.lastUpdated = lastUpdated;
    if (iconUrl != null) result.iconUrl = iconUrl;
    return result;
  }

  PortfolioAsset._();

  factory PortfolioAsset.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PortfolioAsset.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PortfolioAsset',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'assetType')
    ..aOS(3, _omitFieldNames ? '' : 'name')
    ..aOS(4, _omitFieldNames ? '' : 'symbol')
    ..a<$core.double>(
        5, _omitFieldNames ? '' : 'currentValue', $pb.PbFieldType.OD)
    ..a<$core.double>(6, _omitFieldNames ? '' : 'quantity', $pb.PbFieldType.OD)
    ..a<$core.double>(
        7, _omitFieldNames ? '' : 'currentPrice', $pb.PbFieldType.OD)
    ..a<$core.double>(
        8, _omitFieldNames ? '' : 'initialValue', $pb.PbFieldType.OD)
    ..a<$core.double>(9, _omitFieldNames ? '' : 'gainLoss', $pb.PbFieldType.OD)
    ..a<$core.double>(
        10, _omitFieldNames ? '' : 'gainLossPercent', $pb.PbFieldType.OD)
    ..aOS(11, _omitFieldNames ? '' : 'currency')
    ..aOM<$1.Timestamp>(12, _omitFieldNames ? '' : 'lastUpdated',
        subBuilder: $1.Timestamp.create)
    ..aOS(13, _omitFieldNames ? '' : 'iconUrl')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PortfolioAsset clone() => PortfolioAsset()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PortfolioAsset copyWith(void Function(PortfolioAsset) updates) =>
      super.copyWith((message) => updates(message as PortfolioAsset))
          as PortfolioAsset;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PortfolioAsset create() => PortfolioAsset._();
  @$core.override
  PortfolioAsset createEmptyInstance() => create();
  static $pb.PbList<PortfolioAsset> createRepeated() =>
      $pb.PbList<PortfolioAsset>();
  @$core.pragma('dart2js:noInline')
  static PortfolioAsset getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PortfolioAsset>(create);
  static PortfolioAsset? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get assetType => $_getSZ(1);
  @$pb.TagNumber(2)
  set assetType($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAssetType() => $_has(1);
  @$pb.TagNumber(2)
  void clearAssetType() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get symbol => $_getSZ(3);
  @$pb.TagNumber(4)
  set symbol($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasSymbol() => $_has(3);
  @$pb.TagNumber(4)
  void clearSymbol() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get currentValue => $_getN(4);
  @$pb.TagNumber(5)
  set currentValue($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCurrentValue() => $_has(4);
  @$pb.TagNumber(5)
  void clearCurrentValue() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.double get quantity => $_getN(5);
  @$pb.TagNumber(6)
  set quantity($core.double value) => $_setDouble(5, value);
  @$pb.TagNumber(6)
  $core.bool hasQuantity() => $_has(5);
  @$pb.TagNumber(6)
  void clearQuantity() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.double get currentPrice => $_getN(6);
  @$pb.TagNumber(7)
  set currentPrice($core.double value) => $_setDouble(6, value);
  @$pb.TagNumber(7)
  $core.bool hasCurrentPrice() => $_has(6);
  @$pb.TagNumber(7)
  void clearCurrentPrice() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.double get initialValue => $_getN(7);
  @$pb.TagNumber(8)
  set initialValue($core.double value) => $_setDouble(7, value);
  @$pb.TagNumber(8)
  $core.bool hasInitialValue() => $_has(7);
  @$pb.TagNumber(8)
  void clearInitialValue() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.double get gainLoss => $_getN(8);
  @$pb.TagNumber(9)
  set gainLoss($core.double value) => $_setDouble(8, value);
  @$pb.TagNumber(9)
  $core.bool hasGainLoss() => $_has(8);
  @$pb.TagNumber(9)
  void clearGainLoss() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.double get gainLossPercent => $_getN(9);
  @$pb.TagNumber(10)
  set gainLossPercent($core.double value) => $_setDouble(9, value);
  @$pb.TagNumber(10)
  $core.bool hasGainLossPercent() => $_has(9);
  @$pb.TagNumber(10)
  void clearGainLossPercent() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get currency => $_getSZ(10);
  @$pb.TagNumber(11)
  set currency($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasCurrency() => $_has(10);
  @$pb.TagNumber(11)
  void clearCurrency() => $_clearField(11);

  @$pb.TagNumber(12)
  $1.Timestamp get lastUpdated => $_getN(11);
  @$pb.TagNumber(12)
  set lastUpdated($1.Timestamp value) => $_setField(12, value);
  @$pb.TagNumber(12)
  $core.bool hasLastUpdated() => $_has(11);
  @$pb.TagNumber(12)
  void clearLastUpdated() => $_clearField(12);
  @$pb.TagNumber(12)
  $1.Timestamp ensureLastUpdated() => $_ensure(11);

  @$pb.TagNumber(13)
  $core.String get iconUrl => $_getSZ(12);
  @$pb.TagNumber(13)
  set iconUrl($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasIconUrl() => $_has(12);
  @$pb.TagNumber(13)
  void clearIconUrl() => $_clearField(13);
}

class PortfolioSummary extends $pb.GeneratedMessage {
  factory PortfolioSummary({
    $core.double? totalValue,
    $core.double? totalGainLoss,
    $core.double? totalGainLossPercent,
    $core.double? totalInvested,
    $core.String? currency,
    $core.Iterable<$core.MapEntry<$core.String, $core.double>>? assetsByType,
    $core.int? assetCount,
    $1.Timestamp? lastUpdated,
  }) {
    final result = create();
    if (totalValue != null) result.totalValue = totalValue;
    if (totalGainLoss != null) result.totalGainLoss = totalGainLoss;
    if (totalGainLossPercent != null)
      result.totalGainLossPercent = totalGainLossPercent;
    if (totalInvested != null) result.totalInvested = totalInvested;
    if (currency != null) result.currency = currency;
    if (assetsByType != null) result.assetsByType.addEntries(assetsByType);
    if (assetCount != null) result.assetCount = assetCount;
    if (lastUpdated != null) result.lastUpdated = lastUpdated;
    return result;
  }

  PortfolioSummary._();

  factory PortfolioSummary.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PortfolioSummary.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PortfolioSummary',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..a<$core.double>(
        1, _omitFieldNames ? '' : 'totalValue', $pb.PbFieldType.OD)
    ..a<$core.double>(
        2, _omitFieldNames ? '' : 'totalGainLoss', $pb.PbFieldType.OD)
    ..a<$core.double>(
        3, _omitFieldNames ? '' : 'totalGainLossPercent', $pb.PbFieldType.OD)
    ..a<$core.double>(
        4, _omitFieldNames ? '' : 'totalInvested', $pb.PbFieldType.OD)
    ..aOS(5, _omitFieldNames ? '' : 'currency')
    ..m<$core.String, $core.double>(6, _omitFieldNames ? '' : 'assetsByType',
        entryClassName: 'PortfolioSummary.AssetsByTypeEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OD,
        packageName: const $pb.PackageName('pb'))
    ..a<$core.int>(7, _omitFieldNames ? '' : 'assetCount', $pb.PbFieldType.O3)
    ..aOM<$1.Timestamp>(8, _omitFieldNames ? '' : 'lastUpdated',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PortfolioSummary clone() => PortfolioSummary()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PortfolioSummary copyWith(void Function(PortfolioSummary) updates) =>
      super.copyWith((message) => updates(message as PortfolioSummary))
          as PortfolioSummary;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PortfolioSummary create() => PortfolioSummary._();
  @$core.override
  PortfolioSummary createEmptyInstance() => create();
  static $pb.PbList<PortfolioSummary> createRepeated() =>
      $pb.PbList<PortfolioSummary>();
  @$core.pragma('dart2js:noInline')
  static PortfolioSummary getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PortfolioSummary>(create);
  static PortfolioSummary? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get totalValue => $_getN(0);
  @$pb.TagNumber(1)
  set totalValue($core.double value) => $_setDouble(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTotalValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearTotalValue() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get totalGainLoss => $_getN(1);
  @$pb.TagNumber(2)
  set totalGainLoss($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotalGainLoss() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalGainLoss() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get totalGainLossPercent => $_getN(2);
  @$pb.TagNumber(3)
  set totalGainLossPercent($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTotalGainLossPercent() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalGainLossPercent() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get totalInvested => $_getN(3);
  @$pb.TagNumber(4)
  set totalInvested($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTotalInvested() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalInvested() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get currency => $_getSZ(4);
  @$pb.TagNumber(5)
  set currency($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCurrency() => $_has(4);
  @$pb.TagNumber(5)
  void clearCurrency() => $_clearField(5);

  @$pb.TagNumber(6)
  $pb.PbMap<$core.String, $core.double> get assetsByType => $_getMap(5);

  @$pb.TagNumber(7)
  $core.int get assetCount => $_getIZ(6);
  @$pb.TagNumber(7)
  set assetCount($core.int value) => $_setSignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasAssetCount() => $_has(6);
  @$pb.TagNumber(7)
  void clearAssetCount() => $_clearField(7);

  @$pb.TagNumber(8)
  $1.Timestamp get lastUpdated => $_getN(7);
  @$pb.TagNumber(8)
  set lastUpdated($1.Timestamp value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasLastUpdated() => $_has(7);
  @$pb.TagNumber(8)
  void clearLastUpdated() => $_clearField(8);
  @$pb.TagNumber(8)
  $1.Timestamp ensureLastUpdated() => $_ensure(7);
}

/// Get Complete Portfolio Request/Response
class GetCompletePortfolioRequest extends $pb.GeneratedMessage {
  factory GetCompletePortfolioRequest() => create();

  GetCompletePortfolioRequest._();

  factory GetCompletePortfolioRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetCompletePortfolioRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetCompletePortfolioRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCompletePortfolioRequest clone() =>
      GetCompletePortfolioRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCompletePortfolioRequest copyWith(
          void Function(GetCompletePortfolioRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetCompletePortfolioRequest))
          as GetCompletePortfolioRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCompletePortfolioRequest create() =>
      GetCompletePortfolioRequest._();
  @$core.override
  GetCompletePortfolioRequest createEmptyInstance() => create();
  static $pb.PbList<GetCompletePortfolioRequest> createRepeated() =>
      $pb.PbList<GetCompletePortfolioRequest>();
  @$core.pragma('dart2js:noInline')
  static GetCompletePortfolioRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetCompletePortfolioRequest>(create);
  static GetCompletePortfolioRequest? _defaultInstance;
}

class GetCompletePortfolioResponse extends $pb.GeneratedMessage {
  factory GetCompletePortfolioResponse({
    $core.bool? success,
    $core.String? message,
    PortfolioSummary? summary,
    $core.Iterable<PortfolioAsset>? assets,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (summary != null) result.summary = summary;
    if (assets != null) result.assets.addAll(assets);
    return result;
  }

  GetCompletePortfolioResponse._();

  factory GetCompletePortfolioResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetCompletePortfolioResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetCompletePortfolioResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<PortfolioSummary>(3, _omitFieldNames ? '' : 'summary',
        subBuilder: PortfolioSummary.create)
    ..pc<PortfolioAsset>(4, _omitFieldNames ? '' : 'assets', $pb.PbFieldType.PM,
        subBuilder: PortfolioAsset.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCompletePortfolioResponse clone() =>
      GetCompletePortfolioResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCompletePortfolioResponse copyWith(
          void Function(GetCompletePortfolioResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetCompletePortfolioResponse))
          as GetCompletePortfolioResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCompletePortfolioResponse create() =>
      GetCompletePortfolioResponse._();
  @$core.override
  GetCompletePortfolioResponse createEmptyInstance() => create();
  static $pb.PbList<GetCompletePortfolioResponse> createRepeated() =>
      $pb.PbList<GetCompletePortfolioResponse>();
  @$core.pragma('dart2js:noInline')
  static GetCompletePortfolioResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetCompletePortfolioResponse>(create);
  static GetCompletePortfolioResponse? _defaultInstance;

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
  PortfolioSummary get summary => $_getN(2);
  @$pb.TagNumber(3)
  set summary(PortfolioSummary value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasSummary() => $_has(2);
  @$pb.TagNumber(3)
  void clearSummary() => $_clearField(3);
  @$pb.TagNumber(3)
  PortfolioSummary ensureSummary() => $_ensure(2);

  @$pb.TagNumber(4)
  $pb.PbList<PortfolioAsset> get assets => $_getList(3);
}

/// Get Portfolio By Asset Type Request/Response
class GetPortfolioByAssetTypeRequest extends $pb.GeneratedMessage {
  factory GetPortfolioByAssetTypeRequest({
    $core.String? assetType,
  }) {
    final result = create();
    if (assetType != null) result.assetType = assetType;
    return result;
  }

  GetPortfolioByAssetTypeRequest._();

  factory GetPortfolioByAssetTypeRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetPortfolioByAssetTypeRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetPortfolioByAssetTypeRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'assetType')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPortfolioByAssetTypeRequest clone() =>
      GetPortfolioByAssetTypeRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPortfolioByAssetTypeRequest copyWith(
          void Function(GetPortfolioByAssetTypeRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetPortfolioByAssetTypeRequest))
          as GetPortfolioByAssetTypeRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPortfolioByAssetTypeRequest create() =>
      GetPortfolioByAssetTypeRequest._();
  @$core.override
  GetPortfolioByAssetTypeRequest createEmptyInstance() => create();
  static $pb.PbList<GetPortfolioByAssetTypeRequest> createRepeated() =>
      $pb.PbList<GetPortfolioByAssetTypeRequest>();
  @$core.pragma('dart2js:noInline')
  static GetPortfolioByAssetTypeRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetPortfolioByAssetTypeRequest>(create);
  static GetPortfolioByAssetTypeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get assetType => $_getSZ(0);
  @$pb.TagNumber(1)
  set assetType($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAssetType() => $_has(0);
  @$pb.TagNumber(1)
  void clearAssetType() => $_clearField(1);
}

class GetPortfolioByAssetTypeResponse extends $pb.GeneratedMessage {
  factory GetPortfolioByAssetTypeResponse({
    $core.bool? success,
    $core.String? message,
    $core.Iterable<PortfolioAsset>? assets,
    $core.double? totalValue,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (assets != null) result.assets.addAll(assets);
    if (totalValue != null) result.totalValue = totalValue;
    return result;
  }

  GetPortfolioByAssetTypeResponse._();

  factory GetPortfolioByAssetTypeResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetPortfolioByAssetTypeResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetPortfolioByAssetTypeResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..pc<PortfolioAsset>(3, _omitFieldNames ? '' : 'assets', $pb.PbFieldType.PM,
        subBuilder: PortfolioAsset.create)
    ..a<$core.double>(
        4, _omitFieldNames ? '' : 'totalValue', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPortfolioByAssetTypeResponse clone() =>
      GetPortfolioByAssetTypeResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPortfolioByAssetTypeResponse copyWith(
          void Function(GetPortfolioByAssetTypeResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetPortfolioByAssetTypeResponse))
          as GetPortfolioByAssetTypeResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPortfolioByAssetTypeResponse create() =>
      GetPortfolioByAssetTypeResponse._();
  @$core.override
  GetPortfolioByAssetTypeResponse createEmptyInstance() => create();
  static $pb.PbList<GetPortfolioByAssetTypeResponse> createRepeated() =>
      $pb.PbList<GetPortfolioByAssetTypeResponse>();
  @$core.pragma('dart2js:noInline')
  static GetPortfolioByAssetTypeResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetPortfolioByAssetTypeResponse>(
          create);
  static GetPortfolioByAssetTypeResponse? _defaultInstance;

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
  $pb.PbList<PortfolioAsset> get assets => $_getList(2);

  @$pb.TagNumber(4)
  $core.double get totalValue => $_getN(3);
  @$pb.TagNumber(4)
  set totalValue($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTotalValue() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalValue() => $_clearField(4);
}

/// Get Portfolio History Request/Response
class GetPortfolioHistoryRequest extends $pb.GeneratedMessage {
  factory GetPortfolioHistoryRequest({
    $core.String? period,
  }) {
    final result = create();
    if (period != null) result.period = period;
    return result;
  }

  GetPortfolioHistoryRequest._();

  factory GetPortfolioHistoryRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetPortfolioHistoryRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetPortfolioHistoryRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'period')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPortfolioHistoryRequest clone() =>
      GetPortfolioHistoryRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPortfolioHistoryRequest copyWith(
          void Function(GetPortfolioHistoryRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetPortfolioHistoryRequest))
          as GetPortfolioHistoryRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPortfolioHistoryRequest create() => GetPortfolioHistoryRequest._();
  @$core.override
  GetPortfolioHistoryRequest createEmptyInstance() => create();
  static $pb.PbList<GetPortfolioHistoryRequest> createRepeated() =>
      $pb.PbList<GetPortfolioHistoryRequest>();
  @$core.pragma('dart2js:noInline')
  static GetPortfolioHistoryRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetPortfolioHistoryRequest>(create);
  static GetPortfolioHistoryRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get period => $_getSZ(0);
  @$pb.TagNumber(1)
  set period($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPeriod() => $_has(0);
  @$pb.TagNumber(1)
  void clearPeriod() => $_clearField(1);
}

class PortfolioHistoryPoint extends $pb.GeneratedMessage {
  factory PortfolioHistoryPoint({
    $1.Timestamp? date,
    $core.double? value,
  }) {
    final result = create();
    if (date != null) result.date = date;
    if (value != null) result.value = value;
    return result;
  }

  PortfolioHistoryPoint._();

  factory PortfolioHistoryPoint.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PortfolioHistoryPoint.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PortfolioHistoryPoint',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOM<$1.Timestamp>(1, _omitFieldNames ? '' : 'date',
        subBuilder: $1.Timestamp.create)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'value', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PortfolioHistoryPoint clone() =>
      PortfolioHistoryPoint()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PortfolioHistoryPoint copyWith(
          void Function(PortfolioHistoryPoint) updates) =>
      super.copyWith((message) => updates(message as PortfolioHistoryPoint))
          as PortfolioHistoryPoint;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PortfolioHistoryPoint create() => PortfolioHistoryPoint._();
  @$core.override
  PortfolioHistoryPoint createEmptyInstance() => create();
  static $pb.PbList<PortfolioHistoryPoint> createRepeated() =>
      $pb.PbList<PortfolioHistoryPoint>();
  @$core.pragma('dart2js:noInline')
  static PortfolioHistoryPoint getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PortfolioHistoryPoint>(create);
  static PortfolioHistoryPoint? _defaultInstance;

  @$pb.TagNumber(1)
  $1.Timestamp get date => $_getN(0);
  @$pb.TagNumber(1)
  set date($1.Timestamp value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasDate() => $_has(0);
  @$pb.TagNumber(1)
  void clearDate() => $_clearField(1);
  @$pb.TagNumber(1)
  $1.Timestamp ensureDate() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.double get value => $_getN(1);
  @$pb.TagNumber(2)
  set value($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearValue() => $_clearField(2);
}

class GetPortfolioHistoryResponse extends $pb.GeneratedMessage {
  factory GetPortfolioHistoryResponse({
    $core.bool? success,
    $core.String? message,
    $core.Iterable<PortfolioHistoryPoint>? history,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (history != null) result.history.addAll(history);
    return result;
  }

  GetPortfolioHistoryResponse._();

  factory GetPortfolioHistoryResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetPortfolioHistoryResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetPortfolioHistoryResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..pc<PortfolioHistoryPoint>(
        3, _omitFieldNames ? '' : 'history', $pb.PbFieldType.PM,
        subBuilder: PortfolioHistoryPoint.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPortfolioHistoryResponse clone() =>
      GetPortfolioHistoryResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPortfolioHistoryResponse copyWith(
          void Function(GetPortfolioHistoryResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetPortfolioHistoryResponse))
          as GetPortfolioHistoryResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPortfolioHistoryResponse create() =>
      GetPortfolioHistoryResponse._();
  @$core.override
  GetPortfolioHistoryResponse createEmptyInstance() => create();
  static $pb.PbList<GetPortfolioHistoryResponse> createRepeated() =>
      $pb.PbList<GetPortfolioHistoryResponse>();
  @$core.pragma('dart2js:noInline')
  static GetPortfolioHistoryResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetPortfolioHistoryResponse>(create);
  static GetPortfolioHistoryResponse? _defaultInstance;

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
  $pb.PbList<PortfolioHistoryPoint> get history => $_getList(2);
}

/// Get Portfolio Summary Request/Response
class GetPortfolioSummaryRequest extends $pb.GeneratedMessage {
  factory GetPortfolioSummaryRequest() => create();

  GetPortfolioSummaryRequest._();

  factory GetPortfolioSummaryRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetPortfolioSummaryRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetPortfolioSummaryRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPortfolioSummaryRequest clone() =>
      GetPortfolioSummaryRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPortfolioSummaryRequest copyWith(
          void Function(GetPortfolioSummaryRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetPortfolioSummaryRequest))
          as GetPortfolioSummaryRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPortfolioSummaryRequest create() => GetPortfolioSummaryRequest._();
  @$core.override
  GetPortfolioSummaryRequest createEmptyInstance() => create();
  static $pb.PbList<GetPortfolioSummaryRequest> createRepeated() =>
      $pb.PbList<GetPortfolioSummaryRequest>();
  @$core.pragma('dart2js:noInline')
  static GetPortfolioSummaryRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetPortfolioSummaryRequest>(create);
  static GetPortfolioSummaryRequest? _defaultInstance;
}

class GetPortfolioSummaryResponse extends $pb.GeneratedMessage {
  factory GetPortfolioSummaryResponse({
    $core.bool? success,
    $core.String? message,
    PortfolioSummary? summary,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (summary != null) result.summary = summary;
    return result;
  }

  GetPortfolioSummaryResponse._();

  factory GetPortfolioSummaryResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetPortfolioSummaryResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetPortfolioSummaryResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<PortfolioSummary>(3, _omitFieldNames ? '' : 'summary',
        subBuilder: PortfolioSummary.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPortfolioSummaryResponse clone() =>
      GetPortfolioSummaryResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPortfolioSummaryResponse copyWith(
          void Function(GetPortfolioSummaryResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetPortfolioSummaryResponse))
          as GetPortfolioSummaryResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPortfolioSummaryResponse create() =>
      GetPortfolioSummaryResponse._();
  @$core.override
  GetPortfolioSummaryResponse createEmptyInstance() => create();
  static $pb.PbList<GetPortfolioSummaryResponse> createRepeated() =>
      $pb.PbList<GetPortfolioSummaryResponse>();
  @$core.pragma('dart2js:noInline')
  static GetPortfolioSummaryResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetPortfolioSummaryResponse>(create);
  static GetPortfolioSummaryResponse? _defaultInstance;

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
  PortfolioSummary get summary => $_getN(2);
  @$pb.TagNumber(3)
  set summary(PortfolioSummary value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasSummary() => $_has(2);
  @$pb.TagNumber(3)
  void clearSummary() => $_clearField(3);
  @$pb.TagNumber(3)
  PortfolioSummary ensureSummary() => $_ensure(2);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
