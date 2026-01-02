///
//  Generated code. Do not modify.
//  source: giftcard.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $34;

import 'giftcard.pbenum.dart';

export 'giftcard.pbenum.dart';

class GiftCardBrand extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GiftCardBrand', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcard'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'logoUrl')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..e<GiftCardCategory>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'category', $pb.PbFieldType.OE, defaultOrMaker: GiftCardCategory.GIFTCARD_CATEGORY_UNSPECIFIED, valueOf: GiftCardCategory.valueOf, enumValues: GiftCardCategory.values)
    ..a<$core.double>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'discountPercentage', $pb.PbFieldType.OD)
    ..aOB(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isPopular')
    ..pPS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'availableDenominations')
    ..a<$core.double>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'minAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'maxAmount', $pb.PbFieldType.OD)
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'termsAndConditions')
    ..aOB(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isAvailable')
    ..a<$core.int>(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'stockCount', $pb.PbFieldType.O3)
    ..aOM<$34.Timestamp>(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $34.Timestamp.create)
    ..aOM<$34.Timestamp>(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedAt', subBuilder: $34.Timestamp.create)
    ..hasRequiredFields = false
  ;

  GiftCardBrand._() : super();
  factory GiftCardBrand({
    $core.String? id,
    $core.String? name,
    $core.String? logoUrl,
    $core.String? description,
    GiftCardCategory? category,
    $core.double? discountPercentage,
    $core.bool? isPopular,
    $core.Iterable<$core.String>? availableDenominations,
    $core.double? minAmount,
    $core.double? maxAmount,
    $core.String? termsAndConditions,
    $core.bool? isAvailable,
    $core.int? stockCount,
    $34.Timestamp? createdAt,
    $34.Timestamp? updatedAt,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (name != null) {
      _result.name = name;
    }
    if (logoUrl != null) {
      _result.logoUrl = logoUrl;
    }
    if (description != null) {
      _result.description = description;
    }
    if (category != null) {
      _result.category = category;
    }
    if (discountPercentage != null) {
      _result.discountPercentage = discountPercentage;
    }
    if (isPopular != null) {
      _result.isPopular = isPopular;
    }
    if (availableDenominations != null) {
      _result.availableDenominations.addAll(availableDenominations);
    }
    if (minAmount != null) {
      _result.minAmount = minAmount;
    }
    if (maxAmount != null) {
      _result.maxAmount = maxAmount;
    }
    if (termsAndConditions != null) {
      _result.termsAndConditions = termsAndConditions;
    }
    if (isAvailable != null) {
      _result.isAvailable = isAvailable;
    }
    if (stockCount != null) {
      _result.stockCount = stockCount;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      _result.updatedAt = updatedAt;
    }
    return _result;
  }
  factory GiftCardBrand.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GiftCardBrand.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GiftCardBrand clone() => GiftCardBrand()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GiftCardBrand copyWith(void Function(GiftCardBrand) updates) => super.copyWith((message) => updates(message as GiftCardBrand)) as GiftCardBrand; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GiftCardBrand create() => GiftCardBrand._();
  GiftCardBrand createEmptyInstance() => create();
  static $pb.PbList<GiftCardBrand> createRepeated() => $pb.PbList<GiftCardBrand>();
  @$core.pragma('dart2js:noInline')
  static GiftCardBrand getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GiftCardBrand>(create);
  static GiftCardBrand? _defaultInstance;

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
  $core.String get logoUrl => $_getSZ(2);
  @$pb.TagNumber(3)
  set logoUrl($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasLogoUrl() => $_has(2);
  @$pb.TagNumber(3)
  void clearLogoUrl() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get description => $_getSZ(3);
  @$pb.TagNumber(4)
  set description($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDescription() => $_has(3);
  @$pb.TagNumber(4)
  void clearDescription() => clearField(4);

  @$pb.TagNumber(5)
  GiftCardCategory get category => $_getN(4);
  @$pb.TagNumber(5)
  set category(GiftCardCategory v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasCategory() => $_has(4);
  @$pb.TagNumber(5)
  void clearCategory() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get discountPercentage => $_getN(5);
  @$pb.TagNumber(6)
  set discountPercentage($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasDiscountPercentage() => $_has(5);
  @$pb.TagNumber(6)
  void clearDiscountPercentage() => clearField(6);

  @$pb.TagNumber(7)
  $core.bool get isPopular => $_getBF(6);
  @$pb.TagNumber(7)
  set isPopular($core.bool v) { $_setBool(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasIsPopular() => $_has(6);
  @$pb.TagNumber(7)
  void clearIsPopular() => clearField(7);

  @$pb.TagNumber(8)
  $core.List<$core.String> get availableDenominations => $_getList(7);

  @$pb.TagNumber(9)
  $core.double get minAmount => $_getN(8);
  @$pb.TagNumber(9)
  set minAmount($core.double v) { $_setDouble(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasMinAmount() => $_has(8);
  @$pb.TagNumber(9)
  void clearMinAmount() => clearField(9);

  @$pb.TagNumber(10)
  $core.double get maxAmount => $_getN(9);
  @$pb.TagNumber(10)
  set maxAmount($core.double v) { $_setDouble(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasMaxAmount() => $_has(9);
  @$pb.TagNumber(10)
  void clearMaxAmount() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get termsAndConditions => $_getSZ(10);
  @$pb.TagNumber(11)
  set termsAndConditions($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasTermsAndConditions() => $_has(10);
  @$pb.TagNumber(11)
  void clearTermsAndConditions() => clearField(11);

  @$pb.TagNumber(12)
  $core.bool get isAvailable => $_getBF(11);
  @$pb.TagNumber(12)
  set isAvailable($core.bool v) { $_setBool(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasIsAvailable() => $_has(11);
  @$pb.TagNumber(12)
  void clearIsAvailable() => clearField(12);

  @$pb.TagNumber(13)
  $core.int get stockCount => $_getIZ(12);
  @$pb.TagNumber(13)
  set stockCount($core.int v) { $_setSignedInt32(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasStockCount() => $_has(12);
  @$pb.TagNumber(13)
  void clearStockCount() => clearField(13);

  @$pb.TagNumber(14)
  $34.Timestamp get createdAt => $_getN(13);
  @$pb.TagNumber(14)
  set createdAt($34.Timestamp v) { setField(14, v); }
  @$pb.TagNumber(14)
  $core.bool hasCreatedAt() => $_has(13);
  @$pb.TagNumber(14)
  void clearCreatedAt() => clearField(14);
  @$pb.TagNumber(14)
  $34.Timestamp ensureCreatedAt() => $_ensure(13);

  @$pb.TagNumber(15)
  $34.Timestamp get updatedAt => $_getN(14);
  @$pb.TagNumber(15)
  set updatedAt($34.Timestamp v) { setField(15, v); }
  @$pb.TagNumber(15)
  $core.bool hasUpdatedAt() => $_has(14);
  @$pb.TagNumber(15)
  void clearUpdatedAt() => clearField(15);
  @$pb.TagNumber(15)
  $34.Timestamp ensureUpdatedAt() => $_ensure(14);
}

class GiftCard extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GiftCard', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcard'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'brandId')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'brandName')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'logoUrl')
    ..a<$core.double>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..a<$core.double>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'discountPercentage', $pb.PbFieldType.OD)
    ..a<$core.double>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'finalPrice', $pb.PbFieldType.OD)
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..e<GiftCardStatus>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: GiftCardStatus.GIFTCARD_STATUS_UNSPECIFIED, valueOf: GiftCardStatus.valueOf, enumValues: GiftCardStatus.values)
    ..e<GiftCardType>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type', $pb.PbFieldType.OE, defaultOrMaker: GiftCardType.GIFTCARD_TYPE_UNSPECIFIED, valueOf: GiftCardType.valueOf, enumValues: GiftCardType.values)
    ..e<GiftCardCategory>(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'category', $pb.PbFieldType.OE, defaultOrMaker: GiftCardCategory.GIFTCARD_CATEGORY_UNSPECIFIED, valueOf: GiftCardCategory.valueOf, enumValues: GiftCardCategory.values)
    ..aOS(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..aOS(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'termsAndConditions')
    ..aOM<$34.Timestamp>(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'expiryDate', subBuilder: $34.Timestamp.create)
    ..aOM<$34.Timestamp>(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'purchaseDate', subBuilder: $34.Timestamp.create)
    ..aOS(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recipientEmail')
    ..aOS(18, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recipientName')
    ..aOS(19, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOS(20, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'code')
    ..aOS(21, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pin')
    ..aOB(22, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isRedeemed')
    ..aOS(23, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionId')
    ..pPS(24, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'availableDenominations')
    ..aOS(25, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'qrCodeUrl')
    ..aOS(26, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'barcodeUrl')
    ..aOM<$34.Timestamp>(27, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $34.Timestamp.create)
    ..aOM<$34.Timestamp>(28, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedAt', subBuilder: $34.Timestamp.create)
    ..aOM<$34.Timestamp>(29, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'redeemedAt', subBuilder: $34.Timestamp.create)
    ..aOS(30, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'redemptionLocation')
    ..a<$core.double>(31, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'remainingBalance', $pb.PbFieldType.OD)
    ..a<$core.double>(32, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'originalAmount', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  GiftCard._() : super();
  factory GiftCard({
    $core.String? id,
    $core.String? userId,
    $core.String? brandId,
    $core.String? brandName,
    $core.String? logoUrl,
    $core.double? amount,
    $core.double? discountPercentage,
    $core.double? finalPrice,
    $core.String? currency,
    GiftCardStatus? status,
    GiftCardType? type,
    GiftCardCategory? category,
    $core.String? description,
    $core.String? termsAndConditions,
    $34.Timestamp? expiryDate,
    $34.Timestamp? purchaseDate,
    $core.String? recipientEmail,
    $core.String? recipientName,
    $core.String? message,
    $core.String? code,
    $core.String? pin,
    $core.bool? isRedeemed,
    $core.String? transactionId,
    $core.Iterable<$core.String>? availableDenominations,
    $core.String? qrCodeUrl,
    $core.String? barcodeUrl,
    $34.Timestamp? createdAt,
    $34.Timestamp? updatedAt,
    $34.Timestamp? redeemedAt,
    $core.String? redemptionLocation,
    $core.double? remainingBalance,
    $core.double? originalAmount,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (brandId != null) {
      _result.brandId = brandId;
    }
    if (brandName != null) {
      _result.brandName = brandName;
    }
    if (logoUrl != null) {
      _result.logoUrl = logoUrl;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (discountPercentage != null) {
      _result.discountPercentage = discountPercentage;
    }
    if (finalPrice != null) {
      _result.finalPrice = finalPrice;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (status != null) {
      _result.status = status;
    }
    if (type != null) {
      _result.type = type;
    }
    if (category != null) {
      _result.category = category;
    }
    if (description != null) {
      _result.description = description;
    }
    if (termsAndConditions != null) {
      _result.termsAndConditions = termsAndConditions;
    }
    if (expiryDate != null) {
      _result.expiryDate = expiryDate;
    }
    if (purchaseDate != null) {
      _result.purchaseDate = purchaseDate;
    }
    if (recipientEmail != null) {
      _result.recipientEmail = recipientEmail;
    }
    if (recipientName != null) {
      _result.recipientName = recipientName;
    }
    if (message != null) {
      _result.message = message;
    }
    if (code != null) {
      _result.code = code;
    }
    if (pin != null) {
      _result.pin = pin;
    }
    if (isRedeemed != null) {
      _result.isRedeemed = isRedeemed;
    }
    if (transactionId != null) {
      _result.transactionId = transactionId;
    }
    if (availableDenominations != null) {
      _result.availableDenominations.addAll(availableDenominations);
    }
    if (qrCodeUrl != null) {
      _result.qrCodeUrl = qrCodeUrl;
    }
    if (barcodeUrl != null) {
      _result.barcodeUrl = barcodeUrl;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      _result.updatedAt = updatedAt;
    }
    if (redeemedAt != null) {
      _result.redeemedAt = redeemedAt;
    }
    if (redemptionLocation != null) {
      _result.redemptionLocation = redemptionLocation;
    }
    if (remainingBalance != null) {
      _result.remainingBalance = remainingBalance;
    }
    if (originalAmount != null) {
      _result.originalAmount = originalAmount;
    }
    return _result;
  }
  factory GiftCard.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GiftCard.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GiftCard clone() => GiftCard()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GiftCard copyWith(void Function(GiftCard) updates) => super.copyWith((message) => updates(message as GiftCard)) as GiftCard; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GiftCard create() => GiftCard._();
  GiftCard createEmptyInstance() => create();
  static $pb.PbList<GiftCard> createRepeated() => $pb.PbList<GiftCard>();
  @$core.pragma('dart2js:noInline')
  static GiftCard getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GiftCard>(create);
  static GiftCard? _defaultInstance;

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
  $core.String get brandId => $_getSZ(2);
  @$pb.TagNumber(3)
  set brandId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasBrandId() => $_has(2);
  @$pb.TagNumber(3)
  void clearBrandId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get brandName => $_getSZ(3);
  @$pb.TagNumber(4)
  set brandName($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasBrandName() => $_has(3);
  @$pb.TagNumber(4)
  void clearBrandName() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get logoUrl => $_getSZ(4);
  @$pb.TagNumber(5)
  set logoUrl($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasLogoUrl() => $_has(4);
  @$pb.TagNumber(5)
  void clearLogoUrl() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get amount => $_getN(5);
  @$pb.TagNumber(6)
  set amount($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasAmount() => $_has(5);
  @$pb.TagNumber(6)
  void clearAmount() => clearField(6);

  @$pb.TagNumber(7)
  $core.double get discountPercentage => $_getN(6);
  @$pb.TagNumber(7)
  set discountPercentage($core.double v) { $_setDouble(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasDiscountPercentage() => $_has(6);
  @$pb.TagNumber(7)
  void clearDiscountPercentage() => clearField(7);

  @$pb.TagNumber(8)
  $core.double get finalPrice => $_getN(7);
  @$pb.TagNumber(8)
  set finalPrice($core.double v) { $_setDouble(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasFinalPrice() => $_has(7);
  @$pb.TagNumber(8)
  void clearFinalPrice() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get currency => $_getSZ(8);
  @$pb.TagNumber(9)
  set currency($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasCurrency() => $_has(8);
  @$pb.TagNumber(9)
  void clearCurrency() => clearField(9);

  @$pb.TagNumber(10)
  GiftCardStatus get status => $_getN(9);
  @$pb.TagNumber(10)
  set status(GiftCardStatus v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasStatus() => $_has(9);
  @$pb.TagNumber(10)
  void clearStatus() => clearField(10);

  @$pb.TagNumber(11)
  GiftCardType get type => $_getN(10);
  @$pb.TagNumber(11)
  set type(GiftCardType v) { setField(11, v); }
  @$pb.TagNumber(11)
  $core.bool hasType() => $_has(10);
  @$pb.TagNumber(11)
  void clearType() => clearField(11);

  @$pb.TagNumber(12)
  GiftCardCategory get category => $_getN(11);
  @$pb.TagNumber(12)
  set category(GiftCardCategory v) { setField(12, v); }
  @$pb.TagNumber(12)
  $core.bool hasCategory() => $_has(11);
  @$pb.TagNumber(12)
  void clearCategory() => clearField(12);

  @$pb.TagNumber(13)
  $core.String get description => $_getSZ(12);
  @$pb.TagNumber(13)
  set description($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasDescription() => $_has(12);
  @$pb.TagNumber(13)
  void clearDescription() => clearField(13);

  @$pb.TagNumber(14)
  $core.String get termsAndConditions => $_getSZ(13);
  @$pb.TagNumber(14)
  set termsAndConditions($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasTermsAndConditions() => $_has(13);
  @$pb.TagNumber(14)
  void clearTermsAndConditions() => clearField(14);

  @$pb.TagNumber(15)
  $34.Timestamp get expiryDate => $_getN(14);
  @$pb.TagNumber(15)
  set expiryDate($34.Timestamp v) { setField(15, v); }
  @$pb.TagNumber(15)
  $core.bool hasExpiryDate() => $_has(14);
  @$pb.TagNumber(15)
  void clearExpiryDate() => clearField(15);
  @$pb.TagNumber(15)
  $34.Timestamp ensureExpiryDate() => $_ensure(14);

  @$pb.TagNumber(16)
  $34.Timestamp get purchaseDate => $_getN(15);
  @$pb.TagNumber(16)
  set purchaseDate($34.Timestamp v) { setField(16, v); }
  @$pb.TagNumber(16)
  $core.bool hasPurchaseDate() => $_has(15);
  @$pb.TagNumber(16)
  void clearPurchaseDate() => clearField(16);
  @$pb.TagNumber(16)
  $34.Timestamp ensurePurchaseDate() => $_ensure(15);

  @$pb.TagNumber(17)
  $core.String get recipientEmail => $_getSZ(16);
  @$pb.TagNumber(17)
  set recipientEmail($core.String v) { $_setString(16, v); }
  @$pb.TagNumber(17)
  $core.bool hasRecipientEmail() => $_has(16);
  @$pb.TagNumber(17)
  void clearRecipientEmail() => clearField(17);

  @$pb.TagNumber(18)
  $core.String get recipientName => $_getSZ(17);
  @$pb.TagNumber(18)
  set recipientName($core.String v) { $_setString(17, v); }
  @$pb.TagNumber(18)
  $core.bool hasRecipientName() => $_has(17);
  @$pb.TagNumber(18)
  void clearRecipientName() => clearField(18);

  @$pb.TagNumber(19)
  $core.String get message => $_getSZ(18);
  @$pb.TagNumber(19)
  set message($core.String v) { $_setString(18, v); }
  @$pb.TagNumber(19)
  $core.bool hasMessage() => $_has(18);
  @$pb.TagNumber(19)
  void clearMessage() => clearField(19);

  @$pb.TagNumber(20)
  $core.String get code => $_getSZ(19);
  @$pb.TagNumber(20)
  set code($core.String v) { $_setString(19, v); }
  @$pb.TagNumber(20)
  $core.bool hasCode() => $_has(19);
  @$pb.TagNumber(20)
  void clearCode() => clearField(20);

  @$pb.TagNumber(21)
  $core.String get pin => $_getSZ(20);
  @$pb.TagNumber(21)
  set pin($core.String v) { $_setString(20, v); }
  @$pb.TagNumber(21)
  $core.bool hasPin() => $_has(20);
  @$pb.TagNumber(21)
  void clearPin() => clearField(21);

  @$pb.TagNumber(22)
  $core.bool get isRedeemed => $_getBF(21);
  @$pb.TagNumber(22)
  set isRedeemed($core.bool v) { $_setBool(21, v); }
  @$pb.TagNumber(22)
  $core.bool hasIsRedeemed() => $_has(21);
  @$pb.TagNumber(22)
  void clearIsRedeemed() => clearField(22);

  @$pb.TagNumber(23)
  $core.String get transactionId => $_getSZ(22);
  @$pb.TagNumber(23)
  set transactionId($core.String v) { $_setString(22, v); }
  @$pb.TagNumber(23)
  $core.bool hasTransactionId() => $_has(22);
  @$pb.TagNumber(23)
  void clearTransactionId() => clearField(23);

  @$pb.TagNumber(24)
  $core.List<$core.String> get availableDenominations => $_getList(23);

  @$pb.TagNumber(25)
  $core.String get qrCodeUrl => $_getSZ(24);
  @$pb.TagNumber(25)
  set qrCodeUrl($core.String v) { $_setString(24, v); }
  @$pb.TagNumber(25)
  $core.bool hasQrCodeUrl() => $_has(24);
  @$pb.TagNumber(25)
  void clearQrCodeUrl() => clearField(25);

  @$pb.TagNumber(26)
  $core.String get barcodeUrl => $_getSZ(25);
  @$pb.TagNumber(26)
  set barcodeUrl($core.String v) { $_setString(25, v); }
  @$pb.TagNumber(26)
  $core.bool hasBarcodeUrl() => $_has(25);
  @$pb.TagNumber(26)
  void clearBarcodeUrl() => clearField(26);

  @$pb.TagNumber(27)
  $34.Timestamp get createdAt => $_getN(26);
  @$pb.TagNumber(27)
  set createdAt($34.Timestamp v) { setField(27, v); }
  @$pb.TagNumber(27)
  $core.bool hasCreatedAt() => $_has(26);
  @$pb.TagNumber(27)
  void clearCreatedAt() => clearField(27);
  @$pb.TagNumber(27)
  $34.Timestamp ensureCreatedAt() => $_ensure(26);

  @$pb.TagNumber(28)
  $34.Timestamp get updatedAt => $_getN(27);
  @$pb.TagNumber(28)
  set updatedAt($34.Timestamp v) { setField(28, v); }
  @$pb.TagNumber(28)
  $core.bool hasUpdatedAt() => $_has(27);
  @$pb.TagNumber(28)
  void clearUpdatedAt() => clearField(28);
  @$pb.TagNumber(28)
  $34.Timestamp ensureUpdatedAt() => $_ensure(27);

  @$pb.TagNumber(29)
  $34.Timestamp get redeemedAt => $_getN(28);
  @$pb.TagNumber(29)
  set redeemedAt($34.Timestamp v) { setField(29, v); }
  @$pb.TagNumber(29)
  $core.bool hasRedeemedAt() => $_has(28);
  @$pb.TagNumber(29)
  void clearRedeemedAt() => clearField(29);
  @$pb.TagNumber(29)
  $34.Timestamp ensureRedeemedAt() => $_ensure(28);

  @$pb.TagNumber(30)
  $core.String get redemptionLocation => $_getSZ(29);
  @$pb.TagNumber(30)
  set redemptionLocation($core.String v) { $_setString(29, v); }
  @$pb.TagNumber(30)
  $core.bool hasRedemptionLocation() => $_has(29);
  @$pb.TagNumber(30)
  void clearRedemptionLocation() => clearField(30);

  @$pb.TagNumber(31)
  $core.double get remainingBalance => $_getN(30);
  @$pb.TagNumber(31)
  set remainingBalance($core.double v) { $_setDouble(30, v); }
  @$pb.TagNumber(31)
  $core.bool hasRemainingBalance() => $_has(30);
  @$pb.TagNumber(31)
  void clearRemainingBalance() => clearField(31);

  @$pb.TagNumber(32)
  $core.double get originalAmount => $_getN(31);
  @$pb.TagNumber(32)
  set originalAmount($core.double v) { $_setDouble(31, v); }
  @$pb.TagNumber(32)
  $core.bool hasOriginalAmount() => $_has(31);
  @$pb.TagNumber(32)
  void clearOriginalAmount() => clearField(32);
}

class GiftCardTransaction extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GiftCardTransaction', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcard'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'giftCardId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOM<$34.Timestamp>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionDate', subBuilder: $34.Timestamp.create)
    ..e<TransactionType>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionType', $pb.PbFieldType.OE, defaultOrMaker: TransactionType.TRANSACTION_TYPE_UNSPECIFIED, valueOf: TransactionType.valueOf, enumValues: TransactionType.values)
    ..e<GiftCardStatus>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: GiftCardStatus.GIFTCARD_STATUS_UNSPECIFIED, valueOf: GiftCardStatus.valueOf, enumValues: GiftCardStatus.values)
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'failureReason')
    ..e<PaymentMethod>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paymentMethod', $pb.PbFieldType.OE, defaultOrMaker: PaymentMethod.PAYMENT_METHOD_UNSPECIFIED, valueOf: PaymentMethod.valueOf, enumValues: PaymentMethod.values)
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paymentReference')
    ..aOS(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'receiptUrl')
    ..aOS(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recipientEmail')
    ..aOS(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recipientName')
    ..aOM<$34.Timestamp>(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $34.Timestamp.create)
    ..hasRequiredFields = false
  ;

  GiftCardTransaction._() : super();
  factory GiftCardTransaction({
    $core.String? id,
    $core.String? giftCardId,
    $core.String? userId,
    $core.double? amount,
    $core.String? currency,
    $34.Timestamp? transactionDate,
    TransactionType? transactionType,
    GiftCardStatus? status,
    $core.String? failureReason,
    PaymentMethod? paymentMethod,
    $core.String? paymentReference,
    $core.String? receiptUrl,
    $core.String? recipientEmail,
    $core.String? recipientName,
    $34.Timestamp? createdAt,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (giftCardId != null) {
      _result.giftCardId = giftCardId;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (transactionDate != null) {
      _result.transactionDate = transactionDate;
    }
    if (transactionType != null) {
      _result.transactionType = transactionType;
    }
    if (status != null) {
      _result.status = status;
    }
    if (failureReason != null) {
      _result.failureReason = failureReason;
    }
    if (paymentMethod != null) {
      _result.paymentMethod = paymentMethod;
    }
    if (paymentReference != null) {
      _result.paymentReference = paymentReference;
    }
    if (receiptUrl != null) {
      _result.receiptUrl = receiptUrl;
    }
    if (recipientEmail != null) {
      _result.recipientEmail = recipientEmail;
    }
    if (recipientName != null) {
      _result.recipientName = recipientName;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    return _result;
  }
  factory GiftCardTransaction.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GiftCardTransaction.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GiftCardTransaction clone() => GiftCardTransaction()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GiftCardTransaction copyWith(void Function(GiftCardTransaction) updates) => super.copyWith((message) => updates(message as GiftCardTransaction)) as GiftCardTransaction; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GiftCardTransaction create() => GiftCardTransaction._();
  GiftCardTransaction createEmptyInstance() => create();
  static $pb.PbList<GiftCardTransaction> createRepeated() => $pb.PbList<GiftCardTransaction>();
  @$core.pragma('dart2js:noInline')
  static GiftCardTransaction getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GiftCardTransaction>(create);
  static GiftCardTransaction? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get giftCardId => $_getSZ(1);
  @$pb.TagNumber(2)
  set giftCardId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasGiftCardId() => $_has(1);
  @$pb.TagNumber(2)
  void clearGiftCardId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get userId => $_getSZ(2);
  @$pb.TagNumber(3)
  set userId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasUserId() => $_has(2);
  @$pb.TagNumber(3)
  void clearUserId() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get amount => $_getN(3);
  @$pb.TagNumber(4)
  set amount($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearAmount() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get currency => $_getSZ(4);
  @$pb.TagNumber(5)
  set currency($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasCurrency() => $_has(4);
  @$pb.TagNumber(5)
  void clearCurrency() => clearField(5);

  @$pb.TagNumber(6)
  $34.Timestamp get transactionDate => $_getN(5);
  @$pb.TagNumber(6)
  set transactionDate($34.Timestamp v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasTransactionDate() => $_has(5);
  @$pb.TagNumber(6)
  void clearTransactionDate() => clearField(6);
  @$pb.TagNumber(6)
  $34.Timestamp ensureTransactionDate() => $_ensure(5);

  @$pb.TagNumber(7)
  TransactionType get transactionType => $_getN(6);
  @$pb.TagNumber(7)
  set transactionType(TransactionType v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasTransactionType() => $_has(6);
  @$pb.TagNumber(7)
  void clearTransactionType() => clearField(7);

  @$pb.TagNumber(8)
  GiftCardStatus get status => $_getN(7);
  @$pb.TagNumber(8)
  set status(GiftCardStatus v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasStatus() => $_has(7);
  @$pb.TagNumber(8)
  void clearStatus() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get failureReason => $_getSZ(8);
  @$pb.TagNumber(9)
  set failureReason($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasFailureReason() => $_has(8);
  @$pb.TagNumber(9)
  void clearFailureReason() => clearField(9);

  @$pb.TagNumber(10)
  PaymentMethod get paymentMethod => $_getN(9);
  @$pb.TagNumber(10)
  set paymentMethod(PaymentMethod v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasPaymentMethod() => $_has(9);
  @$pb.TagNumber(10)
  void clearPaymentMethod() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get paymentReference => $_getSZ(10);
  @$pb.TagNumber(11)
  set paymentReference($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasPaymentReference() => $_has(10);
  @$pb.TagNumber(11)
  void clearPaymentReference() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get receiptUrl => $_getSZ(11);
  @$pb.TagNumber(12)
  set receiptUrl($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasReceiptUrl() => $_has(11);
  @$pb.TagNumber(12)
  void clearReceiptUrl() => clearField(12);

  @$pb.TagNumber(13)
  $core.String get recipientEmail => $_getSZ(12);
  @$pb.TagNumber(13)
  set recipientEmail($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasRecipientEmail() => $_has(12);
  @$pb.TagNumber(13)
  void clearRecipientEmail() => clearField(13);

  @$pb.TagNumber(14)
  $core.String get recipientName => $_getSZ(13);
  @$pb.TagNumber(14)
  set recipientName($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasRecipientName() => $_has(13);
  @$pb.TagNumber(14)
  void clearRecipientName() => clearField(14);

  @$pb.TagNumber(15)
  $34.Timestamp get createdAt => $_getN(14);
  @$pb.TagNumber(15)
  set createdAt($34.Timestamp v) { setField(15, v); }
  @$pb.TagNumber(15)
  $core.bool hasCreatedAt() => $_has(14);
  @$pb.TagNumber(15)
  void clearCreatedAt() => clearField(15);
  @$pb.TagNumber(15)
  $34.Timestamp ensureCreatedAt() => $_ensure(14);
}

class Statistics extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Statistics', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcard'), createEmptyInstance: create)
    ..aInt64(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalCards')
    ..aInt64(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'activeCards')
    ..aInt64(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'usedCards')
    ..aInt64(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pendingCards')
    ..aInt64(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'expiredCards')
    ..a<$core.double>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalValue', $pb.PbFieldType.OD)
    ..a<$core.double>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalSpent', $pb.PbFieldType.OD)
    ..a<$core.double>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalSaved', $pb.PbFieldType.OD)
    ..pc<GiftCard>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recentCards', $pb.PbFieldType.PM, subBuilder: GiftCard.create)
    ..pc<GiftCardTransaction>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recentTransactions', $pb.PbFieldType.PM, subBuilder: GiftCardTransaction.create)
    ..hasRequiredFields = false
  ;

  Statistics._() : super();
  factory Statistics({
    $fixnum.Int64? totalCards,
    $fixnum.Int64? activeCards,
    $fixnum.Int64? usedCards,
    $fixnum.Int64? pendingCards,
    $fixnum.Int64? expiredCards,
    $core.double? totalValue,
    $core.double? totalSpent,
    $core.double? totalSaved,
    $core.Iterable<GiftCard>? recentCards,
    $core.Iterable<GiftCardTransaction>? recentTransactions,
  }) {
    final _result = create();
    if (totalCards != null) {
      _result.totalCards = totalCards;
    }
    if (activeCards != null) {
      _result.activeCards = activeCards;
    }
    if (usedCards != null) {
      _result.usedCards = usedCards;
    }
    if (pendingCards != null) {
      _result.pendingCards = pendingCards;
    }
    if (expiredCards != null) {
      _result.expiredCards = expiredCards;
    }
    if (totalValue != null) {
      _result.totalValue = totalValue;
    }
    if (totalSpent != null) {
      _result.totalSpent = totalSpent;
    }
    if (totalSaved != null) {
      _result.totalSaved = totalSaved;
    }
    if (recentCards != null) {
      _result.recentCards.addAll(recentCards);
    }
    if (recentTransactions != null) {
      _result.recentTransactions.addAll(recentTransactions);
    }
    return _result;
  }
  factory Statistics.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Statistics.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Statistics clone() => Statistics()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Statistics copyWith(void Function(Statistics) updates) => super.copyWith((message) => updates(message as Statistics)) as Statistics; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Statistics create() => Statistics._();
  Statistics createEmptyInstance() => create();
  static $pb.PbList<Statistics> createRepeated() => $pb.PbList<Statistics>();
  @$core.pragma('dart2js:noInline')
  static Statistics getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Statistics>(create);
  static Statistics? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get totalCards => $_getI64(0);
  @$pb.TagNumber(1)
  set totalCards($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTotalCards() => $_has(0);
  @$pb.TagNumber(1)
  void clearTotalCards() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get activeCards => $_getI64(1);
  @$pb.TagNumber(2)
  set activeCards($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasActiveCards() => $_has(1);
  @$pb.TagNumber(2)
  void clearActiveCards() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get usedCards => $_getI64(2);
  @$pb.TagNumber(3)
  set usedCards($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasUsedCards() => $_has(2);
  @$pb.TagNumber(3)
  void clearUsedCards() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get pendingCards => $_getI64(3);
  @$pb.TagNumber(4)
  set pendingCards($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPendingCards() => $_has(3);
  @$pb.TagNumber(4)
  void clearPendingCards() => clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get expiredCards => $_getI64(4);
  @$pb.TagNumber(5)
  set expiredCards($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasExpiredCards() => $_has(4);
  @$pb.TagNumber(5)
  void clearExpiredCards() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get totalValue => $_getN(5);
  @$pb.TagNumber(6)
  set totalValue($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasTotalValue() => $_has(5);
  @$pb.TagNumber(6)
  void clearTotalValue() => clearField(6);

  @$pb.TagNumber(7)
  $core.double get totalSpent => $_getN(6);
  @$pb.TagNumber(7)
  set totalSpent($core.double v) { $_setDouble(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasTotalSpent() => $_has(6);
  @$pb.TagNumber(7)
  void clearTotalSpent() => clearField(7);

  @$pb.TagNumber(8)
  $core.double get totalSaved => $_getN(7);
  @$pb.TagNumber(8)
  set totalSaved($core.double v) { $_setDouble(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasTotalSaved() => $_has(7);
  @$pb.TagNumber(8)
  void clearTotalSaved() => clearField(8);

  @$pb.TagNumber(9)
  $core.List<GiftCard> get recentCards => $_getList(8);

  @$pb.TagNumber(10)
  $core.List<GiftCardTransaction> get recentTransactions => $_getList(9);
}

class GetBrandsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetBrandsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcard'), createEmptyInstance: create)
    ..e<GiftCardCategory>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'category', $pb.PbFieldType.OE, defaultOrMaker: GiftCardCategory.GIFTCARD_CATEGORY_UNSPECIFIED, valueOf: GiftCardCategory.valueOf, enumValues: GiftCardCategory.values)
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'popularOnly')
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetBrandsRequest._() : super();
  factory GetBrandsRequest({
    GiftCardCategory? category,
    $core.bool? popularOnly,
    $core.int? page,
    $core.int? limit,
  }) {
    final _result = create();
    if (category != null) {
      _result.category = category;
    }
    if (popularOnly != null) {
      _result.popularOnly = popularOnly;
    }
    if (page != null) {
      _result.page = page;
    }
    if (limit != null) {
      _result.limit = limit;
    }
    return _result;
  }
  factory GetBrandsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetBrandsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetBrandsRequest clone() => GetBrandsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetBrandsRequest copyWith(void Function(GetBrandsRequest) updates) => super.copyWith((message) => updates(message as GetBrandsRequest)) as GetBrandsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetBrandsRequest create() => GetBrandsRequest._();
  GetBrandsRequest createEmptyInstance() => create();
  static $pb.PbList<GetBrandsRequest> createRepeated() => $pb.PbList<GetBrandsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetBrandsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetBrandsRequest>(create);
  static GetBrandsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  GiftCardCategory get category => $_getN(0);
  @$pb.TagNumber(1)
  set category(GiftCardCategory v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasCategory() => $_has(0);
  @$pb.TagNumber(1)
  void clearCategory() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get popularOnly => $_getBF(1);
  @$pb.TagNumber(2)
  set popularOnly($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPopularOnly() => $_has(1);
  @$pb.TagNumber(2)
  void clearPopularOnly() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get page => $_getIZ(2);
  @$pb.TagNumber(3)
  set page($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPage() => $_has(2);
  @$pb.TagNumber(3)
  void clearPage() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get limit => $_getIZ(3);
  @$pb.TagNumber(4)
  set limit($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasLimit() => $_has(3);
  @$pb.TagNumber(4)
  void clearLimit() => clearField(4);
}

class GetBrandsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetBrandsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcard'), createEmptyInstance: create)
    ..pc<GiftCardBrand>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'brands', $pb.PbFieldType.PM, subBuilder: GiftCardBrand.create)
    ..aInt64(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'total')
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetBrandsResponse._() : super();
  factory GetBrandsResponse({
    $core.Iterable<GiftCardBrand>? brands,
    $fixnum.Int64? total,
    $core.int? page,
    $core.int? limit,
  }) {
    final _result = create();
    if (brands != null) {
      _result.brands.addAll(brands);
    }
    if (total != null) {
      _result.total = total;
    }
    if (page != null) {
      _result.page = page;
    }
    if (limit != null) {
      _result.limit = limit;
    }
    return _result;
  }
  factory GetBrandsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetBrandsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetBrandsResponse clone() => GetBrandsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetBrandsResponse copyWith(void Function(GetBrandsResponse) updates) => super.copyWith((message) => updates(message as GetBrandsResponse)) as GetBrandsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetBrandsResponse create() => GetBrandsResponse._();
  GetBrandsResponse createEmptyInstance() => create();
  static $pb.PbList<GetBrandsResponse> createRepeated() => $pb.PbList<GetBrandsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetBrandsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetBrandsResponse>(create);
  static GetBrandsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<GiftCardBrand> get brands => $_getList(0);

  @$pb.TagNumber(2)
  $fixnum.Int64 get total => $_getI64(1);
  @$pb.TagNumber(2)
  set total($fixnum.Int64 v) { $_setInt64(1, v); }
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
  $core.int get limit => $_getIZ(3);
  @$pb.TagNumber(4)
  set limit($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasLimit() => $_has(3);
  @$pb.TagNumber(4)
  void clearLimit() => clearField(4);
}

class GetBrandByIdRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetBrandByIdRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcard'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'brandId')
    ..hasRequiredFields = false
  ;

  GetBrandByIdRequest._() : super();
  factory GetBrandByIdRequest({
    $core.String? brandId,
  }) {
    final _result = create();
    if (brandId != null) {
      _result.brandId = brandId;
    }
    return _result;
  }
  factory GetBrandByIdRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetBrandByIdRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetBrandByIdRequest clone() => GetBrandByIdRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetBrandByIdRequest copyWith(void Function(GetBrandByIdRequest) updates) => super.copyWith((message) => updates(message as GetBrandByIdRequest)) as GetBrandByIdRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetBrandByIdRequest create() => GetBrandByIdRequest._();
  GetBrandByIdRequest createEmptyInstance() => create();
  static $pb.PbList<GetBrandByIdRequest> createRepeated() => $pb.PbList<GetBrandByIdRequest>();
  @$core.pragma('dart2js:noInline')
  static GetBrandByIdRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetBrandByIdRequest>(create);
  static GetBrandByIdRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get brandId => $_getSZ(0);
  @$pb.TagNumber(1)
  set brandId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasBrandId() => $_has(0);
  @$pb.TagNumber(1)
  void clearBrandId() => clearField(1);
}

class GetBrandByIdResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetBrandByIdResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcard'), createEmptyInstance: create)
    ..aOM<GiftCardBrand>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'brand', subBuilder: GiftCardBrand.create)
    ..hasRequiredFields = false
  ;

  GetBrandByIdResponse._() : super();
  factory GetBrandByIdResponse({
    GiftCardBrand? brand,
  }) {
    final _result = create();
    if (brand != null) {
      _result.brand = brand;
    }
    return _result;
  }
  factory GetBrandByIdResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetBrandByIdResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetBrandByIdResponse clone() => GetBrandByIdResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetBrandByIdResponse copyWith(void Function(GetBrandByIdResponse) updates) => super.copyWith((message) => updates(message as GetBrandByIdResponse)) as GetBrandByIdResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetBrandByIdResponse create() => GetBrandByIdResponse._();
  GetBrandByIdResponse createEmptyInstance() => create();
  static $pb.PbList<GetBrandByIdResponse> createRepeated() => $pb.PbList<GetBrandByIdResponse>();
  @$core.pragma('dart2js:noInline')
  static GetBrandByIdResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetBrandByIdResponse>(create);
  static GetBrandByIdResponse? _defaultInstance;

  @$pb.TagNumber(1)
  GiftCardBrand get brand => $_getN(0);
  @$pb.TagNumber(1)
  set brand(GiftCardBrand v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasBrand() => $_has(0);
  @$pb.TagNumber(1)
  void clearBrand() => clearField(1);
  @$pb.TagNumber(1)
  GiftCardBrand ensureBrand() => $_ensure(0);
}

class SearchBrandsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SearchBrandsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcard'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'query')
    ..e<GiftCardCategory>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'category', $pb.PbFieldType.OE, defaultOrMaker: GiftCardCategory.GIFTCARD_CATEGORY_UNSPECIFIED, valueOf: GiftCardCategory.valueOf, enumValues: GiftCardCategory.values)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  SearchBrandsRequest._() : super();
  factory SearchBrandsRequest({
    $core.String? query,
    GiftCardCategory? category,
    $core.int? page,
    $core.int? limit,
  }) {
    final _result = create();
    if (query != null) {
      _result.query = query;
    }
    if (category != null) {
      _result.category = category;
    }
    if (page != null) {
      _result.page = page;
    }
    if (limit != null) {
      _result.limit = limit;
    }
    return _result;
  }
  factory SearchBrandsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SearchBrandsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SearchBrandsRequest clone() => SearchBrandsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SearchBrandsRequest copyWith(void Function(SearchBrandsRequest) updates) => super.copyWith((message) => updates(message as SearchBrandsRequest)) as SearchBrandsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SearchBrandsRequest create() => SearchBrandsRequest._();
  SearchBrandsRequest createEmptyInstance() => create();
  static $pb.PbList<SearchBrandsRequest> createRepeated() => $pb.PbList<SearchBrandsRequest>();
  @$core.pragma('dart2js:noInline')
  static SearchBrandsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SearchBrandsRequest>(create);
  static SearchBrandsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get query => $_getSZ(0);
  @$pb.TagNumber(1)
  set query($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasQuery() => $_has(0);
  @$pb.TagNumber(1)
  void clearQuery() => clearField(1);

  @$pb.TagNumber(2)
  GiftCardCategory get category => $_getN(1);
  @$pb.TagNumber(2)
  set category(GiftCardCategory v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasCategory() => $_has(1);
  @$pb.TagNumber(2)
  void clearCategory() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get page => $_getIZ(2);
  @$pb.TagNumber(3)
  set page($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPage() => $_has(2);
  @$pb.TagNumber(3)
  void clearPage() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get limit => $_getIZ(3);
  @$pb.TagNumber(4)
  set limit($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasLimit() => $_has(3);
  @$pb.TagNumber(4)
  void clearLimit() => clearField(4);
}

class SearchBrandsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SearchBrandsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcard'), createEmptyInstance: create)
    ..pc<GiftCardBrand>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'brands', $pb.PbFieldType.PM, subBuilder: GiftCardBrand.create)
    ..aInt64(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'total')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'query')
    ..hasRequiredFields = false
  ;

  SearchBrandsResponse._() : super();
  factory SearchBrandsResponse({
    $core.Iterable<GiftCardBrand>? brands,
    $fixnum.Int64? total,
    $core.String? query,
  }) {
    final _result = create();
    if (brands != null) {
      _result.brands.addAll(brands);
    }
    if (total != null) {
      _result.total = total;
    }
    if (query != null) {
      _result.query = query;
    }
    return _result;
  }
  factory SearchBrandsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SearchBrandsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SearchBrandsResponse clone() => SearchBrandsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SearchBrandsResponse copyWith(void Function(SearchBrandsResponse) updates) => super.copyWith((message) => updates(message as SearchBrandsResponse)) as SearchBrandsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SearchBrandsResponse create() => SearchBrandsResponse._();
  SearchBrandsResponse createEmptyInstance() => create();
  static $pb.PbList<SearchBrandsResponse> createRepeated() => $pb.PbList<SearchBrandsResponse>();
  @$core.pragma('dart2js:noInline')
  static SearchBrandsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SearchBrandsResponse>(create);
  static SearchBrandsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<GiftCardBrand> get brands => $_getList(0);

  @$pb.TagNumber(2)
  $fixnum.Int64 get total => $_getI64(1);
  @$pb.TagNumber(2)
  set total($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get query => $_getSZ(2);
  @$pb.TagNumber(3)
  set query($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasQuery() => $_has(2);
  @$pb.TagNumber(3)
  void clearQuery() => clearField(3);
}

class GetUserGiftCardsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetUserGiftCardsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcard'), createEmptyInstance: create)
    ..e<GiftCardStatus>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: GiftCardStatus.GIFTCARD_STATUS_UNSPECIFIED, valueOf: GiftCardStatus.valueOf, enumValues: GiftCardStatus.values)
    ..e<GiftCardCategory>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'category', $pb.PbFieldType.OE, defaultOrMaker: GiftCardCategory.GIFTCARD_CATEGORY_UNSPECIFIED, valueOf: GiftCardCategory.valueOf, enumValues: GiftCardCategory.values)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'searchQuery')
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetUserGiftCardsRequest._() : super();
  factory GetUserGiftCardsRequest({
    GiftCardStatus? status,
    GiftCardCategory? category,
    $core.String? searchQuery,
    $core.int? page,
    $core.int? limit,
  }) {
    final _result = create();
    if (status != null) {
      _result.status = status;
    }
    if (category != null) {
      _result.category = category;
    }
    if (searchQuery != null) {
      _result.searchQuery = searchQuery;
    }
    if (page != null) {
      _result.page = page;
    }
    if (limit != null) {
      _result.limit = limit;
    }
    return _result;
  }
  factory GetUserGiftCardsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserGiftCardsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUserGiftCardsRequest clone() => GetUserGiftCardsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUserGiftCardsRequest copyWith(void Function(GetUserGiftCardsRequest) updates) => super.copyWith((message) => updates(message as GetUserGiftCardsRequest)) as GetUserGiftCardsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetUserGiftCardsRequest create() => GetUserGiftCardsRequest._();
  GetUserGiftCardsRequest createEmptyInstance() => create();
  static $pb.PbList<GetUserGiftCardsRequest> createRepeated() => $pb.PbList<GetUserGiftCardsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetUserGiftCardsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetUserGiftCardsRequest>(create);
  static GetUserGiftCardsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  GiftCardStatus get status => $_getN(0);
  @$pb.TagNumber(1)
  set status(GiftCardStatus v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => clearField(1);

  @$pb.TagNumber(2)
  GiftCardCategory get category => $_getN(1);
  @$pb.TagNumber(2)
  set category(GiftCardCategory v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasCategory() => $_has(1);
  @$pb.TagNumber(2)
  void clearCategory() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get searchQuery => $_getSZ(2);
  @$pb.TagNumber(3)
  set searchQuery($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSearchQuery() => $_has(2);
  @$pb.TagNumber(3)
  void clearSearchQuery() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get page => $_getIZ(3);
  @$pb.TagNumber(4)
  set page($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPage() => $_has(3);
  @$pb.TagNumber(4)
  void clearPage() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get limit => $_getIZ(4);
  @$pb.TagNumber(5)
  set limit($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasLimit() => $_has(4);
  @$pb.TagNumber(5)
  void clearLimit() => clearField(5);
}

class GetUserGiftCardsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetUserGiftCardsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcard'), createEmptyInstance: create)
    ..pc<GiftCard>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'giftCards', $pb.PbFieldType.PM, subBuilder: GiftCard.create)
    ..aInt64(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'total')
    ..aOM<Statistics>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'statistics', subBuilder: Statistics.create)
    ..hasRequiredFields = false
  ;

  GetUserGiftCardsResponse._() : super();
  factory GetUserGiftCardsResponse({
    $core.Iterable<GiftCard>? giftCards,
    $fixnum.Int64? total,
    Statistics? statistics,
  }) {
    final _result = create();
    if (giftCards != null) {
      _result.giftCards.addAll(giftCards);
    }
    if (total != null) {
      _result.total = total;
    }
    if (statistics != null) {
      _result.statistics = statistics;
    }
    return _result;
  }
  factory GetUserGiftCardsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserGiftCardsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUserGiftCardsResponse clone() => GetUserGiftCardsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUserGiftCardsResponse copyWith(void Function(GetUserGiftCardsResponse) updates) => super.copyWith((message) => updates(message as GetUserGiftCardsResponse)) as GetUserGiftCardsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetUserGiftCardsResponse create() => GetUserGiftCardsResponse._();
  GetUserGiftCardsResponse createEmptyInstance() => create();
  static $pb.PbList<GetUserGiftCardsResponse> createRepeated() => $pb.PbList<GetUserGiftCardsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetUserGiftCardsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetUserGiftCardsResponse>(create);
  static GetUserGiftCardsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<GiftCard> get giftCards => $_getList(0);

  @$pb.TagNumber(2)
  $fixnum.Int64 get total => $_getI64(1);
  @$pb.TagNumber(2)
  set total($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => clearField(2);

  @$pb.TagNumber(3)
  Statistics get statistics => $_getN(2);
  @$pb.TagNumber(3)
  set statistics(Statistics v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasStatistics() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatistics() => clearField(3);
  @$pb.TagNumber(3)
  Statistics ensureStatistics() => $_ensure(2);
}

class GetGiftCardByIdRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetGiftCardByIdRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcard'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'giftCardId')
    ..hasRequiredFields = false
  ;

  GetGiftCardByIdRequest._() : super();
  factory GetGiftCardByIdRequest({
    $core.String? giftCardId,
  }) {
    final _result = create();
    if (giftCardId != null) {
      _result.giftCardId = giftCardId;
    }
    return _result;
  }
  factory GetGiftCardByIdRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetGiftCardByIdRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetGiftCardByIdRequest clone() => GetGiftCardByIdRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetGiftCardByIdRequest copyWith(void Function(GetGiftCardByIdRequest) updates) => super.copyWith((message) => updates(message as GetGiftCardByIdRequest)) as GetGiftCardByIdRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetGiftCardByIdRequest create() => GetGiftCardByIdRequest._();
  GetGiftCardByIdRequest createEmptyInstance() => create();
  static $pb.PbList<GetGiftCardByIdRequest> createRepeated() => $pb.PbList<GetGiftCardByIdRequest>();
  @$core.pragma('dart2js:noInline')
  static GetGiftCardByIdRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetGiftCardByIdRequest>(create);
  static GetGiftCardByIdRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get giftCardId => $_getSZ(0);
  @$pb.TagNumber(1)
  set giftCardId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasGiftCardId() => $_has(0);
  @$pb.TagNumber(1)
  void clearGiftCardId() => clearField(1);
}

class GetGiftCardByIdResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetGiftCardByIdResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcard'), createEmptyInstance: create)
    ..aOM<GiftCard>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'giftCard', subBuilder: GiftCard.create)
    ..hasRequiredFields = false
  ;

  GetGiftCardByIdResponse._() : super();
  factory GetGiftCardByIdResponse({
    GiftCard? giftCard,
  }) {
    final _result = create();
    if (giftCard != null) {
      _result.giftCard = giftCard;
    }
    return _result;
  }
  factory GetGiftCardByIdResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetGiftCardByIdResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetGiftCardByIdResponse clone() => GetGiftCardByIdResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetGiftCardByIdResponse copyWith(void Function(GetGiftCardByIdResponse) updates) => super.copyWith((message) => updates(message as GetGiftCardByIdResponse)) as GetGiftCardByIdResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetGiftCardByIdResponse create() => GetGiftCardByIdResponse._();
  GetGiftCardByIdResponse createEmptyInstance() => create();
  static $pb.PbList<GetGiftCardByIdResponse> createRepeated() => $pb.PbList<GetGiftCardByIdResponse>();
  @$core.pragma('dart2js:noInline')
  static GetGiftCardByIdResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetGiftCardByIdResponse>(create);
  static GetGiftCardByIdResponse? _defaultInstance;

  @$pb.TagNumber(1)
  GiftCard get giftCard => $_getN(0);
  @$pb.TagNumber(1)
  set giftCard(GiftCard v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasGiftCard() => $_has(0);
  @$pb.TagNumber(1)
  void clearGiftCard() => clearField(1);
  @$pb.TagNumber(1)
  GiftCard ensureGiftCard() => $_ensure(0);
}

class PurchaseGiftCardRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PurchaseGiftCardRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcard'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'brandId')
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..e<PaymentMethod>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paymentMethod', $pb.PbFieldType.OE, defaultOrMaker: PaymentMethod.PAYMENT_METHOD_UNSPECIFIED, valueOf: PaymentMethod.valueOf, enumValues: PaymentMethod.values)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recipientEmail')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recipientName')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOB(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isForSelf')
    ..aOM<$34.Timestamp>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'scheduledDelivery', subBuilder: $34.Timestamp.create)
    ..hasRequiredFields = false
  ;

  PurchaseGiftCardRequest._() : super();
  factory PurchaseGiftCardRequest({
    $core.String? brandId,
    $core.double? amount,
    $core.String? currency,
    PaymentMethod? paymentMethod,
    $core.String? recipientEmail,
    $core.String? recipientName,
    $core.String? message,
    $core.bool? isForSelf,
    $34.Timestamp? scheduledDelivery,
  }) {
    final _result = create();
    if (brandId != null) {
      _result.brandId = brandId;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (paymentMethod != null) {
      _result.paymentMethod = paymentMethod;
    }
    if (recipientEmail != null) {
      _result.recipientEmail = recipientEmail;
    }
    if (recipientName != null) {
      _result.recipientName = recipientName;
    }
    if (message != null) {
      _result.message = message;
    }
    if (isForSelf != null) {
      _result.isForSelf = isForSelf;
    }
    if (scheduledDelivery != null) {
      _result.scheduledDelivery = scheduledDelivery;
    }
    return _result;
  }
  factory PurchaseGiftCardRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PurchaseGiftCardRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PurchaseGiftCardRequest clone() => PurchaseGiftCardRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PurchaseGiftCardRequest copyWith(void Function(PurchaseGiftCardRequest) updates) => super.copyWith((message) => updates(message as PurchaseGiftCardRequest)) as PurchaseGiftCardRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PurchaseGiftCardRequest create() => PurchaseGiftCardRequest._();
  PurchaseGiftCardRequest createEmptyInstance() => create();
  static $pb.PbList<PurchaseGiftCardRequest> createRepeated() => $pb.PbList<PurchaseGiftCardRequest>();
  @$core.pragma('dart2js:noInline')
  static PurchaseGiftCardRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PurchaseGiftCardRequest>(create);
  static PurchaseGiftCardRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get brandId => $_getSZ(0);
  @$pb.TagNumber(1)
  set brandId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasBrandId() => $_has(0);
  @$pb.TagNumber(1)
  void clearBrandId() => clearField(1);

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
  PaymentMethod get paymentMethod => $_getN(3);
  @$pb.TagNumber(4)
  set paymentMethod(PaymentMethod v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasPaymentMethod() => $_has(3);
  @$pb.TagNumber(4)
  void clearPaymentMethod() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get recipientEmail => $_getSZ(4);
  @$pb.TagNumber(5)
  set recipientEmail($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasRecipientEmail() => $_has(4);
  @$pb.TagNumber(5)
  void clearRecipientEmail() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get recipientName => $_getSZ(5);
  @$pb.TagNumber(6)
  set recipientName($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasRecipientName() => $_has(5);
  @$pb.TagNumber(6)
  void clearRecipientName() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get message => $_getSZ(6);
  @$pb.TagNumber(7)
  set message($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasMessage() => $_has(6);
  @$pb.TagNumber(7)
  void clearMessage() => clearField(7);

  @$pb.TagNumber(8)
  $core.bool get isForSelf => $_getBF(7);
  @$pb.TagNumber(8)
  set isForSelf($core.bool v) { $_setBool(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasIsForSelf() => $_has(7);
  @$pb.TagNumber(8)
  void clearIsForSelf() => clearField(8);

  @$pb.TagNumber(9)
  $34.Timestamp get scheduledDelivery => $_getN(8);
  @$pb.TagNumber(9)
  set scheduledDelivery($34.Timestamp v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasScheduledDelivery() => $_has(8);
  @$pb.TagNumber(9)
  void clearScheduledDelivery() => clearField(9);
  @$pb.TagNumber(9)
  $34.Timestamp ensureScheduledDelivery() => $_ensure(8);
}

class PurchaseGiftCardResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PurchaseGiftCardResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcard'), createEmptyInstance: create)
    ..aOM<GiftCard>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'giftCard', subBuilder: GiftCard.create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'receiptUrl')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionId')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  PurchaseGiftCardResponse._() : super();
  factory PurchaseGiftCardResponse({
    GiftCard? giftCard,
    $core.String? receiptUrl,
    $core.String? transactionId,
    $core.String? message,
  }) {
    final _result = create();
    if (giftCard != null) {
      _result.giftCard = giftCard;
    }
    if (receiptUrl != null) {
      _result.receiptUrl = receiptUrl;
    }
    if (transactionId != null) {
      _result.transactionId = transactionId;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory PurchaseGiftCardResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PurchaseGiftCardResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PurchaseGiftCardResponse clone() => PurchaseGiftCardResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PurchaseGiftCardResponse copyWith(void Function(PurchaseGiftCardResponse) updates) => super.copyWith((message) => updates(message as PurchaseGiftCardResponse)) as PurchaseGiftCardResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PurchaseGiftCardResponse create() => PurchaseGiftCardResponse._();
  PurchaseGiftCardResponse createEmptyInstance() => create();
  static $pb.PbList<PurchaseGiftCardResponse> createRepeated() => $pb.PbList<PurchaseGiftCardResponse>();
  @$core.pragma('dart2js:noInline')
  static PurchaseGiftCardResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PurchaseGiftCardResponse>(create);
  static PurchaseGiftCardResponse? _defaultInstance;

  @$pb.TagNumber(1)
  GiftCard get giftCard => $_getN(0);
  @$pb.TagNumber(1)
  set giftCard(GiftCard v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasGiftCard() => $_has(0);
  @$pb.TagNumber(1)
  void clearGiftCard() => clearField(1);
  @$pb.TagNumber(1)
  GiftCard ensureGiftCard() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get receiptUrl => $_getSZ(1);
  @$pb.TagNumber(2)
  set receiptUrl($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasReceiptUrl() => $_has(1);
  @$pb.TagNumber(2)
  void clearReceiptUrl() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get transactionId => $_getSZ(2);
  @$pb.TagNumber(3)
  set transactionId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTransactionId() => $_has(2);
  @$pb.TagNumber(3)
  void clearTransactionId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get message => $_getSZ(3);
  @$pb.TagNumber(4)
  set message($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMessage() => $_has(3);
  @$pb.TagNumber(4)
  void clearMessage() => clearField(4);
}

class ValidatePurchaseRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ValidatePurchaseRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcard'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'brandId')
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..e<PaymentMethod>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paymentMethod', $pb.PbFieldType.OE, defaultOrMaker: PaymentMethod.PAYMENT_METHOD_UNSPECIFIED, valueOf: PaymentMethod.valueOf, enumValues: PaymentMethod.values)
    ..hasRequiredFields = false
  ;

  ValidatePurchaseRequest._() : super();
  factory ValidatePurchaseRequest({
    $core.String? brandId,
    $core.double? amount,
    PaymentMethod? paymentMethod,
  }) {
    final _result = create();
    if (brandId != null) {
      _result.brandId = brandId;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (paymentMethod != null) {
      _result.paymentMethod = paymentMethod;
    }
    return _result;
  }
  factory ValidatePurchaseRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ValidatePurchaseRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ValidatePurchaseRequest clone() => ValidatePurchaseRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ValidatePurchaseRequest copyWith(void Function(ValidatePurchaseRequest) updates) => super.copyWith((message) => updates(message as ValidatePurchaseRequest)) as ValidatePurchaseRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ValidatePurchaseRequest create() => ValidatePurchaseRequest._();
  ValidatePurchaseRequest createEmptyInstance() => create();
  static $pb.PbList<ValidatePurchaseRequest> createRepeated() => $pb.PbList<ValidatePurchaseRequest>();
  @$core.pragma('dart2js:noInline')
  static ValidatePurchaseRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ValidatePurchaseRequest>(create);
  static ValidatePurchaseRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get brandId => $_getSZ(0);
  @$pb.TagNumber(1)
  set brandId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasBrandId() => $_has(0);
  @$pb.TagNumber(1)
  void clearBrandId() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get amount => $_getN(1);
  @$pb.TagNumber(2)
  set amount($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => clearField(2);

  @$pb.TagNumber(3)
  PaymentMethod get paymentMethod => $_getN(2);
  @$pb.TagNumber(3)
  set paymentMethod(PaymentMethod v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasPaymentMethod() => $_has(2);
  @$pb.TagNumber(3)
  void clearPaymentMethod() => clearField(3);
}

class ValidatePurchaseResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ValidatePurchaseResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcard'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isValid')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'discountApplied', $pb.PbFieldType.OD)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'finalPrice', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  ValidatePurchaseResponse._() : super();
  factory ValidatePurchaseResponse({
    $core.bool? isValid,
    $core.String? message,
    $core.double? discountApplied,
    $core.double? finalPrice,
  }) {
    final _result = create();
    if (isValid != null) {
      _result.isValid = isValid;
    }
    if (message != null) {
      _result.message = message;
    }
    if (discountApplied != null) {
      _result.discountApplied = discountApplied;
    }
    if (finalPrice != null) {
      _result.finalPrice = finalPrice;
    }
    return _result;
  }
  factory ValidatePurchaseResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ValidatePurchaseResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ValidatePurchaseResponse clone() => ValidatePurchaseResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ValidatePurchaseResponse copyWith(void Function(ValidatePurchaseResponse) updates) => super.copyWith((message) => updates(message as ValidatePurchaseResponse)) as ValidatePurchaseResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ValidatePurchaseResponse create() => ValidatePurchaseResponse._();
  ValidatePurchaseResponse createEmptyInstance() => create();
  static $pb.PbList<ValidatePurchaseResponse> createRepeated() => $pb.PbList<ValidatePurchaseResponse>();
  @$core.pragma('dart2js:noInline')
  static ValidatePurchaseResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ValidatePurchaseResponse>(create);
  static ValidatePurchaseResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get isValid => $_getBF(0);
  @$pb.TagNumber(1)
  set isValid($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasIsValid() => $_has(0);
  @$pb.TagNumber(1)
  void clearIsValid() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get discountApplied => $_getN(2);
  @$pb.TagNumber(3)
  set discountApplied($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDiscountApplied() => $_has(2);
  @$pb.TagNumber(3)
  void clearDiscountApplied() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get finalPrice => $_getN(3);
  @$pb.TagNumber(4)
  set finalPrice($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasFinalPrice() => $_has(3);
  @$pb.TagNumber(4)
  void clearFinalPrice() => clearField(4);
}

class ValidateCodeRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ValidateCodeRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcard'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'code')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pin')
    ..hasRequiredFields = false
  ;

  ValidateCodeRequest._() : super();
  factory ValidateCodeRequest({
    $core.String? code,
    $core.String? pin,
  }) {
    final _result = create();
    if (code != null) {
      _result.code = code;
    }
    if (pin != null) {
      _result.pin = pin;
    }
    return _result;
  }
  factory ValidateCodeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ValidateCodeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ValidateCodeRequest clone() => ValidateCodeRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ValidateCodeRequest copyWith(void Function(ValidateCodeRequest) updates) => super.copyWith((message) => updates(message as ValidateCodeRequest)) as ValidateCodeRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ValidateCodeRequest create() => ValidateCodeRequest._();
  ValidateCodeRequest createEmptyInstance() => create();
  static $pb.PbList<ValidateCodeRequest> createRepeated() => $pb.PbList<ValidateCodeRequest>();
  @$core.pragma('dart2js:noInline')
  static ValidateCodeRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ValidateCodeRequest>(create);
  static ValidateCodeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get code => $_getSZ(0);
  @$pb.TagNumber(1)
  set code($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearCode() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get pin => $_getSZ(1);
  @$pb.TagNumber(2)
  set pin($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPin() => $_has(1);
  @$pb.TagNumber(2)
  void clearPin() => clearField(2);
}

class ValidateCodeResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ValidateCodeResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcard'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isValid')
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isExpired')
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isRedeemed')
    ..aOM<GiftCard>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'giftCard', subBuilder: GiftCard.create)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  ValidateCodeResponse._() : super();
  factory ValidateCodeResponse({
    $core.bool? isValid,
    $core.bool? isExpired,
    $core.bool? isRedeemed,
    GiftCard? giftCard,
    $core.String? message,
  }) {
    final _result = create();
    if (isValid != null) {
      _result.isValid = isValid;
    }
    if (isExpired != null) {
      _result.isExpired = isExpired;
    }
    if (isRedeemed != null) {
      _result.isRedeemed = isRedeemed;
    }
    if (giftCard != null) {
      _result.giftCard = giftCard;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory ValidateCodeResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ValidateCodeResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ValidateCodeResponse clone() => ValidateCodeResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ValidateCodeResponse copyWith(void Function(ValidateCodeResponse) updates) => super.copyWith((message) => updates(message as ValidateCodeResponse)) as ValidateCodeResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ValidateCodeResponse create() => ValidateCodeResponse._();
  ValidateCodeResponse createEmptyInstance() => create();
  static $pb.PbList<ValidateCodeResponse> createRepeated() => $pb.PbList<ValidateCodeResponse>();
  @$core.pragma('dart2js:noInline')
  static ValidateCodeResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ValidateCodeResponse>(create);
  static ValidateCodeResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get isValid => $_getBF(0);
  @$pb.TagNumber(1)
  set isValid($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasIsValid() => $_has(0);
  @$pb.TagNumber(1)
  void clearIsValid() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get isExpired => $_getBF(1);
  @$pb.TagNumber(2)
  set isExpired($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasIsExpired() => $_has(1);
  @$pb.TagNumber(2)
  void clearIsExpired() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get isRedeemed => $_getBF(2);
  @$pb.TagNumber(3)
  set isRedeemed($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasIsRedeemed() => $_has(2);
  @$pb.TagNumber(3)
  void clearIsRedeemed() => clearField(3);

  @$pb.TagNumber(4)
  GiftCard get giftCard => $_getN(3);
  @$pb.TagNumber(4)
  set giftCard(GiftCard v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasGiftCard() => $_has(3);
  @$pb.TagNumber(4)
  void clearGiftCard() => clearField(4);
  @$pb.TagNumber(4)
  GiftCard ensureGiftCard() => $_ensure(3);

  @$pb.TagNumber(5)
  $core.String get message => $_getSZ(4);
  @$pb.TagNumber(5)
  set message($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasMessage() => $_has(4);
  @$pb.TagNumber(5)
  void clearMessage() => clearField(5);
}

class RedeemGiftCardRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RedeemGiftCardRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcard'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'giftCardId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'code')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pin')
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amountToRedeem', $pb.PbFieldType.OD)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'location')
    ..hasRequiredFields = false
  ;

  RedeemGiftCardRequest._() : super();
  factory RedeemGiftCardRequest({
    $core.String? giftCardId,
    $core.String? code,
    $core.String? pin,
    $core.double? amountToRedeem,
    $core.String? location,
  }) {
    final _result = create();
    if (giftCardId != null) {
      _result.giftCardId = giftCardId;
    }
    if (code != null) {
      _result.code = code;
    }
    if (pin != null) {
      _result.pin = pin;
    }
    if (amountToRedeem != null) {
      _result.amountToRedeem = amountToRedeem;
    }
    if (location != null) {
      _result.location = location;
    }
    return _result;
  }
  factory RedeemGiftCardRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RedeemGiftCardRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RedeemGiftCardRequest clone() => RedeemGiftCardRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RedeemGiftCardRequest copyWith(void Function(RedeemGiftCardRequest) updates) => super.copyWith((message) => updates(message as RedeemGiftCardRequest)) as RedeemGiftCardRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RedeemGiftCardRequest create() => RedeemGiftCardRequest._();
  RedeemGiftCardRequest createEmptyInstance() => create();
  static $pb.PbList<RedeemGiftCardRequest> createRepeated() => $pb.PbList<RedeemGiftCardRequest>();
  @$core.pragma('dart2js:noInline')
  static RedeemGiftCardRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RedeemGiftCardRequest>(create);
  static RedeemGiftCardRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get giftCardId => $_getSZ(0);
  @$pb.TagNumber(1)
  set giftCardId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasGiftCardId() => $_has(0);
  @$pb.TagNumber(1)
  void clearGiftCardId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get code => $_getSZ(1);
  @$pb.TagNumber(2)
  set code($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearCode() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get pin => $_getSZ(2);
  @$pb.TagNumber(3)
  set pin($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPin() => $_has(2);
  @$pb.TagNumber(3)
  void clearPin() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get amountToRedeem => $_getN(3);
  @$pb.TagNumber(4)
  set amountToRedeem($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAmountToRedeem() => $_has(3);
  @$pb.TagNumber(4)
  void clearAmountToRedeem() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get location => $_getSZ(4);
  @$pb.TagNumber(5)
  set location($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasLocation() => $_has(4);
  @$pb.TagNumber(5)
  void clearLocation() => clearField(5);
}

class RedeemGiftCardResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RedeemGiftCardResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcard'), createEmptyInstance: create)
    ..aOM<GiftCard>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'giftCard', subBuilder: GiftCard.create)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'redeemedAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'remainingBalance', $pb.PbFieldType.OD)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'receiptUrl')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  RedeemGiftCardResponse._() : super();
  factory RedeemGiftCardResponse({
    GiftCard? giftCard,
    $core.double? redeemedAmount,
    $core.double? remainingBalance,
    $core.String? receiptUrl,
    $core.String? message,
  }) {
    final _result = create();
    if (giftCard != null) {
      _result.giftCard = giftCard;
    }
    if (redeemedAmount != null) {
      _result.redeemedAmount = redeemedAmount;
    }
    if (remainingBalance != null) {
      _result.remainingBalance = remainingBalance;
    }
    if (receiptUrl != null) {
      _result.receiptUrl = receiptUrl;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory RedeemGiftCardResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RedeemGiftCardResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RedeemGiftCardResponse clone() => RedeemGiftCardResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RedeemGiftCardResponse copyWith(void Function(RedeemGiftCardResponse) updates) => super.copyWith((message) => updates(message as RedeemGiftCardResponse)) as RedeemGiftCardResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RedeemGiftCardResponse create() => RedeemGiftCardResponse._();
  RedeemGiftCardResponse createEmptyInstance() => create();
  static $pb.PbList<RedeemGiftCardResponse> createRepeated() => $pb.PbList<RedeemGiftCardResponse>();
  @$core.pragma('dart2js:noInline')
  static RedeemGiftCardResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RedeemGiftCardResponse>(create);
  static RedeemGiftCardResponse? _defaultInstance;

  @$pb.TagNumber(1)
  GiftCard get giftCard => $_getN(0);
  @$pb.TagNumber(1)
  set giftCard(GiftCard v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasGiftCard() => $_has(0);
  @$pb.TagNumber(1)
  void clearGiftCard() => clearField(1);
  @$pb.TagNumber(1)
  GiftCard ensureGiftCard() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.double get redeemedAmount => $_getN(1);
  @$pb.TagNumber(2)
  set redeemedAmount($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasRedeemedAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearRedeemedAmount() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get remainingBalance => $_getN(2);
  @$pb.TagNumber(3)
  set remainingBalance($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasRemainingBalance() => $_has(2);
  @$pb.TagNumber(3)
  void clearRemainingBalance() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get receiptUrl => $_getSZ(3);
  @$pb.TagNumber(4)
  set receiptUrl($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasReceiptUrl() => $_has(3);
  @$pb.TagNumber(4)
  void clearReceiptUrl() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get message => $_getSZ(4);
  @$pb.TagNumber(5)
  set message($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasMessage() => $_has(4);
  @$pb.TagNumber(5)
  void clearMessage() => clearField(5);
}

class CheckBalanceRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CheckBalanceRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcard'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'giftCardId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'code')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pin')
    ..hasRequiredFields = false
  ;

  CheckBalanceRequest._() : super();
  factory CheckBalanceRequest({
    $core.String? giftCardId,
    $core.String? code,
    $core.String? pin,
  }) {
    final _result = create();
    if (giftCardId != null) {
      _result.giftCardId = giftCardId;
    }
    if (code != null) {
      _result.code = code;
    }
    if (pin != null) {
      _result.pin = pin;
    }
    return _result;
  }
  factory CheckBalanceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CheckBalanceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CheckBalanceRequest clone() => CheckBalanceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CheckBalanceRequest copyWith(void Function(CheckBalanceRequest) updates) => super.copyWith((message) => updates(message as CheckBalanceRequest)) as CheckBalanceRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CheckBalanceRequest create() => CheckBalanceRequest._();
  CheckBalanceRequest createEmptyInstance() => create();
  static $pb.PbList<CheckBalanceRequest> createRepeated() => $pb.PbList<CheckBalanceRequest>();
  @$core.pragma('dart2js:noInline')
  static CheckBalanceRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CheckBalanceRequest>(create);
  static CheckBalanceRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get giftCardId => $_getSZ(0);
  @$pb.TagNumber(1)
  set giftCardId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasGiftCardId() => $_has(0);
  @$pb.TagNumber(1)
  void clearGiftCardId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get code => $_getSZ(1);
  @$pb.TagNumber(2)
  set code($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearCode() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get pin => $_getSZ(2);
  @$pb.TagNumber(3)
  set pin($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPin() => $_has(2);
  @$pb.TagNumber(3)
  void clearPin() => clearField(3);
}

class CheckBalanceResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CheckBalanceResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcard'), createEmptyInstance: create)
    ..a<$core.double>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'remainingBalance', $pb.PbFieldType.OD)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'originalAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'redeemedAmount', $pb.PbFieldType.OD)
    ..aOM<$34.Timestamp>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lastUsed', subBuilder: $34.Timestamp.create)
    ..aOM<GiftCard>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'giftCard', subBuilder: GiftCard.create)
    ..hasRequiredFields = false
  ;

  CheckBalanceResponse._() : super();
  factory CheckBalanceResponse({
    $core.double? remainingBalance,
    $core.double? originalAmount,
    $core.double? redeemedAmount,
    $34.Timestamp? lastUsed,
    GiftCard? giftCard,
  }) {
    final _result = create();
    if (remainingBalance != null) {
      _result.remainingBalance = remainingBalance;
    }
    if (originalAmount != null) {
      _result.originalAmount = originalAmount;
    }
    if (redeemedAmount != null) {
      _result.redeemedAmount = redeemedAmount;
    }
    if (lastUsed != null) {
      _result.lastUsed = lastUsed;
    }
    if (giftCard != null) {
      _result.giftCard = giftCard;
    }
    return _result;
  }
  factory CheckBalanceResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CheckBalanceResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CheckBalanceResponse clone() => CheckBalanceResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CheckBalanceResponse copyWith(void Function(CheckBalanceResponse) updates) => super.copyWith((message) => updates(message as CheckBalanceResponse)) as CheckBalanceResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CheckBalanceResponse create() => CheckBalanceResponse._();
  CheckBalanceResponse createEmptyInstance() => create();
  static $pb.PbList<CheckBalanceResponse> createRepeated() => $pb.PbList<CheckBalanceResponse>();
  @$core.pragma('dart2js:noInline')
  static CheckBalanceResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CheckBalanceResponse>(create);
  static CheckBalanceResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get remainingBalance => $_getN(0);
  @$pb.TagNumber(1)
  set remainingBalance($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRemainingBalance() => $_has(0);
  @$pb.TagNumber(1)
  void clearRemainingBalance() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get originalAmount => $_getN(1);
  @$pb.TagNumber(2)
  set originalAmount($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasOriginalAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearOriginalAmount() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get redeemedAmount => $_getN(2);
  @$pb.TagNumber(3)
  set redeemedAmount($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasRedeemedAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearRedeemedAmount() => clearField(3);

  @$pb.TagNumber(4)
  $34.Timestamp get lastUsed => $_getN(3);
  @$pb.TagNumber(4)
  set lastUsed($34.Timestamp v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasLastUsed() => $_has(3);
  @$pb.TagNumber(4)
  void clearLastUsed() => clearField(4);
  @$pb.TagNumber(4)
  $34.Timestamp ensureLastUsed() => $_ensure(3);

  @$pb.TagNumber(5)
  GiftCard get giftCard => $_getN(4);
  @$pb.TagNumber(5)
  set giftCard(GiftCard v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasGiftCard() => $_has(4);
  @$pb.TagNumber(5)
  void clearGiftCard() => clearField(5);
  @$pb.TagNumber(5)
  GiftCard ensureGiftCard() => $_ensure(4);
}

class TransferGiftCardRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TransferGiftCardRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcard'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'giftCardId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recipientEmail')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recipientName')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  TransferGiftCardRequest._() : super();
  factory TransferGiftCardRequest({
    $core.String? giftCardId,
    $core.String? recipientEmail,
    $core.String? recipientName,
    $core.String? message,
  }) {
    final _result = create();
    if (giftCardId != null) {
      _result.giftCardId = giftCardId;
    }
    if (recipientEmail != null) {
      _result.recipientEmail = recipientEmail;
    }
    if (recipientName != null) {
      _result.recipientName = recipientName;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory TransferGiftCardRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TransferGiftCardRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TransferGiftCardRequest clone() => TransferGiftCardRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TransferGiftCardRequest copyWith(void Function(TransferGiftCardRequest) updates) => super.copyWith((message) => updates(message as TransferGiftCardRequest)) as TransferGiftCardRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TransferGiftCardRequest create() => TransferGiftCardRequest._();
  TransferGiftCardRequest createEmptyInstance() => create();
  static $pb.PbList<TransferGiftCardRequest> createRepeated() => $pb.PbList<TransferGiftCardRequest>();
  @$core.pragma('dart2js:noInline')
  static TransferGiftCardRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TransferGiftCardRequest>(create);
  static TransferGiftCardRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get giftCardId => $_getSZ(0);
  @$pb.TagNumber(1)
  set giftCardId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasGiftCardId() => $_has(0);
  @$pb.TagNumber(1)
  void clearGiftCardId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get recipientEmail => $_getSZ(1);
  @$pb.TagNumber(2)
  set recipientEmail($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasRecipientEmail() => $_has(1);
  @$pb.TagNumber(2)
  void clearRecipientEmail() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get recipientName => $_getSZ(2);
  @$pb.TagNumber(3)
  set recipientName($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasRecipientName() => $_has(2);
  @$pb.TagNumber(3)
  void clearRecipientName() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get message => $_getSZ(3);
  @$pb.TagNumber(4)
  set message($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMessage() => $_has(3);
  @$pb.TagNumber(4)
  void clearMessage() => clearField(4);
}

class TransferGiftCardResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TransferGiftCardResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcard'), createEmptyInstance: create)
    ..aOM<GiftCard>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'giftCard', subBuilder: GiftCard.create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  TransferGiftCardResponse._() : super();
  factory TransferGiftCardResponse({
    GiftCard? giftCard,
    $core.String? message,
  }) {
    final _result = create();
    if (giftCard != null) {
      _result.giftCard = giftCard;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory TransferGiftCardResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TransferGiftCardResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TransferGiftCardResponse clone() => TransferGiftCardResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TransferGiftCardResponse copyWith(void Function(TransferGiftCardResponse) updates) => super.copyWith((message) => updates(message as TransferGiftCardResponse)) as TransferGiftCardResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TransferGiftCardResponse create() => TransferGiftCardResponse._();
  TransferGiftCardResponse createEmptyInstance() => create();
  static $pb.PbList<TransferGiftCardResponse> createRepeated() => $pb.PbList<TransferGiftCardResponse>();
  @$core.pragma('dart2js:noInline')
  static TransferGiftCardResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TransferGiftCardResponse>(create);
  static TransferGiftCardResponse? _defaultInstance;

  @$pb.TagNumber(1)
  GiftCard get giftCard => $_getN(0);
  @$pb.TagNumber(1)
  set giftCard(GiftCard v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasGiftCard() => $_has(0);
  @$pb.TagNumber(1)
  void clearGiftCard() => clearField(1);
  @$pb.TagNumber(1)
  GiftCard ensureGiftCard() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

class SellGiftCardRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SellGiftCardRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcard'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'giftCardId')
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'askingPrice', $pb.PbFieldType.OD)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..hasRequiredFields = false
  ;

  SellGiftCardRequest._() : super();
  factory SellGiftCardRequest({
    $core.String? giftCardId,
    $core.double? askingPrice,
    $core.String? description,
  }) {
    final _result = create();
    if (giftCardId != null) {
      _result.giftCardId = giftCardId;
    }
    if (askingPrice != null) {
      _result.askingPrice = askingPrice;
    }
    if (description != null) {
      _result.description = description;
    }
    return _result;
  }
  factory SellGiftCardRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SellGiftCardRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SellGiftCardRequest clone() => SellGiftCardRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SellGiftCardRequest copyWith(void Function(SellGiftCardRequest) updates) => super.copyWith((message) => updates(message as SellGiftCardRequest)) as SellGiftCardRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SellGiftCardRequest create() => SellGiftCardRequest._();
  SellGiftCardRequest createEmptyInstance() => create();
  static $pb.PbList<SellGiftCardRequest> createRepeated() => $pb.PbList<SellGiftCardRequest>();
  @$core.pragma('dart2js:noInline')
  static SellGiftCardRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SellGiftCardRequest>(create);
  static SellGiftCardRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get giftCardId => $_getSZ(0);
  @$pb.TagNumber(1)
  set giftCardId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasGiftCardId() => $_has(0);
  @$pb.TagNumber(1)
  void clearGiftCardId() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get askingPrice => $_getN(1);
  @$pb.TagNumber(2)
  set askingPrice($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAskingPrice() => $_has(1);
  @$pb.TagNumber(2)
  void clearAskingPrice() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => clearField(3);
}

class SellGiftCardResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SellGiftCardResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcard'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'listingId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  SellGiftCardResponse._() : super();
  factory SellGiftCardResponse({
    $core.String? listingId,
    $core.String? message,
  }) {
    final _result = create();
    if (listingId != null) {
      _result.listingId = listingId;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory SellGiftCardResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SellGiftCardResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SellGiftCardResponse clone() => SellGiftCardResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SellGiftCardResponse copyWith(void Function(SellGiftCardResponse) updates) => super.copyWith((message) => updates(message as SellGiftCardResponse)) as SellGiftCardResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SellGiftCardResponse create() => SellGiftCardResponse._();
  SellGiftCardResponse createEmptyInstance() => create();
  static $pb.PbList<SellGiftCardResponse> createRepeated() => $pb.PbList<SellGiftCardResponse>();
  @$core.pragma('dart2js:noInline')
  static SellGiftCardResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SellGiftCardResponse>(create);
  static SellGiftCardResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get listingId => $_getSZ(0);
  @$pb.TagNumber(1)
  set listingId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasListingId() => $_has(0);
  @$pb.TagNumber(1)
  void clearListingId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

class GetResellableCardsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetResellableCardsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcard'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetResellableCardsRequest._() : super();
  factory GetResellableCardsRequest({
    $core.int? page,
    $core.int? limit,
  }) {
    final _result = create();
    if (page != null) {
      _result.page = page;
    }
    if (limit != null) {
      _result.limit = limit;
    }
    return _result;
  }
  factory GetResellableCardsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetResellableCardsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetResellableCardsRequest clone() => GetResellableCardsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetResellableCardsRequest copyWith(void Function(GetResellableCardsRequest) updates) => super.copyWith((message) => updates(message as GetResellableCardsRequest)) as GetResellableCardsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetResellableCardsRequest create() => GetResellableCardsRequest._();
  GetResellableCardsRequest createEmptyInstance() => create();
  static $pb.PbList<GetResellableCardsRequest> createRepeated() => $pb.PbList<GetResellableCardsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetResellableCardsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetResellableCardsRequest>(create);
  static GetResellableCardsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get page => $_getIZ(0);
  @$pb.TagNumber(1)
  set page($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearPage() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get limit => $_getIZ(1);
  @$pb.TagNumber(2)
  set limit($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => clearField(2);
}

class GetResellableCardsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetResellableCardsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcard'), createEmptyInstance: create)
    ..pc<GiftCard>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'giftCards', $pb.PbFieldType.PM, subBuilder: GiftCard.create)
    ..aInt64(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'total')
    ..hasRequiredFields = false
  ;

  GetResellableCardsResponse._() : super();
  factory GetResellableCardsResponse({
    $core.Iterable<GiftCard>? giftCards,
    $fixnum.Int64? total,
  }) {
    final _result = create();
    if (giftCards != null) {
      _result.giftCards.addAll(giftCards);
    }
    if (total != null) {
      _result.total = total;
    }
    return _result;
  }
  factory GetResellableCardsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetResellableCardsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetResellableCardsResponse clone() => GetResellableCardsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetResellableCardsResponse copyWith(void Function(GetResellableCardsResponse) updates) => super.copyWith((message) => updates(message as GetResellableCardsResponse)) as GetResellableCardsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetResellableCardsResponse create() => GetResellableCardsResponse._();
  GetResellableCardsResponse createEmptyInstance() => create();
  static $pb.PbList<GetResellableCardsResponse> createRepeated() => $pb.PbList<GetResellableCardsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetResellableCardsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetResellableCardsResponse>(create);
  static GetResellableCardsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<GiftCard> get giftCards => $_getList(0);

  @$pb.TagNumber(2)
  $fixnum.Int64 get total => $_getI64(1);
  @$pb.TagNumber(2)
  set total($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => clearField(2);
}

class GetTransactionsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetTransactionsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcard'), createEmptyInstance: create)
    ..e<TransactionType>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionType', $pb.PbFieldType.OE, defaultOrMaker: TransactionType.TRANSACTION_TYPE_UNSPECIFIED, valueOf: TransactionType.valueOf, enumValues: TransactionType.values)
    ..aOM<$34.Timestamp>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'startDate', subBuilder: $34.Timestamp.create)
    ..aOM<$34.Timestamp>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'endDate', subBuilder: $34.Timestamp.create)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetTransactionsRequest._() : super();
  factory GetTransactionsRequest({
    TransactionType? transactionType,
    $34.Timestamp? startDate,
    $34.Timestamp? endDate,
    $core.int? page,
    $core.int? limit,
  }) {
    final _result = create();
    if (transactionType != null) {
      _result.transactionType = transactionType;
    }
    if (startDate != null) {
      _result.startDate = startDate;
    }
    if (endDate != null) {
      _result.endDate = endDate;
    }
    if (page != null) {
      _result.page = page;
    }
    if (limit != null) {
      _result.limit = limit;
    }
    return _result;
  }
  factory GetTransactionsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTransactionsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetTransactionsRequest clone() => GetTransactionsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetTransactionsRequest copyWith(void Function(GetTransactionsRequest) updates) => super.copyWith((message) => updates(message as GetTransactionsRequest)) as GetTransactionsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetTransactionsRequest create() => GetTransactionsRequest._();
  GetTransactionsRequest createEmptyInstance() => create();
  static $pb.PbList<GetTransactionsRequest> createRepeated() => $pb.PbList<GetTransactionsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetTransactionsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTransactionsRequest>(create);
  static GetTransactionsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  TransactionType get transactionType => $_getN(0);
  @$pb.TagNumber(1)
  set transactionType(TransactionType v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasTransactionType() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransactionType() => clearField(1);

  @$pb.TagNumber(2)
  $34.Timestamp get startDate => $_getN(1);
  @$pb.TagNumber(2)
  set startDate($34.Timestamp v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasStartDate() => $_has(1);
  @$pb.TagNumber(2)
  void clearStartDate() => clearField(2);
  @$pb.TagNumber(2)
  $34.Timestamp ensureStartDate() => $_ensure(1);

  @$pb.TagNumber(3)
  $34.Timestamp get endDate => $_getN(2);
  @$pb.TagNumber(3)
  set endDate($34.Timestamp v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasEndDate() => $_has(2);
  @$pb.TagNumber(3)
  void clearEndDate() => clearField(3);
  @$pb.TagNumber(3)
  $34.Timestamp ensureEndDate() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.int get page => $_getIZ(3);
  @$pb.TagNumber(4)
  set page($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPage() => $_has(3);
  @$pb.TagNumber(4)
  void clearPage() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get limit => $_getIZ(4);
  @$pb.TagNumber(5)
  set limit($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasLimit() => $_has(4);
  @$pb.TagNumber(5)
  void clearLimit() => clearField(5);
}

class GetTransactionsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetTransactionsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcard'), createEmptyInstance: create)
    ..pc<GiftCardTransaction>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactions', $pb.PbFieldType.PM, subBuilder: GiftCardTransaction.create)
    ..aInt64(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'total')
    ..hasRequiredFields = false
  ;

  GetTransactionsResponse._() : super();
  factory GetTransactionsResponse({
    $core.Iterable<GiftCardTransaction>? transactions,
    $fixnum.Int64? total,
  }) {
    final _result = create();
    if (transactions != null) {
      _result.transactions.addAll(transactions);
    }
    if (total != null) {
      _result.total = total;
    }
    return _result;
  }
  factory GetTransactionsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTransactionsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetTransactionsResponse clone() => GetTransactionsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetTransactionsResponse copyWith(void Function(GetTransactionsResponse) updates) => super.copyWith((message) => updates(message as GetTransactionsResponse)) as GetTransactionsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetTransactionsResponse create() => GetTransactionsResponse._();
  GetTransactionsResponse createEmptyInstance() => create();
  static $pb.PbList<GetTransactionsResponse> createRepeated() => $pb.PbList<GetTransactionsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetTransactionsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTransactionsResponse>(create);
  static GetTransactionsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<GiftCardTransaction> get transactions => $_getList(0);

  @$pb.TagNumber(2)
  $fixnum.Int64 get total => $_getI64(1);
  @$pb.TagNumber(2)
  set total($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => clearField(2);
}

class GetTransactionByIdRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetTransactionByIdRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcard'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionId')
    ..hasRequiredFields = false
  ;

  GetTransactionByIdRequest._() : super();
  factory GetTransactionByIdRequest({
    $core.String? transactionId,
  }) {
    final _result = create();
    if (transactionId != null) {
      _result.transactionId = transactionId;
    }
    return _result;
  }
  factory GetTransactionByIdRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTransactionByIdRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetTransactionByIdRequest clone() => GetTransactionByIdRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetTransactionByIdRequest copyWith(void Function(GetTransactionByIdRequest) updates) => super.copyWith((message) => updates(message as GetTransactionByIdRequest)) as GetTransactionByIdRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetTransactionByIdRequest create() => GetTransactionByIdRequest._();
  GetTransactionByIdRequest createEmptyInstance() => create();
  static $pb.PbList<GetTransactionByIdRequest> createRepeated() => $pb.PbList<GetTransactionByIdRequest>();
  @$core.pragma('dart2js:noInline')
  static GetTransactionByIdRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTransactionByIdRequest>(create);
  static GetTransactionByIdRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get transactionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set transactionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTransactionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransactionId() => clearField(1);
}

class GetTransactionByIdResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetTransactionByIdResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcard'), createEmptyInstance: create)
    ..aOM<GiftCardTransaction>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transaction', subBuilder: GiftCardTransaction.create)
    ..hasRequiredFields = false
  ;

  GetTransactionByIdResponse._() : super();
  factory GetTransactionByIdResponse({
    GiftCardTransaction? transaction,
  }) {
    final _result = create();
    if (transaction != null) {
      _result.transaction = transaction;
    }
    return _result;
  }
  factory GetTransactionByIdResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTransactionByIdResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetTransactionByIdResponse clone() => GetTransactionByIdResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetTransactionByIdResponse copyWith(void Function(GetTransactionByIdResponse) updates) => super.copyWith((message) => updates(message as GetTransactionByIdResponse)) as GetTransactionByIdResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetTransactionByIdResponse create() => GetTransactionByIdResponse._();
  GetTransactionByIdResponse createEmptyInstance() => create();
  static $pb.PbList<GetTransactionByIdResponse> createRepeated() => $pb.PbList<GetTransactionByIdResponse>();
  @$core.pragma('dart2js:noInline')
  static GetTransactionByIdResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTransactionByIdResponse>(create);
  static GetTransactionByIdResponse? _defaultInstance;

  @$pb.TagNumber(1)
  GiftCardTransaction get transaction => $_getN(0);
  @$pb.TagNumber(1)
  set transaction(GiftCardTransaction v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasTransaction() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransaction() => clearField(1);
  @$pb.TagNumber(1)
  GiftCardTransaction ensureTransaction() => $_ensure(0);
}

class GetStatisticsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetStatisticsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcard'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetStatisticsRequest._() : super();
  factory GetStatisticsRequest() => create();
  factory GetStatisticsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetStatisticsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetStatisticsRequest clone() => GetStatisticsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetStatisticsRequest copyWith(void Function(GetStatisticsRequest) updates) => super.copyWith((message) => updates(message as GetStatisticsRequest)) as GetStatisticsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetStatisticsRequest create() => GetStatisticsRequest._();
  GetStatisticsRequest createEmptyInstance() => create();
  static $pb.PbList<GetStatisticsRequest> createRepeated() => $pb.PbList<GetStatisticsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetStatisticsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetStatisticsRequest>(create);
  static GetStatisticsRequest? _defaultInstance;
}

class GetStatisticsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetStatisticsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcard'), createEmptyInstance: create)
    ..aOM<Statistics>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'statistics', subBuilder: Statistics.create)
    ..hasRequiredFields = false
  ;

  GetStatisticsResponse._() : super();
  factory GetStatisticsResponse({
    Statistics? statistics,
  }) {
    final _result = create();
    if (statistics != null) {
      _result.statistics = statistics;
    }
    return _result;
  }
  factory GetStatisticsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetStatisticsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetStatisticsResponse clone() => GetStatisticsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetStatisticsResponse copyWith(void Function(GetStatisticsResponse) updates) => super.copyWith((message) => updates(message as GetStatisticsResponse)) as GetStatisticsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetStatisticsResponse create() => GetStatisticsResponse._();
  GetStatisticsResponse createEmptyInstance() => create();
  static $pb.PbList<GetStatisticsResponse> createRepeated() => $pb.PbList<GetStatisticsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetStatisticsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetStatisticsResponse>(create);
  static GetStatisticsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Statistics get statistics => $_getN(0);
  @$pb.TagNumber(1)
  set statistics(Statistics v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasStatistics() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatistics() => clearField(1);
  @$pb.TagNumber(1)
  Statistics ensureStatistics() => $_ensure(0);
}

