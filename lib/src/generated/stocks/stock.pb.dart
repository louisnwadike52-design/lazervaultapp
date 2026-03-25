// This is a generated file - do not edit.
//
// Generated from stocks/stock.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../google/protobuf/timestamp.pb.dart' as $1;
import 'stock.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'stock.pbenum.dart';

class PricePoint extends $pb.GeneratedMessage {
  factory PricePoint({
    $1.Timestamp? timestamp,
    $core.double? open,
    $core.double? high,
    $core.double? low,
    $core.double? close,
    $core.double? volume,
  }) {
    final result = create();
    if (timestamp != null) result.timestamp = timestamp;
    if (open != null) result.open = open;
    if (high != null) result.high = high;
    if (low != null) result.low = low;
    if (close != null) result.close = close;
    if (volume != null) result.volume = volume;
    return result;
  }

  PricePoint._();

  factory PricePoint.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PricePoint.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PricePoint',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'stockspb'),
      createEmptyInstance: create)
    ..aOM<$1.Timestamp>(1, _omitFieldNames ? '' : 'timestamp',
        subBuilder: $1.Timestamp.create)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'open', $pb.PbFieldType.OD)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'high', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'low', $pb.PbFieldType.OD)
    ..a<$core.double>(5, _omitFieldNames ? '' : 'close', $pb.PbFieldType.OD)
    ..a<$core.double>(6, _omitFieldNames ? '' : 'volume', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PricePoint clone() => PricePoint()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PricePoint copyWith(void Function(PricePoint) updates) =>
      super.copyWith((message) => updates(message as PricePoint)) as PricePoint;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PricePoint create() => PricePoint._();
  @$core.override
  PricePoint createEmptyInstance() => create();
  static $pb.PbList<PricePoint> createRepeated() => $pb.PbList<PricePoint>();
  @$core.pragma('dart2js:noInline')
  static PricePoint getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PricePoint>(create);
  static PricePoint? _defaultInstance;

  @$pb.TagNumber(1)
  $1.Timestamp get timestamp => $_getN(0);
  @$pb.TagNumber(1)
  set timestamp($1.Timestamp value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasTimestamp() => $_has(0);
  @$pb.TagNumber(1)
  void clearTimestamp() => $_clearField(1);
  @$pb.TagNumber(1)
  $1.Timestamp ensureTimestamp() => $_ensure(0);

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
  $core.double get volume => $_getN(5);
  @$pb.TagNumber(6)
  set volume($core.double value) => $_setDouble(5, value);
  @$pb.TagNumber(6)
  $core.bool hasVolume() => $_has(5);
  @$pb.TagNumber(6)
  void clearVolume() => $_clearField(6);
}

class StockMessage extends $pb.GeneratedMessage {
  factory StockMessage({
    $core.String? symbol,
    $core.String? name,
    $core.double? currentPrice,
    $core.double? previousClose,
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
    $core.Iterable<PricePoint>? priceHistory,
    $1.Timestamp? lastUpdated,
    $core.double? weekHigh52,
    $core.double? weekLow52,
    $core.double? avgVolume,
    $core.double? beta,
    $core.double? eps,
    $core.String? description,
    $core.String? exchange,
    $core.String? currency,
  }) {
    final result = create();
    if (symbol != null) result.symbol = symbol;
    if (name != null) result.name = name;
    if (currentPrice != null) result.currentPrice = currentPrice;
    if (previousClose != null) result.previousClose = previousClose;
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
    if (priceHistory != null) result.priceHistory.addAll(priceHistory);
    if (lastUpdated != null) result.lastUpdated = lastUpdated;
    if (weekHigh52 != null) result.weekHigh52 = weekHigh52;
    if (weekLow52 != null) result.weekLow52 = weekLow52;
    if (avgVolume != null) result.avgVolume = avgVolume;
    if (beta != null) result.beta = beta;
    if (eps != null) result.eps = eps;
    if (description != null) result.description = description;
    if (exchange != null) result.exchange = exchange;
    if (currency != null) result.currency = currency;
    return result;
  }

  StockMessage._();

  factory StockMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory StockMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StockMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'stockspb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'symbol')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..a<$core.double>(
        3, _omitFieldNames ? '' : 'currentPrice', $pb.PbFieldType.OD)
    ..a<$core.double>(
        4, _omitFieldNames ? '' : 'previousClose', $pb.PbFieldType.OD)
    ..a<$core.double>(5, _omitFieldNames ? '' : 'change', $pb.PbFieldType.OD)
    ..a<$core.double>(
        6, _omitFieldNames ? '' : 'changePercent', $pb.PbFieldType.OD)
    ..a<$core.double>(7, _omitFieldNames ? '' : 'dayHigh', $pb.PbFieldType.OD)
    ..a<$core.double>(8, _omitFieldNames ? '' : 'dayLow', $pb.PbFieldType.OD)
    ..a<$core.double>(9, _omitFieldNames ? '' : 'volume', $pb.PbFieldType.OD)
    ..a<$core.double>(
        10, _omitFieldNames ? '' : 'marketCap', $pb.PbFieldType.OD)
    ..a<$core.double>(11, _omitFieldNames ? '' : 'peRatio', $pb.PbFieldType.OD)
    ..a<$core.double>(
        12, _omitFieldNames ? '' : 'dividendYield', $pb.PbFieldType.OD)
    ..aOS(13, _omitFieldNames ? '' : 'sector')
    ..aOS(14, _omitFieldNames ? '' : 'industry')
    ..aOS(15, _omitFieldNames ? '' : 'logoUrl')
    ..pc<PricePoint>(
        16, _omitFieldNames ? '' : 'priceHistory', $pb.PbFieldType.PM,
        subBuilder: PricePoint.create)
    ..aOM<$1.Timestamp>(17, _omitFieldNames ? '' : 'lastUpdated',
        subBuilder: $1.Timestamp.create)
    ..a<$core.double>(
        18, _omitFieldNames ? '' : 'weekHigh52', $pb.PbFieldType.OD,
        protoName: 'week_high_52')
    ..a<$core.double>(
        19, _omitFieldNames ? '' : 'weekLow52', $pb.PbFieldType.OD,
        protoName: 'week_low_52')
    ..a<$core.double>(
        20, _omitFieldNames ? '' : 'avgVolume', $pb.PbFieldType.OD)
    ..a<$core.double>(21, _omitFieldNames ? '' : 'beta', $pb.PbFieldType.OD)
    ..a<$core.double>(22, _omitFieldNames ? '' : 'eps', $pb.PbFieldType.OD)
    ..aOS(23, _omitFieldNames ? '' : 'description')
    ..aOS(24, _omitFieldNames ? '' : 'exchange')
    ..aOS(25, _omitFieldNames ? '' : 'currency')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StockMessage clone() => StockMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StockMessage copyWith(void Function(StockMessage) updates) =>
      super.copyWith((message) => updates(message as StockMessage))
          as StockMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StockMessage create() => StockMessage._();
  @$core.override
  StockMessage createEmptyInstance() => create();
  static $pb.PbList<StockMessage> createRepeated() =>
      $pb.PbList<StockMessage>();
  @$core.pragma('dart2js:noInline')
  static StockMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<StockMessage>(create);
  static StockMessage? _defaultInstance;

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
  $core.double get previousClose => $_getN(3);
  @$pb.TagNumber(4)
  set previousClose($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPreviousClose() => $_has(3);
  @$pb.TagNumber(4)
  void clearPreviousClose() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get change => $_getN(4);
  @$pb.TagNumber(5)
  set change($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasChange() => $_has(4);
  @$pb.TagNumber(5)
  void clearChange() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.double get changePercent => $_getN(5);
  @$pb.TagNumber(6)
  set changePercent($core.double value) => $_setDouble(5, value);
  @$pb.TagNumber(6)
  $core.bool hasChangePercent() => $_has(5);
  @$pb.TagNumber(6)
  void clearChangePercent() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.double get dayHigh => $_getN(6);
  @$pb.TagNumber(7)
  set dayHigh($core.double value) => $_setDouble(6, value);
  @$pb.TagNumber(7)
  $core.bool hasDayHigh() => $_has(6);
  @$pb.TagNumber(7)
  void clearDayHigh() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.double get dayLow => $_getN(7);
  @$pb.TagNumber(8)
  set dayLow($core.double value) => $_setDouble(7, value);
  @$pb.TagNumber(8)
  $core.bool hasDayLow() => $_has(7);
  @$pb.TagNumber(8)
  void clearDayLow() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.double get volume => $_getN(8);
  @$pb.TagNumber(9)
  set volume($core.double value) => $_setDouble(8, value);
  @$pb.TagNumber(9)
  $core.bool hasVolume() => $_has(8);
  @$pb.TagNumber(9)
  void clearVolume() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.double get marketCap => $_getN(9);
  @$pb.TagNumber(10)
  set marketCap($core.double value) => $_setDouble(9, value);
  @$pb.TagNumber(10)
  $core.bool hasMarketCap() => $_has(9);
  @$pb.TagNumber(10)
  void clearMarketCap() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.double get peRatio => $_getN(10);
  @$pb.TagNumber(11)
  set peRatio($core.double value) => $_setDouble(10, value);
  @$pb.TagNumber(11)
  $core.bool hasPeRatio() => $_has(10);
  @$pb.TagNumber(11)
  void clearPeRatio() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.double get dividendYield => $_getN(11);
  @$pb.TagNumber(12)
  set dividendYield($core.double value) => $_setDouble(11, value);
  @$pb.TagNumber(12)
  $core.bool hasDividendYield() => $_has(11);
  @$pb.TagNumber(12)
  void clearDividendYield() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get sector => $_getSZ(12);
  @$pb.TagNumber(13)
  set sector($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasSector() => $_has(12);
  @$pb.TagNumber(13)
  void clearSector() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.String get industry => $_getSZ(13);
  @$pb.TagNumber(14)
  set industry($core.String value) => $_setString(13, value);
  @$pb.TagNumber(14)
  $core.bool hasIndustry() => $_has(13);
  @$pb.TagNumber(14)
  void clearIndustry() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.String get logoUrl => $_getSZ(14);
  @$pb.TagNumber(15)
  set logoUrl($core.String value) => $_setString(14, value);
  @$pb.TagNumber(15)
  $core.bool hasLogoUrl() => $_has(14);
  @$pb.TagNumber(15)
  void clearLogoUrl() => $_clearField(15);

  @$pb.TagNumber(16)
  $pb.PbList<PricePoint> get priceHistory => $_getList(15);

  @$pb.TagNumber(17)
  $1.Timestamp get lastUpdated => $_getN(16);
  @$pb.TagNumber(17)
  set lastUpdated($1.Timestamp value) => $_setField(17, value);
  @$pb.TagNumber(17)
  $core.bool hasLastUpdated() => $_has(16);
  @$pb.TagNumber(17)
  void clearLastUpdated() => $_clearField(17);
  @$pb.TagNumber(17)
  $1.Timestamp ensureLastUpdated() => $_ensure(16);

  @$pb.TagNumber(18)
  $core.double get weekHigh52 => $_getN(17);
  @$pb.TagNumber(18)
  set weekHigh52($core.double value) => $_setDouble(17, value);
  @$pb.TagNumber(18)
  $core.bool hasWeekHigh52() => $_has(17);
  @$pb.TagNumber(18)
  void clearWeekHigh52() => $_clearField(18);

  @$pb.TagNumber(19)
  $core.double get weekLow52 => $_getN(18);
  @$pb.TagNumber(19)
  set weekLow52($core.double value) => $_setDouble(18, value);
  @$pb.TagNumber(19)
  $core.bool hasWeekLow52() => $_has(18);
  @$pb.TagNumber(19)
  void clearWeekLow52() => $_clearField(19);

  @$pb.TagNumber(20)
  $core.double get avgVolume => $_getN(19);
  @$pb.TagNumber(20)
  set avgVolume($core.double value) => $_setDouble(19, value);
  @$pb.TagNumber(20)
  $core.bool hasAvgVolume() => $_has(19);
  @$pb.TagNumber(20)
  void clearAvgVolume() => $_clearField(20);

  @$pb.TagNumber(21)
  $core.double get beta => $_getN(20);
  @$pb.TagNumber(21)
  set beta($core.double value) => $_setDouble(20, value);
  @$pb.TagNumber(21)
  $core.bool hasBeta() => $_has(20);
  @$pb.TagNumber(21)
  void clearBeta() => $_clearField(21);

  @$pb.TagNumber(22)
  $core.double get eps => $_getN(21);
  @$pb.TagNumber(22)
  set eps($core.double value) => $_setDouble(21, value);
  @$pb.TagNumber(22)
  $core.bool hasEps() => $_has(21);
  @$pb.TagNumber(22)
  void clearEps() => $_clearField(22);

  @$pb.TagNumber(23)
  $core.String get description => $_getSZ(22);
  @$pb.TagNumber(23)
  set description($core.String value) => $_setString(22, value);
  @$pb.TagNumber(23)
  $core.bool hasDescription() => $_has(22);
  @$pb.TagNumber(23)
  void clearDescription() => $_clearField(23);

  @$pb.TagNumber(24)
  $core.String get exchange => $_getSZ(23);
  @$pb.TagNumber(24)
  set exchange($core.String value) => $_setString(23, value);
  @$pb.TagNumber(24)
  $core.bool hasExchange() => $_has(23);
  @$pb.TagNumber(24)
  void clearExchange() => $_clearField(24);

  @$pb.TagNumber(25)
  $core.String get currency => $_getSZ(24);
  @$pb.TagNumber(25)
  set currency($core.String value) => $_setString(24, value);
  @$pb.TagNumber(25)
  $core.bool hasCurrency() => $_has(24);
  @$pb.TagNumber(25)
  void clearCurrency() => $_clearField(25);
}

class PortfolioMessage extends $pb.GeneratedMessage {
  factory PortfolioMessage({
    $core.String? id,
    $core.String? userId,
    $core.double? totalValue,
    $core.double? totalCost,
    $core.double? totalReturn,
    $core.double? totalReturnPercent,
    $core.double? dayChange,
    $core.double? dayChangePercent,
    $core.Iterable<HoldingMessage>? holdings,
    $1.Timestamp? lastUpdated,
    $core.double? availableCash,
    $core.double? totalInvested,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (userId != null) result.userId = userId;
    if (totalValue != null) result.totalValue = totalValue;
    if (totalCost != null) result.totalCost = totalCost;
    if (totalReturn != null) result.totalReturn = totalReturn;
    if (totalReturnPercent != null)
      result.totalReturnPercent = totalReturnPercent;
    if (dayChange != null) result.dayChange = dayChange;
    if (dayChangePercent != null) result.dayChangePercent = dayChangePercent;
    if (holdings != null) result.holdings.addAll(holdings);
    if (lastUpdated != null) result.lastUpdated = lastUpdated;
    if (availableCash != null) result.availableCash = availableCash;
    if (totalInvested != null) result.totalInvested = totalInvested;
    return result;
  }

  PortfolioMessage._();

  factory PortfolioMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PortfolioMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PortfolioMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'stockspb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..a<$core.double>(
        3, _omitFieldNames ? '' : 'totalValue', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'totalCost', $pb.PbFieldType.OD)
    ..a<$core.double>(
        5, _omitFieldNames ? '' : 'totalReturn', $pb.PbFieldType.OD)
    ..a<$core.double>(
        6, _omitFieldNames ? '' : 'totalReturnPercent', $pb.PbFieldType.OD)
    ..a<$core.double>(7, _omitFieldNames ? '' : 'dayChange', $pb.PbFieldType.OD)
    ..a<$core.double>(
        8, _omitFieldNames ? '' : 'dayChangePercent', $pb.PbFieldType.OD)
    ..pc<HoldingMessage>(
        9, _omitFieldNames ? '' : 'holdings', $pb.PbFieldType.PM,
        subBuilder: HoldingMessage.create)
    ..aOM<$1.Timestamp>(10, _omitFieldNames ? '' : 'lastUpdated',
        subBuilder: $1.Timestamp.create)
    ..a<$core.double>(
        11, _omitFieldNames ? '' : 'availableCash', $pb.PbFieldType.OD)
    ..a<$core.double>(
        12, _omitFieldNames ? '' : 'totalInvested', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PortfolioMessage clone() => PortfolioMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PortfolioMessage copyWith(void Function(PortfolioMessage) updates) =>
      super.copyWith((message) => updates(message as PortfolioMessage))
          as PortfolioMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PortfolioMessage create() => PortfolioMessage._();
  @$core.override
  PortfolioMessage createEmptyInstance() => create();
  static $pb.PbList<PortfolioMessage> createRepeated() =>
      $pb.PbList<PortfolioMessage>();
  @$core.pragma('dart2js:noInline')
  static PortfolioMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PortfolioMessage>(create);
  static PortfolioMessage? _defaultInstance;

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
  $core.double get totalValue => $_getN(2);
  @$pb.TagNumber(3)
  set totalValue($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTotalValue() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalValue() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get totalCost => $_getN(3);
  @$pb.TagNumber(4)
  set totalCost($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTotalCost() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalCost() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get totalReturn => $_getN(4);
  @$pb.TagNumber(5)
  set totalReturn($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTotalReturn() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotalReturn() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.double get totalReturnPercent => $_getN(5);
  @$pb.TagNumber(6)
  set totalReturnPercent($core.double value) => $_setDouble(5, value);
  @$pb.TagNumber(6)
  $core.bool hasTotalReturnPercent() => $_has(5);
  @$pb.TagNumber(6)
  void clearTotalReturnPercent() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.double get dayChange => $_getN(6);
  @$pb.TagNumber(7)
  set dayChange($core.double value) => $_setDouble(6, value);
  @$pb.TagNumber(7)
  $core.bool hasDayChange() => $_has(6);
  @$pb.TagNumber(7)
  void clearDayChange() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.double get dayChangePercent => $_getN(7);
  @$pb.TagNumber(8)
  set dayChangePercent($core.double value) => $_setDouble(7, value);
  @$pb.TagNumber(8)
  $core.bool hasDayChangePercent() => $_has(7);
  @$pb.TagNumber(8)
  void clearDayChangePercent() => $_clearField(8);

  @$pb.TagNumber(9)
  $pb.PbList<HoldingMessage> get holdings => $_getList(8);

  @$pb.TagNumber(10)
  $1.Timestamp get lastUpdated => $_getN(9);
  @$pb.TagNumber(10)
  set lastUpdated($1.Timestamp value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasLastUpdated() => $_has(9);
  @$pb.TagNumber(10)
  void clearLastUpdated() => $_clearField(10);
  @$pb.TagNumber(10)
  $1.Timestamp ensureLastUpdated() => $_ensure(9);

  @$pb.TagNumber(11)
  $core.double get availableCash => $_getN(10);
  @$pb.TagNumber(11)
  set availableCash($core.double value) => $_setDouble(10, value);
  @$pb.TagNumber(11)
  $core.bool hasAvailableCash() => $_has(10);
  @$pb.TagNumber(11)
  void clearAvailableCash() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.double get totalInvested => $_getN(11);
  @$pb.TagNumber(12)
  set totalInvested($core.double value) => $_setDouble(11, value);
  @$pb.TagNumber(12)
  $core.bool hasTotalInvested() => $_has(11);
  @$pb.TagNumber(12)
  void clearTotalInvested() => $_clearField(12);
}

class HoldingMessage extends $pb.GeneratedMessage {
  factory HoldingMessage({
    $core.String? id,
    $core.String? symbol,
    $core.String? name,
    $core.int? shares,
    $core.double? averageCost,
    $core.double? currentPrice,
    $core.double? totalValue,
    $core.double? totalReturn,
    $core.double? totalReturnPercent,
    $core.double? dayChange,
    $core.double? dayChangePercent,
    $1.Timestamp? purchaseDate,
    $core.String? logoUrl,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (symbol != null) result.symbol = symbol;
    if (name != null) result.name = name;
    if (shares != null) result.shares = shares;
    if (averageCost != null) result.averageCost = averageCost;
    if (currentPrice != null) result.currentPrice = currentPrice;
    if (totalValue != null) result.totalValue = totalValue;
    if (totalReturn != null) result.totalReturn = totalReturn;
    if (totalReturnPercent != null)
      result.totalReturnPercent = totalReturnPercent;
    if (dayChange != null) result.dayChange = dayChange;
    if (dayChangePercent != null) result.dayChangePercent = dayChangePercent;
    if (purchaseDate != null) result.purchaseDate = purchaseDate;
    if (logoUrl != null) result.logoUrl = logoUrl;
    return result;
  }

  HoldingMessage._();

  factory HoldingMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory HoldingMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'HoldingMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'stockspb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'symbol')
    ..aOS(3, _omitFieldNames ? '' : 'name')
    ..a<$core.int>(4, _omitFieldNames ? '' : 'shares', $pb.PbFieldType.O3)
    ..a<$core.double>(
        5, _omitFieldNames ? '' : 'averageCost', $pb.PbFieldType.OD)
    ..a<$core.double>(
        6, _omitFieldNames ? '' : 'currentPrice', $pb.PbFieldType.OD)
    ..a<$core.double>(
        7, _omitFieldNames ? '' : 'totalValue', $pb.PbFieldType.OD)
    ..a<$core.double>(
        8, _omitFieldNames ? '' : 'totalReturn', $pb.PbFieldType.OD)
    ..a<$core.double>(
        9, _omitFieldNames ? '' : 'totalReturnPercent', $pb.PbFieldType.OD)
    ..a<$core.double>(
        10, _omitFieldNames ? '' : 'dayChange', $pb.PbFieldType.OD)
    ..a<$core.double>(
        11, _omitFieldNames ? '' : 'dayChangePercent', $pb.PbFieldType.OD)
    ..aOM<$1.Timestamp>(12, _omitFieldNames ? '' : 'purchaseDate',
        subBuilder: $1.Timestamp.create)
    ..aOS(13, _omitFieldNames ? '' : 'logoUrl')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HoldingMessage clone() => HoldingMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HoldingMessage copyWith(void Function(HoldingMessage) updates) =>
      super.copyWith((message) => updates(message as HoldingMessage))
          as HoldingMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static HoldingMessage create() => HoldingMessage._();
  @$core.override
  HoldingMessage createEmptyInstance() => create();
  static $pb.PbList<HoldingMessage> createRepeated() =>
      $pb.PbList<HoldingMessage>();
  @$core.pragma('dart2js:noInline')
  static HoldingMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<HoldingMessage>(create);
  static HoldingMessage? _defaultInstance;

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
  $core.int get shares => $_getIZ(3);
  @$pb.TagNumber(4)
  set shares($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasShares() => $_has(3);
  @$pb.TagNumber(4)
  void clearShares() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get averageCost => $_getN(4);
  @$pb.TagNumber(5)
  set averageCost($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasAverageCost() => $_has(4);
  @$pb.TagNumber(5)
  void clearAverageCost() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.double get currentPrice => $_getN(5);
  @$pb.TagNumber(6)
  set currentPrice($core.double value) => $_setDouble(5, value);
  @$pb.TagNumber(6)
  $core.bool hasCurrentPrice() => $_has(5);
  @$pb.TagNumber(6)
  void clearCurrentPrice() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.double get totalValue => $_getN(6);
  @$pb.TagNumber(7)
  set totalValue($core.double value) => $_setDouble(6, value);
  @$pb.TagNumber(7)
  $core.bool hasTotalValue() => $_has(6);
  @$pb.TagNumber(7)
  void clearTotalValue() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.double get totalReturn => $_getN(7);
  @$pb.TagNumber(8)
  set totalReturn($core.double value) => $_setDouble(7, value);
  @$pb.TagNumber(8)
  $core.bool hasTotalReturn() => $_has(7);
  @$pb.TagNumber(8)
  void clearTotalReturn() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.double get totalReturnPercent => $_getN(8);
  @$pb.TagNumber(9)
  set totalReturnPercent($core.double value) => $_setDouble(8, value);
  @$pb.TagNumber(9)
  $core.bool hasTotalReturnPercent() => $_has(8);
  @$pb.TagNumber(9)
  void clearTotalReturnPercent() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.double get dayChange => $_getN(9);
  @$pb.TagNumber(10)
  set dayChange($core.double value) => $_setDouble(9, value);
  @$pb.TagNumber(10)
  $core.bool hasDayChange() => $_has(9);
  @$pb.TagNumber(10)
  void clearDayChange() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.double get dayChangePercent => $_getN(10);
  @$pb.TagNumber(11)
  set dayChangePercent($core.double value) => $_setDouble(10, value);
  @$pb.TagNumber(11)
  $core.bool hasDayChangePercent() => $_has(10);
  @$pb.TagNumber(11)
  void clearDayChangePercent() => $_clearField(11);

  @$pb.TagNumber(12)
  $1.Timestamp get purchaseDate => $_getN(11);
  @$pb.TagNumber(12)
  set purchaseDate($1.Timestamp value) => $_setField(12, value);
  @$pb.TagNumber(12)
  $core.bool hasPurchaseDate() => $_has(11);
  @$pb.TagNumber(12)
  void clearPurchaseDate() => $_clearField(12);
  @$pb.TagNumber(12)
  $1.Timestamp ensurePurchaseDate() => $_ensure(11);

  @$pb.TagNumber(13)
  $core.String get logoUrl => $_getSZ(12);
  @$pb.TagNumber(13)
  set logoUrl($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasLogoUrl() => $_has(12);
  @$pb.TagNumber(13)
  void clearLogoUrl() => $_clearField(13);
}

class OrderMessage extends $pb.GeneratedMessage {
  factory OrderMessage({
    $core.String? id,
    $core.String? userId,
    $core.String? symbol,
    OrderType? type,
    OrderSide? side,
    $core.int? quantity,
    $core.double? price,
    OrderStatus? status,
    $1.Timestamp? createdAt,
    $1.Timestamp? executedAt,
    $core.double? executedPrice,
    $core.int? executedQuantity,
    $core.double? fees,
    $core.String? notes,
    $core.String? alpacaOrderId,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (userId != null) result.userId = userId;
    if (symbol != null) result.symbol = symbol;
    if (type != null) result.type = type;
    if (side != null) result.side = side;
    if (quantity != null) result.quantity = quantity;
    if (price != null) result.price = price;
    if (status != null) result.status = status;
    if (createdAt != null) result.createdAt = createdAt;
    if (executedAt != null) result.executedAt = executedAt;
    if (executedPrice != null) result.executedPrice = executedPrice;
    if (executedQuantity != null) result.executedQuantity = executedQuantity;
    if (fees != null) result.fees = fees;
    if (notes != null) result.notes = notes;
    if (alpacaOrderId != null) result.alpacaOrderId = alpacaOrderId;
    return result;
  }

  OrderMessage._();

  factory OrderMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory OrderMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'OrderMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'stockspb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'symbol')
    ..e<OrderType>(4, _omitFieldNames ? '' : 'type', $pb.PbFieldType.OE,
        defaultOrMaker: OrderType.ORDER_TYPE_UNSPECIFIED,
        valueOf: OrderType.valueOf,
        enumValues: OrderType.values)
    ..e<OrderSide>(5, _omitFieldNames ? '' : 'side', $pb.PbFieldType.OE,
        defaultOrMaker: OrderSide.ORDER_SIDE_UNSPECIFIED,
        valueOf: OrderSide.valueOf,
        enumValues: OrderSide.values)
    ..a<$core.int>(6, _omitFieldNames ? '' : 'quantity', $pb.PbFieldType.O3)
    ..a<$core.double>(7, _omitFieldNames ? '' : 'price', $pb.PbFieldType.OD)
    ..e<OrderStatus>(8, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: OrderStatus.ORDER_STATUS_UNSPECIFIED,
        valueOf: OrderStatus.valueOf,
        enumValues: OrderStatus.values)
    ..aOM<$1.Timestamp>(9, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(10, _omitFieldNames ? '' : 'executedAt',
        subBuilder: $1.Timestamp.create)
    ..a<$core.double>(
        11, _omitFieldNames ? '' : 'executedPrice', $pb.PbFieldType.OD)
    ..a<$core.int>(
        12, _omitFieldNames ? '' : 'executedQuantity', $pb.PbFieldType.O3)
    ..a<$core.double>(13, _omitFieldNames ? '' : 'fees', $pb.PbFieldType.OD)
    ..aOS(14, _omitFieldNames ? '' : 'notes')
    ..aOS(15, _omitFieldNames ? '' : 'alpacaOrderId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OrderMessage clone() => OrderMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OrderMessage copyWith(void Function(OrderMessage) updates) =>
      super.copyWith((message) => updates(message as OrderMessage))
          as OrderMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static OrderMessage create() => OrderMessage._();
  @$core.override
  OrderMessage createEmptyInstance() => create();
  static $pb.PbList<OrderMessage> createRepeated() =>
      $pb.PbList<OrderMessage>();
  @$core.pragma('dart2js:noInline')
  static OrderMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<OrderMessage>(create);
  static OrderMessage? _defaultInstance;

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
  OrderType get type => $_getN(3);
  @$pb.TagNumber(4)
  set type(OrderType value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasType() => $_has(3);
  @$pb.TagNumber(4)
  void clearType() => $_clearField(4);

  @$pb.TagNumber(5)
  OrderSide get side => $_getN(4);
  @$pb.TagNumber(5)
  set side(OrderSide value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasSide() => $_has(4);
  @$pb.TagNumber(5)
  void clearSide() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get quantity => $_getIZ(5);
  @$pb.TagNumber(6)
  set quantity($core.int value) => $_setSignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasQuantity() => $_has(5);
  @$pb.TagNumber(6)
  void clearQuantity() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.double get price => $_getN(6);
  @$pb.TagNumber(7)
  set price($core.double value) => $_setDouble(6, value);
  @$pb.TagNumber(7)
  $core.bool hasPrice() => $_has(6);
  @$pb.TagNumber(7)
  void clearPrice() => $_clearField(7);

  @$pb.TagNumber(8)
  OrderStatus get status => $_getN(7);
  @$pb.TagNumber(8)
  set status(OrderStatus value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasStatus() => $_has(7);
  @$pb.TagNumber(8)
  void clearStatus() => $_clearField(8);

  @$pb.TagNumber(9)
  $1.Timestamp get createdAt => $_getN(8);
  @$pb.TagNumber(9)
  set createdAt($1.Timestamp value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasCreatedAt() => $_has(8);
  @$pb.TagNumber(9)
  void clearCreatedAt() => $_clearField(9);
  @$pb.TagNumber(9)
  $1.Timestamp ensureCreatedAt() => $_ensure(8);

  @$pb.TagNumber(10)
  $1.Timestamp get executedAt => $_getN(9);
  @$pb.TagNumber(10)
  set executedAt($1.Timestamp value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasExecutedAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearExecutedAt() => $_clearField(10);
  @$pb.TagNumber(10)
  $1.Timestamp ensureExecutedAt() => $_ensure(9);

  @$pb.TagNumber(11)
  $core.double get executedPrice => $_getN(10);
  @$pb.TagNumber(11)
  set executedPrice($core.double value) => $_setDouble(10, value);
  @$pb.TagNumber(11)
  $core.bool hasExecutedPrice() => $_has(10);
  @$pb.TagNumber(11)
  void clearExecutedPrice() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.int get executedQuantity => $_getIZ(11);
  @$pb.TagNumber(12)
  set executedQuantity($core.int value) => $_setSignedInt32(11, value);
  @$pb.TagNumber(12)
  $core.bool hasExecutedQuantity() => $_has(11);
  @$pb.TagNumber(12)
  void clearExecutedQuantity() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.double get fees => $_getN(12);
  @$pb.TagNumber(13)
  set fees($core.double value) => $_setDouble(12, value);
  @$pb.TagNumber(13)
  $core.bool hasFees() => $_has(12);
  @$pb.TagNumber(13)
  void clearFees() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.String get notes => $_getSZ(13);
  @$pb.TagNumber(14)
  set notes($core.String value) => $_setString(13, value);
  @$pb.TagNumber(14)
  $core.bool hasNotes() => $_has(13);
  @$pb.TagNumber(14)
  void clearNotes() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.String get alpacaOrderId => $_getSZ(14);
  @$pb.TagNumber(15)
  set alpacaOrderId($core.String value) => $_setString(14, value);
  @$pb.TagNumber(15)
  $core.bool hasAlpacaOrderId() => $_has(14);
  @$pb.TagNumber(15)
  void clearAlpacaOrderId() => $_clearField(15);
}

class WatchlistMessage extends $pb.GeneratedMessage {
  factory WatchlistMessage({
    $core.String? id,
    $core.String? userId,
    $core.String? name,
    $core.Iterable<WatchlistStockMessage>? stocks,
    $1.Timestamp? createdAt,
    $1.Timestamp? updatedAt,
    $core.bool? isDefault,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (userId != null) result.userId = userId;
    if (name != null) result.name = name;
    if (stocks != null) result.stocks.addAll(stocks);
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    if (isDefault != null) result.isDefault = isDefault;
    return result;
  }

  WatchlistMessage._();

  factory WatchlistMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory WatchlistMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'WatchlistMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'stockspb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'name')
    ..pc<WatchlistStockMessage>(
        4, _omitFieldNames ? '' : 'stocks', $pb.PbFieldType.PM,
        subBuilder: WatchlistStockMessage.create)
    ..aOM<$1.Timestamp>(5, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(6, _omitFieldNames ? '' : 'updatedAt',
        subBuilder: $1.Timestamp.create)
    ..aOB(7, _omitFieldNames ? '' : 'isDefault')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WatchlistMessage clone() => WatchlistMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WatchlistMessage copyWith(void Function(WatchlistMessage) updates) =>
      super.copyWith((message) => updates(message as WatchlistMessage))
          as WatchlistMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WatchlistMessage create() => WatchlistMessage._();
  @$core.override
  WatchlistMessage createEmptyInstance() => create();
  static $pb.PbList<WatchlistMessage> createRepeated() =>
      $pb.PbList<WatchlistMessage>();
  @$core.pragma('dart2js:noInline')
  static WatchlistMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<WatchlistMessage>(create);
  static WatchlistMessage? _defaultInstance;

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
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => $_clearField(3);

  @$pb.TagNumber(4)
  $pb.PbList<WatchlistStockMessage> get stocks => $_getList(3);

  @$pb.TagNumber(5)
  $1.Timestamp get createdAt => $_getN(4);
  @$pb.TagNumber(5)
  set createdAt($1.Timestamp value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasCreatedAt() => $_has(4);
  @$pb.TagNumber(5)
  void clearCreatedAt() => $_clearField(5);
  @$pb.TagNumber(5)
  $1.Timestamp ensureCreatedAt() => $_ensure(4);

  @$pb.TagNumber(6)
  $1.Timestamp get updatedAt => $_getN(5);
  @$pb.TagNumber(6)
  set updatedAt($1.Timestamp value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasUpdatedAt() => $_has(5);
  @$pb.TagNumber(6)
  void clearUpdatedAt() => $_clearField(6);
  @$pb.TagNumber(6)
  $1.Timestamp ensureUpdatedAt() => $_ensure(5);

  @$pb.TagNumber(7)
  $core.bool get isDefault => $_getBF(6);
  @$pb.TagNumber(7)
  set isDefault($core.bool value) => $_setBool(6, value);
  @$pb.TagNumber(7)
  $core.bool hasIsDefault() => $_has(6);
  @$pb.TagNumber(7)
  void clearIsDefault() => $_clearField(7);
}

class WatchlistStockMessage extends $pb.GeneratedMessage {
  factory WatchlistStockMessage({
    $core.String? symbol,
    $core.String? name,
    $core.double? currentPrice,
    $core.double? changePercent,
    $1.Timestamp? addedAt,
  }) {
    final result = create();
    if (symbol != null) result.symbol = symbol;
    if (name != null) result.name = name;
    if (currentPrice != null) result.currentPrice = currentPrice;
    if (changePercent != null) result.changePercent = changePercent;
    if (addedAt != null) result.addedAt = addedAt;
    return result;
  }

  WatchlistStockMessage._();

  factory WatchlistStockMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory WatchlistStockMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'WatchlistStockMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'stockspb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'symbol')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..a<$core.double>(
        3, _omitFieldNames ? '' : 'currentPrice', $pb.PbFieldType.OD)
    ..a<$core.double>(
        4, _omitFieldNames ? '' : 'changePercent', $pb.PbFieldType.OD)
    ..aOM<$1.Timestamp>(5, _omitFieldNames ? '' : 'addedAt',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WatchlistStockMessage clone() =>
      WatchlistStockMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WatchlistStockMessage copyWith(
          void Function(WatchlistStockMessage) updates) =>
      super.copyWith((message) => updates(message as WatchlistStockMessage))
          as WatchlistStockMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WatchlistStockMessage create() => WatchlistStockMessage._();
  @$core.override
  WatchlistStockMessage createEmptyInstance() => create();
  static $pb.PbList<WatchlistStockMessage> createRepeated() =>
      $pb.PbList<WatchlistStockMessage>();
  @$core.pragma('dart2js:noInline')
  static WatchlistStockMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<WatchlistStockMessage>(create);
  static WatchlistStockMessage? _defaultInstance;

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
  $core.double get changePercent => $_getN(3);
  @$pb.TagNumber(4)
  set changePercent($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasChangePercent() => $_has(3);
  @$pb.TagNumber(4)
  void clearChangePercent() => $_clearField(4);

  @$pb.TagNumber(5)
  $1.Timestamp get addedAt => $_getN(4);
  @$pb.TagNumber(5)
  set addedAt($1.Timestamp value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasAddedAt() => $_has(4);
  @$pb.TagNumber(5)
  void clearAddedAt() => $_clearField(5);
  @$pb.TagNumber(5)
  $1.Timestamp ensureAddedAt() => $_ensure(4);
}

class MarketIndexMessage extends $pb.GeneratedMessage {
  factory MarketIndexMessage({
    $core.String? symbol,
    $core.String? name,
    $core.double? value,
    $core.double? change,
    $core.double? changePercent,
    $1.Timestamp? lastUpdated,
  }) {
    final result = create();
    if (symbol != null) result.symbol = symbol;
    if (name != null) result.name = name;
    if (value != null) result.value = value;
    if (change != null) result.change = change;
    if (changePercent != null) result.changePercent = changePercent;
    if (lastUpdated != null) result.lastUpdated = lastUpdated;
    return result;
  }

  MarketIndexMessage._();

  factory MarketIndexMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MarketIndexMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MarketIndexMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'stockspb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'symbol')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'value', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'change', $pb.PbFieldType.OD)
    ..a<$core.double>(
        5, _omitFieldNames ? '' : 'changePercent', $pb.PbFieldType.OD)
    ..aOM<$1.Timestamp>(6, _omitFieldNames ? '' : 'lastUpdated',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MarketIndexMessage clone() => MarketIndexMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MarketIndexMessage copyWith(void Function(MarketIndexMessage) updates) =>
      super.copyWith((message) => updates(message as MarketIndexMessage))
          as MarketIndexMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MarketIndexMessage create() => MarketIndexMessage._();
  @$core.override
  MarketIndexMessage createEmptyInstance() => create();
  static $pb.PbList<MarketIndexMessage> createRepeated() =>
      $pb.PbList<MarketIndexMessage>();
  @$core.pragma('dart2js:noInline')
  static MarketIndexMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MarketIndexMessage>(create);
  static MarketIndexMessage? _defaultInstance;

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
  $core.double get value => $_getN(2);
  @$pb.TagNumber(3)
  set value($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasValue() => $_has(2);
  @$pb.TagNumber(3)
  void clearValue() => $_clearField(3);

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
  $1.Timestamp get lastUpdated => $_getN(5);
  @$pb.TagNumber(6)
  set lastUpdated($1.Timestamp value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasLastUpdated() => $_has(5);
  @$pb.TagNumber(6)
  void clearLastUpdated() => $_clearField(6);
  @$pb.TagNumber(6)
  $1.Timestamp ensureLastUpdated() => $_ensure(5);
}

class StocksPaginationInfo extends $pb.GeneratedMessage {
  factory StocksPaginationInfo({
    $core.int? page,
    $core.int? perPage,
    $core.int? total,
    $core.int? totalPages,
  }) {
    final result = create();
    if (page != null) result.page = page;
    if (perPage != null) result.perPage = perPage;
    if (total != null) result.total = total;
    if (totalPages != null) result.totalPages = totalPages;
    return result;
  }

  StocksPaginationInfo._();

  factory StocksPaginationInfo.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory StocksPaginationInfo.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StocksPaginationInfo',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'stockspb'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'perPage', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'totalPages', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StocksPaginationInfo clone() =>
      StocksPaginationInfo()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StocksPaginationInfo copyWith(void Function(StocksPaginationInfo) updates) =>
      super.copyWith((message) => updates(message as StocksPaginationInfo))
          as StocksPaginationInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StocksPaginationInfo create() => StocksPaginationInfo._();
  @$core.override
  StocksPaginationInfo createEmptyInstance() => create();
  static $pb.PbList<StocksPaginationInfo> createRepeated() =>
      $pb.PbList<StocksPaginationInfo>();
  @$core.pragma('dart2js:noInline')
  static StocksPaginationInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<StocksPaginationInfo>(create);
  static StocksPaginationInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get page => $_getIZ(0);
  @$pb.TagNumber(1)
  set page($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearPage() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get perPage => $_getIZ(1);
  @$pb.TagNumber(2)
  set perPage($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPerPage() => $_has(1);
  @$pb.TagNumber(2)
  void clearPerPage() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get total => $_getIZ(2);
  @$pb.TagNumber(3)
  set total($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTotal() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotal() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get totalPages => $_getIZ(3);
  @$pb.TagNumber(4)
  set totalPages($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTotalPages() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalPages() => $_clearField(4);
}

/// Get Stocks
class GetStocksRequest extends $pb.GeneratedMessage {
  factory GetStocksRequest({
    $core.Iterable<$core.String>? symbols,
    $core.int? page,
    $core.int? perPage,
  }) {
    final result = create();
    if (symbols != null) result.symbols.addAll(symbols);
    if (page != null) result.page = page;
    if (perPage != null) result.perPage = perPage;
    return result;
  }

  GetStocksRequest._();

  factory GetStocksRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetStocksRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetStocksRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'stockspb'),
      createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'symbols')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'perPage', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetStocksRequest clone() => GetStocksRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetStocksRequest copyWith(void Function(GetStocksRequest) updates) =>
      super.copyWith((message) => updates(message as GetStocksRequest))
          as GetStocksRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetStocksRequest create() => GetStocksRequest._();
  @$core.override
  GetStocksRequest createEmptyInstance() => create();
  static $pb.PbList<GetStocksRequest> createRepeated() =>
      $pb.PbList<GetStocksRequest>();
  @$core.pragma('dart2js:noInline')
  static GetStocksRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetStocksRequest>(create);
  static GetStocksRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$core.String> get symbols => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get page => $_getIZ(1);
  @$pb.TagNumber(2)
  set page($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPage() => $_has(1);
  @$pb.TagNumber(2)
  void clearPage() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get perPage => $_getIZ(2);
  @$pb.TagNumber(3)
  set perPage($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPerPage() => $_has(2);
  @$pb.TagNumber(3)
  void clearPerPage() => $_clearField(3);
}

class GetStocksResponse extends $pb.GeneratedMessage {
  factory GetStocksResponse({
    $core.Iterable<StockMessage>? stocks,
    StocksPaginationInfo? pagination,
  }) {
    final result = create();
    if (stocks != null) result.stocks.addAll(stocks);
    if (pagination != null) result.pagination = pagination;
    return result;
  }

  GetStocksResponse._();

  factory GetStocksResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetStocksResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetStocksResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'stockspb'),
      createEmptyInstance: create)
    ..pc<StockMessage>(1, _omitFieldNames ? '' : 'stocks', $pb.PbFieldType.PM,
        subBuilder: StockMessage.create)
    ..aOM<StocksPaginationInfo>(2, _omitFieldNames ? '' : 'pagination',
        subBuilder: StocksPaginationInfo.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetStocksResponse clone() => GetStocksResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetStocksResponse copyWith(void Function(GetStocksResponse) updates) =>
      super.copyWith((message) => updates(message as GetStocksResponse))
          as GetStocksResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetStocksResponse create() => GetStocksResponse._();
  @$core.override
  GetStocksResponse createEmptyInstance() => create();
  static $pb.PbList<GetStocksResponse> createRepeated() =>
      $pb.PbList<GetStocksResponse>();
  @$core.pragma('dart2js:noInline')
  static GetStocksResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetStocksResponse>(create);
  static GetStocksResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<StockMessage> get stocks => $_getList(0);

  @$pb.TagNumber(2)
  StocksPaginationInfo get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination(StocksPaginationInfo value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => $_clearField(2);
  @$pb.TagNumber(2)
  StocksPaginationInfo ensurePagination() => $_ensure(1);
}

/// Get Stock by Symbol
class GetStockRequest extends $pb.GeneratedMessage {
  factory GetStockRequest({
    $core.String? symbol,
  }) {
    final result = create();
    if (symbol != null) result.symbol = symbol;
    return result;
  }

  GetStockRequest._();

  factory GetStockRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetStockRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetStockRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'stockspb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'symbol')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetStockRequest clone() => GetStockRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetStockRequest copyWith(void Function(GetStockRequest) updates) =>
      super.copyWith((message) => updates(message as GetStockRequest))
          as GetStockRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetStockRequest create() => GetStockRequest._();
  @$core.override
  GetStockRequest createEmptyInstance() => create();
  static $pb.PbList<GetStockRequest> createRepeated() =>
      $pb.PbList<GetStockRequest>();
  @$core.pragma('dart2js:noInline')
  static GetStockRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetStockRequest>(create);
  static GetStockRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get symbol => $_getSZ(0);
  @$pb.TagNumber(1)
  set symbol($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSymbol() => $_has(0);
  @$pb.TagNumber(1)
  void clearSymbol() => $_clearField(1);
}

class GetStockResponse extends $pb.GeneratedMessage {
  factory GetStockResponse({
    StockMessage? stock,
  }) {
    final result = create();
    if (stock != null) result.stock = stock;
    return result;
  }

  GetStockResponse._();

  factory GetStockResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetStockResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetStockResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'stockspb'),
      createEmptyInstance: create)
    ..aOM<StockMessage>(1, _omitFieldNames ? '' : 'stock',
        subBuilder: StockMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetStockResponse clone() => GetStockResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetStockResponse copyWith(void Function(GetStockResponse) updates) =>
      super.copyWith((message) => updates(message as GetStockResponse))
          as GetStockResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetStockResponse create() => GetStockResponse._();
  @$core.override
  GetStockResponse createEmptyInstance() => create();
  static $pb.PbList<GetStockResponse> createRepeated() =>
      $pb.PbList<GetStockResponse>();
  @$core.pragma('dart2js:noInline')
  static GetStockResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetStockResponse>(create);
  static GetStockResponse? _defaultInstance;

  @$pb.TagNumber(1)
  StockMessage get stock => $_getN(0);
  @$pb.TagNumber(1)
  set stock(StockMessage value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasStock() => $_has(0);
  @$pb.TagNumber(1)
  void clearStock() => $_clearField(1);
  @$pb.TagNumber(1)
  StockMessage ensureStock() => $_ensure(0);
}

/// Search Stocks
class SearchStocksRequest extends $pb.GeneratedMessage {
  factory SearchStocksRequest({
    $core.String? query,
    $core.int? limit,
    $core.String? market,
  }) {
    final result = create();
    if (query != null) result.query = query;
    if (limit != null) result.limit = limit;
    if (market != null) result.market = market;
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
      package: const $pb.PackageName(_omitMessageNames ? '' : 'stockspb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'query')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..aOS(3, _omitFieldNames ? '' : 'market')
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
  $core.int get limit => $_getIZ(1);
  @$pb.TagNumber(2)
  set limit($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get market => $_getSZ(2);
  @$pb.TagNumber(3)
  set market($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMarket() => $_has(2);
  @$pb.TagNumber(3)
  void clearMarket() => $_clearField(3);
}

class SearchStocksResponse extends $pb.GeneratedMessage {
  factory SearchStocksResponse({
    $core.Iterable<StockMessage>? stocks,
  }) {
    final result = create();
    if (stocks != null) result.stocks.addAll(stocks);
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
      package: const $pb.PackageName(_omitMessageNames ? '' : 'stockspb'),
      createEmptyInstance: create)
    ..pc<StockMessage>(1, _omitFieldNames ? '' : 'stocks', $pb.PbFieldType.PM,
        subBuilder: StockMessage.create)
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
  $pb.PbList<StockMessage> get stocks => $_getList(0);
}

/// Get Stock Price History
class GetStockPriceHistoryRequest extends $pb.GeneratedMessage {
  factory GetStockPriceHistoryRequest({
    $core.String? symbol,
    TimeFrame? timeframe,
    $core.String? interval,
  }) {
    final result = create();
    if (symbol != null) result.symbol = symbol;
    if (timeframe != null) result.timeframe = timeframe;
    if (interval != null) result.interval = interval;
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
      package: const $pb.PackageName(_omitMessageNames ? '' : 'stockspb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'symbol')
    ..e<TimeFrame>(2, _omitFieldNames ? '' : 'timeframe', $pb.PbFieldType.OE,
        defaultOrMaker: TimeFrame.TIME_FRAME_UNSPECIFIED,
        valueOf: TimeFrame.valueOf,
        enumValues: TimeFrame.values)
    ..aOS(3, _omitFieldNames ? '' : 'interval')
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
  TimeFrame get timeframe => $_getN(1);
  @$pb.TagNumber(2)
  set timeframe(TimeFrame value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasTimeframe() => $_has(1);
  @$pb.TagNumber(2)
  void clearTimeframe() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get interval => $_getSZ(2);
  @$pb.TagNumber(3)
  set interval($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasInterval() => $_has(2);
  @$pb.TagNumber(3)
  void clearInterval() => $_clearField(3);
}

class GetStockPriceHistoryResponse extends $pb.GeneratedMessage {
  factory GetStockPriceHistoryResponse({
    $core.String? symbol,
    $core.Iterable<PricePoint>? priceHistory,
    TimeFrame? timeframe,
  }) {
    final result = create();
    if (symbol != null) result.symbol = symbol;
    if (priceHistory != null) result.priceHistory.addAll(priceHistory);
    if (timeframe != null) result.timeframe = timeframe;
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
      package: const $pb.PackageName(_omitMessageNames ? '' : 'stockspb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'symbol')
    ..pc<PricePoint>(
        2, _omitFieldNames ? '' : 'priceHistory', $pb.PbFieldType.PM,
        subBuilder: PricePoint.create)
    ..e<TimeFrame>(3, _omitFieldNames ? '' : 'timeframe', $pb.PbFieldType.OE,
        defaultOrMaker: TimeFrame.TIME_FRAME_UNSPECIFIED,
        valueOf: TimeFrame.valueOf,
        enumValues: TimeFrame.values)
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
  $core.String get symbol => $_getSZ(0);
  @$pb.TagNumber(1)
  set symbol($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSymbol() => $_has(0);
  @$pb.TagNumber(1)
  void clearSymbol() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<PricePoint> get priceHistory => $_getList(1);

  @$pb.TagNumber(3)
  TimeFrame get timeframe => $_getN(2);
  @$pb.TagNumber(3)
  set timeframe(TimeFrame value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasTimeframe() => $_has(2);
  @$pb.TagNumber(3)
  void clearTimeframe() => $_clearField(3);
}

/// Get Market Indices
class GetMarketIndicesRequest extends $pb.GeneratedMessage {
  factory GetMarketIndicesRequest() => create();

  GetMarketIndicesRequest._();

  factory GetMarketIndicesRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMarketIndicesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMarketIndicesRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'stockspb'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMarketIndicesRequest clone() =>
      GetMarketIndicesRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMarketIndicesRequest copyWith(
          void Function(GetMarketIndicesRequest) updates) =>
      super.copyWith((message) => updates(message as GetMarketIndicesRequest))
          as GetMarketIndicesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMarketIndicesRequest create() => GetMarketIndicesRequest._();
  @$core.override
  GetMarketIndicesRequest createEmptyInstance() => create();
  static $pb.PbList<GetMarketIndicesRequest> createRepeated() =>
      $pb.PbList<GetMarketIndicesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMarketIndicesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMarketIndicesRequest>(create);
  static GetMarketIndicesRequest? _defaultInstance;
}

class GetMarketIndicesResponse extends $pb.GeneratedMessage {
  factory GetMarketIndicesResponse({
    $core.Iterable<MarketIndexMessage>? indices,
  }) {
    final result = create();
    if (indices != null) result.indices.addAll(indices);
    return result;
  }

  GetMarketIndicesResponse._();

  factory GetMarketIndicesResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetMarketIndicesResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMarketIndicesResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'stockspb'),
      createEmptyInstance: create)
    ..pc<MarketIndexMessage>(
        1, _omitFieldNames ? '' : 'indices', $pb.PbFieldType.PM,
        subBuilder: MarketIndexMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMarketIndicesResponse clone() =>
      GetMarketIndicesResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMarketIndicesResponse copyWith(
          void Function(GetMarketIndicesResponse) updates) =>
      super.copyWith((message) => updates(message as GetMarketIndicesResponse))
          as GetMarketIndicesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMarketIndicesResponse create() => GetMarketIndicesResponse._();
  @$core.override
  GetMarketIndicesResponse createEmptyInstance() => create();
  static $pb.PbList<GetMarketIndicesResponse> createRepeated() =>
      $pb.PbList<GetMarketIndicesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMarketIndicesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMarketIndicesResponse>(create);
  static GetMarketIndicesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<MarketIndexMessage> get indices => $_getList(0);
}

/// Get Trending Stocks
class GetTrendingStocksRequest extends $pb.GeneratedMessage {
  factory GetTrendingStocksRequest({
    $core.int? limit,
  }) {
    final result = create();
    if (limit != null) result.limit = limit;
    return result;
  }

  GetTrendingStocksRequest._();

  factory GetTrendingStocksRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTrendingStocksRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTrendingStocksRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'stockspb'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTrendingStocksRequest clone() =>
      GetTrendingStocksRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTrendingStocksRequest copyWith(
          void Function(GetTrendingStocksRequest) updates) =>
      super.copyWith((message) => updates(message as GetTrendingStocksRequest))
          as GetTrendingStocksRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTrendingStocksRequest create() => GetTrendingStocksRequest._();
  @$core.override
  GetTrendingStocksRequest createEmptyInstance() => create();
  static $pb.PbList<GetTrendingStocksRequest> createRepeated() =>
      $pb.PbList<GetTrendingStocksRequest>();
  @$core.pragma('dart2js:noInline')
  static GetTrendingStocksRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetTrendingStocksRequest>(create);
  static GetTrendingStocksRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get limit => $_getIZ(0);
  @$pb.TagNumber(1)
  set limit($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasLimit() => $_has(0);
  @$pb.TagNumber(1)
  void clearLimit() => $_clearField(1);
}

class GetTrendingStocksResponse extends $pb.GeneratedMessage {
  factory GetTrendingStocksResponse({
    $core.Iterable<StockMessage>? stocks,
  }) {
    final result = create();
    if (stocks != null) result.stocks.addAll(stocks);
    return result;
  }

  GetTrendingStocksResponse._();

  factory GetTrendingStocksResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTrendingStocksResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTrendingStocksResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'stockspb'),
      createEmptyInstance: create)
    ..pc<StockMessage>(1, _omitFieldNames ? '' : 'stocks', $pb.PbFieldType.PM,
        subBuilder: StockMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTrendingStocksResponse clone() =>
      GetTrendingStocksResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTrendingStocksResponse copyWith(
          void Function(GetTrendingStocksResponse) updates) =>
      super.copyWith((message) => updates(message as GetTrendingStocksResponse))
          as GetTrendingStocksResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTrendingStocksResponse create() => GetTrendingStocksResponse._();
  @$core.override
  GetTrendingStocksResponse createEmptyInstance() => create();
  static $pb.PbList<GetTrendingStocksResponse> createRepeated() =>
      $pb.PbList<GetTrendingStocksResponse>();
  @$core.pragma('dart2js:noInline')
  static GetTrendingStocksResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetTrendingStocksResponse>(create);
  static GetTrendingStocksResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<StockMessage> get stocks => $_getList(0);
}

/// Get Top Gainers
class GetTopGainersRequest extends $pb.GeneratedMessage {
  factory GetTopGainersRequest({
    $core.int? limit,
  }) {
    final result = create();
    if (limit != null) result.limit = limit;
    return result;
  }

  GetTopGainersRequest._();

  factory GetTopGainersRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTopGainersRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTopGainersRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'stockspb'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTopGainersRequest clone() =>
      GetTopGainersRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTopGainersRequest copyWith(void Function(GetTopGainersRequest) updates) =>
      super.copyWith((message) => updates(message as GetTopGainersRequest))
          as GetTopGainersRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTopGainersRequest create() => GetTopGainersRequest._();
  @$core.override
  GetTopGainersRequest createEmptyInstance() => create();
  static $pb.PbList<GetTopGainersRequest> createRepeated() =>
      $pb.PbList<GetTopGainersRequest>();
  @$core.pragma('dart2js:noInline')
  static GetTopGainersRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetTopGainersRequest>(create);
  static GetTopGainersRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get limit => $_getIZ(0);
  @$pb.TagNumber(1)
  set limit($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasLimit() => $_has(0);
  @$pb.TagNumber(1)
  void clearLimit() => $_clearField(1);
}

class GetTopGainersResponse extends $pb.GeneratedMessage {
  factory GetTopGainersResponse({
    $core.Iterable<StockMessage>? stocks,
  }) {
    final result = create();
    if (stocks != null) result.stocks.addAll(stocks);
    return result;
  }

  GetTopGainersResponse._();

  factory GetTopGainersResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTopGainersResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTopGainersResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'stockspb'),
      createEmptyInstance: create)
    ..pc<StockMessage>(1, _omitFieldNames ? '' : 'stocks', $pb.PbFieldType.PM,
        subBuilder: StockMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTopGainersResponse clone() =>
      GetTopGainersResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTopGainersResponse copyWith(
          void Function(GetTopGainersResponse) updates) =>
      super.copyWith((message) => updates(message as GetTopGainersResponse))
          as GetTopGainersResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTopGainersResponse create() => GetTopGainersResponse._();
  @$core.override
  GetTopGainersResponse createEmptyInstance() => create();
  static $pb.PbList<GetTopGainersResponse> createRepeated() =>
      $pb.PbList<GetTopGainersResponse>();
  @$core.pragma('dart2js:noInline')
  static GetTopGainersResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetTopGainersResponse>(create);
  static GetTopGainersResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<StockMessage> get stocks => $_getList(0);
}

/// Get Top Losers
class GetTopLosersRequest extends $pb.GeneratedMessage {
  factory GetTopLosersRequest({
    $core.int? limit,
  }) {
    final result = create();
    if (limit != null) result.limit = limit;
    return result;
  }

  GetTopLosersRequest._();

  factory GetTopLosersRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTopLosersRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTopLosersRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'stockspb'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTopLosersRequest clone() => GetTopLosersRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTopLosersRequest copyWith(void Function(GetTopLosersRequest) updates) =>
      super.copyWith((message) => updates(message as GetTopLosersRequest))
          as GetTopLosersRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTopLosersRequest create() => GetTopLosersRequest._();
  @$core.override
  GetTopLosersRequest createEmptyInstance() => create();
  static $pb.PbList<GetTopLosersRequest> createRepeated() =>
      $pb.PbList<GetTopLosersRequest>();
  @$core.pragma('dart2js:noInline')
  static GetTopLosersRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetTopLosersRequest>(create);
  static GetTopLosersRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get limit => $_getIZ(0);
  @$pb.TagNumber(1)
  set limit($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasLimit() => $_has(0);
  @$pb.TagNumber(1)
  void clearLimit() => $_clearField(1);
}

class GetTopLosersResponse extends $pb.GeneratedMessage {
  factory GetTopLosersResponse({
    $core.Iterable<StockMessage>? stocks,
  }) {
    final result = create();
    if (stocks != null) result.stocks.addAll(stocks);
    return result;
  }

  GetTopLosersResponse._();

  factory GetTopLosersResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTopLosersResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTopLosersResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'stockspb'),
      createEmptyInstance: create)
    ..pc<StockMessage>(1, _omitFieldNames ? '' : 'stocks', $pb.PbFieldType.PM,
        subBuilder: StockMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTopLosersResponse clone() =>
      GetTopLosersResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTopLosersResponse copyWith(void Function(GetTopLosersResponse) updates) =>
      super.copyWith((message) => updates(message as GetTopLosersResponse))
          as GetTopLosersResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTopLosersResponse create() => GetTopLosersResponse._();
  @$core.override
  GetTopLosersResponse createEmptyInstance() => create();
  static $pb.PbList<GetTopLosersResponse> createRepeated() =>
      $pb.PbList<GetTopLosersResponse>();
  @$core.pragma('dart2js:noInline')
  static GetTopLosersResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetTopLosersResponse>(create);
  static GetTopLosersResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<StockMessage> get stocks => $_getList(0);
}

/// Get User Portfolio
class GetUserPortfolioRequest extends $pb.GeneratedMessage {
  factory GetUserPortfolioRequest() => create();

  GetUserPortfolioRequest._();

  factory GetUserPortfolioRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetUserPortfolioRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUserPortfolioRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'stockspb'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserPortfolioRequest clone() =>
      GetUserPortfolioRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserPortfolioRequest copyWith(
          void Function(GetUserPortfolioRequest) updates) =>
      super.copyWith((message) => updates(message as GetUserPortfolioRequest))
          as GetUserPortfolioRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserPortfolioRequest create() => GetUserPortfolioRequest._();
  @$core.override
  GetUserPortfolioRequest createEmptyInstance() => create();
  static $pb.PbList<GetUserPortfolioRequest> createRepeated() =>
      $pb.PbList<GetUserPortfolioRequest>();
  @$core.pragma('dart2js:noInline')
  static GetUserPortfolioRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUserPortfolioRequest>(create);
  static GetUserPortfolioRequest? _defaultInstance;
}

class GetUserPortfolioResponse extends $pb.GeneratedMessage {
  factory GetUserPortfolioResponse({
    PortfolioMessage? portfolio,
  }) {
    final result = create();
    if (portfolio != null) result.portfolio = portfolio;
    return result;
  }

  GetUserPortfolioResponse._();

  factory GetUserPortfolioResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetUserPortfolioResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUserPortfolioResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'stockspb'),
      createEmptyInstance: create)
    ..aOM<PortfolioMessage>(1, _omitFieldNames ? '' : 'portfolio',
        subBuilder: PortfolioMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserPortfolioResponse clone() =>
      GetUserPortfolioResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserPortfolioResponse copyWith(
          void Function(GetUserPortfolioResponse) updates) =>
      super.copyWith((message) => updates(message as GetUserPortfolioResponse))
          as GetUserPortfolioResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserPortfolioResponse create() => GetUserPortfolioResponse._();
  @$core.override
  GetUserPortfolioResponse createEmptyInstance() => create();
  static $pb.PbList<GetUserPortfolioResponse> createRepeated() =>
      $pb.PbList<GetUserPortfolioResponse>();
  @$core.pragma('dart2js:noInline')
  static GetUserPortfolioResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUserPortfolioResponse>(create);
  static GetUserPortfolioResponse? _defaultInstance;

  @$pb.TagNumber(1)
  PortfolioMessage get portfolio => $_getN(0);
  @$pb.TagNumber(1)
  set portfolio(PortfolioMessage value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasPortfolio() => $_has(0);
  @$pb.TagNumber(1)
  void clearPortfolio() => $_clearField(1);
  @$pb.TagNumber(1)
  PortfolioMessage ensurePortfolio() => $_ensure(0);
}

/// Get Portfolio Holdings
class GetPortfolioHoldingsRequest extends $pb.GeneratedMessage {
  factory GetPortfolioHoldingsRequest() => create();

  GetPortfolioHoldingsRequest._();

  factory GetPortfolioHoldingsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetPortfolioHoldingsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetPortfolioHoldingsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'stockspb'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPortfolioHoldingsRequest clone() =>
      GetPortfolioHoldingsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPortfolioHoldingsRequest copyWith(
          void Function(GetPortfolioHoldingsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetPortfolioHoldingsRequest))
          as GetPortfolioHoldingsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPortfolioHoldingsRequest create() =>
      GetPortfolioHoldingsRequest._();
  @$core.override
  GetPortfolioHoldingsRequest createEmptyInstance() => create();
  static $pb.PbList<GetPortfolioHoldingsRequest> createRepeated() =>
      $pb.PbList<GetPortfolioHoldingsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetPortfolioHoldingsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetPortfolioHoldingsRequest>(create);
  static GetPortfolioHoldingsRequest? _defaultInstance;
}

class GetPortfolioHoldingsResponse extends $pb.GeneratedMessage {
  factory GetPortfolioHoldingsResponse({
    $core.Iterable<HoldingMessage>? holdings,
  }) {
    final result = create();
    if (holdings != null) result.holdings.addAll(holdings);
    return result;
  }

  GetPortfolioHoldingsResponse._();

  factory GetPortfolioHoldingsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetPortfolioHoldingsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetPortfolioHoldingsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'stockspb'),
      createEmptyInstance: create)
    ..pc<HoldingMessage>(
        1, _omitFieldNames ? '' : 'holdings', $pb.PbFieldType.PM,
        subBuilder: HoldingMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPortfolioHoldingsResponse clone() =>
      GetPortfolioHoldingsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPortfolioHoldingsResponse copyWith(
          void Function(GetPortfolioHoldingsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetPortfolioHoldingsResponse))
          as GetPortfolioHoldingsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPortfolioHoldingsResponse create() =>
      GetPortfolioHoldingsResponse._();
  @$core.override
  GetPortfolioHoldingsResponse createEmptyInstance() => create();
  static $pb.PbList<GetPortfolioHoldingsResponse> createRepeated() =>
      $pb.PbList<GetPortfolioHoldingsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetPortfolioHoldingsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetPortfolioHoldingsResponse>(create);
  static GetPortfolioHoldingsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<HoldingMessage> get holdings => $_getList(0);
}

/// Get Portfolio Performance
class GetPortfolioPerformanceRequest extends $pb.GeneratedMessage {
  factory GetPortfolioPerformanceRequest({
    TimeFrame? timeframe,
  }) {
    final result = create();
    if (timeframe != null) result.timeframe = timeframe;
    return result;
  }

  GetPortfolioPerformanceRequest._();

  factory GetPortfolioPerformanceRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetPortfolioPerformanceRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetPortfolioPerformanceRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'stockspb'),
      createEmptyInstance: create)
    ..e<TimeFrame>(1, _omitFieldNames ? '' : 'timeframe', $pb.PbFieldType.OE,
        defaultOrMaker: TimeFrame.TIME_FRAME_UNSPECIFIED,
        valueOf: TimeFrame.valueOf,
        enumValues: TimeFrame.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPortfolioPerformanceRequest clone() =>
      GetPortfolioPerformanceRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPortfolioPerformanceRequest copyWith(
          void Function(GetPortfolioPerformanceRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetPortfolioPerformanceRequest))
          as GetPortfolioPerformanceRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPortfolioPerformanceRequest create() =>
      GetPortfolioPerformanceRequest._();
  @$core.override
  GetPortfolioPerformanceRequest createEmptyInstance() => create();
  static $pb.PbList<GetPortfolioPerformanceRequest> createRepeated() =>
      $pb.PbList<GetPortfolioPerformanceRequest>();
  @$core.pragma('dart2js:noInline')
  static GetPortfolioPerformanceRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetPortfolioPerformanceRequest>(create);
  static GetPortfolioPerformanceRequest? _defaultInstance;

  @$pb.TagNumber(1)
  TimeFrame get timeframe => $_getN(0);
  @$pb.TagNumber(1)
  set timeframe(TimeFrame value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasTimeframe() => $_has(0);
  @$pb.TagNumber(1)
  void clearTimeframe() => $_clearField(1);
}

class GetPortfolioPerformanceResponse extends $pb.GeneratedMessage {
  factory GetPortfolioPerformanceResponse({
    $core.Iterable<PricePoint>? performanceData,
    $core.double? totalReturn,
    $core.double? totalReturnPercent,
  }) {
    final result = create();
    if (performanceData != null) result.performanceData.addAll(performanceData);
    if (totalReturn != null) result.totalReturn = totalReturn;
    if (totalReturnPercent != null)
      result.totalReturnPercent = totalReturnPercent;
    return result;
  }

  GetPortfolioPerformanceResponse._();

  factory GetPortfolioPerformanceResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetPortfolioPerformanceResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetPortfolioPerformanceResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'stockspb'),
      createEmptyInstance: create)
    ..pc<PricePoint>(
        1, _omitFieldNames ? '' : 'performanceData', $pb.PbFieldType.PM,
        subBuilder: PricePoint.create)
    ..a<$core.double>(
        2, _omitFieldNames ? '' : 'totalReturn', $pb.PbFieldType.OD)
    ..a<$core.double>(
        3, _omitFieldNames ? '' : 'totalReturnPercent', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPortfolioPerformanceResponse clone() =>
      GetPortfolioPerformanceResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPortfolioPerformanceResponse copyWith(
          void Function(GetPortfolioPerformanceResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GetPortfolioPerformanceResponse))
          as GetPortfolioPerformanceResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPortfolioPerformanceResponse create() =>
      GetPortfolioPerformanceResponse._();
  @$core.override
  GetPortfolioPerformanceResponse createEmptyInstance() => create();
  static $pb.PbList<GetPortfolioPerformanceResponse> createRepeated() =>
      $pb.PbList<GetPortfolioPerformanceResponse>();
  @$core.pragma('dart2js:noInline')
  static GetPortfolioPerformanceResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetPortfolioPerformanceResponse>(
          create);
  static GetPortfolioPerformanceResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<PricePoint> get performanceData => $_getList(0);

  @$pb.TagNumber(2)
  $core.double get totalReturn => $_getN(1);
  @$pb.TagNumber(2)
  set totalReturn($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotalReturn() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalReturn() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get totalReturnPercent => $_getN(2);
  @$pb.TagNumber(3)
  set totalReturnPercent($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTotalReturnPercent() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalReturnPercent() => $_clearField(3);
}

/// Update Portfolio Cash
class UpdatePortfolioCashRequest extends $pb.GeneratedMessage {
  factory UpdatePortfolioCashRequest({
    $core.double? amount,
    $core.String? notes,
  }) {
    final result = create();
    if (amount != null) result.amount = amount;
    if (notes != null) result.notes = notes;
    return result;
  }

  UpdatePortfolioCashRequest._();

  factory UpdatePortfolioCashRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdatePortfolioCashRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdatePortfolioCashRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'stockspb'),
      createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(2, _omitFieldNames ? '' : 'notes')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdatePortfolioCashRequest clone() =>
      UpdatePortfolioCashRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdatePortfolioCashRequest copyWith(
          void Function(UpdatePortfolioCashRequest) updates) =>
      super.copyWith(
              (message) => updates(message as UpdatePortfolioCashRequest))
          as UpdatePortfolioCashRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdatePortfolioCashRequest create() => UpdatePortfolioCashRequest._();
  @$core.override
  UpdatePortfolioCashRequest createEmptyInstance() => create();
  static $pb.PbList<UpdatePortfolioCashRequest> createRepeated() =>
      $pb.PbList<UpdatePortfolioCashRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdatePortfolioCashRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdatePortfolioCashRequest>(create);
  static UpdatePortfolioCashRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get amount => $_getN(0);
  @$pb.TagNumber(1)
  set amount($core.double value) => $_setDouble(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAmount() => $_has(0);
  @$pb.TagNumber(1)
  void clearAmount() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get notes => $_getSZ(1);
  @$pb.TagNumber(2)
  set notes($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNotes() => $_has(1);
  @$pb.TagNumber(2)
  void clearNotes() => $_clearField(2);
}

class UpdatePortfolioCashResponse extends $pb.GeneratedMessage {
  factory UpdatePortfolioCashResponse({
    PortfolioMessage? portfolio,
    $core.String? message,
  }) {
    final result = create();
    if (portfolio != null) result.portfolio = portfolio;
    if (message != null) result.message = message;
    return result;
  }

  UpdatePortfolioCashResponse._();

  factory UpdatePortfolioCashResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdatePortfolioCashResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdatePortfolioCashResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'stockspb'),
      createEmptyInstance: create)
    ..aOM<PortfolioMessage>(1, _omitFieldNames ? '' : 'portfolio',
        subBuilder: PortfolioMessage.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdatePortfolioCashResponse clone() =>
      UpdatePortfolioCashResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdatePortfolioCashResponse copyWith(
          void Function(UpdatePortfolioCashResponse) updates) =>
      super.copyWith(
              (message) => updates(message as UpdatePortfolioCashResponse))
          as UpdatePortfolioCashResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdatePortfolioCashResponse create() =>
      UpdatePortfolioCashResponse._();
  @$core.override
  UpdatePortfolioCashResponse createEmptyInstance() => create();
  static $pb.PbList<UpdatePortfolioCashResponse> createRepeated() =>
      $pb.PbList<UpdatePortfolioCashResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdatePortfolioCashResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdatePortfolioCashResponse>(create);
  static UpdatePortfolioCashResponse? _defaultInstance;

  @$pb.TagNumber(1)
  PortfolioMessage get portfolio => $_getN(0);
  @$pb.TagNumber(1)
  set portfolio(PortfolioMessage value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasPortfolio() => $_has(0);
  @$pb.TagNumber(1)
  void clearPortfolio() => $_clearField(1);
  @$pb.TagNumber(1)
  PortfolioMessage ensurePortfolio() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);
}

/// Place Order
class PlaceOrderRequest extends $pb.GeneratedMessage {
  factory PlaceOrderRequest({
    $core.String? symbol,
    OrderType? type,
    OrderSide? side,
    $core.int? quantity,
    $core.double? price,
    $core.String? notes,
  }) {
    final result = create();
    if (symbol != null) result.symbol = symbol;
    if (type != null) result.type = type;
    if (side != null) result.side = side;
    if (quantity != null) result.quantity = quantity;
    if (price != null) result.price = price;
    if (notes != null) result.notes = notes;
    return result;
  }

  PlaceOrderRequest._();

  factory PlaceOrderRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PlaceOrderRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PlaceOrderRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'stockspb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'symbol')
    ..e<OrderType>(2, _omitFieldNames ? '' : 'type', $pb.PbFieldType.OE,
        defaultOrMaker: OrderType.ORDER_TYPE_UNSPECIFIED,
        valueOf: OrderType.valueOf,
        enumValues: OrderType.values)
    ..e<OrderSide>(3, _omitFieldNames ? '' : 'side', $pb.PbFieldType.OE,
        defaultOrMaker: OrderSide.ORDER_SIDE_UNSPECIFIED,
        valueOf: OrderSide.valueOf,
        enumValues: OrderSide.values)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'quantity', $pb.PbFieldType.O3)
    ..a<$core.double>(5, _omitFieldNames ? '' : 'price', $pb.PbFieldType.OD)
    ..aOS(6, _omitFieldNames ? '' : 'notes')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PlaceOrderRequest clone() => PlaceOrderRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PlaceOrderRequest copyWith(void Function(PlaceOrderRequest) updates) =>
      super.copyWith((message) => updates(message as PlaceOrderRequest))
          as PlaceOrderRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PlaceOrderRequest create() => PlaceOrderRequest._();
  @$core.override
  PlaceOrderRequest createEmptyInstance() => create();
  static $pb.PbList<PlaceOrderRequest> createRepeated() =>
      $pb.PbList<PlaceOrderRequest>();
  @$core.pragma('dart2js:noInline')
  static PlaceOrderRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PlaceOrderRequest>(create);
  static PlaceOrderRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get symbol => $_getSZ(0);
  @$pb.TagNumber(1)
  set symbol($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSymbol() => $_has(0);
  @$pb.TagNumber(1)
  void clearSymbol() => $_clearField(1);

  @$pb.TagNumber(2)
  OrderType get type => $_getN(1);
  @$pb.TagNumber(2)
  set type(OrderType value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasType() => $_has(1);
  @$pb.TagNumber(2)
  void clearType() => $_clearField(2);

  @$pb.TagNumber(3)
  OrderSide get side => $_getN(2);
  @$pb.TagNumber(3)
  set side(OrderSide value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasSide() => $_has(2);
  @$pb.TagNumber(3)
  void clearSide() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get quantity => $_getIZ(3);
  @$pb.TagNumber(4)
  set quantity($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasQuantity() => $_has(3);
  @$pb.TagNumber(4)
  void clearQuantity() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get price => $_getN(4);
  @$pb.TagNumber(5)
  set price($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasPrice() => $_has(4);
  @$pb.TagNumber(5)
  void clearPrice() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get notes => $_getSZ(5);
  @$pb.TagNumber(6)
  set notes($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasNotes() => $_has(5);
  @$pb.TagNumber(6)
  void clearNotes() => $_clearField(6);
}

class PlaceOrderResponse extends $pb.GeneratedMessage {
  factory PlaceOrderResponse({
    OrderMessage? order,
    $core.String? message,
  }) {
    final result = create();
    if (order != null) result.order = order;
    if (message != null) result.message = message;
    return result;
  }

  PlaceOrderResponse._();

  factory PlaceOrderResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PlaceOrderResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PlaceOrderResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'stockspb'),
      createEmptyInstance: create)
    ..aOM<OrderMessage>(1, _omitFieldNames ? '' : 'order',
        subBuilder: OrderMessage.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PlaceOrderResponse clone() => PlaceOrderResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PlaceOrderResponse copyWith(void Function(PlaceOrderResponse) updates) =>
      super.copyWith((message) => updates(message as PlaceOrderResponse))
          as PlaceOrderResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PlaceOrderResponse create() => PlaceOrderResponse._();
  @$core.override
  PlaceOrderResponse createEmptyInstance() => create();
  static $pb.PbList<PlaceOrderResponse> createRepeated() =>
      $pb.PbList<PlaceOrderResponse>();
  @$core.pragma('dart2js:noInline')
  static PlaceOrderResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PlaceOrderResponse>(create);
  static PlaceOrderResponse? _defaultInstance;

  @$pb.TagNumber(1)
  OrderMessage get order => $_getN(0);
  @$pb.TagNumber(1)
  set order(OrderMessage value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasOrder() => $_has(0);
  @$pb.TagNumber(1)
  void clearOrder() => $_clearField(1);
  @$pb.TagNumber(1)
  OrderMessage ensureOrder() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);
}

/// Get User Orders
class GetUserOrdersRequest extends $pb.GeneratedMessage {
  factory GetUserOrdersRequest({
    OrderStatus? status,
    $core.int? page,
    $core.int? perPage,
  }) {
    final result = create();
    if (status != null) result.status = status;
    if (page != null) result.page = page;
    if (perPage != null) result.perPage = perPage;
    return result;
  }

  GetUserOrdersRequest._();

  factory GetUserOrdersRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetUserOrdersRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUserOrdersRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'stockspb'),
      createEmptyInstance: create)
    ..e<OrderStatus>(1, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: OrderStatus.ORDER_STATUS_UNSPECIFIED,
        valueOf: OrderStatus.valueOf,
        enumValues: OrderStatus.values)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'perPage', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserOrdersRequest clone() =>
      GetUserOrdersRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserOrdersRequest copyWith(void Function(GetUserOrdersRequest) updates) =>
      super.copyWith((message) => updates(message as GetUserOrdersRequest))
          as GetUserOrdersRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserOrdersRequest create() => GetUserOrdersRequest._();
  @$core.override
  GetUserOrdersRequest createEmptyInstance() => create();
  static $pb.PbList<GetUserOrdersRequest> createRepeated() =>
      $pb.PbList<GetUserOrdersRequest>();
  @$core.pragma('dart2js:noInline')
  static GetUserOrdersRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUserOrdersRequest>(create);
  static GetUserOrdersRequest? _defaultInstance;

  @$pb.TagNumber(1)
  OrderStatus get status => $_getN(0);
  @$pb.TagNumber(1)
  set status(OrderStatus value) => $_setField(1, value);
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
  $core.int get perPage => $_getIZ(2);
  @$pb.TagNumber(3)
  set perPage($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPerPage() => $_has(2);
  @$pb.TagNumber(3)
  void clearPerPage() => $_clearField(3);
}

class GetUserOrdersResponse extends $pb.GeneratedMessage {
  factory GetUserOrdersResponse({
    $core.Iterable<OrderMessage>? orders,
    StocksPaginationInfo? pagination,
  }) {
    final result = create();
    if (orders != null) result.orders.addAll(orders);
    if (pagination != null) result.pagination = pagination;
    return result;
  }

  GetUserOrdersResponse._();

  factory GetUserOrdersResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetUserOrdersResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUserOrdersResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'stockspb'),
      createEmptyInstance: create)
    ..pc<OrderMessage>(1, _omitFieldNames ? '' : 'orders', $pb.PbFieldType.PM,
        subBuilder: OrderMessage.create)
    ..aOM<StocksPaginationInfo>(2, _omitFieldNames ? '' : 'pagination',
        subBuilder: StocksPaginationInfo.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserOrdersResponse clone() =>
      GetUserOrdersResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserOrdersResponse copyWith(
          void Function(GetUserOrdersResponse) updates) =>
      super.copyWith((message) => updates(message as GetUserOrdersResponse))
          as GetUserOrdersResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserOrdersResponse create() => GetUserOrdersResponse._();
  @$core.override
  GetUserOrdersResponse createEmptyInstance() => create();
  static $pb.PbList<GetUserOrdersResponse> createRepeated() =>
      $pb.PbList<GetUserOrdersResponse>();
  @$core.pragma('dart2js:noInline')
  static GetUserOrdersResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUserOrdersResponse>(create);
  static GetUserOrdersResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<OrderMessage> get orders => $_getList(0);

  @$pb.TagNumber(2)
  StocksPaginationInfo get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination(StocksPaginationInfo value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => $_clearField(2);
  @$pb.TagNumber(2)
  StocksPaginationInfo ensurePagination() => $_ensure(1);
}

/// Get Order by ID
class GetOrderRequest extends $pb.GeneratedMessage {
  factory GetOrderRequest({
    $core.String? orderId,
  }) {
    final result = create();
    if (orderId != null) result.orderId = orderId;
    return result;
  }

  GetOrderRequest._();

  factory GetOrderRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetOrderRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetOrderRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'stockspb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'orderId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetOrderRequest clone() => GetOrderRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetOrderRequest copyWith(void Function(GetOrderRequest) updates) =>
      super.copyWith((message) => updates(message as GetOrderRequest))
          as GetOrderRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetOrderRequest create() => GetOrderRequest._();
  @$core.override
  GetOrderRequest createEmptyInstance() => create();
  static $pb.PbList<GetOrderRequest> createRepeated() =>
      $pb.PbList<GetOrderRequest>();
  @$core.pragma('dart2js:noInline')
  static GetOrderRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetOrderRequest>(create);
  static GetOrderRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get orderId => $_getSZ(0);
  @$pb.TagNumber(1)
  set orderId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasOrderId() => $_has(0);
  @$pb.TagNumber(1)
  void clearOrderId() => $_clearField(1);
}

class GetOrderResponse extends $pb.GeneratedMessage {
  factory GetOrderResponse({
    OrderMessage? order,
  }) {
    final result = create();
    if (order != null) result.order = order;
    return result;
  }

  GetOrderResponse._();

  factory GetOrderResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetOrderResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetOrderResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'stockspb'),
      createEmptyInstance: create)
    ..aOM<OrderMessage>(1, _omitFieldNames ? '' : 'order',
        subBuilder: OrderMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetOrderResponse clone() => GetOrderResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetOrderResponse copyWith(void Function(GetOrderResponse) updates) =>
      super.copyWith((message) => updates(message as GetOrderResponse))
          as GetOrderResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetOrderResponse create() => GetOrderResponse._();
  @$core.override
  GetOrderResponse createEmptyInstance() => create();
  static $pb.PbList<GetOrderResponse> createRepeated() =>
      $pb.PbList<GetOrderResponse>();
  @$core.pragma('dart2js:noInline')
  static GetOrderResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetOrderResponse>(create);
  static GetOrderResponse? _defaultInstance;

  @$pb.TagNumber(1)
  OrderMessage get order => $_getN(0);
  @$pb.TagNumber(1)
  set order(OrderMessage value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasOrder() => $_has(0);
  @$pb.TagNumber(1)
  void clearOrder() => $_clearField(1);
  @$pb.TagNumber(1)
  OrderMessage ensureOrder() => $_ensure(0);
}

/// Cancel Order
class CancelOrderRequest extends $pb.GeneratedMessage {
  factory CancelOrderRequest({
    $core.String? orderId,
  }) {
    final result = create();
    if (orderId != null) result.orderId = orderId;
    return result;
  }

  CancelOrderRequest._();

  factory CancelOrderRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CancelOrderRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CancelOrderRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'stockspb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'orderId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CancelOrderRequest clone() => CancelOrderRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CancelOrderRequest copyWith(void Function(CancelOrderRequest) updates) =>
      super.copyWith((message) => updates(message as CancelOrderRequest))
          as CancelOrderRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CancelOrderRequest create() => CancelOrderRequest._();
  @$core.override
  CancelOrderRequest createEmptyInstance() => create();
  static $pb.PbList<CancelOrderRequest> createRepeated() =>
      $pb.PbList<CancelOrderRequest>();
  @$core.pragma('dart2js:noInline')
  static CancelOrderRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CancelOrderRequest>(create);
  static CancelOrderRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get orderId => $_getSZ(0);
  @$pb.TagNumber(1)
  set orderId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasOrderId() => $_has(0);
  @$pb.TagNumber(1)
  void clearOrderId() => $_clearField(1);
}

class CancelOrderResponse extends $pb.GeneratedMessage {
  factory CancelOrderResponse({
    OrderMessage? order,
    $core.String? message,
  }) {
    final result = create();
    if (order != null) result.order = order;
    if (message != null) result.message = message;
    return result;
  }

  CancelOrderResponse._();

  factory CancelOrderResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CancelOrderResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CancelOrderResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'stockspb'),
      createEmptyInstance: create)
    ..aOM<OrderMessage>(1, _omitFieldNames ? '' : 'order',
        subBuilder: OrderMessage.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CancelOrderResponse clone() => CancelOrderResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CancelOrderResponse copyWith(void Function(CancelOrderResponse) updates) =>
      super.copyWith((message) => updates(message as CancelOrderResponse))
          as CancelOrderResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CancelOrderResponse create() => CancelOrderResponse._();
  @$core.override
  CancelOrderResponse createEmptyInstance() => create();
  static $pb.PbList<CancelOrderResponse> createRepeated() =>
      $pb.PbList<CancelOrderResponse>();
  @$core.pragma('dart2js:noInline')
  static CancelOrderResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CancelOrderResponse>(create);
  static CancelOrderResponse? _defaultInstance;

  @$pb.TagNumber(1)
  OrderMessage get order => $_getN(0);
  @$pb.TagNumber(1)
  set order(OrderMessage value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasOrder() => $_has(0);
  @$pb.TagNumber(1)
  void clearOrder() => $_clearField(1);
  @$pb.TagNumber(1)
  OrderMessage ensureOrder() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);
}

/// Get Order History
class GetOrderHistoryRequest extends $pb.GeneratedMessage {
  factory GetOrderHistoryRequest({
    $core.String? symbol,
    $core.int? days,
    $core.int? page,
    $core.int? perPage,
  }) {
    final result = create();
    if (symbol != null) result.symbol = symbol;
    if (days != null) result.days = days;
    if (page != null) result.page = page;
    if (perPage != null) result.perPage = perPage;
    return result;
  }

  GetOrderHistoryRequest._();

  factory GetOrderHistoryRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetOrderHistoryRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetOrderHistoryRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'stockspb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'symbol')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'days', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'perPage', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetOrderHistoryRequest clone() =>
      GetOrderHistoryRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetOrderHistoryRequest copyWith(
          void Function(GetOrderHistoryRequest) updates) =>
      super.copyWith((message) => updates(message as GetOrderHistoryRequest))
          as GetOrderHistoryRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetOrderHistoryRequest create() => GetOrderHistoryRequest._();
  @$core.override
  GetOrderHistoryRequest createEmptyInstance() => create();
  static $pb.PbList<GetOrderHistoryRequest> createRepeated() =>
      $pb.PbList<GetOrderHistoryRequest>();
  @$core.pragma('dart2js:noInline')
  static GetOrderHistoryRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetOrderHistoryRequest>(create);
  static GetOrderHistoryRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get symbol => $_getSZ(0);
  @$pb.TagNumber(1)
  set symbol($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSymbol() => $_has(0);
  @$pb.TagNumber(1)
  void clearSymbol() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get days => $_getIZ(1);
  @$pb.TagNumber(2)
  set days($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDays() => $_has(1);
  @$pb.TagNumber(2)
  void clearDays() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get page => $_getIZ(2);
  @$pb.TagNumber(3)
  set page($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPage() => $_has(2);
  @$pb.TagNumber(3)
  void clearPage() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get perPage => $_getIZ(3);
  @$pb.TagNumber(4)
  set perPage($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPerPage() => $_has(3);
  @$pb.TagNumber(4)
  void clearPerPage() => $_clearField(4);
}

class GetOrderHistoryResponse extends $pb.GeneratedMessage {
  factory GetOrderHistoryResponse({
    $core.Iterable<OrderMessage>? orders,
    StocksPaginationInfo? pagination,
  }) {
    final result = create();
    if (orders != null) result.orders.addAll(orders);
    if (pagination != null) result.pagination = pagination;
    return result;
  }

  GetOrderHistoryResponse._();

  factory GetOrderHistoryResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetOrderHistoryResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetOrderHistoryResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'stockspb'),
      createEmptyInstance: create)
    ..pc<OrderMessage>(1, _omitFieldNames ? '' : 'orders', $pb.PbFieldType.PM,
        subBuilder: OrderMessage.create)
    ..aOM<StocksPaginationInfo>(2, _omitFieldNames ? '' : 'pagination',
        subBuilder: StocksPaginationInfo.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetOrderHistoryResponse clone() =>
      GetOrderHistoryResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetOrderHistoryResponse copyWith(
          void Function(GetOrderHistoryResponse) updates) =>
      super.copyWith((message) => updates(message as GetOrderHistoryResponse))
          as GetOrderHistoryResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetOrderHistoryResponse create() => GetOrderHistoryResponse._();
  @$core.override
  GetOrderHistoryResponse createEmptyInstance() => create();
  static $pb.PbList<GetOrderHistoryResponse> createRepeated() =>
      $pb.PbList<GetOrderHistoryResponse>();
  @$core.pragma('dart2js:noInline')
  static GetOrderHistoryResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetOrderHistoryResponse>(create);
  static GetOrderHistoryResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<OrderMessage> get orders => $_getList(0);

  @$pb.TagNumber(2)
  StocksPaginationInfo get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination(StocksPaginationInfo value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => $_clearField(2);
  @$pb.TagNumber(2)
  StocksPaginationInfo ensurePagination() => $_ensure(1);
}

/// Create Watchlist
class CreateWatchlistRequest extends $pb.GeneratedMessage {
  factory CreateWatchlistRequest({
    $core.String? name,
    $core.Iterable<$core.String>? symbols,
    $core.bool? isDefault,
  }) {
    final result = create();
    if (name != null) result.name = name;
    if (symbols != null) result.symbols.addAll(symbols);
    if (isDefault != null) result.isDefault = isDefault;
    return result;
  }

  CreateWatchlistRequest._();

  factory CreateWatchlistRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateWatchlistRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateWatchlistRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'stockspb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..pPS(2, _omitFieldNames ? '' : 'symbols')
    ..aOB(3, _omitFieldNames ? '' : 'isDefault')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateWatchlistRequest clone() =>
      CreateWatchlistRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateWatchlistRequest copyWith(
          void Function(CreateWatchlistRequest) updates) =>
      super.copyWith((message) => updates(message as CreateWatchlistRequest))
          as CreateWatchlistRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateWatchlistRequest create() => CreateWatchlistRequest._();
  @$core.override
  CreateWatchlistRequest createEmptyInstance() => create();
  static $pb.PbList<CreateWatchlistRequest> createRepeated() =>
      $pb.PbList<CreateWatchlistRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateWatchlistRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateWatchlistRequest>(create);
  static CreateWatchlistRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<$core.String> get symbols => $_getList(1);

  @$pb.TagNumber(3)
  $core.bool get isDefault => $_getBF(2);
  @$pb.TagNumber(3)
  set isDefault($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasIsDefault() => $_has(2);
  @$pb.TagNumber(3)
  void clearIsDefault() => $_clearField(3);
}

class CreateWatchlistResponse extends $pb.GeneratedMessage {
  factory CreateWatchlistResponse({
    WatchlistMessage? watchlist,
    $core.String? message,
  }) {
    final result = create();
    if (watchlist != null) result.watchlist = watchlist;
    if (message != null) result.message = message;
    return result;
  }

  CreateWatchlistResponse._();

  factory CreateWatchlistResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateWatchlistResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateWatchlistResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'stockspb'),
      createEmptyInstance: create)
    ..aOM<WatchlistMessage>(1, _omitFieldNames ? '' : 'watchlist',
        subBuilder: WatchlistMessage.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateWatchlistResponse clone() =>
      CreateWatchlistResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateWatchlistResponse copyWith(
          void Function(CreateWatchlistResponse) updates) =>
      super.copyWith((message) => updates(message as CreateWatchlistResponse))
          as CreateWatchlistResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateWatchlistResponse create() => CreateWatchlistResponse._();
  @$core.override
  CreateWatchlistResponse createEmptyInstance() => create();
  static $pb.PbList<CreateWatchlistResponse> createRepeated() =>
      $pb.PbList<CreateWatchlistResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateWatchlistResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateWatchlistResponse>(create);
  static CreateWatchlistResponse? _defaultInstance;

  @$pb.TagNumber(1)
  WatchlistMessage get watchlist => $_getN(0);
  @$pb.TagNumber(1)
  set watchlist(WatchlistMessage value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasWatchlist() => $_has(0);
  @$pb.TagNumber(1)
  void clearWatchlist() => $_clearField(1);
  @$pb.TagNumber(1)
  WatchlistMessage ensureWatchlist() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);
}

/// Get User Watchlists
class GetUserWatchlistsRequest extends $pb.GeneratedMessage {
  factory GetUserWatchlistsRequest() => create();

  GetUserWatchlistsRequest._();

  factory GetUserWatchlistsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetUserWatchlistsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUserWatchlistsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'stockspb'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserWatchlistsRequest clone() =>
      GetUserWatchlistsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserWatchlistsRequest copyWith(
          void Function(GetUserWatchlistsRequest) updates) =>
      super.copyWith((message) => updates(message as GetUserWatchlistsRequest))
          as GetUserWatchlistsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserWatchlistsRequest create() => GetUserWatchlistsRequest._();
  @$core.override
  GetUserWatchlistsRequest createEmptyInstance() => create();
  static $pb.PbList<GetUserWatchlistsRequest> createRepeated() =>
      $pb.PbList<GetUserWatchlistsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetUserWatchlistsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUserWatchlistsRequest>(create);
  static GetUserWatchlistsRequest? _defaultInstance;
}

class GetUserWatchlistsResponse extends $pb.GeneratedMessage {
  factory GetUserWatchlistsResponse({
    $core.Iterable<WatchlistMessage>? watchlists,
  }) {
    final result = create();
    if (watchlists != null) result.watchlists.addAll(watchlists);
    return result;
  }

  GetUserWatchlistsResponse._();

  factory GetUserWatchlistsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetUserWatchlistsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUserWatchlistsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'stockspb'),
      createEmptyInstance: create)
    ..pc<WatchlistMessage>(
        1, _omitFieldNames ? '' : 'watchlists', $pb.PbFieldType.PM,
        subBuilder: WatchlistMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserWatchlistsResponse clone() =>
      GetUserWatchlistsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserWatchlistsResponse copyWith(
          void Function(GetUserWatchlistsResponse) updates) =>
      super.copyWith((message) => updates(message as GetUserWatchlistsResponse))
          as GetUserWatchlistsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserWatchlistsResponse create() => GetUserWatchlistsResponse._();
  @$core.override
  GetUserWatchlistsResponse createEmptyInstance() => create();
  static $pb.PbList<GetUserWatchlistsResponse> createRepeated() =>
      $pb.PbList<GetUserWatchlistsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetUserWatchlistsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUserWatchlistsResponse>(create);
  static GetUserWatchlistsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<WatchlistMessage> get watchlists => $_getList(0);
}

/// Get Watchlist
class GetWatchlistRequest extends $pb.GeneratedMessage {
  factory GetWatchlistRequest({
    $core.String? watchlistId,
  }) {
    final result = create();
    if (watchlistId != null) result.watchlistId = watchlistId;
    return result;
  }

  GetWatchlistRequest._();

  factory GetWatchlistRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetWatchlistRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetWatchlistRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'stockspb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'watchlistId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetWatchlistRequest clone() => GetWatchlistRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetWatchlistRequest copyWith(void Function(GetWatchlistRequest) updates) =>
      super.copyWith((message) => updates(message as GetWatchlistRequest))
          as GetWatchlistRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetWatchlistRequest create() => GetWatchlistRequest._();
  @$core.override
  GetWatchlistRequest createEmptyInstance() => create();
  static $pb.PbList<GetWatchlistRequest> createRepeated() =>
      $pb.PbList<GetWatchlistRequest>();
  @$core.pragma('dart2js:noInline')
  static GetWatchlistRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetWatchlistRequest>(create);
  static GetWatchlistRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get watchlistId => $_getSZ(0);
  @$pb.TagNumber(1)
  set watchlistId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasWatchlistId() => $_has(0);
  @$pb.TagNumber(1)
  void clearWatchlistId() => $_clearField(1);
}

class GetWatchlistResponse extends $pb.GeneratedMessage {
  factory GetWatchlistResponse({
    WatchlistMessage? watchlist,
  }) {
    final result = create();
    if (watchlist != null) result.watchlist = watchlist;
    return result;
  }

  GetWatchlistResponse._();

  factory GetWatchlistResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetWatchlistResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetWatchlistResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'stockspb'),
      createEmptyInstance: create)
    ..aOM<WatchlistMessage>(1, _omitFieldNames ? '' : 'watchlist',
        subBuilder: WatchlistMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetWatchlistResponse clone() =>
      GetWatchlistResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetWatchlistResponse copyWith(void Function(GetWatchlistResponse) updates) =>
      super.copyWith((message) => updates(message as GetWatchlistResponse))
          as GetWatchlistResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetWatchlistResponse create() => GetWatchlistResponse._();
  @$core.override
  GetWatchlistResponse createEmptyInstance() => create();
  static $pb.PbList<GetWatchlistResponse> createRepeated() =>
      $pb.PbList<GetWatchlistResponse>();
  @$core.pragma('dart2js:noInline')
  static GetWatchlistResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetWatchlistResponse>(create);
  static GetWatchlistResponse? _defaultInstance;

  @$pb.TagNumber(1)
  WatchlistMessage get watchlist => $_getN(0);
  @$pb.TagNumber(1)
  set watchlist(WatchlistMessage value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasWatchlist() => $_has(0);
  @$pb.TagNumber(1)
  void clearWatchlist() => $_clearField(1);
  @$pb.TagNumber(1)
  WatchlistMessage ensureWatchlist() => $_ensure(0);
}

/// Update Watchlist
class UpdateWatchlistRequest extends $pb.GeneratedMessage {
  factory UpdateWatchlistRequest({
    $core.String? watchlistId,
    $core.String? name,
    $core.bool? isDefault,
  }) {
    final result = create();
    if (watchlistId != null) result.watchlistId = watchlistId;
    if (name != null) result.name = name;
    if (isDefault != null) result.isDefault = isDefault;
    return result;
  }

  UpdateWatchlistRequest._();

  factory UpdateWatchlistRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateWatchlistRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateWatchlistRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'stockspb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'watchlistId')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOB(3, _omitFieldNames ? '' : 'isDefault')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateWatchlistRequest clone() =>
      UpdateWatchlistRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateWatchlistRequest copyWith(
          void Function(UpdateWatchlistRequest) updates) =>
      super.copyWith((message) => updates(message as UpdateWatchlistRequest))
          as UpdateWatchlistRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateWatchlistRequest create() => UpdateWatchlistRequest._();
  @$core.override
  UpdateWatchlistRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateWatchlistRequest> createRepeated() =>
      $pb.PbList<UpdateWatchlistRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateWatchlistRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateWatchlistRequest>(create);
  static UpdateWatchlistRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get watchlistId => $_getSZ(0);
  @$pb.TagNumber(1)
  set watchlistId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasWatchlistId() => $_has(0);
  @$pb.TagNumber(1)
  void clearWatchlistId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get isDefault => $_getBF(2);
  @$pb.TagNumber(3)
  set isDefault($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasIsDefault() => $_has(2);
  @$pb.TagNumber(3)
  void clearIsDefault() => $_clearField(3);
}

class UpdateWatchlistResponse extends $pb.GeneratedMessage {
  factory UpdateWatchlistResponse({
    WatchlistMessage? watchlist,
    $core.String? message,
  }) {
    final result = create();
    if (watchlist != null) result.watchlist = watchlist;
    if (message != null) result.message = message;
    return result;
  }

  UpdateWatchlistResponse._();

  factory UpdateWatchlistResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateWatchlistResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateWatchlistResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'stockspb'),
      createEmptyInstance: create)
    ..aOM<WatchlistMessage>(1, _omitFieldNames ? '' : 'watchlist',
        subBuilder: WatchlistMessage.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateWatchlistResponse clone() =>
      UpdateWatchlistResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateWatchlistResponse copyWith(
          void Function(UpdateWatchlistResponse) updates) =>
      super.copyWith((message) => updates(message as UpdateWatchlistResponse))
          as UpdateWatchlistResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateWatchlistResponse create() => UpdateWatchlistResponse._();
  @$core.override
  UpdateWatchlistResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateWatchlistResponse> createRepeated() =>
      $pb.PbList<UpdateWatchlistResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateWatchlistResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateWatchlistResponse>(create);
  static UpdateWatchlistResponse? _defaultInstance;

  @$pb.TagNumber(1)
  WatchlistMessage get watchlist => $_getN(0);
  @$pb.TagNumber(1)
  set watchlist(WatchlistMessage value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasWatchlist() => $_has(0);
  @$pb.TagNumber(1)
  void clearWatchlist() => $_clearField(1);
  @$pb.TagNumber(1)
  WatchlistMessage ensureWatchlist() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);
}

/// Delete Watchlist
class DeleteWatchlistRequest extends $pb.GeneratedMessage {
  factory DeleteWatchlistRequest({
    $core.String? watchlistId,
  }) {
    final result = create();
    if (watchlistId != null) result.watchlistId = watchlistId;
    return result;
  }

  DeleteWatchlistRequest._();

  factory DeleteWatchlistRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeleteWatchlistRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteWatchlistRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'stockspb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'watchlistId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteWatchlistRequest clone() =>
      DeleteWatchlistRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteWatchlistRequest copyWith(
          void Function(DeleteWatchlistRequest) updates) =>
      super.copyWith((message) => updates(message as DeleteWatchlistRequest))
          as DeleteWatchlistRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteWatchlistRequest create() => DeleteWatchlistRequest._();
  @$core.override
  DeleteWatchlistRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteWatchlistRequest> createRepeated() =>
      $pb.PbList<DeleteWatchlistRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteWatchlistRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteWatchlistRequest>(create);
  static DeleteWatchlistRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get watchlistId => $_getSZ(0);
  @$pb.TagNumber(1)
  set watchlistId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasWatchlistId() => $_has(0);
  @$pb.TagNumber(1)
  void clearWatchlistId() => $_clearField(1);
}

class DeleteWatchlistResponse extends $pb.GeneratedMessage {
  factory DeleteWatchlistResponse({
    $core.String? message,
  }) {
    final result = create();
    if (message != null) result.message = message;
    return result;
  }

  DeleteWatchlistResponse._();

  factory DeleteWatchlistResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DeleteWatchlistResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteWatchlistResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'stockspb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteWatchlistResponse clone() =>
      DeleteWatchlistResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteWatchlistResponse copyWith(
          void Function(DeleteWatchlistResponse) updates) =>
      super.copyWith((message) => updates(message as DeleteWatchlistResponse))
          as DeleteWatchlistResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteWatchlistResponse create() => DeleteWatchlistResponse._();
  @$core.override
  DeleteWatchlistResponse createEmptyInstance() => create();
  static $pb.PbList<DeleteWatchlistResponse> createRepeated() =>
      $pb.PbList<DeleteWatchlistResponse>();
  @$core.pragma('dart2js:noInline')
  static DeleteWatchlistResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteWatchlistResponse>(create);
  static DeleteWatchlistResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get message => $_getSZ(0);
  @$pb.TagNumber(1)
  set message($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessage() => $_clearField(1);
}

/// Add Stock to Watchlist
class AddStockToWatchlistRequest extends $pb.GeneratedMessage {
  factory AddStockToWatchlistRequest({
    $core.String? watchlistId,
    $core.String? symbol,
  }) {
    final result = create();
    if (watchlistId != null) result.watchlistId = watchlistId;
    if (symbol != null) result.symbol = symbol;
    return result;
  }

  AddStockToWatchlistRequest._();

  factory AddStockToWatchlistRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AddStockToWatchlistRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AddStockToWatchlistRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'stockspb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'watchlistId')
    ..aOS(2, _omitFieldNames ? '' : 'symbol')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddStockToWatchlistRequest clone() =>
      AddStockToWatchlistRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddStockToWatchlistRequest copyWith(
          void Function(AddStockToWatchlistRequest) updates) =>
      super.copyWith(
              (message) => updates(message as AddStockToWatchlistRequest))
          as AddStockToWatchlistRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddStockToWatchlistRequest create() => AddStockToWatchlistRequest._();
  @$core.override
  AddStockToWatchlistRequest createEmptyInstance() => create();
  static $pb.PbList<AddStockToWatchlistRequest> createRepeated() =>
      $pb.PbList<AddStockToWatchlistRequest>();
  @$core.pragma('dart2js:noInline')
  static AddStockToWatchlistRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AddStockToWatchlistRequest>(create);
  static AddStockToWatchlistRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get watchlistId => $_getSZ(0);
  @$pb.TagNumber(1)
  set watchlistId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasWatchlistId() => $_has(0);
  @$pb.TagNumber(1)
  void clearWatchlistId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get symbol => $_getSZ(1);
  @$pb.TagNumber(2)
  set symbol($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSymbol() => $_has(1);
  @$pb.TagNumber(2)
  void clearSymbol() => $_clearField(2);
}

class AddStockToWatchlistResponse extends $pb.GeneratedMessage {
  factory AddStockToWatchlistResponse({
    WatchlistMessage? watchlist,
    $core.String? message,
  }) {
    final result = create();
    if (watchlist != null) result.watchlist = watchlist;
    if (message != null) result.message = message;
    return result;
  }

  AddStockToWatchlistResponse._();

  factory AddStockToWatchlistResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AddStockToWatchlistResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AddStockToWatchlistResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'stockspb'),
      createEmptyInstance: create)
    ..aOM<WatchlistMessage>(1, _omitFieldNames ? '' : 'watchlist',
        subBuilder: WatchlistMessage.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddStockToWatchlistResponse clone() =>
      AddStockToWatchlistResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddStockToWatchlistResponse copyWith(
          void Function(AddStockToWatchlistResponse) updates) =>
      super.copyWith(
              (message) => updates(message as AddStockToWatchlistResponse))
          as AddStockToWatchlistResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddStockToWatchlistResponse create() =>
      AddStockToWatchlistResponse._();
  @$core.override
  AddStockToWatchlistResponse createEmptyInstance() => create();
  static $pb.PbList<AddStockToWatchlistResponse> createRepeated() =>
      $pb.PbList<AddStockToWatchlistResponse>();
  @$core.pragma('dart2js:noInline')
  static AddStockToWatchlistResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AddStockToWatchlistResponse>(create);
  static AddStockToWatchlistResponse? _defaultInstance;

  @$pb.TagNumber(1)
  WatchlistMessage get watchlist => $_getN(0);
  @$pb.TagNumber(1)
  set watchlist(WatchlistMessage value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasWatchlist() => $_has(0);
  @$pb.TagNumber(1)
  void clearWatchlist() => $_clearField(1);
  @$pb.TagNumber(1)
  WatchlistMessage ensureWatchlist() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);
}

/// Remove Stock from Watchlist
class RemoveStockFromWatchlistRequest extends $pb.GeneratedMessage {
  factory RemoveStockFromWatchlistRequest({
    $core.String? watchlistId,
    $core.String? symbol,
  }) {
    final result = create();
    if (watchlistId != null) result.watchlistId = watchlistId;
    if (symbol != null) result.symbol = symbol;
    return result;
  }

  RemoveStockFromWatchlistRequest._();

  factory RemoveStockFromWatchlistRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RemoveStockFromWatchlistRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RemoveStockFromWatchlistRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'stockspb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'watchlistId')
    ..aOS(2, _omitFieldNames ? '' : 'symbol')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RemoveStockFromWatchlistRequest clone() =>
      RemoveStockFromWatchlistRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RemoveStockFromWatchlistRequest copyWith(
          void Function(RemoveStockFromWatchlistRequest) updates) =>
      super.copyWith(
              (message) => updates(message as RemoveStockFromWatchlistRequest))
          as RemoveStockFromWatchlistRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RemoveStockFromWatchlistRequest create() =>
      RemoveStockFromWatchlistRequest._();
  @$core.override
  RemoveStockFromWatchlistRequest createEmptyInstance() => create();
  static $pb.PbList<RemoveStockFromWatchlistRequest> createRepeated() =>
      $pb.PbList<RemoveStockFromWatchlistRequest>();
  @$core.pragma('dart2js:noInline')
  static RemoveStockFromWatchlistRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RemoveStockFromWatchlistRequest>(
          create);
  static RemoveStockFromWatchlistRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get watchlistId => $_getSZ(0);
  @$pb.TagNumber(1)
  set watchlistId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasWatchlistId() => $_has(0);
  @$pb.TagNumber(1)
  void clearWatchlistId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get symbol => $_getSZ(1);
  @$pb.TagNumber(2)
  set symbol($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSymbol() => $_has(1);
  @$pb.TagNumber(2)
  void clearSymbol() => $_clearField(2);
}

class RemoveStockFromWatchlistResponse extends $pb.GeneratedMessage {
  factory RemoveStockFromWatchlistResponse({
    WatchlistMessage? watchlist,
    $core.String? message,
  }) {
    final result = create();
    if (watchlist != null) result.watchlist = watchlist;
    if (message != null) result.message = message;
    return result;
  }

  RemoveStockFromWatchlistResponse._();

  factory RemoveStockFromWatchlistResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RemoveStockFromWatchlistResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RemoveStockFromWatchlistResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'stockspb'),
      createEmptyInstance: create)
    ..aOM<WatchlistMessage>(1, _omitFieldNames ? '' : 'watchlist',
        subBuilder: WatchlistMessage.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RemoveStockFromWatchlistResponse clone() =>
      RemoveStockFromWatchlistResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RemoveStockFromWatchlistResponse copyWith(
          void Function(RemoveStockFromWatchlistResponse) updates) =>
      super.copyWith(
              (message) => updates(message as RemoveStockFromWatchlistResponse))
          as RemoveStockFromWatchlistResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RemoveStockFromWatchlistResponse create() =>
      RemoveStockFromWatchlistResponse._();
  @$core.override
  RemoveStockFromWatchlistResponse createEmptyInstance() => create();
  static $pb.PbList<RemoveStockFromWatchlistResponse> createRepeated() =>
      $pb.PbList<RemoveStockFromWatchlistResponse>();
  @$core.pragma('dart2js:noInline')
  static RemoveStockFromWatchlistResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RemoveStockFromWatchlistResponse>(
          create);
  static RemoveStockFromWatchlistResponse? _defaultInstance;

  @$pb.TagNumber(1)
  WatchlistMessage get watchlist => $_getN(0);
  @$pb.TagNumber(1)
  set watchlist(WatchlistMessage value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasWatchlist() => $_has(0);
  @$pb.TagNumber(1)
  void clearWatchlist() => $_clearField(1);
  @$pb.TagNumber(1)
  WatchlistMessage ensureWatchlist() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);
}

/// Get Market Status
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
      package: const $pb.PackageName(_omitMessageNames ? '' : 'stockspb'),
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
    $core.String? tradingSession,
    $1.Timestamp? nextOpen,
    $1.Timestamp? nextClose,
    $1.Timestamp? timestamp,
  }) {
    final result = create();
    if (isOpen != null) result.isOpen = isOpen;
    if (tradingSession != null) result.tradingSession = tradingSession;
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
      package: const $pb.PackageName(_omitMessageNames ? '' : 'stockspb'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'isOpen')
    ..aOS(2, _omitFieldNames ? '' : 'tradingSession')
    ..aOM<$1.Timestamp>(3, _omitFieldNames ? '' : 'nextOpen',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(4, _omitFieldNames ? '' : 'nextClose',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(5, _omitFieldNames ? '' : 'timestamp',
        subBuilder: $1.Timestamp.create)
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
  $core.String get tradingSession => $_getSZ(1);
  @$pb.TagNumber(2)
  set tradingSession($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTradingSession() => $_has(1);
  @$pb.TagNumber(2)
  void clearTradingSession() => $_clearField(2);

  @$pb.TagNumber(3)
  $1.Timestamp get nextOpen => $_getN(2);
  @$pb.TagNumber(3)
  set nextOpen($1.Timestamp value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasNextOpen() => $_has(2);
  @$pb.TagNumber(3)
  void clearNextOpen() => $_clearField(3);
  @$pb.TagNumber(3)
  $1.Timestamp ensureNextOpen() => $_ensure(2);

  @$pb.TagNumber(4)
  $1.Timestamp get nextClose => $_getN(3);
  @$pb.TagNumber(4)
  set nextClose($1.Timestamp value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasNextClose() => $_has(3);
  @$pb.TagNumber(4)
  void clearNextClose() => $_clearField(4);
  @$pb.TagNumber(4)
  $1.Timestamp ensureNextClose() => $_ensure(3);

  @$pb.TagNumber(5)
  $1.Timestamp get timestamp => $_getN(4);
  @$pb.TagNumber(5)
  set timestamp($1.Timestamp value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasTimestamp() => $_has(4);
  @$pb.TagNumber(5)
  void clearTimestamp() => $_clearField(5);
  @$pb.TagNumber(5)
  $1.Timestamp ensureTimestamp() => $_ensure(4);
}

class MarketNewsMessage extends $pb.GeneratedMessage {
  factory MarketNewsMessage({
    $core.String? id,
    $core.String? headline,
    $core.String? summary,
    $core.String? source,
    $core.String? url,
    $core.Iterable<$core.String>? symbols,
    $1.Timestamp? publishedAt,
    $core.String? imageUrl,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (headline != null) result.headline = headline;
    if (summary != null) result.summary = summary;
    if (source != null) result.source = source;
    if (url != null) result.url = url;
    if (symbols != null) result.symbols.addAll(symbols);
    if (publishedAt != null) result.publishedAt = publishedAt;
    if (imageUrl != null) result.imageUrl = imageUrl;
    return result;
  }

  MarketNewsMessage._();

  factory MarketNewsMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MarketNewsMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MarketNewsMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'stockspb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'headline')
    ..aOS(3, _omitFieldNames ? '' : 'summary')
    ..aOS(4, _omitFieldNames ? '' : 'source')
    ..aOS(5, _omitFieldNames ? '' : 'url')
    ..pPS(6, _omitFieldNames ? '' : 'symbols')
    ..aOM<$1.Timestamp>(7, _omitFieldNames ? '' : 'publishedAt',
        subBuilder: $1.Timestamp.create)
    ..aOS(8, _omitFieldNames ? '' : 'imageUrl')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MarketNewsMessage clone() => MarketNewsMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MarketNewsMessage copyWith(void Function(MarketNewsMessage) updates) =>
      super.copyWith((message) => updates(message as MarketNewsMessage))
          as MarketNewsMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MarketNewsMessage create() => MarketNewsMessage._();
  @$core.override
  MarketNewsMessage createEmptyInstance() => create();
  static $pb.PbList<MarketNewsMessage> createRepeated() =>
      $pb.PbList<MarketNewsMessage>();
  @$core.pragma('dart2js:noInline')
  static MarketNewsMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MarketNewsMessage>(create);
  static MarketNewsMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get headline => $_getSZ(1);
  @$pb.TagNumber(2)
  set headline($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasHeadline() => $_has(1);
  @$pb.TagNumber(2)
  void clearHeadline() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get summary => $_getSZ(2);
  @$pb.TagNumber(3)
  set summary($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSummary() => $_has(2);
  @$pb.TagNumber(3)
  void clearSummary() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get source => $_getSZ(3);
  @$pb.TagNumber(4)
  set source($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasSource() => $_has(3);
  @$pb.TagNumber(4)
  void clearSource() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get url => $_getSZ(4);
  @$pb.TagNumber(5)
  set url($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasUrl() => $_has(4);
  @$pb.TagNumber(5)
  void clearUrl() => $_clearField(5);

  @$pb.TagNumber(6)
  $pb.PbList<$core.String> get symbols => $_getList(5);

  @$pb.TagNumber(7)
  $1.Timestamp get publishedAt => $_getN(6);
  @$pb.TagNumber(7)
  set publishedAt($1.Timestamp value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasPublishedAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearPublishedAt() => $_clearField(7);
  @$pb.TagNumber(7)
  $1.Timestamp ensurePublishedAt() => $_ensure(6);

  @$pb.TagNumber(8)
  $core.String get imageUrl => $_getSZ(7);
  @$pb.TagNumber(8)
  set imageUrl($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasImageUrl() => $_has(7);
  @$pb.TagNumber(8)
  void clearImageUrl() => $_clearField(8);
}

class GetMarketNewsRequest extends $pb.GeneratedMessage {
  factory GetMarketNewsRequest({
    $core.Iterable<$core.String>? symbols,
    $core.int? page,
    $core.int? limit,
  }) {
    final result = create();
    if (symbols != null) result.symbols.addAll(symbols);
    if (page != null) result.page = page;
    if (limit != null) result.limit = limit;
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
      package: const $pb.PackageName(_omitMessageNames ? '' : 'stockspb'),
      createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'symbols')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
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

class GetMarketNewsResponse extends $pb.GeneratedMessage {
  factory GetMarketNewsResponse({
    $core.Iterable<MarketNewsMessage>? articles,
  }) {
    final result = create();
    if (articles != null) result.articles.addAll(articles);
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
      package: const $pb.PackageName(_omitMessageNames ? '' : 'stockspb'),
      createEmptyInstance: create)
    ..pc<MarketNewsMessage>(
        1, _omitFieldNames ? '' : 'articles', $pb.PbFieldType.PM,
        subBuilder: MarketNewsMessage.create)
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
  $pb.PbList<MarketNewsMessage> get articles => $_getList(0);
}

class PriceAlertMessage extends $pb.GeneratedMessage {
  factory PriceAlertMessage({
    $core.String? id,
    $core.String? symbol,
    AlertType? type,
    $core.double? targetValue,
    $core.bool? isActive,
    $core.bool? isTriggered,
    $1.Timestamp? createdAt,
    $1.Timestamp? triggeredAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (symbol != null) result.symbol = symbol;
    if (type != null) result.type = type;
    if (targetValue != null) result.targetValue = targetValue;
    if (isActive != null) result.isActive = isActive;
    if (isTriggered != null) result.isTriggered = isTriggered;
    if (createdAt != null) result.createdAt = createdAt;
    if (triggeredAt != null) result.triggeredAt = triggeredAt;
    return result;
  }

  PriceAlertMessage._();

  factory PriceAlertMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PriceAlertMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PriceAlertMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'stockspb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'symbol')
    ..e<AlertType>(3, _omitFieldNames ? '' : 'type', $pb.PbFieldType.OE,
        defaultOrMaker: AlertType.ALERT_TYPE_UNSPECIFIED,
        valueOf: AlertType.valueOf,
        enumValues: AlertType.values)
    ..a<$core.double>(
        4, _omitFieldNames ? '' : 'targetValue', $pb.PbFieldType.OD)
    ..aOB(5, _omitFieldNames ? '' : 'isActive')
    ..aOB(6, _omitFieldNames ? '' : 'isTriggered')
    ..aOM<$1.Timestamp>(7, _omitFieldNames ? '' : 'createdAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(8, _omitFieldNames ? '' : 'triggeredAt',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PriceAlertMessage clone() => PriceAlertMessage()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PriceAlertMessage copyWith(void Function(PriceAlertMessage) updates) =>
      super.copyWith((message) => updates(message as PriceAlertMessage))
          as PriceAlertMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PriceAlertMessage create() => PriceAlertMessage._();
  @$core.override
  PriceAlertMessage createEmptyInstance() => create();
  static $pb.PbList<PriceAlertMessage> createRepeated() =>
      $pb.PbList<PriceAlertMessage>();
  @$core.pragma('dart2js:noInline')
  static PriceAlertMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PriceAlertMessage>(create);
  static PriceAlertMessage? _defaultInstance;

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
  AlertType get type => $_getN(2);
  @$pb.TagNumber(3)
  set type(AlertType value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasType() => $_has(2);
  @$pb.TagNumber(3)
  void clearType() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get targetValue => $_getN(3);
  @$pb.TagNumber(4)
  set targetValue($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTargetValue() => $_has(3);
  @$pb.TagNumber(4)
  void clearTargetValue() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.bool get isActive => $_getBF(4);
  @$pb.TagNumber(5)
  set isActive($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasIsActive() => $_has(4);
  @$pb.TagNumber(5)
  void clearIsActive() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.bool get isTriggered => $_getBF(5);
  @$pb.TagNumber(6)
  set isTriggered($core.bool value) => $_setBool(5, value);
  @$pb.TagNumber(6)
  $core.bool hasIsTriggered() => $_has(5);
  @$pb.TagNumber(6)
  void clearIsTriggered() => $_clearField(6);

  @$pb.TagNumber(7)
  $1.Timestamp get createdAt => $_getN(6);
  @$pb.TagNumber(7)
  set createdAt($1.Timestamp value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasCreatedAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearCreatedAt() => $_clearField(7);
  @$pb.TagNumber(7)
  $1.Timestamp ensureCreatedAt() => $_ensure(6);

  @$pb.TagNumber(8)
  $1.Timestamp get triggeredAt => $_getN(7);
  @$pb.TagNumber(8)
  set triggeredAt($1.Timestamp value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasTriggeredAt() => $_has(7);
  @$pb.TagNumber(8)
  void clearTriggeredAt() => $_clearField(8);
  @$pb.TagNumber(8)
  $1.Timestamp ensureTriggeredAt() => $_ensure(7);
}

class CreatePriceAlertRequest extends $pb.GeneratedMessage {
  factory CreatePriceAlertRequest({
    $core.String? symbol,
    AlertType? type,
    $core.double? targetValue,
  }) {
    final result = create();
    if (symbol != null) result.symbol = symbol;
    if (type != null) result.type = type;
    if (targetValue != null) result.targetValue = targetValue;
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
      package: const $pb.PackageName(_omitMessageNames ? '' : 'stockspb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'symbol')
    ..e<AlertType>(2, _omitFieldNames ? '' : 'type', $pb.PbFieldType.OE,
        defaultOrMaker: AlertType.ALERT_TYPE_UNSPECIFIED,
        valueOf: AlertType.valueOf,
        enumValues: AlertType.values)
    ..a<$core.double>(
        3, _omitFieldNames ? '' : 'targetValue', $pb.PbFieldType.OD)
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
  AlertType get type => $_getN(1);
  @$pb.TagNumber(2)
  set type(AlertType value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasType() => $_has(1);
  @$pb.TagNumber(2)
  void clearType() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get targetValue => $_getN(2);
  @$pb.TagNumber(3)
  set targetValue($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTargetValue() => $_has(2);
  @$pb.TagNumber(3)
  void clearTargetValue() => $_clearField(3);
}

class CreatePriceAlertResponse extends $pb.GeneratedMessage {
  factory CreatePriceAlertResponse({
    PriceAlertMessage? alert,
  }) {
    final result = create();
    if (alert != null) result.alert = alert;
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
      package: const $pb.PackageName(_omitMessageNames ? '' : 'stockspb'),
      createEmptyInstance: create)
    ..aOM<PriceAlertMessage>(1, _omitFieldNames ? '' : 'alert',
        subBuilder: PriceAlertMessage.create)
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
  PriceAlertMessage get alert => $_getN(0);
  @$pb.TagNumber(1)
  set alert(PriceAlertMessage value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasAlert() => $_has(0);
  @$pb.TagNumber(1)
  void clearAlert() => $_clearField(1);
  @$pb.TagNumber(1)
  PriceAlertMessage ensureAlert() => $_ensure(0);
}

class GetPriceAlertsRequest extends $pb.GeneratedMessage {
  factory GetPriceAlertsRequest() => create();

  GetPriceAlertsRequest._();

  factory GetPriceAlertsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetPriceAlertsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetPriceAlertsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'stockspb'),
      createEmptyInstance: create)
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
}

class GetPriceAlertsResponse extends $pb.GeneratedMessage {
  factory GetPriceAlertsResponse({
    $core.Iterable<PriceAlertMessage>? alerts,
  }) {
    final result = create();
    if (alerts != null) result.alerts.addAll(alerts);
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
      package: const $pb.PackageName(_omitMessageNames ? '' : 'stockspb'),
      createEmptyInstance: create)
    ..pc<PriceAlertMessage>(
        1, _omitFieldNames ? '' : 'alerts', $pb.PbFieldType.PM,
        subBuilder: PriceAlertMessage.create)
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
  $pb.PbList<PriceAlertMessage> get alerts => $_getList(0);
}

class UpdatePriceAlertRequest extends $pb.GeneratedMessage {
  factory UpdatePriceAlertRequest({
    $core.String? alertId,
    $core.double? targetValue,
    $core.bool? isActive,
  }) {
    final result = create();
    if (alertId != null) result.alertId = alertId;
    if (targetValue != null) result.targetValue = targetValue;
    if (isActive != null) result.isActive = isActive;
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
      package: const $pb.PackageName(_omitMessageNames ? '' : 'stockspb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'alertId')
    ..a<$core.double>(
        2, _omitFieldNames ? '' : 'targetValue', $pb.PbFieldType.OD)
    ..aOB(3, _omitFieldNames ? '' : 'isActive')
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
  $core.double get targetValue => $_getN(1);
  @$pb.TagNumber(2)
  set targetValue($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTargetValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearTargetValue() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get isActive => $_getBF(2);
  @$pb.TagNumber(3)
  set isActive($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasIsActive() => $_has(2);
  @$pb.TagNumber(3)
  void clearIsActive() => $_clearField(3);
}

class UpdatePriceAlertResponse extends $pb.GeneratedMessage {
  factory UpdatePriceAlertResponse({
    PriceAlertMessage? alert,
  }) {
    final result = create();
    if (alert != null) result.alert = alert;
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
      package: const $pb.PackageName(_omitMessageNames ? '' : 'stockspb'),
      createEmptyInstance: create)
    ..aOM<PriceAlertMessage>(1, _omitFieldNames ? '' : 'alert',
        subBuilder: PriceAlertMessage.create)
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
  PriceAlertMessage get alert => $_getN(0);
  @$pb.TagNumber(1)
  set alert(PriceAlertMessage value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasAlert() => $_has(0);
  @$pb.TagNumber(1)
  void clearAlert() => $_clearField(1);
  @$pb.TagNumber(1)
  PriceAlertMessage ensureAlert() => $_ensure(0);
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
      package: const $pb.PackageName(_omitMessageNames ? '' : 'stockspb'),
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
    $core.String? message,
  }) {
    final result = create();
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
      package: const $pb.PackageName(_omitMessageNames ? '' : 'stockspb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'message')
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
  $core.String get message => $_getSZ(0);
  @$pb.TagNumber(1)
  set message($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessage() => $_clearField(1);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
