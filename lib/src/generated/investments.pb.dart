// This is a generated file - do not edit.
//
// Generated from investments.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class Investment extends $pb.GeneratedMessage {
  factory Investment({
    $core.String? id,
    $core.String? userId,
    $core.String? accountId,
    $core.String? investmentType,
    $core.String? assetSymbol,
    $core.String? assetName,
    $core.double? amountInvested,
    $core.double? quantity,
    $core.double? purchasePrice,
    $core.double? currentPrice,
    $core.double? currentValue,
    $core.double? profitLoss,
    $core.double? profitLossPercentage,
    $core.String? status,
    $core.String? metadata,
    $core.String? createdAt,
    $core.String? updatedAt,
    $core.String? closedAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (userId != null) result.userId = userId;
    if (accountId != null) result.accountId = accountId;
    if (investmentType != null) result.investmentType = investmentType;
    if (assetSymbol != null) result.assetSymbol = assetSymbol;
    if (assetName != null) result.assetName = assetName;
    if (amountInvested != null) result.amountInvested = amountInvested;
    if (quantity != null) result.quantity = quantity;
    if (purchasePrice != null) result.purchasePrice = purchasePrice;
    if (currentPrice != null) result.currentPrice = currentPrice;
    if (currentValue != null) result.currentValue = currentValue;
    if (profitLoss != null) result.profitLoss = profitLoss;
    if (profitLossPercentage != null)
      result.profitLossPercentage = profitLossPercentage;
    if (status != null) result.status = status;
    if (metadata != null) result.metadata = metadata;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    if (closedAt != null) result.closedAt = closedAt;
    return result;
  }

  Investment._();

  factory Investment.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Investment.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Investment',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'accountId')
    ..aOS(4, _omitFieldNames ? '' : 'investmentType')
    ..aOS(5, _omitFieldNames ? '' : 'assetSymbol')
    ..aOS(6, _omitFieldNames ? '' : 'assetName')
    ..a<$core.double>(
        7, _omitFieldNames ? '' : 'amountInvested', $pb.PbFieldType.OD)
    ..a<$core.double>(8, _omitFieldNames ? '' : 'quantity', $pb.PbFieldType.OD)
    ..a<$core.double>(
        9, _omitFieldNames ? '' : 'purchasePrice', $pb.PbFieldType.OD)
    ..a<$core.double>(
        10, _omitFieldNames ? '' : 'currentPrice', $pb.PbFieldType.OD)
    ..a<$core.double>(
        11, _omitFieldNames ? '' : 'currentValue', $pb.PbFieldType.OD)
    ..a<$core.double>(
        12, _omitFieldNames ? '' : 'profitLoss', $pb.PbFieldType.OD)
    ..a<$core.double>(
        13, _omitFieldNames ? '' : 'profitLossPercentage', $pb.PbFieldType.OD)
    ..aOS(14, _omitFieldNames ? '' : 'status')
    ..aOS(15, _omitFieldNames ? '' : 'metadata')
    ..aOS(16, _omitFieldNames ? '' : 'createdAt')
    ..aOS(17, _omitFieldNames ? '' : 'updatedAt')
    ..aOS(18, _omitFieldNames ? '' : 'closedAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Investment clone() => Investment()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Investment copyWith(void Function(Investment) updates) =>
      super.copyWith((message) => updates(message as Investment)) as Investment;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Investment create() => Investment._();
  @$core.override
  Investment createEmptyInstance() => create();
  static $pb.PbList<Investment> createRepeated() => $pb.PbList<Investment>();
  @$core.pragma('dart2js:noInline')
  static Investment getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Investment>(create);
  static Investment? _defaultInstance;

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
  $core.String get accountId => $_getSZ(2);
  @$pb.TagNumber(3)
  set accountId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAccountId() => $_has(2);
  @$pb.TagNumber(3)
  void clearAccountId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get investmentType => $_getSZ(3);
  @$pb.TagNumber(4)
  set investmentType($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasInvestmentType() => $_has(3);
  @$pb.TagNumber(4)
  void clearInvestmentType() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get assetSymbol => $_getSZ(4);
  @$pb.TagNumber(5)
  set assetSymbol($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasAssetSymbol() => $_has(4);
  @$pb.TagNumber(5)
  void clearAssetSymbol() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get assetName => $_getSZ(5);
  @$pb.TagNumber(6)
  set assetName($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasAssetName() => $_has(5);
  @$pb.TagNumber(6)
  void clearAssetName() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.double get amountInvested => $_getN(6);
  @$pb.TagNumber(7)
  set amountInvested($core.double value) => $_setDouble(6, value);
  @$pb.TagNumber(7)
  $core.bool hasAmountInvested() => $_has(6);
  @$pb.TagNumber(7)
  void clearAmountInvested() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.double get quantity => $_getN(7);
  @$pb.TagNumber(8)
  set quantity($core.double value) => $_setDouble(7, value);
  @$pb.TagNumber(8)
  $core.bool hasQuantity() => $_has(7);
  @$pb.TagNumber(8)
  void clearQuantity() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.double get purchasePrice => $_getN(8);
  @$pb.TagNumber(9)
  set purchasePrice($core.double value) => $_setDouble(8, value);
  @$pb.TagNumber(9)
  $core.bool hasPurchasePrice() => $_has(8);
  @$pb.TagNumber(9)
  void clearPurchasePrice() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.double get currentPrice => $_getN(9);
  @$pb.TagNumber(10)
  set currentPrice($core.double value) => $_setDouble(9, value);
  @$pb.TagNumber(10)
  $core.bool hasCurrentPrice() => $_has(9);
  @$pb.TagNumber(10)
  void clearCurrentPrice() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.double get currentValue => $_getN(10);
  @$pb.TagNumber(11)
  set currentValue($core.double value) => $_setDouble(10, value);
  @$pb.TagNumber(11)
  $core.bool hasCurrentValue() => $_has(10);
  @$pb.TagNumber(11)
  void clearCurrentValue() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.double get profitLoss => $_getN(11);
  @$pb.TagNumber(12)
  set profitLoss($core.double value) => $_setDouble(11, value);
  @$pb.TagNumber(12)
  $core.bool hasProfitLoss() => $_has(11);
  @$pb.TagNumber(12)
  void clearProfitLoss() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.double get profitLossPercentage => $_getN(12);
  @$pb.TagNumber(13)
  set profitLossPercentage($core.double value) => $_setDouble(12, value);
  @$pb.TagNumber(13)
  $core.bool hasProfitLossPercentage() => $_has(12);
  @$pb.TagNumber(13)
  void clearProfitLossPercentage() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.String get status => $_getSZ(13);
  @$pb.TagNumber(14)
  set status($core.String value) => $_setString(13, value);
  @$pb.TagNumber(14)
  $core.bool hasStatus() => $_has(13);
  @$pb.TagNumber(14)
  void clearStatus() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.String get metadata => $_getSZ(14);
  @$pb.TagNumber(15)
  set metadata($core.String value) => $_setString(14, value);
  @$pb.TagNumber(15)
  $core.bool hasMetadata() => $_has(14);
  @$pb.TagNumber(15)
  void clearMetadata() => $_clearField(15);

  @$pb.TagNumber(16)
  $core.String get createdAt => $_getSZ(15);
  @$pb.TagNumber(16)
  set createdAt($core.String value) => $_setString(15, value);
  @$pb.TagNumber(16)
  $core.bool hasCreatedAt() => $_has(15);
  @$pb.TagNumber(16)
  void clearCreatedAt() => $_clearField(16);

  @$pb.TagNumber(17)
  $core.String get updatedAt => $_getSZ(16);
  @$pb.TagNumber(17)
  set updatedAt($core.String value) => $_setString(16, value);
  @$pb.TagNumber(17)
  $core.bool hasUpdatedAt() => $_has(16);
  @$pb.TagNumber(17)
  void clearUpdatedAt() => $_clearField(17);

  @$pb.TagNumber(18)
  $core.String get closedAt => $_getSZ(17);
  @$pb.TagNumber(18)
  set closedAt($core.String value) => $_setString(17, value);
  @$pb.TagNumber(18)
  $core.bool hasClosedAt() => $_has(17);
  @$pb.TagNumber(18)
  void clearClosedAt() => $_clearField(18);
}

class StockHolding extends $pb.GeneratedMessage {
  factory StockHolding({
    $core.String? id,
    $core.String? userId,
    $core.String? stockSymbol,
    $core.String? stockName,
    $core.double? quantity,
    $core.double? averagePrice,
    $core.double? currentPrice,
    $core.double? totalValue,
    $core.double? profitLoss,
    $core.double? profitLossPercentage,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (userId != null) result.userId = userId;
    if (stockSymbol != null) result.stockSymbol = stockSymbol;
    if (stockName != null) result.stockName = stockName;
    if (quantity != null) result.quantity = quantity;
    if (averagePrice != null) result.averagePrice = averagePrice;
    if (currentPrice != null) result.currentPrice = currentPrice;
    if (totalValue != null) result.totalValue = totalValue;
    if (profitLoss != null) result.profitLoss = profitLoss;
    if (profitLossPercentage != null)
      result.profitLossPercentage = profitLossPercentage;
    return result;
  }

  StockHolding._();

  factory StockHolding.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory StockHolding.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StockHolding',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'stockSymbol')
    ..aOS(4, _omitFieldNames ? '' : 'stockName')
    ..a<$core.double>(5, _omitFieldNames ? '' : 'quantity', $pb.PbFieldType.OD)
    ..a<$core.double>(
        6, _omitFieldNames ? '' : 'averagePrice', $pb.PbFieldType.OD)
    ..a<$core.double>(
        7, _omitFieldNames ? '' : 'currentPrice', $pb.PbFieldType.OD)
    ..a<$core.double>(
        8, _omitFieldNames ? '' : 'totalValue', $pb.PbFieldType.OD)
    ..a<$core.double>(
        9, _omitFieldNames ? '' : 'profitLoss', $pb.PbFieldType.OD)
    ..a<$core.double>(
        10, _omitFieldNames ? '' : 'profitLossPercentage', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StockHolding clone() => StockHolding()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StockHolding copyWith(void Function(StockHolding) updates) =>
      super.copyWith((message) => updates(message as StockHolding))
          as StockHolding;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StockHolding create() => StockHolding._();
  @$core.override
  StockHolding createEmptyInstance() => create();
  static $pb.PbList<StockHolding> createRepeated() =>
      $pb.PbList<StockHolding>();
  @$core.pragma('dart2js:noInline')
  static StockHolding getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<StockHolding>(create);
  static StockHolding? _defaultInstance;

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
  $core.String get stockSymbol => $_getSZ(2);
  @$pb.TagNumber(3)
  set stockSymbol($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasStockSymbol() => $_has(2);
  @$pb.TagNumber(3)
  void clearStockSymbol() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get stockName => $_getSZ(3);
  @$pb.TagNumber(4)
  set stockName($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasStockName() => $_has(3);
  @$pb.TagNumber(4)
  void clearStockName() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get quantity => $_getN(4);
  @$pb.TagNumber(5)
  set quantity($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasQuantity() => $_has(4);
  @$pb.TagNumber(5)
  void clearQuantity() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.double get averagePrice => $_getN(5);
  @$pb.TagNumber(6)
  set averagePrice($core.double value) => $_setDouble(5, value);
  @$pb.TagNumber(6)
  $core.bool hasAveragePrice() => $_has(5);
  @$pb.TagNumber(6)
  void clearAveragePrice() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.double get currentPrice => $_getN(6);
  @$pb.TagNumber(7)
  set currentPrice($core.double value) => $_setDouble(6, value);
  @$pb.TagNumber(7)
  $core.bool hasCurrentPrice() => $_has(6);
  @$pb.TagNumber(7)
  void clearCurrentPrice() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.double get totalValue => $_getN(7);
  @$pb.TagNumber(8)
  set totalValue($core.double value) => $_setDouble(7, value);
  @$pb.TagNumber(8)
  $core.bool hasTotalValue() => $_has(7);
  @$pb.TagNumber(8)
  void clearTotalValue() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.double get profitLoss => $_getN(8);
  @$pb.TagNumber(9)
  set profitLoss($core.double value) => $_setDouble(8, value);
  @$pb.TagNumber(9)
  $core.bool hasProfitLoss() => $_has(8);
  @$pb.TagNumber(9)
  void clearProfitLoss() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.double get profitLossPercentage => $_getN(9);
  @$pb.TagNumber(10)
  set profitLossPercentage($core.double value) => $_setDouble(9, value);
  @$pb.TagNumber(10)
  $core.bool hasProfitLossPercentage() => $_has(9);
  @$pb.TagNumber(10)
  void clearProfitLossPercentage() => $_clearField(10);
}

class CryptoHolding extends $pb.GeneratedMessage {
  factory CryptoHolding({
    $core.String? id,
    $core.String? userId,
    $core.String? cryptoSymbol,
    $core.String? cryptoName,
    $core.double? quantity,
    $core.double? averagePrice,
    $core.double? currentPrice,
    $core.double? totalValue,
    $core.double? profitLoss,
    $core.double? profitLossPercentage,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (userId != null) result.userId = userId;
    if (cryptoSymbol != null) result.cryptoSymbol = cryptoSymbol;
    if (cryptoName != null) result.cryptoName = cryptoName;
    if (quantity != null) result.quantity = quantity;
    if (averagePrice != null) result.averagePrice = averagePrice;
    if (currentPrice != null) result.currentPrice = currentPrice;
    if (totalValue != null) result.totalValue = totalValue;
    if (profitLoss != null) result.profitLoss = profitLoss;
    if (profitLossPercentage != null)
      result.profitLossPercentage = profitLossPercentage;
    return result;
  }

  CryptoHolding._();

  factory CryptoHolding.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CryptoHolding.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CryptoHolding',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'cryptoSymbol')
    ..aOS(4, _omitFieldNames ? '' : 'cryptoName')
    ..a<$core.double>(5, _omitFieldNames ? '' : 'quantity', $pb.PbFieldType.OD)
    ..a<$core.double>(
        6, _omitFieldNames ? '' : 'averagePrice', $pb.PbFieldType.OD)
    ..a<$core.double>(
        7, _omitFieldNames ? '' : 'currentPrice', $pb.PbFieldType.OD)
    ..a<$core.double>(
        8, _omitFieldNames ? '' : 'totalValue', $pb.PbFieldType.OD)
    ..a<$core.double>(
        9, _omitFieldNames ? '' : 'profitLoss', $pb.PbFieldType.OD)
    ..a<$core.double>(
        10, _omitFieldNames ? '' : 'profitLossPercentage', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CryptoHolding clone() => CryptoHolding()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CryptoHolding copyWith(void Function(CryptoHolding) updates) =>
      super.copyWith((message) => updates(message as CryptoHolding))
          as CryptoHolding;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CryptoHolding create() => CryptoHolding._();
  @$core.override
  CryptoHolding createEmptyInstance() => create();
  static $pb.PbList<CryptoHolding> createRepeated() =>
      $pb.PbList<CryptoHolding>();
  @$core.pragma('dart2js:noInline')
  static CryptoHolding getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CryptoHolding>(create);
  static CryptoHolding? _defaultInstance;

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
  $core.String get cryptoSymbol => $_getSZ(2);
  @$pb.TagNumber(3)
  set cryptoSymbol($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCryptoSymbol() => $_has(2);
  @$pb.TagNumber(3)
  void clearCryptoSymbol() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get cryptoName => $_getSZ(3);
  @$pb.TagNumber(4)
  set cryptoName($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCryptoName() => $_has(3);
  @$pb.TagNumber(4)
  void clearCryptoName() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get quantity => $_getN(4);
  @$pb.TagNumber(5)
  set quantity($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasQuantity() => $_has(4);
  @$pb.TagNumber(5)
  void clearQuantity() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.double get averagePrice => $_getN(5);
  @$pb.TagNumber(6)
  set averagePrice($core.double value) => $_setDouble(5, value);
  @$pb.TagNumber(6)
  $core.bool hasAveragePrice() => $_has(5);
  @$pb.TagNumber(6)
  void clearAveragePrice() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.double get currentPrice => $_getN(6);
  @$pb.TagNumber(7)
  set currentPrice($core.double value) => $_setDouble(6, value);
  @$pb.TagNumber(7)
  $core.bool hasCurrentPrice() => $_has(6);
  @$pb.TagNumber(7)
  void clearCurrentPrice() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.double get totalValue => $_getN(7);
  @$pb.TagNumber(8)
  set totalValue($core.double value) => $_setDouble(7, value);
  @$pb.TagNumber(8)
  $core.bool hasTotalValue() => $_has(7);
  @$pb.TagNumber(8)
  void clearTotalValue() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.double get profitLoss => $_getN(8);
  @$pb.TagNumber(9)
  set profitLoss($core.double value) => $_setDouble(8, value);
  @$pb.TagNumber(9)
  $core.bool hasProfitLoss() => $_has(8);
  @$pb.TagNumber(9)
  void clearProfitLoss() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.double get profitLossPercentage => $_getN(9);
  @$pb.TagNumber(10)
  set profitLossPercentage($core.double value) => $_setDouble(9, value);
  @$pb.TagNumber(10)
  $core.bool hasProfitLossPercentage() => $_has(9);
  @$pb.TagNumber(10)
  void clearProfitLossPercentage() => $_clearField(10);
}

/// ===== CREATE INVESTMENT =====
/// NOTE: user_id extracted from JWT token, not from request
class CreateInvestmentRequest extends $pb.GeneratedMessage {
  factory CreateInvestmentRequest({
    $core.String? accountId,
    $core.String? investmentType,
    $core.String? assetSymbol,
    $core.double? amount,
    $core.String? duration,
    $core.String? transactionId,
    $core.String? verificationToken,
  }) {
    final result = create();
    if (accountId != null) result.accountId = accountId;
    if (investmentType != null) result.investmentType = investmentType;
    if (assetSymbol != null) result.assetSymbol = assetSymbol;
    if (amount != null) result.amount = amount;
    if (duration != null) result.duration = duration;
    if (transactionId != null) result.transactionId = transactionId;
    if (verificationToken != null) result.verificationToken = verificationToken;
    return result;
  }

  CreateInvestmentRequest._();

  factory CreateInvestmentRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateInvestmentRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateInvestmentRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..aOS(2, _omitFieldNames ? '' : 'investmentType')
    ..aOS(3, _omitFieldNames ? '' : 'assetSymbol')
    ..a<$core.double>(4, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(5, _omitFieldNames ? '' : 'duration')
    ..aOS(6, _omitFieldNames ? '' : 'transactionId')
    ..aOS(7, _omitFieldNames ? '' : 'verificationToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateInvestmentRequest clone() =>
      CreateInvestmentRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateInvestmentRequest copyWith(
          void Function(CreateInvestmentRequest) updates) =>
      super.copyWith((message) => updates(message as CreateInvestmentRequest))
          as CreateInvestmentRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateInvestmentRequest create() => CreateInvestmentRequest._();
  @$core.override
  CreateInvestmentRequest createEmptyInstance() => create();
  static $pb.PbList<CreateInvestmentRequest> createRepeated() =>
      $pb.PbList<CreateInvestmentRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateInvestmentRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateInvestmentRequest>(create);
  static CreateInvestmentRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get investmentType => $_getSZ(1);
  @$pb.TagNumber(2)
  set investmentType($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasInvestmentType() => $_has(1);
  @$pb.TagNumber(2)
  void clearInvestmentType() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get assetSymbol => $_getSZ(2);
  @$pb.TagNumber(3)
  set assetSymbol($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAssetSymbol() => $_has(2);
  @$pb.TagNumber(3)
  void clearAssetSymbol() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get amount => $_getN(3);
  @$pb.TagNumber(4)
  set amount($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearAmount() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get duration => $_getSZ(4);
  @$pb.TagNumber(5)
  set duration($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasDuration() => $_has(4);
  @$pb.TagNumber(5)
  void clearDuration() => $_clearField(5);

  /// Transaction PIN verification (replaces direct PIN field)
  @$pb.TagNumber(6)
  $core.String get transactionId => $_getSZ(5);
  @$pb.TagNumber(6)
  set transactionId($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasTransactionId() => $_has(5);
  @$pb.TagNumber(6)
  void clearTransactionId() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get verificationToken => $_getSZ(6);
  @$pb.TagNumber(7)
  set verificationToken($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasVerificationToken() => $_has(6);
  @$pb.TagNumber(7)
  void clearVerificationToken() => $_clearField(7);
}

class CreateInvestmentResponse extends $pb.GeneratedMessage {
  factory CreateInvestmentResponse({
    Investment? investment,
    $core.double? newBalance,
    $core.String? message,
  }) {
    final result = create();
    if (investment != null) result.investment = investment;
    if (newBalance != null) result.newBalance = newBalance;
    if (message != null) result.message = message;
    return result;
  }

  CreateInvestmentResponse._();

  factory CreateInvestmentResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateInvestmentResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateInvestmentResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..aOM<Investment>(1, _omitFieldNames ? '' : 'investment',
        subBuilder: Investment.create)
    ..a<$core.double>(
        2, _omitFieldNames ? '' : 'newBalance', $pb.PbFieldType.OD)
    ..aOS(3, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateInvestmentResponse clone() =>
      CreateInvestmentResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateInvestmentResponse copyWith(
          void Function(CreateInvestmentResponse) updates) =>
      super.copyWith((message) => updates(message as CreateInvestmentResponse))
          as CreateInvestmentResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateInvestmentResponse create() => CreateInvestmentResponse._();
  @$core.override
  CreateInvestmentResponse createEmptyInstance() => create();
  static $pb.PbList<CreateInvestmentResponse> createRepeated() =>
      $pb.PbList<CreateInvestmentResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateInvestmentResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateInvestmentResponse>(create);
  static CreateInvestmentResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Investment get investment => $_getN(0);
  @$pb.TagNumber(1)
  set investment(Investment value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasInvestment() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvestment() => $_clearField(1);
  @$pb.TagNumber(1)
  Investment ensureInvestment() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.double get newBalance => $_getN(1);
  @$pb.TagNumber(2)
  set newBalance($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNewBalance() => $_has(1);
  @$pb.TagNumber(2)
  void clearNewBalance() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => $_clearField(3);
}

/// ===== GET INVESTMENTS =====
/// NOTE: user_id extracted from JWT token, not from request
class GetInvestmentsRequest extends $pb.GeneratedMessage {
  factory GetInvestmentsRequest({
    $core.String? investmentType,
    $core.String? status,
    $core.int? limit,
    $core.int? offset,
  }) {
    final result = create();
    if (investmentType != null) result.investmentType = investmentType;
    if (status != null) result.status = status;
    if (limit != null) result.limit = limit;
    if (offset != null) result.offset = offset;
    return result;
  }

  GetInvestmentsRequest._();

  factory GetInvestmentsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInvestmentsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInvestmentsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'investmentType')
    ..aOS(2, _omitFieldNames ? '' : 'status')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInvestmentsRequest clone() =>
      GetInvestmentsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInvestmentsRequest copyWith(
          void Function(GetInvestmentsRequest) updates) =>
      super.copyWith((message) => updates(message as GetInvestmentsRequest))
          as GetInvestmentsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInvestmentsRequest create() => GetInvestmentsRequest._();
  @$core.override
  GetInvestmentsRequest createEmptyInstance() => create();
  static $pb.PbList<GetInvestmentsRequest> createRepeated() =>
      $pb.PbList<GetInvestmentsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInvestmentsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetInvestmentsRequest>(create);
  static GetInvestmentsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get investmentType => $_getSZ(0);
  @$pb.TagNumber(1)
  set investmentType($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasInvestmentType() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvestmentType() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get status => $_getSZ(1);
  @$pb.TagNumber(2)
  set status($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get limit => $_getIZ(2);
  @$pb.TagNumber(3)
  set limit($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLimit() => $_has(2);
  @$pb.TagNumber(3)
  void clearLimit() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get offset => $_getIZ(3);
  @$pb.TagNumber(4)
  set offset($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasOffset() => $_has(3);
  @$pb.TagNumber(4)
  void clearOffset() => $_clearField(4);
}

class GetInvestmentsResponse extends $pb.GeneratedMessage {
  factory GetInvestmentsResponse({
    $core.Iterable<Investment>? investments,
    $core.int? total,
    $core.double? totalInvested,
    $core.double? totalCurrentValue,
    $core.double? totalProfitLoss,
  }) {
    final result = create();
    if (investments != null) result.investments.addAll(investments);
    if (total != null) result.total = total;
    if (totalInvested != null) result.totalInvested = totalInvested;
    if (totalCurrentValue != null) result.totalCurrentValue = totalCurrentValue;
    if (totalProfitLoss != null) result.totalProfitLoss = totalProfitLoss;
    return result;
  }

  GetInvestmentsResponse._();

  factory GetInvestmentsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInvestmentsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInvestmentsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..pc<Investment>(
        1, _omitFieldNames ? '' : 'investments', $pb.PbFieldType.PM,
        subBuilder: Investment.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..a<$core.double>(
        3, _omitFieldNames ? '' : 'totalInvested', $pb.PbFieldType.OD)
    ..a<$core.double>(
        4, _omitFieldNames ? '' : 'totalCurrentValue', $pb.PbFieldType.OD)
    ..a<$core.double>(
        5, _omitFieldNames ? '' : 'totalProfitLoss', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInvestmentsResponse clone() =>
      GetInvestmentsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInvestmentsResponse copyWith(
          void Function(GetInvestmentsResponse) updates) =>
      super.copyWith((message) => updates(message as GetInvestmentsResponse))
          as GetInvestmentsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInvestmentsResponse create() => GetInvestmentsResponse._();
  @$core.override
  GetInvestmentsResponse createEmptyInstance() => create();
  static $pb.PbList<GetInvestmentsResponse> createRepeated() =>
      $pb.PbList<GetInvestmentsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInvestmentsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetInvestmentsResponse>(create);
  static GetInvestmentsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Investment> get investments => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get totalInvested => $_getN(2);
  @$pb.TagNumber(3)
  set totalInvested($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTotalInvested() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalInvested() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get totalCurrentValue => $_getN(3);
  @$pb.TagNumber(4)
  set totalCurrentValue($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTotalCurrentValue() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalCurrentValue() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get totalProfitLoss => $_getN(4);
  @$pb.TagNumber(5)
  set totalProfitLoss($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTotalProfitLoss() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotalProfitLoss() => $_clearField(5);
}

/// ===== GET INVESTMENT =====
/// NOTE: user_id extracted from JWT token, not from request
class GetInvestmentRequest extends $pb.GeneratedMessage {
  factory GetInvestmentRequest({
    $core.String? investmentId,
  }) {
    final result = create();
    if (investmentId != null) result.investmentId = investmentId;
    return result;
  }

  GetInvestmentRequest._();

  factory GetInvestmentRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInvestmentRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInvestmentRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'investmentId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInvestmentRequest clone() =>
      GetInvestmentRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInvestmentRequest copyWith(void Function(GetInvestmentRequest) updates) =>
      super.copyWith((message) => updates(message as GetInvestmentRequest))
          as GetInvestmentRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInvestmentRequest create() => GetInvestmentRequest._();
  @$core.override
  GetInvestmentRequest createEmptyInstance() => create();
  static $pb.PbList<GetInvestmentRequest> createRepeated() =>
      $pb.PbList<GetInvestmentRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInvestmentRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetInvestmentRequest>(create);
  static GetInvestmentRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get investmentId => $_getSZ(0);
  @$pb.TagNumber(1)
  set investmentId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasInvestmentId() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvestmentId() => $_clearField(1);
}

class GetInvestmentResponse extends $pb.GeneratedMessage {
  factory GetInvestmentResponse({
    Investment? investment,
  }) {
    final result = create();
    if (investment != null) result.investment = investment;
    return result;
  }

  GetInvestmentResponse._();

  factory GetInvestmentResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInvestmentResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInvestmentResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..aOM<Investment>(1, _omitFieldNames ? '' : 'investment',
        subBuilder: Investment.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInvestmentResponse clone() =>
      GetInvestmentResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInvestmentResponse copyWith(
          void Function(GetInvestmentResponse) updates) =>
      super.copyWith((message) => updates(message as GetInvestmentResponse))
          as GetInvestmentResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInvestmentResponse create() => GetInvestmentResponse._();
  @$core.override
  GetInvestmentResponse createEmptyInstance() => create();
  static $pb.PbList<GetInvestmentResponse> createRepeated() =>
      $pb.PbList<GetInvestmentResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInvestmentResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetInvestmentResponse>(create);
  static GetInvestmentResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Investment get investment => $_getN(0);
  @$pb.TagNumber(1)
  set investment(Investment value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasInvestment() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvestment() => $_clearField(1);
  @$pb.TagNumber(1)
  Investment ensureInvestment() => $_ensure(0);
}

/// ===== CLOSE INVESTMENT =====
/// NOTE: user_id extracted from JWT token, not from request
class CloseInvestmentRequest extends $pb.GeneratedMessage {
  factory CloseInvestmentRequest({
    $core.String? investmentId,
    $core.String? transactionId,
    $core.String? verificationToken,
  }) {
    final result = create();
    if (investmentId != null) result.investmentId = investmentId;
    if (transactionId != null) result.transactionId = transactionId;
    if (verificationToken != null) result.verificationToken = verificationToken;
    return result;
  }

  CloseInvestmentRequest._();

  factory CloseInvestmentRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CloseInvestmentRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CloseInvestmentRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'investmentId')
    ..aOS(2, _omitFieldNames ? '' : 'transactionId')
    ..aOS(3, _omitFieldNames ? '' : 'verificationToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CloseInvestmentRequest clone() =>
      CloseInvestmentRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CloseInvestmentRequest copyWith(
          void Function(CloseInvestmentRequest) updates) =>
      super.copyWith((message) => updates(message as CloseInvestmentRequest))
          as CloseInvestmentRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CloseInvestmentRequest create() => CloseInvestmentRequest._();
  @$core.override
  CloseInvestmentRequest createEmptyInstance() => create();
  static $pb.PbList<CloseInvestmentRequest> createRepeated() =>
      $pb.PbList<CloseInvestmentRequest>();
  @$core.pragma('dart2js:noInline')
  static CloseInvestmentRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CloseInvestmentRequest>(create);
  static CloseInvestmentRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get investmentId => $_getSZ(0);
  @$pb.TagNumber(1)
  set investmentId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasInvestmentId() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvestmentId() => $_clearField(1);

  /// Transaction PIN verification (replaces direct PIN field)
  @$pb.TagNumber(2)
  $core.String get transactionId => $_getSZ(1);
  @$pb.TagNumber(2)
  set transactionId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTransactionId() => $_has(1);
  @$pb.TagNumber(2)
  void clearTransactionId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get verificationToken => $_getSZ(2);
  @$pb.TagNumber(3)
  set verificationToken($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasVerificationToken() => $_has(2);
  @$pb.TagNumber(3)
  void clearVerificationToken() => $_clearField(3);
}

class CloseInvestmentResponse extends $pb.GeneratedMessage {
  factory CloseInvestmentResponse({
    Investment? investment,
    $core.double? finalValue,
    $core.double? profitLoss,
    $core.double? newBalance,
    $core.String? message,
  }) {
    final result = create();
    if (investment != null) result.investment = investment;
    if (finalValue != null) result.finalValue = finalValue;
    if (profitLoss != null) result.profitLoss = profitLoss;
    if (newBalance != null) result.newBalance = newBalance;
    if (message != null) result.message = message;
    return result;
  }

  CloseInvestmentResponse._();

  factory CloseInvestmentResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CloseInvestmentResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CloseInvestmentResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..aOM<Investment>(1, _omitFieldNames ? '' : 'investment',
        subBuilder: Investment.create)
    ..a<$core.double>(
        2, _omitFieldNames ? '' : 'finalValue', $pb.PbFieldType.OD)
    ..a<$core.double>(
        3, _omitFieldNames ? '' : 'profitLoss', $pb.PbFieldType.OD)
    ..a<$core.double>(
        4, _omitFieldNames ? '' : 'newBalance', $pb.PbFieldType.OD)
    ..aOS(5, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CloseInvestmentResponse clone() =>
      CloseInvestmentResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CloseInvestmentResponse copyWith(
          void Function(CloseInvestmentResponse) updates) =>
      super.copyWith((message) => updates(message as CloseInvestmentResponse))
          as CloseInvestmentResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CloseInvestmentResponse create() => CloseInvestmentResponse._();
  @$core.override
  CloseInvestmentResponse createEmptyInstance() => create();
  static $pb.PbList<CloseInvestmentResponse> createRepeated() =>
      $pb.PbList<CloseInvestmentResponse>();
  @$core.pragma('dart2js:noInline')
  static CloseInvestmentResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CloseInvestmentResponse>(create);
  static CloseInvestmentResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Investment get investment => $_getN(0);
  @$pb.TagNumber(1)
  set investment(Investment value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasInvestment() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvestment() => $_clearField(1);
  @$pb.TagNumber(1)
  Investment ensureInvestment() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.double get finalValue => $_getN(1);
  @$pb.TagNumber(2)
  set finalValue($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasFinalValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearFinalValue() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get profitLoss => $_getN(2);
  @$pb.TagNumber(3)
  set profitLoss($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasProfitLoss() => $_has(2);
  @$pb.TagNumber(3)
  void clearProfitLoss() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get newBalance => $_getN(3);
  @$pb.TagNumber(4)
  set newBalance($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasNewBalance() => $_has(3);
  @$pb.TagNumber(4)
  void clearNewBalance() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get message => $_getSZ(4);
  @$pb.TagNumber(5)
  set message($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasMessage() => $_has(4);
  @$pb.TagNumber(5)
  void clearMessage() => $_clearField(5);
}

/// ===== BUY STOCK =====
class BuyStockRequest extends $pb.GeneratedMessage {
  factory BuyStockRequest({
    $core.String? userId,
    $core.String? symbol,
    $core.double? quantity,
    $core.double? pricePerShare,
    $core.String? orderType,
    $core.String? transactionId,
    $core.String? verificationToken,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (symbol != null) result.symbol = symbol;
    if (quantity != null) result.quantity = quantity;
    if (pricePerShare != null) result.pricePerShare = pricePerShare;
    if (orderType != null) result.orderType = orderType;
    if (transactionId != null) result.transactionId = transactionId;
    if (verificationToken != null) result.verificationToken = verificationToken;
    return result;
  }

  BuyStockRequest._();

  factory BuyStockRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BuyStockRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BuyStockRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'symbol')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'quantity', $pb.PbFieldType.OD)
    ..a<$core.double>(
        4, _omitFieldNames ? '' : 'pricePerShare', $pb.PbFieldType.OD)
    ..aOS(5, _omitFieldNames ? '' : 'orderType')
    ..aOS(6, _omitFieldNames ? '' : 'transactionId')
    ..aOS(7, _omitFieldNames ? '' : 'verificationToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BuyStockRequest clone() => BuyStockRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BuyStockRequest copyWith(void Function(BuyStockRequest) updates) =>
      super.copyWith((message) => updates(message as BuyStockRequest))
          as BuyStockRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BuyStockRequest create() => BuyStockRequest._();
  @$core.override
  BuyStockRequest createEmptyInstance() => create();
  static $pb.PbList<BuyStockRequest> createRepeated() =>
      $pb.PbList<BuyStockRequest>();
  @$core.pragma('dart2js:noInline')
  static BuyStockRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BuyStockRequest>(create);
  static BuyStockRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get symbol => $_getSZ(1);
  @$pb.TagNumber(2)
  set symbol($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSymbol() => $_has(1);
  @$pb.TagNumber(2)
  void clearSymbol() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get quantity => $_getN(2);
  @$pb.TagNumber(3)
  set quantity($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasQuantity() => $_has(2);
  @$pb.TagNumber(3)
  void clearQuantity() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get pricePerShare => $_getN(3);
  @$pb.TagNumber(4)
  set pricePerShare($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPricePerShare() => $_has(3);
  @$pb.TagNumber(4)
  void clearPricePerShare() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get orderType => $_getSZ(4);
  @$pb.TagNumber(5)
  set orderType($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasOrderType() => $_has(4);
  @$pb.TagNumber(5)
  void clearOrderType() => $_clearField(5);

  /// Transaction PIN verification (replaces direct PIN field)
  @$pb.TagNumber(6)
  $core.String get transactionId => $_getSZ(5);
  @$pb.TagNumber(6)
  set transactionId($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasTransactionId() => $_has(5);
  @$pb.TagNumber(6)
  void clearTransactionId() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get verificationToken => $_getSZ(6);
  @$pb.TagNumber(7)
  set verificationToken($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasVerificationToken() => $_has(6);
  @$pb.TagNumber(7)
  void clearVerificationToken() => $_clearField(7);
}

class BuyStockResponse extends $pb.GeneratedMessage {
  factory BuyStockResponse({
    Trade? trade,
    Investment? investment,
    $core.double? totalCost,
    $core.double? newBalance,
    $core.String? message,
  }) {
    final result = create();
    if (trade != null) result.trade = trade;
    if (investment != null) result.investment = investment;
    if (totalCost != null) result.totalCost = totalCost;
    if (newBalance != null) result.newBalance = newBalance;
    if (message != null) result.message = message;
    return result;
  }

  BuyStockResponse._();

  factory BuyStockResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BuyStockResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BuyStockResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..aOM<Trade>(1, _omitFieldNames ? '' : 'trade', subBuilder: Trade.create)
    ..aOM<Investment>(2, _omitFieldNames ? '' : 'investment',
        subBuilder: Investment.create)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'totalCost', $pb.PbFieldType.OD)
    ..a<$core.double>(
        4, _omitFieldNames ? '' : 'newBalance', $pb.PbFieldType.OD)
    ..aOS(5, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BuyStockResponse clone() => BuyStockResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BuyStockResponse copyWith(void Function(BuyStockResponse) updates) =>
      super.copyWith((message) => updates(message as BuyStockResponse))
          as BuyStockResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BuyStockResponse create() => BuyStockResponse._();
  @$core.override
  BuyStockResponse createEmptyInstance() => create();
  static $pb.PbList<BuyStockResponse> createRepeated() =>
      $pb.PbList<BuyStockResponse>();
  @$core.pragma('dart2js:noInline')
  static BuyStockResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BuyStockResponse>(create);
  static BuyStockResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Trade get trade => $_getN(0);
  @$pb.TagNumber(1)
  set trade(Trade value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasTrade() => $_has(0);
  @$pb.TagNumber(1)
  void clearTrade() => $_clearField(1);
  @$pb.TagNumber(1)
  Trade ensureTrade() => $_ensure(0);

  @$pb.TagNumber(2)
  Investment get investment => $_getN(1);
  @$pb.TagNumber(2)
  set investment(Investment value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasInvestment() => $_has(1);
  @$pb.TagNumber(2)
  void clearInvestment() => $_clearField(2);
  @$pb.TagNumber(2)
  Investment ensureInvestment() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.double get totalCost => $_getN(2);
  @$pb.TagNumber(3)
  set totalCost($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTotalCost() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalCost() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get newBalance => $_getN(3);
  @$pb.TagNumber(4)
  set newBalance($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasNewBalance() => $_has(3);
  @$pb.TagNumber(4)
  void clearNewBalance() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get message => $_getSZ(4);
  @$pb.TagNumber(5)
  set message($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasMessage() => $_has(4);
  @$pb.TagNumber(5)
  void clearMessage() => $_clearField(5);
}

/// ===== SELL STOCK =====
class SellStockRequest extends $pb.GeneratedMessage {
  factory SellStockRequest({
    $core.String? userId,
    $core.String? symbol,
    $core.double? quantity,
    $core.double? pricePerShare,
    $core.String? orderType,
    $core.String? transactionId,
    $core.String? verificationToken,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (symbol != null) result.symbol = symbol;
    if (quantity != null) result.quantity = quantity;
    if (pricePerShare != null) result.pricePerShare = pricePerShare;
    if (orderType != null) result.orderType = orderType;
    if (transactionId != null) result.transactionId = transactionId;
    if (verificationToken != null) result.verificationToken = verificationToken;
    return result;
  }

  SellStockRequest._();

  factory SellStockRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SellStockRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SellStockRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'symbol')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'quantity', $pb.PbFieldType.OD)
    ..a<$core.double>(
        4, _omitFieldNames ? '' : 'pricePerShare', $pb.PbFieldType.OD)
    ..aOS(5, _omitFieldNames ? '' : 'orderType')
    ..aOS(6, _omitFieldNames ? '' : 'transactionId')
    ..aOS(7, _omitFieldNames ? '' : 'verificationToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SellStockRequest clone() => SellStockRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SellStockRequest copyWith(void Function(SellStockRequest) updates) =>
      super.copyWith((message) => updates(message as SellStockRequest))
          as SellStockRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SellStockRequest create() => SellStockRequest._();
  @$core.override
  SellStockRequest createEmptyInstance() => create();
  static $pb.PbList<SellStockRequest> createRepeated() =>
      $pb.PbList<SellStockRequest>();
  @$core.pragma('dart2js:noInline')
  static SellStockRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SellStockRequest>(create);
  static SellStockRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get symbol => $_getSZ(1);
  @$pb.TagNumber(2)
  set symbol($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSymbol() => $_has(1);
  @$pb.TagNumber(2)
  void clearSymbol() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get quantity => $_getN(2);
  @$pb.TagNumber(3)
  set quantity($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasQuantity() => $_has(2);
  @$pb.TagNumber(3)
  void clearQuantity() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get pricePerShare => $_getN(3);
  @$pb.TagNumber(4)
  set pricePerShare($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPricePerShare() => $_has(3);
  @$pb.TagNumber(4)
  void clearPricePerShare() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get orderType => $_getSZ(4);
  @$pb.TagNumber(5)
  set orderType($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasOrderType() => $_has(4);
  @$pb.TagNumber(5)
  void clearOrderType() => $_clearField(5);

  /// Transaction PIN verification (replaces direct PIN field)
  @$pb.TagNumber(6)
  $core.String get transactionId => $_getSZ(5);
  @$pb.TagNumber(6)
  set transactionId($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasTransactionId() => $_has(5);
  @$pb.TagNumber(6)
  void clearTransactionId() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get verificationToken => $_getSZ(6);
  @$pb.TagNumber(7)
  set verificationToken($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasVerificationToken() => $_has(6);
  @$pb.TagNumber(7)
  void clearVerificationToken() => $_clearField(7);
}

class SellStockResponse extends $pb.GeneratedMessage {
  factory SellStockResponse({
    Trade? trade,
    Investment? investment,
    $core.double? totalProceeds,
    $core.double? profitLoss,
    $core.double? newBalance,
    $core.String? message,
  }) {
    final result = create();
    if (trade != null) result.trade = trade;
    if (investment != null) result.investment = investment;
    if (totalProceeds != null) result.totalProceeds = totalProceeds;
    if (profitLoss != null) result.profitLoss = profitLoss;
    if (newBalance != null) result.newBalance = newBalance;
    if (message != null) result.message = message;
    return result;
  }

  SellStockResponse._();

  factory SellStockResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SellStockResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SellStockResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..aOM<Trade>(1, _omitFieldNames ? '' : 'trade', subBuilder: Trade.create)
    ..aOM<Investment>(2, _omitFieldNames ? '' : 'investment',
        subBuilder: Investment.create)
    ..a<$core.double>(
        3, _omitFieldNames ? '' : 'totalProceeds', $pb.PbFieldType.OD)
    ..a<$core.double>(
        4, _omitFieldNames ? '' : 'profitLoss', $pb.PbFieldType.OD)
    ..a<$core.double>(
        5, _omitFieldNames ? '' : 'newBalance', $pb.PbFieldType.OD)
    ..aOS(6, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SellStockResponse clone() => SellStockResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SellStockResponse copyWith(void Function(SellStockResponse) updates) =>
      super.copyWith((message) => updates(message as SellStockResponse))
          as SellStockResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SellStockResponse create() => SellStockResponse._();
  @$core.override
  SellStockResponse createEmptyInstance() => create();
  static $pb.PbList<SellStockResponse> createRepeated() =>
      $pb.PbList<SellStockResponse>();
  @$core.pragma('dart2js:noInline')
  static SellStockResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SellStockResponse>(create);
  static SellStockResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Trade get trade => $_getN(0);
  @$pb.TagNumber(1)
  set trade(Trade value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasTrade() => $_has(0);
  @$pb.TagNumber(1)
  void clearTrade() => $_clearField(1);
  @$pb.TagNumber(1)
  Trade ensureTrade() => $_ensure(0);

  @$pb.TagNumber(2)
  Investment get investment => $_getN(1);
  @$pb.TagNumber(2)
  set investment(Investment value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasInvestment() => $_has(1);
  @$pb.TagNumber(2)
  void clearInvestment() => $_clearField(2);
  @$pb.TagNumber(2)
  Investment ensureInvestment() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.double get totalProceeds => $_getN(2);
  @$pb.TagNumber(3)
  set totalProceeds($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTotalProceeds() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalProceeds() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get profitLoss => $_getN(3);
  @$pb.TagNumber(4)
  set profitLoss($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasProfitLoss() => $_has(3);
  @$pb.TagNumber(4)
  void clearProfitLoss() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get newBalance => $_getN(4);
  @$pb.TagNumber(5)
  set newBalance($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasNewBalance() => $_has(4);
  @$pb.TagNumber(5)
  void clearNewBalance() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get message => $_getSZ(5);
  @$pb.TagNumber(6)
  set message($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasMessage() => $_has(5);
  @$pb.TagNumber(6)
  void clearMessage() => $_clearField(6);
}

/// ===== GET STOCK QUOTE =====
class GetStockQuoteRequest extends $pb.GeneratedMessage {
  factory GetStockQuoteRequest({
    $core.String? symbol,
  }) {
    final result = create();
    if (symbol != null) result.symbol = symbol;
    return result;
  }

  GetStockQuoteRequest._();

  factory GetStockQuoteRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetStockQuoteRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetStockQuoteRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'symbol')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetStockQuoteRequest clone() =>
      GetStockQuoteRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetStockQuoteRequest copyWith(void Function(GetStockQuoteRequest) updates) =>
      super.copyWith((message) => updates(message as GetStockQuoteRequest))
          as GetStockQuoteRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetStockQuoteRequest create() => GetStockQuoteRequest._();
  @$core.override
  GetStockQuoteRequest createEmptyInstance() => create();
  static $pb.PbList<GetStockQuoteRequest> createRepeated() =>
      $pb.PbList<GetStockQuoteRequest>();
  @$core.pragma('dart2js:noInline')
  static GetStockQuoteRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetStockQuoteRequest>(create);
  static GetStockQuoteRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get symbol => $_getSZ(0);
  @$pb.TagNumber(1)
  set symbol($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSymbol() => $_has(0);
  @$pb.TagNumber(1)
  void clearSymbol() => $_clearField(1);
}

class StockQuote extends $pb.GeneratedMessage {
  factory StockQuote({
    $core.String? symbol,
    $core.String? name,
    $core.double? price,
    $core.double? change,
    $core.double? changePercent,
    $core.double? dayHigh,
    $core.double? dayLow,
    $core.double? volume,
    $core.String? marketCap,
    $core.String? timestamp,
  }) {
    final result = create();
    if (symbol != null) result.symbol = symbol;
    if (name != null) result.name = name;
    if (price != null) result.price = price;
    if (change != null) result.change = change;
    if (changePercent != null) result.changePercent = changePercent;
    if (dayHigh != null) result.dayHigh = dayHigh;
    if (dayLow != null) result.dayLow = dayLow;
    if (volume != null) result.volume = volume;
    if (marketCap != null) result.marketCap = marketCap;
    if (timestamp != null) result.timestamp = timestamp;
    return result;
  }

  StockQuote._();

  factory StockQuote.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory StockQuote.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StockQuote',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'symbol')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'price', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'change', $pb.PbFieldType.OD)
    ..a<$core.double>(
        5, _omitFieldNames ? '' : 'changePercent', $pb.PbFieldType.OD)
    ..a<$core.double>(6, _omitFieldNames ? '' : 'dayHigh', $pb.PbFieldType.OD)
    ..a<$core.double>(7, _omitFieldNames ? '' : 'dayLow', $pb.PbFieldType.OD)
    ..a<$core.double>(8, _omitFieldNames ? '' : 'volume', $pb.PbFieldType.OD)
    ..aOS(9, _omitFieldNames ? '' : 'marketCap')
    ..aOS(10, _omitFieldNames ? '' : 'timestamp')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StockQuote clone() => StockQuote()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StockQuote copyWith(void Function(StockQuote) updates) =>
      super.copyWith((message) => updates(message as StockQuote)) as StockQuote;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StockQuote create() => StockQuote._();
  @$core.override
  StockQuote createEmptyInstance() => create();
  static $pb.PbList<StockQuote> createRepeated() => $pb.PbList<StockQuote>();
  @$core.pragma('dart2js:noInline')
  static StockQuote getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<StockQuote>(create);
  static StockQuote? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get symbol => $_getSZ(0);
  @$pb.TagNumber(1)
  set symbol($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSymbol() => $_has(0);
  @$pb.TagNumber(1)
  void clearSymbol() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get price => $_getN(2);
  @$pb.TagNumber(3)
  set price($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPrice() => $_has(2);
  @$pb.TagNumber(3)
  void clearPrice() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get change => $_getN(3);
  @$pb.TagNumber(4)
  set change($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasChange() => $_has(3);
  @$pb.TagNumber(4)
  void clearChange() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get changePercent => $_getN(4);
  @$pb.TagNumber(5)
  set changePercent($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasChangePercent() => $_has(4);
  @$pb.TagNumber(5)
  void clearChangePercent() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.double get dayHigh => $_getN(5);
  @$pb.TagNumber(6)
  set dayHigh($core.double value) => $_setDouble(5, value);
  @$pb.TagNumber(6)
  $core.bool hasDayHigh() => $_has(5);
  @$pb.TagNumber(6)
  void clearDayHigh() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.double get dayLow => $_getN(6);
  @$pb.TagNumber(7)
  set dayLow($core.double value) => $_setDouble(6, value);
  @$pb.TagNumber(7)
  $core.bool hasDayLow() => $_has(6);
  @$pb.TagNumber(7)
  void clearDayLow() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.double get volume => $_getN(7);
  @$pb.TagNumber(8)
  set volume($core.double value) => $_setDouble(7, value);
  @$pb.TagNumber(8)
  $core.bool hasVolume() => $_has(7);
  @$pb.TagNumber(8)
  void clearVolume() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get marketCap => $_getSZ(8);
  @$pb.TagNumber(9)
  set marketCap($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasMarketCap() => $_has(8);
  @$pb.TagNumber(9)
  void clearMarketCap() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get timestamp => $_getSZ(9);
  @$pb.TagNumber(10)
  set timestamp($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasTimestamp() => $_has(9);
  @$pb.TagNumber(10)
  void clearTimestamp() => $_clearField(10);
}

class GetStockQuoteResponse extends $pb.GeneratedMessage {
  factory GetStockQuoteResponse({
    StockQuote? quote,
  }) {
    final result = create();
    if (quote != null) result.quote = quote;
    return result;
  }

  GetStockQuoteResponse._();

  factory GetStockQuoteResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetStockQuoteResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetStockQuoteResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..aOM<StockQuote>(1, _omitFieldNames ? '' : 'quote',
        subBuilder: StockQuote.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetStockQuoteResponse clone() =>
      GetStockQuoteResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetStockQuoteResponse copyWith(
          void Function(GetStockQuoteResponse) updates) =>
      super.copyWith((message) => updates(message as GetStockQuoteResponse))
          as GetStockQuoteResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetStockQuoteResponse create() => GetStockQuoteResponse._();
  @$core.override
  GetStockQuoteResponse createEmptyInstance() => create();
  static $pb.PbList<GetStockQuoteResponse> createRepeated() =>
      $pb.PbList<GetStockQuoteResponse>();
  @$core.pragma('dart2js:noInline')
  static GetStockQuoteResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetStockQuoteResponse>(create);
  static GetStockQuoteResponse? _defaultInstance;

  @$pb.TagNumber(1)
  StockQuote get quote => $_getN(0);
  @$pb.TagNumber(1)
  set quote(StockQuote value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasQuote() => $_has(0);
  @$pb.TagNumber(1)
  void clearQuote() => $_clearField(1);
  @$pb.TagNumber(1)
  StockQuote ensureQuote() => $_ensure(0);
}

/// ===== GET STOCK PORTFOLIO =====
class GetStockPortfolioRequest extends $pb.GeneratedMessage {
  factory GetStockPortfolioRequest() => create();

  GetStockPortfolioRequest._();

  factory GetStockPortfolioRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetStockPortfolioRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetStockPortfolioRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetStockPortfolioRequest clone() =>
      GetStockPortfolioRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetStockPortfolioRequest copyWith(
          void Function(GetStockPortfolioRequest) updates) =>
      super.copyWith((message) => updates(message as GetStockPortfolioRequest))
          as GetStockPortfolioRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetStockPortfolioRequest create() => GetStockPortfolioRequest._();
  @$core.override
  GetStockPortfolioRequest createEmptyInstance() => create();
  static $pb.PbList<GetStockPortfolioRequest> createRepeated() =>
      $pb.PbList<GetStockPortfolioRequest>();
  @$core.pragma('dart2js:noInline')
  static GetStockPortfolioRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetStockPortfolioRequest>(create);
  static GetStockPortfolioRequest? _defaultInstance;
}

class GetStockPortfolioResponse extends $pb.GeneratedMessage {
  factory GetStockPortfolioResponse({
    $core.Iterable<StockHolding>? holdings,
    $core.double? totalValue,
    $core.double? totalInvested,
    $core.double? totalProfitLoss,
    $core.double? profitLossPercentage,
  }) {
    final result = create();
    if (holdings != null) result.holdings.addAll(holdings);
    if (totalValue != null) result.totalValue = totalValue;
    if (totalInvested != null) result.totalInvested = totalInvested;
    if (totalProfitLoss != null) result.totalProfitLoss = totalProfitLoss;
    if (profitLossPercentage != null)
      result.profitLossPercentage = profitLossPercentage;
    return result;
  }

  GetStockPortfolioResponse._();

  factory GetStockPortfolioResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetStockPortfolioResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetStockPortfolioResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..pc<StockHolding>(1, _omitFieldNames ? '' : 'holdings', $pb.PbFieldType.PM,
        subBuilder: StockHolding.create)
    ..a<$core.double>(
        2, _omitFieldNames ? '' : 'totalValue', $pb.PbFieldType.OD)
    ..a<$core.double>(
        3, _omitFieldNames ? '' : 'totalInvested', $pb.PbFieldType.OD)
    ..a<$core.double>(
        4, _omitFieldNames ? '' : 'totalProfitLoss', $pb.PbFieldType.OD)
    ..a<$core.double>(
        5, _omitFieldNames ? '' : 'profitLossPercentage', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetStockPortfolioResponse clone() =>
      GetStockPortfolioResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetStockPortfolioResponse copyWith(
          void Function(GetStockPortfolioResponse) updates) =>
      super.copyWith((message) => updates(message as GetStockPortfolioResponse))
          as GetStockPortfolioResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetStockPortfolioResponse create() => GetStockPortfolioResponse._();
  @$core.override
  GetStockPortfolioResponse createEmptyInstance() => create();
  static $pb.PbList<GetStockPortfolioResponse> createRepeated() =>
      $pb.PbList<GetStockPortfolioResponse>();
  @$core.pragma('dart2js:noInline')
  static GetStockPortfolioResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetStockPortfolioResponse>(create);
  static GetStockPortfolioResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<StockHolding> get holdings => $_getList(0);

  @$pb.TagNumber(2)
  $core.double get totalValue => $_getN(1);
  @$pb.TagNumber(2)
  set totalValue($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotalValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalValue() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get totalInvested => $_getN(2);
  @$pb.TagNumber(3)
  set totalInvested($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTotalInvested() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalInvested() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get totalProfitLoss => $_getN(3);
  @$pb.TagNumber(4)
  set totalProfitLoss($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTotalProfitLoss() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalProfitLoss() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get profitLossPercentage => $_getN(4);
  @$pb.TagNumber(5)
  set profitLossPercentage($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasProfitLossPercentage() => $_has(4);
  @$pb.TagNumber(5)
  void clearProfitLossPercentage() => $_clearField(5);
}

/// ===== BUY CRYPTO =====
/// NOTE: user_id extracted from JWT token, not from request
class BuyCryptoRequest extends $pb.GeneratedMessage {
  factory BuyCryptoRequest({
    $core.String? accountId,
    $core.String? cryptoSymbol,
    $core.double? amount,
    $core.double? quantity,
    $core.double? pricePerUnit,
    $core.String? transactionId,
    $core.String? verificationToken,
  }) {
    final result = create();
    if (accountId != null) result.accountId = accountId;
    if (cryptoSymbol != null) result.cryptoSymbol = cryptoSymbol;
    if (amount != null) result.amount = amount;
    if (quantity != null) result.quantity = quantity;
    if (pricePerUnit != null) result.pricePerUnit = pricePerUnit;
    if (transactionId != null) result.transactionId = transactionId;
    if (verificationToken != null) result.verificationToken = verificationToken;
    return result;
  }

  BuyCryptoRequest._();

  factory BuyCryptoRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BuyCryptoRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BuyCryptoRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..aOS(2, _omitFieldNames ? '' : 'cryptoSymbol')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'quantity', $pb.PbFieldType.OD)
    ..a<$core.double>(
        5, _omitFieldNames ? '' : 'pricePerUnit', $pb.PbFieldType.OD)
    ..aOS(6, _omitFieldNames ? '' : 'transactionId')
    ..aOS(7, _omitFieldNames ? '' : 'verificationToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BuyCryptoRequest clone() => BuyCryptoRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BuyCryptoRequest copyWith(void Function(BuyCryptoRequest) updates) =>
      super.copyWith((message) => updates(message as BuyCryptoRequest))
          as BuyCryptoRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BuyCryptoRequest create() => BuyCryptoRequest._();
  @$core.override
  BuyCryptoRequest createEmptyInstance() => create();
  static $pb.PbList<BuyCryptoRequest> createRepeated() =>
      $pb.PbList<BuyCryptoRequest>();
  @$core.pragma('dart2js:noInline')
  static BuyCryptoRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BuyCryptoRequest>(create);
  static BuyCryptoRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get cryptoSymbol => $_getSZ(1);
  @$pb.TagNumber(2)
  set cryptoSymbol($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCryptoSymbol() => $_has(1);
  @$pb.TagNumber(2)
  void clearCryptoSymbol() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get amount => $_getN(2);
  @$pb.TagNumber(3)
  set amount($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get quantity => $_getN(3);
  @$pb.TagNumber(4)
  set quantity($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasQuantity() => $_has(3);
  @$pb.TagNumber(4)
  void clearQuantity() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get pricePerUnit => $_getN(4);
  @$pb.TagNumber(5)
  set pricePerUnit($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasPricePerUnit() => $_has(4);
  @$pb.TagNumber(5)
  void clearPricePerUnit() => $_clearField(5);

  /// Transaction PIN verification (replaces direct PIN field)
  @$pb.TagNumber(6)
  $core.String get transactionId => $_getSZ(5);
  @$pb.TagNumber(6)
  set transactionId($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasTransactionId() => $_has(5);
  @$pb.TagNumber(6)
  void clearTransactionId() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get verificationToken => $_getSZ(6);
  @$pb.TagNumber(7)
  set verificationToken($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasVerificationToken() => $_has(6);
  @$pb.TagNumber(7)
  void clearVerificationToken() => $_clearField(7);
}

class BuyCryptoResponse extends $pb.GeneratedMessage {
  factory BuyCryptoResponse({
    Investment? investment,
    $core.double? totalCost,
    $core.double? quantityPurchased,
    $core.double? newBalance,
    $core.String? message,
  }) {
    final result = create();
    if (investment != null) result.investment = investment;
    if (totalCost != null) result.totalCost = totalCost;
    if (quantityPurchased != null) result.quantityPurchased = quantityPurchased;
    if (newBalance != null) result.newBalance = newBalance;
    if (message != null) result.message = message;
    return result;
  }

  BuyCryptoResponse._();

  factory BuyCryptoResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BuyCryptoResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BuyCryptoResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..aOM<Investment>(1, _omitFieldNames ? '' : 'investment',
        subBuilder: Investment.create)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'totalCost', $pb.PbFieldType.OD)
    ..a<$core.double>(
        3, _omitFieldNames ? '' : 'quantityPurchased', $pb.PbFieldType.OD)
    ..a<$core.double>(
        4, _omitFieldNames ? '' : 'newBalance', $pb.PbFieldType.OD)
    ..aOS(5, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BuyCryptoResponse clone() => BuyCryptoResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BuyCryptoResponse copyWith(void Function(BuyCryptoResponse) updates) =>
      super.copyWith((message) => updates(message as BuyCryptoResponse))
          as BuyCryptoResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BuyCryptoResponse create() => BuyCryptoResponse._();
  @$core.override
  BuyCryptoResponse createEmptyInstance() => create();
  static $pb.PbList<BuyCryptoResponse> createRepeated() =>
      $pb.PbList<BuyCryptoResponse>();
  @$core.pragma('dart2js:noInline')
  static BuyCryptoResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BuyCryptoResponse>(create);
  static BuyCryptoResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Investment get investment => $_getN(0);
  @$pb.TagNumber(1)
  set investment(Investment value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasInvestment() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvestment() => $_clearField(1);
  @$pb.TagNumber(1)
  Investment ensureInvestment() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.double get totalCost => $_getN(1);
  @$pb.TagNumber(2)
  set totalCost($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotalCost() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalCost() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get quantityPurchased => $_getN(2);
  @$pb.TagNumber(3)
  set quantityPurchased($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasQuantityPurchased() => $_has(2);
  @$pb.TagNumber(3)
  void clearQuantityPurchased() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get newBalance => $_getN(3);
  @$pb.TagNumber(4)
  set newBalance($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasNewBalance() => $_has(3);
  @$pb.TagNumber(4)
  void clearNewBalance() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get message => $_getSZ(4);
  @$pb.TagNumber(5)
  set message($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasMessage() => $_has(4);
  @$pb.TagNumber(5)
  void clearMessage() => $_clearField(5);
}

/// ===== SELL CRYPTO =====
/// NOTE: user_id extracted from JWT token, not from request
class SellCryptoRequest extends $pb.GeneratedMessage {
  factory SellCryptoRequest({
    $core.String? accountId,
    $core.String? cryptoSymbol,
    $core.double? quantity,
    $core.double? pricePerUnit,
    $core.String? transactionId,
    $core.String? verificationToken,
  }) {
    final result = create();
    if (accountId != null) result.accountId = accountId;
    if (cryptoSymbol != null) result.cryptoSymbol = cryptoSymbol;
    if (quantity != null) result.quantity = quantity;
    if (pricePerUnit != null) result.pricePerUnit = pricePerUnit;
    if (transactionId != null) result.transactionId = transactionId;
    if (verificationToken != null) result.verificationToken = verificationToken;
    return result;
  }

  SellCryptoRequest._();

  factory SellCryptoRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SellCryptoRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SellCryptoRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..aOS(2, _omitFieldNames ? '' : 'cryptoSymbol')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'quantity', $pb.PbFieldType.OD)
    ..a<$core.double>(
        4, _omitFieldNames ? '' : 'pricePerUnit', $pb.PbFieldType.OD)
    ..aOS(5, _omitFieldNames ? '' : 'transactionId')
    ..aOS(6, _omitFieldNames ? '' : 'verificationToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SellCryptoRequest clone() => SellCryptoRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SellCryptoRequest copyWith(void Function(SellCryptoRequest) updates) =>
      super.copyWith((message) => updates(message as SellCryptoRequest))
          as SellCryptoRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SellCryptoRequest create() => SellCryptoRequest._();
  @$core.override
  SellCryptoRequest createEmptyInstance() => create();
  static $pb.PbList<SellCryptoRequest> createRepeated() =>
      $pb.PbList<SellCryptoRequest>();
  @$core.pragma('dart2js:noInline')
  static SellCryptoRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SellCryptoRequest>(create);
  static SellCryptoRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get cryptoSymbol => $_getSZ(1);
  @$pb.TagNumber(2)
  set cryptoSymbol($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCryptoSymbol() => $_has(1);
  @$pb.TagNumber(2)
  void clearCryptoSymbol() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get quantity => $_getN(2);
  @$pb.TagNumber(3)
  set quantity($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasQuantity() => $_has(2);
  @$pb.TagNumber(3)
  void clearQuantity() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get pricePerUnit => $_getN(3);
  @$pb.TagNumber(4)
  set pricePerUnit($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPricePerUnit() => $_has(3);
  @$pb.TagNumber(4)
  void clearPricePerUnit() => $_clearField(4);

  /// Transaction PIN verification (replaces direct PIN field)
  @$pb.TagNumber(5)
  $core.String get transactionId => $_getSZ(4);
  @$pb.TagNumber(5)
  set transactionId($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTransactionId() => $_has(4);
  @$pb.TagNumber(5)
  void clearTransactionId() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get verificationToken => $_getSZ(5);
  @$pb.TagNumber(6)
  set verificationToken($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasVerificationToken() => $_has(5);
  @$pb.TagNumber(6)
  void clearVerificationToken() => $_clearField(6);
}

class SellCryptoResponse extends $pb.GeneratedMessage {
  factory SellCryptoResponse({
    Investment? investment,
    $core.double? totalProceeds,
    $core.double? profitLoss,
    $core.double? newBalance,
    $core.String? message,
  }) {
    final result = create();
    if (investment != null) result.investment = investment;
    if (totalProceeds != null) result.totalProceeds = totalProceeds;
    if (profitLoss != null) result.profitLoss = profitLoss;
    if (newBalance != null) result.newBalance = newBalance;
    if (message != null) result.message = message;
    return result;
  }

  SellCryptoResponse._();

  factory SellCryptoResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SellCryptoResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SellCryptoResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..aOM<Investment>(1, _omitFieldNames ? '' : 'investment',
        subBuilder: Investment.create)
    ..a<$core.double>(
        2, _omitFieldNames ? '' : 'totalProceeds', $pb.PbFieldType.OD)
    ..a<$core.double>(
        3, _omitFieldNames ? '' : 'profitLoss', $pb.PbFieldType.OD)
    ..a<$core.double>(
        4, _omitFieldNames ? '' : 'newBalance', $pb.PbFieldType.OD)
    ..aOS(5, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SellCryptoResponse clone() => SellCryptoResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SellCryptoResponse copyWith(void Function(SellCryptoResponse) updates) =>
      super.copyWith((message) => updates(message as SellCryptoResponse))
          as SellCryptoResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SellCryptoResponse create() => SellCryptoResponse._();
  @$core.override
  SellCryptoResponse createEmptyInstance() => create();
  static $pb.PbList<SellCryptoResponse> createRepeated() =>
      $pb.PbList<SellCryptoResponse>();
  @$core.pragma('dart2js:noInline')
  static SellCryptoResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SellCryptoResponse>(create);
  static SellCryptoResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Investment get investment => $_getN(0);
  @$pb.TagNumber(1)
  set investment(Investment value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasInvestment() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvestment() => $_clearField(1);
  @$pb.TagNumber(1)
  Investment ensureInvestment() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.double get totalProceeds => $_getN(1);
  @$pb.TagNumber(2)
  set totalProceeds($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotalProceeds() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalProceeds() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get profitLoss => $_getN(2);
  @$pb.TagNumber(3)
  set profitLoss($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasProfitLoss() => $_has(2);
  @$pb.TagNumber(3)
  void clearProfitLoss() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get newBalance => $_getN(3);
  @$pb.TagNumber(4)
  set newBalance($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasNewBalance() => $_has(3);
  @$pb.TagNumber(4)
  void clearNewBalance() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get message => $_getSZ(4);
  @$pb.TagNumber(5)
  set message($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasMessage() => $_has(4);
  @$pb.TagNumber(5)
  void clearMessage() => $_clearField(5);
}

/// ===== GET CRYPTO PORTFOLIO =====
/// NOTE: user_id extracted from JWT token, not from request
class GetCryptoPortfolioRequest extends $pb.GeneratedMessage {
  factory GetCryptoPortfolioRequest() => create();

  GetCryptoPortfolioRequest._();

  factory GetCryptoPortfolioRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetCryptoPortfolioRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetCryptoPortfolioRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCryptoPortfolioRequest clone() =>
      GetCryptoPortfolioRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCryptoPortfolioRequest copyWith(
          void Function(GetCryptoPortfolioRequest) updates) =>
      super.copyWith((message) => updates(message as GetCryptoPortfolioRequest))
          as GetCryptoPortfolioRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCryptoPortfolioRequest create() => GetCryptoPortfolioRequest._();
  @$core.override
  GetCryptoPortfolioRequest createEmptyInstance() => create();
  static $pb.PbList<GetCryptoPortfolioRequest> createRepeated() =>
      $pb.PbList<GetCryptoPortfolioRequest>();
  @$core.pragma('dart2js:noInline')
  static GetCryptoPortfolioRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetCryptoPortfolioRequest>(create);
  static GetCryptoPortfolioRequest? _defaultInstance;
}

class GetCryptoPortfolioResponse extends $pb.GeneratedMessage {
  factory GetCryptoPortfolioResponse({
    $core.Iterable<CryptoHolding>? holdings,
    $core.double? totalValue,
    $core.double? totalInvested,
    $core.double? totalProfitLoss,
    $core.double? profitLossPercentage,
  }) {
    final result = create();
    if (holdings != null) result.holdings.addAll(holdings);
    if (totalValue != null) result.totalValue = totalValue;
    if (totalInvested != null) result.totalInvested = totalInvested;
    if (totalProfitLoss != null) result.totalProfitLoss = totalProfitLoss;
    if (profitLossPercentage != null)
      result.profitLossPercentage = profitLossPercentage;
    return result;
  }

  GetCryptoPortfolioResponse._();

  factory GetCryptoPortfolioResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetCryptoPortfolioResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetCryptoPortfolioResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..pc<CryptoHolding>(
        1, _omitFieldNames ? '' : 'holdings', $pb.PbFieldType.PM,
        subBuilder: CryptoHolding.create)
    ..a<$core.double>(
        2, _omitFieldNames ? '' : 'totalValue', $pb.PbFieldType.OD)
    ..a<$core.double>(
        3, _omitFieldNames ? '' : 'totalInvested', $pb.PbFieldType.OD)
    ..a<$core.double>(
        4, _omitFieldNames ? '' : 'totalProfitLoss', $pb.PbFieldType.OD)
    ..a<$core.double>(
        5, _omitFieldNames ? '' : 'profitLossPercentage', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCryptoPortfolioResponse clone() =>
      GetCryptoPortfolioResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCryptoPortfolioResponse copyWith(
          void Function(GetCryptoPortfolioResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetCryptoPortfolioResponse))
          as GetCryptoPortfolioResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCryptoPortfolioResponse create() => GetCryptoPortfolioResponse._();
  @$core.override
  GetCryptoPortfolioResponse createEmptyInstance() => create();
  static $pb.PbList<GetCryptoPortfolioResponse> createRepeated() =>
      $pb.PbList<GetCryptoPortfolioResponse>();
  @$core.pragma('dart2js:noInline')
  static GetCryptoPortfolioResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetCryptoPortfolioResponse>(create);
  static GetCryptoPortfolioResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<CryptoHolding> get holdings => $_getList(0);

  @$pb.TagNumber(2)
  $core.double get totalValue => $_getN(1);
  @$pb.TagNumber(2)
  set totalValue($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotalValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalValue() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get totalInvested => $_getN(2);
  @$pb.TagNumber(3)
  set totalInvested($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTotalInvested() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalInvested() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get totalProfitLoss => $_getN(3);
  @$pb.TagNumber(4)
  set totalProfitLoss($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTotalProfitLoss() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalProfitLoss() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get profitLossPercentage => $_getN(4);
  @$pb.TagNumber(5)
  set profitLossPercentage($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasProfitLossPercentage() => $_has(4);
  @$pb.TagNumber(5)
  void clearProfitLossPercentage() => $_clearField(5);
}

/// ===== EXCHANGE CURRENCY =====
/// NOTE: user_id extracted from JWT token, not from request
class ExchangeCurrencyRequest extends $pb.GeneratedMessage {
  factory ExchangeCurrencyRequest({
    $core.String? accountId,
    $core.String? fromCurrency,
    $core.String? toCurrency,
    $core.double? amount,
    $core.double? exchangeRate,
    $core.String? transactionId,
    $core.String? verificationToken,
  }) {
    final result = create();
    if (accountId != null) result.accountId = accountId;
    if (fromCurrency != null) result.fromCurrency = fromCurrency;
    if (toCurrency != null) result.toCurrency = toCurrency;
    if (amount != null) result.amount = amount;
    if (exchangeRate != null) result.exchangeRate = exchangeRate;
    if (transactionId != null) result.transactionId = transactionId;
    if (verificationToken != null) result.verificationToken = verificationToken;
    return result;
  }

  ExchangeCurrencyRequest._();

  factory ExchangeCurrencyRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ExchangeCurrencyRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ExchangeCurrencyRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..aOS(2, _omitFieldNames ? '' : 'fromCurrency')
    ..aOS(3, _omitFieldNames ? '' : 'toCurrency')
    ..a<$core.double>(4, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..a<$core.double>(
        5, _omitFieldNames ? '' : 'exchangeRate', $pb.PbFieldType.OD)
    ..aOS(6, _omitFieldNames ? '' : 'transactionId')
    ..aOS(7, _omitFieldNames ? '' : 'verificationToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExchangeCurrencyRequest clone() =>
      ExchangeCurrencyRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExchangeCurrencyRequest copyWith(
          void Function(ExchangeCurrencyRequest) updates) =>
      super.copyWith((message) => updates(message as ExchangeCurrencyRequest))
          as ExchangeCurrencyRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ExchangeCurrencyRequest create() => ExchangeCurrencyRequest._();
  @$core.override
  ExchangeCurrencyRequest createEmptyInstance() => create();
  static $pb.PbList<ExchangeCurrencyRequest> createRepeated() =>
      $pb.PbList<ExchangeCurrencyRequest>();
  @$core.pragma('dart2js:noInline')
  static ExchangeCurrencyRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ExchangeCurrencyRequest>(create);
  static ExchangeCurrencyRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get fromCurrency => $_getSZ(1);
  @$pb.TagNumber(2)
  set fromCurrency($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasFromCurrency() => $_has(1);
  @$pb.TagNumber(2)
  void clearFromCurrency() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get toCurrency => $_getSZ(2);
  @$pb.TagNumber(3)
  set toCurrency($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasToCurrency() => $_has(2);
  @$pb.TagNumber(3)
  void clearToCurrency() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get amount => $_getN(3);
  @$pb.TagNumber(4)
  set amount($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearAmount() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get exchangeRate => $_getN(4);
  @$pb.TagNumber(5)
  set exchangeRate($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasExchangeRate() => $_has(4);
  @$pb.TagNumber(5)
  void clearExchangeRate() => $_clearField(5);

  /// Transaction PIN verification (replaces direct PIN field)
  @$pb.TagNumber(6)
  $core.String get transactionId => $_getSZ(5);
  @$pb.TagNumber(6)
  set transactionId($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasTransactionId() => $_has(5);
  @$pb.TagNumber(6)
  void clearTransactionId() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get verificationToken => $_getSZ(6);
  @$pb.TagNumber(7)
  set verificationToken($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasVerificationToken() => $_has(6);
  @$pb.TagNumber(7)
  void clearVerificationToken() => $_clearField(7);
}

class ExchangeCurrencyResponse extends $pb.GeneratedMessage {
  factory ExchangeCurrencyResponse({
    Investment? investment,
    $core.double? amountSent,
    $core.double? amountReceived,
    $core.double? exchangeRate,
    $core.double? newBalance,
    $core.String? message,
  }) {
    final result = create();
    if (investment != null) result.investment = investment;
    if (amountSent != null) result.amountSent = amountSent;
    if (amountReceived != null) result.amountReceived = amountReceived;
    if (exchangeRate != null) result.exchangeRate = exchangeRate;
    if (newBalance != null) result.newBalance = newBalance;
    if (message != null) result.message = message;
    return result;
  }

  ExchangeCurrencyResponse._();

  factory ExchangeCurrencyResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ExchangeCurrencyResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ExchangeCurrencyResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..aOM<Investment>(1, _omitFieldNames ? '' : 'investment',
        subBuilder: Investment.create)
    ..a<$core.double>(
        2, _omitFieldNames ? '' : 'amountSent', $pb.PbFieldType.OD)
    ..a<$core.double>(
        3, _omitFieldNames ? '' : 'amountReceived', $pb.PbFieldType.OD)
    ..a<$core.double>(
        4, _omitFieldNames ? '' : 'exchangeRate', $pb.PbFieldType.OD)
    ..a<$core.double>(
        5, _omitFieldNames ? '' : 'newBalance', $pb.PbFieldType.OD)
    ..aOS(6, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExchangeCurrencyResponse clone() =>
      ExchangeCurrencyResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExchangeCurrencyResponse copyWith(
          void Function(ExchangeCurrencyResponse) updates) =>
      super.copyWith((message) => updates(message as ExchangeCurrencyResponse))
          as ExchangeCurrencyResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ExchangeCurrencyResponse create() => ExchangeCurrencyResponse._();
  @$core.override
  ExchangeCurrencyResponse createEmptyInstance() => create();
  static $pb.PbList<ExchangeCurrencyResponse> createRepeated() =>
      $pb.PbList<ExchangeCurrencyResponse>();
  @$core.pragma('dart2js:noInline')
  static ExchangeCurrencyResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ExchangeCurrencyResponse>(create);
  static ExchangeCurrencyResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Investment get investment => $_getN(0);
  @$pb.TagNumber(1)
  set investment(Investment value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasInvestment() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvestment() => $_clearField(1);
  @$pb.TagNumber(1)
  Investment ensureInvestment() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.double get amountSent => $_getN(1);
  @$pb.TagNumber(2)
  set amountSent($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAmountSent() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmountSent() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get amountReceived => $_getN(2);
  @$pb.TagNumber(3)
  set amountReceived($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAmountReceived() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmountReceived() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get exchangeRate => $_getN(3);
  @$pb.TagNumber(4)
  set exchangeRate($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasExchangeRate() => $_has(3);
  @$pb.TagNumber(4)
  void clearExchangeRate() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get newBalance => $_getN(4);
  @$pb.TagNumber(5)
  set newBalance($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasNewBalance() => $_has(4);
  @$pb.TagNumber(5)
  void clearNewBalance() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get message => $_getSZ(5);
  @$pb.TagNumber(6)
  set message($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasMessage() => $_has(5);
  @$pb.TagNumber(6)
  void clearMessage() => $_clearField(6);
}

class GetExchangeRatesRequest extends $pb.GeneratedMessage {
  factory GetExchangeRatesRequest({
    $core.String? baseCurrency,
    $core.Iterable<$core.String>? targetCurrencies,
  }) {
    final result = create();
    if (baseCurrency != null) result.baseCurrency = baseCurrency;
    if (targetCurrencies != null)
      result.targetCurrencies.addAll(targetCurrencies);
    return result;
  }

  GetExchangeRatesRequest._();

  factory GetExchangeRatesRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetExchangeRatesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetExchangeRatesRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'baseCurrency')
    ..pPS(2, _omitFieldNames ? '' : 'targetCurrencies')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetExchangeRatesRequest clone() =>
      GetExchangeRatesRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetExchangeRatesRequest copyWith(
          void Function(GetExchangeRatesRequest) updates) =>
      super.copyWith((message) => updates(message as GetExchangeRatesRequest))
          as GetExchangeRatesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetExchangeRatesRequest create() => GetExchangeRatesRequest._();
  @$core.override
  GetExchangeRatesRequest createEmptyInstance() => create();
  static $pb.PbList<GetExchangeRatesRequest> createRepeated() =>
      $pb.PbList<GetExchangeRatesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetExchangeRatesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetExchangeRatesRequest>(create);
  static GetExchangeRatesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get baseCurrency => $_getSZ(0);
  @$pb.TagNumber(1)
  set baseCurrency($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasBaseCurrency() => $_has(0);
  @$pb.TagNumber(1)
  void clearBaseCurrency() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<$core.String> get targetCurrencies => $_getList(1);
}

class ExchangeRate extends $pb.GeneratedMessage {
  factory ExchangeRate({
    $core.String? fromCurrency,
    $core.String? toCurrency,
    $core.double? rate,
    $core.String? timestamp,
  }) {
    final result = create();
    if (fromCurrency != null) result.fromCurrency = fromCurrency;
    if (toCurrency != null) result.toCurrency = toCurrency;
    if (rate != null) result.rate = rate;
    if (timestamp != null) result.timestamp = timestamp;
    return result;
  }

  ExchangeRate._();

  factory ExchangeRate.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ExchangeRate.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ExchangeRate',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'fromCurrency')
    ..aOS(2, _omitFieldNames ? '' : 'toCurrency')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'rate', $pb.PbFieldType.OD)
    ..aOS(4, _omitFieldNames ? '' : 'timestamp')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExchangeRate clone() => ExchangeRate()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExchangeRate copyWith(void Function(ExchangeRate) updates) =>
      super.copyWith((message) => updates(message as ExchangeRate))
          as ExchangeRate;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ExchangeRate create() => ExchangeRate._();
  @$core.override
  ExchangeRate createEmptyInstance() => create();
  static $pb.PbList<ExchangeRate> createRepeated() =>
      $pb.PbList<ExchangeRate>();
  @$core.pragma('dart2js:noInline')
  static ExchangeRate getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ExchangeRate>(create);
  static ExchangeRate? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fromCurrency => $_getSZ(0);
  @$pb.TagNumber(1)
  set fromCurrency($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFromCurrency() => $_has(0);
  @$pb.TagNumber(1)
  void clearFromCurrency() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get toCurrency => $_getSZ(1);
  @$pb.TagNumber(2)
  set toCurrency($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasToCurrency() => $_has(1);
  @$pb.TagNumber(2)
  void clearToCurrency() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get rate => $_getN(2);
  @$pb.TagNumber(3)
  set rate($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasRate() => $_has(2);
  @$pb.TagNumber(3)
  void clearRate() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get timestamp => $_getSZ(3);
  @$pb.TagNumber(4)
  set timestamp($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTimestamp() => $_has(3);
  @$pb.TagNumber(4)
  void clearTimestamp() => $_clearField(4);
}

class GetExchangeRatesResponse extends $pb.GeneratedMessage {
  factory GetExchangeRatesResponse({
    $core.Iterable<ExchangeRate>? rates,
    $core.String? baseCurrency,
    $core.String? timestamp,
  }) {
    final result = create();
    if (rates != null) result.rates.addAll(rates);
    if (baseCurrency != null) result.baseCurrency = baseCurrency;
    if (timestamp != null) result.timestamp = timestamp;
    return result;
  }

  GetExchangeRatesResponse._();

  factory GetExchangeRatesResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetExchangeRatesResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetExchangeRatesResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..pc<ExchangeRate>(1, _omitFieldNames ? '' : 'rates', $pb.PbFieldType.PM,
        subBuilder: ExchangeRate.create)
    ..aOS(2, _omitFieldNames ? '' : 'baseCurrency')
    ..aOS(3, _omitFieldNames ? '' : 'timestamp')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetExchangeRatesResponse clone() =>
      GetExchangeRatesResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetExchangeRatesResponse copyWith(
          void Function(GetExchangeRatesResponse) updates) =>
      super.copyWith((message) => updates(message as GetExchangeRatesResponse))
          as GetExchangeRatesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetExchangeRatesResponse create() => GetExchangeRatesResponse._();
  @$core.override
  GetExchangeRatesResponse createEmptyInstance() => create();
  static $pb.PbList<GetExchangeRatesResponse> createRepeated() =>
      $pb.PbList<GetExchangeRatesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetExchangeRatesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetExchangeRatesResponse>(create);
  static GetExchangeRatesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<ExchangeRate> get rates => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get baseCurrency => $_getSZ(1);
  @$pb.TagNumber(2)
  set baseCurrency($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasBaseCurrency() => $_has(1);
  @$pb.TagNumber(2)
  void clearBaseCurrency() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get timestamp => $_getSZ(2);
  @$pb.TagNumber(3)
  set timestamp($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTimestamp() => $_has(2);
  @$pb.TagNumber(3)
  void clearTimestamp() => $_clearField(3);
}

/// ===== GET PORTFOLIO =====
class GetPortfolioRequest extends $pb.GeneratedMessage {
  factory GetPortfolioRequest({
    $core.String? userId,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    return result;
  }

  GetPortfolioRequest._();

  factory GetPortfolioRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetPortfolioRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetPortfolioRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPortfolioRequest clone() => GetPortfolioRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPortfolioRequest copyWith(void Function(GetPortfolioRequest) updates) =>
      super.copyWith((message) => updates(message as GetPortfolioRequest))
          as GetPortfolioRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPortfolioRequest create() => GetPortfolioRequest._();
  @$core.override
  GetPortfolioRequest createEmptyInstance() => create();
  static $pb.PbList<GetPortfolioRequest> createRepeated() =>
      $pb.PbList<GetPortfolioRequest>();
  @$core.pragma('dart2js:noInline')
  static GetPortfolioRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetPortfolioRequest>(create);
  static GetPortfolioRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);
}

class Portfolio extends $pb.GeneratedMessage {
  factory Portfolio({
    $core.double? totalValue,
    $core.Iterable<Position>? positions,
  }) {
    final result = create();
    if (totalValue != null) result.totalValue = totalValue;
    if (positions != null) result.positions.addAll(positions);
    return result;
  }

  Portfolio._();

  factory Portfolio.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Portfolio.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Portfolio',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..a<$core.double>(
        1, _omitFieldNames ? '' : 'totalValue', $pb.PbFieldType.OD)
    ..pc<Position>(2, _omitFieldNames ? '' : 'positions', $pb.PbFieldType.PM,
        subBuilder: Position.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Portfolio clone() => Portfolio()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Portfolio copyWith(void Function(Portfolio) updates) =>
      super.copyWith((message) => updates(message as Portfolio)) as Portfolio;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Portfolio create() => Portfolio._();
  @$core.override
  Portfolio createEmptyInstance() => create();
  static $pb.PbList<Portfolio> createRepeated() => $pb.PbList<Portfolio>();
  @$core.pragma('dart2js:noInline')
  static Portfolio getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Portfolio>(create);
  static Portfolio? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get totalValue => $_getN(0);
  @$pb.TagNumber(1)
  set totalValue($core.double value) => $_setDouble(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTotalValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearTotalValue() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<Position> get positions => $_getList(1);
}

class Position extends $pb.GeneratedMessage {
  factory Position({
    $core.String? symbol,
    $core.String? name,
    $core.double? quantity,
    $core.double? currentPrice,
    $core.double? currentValue,
    $core.double? profitLoss,
    $core.double? profitLossPercentage,
  }) {
    final result = create();
    if (symbol != null) result.symbol = symbol;
    if (name != null) result.name = name;
    if (quantity != null) result.quantity = quantity;
    if (currentPrice != null) result.currentPrice = currentPrice;
    if (currentValue != null) result.currentValue = currentValue;
    if (profitLoss != null) result.profitLoss = profitLoss;
    if (profitLossPercentage != null)
      result.profitLossPercentage = profitLossPercentage;
    return result;
  }

  Position._();

  factory Position.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Position.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Position',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'symbol')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'quantity', $pb.PbFieldType.OD)
    ..a<$core.double>(
        4, _omitFieldNames ? '' : 'currentPrice', $pb.PbFieldType.OD)
    ..a<$core.double>(
        5, _omitFieldNames ? '' : 'currentValue', $pb.PbFieldType.OD)
    ..a<$core.double>(
        6, _omitFieldNames ? '' : 'profitLoss', $pb.PbFieldType.OD)
    ..a<$core.double>(
        7, _omitFieldNames ? '' : 'profitLossPercentage', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Position clone() => Position()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Position copyWith(void Function(Position) updates) =>
      super.copyWith((message) => updates(message as Position)) as Position;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Position create() => Position._();
  @$core.override
  Position createEmptyInstance() => create();
  static $pb.PbList<Position> createRepeated() => $pb.PbList<Position>();
  @$core.pragma('dart2js:noInline')
  static Position getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Position>(create);
  static Position? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get symbol => $_getSZ(0);
  @$pb.TagNumber(1)
  set symbol($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSymbol() => $_has(0);
  @$pb.TagNumber(1)
  void clearSymbol() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get quantity => $_getN(2);
  @$pb.TagNumber(3)
  set quantity($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasQuantity() => $_has(2);
  @$pb.TagNumber(3)
  void clearQuantity() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get currentPrice => $_getN(3);
  @$pb.TagNumber(4)
  set currentPrice($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCurrentPrice() => $_has(3);
  @$pb.TagNumber(4)
  void clearCurrentPrice() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get currentValue => $_getN(4);
  @$pb.TagNumber(5)
  set currentValue($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCurrentValue() => $_has(4);
  @$pb.TagNumber(5)
  void clearCurrentValue() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.double get profitLoss => $_getN(5);
  @$pb.TagNumber(6)
  set profitLoss($core.double value) => $_setDouble(5, value);
  @$pb.TagNumber(6)
  $core.bool hasProfitLoss() => $_has(5);
  @$pb.TagNumber(6)
  void clearProfitLoss() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.double get profitLossPercentage => $_getN(6);
  @$pb.TagNumber(7)
  set profitLossPercentage($core.double value) => $_setDouble(6, value);
  @$pb.TagNumber(7)
  $core.bool hasProfitLossPercentage() => $_has(6);
  @$pb.TagNumber(7)
  void clearProfitLossPercentage() => $_clearField(7);
}

class GetPortfolioResponse extends $pb.GeneratedMessage {
  factory GetPortfolioResponse({
    Portfolio? portfolio,
    $core.Iterable<StockHolding>? stocks,
    $core.Iterable<CryptoHolding>? crypto,
    $core.Iterable<Investment>? otherInvestments,
    $core.double? totalPortfolioValue,
    $core.double? totalInvested,
    $core.double? totalProfitLoss,
    $core.double? profitLossPercentage,
  }) {
    final result = create();
    if (portfolio != null) result.portfolio = portfolio;
    if (stocks != null) result.stocks.addAll(stocks);
    if (crypto != null) result.crypto.addAll(crypto);
    if (otherInvestments != null)
      result.otherInvestments.addAll(otherInvestments);
    if (totalPortfolioValue != null)
      result.totalPortfolioValue = totalPortfolioValue;
    if (totalInvested != null) result.totalInvested = totalInvested;
    if (totalProfitLoss != null) result.totalProfitLoss = totalProfitLoss;
    if (profitLossPercentage != null)
      result.profitLossPercentage = profitLossPercentage;
    return result;
  }

  GetPortfolioResponse._();

  factory GetPortfolioResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetPortfolioResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetPortfolioResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..aOM<Portfolio>(1, _omitFieldNames ? '' : 'portfolio',
        subBuilder: Portfolio.create)
    ..pc<StockHolding>(2, _omitFieldNames ? '' : 'stocks', $pb.PbFieldType.PM,
        subBuilder: StockHolding.create)
    ..pc<CryptoHolding>(3, _omitFieldNames ? '' : 'crypto', $pb.PbFieldType.PM,
        subBuilder: CryptoHolding.create)
    ..pc<Investment>(
        4, _omitFieldNames ? '' : 'otherInvestments', $pb.PbFieldType.PM,
        subBuilder: Investment.create)
    ..a<$core.double>(
        5, _omitFieldNames ? '' : 'totalPortfolioValue', $pb.PbFieldType.OD)
    ..a<$core.double>(
        6, _omitFieldNames ? '' : 'totalInvested', $pb.PbFieldType.OD)
    ..a<$core.double>(
        7, _omitFieldNames ? '' : 'totalProfitLoss', $pb.PbFieldType.OD)
    ..a<$core.double>(
        8, _omitFieldNames ? '' : 'profitLossPercentage', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPortfolioResponse clone() =>
      GetPortfolioResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPortfolioResponse copyWith(void Function(GetPortfolioResponse) updates) =>
      super.copyWith((message) => updates(message as GetPortfolioResponse))
          as GetPortfolioResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPortfolioResponse create() => GetPortfolioResponse._();
  @$core.override
  GetPortfolioResponse createEmptyInstance() => create();
  static $pb.PbList<GetPortfolioResponse> createRepeated() =>
      $pb.PbList<GetPortfolioResponse>();
  @$core.pragma('dart2js:noInline')
  static GetPortfolioResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetPortfolioResponse>(create);
  static GetPortfolioResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Portfolio get portfolio => $_getN(0);
  @$pb.TagNumber(1)
  set portfolio(Portfolio value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasPortfolio() => $_has(0);
  @$pb.TagNumber(1)
  void clearPortfolio() => $_clearField(1);
  @$pb.TagNumber(1)
  Portfolio ensurePortfolio() => $_ensure(0);

  @$pb.TagNumber(2)
  $pb.PbList<StockHolding> get stocks => $_getList(1);

  @$pb.TagNumber(3)
  $pb.PbList<CryptoHolding> get crypto => $_getList(2);

  @$pb.TagNumber(4)
  $pb.PbList<Investment> get otherInvestments => $_getList(3);

  @$pb.TagNumber(5)
  $core.double get totalPortfolioValue => $_getN(4);
  @$pb.TagNumber(5)
  set totalPortfolioValue($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTotalPortfolioValue() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotalPortfolioValue() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.double get totalInvested => $_getN(5);
  @$pb.TagNumber(6)
  set totalInvested($core.double value) => $_setDouble(5, value);
  @$pb.TagNumber(6)
  $core.bool hasTotalInvested() => $_has(5);
  @$pb.TagNumber(6)
  void clearTotalInvested() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.double get totalProfitLoss => $_getN(6);
  @$pb.TagNumber(7)
  set totalProfitLoss($core.double value) => $_setDouble(6, value);
  @$pb.TagNumber(7)
  $core.bool hasTotalProfitLoss() => $_has(6);
  @$pb.TagNumber(7)
  void clearTotalProfitLoss() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.double get profitLossPercentage => $_getN(7);
  @$pb.TagNumber(8)
  set profitLossPercentage($core.double value) => $_setDouble(7, value);
  @$pb.TagNumber(8)
  $core.bool hasProfitLossPercentage() => $_has(7);
  @$pb.TagNumber(8)
  void clearProfitLossPercentage() => $_clearField(8);
}

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
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
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
    $fixnum.Int64? timestamp,
    $core.double? value,
  }) {
    final result = create();
    if (timestamp != null) result.timestamp = timestamp;
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
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'timestamp')
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
  $fixnum.Int64 get timestamp => $_getI64(0);
  @$pb.TagNumber(1)
  set timestamp($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTimestamp() => $_has(0);
  @$pb.TagNumber(1)
  void clearTimestamp() => $_clearField(1);

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
    $core.Iterable<PortfolioHistoryPoint>? history,
  }) {
    final result = create();
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
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..pc<PortfolioHistoryPoint>(
        1, _omitFieldNames ? '' : 'history', $pb.PbFieldType.PM,
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
  $pb.PbList<PortfolioHistoryPoint> get history => $_getList(0);
}

class GetMarketPricesRequest extends $pb.GeneratedMessage {
  factory GetMarketPricesRequest({
    $core.Iterable<$core.String>? stockSymbols,
    $core.Iterable<$core.String>? cryptoSymbols,
  }) {
    final result = create();
    if (stockSymbols != null) result.stockSymbols.addAll(stockSymbols);
    if (cryptoSymbols != null) result.cryptoSymbols.addAll(cryptoSymbols);
    return result;
  }

  GetMarketPricesRequest._();

  factory GetMarketPricesRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMarketPricesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMarketPricesRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'stockSymbols')
    ..pPS(2, _omitFieldNames ? '' : 'cryptoSymbols')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMarketPricesRequest clone() =>
      GetMarketPricesRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMarketPricesRequest copyWith(
          void Function(GetMarketPricesRequest) updates) =>
      super.copyWith((message) => updates(message as GetMarketPricesRequest))
          as GetMarketPricesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMarketPricesRequest create() => GetMarketPricesRequest._();
  @$core.override
  GetMarketPricesRequest createEmptyInstance() => create();
  static $pb.PbList<GetMarketPricesRequest> createRepeated() =>
      $pb.PbList<GetMarketPricesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMarketPricesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMarketPricesRequest>(create);
  static GetMarketPricesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$core.String> get stockSymbols => $_getList(0);

  @$pb.TagNumber(2)
  $pb.PbList<$core.String> get cryptoSymbols => $_getList(1);
}

class MarketPrice extends $pb.GeneratedMessage {
  factory MarketPrice({
    $core.String? symbol,
    $core.String? name,
    $core.double? price,
    $core.double? change24h,
    $core.double? changePercentage,
    $core.String? timestamp,
  }) {
    final result = create();
    if (symbol != null) result.symbol = symbol;
    if (name != null) result.name = name;
    if (price != null) result.price = price;
    if (change24h != null) result.change24h = change24h;
    if (changePercentage != null) result.changePercentage = changePercentage;
    if (timestamp != null) result.timestamp = timestamp;
    return result;
  }

  MarketPrice._();

  factory MarketPrice.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MarketPrice.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MarketPrice',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'symbol')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'price', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'change24h', $pb.PbFieldType.OD,
        protoName: 'change_24h')
    ..a<$core.double>(
        5, _omitFieldNames ? '' : 'changePercentage', $pb.PbFieldType.OD)
    ..aOS(6, _omitFieldNames ? '' : 'timestamp')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MarketPrice clone() => MarketPrice()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MarketPrice copyWith(void Function(MarketPrice) updates) =>
      super.copyWith((message) => updates(message as MarketPrice))
          as MarketPrice;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MarketPrice create() => MarketPrice._();
  @$core.override
  MarketPrice createEmptyInstance() => create();
  static $pb.PbList<MarketPrice> createRepeated() => $pb.PbList<MarketPrice>();
  @$core.pragma('dart2js:noInline')
  static MarketPrice getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MarketPrice>(create);
  static MarketPrice? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get symbol => $_getSZ(0);
  @$pb.TagNumber(1)
  set symbol($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSymbol() => $_has(0);
  @$pb.TagNumber(1)
  void clearSymbol() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get price => $_getN(2);
  @$pb.TagNumber(3)
  set price($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPrice() => $_has(2);
  @$pb.TagNumber(3)
  void clearPrice() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get change24h => $_getN(3);
  @$pb.TagNumber(4)
  set change24h($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasChange24h() => $_has(3);
  @$pb.TagNumber(4)
  void clearChange24h() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get changePercentage => $_getN(4);
  @$pb.TagNumber(5)
  set changePercentage($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasChangePercentage() => $_has(4);
  @$pb.TagNumber(5)
  void clearChangePercentage() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get timestamp => $_getSZ(5);
  @$pb.TagNumber(6)
  set timestamp($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasTimestamp() => $_has(5);
  @$pb.TagNumber(6)
  void clearTimestamp() => $_clearField(6);
}

class GetMarketPricesResponse extends $pb.GeneratedMessage {
  factory GetMarketPricesResponse({
    $core.Iterable<MarketPrice>? stockPrices,
    $core.Iterable<MarketPrice>? cryptoPrices,
    $core.String? timestamp,
  }) {
    final result = create();
    if (stockPrices != null) result.stockPrices.addAll(stockPrices);
    if (cryptoPrices != null) result.cryptoPrices.addAll(cryptoPrices);
    if (timestamp != null) result.timestamp = timestamp;
    return result;
  }

  GetMarketPricesResponse._();

  factory GetMarketPricesResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMarketPricesResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMarketPricesResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..pc<MarketPrice>(
        1, _omitFieldNames ? '' : 'stockPrices', $pb.PbFieldType.PM,
        subBuilder: MarketPrice.create)
    ..pc<MarketPrice>(
        2, _omitFieldNames ? '' : 'cryptoPrices', $pb.PbFieldType.PM,
        subBuilder: MarketPrice.create)
    ..aOS(3, _omitFieldNames ? '' : 'timestamp')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMarketPricesResponse clone() =>
      GetMarketPricesResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMarketPricesResponse copyWith(
          void Function(GetMarketPricesResponse) updates) =>
      super.copyWith((message) => updates(message as GetMarketPricesResponse))
          as GetMarketPricesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMarketPricesResponse create() => GetMarketPricesResponse._();
  @$core.override
  GetMarketPricesResponse createEmptyInstance() => create();
  static $pb.PbList<GetMarketPricesResponse> createRepeated() =>
      $pb.PbList<GetMarketPricesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMarketPricesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMarketPricesResponse>(create);
  static GetMarketPricesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<MarketPrice> get stockPrices => $_getList(0);

  @$pb.TagNumber(2)
  $pb.PbList<MarketPrice> get cryptoPrices => $_getList(1);

  @$pb.TagNumber(3)
  $core.String get timestamp => $_getSZ(2);
  @$pb.TagNumber(3)
  set timestamp($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTimestamp() => $_has(2);
  @$pb.TagNumber(3)
  void clearTimestamp() => $_clearField(3);
}

class GetInvestmentHistoryRequest extends $pb.GeneratedMessage {
  factory GetInvestmentHistoryRequest({
    $core.String? userId,
    $core.String? investmentType,
    $core.String? startDate,
    $core.String? endDate,
    $core.int? limit,
    $core.int? offset,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (investmentType != null) result.investmentType = investmentType;
    if (startDate != null) result.startDate = startDate;
    if (endDate != null) result.endDate = endDate;
    if (limit != null) result.limit = limit;
    if (offset != null) result.offset = offset;
    return result;
  }

  GetInvestmentHistoryRequest._();

  factory GetInvestmentHistoryRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInvestmentHistoryRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInvestmentHistoryRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'investmentType')
    ..aOS(3, _omitFieldNames ? '' : 'startDate')
    ..aOS(4, _omitFieldNames ? '' : 'endDate')
    ..a<$core.int>(5, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(6, _omitFieldNames ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInvestmentHistoryRequest clone() =>
      GetInvestmentHistoryRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInvestmentHistoryRequest copyWith(
          void Function(GetInvestmentHistoryRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetInvestmentHistoryRequest))
          as GetInvestmentHistoryRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInvestmentHistoryRequest create() =>
      GetInvestmentHistoryRequest._();
  @$core.override
  GetInvestmentHistoryRequest createEmptyInstance() => create();
  static $pb.PbList<GetInvestmentHistoryRequest> createRepeated() =>
      $pb.PbList<GetInvestmentHistoryRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInvestmentHistoryRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetInvestmentHistoryRequest>(create);
  static GetInvestmentHistoryRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get investmentType => $_getSZ(1);
  @$pb.TagNumber(2)
  set investmentType($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasInvestmentType() => $_has(1);
  @$pb.TagNumber(2)
  void clearInvestmentType() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get startDate => $_getSZ(2);
  @$pb.TagNumber(3)
  set startDate($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasStartDate() => $_has(2);
  @$pb.TagNumber(3)
  void clearStartDate() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get endDate => $_getSZ(3);
  @$pb.TagNumber(4)
  set endDate($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasEndDate() => $_has(3);
  @$pb.TagNumber(4)
  void clearEndDate() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get limit => $_getIZ(4);
  @$pb.TagNumber(5)
  set limit($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasLimit() => $_has(4);
  @$pb.TagNumber(5)
  void clearLimit() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get offset => $_getIZ(5);
  @$pb.TagNumber(6)
  set offset($core.int value) => $_setSignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasOffset() => $_has(5);
  @$pb.TagNumber(6)
  void clearOffset() => $_clearField(6);
}

class GetInvestmentHistoryResponse extends $pb.GeneratedMessage {
  factory GetInvestmentHistoryResponse({
    $core.Iterable<Investment>? investments,
    $core.int? total,
  }) {
    final result = create();
    if (investments != null) result.investments.addAll(investments);
    if (total != null) result.total = total;
    return result;
  }

  GetInvestmentHistoryResponse._();

  factory GetInvestmentHistoryResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetInvestmentHistoryResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetInvestmentHistoryResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..pc<Investment>(
        1, _omitFieldNames ? '' : 'investments', $pb.PbFieldType.PM,
        subBuilder: Investment.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInvestmentHistoryResponse clone() =>
      GetInvestmentHistoryResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetInvestmentHistoryResponse copyWith(
          void Function(GetInvestmentHistoryResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetInvestmentHistoryResponse))
          as GetInvestmentHistoryResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInvestmentHistoryResponse create() =>
      GetInvestmentHistoryResponse._();
  @$core.override
  GetInvestmentHistoryResponse createEmptyInstance() => create();
  static $pb.PbList<GetInvestmentHistoryResponse> createRepeated() =>
      $pb.PbList<GetInvestmentHistoryResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInvestmentHistoryResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetInvestmentHistoryResponse>(create);
  static GetInvestmentHistoryResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Investment> get investments => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);
}

/// ===== TRADE MODEL =====
class Trade extends $pb.GeneratedMessage {
  factory Trade({
    $core.String? tradeId,
    $core.String? userId,
    $core.String? accountId,
    $core.String? symbol,
    $core.String? tradeType,
    $core.double? quantity,
    $core.double? pricePerShare,
    $core.double? totalValue,
    $core.double? fee,
    $core.String? currency,
    $core.String? status,
    $core.String? orderType,
    $core.double? limitPrice,
    $core.String? createdAt,
    $core.String? completedAt,
    $core.String? failureReason,
  }) {
    final result = create();
    if (tradeId != null) result.tradeId = tradeId;
    if (userId != null) result.userId = userId;
    if (accountId != null) result.accountId = accountId;
    if (symbol != null) result.symbol = symbol;
    if (tradeType != null) result.tradeType = tradeType;
    if (quantity != null) result.quantity = quantity;
    if (pricePerShare != null) result.pricePerShare = pricePerShare;
    if (totalValue != null) result.totalValue = totalValue;
    if (fee != null) result.fee = fee;
    if (currency != null) result.currency = currency;
    if (status != null) result.status = status;
    if (orderType != null) result.orderType = orderType;
    if (limitPrice != null) result.limitPrice = limitPrice;
    if (createdAt != null) result.createdAt = createdAt;
    if (completedAt != null) result.completedAt = completedAt;
    if (failureReason != null) result.failureReason = failureReason;
    return result;
  }

  Trade._();

  factory Trade.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Trade.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Trade',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'tradeId')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'accountId')
    ..aOS(4, _omitFieldNames ? '' : 'symbol')
    ..aOS(5, _omitFieldNames ? '' : 'tradeType')
    ..a<$core.double>(6, _omitFieldNames ? '' : 'quantity', $pb.PbFieldType.OD)
    ..a<$core.double>(
        7, _omitFieldNames ? '' : 'pricePerShare', $pb.PbFieldType.OD)
    ..a<$core.double>(
        8, _omitFieldNames ? '' : 'totalValue', $pb.PbFieldType.OD)
    ..a<$core.double>(9, _omitFieldNames ? '' : 'fee', $pb.PbFieldType.OD)
    ..aOS(10, _omitFieldNames ? '' : 'currency')
    ..aOS(11, _omitFieldNames ? '' : 'status')
    ..aOS(12, _omitFieldNames ? '' : 'orderType')
    ..a<$core.double>(
        13, _omitFieldNames ? '' : 'limitPrice', $pb.PbFieldType.OD)
    ..aOS(14, _omitFieldNames ? '' : 'createdAt')
    ..aOS(15, _omitFieldNames ? '' : 'completedAt')
    ..aOS(16, _omitFieldNames ? '' : 'failureReason')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Trade clone() => Trade()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Trade copyWith(void Function(Trade) updates) =>
      super.copyWith((message) => updates(message as Trade)) as Trade;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Trade create() => Trade._();
  @$core.override
  Trade createEmptyInstance() => create();
  static $pb.PbList<Trade> createRepeated() => $pb.PbList<Trade>();
  @$core.pragma('dart2js:noInline')
  static Trade getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Trade>(create);
  static Trade? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get tradeId => $_getSZ(0);
  @$pb.TagNumber(1)
  set tradeId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTradeId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTradeId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get accountId => $_getSZ(2);
  @$pb.TagNumber(3)
  set accountId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAccountId() => $_has(2);
  @$pb.TagNumber(3)
  void clearAccountId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get symbol => $_getSZ(3);
  @$pb.TagNumber(4)
  set symbol($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasSymbol() => $_has(3);
  @$pb.TagNumber(4)
  void clearSymbol() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get tradeType => $_getSZ(4);
  @$pb.TagNumber(5)
  set tradeType($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTradeType() => $_has(4);
  @$pb.TagNumber(5)
  void clearTradeType() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.double get quantity => $_getN(5);
  @$pb.TagNumber(6)
  set quantity($core.double value) => $_setDouble(5, value);
  @$pb.TagNumber(6)
  $core.bool hasQuantity() => $_has(5);
  @$pb.TagNumber(6)
  void clearQuantity() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.double get pricePerShare => $_getN(6);
  @$pb.TagNumber(7)
  set pricePerShare($core.double value) => $_setDouble(6, value);
  @$pb.TagNumber(7)
  $core.bool hasPricePerShare() => $_has(6);
  @$pb.TagNumber(7)
  void clearPricePerShare() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.double get totalValue => $_getN(7);
  @$pb.TagNumber(8)
  set totalValue($core.double value) => $_setDouble(7, value);
  @$pb.TagNumber(8)
  $core.bool hasTotalValue() => $_has(7);
  @$pb.TagNumber(8)
  void clearTotalValue() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.double get fee => $_getN(8);
  @$pb.TagNumber(9)
  set fee($core.double value) => $_setDouble(8, value);
  @$pb.TagNumber(9)
  $core.bool hasFee() => $_has(8);
  @$pb.TagNumber(9)
  void clearFee() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get currency => $_getSZ(9);
  @$pb.TagNumber(10)
  set currency($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasCurrency() => $_has(9);
  @$pb.TagNumber(10)
  void clearCurrency() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get status => $_getSZ(10);
  @$pb.TagNumber(11)
  set status($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasStatus() => $_has(10);
  @$pb.TagNumber(11)
  void clearStatus() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get orderType => $_getSZ(11);
  @$pb.TagNumber(12)
  set orderType($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasOrderType() => $_has(11);
  @$pb.TagNumber(12)
  void clearOrderType() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.double get limitPrice => $_getN(12);
  @$pb.TagNumber(13)
  set limitPrice($core.double value) => $_setDouble(12, value);
  @$pb.TagNumber(13)
  $core.bool hasLimitPrice() => $_has(12);
  @$pb.TagNumber(13)
  void clearLimitPrice() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.String get createdAt => $_getSZ(13);
  @$pb.TagNumber(14)
  set createdAt($core.String value) => $_setString(13, value);
  @$pb.TagNumber(14)
  $core.bool hasCreatedAt() => $_has(13);
  @$pb.TagNumber(14)
  void clearCreatedAt() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.String get completedAt => $_getSZ(14);
  @$pb.TagNumber(15)
  set completedAt($core.String value) => $_setString(14, value);
  @$pb.TagNumber(15)
  $core.bool hasCompletedAt() => $_has(14);
  @$pb.TagNumber(15)
  void clearCompletedAt() => $_clearField(15);

  @$pb.TagNumber(16)
  $core.String get failureReason => $_getSZ(15);
  @$pb.TagNumber(16)
  set failureReason($core.String value) => $_setString(15, value);
  @$pb.TagNumber(16)
  $core.bool hasFailureReason() => $_has(15);
  @$pb.TagNumber(16)
  void clearFailureReason() => $_clearField(16);
}

class SearchStocksRequest extends $pb.GeneratedMessage {
  factory SearchStocksRequest({
    $core.String? query,
    $core.String? market,
    $core.int? limit,
  }) {
    final result = create();
    if (query != null) result.query = query;
    if (market != null) result.market = market;
    if (limit != null) result.limit = limit;
    return result;
  }

  SearchStocksRequest._();

  factory SearchStocksRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SearchStocksRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SearchStocksRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'query')
    ..aOS(2, _omitFieldNames ? '' : 'market')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchStocksRequest clone() => SearchStocksRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchStocksRequest copyWith(void Function(SearchStocksRequest) updates) =>
      super.copyWith((message) => updates(message as SearchStocksRequest))
          as SearchStocksRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SearchStocksRequest create() => SearchStocksRequest._();
  @$core.override
  SearchStocksRequest createEmptyInstance() => create();
  static $pb.PbList<SearchStocksRequest> createRepeated() =>
      $pb.PbList<SearchStocksRequest>();
  @$core.pragma('dart2js:noInline')
  static SearchStocksRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SearchStocksRequest>(create);
  static SearchStocksRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get query => $_getSZ(0);
  @$pb.TagNumber(1)
  set query($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasQuery() => $_has(0);
  @$pb.TagNumber(1)
  void clearQuery() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get market => $_getSZ(1);
  @$pb.TagNumber(2)
  set market($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMarket() => $_has(1);
  @$pb.TagNumber(2)
  void clearMarket() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get limit => $_getIZ(2);
  @$pb.TagNumber(3)
  set limit($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLimit() => $_has(2);
  @$pb.TagNumber(3)
  void clearLimit() => $_clearField(3);
}

class StockSearchResult extends $pb.GeneratedMessage {
  factory StockSearchResult({
    $core.String? symbol,
    $core.String? name,
    $core.String? exchange,
    $core.bool? isTradable,
    $core.bool? isFractionable,
  }) {
    final result = create();
    if (symbol != null) result.symbol = symbol;
    if (name != null) result.name = name;
    if (exchange != null) result.exchange = exchange;
    if (isTradable != null) result.isTradable = isTradable;
    if (isFractionable != null) result.isFractionable = isFractionable;
    return result;
  }

  StockSearchResult._();

  factory StockSearchResult.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory StockSearchResult.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StockSearchResult',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'symbol')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'exchange')
    ..aOB(4, _omitFieldNames ? '' : 'isTradable')
    ..aOB(5, _omitFieldNames ? '' : 'isFractionable')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StockSearchResult clone() => StockSearchResult()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StockSearchResult copyWith(void Function(StockSearchResult) updates) =>
      super.copyWith((message) => updates(message as StockSearchResult))
          as StockSearchResult;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StockSearchResult create() => StockSearchResult._();
  @$core.override
  StockSearchResult createEmptyInstance() => create();
  static $pb.PbList<StockSearchResult> createRepeated() =>
      $pb.PbList<StockSearchResult>();
  @$core.pragma('dart2js:noInline')
  static StockSearchResult getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<StockSearchResult>(create);
  static StockSearchResult? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get symbol => $_getSZ(0);
  @$pb.TagNumber(1)
  set symbol($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSymbol() => $_has(0);
  @$pb.TagNumber(1)
  void clearSymbol() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get exchange => $_getSZ(2);
  @$pb.TagNumber(3)
  set exchange($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasExchange() => $_has(2);
  @$pb.TagNumber(3)
  void clearExchange() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.bool get isTradable => $_getBF(3);
  @$pb.TagNumber(4)
  set isTradable($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasIsTradable() => $_has(3);
  @$pb.TagNumber(4)
  void clearIsTradable() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.bool get isFractionable => $_getBF(4);
  @$pb.TagNumber(5)
  set isFractionable($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasIsFractionable() => $_has(4);
  @$pb.TagNumber(5)
  void clearIsFractionable() => $_clearField(5);
}

class SearchStocksResponse extends $pb.GeneratedMessage {
  factory SearchStocksResponse({
    $core.Iterable<StockSearchResult>? results,
    $core.int? total,
  }) {
    final result = create();
    if (results != null) result.results.addAll(results);
    if (total != null) result.total = total;
    return result;
  }

  SearchStocksResponse._();

  factory SearchStocksResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SearchStocksResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SearchStocksResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..pc<StockSearchResult>(
        1, _omitFieldNames ? '' : 'results', $pb.PbFieldType.PM,
        subBuilder: StockSearchResult.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchStocksResponse clone() =>
      SearchStocksResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchStocksResponse copyWith(void Function(SearchStocksResponse) updates) =>
      super.copyWith((message) => updates(message as SearchStocksResponse))
          as SearchStocksResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SearchStocksResponse create() => SearchStocksResponse._();
  @$core.override
  SearchStocksResponse createEmptyInstance() => create();
  static $pb.PbList<SearchStocksResponse> createRepeated() =>
      $pb.PbList<SearchStocksResponse>();
  @$core.pragma('dart2js:noInline')
  static SearchStocksResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SearchStocksResponse>(create);
  static SearchStocksResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<StockSearchResult> get results => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);
}

class GetStockDetailsRequest extends $pb.GeneratedMessage {
  factory GetStockDetailsRequest({
    $core.String? symbol,
  }) {
    final result = create();
    if (symbol != null) result.symbol = symbol;
    return result;
  }

  GetStockDetailsRequest._();

  factory GetStockDetailsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetStockDetailsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetStockDetailsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'symbol')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetStockDetailsRequest clone() =>
      GetStockDetailsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetStockDetailsRequest copyWith(
          void Function(GetStockDetailsRequest) updates) =>
      super.copyWith((message) => updates(message as GetStockDetailsRequest))
          as GetStockDetailsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetStockDetailsRequest create() => GetStockDetailsRequest._();
  @$core.override
  GetStockDetailsRequest createEmptyInstance() => create();
  static $pb.PbList<GetStockDetailsRequest> createRepeated() =>
      $pb.PbList<GetStockDetailsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetStockDetailsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetStockDetailsRequest>(create);
  static GetStockDetailsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get symbol => $_getSZ(0);
  @$pb.TagNumber(1)
  set symbol($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSymbol() => $_has(0);
  @$pb.TagNumber(1)
  void clearSymbol() => $_clearField(1);
}

class StockDetail extends $pb.GeneratedMessage {
  factory StockDetail({
    $core.String? symbol,
    $core.String? name,
    $core.double? currentPrice,
    $core.double? change,
    $core.double? changePercent,
    $core.double? dayHigh,
    $core.double? dayLow,
    $core.double? volume,
    $core.double? marketCap,
    $core.double? peRatio,
    $core.double? dividendYield,
    $core.String? sector,
    $core.String? industry,
    $core.String? logoUrl,
    $core.String? exchange,
    $core.String? currency,
    $core.double? weekHigh52,
    $core.double? weekLow52,
    $core.double? beta,
    $core.double? eps,
    $core.String? description,
    $core.bool? isTradable,
    $core.bool? isFractionable,
  }) {
    final result = create();
    if (symbol != null) result.symbol = symbol;
    if (name != null) result.name = name;
    if (currentPrice != null) result.currentPrice = currentPrice;
    if (change != null) result.change = change;
    if (changePercent != null) result.changePercent = changePercent;
    if (dayHigh != null) result.dayHigh = dayHigh;
    if (dayLow != null) result.dayLow = dayLow;
    if (volume != null) result.volume = volume;
    if (marketCap != null) result.marketCap = marketCap;
    if (peRatio != null) result.peRatio = peRatio;
    if (dividendYield != null) result.dividendYield = dividendYield;
    if (sector != null) result.sector = sector;
    if (industry != null) result.industry = industry;
    if (logoUrl != null) result.logoUrl = logoUrl;
    if (exchange != null) result.exchange = exchange;
    if (currency != null) result.currency = currency;
    if (weekHigh52 != null) result.weekHigh52 = weekHigh52;
    if (weekLow52 != null) result.weekLow52 = weekLow52;
    if (beta != null) result.beta = beta;
    if (eps != null) result.eps = eps;
    if (description != null) result.description = description;
    if (isTradable != null) result.isTradable = isTradable;
    if (isFractionable != null) result.isFractionable = isFractionable;
    return result;
  }

  StockDetail._();

  factory StockDetail.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory StockDetail.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StockDetail',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'symbol')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..a<$core.double>(
        3, _omitFieldNames ? '' : 'currentPrice', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'change', $pb.PbFieldType.OD)
    ..a<$core.double>(
        5, _omitFieldNames ? '' : 'changePercent', $pb.PbFieldType.OD)
    ..a<$core.double>(6, _omitFieldNames ? '' : 'dayHigh', $pb.PbFieldType.OD)
    ..a<$core.double>(7, _omitFieldNames ? '' : 'dayLow', $pb.PbFieldType.OD)
    ..a<$core.double>(8, _omitFieldNames ? '' : 'volume', $pb.PbFieldType.OD)
    ..a<$core.double>(9, _omitFieldNames ? '' : 'marketCap', $pb.PbFieldType.OD)
    ..a<$core.double>(10, _omitFieldNames ? '' : 'peRatio', $pb.PbFieldType.OD)
    ..a<$core.double>(
        11, _omitFieldNames ? '' : 'dividendYield', $pb.PbFieldType.OD)
    ..aOS(12, _omitFieldNames ? '' : 'sector')
    ..aOS(13, _omitFieldNames ? '' : 'industry')
    ..aOS(14, _omitFieldNames ? '' : 'logoUrl')
    ..aOS(15, _omitFieldNames ? '' : 'exchange')
    ..aOS(16, _omitFieldNames ? '' : 'currency')
    ..a<$core.double>(
        17, _omitFieldNames ? '' : 'weekHigh52', $pb.PbFieldType.OD,
        protoName: 'week_high_52')
    ..a<$core.double>(
        18, _omitFieldNames ? '' : 'weekLow52', $pb.PbFieldType.OD,
        protoName: 'week_low_52')
    ..a<$core.double>(19, _omitFieldNames ? '' : 'beta', $pb.PbFieldType.OD)
    ..a<$core.double>(20, _omitFieldNames ? '' : 'eps', $pb.PbFieldType.OD)
    ..aOS(21, _omitFieldNames ? '' : 'description')
    ..aOB(22, _omitFieldNames ? '' : 'isTradable')
    ..aOB(23, _omitFieldNames ? '' : 'isFractionable')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StockDetail clone() => StockDetail()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StockDetail copyWith(void Function(StockDetail) updates) =>
      super.copyWith((message) => updates(message as StockDetail))
          as StockDetail;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StockDetail create() => StockDetail._();
  @$core.override
  StockDetail createEmptyInstance() => create();
  static $pb.PbList<StockDetail> createRepeated() => $pb.PbList<StockDetail>();
  @$core.pragma('dart2js:noInline')
  static StockDetail getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<StockDetail>(create);
  static StockDetail? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get symbol => $_getSZ(0);
  @$pb.TagNumber(1)
  set symbol($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSymbol() => $_has(0);
  @$pb.TagNumber(1)
  void clearSymbol() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get currentPrice => $_getN(2);
  @$pb.TagNumber(3)
  set currentPrice($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCurrentPrice() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrentPrice() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get change => $_getN(3);
  @$pb.TagNumber(4)
  set change($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasChange() => $_has(3);
  @$pb.TagNumber(4)
  void clearChange() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get changePercent => $_getN(4);
  @$pb.TagNumber(5)
  set changePercent($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasChangePercent() => $_has(4);
  @$pb.TagNumber(5)
  void clearChangePercent() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.double get dayHigh => $_getN(5);
  @$pb.TagNumber(6)
  set dayHigh($core.double value) => $_setDouble(5, value);
  @$pb.TagNumber(6)
  $core.bool hasDayHigh() => $_has(5);
  @$pb.TagNumber(6)
  void clearDayHigh() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.double get dayLow => $_getN(6);
  @$pb.TagNumber(7)
  set dayLow($core.double value) => $_setDouble(6, value);
  @$pb.TagNumber(7)
  $core.bool hasDayLow() => $_has(6);
  @$pb.TagNumber(7)
  void clearDayLow() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.double get volume => $_getN(7);
  @$pb.TagNumber(8)
  set volume($core.double value) => $_setDouble(7, value);
  @$pb.TagNumber(8)
  $core.bool hasVolume() => $_has(7);
  @$pb.TagNumber(8)
  void clearVolume() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.double get marketCap => $_getN(8);
  @$pb.TagNumber(9)
  set marketCap($core.double value) => $_setDouble(8, value);
  @$pb.TagNumber(9)
  $core.bool hasMarketCap() => $_has(8);
  @$pb.TagNumber(9)
  void clearMarketCap() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.double get peRatio => $_getN(9);
  @$pb.TagNumber(10)
  set peRatio($core.double value) => $_setDouble(9, value);
  @$pb.TagNumber(10)
  $core.bool hasPeRatio() => $_has(9);
  @$pb.TagNumber(10)
  void clearPeRatio() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.double get dividendYield => $_getN(10);
  @$pb.TagNumber(11)
  set dividendYield($core.double value) => $_setDouble(10, value);
  @$pb.TagNumber(11)
  $core.bool hasDividendYield() => $_has(10);
  @$pb.TagNumber(11)
  void clearDividendYield() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get sector => $_getSZ(11);
  @$pb.TagNumber(12)
  set sector($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasSector() => $_has(11);
  @$pb.TagNumber(12)
  void clearSector() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get industry => $_getSZ(12);
  @$pb.TagNumber(13)
  set industry($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasIndustry() => $_has(12);
  @$pb.TagNumber(13)
  void clearIndustry() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.String get logoUrl => $_getSZ(13);
  @$pb.TagNumber(14)
  set logoUrl($core.String value) => $_setString(13, value);
  @$pb.TagNumber(14)
  $core.bool hasLogoUrl() => $_has(13);
  @$pb.TagNumber(14)
  void clearLogoUrl() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.String get exchange => $_getSZ(14);
  @$pb.TagNumber(15)
  set exchange($core.String value) => $_setString(14, value);
  @$pb.TagNumber(15)
  $core.bool hasExchange() => $_has(14);
  @$pb.TagNumber(15)
  void clearExchange() => $_clearField(15);

  @$pb.TagNumber(16)
  $core.String get currency => $_getSZ(15);
  @$pb.TagNumber(16)
  set currency($core.String value) => $_setString(15, value);
  @$pb.TagNumber(16)
  $core.bool hasCurrency() => $_has(15);
  @$pb.TagNumber(16)
  void clearCurrency() => $_clearField(16);

  @$pb.TagNumber(17)
  $core.double get weekHigh52 => $_getN(16);
  @$pb.TagNumber(17)
  set weekHigh52($core.double value) => $_setDouble(16, value);
  @$pb.TagNumber(17)
  $core.bool hasWeekHigh52() => $_has(16);
  @$pb.TagNumber(17)
  void clearWeekHigh52() => $_clearField(17);

  @$pb.TagNumber(18)
  $core.double get weekLow52 => $_getN(17);
  @$pb.TagNumber(18)
  set weekLow52($core.double value) => $_setDouble(17, value);
  @$pb.TagNumber(18)
  $core.bool hasWeekLow52() => $_has(17);
  @$pb.TagNumber(18)
  void clearWeekLow52() => $_clearField(18);

  @$pb.TagNumber(19)
  $core.double get beta => $_getN(18);
  @$pb.TagNumber(19)
  set beta($core.double value) => $_setDouble(18, value);
  @$pb.TagNumber(19)
  $core.bool hasBeta() => $_has(18);
  @$pb.TagNumber(19)
  void clearBeta() => $_clearField(19);

  @$pb.TagNumber(20)
  $core.double get eps => $_getN(19);
  @$pb.TagNumber(20)
  set eps($core.double value) => $_setDouble(19, value);
  @$pb.TagNumber(20)
  $core.bool hasEps() => $_has(19);
  @$pb.TagNumber(20)
  void clearEps() => $_clearField(20);

  @$pb.TagNumber(21)
  $core.String get description => $_getSZ(20);
  @$pb.TagNumber(21)
  set description($core.String value) => $_setString(20, value);
  @$pb.TagNumber(21)
  $core.bool hasDescription() => $_has(20);
  @$pb.TagNumber(21)
  void clearDescription() => $_clearField(21);

  @$pb.TagNumber(22)
  $core.bool get isTradable => $_getBF(21);
  @$pb.TagNumber(22)
  set isTradable($core.bool value) => $_setBool(21, value);
  @$pb.TagNumber(22)
  $core.bool hasIsTradable() => $_has(21);
  @$pb.TagNumber(22)
  void clearIsTradable() => $_clearField(22);

  @$pb.TagNumber(23)
  $core.bool get isFractionable => $_getBF(22);
  @$pb.TagNumber(23)
  set isFractionable($core.bool value) => $_setBool(22, value);
  @$pb.TagNumber(23)
  $core.bool hasIsFractionable() => $_has(22);
  @$pb.TagNumber(23)
  void clearIsFractionable() => $_clearField(23);
}

class GetStockDetailsResponse extends $pb.GeneratedMessage {
  factory GetStockDetailsResponse({
    StockDetail? stock,
  }) {
    final result = create();
    if (stock != null) result.stock = stock;
    return result;
  }

  GetStockDetailsResponse._();

  factory GetStockDetailsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetStockDetailsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetStockDetailsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..aOM<StockDetail>(1, _omitFieldNames ? '' : 'stock',
        subBuilder: StockDetail.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetStockDetailsResponse clone() =>
      GetStockDetailsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetStockDetailsResponse copyWith(
          void Function(GetStockDetailsResponse) updates) =>
      super.copyWith((message) => updates(message as GetStockDetailsResponse))
          as GetStockDetailsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetStockDetailsResponse create() => GetStockDetailsResponse._();
  @$core.override
  GetStockDetailsResponse createEmptyInstance() => create();
  static $pb.PbList<GetStockDetailsResponse> createRepeated() =>
      $pb.PbList<GetStockDetailsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetStockDetailsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetStockDetailsResponse>(create);
  static GetStockDetailsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  StockDetail get stock => $_getN(0);
  @$pb.TagNumber(1)
  set stock(StockDetail value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasStock() => $_has(0);
  @$pb.TagNumber(1)
  void clearStock() => $_clearField(1);
  @$pb.TagNumber(1)
  StockDetail ensureStock() => $_ensure(0);
}

class GetStockPriceHistoryRequest extends $pb.GeneratedMessage {
  factory GetStockPriceHistoryRequest({
    $core.String? symbol,
    $core.String? timeframe,
    $core.String? start,
    $core.String? end,
    $core.int? limit,
  }) {
    final result = create();
    if (symbol != null) result.symbol = symbol;
    if (timeframe != null) result.timeframe = timeframe;
    if (start != null) result.start = start;
    if (end != null) result.end = end;
    if (limit != null) result.limit = limit;
    return result;
  }

  GetStockPriceHistoryRequest._();

  factory GetStockPriceHistoryRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetStockPriceHistoryRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetStockPriceHistoryRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'symbol')
    ..aOS(2, _omitFieldNames ? '' : 'timeframe')
    ..aOS(3, _omitFieldNames ? '' : 'start')
    ..aOS(4, _omitFieldNames ? '' : 'end')
    ..a<$core.int>(5, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetStockPriceHistoryRequest clone() =>
      GetStockPriceHistoryRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetStockPriceHistoryRequest copyWith(
          void Function(GetStockPriceHistoryRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetStockPriceHistoryRequest))
          as GetStockPriceHistoryRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetStockPriceHistoryRequest create() =>
      GetStockPriceHistoryRequest._();
  @$core.override
  GetStockPriceHistoryRequest createEmptyInstance() => create();
  static $pb.PbList<GetStockPriceHistoryRequest> createRepeated() =>
      $pb.PbList<GetStockPriceHistoryRequest>();
  @$core.pragma('dart2js:noInline')
  static GetStockPriceHistoryRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetStockPriceHistoryRequest>(create);
  static GetStockPriceHistoryRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get symbol => $_getSZ(0);
  @$pb.TagNumber(1)
  set symbol($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSymbol() => $_has(0);
  @$pb.TagNumber(1)
  void clearSymbol() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get timeframe => $_getSZ(1);
  @$pb.TagNumber(2)
  set timeframe($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTimeframe() => $_has(1);
  @$pb.TagNumber(2)
  void clearTimeframe() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get start => $_getSZ(2);
  @$pb.TagNumber(3)
  set start($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasStart() => $_has(2);
  @$pb.TagNumber(3)
  void clearStart() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get end => $_getSZ(3);
  @$pb.TagNumber(4)
  set end($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasEnd() => $_has(3);
  @$pb.TagNumber(4)
  void clearEnd() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get limit => $_getIZ(4);
  @$pb.TagNumber(5)
  set limit($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasLimit() => $_has(4);
  @$pb.TagNumber(5)
  void clearLimit() => $_clearField(5);
}

class PriceBar extends $pb.GeneratedMessage {
  factory PriceBar({
    $core.String? timestamp,
    $core.double? open,
    $core.double? high,
    $core.double? low,
    $core.double? close,
    $fixnum.Int64? volume,
    $core.double? vwap,
  }) {
    final result = create();
    if (timestamp != null) result.timestamp = timestamp;
    if (open != null) result.open = open;
    if (high != null) result.high = high;
    if (low != null) result.low = low;
    if (close != null) result.close = close;
    if (volume != null) result.volume = volume;
    if (vwap != null) result.vwap = vwap;
    return result;
  }

  PriceBar._();

  factory PriceBar.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PriceBar.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PriceBar',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'timestamp')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'open', $pb.PbFieldType.OD)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'high', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'low', $pb.PbFieldType.OD)
    ..a<$core.double>(5, _omitFieldNames ? '' : 'close', $pb.PbFieldType.OD)
    ..aInt64(6, _omitFieldNames ? '' : 'volume')
    ..a<$core.double>(7, _omitFieldNames ? '' : 'vwap', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PriceBar clone() => PriceBar()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PriceBar copyWith(void Function(PriceBar) updates) =>
      super.copyWith((message) => updates(message as PriceBar)) as PriceBar;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PriceBar create() => PriceBar._();
  @$core.override
  PriceBar createEmptyInstance() => create();
  static $pb.PbList<PriceBar> createRepeated() => $pb.PbList<PriceBar>();
  @$core.pragma('dart2js:noInline')
  static PriceBar getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PriceBar>(create);
  static PriceBar? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get timestamp => $_getSZ(0);
  @$pb.TagNumber(1)
  set timestamp($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTimestamp() => $_has(0);
  @$pb.TagNumber(1)
  void clearTimestamp() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get open => $_getN(1);
  @$pb.TagNumber(2)
  set open($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasOpen() => $_has(1);
  @$pb.TagNumber(2)
  void clearOpen() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get high => $_getN(2);
  @$pb.TagNumber(3)
  set high($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasHigh() => $_has(2);
  @$pb.TagNumber(3)
  void clearHigh() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get low => $_getN(3);
  @$pb.TagNumber(4)
  set low($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasLow() => $_has(3);
  @$pb.TagNumber(4)
  void clearLow() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get close => $_getN(4);
  @$pb.TagNumber(5)
  set close($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasClose() => $_has(4);
  @$pb.TagNumber(5)
  void clearClose() => $_clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get volume => $_getI64(5);
  @$pb.TagNumber(6)
  set volume($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasVolume() => $_has(5);
  @$pb.TagNumber(6)
  void clearVolume() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.double get vwap => $_getN(6);
  @$pb.TagNumber(7)
  set vwap($core.double value) => $_setDouble(6, value);
  @$pb.TagNumber(7)
  $core.bool hasVwap() => $_has(6);
  @$pb.TagNumber(7)
  void clearVwap() => $_clearField(7);
}

class GetStockPriceHistoryResponse extends $pb.GeneratedMessage {
  factory GetStockPriceHistoryResponse({
    $core.Iterable<PriceBar>? bars,
    $core.String? symbol,
  }) {
    final result = create();
    if (bars != null) result.bars.addAll(bars);
    if (symbol != null) result.symbol = symbol;
    return result;
  }

  GetStockPriceHistoryResponse._();

  factory GetStockPriceHistoryResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetStockPriceHistoryResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetStockPriceHistoryResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..pc<PriceBar>(1, _omitFieldNames ? '' : 'bars', $pb.PbFieldType.PM,
        subBuilder: PriceBar.create)
    ..aOS(2, _omitFieldNames ? '' : 'symbol')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetStockPriceHistoryResponse clone() =>
      GetStockPriceHistoryResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetStockPriceHistoryResponse copyWith(
          void Function(GetStockPriceHistoryResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetStockPriceHistoryResponse))
          as GetStockPriceHistoryResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetStockPriceHistoryResponse create() =>
      GetStockPriceHistoryResponse._();
  @$core.override
  GetStockPriceHistoryResponse createEmptyInstance() => create();
  static $pb.PbList<GetStockPriceHistoryResponse> createRepeated() =>
      $pb.PbList<GetStockPriceHistoryResponse>();
  @$core.pragma('dart2js:noInline')
  static GetStockPriceHistoryResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetStockPriceHistoryResponse>(create);
  static GetStockPriceHistoryResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<PriceBar> get bars => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get symbol => $_getSZ(1);
  @$pb.TagNumber(2)
  set symbol($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSymbol() => $_has(1);
  @$pb.TagNumber(2)
  void clearSymbol() => $_clearField(2);
}

class GetTopMoversRequest extends $pb.GeneratedMessage {
  factory GetTopMoversRequest({
    $core.String? market,
    $core.int? limit,
  }) {
    final result = create();
    if (market != null) result.market = market;
    if (limit != null) result.limit = limit;
    return result;
  }

  GetTopMoversRequest._();

  factory GetTopMoversRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTopMoversRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTopMoversRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'market')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTopMoversRequest clone() => GetTopMoversRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTopMoversRequest copyWith(void Function(GetTopMoversRequest) updates) =>
      super.copyWith((message) => updates(message as GetTopMoversRequest))
          as GetTopMoversRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTopMoversRequest create() => GetTopMoversRequest._();
  @$core.override
  GetTopMoversRequest createEmptyInstance() => create();
  static $pb.PbList<GetTopMoversRequest> createRepeated() =>
      $pb.PbList<GetTopMoversRequest>();
  @$core.pragma('dart2js:noInline')
  static GetTopMoversRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetTopMoversRequest>(create);
  static GetTopMoversRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get market => $_getSZ(0);
  @$pb.TagNumber(1)
  set market($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMarket() => $_has(0);
  @$pb.TagNumber(1)
  void clearMarket() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get limit => $_getIZ(1);
  @$pb.TagNumber(2)
  set limit($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => $_clearField(2);
}

class TopMover extends $pb.GeneratedMessage {
  factory TopMover({
    $core.String? symbol,
    $core.String? name,
    $core.double? price,
    $core.double? change,
    $core.double? changePercent,
    $core.double? volume,
  }) {
    final result = create();
    if (symbol != null) result.symbol = symbol;
    if (name != null) result.name = name;
    if (price != null) result.price = price;
    if (change != null) result.change = change;
    if (changePercent != null) result.changePercent = changePercent;
    if (volume != null) result.volume = volume;
    return result;
  }

  TopMover._();

  factory TopMover.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TopMover.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TopMover',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'symbol')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'price', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'change', $pb.PbFieldType.OD)
    ..a<$core.double>(
        5, _omitFieldNames ? '' : 'changePercent', $pb.PbFieldType.OD)
    ..a<$core.double>(6, _omitFieldNames ? '' : 'volume', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TopMover clone() => TopMover()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TopMover copyWith(void Function(TopMover) updates) =>
      super.copyWith((message) => updates(message as TopMover)) as TopMover;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TopMover create() => TopMover._();
  @$core.override
  TopMover createEmptyInstance() => create();
  static $pb.PbList<TopMover> createRepeated() => $pb.PbList<TopMover>();
  @$core.pragma('dart2js:noInline')
  static TopMover getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TopMover>(create);
  static TopMover? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get symbol => $_getSZ(0);
  @$pb.TagNumber(1)
  set symbol($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSymbol() => $_has(0);
  @$pb.TagNumber(1)
  void clearSymbol() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get price => $_getN(2);
  @$pb.TagNumber(3)
  set price($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPrice() => $_has(2);
  @$pb.TagNumber(3)
  void clearPrice() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get change => $_getN(3);
  @$pb.TagNumber(4)
  set change($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasChange() => $_has(3);
  @$pb.TagNumber(4)
  void clearChange() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get changePercent => $_getN(4);
  @$pb.TagNumber(5)
  set changePercent($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasChangePercent() => $_has(4);
  @$pb.TagNumber(5)
  void clearChangePercent() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.double get volume => $_getN(5);
  @$pb.TagNumber(6)
  set volume($core.double value) => $_setDouble(5, value);
  @$pb.TagNumber(6)
  $core.bool hasVolume() => $_has(5);
  @$pb.TagNumber(6)
  void clearVolume() => $_clearField(6);
}

class GetTopMoversResponse extends $pb.GeneratedMessage {
  factory GetTopMoversResponse({
    $core.Iterable<TopMover>? gainers,
    $core.Iterable<TopMover>? losers,
  }) {
    final result = create();
    if (gainers != null) result.gainers.addAll(gainers);
    if (losers != null) result.losers.addAll(losers);
    return result;
  }

  GetTopMoversResponse._();

  factory GetTopMoversResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTopMoversResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTopMoversResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..pc<TopMover>(1, _omitFieldNames ? '' : 'gainers', $pb.PbFieldType.PM,
        subBuilder: TopMover.create)
    ..pc<TopMover>(2, _omitFieldNames ? '' : 'losers', $pb.PbFieldType.PM,
        subBuilder: TopMover.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTopMoversResponse clone() =>
      GetTopMoversResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTopMoversResponse copyWith(void Function(GetTopMoversResponse) updates) =>
      super.copyWith((message) => updates(message as GetTopMoversResponse))
          as GetTopMoversResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTopMoversResponse create() => GetTopMoversResponse._();
  @$core.override
  GetTopMoversResponse createEmptyInstance() => create();
  static $pb.PbList<GetTopMoversResponse> createRepeated() =>
      $pb.PbList<GetTopMoversResponse>();
  @$core.pragma('dart2js:noInline')
  static GetTopMoversResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetTopMoversResponse>(create);
  static GetTopMoversResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<TopMover> get gainers => $_getList(0);

  @$pb.TagNumber(2)
  $pb.PbList<TopMover> get losers => $_getList(1);
}

class GetStockOrdersRequest extends $pb.GeneratedMessage {
  factory GetStockOrdersRequest({
    $core.String? status,
    $core.String? side,
    $core.int? limit,
  }) {
    final result = create();
    if (status != null) result.status = status;
    if (side != null) result.side = side;
    if (limit != null) result.limit = limit;
    return result;
  }

  GetStockOrdersRequest._();

  factory GetStockOrdersRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetStockOrdersRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetStockOrdersRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'status')
    ..aOS(2, _omitFieldNames ? '' : 'side')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetStockOrdersRequest clone() =>
      GetStockOrdersRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetStockOrdersRequest copyWith(
          void Function(GetStockOrdersRequest) updates) =>
      super.copyWith((message) => updates(message as GetStockOrdersRequest))
          as GetStockOrdersRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetStockOrdersRequest create() => GetStockOrdersRequest._();
  @$core.override
  GetStockOrdersRequest createEmptyInstance() => create();
  static $pb.PbList<GetStockOrdersRequest> createRepeated() =>
      $pb.PbList<GetStockOrdersRequest>();
  @$core.pragma('dart2js:noInline')
  static GetStockOrdersRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetStockOrdersRequest>(create);
  static GetStockOrdersRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get status => $_getSZ(0);
  @$pb.TagNumber(1)
  set status($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get side => $_getSZ(1);
  @$pb.TagNumber(2)
  set side($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSide() => $_has(1);
  @$pb.TagNumber(2)
  void clearSide() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get limit => $_getIZ(2);
  @$pb.TagNumber(3)
  set limit($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLimit() => $_has(2);
  @$pb.TagNumber(3)
  void clearLimit() => $_clearField(3);
}

class StockOrderInfo extends $pb.GeneratedMessage {
  factory StockOrderInfo({
    $core.String? orderId,
    $core.String? symbol,
    $core.String? side,
    $core.String? orderType,
    $core.double? quantity,
    $core.double? filledQty,
    $core.double? filledAvgPrice,
    $core.double? limitPrice,
    $core.double? stopPrice,
    $core.String? status,
    $core.String? createdAt,
    $core.String? filledAt,
    $core.double? totalValue,
    $core.double? fee,
  }) {
    final result = create();
    if (orderId != null) result.orderId = orderId;
    if (symbol != null) result.symbol = symbol;
    if (side != null) result.side = side;
    if (orderType != null) result.orderType = orderType;
    if (quantity != null) result.quantity = quantity;
    if (filledQty != null) result.filledQty = filledQty;
    if (filledAvgPrice != null) result.filledAvgPrice = filledAvgPrice;
    if (limitPrice != null) result.limitPrice = limitPrice;
    if (stopPrice != null) result.stopPrice = stopPrice;
    if (status != null) result.status = status;
    if (createdAt != null) result.createdAt = createdAt;
    if (filledAt != null) result.filledAt = filledAt;
    if (totalValue != null) result.totalValue = totalValue;
    if (fee != null) result.fee = fee;
    return result;
  }

  StockOrderInfo._();

  factory StockOrderInfo.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory StockOrderInfo.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StockOrderInfo',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'orderId')
    ..aOS(2, _omitFieldNames ? '' : 'symbol')
    ..aOS(3, _omitFieldNames ? '' : 'side')
    ..aOS(4, _omitFieldNames ? '' : 'orderType')
    ..a<$core.double>(5, _omitFieldNames ? '' : 'quantity', $pb.PbFieldType.OD)
    ..a<$core.double>(6, _omitFieldNames ? '' : 'filledQty', $pb.PbFieldType.OD)
    ..a<$core.double>(
        7, _omitFieldNames ? '' : 'filledAvgPrice', $pb.PbFieldType.OD)
    ..a<$core.double>(
        8, _omitFieldNames ? '' : 'limitPrice', $pb.PbFieldType.OD)
    ..a<$core.double>(9, _omitFieldNames ? '' : 'stopPrice', $pb.PbFieldType.OD)
    ..aOS(10, _omitFieldNames ? '' : 'status')
    ..aOS(11, _omitFieldNames ? '' : 'createdAt')
    ..aOS(12, _omitFieldNames ? '' : 'filledAt')
    ..a<$core.double>(
        13, _omitFieldNames ? '' : 'totalValue', $pb.PbFieldType.OD)
    ..a<$core.double>(14, _omitFieldNames ? '' : 'fee', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StockOrderInfo clone() => StockOrderInfo()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StockOrderInfo copyWith(void Function(StockOrderInfo) updates) =>
      super.copyWith((message) => updates(message as StockOrderInfo))
          as StockOrderInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StockOrderInfo create() => StockOrderInfo._();
  @$core.override
  StockOrderInfo createEmptyInstance() => create();
  static $pb.PbList<StockOrderInfo> createRepeated() =>
      $pb.PbList<StockOrderInfo>();
  @$core.pragma('dart2js:noInline')
  static StockOrderInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<StockOrderInfo>(create);
  static StockOrderInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get orderId => $_getSZ(0);
  @$pb.TagNumber(1)
  set orderId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasOrderId() => $_has(0);
  @$pb.TagNumber(1)
  void clearOrderId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get symbol => $_getSZ(1);
  @$pb.TagNumber(2)
  set symbol($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSymbol() => $_has(1);
  @$pb.TagNumber(2)
  void clearSymbol() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get side => $_getSZ(2);
  @$pb.TagNumber(3)
  set side($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSide() => $_has(2);
  @$pb.TagNumber(3)
  void clearSide() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get orderType => $_getSZ(3);
  @$pb.TagNumber(4)
  set orderType($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasOrderType() => $_has(3);
  @$pb.TagNumber(4)
  void clearOrderType() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get quantity => $_getN(4);
  @$pb.TagNumber(5)
  set quantity($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasQuantity() => $_has(4);
  @$pb.TagNumber(5)
  void clearQuantity() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.double get filledQty => $_getN(5);
  @$pb.TagNumber(6)
  set filledQty($core.double value) => $_setDouble(5, value);
  @$pb.TagNumber(6)
  $core.bool hasFilledQty() => $_has(5);
  @$pb.TagNumber(6)
  void clearFilledQty() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.double get filledAvgPrice => $_getN(6);
  @$pb.TagNumber(7)
  set filledAvgPrice($core.double value) => $_setDouble(6, value);
  @$pb.TagNumber(7)
  $core.bool hasFilledAvgPrice() => $_has(6);
  @$pb.TagNumber(7)
  void clearFilledAvgPrice() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.double get limitPrice => $_getN(7);
  @$pb.TagNumber(8)
  set limitPrice($core.double value) => $_setDouble(7, value);
  @$pb.TagNumber(8)
  $core.bool hasLimitPrice() => $_has(7);
  @$pb.TagNumber(8)
  void clearLimitPrice() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.double get stopPrice => $_getN(8);
  @$pb.TagNumber(9)
  set stopPrice($core.double value) => $_setDouble(8, value);
  @$pb.TagNumber(9)
  $core.bool hasStopPrice() => $_has(8);
  @$pb.TagNumber(9)
  void clearStopPrice() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get status => $_getSZ(9);
  @$pb.TagNumber(10)
  set status($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasStatus() => $_has(9);
  @$pb.TagNumber(10)
  void clearStatus() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get createdAt => $_getSZ(10);
  @$pb.TagNumber(11)
  set createdAt($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasCreatedAt() => $_has(10);
  @$pb.TagNumber(11)
  void clearCreatedAt() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get filledAt => $_getSZ(11);
  @$pb.TagNumber(12)
  set filledAt($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasFilledAt() => $_has(11);
  @$pb.TagNumber(12)
  void clearFilledAt() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.double get totalValue => $_getN(12);
  @$pb.TagNumber(13)
  set totalValue($core.double value) => $_setDouble(12, value);
  @$pb.TagNumber(13)
  $core.bool hasTotalValue() => $_has(12);
  @$pb.TagNumber(13)
  void clearTotalValue() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.double get fee => $_getN(13);
  @$pb.TagNumber(14)
  set fee($core.double value) => $_setDouble(13, value);
  @$pb.TagNumber(14)
  $core.bool hasFee() => $_has(13);
  @$pb.TagNumber(14)
  void clearFee() => $_clearField(14);
}

class GetStockOrdersResponse extends $pb.GeneratedMessage {
  factory GetStockOrdersResponse({
    $core.Iterable<StockOrderInfo>? orders,
    $core.int? total,
  }) {
    final result = create();
    if (orders != null) result.orders.addAll(orders);
    if (total != null) result.total = total;
    return result;
  }

  GetStockOrdersResponse._();

  factory GetStockOrdersResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetStockOrdersResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetStockOrdersResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..pc<StockOrderInfo>(1, _omitFieldNames ? '' : 'orders', $pb.PbFieldType.PM,
        subBuilder: StockOrderInfo.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetStockOrdersResponse clone() =>
      GetStockOrdersResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetStockOrdersResponse copyWith(
          void Function(GetStockOrdersResponse) updates) =>
      super.copyWith((message) => updates(message as GetStockOrdersResponse))
          as GetStockOrdersResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetStockOrdersResponse create() => GetStockOrdersResponse._();
  @$core.override
  GetStockOrdersResponse createEmptyInstance() => create();
  static $pb.PbList<GetStockOrdersResponse> createRepeated() =>
      $pb.PbList<GetStockOrdersResponse>();
  @$core.pragma('dart2js:noInline')
  static GetStockOrdersResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetStockOrdersResponse>(create);
  static GetStockOrdersResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<StockOrderInfo> get orders => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);
}

class CancelStockOrderRequest extends $pb.GeneratedMessage {
  factory CancelStockOrderRequest({
    $core.String? orderId,
  }) {
    final result = create();
    if (orderId != null) result.orderId = orderId;
    return result;
  }

  CancelStockOrderRequest._();

  factory CancelStockOrderRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CancelStockOrderRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CancelStockOrderRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'orderId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CancelStockOrderRequest clone() =>
      CancelStockOrderRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CancelStockOrderRequest copyWith(
          void Function(CancelStockOrderRequest) updates) =>
      super.copyWith((message) => updates(message as CancelStockOrderRequest))
          as CancelStockOrderRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CancelStockOrderRequest create() => CancelStockOrderRequest._();
  @$core.override
  CancelStockOrderRequest createEmptyInstance() => create();
  static $pb.PbList<CancelStockOrderRequest> createRepeated() =>
      $pb.PbList<CancelStockOrderRequest>();
  @$core.pragma('dart2js:noInline')
  static CancelStockOrderRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CancelStockOrderRequest>(create);
  static CancelStockOrderRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get orderId => $_getSZ(0);
  @$pb.TagNumber(1)
  set orderId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasOrderId() => $_has(0);
  @$pb.TagNumber(1)
  void clearOrderId() => $_clearField(1);
}

class CancelStockOrderResponse extends $pb.GeneratedMessage {
  factory CancelStockOrderResponse({
    $core.bool? success,
    $core.String? message,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    return result;
  }

  CancelStockOrderResponse._();

  factory CancelStockOrderResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CancelStockOrderResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CancelStockOrderResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CancelStockOrderResponse clone() =>
      CancelStockOrderResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CancelStockOrderResponse copyWith(
          void Function(CancelStockOrderResponse) updates) =>
      super.copyWith((message) => updates(message as CancelStockOrderResponse))
          as CancelStockOrderResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CancelStockOrderResponse create() => CancelStockOrderResponse._();
  @$core.override
  CancelStockOrderResponse createEmptyInstance() => create();
  static $pb.PbList<CancelStockOrderResponse> createRepeated() =>
      $pb.PbList<CancelStockOrderResponse>();
  @$core.pragma('dart2js:noInline')
  static CancelStockOrderResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CancelStockOrderResponse>(create);
  static CancelStockOrderResponse? _defaultInstance;

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

class GetMarketStatusRequest extends $pb.GeneratedMessage {
  factory GetMarketStatusRequest() => create();

  GetMarketStatusRequest._();

  factory GetMarketStatusRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMarketStatusRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMarketStatusRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMarketStatusRequest clone() =>
      GetMarketStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMarketStatusRequest copyWith(
          void Function(GetMarketStatusRequest) updates) =>
      super.copyWith((message) => updates(message as GetMarketStatusRequest))
          as GetMarketStatusRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMarketStatusRequest create() => GetMarketStatusRequest._();
  @$core.override
  GetMarketStatusRequest createEmptyInstance() => create();
  static $pb.PbList<GetMarketStatusRequest> createRepeated() =>
      $pb.PbList<GetMarketStatusRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMarketStatusRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMarketStatusRequest>(create);
  static GetMarketStatusRequest? _defaultInstance;
}

class GetMarketStatusResponse extends $pb.GeneratedMessage {
  factory GetMarketStatusResponse({
    $core.bool? isOpen,
    $core.String? nextOpen,
    $core.String? nextClose,
    $core.String? timestamp,
  }) {
    final result = create();
    if (isOpen != null) result.isOpen = isOpen;
    if (nextOpen != null) result.nextOpen = nextOpen;
    if (nextClose != null) result.nextClose = nextClose;
    if (timestamp != null) result.timestamp = timestamp;
    return result;
  }

  GetMarketStatusResponse._();

  factory GetMarketStatusResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMarketStatusResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMarketStatusResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'isOpen')
    ..aOS(2, _omitFieldNames ? '' : 'nextOpen')
    ..aOS(3, _omitFieldNames ? '' : 'nextClose')
    ..aOS(4, _omitFieldNames ? '' : 'timestamp')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMarketStatusResponse clone() =>
      GetMarketStatusResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMarketStatusResponse copyWith(
          void Function(GetMarketStatusResponse) updates) =>
      super.copyWith((message) => updates(message as GetMarketStatusResponse))
          as GetMarketStatusResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMarketStatusResponse create() => GetMarketStatusResponse._();
  @$core.override
  GetMarketStatusResponse createEmptyInstance() => create();
  static $pb.PbList<GetMarketStatusResponse> createRepeated() =>
      $pb.PbList<GetMarketStatusResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMarketStatusResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMarketStatusResponse>(create);
  static GetMarketStatusResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get isOpen => $_getBF(0);
  @$pb.TagNumber(1)
  set isOpen($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasIsOpen() => $_has(0);
  @$pb.TagNumber(1)
  void clearIsOpen() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get nextOpen => $_getSZ(1);
  @$pb.TagNumber(2)
  set nextOpen($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNextOpen() => $_has(1);
  @$pb.TagNumber(2)
  void clearNextOpen() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get nextClose => $_getSZ(2);
  @$pb.TagNumber(3)
  set nextClose($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasNextClose() => $_has(2);
  @$pb.TagNumber(3)
  void clearNextClose() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get timestamp => $_getSZ(3);
  @$pb.TagNumber(4)
  set timestamp($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTimestamp() => $_has(3);
  @$pb.TagNumber(4)
  void clearTimestamp() => $_clearField(4);
}

class GetMarketNewsRequest extends $pb.GeneratedMessage {
  factory GetMarketNewsRequest({
    $core.Iterable<$core.String>? symbols,
    $core.String? category,
    $core.int? limit,
    $core.int? page,
  }) {
    final result = create();
    if (symbols != null) result.symbols.addAll(symbols);
    if (category != null) result.category = category;
    if (limit != null) result.limit = limit;
    if (page != null) result.page = page;
    return result;
  }

  GetMarketNewsRequest._();

  factory GetMarketNewsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMarketNewsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMarketNewsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'symbols')
    ..aOS(2, _omitFieldNames ? '' : 'category')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMarketNewsRequest clone() =>
      GetMarketNewsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMarketNewsRequest copyWith(void Function(GetMarketNewsRequest) updates) =>
      super.copyWith((message) => updates(message as GetMarketNewsRequest))
          as GetMarketNewsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMarketNewsRequest create() => GetMarketNewsRequest._();
  @$core.override
  GetMarketNewsRequest createEmptyInstance() => create();
  static $pb.PbList<GetMarketNewsRequest> createRepeated() =>
      $pb.PbList<GetMarketNewsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMarketNewsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMarketNewsRequest>(create);
  static GetMarketNewsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$core.String> get symbols => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get category => $_getSZ(1);
  @$pb.TagNumber(2)
  set category($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCategory() => $_has(1);
  @$pb.TagNumber(2)
  void clearCategory() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get limit => $_getIZ(2);
  @$pb.TagNumber(3)
  set limit($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLimit() => $_has(2);
  @$pb.TagNumber(3)
  void clearLimit() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get page => $_getIZ(3);
  @$pb.TagNumber(4)
  set page($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPage() => $_has(3);
  @$pb.TagNumber(4)
  void clearPage() => $_clearField(4);
}

class NewsArticle extends $pb.GeneratedMessage {
  factory NewsArticle({
    $core.String? id,
    $core.String? title,
    $core.String? summary,
    $core.String? content,
    $core.String? source,
    $core.String? imageUrl,
    $core.Iterable<$core.String>? relatedSymbols,
    $core.String? publishedAt,
    $core.String? url,
    $core.String? category,
    $core.int? readTime,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (title != null) result.title = title;
    if (summary != null) result.summary = summary;
    if (content != null) result.content = content;
    if (source != null) result.source = source;
    if (imageUrl != null) result.imageUrl = imageUrl;
    if (relatedSymbols != null) result.relatedSymbols.addAll(relatedSymbols);
    if (publishedAt != null) result.publishedAt = publishedAt;
    if (url != null) result.url = url;
    if (category != null) result.category = category;
    if (readTime != null) result.readTime = readTime;
    return result;
  }

  NewsArticle._();

  factory NewsArticle.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory NewsArticle.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'NewsArticle',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'title')
    ..aOS(3, _omitFieldNames ? '' : 'summary')
    ..aOS(4, _omitFieldNames ? '' : 'content')
    ..aOS(5, _omitFieldNames ? '' : 'source')
    ..aOS(6, _omitFieldNames ? '' : 'imageUrl')
    ..pPS(7, _omitFieldNames ? '' : 'relatedSymbols')
    ..aOS(8, _omitFieldNames ? '' : 'publishedAt')
    ..aOS(9, _omitFieldNames ? '' : 'url')
    ..aOS(10, _omitFieldNames ? '' : 'category')
    ..a<$core.int>(11, _omitFieldNames ? '' : 'readTime', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  NewsArticle clone() => NewsArticle()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  NewsArticle copyWith(void Function(NewsArticle) updates) =>
      super.copyWith((message) => updates(message as NewsArticle))
          as NewsArticle;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NewsArticle create() => NewsArticle._();
  @$core.override
  NewsArticle createEmptyInstance() => create();
  static $pb.PbList<NewsArticle> createRepeated() => $pb.PbList<NewsArticle>();
  @$core.pragma('dart2js:noInline')
  static NewsArticle getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<NewsArticle>(create);
  static NewsArticle? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get title => $_getSZ(1);
  @$pb.TagNumber(2)
  set title($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearTitle() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get summary => $_getSZ(2);
  @$pb.TagNumber(3)
  set summary($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSummary() => $_has(2);
  @$pb.TagNumber(3)
  void clearSummary() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get content => $_getSZ(3);
  @$pb.TagNumber(4)
  set content($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasContent() => $_has(3);
  @$pb.TagNumber(4)
  void clearContent() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get source => $_getSZ(4);
  @$pb.TagNumber(5)
  set source($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasSource() => $_has(4);
  @$pb.TagNumber(5)
  void clearSource() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get imageUrl => $_getSZ(5);
  @$pb.TagNumber(6)
  set imageUrl($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasImageUrl() => $_has(5);
  @$pb.TagNumber(6)
  void clearImageUrl() => $_clearField(6);

  @$pb.TagNumber(7)
  $pb.PbList<$core.String> get relatedSymbols => $_getList(6);

  @$pb.TagNumber(8)
  $core.String get publishedAt => $_getSZ(7);
  @$pb.TagNumber(8)
  set publishedAt($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasPublishedAt() => $_has(7);
  @$pb.TagNumber(8)
  void clearPublishedAt() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get url => $_getSZ(8);
  @$pb.TagNumber(9)
  set url($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasUrl() => $_has(8);
  @$pb.TagNumber(9)
  void clearUrl() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get category => $_getSZ(9);
  @$pb.TagNumber(10)
  set category($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasCategory() => $_has(9);
  @$pb.TagNumber(10)
  void clearCategory() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.int get readTime => $_getIZ(10);
  @$pb.TagNumber(11)
  set readTime($core.int value) => $_setSignedInt32(10, value);
  @$pb.TagNumber(11)
  $core.bool hasReadTime() => $_has(10);
  @$pb.TagNumber(11)
  void clearReadTime() => $_clearField(11);
}

class GetMarketNewsResponse extends $pb.GeneratedMessage {
  factory GetMarketNewsResponse({
    $core.Iterable<NewsArticle>? articles,
    $core.int? total,
  }) {
    final result = create();
    if (articles != null) result.articles.addAll(articles);
    if (total != null) result.total = total;
    return result;
  }

  GetMarketNewsResponse._();

  factory GetMarketNewsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMarketNewsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMarketNewsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..pc<NewsArticle>(1, _omitFieldNames ? '' : 'articles', $pb.PbFieldType.PM,
        subBuilder: NewsArticle.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMarketNewsResponse clone() =>
      GetMarketNewsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMarketNewsResponse copyWith(
          void Function(GetMarketNewsResponse) updates) =>
      super.copyWith((message) => updates(message as GetMarketNewsResponse))
          as GetMarketNewsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMarketNewsResponse create() => GetMarketNewsResponse._();
  @$core.override
  GetMarketNewsResponse createEmptyInstance() => create();
  static $pb.PbList<GetMarketNewsResponse> createRepeated() =>
      $pb.PbList<GetMarketNewsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMarketNewsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMarketNewsResponse>(create);
  static GetMarketNewsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<NewsArticle> get articles => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);
}

class GetSectorPerformanceRequest extends $pb.GeneratedMessage {
  factory GetSectorPerformanceRequest() => create();

  GetSectorPerformanceRequest._();

  factory GetSectorPerformanceRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetSectorPerformanceRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetSectorPerformanceRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSectorPerformanceRequest clone() =>
      GetSectorPerformanceRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSectorPerformanceRequest copyWith(
          void Function(GetSectorPerformanceRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetSectorPerformanceRequest))
          as GetSectorPerformanceRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSectorPerformanceRequest create() =>
      GetSectorPerformanceRequest._();
  @$core.override
  GetSectorPerformanceRequest createEmptyInstance() => create();
  static $pb.PbList<GetSectorPerformanceRequest> createRepeated() =>
      $pb.PbList<GetSectorPerformanceRequest>();
  @$core.pragma('dart2js:noInline')
  static GetSectorPerformanceRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetSectorPerformanceRequest>(create);
  static GetSectorPerformanceRequest? _defaultInstance;
}

class SectorPerformanceInfo extends $pb.GeneratedMessage {
  factory SectorPerformanceInfo({
    $core.String? sector,
    $core.double? change,
    $core.double? changePercent,
    $core.double? marketCap,
    $core.Iterable<$core.String>? topStocks,
  }) {
    final result = create();
    if (sector != null) result.sector = sector;
    if (change != null) result.change = change;
    if (changePercent != null) result.changePercent = changePercent;
    if (marketCap != null) result.marketCap = marketCap;
    if (topStocks != null) result.topStocks.addAll(topStocks);
    return result;
  }

  SectorPerformanceInfo._();

  factory SectorPerformanceInfo.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SectorPerformanceInfo.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SectorPerformanceInfo',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'sector')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'change', $pb.PbFieldType.OD)
    ..a<$core.double>(
        3, _omitFieldNames ? '' : 'changePercent', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'marketCap', $pb.PbFieldType.OD)
    ..pPS(5, _omitFieldNames ? '' : 'topStocks')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SectorPerformanceInfo clone() =>
      SectorPerformanceInfo()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SectorPerformanceInfo copyWith(
          void Function(SectorPerformanceInfo) updates) =>
      super.copyWith((message) => updates(message as SectorPerformanceInfo))
          as SectorPerformanceInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SectorPerformanceInfo create() => SectorPerformanceInfo._();
  @$core.override
  SectorPerformanceInfo createEmptyInstance() => create();
  static $pb.PbList<SectorPerformanceInfo> createRepeated() =>
      $pb.PbList<SectorPerformanceInfo>();
  @$core.pragma('dart2js:noInline')
  static SectorPerformanceInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SectorPerformanceInfo>(create);
  static SectorPerformanceInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get sector => $_getSZ(0);
  @$pb.TagNumber(1)
  set sector($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSector() => $_has(0);
  @$pb.TagNumber(1)
  void clearSector() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get change => $_getN(1);
  @$pb.TagNumber(2)
  set change($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasChange() => $_has(1);
  @$pb.TagNumber(2)
  void clearChange() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get changePercent => $_getN(2);
  @$pb.TagNumber(3)
  set changePercent($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasChangePercent() => $_has(2);
  @$pb.TagNumber(3)
  void clearChangePercent() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get marketCap => $_getN(3);
  @$pb.TagNumber(4)
  set marketCap($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMarketCap() => $_has(3);
  @$pb.TagNumber(4)
  void clearMarketCap() => $_clearField(4);

  @$pb.TagNumber(5)
  $pb.PbList<$core.String> get topStocks => $_getList(4);
}

class GetSectorPerformanceResponse extends $pb.GeneratedMessage {
  factory GetSectorPerformanceResponse({
    $core.Iterable<SectorPerformanceInfo>? sectors,
  }) {
    final result = create();
    if (sectors != null) result.sectors.addAll(sectors);
    return result;
  }

  GetSectorPerformanceResponse._();

  factory GetSectorPerformanceResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetSectorPerformanceResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetSectorPerformanceResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..pc<SectorPerformanceInfo>(
        1, _omitFieldNames ? '' : 'sectors', $pb.PbFieldType.PM,
        subBuilder: SectorPerformanceInfo.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSectorPerformanceResponse clone() =>
      GetSectorPerformanceResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSectorPerformanceResponse copyWith(
          void Function(GetSectorPerformanceResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetSectorPerformanceResponse))
          as GetSectorPerformanceResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSectorPerformanceResponse create() =>
      GetSectorPerformanceResponse._();
  @$core.override
  GetSectorPerformanceResponse createEmptyInstance() => create();
  static $pb.PbList<GetSectorPerformanceResponse> createRepeated() =>
      $pb.PbList<GetSectorPerformanceResponse>();
  @$core.pragma('dart2js:noInline')
  static GetSectorPerformanceResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetSectorPerformanceResponse>(create);
  static GetSectorPerformanceResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<SectorPerformanceInfo> get sectors => $_getList(0);
}

class GetEarningsCalendarRequest extends $pb.GeneratedMessage {
  factory GetEarningsCalendarRequest({
    $core.String? startDate,
    $core.String? endDate,
    $core.int? limit,
  }) {
    final result = create();
    if (startDate != null) result.startDate = startDate;
    if (endDate != null) result.endDate = endDate;
    if (limit != null) result.limit = limit;
    return result;
  }

  GetEarningsCalendarRequest._();

  factory GetEarningsCalendarRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetEarningsCalendarRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetEarningsCalendarRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'startDate')
    ..aOS(2, _omitFieldNames ? '' : 'endDate')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetEarningsCalendarRequest clone() =>
      GetEarningsCalendarRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetEarningsCalendarRequest copyWith(
          void Function(GetEarningsCalendarRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetEarningsCalendarRequest))
          as GetEarningsCalendarRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetEarningsCalendarRequest create() => GetEarningsCalendarRequest._();
  @$core.override
  GetEarningsCalendarRequest createEmptyInstance() => create();
  static $pb.PbList<GetEarningsCalendarRequest> createRepeated() =>
      $pb.PbList<GetEarningsCalendarRequest>();
  @$core.pragma('dart2js:noInline')
  static GetEarningsCalendarRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetEarningsCalendarRequest>(create);
  static GetEarningsCalendarRequest? _defaultInstance;

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

  @$pb.TagNumber(3)
  $core.int get limit => $_getIZ(2);
  @$pb.TagNumber(3)
  set limit($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLimit() => $_has(2);
  @$pb.TagNumber(3)
  void clearLimit() => $_clearField(3);
}

class EarningsEvent extends $pb.GeneratedMessage {
  factory EarningsEvent({
    $core.String? symbol,
    $core.String? name,
    $core.String? reportDate,
    $core.String? fiscalQuarter,
    $core.double? epsEstimate,
    $core.double? epsActual,
    $core.double? revenueEstimate,
    $core.double? revenueActual,
  }) {
    final result = create();
    if (symbol != null) result.symbol = symbol;
    if (name != null) result.name = name;
    if (reportDate != null) result.reportDate = reportDate;
    if (fiscalQuarter != null) result.fiscalQuarter = fiscalQuarter;
    if (epsEstimate != null) result.epsEstimate = epsEstimate;
    if (epsActual != null) result.epsActual = epsActual;
    if (revenueEstimate != null) result.revenueEstimate = revenueEstimate;
    if (revenueActual != null) result.revenueActual = revenueActual;
    return result;
  }

  EarningsEvent._();

  factory EarningsEvent.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory EarningsEvent.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EarningsEvent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'symbol')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'reportDate')
    ..aOS(4, _omitFieldNames ? '' : 'fiscalQuarter')
    ..a<$core.double>(
        5, _omitFieldNames ? '' : 'epsEstimate', $pb.PbFieldType.OD)
    ..a<$core.double>(6, _omitFieldNames ? '' : 'epsActual', $pb.PbFieldType.OD)
    ..a<$core.double>(
        7, _omitFieldNames ? '' : 'revenueEstimate', $pb.PbFieldType.OD)
    ..a<$core.double>(
        8, _omitFieldNames ? '' : 'revenueActual', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EarningsEvent clone() => EarningsEvent()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EarningsEvent copyWith(void Function(EarningsEvent) updates) =>
      super.copyWith((message) => updates(message as EarningsEvent))
          as EarningsEvent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EarningsEvent create() => EarningsEvent._();
  @$core.override
  EarningsEvent createEmptyInstance() => create();
  static $pb.PbList<EarningsEvent> createRepeated() =>
      $pb.PbList<EarningsEvent>();
  @$core.pragma('dart2js:noInline')
  static EarningsEvent getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EarningsEvent>(create);
  static EarningsEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get symbol => $_getSZ(0);
  @$pb.TagNumber(1)
  set symbol($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSymbol() => $_has(0);
  @$pb.TagNumber(1)
  void clearSymbol() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get reportDate => $_getSZ(2);
  @$pb.TagNumber(3)
  set reportDate($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasReportDate() => $_has(2);
  @$pb.TagNumber(3)
  void clearReportDate() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get fiscalQuarter => $_getSZ(3);
  @$pb.TagNumber(4)
  set fiscalQuarter($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasFiscalQuarter() => $_has(3);
  @$pb.TagNumber(4)
  void clearFiscalQuarter() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get epsEstimate => $_getN(4);
  @$pb.TagNumber(5)
  set epsEstimate($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasEpsEstimate() => $_has(4);
  @$pb.TagNumber(5)
  void clearEpsEstimate() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.double get epsActual => $_getN(5);
  @$pb.TagNumber(6)
  set epsActual($core.double value) => $_setDouble(5, value);
  @$pb.TagNumber(6)
  $core.bool hasEpsActual() => $_has(5);
  @$pb.TagNumber(6)
  void clearEpsActual() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.double get revenueEstimate => $_getN(6);
  @$pb.TagNumber(7)
  set revenueEstimate($core.double value) => $_setDouble(6, value);
  @$pb.TagNumber(7)
  $core.bool hasRevenueEstimate() => $_has(6);
  @$pb.TagNumber(7)
  void clearRevenueEstimate() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.double get revenueActual => $_getN(7);
  @$pb.TagNumber(8)
  set revenueActual($core.double value) => $_setDouble(7, value);
  @$pb.TagNumber(8)
  $core.bool hasRevenueActual() => $_has(7);
  @$pb.TagNumber(8)
  void clearRevenueActual() => $_clearField(8);
}

class GetEarningsCalendarResponse extends $pb.GeneratedMessage {
  factory GetEarningsCalendarResponse({
    $core.Iterable<EarningsEvent>? events,
  }) {
    final result = create();
    if (events != null) result.events.addAll(events);
    return result;
  }

  GetEarningsCalendarResponse._();

  factory GetEarningsCalendarResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetEarningsCalendarResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetEarningsCalendarResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..pc<EarningsEvent>(1, _omitFieldNames ? '' : 'events', $pb.PbFieldType.PM,
        subBuilder: EarningsEvent.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetEarningsCalendarResponse clone() =>
      GetEarningsCalendarResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetEarningsCalendarResponse copyWith(
          void Function(GetEarningsCalendarResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetEarningsCalendarResponse))
          as GetEarningsCalendarResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetEarningsCalendarResponse create() =>
      GetEarningsCalendarResponse._();
  @$core.override
  GetEarningsCalendarResponse createEmptyInstance() => create();
  static $pb.PbList<GetEarningsCalendarResponse> createRepeated() =>
      $pb.PbList<GetEarningsCalendarResponse>();
  @$core.pragma('dart2js:noInline')
  static GetEarningsCalendarResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetEarningsCalendarResponse>(create);
  static GetEarningsCalendarResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<EarningsEvent> get events => $_getList(0);
}

class GetDividendCalendarRequest extends $pb.GeneratedMessage {
  factory GetDividendCalendarRequest({
    $core.String? startDate,
    $core.String? endDate,
    $core.int? limit,
  }) {
    final result = create();
    if (startDate != null) result.startDate = startDate;
    if (endDate != null) result.endDate = endDate;
    if (limit != null) result.limit = limit;
    return result;
  }

  GetDividendCalendarRequest._();

  factory GetDividendCalendarRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetDividendCalendarRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetDividendCalendarRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'startDate')
    ..aOS(2, _omitFieldNames ? '' : 'endDate')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetDividendCalendarRequest clone() =>
      GetDividendCalendarRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetDividendCalendarRequest copyWith(
          void Function(GetDividendCalendarRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetDividendCalendarRequest))
          as GetDividendCalendarRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetDividendCalendarRequest create() => GetDividendCalendarRequest._();
  @$core.override
  GetDividendCalendarRequest createEmptyInstance() => create();
  static $pb.PbList<GetDividendCalendarRequest> createRepeated() =>
      $pb.PbList<GetDividendCalendarRequest>();
  @$core.pragma('dart2js:noInline')
  static GetDividendCalendarRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetDividendCalendarRequest>(create);
  static GetDividendCalendarRequest? _defaultInstance;

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

  @$pb.TagNumber(3)
  $core.int get limit => $_getIZ(2);
  @$pb.TagNumber(3)
  set limit($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLimit() => $_has(2);
  @$pb.TagNumber(3)
  void clearLimit() => $_clearField(3);
}

class DividendEvent extends $pb.GeneratedMessage {
  factory DividendEvent({
    $core.String? symbol,
    $core.String? name,
    $core.String? exDate,
    $core.String? paymentDate,
    $core.String? recordDate,
    $core.double? amount,
    $core.double? yield,
  }) {
    final result = create();
    if (symbol != null) result.symbol = symbol;
    if (name != null) result.name = name;
    if (exDate != null) result.exDate = exDate;
    if (paymentDate != null) result.paymentDate = paymentDate;
    if (recordDate != null) result.recordDate = recordDate;
    if (amount != null) result.amount = amount;
    if (yield != null) result.yield = yield;
    return result;
  }

  DividendEvent._();

  factory DividendEvent.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DividendEvent.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DividendEvent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'symbol')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'exDate')
    ..aOS(4, _omitFieldNames ? '' : 'paymentDate')
    ..aOS(5, _omitFieldNames ? '' : 'recordDate')
    ..a<$core.double>(6, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..a<$core.double>(7, _omitFieldNames ? '' : 'yield', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DividendEvent clone() => DividendEvent()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DividendEvent copyWith(void Function(DividendEvent) updates) =>
      super.copyWith((message) => updates(message as DividendEvent))
          as DividendEvent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DividendEvent create() => DividendEvent._();
  @$core.override
  DividendEvent createEmptyInstance() => create();
  static $pb.PbList<DividendEvent> createRepeated() =>
      $pb.PbList<DividendEvent>();
  @$core.pragma('dart2js:noInline')
  static DividendEvent getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DividendEvent>(create);
  static DividendEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get symbol => $_getSZ(0);
  @$pb.TagNumber(1)
  set symbol($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSymbol() => $_has(0);
  @$pb.TagNumber(1)
  void clearSymbol() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get exDate => $_getSZ(2);
  @$pb.TagNumber(3)
  set exDate($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasExDate() => $_has(2);
  @$pb.TagNumber(3)
  void clearExDate() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get paymentDate => $_getSZ(3);
  @$pb.TagNumber(4)
  set paymentDate($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPaymentDate() => $_has(3);
  @$pb.TagNumber(4)
  void clearPaymentDate() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get recordDate => $_getSZ(4);
  @$pb.TagNumber(5)
  set recordDate($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasRecordDate() => $_has(4);
  @$pb.TagNumber(5)
  void clearRecordDate() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.double get amount => $_getN(5);
  @$pb.TagNumber(6)
  set amount($core.double value) => $_setDouble(5, value);
  @$pb.TagNumber(6)
  $core.bool hasAmount() => $_has(5);
  @$pb.TagNumber(6)
  void clearAmount() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.double get yield => $_getN(6);
  @$pb.TagNumber(7)
  set yield($core.double value) => $_setDouble(6, value);
  @$pb.TagNumber(7)
  $core.bool hasYield() => $_has(6);
  @$pb.TagNumber(7)
  void clearYield() => $_clearField(7);
}

class GetDividendCalendarResponse extends $pb.GeneratedMessage {
  factory GetDividendCalendarResponse({
    $core.Iterable<DividendEvent>? events,
  }) {
    final result = create();
    if (events != null) result.events.addAll(events);
    return result;
  }

  GetDividendCalendarResponse._();

  factory GetDividendCalendarResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetDividendCalendarResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetDividendCalendarResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..pc<DividendEvent>(1, _omitFieldNames ? '' : 'events', $pb.PbFieldType.PM,
        subBuilder: DividendEvent.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetDividendCalendarResponse clone() =>
      GetDividendCalendarResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetDividendCalendarResponse copyWith(
          void Function(GetDividendCalendarResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetDividendCalendarResponse))
          as GetDividendCalendarResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetDividendCalendarResponse create() =>
      GetDividendCalendarResponse._();
  @$core.override
  GetDividendCalendarResponse createEmptyInstance() => create();
  static $pb.PbList<GetDividendCalendarResponse> createRepeated() =>
      $pb.PbList<GetDividendCalendarResponse>();
  @$core.pragma('dart2js:noInline')
  static GetDividendCalendarResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetDividendCalendarResponse>(create);
  static GetDividendCalendarResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<DividendEvent> get events => $_getList(0);
}

class PriceAlertInfo extends $pb.GeneratedMessage {
  factory PriceAlertInfo({
    $core.String? id,
    $core.String? userId,
    $core.String? symbol,
    $core.String? alertType,
    $core.double? targetValue,
    $core.String? condition,
    $core.bool? isActive,
    $core.String? message,
    $core.String? triggeredAt,
    $core.String? createdAt,
    $core.String? updatedAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (userId != null) result.userId = userId;
    if (symbol != null) result.symbol = symbol;
    if (alertType != null) result.alertType = alertType;
    if (targetValue != null) result.targetValue = targetValue;
    if (condition != null) result.condition = condition;
    if (isActive != null) result.isActive = isActive;
    if (message != null) result.message = message;
    if (triggeredAt != null) result.triggeredAt = triggeredAt;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    return result;
  }

  PriceAlertInfo._();

  factory PriceAlertInfo.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PriceAlertInfo.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PriceAlertInfo',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'symbol')
    ..aOS(4, _omitFieldNames ? '' : 'alertType')
    ..a<$core.double>(
        5, _omitFieldNames ? '' : 'targetValue', $pb.PbFieldType.OD)
    ..aOS(6, _omitFieldNames ? '' : 'condition')
    ..aOB(7, _omitFieldNames ? '' : 'isActive')
    ..aOS(8, _omitFieldNames ? '' : 'message')
    ..aOS(9, _omitFieldNames ? '' : 'triggeredAt')
    ..aOS(10, _omitFieldNames ? '' : 'createdAt')
    ..aOS(11, _omitFieldNames ? '' : 'updatedAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PriceAlertInfo clone() => PriceAlertInfo()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PriceAlertInfo copyWith(void Function(PriceAlertInfo) updates) =>
      super.copyWith((message) => updates(message as PriceAlertInfo))
          as PriceAlertInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PriceAlertInfo create() => PriceAlertInfo._();
  @$core.override
  PriceAlertInfo createEmptyInstance() => create();
  static $pb.PbList<PriceAlertInfo> createRepeated() =>
      $pb.PbList<PriceAlertInfo>();
  @$core.pragma('dart2js:noInline')
  static PriceAlertInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PriceAlertInfo>(create);
  static PriceAlertInfo? _defaultInstance;

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
  $core.String get symbol => $_getSZ(2);
  @$pb.TagNumber(3)
  set symbol($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSymbol() => $_has(2);
  @$pb.TagNumber(3)
  void clearSymbol() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get alertType => $_getSZ(3);
  @$pb.TagNumber(4)
  set alertType($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAlertType() => $_has(3);
  @$pb.TagNumber(4)
  void clearAlertType() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get targetValue => $_getN(4);
  @$pb.TagNumber(5)
  set targetValue($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTargetValue() => $_has(4);
  @$pb.TagNumber(5)
  void clearTargetValue() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get condition => $_getSZ(5);
  @$pb.TagNumber(6)
  set condition($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasCondition() => $_has(5);
  @$pb.TagNumber(6)
  void clearCondition() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.bool get isActive => $_getBF(6);
  @$pb.TagNumber(7)
  set isActive($core.bool value) => $_setBool(6, value);
  @$pb.TagNumber(7)
  $core.bool hasIsActive() => $_has(6);
  @$pb.TagNumber(7)
  void clearIsActive() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get message => $_getSZ(7);
  @$pb.TagNumber(8)
  set message($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasMessage() => $_has(7);
  @$pb.TagNumber(8)
  void clearMessage() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get triggeredAt => $_getSZ(8);
  @$pb.TagNumber(9)
  set triggeredAt($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasTriggeredAt() => $_has(8);
  @$pb.TagNumber(9)
  void clearTriggeredAt() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get createdAt => $_getSZ(9);
  @$pb.TagNumber(10)
  set createdAt($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasCreatedAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearCreatedAt() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get updatedAt => $_getSZ(10);
  @$pb.TagNumber(11)
  set updatedAt($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasUpdatedAt() => $_has(10);
  @$pb.TagNumber(11)
  void clearUpdatedAt() => $_clearField(11);
}

class CreatePriceAlertRequest extends $pb.GeneratedMessage {
  factory CreatePriceAlertRequest({
    $core.String? symbol,
    $core.String? alertType,
    $core.double? targetValue,
    $core.String? condition,
    $core.String? message,
  }) {
    final result = create();
    if (symbol != null) result.symbol = symbol;
    if (alertType != null) result.alertType = alertType;
    if (targetValue != null) result.targetValue = targetValue;
    if (condition != null) result.condition = condition;
    if (message != null) result.message = message;
    return result;
  }

  CreatePriceAlertRequest._();

  factory CreatePriceAlertRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreatePriceAlertRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreatePriceAlertRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'symbol')
    ..aOS(2, _omitFieldNames ? '' : 'alertType')
    ..a<$core.double>(
        3, _omitFieldNames ? '' : 'targetValue', $pb.PbFieldType.OD)
    ..aOS(4, _omitFieldNames ? '' : 'condition')
    ..aOS(5, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreatePriceAlertRequest clone() =>
      CreatePriceAlertRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreatePriceAlertRequest copyWith(
          void Function(CreatePriceAlertRequest) updates) =>
      super.copyWith((message) => updates(message as CreatePriceAlertRequest))
          as CreatePriceAlertRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreatePriceAlertRequest create() => CreatePriceAlertRequest._();
  @$core.override
  CreatePriceAlertRequest createEmptyInstance() => create();
  static $pb.PbList<CreatePriceAlertRequest> createRepeated() =>
      $pb.PbList<CreatePriceAlertRequest>();
  @$core.pragma('dart2js:noInline')
  static CreatePriceAlertRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreatePriceAlertRequest>(create);
  static CreatePriceAlertRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get symbol => $_getSZ(0);
  @$pb.TagNumber(1)
  set symbol($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSymbol() => $_has(0);
  @$pb.TagNumber(1)
  void clearSymbol() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get alertType => $_getSZ(1);
  @$pb.TagNumber(2)
  set alertType($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAlertType() => $_has(1);
  @$pb.TagNumber(2)
  void clearAlertType() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get targetValue => $_getN(2);
  @$pb.TagNumber(3)
  set targetValue($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTargetValue() => $_has(2);
  @$pb.TagNumber(3)
  void clearTargetValue() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get condition => $_getSZ(3);
  @$pb.TagNumber(4)
  set condition($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCondition() => $_has(3);
  @$pb.TagNumber(4)
  void clearCondition() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get message => $_getSZ(4);
  @$pb.TagNumber(5)
  set message($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasMessage() => $_has(4);
  @$pb.TagNumber(5)
  void clearMessage() => $_clearField(5);
}

class CreatePriceAlertResponse extends $pb.GeneratedMessage {
  factory CreatePriceAlertResponse({
    PriceAlertInfo? alert,
    $core.String? message,
  }) {
    final result = create();
    if (alert != null) result.alert = alert;
    if (message != null) result.message = message;
    return result;
  }

  CreatePriceAlertResponse._();

  factory CreatePriceAlertResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreatePriceAlertResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreatePriceAlertResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..aOM<PriceAlertInfo>(1, _omitFieldNames ? '' : 'alert',
        subBuilder: PriceAlertInfo.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreatePriceAlertResponse clone() =>
      CreatePriceAlertResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreatePriceAlertResponse copyWith(
          void Function(CreatePriceAlertResponse) updates) =>
      super.copyWith((message) => updates(message as CreatePriceAlertResponse))
          as CreatePriceAlertResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreatePriceAlertResponse create() => CreatePriceAlertResponse._();
  @$core.override
  CreatePriceAlertResponse createEmptyInstance() => create();
  static $pb.PbList<CreatePriceAlertResponse> createRepeated() =>
      $pb.PbList<CreatePriceAlertResponse>();
  @$core.pragma('dart2js:noInline')
  static CreatePriceAlertResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreatePriceAlertResponse>(create);
  static CreatePriceAlertResponse? _defaultInstance;

  @$pb.TagNumber(1)
  PriceAlertInfo get alert => $_getN(0);
  @$pb.TagNumber(1)
  set alert(PriceAlertInfo value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasAlert() => $_has(0);
  @$pb.TagNumber(1)
  void clearAlert() => $_clearField(1);
  @$pb.TagNumber(1)
  PriceAlertInfo ensureAlert() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);
}

class GetPriceAlertsRequest extends $pb.GeneratedMessage {
  factory GetPriceAlertsRequest({
    $core.String? symbol,
  }) {
    final result = create();
    if (symbol != null) result.symbol = symbol;
    return result;
  }

  GetPriceAlertsRequest._();

  factory GetPriceAlertsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetPriceAlertsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetPriceAlertsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'symbol')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPriceAlertsRequest clone() =>
      GetPriceAlertsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPriceAlertsRequest copyWith(
          void Function(GetPriceAlertsRequest) updates) =>
      super.copyWith((message) => updates(message as GetPriceAlertsRequest))
          as GetPriceAlertsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPriceAlertsRequest create() => GetPriceAlertsRequest._();
  @$core.override
  GetPriceAlertsRequest createEmptyInstance() => create();
  static $pb.PbList<GetPriceAlertsRequest> createRepeated() =>
      $pb.PbList<GetPriceAlertsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetPriceAlertsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetPriceAlertsRequest>(create);
  static GetPriceAlertsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get symbol => $_getSZ(0);
  @$pb.TagNumber(1)
  set symbol($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSymbol() => $_has(0);
  @$pb.TagNumber(1)
  void clearSymbol() => $_clearField(1);
}

class GetPriceAlertsResponse extends $pb.GeneratedMessage {
  factory GetPriceAlertsResponse({
    $core.Iterable<PriceAlertInfo>? alerts,
    $core.int? total,
  }) {
    final result = create();
    if (alerts != null) result.alerts.addAll(alerts);
    if (total != null) result.total = total;
    return result;
  }

  GetPriceAlertsResponse._();

  factory GetPriceAlertsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetPriceAlertsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetPriceAlertsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..pc<PriceAlertInfo>(1, _omitFieldNames ? '' : 'alerts', $pb.PbFieldType.PM,
        subBuilder: PriceAlertInfo.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPriceAlertsResponse clone() =>
      GetPriceAlertsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPriceAlertsResponse copyWith(
          void Function(GetPriceAlertsResponse) updates) =>
      super.copyWith((message) => updates(message as GetPriceAlertsResponse))
          as GetPriceAlertsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPriceAlertsResponse create() => GetPriceAlertsResponse._();
  @$core.override
  GetPriceAlertsResponse createEmptyInstance() => create();
  static $pb.PbList<GetPriceAlertsResponse> createRepeated() =>
      $pb.PbList<GetPriceAlertsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetPriceAlertsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetPriceAlertsResponse>(create);
  static GetPriceAlertsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<PriceAlertInfo> get alerts => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);
}

class UpdatePriceAlertRequest extends $pb.GeneratedMessage {
  factory UpdatePriceAlertRequest({
    $core.String? alertId,
    $core.String? alertType,
    $core.double? targetValue,
    $core.String? condition,
    $core.bool? isActive,
    $core.String? message,
  }) {
    final result = create();
    if (alertId != null) result.alertId = alertId;
    if (alertType != null) result.alertType = alertType;
    if (targetValue != null) result.targetValue = targetValue;
    if (condition != null) result.condition = condition;
    if (isActive != null) result.isActive = isActive;
    if (message != null) result.message = message;
    return result;
  }

  UpdatePriceAlertRequest._();

  factory UpdatePriceAlertRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdatePriceAlertRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdatePriceAlertRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'alertId')
    ..aOS(2, _omitFieldNames ? '' : 'alertType')
    ..a<$core.double>(
        3, _omitFieldNames ? '' : 'targetValue', $pb.PbFieldType.OD)
    ..aOS(4, _omitFieldNames ? '' : 'condition')
    ..aOB(5, _omitFieldNames ? '' : 'isActive')
    ..aOS(6, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdatePriceAlertRequest clone() =>
      UpdatePriceAlertRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdatePriceAlertRequest copyWith(
          void Function(UpdatePriceAlertRequest) updates) =>
      super.copyWith((message) => updates(message as UpdatePriceAlertRequest))
          as UpdatePriceAlertRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdatePriceAlertRequest create() => UpdatePriceAlertRequest._();
  @$core.override
  UpdatePriceAlertRequest createEmptyInstance() => create();
  static $pb.PbList<UpdatePriceAlertRequest> createRepeated() =>
      $pb.PbList<UpdatePriceAlertRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdatePriceAlertRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdatePriceAlertRequest>(create);
  static UpdatePriceAlertRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get alertId => $_getSZ(0);
  @$pb.TagNumber(1)
  set alertId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAlertId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAlertId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get alertType => $_getSZ(1);
  @$pb.TagNumber(2)
  set alertType($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAlertType() => $_has(1);
  @$pb.TagNumber(2)
  void clearAlertType() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get targetValue => $_getN(2);
  @$pb.TagNumber(3)
  set targetValue($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTargetValue() => $_has(2);
  @$pb.TagNumber(3)
  void clearTargetValue() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get condition => $_getSZ(3);
  @$pb.TagNumber(4)
  set condition($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCondition() => $_has(3);
  @$pb.TagNumber(4)
  void clearCondition() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.bool get isActive => $_getBF(4);
  @$pb.TagNumber(5)
  set isActive($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasIsActive() => $_has(4);
  @$pb.TagNumber(5)
  void clearIsActive() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get message => $_getSZ(5);
  @$pb.TagNumber(6)
  set message($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasMessage() => $_has(5);
  @$pb.TagNumber(6)
  void clearMessage() => $_clearField(6);
}

class UpdatePriceAlertResponse extends $pb.GeneratedMessage {
  factory UpdatePriceAlertResponse({
    PriceAlertInfo? alert,
    $core.String? message,
  }) {
    final result = create();
    if (alert != null) result.alert = alert;
    if (message != null) result.message = message;
    return result;
  }

  UpdatePriceAlertResponse._();

  factory UpdatePriceAlertResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdatePriceAlertResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdatePriceAlertResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..aOM<PriceAlertInfo>(1, _omitFieldNames ? '' : 'alert',
        subBuilder: PriceAlertInfo.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdatePriceAlertResponse clone() =>
      UpdatePriceAlertResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdatePriceAlertResponse copyWith(
          void Function(UpdatePriceAlertResponse) updates) =>
      super.copyWith((message) => updates(message as UpdatePriceAlertResponse))
          as UpdatePriceAlertResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdatePriceAlertResponse create() => UpdatePriceAlertResponse._();
  @$core.override
  UpdatePriceAlertResponse createEmptyInstance() => create();
  static $pb.PbList<UpdatePriceAlertResponse> createRepeated() =>
      $pb.PbList<UpdatePriceAlertResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdatePriceAlertResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdatePriceAlertResponse>(create);
  static UpdatePriceAlertResponse? _defaultInstance;

  @$pb.TagNumber(1)
  PriceAlertInfo get alert => $_getN(0);
  @$pb.TagNumber(1)
  set alert(PriceAlertInfo value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasAlert() => $_has(0);
  @$pb.TagNumber(1)
  void clearAlert() => $_clearField(1);
  @$pb.TagNumber(1)
  PriceAlertInfo ensureAlert() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);
}

class DeletePriceAlertRequest extends $pb.GeneratedMessage {
  factory DeletePriceAlertRequest({
    $core.String? alertId,
  }) {
    final result = create();
    if (alertId != null) result.alertId = alertId;
    return result;
  }

  DeletePriceAlertRequest._();

  factory DeletePriceAlertRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeletePriceAlertRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeletePriceAlertRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'alertId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeletePriceAlertRequest clone() =>
      DeletePriceAlertRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeletePriceAlertRequest copyWith(
          void Function(DeletePriceAlertRequest) updates) =>
      super.copyWith((message) => updates(message as DeletePriceAlertRequest))
          as DeletePriceAlertRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeletePriceAlertRequest create() => DeletePriceAlertRequest._();
  @$core.override
  DeletePriceAlertRequest createEmptyInstance() => create();
  static $pb.PbList<DeletePriceAlertRequest> createRepeated() =>
      $pb.PbList<DeletePriceAlertRequest>();
  @$core.pragma('dart2js:noInline')
  static DeletePriceAlertRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeletePriceAlertRequest>(create);
  static DeletePriceAlertRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get alertId => $_getSZ(0);
  @$pb.TagNumber(1)
  set alertId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAlertId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAlertId() => $_clearField(1);
}

class DeletePriceAlertResponse extends $pb.GeneratedMessage {
  factory DeletePriceAlertResponse({
    $core.bool? success,
    $core.String? message,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    return result;
  }

  DeletePriceAlertResponse._();

  factory DeletePriceAlertResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeletePriceAlertResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeletePriceAlertResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeletePriceAlertResponse clone() =>
      DeletePriceAlertResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeletePriceAlertResponse copyWith(
          void Function(DeletePriceAlertResponse) updates) =>
      super.copyWith((message) => updates(message as DeletePriceAlertResponse))
          as DeletePriceAlertResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeletePriceAlertResponse create() => DeletePriceAlertResponse._();
  @$core.override
  DeletePriceAlertResponse createEmptyInstance() => create();
  static $pb.PbList<DeletePriceAlertResponse> createRepeated() =>
      $pb.PbList<DeletePriceAlertResponse>();
  @$core.pragma('dart2js:noInline')
  static DeletePriceAlertResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeletePriceAlertResponse>(create);
  static DeletePriceAlertResponse? _defaultInstance;

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

class EnsureBrokerAccountRequest extends $pb.GeneratedMessage {
  factory EnsureBrokerAccountRequest({
    $core.String? provider,
  }) {
    final result = create();
    if (provider != null) result.provider = provider;
    return result;
  }

  EnsureBrokerAccountRequest._();

  factory EnsureBrokerAccountRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory EnsureBrokerAccountRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EnsureBrokerAccountRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'provider')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EnsureBrokerAccountRequest clone() =>
      EnsureBrokerAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EnsureBrokerAccountRequest copyWith(
          void Function(EnsureBrokerAccountRequest) updates) =>
      super.copyWith(
              (message) => updates(message as EnsureBrokerAccountRequest))
          as EnsureBrokerAccountRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EnsureBrokerAccountRequest create() => EnsureBrokerAccountRequest._();
  @$core.override
  EnsureBrokerAccountRequest createEmptyInstance() => create();
  static $pb.PbList<EnsureBrokerAccountRequest> createRepeated() =>
      $pb.PbList<EnsureBrokerAccountRequest>();
  @$core.pragma('dart2js:noInline')
  static EnsureBrokerAccountRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EnsureBrokerAccountRequest>(create);
  static EnsureBrokerAccountRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get provider => $_getSZ(0);
  @$pb.TagNumber(1)
  set provider($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasProvider() => $_has(0);
  @$pb.TagNumber(1)
  void clearProvider() => $_clearField(1);
}

class EnsureBrokerAccountResponse extends $pb.GeneratedMessage {
  factory EnsureBrokerAccountResponse({
    $core.String? provider,
    $core.String? externalAccountId,
    $core.String? status,
    $core.String? message,
  }) {
    final result = create();
    if (provider != null) result.provider = provider;
    if (externalAccountId != null) result.externalAccountId = externalAccountId;
    if (status != null) result.status = status;
    if (message != null) result.message = message;
    return result;
  }

  EnsureBrokerAccountResponse._();

  factory EnsureBrokerAccountResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory EnsureBrokerAccountResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EnsureBrokerAccountResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'provider')
    ..aOS(2, _omitFieldNames ? '' : 'externalAccountId')
    ..aOS(3, _omitFieldNames ? '' : 'status')
    ..aOS(4, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EnsureBrokerAccountResponse clone() =>
      EnsureBrokerAccountResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EnsureBrokerAccountResponse copyWith(
          void Function(EnsureBrokerAccountResponse) updates) =>
      super.copyWith(
              (message) => updates(message as EnsureBrokerAccountResponse))
          as EnsureBrokerAccountResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EnsureBrokerAccountResponse create() =>
      EnsureBrokerAccountResponse._();
  @$core.override
  EnsureBrokerAccountResponse createEmptyInstance() => create();
  static $pb.PbList<EnsureBrokerAccountResponse> createRepeated() =>
      $pb.PbList<EnsureBrokerAccountResponse>();
  @$core.pragma('dart2js:noInline')
  static EnsureBrokerAccountResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EnsureBrokerAccountResponse>(create);
  static EnsureBrokerAccountResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get provider => $_getSZ(0);
  @$pb.TagNumber(1)
  set provider($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasProvider() => $_has(0);
  @$pb.TagNumber(1)
  void clearProvider() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get externalAccountId => $_getSZ(1);
  @$pb.TagNumber(2)
  set externalAccountId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasExternalAccountId() => $_has(1);
  @$pb.TagNumber(2)
  void clearExternalAccountId() => $_clearField(2);

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
}

class GetBrokerOnboardingStatusRequest extends $pb.GeneratedMessage {
  factory GetBrokerOnboardingStatusRequest({
    $core.String? provider,
  }) {
    final result = create();
    if (provider != null) result.provider = provider;
    return result;
  }

  GetBrokerOnboardingStatusRequest._();

  factory GetBrokerOnboardingStatusRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetBrokerOnboardingStatusRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetBrokerOnboardingStatusRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'provider')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetBrokerOnboardingStatusRequest clone() =>
      GetBrokerOnboardingStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetBrokerOnboardingStatusRequest copyWith(
          void Function(GetBrokerOnboardingStatusRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetBrokerOnboardingStatusRequest))
          as GetBrokerOnboardingStatusRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetBrokerOnboardingStatusRequest create() =>
      GetBrokerOnboardingStatusRequest._();
  @$core.override
  GetBrokerOnboardingStatusRequest createEmptyInstance() => create();
  static $pb.PbList<GetBrokerOnboardingStatusRequest> createRepeated() =>
      $pb.PbList<GetBrokerOnboardingStatusRequest>();
  @$core.pragma('dart2js:noInline')
  static GetBrokerOnboardingStatusRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetBrokerOnboardingStatusRequest>(
          create);
  static GetBrokerOnboardingStatusRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get provider => $_getSZ(0);
  @$pb.TagNumber(1)
  set provider($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasProvider() => $_has(0);
  @$pb.TagNumber(1)
  void clearProvider() => $_clearField(1);
}

class GetBrokerOnboardingStatusResponse extends $pb.GeneratedMessage {
  factory GetBrokerOnboardingStatusResponse({
    $core.Iterable<BrokerAccountLink>? links,
  }) {
    final result = create();
    if (links != null) result.links.addAll(links);
    return result;
  }

  GetBrokerOnboardingStatusResponse._();

  factory GetBrokerOnboardingStatusResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetBrokerOnboardingStatusResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetBrokerOnboardingStatusResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..pc<BrokerAccountLink>(
        1, _omitFieldNames ? '' : 'links', $pb.PbFieldType.PM,
        subBuilder: BrokerAccountLink.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetBrokerOnboardingStatusResponse clone() =>
      GetBrokerOnboardingStatusResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetBrokerOnboardingStatusResponse copyWith(
          void Function(GetBrokerOnboardingStatusResponse) updates) =>
      super.copyWith((message) =>
              updates(message as GetBrokerOnboardingStatusResponse))
          as GetBrokerOnboardingStatusResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetBrokerOnboardingStatusResponse create() =>
      GetBrokerOnboardingStatusResponse._();
  @$core.override
  GetBrokerOnboardingStatusResponse createEmptyInstance() => create();
  static $pb.PbList<GetBrokerOnboardingStatusResponse> createRepeated() =>
      $pb.PbList<GetBrokerOnboardingStatusResponse>();
  @$core.pragma('dart2js:noInline')
  static GetBrokerOnboardingStatusResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetBrokerOnboardingStatusResponse>(
          create);
  static GetBrokerOnboardingStatusResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<BrokerAccountLink> get links => $_getList(0);
}

class BrokerAccountLink extends $pb.GeneratedMessage {
  factory BrokerAccountLink({
    $core.String? provider,
    $core.String? externalAccountId,
    $core.String? status,
    $core.String? createdAt,
    $core.String? updatedAt,
  }) {
    final result = create();
    if (provider != null) result.provider = provider;
    if (externalAccountId != null) result.externalAccountId = externalAccountId;
    if (status != null) result.status = status;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    return result;
  }

  BrokerAccountLink._();

  factory BrokerAccountLink.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BrokerAccountLink.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BrokerAccountLink',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'provider')
    ..aOS(2, _omitFieldNames ? '' : 'externalAccountId')
    ..aOS(3, _omitFieldNames ? '' : 'status')
    ..aOS(4, _omitFieldNames ? '' : 'createdAt')
    ..aOS(5, _omitFieldNames ? '' : 'updatedAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BrokerAccountLink clone() => BrokerAccountLink()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BrokerAccountLink copyWith(void Function(BrokerAccountLink) updates) =>
      super.copyWith((message) => updates(message as BrokerAccountLink))
          as BrokerAccountLink;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BrokerAccountLink create() => BrokerAccountLink._();
  @$core.override
  BrokerAccountLink createEmptyInstance() => create();
  static $pb.PbList<BrokerAccountLink> createRepeated() =>
      $pb.PbList<BrokerAccountLink>();
  @$core.pragma('dart2js:noInline')
  static BrokerAccountLink getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BrokerAccountLink>(create);
  static BrokerAccountLink? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get provider => $_getSZ(0);
  @$pb.TagNumber(1)
  set provider($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasProvider() => $_has(0);
  @$pb.TagNumber(1)
  void clearProvider() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get externalAccountId => $_getSZ(1);
  @$pb.TagNumber(2)
  set externalAccountId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasExternalAccountId() => $_has(1);
  @$pb.TagNumber(2)
  void clearExternalAccountId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get status => $_getSZ(2);
  @$pb.TagNumber(3)
  set status($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatus() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get createdAt => $_getSZ(3);
  @$pb.TagNumber(4)
  set createdAt($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCreatedAt() => $_has(3);
  @$pb.TagNumber(4)
  void clearCreatedAt() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get updatedAt => $_getSZ(4);
  @$pb.TagNumber(5)
  set updatedAt($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasUpdatedAt() => $_has(4);
  @$pb.TagNumber(5)
  void clearUpdatedAt() => $_clearField(5);
}

class AssetInfo extends $pb.GeneratedMessage {
  factory AssetInfo({
    $core.String? id,
    $core.String? symbol,
    $core.String? name,
    $core.String? assetType,
    $core.String? provider,
    $core.String? region,
    $core.String? currency,
    $core.String? riskLevel,
    $core.String? yieldType,
    $core.double? expectedYield,
    $core.String? description,
    $core.String? exchange,
    $core.String? sector,
    $core.bool? isFeatured,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (symbol != null) result.symbol = symbol;
    if (name != null) result.name = name;
    if (assetType != null) result.assetType = assetType;
    if (provider != null) result.provider = provider;
    if (region != null) result.region = region;
    if (currency != null) result.currency = currency;
    if (riskLevel != null) result.riskLevel = riskLevel;
    if (yieldType != null) result.yieldType = yieldType;
    if (expectedYield != null) result.expectedYield = expectedYield;
    if (description != null) result.description = description;
    if (exchange != null) result.exchange = exchange;
    if (sector != null) result.sector = sector;
    if (isFeatured != null) result.isFeatured = isFeatured;
    return result;
  }

  AssetInfo._();

  factory AssetInfo.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AssetInfo.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AssetInfo',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'symbol')
    ..aOS(3, _omitFieldNames ? '' : 'name')
    ..aOS(4, _omitFieldNames ? '' : 'assetType')
    ..aOS(5, _omitFieldNames ? '' : 'provider')
    ..aOS(6, _omitFieldNames ? '' : 'region')
    ..aOS(7, _omitFieldNames ? '' : 'currency')
    ..aOS(8, _omitFieldNames ? '' : 'riskLevel')
    ..aOS(9, _omitFieldNames ? '' : 'yieldType')
    ..a<$core.double>(
        10, _omitFieldNames ? '' : 'expectedYield', $pb.PbFieldType.OD)
    ..aOS(11, _omitFieldNames ? '' : 'description')
    ..aOS(12, _omitFieldNames ? '' : 'exchange')
    ..aOS(13, _omitFieldNames ? '' : 'sector')
    ..aOB(14, _omitFieldNames ? '' : 'isFeatured')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AssetInfo clone() => AssetInfo()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AssetInfo copyWith(void Function(AssetInfo) updates) =>
      super.copyWith((message) => updates(message as AssetInfo)) as AssetInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AssetInfo create() => AssetInfo._();
  @$core.override
  AssetInfo createEmptyInstance() => create();
  static $pb.PbList<AssetInfo> createRepeated() => $pb.PbList<AssetInfo>();
  @$core.pragma('dart2js:noInline')
  static AssetInfo getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AssetInfo>(create);
  static AssetInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get symbol => $_getSZ(1);
  @$pb.TagNumber(2)
  set symbol($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSymbol() => $_has(1);
  @$pb.TagNumber(2)
  void clearSymbol() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get assetType => $_getSZ(3);
  @$pb.TagNumber(4)
  set assetType($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAssetType() => $_has(3);
  @$pb.TagNumber(4)
  void clearAssetType() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get provider => $_getSZ(4);
  @$pb.TagNumber(5)
  set provider($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasProvider() => $_has(4);
  @$pb.TagNumber(5)
  void clearProvider() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get region => $_getSZ(5);
  @$pb.TagNumber(6)
  set region($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasRegion() => $_has(5);
  @$pb.TagNumber(6)
  void clearRegion() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get currency => $_getSZ(6);
  @$pb.TagNumber(7)
  set currency($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasCurrency() => $_has(6);
  @$pb.TagNumber(7)
  void clearCurrency() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get riskLevel => $_getSZ(7);
  @$pb.TagNumber(8)
  set riskLevel($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasRiskLevel() => $_has(7);
  @$pb.TagNumber(8)
  void clearRiskLevel() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get yieldType => $_getSZ(8);
  @$pb.TagNumber(9)
  set yieldType($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasYieldType() => $_has(8);
  @$pb.TagNumber(9)
  void clearYieldType() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.double get expectedYield => $_getN(9);
  @$pb.TagNumber(10)
  set expectedYield($core.double value) => $_setDouble(9, value);
  @$pb.TagNumber(10)
  $core.bool hasExpectedYield() => $_has(9);
  @$pb.TagNumber(10)
  void clearExpectedYield() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get description => $_getSZ(10);
  @$pb.TagNumber(11)
  set description($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasDescription() => $_has(10);
  @$pb.TagNumber(11)
  void clearDescription() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get exchange => $_getSZ(11);
  @$pb.TagNumber(12)
  set exchange($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasExchange() => $_has(11);
  @$pb.TagNumber(12)
  void clearExchange() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get sector => $_getSZ(12);
  @$pb.TagNumber(13)
  set sector($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasSector() => $_has(12);
  @$pb.TagNumber(13)
  void clearSector() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.bool get isFeatured => $_getBF(13);
  @$pb.TagNumber(14)
  set isFeatured($core.bool value) => $_setBool(13, value);
  @$pb.TagNumber(14)
  $core.bool hasIsFeatured() => $_has(13);
  @$pb.TagNumber(14)
  void clearIsFeatured() => $_clearField(14);
}

class ListAssetsRequest extends $pb.GeneratedMessage {
  factory ListAssetsRequest({
    $core.String? assetType,
    $core.String? region,
    $core.String? riskLevel,
    $core.String? provider,
    $core.String? yieldType,
    $core.bool? featuredOnly,
    $core.String? query,
    $core.int? limit,
    $core.int? offset,
  }) {
    final result = create();
    if (assetType != null) result.assetType = assetType;
    if (region != null) result.region = region;
    if (riskLevel != null) result.riskLevel = riskLevel;
    if (provider != null) result.provider = provider;
    if (yieldType != null) result.yieldType = yieldType;
    if (featuredOnly != null) result.featuredOnly = featuredOnly;
    if (query != null) result.query = query;
    if (limit != null) result.limit = limit;
    if (offset != null) result.offset = offset;
    return result;
  }

  ListAssetsRequest._();

  factory ListAssetsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListAssetsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListAssetsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'assetType')
    ..aOS(2, _omitFieldNames ? '' : 'region')
    ..aOS(3, _omitFieldNames ? '' : 'riskLevel')
    ..aOS(4, _omitFieldNames ? '' : 'provider')
    ..aOS(5, _omitFieldNames ? '' : 'yieldType')
    ..aOB(6, _omitFieldNames ? '' : 'featuredOnly')
    ..aOS(7, _omitFieldNames ? '' : 'query')
    ..a<$core.int>(8, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(9, _omitFieldNames ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListAssetsRequest clone() => ListAssetsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListAssetsRequest copyWith(void Function(ListAssetsRequest) updates) =>
      super.copyWith((message) => updates(message as ListAssetsRequest))
          as ListAssetsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListAssetsRequest create() => ListAssetsRequest._();
  @$core.override
  ListAssetsRequest createEmptyInstance() => create();
  static $pb.PbList<ListAssetsRequest> createRepeated() =>
      $pb.PbList<ListAssetsRequest>();
  @$core.pragma('dart2js:noInline')
  static ListAssetsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListAssetsRequest>(create);
  static ListAssetsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get assetType => $_getSZ(0);
  @$pb.TagNumber(1)
  set assetType($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAssetType() => $_has(0);
  @$pb.TagNumber(1)
  void clearAssetType() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get region => $_getSZ(1);
  @$pb.TagNumber(2)
  set region($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRegion() => $_has(1);
  @$pb.TagNumber(2)
  void clearRegion() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get riskLevel => $_getSZ(2);
  @$pb.TagNumber(3)
  set riskLevel($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasRiskLevel() => $_has(2);
  @$pb.TagNumber(3)
  void clearRiskLevel() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get provider => $_getSZ(3);
  @$pb.TagNumber(4)
  set provider($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasProvider() => $_has(3);
  @$pb.TagNumber(4)
  void clearProvider() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get yieldType => $_getSZ(4);
  @$pb.TagNumber(5)
  set yieldType($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasYieldType() => $_has(4);
  @$pb.TagNumber(5)
  void clearYieldType() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.bool get featuredOnly => $_getBF(5);
  @$pb.TagNumber(6)
  set featuredOnly($core.bool value) => $_setBool(5, value);
  @$pb.TagNumber(6)
  $core.bool hasFeaturedOnly() => $_has(5);
  @$pb.TagNumber(6)
  void clearFeaturedOnly() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get query => $_getSZ(6);
  @$pb.TagNumber(7)
  set query($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasQuery() => $_has(6);
  @$pb.TagNumber(7)
  void clearQuery() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.int get limit => $_getIZ(7);
  @$pb.TagNumber(8)
  set limit($core.int value) => $_setSignedInt32(7, value);
  @$pb.TagNumber(8)
  $core.bool hasLimit() => $_has(7);
  @$pb.TagNumber(8)
  void clearLimit() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.int get offset => $_getIZ(8);
  @$pb.TagNumber(9)
  set offset($core.int value) => $_setSignedInt32(8, value);
  @$pb.TagNumber(9)
  $core.bool hasOffset() => $_has(8);
  @$pb.TagNumber(9)
  void clearOffset() => $_clearField(9);
}

class ListAssetsResponse extends $pb.GeneratedMessage {
  factory ListAssetsResponse({
    $core.Iterable<AssetInfo>? assets,
    $core.int? total,
  }) {
    final result = create();
    if (assets != null) result.assets.addAll(assets);
    if (total != null) result.total = total;
    return result;
  }

  ListAssetsResponse._();

  factory ListAssetsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListAssetsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListAssetsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..pc<AssetInfo>(1, _omitFieldNames ? '' : 'assets', $pb.PbFieldType.PM,
        subBuilder: AssetInfo.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListAssetsResponse clone() => ListAssetsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListAssetsResponse copyWith(void Function(ListAssetsResponse) updates) =>
      super.copyWith((message) => updates(message as ListAssetsResponse))
          as ListAssetsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListAssetsResponse create() => ListAssetsResponse._();
  @$core.override
  ListAssetsResponse createEmptyInstance() => create();
  static $pb.PbList<ListAssetsResponse> createRepeated() =>
      $pb.PbList<ListAssetsResponse>();
  @$core.pragma('dart2js:noInline')
  static ListAssetsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListAssetsResponse>(create);
  static ListAssetsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<AssetInfo> get assets => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);
}

class GetAssetDetailsRequest extends $pb.GeneratedMessage {
  factory GetAssetDetailsRequest({
    $core.String? symbol,
  }) {
    final result = create();
    if (symbol != null) result.symbol = symbol;
    return result;
  }

  GetAssetDetailsRequest._();

  factory GetAssetDetailsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetAssetDetailsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetAssetDetailsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'symbol')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAssetDetailsRequest clone() =>
      GetAssetDetailsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAssetDetailsRequest copyWith(
          void Function(GetAssetDetailsRequest) updates) =>
      super.copyWith((message) => updates(message as GetAssetDetailsRequest))
          as GetAssetDetailsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAssetDetailsRequest create() => GetAssetDetailsRequest._();
  @$core.override
  GetAssetDetailsRequest createEmptyInstance() => create();
  static $pb.PbList<GetAssetDetailsRequest> createRepeated() =>
      $pb.PbList<GetAssetDetailsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetAssetDetailsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetAssetDetailsRequest>(create);
  static GetAssetDetailsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get symbol => $_getSZ(0);
  @$pb.TagNumber(1)
  set symbol($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSymbol() => $_has(0);
  @$pb.TagNumber(1)
  void clearSymbol() => $_clearField(1);
}

class GetAssetDetailsResponse extends $pb.GeneratedMessage {
  factory GetAssetDetailsResponse({
    AssetInfo? asset,
    $core.double? currentPrice,
    $core.double? change24h,
    $core.double? changePercentage,
  }) {
    final result = create();
    if (asset != null) result.asset = asset;
    if (currentPrice != null) result.currentPrice = currentPrice;
    if (change24h != null) result.change24h = change24h;
    if (changePercentage != null) result.changePercentage = changePercentage;
    return result;
  }

  GetAssetDetailsResponse._();

  factory GetAssetDetailsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetAssetDetailsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetAssetDetailsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..aOM<AssetInfo>(1, _omitFieldNames ? '' : 'asset',
        subBuilder: AssetInfo.create)
    ..a<$core.double>(
        2, _omitFieldNames ? '' : 'currentPrice', $pb.PbFieldType.OD)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'change24h', $pb.PbFieldType.OD,
        protoName: 'change_24h')
    ..a<$core.double>(
        4, _omitFieldNames ? '' : 'changePercentage', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAssetDetailsResponse clone() =>
      GetAssetDetailsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAssetDetailsResponse copyWith(
          void Function(GetAssetDetailsResponse) updates) =>
      super.copyWith((message) => updates(message as GetAssetDetailsResponse))
          as GetAssetDetailsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAssetDetailsResponse create() => GetAssetDetailsResponse._();
  @$core.override
  GetAssetDetailsResponse createEmptyInstance() => create();
  static $pb.PbList<GetAssetDetailsResponse> createRepeated() =>
      $pb.PbList<GetAssetDetailsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetAssetDetailsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetAssetDetailsResponse>(create);
  static GetAssetDetailsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  AssetInfo get asset => $_getN(0);
  @$pb.TagNumber(1)
  set asset(AssetInfo value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasAsset() => $_has(0);
  @$pb.TagNumber(1)
  void clearAsset() => $_clearField(1);
  @$pb.TagNumber(1)
  AssetInfo ensureAsset() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.double get currentPrice => $_getN(1);
  @$pb.TagNumber(2)
  set currentPrice($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCurrentPrice() => $_has(1);
  @$pb.TagNumber(2)
  void clearCurrentPrice() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get change24h => $_getN(2);
  @$pb.TagNumber(3)
  set change24h($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasChange24h() => $_has(2);
  @$pb.TagNumber(3)
  void clearChange24h() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get changePercentage => $_getN(3);
  @$pb.TagNumber(4)
  set changePercentage($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasChangePercentage() => $_has(3);
  @$pb.TagNumber(4)
  void clearChangePercentage() => $_clearField(4);
}

class GetFeaturedAssetsRequest extends $pb.GeneratedMessage {
  factory GetFeaturedAssetsRequest() => create();

  GetFeaturedAssetsRequest._();

  factory GetFeaturedAssetsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetFeaturedAssetsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetFeaturedAssetsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetFeaturedAssetsRequest clone() =>
      GetFeaturedAssetsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetFeaturedAssetsRequest copyWith(
          void Function(GetFeaturedAssetsRequest) updates) =>
      super.copyWith((message) => updates(message as GetFeaturedAssetsRequest))
          as GetFeaturedAssetsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetFeaturedAssetsRequest create() => GetFeaturedAssetsRequest._();
  @$core.override
  GetFeaturedAssetsRequest createEmptyInstance() => create();
  static $pb.PbList<GetFeaturedAssetsRequest> createRepeated() =>
      $pb.PbList<GetFeaturedAssetsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetFeaturedAssetsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetFeaturedAssetsRequest>(create);
  static GetFeaturedAssetsRequest? _defaultInstance;
}

class AssetCategory extends $pb.GeneratedMessage {
  factory AssetCategory({
    $core.String? name,
    $core.String? displayName,
    $core.Iterable<AssetInfo>? assets,
  }) {
    final result = create();
    if (name != null) result.name = name;
    if (displayName != null) result.displayName = displayName;
    if (assets != null) result.assets.addAll(assets);
    return result;
  }

  AssetCategory._();

  factory AssetCategory.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AssetCategory.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AssetCategory',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOS(2, _omitFieldNames ? '' : 'displayName')
    ..pc<AssetInfo>(3, _omitFieldNames ? '' : 'assets', $pb.PbFieldType.PM,
        subBuilder: AssetInfo.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AssetCategory clone() => AssetCategory()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AssetCategory copyWith(void Function(AssetCategory) updates) =>
      super.copyWith((message) => updates(message as AssetCategory))
          as AssetCategory;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AssetCategory create() => AssetCategory._();
  @$core.override
  AssetCategory createEmptyInstance() => create();
  static $pb.PbList<AssetCategory> createRepeated() =>
      $pb.PbList<AssetCategory>();
  @$core.pragma('dart2js:noInline')
  static AssetCategory getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AssetCategory>(create);
  static AssetCategory? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get displayName => $_getSZ(1);
  @$pb.TagNumber(2)
  set displayName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDisplayName() => $_has(1);
  @$pb.TagNumber(2)
  void clearDisplayName() => $_clearField(2);

  @$pb.TagNumber(3)
  $pb.PbList<AssetInfo> get assets => $_getList(2);
}

class GetAssetCategoriesRequest extends $pb.GeneratedMessage {
  factory GetAssetCategoriesRequest() => create();

  GetAssetCategoriesRequest._();

  factory GetAssetCategoriesRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetAssetCategoriesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetAssetCategoriesRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAssetCategoriesRequest clone() =>
      GetAssetCategoriesRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAssetCategoriesRequest copyWith(
          void Function(GetAssetCategoriesRequest) updates) =>
      super.copyWith((message) => updates(message as GetAssetCategoriesRequest))
          as GetAssetCategoriesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAssetCategoriesRequest create() => GetAssetCategoriesRequest._();
  @$core.override
  GetAssetCategoriesRequest createEmptyInstance() => create();
  static $pb.PbList<GetAssetCategoriesRequest> createRepeated() =>
      $pb.PbList<GetAssetCategoriesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetAssetCategoriesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetAssetCategoriesRequest>(create);
  static GetAssetCategoriesRequest? _defaultInstance;
}

class GetAssetCategoriesResponse extends $pb.GeneratedMessage {
  factory GetAssetCategoriesResponse({
    $core.Iterable<AssetCategory>? categories,
  }) {
    final result = create();
    if (categories != null) result.categories.addAll(categories);
    return result;
  }

  GetAssetCategoriesResponse._();

  factory GetAssetCategoriesResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetAssetCategoriesResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetAssetCategoriesResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..pc<AssetCategory>(
        1, _omitFieldNames ? '' : 'categories', $pb.PbFieldType.PM,
        subBuilder: AssetCategory.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAssetCategoriesResponse clone() =>
      GetAssetCategoriesResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAssetCategoriesResponse copyWith(
          void Function(GetAssetCategoriesResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetAssetCategoriesResponse))
          as GetAssetCategoriesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAssetCategoriesResponse create() => GetAssetCategoriesResponse._();
  @$core.override
  GetAssetCategoriesResponse createEmptyInstance() => create();
  static $pb.PbList<GetAssetCategoriesResponse> createRepeated() =>
      $pb.PbList<GetAssetCategoriesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetAssetCategoriesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetAssetCategoriesResponse>(create);
  static GetAssetCategoriesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<AssetCategory> get categories => $_getList(0);
}

class GetFXRateRequest extends $pb.GeneratedMessage {
  factory GetFXRateRequest({
    $core.String? fromCurrency,
    $core.String? toCurrency,
  }) {
    final result = create();
    if (fromCurrency != null) result.fromCurrency = fromCurrency;
    if (toCurrency != null) result.toCurrency = toCurrency;
    return result;
  }

  GetFXRateRequest._();

  factory GetFXRateRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetFXRateRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetFXRateRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'fromCurrency')
    ..aOS(2, _omitFieldNames ? '' : 'toCurrency')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetFXRateRequest clone() => GetFXRateRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetFXRateRequest copyWith(void Function(GetFXRateRequest) updates) =>
      super.copyWith((message) => updates(message as GetFXRateRequest))
          as GetFXRateRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetFXRateRequest create() => GetFXRateRequest._();
  @$core.override
  GetFXRateRequest createEmptyInstance() => create();
  static $pb.PbList<GetFXRateRequest> createRepeated() =>
      $pb.PbList<GetFXRateRequest>();
  @$core.pragma('dart2js:noInline')
  static GetFXRateRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetFXRateRequest>(create);
  static GetFXRateRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fromCurrency => $_getSZ(0);
  @$pb.TagNumber(1)
  set fromCurrency($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFromCurrency() => $_has(0);
  @$pb.TagNumber(1)
  void clearFromCurrency() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get toCurrency => $_getSZ(1);
  @$pb.TagNumber(2)
  set toCurrency($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasToCurrency() => $_has(1);
  @$pb.TagNumber(2)
  void clearToCurrency() => $_clearField(2);
}

class GetFXRateResponse extends $pb.GeneratedMessage {
  factory GetFXRateResponse({
    $core.String? fromCurrency,
    $core.String? toCurrency,
    $core.double? marketRate,
    $core.double? buyRate,
    $core.double? sellRate,
    $core.int? spreadBps,
    $core.String? updatedAt,
    $core.String? rateId,
  }) {
    final result = create();
    if (fromCurrency != null) result.fromCurrency = fromCurrency;
    if (toCurrency != null) result.toCurrency = toCurrency;
    if (marketRate != null) result.marketRate = marketRate;
    if (buyRate != null) result.buyRate = buyRate;
    if (sellRate != null) result.sellRate = sellRate;
    if (spreadBps != null) result.spreadBps = spreadBps;
    if (updatedAt != null) result.updatedAt = updatedAt;
    if (rateId != null) result.rateId = rateId;
    return result;
  }

  GetFXRateResponse._();

  factory GetFXRateResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetFXRateResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetFXRateResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'fromCurrency')
    ..aOS(2, _omitFieldNames ? '' : 'toCurrency')
    ..a<$core.double>(
        3, _omitFieldNames ? '' : 'marketRate', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'buyRate', $pb.PbFieldType.OD)
    ..a<$core.double>(5, _omitFieldNames ? '' : 'sellRate', $pb.PbFieldType.OD)
    ..a<$core.int>(6, _omitFieldNames ? '' : 'spreadBps', $pb.PbFieldType.O3)
    ..aOS(7, _omitFieldNames ? '' : 'updatedAt')
    ..aOS(8, _omitFieldNames ? '' : 'rateId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetFXRateResponse clone() => GetFXRateResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetFXRateResponse copyWith(void Function(GetFXRateResponse) updates) =>
      super.copyWith((message) => updates(message as GetFXRateResponse))
          as GetFXRateResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetFXRateResponse create() => GetFXRateResponse._();
  @$core.override
  GetFXRateResponse createEmptyInstance() => create();
  static $pb.PbList<GetFXRateResponse> createRepeated() =>
      $pb.PbList<GetFXRateResponse>();
  @$core.pragma('dart2js:noInline')
  static GetFXRateResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetFXRateResponse>(create);
  static GetFXRateResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fromCurrency => $_getSZ(0);
  @$pb.TagNumber(1)
  set fromCurrency($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFromCurrency() => $_has(0);
  @$pb.TagNumber(1)
  void clearFromCurrency() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get toCurrency => $_getSZ(1);
  @$pb.TagNumber(2)
  set toCurrency($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasToCurrency() => $_has(1);
  @$pb.TagNumber(2)
  void clearToCurrency() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get marketRate => $_getN(2);
  @$pb.TagNumber(3)
  set marketRate($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMarketRate() => $_has(2);
  @$pb.TagNumber(3)
  void clearMarketRate() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get buyRate => $_getN(3);
  @$pb.TagNumber(4)
  set buyRate($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasBuyRate() => $_has(3);
  @$pb.TagNumber(4)
  void clearBuyRate() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get sellRate => $_getN(4);
  @$pb.TagNumber(5)
  set sellRate($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasSellRate() => $_has(4);
  @$pb.TagNumber(5)
  void clearSellRate() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get spreadBps => $_getIZ(5);
  @$pb.TagNumber(6)
  set spreadBps($core.int value) => $_setSignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasSpreadBps() => $_has(5);
  @$pb.TagNumber(6)
  void clearSpreadBps() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get updatedAt => $_getSZ(6);
  @$pb.TagNumber(7)
  set updatedAt($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasUpdatedAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearUpdatedAt() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get rateId => $_getSZ(7);
  @$pb.TagNumber(8)
  set rateId($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasRateId() => $_has(7);
  @$pb.TagNumber(8)
  void clearRateId() => $_clearField(8);
}

class ConvertCurrencyRequest extends $pb.GeneratedMessage {
  factory ConvertCurrencyRequest({
    $core.String? fromCurrency,
    $core.String? toCurrency,
    $core.double? amount,
    $core.String? direction,
    $core.String? purpose,
    $core.String? idempotencyKey,
  }) {
    final result = create();
    if (fromCurrency != null) result.fromCurrency = fromCurrency;
    if (toCurrency != null) result.toCurrency = toCurrency;
    if (amount != null) result.amount = amount;
    if (direction != null) result.direction = direction;
    if (purpose != null) result.purpose = purpose;
    if (idempotencyKey != null) result.idempotencyKey = idempotencyKey;
    return result;
  }

  ConvertCurrencyRequest._();

  factory ConvertCurrencyRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ConvertCurrencyRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ConvertCurrencyRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'fromCurrency')
    ..aOS(2, _omitFieldNames ? '' : 'toCurrency')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(4, _omitFieldNames ? '' : 'direction')
    ..aOS(5, _omitFieldNames ? '' : 'purpose')
    ..aOS(6, _omitFieldNames ? '' : 'idempotencyKey')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ConvertCurrencyRequest clone() =>
      ConvertCurrencyRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ConvertCurrencyRequest copyWith(
          void Function(ConvertCurrencyRequest) updates) =>
      super.copyWith((message) => updates(message as ConvertCurrencyRequest))
          as ConvertCurrencyRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ConvertCurrencyRequest create() => ConvertCurrencyRequest._();
  @$core.override
  ConvertCurrencyRequest createEmptyInstance() => create();
  static $pb.PbList<ConvertCurrencyRequest> createRepeated() =>
      $pb.PbList<ConvertCurrencyRequest>();
  @$core.pragma('dart2js:noInline')
  static ConvertCurrencyRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ConvertCurrencyRequest>(create);
  static ConvertCurrencyRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fromCurrency => $_getSZ(0);
  @$pb.TagNumber(1)
  set fromCurrency($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFromCurrency() => $_has(0);
  @$pb.TagNumber(1)
  void clearFromCurrency() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get toCurrency => $_getSZ(1);
  @$pb.TagNumber(2)
  set toCurrency($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasToCurrency() => $_has(1);
  @$pb.TagNumber(2)
  void clearToCurrency() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get amount => $_getN(2);
  @$pb.TagNumber(3)
  set amount($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get direction => $_getSZ(3);
  @$pb.TagNumber(4)
  set direction($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDirection() => $_has(3);
  @$pb.TagNumber(4)
  void clearDirection() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get purpose => $_getSZ(4);
  @$pb.TagNumber(5)
  set purpose($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasPurpose() => $_has(4);
  @$pb.TagNumber(5)
  void clearPurpose() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get idempotencyKey => $_getSZ(5);
  @$pb.TagNumber(6)
  set idempotencyKey($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasIdempotencyKey() => $_has(5);
  @$pb.TagNumber(6)
  void clearIdempotencyKey() => $_clearField(6);
}

class ConvertCurrencyResponse extends $pb.GeneratedMessage {
  factory ConvertCurrencyResponse({
    $core.String? fromCurrency,
    $core.String? toCurrency,
    $core.double? fromAmount,
    $core.double? toAmount,
    $core.double? marketRate,
    $core.double? appliedRate,
    $core.double? spreadProfit,
    $core.String? direction,
    $core.bool? success,
    $core.String? message,
  }) {
    final result = create();
    if (fromCurrency != null) result.fromCurrency = fromCurrency;
    if (toCurrency != null) result.toCurrency = toCurrency;
    if (fromAmount != null) result.fromAmount = fromAmount;
    if (toAmount != null) result.toAmount = toAmount;
    if (marketRate != null) result.marketRate = marketRate;
    if (appliedRate != null) result.appliedRate = appliedRate;
    if (spreadProfit != null) result.spreadProfit = spreadProfit;
    if (direction != null) result.direction = direction;
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    return result;
  }

  ConvertCurrencyResponse._();

  factory ConvertCurrencyResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ConvertCurrencyResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ConvertCurrencyResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'fromCurrency')
    ..aOS(2, _omitFieldNames ? '' : 'toCurrency')
    ..a<$core.double>(
        3, _omitFieldNames ? '' : 'fromAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'toAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(
        5, _omitFieldNames ? '' : 'marketRate', $pb.PbFieldType.OD)
    ..a<$core.double>(
        6, _omitFieldNames ? '' : 'appliedRate', $pb.PbFieldType.OD)
    ..a<$core.double>(
        7, _omitFieldNames ? '' : 'spreadProfit', $pb.PbFieldType.OD)
    ..aOS(8, _omitFieldNames ? '' : 'direction')
    ..aOB(9, _omitFieldNames ? '' : 'success')
    ..aOS(10, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ConvertCurrencyResponse clone() =>
      ConvertCurrencyResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ConvertCurrencyResponse copyWith(
          void Function(ConvertCurrencyResponse) updates) =>
      super.copyWith((message) => updates(message as ConvertCurrencyResponse))
          as ConvertCurrencyResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ConvertCurrencyResponse create() => ConvertCurrencyResponse._();
  @$core.override
  ConvertCurrencyResponse createEmptyInstance() => create();
  static $pb.PbList<ConvertCurrencyResponse> createRepeated() =>
      $pb.PbList<ConvertCurrencyResponse>();
  @$core.pragma('dart2js:noInline')
  static ConvertCurrencyResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ConvertCurrencyResponse>(create);
  static ConvertCurrencyResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fromCurrency => $_getSZ(0);
  @$pb.TagNumber(1)
  set fromCurrency($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFromCurrency() => $_has(0);
  @$pb.TagNumber(1)
  void clearFromCurrency() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get toCurrency => $_getSZ(1);
  @$pb.TagNumber(2)
  set toCurrency($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasToCurrency() => $_has(1);
  @$pb.TagNumber(2)
  void clearToCurrency() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get fromAmount => $_getN(2);
  @$pb.TagNumber(3)
  set fromAmount($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasFromAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearFromAmount() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get toAmount => $_getN(3);
  @$pb.TagNumber(4)
  set toAmount($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasToAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearToAmount() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get marketRate => $_getN(4);
  @$pb.TagNumber(5)
  set marketRate($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasMarketRate() => $_has(4);
  @$pb.TagNumber(5)
  void clearMarketRate() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.double get appliedRate => $_getN(5);
  @$pb.TagNumber(6)
  set appliedRate($core.double value) => $_setDouble(5, value);
  @$pb.TagNumber(6)
  $core.bool hasAppliedRate() => $_has(5);
  @$pb.TagNumber(6)
  void clearAppliedRate() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.double get spreadProfit => $_getN(6);
  @$pb.TagNumber(7)
  set spreadProfit($core.double value) => $_setDouble(6, value);
  @$pb.TagNumber(7)
  $core.bool hasSpreadProfit() => $_has(6);
  @$pb.TagNumber(7)
  void clearSpreadProfit() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get direction => $_getSZ(7);
  @$pb.TagNumber(8)
  set direction($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasDirection() => $_has(7);
  @$pb.TagNumber(8)
  void clearDirection() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.bool get success => $_getBF(8);
  @$pb.TagNumber(9)
  set success($core.bool value) => $_setBool(8, value);
  @$pb.TagNumber(9)
  $core.bool hasSuccess() => $_has(8);
  @$pb.TagNumber(9)
  void clearSuccess() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get message => $_getSZ(9);
  @$pb.TagNumber(10)
  set message($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasMessage() => $_has(9);
  @$pb.TagNumber(10)
  void clearMessage() => $_clearField(10);
}

class FXTransactionInfo extends $pb.GeneratedMessage {
  factory FXTransactionInfo({
    $core.String? id,
    $core.String? fromCurrency,
    $core.String? toCurrency,
    $core.double? fromAmount,
    $core.double? toAmount,
    $core.double? marketRate,
    $core.double? appliedRate,
    $core.double? spreadProfit,
    $core.String? direction,
    $core.String? purpose,
    $core.String? createdAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (fromCurrency != null) result.fromCurrency = fromCurrency;
    if (toCurrency != null) result.toCurrency = toCurrency;
    if (fromAmount != null) result.fromAmount = fromAmount;
    if (toAmount != null) result.toAmount = toAmount;
    if (marketRate != null) result.marketRate = marketRate;
    if (appliedRate != null) result.appliedRate = appliedRate;
    if (spreadProfit != null) result.spreadProfit = spreadProfit;
    if (direction != null) result.direction = direction;
    if (purpose != null) result.purpose = purpose;
    if (createdAt != null) result.createdAt = createdAt;
    return result;
  }

  FXTransactionInfo._();

  factory FXTransactionInfo.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FXTransactionInfo.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FXTransactionInfo',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'fromCurrency')
    ..aOS(3, _omitFieldNames ? '' : 'toCurrency')
    ..a<$core.double>(
        4, _omitFieldNames ? '' : 'fromAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(5, _omitFieldNames ? '' : 'toAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(
        6, _omitFieldNames ? '' : 'marketRate', $pb.PbFieldType.OD)
    ..a<$core.double>(
        7, _omitFieldNames ? '' : 'appliedRate', $pb.PbFieldType.OD)
    ..a<$core.double>(
        8, _omitFieldNames ? '' : 'spreadProfit', $pb.PbFieldType.OD)
    ..aOS(9, _omitFieldNames ? '' : 'direction')
    ..aOS(10, _omitFieldNames ? '' : 'purpose')
    ..aOS(11, _omitFieldNames ? '' : 'createdAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FXTransactionInfo clone() => FXTransactionInfo()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FXTransactionInfo copyWith(void Function(FXTransactionInfo) updates) =>
      super.copyWith((message) => updates(message as FXTransactionInfo))
          as FXTransactionInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FXTransactionInfo create() => FXTransactionInfo._();
  @$core.override
  FXTransactionInfo createEmptyInstance() => create();
  static $pb.PbList<FXTransactionInfo> createRepeated() =>
      $pb.PbList<FXTransactionInfo>();
  @$core.pragma('dart2js:noInline')
  static FXTransactionInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FXTransactionInfo>(create);
  static FXTransactionInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get fromCurrency => $_getSZ(1);
  @$pb.TagNumber(2)
  set fromCurrency($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasFromCurrency() => $_has(1);
  @$pb.TagNumber(2)
  void clearFromCurrency() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get toCurrency => $_getSZ(2);
  @$pb.TagNumber(3)
  set toCurrency($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasToCurrency() => $_has(2);
  @$pb.TagNumber(3)
  void clearToCurrency() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get fromAmount => $_getN(3);
  @$pb.TagNumber(4)
  set fromAmount($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasFromAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearFromAmount() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get toAmount => $_getN(4);
  @$pb.TagNumber(5)
  set toAmount($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasToAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearToAmount() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.double get marketRate => $_getN(5);
  @$pb.TagNumber(6)
  set marketRate($core.double value) => $_setDouble(5, value);
  @$pb.TagNumber(6)
  $core.bool hasMarketRate() => $_has(5);
  @$pb.TagNumber(6)
  void clearMarketRate() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.double get appliedRate => $_getN(6);
  @$pb.TagNumber(7)
  set appliedRate($core.double value) => $_setDouble(6, value);
  @$pb.TagNumber(7)
  $core.bool hasAppliedRate() => $_has(6);
  @$pb.TagNumber(7)
  void clearAppliedRate() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.double get spreadProfit => $_getN(7);
  @$pb.TagNumber(8)
  set spreadProfit($core.double value) => $_setDouble(7, value);
  @$pb.TagNumber(8)
  $core.bool hasSpreadProfit() => $_has(7);
  @$pb.TagNumber(8)
  void clearSpreadProfit() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get direction => $_getSZ(8);
  @$pb.TagNumber(9)
  set direction($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasDirection() => $_has(8);
  @$pb.TagNumber(9)
  void clearDirection() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get purpose => $_getSZ(9);
  @$pb.TagNumber(10)
  set purpose($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasPurpose() => $_has(9);
  @$pb.TagNumber(10)
  void clearPurpose() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get createdAt => $_getSZ(10);
  @$pb.TagNumber(11)
  set createdAt($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasCreatedAt() => $_has(10);
  @$pb.TagNumber(11)
  void clearCreatedAt() => $_clearField(11);
}

class GetFXHistoryRequest extends $pb.GeneratedMessage {
  factory GetFXHistoryRequest({
    $core.int? limit,
    $core.int? offset,
  }) {
    final result = create();
    if (limit != null) result.limit = limit;
    if (offset != null) result.offset = offset;
    return result;
  }

  GetFXHistoryRequest._();

  factory GetFXHistoryRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetFXHistoryRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetFXHistoryRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetFXHistoryRequest clone() => GetFXHistoryRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetFXHistoryRequest copyWith(void Function(GetFXHistoryRequest) updates) =>
      super.copyWith((message) => updates(message as GetFXHistoryRequest))
          as GetFXHistoryRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetFXHistoryRequest create() => GetFXHistoryRequest._();
  @$core.override
  GetFXHistoryRequest createEmptyInstance() => create();
  static $pb.PbList<GetFXHistoryRequest> createRepeated() =>
      $pb.PbList<GetFXHistoryRequest>();
  @$core.pragma('dart2js:noInline')
  static GetFXHistoryRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetFXHistoryRequest>(create);
  static GetFXHistoryRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get limit => $_getIZ(0);
  @$pb.TagNumber(1)
  set limit($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasLimit() => $_has(0);
  @$pb.TagNumber(1)
  void clearLimit() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get offset => $_getIZ(1);
  @$pb.TagNumber(2)
  set offset($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasOffset() => $_has(1);
  @$pb.TagNumber(2)
  void clearOffset() => $_clearField(2);
}

class GetFXHistoryResponse extends $pb.GeneratedMessage {
  factory GetFXHistoryResponse({
    $core.Iterable<FXTransactionInfo>? transactions,
    $fixnum.Int64? total,
  }) {
    final result = create();
    if (transactions != null) result.transactions.addAll(transactions);
    if (total != null) result.total = total;
    return result;
  }

  GetFXHistoryResponse._();

  factory GetFXHistoryResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetFXHistoryResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetFXHistoryResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..pc<FXTransactionInfo>(
        1, _omitFieldNames ? '' : 'transactions', $pb.PbFieldType.PM,
        subBuilder: FXTransactionInfo.create)
    ..aInt64(2, _omitFieldNames ? '' : 'total')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetFXHistoryResponse clone() =>
      GetFXHistoryResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetFXHistoryResponse copyWith(void Function(GetFXHistoryResponse) updates) =>
      super.copyWith((message) => updates(message as GetFXHistoryResponse))
          as GetFXHistoryResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetFXHistoryResponse create() => GetFXHistoryResponse._();
  @$core.override
  GetFXHistoryResponse createEmptyInstance() => create();
  static $pb.PbList<GetFXHistoryResponse> createRepeated() =>
      $pb.PbList<GetFXHistoryResponse>();
  @$core.pragma('dart2js:noInline')
  static GetFXHistoryResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetFXHistoryResponse>(create);
  static GetFXHistoryResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<FXTransactionInfo> get transactions => $_getList(0);

  @$pb.TagNumber(2)
  $fixnum.Int64 get total => $_getI64(1);
  @$pb.TagNumber(2)
  set total($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);
}

class IncomeEventInfo extends $pb.GeneratedMessage {
  factory IncomeEventInfo({
    $core.String? id,
    $core.String? assetSymbol,
    $core.String? assetType,
    $core.String? incomeType,
    $core.double? grossAmount,
    $core.double? taxWithheld,
    $core.double? netAmount,
    $core.String? currency,
    $core.String? provider,
    $core.bool? isReinvested,
    $core.String? payDate,
    $core.String? createdAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (assetSymbol != null) result.assetSymbol = assetSymbol;
    if (assetType != null) result.assetType = assetType;
    if (incomeType != null) result.incomeType = incomeType;
    if (grossAmount != null) result.grossAmount = grossAmount;
    if (taxWithheld != null) result.taxWithheld = taxWithheld;
    if (netAmount != null) result.netAmount = netAmount;
    if (currency != null) result.currency = currency;
    if (provider != null) result.provider = provider;
    if (isReinvested != null) result.isReinvested = isReinvested;
    if (payDate != null) result.payDate = payDate;
    if (createdAt != null) result.createdAt = createdAt;
    return result;
  }

  IncomeEventInfo._();

  factory IncomeEventInfo.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory IncomeEventInfo.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'IncomeEventInfo',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'assetSymbol')
    ..aOS(3, _omitFieldNames ? '' : 'assetType')
    ..aOS(4, _omitFieldNames ? '' : 'incomeType')
    ..a<$core.double>(
        5, _omitFieldNames ? '' : 'grossAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(
        6, _omitFieldNames ? '' : 'taxWithheld', $pb.PbFieldType.OD)
    ..a<$core.double>(7, _omitFieldNames ? '' : 'netAmount', $pb.PbFieldType.OD)
    ..aOS(8, _omitFieldNames ? '' : 'currency')
    ..aOS(9, _omitFieldNames ? '' : 'provider')
    ..aOB(10, _omitFieldNames ? '' : 'isReinvested')
    ..aOS(11, _omitFieldNames ? '' : 'payDate')
    ..aOS(12, _omitFieldNames ? '' : 'createdAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  IncomeEventInfo clone() => IncomeEventInfo()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  IncomeEventInfo copyWith(void Function(IncomeEventInfo) updates) =>
      super.copyWith((message) => updates(message as IncomeEventInfo))
          as IncomeEventInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static IncomeEventInfo create() => IncomeEventInfo._();
  @$core.override
  IncomeEventInfo createEmptyInstance() => create();
  static $pb.PbList<IncomeEventInfo> createRepeated() =>
      $pb.PbList<IncomeEventInfo>();
  @$core.pragma('dart2js:noInline')
  static IncomeEventInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<IncomeEventInfo>(create);
  static IncomeEventInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get assetSymbol => $_getSZ(1);
  @$pb.TagNumber(2)
  set assetSymbol($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAssetSymbol() => $_has(1);
  @$pb.TagNumber(2)
  void clearAssetSymbol() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get assetType => $_getSZ(2);
  @$pb.TagNumber(3)
  set assetType($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAssetType() => $_has(2);
  @$pb.TagNumber(3)
  void clearAssetType() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get incomeType => $_getSZ(3);
  @$pb.TagNumber(4)
  set incomeType($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasIncomeType() => $_has(3);
  @$pb.TagNumber(4)
  void clearIncomeType() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get grossAmount => $_getN(4);
  @$pb.TagNumber(5)
  set grossAmount($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasGrossAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearGrossAmount() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.double get taxWithheld => $_getN(5);
  @$pb.TagNumber(6)
  set taxWithheld($core.double value) => $_setDouble(5, value);
  @$pb.TagNumber(6)
  $core.bool hasTaxWithheld() => $_has(5);
  @$pb.TagNumber(6)
  void clearTaxWithheld() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.double get netAmount => $_getN(6);
  @$pb.TagNumber(7)
  set netAmount($core.double value) => $_setDouble(6, value);
  @$pb.TagNumber(7)
  $core.bool hasNetAmount() => $_has(6);
  @$pb.TagNumber(7)
  void clearNetAmount() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get currency => $_getSZ(7);
  @$pb.TagNumber(8)
  set currency($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasCurrency() => $_has(7);
  @$pb.TagNumber(8)
  void clearCurrency() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get provider => $_getSZ(8);
  @$pb.TagNumber(9)
  set provider($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasProvider() => $_has(8);
  @$pb.TagNumber(9)
  void clearProvider() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.bool get isReinvested => $_getBF(9);
  @$pb.TagNumber(10)
  set isReinvested($core.bool value) => $_setBool(9, value);
  @$pb.TagNumber(10)
  $core.bool hasIsReinvested() => $_has(9);
  @$pb.TagNumber(10)
  void clearIsReinvested() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get payDate => $_getSZ(10);
  @$pb.TagNumber(11)
  set payDate($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasPayDate() => $_has(10);
  @$pb.TagNumber(11)
  void clearPayDate() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get createdAt => $_getSZ(11);
  @$pb.TagNumber(12)
  set createdAt($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasCreatedAt() => $_has(11);
  @$pb.TagNumber(12)
  void clearCreatedAt() => $_clearField(12);
}

class GetIncomeHistoryRequest extends $pb.GeneratedMessage {
  factory GetIncomeHistoryRequest({
    $core.String? incomeType,
    $core.int? limit,
    $core.int? offset,
  }) {
    final result = create();
    if (incomeType != null) result.incomeType = incomeType;
    if (limit != null) result.limit = limit;
    if (offset != null) result.offset = offset;
    return result;
  }

  GetIncomeHistoryRequest._();

  factory GetIncomeHistoryRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetIncomeHistoryRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetIncomeHistoryRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'incomeType')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetIncomeHistoryRequest clone() =>
      GetIncomeHistoryRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetIncomeHistoryRequest copyWith(
          void Function(GetIncomeHistoryRequest) updates) =>
      super.copyWith((message) => updates(message as GetIncomeHistoryRequest))
          as GetIncomeHistoryRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetIncomeHistoryRequest create() => GetIncomeHistoryRequest._();
  @$core.override
  GetIncomeHistoryRequest createEmptyInstance() => create();
  static $pb.PbList<GetIncomeHistoryRequest> createRepeated() =>
      $pb.PbList<GetIncomeHistoryRequest>();
  @$core.pragma('dart2js:noInline')
  static GetIncomeHistoryRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetIncomeHistoryRequest>(create);
  static GetIncomeHistoryRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get incomeType => $_getSZ(0);
  @$pb.TagNumber(1)
  set incomeType($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasIncomeType() => $_has(0);
  @$pb.TagNumber(1)
  void clearIncomeType() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get limit => $_getIZ(1);
  @$pb.TagNumber(2)
  set limit($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get offset => $_getIZ(2);
  @$pb.TagNumber(3)
  set offset($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasOffset() => $_has(2);
  @$pb.TagNumber(3)
  void clearOffset() => $_clearField(3);
}

class GetIncomeHistoryResponse extends $pb.GeneratedMessage {
  factory GetIncomeHistoryResponse({
    $core.Iterable<IncomeEventInfo>? events,
    $fixnum.Int64? total,
  }) {
    final result = create();
    if (events != null) result.events.addAll(events);
    if (total != null) result.total = total;
    return result;
  }

  GetIncomeHistoryResponse._();

  factory GetIncomeHistoryResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetIncomeHistoryResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetIncomeHistoryResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..pc<IncomeEventInfo>(
        1, _omitFieldNames ? '' : 'events', $pb.PbFieldType.PM,
        subBuilder: IncomeEventInfo.create)
    ..aInt64(2, _omitFieldNames ? '' : 'total')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetIncomeHistoryResponse clone() =>
      GetIncomeHistoryResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetIncomeHistoryResponse copyWith(
          void Function(GetIncomeHistoryResponse) updates) =>
      super.copyWith((message) => updates(message as GetIncomeHistoryResponse))
          as GetIncomeHistoryResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetIncomeHistoryResponse create() => GetIncomeHistoryResponse._();
  @$core.override
  GetIncomeHistoryResponse createEmptyInstance() => create();
  static $pb.PbList<GetIncomeHistoryResponse> createRepeated() =>
      $pb.PbList<GetIncomeHistoryResponse>();
  @$core.pragma('dart2js:noInline')
  static GetIncomeHistoryResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetIncomeHistoryResponse>(create);
  static GetIncomeHistoryResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<IncomeEventInfo> get events => $_getList(0);

  @$pb.TagNumber(2)
  $fixnum.Int64 get total => $_getI64(1);
  @$pb.TagNumber(2)
  set total($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);
}

class GetTotalIncomeRequest extends $pb.GeneratedMessage {
  factory GetTotalIncomeRequest() => create();

  GetTotalIncomeRequest._();

  factory GetTotalIncomeRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTotalIncomeRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTotalIncomeRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTotalIncomeRequest clone() =>
      GetTotalIncomeRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTotalIncomeRequest copyWith(
          void Function(GetTotalIncomeRequest) updates) =>
      super.copyWith((message) => updates(message as GetTotalIncomeRequest))
          as GetTotalIncomeRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTotalIncomeRequest create() => GetTotalIncomeRequest._();
  @$core.override
  GetTotalIncomeRequest createEmptyInstance() => create();
  static $pb.PbList<GetTotalIncomeRequest> createRepeated() =>
      $pb.PbList<GetTotalIncomeRequest>();
  @$core.pragma('dart2js:noInline')
  static GetTotalIncomeRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetTotalIncomeRequest>(create);
  static GetTotalIncomeRequest? _defaultInstance;
}

class GetTotalIncomeResponse extends $pb.GeneratedMessage {
  factory GetTotalIncomeResponse({
    $core.double? totalIncome,
    $core.String? currency,
  }) {
    final result = create();
    if (totalIncome != null) result.totalIncome = totalIncome;
    if (currency != null) result.currency = currency;
    return result;
  }

  GetTotalIncomeResponse._();

  factory GetTotalIncomeResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTotalIncomeResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTotalIncomeResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..a<$core.double>(
        1, _omitFieldNames ? '' : 'totalIncome', $pb.PbFieldType.OD)
    ..aOS(2, _omitFieldNames ? '' : 'currency')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTotalIncomeResponse clone() =>
      GetTotalIncomeResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTotalIncomeResponse copyWith(
          void Function(GetTotalIncomeResponse) updates) =>
      super.copyWith((message) => updates(message as GetTotalIncomeResponse))
          as GetTotalIncomeResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTotalIncomeResponse create() => GetTotalIncomeResponse._();
  @$core.override
  GetTotalIncomeResponse createEmptyInstance() => create();
  static $pb.PbList<GetTotalIncomeResponse> createRepeated() =>
      $pb.PbList<GetTotalIncomeResponse>();
  @$core.pragma('dart2js:noInline')
  static GetTotalIncomeResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetTotalIncomeResponse>(create);
  static GetTotalIncomeResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get totalIncome => $_getN(0);
  @$pb.TagNumber(1)
  set totalIncome($core.double value) => $_setDouble(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTotalIncome() => $_has(0);
  @$pb.TagNumber(1)
  void clearTotalIncome() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get currency => $_getSZ(1);
  @$pb.TagNumber(2)
  set currency($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCurrency() => $_has(1);
  @$pb.TagNumber(2)
  void clearCurrency() => $_clearField(2);
}

class SyncDividendsRequest extends $pb.GeneratedMessage {
  factory SyncDividendsRequest({
    $core.String? brokerAccountId,
  }) {
    final result = create();
    if (brokerAccountId != null) result.brokerAccountId = brokerAccountId;
    return result;
  }

  SyncDividendsRequest._();

  factory SyncDividendsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SyncDividendsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SyncDividendsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'brokerAccountId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SyncDividendsRequest clone() =>
      SyncDividendsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SyncDividendsRequest copyWith(void Function(SyncDividendsRequest) updates) =>
      super.copyWith((message) => updates(message as SyncDividendsRequest))
          as SyncDividendsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SyncDividendsRequest create() => SyncDividendsRequest._();
  @$core.override
  SyncDividendsRequest createEmptyInstance() => create();
  static $pb.PbList<SyncDividendsRequest> createRepeated() =>
      $pb.PbList<SyncDividendsRequest>();
  @$core.pragma('dart2js:noInline')
  static SyncDividendsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SyncDividendsRequest>(create);
  static SyncDividendsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get brokerAccountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set brokerAccountId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasBrokerAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearBrokerAccountId() => $_clearField(1);
}

class SyncDividendsResponse extends $pb.GeneratedMessage {
  factory SyncDividendsResponse({
    $core.int? syncedCount,
    $core.String? message,
  }) {
    final result = create();
    if (syncedCount != null) result.syncedCount = syncedCount;
    if (message != null) result.message = message;
    return result;
  }

  SyncDividendsResponse._();

  factory SyncDividendsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SyncDividendsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SyncDividendsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'syncedCount', $pb.PbFieldType.O3)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SyncDividendsResponse clone() =>
      SyncDividendsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SyncDividendsResponse copyWith(
          void Function(SyncDividendsResponse) updates) =>
      super.copyWith((message) => updates(message as SyncDividendsResponse))
          as SyncDividendsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SyncDividendsResponse create() => SyncDividendsResponse._();
  @$core.override
  SyncDividendsResponse createEmptyInstance() => create();
  static $pb.PbList<SyncDividendsResponse> createRepeated() =>
      $pb.PbList<SyncDividendsResponse>();
  @$core.pragma('dart2js:noInline')
  static SyncDividendsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SyncDividendsResponse>(create);
  static SyncDividendsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get syncedCount => $_getIZ(0);
  @$pb.TagNumber(1)
  set syncedCount($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSyncedCount() => $_has(0);
  @$pb.TagNumber(1)
  void clearSyncedCount() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);
}

class CommissionTierInfo extends $pb.GeneratedMessage {
  factory CommissionTierInfo({
    $core.String? assetType,
    $core.int? rateBps,
    $core.double? minAmount,
    $core.double? maxAmount,
    $core.bool? isActive,
  }) {
    final result = create();
    if (assetType != null) result.assetType = assetType;
    if (rateBps != null) result.rateBps = rateBps;
    if (minAmount != null) result.minAmount = minAmount;
    if (maxAmount != null) result.maxAmount = maxAmount;
    if (isActive != null) result.isActive = isActive;
    return result;
  }

  CommissionTierInfo._();

  factory CommissionTierInfo.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CommissionTierInfo.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CommissionTierInfo',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'assetType')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'rateBps', $pb.PbFieldType.O3)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'minAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'maxAmount', $pb.PbFieldType.OD)
    ..aOB(5, _omitFieldNames ? '' : 'isActive')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CommissionTierInfo clone() => CommissionTierInfo()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CommissionTierInfo copyWith(void Function(CommissionTierInfo) updates) =>
      super.copyWith((message) => updates(message as CommissionTierInfo))
          as CommissionTierInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CommissionTierInfo create() => CommissionTierInfo._();
  @$core.override
  CommissionTierInfo createEmptyInstance() => create();
  static $pb.PbList<CommissionTierInfo> createRepeated() =>
      $pb.PbList<CommissionTierInfo>();
  @$core.pragma('dart2js:noInline')
  static CommissionTierInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CommissionTierInfo>(create);
  static CommissionTierInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get assetType => $_getSZ(0);
  @$pb.TagNumber(1)
  set assetType($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAssetType() => $_has(0);
  @$pb.TagNumber(1)
  void clearAssetType() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get rateBps => $_getIZ(1);
  @$pb.TagNumber(2)
  set rateBps($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRateBps() => $_has(1);
  @$pb.TagNumber(2)
  void clearRateBps() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get minAmount => $_getN(2);
  @$pb.TagNumber(3)
  set minAmount($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMinAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearMinAmount() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get maxAmount => $_getN(3);
  @$pb.TagNumber(4)
  set maxAmount($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMaxAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearMaxAmount() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.bool get isActive => $_getBF(4);
  @$pb.TagNumber(5)
  set isActive($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasIsActive() => $_has(4);
  @$pb.TagNumber(5)
  void clearIsActive() => $_clearField(5);
}

class GetCommissionRatesRequest extends $pb.GeneratedMessage {
  factory GetCommissionRatesRequest() => create();

  GetCommissionRatesRequest._();

  factory GetCommissionRatesRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetCommissionRatesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetCommissionRatesRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCommissionRatesRequest clone() =>
      GetCommissionRatesRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCommissionRatesRequest copyWith(
          void Function(GetCommissionRatesRequest) updates) =>
      super.copyWith((message) => updates(message as GetCommissionRatesRequest))
          as GetCommissionRatesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCommissionRatesRequest create() => GetCommissionRatesRequest._();
  @$core.override
  GetCommissionRatesRequest createEmptyInstance() => create();
  static $pb.PbList<GetCommissionRatesRequest> createRepeated() =>
      $pb.PbList<GetCommissionRatesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetCommissionRatesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetCommissionRatesRequest>(create);
  static GetCommissionRatesRequest? _defaultInstance;
}

class GetCommissionRatesResponse extends $pb.GeneratedMessage {
  factory GetCommissionRatesResponse({
    $core.Iterable<CommissionTierInfo>? tiers,
  }) {
    final result = create();
    if (tiers != null) result.tiers.addAll(tiers);
    return result;
  }

  GetCommissionRatesResponse._();

  factory GetCommissionRatesResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetCommissionRatesResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetCommissionRatesResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..pc<CommissionTierInfo>(
        1, _omitFieldNames ? '' : 'tiers', $pb.PbFieldType.PM,
        subBuilder: CommissionTierInfo.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCommissionRatesResponse clone() =>
      GetCommissionRatesResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetCommissionRatesResponse copyWith(
          void Function(GetCommissionRatesResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetCommissionRatesResponse))
          as GetCommissionRatesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCommissionRatesResponse create() => GetCommissionRatesResponse._();
  @$core.override
  GetCommissionRatesResponse createEmptyInstance() => create();
  static $pb.PbList<GetCommissionRatesResponse> createRepeated() =>
      $pb.PbList<GetCommissionRatesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetCommissionRatesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetCommissionRatesResponse>(create);
  static GetCommissionRatesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<CommissionTierInfo> get tiers => $_getList(0);
}

class CalculateCommissionRequest extends $pb.GeneratedMessage {
  factory CalculateCommissionRequest({
    $core.String? assetType,
    $core.double? tradeAmount,
  }) {
    final result = create();
    if (assetType != null) result.assetType = assetType;
    if (tradeAmount != null) result.tradeAmount = tradeAmount;
    return result;
  }

  CalculateCommissionRequest._();

  factory CalculateCommissionRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CalculateCommissionRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CalculateCommissionRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'assetType')
    ..a<$core.double>(
        2, _omitFieldNames ? '' : 'tradeAmount', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CalculateCommissionRequest clone() =>
      CalculateCommissionRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CalculateCommissionRequest copyWith(
          void Function(CalculateCommissionRequest) updates) =>
      super.copyWith(
              (message) => updates(message as CalculateCommissionRequest))
          as CalculateCommissionRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CalculateCommissionRequest create() => CalculateCommissionRequest._();
  @$core.override
  CalculateCommissionRequest createEmptyInstance() => create();
  static $pb.PbList<CalculateCommissionRequest> createRepeated() =>
      $pb.PbList<CalculateCommissionRequest>();
  @$core.pragma('dart2js:noInline')
  static CalculateCommissionRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CalculateCommissionRequest>(create);
  static CalculateCommissionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get assetType => $_getSZ(0);
  @$pb.TagNumber(1)
  set assetType($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAssetType() => $_has(0);
  @$pb.TagNumber(1)
  void clearAssetType() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get tradeAmount => $_getN(1);
  @$pb.TagNumber(2)
  set tradeAmount($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTradeAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearTradeAmount() => $_clearField(2);
}

class CalculateCommissionResponse extends $pb.GeneratedMessage {
  factory CalculateCommissionResponse({
    $core.String? assetType,
    $core.double? tradeAmount,
    $core.double? commissionRate,
    $core.double? commissionAmount,
    $core.double? netAmount,
  }) {
    final result = create();
    if (assetType != null) result.assetType = assetType;
    if (tradeAmount != null) result.tradeAmount = tradeAmount;
    if (commissionRate != null) result.commissionRate = commissionRate;
    if (commissionAmount != null) result.commissionAmount = commissionAmount;
    if (netAmount != null) result.netAmount = netAmount;
    return result;
  }

  CalculateCommissionResponse._();

  factory CalculateCommissionResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CalculateCommissionResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CalculateCommissionResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'assetType')
    ..a<$core.double>(
        2, _omitFieldNames ? '' : 'tradeAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(
        3, _omitFieldNames ? '' : 'commissionRate', $pb.PbFieldType.OD)
    ..a<$core.double>(
        4, _omitFieldNames ? '' : 'commissionAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(5, _omitFieldNames ? '' : 'netAmount', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CalculateCommissionResponse clone() =>
      CalculateCommissionResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CalculateCommissionResponse copyWith(
          void Function(CalculateCommissionResponse) updates) =>
      super.copyWith(
              (message) => updates(message as CalculateCommissionResponse))
          as CalculateCommissionResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CalculateCommissionResponse create() =>
      CalculateCommissionResponse._();
  @$core.override
  CalculateCommissionResponse createEmptyInstance() => create();
  static $pb.PbList<CalculateCommissionResponse> createRepeated() =>
      $pb.PbList<CalculateCommissionResponse>();
  @$core.pragma('dart2js:noInline')
  static CalculateCommissionResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CalculateCommissionResponse>(create);
  static CalculateCommissionResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get assetType => $_getSZ(0);
  @$pb.TagNumber(1)
  set assetType($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAssetType() => $_has(0);
  @$pb.TagNumber(1)
  void clearAssetType() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get tradeAmount => $_getN(1);
  @$pb.TagNumber(2)
  set tradeAmount($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTradeAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearTradeAmount() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get commissionRate => $_getN(2);
  @$pb.TagNumber(3)
  set commissionRate($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCommissionRate() => $_has(2);
  @$pb.TagNumber(3)
  void clearCommissionRate() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get commissionAmount => $_getN(3);
  @$pb.TagNumber(4)
  set commissionAmount($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCommissionAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearCommissionAmount() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get netAmount => $_getN(4);
  @$pb.TagNumber(5)
  set netAmount($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasNetAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearNetAmount() => $_clearField(5);
}

class TreasuryBillInfo extends $pb.GeneratedMessage {
  factory TreasuryBillInfo({
    $core.String? id,
    $core.String? name,
    $core.int? maturityDays,
    $core.double? rate,
    $core.double? unitPrice,
    $core.String? currency,
    $core.String? maturityDate,
    $core.String? status,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (maturityDays != null) result.maturityDays = maturityDays;
    if (rate != null) result.rate = rate;
    if (unitPrice != null) result.unitPrice = unitPrice;
    if (currency != null) result.currency = currency;
    if (maturityDate != null) result.maturityDate = maturityDate;
    if (status != null) result.status = status;
    return result;
  }

  TreasuryBillInfo._();

  factory TreasuryBillInfo.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TreasuryBillInfo.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TreasuryBillInfo',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'maturityDays', $pb.PbFieldType.O3)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'rate', $pb.PbFieldType.OD)
    ..a<$core.double>(5, _omitFieldNames ? '' : 'unitPrice', $pb.PbFieldType.OD)
    ..aOS(6, _omitFieldNames ? '' : 'currency')
    ..aOS(7, _omitFieldNames ? '' : 'maturityDate')
    ..aOS(8, _omitFieldNames ? '' : 'status')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TreasuryBillInfo clone() => TreasuryBillInfo()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TreasuryBillInfo copyWith(void Function(TreasuryBillInfo) updates) =>
      super.copyWith((message) => updates(message as TreasuryBillInfo))
          as TreasuryBillInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TreasuryBillInfo create() => TreasuryBillInfo._();
  @$core.override
  TreasuryBillInfo createEmptyInstance() => create();
  static $pb.PbList<TreasuryBillInfo> createRepeated() =>
      $pb.PbList<TreasuryBillInfo>();
  @$core.pragma('dart2js:noInline')
  static TreasuryBillInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TreasuryBillInfo>(create);
  static TreasuryBillInfo? _defaultInstance;

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
  $core.int get maturityDays => $_getIZ(2);
  @$pb.TagNumber(3)
  set maturityDays($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMaturityDays() => $_has(2);
  @$pb.TagNumber(3)
  void clearMaturityDays() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get rate => $_getN(3);
  @$pb.TagNumber(4)
  set rate($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasRate() => $_has(3);
  @$pb.TagNumber(4)
  void clearRate() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get unitPrice => $_getN(4);
  @$pb.TagNumber(5)
  set unitPrice($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasUnitPrice() => $_has(4);
  @$pb.TagNumber(5)
  void clearUnitPrice() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get currency => $_getSZ(5);
  @$pb.TagNumber(6)
  set currency($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasCurrency() => $_has(5);
  @$pb.TagNumber(6)
  void clearCurrency() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get maturityDate => $_getSZ(6);
  @$pb.TagNumber(7)
  set maturityDate($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasMaturityDate() => $_has(6);
  @$pb.TagNumber(7)
  void clearMaturityDate() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get status => $_getSZ(7);
  @$pb.TagNumber(8)
  set status($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasStatus() => $_has(7);
  @$pb.TagNumber(8)
  void clearStatus() => $_clearField(8);
}

class GetTreasuryBillsRequest extends $pb.GeneratedMessage {
  factory GetTreasuryBillsRequest() => create();

  GetTreasuryBillsRequest._();

  factory GetTreasuryBillsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTreasuryBillsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTreasuryBillsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTreasuryBillsRequest clone() =>
      GetTreasuryBillsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTreasuryBillsRequest copyWith(
          void Function(GetTreasuryBillsRequest) updates) =>
      super.copyWith((message) => updates(message as GetTreasuryBillsRequest))
          as GetTreasuryBillsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTreasuryBillsRequest create() => GetTreasuryBillsRequest._();
  @$core.override
  GetTreasuryBillsRequest createEmptyInstance() => create();
  static $pb.PbList<GetTreasuryBillsRequest> createRepeated() =>
      $pb.PbList<GetTreasuryBillsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetTreasuryBillsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetTreasuryBillsRequest>(create);
  static GetTreasuryBillsRequest? _defaultInstance;
}

class GetTreasuryBillsResponse extends $pb.GeneratedMessage {
  factory GetTreasuryBillsResponse({
    $core.Iterable<TreasuryBillInfo>? bills,
  }) {
    final result = create();
    if (bills != null) result.bills.addAll(bills);
    return result;
  }

  GetTreasuryBillsResponse._();

  factory GetTreasuryBillsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTreasuryBillsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTreasuryBillsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..pc<TreasuryBillInfo>(
        1, _omitFieldNames ? '' : 'bills', $pb.PbFieldType.PM,
        subBuilder: TreasuryBillInfo.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTreasuryBillsResponse clone() =>
      GetTreasuryBillsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTreasuryBillsResponse copyWith(
          void Function(GetTreasuryBillsResponse) updates) =>
      super.copyWith((message) => updates(message as GetTreasuryBillsResponse))
          as GetTreasuryBillsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTreasuryBillsResponse create() => GetTreasuryBillsResponse._();
  @$core.override
  GetTreasuryBillsResponse createEmptyInstance() => create();
  static $pb.PbList<GetTreasuryBillsResponse> createRepeated() =>
      $pb.PbList<GetTreasuryBillsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetTreasuryBillsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetTreasuryBillsResponse>(create);
  static GetTreasuryBillsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<TreasuryBillInfo> get bills => $_getList(0);
}

class BuyTreasuryBillRequest extends $pb.GeneratedMessage {
  factory BuyTreasuryBillRequest({
    $core.String? assetId,
    $core.double? amount,
    $core.String? currency,
    $core.String? idempotencyKey,
    $core.String? verificationToken,
  }) {
    final result = create();
    if (assetId != null) result.assetId = assetId;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    if (idempotencyKey != null) result.idempotencyKey = idempotencyKey;
    if (verificationToken != null) result.verificationToken = verificationToken;
    return result;
  }

  BuyTreasuryBillRequest._();

  factory BuyTreasuryBillRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BuyTreasuryBillRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BuyTreasuryBillRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'assetId')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(3, _omitFieldNames ? '' : 'currency')
    ..aOS(4, _omitFieldNames ? '' : 'idempotencyKey')
    ..aOS(5, _omitFieldNames ? '' : 'verificationToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BuyTreasuryBillRequest clone() =>
      BuyTreasuryBillRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BuyTreasuryBillRequest copyWith(
          void Function(BuyTreasuryBillRequest) updates) =>
      super.copyWith((message) => updates(message as BuyTreasuryBillRequest))
          as BuyTreasuryBillRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BuyTreasuryBillRequest create() => BuyTreasuryBillRequest._();
  @$core.override
  BuyTreasuryBillRequest createEmptyInstance() => create();
  static $pb.PbList<BuyTreasuryBillRequest> createRepeated() =>
      $pb.PbList<BuyTreasuryBillRequest>();
  @$core.pragma('dart2js:noInline')
  static BuyTreasuryBillRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BuyTreasuryBillRequest>(create);
  static BuyTreasuryBillRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get assetId => $_getSZ(0);
  @$pb.TagNumber(1)
  set assetId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAssetId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAssetId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get amount => $_getN(1);
  @$pb.TagNumber(2)
  set amount($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get currency => $_getSZ(2);
  @$pb.TagNumber(3)
  set currency($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCurrency() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrency() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get idempotencyKey => $_getSZ(3);
  @$pb.TagNumber(4)
  set idempotencyKey($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasIdempotencyKey() => $_has(3);
  @$pb.TagNumber(4)
  void clearIdempotencyKey() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get verificationToken => $_getSZ(4);
  @$pb.TagNumber(5)
  set verificationToken($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasVerificationToken() => $_has(4);
  @$pb.TagNumber(5)
  void clearVerificationToken() => $_clearField(5);
}

class BuyTreasuryBillResponse extends $pb.GeneratedMessage {
  factory BuyTreasuryBillResponse({
    $core.String? investmentId,
    $core.double? amount,
    $core.double? units,
    $core.String? status,
    $core.String? message,
  }) {
    final result = create();
    if (investmentId != null) result.investmentId = investmentId;
    if (amount != null) result.amount = amount;
    if (units != null) result.units = units;
    if (status != null) result.status = status;
    if (message != null) result.message = message;
    return result;
  }

  BuyTreasuryBillResponse._();

  factory BuyTreasuryBillResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BuyTreasuryBillResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BuyTreasuryBillResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'investmentId')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'units', $pb.PbFieldType.OD)
    ..aOS(4, _omitFieldNames ? '' : 'status')
    ..aOS(5, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BuyTreasuryBillResponse clone() =>
      BuyTreasuryBillResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BuyTreasuryBillResponse copyWith(
          void Function(BuyTreasuryBillResponse) updates) =>
      super.copyWith((message) => updates(message as BuyTreasuryBillResponse))
          as BuyTreasuryBillResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BuyTreasuryBillResponse create() => BuyTreasuryBillResponse._();
  @$core.override
  BuyTreasuryBillResponse createEmptyInstance() => create();
  static $pb.PbList<BuyTreasuryBillResponse> createRepeated() =>
      $pb.PbList<BuyTreasuryBillResponse>();
  @$core.pragma('dart2js:noInline')
  static BuyTreasuryBillResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BuyTreasuryBillResponse>(create);
  static BuyTreasuryBillResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get investmentId => $_getSZ(0);
  @$pb.TagNumber(1)
  set investmentId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasInvestmentId() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvestmentId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get amount => $_getN(1);
  @$pb.TagNumber(2)
  set amount($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get units => $_getN(2);
  @$pb.TagNumber(3)
  set units($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasUnits() => $_has(2);
  @$pb.TagNumber(3)
  void clearUnits() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get status => $_getSZ(3);
  @$pb.TagNumber(4)
  set status($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearStatus() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get message => $_getSZ(4);
  @$pb.TagNumber(5)
  set message($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasMessage() => $_has(4);
  @$pb.TagNumber(5)
  void clearMessage() => $_clearField(5);
}

class MutualFundInfo extends $pb.GeneratedMessage {
  factory MutualFundInfo({
    $core.String? id,
    $core.String? name,
    $core.String? fundType,
    $core.String? riskLevel,
    $core.double? returnRate,
    $core.double? minInvestment,
    $core.String? currency,
    $core.double? nav,
    $core.String? status,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (fundType != null) result.fundType = fundType;
    if (riskLevel != null) result.riskLevel = riskLevel;
    if (returnRate != null) result.returnRate = returnRate;
    if (minInvestment != null) result.minInvestment = minInvestment;
    if (currency != null) result.currency = currency;
    if (nav != null) result.nav = nav;
    if (status != null) result.status = status;
    return result;
  }

  MutualFundInfo._();

  factory MutualFundInfo.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MutualFundInfo.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MutualFundInfo',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'fundType')
    ..aOS(4, _omitFieldNames ? '' : 'riskLevel')
    ..a<$core.double>(
        5, _omitFieldNames ? '' : 'returnRate', $pb.PbFieldType.OD)
    ..a<$core.double>(
        6, _omitFieldNames ? '' : 'minInvestment', $pb.PbFieldType.OD)
    ..aOS(7, _omitFieldNames ? '' : 'currency')
    ..a<$core.double>(8, _omitFieldNames ? '' : 'nav', $pb.PbFieldType.OD)
    ..aOS(9, _omitFieldNames ? '' : 'status')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MutualFundInfo clone() => MutualFundInfo()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MutualFundInfo copyWith(void Function(MutualFundInfo) updates) =>
      super.copyWith((message) => updates(message as MutualFundInfo))
          as MutualFundInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MutualFundInfo create() => MutualFundInfo._();
  @$core.override
  MutualFundInfo createEmptyInstance() => create();
  static $pb.PbList<MutualFundInfo> createRepeated() =>
      $pb.PbList<MutualFundInfo>();
  @$core.pragma('dart2js:noInline')
  static MutualFundInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MutualFundInfo>(create);
  static MutualFundInfo? _defaultInstance;

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
  $core.String get fundType => $_getSZ(2);
  @$pb.TagNumber(3)
  set fundType($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasFundType() => $_has(2);
  @$pb.TagNumber(3)
  void clearFundType() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get riskLevel => $_getSZ(3);
  @$pb.TagNumber(4)
  set riskLevel($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasRiskLevel() => $_has(3);
  @$pb.TagNumber(4)
  void clearRiskLevel() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get returnRate => $_getN(4);
  @$pb.TagNumber(5)
  set returnRate($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasReturnRate() => $_has(4);
  @$pb.TagNumber(5)
  void clearReturnRate() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.double get minInvestment => $_getN(5);
  @$pb.TagNumber(6)
  set minInvestment($core.double value) => $_setDouble(5, value);
  @$pb.TagNumber(6)
  $core.bool hasMinInvestment() => $_has(5);
  @$pb.TagNumber(6)
  void clearMinInvestment() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get currency => $_getSZ(6);
  @$pb.TagNumber(7)
  set currency($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasCurrency() => $_has(6);
  @$pb.TagNumber(7)
  void clearCurrency() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.double get nav => $_getN(7);
  @$pb.TagNumber(8)
  set nav($core.double value) => $_setDouble(7, value);
  @$pb.TagNumber(8)
  $core.bool hasNav() => $_has(7);
  @$pb.TagNumber(8)
  void clearNav() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get status => $_getSZ(8);
  @$pb.TagNumber(9)
  set status($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasStatus() => $_has(8);
  @$pb.TagNumber(9)
  void clearStatus() => $_clearField(9);
}

class GetMutualFundsRequest extends $pb.GeneratedMessage {
  factory GetMutualFundsRequest() => create();

  GetMutualFundsRequest._();

  factory GetMutualFundsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMutualFundsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMutualFundsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMutualFundsRequest clone() =>
      GetMutualFundsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMutualFundsRequest copyWith(
          void Function(GetMutualFundsRequest) updates) =>
      super.copyWith((message) => updates(message as GetMutualFundsRequest))
          as GetMutualFundsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMutualFundsRequest create() => GetMutualFundsRequest._();
  @$core.override
  GetMutualFundsRequest createEmptyInstance() => create();
  static $pb.PbList<GetMutualFundsRequest> createRepeated() =>
      $pb.PbList<GetMutualFundsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMutualFundsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMutualFundsRequest>(create);
  static GetMutualFundsRequest? _defaultInstance;
}

class GetMutualFundsResponse extends $pb.GeneratedMessage {
  factory GetMutualFundsResponse({
    $core.Iterable<MutualFundInfo>? funds,
  }) {
    final result = create();
    if (funds != null) result.funds.addAll(funds);
    return result;
  }

  GetMutualFundsResponse._();

  factory GetMutualFundsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMutualFundsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMutualFundsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..pc<MutualFundInfo>(1, _omitFieldNames ? '' : 'funds', $pb.PbFieldType.PM,
        subBuilder: MutualFundInfo.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMutualFundsResponse clone() =>
      GetMutualFundsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMutualFundsResponse copyWith(
          void Function(GetMutualFundsResponse) updates) =>
      super.copyWith((message) => updates(message as GetMutualFundsResponse))
          as GetMutualFundsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMutualFundsResponse create() => GetMutualFundsResponse._();
  @$core.override
  GetMutualFundsResponse createEmptyInstance() => create();
  static $pb.PbList<GetMutualFundsResponse> createRepeated() =>
      $pb.PbList<GetMutualFundsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMutualFundsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMutualFundsResponse>(create);
  static GetMutualFundsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<MutualFundInfo> get funds => $_getList(0);
}

class BuyMutualFundRequest extends $pb.GeneratedMessage {
  factory BuyMutualFundRequest({
    $core.String? assetId,
    $core.double? amount,
    $core.String? currency,
    $core.String? idempotencyKey,
    $core.String? verificationToken,
  }) {
    final result = create();
    if (assetId != null) result.assetId = assetId;
    if (amount != null) result.amount = amount;
    if (currency != null) result.currency = currency;
    if (idempotencyKey != null) result.idempotencyKey = idempotencyKey;
    if (verificationToken != null) result.verificationToken = verificationToken;
    return result;
  }

  BuyMutualFundRequest._();

  factory BuyMutualFundRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BuyMutualFundRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BuyMutualFundRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'assetId')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(3, _omitFieldNames ? '' : 'currency')
    ..aOS(4, _omitFieldNames ? '' : 'idempotencyKey')
    ..aOS(5, _omitFieldNames ? '' : 'verificationToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BuyMutualFundRequest clone() =>
      BuyMutualFundRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BuyMutualFundRequest copyWith(void Function(BuyMutualFundRequest) updates) =>
      super.copyWith((message) => updates(message as BuyMutualFundRequest))
          as BuyMutualFundRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BuyMutualFundRequest create() => BuyMutualFundRequest._();
  @$core.override
  BuyMutualFundRequest createEmptyInstance() => create();
  static $pb.PbList<BuyMutualFundRequest> createRepeated() =>
      $pb.PbList<BuyMutualFundRequest>();
  @$core.pragma('dart2js:noInline')
  static BuyMutualFundRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BuyMutualFundRequest>(create);
  static BuyMutualFundRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get assetId => $_getSZ(0);
  @$pb.TagNumber(1)
  set assetId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAssetId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAssetId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get amount => $_getN(1);
  @$pb.TagNumber(2)
  set amount($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get currency => $_getSZ(2);
  @$pb.TagNumber(3)
  set currency($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCurrency() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrency() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get idempotencyKey => $_getSZ(3);
  @$pb.TagNumber(4)
  set idempotencyKey($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasIdempotencyKey() => $_has(3);
  @$pb.TagNumber(4)
  void clearIdempotencyKey() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get verificationToken => $_getSZ(4);
  @$pb.TagNumber(5)
  set verificationToken($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasVerificationToken() => $_has(4);
  @$pb.TagNumber(5)
  void clearVerificationToken() => $_clearField(5);
}

class BuyMutualFundResponse extends $pb.GeneratedMessage {
  factory BuyMutualFundResponse({
    $core.String? investmentId,
    $core.double? amount,
    $core.double? units,
    $core.String? status,
    $core.String? message,
  }) {
    final result = create();
    if (investmentId != null) result.investmentId = investmentId;
    if (amount != null) result.amount = amount;
    if (units != null) result.units = units;
    if (status != null) result.status = status;
    if (message != null) result.message = message;
    return result;
  }

  BuyMutualFundResponse._();

  factory BuyMutualFundResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BuyMutualFundResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BuyMutualFundResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'investmentId')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'units', $pb.PbFieldType.OD)
    ..aOS(4, _omitFieldNames ? '' : 'status')
    ..aOS(5, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BuyMutualFundResponse clone() =>
      BuyMutualFundResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BuyMutualFundResponse copyWith(
          void Function(BuyMutualFundResponse) updates) =>
      super.copyWith((message) => updates(message as BuyMutualFundResponse))
          as BuyMutualFundResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BuyMutualFundResponse create() => BuyMutualFundResponse._();
  @$core.override
  BuyMutualFundResponse createEmptyInstance() => create();
  static $pb.PbList<BuyMutualFundResponse> createRepeated() =>
      $pb.PbList<BuyMutualFundResponse>();
  @$core.pragma('dart2js:noInline')
  static BuyMutualFundResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BuyMutualFundResponse>(create);
  static BuyMutualFundResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get investmentId => $_getSZ(0);
  @$pb.TagNumber(1)
  set investmentId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasInvestmentId() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvestmentId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get amount => $_getN(1);
  @$pb.TagNumber(2)
  set amount($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get units => $_getN(2);
  @$pb.TagNumber(3)
  set units($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasUnits() => $_has(2);
  @$pb.TagNumber(3)
  void clearUnits() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get status => $_getSZ(3);
  @$pb.TagNumber(4)
  set status($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearStatus() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get message => $_getSZ(4);
  @$pb.TagNumber(5)
  set message($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasMessage() => $_has(4);
  @$pb.TagNumber(5)
  void clearMessage() => $_clearField(5);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
