// This is a generated file - do not edit.
//
// Generated from giftcards.proto.

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

class GiftCard extends $pb.GeneratedMessage {
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
    final result = create();
    if (id != null) result.id = id;
    if (userId != null) result.userId = userId;
    if (accountId != null) result.accountId = accountId;
    if (brandId != null) result.brandId = brandId;
    if (brandName != null) result.brandName = brandName;
    if (originalAmount != null) result.originalAmount = originalAmount;
    if (currency != null) result.currency = currency;
    if (status != null) result.status = status;
    if (purchaseDate != null) result.purchaseDate = purchaseDate;
    if (expiryDate != null) result.expiryDate = expiryDate;
    if (recipientEmail != null) result.recipientEmail = recipientEmail;
    if (recipientName != null) result.recipientName = recipientName;
    if (message != null) result.message = message;
    if (metadata != null) result.metadata = metadata;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    if (providerTransactionId != null) result.providerTransactionId = providerTransactionId;
    if (redemptionCode != null) result.redemptionCode = redemptionCode;
    if (redemptionPin != null) result.redemptionPin = redemptionPin;
    if (countryCode != null) result.countryCode = countryCode;
    if (logoUrl != null) result.logoUrl = logoUrl;
    if (providerProductId != null) result.providerProductId = providerProductId;
    if (discountPercentage != null) result.discountPercentage = discountPercentage;
    if (senderAmount != null) result.senderAmount = senderAmount;
    if (senderCurrency != null) result.senderCurrency = senderCurrency;
    if (transferredFromId != null) result.transferredFromId = transferredFromId;
    if (senderUserId != null) result.senderUserId = senderUserId;
    if (transferType != null) result.transferType = transferType;
    if (redemptionInstructions != null) result.redemptionInstructions = redemptionInstructions;
    return result;
  }

  GiftCard._();

  factory GiftCard.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GiftCard.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GiftCard', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'accountId')
    ..aOS(4, _omitFieldNames ? '' : 'brandId')
    ..aOS(5, _omitFieldNames ? '' : 'brandName')
    ..a<$core.double>(8, _omitFieldNames ? '' : 'originalAmount', $pb.PbFieldType.OD)
    ..aOS(10, _omitFieldNames ? '' : 'currency')
    ..aOS(11, _omitFieldNames ? '' : 'status')
    ..aOS(12, _omitFieldNames ? '' : 'purchaseDate')
    ..aOS(13, _omitFieldNames ? '' : 'expiryDate')
    ..aOS(14, _omitFieldNames ? '' : 'recipientEmail')
    ..aOS(15, _omitFieldNames ? '' : 'recipientName')
    ..aOS(16, _omitFieldNames ? '' : 'message')
    ..aOS(18, _omitFieldNames ? '' : 'metadata')
    ..aOS(19, _omitFieldNames ? '' : 'createdAt')
    ..aOS(20, _omitFieldNames ? '' : 'updatedAt')
    ..aOS(21, _omitFieldNames ? '' : 'providerTransactionId')
    ..aOS(22, _omitFieldNames ? '' : 'redemptionCode')
    ..aOS(23, _omitFieldNames ? '' : 'redemptionPin')
    ..aOS(24, _omitFieldNames ? '' : 'countryCode')
    ..aOS(25, _omitFieldNames ? '' : 'logoUrl')
    ..aInt64(26, _omitFieldNames ? '' : 'providerProductId')
    ..a<$core.double>(27, _omitFieldNames ? '' : 'discountPercentage', $pb.PbFieldType.OD)
    ..a<$core.double>(28, _omitFieldNames ? '' : 'senderAmount', $pb.PbFieldType.OD)
    ..aOS(29, _omitFieldNames ? '' : 'senderCurrency')
    ..aOS(30, _omitFieldNames ? '' : 'transferredFromId')
    ..aOS(31, _omitFieldNames ? '' : 'senderUserId')
    ..aOS(32, _omitFieldNames ? '' : 'transferType')
    ..aOS(33, _omitFieldNames ? '' : 'redemptionInstructions')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GiftCard clone() => GiftCard()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GiftCard copyWith(void Function(GiftCard) updates) => super.copyWith((message) => updates(message as GiftCard)) as GiftCard;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GiftCard create() => GiftCard._();
  @$core.override
  GiftCard createEmptyInstance() => create();
  static $pb.PbList<GiftCard> createRepeated() => $pb.PbList<GiftCard>();
  @$core.pragma('dart2js:noInline')
  static GiftCard getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GiftCard>(create);
  static GiftCard? _defaultInstance;

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
  $core.String get brandId => $_getSZ(3);
  @$pb.TagNumber(4)
  set brandId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasBrandId() => $_has(3);
  @$pb.TagNumber(4)
  void clearBrandId() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get brandName => $_getSZ(4);
  @$pb.TagNumber(5)
  set brandName($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasBrandName() => $_has(4);
  @$pb.TagNumber(5)
  void clearBrandName() => $_clearField(5);

  @$pb.TagNumber(8)
  $core.double get originalAmount => $_getN(5);
  @$pb.TagNumber(8)
  set originalAmount($core.double value) => $_setDouble(5, value);
  @$pb.TagNumber(8)
  $core.bool hasOriginalAmount() => $_has(5);
  @$pb.TagNumber(8)
  void clearOriginalAmount() => $_clearField(8);

  @$pb.TagNumber(10)
  $core.String get currency => $_getSZ(6);
  @$pb.TagNumber(10)
  set currency($core.String value) => $_setString(6, value);
  @$pb.TagNumber(10)
  $core.bool hasCurrency() => $_has(6);
  @$pb.TagNumber(10)
  void clearCurrency() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get status => $_getSZ(7);
  @$pb.TagNumber(11)
  set status($core.String value) => $_setString(7, value);
  @$pb.TagNumber(11)
  $core.bool hasStatus() => $_has(7);
  @$pb.TagNumber(11)
  void clearStatus() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get purchaseDate => $_getSZ(8);
  @$pb.TagNumber(12)
  set purchaseDate($core.String value) => $_setString(8, value);
  @$pb.TagNumber(12)
  $core.bool hasPurchaseDate() => $_has(8);
  @$pb.TagNumber(12)
  void clearPurchaseDate() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get expiryDate => $_getSZ(9);
  @$pb.TagNumber(13)
  set expiryDate($core.String value) => $_setString(9, value);
  @$pb.TagNumber(13)
  $core.bool hasExpiryDate() => $_has(9);
  @$pb.TagNumber(13)
  void clearExpiryDate() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.String get recipientEmail => $_getSZ(10);
  @$pb.TagNumber(14)
  set recipientEmail($core.String value) => $_setString(10, value);
  @$pb.TagNumber(14)
  $core.bool hasRecipientEmail() => $_has(10);
  @$pb.TagNumber(14)
  void clearRecipientEmail() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.String get recipientName => $_getSZ(11);
  @$pb.TagNumber(15)
  set recipientName($core.String value) => $_setString(11, value);
  @$pb.TagNumber(15)
  $core.bool hasRecipientName() => $_has(11);
  @$pb.TagNumber(15)
  void clearRecipientName() => $_clearField(15);

  @$pb.TagNumber(16)
  $core.String get message => $_getSZ(12);
  @$pb.TagNumber(16)
  set message($core.String value) => $_setString(12, value);
  @$pb.TagNumber(16)
  $core.bool hasMessage() => $_has(12);
  @$pb.TagNumber(16)
  void clearMessage() => $_clearField(16);

  @$pb.TagNumber(18)
  $core.String get metadata => $_getSZ(13);
  @$pb.TagNumber(18)
  set metadata($core.String value) => $_setString(13, value);
  @$pb.TagNumber(18)
  $core.bool hasMetadata() => $_has(13);
  @$pb.TagNumber(18)
  void clearMetadata() => $_clearField(18);

  @$pb.TagNumber(19)
  $core.String get createdAt => $_getSZ(14);
  @$pb.TagNumber(19)
  set createdAt($core.String value) => $_setString(14, value);
  @$pb.TagNumber(19)
  $core.bool hasCreatedAt() => $_has(14);
  @$pb.TagNumber(19)
  void clearCreatedAt() => $_clearField(19);

  @$pb.TagNumber(20)
  $core.String get updatedAt => $_getSZ(15);
  @$pb.TagNumber(20)
  set updatedAt($core.String value) => $_setString(15, value);
  @$pb.TagNumber(20)
  $core.bool hasUpdatedAt() => $_has(15);
  @$pb.TagNumber(20)
  void clearUpdatedAt() => $_clearField(20);

  /// Reloadly provider fields — the actual gift card data from the provider
  @$pb.TagNumber(21)
  $core.String get providerTransactionId => $_getSZ(16);
  @$pb.TagNumber(21)
  set providerTransactionId($core.String value) => $_setString(16, value);
  @$pb.TagNumber(21)
  $core.bool hasProviderTransactionId() => $_has(16);
  @$pb.TagNumber(21)
  void clearProviderTransactionId() => $_clearField(21);

  @$pb.TagNumber(22)
  $core.String get redemptionCode => $_getSZ(17);
  @$pb.TagNumber(22)
  set redemptionCode($core.String value) => $_setString(17, value);
  @$pb.TagNumber(22)
  $core.bool hasRedemptionCode() => $_has(17);
  @$pb.TagNumber(22)
  void clearRedemptionCode() => $_clearField(22);

  @$pb.TagNumber(23)
  $core.String get redemptionPin => $_getSZ(18);
  @$pb.TagNumber(23)
  set redemptionPin($core.String value) => $_setString(18, value);
  @$pb.TagNumber(23)
  $core.bool hasRedemptionPin() => $_has(18);
  @$pb.TagNumber(23)
  void clearRedemptionPin() => $_clearField(23);

  @$pb.TagNumber(24)
  $core.String get countryCode => $_getSZ(19);
  @$pb.TagNumber(24)
  set countryCode($core.String value) => $_setString(19, value);
  @$pb.TagNumber(24)
  $core.bool hasCountryCode() => $_has(19);
  @$pb.TagNumber(24)
  void clearCountryCode() => $_clearField(24);

  @$pb.TagNumber(25)
  $core.String get logoUrl => $_getSZ(20);
  @$pb.TagNumber(25)
  set logoUrl($core.String value) => $_setString(20, value);
  @$pb.TagNumber(25)
  $core.bool hasLogoUrl() => $_has(20);
  @$pb.TagNumber(25)
  void clearLogoUrl() => $_clearField(25);

  @$pb.TagNumber(26)
  $fixnum.Int64 get providerProductId => $_getI64(21);
  @$pb.TagNumber(26)
  set providerProductId($fixnum.Int64 value) => $_setInt64(21, value);
  @$pb.TagNumber(26)
  $core.bool hasProviderProductId() => $_has(21);
  @$pb.TagNumber(26)
  void clearProviderProductId() => $_clearField(26);

  @$pb.TagNumber(27)
  $core.double get discountPercentage => $_getN(22);
  @$pb.TagNumber(27)
  set discountPercentage($core.double value) => $_setDouble(22, value);
  @$pb.TagNumber(27)
  $core.bool hasDiscountPercentage() => $_has(22);
  @$pb.TagNumber(27)
  void clearDiscountPercentage() => $_clearField(27);

  /// Payment (sender) currency fields — what was actually charged
  @$pb.TagNumber(28)
  $core.double get senderAmount => $_getN(23);
  @$pb.TagNumber(28)
  set senderAmount($core.double value) => $_setDouble(23, value);
  @$pb.TagNumber(28)
  $core.bool hasSenderAmount() => $_has(23);
  @$pb.TagNumber(28)
  void clearSenderAmount() => $_clearField(28);

  @$pb.TagNumber(29)
  $core.String get senderCurrency => $_getSZ(24);
  @$pb.TagNumber(29)
  set senderCurrency($core.String value) => $_setString(24, value);
  @$pb.TagNumber(29)
  $core.bool hasSenderCurrency() => $_has(24);
  @$pb.TagNumber(29)
  void clearSenderCurrency() => $_clearField(29);

  /// Platform transfer tracking
  @$pb.TagNumber(30)
  $core.String get transferredFromId => $_getSZ(25);
  @$pb.TagNumber(30)
  set transferredFromId($core.String value) => $_setString(25, value);
  @$pb.TagNumber(30)
  $core.bool hasTransferredFromId() => $_has(25);
  @$pb.TagNumber(30)
  void clearTransferredFromId() => $_clearField(30);

  @$pb.TagNumber(31)
  $core.String get senderUserId => $_getSZ(26);
  @$pb.TagNumber(31)
  set senderUserId($core.String value) => $_setString(26, value);
  @$pb.TagNumber(31)
  $core.bool hasSenderUserId() => $_has(26);
  @$pb.TagNumber(31)
  void clearSenderUserId() => $_clearField(31);

  @$pb.TagNumber(32)
  $core.String get transferType => $_getSZ(27);
  @$pb.TagNumber(32)
  set transferType($core.String value) => $_setString(27, value);
  @$pb.TagNumber(32)
  $core.bool hasTransferType() => $_has(27);
  @$pb.TagNumber(32)
  void clearTransferType() => $_clearField(32);

  /// Redemption instructions from Reloadly (how to use the code on the merchant's website)
  @$pb.TagNumber(33)
  $core.String get redemptionInstructions => $_getSZ(28);
  @$pb.TagNumber(33)
  set redemptionInstructions($core.String value) => $_setString(28, value);
  @$pb.TagNumber(33)
  $core.bool hasRedemptionInstructions() => $_has(28);
  @$pb.TagNumber(33)
  void clearRedemptionInstructions() => $_clearField(33);
}

class GiftCardBrand extends $pb.GeneratedMessage {
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
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (logoUrl != null) result.logoUrl = logoUrl;
    if (category != null) result.category = category;
    if (description != null) result.description = description;
    if (denominations != null) result.denominations.addAll(denominations);
    if (minAmount != null) result.minAmount = minAmount;
    if (maxAmount != null) result.maxAmount = maxAmount;
    if (isActive != null) result.isActive = isActive;
    if (termsAndConditions != null) result.termsAndConditions = termsAndConditions;
    if (productId != null) result.productId = productId;
    if (countryCode != null) result.countryCode = countryCode;
    if (fixedDenominations != null) result.fixedDenominations.addAll(fixedDenominations);
    if (discountPercentage != null) result.discountPercentage = discountPercentage;
    if (currencyCode != null) result.currencyCode = currencyCode;
    if (redemptionInstructions != null) result.redemptionInstructions = redemptionInstructions;
    if (providerName != null) result.providerName = providerName;
    if (senderCurrencyCode != null) result.senderCurrencyCode = senderCurrencyCode;
    if (senderDenominations != null) result.senderDenominations.addAll(senderDenominations);
    if (minSenderAmount != null) result.minSenderAmount = minSenderAmount;
    if (maxSenderAmount != null) result.maxSenderAmount = maxSenderAmount;
    if (senderFee != null) result.senderFee = senderFee;
    if (senderFeePercentage != null) result.senderFeePercentage = senderFeePercentage;
    if (fixedSenderDenominations != null) result.fixedSenderDenominations.addAll(fixedSenderDenominations);
    return result;
  }

  GiftCardBrand._();

  factory GiftCardBrand.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GiftCardBrand.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GiftCardBrand', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'logoUrl')
    ..aOS(4, _omitFieldNames ? '' : 'category')
    ..aOS(5, _omitFieldNames ? '' : 'description')
    ..p<$core.double>(6, _omitFieldNames ? '' : 'denominations', $pb.PbFieldType.KD)
    ..a<$core.double>(7, _omitFieldNames ? '' : 'minAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(8, _omitFieldNames ? '' : 'maxAmount', $pb.PbFieldType.OD)
    ..aOB(9, _omitFieldNames ? '' : 'isActive')
    ..aOS(10, _omitFieldNames ? '' : 'termsAndConditions')
    ..aInt64(11, _omitFieldNames ? '' : 'productId')
    ..aOS(12, _omitFieldNames ? '' : 'countryCode')
    ..pc<GiftCardDenomination>(13, _omitFieldNames ? '' : 'fixedDenominations', $pb.PbFieldType.PM, subBuilder: GiftCardDenomination.create)
    ..a<$core.double>(14, _omitFieldNames ? '' : 'discountPercentage', $pb.PbFieldType.OD)
    ..aOS(15, _omitFieldNames ? '' : 'currencyCode')
    ..aOS(16, _omitFieldNames ? '' : 'redemptionInstructions')
    ..aOS(17, _omitFieldNames ? '' : 'providerName')
    ..aOS(18, _omitFieldNames ? '' : 'senderCurrencyCode')
    ..p<$core.double>(19, _omitFieldNames ? '' : 'senderDenominations', $pb.PbFieldType.KD)
    ..a<$core.double>(20, _omitFieldNames ? '' : 'minSenderAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(21, _omitFieldNames ? '' : 'maxSenderAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(22, _omitFieldNames ? '' : 'senderFee', $pb.PbFieldType.OD)
    ..a<$core.double>(23, _omitFieldNames ? '' : 'senderFeePercentage', $pb.PbFieldType.OD)
    ..pc<GiftCardDenomination>(24, _omitFieldNames ? '' : 'fixedSenderDenominations', $pb.PbFieldType.PM, subBuilder: GiftCardDenomination.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GiftCardBrand clone() => GiftCardBrand()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GiftCardBrand copyWith(void Function(GiftCardBrand) updates) => super.copyWith((message) => updates(message as GiftCardBrand)) as GiftCardBrand;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GiftCardBrand create() => GiftCardBrand._();
  @$core.override
  GiftCardBrand createEmptyInstance() => create();
  static $pb.PbList<GiftCardBrand> createRepeated() => $pb.PbList<GiftCardBrand>();
  @$core.pragma('dart2js:noInline')
  static GiftCardBrand getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GiftCardBrand>(create);
  static GiftCardBrand? _defaultInstance;

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
  $core.String get logoUrl => $_getSZ(2);
  @$pb.TagNumber(3)
  set logoUrl($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLogoUrl() => $_has(2);
  @$pb.TagNumber(3)
  void clearLogoUrl() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get category => $_getSZ(3);
  @$pb.TagNumber(4)
  set category($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCategory() => $_has(3);
  @$pb.TagNumber(4)
  void clearCategory() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get description => $_getSZ(4);
  @$pb.TagNumber(5)
  set description($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasDescription() => $_has(4);
  @$pb.TagNumber(5)
  void clearDescription() => $_clearField(5);

  @$pb.TagNumber(6)
  $pb.PbList<$core.double> get denominations => $_getList(5);

  @$pb.TagNumber(7)
  $core.double get minAmount => $_getN(6);
  @$pb.TagNumber(7)
  set minAmount($core.double value) => $_setDouble(6, value);
  @$pb.TagNumber(7)
  $core.bool hasMinAmount() => $_has(6);
  @$pb.TagNumber(7)
  void clearMinAmount() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.double get maxAmount => $_getN(7);
  @$pb.TagNumber(8)
  set maxAmount($core.double value) => $_setDouble(7, value);
  @$pb.TagNumber(8)
  $core.bool hasMaxAmount() => $_has(7);
  @$pb.TagNumber(8)
  void clearMaxAmount() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.bool get isActive => $_getBF(8);
  @$pb.TagNumber(9)
  set isActive($core.bool value) => $_setBool(8, value);
  @$pb.TagNumber(9)
  $core.bool hasIsActive() => $_has(8);
  @$pb.TagNumber(9)
  void clearIsActive() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get termsAndConditions => $_getSZ(9);
  @$pb.TagNumber(10)
  set termsAndConditions($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasTermsAndConditions() => $_has(9);
  @$pb.TagNumber(10)
  void clearTermsAndConditions() => $_clearField(10);

  /// Reloadly fields
  @$pb.TagNumber(11)
  $fixnum.Int64 get productId => $_getI64(10);
  @$pb.TagNumber(11)
  set productId($fixnum.Int64 value) => $_setInt64(10, value);
  @$pb.TagNumber(11)
  $core.bool hasProductId() => $_has(10);
  @$pb.TagNumber(11)
  void clearProductId() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get countryCode => $_getSZ(11);
  @$pb.TagNumber(12)
  set countryCode($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasCountryCode() => $_has(11);
  @$pb.TagNumber(12)
  void clearCountryCode() => $_clearField(12);

  @$pb.TagNumber(13)
  $pb.PbList<GiftCardDenomination> get fixedDenominations => $_getList(12);

  @$pb.TagNumber(14)
  $core.double get discountPercentage => $_getN(13);
  @$pb.TagNumber(14)
  set discountPercentage($core.double value) => $_setDouble(13, value);
  @$pb.TagNumber(14)
  $core.bool hasDiscountPercentage() => $_has(13);
  @$pb.TagNumber(14)
  void clearDiscountPercentage() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.String get currencyCode => $_getSZ(14);
  @$pb.TagNumber(15)
  set currencyCode($core.String value) => $_setString(14, value);
  @$pb.TagNumber(15)
  $core.bool hasCurrencyCode() => $_has(14);
  @$pb.TagNumber(15)
  void clearCurrencyCode() => $_clearField(15);

  @$pb.TagNumber(16)
  $core.String get redemptionInstructions => $_getSZ(15);
  @$pb.TagNumber(16)
  set redemptionInstructions($core.String value) => $_setString(15, value);
  @$pb.TagNumber(16)
  $core.bool hasRedemptionInstructions() => $_has(15);
  @$pb.TagNumber(16)
  void clearRedemptionInstructions() => $_clearField(16);

  /// Provider consistency tracking
  @$pb.TagNumber(17)
  $core.String get providerName => $_getSZ(16);
  @$pb.TagNumber(17)
  set providerName($core.String value) => $_setString(16, value);
  @$pb.TagNumber(17)
  $core.bool hasProviderName() => $_has(16);
  @$pb.TagNumber(17)
  void clearProviderName() => $_clearField(17);

  /// Sender (payment) currency fields — what the user actually pays
  @$pb.TagNumber(18)
  $core.String get senderCurrencyCode => $_getSZ(17);
  @$pb.TagNumber(18)
  set senderCurrencyCode($core.String value) => $_setString(17, value);
  @$pb.TagNumber(18)
  $core.bool hasSenderCurrencyCode() => $_has(17);
  @$pb.TagNumber(18)
  void clearSenderCurrencyCode() => $_clearField(18);

  @$pb.TagNumber(19)
  $pb.PbList<$core.double> get senderDenominations => $_getList(18);

  @$pb.TagNumber(20)
  $core.double get minSenderAmount => $_getN(19);
  @$pb.TagNumber(20)
  set minSenderAmount($core.double value) => $_setDouble(19, value);
  @$pb.TagNumber(20)
  $core.bool hasMinSenderAmount() => $_has(19);
  @$pb.TagNumber(20)
  void clearMinSenderAmount() => $_clearField(20);

  @$pb.TagNumber(21)
  $core.double get maxSenderAmount => $_getN(20);
  @$pb.TagNumber(21)
  set maxSenderAmount($core.double value) => $_setDouble(20, value);
  @$pb.TagNumber(21)
  $core.bool hasMaxSenderAmount() => $_has(20);
  @$pb.TagNumber(21)
  void clearMaxSenderAmount() => $_clearField(21);

  @$pb.TagNumber(22)
  $core.double get senderFee => $_getN(21);
  @$pb.TagNumber(22)
  set senderFee($core.double value) => $_setDouble(21, value);
  @$pb.TagNumber(22)
  $core.bool hasSenderFee() => $_has(21);
  @$pb.TagNumber(22)
  void clearSenderFee() => $_clearField(22);

  @$pb.TagNumber(23)
  $core.double get senderFeePercentage => $_getN(22);
  @$pb.TagNumber(23)
  set senderFeePercentage($core.double value) => $_setDouble(22, value);
  @$pb.TagNumber(23)
  $core.bool hasSenderFeePercentage() => $_has(22);
  @$pb.TagNumber(23)
  void clearSenderFeePercentage() => $_clearField(23);

  /// Fixed sender denomination objects (paired with recipient denominations)
  @$pb.TagNumber(24)
  $pb.PbList<GiftCardDenomination> get fixedSenderDenominations => $_getList(23);
}

/// Fixed denomination from Reloadly
class GiftCardDenomination extends $pb.GeneratedMessage {
  factory GiftCardDenomination({
    $core.double? price,
    $core.String? currencyCode,
  }) {
    final result = create();
    if (price != null) result.price = price;
    if (currencyCode != null) result.currencyCode = currencyCode;
    return result;
  }

  GiftCardDenomination._();

  factory GiftCardDenomination.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GiftCardDenomination.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GiftCardDenomination', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'price', $pb.PbFieldType.OD)
    ..aOS(2, _omitFieldNames ? '' : 'currencyCode')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GiftCardDenomination clone() => GiftCardDenomination()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GiftCardDenomination copyWith(void Function(GiftCardDenomination) updates) => super.copyWith((message) => updates(message as GiftCardDenomination)) as GiftCardDenomination;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GiftCardDenomination create() => GiftCardDenomination._();
  @$core.override
  GiftCardDenomination createEmptyInstance() => create();
  static $pb.PbList<GiftCardDenomination> createRepeated() => $pb.PbList<GiftCardDenomination>();
  @$core.pragma('dart2js:noInline')
  static GiftCardDenomination getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GiftCardDenomination>(create);
  static GiftCardDenomination? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get price => $_getN(0);
  @$pb.TagNumber(1)
  set price($core.double value) => $_setDouble(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPrice() => $_has(0);
  @$pb.TagNumber(1)
  void clearPrice() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get currencyCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set currencyCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCurrencyCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearCurrencyCode() => $_clearField(2);
}

class GiftCardTransaction extends $pb.GeneratedMessage {
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
    final result = create();
    if (id != null) result.id = id;
    if (giftCardId != null) result.giftCardId = giftCardId;
    if (userId != null) result.userId = userId;
    if (transactionType != null) result.transactionType = transactionType;
    if (amount != null) result.amount = amount;
    if (balanceBefore != null) result.balanceBefore = balanceBefore;
    if (balanceAfter != null) result.balanceAfter = balanceAfter;
    if (description != null) result.description = description;
    if (createdAt != null) result.createdAt = createdAt;
    if (providerTransactionId != null) result.providerTransactionId = providerTransactionId;
    if (reference != null) result.reference = reference;
    return result;
  }

  GiftCardTransaction._();

  factory GiftCardTransaction.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GiftCardTransaction.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GiftCardTransaction', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'giftCardId')
    ..aOS(3, _omitFieldNames ? '' : 'userId')
    ..aOS(4, _omitFieldNames ? '' : 'transactionType')
    ..a<$core.double>(5, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..a<$core.double>(6, _omitFieldNames ? '' : 'balanceBefore', $pb.PbFieldType.OD)
    ..a<$core.double>(7, _omitFieldNames ? '' : 'balanceAfter', $pb.PbFieldType.OD)
    ..aOS(8, _omitFieldNames ? '' : 'description')
    ..aOS(9, _omitFieldNames ? '' : 'createdAt')
    ..aOS(10, _omitFieldNames ? '' : 'providerTransactionId')
    ..aOS(11, _omitFieldNames ? '' : 'reference')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GiftCardTransaction clone() => GiftCardTransaction()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GiftCardTransaction copyWith(void Function(GiftCardTransaction) updates) => super.copyWith((message) => updates(message as GiftCardTransaction)) as GiftCardTransaction;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GiftCardTransaction create() => GiftCardTransaction._();
  @$core.override
  GiftCardTransaction createEmptyInstance() => create();
  static $pb.PbList<GiftCardTransaction> createRepeated() => $pb.PbList<GiftCardTransaction>();
  @$core.pragma('dart2js:noInline')
  static GiftCardTransaction getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GiftCardTransaction>(create);
  static GiftCardTransaction? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get giftCardId => $_getSZ(1);
  @$pb.TagNumber(2)
  set giftCardId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasGiftCardId() => $_has(1);
  @$pb.TagNumber(2)
  void clearGiftCardId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get userId => $_getSZ(2);
  @$pb.TagNumber(3)
  set userId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasUserId() => $_has(2);
  @$pb.TagNumber(3)
  void clearUserId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get transactionType => $_getSZ(3);
  @$pb.TagNumber(4)
  set transactionType($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTransactionType() => $_has(3);
  @$pb.TagNumber(4)
  void clearTransactionType() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get amount => $_getN(4);
  @$pb.TagNumber(5)
  set amount($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearAmount() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.double get balanceBefore => $_getN(5);
  @$pb.TagNumber(6)
  set balanceBefore($core.double value) => $_setDouble(5, value);
  @$pb.TagNumber(6)
  $core.bool hasBalanceBefore() => $_has(5);
  @$pb.TagNumber(6)
  void clearBalanceBefore() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.double get balanceAfter => $_getN(6);
  @$pb.TagNumber(7)
  set balanceAfter($core.double value) => $_setDouble(6, value);
  @$pb.TagNumber(7)
  $core.bool hasBalanceAfter() => $_has(6);
  @$pb.TagNumber(7)
  void clearBalanceAfter() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get description => $_getSZ(7);
  @$pb.TagNumber(8)
  set description($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasDescription() => $_has(7);
  @$pb.TagNumber(8)
  void clearDescription() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get createdAt => $_getSZ(8);
  @$pb.TagNumber(9)
  set createdAt($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasCreatedAt() => $_has(8);
  @$pb.TagNumber(9)
  void clearCreatedAt() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get providerTransactionId => $_getSZ(9);
  @$pb.TagNumber(10)
  set providerTransactionId($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasProviderTransactionId() => $_has(9);
  @$pb.TagNumber(10)
  void clearProviderTransactionId() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get reference => $_getSZ(10);
  @$pb.TagNumber(11)
  set reference($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasReference() => $_has(10);
  @$pb.TagNumber(11)
  void clearReference() => $_clearField(11);
}

/// ===== BUY GIFT CARD =====
/// NOTE: user_id extracted from JWT token, not from request
class BuyGiftCardRequest extends $pb.GeneratedMessage {
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
    final result = create();
    if (accountId != null) result.accountId = accountId;
    if (brandId != null) result.brandId = brandId;
    if (amount != null) result.amount = amount;
    if (recipientEmail != null) result.recipientEmail = recipientEmail;
    if (recipientName != null) result.recipientName = recipientName;
    if (giftMessage != null) result.giftMessage = giftMessage;
    if (transactionId != null) result.transactionId = transactionId;
    if (verificationToken != null) result.verificationToken = verificationToken;
    if (idempotencyKey != null) result.idempotencyKey = idempotencyKey;
    if (senderName != null) result.senderName = senderName;
    if (recipientPhone != null) result.recipientPhone = recipientPhone;
    if (productId != null) result.productId = productId;
    if (countryCode != null) result.countryCode = countryCode;
    if (quantity != null) result.quantity = quantity;
    if (providerName != null) result.providerName = providerName;
    if (senderAmount != null) result.senderAmount = senderAmount;
    if (senderCurrency != null) result.senderCurrency = senderCurrency;
    return result;
  }

  BuyGiftCardRequest._();

  factory BuyGiftCardRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory BuyGiftCardRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'BuyGiftCardRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..aOS(2, _omitFieldNames ? '' : 'brandId')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(4, _omitFieldNames ? '' : 'recipientEmail')
    ..aOS(5, _omitFieldNames ? '' : 'recipientName')
    ..aOS(6, _omitFieldNames ? '' : 'giftMessage')
    ..aOS(7, _omitFieldNames ? '' : 'transactionId')
    ..aOS(8, _omitFieldNames ? '' : 'verificationToken')
    ..aOS(9, _omitFieldNames ? '' : 'idempotencyKey')
    ..aOS(10, _omitFieldNames ? '' : 'senderName')
    ..aOS(11, _omitFieldNames ? '' : 'recipientPhone')
    ..aInt64(12, _omitFieldNames ? '' : 'productId')
    ..aOS(13, _omitFieldNames ? '' : 'countryCode')
    ..a<$core.int>(14, _omitFieldNames ? '' : 'quantity', $pb.PbFieldType.O3)
    ..aOS(15, _omitFieldNames ? '' : 'providerName')
    ..a<$core.double>(16, _omitFieldNames ? '' : 'senderAmount', $pb.PbFieldType.OD)
    ..aOS(17, _omitFieldNames ? '' : 'senderCurrency')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BuyGiftCardRequest clone() => BuyGiftCardRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BuyGiftCardRequest copyWith(void Function(BuyGiftCardRequest) updates) => super.copyWith((message) => updates(message as BuyGiftCardRequest)) as BuyGiftCardRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BuyGiftCardRequest create() => BuyGiftCardRequest._();
  @$core.override
  BuyGiftCardRequest createEmptyInstance() => create();
  static $pb.PbList<BuyGiftCardRequest> createRepeated() => $pb.PbList<BuyGiftCardRequest>();
  @$core.pragma('dart2js:noInline')
  static BuyGiftCardRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BuyGiftCardRequest>(create);
  static BuyGiftCardRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get brandId => $_getSZ(1);
  @$pb.TagNumber(2)
  set brandId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasBrandId() => $_has(1);
  @$pb.TagNumber(2)
  void clearBrandId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get amount => $_getN(2);
  @$pb.TagNumber(3)
  set amount($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get recipientEmail => $_getSZ(3);
  @$pb.TagNumber(4)
  set recipientEmail($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasRecipientEmail() => $_has(3);
  @$pb.TagNumber(4)
  void clearRecipientEmail() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get recipientName => $_getSZ(4);
  @$pb.TagNumber(5)
  set recipientName($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasRecipientName() => $_has(4);
  @$pb.TagNumber(5)
  void clearRecipientName() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get giftMessage => $_getSZ(5);
  @$pb.TagNumber(6)
  set giftMessage($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasGiftMessage() => $_has(5);
  @$pb.TagNumber(6)
  void clearGiftMessage() => $_clearField(6);

  /// Transaction PIN verification (replaces direct PIN field)
  @$pb.TagNumber(7)
  $core.String get transactionId => $_getSZ(6);
  @$pb.TagNumber(7)
  set transactionId($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasTransactionId() => $_has(6);
  @$pb.TagNumber(7)
  void clearTransactionId() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get verificationToken => $_getSZ(7);
  @$pb.TagNumber(8)
  set verificationToken($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasVerificationToken() => $_has(7);
  @$pb.TagNumber(8)
  void clearVerificationToken() => $_clearField(8);

  /// Reloadly fields
  @$pb.TagNumber(9)
  $core.String get idempotencyKey => $_getSZ(8);
  @$pb.TagNumber(9)
  set idempotencyKey($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasIdempotencyKey() => $_has(8);
  @$pb.TagNumber(9)
  void clearIdempotencyKey() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get senderName => $_getSZ(9);
  @$pb.TagNumber(10)
  set senderName($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasSenderName() => $_has(9);
  @$pb.TagNumber(10)
  void clearSenderName() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get recipientPhone => $_getSZ(10);
  @$pb.TagNumber(11)
  set recipientPhone($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasRecipientPhone() => $_has(10);
  @$pb.TagNumber(11)
  void clearRecipientPhone() => $_clearField(11);

  @$pb.TagNumber(12)
  $fixnum.Int64 get productId => $_getI64(11);
  @$pb.TagNumber(12)
  set productId($fixnum.Int64 value) => $_setInt64(11, value);
  @$pb.TagNumber(12)
  $core.bool hasProductId() => $_has(11);
  @$pb.TagNumber(12)
  void clearProductId() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get countryCode => $_getSZ(12);
  @$pb.TagNumber(13)
  set countryCode($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasCountryCode() => $_has(12);
  @$pb.TagNumber(13)
  void clearCountryCode() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.int get quantity => $_getIZ(13);
  @$pb.TagNumber(14)
  set quantity($core.int value) => $_setSignedInt32(13, value);
  @$pb.TagNumber(14)
  $core.bool hasQuantity() => $_has(13);
  @$pb.TagNumber(14)
  void clearQuantity() => $_clearField(14);

  /// Provider consistency - MUST match the provider from GetGiftCardBrands response
  @$pb.TagNumber(15)
  $core.String get providerName => $_getSZ(14);
  @$pb.TagNumber(15)
  set providerName($core.String value) => $_setString(14, value);
  @$pb.TagNumber(15)
  $core.bool hasProviderName() => $_has(14);
  @$pb.TagNumber(15)
  void clearProviderName() => $_clearField(15);

  /// Multi-currency payment fields
  @$pb.TagNumber(16)
  $core.double get senderAmount => $_getN(15);
  @$pb.TagNumber(16)
  set senderAmount($core.double value) => $_setDouble(15, value);
  @$pb.TagNumber(16)
  $core.bool hasSenderAmount() => $_has(15);
  @$pb.TagNumber(16)
  void clearSenderAmount() => $_clearField(16);

  @$pb.TagNumber(17)
  $core.String get senderCurrency => $_getSZ(16);
  @$pb.TagNumber(17)
  set senderCurrency($core.String value) => $_setString(16, value);
  @$pb.TagNumber(17)
  $core.bool hasSenderCurrency() => $_has(16);
  @$pb.TagNumber(17)
  void clearSenderCurrency() => $_clearField(17);
}

class BuyGiftCardResponse extends $pb.GeneratedMessage {
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
    final result = create();
    if (giftCard != null) result.giftCard = giftCard;
    if (newBalance != null) result.newBalance = newBalance;
    if (message != null) result.message = message;
    if (providerTransactionId != null) result.providerTransactionId = providerTransactionId;
    if (senderAmount != null) result.senderAmount = senderAmount;
    if (senderCurrency != null) result.senderCurrency = senderCurrency;
    if (recipientAmount != null) result.recipientAmount = recipientAmount;
    if (recipientCurrency != null) result.recipientCurrency = recipientCurrency;
    return result;
  }

  BuyGiftCardResponse._();

  factory BuyGiftCardResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory BuyGiftCardResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'BuyGiftCardResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOM<GiftCard>(1, _omitFieldNames ? '' : 'giftCard', subBuilder: GiftCard.create)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'newBalance', $pb.PbFieldType.OD)
    ..aOS(3, _omitFieldNames ? '' : 'message')
    ..aOS(4, _omitFieldNames ? '' : 'providerTransactionId')
    ..a<$core.double>(5, _omitFieldNames ? '' : 'senderAmount', $pb.PbFieldType.OD)
    ..aOS(6, _omitFieldNames ? '' : 'senderCurrency')
    ..a<$core.double>(7, _omitFieldNames ? '' : 'recipientAmount', $pb.PbFieldType.OD)
    ..aOS(8, _omitFieldNames ? '' : 'recipientCurrency')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BuyGiftCardResponse clone() => BuyGiftCardResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BuyGiftCardResponse copyWith(void Function(BuyGiftCardResponse) updates) => super.copyWith((message) => updates(message as BuyGiftCardResponse)) as BuyGiftCardResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BuyGiftCardResponse create() => BuyGiftCardResponse._();
  @$core.override
  BuyGiftCardResponse createEmptyInstance() => create();
  static $pb.PbList<BuyGiftCardResponse> createRepeated() => $pb.PbList<BuyGiftCardResponse>();
  @$core.pragma('dart2js:noInline')
  static BuyGiftCardResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BuyGiftCardResponse>(create);
  static BuyGiftCardResponse? _defaultInstance;

  @$pb.TagNumber(1)
  GiftCard get giftCard => $_getN(0);
  @$pb.TagNumber(1)
  set giftCard(GiftCard value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasGiftCard() => $_has(0);
  @$pb.TagNumber(1)
  void clearGiftCard() => $_clearField(1);
  @$pb.TagNumber(1)
  GiftCard ensureGiftCard() => $_ensure(0);

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

  @$pb.TagNumber(4)
  $core.String get providerTransactionId => $_getSZ(3);
  @$pb.TagNumber(4)
  set providerTransactionId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasProviderTransactionId() => $_has(3);
  @$pb.TagNumber(4)
  void clearProviderTransactionId() => $_clearField(4);

  /// Multi-currency info
  @$pb.TagNumber(5)
  $core.double get senderAmount => $_getN(4);
  @$pb.TagNumber(5)
  set senderAmount($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasSenderAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearSenderAmount() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get senderCurrency => $_getSZ(5);
  @$pb.TagNumber(6)
  set senderCurrency($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasSenderCurrency() => $_has(5);
  @$pb.TagNumber(6)
  void clearSenderCurrency() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.double get recipientAmount => $_getN(6);
  @$pb.TagNumber(7)
  set recipientAmount($core.double value) => $_setDouble(6, value);
  @$pb.TagNumber(7)
  $core.bool hasRecipientAmount() => $_has(6);
  @$pb.TagNumber(7)
  void clearRecipientAmount() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get recipientCurrency => $_getSZ(7);
  @$pb.TagNumber(8)
  set recipientCurrency($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasRecipientCurrency() => $_has(7);
  @$pb.TagNumber(8)
  void clearRecipientCurrency() => $_clearField(8);
}

/// ===== GET REDEEM CODE =====
/// Fetches the merchant redeem code (e.g., Amazon code, Google Play code) for a gift card
/// purchased on this platform. Uses the stored provider transaction ID to call Reloadly.
/// NOTE: user_id extracted from JWT token, not from request
class GetRedeemCodeRequest extends $pb.GeneratedMessage {
  factory GetRedeemCodeRequest({
    $core.String? transactionId,
    $core.bool? forceRefresh,
  }) {
    final result = create();
    if (transactionId != null) result.transactionId = transactionId;
    if (forceRefresh != null) result.forceRefresh = forceRefresh;
    return result;
  }

  GetRedeemCodeRequest._();

  factory GetRedeemCodeRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GetRedeemCodeRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetRedeemCodeRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'transactionId')
    ..aOB(2, _omitFieldNames ? '' : 'forceRefresh')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetRedeemCodeRequest clone() => GetRedeemCodeRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetRedeemCodeRequest copyWith(void Function(GetRedeemCodeRequest) updates) => super.copyWith((message) => updates(message as GetRedeemCodeRequest)) as GetRedeemCodeRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetRedeemCodeRequest create() => GetRedeemCodeRequest._();
  @$core.override
  GetRedeemCodeRequest createEmptyInstance() => create();
  static $pb.PbList<GetRedeemCodeRequest> createRepeated() => $pb.PbList<GetRedeemCodeRequest>();
  @$core.pragma('dart2js:noInline')
  static GetRedeemCodeRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetRedeemCodeRequest>(create);
  static GetRedeemCodeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get transactionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set transactionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTransactionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransactionId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get forceRefresh => $_getBF(1);
  @$pb.TagNumber(2)
  set forceRefresh($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasForceRefresh() => $_has(1);
  @$pb.TagNumber(2)
  void clearForceRefresh() => $_clearField(2);
}

class GetRedeemCodeResponse extends $pb.GeneratedMessage {
  factory GetRedeemCodeResponse({
    $core.String? transactionId,
    $core.String? redemptionCode,
    $core.String? redemptionPin,
    $core.String? brandName,
    $core.String? redemptionInstructions,
    $core.String? status,
    $core.String? message,
  }) {
    final result = create();
    if (transactionId != null) result.transactionId = transactionId;
    if (redemptionCode != null) result.redemptionCode = redemptionCode;
    if (redemptionPin != null) result.redemptionPin = redemptionPin;
    if (brandName != null) result.brandName = brandName;
    if (redemptionInstructions != null) result.redemptionInstructions = redemptionInstructions;
    if (status != null) result.status = status;
    if (message != null) result.message = message;
    return result;
  }

  GetRedeemCodeResponse._();

  factory GetRedeemCodeResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GetRedeemCodeResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetRedeemCodeResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'transactionId')
    ..aOS(2, _omitFieldNames ? '' : 'redemptionCode')
    ..aOS(3, _omitFieldNames ? '' : 'redemptionPin')
    ..aOS(4, _omitFieldNames ? '' : 'brandName')
    ..aOS(5, _omitFieldNames ? '' : 'redemptionInstructions')
    ..aOS(6, _omitFieldNames ? '' : 'status')
    ..aOS(7, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetRedeemCodeResponse clone() => GetRedeemCodeResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetRedeemCodeResponse copyWith(void Function(GetRedeemCodeResponse) updates) => super.copyWith((message) => updates(message as GetRedeemCodeResponse)) as GetRedeemCodeResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetRedeemCodeResponse create() => GetRedeemCodeResponse._();
  @$core.override
  GetRedeemCodeResponse createEmptyInstance() => create();
  static $pb.PbList<GetRedeemCodeResponse> createRepeated() => $pb.PbList<GetRedeemCodeResponse>();
  @$core.pragma('dart2js:noInline')
  static GetRedeemCodeResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetRedeemCodeResponse>(create);
  static GetRedeemCodeResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get transactionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set transactionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTransactionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransactionId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get redemptionCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set redemptionCode($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRedemptionCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearRedemptionCode() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get redemptionPin => $_getSZ(2);
  @$pb.TagNumber(3)
  set redemptionPin($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasRedemptionPin() => $_has(2);
  @$pb.TagNumber(3)
  void clearRedemptionPin() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get brandName => $_getSZ(3);
  @$pb.TagNumber(4)
  set brandName($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasBrandName() => $_has(3);
  @$pb.TagNumber(4)
  void clearBrandName() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get redemptionInstructions => $_getSZ(4);
  @$pb.TagNumber(5)
  set redemptionInstructions($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasRedemptionInstructions() => $_has(4);
  @$pb.TagNumber(5)
  void clearRedemptionInstructions() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get status => $_getSZ(5);
  @$pb.TagNumber(6)
  set status($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasStatus() => $_has(5);
  @$pb.TagNumber(6)
  void clearStatus() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get message => $_getSZ(6);
  @$pb.TagNumber(7)
  set message($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasMessage() => $_has(6);
  @$pb.TagNumber(7)
  void clearMessage() => $_clearField(7);
}

/// ===== GET GIFT CARDS =====
/// NOTE: user_id extracted from JWT token, not from request
class GetGiftCardsRequest extends $pb.GeneratedMessage {
  factory GetGiftCardsRequest({
    $core.String? status,
    $core.String? brandId,
    $core.int? limit,
    $core.int? offset,
  }) {
    final result = create();
    if (status != null) result.status = status;
    if (brandId != null) result.brandId = brandId;
    if (limit != null) result.limit = limit;
    if (offset != null) result.offset = offset;
    return result;
  }

  GetGiftCardsRequest._();

  factory GetGiftCardsRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GetGiftCardsRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetGiftCardsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'status')
    ..aOS(2, _omitFieldNames ? '' : 'brandId')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetGiftCardsRequest clone() => GetGiftCardsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetGiftCardsRequest copyWith(void Function(GetGiftCardsRequest) updates) => super.copyWith((message) => updates(message as GetGiftCardsRequest)) as GetGiftCardsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetGiftCardsRequest create() => GetGiftCardsRequest._();
  @$core.override
  GetGiftCardsRequest createEmptyInstance() => create();
  static $pb.PbList<GetGiftCardsRequest> createRepeated() => $pb.PbList<GetGiftCardsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetGiftCardsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetGiftCardsRequest>(create);
  static GetGiftCardsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get status => $_getSZ(0);
  @$pb.TagNumber(1)
  set status($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get brandId => $_getSZ(1);
  @$pb.TagNumber(2)
  set brandId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasBrandId() => $_has(1);
  @$pb.TagNumber(2)
  void clearBrandId() => $_clearField(2);

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

class GetGiftCardsResponse extends $pb.GeneratedMessage {
  factory GetGiftCardsResponse({
    $core.Iterable<GiftCard>? giftCards,
    $core.int? total,
    $core.double? totalValue,
  }) {
    final result = create();
    if (giftCards != null) result.giftCards.addAll(giftCards);
    if (total != null) result.total = total;
    if (totalValue != null) result.totalValue = totalValue;
    return result;
  }

  GetGiftCardsResponse._();

  factory GetGiftCardsResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GetGiftCardsResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetGiftCardsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..pc<GiftCard>(1, _omitFieldNames ? '' : 'giftCards', $pb.PbFieldType.PM, subBuilder: GiftCard.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'totalValue', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetGiftCardsResponse clone() => GetGiftCardsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetGiftCardsResponse copyWith(void Function(GetGiftCardsResponse) updates) => super.copyWith((message) => updates(message as GetGiftCardsResponse)) as GetGiftCardsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetGiftCardsResponse create() => GetGiftCardsResponse._();
  @$core.override
  GetGiftCardsResponse createEmptyInstance() => create();
  static $pb.PbList<GetGiftCardsResponse> createRepeated() => $pb.PbList<GetGiftCardsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetGiftCardsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetGiftCardsResponse>(create);
  static GetGiftCardsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<GiftCard> get giftCards => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get totalValue => $_getN(2);
  @$pb.TagNumber(3)
  set totalValue($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTotalValue() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalValue() => $_clearField(3);
}

/// ===== GET GIFT CARD =====
/// NOTE: user_id extracted from JWT token, not from request
class GetGiftCardRequest extends $pb.GeneratedMessage {
  factory GetGiftCardRequest({
    $core.String? giftCardId,
  }) {
    final result = create();
    if (giftCardId != null) result.giftCardId = giftCardId;
    return result;
  }

  GetGiftCardRequest._();

  factory GetGiftCardRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GetGiftCardRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetGiftCardRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'giftCardId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetGiftCardRequest clone() => GetGiftCardRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetGiftCardRequest copyWith(void Function(GetGiftCardRequest) updates) => super.copyWith((message) => updates(message as GetGiftCardRequest)) as GetGiftCardRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetGiftCardRequest create() => GetGiftCardRequest._();
  @$core.override
  GetGiftCardRequest createEmptyInstance() => create();
  static $pb.PbList<GetGiftCardRequest> createRepeated() => $pb.PbList<GetGiftCardRequest>();
  @$core.pragma('dart2js:noInline')
  static GetGiftCardRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetGiftCardRequest>(create);
  static GetGiftCardRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get giftCardId => $_getSZ(0);
  @$pb.TagNumber(1)
  set giftCardId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasGiftCardId() => $_has(0);
  @$pb.TagNumber(1)
  void clearGiftCardId() => $_clearField(1);
}

class GetGiftCardResponse extends $pb.GeneratedMessage {
  factory GetGiftCardResponse({
    GiftCard? giftCard,
  }) {
    final result = create();
    if (giftCard != null) result.giftCard = giftCard;
    return result;
  }

  GetGiftCardResponse._();

  factory GetGiftCardResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GetGiftCardResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetGiftCardResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOM<GiftCard>(1, _omitFieldNames ? '' : 'giftCard', subBuilder: GiftCard.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetGiftCardResponse clone() => GetGiftCardResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetGiftCardResponse copyWith(void Function(GetGiftCardResponse) updates) => super.copyWith((message) => updates(message as GetGiftCardResponse)) as GetGiftCardResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetGiftCardResponse create() => GetGiftCardResponse._();
  @$core.override
  GetGiftCardResponse createEmptyInstance() => create();
  static $pb.PbList<GetGiftCardResponse> createRepeated() => $pb.PbList<GetGiftCardResponse>();
  @$core.pragma('dart2js:noInline')
  static GetGiftCardResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetGiftCardResponse>(create);
  static GetGiftCardResponse? _defaultInstance;

  @$pb.TagNumber(1)
  GiftCard get giftCard => $_getN(0);
  @$pb.TagNumber(1)
  set giftCard(GiftCard value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasGiftCard() => $_has(0);
  @$pb.TagNumber(1)
  void clearGiftCard() => $_clearField(1);
  @$pb.TagNumber(1)
  GiftCard ensureGiftCard() => $_ensure(0);
}

/// ===== TRANSFER GIFT CARD =====
/// NOTE: user_id extracted from JWT token, not from request
class TransferGiftCardRequest extends $pb.GeneratedMessage {
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
    final result = create();
    if (giftCardId != null) result.giftCardId = giftCardId;
    if (recipientEmail != null) result.recipientEmail = recipientEmail;
    if (recipientName != null) result.recipientName = recipientName;
    if (message != null) result.message = message;
    if (transactionId != null) result.transactionId = transactionId;
    if (verificationToken != null) result.verificationToken = verificationToken;
    if (recipientUserId != null) result.recipientUserId = recipientUserId;
    if (transferType != null) result.transferType = transferType;
    return result;
  }

  TransferGiftCardRequest._();

  factory TransferGiftCardRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory TransferGiftCardRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TransferGiftCardRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'giftCardId')
    ..aOS(2, _omitFieldNames ? '' : 'recipientEmail')
    ..aOS(3, _omitFieldNames ? '' : 'recipientName')
    ..aOS(4, _omitFieldNames ? '' : 'message')
    ..aOS(5, _omitFieldNames ? '' : 'transactionId')
    ..aOS(6, _omitFieldNames ? '' : 'verificationToken')
    ..aOS(7, _omitFieldNames ? '' : 'recipientUserId')
    ..aOS(8, _omitFieldNames ? '' : 'transferType')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TransferGiftCardRequest clone() => TransferGiftCardRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TransferGiftCardRequest copyWith(void Function(TransferGiftCardRequest) updates) => super.copyWith((message) => updates(message as TransferGiftCardRequest)) as TransferGiftCardRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TransferGiftCardRequest create() => TransferGiftCardRequest._();
  @$core.override
  TransferGiftCardRequest createEmptyInstance() => create();
  static $pb.PbList<TransferGiftCardRequest> createRepeated() => $pb.PbList<TransferGiftCardRequest>();
  @$core.pragma('dart2js:noInline')
  static TransferGiftCardRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TransferGiftCardRequest>(create);
  static TransferGiftCardRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get giftCardId => $_getSZ(0);
  @$pb.TagNumber(1)
  set giftCardId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasGiftCardId() => $_has(0);
  @$pb.TagNumber(1)
  void clearGiftCardId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get recipientEmail => $_getSZ(1);
  @$pb.TagNumber(2)
  set recipientEmail($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRecipientEmail() => $_has(1);
  @$pb.TagNumber(2)
  void clearRecipientEmail() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get recipientName => $_getSZ(2);
  @$pb.TagNumber(3)
  set recipientName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasRecipientName() => $_has(2);
  @$pb.TagNumber(3)
  void clearRecipientName() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get message => $_getSZ(3);
  @$pb.TagNumber(4)
  set message($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMessage() => $_has(3);
  @$pb.TagNumber(4)
  void clearMessage() => $_clearField(4);

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

  /// Platform transfer fields (when transferring to a LazerVault user)
  @$pb.TagNumber(7)
  $core.String get recipientUserId => $_getSZ(6);
  @$pb.TagNumber(7)
  set recipientUserId($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasRecipientUserId() => $_has(6);
  @$pb.TagNumber(7)
  void clearRecipientUserId() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get transferType => $_getSZ(7);
  @$pb.TagNumber(8)
  set transferType($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasTransferType() => $_has(7);
  @$pb.TagNumber(8)
  void clearTransferType() => $_clearField(8);
}

class TransferGiftCardResponse extends $pb.GeneratedMessage {
  factory TransferGiftCardResponse({
    GiftCard? giftCard,
    $core.String? message,
    GiftCard? recipientGiftCard,
  }) {
    final result = create();
    if (giftCard != null) result.giftCard = giftCard;
    if (message != null) result.message = message;
    if (recipientGiftCard != null) result.recipientGiftCard = recipientGiftCard;
    return result;
  }

  TransferGiftCardResponse._();

  factory TransferGiftCardResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory TransferGiftCardResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TransferGiftCardResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOM<GiftCard>(1, _omitFieldNames ? '' : 'giftCard', subBuilder: GiftCard.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<GiftCard>(3, _omitFieldNames ? '' : 'recipientGiftCard', subBuilder: GiftCard.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TransferGiftCardResponse clone() => TransferGiftCardResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TransferGiftCardResponse copyWith(void Function(TransferGiftCardResponse) updates) => super.copyWith((message) => updates(message as TransferGiftCardResponse)) as TransferGiftCardResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TransferGiftCardResponse create() => TransferGiftCardResponse._();
  @$core.override
  TransferGiftCardResponse createEmptyInstance() => create();
  static $pb.PbList<TransferGiftCardResponse> createRepeated() => $pb.PbList<TransferGiftCardResponse>();
  @$core.pragma('dart2js:noInline')
  static TransferGiftCardResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TransferGiftCardResponse>(create);
  static TransferGiftCardResponse? _defaultInstance;

  @$pb.TagNumber(1)
  GiftCard get giftCard => $_getN(0);
  @$pb.TagNumber(1)
  set giftCard(GiftCard value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasGiftCard() => $_has(0);
  @$pb.TagNumber(1)
  void clearGiftCard() => $_clearField(1);
  @$pb.TagNumber(1)
  GiftCard ensureGiftCard() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);

  @$pb.TagNumber(3)
  GiftCard get recipientGiftCard => $_getN(2);
  @$pb.TagNumber(3)
  set recipientGiftCard(GiftCard value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasRecipientGiftCard() => $_has(2);
  @$pb.TagNumber(3)
  void clearRecipientGiftCard() => $_clearField(3);
  @$pb.TagNumber(3)
  GiftCard ensureRecipientGiftCard() => $_ensure(2);
}

class GetGiftCardBrandsRequest extends $pb.GeneratedMessage {
  factory GetGiftCardBrandsRequest({
    $core.String? category,
    $core.bool? activeOnly,
    $core.String? countryCode,
    $core.int? page,
    $core.int? pageSize,
    $core.String? searchQuery,
  }) {
    final result = create();
    if (category != null) result.category = category;
    if (activeOnly != null) result.activeOnly = activeOnly;
    if (countryCode != null) result.countryCode = countryCode;
    if (page != null) result.page = page;
    if (pageSize != null) result.pageSize = pageSize;
    if (searchQuery != null) result.searchQuery = searchQuery;
    return result;
  }

  GetGiftCardBrandsRequest._();

  factory GetGiftCardBrandsRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GetGiftCardBrandsRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetGiftCardBrandsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'category')
    ..aOB(2, _omitFieldNames ? '' : 'activeOnly')
    ..aOS(3, _omitFieldNames ? '' : 'countryCode')
    ..a<$core.int>(4, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..aOS(6, _omitFieldNames ? '' : 'searchQuery')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetGiftCardBrandsRequest clone() => GetGiftCardBrandsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetGiftCardBrandsRequest copyWith(void Function(GetGiftCardBrandsRequest) updates) => super.copyWith((message) => updates(message as GetGiftCardBrandsRequest)) as GetGiftCardBrandsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetGiftCardBrandsRequest create() => GetGiftCardBrandsRequest._();
  @$core.override
  GetGiftCardBrandsRequest createEmptyInstance() => create();
  static $pb.PbList<GetGiftCardBrandsRequest> createRepeated() => $pb.PbList<GetGiftCardBrandsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetGiftCardBrandsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetGiftCardBrandsRequest>(create);
  static GetGiftCardBrandsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get category => $_getSZ(0);
  @$pb.TagNumber(1)
  set category($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCategory() => $_has(0);
  @$pb.TagNumber(1)
  void clearCategory() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get activeOnly => $_getBF(1);
  @$pb.TagNumber(2)
  set activeOnly($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasActiveOnly() => $_has(1);
  @$pb.TagNumber(2)
  void clearActiveOnly() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get countryCode => $_getSZ(2);
  @$pb.TagNumber(3)
  set countryCode($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCountryCode() => $_has(2);
  @$pb.TagNumber(3)
  void clearCountryCode() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get page => $_getIZ(3);
  @$pb.TagNumber(4)
  set page($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPage() => $_has(3);
  @$pb.TagNumber(4)
  void clearPage() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get pageSize => $_getIZ(4);
  @$pb.TagNumber(5)
  set pageSize($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasPageSize() => $_has(4);
  @$pb.TagNumber(5)
  void clearPageSize() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get searchQuery => $_getSZ(5);
  @$pb.TagNumber(6)
  set searchQuery($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasSearchQuery() => $_has(5);
  @$pb.TagNumber(6)
  void clearSearchQuery() => $_clearField(6);
}

class GetGiftCardBrandsResponse extends $pb.GeneratedMessage {
  factory GetGiftCardBrandsResponse({
    $core.Iterable<GiftCardBrand>? brands,
    $core.int? total,
    $core.int? totalPages,
    $core.int? currentPage,
    $core.bool? hasNext,
    $core.int? pageSize,
  }) {
    final result = create();
    if (brands != null) result.brands.addAll(brands);
    if (total != null) result.total = total;
    if (totalPages != null) result.totalPages = totalPages;
    if (currentPage != null) result.currentPage = currentPage;
    if (hasNext != null) result.hasNext = hasNext;
    if (pageSize != null) result.pageSize = pageSize;
    return result;
  }

  GetGiftCardBrandsResponse._();

  factory GetGiftCardBrandsResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GetGiftCardBrandsResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetGiftCardBrandsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..pc<GiftCardBrand>(1, _omitFieldNames ? '' : 'brands', $pb.PbFieldType.PM, subBuilder: GiftCardBrand.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'totalPages', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'currentPage', $pb.PbFieldType.O3)
    ..aOB(5, _omitFieldNames ? '' : 'hasNext')
    ..a<$core.int>(6, _omitFieldNames ? '' : 'pageSize', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetGiftCardBrandsResponse clone() => GetGiftCardBrandsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetGiftCardBrandsResponse copyWith(void Function(GetGiftCardBrandsResponse) updates) => super.copyWith((message) => updates(message as GetGiftCardBrandsResponse)) as GetGiftCardBrandsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetGiftCardBrandsResponse create() => GetGiftCardBrandsResponse._();
  @$core.override
  GetGiftCardBrandsResponse createEmptyInstance() => create();
  static $pb.PbList<GetGiftCardBrandsResponse> createRepeated() => $pb.PbList<GetGiftCardBrandsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetGiftCardBrandsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetGiftCardBrandsResponse>(create);
  static GetGiftCardBrandsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<GiftCardBrand> get brands => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get totalPages => $_getIZ(2);
  @$pb.TagNumber(3)
  set totalPages($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTotalPages() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalPages() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get currentPage => $_getIZ(3);
  @$pb.TagNumber(4)
  set currentPage($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCurrentPage() => $_has(3);
  @$pb.TagNumber(4)
  void clearCurrentPage() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.bool get hasNext => $_getBF(4);
  @$pb.TagNumber(5)
  set hasNext($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasHasNext() => $_has(4);
  @$pb.TagNumber(5)
  void clearHasNext() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get pageSize => $_getIZ(5);
  @$pb.TagNumber(6)
  set pageSize($core.int value) => $_setSignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasPageSize() => $_has(5);
  @$pb.TagNumber(6)
  void clearPageSize() => $_clearField(6);
}

/// ===== GET GIFT CARD HISTORY =====
/// NOTE: user_id extracted from JWT token, not from request
class GetGiftCardHistoryRequest extends $pb.GeneratedMessage {
  factory GetGiftCardHistoryRequest({
    $core.String? giftCardId,
    $core.String? transactionType,
    $core.String? startDate,
    $core.String? endDate,
    $core.int? limit,
    $core.int? offset,
  }) {
    final result = create();
    if (giftCardId != null) result.giftCardId = giftCardId;
    if (transactionType != null) result.transactionType = transactionType;
    if (startDate != null) result.startDate = startDate;
    if (endDate != null) result.endDate = endDate;
    if (limit != null) result.limit = limit;
    if (offset != null) result.offset = offset;
    return result;
  }

  GetGiftCardHistoryRequest._();

  factory GetGiftCardHistoryRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GetGiftCardHistoryRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetGiftCardHistoryRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'giftCardId')
    ..aOS(2, _omitFieldNames ? '' : 'transactionType')
    ..aOS(3, _omitFieldNames ? '' : 'startDate')
    ..aOS(4, _omitFieldNames ? '' : 'endDate')
    ..a<$core.int>(5, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(6, _omitFieldNames ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetGiftCardHistoryRequest clone() => GetGiftCardHistoryRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetGiftCardHistoryRequest copyWith(void Function(GetGiftCardHistoryRequest) updates) => super.copyWith((message) => updates(message as GetGiftCardHistoryRequest)) as GetGiftCardHistoryRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetGiftCardHistoryRequest create() => GetGiftCardHistoryRequest._();
  @$core.override
  GetGiftCardHistoryRequest createEmptyInstance() => create();
  static $pb.PbList<GetGiftCardHistoryRequest> createRepeated() => $pb.PbList<GetGiftCardHistoryRequest>();
  @$core.pragma('dart2js:noInline')
  static GetGiftCardHistoryRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetGiftCardHistoryRequest>(create);
  static GetGiftCardHistoryRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get giftCardId => $_getSZ(0);
  @$pb.TagNumber(1)
  set giftCardId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasGiftCardId() => $_has(0);
  @$pb.TagNumber(1)
  void clearGiftCardId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get transactionType => $_getSZ(1);
  @$pb.TagNumber(2)
  set transactionType($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTransactionType() => $_has(1);
  @$pb.TagNumber(2)
  void clearTransactionType() => $_clearField(2);

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

class GetGiftCardHistoryResponse extends $pb.GeneratedMessage {
  factory GetGiftCardHistoryResponse({
    $core.Iterable<GiftCardTransaction>? transactions,
    $core.int? total,
  }) {
    final result = create();
    if (transactions != null) result.transactions.addAll(transactions);
    if (total != null) result.total = total;
    return result;
  }

  GetGiftCardHistoryResponse._();

  factory GetGiftCardHistoryResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GetGiftCardHistoryResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetGiftCardHistoryResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..pc<GiftCardTransaction>(1, _omitFieldNames ? '' : 'transactions', $pb.PbFieldType.PM, subBuilder: GiftCardTransaction.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetGiftCardHistoryResponse clone() => GetGiftCardHistoryResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetGiftCardHistoryResponse copyWith(void Function(GetGiftCardHistoryResponse) updates) => super.copyWith((message) => updates(message as GetGiftCardHistoryResponse)) as GetGiftCardHistoryResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetGiftCardHistoryResponse create() => GetGiftCardHistoryResponse._();
  @$core.override
  GetGiftCardHistoryResponse createEmptyInstance() => create();
  static $pb.PbList<GetGiftCardHistoryResponse> createRepeated() => $pb.PbList<GetGiftCardHistoryResponse>();
  @$core.pragma('dart2js:noInline')
  static GetGiftCardHistoryResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetGiftCardHistoryResponse>(create);
  static GetGiftCardHistoryResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<GiftCardTransaction> get transactions => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);
}

class SellableCard extends $pb.GeneratedMessage {
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
    final result = create();
    if (cardType != null) result.cardType = cardType;
    if (displayName != null) result.displayName = displayName;
    if (logoUrl != null) result.logoUrl = logoUrl;
    if (category != null) result.category = category;
    if (denominations != null) result.denominations.addAll(denominations);
    if (currencies != null) result.currencies.addAll(currencies);
    if (minDenomination != null) result.minDenomination = minDenomination;
    if (maxDenomination != null) result.maxDenomination = maxDenomination;
    if (providerName != null) result.providerName = providerName;
    if (form != null) result.form = form;
    if (subcategoryId != null) result.subcategoryId = subcategoryId;
    if (country != null) result.country = country;
    return result;
  }

  SellableCard._();

  factory SellableCard.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory SellableCard.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SellableCard', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'cardType')
    ..aOS(2, _omitFieldNames ? '' : 'displayName')
    ..aOS(3, _omitFieldNames ? '' : 'logoUrl')
    ..aOS(4, _omitFieldNames ? '' : 'category')
    ..p<$core.double>(5, _omitFieldNames ? '' : 'denominations', $pb.PbFieldType.KD)
    ..pPS(6, _omitFieldNames ? '' : 'currencies')
    ..a<$core.double>(7, _omitFieldNames ? '' : 'minDenomination', $pb.PbFieldType.OD)
    ..a<$core.double>(8, _omitFieldNames ? '' : 'maxDenomination', $pb.PbFieldType.OD)
    ..aOS(9, _omitFieldNames ? '' : 'providerName')
    ..aOS(10, _omitFieldNames ? '' : 'form')
    ..aOS(11, _omitFieldNames ? '' : 'subcategoryId')
    ..aOS(12, _omitFieldNames ? '' : 'country')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SellableCard clone() => SellableCard()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SellableCard copyWith(void Function(SellableCard) updates) => super.copyWith((message) => updates(message as SellableCard)) as SellableCard;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SellableCard create() => SellableCard._();
  @$core.override
  SellableCard createEmptyInstance() => create();
  static $pb.PbList<SellableCard> createRepeated() => $pb.PbList<SellableCard>();
  @$core.pragma('dart2js:noInline')
  static SellableCard getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SellableCard>(create);
  static SellableCard? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get cardType => $_getSZ(0);
  @$pb.TagNumber(1)
  set cardType($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCardType() => $_has(0);
  @$pb.TagNumber(1)
  void clearCardType() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get displayName => $_getSZ(1);
  @$pb.TagNumber(2)
  set displayName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDisplayName() => $_has(1);
  @$pb.TagNumber(2)
  void clearDisplayName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get logoUrl => $_getSZ(2);
  @$pb.TagNumber(3)
  set logoUrl($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLogoUrl() => $_has(2);
  @$pb.TagNumber(3)
  void clearLogoUrl() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get category => $_getSZ(3);
  @$pb.TagNumber(4)
  set category($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCategory() => $_has(3);
  @$pb.TagNumber(4)
  void clearCategory() => $_clearField(4);

  @$pb.TagNumber(5)
  $pb.PbList<$core.double> get denominations => $_getList(4);

  @$pb.TagNumber(6)
  $pb.PbList<$core.String> get currencies => $_getList(5);

  @$pb.TagNumber(7)
  $core.double get minDenomination => $_getN(6);
  @$pb.TagNumber(7)
  set minDenomination($core.double value) => $_setDouble(6, value);
  @$pb.TagNumber(7)
  $core.bool hasMinDenomination() => $_has(6);
  @$pb.TagNumber(7)
  void clearMinDenomination() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.double get maxDenomination => $_getN(7);
  @$pb.TagNumber(8)
  set maxDenomination($core.double value) => $_setDouble(7, value);
  @$pb.TagNumber(8)
  $core.bool hasMaxDenomination() => $_has(7);
  @$pb.TagNumber(8)
  void clearMaxDenomination() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get providerName => $_getSZ(8);
  @$pb.TagNumber(9)
  set providerName($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasProviderName() => $_has(8);
  @$pb.TagNumber(9)
  void clearProviderName() => $_clearField(9);

  /// Prestmit `form` value: "Physical" | "Ecode". Drives sell-flow UI:
  /// Physical → image upload (attachments[]); Ecode → text-input
  /// (code goes to `comments`). Empty for providers that don't
  /// distinguish (manual/internal).
  @$pb.TagNumber(10)
  $core.String get form => $_getSZ(9);
  @$pb.TagNumber(10)
  set form($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasForm() => $_has(9);
  @$pb.TagNumber(10)
  void clearForm() => $_clearField(10);

  /// Prestmit numeric subcategory id used as `giftcard_id` at sale time.
  /// Mirrors `card_type` for non-Prestmit catalogues.
  @$pb.TagNumber(11)
  $core.String get subcategoryId => $_getSZ(10);
  @$pb.TagNumber(11)
  set subcategoryId($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasSubcategoryId() => $_has(10);
  @$pb.TagNumber(11)
  void clearSubcategoryId() => $_clearField(11);

  /// ISO/Prestmit country tag (e.g. "USA", "UK") for region variants.
  @$pb.TagNumber(12)
  $core.String get country => $_getSZ(11);
  @$pb.TagNumber(12)
  set country($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasCountry() => $_has(11);
  @$pb.TagNumber(12)
  void clearCountry() => $_clearField(12);
}

class SellRate extends $pb.GeneratedMessage {
  factory SellRate({
    $core.String? cardType,
    $core.double? denomination,
    $core.double? ratePercentage,
    $core.double? payoutAmount,
    $core.String? currency,
    $core.String? expiresAt,
  }) {
    final result = create();
    if (cardType != null) result.cardType = cardType;
    if (denomination != null) result.denomination = denomination;
    if (ratePercentage != null) result.ratePercentage = ratePercentage;
    if (payoutAmount != null) result.payoutAmount = payoutAmount;
    if (currency != null) result.currency = currency;
    if (expiresAt != null) result.expiresAt = expiresAt;
    return result;
  }

  SellRate._();

  factory SellRate.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory SellRate.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SellRate', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'cardType')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'denomination', $pb.PbFieldType.OD)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'ratePercentage', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'payoutAmount', $pb.PbFieldType.OD)
    ..aOS(5, _omitFieldNames ? '' : 'currency')
    ..aOS(6, _omitFieldNames ? '' : 'expiresAt')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SellRate clone() => SellRate()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SellRate copyWith(void Function(SellRate) updates) => super.copyWith((message) => updates(message as SellRate)) as SellRate;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SellRate create() => SellRate._();
  @$core.override
  SellRate createEmptyInstance() => create();
  static $pb.PbList<SellRate> createRepeated() => $pb.PbList<SellRate>();
  @$core.pragma('dart2js:noInline')
  static SellRate getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SellRate>(create);
  static SellRate? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get cardType => $_getSZ(0);
  @$pb.TagNumber(1)
  set cardType($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCardType() => $_has(0);
  @$pb.TagNumber(1)
  void clearCardType() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get denomination => $_getN(1);
  @$pb.TagNumber(2)
  set denomination($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDenomination() => $_has(1);
  @$pb.TagNumber(2)
  void clearDenomination() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get ratePercentage => $_getN(2);
  @$pb.TagNumber(3)
  set ratePercentage($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasRatePercentage() => $_has(2);
  @$pb.TagNumber(3)
  void clearRatePercentage() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get payoutAmount => $_getN(3);
  @$pb.TagNumber(4)
  set payoutAmount($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPayoutAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearPayoutAmount() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get currency => $_getSZ(4);
  @$pb.TagNumber(5)
  set currency($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCurrency() => $_has(4);
  @$pb.TagNumber(5)
  void clearCurrency() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get expiresAt => $_getSZ(5);
  @$pb.TagNumber(6)
  set expiresAt($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasExpiresAt() => $_has(5);
  @$pb.TagNumber(6)
  void clearExpiresAt() => $_clearField(6);
}

class GiftCardSale extends $pb.GeneratedMessage {
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
    final result = create();
    if (id != null) result.id = id;
    if (userId != null) result.userId = userId;
    if (accountId != null) result.accountId = accountId;
    if (cardType != null) result.cardType = cardType;
    if (cardNumber != null) result.cardNumber = cardNumber;
    if (denomination != null) result.denomination = denomination;
    if (currency != null) result.currency = currency;
    if (ratePercentage != null) result.ratePercentage = ratePercentage;
    if (expectedPayout != null) result.expectedPayout = expectedPayout;
    if (actualPayout != null) result.actualPayout = actualPayout;
    if (status != null) result.status = status;
    if (providerSaleId != null) result.providerSaleId = providerSaleId;
    if (providerName != null) result.providerName = providerName;
    if (reference != null) result.reference = reference;
    if (submittedAt != null) result.submittedAt = submittedAt;
    if (reviewedAt != null) result.reviewedAt = reviewedAt;
    if (paidAt != null) result.paidAt = paidAt;
    if (payoutError != null) result.payoutError = payoutError;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    if (imageUrls != null) result.imageUrls.addAll(imageUrls);
    if (ocrBrand != null) result.ocrBrand = ocrBrand;
    if (ocrCardNumber != null) result.ocrCardNumber = ocrCardNumber;
    if (ocrPin != null) result.ocrPin = ocrPin;
    if (ocrDenomination != null) result.ocrDenomination = ocrDenomination;
    if (ocrCurrency != null) result.ocrCurrency = ocrCurrency;
    if (adminReviewerId != null) result.adminReviewerId = adminReviewerId;
    if (rejectionReason != null) result.rejectionReason = rejectionReason;
    if (adminNotes != null) result.adminNotes = adminNotes;
    if (cardPin != null) result.cardPin = cardPin;
    if (exitRatePercent != null) result.exitRatePercent = exitRatePercent;
    if (baseMarginPercent != null) result.baseMarginPercent = baseMarginPercent;
    if (riskBufferPercent != null) result.riskBufferPercent = riskBufferPercent;
    if (commissionAmount != null) result.commissionAmount = commissionAmount;
    if (riskScore != null) result.riskScore = riskScore;
    if (riskLevel != null) result.riskLevel = riskLevel;
    if (riskFlags != null) result.riskFlags.addAll(riskFlags);
    if (riskAction != null) result.riskAction = riskAction;
    if (cardCountry != null) result.cardCountry = cardCountry;
    if (cardFormat != null) result.cardFormat = cardFormat;
    return result;
  }

  GiftCardSale._();

  factory GiftCardSale.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GiftCardSale.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GiftCardSale', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'accountId')
    ..aOS(4, _omitFieldNames ? '' : 'cardType')
    ..aOS(5, _omitFieldNames ? '' : 'cardNumber')
    ..a<$core.double>(6, _omitFieldNames ? '' : 'denomination', $pb.PbFieldType.OD)
    ..aOS(7, _omitFieldNames ? '' : 'currency')
    ..a<$core.double>(8, _omitFieldNames ? '' : 'ratePercentage', $pb.PbFieldType.OD)
    ..a<$core.double>(9, _omitFieldNames ? '' : 'expectedPayout', $pb.PbFieldType.OD)
    ..a<$core.double>(10, _omitFieldNames ? '' : 'actualPayout', $pb.PbFieldType.OD)
    ..aOS(11, _omitFieldNames ? '' : 'status')
    ..aOS(12, _omitFieldNames ? '' : 'providerSaleId')
    ..aOS(13, _omitFieldNames ? '' : 'providerName')
    ..aOS(14, _omitFieldNames ? '' : 'reference')
    ..aOS(15, _omitFieldNames ? '' : 'submittedAt')
    ..aOS(16, _omitFieldNames ? '' : 'reviewedAt')
    ..aOS(17, _omitFieldNames ? '' : 'paidAt')
    ..aOS(18, _omitFieldNames ? '' : 'payoutError')
    ..aOS(19, _omitFieldNames ? '' : 'createdAt')
    ..aOS(20, _omitFieldNames ? '' : 'updatedAt')
    ..pPS(21, _omitFieldNames ? '' : 'imageUrls')
    ..aOS(22, _omitFieldNames ? '' : 'ocrBrand')
    ..aOS(23, _omitFieldNames ? '' : 'ocrCardNumber')
    ..aOS(24, _omitFieldNames ? '' : 'ocrPin')
    ..a<$core.double>(25, _omitFieldNames ? '' : 'ocrDenomination', $pb.PbFieldType.OD)
    ..aOS(26, _omitFieldNames ? '' : 'ocrCurrency')
    ..aOS(27, _omitFieldNames ? '' : 'adminReviewerId')
    ..aOS(28, _omitFieldNames ? '' : 'rejectionReason')
    ..aOS(29, _omitFieldNames ? '' : 'adminNotes')
    ..aOS(30, _omitFieldNames ? '' : 'cardPin')
    ..a<$core.double>(31, _omitFieldNames ? '' : 'exitRatePercent', $pb.PbFieldType.OD)
    ..a<$core.double>(32, _omitFieldNames ? '' : 'baseMarginPercent', $pb.PbFieldType.OD)
    ..a<$core.double>(33, _omitFieldNames ? '' : 'riskBufferPercent', $pb.PbFieldType.OD)
    ..a<$core.double>(34, _omitFieldNames ? '' : 'commissionAmount', $pb.PbFieldType.OD)
    ..a<$core.int>(35, _omitFieldNames ? '' : 'riskScore', $pb.PbFieldType.O3)
    ..aOS(36, _omitFieldNames ? '' : 'riskLevel')
    ..pPS(37, _omitFieldNames ? '' : 'riskFlags')
    ..aOS(38, _omitFieldNames ? '' : 'riskAction')
    ..aOS(39, _omitFieldNames ? '' : 'cardCountry')
    ..aOS(40, _omitFieldNames ? '' : 'cardFormat')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GiftCardSale clone() => GiftCardSale()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GiftCardSale copyWith(void Function(GiftCardSale) updates) => super.copyWith((message) => updates(message as GiftCardSale)) as GiftCardSale;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GiftCardSale create() => GiftCardSale._();
  @$core.override
  GiftCardSale createEmptyInstance() => create();
  static $pb.PbList<GiftCardSale> createRepeated() => $pb.PbList<GiftCardSale>();
  @$core.pragma('dart2js:noInline')
  static GiftCardSale getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GiftCardSale>(create);
  static GiftCardSale? _defaultInstance;

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
  $core.String get cardType => $_getSZ(3);
  @$pb.TagNumber(4)
  set cardType($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCardType() => $_has(3);
  @$pb.TagNumber(4)
  void clearCardType() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get cardNumber => $_getSZ(4);
  @$pb.TagNumber(5)
  set cardNumber($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCardNumber() => $_has(4);
  @$pb.TagNumber(5)
  void clearCardNumber() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.double get denomination => $_getN(5);
  @$pb.TagNumber(6)
  set denomination($core.double value) => $_setDouble(5, value);
  @$pb.TagNumber(6)
  $core.bool hasDenomination() => $_has(5);
  @$pb.TagNumber(6)
  void clearDenomination() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get currency => $_getSZ(6);
  @$pb.TagNumber(7)
  set currency($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasCurrency() => $_has(6);
  @$pb.TagNumber(7)
  void clearCurrency() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.double get ratePercentage => $_getN(7);
  @$pb.TagNumber(8)
  set ratePercentage($core.double value) => $_setDouble(7, value);
  @$pb.TagNumber(8)
  $core.bool hasRatePercentage() => $_has(7);
  @$pb.TagNumber(8)
  void clearRatePercentage() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.double get expectedPayout => $_getN(8);
  @$pb.TagNumber(9)
  set expectedPayout($core.double value) => $_setDouble(8, value);
  @$pb.TagNumber(9)
  $core.bool hasExpectedPayout() => $_has(8);
  @$pb.TagNumber(9)
  void clearExpectedPayout() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.double get actualPayout => $_getN(9);
  @$pb.TagNumber(10)
  set actualPayout($core.double value) => $_setDouble(9, value);
  @$pb.TagNumber(10)
  $core.bool hasActualPayout() => $_has(9);
  @$pb.TagNumber(10)
  void clearActualPayout() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get status => $_getSZ(10);
  @$pb.TagNumber(11)
  set status($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasStatus() => $_has(10);
  @$pb.TagNumber(11)
  void clearStatus() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get providerSaleId => $_getSZ(11);
  @$pb.TagNumber(12)
  set providerSaleId($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasProviderSaleId() => $_has(11);
  @$pb.TagNumber(12)
  void clearProviderSaleId() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get providerName => $_getSZ(12);
  @$pb.TagNumber(13)
  set providerName($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasProviderName() => $_has(12);
  @$pb.TagNumber(13)
  void clearProviderName() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.String get reference => $_getSZ(13);
  @$pb.TagNumber(14)
  set reference($core.String value) => $_setString(13, value);
  @$pb.TagNumber(14)
  $core.bool hasReference() => $_has(13);
  @$pb.TagNumber(14)
  void clearReference() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.String get submittedAt => $_getSZ(14);
  @$pb.TagNumber(15)
  set submittedAt($core.String value) => $_setString(14, value);
  @$pb.TagNumber(15)
  $core.bool hasSubmittedAt() => $_has(14);
  @$pb.TagNumber(15)
  void clearSubmittedAt() => $_clearField(15);

  @$pb.TagNumber(16)
  $core.String get reviewedAt => $_getSZ(15);
  @$pb.TagNumber(16)
  set reviewedAt($core.String value) => $_setString(15, value);
  @$pb.TagNumber(16)
  $core.bool hasReviewedAt() => $_has(15);
  @$pb.TagNumber(16)
  void clearReviewedAt() => $_clearField(16);

  @$pb.TagNumber(17)
  $core.String get paidAt => $_getSZ(16);
  @$pb.TagNumber(17)
  set paidAt($core.String value) => $_setString(16, value);
  @$pb.TagNumber(17)
  $core.bool hasPaidAt() => $_has(16);
  @$pb.TagNumber(17)
  void clearPaidAt() => $_clearField(17);

  @$pb.TagNumber(18)
  $core.String get payoutError => $_getSZ(17);
  @$pb.TagNumber(18)
  set payoutError($core.String value) => $_setString(17, value);
  @$pb.TagNumber(18)
  $core.bool hasPayoutError() => $_has(17);
  @$pb.TagNumber(18)
  void clearPayoutError() => $_clearField(18);

  @$pb.TagNumber(19)
  $core.String get createdAt => $_getSZ(18);
  @$pb.TagNumber(19)
  set createdAt($core.String value) => $_setString(18, value);
  @$pb.TagNumber(19)
  $core.bool hasCreatedAt() => $_has(18);
  @$pb.TagNumber(19)
  void clearCreatedAt() => $_clearField(19);

  @$pb.TagNumber(20)
  $core.String get updatedAt => $_getSZ(19);
  @$pb.TagNumber(20)
  set updatedAt($core.String value) => $_setString(19, value);
  @$pb.TagNumber(20)
  $core.bool hasUpdatedAt() => $_has(19);
  @$pb.TagNumber(20)
  void clearUpdatedAt() => $_clearField(20);

  /// Image and OCR fields
  @$pb.TagNumber(21)
  $pb.PbList<$core.String> get imageUrls => $_getList(20);

  @$pb.TagNumber(22)
  $core.String get ocrBrand => $_getSZ(21);
  @$pb.TagNumber(22)
  set ocrBrand($core.String value) => $_setString(21, value);
  @$pb.TagNumber(22)
  $core.bool hasOcrBrand() => $_has(21);
  @$pb.TagNumber(22)
  void clearOcrBrand() => $_clearField(22);

  @$pb.TagNumber(23)
  $core.String get ocrCardNumber => $_getSZ(22);
  @$pb.TagNumber(23)
  set ocrCardNumber($core.String value) => $_setString(22, value);
  @$pb.TagNumber(23)
  $core.bool hasOcrCardNumber() => $_has(22);
  @$pb.TagNumber(23)
  void clearOcrCardNumber() => $_clearField(23);

  @$pb.TagNumber(24)
  $core.String get ocrPin => $_getSZ(23);
  @$pb.TagNumber(24)
  set ocrPin($core.String value) => $_setString(23, value);
  @$pb.TagNumber(24)
  $core.bool hasOcrPin() => $_has(23);
  @$pb.TagNumber(24)
  void clearOcrPin() => $_clearField(24);

  @$pb.TagNumber(25)
  $core.double get ocrDenomination => $_getN(24);
  @$pb.TagNumber(25)
  set ocrDenomination($core.double value) => $_setDouble(24, value);
  @$pb.TagNumber(25)
  $core.bool hasOcrDenomination() => $_has(24);
  @$pb.TagNumber(25)
  void clearOcrDenomination() => $_clearField(25);

  @$pb.TagNumber(26)
  $core.String get ocrCurrency => $_getSZ(25);
  @$pb.TagNumber(26)
  set ocrCurrency($core.String value) => $_setString(25, value);
  @$pb.TagNumber(26)
  $core.bool hasOcrCurrency() => $_has(25);
  @$pb.TagNumber(26)
  void clearOcrCurrency() => $_clearField(26);

  /// Admin review fields
  @$pb.TagNumber(27)
  $core.String get adminReviewerId => $_getSZ(26);
  @$pb.TagNumber(27)
  set adminReviewerId($core.String value) => $_setString(26, value);
  @$pb.TagNumber(27)
  $core.bool hasAdminReviewerId() => $_has(26);
  @$pb.TagNumber(27)
  void clearAdminReviewerId() => $_clearField(27);

  @$pb.TagNumber(28)
  $core.String get rejectionReason => $_getSZ(27);
  @$pb.TagNumber(28)
  set rejectionReason($core.String value) => $_setString(27, value);
  @$pb.TagNumber(28)
  $core.bool hasRejectionReason() => $_has(27);
  @$pb.TagNumber(28)
  void clearRejectionReason() => $_clearField(28);

  @$pb.TagNumber(29)
  $core.String get adminNotes => $_getSZ(28);
  @$pb.TagNumber(29)
  set adminNotes($core.String value) => $_setString(28, value);
  @$pb.TagNumber(29)
  $core.bool hasAdminNotes() => $_has(28);
  @$pb.TagNumber(29)
  void clearAdminNotes() => $_clearField(29);

  @$pb.TagNumber(30)
  $core.String get cardPin => $_getSZ(29);
  @$pb.TagNumber(30)
  set cardPin($core.String value) => $_setString(29, value);
  @$pb.TagNumber(30)
  $core.bool hasCardPin() => $_has(29);
  @$pb.TagNumber(30)
  void clearCardPin() => $_clearField(30);

  /// Dynamic pricing breakdown
  @$pb.TagNumber(31)
  $core.double get exitRatePercent => $_getN(30);
  @$pb.TagNumber(31)
  set exitRatePercent($core.double value) => $_setDouble(30, value);
  @$pb.TagNumber(31)
  $core.bool hasExitRatePercent() => $_has(30);
  @$pb.TagNumber(31)
  void clearExitRatePercent() => $_clearField(31);

  @$pb.TagNumber(32)
  $core.double get baseMarginPercent => $_getN(31);
  @$pb.TagNumber(32)
  set baseMarginPercent($core.double value) => $_setDouble(31, value);
  @$pb.TagNumber(32)
  $core.bool hasBaseMarginPercent() => $_has(31);
  @$pb.TagNumber(32)
  void clearBaseMarginPercent() => $_clearField(32);

  @$pb.TagNumber(33)
  $core.double get riskBufferPercent => $_getN(32);
  @$pb.TagNumber(33)
  set riskBufferPercent($core.double value) => $_setDouble(32, value);
  @$pb.TagNumber(33)
  $core.bool hasRiskBufferPercent() => $_has(32);
  @$pb.TagNumber(33)
  void clearRiskBufferPercent() => $_clearField(33);

  @$pb.TagNumber(34)
  $core.double get commissionAmount => $_getN(33);
  @$pb.TagNumber(34)
  set commissionAmount($core.double value) => $_setDouble(33, value);
  @$pb.TagNumber(34)
  $core.bool hasCommissionAmount() => $_has(33);
  @$pb.TagNumber(34)
  void clearCommissionAmount() => $_clearField(34);

  /// Risk scoring
  @$pb.TagNumber(35)
  $core.int get riskScore => $_getIZ(34);
  @$pb.TagNumber(35)
  set riskScore($core.int value) => $_setSignedInt32(34, value);
  @$pb.TagNumber(35)
  $core.bool hasRiskScore() => $_has(34);
  @$pb.TagNumber(35)
  void clearRiskScore() => $_clearField(35);

  @$pb.TagNumber(36)
  $core.String get riskLevel => $_getSZ(35);
  @$pb.TagNumber(36)
  set riskLevel($core.String value) => $_setString(35, value);
  @$pb.TagNumber(36)
  $core.bool hasRiskLevel() => $_has(35);
  @$pb.TagNumber(36)
  void clearRiskLevel() => $_clearField(36);

  @$pb.TagNumber(37)
  $pb.PbList<$core.String> get riskFlags => $_getList(36);

  @$pb.TagNumber(38)
  $core.String get riskAction => $_getSZ(37);
  @$pb.TagNumber(38)
  set riskAction($core.String value) => $_setString(37, value);
  @$pb.TagNumber(38)
  $core.bool hasRiskAction() => $_has(37);
  @$pb.TagNumber(38)
  void clearRiskAction() => $_clearField(38);

  /// Card details
  @$pb.TagNumber(39)
  $core.String get cardCountry => $_getSZ(38);
  @$pb.TagNumber(39)
  set cardCountry($core.String value) => $_setString(38, value);
  @$pb.TagNumber(39)
  $core.bool hasCardCountry() => $_has(38);
  @$pb.TagNumber(39)
  void clearCardCountry() => $_clearField(39);

  @$pb.TagNumber(40)
  $core.String get cardFormat => $_getSZ(39);
  @$pb.TagNumber(40)
  set cardFormat($core.String value) => $_setString(39, value);
  @$pb.TagNumber(40)
  $core.bool hasCardFormat() => $_has(39);
  @$pb.TagNumber(40)
  void clearCardFormat() => $_clearField(40);
}

class GetSellableCardsRequest extends $pb.GeneratedMessage {
  factory GetSellableCardsRequest({
    $core.String? countryCode,
  }) {
    final result = create();
    if (countryCode != null) result.countryCode = countryCode;
    return result;
  }

  GetSellableCardsRequest._();

  factory GetSellableCardsRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GetSellableCardsRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetSellableCardsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'countryCode')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSellableCardsRequest clone() => GetSellableCardsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSellableCardsRequest copyWith(void Function(GetSellableCardsRequest) updates) => super.copyWith((message) => updates(message as GetSellableCardsRequest)) as GetSellableCardsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSellableCardsRequest create() => GetSellableCardsRequest._();
  @$core.override
  GetSellableCardsRequest createEmptyInstance() => create();
  static $pb.PbList<GetSellableCardsRequest> createRepeated() => $pb.PbList<GetSellableCardsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetSellableCardsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetSellableCardsRequest>(create);
  static GetSellableCardsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get countryCode => $_getSZ(0);
  @$pb.TagNumber(1)
  set countryCode($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCountryCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearCountryCode() => $_clearField(1);
}

class GetSellableCardsResponse extends $pb.GeneratedMessage {
  factory GetSellableCardsResponse({
    $core.Iterable<SellableCard>? cards,
    $core.int? total,
  }) {
    final result = create();
    if (cards != null) result.cards.addAll(cards);
    if (total != null) result.total = total;
    return result;
  }

  GetSellableCardsResponse._();

  factory GetSellableCardsResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GetSellableCardsResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetSellableCardsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..pc<SellableCard>(1, _omitFieldNames ? '' : 'cards', $pb.PbFieldType.PM, subBuilder: SellableCard.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSellableCardsResponse clone() => GetSellableCardsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSellableCardsResponse copyWith(void Function(GetSellableCardsResponse) updates) => super.copyWith((message) => updates(message as GetSellableCardsResponse)) as GetSellableCardsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSellableCardsResponse create() => GetSellableCardsResponse._();
  @$core.override
  GetSellableCardsResponse createEmptyInstance() => create();
  static $pb.PbList<GetSellableCardsResponse> createRepeated() => $pb.PbList<GetSellableCardsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetSellableCardsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetSellableCardsResponse>(create);
  static GetSellableCardsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<SellableCard> get cards => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);
}

class GetSellProviderRequest extends $pb.GeneratedMessage {
  factory GetSellProviderRequest() => create();

  GetSellProviderRequest._();

  factory GetSellProviderRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GetSellProviderRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetSellProviderRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSellProviderRequest clone() => GetSellProviderRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSellProviderRequest copyWith(void Function(GetSellProviderRequest) updates) => super.copyWith((message) => updates(message as GetSellProviderRequest)) as GetSellProviderRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSellProviderRequest create() => GetSellProviderRequest._();
  @$core.override
  GetSellProviderRequest createEmptyInstance() => create();
  static $pb.PbList<GetSellProviderRequest> createRepeated() => $pb.PbList<GetSellProviderRequest>();
  @$core.pragma('dart2js:noInline')
  static GetSellProviderRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetSellProviderRequest>(create);
  static GetSellProviderRequest? _defaultInstance;
}

class GetSellProviderResponse extends $pb.GeneratedMessage {
  factory GetSellProviderResponse({
    $core.String? provider,
    $core.String? description,
  }) {
    final result = create();
    if (provider != null) result.provider = provider;
    if (description != null) result.description = description;
    return result;
  }

  GetSellProviderResponse._();

  factory GetSellProviderResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GetSellProviderResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetSellProviderResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'provider')
    ..aOS(2, _omitFieldNames ? '' : 'description')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSellProviderResponse clone() => GetSellProviderResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSellProviderResponse copyWith(void Function(GetSellProviderResponse) updates) => super.copyWith((message) => updates(message as GetSellProviderResponse)) as GetSellProviderResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSellProviderResponse create() => GetSellProviderResponse._();
  @$core.override
  GetSellProviderResponse createEmptyInstance() => create();
  static $pb.PbList<GetSellProviderResponse> createRepeated() => $pb.PbList<GetSellProviderResponse>();
  @$core.pragma('dart2js:noInline')
  static GetSellProviderResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetSellProviderResponse>(create);
  static GetSellProviderResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get provider => $_getSZ(0);
  @$pb.TagNumber(1)
  set provider($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasProvider() => $_has(0);
  @$pb.TagNumber(1)
  void clearProvider() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get description => $_getSZ(1);
  @$pb.TagNumber(2)
  set description($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDescription() => $_has(1);
  @$pb.TagNumber(2)
  void clearDescription() => $_clearField(2);
}

class UpdateFeatureFlagRequest extends $pb.GeneratedMessage {
  factory UpdateFeatureFlagRequest({
    $core.String? key,
    $core.String? value,
    $core.String? reason,
  }) {
    final result = create();
    if (key != null) result.key = key;
    if (value != null) result.value = value;
    if (reason != null) result.reason = reason;
    return result;
  }

  UpdateFeatureFlagRequest._();

  factory UpdateFeatureFlagRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory UpdateFeatureFlagRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateFeatureFlagRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'key')
    ..aOS(2, _omitFieldNames ? '' : 'value')
    ..aOS(3, _omitFieldNames ? '' : 'reason')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateFeatureFlagRequest clone() => UpdateFeatureFlagRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateFeatureFlagRequest copyWith(void Function(UpdateFeatureFlagRequest) updates) => super.copyWith((message) => updates(message as UpdateFeatureFlagRequest)) as UpdateFeatureFlagRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateFeatureFlagRequest create() => UpdateFeatureFlagRequest._();
  @$core.override
  UpdateFeatureFlagRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateFeatureFlagRequest> createRepeated() => $pb.PbList<UpdateFeatureFlagRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateFeatureFlagRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateFeatureFlagRequest>(create);
  static UpdateFeatureFlagRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get key => $_getSZ(0);
  @$pb.TagNumber(1)
  set key($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearKey() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get value => $_getSZ(1);
  @$pb.TagNumber(2)
  set value($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearValue() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get reason => $_getSZ(2);
  @$pb.TagNumber(3)
  set reason($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasReason() => $_has(2);
  @$pb.TagNumber(3)
  void clearReason() => $_clearField(3);
}

class UpdateFeatureFlagResponse extends $pb.GeneratedMessage {
  factory UpdateFeatureFlagResponse({
    $core.bool? success,
    $core.String? message,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    return result;
  }

  UpdateFeatureFlagResponse._();

  factory UpdateFeatureFlagResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory UpdateFeatureFlagResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateFeatureFlagResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateFeatureFlagResponse clone() => UpdateFeatureFlagResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateFeatureFlagResponse copyWith(void Function(UpdateFeatureFlagResponse) updates) => super.copyWith((message) => updates(message as UpdateFeatureFlagResponse)) as UpdateFeatureFlagResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateFeatureFlagResponse create() => UpdateFeatureFlagResponse._();
  @$core.override
  UpdateFeatureFlagResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateFeatureFlagResponse> createRepeated() => $pb.PbList<UpdateFeatureFlagResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateFeatureFlagResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateFeatureFlagResponse>(create);
  static UpdateFeatureFlagResponse? _defaultInstance;

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

class GetPayoutMethodsRequest extends $pb.GeneratedMessage {
  factory GetPayoutMethodsRequest() => create();

  GetPayoutMethodsRequest._();

  factory GetPayoutMethodsRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GetPayoutMethodsRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetPayoutMethodsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPayoutMethodsRequest clone() => GetPayoutMethodsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPayoutMethodsRequest copyWith(void Function(GetPayoutMethodsRequest) updates) => super.copyWith((message) => updates(message as GetPayoutMethodsRequest)) as GetPayoutMethodsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPayoutMethodsRequest create() => GetPayoutMethodsRequest._();
  @$core.override
  GetPayoutMethodsRequest createEmptyInstance() => create();
  static $pb.PbList<GetPayoutMethodsRequest> createRepeated() => $pb.PbList<GetPayoutMethodsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetPayoutMethodsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetPayoutMethodsRequest>(create);
  static GetPayoutMethodsRequest? _defaultInstance;
}

class PayoutMethod extends $pb.GeneratedMessage {
  factory PayoutMethod({
    $core.String? name,
    $core.bool? available,
    $core.String? currency,
  }) {
    final result = create();
    if (name != null) result.name = name;
    if (available != null) result.available = available;
    if (currency != null) result.currency = currency;
    return result;
  }

  PayoutMethod._();

  factory PayoutMethod.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory PayoutMethod.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PayoutMethod', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOB(2, _omitFieldNames ? '' : 'available')
    ..aOS(3, _omitFieldNames ? '' : 'currency')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PayoutMethod clone() => PayoutMethod()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PayoutMethod copyWith(void Function(PayoutMethod) updates) => super.copyWith((message) => updates(message as PayoutMethod)) as PayoutMethod;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PayoutMethod create() => PayoutMethod._();
  @$core.override
  PayoutMethod createEmptyInstance() => create();
  static $pb.PbList<PayoutMethod> createRepeated() => $pb.PbList<PayoutMethod>();
  @$core.pragma('dart2js:noInline')
  static PayoutMethod getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PayoutMethod>(create);
  static PayoutMethod? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get available => $_getBF(1);
  @$pb.TagNumber(2)
  set available($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAvailable() => $_has(1);
  @$pb.TagNumber(2)
  void clearAvailable() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get currency => $_getSZ(2);
  @$pb.TagNumber(3)
  set currency($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCurrency() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrency() => $_clearField(3);
}

class GetPayoutMethodsResponse extends $pb.GeneratedMessage {
  factory GetPayoutMethodsResponse({
    $core.Iterable<PayoutMethod>? methods,
  }) {
    final result = create();
    if (methods != null) result.methods.addAll(methods);
    return result;
  }

  GetPayoutMethodsResponse._();

  factory GetPayoutMethodsResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GetPayoutMethodsResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetPayoutMethodsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..pc<PayoutMethod>(1, _omitFieldNames ? '' : 'methods', $pb.PbFieldType.PM, subBuilder: PayoutMethod.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPayoutMethodsResponse clone() => GetPayoutMethodsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPayoutMethodsResponse copyWith(void Function(GetPayoutMethodsResponse) updates) => super.copyWith((message) => updates(message as GetPayoutMethodsResponse)) as GetPayoutMethodsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPayoutMethodsResponse create() => GetPayoutMethodsResponse._();
  @$core.override
  GetPayoutMethodsResponse createEmptyInstance() => create();
  static $pb.PbList<GetPayoutMethodsResponse> createRepeated() => $pb.PbList<GetPayoutMethodsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetPayoutMethodsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetPayoutMethodsResponse>(create);
  static GetPayoutMethodsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<PayoutMethod> get methods => $_getList(0);
}

class GetSellRateRequest extends $pb.GeneratedMessage {
  factory GetSellRateRequest({
    $core.String? cardType,
    $core.double? denomination,
  }) {
    final result = create();
    if (cardType != null) result.cardType = cardType;
    if (denomination != null) result.denomination = denomination;
    return result;
  }

  GetSellRateRequest._();

  factory GetSellRateRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GetSellRateRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetSellRateRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'cardType')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'denomination', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSellRateRequest clone() => GetSellRateRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSellRateRequest copyWith(void Function(GetSellRateRequest) updates) => super.copyWith((message) => updates(message as GetSellRateRequest)) as GetSellRateRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSellRateRequest create() => GetSellRateRequest._();
  @$core.override
  GetSellRateRequest createEmptyInstance() => create();
  static $pb.PbList<GetSellRateRequest> createRepeated() => $pb.PbList<GetSellRateRequest>();
  @$core.pragma('dart2js:noInline')
  static GetSellRateRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetSellRateRequest>(create);
  static GetSellRateRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get cardType => $_getSZ(0);
  @$pb.TagNumber(1)
  set cardType($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCardType() => $_has(0);
  @$pb.TagNumber(1)
  void clearCardType() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get denomination => $_getN(1);
  @$pb.TagNumber(2)
  set denomination($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDenomination() => $_has(1);
  @$pb.TagNumber(2)
  void clearDenomination() => $_clearField(2);
}

class GetSellRateResponse extends $pb.GeneratedMessage {
  factory GetSellRateResponse({
    SellRate? rate,
  }) {
    final result = create();
    if (rate != null) result.rate = rate;
    return result;
  }

  GetSellRateResponse._();

  factory GetSellRateResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GetSellRateResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetSellRateResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOM<SellRate>(1, _omitFieldNames ? '' : 'rate', subBuilder: SellRate.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSellRateResponse clone() => GetSellRateResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSellRateResponse copyWith(void Function(GetSellRateResponse) updates) => super.copyWith((message) => updates(message as GetSellRateResponse)) as GetSellRateResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSellRateResponse create() => GetSellRateResponse._();
  @$core.override
  GetSellRateResponse createEmptyInstance() => create();
  static $pb.PbList<GetSellRateResponse> createRepeated() => $pb.PbList<GetSellRateResponse>();
  @$core.pragma('dart2js:noInline')
  static GetSellRateResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetSellRateResponse>(create);
  static GetSellRateResponse? _defaultInstance;

  @$pb.TagNumber(1)
  SellRate get rate => $_getN(0);
  @$pb.TagNumber(1)
  set rate(SellRate value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRate() => $_has(0);
  @$pb.TagNumber(1)
  void clearRate() => $_clearField(1);
  @$pb.TagNumber(1)
  SellRate ensureRate() => $_ensure(0);
}

/// NOTE: user_id extracted from JWT token
class SellGiftCardRequest extends $pb.GeneratedMessage {
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
    final result = create();
    if (cardType != null) result.cardType = cardType;
    if (cardNumber != null) result.cardNumber = cardNumber;
    if (cardPin != null) result.cardPin = cardPin;
    if (denomination != null) result.denomination = denomination;
    if (currency != null) result.currency = currency;
    if (images != null) result.images.addAll(images);
    if (idempotencyKey != null) result.idempotencyKey = idempotencyKey;
    if (transactionId != null) result.transactionId = transactionId;
    if (verificationToken != null) result.verificationToken = verificationToken;
    if (providerName != null) result.providerName = providerName;
    if (imageUrls != null) result.imageUrls.addAll(imageUrls);
    if (imageKeys != null) result.imageKeys.addAll(imageKeys);
    if (ocrBrand != null) result.ocrBrand = ocrBrand;
    if (ocrCardNumber != null) result.ocrCardNumber = ocrCardNumber;
    if (ocrPin != null) result.ocrPin = ocrPin;
    if (ocrDenomination != null) result.ocrDenomination = ocrDenomination;
    if (ocrCurrency != null) result.ocrCurrency = ocrCurrency;
    if (cardCountry != null) result.cardCountry = cardCountry;
    if (cardFormat != null) result.cardFormat = cardFormat;
    if (ocrConfidence != null) result.ocrConfidence = ocrConfidence;
    if (subcategoryId != null) result.subcategoryId = subcategoryId;
    if (form != null) result.form = form;
    if (payoutMethod != null) result.payoutMethod = payoutMethod;
    if (cardCode != null) result.cardCode = cardCode;
    if (disclaimerAccepted != null) result.disclaimerAccepted = disclaimerAccepted;
    return result;
  }

  SellGiftCardRequest._();

  factory SellGiftCardRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory SellGiftCardRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SellGiftCardRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'cardType')
    ..aOS(2, _omitFieldNames ? '' : 'cardNumber')
    ..aOS(3, _omitFieldNames ? '' : 'cardPin')
    ..a<$core.double>(4, _omitFieldNames ? '' : 'denomination', $pb.PbFieldType.OD)
    ..aOS(5, _omitFieldNames ? '' : 'currency')
    ..pPS(6, _omitFieldNames ? '' : 'images')
    ..aOS(7, _omitFieldNames ? '' : 'idempotencyKey')
    ..aOS(8, _omitFieldNames ? '' : 'transactionId')
    ..aOS(9, _omitFieldNames ? '' : 'verificationToken')
    ..aOS(10, _omitFieldNames ? '' : 'providerName')
    ..pPS(11, _omitFieldNames ? '' : 'imageUrls')
    ..pPS(12, _omitFieldNames ? '' : 'imageKeys')
    ..aOS(13, _omitFieldNames ? '' : 'ocrBrand')
    ..aOS(14, _omitFieldNames ? '' : 'ocrCardNumber')
    ..aOS(15, _omitFieldNames ? '' : 'ocrPin')
    ..a<$core.double>(16, _omitFieldNames ? '' : 'ocrDenomination', $pb.PbFieldType.OD)
    ..aOS(17, _omitFieldNames ? '' : 'ocrCurrency')
    ..aOS(18, _omitFieldNames ? '' : 'cardCountry')
    ..aOS(19, _omitFieldNames ? '' : 'cardFormat')
    ..a<$core.double>(20, _omitFieldNames ? '' : 'ocrConfidence', $pb.PbFieldType.OD)
    ..aOS(21, _omitFieldNames ? '' : 'subcategoryId')
    ..aOS(22, _omitFieldNames ? '' : 'form')
    ..aOS(23, _omitFieldNames ? '' : 'payoutMethod')
    ..aOS(24, _omitFieldNames ? '' : 'cardCode')
    ..aOB(25, _omitFieldNames ? '' : 'disclaimerAccepted')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SellGiftCardRequest clone() => SellGiftCardRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SellGiftCardRequest copyWith(void Function(SellGiftCardRequest) updates) => super.copyWith((message) => updates(message as SellGiftCardRequest)) as SellGiftCardRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SellGiftCardRequest create() => SellGiftCardRequest._();
  @$core.override
  SellGiftCardRequest createEmptyInstance() => create();
  static $pb.PbList<SellGiftCardRequest> createRepeated() => $pb.PbList<SellGiftCardRequest>();
  @$core.pragma('dart2js:noInline')
  static SellGiftCardRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SellGiftCardRequest>(create);
  static SellGiftCardRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get cardType => $_getSZ(0);
  @$pb.TagNumber(1)
  set cardType($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCardType() => $_has(0);
  @$pb.TagNumber(1)
  void clearCardType() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get cardNumber => $_getSZ(1);
  @$pb.TagNumber(2)
  set cardNumber($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCardNumber() => $_has(1);
  @$pb.TagNumber(2)
  void clearCardNumber() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get cardPin => $_getSZ(2);
  @$pb.TagNumber(3)
  set cardPin($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCardPin() => $_has(2);
  @$pb.TagNumber(3)
  void clearCardPin() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get denomination => $_getN(3);
  @$pb.TagNumber(4)
  set denomination($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDenomination() => $_has(3);
  @$pb.TagNumber(4)
  void clearDenomination() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get currency => $_getSZ(4);
  @$pb.TagNumber(5)
  set currency($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCurrency() => $_has(4);
  @$pb.TagNumber(5)
  void clearCurrency() => $_clearField(5);

  @$pb.TagNumber(6)
  $pb.PbList<$core.String> get images => $_getList(5);

  @$pb.TagNumber(7)
  $core.String get idempotencyKey => $_getSZ(6);
  @$pb.TagNumber(7)
  set idempotencyKey($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasIdempotencyKey() => $_has(6);
  @$pb.TagNumber(7)
  void clearIdempotencyKey() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get transactionId => $_getSZ(7);
  @$pb.TagNumber(8)
  set transactionId($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasTransactionId() => $_has(7);
  @$pb.TagNumber(8)
  void clearTransactionId() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get verificationToken => $_getSZ(8);
  @$pb.TagNumber(9)
  set verificationToken($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasVerificationToken() => $_has(8);
  @$pb.TagNumber(9)
  void clearVerificationToken() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get providerName => $_getSZ(9);
  @$pb.TagNumber(10)
  set providerName($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasProviderName() => $_has(9);
  @$pb.TagNumber(10)
  void clearProviderName() => $_clearField(10);

  /// Image upload fields (from UploadSellImage)
  @$pb.TagNumber(11)
  $pb.PbList<$core.String> get imageUrls => $_getList(10);

  @$pb.TagNumber(12)
  $pb.PbList<$core.String> get imageKeys => $_getList(11);

  /// OCR extraction results (from ExtractCardDetails)
  @$pb.TagNumber(13)
  $core.String get ocrBrand => $_getSZ(12);
  @$pb.TagNumber(13)
  set ocrBrand($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasOcrBrand() => $_has(12);
  @$pb.TagNumber(13)
  void clearOcrBrand() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.String get ocrCardNumber => $_getSZ(13);
  @$pb.TagNumber(14)
  set ocrCardNumber($core.String value) => $_setString(13, value);
  @$pb.TagNumber(14)
  $core.bool hasOcrCardNumber() => $_has(13);
  @$pb.TagNumber(14)
  void clearOcrCardNumber() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.String get ocrPin => $_getSZ(14);
  @$pb.TagNumber(15)
  set ocrPin($core.String value) => $_setString(14, value);
  @$pb.TagNumber(15)
  $core.bool hasOcrPin() => $_has(14);
  @$pb.TagNumber(15)
  void clearOcrPin() => $_clearField(15);

  @$pb.TagNumber(16)
  $core.double get ocrDenomination => $_getN(15);
  @$pb.TagNumber(16)
  set ocrDenomination($core.double value) => $_setDouble(15, value);
  @$pb.TagNumber(16)
  $core.bool hasOcrDenomination() => $_has(15);
  @$pb.TagNumber(16)
  void clearOcrDenomination() => $_clearField(16);

  @$pb.TagNumber(17)
  $core.String get ocrCurrency => $_getSZ(16);
  @$pb.TagNumber(17)
  set ocrCurrency($core.String value) => $_setString(16, value);
  @$pb.TagNumber(17)
  $core.bool hasOcrCurrency() => $_has(16);
  @$pb.TagNumber(17)
  void clearOcrCurrency() => $_clearField(17);

  /// Card origin details
  @$pb.TagNumber(18)
  $core.String get cardCountry => $_getSZ(17);
  @$pb.TagNumber(18)
  set cardCountry($core.String value) => $_setString(17, value);
  @$pb.TagNumber(18)
  $core.bool hasCardCountry() => $_has(17);
  @$pb.TagNumber(18)
  void clearCardCountry() => $_clearField(18);

  @$pb.TagNumber(19)
  $core.String get cardFormat => $_getSZ(18);
  @$pb.TagNumber(19)
  set cardFormat($core.String value) => $_setString(18, value);
  @$pb.TagNumber(19)
  $core.bool hasCardFormat() => $_has(18);
  @$pb.TagNumber(19)
  void clearCardFormat() => $_clearField(19);

  @$pb.TagNumber(20)
  $core.double get ocrConfidence => $_getN(19);
  @$pb.TagNumber(20)
  set ocrConfidence($core.double value) => $_setDouble(19, value);
  @$pb.TagNumber(20)
  $core.bool hasOcrConfidence() => $_has(19);
  @$pb.TagNumber(20)
  void clearOcrConfidence() => $_clearField(20);

  /// Prestmit-aligned fields (per documentation.prestmit.io):
  /// subcategory_id = sellableGiftcards[i].id from rate-calculator-data,
  /// sent verbatim as `giftcard_id` to /giftcard-trade/sell/create.
  @$pb.TagNumber(21)
  $core.String get subcategoryId => $_getSZ(20);
  @$pb.TagNumber(21)
  set subcategoryId($core.String value) => $_setString(20, value);
  @$pb.TagNumber(21)
  $core.bool hasSubcategoryId() => $_has(20);
  @$pb.TagNumber(21)
  void clearSubcategoryId() => $_clearField(21);

  /// form = "Physical" | "Ecode". Branches the multipart payload:
  /// Physical → attachments[]; Ecode → comments=card_code.
  @$pb.TagNumber(22)
  $core.String get form => $_getSZ(21);
  @$pb.TagNumber(22)
  set form($core.String value) => $_setString(21, value);
  @$pb.TagNumber(22)
  $core.bool hasForm() => $_has(21);
  @$pb.TagNumber(22)
  void clearForm() => $_clearField(22);

  /// payout_method = name from sellGiftcardPayoutMethods (e.g.
  /// "NAIRA", "CEDIS"). Backend also resolves from system_settings
  /// when this is empty.
  @$pb.TagNumber(23)
  $core.String get payoutMethod => $_getSZ(22);
  @$pb.TagNumber(23)
  set payoutMethod($core.String value) => $_setString(22, value);
  @$pb.TagNumber(23)
  $core.bool hasPayoutMethod() => $_has(22);
  @$pb.TagNumber(23)
  void clearPayoutMethod() => $_clearField(23);

  /// card_code = explicit Ecode value (replaces card_number/card_pin
  /// for Ecode submissions).
  @$pb.TagNumber(24)
  $core.String get cardCode => $_getSZ(23);
  @$pb.TagNumber(24)
  set cardCode($core.String value) => $_setString(23, value);
  @$pb.TagNumber(24)
  $core.bool hasCardCode() => $_has(23);
  @$pb.TagNumber(24)
  void clearCardCode() => $_clearField(24);

  /// disclaimer_accepted MUST be true. The Flutter app gates Submit
  /// behind a checkbox; the backend rejects when false to enforce the
  /// operator's audit trail of explicit user acceptance.
  @$pb.TagNumber(25)
  $core.bool get disclaimerAccepted => $_getBF(24);
  @$pb.TagNumber(25)
  set disclaimerAccepted($core.bool value) => $_setBool(24, value);
  @$pb.TagNumber(25)
  $core.bool hasDisclaimerAccepted() => $_has(24);
  @$pb.TagNumber(25)
  void clearDisclaimerAccepted() => $_clearField(25);
}

class SellGiftCardResponse extends $pb.GeneratedMessage {
  factory SellGiftCardResponse({
    GiftCardSale? sale,
    $core.String? message,
  }) {
    final result = create();
    if (sale != null) result.sale = sale;
    if (message != null) result.message = message;
    return result;
  }

  SellGiftCardResponse._();

  factory SellGiftCardResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory SellGiftCardResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SellGiftCardResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOM<GiftCardSale>(1, _omitFieldNames ? '' : 'sale', subBuilder: GiftCardSale.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SellGiftCardResponse clone() => SellGiftCardResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SellGiftCardResponse copyWith(void Function(SellGiftCardResponse) updates) => super.copyWith((message) => updates(message as SellGiftCardResponse)) as SellGiftCardResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SellGiftCardResponse create() => SellGiftCardResponse._();
  @$core.override
  SellGiftCardResponse createEmptyInstance() => create();
  static $pb.PbList<SellGiftCardResponse> createRepeated() => $pb.PbList<SellGiftCardResponse>();
  @$core.pragma('dart2js:noInline')
  static SellGiftCardResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SellGiftCardResponse>(create);
  static SellGiftCardResponse? _defaultInstance;

  @$pb.TagNumber(1)
  GiftCardSale get sale => $_getN(0);
  @$pb.TagNumber(1)
  set sale(GiftCardSale value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasSale() => $_has(0);
  @$pb.TagNumber(1)
  void clearSale() => $_clearField(1);
  @$pb.TagNumber(1)
  GiftCardSale ensureSale() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);
}

class GetSellStatusRequest extends $pb.GeneratedMessage {
  factory GetSellStatusRequest({
    $core.String? saleId,
  }) {
    final result = create();
    if (saleId != null) result.saleId = saleId;
    return result;
  }

  GetSellStatusRequest._();

  factory GetSellStatusRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GetSellStatusRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetSellStatusRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'saleId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSellStatusRequest clone() => GetSellStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSellStatusRequest copyWith(void Function(GetSellStatusRequest) updates) => super.copyWith((message) => updates(message as GetSellStatusRequest)) as GetSellStatusRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSellStatusRequest create() => GetSellStatusRequest._();
  @$core.override
  GetSellStatusRequest createEmptyInstance() => create();
  static $pb.PbList<GetSellStatusRequest> createRepeated() => $pb.PbList<GetSellStatusRequest>();
  @$core.pragma('dart2js:noInline')
  static GetSellStatusRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetSellStatusRequest>(create);
  static GetSellStatusRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get saleId => $_getSZ(0);
  @$pb.TagNumber(1)
  set saleId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSaleId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSaleId() => $_clearField(1);
}

class GetSellStatusResponse extends $pb.GeneratedMessage {
  factory GetSellStatusResponse({
    GiftCardSale? sale,
  }) {
    final result = create();
    if (sale != null) result.sale = sale;
    return result;
  }

  GetSellStatusResponse._();

  factory GetSellStatusResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GetSellStatusResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetSellStatusResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOM<GiftCardSale>(1, _omitFieldNames ? '' : 'sale', subBuilder: GiftCardSale.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSellStatusResponse clone() => GetSellStatusResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSellStatusResponse copyWith(void Function(GetSellStatusResponse) updates) => super.copyWith((message) => updates(message as GetSellStatusResponse)) as GetSellStatusResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSellStatusResponse create() => GetSellStatusResponse._();
  @$core.override
  GetSellStatusResponse createEmptyInstance() => create();
  static $pb.PbList<GetSellStatusResponse> createRepeated() => $pb.PbList<GetSellStatusResponse>();
  @$core.pragma('dart2js:noInline')
  static GetSellStatusResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetSellStatusResponse>(create);
  static GetSellStatusResponse? _defaultInstance;

  @$pb.TagNumber(1)
  GiftCardSale get sale => $_getN(0);
  @$pb.TagNumber(1)
  set sale(GiftCardSale value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasSale() => $_has(0);
  @$pb.TagNumber(1)
  void clearSale() => $_clearField(1);
  @$pb.TagNumber(1)
  GiftCardSale ensureSale() => $_ensure(0);
}

/// NOTE: user_id extracted from JWT token
class GetMySalesRequest extends $pb.GeneratedMessage {
  factory GetMySalesRequest({
    $core.String? status,
    $core.int? limit,
    $core.int? offset,
  }) {
    final result = create();
    if (status != null) result.status = status;
    if (limit != null) result.limit = limit;
    if (offset != null) result.offset = offset;
    return result;
  }

  GetMySalesRequest._();

  factory GetMySalesRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GetMySalesRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetMySalesRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'status')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMySalesRequest clone() => GetMySalesRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMySalesRequest copyWith(void Function(GetMySalesRequest) updates) => super.copyWith((message) => updates(message as GetMySalesRequest)) as GetMySalesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMySalesRequest create() => GetMySalesRequest._();
  @$core.override
  GetMySalesRequest createEmptyInstance() => create();
  static $pb.PbList<GetMySalesRequest> createRepeated() => $pb.PbList<GetMySalesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMySalesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMySalesRequest>(create);
  static GetMySalesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get status => $_getSZ(0);
  @$pb.TagNumber(1)
  set status($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => $_clearField(1);

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

class GetMySalesResponse extends $pb.GeneratedMessage {
  factory GetMySalesResponse({
    $core.Iterable<GiftCardSale>? sales,
    $core.int? total,
  }) {
    final result = create();
    if (sales != null) result.sales.addAll(sales);
    if (total != null) result.total = total;
    return result;
  }

  GetMySalesResponse._();

  factory GetMySalesResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GetMySalesResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetMySalesResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..pc<GiftCardSale>(1, _omitFieldNames ? '' : 'sales', $pb.PbFieldType.PM, subBuilder: GiftCardSale.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMySalesResponse clone() => GetMySalesResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMySalesResponse copyWith(void Function(GetMySalesResponse) updates) => super.copyWith((message) => updates(message as GetMySalesResponse)) as GetMySalesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMySalesResponse create() => GetMySalesResponse._();
  @$core.override
  GetMySalesResponse createEmptyInstance() => create();
  static $pb.PbList<GetMySalesResponse> createRepeated() => $pb.PbList<GetMySalesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMySalesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMySalesResponse>(create);
  static GetMySalesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<GiftCardSale> get sales => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);
}

class UploadSellImageRequest extends $pb.GeneratedMessage {
  factory UploadSellImageRequest({
    $core.String? imageData,
    $core.String? contentType,
    $core.String? filename,
  }) {
    final result = create();
    if (imageData != null) result.imageData = imageData;
    if (contentType != null) result.contentType = contentType;
    if (filename != null) result.filename = filename;
    return result;
  }

  UploadSellImageRequest._();

  factory UploadSellImageRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory UploadSellImageRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UploadSellImageRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'imageData')
    ..aOS(2, _omitFieldNames ? '' : 'contentType')
    ..aOS(3, _omitFieldNames ? '' : 'filename')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UploadSellImageRequest clone() => UploadSellImageRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UploadSellImageRequest copyWith(void Function(UploadSellImageRequest) updates) => super.copyWith((message) => updates(message as UploadSellImageRequest)) as UploadSellImageRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UploadSellImageRequest create() => UploadSellImageRequest._();
  @$core.override
  UploadSellImageRequest createEmptyInstance() => create();
  static $pb.PbList<UploadSellImageRequest> createRepeated() => $pb.PbList<UploadSellImageRequest>();
  @$core.pragma('dart2js:noInline')
  static UploadSellImageRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UploadSellImageRequest>(create);
  static UploadSellImageRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get imageData => $_getSZ(0);
  @$pb.TagNumber(1)
  set imageData($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasImageData() => $_has(0);
  @$pb.TagNumber(1)
  void clearImageData() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get contentType => $_getSZ(1);
  @$pb.TagNumber(2)
  set contentType($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasContentType() => $_has(1);
  @$pb.TagNumber(2)
  void clearContentType() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get filename => $_getSZ(2);
  @$pb.TagNumber(3)
  set filename($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasFilename() => $_has(2);
  @$pb.TagNumber(3)
  void clearFilename() => $_clearField(3);
}

class UploadSellImageResponse extends $pb.GeneratedMessage {
  factory UploadSellImageResponse({
    $core.String? imageUrl,
    $core.String? imageKey,
  }) {
    final result = create();
    if (imageUrl != null) result.imageUrl = imageUrl;
    if (imageKey != null) result.imageKey = imageKey;
    return result;
  }

  UploadSellImageResponse._();

  factory UploadSellImageResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory UploadSellImageResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UploadSellImageResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'imageUrl')
    ..aOS(2, _omitFieldNames ? '' : 'imageKey')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UploadSellImageResponse clone() => UploadSellImageResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UploadSellImageResponse copyWith(void Function(UploadSellImageResponse) updates) => super.copyWith((message) => updates(message as UploadSellImageResponse)) as UploadSellImageResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UploadSellImageResponse create() => UploadSellImageResponse._();
  @$core.override
  UploadSellImageResponse createEmptyInstance() => create();
  static $pb.PbList<UploadSellImageResponse> createRepeated() => $pb.PbList<UploadSellImageResponse>();
  @$core.pragma('dart2js:noInline')
  static UploadSellImageResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UploadSellImageResponse>(create);
  static UploadSellImageResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get imageUrl => $_getSZ(0);
  @$pb.TagNumber(1)
  set imageUrl($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasImageUrl() => $_has(0);
  @$pb.TagNumber(1)
  void clearImageUrl() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get imageKey => $_getSZ(1);
  @$pb.TagNumber(2)
  set imageKey($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasImageKey() => $_has(1);
  @$pb.TagNumber(2)
  void clearImageKey() => $_clearField(2);
}

class ExtractCardDetailsRequest extends $pb.GeneratedMessage {
  factory ExtractCardDetailsRequest({
    $core.Iterable<$core.String>? imageUrls,
  }) {
    final result = create();
    if (imageUrls != null) result.imageUrls.addAll(imageUrls);
    return result;
  }

  ExtractCardDetailsRequest._();

  factory ExtractCardDetailsRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory ExtractCardDetailsRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ExtractCardDetailsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'imageUrls')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExtractCardDetailsRequest clone() => ExtractCardDetailsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExtractCardDetailsRequest copyWith(void Function(ExtractCardDetailsRequest) updates) => super.copyWith((message) => updates(message as ExtractCardDetailsRequest)) as ExtractCardDetailsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ExtractCardDetailsRequest create() => ExtractCardDetailsRequest._();
  @$core.override
  ExtractCardDetailsRequest createEmptyInstance() => create();
  static $pb.PbList<ExtractCardDetailsRequest> createRepeated() => $pb.PbList<ExtractCardDetailsRequest>();
  @$core.pragma('dart2js:noInline')
  static ExtractCardDetailsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ExtractCardDetailsRequest>(create);
  static ExtractCardDetailsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$core.String> get imageUrls => $_getList(0);
}

class ExtractCardDetailsResponse extends $pb.GeneratedMessage {
  factory ExtractCardDetailsResponse({
    $core.String? brand,
    $core.String? cardNumber,
    $core.String? pin,
    $core.double? denomination,
    $core.String? currency,
    $core.double? confidence,
    $core.String? rawText,
  }) {
    final result = create();
    if (brand != null) result.brand = brand;
    if (cardNumber != null) result.cardNumber = cardNumber;
    if (pin != null) result.pin = pin;
    if (denomination != null) result.denomination = denomination;
    if (currency != null) result.currency = currency;
    if (confidence != null) result.confidence = confidence;
    if (rawText != null) result.rawText = rawText;
    return result;
  }

  ExtractCardDetailsResponse._();

  factory ExtractCardDetailsResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory ExtractCardDetailsResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ExtractCardDetailsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'brand')
    ..aOS(2, _omitFieldNames ? '' : 'cardNumber')
    ..aOS(3, _omitFieldNames ? '' : 'pin')
    ..a<$core.double>(4, _omitFieldNames ? '' : 'denomination', $pb.PbFieldType.OD)
    ..aOS(5, _omitFieldNames ? '' : 'currency')
    ..a<$core.double>(6, _omitFieldNames ? '' : 'confidence', $pb.PbFieldType.OD)
    ..aOS(7, _omitFieldNames ? '' : 'rawText')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExtractCardDetailsResponse clone() => ExtractCardDetailsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExtractCardDetailsResponse copyWith(void Function(ExtractCardDetailsResponse) updates) => super.copyWith((message) => updates(message as ExtractCardDetailsResponse)) as ExtractCardDetailsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ExtractCardDetailsResponse create() => ExtractCardDetailsResponse._();
  @$core.override
  ExtractCardDetailsResponse createEmptyInstance() => create();
  static $pb.PbList<ExtractCardDetailsResponse> createRepeated() => $pb.PbList<ExtractCardDetailsResponse>();
  @$core.pragma('dart2js:noInline')
  static ExtractCardDetailsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ExtractCardDetailsResponse>(create);
  static ExtractCardDetailsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get brand => $_getSZ(0);
  @$pb.TagNumber(1)
  set brand($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasBrand() => $_has(0);
  @$pb.TagNumber(1)
  void clearBrand() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get cardNumber => $_getSZ(1);
  @$pb.TagNumber(2)
  set cardNumber($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCardNumber() => $_has(1);
  @$pb.TagNumber(2)
  void clearCardNumber() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get pin => $_getSZ(2);
  @$pb.TagNumber(3)
  set pin($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPin() => $_has(2);
  @$pb.TagNumber(3)
  void clearPin() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get denomination => $_getN(3);
  @$pb.TagNumber(4)
  set denomination($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDenomination() => $_has(3);
  @$pb.TagNumber(4)
  void clearDenomination() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get currency => $_getSZ(4);
  @$pb.TagNumber(5)
  set currency($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCurrency() => $_has(4);
  @$pb.TagNumber(5)
  void clearCurrency() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.double get confidence => $_getN(5);
  @$pb.TagNumber(6)
  set confidence($core.double value) => $_setDouble(5, value);
  @$pb.TagNumber(6)
  $core.bool hasConfidence() => $_has(5);
  @$pb.TagNumber(6)
  void clearConfidence() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get rawText => $_getSZ(6);
  @$pb.TagNumber(7)
  set rawText($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasRawText() => $_has(6);
  @$pb.TagNumber(7)
  void clearRawText() => $_clearField(7);
}

class AdminListPendingSalesRequest extends $pb.GeneratedMessage {
  factory AdminListPendingSalesRequest({
    $core.String? status,
    $core.int? limit,
    $core.int? offset,
  }) {
    final result = create();
    if (status != null) result.status = status;
    if (limit != null) result.limit = limit;
    if (offset != null) result.offset = offset;
    return result;
  }

  AdminListPendingSalesRequest._();

  factory AdminListPendingSalesRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory AdminListPendingSalesRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AdminListPendingSalesRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'status')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminListPendingSalesRequest clone() => AdminListPendingSalesRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminListPendingSalesRequest copyWith(void Function(AdminListPendingSalesRequest) updates) => super.copyWith((message) => updates(message as AdminListPendingSalesRequest)) as AdminListPendingSalesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminListPendingSalesRequest create() => AdminListPendingSalesRequest._();
  @$core.override
  AdminListPendingSalesRequest createEmptyInstance() => create();
  static $pb.PbList<AdminListPendingSalesRequest> createRepeated() => $pb.PbList<AdminListPendingSalesRequest>();
  @$core.pragma('dart2js:noInline')
  static AdminListPendingSalesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminListPendingSalesRequest>(create);
  static AdminListPendingSalesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get status => $_getSZ(0);
  @$pb.TagNumber(1)
  set status($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => $_clearField(1);

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

class AdminListPendingSalesResponse extends $pb.GeneratedMessage {
  factory AdminListPendingSalesResponse({
    $core.Iterable<GiftCardSale>? sales,
    $core.int? total,
  }) {
    final result = create();
    if (sales != null) result.sales.addAll(sales);
    if (total != null) result.total = total;
    return result;
  }

  AdminListPendingSalesResponse._();

  factory AdminListPendingSalesResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory AdminListPendingSalesResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AdminListPendingSalesResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..pc<GiftCardSale>(1, _omitFieldNames ? '' : 'sales', $pb.PbFieldType.PM, subBuilder: GiftCardSale.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminListPendingSalesResponse clone() => AdminListPendingSalesResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminListPendingSalesResponse copyWith(void Function(AdminListPendingSalesResponse) updates) => super.copyWith((message) => updates(message as AdminListPendingSalesResponse)) as AdminListPendingSalesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminListPendingSalesResponse create() => AdminListPendingSalesResponse._();
  @$core.override
  AdminListPendingSalesResponse createEmptyInstance() => create();
  static $pb.PbList<AdminListPendingSalesResponse> createRepeated() => $pb.PbList<AdminListPendingSalesResponse>();
  @$core.pragma('dart2js:noInline')
  static AdminListPendingSalesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminListPendingSalesResponse>(create);
  static AdminListPendingSalesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<GiftCardSale> get sales => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);
}

/// Buy-side admin transactions — flat projection of the giftcards table.
/// Status mirrors the chk_giftcard_status enum:
/// pending | available | redeemed | transferred | expired | failed.
class AdminListBuyTransactionsRequest extends $pb.GeneratedMessage {
  factory AdminListBuyTransactionsRequest({
    $core.String? status,
    $core.String? search,
    $core.int? page,
    $core.int? limit,
  }) {
    final result = create();
    if (status != null) result.status = status;
    if (search != null) result.search = search;
    if (page != null) result.page = page;
    if (limit != null) result.limit = limit;
    return result;
  }

  AdminListBuyTransactionsRequest._();

  factory AdminListBuyTransactionsRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory AdminListBuyTransactionsRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AdminListBuyTransactionsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'status')
    ..aOS(2, _omitFieldNames ? '' : 'search')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminListBuyTransactionsRequest clone() => AdminListBuyTransactionsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminListBuyTransactionsRequest copyWith(void Function(AdminListBuyTransactionsRequest) updates) => super.copyWith((message) => updates(message as AdminListBuyTransactionsRequest)) as AdminListBuyTransactionsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminListBuyTransactionsRequest create() => AdminListBuyTransactionsRequest._();
  @$core.override
  AdminListBuyTransactionsRequest createEmptyInstance() => create();
  static $pb.PbList<AdminListBuyTransactionsRequest> createRepeated() => $pb.PbList<AdminListBuyTransactionsRequest>();
  @$core.pragma('dart2js:noInline')
  static AdminListBuyTransactionsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminListBuyTransactionsRequest>(create);
  static AdminListBuyTransactionsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get status => $_getSZ(0);
  @$pb.TagNumber(1)
  set status($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get search => $_getSZ(1);
  @$pb.TagNumber(2)
  set search($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSearch() => $_has(1);
  @$pb.TagNumber(2)
  void clearSearch() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get page => $_getIZ(2);
  @$pb.TagNumber(3)
  set page($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPage() => $_has(2);
  @$pb.TagNumber(3)
  void clearPage() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get limit => $_getIZ(3);
  @$pb.TagNumber(4)
  set limit($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasLimit() => $_has(3);
  @$pb.TagNumber(4)
  void clearLimit() => $_clearField(4);
}

class AdminBuyTransaction extends $pb.GeneratedMessage {
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
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (userId != null) result.userId = userId;
    if (brandName != null) result.brandName = brandName;
    if (originalAmount != null) result.originalAmount = originalAmount;
    if (currency != null) result.currency = currency;
    if (status != null) result.status = status;
    if (idempotencyKey != null) result.idempotencyKey = idempotencyKey;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    if (recipientEmail != null) result.recipientEmail = recipientEmail;
    if (recipientName != null) result.recipientName = recipientName;
    return result;
  }

  AdminBuyTransaction._();

  factory AdminBuyTransaction.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory AdminBuyTransaction.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AdminBuyTransaction', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'brandName')
    ..a<$core.double>(4, _omitFieldNames ? '' : 'originalAmount', $pb.PbFieldType.OD)
    ..aOS(5, _omitFieldNames ? '' : 'currency')
    ..aOS(6, _omitFieldNames ? '' : 'status')
    ..aOS(7, _omitFieldNames ? '' : 'idempotencyKey')
    ..aOS(8, _omitFieldNames ? '' : 'createdAt')
    ..aOS(9, _omitFieldNames ? '' : 'updatedAt')
    ..aOS(10, _omitFieldNames ? '' : 'recipientEmail')
    ..aOS(11, _omitFieldNames ? '' : 'recipientName')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminBuyTransaction clone() => AdminBuyTransaction()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminBuyTransaction copyWith(void Function(AdminBuyTransaction) updates) => super.copyWith((message) => updates(message as AdminBuyTransaction)) as AdminBuyTransaction;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminBuyTransaction create() => AdminBuyTransaction._();
  @$core.override
  AdminBuyTransaction createEmptyInstance() => create();
  static $pb.PbList<AdminBuyTransaction> createRepeated() => $pb.PbList<AdminBuyTransaction>();
  @$core.pragma('dart2js:noInline')
  static AdminBuyTransaction getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminBuyTransaction>(create);
  static AdminBuyTransaction? _defaultInstance;

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
  $core.String get brandName => $_getSZ(2);
  @$pb.TagNumber(3)
  set brandName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasBrandName() => $_has(2);
  @$pb.TagNumber(3)
  void clearBrandName() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get originalAmount => $_getN(3);
  @$pb.TagNumber(4)
  set originalAmount($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasOriginalAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearOriginalAmount() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get currency => $_getSZ(4);
  @$pb.TagNumber(5)
  set currency($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCurrency() => $_has(4);
  @$pb.TagNumber(5)
  void clearCurrency() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get status => $_getSZ(5);
  @$pb.TagNumber(6)
  set status($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasStatus() => $_has(5);
  @$pb.TagNumber(6)
  void clearStatus() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get idempotencyKey => $_getSZ(6);
  @$pb.TagNumber(7)
  set idempotencyKey($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasIdempotencyKey() => $_has(6);
  @$pb.TagNumber(7)
  void clearIdempotencyKey() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get createdAt => $_getSZ(7);
  @$pb.TagNumber(8)
  set createdAt($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasCreatedAt() => $_has(7);
  @$pb.TagNumber(8)
  void clearCreatedAt() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get updatedAt => $_getSZ(8);
  @$pb.TagNumber(9)
  set updatedAt($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasUpdatedAt() => $_has(8);
  @$pb.TagNumber(9)
  void clearUpdatedAt() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get recipientEmail => $_getSZ(9);
  @$pb.TagNumber(10)
  set recipientEmail($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasRecipientEmail() => $_has(9);
  @$pb.TagNumber(10)
  void clearRecipientEmail() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get recipientName => $_getSZ(10);
  @$pb.TagNumber(11)
  set recipientName($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasRecipientName() => $_has(10);
  @$pb.TagNumber(11)
  void clearRecipientName() => $_clearField(11);
}

class AdminListBuyTransactionsResponse extends $pb.GeneratedMessage {
  factory AdminListBuyTransactionsResponse({
    $core.Iterable<AdminBuyTransaction>? transactions,
    $core.int? total,
    $core.int? page,
    $core.int? limit,
  }) {
    final result = create();
    if (transactions != null) result.transactions.addAll(transactions);
    if (total != null) result.total = total;
    if (page != null) result.page = page;
    if (limit != null) result.limit = limit;
    return result;
  }

  AdminListBuyTransactionsResponse._();

  factory AdminListBuyTransactionsResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory AdminListBuyTransactionsResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AdminListBuyTransactionsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..pc<AdminBuyTransaction>(1, _omitFieldNames ? '' : 'transactions', $pb.PbFieldType.PM, subBuilder: AdminBuyTransaction.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminListBuyTransactionsResponse clone() => AdminListBuyTransactionsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminListBuyTransactionsResponse copyWith(void Function(AdminListBuyTransactionsResponse) updates) => super.copyWith((message) => updates(message as AdminListBuyTransactionsResponse)) as AdminListBuyTransactionsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminListBuyTransactionsResponse create() => AdminListBuyTransactionsResponse._();
  @$core.override
  AdminListBuyTransactionsResponse createEmptyInstance() => create();
  static $pb.PbList<AdminListBuyTransactionsResponse> createRepeated() => $pb.PbList<AdminListBuyTransactionsResponse>();
  @$core.pragma('dart2js:noInline')
  static AdminListBuyTransactionsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminListBuyTransactionsResponse>(create);
  static AdminListBuyTransactionsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<AdminBuyTransaction> get transactions => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get page => $_getIZ(2);
  @$pb.TagNumber(3)
  set page($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPage() => $_has(2);
  @$pb.TagNumber(3)
  void clearPage() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get limit => $_getIZ(3);
  @$pb.TagNumber(4)
  set limit($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasLimit() => $_has(3);
  @$pb.TagNumber(4)
  void clearLimit() => $_clearField(4);
}

class AdminGetSaleDetailRequest extends $pb.GeneratedMessage {
  factory AdminGetSaleDetailRequest({
    $core.String? saleId,
  }) {
    final result = create();
    if (saleId != null) result.saleId = saleId;
    return result;
  }

  AdminGetSaleDetailRequest._();

  factory AdminGetSaleDetailRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory AdminGetSaleDetailRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AdminGetSaleDetailRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'saleId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminGetSaleDetailRequest clone() => AdminGetSaleDetailRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminGetSaleDetailRequest copyWith(void Function(AdminGetSaleDetailRequest) updates) => super.copyWith((message) => updates(message as AdminGetSaleDetailRequest)) as AdminGetSaleDetailRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminGetSaleDetailRequest create() => AdminGetSaleDetailRequest._();
  @$core.override
  AdminGetSaleDetailRequest createEmptyInstance() => create();
  static $pb.PbList<AdminGetSaleDetailRequest> createRepeated() => $pb.PbList<AdminGetSaleDetailRequest>();
  @$core.pragma('dart2js:noInline')
  static AdminGetSaleDetailRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminGetSaleDetailRequest>(create);
  static AdminGetSaleDetailRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get saleId => $_getSZ(0);
  @$pb.TagNumber(1)
  set saleId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSaleId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSaleId() => $_clearField(1);
}

class AdminGetSaleDetailResponse extends $pb.GeneratedMessage {
  factory AdminGetSaleDetailResponse({
    GiftCardSale? sale,
    $core.Iterable<$core.String>? imageDownloadUrls,
    $core.String? userEmail,
    $core.String? userName,
  }) {
    final result = create();
    if (sale != null) result.sale = sale;
    if (imageDownloadUrls != null) result.imageDownloadUrls.addAll(imageDownloadUrls);
    if (userEmail != null) result.userEmail = userEmail;
    if (userName != null) result.userName = userName;
    return result;
  }

  AdminGetSaleDetailResponse._();

  factory AdminGetSaleDetailResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory AdminGetSaleDetailResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AdminGetSaleDetailResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOM<GiftCardSale>(1, _omitFieldNames ? '' : 'sale', subBuilder: GiftCardSale.create)
    ..pPS(2, _omitFieldNames ? '' : 'imageDownloadUrls')
    ..aOS(3, _omitFieldNames ? '' : 'userEmail')
    ..aOS(4, _omitFieldNames ? '' : 'userName')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminGetSaleDetailResponse clone() => AdminGetSaleDetailResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminGetSaleDetailResponse copyWith(void Function(AdminGetSaleDetailResponse) updates) => super.copyWith((message) => updates(message as AdminGetSaleDetailResponse)) as AdminGetSaleDetailResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminGetSaleDetailResponse create() => AdminGetSaleDetailResponse._();
  @$core.override
  AdminGetSaleDetailResponse createEmptyInstance() => create();
  static $pb.PbList<AdminGetSaleDetailResponse> createRepeated() => $pb.PbList<AdminGetSaleDetailResponse>();
  @$core.pragma('dart2js:noInline')
  static AdminGetSaleDetailResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminGetSaleDetailResponse>(create);
  static AdminGetSaleDetailResponse? _defaultInstance;

  @$pb.TagNumber(1)
  GiftCardSale get sale => $_getN(0);
  @$pb.TagNumber(1)
  set sale(GiftCardSale value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasSale() => $_has(0);
  @$pb.TagNumber(1)
  void clearSale() => $_clearField(1);
  @$pb.TagNumber(1)
  GiftCardSale ensureSale() => $_ensure(0);

  @$pb.TagNumber(2)
  $pb.PbList<$core.String> get imageDownloadUrls => $_getList(1);

  @$pb.TagNumber(3)
  $core.String get userEmail => $_getSZ(2);
  @$pb.TagNumber(3)
  set userEmail($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasUserEmail() => $_has(2);
  @$pb.TagNumber(3)
  void clearUserEmail() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get userName => $_getSZ(3);
  @$pb.TagNumber(4)
  set userName($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasUserName() => $_has(3);
  @$pb.TagNumber(4)
  void clearUserName() => $_clearField(4);
}

class AdminApproveSaleRequest extends $pb.GeneratedMessage {
  factory AdminApproveSaleRequest({
    $core.String? saleId,
    $core.String? adminNotes,
  }) {
    final result = create();
    if (saleId != null) result.saleId = saleId;
    if (adminNotes != null) result.adminNotes = adminNotes;
    return result;
  }

  AdminApproveSaleRequest._();

  factory AdminApproveSaleRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory AdminApproveSaleRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AdminApproveSaleRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'saleId')
    ..aOS(2, _omitFieldNames ? '' : 'adminNotes')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminApproveSaleRequest clone() => AdminApproveSaleRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminApproveSaleRequest copyWith(void Function(AdminApproveSaleRequest) updates) => super.copyWith((message) => updates(message as AdminApproveSaleRequest)) as AdminApproveSaleRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminApproveSaleRequest create() => AdminApproveSaleRequest._();
  @$core.override
  AdminApproveSaleRequest createEmptyInstance() => create();
  static $pb.PbList<AdminApproveSaleRequest> createRepeated() => $pb.PbList<AdminApproveSaleRequest>();
  @$core.pragma('dart2js:noInline')
  static AdminApproveSaleRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminApproveSaleRequest>(create);
  static AdminApproveSaleRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get saleId => $_getSZ(0);
  @$pb.TagNumber(1)
  set saleId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSaleId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSaleId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get adminNotes => $_getSZ(1);
  @$pb.TagNumber(2)
  set adminNotes($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAdminNotes() => $_has(1);
  @$pb.TagNumber(2)
  void clearAdminNotes() => $_clearField(2);
}

class AdminApproveSaleResponse extends $pb.GeneratedMessage {
  factory AdminApproveSaleResponse({
    GiftCardSale? sale,
    $core.String? message,
  }) {
    final result = create();
    if (sale != null) result.sale = sale;
    if (message != null) result.message = message;
    return result;
  }

  AdminApproveSaleResponse._();

  factory AdminApproveSaleResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory AdminApproveSaleResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AdminApproveSaleResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOM<GiftCardSale>(1, _omitFieldNames ? '' : 'sale', subBuilder: GiftCardSale.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminApproveSaleResponse clone() => AdminApproveSaleResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminApproveSaleResponse copyWith(void Function(AdminApproveSaleResponse) updates) => super.copyWith((message) => updates(message as AdminApproveSaleResponse)) as AdminApproveSaleResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminApproveSaleResponse create() => AdminApproveSaleResponse._();
  @$core.override
  AdminApproveSaleResponse createEmptyInstance() => create();
  static $pb.PbList<AdminApproveSaleResponse> createRepeated() => $pb.PbList<AdminApproveSaleResponse>();
  @$core.pragma('dart2js:noInline')
  static AdminApproveSaleResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminApproveSaleResponse>(create);
  static AdminApproveSaleResponse? _defaultInstance;

  @$pb.TagNumber(1)
  GiftCardSale get sale => $_getN(0);
  @$pb.TagNumber(1)
  set sale(GiftCardSale value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasSale() => $_has(0);
  @$pb.TagNumber(1)
  void clearSale() => $_clearField(1);
  @$pb.TagNumber(1)
  GiftCardSale ensureSale() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);
}

class AdminProcessPayoutRequest extends $pb.GeneratedMessage {
  factory AdminProcessPayoutRequest({
    $core.String? saleId,
  }) {
    final result = create();
    if (saleId != null) result.saleId = saleId;
    return result;
  }

  AdminProcessPayoutRequest._();

  factory AdminProcessPayoutRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory AdminProcessPayoutRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AdminProcessPayoutRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'saleId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminProcessPayoutRequest clone() => AdminProcessPayoutRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminProcessPayoutRequest copyWith(void Function(AdminProcessPayoutRequest) updates) => super.copyWith((message) => updates(message as AdminProcessPayoutRequest)) as AdminProcessPayoutRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminProcessPayoutRequest create() => AdminProcessPayoutRequest._();
  @$core.override
  AdminProcessPayoutRequest createEmptyInstance() => create();
  static $pb.PbList<AdminProcessPayoutRequest> createRepeated() => $pb.PbList<AdminProcessPayoutRequest>();
  @$core.pragma('dart2js:noInline')
  static AdminProcessPayoutRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminProcessPayoutRequest>(create);
  static AdminProcessPayoutRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get saleId => $_getSZ(0);
  @$pb.TagNumber(1)
  set saleId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSaleId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSaleId() => $_clearField(1);
}

class AdminProcessPayoutResponse extends $pb.GeneratedMessage {
  factory AdminProcessPayoutResponse({
    GiftCardSale? sale,
    $core.String? message,
  }) {
    final result = create();
    if (sale != null) result.sale = sale;
    if (message != null) result.message = message;
    return result;
  }

  AdminProcessPayoutResponse._();

  factory AdminProcessPayoutResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory AdminProcessPayoutResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AdminProcessPayoutResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOM<GiftCardSale>(1, _omitFieldNames ? '' : 'sale', subBuilder: GiftCardSale.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminProcessPayoutResponse clone() => AdminProcessPayoutResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminProcessPayoutResponse copyWith(void Function(AdminProcessPayoutResponse) updates) => super.copyWith((message) => updates(message as AdminProcessPayoutResponse)) as AdminProcessPayoutResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminProcessPayoutResponse create() => AdminProcessPayoutResponse._();
  @$core.override
  AdminProcessPayoutResponse createEmptyInstance() => create();
  static $pb.PbList<AdminProcessPayoutResponse> createRepeated() => $pb.PbList<AdminProcessPayoutResponse>();
  @$core.pragma('dart2js:noInline')
  static AdminProcessPayoutResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminProcessPayoutResponse>(create);
  static AdminProcessPayoutResponse? _defaultInstance;

  @$pb.TagNumber(1)
  GiftCardSale get sale => $_getN(0);
  @$pb.TagNumber(1)
  set sale(GiftCardSale value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasSale() => $_has(0);
  @$pb.TagNumber(1)
  void clearSale() => $_clearField(1);
  @$pb.TagNumber(1)
  GiftCardSale ensureSale() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);
}

class AdminRejectSaleRequest extends $pb.GeneratedMessage {
  factory AdminRejectSaleRequest({
    $core.String? saleId,
    $core.String? reason,
    $core.String? adminNotes,
  }) {
    final result = create();
    if (saleId != null) result.saleId = saleId;
    if (reason != null) result.reason = reason;
    if (adminNotes != null) result.adminNotes = adminNotes;
    return result;
  }

  AdminRejectSaleRequest._();

  factory AdminRejectSaleRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory AdminRejectSaleRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AdminRejectSaleRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'saleId')
    ..aOS(2, _omitFieldNames ? '' : 'reason')
    ..aOS(3, _omitFieldNames ? '' : 'adminNotes')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminRejectSaleRequest clone() => AdminRejectSaleRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminRejectSaleRequest copyWith(void Function(AdminRejectSaleRequest) updates) => super.copyWith((message) => updates(message as AdminRejectSaleRequest)) as AdminRejectSaleRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminRejectSaleRequest create() => AdminRejectSaleRequest._();
  @$core.override
  AdminRejectSaleRequest createEmptyInstance() => create();
  static $pb.PbList<AdminRejectSaleRequest> createRepeated() => $pb.PbList<AdminRejectSaleRequest>();
  @$core.pragma('dart2js:noInline')
  static AdminRejectSaleRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminRejectSaleRequest>(create);
  static AdminRejectSaleRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get saleId => $_getSZ(0);
  @$pb.TagNumber(1)
  set saleId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSaleId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSaleId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get reason => $_getSZ(1);
  @$pb.TagNumber(2)
  set reason($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasReason() => $_has(1);
  @$pb.TagNumber(2)
  void clearReason() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get adminNotes => $_getSZ(2);
  @$pb.TagNumber(3)
  set adminNotes($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAdminNotes() => $_has(2);
  @$pb.TagNumber(3)
  void clearAdminNotes() => $_clearField(3);
}

class AdminRejectSaleResponse extends $pb.GeneratedMessage {
  factory AdminRejectSaleResponse({
    GiftCardSale? sale,
    $core.String? message,
  }) {
    final result = create();
    if (sale != null) result.sale = sale;
    if (message != null) result.message = message;
    return result;
  }

  AdminRejectSaleResponse._();

  factory AdminRejectSaleResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory AdminRejectSaleResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AdminRejectSaleResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOM<GiftCardSale>(1, _omitFieldNames ? '' : 'sale', subBuilder: GiftCardSale.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminRejectSaleResponse clone() => AdminRejectSaleResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminRejectSaleResponse copyWith(void Function(AdminRejectSaleResponse) updates) => super.copyWith((message) => updates(message as AdminRejectSaleResponse)) as AdminRejectSaleResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminRejectSaleResponse create() => AdminRejectSaleResponse._();
  @$core.override
  AdminRejectSaleResponse createEmptyInstance() => create();
  static $pb.PbList<AdminRejectSaleResponse> createRepeated() => $pb.PbList<AdminRejectSaleResponse>();
  @$core.pragma('dart2js:noInline')
  static AdminRejectSaleResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminRejectSaleResponse>(create);
  static AdminRejectSaleResponse? _defaultInstance;

  @$pb.TagNumber(1)
  GiftCardSale get sale => $_getN(0);
  @$pb.TagNumber(1)
  set sale(GiftCardSale value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasSale() => $_has(0);
  @$pb.TagNumber(1)
  void clearSale() => $_clearField(1);
  @$pb.TagNumber(1)
  GiftCardSale ensureSale() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);
}

class SellRateConfig extends $pb.GeneratedMessage {
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
    final result = create();
    if (id != null) result.id = id;
    if (cardBrand != null) result.cardBrand = cardBrand;
    if (cardTypeSlug != null) result.cardTypeSlug = cardTypeSlug;
    if (logoUrl != null) result.logoUrl = logoUrl;
    if (category != null) result.category = category;
    if (denominations != null) result.denominations.addAll(denominations);
    if (currencies != null) result.currencies.addAll(currencies);
    if (countries != null) result.countries.addAll(countries);
    if (minDenomination != null) result.minDenomination = minDenomination;
    if (maxDenomination != null) result.maxDenomination = maxDenomination;
    if (buyRatePercentage != null) result.buyRatePercentage = buyRatePercentage;
    if (commissionPercentage != null) result.commissionPercentage = commissionPercentage;
    if (payoutRatePercentage != null) result.payoutRatePercentage = payoutRatePercentage;
    if (payoutCurrency != null) result.payoutCurrency = payoutCurrency;
    if (cardType != null) result.cardType = cardType;
    if (isActive != null) result.isActive = isActive;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    return result;
  }

  SellRateConfig._();

  factory SellRateConfig.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory SellRateConfig.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SellRateConfig', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'cardBrand')
    ..aOS(3, _omitFieldNames ? '' : 'cardTypeSlug')
    ..aOS(4, _omitFieldNames ? '' : 'logoUrl')
    ..aOS(5, _omitFieldNames ? '' : 'category')
    ..p<$core.double>(6, _omitFieldNames ? '' : 'denominations', $pb.PbFieldType.KD)
    ..pPS(7, _omitFieldNames ? '' : 'currencies')
    ..pPS(8, _omitFieldNames ? '' : 'countries')
    ..a<$core.double>(9, _omitFieldNames ? '' : 'minDenomination', $pb.PbFieldType.OD)
    ..a<$core.double>(10, _omitFieldNames ? '' : 'maxDenomination', $pb.PbFieldType.OD)
    ..a<$core.double>(11, _omitFieldNames ? '' : 'buyRatePercentage', $pb.PbFieldType.OD)
    ..a<$core.double>(12, _omitFieldNames ? '' : 'commissionPercentage', $pb.PbFieldType.OD)
    ..a<$core.double>(13, _omitFieldNames ? '' : 'payoutRatePercentage', $pb.PbFieldType.OD)
    ..aOS(14, _omitFieldNames ? '' : 'payoutCurrency')
    ..aOS(15, _omitFieldNames ? '' : 'cardType')
    ..aOB(16, _omitFieldNames ? '' : 'isActive')
    ..aOS(17, _omitFieldNames ? '' : 'createdAt')
    ..aOS(18, _omitFieldNames ? '' : 'updatedAt')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SellRateConfig clone() => SellRateConfig()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SellRateConfig copyWith(void Function(SellRateConfig) updates) => super.copyWith((message) => updates(message as SellRateConfig)) as SellRateConfig;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SellRateConfig create() => SellRateConfig._();
  @$core.override
  SellRateConfig createEmptyInstance() => create();
  static $pb.PbList<SellRateConfig> createRepeated() => $pb.PbList<SellRateConfig>();
  @$core.pragma('dart2js:noInline')
  static SellRateConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SellRateConfig>(create);
  static SellRateConfig? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get cardBrand => $_getSZ(1);
  @$pb.TagNumber(2)
  set cardBrand($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCardBrand() => $_has(1);
  @$pb.TagNumber(2)
  void clearCardBrand() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get cardTypeSlug => $_getSZ(2);
  @$pb.TagNumber(3)
  set cardTypeSlug($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCardTypeSlug() => $_has(2);
  @$pb.TagNumber(3)
  void clearCardTypeSlug() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get logoUrl => $_getSZ(3);
  @$pb.TagNumber(4)
  set logoUrl($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasLogoUrl() => $_has(3);
  @$pb.TagNumber(4)
  void clearLogoUrl() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get category => $_getSZ(4);
  @$pb.TagNumber(5)
  set category($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCategory() => $_has(4);
  @$pb.TagNumber(5)
  void clearCategory() => $_clearField(5);

  @$pb.TagNumber(6)
  $pb.PbList<$core.double> get denominations => $_getList(5);

  @$pb.TagNumber(7)
  $pb.PbList<$core.String> get currencies => $_getList(6);

  @$pb.TagNumber(8)
  $pb.PbList<$core.String> get countries => $_getList(7);

  @$pb.TagNumber(9)
  $core.double get minDenomination => $_getN(8);
  @$pb.TagNumber(9)
  set minDenomination($core.double value) => $_setDouble(8, value);
  @$pb.TagNumber(9)
  $core.bool hasMinDenomination() => $_has(8);
  @$pb.TagNumber(9)
  void clearMinDenomination() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.double get maxDenomination => $_getN(9);
  @$pb.TagNumber(10)
  set maxDenomination($core.double value) => $_setDouble(9, value);
  @$pb.TagNumber(10)
  $core.bool hasMaxDenomination() => $_has(9);
  @$pb.TagNumber(10)
  void clearMaxDenomination() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.double get buyRatePercentage => $_getN(10);
  @$pb.TagNumber(11)
  set buyRatePercentage($core.double value) => $_setDouble(10, value);
  @$pb.TagNumber(11)
  $core.bool hasBuyRatePercentage() => $_has(10);
  @$pb.TagNumber(11)
  void clearBuyRatePercentage() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.double get commissionPercentage => $_getN(11);
  @$pb.TagNumber(12)
  set commissionPercentage($core.double value) => $_setDouble(11, value);
  @$pb.TagNumber(12)
  $core.bool hasCommissionPercentage() => $_has(11);
  @$pb.TagNumber(12)
  void clearCommissionPercentage() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.double get payoutRatePercentage => $_getN(12);
  @$pb.TagNumber(13)
  set payoutRatePercentage($core.double value) => $_setDouble(12, value);
  @$pb.TagNumber(13)
  $core.bool hasPayoutRatePercentage() => $_has(12);
  @$pb.TagNumber(13)
  void clearPayoutRatePercentage() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.String get payoutCurrency => $_getSZ(13);
  @$pb.TagNumber(14)
  set payoutCurrency($core.String value) => $_setString(13, value);
  @$pb.TagNumber(14)
  $core.bool hasPayoutCurrency() => $_has(13);
  @$pb.TagNumber(14)
  void clearPayoutCurrency() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.String get cardType => $_getSZ(14);
  @$pb.TagNumber(15)
  set cardType($core.String value) => $_setString(14, value);
  @$pb.TagNumber(15)
  $core.bool hasCardType() => $_has(14);
  @$pb.TagNumber(15)
  void clearCardType() => $_clearField(15);

  @$pb.TagNumber(16)
  $core.bool get isActive => $_getBF(15);
  @$pb.TagNumber(16)
  set isActive($core.bool value) => $_setBool(15, value);
  @$pb.TagNumber(16)
  $core.bool hasIsActive() => $_has(15);
  @$pb.TagNumber(16)
  void clearIsActive() => $_clearField(16);

  @$pb.TagNumber(17)
  $core.String get createdAt => $_getSZ(16);
  @$pb.TagNumber(17)
  set createdAt($core.String value) => $_setString(16, value);
  @$pb.TagNumber(17)
  $core.bool hasCreatedAt() => $_has(16);
  @$pb.TagNumber(17)
  void clearCreatedAt() => $_clearField(17);

  @$pb.TagNumber(18)
  $core.String get updatedAt => $_getSZ(17);
  @$pb.TagNumber(18)
  set updatedAt($core.String value) => $_setString(17, value);
  @$pb.TagNumber(18)
  $core.bool hasUpdatedAt() => $_has(17);
  @$pb.TagNumber(18)
  void clearUpdatedAt() => $_clearField(18);
}

class AdminListSellRatesRequest extends $pb.GeneratedMessage {
  factory AdminListSellRatesRequest({
    $core.String? category,
    $core.bool? activeOnly,
    $core.int? limit,
    $core.int? offset,
  }) {
    final result = create();
    if (category != null) result.category = category;
    if (activeOnly != null) result.activeOnly = activeOnly;
    if (limit != null) result.limit = limit;
    if (offset != null) result.offset = offset;
    return result;
  }

  AdminListSellRatesRequest._();

  factory AdminListSellRatesRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory AdminListSellRatesRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AdminListSellRatesRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'category')
    ..aOB(2, _omitFieldNames ? '' : 'activeOnly')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminListSellRatesRequest clone() => AdminListSellRatesRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminListSellRatesRequest copyWith(void Function(AdminListSellRatesRequest) updates) => super.copyWith((message) => updates(message as AdminListSellRatesRequest)) as AdminListSellRatesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminListSellRatesRequest create() => AdminListSellRatesRequest._();
  @$core.override
  AdminListSellRatesRequest createEmptyInstance() => create();
  static $pb.PbList<AdminListSellRatesRequest> createRepeated() => $pb.PbList<AdminListSellRatesRequest>();
  @$core.pragma('dart2js:noInline')
  static AdminListSellRatesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminListSellRatesRequest>(create);
  static AdminListSellRatesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get category => $_getSZ(0);
  @$pb.TagNumber(1)
  set category($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCategory() => $_has(0);
  @$pb.TagNumber(1)
  void clearCategory() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get activeOnly => $_getBF(1);
  @$pb.TagNumber(2)
  set activeOnly($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasActiveOnly() => $_has(1);
  @$pb.TagNumber(2)
  void clearActiveOnly() => $_clearField(2);

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

class AdminListSellRatesResponse extends $pb.GeneratedMessage {
  factory AdminListSellRatesResponse({
    $core.Iterable<SellRateConfig>? rates,
    $core.int? total,
  }) {
    final result = create();
    if (rates != null) result.rates.addAll(rates);
    if (total != null) result.total = total;
    return result;
  }

  AdminListSellRatesResponse._();

  factory AdminListSellRatesResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory AdminListSellRatesResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AdminListSellRatesResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..pc<SellRateConfig>(1, _omitFieldNames ? '' : 'rates', $pb.PbFieldType.PM, subBuilder: SellRateConfig.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminListSellRatesResponse clone() => AdminListSellRatesResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminListSellRatesResponse copyWith(void Function(AdminListSellRatesResponse) updates) => super.copyWith((message) => updates(message as AdminListSellRatesResponse)) as AdminListSellRatesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminListSellRatesResponse create() => AdminListSellRatesResponse._();
  @$core.override
  AdminListSellRatesResponse createEmptyInstance() => create();
  static $pb.PbList<AdminListSellRatesResponse> createRepeated() => $pb.PbList<AdminListSellRatesResponse>();
  @$core.pragma('dart2js:noInline')
  static AdminListSellRatesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminListSellRatesResponse>(create);
  static AdminListSellRatesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<SellRateConfig> get rates => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);
}

class AdminCreateSellRateRequest extends $pb.GeneratedMessage {
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
    final result = create();
    if (cardBrand != null) result.cardBrand = cardBrand;
    if (cardTypeSlug != null) result.cardTypeSlug = cardTypeSlug;
    if (logoUrl != null) result.logoUrl = logoUrl;
    if (category != null) result.category = category;
    if (denominations != null) result.denominations.addAll(denominations);
    if (currencies != null) result.currencies.addAll(currencies);
    if (countries != null) result.countries.addAll(countries);
    if (minDenomination != null) result.minDenomination = minDenomination;
    if (maxDenomination != null) result.maxDenomination = maxDenomination;
    if (buyRatePercentage != null) result.buyRatePercentage = buyRatePercentage;
    if (commissionPercentage != null) result.commissionPercentage = commissionPercentage;
    if (payoutRatePercentage != null) result.payoutRatePercentage = payoutRatePercentage;
    if (payoutCurrency != null) result.payoutCurrency = payoutCurrency;
    if (cardType != null) result.cardType = cardType;
    return result;
  }

  AdminCreateSellRateRequest._();

  factory AdminCreateSellRateRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory AdminCreateSellRateRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AdminCreateSellRateRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'cardBrand')
    ..aOS(2, _omitFieldNames ? '' : 'cardTypeSlug')
    ..aOS(3, _omitFieldNames ? '' : 'logoUrl')
    ..aOS(4, _omitFieldNames ? '' : 'category')
    ..p<$core.double>(5, _omitFieldNames ? '' : 'denominations', $pb.PbFieldType.KD)
    ..pPS(6, _omitFieldNames ? '' : 'currencies')
    ..pPS(7, _omitFieldNames ? '' : 'countries')
    ..a<$core.double>(8, _omitFieldNames ? '' : 'minDenomination', $pb.PbFieldType.OD)
    ..a<$core.double>(9, _omitFieldNames ? '' : 'maxDenomination', $pb.PbFieldType.OD)
    ..a<$core.double>(10, _omitFieldNames ? '' : 'buyRatePercentage', $pb.PbFieldType.OD)
    ..a<$core.double>(11, _omitFieldNames ? '' : 'commissionPercentage', $pb.PbFieldType.OD)
    ..a<$core.double>(12, _omitFieldNames ? '' : 'payoutRatePercentage', $pb.PbFieldType.OD)
    ..aOS(13, _omitFieldNames ? '' : 'payoutCurrency')
    ..aOS(14, _omitFieldNames ? '' : 'cardType')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminCreateSellRateRequest clone() => AdminCreateSellRateRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminCreateSellRateRequest copyWith(void Function(AdminCreateSellRateRequest) updates) => super.copyWith((message) => updates(message as AdminCreateSellRateRequest)) as AdminCreateSellRateRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminCreateSellRateRequest create() => AdminCreateSellRateRequest._();
  @$core.override
  AdminCreateSellRateRequest createEmptyInstance() => create();
  static $pb.PbList<AdminCreateSellRateRequest> createRepeated() => $pb.PbList<AdminCreateSellRateRequest>();
  @$core.pragma('dart2js:noInline')
  static AdminCreateSellRateRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminCreateSellRateRequest>(create);
  static AdminCreateSellRateRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get cardBrand => $_getSZ(0);
  @$pb.TagNumber(1)
  set cardBrand($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCardBrand() => $_has(0);
  @$pb.TagNumber(1)
  void clearCardBrand() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get cardTypeSlug => $_getSZ(1);
  @$pb.TagNumber(2)
  set cardTypeSlug($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCardTypeSlug() => $_has(1);
  @$pb.TagNumber(2)
  void clearCardTypeSlug() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get logoUrl => $_getSZ(2);
  @$pb.TagNumber(3)
  set logoUrl($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLogoUrl() => $_has(2);
  @$pb.TagNumber(3)
  void clearLogoUrl() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get category => $_getSZ(3);
  @$pb.TagNumber(4)
  set category($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCategory() => $_has(3);
  @$pb.TagNumber(4)
  void clearCategory() => $_clearField(4);

  @$pb.TagNumber(5)
  $pb.PbList<$core.double> get denominations => $_getList(4);

  @$pb.TagNumber(6)
  $pb.PbList<$core.String> get currencies => $_getList(5);

  @$pb.TagNumber(7)
  $pb.PbList<$core.String> get countries => $_getList(6);

  @$pb.TagNumber(8)
  $core.double get minDenomination => $_getN(7);
  @$pb.TagNumber(8)
  set minDenomination($core.double value) => $_setDouble(7, value);
  @$pb.TagNumber(8)
  $core.bool hasMinDenomination() => $_has(7);
  @$pb.TagNumber(8)
  void clearMinDenomination() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.double get maxDenomination => $_getN(8);
  @$pb.TagNumber(9)
  set maxDenomination($core.double value) => $_setDouble(8, value);
  @$pb.TagNumber(9)
  $core.bool hasMaxDenomination() => $_has(8);
  @$pb.TagNumber(9)
  void clearMaxDenomination() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.double get buyRatePercentage => $_getN(9);
  @$pb.TagNumber(10)
  set buyRatePercentage($core.double value) => $_setDouble(9, value);
  @$pb.TagNumber(10)
  $core.bool hasBuyRatePercentage() => $_has(9);
  @$pb.TagNumber(10)
  void clearBuyRatePercentage() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.double get commissionPercentage => $_getN(10);
  @$pb.TagNumber(11)
  set commissionPercentage($core.double value) => $_setDouble(10, value);
  @$pb.TagNumber(11)
  $core.bool hasCommissionPercentage() => $_has(10);
  @$pb.TagNumber(11)
  void clearCommissionPercentage() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.double get payoutRatePercentage => $_getN(11);
  @$pb.TagNumber(12)
  set payoutRatePercentage($core.double value) => $_setDouble(11, value);
  @$pb.TagNumber(12)
  $core.bool hasPayoutRatePercentage() => $_has(11);
  @$pb.TagNumber(12)
  void clearPayoutRatePercentage() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get payoutCurrency => $_getSZ(12);
  @$pb.TagNumber(13)
  set payoutCurrency($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasPayoutCurrency() => $_has(12);
  @$pb.TagNumber(13)
  void clearPayoutCurrency() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.String get cardType => $_getSZ(13);
  @$pb.TagNumber(14)
  set cardType($core.String value) => $_setString(13, value);
  @$pb.TagNumber(14)
  $core.bool hasCardType() => $_has(13);
  @$pb.TagNumber(14)
  void clearCardType() => $_clearField(14);
}

class AdminCreateSellRateResponse extends $pb.GeneratedMessage {
  factory AdminCreateSellRateResponse({
    SellRateConfig? rate,
    $core.String? message,
  }) {
    final result = create();
    if (rate != null) result.rate = rate;
    if (message != null) result.message = message;
    return result;
  }

  AdminCreateSellRateResponse._();

  factory AdminCreateSellRateResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory AdminCreateSellRateResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AdminCreateSellRateResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOM<SellRateConfig>(1, _omitFieldNames ? '' : 'rate', subBuilder: SellRateConfig.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminCreateSellRateResponse clone() => AdminCreateSellRateResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminCreateSellRateResponse copyWith(void Function(AdminCreateSellRateResponse) updates) => super.copyWith((message) => updates(message as AdminCreateSellRateResponse)) as AdminCreateSellRateResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminCreateSellRateResponse create() => AdminCreateSellRateResponse._();
  @$core.override
  AdminCreateSellRateResponse createEmptyInstance() => create();
  static $pb.PbList<AdminCreateSellRateResponse> createRepeated() => $pb.PbList<AdminCreateSellRateResponse>();
  @$core.pragma('dart2js:noInline')
  static AdminCreateSellRateResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminCreateSellRateResponse>(create);
  static AdminCreateSellRateResponse? _defaultInstance;

  @$pb.TagNumber(1)
  SellRateConfig get rate => $_getN(0);
  @$pb.TagNumber(1)
  set rate(SellRateConfig value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRate() => $_has(0);
  @$pb.TagNumber(1)
  void clearRate() => $_clearField(1);
  @$pb.TagNumber(1)
  SellRateConfig ensureRate() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);
}

class AdminUpdateSellRateRequest extends $pb.GeneratedMessage {
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
    final result = create();
    if (id != null) result.id = id;
    if (cardBrand != null) result.cardBrand = cardBrand;
    if (cardTypeSlug != null) result.cardTypeSlug = cardTypeSlug;
    if (logoUrl != null) result.logoUrl = logoUrl;
    if (category != null) result.category = category;
    if (denominations != null) result.denominations.addAll(denominations);
    if (currencies != null) result.currencies.addAll(currencies);
    if (countries != null) result.countries.addAll(countries);
    if (minDenomination != null) result.minDenomination = minDenomination;
    if (maxDenomination != null) result.maxDenomination = maxDenomination;
    if (buyRatePercentage != null) result.buyRatePercentage = buyRatePercentage;
    if (commissionPercentage != null) result.commissionPercentage = commissionPercentage;
    if (payoutRatePercentage != null) result.payoutRatePercentage = payoutRatePercentage;
    if (payoutCurrency != null) result.payoutCurrency = payoutCurrency;
    if (cardType != null) result.cardType = cardType;
    if (isActive != null) result.isActive = isActive;
    return result;
  }

  AdminUpdateSellRateRequest._();

  factory AdminUpdateSellRateRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory AdminUpdateSellRateRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AdminUpdateSellRateRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'cardBrand')
    ..aOS(3, _omitFieldNames ? '' : 'cardTypeSlug')
    ..aOS(4, _omitFieldNames ? '' : 'logoUrl')
    ..aOS(5, _omitFieldNames ? '' : 'category')
    ..p<$core.double>(6, _omitFieldNames ? '' : 'denominations', $pb.PbFieldType.KD)
    ..pPS(7, _omitFieldNames ? '' : 'currencies')
    ..pPS(8, _omitFieldNames ? '' : 'countries')
    ..a<$core.double>(9, _omitFieldNames ? '' : 'minDenomination', $pb.PbFieldType.OD)
    ..a<$core.double>(10, _omitFieldNames ? '' : 'maxDenomination', $pb.PbFieldType.OD)
    ..a<$core.double>(11, _omitFieldNames ? '' : 'buyRatePercentage', $pb.PbFieldType.OD)
    ..a<$core.double>(12, _omitFieldNames ? '' : 'commissionPercentage', $pb.PbFieldType.OD)
    ..a<$core.double>(13, _omitFieldNames ? '' : 'payoutRatePercentage', $pb.PbFieldType.OD)
    ..aOS(14, _omitFieldNames ? '' : 'payoutCurrency')
    ..aOS(15, _omitFieldNames ? '' : 'cardType')
    ..aOB(16, _omitFieldNames ? '' : 'isActive')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminUpdateSellRateRequest clone() => AdminUpdateSellRateRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminUpdateSellRateRequest copyWith(void Function(AdminUpdateSellRateRequest) updates) => super.copyWith((message) => updates(message as AdminUpdateSellRateRequest)) as AdminUpdateSellRateRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminUpdateSellRateRequest create() => AdminUpdateSellRateRequest._();
  @$core.override
  AdminUpdateSellRateRequest createEmptyInstance() => create();
  static $pb.PbList<AdminUpdateSellRateRequest> createRepeated() => $pb.PbList<AdminUpdateSellRateRequest>();
  @$core.pragma('dart2js:noInline')
  static AdminUpdateSellRateRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminUpdateSellRateRequest>(create);
  static AdminUpdateSellRateRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get cardBrand => $_getSZ(1);
  @$pb.TagNumber(2)
  set cardBrand($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCardBrand() => $_has(1);
  @$pb.TagNumber(2)
  void clearCardBrand() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get cardTypeSlug => $_getSZ(2);
  @$pb.TagNumber(3)
  set cardTypeSlug($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCardTypeSlug() => $_has(2);
  @$pb.TagNumber(3)
  void clearCardTypeSlug() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get logoUrl => $_getSZ(3);
  @$pb.TagNumber(4)
  set logoUrl($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasLogoUrl() => $_has(3);
  @$pb.TagNumber(4)
  void clearLogoUrl() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get category => $_getSZ(4);
  @$pb.TagNumber(5)
  set category($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCategory() => $_has(4);
  @$pb.TagNumber(5)
  void clearCategory() => $_clearField(5);

  @$pb.TagNumber(6)
  $pb.PbList<$core.double> get denominations => $_getList(5);

  @$pb.TagNumber(7)
  $pb.PbList<$core.String> get currencies => $_getList(6);

  @$pb.TagNumber(8)
  $pb.PbList<$core.String> get countries => $_getList(7);

  @$pb.TagNumber(9)
  $core.double get minDenomination => $_getN(8);
  @$pb.TagNumber(9)
  set minDenomination($core.double value) => $_setDouble(8, value);
  @$pb.TagNumber(9)
  $core.bool hasMinDenomination() => $_has(8);
  @$pb.TagNumber(9)
  void clearMinDenomination() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.double get maxDenomination => $_getN(9);
  @$pb.TagNumber(10)
  set maxDenomination($core.double value) => $_setDouble(9, value);
  @$pb.TagNumber(10)
  $core.bool hasMaxDenomination() => $_has(9);
  @$pb.TagNumber(10)
  void clearMaxDenomination() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.double get buyRatePercentage => $_getN(10);
  @$pb.TagNumber(11)
  set buyRatePercentage($core.double value) => $_setDouble(10, value);
  @$pb.TagNumber(11)
  $core.bool hasBuyRatePercentage() => $_has(10);
  @$pb.TagNumber(11)
  void clearBuyRatePercentage() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.double get commissionPercentage => $_getN(11);
  @$pb.TagNumber(12)
  set commissionPercentage($core.double value) => $_setDouble(11, value);
  @$pb.TagNumber(12)
  $core.bool hasCommissionPercentage() => $_has(11);
  @$pb.TagNumber(12)
  void clearCommissionPercentage() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.double get payoutRatePercentage => $_getN(12);
  @$pb.TagNumber(13)
  set payoutRatePercentage($core.double value) => $_setDouble(12, value);
  @$pb.TagNumber(13)
  $core.bool hasPayoutRatePercentage() => $_has(12);
  @$pb.TagNumber(13)
  void clearPayoutRatePercentage() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.String get payoutCurrency => $_getSZ(13);
  @$pb.TagNumber(14)
  set payoutCurrency($core.String value) => $_setString(13, value);
  @$pb.TagNumber(14)
  $core.bool hasPayoutCurrency() => $_has(13);
  @$pb.TagNumber(14)
  void clearPayoutCurrency() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.String get cardType => $_getSZ(14);
  @$pb.TagNumber(15)
  set cardType($core.String value) => $_setString(14, value);
  @$pb.TagNumber(15)
  $core.bool hasCardType() => $_has(14);
  @$pb.TagNumber(15)
  void clearCardType() => $_clearField(15);

  @$pb.TagNumber(16)
  $core.bool get isActive => $_getBF(15);
  @$pb.TagNumber(16)
  set isActive($core.bool value) => $_setBool(15, value);
  @$pb.TagNumber(16)
  $core.bool hasIsActive() => $_has(15);
  @$pb.TagNumber(16)
  void clearIsActive() => $_clearField(16);
}

class AdminUpdateSellRateResponse extends $pb.GeneratedMessage {
  factory AdminUpdateSellRateResponse({
    SellRateConfig? rate,
    $core.String? message,
  }) {
    final result = create();
    if (rate != null) result.rate = rate;
    if (message != null) result.message = message;
    return result;
  }

  AdminUpdateSellRateResponse._();

  factory AdminUpdateSellRateResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory AdminUpdateSellRateResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AdminUpdateSellRateResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOM<SellRateConfig>(1, _omitFieldNames ? '' : 'rate', subBuilder: SellRateConfig.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminUpdateSellRateResponse clone() => AdminUpdateSellRateResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminUpdateSellRateResponse copyWith(void Function(AdminUpdateSellRateResponse) updates) => super.copyWith((message) => updates(message as AdminUpdateSellRateResponse)) as AdminUpdateSellRateResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminUpdateSellRateResponse create() => AdminUpdateSellRateResponse._();
  @$core.override
  AdminUpdateSellRateResponse createEmptyInstance() => create();
  static $pb.PbList<AdminUpdateSellRateResponse> createRepeated() => $pb.PbList<AdminUpdateSellRateResponse>();
  @$core.pragma('dart2js:noInline')
  static AdminUpdateSellRateResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminUpdateSellRateResponse>(create);
  static AdminUpdateSellRateResponse? _defaultInstance;

  @$pb.TagNumber(1)
  SellRateConfig get rate => $_getN(0);
  @$pb.TagNumber(1)
  set rate(SellRateConfig value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRate() => $_has(0);
  @$pb.TagNumber(1)
  void clearRate() => $_clearField(1);
  @$pb.TagNumber(1)
  SellRateConfig ensureRate() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);
}

class AdminToggleSellRateRequest extends $pb.GeneratedMessage {
  factory AdminToggleSellRateRequest({
    $core.String? id,
    $core.bool? isActive,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (isActive != null) result.isActive = isActive;
    return result;
  }

  AdminToggleSellRateRequest._();

  factory AdminToggleSellRateRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory AdminToggleSellRateRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AdminToggleSellRateRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOB(2, _omitFieldNames ? '' : 'isActive')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminToggleSellRateRequest clone() => AdminToggleSellRateRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminToggleSellRateRequest copyWith(void Function(AdminToggleSellRateRequest) updates) => super.copyWith((message) => updates(message as AdminToggleSellRateRequest)) as AdminToggleSellRateRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminToggleSellRateRequest create() => AdminToggleSellRateRequest._();
  @$core.override
  AdminToggleSellRateRequest createEmptyInstance() => create();
  static $pb.PbList<AdminToggleSellRateRequest> createRepeated() => $pb.PbList<AdminToggleSellRateRequest>();
  @$core.pragma('dart2js:noInline')
  static AdminToggleSellRateRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminToggleSellRateRequest>(create);
  static AdminToggleSellRateRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get isActive => $_getBF(1);
  @$pb.TagNumber(2)
  set isActive($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasIsActive() => $_has(1);
  @$pb.TagNumber(2)
  void clearIsActive() => $_clearField(2);
}

class AdminToggleSellRateResponse extends $pb.GeneratedMessage {
  factory AdminToggleSellRateResponse({
    $core.String? message,
  }) {
    final result = create();
    if (message != null) result.message = message;
    return result;
  }

  AdminToggleSellRateResponse._();

  factory AdminToggleSellRateResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory AdminToggleSellRateResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AdminToggleSellRateResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminToggleSellRateResponse clone() => AdminToggleSellRateResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AdminToggleSellRateResponse copyWith(void Function(AdminToggleSellRateResponse) updates) => super.copyWith((message) => updates(message as AdminToggleSellRateResponse)) as AdminToggleSellRateResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AdminToggleSellRateResponse create() => AdminToggleSellRateResponse._();
  @$core.override
  AdminToggleSellRateResponse createEmptyInstance() => create();
  static $pb.PbList<AdminToggleSellRateResponse> createRepeated() => $pb.PbList<AdminToggleSellRateResponse>();
  @$core.pragma('dart2js:noInline')
  static AdminToggleSellRateResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AdminToggleSellRateResponse>(create);
  static AdminToggleSellRateResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get message => $_getSZ(0);
  @$pb.TagNumber(1)
  set message($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessage() => $_clearField(1);
}

class GiftCardCountry extends $pb.GeneratedMessage {
  factory GiftCardCountry({
    $core.String? isoCode,
    $core.String? name,
    $core.String? flagUrl,
    $core.String? currencyCode,
    $core.String? currencyName,
  }) {
    final result = create();
    if (isoCode != null) result.isoCode = isoCode;
    if (name != null) result.name = name;
    if (flagUrl != null) result.flagUrl = flagUrl;
    if (currencyCode != null) result.currencyCode = currencyCode;
    if (currencyName != null) result.currencyName = currencyName;
    return result;
  }

  GiftCardCountry._();

  factory GiftCardCountry.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GiftCardCountry.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GiftCardCountry', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'isoCode')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'flagUrl')
    ..aOS(4, _omitFieldNames ? '' : 'currencyCode')
    ..aOS(5, _omitFieldNames ? '' : 'currencyName')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GiftCardCountry clone() => GiftCardCountry()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GiftCardCountry copyWith(void Function(GiftCardCountry) updates) => super.copyWith((message) => updates(message as GiftCardCountry)) as GiftCardCountry;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GiftCardCountry create() => GiftCardCountry._();
  @$core.override
  GiftCardCountry createEmptyInstance() => create();
  static $pb.PbList<GiftCardCountry> createRepeated() => $pb.PbList<GiftCardCountry>();
  @$core.pragma('dart2js:noInline')
  static GiftCardCountry getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GiftCardCountry>(create);
  static GiftCardCountry? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get isoCode => $_getSZ(0);
  @$pb.TagNumber(1)
  set isoCode($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasIsoCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearIsoCode() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get flagUrl => $_getSZ(2);
  @$pb.TagNumber(3)
  set flagUrl($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasFlagUrl() => $_has(2);
  @$pb.TagNumber(3)
  void clearFlagUrl() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get currencyCode => $_getSZ(3);
  @$pb.TagNumber(4)
  set currencyCode($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCurrencyCode() => $_has(3);
  @$pb.TagNumber(4)
  void clearCurrencyCode() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get currencyName => $_getSZ(4);
  @$pb.TagNumber(5)
  set currencyName($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCurrencyName() => $_has(4);
  @$pb.TagNumber(5)
  void clearCurrencyName() => $_clearField(5);
}

class GetSupportedCountriesRequest extends $pb.GeneratedMessage {
  factory GetSupportedCountriesRequest() => create();

  GetSupportedCountriesRequest._();

  factory GetSupportedCountriesRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GetSupportedCountriesRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetSupportedCountriesRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSupportedCountriesRequest clone() => GetSupportedCountriesRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSupportedCountriesRequest copyWith(void Function(GetSupportedCountriesRequest) updates) => super.copyWith((message) => updates(message as GetSupportedCountriesRequest)) as GetSupportedCountriesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSupportedCountriesRequest create() => GetSupportedCountriesRequest._();
  @$core.override
  GetSupportedCountriesRequest createEmptyInstance() => create();
  static $pb.PbList<GetSupportedCountriesRequest> createRepeated() => $pb.PbList<GetSupportedCountriesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetSupportedCountriesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetSupportedCountriesRequest>(create);
  static GetSupportedCountriesRequest? _defaultInstance;
}

class GetSupportedCountriesResponse extends $pb.GeneratedMessage {
  factory GetSupportedCountriesResponse({
    $core.Iterable<GiftCardCountry>? countries,
  }) {
    final result = create();
    if (countries != null) result.countries.addAll(countries);
    return result;
  }

  GetSupportedCountriesResponse._();

  factory GetSupportedCountriesResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GetSupportedCountriesResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetSupportedCountriesResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..pc<GiftCardCountry>(1, _omitFieldNames ? '' : 'countries', $pb.PbFieldType.PM, subBuilder: GiftCardCountry.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSupportedCountriesResponse clone() => GetSupportedCountriesResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSupportedCountriesResponse copyWith(void Function(GetSupportedCountriesResponse) updates) => super.copyWith((message) => updates(message as GetSupportedCountriesResponse)) as GetSupportedCountriesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSupportedCountriesResponse create() => GetSupportedCountriesResponse._();
  @$core.override
  GetSupportedCountriesResponse createEmptyInstance() => create();
  static $pb.PbList<GetSupportedCountriesResponse> createRepeated() => $pb.PbList<GetSupportedCountriesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetSupportedCountriesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetSupportedCountriesResponse>(create);
  static GetSupportedCountriesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<GiftCardCountry> get countries => $_getList(0);
}

class GetGiftCardsAnalyticsRequest extends $pb.GeneratedMessage {
  factory GetGiftCardsAnalyticsRequest({
    $core.String? timeRange,
    $core.String? provider,
  }) {
    final result = create();
    if (timeRange != null) result.timeRange = timeRange;
    if (provider != null) result.provider = provider;
    return result;
  }

  GetGiftCardsAnalyticsRequest._();

  factory GetGiftCardsAnalyticsRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GetGiftCardsAnalyticsRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetGiftCardsAnalyticsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'timeRange')
    ..aOS(2, _omitFieldNames ? '' : 'provider')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetGiftCardsAnalyticsRequest clone() => GetGiftCardsAnalyticsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetGiftCardsAnalyticsRequest copyWith(void Function(GetGiftCardsAnalyticsRequest) updates) => super.copyWith((message) => updates(message as GetGiftCardsAnalyticsRequest)) as GetGiftCardsAnalyticsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetGiftCardsAnalyticsRequest create() => GetGiftCardsAnalyticsRequest._();
  @$core.override
  GetGiftCardsAnalyticsRequest createEmptyInstance() => create();
  static $pb.PbList<GetGiftCardsAnalyticsRequest> createRepeated() => $pb.PbList<GetGiftCardsAnalyticsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetGiftCardsAnalyticsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetGiftCardsAnalyticsRequest>(create);
  static GetGiftCardsAnalyticsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get timeRange => $_getSZ(0);
  @$pb.TagNumber(1)
  set timeRange($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTimeRange() => $_has(0);
  @$pb.TagNumber(1)
  void clearTimeRange() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get provider => $_getSZ(1);
  @$pb.TagNumber(2)
  set provider($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasProvider() => $_has(1);
  @$pb.TagNumber(2)
  void clearProvider() => $_clearField(2);
}

class RevenuePoint extends $pb.GeneratedMessage {
  factory RevenuePoint({
    $core.String? date,
    $core.double? revenue,
    $core.double? payouts,
  }) {
    final result = create();
    if (date != null) result.date = date;
    if (revenue != null) result.revenue = revenue;
    if (payouts != null) result.payouts = payouts;
    return result;
  }

  RevenuePoint._();

  factory RevenuePoint.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory RevenuePoint.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RevenuePoint', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'date')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'revenue', $pb.PbFieldType.OD)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'payouts', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RevenuePoint clone() => RevenuePoint()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RevenuePoint copyWith(void Function(RevenuePoint) updates) => super.copyWith((message) => updates(message as RevenuePoint)) as RevenuePoint;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RevenuePoint create() => RevenuePoint._();
  @$core.override
  RevenuePoint createEmptyInstance() => create();
  static $pb.PbList<RevenuePoint> createRepeated() => $pb.PbList<RevenuePoint>();
  @$core.pragma('dart2js:noInline')
  static RevenuePoint getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RevenuePoint>(create);
  static RevenuePoint? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get date => $_getSZ(0);
  @$pb.TagNumber(1)
  set date($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDate() => $_has(0);
  @$pb.TagNumber(1)
  void clearDate() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get revenue => $_getN(1);
  @$pb.TagNumber(2)
  set revenue($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRevenue() => $_has(1);
  @$pb.TagNumber(2)
  void clearRevenue() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get payouts => $_getN(2);
  @$pb.TagNumber(3)
  set payouts($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPayouts() => $_has(2);
  @$pb.TagNumber(3)
  void clearPayouts() => $_clearField(3);
}

class ProviderSlice extends $pb.GeneratedMessage {
  factory ProviderSlice({
    $core.String? provider,
    $fixnum.Int64? sales,
    $core.double? revenue,
  }) {
    final result = create();
    if (provider != null) result.provider = provider;
    if (sales != null) result.sales = sales;
    if (revenue != null) result.revenue = revenue;
    return result;
  }

  ProviderSlice._();

  factory ProviderSlice.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory ProviderSlice.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ProviderSlice', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'provider')
    ..aInt64(2, _omitFieldNames ? '' : 'sales')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'revenue', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProviderSlice clone() => ProviderSlice()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProviderSlice copyWith(void Function(ProviderSlice) updates) => super.copyWith((message) => updates(message as ProviderSlice)) as ProviderSlice;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProviderSlice create() => ProviderSlice._();
  @$core.override
  ProviderSlice createEmptyInstance() => create();
  static $pb.PbList<ProviderSlice> createRepeated() => $pb.PbList<ProviderSlice>();
  @$core.pragma('dart2js:noInline')
  static ProviderSlice getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProviderSlice>(create);
  static ProviderSlice? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get provider => $_getSZ(0);
  @$pb.TagNumber(1)
  set provider($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasProvider() => $_has(0);
  @$pb.TagNumber(1)
  void clearProvider() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get sales => $_getI64(1);
  @$pb.TagNumber(2)
  set sales($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSales() => $_has(1);
  @$pb.TagNumber(2)
  void clearSales() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get revenue => $_getN(2);
  @$pb.TagNumber(3)
  set revenue($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasRevenue() => $_has(2);
  @$pb.TagNumber(3)
  void clearRevenue() => $_clearField(3);
}

class TopCardType extends $pb.GeneratedMessage {
  factory TopCardType({
    $core.String? cardType,
    $fixnum.Int64? sales,
    $core.double? revenue,
  }) {
    final result = create();
    if (cardType != null) result.cardType = cardType;
    if (sales != null) result.sales = sales;
    if (revenue != null) result.revenue = revenue;
    return result;
  }

  TopCardType._();

  factory TopCardType.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory TopCardType.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TopCardType', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'cardType')
    ..aInt64(2, _omitFieldNames ? '' : 'sales')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'revenue', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TopCardType clone() => TopCardType()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TopCardType copyWith(void Function(TopCardType) updates) => super.copyWith((message) => updates(message as TopCardType)) as TopCardType;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TopCardType create() => TopCardType._();
  @$core.override
  TopCardType createEmptyInstance() => create();
  static $pb.PbList<TopCardType> createRepeated() => $pb.PbList<TopCardType>();
  @$core.pragma('dart2js:noInline')
  static TopCardType getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TopCardType>(create);
  static TopCardType? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get cardType => $_getSZ(0);
  @$pb.TagNumber(1)
  set cardType($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCardType() => $_has(0);
  @$pb.TagNumber(1)
  void clearCardType() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get sales => $_getI64(1);
  @$pb.TagNumber(2)
  set sales($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSales() => $_has(1);
  @$pb.TagNumber(2)
  void clearSales() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get revenue => $_getN(2);
  @$pb.TagNumber(3)
  set revenue($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasRevenue() => $_has(2);
  @$pb.TagNumber(3)
  void clearRevenue() => $_clearField(3);
}

class SettlementSlice extends $pb.GeneratedMessage {
  factory SettlementSlice({
    $core.String? status,
    $fixnum.Int64? count,
  }) {
    final result = create();
    if (status != null) result.status = status;
    if (count != null) result.count = count;
    return result;
  }

  SettlementSlice._();

  factory SettlementSlice.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory SettlementSlice.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SettlementSlice', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'status')
    ..aInt64(2, _omitFieldNames ? '' : 'count')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SettlementSlice clone() => SettlementSlice()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SettlementSlice copyWith(void Function(SettlementSlice) updates) => super.copyWith((message) => updates(message as SettlementSlice)) as SettlementSlice;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SettlementSlice create() => SettlementSlice._();
  @$core.override
  SettlementSlice createEmptyInstance() => create();
  static $pb.PbList<SettlementSlice> createRepeated() => $pb.PbList<SettlementSlice>();
  @$core.pragma('dart2js:noInline')
  static SettlementSlice getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SettlementSlice>(create);
  static SettlementSlice? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get status => $_getSZ(0);
  @$pb.TagNumber(1)
  set status($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get count => $_getI64(1);
  @$pb.TagNumber(2)
  set count($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCount() => $_has(1);
  @$pb.TagNumber(2)
  void clearCount() => $_clearField(2);
}

class ProviderPerformance extends $pb.GeneratedMessage {
  factory ProviderPerformance({
    $core.String? provider,
    $core.double? successRate,
    $core.double? averageLatencyMs,
    $fixnum.Int64? errors,
  }) {
    final result = create();
    if (provider != null) result.provider = provider;
    if (successRate != null) result.successRate = successRate;
    if (averageLatencyMs != null) result.averageLatencyMs = averageLatencyMs;
    if (errors != null) result.errors = errors;
    return result;
  }

  ProviderPerformance._();

  factory ProviderPerformance.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory ProviderPerformance.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ProviderPerformance', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'provider')
    ..a<$core.double>(2, _omitFieldNames ? '' : 'successRate', $pb.PbFieldType.OD)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'averageLatencyMs', $pb.PbFieldType.OD)
    ..aInt64(4, _omitFieldNames ? '' : 'errors')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProviderPerformance clone() => ProviderPerformance()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProviderPerformance copyWith(void Function(ProviderPerformance) updates) => super.copyWith((message) => updates(message as ProviderPerformance)) as ProviderPerformance;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProviderPerformance create() => ProviderPerformance._();
  @$core.override
  ProviderPerformance createEmptyInstance() => create();
  static $pb.PbList<ProviderPerformance> createRepeated() => $pb.PbList<ProviderPerformance>();
  @$core.pragma('dart2js:noInline')
  static ProviderPerformance getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProviderPerformance>(create);
  static ProviderPerformance? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get provider => $_getSZ(0);
  @$pb.TagNumber(1)
  set provider($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasProvider() => $_has(0);
  @$pb.TagNumber(1)
  void clearProvider() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get successRate => $_getN(1);
  @$pb.TagNumber(2)
  set successRate($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSuccessRate() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccessRate() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get averageLatencyMs => $_getN(2);
  @$pb.TagNumber(3)
  set averageLatencyMs($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAverageLatencyMs() => $_has(2);
  @$pb.TagNumber(3)
  void clearAverageLatencyMs() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get errors => $_getI64(3);
  @$pb.TagNumber(4)
  set errors($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasErrors() => $_has(3);
  @$pb.TagNumber(4)
  void clearErrors() => $_clearField(4);
}

class GetGiftCardsAnalyticsResponse extends $pb.GeneratedMessage {
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
    final result = create();
    if (totalRevenue != null) result.totalRevenue = totalRevenue;
    if (totalPayouts != null) result.totalPayouts = totalPayouts;
    if (grossProfit != null) result.grossProfit = grossProfit;
    if (profitMargin != null) result.profitMargin = profitMargin;
    if (totalSales != null) result.totalSales = totalSales;
    if (approvalRate != null) result.approvalRate = approvalRate;
    if (revenueChangePercent != null) result.revenueChangePercent = revenueChangePercent;
    if (payoutsChangePercent != null) result.payoutsChangePercent = payoutsChangePercent;
    if (profitChangePercent != null) result.profitChangePercent = profitChangePercent;
    if (salesChangePercent != null) result.salesChangePercent = salesChangePercent;
    if (revenueOverTime != null) result.revenueOverTime.addAll(revenueOverTime);
    if (salesByProvider != null) result.salesByProvider.addAll(salesByProvider);
    if (topCardTypes != null) result.topCardTypes.addAll(topCardTypes);
    if (settlementStatus != null) result.settlementStatus.addAll(settlementStatus);
    if (providerPerformance != null) result.providerPerformance.addAll(providerPerformance);
    return result;
  }

  GetGiftCardsAnalyticsResponse._();

  factory GetGiftCardsAnalyticsResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GetGiftCardsAnalyticsResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetGiftCardsAnalyticsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'totalRevenue', $pb.PbFieldType.OD)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'totalPayouts', $pb.PbFieldType.OD)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'grossProfit', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'profitMargin', $pb.PbFieldType.OD)
    ..aInt64(5, _omitFieldNames ? '' : 'totalSales')
    ..a<$core.double>(6, _omitFieldNames ? '' : 'approvalRate', $pb.PbFieldType.OD)
    ..a<$core.double>(7, _omitFieldNames ? '' : 'revenueChangePercent', $pb.PbFieldType.OD)
    ..a<$core.double>(8, _omitFieldNames ? '' : 'payoutsChangePercent', $pb.PbFieldType.OD)
    ..a<$core.double>(9, _omitFieldNames ? '' : 'profitChangePercent', $pb.PbFieldType.OD)
    ..a<$core.double>(10, _omitFieldNames ? '' : 'salesChangePercent', $pb.PbFieldType.OD)
    ..pc<RevenuePoint>(11, _omitFieldNames ? '' : 'revenueOverTime', $pb.PbFieldType.PM, subBuilder: RevenuePoint.create)
    ..pc<ProviderSlice>(12, _omitFieldNames ? '' : 'salesByProvider', $pb.PbFieldType.PM, subBuilder: ProviderSlice.create)
    ..pc<TopCardType>(13, _omitFieldNames ? '' : 'topCardTypes', $pb.PbFieldType.PM, subBuilder: TopCardType.create)
    ..pc<SettlementSlice>(14, _omitFieldNames ? '' : 'settlementStatus', $pb.PbFieldType.PM, subBuilder: SettlementSlice.create)
    ..pc<ProviderPerformance>(15, _omitFieldNames ? '' : 'providerPerformance', $pb.PbFieldType.PM, subBuilder: ProviderPerformance.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetGiftCardsAnalyticsResponse clone() => GetGiftCardsAnalyticsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetGiftCardsAnalyticsResponse copyWith(void Function(GetGiftCardsAnalyticsResponse) updates) => super.copyWith((message) => updates(message as GetGiftCardsAnalyticsResponse)) as GetGiftCardsAnalyticsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetGiftCardsAnalyticsResponse create() => GetGiftCardsAnalyticsResponse._();
  @$core.override
  GetGiftCardsAnalyticsResponse createEmptyInstance() => create();
  static $pb.PbList<GetGiftCardsAnalyticsResponse> createRepeated() => $pb.PbList<GetGiftCardsAnalyticsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetGiftCardsAnalyticsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetGiftCardsAnalyticsResponse>(create);
  static GetGiftCardsAnalyticsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get totalRevenue => $_getN(0);
  @$pb.TagNumber(1)
  set totalRevenue($core.double value) => $_setDouble(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTotalRevenue() => $_has(0);
  @$pb.TagNumber(1)
  void clearTotalRevenue() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get totalPayouts => $_getN(1);
  @$pb.TagNumber(2)
  set totalPayouts($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotalPayouts() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotalPayouts() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get grossProfit => $_getN(2);
  @$pb.TagNumber(3)
  set grossProfit($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasGrossProfit() => $_has(2);
  @$pb.TagNumber(3)
  void clearGrossProfit() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get profitMargin => $_getN(3);
  @$pb.TagNumber(4)
  set profitMargin($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasProfitMargin() => $_has(3);
  @$pb.TagNumber(4)
  void clearProfitMargin() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get totalSales => $_getI64(4);
  @$pb.TagNumber(5)
  set totalSales($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTotalSales() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotalSales() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.double get approvalRate => $_getN(5);
  @$pb.TagNumber(6)
  set approvalRate($core.double value) => $_setDouble(5, value);
  @$pb.TagNumber(6)
  $core.bool hasApprovalRate() => $_has(5);
  @$pb.TagNumber(6)
  void clearApprovalRate() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.double get revenueChangePercent => $_getN(6);
  @$pb.TagNumber(7)
  set revenueChangePercent($core.double value) => $_setDouble(6, value);
  @$pb.TagNumber(7)
  $core.bool hasRevenueChangePercent() => $_has(6);
  @$pb.TagNumber(7)
  void clearRevenueChangePercent() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.double get payoutsChangePercent => $_getN(7);
  @$pb.TagNumber(8)
  set payoutsChangePercent($core.double value) => $_setDouble(7, value);
  @$pb.TagNumber(8)
  $core.bool hasPayoutsChangePercent() => $_has(7);
  @$pb.TagNumber(8)
  void clearPayoutsChangePercent() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.double get profitChangePercent => $_getN(8);
  @$pb.TagNumber(9)
  set profitChangePercent($core.double value) => $_setDouble(8, value);
  @$pb.TagNumber(9)
  $core.bool hasProfitChangePercent() => $_has(8);
  @$pb.TagNumber(9)
  void clearProfitChangePercent() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.double get salesChangePercent => $_getN(9);
  @$pb.TagNumber(10)
  set salesChangePercent($core.double value) => $_setDouble(9, value);
  @$pb.TagNumber(10)
  $core.bool hasSalesChangePercent() => $_has(9);
  @$pb.TagNumber(10)
  void clearSalesChangePercent() => $_clearField(10);

  @$pb.TagNumber(11)
  $pb.PbList<RevenuePoint> get revenueOverTime => $_getList(10);

  @$pb.TagNumber(12)
  $pb.PbList<ProviderSlice> get salesByProvider => $_getList(11);

  @$pb.TagNumber(13)
  $pb.PbList<TopCardType> get topCardTypes => $_getList(12);

  @$pb.TagNumber(14)
  $pb.PbList<SettlementSlice> get settlementStatus => $_getList(13);

  @$pb.TagNumber(15)
  $pb.PbList<ProviderPerformance> get providerPerformance => $_getList(14);
}

class ReconciliationRun extends $pb.GeneratedMessage {
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
    final result = create();
    if (id != null) result.id = id;
    if (type != null) result.type = type;
    if (status != null) result.status = status;
    if (timestamp != null) result.timestamp = timestamp;
    if (itemsProcessed != null) result.itemsProcessed = itemsProcessed;
    if (resolved != null) result.resolved = resolved;
    if (escalated != null) result.escalated = escalated;
    if (duration != null) result.duration = duration;
    return result;
  }

  ReconciliationRun._();

  factory ReconciliationRun.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory ReconciliationRun.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ReconciliationRun', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'type')
    ..aOS(3, _omitFieldNames ? '' : 'status')
    ..aOS(4, _omitFieldNames ? '' : 'timestamp')
    ..aInt64(5, _omitFieldNames ? '' : 'itemsProcessed')
    ..aInt64(6, _omitFieldNames ? '' : 'resolved')
    ..aInt64(7, _omitFieldNames ? '' : 'escalated')
    ..aOS(8, _omitFieldNames ? '' : 'duration')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReconciliationRun clone() => ReconciliationRun()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReconciliationRun copyWith(void Function(ReconciliationRun) updates) => super.copyWith((message) => updates(message as ReconciliationRun)) as ReconciliationRun;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ReconciliationRun create() => ReconciliationRun._();
  @$core.override
  ReconciliationRun createEmptyInstance() => create();
  static $pb.PbList<ReconciliationRun> createRepeated() => $pb.PbList<ReconciliationRun>();
  @$core.pragma('dart2js:noInline')
  static ReconciliationRun getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ReconciliationRun>(create);
  static ReconciliationRun? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get type => $_getSZ(1);
  @$pb.TagNumber(2)
  set type($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasType() => $_has(1);
  @$pb.TagNumber(2)
  void clearType() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get status => $_getSZ(2);
  @$pb.TagNumber(3)
  set status($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatus() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get timestamp => $_getSZ(3);
  @$pb.TagNumber(4)
  set timestamp($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTimestamp() => $_has(3);
  @$pb.TagNumber(4)
  void clearTimestamp() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get itemsProcessed => $_getI64(4);
  @$pb.TagNumber(5)
  set itemsProcessed($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasItemsProcessed() => $_has(4);
  @$pb.TagNumber(5)
  void clearItemsProcessed() => $_clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get resolved => $_getI64(5);
  @$pb.TagNumber(6)
  set resolved($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasResolved() => $_has(5);
  @$pb.TagNumber(6)
  void clearResolved() => $_clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get escalated => $_getI64(6);
  @$pb.TagNumber(7)
  set escalated($fixnum.Int64 value) => $_setInt64(6, value);
  @$pb.TagNumber(7)
  $core.bool hasEscalated() => $_has(6);
  @$pb.TagNumber(7)
  void clearEscalated() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get duration => $_getSZ(7);
  @$pb.TagNumber(8)
  set duration($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasDuration() => $_has(7);
  @$pb.TagNumber(8)
  void clearDuration() => $_clearField(8);
}

class GetReconciliationOverviewRequest extends $pb.GeneratedMessage {
  factory GetReconciliationOverviewRequest() => create();

  GetReconciliationOverviewRequest._();

  factory GetReconciliationOverviewRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GetReconciliationOverviewRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetReconciliationOverviewRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetReconciliationOverviewRequest clone() => GetReconciliationOverviewRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetReconciliationOverviewRequest copyWith(void Function(GetReconciliationOverviewRequest) updates) => super.copyWith((message) => updates(message as GetReconciliationOverviewRequest)) as GetReconciliationOverviewRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetReconciliationOverviewRequest create() => GetReconciliationOverviewRequest._();
  @$core.override
  GetReconciliationOverviewRequest createEmptyInstance() => create();
  static $pb.PbList<GetReconciliationOverviewRequest> createRepeated() => $pb.PbList<GetReconciliationOverviewRequest>();
  @$core.pragma('dart2js:noInline')
  static GetReconciliationOverviewRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetReconciliationOverviewRequest>(create);
  static GetReconciliationOverviewRequest? _defaultInstance;
}

class GetReconciliationOverviewResponse extends $pb.GeneratedMessage {
  factory GetReconciliationOverviewResponse({
    $fixnum.Int64? orphanedTransactions,
    $fixnum.Int64? pendingVerification,
    $fixnum.Int64? escalatedItems,
    $fixnum.Int64? resolvedToday,
    $core.double? floatVariance,
    $core.bool? floatVarianceCritical,
    ReconciliationRun? lastReconciliation,
  }) {
    final result = create();
    if (orphanedTransactions != null) result.orphanedTransactions = orphanedTransactions;
    if (pendingVerification != null) result.pendingVerification = pendingVerification;
    if (escalatedItems != null) result.escalatedItems = escalatedItems;
    if (resolvedToday != null) result.resolvedToday = resolvedToday;
    if (floatVariance != null) result.floatVariance = floatVariance;
    if (floatVarianceCritical != null) result.floatVarianceCritical = floatVarianceCritical;
    if (lastReconciliation != null) result.lastReconciliation = lastReconciliation;
    return result;
  }

  GetReconciliationOverviewResponse._();

  factory GetReconciliationOverviewResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GetReconciliationOverviewResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetReconciliationOverviewResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'orphanedTransactions')
    ..aInt64(2, _omitFieldNames ? '' : 'pendingVerification')
    ..aInt64(3, _omitFieldNames ? '' : 'escalatedItems')
    ..aInt64(4, _omitFieldNames ? '' : 'resolvedToday')
    ..a<$core.double>(5, _omitFieldNames ? '' : 'floatVariance', $pb.PbFieldType.OD)
    ..aOB(6, _omitFieldNames ? '' : 'floatVarianceCritical')
    ..aOM<ReconciliationRun>(7, _omitFieldNames ? '' : 'lastReconciliation', subBuilder: ReconciliationRun.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetReconciliationOverviewResponse clone() => GetReconciliationOverviewResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetReconciliationOverviewResponse copyWith(void Function(GetReconciliationOverviewResponse) updates) => super.copyWith((message) => updates(message as GetReconciliationOverviewResponse)) as GetReconciliationOverviewResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetReconciliationOverviewResponse create() => GetReconciliationOverviewResponse._();
  @$core.override
  GetReconciliationOverviewResponse createEmptyInstance() => create();
  static $pb.PbList<GetReconciliationOverviewResponse> createRepeated() => $pb.PbList<GetReconciliationOverviewResponse>();
  @$core.pragma('dart2js:noInline')
  static GetReconciliationOverviewResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetReconciliationOverviewResponse>(create);
  static GetReconciliationOverviewResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get orphanedTransactions => $_getI64(0);
  @$pb.TagNumber(1)
  set orphanedTransactions($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasOrphanedTransactions() => $_has(0);
  @$pb.TagNumber(1)
  void clearOrphanedTransactions() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get pendingVerification => $_getI64(1);
  @$pb.TagNumber(2)
  set pendingVerification($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPendingVerification() => $_has(1);
  @$pb.TagNumber(2)
  void clearPendingVerification() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get escalatedItems => $_getI64(2);
  @$pb.TagNumber(3)
  set escalatedItems($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasEscalatedItems() => $_has(2);
  @$pb.TagNumber(3)
  void clearEscalatedItems() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get resolvedToday => $_getI64(3);
  @$pb.TagNumber(4)
  set resolvedToday($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasResolvedToday() => $_has(3);
  @$pb.TagNumber(4)
  void clearResolvedToday() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get floatVariance => $_getN(4);
  @$pb.TagNumber(5)
  set floatVariance($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasFloatVariance() => $_has(4);
  @$pb.TagNumber(5)
  void clearFloatVariance() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.bool get floatVarianceCritical => $_getBF(5);
  @$pb.TagNumber(6)
  set floatVarianceCritical($core.bool value) => $_setBool(5, value);
  @$pb.TagNumber(6)
  $core.bool hasFloatVarianceCritical() => $_has(5);
  @$pb.TagNumber(6)
  void clearFloatVarianceCritical() => $_clearField(6);

  @$pb.TagNumber(7)
  ReconciliationRun get lastReconciliation => $_getN(6);
  @$pb.TagNumber(7)
  set lastReconciliation(ReconciliationRun value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasLastReconciliation() => $_has(6);
  @$pb.TagNumber(7)
  void clearLastReconciliation() => $_clearField(7);
  @$pb.TagNumber(7)
  ReconciliationRun ensureLastReconciliation() => $_ensure(6);
}

class OrphanedTransaction extends $pb.GeneratedMessage {
  factory OrphanedTransaction({
    $core.String? id,
    $core.String? type,
    $core.String? reference,
    $core.double? amount,
    $core.String? issue,
    $core.String? createdAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (type != null) result.type = type;
    if (reference != null) result.reference = reference;
    if (amount != null) result.amount = amount;
    if (issue != null) result.issue = issue;
    if (createdAt != null) result.createdAt = createdAt;
    return result;
  }

  OrphanedTransaction._();

  factory OrphanedTransaction.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory OrphanedTransaction.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'OrphanedTransaction', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'type')
    ..aOS(3, _omitFieldNames ? '' : 'reference')
    ..a<$core.double>(4, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(5, _omitFieldNames ? '' : 'issue')
    ..aOS(6, _omitFieldNames ? '' : 'createdAt')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OrphanedTransaction clone() => OrphanedTransaction()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  OrphanedTransaction copyWith(void Function(OrphanedTransaction) updates) => super.copyWith((message) => updates(message as OrphanedTransaction)) as OrphanedTransaction;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static OrphanedTransaction create() => OrphanedTransaction._();
  @$core.override
  OrphanedTransaction createEmptyInstance() => create();
  static $pb.PbList<OrphanedTransaction> createRepeated() => $pb.PbList<OrphanedTransaction>();
  @$core.pragma('dart2js:noInline')
  static OrphanedTransaction getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<OrphanedTransaction>(create);
  static OrphanedTransaction? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get type => $_getSZ(1);
  @$pb.TagNumber(2)
  set type($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasType() => $_has(1);
  @$pb.TagNumber(2)
  void clearType() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get reference => $_getSZ(2);
  @$pb.TagNumber(3)
  set reference($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasReference() => $_has(2);
  @$pb.TagNumber(3)
  void clearReference() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get amount => $_getN(3);
  @$pb.TagNumber(4)
  set amount($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearAmount() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get issue => $_getSZ(4);
  @$pb.TagNumber(5)
  set issue($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasIssue() => $_has(4);
  @$pb.TagNumber(5)
  void clearIssue() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get createdAt => $_getSZ(5);
  @$pb.TagNumber(6)
  set createdAt($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasCreatedAt() => $_has(5);
  @$pb.TagNumber(6)
  void clearCreatedAt() => $_clearField(6);
}

class GetOrphanedTransactionsRequest extends $pb.GeneratedMessage {
  factory GetOrphanedTransactionsRequest({
    $core.int? page,
    $core.int? limit,
  }) {
    final result = create();
    if (page != null) result.page = page;
    if (limit != null) result.limit = limit;
    return result;
  }

  GetOrphanedTransactionsRequest._();

  factory GetOrphanedTransactionsRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GetOrphanedTransactionsRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetOrphanedTransactionsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetOrphanedTransactionsRequest clone() => GetOrphanedTransactionsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetOrphanedTransactionsRequest copyWith(void Function(GetOrphanedTransactionsRequest) updates) => super.copyWith((message) => updates(message as GetOrphanedTransactionsRequest)) as GetOrphanedTransactionsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetOrphanedTransactionsRequest create() => GetOrphanedTransactionsRequest._();
  @$core.override
  GetOrphanedTransactionsRequest createEmptyInstance() => create();
  static $pb.PbList<GetOrphanedTransactionsRequest> createRepeated() => $pb.PbList<GetOrphanedTransactionsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetOrphanedTransactionsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetOrphanedTransactionsRequest>(create);
  static GetOrphanedTransactionsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get page => $_getIZ(0);
  @$pb.TagNumber(1)
  set page($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearPage() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get limit => $_getIZ(1);
  @$pb.TagNumber(2)
  set limit($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => $_clearField(2);
}

class GetOrphanedTransactionsResponse extends $pb.GeneratedMessage {
  factory GetOrphanedTransactionsResponse({
    $core.Iterable<OrphanedTransaction>? transactions,
    $fixnum.Int64? total,
    $core.int? page,
    $core.int? limit,
  }) {
    final result = create();
    if (transactions != null) result.transactions.addAll(transactions);
    if (total != null) result.total = total;
    if (page != null) result.page = page;
    if (limit != null) result.limit = limit;
    return result;
  }

  GetOrphanedTransactionsResponse._();

  factory GetOrphanedTransactionsResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GetOrphanedTransactionsResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetOrphanedTransactionsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..pc<OrphanedTransaction>(1, _omitFieldNames ? '' : 'transactions', $pb.PbFieldType.PM, subBuilder: OrphanedTransaction.create)
    ..aInt64(2, _omitFieldNames ? '' : 'total')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetOrphanedTransactionsResponse clone() => GetOrphanedTransactionsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetOrphanedTransactionsResponse copyWith(void Function(GetOrphanedTransactionsResponse) updates) => super.copyWith((message) => updates(message as GetOrphanedTransactionsResponse)) as GetOrphanedTransactionsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetOrphanedTransactionsResponse create() => GetOrphanedTransactionsResponse._();
  @$core.override
  GetOrphanedTransactionsResponse createEmptyInstance() => create();
  static $pb.PbList<GetOrphanedTransactionsResponse> createRepeated() => $pb.PbList<GetOrphanedTransactionsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetOrphanedTransactionsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetOrphanedTransactionsResponse>(create);
  static GetOrphanedTransactionsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<OrphanedTransaction> get transactions => $_getList(0);

  @$pb.TagNumber(2)
  $fixnum.Int64 get total => $_getI64(1);
  @$pb.TagNumber(2)
  set total($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get page => $_getIZ(2);
  @$pb.TagNumber(3)
  set page($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPage() => $_has(2);
  @$pb.TagNumber(3)
  void clearPage() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get limit => $_getIZ(3);
  @$pb.TagNumber(4)
  set limit($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasLimit() => $_has(3);
  @$pb.TagNumber(4)
  void clearLimit() => $_clearField(4);
}

class ResolveOrphanedTransactionRequest extends $pb.GeneratedMessage {
  factory ResolveOrphanedTransactionRequest({
    $core.String? id,
    $core.String? resolution,
    $core.String? notes,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (resolution != null) result.resolution = resolution;
    if (notes != null) result.notes = notes;
    return result;
  }

  ResolveOrphanedTransactionRequest._();

  factory ResolveOrphanedTransactionRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory ResolveOrphanedTransactionRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ResolveOrphanedTransactionRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'resolution')
    ..aOS(3, _omitFieldNames ? '' : 'notes')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ResolveOrphanedTransactionRequest clone() => ResolveOrphanedTransactionRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ResolveOrphanedTransactionRequest copyWith(void Function(ResolveOrphanedTransactionRequest) updates) => super.copyWith((message) => updates(message as ResolveOrphanedTransactionRequest)) as ResolveOrphanedTransactionRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ResolveOrphanedTransactionRequest create() => ResolveOrphanedTransactionRequest._();
  @$core.override
  ResolveOrphanedTransactionRequest createEmptyInstance() => create();
  static $pb.PbList<ResolveOrphanedTransactionRequest> createRepeated() => $pb.PbList<ResolveOrphanedTransactionRequest>();
  @$core.pragma('dart2js:noInline')
  static ResolveOrphanedTransactionRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ResolveOrphanedTransactionRequest>(create);
  static ResolveOrphanedTransactionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get resolution => $_getSZ(1);
  @$pb.TagNumber(2)
  set resolution($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasResolution() => $_has(1);
  @$pb.TagNumber(2)
  void clearResolution() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get notes => $_getSZ(2);
  @$pb.TagNumber(3)
  set notes($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasNotes() => $_has(2);
  @$pb.TagNumber(3)
  void clearNotes() => $_clearField(3);
}

class ResolveOrphanedTransactionResponse extends $pb.GeneratedMessage {
  factory ResolveOrphanedTransactionResponse({
    $core.bool? success,
    $core.String? message,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    return result;
  }

  ResolveOrphanedTransactionResponse._();

  factory ResolveOrphanedTransactionResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory ResolveOrphanedTransactionResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ResolveOrphanedTransactionResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ResolveOrphanedTransactionResponse clone() => ResolveOrphanedTransactionResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ResolveOrphanedTransactionResponse copyWith(void Function(ResolveOrphanedTransactionResponse) updates) => super.copyWith((message) => updates(message as ResolveOrphanedTransactionResponse)) as ResolveOrphanedTransactionResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ResolveOrphanedTransactionResponse create() => ResolveOrphanedTransactionResponse._();
  @$core.override
  ResolveOrphanedTransactionResponse createEmptyInstance() => create();
  static $pb.PbList<ResolveOrphanedTransactionResponse> createRepeated() => $pb.PbList<ResolveOrphanedTransactionResponse>();
  @$core.pragma('dart2js:noInline')
  static ResolveOrphanedTransactionResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ResolveOrphanedTransactionResponse>(create);
  static ResolveOrphanedTransactionResponse? _defaultInstance;

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

class PendingVerification extends $pb.GeneratedMessage {
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
    final result = create();
    if (id != null) result.id = id;
    if (reference != null) result.reference = reference;
    if (cardType != null) result.cardType = cardType;
    if (denomination != null) result.denomination = denomination;
    if (currency != null) result.currency = currency;
    if (verificationAttempts != null) result.verificationAttempts = verificationAttempts;
    if (lastChecked != null) result.lastChecked = lastChecked;
    if (status != null) result.status = status;
    return result;
  }

  PendingVerification._();

  factory PendingVerification.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory PendingVerification.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PendingVerification', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'reference')
    ..aOS(3, _omitFieldNames ? '' : 'cardType')
    ..a<$core.double>(4, _omitFieldNames ? '' : 'denomination', $pb.PbFieldType.OD)
    ..aOS(5, _omitFieldNames ? '' : 'currency')
    ..a<$core.int>(6, _omitFieldNames ? '' : 'verificationAttempts', $pb.PbFieldType.O3)
    ..aOS(7, _omitFieldNames ? '' : 'lastChecked')
    ..aOS(8, _omitFieldNames ? '' : 'status')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PendingVerification clone() => PendingVerification()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PendingVerification copyWith(void Function(PendingVerification) updates) => super.copyWith((message) => updates(message as PendingVerification)) as PendingVerification;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PendingVerification create() => PendingVerification._();
  @$core.override
  PendingVerification createEmptyInstance() => create();
  static $pb.PbList<PendingVerification> createRepeated() => $pb.PbList<PendingVerification>();
  @$core.pragma('dart2js:noInline')
  static PendingVerification getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PendingVerification>(create);
  static PendingVerification? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get reference => $_getSZ(1);
  @$pb.TagNumber(2)
  set reference($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasReference() => $_has(1);
  @$pb.TagNumber(2)
  void clearReference() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get cardType => $_getSZ(2);
  @$pb.TagNumber(3)
  set cardType($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCardType() => $_has(2);
  @$pb.TagNumber(3)
  void clearCardType() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get denomination => $_getN(3);
  @$pb.TagNumber(4)
  set denomination($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDenomination() => $_has(3);
  @$pb.TagNumber(4)
  void clearDenomination() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get currency => $_getSZ(4);
  @$pb.TagNumber(5)
  set currency($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCurrency() => $_has(4);
  @$pb.TagNumber(5)
  void clearCurrency() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get verificationAttempts => $_getIZ(5);
  @$pb.TagNumber(6)
  set verificationAttempts($core.int value) => $_setSignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasVerificationAttempts() => $_has(5);
  @$pb.TagNumber(6)
  void clearVerificationAttempts() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get lastChecked => $_getSZ(6);
  @$pb.TagNumber(7)
  set lastChecked($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasLastChecked() => $_has(6);
  @$pb.TagNumber(7)
  void clearLastChecked() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get status => $_getSZ(7);
  @$pb.TagNumber(8)
  set status($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasStatus() => $_has(7);
  @$pb.TagNumber(8)
  void clearStatus() => $_clearField(8);
}

class GetPendingVerificationsRequest extends $pb.GeneratedMessage {
  factory GetPendingVerificationsRequest({
    $core.int? page,
    $core.int? limit,
  }) {
    final result = create();
    if (page != null) result.page = page;
    if (limit != null) result.limit = limit;
    return result;
  }

  GetPendingVerificationsRequest._();

  factory GetPendingVerificationsRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GetPendingVerificationsRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetPendingVerificationsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPendingVerificationsRequest clone() => GetPendingVerificationsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPendingVerificationsRequest copyWith(void Function(GetPendingVerificationsRequest) updates) => super.copyWith((message) => updates(message as GetPendingVerificationsRequest)) as GetPendingVerificationsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPendingVerificationsRequest create() => GetPendingVerificationsRequest._();
  @$core.override
  GetPendingVerificationsRequest createEmptyInstance() => create();
  static $pb.PbList<GetPendingVerificationsRequest> createRepeated() => $pb.PbList<GetPendingVerificationsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetPendingVerificationsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetPendingVerificationsRequest>(create);
  static GetPendingVerificationsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get page => $_getIZ(0);
  @$pb.TagNumber(1)
  set page($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearPage() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get limit => $_getIZ(1);
  @$pb.TagNumber(2)
  set limit($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => $_clearField(2);
}

class GetPendingVerificationsResponse extends $pb.GeneratedMessage {
  factory GetPendingVerificationsResponse({
    $core.Iterable<PendingVerification>? verifications,
    $fixnum.Int64? total,
    $core.int? page,
    $core.int? limit,
  }) {
    final result = create();
    if (verifications != null) result.verifications.addAll(verifications);
    if (total != null) result.total = total;
    if (page != null) result.page = page;
    if (limit != null) result.limit = limit;
    return result;
  }

  GetPendingVerificationsResponse._();

  factory GetPendingVerificationsResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GetPendingVerificationsResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetPendingVerificationsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..pc<PendingVerification>(1, _omitFieldNames ? '' : 'verifications', $pb.PbFieldType.PM, subBuilder: PendingVerification.create)
    ..aInt64(2, _omitFieldNames ? '' : 'total')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPendingVerificationsResponse clone() => GetPendingVerificationsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPendingVerificationsResponse copyWith(void Function(GetPendingVerificationsResponse) updates) => super.copyWith((message) => updates(message as GetPendingVerificationsResponse)) as GetPendingVerificationsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPendingVerificationsResponse create() => GetPendingVerificationsResponse._();
  @$core.override
  GetPendingVerificationsResponse createEmptyInstance() => create();
  static $pb.PbList<GetPendingVerificationsResponse> createRepeated() => $pb.PbList<GetPendingVerificationsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetPendingVerificationsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetPendingVerificationsResponse>(create);
  static GetPendingVerificationsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<PendingVerification> get verifications => $_getList(0);

  @$pb.TagNumber(2)
  $fixnum.Int64 get total => $_getI64(1);
  @$pb.TagNumber(2)
  set total($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get page => $_getIZ(2);
  @$pb.TagNumber(3)
  set page($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPage() => $_has(2);
  @$pb.TagNumber(3)
  void clearPage() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get limit => $_getIZ(3);
  @$pb.TagNumber(4)
  set limit($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasLimit() => $_has(3);
  @$pb.TagNumber(4)
  void clearLimit() => $_clearField(4);
}

class EscalatedItem extends $pb.GeneratedMessage {
  factory EscalatedItem({
    $core.String? id,
    $core.String? reference,
    $core.double? amount,
    $core.String? reason,
    $core.String? escalatedAt,
    $core.String? status,
    $core.String? assignedTo,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (reference != null) result.reference = reference;
    if (amount != null) result.amount = amount;
    if (reason != null) result.reason = reason;
    if (escalatedAt != null) result.escalatedAt = escalatedAt;
    if (status != null) result.status = status;
    if (assignedTo != null) result.assignedTo = assignedTo;
    return result;
  }

  EscalatedItem._();

  factory EscalatedItem.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory EscalatedItem.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'EscalatedItem', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'reference')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(4, _omitFieldNames ? '' : 'reason')
    ..aOS(5, _omitFieldNames ? '' : 'escalatedAt')
    ..aOS(6, _omitFieldNames ? '' : 'status')
    ..aOS(7, _omitFieldNames ? '' : 'assignedTo')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EscalatedItem clone() => EscalatedItem()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EscalatedItem copyWith(void Function(EscalatedItem) updates) => super.copyWith((message) => updates(message as EscalatedItem)) as EscalatedItem;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EscalatedItem create() => EscalatedItem._();
  @$core.override
  EscalatedItem createEmptyInstance() => create();
  static $pb.PbList<EscalatedItem> createRepeated() => $pb.PbList<EscalatedItem>();
  @$core.pragma('dart2js:noInline')
  static EscalatedItem getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EscalatedItem>(create);
  static EscalatedItem? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get reference => $_getSZ(1);
  @$pb.TagNumber(2)
  set reference($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasReference() => $_has(1);
  @$pb.TagNumber(2)
  void clearReference() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get amount => $_getN(2);
  @$pb.TagNumber(3)
  set amount($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get reason => $_getSZ(3);
  @$pb.TagNumber(4)
  set reason($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasReason() => $_has(3);
  @$pb.TagNumber(4)
  void clearReason() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get escalatedAt => $_getSZ(4);
  @$pb.TagNumber(5)
  set escalatedAt($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasEscalatedAt() => $_has(4);
  @$pb.TagNumber(5)
  void clearEscalatedAt() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get status => $_getSZ(5);
  @$pb.TagNumber(6)
  set status($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasStatus() => $_has(5);
  @$pb.TagNumber(6)
  void clearStatus() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get assignedTo => $_getSZ(6);
  @$pb.TagNumber(7)
  set assignedTo($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasAssignedTo() => $_has(6);
  @$pb.TagNumber(7)
  void clearAssignedTo() => $_clearField(7);
}

class GetEscalatedItemsRequest extends $pb.GeneratedMessage {
  factory GetEscalatedItemsRequest({
    $core.int? page,
    $core.int? limit,
  }) {
    final result = create();
    if (page != null) result.page = page;
    if (limit != null) result.limit = limit;
    return result;
  }

  GetEscalatedItemsRequest._();

  factory GetEscalatedItemsRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GetEscalatedItemsRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetEscalatedItemsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetEscalatedItemsRequest clone() => GetEscalatedItemsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetEscalatedItemsRequest copyWith(void Function(GetEscalatedItemsRequest) updates) => super.copyWith((message) => updates(message as GetEscalatedItemsRequest)) as GetEscalatedItemsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetEscalatedItemsRequest create() => GetEscalatedItemsRequest._();
  @$core.override
  GetEscalatedItemsRequest createEmptyInstance() => create();
  static $pb.PbList<GetEscalatedItemsRequest> createRepeated() => $pb.PbList<GetEscalatedItemsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetEscalatedItemsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetEscalatedItemsRequest>(create);
  static GetEscalatedItemsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get page => $_getIZ(0);
  @$pb.TagNumber(1)
  set page($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPage() => $_has(0);
  @$pb.TagNumber(1)
  void clearPage() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get limit => $_getIZ(1);
  @$pb.TagNumber(2)
  set limit($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => $_clearField(2);
}

class GetEscalatedItemsResponse extends $pb.GeneratedMessage {
  factory GetEscalatedItemsResponse({
    $core.Iterable<EscalatedItem>? items,
    $fixnum.Int64? total,
    $core.int? page,
    $core.int? limit,
  }) {
    final result = create();
    if (items != null) result.items.addAll(items);
    if (total != null) result.total = total;
    if (page != null) result.page = page;
    if (limit != null) result.limit = limit;
    return result;
  }

  GetEscalatedItemsResponse._();

  factory GetEscalatedItemsResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GetEscalatedItemsResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetEscalatedItemsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..pc<EscalatedItem>(1, _omitFieldNames ? '' : 'items', $pb.PbFieldType.PM, subBuilder: EscalatedItem.create)
    ..aInt64(2, _omitFieldNames ? '' : 'total')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetEscalatedItemsResponse clone() => GetEscalatedItemsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetEscalatedItemsResponse copyWith(void Function(GetEscalatedItemsResponse) updates) => super.copyWith((message) => updates(message as GetEscalatedItemsResponse)) as GetEscalatedItemsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetEscalatedItemsResponse create() => GetEscalatedItemsResponse._();
  @$core.override
  GetEscalatedItemsResponse createEmptyInstance() => create();
  static $pb.PbList<GetEscalatedItemsResponse> createRepeated() => $pb.PbList<GetEscalatedItemsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetEscalatedItemsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetEscalatedItemsResponse>(create);
  static GetEscalatedItemsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<EscalatedItem> get items => $_getList(0);

  @$pb.TagNumber(2)
  $fixnum.Int64 get total => $_getI64(1);
  @$pb.TagNumber(2)
  set total($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get page => $_getIZ(2);
  @$pb.TagNumber(3)
  set page($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPage() => $_has(2);
  @$pb.TagNumber(3)
  void clearPage() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get limit => $_getIZ(3);
  @$pb.TagNumber(4)
  set limit($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasLimit() => $_has(3);
  @$pb.TagNumber(4)
  void clearLimit() => $_clearField(4);
}

class ResolveEscalatedItemRequest extends $pb.GeneratedMessage {
  factory ResolveEscalatedItemRequest({
    $core.String? id,
    $core.String? resolution,
    $core.String? notes,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (resolution != null) result.resolution = resolution;
    if (notes != null) result.notes = notes;
    return result;
  }

  ResolveEscalatedItemRequest._();

  factory ResolveEscalatedItemRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory ResolveEscalatedItemRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ResolveEscalatedItemRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'resolution')
    ..aOS(3, _omitFieldNames ? '' : 'notes')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ResolveEscalatedItemRequest clone() => ResolveEscalatedItemRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ResolveEscalatedItemRequest copyWith(void Function(ResolveEscalatedItemRequest) updates) => super.copyWith((message) => updates(message as ResolveEscalatedItemRequest)) as ResolveEscalatedItemRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ResolveEscalatedItemRequest create() => ResolveEscalatedItemRequest._();
  @$core.override
  ResolveEscalatedItemRequest createEmptyInstance() => create();
  static $pb.PbList<ResolveEscalatedItemRequest> createRepeated() => $pb.PbList<ResolveEscalatedItemRequest>();
  @$core.pragma('dart2js:noInline')
  static ResolveEscalatedItemRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ResolveEscalatedItemRequest>(create);
  static ResolveEscalatedItemRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get resolution => $_getSZ(1);
  @$pb.TagNumber(2)
  set resolution($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasResolution() => $_has(1);
  @$pb.TagNumber(2)
  void clearResolution() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get notes => $_getSZ(2);
  @$pb.TagNumber(3)
  set notes($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasNotes() => $_has(2);
  @$pb.TagNumber(3)
  void clearNotes() => $_clearField(3);
}

class ResolveEscalatedItemResponse extends $pb.GeneratedMessage {
  factory ResolveEscalatedItemResponse({
    $core.bool? success,
    $core.String? message,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    return result;
  }

  ResolveEscalatedItemResponse._();

  factory ResolveEscalatedItemResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory ResolveEscalatedItemResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ResolveEscalatedItemResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ResolveEscalatedItemResponse clone() => ResolveEscalatedItemResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ResolveEscalatedItemResponse copyWith(void Function(ResolveEscalatedItemResponse) updates) => super.copyWith((message) => updates(message as ResolveEscalatedItemResponse)) as ResolveEscalatedItemResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ResolveEscalatedItemResponse create() => ResolveEscalatedItemResponse._();
  @$core.override
  ResolveEscalatedItemResponse createEmptyInstance() => create();
  static $pb.PbList<ResolveEscalatedItemResponse> createRepeated() => $pb.PbList<ResolveEscalatedItemResponse>();
  @$core.pragma('dart2js:noInline')
  static ResolveEscalatedItemResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ResolveEscalatedItemResponse>(create);
  static ResolveEscalatedItemResponse? _defaultInstance;

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

class GetReconciliationHistoryRequest extends $pb.GeneratedMessage {
  factory GetReconciliationHistoryRequest({
    $core.int? limit,
  }) {
    final result = create();
    if (limit != null) result.limit = limit;
    return result;
  }

  GetReconciliationHistoryRequest._();

  factory GetReconciliationHistoryRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GetReconciliationHistoryRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetReconciliationHistoryRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetReconciliationHistoryRequest clone() => GetReconciliationHistoryRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetReconciliationHistoryRequest copyWith(void Function(GetReconciliationHistoryRequest) updates) => super.copyWith((message) => updates(message as GetReconciliationHistoryRequest)) as GetReconciliationHistoryRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetReconciliationHistoryRequest create() => GetReconciliationHistoryRequest._();
  @$core.override
  GetReconciliationHistoryRequest createEmptyInstance() => create();
  static $pb.PbList<GetReconciliationHistoryRequest> createRepeated() => $pb.PbList<GetReconciliationHistoryRequest>();
  @$core.pragma('dart2js:noInline')
  static GetReconciliationHistoryRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetReconciliationHistoryRequest>(create);
  static GetReconciliationHistoryRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get limit => $_getIZ(0);
  @$pb.TagNumber(1)
  set limit($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasLimit() => $_has(0);
  @$pb.TagNumber(1)
  void clearLimit() => $_clearField(1);
}

class GetReconciliationHistoryResponse extends $pb.GeneratedMessage {
  factory GetReconciliationHistoryResponse({
    $core.Iterable<ReconciliationRun>? runs,
  }) {
    final result = create();
    if (runs != null) result.runs.addAll(runs);
    return result;
  }

  GetReconciliationHistoryResponse._();

  factory GetReconciliationHistoryResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GetReconciliationHistoryResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetReconciliationHistoryResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..pc<ReconciliationRun>(1, _omitFieldNames ? '' : 'runs', $pb.PbFieldType.PM, subBuilder: ReconciliationRun.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetReconciliationHistoryResponse clone() => GetReconciliationHistoryResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetReconciliationHistoryResponse copyWith(void Function(GetReconciliationHistoryResponse) updates) => super.copyWith((message) => updates(message as GetReconciliationHistoryResponse)) as GetReconciliationHistoryResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetReconciliationHistoryResponse create() => GetReconciliationHistoryResponse._();
  @$core.override
  GetReconciliationHistoryResponse createEmptyInstance() => create();
  static $pb.PbList<GetReconciliationHistoryResponse> createRepeated() => $pb.PbList<GetReconciliationHistoryResponse>();
  @$core.pragma('dart2js:noInline')
  static GetReconciliationHistoryResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetReconciliationHistoryResponse>(create);
  static GetReconciliationHistoryResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<ReconciliationRun> get runs => $_getList(0);
}

class UserSummary extends $pb.GeneratedMessage {
  factory UserSummary({
    $core.String? id,
    $core.String? name,
    $core.String? email,
    $core.String? phone,
    $fixnum.Int64? totalGiftCardSales,
    $core.double? totalPayouts,
    $core.String? createdAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (name != null) result.name = name;
    if (email != null) result.email = email;
    if (phone != null) result.phone = phone;
    if (totalGiftCardSales != null) result.totalGiftCardSales = totalGiftCardSales;
    if (totalPayouts != null) result.totalPayouts = totalPayouts;
    if (createdAt != null) result.createdAt = createdAt;
    return result;
  }

  UserSummary._();

  factory UserSummary.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory UserSummary.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UserSummary', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOS(3, _omitFieldNames ? '' : 'email')
    ..aOS(4, _omitFieldNames ? '' : 'phone')
    ..aInt64(5, _omitFieldNames ? '' : 'totalGiftCardSales')
    ..a<$core.double>(6, _omitFieldNames ? '' : 'totalPayouts', $pb.PbFieldType.OD)
    ..aOS(7, _omitFieldNames ? '' : 'createdAt')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserSummary clone() => UserSummary()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserSummary copyWith(void Function(UserSummary) updates) => super.copyWith((message) => updates(message as UserSummary)) as UserSummary;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UserSummary create() => UserSummary._();
  @$core.override
  UserSummary createEmptyInstance() => create();
  static $pb.PbList<UserSummary> createRepeated() => $pb.PbList<UserSummary>();
  @$core.pragma('dart2js:noInline')
  static UserSummary getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UserSummary>(create);
  static UserSummary? _defaultInstance;

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
  $core.String get email => $_getSZ(2);
  @$pb.TagNumber(3)
  set email($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasEmail() => $_has(2);
  @$pb.TagNumber(3)
  void clearEmail() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get phone => $_getSZ(3);
  @$pb.TagNumber(4)
  set phone($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPhone() => $_has(3);
  @$pb.TagNumber(4)
  void clearPhone() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get totalGiftCardSales => $_getI64(4);
  @$pb.TagNumber(5)
  set totalGiftCardSales($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTotalGiftCardSales() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotalGiftCardSales() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.double get totalPayouts => $_getN(5);
  @$pb.TagNumber(6)
  set totalPayouts($core.double value) => $_setDouble(5, value);
  @$pb.TagNumber(6)
  $core.bool hasTotalPayouts() => $_has(5);
  @$pb.TagNumber(6)
  void clearTotalPayouts() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get createdAt => $_getSZ(6);
  @$pb.TagNumber(7)
  set createdAt($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasCreatedAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearCreatedAt() => $_clearField(7);
}

class LookupUserRequest extends $pb.GeneratedMessage {
  factory LookupUserRequest({
    $core.String? query,
    $core.String? type,
  }) {
    final result = create();
    if (query != null) result.query = query;
    if (type != null) result.type = type;
    return result;
  }

  LookupUserRequest._();

  factory LookupUserRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory LookupUserRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'LookupUserRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'query')
    ..aOS(2, _omitFieldNames ? '' : 'type')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LookupUserRequest clone() => LookupUserRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LookupUserRequest copyWith(void Function(LookupUserRequest) updates) => super.copyWith((message) => updates(message as LookupUserRequest)) as LookupUserRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LookupUserRequest create() => LookupUserRequest._();
  @$core.override
  LookupUserRequest createEmptyInstance() => create();
  static $pb.PbList<LookupUserRequest> createRepeated() => $pb.PbList<LookupUserRequest>();
  @$core.pragma('dart2js:noInline')
  static LookupUserRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LookupUserRequest>(create);
  static LookupUserRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get query => $_getSZ(0);
  @$pb.TagNumber(1)
  set query($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasQuery() => $_has(0);
  @$pb.TagNumber(1)
  void clearQuery() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get type => $_getSZ(1);
  @$pb.TagNumber(2)
  set type($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasType() => $_has(1);
  @$pb.TagNumber(2)
  void clearType() => $_clearField(2);
}

class LookupUserResponse extends $pb.GeneratedMessage {
  factory LookupUserResponse({
    $core.Iterable<UserSummary>? users,
  }) {
    final result = create();
    if (users != null) result.users.addAll(users);
    return result;
  }

  LookupUserResponse._();

  factory LookupUserResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory LookupUserResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'LookupUserResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..pc<UserSummary>(1, _omitFieldNames ? '' : 'users', $pb.PbFieldType.PM, subBuilder: UserSummary.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LookupUserResponse clone() => LookupUserResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LookupUserResponse copyWith(void Function(LookupUserResponse) updates) => super.copyWith((message) => updates(message as LookupUserResponse)) as LookupUserResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LookupUserResponse create() => LookupUserResponse._();
  @$core.override
  LookupUserResponse createEmptyInstance() => create();
  static $pb.PbList<LookupUserResponse> createRepeated() => $pb.PbList<LookupUserResponse>();
  @$core.pragma('dart2js:noInline')
  static LookupUserResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LookupUserResponse>(create);
  static LookupUserResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<UserSummary> get users => $_getList(0);
}

class GetUserDetailsRequest extends $pb.GeneratedMessage {
  factory GetUserDetailsRequest({
    $core.String? userId,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    return result;
  }

  GetUserDetailsRequest._();

  factory GetUserDetailsRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GetUserDetailsRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetUserDetailsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserDetailsRequest clone() => GetUserDetailsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserDetailsRequest copyWith(void Function(GetUserDetailsRequest) updates) => super.copyWith((message) => updates(message as GetUserDetailsRequest)) as GetUserDetailsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserDetailsRequest create() => GetUserDetailsRequest._();
  @$core.override
  GetUserDetailsRequest createEmptyInstance() => create();
  static $pb.PbList<GetUserDetailsRequest> createRepeated() => $pb.PbList<GetUserDetailsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetUserDetailsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetUserDetailsRequest>(create);
  static GetUserDetailsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);
}

class GetUserDetailsResponse extends $pb.GeneratedMessage {
  factory GetUserDetailsResponse({
    UserSummary? user,
    $core.Iterable<GiftCardSale>? recentSales,
  }) {
    final result = create();
    if (user != null) result.user = user;
    if (recentSales != null) result.recentSales.addAll(recentSales);
    return result;
  }

  GetUserDetailsResponse._();

  factory GetUserDetailsResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GetUserDetailsResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetUserDetailsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOM<UserSummary>(1, _omitFieldNames ? '' : 'user', subBuilder: UserSummary.create)
    ..pc<GiftCardSale>(2, _omitFieldNames ? '' : 'recentSales', $pb.PbFieldType.PM, subBuilder: GiftCardSale.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserDetailsResponse clone() => GetUserDetailsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUserDetailsResponse copyWith(void Function(GetUserDetailsResponse) updates) => super.copyWith((message) => updates(message as GetUserDetailsResponse)) as GetUserDetailsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetUserDetailsResponse create() => GetUserDetailsResponse._();
  @$core.override
  GetUserDetailsResponse createEmptyInstance() => create();
  static $pb.PbList<GetUserDetailsResponse> createRepeated() => $pb.PbList<GetUserDetailsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetUserDetailsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetUserDetailsResponse>(create);
  static GetUserDetailsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  UserSummary get user => $_getN(0);
  @$pb.TagNumber(1)
  set user(UserSummary value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasUser() => $_has(0);
  @$pb.TagNumber(1)
  void clearUser() => $_clearField(1);
  @$pb.TagNumber(1)
  UserSummary ensureUser() => $_ensure(0);

  @$pb.TagNumber(2)
  $pb.PbList<GiftCardSale> get recentSales => $_getList(1);
}

class AuditLogEntry extends $pb.GeneratedMessage {
  factory AuditLogEntry({
    $core.String? id,
    $core.String? timestamp,
    $core.String? admin,
    $core.String? action,
    $core.String? target,
    $core.String? details,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (timestamp != null) result.timestamp = timestamp;
    if (admin != null) result.admin = admin;
    if (action != null) result.action = action;
    if (target != null) result.target = target;
    if (details != null) result.details = details;
    return result;
  }

  AuditLogEntry._();

  factory AuditLogEntry.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory AuditLogEntry.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AuditLogEntry', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'timestamp')
    ..aOS(3, _omitFieldNames ? '' : 'admin')
    ..aOS(4, _omitFieldNames ? '' : 'action')
    ..aOS(5, _omitFieldNames ? '' : 'target')
    ..aOS(6, _omitFieldNames ? '' : 'details')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AuditLogEntry clone() => AuditLogEntry()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AuditLogEntry copyWith(void Function(AuditLogEntry) updates) => super.copyWith((message) => updates(message as AuditLogEntry)) as AuditLogEntry;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AuditLogEntry create() => AuditLogEntry._();
  @$core.override
  AuditLogEntry createEmptyInstance() => create();
  static $pb.PbList<AuditLogEntry> createRepeated() => $pb.PbList<AuditLogEntry>();
  @$core.pragma('dart2js:noInline')
  static AuditLogEntry getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AuditLogEntry>(create);
  static AuditLogEntry? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get timestamp => $_getSZ(1);
  @$pb.TagNumber(2)
  set timestamp($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTimestamp() => $_has(1);
  @$pb.TagNumber(2)
  void clearTimestamp() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get admin => $_getSZ(2);
  @$pb.TagNumber(3)
  set admin($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAdmin() => $_has(2);
  @$pb.TagNumber(3)
  void clearAdmin() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get action => $_getSZ(3);
  @$pb.TagNumber(4)
  set action($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAction() => $_has(3);
  @$pb.TagNumber(4)
  void clearAction() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get target => $_getSZ(4);
  @$pb.TagNumber(5)
  set target($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTarget() => $_has(4);
  @$pb.TagNumber(5)
  void clearTarget() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get details => $_getSZ(5);
  @$pb.TagNumber(6)
  set details($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasDetails() => $_has(5);
  @$pb.TagNumber(6)
  void clearDetails() => $_clearField(6);
}

class SearchGiftCardTransactionRequest extends $pb.GeneratedMessage {
  factory SearchGiftCardTransactionRequest({
    $core.String? reference,
  }) {
    final result = create();
    if (reference != null) result.reference = reference;
    return result;
  }

  SearchGiftCardTransactionRequest._();

  factory SearchGiftCardTransactionRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory SearchGiftCardTransactionRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SearchGiftCardTransactionRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'reference')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchGiftCardTransactionRequest clone() => SearchGiftCardTransactionRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchGiftCardTransactionRequest copyWith(void Function(SearchGiftCardTransactionRequest) updates) => super.copyWith((message) => updates(message as SearchGiftCardTransactionRequest)) as SearchGiftCardTransactionRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SearchGiftCardTransactionRequest create() => SearchGiftCardTransactionRequest._();
  @$core.override
  SearchGiftCardTransactionRequest createEmptyInstance() => create();
  static $pb.PbList<SearchGiftCardTransactionRequest> createRepeated() => $pb.PbList<SearchGiftCardTransactionRequest>();
  @$core.pragma('dart2js:noInline')
  static SearchGiftCardTransactionRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SearchGiftCardTransactionRequest>(create);
  static SearchGiftCardTransactionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get reference => $_getSZ(0);
  @$pb.TagNumber(1)
  set reference($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasReference() => $_has(0);
  @$pb.TagNumber(1)
  void clearReference() => $_clearField(1);
}

class SearchGiftCardTransactionResponse extends $pb.GeneratedMessage {
  factory SearchGiftCardTransactionResponse({
    GiftCardSale? sale,
    $core.Iterable<AuditLogEntry>? events,
  }) {
    final result = create();
    if (sale != null) result.sale = sale;
    if (events != null) result.events.addAll(events);
    return result;
  }

  SearchGiftCardTransactionResponse._();

  factory SearchGiftCardTransactionResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory SearchGiftCardTransactionResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SearchGiftCardTransactionResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOM<GiftCardSale>(1, _omitFieldNames ? '' : 'sale', subBuilder: GiftCardSale.create)
    ..pc<AuditLogEntry>(2, _omitFieldNames ? '' : 'events', $pb.PbFieldType.PM, subBuilder: AuditLogEntry.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchGiftCardTransactionResponse clone() => SearchGiftCardTransactionResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchGiftCardTransactionResponse copyWith(void Function(SearchGiftCardTransactionResponse) updates) => super.copyWith((message) => updates(message as SearchGiftCardTransactionResponse)) as SearchGiftCardTransactionResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SearchGiftCardTransactionResponse create() => SearchGiftCardTransactionResponse._();
  @$core.override
  SearchGiftCardTransactionResponse createEmptyInstance() => create();
  static $pb.PbList<SearchGiftCardTransactionResponse> createRepeated() => $pb.PbList<SearchGiftCardTransactionResponse>();
  @$core.pragma('dart2js:noInline')
  static SearchGiftCardTransactionResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SearchGiftCardTransactionResponse>(create);
  static SearchGiftCardTransactionResponse? _defaultInstance;

  @$pb.TagNumber(1)
  GiftCardSale get sale => $_getN(0);
  @$pb.TagNumber(1)
  set sale(GiftCardSale value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasSale() => $_has(0);
  @$pb.TagNumber(1)
  void clearSale() => $_clearField(1);
  @$pb.TagNumber(1)
  GiftCardSale ensureSale() => $_ensure(0);

  @$pb.TagNumber(2)
  $pb.PbList<AuditLogEntry> get events => $_getList(1);
}

class PerformManualOperationRequest extends $pb.GeneratedMessage {
  factory PerformManualOperationRequest({
    $core.String? transactionId,
    $core.String? operation,
    $core.String? reason,
    $core.String? notes,
    $core.double? amountOverride,
  }) {
    final result = create();
    if (transactionId != null) result.transactionId = transactionId;
    if (operation != null) result.operation = operation;
    if (reason != null) result.reason = reason;
    if (notes != null) result.notes = notes;
    if (amountOverride != null) result.amountOverride = amountOverride;
    return result;
  }

  PerformManualOperationRequest._();

  factory PerformManualOperationRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory PerformManualOperationRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PerformManualOperationRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'transactionId')
    ..aOS(2, _omitFieldNames ? '' : 'operation')
    ..aOS(3, _omitFieldNames ? '' : 'reason')
    ..aOS(4, _omitFieldNames ? '' : 'notes')
    ..a<$core.double>(5, _omitFieldNames ? '' : 'amountOverride', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PerformManualOperationRequest clone() => PerformManualOperationRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PerformManualOperationRequest copyWith(void Function(PerformManualOperationRequest) updates) => super.copyWith((message) => updates(message as PerformManualOperationRequest)) as PerformManualOperationRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PerformManualOperationRequest create() => PerformManualOperationRequest._();
  @$core.override
  PerformManualOperationRequest createEmptyInstance() => create();
  static $pb.PbList<PerformManualOperationRequest> createRepeated() => $pb.PbList<PerformManualOperationRequest>();
  @$core.pragma('dart2js:noInline')
  static PerformManualOperationRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PerformManualOperationRequest>(create);
  static PerformManualOperationRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get transactionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set transactionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTransactionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransactionId() => $_clearField(1);

  /// Operation key. `refund_sale` is canonical; `reverse_sale` kept as
  /// a back-compat alias during the rename rollout. Both route through
  /// the three-phase rollback pipeline (verify → refund → reverse
  /// settlement) and end at status='refunded'.
  /// retry_settlement|manual_payout|refund_sale|reverse_sale|cancel_sale|escalate
  @$pb.TagNumber(2)
  $core.String get operation => $_getSZ(1);
  @$pb.TagNumber(2)
  set operation($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasOperation() => $_has(1);
  @$pb.TagNumber(2)
  void clearOperation() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get reason => $_getSZ(2);
  @$pb.TagNumber(3)
  set reason($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasReason() => $_has(2);
  @$pb.TagNumber(3)
  void clearReason() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get notes => $_getSZ(3);
  @$pb.TagNumber(4)
  set notes($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasNotes() => $_has(3);
  @$pb.TagNumber(4)
  void clearNotes() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.double get amountOverride => $_getN(4);
  @$pb.TagNumber(5)
  set amountOverride($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasAmountOverride() => $_has(4);
  @$pb.TagNumber(5)
  void clearAmountOverride() => $_clearField(5);
}

class PerformManualOperationResponse extends $pb.GeneratedMessage {
  factory PerformManualOperationResponse({
    $core.bool? success,
    $core.String? message,
    GiftCardSale? sale,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (sale != null) result.sale = sale;
    return result;
  }

  PerformManualOperationResponse._();

  factory PerformManualOperationResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory PerformManualOperationResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PerformManualOperationResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<GiftCardSale>(3, _omitFieldNames ? '' : 'sale', subBuilder: GiftCardSale.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PerformManualOperationResponse clone() => PerformManualOperationResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PerformManualOperationResponse copyWith(void Function(PerformManualOperationResponse) updates) => super.copyWith((message) => updates(message as PerformManualOperationResponse)) as PerformManualOperationResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PerformManualOperationResponse create() => PerformManualOperationResponse._();
  @$core.override
  PerformManualOperationResponse createEmptyInstance() => create();
  static $pb.PbList<PerformManualOperationResponse> createRepeated() => $pb.PbList<PerformManualOperationResponse>();
  @$core.pragma('dart2js:noInline')
  static PerformManualOperationResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PerformManualOperationResponse>(create);
  static PerformManualOperationResponse? _defaultInstance;

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

  @$pb.TagNumber(3)
  GiftCardSale get sale => $_getN(2);
  @$pb.TagNumber(3)
  set sale(GiftCardSale value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasSale() => $_has(2);
  @$pb.TagNumber(3)
  void clearSale() => $_clearField(3);
  @$pb.TagNumber(3)
  GiftCardSale ensureSale() => $_ensure(2);
}

class GetGiftCardAuditLogRequest extends $pb.GeneratedMessage {
  factory GetGiftCardAuditLogRequest({
    $core.String? transactionId,
    $core.String? userId,
    $core.int? page,
    $core.int? limit,
  }) {
    final result = create();
    if (transactionId != null) result.transactionId = transactionId;
    if (userId != null) result.userId = userId;
    if (page != null) result.page = page;
    if (limit != null) result.limit = limit;
    return result;
  }

  GetGiftCardAuditLogRequest._();

  factory GetGiftCardAuditLogRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GetGiftCardAuditLogRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetGiftCardAuditLogRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'transactionId')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetGiftCardAuditLogRequest clone() => GetGiftCardAuditLogRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetGiftCardAuditLogRequest copyWith(void Function(GetGiftCardAuditLogRequest) updates) => super.copyWith((message) => updates(message as GetGiftCardAuditLogRequest)) as GetGiftCardAuditLogRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetGiftCardAuditLogRequest create() => GetGiftCardAuditLogRequest._();
  @$core.override
  GetGiftCardAuditLogRequest createEmptyInstance() => create();
  static $pb.PbList<GetGiftCardAuditLogRequest> createRepeated() => $pb.PbList<GetGiftCardAuditLogRequest>();
  @$core.pragma('dart2js:noInline')
  static GetGiftCardAuditLogRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetGiftCardAuditLogRequest>(create);
  static GetGiftCardAuditLogRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get transactionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set transactionId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTransactionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransactionId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get page => $_getIZ(2);
  @$pb.TagNumber(3)
  set page($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPage() => $_has(2);
  @$pb.TagNumber(3)
  void clearPage() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get limit => $_getIZ(3);
  @$pb.TagNumber(4)
  set limit($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasLimit() => $_has(3);
  @$pb.TagNumber(4)
  void clearLimit() => $_clearField(4);
}

class GetGiftCardAuditLogResponse extends $pb.GeneratedMessage {
  factory GetGiftCardAuditLogResponse({
    $core.Iterable<AuditLogEntry>? logs,
    $fixnum.Int64? total,
    $core.int? page,
    $core.int? limit,
  }) {
    final result = create();
    if (logs != null) result.logs.addAll(logs);
    if (total != null) result.total = total;
    if (page != null) result.page = page;
    if (limit != null) result.limit = limit;
    return result;
  }

  GetGiftCardAuditLogResponse._();

  factory GetGiftCardAuditLogResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GetGiftCardAuditLogResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetGiftCardAuditLogResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..pc<AuditLogEntry>(1, _omitFieldNames ? '' : 'logs', $pb.PbFieldType.PM, subBuilder: AuditLogEntry.create)
    ..aInt64(2, _omitFieldNames ? '' : 'total')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'page', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetGiftCardAuditLogResponse clone() => GetGiftCardAuditLogResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetGiftCardAuditLogResponse copyWith(void Function(GetGiftCardAuditLogResponse) updates) => super.copyWith((message) => updates(message as GetGiftCardAuditLogResponse)) as GetGiftCardAuditLogResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetGiftCardAuditLogResponse create() => GetGiftCardAuditLogResponse._();
  @$core.override
  GetGiftCardAuditLogResponse createEmptyInstance() => create();
  static $pb.PbList<GetGiftCardAuditLogResponse> createRepeated() => $pb.PbList<GetGiftCardAuditLogResponse>();
  @$core.pragma('dart2js:noInline')
  static GetGiftCardAuditLogResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetGiftCardAuditLogResponse>(create);
  static GetGiftCardAuditLogResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<AuditLogEntry> get logs => $_getList(0);

  @$pb.TagNumber(2)
  $fixnum.Int64 get total => $_getI64(1);
  @$pb.TagNumber(2)
  set total($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get page => $_getIZ(2);
  @$pb.TagNumber(3)
  set page($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPage() => $_has(2);
  @$pb.TagNumber(3)
  void clearPage() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get limit => $_getIZ(3);
  @$pb.TagNumber(4)
  set limit($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasLimit() => $_has(3);
  @$pb.TagNumber(4)
  void clearLimit() => $_clearField(4);
}

class SystemSetting extends $pb.GeneratedMessage {
  factory SystemSetting({
    $core.String? key,
    $core.String? value,
    $core.String? category,
    $core.String? description,
    $core.String? updatedAt,
  }) {
    final result = create();
    if (key != null) result.key = key;
    if (value != null) result.value = value;
    if (category != null) result.category = category;
    if (description != null) result.description = description;
    if (updatedAt != null) result.updatedAt = updatedAt;
    return result;
  }

  SystemSetting._();

  factory SystemSetting.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory SystemSetting.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SystemSetting', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'key')
    ..aOS(2, _omitFieldNames ? '' : 'value')
    ..aOS(3, _omitFieldNames ? '' : 'category')
    ..aOS(4, _omitFieldNames ? '' : 'description')
    ..aOS(5, _omitFieldNames ? '' : 'updatedAt')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SystemSetting clone() => SystemSetting()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SystemSetting copyWith(void Function(SystemSetting) updates) => super.copyWith((message) => updates(message as SystemSetting)) as SystemSetting;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SystemSetting create() => SystemSetting._();
  @$core.override
  SystemSetting createEmptyInstance() => create();
  static $pb.PbList<SystemSetting> createRepeated() => $pb.PbList<SystemSetting>();
  @$core.pragma('dart2js:noInline')
  static SystemSetting getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SystemSetting>(create);
  static SystemSetting? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get key => $_getSZ(0);
  @$pb.TagNumber(1)
  set key($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearKey() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get value => $_getSZ(1);
  @$pb.TagNumber(2)
  set value($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearValue() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get category => $_getSZ(2);
  @$pb.TagNumber(3)
  set category($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCategory() => $_has(2);
  @$pb.TagNumber(3)
  void clearCategory() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get description => $_getSZ(3);
  @$pb.TagNumber(4)
  set description($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDescription() => $_has(3);
  @$pb.TagNumber(4)
  void clearDescription() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get updatedAt => $_getSZ(4);
  @$pb.TagNumber(5)
  set updatedAt($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasUpdatedAt() => $_has(4);
  @$pb.TagNumber(5)
  void clearUpdatedAt() => $_clearField(5);
}

class ListSystemSettingsRequest extends $pb.GeneratedMessage {
  factory ListSystemSettingsRequest({
    $core.String? category,
  }) {
    final result = create();
    if (category != null) result.category = category;
    return result;
  }

  ListSystemSettingsRequest._();

  factory ListSystemSettingsRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory ListSystemSettingsRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ListSystemSettingsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'category')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListSystemSettingsRequest clone() => ListSystemSettingsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListSystemSettingsRequest copyWith(void Function(ListSystemSettingsRequest) updates) => super.copyWith((message) => updates(message as ListSystemSettingsRequest)) as ListSystemSettingsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListSystemSettingsRequest create() => ListSystemSettingsRequest._();
  @$core.override
  ListSystemSettingsRequest createEmptyInstance() => create();
  static $pb.PbList<ListSystemSettingsRequest> createRepeated() => $pb.PbList<ListSystemSettingsRequest>();
  @$core.pragma('dart2js:noInline')
  static ListSystemSettingsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListSystemSettingsRequest>(create);
  static ListSystemSettingsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get category => $_getSZ(0);
  @$pb.TagNumber(1)
  set category($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCategory() => $_has(0);
  @$pb.TagNumber(1)
  void clearCategory() => $_clearField(1);
}

class ListSystemSettingsResponse extends $pb.GeneratedMessage {
  factory ListSystemSettingsResponse({
    $core.Iterable<SystemSetting>? settings,
  }) {
    final result = create();
    if (settings != null) result.settings.addAll(settings);
    return result;
  }

  ListSystemSettingsResponse._();

  factory ListSystemSettingsResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory ListSystemSettingsResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ListSystemSettingsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..pc<SystemSetting>(1, _omitFieldNames ? '' : 'settings', $pb.PbFieldType.PM, subBuilder: SystemSetting.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListSystemSettingsResponse clone() => ListSystemSettingsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListSystemSettingsResponse copyWith(void Function(ListSystemSettingsResponse) updates) => super.copyWith((message) => updates(message as ListSystemSettingsResponse)) as ListSystemSettingsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListSystemSettingsResponse create() => ListSystemSettingsResponse._();
  @$core.override
  ListSystemSettingsResponse createEmptyInstance() => create();
  static $pb.PbList<ListSystemSettingsResponse> createRepeated() => $pb.PbList<ListSystemSettingsResponse>();
  @$core.pragma('dart2js:noInline')
  static ListSystemSettingsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListSystemSettingsResponse>(create);
  static ListSystemSettingsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<SystemSetting> get settings => $_getList(0);
}

class UpdateSystemSettingRequest extends $pb.GeneratedMessage {
  factory UpdateSystemSettingRequest({
    $core.String? key,
    $core.String? value,
  }) {
    final result = create();
    if (key != null) result.key = key;
    if (value != null) result.value = value;
    return result;
  }

  UpdateSystemSettingRequest._();

  factory UpdateSystemSettingRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory UpdateSystemSettingRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateSystemSettingRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'key')
    ..aOS(2, _omitFieldNames ? '' : 'value')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateSystemSettingRequest clone() => UpdateSystemSettingRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateSystemSettingRequest copyWith(void Function(UpdateSystemSettingRequest) updates) => super.copyWith((message) => updates(message as UpdateSystemSettingRequest)) as UpdateSystemSettingRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateSystemSettingRequest create() => UpdateSystemSettingRequest._();
  @$core.override
  UpdateSystemSettingRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateSystemSettingRequest> createRepeated() => $pb.PbList<UpdateSystemSettingRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateSystemSettingRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateSystemSettingRequest>(create);
  static UpdateSystemSettingRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get key => $_getSZ(0);
  @$pb.TagNumber(1)
  set key($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearKey() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get value => $_getSZ(1);
  @$pb.TagNumber(2)
  set value($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearValue() => $_clearField(2);
}

class UpdateSystemSettingResponse extends $pb.GeneratedMessage {
  factory UpdateSystemSettingResponse({
    $core.bool? success,
    $core.String? message,
    SystemSetting? setting,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (message != null) result.message = message;
    if (setting != null) result.setting = setting;
    return result;
  }

  UpdateSystemSettingResponse._();

  factory UpdateSystemSettingResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory UpdateSystemSettingResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateSystemSettingResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<SystemSetting>(3, _omitFieldNames ? '' : 'setting', subBuilder: SystemSetting.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateSystemSettingResponse clone() => UpdateSystemSettingResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateSystemSettingResponse copyWith(void Function(UpdateSystemSettingResponse) updates) => super.copyWith((message) => updates(message as UpdateSystemSettingResponse)) as UpdateSystemSettingResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateSystemSettingResponse create() => UpdateSystemSettingResponse._();
  @$core.override
  UpdateSystemSettingResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateSystemSettingResponse> createRepeated() => $pb.PbList<UpdateSystemSettingResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateSystemSettingResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateSystemSettingResponse>(create);
  static UpdateSystemSettingResponse? _defaultInstance;

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

  @$pb.TagNumber(3)
  SystemSetting get setting => $_getN(2);
  @$pb.TagNumber(3)
  set setting(SystemSetting value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasSetting() => $_has(2);
  @$pb.TagNumber(3)
  void clearSetting() => $_clearField(3);
  @$pb.TagNumber(3)
  SystemSetting ensureSetting() => $_ensure(2);
}


const $core.bool _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
