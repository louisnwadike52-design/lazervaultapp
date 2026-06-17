///
//  Generated code. Do not modify.
//  source: giftcards.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'giftcards.pbenum.dart';

export 'giftcards.pbenum.dart';

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
    ..aOS(34, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reference')
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
    $core.String? reference,
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
    if (reference != null) {
      _result.reference = reference;
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

  @$pb.TagNumber(34)
  $core.String get reference => $_getSZ(29);
  @$pb.TagNumber(34)
  set reference($core.String v) { $_setString(29, v); }
  @$pb.TagNumber(34)
  $core.bool hasReference() => $_has(29);
  @$pb.TagNumber(34)
  void clearReference() => clearField(34);
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
    ..aOS(25, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'denominationType')
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
    $core.String? denominationType,
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
    if (denominationType != null) {
      _result.denominationType = denominationType;
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

  @$pb.TagNumber(25)
  $core.String get denominationType => $_getSZ(24);
  @$pb.TagNumber(25)
  set denominationType($core.String v) { $_setString(24, v); }
  @$pb.TagNumber(25)
  $core.bool hasDenominationType() => $_has(24);
  @$pb.TagNumber(25)
  void clearDenominationType() => clearField(25);
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

class BuyError extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'BuyError', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..e<BuyErrorCode>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'code', $pb.PbFieldType.OE, defaultOrMaker: BuyErrorCode.BUY_ERROR_UNSPECIFIED, valueOf: BuyErrorCode.valueOf, enumValues: BuyErrorCode.values)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  BuyError._() : super();
  factory BuyError({
    BuyErrorCode? code,
    $core.String? message,
  }) {
    final _result = create();
    if (code != null) {
      _result.code = code;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory BuyError.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BuyError.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BuyError clone() => BuyError()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BuyError copyWith(void Function(BuyError) updates) => super.copyWith((message) => updates(message as BuyError)) as BuyError; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static BuyError create() => BuyError._();
  BuyError createEmptyInstance() => create();
  static $pb.PbList<BuyError> createRepeated() => $pb.PbList<BuyError>();
  @$core.pragma('dart2js:noInline')
  static BuyError getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BuyError>(create);
  static BuyError? _defaultInstance;

  @$pb.TagNumber(1)
  BuyErrorCode get code => $_getN(0);
  @$pb.TagNumber(1)
  set code(BuyErrorCode v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearCode() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);
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
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'form')
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'subcategoryId')
    ..aOS(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'country')
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
    $core.String? form,
    $core.String? subcategoryId,
    $core.String? country,
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
    if (form != null) {
      _result.form = form;
    }
    if (subcategoryId != null) {
      _result.subcategoryId = subcategoryId;
    }
    if (country != null) {
      _result.country = country;
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

  @$pb.TagNumber(10)
  $core.String get form => $_getSZ(9);
  @$pb.TagNumber(10)
  set form($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasForm() => $_has(9);
  @$pb.TagNumber(10)
  void clearForm() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get subcategoryId => $_getSZ(10);
  @$pb.TagNumber(11)
  set subcategoryId($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasSubcategoryId() => $_has(10);
  @$pb.TagNumber(11)
  void clearSubcategoryId() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get country => $_getSZ(11);
  @$pb.TagNumber(12)
  set country($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasCountry() => $_has(11);
  @$pb.TagNumber(12)
  void clearCountry() => clearField(12);
}

class SellRate extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SellRate', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cardType')
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'denomination', $pb.PbFieldType.OD)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ratePercentage', $pb.PbFieldType.OD)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payoutAmount', $pb.PbFieldType.OD)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'expiresAt')
    ..a<$core.double>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payoutLowerBound', $pb.PbFieldType.OD)
    ..a<$core.double>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payoutUpperBound', $pb.PbFieldType.OD)
    ..aOB(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isManualMode')
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
    $core.double? payoutLowerBound,
    $core.double? payoutUpperBound,
    $core.bool? isManualMode,
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
    if (payoutLowerBound != null) {
      _result.payoutLowerBound = payoutLowerBound;
    }
    if (payoutUpperBound != null) {
      _result.payoutUpperBound = payoutUpperBound;
    }
    if (isManualMode != null) {
      _result.isManualMode = isManualMode;
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

  @$pb.TagNumber(7)
  $core.double get payoutLowerBound => $_getN(6);
  @$pb.TagNumber(7)
  set payoutLowerBound($core.double v) { $_setDouble(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasPayoutLowerBound() => $_has(6);
  @$pb.TagNumber(7)
  void clearPayoutLowerBound() => clearField(7);

  @$pb.TagNumber(8)
  $core.double get payoutUpperBound => $_getN(7);
  @$pb.TagNumber(8)
  set payoutUpperBound($core.double v) { $_setDouble(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasPayoutUpperBound() => $_has(7);
  @$pb.TagNumber(8)
  void clearPayoutUpperBound() => clearField(8);

  @$pb.TagNumber(9)
  $core.bool get isManualMode => $_getBF(8);
  @$pb.TagNumber(9)
  set isManualMode($core.bool v) { $_setBool(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasIsManualMode() => $_has(8);
  @$pb.TagNumber(9)
  void clearIsManualMode() => clearField(9);
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
    ..aOS(41, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'brandName')
    ..a<$core.double>(42, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'originalAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(43, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'retailAmount', $pb.PbFieldType.OD)
    ..aOS(44, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'retailCurrency')
    ..a<$core.double>(45, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'wholesaleAmount', $pb.PbFieldType.OD)
    ..aOS(46, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'wholesaleCurrency')
    ..a<$core.double>(47, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'commissionAmountBuy', $pb.PbFieldType.OD)
    ..aOS(48, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'commissionCurrency')
    ..a<$core.double>(49, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'senderAmount', $pb.PbFieldType.OD)
    ..aOS(50, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'senderCurrency')
    ..a<$core.double>(51, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fxRate', $pb.PbFieldType.OD)
    ..a<$core.double>(52, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'feePercentage', $pb.PbFieldType.OD)
    ..aOS(53, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'redemptionCode')
    ..aOS(54, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'redemptionPin')
    ..aOS(55, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerTransactionId')
    ..aOS(56, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'completedAt')
    ..aOS(57, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'requestJson')
    ..aOS(58, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'responseJson')
    ..a<$core.int>(59, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerHttpStatus', $pb.PbFieldType.O3)
    ..aInt64(60, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerDurationMs')
    ..aOS(61, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'failureReason')
    ..aOS(62, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'quoteProvider')
    ..aOS(63, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'settlementStatus')
    ..aOS(64, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'displayStatus')
    ..aOS(65, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'escalatedAt')
    ..aOS(66, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'escalationReason')
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
    $core.String? brandName,
    $core.double? originalAmount,
    $core.double? retailAmount,
    $core.String? retailCurrency,
    $core.double? wholesaleAmount,
    $core.String? wholesaleCurrency,
    $core.double? commissionAmountBuy,
    $core.String? commissionCurrency,
    $core.double? senderAmount,
    $core.String? senderCurrency,
    $core.double? fxRate,
    $core.double? feePercentage,
    $core.String? redemptionCode,
    $core.String? redemptionPin,
    $core.String? providerTransactionId,
    $core.String? completedAt,
    $core.String? requestJson,
    $core.String? responseJson,
    $core.int? providerHttpStatus,
    $fixnum.Int64? providerDurationMs,
    $core.String? failureReason,
    $core.String? quoteProvider,
    $core.String? settlementStatus,
    $core.String? displayStatus,
    $core.String? escalatedAt,
    $core.String? escalationReason,
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
    if (brandName != null) {
      _result.brandName = brandName;
    }
    if (originalAmount != null) {
      _result.originalAmount = originalAmount;
    }
    if (retailAmount != null) {
      _result.retailAmount = retailAmount;
    }
    if (retailCurrency != null) {
      _result.retailCurrency = retailCurrency;
    }
    if (wholesaleAmount != null) {
      _result.wholesaleAmount = wholesaleAmount;
    }
    if (wholesaleCurrency != null) {
      _result.wholesaleCurrency = wholesaleCurrency;
    }
    if (commissionAmountBuy != null) {
      _result.commissionAmountBuy = commissionAmountBuy;
    }
    if (commissionCurrency != null) {
      _result.commissionCurrency = commissionCurrency;
    }
    if (senderAmount != null) {
      _result.senderAmount = senderAmount;
    }
    if (senderCurrency != null) {
      _result.senderCurrency = senderCurrency;
    }
    if (fxRate != null) {
      _result.fxRate = fxRate;
    }
    if (feePercentage != null) {
      _result.feePercentage = feePercentage;
    }
    if (redemptionCode != null) {
      _result.redemptionCode = redemptionCode;
    }
    if (redemptionPin != null) {
      _result.redemptionPin = redemptionPin;
    }
    if (providerTransactionId != null) {
      _result.providerTransactionId = providerTransactionId;
    }
    if (completedAt != null) {
      _result.completedAt = completedAt;
    }
    if (requestJson != null) {
      _result.requestJson = requestJson;
    }
    if (responseJson != null) {
      _result.responseJson = responseJson;
    }
    if (providerHttpStatus != null) {
      _result.providerHttpStatus = providerHttpStatus;
    }
    if (providerDurationMs != null) {
      _result.providerDurationMs = providerDurationMs;
    }
    if (failureReason != null) {
      _result.failureReason = failureReason;
    }
    if (quoteProvider != null) {
      _result.quoteProvider = quoteProvider;
    }
    if (settlementStatus != null) {
      _result.settlementStatus = settlementStatus;
    }
    if (displayStatus != null) {
      _result.displayStatus = displayStatus;
    }
    if (escalatedAt != null) {
      _result.escalatedAt = escalatedAt;
    }
    if (escalationReason != null) {
      _result.escalationReason = escalationReason;
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

  @$pb.TagNumber(41)
  $core.String get brandName => $_getSZ(40);
  @$pb.TagNumber(41)
  set brandName($core.String v) { $_setString(40, v); }
  @$pb.TagNumber(41)
  $core.bool hasBrandName() => $_has(40);
  @$pb.TagNumber(41)
  void clearBrandName() => clearField(41);

  @$pb.TagNumber(42)
  $core.double get originalAmount => $_getN(41);
  @$pb.TagNumber(42)
  set originalAmount($core.double v) { $_setDouble(41, v); }
  @$pb.TagNumber(42)
  $core.bool hasOriginalAmount() => $_has(41);
  @$pb.TagNumber(42)
  void clearOriginalAmount() => clearField(42);

  @$pb.TagNumber(43)
  $core.double get retailAmount => $_getN(42);
  @$pb.TagNumber(43)
  set retailAmount($core.double v) { $_setDouble(42, v); }
  @$pb.TagNumber(43)
  $core.bool hasRetailAmount() => $_has(42);
  @$pb.TagNumber(43)
  void clearRetailAmount() => clearField(43);

  @$pb.TagNumber(44)
  $core.String get retailCurrency => $_getSZ(43);
  @$pb.TagNumber(44)
  set retailCurrency($core.String v) { $_setString(43, v); }
  @$pb.TagNumber(44)
  $core.bool hasRetailCurrency() => $_has(43);
  @$pb.TagNumber(44)
  void clearRetailCurrency() => clearField(44);

  @$pb.TagNumber(45)
  $core.double get wholesaleAmount => $_getN(44);
  @$pb.TagNumber(45)
  set wholesaleAmount($core.double v) { $_setDouble(44, v); }
  @$pb.TagNumber(45)
  $core.bool hasWholesaleAmount() => $_has(44);
  @$pb.TagNumber(45)
  void clearWholesaleAmount() => clearField(45);

  @$pb.TagNumber(46)
  $core.String get wholesaleCurrency => $_getSZ(45);
  @$pb.TagNumber(46)
  set wholesaleCurrency($core.String v) { $_setString(45, v); }
  @$pb.TagNumber(46)
  $core.bool hasWholesaleCurrency() => $_has(45);
  @$pb.TagNumber(46)
  void clearWholesaleCurrency() => clearField(46);

  @$pb.TagNumber(47)
  $core.double get commissionAmountBuy => $_getN(46);
  @$pb.TagNumber(47)
  set commissionAmountBuy($core.double v) { $_setDouble(46, v); }
  @$pb.TagNumber(47)
  $core.bool hasCommissionAmountBuy() => $_has(46);
  @$pb.TagNumber(47)
  void clearCommissionAmountBuy() => clearField(47);

  @$pb.TagNumber(48)
  $core.String get commissionCurrency => $_getSZ(47);
  @$pb.TagNumber(48)
  set commissionCurrency($core.String v) { $_setString(47, v); }
  @$pb.TagNumber(48)
  $core.bool hasCommissionCurrency() => $_has(47);
  @$pb.TagNumber(48)
  void clearCommissionCurrency() => clearField(48);

  @$pb.TagNumber(49)
  $core.double get senderAmount => $_getN(48);
  @$pb.TagNumber(49)
  set senderAmount($core.double v) { $_setDouble(48, v); }
  @$pb.TagNumber(49)
  $core.bool hasSenderAmount() => $_has(48);
  @$pb.TagNumber(49)
  void clearSenderAmount() => clearField(49);

  @$pb.TagNumber(50)
  $core.String get senderCurrency => $_getSZ(49);
  @$pb.TagNumber(50)
  set senderCurrency($core.String v) { $_setString(49, v); }
  @$pb.TagNumber(50)
  $core.bool hasSenderCurrency() => $_has(49);
  @$pb.TagNumber(50)
  void clearSenderCurrency() => clearField(50);

  @$pb.TagNumber(51)
  $core.double get fxRate => $_getN(50);
  @$pb.TagNumber(51)
  set fxRate($core.double v) { $_setDouble(50, v); }
  @$pb.TagNumber(51)
  $core.bool hasFxRate() => $_has(50);
  @$pb.TagNumber(51)
  void clearFxRate() => clearField(51);

  @$pb.TagNumber(52)
  $core.double get feePercentage => $_getN(51);
  @$pb.TagNumber(52)
  set feePercentage($core.double v) { $_setDouble(51, v); }
  @$pb.TagNumber(52)
  $core.bool hasFeePercentage() => $_has(51);
  @$pb.TagNumber(52)
  void clearFeePercentage() => clearField(52);

  @$pb.TagNumber(53)
  $core.String get redemptionCode => $_getSZ(52);
  @$pb.TagNumber(53)
  set redemptionCode($core.String v) { $_setString(52, v); }
  @$pb.TagNumber(53)
  $core.bool hasRedemptionCode() => $_has(52);
  @$pb.TagNumber(53)
  void clearRedemptionCode() => clearField(53);

  @$pb.TagNumber(54)
  $core.String get redemptionPin => $_getSZ(53);
  @$pb.TagNumber(54)
  set redemptionPin($core.String v) { $_setString(53, v); }
  @$pb.TagNumber(54)
  $core.bool hasRedemptionPin() => $_has(53);
  @$pb.TagNumber(54)
  void clearRedemptionPin() => clearField(54);

  @$pb.TagNumber(55)
  $core.String get providerTransactionId => $_getSZ(54);
  @$pb.TagNumber(55)
  set providerTransactionId($core.String v) { $_setString(54, v); }
  @$pb.TagNumber(55)
  $core.bool hasProviderTransactionId() => $_has(54);
  @$pb.TagNumber(55)
  void clearProviderTransactionId() => clearField(55);

  @$pb.TagNumber(56)
  $core.String get completedAt => $_getSZ(55);
  @$pb.TagNumber(56)
  set completedAt($core.String v) { $_setString(55, v); }
  @$pb.TagNumber(56)
  $core.bool hasCompletedAt() => $_has(55);
  @$pb.TagNumber(56)
  void clearCompletedAt() => clearField(56);

  @$pb.TagNumber(57)
  $core.String get requestJson => $_getSZ(56);
  @$pb.TagNumber(57)
  set requestJson($core.String v) { $_setString(56, v); }
  @$pb.TagNumber(57)
  $core.bool hasRequestJson() => $_has(56);
  @$pb.TagNumber(57)
  void clearRequestJson() => clearField(57);

  @$pb.TagNumber(58)
  $core.String get responseJson => $_getSZ(57);
  @$pb.TagNumber(58)
  set responseJson($core.String v) { $_setString(57, v); }
  @$pb.TagNumber(58)
  $core.bool hasResponseJson() => $_has(57);
  @$pb.TagNumber(58)
  void clearResponseJson() => clearField(58);

  @$pb.TagNumber(59)
  $core.int get providerHttpStatus => $_getIZ(58);
  @$pb.TagNumber(59)
  set providerHttpStatus($core.int v) { $_setSignedInt32(58, v); }
  @$pb.TagNumber(59)
  $core.bool hasProviderHttpStatus() => $_has(58);
  @$pb.TagNumber(59)
  void clearProviderHttpStatus() => clearField(59);

  @$pb.TagNumber(60)
  $fixnum.Int64 get providerDurationMs => $_getI64(59);
  @$pb.TagNumber(60)
  set providerDurationMs($fixnum.Int64 v) { $_setInt64(59, v); }
  @$pb.TagNumber(60)
  $core.bool hasProviderDurationMs() => $_has(59);
  @$pb.TagNumber(60)
  void clearProviderDurationMs() => clearField(60);

  @$pb.TagNumber(61)
  $core.String get failureReason => $_getSZ(60);
  @$pb.TagNumber(61)
  set failureReason($core.String v) { $_setString(60, v); }
  @$pb.TagNumber(61)
  $core.bool hasFailureReason() => $_has(60);
  @$pb.TagNumber(61)
  void clearFailureReason() => clearField(61);

  @$pb.TagNumber(62)
  $core.String get quoteProvider => $_getSZ(61);
  @$pb.TagNumber(62)
  set quoteProvider($core.String v) { $_setString(61, v); }
  @$pb.TagNumber(62)
  $core.bool hasQuoteProvider() => $_has(61);
  @$pb.TagNumber(62)
  void clearQuoteProvider() => clearField(62);

  @$pb.TagNumber(63)
  $core.String get settlementStatus => $_getSZ(62);
  @$pb.TagNumber(63)
  set settlementStatus($core.String v) { $_setString(62, v); }
  @$pb.TagNumber(63)
  $core.bool hasSettlementStatus() => $_has(62);
  @$pb.TagNumber(63)
  void clearSettlementStatus() => clearField(63);

  @$pb.TagNumber(64)
  $core.String get displayStatus => $_getSZ(63);
  @$pb.TagNumber(64)
  set displayStatus($core.String v) { $_setString(63, v); }
  @$pb.TagNumber(64)
  $core.bool hasDisplayStatus() => $_has(63);
  @$pb.TagNumber(64)
  void clearDisplayStatus() => clearField(64);

  @$pb.TagNumber(65)
  $core.String get escalatedAt => $_getSZ(64);
  @$pb.TagNumber(65)
  set escalatedAt($core.String v) { $_setString(64, v); }
  @$pb.TagNumber(65)
  $core.bool hasEscalatedAt() => $_has(64);
  @$pb.TagNumber(65)
  void clearEscalatedAt() => clearField(65);

  @$pb.TagNumber(66)
  $core.String get escalationReason => $_getSZ(65);
  @$pb.TagNumber(66)
  set escalationReason($core.String v) { $_setString(65, v); }
  @$pb.TagNumber(66)
  $core.bool hasEscalationReason() => $_has(65);
  @$pb.TagNumber(66)
  void clearEscalationReason() => clearField(66);
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

class GetSellProviderRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetSellProviderRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetSellProviderRequest._() : super();
  factory GetSellProviderRequest() => create();
  factory GetSellProviderRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetSellProviderRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetSellProviderRequest clone() => GetSellProviderRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetSellProviderRequest copyWith(void Function(GetSellProviderRequest) updates) => super.copyWith((message) => updates(message as GetSellProviderRequest)) as GetSellProviderRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetSellProviderRequest create() => GetSellProviderRequest._();
  GetSellProviderRequest createEmptyInstance() => create();
  static $pb.PbList<GetSellProviderRequest> createRepeated() => $pb.PbList<GetSellProviderRequest>();
  @$core.pragma('dart2js:noInline')
  static GetSellProviderRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetSellProviderRequest>(create);
  static GetSellProviderRequest? _defaultInstance;
}

class GetSellProviderResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetSellProviderResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'provider')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'mode')
    ..aOB(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'asyncEnabled')
    ..hasRequiredFields = false
  ;

  GetSellProviderResponse._() : super();
  factory GetSellProviderResponse({
    $core.String? provider,
    $core.String? description,
    $core.String? mode,
    $core.bool? asyncEnabled,
  }) {
    final _result = create();
    if (provider != null) {
      _result.provider = provider;
    }
    if (description != null) {
      _result.description = description;
    }
    if (mode != null) {
      _result.mode = mode;
    }
    if (asyncEnabled != null) {
      _result.asyncEnabled = asyncEnabled;
    }
    return _result;
  }
  factory GetSellProviderResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetSellProviderResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetSellProviderResponse clone() => GetSellProviderResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetSellProviderResponse copyWith(void Function(GetSellProviderResponse) updates) => super.copyWith((message) => updates(message as GetSellProviderResponse)) as GetSellProviderResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetSellProviderResponse create() => GetSellProviderResponse._();
  GetSellProviderResponse createEmptyInstance() => create();
  static $pb.PbList<GetSellProviderResponse> createRepeated() => $pb.PbList<GetSellProviderResponse>();
  @$core.pragma('dart2js:noInline')
  static GetSellProviderResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetSellProviderResponse>(create);
  static GetSellProviderResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get provider => $_getSZ(0);
  @$pb.TagNumber(1)
  set provider($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasProvider() => $_has(0);
  @$pb.TagNumber(1)
  void clearProvider() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get description => $_getSZ(1);
  @$pb.TagNumber(2)
  set description($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasDescription() => $_has(1);
  @$pb.TagNumber(2)
  void clearDescription() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get mode => $_getSZ(2);
  @$pb.TagNumber(3)
  set mode($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMode() => $_has(2);
  @$pb.TagNumber(3)
  void clearMode() => clearField(3);

  @$pb.TagNumber(4)
  $core.bool get asyncEnabled => $_getBF(3);
  @$pb.TagNumber(4)
  set asyncEnabled($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAsyncEnabled() => $_has(3);
  @$pb.TagNumber(4)
  void clearAsyncEnabled() => clearField(4);
}

class UpdateFeatureFlagRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateFeatureFlagRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'key')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'value')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reason')
    ..hasRequiredFields = false
  ;

  UpdateFeatureFlagRequest._() : super();
  factory UpdateFeatureFlagRequest({
    $core.String? key,
    $core.String? value,
    $core.String? reason,
  }) {
    final _result = create();
    if (key != null) {
      _result.key = key;
    }
    if (value != null) {
      _result.value = value;
    }
    if (reason != null) {
      _result.reason = reason;
    }
    return _result;
  }
  factory UpdateFeatureFlagRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateFeatureFlagRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateFeatureFlagRequest clone() => UpdateFeatureFlagRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateFeatureFlagRequest copyWith(void Function(UpdateFeatureFlagRequest) updates) => super.copyWith((message) => updates(message as UpdateFeatureFlagRequest)) as UpdateFeatureFlagRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpdateFeatureFlagRequest create() => UpdateFeatureFlagRequest._();
  UpdateFeatureFlagRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateFeatureFlagRequest> createRepeated() => $pb.PbList<UpdateFeatureFlagRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateFeatureFlagRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateFeatureFlagRequest>(create);
  static UpdateFeatureFlagRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get key => $_getSZ(0);
  @$pb.TagNumber(1)
  set key($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearKey() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get value => $_getSZ(1);
  @$pb.TagNumber(2)
  set value($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearValue() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get reason => $_getSZ(2);
  @$pb.TagNumber(3)
  set reason($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasReason() => $_has(2);
  @$pb.TagNumber(3)
  void clearReason() => clearField(3);
}

class UpdateFeatureFlagResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateFeatureFlagResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  UpdateFeatureFlagResponse._() : super();
  factory UpdateFeatureFlagResponse({
    $core.bool? success,
    $core.String? message,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory UpdateFeatureFlagResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateFeatureFlagResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateFeatureFlagResponse clone() => UpdateFeatureFlagResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateFeatureFlagResponse copyWith(void Function(UpdateFeatureFlagResponse) updates) => super.copyWith((message) => updates(message as UpdateFeatureFlagResponse)) as UpdateFeatureFlagResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpdateFeatureFlagResponse create() => UpdateFeatureFlagResponse._();
  UpdateFeatureFlagResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateFeatureFlagResponse> createRepeated() => $pb.PbList<UpdateFeatureFlagResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateFeatureFlagResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateFeatureFlagResponse>(create);
  static UpdateFeatureFlagResponse? _defaultInstance;

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

class GetPayoutMethodsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetPayoutMethodsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetPayoutMethodsRequest._() : super();
  factory GetPayoutMethodsRequest() => create();
  factory GetPayoutMethodsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPayoutMethodsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPayoutMethodsRequest clone() => GetPayoutMethodsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPayoutMethodsRequest copyWith(void Function(GetPayoutMethodsRequest) updates) => super.copyWith((message) => updates(message as GetPayoutMethodsRequest)) as GetPayoutMethodsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetPayoutMethodsRequest create() => GetPayoutMethodsRequest._();
  GetPayoutMethodsRequest createEmptyInstance() => create();
  static $pb.PbList<GetPayoutMethodsRequest> createRepeated() => $pb.PbList<GetPayoutMethodsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetPayoutMethodsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetPayoutMethodsRequest>(create);
  static GetPayoutMethodsRequest? _defaultInstance;
}

class PayoutMethod extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PayoutMethod', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'available')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..hasRequiredFields = false
  ;

  PayoutMethod._() : super();
  factory PayoutMethod({
    $core.String? name,
    $core.bool? available,
    $core.String? currency,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    if (available != null) {
      _result.available = available;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    return _result;
  }
  factory PayoutMethod.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PayoutMethod.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PayoutMethod clone() => PayoutMethod()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PayoutMethod copyWith(void Function(PayoutMethod) updates) => super.copyWith((message) => updates(message as PayoutMethod)) as PayoutMethod; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PayoutMethod create() => PayoutMethod._();
  PayoutMethod createEmptyInstance() => create();
  static $pb.PbList<PayoutMethod> createRepeated() => $pb.PbList<PayoutMethod>();
  @$core.pragma('dart2js:noInline')
  static PayoutMethod getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PayoutMethod>(create);
  static PayoutMethod? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get available => $_getBF(1);
  @$pb.TagNumber(2)
  set available($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAvailable() => $_has(1);
  @$pb.TagNumber(2)
  void clearAvailable() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get currency => $_getSZ(2);
  @$pb.TagNumber(3)
  set currency($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCurrency() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrency() => clearField(3);
}

class GetPayoutMethodsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetPayoutMethodsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..pc<PayoutMethod>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'methods', $pb.PbFieldType.PM, subBuilder: PayoutMethod.create)
    ..hasRequiredFields = false
  ;

  GetPayoutMethodsResponse._() : super();
  factory GetPayoutMethodsResponse({
    $core.Iterable<PayoutMethod>? methods,
  }) {
    final _result = create();
    if (methods != null) {
      _result.methods.addAll(methods);
    }
    return _result;
  }
  factory GetPayoutMethodsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPayoutMethodsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPayoutMethodsResponse clone() => GetPayoutMethodsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPayoutMethodsResponse copyWith(void Function(GetPayoutMethodsResponse) updates) => super.copyWith((message) => updates(message as GetPayoutMethodsResponse)) as GetPayoutMethodsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetPayoutMethodsResponse create() => GetPayoutMethodsResponse._();
  GetPayoutMethodsResponse createEmptyInstance() => create();
  static $pb.PbList<GetPayoutMethodsResponse> createRepeated() => $pb.PbList<GetPayoutMethodsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetPayoutMethodsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetPayoutMethodsResponse>(create);
  static GetPayoutMethodsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<PayoutMethod> get methods => $_getList(0);
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
    ..aOS(21, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'subcategoryId')
    ..aOS(22, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'form')
    ..aOS(23, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payoutMethod')
    ..aOS(24, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cardCode')
    ..aOB(25, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'disclaimerAccepted')
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
    $core.String? subcategoryId,
    $core.String? form,
    $core.String? payoutMethod,
    $core.String? cardCode,
    $core.bool? disclaimerAccepted,
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
    if (subcategoryId != null) {
      _result.subcategoryId = subcategoryId;
    }
    if (form != null) {
      _result.form = form;
    }
    if (payoutMethod != null) {
      _result.payoutMethod = payoutMethod;
    }
    if (cardCode != null) {
      _result.cardCode = cardCode;
    }
    if (disclaimerAccepted != null) {
      _result.disclaimerAccepted = disclaimerAccepted;
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

  @$pb.TagNumber(21)
  $core.String get subcategoryId => $_getSZ(20);
  @$pb.TagNumber(21)
  set subcategoryId($core.String v) { $_setString(20, v); }
  @$pb.TagNumber(21)
  $core.bool hasSubcategoryId() => $_has(20);
  @$pb.TagNumber(21)
  void clearSubcategoryId() => clearField(21);

  @$pb.TagNumber(22)
  $core.String get form => $_getSZ(21);
  @$pb.TagNumber(22)
  set form($core.String v) { $_setString(21, v); }
  @$pb.TagNumber(22)
  $core.bool hasForm() => $_has(21);
  @$pb.TagNumber(22)
  void clearForm() => clearField(22);

  @$pb.TagNumber(23)
  $core.String get payoutMethod => $_getSZ(22);
  @$pb.TagNumber(23)
  set payoutMethod($core.String v) { $_setString(22, v); }
  @$pb.TagNumber(23)
  $core.bool hasPayoutMethod() => $_has(22);
  @$pb.TagNumber(23)
  void clearPayoutMethod() => clearField(23);

  @$pb.TagNumber(24)
  $core.String get cardCode => $_getSZ(23);
  @$pb.TagNumber(24)
  set cardCode($core.String v) { $_setString(23, v); }
  @$pb.TagNumber(24)
  $core.bool hasCardCode() => $_has(23);
  @$pb.TagNumber(24)
  void clearCardCode() => clearField(24);

  @$pb.TagNumber(25)
  $core.bool get disclaimerAccepted => $_getBF(24);
  @$pb.TagNumber(25)
  set disclaimerAccepted($core.bool v) { $_setBool(24, v); }
  @$pb.TagNumber(25)
  $core.bool hasDisclaimerAccepted() => $_has(24);
  @$pb.TagNumber(25)
  void clearDisclaimerAccepted() => clearField(25);
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

class AdminListSellSettlementsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AdminListSellSettlementsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'source')
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  AdminListSellSettlementsRequest._() : super();
  factory AdminListSellSettlementsRequest({
    $core.String? status,
    $core.String? source,
    $core.int? page,
    $core.int? limit,
  }) {
    final _result = create();
    if (status != null) {
      _result.status = status;
    }
    if (source != null) {
      _result.source = source;
    }
    if (page != null) {
      _result.page = page;
    }
    if (limit != null) {
      _result.limit = limit;
    }
    return _result;
  }
  factory AdminListSellSettlementsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AdminListSellSettlementsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AdminListSellSettlementsRequest clone() => AdminListSellSettlementsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AdminListSellSettlementsRequest copyWith(void Function(AdminListSellSettlementsRequest) updates) => super.copyWith((message) => updates(message as AdminListSellSettlementsRequest)) as AdminListSellSettlementsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AdminListSellSettlementsRequest create() => AdminListSellSettlementsRequest._();
  AdminListSellSettlementsRequest createEmptyInstance() => create();
  static $pb.PbList<AdminListSellSettlementsRequest> createRepeated() => $pb.PbList<AdminListSellSettlementsRequest>();
  @$core.pragma('dart2js:noInline')
  static AdminListSellSettlementsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminListSellSettlementsRequest>(create);
  static AdminListSellSettlementsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get status => $_getSZ(0);
  @$pb.TagNumber(1)
  set status($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get source => $_getSZ(1);
  @$pb.TagNumber(2)
  set source($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSource() => $_has(1);
  @$pb.TagNumber(2)
  void clearSource() => clearField(2);

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

class AdminSellSettlement extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AdminSellSettlement', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reference')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'brand')
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'faceValue', $pb.PbFieldType.OD)
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'faceCurrency')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payoutCurrency')
    ..a<$core.double>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fxRate', $pb.PbFieldType.OD)
    ..a<$core.double>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'preMarginPayout', $pb.PbFieldType.OD)
    ..a<$core.double>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paidToUser', $pb.PbFieldType.OD)
    ..a<$core.double>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'saleProceeds', $pb.PbFieldType.OD)
    ..aOS(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'saleProceedsCurrency')
    ..a<$core.double>(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalRevenue', $pb.PbFieldType.OD)
    ..aOS(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalRevenueCurrency')
    ..a<$core.double>(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'marginPercentage', $pb.PbFieldType.OD)
    ..a<$core.double>(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'flatFee', $pb.PbFieldType.OD)
    ..aOS(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'source')
    ..aOS(18, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..aOS(19, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerName')
    ..aOS(20, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paidAt')
    ..aOS(21, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt')
    ..hasRequiredFields = false
  ;

  AdminSellSettlement._() : super();
  factory AdminSellSettlement({
    $core.String? id,
    $core.String? reference,
    $core.String? userId,
    $core.String? brand,
    $core.double? faceValue,
    $core.String? faceCurrency,
    $core.String? payoutCurrency,
    $core.double? fxRate,
    $core.double? preMarginPayout,
    $core.double? paidToUser,
    $core.double? saleProceeds,
    $core.String? saleProceedsCurrency,
    $core.double? totalRevenue,
    $core.String? totalRevenueCurrency,
    $core.double? marginPercentage,
    $core.double? flatFee,
    $core.String? source,
    $core.String? status,
    $core.String? providerName,
    $core.String? paidAt,
    $core.String? createdAt,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (reference != null) {
      _result.reference = reference;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (brand != null) {
      _result.brand = brand;
    }
    if (faceValue != null) {
      _result.faceValue = faceValue;
    }
    if (faceCurrency != null) {
      _result.faceCurrency = faceCurrency;
    }
    if (payoutCurrency != null) {
      _result.payoutCurrency = payoutCurrency;
    }
    if (fxRate != null) {
      _result.fxRate = fxRate;
    }
    if (preMarginPayout != null) {
      _result.preMarginPayout = preMarginPayout;
    }
    if (paidToUser != null) {
      _result.paidToUser = paidToUser;
    }
    if (saleProceeds != null) {
      _result.saleProceeds = saleProceeds;
    }
    if (saleProceedsCurrency != null) {
      _result.saleProceedsCurrency = saleProceedsCurrency;
    }
    if (totalRevenue != null) {
      _result.totalRevenue = totalRevenue;
    }
    if (totalRevenueCurrency != null) {
      _result.totalRevenueCurrency = totalRevenueCurrency;
    }
    if (marginPercentage != null) {
      _result.marginPercentage = marginPercentage;
    }
    if (flatFee != null) {
      _result.flatFee = flatFee;
    }
    if (source != null) {
      _result.source = source;
    }
    if (status != null) {
      _result.status = status;
    }
    if (providerName != null) {
      _result.providerName = providerName;
    }
    if (paidAt != null) {
      _result.paidAt = paidAt;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    return _result;
  }
  factory AdminSellSettlement.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AdminSellSettlement.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AdminSellSettlement clone() => AdminSellSettlement()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AdminSellSettlement copyWith(void Function(AdminSellSettlement) updates) => super.copyWith((message) => updates(message as AdminSellSettlement)) as AdminSellSettlement; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AdminSellSettlement create() => AdminSellSettlement._();
  AdminSellSettlement createEmptyInstance() => create();
  static $pb.PbList<AdminSellSettlement> createRepeated() => $pb.PbList<AdminSellSettlement>();
  @$core.pragma('dart2js:noInline')
  static AdminSellSettlement getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminSellSettlement>(create);
  static AdminSellSettlement? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get reference => $_getSZ(1);
  @$pb.TagNumber(2)
  set reference($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasReference() => $_has(1);
  @$pb.TagNumber(2)
  void clearReference() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get userId => $_getSZ(2);
  @$pb.TagNumber(3)
  set userId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasUserId() => $_has(2);
  @$pb.TagNumber(3)
  void clearUserId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get brand => $_getSZ(3);
  @$pb.TagNumber(4)
  set brand($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasBrand() => $_has(3);
  @$pb.TagNumber(4)
  void clearBrand() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get faceValue => $_getN(4);
  @$pb.TagNumber(5)
  set faceValue($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasFaceValue() => $_has(4);
  @$pb.TagNumber(5)
  void clearFaceValue() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get faceCurrency => $_getSZ(5);
  @$pb.TagNumber(6)
  set faceCurrency($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasFaceCurrency() => $_has(5);
  @$pb.TagNumber(6)
  void clearFaceCurrency() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get payoutCurrency => $_getSZ(6);
  @$pb.TagNumber(7)
  set payoutCurrency($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasPayoutCurrency() => $_has(6);
  @$pb.TagNumber(7)
  void clearPayoutCurrency() => clearField(7);

  @$pb.TagNumber(8)
  $core.double get fxRate => $_getN(7);
  @$pb.TagNumber(8)
  set fxRate($core.double v) { $_setDouble(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasFxRate() => $_has(7);
  @$pb.TagNumber(8)
  void clearFxRate() => clearField(8);

  @$pb.TagNumber(9)
  $core.double get preMarginPayout => $_getN(8);
  @$pb.TagNumber(9)
  set preMarginPayout($core.double v) { $_setDouble(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasPreMarginPayout() => $_has(8);
  @$pb.TagNumber(9)
  void clearPreMarginPayout() => clearField(9);

  @$pb.TagNumber(10)
  $core.double get paidToUser => $_getN(9);
  @$pb.TagNumber(10)
  set paidToUser($core.double v) { $_setDouble(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasPaidToUser() => $_has(9);
  @$pb.TagNumber(10)
  void clearPaidToUser() => clearField(10);

  @$pb.TagNumber(11)
  $core.double get saleProceeds => $_getN(10);
  @$pb.TagNumber(11)
  set saleProceeds($core.double v) { $_setDouble(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasSaleProceeds() => $_has(10);
  @$pb.TagNumber(11)
  void clearSaleProceeds() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get saleProceedsCurrency => $_getSZ(11);
  @$pb.TagNumber(12)
  set saleProceedsCurrency($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasSaleProceedsCurrency() => $_has(11);
  @$pb.TagNumber(12)
  void clearSaleProceedsCurrency() => clearField(12);

  @$pb.TagNumber(13)
  $core.double get totalRevenue => $_getN(12);
  @$pb.TagNumber(13)
  set totalRevenue($core.double v) { $_setDouble(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasTotalRevenue() => $_has(12);
  @$pb.TagNumber(13)
  void clearTotalRevenue() => clearField(13);

  @$pb.TagNumber(14)
  $core.String get totalRevenueCurrency => $_getSZ(13);
  @$pb.TagNumber(14)
  set totalRevenueCurrency($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasTotalRevenueCurrency() => $_has(13);
  @$pb.TagNumber(14)
  void clearTotalRevenueCurrency() => clearField(14);

  @$pb.TagNumber(15)
  $core.double get marginPercentage => $_getN(14);
  @$pb.TagNumber(15)
  set marginPercentage($core.double v) { $_setDouble(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasMarginPercentage() => $_has(14);
  @$pb.TagNumber(15)
  void clearMarginPercentage() => clearField(15);

  @$pb.TagNumber(16)
  $core.double get flatFee => $_getN(15);
  @$pb.TagNumber(16)
  set flatFee($core.double v) { $_setDouble(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasFlatFee() => $_has(15);
  @$pb.TagNumber(16)
  void clearFlatFee() => clearField(16);

  @$pb.TagNumber(17)
  $core.String get source => $_getSZ(16);
  @$pb.TagNumber(17)
  set source($core.String v) { $_setString(16, v); }
  @$pb.TagNumber(17)
  $core.bool hasSource() => $_has(16);
  @$pb.TagNumber(17)
  void clearSource() => clearField(17);

  @$pb.TagNumber(18)
  $core.String get status => $_getSZ(17);
  @$pb.TagNumber(18)
  set status($core.String v) { $_setString(17, v); }
  @$pb.TagNumber(18)
  $core.bool hasStatus() => $_has(17);
  @$pb.TagNumber(18)
  void clearStatus() => clearField(18);

  @$pb.TagNumber(19)
  $core.String get providerName => $_getSZ(18);
  @$pb.TagNumber(19)
  set providerName($core.String v) { $_setString(18, v); }
  @$pb.TagNumber(19)
  $core.bool hasProviderName() => $_has(18);
  @$pb.TagNumber(19)
  void clearProviderName() => clearField(19);

  @$pb.TagNumber(20)
  $core.String get paidAt => $_getSZ(19);
  @$pb.TagNumber(20)
  set paidAt($core.String v) { $_setString(19, v); }
  @$pb.TagNumber(20)
  $core.bool hasPaidAt() => $_has(19);
  @$pb.TagNumber(20)
  void clearPaidAt() => clearField(20);

  @$pb.TagNumber(21)
  $core.String get createdAt => $_getSZ(20);
  @$pb.TagNumber(21)
  set createdAt($core.String v) { $_setString(20, v); }
  @$pb.TagNumber(21)
  $core.bool hasCreatedAt() => $_has(20);
  @$pb.TagNumber(21)
  void clearCreatedAt() => clearField(21);
}

class AdminListSellSettlementsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AdminListSellSettlementsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..pc<AdminSellSettlement>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'settlements', $pb.PbFieldType.PM, subBuilder: AdminSellSettlement.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'total', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  AdminListSellSettlementsResponse._() : super();
  factory AdminListSellSettlementsResponse({
    $core.Iterable<AdminSellSettlement>? settlements,
    $core.int? total,
    $core.int? page,
    $core.int? limit,
  }) {
    final _result = create();
    if (settlements != null) {
      _result.settlements.addAll(settlements);
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
  factory AdminListSellSettlementsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AdminListSellSettlementsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AdminListSellSettlementsResponse clone() => AdminListSellSettlementsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AdminListSellSettlementsResponse copyWith(void Function(AdminListSellSettlementsResponse) updates) => super.copyWith((message) => updates(message as AdminListSellSettlementsResponse)) as AdminListSellSettlementsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AdminListSellSettlementsResponse create() => AdminListSellSettlementsResponse._();
  AdminListSellSettlementsResponse createEmptyInstance() => create();
  static $pb.PbList<AdminListSellSettlementsResponse> createRepeated() => $pb.PbList<AdminListSellSettlementsResponse>();
  @$core.pragma('dart2js:noInline')
  static AdminListSellSettlementsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminListSellSettlementsResponse>(create);
  static AdminListSellSettlementsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<AdminSellSettlement> get settlements => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int v) { $_setSignedInt32(1, v); }
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

class AdminListBuyTransactionsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AdminListBuyTransactionsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'search')
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  AdminListBuyTransactionsRequest._() : super();
  factory AdminListBuyTransactionsRequest({
    $core.String? status,
    $core.String? search,
    $core.int? page,
    $core.int? limit,
  }) {
    final _result = create();
    if (status != null) {
      _result.status = status;
    }
    if (search != null) {
      _result.search = search;
    }
    if (page != null) {
      _result.page = page;
    }
    if (limit != null) {
      _result.limit = limit;
    }
    return _result;
  }
  factory AdminListBuyTransactionsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AdminListBuyTransactionsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AdminListBuyTransactionsRequest clone() => AdminListBuyTransactionsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AdminListBuyTransactionsRequest copyWith(void Function(AdminListBuyTransactionsRequest) updates) => super.copyWith((message) => updates(message as AdminListBuyTransactionsRequest)) as AdminListBuyTransactionsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AdminListBuyTransactionsRequest create() => AdminListBuyTransactionsRequest._();
  AdminListBuyTransactionsRequest createEmptyInstance() => create();
  static $pb.PbList<AdminListBuyTransactionsRequest> createRepeated() => $pb.PbList<AdminListBuyTransactionsRequest>();
  @$core.pragma('dart2js:noInline')
  static AdminListBuyTransactionsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminListBuyTransactionsRequest>(create);
  static AdminListBuyTransactionsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get status => $_getSZ(0);
  @$pb.TagNumber(1)
  set status($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get search => $_getSZ(1);
  @$pb.TagNumber(2)
  set search($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSearch() => $_has(1);
  @$pb.TagNumber(2)
  void clearSearch() => clearField(2);

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

class AdminBuyTransaction extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AdminBuyTransaction', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'brandName')
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'originalAmount', $pb.PbFieldType.OD)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'idempotencyKey')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedAt')
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recipientEmail')
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recipientName')
    ..aOS(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reference')
    ..a<$core.double>(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'retailAmount', $pb.PbFieldType.OD)
    ..aOS(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'retailCurrency')
    ..a<$core.double>(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'wholesaleAmount', $pb.PbFieldType.OD)
    ..aOS(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'wholesaleCurrency')
    ..a<$core.double>(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'commissionAmount', $pb.PbFieldType.OD)
    ..aOS(18, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'commissionCurrency')
    ..a<$core.double>(19, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'senderAmount', $pb.PbFieldType.OD)
    ..aOS(20, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'senderCurrency')
    ..a<$core.double>(21, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fxRate', $pb.PbFieldType.OD)
    ..a<$core.double>(22, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'feePercentage', $pb.PbFieldType.OD)
    ..aOS(23, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'completedAt')
    ..aOS(24, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerName')
    ..aOS(25, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'failureReason')
    ..aOS(26, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'redemptionCode')
    ..aOS(27, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'redemptionPin')
    ..aOS(28, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerTransactionId')
    ..aOS(29, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'mode')
    ..aOB(30, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hasRefundEntry')
    ..aOS(31, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'requestJson')
    ..aOS(32, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'responseJson')
    ..a<$core.int>(33, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerHttpStatus', $pb.PbFieldType.O3)
    ..aInt64(34, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerDurationMs')
    ..aOS(35, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'refundState')
    ..aOS(36, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'refundSource')
    ..aOS(37, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'refundReason')
    ..aOS(38, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'finalGateway')
    ..aOS(39, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'source')
    ..aOS(40, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'failover')
    ..a<$core.double>(41, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'flatFee', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  AdminBuyTransaction._() : super();
  factory AdminBuyTransaction({
    $core.String? id,
    $core.String? userId,
    $core.String? brandName,
    $core.double? originalAmount,
    $core.String? currency,
    $core.String? status,
    $core.String? idempotencyKey,
    $core.String? createdAt,
    $core.String? updatedAt,
    $core.String? recipientEmail,
    $core.String? recipientName,
    $core.String? reference,
    $core.double? retailAmount,
    $core.String? retailCurrency,
    $core.double? wholesaleAmount,
    $core.String? wholesaleCurrency,
    $core.double? commissionAmount,
    $core.String? commissionCurrency,
    $core.double? senderAmount,
    $core.String? senderCurrency,
    $core.double? fxRate,
    $core.double? feePercentage,
    $core.String? completedAt,
    $core.String? providerName,
    $core.String? failureReason,
    $core.String? redemptionCode,
    $core.String? redemptionPin,
    $core.String? providerTransactionId,
    $core.String? mode,
    $core.bool? hasRefundEntry,
    $core.String? requestJson,
    $core.String? responseJson,
    $core.int? providerHttpStatus,
    $fixnum.Int64? providerDurationMs,
    $core.String? refundState,
    $core.String? refundSource,
    $core.String? refundReason,
    $core.String? finalGateway,
    $core.String? source,
    $core.String? failover,
    $core.double? flatFee,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (userId != null) {
      _result.userId = userId;
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
    if (idempotencyKey != null) {
      _result.idempotencyKey = idempotencyKey;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      _result.updatedAt = updatedAt;
    }
    if (recipientEmail != null) {
      _result.recipientEmail = recipientEmail;
    }
    if (recipientName != null) {
      _result.recipientName = recipientName;
    }
    if (reference != null) {
      _result.reference = reference;
    }
    if (retailAmount != null) {
      _result.retailAmount = retailAmount;
    }
    if (retailCurrency != null) {
      _result.retailCurrency = retailCurrency;
    }
    if (wholesaleAmount != null) {
      _result.wholesaleAmount = wholesaleAmount;
    }
    if (wholesaleCurrency != null) {
      _result.wholesaleCurrency = wholesaleCurrency;
    }
    if (commissionAmount != null) {
      _result.commissionAmount = commissionAmount;
    }
    if (commissionCurrency != null) {
      _result.commissionCurrency = commissionCurrency;
    }
    if (senderAmount != null) {
      _result.senderAmount = senderAmount;
    }
    if (senderCurrency != null) {
      _result.senderCurrency = senderCurrency;
    }
    if (fxRate != null) {
      _result.fxRate = fxRate;
    }
    if (feePercentage != null) {
      _result.feePercentage = feePercentage;
    }
    if (completedAt != null) {
      _result.completedAt = completedAt;
    }
    if (providerName != null) {
      _result.providerName = providerName;
    }
    if (failureReason != null) {
      _result.failureReason = failureReason;
    }
    if (redemptionCode != null) {
      _result.redemptionCode = redemptionCode;
    }
    if (redemptionPin != null) {
      _result.redemptionPin = redemptionPin;
    }
    if (providerTransactionId != null) {
      _result.providerTransactionId = providerTransactionId;
    }
    if (mode != null) {
      _result.mode = mode;
    }
    if (hasRefundEntry != null) {
      _result.hasRefundEntry = hasRefundEntry;
    }
    if (requestJson != null) {
      _result.requestJson = requestJson;
    }
    if (responseJson != null) {
      _result.responseJson = responseJson;
    }
    if (providerHttpStatus != null) {
      _result.providerHttpStatus = providerHttpStatus;
    }
    if (providerDurationMs != null) {
      _result.providerDurationMs = providerDurationMs;
    }
    if (refundState != null) {
      _result.refundState = refundState;
    }
    if (refundSource != null) {
      _result.refundSource = refundSource;
    }
    if (refundReason != null) {
      _result.refundReason = refundReason;
    }
    if (finalGateway != null) {
      _result.finalGateway = finalGateway;
    }
    if (source != null) {
      _result.source = source;
    }
    if (failover != null) {
      _result.failover = failover;
    }
    if (flatFee != null) {
      _result.flatFee = flatFee;
    }
    return _result;
  }
  factory AdminBuyTransaction.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AdminBuyTransaction.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AdminBuyTransaction clone() => AdminBuyTransaction()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AdminBuyTransaction copyWith(void Function(AdminBuyTransaction) updates) => super.copyWith((message) => updates(message as AdminBuyTransaction)) as AdminBuyTransaction; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AdminBuyTransaction create() => AdminBuyTransaction._();
  AdminBuyTransaction createEmptyInstance() => create();
  static $pb.PbList<AdminBuyTransaction> createRepeated() => $pb.PbList<AdminBuyTransaction>();
  @$core.pragma('dart2js:noInline')
  static AdminBuyTransaction getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminBuyTransaction>(create);
  static AdminBuyTransaction? _defaultInstance;

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
  $core.String get brandName => $_getSZ(2);
  @$pb.TagNumber(3)
  set brandName($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasBrandName() => $_has(2);
  @$pb.TagNumber(3)
  void clearBrandName() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get originalAmount => $_getN(3);
  @$pb.TagNumber(4)
  set originalAmount($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasOriginalAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearOriginalAmount() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get currency => $_getSZ(4);
  @$pb.TagNumber(5)
  set currency($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasCurrency() => $_has(4);
  @$pb.TagNumber(5)
  void clearCurrency() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get status => $_getSZ(5);
  @$pb.TagNumber(6)
  set status($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasStatus() => $_has(5);
  @$pb.TagNumber(6)
  void clearStatus() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get idempotencyKey => $_getSZ(6);
  @$pb.TagNumber(7)
  set idempotencyKey($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasIdempotencyKey() => $_has(6);
  @$pb.TagNumber(7)
  void clearIdempotencyKey() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get createdAt => $_getSZ(7);
  @$pb.TagNumber(8)
  set createdAt($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasCreatedAt() => $_has(7);
  @$pb.TagNumber(8)
  void clearCreatedAt() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get updatedAt => $_getSZ(8);
  @$pb.TagNumber(9)
  set updatedAt($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasUpdatedAt() => $_has(8);
  @$pb.TagNumber(9)
  void clearUpdatedAt() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get recipientEmail => $_getSZ(9);
  @$pb.TagNumber(10)
  set recipientEmail($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasRecipientEmail() => $_has(9);
  @$pb.TagNumber(10)
  void clearRecipientEmail() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get recipientName => $_getSZ(10);
  @$pb.TagNumber(11)
  set recipientName($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasRecipientName() => $_has(10);
  @$pb.TagNumber(11)
  void clearRecipientName() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get reference => $_getSZ(11);
  @$pb.TagNumber(12)
  set reference($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasReference() => $_has(11);
  @$pb.TagNumber(12)
  void clearReference() => clearField(12);

  @$pb.TagNumber(13)
  $core.double get retailAmount => $_getN(12);
  @$pb.TagNumber(13)
  set retailAmount($core.double v) { $_setDouble(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasRetailAmount() => $_has(12);
  @$pb.TagNumber(13)
  void clearRetailAmount() => clearField(13);

  @$pb.TagNumber(14)
  $core.String get retailCurrency => $_getSZ(13);
  @$pb.TagNumber(14)
  set retailCurrency($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasRetailCurrency() => $_has(13);
  @$pb.TagNumber(14)
  void clearRetailCurrency() => clearField(14);

  @$pb.TagNumber(15)
  $core.double get wholesaleAmount => $_getN(14);
  @$pb.TagNumber(15)
  set wholesaleAmount($core.double v) { $_setDouble(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasWholesaleAmount() => $_has(14);
  @$pb.TagNumber(15)
  void clearWholesaleAmount() => clearField(15);

  @$pb.TagNumber(16)
  $core.String get wholesaleCurrency => $_getSZ(15);
  @$pb.TagNumber(16)
  set wholesaleCurrency($core.String v) { $_setString(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasWholesaleCurrency() => $_has(15);
  @$pb.TagNumber(16)
  void clearWholesaleCurrency() => clearField(16);

  @$pb.TagNumber(17)
  $core.double get commissionAmount => $_getN(16);
  @$pb.TagNumber(17)
  set commissionAmount($core.double v) { $_setDouble(16, v); }
  @$pb.TagNumber(17)
  $core.bool hasCommissionAmount() => $_has(16);
  @$pb.TagNumber(17)
  void clearCommissionAmount() => clearField(17);

  @$pb.TagNumber(18)
  $core.String get commissionCurrency => $_getSZ(17);
  @$pb.TagNumber(18)
  set commissionCurrency($core.String v) { $_setString(17, v); }
  @$pb.TagNumber(18)
  $core.bool hasCommissionCurrency() => $_has(17);
  @$pb.TagNumber(18)
  void clearCommissionCurrency() => clearField(18);

  @$pb.TagNumber(19)
  $core.double get senderAmount => $_getN(18);
  @$pb.TagNumber(19)
  set senderAmount($core.double v) { $_setDouble(18, v); }
  @$pb.TagNumber(19)
  $core.bool hasSenderAmount() => $_has(18);
  @$pb.TagNumber(19)
  void clearSenderAmount() => clearField(19);

  @$pb.TagNumber(20)
  $core.String get senderCurrency => $_getSZ(19);
  @$pb.TagNumber(20)
  set senderCurrency($core.String v) { $_setString(19, v); }
  @$pb.TagNumber(20)
  $core.bool hasSenderCurrency() => $_has(19);
  @$pb.TagNumber(20)
  void clearSenderCurrency() => clearField(20);

  @$pb.TagNumber(21)
  $core.double get fxRate => $_getN(20);
  @$pb.TagNumber(21)
  set fxRate($core.double v) { $_setDouble(20, v); }
  @$pb.TagNumber(21)
  $core.bool hasFxRate() => $_has(20);
  @$pb.TagNumber(21)
  void clearFxRate() => clearField(21);

  @$pb.TagNumber(22)
  $core.double get feePercentage => $_getN(21);
  @$pb.TagNumber(22)
  set feePercentage($core.double v) { $_setDouble(21, v); }
  @$pb.TagNumber(22)
  $core.bool hasFeePercentage() => $_has(21);
  @$pb.TagNumber(22)
  void clearFeePercentage() => clearField(22);

  @$pb.TagNumber(23)
  $core.String get completedAt => $_getSZ(22);
  @$pb.TagNumber(23)
  set completedAt($core.String v) { $_setString(22, v); }
  @$pb.TagNumber(23)
  $core.bool hasCompletedAt() => $_has(22);
  @$pb.TagNumber(23)
  void clearCompletedAt() => clearField(23);

  @$pb.TagNumber(24)
  $core.String get providerName => $_getSZ(23);
  @$pb.TagNumber(24)
  set providerName($core.String v) { $_setString(23, v); }
  @$pb.TagNumber(24)
  $core.bool hasProviderName() => $_has(23);
  @$pb.TagNumber(24)
  void clearProviderName() => clearField(24);

  @$pb.TagNumber(25)
  $core.String get failureReason => $_getSZ(24);
  @$pb.TagNumber(25)
  set failureReason($core.String v) { $_setString(24, v); }
  @$pb.TagNumber(25)
  $core.bool hasFailureReason() => $_has(24);
  @$pb.TagNumber(25)
  void clearFailureReason() => clearField(25);

  @$pb.TagNumber(26)
  $core.String get redemptionCode => $_getSZ(25);
  @$pb.TagNumber(26)
  set redemptionCode($core.String v) { $_setString(25, v); }
  @$pb.TagNumber(26)
  $core.bool hasRedemptionCode() => $_has(25);
  @$pb.TagNumber(26)
  void clearRedemptionCode() => clearField(26);

  @$pb.TagNumber(27)
  $core.String get redemptionPin => $_getSZ(26);
  @$pb.TagNumber(27)
  set redemptionPin($core.String v) { $_setString(26, v); }
  @$pb.TagNumber(27)
  $core.bool hasRedemptionPin() => $_has(26);
  @$pb.TagNumber(27)
  void clearRedemptionPin() => clearField(27);

  @$pb.TagNumber(28)
  $core.String get providerTransactionId => $_getSZ(27);
  @$pb.TagNumber(28)
  set providerTransactionId($core.String v) { $_setString(27, v); }
  @$pb.TagNumber(28)
  $core.bool hasProviderTransactionId() => $_has(27);
  @$pb.TagNumber(28)
  void clearProviderTransactionId() => clearField(28);

  @$pb.TagNumber(29)
  $core.String get mode => $_getSZ(28);
  @$pb.TagNumber(29)
  set mode($core.String v) { $_setString(28, v); }
  @$pb.TagNumber(29)
  $core.bool hasMode() => $_has(28);
  @$pb.TagNumber(29)
  void clearMode() => clearField(29);

  @$pb.TagNumber(30)
  $core.bool get hasRefundEntry => $_getBF(29);
  @$pb.TagNumber(30)
  set hasRefundEntry($core.bool v) { $_setBool(29, v); }
  @$pb.TagNumber(30)
  $core.bool hasHasRefundEntry() => $_has(29);
  @$pb.TagNumber(30)
  void clearHasRefundEntry() => clearField(30);

  @$pb.TagNumber(31)
  $core.String get requestJson => $_getSZ(30);
  @$pb.TagNumber(31)
  set requestJson($core.String v) { $_setString(30, v); }
  @$pb.TagNumber(31)
  $core.bool hasRequestJson() => $_has(30);
  @$pb.TagNumber(31)
  void clearRequestJson() => clearField(31);

  @$pb.TagNumber(32)
  $core.String get responseJson => $_getSZ(31);
  @$pb.TagNumber(32)
  set responseJson($core.String v) { $_setString(31, v); }
  @$pb.TagNumber(32)
  $core.bool hasResponseJson() => $_has(31);
  @$pb.TagNumber(32)
  void clearResponseJson() => clearField(32);

  @$pb.TagNumber(33)
  $core.int get providerHttpStatus => $_getIZ(32);
  @$pb.TagNumber(33)
  set providerHttpStatus($core.int v) { $_setSignedInt32(32, v); }
  @$pb.TagNumber(33)
  $core.bool hasProviderHttpStatus() => $_has(32);
  @$pb.TagNumber(33)
  void clearProviderHttpStatus() => clearField(33);

  @$pb.TagNumber(34)
  $fixnum.Int64 get providerDurationMs => $_getI64(33);
  @$pb.TagNumber(34)
  set providerDurationMs($fixnum.Int64 v) { $_setInt64(33, v); }
  @$pb.TagNumber(34)
  $core.bool hasProviderDurationMs() => $_has(33);
  @$pb.TagNumber(34)
  void clearProviderDurationMs() => clearField(34);

  @$pb.TagNumber(35)
  $core.String get refundState => $_getSZ(34);
  @$pb.TagNumber(35)
  set refundState($core.String v) { $_setString(34, v); }
  @$pb.TagNumber(35)
  $core.bool hasRefundState() => $_has(34);
  @$pb.TagNumber(35)
  void clearRefundState() => clearField(35);

  @$pb.TagNumber(36)
  $core.String get refundSource => $_getSZ(35);
  @$pb.TagNumber(36)
  set refundSource($core.String v) { $_setString(35, v); }
  @$pb.TagNumber(36)
  $core.bool hasRefundSource() => $_has(35);
  @$pb.TagNumber(36)
  void clearRefundSource() => clearField(36);

  @$pb.TagNumber(37)
  $core.String get refundReason => $_getSZ(36);
  @$pb.TagNumber(37)
  set refundReason($core.String v) { $_setString(36, v); }
  @$pb.TagNumber(37)
  $core.bool hasRefundReason() => $_has(36);
  @$pb.TagNumber(37)
  void clearRefundReason() => clearField(37);

  @$pb.TagNumber(38)
  $core.String get finalGateway => $_getSZ(37);
  @$pb.TagNumber(38)
  set finalGateway($core.String v) { $_setString(37, v); }
  @$pb.TagNumber(38)
  $core.bool hasFinalGateway() => $_has(37);
  @$pb.TagNumber(38)
  void clearFinalGateway() => clearField(38);

  @$pb.TagNumber(39)
  $core.String get source => $_getSZ(38);
  @$pb.TagNumber(39)
  set source($core.String v) { $_setString(38, v); }
  @$pb.TagNumber(39)
  $core.bool hasSource() => $_has(38);
  @$pb.TagNumber(39)
  void clearSource() => clearField(39);

  @$pb.TagNumber(40)
  $core.String get failover => $_getSZ(39);
  @$pb.TagNumber(40)
  set failover($core.String v) { $_setString(39, v); }
  @$pb.TagNumber(40)
  $core.bool hasFailover() => $_has(39);
  @$pb.TagNumber(40)
  void clearFailover() => clearField(40);

  @$pb.TagNumber(41)
  $core.double get flatFee => $_getN(40);
  @$pb.TagNumber(41)
  set flatFee($core.double v) { $_setDouble(40, v); }
  @$pb.TagNumber(41)
  $core.bool hasFlatFee() => $_has(40);
  @$pb.TagNumber(41)
  void clearFlatFee() => clearField(41);
}

class AdminListBuyTransactionsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AdminListBuyTransactionsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..pc<AdminBuyTransaction>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactions', $pb.PbFieldType.PM, subBuilder: AdminBuyTransaction.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'total', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  AdminListBuyTransactionsResponse._() : super();
  factory AdminListBuyTransactionsResponse({
    $core.Iterable<AdminBuyTransaction>? transactions,
    $core.int? total,
    $core.int? page,
    $core.int? limit,
  }) {
    final _result = create();
    if (transactions != null) {
      _result.transactions.addAll(transactions);
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
  factory AdminListBuyTransactionsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AdminListBuyTransactionsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AdminListBuyTransactionsResponse clone() => AdminListBuyTransactionsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AdminListBuyTransactionsResponse copyWith(void Function(AdminListBuyTransactionsResponse) updates) => super.copyWith((message) => updates(message as AdminListBuyTransactionsResponse)) as AdminListBuyTransactionsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AdminListBuyTransactionsResponse create() => AdminListBuyTransactionsResponse._();
  AdminListBuyTransactionsResponse createEmptyInstance() => create();
  static $pb.PbList<AdminListBuyTransactionsResponse> createRepeated() => $pb.PbList<AdminListBuyTransactionsResponse>();
  @$core.pragma('dart2js:noInline')
  static AdminListBuyTransactionsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminListBuyTransactionsResponse>(create);
  static AdminListBuyTransactionsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<AdminBuyTransaction> get transactions => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int v) { $_setSignedInt32(1, v); }
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

class AdminListRefundLedgerRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AdminListRefundLedgerRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'side')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  AdminListRefundLedgerRequest._() : super();
  factory AdminListRefundLedgerRequest({
    $core.String? side,
    $core.String? status,
    $core.int? page,
    $core.int? limit,
  }) {
    final _result = create();
    if (side != null) {
      _result.side = side;
    }
    if (status != null) {
      _result.status = status;
    }
    if (page != null) {
      _result.page = page;
    }
    if (limit != null) {
      _result.limit = limit;
    }
    return _result;
  }
  factory AdminListRefundLedgerRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AdminListRefundLedgerRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AdminListRefundLedgerRequest clone() => AdminListRefundLedgerRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AdminListRefundLedgerRequest copyWith(void Function(AdminListRefundLedgerRequest) updates) => super.copyWith((message) => updates(message as AdminListRefundLedgerRequest)) as AdminListRefundLedgerRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AdminListRefundLedgerRequest create() => AdminListRefundLedgerRequest._();
  AdminListRefundLedgerRequest createEmptyInstance() => create();
  static $pb.PbList<AdminListRefundLedgerRequest> createRepeated() => $pb.PbList<AdminListRefundLedgerRequest>();
  @$core.pragma('dart2js:noInline')
  static AdminListRefundLedgerRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminListRefundLedgerRequest>(create);
  static AdminListRefundLedgerRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get side => $_getSZ(0);
  @$pb.TagNumber(1)
  set side($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSide() => $_has(0);
  @$pb.TagNumber(1)
  void clearSide() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get status => $_getSZ(1);
  @$pb.TagNumber(2)
  set status($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => clearField(2);

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

class AdminRefundLedgerEntry extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AdminRefundLedgerEntry', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'originalReference')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'refundReference')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accountId')
    ..a<$core.double>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'direction')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reason')
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'confirmationStatus')
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'settlementStatus')
    ..aOS(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerTransactionId')
    ..aOS(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerStatus')
    ..aOS(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'notes')
    ..aOS(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'executedAt')
    ..aOS(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'confirmedAt')
    ..aOS(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'escalatedAt')
    ..a<$core.int>(18, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'verificationAttempts', $pb.PbFieldType.O3)
    ..a<$core.int>(19, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'maxVerificationRetries', $pb.PbFieldType.O3)
    ..aOS(20, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt')
    ..aOS(21, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedAt')
    ..aOS(22, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'side')
    ..aOS(23, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'source')
    ..hasRequiredFields = false
  ;

  AdminRefundLedgerEntry._() : super();
  factory AdminRefundLedgerEntry({
    $core.String? id,
    $core.String? originalReference,
    $core.String? refundReference,
    $core.String? userId,
    $core.String? accountId,
    $core.double? amount,
    $core.String? currency,
    $core.String? direction,
    $core.String? reason,
    $core.String? confirmationStatus,
    $core.String? settlementStatus,
    $core.String? providerTransactionId,
    $core.String? providerStatus,
    $core.String? notes,
    $core.String? executedAt,
    $core.String? confirmedAt,
    $core.String? escalatedAt,
    $core.int? verificationAttempts,
    $core.int? maxVerificationRetries,
    $core.String? createdAt,
    $core.String? updatedAt,
    $core.String? side,
    $core.String? source,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (originalReference != null) {
      _result.originalReference = originalReference;
    }
    if (refundReference != null) {
      _result.refundReference = refundReference;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (accountId != null) {
      _result.accountId = accountId;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (direction != null) {
      _result.direction = direction;
    }
    if (reason != null) {
      _result.reason = reason;
    }
    if (confirmationStatus != null) {
      _result.confirmationStatus = confirmationStatus;
    }
    if (settlementStatus != null) {
      _result.settlementStatus = settlementStatus;
    }
    if (providerTransactionId != null) {
      _result.providerTransactionId = providerTransactionId;
    }
    if (providerStatus != null) {
      _result.providerStatus = providerStatus;
    }
    if (notes != null) {
      _result.notes = notes;
    }
    if (executedAt != null) {
      _result.executedAt = executedAt;
    }
    if (confirmedAt != null) {
      _result.confirmedAt = confirmedAt;
    }
    if (escalatedAt != null) {
      _result.escalatedAt = escalatedAt;
    }
    if (verificationAttempts != null) {
      _result.verificationAttempts = verificationAttempts;
    }
    if (maxVerificationRetries != null) {
      _result.maxVerificationRetries = maxVerificationRetries;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      _result.updatedAt = updatedAt;
    }
    if (side != null) {
      _result.side = side;
    }
    if (source != null) {
      _result.source = source;
    }
    return _result;
  }
  factory AdminRefundLedgerEntry.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AdminRefundLedgerEntry.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AdminRefundLedgerEntry clone() => AdminRefundLedgerEntry()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AdminRefundLedgerEntry copyWith(void Function(AdminRefundLedgerEntry) updates) => super.copyWith((message) => updates(message as AdminRefundLedgerEntry)) as AdminRefundLedgerEntry; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AdminRefundLedgerEntry create() => AdminRefundLedgerEntry._();
  AdminRefundLedgerEntry createEmptyInstance() => create();
  static $pb.PbList<AdminRefundLedgerEntry> createRepeated() => $pb.PbList<AdminRefundLedgerEntry>();
  @$core.pragma('dart2js:noInline')
  static AdminRefundLedgerEntry getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminRefundLedgerEntry>(create);
  static AdminRefundLedgerEntry? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get originalReference => $_getSZ(1);
  @$pb.TagNumber(2)
  set originalReference($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasOriginalReference() => $_has(1);
  @$pb.TagNumber(2)
  void clearOriginalReference() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get refundReference => $_getSZ(2);
  @$pb.TagNumber(3)
  set refundReference($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasRefundReference() => $_has(2);
  @$pb.TagNumber(3)
  void clearRefundReference() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get userId => $_getSZ(3);
  @$pb.TagNumber(4)
  set userId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasUserId() => $_has(3);
  @$pb.TagNumber(4)
  void clearUserId() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get accountId => $_getSZ(4);
  @$pb.TagNumber(5)
  set accountId($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasAccountId() => $_has(4);
  @$pb.TagNumber(5)
  void clearAccountId() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get amount => $_getN(5);
  @$pb.TagNumber(6)
  set amount($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasAmount() => $_has(5);
  @$pb.TagNumber(6)
  void clearAmount() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get currency => $_getSZ(6);
  @$pb.TagNumber(7)
  set currency($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasCurrency() => $_has(6);
  @$pb.TagNumber(7)
  void clearCurrency() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get direction => $_getSZ(7);
  @$pb.TagNumber(8)
  set direction($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasDirection() => $_has(7);
  @$pb.TagNumber(8)
  void clearDirection() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get reason => $_getSZ(8);
  @$pb.TagNumber(9)
  set reason($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasReason() => $_has(8);
  @$pb.TagNumber(9)
  void clearReason() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get confirmationStatus => $_getSZ(9);
  @$pb.TagNumber(10)
  set confirmationStatus($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasConfirmationStatus() => $_has(9);
  @$pb.TagNumber(10)
  void clearConfirmationStatus() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get settlementStatus => $_getSZ(10);
  @$pb.TagNumber(11)
  set settlementStatus($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasSettlementStatus() => $_has(10);
  @$pb.TagNumber(11)
  void clearSettlementStatus() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get providerTransactionId => $_getSZ(11);
  @$pb.TagNumber(12)
  set providerTransactionId($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasProviderTransactionId() => $_has(11);
  @$pb.TagNumber(12)
  void clearProviderTransactionId() => clearField(12);

  @$pb.TagNumber(13)
  $core.String get providerStatus => $_getSZ(12);
  @$pb.TagNumber(13)
  set providerStatus($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasProviderStatus() => $_has(12);
  @$pb.TagNumber(13)
  void clearProviderStatus() => clearField(13);

  @$pb.TagNumber(14)
  $core.String get notes => $_getSZ(13);
  @$pb.TagNumber(14)
  set notes($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasNotes() => $_has(13);
  @$pb.TagNumber(14)
  void clearNotes() => clearField(14);

  @$pb.TagNumber(15)
  $core.String get executedAt => $_getSZ(14);
  @$pb.TagNumber(15)
  set executedAt($core.String v) { $_setString(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasExecutedAt() => $_has(14);
  @$pb.TagNumber(15)
  void clearExecutedAt() => clearField(15);

  @$pb.TagNumber(16)
  $core.String get confirmedAt => $_getSZ(15);
  @$pb.TagNumber(16)
  set confirmedAt($core.String v) { $_setString(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasConfirmedAt() => $_has(15);
  @$pb.TagNumber(16)
  void clearConfirmedAt() => clearField(16);

  @$pb.TagNumber(17)
  $core.String get escalatedAt => $_getSZ(16);
  @$pb.TagNumber(17)
  set escalatedAt($core.String v) { $_setString(16, v); }
  @$pb.TagNumber(17)
  $core.bool hasEscalatedAt() => $_has(16);
  @$pb.TagNumber(17)
  void clearEscalatedAt() => clearField(17);

  @$pb.TagNumber(18)
  $core.int get verificationAttempts => $_getIZ(17);
  @$pb.TagNumber(18)
  set verificationAttempts($core.int v) { $_setSignedInt32(17, v); }
  @$pb.TagNumber(18)
  $core.bool hasVerificationAttempts() => $_has(17);
  @$pb.TagNumber(18)
  void clearVerificationAttempts() => clearField(18);

  @$pb.TagNumber(19)
  $core.int get maxVerificationRetries => $_getIZ(18);
  @$pb.TagNumber(19)
  set maxVerificationRetries($core.int v) { $_setSignedInt32(18, v); }
  @$pb.TagNumber(19)
  $core.bool hasMaxVerificationRetries() => $_has(18);
  @$pb.TagNumber(19)
  void clearMaxVerificationRetries() => clearField(19);

  @$pb.TagNumber(20)
  $core.String get createdAt => $_getSZ(19);
  @$pb.TagNumber(20)
  set createdAt($core.String v) { $_setString(19, v); }
  @$pb.TagNumber(20)
  $core.bool hasCreatedAt() => $_has(19);
  @$pb.TagNumber(20)
  void clearCreatedAt() => clearField(20);

  @$pb.TagNumber(21)
  $core.String get updatedAt => $_getSZ(20);
  @$pb.TagNumber(21)
  set updatedAt($core.String v) { $_setString(20, v); }
  @$pb.TagNumber(21)
  $core.bool hasUpdatedAt() => $_has(20);
  @$pb.TagNumber(21)
  void clearUpdatedAt() => clearField(21);

  @$pb.TagNumber(22)
  $core.String get side => $_getSZ(21);
  @$pb.TagNumber(22)
  set side($core.String v) { $_setString(21, v); }
  @$pb.TagNumber(22)
  $core.bool hasSide() => $_has(21);
  @$pb.TagNumber(22)
  void clearSide() => clearField(22);

  @$pb.TagNumber(23)
  $core.String get source => $_getSZ(22);
  @$pb.TagNumber(23)
  set source($core.String v) { $_setString(22, v); }
  @$pb.TagNumber(23)
  $core.bool hasSource() => $_has(22);
  @$pb.TagNumber(23)
  void clearSource() => clearField(23);
}

class AdminListRefundLedgerResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AdminListRefundLedgerResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..pc<AdminRefundLedgerEntry>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'entries', $pb.PbFieldType.PM, subBuilder: AdminRefundLedgerEntry.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'total', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  AdminListRefundLedgerResponse._() : super();
  factory AdminListRefundLedgerResponse({
    $core.Iterable<AdminRefundLedgerEntry>? entries,
    $core.int? total,
    $core.int? page,
    $core.int? limit,
  }) {
    final _result = create();
    if (entries != null) {
      _result.entries.addAll(entries);
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
  factory AdminListRefundLedgerResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AdminListRefundLedgerResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AdminListRefundLedgerResponse clone() => AdminListRefundLedgerResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AdminListRefundLedgerResponse copyWith(void Function(AdminListRefundLedgerResponse) updates) => super.copyWith((message) => updates(message as AdminListRefundLedgerResponse)) as AdminListRefundLedgerResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AdminListRefundLedgerResponse create() => AdminListRefundLedgerResponse._();
  AdminListRefundLedgerResponse createEmptyInstance() => create();
  static $pb.PbList<AdminListRefundLedgerResponse> createRepeated() => $pb.PbList<AdminListRefundLedgerResponse>();
  @$core.pragma('dart2js:noInline')
  static AdminListRefundLedgerResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminListRefundLedgerResponse>(create);
  static AdminListRefundLedgerResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<AdminRefundLedgerEntry> get entries => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int v) { $_setSignedInt32(1, v); }
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

class AdminRetryHoldReleaseRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AdminRetryHoldReleaseRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cardId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'adminId')
    ..hasRequiredFields = false
  ;

  AdminRetryHoldReleaseRequest._() : super();
  factory AdminRetryHoldReleaseRequest({
    $core.String? cardId,
    $core.String? adminId,
  }) {
    final _result = create();
    if (cardId != null) {
      _result.cardId = cardId;
    }
    if (adminId != null) {
      _result.adminId = adminId;
    }
    return _result;
  }
  factory AdminRetryHoldReleaseRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AdminRetryHoldReleaseRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AdminRetryHoldReleaseRequest clone() => AdminRetryHoldReleaseRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AdminRetryHoldReleaseRequest copyWith(void Function(AdminRetryHoldReleaseRequest) updates) => super.copyWith((message) => updates(message as AdminRetryHoldReleaseRequest)) as AdminRetryHoldReleaseRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AdminRetryHoldReleaseRequest create() => AdminRetryHoldReleaseRequest._();
  AdminRetryHoldReleaseRequest createEmptyInstance() => create();
  static $pb.PbList<AdminRetryHoldReleaseRequest> createRepeated() => $pb.PbList<AdminRetryHoldReleaseRequest>();
  @$core.pragma('dart2js:noInline')
  static AdminRetryHoldReleaseRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminRetryHoldReleaseRequest>(create);
  static AdminRetryHoldReleaseRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get cardId => $_getSZ(0);
  @$pb.TagNumber(1)
  set cardId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCardId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCardId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get adminId => $_getSZ(1);
  @$pb.TagNumber(2)
  set adminId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAdminId() => $_has(1);
  @$pb.TagNumber(2)
  void clearAdminId() => clearField(2);
}

class AdminRetryHoldReleaseResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AdminRetryHoldReleaseResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errorMessage')
    ..hasRequiredFields = false
  ;

  AdminRetryHoldReleaseResponse._() : super();
  factory AdminRetryHoldReleaseResponse({
    $core.bool? success,
    $core.String? status,
    $core.String? errorMessage,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (status != null) {
      _result.status = status;
    }
    if (errorMessage != null) {
      _result.errorMessage = errorMessage;
    }
    return _result;
  }
  factory AdminRetryHoldReleaseResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AdminRetryHoldReleaseResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AdminRetryHoldReleaseResponse clone() => AdminRetryHoldReleaseResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AdminRetryHoldReleaseResponse copyWith(void Function(AdminRetryHoldReleaseResponse) updates) => super.copyWith((message) => updates(message as AdminRetryHoldReleaseResponse)) as AdminRetryHoldReleaseResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AdminRetryHoldReleaseResponse create() => AdminRetryHoldReleaseResponse._();
  AdminRetryHoldReleaseResponse createEmptyInstance() => create();
  static $pb.PbList<AdminRetryHoldReleaseResponse> createRepeated() => $pb.PbList<AdminRetryHoldReleaseResponse>();
  @$core.pragma('dart2js:noInline')
  static AdminRetryHoldReleaseResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminRetryHoldReleaseResponse>(create);
  static AdminRetryHoldReleaseResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get status => $_getSZ(1);
  @$pb.TagNumber(2)
  set status($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get errorMessage => $_getSZ(2);
  @$pb.TagNumber(3)
  set errorMessage($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasErrorMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearErrorMessage() => clearField(3);
}

class AdminManualRefundPurchaseRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AdminManualRefundPurchaseRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cardId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'adminId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reason')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'notes')
    ..hasRequiredFields = false
  ;

  AdminManualRefundPurchaseRequest._() : super();
  factory AdminManualRefundPurchaseRequest({
    $core.String? cardId,
    $core.String? adminId,
    $core.String? reason,
    $core.String? notes,
  }) {
    final _result = create();
    if (cardId != null) {
      _result.cardId = cardId;
    }
    if (adminId != null) {
      _result.adminId = adminId;
    }
    if (reason != null) {
      _result.reason = reason;
    }
    if (notes != null) {
      _result.notes = notes;
    }
    return _result;
  }
  factory AdminManualRefundPurchaseRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AdminManualRefundPurchaseRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AdminManualRefundPurchaseRequest clone() => AdminManualRefundPurchaseRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AdminManualRefundPurchaseRequest copyWith(void Function(AdminManualRefundPurchaseRequest) updates) => super.copyWith((message) => updates(message as AdminManualRefundPurchaseRequest)) as AdminManualRefundPurchaseRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AdminManualRefundPurchaseRequest create() => AdminManualRefundPurchaseRequest._();
  AdminManualRefundPurchaseRequest createEmptyInstance() => create();
  static $pb.PbList<AdminManualRefundPurchaseRequest> createRepeated() => $pb.PbList<AdminManualRefundPurchaseRequest>();
  @$core.pragma('dart2js:noInline')
  static AdminManualRefundPurchaseRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminManualRefundPurchaseRequest>(create);
  static AdminManualRefundPurchaseRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get cardId => $_getSZ(0);
  @$pb.TagNumber(1)
  set cardId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCardId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCardId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get adminId => $_getSZ(1);
  @$pb.TagNumber(2)
  set adminId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAdminId() => $_has(1);
  @$pb.TagNumber(2)
  void clearAdminId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get reason => $_getSZ(2);
  @$pb.TagNumber(3)
  set reason($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasReason() => $_has(2);
  @$pb.TagNumber(3)
  void clearReason() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get notes => $_getSZ(3);
  @$pb.TagNumber(4)
  set notes($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasNotes() => $_has(3);
  @$pb.TagNumber(4)
  void clearNotes() => clearField(4);
}

class AdminManualRefundPurchaseResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AdminManualRefundPurchaseResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  AdminManualRefundPurchaseResponse._() : super();
  factory AdminManualRefundPurchaseResponse({
    $core.bool? success,
    $core.String? status,
    $core.String? message,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (status != null) {
      _result.status = status;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory AdminManualRefundPurchaseResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AdminManualRefundPurchaseResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AdminManualRefundPurchaseResponse clone() => AdminManualRefundPurchaseResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AdminManualRefundPurchaseResponse copyWith(void Function(AdminManualRefundPurchaseResponse) updates) => super.copyWith((message) => updates(message as AdminManualRefundPurchaseResponse)) as AdminManualRefundPurchaseResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AdminManualRefundPurchaseResponse create() => AdminManualRefundPurchaseResponse._();
  AdminManualRefundPurchaseResponse createEmptyInstance() => create();
  static $pb.PbList<AdminManualRefundPurchaseResponse> createRepeated() => $pb.PbList<AdminManualRefundPurchaseResponse>();
  @$core.pragma('dart2js:noInline')
  static AdminManualRefundPurchaseResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminManualRefundPurchaseResponse>(create);
  static AdminManualRefundPurchaseResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get status => $_getSZ(1);
  @$pb.TagNumber(2)
  set status($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => clearField(3);
}

class AdminForceReconcilePurchaseRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AdminForceReconcilePurchaseRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cardId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'adminId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reason')
    ..hasRequiredFields = false
  ;

  AdminForceReconcilePurchaseRequest._() : super();
  factory AdminForceReconcilePurchaseRequest({
    $core.String? cardId,
    $core.String? adminId,
    $core.String? reason,
  }) {
    final _result = create();
    if (cardId != null) {
      _result.cardId = cardId;
    }
    if (adminId != null) {
      _result.adminId = adminId;
    }
    if (reason != null) {
      _result.reason = reason;
    }
    return _result;
  }
  factory AdminForceReconcilePurchaseRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AdminForceReconcilePurchaseRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AdminForceReconcilePurchaseRequest clone() => AdminForceReconcilePurchaseRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AdminForceReconcilePurchaseRequest copyWith(void Function(AdminForceReconcilePurchaseRequest) updates) => super.copyWith((message) => updates(message as AdminForceReconcilePurchaseRequest)) as AdminForceReconcilePurchaseRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AdminForceReconcilePurchaseRequest create() => AdminForceReconcilePurchaseRequest._();
  AdminForceReconcilePurchaseRequest createEmptyInstance() => create();
  static $pb.PbList<AdminForceReconcilePurchaseRequest> createRepeated() => $pb.PbList<AdminForceReconcilePurchaseRequest>();
  @$core.pragma('dart2js:noInline')
  static AdminForceReconcilePurchaseRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminForceReconcilePurchaseRequest>(create);
  static AdminForceReconcilePurchaseRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get cardId => $_getSZ(0);
  @$pb.TagNumber(1)
  set cardId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCardId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCardId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get adminId => $_getSZ(1);
  @$pb.TagNumber(2)
  set adminId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAdminId() => $_has(1);
  @$pb.TagNumber(2)
  void clearAdminId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get reason => $_getSZ(2);
  @$pb.TagNumber(3)
  set reason($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasReason() => $_has(2);
  @$pb.TagNumber(3)
  void clearReason() => clearField(3);
}

class AdminForceReconcilePurchaseResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AdminForceReconcilePurchaseResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'action')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  AdminForceReconcilePurchaseResponse._() : super();
  factory AdminForceReconcilePurchaseResponse({
    $core.bool? success,
    $core.String? action,
    $core.String? status,
    $core.String? message,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (action != null) {
      _result.action = action;
    }
    if (status != null) {
      _result.status = status;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory AdminForceReconcilePurchaseResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AdminForceReconcilePurchaseResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AdminForceReconcilePurchaseResponse clone() => AdminForceReconcilePurchaseResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AdminForceReconcilePurchaseResponse copyWith(void Function(AdminForceReconcilePurchaseResponse) updates) => super.copyWith((message) => updates(message as AdminForceReconcilePurchaseResponse)) as AdminForceReconcilePurchaseResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AdminForceReconcilePurchaseResponse create() => AdminForceReconcilePurchaseResponse._();
  AdminForceReconcilePurchaseResponse createEmptyInstance() => create();
  static $pb.PbList<AdminForceReconcilePurchaseResponse> createRepeated() => $pb.PbList<AdminForceReconcilePurchaseResponse>();
  @$core.pragma('dart2js:noInline')
  static AdminForceReconcilePurchaseResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminForceReconcilePurchaseResponse>(create);
  static AdminForceReconcilePurchaseResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get action => $_getSZ(1);
  @$pb.TagNumber(2)
  set action($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAction() => $_has(1);
  @$pb.TagNumber(2)
  void clearAction() => clearField(2);

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

class AdminSetSellPayoutOverrideRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AdminSetSellPayoutOverrideRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'saleId')
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'note')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'adminId')
    ..hasRequiredFields = false
  ;

  AdminSetSellPayoutOverrideRequest._() : super();
  factory AdminSetSellPayoutOverrideRequest({
    $core.String? saleId,
    $core.double? amount,
    $core.String? currency,
    $core.String? note,
    $core.String? adminId,
  }) {
    final _result = create();
    if (saleId != null) {
      _result.saleId = saleId;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (note != null) {
      _result.note = note;
    }
    if (adminId != null) {
      _result.adminId = adminId;
    }
    return _result;
  }
  factory AdminSetSellPayoutOverrideRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AdminSetSellPayoutOverrideRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AdminSetSellPayoutOverrideRequest clone() => AdminSetSellPayoutOverrideRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AdminSetSellPayoutOverrideRequest copyWith(void Function(AdminSetSellPayoutOverrideRequest) updates) => super.copyWith((message) => updates(message as AdminSetSellPayoutOverrideRequest)) as AdminSetSellPayoutOverrideRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AdminSetSellPayoutOverrideRequest create() => AdminSetSellPayoutOverrideRequest._();
  AdminSetSellPayoutOverrideRequest createEmptyInstance() => create();
  static $pb.PbList<AdminSetSellPayoutOverrideRequest> createRepeated() => $pb.PbList<AdminSetSellPayoutOverrideRequest>();
  @$core.pragma('dart2js:noInline')
  static AdminSetSellPayoutOverrideRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminSetSellPayoutOverrideRequest>(create);
  static AdminSetSellPayoutOverrideRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get saleId => $_getSZ(0);
  @$pb.TagNumber(1)
  set saleId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSaleId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSaleId() => clearField(1);

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
  $core.String get note => $_getSZ(3);
  @$pb.TagNumber(4)
  set note($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasNote() => $_has(3);
  @$pb.TagNumber(4)
  void clearNote() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get adminId => $_getSZ(4);
  @$pb.TagNumber(5)
  set adminId($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasAdminId() => $_has(4);
  @$pb.TagNumber(5)
  void clearAdminId() => clearField(5);
}

class AdminSetSellPayoutOverrideResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AdminSetSellPayoutOverrideResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'overrideAmount', $pb.PbFieldType.OD)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'overrideCurrency')
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'resolvedNgn', $pb.PbFieldType.OD)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  AdminSetSellPayoutOverrideResponse._() : super();
  factory AdminSetSellPayoutOverrideResponse({
    $core.bool? success,
    $core.double? overrideAmount,
    $core.String? overrideCurrency,
    $core.double? resolvedNgn,
    $core.String? message,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (overrideAmount != null) {
      _result.overrideAmount = overrideAmount;
    }
    if (overrideCurrency != null) {
      _result.overrideCurrency = overrideCurrency;
    }
    if (resolvedNgn != null) {
      _result.resolvedNgn = resolvedNgn;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory AdminSetSellPayoutOverrideResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AdminSetSellPayoutOverrideResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AdminSetSellPayoutOverrideResponse clone() => AdminSetSellPayoutOverrideResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AdminSetSellPayoutOverrideResponse copyWith(void Function(AdminSetSellPayoutOverrideResponse) updates) => super.copyWith((message) => updates(message as AdminSetSellPayoutOverrideResponse)) as AdminSetSellPayoutOverrideResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AdminSetSellPayoutOverrideResponse create() => AdminSetSellPayoutOverrideResponse._();
  AdminSetSellPayoutOverrideResponse createEmptyInstance() => create();
  static $pb.PbList<AdminSetSellPayoutOverrideResponse> createRepeated() => $pb.PbList<AdminSetSellPayoutOverrideResponse>();
  @$core.pragma('dart2js:noInline')
  static AdminSetSellPayoutOverrideResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminSetSellPayoutOverrideResponse>(create);
  static AdminSetSellPayoutOverrideResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get overrideAmount => $_getN(1);
  @$pb.TagNumber(2)
  set overrideAmount($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasOverrideAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearOverrideAmount() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get overrideCurrency => $_getSZ(2);
  @$pb.TagNumber(3)
  set overrideCurrency($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasOverrideCurrency() => $_has(2);
  @$pb.TagNumber(3)
  void clearOverrideCurrency() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get resolvedNgn => $_getN(3);
  @$pb.TagNumber(4)
  set resolvedNgn($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasResolvedNgn() => $_has(3);
  @$pb.TagNumber(4)
  void clearResolvedNgn() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get message => $_getSZ(4);
  @$pb.TagNumber(5)
  set message($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasMessage() => $_has(4);
  @$pb.TagNumber(5)
  void clearMessage() => clearField(5);
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

class GetGiftCardsAnalyticsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetGiftCardsAnalyticsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'timeRange')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'provider')
    ..hasRequiredFields = false
  ;

  GetGiftCardsAnalyticsRequest._() : super();
  factory GetGiftCardsAnalyticsRequest({
    $core.String? timeRange,
    $core.String? provider,
  }) {
    final _result = create();
    if (timeRange != null) {
      _result.timeRange = timeRange;
    }
    if (provider != null) {
      _result.provider = provider;
    }
    return _result;
  }
  factory GetGiftCardsAnalyticsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetGiftCardsAnalyticsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetGiftCardsAnalyticsRequest clone() => GetGiftCardsAnalyticsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetGiftCardsAnalyticsRequest copyWith(void Function(GetGiftCardsAnalyticsRequest) updates) => super.copyWith((message) => updates(message as GetGiftCardsAnalyticsRequest)) as GetGiftCardsAnalyticsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetGiftCardsAnalyticsRequest create() => GetGiftCardsAnalyticsRequest._();
  GetGiftCardsAnalyticsRequest createEmptyInstance() => create();
  static $pb.PbList<GetGiftCardsAnalyticsRequest> createRepeated() => $pb.PbList<GetGiftCardsAnalyticsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetGiftCardsAnalyticsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetGiftCardsAnalyticsRequest>(create);
  static GetGiftCardsAnalyticsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get timeRange => $_getSZ(0);
  @$pb.TagNumber(1)
  set timeRange($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTimeRange() => $_has(0);
  @$pb.TagNumber(1)
  void clearTimeRange() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get provider => $_getSZ(1);
  @$pb.TagNumber(2)
  set provider($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasProvider() => $_has(1);
  @$pb.TagNumber(2)
  void clearProvider() => clearField(2);
}

class RevenuePoint extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RevenuePoint', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'date')
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'revenue', $pb.PbFieldType.OD)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payouts', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  RevenuePoint._() : super();
  factory RevenuePoint({
    $core.String? date,
    $core.double? revenue,
    $core.double? payouts,
  }) {
    final _result = create();
    if (date != null) {
      _result.date = date;
    }
    if (revenue != null) {
      _result.revenue = revenue;
    }
    if (payouts != null) {
      _result.payouts = payouts;
    }
    return _result;
  }
  factory RevenuePoint.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RevenuePoint.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RevenuePoint clone() => RevenuePoint()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RevenuePoint copyWith(void Function(RevenuePoint) updates) => super.copyWith((message) => updates(message as RevenuePoint)) as RevenuePoint; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RevenuePoint create() => RevenuePoint._();
  RevenuePoint createEmptyInstance() => create();
  static $pb.PbList<RevenuePoint> createRepeated() => $pb.PbList<RevenuePoint>();
  @$core.pragma('dart2js:noInline')
  static RevenuePoint getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RevenuePoint>(create);
  static RevenuePoint? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get date => $_getSZ(0);
  @$pb.TagNumber(1)
  set date($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDate() => $_has(0);
  @$pb.TagNumber(1)
  void clearDate() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get revenue => $_getN(1);
  @$pb.TagNumber(2)
  set revenue($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasRevenue() => $_has(1);
  @$pb.TagNumber(2)
  void clearRevenue() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get payouts => $_getN(2);
  @$pb.TagNumber(3)
  set payouts($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPayouts() => $_has(2);
  @$pb.TagNumber(3)
  void clearPayouts() => clearField(3);
}

class ProviderSlice extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProviderSlice', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'provider')
    ..aInt64(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sales')
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'revenue', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  ProviderSlice._() : super();
  factory ProviderSlice({
    $core.String? provider,
    $fixnum.Int64? sales,
    $core.double? revenue,
  }) {
    final _result = create();
    if (provider != null) {
      _result.provider = provider;
    }
    if (sales != null) {
      _result.sales = sales;
    }
    if (revenue != null) {
      _result.revenue = revenue;
    }
    return _result;
  }
  factory ProviderSlice.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProviderSlice.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProviderSlice clone() => ProviderSlice()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProviderSlice copyWith(void Function(ProviderSlice) updates) => super.copyWith((message) => updates(message as ProviderSlice)) as ProviderSlice; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProviderSlice create() => ProviderSlice._();
  ProviderSlice createEmptyInstance() => create();
  static $pb.PbList<ProviderSlice> createRepeated() => $pb.PbList<ProviderSlice>();
  @$core.pragma('dart2js:noInline')
  static ProviderSlice getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProviderSlice>(create);
  static ProviderSlice? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get provider => $_getSZ(0);
  @$pb.TagNumber(1)
  set provider($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasProvider() => $_has(0);
  @$pb.TagNumber(1)
  void clearProvider() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get sales => $_getI64(1);
  @$pb.TagNumber(2)
  set sales($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSales() => $_has(1);
  @$pb.TagNumber(2)
  void clearSales() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get revenue => $_getN(2);
  @$pb.TagNumber(3)
  set revenue($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasRevenue() => $_has(2);
  @$pb.TagNumber(3)
  void clearRevenue() => clearField(3);
}

class TopCardType extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TopCardType', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cardType')
    ..aInt64(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sales')
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'revenue', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  TopCardType._() : super();
  factory TopCardType({
    $core.String? cardType,
    $fixnum.Int64? sales,
    $core.double? revenue,
  }) {
    final _result = create();
    if (cardType != null) {
      _result.cardType = cardType;
    }
    if (sales != null) {
      _result.sales = sales;
    }
    if (revenue != null) {
      _result.revenue = revenue;
    }
    return _result;
  }
  factory TopCardType.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TopCardType.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TopCardType clone() => TopCardType()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TopCardType copyWith(void Function(TopCardType) updates) => super.copyWith((message) => updates(message as TopCardType)) as TopCardType; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TopCardType create() => TopCardType._();
  TopCardType createEmptyInstance() => create();
  static $pb.PbList<TopCardType> createRepeated() => $pb.PbList<TopCardType>();
  @$core.pragma('dart2js:noInline')
  static TopCardType getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TopCardType>(create);
  static TopCardType? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get cardType => $_getSZ(0);
  @$pb.TagNumber(1)
  set cardType($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCardType() => $_has(0);
  @$pb.TagNumber(1)
  void clearCardType() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get sales => $_getI64(1);
  @$pb.TagNumber(2)
  set sales($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSales() => $_has(1);
  @$pb.TagNumber(2)
  void clearSales() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get revenue => $_getN(2);
  @$pb.TagNumber(3)
  set revenue($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasRevenue() => $_has(2);
  @$pb.TagNumber(3)
  void clearRevenue() => clearField(3);
}

class SettlementSlice extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SettlementSlice', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..aInt64(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'count')
    ..hasRequiredFields = false
  ;

  SettlementSlice._() : super();
  factory SettlementSlice({
    $core.String? status,
    $fixnum.Int64? count,
  }) {
    final _result = create();
    if (status != null) {
      _result.status = status;
    }
    if (count != null) {
      _result.count = count;
    }
    return _result;
  }
  factory SettlementSlice.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SettlementSlice.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SettlementSlice clone() => SettlementSlice()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SettlementSlice copyWith(void Function(SettlementSlice) updates) => super.copyWith((message) => updates(message as SettlementSlice)) as SettlementSlice; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SettlementSlice create() => SettlementSlice._();
  SettlementSlice createEmptyInstance() => create();
  static $pb.PbList<SettlementSlice> createRepeated() => $pb.PbList<SettlementSlice>();
  @$core.pragma('dart2js:noInline')
  static SettlementSlice getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SettlementSlice>(create);
  static SettlementSlice? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get status => $_getSZ(0);
  @$pb.TagNumber(1)
  set status($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get count => $_getI64(1);
  @$pb.TagNumber(2)
  set count($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCount() => $_has(1);
  @$pb.TagNumber(2)
  void clearCount() => clearField(2);
}

class ProviderPerformance extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProviderPerformance', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'provider')
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'successRate', $pb.PbFieldType.OD)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'averageLatencyMs', $pb.PbFieldType.OD)
    ..aInt64(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'errors')
    ..hasRequiredFields = false
  ;

  ProviderPerformance._() : super();
  factory ProviderPerformance({
    $core.String? provider,
    $core.double? successRate,
    $core.double? averageLatencyMs,
    $fixnum.Int64? errors,
  }) {
    final _result = create();
    if (provider != null) {
      _result.provider = provider;
    }
    if (successRate != null) {
      _result.successRate = successRate;
    }
    if (averageLatencyMs != null) {
      _result.averageLatencyMs = averageLatencyMs;
    }
    if (errors != null) {
      _result.errors = errors;
    }
    return _result;
  }
  factory ProviderPerformance.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProviderPerformance.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProviderPerformance clone() => ProviderPerformance()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProviderPerformance copyWith(void Function(ProviderPerformance) updates) => super.copyWith((message) => updates(message as ProviderPerformance)) as ProviderPerformance; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProviderPerformance create() => ProviderPerformance._();
  ProviderPerformance createEmptyInstance() => create();
  static $pb.PbList<ProviderPerformance> createRepeated() => $pb.PbList<ProviderPerformance>();
  @$core.pragma('dart2js:noInline')
  static ProviderPerformance getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProviderPerformance>(create);
  static ProviderPerformance? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get provider => $_getSZ(0);
  @$pb.TagNumber(1)
  set provider($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasProvider() => $_has(0);
  @$pb.TagNumber(1)
  void clearProvider() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get successRate => $_getN(1);
  @$pb.TagNumber(2)
  set successRate($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSuccessRate() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccessRate() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get averageLatencyMs => $_getN(2);
  @$pb.TagNumber(3)
  set averageLatencyMs($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAverageLatencyMs() => $_has(2);
  @$pb.TagNumber(3)
  void clearAverageLatencyMs() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get errors => $_getI64(3);
  @$pb.TagNumber(4)
  set errors($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasErrors() => $_has(3);
  @$pb.TagNumber(4)
  void clearErrors() => clearField(4);
}

class GetGiftCardsAnalyticsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetGiftCardsAnalyticsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..a<$core.double>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalRevenue', $pb.PbFieldType.OD)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalPayouts', $pb.PbFieldType.OD)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'grossProfit', $pb.PbFieldType.OD)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'profitMargin', $pb.PbFieldType.OD)
    ..aInt64(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalSales')
    ..a<$core.double>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'approvalRate', $pb.PbFieldType.OD)
    ..a<$core.double>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'revenueChangePercent', $pb.PbFieldType.OD)
    ..a<$core.double>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payoutsChangePercent', $pb.PbFieldType.OD)
    ..a<$core.double>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'profitChangePercent', $pb.PbFieldType.OD)
    ..a<$core.double>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'salesChangePercent', $pb.PbFieldType.OD)
    ..pc<RevenuePoint>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'revenueOverTime', $pb.PbFieldType.PM, subBuilder: RevenuePoint.create)
    ..pc<ProviderSlice>(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'salesByProvider', $pb.PbFieldType.PM, subBuilder: ProviderSlice.create)
    ..pc<TopCardType>(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'topCardTypes', $pb.PbFieldType.PM, subBuilder: TopCardType.create)
    ..pc<SettlementSlice>(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'settlementStatus', $pb.PbFieldType.PM, subBuilder: SettlementSlice.create)
    ..pc<ProviderPerformance>(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerPerformance', $pb.PbFieldType.PM, subBuilder: ProviderPerformance.create)
    ..hasRequiredFields = false
  ;

  GetGiftCardsAnalyticsResponse._() : super();
  factory GetGiftCardsAnalyticsResponse({
    $core.double? totalRevenue,
    $core.double? totalPayouts,
    $core.double? grossProfit,
    $core.double? profitMargin,
    $fixnum.Int64? totalSales,
    $core.double? approvalRate,
    $core.double? revenueChangePercent,
    $core.double? payoutsChangePercent,
    $core.double? profitChangePercent,
    $core.double? salesChangePercent,
    $core.Iterable<RevenuePoint>? revenueOverTime,
    $core.Iterable<ProviderSlice>? salesByProvider,
    $core.Iterable<TopCardType>? topCardTypes,
    $core.Iterable<SettlementSlice>? settlementStatus,
    $core.Iterable<ProviderPerformance>? providerPerformance,
  }) {
    final _result = create();
    if (totalRevenue != null) {
      _result.totalRevenue = totalRevenue;
    }
    if (totalPayouts != null) {
      _result.totalPayouts = totalPayouts;
    }
    if (grossProfit != null) {
      _result.grossProfit = grossProfit;
    }
    if (profitMargin != null) {
      _result.profitMargin = profitMargin;
    }
    if (totalSales != null) {
      _result.totalSales = totalSales;
    }
    if (approvalRate != null) {
      _result.approvalRate = approvalRate;
    }
    if (revenueChangePercent != null) {
      _result.revenueChangePercent = revenueChangePercent;
    }
    if (payoutsChangePercent != null) {
      _result.payoutsChangePercent = payoutsChangePercent;
    }
    if (profitChangePercent != null) {
      _result.profitChangePercent = profitChangePercent;
    }
    if (salesChangePercent != null) {
      _result.salesChangePercent = salesChangePercent;
    }
    if (revenueOverTime != null) {
      _result.revenueOverTime.addAll(revenueOverTime);
    }
    if (salesByProvider != null) {
      _result.salesByProvider.addAll(salesByProvider);
    }
    if (topCardTypes != null) {
      _result.topCardTypes.addAll(topCardTypes);
    }
    if (settlementStatus != null) {
      _result.settlementStatus.addAll(settlementStatus);
    }
    if (providerPerformance != null) {
      _result.providerPerformance.addAll(providerPerformance);
    }
    return _result;
  }
  factory GetGiftCardsAnalyticsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetGiftCardsAnalyticsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetGiftCardsAnalyticsResponse clone() => GetGiftCardsAnalyticsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetGiftCardsAnalyticsResponse copyWith(void Function(GetGiftCardsAnalyticsResponse) updates) => super.copyWith((message) => updates(message as GetGiftCardsAnalyticsResponse)) as GetGiftCardsAnalyticsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetGiftCardsAnalyticsResponse create() => GetGiftCardsAnalyticsResponse._();
  GetGiftCardsAnalyticsResponse createEmptyInstance() => create();
  static $pb.PbList<GetGiftCardsAnalyticsResponse> createRepeated() => $pb.PbList<GetGiftCardsAnalyticsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetGiftCardsAnalyticsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetGiftCardsAnalyticsResponse>(create);
  static GetGiftCardsAnalyticsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get totalRevenue => $_getN(0);
  @$pb.TagNumber(1)
  set totalRevenue($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTotalRevenue() => $_has(0);
  @$pb.TagNumber(1)
  void clearTotalRevenue() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get totalPayouts => $_getN(1);
  @$pb.TagNumber(2)
  set totalPayouts($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTotalPayouts() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalPayouts() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get grossProfit => $_getN(2);
  @$pb.TagNumber(3)
  set grossProfit($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasGrossProfit() => $_has(2);
  @$pb.TagNumber(3)
  void clearGrossProfit() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get profitMargin => $_getN(3);
  @$pb.TagNumber(4)
  set profitMargin($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasProfitMargin() => $_has(3);
  @$pb.TagNumber(4)
  void clearProfitMargin() => clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get totalSales => $_getI64(4);
  @$pb.TagNumber(5)
  set totalSales($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTotalSales() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotalSales() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get approvalRate => $_getN(5);
  @$pb.TagNumber(6)
  set approvalRate($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasApprovalRate() => $_has(5);
  @$pb.TagNumber(6)
  void clearApprovalRate() => clearField(6);

  @$pb.TagNumber(7)
  $core.double get revenueChangePercent => $_getN(6);
  @$pb.TagNumber(7)
  set revenueChangePercent($core.double v) { $_setDouble(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasRevenueChangePercent() => $_has(6);
  @$pb.TagNumber(7)
  void clearRevenueChangePercent() => clearField(7);

  @$pb.TagNumber(8)
  $core.double get payoutsChangePercent => $_getN(7);
  @$pb.TagNumber(8)
  set payoutsChangePercent($core.double v) { $_setDouble(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasPayoutsChangePercent() => $_has(7);
  @$pb.TagNumber(8)
  void clearPayoutsChangePercent() => clearField(8);

  @$pb.TagNumber(9)
  $core.double get profitChangePercent => $_getN(8);
  @$pb.TagNumber(9)
  set profitChangePercent($core.double v) { $_setDouble(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasProfitChangePercent() => $_has(8);
  @$pb.TagNumber(9)
  void clearProfitChangePercent() => clearField(9);

  @$pb.TagNumber(10)
  $core.double get salesChangePercent => $_getN(9);
  @$pb.TagNumber(10)
  set salesChangePercent($core.double v) { $_setDouble(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasSalesChangePercent() => $_has(9);
  @$pb.TagNumber(10)
  void clearSalesChangePercent() => clearField(10);

  @$pb.TagNumber(11)
  $core.List<RevenuePoint> get revenueOverTime => $_getList(10);

  @$pb.TagNumber(12)
  $core.List<ProviderSlice> get salesByProvider => $_getList(11);

  @$pb.TagNumber(13)
  $core.List<TopCardType> get topCardTypes => $_getList(12);

  @$pb.TagNumber(14)
  $core.List<SettlementSlice> get settlementStatus => $_getList(13);

  @$pb.TagNumber(15)
  $core.List<ProviderPerformance> get providerPerformance => $_getList(14);
}

class ReconciliationRun extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ReconciliationRun', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'timestamp')
    ..aInt64(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'itemsProcessed')
    ..aInt64(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'resolved')
    ..aInt64(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'escalated')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'duration')
    ..hasRequiredFields = false
  ;

  ReconciliationRun._() : super();
  factory ReconciliationRun({
    $core.String? id,
    $core.String? type,
    $core.String? status,
    $core.String? timestamp,
    $fixnum.Int64? itemsProcessed,
    $fixnum.Int64? resolved,
    $fixnum.Int64? escalated,
    $core.String? duration,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (type != null) {
      _result.type = type;
    }
    if (status != null) {
      _result.status = status;
    }
    if (timestamp != null) {
      _result.timestamp = timestamp;
    }
    if (itemsProcessed != null) {
      _result.itemsProcessed = itemsProcessed;
    }
    if (resolved != null) {
      _result.resolved = resolved;
    }
    if (escalated != null) {
      _result.escalated = escalated;
    }
    if (duration != null) {
      _result.duration = duration;
    }
    return _result;
  }
  factory ReconciliationRun.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ReconciliationRun.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ReconciliationRun clone() => ReconciliationRun()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ReconciliationRun copyWith(void Function(ReconciliationRun) updates) => super.copyWith((message) => updates(message as ReconciliationRun)) as ReconciliationRun; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ReconciliationRun create() => ReconciliationRun._();
  ReconciliationRun createEmptyInstance() => create();
  static $pb.PbList<ReconciliationRun> createRepeated() => $pb.PbList<ReconciliationRun>();
  @$core.pragma('dart2js:noInline')
  static ReconciliationRun getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ReconciliationRun>(create);
  static ReconciliationRun? _defaultInstance;

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
  $core.String get status => $_getSZ(2);
  @$pb.TagNumber(3)
  set status($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatus() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get timestamp => $_getSZ(3);
  @$pb.TagNumber(4)
  set timestamp($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTimestamp() => $_has(3);
  @$pb.TagNumber(4)
  void clearTimestamp() => clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get itemsProcessed => $_getI64(4);
  @$pb.TagNumber(5)
  set itemsProcessed($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasItemsProcessed() => $_has(4);
  @$pb.TagNumber(5)
  void clearItemsProcessed() => clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get resolved => $_getI64(5);
  @$pb.TagNumber(6)
  set resolved($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasResolved() => $_has(5);
  @$pb.TagNumber(6)
  void clearResolved() => clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get escalated => $_getI64(6);
  @$pb.TagNumber(7)
  set escalated($fixnum.Int64 v) { $_setInt64(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasEscalated() => $_has(6);
  @$pb.TagNumber(7)
  void clearEscalated() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get duration => $_getSZ(7);
  @$pb.TagNumber(8)
  set duration($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasDuration() => $_has(7);
  @$pb.TagNumber(8)
  void clearDuration() => clearField(8);
}

class GetReconciliationOverviewRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetReconciliationOverviewRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  GetReconciliationOverviewRequest._() : super();
  factory GetReconciliationOverviewRequest() => create();
  factory GetReconciliationOverviewRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetReconciliationOverviewRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetReconciliationOverviewRequest clone() => GetReconciliationOverviewRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetReconciliationOverviewRequest copyWith(void Function(GetReconciliationOverviewRequest) updates) => super.copyWith((message) => updates(message as GetReconciliationOverviewRequest)) as GetReconciliationOverviewRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetReconciliationOverviewRequest create() => GetReconciliationOverviewRequest._();
  GetReconciliationOverviewRequest createEmptyInstance() => create();
  static $pb.PbList<GetReconciliationOverviewRequest> createRepeated() => $pb.PbList<GetReconciliationOverviewRequest>();
  @$core.pragma('dart2js:noInline')
  static GetReconciliationOverviewRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetReconciliationOverviewRequest>(create);
  static GetReconciliationOverviewRequest? _defaultInstance;
}

class GetReconciliationOverviewResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetReconciliationOverviewResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aInt64(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'orphanedTransactions')
    ..aInt64(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pendingVerification')
    ..aInt64(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'escalatedItems')
    ..aInt64(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'resolvedToday')
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'floatVariance', $pb.PbFieldType.OD)
    ..aOB(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'floatVarianceCritical')
    ..aOM<ReconciliationRun>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lastReconciliation', subBuilder: ReconciliationRun.create)
    ..hasRequiredFields = false
  ;

  GetReconciliationOverviewResponse._() : super();
  factory GetReconciliationOverviewResponse({
    $fixnum.Int64? orphanedTransactions,
    $fixnum.Int64? pendingVerification,
    $fixnum.Int64? escalatedItems,
    $fixnum.Int64? resolvedToday,
    $core.double? floatVariance,
    $core.bool? floatVarianceCritical,
    ReconciliationRun? lastReconciliation,
  }) {
    final _result = create();
    if (orphanedTransactions != null) {
      _result.orphanedTransactions = orphanedTransactions;
    }
    if (pendingVerification != null) {
      _result.pendingVerification = pendingVerification;
    }
    if (escalatedItems != null) {
      _result.escalatedItems = escalatedItems;
    }
    if (resolvedToday != null) {
      _result.resolvedToday = resolvedToday;
    }
    if (floatVariance != null) {
      _result.floatVariance = floatVariance;
    }
    if (floatVarianceCritical != null) {
      _result.floatVarianceCritical = floatVarianceCritical;
    }
    if (lastReconciliation != null) {
      _result.lastReconciliation = lastReconciliation;
    }
    return _result;
  }
  factory GetReconciliationOverviewResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetReconciliationOverviewResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetReconciliationOverviewResponse clone() => GetReconciliationOverviewResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetReconciliationOverviewResponse copyWith(void Function(GetReconciliationOverviewResponse) updates) => super.copyWith((message) => updates(message as GetReconciliationOverviewResponse)) as GetReconciliationOverviewResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetReconciliationOverviewResponse create() => GetReconciliationOverviewResponse._();
  GetReconciliationOverviewResponse createEmptyInstance() => create();
  static $pb.PbList<GetReconciliationOverviewResponse> createRepeated() => $pb.PbList<GetReconciliationOverviewResponse>();
  @$core.pragma('dart2js:noInline')
  static GetReconciliationOverviewResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetReconciliationOverviewResponse>(create);
  static GetReconciliationOverviewResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get orphanedTransactions => $_getI64(0);
  @$pb.TagNumber(1)
  set orphanedTransactions($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasOrphanedTransactions() => $_has(0);
  @$pb.TagNumber(1)
  void clearOrphanedTransactions() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get pendingVerification => $_getI64(1);
  @$pb.TagNumber(2)
  set pendingVerification($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPendingVerification() => $_has(1);
  @$pb.TagNumber(2)
  void clearPendingVerification() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get escalatedItems => $_getI64(2);
  @$pb.TagNumber(3)
  set escalatedItems($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasEscalatedItems() => $_has(2);
  @$pb.TagNumber(3)
  void clearEscalatedItems() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get resolvedToday => $_getI64(3);
  @$pb.TagNumber(4)
  set resolvedToday($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasResolvedToday() => $_has(3);
  @$pb.TagNumber(4)
  void clearResolvedToday() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get floatVariance => $_getN(4);
  @$pb.TagNumber(5)
  set floatVariance($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasFloatVariance() => $_has(4);
  @$pb.TagNumber(5)
  void clearFloatVariance() => clearField(5);

  @$pb.TagNumber(6)
  $core.bool get floatVarianceCritical => $_getBF(5);
  @$pb.TagNumber(6)
  set floatVarianceCritical($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasFloatVarianceCritical() => $_has(5);
  @$pb.TagNumber(6)
  void clearFloatVarianceCritical() => clearField(6);

  @$pb.TagNumber(7)
  ReconciliationRun get lastReconciliation => $_getN(6);
  @$pb.TagNumber(7)
  set lastReconciliation(ReconciliationRun v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasLastReconciliation() => $_has(6);
  @$pb.TagNumber(7)
  void clearLastReconciliation() => clearField(7);
  @$pb.TagNumber(7)
  ReconciliationRun ensureLastReconciliation() => $_ensure(6);
}

class OrphanedTransaction extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'OrphanedTransaction', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reference')
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'issue')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt')
    ..hasRequiredFields = false
  ;

  OrphanedTransaction._() : super();
  factory OrphanedTransaction({
    $core.String? id,
    $core.String? type,
    $core.String? reference,
    $core.double? amount,
    $core.String? issue,
    $core.String? createdAt,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (type != null) {
      _result.type = type;
    }
    if (reference != null) {
      _result.reference = reference;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (issue != null) {
      _result.issue = issue;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    return _result;
  }
  factory OrphanedTransaction.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory OrphanedTransaction.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  OrphanedTransaction clone() => OrphanedTransaction()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  OrphanedTransaction copyWith(void Function(OrphanedTransaction) updates) => super.copyWith((message) => updates(message as OrphanedTransaction)) as OrphanedTransaction; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static OrphanedTransaction create() => OrphanedTransaction._();
  OrphanedTransaction createEmptyInstance() => create();
  static $pb.PbList<OrphanedTransaction> createRepeated() => $pb.PbList<OrphanedTransaction>();
  @$core.pragma('dart2js:noInline')
  static OrphanedTransaction getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<OrphanedTransaction>(create);
  static OrphanedTransaction? _defaultInstance;

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
  $core.String get reference => $_getSZ(2);
  @$pb.TagNumber(3)
  set reference($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasReference() => $_has(2);
  @$pb.TagNumber(3)
  void clearReference() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get amount => $_getN(3);
  @$pb.TagNumber(4)
  set amount($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearAmount() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get issue => $_getSZ(4);
  @$pb.TagNumber(5)
  set issue($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasIssue() => $_has(4);
  @$pb.TagNumber(5)
  void clearIssue() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get createdAt => $_getSZ(5);
  @$pb.TagNumber(6)
  set createdAt($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasCreatedAt() => $_has(5);
  @$pb.TagNumber(6)
  void clearCreatedAt() => clearField(6);
}

class GetOrphanedTransactionsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetOrphanedTransactionsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetOrphanedTransactionsRequest._() : super();
  factory GetOrphanedTransactionsRequest({
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
  factory GetOrphanedTransactionsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetOrphanedTransactionsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetOrphanedTransactionsRequest clone() => GetOrphanedTransactionsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetOrphanedTransactionsRequest copyWith(void Function(GetOrphanedTransactionsRequest) updates) => super.copyWith((message) => updates(message as GetOrphanedTransactionsRequest)) as GetOrphanedTransactionsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetOrphanedTransactionsRequest create() => GetOrphanedTransactionsRequest._();
  GetOrphanedTransactionsRequest createEmptyInstance() => create();
  static $pb.PbList<GetOrphanedTransactionsRequest> createRepeated() => $pb.PbList<GetOrphanedTransactionsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetOrphanedTransactionsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetOrphanedTransactionsRequest>(create);
  static GetOrphanedTransactionsRequest? _defaultInstance;

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

class GetOrphanedTransactionsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetOrphanedTransactionsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..pc<OrphanedTransaction>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactions', $pb.PbFieldType.PM, subBuilder: OrphanedTransaction.create)
    ..aInt64(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'total')
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetOrphanedTransactionsResponse._() : super();
  factory GetOrphanedTransactionsResponse({
    $core.Iterable<OrphanedTransaction>? transactions,
    $fixnum.Int64? total,
    $core.int? page,
    $core.int? limit,
  }) {
    final _result = create();
    if (transactions != null) {
      _result.transactions.addAll(transactions);
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
  factory GetOrphanedTransactionsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetOrphanedTransactionsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetOrphanedTransactionsResponse clone() => GetOrphanedTransactionsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetOrphanedTransactionsResponse copyWith(void Function(GetOrphanedTransactionsResponse) updates) => super.copyWith((message) => updates(message as GetOrphanedTransactionsResponse)) as GetOrphanedTransactionsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetOrphanedTransactionsResponse create() => GetOrphanedTransactionsResponse._();
  GetOrphanedTransactionsResponse createEmptyInstance() => create();
  static $pb.PbList<GetOrphanedTransactionsResponse> createRepeated() => $pb.PbList<GetOrphanedTransactionsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetOrphanedTransactionsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetOrphanedTransactionsResponse>(create);
  static GetOrphanedTransactionsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<OrphanedTransaction> get transactions => $_getList(0);

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

class ResolveOrphanedTransactionRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ResolveOrphanedTransactionRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'resolution')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'notes')
    ..hasRequiredFields = false
  ;

  ResolveOrphanedTransactionRequest._() : super();
  factory ResolveOrphanedTransactionRequest({
    $core.String? id,
    $core.String? resolution,
    $core.String? notes,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (resolution != null) {
      _result.resolution = resolution;
    }
    if (notes != null) {
      _result.notes = notes;
    }
    return _result;
  }
  factory ResolveOrphanedTransactionRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ResolveOrphanedTransactionRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ResolveOrphanedTransactionRequest clone() => ResolveOrphanedTransactionRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ResolveOrphanedTransactionRequest copyWith(void Function(ResolveOrphanedTransactionRequest) updates) => super.copyWith((message) => updates(message as ResolveOrphanedTransactionRequest)) as ResolveOrphanedTransactionRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ResolveOrphanedTransactionRequest create() => ResolveOrphanedTransactionRequest._();
  ResolveOrphanedTransactionRequest createEmptyInstance() => create();
  static $pb.PbList<ResolveOrphanedTransactionRequest> createRepeated() => $pb.PbList<ResolveOrphanedTransactionRequest>();
  @$core.pragma('dart2js:noInline')
  static ResolveOrphanedTransactionRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ResolveOrphanedTransactionRequest>(create);
  static ResolveOrphanedTransactionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get resolution => $_getSZ(1);
  @$pb.TagNumber(2)
  set resolution($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasResolution() => $_has(1);
  @$pb.TagNumber(2)
  void clearResolution() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get notes => $_getSZ(2);
  @$pb.TagNumber(3)
  set notes($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasNotes() => $_has(2);
  @$pb.TagNumber(3)
  void clearNotes() => clearField(3);
}

class ResolveOrphanedTransactionResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ResolveOrphanedTransactionResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  ResolveOrphanedTransactionResponse._() : super();
  factory ResolveOrphanedTransactionResponse({
    $core.bool? success,
    $core.String? message,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory ResolveOrphanedTransactionResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ResolveOrphanedTransactionResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ResolveOrphanedTransactionResponse clone() => ResolveOrphanedTransactionResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ResolveOrphanedTransactionResponse copyWith(void Function(ResolveOrphanedTransactionResponse) updates) => super.copyWith((message) => updates(message as ResolveOrphanedTransactionResponse)) as ResolveOrphanedTransactionResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ResolveOrphanedTransactionResponse create() => ResolveOrphanedTransactionResponse._();
  ResolveOrphanedTransactionResponse createEmptyInstance() => create();
  static $pb.PbList<ResolveOrphanedTransactionResponse> createRepeated() => $pb.PbList<ResolveOrphanedTransactionResponse>();
  @$core.pragma('dart2js:noInline')
  static ResolveOrphanedTransactionResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ResolveOrphanedTransactionResponse>(create);
  static ResolveOrphanedTransactionResponse? _defaultInstance;

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

class PendingVerification extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PendingVerification', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reference')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cardType')
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'denomination', $pb.PbFieldType.OD)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'currency')
    ..a<$core.int>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'verificationAttempts', $pb.PbFieldType.O3)
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lastChecked')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..hasRequiredFields = false
  ;

  PendingVerification._() : super();
  factory PendingVerification({
    $core.String? id,
    $core.String? reference,
    $core.String? cardType,
    $core.double? denomination,
    $core.String? currency,
    $core.int? verificationAttempts,
    $core.String? lastChecked,
    $core.String? status,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (reference != null) {
      _result.reference = reference;
    }
    if (cardType != null) {
      _result.cardType = cardType;
    }
    if (denomination != null) {
      _result.denomination = denomination;
    }
    if (currency != null) {
      _result.currency = currency;
    }
    if (verificationAttempts != null) {
      _result.verificationAttempts = verificationAttempts;
    }
    if (lastChecked != null) {
      _result.lastChecked = lastChecked;
    }
    if (status != null) {
      _result.status = status;
    }
    return _result;
  }
  factory PendingVerification.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PendingVerification.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PendingVerification clone() => PendingVerification()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PendingVerification copyWith(void Function(PendingVerification) updates) => super.copyWith((message) => updates(message as PendingVerification)) as PendingVerification; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PendingVerification create() => PendingVerification._();
  PendingVerification createEmptyInstance() => create();
  static $pb.PbList<PendingVerification> createRepeated() => $pb.PbList<PendingVerification>();
  @$core.pragma('dart2js:noInline')
  static PendingVerification getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PendingVerification>(create);
  static PendingVerification? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get reference => $_getSZ(1);
  @$pb.TagNumber(2)
  set reference($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasReference() => $_has(1);
  @$pb.TagNumber(2)
  void clearReference() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get cardType => $_getSZ(2);
  @$pb.TagNumber(3)
  set cardType($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCardType() => $_has(2);
  @$pb.TagNumber(3)
  void clearCardType() => clearField(3);

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
  $core.int get verificationAttempts => $_getIZ(5);
  @$pb.TagNumber(6)
  set verificationAttempts($core.int v) { $_setSignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasVerificationAttempts() => $_has(5);
  @$pb.TagNumber(6)
  void clearVerificationAttempts() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get lastChecked => $_getSZ(6);
  @$pb.TagNumber(7)
  set lastChecked($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasLastChecked() => $_has(6);
  @$pb.TagNumber(7)
  void clearLastChecked() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get status => $_getSZ(7);
  @$pb.TagNumber(8)
  set status($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasStatus() => $_has(7);
  @$pb.TagNumber(8)
  void clearStatus() => clearField(8);
}

class GetPendingVerificationsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetPendingVerificationsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetPendingVerificationsRequest._() : super();
  factory GetPendingVerificationsRequest({
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
  factory GetPendingVerificationsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPendingVerificationsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPendingVerificationsRequest clone() => GetPendingVerificationsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPendingVerificationsRequest copyWith(void Function(GetPendingVerificationsRequest) updates) => super.copyWith((message) => updates(message as GetPendingVerificationsRequest)) as GetPendingVerificationsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetPendingVerificationsRequest create() => GetPendingVerificationsRequest._();
  GetPendingVerificationsRequest createEmptyInstance() => create();
  static $pb.PbList<GetPendingVerificationsRequest> createRepeated() => $pb.PbList<GetPendingVerificationsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetPendingVerificationsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetPendingVerificationsRequest>(create);
  static GetPendingVerificationsRequest? _defaultInstance;

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

class GetPendingVerificationsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetPendingVerificationsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..pc<PendingVerification>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'verifications', $pb.PbFieldType.PM, subBuilder: PendingVerification.create)
    ..aInt64(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'total')
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetPendingVerificationsResponse._() : super();
  factory GetPendingVerificationsResponse({
    $core.Iterable<PendingVerification>? verifications,
    $fixnum.Int64? total,
    $core.int? page,
    $core.int? limit,
  }) {
    final _result = create();
    if (verifications != null) {
      _result.verifications.addAll(verifications);
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
  factory GetPendingVerificationsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPendingVerificationsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPendingVerificationsResponse clone() => GetPendingVerificationsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPendingVerificationsResponse copyWith(void Function(GetPendingVerificationsResponse) updates) => super.copyWith((message) => updates(message as GetPendingVerificationsResponse)) as GetPendingVerificationsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetPendingVerificationsResponse create() => GetPendingVerificationsResponse._();
  GetPendingVerificationsResponse createEmptyInstance() => create();
  static $pb.PbList<GetPendingVerificationsResponse> createRepeated() => $pb.PbList<GetPendingVerificationsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetPendingVerificationsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetPendingVerificationsResponse>(create);
  static GetPendingVerificationsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<PendingVerification> get verifications => $_getList(0);

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

class EscalatedItem extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'EscalatedItem', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reference')
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reason')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'escalatedAt')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'assignedTo')
    ..hasRequiredFields = false
  ;

  EscalatedItem._() : super();
  factory EscalatedItem({
    $core.String? id,
    $core.String? reference,
    $core.double? amount,
    $core.String? reason,
    $core.String? escalatedAt,
    $core.String? status,
    $core.String? assignedTo,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (reference != null) {
      _result.reference = reference;
    }
    if (amount != null) {
      _result.amount = amount;
    }
    if (reason != null) {
      _result.reason = reason;
    }
    if (escalatedAt != null) {
      _result.escalatedAt = escalatedAt;
    }
    if (status != null) {
      _result.status = status;
    }
    if (assignedTo != null) {
      _result.assignedTo = assignedTo;
    }
    return _result;
  }
  factory EscalatedItem.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EscalatedItem.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EscalatedItem clone() => EscalatedItem()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EscalatedItem copyWith(void Function(EscalatedItem) updates) => super.copyWith((message) => updates(message as EscalatedItem)) as EscalatedItem; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static EscalatedItem create() => EscalatedItem._();
  EscalatedItem createEmptyInstance() => create();
  static $pb.PbList<EscalatedItem> createRepeated() => $pb.PbList<EscalatedItem>();
  @$core.pragma('dart2js:noInline')
  static EscalatedItem getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EscalatedItem>(create);
  static EscalatedItem? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get reference => $_getSZ(1);
  @$pb.TagNumber(2)
  set reference($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasReference() => $_has(1);
  @$pb.TagNumber(2)
  void clearReference() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get amount => $_getN(2);
  @$pb.TagNumber(3)
  set amount($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get reason => $_getSZ(3);
  @$pb.TagNumber(4)
  set reason($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasReason() => $_has(3);
  @$pb.TagNumber(4)
  void clearReason() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get escalatedAt => $_getSZ(4);
  @$pb.TagNumber(5)
  set escalatedAt($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasEscalatedAt() => $_has(4);
  @$pb.TagNumber(5)
  void clearEscalatedAt() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get status => $_getSZ(5);
  @$pb.TagNumber(6)
  set status($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasStatus() => $_has(5);
  @$pb.TagNumber(6)
  void clearStatus() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get assignedTo => $_getSZ(6);
  @$pb.TagNumber(7)
  set assignedTo($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasAssignedTo() => $_has(6);
  @$pb.TagNumber(7)
  void clearAssignedTo() => clearField(7);
}

class GetEscalatedItemsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetEscalatedItemsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetEscalatedItemsRequest._() : super();
  factory GetEscalatedItemsRequest({
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
  factory GetEscalatedItemsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetEscalatedItemsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetEscalatedItemsRequest clone() => GetEscalatedItemsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetEscalatedItemsRequest copyWith(void Function(GetEscalatedItemsRequest) updates) => super.copyWith((message) => updates(message as GetEscalatedItemsRequest)) as GetEscalatedItemsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetEscalatedItemsRequest create() => GetEscalatedItemsRequest._();
  GetEscalatedItemsRequest createEmptyInstance() => create();
  static $pb.PbList<GetEscalatedItemsRequest> createRepeated() => $pb.PbList<GetEscalatedItemsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetEscalatedItemsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetEscalatedItemsRequest>(create);
  static GetEscalatedItemsRequest? _defaultInstance;

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

class GetEscalatedItemsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetEscalatedItemsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..pc<EscalatedItem>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'items', $pb.PbFieldType.PM, subBuilder: EscalatedItem.create)
    ..aInt64(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'total')
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetEscalatedItemsResponse._() : super();
  factory GetEscalatedItemsResponse({
    $core.Iterable<EscalatedItem>? items,
    $fixnum.Int64? total,
    $core.int? page,
    $core.int? limit,
  }) {
    final _result = create();
    if (items != null) {
      _result.items.addAll(items);
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
  factory GetEscalatedItemsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetEscalatedItemsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetEscalatedItemsResponse clone() => GetEscalatedItemsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetEscalatedItemsResponse copyWith(void Function(GetEscalatedItemsResponse) updates) => super.copyWith((message) => updates(message as GetEscalatedItemsResponse)) as GetEscalatedItemsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetEscalatedItemsResponse create() => GetEscalatedItemsResponse._();
  GetEscalatedItemsResponse createEmptyInstance() => create();
  static $pb.PbList<GetEscalatedItemsResponse> createRepeated() => $pb.PbList<GetEscalatedItemsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetEscalatedItemsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetEscalatedItemsResponse>(create);
  static GetEscalatedItemsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<EscalatedItem> get items => $_getList(0);

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

class ResolveEscalatedItemRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ResolveEscalatedItemRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'resolution')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'notes')
    ..hasRequiredFields = false
  ;

  ResolveEscalatedItemRequest._() : super();
  factory ResolveEscalatedItemRequest({
    $core.String? id,
    $core.String? resolution,
    $core.String? notes,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (resolution != null) {
      _result.resolution = resolution;
    }
    if (notes != null) {
      _result.notes = notes;
    }
    return _result;
  }
  factory ResolveEscalatedItemRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ResolveEscalatedItemRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ResolveEscalatedItemRequest clone() => ResolveEscalatedItemRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ResolveEscalatedItemRequest copyWith(void Function(ResolveEscalatedItemRequest) updates) => super.copyWith((message) => updates(message as ResolveEscalatedItemRequest)) as ResolveEscalatedItemRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ResolveEscalatedItemRequest create() => ResolveEscalatedItemRequest._();
  ResolveEscalatedItemRequest createEmptyInstance() => create();
  static $pb.PbList<ResolveEscalatedItemRequest> createRepeated() => $pb.PbList<ResolveEscalatedItemRequest>();
  @$core.pragma('dart2js:noInline')
  static ResolveEscalatedItemRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ResolveEscalatedItemRequest>(create);
  static ResolveEscalatedItemRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get resolution => $_getSZ(1);
  @$pb.TagNumber(2)
  set resolution($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasResolution() => $_has(1);
  @$pb.TagNumber(2)
  void clearResolution() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get notes => $_getSZ(2);
  @$pb.TagNumber(3)
  set notes($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasNotes() => $_has(2);
  @$pb.TagNumber(3)
  void clearNotes() => clearField(3);
}

class ResolveEscalatedItemResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ResolveEscalatedItemResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  ResolveEscalatedItemResponse._() : super();
  factory ResolveEscalatedItemResponse({
    $core.bool? success,
    $core.String? message,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory ResolveEscalatedItemResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ResolveEscalatedItemResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ResolveEscalatedItemResponse clone() => ResolveEscalatedItemResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ResolveEscalatedItemResponse copyWith(void Function(ResolveEscalatedItemResponse) updates) => super.copyWith((message) => updates(message as ResolveEscalatedItemResponse)) as ResolveEscalatedItemResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ResolveEscalatedItemResponse create() => ResolveEscalatedItemResponse._();
  ResolveEscalatedItemResponse createEmptyInstance() => create();
  static $pb.PbList<ResolveEscalatedItemResponse> createRepeated() => $pb.PbList<ResolveEscalatedItemResponse>();
  @$core.pragma('dart2js:noInline')
  static ResolveEscalatedItemResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ResolveEscalatedItemResponse>(create);
  static ResolveEscalatedItemResponse? _defaultInstance;

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

class GetReconciliationHistoryRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetReconciliationHistoryRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetReconciliationHistoryRequest._() : super();
  factory GetReconciliationHistoryRequest({
    $core.int? limit,
  }) {
    final _result = create();
    if (limit != null) {
      _result.limit = limit;
    }
    return _result;
  }
  factory GetReconciliationHistoryRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetReconciliationHistoryRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetReconciliationHistoryRequest clone() => GetReconciliationHistoryRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetReconciliationHistoryRequest copyWith(void Function(GetReconciliationHistoryRequest) updates) => super.copyWith((message) => updates(message as GetReconciliationHistoryRequest)) as GetReconciliationHistoryRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetReconciliationHistoryRequest create() => GetReconciliationHistoryRequest._();
  GetReconciliationHistoryRequest createEmptyInstance() => create();
  static $pb.PbList<GetReconciliationHistoryRequest> createRepeated() => $pb.PbList<GetReconciliationHistoryRequest>();
  @$core.pragma('dart2js:noInline')
  static GetReconciliationHistoryRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetReconciliationHistoryRequest>(create);
  static GetReconciliationHistoryRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get limit => $_getIZ(0);
  @$pb.TagNumber(1)
  set limit($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLimit() => $_has(0);
  @$pb.TagNumber(1)
  void clearLimit() => clearField(1);
}

class GetReconciliationHistoryResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetReconciliationHistoryResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..pc<ReconciliationRun>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'runs', $pb.PbFieldType.PM, subBuilder: ReconciliationRun.create)
    ..hasRequiredFields = false
  ;

  GetReconciliationHistoryResponse._() : super();
  factory GetReconciliationHistoryResponse({
    $core.Iterable<ReconciliationRun>? runs,
  }) {
    final _result = create();
    if (runs != null) {
      _result.runs.addAll(runs);
    }
    return _result;
  }
  factory GetReconciliationHistoryResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetReconciliationHistoryResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetReconciliationHistoryResponse clone() => GetReconciliationHistoryResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetReconciliationHistoryResponse copyWith(void Function(GetReconciliationHistoryResponse) updates) => super.copyWith((message) => updates(message as GetReconciliationHistoryResponse)) as GetReconciliationHistoryResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetReconciliationHistoryResponse create() => GetReconciliationHistoryResponse._();
  GetReconciliationHistoryResponse createEmptyInstance() => create();
  static $pb.PbList<GetReconciliationHistoryResponse> createRepeated() => $pb.PbList<GetReconciliationHistoryResponse>();
  @$core.pragma('dart2js:noInline')
  static GetReconciliationHistoryResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetReconciliationHistoryResponse>(create);
  static GetReconciliationHistoryResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<ReconciliationRun> get runs => $_getList(0);
}

class UserSummary extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UserSummary', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'email')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'phone')
    ..aInt64(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalGiftCardSales')
    ..a<$core.double>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'totalPayouts', $pb.PbFieldType.OD)
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt')
    ..hasRequiredFields = false
  ;

  UserSummary._() : super();
  factory UserSummary({
    $core.String? id,
    $core.String? name,
    $core.String? email,
    $core.String? phone,
    $fixnum.Int64? totalGiftCardSales,
    $core.double? totalPayouts,
    $core.String? createdAt,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (name != null) {
      _result.name = name;
    }
    if (email != null) {
      _result.email = email;
    }
    if (phone != null) {
      _result.phone = phone;
    }
    if (totalGiftCardSales != null) {
      _result.totalGiftCardSales = totalGiftCardSales;
    }
    if (totalPayouts != null) {
      _result.totalPayouts = totalPayouts;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    return _result;
  }
  factory UserSummary.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UserSummary.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UserSummary clone() => UserSummary()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UserSummary copyWith(void Function(UserSummary) updates) => super.copyWith((message) => updates(message as UserSummary)) as UserSummary; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UserSummary create() => UserSummary._();
  UserSummary createEmptyInstance() => create();
  static $pb.PbList<UserSummary> createRepeated() => $pb.PbList<UserSummary>();
  @$core.pragma('dart2js:noInline')
  static UserSummary getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UserSummary>(create);
  static UserSummary? _defaultInstance;

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
  $core.String get email => $_getSZ(2);
  @$pb.TagNumber(3)
  set email($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasEmail() => $_has(2);
  @$pb.TagNumber(3)
  void clearEmail() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get phone => $_getSZ(3);
  @$pb.TagNumber(4)
  set phone($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPhone() => $_has(3);
  @$pb.TagNumber(4)
  void clearPhone() => clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get totalGiftCardSales => $_getI64(4);
  @$pb.TagNumber(5)
  set totalGiftCardSales($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTotalGiftCardSales() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotalGiftCardSales() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get totalPayouts => $_getN(5);
  @$pb.TagNumber(6)
  set totalPayouts($core.double v) { $_setDouble(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasTotalPayouts() => $_has(5);
  @$pb.TagNumber(6)
  void clearTotalPayouts() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get createdAt => $_getSZ(6);
  @$pb.TagNumber(7)
  set createdAt($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasCreatedAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearCreatedAt() => clearField(7);
}

class LookupUserRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'LookupUserRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'query')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type')
    ..hasRequiredFields = false
  ;

  LookupUserRequest._() : super();
  factory LookupUserRequest({
    $core.String? query,
    $core.String? type,
  }) {
    final _result = create();
    if (query != null) {
      _result.query = query;
    }
    if (type != null) {
      _result.type = type;
    }
    return _result;
  }
  factory LookupUserRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LookupUserRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LookupUserRequest clone() => LookupUserRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LookupUserRequest copyWith(void Function(LookupUserRequest) updates) => super.copyWith((message) => updates(message as LookupUserRequest)) as LookupUserRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static LookupUserRequest create() => LookupUserRequest._();
  LookupUserRequest createEmptyInstance() => create();
  static $pb.PbList<LookupUserRequest> createRepeated() => $pb.PbList<LookupUserRequest>();
  @$core.pragma('dart2js:noInline')
  static LookupUserRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LookupUserRequest>(create);
  static LookupUserRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get query => $_getSZ(0);
  @$pb.TagNumber(1)
  set query($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasQuery() => $_has(0);
  @$pb.TagNumber(1)
  void clearQuery() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get type => $_getSZ(1);
  @$pb.TagNumber(2)
  set type($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasType() => $_has(1);
  @$pb.TagNumber(2)
  void clearType() => clearField(2);
}

class LookupUserResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'LookupUserResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..pc<UserSummary>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'users', $pb.PbFieldType.PM, subBuilder: UserSummary.create)
    ..hasRequiredFields = false
  ;

  LookupUserResponse._() : super();
  factory LookupUserResponse({
    $core.Iterable<UserSummary>? users,
  }) {
    final _result = create();
    if (users != null) {
      _result.users.addAll(users);
    }
    return _result;
  }
  factory LookupUserResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LookupUserResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LookupUserResponse clone() => LookupUserResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LookupUserResponse copyWith(void Function(LookupUserResponse) updates) => super.copyWith((message) => updates(message as LookupUserResponse)) as LookupUserResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static LookupUserResponse create() => LookupUserResponse._();
  LookupUserResponse createEmptyInstance() => create();
  static $pb.PbList<LookupUserResponse> createRepeated() => $pb.PbList<LookupUserResponse>();
  @$core.pragma('dart2js:noInline')
  static LookupUserResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LookupUserResponse>(create);
  static LookupUserResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<UserSummary> get users => $_getList(0);
}

class GetUserDetailsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetUserDetailsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..hasRequiredFields = false
  ;

  GetUserDetailsRequest._() : super();
  factory GetUserDetailsRequest({
    $core.String? userId,
  }) {
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    return _result;
  }
  factory GetUserDetailsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserDetailsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUserDetailsRequest clone() => GetUserDetailsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUserDetailsRequest copyWith(void Function(GetUserDetailsRequest) updates) => super.copyWith((message) => updates(message as GetUserDetailsRequest)) as GetUserDetailsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetUserDetailsRequest create() => GetUserDetailsRequest._();
  GetUserDetailsRequest createEmptyInstance() => create();
  static $pb.PbList<GetUserDetailsRequest> createRepeated() => $pb.PbList<GetUserDetailsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetUserDetailsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetUserDetailsRequest>(create);
  static GetUserDetailsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);
}

class GetUserDetailsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetUserDetailsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOM<UserSummary>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'user', subBuilder: UserSummary.create)
    ..pc<GiftCardSale>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recentSales', $pb.PbFieldType.PM, subBuilder: GiftCardSale.create)
    ..hasRequiredFields = false
  ;

  GetUserDetailsResponse._() : super();
  factory GetUserDetailsResponse({
    UserSummary? user,
    $core.Iterable<GiftCardSale>? recentSales,
  }) {
    final _result = create();
    if (user != null) {
      _result.user = user;
    }
    if (recentSales != null) {
      _result.recentSales.addAll(recentSales);
    }
    return _result;
  }
  factory GetUserDetailsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetUserDetailsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetUserDetailsResponse clone() => GetUserDetailsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetUserDetailsResponse copyWith(void Function(GetUserDetailsResponse) updates) => super.copyWith((message) => updates(message as GetUserDetailsResponse)) as GetUserDetailsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetUserDetailsResponse create() => GetUserDetailsResponse._();
  GetUserDetailsResponse createEmptyInstance() => create();
  static $pb.PbList<GetUserDetailsResponse> createRepeated() => $pb.PbList<GetUserDetailsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetUserDetailsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetUserDetailsResponse>(create);
  static GetUserDetailsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  UserSummary get user => $_getN(0);
  @$pb.TagNumber(1)
  set user(UserSummary v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasUser() => $_has(0);
  @$pb.TagNumber(1)
  void clearUser() => clearField(1);
  @$pb.TagNumber(1)
  UserSummary ensureUser() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.List<GiftCardSale> get recentSales => $_getList(1);
}

class AuditLogEntry extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AuditLogEntry', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'timestamp')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'admin')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'action')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'target')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'details')
    ..hasRequiredFields = false
  ;

  AuditLogEntry._() : super();
  factory AuditLogEntry({
    $core.String? id,
    $core.String? timestamp,
    $core.String? admin,
    $core.String? action,
    $core.String? target,
    $core.String? details,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (timestamp != null) {
      _result.timestamp = timestamp;
    }
    if (admin != null) {
      _result.admin = admin;
    }
    if (action != null) {
      _result.action = action;
    }
    if (target != null) {
      _result.target = target;
    }
    if (details != null) {
      _result.details = details;
    }
    return _result;
  }
  factory AuditLogEntry.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AuditLogEntry.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AuditLogEntry clone() => AuditLogEntry()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AuditLogEntry copyWith(void Function(AuditLogEntry) updates) => super.copyWith((message) => updates(message as AuditLogEntry)) as AuditLogEntry; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AuditLogEntry create() => AuditLogEntry._();
  AuditLogEntry createEmptyInstance() => create();
  static $pb.PbList<AuditLogEntry> createRepeated() => $pb.PbList<AuditLogEntry>();
  @$core.pragma('dart2js:noInline')
  static AuditLogEntry getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AuditLogEntry>(create);
  static AuditLogEntry? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get timestamp => $_getSZ(1);
  @$pb.TagNumber(2)
  set timestamp($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTimestamp() => $_has(1);
  @$pb.TagNumber(2)
  void clearTimestamp() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get admin => $_getSZ(2);
  @$pb.TagNumber(3)
  set admin($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAdmin() => $_has(2);
  @$pb.TagNumber(3)
  void clearAdmin() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get action => $_getSZ(3);
  @$pb.TagNumber(4)
  set action($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAction() => $_has(3);
  @$pb.TagNumber(4)
  void clearAction() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get target => $_getSZ(4);
  @$pb.TagNumber(5)
  set target($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTarget() => $_has(4);
  @$pb.TagNumber(5)
  void clearTarget() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get details => $_getSZ(5);
  @$pb.TagNumber(6)
  set details($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasDetails() => $_has(5);
  @$pb.TagNumber(6)
  void clearDetails() => clearField(6);
}

class SearchGiftCardTransactionRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SearchGiftCardTransactionRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reference')
    ..hasRequiredFields = false
  ;

  SearchGiftCardTransactionRequest._() : super();
  factory SearchGiftCardTransactionRequest({
    $core.String? reference,
  }) {
    final _result = create();
    if (reference != null) {
      _result.reference = reference;
    }
    return _result;
  }
  factory SearchGiftCardTransactionRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SearchGiftCardTransactionRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SearchGiftCardTransactionRequest clone() => SearchGiftCardTransactionRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SearchGiftCardTransactionRequest copyWith(void Function(SearchGiftCardTransactionRequest) updates) => super.copyWith((message) => updates(message as SearchGiftCardTransactionRequest)) as SearchGiftCardTransactionRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SearchGiftCardTransactionRequest create() => SearchGiftCardTransactionRequest._();
  SearchGiftCardTransactionRequest createEmptyInstance() => create();
  static $pb.PbList<SearchGiftCardTransactionRequest> createRepeated() => $pb.PbList<SearchGiftCardTransactionRequest>();
  @$core.pragma('dart2js:noInline')
  static SearchGiftCardTransactionRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SearchGiftCardTransactionRequest>(create);
  static SearchGiftCardTransactionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get reference => $_getSZ(0);
  @$pb.TagNumber(1)
  set reference($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasReference() => $_has(0);
  @$pb.TagNumber(1)
  void clearReference() => clearField(1);
}

class SearchGiftCardTransactionResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SearchGiftCardTransactionResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOM<GiftCardSale>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sale', subBuilder: GiftCardSale.create)
    ..pc<AuditLogEntry>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'events', $pb.PbFieldType.PM, subBuilder: AuditLogEntry.create)
    ..hasRequiredFields = false
  ;

  SearchGiftCardTransactionResponse._() : super();
  factory SearchGiftCardTransactionResponse({
    GiftCardSale? sale,
    $core.Iterable<AuditLogEntry>? events,
  }) {
    final _result = create();
    if (sale != null) {
      _result.sale = sale;
    }
    if (events != null) {
      _result.events.addAll(events);
    }
    return _result;
  }
  factory SearchGiftCardTransactionResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SearchGiftCardTransactionResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SearchGiftCardTransactionResponse clone() => SearchGiftCardTransactionResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SearchGiftCardTransactionResponse copyWith(void Function(SearchGiftCardTransactionResponse) updates) => super.copyWith((message) => updates(message as SearchGiftCardTransactionResponse)) as SearchGiftCardTransactionResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SearchGiftCardTransactionResponse create() => SearchGiftCardTransactionResponse._();
  SearchGiftCardTransactionResponse createEmptyInstance() => create();
  static $pb.PbList<SearchGiftCardTransactionResponse> createRepeated() => $pb.PbList<SearchGiftCardTransactionResponse>();
  @$core.pragma('dart2js:noInline')
  static SearchGiftCardTransactionResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SearchGiftCardTransactionResponse>(create);
  static SearchGiftCardTransactionResponse? _defaultInstance;

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
  $core.List<AuditLogEntry> get events => $_getList(1);
}

class BulkPerformManualOperationRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'BulkPerformManualOperationRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..pPS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionIds')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'operation')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reason')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'notes')
    ..hasRequiredFields = false
  ;

  BulkPerformManualOperationRequest._() : super();
  factory BulkPerformManualOperationRequest({
    $core.Iterable<$core.String>? transactionIds,
    $core.String? operation,
    $core.String? reason,
    $core.String? notes,
  }) {
    final _result = create();
    if (transactionIds != null) {
      _result.transactionIds.addAll(transactionIds);
    }
    if (operation != null) {
      _result.operation = operation;
    }
    if (reason != null) {
      _result.reason = reason;
    }
    if (notes != null) {
      _result.notes = notes;
    }
    return _result;
  }
  factory BulkPerformManualOperationRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BulkPerformManualOperationRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BulkPerformManualOperationRequest clone() => BulkPerformManualOperationRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BulkPerformManualOperationRequest copyWith(void Function(BulkPerformManualOperationRequest) updates) => super.copyWith((message) => updates(message as BulkPerformManualOperationRequest)) as BulkPerformManualOperationRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static BulkPerformManualOperationRequest create() => BulkPerformManualOperationRequest._();
  BulkPerformManualOperationRequest createEmptyInstance() => create();
  static $pb.PbList<BulkPerformManualOperationRequest> createRepeated() => $pb.PbList<BulkPerformManualOperationRequest>();
  @$core.pragma('dart2js:noInline')
  static BulkPerformManualOperationRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BulkPerformManualOperationRequest>(create);
  static BulkPerformManualOperationRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.String> get transactionIds => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get operation => $_getSZ(1);
  @$pb.TagNumber(2)
  set operation($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasOperation() => $_has(1);
  @$pb.TagNumber(2)
  void clearOperation() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get reason => $_getSZ(2);
  @$pb.TagNumber(3)
  set reason($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasReason() => $_has(2);
  @$pb.TagNumber(3)
  void clearReason() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get notes => $_getSZ(3);
  @$pb.TagNumber(4)
  set notes($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasNotes() => $_has(3);
  @$pb.TagNumber(4)
  void clearNotes() => clearField(4);
}

class BulkPerformManualOperationResult extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'BulkPerformManualOperationResult', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionId')
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'error')
    ..hasRequiredFields = false
  ;

  BulkPerformManualOperationResult._() : super();
  factory BulkPerformManualOperationResult({
    $core.String? transactionId,
    $core.bool? success,
    $core.String? error,
  }) {
    final _result = create();
    if (transactionId != null) {
      _result.transactionId = transactionId;
    }
    if (success != null) {
      _result.success = success;
    }
    if (error != null) {
      _result.error = error;
    }
    return _result;
  }
  factory BulkPerformManualOperationResult.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BulkPerformManualOperationResult.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BulkPerformManualOperationResult clone() => BulkPerformManualOperationResult()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BulkPerformManualOperationResult copyWith(void Function(BulkPerformManualOperationResult) updates) => super.copyWith((message) => updates(message as BulkPerformManualOperationResult)) as BulkPerformManualOperationResult; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static BulkPerformManualOperationResult create() => BulkPerformManualOperationResult._();
  BulkPerformManualOperationResult createEmptyInstance() => create();
  static $pb.PbList<BulkPerformManualOperationResult> createRepeated() => $pb.PbList<BulkPerformManualOperationResult>();
  @$core.pragma('dart2js:noInline')
  static BulkPerformManualOperationResult getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BulkPerformManualOperationResult>(create);
  static BulkPerformManualOperationResult? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get transactionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set transactionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTransactionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransactionId() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get error => $_getSZ(2);
  @$pb.TagNumber(3)
  set error($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasError() => $_has(2);
  @$pb.TagNumber(3)
  void clearError() => clearField(3);
}

class BulkPerformManualOperationResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'BulkPerformManualOperationResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..pc<BulkPerformManualOperationResult>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'results', $pb.PbFieldType.PM, subBuilder: BulkPerformManualOperationResult.create)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'succeeded', $pb.PbFieldType.O3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'failed', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  BulkPerformManualOperationResponse._() : super();
  factory BulkPerformManualOperationResponse({
    $core.Iterable<BulkPerformManualOperationResult>? results,
    $core.int? succeeded,
    $core.int? failed,
  }) {
    final _result = create();
    if (results != null) {
      _result.results.addAll(results);
    }
    if (succeeded != null) {
      _result.succeeded = succeeded;
    }
    if (failed != null) {
      _result.failed = failed;
    }
    return _result;
  }
  factory BulkPerformManualOperationResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BulkPerformManualOperationResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BulkPerformManualOperationResponse clone() => BulkPerformManualOperationResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BulkPerformManualOperationResponse copyWith(void Function(BulkPerformManualOperationResponse) updates) => super.copyWith((message) => updates(message as BulkPerformManualOperationResponse)) as BulkPerformManualOperationResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static BulkPerformManualOperationResponse create() => BulkPerformManualOperationResponse._();
  BulkPerformManualOperationResponse createEmptyInstance() => create();
  static $pb.PbList<BulkPerformManualOperationResponse> createRepeated() => $pb.PbList<BulkPerformManualOperationResponse>();
  @$core.pragma('dart2js:noInline')
  static BulkPerformManualOperationResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BulkPerformManualOperationResponse>(create);
  static BulkPerformManualOperationResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<BulkPerformManualOperationResult> get results => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get succeeded => $_getIZ(1);
  @$pb.TagNumber(2)
  set succeeded($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSucceeded() => $_has(1);
  @$pb.TagNumber(2)
  void clearSucceeded() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get failed => $_getIZ(2);
  @$pb.TagNumber(3)
  set failed($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasFailed() => $_has(2);
  @$pb.TagNumber(3)
  void clearFailed() => clearField(3);
}

class PerformManualOperationRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PerformManualOperationRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'operation')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reason')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'notes')
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amountOverride', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  PerformManualOperationRequest._() : super();
  factory PerformManualOperationRequest({
    $core.String? transactionId,
    $core.String? operation,
    $core.String? reason,
    $core.String? notes,
    $core.double? amountOverride,
  }) {
    final _result = create();
    if (transactionId != null) {
      _result.transactionId = transactionId;
    }
    if (operation != null) {
      _result.operation = operation;
    }
    if (reason != null) {
      _result.reason = reason;
    }
    if (notes != null) {
      _result.notes = notes;
    }
    if (amountOverride != null) {
      _result.amountOverride = amountOverride;
    }
    return _result;
  }
  factory PerformManualOperationRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PerformManualOperationRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PerformManualOperationRequest clone() => PerformManualOperationRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PerformManualOperationRequest copyWith(void Function(PerformManualOperationRequest) updates) => super.copyWith((message) => updates(message as PerformManualOperationRequest)) as PerformManualOperationRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PerformManualOperationRequest create() => PerformManualOperationRequest._();
  PerformManualOperationRequest createEmptyInstance() => create();
  static $pb.PbList<PerformManualOperationRequest> createRepeated() => $pb.PbList<PerformManualOperationRequest>();
  @$core.pragma('dart2js:noInline')
  static PerformManualOperationRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PerformManualOperationRequest>(create);
  static PerformManualOperationRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get transactionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set transactionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTransactionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransactionId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get operation => $_getSZ(1);
  @$pb.TagNumber(2)
  set operation($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasOperation() => $_has(1);
  @$pb.TagNumber(2)
  void clearOperation() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get reason => $_getSZ(2);
  @$pb.TagNumber(3)
  set reason($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasReason() => $_has(2);
  @$pb.TagNumber(3)
  void clearReason() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get notes => $_getSZ(3);
  @$pb.TagNumber(4)
  set notes($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasNotes() => $_has(3);
  @$pb.TagNumber(4)
  void clearNotes() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get amountOverride => $_getN(4);
  @$pb.TagNumber(5)
  set amountOverride($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasAmountOverride() => $_has(4);
  @$pb.TagNumber(5)
  void clearAmountOverride() => clearField(5);
}

class PerformManualOperationResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PerformManualOperationResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOM<GiftCardSale>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sale', subBuilder: GiftCardSale.create)
    ..hasRequiredFields = false
  ;

  PerformManualOperationResponse._() : super();
  factory PerformManualOperationResponse({
    $core.bool? success,
    $core.String? message,
    GiftCardSale? sale,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (sale != null) {
      _result.sale = sale;
    }
    return _result;
  }
  factory PerformManualOperationResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PerformManualOperationResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PerformManualOperationResponse clone() => PerformManualOperationResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PerformManualOperationResponse copyWith(void Function(PerformManualOperationResponse) updates) => super.copyWith((message) => updates(message as PerformManualOperationResponse)) as PerformManualOperationResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PerformManualOperationResponse create() => PerformManualOperationResponse._();
  PerformManualOperationResponse createEmptyInstance() => create();
  static $pb.PbList<PerformManualOperationResponse> createRepeated() => $pb.PbList<PerformManualOperationResponse>();
  @$core.pragma('dart2js:noInline')
  static PerformManualOperationResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PerformManualOperationResponse>(create);
  static PerformManualOperationResponse? _defaultInstance;

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
  GiftCardSale get sale => $_getN(2);
  @$pb.TagNumber(3)
  set sale(GiftCardSale v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasSale() => $_has(2);
  @$pb.TagNumber(3)
  void clearSale() => clearField(3);
  @$pb.TagNumber(3)
  GiftCardSale ensureSale() => $_ensure(2);
}

class GetGiftCardAuditLogRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetGiftCardAuditLogRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transactionId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetGiftCardAuditLogRequest._() : super();
  factory GetGiftCardAuditLogRequest({
    $core.String? transactionId,
    $core.String? userId,
    $core.int? page,
    $core.int? limit,
  }) {
    final _result = create();
    if (transactionId != null) {
      _result.transactionId = transactionId;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (page != null) {
      _result.page = page;
    }
    if (limit != null) {
      _result.limit = limit;
    }
    return _result;
  }
  factory GetGiftCardAuditLogRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetGiftCardAuditLogRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetGiftCardAuditLogRequest clone() => GetGiftCardAuditLogRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetGiftCardAuditLogRequest copyWith(void Function(GetGiftCardAuditLogRequest) updates) => super.copyWith((message) => updates(message as GetGiftCardAuditLogRequest)) as GetGiftCardAuditLogRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetGiftCardAuditLogRequest create() => GetGiftCardAuditLogRequest._();
  GetGiftCardAuditLogRequest createEmptyInstance() => create();
  static $pb.PbList<GetGiftCardAuditLogRequest> createRepeated() => $pb.PbList<GetGiftCardAuditLogRequest>();
  @$core.pragma('dart2js:noInline')
  static GetGiftCardAuditLogRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetGiftCardAuditLogRequest>(create);
  static GetGiftCardAuditLogRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get transactionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set transactionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTransactionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransactionId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => clearField(2);

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

class GetGiftCardAuditLogResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GetGiftCardAuditLogResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..pc<AuditLogEntry>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'logs', $pb.PbFieldType.PM, subBuilder: AuditLogEntry.create)
    ..aInt64(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'total')
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  GetGiftCardAuditLogResponse._() : super();
  factory GetGiftCardAuditLogResponse({
    $core.Iterable<AuditLogEntry>? logs,
    $fixnum.Int64? total,
    $core.int? page,
    $core.int? limit,
  }) {
    final _result = create();
    if (logs != null) {
      _result.logs.addAll(logs);
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
  factory GetGiftCardAuditLogResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetGiftCardAuditLogResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetGiftCardAuditLogResponse clone() => GetGiftCardAuditLogResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetGiftCardAuditLogResponse copyWith(void Function(GetGiftCardAuditLogResponse) updates) => super.copyWith((message) => updates(message as GetGiftCardAuditLogResponse)) as GetGiftCardAuditLogResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GetGiftCardAuditLogResponse create() => GetGiftCardAuditLogResponse._();
  GetGiftCardAuditLogResponse createEmptyInstance() => create();
  static $pb.PbList<GetGiftCardAuditLogResponse> createRepeated() => $pb.PbList<GetGiftCardAuditLogResponse>();
  @$core.pragma('dart2js:noInline')
  static GetGiftCardAuditLogResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetGiftCardAuditLogResponse>(create);
  static GetGiftCardAuditLogResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<AuditLogEntry> get logs => $_getList(0);

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

class SystemSetting extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SystemSetting', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'key')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'value')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'category')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedAt')
    ..hasRequiredFields = false
  ;

  SystemSetting._() : super();
  factory SystemSetting({
    $core.String? key,
    $core.String? value,
    $core.String? category,
    $core.String? description,
    $core.String? updatedAt,
  }) {
    final _result = create();
    if (key != null) {
      _result.key = key;
    }
    if (value != null) {
      _result.value = value;
    }
    if (category != null) {
      _result.category = category;
    }
    if (description != null) {
      _result.description = description;
    }
    if (updatedAt != null) {
      _result.updatedAt = updatedAt;
    }
    return _result;
  }
  factory SystemSetting.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SystemSetting.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SystemSetting clone() => SystemSetting()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SystemSetting copyWith(void Function(SystemSetting) updates) => super.copyWith((message) => updates(message as SystemSetting)) as SystemSetting; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SystemSetting create() => SystemSetting._();
  SystemSetting createEmptyInstance() => create();
  static $pb.PbList<SystemSetting> createRepeated() => $pb.PbList<SystemSetting>();
  @$core.pragma('dart2js:noInline')
  static SystemSetting getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SystemSetting>(create);
  static SystemSetting? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get key => $_getSZ(0);
  @$pb.TagNumber(1)
  set key($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearKey() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get value => $_getSZ(1);
  @$pb.TagNumber(2)
  set value($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearValue() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get category => $_getSZ(2);
  @$pb.TagNumber(3)
  set category($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCategory() => $_has(2);
  @$pb.TagNumber(3)
  void clearCategory() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get description => $_getSZ(3);
  @$pb.TagNumber(4)
  set description($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDescription() => $_has(3);
  @$pb.TagNumber(4)
  void clearDescription() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get updatedAt => $_getSZ(4);
  @$pb.TagNumber(5)
  set updatedAt($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasUpdatedAt() => $_has(4);
  @$pb.TagNumber(5)
  void clearUpdatedAt() => clearField(5);
}

class ListSystemSettingsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ListSystemSettingsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'category')
    ..hasRequiredFields = false
  ;

  ListSystemSettingsRequest._() : super();
  factory ListSystemSettingsRequest({
    $core.String? category,
  }) {
    final _result = create();
    if (category != null) {
      _result.category = category;
    }
    return _result;
  }
  factory ListSystemSettingsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListSystemSettingsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListSystemSettingsRequest clone() => ListSystemSettingsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListSystemSettingsRequest copyWith(void Function(ListSystemSettingsRequest) updates) => super.copyWith((message) => updates(message as ListSystemSettingsRequest)) as ListSystemSettingsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ListSystemSettingsRequest create() => ListSystemSettingsRequest._();
  ListSystemSettingsRequest createEmptyInstance() => create();
  static $pb.PbList<ListSystemSettingsRequest> createRepeated() => $pb.PbList<ListSystemSettingsRequest>();
  @$core.pragma('dart2js:noInline')
  static ListSystemSettingsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListSystemSettingsRequest>(create);
  static ListSystemSettingsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get category => $_getSZ(0);
  @$pb.TagNumber(1)
  set category($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCategory() => $_has(0);
  @$pb.TagNumber(1)
  void clearCategory() => clearField(1);
}

class ListSystemSettingsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ListSystemSettingsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..pc<SystemSetting>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'settings', $pb.PbFieldType.PM, subBuilder: SystemSetting.create)
    ..hasRequiredFields = false
  ;

  ListSystemSettingsResponse._() : super();
  factory ListSystemSettingsResponse({
    $core.Iterable<SystemSetting>? settings,
  }) {
    final _result = create();
    if (settings != null) {
      _result.settings.addAll(settings);
    }
    return _result;
  }
  factory ListSystemSettingsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListSystemSettingsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListSystemSettingsResponse clone() => ListSystemSettingsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListSystemSettingsResponse copyWith(void Function(ListSystemSettingsResponse) updates) => super.copyWith((message) => updates(message as ListSystemSettingsResponse)) as ListSystemSettingsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ListSystemSettingsResponse create() => ListSystemSettingsResponse._();
  ListSystemSettingsResponse createEmptyInstance() => create();
  static $pb.PbList<ListSystemSettingsResponse> createRepeated() => $pb.PbList<ListSystemSettingsResponse>();
  @$core.pragma('dart2js:noInline')
  static ListSystemSettingsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListSystemSettingsResponse>(create);
  static ListSystemSettingsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<SystemSetting> get settings => $_getList(0);
}

class UpdateSystemSettingRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateSystemSettingRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'key')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'value')
    ..hasRequiredFields = false
  ;

  UpdateSystemSettingRequest._() : super();
  factory UpdateSystemSettingRequest({
    $core.String? key,
    $core.String? value,
  }) {
    final _result = create();
    if (key != null) {
      _result.key = key;
    }
    if (value != null) {
      _result.value = value;
    }
    return _result;
  }
  factory UpdateSystemSettingRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateSystemSettingRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateSystemSettingRequest clone() => UpdateSystemSettingRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateSystemSettingRequest copyWith(void Function(UpdateSystemSettingRequest) updates) => super.copyWith((message) => updates(message as UpdateSystemSettingRequest)) as UpdateSystemSettingRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpdateSystemSettingRequest create() => UpdateSystemSettingRequest._();
  UpdateSystemSettingRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateSystemSettingRequest> createRepeated() => $pb.PbList<UpdateSystemSettingRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateSystemSettingRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateSystemSettingRequest>(create);
  static UpdateSystemSettingRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get key => $_getSZ(0);
  @$pb.TagNumber(1)
  set key($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearKey() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get value => $_getSZ(1);
  @$pb.TagNumber(2)
  set value($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearValue() => clearField(2);
}

class UpdateSystemSettingResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateSystemSettingResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOM<SystemSetting>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'setting', subBuilder: SystemSetting.create)
    ..hasRequiredFields = false
  ;

  UpdateSystemSettingResponse._() : super();
  factory UpdateSystemSettingResponse({
    $core.bool? success,
    $core.String? message,
    SystemSetting? setting,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (setting != null) {
      _result.setting = setting;
    }
    return _result;
  }
  factory UpdateSystemSettingResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateSystemSettingResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateSystemSettingResponse clone() => UpdateSystemSettingResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateSystemSettingResponse copyWith(void Function(UpdateSystemSettingResponse) updates) => super.copyWith((message) => updates(message as UpdateSystemSettingResponse)) as UpdateSystemSettingResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpdateSystemSettingResponse create() => UpdateSystemSettingResponse._();
  UpdateSystemSettingResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateSystemSettingResponse> createRepeated() => $pb.PbList<UpdateSystemSettingResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateSystemSettingResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateSystemSettingResponse>(create);
  static UpdateSystemSettingResponse? _defaultInstance;

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
  SystemSetting get setting => $_getN(2);
  @$pb.TagNumber(3)
  set setting(SystemSetting v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasSetting() => $_has(2);
  @$pb.TagNumber(3)
  void clearSetting() => clearField(3);
  @$pb.TagNumber(3)
  SystemSetting ensureSetting() => $_ensure(2);
}

