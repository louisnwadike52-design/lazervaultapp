///
//  Generated code. Do not modify.
//  source: crypto.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $1;

export 'crypto.pbenum.dart';

class CryptoMessage extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CryptoMessage', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'symbol')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'image')
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currentPrice', $pb.PbFieldType.OD)
    ..a<$fixnum.Int64>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'marketCap', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'marketCapRank', $pb.PbFieldType.O3)
    ..a<$fixnum.Int64>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalVolume', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.double>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'high24h', $pb.PbFieldType.OD, protoName: 'high_24h')
    ..a<$core.double>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'low24h', $pb.PbFieldType.OD, protoName: 'low_24h')
    ..a<$core.double>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'priceChange24h', $pb.PbFieldType.OD, protoName: 'price_change_24h')
    ..a<$core.double>(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'priceChangePercentage24h', $pb.PbFieldType.OD, protoName: 'price_change_percentage_24h')
    ..a<$core.double>(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'priceChangePercentage7d', $pb.PbFieldType.OD, protoName: 'price_change_percentage_7d')
    ..a<$core.double>(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'priceChangePercentage30d', $pb.PbFieldType.OD, protoName: 'price_change_percentage_30d')
    ..a<$core.double>(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'priceChangePercentage1y', $pb.PbFieldType.OD, protoName: 'price_change_percentage_1y')
    ..a<$core.double>(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'circulatingSupply', $pb.PbFieldType.OD)
    ..a<$core.double>(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalSupply', $pb.PbFieldType.OD)
    ..a<$core.double>(18, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'maxSupply', $pb.PbFieldType.OD)
    ..a<$core.double>(19, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ath', $pb.PbFieldType.OD)
    ..a<$core.double>(20, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'athChangePercentage', $pb.PbFieldType.OD)
    ..aOM<$1.Timestamp>(21, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'athDate', subBuilder: $1.Timestamp.create)
    ..a<$core.double>(22, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'atl', $pb.PbFieldType.OD)
    ..a<$core.double>(23, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'atlChangePercentage', $pb.PbFieldType.OD)
    ..aOM<$1.Timestamp>(24, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'atlDate', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(25, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lastUpdated', subBuilder: $1.Timestamp.create)
    ..pc<PricePoint>(26, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'priceHistory', $pb.PbFieldType.PM, subBuilder: PricePoint.create)
    ..aOS(27, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..pPS(28, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'categories')
    ..m<$core.String, $core.String>(29, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'links', entryClassName: 'CryptoMessage.LinksEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('pb'))
    ..a<$core.double>(30, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fullyDilutedValuation', $pb.PbFieldType.OD)
    ..a<$core.double>(31, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'marketCapChange24h', $pb.PbFieldType.OD, protoName: 'market_cap_change_24h')
    ..a<$core.double>(32, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'marketCapChangePercentage24h', $pb.PbFieldType.OD, protoName: 'market_cap_change_percentage_24h')
    ..hasRequiredFields = false
  ;

  CryptoMessage._() : super();
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
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (symbol != null) {
      _result.symbol = symbol;
    }
    if (name != null) {
      _result.name = name;
    }
    if (image != null) {
      _result.image = image;
    }
    if (currentPrice != null) {
      _result.currentPrice = currentPrice;
    }
    if (marketCap != null) {
      _result.marketCap = marketCap;
    }
    if (marketCapRank != null) {
      _result.marketCapRank = marketCapRank;
    }
    if (totalVolume != null) {
      _result.totalVolume = totalVolume;
    }
    if (high24h != null) {
      _result.high24h = high24h;
    }
    if (low24h != null) {
      _result.low24h = low24h;
    }
    if (priceChange24h != null) {
      _result.priceChange24h = priceChange24h;
    }
    if (priceChangePercentage24h != null) {
      _result.priceChangePercentage24h = priceChangePercentage24h;
    }
    if (priceChangePercentage7d != null) {
      _result.priceChangePercentage7d = priceChangePercentage7d;
    }
    if (priceChangePercentage30d != null) {
      _result.priceChangePercentage30d = priceChangePercentage30d;
    }
    if (priceChangePercentage1y != null) {
      _result.priceChangePercentage1y = priceChangePercentage1y;
    }
    if (circulatingSupply != null) {
      _result.circulatingSupply = circulatingSupply;
    }
    if (totalSupply != null) {
      _result.totalSupply = totalSupply;
    }
    if (maxSupply != null) {
      _result.maxSupply = maxSupply;
    }
    if (ath != null) {
      _result.ath = ath;
    }
    if (athChangePercentage != null) {
      _result.athChangePercentage = athChangePercentage;
    }
    if (athDate != null) {
      _result.athDate = athDate;
    }
    if (atl != null) {
      _result.atl = atl;
    }
    if (atlChangePercentage != null) {
      _result.atlChangePercentage = atlChangePercentage;
    }
    if (atlDate != null) {
      _result.atlDate = atlDate;
    }
    if (lastUpdated != null) {
      _result.lastUpdated = lastUpdated;
    }
    if (priceHistory != null) {
      _result.priceHistory.addAll(priceHistory);
    }
    if (description != null) {
      _result.description = description;
    }
    if (categories != null) {
      _result.categories.addAll(categories);
    }
    if (links != null) {
      _result.links.addAll(links);
    }
    if (fullyDilutedValuation != null) {
      _result.fullyDilutedValuation = fullyDilutedValuation;
    }
    if (marketCapChange24h != null) {
      _result.marketCapChange24h = marketCapChange24h;
    }
    if (marketCapChangePercentage24h != null) {
      _result.marketCapChangePercentage24h = marketCapChangePercentage24h;
    }
    return _result;
  }
  factory CryptoMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CryptoMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CryptoMessage clone() => CryptoMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CryptoMessage copyWith(void Function(CryptoMessage) updates) => super.copyWith((message) => updates(message as CryptoMessage)) as CryptoMessage; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PricePoint', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<$1.Timestamp>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'timestamp', subBuilder: $1.Timestamp.create)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'price', $pb.PbFieldType.OD)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'volume', $pb.PbFieldType.OD)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'marketCap', $pb.PbFieldType.OD)
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'open', $pb.PbFieldType.OD)
    ..a<$core.double>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'high', $pb.PbFieldType.OD)
    ..a<$core.double>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'low', $pb.PbFieldType.OD)
    ..a<$core.double>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'close', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  PricePoint._() : super();
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
    final _result = create();
    if (timestamp != null) {
      _result.timestamp = timestamp;
    }
    if (price != null) {
      _result.price = price;
    }
    if (volume != null) {
      _result.volume = volume;
    }
    if (marketCap != null) {
      _result.marketCap = marketCap;
    }
    if (open != null) {
      _result.open = open;
    }
    if (high != null) {
      _result.high = high;
    }
    if (low != null) {
      _result.low = low;
    }
    if (close != null) {
      _result.close = close;
    }
    return _result;
  }
  factory PricePoint.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PricePoint.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PricePoint clone() => PricePoint()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PricePoint copyWith(void Function(PricePoint) updates) => super.copyWith((message) => updates(message as PricePoint)) as PricePoint; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetCryptosRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'perPage', $pb.PbFieldType.O3)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'vsCurrency')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'order')
    ..pPS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ids')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'category')
    ..hasRequiredFields = false
  ;

  GetCryptosRequest._() : super();
  factory GetCryptosRequest({
    $core.int? page,
    $core.int? perPage,
    $core.String? vsCurrency,
    $core.String? order,
    $core.Iterable<$core.String>? ids,
    $core.String? category,
  }) {
    final _result = create();
    if (page != null) {
      _result.page = page;
    }
    if (perPage != null) {
      _result.perPage = perPage;
    }
    if (vsCurrency != null) {
      _result.vsCurrency = vsCurrency;
    }
    if (order != null) {
      _result.order = order;
    }
    if (ids != null) {
      _result.ids.addAll(ids);
    }
    if (category != null) {
      _result.category = category;
    }
    return _result;
  }
  factory GetCryptosRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCryptosRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCryptosRequest clone() => GetCryptosRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCryptosRequest copyWith(void Function(GetCryptosRequest) updates) => super.copyWith((message) => updates(message as GetCryptosRequest)) as GetCryptosRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetCryptosResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<CryptoMessage>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cryptos', $pb.PbFieldType.PM, subBuilder: CryptoMessage.create)
    ..aOM<CryptoPaginationInfo>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pagination', subBuilder: CryptoPaginationInfo.create)
    ..hasRequiredFields = false
  ;

  GetCryptosResponse._() : super();
  factory GetCryptosResponse({
    $core.Iterable<CryptoMessage>? cryptos,
    CryptoPaginationInfo? pagination,
  }) {
    final _result = create();
    if (cryptos != null) {
      _result.cryptos.addAll(cryptos);
    }
    if (pagination != null) {
      _result.pagination = pagination;
    }
    return _result;
  }
  factory GetCryptosResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCryptosResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCryptosResponse clone() => GetCryptosResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCryptosResponse copyWith(void Function(GetCryptosResponse) updates) => super.copyWith((message) => updates(message as GetCryptosResponse)) as GetCryptosResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetCryptoByIdRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'includeMarketData')
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'includeCommunityData')
    ..aOB(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'includeDeveloperData')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'vsCurrency')
    ..hasRequiredFields = false
  ;

  GetCryptoByIdRequest._() : super();
  factory GetCryptoByIdRequest({
    $core.String? id,
    $core.bool? includeMarketData,
    $core.bool? includeCommunityData,
    $core.bool? includeDeveloperData,
    $core.String? vsCurrency,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (includeMarketData != null) {
      _result.includeMarketData = includeMarketData;
    }
    if (includeCommunityData != null) {
      _result.includeCommunityData = includeCommunityData;
    }
    if (includeDeveloperData != null) {
      _result.includeDeveloperData = includeDeveloperData;
    }
    if (vsCurrency != null) {
      _result.vsCurrency = vsCurrency;
    }
    return _result;
  }
  factory GetCryptoByIdRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCryptoByIdRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCryptoByIdRequest clone() => GetCryptoByIdRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCryptoByIdRequest copyWith(void Function(GetCryptoByIdRequest) updates) => super.copyWith((message) => updates(message as GetCryptoByIdRequest)) as GetCryptoByIdRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetCryptoByIdResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<CryptoMessage>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'crypto', subBuilder: CryptoMessage.create)
    ..hasRequiredFields = false
  ;

  GetCryptoByIdResponse._() : super();
  factory GetCryptoByIdResponse({
    CryptoMessage? crypto,
  }) {
    final _result = create();
    if (crypto != null) {
      _result.crypto = crypto;
    }
    return _result;
  }
  factory GetCryptoByIdResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCryptoByIdResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCryptoByIdResponse clone() => GetCryptoByIdResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCryptoByIdResponse copyWith(void Function(GetCryptoByIdResponse) updates) => super.copyWith((message) => updates(message as GetCryptoByIdResponse)) as GetCryptoByIdResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SearchCryptosRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'query')
    ..hasRequiredFields = false
  ;

  SearchCryptosRequest._() : super();
  factory SearchCryptosRequest({
    $core.String? query,
  }) {
    final _result = create();
    if (query != null) {
      _result.query = query;
    }
    return _result;
  }
  factory SearchCryptosRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SearchCryptosRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SearchCryptosRequest clone() => SearchCryptosRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SearchCryptosRequest copyWith(void Function(SearchCryptosRequest) updates) => super.copyWith((message) => updates(message as SearchCryptosRequest)) as SearchCryptosRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SearchCryptosResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<CryptoMessage>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cryptos', $pb.PbFieldType.PM, subBuilder: CryptoMessage.create)
    ..hasRequiredFields = false
  ;

  SearchCryptosResponse._() : super();
  factory SearchCryptosResponse({
    $core.Iterable<CryptoMessage>? cryptos,
  }) {
    final _result = create();
    if (cryptos != null) {
      _result.cryptos.addAll(cryptos);
    }
    return _result;
  }
  factory SearchCryptosResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SearchCryptosResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SearchCryptosResponse clone() => SearchCryptosResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SearchCryptosResponse copyWith(void Function(SearchCryptosResponse) updates) => super.copyWith((message) => updates(message as SearchCryptosResponse)) as SearchCryptosResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetCryptoPriceHistoryRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'range')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'vsCurrency')
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'interval', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetCryptoPriceHistoryRequest._() : super();
  factory GetCryptoPriceHistoryRequest({
    $core.String? id,
    $core.String? range,
    $core.String? vsCurrency,
    $core.int? interval,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (range != null) {
      _result.range = range;
    }
    if (vsCurrency != null) {
      _result.vsCurrency = vsCurrency;
    }
    if (interval != null) {
      _result.interval = interval;
    }
    return _result;
  }
  factory GetCryptoPriceHistoryRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCryptoPriceHistoryRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCryptoPriceHistoryRequest clone() => GetCryptoPriceHistoryRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCryptoPriceHistoryRequest copyWith(void Function(GetCryptoPriceHistoryRequest) updates) => super.copyWith((message) => updates(message as GetCryptoPriceHistoryRequest)) as GetCryptoPriceHistoryRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetCryptoPriceHistoryResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<PricePoint>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'priceHistory', $pb.PbFieldType.PM, subBuilder: PricePoint.create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cryptoId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'range')
    ..hasRequiredFields = false
  ;

  GetCryptoPriceHistoryResponse._() : super();
  factory GetCryptoPriceHistoryResponse({
    $core.Iterable<PricePoint>? priceHistory,
    $core.String? cryptoId,
    $core.String? range,
  }) {
    final _result = create();
    if (priceHistory != null) {
      _result.priceHistory.addAll(priceHistory);
    }
    if (cryptoId != null) {
      _result.cryptoId = cryptoId;
    }
    if (range != null) {
      _result.range = range;
    }
    return _result;
  }
  factory GetCryptoPriceHistoryResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCryptoPriceHistoryResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCryptoPriceHistoryResponse clone() => GetCryptoPriceHistoryResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCryptoPriceHistoryResponse copyWith(void Function(GetCryptoPriceHistoryResponse) updates) => super.copyWith((message) => updates(message as GetCryptoPriceHistoryResponse)) as GetCryptoPriceHistoryResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetTrendingCryptosRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetTrendingCryptosRequest._() : super();
  factory GetTrendingCryptosRequest({
    $core.int? limit,
  }) {
    final _result = create();
    if (limit != null) {
      _result.limit = limit;
    }
    return _result;
  }
  factory GetTrendingCryptosRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTrendingCryptosRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetTrendingCryptosRequest clone() => GetTrendingCryptosRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetTrendingCryptosRequest copyWith(void Function(GetTrendingCryptosRequest) updates) => super.copyWith((message) => updates(message as GetTrendingCryptosRequest)) as GetTrendingCryptosRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetTrendingCryptosResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<CryptoMessage>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cryptos', $pb.PbFieldType.PM, subBuilder: CryptoMessage.create)
    ..hasRequiredFields = false
  ;

  GetTrendingCryptosResponse._() : super();
  factory GetTrendingCryptosResponse({
    $core.Iterable<CryptoMessage>? cryptos,
  }) {
    final _result = create();
    if (cryptos != null) {
      _result.cryptos.addAll(cryptos);
    }
    return _result;
  }
  factory GetTrendingCryptosResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTrendingCryptosResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetTrendingCryptosResponse clone() => GetTrendingCryptosResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetTrendingCryptosResponse copyWith(void Function(GetTrendingCryptosResponse) updates) => super.copyWith((message) => updates(message as GetTrendingCryptosResponse)) as GetTrendingCryptosResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetTopCryptosRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'vsCurrency')
    ..hasRequiredFields = false
  ;

  GetTopCryptosRequest._() : super();
  factory GetTopCryptosRequest({
    $core.int? limit,
    $core.String? vsCurrency,
  }) {
    final _result = create();
    if (limit != null) {
      _result.limit = limit;
    }
    if (vsCurrency != null) {
      _result.vsCurrency = vsCurrency;
    }
    return _result;
  }
  factory GetTopCryptosRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTopCryptosRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetTopCryptosRequest clone() => GetTopCryptosRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetTopCryptosRequest copyWith(void Function(GetTopCryptosRequest) updates) => super.copyWith((message) => updates(message as GetTopCryptosRequest)) as GetTopCryptosRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetTopCryptosResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<CryptoMessage>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cryptos', $pb.PbFieldType.PM, subBuilder: CryptoMessage.create)
    ..hasRequiredFields = false
  ;

  GetTopCryptosResponse._() : super();
  factory GetTopCryptosResponse({
    $core.Iterable<CryptoMessage>? cryptos,
  }) {
    final _result = create();
    if (cryptos != null) {
      _result.cryptos.addAll(cryptos);
    }
    return _result;
  }
  factory GetTopCryptosResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTopCryptosResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetTopCryptosResponse clone() => GetTopCryptosResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetTopCryptosResponse copyWith(void Function(GetTopCryptosResponse) updates) => super.copyWith((message) => updates(message as GetTopCryptosResponse)) as GetTopCryptosResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetMarketChartRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'vsCurrency')
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'days', $pb.PbFieldType.O3)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'interval')
    ..hasRequiredFields = false
  ;

  GetMarketChartRequest._() : super();
  factory GetMarketChartRequest({
    $core.String? id,
    $core.String? vsCurrency,
    $core.int? days,
    $core.String? interval,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (vsCurrency != null) {
      _result.vsCurrency = vsCurrency;
    }
    if (days != null) {
      _result.days = days;
    }
    if (interval != null) {
      _result.interval = interval;
    }
    return _result;
  }
  factory GetMarketChartRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMarketChartRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMarketChartRequest clone() => GetMarketChartRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMarketChartRequest copyWith(void Function(GetMarketChartRequest) updates) => super.copyWith((message) => updates(message as GetMarketChartRequest)) as GetMarketChartRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetMarketChartResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<PricePoint>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'prices', $pb.PbFieldType.PM, subBuilder: PricePoint.create)
    ..pc<PricePoint>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'marketCaps', $pb.PbFieldType.PM, subBuilder: PricePoint.create)
    ..pc<PricePoint>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalVolumes', $pb.PbFieldType.PM, subBuilder: PricePoint.create)
    ..hasRequiredFields = false
  ;

  GetMarketChartResponse._() : super();
  factory GetMarketChartResponse({
    $core.Iterable<PricePoint>? prices,
    $core.Iterable<PricePoint>? marketCaps,
    $core.Iterable<PricePoint>? totalVolumes,
  }) {
    final _result = create();
    if (prices != null) {
      _result.prices.addAll(prices);
    }
    if (marketCaps != null) {
      _result.marketCaps.addAll(marketCaps);
    }
    if (totalVolumes != null) {
      _result.totalVolumes.addAll(totalVolumes);
    }
    return _result;
  }
  factory GetMarketChartResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMarketChartResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMarketChartResponse clone() => GetMarketChartResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMarketChartResponse copyWith(void Function(GetMarketChartResponse) updates) => super.copyWith((message) => updates(message as GetMarketChartResponse)) as GetMarketChartResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetGlobalMarketDataRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetGlobalMarketDataRequest._() : super();
  factory GetGlobalMarketDataRequest() => create();
  factory GetGlobalMarketDataRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetGlobalMarketDataRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetGlobalMarketDataRequest clone() => GetGlobalMarketDataRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetGlobalMarketDataRequest copyWith(void Function(GetGlobalMarketDataRequest) updates) => super.copyWith((message) => updates(message as GetGlobalMarketDataRequest)) as GetGlobalMarketDataRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetGlobalMarketDataResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.double>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalMarketCap', $pb.PbFieldType.OD)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalVolume24h', $pb.PbFieldType.OD, protoName: 'total_volume_24h')
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'marketCapPercentageBtc', $pb.PbFieldType.OD)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'marketCapPercentageEth', $pb.PbFieldType.OD)
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'activeCryptocurrencies', $pb.PbFieldType.O3)
    ..a<$core.int>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'markets', $pb.PbFieldType.O3)
    ..aOM<$1.Timestamp>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedAt', subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false
  ;

  GetGlobalMarketDataResponse._() : super();
  factory GetGlobalMarketDataResponse({
    $core.double? totalMarketCap,
    $core.double? totalVolume24h,
    $core.double? marketCapPercentageBtc,
    $core.double? marketCapPercentageEth,
    $core.int? activeCryptocurrencies,
    $core.int? markets,
    $1.Timestamp? updatedAt,
  }) {
    final _result = create();
    if (totalMarketCap != null) {
      _result.totalMarketCap = totalMarketCap;
    }
    if (totalVolume24h != null) {
      _result.totalVolume24h = totalVolume24h;
    }
    if (marketCapPercentageBtc != null) {
      _result.marketCapPercentageBtc = marketCapPercentageBtc;
    }
    if (marketCapPercentageEth != null) {
      _result.marketCapPercentageEth = marketCapPercentageEth;
    }
    if (activeCryptocurrencies != null) {
      _result.activeCryptocurrencies = activeCryptocurrencies;
    }
    if (markets != null) {
      _result.markets = markets;
    }
    if (updatedAt != null) {
      _result.updatedAt = updatedAt;
    }
    return _result;
  }
  factory GetGlobalMarketDataResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetGlobalMarketDataResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetGlobalMarketDataResponse clone() => GetGlobalMarketDataResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetGlobalMarketDataResponse copyWith(void Function(GetGlobalMarketDataResponse) updates) => super.copyWith((message) => updates(message as GetGlobalMarketDataResponse)) as GetGlobalMarketDataResponse; // ignore: deprecated_member_use
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

class CryptoPaginationInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CryptoPaginationInfo', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currentPage', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalPages', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalItems', $pb.PbFieldType.O3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'itemsPerPage', $pb.PbFieldType.O3)
    ..aOB(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hasNext')
    ..aOB(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hasPrev')
    ..hasRequiredFields = false
  ;

  CryptoPaginationInfo._() : super();
  factory CryptoPaginationInfo({
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
  factory CryptoPaginationInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CryptoPaginationInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CryptoPaginationInfo clone() => CryptoPaginationInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CryptoPaginationInfo copyWith(void Function(CryptoPaginationInfo) updates) => super.copyWith((message) => updates(message as CryptoPaginationInfo)) as CryptoPaginationInfo; // ignore: deprecated_member_use
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

