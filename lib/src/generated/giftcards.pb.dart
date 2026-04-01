///
//  Generated code. Do not modify.
//  source: giftcards.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

class GiftCard extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GiftCard', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountId')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'brandId')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'brandName')
    ..a<$core.double>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'originalAmount', $pb.PbFieldType.OD)
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..aOS(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'purchaseDate')
    ..aOS(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'expiryDate')
    ..aOS(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recipientEmail')
    ..aOS(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recipientName')
    ..aOS(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOS(18, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'metadata')
    ..aOS(19, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt')
    ..aOS(20, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedAt')
    ..aOS(21, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerTransactionId')
    ..aOS(22, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'redemptionCode')
    ..aOS(23, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'redemptionPin')
    ..aOS(24, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'countryCode')
    ..aOS(25, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'logoUrl')
    ..aInt64(26, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerProductId')
    ..a<$core.double>(27, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'discountPercentage', $pb.PbFieldType.OD)
    ..a<$core.double>(28, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'senderAmount', $pb.PbFieldType.OD)
    ..aOS(29, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'senderCurrency')
    ..aOS(30, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transferredFromId')
    ..aOS(31, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'senderUserId')
    ..aOS(32, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transferType')
    ..aOS(33, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'redemptionInstructions')
    ..hasRequiredFields = false
  ;

  GiftCard._() : super();
  factory GiftCard({
    $core.String? id,
    $core.String? userId,
    $core.String? accountId,
    $core.String? brandId,
    $core.String? brandName,
    $core.double? originalAmount,
    $core.String? currency,
    $core.String? status,
    $core.String? purchaseDate,
    $core.String? expiryDate,
    $core.String? recipientEmail,
    $core.String? recipientName,
    $core.String? message,
    $core.String? metadata,
    $core.String? createdAt,
    $core.String? updatedAt,
    $core.String? providerTransactionId,
    $core.String? redemptionCode,
    $core.String? redemptionPin,
    $core.String? countryCode,
    $core.String? logoUrl,
    $fixnum.Int64? providerProductId,
    $core.double? discountPercentage,
    $core.double? senderAmount,
    $core.String? senderCurrency,
    $core.String? transferredFromId,
    $core.String? senderUserId,
    $core.String? transferType,
    $core.String? redemptionInstructions,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (accountId != null) {
      _result.accountId = accountId;
    }
    if (brandId != null) {
      _result.brandId = brandId;
    }
    if (brandName != null) {
      _result.brandName = brandName;
    }
    if (originalAmount != null) {
      _result.originalAmount = originalAmount;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (status != null) {
      _result.status = status;
    }
    if (purchaseDate != null) {
      _result.purchaseDate = purchaseDate;
    }
    if (expiryDate != null) {
      _result.expiryDate = expiryDate;
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
    if (metadata != null) {
      _result.metadata = metadata;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      _result.updatedAt = updatedAt;
    }
    if (providerTransactionId != null) {
      _result.providerTransactionId = providerTransactionId;
    }
    if (redemptionCode != null) {
      _result.redemptionCode = redemptionCode;
    }
    if (redemptionPin != null) {
      _result.redemptionPin = redemptionPin;
    }
    if (countryCode != null) {
      _result.countryCode = countryCode;
    }
    if (logoUrl != null) {
      _result.logoUrl = logoUrl;
    }
    if (providerProductId != null) {
      _result.providerProductId = providerProductId;
    }
    if (discountPercentage != null) {
      _result.discountPercentage = discountPercentage;
    }
    if (senderAmount != null) {
      _result.senderAmount = senderAmount;
    }
    if (senderCurrency != null) {
      _result.senderCurrency = senderCurrency;
    }
    if (transferredFromId != null) {
      _result.transferredFromId = transferredFromId;
    }
    if (senderUserId != null) {
      _result.senderUserId = senderUserId;
    }
    if (transferType != null) {
      _result.transferType = transferType;
    }
    if (redemptionInstructions != null) {
      _result.redemptionInstructions = redemptionInstructions;
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
  $core.String get accountId => $_getSZ(2);
  @$pb.TagNumber(3)
  set accountId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAccountId() => $_has(2);
  @$pb.TagNumber(3)
  void clearAccountId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get brandId => $_getSZ(3);
  @$pb.TagNumber(4)
  set brandId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasBrandId() => $_has(3);
  @$pb.TagNumber(4)
  void clearBrandId() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get brandName => $_getSZ(4);
  @$pb.TagNumber(5)
  set brandName($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasBrandName() => $_has(4);
  @$pb.TagNumber(5)
  void clearBrandName() => clearField(5);

  @$pb.TagNumber(8)
  $core.double get originalAmount => $_getN(5);
  @$pb.TagNumber(8)
  set originalAmount($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(8)
  $core.bool hasOriginalAmount() => $_has(5);
  @$pb.TagNumber(8)
  void clearOriginalAmount() => clearField(8);

  @$pb.TagNumber(10)
  $core.String get currency => $_getSZ(6);
  @$pb.TagNumber(10)
  set currency($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(10)
  $core.bool hasCurrency() => $_has(6);
  @$pb.TagNumber(10)
  void clearCurrency() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get status => $_getSZ(7);
  @$pb.TagNumber(11)
  set status($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(11)
  $core.bool hasStatus() => $_has(7);
  @$pb.TagNumber(11)
  void clearStatus() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get purchaseDate => $_getSZ(8);
  @$pb.TagNumber(12)
  set purchaseDate($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(12)
  $core.bool hasPurchaseDate() => $_has(8);
  @$pb.TagNumber(12)
  void clearPurchaseDate() => clearField(12);

  @$pb.TagNumber(13)
  $core.String get expiryDate => $_getSZ(9);
  @$pb.TagNumber(13)
  set expiryDate($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(13)
  $core.bool hasExpiryDate() => $_has(9);
  @$pb.TagNumber(13)
  void clearExpiryDate() => clearField(13);

  @$pb.TagNumber(14)
  $core.String get recipientEmail => $_getSZ(10);
  @$pb.TagNumber(14)
  set recipientEmail($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(14)
  $core.bool hasRecipientEmail() => $_has(10);
  @$pb.TagNumber(14)
  void clearRecipientEmail() => clearField(14);

  @$pb.TagNumber(15)
  $core.String get recipientName => $_getSZ(11);
  @$pb.TagNumber(15)
  set recipientName($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(15)
  $core.bool hasRecipientName() => $_has(11);
  @$pb.TagNumber(15)
  void clearRecipientName() => clearField(15);

  @$pb.TagNumber(16)
  $core.String get message => $_getSZ(12);
  @$pb.TagNumber(16)
  set message($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(16)
  $core.bool hasMessage() => $_has(12);
  @$pb.TagNumber(16)
  void clearMessage() => clearField(16);

  @$pb.TagNumber(18)
  $core.String get metadata => $_getSZ(13);
  @$pb.TagNumber(18)
  set metadata($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(18)
  $core.bool hasMetadata() => $_has(13);
  @$pb.TagNumber(18)
  void clearMetadata() => clearField(18);

  @$pb.TagNumber(19)
  $core.String get createdAt => $_getSZ(14);
  @$pb.TagNumber(19)
  set createdAt($core.String v) { $_setString(14, v); }
  @$pb.TagNumber(19)
  $core.bool hasCreatedAt() => $_has(14);
  @$pb.TagNumber(19)
  void clearCreatedAt() => clearField(19);

  @$pb.TagNumber(20)
  $core.String get updatedAt => $_getSZ(15);
  @$pb.TagNumber(20)
  set updatedAt($core.String v) { $_setString(15, v); }
  @$pb.TagNumber(20)
  $core.bool hasUpdatedAt() => $_has(15);
  @$pb.TagNumber(20)
  void clearUpdatedAt() => clearField(20);

  @$pb.TagNumber(21)
  $core.String get providerTransactionId => $_getSZ(16);
  @$pb.TagNumber(21)
  set providerTransactionId($core.String v) { $_setString(16, v); }
  @$pb.TagNumber(21)
  $core.bool hasProviderTransactionId() => $_has(16);
  @$pb.TagNumber(21)
  void clearProviderTransactionId() => clearField(21);

  @$pb.TagNumber(22)
  $core.String get redemptionCode => $_getSZ(17);
  @$pb.TagNumber(22)
  set redemptionCode($core.String v) { $_setString(17, v); }
  @$pb.TagNumber(22)
  $core.bool hasRedemptionCode() => $_has(17);
  @$pb.TagNumber(22)
  void clearRedemptionCode() => clearField(22);

  @$pb.TagNumber(23)
  $core.String get redemptionPin => $_getSZ(18);
  @$pb.TagNumber(23)
  set redemptionPin($core.String v) { $_setString(18, v); }
  @$pb.TagNumber(23)
  $core.bool hasRedemptionPin() => $_has(18);
  @$pb.TagNumber(23)
  void clearRedemptionPin() => clearField(23);

  @$pb.TagNumber(24)
  $core.String get countryCode => $_getSZ(19);
  @$pb.TagNumber(24)
  set countryCode($core.String v) { $_setString(19, v); }
  @$pb.TagNumber(24)
  $core.bool hasCountryCode() => $_has(19);
  @$pb.TagNumber(24)
  void clearCountryCode() => clearField(24);

  @$pb.TagNumber(25)
  $core.String get logoUrl => $_getSZ(20);
  @$pb.TagNumber(25)
  set logoUrl($core.String v) { $_setString(20, v); }
  @$pb.TagNumber(25)
  $core.bool hasLogoUrl() => $_has(20);
  @$pb.TagNumber(25)
  void clearLogoUrl() => clearField(25);

  @$pb.TagNumber(26)
  $fixnum.Int64 get providerProductId => $_getI64(21);
  @$pb.TagNumber(26)
  set providerProductId($fixnum.Int64 v) { $_setInt64(21, v); }
  @$pb.TagNumber(26)
  $core.bool hasProviderProductId() => $_has(21);
  @$pb.TagNumber(26)
  void clearProviderProductId() => clearField(26);

  @$pb.TagNumber(27)
  $core.double get discountPercentage => $_getN(22);
  @$pb.TagNumber(27)
  set discountPercentage($core.double v) { $_setDouble(22, v); }
  @$pb.TagNumber(27)
  $core.bool hasDiscountPercentage() => $_has(22);
  @$pb.TagNumber(27)
  void clearDiscountPercentage() => clearField(27);

  @$pb.TagNumber(28)
  $core.double get senderAmount => $_getN(23);
  @$pb.TagNumber(28)
  set senderAmount($core.double v) { $_setDouble(23, v); }
  @$pb.TagNumber(28)
  $core.bool hasSenderAmount() => $_has(23);
  @$pb.TagNumber(28)
  void clearSenderAmount() => clearField(28);

  @$pb.TagNumber(29)
  $core.String get senderCurrency => $_getSZ(24);
  @$pb.TagNumber(29)
  set senderCurrency($core.String v) { $_setString(24, v); }
  @$pb.TagNumber(29)
  $core.bool hasSenderCurrency() => $_has(24);
  @$pb.TagNumber(29)
  void clearSenderCurrency() => clearField(29);

  @$pb.TagNumber(30)
  $core.String get transferredFromId => $_getSZ(25);
  @$pb.TagNumber(30)
  set transferredFromId($core.String v) { $_setString(25, v); }
  @$pb.TagNumber(30)
  $core.bool hasTransferredFromId() => $_has(25);
  @$pb.TagNumber(30)
  void clearTransferredFromId() => clearField(30);

  @$pb.TagNumber(31)
  $core.String get senderUserId => $_getSZ(26);
  @$pb.TagNumber(31)
  set senderUserId($core.String v) { $_setString(26, v); }
  @$pb.TagNumber(31)
  $core.bool hasSenderUserId() => $_has(26);
  @$pb.TagNumber(31)
  void clearSenderUserId() => clearField(31);

  @$pb.TagNumber(32)
  $core.String get transferType => $_getSZ(27);
  @$pb.TagNumber(32)
  set transferType($core.String v) { $_setString(27, v); }
  @$pb.TagNumber(32)
  $core.bool hasTransferType() => $_has(27);
  @$pb.TagNumber(32)
  void clearTransferType() => clearField(32);

  @$pb.TagNumber(33)
  $core.String get redemptionInstructions => $_getSZ(28);
  @$pb.TagNumber(33)
  set redemptionInstructions($core.String v) { $_setString(28, v); }
  @$pb.TagNumber(33)
  $core.bool hasRedemptionInstructions() => $_has(28);
  @$pb.TagNumber(33)
  void clearRedemptionInstructions() => clearField(33);
}

class GiftCardBrand extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GiftCardBrand', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'logoUrl')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'category')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..p<$core.double>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'denominations', $pb.PbFieldType.KD)
    ..a<$core.double>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'minAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'maxAmount', $pb.PbFieldType.OD)
    ..aOB(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isActive')
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'termsAndConditions')
    ..aInt64(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'productId')
    ..aOS(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'countryCode')
    ..pc<GiftCardDenomination>(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fixedDenominations', $pb.PbFieldType.PM, subBuilder: GiftCardDenomination.create)
    ..a<$core.double>(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'discountPercentage', $pb.PbFieldType.OD)
    ..aOS(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currencyCode')
    ..aOS(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'redemptionInstructions')
    ..aOS(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerName')
    ..aOS(18, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'senderCurrencyCode')
    ..p<$core.double>(19, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'senderDenominations', $pb.PbFieldType.KD)
    ..a<$core.double>(20, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'minSenderAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(21, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'maxSenderAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(22, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'senderFee', $pb.PbFieldType.OD)
    ..a<$core.double>(23, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'senderFeePercentage', $pb.PbFieldType.OD)
    ..pc<GiftCardDenomination>(24, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fixedSenderDenominations', $pb.PbFieldType.PM, subBuilder: GiftCardDenomination.create)
    ..hasRequiredFields = false
  ;

  GiftCardBrand._() : super();
  factory GiftCardBrand({
    $core.String? id,
    $core.String? name,
    $core.String? logoUrl,
    $core.String? category,
    $core.String? description,
    $core.Iterable<$core.double>? denominations,
    $core.double? minAmount,
    $core.double? maxAmount,
    $core.bool? isActive,
    $core.String? termsAndConditions,
    $fixnum.Int64? productId,
    $core.String? countryCode,
    $core.Iterable<GiftCardDenomination>? fixedDenominations,
    $core.double? discountPercentage,
    $core.String? currencyCode,
    $core.String? redemptionInstructions,
    $core.String? providerName,
    $core.String? senderCurrencyCode,
    $core.Iterable<$core.double>? senderDenominations,
    $core.double? minSenderAmount,
    $core.double? maxSenderAmount,
    $core.double? senderFee,
    $core.double? senderFeePercentage,
    $core.Iterable<GiftCardDenomination>? fixedSenderDenominations,
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
    if (category != null) {
      _result.category = category;
    }
    if (description != null) {
      _result.description = description;
    }
    if (denominations != null) {
      _result.denominations.addAll(denominations);
    }
    if (minAmount != null) {
      _result.minAmount = minAmount;
    }
    if (maxAmount != null) {
      _result.maxAmount = maxAmount;
    }
    if (isActive != null) {
      _result.isActive = isActive;
    }
    if (termsAndConditions != null) {
      _result.termsAndConditions = termsAndConditions;
    }
    if (productId != null) {
      _result.productId = productId;
    }
    if (countryCode != null) {
      _result.countryCode = countryCode;
    }
    if (fixedDenominations != null) {
      _result.fixedDenominations.addAll(fixedDenominations);
    }
    if (discountPercentage != null) {
      _result.discountPercentage = discountPercentage;
    }
    if (currencyCode != null) {
      _result.currencyCode = currencyCode;
    }
    if (redemptionInstructions != null) {
      _result.redemptionInstructions = redemptionInstructions;
    }
    if (providerName != null) {
      _result.providerName = providerName;
    }
    if (senderCurrencyCode != null) {
      _result.senderCurrencyCode = senderCurrencyCode;
    }
    if (senderDenominations != null) {
      _result.senderDenominations.addAll(senderDenominations);
    }
    if (minSenderAmount != null) {
      _result.minSenderAmount = minSenderAmount;
    }
    if (maxSenderAmount != null) {
      _result.maxSenderAmount = maxSenderAmount;
    }
    if (senderFee != null) {
      _result.senderFee = senderFee;
    }
    if (senderFeePercentage != null) {
      _result.senderFeePercentage = senderFeePercentage;
    }
    if (fixedSenderDenominations != null) {
      _result.fixedSenderDenominations.addAll(fixedSenderDenominations);
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
  $core.String get category => $_getSZ(3);
  @$pb.TagNumber(4)
  set category($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCategory() => $_has(3);
  @$pb.TagNumber(4)
  void clearCategory() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get description => $_getSZ(4);
  @$pb.TagNumber(5)
  set description($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasDescription() => $_has(4);
  @$pb.TagNumber(5)
  void clearDescription() => clearField(5);

  @$pb.TagNumber(6)
  $core.List<$core.double> get denominations => $_getList(5);

  @$pb.TagNumber(7)
  $core.double get minAmount => $_getN(6);
  @$pb.TagNumber(7)
  set minAmount($core.double v) { $_setDouble(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasMinAmount() => $_has(6);
  @$pb.TagNumber(7)
  void clearMinAmount() => clearField(7);

  @$pb.TagNumber(8)
  $core.double get maxAmount => $_getN(7);
  @$pb.TagNumber(8)
  set maxAmount($core.double v) { $_setDouble(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasMaxAmount() => $_has(7);
  @$pb.TagNumber(8)
  void clearMaxAmount() => clearField(8);

  @$pb.TagNumber(9)
  $core.bool get isActive => $_getBF(8);
  @$pb.TagNumber(9)
  set isActive($core.bool v) { $_setBool(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasIsActive() => $_has(8);
  @$pb.TagNumber(9)
  void clearIsActive() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get termsAndConditions => $_getSZ(9);
  @$pb.TagNumber(10)
  set termsAndConditions($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasTermsAndConditions() => $_has(9);
  @$pb.TagNumber(10)
  void clearTermsAndConditions() => clearField(10);

  @$pb.TagNumber(11)
  $fixnum.Int64 get productId => $_getI64(10);
  @$pb.TagNumber(11)
  set productId($fixnum.Int64 v) { $_setInt64(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasProductId() => $_has(10);
  @$pb.TagNumber(11)
  void clearProductId() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get countryCode => $_getSZ(11);
  @$pb.TagNumber(12)
  set countryCode($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasCountryCode() => $_has(11);
  @$pb.TagNumber(12)
  void clearCountryCode() => clearField(12);

  @$pb.TagNumber(13)
  $core.List<GiftCardDenomination> get fixedDenominations => $_getList(12);

  @$pb.TagNumber(14)
  $core.double get discountPercentage => $_getN(13);
  @$pb.TagNumber(14)
  set discountPercentage($core.double v) { $_setDouble(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasDiscountPercentage() => $_has(13);
  @$pb.TagNumber(14)
  void clearDiscountPercentage() => clearField(14);

  @$pb.TagNumber(15)
  $core.String get currencyCode => $_getSZ(14);
  @$pb.TagNumber(15)
  set currencyCode($core.String v) { $_setString(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasCurrencyCode() => $_has(14);
  @$pb.TagNumber(15)
  void clearCurrencyCode() => clearField(15);

  @$pb.TagNumber(16)
  $core.String get redemptionInstructions => $_getSZ(15);
  @$pb.TagNumber(16)
  set redemptionInstructions($core.String v) { $_setString(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasRedemptionInstructions() => $_has(15);
  @$pb.TagNumber(16)
  void clearRedemptionInstructions() => clearField(16);

  @$pb.TagNumber(17)
  $core.String get providerName => $_getSZ(16);
  @$pb.TagNumber(17)
  set providerName($core.String v) { $_setString(16, v); }
  @$pb.TagNumber(17)
  $core.bool hasProviderName() => $_has(16);
  @$pb.TagNumber(17)
  void clearProviderName() => clearField(17);

  @$pb.TagNumber(18)
  $core.String get senderCurrencyCode => $_getSZ(17);
  @$pb.TagNumber(18)
  set senderCurrencyCode($core.String v) { $_setString(17, v); }
  @$pb.TagNumber(18)
  $core.bool hasSenderCurrencyCode() => $_has(17);
  @$pb.TagNumber(18)
  void clearSenderCurrencyCode() => clearField(18);

  @$pb.TagNumber(19)
  $core.List<$core.double> get senderDenominations => $_getList(18);

  @$pb.TagNumber(20)
  $core.double get minSenderAmount => $_getN(19);
  @$pb.TagNumber(20)
  set minSenderAmount($core.double v) { $_setDouble(19, v); }
  @$pb.TagNumber(20)
  $core.bool hasMinSenderAmount() => $_has(19);
  @$pb.TagNumber(20)
  void clearMinSenderAmount() => clearField(20);

  @$pb.TagNumber(21)
  $core.double get maxSenderAmount => $_getN(20);
  @$pb.TagNumber(21)
  set maxSenderAmount($core.double v) { $_setDouble(20, v); }
  @$pb.TagNumber(21)
  $core.bool hasMaxSenderAmount() => $_has(20);
  @$pb.TagNumber(21)
  void clearMaxSenderAmount() => clearField(21);

  @$pb.TagNumber(22)
  $core.double get senderFee => $_getN(21);
  @$pb.TagNumber(22)
  set senderFee($core.double v) { $_setDouble(21, v); }
  @$pb.TagNumber(22)
  $core.bool hasSenderFee() => $_has(21);
  @$pb.TagNumber(22)
  void clearSenderFee() => clearField(22);

  @$pb.TagNumber(23)
  $core.double get senderFeePercentage => $_getN(22);
  @$pb.TagNumber(23)
  set senderFeePercentage($core.double v) { $_setDouble(22, v); }
  @$pb.TagNumber(23)
  $core.bool hasSenderFeePercentage() => $_has(22);
  @$pb.TagNumber(23)
  void clearSenderFeePercentage() => clearField(23);

  @$pb.TagNumber(24)
  $core.List<GiftCardDenomination> get fixedSenderDenominations => $_getList(23);
}

class GiftCardDenomination extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GiftCardDenomination', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..a<$core.double>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'price', $pb.PbFieldType.OD)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currencyCode')
    ..hasRequiredFields = false
  ;

  GiftCardDenomination._() : super();
  factory GiftCardDenomination({
    $core.double? price,
    $core.String? currencyCode,
  }) {
    final _result = create();
    if (price != null) {
      _result.price = price;
    }
    if (currencyCode != null) {
      _result.currencyCode = currencyCode;
    }
    return _result;
  }
  factory GiftCardDenomination.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GiftCardDenomination.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GiftCardDenomination clone() => GiftCardDenomination()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GiftCardDenomination copyWith(void Function(GiftCardDenomination) updates) => super.copyWith((message) => updates(message as GiftCardDenomination)) as GiftCardDenomination; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GiftCardDenomination create() => GiftCardDenomination._();
  GiftCardDenomination createEmptyInstance() => create();
  static $pb.PbList<GiftCardDenomination> createRepeated() => $pb.PbList<GiftCardDenomination>();
  @$core.pragma('dart2js:noInline')
  static GiftCardDenomination getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GiftCardDenomination>(create);
  static GiftCardDenomination? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get price => $_getN(0);
  @$pb.TagNumber(1)
  set price($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPrice() => $_has(0);
  @$pb.TagNumber(1)
  void clearPrice() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get currencyCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set currencyCode($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCurrencyCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearCurrencyCode() => clearField(2);
}

class GiftCardTransaction extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GiftCardTransaction', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'giftCardId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionType')
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..a<$core.double>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'balanceBefore', $pb.PbFieldType.OD)
    ..a<$core.double>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'balanceAfter', $pb.PbFieldType.OD)
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt')
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerTransactionId')
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reference')
    ..hasRequiredFields = false
  ;

  GiftCardTransaction._() : super();
  factory GiftCardTransaction({
    $core.String? id,
    $core.String? giftCardId,
    $core.String? userId,
    $core.String? transactionType,
    $core.double? amount,
    $core.double? balanceBefore,
    $core.double? balanceAfter,
    $core.String? description,
    $core.String? createdAt,
    $core.String? providerTransactionId,
    $core.String? reference,
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
    if (transactionType != null) {
      _result.transactionType = transactionType;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (balanceBefore != null) {
      _result.balanceBefore = balanceBefore;
    }
    if (balanceAfter != null) {
      _result.balanceAfter = balanceAfter;
    }
    if (description != null) {
      _result.description = description;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (providerTransactionId != null) {
      _result.providerTransactionId = providerTransactionId;
    }
    if (reference != null) {
      _result.reference = reference;
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
  $core.String get transactionType => $_getSZ(3);
  @$pb.TagNumber(4)
  set transactionType($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTransactionType() => $_has(3);
  @$pb.TagNumber(4)
  void clearTransactionType() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get amount => $_getN(4);
  @$pb.TagNumber(5)
  set amount($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearAmount() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get balanceBefore => $_getN(5);
  @$pb.TagNumber(6)
  set balanceBefore($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasBalanceBefore() => $_has(5);
  @$pb.TagNumber(6)
  void clearBalanceBefore() => clearField(6);

  @$pb.TagNumber(7)
  $core.double get balanceAfter => $_getN(6);
  @$pb.TagNumber(7)
  set balanceAfter($core.double v) { $_setDouble(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasBalanceAfter() => $_has(6);
  @$pb.TagNumber(7)
  void clearBalanceAfter() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get description => $_getSZ(7);
  @$pb.TagNumber(8)
  set description($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasDescription() => $_has(7);
  @$pb.TagNumber(8)
  void clearDescription() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get createdAt => $_getSZ(8);
  @$pb.TagNumber(9)
  set createdAt($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasCreatedAt() => $_has(8);
  @$pb.TagNumber(9)
  void clearCreatedAt() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get providerTransactionId => $_getSZ(9);
  @$pb.TagNumber(10)
  set providerTransactionId($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasProviderTransactionId() => $_has(9);
  @$pb.TagNumber(10)
  void clearProviderTransactionId() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get reference => $_getSZ(10);
  @$pb.TagNumber(11)
  set reference($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasReference() => $_has(10);
  @$pb.TagNumber(11)
  void clearReference() => clearField(11);
}

class BuyGiftCardRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'BuyGiftCardRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'brandId')
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recipientEmail')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recipientName')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'giftMessage')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionId')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'verificationToken')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'idempotencyKey')
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'senderName')
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recipientPhone')
    ..aInt64(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'productId')
    ..aOS(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'countryCode')
    ..a<$core.int>(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'quantity', $pb.PbFieldType.O3)
    ..aOS(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerName')
    ..a<$core.double>(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'senderAmount', $pb.PbFieldType.OD)
    ..aOS(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'senderCurrency')
    ..hasRequiredFields = false
  ;

  BuyGiftCardRequest._() : super();
  factory BuyGiftCardRequest({
    $core.String? accountId,
    $core.String? brandId,
    $core.double? amount,
    $core.String? recipientEmail,
    $core.String? recipientName,
    $core.String? giftMessage,
    $core.String? transactionId,
    $core.String? verificationToken,
    $core.String? idempotencyKey,
    $core.String? senderName,
    $core.String? recipientPhone,
    $fixnum.Int64? productId,
    $core.String? countryCode,
    $core.int? quantity,
    $core.String? providerName,
    $core.double? senderAmount,
    $core.String? senderCurrency,
  }) {
    final _result = create();
    if (accountId != null) {
      _result.accountId = accountId;
    }
    if (brandId != null) {
      _result.brandId = brandId;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (recipientEmail != null) {
      _result.recipientEmail = recipientEmail;
    }
    if (recipientName != null) {
      _result.recipientName = recipientName;
    }
    if (giftMessage != null) {
      _result.giftMessage = giftMessage;
    }
    if (transactionId != null) {
      _result.transactionId = transactionId;
    }
    if (verificationToken != null) {
      _result.verificationToken = verificationToken;
    }
    if (idempotencyKey != null) {
      _result.idempotencyKey = idempotencyKey;
    }
    if (senderName != null) {
      _result.senderName = senderName;
    }
    if (recipientPhone != null) {
      _result.recipientPhone = recipientPhone;
    }
    if (productId != null) {
      _result.productId = productId;
    }
    if (countryCode != null) {
      _result.countryCode = countryCode;
    }
    if (quantity != null) {
      _result.quantity = quantity;
    }
    if (providerName != null) {
      _result.providerName = providerName;
    }
    if (senderAmount != null) {
      _result.senderAmount = senderAmount;
    }
    if (senderCurrency != null) {
      _result.senderCurrency = senderCurrency;
    }
    return _result;
  }
  factory BuyGiftCardRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BuyGiftCardRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BuyGiftCardRequest clone() => BuyGiftCardRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BuyGiftCardRequest copyWith(void Function(BuyGiftCardRequest) updates) => super.copyWith((message) => updates(message as BuyGiftCardRequest)) as BuyGiftCardRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static BuyGiftCardRequest create() => BuyGiftCardRequest._();
  BuyGiftCardRequest createEmptyInstance() => create();
  static $pb.PbList<BuyGiftCardRequest> createRepeated() => $pb.PbList<BuyGiftCardRequest>();
  @$core.pragma('dart2js:noInline')
  static BuyGiftCardRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BuyGiftCardRequest>(create);
  static BuyGiftCardRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get brandId => $_getSZ(1);
  @$pb.TagNumber(2)
  set brandId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasBrandId() => $_has(1);
  @$pb.TagNumber(2)
  void clearBrandId() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get amount => $_getN(2);
  @$pb.TagNumber(3)
  set amount($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get recipientEmail => $_getSZ(3);
  @$pb.TagNumber(4)
  set recipientEmail($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasRecipientEmail() => $_has(3);
  @$pb.TagNumber(4)
  void clearRecipientEmail() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get recipientName => $_getSZ(4);
  @$pb.TagNumber(5)
  set recipientName($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasRecipientName() => $_has(4);
  @$pb.TagNumber(5)
  void clearRecipientName() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get giftMessage => $_getSZ(5);
  @$pb.TagNumber(6)
  set giftMessage($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasGiftMessage() => $_has(5);
  @$pb.TagNumber(6)
  void clearGiftMessage() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get transactionId => $_getSZ(6);
  @$pb.TagNumber(7)
  set transactionId($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasTransactionId() => $_has(6);
  @$pb.TagNumber(7)
  void clearTransactionId() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get verificationToken => $_getSZ(7);
  @$pb.TagNumber(8)
  set verificationToken($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasVerificationToken() => $_has(7);
  @$pb.TagNumber(8)
  void clearVerificationToken() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get idempotencyKey => $_getSZ(8);
  @$pb.TagNumber(9)
  set idempotencyKey($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasIdempotencyKey() => $_has(8);
  @$pb.TagNumber(9)
  void clearIdempotencyKey() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get senderName => $_getSZ(9);
  @$pb.TagNumber(10)
  set senderName($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasSenderName() => $_has(9);
  @$pb.TagNumber(10)
  void clearSenderName() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get recipientPhone => $_getSZ(10);
  @$pb.TagNumber(11)
  set recipientPhone($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasRecipientPhone() => $_has(10);
  @$pb.TagNumber(11)
  void clearRecipientPhone() => clearField(11);

  @$pb.TagNumber(12)
  $fixnum.Int64 get productId => $_getI64(11);
  @$pb.TagNumber(12)
  set productId($fixnum.Int64 v) { $_setInt64(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasProductId() => $_has(11);
  @$pb.TagNumber(12)
  void clearProductId() => clearField(12);

  @$pb.TagNumber(13)
  $core.String get countryCode => $_getSZ(12);
  @$pb.TagNumber(13)
  set countryCode($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasCountryCode() => $_has(12);
  @$pb.TagNumber(13)
  void clearCountryCode() => clearField(13);

  @$pb.TagNumber(14)
  $core.int get quantity => $_getIZ(13);
  @$pb.TagNumber(14)
  set quantity($core.int v) { $_setSignedInt32(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasQuantity() => $_has(13);
  @$pb.TagNumber(14)
  void clearQuantity() => clearField(14);

  @$pb.TagNumber(15)
  $core.String get providerName => $_getSZ(14);
  @$pb.TagNumber(15)
  set providerName($core.String v) { $_setString(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasProviderName() => $_has(14);
  @$pb.TagNumber(15)
  void clearProviderName() => clearField(15);

  @$pb.TagNumber(16)
  $core.double get senderAmount => $_getN(15);
  @$pb.TagNumber(16)
  set senderAmount($core.double v) { $_setDouble(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasSenderAmount() => $_has(15);
  @$pb.TagNumber(16)
  void clearSenderAmount() => clearField(16);

  @$pb.TagNumber(17)
  $core.String get senderCurrency => $_getSZ(16);
  @$pb.TagNumber(17)
  set senderCurrency($core.String v) { $_setString(16, v); }
  @$pb.TagNumber(17)
  $core.bool hasSenderCurrency() => $_has(16);
  @$pb.TagNumber(17)
  void clearSenderCurrency() => clearField(17);
}

class BuyGiftCardResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'BuyGiftCardResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOM<GiftCard>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'giftCard', subBuilder: GiftCard.create)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'newBalance', $pb.PbFieldType.OD)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerTransactionId')
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'senderAmount', $pb.PbFieldType.OD)
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'senderCurrency')
    ..a<$core.double>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recipientAmount', $pb.PbFieldType.OD)
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recipientCurrency')
    ..hasRequiredFields = false
  ;

  BuyGiftCardResponse._() : super();
  factory BuyGiftCardResponse({
    GiftCard? giftCard,
    $core.double? newBalance,
    $core.String? message,
    $core.String? providerTransactionId,
    $core.double? senderAmount,
    $core.String? senderCurrency,
    $core.double? recipientAmount,
    $core.String? recipientCurrency,
  }) {
    final _result = create();
    if (giftCard != null) {
      _result.giftCard = giftCard;
    }
    if (newBalance != null) {
      _result.newBalance = newBalance;
    }
    if (message != null) {
      _result.message = message;
    }
    if (providerTransactionId != null) {
      _result.providerTransactionId = providerTransactionId;
    }
    if (senderAmount != null) {
      _result.senderAmount = senderAmount;
    }
    if (senderCurrency != null) {
      _result.senderCurrency = senderCurrency;
    }
    if (recipientAmount != null) {
      _result.recipientAmount = recipientAmount;
    }
    if (recipientCurrency != null) {
      _result.recipientCurrency = recipientCurrency;
    }
    return _result;
  }
  factory BuyGiftCardResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BuyGiftCardResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BuyGiftCardResponse clone() => BuyGiftCardResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BuyGiftCardResponse copyWith(void Function(BuyGiftCardResponse) updates) => super.copyWith((message) => updates(message as BuyGiftCardResponse)) as BuyGiftCardResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static BuyGiftCardResponse create() => BuyGiftCardResponse._();
  BuyGiftCardResponse createEmptyInstance() => create();
  static $pb.PbList<BuyGiftCardResponse> createRepeated() => $pb.PbList<BuyGiftCardResponse>();
  @$core.pragma('dart2js:noInline')
  static BuyGiftCardResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BuyGiftCardResponse>(create);
  static BuyGiftCardResponse? _defaultInstance;

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

  @$pb.TagNumber(4)
  $core.String get providerTransactionId => $_getSZ(3);
  @$pb.TagNumber(4)
  set providerTransactionId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasProviderTransactionId() => $_has(3);
  @$pb.TagNumber(4)
  void clearProviderTransactionId() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get senderAmount => $_getN(4);
  @$pb.TagNumber(5)
  set senderAmount($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasSenderAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearSenderAmount() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get senderCurrency => $_getSZ(5);
  @$pb.TagNumber(6)
  set senderCurrency($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasSenderCurrency() => $_has(5);
  @$pb.TagNumber(6)
  void clearSenderCurrency() => clearField(6);

  @$pb.TagNumber(7)
  $core.double get recipientAmount => $_getN(6);
  @$pb.TagNumber(7)
  set recipientAmount($core.double v) { $_setDouble(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasRecipientAmount() => $_has(6);
  @$pb.TagNumber(7)
  void clearRecipientAmount() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get recipientCurrency => $_getSZ(7);
  @$pb.TagNumber(8)
  set recipientCurrency($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasRecipientCurrency() => $_has(7);
  @$pb.TagNumber(8)
  void clearRecipientCurrency() => clearField(8);
}

class GetRedeemCodeRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetRedeemCodeRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionId')
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'forceRefresh')
    ..hasRequiredFields = false
  ;

  GetRedeemCodeRequest._() : super();
  factory GetRedeemCodeRequest({
    $core.String? transactionId,
    $core.bool? forceRefresh,
  }) {
    final _result = create();
    if (transactionId != null) {
      _result.transactionId = transactionId;
    }
    if (forceRefresh != null) {
      _result.forceRefresh = forceRefresh;
    }
    return _result;
  }
  factory GetRedeemCodeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetRedeemCodeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetRedeemCodeRequest clone() => GetRedeemCodeRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetRedeemCodeRequest copyWith(void Function(GetRedeemCodeRequest) updates) => super.copyWith((message) => updates(message as GetRedeemCodeRequest)) as GetRedeemCodeRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetRedeemCodeRequest create() => GetRedeemCodeRequest._();
  GetRedeemCodeRequest createEmptyInstance() => create();
  static $pb.PbList<GetRedeemCodeRequest> createRepeated() => $pb.PbList<GetRedeemCodeRequest>();
  @$core.pragma('dart2js:noInline')
  static GetRedeemCodeRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetRedeemCodeRequest>(create);
  static GetRedeemCodeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get transactionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set transactionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTransactionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransactionId() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get forceRefresh => $_getBF(1);
  @$pb.TagNumber(2)
  set forceRefresh($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasForceRefresh() => $_has(1);
  @$pb.TagNumber(2)
  void clearForceRefresh() => clearField(2);
}

class GetRedeemCodeResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetRedeemCodeResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'redemptionCode')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'redemptionPin')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'brandName')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'redemptionInstructions')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  GetRedeemCodeResponse._() : super();
  factory GetRedeemCodeResponse({
    $core.String? transactionId,
    $core.String? redemptionCode,
    $core.String? redemptionPin,
    $core.String? brandName,
    $core.String? redemptionInstructions,
    $core.String? status,
    $core.String? message,
  }) {
    final _result = create();
    if (transactionId != null) {
      _result.transactionId = transactionId;
    }
    if (redemptionCode != null) {
      _result.redemptionCode = redemptionCode;
    }
    if (redemptionPin != null) {
      _result.redemptionPin = redemptionPin;
    }
    if (brandName != null) {
      _result.brandName = brandName;
    }
    if (redemptionInstructions != null) {
      _result.redemptionInstructions = redemptionInstructions;
    }
    if (status != null) {
      _result.status = status;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory GetRedeemCodeResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetRedeemCodeResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetRedeemCodeResponse clone() => GetRedeemCodeResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetRedeemCodeResponse copyWith(void Function(GetRedeemCodeResponse) updates) => super.copyWith((message) => updates(message as GetRedeemCodeResponse)) as GetRedeemCodeResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetRedeemCodeResponse create() => GetRedeemCodeResponse._();
  GetRedeemCodeResponse createEmptyInstance() => create();
  static $pb.PbList<GetRedeemCodeResponse> createRepeated() => $pb.PbList<GetRedeemCodeResponse>();
  @$core.pragma('dart2js:noInline')
  static GetRedeemCodeResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetRedeemCodeResponse>(create);
  static GetRedeemCodeResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get transactionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set transactionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTransactionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransactionId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get redemptionCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set redemptionCode($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasRedemptionCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearRedemptionCode() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get redemptionPin => $_getSZ(2);
  @$pb.TagNumber(3)
  set redemptionPin($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasRedemptionPin() => $_has(2);
  @$pb.TagNumber(3)
  void clearRedemptionPin() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get brandName => $_getSZ(3);
  @$pb.TagNumber(4)
  set brandName($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasBrandName() => $_has(3);
  @$pb.TagNumber(4)
  void clearBrandName() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get redemptionInstructions => $_getSZ(4);
  @$pb.TagNumber(5)
  set redemptionInstructions($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasRedemptionInstructions() => $_has(4);
  @$pb.TagNumber(5)
  void clearRedemptionInstructions() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get status => $_getSZ(5);
  @$pb.TagNumber(6)
  set status($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasStatus() => $_has(5);
  @$pb.TagNumber(6)
  void clearStatus() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get message => $_getSZ(6);
  @$pb.TagNumber(7)
  set message($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasMessage() => $_has(6);
  @$pb.TagNumber(7)
  void clearMessage() => clearField(7);
}

class GetGiftCardsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetGiftCardsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'brandId')
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetGiftCardsRequest._() : super();
  factory GetGiftCardsRequest({
    $core.String? status,
    $core.String? brandId,
    $core.int? limit,
    $core.int? offset,
  }) {
    final _result = create();
    if (status != null) {
      _result.status = status;
    }
    if (brandId != null) {
      _result.brandId = brandId;
    }
    if (limit != null) {
      _result.limit = limit;
    }
    if (offset != null) {
      _result.offset = offset;
    }
    return _result;
  }
  factory GetGiftCardsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetGiftCardsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetGiftCardsRequest clone() => GetGiftCardsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetGiftCardsRequest copyWith(void Function(GetGiftCardsRequest) updates) => super.copyWith((message) => updates(message as GetGiftCardsRequest)) as GetGiftCardsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetGiftCardsRequest create() => GetGiftCardsRequest._();
  GetGiftCardsRequest createEmptyInstance() => create();
  static $pb.PbList<GetGiftCardsRequest> createRepeated() => $pb.PbList<GetGiftCardsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetGiftCardsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetGiftCardsRequest>(create);
  static GetGiftCardsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get status => $_getSZ(0);
  @$pb.TagNumber(1)
  set status($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get brandId => $_getSZ(1);
  @$pb.TagNumber(2)
  set brandId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasBrandId() => $_has(1);
  @$pb.TagNumber(2)
  void clearBrandId() => clearField(2);

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

class GetGiftCardsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetGiftCardsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..pc<GiftCard>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'giftCards', $pb.PbFieldType.PM, subBuilder: GiftCard.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'total', $pb.PbFieldType.O3)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalValue', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  GetGiftCardsResponse._() : super();
  factory GetGiftCardsResponse({
    $core.Iterable<GiftCard>? giftCards,
    $core.int? total,
    $core.double? totalValue,
  }) {
    final _result = create();
    if (giftCards != null) {
      _result.giftCards.addAll(giftCards);
    }
    if (total != null) {
      _result.total = total;
    }
    if (totalValue != null) {
      _result.totalValue = totalValue;
    }
    return _result;
  }
  factory GetGiftCardsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetGiftCardsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetGiftCardsResponse clone() => GetGiftCardsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetGiftCardsResponse copyWith(void Function(GetGiftCardsResponse) updates) => super.copyWith((message) => updates(message as GetGiftCardsResponse)) as GetGiftCardsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetGiftCardsResponse create() => GetGiftCardsResponse._();
  GetGiftCardsResponse createEmptyInstance() => create();
  static $pb.PbList<GetGiftCardsResponse> createRepeated() => $pb.PbList<GetGiftCardsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetGiftCardsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetGiftCardsResponse>(create);
  static GetGiftCardsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<GiftCard> get giftCards => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get totalValue => $_getN(2);
  @$pb.TagNumber(3)
  set totalValue($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTotalValue() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalValue() => clearField(3);
}

class GetGiftCardRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetGiftCardRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'giftCardId')
    ..hasRequiredFields = false
  ;

  GetGiftCardRequest._() : super();
  factory GetGiftCardRequest({
    $core.String? giftCardId,
  }) {
    final _result = create();
    if (giftCardId != null) {
      _result.giftCardId = giftCardId;
    }
    return _result;
  }
  factory GetGiftCardRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetGiftCardRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetGiftCardRequest clone() => GetGiftCardRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetGiftCardRequest copyWith(void Function(GetGiftCardRequest) updates) => super.copyWith((message) => updates(message as GetGiftCardRequest)) as GetGiftCardRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetGiftCardRequest create() => GetGiftCardRequest._();
  GetGiftCardRequest createEmptyInstance() => create();
  static $pb.PbList<GetGiftCardRequest> createRepeated() => $pb.PbList<GetGiftCardRequest>();
  @$core.pragma('dart2js:noInline')
  static GetGiftCardRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetGiftCardRequest>(create);
  static GetGiftCardRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get giftCardId => $_getSZ(0);
  @$pb.TagNumber(1)
  set giftCardId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasGiftCardId() => $_has(0);
  @$pb.TagNumber(1)
  void clearGiftCardId() => clearField(1);
}

class GetGiftCardResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetGiftCardResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOM<GiftCard>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'giftCard', subBuilder: GiftCard.create)
    ..hasRequiredFields = false
  ;

  GetGiftCardResponse._() : super();
  factory GetGiftCardResponse({
    GiftCard? giftCard,
  }) {
    final _result = create();
    if (giftCard != null) {
      _result.giftCard = giftCard;
    }
    return _result;
  }
  factory GetGiftCardResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetGiftCardResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetGiftCardResponse clone() => GetGiftCardResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetGiftCardResponse copyWith(void Function(GetGiftCardResponse) updates) => super.copyWith((message) => updates(message as GetGiftCardResponse)) as GetGiftCardResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetGiftCardResponse create() => GetGiftCardResponse._();
  GetGiftCardResponse createEmptyInstance() => create();
  static $pb.PbList<GetGiftCardResponse> createRepeated() => $pb.PbList<GetGiftCardResponse>();
  @$core.pragma('dart2js:noInline')
  static GetGiftCardResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetGiftCardResponse>(create);
  static GetGiftCardResponse? _defaultInstance;

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

class TransferGiftCardRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TransferGiftCardRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'giftCardId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recipientEmail')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recipientName')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionId')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'verificationToken')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recipientUserId')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transferType')
    ..hasRequiredFields = false
  ;

  TransferGiftCardRequest._() : super();
  factory TransferGiftCardRequest({
    $core.String? giftCardId,
    $core.String? recipientEmail,
    $core.String? recipientName,
    $core.String? message,
    $core.String? transactionId,
    $core.String? verificationToken,
    $core.String? recipientUserId,
    $core.String? transferType,
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
    if (transactionId != null) {
      _result.transactionId = transactionId;
    }
    if (verificationToken != null) {
      _result.verificationToken = verificationToken;
    }
    if (recipientUserId != null) {
      _result.recipientUserId = recipientUserId;
    }
    if (transferType != null) {
      _result.transferType = transferType;
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

  @$pb.TagNumber(7)
  $core.String get recipientUserId => $_getSZ(6);
  @$pb.TagNumber(7)
  set recipientUserId($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasRecipientUserId() => $_has(6);
  @$pb.TagNumber(7)
  void clearRecipientUserId() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get transferType => $_getSZ(7);
  @$pb.TagNumber(8)
  set transferType($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasTransferType() => $_has(7);
  @$pb.TagNumber(8)
  void clearTransferType() => clearField(8);
}

class TransferGiftCardResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TransferGiftCardResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOM<GiftCard>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'giftCard', subBuilder: GiftCard.create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOM<GiftCard>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recipientGiftCard', subBuilder: GiftCard.create)
    ..hasRequiredFields = false
  ;

  TransferGiftCardResponse._() : super();
  factory TransferGiftCardResponse({
    GiftCard? giftCard,
    $core.String? message,
    GiftCard? recipientGiftCard,
  }) {
    final _result = create();
    if (giftCard != null) {
      _result.giftCard = giftCard;
    }
    if (message != null) {
      _result.message = message;
    }
    if (recipientGiftCard != null) {
      _result.recipientGiftCard = recipientGiftCard;
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

  @$pb.TagNumber(3)
  GiftCard get recipientGiftCard => $_getN(2);
  @$pb.TagNumber(3)
  set recipientGiftCard(GiftCard v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasRecipientGiftCard() => $_has(2);
  @$pb.TagNumber(3)
  void clearRecipientGiftCard() => clearField(3);
  @$pb.TagNumber(3)
  GiftCard ensureRecipientGiftCard() => $_ensure(2);
}

class GetGiftCardBrandsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetGiftCardBrandsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'category')
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'activeOnly')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'countryCode')
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'searchQuery')
    ..hasRequiredFields = false
  ;

  GetGiftCardBrandsRequest._() : super();
  factory GetGiftCardBrandsRequest({
    $core.String? category,
    $core.bool? activeOnly,
    $core.String? countryCode,
    $core.int? page,
    $core.int? pageSize,
    $core.String? searchQuery,
  }) {
    final _result = create();
    if (category != null) {
      _result.category = category;
    }
    if (activeOnly != null) {
      _result.activeOnly = activeOnly;
    }
    if (countryCode != null) {
      _result.countryCode = countryCode;
    }
    if (page != null) {
      _result.page = page;
    }
    if (pageSize != null) {
      _result.pageSize = pageSize;
    }
    if (searchQuery != null) {
      _result.searchQuery = searchQuery;
    }
    return _result;
  }
  factory GetGiftCardBrandsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetGiftCardBrandsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetGiftCardBrandsRequest clone() => GetGiftCardBrandsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetGiftCardBrandsRequest copyWith(void Function(GetGiftCardBrandsRequest) updates) => super.copyWith((message) => updates(message as GetGiftCardBrandsRequest)) as GetGiftCardBrandsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetGiftCardBrandsRequest create() => GetGiftCardBrandsRequest._();
  GetGiftCardBrandsRequest createEmptyInstance() => create();
  static $pb.PbList<GetGiftCardBrandsRequest> createRepeated() => $pb.PbList<GetGiftCardBrandsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetGiftCardBrandsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetGiftCardBrandsRequest>(create);
  static GetGiftCardBrandsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get category => $_getSZ(0);
  @$pb.TagNumber(1)
  set category($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCategory() => $_has(0);
  @$pb.TagNumber(1)
  void clearCategory() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get activeOnly => $_getBF(1);
  @$pb.TagNumber(2)
  set activeOnly($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasActiveOnly() => $_has(1);
  @$pb.TagNumber(2)
  void clearActiveOnly() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get countryCode => $_getSZ(2);
  @$pb.TagNumber(3)
  set countryCode($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCountryCode() => $_has(2);
  @$pb.TagNumber(3)
  void clearCountryCode() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get page => $_getIZ(3);
  @$pb.TagNumber(4)
  set page($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPage() => $_has(3);
  @$pb.TagNumber(4)
  void clearPage() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get pageSize => $_getIZ(4);
  @$pb.TagNumber(5)
  set pageSize($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasPageSize() => $_has(4);
  @$pb.TagNumber(5)
  void clearPageSize() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get searchQuery => $_getSZ(5);
  @$pb.TagNumber(6)
  set searchQuery($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasSearchQuery() => $_has(5);
  @$pb.TagNumber(6)
  void clearSearchQuery() => clearField(6);
}

class GetGiftCardBrandsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetGiftCardBrandsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..pc<GiftCardBrand>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'brands', $pb.PbFieldType.PM, subBuilder: GiftCardBrand.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'total', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalPages', $pb.PbFieldType.O3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currentPage', $pb.PbFieldType.O3)
    ..aOB(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hasNext')
    ..a<$core.int>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetGiftCardBrandsResponse._() : super();
  factory GetGiftCardBrandsResponse({
    $core.Iterable<GiftCardBrand>? brands,
    $core.int? total,
    $core.int? totalPages,
    $core.int? currentPage,
    $core.bool? hasNext,
    $core.int? pageSize,
  }) {
    final _result = create();
    if (brands != null) {
      _result.brands.addAll(brands);
    }
    if (total != null) {
      _result.total = total;
    }
    if (totalPages != null) {
      _result.totalPages = totalPages;
    }
    if (currentPage != null) {
      _result.currentPage = currentPage;
    }
    if (hasNext != null) {
      _result.hasNext = hasNext;
    }
    if (pageSize != null) {
      _result.pageSize = pageSize;
    }
    return _result;
  }
  factory GetGiftCardBrandsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetGiftCardBrandsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetGiftCardBrandsResponse clone() => GetGiftCardBrandsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetGiftCardBrandsResponse copyWith(void Function(GetGiftCardBrandsResponse) updates) => super.copyWith((message) => updates(message as GetGiftCardBrandsResponse)) as GetGiftCardBrandsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetGiftCardBrandsResponse create() => GetGiftCardBrandsResponse._();
  GetGiftCardBrandsResponse createEmptyInstance() => create();
  static $pb.PbList<GetGiftCardBrandsResponse> createRepeated() => $pb.PbList<GetGiftCardBrandsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetGiftCardBrandsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetGiftCardBrandsResponse>(create);
  static GetGiftCardBrandsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<GiftCardBrand> get brands => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get totalPages => $_getIZ(2);
  @$pb.TagNumber(3)
  set totalPages($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTotalPages() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalPages() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get currentPage => $_getIZ(3);
  @$pb.TagNumber(4)
  set currentPage($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCurrentPage() => $_has(3);
  @$pb.TagNumber(4)
  void clearCurrentPage() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get hasNext => $_getBF(4);
  @$pb.TagNumber(5)
  set hasNext($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasHasNext() => $_has(4);
  @$pb.TagNumber(5)
  void clearHasNext() => clearField(5);

  @$pb.TagNumber(6)
  $core.int get pageSize => $_getIZ(5);
  @$pb.TagNumber(6)
  set pageSize($core.int v) { $_setSignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasPageSize() => $_has(5);
  @$pb.TagNumber(6)
  void clearPageSize() => clearField(6);
}

class GetGiftCardHistoryRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetGiftCardHistoryRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'giftCardId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionType')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'startDate')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'endDate')
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetGiftCardHistoryRequest._() : super();
  factory GetGiftCardHistoryRequest({
    $core.String? giftCardId,
    $core.String? transactionType,
    $core.String? startDate,
    $core.String? endDate,
    $core.int? limit,
    $core.int? offset,
  }) {
    final _result = create();
    if (giftCardId != null) {
      _result.giftCardId = giftCardId;
    }
    if (transactionType != null) {
      _result.transactionType = transactionType;
    }
    if (startDate != null) {
      _result.startDate = startDate;
    }
    if (endDate != null) {
      _result.endDate = endDate;
    }
    if (limit != null) {
      _result.limit = limit;
    }
    if (offset != null) {
      _result.offset = offset;
    }
    return _result;
  }
  factory GetGiftCardHistoryRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetGiftCardHistoryRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetGiftCardHistoryRequest clone() => GetGiftCardHistoryRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetGiftCardHistoryRequest copyWith(void Function(GetGiftCardHistoryRequest) updates) => super.copyWith((message) => updates(message as GetGiftCardHistoryRequest)) as GetGiftCardHistoryRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetGiftCardHistoryRequest create() => GetGiftCardHistoryRequest._();
  GetGiftCardHistoryRequest createEmptyInstance() => create();
  static $pb.PbList<GetGiftCardHistoryRequest> createRepeated() => $pb.PbList<GetGiftCardHistoryRequest>();
  @$core.pragma('dart2js:noInline')
  static GetGiftCardHistoryRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetGiftCardHistoryRequest>(create);
  static GetGiftCardHistoryRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get giftCardId => $_getSZ(0);
  @$pb.TagNumber(1)
  set giftCardId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasGiftCardId() => $_has(0);
  @$pb.TagNumber(1)
  void clearGiftCardId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get transactionType => $_getSZ(1);
  @$pb.TagNumber(2)
  set transactionType($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTransactionType() => $_has(1);
  @$pb.TagNumber(2)
  void clearTransactionType() => clearField(2);

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

class GetGiftCardHistoryResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetGiftCardHistoryResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..pc<GiftCardTransaction>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactions', $pb.PbFieldType.PM, subBuilder: GiftCardTransaction.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetGiftCardHistoryResponse._() : super();
  factory GetGiftCardHistoryResponse({
    $core.Iterable<GiftCardTransaction>? transactions,
    $core.int? total,
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
  factory GetGiftCardHistoryResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetGiftCardHistoryResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetGiftCardHistoryResponse clone() => GetGiftCardHistoryResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetGiftCardHistoryResponse copyWith(void Function(GetGiftCardHistoryResponse) updates) => super.copyWith((message) => updates(message as GetGiftCardHistoryResponse)) as GetGiftCardHistoryResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetGiftCardHistoryResponse create() => GetGiftCardHistoryResponse._();
  GetGiftCardHistoryResponse createEmptyInstance() => create();
  static $pb.PbList<GetGiftCardHistoryResponse> createRepeated() => $pb.PbList<GetGiftCardHistoryResponse>();
  @$core.pragma('dart2js:noInline')
  static GetGiftCardHistoryResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetGiftCardHistoryResponse>(create);
  static GetGiftCardHistoryResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<GiftCardTransaction> get transactions => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => clearField(2);
}

class SellableCard extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SellableCard', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cardType')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'displayName')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'logoUrl')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'category')
    ..p<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'denominations', $pb.PbFieldType.KD)
    ..pPS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currencies')
    ..a<$core.double>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'minDenomination', $pb.PbFieldType.OD)
    ..a<$core.double>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'maxDenomination', $pb.PbFieldType.OD)
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerName')
    ..hasRequiredFields = false
  ;

  SellableCard._() : super();
  factory SellableCard({
    $core.String? cardType,
    $core.String? displayName,
    $core.String? logoUrl,
    $core.String? category,
    $core.Iterable<$core.double>? denominations,
    $core.Iterable<$core.String>? currencies,
    $core.double? minDenomination,
    $core.double? maxDenomination,
    $core.String? providerName,
  }) {
    final _result = create();
    if (cardType != null) {
      _result.cardType = cardType;
    }
    if (displayName != null) {
      _result.displayName = displayName;
    }
    if (logoUrl != null) {
      _result.logoUrl = logoUrl;
    }
    if (category != null) {
      _result.category = category;
    }
    if (denominations != null) {
      _result.denominations.addAll(denominations);
    }
    if (currencies != null) {
      _result.currencies.addAll(currencies);
    }
    if (minDenomination != null) {
      _result.minDenomination = minDenomination;
    }
    if (maxDenomination != null) {
      _result.maxDenomination = maxDenomination;
    }
    if (providerName != null) {
      _result.providerName = providerName;
    }
    return _result;
  }
  factory SellableCard.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SellableCard.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SellableCard clone() => SellableCard()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SellableCard copyWith(void Function(SellableCard) updates) => super.copyWith((message) => updates(message as SellableCard)) as SellableCard; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SellableCard create() => SellableCard._();
  SellableCard createEmptyInstance() => create();
  static $pb.PbList<SellableCard> createRepeated() => $pb.PbList<SellableCard>();
  @$core.pragma('dart2js:noInline')
  static SellableCard getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SellableCard>(create);
  static SellableCard? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get cardType => $_getSZ(0);
  @$pb.TagNumber(1)
  set cardType($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCardType() => $_has(0);
  @$pb.TagNumber(1)
  void clearCardType() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get displayName => $_getSZ(1);
  @$pb.TagNumber(2)
  set displayName($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasDisplayName() => $_has(1);
  @$pb.TagNumber(2)
  void clearDisplayName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get logoUrl => $_getSZ(2);
  @$pb.TagNumber(3)
  set logoUrl($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasLogoUrl() => $_has(2);
  @$pb.TagNumber(3)
  void clearLogoUrl() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get category => $_getSZ(3);
  @$pb.TagNumber(4)
  set category($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCategory() => $_has(3);
  @$pb.TagNumber(4)
  void clearCategory() => clearField(4);

  @$pb.TagNumber(5)
  $core.List<$core.double> get denominations => $_getList(4);

  @$pb.TagNumber(6)
  $core.List<$core.String> get currencies => $_getList(5);

  @$pb.TagNumber(7)
  $core.double get minDenomination => $_getN(6);
  @$pb.TagNumber(7)
  set minDenomination($core.double v) { $_setDouble(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasMinDenomination() => $_has(6);
  @$pb.TagNumber(7)
  void clearMinDenomination() => clearField(7);

  @$pb.TagNumber(8)
  $core.double get maxDenomination => $_getN(7);
  @$pb.TagNumber(8)
  set maxDenomination($core.double v) { $_setDouble(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasMaxDenomination() => $_has(7);
  @$pb.TagNumber(8)
  void clearMaxDenomination() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get providerName => $_getSZ(8);
  @$pb.TagNumber(9)
  set providerName($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasProviderName() => $_has(8);
  @$pb.TagNumber(9)
  void clearProviderName() => clearField(9);
}

class SellRate extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SellRate', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cardType')
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'denomination', $pb.PbFieldType.OD)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ratePercentage', $pb.PbFieldType.OD)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payoutAmount', $pb.PbFieldType.OD)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'expiresAt')
    ..hasRequiredFields = false
  ;

  SellRate._() : super();
  factory SellRate({
    $core.String? cardType,
    $core.double? denomination,
    $core.double? ratePercentage,
    $core.double? payoutAmount,
    $core.String? currency,
    $core.String? expiresAt,
  }) {
    final _result = create();
    if (cardType != null) {
      _result.cardType = cardType;
    }
    if (denomination != null) {
      _result.denomination = denomination;
    }
    if (ratePercentage != null) {
      _result.ratePercentage = ratePercentage;
    }
    if (payoutAmount != null) {
      _result.payoutAmount = payoutAmount;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (expiresAt != null) {
      _result.expiresAt = expiresAt;
    }
    return _result;
  }
  factory SellRate.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SellRate.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SellRate clone() => SellRate()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SellRate copyWith(void Function(SellRate) updates) => super.copyWith((message) => updates(message as SellRate)) as SellRate; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SellRate create() => SellRate._();
  SellRate createEmptyInstance() => create();
  static $pb.PbList<SellRate> createRepeated() => $pb.PbList<SellRate>();
  @$core.pragma('dart2js:noInline')
  static SellRate getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SellRate>(create);
  static SellRate? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get cardType => $_getSZ(0);
  @$pb.TagNumber(1)
  set cardType($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCardType() => $_has(0);
  @$pb.TagNumber(1)
  void clearCardType() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get denomination => $_getN(1);
  @$pb.TagNumber(2)
  set denomination($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasDenomination() => $_has(1);
  @$pb.TagNumber(2)
  void clearDenomination() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get ratePercentage => $_getN(2);
  @$pb.TagNumber(3)
  set ratePercentage($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasRatePercentage() => $_has(2);
  @$pb.TagNumber(3)
  void clearRatePercentage() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get payoutAmount => $_getN(3);
  @$pb.TagNumber(4)
  set payoutAmount($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPayoutAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearPayoutAmount() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get currency => $_getSZ(4);
  @$pb.TagNumber(5)
  set currency($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasCurrency() => $_has(4);
  @$pb.TagNumber(5)
  void clearCurrency() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get expiresAt => $_getSZ(5);
  @$pb.TagNumber(6)
  set expiresAt($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasExpiresAt() => $_has(5);
  @$pb.TagNumber(6)
  void clearExpiresAt() => clearField(6);
}

class GiftCardSale extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GiftCardSale', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountId')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cardType')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cardNumber')
    ..a<$core.double>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'denomination', $pb.PbFieldType.OD)
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..a<$core.double>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ratePercentage', $pb.PbFieldType.OD)
    ..a<$core.double>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'expectedPayout', $pb.PbFieldType.OD)
    ..a<$core.double>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'actualPayout', $pb.PbFieldType.OD)
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..aOS(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerSaleId')
    ..aOS(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerName')
    ..aOS(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reference')
    ..aOS(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'submittedAt')
    ..aOS(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reviewedAt')
    ..aOS(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paidAt')
    ..aOS(18, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payoutError')
    ..aOS(19, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt')
    ..aOS(20, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedAt')
    ..pPS(21, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'imageUrls')
    ..aOS(22, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ocrBrand')
    ..aOS(23, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ocrCardNumber')
    ..aOS(24, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ocrPin')
    ..a<$core.double>(25, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ocrDenomination', $pb.PbFieldType.OD)
    ..aOS(26, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ocrCurrency')
    ..aOS(27, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'adminReviewerId')
    ..aOS(28, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'rejectionReason')
    ..aOS(29, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'adminNotes')
    ..aOS(30, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cardPin')
    ..a<$core.double>(31, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'exitRatePercent', $pb.PbFieldType.OD)
    ..a<$core.double>(32, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'baseMarginPercent', $pb.PbFieldType.OD)
    ..a<$core.double>(33, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'riskBufferPercent', $pb.PbFieldType.OD)
    ..a<$core.double>(34, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'commissionAmount', $pb.PbFieldType.OD)
    ..a<$core.int>(35, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'riskScore', $pb.PbFieldType.O3)
    ..aOS(36, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'riskLevel')
    ..pPS(37, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'riskFlags')
    ..aOS(38, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'riskAction')
    ..aOS(39, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cardCountry')
    ..aOS(40, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cardFormat')
    ..hasRequiredFields = false
  ;

  GiftCardSale._() : super();
  factory GiftCardSale({
    $core.String? id,
    $core.String? userId,
    $core.String? accountId,
    $core.String? cardType,
    $core.String? cardNumber,
    $core.double? denomination,
    $core.String? currency,
    $core.double? ratePercentage,
    $core.double? expectedPayout,
    $core.double? actualPayout,
    $core.String? status,
    $core.String? providerSaleId,
    $core.String? providerName,
    $core.String? reference,
    $core.String? submittedAt,
    $core.String? reviewedAt,
    $core.String? paidAt,
    $core.String? payoutError,
    $core.String? createdAt,
    $core.String? updatedAt,
    $core.Iterable<$core.String>? imageUrls,
    $core.String? ocrBrand,
    $core.String? ocrCardNumber,
    $core.String? ocrPin,
    $core.double? ocrDenomination,
    $core.String? ocrCurrency,
    $core.String? adminReviewerId,
    $core.String? rejectionReason,
    $core.String? adminNotes,
    $core.String? cardPin,
    $core.double? exitRatePercent,
    $core.double? baseMarginPercent,
    $core.double? riskBufferPercent,
    $core.double? commissionAmount,
    $core.int? riskScore,
    $core.String? riskLevel,
    $core.Iterable<$core.String>? riskFlags,
    $core.String? riskAction,
    $core.String? cardCountry,
    $core.String? cardFormat,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (accountId != null) {
      _result.accountId = accountId;
    }
    if (cardType != null) {
      _result.cardType = cardType;
    }
    if (cardNumber != null) {
      _result.cardNumber = cardNumber;
    }
    if (denomination != null) {
      _result.denomination = denomination;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (ratePercentage != null) {
      _result.ratePercentage = ratePercentage;
    }
    if (expectedPayout != null) {
      _result.expectedPayout = expectedPayout;
    }
    if (actualPayout != null) {
      _result.actualPayout = actualPayout;
    }
    if (status != null) {
      _result.status = status;
    }
    if (providerSaleId != null) {
      _result.providerSaleId = providerSaleId;
    }
    if (providerName != null) {
      _result.providerName = providerName;
    }
    if (reference != null) {
      _result.reference = reference;
    }
    if (submittedAt != null) {
      _result.submittedAt = submittedAt;
    }
    if (reviewedAt != null) {
      _result.reviewedAt = reviewedAt;
    }
    if (paidAt != null) {
      _result.paidAt = paidAt;
    }
    if (payoutError != null) {
      _result.payoutError = payoutError;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      _result.updatedAt = updatedAt;
    }
    if (imageUrls != null) {
      _result.imageUrls.addAll(imageUrls);
    }
    if (ocrBrand != null) {
      _result.ocrBrand = ocrBrand;
    }
    if (ocrCardNumber != null) {
      _result.ocrCardNumber = ocrCardNumber;
    }
    if (ocrPin != null) {
      _result.ocrPin = ocrPin;
    }
    if (ocrDenomination != null) {
      _result.ocrDenomination = ocrDenomination;
    }
    if (ocrCurrency != null) {
      _result.ocrCurrency = ocrCurrency;
    }
    if (adminReviewerId != null) {
      _result.adminReviewerId = adminReviewerId;
    }
    if (rejectionReason != null) {
      _result.rejectionReason = rejectionReason;
    }
    if (adminNotes != null) {
      _result.adminNotes = adminNotes;
    }
    if (cardPin != null) {
      _result.cardPin = cardPin;
    }
    if (exitRatePercent != null) {
      _result.exitRatePercent = exitRatePercent;
    }
    if (baseMarginPercent != null) {
      _result.baseMarginPercent = baseMarginPercent;
    }
    if (riskBufferPercent != null) {
      _result.riskBufferPercent = riskBufferPercent;
    }
    if (commissionAmount != null) {
      _result.commissionAmount = commissionAmount;
    }
    if (riskScore != null) {
      _result.riskScore = riskScore;
    }
    if (riskLevel != null) {
      _result.riskLevel = riskLevel;
    }
    if (riskFlags != null) {
      _result.riskFlags.addAll(riskFlags);
    }
    if (riskAction != null) {
      _result.riskAction = riskAction;
    }
    if (cardCountry != null) {
      _result.cardCountry = cardCountry;
    }
    if (cardFormat != null) {
      _result.cardFormat = cardFormat;
    }
    return _result;
  }
  factory GiftCardSale.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GiftCardSale.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GiftCardSale clone() => GiftCardSale()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GiftCardSale copyWith(void Function(GiftCardSale) updates) => super.copyWith((message) => updates(message as GiftCardSale)) as GiftCardSale; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GiftCardSale create() => GiftCardSale._();
  GiftCardSale createEmptyInstance() => create();
  static $pb.PbList<GiftCardSale> createRepeated() => $pb.PbList<GiftCardSale>();
  @$core.pragma('dart2js:noInline')
  static GiftCardSale getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GiftCardSale>(create);
  static GiftCardSale? _defaultInstance;

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
  $core.String get cardType => $_getSZ(3);
  @$pb.TagNumber(4)
  set cardType($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCardType() => $_has(3);
  @$pb.TagNumber(4)
  void clearCardType() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get cardNumber => $_getSZ(4);
  @$pb.TagNumber(5)
  set cardNumber($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasCardNumber() => $_has(4);
  @$pb.TagNumber(5)
  void clearCardNumber() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get denomination => $_getN(5);
  @$pb.TagNumber(6)
  set denomination($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasDenomination() => $_has(5);
  @$pb.TagNumber(6)
  void clearDenomination() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get currency => $_getSZ(6);
  @$pb.TagNumber(7)
  set currency($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasCurrency() => $_has(6);
  @$pb.TagNumber(7)
  void clearCurrency() => clearField(7);

  @$pb.TagNumber(8)
  $core.double get ratePercentage => $_getN(7);
  @$pb.TagNumber(8)
  set ratePercentage($core.double v) { $_setDouble(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasRatePercentage() => $_has(7);
  @$pb.TagNumber(8)
  void clearRatePercentage() => clearField(8);

  @$pb.TagNumber(9)
  $core.double get expectedPayout => $_getN(8);
  @$pb.TagNumber(9)
  set expectedPayout($core.double v) { $_setDouble(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasExpectedPayout() => $_has(8);
  @$pb.TagNumber(9)
  void clearExpectedPayout() => clearField(9);

  @$pb.TagNumber(10)
  $core.double get actualPayout => $_getN(9);
  @$pb.TagNumber(10)
  set actualPayout($core.double v) { $_setDouble(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasActualPayout() => $_has(9);
  @$pb.TagNumber(10)
  void clearActualPayout() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get status => $_getSZ(10);
  @$pb.TagNumber(11)
  set status($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasStatus() => $_has(10);
  @$pb.TagNumber(11)
  void clearStatus() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get providerSaleId => $_getSZ(11);
  @$pb.TagNumber(12)
  set providerSaleId($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasProviderSaleId() => $_has(11);
  @$pb.TagNumber(12)
  void clearProviderSaleId() => clearField(12);

  @$pb.TagNumber(13)
  $core.String get providerName => $_getSZ(12);
  @$pb.TagNumber(13)
  set providerName($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasProviderName() => $_has(12);
  @$pb.TagNumber(13)
  void clearProviderName() => clearField(13);

  @$pb.TagNumber(14)
  $core.String get reference => $_getSZ(13);
  @$pb.TagNumber(14)
  set reference($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasReference() => $_has(13);
  @$pb.TagNumber(14)
  void clearReference() => clearField(14);

  @$pb.TagNumber(15)
  $core.String get submittedAt => $_getSZ(14);
  @$pb.TagNumber(15)
  set submittedAt($core.String v) { $_setString(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasSubmittedAt() => $_has(14);
  @$pb.TagNumber(15)
  void clearSubmittedAt() => clearField(15);

  @$pb.TagNumber(16)
  $core.String get reviewedAt => $_getSZ(15);
  @$pb.TagNumber(16)
  set reviewedAt($core.String v) { $_setString(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasReviewedAt() => $_has(15);
  @$pb.TagNumber(16)
  void clearReviewedAt() => clearField(16);

  @$pb.TagNumber(17)
  $core.String get paidAt => $_getSZ(16);
  @$pb.TagNumber(17)
  set paidAt($core.String v) { $_setString(16, v); }
  @$pb.TagNumber(17)
  $core.bool hasPaidAt() => $_has(16);
  @$pb.TagNumber(17)
  void clearPaidAt() => clearField(17);

  @$pb.TagNumber(18)
  $core.String get payoutError => $_getSZ(17);
  @$pb.TagNumber(18)
  set payoutError($core.String v) { $_setString(17, v); }
  @$pb.TagNumber(18)
  $core.bool hasPayoutError() => $_has(17);
  @$pb.TagNumber(18)
  void clearPayoutError() => clearField(18);

  @$pb.TagNumber(19)
  $core.String get createdAt => $_getSZ(18);
  @$pb.TagNumber(19)
  set createdAt($core.String v) { $_setString(18, v); }
  @$pb.TagNumber(19)
  $core.bool hasCreatedAt() => $_has(18);
  @$pb.TagNumber(19)
  void clearCreatedAt() => clearField(19);

  @$pb.TagNumber(20)
  $core.String get updatedAt => $_getSZ(19);
  @$pb.TagNumber(20)
  set updatedAt($core.String v) { $_setString(19, v); }
  @$pb.TagNumber(20)
  $core.bool hasUpdatedAt() => $_has(19);
  @$pb.TagNumber(20)
  void clearUpdatedAt() => clearField(20);

  @$pb.TagNumber(21)
  $core.List<$core.String> get imageUrls => $_getList(20);

  @$pb.TagNumber(22)
  $core.String get ocrBrand => $_getSZ(21);
  @$pb.TagNumber(22)
  set ocrBrand($core.String v) { $_setString(21, v); }
  @$pb.TagNumber(22)
  $core.bool hasOcrBrand() => $_has(21);
  @$pb.TagNumber(22)
  void clearOcrBrand() => clearField(22);

  @$pb.TagNumber(23)
  $core.String get ocrCardNumber => $_getSZ(22);
  @$pb.TagNumber(23)
  set ocrCardNumber($core.String v) { $_setString(22, v); }
  @$pb.TagNumber(23)
  $core.bool hasOcrCardNumber() => $_has(22);
  @$pb.TagNumber(23)
  void clearOcrCardNumber() => clearField(23);

  @$pb.TagNumber(24)
  $core.String get ocrPin => $_getSZ(23);
  @$pb.TagNumber(24)
  set ocrPin($core.String v) { $_setString(23, v); }
  @$pb.TagNumber(24)
  $core.bool hasOcrPin() => $_has(23);
  @$pb.TagNumber(24)
  void clearOcrPin() => clearField(24);

  @$pb.TagNumber(25)
  $core.double get ocrDenomination => $_getN(24);
  @$pb.TagNumber(25)
  set ocrDenomination($core.double v) { $_setDouble(24, v); }
  @$pb.TagNumber(25)
  $core.bool hasOcrDenomination() => $_has(24);
  @$pb.TagNumber(25)
  void clearOcrDenomination() => clearField(25);

  @$pb.TagNumber(26)
  $core.String get ocrCurrency => $_getSZ(25);
  @$pb.TagNumber(26)
  set ocrCurrency($core.String v) { $_setString(25, v); }
  @$pb.TagNumber(26)
  $core.bool hasOcrCurrency() => $_has(25);
  @$pb.TagNumber(26)
  void clearOcrCurrency() => clearField(26);

  @$pb.TagNumber(27)
  $core.String get adminReviewerId => $_getSZ(26);
  @$pb.TagNumber(27)
  set adminReviewerId($core.String v) { $_setString(26, v); }
  @$pb.TagNumber(27)
  $core.bool hasAdminReviewerId() => $_has(26);
  @$pb.TagNumber(27)
  void clearAdminReviewerId() => clearField(27);

  @$pb.TagNumber(28)
  $core.String get rejectionReason => $_getSZ(27);
  @$pb.TagNumber(28)
  set rejectionReason($core.String v) { $_setString(27, v); }
  @$pb.TagNumber(28)
  $core.bool hasRejectionReason() => $_has(27);
  @$pb.TagNumber(28)
  void clearRejectionReason() => clearField(28);

  @$pb.TagNumber(29)
  $core.String get adminNotes => $_getSZ(28);
  @$pb.TagNumber(29)
  set adminNotes($core.String v) { $_setString(28, v); }
  @$pb.TagNumber(29)
  $core.bool hasAdminNotes() => $_has(28);
  @$pb.TagNumber(29)
  void clearAdminNotes() => clearField(29);

  @$pb.TagNumber(30)
  $core.String get cardPin => $_getSZ(29);
  @$pb.TagNumber(30)
  set cardPin($core.String v) { $_setString(29, v); }
  @$pb.TagNumber(30)
  $core.bool hasCardPin() => $_has(29);
  @$pb.TagNumber(30)
  void clearCardPin() => clearField(30);

  @$pb.TagNumber(31)
  $core.double get exitRatePercent => $_getN(30);
  @$pb.TagNumber(31)
  set exitRatePercent($core.double v) { $_setDouble(30, v); }
  @$pb.TagNumber(31)
  $core.bool hasExitRatePercent() => $_has(30);
  @$pb.TagNumber(31)
  void clearExitRatePercent() => clearField(31);

  @$pb.TagNumber(32)
  $core.double get baseMarginPercent => $_getN(31);
  @$pb.TagNumber(32)
  set baseMarginPercent($core.double v) { $_setDouble(31, v); }
  @$pb.TagNumber(32)
  $core.bool hasBaseMarginPercent() => $_has(31);
  @$pb.TagNumber(32)
  void clearBaseMarginPercent() => clearField(32);

  @$pb.TagNumber(33)
  $core.double get riskBufferPercent => $_getN(32);
  @$pb.TagNumber(33)
  set riskBufferPercent($core.double v) { $_setDouble(32, v); }
  @$pb.TagNumber(33)
  $core.bool hasRiskBufferPercent() => $_has(32);
  @$pb.TagNumber(33)
  void clearRiskBufferPercent() => clearField(33);

  @$pb.TagNumber(34)
  $core.double get commissionAmount => $_getN(33);
  @$pb.TagNumber(34)
  set commissionAmount($core.double v) { $_setDouble(33, v); }
  @$pb.TagNumber(34)
  $core.bool hasCommissionAmount() => $_has(33);
  @$pb.TagNumber(34)
  void clearCommissionAmount() => clearField(34);

  @$pb.TagNumber(35)
  $core.int get riskScore => $_getIZ(34);
  @$pb.TagNumber(35)
  set riskScore($core.int v) { $_setSignedInt32(34, v); }
  @$pb.TagNumber(35)
  $core.bool hasRiskScore() => $_has(34);
  @$pb.TagNumber(35)
  void clearRiskScore() => clearField(35);

  @$pb.TagNumber(36)
  $core.String get riskLevel => $_getSZ(35);
  @$pb.TagNumber(36)
  set riskLevel($core.String v) { $_setString(35, v); }
  @$pb.TagNumber(36)
  $core.bool hasRiskLevel() => $_has(35);
  @$pb.TagNumber(36)
  void clearRiskLevel() => clearField(36);

  @$pb.TagNumber(37)
  $core.List<$core.String> get riskFlags => $_getList(36);

  @$pb.TagNumber(38)
  $core.String get riskAction => $_getSZ(37);
  @$pb.TagNumber(38)
  set riskAction($core.String v) { $_setString(37, v); }
  @$pb.TagNumber(38)
  $core.bool hasRiskAction() => $_has(37);
  @$pb.TagNumber(38)
  void clearRiskAction() => clearField(38);

  @$pb.TagNumber(39)
  $core.String get cardCountry => $_getSZ(38);
  @$pb.TagNumber(39)
  set cardCountry($core.String v) { $_setString(38, v); }
  @$pb.TagNumber(39)
  $core.bool hasCardCountry() => $_has(38);
  @$pb.TagNumber(39)
  void clearCardCountry() => clearField(39);

  @$pb.TagNumber(40)
  $core.String get cardFormat => $_getSZ(39);
  @$pb.TagNumber(40)
  set cardFormat($core.String v) { $_setString(39, v); }
  @$pb.TagNumber(40)
  $core.bool hasCardFormat() => $_has(39);
  @$pb.TagNumber(40)
  void clearCardFormat() => clearField(40);
}

class GetSellableCardsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetSellableCardsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'countryCode')
    ..hasRequiredFields = false
  ;

  GetSellableCardsRequest._() : super();
  factory GetSellableCardsRequest({
    $core.String? countryCode,
  }) {
    final _result = create();
    if (countryCode != null) {
      _result.countryCode = countryCode;
    }
    return _result;
  }
  factory GetSellableCardsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetSellableCardsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetSellableCardsRequest clone() => GetSellableCardsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetSellableCardsRequest copyWith(void Function(GetSellableCardsRequest) updates) => super.copyWith((message) => updates(message as GetSellableCardsRequest)) as GetSellableCardsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetSellableCardsRequest create() => GetSellableCardsRequest._();
  GetSellableCardsRequest createEmptyInstance() => create();
  static $pb.PbList<GetSellableCardsRequest> createRepeated() => $pb.PbList<GetSellableCardsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetSellableCardsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetSellableCardsRequest>(create);
  static GetSellableCardsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get countryCode => $_getSZ(0);
  @$pb.TagNumber(1)
  set countryCode($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCountryCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearCountryCode() => clearField(1);
}

class GetSellableCardsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetSellableCardsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..pc<SellableCard>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cards', $pb.PbFieldType.PM, subBuilder: SellableCard.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetSellableCardsResponse._() : super();
  factory GetSellableCardsResponse({
    $core.Iterable<SellableCard>? cards,
    $core.int? total,
  }) {
    final _result = create();
    if (cards != null) {
      _result.cards.addAll(cards);
    }
    if (total != null) {
      _result.total = total;
    }
    return _result;
  }
  factory GetSellableCardsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetSellableCardsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetSellableCardsResponse clone() => GetSellableCardsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetSellableCardsResponse copyWith(void Function(GetSellableCardsResponse) updates) => super.copyWith((message) => updates(message as GetSellableCardsResponse)) as GetSellableCardsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetSellableCardsResponse create() => GetSellableCardsResponse._();
  GetSellableCardsResponse createEmptyInstance() => create();
  static $pb.PbList<GetSellableCardsResponse> createRepeated() => $pb.PbList<GetSellableCardsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetSellableCardsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetSellableCardsResponse>(create);
  static GetSellableCardsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<SellableCard> get cards => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => clearField(2);
}

class GetSellRateRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetSellRateRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cardType')
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'denomination', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  GetSellRateRequest._() : super();
  factory GetSellRateRequest({
    $core.String? cardType,
    $core.double? denomination,
  }) {
    final _result = create();
    if (cardType != null) {
      _result.cardType = cardType;
    }
    if (denomination != null) {
      _result.denomination = denomination;
    }
    return _result;
  }
  factory GetSellRateRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetSellRateRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetSellRateRequest clone() => GetSellRateRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetSellRateRequest copyWith(void Function(GetSellRateRequest) updates) => super.copyWith((message) => updates(message as GetSellRateRequest)) as GetSellRateRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetSellRateRequest create() => GetSellRateRequest._();
  GetSellRateRequest createEmptyInstance() => create();
  static $pb.PbList<GetSellRateRequest> createRepeated() => $pb.PbList<GetSellRateRequest>();
  @$core.pragma('dart2js:noInline')
  static GetSellRateRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetSellRateRequest>(create);
  static GetSellRateRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get cardType => $_getSZ(0);
  @$pb.TagNumber(1)
  set cardType($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCardType() => $_has(0);
  @$pb.TagNumber(1)
  void clearCardType() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get denomination => $_getN(1);
  @$pb.TagNumber(2)
  set denomination($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasDenomination() => $_has(1);
  @$pb.TagNumber(2)
  void clearDenomination() => clearField(2);
}

class GetSellRateResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetSellRateResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOM<SellRate>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'rate', subBuilder: SellRate.create)
    ..hasRequiredFields = false
  ;

  GetSellRateResponse._() : super();
  factory GetSellRateResponse({
    SellRate? rate,
  }) {
    final _result = create();
    if (rate != null) {
      _result.rate = rate;
    }
    return _result;
  }
  factory GetSellRateResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetSellRateResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetSellRateResponse clone() => GetSellRateResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetSellRateResponse copyWith(void Function(GetSellRateResponse) updates) => super.copyWith((message) => updates(message as GetSellRateResponse)) as GetSellRateResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetSellRateResponse create() => GetSellRateResponse._();
  GetSellRateResponse createEmptyInstance() => create();
  static $pb.PbList<GetSellRateResponse> createRepeated() => $pb.PbList<GetSellRateResponse>();
  @$core.pragma('dart2js:noInline')
  static GetSellRateResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetSellRateResponse>(create);
  static GetSellRateResponse? _defaultInstance;

  @$pb.TagNumber(1)
  SellRate get rate => $_getN(0);
  @$pb.TagNumber(1)
  set rate(SellRate v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasRate() => $_has(0);
  @$pb.TagNumber(1)
  void clearRate() => clearField(1);
  @$pb.TagNumber(1)
  SellRate ensureRate() => $_ensure(0);
}

class SellGiftCardRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SellGiftCardRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cardType')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cardNumber')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cardPin')
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'denomination', $pb.PbFieldType.OD)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..pPS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'images')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'idempotencyKey')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionId')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'verificationToken')
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerName')
    ..pPS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'imageUrls')
    ..pPS(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'imageKeys')
    ..aOS(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ocrBrand')
    ..aOS(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ocrCardNumber')
    ..aOS(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ocrPin')
    ..a<$core.double>(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ocrDenomination', $pb.PbFieldType.OD)
    ..aOS(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ocrCurrency')
    ..aOS(18, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cardCountry')
    ..aOS(19, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cardFormat')
    ..a<$core.double>(20, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ocrConfidence', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  SellGiftCardRequest._() : super();
  factory SellGiftCardRequest({
    $core.String? cardType,
    $core.String? cardNumber,
    $core.String? cardPin,
    $core.double? denomination,
    $core.String? currency,
    $core.Iterable<$core.String>? images,
    $core.String? idempotencyKey,
    $core.String? transactionId,
    $core.String? verificationToken,
    $core.String? providerName,
    $core.Iterable<$core.String>? imageUrls,
    $core.Iterable<$core.String>? imageKeys,
    $core.String? ocrBrand,
    $core.String? ocrCardNumber,
    $core.String? ocrPin,
    $core.double? ocrDenomination,
    $core.String? ocrCurrency,
    $core.String? cardCountry,
    $core.String? cardFormat,
    $core.double? ocrConfidence,
  }) {
    final _result = create();
    if (cardType != null) {
      _result.cardType = cardType;
    }
    if (cardNumber != null) {
      _result.cardNumber = cardNumber;
    }
    if (cardPin != null) {
      _result.cardPin = cardPin;
    }
    if (denomination != null) {
      _result.denomination = denomination;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (images != null) {
      _result.images.addAll(images);
    }
    if (idempotencyKey != null) {
      _result.idempotencyKey = idempotencyKey;
    }
    if (transactionId != null) {
      _result.transactionId = transactionId;
    }
    if (verificationToken != null) {
      _result.verificationToken = verificationToken;
    }
    if (providerName != null) {
      _result.providerName = providerName;
    }
    if (imageUrls != null) {
      _result.imageUrls.addAll(imageUrls);
    }
    if (imageKeys != null) {
      _result.imageKeys.addAll(imageKeys);
    }
    if (ocrBrand != null) {
      _result.ocrBrand = ocrBrand;
    }
    if (ocrCardNumber != null) {
      _result.ocrCardNumber = ocrCardNumber;
    }
    if (ocrPin != null) {
      _result.ocrPin = ocrPin;
    }
    if (ocrDenomination != null) {
      _result.ocrDenomination = ocrDenomination;
    }
    if (ocrCurrency != null) {
      _result.ocrCurrency = ocrCurrency;
    }
    if (cardCountry != null) {
      _result.cardCountry = cardCountry;
    }
    if (cardFormat != null) {
      _result.cardFormat = cardFormat;
    }
    if (ocrConfidence != null) {
      _result.ocrConfidence = ocrConfidence;
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
  $core.String get cardType => $_getSZ(0);
  @$pb.TagNumber(1)
  set cardType($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCardType() => $_has(0);
  @$pb.TagNumber(1)
  void clearCardType() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get cardNumber => $_getSZ(1);
  @$pb.TagNumber(2)
  set cardNumber($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCardNumber() => $_has(1);
  @$pb.TagNumber(2)
  void clearCardNumber() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get cardPin => $_getSZ(2);
  @$pb.TagNumber(3)
  set cardPin($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCardPin() => $_has(2);
  @$pb.TagNumber(3)
  void clearCardPin() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get denomination => $_getN(3);
  @$pb.TagNumber(4)
  set denomination($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDenomination() => $_has(3);
  @$pb.TagNumber(4)
  void clearDenomination() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get currency => $_getSZ(4);
  @$pb.TagNumber(5)
  set currency($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasCurrency() => $_has(4);
  @$pb.TagNumber(5)
  void clearCurrency() => clearField(5);

  @$pb.TagNumber(6)
  $core.List<$core.String> get images => $_getList(5);

  @$pb.TagNumber(7)
  $core.String get idempotencyKey => $_getSZ(6);
  @$pb.TagNumber(7)
  set idempotencyKey($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasIdempotencyKey() => $_has(6);
  @$pb.TagNumber(7)
  void clearIdempotencyKey() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get transactionId => $_getSZ(7);
  @$pb.TagNumber(8)
  set transactionId($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasTransactionId() => $_has(7);
  @$pb.TagNumber(8)
  void clearTransactionId() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get verificationToken => $_getSZ(8);
  @$pb.TagNumber(9)
  set verificationToken($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasVerificationToken() => $_has(8);
  @$pb.TagNumber(9)
  void clearVerificationToken() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get providerName => $_getSZ(9);
  @$pb.TagNumber(10)
  set providerName($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasProviderName() => $_has(9);
  @$pb.TagNumber(10)
  void clearProviderName() => clearField(10);

  @$pb.TagNumber(11)
  $core.List<$core.String> get imageUrls => $_getList(10);

  @$pb.TagNumber(12)
  $core.List<$core.String> get imageKeys => $_getList(11);

  @$pb.TagNumber(13)
  $core.String get ocrBrand => $_getSZ(12);
  @$pb.TagNumber(13)
  set ocrBrand($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasOcrBrand() => $_has(12);
  @$pb.TagNumber(13)
  void clearOcrBrand() => clearField(13);

  @$pb.TagNumber(14)
  $core.String get ocrCardNumber => $_getSZ(13);
  @$pb.TagNumber(14)
  set ocrCardNumber($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasOcrCardNumber() => $_has(13);
  @$pb.TagNumber(14)
  void clearOcrCardNumber() => clearField(14);

  @$pb.TagNumber(15)
  $core.String get ocrPin => $_getSZ(14);
  @$pb.TagNumber(15)
  set ocrPin($core.String v) { $_setString(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasOcrPin() => $_has(14);
  @$pb.TagNumber(15)
  void clearOcrPin() => clearField(15);

  @$pb.TagNumber(16)
  $core.double get ocrDenomination => $_getN(15);
  @$pb.TagNumber(16)
  set ocrDenomination($core.double v) { $_setDouble(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasOcrDenomination() => $_has(15);
  @$pb.TagNumber(16)
  void clearOcrDenomination() => clearField(16);

  @$pb.TagNumber(17)
  $core.String get ocrCurrency => $_getSZ(16);
  @$pb.TagNumber(17)
  set ocrCurrency($core.String v) { $_setString(16, v); }
  @$pb.TagNumber(17)
  $core.bool hasOcrCurrency() => $_has(16);
  @$pb.TagNumber(17)
  void clearOcrCurrency() => clearField(17);

  @$pb.TagNumber(18)
  $core.String get cardCountry => $_getSZ(17);
  @$pb.TagNumber(18)
  set cardCountry($core.String v) { $_setString(17, v); }
  @$pb.TagNumber(18)
  $core.bool hasCardCountry() => $_has(17);
  @$pb.TagNumber(18)
  void clearCardCountry() => clearField(18);

  @$pb.TagNumber(19)
  $core.String get cardFormat => $_getSZ(18);
  @$pb.TagNumber(19)
  set cardFormat($core.String v) { $_setString(18, v); }
  @$pb.TagNumber(19)
  $core.bool hasCardFormat() => $_has(18);
  @$pb.TagNumber(19)
  void clearCardFormat() => clearField(19);

  @$pb.TagNumber(20)
  $core.double get ocrConfidence => $_getN(19);
  @$pb.TagNumber(20)
  set ocrConfidence($core.double v) { $_setDouble(19, v); }
  @$pb.TagNumber(20)
  $core.bool hasOcrConfidence() => $_has(19);
  @$pb.TagNumber(20)
  void clearOcrConfidence() => clearField(20);
}

class SellGiftCardResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SellGiftCardResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOM<GiftCardSale>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sale', subBuilder: GiftCardSale.create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  SellGiftCardResponse._() : super();
  factory SellGiftCardResponse({
    GiftCardSale? sale,
    $core.String? message,
  }) {
    final _result = create();
    if (sale != null) {
      _result.sale = sale;
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
  GiftCardSale get sale => $_getN(0);
  @$pb.TagNumber(1)
  set sale(GiftCardSale v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasSale() => $_has(0);
  @$pb.TagNumber(1)
  void clearSale() => clearField(1);
  @$pb.TagNumber(1)
  GiftCardSale ensureSale() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

class GetSellStatusRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetSellStatusRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'saleId')
    ..hasRequiredFields = false
  ;

  GetSellStatusRequest._() : super();
  factory GetSellStatusRequest({
    $core.String? saleId,
  }) {
    final _result = create();
    if (saleId != null) {
      _result.saleId = saleId;
    }
    return _result;
  }
  factory GetSellStatusRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetSellStatusRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetSellStatusRequest clone() => GetSellStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetSellStatusRequest copyWith(void Function(GetSellStatusRequest) updates) => super.copyWith((message) => updates(message as GetSellStatusRequest)) as GetSellStatusRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetSellStatusRequest create() => GetSellStatusRequest._();
  GetSellStatusRequest createEmptyInstance() => create();
  static $pb.PbList<GetSellStatusRequest> createRepeated() => $pb.PbList<GetSellStatusRequest>();
  @$core.pragma('dart2js:noInline')
  static GetSellStatusRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetSellStatusRequest>(create);
  static GetSellStatusRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get saleId => $_getSZ(0);
  @$pb.TagNumber(1)
  set saleId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSaleId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSaleId() => clearField(1);
}

class GetSellStatusResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetSellStatusResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOM<GiftCardSale>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sale', subBuilder: GiftCardSale.create)
    ..hasRequiredFields = false
  ;

  GetSellStatusResponse._() : super();
  factory GetSellStatusResponse({
    GiftCardSale? sale,
  }) {
    final _result = create();
    if (sale != null) {
      _result.sale = sale;
    }
    return _result;
  }
  factory GetSellStatusResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetSellStatusResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetSellStatusResponse clone() => GetSellStatusResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetSellStatusResponse copyWith(void Function(GetSellStatusResponse) updates) => super.copyWith((message) => updates(message as GetSellStatusResponse)) as GetSellStatusResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetSellStatusResponse create() => GetSellStatusResponse._();
  GetSellStatusResponse createEmptyInstance() => create();
  static $pb.PbList<GetSellStatusResponse> createRepeated() => $pb.PbList<GetSellStatusResponse>();
  @$core.pragma('dart2js:noInline')
  static GetSellStatusResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetSellStatusResponse>(create);
  static GetSellStatusResponse? _defaultInstance;

  @$pb.TagNumber(1)
  GiftCardSale get sale => $_getN(0);
  @$pb.TagNumber(1)
  set sale(GiftCardSale v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasSale() => $_has(0);
  @$pb.TagNumber(1)
  void clearSale() => clearField(1);
  @$pb.TagNumber(1)
  GiftCardSale ensureSale() => $_ensure(0);
}

class GetMySalesRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetMySalesRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetMySalesRequest._() : super();
  factory GetMySalesRequest({
    $core.String? status,
    $core.int? limit,
    $core.int? offset,
  }) {
    final _result = create();
    if (status != null) {
      _result.status = status;
    }
    if (limit != null) {
      _result.limit = limit;
    }
    if (offset != null) {
      _result.offset = offset;
    }
    return _result;
  }
  factory GetMySalesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMySalesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMySalesRequest clone() => GetMySalesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMySalesRequest copyWith(void Function(GetMySalesRequest) updates) => super.copyWith((message) => updates(message as GetMySalesRequest)) as GetMySalesRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetMySalesRequest create() => GetMySalesRequest._();
  GetMySalesRequest createEmptyInstance() => create();
  static $pb.PbList<GetMySalesRequest> createRepeated() => $pb.PbList<GetMySalesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMySalesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMySalesRequest>(create);
  static GetMySalesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get status => $_getSZ(0);
  @$pb.TagNumber(1)
  set status($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => clearField(1);

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

class GetMySalesResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetMySalesResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..pc<GiftCardSale>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sales', $pb.PbFieldType.PM, subBuilder: GiftCardSale.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetMySalesResponse._() : super();
  factory GetMySalesResponse({
    $core.Iterable<GiftCardSale>? sales,
    $core.int? total,
  }) {
    final _result = create();
    if (sales != null) {
      _result.sales.addAll(sales);
    }
    if (total != null) {
      _result.total = total;
    }
    return _result;
  }
  factory GetMySalesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMySalesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMySalesResponse clone() => GetMySalesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMySalesResponse copyWith(void Function(GetMySalesResponse) updates) => super.copyWith((message) => updates(message as GetMySalesResponse)) as GetMySalesResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetMySalesResponse create() => GetMySalesResponse._();
  GetMySalesResponse createEmptyInstance() => create();
  static $pb.PbList<GetMySalesResponse> createRepeated() => $pb.PbList<GetMySalesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMySalesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMySalesResponse>(create);
  static GetMySalesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<GiftCardSale> get sales => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => clearField(2);
}

class UploadSellImageRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UploadSellImageRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'imageData')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'contentType')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'filename')
    ..hasRequiredFields = false
  ;

  UploadSellImageRequest._() : super();
  factory UploadSellImageRequest({
    $core.String? imageData,
    $core.String? contentType,
    $core.String? filename,
  }) {
    final _result = create();
    if (imageData != null) {
      _result.imageData = imageData;
    }
    if (contentType != null) {
      _result.contentType = contentType;
    }
    if (filename != null) {
      _result.filename = filename;
    }
    return _result;
  }
  factory UploadSellImageRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UploadSellImageRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UploadSellImageRequest clone() => UploadSellImageRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UploadSellImageRequest copyWith(void Function(UploadSellImageRequest) updates) => super.copyWith((message) => updates(message as UploadSellImageRequest)) as UploadSellImageRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UploadSellImageRequest create() => UploadSellImageRequest._();
  UploadSellImageRequest createEmptyInstance() => create();
  static $pb.PbList<UploadSellImageRequest> createRepeated() => $pb.PbList<UploadSellImageRequest>();
  @$core.pragma('dart2js:noInline')
  static UploadSellImageRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UploadSellImageRequest>(create);
  static UploadSellImageRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get imageData => $_getSZ(0);
  @$pb.TagNumber(1)
  set imageData($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasImageData() => $_has(0);
  @$pb.TagNumber(1)
  void clearImageData() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get contentType => $_getSZ(1);
  @$pb.TagNumber(2)
  set contentType($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasContentType() => $_has(1);
  @$pb.TagNumber(2)
  void clearContentType() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get filename => $_getSZ(2);
  @$pb.TagNumber(3)
  set filename($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasFilename() => $_has(2);
  @$pb.TagNumber(3)
  void clearFilename() => clearField(3);
}

class UploadSellImageResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UploadSellImageResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'imageUrl')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'imageKey')
    ..hasRequiredFields = false
  ;

  UploadSellImageResponse._() : super();
  factory UploadSellImageResponse({
    $core.String? imageUrl,
    $core.String? imageKey,
  }) {
    final _result = create();
    if (imageUrl != null) {
      _result.imageUrl = imageUrl;
    }
    if (imageKey != null) {
      _result.imageKey = imageKey;
    }
    return _result;
  }
  factory UploadSellImageResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UploadSellImageResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UploadSellImageResponse clone() => UploadSellImageResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UploadSellImageResponse copyWith(void Function(UploadSellImageResponse) updates) => super.copyWith((message) => updates(message as UploadSellImageResponse)) as UploadSellImageResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UploadSellImageResponse create() => UploadSellImageResponse._();
  UploadSellImageResponse createEmptyInstance() => create();
  static $pb.PbList<UploadSellImageResponse> createRepeated() => $pb.PbList<UploadSellImageResponse>();
  @$core.pragma('dart2js:noInline')
  static UploadSellImageResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UploadSellImageResponse>(create);
  static UploadSellImageResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get imageUrl => $_getSZ(0);
  @$pb.TagNumber(1)
  set imageUrl($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasImageUrl() => $_has(0);
  @$pb.TagNumber(1)
  void clearImageUrl() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get imageKey => $_getSZ(1);
  @$pb.TagNumber(2)
  set imageKey($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasImageKey() => $_has(1);
  @$pb.TagNumber(2)
  void clearImageKey() => clearField(2);
}

class ExtractCardDetailsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ExtractCardDetailsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..pPS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'imageUrls')
    ..hasRequiredFields = false
  ;

  ExtractCardDetailsRequest._() : super();
  factory ExtractCardDetailsRequest({
    $core.Iterable<$core.String>? imageUrls,
  }) {
    final _result = create();
    if (imageUrls != null) {
      _result.imageUrls.addAll(imageUrls);
    }
    return _result;
  }
  factory ExtractCardDetailsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ExtractCardDetailsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ExtractCardDetailsRequest clone() => ExtractCardDetailsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ExtractCardDetailsRequest copyWith(void Function(ExtractCardDetailsRequest) updates) => super.copyWith((message) => updates(message as ExtractCardDetailsRequest)) as ExtractCardDetailsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ExtractCardDetailsRequest create() => ExtractCardDetailsRequest._();
  ExtractCardDetailsRequest createEmptyInstance() => create();
  static $pb.PbList<ExtractCardDetailsRequest> createRepeated() => $pb.PbList<ExtractCardDetailsRequest>();
  @$core.pragma('dart2js:noInline')
  static ExtractCardDetailsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ExtractCardDetailsRequest>(create);
  static ExtractCardDetailsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.String> get imageUrls => $_getList(0);
}

class ExtractCardDetailsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ExtractCardDetailsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'brand')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cardNumber')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pin')
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'denomination', $pb.PbFieldType.OD)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..a<$core.double>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'confidence', $pb.PbFieldType.OD)
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'rawText')
    ..hasRequiredFields = false
  ;

  ExtractCardDetailsResponse._() : super();
  factory ExtractCardDetailsResponse({
    $core.String? brand,
    $core.String? cardNumber,
    $core.String? pin,
    $core.double? denomination,
    $core.String? currency,
    $core.double? confidence,
    $core.String? rawText,
  }) {
    final _result = create();
    if (brand != null) {
      _result.brand = brand;
    }
    if (cardNumber != null) {
      _result.cardNumber = cardNumber;
    }
    if (pin != null) {
      _result.pin = pin;
    }
    if (denomination != null) {
      _result.denomination = denomination;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (confidence != null) {
      _result.confidence = confidence;
    }
    if (rawText != null) {
      _result.rawText = rawText;
    }
    return _result;
  }
  factory ExtractCardDetailsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ExtractCardDetailsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ExtractCardDetailsResponse clone() => ExtractCardDetailsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ExtractCardDetailsResponse copyWith(void Function(ExtractCardDetailsResponse) updates) => super.copyWith((message) => updates(message as ExtractCardDetailsResponse)) as ExtractCardDetailsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ExtractCardDetailsResponse create() => ExtractCardDetailsResponse._();
  ExtractCardDetailsResponse createEmptyInstance() => create();
  static $pb.PbList<ExtractCardDetailsResponse> createRepeated() => $pb.PbList<ExtractCardDetailsResponse>();
  @$core.pragma('dart2js:noInline')
  static ExtractCardDetailsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ExtractCardDetailsResponse>(create);
  static ExtractCardDetailsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get brand => $_getSZ(0);
  @$pb.TagNumber(1)
  set brand($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasBrand() => $_has(0);
  @$pb.TagNumber(1)
  void clearBrand() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get cardNumber => $_getSZ(1);
  @$pb.TagNumber(2)
  set cardNumber($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCardNumber() => $_has(1);
  @$pb.TagNumber(2)
  void clearCardNumber() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get pin => $_getSZ(2);
  @$pb.TagNumber(3)
  set pin($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPin() => $_has(2);
  @$pb.TagNumber(3)
  void clearPin() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get denomination => $_getN(3);
  @$pb.TagNumber(4)
  set denomination($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDenomination() => $_has(3);
  @$pb.TagNumber(4)
  void clearDenomination() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get currency => $_getSZ(4);
  @$pb.TagNumber(5)
  set currency($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasCurrency() => $_has(4);
  @$pb.TagNumber(5)
  void clearCurrency() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get confidence => $_getN(5);
  @$pb.TagNumber(6)
  set confidence($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasConfidence() => $_has(5);
  @$pb.TagNumber(6)
  void clearConfidence() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get rawText => $_getSZ(6);
  @$pb.TagNumber(7)
  set rawText($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasRawText() => $_has(6);
  @$pb.TagNumber(7)
  void clearRawText() => clearField(7);
}

class AdminListPendingSalesRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AdminListPendingSalesRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  AdminListPendingSalesRequest._() : super();
  factory AdminListPendingSalesRequest({
    $core.String? status,
    $core.int? limit,
    $core.int? offset,
  }) {
    final _result = create();
    if (status != null) {
      _result.status = status;
    }
    if (limit != null) {
      _result.limit = limit;
    }
    if (offset != null) {
      _result.offset = offset;
    }
    return _result;
  }
  factory AdminListPendingSalesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AdminListPendingSalesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AdminListPendingSalesRequest clone() => AdminListPendingSalesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AdminListPendingSalesRequest copyWith(void Function(AdminListPendingSalesRequest) updates) => super.copyWith((message) => updates(message as AdminListPendingSalesRequest)) as AdminListPendingSalesRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AdminListPendingSalesRequest create() => AdminListPendingSalesRequest._();
  AdminListPendingSalesRequest createEmptyInstance() => create();
  static $pb.PbList<AdminListPendingSalesRequest> createRepeated() => $pb.PbList<AdminListPendingSalesRequest>();
  @$core.pragma('dart2js:noInline')
  static AdminListPendingSalesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminListPendingSalesRequest>(create);
  static AdminListPendingSalesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get status => $_getSZ(0);
  @$pb.TagNumber(1)
  set status($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => clearField(1);

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

class AdminListPendingSalesResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AdminListPendingSalesResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..pc<GiftCardSale>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sales', $pb.PbFieldType.PM, subBuilder: GiftCardSale.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  AdminListPendingSalesResponse._() : super();
  factory AdminListPendingSalesResponse({
    $core.Iterable<GiftCardSale>? sales,
    $core.int? total,
  }) {
    final _result = create();
    if (sales != null) {
      _result.sales.addAll(sales);
    }
    if (total != null) {
      _result.total = total;
    }
    return _result;
  }
  factory AdminListPendingSalesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AdminListPendingSalesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AdminListPendingSalesResponse clone() => AdminListPendingSalesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AdminListPendingSalesResponse copyWith(void Function(AdminListPendingSalesResponse) updates) => super.copyWith((message) => updates(message as AdminListPendingSalesResponse)) as AdminListPendingSalesResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AdminListPendingSalesResponse create() => AdminListPendingSalesResponse._();
  AdminListPendingSalesResponse createEmptyInstance() => create();
  static $pb.PbList<AdminListPendingSalesResponse> createRepeated() => $pb.PbList<AdminListPendingSalesResponse>();
  @$core.pragma('dart2js:noInline')
  static AdminListPendingSalesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminListPendingSalesResponse>(create);
  static AdminListPendingSalesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<GiftCardSale> get sales => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => clearField(2);
}

class AdminGetSaleDetailRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AdminGetSaleDetailRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'saleId')
    ..hasRequiredFields = false
  ;

  AdminGetSaleDetailRequest._() : super();
  factory AdminGetSaleDetailRequest({
    $core.String? saleId,
  }) {
    final _result = create();
    if (saleId != null) {
      _result.saleId = saleId;
    }
    return _result;
  }
  factory AdminGetSaleDetailRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AdminGetSaleDetailRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AdminGetSaleDetailRequest clone() => AdminGetSaleDetailRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AdminGetSaleDetailRequest copyWith(void Function(AdminGetSaleDetailRequest) updates) => super.copyWith((message) => updates(message as AdminGetSaleDetailRequest)) as AdminGetSaleDetailRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AdminGetSaleDetailRequest create() => AdminGetSaleDetailRequest._();
  AdminGetSaleDetailRequest createEmptyInstance() => create();
  static $pb.PbList<AdminGetSaleDetailRequest> createRepeated() => $pb.PbList<AdminGetSaleDetailRequest>();
  @$core.pragma('dart2js:noInline')
  static AdminGetSaleDetailRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminGetSaleDetailRequest>(create);
  static AdminGetSaleDetailRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get saleId => $_getSZ(0);
  @$pb.TagNumber(1)
  set saleId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSaleId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSaleId() => clearField(1);
}

class AdminGetSaleDetailResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AdminGetSaleDetailResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOM<GiftCardSale>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sale', subBuilder: GiftCardSale.create)
    ..pPS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'imageDownloadUrls')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userEmail')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userName')
    ..hasRequiredFields = false
  ;

  AdminGetSaleDetailResponse._() : super();
  factory AdminGetSaleDetailResponse({
    GiftCardSale? sale,
    $core.Iterable<$core.String>? imageDownloadUrls,
    $core.String? userEmail,
    $core.String? userName,
  }) {
    final _result = create();
    if (sale != null) {
      _result.sale = sale;
    }
    if (imageDownloadUrls != null) {
      _result.imageDownloadUrls.addAll(imageDownloadUrls);
    }
    if (userEmail != null) {
      _result.userEmail = userEmail;
    }
    if (userName != null) {
      _result.userName = userName;
    }
    return _result;
  }
  factory AdminGetSaleDetailResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AdminGetSaleDetailResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AdminGetSaleDetailResponse clone() => AdminGetSaleDetailResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AdminGetSaleDetailResponse copyWith(void Function(AdminGetSaleDetailResponse) updates) => super.copyWith((message) => updates(message as AdminGetSaleDetailResponse)) as AdminGetSaleDetailResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AdminGetSaleDetailResponse create() => AdminGetSaleDetailResponse._();
  AdminGetSaleDetailResponse createEmptyInstance() => create();
  static $pb.PbList<AdminGetSaleDetailResponse> createRepeated() => $pb.PbList<AdminGetSaleDetailResponse>();
  @$core.pragma('dart2js:noInline')
  static AdminGetSaleDetailResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminGetSaleDetailResponse>(create);
  static AdminGetSaleDetailResponse? _defaultInstance;

  @$pb.TagNumber(1)
  GiftCardSale get sale => $_getN(0);
  @$pb.TagNumber(1)
  set sale(GiftCardSale v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasSale() => $_has(0);
  @$pb.TagNumber(1)
  void clearSale() => clearField(1);
  @$pb.TagNumber(1)
  GiftCardSale ensureSale() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.List<$core.String> get imageDownloadUrls => $_getList(1);

  @$pb.TagNumber(3)
  $core.String get userEmail => $_getSZ(2);
  @$pb.TagNumber(3)
  set userEmail($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasUserEmail() => $_has(2);
  @$pb.TagNumber(3)
  void clearUserEmail() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get userName => $_getSZ(3);
  @$pb.TagNumber(4)
  set userName($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasUserName() => $_has(3);
  @$pb.TagNumber(4)
  void clearUserName() => clearField(4);
}

class AdminApproveSaleRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AdminApproveSaleRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'saleId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'adminNotes')
    ..hasRequiredFields = false
  ;

  AdminApproveSaleRequest._() : super();
  factory AdminApproveSaleRequest({
    $core.String? saleId,
    $core.String? adminNotes,
  }) {
    final _result = create();
    if (saleId != null) {
      _result.saleId = saleId;
    }
    if (adminNotes != null) {
      _result.adminNotes = adminNotes;
    }
    return _result;
  }
  factory AdminApproveSaleRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AdminApproveSaleRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AdminApproveSaleRequest clone() => AdminApproveSaleRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AdminApproveSaleRequest copyWith(void Function(AdminApproveSaleRequest) updates) => super.copyWith((message) => updates(message as AdminApproveSaleRequest)) as AdminApproveSaleRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AdminApproveSaleRequest create() => AdminApproveSaleRequest._();
  AdminApproveSaleRequest createEmptyInstance() => create();
  static $pb.PbList<AdminApproveSaleRequest> createRepeated() => $pb.PbList<AdminApproveSaleRequest>();
  @$core.pragma('dart2js:noInline')
  static AdminApproveSaleRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminApproveSaleRequest>(create);
  static AdminApproveSaleRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get saleId => $_getSZ(0);
  @$pb.TagNumber(1)
  set saleId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSaleId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSaleId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get adminNotes => $_getSZ(1);
  @$pb.TagNumber(2)
  set adminNotes($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAdminNotes() => $_has(1);
  @$pb.TagNumber(2)
  void clearAdminNotes() => clearField(2);
}

class AdminApproveSaleResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AdminApproveSaleResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOM<GiftCardSale>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sale', subBuilder: GiftCardSale.create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  AdminApproveSaleResponse._() : super();
  factory AdminApproveSaleResponse({
    GiftCardSale? sale,
    $core.String? message,
  }) {
    final _result = create();
    if (sale != null) {
      _result.sale = sale;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory AdminApproveSaleResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AdminApproveSaleResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AdminApproveSaleResponse clone() => AdminApproveSaleResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AdminApproveSaleResponse copyWith(void Function(AdminApproveSaleResponse) updates) => super.copyWith((message) => updates(message as AdminApproveSaleResponse)) as AdminApproveSaleResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AdminApproveSaleResponse create() => AdminApproveSaleResponse._();
  AdminApproveSaleResponse createEmptyInstance() => create();
  static $pb.PbList<AdminApproveSaleResponse> createRepeated() => $pb.PbList<AdminApproveSaleResponse>();
  @$core.pragma('dart2js:noInline')
  static AdminApproveSaleResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminApproveSaleResponse>(create);
  static AdminApproveSaleResponse? _defaultInstance;

  @$pb.TagNumber(1)
  GiftCardSale get sale => $_getN(0);
  @$pb.TagNumber(1)
  set sale(GiftCardSale v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasSale() => $_has(0);
  @$pb.TagNumber(1)
  void clearSale() => clearField(1);
  @$pb.TagNumber(1)
  GiftCardSale ensureSale() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

class AdminProcessPayoutRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AdminProcessPayoutRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'saleId')
    ..hasRequiredFields = false
  ;

  AdminProcessPayoutRequest._() : super();
  factory AdminProcessPayoutRequest({
    $core.String? saleId,
  }) {
    final _result = create();
    if (saleId != null) {
      _result.saleId = saleId;
    }
    return _result;
  }
  factory AdminProcessPayoutRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AdminProcessPayoutRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AdminProcessPayoutRequest clone() => AdminProcessPayoutRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AdminProcessPayoutRequest copyWith(void Function(AdminProcessPayoutRequest) updates) => super.copyWith((message) => updates(message as AdminProcessPayoutRequest)) as AdminProcessPayoutRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AdminProcessPayoutRequest create() => AdminProcessPayoutRequest._();
  AdminProcessPayoutRequest createEmptyInstance() => create();
  static $pb.PbList<AdminProcessPayoutRequest> createRepeated() => $pb.PbList<AdminProcessPayoutRequest>();
  @$core.pragma('dart2js:noInline')
  static AdminProcessPayoutRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminProcessPayoutRequest>(create);
  static AdminProcessPayoutRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get saleId => $_getSZ(0);
  @$pb.TagNumber(1)
  set saleId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSaleId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSaleId() => clearField(1);
}

class AdminProcessPayoutResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AdminProcessPayoutResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOM<GiftCardSale>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sale', subBuilder: GiftCardSale.create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  AdminProcessPayoutResponse._() : super();
  factory AdminProcessPayoutResponse({
    GiftCardSale? sale,
    $core.String? message,
  }) {
    final _result = create();
    if (sale != null) {
      _result.sale = sale;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory AdminProcessPayoutResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AdminProcessPayoutResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AdminProcessPayoutResponse clone() => AdminProcessPayoutResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AdminProcessPayoutResponse copyWith(void Function(AdminProcessPayoutResponse) updates) => super.copyWith((message) => updates(message as AdminProcessPayoutResponse)) as AdminProcessPayoutResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AdminProcessPayoutResponse create() => AdminProcessPayoutResponse._();
  AdminProcessPayoutResponse createEmptyInstance() => create();
  static $pb.PbList<AdminProcessPayoutResponse> createRepeated() => $pb.PbList<AdminProcessPayoutResponse>();
  @$core.pragma('dart2js:noInline')
  static AdminProcessPayoutResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminProcessPayoutResponse>(create);
  static AdminProcessPayoutResponse? _defaultInstance;

  @$pb.TagNumber(1)
  GiftCardSale get sale => $_getN(0);
  @$pb.TagNumber(1)
  set sale(GiftCardSale v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasSale() => $_has(0);
  @$pb.TagNumber(1)
  void clearSale() => clearField(1);
  @$pb.TagNumber(1)
  GiftCardSale ensureSale() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

class AdminRejectSaleRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AdminRejectSaleRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'saleId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reason')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'adminNotes')
    ..hasRequiredFields = false
  ;

  AdminRejectSaleRequest._() : super();
  factory AdminRejectSaleRequest({
    $core.String? saleId,
    $core.String? reason,
    $core.String? adminNotes,
  }) {
    final _result = create();
    if (saleId != null) {
      _result.saleId = saleId;
    }
    if (reason != null) {
      _result.reason = reason;
    }
    if (adminNotes != null) {
      _result.adminNotes = adminNotes;
    }
    return _result;
  }
  factory AdminRejectSaleRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AdminRejectSaleRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AdminRejectSaleRequest clone() => AdminRejectSaleRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AdminRejectSaleRequest copyWith(void Function(AdminRejectSaleRequest) updates) => super.copyWith((message) => updates(message as AdminRejectSaleRequest)) as AdminRejectSaleRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AdminRejectSaleRequest create() => AdminRejectSaleRequest._();
  AdminRejectSaleRequest createEmptyInstance() => create();
  static $pb.PbList<AdminRejectSaleRequest> createRepeated() => $pb.PbList<AdminRejectSaleRequest>();
  @$core.pragma('dart2js:noInline')
  static AdminRejectSaleRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminRejectSaleRequest>(create);
  static AdminRejectSaleRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get saleId => $_getSZ(0);
  @$pb.TagNumber(1)
  set saleId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSaleId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSaleId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get reason => $_getSZ(1);
  @$pb.TagNumber(2)
  set reason($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasReason() => $_has(1);
  @$pb.TagNumber(2)
  void clearReason() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get adminNotes => $_getSZ(2);
  @$pb.TagNumber(3)
  set adminNotes($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAdminNotes() => $_has(2);
  @$pb.TagNumber(3)
  void clearAdminNotes() => clearField(3);
}

class AdminRejectSaleResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AdminRejectSaleResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOM<GiftCardSale>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sale', subBuilder: GiftCardSale.create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  AdminRejectSaleResponse._() : super();
  factory AdminRejectSaleResponse({
    GiftCardSale? sale,
    $core.String? message,
  }) {
    final _result = create();
    if (sale != null) {
      _result.sale = sale;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory AdminRejectSaleResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AdminRejectSaleResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AdminRejectSaleResponse clone() => AdminRejectSaleResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AdminRejectSaleResponse copyWith(void Function(AdminRejectSaleResponse) updates) => super.copyWith((message) => updates(message as AdminRejectSaleResponse)) as AdminRejectSaleResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AdminRejectSaleResponse create() => AdminRejectSaleResponse._();
  AdminRejectSaleResponse createEmptyInstance() => create();
  static $pb.PbList<AdminRejectSaleResponse> createRepeated() => $pb.PbList<AdminRejectSaleResponse>();
  @$core.pragma('dart2js:noInline')
  static AdminRejectSaleResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminRejectSaleResponse>(create);
  static AdminRejectSaleResponse? _defaultInstance;

  @$pb.TagNumber(1)
  GiftCardSale get sale => $_getN(0);
  @$pb.TagNumber(1)
  set sale(GiftCardSale v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasSale() => $_has(0);
  @$pb.TagNumber(1)
  void clearSale() => clearField(1);
  @$pb.TagNumber(1)
  GiftCardSale ensureSale() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

class SellRateConfig extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SellRateConfig', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cardBrand')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cardTypeSlug')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'logoUrl')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'category')
    ..p<$core.double>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'denominations', $pb.PbFieldType.KD)
    ..pPS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currencies')
    ..pPS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'countries')
    ..a<$core.double>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'minDenomination', $pb.PbFieldType.OD)
    ..a<$core.double>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'maxDenomination', $pb.PbFieldType.OD)
    ..a<$core.double>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'buyRatePercentage', $pb.PbFieldType.OD)
    ..a<$core.double>(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'commissionPercentage', $pb.PbFieldType.OD)
    ..a<$core.double>(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payoutRatePercentage', $pb.PbFieldType.OD)
    ..aOS(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payoutCurrency')
    ..aOS(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cardType')
    ..aOB(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isActive')
    ..aOS(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt')
    ..aOS(18, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedAt')
    ..hasRequiredFields = false
  ;

  SellRateConfig._() : super();
  factory SellRateConfig({
    $core.String? id,
    $core.String? cardBrand,
    $core.String? cardTypeSlug,
    $core.String? logoUrl,
    $core.String? category,
    $core.Iterable<$core.double>? denominations,
    $core.Iterable<$core.String>? currencies,
    $core.Iterable<$core.String>? countries,
    $core.double? minDenomination,
    $core.double? maxDenomination,
    $core.double? buyRatePercentage,
    $core.double? commissionPercentage,
    $core.double? payoutRatePercentage,
    $core.String? payoutCurrency,
    $core.String? cardType,
    $core.bool? isActive,
    $core.String? createdAt,
    $core.String? updatedAt,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (cardBrand != null) {
      _result.cardBrand = cardBrand;
    }
    if (cardTypeSlug != null) {
      _result.cardTypeSlug = cardTypeSlug;
    }
    if (logoUrl != null) {
      _result.logoUrl = logoUrl;
    }
    if (category != null) {
      _result.category = category;
    }
    if (denominations != null) {
      _result.denominations.addAll(denominations);
    }
    if (currencies != null) {
      _result.currencies.addAll(currencies);
    }
    if (countries != null) {
      _result.countries.addAll(countries);
    }
    if (minDenomination != null) {
      _result.minDenomination = minDenomination;
    }
    if (maxDenomination != null) {
      _result.maxDenomination = maxDenomination;
    }
    if (buyRatePercentage != null) {
      _result.buyRatePercentage = buyRatePercentage;
    }
    if (commissionPercentage != null) {
      _result.commissionPercentage = commissionPercentage;
    }
    if (payoutRatePercentage != null) {
      _result.payoutRatePercentage = payoutRatePercentage;
    }
    if (payoutCurrency != null) {
      _result.payoutCurrency = payoutCurrency;
    }
    if (cardType != null) {
      _result.cardType = cardType;
    }
    if (isActive != null) {
      _result.isActive = isActive;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      _result.updatedAt = updatedAt;
    }
    return _result;
  }
  factory SellRateConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SellRateConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SellRateConfig clone() => SellRateConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SellRateConfig copyWith(void Function(SellRateConfig) updates) => super.copyWith((message) => updates(message as SellRateConfig)) as SellRateConfig; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SellRateConfig create() => SellRateConfig._();
  SellRateConfig createEmptyInstance() => create();
  static $pb.PbList<SellRateConfig> createRepeated() => $pb.PbList<SellRateConfig>();
  @$core.pragma('dart2js:noInline')
  static SellRateConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SellRateConfig>(create);
  static SellRateConfig? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get cardBrand => $_getSZ(1);
  @$pb.TagNumber(2)
  set cardBrand($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCardBrand() => $_has(1);
  @$pb.TagNumber(2)
  void clearCardBrand() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get cardTypeSlug => $_getSZ(2);
  @$pb.TagNumber(3)
  set cardTypeSlug($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCardTypeSlug() => $_has(2);
  @$pb.TagNumber(3)
  void clearCardTypeSlug() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get logoUrl => $_getSZ(3);
  @$pb.TagNumber(4)
  set logoUrl($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasLogoUrl() => $_has(3);
  @$pb.TagNumber(4)
  void clearLogoUrl() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get category => $_getSZ(4);
  @$pb.TagNumber(5)
  set category($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasCategory() => $_has(4);
  @$pb.TagNumber(5)
  void clearCategory() => clearField(5);

  @$pb.TagNumber(6)
  $core.List<$core.double> get denominations => $_getList(5);

  @$pb.TagNumber(7)
  $core.List<$core.String> get currencies => $_getList(6);

  @$pb.TagNumber(8)
  $core.List<$core.String> get countries => $_getList(7);

  @$pb.TagNumber(9)
  $core.double get minDenomination => $_getN(8);
  @$pb.TagNumber(9)
  set minDenomination($core.double v) { $_setDouble(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasMinDenomination() => $_has(8);
  @$pb.TagNumber(9)
  void clearMinDenomination() => clearField(9);

  @$pb.TagNumber(10)
  $core.double get maxDenomination => $_getN(9);
  @$pb.TagNumber(10)
  set maxDenomination($core.double v) { $_setDouble(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasMaxDenomination() => $_has(9);
  @$pb.TagNumber(10)
  void clearMaxDenomination() => clearField(10);

  @$pb.TagNumber(11)
  $core.double get buyRatePercentage => $_getN(10);
  @$pb.TagNumber(11)
  set buyRatePercentage($core.double v) { $_setDouble(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasBuyRatePercentage() => $_has(10);
  @$pb.TagNumber(11)
  void clearBuyRatePercentage() => clearField(11);

  @$pb.TagNumber(12)
  $core.double get commissionPercentage => $_getN(11);
  @$pb.TagNumber(12)
  set commissionPercentage($core.double v) { $_setDouble(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasCommissionPercentage() => $_has(11);
  @$pb.TagNumber(12)
  void clearCommissionPercentage() => clearField(12);

  @$pb.TagNumber(13)
  $core.double get payoutRatePercentage => $_getN(12);
  @$pb.TagNumber(13)
  set payoutRatePercentage($core.double v) { $_setDouble(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasPayoutRatePercentage() => $_has(12);
  @$pb.TagNumber(13)
  void clearPayoutRatePercentage() => clearField(13);

  @$pb.TagNumber(14)
  $core.String get payoutCurrency => $_getSZ(13);
  @$pb.TagNumber(14)
  set payoutCurrency($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasPayoutCurrency() => $_has(13);
  @$pb.TagNumber(14)
  void clearPayoutCurrency() => clearField(14);

  @$pb.TagNumber(15)
  $core.String get cardType => $_getSZ(14);
  @$pb.TagNumber(15)
  set cardType($core.String v) { $_setString(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasCardType() => $_has(14);
  @$pb.TagNumber(15)
  void clearCardType() => clearField(15);

  @$pb.TagNumber(16)
  $core.bool get isActive => $_getBF(15);
  @$pb.TagNumber(16)
  set isActive($core.bool v) { $_setBool(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasIsActive() => $_has(15);
  @$pb.TagNumber(16)
  void clearIsActive() => clearField(16);

  @$pb.TagNumber(17)
  $core.String get createdAt => $_getSZ(16);
  @$pb.TagNumber(17)
  set createdAt($core.String v) { $_setString(16, v); }
  @$pb.TagNumber(17)
  $core.bool hasCreatedAt() => $_has(16);
  @$pb.TagNumber(17)
  void clearCreatedAt() => clearField(17);

  @$pb.TagNumber(18)
  $core.String get updatedAt => $_getSZ(17);
  @$pb.TagNumber(18)
  set updatedAt($core.String v) { $_setString(17, v); }
  @$pb.TagNumber(18)
  $core.bool hasUpdatedAt() => $_has(17);
  @$pb.TagNumber(18)
  void clearUpdatedAt() => clearField(18);
}

class AdminListSellRatesRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AdminListSellRatesRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'category')
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'activeOnly')
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  AdminListSellRatesRequest._() : super();
  factory AdminListSellRatesRequest({
    $core.String? category,
    $core.bool? activeOnly,
    $core.int? limit,
    $core.int? offset,
  }) {
    final _result = create();
    if (category != null) {
      _result.category = category;
    }
    if (activeOnly != null) {
      _result.activeOnly = activeOnly;
    }
    if (limit != null) {
      _result.limit = limit;
    }
    if (offset != null) {
      _result.offset = offset;
    }
    return _result;
  }
  factory AdminListSellRatesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AdminListSellRatesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AdminListSellRatesRequest clone() => AdminListSellRatesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AdminListSellRatesRequest copyWith(void Function(AdminListSellRatesRequest) updates) => super.copyWith((message) => updates(message as AdminListSellRatesRequest)) as AdminListSellRatesRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AdminListSellRatesRequest create() => AdminListSellRatesRequest._();
  AdminListSellRatesRequest createEmptyInstance() => create();
  static $pb.PbList<AdminListSellRatesRequest> createRepeated() => $pb.PbList<AdminListSellRatesRequest>();
  @$core.pragma('dart2js:noInline')
  static AdminListSellRatesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminListSellRatesRequest>(create);
  static AdminListSellRatesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get category => $_getSZ(0);
  @$pb.TagNumber(1)
  set category($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCategory() => $_has(0);
  @$pb.TagNumber(1)
  void clearCategory() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get activeOnly => $_getBF(1);
  @$pb.TagNumber(2)
  set activeOnly($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasActiveOnly() => $_has(1);
  @$pb.TagNumber(2)
  void clearActiveOnly() => clearField(2);

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

class AdminListSellRatesResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AdminListSellRatesResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..pc<SellRateConfig>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'rates', $pb.PbFieldType.PM, subBuilder: SellRateConfig.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  AdminListSellRatesResponse._() : super();
  factory AdminListSellRatesResponse({
    $core.Iterable<SellRateConfig>? rates,
    $core.int? total,
  }) {
    final _result = create();
    if (rates != null) {
      _result.rates.addAll(rates);
    }
    if (total != null) {
      _result.total = total;
    }
    return _result;
  }
  factory AdminListSellRatesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AdminListSellRatesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AdminListSellRatesResponse clone() => AdminListSellRatesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AdminListSellRatesResponse copyWith(void Function(AdminListSellRatesResponse) updates) => super.copyWith((message) => updates(message as AdminListSellRatesResponse)) as AdminListSellRatesResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AdminListSellRatesResponse create() => AdminListSellRatesResponse._();
  AdminListSellRatesResponse createEmptyInstance() => create();
  static $pb.PbList<AdminListSellRatesResponse> createRepeated() => $pb.PbList<AdminListSellRatesResponse>();
  @$core.pragma('dart2js:noInline')
  static AdminListSellRatesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminListSellRatesResponse>(create);
  static AdminListSellRatesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<SellRateConfig> get rates => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => clearField(2);
}

class AdminCreateSellRateRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AdminCreateSellRateRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cardBrand')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cardTypeSlug')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'logoUrl')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'category')
    ..p<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'denominations', $pb.PbFieldType.KD)
    ..pPS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currencies')
    ..pPS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'countries')
    ..a<$core.double>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'minDenomination', $pb.PbFieldType.OD)
    ..a<$core.double>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'maxDenomination', $pb.PbFieldType.OD)
    ..a<$core.double>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'buyRatePercentage', $pb.PbFieldType.OD)
    ..a<$core.double>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'commissionPercentage', $pb.PbFieldType.OD)
    ..a<$core.double>(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payoutRatePercentage', $pb.PbFieldType.OD)
    ..aOS(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payoutCurrency')
    ..aOS(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cardType')
    ..hasRequiredFields = false
  ;

  AdminCreateSellRateRequest._() : super();
  factory AdminCreateSellRateRequest({
    $core.String? cardBrand,
    $core.String? cardTypeSlug,
    $core.String? logoUrl,
    $core.String? category,
    $core.Iterable<$core.double>? denominations,
    $core.Iterable<$core.String>? currencies,
    $core.Iterable<$core.String>? countries,
    $core.double? minDenomination,
    $core.double? maxDenomination,
    $core.double? buyRatePercentage,
    $core.double? commissionPercentage,
    $core.double? payoutRatePercentage,
    $core.String? payoutCurrency,
    $core.String? cardType,
  }) {
    final _result = create();
    if (cardBrand != null) {
      _result.cardBrand = cardBrand;
    }
    if (cardTypeSlug != null) {
      _result.cardTypeSlug = cardTypeSlug;
    }
    if (logoUrl != null) {
      _result.logoUrl = logoUrl;
    }
    if (category != null) {
      _result.category = category;
    }
    if (denominations != null) {
      _result.denominations.addAll(denominations);
    }
    if (currencies != null) {
      _result.currencies.addAll(currencies);
    }
    if (countries != null) {
      _result.countries.addAll(countries);
    }
    if (minDenomination != null) {
      _result.minDenomination = minDenomination;
    }
    if (maxDenomination != null) {
      _result.maxDenomination = maxDenomination;
    }
    if (buyRatePercentage != null) {
      _result.buyRatePercentage = buyRatePercentage;
    }
    if (commissionPercentage != null) {
      _result.commissionPercentage = commissionPercentage;
    }
    if (payoutRatePercentage != null) {
      _result.payoutRatePercentage = payoutRatePercentage;
    }
    if (payoutCurrency != null) {
      _result.payoutCurrency = payoutCurrency;
    }
    if (cardType != null) {
      _result.cardType = cardType;
    }
    return _result;
  }
  factory AdminCreateSellRateRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AdminCreateSellRateRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AdminCreateSellRateRequest clone() => AdminCreateSellRateRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AdminCreateSellRateRequest copyWith(void Function(AdminCreateSellRateRequest) updates) => super.copyWith((message) => updates(message as AdminCreateSellRateRequest)) as AdminCreateSellRateRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AdminCreateSellRateRequest create() => AdminCreateSellRateRequest._();
  AdminCreateSellRateRequest createEmptyInstance() => create();
  static $pb.PbList<AdminCreateSellRateRequest> createRepeated() => $pb.PbList<AdminCreateSellRateRequest>();
  @$core.pragma('dart2js:noInline')
  static AdminCreateSellRateRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminCreateSellRateRequest>(create);
  static AdminCreateSellRateRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get cardBrand => $_getSZ(0);
  @$pb.TagNumber(1)
  set cardBrand($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCardBrand() => $_has(0);
  @$pb.TagNumber(1)
  void clearCardBrand() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get cardTypeSlug => $_getSZ(1);
  @$pb.TagNumber(2)
  set cardTypeSlug($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCardTypeSlug() => $_has(1);
  @$pb.TagNumber(2)
  void clearCardTypeSlug() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get logoUrl => $_getSZ(2);
  @$pb.TagNumber(3)
  set logoUrl($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasLogoUrl() => $_has(2);
  @$pb.TagNumber(3)
  void clearLogoUrl() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get category => $_getSZ(3);
  @$pb.TagNumber(4)
  set category($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCategory() => $_has(3);
  @$pb.TagNumber(4)
  void clearCategory() => clearField(4);

  @$pb.TagNumber(5)
  $core.List<$core.double> get denominations => $_getList(4);

  @$pb.TagNumber(6)
  $core.List<$core.String> get currencies => $_getList(5);

  @$pb.TagNumber(7)
  $core.List<$core.String> get countries => $_getList(6);

  @$pb.TagNumber(8)
  $core.double get minDenomination => $_getN(7);
  @$pb.TagNumber(8)
  set minDenomination($core.double v) { $_setDouble(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasMinDenomination() => $_has(7);
  @$pb.TagNumber(8)
  void clearMinDenomination() => clearField(8);

  @$pb.TagNumber(9)
  $core.double get maxDenomination => $_getN(8);
  @$pb.TagNumber(9)
  set maxDenomination($core.double v) { $_setDouble(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasMaxDenomination() => $_has(8);
  @$pb.TagNumber(9)
  void clearMaxDenomination() => clearField(9);

  @$pb.TagNumber(10)
  $core.double get buyRatePercentage => $_getN(9);
  @$pb.TagNumber(10)
  set buyRatePercentage($core.double v) { $_setDouble(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasBuyRatePercentage() => $_has(9);
  @$pb.TagNumber(10)
  void clearBuyRatePercentage() => clearField(10);

  @$pb.TagNumber(11)
  $core.double get commissionPercentage => $_getN(10);
  @$pb.TagNumber(11)
  set commissionPercentage($core.double v) { $_setDouble(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasCommissionPercentage() => $_has(10);
  @$pb.TagNumber(11)
  void clearCommissionPercentage() => clearField(11);

  @$pb.TagNumber(12)
  $core.double get payoutRatePercentage => $_getN(11);
  @$pb.TagNumber(12)
  set payoutRatePercentage($core.double v) { $_setDouble(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasPayoutRatePercentage() => $_has(11);
  @$pb.TagNumber(12)
  void clearPayoutRatePercentage() => clearField(12);

  @$pb.TagNumber(13)
  $core.String get payoutCurrency => $_getSZ(12);
  @$pb.TagNumber(13)
  set payoutCurrency($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasPayoutCurrency() => $_has(12);
  @$pb.TagNumber(13)
  void clearPayoutCurrency() => clearField(13);

  @$pb.TagNumber(14)
  $core.String get cardType => $_getSZ(13);
  @$pb.TagNumber(14)
  set cardType($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasCardType() => $_has(13);
  @$pb.TagNumber(14)
  void clearCardType() => clearField(14);
}

class AdminCreateSellRateResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AdminCreateSellRateResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOM<SellRateConfig>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'rate', subBuilder: SellRateConfig.create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  AdminCreateSellRateResponse._() : super();
  factory AdminCreateSellRateResponse({
    SellRateConfig? rate,
    $core.String? message,
  }) {
    final _result = create();
    if (rate != null) {
      _result.rate = rate;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory AdminCreateSellRateResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AdminCreateSellRateResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AdminCreateSellRateResponse clone() => AdminCreateSellRateResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AdminCreateSellRateResponse copyWith(void Function(AdminCreateSellRateResponse) updates) => super.copyWith((message) => updates(message as AdminCreateSellRateResponse)) as AdminCreateSellRateResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AdminCreateSellRateResponse create() => AdminCreateSellRateResponse._();
  AdminCreateSellRateResponse createEmptyInstance() => create();
  static $pb.PbList<AdminCreateSellRateResponse> createRepeated() => $pb.PbList<AdminCreateSellRateResponse>();
  @$core.pragma('dart2js:noInline')
  static AdminCreateSellRateResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminCreateSellRateResponse>(create);
  static AdminCreateSellRateResponse? _defaultInstance;

  @$pb.TagNumber(1)
  SellRateConfig get rate => $_getN(0);
  @$pb.TagNumber(1)
  set rate(SellRateConfig v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasRate() => $_has(0);
  @$pb.TagNumber(1)
  void clearRate() => clearField(1);
  @$pb.TagNumber(1)
  SellRateConfig ensureRate() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

class AdminUpdateSellRateRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AdminUpdateSellRateRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cardBrand')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cardTypeSlug')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'logoUrl')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'category')
    ..p<$core.double>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'denominations', $pb.PbFieldType.KD)
    ..pPS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currencies')
    ..pPS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'countries')
    ..a<$core.double>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'minDenomination', $pb.PbFieldType.OD)
    ..a<$core.double>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'maxDenomination', $pb.PbFieldType.OD)
    ..a<$core.double>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'buyRatePercentage', $pb.PbFieldType.OD)
    ..a<$core.double>(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'commissionPercentage', $pb.PbFieldType.OD)
    ..a<$core.double>(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payoutRatePercentage', $pb.PbFieldType.OD)
    ..aOS(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payoutCurrency')
    ..aOS(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cardType')
    ..aOB(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isActive')
    ..hasRequiredFields = false
  ;

  AdminUpdateSellRateRequest._() : super();
  factory AdminUpdateSellRateRequest({
    $core.String? id,
    $core.String? cardBrand,
    $core.String? cardTypeSlug,
    $core.String? logoUrl,
    $core.String? category,
    $core.Iterable<$core.double>? denominations,
    $core.Iterable<$core.String>? currencies,
    $core.Iterable<$core.String>? countries,
    $core.double? minDenomination,
    $core.double? maxDenomination,
    $core.double? buyRatePercentage,
    $core.double? commissionPercentage,
    $core.double? payoutRatePercentage,
    $core.String? payoutCurrency,
    $core.String? cardType,
    $core.bool? isActive,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (cardBrand != null) {
      _result.cardBrand = cardBrand;
    }
    if (cardTypeSlug != null) {
      _result.cardTypeSlug = cardTypeSlug;
    }
    if (logoUrl != null) {
      _result.logoUrl = logoUrl;
    }
    if (category != null) {
      _result.category = category;
    }
    if (denominations != null) {
      _result.denominations.addAll(denominations);
    }
    if (currencies != null) {
      _result.currencies.addAll(currencies);
    }
    if (countries != null) {
      _result.countries.addAll(countries);
    }
    if (minDenomination != null) {
      _result.minDenomination = minDenomination;
    }
    if (maxDenomination != null) {
      _result.maxDenomination = maxDenomination;
    }
    if (buyRatePercentage != null) {
      _result.buyRatePercentage = buyRatePercentage;
    }
    if (commissionPercentage != null) {
      _result.commissionPercentage = commissionPercentage;
    }
    if (payoutRatePercentage != null) {
      _result.payoutRatePercentage = payoutRatePercentage;
    }
    if (payoutCurrency != null) {
      _result.payoutCurrency = payoutCurrency;
    }
    if (cardType != null) {
      _result.cardType = cardType;
    }
    if (isActive != null) {
      _result.isActive = isActive;
    }
    return _result;
  }
  factory AdminUpdateSellRateRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AdminUpdateSellRateRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AdminUpdateSellRateRequest clone() => AdminUpdateSellRateRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AdminUpdateSellRateRequest copyWith(void Function(AdminUpdateSellRateRequest) updates) => super.copyWith((message) => updates(message as AdminUpdateSellRateRequest)) as AdminUpdateSellRateRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AdminUpdateSellRateRequest create() => AdminUpdateSellRateRequest._();
  AdminUpdateSellRateRequest createEmptyInstance() => create();
  static $pb.PbList<AdminUpdateSellRateRequest> createRepeated() => $pb.PbList<AdminUpdateSellRateRequest>();
  @$core.pragma('dart2js:noInline')
  static AdminUpdateSellRateRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminUpdateSellRateRequest>(create);
  static AdminUpdateSellRateRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get cardBrand => $_getSZ(1);
  @$pb.TagNumber(2)
  set cardBrand($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCardBrand() => $_has(1);
  @$pb.TagNumber(2)
  void clearCardBrand() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get cardTypeSlug => $_getSZ(2);
  @$pb.TagNumber(3)
  set cardTypeSlug($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCardTypeSlug() => $_has(2);
  @$pb.TagNumber(3)
  void clearCardTypeSlug() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get logoUrl => $_getSZ(3);
  @$pb.TagNumber(4)
  set logoUrl($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasLogoUrl() => $_has(3);
  @$pb.TagNumber(4)
  void clearLogoUrl() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get category => $_getSZ(4);
  @$pb.TagNumber(5)
  set category($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasCategory() => $_has(4);
  @$pb.TagNumber(5)
  void clearCategory() => clearField(5);

  @$pb.TagNumber(6)
  $core.List<$core.double> get denominations => $_getList(5);

  @$pb.TagNumber(7)
  $core.List<$core.String> get currencies => $_getList(6);

  @$pb.TagNumber(8)
  $core.List<$core.String> get countries => $_getList(7);

  @$pb.TagNumber(9)
  $core.double get minDenomination => $_getN(8);
  @$pb.TagNumber(9)
  set minDenomination($core.double v) { $_setDouble(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasMinDenomination() => $_has(8);
  @$pb.TagNumber(9)
  void clearMinDenomination() => clearField(9);

  @$pb.TagNumber(10)
  $core.double get maxDenomination => $_getN(9);
  @$pb.TagNumber(10)
  set maxDenomination($core.double v) { $_setDouble(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasMaxDenomination() => $_has(9);
  @$pb.TagNumber(10)
  void clearMaxDenomination() => clearField(10);

  @$pb.TagNumber(11)
  $core.double get buyRatePercentage => $_getN(10);
  @$pb.TagNumber(11)
  set buyRatePercentage($core.double v) { $_setDouble(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasBuyRatePercentage() => $_has(10);
  @$pb.TagNumber(11)
  void clearBuyRatePercentage() => clearField(11);

  @$pb.TagNumber(12)
  $core.double get commissionPercentage => $_getN(11);
  @$pb.TagNumber(12)
  set commissionPercentage($core.double v) { $_setDouble(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasCommissionPercentage() => $_has(11);
  @$pb.TagNumber(12)
  void clearCommissionPercentage() => clearField(12);

  @$pb.TagNumber(13)
  $core.double get payoutRatePercentage => $_getN(12);
  @$pb.TagNumber(13)
  set payoutRatePercentage($core.double v) { $_setDouble(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasPayoutRatePercentage() => $_has(12);
  @$pb.TagNumber(13)
  void clearPayoutRatePercentage() => clearField(13);

  @$pb.TagNumber(14)
  $core.String get payoutCurrency => $_getSZ(13);
  @$pb.TagNumber(14)
  set payoutCurrency($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasPayoutCurrency() => $_has(13);
  @$pb.TagNumber(14)
  void clearPayoutCurrency() => clearField(14);

  @$pb.TagNumber(15)
  $core.String get cardType => $_getSZ(14);
  @$pb.TagNumber(15)
  set cardType($core.String v) { $_setString(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasCardType() => $_has(14);
  @$pb.TagNumber(15)
  void clearCardType() => clearField(15);

  @$pb.TagNumber(16)
  $core.bool get isActive => $_getBF(15);
  @$pb.TagNumber(16)
  set isActive($core.bool v) { $_setBool(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasIsActive() => $_has(15);
  @$pb.TagNumber(16)
  void clearIsActive() => clearField(16);
}

class AdminUpdateSellRateResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AdminUpdateSellRateResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOM<SellRateConfig>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'rate', subBuilder: SellRateConfig.create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  AdminUpdateSellRateResponse._() : super();
  factory AdminUpdateSellRateResponse({
    SellRateConfig? rate,
    $core.String? message,
  }) {
    final _result = create();
    if (rate != null) {
      _result.rate = rate;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory AdminUpdateSellRateResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AdminUpdateSellRateResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AdminUpdateSellRateResponse clone() => AdminUpdateSellRateResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AdminUpdateSellRateResponse copyWith(void Function(AdminUpdateSellRateResponse) updates) => super.copyWith((message) => updates(message as AdminUpdateSellRateResponse)) as AdminUpdateSellRateResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AdminUpdateSellRateResponse create() => AdminUpdateSellRateResponse._();
  AdminUpdateSellRateResponse createEmptyInstance() => create();
  static $pb.PbList<AdminUpdateSellRateResponse> createRepeated() => $pb.PbList<AdminUpdateSellRateResponse>();
  @$core.pragma('dart2js:noInline')
  static AdminUpdateSellRateResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminUpdateSellRateResponse>(create);
  static AdminUpdateSellRateResponse? _defaultInstance;

  @$pb.TagNumber(1)
  SellRateConfig get rate => $_getN(0);
  @$pb.TagNumber(1)
  set rate(SellRateConfig v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasRate() => $_has(0);
  @$pb.TagNumber(1)
  void clearRate() => clearField(1);
  @$pb.TagNumber(1)
  SellRateConfig ensureRate() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
}

class AdminToggleSellRateRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AdminToggleSellRateRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isActive')
    ..hasRequiredFields = false
  ;

  AdminToggleSellRateRequest._() : super();
  factory AdminToggleSellRateRequest({
    $core.String? id,
    $core.bool? isActive,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (isActive != null) {
      _result.isActive = isActive;
    }
    return _result;
  }
  factory AdminToggleSellRateRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AdminToggleSellRateRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AdminToggleSellRateRequest clone() => AdminToggleSellRateRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AdminToggleSellRateRequest copyWith(void Function(AdminToggleSellRateRequest) updates) => super.copyWith((message) => updates(message as AdminToggleSellRateRequest)) as AdminToggleSellRateRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AdminToggleSellRateRequest create() => AdminToggleSellRateRequest._();
  AdminToggleSellRateRequest createEmptyInstance() => create();
  static $pb.PbList<AdminToggleSellRateRequest> createRepeated() => $pb.PbList<AdminToggleSellRateRequest>();
  @$core.pragma('dart2js:noInline')
  static AdminToggleSellRateRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminToggleSellRateRequest>(create);
  static AdminToggleSellRateRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get isActive => $_getBF(1);
  @$pb.TagNumber(2)
  set isActive($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasIsActive() => $_has(1);
  @$pb.TagNumber(2)
  void clearIsActive() => clearField(2);
}

class AdminToggleSellRateResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AdminToggleSellRateResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  AdminToggleSellRateResponse._() : super();
  factory AdminToggleSellRateResponse({
    $core.String? message,
  }) {
    final _result = create();
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory AdminToggleSellRateResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AdminToggleSellRateResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AdminToggleSellRateResponse clone() => AdminToggleSellRateResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AdminToggleSellRateResponse copyWith(void Function(AdminToggleSellRateResponse) updates) => super.copyWith((message) => updates(message as AdminToggleSellRateResponse)) as AdminToggleSellRateResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AdminToggleSellRateResponse create() => AdminToggleSellRateResponse._();
  AdminToggleSellRateResponse createEmptyInstance() => create();
  static $pb.PbList<AdminToggleSellRateResponse> createRepeated() => $pb.PbList<AdminToggleSellRateResponse>();
  @$core.pragma('dart2js:noInline')
  static AdminToggleSellRateResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminToggleSellRateResponse>(create);
  static AdminToggleSellRateResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get message => $_getSZ(0);
  @$pb.TagNumber(1)
  set message($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessage() => clearField(1);
}

class GiftCardCountry extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GiftCardCountry', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isoCode')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'flagUrl')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currencyCode')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currencyName')
    ..hasRequiredFields = false
  ;

  GiftCardCountry._() : super();
  factory GiftCardCountry({
    $core.String? isoCode,
    $core.String? name,
    $core.String? flagUrl,
    $core.String? currencyCode,
    $core.String? currencyName,
  }) {
    final _result = create();
    if (isoCode != null) {
      _result.isoCode = isoCode;
    }
    if (name != null) {
      _result.name = name;
    }
    if (flagUrl != null) {
      _result.flagUrl = flagUrl;
    }
    if (currencyCode != null) {
      _result.currencyCode = currencyCode;
    }
    if (currencyName != null) {
      _result.currencyName = currencyName;
    }
    return _result;
  }
  factory GiftCardCountry.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GiftCardCountry.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GiftCardCountry clone() => GiftCardCountry()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GiftCardCountry copyWith(void Function(GiftCardCountry) updates) => super.copyWith((message) => updates(message as GiftCardCountry)) as GiftCardCountry; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GiftCardCountry create() => GiftCardCountry._();
  GiftCardCountry createEmptyInstance() => create();
  static $pb.PbList<GiftCardCountry> createRepeated() => $pb.PbList<GiftCardCountry>();
  @$core.pragma('dart2js:noInline')
  static GiftCardCountry getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GiftCardCountry>(create);
  static GiftCardCountry? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get isoCode => $_getSZ(0);
  @$pb.TagNumber(1)
  set isoCode($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasIsoCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearIsoCode() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get flagUrl => $_getSZ(2);
  @$pb.TagNumber(3)
  set flagUrl($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasFlagUrl() => $_has(2);
  @$pb.TagNumber(3)
  void clearFlagUrl() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get currencyCode => $_getSZ(3);
  @$pb.TagNumber(4)
  set currencyCode($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCurrencyCode() => $_has(3);
  @$pb.TagNumber(4)
  void clearCurrencyCode() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get currencyName => $_getSZ(4);
  @$pb.TagNumber(5)
  set currencyName($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasCurrencyName() => $_has(4);
  @$pb.TagNumber(5)
  void clearCurrencyName() => clearField(5);
}

class GetSupportedCountriesRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetSupportedCountriesRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetSupportedCountriesRequest._() : super();
  factory GetSupportedCountriesRequest() => create();
  factory GetSupportedCountriesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetSupportedCountriesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetSupportedCountriesRequest clone() => GetSupportedCountriesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetSupportedCountriesRequest copyWith(void Function(GetSupportedCountriesRequest) updates) => super.copyWith((message) => updates(message as GetSupportedCountriesRequest)) as GetSupportedCountriesRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetSupportedCountriesRequest create() => GetSupportedCountriesRequest._();
  GetSupportedCountriesRequest createEmptyInstance() => create();
  static $pb.PbList<GetSupportedCountriesRequest> createRepeated() => $pb.PbList<GetSupportedCountriesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetSupportedCountriesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetSupportedCountriesRequest>(create);
  static GetSupportedCountriesRequest? _defaultInstance;
}

class GetSupportedCountriesResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetSupportedCountriesResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..pc<GiftCardCountry>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'countries', $pb.PbFieldType.PM, subBuilder: GiftCardCountry.create)
    ..hasRequiredFields = false
  ;

  GetSupportedCountriesResponse._() : super();
  factory GetSupportedCountriesResponse({
    $core.Iterable<GiftCardCountry>? countries,
  }) {
    final _result = create();
    if (countries != null) {
      _result.countries.addAll(countries);
    }
    return _result;
  }
  factory GetSupportedCountriesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetSupportedCountriesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetSupportedCountriesResponse clone() => GetSupportedCountriesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetSupportedCountriesResponse copyWith(void Function(GetSupportedCountriesResponse) updates) => super.copyWith((message) => updates(message as GetSupportedCountriesResponse)) as GetSupportedCountriesResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetSupportedCountriesResponse create() => GetSupportedCountriesResponse._();
  GetSupportedCountriesResponse createEmptyInstance() => create();
  static $pb.PbList<GetSupportedCountriesResponse> createRepeated() => $pb.PbList<GetSupportedCountriesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetSupportedCountriesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetSupportedCountriesResponse>(create);
  static GetSupportedCountriesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<GiftCardCountry> get countries => $_getList(0);
}

