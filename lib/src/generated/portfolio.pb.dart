//
//  Generated code. Do not modify.
//  source: portfolio.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $42;

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
    $42.Timestamp? lastUpdated,
    $core.String? iconUrl,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (assetType != null) {
      $result.assetType = assetType;
    }
    if (name != null) {
      $result.name = name;
    }
    if (symbol != null) {
      $result.symbol = symbol;
    }
    if (currentValue != null) {
      $result.currentValue = currentValue;
    }
    if (quantity != null) {
      $result.quantity = quantity;
    }
    if (currentPrice != null) {
      $result.currentPrice = currentPrice;
    }
    if (initialValue != null) {
      $result.initialValue = initialValue;
    }
    if (gainLoss != null) {
      $result.gainLoss = gainLoss;
    }
    if (gainLossPercent != null) {
      $result.gainLossPercent = gainLossPercent;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (lastUpdated != null) {
      $result.lastUpdated = lastUpdated;
    }
    if (iconUrl != null) {
      $result.iconUrl = iconUrl;
    }
    return $result;
  }
  PortfolioAsset._() : super();
  factory PortfolioAsset.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PortfolioAsset.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PortfolioAsset', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'assetType')
    ..aOS(3, _omitFieldNames ? '' : 'name')
    ..aOS(4, _omitFieldNames ? '' : 'symbol')
    ..a<$core.double>(5, _omitFieldNames ? '' : 'currentValue', $pb.PbFieldType.OD)
    ..a<$core.double>(6, _omitFieldNames ? '' : 'quantity', $pb.PbFieldType.OD)
    ..a<$core.double>(7, _omitFieldNames ? '' : 'currentPrice', $pb.PbFieldType.OD)
    ..a<$core.double>(8, _omitFieldNames ? '' : 'initialValue', $pb.PbFieldType.OD)
    ..a<$core.double>(9, _omitFieldNames ? '' : 'gainLoss', $pb.PbFieldType.OD)
    ..a<$core.double>(10, _omitFieldNames ? '' : 'gainLossPercent', $pb.PbFieldType.OD)
    ..aOS(11, _omitFieldNames ? '' : 'currency')
    ..aOM<$42.Timestamp>(12, _omitFieldNames ? '' : 'lastUpdated', subBuilder: $42.Timestamp.create)
    ..aOS(13, _omitFieldNames ? '' : 'iconUrl')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PortfolioAsset clone() => PortfolioAsset()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PortfolioAsset copyWith(void Function(PortfolioAsset) updates) => super.copyWith((message) => updates(message as PortfolioAsset)) as PortfolioAsset;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PortfolioAsset create() => PortfolioAsset._();
  PortfolioAsset createEmptyInstance() => create();
  static $pb.PbList<PortfolioAsset> createRepeated() => $pb.PbList<PortfolioAsset>();
  @$core.pragma('dart2js:noInline')
  static PortfolioAsset getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PortfolioAsset>(create);
  static PortfolioAsset? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get assetType => $_getSZ(1);
  @$pb.TagNumber(2)
  set assetType($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAssetType() => $_has(1);
  @$pb.TagNumber(2)
  void clearAssetType() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get symbol => $_getSZ(3);
  @$pb.TagNumber(4)
  set symbol($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasSymbol() => $_has(3);
  @$pb.TagNumber(4)
  void clearSymbol() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get currentValue => $_getN(4);
  @$pb.TagNumber(5)
  set currentValue($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasCurrentValue() => $_has(4);
  @$pb.TagNumber(5)
  void clearCurrentValue() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get quantity => $_getN(5);
  @$pb.TagNumber(6)
  set quantity($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasQuantity() => $_has(5);
  @$pb.TagNumber(6)
  void clearQuantity() => clearField(6);

  @$pb.TagNumber(7)
  $core.double get currentPrice => $_getN(6);
  @$pb.TagNumber(7)
  set currentPrice($core.double v) { $_setDouble(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasCurrentPrice() => $_has(6);
  @$pb.TagNumber(7)
  void clearCurrentPrice() => clearField(7);

  @$pb.TagNumber(8)
  $core.double get initialValue => $_getN(7);
  @$pb.TagNumber(8)
  set initialValue($core.double v) { $_setDouble(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasInitialValue() => $_has(7);
  @$pb.TagNumber(8)
  void clearInitialValue() => clearField(8);

  @$pb.TagNumber(9)
  $core.double get gainLoss => $_getN(8);
  @$pb.TagNumber(9)
  set gainLoss($core.double v) { $_setDouble(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasGainLoss() => $_has(8);
  @$pb.TagNumber(9)
  void clearGainLoss() => clearField(9);

  @$pb.TagNumber(10)
  $core.double get gainLossPercent => $_getN(9);
  @$pb.TagNumber(10)
  set gainLossPercent($core.double v) { $_setDouble(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasGainLossPercent() => $_has(9);
  @$pb.TagNumber(10)
  void clearGainLossPercent() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get currency => $_getSZ(10);
  @$pb.TagNumber(11)
  set currency($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasCurrency() => $_has(10);
  @$pb.TagNumber(11)
  void clearCurrency() => clearField(11);

  @$pb.TagNumber(12)
  $42.Timestamp get lastUpdated => $_getN(11);
  @$pb.TagNumber(12)
  set lastUpdated($42.Timestamp v) { setField(12, v); }
  @$pb.TagNumber(12)
  $core.bool hasLastUpdated() => $_has(11);
  @$pb.TagNumber(12)
  void clearLastUpdated() => clearField(12);
  @$pb.TagNumber(12)
  $42.Timestamp ensureLastUpdated() => $_ensure(11);

  @$pb.TagNumber(13)
  $core.String get iconUrl => $_getSZ(12);
  @$pb.TagNumber(13)
  set iconUrl($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasIconUrl() => $_has(12);
  @$pb.TagNumber(13)
  void clearIconUrl() => clearField(13);
}

class PortfolioSummary extends $pb.GeneratedMessage {
  factory PortfolioSummary({
    $core.double? totalValue,
    $core.double? totalGainLoss,
    $core.double? totalGainLossPercent,
    $core.double? totalInvested,
    $core.String? currency,
    $core.Map<$core.String, $core.double>? assetsByType,
    $core.int? assetCount,
    $42.Timestamp? lastUpdated,
  }) {
    final $result = create();
    if (totalValue != null) {
      $result.totalValue = totalValue;
    }
    if (totalGainLoss != null) {
      $result.totalGainLoss = totalGainLoss;
    }
    if (totalGainLossPercent != null) {
      $result.totalGainLossPercent = totalGainLossPercent;
    }
    if (totalInvested != null) {
      $result.totalInvested = totalInvested;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (assetsByType != null) {
      $result.assetsByType.addAll(assetsByType);
    }
    if (assetCount != null) {
      $result.assetCount = assetCount;
    }
    if (lastUpdated != null) {
      $result.lastUpdated = lastUpdated;
    }
    return $result;
  }
  PortfolioSummary._() : super();
  factory PortfolioSummary.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PortfolioSummary.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PortfolioSummary', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'totalValue', $pb.PbFieldType.OD)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'totalGainLoss', $pb.PbFieldType.OD)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'totalGainLossPercent', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'totalInvested', $pb.PbFieldType.OD)
    ..aOS(5, _omitFieldNames ? '' : 'currency')
    ..m<$core.String, $core.double>(6, _omitFieldNames ? '' : 'assetsByType', entryClassName: 'PortfolioSummary.AssetsByTypeEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OD, packageName: const $pb.PackageName('pb'))
    ..a<$core.int>(7, _omitFieldNames ? '' : 'assetCount', $pb.PbFieldType.O3)
    ..aOM<$42.Timestamp>(8, _omitFieldNames ? '' : 'lastUpdated', subBuilder: $42.Timestamp.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PortfolioSummary clone() => PortfolioSummary()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PortfolioSummary copyWith(void Function(PortfolioSummary) updates) => super.copyWith((message) => updates(message as PortfolioSummary)) as PortfolioSummary;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PortfolioSummary create() => PortfolioSummary._();
  PortfolioSummary createEmptyInstance() => create();
  static $pb.PbList<PortfolioSummary> createRepeated() => $pb.PbList<PortfolioSummary>();
  @$core.pragma('dart2js:noInline')
  static PortfolioSummary getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PortfolioSummary>(create);
  static PortfolioSummary? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get totalValue => $_getN(0);
  @$pb.TagNumber(1)
  set totalValue($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTotalValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearTotalValue() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get totalGainLoss => $_getN(1);
  @$pb.TagNumber(2)
  set totalGainLoss($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotalGainLoss() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalGainLoss() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get totalGainLossPercent => $_getN(2);
  @$pb.TagNumber(3)
  set totalGainLossPercent($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTotalGainLossPercent() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalGainLossPercent() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get totalInvested => $_getN(3);
  @$pb.TagNumber(4)
  set totalInvested($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTotalInvested() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalInvested() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get currency => $_getSZ(4);
  @$pb.TagNumber(5)
  set currency($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasCurrency() => $_has(4);
  @$pb.TagNumber(5)
  void clearCurrency() => clearField(5);

  @$pb.TagNumber(6)
  $core.Map<$core.String, $core.double> get assetsByType => $_getMap(5);

  @$pb.TagNumber(7)
  $core.int get assetCount => $_getIZ(6);
  @$pb.TagNumber(7)
  set assetCount($core.int v) { $_setSignedInt32(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasAssetCount() => $_has(6);
  @$pb.TagNumber(7)
  void clearAssetCount() => clearField(7);

  @$pb.TagNumber(8)
  $42.Timestamp get lastUpdated => $_getN(7);
  @$pb.TagNumber(8)
  set lastUpdated($42.Timestamp v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasLastUpdated() => $_has(7);
  @$pb.TagNumber(8)
  void clearLastUpdated() => clearField(8);
  @$pb.TagNumber(8)
  $42.Timestamp ensureLastUpdated() => $_ensure(7);
}

/// Get Complete Portfolio Request/Response
class GetCompletePortfolioRequest extends $pb.GeneratedMessage {
  factory GetCompletePortfolioRequest() => create();
  GetCompletePortfolioRequest._() : super();
  factory GetCompletePortfolioRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCompletePortfolioRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetCompletePortfolioRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCompletePortfolioRequest clone() => GetCompletePortfolioRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCompletePortfolioRequest copyWith(void Function(GetCompletePortfolioRequest) updates) => super.copyWith((message) => updates(message as GetCompletePortfolioRequest)) as GetCompletePortfolioRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCompletePortfolioRequest create() => GetCompletePortfolioRequest._();
  GetCompletePortfolioRequest createEmptyInstance() => create();
  static $pb.PbList<GetCompletePortfolioRequest> createRepeated() => $pb.PbList<GetCompletePortfolioRequest>();
  @$core.pragma('dart2js:noInline')
  static GetCompletePortfolioRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetCompletePortfolioRequest>(create);
  static GetCompletePortfolioRequest? _defaultInstance;
}

class GetCompletePortfolioResponse extends $pb.GeneratedMessage {
  factory GetCompletePortfolioResponse({
    $core.bool? success,
    $core.String? message,
    PortfolioSummary? summary,
    $core.Iterable<PortfolioAsset>? assets,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    if (summary != null) {
      $result.summary = summary;
    }
    if (assets != null) {
      $result.assets.addAll(assets);
    }
    return $result;
  }
  GetCompletePortfolioResponse._() : super();
  factory GetCompletePortfolioResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCompletePortfolioResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetCompletePortfolioResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<PortfolioSummary>(3, _omitFieldNames ? '' : 'summary', subBuilder: PortfolioSummary.create)
    ..pc<PortfolioAsset>(4, _omitFieldNames ? '' : 'assets', $pb.PbFieldType.PM, subBuilder: PortfolioAsset.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCompletePortfolioResponse clone() => GetCompletePortfolioResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCompletePortfolioResponse copyWith(void Function(GetCompletePortfolioResponse) updates) => super.copyWith((message) => updates(message as GetCompletePortfolioResponse)) as GetCompletePortfolioResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCompletePortfolioResponse create() => GetCompletePortfolioResponse._();
  GetCompletePortfolioResponse createEmptyInstance() => create();
  static $pb.PbList<GetCompletePortfolioResponse> createRepeated() => $pb.PbList<GetCompletePortfolioResponse>();
  @$core.pragma('dart2js:noInline')
  static GetCompletePortfolioResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetCompletePortfolioResponse>(create);
  static GetCompletePortfolioResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);

  @$pb.TagNumber(3)
  PortfolioSummary get summary => $_getN(2);
  @$pb.TagNumber(3)
  set summary(PortfolioSummary v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasSummary() => $_has(2);
  @$pb.TagNumber(3)
  void clearSummary() => clearField(3);
  @$pb.TagNumber(3)
  PortfolioSummary ensureSummary() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.List<PortfolioAsset> get assets => $_getList(3);
}

/// Get Portfolio By Asset Type Request/Response
class GetPortfolioByAssetTypeRequest extends $pb.GeneratedMessage {
  factory GetPortfolioByAssetTypeRequest({
    $core.String? assetType,
  }) {
    final $result = create();
    if (assetType != null) {
      $result.assetType = assetType;
    }
    return $result;
  }
  GetPortfolioByAssetTypeRequest._() : super();
  factory GetPortfolioByAssetTypeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPortfolioByAssetTypeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetPortfolioByAssetTypeRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'assetType')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPortfolioByAssetTypeRequest clone() => GetPortfolioByAssetTypeRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPortfolioByAssetTypeRequest copyWith(void Function(GetPortfolioByAssetTypeRequest) updates) => super.copyWith((message) => updates(message as GetPortfolioByAssetTypeRequest)) as GetPortfolioByAssetTypeRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPortfolioByAssetTypeRequest create() => GetPortfolioByAssetTypeRequest._();
  GetPortfolioByAssetTypeRequest createEmptyInstance() => create();
  static $pb.PbList<GetPortfolioByAssetTypeRequest> createRepeated() => $pb.PbList<GetPortfolioByAssetTypeRequest>();
  @$core.pragma('dart2js:noInline')
  static GetPortfolioByAssetTypeRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetPortfolioByAssetTypeRequest>(create);
  static GetPortfolioByAssetTypeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get assetType => $_getSZ(0);
  @$pb.TagNumber(1)
  set assetType($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAssetType() => $_has(0);
  @$pb.TagNumber(1)
  void clearAssetType() => clearField(1);
}

class GetPortfolioByAssetTypeResponse extends $pb.GeneratedMessage {
  factory GetPortfolioByAssetTypeResponse({
    $core.bool? success,
    $core.String? message,
    $core.Iterable<PortfolioAsset>? assets,
    $core.double? totalValue,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    if (assets != null) {
      $result.assets.addAll(assets);
    }
    if (totalValue != null) {
      $result.totalValue = totalValue;
    }
    return $result;
  }
  GetPortfolioByAssetTypeResponse._() : super();
  factory GetPortfolioByAssetTypeResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPortfolioByAssetTypeResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetPortfolioByAssetTypeResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..pc<PortfolioAsset>(3, _omitFieldNames ? '' : 'assets', $pb.PbFieldType.PM, subBuilder: PortfolioAsset.create)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'totalValue', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPortfolioByAssetTypeResponse clone() => GetPortfolioByAssetTypeResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPortfolioByAssetTypeResponse copyWith(void Function(GetPortfolioByAssetTypeResponse) updates) => super.copyWith((message) => updates(message as GetPortfolioByAssetTypeResponse)) as GetPortfolioByAssetTypeResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPortfolioByAssetTypeResponse create() => GetPortfolioByAssetTypeResponse._();
  GetPortfolioByAssetTypeResponse createEmptyInstance() => create();
  static $pb.PbList<GetPortfolioByAssetTypeResponse> createRepeated() => $pb.PbList<GetPortfolioByAssetTypeResponse>();
  @$core.pragma('dart2js:noInline')
  static GetPortfolioByAssetTypeResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetPortfolioByAssetTypeResponse>(create);
  static GetPortfolioByAssetTypeResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<PortfolioAsset> get assets => $_getList(2);

  @$pb.TagNumber(4)
  $core.double get totalValue => $_getN(3);
  @$pb.TagNumber(4)
  set totalValue($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTotalValue() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalValue() => clearField(4);
}

/// Get Portfolio History Request/Response
class GetPortfolioHistoryRequest extends $pb.GeneratedMessage {
  factory GetPortfolioHistoryRequest({
    $core.String? period,
  }) {
    final $result = create();
    if (period != null) {
      $result.period = period;
    }
    return $result;
  }
  GetPortfolioHistoryRequest._() : super();
  factory GetPortfolioHistoryRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPortfolioHistoryRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetPortfolioHistoryRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'period')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPortfolioHistoryRequest clone() => GetPortfolioHistoryRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPortfolioHistoryRequest copyWith(void Function(GetPortfolioHistoryRequest) updates) => super.copyWith((message) => updates(message as GetPortfolioHistoryRequest)) as GetPortfolioHistoryRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPortfolioHistoryRequest create() => GetPortfolioHistoryRequest._();
  GetPortfolioHistoryRequest createEmptyInstance() => create();
  static $pb.PbList<GetPortfolioHistoryRequest> createRepeated() => $pb.PbList<GetPortfolioHistoryRequest>();
  @$core.pragma('dart2js:noInline')
  static GetPortfolioHistoryRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetPortfolioHistoryRequest>(create);
  static GetPortfolioHistoryRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get period => $_getSZ(0);
  @$pb.TagNumber(1)
  set period($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPeriod() => $_has(0);
  @$pb.TagNumber(1)
  void clearPeriod() => clearField(1);
}

class PortfolioHistoryPoint extends $pb.GeneratedMessage {
  factory PortfolioHistoryPoint({
    $42.Timestamp? date,
    $core.double? value,
  }) {
    final $result = create();
    if (date != null) {
      $result.date = date;
    }
    if (value != null) {
      $result.value = value;
    }
    return $result;
  }
  PortfolioHistoryPoint._() : super();
  factory PortfolioHistoryPoint.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PortfolioHistoryPoint.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PortfolioHistoryPoint', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<$42.Timestamp>(1, _omitFieldNames ? '' : 'date', subBuilder: $42.Timestamp.create)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'value', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PortfolioHistoryPoint clone() => PortfolioHistoryPoint()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PortfolioHistoryPoint copyWith(void Function(PortfolioHistoryPoint) updates) => super.copyWith((message) => updates(message as PortfolioHistoryPoint)) as PortfolioHistoryPoint;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PortfolioHistoryPoint create() => PortfolioHistoryPoint._();
  PortfolioHistoryPoint createEmptyInstance() => create();
  static $pb.PbList<PortfolioHistoryPoint> createRepeated() => $pb.PbList<PortfolioHistoryPoint>();
  @$core.pragma('dart2js:noInline')
  static PortfolioHistoryPoint getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PortfolioHistoryPoint>(create);
  static PortfolioHistoryPoint? _defaultInstance;

  @$pb.TagNumber(1)
  $42.Timestamp get date => $_getN(0);
  @$pb.TagNumber(1)
  set date($42.Timestamp v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasDate() => $_has(0);
  @$pb.TagNumber(1)
  void clearDate() => clearField(1);
  @$pb.TagNumber(1)
  $42.Timestamp ensureDate() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.double get value => $_getN(1);
  @$pb.TagNumber(2)
  set value($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearValue() => clearField(2);
}

class GetPortfolioHistoryResponse extends $pb.GeneratedMessage {
  factory GetPortfolioHistoryResponse({
    $core.bool? success,
    $core.String? message,
    $core.Iterable<PortfolioHistoryPoint>? history,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    if (history != null) {
      $result.history.addAll(history);
    }
    return $result;
  }
  GetPortfolioHistoryResponse._() : super();
  factory GetPortfolioHistoryResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPortfolioHistoryResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetPortfolioHistoryResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..pc<PortfolioHistoryPoint>(3, _omitFieldNames ? '' : 'history', $pb.PbFieldType.PM, subBuilder: PortfolioHistoryPoint.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPortfolioHistoryResponse clone() => GetPortfolioHistoryResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPortfolioHistoryResponse copyWith(void Function(GetPortfolioHistoryResponse) updates) => super.copyWith((message) => updates(message as GetPortfolioHistoryResponse)) as GetPortfolioHistoryResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPortfolioHistoryResponse create() => GetPortfolioHistoryResponse._();
  GetPortfolioHistoryResponse createEmptyInstance() => create();
  static $pb.PbList<GetPortfolioHistoryResponse> createRepeated() => $pb.PbList<GetPortfolioHistoryResponse>();
  @$core.pragma('dart2js:noInline')
  static GetPortfolioHistoryResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetPortfolioHistoryResponse>(create);
  static GetPortfolioHistoryResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<PortfolioHistoryPoint> get history => $_getList(2);
}

/// Get Portfolio Summary Request/Response
class GetPortfolioSummaryRequest extends $pb.GeneratedMessage {
  factory GetPortfolioSummaryRequest() => create();
  GetPortfolioSummaryRequest._() : super();
  factory GetPortfolioSummaryRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPortfolioSummaryRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetPortfolioSummaryRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPortfolioSummaryRequest clone() => GetPortfolioSummaryRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPortfolioSummaryRequest copyWith(void Function(GetPortfolioSummaryRequest) updates) => super.copyWith((message) => updates(message as GetPortfolioSummaryRequest)) as GetPortfolioSummaryRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPortfolioSummaryRequest create() => GetPortfolioSummaryRequest._();
  GetPortfolioSummaryRequest createEmptyInstance() => create();
  static $pb.PbList<GetPortfolioSummaryRequest> createRepeated() => $pb.PbList<GetPortfolioSummaryRequest>();
  @$core.pragma('dart2js:noInline')
  static GetPortfolioSummaryRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetPortfolioSummaryRequest>(create);
  static GetPortfolioSummaryRequest? _defaultInstance;
}

class GetPortfolioSummaryResponse extends $pb.GeneratedMessage {
  factory GetPortfolioSummaryResponse({
    $core.bool? success,
    $core.String? message,
    PortfolioSummary? summary,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    if (summary != null) {
      $result.summary = summary;
    }
    return $result;
  }
  GetPortfolioSummaryResponse._() : super();
  factory GetPortfolioSummaryResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPortfolioSummaryResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetPortfolioSummaryResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<PortfolioSummary>(3, _omitFieldNames ? '' : 'summary', subBuilder: PortfolioSummary.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPortfolioSummaryResponse clone() => GetPortfolioSummaryResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPortfolioSummaryResponse copyWith(void Function(GetPortfolioSummaryResponse) updates) => super.copyWith((message) => updates(message as GetPortfolioSummaryResponse)) as GetPortfolioSummaryResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPortfolioSummaryResponse create() => GetPortfolioSummaryResponse._();
  GetPortfolioSummaryResponse createEmptyInstance() => create();
  static $pb.PbList<GetPortfolioSummaryResponse> createRepeated() => $pb.PbList<GetPortfolioSummaryResponse>();
  @$core.pragma('dart2js:noInline')
  static GetPortfolioSummaryResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetPortfolioSummaryResponse>(create);
  static GetPortfolioSummaryResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);

  @$pb.TagNumber(3)
  PortfolioSummary get summary => $_getN(2);
  @$pb.TagNumber(3)
  set summary(PortfolioSummary v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasSummary() => $_has(2);
  @$pb.TagNumber(3)
  void clearSummary() => clearField(3);
  @$pb.TagNumber(3)
  PortfolioSummary ensureSummary() => $_ensure(2);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
