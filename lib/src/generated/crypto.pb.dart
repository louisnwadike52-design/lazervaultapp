//
//  Generated code. Do not modify.
//  source: crypto.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $1;

export 'crypto.pbenum.dart';

class CryptoMessage extends $pb.GeneratedMessage {
  factory CryptoMessage({
    $core.String? id,
    $core.String? symbol,
    $core.String? name,
    $core.String? image,
    $core.double? currentPrice,
    $fixnum.Int64? marketCap,
    $core.int? marketCapRank,
    $fixnum.Int64? totalVolume,
    $core.double? high24h,
    $core.double? low24h,
    $core.double? priceChange24h,
    $core.double? priceChangePercentage24h,
    $core.double? priceChangePercentage7d,
    $core.double? priceChangePercentage30d,
    $core.double? priceChangePercentage1y,
    $core.double? circulatingSupply,
    $core.double? totalSupply,
    $core.double? maxSupply,
    $core.double? ath,
    $core.double? athChangePercentage,
    $1.Timestamp? athDate,
    $core.double? atl,
    $core.double? atlChangePercentage,
    $1.Timestamp? atlDate,
    $1.Timestamp? lastUpdated,
    $core.Iterable<PricePoint>? priceHistory,
    $core.String? description,
    $core.Iterable<$core.String>? categories,
    $core.Map<$core.String, $core.String>? links,
    $core.double? fullyDilutedValuation,
    $core.double? marketCapChange24h,
    $core.double? marketCapChangePercentage24h,
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
    if (image != null) {
      $result.image = image;
    }
    if (currentPrice != null) {
      $result.currentPrice = currentPrice;
    }
    if (marketCap != null) {
      $result.marketCap = marketCap;
    }
    if (marketCapRank != null) {
      $result.marketCapRank = marketCapRank;
    }
    if (totalVolume != null) {
      $result.totalVolume = totalVolume;
    }
    if (high24h != null) {
      $result.high24h = high24h;
    }
    if (low24h != null) {
      $result.low24h = low24h;
    }
    if (priceChange24h != null) {
      $result.priceChange24h = priceChange24h;
    }
    if (priceChangePercentage24h != null) {
      $result.priceChangePercentage24h = priceChangePercentage24h;
    }
    if (priceChangePercentage7d != null) {
      $result.priceChangePercentage7d = priceChangePercentage7d;
    }
    if (priceChangePercentage30d != null) {
      $result.priceChangePercentage30d = priceChangePercentage30d;
    }
    if (priceChangePercentage1y != null) {
      $result.priceChangePercentage1y = priceChangePercentage1y;
    }
    if (circulatingSupply != null) {
      $result.circulatingSupply = circulatingSupply;
    }
    if (totalSupply != null) {
      $result.totalSupply = totalSupply;
    }
    if (maxSupply != null) {
      $result.maxSupply = maxSupply;
    }
    if (ath != null) {
      $result.ath = ath;
    }
    if (athChangePercentage != null) {
      $result.athChangePercentage = athChangePercentage;
    }
    if (athDate != null) {
      $result.athDate = athDate;
    }
    if (atl != null) {
      $result.atl = atl;
    }
    if (atlChangePercentage != null) {
      $result.atlChangePercentage = atlChangePercentage;
    }
    if (atlDate != null) {
      $result.atlDate = atlDate;
    }
    if (lastUpdated != null) {
      $result.lastUpdated = lastUpdated;
    }
    if (priceHistory != null) {
      $result.priceHistory.addAll(priceHistory);
    }
    if (description != null) {
      $result.description = description;
    }
    if (categories != null) {
      $result.categories.addAll(categories);
    }
    if (links != null) {
      $result.links.addAll(links);
    }
    if (fullyDilutedValuation != null) {
      $result.fullyDilutedValuation = fullyDilutedValuation;
    }
    if (marketCapChange24h != null) {
      $result.marketCapChange24h = marketCapChange24h;
    }
    if (marketCapChangePercentage24h != null) {
      $result.marketCapChangePercentage24h = marketCapChangePercentage24h;
    }
    return $result;
  }
  CryptoMessage._() : super();
  factory CryptoMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CryptoMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CryptoMessage', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'symbol')
    ..aOS(3, _omitFieldNames ? '' : 'name')
    ..aOS(4, _omitFieldNames ? '' : 'image')
    ..a<$core.double>(5, _omitFieldNames ? '' : 'currentPrice', $pb.PbFieldType.OD)
    ..a<$fixnum.Int64>(6, _omitFieldNames ? '' : 'marketCap', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(7, _omitFieldNames ? '' : 'marketCapRank', $pb.PbFieldType.O3)
    ..a<$fixnum.Int64>(8, _omitFieldNames ? '' : 'totalVolume', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.double>(9, _omitFieldNames ? '' : 'high24h', $pb.PbFieldType.OD, protoName: 'high_24h')
    ..a<$core.double>(10, _omitFieldNames ? '' : 'low24h', $pb.PbFieldType.OD, protoName: 'low_24h')
    ..a<$core.double>(11, _omitFieldNames ? '' : 'priceChange24h', $pb.PbFieldType.OD, protoName: 'price_change_24h')
    ..a<$core.double>(12, _omitFieldNames ? '' : 'priceChangePercentage24h', $pb.PbFieldType.OD, protoName: 'price_change_percentage_24h')
    ..a<$core.double>(13, _omitFieldNames ? '' : 'priceChangePercentage7d', $pb.PbFieldType.OD, protoName: 'price_change_percentage_7d')
    ..a<$core.double>(14, _omitFieldNames ? '' : 'priceChangePercentage30d', $pb.PbFieldType.OD, protoName: 'price_change_percentage_30d')
    ..a<$core.double>(15, _omitFieldNames ? '' : 'priceChangePercentage1y', $pb.PbFieldType.OD, protoName: 'price_change_percentage_1y')
    ..a<$core.double>(16, _omitFieldNames ? '' : 'circulatingSupply', $pb.PbFieldType.OD)
    ..a<$core.double>(17, _omitFieldNames ? '' : 'totalSupply', $pb.PbFieldType.OD)
    ..a<$core.double>(18, _omitFieldNames ? '' : 'maxSupply', $pb.PbFieldType.OD)
    ..a<$core.double>(19, _omitFieldNames ? '' : 'ath', $pb.PbFieldType.OD)
    ..a<$core.double>(20, _omitFieldNames ? '' : 'athChangePercentage', $pb.PbFieldType.OD)
    ..aOM<$1.Timestamp>(21, _omitFieldNames ? '' : 'athDate', subBuilder: $1.Timestamp.create)
    ..a<$core.double>(22, _omitFieldNames ? '' : 'atl', $pb.PbFieldType.OD)
    ..a<$core.double>(23, _omitFieldNames ? '' : 'atlChangePercentage', $pb.PbFieldType.OD)
    ..aOM<$1.Timestamp>(24, _omitFieldNames ? '' : 'atlDate', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(25, _omitFieldNames ? '' : 'lastUpdated', subBuilder: $1.Timestamp.create)
    ..pc<PricePoint>(26, _omitFieldNames ? '' : 'priceHistory', $pb.PbFieldType.PM, subBuilder: PricePoint.create)
    ..aOS(27, _omitFieldNames ? '' : 'description')
    ..pPS(28, _omitFieldNames ? '' : 'categories')
    ..m<$core.String, $core.String>(29, _omitFieldNames ? '' : 'links', entryClassName: 'CryptoMessage.LinksEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('pb'))
    ..a<$core.double>(30, _omitFieldNames ? '' : 'fullyDilutedValuation', $pb.PbFieldType.OD)
    ..a<$core.double>(31, _omitFieldNames ? '' : 'marketCapChange24h', $pb.PbFieldType.OD, protoName: 'market_cap_change_24h')
    ..a<$core.double>(32, _omitFieldNames ? '' : 'marketCapChangePercentage24h', $pb.PbFieldType.OD, protoName: 'market_cap_change_percentage_24h')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CryptoMessage clone() => CryptoMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CryptoMessage copyWith(void Function(CryptoMessage) updates) => super.copyWith((message) => updates(message as CryptoMessage)) as CryptoMessage;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CryptoMessage create() => CryptoMessage._();
  CryptoMessage createEmptyInstance() => create();
  static $pb.PbList<CryptoMessage> createRepeated() => $pb.PbList<CryptoMessage>();
  @$core.pragma('dart2js:noInline')
  static CryptoMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CryptoMessage>(create);
  static CryptoMessage? _defaultInstance;

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
  $core.String get image => $_getSZ(3);
  @$pb.TagNumber(4)
  set image($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasImage() => $_has(3);
  @$pb.TagNumber(4)
  void clearImage() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get currentPrice => $_getN(4);
  @$pb.TagNumber(5)
  set currentPrice($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasCurrentPrice() => $_has(4);
  @$pb.TagNumber(5)
  void clearCurrentPrice() => clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get marketCap => $_getI64(5);
  @$pb.TagNumber(6)
  set marketCap($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasMarketCap() => $_has(5);
  @$pb.TagNumber(6)
  void clearMarketCap() => clearField(6);

  @$pb.TagNumber(7)
  $core.int get marketCapRank => $_getIZ(6);
  @$pb.TagNumber(7)
  set marketCapRank($core.int v) { $_setSignedInt32(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasMarketCapRank() => $_has(6);
  @$pb.TagNumber(7)
  void clearMarketCapRank() => clearField(7);

  @$pb.TagNumber(8)
  $fixnum.Int64 get totalVolume => $_getI64(7);
  @$pb.TagNumber(8)
  set totalVolume($fixnum.Int64 v) { $_setInt64(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasTotalVolume() => $_has(7);
  @$pb.TagNumber(8)
  void clearTotalVolume() => clearField(8);

  @$pb.TagNumber(9)
  $core.double get high24h => $_getN(8);
  @$pb.TagNumber(9)
  set high24h($core.double v) { $_setDouble(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasHigh24h() => $_has(8);
  @$pb.TagNumber(9)
  void clearHigh24h() => clearField(9);

  @$pb.TagNumber(10)
  $core.double get low24h => $_getN(9);
  @$pb.TagNumber(10)
  set low24h($core.double v) { $_setDouble(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasLow24h() => $_has(9);
  @$pb.TagNumber(10)
  void clearLow24h() => clearField(10);

  @$pb.TagNumber(11)
  $core.double get priceChange24h => $_getN(10);
  @$pb.TagNumber(11)
  set priceChange24h($core.double v) { $_setDouble(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasPriceChange24h() => $_has(10);
  @$pb.TagNumber(11)
  void clearPriceChange24h() => clearField(11);

  @$pb.TagNumber(12)
  $core.double get priceChangePercentage24h => $_getN(11);
  @$pb.TagNumber(12)
  set priceChangePercentage24h($core.double v) { $_setDouble(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasPriceChangePercentage24h() => $_has(11);
  @$pb.TagNumber(12)
  void clearPriceChangePercentage24h() => clearField(12);

  @$pb.TagNumber(13)
  $core.double get priceChangePercentage7d => $_getN(12);
  @$pb.TagNumber(13)
  set priceChangePercentage7d($core.double v) { $_setDouble(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasPriceChangePercentage7d() => $_has(12);
  @$pb.TagNumber(13)
  void clearPriceChangePercentage7d() => clearField(13);

  @$pb.TagNumber(14)
  $core.double get priceChangePercentage30d => $_getN(13);
  @$pb.TagNumber(14)
  set priceChangePercentage30d($core.double v) { $_setDouble(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasPriceChangePercentage30d() => $_has(13);
  @$pb.TagNumber(14)
  void clearPriceChangePercentage30d() => clearField(14);

  @$pb.TagNumber(15)
  $core.double get priceChangePercentage1y => $_getN(14);
  @$pb.TagNumber(15)
  set priceChangePercentage1y($core.double v) { $_setDouble(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasPriceChangePercentage1y() => $_has(14);
  @$pb.TagNumber(15)
  void clearPriceChangePercentage1y() => clearField(15);

  @$pb.TagNumber(16)
  $core.double get circulatingSupply => $_getN(15);
  @$pb.TagNumber(16)
  set circulatingSupply($core.double v) { $_setDouble(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasCirculatingSupply() => $_has(15);
  @$pb.TagNumber(16)
  void clearCirculatingSupply() => clearField(16);

  @$pb.TagNumber(17)
  $core.double get totalSupply => $_getN(16);
  @$pb.TagNumber(17)
  set totalSupply($core.double v) { $_setDouble(16, v); }
  @$pb.TagNumber(17)
  $core.bool hasTotalSupply() => $_has(16);
  @$pb.TagNumber(17)
  void clearTotalSupply() => clearField(17);

  @$pb.TagNumber(18)
  $core.double get maxSupply => $_getN(17);
  @$pb.TagNumber(18)
  set maxSupply($core.double v) { $_setDouble(17, v); }
  @$pb.TagNumber(18)
  $core.bool hasMaxSupply() => $_has(17);
  @$pb.TagNumber(18)
  void clearMaxSupply() => clearField(18);

  @$pb.TagNumber(19)
  $core.double get ath => $_getN(18);
  @$pb.TagNumber(19)
  set ath($core.double v) { $_setDouble(18, v); }
  @$pb.TagNumber(19)
  $core.bool hasAth() => $_has(18);
  @$pb.TagNumber(19)
  void clearAth() => clearField(19);

  @$pb.TagNumber(20)
  $core.double get athChangePercentage => $_getN(19);
  @$pb.TagNumber(20)
  set athChangePercentage($core.double v) { $_setDouble(19, v); }
  @$pb.TagNumber(20)
  $core.bool hasAthChangePercentage() => $_has(19);
  @$pb.TagNumber(20)
  void clearAthChangePercentage() => clearField(20);

  @$pb.TagNumber(21)
  $1.Timestamp get athDate => $_getN(20);
  @$pb.TagNumber(21)
  set athDate($1.Timestamp v) { setField(21, v); }
  @$pb.TagNumber(21)
  $core.bool hasAthDate() => $_has(20);
  @$pb.TagNumber(21)
  void clearAthDate() => clearField(21);
  @$pb.TagNumber(21)
  $1.Timestamp ensureAthDate() => $_ensure(20);

  @$pb.TagNumber(22)
  $core.double get atl => $_getN(21);
  @$pb.TagNumber(22)
  set atl($core.double v) { $_setDouble(21, v); }
  @$pb.TagNumber(22)
  $core.bool hasAtl() => $_has(21);
  @$pb.TagNumber(22)
  void clearAtl() => clearField(22);

  @$pb.TagNumber(23)
  $core.double get atlChangePercentage => $_getN(22);
  @$pb.TagNumber(23)
  set atlChangePercentage($core.double v) { $_setDouble(22, v); }
  @$pb.TagNumber(23)
  $core.bool hasAtlChangePercentage() => $_has(22);
  @$pb.TagNumber(23)
  void clearAtlChangePercentage() => clearField(23);

  @$pb.TagNumber(24)
  $1.Timestamp get atlDate => $_getN(23);
  @$pb.TagNumber(24)
  set atlDate($1.Timestamp v) { setField(24, v); }
  @$pb.TagNumber(24)
  $core.bool hasAtlDate() => $_has(23);
  @$pb.TagNumber(24)
  void clearAtlDate() => clearField(24);
  @$pb.TagNumber(24)
  $1.Timestamp ensureAtlDate() => $_ensure(23);

  @$pb.TagNumber(25)
  $1.Timestamp get lastUpdated => $_getN(24);
  @$pb.TagNumber(25)
  set lastUpdated($1.Timestamp v) { setField(25, v); }
  @$pb.TagNumber(25)
  $core.bool hasLastUpdated() => $_has(24);
  @$pb.TagNumber(25)
  void clearLastUpdated() => clearField(25);
  @$pb.TagNumber(25)
  $1.Timestamp ensureLastUpdated() => $_ensure(24);

  @$pb.TagNumber(26)
  $core.List<PricePoint> get priceHistory => $_getList(25);

  @$pb.TagNumber(27)
  $core.String get description => $_getSZ(26);
  @$pb.TagNumber(27)
  set description($core.String v) { $_setString(26, v); }
  @$pb.TagNumber(27)
  $core.bool hasDescription() => $_has(26);
  @$pb.TagNumber(27)
  void clearDescription() => clearField(27);

  @$pb.TagNumber(28)
  $core.List<$core.String> get categories => $_getList(27);

  @$pb.TagNumber(29)
  $core.Map<$core.String, $core.String> get links => $_getMap(28);

  @$pb.TagNumber(30)
  $core.double get fullyDilutedValuation => $_getN(29);
  @$pb.TagNumber(30)
  set fullyDilutedValuation($core.double v) { $_setDouble(29, v); }
  @$pb.TagNumber(30)
  $core.bool hasFullyDilutedValuation() => $_has(29);
  @$pb.TagNumber(30)
  void clearFullyDilutedValuation() => clearField(30);

  @$pb.TagNumber(31)
  $core.double get marketCapChange24h => $_getN(30);
  @$pb.TagNumber(31)
  set marketCapChange24h($core.double v) { $_setDouble(30, v); }
  @$pb.TagNumber(31)
  $core.bool hasMarketCapChange24h() => $_has(30);
  @$pb.TagNumber(31)
  void clearMarketCapChange24h() => clearField(31);

  @$pb.TagNumber(32)
  $core.double get marketCapChangePercentage24h => $_getN(31);
  @$pb.TagNumber(32)
  set marketCapChangePercentage24h($core.double v) { $_setDouble(31, v); }
  @$pb.TagNumber(32)
  $core.bool hasMarketCapChangePercentage24h() => $_has(31);
  @$pb.TagNumber(32)
  void clearMarketCapChangePercentage24h() => clearField(32);
}

class PricePoint extends $pb.GeneratedMessage {
  factory PricePoint({
    $1.Timestamp? timestamp,
    $core.double? price,
    $core.double? volume,
    $core.double? marketCap,
    $core.double? open,
    $core.double? high,
    $core.double? low,
    $core.double? close,
  }) {
    final $result = create();
    if (timestamp != null) {
      $result.timestamp = timestamp;
    }
    if (price != null) {
      $result.price = price;
    }
    if (volume != null) {
      $result.volume = volume;
    }
    if (marketCap != null) {
      $result.marketCap = marketCap;
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
    return $result;
  }
  PricePoint._() : super();
  factory PricePoint.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PricePoint.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PricePoint', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<$1.Timestamp>(1, _omitFieldNames ? '' : 'timestamp', subBuilder: $1.Timestamp.create)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'price', $pb.PbFieldType.OD)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'volume', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'marketCap', $pb.PbFieldType.OD)
    ..a<$core.double>(5, _omitFieldNames ? '' : 'open', $pb.PbFieldType.OD)
    ..a<$core.double>(6, _omitFieldNames ? '' : 'high', $pb.PbFieldType.OD)
    ..a<$core.double>(7, _omitFieldNames ? '' : 'low', $pb.PbFieldType.OD)
    ..a<$core.double>(8, _omitFieldNames ? '' : 'close', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PricePoint clone() => PricePoint()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PricePoint copyWith(void Function(PricePoint) updates) => super.copyWith((message) => updates(message as PricePoint)) as PricePoint;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PricePoint create() => PricePoint._();
  PricePoint createEmptyInstance() => create();
  static $pb.PbList<PricePoint> createRepeated() => $pb.PbList<PricePoint>();
  @$core.pragma('dart2js:noInline')
  static PricePoint getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PricePoint>(create);
  static PricePoint? _defaultInstance;

  @$pb.TagNumber(1)
  $1.Timestamp get timestamp => $_getN(0);
  @$pb.TagNumber(1)
  set timestamp($1.Timestamp v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasTimestamp() => $_has(0);
  @$pb.TagNumber(1)
  void clearTimestamp() => clearField(1);
  @$pb.TagNumber(1)
  $1.Timestamp ensureTimestamp() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.double get price => $_getN(1);
  @$pb.TagNumber(2)
  set price($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPrice() => $_has(1);
  @$pb.TagNumber(2)
  void clearPrice() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get volume => $_getN(2);
  @$pb.TagNumber(3)
  set volume($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasVolume() => $_has(2);
  @$pb.TagNumber(3)
  void clearVolume() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get marketCap => $_getN(3);
  @$pb.TagNumber(4)
  set marketCap($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMarketCap() => $_has(3);
  @$pb.TagNumber(4)
  void clearMarketCap() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get open => $_getN(4);
  @$pb.TagNumber(5)
  set open($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasOpen() => $_has(4);
  @$pb.TagNumber(5)
  void clearOpen() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get high => $_getN(5);
  @$pb.TagNumber(6)
  set high($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasHigh() => $_has(5);
  @$pb.TagNumber(6)
  void clearHigh() => clearField(6);

  @$pb.TagNumber(7)
  $core.double get low => $_getN(6);
  @$pb.TagNumber(7)
  set low($core.double v) { $_setDouble(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasLow() => $_has(6);
  @$pb.TagNumber(7)
  void clearLow() => clearField(7);

  @$pb.TagNumber(8)
  $core.double get close => $_getN(7);
  @$pb.TagNumber(8)
  set close($core.double v) { $_setDouble(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasClose() => $_has(7);
  @$pb.TagNumber(8)
  void clearClose() => clearField(8);
}

class GetCryptosRequest extends $pb.GeneratedMessage {
  factory GetCryptosRequest({
    $core.int? page,
    $core.int? perPage,
    $core.String? vsCurrency,
    $core.String? order,
    $core.Iterable<$core.String>? ids,
    $core.String? category,
  }) {
    final $result = create();
    if (page != null) {
      $result.page = page;
    }
    if (perPage != null) {
      $result.perPage = perPage;
    }
    if (vsCurrency != null) {
      $result.vsCurrency = vsCurrency;
    }
    if (order != null) {
      $result.order = order;
    }
    if (ids != null) {
      $result.ids.addAll(ids);
    }
    if (category != null) {
      $result.category = category;
    }
    return $result;
  }
  GetCryptosRequest._() : super();
  factory GetCryptosRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCryptosRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetCryptosRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'perPage', $pb.PbFieldType.O3)
    ..aOS(3, _omitFieldNames ? '' : 'vsCurrency')
    ..aOS(4, _omitFieldNames ? '' : 'order')
    ..pPS(5, _omitFieldNames ? '' : 'ids')
    ..aOS(6, _omitFieldNames ? '' : 'category')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCryptosRequest clone() => GetCryptosRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCryptosRequest copyWith(void Function(GetCryptosRequest) updates) => super.copyWith((message) => updates(message as GetCryptosRequest)) as GetCryptosRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCryptosRequest create() => GetCryptosRequest._();
  GetCryptosRequest createEmptyInstance() => create();
  static $pb.PbList<GetCryptosRequest> createRepeated() => $pb.PbList<GetCryptosRequest>();
  @$core.pragma('dart2js:noInline')
  static GetCryptosRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetCryptosRequest>(create);
  static GetCryptosRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get page => $_getIZ(0);
  @$pb.TagNumber(1)
  set page($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearPage() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get perPage => $_getIZ(1);
  @$pb.TagNumber(2)
  set perPage($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPerPage() => $_has(1);
  @$pb.TagNumber(2)
  void clearPerPage() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get vsCurrency => $_getSZ(2);
  @$pb.TagNumber(3)
  set vsCurrency($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasVsCurrency() => $_has(2);
  @$pb.TagNumber(3)
  void clearVsCurrency() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get order => $_getSZ(3);
  @$pb.TagNumber(4)
  set order($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasOrder() => $_has(3);
  @$pb.TagNumber(4)
  void clearOrder() => clearField(4);

  @$pb.TagNumber(5)
  $core.List<$core.String> get ids => $_getList(4);

  @$pb.TagNumber(6)
  $core.String get category => $_getSZ(5);
  @$pb.TagNumber(6)
  set category($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasCategory() => $_has(5);
  @$pb.TagNumber(6)
  void clearCategory() => clearField(6);
}

class GetCryptosResponse extends $pb.GeneratedMessage {
  factory GetCryptosResponse({
    $core.Iterable<CryptoMessage>? cryptos,
    CryptoPaginationInfo? pagination,
  }) {
    final $result = create();
    if (cryptos != null) {
      $result.cryptos.addAll(cryptos);
    }
    if (pagination != null) {
      $result.pagination = pagination;
    }
    return $result;
  }
  GetCryptosResponse._() : super();
  factory GetCryptosResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCryptosResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetCryptosResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<CryptoMessage>(1, _omitFieldNames ? '' : 'cryptos', $pb.PbFieldType.PM, subBuilder: CryptoMessage.create)
    ..aOM<CryptoPaginationInfo>(2, _omitFieldNames ? '' : 'pagination', subBuilder: CryptoPaginationInfo.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCryptosResponse clone() => GetCryptosResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCryptosResponse copyWith(void Function(GetCryptosResponse) updates) => super.copyWith((message) => updates(message as GetCryptosResponse)) as GetCryptosResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCryptosResponse create() => GetCryptosResponse._();
  GetCryptosResponse createEmptyInstance() => create();
  static $pb.PbList<GetCryptosResponse> createRepeated() => $pb.PbList<GetCryptosResponse>();
  @$core.pragma('dart2js:noInline')
  static GetCryptosResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetCryptosResponse>(create);
  static GetCryptosResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<CryptoMessage> get cryptos => $_getList(0);

  @$pb.TagNumber(2)
  CryptoPaginationInfo get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination(CryptoPaginationInfo v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => clearField(2);
  @$pb.TagNumber(2)
  CryptoPaginationInfo ensurePagination() => $_ensure(1);
}

class GetCryptoByIdRequest extends $pb.GeneratedMessage {
  factory GetCryptoByIdRequest({
    $core.String? id,
    $core.bool? includeMarketData,
    $core.bool? includeCommunityData,
    $core.bool? includeDeveloperData,
    $core.String? vsCurrency,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (includeMarketData != null) {
      $result.includeMarketData = includeMarketData;
    }
    if (includeCommunityData != null) {
      $result.includeCommunityData = includeCommunityData;
    }
    if (includeDeveloperData != null) {
      $result.includeDeveloperData = includeDeveloperData;
    }
    if (vsCurrency != null) {
      $result.vsCurrency = vsCurrency;
    }
    return $result;
  }
  GetCryptoByIdRequest._() : super();
  factory GetCryptoByIdRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCryptoByIdRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetCryptoByIdRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOB(2, _omitFieldNames ? '' : 'includeMarketData')
    ..aOB(3, _omitFieldNames ? '' : 'includeCommunityData')
    ..aOB(4, _omitFieldNames ? '' : 'includeDeveloperData')
    ..aOS(5, _omitFieldNames ? '' : 'vsCurrency')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCryptoByIdRequest clone() => GetCryptoByIdRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCryptoByIdRequest copyWith(void Function(GetCryptoByIdRequest) updates) => super.copyWith((message) => updates(message as GetCryptoByIdRequest)) as GetCryptoByIdRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCryptoByIdRequest create() => GetCryptoByIdRequest._();
  GetCryptoByIdRequest createEmptyInstance() => create();
  static $pb.PbList<GetCryptoByIdRequest> createRepeated() => $pb.PbList<GetCryptoByIdRequest>();
  @$core.pragma('dart2js:noInline')
  static GetCryptoByIdRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetCryptoByIdRequest>(create);
  static GetCryptoByIdRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get includeMarketData => $_getBF(1);
  @$pb.TagNumber(2)
  set includeMarketData($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasIncludeMarketData() => $_has(1);
  @$pb.TagNumber(2)
  void clearIncludeMarketData() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get includeCommunityData => $_getBF(2);
  @$pb.TagNumber(3)
  set includeCommunityData($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasIncludeCommunityData() => $_has(2);
  @$pb.TagNumber(3)
  void clearIncludeCommunityData() => clearField(3);

  @$pb.TagNumber(4)
  $core.bool get includeDeveloperData => $_getBF(3);
  @$pb.TagNumber(4)
  set includeDeveloperData($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasIncludeDeveloperData() => $_has(3);
  @$pb.TagNumber(4)
  void clearIncludeDeveloperData() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get vsCurrency => $_getSZ(4);
  @$pb.TagNumber(5)
  set vsCurrency($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasVsCurrency() => $_has(4);
  @$pb.TagNumber(5)
  void clearVsCurrency() => clearField(5);
}

class GetCryptoByIdResponse extends $pb.GeneratedMessage {
  factory GetCryptoByIdResponse({
    CryptoMessage? crypto,
  }) {
    final $result = create();
    if (crypto != null) {
      $result.crypto = crypto;
    }
    return $result;
  }
  GetCryptoByIdResponse._() : super();
  factory GetCryptoByIdResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCryptoByIdResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetCryptoByIdResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<CryptoMessage>(1, _omitFieldNames ? '' : 'crypto', subBuilder: CryptoMessage.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCryptoByIdResponse clone() => GetCryptoByIdResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCryptoByIdResponse copyWith(void Function(GetCryptoByIdResponse) updates) => super.copyWith((message) => updates(message as GetCryptoByIdResponse)) as GetCryptoByIdResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCryptoByIdResponse create() => GetCryptoByIdResponse._();
  GetCryptoByIdResponse createEmptyInstance() => create();
  static $pb.PbList<GetCryptoByIdResponse> createRepeated() => $pb.PbList<GetCryptoByIdResponse>();
  @$core.pragma('dart2js:noInline')
  static GetCryptoByIdResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetCryptoByIdResponse>(create);
  static GetCryptoByIdResponse? _defaultInstance;

  @$pb.TagNumber(1)
  CryptoMessage get crypto => $_getN(0);
  @$pb.TagNumber(1)
  set crypto(CryptoMessage v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasCrypto() => $_has(0);
  @$pb.TagNumber(1)
  void clearCrypto() => clearField(1);
  @$pb.TagNumber(1)
  CryptoMessage ensureCrypto() => $_ensure(0);
}

class SearchCryptosRequest extends $pb.GeneratedMessage {
  factory SearchCryptosRequest({
    $core.String? query,
  }) {
    final $result = create();
    if (query != null) {
      $result.query = query;
    }
    return $result;
  }
  SearchCryptosRequest._() : super();
  factory SearchCryptosRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SearchCryptosRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SearchCryptosRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'query')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SearchCryptosRequest clone() => SearchCryptosRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SearchCryptosRequest copyWith(void Function(SearchCryptosRequest) updates) => super.copyWith((message) => updates(message as SearchCryptosRequest)) as SearchCryptosRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SearchCryptosRequest create() => SearchCryptosRequest._();
  SearchCryptosRequest createEmptyInstance() => create();
  static $pb.PbList<SearchCryptosRequest> createRepeated() => $pb.PbList<SearchCryptosRequest>();
  @$core.pragma('dart2js:noInline')
  static SearchCryptosRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SearchCryptosRequest>(create);
  static SearchCryptosRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get query => $_getSZ(0);
  @$pb.TagNumber(1)
  set query($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasQuery() => $_has(0);
  @$pb.TagNumber(1)
  void clearQuery() => clearField(1);
}

class SearchCryptosResponse extends $pb.GeneratedMessage {
  factory SearchCryptosResponse({
    $core.Iterable<CryptoMessage>? cryptos,
  }) {
    final $result = create();
    if (cryptos != null) {
      $result.cryptos.addAll(cryptos);
    }
    return $result;
  }
  SearchCryptosResponse._() : super();
  factory SearchCryptosResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SearchCryptosResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SearchCryptosResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<CryptoMessage>(1, _omitFieldNames ? '' : 'cryptos', $pb.PbFieldType.PM, subBuilder: CryptoMessage.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SearchCryptosResponse clone() => SearchCryptosResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SearchCryptosResponse copyWith(void Function(SearchCryptosResponse) updates) => super.copyWith((message) => updates(message as SearchCryptosResponse)) as SearchCryptosResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SearchCryptosResponse create() => SearchCryptosResponse._();
  SearchCryptosResponse createEmptyInstance() => create();
  static $pb.PbList<SearchCryptosResponse> createRepeated() => $pb.PbList<SearchCryptosResponse>();
  @$core.pragma('dart2js:noInline')
  static SearchCryptosResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SearchCryptosResponse>(create);
  static SearchCryptosResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<CryptoMessage> get cryptos => $_getList(0);
}

class GetCryptoPriceHistoryRequest extends $pb.GeneratedMessage {
  factory GetCryptoPriceHistoryRequest({
    $core.String? id,
    $core.String? range,
    $core.String? vsCurrency,
    $core.int? interval,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (range != null) {
      $result.range = range;
    }
    if (vsCurrency != null) {
      $result.vsCurrency = vsCurrency;
    }
    if (interval != null) {
      $result.interval = interval;
    }
    return $result;
  }
  GetCryptoPriceHistoryRequest._() : super();
  factory GetCryptoPriceHistoryRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCryptoPriceHistoryRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetCryptoPriceHistoryRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'range')
    ..aOS(3, _omitFieldNames ? '' : 'vsCurrency')
    ..a<$core.int>(4, _omitFieldNames ? '' : 'interval', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCryptoPriceHistoryRequest clone() => GetCryptoPriceHistoryRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCryptoPriceHistoryRequest copyWith(void Function(GetCryptoPriceHistoryRequest) updates) => super.copyWith((message) => updates(message as GetCryptoPriceHistoryRequest)) as GetCryptoPriceHistoryRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCryptoPriceHistoryRequest create() => GetCryptoPriceHistoryRequest._();
  GetCryptoPriceHistoryRequest createEmptyInstance() => create();
  static $pb.PbList<GetCryptoPriceHistoryRequest> createRepeated() => $pb.PbList<GetCryptoPriceHistoryRequest>();
  @$core.pragma('dart2js:noInline')
  static GetCryptoPriceHistoryRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetCryptoPriceHistoryRequest>(create);
  static GetCryptoPriceHistoryRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get range => $_getSZ(1);
  @$pb.TagNumber(2)
  set range($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasRange() => $_has(1);
  @$pb.TagNumber(2)
  void clearRange() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get vsCurrency => $_getSZ(2);
  @$pb.TagNumber(3)
  set vsCurrency($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasVsCurrency() => $_has(2);
  @$pb.TagNumber(3)
  void clearVsCurrency() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get interval => $_getIZ(3);
  @$pb.TagNumber(4)
  set interval($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasInterval() => $_has(3);
  @$pb.TagNumber(4)
  void clearInterval() => clearField(4);
}

class GetCryptoPriceHistoryResponse extends $pb.GeneratedMessage {
  factory GetCryptoPriceHistoryResponse({
    $core.Iterable<PricePoint>? priceHistory,
    $core.String? cryptoId,
    $core.String? range,
  }) {
    final $result = create();
    if (priceHistory != null) {
      $result.priceHistory.addAll(priceHistory);
    }
    if (cryptoId != null) {
      $result.cryptoId = cryptoId;
    }
    if (range != null) {
      $result.range = range;
    }
    return $result;
  }
  GetCryptoPriceHistoryResponse._() : super();
  factory GetCryptoPriceHistoryResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCryptoPriceHistoryResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetCryptoPriceHistoryResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<PricePoint>(1, _omitFieldNames ? '' : 'priceHistory', $pb.PbFieldType.PM, subBuilder: PricePoint.create)
    ..aOS(2, _omitFieldNames ? '' : 'cryptoId')
    ..aOS(3, _omitFieldNames ? '' : 'range')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCryptoPriceHistoryResponse clone() => GetCryptoPriceHistoryResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCryptoPriceHistoryResponse copyWith(void Function(GetCryptoPriceHistoryResponse) updates) => super.copyWith((message) => updates(message as GetCryptoPriceHistoryResponse)) as GetCryptoPriceHistoryResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCryptoPriceHistoryResponse create() => GetCryptoPriceHistoryResponse._();
  GetCryptoPriceHistoryResponse createEmptyInstance() => create();
  static $pb.PbList<GetCryptoPriceHistoryResponse> createRepeated() => $pb.PbList<GetCryptoPriceHistoryResponse>();
  @$core.pragma('dart2js:noInline')
  static GetCryptoPriceHistoryResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetCryptoPriceHistoryResponse>(create);
  static GetCryptoPriceHistoryResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<PricePoint> get priceHistory => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get cryptoId => $_getSZ(1);
  @$pb.TagNumber(2)
  set cryptoId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCryptoId() => $_has(1);
  @$pb.TagNumber(2)
  void clearCryptoId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get range => $_getSZ(2);
  @$pb.TagNumber(3)
  set range($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasRange() => $_has(2);
  @$pb.TagNumber(3)
  void clearRange() => clearField(3);
}

class GetTrendingCryptosRequest extends $pb.GeneratedMessage {
  factory GetTrendingCryptosRequest({
    $core.int? limit,
  }) {
    final $result = create();
    if (limit != null) {
      $result.limit = limit;
    }
    return $result;
  }
  GetTrendingCryptosRequest._() : super();
  factory GetTrendingCryptosRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTrendingCryptosRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetTrendingCryptosRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetTrendingCryptosRequest clone() => GetTrendingCryptosRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetTrendingCryptosRequest copyWith(void Function(GetTrendingCryptosRequest) updates) => super.copyWith((message) => updates(message as GetTrendingCryptosRequest)) as GetTrendingCryptosRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTrendingCryptosRequest create() => GetTrendingCryptosRequest._();
  GetTrendingCryptosRequest createEmptyInstance() => create();
  static $pb.PbList<GetTrendingCryptosRequest> createRepeated() => $pb.PbList<GetTrendingCryptosRequest>();
  @$core.pragma('dart2js:noInline')
  static GetTrendingCryptosRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTrendingCryptosRequest>(create);
  static GetTrendingCryptosRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get limit => $_getIZ(0);
  @$pb.TagNumber(1)
  set limit($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLimit() => $_has(0);
  @$pb.TagNumber(1)
  void clearLimit() => clearField(1);
}

class GetTrendingCryptosResponse extends $pb.GeneratedMessage {
  factory GetTrendingCryptosResponse({
    $core.Iterable<CryptoMessage>? cryptos,
  }) {
    final $result = create();
    if (cryptos != null) {
      $result.cryptos.addAll(cryptos);
    }
    return $result;
  }
  GetTrendingCryptosResponse._() : super();
  factory GetTrendingCryptosResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTrendingCryptosResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetTrendingCryptosResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<CryptoMessage>(1, _omitFieldNames ? '' : 'cryptos', $pb.PbFieldType.PM, subBuilder: CryptoMessage.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetTrendingCryptosResponse clone() => GetTrendingCryptosResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetTrendingCryptosResponse copyWith(void Function(GetTrendingCryptosResponse) updates) => super.copyWith((message) => updates(message as GetTrendingCryptosResponse)) as GetTrendingCryptosResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTrendingCryptosResponse create() => GetTrendingCryptosResponse._();
  GetTrendingCryptosResponse createEmptyInstance() => create();
  static $pb.PbList<GetTrendingCryptosResponse> createRepeated() => $pb.PbList<GetTrendingCryptosResponse>();
  @$core.pragma('dart2js:noInline')
  static GetTrendingCryptosResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTrendingCryptosResponse>(create);
  static GetTrendingCryptosResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<CryptoMessage> get cryptos => $_getList(0);
}

class GetTopCryptosRequest extends $pb.GeneratedMessage {
  factory GetTopCryptosRequest({
    $core.int? limit,
    $core.String? vsCurrency,
  }) {
    final $result = create();
    if (limit != null) {
      $result.limit = limit;
    }
    if (vsCurrency != null) {
      $result.vsCurrency = vsCurrency;
    }
    return $result;
  }
  GetTopCryptosRequest._() : super();
  factory GetTopCryptosRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTopCryptosRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetTopCryptosRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..aOS(2, _omitFieldNames ? '' : 'vsCurrency')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetTopCryptosRequest clone() => GetTopCryptosRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetTopCryptosRequest copyWith(void Function(GetTopCryptosRequest) updates) => super.copyWith((message) => updates(message as GetTopCryptosRequest)) as GetTopCryptosRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTopCryptosRequest create() => GetTopCryptosRequest._();
  GetTopCryptosRequest createEmptyInstance() => create();
  static $pb.PbList<GetTopCryptosRequest> createRepeated() => $pb.PbList<GetTopCryptosRequest>();
  @$core.pragma('dart2js:noInline')
  static GetTopCryptosRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTopCryptosRequest>(create);
  static GetTopCryptosRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get limit => $_getIZ(0);
  @$pb.TagNumber(1)
  set limit($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLimit() => $_has(0);
  @$pb.TagNumber(1)
  void clearLimit() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get vsCurrency => $_getSZ(1);
  @$pb.TagNumber(2)
  set vsCurrency($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasVsCurrency() => $_has(1);
  @$pb.TagNumber(2)
  void clearVsCurrency() => clearField(2);
}

class GetTopCryptosResponse extends $pb.GeneratedMessage {
  factory GetTopCryptosResponse({
    $core.Iterable<CryptoMessage>? cryptos,
  }) {
    final $result = create();
    if (cryptos != null) {
      $result.cryptos.addAll(cryptos);
    }
    return $result;
  }
  GetTopCryptosResponse._() : super();
  factory GetTopCryptosResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTopCryptosResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetTopCryptosResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<CryptoMessage>(1, _omitFieldNames ? '' : 'cryptos', $pb.PbFieldType.PM, subBuilder: CryptoMessage.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetTopCryptosResponse clone() => GetTopCryptosResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetTopCryptosResponse copyWith(void Function(GetTopCryptosResponse) updates) => super.copyWith((message) => updates(message as GetTopCryptosResponse)) as GetTopCryptosResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTopCryptosResponse create() => GetTopCryptosResponse._();
  GetTopCryptosResponse createEmptyInstance() => create();
  static $pb.PbList<GetTopCryptosResponse> createRepeated() => $pb.PbList<GetTopCryptosResponse>();
  @$core.pragma('dart2js:noInline')
  static GetTopCryptosResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTopCryptosResponse>(create);
  static GetTopCryptosResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<CryptoMessage> get cryptos => $_getList(0);
}

class GetMarketChartRequest extends $pb.GeneratedMessage {
  factory GetMarketChartRequest({
    $core.String? id,
    $core.String? vsCurrency,
    $core.int? days,
    $core.String? interval,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (vsCurrency != null) {
      $result.vsCurrency = vsCurrency;
    }
    if (days != null) {
      $result.days = days;
    }
    if (interval != null) {
      $result.interval = interval;
    }
    return $result;
  }
  GetMarketChartRequest._() : super();
  factory GetMarketChartRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMarketChartRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetMarketChartRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'vsCurrency')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'days', $pb.PbFieldType.O3)
    ..aOS(4, _omitFieldNames ? '' : 'interval')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMarketChartRequest clone() => GetMarketChartRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMarketChartRequest copyWith(void Function(GetMarketChartRequest) updates) => super.copyWith((message) => updates(message as GetMarketChartRequest)) as GetMarketChartRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMarketChartRequest create() => GetMarketChartRequest._();
  GetMarketChartRequest createEmptyInstance() => create();
  static $pb.PbList<GetMarketChartRequest> createRepeated() => $pb.PbList<GetMarketChartRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMarketChartRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMarketChartRequest>(create);
  static GetMarketChartRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get vsCurrency => $_getSZ(1);
  @$pb.TagNumber(2)
  set vsCurrency($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasVsCurrency() => $_has(1);
  @$pb.TagNumber(2)
  void clearVsCurrency() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get days => $_getIZ(2);
  @$pb.TagNumber(3)
  set days($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDays() => $_has(2);
  @$pb.TagNumber(3)
  void clearDays() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get interval => $_getSZ(3);
  @$pb.TagNumber(4)
  set interval($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasInterval() => $_has(3);
  @$pb.TagNumber(4)
  void clearInterval() => clearField(4);
}

class GetMarketChartResponse extends $pb.GeneratedMessage {
  factory GetMarketChartResponse({
    $core.Iterable<PricePoint>? prices,
    $core.Iterable<PricePoint>? marketCaps,
    $core.Iterable<PricePoint>? totalVolumes,
  }) {
    final $result = create();
    if (prices != null) {
      $result.prices.addAll(prices);
    }
    if (marketCaps != null) {
      $result.marketCaps.addAll(marketCaps);
    }
    if (totalVolumes != null) {
      $result.totalVolumes.addAll(totalVolumes);
    }
    return $result;
  }
  GetMarketChartResponse._() : super();
  factory GetMarketChartResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMarketChartResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetMarketChartResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<PricePoint>(1, _omitFieldNames ? '' : 'prices', $pb.PbFieldType.PM, subBuilder: PricePoint.create)
    ..pc<PricePoint>(2, _omitFieldNames ? '' : 'marketCaps', $pb.PbFieldType.PM, subBuilder: PricePoint.create)
    ..pc<PricePoint>(3, _omitFieldNames ? '' : 'totalVolumes', $pb.PbFieldType.PM, subBuilder: PricePoint.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMarketChartResponse clone() => GetMarketChartResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMarketChartResponse copyWith(void Function(GetMarketChartResponse) updates) => super.copyWith((message) => updates(message as GetMarketChartResponse)) as GetMarketChartResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMarketChartResponse create() => GetMarketChartResponse._();
  GetMarketChartResponse createEmptyInstance() => create();
  static $pb.PbList<GetMarketChartResponse> createRepeated() => $pb.PbList<GetMarketChartResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMarketChartResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMarketChartResponse>(create);
  static GetMarketChartResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<PricePoint> get prices => $_getList(0);

  @$pb.TagNumber(2)
  $core.List<PricePoint> get marketCaps => $_getList(1);

  @$pb.TagNumber(3)
  $core.List<PricePoint> get totalVolumes => $_getList(2);
}

class GetGlobalMarketDataRequest extends $pb.GeneratedMessage {
  factory GetGlobalMarketDataRequest() => create();
  GetGlobalMarketDataRequest._() : super();
  factory GetGlobalMarketDataRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetGlobalMarketDataRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetGlobalMarketDataRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetGlobalMarketDataRequest clone() => GetGlobalMarketDataRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetGlobalMarketDataRequest copyWith(void Function(GetGlobalMarketDataRequest) updates) => super.copyWith((message) => updates(message as GetGlobalMarketDataRequest)) as GetGlobalMarketDataRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetGlobalMarketDataRequest create() => GetGlobalMarketDataRequest._();
  GetGlobalMarketDataRequest createEmptyInstance() => create();
  static $pb.PbList<GetGlobalMarketDataRequest> createRepeated() => $pb.PbList<GetGlobalMarketDataRequest>();
  @$core.pragma('dart2js:noInline')
  static GetGlobalMarketDataRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetGlobalMarketDataRequest>(create);
  static GetGlobalMarketDataRequest? _defaultInstance;
}

class GetGlobalMarketDataResponse extends $pb.GeneratedMessage {
  factory GetGlobalMarketDataResponse({
    $core.double? totalMarketCap,
    $core.double? totalVolume24h,
    $core.double? marketCapPercentageBtc,
    $core.double? marketCapPercentageEth,
    $core.int? activeCryptocurrencies,
    $core.int? markets,
    $1.Timestamp? updatedAt,
  }) {
    final $result = create();
    if (totalMarketCap != null) {
      $result.totalMarketCap = totalMarketCap;
    }
    if (totalVolume24h != null) {
      $result.totalVolume24h = totalVolume24h;
    }
    if (marketCapPercentageBtc != null) {
      $result.marketCapPercentageBtc = marketCapPercentageBtc;
    }
    if (marketCapPercentageEth != null) {
      $result.marketCapPercentageEth = marketCapPercentageEth;
    }
    if (activeCryptocurrencies != null) {
      $result.activeCryptocurrencies = activeCryptocurrencies;
    }
    if (markets != null) {
      $result.markets = markets;
    }
    if (updatedAt != null) {
      $result.updatedAt = updatedAt;
    }
    return $result;
  }
  GetGlobalMarketDataResponse._() : super();
  factory GetGlobalMarketDataResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetGlobalMarketDataResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetGlobalMarketDataResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'totalMarketCap', $pb.PbFieldType.OD)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'totalVolume24h', $pb.PbFieldType.OD, protoName: 'total_volume_24h')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'marketCapPercentageBtc', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'marketCapPercentageEth', $pb.PbFieldType.OD)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'activeCryptocurrencies', $pb.PbFieldType.O3)
    ..a<$core.int>(6, _omitFieldNames ? '' : 'markets', $pb.PbFieldType.O3)
    ..aOM<$1.Timestamp>(7, _omitFieldNames ? '' : 'updatedAt', subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetGlobalMarketDataResponse clone() => GetGlobalMarketDataResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetGlobalMarketDataResponse copyWith(void Function(GetGlobalMarketDataResponse) updates) => super.copyWith((message) => updates(message as GetGlobalMarketDataResponse)) as GetGlobalMarketDataResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetGlobalMarketDataResponse create() => GetGlobalMarketDataResponse._();
  GetGlobalMarketDataResponse createEmptyInstance() => create();
  static $pb.PbList<GetGlobalMarketDataResponse> createRepeated() => $pb.PbList<GetGlobalMarketDataResponse>();
  @$core.pragma('dart2js:noInline')
  static GetGlobalMarketDataResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetGlobalMarketDataResponse>(create);
  static GetGlobalMarketDataResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get totalMarketCap => $_getN(0);
  @$pb.TagNumber(1)
  set totalMarketCap($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTotalMarketCap() => $_has(0);
  @$pb.TagNumber(1)
  void clearTotalMarketCap() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get totalVolume24h => $_getN(1);
  @$pb.TagNumber(2)
  set totalVolume24h($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotalVolume24h() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalVolume24h() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get marketCapPercentageBtc => $_getN(2);
  @$pb.TagNumber(3)
  set marketCapPercentageBtc($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMarketCapPercentageBtc() => $_has(2);
  @$pb.TagNumber(3)
  void clearMarketCapPercentageBtc() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get marketCapPercentageEth => $_getN(3);
  @$pb.TagNumber(4)
  set marketCapPercentageEth($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMarketCapPercentageEth() => $_has(3);
  @$pb.TagNumber(4)
  void clearMarketCapPercentageEth() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get activeCryptocurrencies => $_getIZ(4);
  @$pb.TagNumber(5)
  set activeCryptocurrencies($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasActiveCryptocurrencies() => $_has(4);
  @$pb.TagNumber(5)
  void clearActiveCryptocurrencies() => clearField(5);

  @$pb.TagNumber(6)
  $core.int get markets => $_getIZ(5);
  @$pb.TagNumber(6)
  set markets($core.int v) { $_setSignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasMarkets() => $_has(5);
  @$pb.TagNumber(6)
  void clearMarkets() => clearField(6);

  @$pb.TagNumber(7)
  $1.Timestamp get updatedAt => $_getN(6);
  @$pb.TagNumber(7)
  set updatedAt($1.Timestamp v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasUpdatedAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearUpdatedAt() => clearField(7);
  @$pb.TagNumber(7)
  $1.Timestamp ensureUpdatedAt() => $_ensure(6);
}

class GetCryptoFiatRateRequest extends $pb.GeneratedMessage {
  factory GetCryptoFiatRateRequest({
    $core.String? cryptoId,
    $core.String? fiatCurrency,
  }) {
    final $result = create();
    if (cryptoId != null) {
      $result.cryptoId = cryptoId;
    }
    if (fiatCurrency != null) {
      $result.fiatCurrency = fiatCurrency;
    }
    return $result;
  }
  GetCryptoFiatRateRequest._() : super();
  factory GetCryptoFiatRateRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCryptoFiatRateRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetCryptoFiatRateRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'cryptoId')
    ..aOS(2, _omitFieldNames ? '' : 'fiatCurrency')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCryptoFiatRateRequest clone() => GetCryptoFiatRateRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCryptoFiatRateRequest copyWith(void Function(GetCryptoFiatRateRequest) updates) => super.copyWith((message) => updates(message as GetCryptoFiatRateRequest)) as GetCryptoFiatRateRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCryptoFiatRateRequest create() => GetCryptoFiatRateRequest._();
  GetCryptoFiatRateRequest createEmptyInstance() => create();
  static $pb.PbList<GetCryptoFiatRateRequest> createRepeated() => $pb.PbList<GetCryptoFiatRateRequest>();
  @$core.pragma('dart2js:noInline')
  static GetCryptoFiatRateRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetCryptoFiatRateRequest>(create);
  static GetCryptoFiatRateRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get cryptoId => $_getSZ(0);
  @$pb.TagNumber(1)
  set cryptoId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCryptoId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCryptoId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get fiatCurrency => $_getSZ(1);
  @$pb.TagNumber(2)
  set fiatCurrency($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFiatCurrency() => $_has(1);
  @$pb.TagNumber(2)
  void clearFiatCurrency() => clearField(2);
}

class GetCryptoFiatRateResponse extends $pb.GeneratedMessage {
  factory GetCryptoFiatRateResponse({
    $core.String? cryptoId,
    $core.String? fiatCurrency,
    $core.double? rate,
    $core.double? feePercentage,
    $core.double? spread,
    $1.Timestamp? validUntil,
  }) {
    final $result = create();
    if (cryptoId != null) {
      $result.cryptoId = cryptoId;
    }
    if (fiatCurrency != null) {
      $result.fiatCurrency = fiatCurrency;
    }
    if (rate != null) {
      $result.rate = rate;
    }
    if (feePercentage != null) {
      $result.feePercentage = feePercentage;
    }
    if (spread != null) {
      $result.spread = spread;
    }
    if (validUntil != null) {
      $result.validUntil = validUntil;
    }
    return $result;
  }
  GetCryptoFiatRateResponse._() : super();
  factory GetCryptoFiatRateResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCryptoFiatRateResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetCryptoFiatRateResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'cryptoId')
    ..aOS(2, _omitFieldNames ? '' : 'fiatCurrency')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'rate', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'feePercentage', $pb.PbFieldType.OD)
    ..a<$core.double>(5, _omitFieldNames ? '' : 'spread', $pb.PbFieldType.OD)
    ..aOM<$1.Timestamp>(6, _omitFieldNames ? '' : 'validUntil', subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCryptoFiatRateResponse clone() => GetCryptoFiatRateResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCryptoFiatRateResponse copyWith(void Function(GetCryptoFiatRateResponse) updates) => super.copyWith((message) => updates(message as GetCryptoFiatRateResponse)) as GetCryptoFiatRateResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCryptoFiatRateResponse create() => GetCryptoFiatRateResponse._();
  GetCryptoFiatRateResponse createEmptyInstance() => create();
  static $pb.PbList<GetCryptoFiatRateResponse> createRepeated() => $pb.PbList<GetCryptoFiatRateResponse>();
  @$core.pragma('dart2js:noInline')
  static GetCryptoFiatRateResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetCryptoFiatRateResponse>(create);
  static GetCryptoFiatRateResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get cryptoId => $_getSZ(0);
  @$pb.TagNumber(1)
  set cryptoId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCryptoId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCryptoId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get fiatCurrency => $_getSZ(1);
  @$pb.TagNumber(2)
  set fiatCurrency($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFiatCurrency() => $_has(1);
  @$pb.TagNumber(2)
  void clearFiatCurrency() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get rate => $_getN(2);
  @$pb.TagNumber(3)
  set rate($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasRate() => $_has(2);
  @$pb.TagNumber(3)
  void clearRate() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get feePercentage => $_getN(3);
  @$pb.TagNumber(4)
  set feePercentage($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasFeePercentage() => $_has(3);
  @$pb.TagNumber(4)
  void clearFeePercentage() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get spread => $_getN(4);
  @$pb.TagNumber(5)
  set spread($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasSpread() => $_has(4);
  @$pb.TagNumber(5)
  void clearSpread() => clearField(5);

  @$pb.TagNumber(6)
  $1.Timestamp get validUntil => $_getN(5);
  @$pb.TagNumber(6)
  set validUntil($1.Timestamp v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasValidUntil() => $_has(5);
  @$pb.TagNumber(6)
  void clearValidUntil() => clearField(6);
  @$pb.TagNumber(6)
  $1.Timestamp ensureValidUntil() => $_ensure(5);
}

class GetCryptoHoldingsRequest extends $pb.GeneratedMessage {
  factory GetCryptoHoldingsRequest({
    $core.String? userId,
  }) {
    final $result = create();
    if (userId != null) {
      $result.userId = userId;
    }
    return $result;
  }
  GetCryptoHoldingsRequest._() : super();
  factory GetCryptoHoldingsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCryptoHoldingsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetCryptoHoldingsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCryptoHoldingsRequest clone() => GetCryptoHoldingsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCryptoHoldingsRequest copyWith(void Function(GetCryptoHoldingsRequest) updates) => super.copyWith((message) => updates(message as GetCryptoHoldingsRequest)) as GetCryptoHoldingsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCryptoHoldingsRequest create() => GetCryptoHoldingsRequest._();
  GetCryptoHoldingsRequest createEmptyInstance() => create();
  static $pb.PbList<GetCryptoHoldingsRequest> createRepeated() => $pb.PbList<GetCryptoHoldingsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetCryptoHoldingsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetCryptoHoldingsRequest>(create);
  static GetCryptoHoldingsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);
}

class GetCryptoHolding extends $pb.GeneratedMessage {
  factory GetCryptoHolding({
    $core.String? cryptoId,
    $core.String? symbol,
    $core.String? name,
    $core.double? balance,
    $core.double? fiatValue,
    $core.String? fiatCurrency,
    $1.Timestamp? acquiredAt,
  }) {
    final $result = create();
    if (cryptoId != null) {
      $result.cryptoId = cryptoId;
    }
    if (symbol != null) {
      $result.symbol = symbol;
    }
    if (name != null) {
      $result.name = name;
    }
    if (balance != null) {
      $result.balance = balance;
    }
    if (fiatValue != null) {
      $result.fiatValue = fiatValue;
    }
    if (fiatCurrency != null) {
      $result.fiatCurrency = fiatCurrency;
    }
    if (acquiredAt != null) {
      $result.acquiredAt = acquiredAt;
    }
    return $result;
  }
  GetCryptoHolding._() : super();
  factory GetCryptoHolding.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCryptoHolding.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetCryptoHolding', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'cryptoId')
    ..aOS(2, _omitFieldNames ? '' : 'symbol')
    ..aOS(3, _omitFieldNames ? '' : 'name')
    ..a<$core.double>(4, _omitFieldNames ? '' : 'balance', $pb.PbFieldType.OD)
    ..a<$core.double>(5, _omitFieldNames ? '' : 'fiatValue', $pb.PbFieldType.OD)
    ..aOS(6, _omitFieldNames ? '' : 'fiatCurrency')
    ..aOM<$1.Timestamp>(7, _omitFieldNames ? '' : 'acquiredAt', subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCryptoHolding clone() => GetCryptoHolding()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCryptoHolding copyWith(void Function(GetCryptoHolding) updates) => super.copyWith((message) => updates(message as GetCryptoHolding)) as GetCryptoHolding;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCryptoHolding create() => GetCryptoHolding._();
  GetCryptoHolding createEmptyInstance() => create();
  static $pb.PbList<GetCryptoHolding> createRepeated() => $pb.PbList<GetCryptoHolding>();
  @$core.pragma('dart2js:noInline')
  static GetCryptoHolding getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetCryptoHolding>(create);
  static GetCryptoHolding? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get cryptoId => $_getSZ(0);
  @$pb.TagNumber(1)
  set cryptoId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCryptoId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCryptoId() => clearField(1);

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
  $core.double get balance => $_getN(3);
  @$pb.TagNumber(4)
  set balance($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasBalance() => $_has(3);
  @$pb.TagNumber(4)
  void clearBalance() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get fiatValue => $_getN(4);
  @$pb.TagNumber(5)
  set fiatValue($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasFiatValue() => $_has(4);
  @$pb.TagNumber(5)
  void clearFiatValue() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get fiatCurrency => $_getSZ(5);
  @$pb.TagNumber(6)
  set fiatCurrency($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasFiatCurrency() => $_has(5);
  @$pb.TagNumber(6)
  void clearFiatCurrency() => clearField(6);

  @$pb.TagNumber(7)
  $1.Timestamp get acquiredAt => $_getN(6);
  @$pb.TagNumber(7)
  set acquiredAt($1.Timestamp v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasAcquiredAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearAcquiredAt() => clearField(7);
  @$pb.TagNumber(7)
  $1.Timestamp ensureAcquiredAt() => $_ensure(6);
}

class GetCryptoHoldingsResponse extends $pb.GeneratedMessage {
  factory GetCryptoHoldingsResponse({
    $core.Iterable<GetCryptoHolding>? holdings,
    $core.double? totalFiatValue,
    $core.String? fiatCurrency,
  }) {
    final $result = create();
    if (holdings != null) {
      $result.holdings.addAll(holdings);
    }
    if (totalFiatValue != null) {
      $result.totalFiatValue = totalFiatValue;
    }
    if (fiatCurrency != null) {
      $result.fiatCurrency = fiatCurrency;
    }
    return $result;
  }
  GetCryptoHoldingsResponse._() : super();
  factory GetCryptoHoldingsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCryptoHoldingsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetCryptoHoldingsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<GetCryptoHolding>(1, _omitFieldNames ? '' : 'holdings', $pb.PbFieldType.PM, subBuilder: GetCryptoHolding.create)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'totalFiatValue', $pb.PbFieldType.OD)
    ..aOS(3, _omitFieldNames ? '' : 'fiatCurrency')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCryptoHoldingsResponse clone() => GetCryptoHoldingsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCryptoHoldingsResponse copyWith(void Function(GetCryptoHoldingsResponse) updates) => super.copyWith((message) => updates(message as GetCryptoHoldingsResponse)) as GetCryptoHoldingsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCryptoHoldingsResponse create() => GetCryptoHoldingsResponse._();
  GetCryptoHoldingsResponse createEmptyInstance() => create();
  static $pb.PbList<GetCryptoHoldingsResponse> createRepeated() => $pb.PbList<GetCryptoHoldingsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetCryptoHoldingsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetCryptoHoldingsResponse>(create);
  static GetCryptoHoldingsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<GetCryptoHolding> get holdings => $_getList(0);

  @$pb.TagNumber(2)
  $core.double get totalFiatValue => $_getN(1);
  @$pb.TagNumber(2)
  set totalFiatValue($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotalFiatValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalFiatValue() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get fiatCurrency => $_getSZ(2);
  @$pb.TagNumber(3)
  set fiatCurrency($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasFiatCurrency() => $_has(2);
  @$pb.TagNumber(3)
  void clearFiatCurrency() => clearField(3);
}

class GetCryptoTransactionsRequest extends $pb.GeneratedMessage {
  factory GetCryptoTransactionsRequest({
    $core.String? userId,
    $core.int? limit,
    $core.int? offset,
  }) {
    final $result = create();
    if (userId != null) {
      $result.userId = userId;
    }
    if (limit != null) {
      $result.limit = limit;
    }
    if (offset != null) {
      $result.offset = offset;
    }
    return $result;
  }
  GetCryptoTransactionsRequest._() : super();
  factory GetCryptoTransactionsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCryptoTransactionsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetCryptoTransactionsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCryptoTransactionsRequest clone() => GetCryptoTransactionsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCryptoTransactionsRequest copyWith(void Function(GetCryptoTransactionsRequest) updates) => super.copyWith((message) => updates(message as GetCryptoTransactionsRequest)) as GetCryptoTransactionsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCryptoTransactionsRequest create() => GetCryptoTransactionsRequest._();
  GetCryptoTransactionsRequest createEmptyInstance() => create();
  static $pb.PbList<GetCryptoTransactionsRequest> createRepeated() => $pb.PbList<GetCryptoTransactionsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetCryptoTransactionsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetCryptoTransactionsRequest>(create);
  static GetCryptoTransactionsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

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

class CryptoTransaction extends $pb.GeneratedMessage {
  factory CryptoTransaction({
    $core.String? id,
    $core.String? type,
    $core.String? cryptoId,
    $core.String? cryptoSymbol,
    $core.double? amount,
    $core.double? fiatValue,
    $core.String? fiatCurrency,
    $1.Timestamp? timestamp,
    $core.String? status,
    $core.double? fee,
    $core.double? exchangeRate,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (type != null) {
      $result.type = type;
    }
    if (cryptoId != null) {
      $result.cryptoId = cryptoId;
    }
    if (cryptoSymbol != null) {
      $result.cryptoSymbol = cryptoSymbol;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (fiatValue != null) {
      $result.fiatValue = fiatValue;
    }
    if (fiatCurrency != null) {
      $result.fiatCurrency = fiatCurrency;
    }
    if (timestamp != null) {
      $result.timestamp = timestamp;
    }
    if (status != null) {
      $result.status = status;
    }
    if (fee != null) {
      $result.fee = fee;
    }
    if (exchangeRate != null) {
      $result.exchangeRate = exchangeRate;
    }
    return $result;
  }
  CryptoTransaction._() : super();
  factory CryptoTransaction.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CryptoTransaction.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CryptoTransaction', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'type')
    ..aOS(3, _omitFieldNames ? '' : 'cryptoId')
    ..aOS(4, _omitFieldNames ? '' : 'cryptoSymbol')
    ..a<$core.double>(5, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..a<$core.double>(6, _omitFieldNames ? '' : 'fiatValue', $pb.PbFieldType.OD)
    ..aOS(7, _omitFieldNames ? '' : 'fiatCurrency')
    ..aOM<$1.Timestamp>(8, _omitFieldNames ? '' : 'timestamp', subBuilder: $1.Timestamp.create)
    ..aOS(9, _omitFieldNames ? '' : 'status')
    ..a<$core.double>(10, _omitFieldNames ? '' : 'fee', $pb.PbFieldType.OD)
    ..a<$core.double>(11, _omitFieldNames ? '' : 'exchangeRate', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CryptoTransaction clone() => CryptoTransaction()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CryptoTransaction copyWith(void Function(CryptoTransaction) updates) => super.copyWith((message) => updates(message as CryptoTransaction)) as CryptoTransaction;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CryptoTransaction create() => CryptoTransaction._();
  CryptoTransaction createEmptyInstance() => create();
  static $pb.PbList<CryptoTransaction> createRepeated() => $pb.PbList<CryptoTransaction>();
  @$core.pragma('dart2js:noInline')
  static CryptoTransaction getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CryptoTransaction>(create);
  static CryptoTransaction? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get type => $_getSZ(1);
  @$pb.TagNumber(2)
  set type($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasType() => $_has(1);
  @$pb.TagNumber(2)
  void clearType() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get cryptoId => $_getSZ(2);
  @$pb.TagNumber(3)
  set cryptoId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCryptoId() => $_has(2);
  @$pb.TagNumber(3)
  void clearCryptoId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get cryptoSymbol => $_getSZ(3);
  @$pb.TagNumber(4)
  set cryptoSymbol($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCryptoSymbol() => $_has(3);
  @$pb.TagNumber(4)
  void clearCryptoSymbol() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get amount => $_getN(4);
  @$pb.TagNumber(5)
  set amount($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearAmount() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get fiatValue => $_getN(5);
  @$pb.TagNumber(6)
  set fiatValue($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasFiatValue() => $_has(5);
  @$pb.TagNumber(6)
  void clearFiatValue() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get fiatCurrency => $_getSZ(6);
  @$pb.TagNumber(7)
  set fiatCurrency($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasFiatCurrency() => $_has(6);
  @$pb.TagNumber(7)
  void clearFiatCurrency() => clearField(7);

  @$pb.TagNumber(8)
  $1.Timestamp get timestamp => $_getN(7);
  @$pb.TagNumber(8)
  set timestamp($1.Timestamp v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasTimestamp() => $_has(7);
  @$pb.TagNumber(8)
  void clearTimestamp() => clearField(8);
  @$pb.TagNumber(8)
  $1.Timestamp ensureTimestamp() => $_ensure(7);

  @$pb.TagNumber(9)
  $core.String get status => $_getSZ(8);
  @$pb.TagNumber(9)
  set status($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasStatus() => $_has(8);
  @$pb.TagNumber(9)
  void clearStatus() => clearField(9);

  @$pb.TagNumber(10)
  $core.double get fee => $_getN(9);
  @$pb.TagNumber(10)
  set fee($core.double v) { $_setDouble(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasFee() => $_has(9);
  @$pb.TagNumber(10)
  void clearFee() => clearField(10);

  @$pb.TagNumber(11)
  $core.double get exchangeRate => $_getN(10);
  @$pb.TagNumber(11)
  set exchangeRate($core.double v) { $_setDouble(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasExchangeRate() => $_has(10);
  @$pb.TagNumber(11)
  void clearExchangeRate() => clearField(11);
}

class GetCryptoTransactionsResponse extends $pb.GeneratedMessage {
  factory GetCryptoTransactionsResponse({
    $core.Iterable<CryptoTransaction>? transactions,
    $core.int? totalCount,
  }) {
    final $result = create();
    if (transactions != null) {
      $result.transactions.addAll(transactions);
    }
    if (totalCount != null) {
      $result.totalCount = totalCount;
    }
    return $result;
  }
  GetCryptoTransactionsResponse._() : super();
  factory GetCryptoTransactionsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCryptoTransactionsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetCryptoTransactionsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<CryptoTransaction>(1, _omitFieldNames ? '' : 'transactions', $pb.PbFieldType.PM, subBuilder: CryptoTransaction.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'totalCount', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCryptoTransactionsResponse clone() => GetCryptoTransactionsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCryptoTransactionsResponse copyWith(void Function(GetCryptoTransactionsResponse) updates) => super.copyWith((message) => updates(message as GetCryptoTransactionsResponse)) as GetCryptoTransactionsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCryptoTransactionsResponse create() => GetCryptoTransactionsResponse._();
  GetCryptoTransactionsResponse createEmptyInstance() => create();
  static $pb.PbList<GetCryptoTransactionsResponse> createRepeated() => $pb.PbList<GetCryptoTransactionsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetCryptoTransactionsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetCryptoTransactionsResponse>(create);
  static GetCryptoTransactionsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<CryptoTransaction> get transactions => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get totalCount => $_getIZ(1);
  @$pb.TagNumber(2)
  set totalCount($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotalCount() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalCount() => clearField(2);
}

class BuyCryptoRequest extends $pb.GeneratedMessage {
  factory BuyCryptoRequest({
    $core.String? userId,
    $core.String? cryptoId,
    $core.double? fiatAmount,
    $core.String? fiatCurrency,
    $core.String? transactionPin,
    $core.String? idempotencyKey,
  }) {
    final $result = create();
    if (userId != null) {
      $result.userId = userId;
    }
    if (cryptoId != null) {
      $result.cryptoId = cryptoId;
    }
    if (fiatAmount != null) {
      $result.fiatAmount = fiatAmount;
    }
    if (fiatCurrency != null) {
      $result.fiatCurrency = fiatCurrency;
    }
    if (transactionPin != null) {
      $result.transactionPin = transactionPin;
    }
    if (idempotencyKey != null) {
      $result.idempotencyKey = idempotencyKey;
    }
    return $result;
  }
  BuyCryptoRequest._() : super();
  factory BuyCryptoRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BuyCryptoRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'BuyCryptoRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'cryptoId')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'fiatAmount', $pb.PbFieldType.OD)
    ..aOS(4, _omitFieldNames ? '' : 'fiatCurrency')
    ..aOS(5, _omitFieldNames ? '' : 'transactionPin')
    ..aOS(6, _omitFieldNames ? '' : 'idempotencyKey')
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
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get cryptoId => $_getSZ(1);
  @$pb.TagNumber(2)
  set cryptoId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCryptoId() => $_has(1);
  @$pb.TagNumber(2)
  void clearCryptoId() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get fiatAmount => $_getN(2);
  @$pb.TagNumber(3)
  set fiatAmount($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasFiatAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearFiatAmount() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get fiatCurrency => $_getSZ(3);
  @$pb.TagNumber(4)
  set fiatCurrency($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasFiatCurrency() => $_has(3);
  @$pb.TagNumber(4)
  void clearFiatCurrency() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get transactionPin => $_getSZ(4);
  @$pb.TagNumber(5)
  set transactionPin($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTransactionPin() => $_has(4);
  @$pb.TagNumber(5)
  void clearTransactionPin() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get idempotencyKey => $_getSZ(5);
  @$pb.TagNumber(6)
  set idempotencyKey($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasIdempotencyKey() => $_has(5);
  @$pb.TagNumber(6)
  void clearIdempotencyKey() => clearField(6);
}

class BuyCryptoResponse extends $pb.GeneratedMessage {
  factory BuyCryptoResponse({
    $core.String? transactionId,
    $core.String? cryptoId,
    $core.double? cryptoAmount,
    $core.double? fiatAmount,
    $core.String? status,
    $core.double? fee,
    $core.double? exchangeRate,
    $core.double? netAmount,
  }) {
    final $result = create();
    if (transactionId != null) {
      $result.transactionId = transactionId;
    }
    if (cryptoId != null) {
      $result.cryptoId = cryptoId;
    }
    if (cryptoAmount != null) {
      $result.cryptoAmount = cryptoAmount;
    }
    if (fiatAmount != null) {
      $result.fiatAmount = fiatAmount;
    }
    if (status != null) {
      $result.status = status;
    }
    if (fee != null) {
      $result.fee = fee;
    }
    if (exchangeRate != null) {
      $result.exchangeRate = exchangeRate;
    }
    if (netAmount != null) {
      $result.netAmount = netAmount;
    }
    return $result;
  }
  BuyCryptoResponse._() : super();
  factory BuyCryptoResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BuyCryptoResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'BuyCryptoResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'transactionId')
    ..aOS(2, _omitFieldNames ? '' : 'cryptoId')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'cryptoAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'fiatAmount', $pb.PbFieldType.OD)
    ..aOS(5, _omitFieldNames ? '' : 'status')
    ..a<$core.double>(6, _omitFieldNames ? '' : 'fee', $pb.PbFieldType.OD)
    ..a<$core.double>(7, _omitFieldNames ? '' : 'exchangeRate', $pb.PbFieldType.OD)
    ..a<$core.double>(8, _omitFieldNames ? '' : 'netAmount', $pb.PbFieldType.OD)
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
  $core.String get transactionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set transactionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTransactionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransactionId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get cryptoId => $_getSZ(1);
  @$pb.TagNumber(2)
  set cryptoId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCryptoId() => $_has(1);
  @$pb.TagNumber(2)
  void clearCryptoId() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get cryptoAmount => $_getN(2);
  @$pb.TagNumber(3)
  set cryptoAmount($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCryptoAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearCryptoAmount() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get fiatAmount => $_getN(3);
  @$pb.TagNumber(4)
  set fiatAmount($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasFiatAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearFiatAmount() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get status => $_getSZ(4);
  @$pb.TagNumber(5)
  set status($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasStatus() => $_has(4);
  @$pb.TagNumber(5)
  void clearStatus() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get fee => $_getN(5);
  @$pb.TagNumber(6)
  set fee($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasFee() => $_has(5);
  @$pb.TagNumber(6)
  void clearFee() => clearField(6);

  @$pb.TagNumber(7)
  $core.double get exchangeRate => $_getN(6);
  @$pb.TagNumber(7)
  set exchangeRate($core.double v) { $_setDouble(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasExchangeRate() => $_has(6);
  @$pb.TagNumber(7)
  void clearExchangeRate() => clearField(7);

  @$pb.TagNumber(8)
  $core.double get netAmount => $_getN(7);
  @$pb.TagNumber(8)
  set netAmount($core.double v) { $_setDouble(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasNetAmount() => $_has(7);
  @$pb.TagNumber(8)
  void clearNetAmount() => clearField(8);
}

class SellCryptoRequest extends $pb.GeneratedMessage {
  factory SellCryptoRequest({
    $core.String? userId,
    $core.String? cryptoId,
    $core.double? cryptoAmount,
    $core.String? fiatCurrency,
    $core.String? transactionPin,
    $core.String? idempotencyKey,
  }) {
    final $result = create();
    if (userId != null) {
      $result.userId = userId;
    }
    if (cryptoId != null) {
      $result.cryptoId = cryptoId;
    }
    if (cryptoAmount != null) {
      $result.cryptoAmount = cryptoAmount;
    }
    if (fiatCurrency != null) {
      $result.fiatCurrency = fiatCurrency;
    }
    if (transactionPin != null) {
      $result.transactionPin = transactionPin;
    }
    if (idempotencyKey != null) {
      $result.idempotencyKey = idempotencyKey;
    }
    return $result;
  }
  SellCryptoRequest._() : super();
  factory SellCryptoRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SellCryptoRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SellCryptoRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'cryptoId')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'cryptoAmount', $pb.PbFieldType.OD)
    ..aOS(4, _omitFieldNames ? '' : 'fiatCurrency')
    ..aOS(5, _omitFieldNames ? '' : 'transactionPin')
    ..aOS(6, _omitFieldNames ? '' : 'idempotencyKey')
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
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get cryptoId => $_getSZ(1);
  @$pb.TagNumber(2)
  set cryptoId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCryptoId() => $_has(1);
  @$pb.TagNumber(2)
  void clearCryptoId() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get cryptoAmount => $_getN(2);
  @$pb.TagNumber(3)
  set cryptoAmount($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCryptoAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearCryptoAmount() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get fiatCurrency => $_getSZ(3);
  @$pb.TagNumber(4)
  set fiatCurrency($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasFiatCurrency() => $_has(3);
  @$pb.TagNumber(4)
  void clearFiatCurrency() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get transactionPin => $_getSZ(4);
  @$pb.TagNumber(5)
  set transactionPin($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTransactionPin() => $_has(4);
  @$pb.TagNumber(5)
  void clearTransactionPin() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get idempotencyKey => $_getSZ(5);
  @$pb.TagNumber(6)
  set idempotencyKey($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasIdempotencyKey() => $_has(5);
  @$pb.TagNumber(6)
  void clearIdempotencyKey() => clearField(6);
}

class SellCryptoResponse extends $pb.GeneratedMessage {
  factory SellCryptoResponse({
    $core.String? transactionId,
    $core.String? cryptoId,
    $core.double? fiatAmount,
    $core.double? cryptoAmount,
    $core.String? status,
    $core.double? fee,
    $core.double? exchangeRate,
    $core.double? netAmount,
  }) {
    final $result = create();
    if (transactionId != null) {
      $result.transactionId = transactionId;
    }
    if (cryptoId != null) {
      $result.cryptoId = cryptoId;
    }
    if (fiatAmount != null) {
      $result.fiatAmount = fiatAmount;
    }
    if (cryptoAmount != null) {
      $result.cryptoAmount = cryptoAmount;
    }
    if (status != null) {
      $result.status = status;
    }
    if (fee != null) {
      $result.fee = fee;
    }
    if (exchangeRate != null) {
      $result.exchangeRate = exchangeRate;
    }
    if (netAmount != null) {
      $result.netAmount = netAmount;
    }
    return $result;
  }
  SellCryptoResponse._() : super();
  factory SellCryptoResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SellCryptoResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SellCryptoResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'transactionId')
    ..aOS(2, _omitFieldNames ? '' : 'cryptoId')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'fiatAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'cryptoAmount', $pb.PbFieldType.OD)
    ..aOS(5, _omitFieldNames ? '' : 'status')
    ..a<$core.double>(6, _omitFieldNames ? '' : 'fee', $pb.PbFieldType.OD)
    ..a<$core.double>(7, _omitFieldNames ? '' : 'exchangeRate', $pb.PbFieldType.OD)
    ..a<$core.double>(8, _omitFieldNames ? '' : 'netAmount', $pb.PbFieldType.OD)
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
  $core.String get transactionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set transactionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTransactionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransactionId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get cryptoId => $_getSZ(1);
  @$pb.TagNumber(2)
  set cryptoId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCryptoId() => $_has(1);
  @$pb.TagNumber(2)
  void clearCryptoId() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get fiatAmount => $_getN(2);
  @$pb.TagNumber(3)
  set fiatAmount($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasFiatAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearFiatAmount() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get cryptoAmount => $_getN(3);
  @$pb.TagNumber(4)
  set cryptoAmount($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCryptoAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearCryptoAmount() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get status => $_getSZ(4);
  @$pb.TagNumber(5)
  set status($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasStatus() => $_has(4);
  @$pb.TagNumber(5)
  void clearStatus() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get fee => $_getN(5);
  @$pb.TagNumber(6)
  set fee($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasFee() => $_has(5);
  @$pb.TagNumber(6)
  void clearFee() => clearField(6);

  @$pb.TagNumber(7)
  $core.double get exchangeRate => $_getN(6);
  @$pb.TagNumber(7)
  set exchangeRate($core.double v) { $_setDouble(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasExchangeRate() => $_has(6);
  @$pb.TagNumber(7)
  void clearExchangeRate() => clearField(7);

  @$pb.TagNumber(8)
  $core.double get netAmount => $_getN(7);
  @$pb.TagNumber(8)
  set netAmount($core.double v) { $_setDouble(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasNetAmount() => $_has(7);
  @$pb.TagNumber(8)
  void clearNetAmount() => clearField(8);
}

class ConvertCryptoRequest extends $pb.GeneratedMessage {
  factory ConvertCryptoRequest({
    $core.String? userId,
    $core.String? fromCryptoId,
    $core.String? toCryptoId,
    $core.double? fromAmount,
    $core.String? transactionPin,
    $core.String? idempotencyKey,
  }) {
    final $result = create();
    if (userId != null) {
      $result.userId = userId;
    }
    if (fromCryptoId != null) {
      $result.fromCryptoId = fromCryptoId;
    }
    if (toCryptoId != null) {
      $result.toCryptoId = toCryptoId;
    }
    if (fromAmount != null) {
      $result.fromAmount = fromAmount;
    }
    if (transactionPin != null) {
      $result.transactionPin = transactionPin;
    }
    if (idempotencyKey != null) {
      $result.idempotencyKey = idempotencyKey;
    }
    return $result;
  }
  ConvertCryptoRequest._() : super();
  factory ConvertCryptoRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ConvertCryptoRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ConvertCryptoRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'fromCryptoId')
    ..aOS(3, _omitFieldNames ? '' : 'toCryptoId')
    ..a<$core.double>(4, _omitFieldNames ? '' : 'fromAmount', $pb.PbFieldType.OD)
    ..aOS(5, _omitFieldNames ? '' : 'transactionPin')
    ..aOS(6, _omitFieldNames ? '' : 'idempotencyKey')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ConvertCryptoRequest clone() => ConvertCryptoRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ConvertCryptoRequest copyWith(void Function(ConvertCryptoRequest) updates) => super.copyWith((message) => updates(message as ConvertCryptoRequest)) as ConvertCryptoRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ConvertCryptoRequest create() => ConvertCryptoRequest._();
  ConvertCryptoRequest createEmptyInstance() => create();
  static $pb.PbList<ConvertCryptoRequest> createRepeated() => $pb.PbList<ConvertCryptoRequest>();
  @$core.pragma('dart2js:noInline')
  static ConvertCryptoRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ConvertCryptoRequest>(create);
  static ConvertCryptoRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get fromCryptoId => $_getSZ(1);
  @$pb.TagNumber(2)
  set fromCryptoId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFromCryptoId() => $_has(1);
  @$pb.TagNumber(2)
  void clearFromCryptoId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get toCryptoId => $_getSZ(2);
  @$pb.TagNumber(3)
  set toCryptoId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasToCryptoId() => $_has(2);
  @$pb.TagNumber(3)
  void clearToCryptoId() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get fromAmount => $_getN(3);
  @$pb.TagNumber(4)
  set fromAmount($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasFromAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearFromAmount() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get transactionPin => $_getSZ(4);
  @$pb.TagNumber(5)
  set transactionPin($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTransactionPin() => $_has(4);
  @$pb.TagNumber(5)
  void clearTransactionPin() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get idempotencyKey => $_getSZ(5);
  @$pb.TagNumber(6)
  set idempotencyKey($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasIdempotencyKey() => $_has(5);
  @$pb.TagNumber(6)
  void clearIdempotencyKey() => clearField(6);
}

class ConvertCryptoResponse extends $pb.GeneratedMessage {
  factory ConvertCryptoResponse({
    $core.String? transactionId,
    $core.double? toAmount,
    $core.double? rate,
    $core.String? status,
    $core.double? fee,
    $core.double? fromAmount,
  }) {
    final $result = create();
    if (transactionId != null) {
      $result.transactionId = transactionId;
    }
    if (toAmount != null) {
      $result.toAmount = toAmount;
    }
    if (rate != null) {
      $result.rate = rate;
    }
    if (status != null) {
      $result.status = status;
    }
    if (fee != null) {
      $result.fee = fee;
    }
    if (fromAmount != null) {
      $result.fromAmount = fromAmount;
    }
    return $result;
  }
  ConvertCryptoResponse._() : super();
  factory ConvertCryptoResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ConvertCryptoResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ConvertCryptoResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'transactionId')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'toAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'rate', $pb.PbFieldType.OD)
    ..aOS(4, _omitFieldNames ? '' : 'status')
    ..a<$core.double>(5, _omitFieldNames ? '' : 'fee', $pb.PbFieldType.OD)
    ..a<$core.double>(6, _omitFieldNames ? '' : 'fromAmount', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ConvertCryptoResponse clone() => ConvertCryptoResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ConvertCryptoResponse copyWith(void Function(ConvertCryptoResponse) updates) => super.copyWith((message) => updates(message as ConvertCryptoResponse)) as ConvertCryptoResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ConvertCryptoResponse create() => ConvertCryptoResponse._();
  ConvertCryptoResponse createEmptyInstance() => create();
  static $pb.PbList<ConvertCryptoResponse> createRepeated() => $pb.PbList<ConvertCryptoResponse>();
  @$core.pragma('dart2js:noInline')
  static ConvertCryptoResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ConvertCryptoResponse>(create);
  static ConvertCryptoResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get transactionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set transactionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTransactionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransactionId() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get toAmount => $_getN(1);
  @$pb.TagNumber(2)
  set toAmount($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasToAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearToAmount() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get rate => $_getN(2);
  @$pb.TagNumber(3)
  set rate($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasRate() => $_has(2);
  @$pb.TagNumber(3)
  void clearRate() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get status => $_getSZ(3);
  @$pb.TagNumber(4)
  set status($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearStatus() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get fee => $_getN(4);
  @$pb.TagNumber(5)
  set fee($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasFee() => $_has(4);
  @$pb.TagNumber(5)
  void clearFee() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get fromAmount => $_getN(5);
  @$pb.TagNumber(6)
  set fromAmount($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasFromAmount() => $_has(5);
  @$pb.TagNumber(6)
  void clearFromAmount() => clearField(6);
}

class GetWalletsRequest extends $pb.GeneratedMessage {
  factory GetWalletsRequest({
    $core.String? userId,
  }) {
    final $result = create();
    if (userId != null) {
      $result.userId = userId;
    }
    return $result;
  }
  GetWalletsRequest._() : super();
  factory GetWalletsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetWalletsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetWalletsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetWalletsRequest clone() => GetWalletsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetWalletsRequest copyWith(void Function(GetWalletsRequest) updates) => super.copyWith((message) => updates(message as GetWalletsRequest)) as GetWalletsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetWalletsRequest create() => GetWalletsRequest._();
  GetWalletsRequest createEmptyInstance() => create();
  static $pb.PbList<GetWalletsRequest> createRepeated() => $pb.PbList<GetWalletsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetWalletsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetWalletsRequest>(create);
  static GetWalletsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);
}

class CryptoWallet extends $pb.GeneratedMessage {
  factory CryptoWallet({
    $core.String? id,
    $core.String? cryptoId,
    $core.String? cryptoSymbol,
    $core.String? address,
    $core.double? balance,
    $core.String? walletType,
    $core.String? chain,
    $core.String? cryptoName,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (cryptoId != null) {
      $result.cryptoId = cryptoId;
    }
    if (cryptoSymbol != null) {
      $result.cryptoSymbol = cryptoSymbol;
    }
    if (address != null) {
      $result.address = address;
    }
    if (balance != null) {
      $result.balance = balance;
    }
    if (walletType != null) {
      $result.walletType = walletType;
    }
    if (chain != null) {
      $result.chain = chain;
    }
    if (cryptoName != null) {
      $result.cryptoName = cryptoName;
    }
    return $result;
  }
  CryptoWallet._() : super();
  factory CryptoWallet.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CryptoWallet.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CryptoWallet', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'cryptoId')
    ..aOS(3, _omitFieldNames ? '' : 'cryptoSymbol')
    ..aOS(4, _omitFieldNames ? '' : 'address')
    ..a<$core.double>(5, _omitFieldNames ? '' : 'balance', $pb.PbFieldType.OD)
    ..aOS(6, _omitFieldNames ? '' : 'walletType')
    ..aOS(7, _omitFieldNames ? '' : 'chain')
    ..aOS(8, _omitFieldNames ? '' : 'cryptoName')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CryptoWallet clone() => CryptoWallet()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CryptoWallet copyWith(void Function(CryptoWallet) updates) => super.copyWith((message) => updates(message as CryptoWallet)) as CryptoWallet;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CryptoWallet create() => CryptoWallet._();
  CryptoWallet createEmptyInstance() => create();
  static $pb.PbList<CryptoWallet> createRepeated() => $pb.PbList<CryptoWallet>();
  @$core.pragma('dart2js:noInline')
  static CryptoWallet getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CryptoWallet>(create);
  static CryptoWallet? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get cryptoId => $_getSZ(1);
  @$pb.TagNumber(2)
  set cryptoId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCryptoId() => $_has(1);
  @$pb.TagNumber(2)
  void clearCryptoId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get cryptoSymbol => $_getSZ(2);
  @$pb.TagNumber(3)
  set cryptoSymbol($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCryptoSymbol() => $_has(2);
  @$pb.TagNumber(3)
  void clearCryptoSymbol() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get address => $_getSZ(3);
  @$pb.TagNumber(4)
  set address($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAddress() => $_has(3);
  @$pb.TagNumber(4)
  void clearAddress() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get balance => $_getN(4);
  @$pb.TagNumber(5)
  set balance($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasBalance() => $_has(4);
  @$pb.TagNumber(5)
  void clearBalance() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get walletType => $_getSZ(5);
  @$pb.TagNumber(6)
  set walletType($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasWalletType() => $_has(5);
  @$pb.TagNumber(6)
  void clearWalletType() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get chain => $_getSZ(6);
  @$pb.TagNumber(7)
  set chain($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasChain() => $_has(6);
  @$pb.TagNumber(7)
  void clearChain() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get cryptoName => $_getSZ(7);
  @$pb.TagNumber(8)
  set cryptoName($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasCryptoName() => $_has(7);
  @$pb.TagNumber(8)
  void clearCryptoName() => clearField(8);
}

class GetWalletsResponse extends $pb.GeneratedMessage {
  factory GetWalletsResponse({
    $core.Iterable<CryptoWallet>? wallets,
  }) {
    final $result = create();
    if (wallets != null) {
      $result.wallets.addAll(wallets);
    }
    return $result;
  }
  GetWalletsResponse._() : super();
  factory GetWalletsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetWalletsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetWalletsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<CryptoWallet>(1, _omitFieldNames ? '' : 'wallets', $pb.PbFieldType.PM, subBuilder: CryptoWallet.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetWalletsResponse clone() => GetWalletsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetWalletsResponse copyWith(void Function(GetWalletsResponse) updates) => super.copyWith((message) => updates(message as GetWalletsResponse)) as GetWalletsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetWalletsResponse create() => GetWalletsResponse._();
  GetWalletsResponse createEmptyInstance() => create();
  static $pb.PbList<GetWalletsResponse> createRepeated() => $pb.PbList<GetWalletsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetWalletsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetWalletsResponse>(create);
  static GetWalletsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<CryptoWallet> get wallets => $_getList(0);
}

class CreateWalletRequest extends $pb.GeneratedMessage {
  factory CreateWalletRequest({
    $core.String? userId,
    $core.String? cryptoId,
    $core.String? walletType,
    $core.String? chain,
  }) {
    final $result = create();
    if (userId != null) {
      $result.userId = userId;
    }
    if (cryptoId != null) {
      $result.cryptoId = cryptoId;
    }
    if (walletType != null) {
      $result.walletType = walletType;
    }
    if (chain != null) {
      $result.chain = chain;
    }
    return $result;
  }
  CreateWalletRequest._() : super();
  factory CreateWalletRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateWalletRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateWalletRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'cryptoId')
    ..aOS(3, _omitFieldNames ? '' : 'walletType')
    ..aOS(4, _omitFieldNames ? '' : 'chain')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateWalletRequest clone() => CreateWalletRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateWalletRequest copyWith(void Function(CreateWalletRequest) updates) => super.copyWith((message) => updates(message as CreateWalletRequest)) as CreateWalletRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateWalletRequest create() => CreateWalletRequest._();
  CreateWalletRequest createEmptyInstance() => create();
  static $pb.PbList<CreateWalletRequest> createRepeated() => $pb.PbList<CreateWalletRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateWalletRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateWalletRequest>(create);
  static CreateWalletRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get cryptoId => $_getSZ(1);
  @$pb.TagNumber(2)
  set cryptoId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCryptoId() => $_has(1);
  @$pb.TagNumber(2)
  void clearCryptoId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get walletType => $_getSZ(2);
  @$pb.TagNumber(3)
  set walletType($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasWalletType() => $_has(2);
  @$pb.TagNumber(3)
  void clearWalletType() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get chain => $_getSZ(3);
  @$pb.TagNumber(4)
  set chain($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasChain() => $_has(3);
  @$pb.TagNumber(4)
  void clearChain() => clearField(4);
}

class CreateWalletResponse extends $pb.GeneratedMessage {
  factory CreateWalletResponse({
    $core.String? walletId,
    $core.String? address,
    $core.String? cryptoId,
    $core.String? status,
    $core.String? chain,
    $core.String? cryptoName,
  }) {
    final $result = create();
    if (walletId != null) {
      $result.walletId = walletId;
    }
    if (address != null) {
      $result.address = address;
    }
    if (cryptoId != null) {
      $result.cryptoId = cryptoId;
    }
    if (status != null) {
      $result.status = status;
    }
    if (chain != null) {
      $result.chain = chain;
    }
    if (cryptoName != null) {
      $result.cryptoName = cryptoName;
    }
    return $result;
  }
  CreateWalletResponse._() : super();
  factory CreateWalletResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateWalletResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateWalletResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'walletId')
    ..aOS(2, _omitFieldNames ? '' : 'address')
    ..aOS(3, _omitFieldNames ? '' : 'cryptoId')
    ..aOS(4, _omitFieldNames ? '' : 'status')
    ..aOS(5, _omitFieldNames ? '' : 'chain')
    ..aOS(6, _omitFieldNames ? '' : 'cryptoName')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateWalletResponse clone() => CreateWalletResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateWalletResponse copyWith(void Function(CreateWalletResponse) updates) => super.copyWith((message) => updates(message as CreateWalletResponse)) as CreateWalletResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateWalletResponse create() => CreateWalletResponse._();
  CreateWalletResponse createEmptyInstance() => create();
  static $pb.PbList<CreateWalletResponse> createRepeated() => $pb.PbList<CreateWalletResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateWalletResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateWalletResponse>(create);
  static CreateWalletResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get walletId => $_getSZ(0);
  @$pb.TagNumber(1)
  set walletId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasWalletId() => $_has(0);
  @$pb.TagNumber(1)
  void clearWalletId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get address => $_getSZ(1);
  @$pb.TagNumber(2)
  set address($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAddress() => $_has(1);
  @$pb.TagNumber(2)
  void clearAddress() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get cryptoId => $_getSZ(2);
  @$pb.TagNumber(3)
  set cryptoId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCryptoId() => $_has(2);
  @$pb.TagNumber(3)
  void clearCryptoId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get status => $_getSZ(3);
  @$pb.TagNumber(4)
  set status($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearStatus() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get chain => $_getSZ(4);
  @$pb.TagNumber(5)
  set chain($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasChain() => $_has(4);
  @$pb.TagNumber(5)
  void clearChain() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get cryptoName => $_getSZ(5);
  @$pb.TagNumber(6)
  set cryptoName($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasCryptoName() => $_has(5);
  @$pb.TagNumber(6)
  void clearCryptoName() => clearField(6);
}

/// Batch Create Wallets (stablecoin auto-creation)
class BatchCreateWalletsRequest extends $pb.GeneratedMessage {
  factory BatchCreateWalletsRequest({
    $core.String? userId,
  }) {
    final $result = create();
    if (userId != null) {
      $result.userId = userId;
    }
    return $result;
  }
  BatchCreateWalletsRequest._() : super();
  factory BatchCreateWalletsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BatchCreateWalletsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'BatchCreateWalletsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BatchCreateWalletsRequest clone() => BatchCreateWalletsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BatchCreateWalletsRequest copyWith(void Function(BatchCreateWalletsRequest) updates) => super.copyWith((message) => updates(message as BatchCreateWalletsRequest)) as BatchCreateWalletsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BatchCreateWalletsRequest create() => BatchCreateWalletsRequest._();
  BatchCreateWalletsRequest createEmptyInstance() => create();
  static $pb.PbList<BatchCreateWalletsRequest> createRepeated() => $pb.PbList<BatchCreateWalletsRequest>();
  @$core.pragma('dart2js:noInline')
  static BatchCreateWalletsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BatchCreateWalletsRequest>(create);
  static BatchCreateWalletsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);
}

class BatchCreateWalletsResponse extends $pb.GeneratedMessage {
  factory BatchCreateWalletsResponse({
    $core.Iterable<CryptoWallet>? wallets,
    $core.int? createdCount,
    $core.int? failedCount,
  }) {
    final $result = create();
    if (wallets != null) {
      $result.wallets.addAll(wallets);
    }
    if (createdCount != null) {
      $result.createdCount = createdCount;
    }
    if (failedCount != null) {
      $result.failedCount = failedCount;
    }
    return $result;
  }
  BatchCreateWalletsResponse._() : super();
  factory BatchCreateWalletsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BatchCreateWalletsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'BatchCreateWalletsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<CryptoWallet>(1, _omitFieldNames ? '' : 'wallets', $pb.PbFieldType.PM, subBuilder: CryptoWallet.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'createdCount', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'failedCount', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BatchCreateWalletsResponse clone() => BatchCreateWalletsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BatchCreateWalletsResponse copyWith(void Function(BatchCreateWalletsResponse) updates) => super.copyWith((message) => updates(message as BatchCreateWalletsResponse)) as BatchCreateWalletsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BatchCreateWalletsResponse create() => BatchCreateWalletsResponse._();
  BatchCreateWalletsResponse createEmptyInstance() => create();
  static $pb.PbList<BatchCreateWalletsResponse> createRepeated() => $pb.PbList<BatchCreateWalletsResponse>();
  @$core.pragma('dart2js:noInline')
  static BatchCreateWalletsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BatchCreateWalletsResponse>(create);
  static BatchCreateWalletsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<CryptoWallet> get wallets => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get createdCount => $_getIZ(1);
  @$pb.TagNumber(2)
  set createdCount($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCreatedCount() => $_has(1);
  @$pb.TagNumber(2)
  void clearCreatedCount() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get failedCount => $_getIZ(2);
  @$pb.TagNumber(3)
  set failedCount($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasFailedCount() => $_has(2);
  @$pb.TagNumber(3)
  void clearFailedCount() => clearField(3);
}

class GetWalletBalanceRequest extends $pb.GeneratedMessage {
  factory GetWalletBalanceRequest({
    $core.String? walletId,
  }) {
    final $result = create();
    if (walletId != null) {
      $result.walletId = walletId;
    }
    return $result;
  }
  GetWalletBalanceRequest._() : super();
  factory GetWalletBalanceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetWalletBalanceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetWalletBalanceRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'walletId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetWalletBalanceRequest clone() => GetWalletBalanceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetWalletBalanceRequest copyWith(void Function(GetWalletBalanceRequest) updates) => super.copyWith((message) => updates(message as GetWalletBalanceRequest)) as GetWalletBalanceRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetWalletBalanceRequest create() => GetWalletBalanceRequest._();
  GetWalletBalanceRequest createEmptyInstance() => create();
  static $pb.PbList<GetWalletBalanceRequest> createRepeated() => $pb.PbList<GetWalletBalanceRequest>();
  @$core.pragma('dart2js:noInline')
  static GetWalletBalanceRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetWalletBalanceRequest>(create);
  static GetWalletBalanceRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get walletId => $_getSZ(0);
  @$pb.TagNumber(1)
  set walletId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasWalletId() => $_has(0);
  @$pb.TagNumber(1)
  void clearWalletId() => clearField(1);
}

class GetWalletBalanceResponse extends $pb.GeneratedMessage {
  factory GetWalletBalanceResponse({
    $core.String? walletId,
    $core.String? cryptoId,
    $core.double? balance,
    $core.double? fiatValue,
  }) {
    final $result = create();
    if (walletId != null) {
      $result.walletId = walletId;
    }
    if (cryptoId != null) {
      $result.cryptoId = cryptoId;
    }
    if (balance != null) {
      $result.balance = balance;
    }
    if (fiatValue != null) {
      $result.fiatValue = fiatValue;
    }
    return $result;
  }
  GetWalletBalanceResponse._() : super();
  factory GetWalletBalanceResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetWalletBalanceResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetWalletBalanceResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'walletId')
    ..aOS(2, _omitFieldNames ? '' : 'cryptoId')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'balance', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'fiatValue', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetWalletBalanceResponse clone() => GetWalletBalanceResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetWalletBalanceResponse copyWith(void Function(GetWalletBalanceResponse) updates) => super.copyWith((message) => updates(message as GetWalletBalanceResponse)) as GetWalletBalanceResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetWalletBalanceResponse create() => GetWalletBalanceResponse._();
  GetWalletBalanceResponse createEmptyInstance() => create();
  static $pb.PbList<GetWalletBalanceResponse> createRepeated() => $pb.PbList<GetWalletBalanceResponse>();
  @$core.pragma('dart2js:noInline')
  static GetWalletBalanceResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetWalletBalanceResponse>(create);
  static GetWalletBalanceResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get walletId => $_getSZ(0);
  @$pb.TagNumber(1)
  set walletId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasWalletId() => $_has(0);
  @$pb.TagNumber(1)
  void clearWalletId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get cryptoId => $_getSZ(1);
  @$pb.TagNumber(2)
  set cryptoId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCryptoId() => $_has(1);
  @$pb.TagNumber(2)
  void clearCryptoId() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get balance => $_getN(2);
  @$pb.TagNumber(3)
  set balance($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasBalance() => $_has(2);
  @$pb.TagNumber(3)
  void clearBalance() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get fiatValue => $_getN(3);
  @$pb.TagNumber(4)
  set fiatValue($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasFiatValue() => $_has(3);
  @$pb.TagNumber(4)
  void clearFiatValue() => clearField(4);
}

class CryptoWatchlistProto extends $pb.GeneratedMessage {
  factory CryptoWatchlistProto({
    $core.String? id,
    $core.String? name,
    $core.String? description,
    $core.Iterable<$core.String>? cryptoIds,
    $1.Timestamp? createdAt,
    $1.Timestamp? updatedAt,
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
    if (cryptoIds != null) {
      $result.cryptoIds.addAll(cryptoIds);
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      $result.updatedAt = updatedAt;
    }
    return $result;
  }
  CryptoWatchlistProto._() : super();
  factory CryptoWatchlistProto.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CryptoWatchlistProto.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CryptoWatchlistProto', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..pPS(4, _omitFieldNames ? '' : 'cryptoIds')
    ..aOM<$1.Timestamp>(5, _omitFieldNames ? '' : 'createdAt', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(6, _omitFieldNames ? '' : 'updatedAt', subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CryptoWatchlistProto clone() => CryptoWatchlistProto()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CryptoWatchlistProto copyWith(void Function(CryptoWatchlistProto) updates) => super.copyWith((message) => updates(message as CryptoWatchlistProto)) as CryptoWatchlistProto;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CryptoWatchlistProto create() => CryptoWatchlistProto._();
  CryptoWatchlistProto createEmptyInstance() => create();
  static $pb.PbList<CryptoWatchlistProto> createRepeated() => $pb.PbList<CryptoWatchlistProto>();
  @$core.pragma('dart2js:noInline')
  static CryptoWatchlistProto getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CryptoWatchlistProto>(create);
  static CryptoWatchlistProto? _defaultInstance;

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
  $core.List<$core.String> get cryptoIds => $_getList(3);

  @$pb.TagNumber(5)
  $1.Timestamp get createdAt => $_getN(4);
  @$pb.TagNumber(5)
  set createdAt($1.Timestamp v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasCreatedAt() => $_has(4);
  @$pb.TagNumber(5)
  void clearCreatedAt() => clearField(5);
  @$pb.TagNumber(5)
  $1.Timestamp ensureCreatedAt() => $_ensure(4);

  @$pb.TagNumber(6)
  $1.Timestamp get updatedAt => $_getN(5);
  @$pb.TagNumber(6)
  set updatedAt($1.Timestamp v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasUpdatedAt() => $_has(5);
  @$pb.TagNumber(6)
  void clearUpdatedAt() => clearField(6);
  @$pb.TagNumber(6)
  $1.Timestamp ensureUpdatedAt() => $_ensure(5);
}

class CreateWatchlistRequest extends $pb.GeneratedMessage {
  factory CreateWatchlistRequest({
    $core.String? name,
    $core.String? description,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (description != null) {
      $result.description = description;
    }
    return $result;
  }
  CreateWatchlistRequest._() : super();
  factory CreateWatchlistRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateWatchlistRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateWatchlistRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOS(2, _omitFieldNames ? '' : 'description')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateWatchlistRequest clone() => CreateWatchlistRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateWatchlistRequest copyWith(void Function(CreateWatchlistRequest) updates) => super.copyWith((message) => updates(message as CreateWatchlistRequest)) as CreateWatchlistRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateWatchlistRequest create() => CreateWatchlistRequest._();
  CreateWatchlistRequest createEmptyInstance() => create();
  static $pb.PbList<CreateWatchlistRequest> createRepeated() => $pb.PbList<CreateWatchlistRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateWatchlistRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateWatchlistRequest>(create);
  static CreateWatchlistRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get description => $_getSZ(1);
  @$pb.TagNumber(2)
  set description($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasDescription() => $_has(1);
  @$pb.TagNumber(2)
  void clearDescription() => clearField(2);
}

class CreateWatchlistResponse extends $pb.GeneratedMessage {
  factory CreateWatchlistResponse({
    CryptoWatchlistProto? watchlist,
  }) {
    final $result = create();
    if (watchlist != null) {
      $result.watchlist = watchlist;
    }
    return $result;
  }
  CreateWatchlistResponse._() : super();
  factory CreateWatchlistResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateWatchlistResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateWatchlistResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<CryptoWatchlistProto>(1, _omitFieldNames ? '' : 'watchlist', subBuilder: CryptoWatchlistProto.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateWatchlistResponse clone() => CreateWatchlistResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateWatchlistResponse copyWith(void Function(CreateWatchlistResponse) updates) => super.copyWith((message) => updates(message as CreateWatchlistResponse)) as CreateWatchlistResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateWatchlistResponse create() => CreateWatchlistResponse._();
  CreateWatchlistResponse createEmptyInstance() => create();
  static $pb.PbList<CreateWatchlistResponse> createRepeated() => $pb.PbList<CreateWatchlistResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateWatchlistResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateWatchlistResponse>(create);
  static CreateWatchlistResponse? _defaultInstance;

  @$pb.TagNumber(1)
  CryptoWatchlistProto get watchlist => $_getN(0);
  @$pb.TagNumber(1)
  set watchlist(CryptoWatchlistProto v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasWatchlist() => $_has(0);
  @$pb.TagNumber(1)
  void clearWatchlist() => clearField(1);
  @$pb.TagNumber(1)
  CryptoWatchlistProto ensureWatchlist() => $_ensure(0);
}

class GetWatchlistsRequest extends $pb.GeneratedMessage {
  factory GetWatchlistsRequest() => create();
  GetWatchlistsRequest._() : super();
  factory GetWatchlistsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetWatchlistsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetWatchlistsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetWatchlistsRequest clone() => GetWatchlistsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetWatchlistsRequest copyWith(void Function(GetWatchlistsRequest) updates) => super.copyWith((message) => updates(message as GetWatchlistsRequest)) as GetWatchlistsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetWatchlistsRequest create() => GetWatchlistsRequest._();
  GetWatchlistsRequest createEmptyInstance() => create();
  static $pb.PbList<GetWatchlistsRequest> createRepeated() => $pb.PbList<GetWatchlistsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetWatchlistsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetWatchlistsRequest>(create);
  static GetWatchlistsRequest? _defaultInstance;
}

class GetWatchlistsResponse extends $pb.GeneratedMessage {
  factory GetWatchlistsResponse({
    $core.Iterable<CryptoWatchlistProto>? watchlists,
  }) {
    final $result = create();
    if (watchlists != null) {
      $result.watchlists.addAll(watchlists);
    }
    return $result;
  }
  GetWatchlistsResponse._() : super();
  factory GetWatchlistsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetWatchlistsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetWatchlistsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<CryptoWatchlistProto>(1, _omitFieldNames ? '' : 'watchlists', $pb.PbFieldType.PM, subBuilder: CryptoWatchlistProto.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetWatchlistsResponse clone() => GetWatchlistsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetWatchlistsResponse copyWith(void Function(GetWatchlistsResponse) updates) => super.copyWith((message) => updates(message as GetWatchlistsResponse)) as GetWatchlistsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetWatchlistsResponse create() => GetWatchlistsResponse._();
  GetWatchlistsResponse createEmptyInstance() => create();
  static $pb.PbList<GetWatchlistsResponse> createRepeated() => $pb.PbList<GetWatchlistsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetWatchlistsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetWatchlistsResponse>(create);
  static GetWatchlistsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<CryptoWatchlistProto> get watchlists => $_getList(0);
}

class AddToWatchlistRequest extends $pb.GeneratedMessage {
  factory AddToWatchlistRequest({
    $core.String? watchlistId,
    $core.String? cryptoId,
  }) {
    final $result = create();
    if (watchlistId != null) {
      $result.watchlistId = watchlistId;
    }
    if (cryptoId != null) {
      $result.cryptoId = cryptoId;
    }
    return $result;
  }
  AddToWatchlistRequest._() : super();
  factory AddToWatchlistRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddToWatchlistRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AddToWatchlistRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'watchlistId')
    ..aOS(2, _omitFieldNames ? '' : 'cryptoId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddToWatchlistRequest clone() => AddToWatchlistRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddToWatchlistRequest copyWith(void Function(AddToWatchlistRequest) updates) => super.copyWith((message) => updates(message as AddToWatchlistRequest)) as AddToWatchlistRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddToWatchlistRequest create() => AddToWatchlistRequest._();
  AddToWatchlistRequest createEmptyInstance() => create();
  static $pb.PbList<AddToWatchlistRequest> createRepeated() => $pb.PbList<AddToWatchlistRequest>();
  @$core.pragma('dart2js:noInline')
  static AddToWatchlistRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddToWatchlistRequest>(create);
  static AddToWatchlistRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get watchlistId => $_getSZ(0);
  @$pb.TagNumber(1)
  set watchlistId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasWatchlistId() => $_has(0);
  @$pb.TagNumber(1)
  void clearWatchlistId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get cryptoId => $_getSZ(1);
  @$pb.TagNumber(2)
  set cryptoId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCryptoId() => $_has(1);
  @$pb.TagNumber(2)
  void clearCryptoId() => clearField(2);
}

class AddToWatchlistResponse extends $pb.GeneratedMessage {
  factory AddToWatchlistResponse({
    CryptoWatchlistProto? watchlist,
  }) {
    final $result = create();
    if (watchlist != null) {
      $result.watchlist = watchlist;
    }
    return $result;
  }
  AddToWatchlistResponse._() : super();
  factory AddToWatchlistResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddToWatchlistResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AddToWatchlistResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<CryptoWatchlistProto>(1, _omitFieldNames ? '' : 'watchlist', subBuilder: CryptoWatchlistProto.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddToWatchlistResponse clone() => AddToWatchlistResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddToWatchlistResponse copyWith(void Function(AddToWatchlistResponse) updates) => super.copyWith((message) => updates(message as AddToWatchlistResponse)) as AddToWatchlistResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddToWatchlistResponse create() => AddToWatchlistResponse._();
  AddToWatchlistResponse createEmptyInstance() => create();
  static $pb.PbList<AddToWatchlistResponse> createRepeated() => $pb.PbList<AddToWatchlistResponse>();
  @$core.pragma('dart2js:noInline')
  static AddToWatchlistResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddToWatchlistResponse>(create);
  static AddToWatchlistResponse? _defaultInstance;

  @$pb.TagNumber(1)
  CryptoWatchlistProto get watchlist => $_getN(0);
  @$pb.TagNumber(1)
  set watchlist(CryptoWatchlistProto v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasWatchlist() => $_has(0);
  @$pb.TagNumber(1)
  void clearWatchlist() => clearField(1);
  @$pb.TagNumber(1)
  CryptoWatchlistProto ensureWatchlist() => $_ensure(0);
}

class RemoveFromWatchlistRequest extends $pb.GeneratedMessage {
  factory RemoveFromWatchlistRequest({
    $core.String? watchlistId,
    $core.String? cryptoId,
  }) {
    final $result = create();
    if (watchlistId != null) {
      $result.watchlistId = watchlistId;
    }
    if (cryptoId != null) {
      $result.cryptoId = cryptoId;
    }
    return $result;
  }
  RemoveFromWatchlistRequest._() : super();
  factory RemoveFromWatchlistRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RemoveFromWatchlistRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RemoveFromWatchlistRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'watchlistId')
    ..aOS(2, _omitFieldNames ? '' : 'cryptoId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RemoveFromWatchlistRequest clone() => RemoveFromWatchlistRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RemoveFromWatchlistRequest copyWith(void Function(RemoveFromWatchlistRequest) updates) => super.copyWith((message) => updates(message as RemoveFromWatchlistRequest)) as RemoveFromWatchlistRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RemoveFromWatchlistRequest create() => RemoveFromWatchlistRequest._();
  RemoveFromWatchlistRequest createEmptyInstance() => create();
  static $pb.PbList<RemoveFromWatchlistRequest> createRepeated() => $pb.PbList<RemoveFromWatchlistRequest>();
  @$core.pragma('dart2js:noInline')
  static RemoveFromWatchlistRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RemoveFromWatchlistRequest>(create);
  static RemoveFromWatchlistRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get watchlistId => $_getSZ(0);
  @$pb.TagNumber(1)
  set watchlistId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasWatchlistId() => $_has(0);
  @$pb.TagNumber(1)
  void clearWatchlistId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get cryptoId => $_getSZ(1);
  @$pb.TagNumber(2)
  set cryptoId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCryptoId() => $_has(1);
  @$pb.TagNumber(2)
  void clearCryptoId() => clearField(2);
}

class RemoveFromWatchlistResponse extends $pb.GeneratedMessage {
  factory RemoveFromWatchlistResponse({
    CryptoWatchlistProto? watchlist,
  }) {
    final $result = create();
    if (watchlist != null) {
      $result.watchlist = watchlist;
    }
    return $result;
  }
  RemoveFromWatchlistResponse._() : super();
  factory RemoveFromWatchlistResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RemoveFromWatchlistResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RemoveFromWatchlistResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<CryptoWatchlistProto>(1, _omitFieldNames ? '' : 'watchlist', subBuilder: CryptoWatchlistProto.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RemoveFromWatchlistResponse clone() => RemoveFromWatchlistResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RemoveFromWatchlistResponse copyWith(void Function(RemoveFromWatchlistResponse) updates) => super.copyWith((message) => updates(message as RemoveFromWatchlistResponse)) as RemoveFromWatchlistResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RemoveFromWatchlistResponse create() => RemoveFromWatchlistResponse._();
  RemoveFromWatchlistResponse createEmptyInstance() => create();
  static $pb.PbList<RemoveFromWatchlistResponse> createRepeated() => $pb.PbList<RemoveFromWatchlistResponse>();
  @$core.pragma('dart2js:noInline')
  static RemoveFromWatchlistResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RemoveFromWatchlistResponse>(create);
  static RemoveFromWatchlistResponse? _defaultInstance;

  @$pb.TagNumber(1)
  CryptoWatchlistProto get watchlist => $_getN(0);
  @$pb.TagNumber(1)
  set watchlist(CryptoWatchlistProto v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasWatchlist() => $_has(0);
  @$pb.TagNumber(1)
  void clearWatchlist() => clearField(1);
  @$pb.TagNumber(1)
  CryptoWatchlistProto ensureWatchlist() => $_ensure(0);
}

class DeleteWatchlistRequest extends $pb.GeneratedMessage {
  factory DeleteWatchlistRequest({
    $core.String? watchlistId,
  }) {
    final $result = create();
    if (watchlistId != null) {
      $result.watchlistId = watchlistId;
    }
    return $result;
  }
  DeleteWatchlistRequest._() : super();
  factory DeleteWatchlistRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteWatchlistRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DeleteWatchlistRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'watchlistId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteWatchlistRequest clone() => DeleteWatchlistRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteWatchlistRequest copyWith(void Function(DeleteWatchlistRequest) updates) => super.copyWith((message) => updates(message as DeleteWatchlistRequest)) as DeleteWatchlistRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteWatchlistRequest create() => DeleteWatchlistRequest._();
  DeleteWatchlistRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteWatchlistRequest> createRepeated() => $pb.PbList<DeleteWatchlistRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteWatchlistRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteWatchlistRequest>(create);
  static DeleteWatchlistRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get watchlistId => $_getSZ(0);
  @$pb.TagNumber(1)
  set watchlistId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasWatchlistId() => $_has(0);
  @$pb.TagNumber(1)
  void clearWatchlistId() => clearField(1);
}

class DeleteWatchlistResponse extends $pb.GeneratedMessage {
  factory DeleteWatchlistResponse({
    $core.bool? success,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    return $result;
  }
  DeleteWatchlistResponse._() : super();
  factory DeleteWatchlistResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteWatchlistResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DeleteWatchlistResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteWatchlistResponse clone() => DeleteWatchlistResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteWatchlistResponse copyWith(void Function(DeleteWatchlistResponse) updates) => super.copyWith((message) => updates(message as DeleteWatchlistResponse)) as DeleteWatchlistResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteWatchlistResponse create() => DeleteWatchlistResponse._();
  DeleteWatchlistResponse createEmptyInstance() => create();
  static $pb.PbList<DeleteWatchlistResponse> createRepeated() => $pb.PbList<DeleteWatchlistResponse>();
  @$core.pragma('dart2js:noInline')
  static DeleteWatchlistResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteWatchlistResponse>(create);
  static DeleteWatchlistResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);
}

/// Toggle Favorite
class ToggleFavoriteRequest extends $pb.GeneratedMessage {
  factory ToggleFavoriteRequest({
    $core.String? cryptoId,
  }) {
    final $result = create();
    if (cryptoId != null) {
      $result.cryptoId = cryptoId;
    }
    return $result;
  }
  ToggleFavoriteRequest._() : super();
  factory ToggleFavoriteRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ToggleFavoriteRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ToggleFavoriteRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'cryptoId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ToggleFavoriteRequest clone() => ToggleFavoriteRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ToggleFavoriteRequest copyWith(void Function(ToggleFavoriteRequest) updates) => super.copyWith((message) => updates(message as ToggleFavoriteRequest)) as ToggleFavoriteRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ToggleFavoriteRequest create() => ToggleFavoriteRequest._();
  ToggleFavoriteRequest createEmptyInstance() => create();
  static $pb.PbList<ToggleFavoriteRequest> createRepeated() => $pb.PbList<ToggleFavoriteRequest>();
  @$core.pragma('dart2js:noInline')
  static ToggleFavoriteRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ToggleFavoriteRequest>(create);
  static ToggleFavoriteRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get cryptoId => $_getSZ(0);
  @$pb.TagNumber(1)
  set cryptoId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCryptoId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCryptoId() => clearField(1);
}

class ToggleFavoriteResponse extends $pb.GeneratedMessage {
  factory ToggleFavoriteResponse({
    $core.bool? isFavorite,
    $core.String? message,
  }) {
    final $result = create();
    if (isFavorite != null) {
      $result.isFavorite = isFavorite;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  ToggleFavoriteResponse._() : super();
  factory ToggleFavoriteResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ToggleFavoriteResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ToggleFavoriteResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'isFavorite')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ToggleFavoriteResponse clone() => ToggleFavoriteResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ToggleFavoriteResponse copyWith(void Function(ToggleFavoriteResponse) updates) => super.copyWith((message) => updates(message as ToggleFavoriteResponse)) as ToggleFavoriteResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ToggleFavoriteResponse create() => ToggleFavoriteResponse._();
  ToggleFavoriteResponse createEmptyInstance() => create();
  static $pb.PbList<ToggleFavoriteResponse> createRepeated() => $pb.PbList<ToggleFavoriteResponse>();
  @$core.pragma('dart2js:noInline')
  static ToggleFavoriteResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ToggleFavoriteResponse>(create);
  static ToggleFavoriteResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get isFavorite => $_getBF(0);
  @$pb.TagNumber(1)
  set isFavorite($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasIsFavorite() => $_has(0);
  @$pb.TagNumber(1)
  void clearIsFavorite() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

class GetPlatformCryptoPortfolioRequest extends $pb.GeneratedMessage {
  factory GetPlatformCryptoPortfolioRequest({
    $core.String? fiatCurrency,
  }) {
    final $result = create();
    if (fiatCurrency != null) {
      $result.fiatCurrency = fiatCurrency;
    }
    return $result;
  }
  GetPlatformCryptoPortfolioRequest._() : super();
  factory GetPlatformCryptoPortfolioRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPlatformCryptoPortfolioRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetPlatformCryptoPortfolioRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'fiatCurrency')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPlatformCryptoPortfolioRequest clone() => GetPlatformCryptoPortfolioRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPlatformCryptoPortfolioRequest copyWith(void Function(GetPlatformCryptoPortfolioRequest) updates) => super.copyWith((message) => updates(message as GetPlatformCryptoPortfolioRequest)) as GetPlatformCryptoPortfolioRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPlatformCryptoPortfolioRequest create() => GetPlatformCryptoPortfolioRequest._();
  GetPlatformCryptoPortfolioRequest createEmptyInstance() => create();
  static $pb.PbList<GetPlatformCryptoPortfolioRequest> createRepeated() => $pb.PbList<GetPlatformCryptoPortfolioRequest>();
  @$core.pragma('dart2js:noInline')
  static GetPlatformCryptoPortfolioRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetPlatformCryptoPortfolioRequest>(create);
  static GetPlatformCryptoPortfolioRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fiatCurrency => $_getSZ(0);
  @$pb.TagNumber(1)
  set fiatCurrency($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFiatCurrency() => $_has(0);
  @$pb.TagNumber(1)
  void clearFiatCurrency() => clearField(1);
}

class AssetAllocation extends $pb.GeneratedMessage {
  factory AssetAllocation({
    $core.String? cryptoId,
    $core.String? symbol,
    $core.String? name,
    $core.double? totalBalance,
    $core.double? totalFiatValue,
    $core.double? currentPrice,
    $core.double? allocationPercentage,
    $core.int? holdersCount,
    $core.double? priceChange24h,
  }) {
    final $result = create();
    if (cryptoId != null) {
      $result.cryptoId = cryptoId;
    }
    if (symbol != null) {
      $result.symbol = symbol;
    }
    if (name != null) {
      $result.name = name;
    }
    if (totalBalance != null) {
      $result.totalBalance = totalBalance;
    }
    if (totalFiatValue != null) {
      $result.totalFiatValue = totalFiatValue;
    }
    if (currentPrice != null) {
      $result.currentPrice = currentPrice;
    }
    if (allocationPercentage != null) {
      $result.allocationPercentage = allocationPercentage;
    }
    if (holdersCount != null) {
      $result.holdersCount = holdersCount;
    }
    if (priceChange24h != null) {
      $result.priceChange24h = priceChange24h;
    }
    return $result;
  }
  AssetAllocation._() : super();
  factory AssetAllocation.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AssetAllocation.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AssetAllocation', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'cryptoId')
    ..aOS(2, _omitFieldNames ? '' : 'symbol')
    ..aOS(3, _omitFieldNames ? '' : 'name')
    ..a<$core.double>(4, _omitFieldNames ? '' : 'totalBalance', $pb.PbFieldType.OD)
    ..a<$core.double>(5, _omitFieldNames ? '' : 'totalFiatValue', $pb.PbFieldType.OD)
    ..a<$core.double>(6, _omitFieldNames ? '' : 'currentPrice', $pb.PbFieldType.OD)
    ..a<$core.double>(7, _omitFieldNames ? '' : 'allocationPercentage', $pb.PbFieldType.OD)
    ..a<$core.int>(8, _omitFieldNames ? '' : 'holdersCount', $pb.PbFieldType.O3)
    ..a<$core.double>(9, _omitFieldNames ? '' : 'priceChange24h', $pb.PbFieldType.OD, protoName: 'price_change_24h')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AssetAllocation clone() => AssetAllocation()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AssetAllocation copyWith(void Function(AssetAllocation) updates) => super.copyWith((message) => updates(message as AssetAllocation)) as AssetAllocation;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AssetAllocation create() => AssetAllocation._();
  AssetAllocation createEmptyInstance() => create();
  static $pb.PbList<AssetAllocation> createRepeated() => $pb.PbList<AssetAllocation>();
  @$core.pragma('dart2js:noInline')
  static AssetAllocation getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AssetAllocation>(create);
  static AssetAllocation? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get cryptoId => $_getSZ(0);
  @$pb.TagNumber(1)
  set cryptoId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCryptoId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCryptoId() => clearField(1);

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
  $core.double get totalBalance => $_getN(3);
  @$pb.TagNumber(4)
  set totalBalance($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTotalBalance() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalBalance() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get totalFiatValue => $_getN(4);
  @$pb.TagNumber(5)
  set totalFiatValue($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTotalFiatValue() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotalFiatValue() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get currentPrice => $_getN(5);
  @$pb.TagNumber(6)
  set currentPrice($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasCurrentPrice() => $_has(5);
  @$pb.TagNumber(6)
  void clearCurrentPrice() => clearField(6);

  @$pb.TagNumber(7)
  $core.double get allocationPercentage => $_getN(6);
  @$pb.TagNumber(7)
  set allocationPercentage($core.double v) { $_setDouble(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasAllocationPercentage() => $_has(6);
  @$pb.TagNumber(7)
  void clearAllocationPercentage() => clearField(7);

  @$pb.TagNumber(8)
  $core.int get holdersCount => $_getIZ(7);
  @$pb.TagNumber(8)
  set holdersCount($core.int v) { $_setSignedInt32(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasHoldersCount() => $_has(7);
  @$pb.TagNumber(8)
  void clearHoldersCount() => clearField(8);

  @$pb.TagNumber(9)
  $core.double get priceChange24h => $_getN(8);
  @$pb.TagNumber(9)
  set priceChange24h($core.double v) { $_setDouble(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasPriceChange24h() => $_has(8);
  @$pb.TagNumber(9)
  void clearPriceChange24h() => clearField(9);
}

class PlatformCryptoStats extends $pb.GeneratedMessage {
  factory PlatformCryptoStats({
    $core.int? totalUsersWithHoldings,
    $core.int? totalWallets,
    $core.int? totalTransactions,
    $core.int? totalUniqueAssets,
  }) {
    final $result = create();
    if (totalUsersWithHoldings != null) {
      $result.totalUsersWithHoldings = totalUsersWithHoldings;
    }
    if (totalWallets != null) {
      $result.totalWallets = totalWallets;
    }
    if (totalTransactions != null) {
      $result.totalTransactions = totalTransactions;
    }
    if (totalUniqueAssets != null) {
      $result.totalUniqueAssets = totalUniqueAssets;
    }
    return $result;
  }
  PlatformCryptoStats._() : super();
  factory PlatformCryptoStats.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PlatformCryptoStats.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PlatformCryptoStats', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'totalUsersWithHoldings', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'totalWallets', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'totalTransactions', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'totalUniqueAssets', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PlatformCryptoStats clone() => PlatformCryptoStats()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PlatformCryptoStats copyWith(void Function(PlatformCryptoStats) updates) => super.copyWith((message) => updates(message as PlatformCryptoStats)) as PlatformCryptoStats;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PlatformCryptoStats create() => PlatformCryptoStats._();
  PlatformCryptoStats createEmptyInstance() => create();
  static $pb.PbList<PlatformCryptoStats> createRepeated() => $pb.PbList<PlatformCryptoStats>();
  @$core.pragma('dart2js:noInline')
  static PlatformCryptoStats getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PlatformCryptoStats>(create);
  static PlatformCryptoStats? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get totalUsersWithHoldings => $_getIZ(0);
  @$pb.TagNumber(1)
  set totalUsersWithHoldings($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTotalUsersWithHoldings() => $_has(0);
  @$pb.TagNumber(1)
  void clearTotalUsersWithHoldings() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get totalWallets => $_getIZ(1);
  @$pb.TagNumber(2)
  set totalWallets($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotalWallets() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalWallets() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get totalTransactions => $_getIZ(2);
  @$pb.TagNumber(3)
  set totalTransactions($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTotalTransactions() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalTransactions() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get totalUniqueAssets => $_getIZ(3);
  @$pb.TagNumber(4)
  set totalUniqueAssets($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTotalUniqueAssets() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalUniqueAssets() => clearField(4);
}

class GetPlatformCryptoPortfolioResponse extends $pb.GeneratedMessage {
  factory GetPlatformCryptoPortfolioResponse({
    $core.double? totalPortfolioValue,
    $core.String? fiatCurrency,
    $core.Iterable<AssetAllocation>? assets,
    PlatformCryptoStats? stats,
    $1.Timestamp? lastUpdated,
  }) {
    final $result = create();
    if (totalPortfolioValue != null) {
      $result.totalPortfolioValue = totalPortfolioValue;
    }
    if (fiatCurrency != null) {
      $result.fiatCurrency = fiatCurrency;
    }
    if (assets != null) {
      $result.assets.addAll(assets);
    }
    if (stats != null) {
      $result.stats = stats;
    }
    if (lastUpdated != null) {
      $result.lastUpdated = lastUpdated;
    }
    return $result;
  }
  GetPlatformCryptoPortfolioResponse._() : super();
  factory GetPlatformCryptoPortfolioResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPlatformCryptoPortfolioResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetPlatformCryptoPortfolioResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'totalPortfolioValue', $pb.PbFieldType.OD)
    ..aOS(2, _omitFieldNames ? '' : 'fiatCurrency')
    ..pc<AssetAllocation>(3, _omitFieldNames ? '' : 'assets', $pb.PbFieldType.PM, subBuilder: AssetAllocation.create)
    ..aOM<PlatformCryptoStats>(4, _omitFieldNames ? '' : 'stats', subBuilder: PlatformCryptoStats.create)
    ..aOM<$1.Timestamp>(5, _omitFieldNames ? '' : 'lastUpdated', subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPlatformCryptoPortfolioResponse clone() => GetPlatformCryptoPortfolioResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPlatformCryptoPortfolioResponse copyWith(void Function(GetPlatformCryptoPortfolioResponse) updates) => super.copyWith((message) => updates(message as GetPlatformCryptoPortfolioResponse)) as GetPlatformCryptoPortfolioResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPlatformCryptoPortfolioResponse create() => GetPlatformCryptoPortfolioResponse._();
  GetPlatformCryptoPortfolioResponse createEmptyInstance() => create();
  static $pb.PbList<GetPlatformCryptoPortfolioResponse> createRepeated() => $pb.PbList<GetPlatformCryptoPortfolioResponse>();
  @$core.pragma('dart2js:noInline')
  static GetPlatformCryptoPortfolioResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetPlatformCryptoPortfolioResponse>(create);
  static GetPlatformCryptoPortfolioResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get totalPortfolioValue => $_getN(0);
  @$pb.TagNumber(1)
  set totalPortfolioValue($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTotalPortfolioValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearTotalPortfolioValue() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get fiatCurrency => $_getSZ(1);
  @$pb.TagNumber(2)
  set fiatCurrency($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFiatCurrency() => $_has(1);
  @$pb.TagNumber(2)
  void clearFiatCurrency() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<AssetAllocation> get assets => $_getList(2);

  @$pb.TagNumber(4)
  PlatformCryptoStats get stats => $_getN(3);
  @$pb.TagNumber(4)
  set stats(PlatformCryptoStats v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasStats() => $_has(3);
  @$pb.TagNumber(4)
  void clearStats() => clearField(4);
  @$pb.TagNumber(4)
  PlatformCryptoStats ensureStats() => $_ensure(3);

  @$pb.TagNumber(5)
  $1.Timestamp get lastUpdated => $_getN(4);
  @$pb.TagNumber(5)
  set lastUpdated($1.Timestamp v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasLastUpdated() => $_has(4);
  @$pb.TagNumber(5)
  void clearLastUpdated() => clearField(5);
  @$pb.TagNumber(5)
  $1.Timestamp ensureLastUpdated() => $_ensure(4);
}

/// Admin: paginated platform-wide transaction list
class GetPlatformCryptoTransactionsRequest extends $pb.GeneratedMessage {
  factory GetPlatformCryptoTransactionsRequest({
    $core.int? page,
    $core.int? perPage,
    $core.String? statusFilter,
    $core.String? typeFilter,
  }) {
    final $result = create();
    if (page != null) {
      $result.page = page;
    }
    if (perPage != null) {
      $result.perPage = perPage;
    }
    if (statusFilter != null) {
      $result.statusFilter = statusFilter;
    }
    if (typeFilter != null) {
      $result.typeFilter = typeFilter;
    }
    return $result;
  }
  GetPlatformCryptoTransactionsRequest._() : super();
  factory GetPlatformCryptoTransactionsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPlatformCryptoTransactionsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetPlatformCryptoTransactionsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'perPage', $pb.PbFieldType.O3)
    ..aOS(3, _omitFieldNames ? '' : 'statusFilter')
    ..aOS(4, _omitFieldNames ? '' : 'typeFilter')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPlatformCryptoTransactionsRequest clone() => GetPlatformCryptoTransactionsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPlatformCryptoTransactionsRequest copyWith(void Function(GetPlatformCryptoTransactionsRequest) updates) => super.copyWith((message) => updates(message as GetPlatformCryptoTransactionsRequest)) as GetPlatformCryptoTransactionsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPlatformCryptoTransactionsRequest create() => GetPlatformCryptoTransactionsRequest._();
  GetPlatformCryptoTransactionsRequest createEmptyInstance() => create();
  static $pb.PbList<GetPlatformCryptoTransactionsRequest> createRepeated() => $pb.PbList<GetPlatformCryptoTransactionsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetPlatformCryptoTransactionsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetPlatformCryptoTransactionsRequest>(create);
  static GetPlatformCryptoTransactionsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get page => $_getIZ(0);
  @$pb.TagNumber(1)
  set page($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearPage() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get perPage => $_getIZ(1);
  @$pb.TagNumber(2)
  set perPage($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPerPage() => $_has(1);
  @$pb.TagNumber(2)
  void clearPerPage() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get statusFilter => $_getSZ(2);
  @$pb.TagNumber(3)
  set statusFilter($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasStatusFilter() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatusFilter() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get typeFilter => $_getSZ(3);
  @$pb.TagNumber(4)
  set typeFilter($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTypeFilter() => $_has(3);
  @$pb.TagNumber(4)
  void clearTypeFilter() => clearField(4);
}

class GetPlatformCryptoTransactionsResponse extends $pb.GeneratedMessage {
  factory GetPlatformCryptoTransactionsResponse({
    $core.Iterable<CryptoTransaction>? transactions,
    $core.int? totalCount,
    $core.int? page,
    $core.int? perPage,
  }) {
    final $result = create();
    if (transactions != null) {
      $result.transactions.addAll(transactions);
    }
    if (totalCount != null) {
      $result.totalCount = totalCount;
    }
    if (page != null) {
      $result.page = page;
    }
    if (perPage != null) {
      $result.perPage = perPage;
    }
    return $result;
  }
  GetPlatformCryptoTransactionsResponse._() : super();
  factory GetPlatformCryptoTransactionsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPlatformCryptoTransactionsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetPlatformCryptoTransactionsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<CryptoTransaction>(1, _omitFieldNames ? '' : 'transactions', $pb.PbFieldType.PM, subBuilder: CryptoTransaction.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'totalCount', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'perPage', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPlatformCryptoTransactionsResponse clone() => GetPlatformCryptoTransactionsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPlatformCryptoTransactionsResponse copyWith(void Function(GetPlatformCryptoTransactionsResponse) updates) => super.copyWith((message) => updates(message as GetPlatformCryptoTransactionsResponse)) as GetPlatformCryptoTransactionsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPlatformCryptoTransactionsResponse create() => GetPlatformCryptoTransactionsResponse._();
  GetPlatformCryptoTransactionsResponse createEmptyInstance() => create();
  static $pb.PbList<GetPlatformCryptoTransactionsResponse> createRepeated() => $pb.PbList<GetPlatformCryptoTransactionsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetPlatformCryptoTransactionsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetPlatformCryptoTransactionsResponse>(create);
  static GetPlatformCryptoTransactionsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<CryptoTransaction> get transactions => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get totalCount => $_getIZ(1);
  @$pb.TagNumber(2)
  set totalCount($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotalCount() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalCount() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get page => $_getIZ(2);
  @$pb.TagNumber(3)
  set page($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPage() => $_has(2);
  @$pb.TagNumber(3)
  void clearPage() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get perPage => $_getIZ(3);
  @$pb.TagNumber(4)
  set perPage($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPerPage() => $_has(3);
  @$pb.TagNumber(4)
  void clearPerPage() => clearField(4);
}

class CryptoNewsItem extends $pb.GeneratedMessage {
  factory CryptoNewsItem({
    $core.String? id,
    $core.String? title,
    $core.String? url,
    $1.Timestamp? publishedAt,
    $core.Iterable<$core.String>? currencies,
    $core.String? source,
    $core.String? sentiment,
    $core.int? votesPositive,
    $core.int? votesNegative,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (title != null) {
      $result.title = title;
    }
    if (url != null) {
      $result.url = url;
    }
    if (publishedAt != null) {
      $result.publishedAt = publishedAt;
    }
    if (currencies != null) {
      $result.currencies.addAll(currencies);
    }
    if (source != null) {
      $result.source = source;
    }
    if (sentiment != null) {
      $result.sentiment = sentiment;
    }
    if (votesPositive != null) {
      $result.votesPositive = votesPositive;
    }
    if (votesNegative != null) {
      $result.votesNegative = votesNegative;
    }
    return $result;
  }
  CryptoNewsItem._() : super();
  factory CryptoNewsItem.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CryptoNewsItem.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CryptoNewsItem', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'title')
    ..aOS(3, _omitFieldNames ? '' : 'url')
    ..aOM<$1.Timestamp>(4, _omitFieldNames ? '' : 'publishedAt', subBuilder: $1.Timestamp.create)
    ..pPS(5, _omitFieldNames ? '' : 'currencies')
    ..aOS(6, _omitFieldNames ? '' : 'source')
    ..aOS(7, _omitFieldNames ? '' : 'sentiment')
    ..a<$core.int>(8, _omitFieldNames ? '' : 'votesPositive', $pb.PbFieldType.O3)
    ..a<$core.int>(9, _omitFieldNames ? '' : 'votesNegative', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CryptoNewsItem clone() => CryptoNewsItem()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CryptoNewsItem copyWith(void Function(CryptoNewsItem) updates) => super.copyWith((message) => updates(message as CryptoNewsItem)) as CryptoNewsItem;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CryptoNewsItem create() => CryptoNewsItem._();
  CryptoNewsItem createEmptyInstance() => create();
  static $pb.PbList<CryptoNewsItem> createRepeated() => $pb.PbList<CryptoNewsItem>();
  @$core.pragma('dart2js:noInline')
  static CryptoNewsItem getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CryptoNewsItem>(create);
  static CryptoNewsItem? _defaultInstance;

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
  $core.String get url => $_getSZ(2);
  @$pb.TagNumber(3)
  set url($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasUrl() => $_has(2);
  @$pb.TagNumber(3)
  void clearUrl() => clearField(3);

  @$pb.TagNumber(4)
  $1.Timestamp get publishedAt => $_getN(3);
  @$pb.TagNumber(4)
  set publishedAt($1.Timestamp v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasPublishedAt() => $_has(3);
  @$pb.TagNumber(4)
  void clearPublishedAt() => clearField(4);
  @$pb.TagNumber(4)
  $1.Timestamp ensurePublishedAt() => $_ensure(3);

  @$pb.TagNumber(5)
  $core.List<$core.String> get currencies => $_getList(4);

  @$pb.TagNumber(6)
  $core.String get source => $_getSZ(5);
  @$pb.TagNumber(6)
  set source($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasSource() => $_has(5);
  @$pb.TagNumber(6)
  void clearSource() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get sentiment => $_getSZ(6);
  @$pb.TagNumber(7)
  set sentiment($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasSentiment() => $_has(6);
  @$pb.TagNumber(7)
  void clearSentiment() => clearField(7);

  @$pb.TagNumber(8)
  $core.int get votesPositive => $_getIZ(7);
  @$pb.TagNumber(8)
  set votesPositive($core.int v) { $_setSignedInt32(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasVotesPositive() => $_has(7);
  @$pb.TagNumber(8)
  void clearVotesPositive() => clearField(8);

  @$pb.TagNumber(9)
  $core.int get votesNegative => $_getIZ(8);
  @$pb.TagNumber(9)
  set votesNegative($core.int v) { $_setSignedInt32(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasVotesNegative() => $_has(8);
  @$pb.TagNumber(9)
  void clearVotesNegative() => clearField(9);
}

class GetCryptoNewsRequest extends $pb.GeneratedMessage {
  factory GetCryptoNewsRequest({
    $core.Iterable<$core.String>? currencies,
    $core.int? limit,
  }) {
    final $result = create();
    if (currencies != null) {
      $result.currencies.addAll(currencies);
    }
    if (limit != null) {
      $result.limit = limit;
    }
    return $result;
  }
  GetCryptoNewsRequest._() : super();
  factory GetCryptoNewsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCryptoNewsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetCryptoNewsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'currencies')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCryptoNewsRequest clone() => GetCryptoNewsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCryptoNewsRequest copyWith(void Function(GetCryptoNewsRequest) updates) => super.copyWith((message) => updates(message as GetCryptoNewsRequest)) as GetCryptoNewsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCryptoNewsRequest create() => GetCryptoNewsRequest._();
  GetCryptoNewsRequest createEmptyInstance() => create();
  static $pb.PbList<GetCryptoNewsRequest> createRepeated() => $pb.PbList<GetCryptoNewsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetCryptoNewsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetCryptoNewsRequest>(create);
  static GetCryptoNewsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.String> get currencies => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get limit => $_getIZ(1);
  @$pb.TagNumber(2)
  set limit($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => clearField(2);
}

class GetCryptoNewsResponse extends $pb.GeneratedMessage {
  factory GetCryptoNewsResponse({
    $core.Iterable<CryptoNewsItem>? items,
  }) {
    final $result = create();
    if (items != null) {
      $result.items.addAll(items);
    }
    return $result;
  }
  GetCryptoNewsResponse._() : super();
  factory GetCryptoNewsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCryptoNewsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetCryptoNewsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<CryptoNewsItem>(1, _omitFieldNames ? '' : 'items', $pb.PbFieldType.PM, subBuilder: CryptoNewsItem.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCryptoNewsResponse clone() => GetCryptoNewsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCryptoNewsResponse copyWith(void Function(GetCryptoNewsResponse) updates) => super.copyWith((message) => updates(message as GetCryptoNewsResponse)) as GetCryptoNewsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetCryptoNewsResponse create() => GetCryptoNewsResponse._();
  GetCryptoNewsResponse createEmptyInstance() => create();
  static $pb.PbList<GetCryptoNewsResponse> createRepeated() => $pb.PbList<GetCryptoNewsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetCryptoNewsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetCryptoNewsResponse>(create);
  static GetCryptoNewsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<CryptoNewsItem> get items => $_getList(0);
}

class OHLCVPoint extends $pb.GeneratedMessage {
  factory OHLCVPoint({
    $1.Timestamp? timestamp,
    $core.double? open,
    $core.double? high,
    $core.double? low,
    $core.double? close,
    $core.double? volume,
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
    return $result;
  }
  OHLCVPoint._() : super();
  factory OHLCVPoint.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory OHLCVPoint.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'OHLCVPoint', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<$1.Timestamp>(1, _omitFieldNames ? '' : 'timestamp', subBuilder: $1.Timestamp.create)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'open', $pb.PbFieldType.OD)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'high', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'low', $pb.PbFieldType.OD)
    ..a<$core.double>(5, _omitFieldNames ? '' : 'close', $pb.PbFieldType.OD)
    ..a<$core.double>(6, _omitFieldNames ? '' : 'volume', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  OHLCVPoint clone() => OHLCVPoint()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  OHLCVPoint copyWith(void Function(OHLCVPoint) updates) => super.copyWith((message) => updates(message as OHLCVPoint)) as OHLCVPoint;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static OHLCVPoint create() => OHLCVPoint._();
  OHLCVPoint createEmptyInstance() => create();
  static $pb.PbList<OHLCVPoint> createRepeated() => $pb.PbList<OHLCVPoint>();
  @$core.pragma('dart2js:noInline')
  static OHLCVPoint getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<OHLCVPoint>(create);
  static OHLCVPoint? _defaultInstance;

  @$pb.TagNumber(1)
  $1.Timestamp get timestamp => $_getN(0);
  @$pb.TagNumber(1)
  set timestamp($1.Timestamp v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasTimestamp() => $_has(0);
  @$pb.TagNumber(1)
  void clearTimestamp() => clearField(1);
  @$pb.TagNumber(1)
  $1.Timestamp ensureTimestamp() => $_ensure(0);

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
  $core.double get volume => $_getN(5);
  @$pb.TagNumber(6)
  set volume($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasVolume() => $_has(5);
  @$pb.TagNumber(6)
  void clearVolume() => clearField(6);
}

class GetOHLCVRequest extends $pb.GeneratedMessage {
  factory GetOHLCVRequest({
    $core.String? cryptoId,
    $core.String? vsCurrency,
    $core.int? days,
  }) {
    final $result = create();
    if (cryptoId != null) {
      $result.cryptoId = cryptoId;
    }
    if (vsCurrency != null) {
      $result.vsCurrency = vsCurrency;
    }
    if (days != null) {
      $result.days = days;
    }
    return $result;
  }
  GetOHLCVRequest._() : super();
  factory GetOHLCVRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetOHLCVRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetOHLCVRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'cryptoId')
    ..aOS(2, _omitFieldNames ? '' : 'vsCurrency')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'days', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetOHLCVRequest clone() => GetOHLCVRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetOHLCVRequest copyWith(void Function(GetOHLCVRequest) updates) => super.copyWith((message) => updates(message as GetOHLCVRequest)) as GetOHLCVRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetOHLCVRequest create() => GetOHLCVRequest._();
  GetOHLCVRequest createEmptyInstance() => create();
  static $pb.PbList<GetOHLCVRequest> createRepeated() => $pb.PbList<GetOHLCVRequest>();
  @$core.pragma('dart2js:noInline')
  static GetOHLCVRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetOHLCVRequest>(create);
  static GetOHLCVRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get cryptoId => $_getSZ(0);
  @$pb.TagNumber(1)
  set cryptoId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCryptoId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCryptoId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get vsCurrency => $_getSZ(1);
  @$pb.TagNumber(2)
  set vsCurrency($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasVsCurrency() => $_has(1);
  @$pb.TagNumber(2)
  void clearVsCurrency() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get days => $_getIZ(2);
  @$pb.TagNumber(3)
  set days($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDays() => $_has(2);
  @$pb.TagNumber(3)
  void clearDays() => clearField(3);
}

class GetOHLCVResponse extends $pb.GeneratedMessage {
  factory GetOHLCVResponse({
    $core.Iterable<OHLCVPoint>? points,
  }) {
    final $result = create();
    if (points != null) {
      $result.points.addAll(points);
    }
    return $result;
  }
  GetOHLCVResponse._() : super();
  factory GetOHLCVResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetOHLCVResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetOHLCVResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<OHLCVPoint>(1, _omitFieldNames ? '' : 'points', $pb.PbFieldType.PM, subBuilder: OHLCVPoint.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetOHLCVResponse clone() => GetOHLCVResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetOHLCVResponse copyWith(void Function(GetOHLCVResponse) updates) => super.copyWith((message) => updates(message as GetOHLCVResponse)) as GetOHLCVResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetOHLCVResponse create() => GetOHLCVResponse._();
  GetOHLCVResponse createEmptyInstance() => create();
  static $pb.PbList<GetOHLCVResponse> createRepeated() => $pb.PbList<GetOHLCVResponse>();
  @$core.pragma('dart2js:noInline')
  static GetOHLCVResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetOHLCVResponse>(create);
  static GetOHLCVResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<OHLCVPoint> get points => $_getList(0);
}

class OrderBookEntry extends $pb.GeneratedMessage {
  factory OrderBookEntry({
    $core.String? price,
    $core.String? volume,
  }) {
    final $result = create();
    if (price != null) {
      $result.price = price;
    }
    if (volume != null) {
      $result.volume = volume;
    }
    return $result;
  }
  OrderBookEntry._() : super();
  factory OrderBookEntry.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory OrderBookEntry.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'OrderBookEntry', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'price')
    ..aOS(2, _omitFieldNames ? '' : 'volume')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  OrderBookEntry clone() => OrderBookEntry()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  OrderBookEntry copyWith(void Function(OrderBookEntry) updates) => super.copyWith((message) => updates(message as OrderBookEntry)) as OrderBookEntry;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static OrderBookEntry create() => OrderBookEntry._();
  OrderBookEntry createEmptyInstance() => create();
  static $pb.PbList<OrderBookEntry> createRepeated() => $pb.PbList<OrderBookEntry>();
  @$core.pragma('dart2js:noInline')
  static OrderBookEntry getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<OrderBookEntry>(create);
  static OrderBookEntry? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get price => $_getSZ(0);
  @$pb.TagNumber(1)
  set price($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPrice() => $_has(0);
  @$pb.TagNumber(1)
  void clearPrice() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get volume => $_getSZ(1);
  @$pb.TagNumber(2)
  set volume($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasVolume() => $_has(1);
  @$pb.TagNumber(2)
  void clearVolume() => clearField(2);
}

class GetOrderBookRequest extends $pb.GeneratedMessage {
  factory GetOrderBookRequest({
    $core.String? market,
  }) {
    final $result = create();
    if (market != null) {
      $result.market = market;
    }
    return $result;
  }
  GetOrderBookRequest._() : super();
  factory GetOrderBookRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetOrderBookRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetOrderBookRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'market')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetOrderBookRequest clone() => GetOrderBookRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetOrderBookRequest copyWith(void Function(GetOrderBookRequest) updates) => super.copyWith((message) => updates(message as GetOrderBookRequest)) as GetOrderBookRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetOrderBookRequest create() => GetOrderBookRequest._();
  GetOrderBookRequest createEmptyInstance() => create();
  static $pb.PbList<GetOrderBookRequest> createRepeated() => $pb.PbList<GetOrderBookRequest>();
  @$core.pragma('dart2js:noInline')
  static GetOrderBookRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetOrderBookRequest>(create);
  static GetOrderBookRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get market => $_getSZ(0);
  @$pb.TagNumber(1)
  set market($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMarket() => $_has(0);
  @$pb.TagNumber(1)
  void clearMarket() => clearField(1);
}

class GetOrderBookResponse extends $pb.GeneratedMessage {
  factory GetOrderBookResponse({
    $core.Iterable<OrderBookEntry>? bids,
    $core.Iterable<OrderBookEntry>? asks,
    $core.String? market,
  }) {
    final $result = create();
    if (bids != null) {
      $result.bids.addAll(bids);
    }
    if (asks != null) {
      $result.asks.addAll(asks);
    }
    if (market != null) {
      $result.market = market;
    }
    return $result;
  }
  GetOrderBookResponse._() : super();
  factory GetOrderBookResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetOrderBookResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetOrderBookResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<OrderBookEntry>(1, _omitFieldNames ? '' : 'bids', $pb.PbFieldType.PM, subBuilder: OrderBookEntry.create)
    ..pc<OrderBookEntry>(2, _omitFieldNames ? '' : 'asks', $pb.PbFieldType.PM, subBuilder: OrderBookEntry.create)
    ..aOS(3, _omitFieldNames ? '' : 'market')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetOrderBookResponse clone() => GetOrderBookResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetOrderBookResponse copyWith(void Function(GetOrderBookResponse) updates) => super.copyWith((message) => updates(message as GetOrderBookResponse)) as GetOrderBookResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetOrderBookResponse create() => GetOrderBookResponse._();
  GetOrderBookResponse createEmptyInstance() => create();
  static $pb.PbList<GetOrderBookResponse> createRepeated() => $pb.PbList<GetOrderBookResponse>();
  @$core.pragma('dart2js:noInline')
  static GetOrderBookResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetOrderBookResponse>(create);
  static GetOrderBookResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<OrderBookEntry> get bids => $_getList(0);

  @$pb.TagNumber(2)
  $core.List<OrderBookEntry> get asks => $_getList(1);

  @$pb.TagNumber(3)
  $core.String get market => $_getSZ(2);
  @$pb.TagNumber(3)
  set market($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMarket() => $_has(2);
  @$pb.TagNumber(3)
  void clearMarket() => clearField(3);
}

class TradeEntry extends $pb.GeneratedMessage {
  factory TradeEntry({
    $core.String? id,
    $core.String? price,
    $core.String? volume,
    $core.String? side,
    $core.String? market,
    $1.Timestamp? createdAt,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (price != null) {
      $result.price = price;
    }
    if (volume != null) {
      $result.volume = volume;
    }
    if (side != null) {
      $result.side = side;
    }
    if (market != null) {
      $result.market = market;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    return $result;
  }
  TradeEntry._() : super();
  factory TradeEntry.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TradeEntry.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TradeEntry', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'price')
    ..aOS(3, _omitFieldNames ? '' : 'volume')
    ..aOS(4, _omitFieldNames ? '' : 'side')
    ..aOS(5, _omitFieldNames ? '' : 'market')
    ..aOM<$1.Timestamp>(6, _omitFieldNames ? '' : 'createdAt', subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TradeEntry clone() => TradeEntry()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TradeEntry copyWith(void Function(TradeEntry) updates) => super.copyWith((message) => updates(message as TradeEntry)) as TradeEntry;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TradeEntry create() => TradeEntry._();
  TradeEntry createEmptyInstance() => create();
  static $pb.PbList<TradeEntry> createRepeated() => $pb.PbList<TradeEntry>();
  @$core.pragma('dart2js:noInline')
  static TradeEntry getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TradeEntry>(create);
  static TradeEntry? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get price => $_getSZ(1);
  @$pb.TagNumber(2)
  set price($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPrice() => $_has(1);
  @$pb.TagNumber(2)
  void clearPrice() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get volume => $_getSZ(2);
  @$pb.TagNumber(3)
  set volume($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasVolume() => $_has(2);
  @$pb.TagNumber(3)
  void clearVolume() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get side => $_getSZ(3);
  @$pb.TagNumber(4)
  set side($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasSide() => $_has(3);
  @$pb.TagNumber(4)
  void clearSide() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get market => $_getSZ(4);
  @$pb.TagNumber(5)
  set market($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasMarket() => $_has(4);
  @$pb.TagNumber(5)
  void clearMarket() => clearField(5);

  @$pb.TagNumber(6)
  $1.Timestamp get createdAt => $_getN(5);
  @$pb.TagNumber(6)
  set createdAt($1.Timestamp v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasCreatedAt() => $_has(5);
  @$pb.TagNumber(6)
  void clearCreatedAt() => clearField(6);
  @$pb.TagNumber(6)
  $1.Timestamp ensureCreatedAt() => $_ensure(5);
}

class GetRecentTradesRequest extends $pb.GeneratedMessage {
  factory GetRecentTradesRequest({
    $core.String? market,
  }) {
    final $result = create();
    if (market != null) {
      $result.market = market;
    }
    return $result;
  }
  GetRecentTradesRequest._() : super();
  factory GetRecentTradesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetRecentTradesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetRecentTradesRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'market')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetRecentTradesRequest clone() => GetRecentTradesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetRecentTradesRequest copyWith(void Function(GetRecentTradesRequest) updates) => super.copyWith((message) => updates(message as GetRecentTradesRequest)) as GetRecentTradesRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetRecentTradesRequest create() => GetRecentTradesRequest._();
  GetRecentTradesRequest createEmptyInstance() => create();
  static $pb.PbList<GetRecentTradesRequest> createRepeated() => $pb.PbList<GetRecentTradesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetRecentTradesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetRecentTradesRequest>(create);
  static GetRecentTradesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get market => $_getSZ(0);
  @$pb.TagNumber(1)
  set market($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMarket() => $_has(0);
  @$pb.TagNumber(1)
  void clearMarket() => clearField(1);
}

class GetRecentTradesResponse extends $pb.GeneratedMessage {
  factory GetRecentTradesResponse({
    $core.Iterable<TradeEntry>? trades,
  }) {
    final $result = create();
    if (trades != null) {
      $result.trades.addAll(trades);
    }
    return $result;
  }
  GetRecentTradesResponse._() : super();
  factory GetRecentTradesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetRecentTradesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetRecentTradesResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<TradeEntry>(1, _omitFieldNames ? '' : 'trades', $pb.PbFieldType.PM, subBuilder: TradeEntry.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetRecentTradesResponse clone() => GetRecentTradesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetRecentTradesResponse copyWith(void Function(GetRecentTradesResponse) updates) => super.copyWith((message) => updates(message as GetRecentTradesResponse)) as GetRecentTradesResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetRecentTradesResponse create() => GetRecentTradesResponse._();
  GetRecentTradesResponse createEmptyInstance() => create();
  static $pb.PbList<GetRecentTradesResponse> createRepeated() => $pb.PbList<GetRecentTradesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetRecentTradesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetRecentTradesResponse>(create);
  static GetRecentTradesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<TradeEntry> get trades => $_getList(0);
}

class GetFearGreedIndexRequest extends $pb.GeneratedMessage {
  factory GetFearGreedIndexRequest() => create();
  GetFearGreedIndexRequest._() : super();
  factory GetFearGreedIndexRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetFearGreedIndexRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetFearGreedIndexRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetFearGreedIndexRequest clone() => GetFearGreedIndexRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetFearGreedIndexRequest copyWith(void Function(GetFearGreedIndexRequest) updates) => super.copyWith((message) => updates(message as GetFearGreedIndexRequest)) as GetFearGreedIndexRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetFearGreedIndexRequest create() => GetFearGreedIndexRequest._();
  GetFearGreedIndexRequest createEmptyInstance() => create();
  static $pb.PbList<GetFearGreedIndexRequest> createRepeated() => $pb.PbList<GetFearGreedIndexRequest>();
  @$core.pragma('dart2js:noInline')
  static GetFearGreedIndexRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetFearGreedIndexRequest>(create);
  static GetFearGreedIndexRequest? _defaultInstance;
}

class FearGreedEntry extends $pb.GeneratedMessage {
  factory FearGreedEntry({
    $core.int? value,
    $core.String? classification,
    $1.Timestamp? timestamp,
  }) {
    final $result = create();
    if (value != null) {
      $result.value = value;
    }
    if (classification != null) {
      $result.classification = classification;
    }
    if (timestamp != null) {
      $result.timestamp = timestamp;
    }
    return $result;
  }
  FearGreedEntry._() : super();
  factory FearGreedEntry.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FearGreedEntry.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FearGreedEntry', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'value', $pb.PbFieldType.O3)
    ..aOS(2, _omitFieldNames ? '' : 'classification')
    ..aOM<$1.Timestamp>(3, _omitFieldNames ? '' : 'timestamp', subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FearGreedEntry clone() => FearGreedEntry()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FearGreedEntry copyWith(void Function(FearGreedEntry) updates) => super.copyWith((message) => updates(message as FearGreedEntry)) as FearGreedEntry;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FearGreedEntry create() => FearGreedEntry._();
  FearGreedEntry createEmptyInstance() => create();
  static $pb.PbList<FearGreedEntry> createRepeated() => $pb.PbList<FearGreedEntry>();
  @$core.pragma('dart2js:noInline')
  static FearGreedEntry getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FearGreedEntry>(create);
  static FearGreedEntry? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get value => $_getIZ(0);
  @$pb.TagNumber(1)
  set value($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearValue() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get classification => $_getSZ(1);
  @$pb.TagNumber(2)
  set classification($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasClassification() => $_has(1);
  @$pb.TagNumber(2)
  void clearClassification() => clearField(2);

  @$pb.TagNumber(3)
  $1.Timestamp get timestamp => $_getN(2);
  @$pb.TagNumber(3)
  set timestamp($1.Timestamp v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasTimestamp() => $_has(2);
  @$pb.TagNumber(3)
  void clearTimestamp() => clearField(3);
  @$pb.TagNumber(3)
  $1.Timestamp ensureTimestamp() => $_ensure(2);
}

class GetFearGreedIndexResponse extends $pb.GeneratedMessage {
  factory GetFearGreedIndexResponse({
    FearGreedEntry? current,
    $core.Iterable<FearGreedEntry>? history,
  }) {
    final $result = create();
    if (current != null) {
      $result.current = current;
    }
    if (history != null) {
      $result.history.addAll(history);
    }
    return $result;
  }
  GetFearGreedIndexResponse._() : super();
  factory GetFearGreedIndexResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetFearGreedIndexResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetFearGreedIndexResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<FearGreedEntry>(1, _omitFieldNames ? '' : 'current', subBuilder: FearGreedEntry.create)
    ..pc<FearGreedEntry>(2, _omitFieldNames ? '' : 'history', $pb.PbFieldType.PM, subBuilder: FearGreedEntry.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetFearGreedIndexResponse clone() => GetFearGreedIndexResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetFearGreedIndexResponse copyWith(void Function(GetFearGreedIndexResponse) updates) => super.copyWith((message) => updates(message as GetFearGreedIndexResponse)) as GetFearGreedIndexResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetFearGreedIndexResponse create() => GetFearGreedIndexResponse._();
  GetFearGreedIndexResponse createEmptyInstance() => create();
  static $pb.PbList<GetFearGreedIndexResponse> createRepeated() => $pb.PbList<GetFearGreedIndexResponse>();
  @$core.pragma('dart2js:noInline')
  static GetFearGreedIndexResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetFearGreedIndexResponse>(create);
  static GetFearGreedIndexResponse? _defaultInstance;

  @$pb.TagNumber(1)
  FearGreedEntry get current => $_getN(0);
  @$pb.TagNumber(1)
  set current(FearGreedEntry v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasCurrent() => $_has(0);
  @$pb.TagNumber(1)
  void clearCurrent() => clearField(1);
  @$pb.TagNumber(1)
  FearGreedEntry ensureCurrent() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.List<FearGreedEntry> get history => $_getList(1);
}

class PriceAlert extends $pb.GeneratedMessage {
  factory PriceAlert({
    $core.String? id,
    $core.String? cryptoId,
    $core.String? cryptoSymbol,
    $core.double? targetPrice,
    $core.String? direction,
    $core.String? fiatCurrency,
    $core.bool? isActive,
    $core.bool? isTriggered,
    $1.Timestamp? createdAt,
    $1.Timestamp? triggeredAt,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (cryptoId != null) {
      $result.cryptoId = cryptoId;
    }
    if (cryptoSymbol != null) {
      $result.cryptoSymbol = cryptoSymbol;
    }
    if (targetPrice != null) {
      $result.targetPrice = targetPrice;
    }
    if (direction != null) {
      $result.direction = direction;
    }
    if (fiatCurrency != null) {
      $result.fiatCurrency = fiatCurrency;
    }
    if (isActive != null) {
      $result.isActive = isActive;
    }
    if (isTriggered != null) {
      $result.isTriggered = isTriggered;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    if (triggeredAt != null) {
      $result.triggeredAt = triggeredAt;
    }
    return $result;
  }
  PriceAlert._() : super();
  factory PriceAlert.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PriceAlert.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PriceAlert', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'cryptoId')
    ..aOS(3, _omitFieldNames ? '' : 'cryptoSymbol')
    ..a<$core.double>(4, _omitFieldNames ? '' : 'targetPrice', $pb.PbFieldType.OD)
    ..aOS(5, _omitFieldNames ? '' : 'direction')
    ..aOS(6, _omitFieldNames ? '' : 'fiatCurrency')
    ..aOB(7, _omitFieldNames ? '' : 'isActive')
    ..aOB(8, _omitFieldNames ? '' : 'isTriggered')
    ..aOM<$1.Timestamp>(9, _omitFieldNames ? '' : 'createdAt', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(10, _omitFieldNames ? '' : 'triggeredAt', subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PriceAlert clone() => PriceAlert()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PriceAlert copyWith(void Function(PriceAlert) updates) => super.copyWith((message) => updates(message as PriceAlert)) as PriceAlert;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PriceAlert create() => PriceAlert._();
  PriceAlert createEmptyInstance() => create();
  static $pb.PbList<PriceAlert> createRepeated() => $pb.PbList<PriceAlert>();
  @$core.pragma('dart2js:noInline')
  static PriceAlert getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PriceAlert>(create);
  static PriceAlert? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get cryptoId => $_getSZ(1);
  @$pb.TagNumber(2)
  set cryptoId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCryptoId() => $_has(1);
  @$pb.TagNumber(2)
  void clearCryptoId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get cryptoSymbol => $_getSZ(2);
  @$pb.TagNumber(3)
  set cryptoSymbol($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCryptoSymbol() => $_has(2);
  @$pb.TagNumber(3)
  void clearCryptoSymbol() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get targetPrice => $_getN(3);
  @$pb.TagNumber(4)
  set targetPrice($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTargetPrice() => $_has(3);
  @$pb.TagNumber(4)
  void clearTargetPrice() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get direction => $_getSZ(4);
  @$pb.TagNumber(5)
  set direction($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasDirection() => $_has(4);
  @$pb.TagNumber(5)
  void clearDirection() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get fiatCurrency => $_getSZ(5);
  @$pb.TagNumber(6)
  set fiatCurrency($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasFiatCurrency() => $_has(5);
  @$pb.TagNumber(6)
  void clearFiatCurrency() => clearField(6);

  @$pb.TagNumber(7)
  $core.bool get isActive => $_getBF(6);
  @$pb.TagNumber(7)
  set isActive($core.bool v) { $_setBool(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasIsActive() => $_has(6);
  @$pb.TagNumber(7)
  void clearIsActive() => clearField(7);

  @$pb.TagNumber(8)
  $core.bool get isTriggered => $_getBF(7);
  @$pb.TagNumber(8)
  set isTriggered($core.bool v) { $_setBool(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasIsTriggered() => $_has(7);
  @$pb.TagNumber(8)
  void clearIsTriggered() => clearField(8);

  @$pb.TagNumber(9)
  $1.Timestamp get createdAt => $_getN(8);
  @$pb.TagNumber(9)
  set createdAt($1.Timestamp v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasCreatedAt() => $_has(8);
  @$pb.TagNumber(9)
  void clearCreatedAt() => clearField(9);
  @$pb.TagNumber(9)
  $1.Timestamp ensureCreatedAt() => $_ensure(8);

  @$pb.TagNumber(10)
  $1.Timestamp get triggeredAt => $_getN(9);
  @$pb.TagNumber(10)
  set triggeredAt($1.Timestamp v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasTriggeredAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearTriggeredAt() => clearField(10);
  @$pb.TagNumber(10)
  $1.Timestamp ensureTriggeredAt() => $_ensure(9);
}

class CreatePriceAlertRequest extends $pb.GeneratedMessage {
  factory CreatePriceAlertRequest({
    $core.String? cryptoId,
    $core.double? targetPrice,
    $core.String? direction,
    $core.String? fiatCurrency,
  }) {
    final $result = create();
    if (cryptoId != null) {
      $result.cryptoId = cryptoId;
    }
    if (targetPrice != null) {
      $result.targetPrice = targetPrice;
    }
    if (direction != null) {
      $result.direction = direction;
    }
    if (fiatCurrency != null) {
      $result.fiatCurrency = fiatCurrency;
    }
    return $result;
  }
  CreatePriceAlertRequest._() : super();
  factory CreatePriceAlertRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreatePriceAlertRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreatePriceAlertRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'cryptoId')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'targetPrice', $pb.PbFieldType.OD)
    ..aOS(3, _omitFieldNames ? '' : 'direction')
    ..aOS(4, _omitFieldNames ? '' : 'fiatCurrency')
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
  $core.String get cryptoId => $_getSZ(0);
  @$pb.TagNumber(1)
  set cryptoId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCryptoId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCryptoId() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get targetPrice => $_getN(1);
  @$pb.TagNumber(2)
  set targetPrice($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTargetPrice() => $_has(1);
  @$pb.TagNumber(2)
  void clearTargetPrice() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get direction => $_getSZ(2);
  @$pb.TagNumber(3)
  set direction($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDirection() => $_has(2);
  @$pb.TagNumber(3)
  void clearDirection() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get fiatCurrency => $_getSZ(3);
  @$pb.TagNumber(4)
  set fiatCurrency($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasFiatCurrency() => $_has(3);
  @$pb.TagNumber(4)
  void clearFiatCurrency() => clearField(4);
}

class CreatePriceAlertResponse extends $pb.GeneratedMessage {
  factory CreatePriceAlertResponse({
    PriceAlert? alert,
  }) {
    final $result = create();
    if (alert != null) {
      $result.alert = alert;
    }
    return $result;
  }
  CreatePriceAlertResponse._() : super();
  factory CreatePriceAlertResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreatePriceAlertResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreatePriceAlertResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<PriceAlert>(1, _omitFieldNames ? '' : 'alert', subBuilder: PriceAlert.create)
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
  PriceAlert get alert => $_getN(0);
  @$pb.TagNumber(1)
  set alert(PriceAlert v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasAlert() => $_has(0);
  @$pb.TagNumber(1)
  void clearAlert() => clearField(1);
  @$pb.TagNumber(1)
  PriceAlert ensureAlert() => $_ensure(0);
}

class GetPriceAlertsRequest extends $pb.GeneratedMessage {
  factory GetPriceAlertsRequest({
    $core.bool? activeOnly,
  }) {
    final $result = create();
    if (activeOnly != null) {
      $result.activeOnly = activeOnly;
    }
    return $result;
  }
  GetPriceAlertsRequest._() : super();
  factory GetPriceAlertsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPriceAlertsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetPriceAlertsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'activeOnly')
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
  $core.bool get activeOnly => $_getBF(0);
  @$pb.TagNumber(1)
  set activeOnly($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasActiveOnly() => $_has(0);
  @$pb.TagNumber(1)
  void clearActiveOnly() => clearField(1);
}

class GetPriceAlertsResponse extends $pb.GeneratedMessage {
  factory GetPriceAlertsResponse({
    $core.Iterable<PriceAlert>? alerts,
  }) {
    final $result = create();
    if (alerts != null) {
      $result.alerts.addAll(alerts);
    }
    return $result;
  }
  GetPriceAlertsResponse._() : super();
  factory GetPriceAlertsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPriceAlertsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetPriceAlertsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<PriceAlert>(1, _omitFieldNames ? '' : 'alerts', $pb.PbFieldType.PM, subBuilder: PriceAlert.create)
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
  $core.List<PriceAlert> get alerts => $_getList(0);
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

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DeletePriceAlertRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
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
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    return $result;
  }
  DeletePriceAlertResponse._() : super();
  factory DeletePriceAlertResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeletePriceAlertResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DeletePriceAlertResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
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
}

class FeeTier extends $pb.GeneratedMessage {
  factory FeeTier({
    $core.String? id,
    $core.String? currency,
    $core.String? cryptoId,
    $core.double? minAmount,
    $core.double? maxAmount,
    $core.double? feePercentage,
    $core.bool? isActive,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (cryptoId != null) {
      $result.cryptoId = cryptoId;
    }
    if (minAmount != null) {
      $result.minAmount = minAmount;
    }
    if (maxAmount != null) {
      $result.maxAmount = maxAmount;
    }
    if (feePercentage != null) {
      $result.feePercentage = feePercentage;
    }
    if (isActive != null) {
      $result.isActive = isActive;
    }
    return $result;
  }
  FeeTier._() : super();
  factory FeeTier.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FeeTier.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FeeTier', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'currency')
    ..aOS(3, _omitFieldNames ? '' : 'cryptoId')
    ..a<$core.double>(4, _omitFieldNames ? '' : 'minAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(5, _omitFieldNames ? '' : 'maxAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(6, _omitFieldNames ? '' : 'feePercentage', $pb.PbFieldType.OD)
    ..aOB(7, _omitFieldNames ? '' : 'isActive')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FeeTier clone() => FeeTier()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FeeTier copyWith(void Function(FeeTier) updates) => super.copyWith((message) => updates(message as FeeTier)) as FeeTier;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FeeTier create() => FeeTier._();
  FeeTier createEmptyInstance() => create();
  static $pb.PbList<FeeTier> createRepeated() => $pb.PbList<FeeTier>();
  @$core.pragma('dart2js:noInline')
  static FeeTier getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FeeTier>(create);
  static FeeTier? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get currency => $_getSZ(1);
  @$pb.TagNumber(2)
  set currency($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCurrency() => $_has(1);
  @$pb.TagNumber(2)
  void clearCurrency() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get cryptoId => $_getSZ(2);
  @$pb.TagNumber(3)
  set cryptoId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCryptoId() => $_has(2);
  @$pb.TagNumber(3)
  void clearCryptoId() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get minAmount => $_getN(3);
  @$pb.TagNumber(4)
  set minAmount($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMinAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearMinAmount() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get maxAmount => $_getN(4);
  @$pb.TagNumber(5)
  set maxAmount($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasMaxAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearMaxAmount() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get feePercentage => $_getN(5);
  @$pb.TagNumber(6)
  set feePercentage($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasFeePercentage() => $_has(5);
  @$pb.TagNumber(6)
  void clearFeePercentage() => clearField(6);

  @$pb.TagNumber(7)
  $core.bool get isActive => $_getBF(6);
  @$pb.TagNumber(7)
  set isActive($core.bool v) { $_setBool(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasIsActive() => $_has(6);
  @$pb.TagNumber(7)
  void clearIsActive() => clearField(7);
}

class GetFeeTiersRequest extends $pb.GeneratedMessage {
  factory GetFeeTiersRequest() => create();
  GetFeeTiersRequest._() : super();
  factory GetFeeTiersRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetFeeTiersRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetFeeTiersRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetFeeTiersRequest clone() => GetFeeTiersRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetFeeTiersRequest copyWith(void Function(GetFeeTiersRequest) updates) => super.copyWith((message) => updates(message as GetFeeTiersRequest)) as GetFeeTiersRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetFeeTiersRequest create() => GetFeeTiersRequest._();
  GetFeeTiersRequest createEmptyInstance() => create();
  static $pb.PbList<GetFeeTiersRequest> createRepeated() => $pb.PbList<GetFeeTiersRequest>();
  @$core.pragma('dart2js:noInline')
  static GetFeeTiersRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetFeeTiersRequest>(create);
  static GetFeeTiersRequest? _defaultInstance;
}

class GetFeeTiersResponse extends $pb.GeneratedMessage {
  factory GetFeeTiersResponse({
    $core.Iterable<FeeTier>? tiers,
  }) {
    final $result = create();
    if (tiers != null) {
      $result.tiers.addAll(tiers);
    }
    return $result;
  }
  GetFeeTiersResponse._() : super();
  factory GetFeeTiersResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetFeeTiersResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetFeeTiersResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<FeeTier>(1, _omitFieldNames ? '' : 'tiers', $pb.PbFieldType.PM, subBuilder: FeeTier.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetFeeTiersResponse clone() => GetFeeTiersResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetFeeTiersResponse copyWith(void Function(GetFeeTiersResponse) updates) => super.copyWith((message) => updates(message as GetFeeTiersResponse)) as GetFeeTiersResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetFeeTiersResponse create() => GetFeeTiersResponse._();
  GetFeeTiersResponse createEmptyInstance() => create();
  static $pb.PbList<GetFeeTiersResponse> createRepeated() => $pb.PbList<GetFeeTiersResponse>();
  @$core.pragma('dart2js:noInline')
  static GetFeeTiersResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetFeeTiersResponse>(create);
  static GetFeeTiersResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<FeeTier> get tiers => $_getList(0);
}

class CreateFeeTierRequest extends $pb.GeneratedMessage {
  factory CreateFeeTierRequest({
    $core.String? currency,
    $core.String? cryptoId,
    $core.double? minAmount,
    $core.double? maxAmount,
    $core.double? feePercentage,
  }) {
    final $result = create();
    if (currency != null) {
      $result.currency = currency;
    }
    if (cryptoId != null) {
      $result.cryptoId = cryptoId;
    }
    if (minAmount != null) {
      $result.minAmount = minAmount;
    }
    if (maxAmount != null) {
      $result.maxAmount = maxAmount;
    }
    if (feePercentage != null) {
      $result.feePercentage = feePercentage;
    }
    return $result;
  }
  CreateFeeTierRequest._() : super();
  factory CreateFeeTierRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateFeeTierRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateFeeTierRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'currency')
    ..aOS(2, _omitFieldNames ? '' : 'cryptoId')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'minAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'maxAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(5, _omitFieldNames ? '' : 'feePercentage', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateFeeTierRequest clone() => CreateFeeTierRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateFeeTierRequest copyWith(void Function(CreateFeeTierRequest) updates) => super.copyWith((message) => updates(message as CreateFeeTierRequest)) as CreateFeeTierRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateFeeTierRequest create() => CreateFeeTierRequest._();
  CreateFeeTierRequest createEmptyInstance() => create();
  static $pb.PbList<CreateFeeTierRequest> createRepeated() => $pb.PbList<CreateFeeTierRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateFeeTierRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateFeeTierRequest>(create);
  static CreateFeeTierRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get currency => $_getSZ(0);
  @$pb.TagNumber(1)
  set currency($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCurrency() => $_has(0);
  @$pb.TagNumber(1)
  void clearCurrency() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get cryptoId => $_getSZ(1);
  @$pb.TagNumber(2)
  set cryptoId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCryptoId() => $_has(1);
  @$pb.TagNumber(2)
  void clearCryptoId() => clearField(2);

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
  $core.double get feePercentage => $_getN(4);
  @$pb.TagNumber(5)
  set feePercentage($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasFeePercentage() => $_has(4);
  @$pb.TagNumber(5)
  void clearFeePercentage() => clearField(5);
}

class CreateFeeTierResponse extends $pb.GeneratedMessage {
  factory CreateFeeTierResponse({
    FeeTier? tier,
  }) {
    final $result = create();
    if (tier != null) {
      $result.tier = tier;
    }
    return $result;
  }
  CreateFeeTierResponse._() : super();
  factory CreateFeeTierResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateFeeTierResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateFeeTierResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<FeeTier>(1, _omitFieldNames ? '' : 'tier', subBuilder: FeeTier.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateFeeTierResponse clone() => CreateFeeTierResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateFeeTierResponse copyWith(void Function(CreateFeeTierResponse) updates) => super.copyWith((message) => updates(message as CreateFeeTierResponse)) as CreateFeeTierResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateFeeTierResponse create() => CreateFeeTierResponse._();
  CreateFeeTierResponse createEmptyInstance() => create();
  static $pb.PbList<CreateFeeTierResponse> createRepeated() => $pb.PbList<CreateFeeTierResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateFeeTierResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateFeeTierResponse>(create);
  static CreateFeeTierResponse? _defaultInstance;

  @$pb.TagNumber(1)
  FeeTier get tier => $_getN(0);
  @$pb.TagNumber(1)
  set tier(FeeTier v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasTier() => $_has(0);
  @$pb.TagNumber(1)
  void clearTier() => clearField(1);
  @$pb.TagNumber(1)
  FeeTier ensureTier() => $_ensure(0);
}

class UpdateFeeTierRequest extends $pb.GeneratedMessage {
  factory UpdateFeeTierRequest({
    $core.String? id,
    $core.double? feePercentage,
    $core.bool? isActive,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (feePercentage != null) {
      $result.feePercentage = feePercentage;
    }
    if (isActive != null) {
      $result.isActive = isActive;
    }
    return $result;
  }
  UpdateFeeTierRequest._() : super();
  factory UpdateFeeTierRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateFeeTierRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateFeeTierRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'feePercentage', $pb.PbFieldType.OD)
    ..aOB(3, _omitFieldNames ? '' : 'isActive')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateFeeTierRequest clone() => UpdateFeeTierRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateFeeTierRequest copyWith(void Function(UpdateFeeTierRequest) updates) => super.copyWith((message) => updates(message as UpdateFeeTierRequest)) as UpdateFeeTierRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateFeeTierRequest create() => UpdateFeeTierRequest._();
  UpdateFeeTierRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateFeeTierRequest> createRepeated() => $pb.PbList<UpdateFeeTierRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateFeeTierRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateFeeTierRequest>(create);
  static UpdateFeeTierRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get feePercentage => $_getN(1);
  @$pb.TagNumber(2)
  set feePercentage($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFeePercentage() => $_has(1);
  @$pb.TagNumber(2)
  void clearFeePercentage() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get isActive => $_getBF(2);
  @$pb.TagNumber(3)
  set isActive($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasIsActive() => $_has(2);
  @$pb.TagNumber(3)
  void clearIsActive() => clearField(3);
}

class UpdateFeeTierResponse extends $pb.GeneratedMessage {
  factory UpdateFeeTierResponse({
    FeeTier? tier,
  }) {
    final $result = create();
    if (tier != null) {
      $result.tier = tier;
    }
    return $result;
  }
  UpdateFeeTierResponse._() : super();
  factory UpdateFeeTierResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateFeeTierResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateFeeTierResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<FeeTier>(1, _omitFieldNames ? '' : 'tier', subBuilder: FeeTier.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateFeeTierResponse clone() => UpdateFeeTierResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateFeeTierResponse copyWith(void Function(UpdateFeeTierResponse) updates) => super.copyWith((message) => updates(message as UpdateFeeTierResponse)) as UpdateFeeTierResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateFeeTierResponse create() => UpdateFeeTierResponse._();
  UpdateFeeTierResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateFeeTierResponse> createRepeated() => $pb.PbList<UpdateFeeTierResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateFeeTierResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateFeeTierResponse>(create);
  static UpdateFeeTierResponse? _defaultInstance;

  @$pb.TagNumber(1)
  FeeTier get tier => $_getN(0);
  @$pb.TagNumber(1)
  set tier(FeeTier v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasTier() => $_has(0);
  @$pb.TagNumber(1)
  void clearTier() => clearField(1);
  @$pb.TagNumber(1)
  FeeTier ensureTier() => $_ensure(0);
}

class DeleteFeeTierRequest extends $pb.GeneratedMessage {
  factory DeleteFeeTierRequest({
    $core.String? id,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    return $result;
  }
  DeleteFeeTierRequest._() : super();
  factory DeleteFeeTierRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteFeeTierRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DeleteFeeTierRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteFeeTierRequest clone() => DeleteFeeTierRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteFeeTierRequest copyWith(void Function(DeleteFeeTierRequest) updates) => super.copyWith((message) => updates(message as DeleteFeeTierRequest)) as DeleteFeeTierRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteFeeTierRequest create() => DeleteFeeTierRequest._();
  DeleteFeeTierRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteFeeTierRequest> createRepeated() => $pb.PbList<DeleteFeeTierRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteFeeTierRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteFeeTierRequest>(create);
  static DeleteFeeTierRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);
}

class DeleteFeeTierResponse extends $pb.GeneratedMessage {
  factory DeleteFeeTierResponse({
    $core.bool? success,
  }) {
    final $result = create();
    if (success != null) {
      $result.success = success;
    }
    return $result;
  }
  DeleteFeeTierResponse._() : super();
  factory DeleteFeeTierResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteFeeTierResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DeleteFeeTierResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteFeeTierResponse clone() => DeleteFeeTierResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteFeeTierResponse copyWith(void Function(DeleteFeeTierResponse) updates) => super.copyWith((message) => updates(message as DeleteFeeTierResponse)) as DeleteFeeTierResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteFeeTierResponse create() => DeleteFeeTierResponse._();
  DeleteFeeTierResponse createEmptyInstance() => create();
  static $pb.PbList<DeleteFeeTierResponse> createRepeated() => $pb.PbList<DeleteFeeTierResponse>();
  @$core.pragma('dart2js:noInline')
  static DeleteFeeTierResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteFeeTierResponse>(create);
  static DeleteFeeTierResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);
}

class RunReconciliationRequest extends $pb.GeneratedMessage {
  factory RunReconciliationRequest({
    $core.String? triggeredBy,
  }) {
    final $result = create();
    if (triggeredBy != null) {
      $result.triggeredBy = triggeredBy;
    }
    return $result;
  }
  RunReconciliationRequest._() : super();
  factory RunReconciliationRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RunReconciliationRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RunReconciliationRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'triggeredBy')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RunReconciliationRequest clone() => RunReconciliationRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RunReconciliationRequest copyWith(void Function(RunReconciliationRequest) updates) => super.copyWith((message) => updates(message as RunReconciliationRequest)) as RunReconciliationRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RunReconciliationRequest create() => RunReconciliationRequest._();
  RunReconciliationRequest createEmptyInstance() => create();
  static $pb.PbList<RunReconciliationRequest> createRepeated() => $pb.PbList<RunReconciliationRequest>();
  @$core.pragma('dart2js:noInline')
  static RunReconciliationRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RunReconciliationRequest>(create);
  static RunReconciliationRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get triggeredBy => $_getSZ(0);
  @$pb.TagNumber(1)
  set triggeredBy($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTriggeredBy() => $_has(0);
  @$pb.TagNumber(1)
  void clearTriggeredBy() => clearField(1);
}

class ReconciliationResult extends $pb.GeneratedMessage {
  factory ReconciliationResult({
    $core.String? id,
    $core.String? date,
    $core.int? expiredHoldsReleased,
    $core.int? stuckTransactionsFound,
    $core.int? failedOutboxCount,
    $core.String? status,
    $1.Timestamp? createdAt,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (date != null) {
      $result.date = date;
    }
    if (expiredHoldsReleased != null) {
      $result.expiredHoldsReleased = expiredHoldsReleased;
    }
    if (stuckTransactionsFound != null) {
      $result.stuckTransactionsFound = stuckTransactionsFound;
    }
    if (failedOutboxCount != null) {
      $result.failedOutboxCount = failedOutboxCount;
    }
    if (status != null) {
      $result.status = status;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    return $result;
  }
  ReconciliationResult._() : super();
  factory ReconciliationResult.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ReconciliationResult.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ReconciliationResult', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'date')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'expiredHoldsReleased', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'stuckTransactionsFound', $pb.PbFieldType.O3)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'failedOutboxCount', $pb.PbFieldType.O3)
    ..aOS(6, _omitFieldNames ? '' : 'status')
    ..aOM<$1.Timestamp>(7, _omitFieldNames ? '' : 'createdAt', subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ReconciliationResult clone() => ReconciliationResult()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ReconciliationResult copyWith(void Function(ReconciliationResult) updates) => super.copyWith((message) => updates(message as ReconciliationResult)) as ReconciliationResult;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ReconciliationResult create() => ReconciliationResult._();
  ReconciliationResult createEmptyInstance() => create();
  static $pb.PbList<ReconciliationResult> createRepeated() => $pb.PbList<ReconciliationResult>();
  @$core.pragma('dart2js:noInline')
  static ReconciliationResult getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ReconciliationResult>(create);
  static ReconciliationResult? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get date => $_getSZ(1);
  @$pb.TagNumber(2)
  set date($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasDate() => $_has(1);
  @$pb.TagNumber(2)
  void clearDate() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get expiredHoldsReleased => $_getIZ(2);
  @$pb.TagNumber(3)
  set expiredHoldsReleased($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasExpiredHoldsReleased() => $_has(2);
  @$pb.TagNumber(3)
  void clearExpiredHoldsReleased() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get stuckTransactionsFound => $_getIZ(3);
  @$pb.TagNumber(4)
  set stuckTransactionsFound($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasStuckTransactionsFound() => $_has(3);
  @$pb.TagNumber(4)
  void clearStuckTransactionsFound() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get failedOutboxCount => $_getIZ(4);
  @$pb.TagNumber(5)
  set failedOutboxCount($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasFailedOutboxCount() => $_has(4);
  @$pb.TagNumber(5)
  void clearFailedOutboxCount() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get status => $_getSZ(5);
  @$pb.TagNumber(6)
  set status($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasStatus() => $_has(5);
  @$pb.TagNumber(6)
  void clearStatus() => clearField(6);

  @$pb.TagNumber(7)
  $1.Timestamp get createdAt => $_getN(6);
  @$pb.TagNumber(7)
  set createdAt($1.Timestamp v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasCreatedAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearCreatedAt() => clearField(7);
  @$pb.TagNumber(7)
  $1.Timestamp ensureCreatedAt() => $_ensure(6);
}

class GetReconciliationLogsRequest extends $pb.GeneratedMessage {
  factory GetReconciliationLogsRequest({
    $core.int? limit,
  }) {
    final $result = create();
    if (limit != null) {
      $result.limit = limit;
    }
    return $result;
  }
  GetReconciliationLogsRequest._() : super();
  factory GetReconciliationLogsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetReconciliationLogsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetReconciliationLogsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetReconciliationLogsRequest clone() => GetReconciliationLogsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetReconciliationLogsRequest copyWith(void Function(GetReconciliationLogsRequest) updates) => super.copyWith((message) => updates(message as GetReconciliationLogsRequest)) as GetReconciliationLogsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetReconciliationLogsRequest create() => GetReconciliationLogsRequest._();
  GetReconciliationLogsRequest createEmptyInstance() => create();
  static $pb.PbList<GetReconciliationLogsRequest> createRepeated() => $pb.PbList<GetReconciliationLogsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetReconciliationLogsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetReconciliationLogsRequest>(create);
  static GetReconciliationLogsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get limit => $_getIZ(0);
  @$pb.TagNumber(1)
  set limit($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLimit() => $_has(0);
  @$pb.TagNumber(1)
  void clearLimit() => clearField(1);
}

class GetReconciliationLogsResponse extends $pb.GeneratedMessage {
  factory GetReconciliationLogsResponse({
    $core.Iterable<ReconciliationResult>? logs,
  }) {
    final $result = create();
    if (logs != null) {
      $result.logs.addAll(logs);
    }
    return $result;
  }
  GetReconciliationLogsResponse._() : super();
  factory GetReconciliationLogsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetReconciliationLogsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetReconciliationLogsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<ReconciliationResult>(1, _omitFieldNames ? '' : 'logs', $pb.PbFieldType.PM, subBuilder: ReconciliationResult.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetReconciliationLogsResponse clone() => GetReconciliationLogsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetReconciliationLogsResponse copyWith(void Function(GetReconciliationLogsResponse) updates) => super.copyWith((message) => updates(message as GetReconciliationLogsResponse)) as GetReconciliationLogsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetReconciliationLogsResponse create() => GetReconciliationLogsResponse._();
  GetReconciliationLogsResponse createEmptyInstance() => create();
  static $pb.PbList<GetReconciliationLogsResponse> createRepeated() => $pb.PbList<GetReconciliationLogsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetReconciliationLogsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetReconciliationLogsResponse>(create);
  static GetReconciliationLogsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<ReconciliationResult> get logs => $_getList(0);
}

class CryptoPaginationInfo extends $pb.GeneratedMessage {
  factory CryptoPaginationInfo({
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
  CryptoPaginationInfo._() : super();
  factory CryptoPaginationInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CryptoPaginationInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CryptoPaginationInfo', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
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
  CryptoPaginationInfo clone() => CryptoPaginationInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CryptoPaginationInfo copyWith(void Function(CryptoPaginationInfo) updates) => super.copyWith((message) => updates(message as CryptoPaginationInfo)) as CryptoPaginationInfo;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CryptoPaginationInfo create() => CryptoPaginationInfo._();
  CryptoPaginationInfo createEmptyInstance() => create();
  static $pb.PbList<CryptoPaginationInfo> createRepeated() => $pb.PbList<CryptoPaginationInfo>();
  @$core.pragma('dart2js:noInline')
  static CryptoPaginationInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CryptoPaginationInfo>(create);
  static CryptoPaginationInfo? _defaultInstance;

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

class GetSupportedAssetsRequest extends $pb.GeneratedMessage {
  factory GetSupportedAssetsRequest({
    $core.String? vsCurrency,
    $core.int? page,
    $core.int? perPage,
  }) {
    final $result = create();
    if (vsCurrency != null) {
      $result.vsCurrency = vsCurrency;
    }
    if (page != null) {
      $result.page = page;
    }
    if (perPage != null) {
      $result.perPage = perPage;
    }
    return $result;
  }
  GetSupportedAssetsRequest._() : super();
  factory GetSupportedAssetsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetSupportedAssetsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetSupportedAssetsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'vsCurrency')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'perPage', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetSupportedAssetsRequest clone() => GetSupportedAssetsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetSupportedAssetsRequest copyWith(void Function(GetSupportedAssetsRequest) updates) => super.copyWith((message) => updates(message as GetSupportedAssetsRequest)) as GetSupportedAssetsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSupportedAssetsRequest create() => GetSupportedAssetsRequest._();
  GetSupportedAssetsRequest createEmptyInstance() => create();
  static $pb.PbList<GetSupportedAssetsRequest> createRepeated() => $pb.PbList<GetSupportedAssetsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetSupportedAssetsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetSupportedAssetsRequest>(create);
  static GetSupportedAssetsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get vsCurrency => $_getSZ(0);
  @$pb.TagNumber(1)
  set vsCurrency($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasVsCurrency() => $_has(0);
  @$pb.TagNumber(1)
  void clearVsCurrency() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get page => $_getIZ(1);
  @$pb.TagNumber(2)
  set page($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPage() => $_has(1);
  @$pb.TagNumber(2)
  void clearPage() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get perPage => $_getIZ(2);
  @$pb.TagNumber(3)
  set perPage($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPerPage() => $_has(2);
  @$pb.TagNumber(3)
  void clearPerPage() => clearField(3);
}

class GetSupportedAssetsResponse extends $pb.GeneratedMessage {
  factory GetSupportedAssetsResponse({
    $core.Iterable<CryptoMessage>? assets,
    CryptoPaginationInfo? pagination,
  }) {
    final $result = create();
    if (assets != null) {
      $result.assets.addAll(assets);
    }
    if (pagination != null) {
      $result.pagination = pagination;
    }
    return $result;
  }
  GetSupportedAssetsResponse._() : super();
  factory GetSupportedAssetsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetSupportedAssetsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetSupportedAssetsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'pb'), createEmptyInstance: create)
    ..pc<CryptoMessage>(1, _omitFieldNames ? '' : 'assets', $pb.PbFieldType.PM, subBuilder: CryptoMessage.create)
    ..aOM<CryptoPaginationInfo>(2, _omitFieldNames ? '' : 'pagination', subBuilder: CryptoPaginationInfo.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetSupportedAssetsResponse clone() => GetSupportedAssetsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetSupportedAssetsResponse copyWith(void Function(GetSupportedAssetsResponse) updates) => super.copyWith((message) => updates(message as GetSupportedAssetsResponse)) as GetSupportedAssetsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSupportedAssetsResponse create() => GetSupportedAssetsResponse._();
  GetSupportedAssetsResponse createEmptyInstance() => create();
  static $pb.PbList<GetSupportedAssetsResponse> createRepeated() => $pb.PbList<GetSupportedAssetsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetSupportedAssetsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetSupportedAssetsResponse>(create);
  static GetSupportedAssetsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<CryptoMessage> get assets => $_getList(0);

  @$pb.TagNumber(2)
  CryptoPaginationInfo get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination(CryptoPaginationInfo v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => clearField(2);
  @$pb.TagNumber(2)
  CryptoPaginationInfo ensurePagination() => $_ensure(1);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
