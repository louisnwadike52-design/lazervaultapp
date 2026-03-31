//
//  Generated code. Do not modify.
//  source: investments.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

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
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (userId != null) {
      $result.userId = userId;
    }
    if (accountId != null) {
      $result.accountId = accountId;
    }
    if (investmentType != null) {
      $result.investmentType = investmentType;
    }
    if (assetSymbol != null) {
      $result.assetSymbol = assetSymbol;
    }
    if (assetName != null) {
      $result.assetName = assetName;
    }
    if (amountInvested != null) {
      $result.amountInvested = amountInvested;
    }
    if (quantity != null) {
      $result.quantity = quantity;
    }
    if (purchasePrice != null) {
      $result.purchasePrice = purchasePrice;
    }
    if (currentPrice != null) {
      $result.currentPrice = currentPrice;
    }
    if (currentValue != null) {
      $result.currentValue = currentValue;
    }
    if (profitLoss != null) {
      $result.profitLoss = profitLoss;
    }
    if (profitLossPercentage != null) {
      $result.profitLossPercentage = profitLossPercentage;
    }
    if (status != null) {
      $result.status = status;
    }
    if (metadata != null) {
      $result.metadata = metadata;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      $result.updatedAt = updatedAt;
    }
    if (closedAt != null) {
      $result.closedAt = closedAt;
    }
    return $result;
  }
  Investment._() : super();
  factory Investment.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Investment.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Investment', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'accountId')
    ..aOS(4, _omitFieldNames ? '' : 'investmentType')
    ..aOS(5, _omitFieldNames ? '' : 'assetSymbol')
    ..aOS(6, _omitFieldNames ? '' : 'assetName')
    ..a<$core.double>(7, _omitFieldNames ? '' : 'amountInvested', $pb.PbFieldType.OD)
    ..a<$core.double>(8, _omitFieldNames ? '' : 'quantity', $pb.PbFieldType.OD)
    ..a<$core.double>(9, _omitFieldNames ? '' : 'purchasePrice', $pb.PbFieldType.OD)
    ..a<$core.double>(10, _omitFieldNames ? '' : 'currentPrice', $pb.PbFieldType.OD)
    ..a<$core.double>(11, _omitFieldNames ? '' : 'currentValue', $pb.PbFieldType.OD)
    ..a<$core.double>(12, _omitFieldNames ? '' : 'profitLoss', $pb.PbFieldType.OD)
    ..a<$core.double>(13, _omitFieldNames ? '' : 'profitLossPercentage', $pb.PbFieldType.OD)
    ..aOS(14, _omitFieldNames ? '' : 'status')
    ..aOS(15, _omitFieldNames ? '' : 'metadata')
    ..aOS(16, _omitFieldNames ? '' : 'createdAt')
    ..aOS(17, _omitFieldNames ? '' : 'updatedAt')
    ..aOS(18, _omitFieldNames ? '' : 'closedAt')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Investment clone() => Investment()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Investment copyWith(void Function(Investment) updates) => super.copyWith((message) => updates(message as Investment)) as Investment;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Investment create() => Investment._();
  Investment createEmptyInstance() => create();
  static $pb.PbList<Investment> createRepeated() => $pb.PbList<Investment>();
  @$core.pragma('dart2js:noInline')
  static Investment getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Investment>(create);
  static Investment? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get accountId => $_getSZ(2);
  @$pb.TagNumber(3)
  set accountId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAccountId() => $_has(2);
  @$pb.TagNumber(3)
  void clearAccountId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get investmentType => $_getSZ(3);
  @$pb.TagNumber(4)
  set investmentType($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasInvestmentType() => $_has(3);
  @$pb.TagNumber(4)
  void clearInvestmentType() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get assetSymbol => $_getSZ(4);
  @$pb.TagNumber(5)
  set assetSymbol($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasAssetSymbol() => $_has(4);
  @$pb.TagNumber(5)
  void clearAssetSymbol() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get assetName => $_getSZ(5);
  @$pb.TagNumber(6)
  set assetName($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasAssetName() => $_has(5);
  @$pb.TagNumber(6)
  void clearAssetName() => clearField(6);

  @$pb.TagNumber(7)
  $core.double get amountInvested => $_getN(6);
  @$pb.TagNumber(7)
  set amountInvested($core.double v) { $_setDouble(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasAmountInvested() => $_has(6);
  @$pb.TagNumber(7)
  void clearAmountInvested() => clearField(7);

  @$pb.TagNumber(8)
  $core.double get quantity => $_getN(7);
  @$pb.TagNumber(8)
  set quantity($core.double v) { $_setDouble(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasQuantity() => $_has(7);
  @$pb.TagNumber(8)
  void clearQuantity() => clearField(8);

  @$pb.TagNumber(9)
  $core.double get purchasePrice => $_getN(8);
  @$pb.TagNumber(9)
  set purchasePrice($core.double v) { $_setDouble(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasPurchasePrice() => $_has(8);
  @$pb.TagNumber(9)
  void clearPurchasePrice() => clearField(9);

  @$pb.TagNumber(10)
  $core.double get currentPrice => $_getN(9);
  @$pb.TagNumber(10)
  set currentPrice($core.double v) { $_setDouble(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasCurrentPrice() => $_has(9);
  @$pb.TagNumber(10)
  void clearCurrentPrice() => clearField(10);

  @$pb.TagNumber(11)
  $core.double get currentValue => $_getN(10);
  @$pb.TagNumber(11)
  set currentValue($core.double v) { $_setDouble(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasCurrentValue() => $_has(10);
  @$pb.TagNumber(11)
  void clearCurrentValue() => clearField(11);

  @$pb.TagNumber(12)
  $core.double get profitLoss => $_getN(11);
  @$pb.TagNumber(12)
  set profitLoss($core.double v) { $_setDouble(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasProfitLoss() => $_has(11);
  @$pb.TagNumber(12)
  void clearProfitLoss() => clearField(12);

  @$pb.TagNumber(13)
  $core.double get profitLossPercentage => $_getN(12);
  @$pb.TagNumber(13)
  set profitLossPercentage($core.double v) { $_setDouble(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasProfitLossPercentage() => $_has(12);
  @$pb.TagNumber(13)
  void clearProfitLossPercentage() => clearField(13);

  @$pb.TagNumber(14)
  $core.String get status => $_getSZ(13);
  @$pb.TagNumber(14)
  set status($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasStatus() => $_has(13);
  @$pb.TagNumber(14)
  void clearStatus() => clearField(14);

  @$pb.TagNumber(15)
  $core.String get metadata => $_getSZ(14);
  @$pb.TagNumber(15)
  set metadata($core.String v) { $_setString(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasMetadata() => $_has(14);
  @$pb.TagNumber(15)
  void clearMetadata() => clearField(15);

  @$pb.TagNumber(16)
  $core.String get createdAt => $_getSZ(15);
  @$pb.TagNumber(16)
  set createdAt($core.String v) { $_setString(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasCreatedAt() => $_has(15);
  @$pb.TagNumber(16)
  void clearCreatedAt() => clearField(16);

  @$pb.TagNumber(17)
  $core.String get updatedAt => $_getSZ(16);
  @$pb.TagNumber(17)
  set updatedAt($core.String v) { $_setString(16, v); }
  @$pb.TagNumber(17)
  $core.bool hasUpdatedAt() => $_has(16);
  @$pb.TagNumber(17)
  void clearUpdatedAt() => clearField(17);

  @$pb.TagNumber(18)
  $core.String get closedAt => $_getSZ(17);
  @$pb.TagNumber(18)
  set closedAt($core.String v) { $_setString(17, v); }
  @$pb.TagNumber(18)
  $core.bool hasClosedAt() => $_has(17);
  @$pb.TagNumber(18)
  void clearClosedAt() => clearField(18);
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
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (userId != null) {
      $result.userId = userId;
    }
    if (stockSymbol != null) {
      $result.stockSymbol = stockSymbol;
    }
    if (stockName != null) {
      $result.stockName = stockName;
    }
    if (quantity != null) {
      $result.quantity = quantity;
    }
    if (averagePrice != null) {
      $result.averagePrice = averagePrice;
    }
    if (currentPrice != null) {
      $result.currentPrice = currentPrice;
    }
    if (totalValue != null) {
      $result.totalValue = totalValue;
    }
    if (profitLoss != null) {
      $result.profitLoss = profitLoss;
    }
    if (profitLossPercentage != null) {
      $result.profitLossPercentage = profitLossPercentage;
    }
    return $result;
  }
  StockHolding._() : super();
  factory StockHolding.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory StockHolding.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'StockHolding', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'stockSymbol')
    ..aOS(4, _omitFieldNames ? '' : 'stockName')
    ..a<$core.double>(5, _omitFieldNames ? '' : 'quantity', $pb.PbFieldType.OD)
    ..a<$core.double>(6, _omitFieldNames ? '' : 'averagePrice', $pb.PbFieldType.OD)
    ..a<$core.double>(7, _omitFieldNames ? '' : 'currentPrice', $pb.PbFieldType.OD)
    ..a<$core.double>(8, _omitFieldNames ? '' : 'totalValue', $pb.PbFieldType.OD)
    ..a<$core.double>(9, _omitFieldNames ? '' : 'profitLoss', $pb.PbFieldType.OD)
    ..a<$core.double>(10, _omitFieldNames ? '' : 'profitLossPercentage', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  StockHolding clone() => StockHolding()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  StockHolding copyWith(void Function(StockHolding) updates) => super.copyWith((message) => updates(message as StockHolding)) as StockHolding;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StockHolding create() => StockHolding._();
  StockHolding createEmptyInstance() => create();
  static $pb.PbList<StockHolding> createRepeated() => $pb.PbList<StockHolding>();
  @$core.pragma('dart2js:noInline')
  static StockHolding getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StockHolding>(create);
  static StockHolding? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get stockSymbol => $_getSZ(2);
  @$pb.TagNumber(3)
  set stockSymbol($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasStockSymbol() => $_has(2);
  @$pb.TagNumber(3)
  void clearStockSymbol() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get stockName => $_getSZ(3);
  @$pb.TagNumber(4)
  set stockName($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasStockName() => $_has(3);
  @$pb.TagNumber(4)
  void clearStockName() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get quantity => $_getN(4);
  @$pb.TagNumber(5)
  set quantity($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasQuantity() => $_has(4);
  @$pb.TagNumber(5)
  void clearQuantity() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get averagePrice => $_getN(5);
  @$pb.TagNumber(6)
  set averagePrice($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasAveragePrice() => $_has(5);
  @$pb.TagNumber(6)
  void clearAveragePrice() => clearField(6);

  @$pb.TagNumber(7)
  $core.double get currentPrice => $_getN(6);
  @$pb.TagNumber(7)
  set currentPrice($core.double v) { $_setDouble(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasCurrentPrice() => $_has(6);
  @$pb.TagNumber(7)
  void clearCurrentPrice() => clearField(7);

  @$pb.TagNumber(8)
  $core.double get totalValue => $_getN(7);
  @$pb.TagNumber(8)
  set totalValue($core.double v) { $_setDouble(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasTotalValue() => $_has(7);
  @$pb.TagNumber(8)
  void clearTotalValue() => clearField(8);

  @$pb.TagNumber(9)
  $core.double get profitLoss => $_getN(8);
  @$pb.TagNumber(9)
  set profitLoss($core.double v) { $_setDouble(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasProfitLoss() => $_has(8);
  @$pb.TagNumber(9)
  void clearProfitLoss() => clearField(9);

  @$pb.TagNumber(10)
  $core.double get profitLossPercentage => $_getN(9);
  @$pb.TagNumber(10)
  set profitLossPercentage($core.double v) { $_setDouble(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasProfitLossPercentage() => $_has(9);
  @$pb.TagNumber(10)
  void clearProfitLossPercentage() => clearField(10);
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
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (userId != null) {
      $result.userId = userId;
    }
    if (cryptoSymbol != null) {
      $result.cryptoSymbol = cryptoSymbol;
    }
    if (cryptoName != null) {
      $result.cryptoName = cryptoName;
    }
    if (quantity != null) {
      $result.quantity = quantity;
    }
    if (averagePrice != null) {
      $result.averagePrice = averagePrice;
    }
    if (currentPrice != null) {
      $result.currentPrice = currentPrice;
    }
    if (totalValue != null) {
      $result.totalValue = totalValue;
    }
    if (profitLoss != null) {
      $result.profitLoss = profitLoss;
    }
    if (profitLossPercentage != null) {
      $result.profitLossPercentage = profitLossPercentage;
    }
    return $result;
  }
  CryptoHolding._() : super();
  factory CryptoHolding.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CryptoHolding.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CryptoHolding', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'cryptoSymbol')
    ..aOS(4, _omitFieldNames ? '' : 'cryptoName')
    ..a<$core.double>(5, _omitFieldNames ? '' : 'quantity', $pb.PbFieldType.OD)
    ..a<$core.double>(6, _omitFieldNames ? '' : 'averagePrice', $pb.PbFieldType.OD)
    ..a<$core.double>(7, _omitFieldNames ? '' : 'currentPrice', $pb.PbFieldType.OD)
    ..a<$core.double>(8, _omitFieldNames ? '' : 'totalValue', $pb.PbFieldType.OD)
    ..a<$core.double>(9, _omitFieldNames ? '' : 'profitLoss', $pb.PbFieldType.OD)
    ..a<$core.double>(10, _omitFieldNames ? '' : 'profitLossPercentage', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CryptoHolding clone() => CryptoHolding()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CryptoHolding copyWith(void Function(CryptoHolding) updates) => super.copyWith((message) => updates(message as CryptoHolding)) as CryptoHolding;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CryptoHolding create() => CryptoHolding._();
  CryptoHolding createEmptyInstance() => create();
  static $pb.PbList<CryptoHolding> createRepeated() => $pb.PbList<CryptoHolding>();
  @$core.pragma('dart2js:noInline')
  static CryptoHolding getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CryptoHolding>(create);
  static CryptoHolding? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get cryptoSymbol => $_getSZ(2);
  @$pb.TagNumber(3)
  set cryptoSymbol($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCryptoSymbol() => $_has(2);
  @$pb.TagNumber(3)
  void clearCryptoSymbol() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get cryptoName => $_getSZ(3);
  @$pb.TagNumber(4)
  set cryptoName($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCryptoName() => $_has(3);
  @$pb.TagNumber(4)
  void clearCryptoName() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get quantity => $_getN(4);
  @$pb.TagNumber(5)
  set quantity($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasQuantity() => $_has(4);
  @$pb.TagNumber(5)
  void clearQuantity() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get averagePrice => $_getN(5);
  @$pb.TagNumber(6)
  set averagePrice($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasAveragePrice() => $_has(5);
  @$pb.TagNumber(6)
  void clearAveragePrice() => clearField(6);

  @$pb.TagNumber(7)
  $core.double get currentPrice => $_getN(6);
  @$pb.TagNumber(7)
  set currentPrice($core.double v) { $_setDouble(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasCurrentPrice() => $_has(6);
  @$pb.TagNumber(7)
  void clearCurrentPrice() => clearField(7);

  @$pb.TagNumber(8)
  $core.double get totalValue => $_getN(7);
  @$pb.TagNumber(8)
  set totalValue($core.double v) { $_setDouble(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasTotalValue() => $_has(7);
  @$pb.TagNumber(8)
  void clearTotalValue() => clearField(8);

  @$pb.TagNumber(9)
  $core.double get profitLoss => $_getN(8);
  @$pb.TagNumber(9)
  set profitLoss($core.double v) { $_setDouble(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasProfitLoss() => $_has(8);
  @$pb.TagNumber(9)
  void clearProfitLoss() => clearField(9);

  @$pb.TagNumber(10)
  $core.double get profitLossPercentage => $_getN(9);
  @$pb.TagNumber(10)
  set profitLossPercentage($core.double v) { $_setDouble(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasProfitLossPercentage() => $_has(9);
  @$pb.TagNumber(10)
  void clearProfitLossPercentage() => clearField(10);
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
    final $result = create();
    if (accountId != null) {
      $result.accountId = accountId;
    }
    if (investmentType != null) {
      $result.investmentType = investmentType;
    }
    if (assetSymbol != null) {
      $result.assetSymbol = assetSymbol;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (duration != null) {
      $result.duration = duration;
    }
    if (transactionId != null) {
      $result.transactionId = transactionId;
    }
    if (verificationToken != null) {
      $result.verificationToken = verificationToken;
    }
    return $result;
  }
  CreateInvestmentRequest._() : super();
  factory CreateInvestmentRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateInvestmentRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateInvestmentRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..aOS(2, _omitFieldNames ? '' : 'investmentType')
    ..aOS(3, _omitFieldNames ? '' : 'assetSymbol')
    ..a<$core.double>(4, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(5, _omitFieldNames ? '' : 'duration')
    ..aOS(6, _omitFieldNames ? '' : 'transactionId')
    ..aOS(7, _omitFieldNames ? '' : 'verificationToken')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateInvestmentRequest clone() => CreateInvestmentRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateInvestmentRequest copyWith(void Function(CreateInvestmentRequest) updates) => super.copyWith((message) => updates(message as CreateInvestmentRequest)) as CreateInvestmentRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateInvestmentRequest create() => CreateInvestmentRequest._();
  CreateInvestmentRequest createEmptyInstance() => create();
  static $pb.PbList<CreateInvestmentRequest> createRepeated() => $pb.PbList<CreateInvestmentRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateInvestmentRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateInvestmentRequest>(create);
  static CreateInvestmentRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get investmentType => $_getSZ(1);
  @$pb.TagNumber(2)
  set investmentType($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasInvestmentType() => $_has(1);
  @$pb.TagNumber(2)
  void clearInvestmentType() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get assetSymbol => $_getSZ(2);
  @$pb.TagNumber(3)
  set assetSymbol($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAssetSymbol() => $_has(2);
  @$pb.TagNumber(3)
  void clearAssetSymbol() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get amount => $_getN(3);
  @$pb.TagNumber(4)
  set amount($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearAmount() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get duration => $_getSZ(4);
  @$pb.TagNumber(5)
  set duration($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasDuration() => $_has(4);
  @$pb.TagNumber(5)
  void clearDuration() => clearField(5);

  /// Transaction PIN verification (replaces direct PIN field)
  @$pb.TagNumber(6)
  $core.String get transactionId => $_getSZ(5);
  @$pb.TagNumber(6)
  set transactionId($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasTransactionId() => $_has(5);
  @$pb.TagNumber(6)
  void clearTransactionId() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get verificationToken => $_getSZ(6);
  @$pb.TagNumber(7)
  set verificationToken($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasVerificationToken() => $_has(6);
  @$pb.TagNumber(7)
  void clearVerificationToken() => clearField(7);
}

class CreateInvestmentResponse extends $pb.GeneratedMessage {
  factory CreateInvestmentResponse({
    Investment? investment,
    $core.double? newBalance,
    $core.String? message,
  }) {
    final $result = create();
    if (investment != null) {
      $result.investment = investment;
    }
    if (newBalance != null) {
      $result.newBalance = newBalance;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  CreateInvestmentResponse._() : super();
  factory CreateInvestmentResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateInvestmentResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateInvestmentResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..aOM<Investment>(1, _omitFieldNames ? '' : 'investment', subBuilder: Investment.create)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'newBalance', $pb.PbFieldType.OD)
    ..aOS(3, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateInvestmentResponse clone() => CreateInvestmentResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateInvestmentResponse copyWith(void Function(CreateInvestmentResponse) updates) => super.copyWith((message) => updates(message as CreateInvestmentResponse)) as CreateInvestmentResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateInvestmentResponse create() => CreateInvestmentResponse._();
  CreateInvestmentResponse createEmptyInstance() => create();
  static $pb.PbList<CreateInvestmentResponse> createRepeated() => $pb.PbList<CreateInvestmentResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateInvestmentResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateInvestmentResponse>(create);
  static CreateInvestmentResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Investment get investment => $_getN(0);
  @$pb.TagNumber(1)
  set investment(Investment v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasInvestment() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvestment() => clearField(1);
  @$pb.TagNumber(1)
  Investment ensureInvestment() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.double get newBalance => $_getN(1);
  @$pb.TagNumber(2)
  set newBalance($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNewBalance() => $_has(1);
  @$pb.TagNumber(2)
  void clearNewBalance() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => clearField(3);
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
    final $result = create();
    if (investmentType != null) {
      $result.investmentType = investmentType;
    }
    if (status != null) {
      $result.status = status;
    }
    if (limit != null) {
      $result.limit = limit;
    }
    if (offset != null) {
      $result.offset = offset;
    }
    return $result;
  }
  GetInvestmentsRequest._() : super();
  factory GetInvestmentsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInvestmentsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetInvestmentsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'investmentType')
    ..aOS(2, _omitFieldNames ? '' : 'status')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInvestmentsRequest clone() => GetInvestmentsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInvestmentsRequest copyWith(void Function(GetInvestmentsRequest) updates) => super.copyWith((message) => updates(message as GetInvestmentsRequest)) as GetInvestmentsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInvestmentsRequest create() => GetInvestmentsRequest._();
  GetInvestmentsRequest createEmptyInstance() => create();
  static $pb.PbList<GetInvestmentsRequest> createRepeated() => $pb.PbList<GetInvestmentsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInvestmentsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInvestmentsRequest>(create);
  static GetInvestmentsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get investmentType => $_getSZ(0);
  @$pb.TagNumber(1)
  set investmentType($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasInvestmentType() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvestmentType() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get status => $_getSZ(1);
  @$pb.TagNumber(2)
  set status($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get limit => $_getIZ(2);
  @$pb.TagNumber(3)
  set limit($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasLimit() => $_has(2);
  @$pb.TagNumber(3)
  void clearLimit() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get offset => $_getIZ(3);
  @$pb.TagNumber(4)
  set offset($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasOffset() => $_has(3);
  @$pb.TagNumber(4)
  void clearOffset() => clearField(4);
}

class GetInvestmentsResponse extends $pb.GeneratedMessage {
  factory GetInvestmentsResponse({
    $core.Iterable<Investment>? investments,
    $core.int? total,
    $core.double? totalInvested,
    $core.double? totalCurrentValue,
    $core.double? totalProfitLoss,
  }) {
    final $result = create();
    if (investments != null) {
      $result.investments.addAll(investments);
    }
    if (total != null) {
      $result.total = total;
    }
    if (totalInvested != null) {
      $result.totalInvested = totalInvested;
    }
    if (totalCurrentValue != null) {
      $result.totalCurrentValue = totalCurrentValue;
    }
    if (totalProfitLoss != null) {
      $result.totalProfitLoss = totalProfitLoss;
    }
    return $result;
  }
  GetInvestmentsResponse._() : super();
  factory GetInvestmentsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInvestmentsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetInvestmentsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..pc<Investment>(1, _omitFieldNames ? '' : 'investments', $pb.PbFieldType.PM, subBuilder: Investment.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'totalInvested', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'totalCurrentValue', $pb.PbFieldType.OD)
    ..a<$core.double>(5, _omitFieldNames ? '' : 'totalProfitLoss', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInvestmentsResponse clone() => GetInvestmentsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInvestmentsResponse copyWith(void Function(GetInvestmentsResponse) updates) => super.copyWith((message) => updates(message as GetInvestmentsResponse)) as GetInvestmentsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInvestmentsResponse create() => GetInvestmentsResponse._();
  GetInvestmentsResponse createEmptyInstance() => create();
  static $pb.PbList<GetInvestmentsResponse> createRepeated() => $pb.PbList<GetInvestmentsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInvestmentsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInvestmentsResponse>(create);
  static GetInvestmentsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Investment> get investments => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get totalInvested => $_getN(2);
  @$pb.TagNumber(3)
  set totalInvested($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTotalInvested() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalInvested() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get totalCurrentValue => $_getN(3);
  @$pb.TagNumber(4)
  set totalCurrentValue($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTotalCurrentValue() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalCurrentValue() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get totalProfitLoss => $_getN(4);
  @$pb.TagNumber(5)
  set totalProfitLoss($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTotalProfitLoss() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotalProfitLoss() => clearField(5);
}

/// ===== GET INVESTMENT =====
/// NOTE: user_id extracted from JWT token, not from request
class GetInvestmentRequest extends $pb.GeneratedMessage {
  factory GetInvestmentRequest({
    $core.String? investmentId,
  }) {
    final $result = create();
    if (investmentId != null) {
      $result.investmentId = investmentId;
    }
    return $result;
  }
  GetInvestmentRequest._() : super();
  factory GetInvestmentRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInvestmentRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetInvestmentRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'investmentId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInvestmentRequest clone() => GetInvestmentRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInvestmentRequest copyWith(void Function(GetInvestmentRequest) updates) => super.copyWith((message) => updates(message as GetInvestmentRequest)) as GetInvestmentRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInvestmentRequest create() => GetInvestmentRequest._();
  GetInvestmentRequest createEmptyInstance() => create();
  static $pb.PbList<GetInvestmentRequest> createRepeated() => $pb.PbList<GetInvestmentRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInvestmentRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInvestmentRequest>(create);
  static GetInvestmentRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get investmentId => $_getSZ(0);
  @$pb.TagNumber(1)
  set investmentId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasInvestmentId() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvestmentId() => clearField(1);
}

class GetInvestmentResponse extends $pb.GeneratedMessage {
  factory GetInvestmentResponse({
    Investment? investment,
  }) {
    final $result = create();
    if (investment != null) {
      $result.investment = investment;
    }
    return $result;
  }
  GetInvestmentResponse._() : super();
  factory GetInvestmentResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInvestmentResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetInvestmentResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..aOM<Investment>(1, _omitFieldNames ? '' : 'investment', subBuilder: Investment.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInvestmentResponse clone() => GetInvestmentResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInvestmentResponse copyWith(void Function(GetInvestmentResponse) updates) => super.copyWith((message) => updates(message as GetInvestmentResponse)) as GetInvestmentResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInvestmentResponse create() => GetInvestmentResponse._();
  GetInvestmentResponse createEmptyInstance() => create();
  static $pb.PbList<GetInvestmentResponse> createRepeated() => $pb.PbList<GetInvestmentResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInvestmentResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInvestmentResponse>(create);
  static GetInvestmentResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Investment get investment => $_getN(0);
  @$pb.TagNumber(1)
  set investment(Investment v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasInvestment() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvestment() => clearField(1);
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
    final $result = create();
    if (investmentId != null) {
      $result.investmentId = investmentId;
    }
    if (transactionId != null) {
      $result.transactionId = transactionId;
    }
    if (verificationToken != null) {
      $result.verificationToken = verificationToken;
    }
    return $result;
  }
  CloseInvestmentRequest._() : super();
  factory CloseInvestmentRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CloseInvestmentRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CloseInvestmentRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'investmentId')
    ..aOS(2, _omitFieldNames ? '' : 'transactionId')
    ..aOS(3, _omitFieldNames ? '' : 'verificationToken')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CloseInvestmentRequest clone() => CloseInvestmentRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CloseInvestmentRequest copyWith(void Function(CloseInvestmentRequest) updates) => super.copyWith((message) => updates(message as CloseInvestmentRequest)) as CloseInvestmentRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CloseInvestmentRequest create() => CloseInvestmentRequest._();
  CloseInvestmentRequest createEmptyInstance() => create();
  static $pb.PbList<CloseInvestmentRequest> createRepeated() => $pb.PbList<CloseInvestmentRequest>();
  @$core.pragma('dart2js:noInline')
  static CloseInvestmentRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CloseInvestmentRequest>(create);
  static CloseInvestmentRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get investmentId => $_getSZ(0);
  @$pb.TagNumber(1)
  set investmentId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasInvestmentId() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvestmentId() => clearField(1);

  /// Transaction PIN verification (replaces direct PIN field)
  @$pb.TagNumber(2)
  $core.String get transactionId => $_getSZ(1);
  @$pb.TagNumber(2)
  set transactionId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTransactionId() => $_has(1);
  @$pb.TagNumber(2)
  void clearTransactionId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get verificationToken => $_getSZ(2);
  @$pb.TagNumber(3)
  set verificationToken($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasVerificationToken() => $_has(2);
  @$pb.TagNumber(3)
  void clearVerificationToken() => clearField(3);
}

class CloseInvestmentResponse extends $pb.GeneratedMessage {
  factory CloseInvestmentResponse({
    Investment? investment,
    $core.double? finalValue,
    $core.double? profitLoss,
    $core.double? newBalance,
    $core.String? message,
  }) {
    final $result = create();
    if (investment != null) {
      $result.investment = investment;
    }
    if (finalValue != null) {
      $result.finalValue = finalValue;
    }
    if (profitLoss != null) {
      $result.profitLoss = profitLoss;
    }
    if (newBalance != null) {
      $result.newBalance = newBalance;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  CloseInvestmentResponse._() : super();
  factory CloseInvestmentResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CloseInvestmentResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CloseInvestmentResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..aOM<Investment>(1, _omitFieldNames ? '' : 'investment', subBuilder: Investment.create)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'finalValue', $pb.PbFieldType.OD)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'profitLoss', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'newBalance', $pb.PbFieldType.OD)
    ..aOS(5, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CloseInvestmentResponse clone() => CloseInvestmentResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CloseInvestmentResponse copyWith(void Function(CloseInvestmentResponse) updates) => super.copyWith((message) => updates(message as CloseInvestmentResponse)) as CloseInvestmentResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CloseInvestmentResponse create() => CloseInvestmentResponse._();
  CloseInvestmentResponse createEmptyInstance() => create();
  static $pb.PbList<CloseInvestmentResponse> createRepeated() => $pb.PbList<CloseInvestmentResponse>();
  @$core.pragma('dart2js:noInline')
  static CloseInvestmentResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CloseInvestmentResponse>(create);
  static CloseInvestmentResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Investment get investment => $_getN(0);
  @$pb.TagNumber(1)
  set investment(Investment v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasInvestment() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvestment() => clearField(1);
  @$pb.TagNumber(1)
  Investment ensureInvestment() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.double get finalValue => $_getN(1);
  @$pb.TagNumber(2)
  set finalValue($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFinalValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearFinalValue() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get profitLoss => $_getN(2);
  @$pb.TagNumber(3)
  set profitLoss($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasProfitLoss() => $_has(2);
  @$pb.TagNumber(3)
  void clearProfitLoss() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get newBalance => $_getN(3);
  @$pb.TagNumber(4)
  set newBalance($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasNewBalance() => $_has(3);
  @$pb.TagNumber(4)
  void clearNewBalance() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get message => $_getSZ(4);
  @$pb.TagNumber(5)
  set message($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasMessage() => $_has(4);
  @$pb.TagNumber(5)
  void clearMessage() => clearField(5);
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
    final $result = create();
    if (userId != null) {
      $result.userId = userId;
    }
    if (symbol != null) {
      $result.symbol = symbol;
    }
    if (quantity != null) {
      $result.quantity = quantity;
    }
    if (pricePerShare != null) {
      $result.pricePerShare = pricePerShare;
    }
    if (orderType != null) {
      $result.orderType = orderType;
    }
    if (transactionId != null) {
      $result.transactionId = transactionId;
    }
    if (verificationToken != null) {
      $result.verificationToken = verificationToken;
    }
    return $result;
  }
  BuyStockRequest._() : super();
  factory BuyStockRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BuyStockRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'BuyStockRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'symbol')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'quantity', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'pricePerShare', $pb.PbFieldType.OD)
    ..aOS(5, _omitFieldNames ? '' : 'orderType')
    ..aOS(6, _omitFieldNames ? '' : 'transactionId')
    ..aOS(7, _omitFieldNames ? '' : 'verificationToken')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BuyStockRequest clone() => BuyStockRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BuyStockRequest copyWith(void Function(BuyStockRequest) updates) => super.copyWith((message) => updates(message as BuyStockRequest)) as BuyStockRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BuyStockRequest create() => BuyStockRequest._();
  BuyStockRequest createEmptyInstance() => create();
  static $pb.PbList<BuyStockRequest> createRepeated() => $pb.PbList<BuyStockRequest>();
  @$core.pragma('dart2js:noInline')
  static BuyStockRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BuyStockRequest>(create);
  static BuyStockRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get symbol => $_getSZ(1);
  @$pb.TagNumber(2)
  set symbol($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSymbol() => $_has(1);
  @$pb.TagNumber(2)
  void clearSymbol() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get quantity => $_getN(2);
  @$pb.TagNumber(3)
  set quantity($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasQuantity() => $_has(2);
  @$pb.TagNumber(3)
  void clearQuantity() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get pricePerShare => $_getN(3);
  @$pb.TagNumber(4)
  set pricePerShare($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPricePerShare() => $_has(3);
  @$pb.TagNumber(4)
  void clearPricePerShare() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get orderType => $_getSZ(4);
  @$pb.TagNumber(5)
  set orderType($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasOrderType() => $_has(4);
  @$pb.TagNumber(5)
  void clearOrderType() => clearField(5);

  /// Transaction PIN verification (replaces direct PIN field)
  @$pb.TagNumber(6)
  $core.String get transactionId => $_getSZ(5);
  @$pb.TagNumber(6)
  set transactionId($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasTransactionId() => $_has(5);
  @$pb.TagNumber(6)
  void clearTransactionId() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get verificationToken => $_getSZ(6);
  @$pb.TagNumber(7)
  set verificationToken($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasVerificationToken() => $_has(6);
  @$pb.TagNumber(7)
  void clearVerificationToken() => clearField(7);
}

class BuyStockResponse extends $pb.GeneratedMessage {
  factory BuyStockResponse({
    Trade? trade,
    Investment? investment,
    $core.double? totalCost,
    $core.double? newBalance,
    $core.String? message,
  }) {
    final $result = create();
    if (trade != null) {
      $result.trade = trade;
    }
    if (investment != null) {
      $result.investment = investment;
    }
    if (totalCost != null) {
      $result.totalCost = totalCost;
    }
    if (newBalance != null) {
      $result.newBalance = newBalance;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  BuyStockResponse._() : super();
  factory BuyStockResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BuyStockResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'BuyStockResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..aOM<Trade>(1, _omitFieldNames ? '' : 'trade', subBuilder: Trade.create)
    ..aOM<Investment>(2, _omitFieldNames ? '' : 'investment', subBuilder: Investment.create)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'totalCost', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'newBalance', $pb.PbFieldType.OD)
    ..aOS(5, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BuyStockResponse clone() => BuyStockResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BuyStockResponse copyWith(void Function(BuyStockResponse) updates) => super.copyWith((message) => updates(message as BuyStockResponse)) as BuyStockResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BuyStockResponse create() => BuyStockResponse._();
  BuyStockResponse createEmptyInstance() => create();
  static $pb.PbList<BuyStockResponse> createRepeated() => $pb.PbList<BuyStockResponse>();
  @$core.pragma('dart2js:noInline')
  static BuyStockResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BuyStockResponse>(create);
  static BuyStockResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Trade get trade => $_getN(0);
  @$pb.TagNumber(1)
  set trade(Trade v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasTrade() => $_has(0);
  @$pb.TagNumber(1)
  void clearTrade() => clearField(1);
  @$pb.TagNumber(1)
  Trade ensureTrade() => $_ensure(0);

  @$pb.TagNumber(2)
  Investment get investment => $_getN(1);
  @$pb.TagNumber(2)
  set investment(Investment v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasInvestment() => $_has(1);
  @$pb.TagNumber(2)
  void clearInvestment() => clearField(2);
  @$pb.TagNumber(2)
  Investment ensureInvestment() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.double get totalCost => $_getN(2);
  @$pb.TagNumber(3)
  set totalCost($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTotalCost() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalCost() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get newBalance => $_getN(3);
  @$pb.TagNumber(4)
  set newBalance($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasNewBalance() => $_has(3);
  @$pb.TagNumber(4)
  void clearNewBalance() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get message => $_getSZ(4);
  @$pb.TagNumber(5)
  set message($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasMessage() => $_has(4);
  @$pb.TagNumber(5)
  void clearMessage() => clearField(5);
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
    final $result = create();
    if (userId != null) {
      $result.userId = userId;
    }
    if (symbol != null) {
      $result.symbol = symbol;
    }
    if (quantity != null) {
      $result.quantity = quantity;
    }
    if (pricePerShare != null) {
      $result.pricePerShare = pricePerShare;
    }
    if (orderType != null) {
      $result.orderType = orderType;
    }
    if (transactionId != null) {
      $result.transactionId = transactionId;
    }
    if (verificationToken != null) {
      $result.verificationToken = verificationToken;
    }
    return $result;
  }
  SellStockRequest._() : super();
  factory SellStockRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SellStockRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SellStockRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'symbol')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'quantity', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'pricePerShare', $pb.PbFieldType.OD)
    ..aOS(5, _omitFieldNames ? '' : 'orderType')
    ..aOS(6, _omitFieldNames ? '' : 'transactionId')
    ..aOS(7, _omitFieldNames ? '' : 'verificationToken')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SellStockRequest clone() => SellStockRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SellStockRequest copyWith(void Function(SellStockRequest) updates) => super.copyWith((message) => updates(message as SellStockRequest)) as SellStockRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SellStockRequest create() => SellStockRequest._();
  SellStockRequest createEmptyInstance() => create();
  static $pb.PbList<SellStockRequest> createRepeated() => $pb.PbList<SellStockRequest>();
  @$core.pragma('dart2js:noInline')
  static SellStockRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SellStockRequest>(create);
  static SellStockRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get symbol => $_getSZ(1);
  @$pb.TagNumber(2)
  set symbol($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSymbol() => $_has(1);
  @$pb.TagNumber(2)
  void clearSymbol() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get quantity => $_getN(2);
  @$pb.TagNumber(3)
  set quantity($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasQuantity() => $_has(2);
  @$pb.TagNumber(3)
  void clearQuantity() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get pricePerShare => $_getN(3);
  @$pb.TagNumber(4)
  set pricePerShare($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPricePerShare() => $_has(3);
  @$pb.TagNumber(4)
  void clearPricePerShare() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get orderType => $_getSZ(4);
  @$pb.TagNumber(5)
  set orderType($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasOrderType() => $_has(4);
  @$pb.TagNumber(5)
  void clearOrderType() => clearField(5);

  /// Transaction PIN verification (replaces direct PIN field)
  @$pb.TagNumber(6)
  $core.String get transactionId => $_getSZ(5);
  @$pb.TagNumber(6)
  set transactionId($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasTransactionId() => $_has(5);
  @$pb.TagNumber(6)
  void clearTransactionId() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get verificationToken => $_getSZ(6);
  @$pb.TagNumber(7)
  set verificationToken($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasVerificationToken() => $_has(6);
  @$pb.TagNumber(7)
  void clearVerificationToken() => clearField(7);
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
    final $result = create();
    if (trade != null) {
      $result.trade = trade;
    }
    if (investment != null) {
      $result.investment = investment;
    }
    if (totalProceeds != null) {
      $result.totalProceeds = totalProceeds;
    }
    if (profitLoss != null) {
      $result.profitLoss = profitLoss;
    }
    if (newBalance != null) {
      $result.newBalance = newBalance;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  SellStockResponse._() : super();
  factory SellStockResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SellStockResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SellStockResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..aOM<Trade>(1, _omitFieldNames ? '' : 'trade', subBuilder: Trade.create)
    ..aOM<Investment>(2, _omitFieldNames ? '' : 'investment', subBuilder: Investment.create)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'totalProceeds', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'profitLoss', $pb.PbFieldType.OD)
    ..a<$core.double>(5, _omitFieldNames ? '' : 'newBalance', $pb.PbFieldType.OD)
    ..aOS(6, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SellStockResponse clone() => SellStockResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SellStockResponse copyWith(void Function(SellStockResponse) updates) => super.copyWith((message) => updates(message as SellStockResponse)) as SellStockResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SellStockResponse create() => SellStockResponse._();
  SellStockResponse createEmptyInstance() => create();
  static $pb.PbList<SellStockResponse> createRepeated() => $pb.PbList<SellStockResponse>();
  @$core.pragma('dart2js:noInline')
  static SellStockResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SellStockResponse>(create);
  static SellStockResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Trade get trade => $_getN(0);
  @$pb.TagNumber(1)
  set trade(Trade v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasTrade() => $_has(0);
  @$pb.TagNumber(1)
  void clearTrade() => clearField(1);
  @$pb.TagNumber(1)
  Trade ensureTrade() => $_ensure(0);

  @$pb.TagNumber(2)
  Investment get investment => $_getN(1);
  @$pb.TagNumber(2)
  set investment(Investment v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasInvestment() => $_has(1);
  @$pb.TagNumber(2)
  void clearInvestment() => clearField(2);
  @$pb.TagNumber(2)
  Investment ensureInvestment() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.double get totalProceeds => $_getN(2);
  @$pb.TagNumber(3)
  set totalProceeds($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTotalProceeds() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalProceeds() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get profitLoss => $_getN(3);
  @$pb.TagNumber(4)
  set profitLoss($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasProfitLoss() => $_has(3);
  @$pb.TagNumber(4)
  void clearProfitLoss() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get newBalance => $_getN(4);
  @$pb.TagNumber(5)
  set newBalance($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasNewBalance() => $_has(4);
  @$pb.TagNumber(5)
  void clearNewBalance() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get message => $_getSZ(5);
  @$pb.TagNumber(6)
  set message($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasMessage() => $_has(5);
  @$pb.TagNumber(6)
  void clearMessage() => clearField(6);
}

/// ===== GET STOCK QUOTE =====
class GetStockQuoteRequest extends $pb.GeneratedMessage {
  factory GetStockQuoteRequest({
    $core.String? symbol,
  }) {
    final $result = create();
    if (symbol != null) {
      $result.symbol = symbol;
    }
    return $result;
  }
  GetStockQuoteRequest._() : super();
  factory GetStockQuoteRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetStockQuoteRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetStockQuoteRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'symbol')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetStockQuoteRequest clone() => GetStockQuoteRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetStockQuoteRequest copyWith(void Function(GetStockQuoteRequest) updates) => super.copyWith((message) => updates(message as GetStockQuoteRequest)) as GetStockQuoteRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetStockQuoteRequest create() => GetStockQuoteRequest._();
  GetStockQuoteRequest createEmptyInstance() => create();
  static $pb.PbList<GetStockQuoteRequest> createRepeated() => $pb.PbList<GetStockQuoteRequest>();
  @$core.pragma('dart2js:noInline')
  static GetStockQuoteRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetStockQuoteRequest>(create);
  static GetStockQuoteRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get symbol => $_getSZ(0);
  @$pb.TagNumber(1)
  set symbol($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSymbol() => $_has(0);
  @$pb.TagNumber(1)
  void clearSymbol() => clearField(1);
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
    final $result = create();
    if (symbol != null) {
      $result.symbol = symbol;
    }
    if (name != null) {
      $result.name = name;
    }
    if (price != null) {
      $result.price = price;
    }
    if (change != null) {
      $result.change = change;
    }
    if (changePercent != null) {
      $result.changePercent = changePercent;
    }
    if (dayHigh != null) {
      $result.dayHigh = dayHigh;
    }
    if (dayLow != null) {
      $result.dayLow = dayLow;
    }
    if (volume != null) {
      $result.volume = volume;
    }
    if (marketCap != null) {
      $result.marketCap = marketCap;
    }
    if (timestamp != null) {
      $result.timestamp = timestamp;
    }
    return $result;
  }
  StockQuote._() : super();
  factory StockQuote.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory StockQuote.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'StockQuote', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'symbol')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'price', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'change', $pb.PbFieldType.OD)
    ..a<$core.double>(5, _omitFieldNames ? '' : 'changePercent', $pb.PbFieldType.OD)
    ..a<$core.double>(6, _omitFieldNames ? '' : 'dayHigh', $pb.PbFieldType.OD)
    ..a<$core.double>(7, _omitFieldNames ? '' : 'dayLow', $pb.PbFieldType.OD)
    ..a<$core.double>(8, _omitFieldNames ? '' : 'volume', $pb.PbFieldType.OD)
    ..aOS(9, _omitFieldNames ? '' : 'marketCap')
    ..aOS(10, _omitFieldNames ? '' : 'timestamp')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  StockQuote clone() => StockQuote()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  StockQuote copyWith(void Function(StockQuote) updates) => super.copyWith((message) => updates(message as StockQuote)) as StockQuote;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StockQuote create() => StockQuote._();
  StockQuote createEmptyInstance() => create();
  static $pb.PbList<StockQuote> createRepeated() => $pb.PbList<StockQuote>();
  @$core.pragma('dart2js:noInline')
  static StockQuote getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StockQuote>(create);
  static StockQuote? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get symbol => $_getSZ(0);
  @$pb.TagNumber(1)
  set symbol($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSymbol() => $_has(0);
  @$pb.TagNumber(1)
  void clearSymbol() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get price => $_getN(2);
  @$pb.TagNumber(3)
  set price($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPrice() => $_has(2);
  @$pb.TagNumber(3)
  void clearPrice() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get change => $_getN(3);
  @$pb.TagNumber(4)
  set change($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasChange() => $_has(3);
  @$pb.TagNumber(4)
  void clearChange() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get changePercent => $_getN(4);
  @$pb.TagNumber(5)
  set changePercent($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasChangePercent() => $_has(4);
  @$pb.TagNumber(5)
  void clearChangePercent() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get dayHigh => $_getN(5);
  @$pb.TagNumber(6)
  set dayHigh($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasDayHigh() => $_has(5);
  @$pb.TagNumber(6)
  void clearDayHigh() => clearField(6);

  @$pb.TagNumber(7)
  $core.double get dayLow => $_getN(6);
  @$pb.TagNumber(7)
  set dayLow($core.double v) { $_setDouble(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasDayLow() => $_has(6);
  @$pb.TagNumber(7)
  void clearDayLow() => clearField(7);

  @$pb.TagNumber(8)
  $core.double get volume => $_getN(7);
  @$pb.TagNumber(8)
  set volume($core.double v) { $_setDouble(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasVolume() => $_has(7);
  @$pb.TagNumber(8)
  void clearVolume() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get marketCap => $_getSZ(8);
  @$pb.TagNumber(9)
  set marketCap($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasMarketCap() => $_has(8);
  @$pb.TagNumber(9)
  void clearMarketCap() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get timestamp => $_getSZ(9);
  @$pb.TagNumber(10)
  set timestamp($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasTimestamp() => $_has(9);
  @$pb.TagNumber(10)
  void clearTimestamp() => clearField(10);
}

class GetStockQuoteResponse extends $pb.GeneratedMessage {
  factory GetStockQuoteResponse({
    StockQuote? quote,
  }) {
    final $result = create();
    if (quote != null) {
      $result.quote = quote;
    }
    return $result;
  }
  GetStockQuoteResponse._() : super();
  factory GetStockQuoteResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetStockQuoteResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetStockQuoteResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..aOM<StockQuote>(1, _omitFieldNames ? '' : 'quote', subBuilder: StockQuote.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetStockQuoteResponse clone() => GetStockQuoteResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetStockQuoteResponse copyWith(void Function(GetStockQuoteResponse) updates) => super.copyWith((message) => updates(message as GetStockQuoteResponse)) as GetStockQuoteResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetStockQuoteResponse create() => GetStockQuoteResponse._();
  GetStockQuoteResponse createEmptyInstance() => create();
  static $pb.PbList<GetStockQuoteResponse> createRepeated() => $pb.PbList<GetStockQuoteResponse>();
  @$core.pragma('dart2js:noInline')
  static GetStockQuoteResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetStockQuoteResponse>(create);
  static GetStockQuoteResponse? _defaultInstance;

  @$pb.TagNumber(1)
  StockQuote get quote => $_getN(0);
  @$pb.TagNumber(1)
  set quote(StockQuote v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasQuote() => $_has(0);
  @$pb.TagNumber(1)
  void clearQuote() => clearField(1);
  @$pb.TagNumber(1)
  StockQuote ensureQuote() => $_ensure(0);
}

/// ===== GET STOCK PORTFOLIO =====
class GetStockPortfolioRequest extends $pb.GeneratedMessage {
  factory GetStockPortfolioRequest() => create();
  GetStockPortfolioRequest._() : super();
  factory GetStockPortfolioRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetStockPortfolioRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetStockPortfolioRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetStockPortfolioRequest clone() => GetStockPortfolioRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetStockPortfolioRequest copyWith(void Function(GetStockPortfolioRequest) updates) => super.copyWith((message) => updates(message as GetStockPortfolioRequest)) as GetStockPortfolioRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetStockPortfolioRequest create() => GetStockPortfolioRequest._();
  GetStockPortfolioRequest createEmptyInstance() => create();
  static $pb.PbList<GetStockPortfolioRequest> createRepeated() => $pb.PbList<GetStockPortfolioRequest>();
  @$core.pragma('dart2js:noInline')
  static GetStockPortfolioRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetStockPortfolioRequest>(create);
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
    final $result = create();
    if (holdings != null) {
      $result.holdings.addAll(holdings);
    }
    if (totalValue != null) {
      $result.totalValue = totalValue;
    }
    if (totalInvested != null) {
      $result.totalInvested = totalInvested;
    }
    if (totalProfitLoss != null) {
      $result.totalProfitLoss = totalProfitLoss;
    }
    if (profitLossPercentage != null) {
      $result.profitLossPercentage = profitLossPercentage;
    }
    return $result;
  }
  GetStockPortfolioResponse._() : super();
  factory GetStockPortfolioResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetStockPortfolioResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetStockPortfolioResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..pc<StockHolding>(1, _omitFieldNames ? '' : 'holdings', $pb.PbFieldType.PM, subBuilder: StockHolding.create)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'totalValue', $pb.PbFieldType.OD)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'totalInvested', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'totalProfitLoss', $pb.PbFieldType.OD)
    ..a<$core.double>(5, _omitFieldNames ? '' : 'profitLossPercentage', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetStockPortfolioResponse clone() => GetStockPortfolioResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetStockPortfolioResponse copyWith(void Function(GetStockPortfolioResponse) updates) => super.copyWith((message) => updates(message as GetStockPortfolioResponse)) as GetStockPortfolioResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetStockPortfolioResponse create() => GetStockPortfolioResponse._();
  GetStockPortfolioResponse createEmptyInstance() => create();
  static $pb.PbList<GetStockPortfolioResponse> createRepeated() => $pb.PbList<GetStockPortfolioResponse>();
  @$core.pragma('dart2js:noInline')
  static GetStockPortfolioResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetStockPortfolioResponse>(create);
  static GetStockPortfolioResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<StockHolding> get holdings => $_getList(0);

  @$pb.TagNumber(2)
  $core.double get totalValue => $_getN(1);
  @$pb.TagNumber(2)
  set totalValue($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotalValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalValue() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get totalInvested => $_getN(2);
  @$pb.TagNumber(3)
  set totalInvested($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTotalInvested() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalInvested() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get totalProfitLoss => $_getN(3);
  @$pb.TagNumber(4)
  set totalProfitLoss($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTotalProfitLoss() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalProfitLoss() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get profitLossPercentage => $_getN(4);
  @$pb.TagNumber(5)
  set profitLossPercentage($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasProfitLossPercentage() => $_has(4);
  @$pb.TagNumber(5)
  void clearProfitLossPercentage() => clearField(5);
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
    final $result = create();
    if (accountId != null) {
      $result.accountId = accountId;
    }
    if (cryptoSymbol != null) {
      $result.cryptoSymbol = cryptoSymbol;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (quantity != null) {
      $result.quantity = quantity;
    }
    if (pricePerUnit != null) {
      $result.pricePerUnit = pricePerUnit;
    }
    if (transactionId != null) {
      $result.transactionId = transactionId;
    }
    if (verificationToken != null) {
      $result.verificationToken = verificationToken;
    }
    return $result;
  }
  BuyCryptoRequest._() : super();
  factory BuyCryptoRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BuyCryptoRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'BuyCryptoRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..aOS(2, _omitFieldNames ? '' : 'cryptoSymbol')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'quantity', $pb.PbFieldType.OD)
    ..a<$core.double>(5, _omitFieldNames ? '' : 'pricePerUnit', $pb.PbFieldType.OD)
    ..aOS(6, _omitFieldNames ? '' : 'transactionId')
    ..aOS(7, _omitFieldNames ? '' : 'verificationToken')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BuyCryptoRequest clone() => BuyCryptoRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BuyCryptoRequest copyWith(void Function(BuyCryptoRequest) updates) => super.copyWith((message) => updates(message as BuyCryptoRequest)) as BuyCryptoRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BuyCryptoRequest create() => BuyCryptoRequest._();
  BuyCryptoRequest createEmptyInstance() => create();
  static $pb.PbList<BuyCryptoRequest> createRepeated() => $pb.PbList<BuyCryptoRequest>();
  @$core.pragma('dart2js:noInline')
  static BuyCryptoRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BuyCryptoRequest>(create);
  static BuyCryptoRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get cryptoSymbol => $_getSZ(1);
  @$pb.TagNumber(2)
  set cryptoSymbol($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCryptoSymbol() => $_has(1);
  @$pb.TagNumber(2)
  void clearCryptoSymbol() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get amount => $_getN(2);
  @$pb.TagNumber(3)
  set amount($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get quantity => $_getN(3);
  @$pb.TagNumber(4)
  set quantity($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasQuantity() => $_has(3);
  @$pb.TagNumber(4)
  void clearQuantity() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get pricePerUnit => $_getN(4);
  @$pb.TagNumber(5)
  set pricePerUnit($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasPricePerUnit() => $_has(4);
  @$pb.TagNumber(5)
  void clearPricePerUnit() => clearField(5);

  /// Transaction PIN verification (replaces direct PIN field)
  @$pb.TagNumber(6)
  $core.String get transactionId => $_getSZ(5);
  @$pb.TagNumber(6)
  set transactionId($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasTransactionId() => $_has(5);
  @$pb.TagNumber(6)
  void clearTransactionId() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get verificationToken => $_getSZ(6);
  @$pb.TagNumber(7)
  set verificationToken($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasVerificationToken() => $_has(6);
  @$pb.TagNumber(7)
  void clearVerificationToken() => clearField(7);
}

class BuyCryptoResponse extends $pb.GeneratedMessage {
  factory BuyCryptoResponse({
    Investment? investment,
    $core.double? totalCost,
    $core.double? quantityPurchased,
    $core.double? newBalance,
    $core.String? message,
  }) {
    final $result = create();
    if (investment != null) {
      $result.investment = investment;
    }
    if (totalCost != null) {
      $result.totalCost = totalCost;
    }
    if (quantityPurchased != null) {
      $result.quantityPurchased = quantityPurchased;
    }
    if (newBalance != null) {
      $result.newBalance = newBalance;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  BuyCryptoResponse._() : super();
  factory BuyCryptoResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BuyCryptoResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'BuyCryptoResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..aOM<Investment>(1, _omitFieldNames ? '' : 'investment', subBuilder: Investment.create)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'totalCost', $pb.PbFieldType.OD)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'quantityPurchased', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'newBalance', $pb.PbFieldType.OD)
    ..aOS(5, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BuyCryptoResponse clone() => BuyCryptoResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BuyCryptoResponse copyWith(void Function(BuyCryptoResponse) updates) => super.copyWith((message) => updates(message as BuyCryptoResponse)) as BuyCryptoResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BuyCryptoResponse create() => BuyCryptoResponse._();
  BuyCryptoResponse createEmptyInstance() => create();
  static $pb.PbList<BuyCryptoResponse> createRepeated() => $pb.PbList<BuyCryptoResponse>();
  @$core.pragma('dart2js:noInline')
  static BuyCryptoResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BuyCryptoResponse>(create);
  static BuyCryptoResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Investment get investment => $_getN(0);
  @$pb.TagNumber(1)
  set investment(Investment v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasInvestment() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvestment() => clearField(1);
  @$pb.TagNumber(1)
  Investment ensureInvestment() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.double get totalCost => $_getN(1);
  @$pb.TagNumber(2)
  set totalCost($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotalCost() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalCost() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get quantityPurchased => $_getN(2);
  @$pb.TagNumber(3)
  set quantityPurchased($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasQuantityPurchased() => $_has(2);
  @$pb.TagNumber(3)
  void clearQuantityPurchased() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get newBalance => $_getN(3);
  @$pb.TagNumber(4)
  set newBalance($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasNewBalance() => $_has(3);
  @$pb.TagNumber(4)
  void clearNewBalance() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get message => $_getSZ(4);
  @$pb.TagNumber(5)
  set message($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasMessage() => $_has(4);
  @$pb.TagNumber(5)
  void clearMessage() => clearField(5);
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
    final $result = create();
    if (accountId != null) {
      $result.accountId = accountId;
    }
    if (cryptoSymbol != null) {
      $result.cryptoSymbol = cryptoSymbol;
    }
    if (quantity != null) {
      $result.quantity = quantity;
    }
    if (pricePerUnit != null) {
      $result.pricePerUnit = pricePerUnit;
    }
    if (transactionId != null) {
      $result.transactionId = transactionId;
    }
    if (verificationToken != null) {
      $result.verificationToken = verificationToken;
    }
    return $result;
  }
  SellCryptoRequest._() : super();
  factory SellCryptoRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SellCryptoRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SellCryptoRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..aOS(2, _omitFieldNames ? '' : 'cryptoSymbol')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'quantity', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'pricePerUnit', $pb.PbFieldType.OD)
    ..aOS(5, _omitFieldNames ? '' : 'transactionId')
    ..aOS(6, _omitFieldNames ? '' : 'verificationToken')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SellCryptoRequest clone() => SellCryptoRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SellCryptoRequest copyWith(void Function(SellCryptoRequest) updates) => super.copyWith((message) => updates(message as SellCryptoRequest)) as SellCryptoRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SellCryptoRequest create() => SellCryptoRequest._();
  SellCryptoRequest createEmptyInstance() => create();
  static $pb.PbList<SellCryptoRequest> createRepeated() => $pb.PbList<SellCryptoRequest>();
  @$core.pragma('dart2js:noInline')
  static SellCryptoRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SellCryptoRequest>(create);
  static SellCryptoRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get cryptoSymbol => $_getSZ(1);
  @$pb.TagNumber(2)
  set cryptoSymbol($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCryptoSymbol() => $_has(1);
  @$pb.TagNumber(2)
  void clearCryptoSymbol() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get quantity => $_getN(2);
  @$pb.TagNumber(3)
  set quantity($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasQuantity() => $_has(2);
  @$pb.TagNumber(3)
  void clearQuantity() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get pricePerUnit => $_getN(3);
  @$pb.TagNumber(4)
  set pricePerUnit($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPricePerUnit() => $_has(3);
  @$pb.TagNumber(4)
  void clearPricePerUnit() => clearField(4);

  /// Transaction PIN verification (replaces direct PIN field)
  @$pb.TagNumber(5)
  $core.String get transactionId => $_getSZ(4);
  @$pb.TagNumber(5)
  set transactionId($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTransactionId() => $_has(4);
  @$pb.TagNumber(5)
  void clearTransactionId() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get verificationToken => $_getSZ(5);
  @$pb.TagNumber(6)
  set verificationToken($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasVerificationToken() => $_has(5);
  @$pb.TagNumber(6)
  void clearVerificationToken() => clearField(6);
}

class SellCryptoResponse extends $pb.GeneratedMessage {
  factory SellCryptoResponse({
    Investment? investment,
    $core.double? totalProceeds,
    $core.double? profitLoss,
    $core.double? newBalance,
    $core.String? message,
  }) {
    final $result = create();
    if (investment != null) {
      $result.investment = investment;
    }
    if (totalProceeds != null) {
      $result.totalProceeds = totalProceeds;
    }
    if (profitLoss != null) {
      $result.profitLoss = profitLoss;
    }
    if (newBalance != null) {
      $result.newBalance = newBalance;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  SellCryptoResponse._() : super();
  factory SellCryptoResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SellCryptoResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SellCryptoResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..aOM<Investment>(1, _omitFieldNames ? '' : 'investment', subBuilder: Investment.create)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'totalProceeds', $pb.PbFieldType.OD)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'profitLoss', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'newBalance', $pb.PbFieldType.OD)
    ..aOS(5, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SellCryptoResponse clone() => SellCryptoResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SellCryptoResponse copyWith(void Function(SellCryptoResponse) updates) => super.copyWith((message) => updates(message as SellCryptoResponse)) as SellCryptoResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SellCryptoResponse create() => SellCryptoResponse._();
  SellCryptoResponse createEmptyInstance() => create();
  static $pb.PbList<SellCryptoResponse> createRepeated() => $pb.PbList<SellCryptoResponse>();
  @$core.pragma('dart2js:noInline')
  static SellCryptoResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SellCryptoResponse>(create);
  static SellCryptoResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Investment get investment => $_getN(0);
  @$pb.TagNumber(1)
  set investment(Investment v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasInvestment() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvestment() => clearField(1);
  @$pb.TagNumber(1)
  Investment ensureInvestment() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.double get totalProceeds => $_getN(1);
  @$pb.TagNumber(2)
  set totalProceeds($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotalProceeds() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalProceeds() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get profitLoss => $_getN(2);
  @$pb.TagNumber(3)
  set profitLoss($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasProfitLoss() => $_has(2);
  @$pb.TagNumber(3)
  void clearProfitLoss() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get newBalance => $_getN(3);
  @$pb.TagNumber(4)
  set newBalance($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasNewBalance() => $_has(3);
  @$pb.TagNumber(4)
  void clearNewBalance() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get message => $_getSZ(4);
  @$pb.TagNumber(5)
  set message($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasMessage() => $_has(4);
  @$pb.TagNumber(5)
  void clearMessage() => clearField(5);
}

/// ===== GET CRYPTO PORTFOLIO =====
/// NOTE: user_id extracted from JWT token, not from request
class GetCryptoPortfolioRequest extends $pb.GeneratedMessage {
  factory GetCryptoPortfolioRequest() => create();
  GetCryptoPortfolioRequest._() : super();
  factory GetCryptoPortfolioRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCryptoPortfolioRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetCryptoPortfolioRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCryptoPortfolioRequest clone() => GetCryptoPortfolioRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCryptoPortfolioRequest copyWith(void Function(GetCryptoPortfolioRequest) updates) => super.copyWith((message) => updates(message as GetCryptoPortfolioRequest)) as GetCryptoPortfolioRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCryptoPortfolioRequest create() => GetCryptoPortfolioRequest._();
  GetCryptoPortfolioRequest createEmptyInstance() => create();
  static $pb.PbList<GetCryptoPortfolioRequest> createRepeated() => $pb.PbList<GetCryptoPortfolioRequest>();
  @$core.pragma('dart2js:noInline')
  static GetCryptoPortfolioRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetCryptoPortfolioRequest>(create);
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
    final $result = create();
    if (holdings != null) {
      $result.holdings.addAll(holdings);
    }
    if (totalValue != null) {
      $result.totalValue = totalValue;
    }
    if (totalInvested != null) {
      $result.totalInvested = totalInvested;
    }
    if (totalProfitLoss != null) {
      $result.totalProfitLoss = totalProfitLoss;
    }
    if (profitLossPercentage != null) {
      $result.profitLossPercentage = profitLossPercentage;
    }
    return $result;
  }
  GetCryptoPortfolioResponse._() : super();
  factory GetCryptoPortfolioResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCryptoPortfolioResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetCryptoPortfolioResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..pc<CryptoHolding>(1, _omitFieldNames ? '' : 'holdings', $pb.PbFieldType.PM, subBuilder: CryptoHolding.create)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'totalValue', $pb.PbFieldType.OD)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'totalInvested', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'totalProfitLoss', $pb.PbFieldType.OD)
    ..a<$core.double>(5, _omitFieldNames ? '' : 'profitLossPercentage', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCryptoPortfolioResponse clone() => GetCryptoPortfolioResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCryptoPortfolioResponse copyWith(void Function(GetCryptoPortfolioResponse) updates) => super.copyWith((message) => updates(message as GetCryptoPortfolioResponse)) as GetCryptoPortfolioResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCryptoPortfolioResponse create() => GetCryptoPortfolioResponse._();
  GetCryptoPortfolioResponse createEmptyInstance() => create();
  static $pb.PbList<GetCryptoPortfolioResponse> createRepeated() => $pb.PbList<GetCryptoPortfolioResponse>();
  @$core.pragma('dart2js:noInline')
  static GetCryptoPortfolioResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetCryptoPortfolioResponse>(create);
  static GetCryptoPortfolioResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<CryptoHolding> get holdings => $_getList(0);

  @$pb.TagNumber(2)
  $core.double get totalValue => $_getN(1);
  @$pb.TagNumber(2)
  set totalValue($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotalValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalValue() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get totalInvested => $_getN(2);
  @$pb.TagNumber(3)
  set totalInvested($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTotalInvested() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalInvested() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get totalProfitLoss => $_getN(3);
  @$pb.TagNumber(4)
  set totalProfitLoss($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTotalProfitLoss() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalProfitLoss() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get profitLossPercentage => $_getN(4);
  @$pb.TagNumber(5)
  set profitLossPercentage($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasProfitLossPercentage() => $_has(4);
  @$pb.TagNumber(5)
  void clearProfitLossPercentage() => clearField(5);
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
    final $result = create();
    if (accountId != null) {
      $result.accountId = accountId;
    }
    if (fromCurrency != null) {
      $result.fromCurrency = fromCurrency;
    }
    if (toCurrency != null) {
      $result.toCurrency = toCurrency;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (exchangeRate != null) {
      $result.exchangeRate = exchangeRate;
    }
    if (transactionId != null) {
      $result.transactionId = transactionId;
    }
    if (verificationToken != null) {
      $result.verificationToken = verificationToken;
    }
    return $result;
  }
  ExchangeCurrencyRequest._() : super();
  factory ExchangeCurrencyRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ExchangeCurrencyRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ExchangeCurrencyRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..aOS(2, _omitFieldNames ? '' : 'fromCurrency')
    ..aOS(3, _omitFieldNames ? '' : 'toCurrency')
    ..a<$core.double>(4, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..a<$core.double>(5, _omitFieldNames ? '' : 'exchangeRate', $pb.PbFieldType.OD)
    ..aOS(6, _omitFieldNames ? '' : 'transactionId')
    ..aOS(7, _omitFieldNames ? '' : 'verificationToken')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ExchangeCurrencyRequest clone() => ExchangeCurrencyRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ExchangeCurrencyRequest copyWith(void Function(ExchangeCurrencyRequest) updates) => super.copyWith((message) => updates(message as ExchangeCurrencyRequest)) as ExchangeCurrencyRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ExchangeCurrencyRequest create() => ExchangeCurrencyRequest._();
  ExchangeCurrencyRequest createEmptyInstance() => create();
  static $pb.PbList<ExchangeCurrencyRequest> createRepeated() => $pb.PbList<ExchangeCurrencyRequest>();
  @$core.pragma('dart2js:noInline')
  static ExchangeCurrencyRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ExchangeCurrencyRequest>(create);
  static ExchangeCurrencyRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get fromCurrency => $_getSZ(1);
  @$pb.TagNumber(2)
  set fromCurrency($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFromCurrency() => $_has(1);
  @$pb.TagNumber(2)
  void clearFromCurrency() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get toCurrency => $_getSZ(2);
  @$pb.TagNumber(3)
  set toCurrency($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasToCurrency() => $_has(2);
  @$pb.TagNumber(3)
  void clearToCurrency() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get amount => $_getN(3);
  @$pb.TagNumber(4)
  set amount($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearAmount() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get exchangeRate => $_getN(4);
  @$pb.TagNumber(5)
  set exchangeRate($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasExchangeRate() => $_has(4);
  @$pb.TagNumber(5)
  void clearExchangeRate() => clearField(5);

  /// Transaction PIN verification (replaces direct PIN field)
  @$pb.TagNumber(6)
  $core.String get transactionId => $_getSZ(5);
  @$pb.TagNumber(6)
  set transactionId($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasTransactionId() => $_has(5);
  @$pb.TagNumber(6)
  void clearTransactionId() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get verificationToken => $_getSZ(6);
  @$pb.TagNumber(7)
  set verificationToken($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasVerificationToken() => $_has(6);
  @$pb.TagNumber(7)
  void clearVerificationToken() => clearField(7);
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
    final $result = create();
    if (investment != null) {
      $result.investment = investment;
    }
    if (amountSent != null) {
      $result.amountSent = amountSent;
    }
    if (amountReceived != null) {
      $result.amountReceived = amountReceived;
    }
    if (exchangeRate != null) {
      $result.exchangeRate = exchangeRate;
    }
    if (newBalance != null) {
      $result.newBalance = newBalance;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  ExchangeCurrencyResponse._() : super();
  factory ExchangeCurrencyResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ExchangeCurrencyResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ExchangeCurrencyResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..aOM<Investment>(1, _omitFieldNames ? '' : 'investment', subBuilder: Investment.create)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'amountSent', $pb.PbFieldType.OD)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'amountReceived', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'exchangeRate', $pb.PbFieldType.OD)
    ..a<$core.double>(5, _omitFieldNames ? '' : 'newBalance', $pb.PbFieldType.OD)
    ..aOS(6, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ExchangeCurrencyResponse clone() => ExchangeCurrencyResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ExchangeCurrencyResponse copyWith(void Function(ExchangeCurrencyResponse) updates) => super.copyWith((message) => updates(message as ExchangeCurrencyResponse)) as ExchangeCurrencyResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ExchangeCurrencyResponse create() => ExchangeCurrencyResponse._();
  ExchangeCurrencyResponse createEmptyInstance() => create();
  static $pb.PbList<ExchangeCurrencyResponse> createRepeated() => $pb.PbList<ExchangeCurrencyResponse>();
  @$core.pragma('dart2js:noInline')
  static ExchangeCurrencyResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ExchangeCurrencyResponse>(create);
  static ExchangeCurrencyResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Investment get investment => $_getN(0);
  @$pb.TagNumber(1)
  set investment(Investment v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasInvestment() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvestment() => clearField(1);
  @$pb.TagNumber(1)
  Investment ensureInvestment() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.double get amountSent => $_getN(1);
  @$pb.TagNumber(2)
  set amountSent($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAmountSent() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmountSent() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get amountReceived => $_getN(2);
  @$pb.TagNumber(3)
  set amountReceived($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAmountReceived() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmountReceived() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get exchangeRate => $_getN(3);
  @$pb.TagNumber(4)
  set exchangeRate($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasExchangeRate() => $_has(3);
  @$pb.TagNumber(4)
  void clearExchangeRate() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get newBalance => $_getN(4);
  @$pb.TagNumber(5)
  set newBalance($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasNewBalance() => $_has(4);
  @$pb.TagNumber(5)
  void clearNewBalance() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get message => $_getSZ(5);
  @$pb.TagNumber(6)
  set message($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasMessage() => $_has(5);
  @$pb.TagNumber(6)
  void clearMessage() => clearField(6);
}

class GetExchangeRatesRequest extends $pb.GeneratedMessage {
  factory GetExchangeRatesRequest({
    $core.String? baseCurrency,
    $core.Iterable<$core.String>? targetCurrencies,
  }) {
    final $result = create();
    if (baseCurrency != null) {
      $result.baseCurrency = baseCurrency;
    }
    if (targetCurrencies != null) {
      $result.targetCurrencies.addAll(targetCurrencies);
    }
    return $result;
  }
  GetExchangeRatesRequest._() : super();
  factory GetExchangeRatesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetExchangeRatesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetExchangeRatesRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'baseCurrency')
    ..pPS(2, _omitFieldNames ? '' : 'targetCurrencies')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetExchangeRatesRequest clone() => GetExchangeRatesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetExchangeRatesRequest copyWith(void Function(GetExchangeRatesRequest) updates) => super.copyWith((message) => updates(message as GetExchangeRatesRequest)) as GetExchangeRatesRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetExchangeRatesRequest create() => GetExchangeRatesRequest._();
  GetExchangeRatesRequest createEmptyInstance() => create();
  static $pb.PbList<GetExchangeRatesRequest> createRepeated() => $pb.PbList<GetExchangeRatesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetExchangeRatesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetExchangeRatesRequest>(create);
  static GetExchangeRatesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get baseCurrency => $_getSZ(0);
  @$pb.TagNumber(1)
  set baseCurrency($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasBaseCurrency() => $_has(0);
  @$pb.TagNumber(1)
  void clearBaseCurrency() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.String> get targetCurrencies => $_getList(1);
}

class ExchangeRate extends $pb.GeneratedMessage {
  factory ExchangeRate({
    $core.String? fromCurrency,
    $core.String? toCurrency,
    $core.double? rate,
    $core.String? timestamp,
  }) {
    final $result = create();
    if (fromCurrency != null) {
      $result.fromCurrency = fromCurrency;
    }
    if (toCurrency != null) {
      $result.toCurrency = toCurrency;
    }
    if (rate != null) {
      $result.rate = rate;
    }
    if (timestamp != null) {
      $result.timestamp = timestamp;
    }
    return $result;
  }
  ExchangeRate._() : super();
  factory ExchangeRate.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ExchangeRate.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ExchangeRate', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'fromCurrency')
    ..aOS(2, _omitFieldNames ? '' : 'toCurrency')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'rate', $pb.PbFieldType.OD)
    ..aOS(4, _omitFieldNames ? '' : 'timestamp')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ExchangeRate clone() => ExchangeRate()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ExchangeRate copyWith(void Function(ExchangeRate) updates) => super.copyWith((message) => updates(message as ExchangeRate)) as ExchangeRate;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ExchangeRate create() => ExchangeRate._();
  ExchangeRate createEmptyInstance() => create();
  static $pb.PbList<ExchangeRate> createRepeated() => $pb.PbList<ExchangeRate>();
  @$core.pragma('dart2js:noInline')
  static ExchangeRate getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ExchangeRate>(create);
  static ExchangeRate? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fromCurrency => $_getSZ(0);
  @$pb.TagNumber(1)
  set fromCurrency($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFromCurrency() => $_has(0);
  @$pb.TagNumber(1)
  void clearFromCurrency() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get toCurrency => $_getSZ(1);
  @$pb.TagNumber(2)
  set toCurrency($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasToCurrency() => $_has(1);
  @$pb.TagNumber(2)
  void clearToCurrency() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get rate => $_getN(2);
  @$pb.TagNumber(3)
  set rate($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasRate() => $_has(2);
  @$pb.TagNumber(3)
  void clearRate() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get timestamp => $_getSZ(3);
  @$pb.TagNumber(4)
  set timestamp($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTimestamp() => $_has(3);
  @$pb.TagNumber(4)
  void clearTimestamp() => clearField(4);
}

class GetExchangeRatesResponse extends $pb.GeneratedMessage {
  factory GetExchangeRatesResponse({
    $core.Iterable<ExchangeRate>? rates,
    $core.String? baseCurrency,
    $core.String? timestamp,
  }) {
    final $result = create();
    if (rates != null) {
      $result.rates.addAll(rates);
    }
    if (baseCurrency != null) {
      $result.baseCurrency = baseCurrency;
    }
    if (timestamp != null) {
      $result.timestamp = timestamp;
    }
    return $result;
  }
  GetExchangeRatesResponse._() : super();
  factory GetExchangeRatesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetExchangeRatesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetExchangeRatesResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..pc<ExchangeRate>(1, _omitFieldNames ? '' : 'rates', $pb.PbFieldType.PM, subBuilder: ExchangeRate.create)
    ..aOS(2, _omitFieldNames ? '' : 'baseCurrency')
    ..aOS(3, _omitFieldNames ? '' : 'timestamp')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetExchangeRatesResponse clone() => GetExchangeRatesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetExchangeRatesResponse copyWith(void Function(GetExchangeRatesResponse) updates) => super.copyWith((message) => updates(message as GetExchangeRatesResponse)) as GetExchangeRatesResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetExchangeRatesResponse create() => GetExchangeRatesResponse._();
  GetExchangeRatesResponse createEmptyInstance() => create();
  static $pb.PbList<GetExchangeRatesResponse> createRepeated() => $pb.PbList<GetExchangeRatesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetExchangeRatesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetExchangeRatesResponse>(create);
  static GetExchangeRatesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<ExchangeRate> get rates => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get baseCurrency => $_getSZ(1);
  @$pb.TagNumber(2)
  set baseCurrency($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasBaseCurrency() => $_has(1);
  @$pb.TagNumber(2)
  void clearBaseCurrency() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get timestamp => $_getSZ(2);
  @$pb.TagNumber(3)
  set timestamp($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTimestamp() => $_has(2);
  @$pb.TagNumber(3)
  void clearTimestamp() => clearField(3);
}

/// ===== GET PORTFOLIO =====
class GetPortfolioRequest extends $pb.GeneratedMessage {
  factory GetPortfolioRequest({
    $core.String? userId,
  }) {
    final $result = create();
    if (userId != null) {
      $result.userId = userId;
    }
    return $result;
  }
  GetPortfolioRequest._() : super();
  factory GetPortfolioRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPortfolioRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetPortfolioRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPortfolioRequest clone() => GetPortfolioRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPortfolioRequest copyWith(void Function(GetPortfolioRequest) updates) => super.copyWith((message) => updates(message as GetPortfolioRequest)) as GetPortfolioRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPortfolioRequest create() => GetPortfolioRequest._();
  GetPortfolioRequest createEmptyInstance() => create();
  static $pb.PbList<GetPortfolioRequest> createRepeated() => $pb.PbList<GetPortfolioRequest>();
  @$core.pragma('dart2js:noInline')
  static GetPortfolioRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetPortfolioRequest>(create);
  static GetPortfolioRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);
}

class Portfolio extends $pb.GeneratedMessage {
  factory Portfolio({
    $core.double? totalValue,
    $core.Iterable<Position>? positions,
  }) {
    final $result = create();
    if (totalValue != null) {
      $result.totalValue = totalValue;
    }
    if (positions != null) {
      $result.positions.addAll(positions);
    }
    return $result;
  }
  Portfolio._() : super();
  factory Portfolio.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Portfolio.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Portfolio', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'totalValue', $pb.PbFieldType.OD)
    ..pc<Position>(2, _omitFieldNames ? '' : 'positions', $pb.PbFieldType.PM, subBuilder: Position.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Portfolio clone() => Portfolio()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Portfolio copyWith(void Function(Portfolio) updates) => super.copyWith((message) => updates(message as Portfolio)) as Portfolio;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Portfolio create() => Portfolio._();
  Portfolio createEmptyInstance() => create();
  static $pb.PbList<Portfolio> createRepeated() => $pb.PbList<Portfolio>();
  @$core.pragma('dart2js:noInline')
  static Portfolio getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Portfolio>(create);
  static Portfolio? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get totalValue => $_getN(0);
  @$pb.TagNumber(1)
  set totalValue($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTotalValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearTotalValue() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<Position> get positions => $_getList(1);
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
    final $result = create();
    if (symbol != null) {
      $result.symbol = symbol;
    }
    if (name != null) {
      $result.name = name;
    }
    if (quantity != null) {
      $result.quantity = quantity;
    }
    if (currentPrice != null) {
      $result.currentPrice = currentPrice;
    }
    if (currentValue != null) {
      $result.currentValue = currentValue;
    }
    if (profitLoss != null) {
      $result.profitLoss = profitLoss;
    }
    if (profitLossPercentage != null) {
      $result.profitLossPercentage = profitLossPercentage;
    }
    return $result;
  }
  Position._() : super();
  factory Position.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Position.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Position', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'symbol')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'quantity', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'currentPrice', $pb.PbFieldType.OD)
    ..a<$core.double>(5, _omitFieldNames ? '' : 'currentValue', $pb.PbFieldType.OD)
    ..a<$core.double>(6, _omitFieldNames ? '' : 'profitLoss', $pb.PbFieldType.OD)
    ..a<$core.double>(7, _omitFieldNames ? '' : 'profitLossPercentage', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Position clone() => Position()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Position copyWith(void Function(Position) updates) => super.copyWith((message) => updates(message as Position)) as Position;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Position create() => Position._();
  Position createEmptyInstance() => create();
  static $pb.PbList<Position> createRepeated() => $pb.PbList<Position>();
  @$core.pragma('dart2js:noInline')
  static Position getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Position>(create);
  static Position? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get symbol => $_getSZ(0);
  @$pb.TagNumber(1)
  set symbol($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSymbol() => $_has(0);
  @$pb.TagNumber(1)
  void clearSymbol() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get quantity => $_getN(2);
  @$pb.TagNumber(3)
  set quantity($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasQuantity() => $_has(2);
  @$pb.TagNumber(3)
  void clearQuantity() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get currentPrice => $_getN(3);
  @$pb.TagNumber(4)
  set currentPrice($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCurrentPrice() => $_has(3);
  @$pb.TagNumber(4)
  void clearCurrentPrice() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get currentValue => $_getN(4);
  @$pb.TagNumber(5)
  set currentValue($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasCurrentValue() => $_has(4);
  @$pb.TagNumber(5)
  void clearCurrentValue() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get profitLoss => $_getN(5);
  @$pb.TagNumber(6)
  set profitLoss($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasProfitLoss() => $_has(5);
  @$pb.TagNumber(6)
  void clearProfitLoss() => clearField(6);

  @$pb.TagNumber(7)
  $core.double get profitLossPercentage => $_getN(6);
  @$pb.TagNumber(7)
  set profitLossPercentage($core.double v) { $_setDouble(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasProfitLossPercentage() => $_has(6);
  @$pb.TagNumber(7)
  void clearProfitLossPercentage() => clearField(7);
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
    final $result = create();
    if (portfolio != null) {
      $result.portfolio = portfolio;
    }
    if (stocks != null) {
      $result.stocks.addAll(stocks);
    }
    if (crypto != null) {
      $result.crypto.addAll(crypto);
    }
    if (otherInvestments != null) {
      $result.otherInvestments.addAll(otherInvestments);
    }
    if (totalPortfolioValue != null) {
      $result.totalPortfolioValue = totalPortfolioValue;
    }
    if (totalInvested != null) {
      $result.totalInvested = totalInvested;
    }
    if (totalProfitLoss != null) {
      $result.totalProfitLoss = totalProfitLoss;
    }
    if (profitLossPercentage != null) {
      $result.profitLossPercentage = profitLossPercentage;
    }
    return $result;
  }
  GetPortfolioResponse._() : super();
  factory GetPortfolioResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPortfolioResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetPortfolioResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..aOM<Portfolio>(1, _omitFieldNames ? '' : 'portfolio', subBuilder: Portfolio.create)
    ..pc<StockHolding>(2, _omitFieldNames ? '' : 'stocks', $pb.PbFieldType.PM, subBuilder: StockHolding.create)
    ..pc<CryptoHolding>(3, _omitFieldNames ? '' : 'crypto', $pb.PbFieldType.PM, subBuilder: CryptoHolding.create)
    ..pc<Investment>(4, _omitFieldNames ? '' : 'otherInvestments', $pb.PbFieldType.PM, subBuilder: Investment.create)
    ..a<$core.double>(5, _omitFieldNames ? '' : 'totalPortfolioValue', $pb.PbFieldType.OD)
    ..a<$core.double>(6, _omitFieldNames ? '' : 'totalInvested', $pb.PbFieldType.OD)
    ..a<$core.double>(7, _omitFieldNames ? '' : 'totalProfitLoss', $pb.PbFieldType.OD)
    ..a<$core.double>(8, _omitFieldNames ? '' : 'profitLossPercentage', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPortfolioResponse clone() => GetPortfolioResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPortfolioResponse copyWith(void Function(GetPortfolioResponse) updates) => super.copyWith((message) => updates(message as GetPortfolioResponse)) as GetPortfolioResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPortfolioResponse create() => GetPortfolioResponse._();
  GetPortfolioResponse createEmptyInstance() => create();
  static $pb.PbList<GetPortfolioResponse> createRepeated() => $pb.PbList<GetPortfolioResponse>();
  @$core.pragma('dart2js:noInline')
  static GetPortfolioResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetPortfolioResponse>(create);
  static GetPortfolioResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Portfolio get portfolio => $_getN(0);
  @$pb.TagNumber(1)
  set portfolio(Portfolio v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasPortfolio() => $_has(0);
  @$pb.TagNumber(1)
  void clearPortfolio() => clearField(1);
  @$pb.TagNumber(1)
  Portfolio ensurePortfolio() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.List<StockHolding> get stocks => $_getList(1);

  @$pb.TagNumber(3)
  $core.List<CryptoHolding> get crypto => $_getList(2);

  @$pb.TagNumber(4)
  $core.List<Investment> get otherInvestments => $_getList(3);

  @$pb.TagNumber(5)
  $core.double get totalPortfolioValue => $_getN(4);
  @$pb.TagNumber(5)
  set totalPortfolioValue($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTotalPortfolioValue() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotalPortfolioValue() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get totalInvested => $_getN(5);
  @$pb.TagNumber(6)
  set totalInvested($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasTotalInvested() => $_has(5);
  @$pb.TagNumber(6)
  void clearTotalInvested() => clearField(6);

  @$pb.TagNumber(7)
  $core.double get totalProfitLoss => $_getN(6);
  @$pb.TagNumber(7)
  set totalProfitLoss($core.double v) { $_setDouble(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasTotalProfitLoss() => $_has(6);
  @$pb.TagNumber(7)
  void clearTotalProfitLoss() => clearField(7);

  @$pb.TagNumber(8)
  $core.double get profitLossPercentage => $_getN(7);
  @$pb.TagNumber(8)
  set profitLossPercentage($core.double v) { $_setDouble(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasProfitLossPercentage() => $_has(7);
  @$pb.TagNumber(8)
  void clearProfitLossPercentage() => clearField(8);
}

class GetMarketPricesRequest extends $pb.GeneratedMessage {
  factory GetMarketPricesRequest({
    $core.Iterable<$core.String>? stockSymbols,
    $core.Iterable<$core.String>? cryptoSymbols,
  }) {
    final $result = create();
    if (stockSymbols != null) {
      $result.stockSymbols.addAll(stockSymbols);
    }
    if (cryptoSymbols != null) {
      $result.cryptoSymbols.addAll(cryptoSymbols);
    }
    return $result;
  }
  GetMarketPricesRequest._() : super();
  factory GetMarketPricesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMarketPricesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetMarketPricesRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'stockSymbols')
    ..pPS(2, _omitFieldNames ? '' : 'cryptoSymbols')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMarketPricesRequest clone() => GetMarketPricesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMarketPricesRequest copyWith(void Function(GetMarketPricesRequest) updates) => super.copyWith((message) => updates(message as GetMarketPricesRequest)) as GetMarketPricesRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMarketPricesRequest create() => GetMarketPricesRequest._();
  GetMarketPricesRequest createEmptyInstance() => create();
  static $pb.PbList<GetMarketPricesRequest> createRepeated() => $pb.PbList<GetMarketPricesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMarketPricesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMarketPricesRequest>(create);
  static GetMarketPricesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.String> get stockSymbols => $_getList(0);

  @$pb.TagNumber(2)
  $core.List<$core.String> get cryptoSymbols => $_getList(1);
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
    final $result = create();
    if (symbol != null) {
      $result.symbol = symbol;
    }
    if (name != null) {
      $result.name = name;
    }
    if (price != null) {
      $result.price = price;
    }
    if (change24h != null) {
      $result.change24h = change24h;
    }
    if (changePercentage != null) {
      $result.changePercentage = changePercentage;
    }
    if (timestamp != null) {
      $result.timestamp = timestamp;
    }
    return $result;
  }
  MarketPrice._() : super();
  factory MarketPrice.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MarketPrice.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MarketPrice', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'symbol')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'price', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'change24h', $pb.PbFieldType.OD, protoName: 'change_24h')
    ..a<$core.double>(5, _omitFieldNames ? '' : 'changePercentage', $pb.PbFieldType.OD)
    ..aOS(6, _omitFieldNames ? '' : 'timestamp')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MarketPrice clone() => MarketPrice()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MarketPrice copyWith(void Function(MarketPrice) updates) => super.copyWith((message) => updates(message as MarketPrice)) as MarketPrice;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MarketPrice create() => MarketPrice._();
  MarketPrice createEmptyInstance() => create();
  static $pb.PbList<MarketPrice> createRepeated() => $pb.PbList<MarketPrice>();
  @$core.pragma('dart2js:noInline')
  static MarketPrice getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MarketPrice>(create);
  static MarketPrice? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get symbol => $_getSZ(0);
  @$pb.TagNumber(1)
  set symbol($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSymbol() => $_has(0);
  @$pb.TagNumber(1)
  void clearSymbol() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get price => $_getN(2);
  @$pb.TagNumber(3)
  set price($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPrice() => $_has(2);
  @$pb.TagNumber(3)
  void clearPrice() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get change24h => $_getN(3);
  @$pb.TagNumber(4)
  set change24h($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasChange24h() => $_has(3);
  @$pb.TagNumber(4)
  void clearChange24h() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get changePercentage => $_getN(4);
  @$pb.TagNumber(5)
  set changePercentage($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasChangePercentage() => $_has(4);
  @$pb.TagNumber(5)
  void clearChangePercentage() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get timestamp => $_getSZ(5);
  @$pb.TagNumber(6)
  set timestamp($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasTimestamp() => $_has(5);
  @$pb.TagNumber(6)
  void clearTimestamp() => clearField(6);
}

class GetMarketPricesResponse extends $pb.GeneratedMessage {
  factory GetMarketPricesResponse({
    $core.Iterable<MarketPrice>? stockPrices,
    $core.Iterable<MarketPrice>? cryptoPrices,
    $core.String? timestamp,
  }) {
    final $result = create();
    if (stockPrices != null) {
      $result.stockPrices.addAll(stockPrices);
    }
    if (cryptoPrices != null) {
      $result.cryptoPrices.addAll(cryptoPrices);
    }
    if (timestamp != null) {
      $result.timestamp = timestamp;
    }
    return $result;
  }
  GetMarketPricesResponse._() : super();
  factory GetMarketPricesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMarketPricesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetMarketPricesResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..pc<MarketPrice>(1, _omitFieldNames ? '' : 'stockPrices', $pb.PbFieldType.PM, subBuilder: MarketPrice.create)
    ..pc<MarketPrice>(2, _omitFieldNames ? '' : 'cryptoPrices', $pb.PbFieldType.PM, subBuilder: MarketPrice.create)
    ..aOS(3, _omitFieldNames ? '' : 'timestamp')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMarketPricesResponse clone() => GetMarketPricesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMarketPricesResponse copyWith(void Function(GetMarketPricesResponse) updates) => super.copyWith((message) => updates(message as GetMarketPricesResponse)) as GetMarketPricesResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMarketPricesResponse create() => GetMarketPricesResponse._();
  GetMarketPricesResponse createEmptyInstance() => create();
  static $pb.PbList<GetMarketPricesResponse> createRepeated() => $pb.PbList<GetMarketPricesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMarketPricesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMarketPricesResponse>(create);
  static GetMarketPricesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<MarketPrice> get stockPrices => $_getList(0);

  @$pb.TagNumber(2)
  $core.List<MarketPrice> get cryptoPrices => $_getList(1);

  @$pb.TagNumber(3)
  $core.String get timestamp => $_getSZ(2);
  @$pb.TagNumber(3)
  set timestamp($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTimestamp() => $_has(2);
  @$pb.TagNumber(3)
  void clearTimestamp() => clearField(3);
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
    final $result = create();
    if (userId != null) {
      $result.userId = userId;
    }
    if (investmentType != null) {
      $result.investmentType = investmentType;
    }
    if (startDate != null) {
      $result.startDate = startDate;
    }
    if (endDate != null) {
      $result.endDate = endDate;
    }
    if (limit != null) {
      $result.limit = limit;
    }
    if (offset != null) {
      $result.offset = offset;
    }
    return $result;
  }
  GetInvestmentHistoryRequest._() : super();
  factory GetInvestmentHistoryRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInvestmentHistoryRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetInvestmentHistoryRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'investmentType')
    ..aOS(3, _omitFieldNames ? '' : 'startDate')
    ..aOS(4, _omitFieldNames ? '' : 'endDate')
    ..a<$core.int>(5, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(6, _omitFieldNames ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInvestmentHistoryRequest clone() => GetInvestmentHistoryRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInvestmentHistoryRequest copyWith(void Function(GetInvestmentHistoryRequest) updates) => super.copyWith((message) => updates(message as GetInvestmentHistoryRequest)) as GetInvestmentHistoryRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInvestmentHistoryRequest create() => GetInvestmentHistoryRequest._();
  GetInvestmentHistoryRequest createEmptyInstance() => create();
  static $pb.PbList<GetInvestmentHistoryRequest> createRepeated() => $pb.PbList<GetInvestmentHistoryRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInvestmentHistoryRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInvestmentHistoryRequest>(create);
  static GetInvestmentHistoryRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get investmentType => $_getSZ(1);
  @$pb.TagNumber(2)
  set investmentType($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasInvestmentType() => $_has(1);
  @$pb.TagNumber(2)
  void clearInvestmentType() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get startDate => $_getSZ(2);
  @$pb.TagNumber(3)
  set startDate($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasStartDate() => $_has(2);
  @$pb.TagNumber(3)
  void clearStartDate() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get endDate => $_getSZ(3);
  @$pb.TagNumber(4)
  set endDate($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasEndDate() => $_has(3);
  @$pb.TagNumber(4)
  void clearEndDate() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get limit => $_getIZ(4);
  @$pb.TagNumber(5)
  set limit($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasLimit() => $_has(4);
  @$pb.TagNumber(5)
  void clearLimit() => clearField(5);

  @$pb.TagNumber(6)
  $core.int get offset => $_getIZ(5);
  @$pb.TagNumber(6)
  set offset($core.int v) { $_setSignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasOffset() => $_has(5);
  @$pb.TagNumber(6)
  void clearOffset() => clearField(6);
}

class GetInvestmentHistoryResponse extends $pb.GeneratedMessage {
  factory GetInvestmentHistoryResponse({
    $core.Iterable<Investment>? investments,
    $core.int? total,
  }) {
    final $result = create();
    if (investments != null) {
      $result.investments.addAll(investments);
    }
    if (total != null) {
      $result.total = total;
    }
    return $result;
  }
  GetInvestmentHistoryResponse._() : super();
  factory GetInvestmentHistoryResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInvestmentHistoryResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetInvestmentHistoryResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..pc<Investment>(1, _omitFieldNames ? '' : 'investments', $pb.PbFieldType.PM, subBuilder: Investment.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInvestmentHistoryResponse clone() => GetInvestmentHistoryResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInvestmentHistoryResponse copyWith(void Function(GetInvestmentHistoryResponse) updates) => super.copyWith((message) => updates(message as GetInvestmentHistoryResponse)) as GetInvestmentHistoryResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInvestmentHistoryResponse create() => GetInvestmentHistoryResponse._();
  GetInvestmentHistoryResponse createEmptyInstance() => create();
  static $pb.PbList<GetInvestmentHistoryResponse> createRepeated() => $pb.PbList<GetInvestmentHistoryResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInvestmentHistoryResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInvestmentHistoryResponse>(create);
  static GetInvestmentHistoryResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Investment> get investments => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => clearField(2);
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
    final $result = create();
    if (tradeId != null) {
      $result.tradeId = tradeId;
    }
    if (userId != null) {
      $result.userId = userId;
    }
    if (accountId != null) {
      $result.accountId = accountId;
    }
    if (symbol != null) {
      $result.symbol = symbol;
    }
    if (tradeType != null) {
      $result.tradeType = tradeType;
    }
    if (quantity != null) {
      $result.quantity = quantity;
    }
    if (pricePerShare != null) {
      $result.pricePerShare = pricePerShare;
    }
    if (totalValue != null) {
      $result.totalValue = totalValue;
    }
    if (fee != null) {
      $result.fee = fee;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (status != null) {
      $result.status = status;
    }
    if (orderType != null) {
      $result.orderType = orderType;
    }
    if (limitPrice != null) {
      $result.limitPrice = limitPrice;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    if (completedAt != null) {
      $result.completedAt = completedAt;
    }
    if (failureReason != null) {
      $result.failureReason = failureReason;
    }
    return $result;
  }
  Trade._() : super();
  factory Trade.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Trade.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Trade', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'tradeId')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'accountId')
    ..aOS(4, _omitFieldNames ? '' : 'symbol')
    ..aOS(5, _omitFieldNames ? '' : 'tradeType')
    ..a<$core.double>(6, _omitFieldNames ? '' : 'quantity', $pb.PbFieldType.OD)
    ..a<$core.double>(7, _omitFieldNames ? '' : 'pricePerShare', $pb.PbFieldType.OD)
    ..a<$core.double>(8, _omitFieldNames ? '' : 'totalValue', $pb.PbFieldType.OD)
    ..a<$core.double>(9, _omitFieldNames ? '' : 'fee', $pb.PbFieldType.OD)
    ..aOS(10, _omitFieldNames ? '' : 'currency')
    ..aOS(11, _omitFieldNames ? '' : 'status')
    ..aOS(12, _omitFieldNames ? '' : 'orderType')
    ..a<$core.double>(13, _omitFieldNames ? '' : 'limitPrice', $pb.PbFieldType.OD)
    ..aOS(14, _omitFieldNames ? '' : 'createdAt')
    ..aOS(15, _omitFieldNames ? '' : 'completedAt')
    ..aOS(16, _omitFieldNames ? '' : 'failureReason')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Trade clone() => Trade()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Trade copyWith(void Function(Trade) updates) => super.copyWith((message) => updates(message as Trade)) as Trade;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Trade create() => Trade._();
  Trade createEmptyInstance() => create();
  static $pb.PbList<Trade> createRepeated() => $pb.PbList<Trade>();
  @$core.pragma('dart2js:noInline')
  static Trade getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Trade>(create);
  static Trade? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get tradeId => $_getSZ(0);
  @$pb.TagNumber(1)
  set tradeId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTradeId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTradeId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get accountId => $_getSZ(2);
  @$pb.TagNumber(3)
  set accountId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAccountId() => $_has(2);
  @$pb.TagNumber(3)
  void clearAccountId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get symbol => $_getSZ(3);
  @$pb.TagNumber(4)
  set symbol($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasSymbol() => $_has(3);
  @$pb.TagNumber(4)
  void clearSymbol() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get tradeType => $_getSZ(4);
  @$pb.TagNumber(5)
  set tradeType($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTradeType() => $_has(4);
  @$pb.TagNumber(5)
  void clearTradeType() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get quantity => $_getN(5);
  @$pb.TagNumber(6)
  set quantity($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasQuantity() => $_has(5);
  @$pb.TagNumber(6)
  void clearQuantity() => clearField(6);

  @$pb.TagNumber(7)
  $core.double get pricePerShare => $_getN(6);
  @$pb.TagNumber(7)
  set pricePerShare($core.double v) { $_setDouble(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasPricePerShare() => $_has(6);
  @$pb.TagNumber(7)
  void clearPricePerShare() => clearField(7);

  @$pb.TagNumber(8)
  $core.double get totalValue => $_getN(7);
  @$pb.TagNumber(8)
  set totalValue($core.double v) { $_setDouble(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasTotalValue() => $_has(7);
  @$pb.TagNumber(8)
  void clearTotalValue() => clearField(8);

  @$pb.TagNumber(9)
  $core.double get fee => $_getN(8);
  @$pb.TagNumber(9)
  set fee($core.double v) { $_setDouble(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasFee() => $_has(8);
  @$pb.TagNumber(9)
  void clearFee() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get currency => $_getSZ(9);
  @$pb.TagNumber(10)
  set currency($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasCurrency() => $_has(9);
  @$pb.TagNumber(10)
  void clearCurrency() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get status => $_getSZ(10);
  @$pb.TagNumber(11)
  set status($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasStatus() => $_has(10);
  @$pb.TagNumber(11)
  void clearStatus() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get orderType => $_getSZ(11);
  @$pb.TagNumber(12)
  set orderType($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasOrderType() => $_has(11);
  @$pb.TagNumber(12)
  void clearOrderType() => clearField(12);

  @$pb.TagNumber(13)
  $core.double get limitPrice => $_getN(12);
  @$pb.TagNumber(13)
  set limitPrice($core.double v) { $_setDouble(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasLimitPrice() => $_has(12);
  @$pb.TagNumber(13)
  void clearLimitPrice() => clearField(13);

  @$pb.TagNumber(14)
  $core.String get createdAt => $_getSZ(13);
  @$pb.TagNumber(14)
  set createdAt($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasCreatedAt() => $_has(13);
  @$pb.TagNumber(14)
  void clearCreatedAt() => clearField(14);

  @$pb.TagNumber(15)
  $core.String get completedAt => $_getSZ(14);
  @$pb.TagNumber(15)
  set completedAt($core.String v) { $_setString(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasCompletedAt() => $_has(14);
  @$pb.TagNumber(15)
  void clearCompletedAt() => clearField(15);

  @$pb.TagNumber(16)
  $core.String get failureReason => $_getSZ(15);
  @$pb.TagNumber(16)
  set failureReason($core.String v) { $_setString(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasFailureReason() => $_has(15);
  @$pb.TagNumber(16)
  void clearFailureReason() => clearField(16);
}

class SearchStocksRequest extends $pb.GeneratedMessage {
  factory SearchStocksRequest({
    $core.String? query,
    $core.String? market,
    $core.int? limit,
  }) {
    final $result = create();
    if (query != null) {
      $result.query = query;
    }
    if (market != null) {
      $result.market = market;
    }
    if (limit != null) {
      $result.limit = limit;
    }
    return $result;
  }
  SearchStocksRequest._() : super();
  factory SearchStocksRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SearchStocksRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SearchStocksRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'query')
    ..aOS(2, _omitFieldNames ? '' : 'market')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SearchStocksRequest clone() => SearchStocksRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SearchStocksRequest copyWith(void Function(SearchStocksRequest) updates) => super.copyWith((message) => updates(message as SearchStocksRequest)) as SearchStocksRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SearchStocksRequest create() => SearchStocksRequest._();
  SearchStocksRequest createEmptyInstance() => create();
  static $pb.PbList<SearchStocksRequest> createRepeated() => $pb.PbList<SearchStocksRequest>();
  @$core.pragma('dart2js:noInline')
  static SearchStocksRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SearchStocksRequest>(create);
  static SearchStocksRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get query => $_getSZ(0);
  @$pb.TagNumber(1)
  set query($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasQuery() => $_has(0);
  @$pb.TagNumber(1)
  void clearQuery() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get market => $_getSZ(1);
  @$pb.TagNumber(2)
  set market($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMarket() => $_has(1);
  @$pb.TagNumber(2)
  void clearMarket() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get limit => $_getIZ(2);
  @$pb.TagNumber(3)
  set limit($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasLimit() => $_has(2);
  @$pb.TagNumber(3)
  void clearLimit() => clearField(3);
}

class StockSearchResult extends $pb.GeneratedMessage {
  factory StockSearchResult({
    $core.String? symbol,
    $core.String? name,
    $core.String? exchange,
    $core.bool? isTradable,
    $core.bool? isFractionable,
  }) {
    final $result = create();
    if (symbol != null) {
      $result.symbol = symbol;
    }
    if (name != null) {
      $result.name = name;
    }
    if (exchange != null) {
      $result.exchange = exchange;
    }
    if (isTradable != null) {
      $result.isTradable = isTradable;
    }
    if (isFractionable != null) {
      $result.isFractionable = isFractionable;
    }
    return $result;
  }
  StockSearchResult._() : super();
  factory StockSearchResult.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory StockSearchResult.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'StockSearchResult', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'symbol')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'exchange')
    ..aOB(4, _omitFieldNames ? '' : 'isTradable')
    ..aOB(5, _omitFieldNames ? '' : 'isFractionable')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  StockSearchResult clone() => StockSearchResult()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  StockSearchResult copyWith(void Function(StockSearchResult) updates) => super.copyWith((message) => updates(message as StockSearchResult)) as StockSearchResult;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StockSearchResult create() => StockSearchResult._();
  StockSearchResult createEmptyInstance() => create();
  static $pb.PbList<StockSearchResult> createRepeated() => $pb.PbList<StockSearchResult>();
  @$core.pragma('dart2js:noInline')
  static StockSearchResult getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StockSearchResult>(create);
  static StockSearchResult? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get symbol => $_getSZ(0);
  @$pb.TagNumber(1)
  set symbol($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSymbol() => $_has(0);
  @$pb.TagNumber(1)
  void clearSymbol() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get exchange => $_getSZ(2);
  @$pb.TagNumber(3)
  set exchange($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasExchange() => $_has(2);
  @$pb.TagNumber(3)
  void clearExchange() => clearField(3);

  @$pb.TagNumber(4)
  $core.bool get isTradable => $_getBF(3);
  @$pb.TagNumber(4)
  set isTradable($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasIsTradable() => $_has(3);
  @$pb.TagNumber(4)
  void clearIsTradable() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get isFractionable => $_getBF(4);
  @$pb.TagNumber(5)
  set isFractionable($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasIsFractionable() => $_has(4);
  @$pb.TagNumber(5)
  void clearIsFractionable() => clearField(5);
}

class SearchStocksResponse extends $pb.GeneratedMessage {
  factory SearchStocksResponse({
    $core.Iterable<StockSearchResult>? results,
    $core.int? total,
  }) {
    final $result = create();
    if (results != null) {
      $result.results.addAll(results);
    }
    if (total != null) {
      $result.total = total;
    }
    return $result;
  }
  SearchStocksResponse._() : super();
  factory SearchStocksResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SearchStocksResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SearchStocksResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..pc<StockSearchResult>(1, _omitFieldNames ? '' : 'results', $pb.PbFieldType.PM, subBuilder: StockSearchResult.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SearchStocksResponse clone() => SearchStocksResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SearchStocksResponse copyWith(void Function(SearchStocksResponse) updates) => super.copyWith((message) => updates(message as SearchStocksResponse)) as SearchStocksResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SearchStocksResponse create() => SearchStocksResponse._();
  SearchStocksResponse createEmptyInstance() => create();
  static $pb.PbList<SearchStocksResponse> createRepeated() => $pb.PbList<SearchStocksResponse>();
  @$core.pragma('dart2js:noInline')
  static SearchStocksResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SearchStocksResponse>(create);
  static SearchStocksResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<StockSearchResult> get results => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => clearField(2);
}

class GetStockDetailsRequest extends $pb.GeneratedMessage {
  factory GetStockDetailsRequest({
    $core.String? symbol,
  }) {
    final $result = create();
    if (symbol != null) {
      $result.symbol = symbol;
    }
    return $result;
  }
  GetStockDetailsRequest._() : super();
  factory GetStockDetailsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetStockDetailsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetStockDetailsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'symbol')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetStockDetailsRequest clone() => GetStockDetailsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetStockDetailsRequest copyWith(void Function(GetStockDetailsRequest) updates) => super.copyWith((message) => updates(message as GetStockDetailsRequest)) as GetStockDetailsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetStockDetailsRequest create() => GetStockDetailsRequest._();
  GetStockDetailsRequest createEmptyInstance() => create();
  static $pb.PbList<GetStockDetailsRequest> createRepeated() => $pb.PbList<GetStockDetailsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetStockDetailsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetStockDetailsRequest>(create);
  static GetStockDetailsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get symbol => $_getSZ(0);
  @$pb.TagNumber(1)
  set symbol($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSymbol() => $_has(0);
  @$pb.TagNumber(1)
  void clearSymbol() => clearField(1);
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
    final $result = create();
    if (symbol != null) {
      $result.symbol = symbol;
    }
    if (name != null) {
      $result.name = name;
    }
    if (currentPrice != null) {
      $result.currentPrice = currentPrice;
    }
    if (change != null) {
      $result.change = change;
    }
    if (changePercent != null) {
      $result.changePercent = changePercent;
    }
    if (dayHigh != null) {
      $result.dayHigh = dayHigh;
    }
    if (dayLow != null) {
      $result.dayLow = dayLow;
    }
    if (volume != null) {
      $result.volume = volume;
    }
    if (marketCap != null) {
      $result.marketCap = marketCap;
    }
    if (peRatio != null) {
      $result.peRatio = peRatio;
    }
    if (dividendYield != null) {
      $result.dividendYield = dividendYield;
    }
    if (sector != null) {
      $result.sector = sector;
    }
    if (industry != null) {
      $result.industry = industry;
    }
    if (logoUrl != null) {
      $result.logoUrl = logoUrl;
    }
    if (exchange != null) {
      $result.exchange = exchange;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (weekHigh52 != null) {
      $result.weekHigh52 = weekHigh52;
    }
    if (weekLow52 != null) {
      $result.weekLow52 = weekLow52;
    }
    if (beta != null) {
      $result.beta = beta;
    }
    if (eps != null) {
      $result.eps = eps;
    }
    if (description != null) {
      $result.description = description;
    }
    if (isTradable != null) {
      $result.isTradable = isTradable;
    }
    if (isFractionable != null) {
      $result.isFractionable = isFractionable;
    }
    return $result;
  }
  StockDetail._() : super();
  factory StockDetail.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory StockDetail.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'StockDetail', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'symbol')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'currentPrice', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'change', $pb.PbFieldType.OD)
    ..a<$core.double>(5, _omitFieldNames ? '' : 'changePercent', $pb.PbFieldType.OD)
    ..a<$core.double>(6, _omitFieldNames ? '' : 'dayHigh', $pb.PbFieldType.OD)
    ..a<$core.double>(7, _omitFieldNames ? '' : 'dayLow', $pb.PbFieldType.OD)
    ..a<$core.double>(8, _omitFieldNames ? '' : 'volume', $pb.PbFieldType.OD)
    ..a<$core.double>(9, _omitFieldNames ? '' : 'marketCap', $pb.PbFieldType.OD)
    ..a<$core.double>(10, _omitFieldNames ? '' : 'peRatio', $pb.PbFieldType.OD)
    ..a<$core.double>(11, _omitFieldNames ? '' : 'dividendYield', $pb.PbFieldType.OD)
    ..aOS(12, _omitFieldNames ? '' : 'sector')
    ..aOS(13, _omitFieldNames ? '' : 'industry')
    ..aOS(14, _omitFieldNames ? '' : 'logoUrl')
    ..aOS(15, _omitFieldNames ? '' : 'exchange')
    ..aOS(16, _omitFieldNames ? '' : 'currency')
    ..a<$core.double>(17, _omitFieldNames ? '' : 'weekHigh52', $pb.PbFieldType.OD, protoName: 'week_high_52')
    ..a<$core.double>(18, _omitFieldNames ? '' : 'weekLow52', $pb.PbFieldType.OD, protoName: 'week_low_52')
    ..a<$core.double>(19, _omitFieldNames ? '' : 'beta', $pb.PbFieldType.OD)
    ..a<$core.double>(20, _omitFieldNames ? '' : 'eps', $pb.PbFieldType.OD)
    ..aOS(21, _omitFieldNames ? '' : 'description')
    ..aOB(22, _omitFieldNames ? '' : 'isTradable')
    ..aOB(23, _omitFieldNames ? '' : 'isFractionable')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  StockDetail clone() => StockDetail()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  StockDetail copyWith(void Function(StockDetail) updates) => super.copyWith((message) => updates(message as StockDetail)) as StockDetail;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StockDetail create() => StockDetail._();
  StockDetail createEmptyInstance() => create();
  static $pb.PbList<StockDetail> createRepeated() => $pb.PbList<StockDetail>();
  @$core.pragma('dart2js:noInline')
  static StockDetail getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StockDetail>(create);
  static StockDetail? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get symbol => $_getSZ(0);
  @$pb.TagNumber(1)
  set symbol($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSymbol() => $_has(0);
  @$pb.TagNumber(1)
  void clearSymbol() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get currentPrice => $_getN(2);
  @$pb.TagNumber(3)
  set currentPrice($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCurrentPrice() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrentPrice() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get change => $_getN(3);
  @$pb.TagNumber(4)
  set change($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasChange() => $_has(3);
  @$pb.TagNumber(4)
  void clearChange() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get changePercent => $_getN(4);
  @$pb.TagNumber(5)
  set changePercent($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasChangePercent() => $_has(4);
  @$pb.TagNumber(5)
  void clearChangePercent() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get dayHigh => $_getN(5);
  @$pb.TagNumber(6)
  set dayHigh($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasDayHigh() => $_has(5);
  @$pb.TagNumber(6)
  void clearDayHigh() => clearField(6);

  @$pb.TagNumber(7)
  $core.double get dayLow => $_getN(6);
  @$pb.TagNumber(7)
  set dayLow($core.double v) { $_setDouble(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasDayLow() => $_has(6);
  @$pb.TagNumber(7)
  void clearDayLow() => clearField(7);

  @$pb.TagNumber(8)
  $core.double get volume => $_getN(7);
  @$pb.TagNumber(8)
  set volume($core.double v) { $_setDouble(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasVolume() => $_has(7);
  @$pb.TagNumber(8)
  void clearVolume() => clearField(8);

  @$pb.TagNumber(9)
  $core.double get marketCap => $_getN(8);
  @$pb.TagNumber(9)
  set marketCap($core.double v) { $_setDouble(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasMarketCap() => $_has(8);
  @$pb.TagNumber(9)
  void clearMarketCap() => clearField(9);

  @$pb.TagNumber(10)
  $core.double get peRatio => $_getN(9);
  @$pb.TagNumber(10)
  set peRatio($core.double v) { $_setDouble(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasPeRatio() => $_has(9);
  @$pb.TagNumber(10)
  void clearPeRatio() => clearField(10);

  @$pb.TagNumber(11)
  $core.double get dividendYield => $_getN(10);
  @$pb.TagNumber(11)
  set dividendYield($core.double v) { $_setDouble(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasDividendYield() => $_has(10);
  @$pb.TagNumber(11)
  void clearDividendYield() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get sector => $_getSZ(11);
  @$pb.TagNumber(12)
  set sector($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasSector() => $_has(11);
  @$pb.TagNumber(12)
  void clearSector() => clearField(12);

  @$pb.TagNumber(13)
  $core.String get industry => $_getSZ(12);
  @$pb.TagNumber(13)
  set industry($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasIndustry() => $_has(12);
  @$pb.TagNumber(13)
  void clearIndustry() => clearField(13);

  @$pb.TagNumber(14)
  $core.String get logoUrl => $_getSZ(13);
  @$pb.TagNumber(14)
  set logoUrl($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasLogoUrl() => $_has(13);
  @$pb.TagNumber(14)
  void clearLogoUrl() => clearField(14);

  @$pb.TagNumber(15)
  $core.String get exchange => $_getSZ(14);
  @$pb.TagNumber(15)
  set exchange($core.String v) { $_setString(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasExchange() => $_has(14);
  @$pb.TagNumber(15)
  void clearExchange() => clearField(15);

  @$pb.TagNumber(16)
  $core.String get currency => $_getSZ(15);
  @$pb.TagNumber(16)
  set currency($core.String v) { $_setString(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasCurrency() => $_has(15);
  @$pb.TagNumber(16)
  void clearCurrency() => clearField(16);

  @$pb.TagNumber(17)
  $core.double get weekHigh52 => $_getN(16);
  @$pb.TagNumber(17)
  set weekHigh52($core.double v) { $_setDouble(16, v); }
  @$pb.TagNumber(17)
  $core.bool hasWeekHigh52() => $_has(16);
  @$pb.TagNumber(17)
  void clearWeekHigh52() => clearField(17);

  @$pb.TagNumber(18)
  $core.double get weekLow52 => $_getN(17);
  @$pb.TagNumber(18)
  set weekLow52($core.double v) { $_setDouble(17, v); }
  @$pb.TagNumber(18)
  $core.bool hasWeekLow52() => $_has(17);
  @$pb.TagNumber(18)
  void clearWeekLow52() => clearField(18);

  @$pb.TagNumber(19)
  $core.double get beta => $_getN(18);
  @$pb.TagNumber(19)
  set beta($core.double v) { $_setDouble(18, v); }
  @$pb.TagNumber(19)
  $core.bool hasBeta() => $_has(18);
  @$pb.TagNumber(19)
  void clearBeta() => clearField(19);

  @$pb.TagNumber(20)
  $core.double get eps => $_getN(19);
  @$pb.TagNumber(20)
  set eps($core.double v) { $_setDouble(19, v); }
  @$pb.TagNumber(20)
  $core.bool hasEps() => $_has(19);
  @$pb.TagNumber(20)
  void clearEps() => clearField(20);

  @$pb.TagNumber(21)
  $core.String get description => $_getSZ(20);
  @$pb.TagNumber(21)
  set description($core.String v) { $_setString(20, v); }
  @$pb.TagNumber(21)
  $core.bool hasDescription() => $_has(20);
  @$pb.TagNumber(21)
  void clearDescription() => clearField(21);

  @$pb.TagNumber(22)
  $core.bool get isTradable => $_getBF(21);
  @$pb.TagNumber(22)
  set isTradable($core.bool v) { $_setBool(21, v); }
  @$pb.TagNumber(22)
  $core.bool hasIsTradable() => $_has(21);
  @$pb.TagNumber(22)
  void clearIsTradable() => clearField(22);

  @$pb.TagNumber(23)
  $core.bool get isFractionable => $_getBF(22);
  @$pb.TagNumber(23)
  set isFractionable($core.bool v) { $_setBool(22, v); }
  @$pb.TagNumber(23)
  $core.bool hasIsFractionable() => $_has(22);
  @$pb.TagNumber(23)
  void clearIsFractionable() => clearField(23);
}

class GetStockDetailsResponse extends $pb.GeneratedMessage {
  factory GetStockDetailsResponse({
    StockDetail? stock,
  }) {
    final $result = create();
    if (stock != null) {
      $result.stock = stock;
    }
    return $result;
  }
  GetStockDetailsResponse._() : super();
  factory GetStockDetailsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetStockDetailsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetStockDetailsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..aOM<StockDetail>(1, _omitFieldNames ? '' : 'stock', subBuilder: StockDetail.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetStockDetailsResponse clone() => GetStockDetailsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetStockDetailsResponse copyWith(void Function(GetStockDetailsResponse) updates) => super.copyWith((message) => updates(message as GetStockDetailsResponse)) as GetStockDetailsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetStockDetailsResponse create() => GetStockDetailsResponse._();
  GetStockDetailsResponse createEmptyInstance() => create();
  static $pb.PbList<GetStockDetailsResponse> createRepeated() => $pb.PbList<GetStockDetailsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetStockDetailsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetStockDetailsResponse>(create);
  static GetStockDetailsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  StockDetail get stock => $_getN(0);
  @$pb.TagNumber(1)
  set stock(StockDetail v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasStock() => $_has(0);
  @$pb.TagNumber(1)
  void clearStock() => clearField(1);
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
    final $result = create();
    if (symbol != null) {
      $result.symbol = symbol;
    }
    if (timeframe != null) {
      $result.timeframe = timeframe;
    }
    if (start != null) {
      $result.start = start;
    }
    if (end != null) {
      $result.end = end;
    }
    if (limit != null) {
      $result.limit = limit;
    }
    return $result;
  }
  GetStockPriceHistoryRequest._() : super();
  factory GetStockPriceHistoryRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetStockPriceHistoryRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetStockPriceHistoryRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'symbol')
    ..aOS(2, _omitFieldNames ? '' : 'timeframe')
    ..aOS(3, _omitFieldNames ? '' : 'start')
    ..aOS(4, _omitFieldNames ? '' : 'end')
    ..a<$core.int>(5, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetStockPriceHistoryRequest clone() => GetStockPriceHistoryRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetStockPriceHistoryRequest copyWith(void Function(GetStockPriceHistoryRequest) updates) => super.copyWith((message) => updates(message as GetStockPriceHistoryRequest)) as GetStockPriceHistoryRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetStockPriceHistoryRequest create() => GetStockPriceHistoryRequest._();
  GetStockPriceHistoryRequest createEmptyInstance() => create();
  static $pb.PbList<GetStockPriceHistoryRequest> createRepeated() => $pb.PbList<GetStockPriceHistoryRequest>();
  @$core.pragma('dart2js:noInline')
  static GetStockPriceHistoryRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetStockPriceHistoryRequest>(create);
  static GetStockPriceHistoryRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get symbol => $_getSZ(0);
  @$pb.TagNumber(1)
  set symbol($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSymbol() => $_has(0);
  @$pb.TagNumber(1)
  void clearSymbol() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get timeframe => $_getSZ(1);
  @$pb.TagNumber(2)
  set timeframe($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTimeframe() => $_has(1);
  @$pb.TagNumber(2)
  void clearTimeframe() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get start => $_getSZ(2);
  @$pb.TagNumber(3)
  set start($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasStart() => $_has(2);
  @$pb.TagNumber(3)
  void clearStart() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get end => $_getSZ(3);
  @$pb.TagNumber(4)
  set end($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasEnd() => $_has(3);
  @$pb.TagNumber(4)
  void clearEnd() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get limit => $_getIZ(4);
  @$pb.TagNumber(5)
  set limit($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasLimit() => $_has(4);
  @$pb.TagNumber(5)
  void clearLimit() => clearField(5);
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
    final $result = create();
    if (timestamp != null) {
      $result.timestamp = timestamp;
    }
    if (open != null) {
      $result.open = open;
    }
    if (high != null) {
      $result.high = high;
    }
    if (low != null) {
      $result.low = low;
    }
    if (close != null) {
      $result.close = close;
    }
    if (volume != null) {
      $result.volume = volume;
    }
    if (vwap != null) {
      $result.vwap = vwap;
    }
    return $result;
  }
  PriceBar._() : super();
  factory PriceBar.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PriceBar.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PriceBar', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'timestamp')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'open', $pb.PbFieldType.OD)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'high', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'low', $pb.PbFieldType.OD)
    ..a<$core.double>(5, _omitFieldNames ? '' : 'close', $pb.PbFieldType.OD)
    ..aInt64(6, _omitFieldNames ? '' : 'volume')
    ..a<$core.double>(7, _omitFieldNames ? '' : 'vwap', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PriceBar clone() => PriceBar()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PriceBar copyWith(void Function(PriceBar) updates) => super.copyWith((message) => updates(message as PriceBar)) as PriceBar;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PriceBar create() => PriceBar._();
  PriceBar createEmptyInstance() => create();
  static $pb.PbList<PriceBar> createRepeated() => $pb.PbList<PriceBar>();
  @$core.pragma('dart2js:noInline')
  static PriceBar getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PriceBar>(create);
  static PriceBar? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get timestamp => $_getSZ(0);
  @$pb.TagNumber(1)
  set timestamp($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTimestamp() => $_has(0);
  @$pb.TagNumber(1)
  void clearTimestamp() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get open => $_getN(1);
  @$pb.TagNumber(2)
  set open($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasOpen() => $_has(1);
  @$pb.TagNumber(2)
  void clearOpen() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get high => $_getN(2);
  @$pb.TagNumber(3)
  set high($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasHigh() => $_has(2);
  @$pb.TagNumber(3)
  void clearHigh() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get low => $_getN(3);
  @$pb.TagNumber(4)
  set low($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasLow() => $_has(3);
  @$pb.TagNumber(4)
  void clearLow() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get close => $_getN(4);
  @$pb.TagNumber(5)
  set close($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasClose() => $_has(4);
  @$pb.TagNumber(5)
  void clearClose() => clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get volume => $_getI64(5);
  @$pb.TagNumber(6)
  set volume($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasVolume() => $_has(5);
  @$pb.TagNumber(6)
  void clearVolume() => clearField(6);

  @$pb.TagNumber(7)
  $core.double get vwap => $_getN(6);
  @$pb.TagNumber(7)
  set vwap($core.double v) { $_setDouble(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasVwap() => $_has(6);
  @$pb.TagNumber(7)
  void clearVwap() => clearField(7);
}

class GetStockPriceHistoryResponse extends $pb.GeneratedMessage {
  factory GetStockPriceHistoryResponse({
    $core.Iterable<PriceBar>? bars,
    $core.String? symbol,
  }) {
    final $result = create();
    if (bars != null) {
      $result.bars.addAll(bars);
    }
    if (symbol != null) {
      $result.symbol = symbol;
    }
    return $result;
  }
  GetStockPriceHistoryResponse._() : super();
  factory GetStockPriceHistoryResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetStockPriceHistoryResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetStockPriceHistoryResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..pc<PriceBar>(1, _omitFieldNames ? '' : 'bars', $pb.PbFieldType.PM, subBuilder: PriceBar.create)
    ..aOS(2, _omitFieldNames ? '' : 'symbol')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetStockPriceHistoryResponse clone() => GetStockPriceHistoryResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetStockPriceHistoryResponse copyWith(void Function(GetStockPriceHistoryResponse) updates) => super.copyWith((message) => updates(message as GetStockPriceHistoryResponse)) as GetStockPriceHistoryResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetStockPriceHistoryResponse create() => GetStockPriceHistoryResponse._();
  GetStockPriceHistoryResponse createEmptyInstance() => create();
  static $pb.PbList<GetStockPriceHistoryResponse> createRepeated() => $pb.PbList<GetStockPriceHistoryResponse>();
  @$core.pragma('dart2js:noInline')
  static GetStockPriceHistoryResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetStockPriceHistoryResponse>(create);
  static GetStockPriceHistoryResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<PriceBar> get bars => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get symbol => $_getSZ(1);
  @$pb.TagNumber(2)
  set symbol($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSymbol() => $_has(1);
  @$pb.TagNumber(2)
  void clearSymbol() => clearField(2);
}

class GetTopMoversRequest extends $pb.GeneratedMessage {
  factory GetTopMoversRequest({
    $core.String? market,
    $core.int? limit,
  }) {
    final $result = create();
    if (market != null) {
      $result.market = market;
    }
    if (limit != null) {
      $result.limit = limit;
    }
    return $result;
  }
  GetTopMoversRequest._() : super();
  factory GetTopMoversRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTopMoversRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetTopMoversRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'market')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetTopMoversRequest clone() => GetTopMoversRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetTopMoversRequest copyWith(void Function(GetTopMoversRequest) updates) => super.copyWith((message) => updates(message as GetTopMoversRequest)) as GetTopMoversRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTopMoversRequest create() => GetTopMoversRequest._();
  GetTopMoversRequest createEmptyInstance() => create();
  static $pb.PbList<GetTopMoversRequest> createRepeated() => $pb.PbList<GetTopMoversRequest>();
  @$core.pragma('dart2js:noInline')
  static GetTopMoversRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTopMoversRequest>(create);
  static GetTopMoversRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get market => $_getSZ(0);
  @$pb.TagNumber(1)
  set market($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMarket() => $_has(0);
  @$pb.TagNumber(1)
  void clearMarket() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get limit => $_getIZ(1);
  @$pb.TagNumber(2)
  set limit($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => clearField(2);
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
    final $result = create();
    if (symbol != null) {
      $result.symbol = symbol;
    }
    if (name != null) {
      $result.name = name;
    }
    if (price != null) {
      $result.price = price;
    }
    if (change != null) {
      $result.change = change;
    }
    if (changePercent != null) {
      $result.changePercent = changePercent;
    }
    if (volume != null) {
      $result.volume = volume;
    }
    return $result;
  }
  TopMover._() : super();
  factory TopMover.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TopMover.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TopMover', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'symbol')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'price', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'change', $pb.PbFieldType.OD)
    ..a<$core.double>(5, _omitFieldNames ? '' : 'changePercent', $pb.PbFieldType.OD)
    ..a<$core.double>(6, _omitFieldNames ? '' : 'volume', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TopMover clone() => TopMover()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TopMover copyWith(void Function(TopMover) updates) => super.copyWith((message) => updates(message as TopMover)) as TopMover;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TopMover create() => TopMover._();
  TopMover createEmptyInstance() => create();
  static $pb.PbList<TopMover> createRepeated() => $pb.PbList<TopMover>();
  @$core.pragma('dart2js:noInline')
  static TopMover getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TopMover>(create);
  static TopMover? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get symbol => $_getSZ(0);
  @$pb.TagNumber(1)
  set symbol($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSymbol() => $_has(0);
  @$pb.TagNumber(1)
  void clearSymbol() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get price => $_getN(2);
  @$pb.TagNumber(3)
  set price($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPrice() => $_has(2);
  @$pb.TagNumber(3)
  void clearPrice() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get change => $_getN(3);
  @$pb.TagNumber(4)
  set change($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasChange() => $_has(3);
  @$pb.TagNumber(4)
  void clearChange() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get changePercent => $_getN(4);
  @$pb.TagNumber(5)
  set changePercent($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasChangePercent() => $_has(4);
  @$pb.TagNumber(5)
  void clearChangePercent() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get volume => $_getN(5);
  @$pb.TagNumber(6)
  set volume($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasVolume() => $_has(5);
  @$pb.TagNumber(6)
  void clearVolume() => clearField(6);
}

class GetTopMoversResponse extends $pb.GeneratedMessage {
  factory GetTopMoversResponse({
    $core.Iterable<TopMover>? gainers,
    $core.Iterable<TopMover>? losers,
  }) {
    final $result = create();
    if (gainers != null) {
      $result.gainers.addAll(gainers);
    }
    if (losers != null) {
      $result.losers.addAll(losers);
    }
    return $result;
  }
  GetTopMoversResponse._() : super();
  factory GetTopMoversResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTopMoversResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetTopMoversResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..pc<TopMover>(1, _omitFieldNames ? '' : 'gainers', $pb.PbFieldType.PM, subBuilder: TopMover.create)
    ..pc<TopMover>(2, _omitFieldNames ? '' : 'losers', $pb.PbFieldType.PM, subBuilder: TopMover.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetTopMoversResponse clone() => GetTopMoversResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetTopMoversResponse copyWith(void Function(GetTopMoversResponse) updates) => super.copyWith((message) => updates(message as GetTopMoversResponse)) as GetTopMoversResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTopMoversResponse create() => GetTopMoversResponse._();
  GetTopMoversResponse createEmptyInstance() => create();
  static $pb.PbList<GetTopMoversResponse> createRepeated() => $pb.PbList<GetTopMoversResponse>();
  @$core.pragma('dart2js:noInline')
  static GetTopMoversResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTopMoversResponse>(create);
  static GetTopMoversResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<TopMover> get gainers => $_getList(0);

  @$pb.TagNumber(2)
  $core.List<TopMover> get losers => $_getList(1);
}

class GetStockOrdersRequest extends $pb.GeneratedMessage {
  factory GetStockOrdersRequest({
    $core.String? status,
    $core.String? side,
    $core.int? limit,
  }) {
    final $result = create();
    if (status != null) {
      $result.status = status;
    }
    if (side != null) {
      $result.side = side;
    }
    if (limit != null) {
      $result.limit = limit;
    }
    return $result;
  }
  GetStockOrdersRequest._() : super();
  factory GetStockOrdersRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetStockOrdersRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetStockOrdersRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'status')
    ..aOS(2, _omitFieldNames ? '' : 'side')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetStockOrdersRequest clone() => GetStockOrdersRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetStockOrdersRequest copyWith(void Function(GetStockOrdersRequest) updates) => super.copyWith((message) => updates(message as GetStockOrdersRequest)) as GetStockOrdersRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetStockOrdersRequest create() => GetStockOrdersRequest._();
  GetStockOrdersRequest createEmptyInstance() => create();
  static $pb.PbList<GetStockOrdersRequest> createRepeated() => $pb.PbList<GetStockOrdersRequest>();
  @$core.pragma('dart2js:noInline')
  static GetStockOrdersRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetStockOrdersRequest>(create);
  static GetStockOrdersRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get status => $_getSZ(0);
  @$pb.TagNumber(1)
  set status($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get side => $_getSZ(1);
  @$pb.TagNumber(2)
  set side($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSide() => $_has(1);
  @$pb.TagNumber(2)
  void clearSide() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get limit => $_getIZ(2);
  @$pb.TagNumber(3)
  set limit($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasLimit() => $_has(2);
  @$pb.TagNumber(3)
  void clearLimit() => clearField(3);
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
    final $result = create();
    if (orderId != null) {
      $result.orderId = orderId;
    }
    if (symbol != null) {
      $result.symbol = symbol;
    }
    if (side != null) {
      $result.side = side;
    }
    if (orderType != null) {
      $result.orderType = orderType;
    }
    if (quantity != null) {
      $result.quantity = quantity;
    }
    if (filledQty != null) {
      $result.filledQty = filledQty;
    }
    if (filledAvgPrice != null) {
      $result.filledAvgPrice = filledAvgPrice;
    }
    if (limitPrice != null) {
      $result.limitPrice = limitPrice;
    }
    if (stopPrice != null) {
      $result.stopPrice = stopPrice;
    }
    if (status != null) {
      $result.status = status;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    if (filledAt != null) {
      $result.filledAt = filledAt;
    }
    if (totalValue != null) {
      $result.totalValue = totalValue;
    }
    if (fee != null) {
      $result.fee = fee;
    }
    return $result;
  }
  StockOrderInfo._() : super();
  factory StockOrderInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory StockOrderInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'StockOrderInfo', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'orderId')
    ..aOS(2, _omitFieldNames ? '' : 'symbol')
    ..aOS(3, _omitFieldNames ? '' : 'side')
    ..aOS(4, _omitFieldNames ? '' : 'orderType')
    ..a<$core.double>(5, _omitFieldNames ? '' : 'quantity', $pb.PbFieldType.OD)
    ..a<$core.double>(6, _omitFieldNames ? '' : 'filledQty', $pb.PbFieldType.OD)
    ..a<$core.double>(7, _omitFieldNames ? '' : 'filledAvgPrice', $pb.PbFieldType.OD)
    ..a<$core.double>(8, _omitFieldNames ? '' : 'limitPrice', $pb.PbFieldType.OD)
    ..a<$core.double>(9, _omitFieldNames ? '' : 'stopPrice', $pb.PbFieldType.OD)
    ..aOS(10, _omitFieldNames ? '' : 'status')
    ..aOS(11, _omitFieldNames ? '' : 'createdAt')
    ..aOS(12, _omitFieldNames ? '' : 'filledAt')
    ..a<$core.double>(13, _omitFieldNames ? '' : 'totalValue', $pb.PbFieldType.OD)
    ..a<$core.double>(14, _omitFieldNames ? '' : 'fee', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  StockOrderInfo clone() => StockOrderInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  StockOrderInfo copyWith(void Function(StockOrderInfo) updates) => super.copyWith((message) => updates(message as StockOrderInfo)) as StockOrderInfo;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StockOrderInfo create() => StockOrderInfo._();
  StockOrderInfo createEmptyInstance() => create();
  static $pb.PbList<StockOrderInfo> createRepeated() => $pb.PbList<StockOrderInfo>();
  @$core.pragma('dart2js:noInline')
  static StockOrderInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StockOrderInfo>(create);
  static StockOrderInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get orderId => $_getSZ(0);
  @$pb.TagNumber(1)
  set orderId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasOrderId() => $_has(0);
  @$pb.TagNumber(1)
  void clearOrderId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get symbol => $_getSZ(1);
  @$pb.TagNumber(2)
  set symbol($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSymbol() => $_has(1);
  @$pb.TagNumber(2)
  void clearSymbol() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get side => $_getSZ(2);
  @$pb.TagNumber(3)
  set side($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSide() => $_has(2);
  @$pb.TagNumber(3)
  void clearSide() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get orderType => $_getSZ(3);
  @$pb.TagNumber(4)
  set orderType($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasOrderType() => $_has(3);
  @$pb.TagNumber(4)
  void clearOrderType() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get quantity => $_getN(4);
  @$pb.TagNumber(5)
  set quantity($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasQuantity() => $_has(4);
  @$pb.TagNumber(5)
  void clearQuantity() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get filledQty => $_getN(5);
  @$pb.TagNumber(6)
  set filledQty($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasFilledQty() => $_has(5);
  @$pb.TagNumber(6)
  void clearFilledQty() => clearField(6);

  @$pb.TagNumber(7)
  $core.double get filledAvgPrice => $_getN(6);
  @$pb.TagNumber(7)
  set filledAvgPrice($core.double v) { $_setDouble(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasFilledAvgPrice() => $_has(6);
  @$pb.TagNumber(7)
  void clearFilledAvgPrice() => clearField(7);

  @$pb.TagNumber(8)
  $core.double get limitPrice => $_getN(7);
  @$pb.TagNumber(8)
  set limitPrice($core.double v) { $_setDouble(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasLimitPrice() => $_has(7);
  @$pb.TagNumber(8)
  void clearLimitPrice() => clearField(8);

  @$pb.TagNumber(9)
  $core.double get stopPrice => $_getN(8);
  @$pb.TagNumber(9)
  set stopPrice($core.double v) { $_setDouble(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasStopPrice() => $_has(8);
  @$pb.TagNumber(9)
  void clearStopPrice() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get status => $_getSZ(9);
  @$pb.TagNumber(10)
  set status($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasStatus() => $_has(9);
  @$pb.TagNumber(10)
  void clearStatus() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get createdAt => $_getSZ(10);
  @$pb.TagNumber(11)
  set createdAt($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasCreatedAt() => $_has(10);
  @$pb.TagNumber(11)
  void clearCreatedAt() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get filledAt => $_getSZ(11);
  @$pb.TagNumber(12)
  set filledAt($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasFilledAt() => $_has(11);
  @$pb.TagNumber(12)
  void clearFilledAt() => clearField(12);

  @$pb.TagNumber(13)
  $core.double get totalValue => $_getN(12);
  @$pb.TagNumber(13)
  set totalValue($core.double v) { $_setDouble(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasTotalValue() => $_has(12);
  @$pb.TagNumber(13)
  void clearTotalValue() => clearField(13);

  @$pb.TagNumber(14)
  $core.double get fee => $_getN(13);
  @$pb.TagNumber(14)
  set fee($core.double v) { $_setDouble(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasFee() => $_has(13);
  @$pb.TagNumber(14)
  void clearFee() => clearField(14);
}

class GetStockOrdersResponse extends $pb.GeneratedMessage {
  factory GetStockOrdersResponse({
    $core.Iterable<StockOrderInfo>? orders,
    $core.int? total,
  }) {
    final $result = create();
    if (orders != null) {
      $result.orders.addAll(orders);
    }
    if (total != null) {
      $result.total = total;
    }
    return $result;
  }
  GetStockOrdersResponse._() : super();
  factory GetStockOrdersResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetStockOrdersResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetStockOrdersResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..pc<StockOrderInfo>(1, _omitFieldNames ? '' : 'orders', $pb.PbFieldType.PM, subBuilder: StockOrderInfo.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetStockOrdersResponse clone() => GetStockOrdersResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetStockOrdersResponse copyWith(void Function(GetStockOrdersResponse) updates) => super.copyWith((message) => updates(message as GetStockOrdersResponse)) as GetStockOrdersResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetStockOrdersResponse create() => GetStockOrdersResponse._();
  GetStockOrdersResponse createEmptyInstance() => create();
  static $pb.PbList<GetStockOrdersResponse> createRepeated() => $pb.PbList<GetStockOrdersResponse>();
  @$core.pragma('dart2js:noInline')
  static GetStockOrdersResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetStockOrdersResponse>(create);
  static GetStockOrdersResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<StockOrderInfo> get orders => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => clearField(2);
}

class CancelStockOrderRequest extends $pb.GeneratedMessage {
  factory CancelStockOrderRequest({
    $core.String? orderId,
  }) {
    final $result = create();
    if (orderId != null) {
      $result.orderId = orderId;
    }
    return $result;
  }
  CancelStockOrderRequest._() : super();
  factory CancelStockOrderRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CancelStockOrderRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CancelStockOrderRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'orderId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CancelStockOrderRequest clone() => CancelStockOrderRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CancelStockOrderRequest copyWith(void Function(CancelStockOrderRequest) updates) => super.copyWith((message) => updates(message as CancelStockOrderRequest)) as CancelStockOrderRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CancelStockOrderRequest create() => CancelStockOrderRequest._();
  CancelStockOrderRequest createEmptyInstance() => create();
  static $pb.PbList<CancelStockOrderRequest> createRepeated() => $pb.PbList<CancelStockOrderRequest>();
  @$core.pragma('dart2js:noInline')
  static CancelStockOrderRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CancelStockOrderRequest>(create);
  static CancelStockOrderRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get orderId => $_getSZ(0);
  @$pb.TagNumber(1)
  set orderId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasOrderId() => $_has(0);
  @$pb.TagNumber(1)
  void clearOrderId() => clearField(1);
}

class CancelStockOrderResponse extends $pb.GeneratedMessage {
  factory CancelStockOrderResponse({
    $core.bool? success,
    $core.String? message,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  CancelStockOrderResponse._() : super();
  factory CancelStockOrderResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CancelStockOrderResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CancelStockOrderResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CancelStockOrderResponse clone() => CancelStockOrderResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CancelStockOrderResponse copyWith(void Function(CancelStockOrderResponse) updates) => super.copyWith((message) => updates(message as CancelStockOrderResponse)) as CancelStockOrderResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CancelStockOrderResponse create() => CancelStockOrderResponse._();
  CancelStockOrderResponse createEmptyInstance() => create();
  static $pb.PbList<CancelStockOrderResponse> createRepeated() => $pb.PbList<CancelStockOrderResponse>();
  @$core.pragma('dart2js:noInline')
  static CancelStockOrderResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CancelStockOrderResponse>(create);
  static CancelStockOrderResponse? _defaultInstance;

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
}

class GetMarketStatusRequest extends $pb.GeneratedMessage {
  factory GetMarketStatusRequest() => create();
  GetMarketStatusRequest._() : super();
  factory GetMarketStatusRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMarketStatusRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetMarketStatusRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMarketStatusRequest clone() => GetMarketStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMarketStatusRequest copyWith(void Function(GetMarketStatusRequest) updates) => super.copyWith((message) => updates(message as GetMarketStatusRequest)) as GetMarketStatusRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMarketStatusRequest create() => GetMarketStatusRequest._();
  GetMarketStatusRequest createEmptyInstance() => create();
  static $pb.PbList<GetMarketStatusRequest> createRepeated() => $pb.PbList<GetMarketStatusRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMarketStatusRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMarketStatusRequest>(create);
  static GetMarketStatusRequest? _defaultInstance;
}

class GetMarketStatusResponse extends $pb.GeneratedMessage {
  factory GetMarketStatusResponse({
    $core.bool? isOpen,
    $core.String? nextOpen,
    $core.String? nextClose,
    $core.String? timestamp,
  }) {
    final $result = create();
    if (isOpen != null) {
      $result.isOpen = isOpen;
    }
    if (nextOpen != null) {
      $result.nextOpen = nextOpen;
    }
    if (nextClose != null) {
      $result.nextClose = nextClose;
    }
    if (timestamp != null) {
      $result.timestamp = timestamp;
    }
    return $result;
  }
  GetMarketStatusResponse._() : super();
  factory GetMarketStatusResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMarketStatusResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetMarketStatusResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'isOpen')
    ..aOS(2, _omitFieldNames ? '' : 'nextOpen')
    ..aOS(3, _omitFieldNames ? '' : 'nextClose')
    ..aOS(4, _omitFieldNames ? '' : 'timestamp')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMarketStatusResponse clone() => GetMarketStatusResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMarketStatusResponse copyWith(void Function(GetMarketStatusResponse) updates) => super.copyWith((message) => updates(message as GetMarketStatusResponse)) as GetMarketStatusResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMarketStatusResponse create() => GetMarketStatusResponse._();
  GetMarketStatusResponse createEmptyInstance() => create();
  static $pb.PbList<GetMarketStatusResponse> createRepeated() => $pb.PbList<GetMarketStatusResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMarketStatusResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMarketStatusResponse>(create);
  static GetMarketStatusResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get isOpen => $_getBF(0);
  @$pb.TagNumber(1)
  set isOpen($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasIsOpen() => $_has(0);
  @$pb.TagNumber(1)
  void clearIsOpen() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get nextOpen => $_getSZ(1);
  @$pb.TagNumber(2)
  set nextOpen($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNextOpen() => $_has(1);
  @$pb.TagNumber(2)
  void clearNextOpen() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get nextClose => $_getSZ(2);
  @$pb.TagNumber(3)
  set nextClose($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasNextClose() => $_has(2);
  @$pb.TagNumber(3)
  void clearNextClose() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get timestamp => $_getSZ(3);
  @$pb.TagNumber(4)
  set timestamp($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTimestamp() => $_has(3);
  @$pb.TagNumber(4)
  void clearTimestamp() => clearField(4);
}

class GetMarketNewsRequest extends $pb.GeneratedMessage {
  factory GetMarketNewsRequest({
    $core.Iterable<$core.String>? symbols,
    $core.String? category,
    $core.int? limit,
    $core.int? page,
  }) {
    final $result = create();
    if (symbols != null) {
      $result.symbols.addAll(symbols);
    }
    if (category != null) {
      $result.category = category;
    }
    if (limit != null) {
      $result.limit = limit;
    }
    if (page != null) {
      $result.page = page;
    }
    return $result;
  }
  GetMarketNewsRequest._() : super();
  factory GetMarketNewsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMarketNewsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetMarketNewsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'symbols')
    ..aOS(2, _omitFieldNames ? '' : 'category')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMarketNewsRequest clone() => GetMarketNewsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMarketNewsRequest copyWith(void Function(GetMarketNewsRequest) updates) => super.copyWith((message) => updates(message as GetMarketNewsRequest)) as GetMarketNewsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMarketNewsRequest create() => GetMarketNewsRequest._();
  GetMarketNewsRequest createEmptyInstance() => create();
  static $pb.PbList<GetMarketNewsRequest> createRepeated() => $pb.PbList<GetMarketNewsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMarketNewsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMarketNewsRequest>(create);
  static GetMarketNewsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.String> get symbols => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get category => $_getSZ(1);
  @$pb.TagNumber(2)
  set category($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCategory() => $_has(1);
  @$pb.TagNumber(2)
  void clearCategory() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get limit => $_getIZ(2);
  @$pb.TagNumber(3)
  set limit($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasLimit() => $_has(2);
  @$pb.TagNumber(3)
  void clearLimit() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get page => $_getIZ(3);
  @$pb.TagNumber(4)
  set page($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPage() => $_has(3);
  @$pb.TagNumber(4)
  void clearPage() => clearField(4);
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
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (title != null) {
      $result.title = title;
    }
    if (summary != null) {
      $result.summary = summary;
    }
    if (content != null) {
      $result.content = content;
    }
    if (source != null) {
      $result.source = source;
    }
    if (imageUrl != null) {
      $result.imageUrl = imageUrl;
    }
    if (relatedSymbols != null) {
      $result.relatedSymbols.addAll(relatedSymbols);
    }
    if (publishedAt != null) {
      $result.publishedAt = publishedAt;
    }
    if (url != null) {
      $result.url = url;
    }
    if (category != null) {
      $result.category = category;
    }
    if (readTime != null) {
      $result.readTime = readTime;
    }
    return $result;
  }
  NewsArticle._() : super();
  factory NewsArticle.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NewsArticle.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'NewsArticle', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
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
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NewsArticle clone() => NewsArticle()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NewsArticle copyWith(void Function(NewsArticle) updates) => super.copyWith((message) => updates(message as NewsArticle)) as NewsArticle;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NewsArticle create() => NewsArticle._();
  NewsArticle createEmptyInstance() => create();
  static $pb.PbList<NewsArticle> createRepeated() => $pb.PbList<NewsArticle>();
  @$core.pragma('dart2js:noInline')
  static NewsArticle getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NewsArticle>(create);
  static NewsArticle? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get title => $_getSZ(1);
  @$pb.TagNumber(2)
  set title($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearTitle() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get summary => $_getSZ(2);
  @$pb.TagNumber(3)
  set summary($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSummary() => $_has(2);
  @$pb.TagNumber(3)
  void clearSummary() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get content => $_getSZ(3);
  @$pb.TagNumber(4)
  set content($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasContent() => $_has(3);
  @$pb.TagNumber(4)
  void clearContent() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get source => $_getSZ(4);
  @$pb.TagNumber(5)
  set source($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasSource() => $_has(4);
  @$pb.TagNumber(5)
  void clearSource() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get imageUrl => $_getSZ(5);
  @$pb.TagNumber(6)
  set imageUrl($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasImageUrl() => $_has(5);
  @$pb.TagNumber(6)
  void clearImageUrl() => clearField(6);

  @$pb.TagNumber(7)
  $core.List<$core.String> get relatedSymbols => $_getList(6);

  @$pb.TagNumber(8)
  $core.String get publishedAt => $_getSZ(7);
  @$pb.TagNumber(8)
  set publishedAt($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasPublishedAt() => $_has(7);
  @$pb.TagNumber(8)
  void clearPublishedAt() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get url => $_getSZ(8);
  @$pb.TagNumber(9)
  set url($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasUrl() => $_has(8);
  @$pb.TagNumber(9)
  void clearUrl() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get category => $_getSZ(9);
  @$pb.TagNumber(10)
  set category($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasCategory() => $_has(9);
  @$pb.TagNumber(10)
  void clearCategory() => clearField(10);

  @$pb.TagNumber(11)
  $core.int get readTime => $_getIZ(10);
  @$pb.TagNumber(11)
  set readTime($core.int v) { $_setSignedInt32(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasReadTime() => $_has(10);
  @$pb.TagNumber(11)
  void clearReadTime() => clearField(11);
}

class GetMarketNewsResponse extends $pb.GeneratedMessage {
  factory GetMarketNewsResponse({
    $core.Iterable<NewsArticle>? articles,
    $core.int? total,
  }) {
    final $result = create();
    if (articles != null) {
      $result.articles.addAll(articles);
    }
    if (total != null) {
      $result.total = total;
    }
    return $result;
  }
  GetMarketNewsResponse._() : super();
  factory GetMarketNewsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMarketNewsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetMarketNewsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..pc<NewsArticle>(1, _omitFieldNames ? '' : 'articles', $pb.PbFieldType.PM, subBuilder: NewsArticle.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMarketNewsResponse clone() => GetMarketNewsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMarketNewsResponse copyWith(void Function(GetMarketNewsResponse) updates) => super.copyWith((message) => updates(message as GetMarketNewsResponse)) as GetMarketNewsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMarketNewsResponse create() => GetMarketNewsResponse._();
  GetMarketNewsResponse createEmptyInstance() => create();
  static $pb.PbList<GetMarketNewsResponse> createRepeated() => $pb.PbList<GetMarketNewsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMarketNewsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMarketNewsResponse>(create);
  static GetMarketNewsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<NewsArticle> get articles => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => clearField(2);
}

class GetSectorPerformanceRequest extends $pb.GeneratedMessage {
  factory GetSectorPerformanceRequest() => create();
  GetSectorPerformanceRequest._() : super();
  factory GetSectorPerformanceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetSectorPerformanceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetSectorPerformanceRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetSectorPerformanceRequest clone() => GetSectorPerformanceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetSectorPerformanceRequest copyWith(void Function(GetSectorPerformanceRequest) updates) => super.copyWith((message) => updates(message as GetSectorPerformanceRequest)) as GetSectorPerformanceRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSectorPerformanceRequest create() => GetSectorPerformanceRequest._();
  GetSectorPerformanceRequest createEmptyInstance() => create();
  static $pb.PbList<GetSectorPerformanceRequest> createRepeated() => $pb.PbList<GetSectorPerformanceRequest>();
  @$core.pragma('dart2js:noInline')
  static GetSectorPerformanceRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetSectorPerformanceRequest>(create);
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
    final $result = create();
    if (sector != null) {
      $result.sector = sector;
    }
    if (change != null) {
      $result.change = change;
    }
    if (changePercent != null) {
      $result.changePercent = changePercent;
    }
    if (marketCap != null) {
      $result.marketCap = marketCap;
    }
    if (topStocks != null) {
      $result.topStocks.addAll(topStocks);
    }
    return $result;
  }
  SectorPerformanceInfo._() : super();
  factory SectorPerformanceInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SectorPerformanceInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SectorPerformanceInfo', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'sector')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'change', $pb.PbFieldType.OD)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'changePercent', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'marketCap', $pb.PbFieldType.OD)
    ..pPS(5, _omitFieldNames ? '' : 'topStocks')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SectorPerformanceInfo clone() => SectorPerformanceInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SectorPerformanceInfo copyWith(void Function(SectorPerformanceInfo) updates) => super.copyWith((message) => updates(message as SectorPerformanceInfo)) as SectorPerformanceInfo;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SectorPerformanceInfo create() => SectorPerformanceInfo._();
  SectorPerformanceInfo createEmptyInstance() => create();
  static $pb.PbList<SectorPerformanceInfo> createRepeated() => $pb.PbList<SectorPerformanceInfo>();
  @$core.pragma('dart2js:noInline')
  static SectorPerformanceInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SectorPerformanceInfo>(create);
  static SectorPerformanceInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get sector => $_getSZ(0);
  @$pb.TagNumber(1)
  set sector($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSector() => $_has(0);
  @$pb.TagNumber(1)
  void clearSector() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get change => $_getN(1);
  @$pb.TagNumber(2)
  set change($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasChange() => $_has(1);
  @$pb.TagNumber(2)
  void clearChange() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get changePercent => $_getN(2);
  @$pb.TagNumber(3)
  set changePercent($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasChangePercent() => $_has(2);
  @$pb.TagNumber(3)
  void clearChangePercent() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get marketCap => $_getN(3);
  @$pb.TagNumber(4)
  set marketCap($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMarketCap() => $_has(3);
  @$pb.TagNumber(4)
  void clearMarketCap() => clearField(4);

  @$pb.TagNumber(5)
  $core.List<$core.String> get topStocks => $_getList(4);
}

class GetSectorPerformanceResponse extends $pb.GeneratedMessage {
  factory GetSectorPerformanceResponse({
    $core.Iterable<SectorPerformanceInfo>? sectors,
  }) {
    final $result = create();
    if (sectors != null) {
      $result.sectors.addAll(sectors);
    }
    return $result;
  }
  GetSectorPerformanceResponse._() : super();
  factory GetSectorPerformanceResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetSectorPerformanceResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetSectorPerformanceResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..pc<SectorPerformanceInfo>(1, _omitFieldNames ? '' : 'sectors', $pb.PbFieldType.PM, subBuilder: SectorPerformanceInfo.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetSectorPerformanceResponse clone() => GetSectorPerformanceResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetSectorPerformanceResponse copyWith(void Function(GetSectorPerformanceResponse) updates) => super.copyWith((message) => updates(message as GetSectorPerformanceResponse)) as GetSectorPerformanceResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSectorPerformanceResponse create() => GetSectorPerformanceResponse._();
  GetSectorPerformanceResponse createEmptyInstance() => create();
  static $pb.PbList<GetSectorPerformanceResponse> createRepeated() => $pb.PbList<GetSectorPerformanceResponse>();
  @$core.pragma('dart2js:noInline')
  static GetSectorPerformanceResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetSectorPerformanceResponse>(create);
  static GetSectorPerformanceResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<SectorPerformanceInfo> get sectors => $_getList(0);
}

class GetEarningsCalendarRequest extends $pb.GeneratedMessage {
  factory GetEarningsCalendarRequest({
    $core.String? startDate,
    $core.String? endDate,
    $core.int? limit,
  }) {
    final $result = create();
    if (startDate != null) {
      $result.startDate = startDate;
    }
    if (endDate != null) {
      $result.endDate = endDate;
    }
    if (limit != null) {
      $result.limit = limit;
    }
    return $result;
  }
  GetEarningsCalendarRequest._() : super();
  factory GetEarningsCalendarRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetEarningsCalendarRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetEarningsCalendarRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'startDate')
    ..aOS(2, _omitFieldNames ? '' : 'endDate')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetEarningsCalendarRequest clone() => GetEarningsCalendarRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetEarningsCalendarRequest copyWith(void Function(GetEarningsCalendarRequest) updates) => super.copyWith((message) => updates(message as GetEarningsCalendarRequest)) as GetEarningsCalendarRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetEarningsCalendarRequest create() => GetEarningsCalendarRequest._();
  GetEarningsCalendarRequest createEmptyInstance() => create();
  static $pb.PbList<GetEarningsCalendarRequest> createRepeated() => $pb.PbList<GetEarningsCalendarRequest>();
  @$core.pragma('dart2js:noInline')
  static GetEarningsCalendarRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetEarningsCalendarRequest>(create);
  static GetEarningsCalendarRequest? _defaultInstance;

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

  @$pb.TagNumber(3)
  $core.int get limit => $_getIZ(2);
  @$pb.TagNumber(3)
  set limit($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasLimit() => $_has(2);
  @$pb.TagNumber(3)
  void clearLimit() => clearField(3);
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
    final $result = create();
    if (symbol != null) {
      $result.symbol = symbol;
    }
    if (name != null) {
      $result.name = name;
    }
    if (reportDate != null) {
      $result.reportDate = reportDate;
    }
    if (fiscalQuarter != null) {
      $result.fiscalQuarter = fiscalQuarter;
    }
    if (epsEstimate != null) {
      $result.epsEstimate = epsEstimate;
    }
    if (epsActual != null) {
      $result.epsActual = epsActual;
    }
    if (revenueEstimate != null) {
      $result.revenueEstimate = revenueEstimate;
    }
    if (revenueActual != null) {
      $result.revenueActual = revenueActual;
    }
    return $result;
  }
  EarningsEvent._() : super();
  factory EarningsEvent.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EarningsEvent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'EarningsEvent', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'symbol')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'reportDate')
    ..aOS(4, _omitFieldNames ? '' : 'fiscalQuarter')
    ..a<$core.double>(5, _omitFieldNames ? '' : 'epsEstimate', $pb.PbFieldType.OD)
    ..a<$core.double>(6, _omitFieldNames ? '' : 'epsActual', $pb.PbFieldType.OD)
    ..a<$core.double>(7, _omitFieldNames ? '' : 'revenueEstimate', $pb.PbFieldType.OD)
    ..a<$core.double>(8, _omitFieldNames ? '' : 'revenueActual', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EarningsEvent clone() => EarningsEvent()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EarningsEvent copyWith(void Function(EarningsEvent) updates) => super.copyWith((message) => updates(message as EarningsEvent)) as EarningsEvent;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EarningsEvent create() => EarningsEvent._();
  EarningsEvent createEmptyInstance() => create();
  static $pb.PbList<EarningsEvent> createRepeated() => $pb.PbList<EarningsEvent>();
  @$core.pragma('dart2js:noInline')
  static EarningsEvent getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EarningsEvent>(create);
  static EarningsEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get symbol => $_getSZ(0);
  @$pb.TagNumber(1)
  set symbol($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSymbol() => $_has(0);
  @$pb.TagNumber(1)
  void clearSymbol() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get reportDate => $_getSZ(2);
  @$pb.TagNumber(3)
  set reportDate($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasReportDate() => $_has(2);
  @$pb.TagNumber(3)
  void clearReportDate() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get fiscalQuarter => $_getSZ(3);
  @$pb.TagNumber(4)
  set fiscalQuarter($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasFiscalQuarter() => $_has(3);
  @$pb.TagNumber(4)
  void clearFiscalQuarter() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get epsEstimate => $_getN(4);
  @$pb.TagNumber(5)
  set epsEstimate($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasEpsEstimate() => $_has(4);
  @$pb.TagNumber(5)
  void clearEpsEstimate() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get epsActual => $_getN(5);
  @$pb.TagNumber(6)
  set epsActual($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasEpsActual() => $_has(5);
  @$pb.TagNumber(6)
  void clearEpsActual() => clearField(6);

  @$pb.TagNumber(7)
  $core.double get revenueEstimate => $_getN(6);
  @$pb.TagNumber(7)
  set revenueEstimate($core.double v) { $_setDouble(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasRevenueEstimate() => $_has(6);
  @$pb.TagNumber(7)
  void clearRevenueEstimate() => clearField(7);

  @$pb.TagNumber(8)
  $core.double get revenueActual => $_getN(7);
  @$pb.TagNumber(8)
  set revenueActual($core.double v) { $_setDouble(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasRevenueActual() => $_has(7);
  @$pb.TagNumber(8)
  void clearRevenueActual() => clearField(8);
}

class GetEarningsCalendarResponse extends $pb.GeneratedMessage {
  factory GetEarningsCalendarResponse({
    $core.Iterable<EarningsEvent>? events,
  }) {
    final $result = create();
    if (events != null) {
      $result.events.addAll(events);
    }
    return $result;
  }
  GetEarningsCalendarResponse._() : super();
  factory GetEarningsCalendarResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetEarningsCalendarResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetEarningsCalendarResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..pc<EarningsEvent>(1, _omitFieldNames ? '' : 'events', $pb.PbFieldType.PM, subBuilder: EarningsEvent.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetEarningsCalendarResponse clone() => GetEarningsCalendarResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetEarningsCalendarResponse copyWith(void Function(GetEarningsCalendarResponse) updates) => super.copyWith((message) => updates(message as GetEarningsCalendarResponse)) as GetEarningsCalendarResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetEarningsCalendarResponse create() => GetEarningsCalendarResponse._();
  GetEarningsCalendarResponse createEmptyInstance() => create();
  static $pb.PbList<GetEarningsCalendarResponse> createRepeated() => $pb.PbList<GetEarningsCalendarResponse>();
  @$core.pragma('dart2js:noInline')
  static GetEarningsCalendarResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetEarningsCalendarResponse>(create);
  static GetEarningsCalendarResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<EarningsEvent> get events => $_getList(0);
}

class GetDividendCalendarRequest extends $pb.GeneratedMessage {
  factory GetDividendCalendarRequest({
    $core.String? startDate,
    $core.String? endDate,
    $core.int? limit,
  }) {
    final $result = create();
    if (startDate != null) {
      $result.startDate = startDate;
    }
    if (endDate != null) {
      $result.endDate = endDate;
    }
    if (limit != null) {
      $result.limit = limit;
    }
    return $result;
  }
  GetDividendCalendarRequest._() : super();
  factory GetDividendCalendarRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetDividendCalendarRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetDividendCalendarRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'startDate')
    ..aOS(2, _omitFieldNames ? '' : 'endDate')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetDividendCalendarRequest clone() => GetDividendCalendarRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetDividendCalendarRequest copyWith(void Function(GetDividendCalendarRequest) updates) => super.copyWith((message) => updates(message as GetDividendCalendarRequest)) as GetDividendCalendarRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetDividendCalendarRequest create() => GetDividendCalendarRequest._();
  GetDividendCalendarRequest createEmptyInstance() => create();
  static $pb.PbList<GetDividendCalendarRequest> createRepeated() => $pb.PbList<GetDividendCalendarRequest>();
  @$core.pragma('dart2js:noInline')
  static GetDividendCalendarRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetDividendCalendarRequest>(create);
  static GetDividendCalendarRequest? _defaultInstance;

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

  @$pb.TagNumber(3)
  $core.int get limit => $_getIZ(2);
  @$pb.TagNumber(3)
  set limit($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasLimit() => $_has(2);
  @$pb.TagNumber(3)
  void clearLimit() => clearField(3);
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
    final $result = create();
    if (symbol != null) {
      $result.symbol = symbol;
    }
    if (name != null) {
      $result.name = name;
    }
    if (exDate != null) {
      $result.exDate = exDate;
    }
    if (paymentDate != null) {
      $result.paymentDate = paymentDate;
    }
    if (recordDate != null) {
      $result.recordDate = recordDate;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (yield != null) {
      $result.yield = yield;
    }
    return $result;
  }
  DividendEvent._() : super();
  factory DividendEvent.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DividendEvent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DividendEvent', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'symbol')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'exDate')
    ..aOS(4, _omitFieldNames ? '' : 'paymentDate')
    ..aOS(5, _omitFieldNames ? '' : 'recordDate')
    ..a<$core.double>(6, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..a<$core.double>(7, _omitFieldNames ? '' : 'yield', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DividendEvent clone() => DividendEvent()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DividendEvent copyWith(void Function(DividendEvent) updates) => super.copyWith((message) => updates(message as DividendEvent)) as DividendEvent;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DividendEvent create() => DividendEvent._();
  DividendEvent createEmptyInstance() => create();
  static $pb.PbList<DividendEvent> createRepeated() => $pb.PbList<DividendEvent>();
  @$core.pragma('dart2js:noInline')
  static DividendEvent getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DividendEvent>(create);
  static DividendEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get symbol => $_getSZ(0);
  @$pb.TagNumber(1)
  set symbol($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSymbol() => $_has(0);
  @$pb.TagNumber(1)
  void clearSymbol() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get exDate => $_getSZ(2);
  @$pb.TagNumber(3)
  set exDate($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasExDate() => $_has(2);
  @$pb.TagNumber(3)
  void clearExDate() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get paymentDate => $_getSZ(3);
  @$pb.TagNumber(4)
  set paymentDate($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPaymentDate() => $_has(3);
  @$pb.TagNumber(4)
  void clearPaymentDate() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get recordDate => $_getSZ(4);
  @$pb.TagNumber(5)
  set recordDate($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasRecordDate() => $_has(4);
  @$pb.TagNumber(5)
  void clearRecordDate() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get amount => $_getN(5);
  @$pb.TagNumber(6)
  set amount($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasAmount() => $_has(5);
  @$pb.TagNumber(6)
  void clearAmount() => clearField(6);

  @$pb.TagNumber(7)
  $core.double get yield => $_getN(6);
  @$pb.TagNumber(7)
  set yield($core.double v) { $_setDouble(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasYield() => $_has(6);
  @$pb.TagNumber(7)
  void clearYield() => clearField(7);
}

class GetDividendCalendarResponse extends $pb.GeneratedMessage {
  factory GetDividendCalendarResponse({
    $core.Iterable<DividendEvent>? events,
  }) {
    final $result = create();
    if (events != null) {
      $result.events.addAll(events);
    }
    return $result;
  }
  GetDividendCalendarResponse._() : super();
  factory GetDividendCalendarResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetDividendCalendarResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetDividendCalendarResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..pc<DividendEvent>(1, _omitFieldNames ? '' : 'events', $pb.PbFieldType.PM, subBuilder: DividendEvent.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetDividendCalendarResponse clone() => GetDividendCalendarResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetDividendCalendarResponse copyWith(void Function(GetDividendCalendarResponse) updates) => super.copyWith((message) => updates(message as GetDividendCalendarResponse)) as GetDividendCalendarResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetDividendCalendarResponse create() => GetDividendCalendarResponse._();
  GetDividendCalendarResponse createEmptyInstance() => create();
  static $pb.PbList<GetDividendCalendarResponse> createRepeated() => $pb.PbList<GetDividendCalendarResponse>();
  @$core.pragma('dart2js:noInline')
  static GetDividendCalendarResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetDividendCalendarResponse>(create);
  static GetDividendCalendarResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<DividendEvent> get events => $_getList(0);
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
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (userId != null) {
      $result.userId = userId;
    }
    if (symbol != null) {
      $result.symbol = symbol;
    }
    if (alertType != null) {
      $result.alertType = alertType;
    }
    if (targetValue != null) {
      $result.targetValue = targetValue;
    }
    if (condition != null) {
      $result.condition = condition;
    }
    if (isActive != null) {
      $result.isActive = isActive;
    }
    if (message != null) {
      $result.message = message;
    }
    if (triggeredAt != null) {
      $result.triggeredAt = triggeredAt;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      $result.updatedAt = updatedAt;
    }
    return $result;
  }
  PriceAlertInfo._() : super();
  factory PriceAlertInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PriceAlertInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PriceAlertInfo', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'symbol')
    ..aOS(4, _omitFieldNames ? '' : 'alertType')
    ..a<$core.double>(5, _omitFieldNames ? '' : 'targetValue', $pb.PbFieldType.OD)
    ..aOS(6, _omitFieldNames ? '' : 'condition')
    ..aOB(7, _omitFieldNames ? '' : 'isActive')
    ..aOS(8, _omitFieldNames ? '' : 'message')
    ..aOS(9, _omitFieldNames ? '' : 'triggeredAt')
    ..aOS(10, _omitFieldNames ? '' : 'createdAt')
    ..aOS(11, _omitFieldNames ? '' : 'updatedAt')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PriceAlertInfo clone() => PriceAlertInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PriceAlertInfo copyWith(void Function(PriceAlertInfo) updates) => super.copyWith((message) => updates(message as PriceAlertInfo)) as PriceAlertInfo;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PriceAlertInfo create() => PriceAlertInfo._();
  PriceAlertInfo createEmptyInstance() => create();
  static $pb.PbList<PriceAlertInfo> createRepeated() => $pb.PbList<PriceAlertInfo>();
  @$core.pragma('dart2js:noInline')
  static PriceAlertInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PriceAlertInfo>(create);
  static PriceAlertInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get symbol => $_getSZ(2);
  @$pb.TagNumber(3)
  set symbol($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSymbol() => $_has(2);
  @$pb.TagNumber(3)
  void clearSymbol() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get alertType => $_getSZ(3);
  @$pb.TagNumber(4)
  set alertType($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAlertType() => $_has(3);
  @$pb.TagNumber(4)
  void clearAlertType() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get targetValue => $_getN(4);
  @$pb.TagNumber(5)
  set targetValue($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTargetValue() => $_has(4);
  @$pb.TagNumber(5)
  void clearTargetValue() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get condition => $_getSZ(5);
  @$pb.TagNumber(6)
  set condition($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasCondition() => $_has(5);
  @$pb.TagNumber(6)
  void clearCondition() => clearField(6);

  @$pb.TagNumber(7)
  $core.bool get isActive => $_getBF(6);
  @$pb.TagNumber(7)
  set isActive($core.bool v) { $_setBool(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasIsActive() => $_has(6);
  @$pb.TagNumber(7)
  void clearIsActive() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get message => $_getSZ(7);
  @$pb.TagNumber(8)
  set message($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasMessage() => $_has(7);
  @$pb.TagNumber(8)
  void clearMessage() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get triggeredAt => $_getSZ(8);
  @$pb.TagNumber(9)
  set triggeredAt($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasTriggeredAt() => $_has(8);
  @$pb.TagNumber(9)
  void clearTriggeredAt() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get createdAt => $_getSZ(9);
  @$pb.TagNumber(10)
  set createdAt($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasCreatedAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearCreatedAt() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get updatedAt => $_getSZ(10);
  @$pb.TagNumber(11)
  set updatedAt($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasUpdatedAt() => $_has(10);
  @$pb.TagNumber(11)
  void clearUpdatedAt() => clearField(11);
}

class CreatePriceAlertRequest extends $pb.GeneratedMessage {
  factory CreatePriceAlertRequest({
    $core.String? symbol,
    $core.String? alertType,
    $core.double? targetValue,
    $core.String? condition,
    $core.String? message,
  }) {
    final $result = create();
    if (symbol != null) {
      $result.symbol = symbol;
    }
    if (alertType != null) {
      $result.alertType = alertType;
    }
    if (targetValue != null) {
      $result.targetValue = targetValue;
    }
    if (condition != null) {
      $result.condition = condition;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  CreatePriceAlertRequest._() : super();
  factory CreatePriceAlertRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreatePriceAlertRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreatePriceAlertRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'symbol')
    ..aOS(2, _omitFieldNames ? '' : 'alertType')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'targetValue', $pb.PbFieldType.OD)
    ..aOS(4, _omitFieldNames ? '' : 'condition')
    ..aOS(5, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreatePriceAlertRequest clone() => CreatePriceAlertRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreatePriceAlertRequest copyWith(void Function(CreatePriceAlertRequest) updates) => super.copyWith((message) => updates(message as CreatePriceAlertRequest)) as CreatePriceAlertRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreatePriceAlertRequest create() => CreatePriceAlertRequest._();
  CreatePriceAlertRequest createEmptyInstance() => create();
  static $pb.PbList<CreatePriceAlertRequest> createRepeated() => $pb.PbList<CreatePriceAlertRequest>();
  @$core.pragma('dart2js:noInline')
  static CreatePriceAlertRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreatePriceAlertRequest>(create);
  static CreatePriceAlertRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get symbol => $_getSZ(0);
  @$pb.TagNumber(1)
  set symbol($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSymbol() => $_has(0);
  @$pb.TagNumber(1)
  void clearSymbol() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get alertType => $_getSZ(1);
  @$pb.TagNumber(2)
  set alertType($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAlertType() => $_has(1);
  @$pb.TagNumber(2)
  void clearAlertType() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get targetValue => $_getN(2);
  @$pb.TagNumber(3)
  set targetValue($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTargetValue() => $_has(2);
  @$pb.TagNumber(3)
  void clearTargetValue() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get condition => $_getSZ(3);
  @$pb.TagNumber(4)
  set condition($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCondition() => $_has(3);
  @$pb.TagNumber(4)
  void clearCondition() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get message => $_getSZ(4);
  @$pb.TagNumber(5)
  set message($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasMessage() => $_has(4);
  @$pb.TagNumber(5)
  void clearMessage() => clearField(5);
}

class CreatePriceAlertResponse extends $pb.GeneratedMessage {
  factory CreatePriceAlertResponse({
    PriceAlertInfo? alert,
    $core.String? message,
  }) {
    final $result = create();
    if (alert != null) {
      $result.alert = alert;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  CreatePriceAlertResponse._() : super();
  factory CreatePriceAlertResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreatePriceAlertResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreatePriceAlertResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..aOM<PriceAlertInfo>(1, _omitFieldNames ? '' : 'alert', subBuilder: PriceAlertInfo.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreatePriceAlertResponse clone() => CreatePriceAlertResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreatePriceAlertResponse copyWith(void Function(CreatePriceAlertResponse) updates) => super.copyWith((message) => updates(message as CreatePriceAlertResponse)) as CreatePriceAlertResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreatePriceAlertResponse create() => CreatePriceAlertResponse._();
  CreatePriceAlertResponse createEmptyInstance() => create();
  static $pb.PbList<CreatePriceAlertResponse> createRepeated() => $pb.PbList<CreatePriceAlertResponse>();
  @$core.pragma('dart2js:noInline')
  static CreatePriceAlertResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreatePriceAlertResponse>(create);
  static CreatePriceAlertResponse? _defaultInstance;

  @$pb.TagNumber(1)
  PriceAlertInfo get alert => $_getN(0);
  @$pb.TagNumber(1)
  set alert(PriceAlertInfo v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasAlert() => $_has(0);
  @$pb.TagNumber(1)
  void clearAlert() => clearField(1);
  @$pb.TagNumber(1)
  PriceAlertInfo ensureAlert() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

class GetPriceAlertsRequest extends $pb.GeneratedMessage {
  factory GetPriceAlertsRequest({
    $core.String? symbol,
  }) {
    final $result = create();
    if (symbol != null) {
      $result.symbol = symbol;
    }
    return $result;
  }
  GetPriceAlertsRequest._() : super();
  factory GetPriceAlertsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPriceAlertsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetPriceAlertsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'symbol')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPriceAlertsRequest clone() => GetPriceAlertsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPriceAlertsRequest copyWith(void Function(GetPriceAlertsRequest) updates) => super.copyWith((message) => updates(message as GetPriceAlertsRequest)) as GetPriceAlertsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPriceAlertsRequest create() => GetPriceAlertsRequest._();
  GetPriceAlertsRequest createEmptyInstance() => create();
  static $pb.PbList<GetPriceAlertsRequest> createRepeated() => $pb.PbList<GetPriceAlertsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetPriceAlertsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetPriceAlertsRequest>(create);
  static GetPriceAlertsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get symbol => $_getSZ(0);
  @$pb.TagNumber(1)
  set symbol($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSymbol() => $_has(0);
  @$pb.TagNumber(1)
  void clearSymbol() => clearField(1);
}

class GetPriceAlertsResponse extends $pb.GeneratedMessage {
  factory GetPriceAlertsResponse({
    $core.Iterable<PriceAlertInfo>? alerts,
    $core.int? total,
  }) {
    final $result = create();
    if (alerts != null) {
      $result.alerts.addAll(alerts);
    }
    if (total != null) {
      $result.total = total;
    }
    return $result;
  }
  GetPriceAlertsResponse._() : super();
  factory GetPriceAlertsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPriceAlertsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetPriceAlertsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..pc<PriceAlertInfo>(1, _omitFieldNames ? '' : 'alerts', $pb.PbFieldType.PM, subBuilder: PriceAlertInfo.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPriceAlertsResponse clone() => GetPriceAlertsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPriceAlertsResponse copyWith(void Function(GetPriceAlertsResponse) updates) => super.copyWith((message) => updates(message as GetPriceAlertsResponse)) as GetPriceAlertsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPriceAlertsResponse create() => GetPriceAlertsResponse._();
  GetPriceAlertsResponse createEmptyInstance() => create();
  static $pb.PbList<GetPriceAlertsResponse> createRepeated() => $pb.PbList<GetPriceAlertsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetPriceAlertsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetPriceAlertsResponse>(create);
  static GetPriceAlertsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<PriceAlertInfo> get alerts => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => clearField(2);
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
    final $result = create();
    if (alertId != null) {
      $result.alertId = alertId;
    }
    if (alertType != null) {
      $result.alertType = alertType;
    }
    if (targetValue != null) {
      $result.targetValue = targetValue;
    }
    if (condition != null) {
      $result.condition = condition;
    }
    if (isActive != null) {
      $result.isActive = isActive;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  UpdatePriceAlertRequest._() : super();
  factory UpdatePriceAlertRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdatePriceAlertRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdatePriceAlertRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'alertId')
    ..aOS(2, _omitFieldNames ? '' : 'alertType')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'targetValue', $pb.PbFieldType.OD)
    ..aOS(4, _omitFieldNames ? '' : 'condition')
    ..aOB(5, _omitFieldNames ? '' : 'isActive')
    ..aOS(6, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdatePriceAlertRequest clone() => UpdatePriceAlertRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdatePriceAlertRequest copyWith(void Function(UpdatePriceAlertRequest) updates) => super.copyWith((message) => updates(message as UpdatePriceAlertRequest)) as UpdatePriceAlertRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdatePriceAlertRequest create() => UpdatePriceAlertRequest._();
  UpdatePriceAlertRequest createEmptyInstance() => create();
  static $pb.PbList<UpdatePriceAlertRequest> createRepeated() => $pb.PbList<UpdatePriceAlertRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdatePriceAlertRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdatePriceAlertRequest>(create);
  static UpdatePriceAlertRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get alertId => $_getSZ(0);
  @$pb.TagNumber(1)
  set alertId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAlertId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAlertId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get alertType => $_getSZ(1);
  @$pb.TagNumber(2)
  set alertType($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAlertType() => $_has(1);
  @$pb.TagNumber(2)
  void clearAlertType() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get targetValue => $_getN(2);
  @$pb.TagNumber(3)
  set targetValue($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTargetValue() => $_has(2);
  @$pb.TagNumber(3)
  void clearTargetValue() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get condition => $_getSZ(3);
  @$pb.TagNumber(4)
  set condition($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCondition() => $_has(3);
  @$pb.TagNumber(4)
  void clearCondition() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get isActive => $_getBF(4);
  @$pb.TagNumber(5)
  set isActive($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasIsActive() => $_has(4);
  @$pb.TagNumber(5)
  void clearIsActive() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get message => $_getSZ(5);
  @$pb.TagNumber(6)
  set message($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasMessage() => $_has(5);
  @$pb.TagNumber(6)
  void clearMessage() => clearField(6);
}

class UpdatePriceAlertResponse extends $pb.GeneratedMessage {
  factory UpdatePriceAlertResponse({
    PriceAlertInfo? alert,
    $core.String? message,
  }) {
    final $result = create();
    if (alert != null) {
      $result.alert = alert;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  UpdatePriceAlertResponse._() : super();
  factory UpdatePriceAlertResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdatePriceAlertResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdatePriceAlertResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..aOM<PriceAlertInfo>(1, _omitFieldNames ? '' : 'alert', subBuilder: PriceAlertInfo.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdatePriceAlertResponse clone() => UpdatePriceAlertResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdatePriceAlertResponse copyWith(void Function(UpdatePriceAlertResponse) updates) => super.copyWith((message) => updates(message as UpdatePriceAlertResponse)) as UpdatePriceAlertResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdatePriceAlertResponse create() => UpdatePriceAlertResponse._();
  UpdatePriceAlertResponse createEmptyInstance() => create();
  static $pb.PbList<UpdatePriceAlertResponse> createRepeated() => $pb.PbList<UpdatePriceAlertResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdatePriceAlertResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdatePriceAlertResponse>(create);
  static UpdatePriceAlertResponse? _defaultInstance;

  @$pb.TagNumber(1)
  PriceAlertInfo get alert => $_getN(0);
  @$pb.TagNumber(1)
  set alert(PriceAlertInfo v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasAlert() => $_has(0);
  @$pb.TagNumber(1)
  void clearAlert() => clearField(1);
  @$pb.TagNumber(1)
  PriceAlertInfo ensureAlert() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

class DeletePriceAlertRequest extends $pb.GeneratedMessage {
  factory DeletePriceAlertRequest({
    $core.String? alertId,
  }) {
    final $result = create();
    if (alertId != null) {
      $result.alertId = alertId;
    }
    return $result;
  }
  DeletePriceAlertRequest._() : super();
  factory DeletePriceAlertRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeletePriceAlertRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DeletePriceAlertRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'alertId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeletePriceAlertRequest clone() => DeletePriceAlertRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeletePriceAlertRequest copyWith(void Function(DeletePriceAlertRequest) updates) => super.copyWith((message) => updates(message as DeletePriceAlertRequest)) as DeletePriceAlertRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeletePriceAlertRequest create() => DeletePriceAlertRequest._();
  DeletePriceAlertRequest createEmptyInstance() => create();
  static $pb.PbList<DeletePriceAlertRequest> createRepeated() => $pb.PbList<DeletePriceAlertRequest>();
  @$core.pragma('dart2js:noInline')
  static DeletePriceAlertRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeletePriceAlertRequest>(create);
  static DeletePriceAlertRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get alertId => $_getSZ(0);
  @$pb.TagNumber(1)
  set alertId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAlertId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAlertId() => clearField(1);
}

class DeletePriceAlertResponse extends $pb.GeneratedMessage {
  factory DeletePriceAlertResponse({
    $core.bool? success,
    $core.String? message,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  DeletePriceAlertResponse._() : super();
  factory DeletePriceAlertResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeletePriceAlertResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DeletePriceAlertResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeletePriceAlertResponse clone() => DeletePriceAlertResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeletePriceAlertResponse copyWith(void Function(DeletePriceAlertResponse) updates) => super.copyWith((message) => updates(message as DeletePriceAlertResponse)) as DeletePriceAlertResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeletePriceAlertResponse create() => DeletePriceAlertResponse._();
  DeletePriceAlertResponse createEmptyInstance() => create();
  static $pb.PbList<DeletePriceAlertResponse> createRepeated() => $pb.PbList<DeletePriceAlertResponse>();
  @$core.pragma('dart2js:noInline')
  static DeletePriceAlertResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeletePriceAlertResponse>(create);
  static DeletePriceAlertResponse? _defaultInstance;

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
}

class EnsureBrokerAccountRequest extends $pb.GeneratedMessage {
  factory EnsureBrokerAccountRequest({
    $core.String? provider,
  }) {
    final $result = create();
    if (provider != null) {
      $result.provider = provider;
    }
    return $result;
  }
  EnsureBrokerAccountRequest._() : super();
  factory EnsureBrokerAccountRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EnsureBrokerAccountRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'EnsureBrokerAccountRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'provider')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EnsureBrokerAccountRequest clone() => EnsureBrokerAccountRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EnsureBrokerAccountRequest copyWith(void Function(EnsureBrokerAccountRequest) updates) => super.copyWith((message) => updates(message as EnsureBrokerAccountRequest)) as EnsureBrokerAccountRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EnsureBrokerAccountRequest create() => EnsureBrokerAccountRequest._();
  EnsureBrokerAccountRequest createEmptyInstance() => create();
  static $pb.PbList<EnsureBrokerAccountRequest> createRepeated() => $pb.PbList<EnsureBrokerAccountRequest>();
  @$core.pragma('dart2js:noInline')
  static EnsureBrokerAccountRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EnsureBrokerAccountRequest>(create);
  static EnsureBrokerAccountRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get provider => $_getSZ(0);
  @$pb.TagNumber(1)
  set provider($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasProvider() => $_has(0);
  @$pb.TagNumber(1)
  void clearProvider() => clearField(1);
}

class EnsureBrokerAccountResponse extends $pb.GeneratedMessage {
  factory EnsureBrokerAccountResponse({
    $core.String? provider,
    $core.String? externalAccountId,
    $core.String? status,
    $core.String? message,
  }) {
    final $result = create();
    if (provider != null) {
      $result.provider = provider;
    }
    if (externalAccountId != null) {
      $result.externalAccountId = externalAccountId;
    }
    if (status != null) {
      $result.status = status;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  EnsureBrokerAccountResponse._() : super();
  factory EnsureBrokerAccountResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EnsureBrokerAccountResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'EnsureBrokerAccountResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'provider')
    ..aOS(2, _omitFieldNames ? '' : 'externalAccountId')
    ..aOS(3, _omitFieldNames ? '' : 'status')
    ..aOS(4, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EnsureBrokerAccountResponse clone() => EnsureBrokerAccountResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EnsureBrokerAccountResponse copyWith(void Function(EnsureBrokerAccountResponse) updates) => super.copyWith((message) => updates(message as EnsureBrokerAccountResponse)) as EnsureBrokerAccountResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EnsureBrokerAccountResponse create() => EnsureBrokerAccountResponse._();
  EnsureBrokerAccountResponse createEmptyInstance() => create();
  static $pb.PbList<EnsureBrokerAccountResponse> createRepeated() => $pb.PbList<EnsureBrokerAccountResponse>();
  @$core.pragma('dart2js:noInline')
  static EnsureBrokerAccountResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EnsureBrokerAccountResponse>(create);
  static EnsureBrokerAccountResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get provider => $_getSZ(0);
  @$pb.TagNumber(1)
  set provider($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasProvider() => $_has(0);
  @$pb.TagNumber(1)
  void clearProvider() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get externalAccountId => $_getSZ(1);
  @$pb.TagNumber(2)
  set externalAccountId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasExternalAccountId() => $_has(1);
  @$pb.TagNumber(2)
  void clearExternalAccountId() => clearField(2);

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
}

class GetBrokerOnboardingStatusRequest extends $pb.GeneratedMessage {
  factory GetBrokerOnboardingStatusRequest({
    $core.String? provider,
  }) {
    final $result = create();
    if (provider != null) {
      $result.provider = provider;
    }
    return $result;
  }
  GetBrokerOnboardingStatusRequest._() : super();
  factory GetBrokerOnboardingStatusRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetBrokerOnboardingStatusRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetBrokerOnboardingStatusRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'provider')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetBrokerOnboardingStatusRequest clone() => GetBrokerOnboardingStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetBrokerOnboardingStatusRequest copyWith(void Function(GetBrokerOnboardingStatusRequest) updates) => super.copyWith((message) => updates(message as GetBrokerOnboardingStatusRequest)) as GetBrokerOnboardingStatusRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetBrokerOnboardingStatusRequest create() => GetBrokerOnboardingStatusRequest._();
  GetBrokerOnboardingStatusRequest createEmptyInstance() => create();
  static $pb.PbList<GetBrokerOnboardingStatusRequest> createRepeated() => $pb.PbList<GetBrokerOnboardingStatusRequest>();
  @$core.pragma('dart2js:noInline')
  static GetBrokerOnboardingStatusRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetBrokerOnboardingStatusRequest>(create);
  static GetBrokerOnboardingStatusRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get provider => $_getSZ(0);
  @$pb.TagNumber(1)
  set provider($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasProvider() => $_has(0);
  @$pb.TagNumber(1)
  void clearProvider() => clearField(1);
}

class GetBrokerOnboardingStatusResponse extends $pb.GeneratedMessage {
  factory GetBrokerOnboardingStatusResponse({
    $core.Iterable<BrokerAccountLink>? links,
  }) {
    final $result = create();
    if (links != null) {
      $result.links.addAll(links);
    }
    return $result;
  }
  GetBrokerOnboardingStatusResponse._() : super();
  factory GetBrokerOnboardingStatusResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetBrokerOnboardingStatusResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetBrokerOnboardingStatusResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..pc<BrokerAccountLink>(1, _omitFieldNames ? '' : 'links', $pb.PbFieldType.PM, subBuilder: BrokerAccountLink.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetBrokerOnboardingStatusResponse clone() => GetBrokerOnboardingStatusResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetBrokerOnboardingStatusResponse copyWith(void Function(GetBrokerOnboardingStatusResponse) updates) => super.copyWith((message) => updates(message as GetBrokerOnboardingStatusResponse)) as GetBrokerOnboardingStatusResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetBrokerOnboardingStatusResponse create() => GetBrokerOnboardingStatusResponse._();
  GetBrokerOnboardingStatusResponse createEmptyInstance() => create();
  static $pb.PbList<GetBrokerOnboardingStatusResponse> createRepeated() => $pb.PbList<GetBrokerOnboardingStatusResponse>();
  @$core.pragma('dart2js:noInline')
  static GetBrokerOnboardingStatusResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetBrokerOnboardingStatusResponse>(create);
  static GetBrokerOnboardingStatusResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<BrokerAccountLink> get links => $_getList(0);
}

class BrokerAccountLink extends $pb.GeneratedMessage {
  factory BrokerAccountLink({
    $core.String? provider,
    $core.String? externalAccountId,
    $core.String? status,
    $core.String? createdAt,
    $core.String? updatedAt,
  }) {
    final $result = create();
    if (provider != null) {
      $result.provider = provider;
    }
    if (externalAccountId != null) {
      $result.externalAccountId = externalAccountId;
    }
    if (status != null) {
      $result.status = status;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      $result.updatedAt = updatedAt;
    }
    return $result;
  }
  BrokerAccountLink._() : super();
  factory BrokerAccountLink.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BrokerAccountLink.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'BrokerAccountLink', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'provider')
    ..aOS(2, _omitFieldNames ? '' : 'externalAccountId')
    ..aOS(3, _omitFieldNames ? '' : 'status')
    ..aOS(4, _omitFieldNames ? '' : 'createdAt')
    ..aOS(5, _omitFieldNames ? '' : 'updatedAt')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BrokerAccountLink clone() => BrokerAccountLink()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BrokerAccountLink copyWith(void Function(BrokerAccountLink) updates) => super.copyWith((message) => updates(message as BrokerAccountLink)) as BrokerAccountLink;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BrokerAccountLink create() => BrokerAccountLink._();
  BrokerAccountLink createEmptyInstance() => create();
  static $pb.PbList<BrokerAccountLink> createRepeated() => $pb.PbList<BrokerAccountLink>();
  @$core.pragma('dart2js:noInline')
  static BrokerAccountLink getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BrokerAccountLink>(create);
  static BrokerAccountLink? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get provider => $_getSZ(0);
  @$pb.TagNumber(1)
  set provider($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasProvider() => $_has(0);
  @$pb.TagNumber(1)
  void clearProvider() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get externalAccountId => $_getSZ(1);
  @$pb.TagNumber(2)
  set externalAccountId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasExternalAccountId() => $_has(1);
  @$pb.TagNumber(2)
  void clearExternalAccountId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get status => $_getSZ(2);
  @$pb.TagNumber(3)
  set status($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatus() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get createdAt => $_getSZ(3);
  @$pb.TagNumber(4)
  set createdAt($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCreatedAt() => $_has(3);
  @$pb.TagNumber(4)
  void clearCreatedAt() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get updatedAt => $_getSZ(4);
  @$pb.TagNumber(5)
  set updatedAt($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasUpdatedAt() => $_has(4);
  @$pb.TagNumber(5)
  void clearUpdatedAt() => clearField(5);
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
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (symbol != null) {
      $result.symbol = symbol;
    }
    if (name != null) {
      $result.name = name;
    }
    if (assetType != null) {
      $result.assetType = assetType;
    }
    if (provider != null) {
      $result.provider = provider;
    }
    if (region != null) {
      $result.region = region;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (riskLevel != null) {
      $result.riskLevel = riskLevel;
    }
    if (yieldType != null) {
      $result.yieldType = yieldType;
    }
    if (expectedYield != null) {
      $result.expectedYield = expectedYield;
    }
    if (description != null) {
      $result.description = description;
    }
    if (exchange != null) {
      $result.exchange = exchange;
    }
    if (sector != null) {
      $result.sector = sector;
    }
    if (isFeatured != null) {
      $result.isFeatured = isFeatured;
    }
    return $result;
  }
  AssetInfo._() : super();
  factory AssetInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AssetInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AssetInfo', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'symbol')
    ..aOS(3, _omitFieldNames ? '' : 'name')
    ..aOS(4, _omitFieldNames ? '' : 'assetType')
    ..aOS(5, _omitFieldNames ? '' : 'provider')
    ..aOS(6, _omitFieldNames ? '' : 'region')
    ..aOS(7, _omitFieldNames ? '' : 'currency')
    ..aOS(8, _omitFieldNames ? '' : 'riskLevel')
    ..aOS(9, _omitFieldNames ? '' : 'yieldType')
    ..a<$core.double>(10, _omitFieldNames ? '' : 'expectedYield', $pb.PbFieldType.OD)
    ..aOS(11, _omitFieldNames ? '' : 'description')
    ..aOS(12, _omitFieldNames ? '' : 'exchange')
    ..aOS(13, _omitFieldNames ? '' : 'sector')
    ..aOB(14, _omitFieldNames ? '' : 'isFeatured')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AssetInfo clone() => AssetInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AssetInfo copyWith(void Function(AssetInfo) updates) => super.copyWith((message) => updates(message as AssetInfo)) as AssetInfo;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AssetInfo create() => AssetInfo._();
  AssetInfo createEmptyInstance() => create();
  static $pb.PbList<AssetInfo> createRepeated() => $pb.PbList<AssetInfo>();
  @$core.pragma('dart2js:noInline')
  static AssetInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AssetInfo>(create);
  static AssetInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get symbol => $_getSZ(1);
  @$pb.TagNumber(2)
  set symbol($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSymbol() => $_has(1);
  @$pb.TagNumber(2)
  void clearSymbol() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get assetType => $_getSZ(3);
  @$pb.TagNumber(4)
  set assetType($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAssetType() => $_has(3);
  @$pb.TagNumber(4)
  void clearAssetType() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get provider => $_getSZ(4);
  @$pb.TagNumber(5)
  set provider($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasProvider() => $_has(4);
  @$pb.TagNumber(5)
  void clearProvider() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get region => $_getSZ(5);
  @$pb.TagNumber(6)
  set region($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasRegion() => $_has(5);
  @$pb.TagNumber(6)
  void clearRegion() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get currency => $_getSZ(6);
  @$pb.TagNumber(7)
  set currency($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasCurrency() => $_has(6);
  @$pb.TagNumber(7)
  void clearCurrency() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get riskLevel => $_getSZ(7);
  @$pb.TagNumber(8)
  set riskLevel($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasRiskLevel() => $_has(7);
  @$pb.TagNumber(8)
  void clearRiskLevel() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get yieldType => $_getSZ(8);
  @$pb.TagNumber(9)
  set yieldType($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasYieldType() => $_has(8);
  @$pb.TagNumber(9)
  void clearYieldType() => clearField(9);

  @$pb.TagNumber(10)
  $core.double get expectedYield => $_getN(9);
  @$pb.TagNumber(10)
  set expectedYield($core.double v) { $_setDouble(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasExpectedYield() => $_has(9);
  @$pb.TagNumber(10)
  void clearExpectedYield() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get description => $_getSZ(10);
  @$pb.TagNumber(11)
  set description($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasDescription() => $_has(10);
  @$pb.TagNumber(11)
  void clearDescription() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get exchange => $_getSZ(11);
  @$pb.TagNumber(12)
  set exchange($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasExchange() => $_has(11);
  @$pb.TagNumber(12)
  void clearExchange() => clearField(12);

  @$pb.TagNumber(13)
  $core.String get sector => $_getSZ(12);
  @$pb.TagNumber(13)
  set sector($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasSector() => $_has(12);
  @$pb.TagNumber(13)
  void clearSector() => clearField(13);

  @$pb.TagNumber(14)
  $core.bool get isFeatured => $_getBF(13);
  @$pb.TagNumber(14)
  set isFeatured($core.bool v) { $_setBool(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasIsFeatured() => $_has(13);
  @$pb.TagNumber(14)
  void clearIsFeatured() => clearField(14);
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
    final $result = create();
    if (assetType != null) {
      $result.assetType = assetType;
    }
    if (region != null) {
      $result.region = region;
    }
    if (riskLevel != null) {
      $result.riskLevel = riskLevel;
    }
    if (provider != null) {
      $result.provider = provider;
    }
    if (yieldType != null) {
      $result.yieldType = yieldType;
    }
    if (featuredOnly != null) {
      $result.featuredOnly = featuredOnly;
    }
    if (query != null) {
      $result.query = query;
    }
    if (limit != null) {
      $result.limit = limit;
    }
    if (offset != null) {
      $result.offset = offset;
    }
    return $result;
  }
  ListAssetsRequest._() : super();
  factory ListAssetsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListAssetsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ListAssetsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'assetType')
    ..aOS(2, _omitFieldNames ? '' : 'region')
    ..aOS(3, _omitFieldNames ? '' : 'riskLevel')
    ..aOS(4, _omitFieldNames ? '' : 'provider')
    ..aOS(5, _omitFieldNames ? '' : 'yieldType')
    ..aOB(6, _omitFieldNames ? '' : 'featuredOnly')
    ..aOS(7, _omitFieldNames ? '' : 'query')
    ..a<$core.int>(8, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(9, _omitFieldNames ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListAssetsRequest clone() => ListAssetsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListAssetsRequest copyWith(void Function(ListAssetsRequest) updates) => super.copyWith((message) => updates(message as ListAssetsRequest)) as ListAssetsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListAssetsRequest create() => ListAssetsRequest._();
  ListAssetsRequest createEmptyInstance() => create();
  static $pb.PbList<ListAssetsRequest> createRepeated() => $pb.PbList<ListAssetsRequest>();
  @$core.pragma('dart2js:noInline')
  static ListAssetsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListAssetsRequest>(create);
  static ListAssetsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get assetType => $_getSZ(0);
  @$pb.TagNumber(1)
  set assetType($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAssetType() => $_has(0);
  @$pb.TagNumber(1)
  void clearAssetType() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get region => $_getSZ(1);
  @$pb.TagNumber(2)
  set region($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasRegion() => $_has(1);
  @$pb.TagNumber(2)
  void clearRegion() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get riskLevel => $_getSZ(2);
  @$pb.TagNumber(3)
  set riskLevel($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasRiskLevel() => $_has(2);
  @$pb.TagNumber(3)
  void clearRiskLevel() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get provider => $_getSZ(3);
  @$pb.TagNumber(4)
  set provider($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasProvider() => $_has(3);
  @$pb.TagNumber(4)
  void clearProvider() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get yieldType => $_getSZ(4);
  @$pb.TagNumber(5)
  set yieldType($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasYieldType() => $_has(4);
  @$pb.TagNumber(5)
  void clearYieldType() => clearField(5);

  @$pb.TagNumber(6)
  $core.bool get featuredOnly => $_getBF(5);
  @$pb.TagNumber(6)
  set featuredOnly($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasFeaturedOnly() => $_has(5);
  @$pb.TagNumber(6)
  void clearFeaturedOnly() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get query => $_getSZ(6);
  @$pb.TagNumber(7)
  set query($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasQuery() => $_has(6);
  @$pb.TagNumber(7)
  void clearQuery() => clearField(7);

  @$pb.TagNumber(8)
  $core.int get limit => $_getIZ(7);
  @$pb.TagNumber(8)
  set limit($core.int v) { $_setSignedInt32(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasLimit() => $_has(7);
  @$pb.TagNumber(8)
  void clearLimit() => clearField(8);

  @$pb.TagNumber(9)
  $core.int get offset => $_getIZ(8);
  @$pb.TagNumber(9)
  set offset($core.int v) { $_setSignedInt32(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasOffset() => $_has(8);
  @$pb.TagNumber(9)
  void clearOffset() => clearField(9);
}

class ListAssetsResponse extends $pb.GeneratedMessage {
  factory ListAssetsResponse({
    $core.Iterable<AssetInfo>? assets,
    $core.int? total,
  }) {
    final $result = create();
    if (assets != null) {
      $result.assets.addAll(assets);
    }
    if (total != null) {
      $result.total = total;
    }
    return $result;
  }
  ListAssetsResponse._() : super();
  factory ListAssetsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListAssetsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ListAssetsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..pc<AssetInfo>(1, _omitFieldNames ? '' : 'assets', $pb.PbFieldType.PM, subBuilder: AssetInfo.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListAssetsResponse clone() => ListAssetsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListAssetsResponse copyWith(void Function(ListAssetsResponse) updates) => super.copyWith((message) => updates(message as ListAssetsResponse)) as ListAssetsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListAssetsResponse create() => ListAssetsResponse._();
  ListAssetsResponse createEmptyInstance() => create();
  static $pb.PbList<ListAssetsResponse> createRepeated() => $pb.PbList<ListAssetsResponse>();
  @$core.pragma('dart2js:noInline')
  static ListAssetsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListAssetsResponse>(create);
  static ListAssetsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<AssetInfo> get assets => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => clearField(2);
}

class GetAssetDetailsRequest extends $pb.GeneratedMessage {
  factory GetAssetDetailsRequest({
    $core.String? symbol,
  }) {
    final $result = create();
    if (symbol != null) {
      $result.symbol = symbol;
    }
    return $result;
  }
  GetAssetDetailsRequest._() : super();
  factory GetAssetDetailsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAssetDetailsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetAssetDetailsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'symbol')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAssetDetailsRequest clone() => GetAssetDetailsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAssetDetailsRequest copyWith(void Function(GetAssetDetailsRequest) updates) => super.copyWith((message) => updates(message as GetAssetDetailsRequest)) as GetAssetDetailsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAssetDetailsRequest create() => GetAssetDetailsRequest._();
  GetAssetDetailsRequest createEmptyInstance() => create();
  static $pb.PbList<GetAssetDetailsRequest> createRepeated() => $pb.PbList<GetAssetDetailsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetAssetDetailsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAssetDetailsRequest>(create);
  static GetAssetDetailsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get symbol => $_getSZ(0);
  @$pb.TagNumber(1)
  set symbol($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSymbol() => $_has(0);
  @$pb.TagNumber(1)
  void clearSymbol() => clearField(1);
}

class GetAssetDetailsResponse extends $pb.GeneratedMessage {
  factory GetAssetDetailsResponse({
    AssetInfo? asset,
    $core.double? currentPrice,
    $core.double? change24h,
    $core.double? changePercentage,
  }) {
    final $result = create();
    if (asset != null) {
      $result.asset = asset;
    }
    if (currentPrice != null) {
      $result.currentPrice = currentPrice;
    }
    if (change24h != null) {
      $result.change24h = change24h;
    }
    if (changePercentage != null) {
      $result.changePercentage = changePercentage;
    }
    return $result;
  }
  GetAssetDetailsResponse._() : super();
  factory GetAssetDetailsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAssetDetailsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetAssetDetailsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..aOM<AssetInfo>(1, _omitFieldNames ? '' : 'asset', subBuilder: AssetInfo.create)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'currentPrice', $pb.PbFieldType.OD)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'change24h', $pb.PbFieldType.OD, protoName: 'change_24h')
    ..a<$core.double>(4, _omitFieldNames ? '' : 'changePercentage', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAssetDetailsResponse clone() => GetAssetDetailsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAssetDetailsResponse copyWith(void Function(GetAssetDetailsResponse) updates) => super.copyWith((message) => updates(message as GetAssetDetailsResponse)) as GetAssetDetailsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAssetDetailsResponse create() => GetAssetDetailsResponse._();
  GetAssetDetailsResponse createEmptyInstance() => create();
  static $pb.PbList<GetAssetDetailsResponse> createRepeated() => $pb.PbList<GetAssetDetailsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetAssetDetailsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAssetDetailsResponse>(create);
  static GetAssetDetailsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  AssetInfo get asset => $_getN(0);
  @$pb.TagNumber(1)
  set asset(AssetInfo v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasAsset() => $_has(0);
  @$pb.TagNumber(1)
  void clearAsset() => clearField(1);
  @$pb.TagNumber(1)
  AssetInfo ensureAsset() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.double get currentPrice => $_getN(1);
  @$pb.TagNumber(2)
  set currentPrice($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCurrentPrice() => $_has(1);
  @$pb.TagNumber(2)
  void clearCurrentPrice() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get change24h => $_getN(2);
  @$pb.TagNumber(3)
  set change24h($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasChange24h() => $_has(2);
  @$pb.TagNumber(3)
  void clearChange24h() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get changePercentage => $_getN(3);
  @$pb.TagNumber(4)
  set changePercentage($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasChangePercentage() => $_has(3);
  @$pb.TagNumber(4)
  void clearChangePercentage() => clearField(4);
}

class GetFeaturedAssetsRequest extends $pb.GeneratedMessage {
  factory GetFeaturedAssetsRequest() => create();
  GetFeaturedAssetsRequest._() : super();
  factory GetFeaturedAssetsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetFeaturedAssetsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetFeaturedAssetsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetFeaturedAssetsRequest clone() => GetFeaturedAssetsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetFeaturedAssetsRequest copyWith(void Function(GetFeaturedAssetsRequest) updates) => super.copyWith((message) => updates(message as GetFeaturedAssetsRequest)) as GetFeaturedAssetsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetFeaturedAssetsRequest create() => GetFeaturedAssetsRequest._();
  GetFeaturedAssetsRequest createEmptyInstance() => create();
  static $pb.PbList<GetFeaturedAssetsRequest> createRepeated() => $pb.PbList<GetFeaturedAssetsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetFeaturedAssetsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetFeaturedAssetsRequest>(create);
  static GetFeaturedAssetsRequest? _defaultInstance;
}

class AssetCategory extends $pb.GeneratedMessage {
  factory AssetCategory({
    $core.String? name,
    $core.String? displayName,
    $core.Iterable<AssetInfo>? assets,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (displayName != null) {
      $result.displayName = displayName;
    }
    if (assets != null) {
      $result.assets.addAll(assets);
    }
    return $result;
  }
  AssetCategory._() : super();
  factory AssetCategory.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AssetCategory.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AssetCategory', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOS(2, _omitFieldNames ? '' : 'displayName')
    ..pc<AssetInfo>(3, _omitFieldNames ? '' : 'assets', $pb.PbFieldType.PM, subBuilder: AssetInfo.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AssetCategory clone() => AssetCategory()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AssetCategory copyWith(void Function(AssetCategory) updates) => super.copyWith((message) => updates(message as AssetCategory)) as AssetCategory;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AssetCategory create() => AssetCategory._();
  AssetCategory createEmptyInstance() => create();
  static $pb.PbList<AssetCategory> createRepeated() => $pb.PbList<AssetCategory>();
  @$core.pragma('dart2js:noInline')
  static AssetCategory getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AssetCategory>(create);
  static AssetCategory? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get displayName => $_getSZ(1);
  @$pb.TagNumber(2)
  set displayName($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasDisplayName() => $_has(1);
  @$pb.TagNumber(2)
  void clearDisplayName() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<AssetInfo> get assets => $_getList(2);
}

class GetAssetCategoriesRequest extends $pb.GeneratedMessage {
  factory GetAssetCategoriesRequest() => create();
  GetAssetCategoriesRequest._() : super();
  factory GetAssetCategoriesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAssetCategoriesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetAssetCategoriesRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAssetCategoriesRequest clone() => GetAssetCategoriesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAssetCategoriesRequest copyWith(void Function(GetAssetCategoriesRequest) updates) => super.copyWith((message) => updates(message as GetAssetCategoriesRequest)) as GetAssetCategoriesRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAssetCategoriesRequest create() => GetAssetCategoriesRequest._();
  GetAssetCategoriesRequest createEmptyInstance() => create();
  static $pb.PbList<GetAssetCategoriesRequest> createRepeated() => $pb.PbList<GetAssetCategoriesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetAssetCategoriesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAssetCategoriesRequest>(create);
  static GetAssetCategoriesRequest? _defaultInstance;
}

class GetAssetCategoriesResponse extends $pb.GeneratedMessage {
  factory GetAssetCategoriesResponse({
    $core.Iterable<AssetCategory>? categories,
  }) {
    final $result = create();
    if (categories != null) {
      $result.categories.addAll(categories);
    }
    return $result;
  }
  GetAssetCategoriesResponse._() : super();
  factory GetAssetCategoriesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetAssetCategoriesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetAssetCategoriesResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..pc<AssetCategory>(1, _omitFieldNames ? '' : 'categories', $pb.PbFieldType.PM, subBuilder: AssetCategory.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetAssetCategoriesResponse clone() => GetAssetCategoriesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetAssetCategoriesResponse copyWith(void Function(GetAssetCategoriesResponse) updates) => super.copyWith((message) => updates(message as GetAssetCategoriesResponse)) as GetAssetCategoriesResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAssetCategoriesResponse create() => GetAssetCategoriesResponse._();
  GetAssetCategoriesResponse createEmptyInstance() => create();
  static $pb.PbList<GetAssetCategoriesResponse> createRepeated() => $pb.PbList<GetAssetCategoriesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetAssetCategoriesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetAssetCategoriesResponse>(create);
  static GetAssetCategoriesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<AssetCategory> get categories => $_getList(0);
}

class GetFXRateRequest extends $pb.GeneratedMessage {
  factory GetFXRateRequest({
    $core.String? fromCurrency,
    $core.String? toCurrency,
  }) {
    final $result = create();
    if (fromCurrency != null) {
      $result.fromCurrency = fromCurrency;
    }
    if (toCurrency != null) {
      $result.toCurrency = toCurrency;
    }
    return $result;
  }
  GetFXRateRequest._() : super();
  factory GetFXRateRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetFXRateRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetFXRateRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'fromCurrency')
    ..aOS(2, _omitFieldNames ? '' : 'toCurrency')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetFXRateRequest clone() => GetFXRateRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetFXRateRequest copyWith(void Function(GetFXRateRequest) updates) => super.copyWith((message) => updates(message as GetFXRateRequest)) as GetFXRateRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetFXRateRequest create() => GetFXRateRequest._();
  GetFXRateRequest createEmptyInstance() => create();
  static $pb.PbList<GetFXRateRequest> createRepeated() => $pb.PbList<GetFXRateRequest>();
  @$core.pragma('dart2js:noInline')
  static GetFXRateRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetFXRateRequest>(create);
  static GetFXRateRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fromCurrency => $_getSZ(0);
  @$pb.TagNumber(1)
  set fromCurrency($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFromCurrency() => $_has(0);
  @$pb.TagNumber(1)
  void clearFromCurrency() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get toCurrency => $_getSZ(1);
  @$pb.TagNumber(2)
  set toCurrency($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasToCurrency() => $_has(1);
  @$pb.TagNumber(2)
  void clearToCurrency() => clearField(2);
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
    final $result = create();
    if (fromCurrency != null) {
      $result.fromCurrency = fromCurrency;
    }
    if (toCurrency != null) {
      $result.toCurrency = toCurrency;
    }
    if (marketRate != null) {
      $result.marketRate = marketRate;
    }
    if (buyRate != null) {
      $result.buyRate = buyRate;
    }
    if (sellRate != null) {
      $result.sellRate = sellRate;
    }
    if (spreadBps != null) {
      $result.spreadBps = spreadBps;
    }
    if (updatedAt != null) {
      $result.updatedAt = updatedAt;
    }
    if (rateId != null) {
      $result.rateId = rateId;
    }
    return $result;
  }
  GetFXRateResponse._() : super();
  factory GetFXRateResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetFXRateResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetFXRateResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'fromCurrency')
    ..aOS(2, _omitFieldNames ? '' : 'toCurrency')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'marketRate', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'buyRate', $pb.PbFieldType.OD)
    ..a<$core.double>(5, _omitFieldNames ? '' : 'sellRate', $pb.PbFieldType.OD)
    ..a<$core.int>(6, _omitFieldNames ? '' : 'spreadBps', $pb.PbFieldType.O3)
    ..aOS(7, _omitFieldNames ? '' : 'updatedAt')
    ..aOS(8, _omitFieldNames ? '' : 'rateId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetFXRateResponse clone() => GetFXRateResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetFXRateResponse copyWith(void Function(GetFXRateResponse) updates) => super.copyWith((message) => updates(message as GetFXRateResponse)) as GetFXRateResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetFXRateResponse create() => GetFXRateResponse._();
  GetFXRateResponse createEmptyInstance() => create();
  static $pb.PbList<GetFXRateResponse> createRepeated() => $pb.PbList<GetFXRateResponse>();
  @$core.pragma('dart2js:noInline')
  static GetFXRateResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetFXRateResponse>(create);
  static GetFXRateResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fromCurrency => $_getSZ(0);
  @$pb.TagNumber(1)
  set fromCurrency($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFromCurrency() => $_has(0);
  @$pb.TagNumber(1)
  void clearFromCurrency() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get toCurrency => $_getSZ(1);
  @$pb.TagNumber(2)
  set toCurrency($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasToCurrency() => $_has(1);
  @$pb.TagNumber(2)
  void clearToCurrency() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get marketRate => $_getN(2);
  @$pb.TagNumber(3)
  set marketRate($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMarketRate() => $_has(2);
  @$pb.TagNumber(3)
  void clearMarketRate() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get buyRate => $_getN(3);
  @$pb.TagNumber(4)
  set buyRate($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasBuyRate() => $_has(3);
  @$pb.TagNumber(4)
  void clearBuyRate() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get sellRate => $_getN(4);
  @$pb.TagNumber(5)
  set sellRate($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasSellRate() => $_has(4);
  @$pb.TagNumber(5)
  void clearSellRate() => clearField(5);

  @$pb.TagNumber(6)
  $core.int get spreadBps => $_getIZ(5);
  @$pb.TagNumber(6)
  set spreadBps($core.int v) { $_setSignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasSpreadBps() => $_has(5);
  @$pb.TagNumber(6)
  void clearSpreadBps() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get updatedAt => $_getSZ(6);
  @$pb.TagNumber(7)
  set updatedAt($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasUpdatedAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearUpdatedAt() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get rateId => $_getSZ(7);
  @$pb.TagNumber(8)
  set rateId($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasRateId() => $_has(7);
  @$pb.TagNumber(8)
  void clearRateId() => clearField(8);
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
    final $result = create();
    if (fromCurrency != null) {
      $result.fromCurrency = fromCurrency;
    }
    if (toCurrency != null) {
      $result.toCurrency = toCurrency;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (direction != null) {
      $result.direction = direction;
    }
    if (purpose != null) {
      $result.purpose = purpose;
    }
    if (idempotencyKey != null) {
      $result.idempotencyKey = idempotencyKey;
    }
    return $result;
  }
  ConvertCurrencyRequest._() : super();
  factory ConvertCurrencyRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ConvertCurrencyRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ConvertCurrencyRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'fromCurrency')
    ..aOS(2, _omitFieldNames ? '' : 'toCurrency')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(4, _omitFieldNames ? '' : 'direction')
    ..aOS(5, _omitFieldNames ? '' : 'purpose')
    ..aOS(6, _omitFieldNames ? '' : 'idempotencyKey')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ConvertCurrencyRequest clone() => ConvertCurrencyRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ConvertCurrencyRequest copyWith(void Function(ConvertCurrencyRequest) updates) => super.copyWith((message) => updates(message as ConvertCurrencyRequest)) as ConvertCurrencyRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ConvertCurrencyRequest create() => ConvertCurrencyRequest._();
  ConvertCurrencyRequest createEmptyInstance() => create();
  static $pb.PbList<ConvertCurrencyRequest> createRepeated() => $pb.PbList<ConvertCurrencyRequest>();
  @$core.pragma('dart2js:noInline')
  static ConvertCurrencyRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ConvertCurrencyRequest>(create);
  static ConvertCurrencyRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fromCurrency => $_getSZ(0);
  @$pb.TagNumber(1)
  set fromCurrency($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFromCurrency() => $_has(0);
  @$pb.TagNumber(1)
  void clearFromCurrency() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get toCurrency => $_getSZ(1);
  @$pb.TagNumber(2)
  set toCurrency($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasToCurrency() => $_has(1);
  @$pb.TagNumber(2)
  void clearToCurrency() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get amount => $_getN(2);
  @$pb.TagNumber(3)
  set amount($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get direction => $_getSZ(3);
  @$pb.TagNumber(4)
  set direction($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDirection() => $_has(3);
  @$pb.TagNumber(4)
  void clearDirection() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get purpose => $_getSZ(4);
  @$pb.TagNumber(5)
  set purpose($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasPurpose() => $_has(4);
  @$pb.TagNumber(5)
  void clearPurpose() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get idempotencyKey => $_getSZ(5);
  @$pb.TagNumber(6)
  set idempotencyKey($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasIdempotencyKey() => $_has(5);
  @$pb.TagNumber(6)
  void clearIdempotencyKey() => clearField(6);
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
    final $result = create();
    if (fromCurrency != null) {
      $result.fromCurrency = fromCurrency;
    }
    if (toCurrency != null) {
      $result.toCurrency = toCurrency;
    }
    if (fromAmount != null) {
      $result.fromAmount = fromAmount;
    }
    if (toAmount != null) {
      $result.toAmount = toAmount;
    }
    if (marketRate != null) {
      $result.marketRate = marketRate;
    }
    if (appliedRate != null) {
      $result.appliedRate = appliedRate;
    }
    if (spreadProfit != null) {
      $result.spreadProfit = spreadProfit;
    }
    if (direction != null) {
      $result.direction = direction;
    }
    if (success != null) {
      $result.success = success;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  ConvertCurrencyResponse._() : super();
  factory ConvertCurrencyResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ConvertCurrencyResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ConvertCurrencyResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'fromCurrency')
    ..aOS(2, _omitFieldNames ? '' : 'toCurrency')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'fromAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'toAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(5, _omitFieldNames ? '' : 'marketRate', $pb.PbFieldType.OD)
    ..a<$core.double>(6, _omitFieldNames ? '' : 'appliedRate', $pb.PbFieldType.OD)
    ..a<$core.double>(7, _omitFieldNames ? '' : 'spreadProfit', $pb.PbFieldType.OD)
    ..aOS(8, _omitFieldNames ? '' : 'direction')
    ..aOB(9, _omitFieldNames ? '' : 'success')
    ..aOS(10, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ConvertCurrencyResponse clone() => ConvertCurrencyResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ConvertCurrencyResponse copyWith(void Function(ConvertCurrencyResponse) updates) => super.copyWith((message) => updates(message as ConvertCurrencyResponse)) as ConvertCurrencyResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ConvertCurrencyResponse create() => ConvertCurrencyResponse._();
  ConvertCurrencyResponse createEmptyInstance() => create();
  static $pb.PbList<ConvertCurrencyResponse> createRepeated() => $pb.PbList<ConvertCurrencyResponse>();
  @$core.pragma('dart2js:noInline')
  static ConvertCurrencyResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ConvertCurrencyResponse>(create);
  static ConvertCurrencyResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fromCurrency => $_getSZ(0);
  @$pb.TagNumber(1)
  set fromCurrency($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFromCurrency() => $_has(0);
  @$pb.TagNumber(1)
  void clearFromCurrency() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get toCurrency => $_getSZ(1);
  @$pb.TagNumber(2)
  set toCurrency($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasToCurrency() => $_has(1);
  @$pb.TagNumber(2)
  void clearToCurrency() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get fromAmount => $_getN(2);
  @$pb.TagNumber(3)
  set fromAmount($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasFromAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearFromAmount() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get toAmount => $_getN(3);
  @$pb.TagNumber(4)
  set toAmount($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasToAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearToAmount() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get marketRate => $_getN(4);
  @$pb.TagNumber(5)
  set marketRate($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasMarketRate() => $_has(4);
  @$pb.TagNumber(5)
  void clearMarketRate() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get appliedRate => $_getN(5);
  @$pb.TagNumber(6)
  set appliedRate($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasAppliedRate() => $_has(5);
  @$pb.TagNumber(6)
  void clearAppliedRate() => clearField(6);

  @$pb.TagNumber(7)
  $core.double get spreadProfit => $_getN(6);
  @$pb.TagNumber(7)
  set spreadProfit($core.double v) { $_setDouble(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasSpreadProfit() => $_has(6);
  @$pb.TagNumber(7)
  void clearSpreadProfit() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get direction => $_getSZ(7);
  @$pb.TagNumber(8)
  set direction($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasDirection() => $_has(7);
  @$pb.TagNumber(8)
  void clearDirection() => clearField(8);

  @$pb.TagNumber(9)
  $core.bool get success => $_getBF(8);
  @$pb.TagNumber(9)
  set success($core.bool v) { $_setBool(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasSuccess() => $_has(8);
  @$pb.TagNumber(9)
  void clearSuccess() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get message => $_getSZ(9);
  @$pb.TagNumber(10)
  set message($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasMessage() => $_has(9);
  @$pb.TagNumber(10)
  void clearMessage() => clearField(10);
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
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (fromCurrency != null) {
      $result.fromCurrency = fromCurrency;
    }
    if (toCurrency != null) {
      $result.toCurrency = toCurrency;
    }
    if (fromAmount != null) {
      $result.fromAmount = fromAmount;
    }
    if (toAmount != null) {
      $result.toAmount = toAmount;
    }
    if (marketRate != null) {
      $result.marketRate = marketRate;
    }
    if (appliedRate != null) {
      $result.appliedRate = appliedRate;
    }
    if (spreadProfit != null) {
      $result.spreadProfit = spreadProfit;
    }
    if (direction != null) {
      $result.direction = direction;
    }
    if (purpose != null) {
      $result.purpose = purpose;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    return $result;
  }
  FXTransactionInfo._() : super();
  factory FXTransactionInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FXTransactionInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FXTransactionInfo', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'fromCurrency')
    ..aOS(3, _omitFieldNames ? '' : 'toCurrency')
    ..a<$core.double>(4, _omitFieldNames ? '' : 'fromAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(5, _omitFieldNames ? '' : 'toAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(6, _omitFieldNames ? '' : 'marketRate', $pb.PbFieldType.OD)
    ..a<$core.double>(7, _omitFieldNames ? '' : 'appliedRate', $pb.PbFieldType.OD)
    ..a<$core.double>(8, _omitFieldNames ? '' : 'spreadProfit', $pb.PbFieldType.OD)
    ..aOS(9, _omitFieldNames ? '' : 'direction')
    ..aOS(10, _omitFieldNames ? '' : 'purpose')
    ..aOS(11, _omitFieldNames ? '' : 'createdAt')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FXTransactionInfo clone() => FXTransactionInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FXTransactionInfo copyWith(void Function(FXTransactionInfo) updates) => super.copyWith((message) => updates(message as FXTransactionInfo)) as FXTransactionInfo;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FXTransactionInfo create() => FXTransactionInfo._();
  FXTransactionInfo createEmptyInstance() => create();
  static $pb.PbList<FXTransactionInfo> createRepeated() => $pb.PbList<FXTransactionInfo>();
  @$core.pragma('dart2js:noInline')
  static FXTransactionInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FXTransactionInfo>(create);
  static FXTransactionInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get fromCurrency => $_getSZ(1);
  @$pb.TagNumber(2)
  set fromCurrency($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFromCurrency() => $_has(1);
  @$pb.TagNumber(2)
  void clearFromCurrency() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get toCurrency => $_getSZ(2);
  @$pb.TagNumber(3)
  set toCurrency($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasToCurrency() => $_has(2);
  @$pb.TagNumber(3)
  void clearToCurrency() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get fromAmount => $_getN(3);
  @$pb.TagNumber(4)
  set fromAmount($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasFromAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearFromAmount() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get toAmount => $_getN(4);
  @$pb.TagNumber(5)
  set toAmount($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasToAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearToAmount() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get marketRate => $_getN(5);
  @$pb.TagNumber(6)
  set marketRate($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasMarketRate() => $_has(5);
  @$pb.TagNumber(6)
  void clearMarketRate() => clearField(6);

  @$pb.TagNumber(7)
  $core.double get appliedRate => $_getN(6);
  @$pb.TagNumber(7)
  set appliedRate($core.double v) { $_setDouble(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasAppliedRate() => $_has(6);
  @$pb.TagNumber(7)
  void clearAppliedRate() => clearField(7);

  @$pb.TagNumber(8)
  $core.double get spreadProfit => $_getN(7);
  @$pb.TagNumber(8)
  set spreadProfit($core.double v) { $_setDouble(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasSpreadProfit() => $_has(7);
  @$pb.TagNumber(8)
  void clearSpreadProfit() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get direction => $_getSZ(8);
  @$pb.TagNumber(9)
  set direction($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasDirection() => $_has(8);
  @$pb.TagNumber(9)
  void clearDirection() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get purpose => $_getSZ(9);
  @$pb.TagNumber(10)
  set purpose($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasPurpose() => $_has(9);
  @$pb.TagNumber(10)
  void clearPurpose() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get createdAt => $_getSZ(10);
  @$pb.TagNumber(11)
  set createdAt($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasCreatedAt() => $_has(10);
  @$pb.TagNumber(11)
  void clearCreatedAt() => clearField(11);
}

class GetFXHistoryRequest extends $pb.GeneratedMessage {
  factory GetFXHistoryRequest({
    $core.int? limit,
    $core.int? offset,
  }) {
    final $result = create();
    if (limit != null) {
      $result.limit = limit;
    }
    if (offset != null) {
      $result.offset = offset;
    }
    return $result;
  }
  GetFXHistoryRequest._() : super();
  factory GetFXHistoryRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetFXHistoryRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetFXHistoryRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetFXHistoryRequest clone() => GetFXHistoryRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetFXHistoryRequest copyWith(void Function(GetFXHistoryRequest) updates) => super.copyWith((message) => updates(message as GetFXHistoryRequest)) as GetFXHistoryRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetFXHistoryRequest create() => GetFXHistoryRequest._();
  GetFXHistoryRequest createEmptyInstance() => create();
  static $pb.PbList<GetFXHistoryRequest> createRepeated() => $pb.PbList<GetFXHistoryRequest>();
  @$core.pragma('dart2js:noInline')
  static GetFXHistoryRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetFXHistoryRequest>(create);
  static GetFXHistoryRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get limit => $_getIZ(0);
  @$pb.TagNumber(1)
  set limit($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLimit() => $_has(0);
  @$pb.TagNumber(1)
  void clearLimit() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get offset => $_getIZ(1);
  @$pb.TagNumber(2)
  set offset($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasOffset() => $_has(1);
  @$pb.TagNumber(2)
  void clearOffset() => clearField(2);
}

class GetFXHistoryResponse extends $pb.GeneratedMessage {
  factory GetFXHistoryResponse({
    $core.Iterable<FXTransactionInfo>? transactions,
    $fixnum.Int64? total,
  }) {
    final $result = create();
    if (transactions != null) {
      $result.transactions.addAll(transactions);
    }
    if (total != null) {
      $result.total = total;
    }
    return $result;
  }
  GetFXHistoryResponse._() : super();
  factory GetFXHistoryResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetFXHistoryResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetFXHistoryResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..pc<FXTransactionInfo>(1, _omitFieldNames ? '' : 'transactions', $pb.PbFieldType.PM, subBuilder: FXTransactionInfo.create)
    ..aInt64(2, _omitFieldNames ? '' : 'total')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetFXHistoryResponse clone() => GetFXHistoryResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetFXHistoryResponse copyWith(void Function(GetFXHistoryResponse) updates) => super.copyWith((message) => updates(message as GetFXHistoryResponse)) as GetFXHistoryResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetFXHistoryResponse create() => GetFXHistoryResponse._();
  GetFXHistoryResponse createEmptyInstance() => create();
  static $pb.PbList<GetFXHistoryResponse> createRepeated() => $pb.PbList<GetFXHistoryResponse>();
  @$core.pragma('dart2js:noInline')
  static GetFXHistoryResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetFXHistoryResponse>(create);
  static GetFXHistoryResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<FXTransactionInfo> get transactions => $_getList(0);

  @$pb.TagNumber(2)
  $fixnum.Int64 get total => $_getI64(1);
  @$pb.TagNumber(2)
  set total($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => clearField(2);
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
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (assetSymbol != null) {
      $result.assetSymbol = assetSymbol;
    }
    if (assetType != null) {
      $result.assetType = assetType;
    }
    if (incomeType != null) {
      $result.incomeType = incomeType;
    }
    if (grossAmount != null) {
      $result.grossAmount = grossAmount;
    }
    if (taxWithheld != null) {
      $result.taxWithheld = taxWithheld;
    }
    if (netAmount != null) {
      $result.netAmount = netAmount;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (provider != null) {
      $result.provider = provider;
    }
    if (isReinvested != null) {
      $result.isReinvested = isReinvested;
    }
    if (payDate != null) {
      $result.payDate = payDate;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    return $result;
  }
  IncomeEventInfo._() : super();
  factory IncomeEventInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory IncomeEventInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'IncomeEventInfo', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'assetSymbol')
    ..aOS(3, _omitFieldNames ? '' : 'assetType')
    ..aOS(4, _omitFieldNames ? '' : 'incomeType')
    ..a<$core.double>(5, _omitFieldNames ? '' : 'grossAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(6, _omitFieldNames ? '' : 'taxWithheld', $pb.PbFieldType.OD)
    ..a<$core.double>(7, _omitFieldNames ? '' : 'netAmount', $pb.PbFieldType.OD)
    ..aOS(8, _omitFieldNames ? '' : 'currency')
    ..aOS(9, _omitFieldNames ? '' : 'provider')
    ..aOB(10, _omitFieldNames ? '' : 'isReinvested')
    ..aOS(11, _omitFieldNames ? '' : 'payDate')
    ..aOS(12, _omitFieldNames ? '' : 'createdAt')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  IncomeEventInfo clone() => IncomeEventInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  IncomeEventInfo copyWith(void Function(IncomeEventInfo) updates) => super.copyWith((message) => updates(message as IncomeEventInfo)) as IncomeEventInfo;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static IncomeEventInfo create() => IncomeEventInfo._();
  IncomeEventInfo createEmptyInstance() => create();
  static $pb.PbList<IncomeEventInfo> createRepeated() => $pb.PbList<IncomeEventInfo>();
  @$core.pragma('dart2js:noInline')
  static IncomeEventInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<IncomeEventInfo>(create);
  static IncomeEventInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get assetSymbol => $_getSZ(1);
  @$pb.TagNumber(2)
  set assetSymbol($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAssetSymbol() => $_has(1);
  @$pb.TagNumber(2)
  void clearAssetSymbol() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get assetType => $_getSZ(2);
  @$pb.TagNumber(3)
  set assetType($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAssetType() => $_has(2);
  @$pb.TagNumber(3)
  void clearAssetType() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get incomeType => $_getSZ(3);
  @$pb.TagNumber(4)
  set incomeType($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasIncomeType() => $_has(3);
  @$pb.TagNumber(4)
  void clearIncomeType() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get grossAmount => $_getN(4);
  @$pb.TagNumber(5)
  set grossAmount($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasGrossAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearGrossAmount() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get taxWithheld => $_getN(5);
  @$pb.TagNumber(6)
  set taxWithheld($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasTaxWithheld() => $_has(5);
  @$pb.TagNumber(6)
  void clearTaxWithheld() => clearField(6);

  @$pb.TagNumber(7)
  $core.double get netAmount => $_getN(6);
  @$pb.TagNumber(7)
  set netAmount($core.double v) { $_setDouble(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasNetAmount() => $_has(6);
  @$pb.TagNumber(7)
  void clearNetAmount() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get currency => $_getSZ(7);
  @$pb.TagNumber(8)
  set currency($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasCurrency() => $_has(7);
  @$pb.TagNumber(8)
  void clearCurrency() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get provider => $_getSZ(8);
  @$pb.TagNumber(9)
  set provider($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasProvider() => $_has(8);
  @$pb.TagNumber(9)
  void clearProvider() => clearField(9);

  @$pb.TagNumber(10)
  $core.bool get isReinvested => $_getBF(9);
  @$pb.TagNumber(10)
  set isReinvested($core.bool v) { $_setBool(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasIsReinvested() => $_has(9);
  @$pb.TagNumber(10)
  void clearIsReinvested() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get payDate => $_getSZ(10);
  @$pb.TagNumber(11)
  set payDate($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasPayDate() => $_has(10);
  @$pb.TagNumber(11)
  void clearPayDate() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get createdAt => $_getSZ(11);
  @$pb.TagNumber(12)
  set createdAt($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasCreatedAt() => $_has(11);
  @$pb.TagNumber(12)
  void clearCreatedAt() => clearField(12);
}

class GetIncomeHistoryRequest extends $pb.GeneratedMessage {
  factory GetIncomeHistoryRequest({
    $core.String? incomeType,
    $core.int? limit,
    $core.int? offset,
  }) {
    final $result = create();
    if (incomeType != null) {
      $result.incomeType = incomeType;
    }
    if (limit != null) {
      $result.limit = limit;
    }
    if (offset != null) {
      $result.offset = offset;
    }
    return $result;
  }
  GetIncomeHistoryRequest._() : super();
  factory GetIncomeHistoryRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetIncomeHistoryRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetIncomeHistoryRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'incomeType')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetIncomeHistoryRequest clone() => GetIncomeHistoryRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetIncomeHistoryRequest copyWith(void Function(GetIncomeHistoryRequest) updates) => super.copyWith((message) => updates(message as GetIncomeHistoryRequest)) as GetIncomeHistoryRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetIncomeHistoryRequest create() => GetIncomeHistoryRequest._();
  GetIncomeHistoryRequest createEmptyInstance() => create();
  static $pb.PbList<GetIncomeHistoryRequest> createRepeated() => $pb.PbList<GetIncomeHistoryRequest>();
  @$core.pragma('dart2js:noInline')
  static GetIncomeHistoryRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetIncomeHistoryRequest>(create);
  static GetIncomeHistoryRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get incomeType => $_getSZ(0);
  @$pb.TagNumber(1)
  set incomeType($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasIncomeType() => $_has(0);
  @$pb.TagNumber(1)
  void clearIncomeType() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get limit => $_getIZ(1);
  @$pb.TagNumber(2)
  set limit($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get offset => $_getIZ(2);
  @$pb.TagNumber(3)
  set offset($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasOffset() => $_has(2);
  @$pb.TagNumber(3)
  void clearOffset() => clearField(3);
}

class GetIncomeHistoryResponse extends $pb.GeneratedMessage {
  factory GetIncomeHistoryResponse({
    $core.Iterable<IncomeEventInfo>? events,
    $fixnum.Int64? total,
  }) {
    final $result = create();
    if (events != null) {
      $result.events.addAll(events);
    }
    if (total != null) {
      $result.total = total;
    }
    return $result;
  }
  GetIncomeHistoryResponse._() : super();
  factory GetIncomeHistoryResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetIncomeHistoryResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetIncomeHistoryResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..pc<IncomeEventInfo>(1, _omitFieldNames ? '' : 'events', $pb.PbFieldType.PM, subBuilder: IncomeEventInfo.create)
    ..aInt64(2, _omitFieldNames ? '' : 'total')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetIncomeHistoryResponse clone() => GetIncomeHistoryResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetIncomeHistoryResponse copyWith(void Function(GetIncomeHistoryResponse) updates) => super.copyWith((message) => updates(message as GetIncomeHistoryResponse)) as GetIncomeHistoryResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetIncomeHistoryResponse create() => GetIncomeHistoryResponse._();
  GetIncomeHistoryResponse createEmptyInstance() => create();
  static $pb.PbList<GetIncomeHistoryResponse> createRepeated() => $pb.PbList<GetIncomeHistoryResponse>();
  @$core.pragma('dart2js:noInline')
  static GetIncomeHistoryResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetIncomeHistoryResponse>(create);
  static GetIncomeHistoryResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<IncomeEventInfo> get events => $_getList(0);

  @$pb.TagNumber(2)
  $fixnum.Int64 get total => $_getI64(1);
  @$pb.TagNumber(2)
  set total($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => clearField(2);
}

class GetTotalIncomeRequest extends $pb.GeneratedMessage {
  factory GetTotalIncomeRequest() => create();
  GetTotalIncomeRequest._() : super();
  factory GetTotalIncomeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTotalIncomeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetTotalIncomeRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetTotalIncomeRequest clone() => GetTotalIncomeRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetTotalIncomeRequest copyWith(void Function(GetTotalIncomeRequest) updates) => super.copyWith((message) => updates(message as GetTotalIncomeRequest)) as GetTotalIncomeRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTotalIncomeRequest create() => GetTotalIncomeRequest._();
  GetTotalIncomeRequest createEmptyInstance() => create();
  static $pb.PbList<GetTotalIncomeRequest> createRepeated() => $pb.PbList<GetTotalIncomeRequest>();
  @$core.pragma('dart2js:noInline')
  static GetTotalIncomeRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTotalIncomeRequest>(create);
  static GetTotalIncomeRequest? _defaultInstance;
}

class GetTotalIncomeResponse extends $pb.GeneratedMessage {
  factory GetTotalIncomeResponse({
    $core.double? totalIncome,
    $core.String? currency,
  }) {
    final $result = create();
    if (totalIncome != null) {
      $result.totalIncome = totalIncome;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    return $result;
  }
  GetTotalIncomeResponse._() : super();
  factory GetTotalIncomeResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTotalIncomeResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetTotalIncomeResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'totalIncome', $pb.PbFieldType.OD)
    ..aOS(2, _omitFieldNames ? '' : 'currency')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetTotalIncomeResponse clone() => GetTotalIncomeResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetTotalIncomeResponse copyWith(void Function(GetTotalIncomeResponse) updates) => super.copyWith((message) => updates(message as GetTotalIncomeResponse)) as GetTotalIncomeResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTotalIncomeResponse create() => GetTotalIncomeResponse._();
  GetTotalIncomeResponse createEmptyInstance() => create();
  static $pb.PbList<GetTotalIncomeResponse> createRepeated() => $pb.PbList<GetTotalIncomeResponse>();
  @$core.pragma('dart2js:noInline')
  static GetTotalIncomeResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTotalIncomeResponse>(create);
  static GetTotalIncomeResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get totalIncome => $_getN(0);
  @$pb.TagNumber(1)
  set totalIncome($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTotalIncome() => $_has(0);
  @$pb.TagNumber(1)
  void clearTotalIncome() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get currency => $_getSZ(1);
  @$pb.TagNumber(2)
  set currency($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCurrency() => $_has(1);
  @$pb.TagNumber(2)
  void clearCurrency() => clearField(2);
}

class SyncDividendsRequest extends $pb.GeneratedMessage {
  factory SyncDividendsRequest({
    $core.String? brokerAccountId,
  }) {
    final $result = create();
    if (brokerAccountId != null) {
      $result.brokerAccountId = brokerAccountId;
    }
    return $result;
  }
  SyncDividendsRequest._() : super();
  factory SyncDividendsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SyncDividendsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SyncDividendsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'brokerAccountId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SyncDividendsRequest clone() => SyncDividendsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SyncDividendsRequest copyWith(void Function(SyncDividendsRequest) updates) => super.copyWith((message) => updates(message as SyncDividendsRequest)) as SyncDividendsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SyncDividendsRequest create() => SyncDividendsRequest._();
  SyncDividendsRequest createEmptyInstance() => create();
  static $pb.PbList<SyncDividendsRequest> createRepeated() => $pb.PbList<SyncDividendsRequest>();
  @$core.pragma('dart2js:noInline')
  static SyncDividendsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SyncDividendsRequest>(create);
  static SyncDividendsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get brokerAccountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set brokerAccountId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasBrokerAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearBrokerAccountId() => clearField(1);
}

class SyncDividendsResponse extends $pb.GeneratedMessage {
  factory SyncDividendsResponse({
    $core.int? syncedCount,
    $core.String? message,
  }) {
    final $result = create();
    if (syncedCount != null) {
      $result.syncedCount = syncedCount;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  SyncDividendsResponse._() : super();
  factory SyncDividendsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SyncDividendsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SyncDividendsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'syncedCount', $pb.PbFieldType.O3)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SyncDividendsResponse clone() => SyncDividendsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SyncDividendsResponse copyWith(void Function(SyncDividendsResponse) updates) => super.copyWith((message) => updates(message as SyncDividendsResponse)) as SyncDividendsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SyncDividendsResponse create() => SyncDividendsResponse._();
  SyncDividendsResponse createEmptyInstance() => create();
  static $pb.PbList<SyncDividendsResponse> createRepeated() => $pb.PbList<SyncDividendsResponse>();
  @$core.pragma('dart2js:noInline')
  static SyncDividendsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SyncDividendsResponse>(create);
  static SyncDividendsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get syncedCount => $_getIZ(0);
  @$pb.TagNumber(1)
  set syncedCount($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSyncedCount() => $_has(0);
  @$pb.TagNumber(1)
  void clearSyncedCount() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

class CommissionTierInfo extends $pb.GeneratedMessage {
  factory CommissionTierInfo({
    $core.String? assetType,
    $core.int? rateBps,
    $core.double? minAmount,
    $core.double? maxAmount,
    $core.bool? isActive,
  }) {
    final $result = create();
    if (assetType != null) {
      $result.assetType = assetType;
    }
    if (rateBps != null) {
      $result.rateBps = rateBps;
    }
    if (minAmount != null) {
      $result.minAmount = minAmount;
    }
    if (maxAmount != null) {
      $result.maxAmount = maxAmount;
    }
    if (isActive != null) {
      $result.isActive = isActive;
    }
    return $result;
  }
  CommissionTierInfo._() : super();
  factory CommissionTierInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CommissionTierInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CommissionTierInfo', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'assetType')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'rateBps', $pb.PbFieldType.O3)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'minAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'maxAmount', $pb.PbFieldType.OD)
    ..aOB(5, _omitFieldNames ? '' : 'isActive')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CommissionTierInfo clone() => CommissionTierInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CommissionTierInfo copyWith(void Function(CommissionTierInfo) updates) => super.copyWith((message) => updates(message as CommissionTierInfo)) as CommissionTierInfo;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CommissionTierInfo create() => CommissionTierInfo._();
  CommissionTierInfo createEmptyInstance() => create();
  static $pb.PbList<CommissionTierInfo> createRepeated() => $pb.PbList<CommissionTierInfo>();
  @$core.pragma('dart2js:noInline')
  static CommissionTierInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CommissionTierInfo>(create);
  static CommissionTierInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get assetType => $_getSZ(0);
  @$pb.TagNumber(1)
  set assetType($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAssetType() => $_has(0);
  @$pb.TagNumber(1)
  void clearAssetType() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get rateBps => $_getIZ(1);
  @$pb.TagNumber(2)
  set rateBps($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasRateBps() => $_has(1);
  @$pb.TagNumber(2)
  void clearRateBps() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get minAmount => $_getN(2);
  @$pb.TagNumber(3)
  set minAmount($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMinAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearMinAmount() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get maxAmount => $_getN(3);
  @$pb.TagNumber(4)
  set maxAmount($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMaxAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearMaxAmount() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get isActive => $_getBF(4);
  @$pb.TagNumber(5)
  set isActive($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasIsActive() => $_has(4);
  @$pb.TagNumber(5)
  void clearIsActive() => clearField(5);
}

class GetCommissionRatesRequest extends $pb.GeneratedMessage {
  factory GetCommissionRatesRequest() => create();
  GetCommissionRatesRequest._() : super();
  factory GetCommissionRatesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCommissionRatesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetCommissionRatesRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCommissionRatesRequest clone() => GetCommissionRatesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCommissionRatesRequest copyWith(void Function(GetCommissionRatesRequest) updates) => super.copyWith((message) => updates(message as GetCommissionRatesRequest)) as GetCommissionRatesRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCommissionRatesRequest create() => GetCommissionRatesRequest._();
  GetCommissionRatesRequest createEmptyInstance() => create();
  static $pb.PbList<GetCommissionRatesRequest> createRepeated() => $pb.PbList<GetCommissionRatesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetCommissionRatesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetCommissionRatesRequest>(create);
  static GetCommissionRatesRequest? _defaultInstance;
}

class GetCommissionRatesResponse extends $pb.GeneratedMessage {
  factory GetCommissionRatesResponse({
    $core.Iterable<CommissionTierInfo>? tiers,
  }) {
    final $result = create();
    if (tiers != null) {
      $result.tiers.addAll(tiers);
    }
    return $result;
  }
  GetCommissionRatesResponse._() : super();
  factory GetCommissionRatesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCommissionRatesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetCommissionRatesResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..pc<CommissionTierInfo>(1, _omitFieldNames ? '' : 'tiers', $pb.PbFieldType.PM, subBuilder: CommissionTierInfo.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCommissionRatesResponse clone() => GetCommissionRatesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCommissionRatesResponse copyWith(void Function(GetCommissionRatesResponse) updates) => super.copyWith((message) => updates(message as GetCommissionRatesResponse)) as GetCommissionRatesResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCommissionRatesResponse create() => GetCommissionRatesResponse._();
  GetCommissionRatesResponse createEmptyInstance() => create();
  static $pb.PbList<GetCommissionRatesResponse> createRepeated() => $pb.PbList<GetCommissionRatesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetCommissionRatesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetCommissionRatesResponse>(create);
  static GetCommissionRatesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<CommissionTierInfo> get tiers => $_getList(0);
}

class CalculateCommissionRequest extends $pb.GeneratedMessage {
  factory CalculateCommissionRequest({
    $core.String? assetType,
    $core.double? tradeAmount,
  }) {
    final $result = create();
    if (assetType != null) {
      $result.assetType = assetType;
    }
    if (tradeAmount != null) {
      $result.tradeAmount = tradeAmount;
    }
    return $result;
  }
  CalculateCommissionRequest._() : super();
  factory CalculateCommissionRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CalculateCommissionRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CalculateCommissionRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'assetType')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'tradeAmount', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CalculateCommissionRequest clone() => CalculateCommissionRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CalculateCommissionRequest copyWith(void Function(CalculateCommissionRequest) updates) => super.copyWith((message) => updates(message as CalculateCommissionRequest)) as CalculateCommissionRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CalculateCommissionRequest create() => CalculateCommissionRequest._();
  CalculateCommissionRequest createEmptyInstance() => create();
  static $pb.PbList<CalculateCommissionRequest> createRepeated() => $pb.PbList<CalculateCommissionRequest>();
  @$core.pragma('dart2js:noInline')
  static CalculateCommissionRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CalculateCommissionRequest>(create);
  static CalculateCommissionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get assetType => $_getSZ(0);
  @$pb.TagNumber(1)
  set assetType($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAssetType() => $_has(0);
  @$pb.TagNumber(1)
  void clearAssetType() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get tradeAmount => $_getN(1);
  @$pb.TagNumber(2)
  set tradeAmount($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTradeAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearTradeAmount() => clearField(2);
}

class CalculateCommissionResponse extends $pb.GeneratedMessage {
  factory CalculateCommissionResponse({
    $core.String? assetType,
    $core.double? tradeAmount,
    $core.double? commissionRate,
    $core.double? commissionAmount,
    $core.double? netAmount,
  }) {
    final $result = create();
    if (assetType != null) {
      $result.assetType = assetType;
    }
    if (tradeAmount != null) {
      $result.tradeAmount = tradeAmount;
    }
    if (commissionRate != null) {
      $result.commissionRate = commissionRate;
    }
    if (commissionAmount != null) {
      $result.commissionAmount = commissionAmount;
    }
    if (netAmount != null) {
      $result.netAmount = netAmount;
    }
    return $result;
  }
  CalculateCommissionResponse._() : super();
  factory CalculateCommissionResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CalculateCommissionResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CalculateCommissionResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'assetType')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'tradeAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'commissionRate', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'commissionAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(5, _omitFieldNames ? '' : 'netAmount', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CalculateCommissionResponse clone() => CalculateCommissionResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CalculateCommissionResponse copyWith(void Function(CalculateCommissionResponse) updates) => super.copyWith((message) => updates(message as CalculateCommissionResponse)) as CalculateCommissionResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CalculateCommissionResponse create() => CalculateCommissionResponse._();
  CalculateCommissionResponse createEmptyInstance() => create();
  static $pb.PbList<CalculateCommissionResponse> createRepeated() => $pb.PbList<CalculateCommissionResponse>();
  @$core.pragma('dart2js:noInline')
  static CalculateCommissionResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CalculateCommissionResponse>(create);
  static CalculateCommissionResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get assetType => $_getSZ(0);
  @$pb.TagNumber(1)
  set assetType($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAssetType() => $_has(0);
  @$pb.TagNumber(1)
  void clearAssetType() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get tradeAmount => $_getN(1);
  @$pb.TagNumber(2)
  set tradeAmount($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTradeAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearTradeAmount() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get commissionRate => $_getN(2);
  @$pb.TagNumber(3)
  set commissionRate($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCommissionRate() => $_has(2);
  @$pb.TagNumber(3)
  void clearCommissionRate() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get commissionAmount => $_getN(3);
  @$pb.TagNumber(4)
  set commissionAmount($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCommissionAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearCommissionAmount() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get netAmount => $_getN(4);
  @$pb.TagNumber(5)
  set netAmount($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasNetAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearNetAmount() => clearField(5);
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
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (name != null) {
      $result.name = name;
    }
    if (maturityDays != null) {
      $result.maturityDays = maturityDays;
    }
    if (rate != null) {
      $result.rate = rate;
    }
    if (unitPrice != null) {
      $result.unitPrice = unitPrice;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (maturityDate != null) {
      $result.maturityDate = maturityDate;
    }
    if (status != null) {
      $result.status = status;
    }
    return $result;
  }
  TreasuryBillInfo._() : super();
  factory TreasuryBillInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TreasuryBillInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TreasuryBillInfo', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'maturityDays', $pb.PbFieldType.O3)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'rate', $pb.PbFieldType.OD)
    ..a<$core.double>(5, _omitFieldNames ? '' : 'unitPrice', $pb.PbFieldType.OD)
    ..aOS(6, _omitFieldNames ? '' : 'currency')
    ..aOS(7, _omitFieldNames ? '' : 'maturityDate')
    ..aOS(8, _omitFieldNames ? '' : 'status')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TreasuryBillInfo clone() => TreasuryBillInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TreasuryBillInfo copyWith(void Function(TreasuryBillInfo) updates) => super.copyWith((message) => updates(message as TreasuryBillInfo)) as TreasuryBillInfo;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TreasuryBillInfo create() => TreasuryBillInfo._();
  TreasuryBillInfo createEmptyInstance() => create();
  static $pb.PbList<TreasuryBillInfo> createRepeated() => $pb.PbList<TreasuryBillInfo>();
  @$core.pragma('dart2js:noInline')
  static TreasuryBillInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TreasuryBillInfo>(create);
  static TreasuryBillInfo? _defaultInstance;

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
  $core.int get maturityDays => $_getIZ(2);
  @$pb.TagNumber(3)
  set maturityDays($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMaturityDays() => $_has(2);
  @$pb.TagNumber(3)
  void clearMaturityDays() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get rate => $_getN(3);
  @$pb.TagNumber(4)
  set rate($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasRate() => $_has(3);
  @$pb.TagNumber(4)
  void clearRate() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get unitPrice => $_getN(4);
  @$pb.TagNumber(5)
  set unitPrice($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasUnitPrice() => $_has(4);
  @$pb.TagNumber(5)
  void clearUnitPrice() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get currency => $_getSZ(5);
  @$pb.TagNumber(6)
  set currency($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasCurrency() => $_has(5);
  @$pb.TagNumber(6)
  void clearCurrency() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get maturityDate => $_getSZ(6);
  @$pb.TagNumber(7)
  set maturityDate($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasMaturityDate() => $_has(6);
  @$pb.TagNumber(7)
  void clearMaturityDate() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get status => $_getSZ(7);
  @$pb.TagNumber(8)
  set status($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasStatus() => $_has(7);
  @$pb.TagNumber(8)
  void clearStatus() => clearField(8);
}

class GetTreasuryBillsRequest extends $pb.GeneratedMessage {
  factory GetTreasuryBillsRequest() => create();
  GetTreasuryBillsRequest._() : super();
  factory GetTreasuryBillsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTreasuryBillsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetTreasuryBillsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetTreasuryBillsRequest clone() => GetTreasuryBillsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetTreasuryBillsRequest copyWith(void Function(GetTreasuryBillsRequest) updates) => super.copyWith((message) => updates(message as GetTreasuryBillsRequest)) as GetTreasuryBillsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTreasuryBillsRequest create() => GetTreasuryBillsRequest._();
  GetTreasuryBillsRequest createEmptyInstance() => create();
  static $pb.PbList<GetTreasuryBillsRequest> createRepeated() => $pb.PbList<GetTreasuryBillsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetTreasuryBillsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTreasuryBillsRequest>(create);
  static GetTreasuryBillsRequest? _defaultInstance;
}

class GetTreasuryBillsResponse extends $pb.GeneratedMessage {
  factory GetTreasuryBillsResponse({
    $core.Iterable<TreasuryBillInfo>? bills,
  }) {
    final $result = create();
    if (bills != null) {
      $result.bills.addAll(bills);
    }
    return $result;
  }
  GetTreasuryBillsResponse._() : super();
  factory GetTreasuryBillsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTreasuryBillsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetTreasuryBillsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..pc<TreasuryBillInfo>(1, _omitFieldNames ? '' : 'bills', $pb.PbFieldType.PM, subBuilder: TreasuryBillInfo.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetTreasuryBillsResponse clone() => GetTreasuryBillsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetTreasuryBillsResponse copyWith(void Function(GetTreasuryBillsResponse) updates) => super.copyWith((message) => updates(message as GetTreasuryBillsResponse)) as GetTreasuryBillsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTreasuryBillsResponse create() => GetTreasuryBillsResponse._();
  GetTreasuryBillsResponse createEmptyInstance() => create();
  static $pb.PbList<GetTreasuryBillsResponse> createRepeated() => $pb.PbList<GetTreasuryBillsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetTreasuryBillsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTreasuryBillsResponse>(create);
  static GetTreasuryBillsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<TreasuryBillInfo> get bills => $_getList(0);
}

class BuyTreasuryBillRequest extends $pb.GeneratedMessage {
  factory BuyTreasuryBillRequest({
    $core.String? assetId,
    $core.double? amount,
    $core.String? currency,
    $core.String? idempotencyKey,
    $core.String? verificationToken,
  }) {
    final $result = create();
    if (assetId != null) {
      $result.assetId = assetId;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (idempotencyKey != null) {
      $result.idempotencyKey = idempotencyKey;
    }
    if (verificationToken != null) {
      $result.verificationToken = verificationToken;
    }
    return $result;
  }
  BuyTreasuryBillRequest._() : super();
  factory BuyTreasuryBillRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BuyTreasuryBillRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'BuyTreasuryBillRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'assetId')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(3, _omitFieldNames ? '' : 'currency')
    ..aOS(4, _omitFieldNames ? '' : 'idempotencyKey')
    ..aOS(5, _omitFieldNames ? '' : 'verificationToken')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BuyTreasuryBillRequest clone() => BuyTreasuryBillRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BuyTreasuryBillRequest copyWith(void Function(BuyTreasuryBillRequest) updates) => super.copyWith((message) => updates(message as BuyTreasuryBillRequest)) as BuyTreasuryBillRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BuyTreasuryBillRequest create() => BuyTreasuryBillRequest._();
  BuyTreasuryBillRequest createEmptyInstance() => create();
  static $pb.PbList<BuyTreasuryBillRequest> createRepeated() => $pb.PbList<BuyTreasuryBillRequest>();
  @$core.pragma('dart2js:noInline')
  static BuyTreasuryBillRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BuyTreasuryBillRequest>(create);
  static BuyTreasuryBillRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get assetId => $_getSZ(0);
  @$pb.TagNumber(1)
  set assetId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAssetId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAssetId() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get amount => $_getN(1);
  @$pb.TagNumber(2)
  set amount($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get currency => $_getSZ(2);
  @$pb.TagNumber(3)
  set currency($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCurrency() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrency() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get idempotencyKey => $_getSZ(3);
  @$pb.TagNumber(4)
  set idempotencyKey($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasIdempotencyKey() => $_has(3);
  @$pb.TagNumber(4)
  void clearIdempotencyKey() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get verificationToken => $_getSZ(4);
  @$pb.TagNumber(5)
  set verificationToken($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasVerificationToken() => $_has(4);
  @$pb.TagNumber(5)
  void clearVerificationToken() => clearField(5);
}

class BuyTreasuryBillResponse extends $pb.GeneratedMessage {
  factory BuyTreasuryBillResponse({
    $core.String? investmentId,
    $core.double? amount,
    $core.double? units,
    $core.String? status,
    $core.String? message,
  }) {
    final $result = create();
    if (investmentId != null) {
      $result.investmentId = investmentId;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (units != null) {
      $result.units = units;
    }
    if (status != null) {
      $result.status = status;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  BuyTreasuryBillResponse._() : super();
  factory BuyTreasuryBillResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BuyTreasuryBillResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'BuyTreasuryBillResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'investmentId')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'units', $pb.PbFieldType.OD)
    ..aOS(4, _omitFieldNames ? '' : 'status')
    ..aOS(5, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BuyTreasuryBillResponse clone() => BuyTreasuryBillResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BuyTreasuryBillResponse copyWith(void Function(BuyTreasuryBillResponse) updates) => super.copyWith((message) => updates(message as BuyTreasuryBillResponse)) as BuyTreasuryBillResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BuyTreasuryBillResponse create() => BuyTreasuryBillResponse._();
  BuyTreasuryBillResponse createEmptyInstance() => create();
  static $pb.PbList<BuyTreasuryBillResponse> createRepeated() => $pb.PbList<BuyTreasuryBillResponse>();
  @$core.pragma('dart2js:noInline')
  static BuyTreasuryBillResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BuyTreasuryBillResponse>(create);
  static BuyTreasuryBillResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get investmentId => $_getSZ(0);
  @$pb.TagNumber(1)
  set investmentId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasInvestmentId() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvestmentId() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get amount => $_getN(1);
  @$pb.TagNumber(2)
  set amount($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get units => $_getN(2);
  @$pb.TagNumber(3)
  set units($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasUnits() => $_has(2);
  @$pb.TagNumber(3)
  void clearUnits() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get status => $_getSZ(3);
  @$pb.TagNumber(4)
  set status($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearStatus() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get message => $_getSZ(4);
  @$pb.TagNumber(5)
  set message($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasMessage() => $_has(4);
  @$pb.TagNumber(5)
  void clearMessage() => clearField(5);
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
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (name != null) {
      $result.name = name;
    }
    if (fundType != null) {
      $result.fundType = fundType;
    }
    if (riskLevel != null) {
      $result.riskLevel = riskLevel;
    }
    if (returnRate != null) {
      $result.returnRate = returnRate;
    }
    if (minInvestment != null) {
      $result.minInvestment = minInvestment;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (nav != null) {
      $result.nav = nav;
    }
    if (status != null) {
      $result.status = status;
    }
    return $result;
  }
  MutualFundInfo._() : super();
  factory MutualFundInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MutualFundInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MutualFundInfo', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'fundType')
    ..aOS(4, _omitFieldNames ? '' : 'riskLevel')
    ..a<$core.double>(5, _omitFieldNames ? '' : 'returnRate', $pb.PbFieldType.OD)
    ..a<$core.double>(6, _omitFieldNames ? '' : 'minInvestment', $pb.PbFieldType.OD)
    ..aOS(7, _omitFieldNames ? '' : 'currency')
    ..a<$core.double>(8, _omitFieldNames ? '' : 'nav', $pb.PbFieldType.OD)
    ..aOS(9, _omitFieldNames ? '' : 'status')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MutualFundInfo clone() => MutualFundInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MutualFundInfo copyWith(void Function(MutualFundInfo) updates) => super.copyWith((message) => updates(message as MutualFundInfo)) as MutualFundInfo;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MutualFundInfo create() => MutualFundInfo._();
  MutualFundInfo createEmptyInstance() => create();
  static $pb.PbList<MutualFundInfo> createRepeated() => $pb.PbList<MutualFundInfo>();
  @$core.pragma('dart2js:noInline')
  static MutualFundInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MutualFundInfo>(create);
  static MutualFundInfo? _defaultInstance;

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
  $core.String get fundType => $_getSZ(2);
  @$pb.TagNumber(3)
  set fundType($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasFundType() => $_has(2);
  @$pb.TagNumber(3)
  void clearFundType() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get riskLevel => $_getSZ(3);
  @$pb.TagNumber(4)
  set riskLevel($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasRiskLevel() => $_has(3);
  @$pb.TagNumber(4)
  void clearRiskLevel() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get returnRate => $_getN(4);
  @$pb.TagNumber(5)
  set returnRate($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasReturnRate() => $_has(4);
  @$pb.TagNumber(5)
  void clearReturnRate() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get minInvestment => $_getN(5);
  @$pb.TagNumber(6)
  set minInvestment($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasMinInvestment() => $_has(5);
  @$pb.TagNumber(6)
  void clearMinInvestment() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get currency => $_getSZ(6);
  @$pb.TagNumber(7)
  set currency($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasCurrency() => $_has(6);
  @$pb.TagNumber(7)
  void clearCurrency() => clearField(7);

  @$pb.TagNumber(8)
  $core.double get nav => $_getN(7);
  @$pb.TagNumber(8)
  set nav($core.double v) { $_setDouble(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasNav() => $_has(7);
  @$pb.TagNumber(8)
  void clearNav() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get status => $_getSZ(8);
  @$pb.TagNumber(9)
  set status($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasStatus() => $_has(8);
  @$pb.TagNumber(9)
  void clearStatus() => clearField(9);
}

class GetMutualFundsRequest extends $pb.GeneratedMessage {
  factory GetMutualFundsRequest() => create();
  GetMutualFundsRequest._() : super();
  factory GetMutualFundsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMutualFundsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetMutualFundsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMutualFundsRequest clone() => GetMutualFundsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMutualFundsRequest copyWith(void Function(GetMutualFundsRequest) updates) => super.copyWith((message) => updates(message as GetMutualFundsRequest)) as GetMutualFundsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMutualFundsRequest create() => GetMutualFundsRequest._();
  GetMutualFundsRequest createEmptyInstance() => create();
  static $pb.PbList<GetMutualFundsRequest> createRepeated() => $pb.PbList<GetMutualFundsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMutualFundsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMutualFundsRequest>(create);
  static GetMutualFundsRequest? _defaultInstance;
}

class GetMutualFundsResponse extends $pb.GeneratedMessage {
  factory GetMutualFundsResponse({
    $core.Iterable<MutualFundInfo>? funds,
  }) {
    final $result = create();
    if (funds != null) {
      $result.funds.addAll(funds);
    }
    return $result;
  }
  GetMutualFundsResponse._() : super();
  factory GetMutualFundsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMutualFundsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetMutualFundsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..pc<MutualFundInfo>(1, _omitFieldNames ? '' : 'funds', $pb.PbFieldType.PM, subBuilder: MutualFundInfo.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMutualFundsResponse clone() => GetMutualFundsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMutualFundsResponse copyWith(void Function(GetMutualFundsResponse) updates) => super.copyWith((message) => updates(message as GetMutualFundsResponse)) as GetMutualFundsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMutualFundsResponse create() => GetMutualFundsResponse._();
  GetMutualFundsResponse createEmptyInstance() => create();
  static $pb.PbList<GetMutualFundsResponse> createRepeated() => $pb.PbList<GetMutualFundsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMutualFundsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMutualFundsResponse>(create);
  static GetMutualFundsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<MutualFundInfo> get funds => $_getList(0);
}

class BuyMutualFundRequest extends $pb.GeneratedMessage {
  factory BuyMutualFundRequest({
    $core.String? assetId,
    $core.double? amount,
    $core.String? currency,
    $core.String? idempotencyKey,
    $core.String? verificationToken,
  }) {
    final $result = create();
    if (assetId != null) {
      $result.assetId = assetId;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (idempotencyKey != null) {
      $result.idempotencyKey = idempotencyKey;
    }
    if (verificationToken != null) {
      $result.verificationToken = verificationToken;
    }
    return $result;
  }
  BuyMutualFundRequest._() : super();
  factory BuyMutualFundRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BuyMutualFundRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'BuyMutualFundRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'assetId')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(3, _omitFieldNames ? '' : 'currency')
    ..aOS(4, _omitFieldNames ? '' : 'idempotencyKey')
    ..aOS(5, _omitFieldNames ? '' : 'verificationToken')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BuyMutualFundRequest clone() => BuyMutualFundRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BuyMutualFundRequest copyWith(void Function(BuyMutualFundRequest) updates) => super.copyWith((message) => updates(message as BuyMutualFundRequest)) as BuyMutualFundRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BuyMutualFundRequest create() => BuyMutualFundRequest._();
  BuyMutualFundRequest createEmptyInstance() => create();
  static $pb.PbList<BuyMutualFundRequest> createRepeated() => $pb.PbList<BuyMutualFundRequest>();
  @$core.pragma('dart2js:noInline')
  static BuyMutualFundRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BuyMutualFundRequest>(create);
  static BuyMutualFundRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get assetId => $_getSZ(0);
  @$pb.TagNumber(1)
  set assetId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAssetId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAssetId() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get amount => $_getN(1);
  @$pb.TagNumber(2)
  set amount($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get currency => $_getSZ(2);
  @$pb.TagNumber(3)
  set currency($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCurrency() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrency() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get idempotencyKey => $_getSZ(3);
  @$pb.TagNumber(4)
  set idempotencyKey($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasIdempotencyKey() => $_has(3);
  @$pb.TagNumber(4)
  void clearIdempotencyKey() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get verificationToken => $_getSZ(4);
  @$pb.TagNumber(5)
  set verificationToken($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasVerificationToken() => $_has(4);
  @$pb.TagNumber(5)
  void clearVerificationToken() => clearField(5);
}

class BuyMutualFundResponse extends $pb.GeneratedMessage {
  factory BuyMutualFundResponse({
    $core.String? investmentId,
    $core.double? amount,
    $core.double? units,
    $core.String? status,
    $core.String? message,
  }) {
    final $result = create();
    if (investmentId != null) {
      $result.investmentId = investmentId;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (units != null) {
      $result.units = units;
    }
    if (status != null) {
      $result.status = status;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  BuyMutualFundResponse._() : super();
  factory BuyMutualFundResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BuyMutualFundResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'BuyMutualFundResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'investments'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'investmentId')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'units', $pb.PbFieldType.OD)
    ..aOS(4, _omitFieldNames ? '' : 'status')
    ..aOS(5, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BuyMutualFundResponse clone() => BuyMutualFundResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BuyMutualFundResponse copyWith(void Function(BuyMutualFundResponse) updates) => super.copyWith((message) => updates(message as BuyMutualFundResponse)) as BuyMutualFundResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BuyMutualFundResponse create() => BuyMutualFundResponse._();
  BuyMutualFundResponse createEmptyInstance() => create();
  static $pb.PbList<BuyMutualFundResponse> createRepeated() => $pb.PbList<BuyMutualFundResponse>();
  @$core.pragma('dart2js:noInline')
  static BuyMutualFundResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BuyMutualFundResponse>(create);
  static BuyMutualFundResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get investmentId => $_getSZ(0);
  @$pb.TagNumber(1)
  set investmentId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasInvestmentId() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvestmentId() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get amount => $_getN(1);
  @$pb.TagNumber(2)
  set amount($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get units => $_getN(2);
  @$pb.TagNumber(3)
  set units($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasUnits() => $_has(2);
  @$pb.TagNumber(3)
  void clearUnits() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get status => $_getSZ(3);
  @$pb.TagNumber(4)
  set status($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearStatus() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get message => $_getSZ(4);
  @$pb.TagNumber(5)
  set message($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasMessage() => $_has(4);
  @$pb.TagNumber(5)
  void clearMessage() => clearField(5);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
