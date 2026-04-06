///
//  Generated code. Do not modify.
//  source: crypto.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $48;

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
    ..aOM<$48.Timestamp>(21, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'athDate', subBuilder: $48.Timestamp.create)
    ..a<$core.double>(22, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'atl', $pb.PbFieldType.OD)
    ..a<$core.double>(23, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'atlChangePercentage', $pb.PbFieldType.OD)
    ..aOM<$48.Timestamp>(24, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'atlDate', subBuilder: $48.Timestamp.create)
    ..aOM<$48.Timestamp>(25, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lastUpdated', subBuilder: $48.Timestamp.create)
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
    $48.Timestamp? athDate,
    $core.double? atl,
    $core.double? atlChangePercentage,
    $48.Timestamp? atlDate,
    $48.Timestamp? lastUpdated,
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
  $48.Timestamp get athDate => $_getN(20);
  @$pb.TagNumber(21)
  set athDate($48.Timestamp v) { setField(21, v); }
  @$pb.TagNumber(21)
  $core.bool hasAthDate() => $_has(20);
  @$pb.TagNumber(21)
  void clearAthDate() => clearField(21);
  @$pb.TagNumber(21)
  $48.Timestamp ensureAthDate() => $_ensure(20);

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
  $48.Timestamp get atlDate => $_getN(23);
  @$pb.TagNumber(24)
  set atlDate($48.Timestamp v) { setField(24, v); }
  @$pb.TagNumber(24)
  $core.bool hasAtlDate() => $_has(23);
  @$pb.TagNumber(24)
  void clearAtlDate() => clearField(24);
  @$pb.TagNumber(24)
  $48.Timestamp ensureAtlDate() => $_ensure(23);

  @$pb.TagNumber(25)
  $48.Timestamp get lastUpdated => $_getN(24);
  @$pb.TagNumber(25)
  set lastUpdated($48.Timestamp v) { setField(25, v); }
  @$pb.TagNumber(25)
  $core.bool hasLastUpdated() => $_has(24);
  @$pb.TagNumber(25)
  void clearLastUpdated() => clearField(25);
  @$pb.TagNumber(25)
  $48.Timestamp ensureLastUpdated() => $_ensure(24);

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
    ..aOM<$48.Timestamp>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'timestamp', subBuilder: $48.Timestamp.create)
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
    $48.Timestamp? timestamp,
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
  $48.Timestamp get timestamp => $_getN(0);
  @$pb.TagNumber(1)
  set timestamp($48.Timestamp v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasTimestamp() => $_has(0);
  @$pb.TagNumber(1)
  void clearTimestamp() => clearField(1);
  @$pb.TagNumber(1)
  $48.Timestamp ensureTimestamp() => $_ensure(0);

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
    ..aOM<$48.Timestamp>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedAt', subBuilder: $48.Timestamp.create)
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
    $48.Timestamp? updatedAt,
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
  $48.Timestamp get updatedAt => $_getN(6);
  @$pb.TagNumber(7)
  set updatedAt($48.Timestamp v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasUpdatedAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearUpdatedAt() => clearField(7);
  @$pb.TagNumber(7)
  $48.Timestamp ensureUpdatedAt() => $_ensure(6);
}

class GetCryptoFiatRateRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetCryptoFiatRateRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cryptoId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fiatCurrency')
    ..hasRequiredFields = false
  ;

  GetCryptoFiatRateRequest._() : super();
  factory GetCryptoFiatRateRequest({
    $core.String? cryptoId,
    $core.String? fiatCurrency,
  }) {
    final _result = create();
    if (cryptoId != null) {
      _result.cryptoId = cryptoId;
    }
    if (fiatCurrency != null) {
      _result.fiatCurrency = fiatCurrency;
    }
    return _result;
  }
  factory GetCryptoFiatRateRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCryptoFiatRateRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCryptoFiatRateRequest clone() => GetCryptoFiatRateRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCryptoFiatRateRequest copyWith(void Function(GetCryptoFiatRateRequest) updates) => super.copyWith((message) => updates(message as GetCryptoFiatRateRequest)) as GetCryptoFiatRateRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetCryptoFiatRateResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cryptoId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fiatCurrency')
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'rate', $pb.PbFieldType.OD)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'feePercentage', $pb.PbFieldType.OD)
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'spread', $pb.PbFieldType.OD)
    ..aOM<$48.Timestamp>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'validUntil', subBuilder: $48.Timestamp.create)
    ..hasRequiredFields = false
  ;

  GetCryptoFiatRateResponse._() : super();
  factory GetCryptoFiatRateResponse({
    $core.String? cryptoId,
    $core.String? fiatCurrency,
    $core.double? rate,
    $core.double? feePercentage,
    $core.double? spread,
    $48.Timestamp? validUntil,
  }) {
    final _result = create();
    if (cryptoId != null) {
      _result.cryptoId = cryptoId;
    }
    if (fiatCurrency != null) {
      _result.fiatCurrency = fiatCurrency;
    }
    if (rate != null) {
      _result.rate = rate;
    }
    if (feePercentage != null) {
      _result.feePercentage = feePercentage;
    }
    if (spread != null) {
      _result.spread = spread;
    }
    if (validUntil != null) {
      _result.validUntil = validUntil;
    }
    return _result;
  }
  factory GetCryptoFiatRateResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCryptoFiatRateResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCryptoFiatRateResponse clone() => GetCryptoFiatRateResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCryptoFiatRateResponse copyWith(void Function(GetCryptoFiatRateResponse) updates) => super.copyWith((message) => updates(message as GetCryptoFiatRateResponse)) as GetCryptoFiatRateResponse; // ignore: deprecated_member_use
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
  $48.Timestamp get validUntil => $_getN(5);
  @$pb.TagNumber(6)
  set validUntil($48.Timestamp v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasValidUntil() => $_has(5);
  @$pb.TagNumber(6)
  void clearValidUntil() => clearField(6);
  @$pb.TagNumber(6)
  $48.Timestamp ensureValidUntil() => $_ensure(5);
}

class GetCryptoHoldingsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetCryptoHoldingsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..hasRequiredFields = false
  ;

  GetCryptoHoldingsRequest._() : super();
  factory GetCryptoHoldingsRequest({
    $core.String? userId,
  }) {
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    return _result;
  }
  factory GetCryptoHoldingsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCryptoHoldingsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCryptoHoldingsRequest clone() => GetCryptoHoldingsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCryptoHoldingsRequest copyWith(void Function(GetCryptoHoldingsRequest) updates) => super.copyWith((message) => updates(message as GetCryptoHoldingsRequest)) as GetCryptoHoldingsRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetCryptoHolding', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cryptoId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'symbol')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'balance', $pb.PbFieldType.OD)
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fiatValue', $pb.PbFieldType.OD)
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fiatCurrency')
    ..aOM<$48.Timestamp>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'acquiredAt', subBuilder: $48.Timestamp.create)
    ..hasRequiredFields = false
  ;

  GetCryptoHolding._() : super();
  factory GetCryptoHolding({
    $core.String? cryptoId,
    $core.String? symbol,
    $core.String? name,
    $core.double? balance,
    $core.double? fiatValue,
    $core.String? fiatCurrency,
    $48.Timestamp? acquiredAt,
  }) {
    final _result = create();
    if (cryptoId != null) {
      _result.cryptoId = cryptoId;
    }
    if (symbol != null) {
      _result.symbol = symbol;
    }
    if (name != null) {
      _result.name = name;
    }
    if (balance != null) {
      _result.balance = balance;
    }
    if (fiatValue != null) {
      _result.fiatValue = fiatValue;
    }
    if (fiatCurrency != null) {
      _result.fiatCurrency = fiatCurrency;
    }
    if (acquiredAt != null) {
      _result.acquiredAt = acquiredAt;
    }
    return _result;
  }
  factory GetCryptoHolding.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCryptoHolding.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCryptoHolding clone() => GetCryptoHolding()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCryptoHolding copyWith(void Function(GetCryptoHolding) updates) => super.copyWith((message) => updates(message as GetCryptoHolding)) as GetCryptoHolding; // ignore: deprecated_member_use
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
  $48.Timestamp get acquiredAt => $_getN(6);
  @$pb.TagNumber(7)
  set acquiredAt($48.Timestamp v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasAcquiredAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearAcquiredAt() => clearField(7);
  @$pb.TagNumber(7)
  $48.Timestamp ensureAcquiredAt() => $_ensure(6);
}

class GetCryptoHoldingsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetCryptoHoldingsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<GetCryptoHolding>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'holdings', $pb.PbFieldType.PM, subBuilder: GetCryptoHolding.create)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalFiatValue', $pb.PbFieldType.OD)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fiatCurrency')
    ..hasRequiredFields = false
  ;

  GetCryptoHoldingsResponse._() : super();
  factory GetCryptoHoldingsResponse({
    $core.Iterable<GetCryptoHolding>? holdings,
    $core.double? totalFiatValue,
    $core.String? fiatCurrency,
  }) {
    final _result = create();
    if (holdings != null) {
      _result.holdings.addAll(holdings);
    }
    if (totalFiatValue != null) {
      _result.totalFiatValue = totalFiatValue;
    }
    if (fiatCurrency != null) {
      _result.fiatCurrency = fiatCurrency;
    }
    return _result;
  }
  factory GetCryptoHoldingsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCryptoHoldingsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCryptoHoldingsResponse clone() => GetCryptoHoldingsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCryptoHoldingsResponse copyWith(void Function(GetCryptoHoldingsResponse) updates) => super.copyWith((message) => updates(message as GetCryptoHoldingsResponse)) as GetCryptoHoldingsResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetCryptoTransactionsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetCryptoTransactionsRequest._() : super();
  factory GetCryptoTransactionsRequest({
    $core.String? userId,
    $core.int? limit,
    $core.int? offset,
  }) {
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    if (limit != null) {
      _result.limit = limit;
    }
    if (offset != null) {
      _result.offset = offset;
    }
    return _result;
  }
  factory GetCryptoTransactionsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCryptoTransactionsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCryptoTransactionsRequest clone() => GetCryptoTransactionsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCryptoTransactionsRequest copyWith(void Function(GetCryptoTransactionsRequest) updates) => super.copyWith((message) => updates(message as GetCryptoTransactionsRequest)) as GetCryptoTransactionsRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CryptoTransaction', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cryptoId')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cryptoSymbol')
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..a<$core.double>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fiatValue', $pb.PbFieldType.OD)
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fiatCurrency')
    ..aOM<$48.Timestamp>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'timestamp', subBuilder: $48.Timestamp.create)
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..a<$core.double>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fee', $pb.PbFieldType.OD)
    ..a<$core.double>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'exchangeRate', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  CryptoTransaction._() : super();
  factory CryptoTransaction({
    $core.String? id,
    $core.String? type,
    $core.String? cryptoId,
    $core.String? cryptoSymbol,
    $core.double? amount,
    $core.double? fiatValue,
    $core.String? fiatCurrency,
    $48.Timestamp? timestamp,
    $core.String? status,
    $core.double? fee,
    $core.double? exchangeRate,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (type != null) {
      _result.type = type;
    }
    if (cryptoId != null) {
      _result.cryptoId = cryptoId;
    }
    if (cryptoSymbol != null) {
      _result.cryptoSymbol = cryptoSymbol;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (fiatValue != null) {
      _result.fiatValue = fiatValue;
    }
    if (fiatCurrency != null) {
      _result.fiatCurrency = fiatCurrency;
    }
    if (timestamp != null) {
      _result.timestamp = timestamp;
    }
    if (status != null) {
      _result.status = status;
    }
    if (fee != null) {
      _result.fee = fee;
    }
    if (exchangeRate != null) {
      _result.exchangeRate = exchangeRate;
    }
    return _result;
  }
  factory CryptoTransaction.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CryptoTransaction.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CryptoTransaction clone() => CryptoTransaction()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CryptoTransaction copyWith(void Function(CryptoTransaction) updates) => super.copyWith((message) => updates(message as CryptoTransaction)) as CryptoTransaction; // ignore: deprecated_member_use
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
  $48.Timestamp get timestamp => $_getN(7);
  @$pb.TagNumber(8)
  set timestamp($48.Timestamp v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasTimestamp() => $_has(7);
  @$pb.TagNumber(8)
  void clearTimestamp() => clearField(8);
  @$pb.TagNumber(8)
  $48.Timestamp ensureTimestamp() => $_ensure(7);

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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetCryptoTransactionsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<CryptoTransaction>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactions', $pb.PbFieldType.PM, subBuilder: CryptoTransaction.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalCount', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetCryptoTransactionsResponse._() : super();
  factory GetCryptoTransactionsResponse({
    $core.Iterable<CryptoTransaction>? transactions,
    $core.int? totalCount,
  }) {
    final _result = create();
    if (transactions != null) {
      _result.transactions.addAll(transactions);
    }
    if (totalCount != null) {
      _result.totalCount = totalCount;
    }
    return _result;
  }
  factory GetCryptoTransactionsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCryptoTransactionsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCryptoTransactionsResponse clone() => GetCryptoTransactionsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCryptoTransactionsResponse copyWith(void Function(GetCryptoTransactionsResponse) updates) => super.copyWith((message) => updates(message as GetCryptoTransactionsResponse)) as GetCryptoTransactionsResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'BuyCryptoRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cryptoId')
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fiatAmount', $pb.PbFieldType.OD)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fiatCurrency')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionPin')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'idempotencyKey')
    ..hasRequiredFields = false
  ;

  BuyCryptoRequest._() : super();
  factory BuyCryptoRequest({
    $core.String? userId,
    $core.String? cryptoId,
    $core.double? fiatAmount,
    $core.String? fiatCurrency,
    $core.String? transactionPin,
    $core.String? idempotencyKey,
  }) {
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    if (cryptoId != null) {
      _result.cryptoId = cryptoId;
    }
    if (fiatAmount != null) {
      _result.fiatAmount = fiatAmount;
    }
    if (fiatCurrency != null) {
      _result.fiatCurrency = fiatCurrency;
    }
    if (transactionPin != null) {
      _result.transactionPin = transactionPin;
    }
    if (idempotencyKey != null) {
      _result.idempotencyKey = idempotencyKey;
    }
    return _result;
  }
  factory BuyCryptoRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BuyCryptoRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BuyCryptoRequest clone() => BuyCryptoRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BuyCryptoRequest copyWith(void Function(BuyCryptoRequest) updates) => super.copyWith((message) => updates(message as BuyCryptoRequest)) as BuyCryptoRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'BuyCryptoResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cryptoId')
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cryptoAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fiatAmount', $pb.PbFieldType.OD)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..a<$core.double>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fee', $pb.PbFieldType.OD)
    ..a<$core.double>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'exchangeRate', $pb.PbFieldType.OD)
    ..a<$core.double>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'netAmount', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  BuyCryptoResponse._() : super();
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
    final _result = create();
    if (transactionId != null) {
      _result.transactionId = transactionId;
    }
    if (cryptoId != null) {
      _result.cryptoId = cryptoId;
    }
    if (cryptoAmount != null) {
      _result.cryptoAmount = cryptoAmount;
    }
    if (fiatAmount != null) {
      _result.fiatAmount = fiatAmount;
    }
    if (status != null) {
      _result.status = status;
    }
    if (fee != null) {
      _result.fee = fee;
    }
    if (exchangeRate != null) {
      _result.exchangeRate = exchangeRate;
    }
    if (netAmount != null) {
      _result.netAmount = netAmount;
    }
    return _result;
  }
  factory BuyCryptoResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BuyCryptoResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BuyCryptoResponse clone() => BuyCryptoResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BuyCryptoResponse copyWith(void Function(BuyCryptoResponse) updates) => super.copyWith((message) => updates(message as BuyCryptoResponse)) as BuyCryptoResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SellCryptoRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cryptoId')
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cryptoAmount', $pb.PbFieldType.OD)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fiatCurrency')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionPin')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'idempotencyKey')
    ..hasRequiredFields = false
  ;

  SellCryptoRequest._() : super();
  factory SellCryptoRequest({
    $core.String? userId,
    $core.String? cryptoId,
    $core.double? cryptoAmount,
    $core.String? fiatCurrency,
    $core.String? transactionPin,
    $core.String? idempotencyKey,
  }) {
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    if (cryptoId != null) {
      _result.cryptoId = cryptoId;
    }
    if (cryptoAmount != null) {
      _result.cryptoAmount = cryptoAmount;
    }
    if (fiatCurrency != null) {
      _result.fiatCurrency = fiatCurrency;
    }
    if (transactionPin != null) {
      _result.transactionPin = transactionPin;
    }
    if (idempotencyKey != null) {
      _result.idempotencyKey = idempotencyKey;
    }
    return _result;
  }
  factory SellCryptoRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SellCryptoRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SellCryptoRequest clone() => SellCryptoRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SellCryptoRequest copyWith(void Function(SellCryptoRequest) updates) => super.copyWith((message) => updates(message as SellCryptoRequest)) as SellCryptoRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SellCryptoResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cryptoId')
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fiatAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cryptoAmount', $pb.PbFieldType.OD)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..a<$core.double>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fee', $pb.PbFieldType.OD)
    ..a<$core.double>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'exchangeRate', $pb.PbFieldType.OD)
    ..a<$core.double>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'netAmount', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  SellCryptoResponse._() : super();
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
    final _result = create();
    if (transactionId != null) {
      _result.transactionId = transactionId;
    }
    if (cryptoId != null) {
      _result.cryptoId = cryptoId;
    }
    if (fiatAmount != null) {
      _result.fiatAmount = fiatAmount;
    }
    if (cryptoAmount != null) {
      _result.cryptoAmount = cryptoAmount;
    }
    if (status != null) {
      _result.status = status;
    }
    if (fee != null) {
      _result.fee = fee;
    }
    if (exchangeRate != null) {
      _result.exchangeRate = exchangeRate;
    }
    if (netAmount != null) {
      _result.netAmount = netAmount;
    }
    return _result;
  }
  factory SellCryptoResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SellCryptoResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SellCryptoResponse clone() => SellCryptoResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SellCryptoResponse copyWith(void Function(SellCryptoResponse) updates) => super.copyWith((message) => updates(message as SellCryptoResponse)) as SellCryptoResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ConvertCryptoRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fromCryptoId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'toCryptoId')
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fromAmount', $pb.PbFieldType.OD)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionPin')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'idempotencyKey')
    ..hasRequiredFields = false
  ;

  ConvertCryptoRequest._() : super();
  factory ConvertCryptoRequest({
    $core.String? userId,
    $core.String? fromCryptoId,
    $core.String? toCryptoId,
    $core.double? fromAmount,
    $core.String? transactionPin,
    $core.String? idempotencyKey,
  }) {
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    if (fromCryptoId != null) {
      _result.fromCryptoId = fromCryptoId;
    }
    if (toCryptoId != null) {
      _result.toCryptoId = toCryptoId;
    }
    if (fromAmount != null) {
      _result.fromAmount = fromAmount;
    }
    if (transactionPin != null) {
      _result.transactionPin = transactionPin;
    }
    if (idempotencyKey != null) {
      _result.idempotencyKey = idempotencyKey;
    }
    return _result;
  }
  factory ConvertCryptoRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ConvertCryptoRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ConvertCryptoRequest clone() => ConvertCryptoRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ConvertCryptoRequest copyWith(void Function(ConvertCryptoRequest) updates) => super.copyWith((message) => updates(message as ConvertCryptoRequest)) as ConvertCryptoRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ConvertCryptoResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionId')
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'toAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'rate', $pb.PbFieldType.OD)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fee', $pb.PbFieldType.OD)
    ..a<$core.double>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fromAmount', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  ConvertCryptoResponse._() : super();
  factory ConvertCryptoResponse({
    $core.String? transactionId,
    $core.double? toAmount,
    $core.double? rate,
    $core.String? status,
    $core.double? fee,
    $core.double? fromAmount,
  }) {
    final _result = create();
    if (transactionId != null) {
      _result.transactionId = transactionId;
    }
    if (toAmount != null) {
      _result.toAmount = toAmount;
    }
    if (rate != null) {
      _result.rate = rate;
    }
    if (status != null) {
      _result.status = status;
    }
    if (fee != null) {
      _result.fee = fee;
    }
    if (fromAmount != null) {
      _result.fromAmount = fromAmount;
    }
    return _result;
  }
  factory ConvertCryptoResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ConvertCryptoResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ConvertCryptoResponse clone() => ConvertCryptoResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ConvertCryptoResponse copyWith(void Function(ConvertCryptoResponse) updates) => super.copyWith((message) => updates(message as ConvertCryptoResponse)) as ConvertCryptoResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetWalletsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..hasRequiredFields = false
  ;

  GetWalletsRequest._() : super();
  factory GetWalletsRequest({
    $core.String? userId,
  }) {
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    return _result;
  }
  factory GetWalletsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetWalletsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetWalletsRequest clone() => GetWalletsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetWalletsRequest copyWith(void Function(GetWalletsRequest) updates) => super.copyWith((message) => updates(message as GetWalletsRequest)) as GetWalletsRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CryptoWallet', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cryptoId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cryptoSymbol')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'address')
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'balance', $pb.PbFieldType.OD)
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'walletType')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'chain')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cryptoName')
    ..hasRequiredFields = false
  ;

  CryptoWallet._() : super();
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
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (cryptoId != null) {
      _result.cryptoId = cryptoId;
    }
    if (cryptoSymbol != null) {
      _result.cryptoSymbol = cryptoSymbol;
    }
    if (address != null) {
      _result.address = address;
    }
    if (balance != null) {
      _result.balance = balance;
    }
    if (walletType != null) {
      _result.walletType = walletType;
    }
    if (chain != null) {
      _result.chain = chain;
    }
    if (cryptoName != null) {
      _result.cryptoName = cryptoName;
    }
    return _result;
  }
  factory CryptoWallet.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CryptoWallet.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CryptoWallet clone() => CryptoWallet()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CryptoWallet copyWith(void Function(CryptoWallet) updates) => super.copyWith((message) => updates(message as CryptoWallet)) as CryptoWallet; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetWalletsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<CryptoWallet>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'wallets', $pb.PbFieldType.PM, subBuilder: CryptoWallet.create)
    ..hasRequiredFields = false
  ;

  GetWalletsResponse._() : super();
  factory GetWalletsResponse({
    $core.Iterable<CryptoWallet>? wallets,
  }) {
    final _result = create();
    if (wallets != null) {
      _result.wallets.addAll(wallets);
    }
    return _result;
  }
  factory GetWalletsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetWalletsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetWalletsResponse clone() => GetWalletsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetWalletsResponse copyWith(void Function(GetWalletsResponse) updates) => super.copyWith((message) => updates(message as GetWalletsResponse)) as GetWalletsResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateWalletRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cryptoId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'walletType')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'chain')
    ..hasRequiredFields = false
  ;

  CreateWalletRequest._() : super();
  factory CreateWalletRequest({
    $core.String? userId,
    $core.String? cryptoId,
    $core.String? walletType,
    $core.String? chain,
  }) {
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    if (cryptoId != null) {
      _result.cryptoId = cryptoId;
    }
    if (walletType != null) {
      _result.walletType = walletType;
    }
    if (chain != null) {
      _result.chain = chain;
    }
    return _result;
  }
  factory CreateWalletRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateWalletRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateWalletRequest clone() => CreateWalletRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateWalletRequest copyWith(void Function(CreateWalletRequest) updates) => super.copyWith((message) => updates(message as CreateWalletRequest)) as CreateWalletRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateWalletResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'walletId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'address')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cryptoId')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'chain')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cryptoName')
    ..hasRequiredFields = false
  ;

  CreateWalletResponse._() : super();
  factory CreateWalletResponse({
    $core.String? walletId,
    $core.String? address,
    $core.String? cryptoId,
    $core.String? status,
    $core.String? chain,
    $core.String? cryptoName,
  }) {
    final _result = create();
    if (walletId != null) {
      _result.walletId = walletId;
    }
    if (address != null) {
      _result.address = address;
    }
    if (cryptoId != null) {
      _result.cryptoId = cryptoId;
    }
    if (status != null) {
      _result.status = status;
    }
    if (chain != null) {
      _result.chain = chain;
    }
    if (cryptoName != null) {
      _result.cryptoName = cryptoName;
    }
    return _result;
  }
  factory CreateWalletResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateWalletResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateWalletResponse clone() => CreateWalletResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateWalletResponse copyWith(void Function(CreateWalletResponse) updates) => super.copyWith((message) => updates(message as CreateWalletResponse)) as CreateWalletResponse; // ignore: deprecated_member_use
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

class BatchCreateWalletsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'BatchCreateWalletsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..hasRequiredFields = false
  ;

  BatchCreateWalletsRequest._() : super();
  factory BatchCreateWalletsRequest({
    $core.String? userId,
  }) {
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    return _result;
  }
  factory BatchCreateWalletsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BatchCreateWalletsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BatchCreateWalletsRequest clone() => BatchCreateWalletsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BatchCreateWalletsRequest copyWith(void Function(BatchCreateWalletsRequest) updates) => super.copyWith((message) => updates(message as BatchCreateWalletsRequest)) as BatchCreateWalletsRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'BatchCreateWalletsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<CryptoWallet>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'wallets', $pb.PbFieldType.PM, subBuilder: CryptoWallet.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdCount', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'failedCount', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  BatchCreateWalletsResponse._() : super();
  factory BatchCreateWalletsResponse({
    $core.Iterable<CryptoWallet>? wallets,
    $core.int? createdCount,
    $core.int? failedCount,
  }) {
    final _result = create();
    if (wallets != null) {
      _result.wallets.addAll(wallets);
    }
    if (createdCount != null) {
      _result.createdCount = createdCount;
    }
    if (failedCount != null) {
      _result.failedCount = failedCount;
    }
    return _result;
  }
  factory BatchCreateWalletsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BatchCreateWalletsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BatchCreateWalletsResponse clone() => BatchCreateWalletsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BatchCreateWalletsResponse copyWith(void Function(BatchCreateWalletsResponse) updates) => super.copyWith((message) => updates(message as BatchCreateWalletsResponse)) as BatchCreateWalletsResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetWalletBalanceRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'walletId')
    ..hasRequiredFields = false
  ;

  GetWalletBalanceRequest._() : super();
  factory GetWalletBalanceRequest({
    $core.String? walletId,
  }) {
    final _result = create();
    if (walletId != null) {
      _result.walletId = walletId;
    }
    return _result;
  }
  factory GetWalletBalanceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetWalletBalanceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetWalletBalanceRequest clone() => GetWalletBalanceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetWalletBalanceRequest copyWith(void Function(GetWalletBalanceRequest) updates) => super.copyWith((message) => updates(message as GetWalletBalanceRequest)) as GetWalletBalanceRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetWalletBalanceResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'walletId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cryptoId')
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'balance', $pb.PbFieldType.OD)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fiatValue', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  GetWalletBalanceResponse._() : super();
  factory GetWalletBalanceResponse({
    $core.String? walletId,
    $core.String? cryptoId,
    $core.double? balance,
    $core.double? fiatValue,
  }) {
    final _result = create();
    if (walletId != null) {
      _result.walletId = walletId;
    }
    if (cryptoId != null) {
      _result.cryptoId = cryptoId;
    }
    if (balance != null) {
      _result.balance = balance;
    }
    if (fiatValue != null) {
      _result.fiatValue = fiatValue;
    }
    return _result;
  }
  factory GetWalletBalanceResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetWalletBalanceResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetWalletBalanceResponse clone() => GetWalletBalanceResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetWalletBalanceResponse copyWith(void Function(GetWalletBalanceResponse) updates) => super.copyWith((message) => updates(message as GetWalletBalanceResponse)) as GetWalletBalanceResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CryptoWatchlistProto', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..pPS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cryptoIds')
    ..aOM<$48.Timestamp>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $48.Timestamp.create)
    ..aOM<$48.Timestamp>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedAt', subBuilder: $48.Timestamp.create)
    ..hasRequiredFields = false
  ;

  CryptoWatchlistProto._() : super();
  factory CryptoWatchlistProto({
    $core.String? id,
    $core.String? name,
    $core.String? description,
    $core.Iterable<$core.String>? cryptoIds,
    $48.Timestamp? createdAt,
    $48.Timestamp? updatedAt,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (name != null) {
      _result.name = name;
    }
    if (description != null) {
      _result.description = description;
    }
    if (cryptoIds != null) {
      _result.cryptoIds.addAll(cryptoIds);
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      _result.updatedAt = updatedAt;
    }
    return _result;
  }
  factory CryptoWatchlistProto.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CryptoWatchlistProto.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CryptoWatchlistProto clone() => CryptoWatchlistProto()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CryptoWatchlistProto copyWith(void Function(CryptoWatchlistProto) updates) => super.copyWith((message) => updates(message as CryptoWatchlistProto)) as CryptoWatchlistProto; // ignore: deprecated_member_use
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
  $48.Timestamp get createdAt => $_getN(4);
  @$pb.TagNumber(5)
  set createdAt($48.Timestamp v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasCreatedAt() => $_has(4);
  @$pb.TagNumber(5)
  void clearCreatedAt() => clearField(5);
  @$pb.TagNumber(5)
  $48.Timestamp ensureCreatedAt() => $_ensure(4);

  @$pb.TagNumber(6)
  $48.Timestamp get updatedAt => $_getN(5);
  @$pb.TagNumber(6)
  set updatedAt($48.Timestamp v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasUpdatedAt() => $_has(5);
  @$pb.TagNumber(6)
  void clearUpdatedAt() => clearField(6);
  @$pb.TagNumber(6)
  $48.Timestamp ensureUpdatedAt() => $_ensure(5);
}

class CreateWatchlistRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateWatchlistRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..hasRequiredFields = false
  ;

  CreateWatchlistRequest._() : super();
  factory CreateWatchlistRequest({
    $core.String? name,
    $core.String? description,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    if (description != null) {
      _result.description = description;
    }
    return _result;
  }
  factory CreateWatchlistRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateWatchlistRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateWatchlistRequest clone() => CreateWatchlistRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateWatchlistRequest copyWith(void Function(CreateWatchlistRequest) updates) => super.copyWith((message) => updates(message as CreateWatchlistRequest)) as CreateWatchlistRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateWatchlistResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<CryptoWatchlistProto>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'watchlist', subBuilder: CryptoWatchlistProto.create)
    ..hasRequiredFields = false
  ;

  CreateWatchlistResponse._() : super();
  factory CreateWatchlistResponse({
    CryptoWatchlistProto? watchlist,
  }) {
    final _result = create();
    if (watchlist != null) {
      _result.watchlist = watchlist;
    }
    return _result;
  }
  factory CreateWatchlistResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateWatchlistResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateWatchlistResponse clone() => CreateWatchlistResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateWatchlistResponse copyWith(void Function(CreateWatchlistResponse) updates) => super.copyWith((message) => updates(message as CreateWatchlistResponse)) as CreateWatchlistResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetWatchlistsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetWatchlistsRequest._() : super();
  factory GetWatchlistsRequest() => create();
  factory GetWatchlistsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetWatchlistsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetWatchlistsRequest clone() => GetWatchlistsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetWatchlistsRequest copyWith(void Function(GetWatchlistsRequest) updates) => super.copyWith((message) => updates(message as GetWatchlistsRequest)) as GetWatchlistsRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetWatchlistsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<CryptoWatchlistProto>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'watchlists', $pb.PbFieldType.PM, subBuilder: CryptoWatchlistProto.create)
    ..hasRequiredFields = false
  ;

  GetWatchlistsResponse._() : super();
  factory GetWatchlistsResponse({
    $core.Iterable<CryptoWatchlistProto>? watchlists,
  }) {
    final _result = create();
    if (watchlists != null) {
      _result.watchlists.addAll(watchlists);
    }
    return _result;
  }
  factory GetWatchlistsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetWatchlistsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetWatchlistsResponse clone() => GetWatchlistsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetWatchlistsResponse copyWith(void Function(GetWatchlistsResponse) updates) => super.copyWith((message) => updates(message as GetWatchlistsResponse)) as GetWatchlistsResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AddToWatchlistRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'watchlistId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cryptoId')
    ..hasRequiredFields = false
  ;

  AddToWatchlistRequest._() : super();
  factory AddToWatchlistRequest({
    $core.String? watchlistId,
    $core.String? cryptoId,
  }) {
    final _result = create();
    if (watchlistId != null) {
      _result.watchlistId = watchlistId;
    }
    if (cryptoId != null) {
      _result.cryptoId = cryptoId;
    }
    return _result;
  }
  factory AddToWatchlistRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddToWatchlistRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddToWatchlistRequest clone() => AddToWatchlistRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddToWatchlistRequest copyWith(void Function(AddToWatchlistRequest) updates) => super.copyWith((message) => updates(message as AddToWatchlistRequest)) as AddToWatchlistRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AddToWatchlistResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<CryptoWatchlistProto>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'watchlist', subBuilder: CryptoWatchlistProto.create)
    ..hasRequiredFields = false
  ;

  AddToWatchlistResponse._() : super();
  factory AddToWatchlistResponse({
    CryptoWatchlistProto? watchlist,
  }) {
    final _result = create();
    if (watchlist != null) {
      _result.watchlist = watchlist;
    }
    return _result;
  }
  factory AddToWatchlistResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddToWatchlistResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddToWatchlistResponse clone() => AddToWatchlistResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddToWatchlistResponse copyWith(void Function(AddToWatchlistResponse) updates) => super.copyWith((message) => updates(message as AddToWatchlistResponse)) as AddToWatchlistResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RemoveFromWatchlistRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'watchlistId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cryptoId')
    ..hasRequiredFields = false
  ;

  RemoveFromWatchlistRequest._() : super();
  factory RemoveFromWatchlistRequest({
    $core.String? watchlistId,
    $core.String? cryptoId,
  }) {
    final _result = create();
    if (watchlistId != null) {
      _result.watchlistId = watchlistId;
    }
    if (cryptoId != null) {
      _result.cryptoId = cryptoId;
    }
    return _result;
  }
  factory RemoveFromWatchlistRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RemoveFromWatchlistRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RemoveFromWatchlistRequest clone() => RemoveFromWatchlistRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RemoveFromWatchlistRequest copyWith(void Function(RemoveFromWatchlistRequest) updates) => super.copyWith((message) => updates(message as RemoveFromWatchlistRequest)) as RemoveFromWatchlistRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RemoveFromWatchlistResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<CryptoWatchlistProto>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'watchlist', subBuilder: CryptoWatchlistProto.create)
    ..hasRequiredFields = false
  ;

  RemoveFromWatchlistResponse._() : super();
  factory RemoveFromWatchlistResponse({
    CryptoWatchlistProto? watchlist,
  }) {
    final _result = create();
    if (watchlist != null) {
      _result.watchlist = watchlist;
    }
    return _result;
  }
  factory RemoveFromWatchlistResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RemoveFromWatchlistResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RemoveFromWatchlistResponse clone() => RemoveFromWatchlistResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RemoveFromWatchlistResponse copyWith(void Function(RemoveFromWatchlistResponse) updates) => super.copyWith((message) => updates(message as RemoveFromWatchlistResponse)) as RemoveFromWatchlistResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DeleteWatchlistRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'watchlistId')
    ..hasRequiredFields = false
  ;

  DeleteWatchlistRequest._() : super();
  factory DeleteWatchlistRequest({
    $core.String? watchlistId,
  }) {
    final _result = create();
    if (watchlistId != null) {
      _result.watchlistId = watchlistId;
    }
    return _result;
  }
  factory DeleteWatchlistRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteWatchlistRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteWatchlistRequest clone() => DeleteWatchlistRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteWatchlistRequest copyWith(void Function(DeleteWatchlistRequest) updates) => super.copyWith((message) => updates(message as DeleteWatchlistRequest)) as DeleteWatchlistRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DeleteWatchlistResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..hasRequiredFields = false
  ;

  DeleteWatchlistResponse._() : super();
  factory DeleteWatchlistResponse({
    $core.bool? success,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    return _result;
  }
  factory DeleteWatchlistResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteWatchlistResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteWatchlistResponse clone() => DeleteWatchlistResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteWatchlistResponse copyWith(void Function(DeleteWatchlistResponse) updates) => super.copyWith((message) => updates(message as DeleteWatchlistResponse)) as DeleteWatchlistResponse; // ignore: deprecated_member_use
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

class ToggleFavoriteRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ToggleFavoriteRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cryptoId')
    ..hasRequiredFields = false
  ;

  ToggleFavoriteRequest._() : super();
  factory ToggleFavoriteRequest({
    $core.String? cryptoId,
  }) {
    final _result = create();
    if (cryptoId != null) {
      _result.cryptoId = cryptoId;
    }
    return _result;
  }
  factory ToggleFavoriteRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ToggleFavoriteRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ToggleFavoriteRequest clone() => ToggleFavoriteRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ToggleFavoriteRequest copyWith(void Function(ToggleFavoriteRequest) updates) => super.copyWith((message) => updates(message as ToggleFavoriteRequest)) as ToggleFavoriteRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ToggleFavoriteResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isFavorite')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  ToggleFavoriteResponse._() : super();
  factory ToggleFavoriteResponse({
    $core.bool? isFavorite,
    $core.String? message,
  }) {
    final _result = create();
    if (isFavorite != null) {
      _result.isFavorite = isFavorite;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory ToggleFavoriteResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ToggleFavoriteResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ToggleFavoriteResponse clone() => ToggleFavoriteResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ToggleFavoriteResponse copyWith(void Function(ToggleFavoriteResponse) updates) => super.copyWith((message) => updates(message as ToggleFavoriteResponse)) as ToggleFavoriteResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetPlatformCryptoPortfolioRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fiatCurrency')
    ..hasRequiredFields = false
  ;

  GetPlatformCryptoPortfolioRequest._() : super();
  factory GetPlatformCryptoPortfolioRequest({
    $core.String? fiatCurrency,
  }) {
    final _result = create();
    if (fiatCurrency != null) {
      _result.fiatCurrency = fiatCurrency;
    }
    return _result;
  }
  factory GetPlatformCryptoPortfolioRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPlatformCryptoPortfolioRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPlatformCryptoPortfolioRequest clone() => GetPlatformCryptoPortfolioRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPlatformCryptoPortfolioRequest copyWith(void Function(GetPlatformCryptoPortfolioRequest) updates) => super.copyWith((message) => updates(message as GetPlatformCryptoPortfolioRequest)) as GetPlatformCryptoPortfolioRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AssetAllocation', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cryptoId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'symbol')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalBalance', $pb.PbFieldType.OD)
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalFiatValue', $pb.PbFieldType.OD)
    ..a<$core.double>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currentPrice', $pb.PbFieldType.OD)
    ..a<$core.double>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'allocationPercentage', $pb.PbFieldType.OD)
    ..a<$core.int>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'holdersCount', $pb.PbFieldType.O3)
    ..a<$core.double>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'priceChange24h', $pb.PbFieldType.OD, protoName: 'price_change_24h')
    ..hasRequiredFields = false
  ;

  AssetAllocation._() : super();
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
    final _result = create();
    if (cryptoId != null) {
      _result.cryptoId = cryptoId;
    }
    if (symbol != null) {
      _result.symbol = symbol;
    }
    if (name != null) {
      _result.name = name;
    }
    if (totalBalance != null) {
      _result.totalBalance = totalBalance;
    }
    if (totalFiatValue != null) {
      _result.totalFiatValue = totalFiatValue;
    }
    if (currentPrice != null) {
      _result.currentPrice = currentPrice;
    }
    if (allocationPercentage != null) {
      _result.allocationPercentage = allocationPercentage;
    }
    if (holdersCount != null) {
      _result.holdersCount = holdersCount;
    }
    if (priceChange24h != null) {
      _result.priceChange24h = priceChange24h;
    }
    return _result;
  }
  factory AssetAllocation.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AssetAllocation.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AssetAllocation clone() => AssetAllocation()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AssetAllocation copyWith(void Function(AssetAllocation) updates) => super.copyWith((message) => updates(message as AssetAllocation)) as AssetAllocation; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PlatformCryptoStats', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalUsersWithHoldings', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalWallets', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalTransactions', $pb.PbFieldType.O3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalUniqueAssets', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  PlatformCryptoStats._() : super();
  factory PlatformCryptoStats({
    $core.int? totalUsersWithHoldings,
    $core.int? totalWallets,
    $core.int? totalTransactions,
    $core.int? totalUniqueAssets,
  }) {
    final _result = create();
    if (totalUsersWithHoldings != null) {
      _result.totalUsersWithHoldings = totalUsersWithHoldings;
    }
    if (totalWallets != null) {
      _result.totalWallets = totalWallets;
    }
    if (totalTransactions != null) {
      _result.totalTransactions = totalTransactions;
    }
    if (totalUniqueAssets != null) {
      _result.totalUniqueAssets = totalUniqueAssets;
    }
    return _result;
  }
  factory PlatformCryptoStats.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PlatformCryptoStats.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PlatformCryptoStats clone() => PlatformCryptoStats()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PlatformCryptoStats copyWith(void Function(PlatformCryptoStats) updates) => super.copyWith((message) => updates(message as PlatformCryptoStats)) as PlatformCryptoStats; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetPlatformCryptoPortfolioResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.double>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalPortfolioValue', $pb.PbFieldType.OD)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fiatCurrency')
    ..pc<AssetAllocation>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'assets', $pb.PbFieldType.PM, subBuilder: AssetAllocation.create)
    ..aOM<PlatformCryptoStats>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'stats', subBuilder: PlatformCryptoStats.create)
    ..aOM<$48.Timestamp>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lastUpdated', subBuilder: $48.Timestamp.create)
    ..hasRequiredFields = false
  ;

  GetPlatformCryptoPortfolioResponse._() : super();
  factory GetPlatformCryptoPortfolioResponse({
    $core.double? totalPortfolioValue,
    $core.String? fiatCurrency,
    $core.Iterable<AssetAllocation>? assets,
    PlatformCryptoStats? stats,
    $48.Timestamp? lastUpdated,
  }) {
    final _result = create();
    if (totalPortfolioValue != null) {
      _result.totalPortfolioValue = totalPortfolioValue;
    }
    if (fiatCurrency != null) {
      _result.fiatCurrency = fiatCurrency;
    }
    if (assets != null) {
      _result.assets.addAll(assets);
    }
    if (stats != null) {
      _result.stats = stats;
    }
    if (lastUpdated != null) {
      _result.lastUpdated = lastUpdated;
    }
    return _result;
  }
  factory GetPlatformCryptoPortfolioResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPlatformCryptoPortfolioResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPlatformCryptoPortfolioResponse clone() => GetPlatformCryptoPortfolioResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPlatformCryptoPortfolioResponse copyWith(void Function(GetPlatformCryptoPortfolioResponse) updates) => super.copyWith((message) => updates(message as GetPlatformCryptoPortfolioResponse)) as GetPlatformCryptoPortfolioResponse; // ignore: deprecated_member_use
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
  $48.Timestamp get lastUpdated => $_getN(4);
  @$pb.TagNumber(5)
  set lastUpdated($48.Timestamp v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasLastUpdated() => $_has(4);
  @$pb.TagNumber(5)
  void clearLastUpdated() => clearField(5);
  @$pb.TagNumber(5)
  $48.Timestamp ensureLastUpdated() => $_ensure(4);
}

class GetPlatformCryptoTransactionsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetPlatformCryptoTransactionsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'perPage', $pb.PbFieldType.O3)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'statusFilter')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'typeFilter')
    ..hasRequiredFields = false
  ;

  GetPlatformCryptoTransactionsRequest._() : super();
  factory GetPlatformCryptoTransactionsRequest({
    $core.int? page,
    $core.int? perPage,
    $core.String? statusFilter,
    $core.String? typeFilter,
  }) {
    final _result = create();
    if (page != null) {
      _result.page = page;
    }
    if (perPage != null) {
      _result.perPage = perPage;
    }
    if (statusFilter != null) {
      _result.statusFilter = statusFilter;
    }
    if (typeFilter != null) {
      _result.typeFilter = typeFilter;
    }
    return _result;
  }
  factory GetPlatformCryptoTransactionsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPlatformCryptoTransactionsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPlatformCryptoTransactionsRequest clone() => GetPlatformCryptoTransactionsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPlatformCryptoTransactionsRequest copyWith(void Function(GetPlatformCryptoTransactionsRequest) updates) => super.copyWith((message) => updates(message as GetPlatformCryptoTransactionsRequest)) as GetPlatformCryptoTransactionsRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetPlatformCryptoTransactionsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<CryptoTransaction>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactions', $pb.PbFieldType.PM, subBuilder: CryptoTransaction.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalCount', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'perPage', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetPlatformCryptoTransactionsResponse._() : super();
  factory GetPlatformCryptoTransactionsResponse({
    $core.Iterable<CryptoTransaction>? transactions,
    $core.int? totalCount,
    $core.int? page,
    $core.int? perPage,
  }) {
    final _result = create();
    if (transactions != null) {
      _result.transactions.addAll(transactions);
    }
    if (totalCount != null) {
      _result.totalCount = totalCount;
    }
    if (page != null) {
      _result.page = page;
    }
    if (perPage != null) {
      _result.perPage = perPage;
    }
    return _result;
  }
  factory GetPlatformCryptoTransactionsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPlatformCryptoTransactionsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPlatformCryptoTransactionsResponse clone() => GetPlatformCryptoTransactionsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPlatformCryptoTransactionsResponse copyWith(void Function(GetPlatformCryptoTransactionsResponse) updates) => super.copyWith((message) => updates(message as GetPlatformCryptoTransactionsResponse)) as GetPlatformCryptoTransactionsResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CryptoNewsItem', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'title')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'url')
    ..aOM<$48.Timestamp>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'publishedAt', subBuilder: $48.Timestamp.create)
    ..pPS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currencies')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'source')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sentiment')
    ..a<$core.int>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'votesPositive', $pb.PbFieldType.O3)
    ..a<$core.int>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'votesNegative', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  CryptoNewsItem._() : super();
  factory CryptoNewsItem({
    $core.String? id,
    $core.String? title,
    $core.String? url,
    $48.Timestamp? publishedAt,
    $core.Iterable<$core.String>? currencies,
    $core.String? source,
    $core.String? sentiment,
    $core.int? votesPositive,
    $core.int? votesNegative,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (title != null) {
      _result.title = title;
    }
    if (url != null) {
      _result.url = url;
    }
    if (publishedAt != null) {
      _result.publishedAt = publishedAt;
    }
    if (currencies != null) {
      _result.currencies.addAll(currencies);
    }
    if (source != null) {
      _result.source = source;
    }
    if (sentiment != null) {
      _result.sentiment = sentiment;
    }
    if (votesPositive != null) {
      _result.votesPositive = votesPositive;
    }
    if (votesNegative != null) {
      _result.votesNegative = votesNegative;
    }
    return _result;
  }
  factory CryptoNewsItem.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CryptoNewsItem.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CryptoNewsItem clone() => CryptoNewsItem()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CryptoNewsItem copyWith(void Function(CryptoNewsItem) updates) => super.copyWith((message) => updates(message as CryptoNewsItem)) as CryptoNewsItem; // ignore: deprecated_member_use
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
  $48.Timestamp get publishedAt => $_getN(3);
  @$pb.TagNumber(4)
  set publishedAt($48.Timestamp v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasPublishedAt() => $_has(3);
  @$pb.TagNumber(4)
  void clearPublishedAt() => clearField(4);
  @$pb.TagNumber(4)
  $48.Timestamp ensurePublishedAt() => $_ensure(3);

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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetCryptoNewsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pPS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currencies')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetCryptoNewsRequest._() : super();
  factory GetCryptoNewsRequest({
    $core.Iterable<$core.String>? currencies,
    $core.int? limit,
  }) {
    final _result = create();
    if (currencies != null) {
      _result.currencies.addAll(currencies);
    }
    if (limit != null) {
      _result.limit = limit;
    }
    return _result;
  }
  factory GetCryptoNewsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCryptoNewsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCryptoNewsRequest clone() => GetCryptoNewsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCryptoNewsRequest copyWith(void Function(GetCryptoNewsRequest) updates) => super.copyWith((message) => updates(message as GetCryptoNewsRequest)) as GetCryptoNewsRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetCryptoNewsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<CryptoNewsItem>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'items', $pb.PbFieldType.PM, subBuilder: CryptoNewsItem.create)
    ..hasRequiredFields = false
  ;

  GetCryptoNewsResponse._() : super();
  factory GetCryptoNewsResponse({
    $core.Iterable<CryptoNewsItem>? items,
  }) {
    final _result = create();
    if (items != null) {
      _result.items.addAll(items);
    }
    return _result;
  }
  factory GetCryptoNewsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetCryptoNewsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetCryptoNewsResponse clone() => GetCryptoNewsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetCryptoNewsResponse copyWith(void Function(GetCryptoNewsResponse) updates) => super.copyWith((message) => updates(message as GetCryptoNewsResponse)) as GetCryptoNewsResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'OHLCVPoint', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<$48.Timestamp>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'timestamp', subBuilder: $48.Timestamp.create)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'open', $pb.PbFieldType.OD)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'high', $pb.PbFieldType.OD)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'low', $pb.PbFieldType.OD)
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'close', $pb.PbFieldType.OD)
    ..a<$core.double>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'volume', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  OHLCVPoint._() : super();
  factory OHLCVPoint({
    $48.Timestamp? timestamp,
    $core.double? open,
    $core.double? high,
    $core.double? low,
    $core.double? close,
    $core.double? volume,
  }) {
    final _result = create();
    if (timestamp != null) {
      _result.timestamp = timestamp;
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
    if (volume != null) {
      _result.volume = volume;
    }
    return _result;
  }
  factory OHLCVPoint.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory OHLCVPoint.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  OHLCVPoint clone() => OHLCVPoint()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  OHLCVPoint copyWith(void Function(OHLCVPoint) updates) => super.copyWith((message) => updates(message as OHLCVPoint)) as OHLCVPoint; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static OHLCVPoint create() => OHLCVPoint._();
  OHLCVPoint createEmptyInstance() => create();
  static $pb.PbList<OHLCVPoint> createRepeated() => $pb.PbList<OHLCVPoint>();
  @$core.pragma('dart2js:noInline')
  static OHLCVPoint getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<OHLCVPoint>(create);
  static OHLCVPoint? _defaultInstance;

  @$pb.TagNumber(1)
  $48.Timestamp get timestamp => $_getN(0);
  @$pb.TagNumber(1)
  set timestamp($48.Timestamp v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasTimestamp() => $_has(0);
  @$pb.TagNumber(1)
  void clearTimestamp() => clearField(1);
  @$pb.TagNumber(1)
  $48.Timestamp ensureTimestamp() => $_ensure(0);

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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetOHLCVRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cryptoId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'vsCurrency')
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'days', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetOHLCVRequest._() : super();
  factory GetOHLCVRequest({
    $core.String? cryptoId,
    $core.String? vsCurrency,
    $core.int? days,
  }) {
    final _result = create();
    if (cryptoId != null) {
      _result.cryptoId = cryptoId;
    }
    if (vsCurrency != null) {
      _result.vsCurrency = vsCurrency;
    }
    if (days != null) {
      _result.days = days;
    }
    return _result;
  }
  factory GetOHLCVRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetOHLCVRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetOHLCVRequest clone() => GetOHLCVRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetOHLCVRequest copyWith(void Function(GetOHLCVRequest) updates) => super.copyWith((message) => updates(message as GetOHLCVRequest)) as GetOHLCVRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetOHLCVResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<OHLCVPoint>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'points', $pb.PbFieldType.PM, subBuilder: OHLCVPoint.create)
    ..hasRequiredFields = false
  ;

  GetOHLCVResponse._() : super();
  factory GetOHLCVResponse({
    $core.Iterable<OHLCVPoint>? points,
  }) {
    final _result = create();
    if (points != null) {
      _result.points.addAll(points);
    }
    return _result;
  }
  factory GetOHLCVResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetOHLCVResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetOHLCVResponse clone() => GetOHLCVResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetOHLCVResponse copyWith(void Function(GetOHLCVResponse) updates) => super.copyWith((message) => updates(message as GetOHLCVResponse)) as GetOHLCVResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'OrderBookEntry', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'price')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'volume')
    ..hasRequiredFields = false
  ;

  OrderBookEntry._() : super();
  factory OrderBookEntry({
    $core.String? price,
    $core.String? volume,
  }) {
    final _result = create();
    if (price != null) {
      _result.price = price;
    }
    if (volume != null) {
      _result.volume = volume;
    }
    return _result;
  }
  factory OrderBookEntry.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory OrderBookEntry.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  OrderBookEntry clone() => OrderBookEntry()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  OrderBookEntry copyWith(void Function(OrderBookEntry) updates) => super.copyWith((message) => updates(message as OrderBookEntry)) as OrderBookEntry; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetOrderBookRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'market')
    ..hasRequiredFields = false
  ;

  GetOrderBookRequest._() : super();
  factory GetOrderBookRequest({
    $core.String? market,
  }) {
    final _result = create();
    if (market != null) {
      _result.market = market;
    }
    return _result;
  }
  factory GetOrderBookRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetOrderBookRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetOrderBookRequest clone() => GetOrderBookRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetOrderBookRequest copyWith(void Function(GetOrderBookRequest) updates) => super.copyWith((message) => updates(message as GetOrderBookRequest)) as GetOrderBookRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetOrderBookResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<OrderBookEntry>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bids', $pb.PbFieldType.PM, subBuilder: OrderBookEntry.create)
    ..pc<OrderBookEntry>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'asks', $pb.PbFieldType.PM, subBuilder: OrderBookEntry.create)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'market')
    ..hasRequiredFields = false
  ;

  GetOrderBookResponse._() : super();
  factory GetOrderBookResponse({
    $core.Iterable<OrderBookEntry>? bids,
    $core.Iterable<OrderBookEntry>? asks,
    $core.String? market,
  }) {
    final _result = create();
    if (bids != null) {
      _result.bids.addAll(bids);
    }
    if (asks != null) {
      _result.asks.addAll(asks);
    }
    if (market != null) {
      _result.market = market;
    }
    return _result;
  }
  factory GetOrderBookResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetOrderBookResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetOrderBookResponse clone() => GetOrderBookResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetOrderBookResponse copyWith(void Function(GetOrderBookResponse) updates) => super.copyWith((message) => updates(message as GetOrderBookResponse)) as GetOrderBookResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TradeEntry', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'price')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'volume')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'side')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'market')
    ..aOM<$48.Timestamp>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $48.Timestamp.create)
    ..hasRequiredFields = false
  ;

  TradeEntry._() : super();
  factory TradeEntry({
    $core.String? id,
    $core.String? price,
    $core.String? volume,
    $core.String? side,
    $core.String? market,
    $48.Timestamp? createdAt,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (price != null) {
      _result.price = price;
    }
    if (volume != null) {
      _result.volume = volume;
    }
    if (side != null) {
      _result.side = side;
    }
    if (market != null) {
      _result.market = market;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    return _result;
  }
  factory TradeEntry.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TradeEntry.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TradeEntry clone() => TradeEntry()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TradeEntry copyWith(void Function(TradeEntry) updates) => super.copyWith((message) => updates(message as TradeEntry)) as TradeEntry; // ignore: deprecated_member_use
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
  $48.Timestamp get createdAt => $_getN(5);
  @$pb.TagNumber(6)
  set createdAt($48.Timestamp v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasCreatedAt() => $_has(5);
  @$pb.TagNumber(6)
  void clearCreatedAt() => clearField(6);
  @$pb.TagNumber(6)
  $48.Timestamp ensureCreatedAt() => $_ensure(5);
}

class GetRecentTradesRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetRecentTradesRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'market')
    ..hasRequiredFields = false
  ;

  GetRecentTradesRequest._() : super();
  factory GetRecentTradesRequest({
    $core.String? market,
  }) {
    final _result = create();
    if (market != null) {
      _result.market = market;
    }
    return _result;
  }
  factory GetRecentTradesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetRecentTradesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetRecentTradesRequest clone() => GetRecentTradesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetRecentTradesRequest copyWith(void Function(GetRecentTradesRequest) updates) => super.copyWith((message) => updates(message as GetRecentTradesRequest)) as GetRecentTradesRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetRecentTradesResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<TradeEntry>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'trades', $pb.PbFieldType.PM, subBuilder: TradeEntry.create)
    ..hasRequiredFields = false
  ;

  GetRecentTradesResponse._() : super();
  factory GetRecentTradesResponse({
    $core.Iterable<TradeEntry>? trades,
  }) {
    final _result = create();
    if (trades != null) {
      _result.trades.addAll(trades);
    }
    return _result;
  }
  factory GetRecentTradesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetRecentTradesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetRecentTradesResponse clone() => GetRecentTradesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetRecentTradesResponse copyWith(void Function(GetRecentTradesResponse) updates) => super.copyWith((message) => updates(message as GetRecentTradesResponse)) as GetRecentTradesResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetFearGreedIndexRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetFearGreedIndexRequest._() : super();
  factory GetFearGreedIndexRequest() => create();
  factory GetFearGreedIndexRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetFearGreedIndexRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetFearGreedIndexRequest clone() => GetFearGreedIndexRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetFearGreedIndexRequest copyWith(void Function(GetFearGreedIndexRequest) updates) => super.copyWith((message) => updates(message as GetFearGreedIndexRequest)) as GetFearGreedIndexRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'FearGreedEntry', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'value', $pb.PbFieldType.O3)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'classification')
    ..aOM<$48.Timestamp>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'timestamp', subBuilder: $48.Timestamp.create)
    ..hasRequiredFields = false
  ;

  FearGreedEntry._() : super();
  factory FearGreedEntry({
    $core.int? value,
    $core.String? classification,
    $48.Timestamp? timestamp,
  }) {
    final _result = create();
    if (value != null) {
      _result.value = value;
    }
    if (classification != null) {
      _result.classification = classification;
    }
    if (timestamp != null) {
      _result.timestamp = timestamp;
    }
    return _result;
  }
  factory FearGreedEntry.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FearGreedEntry.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FearGreedEntry clone() => FearGreedEntry()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FearGreedEntry copyWith(void Function(FearGreedEntry) updates) => super.copyWith((message) => updates(message as FearGreedEntry)) as FearGreedEntry; // ignore: deprecated_member_use
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
  $48.Timestamp get timestamp => $_getN(2);
  @$pb.TagNumber(3)
  set timestamp($48.Timestamp v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasTimestamp() => $_has(2);
  @$pb.TagNumber(3)
  void clearTimestamp() => clearField(3);
  @$pb.TagNumber(3)
  $48.Timestamp ensureTimestamp() => $_ensure(2);
}

class GetFearGreedIndexResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetFearGreedIndexResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<FearGreedEntry>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'current', subBuilder: FearGreedEntry.create)
    ..pc<FearGreedEntry>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'history', $pb.PbFieldType.PM, subBuilder: FearGreedEntry.create)
    ..hasRequiredFields = false
  ;

  GetFearGreedIndexResponse._() : super();
  factory GetFearGreedIndexResponse({
    FearGreedEntry? current,
    $core.Iterable<FearGreedEntry>? history,
  }) {
    final _result = create();
    if (current != null) {
      _result.current = current;
    }
    if (history != null) {
      _result.history.addAll(history);
    }
    return _result;
  }
  factory GetFearGreedIndexResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetFearGreedIndexResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetFearGreedIndexResponse clone() => GetFearGreedIndexResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetFearGreedIndexResponse copyWith(void Function(GetFearGreedIndexResponse) updates) => super.copyWith((message) => updates(message as GetFearGreedIndexResponse)) as GetFearGreedIndexResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PriceAlert', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cryptoId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cryptoSymbol')
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'targetPrice', $pb.PbFieldType.OD)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'direction')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fiatCurrency')
    ..aOB(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isActive')
    ..aOB(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isTriggered')
    ..aOM<$48.Timestamp>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $48.Timestamp.create)
    ..aOM<$48.Timestamp>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'triggeredAt', subBuilder: $48.Timestamp.create)
    ..hasRequiredFields = false
  ;

  PriceAlert._() : super();
  factory PriceAlert({
    $core.String? id,
    $core.String? cryptoId,
    $core.String? cryptoSymbol,
    $core.double? targetPrice,
    $core.String? direction,
    $core.String? fiatCurrency,
    $core.bool? isActive,
    $core.bool? isTriggered,
    $48.Timestamp? createdAt,
    $48.Timestamp? triggeredAt,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (cryptoId != null) {
      _result.cryptoId = cryptoId;
    }
    if (cryptoSymbol != null) {
      _result.cryptoSymbol = cryptoSymbol;
    }
    if (targetPrice != null) {
      _result.targetPrice = targetPrice;
    }
    if (direction != null) {
      _result.direction = direction;
    }
    if (fiatCurrency != null) {
      _result.fiatCurrency = fiatCurrency;
    }
    if (isActive != null) {
      _result.isActive = isActive;
    }
    if (isTriggered != null) {
      _result.isTriggered = isTriggered;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (triggeredAt != null) {
      _result.triggeredAt = triggeredAt;
    }
    return _result;
  }
  factory PriceAlert.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PriceAlert.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PriceAlert clone() => PriceAlert()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PriceAlert copyWith(void Function(PriceAlert) updates) => super.copyWith((message) => updates(message as PriceAlert)) as PriceAlert; // ignore: deprecated_member_use
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
  $48.Timestamp get createdAt => $_getN(8);
  @$pb.TagNumber(9)
  set createdAt($48.Timestamp v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasCreatedAt() => $_has(8);
  @$pb.TagNumber(9)
  void clearCreatedAt() => clearField(9);
  @$pb.TagNumber(9)
  $48.Timestamp ensureCreatedAt() => $_ensure(8);

  @$pb.TagNumber(10)
  $48.Timestamp get triggeredAt => $_getN(9);
  @$pb.TagNumber(10)
  set triggeredAt($48.Timestamp v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasTriggeredAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearTriggeredAt() => clearField(10);
  @$pb.TagNumber(10)
  $48.Timestamp ensureTriggeredAt() => $_ensure(9);
}

class CreatePriceAlertRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreatePriceAlertRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cryptoId')
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'targetPrice', $pb.PbFieldType.OD)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'direction')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fiatCurrency')
    ..hasRequiredFields = false
  ;

  CreatePriceAlertRequest._() : super();
  factory CreatePriceAlertRequest({
    $core.String? cryptoId,
    $core.double? targetPrice,
    $core.String? direction,
    $core.String? fiatCurrency,
  }) {
    final _result = create();
    if (cryptoId != null) {
      _result.cryptoId = cryptoId;
    }
    if (targetPrice != null) {
      _result.targetPrice = targetPrice;
    }
    if (direction != null) {
      _result.direction = direction;
    }
    if (fiatCurrency != null) {
      _result.fiatCurrency = fiatCurrency;
    }
    return _result;
  }
  factory CreatePriceAlertRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreatePriceAlertRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreatePriceAlertRequest clone() => CreatePriceAlertRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreatePriceAlertRequest copyWith(void Function(CreatePriceAlertRequest) updates) => super.copyWith((message) => updates(message as CreatePriceAlertRequest)) as CreatePriceAlertRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreatePriceAlertResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<PriceAlert>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'alert', subBuilder: PriceAlert.create)
    ..hasRequiredFields = false
  ;

  CreatePriceAlertResponse._() : super();
  factory CreatePriceAlertResponse({
    PriceAlert? alert,
  }) {
    final _result = create();
    if (alert != null) {
      _result.alert = alert;
    }
    return _result;
  }
  factory CreatePriceAlertResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreatePriceAlertResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreatePriceAlertResponse clone() => CreatePriceAlertResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreatePriceAlertResponse copyWith(void Function(CreatePriceAlertResponse) updates) => super.copyWith((message) => updates(message as CreatePriceAlertResponse)) as CreatePriceAlertResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetPriceAlertsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'activeOnly')
    ..hasRequiredFields = false
  ;

  GetPriceAlertsRequest._() : super();
  factory GetPriceAlertsRequest({
    $core.bool? activeOnly,
  }) {
    final _result = create();
    if (activeOnly != null) {
      _result.activeOnly = activeOnly;
    }
    return _result;
  }
  factory GetPriceAlertsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPriceAlertsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPriceAlertsRequest clone() => GetPriceAlertsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPriceAlertsRequest copyWith(void Function(GetPriceAlertsRequest) updates) => super.copyWith((message) => updates(message as GetPriceAlertsRequest)) as GetPriceAlertsRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetPriceAlertsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<PriceAlert>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'alerts', $pb.PbFieldType.PM, subBuilder: PriceAlert.create)
    ..hasRequiredFields = false
  ;

  GetPriceAlertsResponse._() : super();
  factory GetPriceAlertsResponse({
    $core.Iterable<PriceAlert>? alerts,
  }) {
    final _result = create();
    if (alerts != null) {
      _result.alerts.addAll(alerts);
    }
    return _result;
  }
  factory GetPriceAlertsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPriceAlertsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPriceAlertsResponse clone() => GetPriceAlertsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPriceAlertsResponse copyWith(void Function(GetPriceAlertsResponse) updates) => super.copyWith((message) => updates(message as GetPriceAlertsResponse)) as GetPriceAlertsResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DeletePriceAlertRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'alertId')
    ..hasRequiredFields = false
  ;

  DeletePriceAlertRequest._() : super();
  factory DeletePriceAlertRequest({
    $core.String? alertId,
  }) {
    final _result = create();
    if (alertId != null) {
      _result.alertId = alertId;
    }
    return _result;
  }
  factory DeletePriceAlertRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeletePriceAlertRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeletePriceAlertRequest clone() => DeletePriceAlertRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeletePriceAlertRequest copyWith(void Function(DeletePriceAlertRequest) updates) => super.copyWith((message) => updates(message as DeletePriceAlertRequest)) as DeletePriceAlertRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DeletePriceAlertResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..hasRequiredFields = false
  ;

  DeletePriceAlertResponse._() : super();
  factory DeletePriceAlertResponse({
    $core.bool? success,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    return _result;
  }
  factory DeletePriceAlertResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeletePriceAlertResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeletePriceAlertResponse clone() => DeletePriceAlertResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeletePriceAlertResponse copyWith(void Function(DeletePriceAlertResponse) updates) => super.copyWith((message) => updates(message as DeletePriceAlertResponse)) as DeletePriceAlertResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'FeeTier', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cryptoId')
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'minAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'maxAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'feePercentage', $pb.PbFieldType.OD)
    ..aOB(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isActive')
    ..hasRequiredFields = false
  ;

  FeeTier._() : super();
  factory FeeTier({
    $core.String? id,
    $core.String? currency,
    $core.String? cryptoId,
    $core.double? minAmount,
    $core.double? maxAmount,
    $core.double? feePercentage,
    $core.bool? isActive,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (cryptoId != null) {
      _result.cryptoId = cryptoId;
    }
    if (minAmount != null) {
      _result.minAmount = minAmount;
    }
    if (maxAmount != null) {
      _result.maxAmount = maxAmount;
    }
    if (feePercentage != null) {
      _result.feePercentage = feePercentage;
    }
    if (isActive != null) {
      _result.isActive = isActive;
    }
    return _result;
  }
  factory FeeTier.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FeeTier.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FeeTier clone() => FeeTier()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FeeTier copyWith(void Function(FeeTier) updates) => super.copyWith((message) => updates(message as FeeTier)) as FeeTier; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetFeeTiersRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetFeeTiersRequest._() : super();
  factory GetFeeTiersRequest() => create();
  factory GetFeeTiersRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetFeeTiersRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetFeeTiersRequest clone() => GetFeeTiersRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetFeeTiersRequest copyWith(void Function(GetFeeTiersRequest) updates) => super.copyWith((message) => updates(message as GetFeeTiersRequest)) as GetFeeTiersRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetFeeTiersResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<FeeTier>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tiers', $pb.PbFieldType.PM, subBuilder: FeeTier.create)
    ..hasRequiredFields = false
  ;

  GetFeeTiersResponse._() : super();
  factory GetFeeTiersResponse({
    $core.Iterable<FeeTier>? tiers,
  }) {
    final _result = create();
    if (tiers != null) {
      _result.tiers.addAll(tiers);
    }
    return _result;
  }
  factory GetFeeTiersResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetFeeTiersResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetFeeTiersResponse clone() => GetFeeTiersResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetFeeTiersResponse copyWith(void Function(GetFeeTiersResponse) updates) => super.copyWith((message) => updates(message as GetFeeTiersResponse)) as GetFeeTiersResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateFeeTierRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cryptoId')
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'minAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'maxAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'feePercentage', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  CreateFeeTierRequest._() : super();
  factory CreateFeeTierRequest({
    $core.String? currency,
    $core.String? cryptoId,
    $core.double? minAmount,
    $core.double? maxAmount,
    $core.double? feePercentage,
  }) {
    final _result = create();
    if (currency != null) {
      _result.currency = currency;
    }
    if (cryptoId != null) {
      _result.cryptoId = cryptoId;
    }
    if (minAmount != null) {
      _result.minAmount = minAmount;
    }
    if (maxAmount != null) {
      _result.maxAmount = maxAmount;
    }
    if (feePercentage != null) {
      _result.feePercentage = feePercentage;
    }
    return _result;
  }
  factory CreateFeeTierRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateFeeTierRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateFeeTierRequest clone() => CreateFeeTierRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateFeeTierRequest copyWith(void Function(CreateFeeTierRequest) updates) => super.copyWith((message) => updates(message as CreateFeeTierRequest)) as CreateFeeTierRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateFeeTierResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<FeeTier>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tier', subBuilder: FeeTier.create)
    ..hasRequiredFields = false
  ;

  CreateFeeTierResponse._() : super();
  factory CreateFeeTierResponse({
    FeeTier? tier,
  }) {
    final _result = create();
    if (tier != null) {
      _result.tier = tier;
    }
    return _result;
  }
  factory CreateFeeTierResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateFeeTierResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateFeeTierResponse clone() => CreateFeeTierResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateFeeTierResponse copyWith(void Function(CreateFeeTierResponse) updates) => super.copyWith((message) => updates(message as CreateFeeTierResponse)) as CreateFeeTierResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateFeeTierRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'feePercentage', $pb.PbFieldType.OD)
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isActive')
    ..hasRequiredFields = false
  ;

  UpdateFeeTierRequest._() : super();
  factory UpdateFeeTierRequest({
    $core.String? id,
    $core.double? feePercentage,
    $core.bool? isActive,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (feePercentage != null) {
      _result.feePercentage = feePercentage;
    }
    if (isActive != null) {
      _result.isActive = isActive;
    }
    return _result;
  }
  factory UpdateFeeTierRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateFeeTierRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateFeeTierRequest clone() => UpdateFeeTierRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateFeeTierRequest copyWith(void Function(UpdateFeeTierRequest) updates) => super.copyWith((message) => updates(message as UpdateFeeTierRequest)) as UpdateFeeTierRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateFeeTierResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOM<FeeTier>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tier', subBuilder: FeeTier.create)
    ..hasRequiredFields = false
  ;

  UpdateFeeTierResponse._() : super();
  factory UpdateFeeTierResponse({
    FeeTier? tier,
  }) {
    final _result = create();
    if (tier != null) {
      _result.tier = tier;
    }
    return _result;
  }
  factory UpdateFeeTierResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateFeeTierResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateFeeTierResponse clone() => UpdateFeeTierResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateFeeTierResponse copyWith(void Function(UpdateFeeTierResponse) updates) => super.copyWith((message) => updates(message as UpdateFeeTierResponse)) as UpdateFeeTierResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DeleteFeeTierRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..hasRequiredFields = false
  ;

  DeleteFeeTierRequest._() : super();
  factory DeleteFeeTierRequest({
    $core.String? id,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    return _result;
  }
  factory DeleteFeeTierRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteFeeTierRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteFeeTierRequest clone() => DeleteFeeTierRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteFeeTierRequest copyWith(void Function(DeleteFeeTierRequest) updates) => super.copyWith((message) => updates(message as DeleteFeeTierRequest)) as DeleteFeeTierRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DeleteFeeTierResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..hasRequiredFields = false
  ;

  DeleteFeeTierResponse._() : super();
  factory DeleteFeeTierResponse({
    $core.bool? success,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    return _result;
  }
  factory DeleteFeeTierResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteFeeTierResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteFeeTierResponse clone() => DeleteFeeTierResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteFeeTierResponse copyWith(void Function(DeleteFeeTierResponse) updates) => super.copyWith((message) => updates(message as DeleteFeeTierResponse)) as DeleteFeeTierResponse; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RunReconciliationRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'triggeredBy')
    ..hasRequiredFields = false
  ;

  RunReconciliationRequest._() : super();
  factory RunReconciliationRequest({
    $core.String? triggeredBy,
  }) {
    final _result = create();
    if (triggeredBy != null) {
      _result.triggeredBy = triggeredBy;
    }
    return _result;
  }
  factory RunReconciliationRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RunReconciliationRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RunReconciliationRequest clone() => RunReconciliationRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RunReconciliationRequest copyWith(void Function(RunReconciliationRequest) updates) => super.copyWith((message) => updates(message as RunReconciliationRequest)) as RunReconciliationRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ReconciliationResult', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'date')
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'expiredHoldsReleased', $pb.PbFieldType.O3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'stuckTransactionsFound', $pb.PbFieldType.O3)
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'failedOutboxCount', $pb.PbFieldType.O3)
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..aOM<$48.Timestamp>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $48.Timestamp.create)
    ..hasRequiredFields = false
  ;

  ReconciliationResult._() : super();
  factory ReconciliationResult({
    $core.String? id,
    $core.String? date,
    $core.int? expiredHoldsReleased,
    $core.int? stuckTransactionsFound,
    $core.int? failedOutboxCount,
    $core.String? status,
    $48.Timestamp? createdAt,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (date != null) {
      _result.date = date;
    }
    if (expiredHoldsReleased != null) {
      _result.expiredHoldsReleased = expiredHoldsReleased;
    }
    if (stuckTransactionsFound != null) {
      _result.stuckTransactionsFound = stuckTransactionsFound;
    }
    if (failedOutboxCount != null) {
      _result.failedOutboxCount = failedOutboxCount;
    }
    if (status != null) {
      _result.status = status;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    return _result;
  }
  factory ReconciliationResult.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ReconciliationResult.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ReconciliationResult clone() => ReconciliationResult()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ReconciliationResult copyWith(void Function(ReconciliationResult) updates) => super.copyWith((message) => updates(message as ReconciliationResult)) as ReconciliationResult; // ignore: deprecated_member_use
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
  $48.Timestamp get createdAt => $_getN(6);
  @$pb.TagNumber(7)
  set createdAt($48.Timestamp v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasCreatedAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearCreatedAt() => clearField(7);
  @$pb.TagNumber(7)
  $48.Timestamp ensureCreatedAt() => $_ensure(6);
}

class GetReconciliationLogsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetReconciliationLogsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetReconciliationLogsRequest._() : super();
  factory GetReconciliationLogsRequest({
    $core.int? limit,
  }) {
    final _result = create();
    if (limit != null) {
      _result.limit = limit;
    }
    return _result;
  }
  factory GetReconciliationLogsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetReconciliationLogsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetReconciliationLogsRequest clone() => GetReconciliationLogsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetReconciliationLogsRequest copyWith(void Function(GetReconciliationLogsRequest) updates) => super.copyWith((message) => updates(message as GetReconciliationLogsRequest)) as GetReconciliationLogsRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetReconciliationLogsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<ReconciliationResult>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'logs', $pb.PbFieldType.PM, subBuilder: ReconciliationResult.create)
    ..hasRequiredFields = false
  ;

  GetReconciliationLogsResponse._() : super();
  factory GetReconciliationLogsResponse({
    $core.Iterable<ReconciliationResult>? logs,
  }) {
    final _result = create();
    if (logs != null) {
      _result.logs.addAll(logs);
    }
    return _result;
  }
  factory GetReconciliationLogsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetReconciliationLogsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetReconciliationLogsResponse clone() => GetReconciliationLogsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetReconciliationLogsResponse copyWith(void Function(GetReconciliationLogsResponse) updates) => super.copyWith((message) => updates(message as GetReconciliationLogsResponse)) as GetReconciliationLogsResponse; // ignore: deprecated_member_use
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

class GetSupportedAssetsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetSupportedAssetsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'vsCurrency')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'perPage', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetSupportedAssetsRequest._() : super();
  factory GetSupportedAssetsRequest({
    $core.String? vsCurrency,
    $core.int? page,
    $core.int? perPage,
  }) {
    final _result = create();
    if (vsCurrency != null) {
      _result.vsCurrency = vsCurrency;
    }
    if (page != null) {
      _result.page = page;
    }
    if (perPage != null) {
      _result.perPage = perPage;
    }
    return _result;
  }
  factory GetSupportedAssetsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetSupportedAssetsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetSupportedAssetsRequest clone() => GetSupportedAssetsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetSupportedAssetsRequest copyWith(void Function(GetSupportedAssetsRequest) updates) => super.copyWith((message) => updates(message as GetSupportedAssetsRequest)) as GetSupportedAssetsRequest; // ignore: deprecated_member_use
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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetSupportedAssetsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'pb'), createEmptyInstance: create)
    ..pc<CryptoMessage>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'assets', $pb.PbFieldType.PM, subBuilder: CryptoMessage.create)
    ..aOM<CryptoPaginationInfo>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pagination', subBuilder: CryptoPaginationInfo.create)
    ..hasRequiredFields = false
  ;

  GetSupportedAssetsResponse._() : super();
  factory GetSupportedAssetsResponse({
    $core.Iterable<CryptoMessage>? assets,
    CryptoPaginationInfo? pagination,
  }) {
    final _result = create();
    if (assets != null) {
      _result.assets.addAll(assets);
    }
    if (pagination != null) {
      _result.pagination = pagination;
    }
    return _result;
  }
  factory GetSupportedAssetsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetSupportedAssetsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetSupportedAssetsResponse clone() => GetSupportedAssetsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetSupportedAssetsResponse copyWith(void Function(GetSupportedAssetsResponse) updates) => super.copyWith((message) => updates(message as GetSupportedAssetsResponse)) as GetSupportedAssetsResponse; // ignore: deprecated_member_use
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

