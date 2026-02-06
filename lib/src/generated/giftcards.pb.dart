//
//  Generated code. Do not modify.
//  source: giftcards.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class GiftCard extends $pb.GeneratedMessage {
  factory GiftCard({
    $core.String? id,
    $core.String? userId,
    $core.String? accountId,
    $core.String? brandId,
    $core.String? brandName,
    $core.String? cardNumber,
    $core.String? pin,
    $core.double? originalAmount,
    $core.double? currentBalance,
    $core.String? currency,
    $core.String? status,
    $core.String? purchaseDate,
    $core.String? expiryDate,
    $core.String? recipientEmail,
    $core.String? recipientName,
    $core.String? message,
    $core.String? qrCode,
    $core.String? metadata,
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
    if (accountId != null) {
      $result.accountId = accountId;
    }
    if (brandId != null) {
      $result.brandId = brandId;
    }
    if (brandName != null) {
      $result.brandName = brandName;
    }
    if (cardNumber != null) {
      $result.cardNumber = cardNumber;
    }
    if (pin != null) {
      $result.pin = pin;
    }
    if (originalAmount != null) {
      $result.originalAmount = originalAmount;
    }
    if (currentBalance != null) {
      $result.currentBalance = currentBalance;
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (status != null) {
      $result.status = status;
    }
    if (purchaseDate != null) {
      $result.purchaseDate = purchaseDate;
    }
    if (expiryDate != null) {
      $result.expiryDate = expiryDate;
    }
    if (recipientEmail != null) {
      $result.recipientEmail = recipientEmail;
    }
    if (recipientName != null) {
      $result.recipientName = recipientName;
    }
    if (message != null) {
      $result.message = message;
    }
    if (qrCode != null) {
      $result.qrCode = qrCode;
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
    return $result;
  }
  GiftCard._() : super();
  factory GiftCard.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GiftCard.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GiftCard', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'accountId')
    ..aOS(4, _omitFieldNames ? '' : 'brandId')
    ..aOS(5, _omitFieldNames ? '' : 'brandName')
    ..aOS(6, _omitFieldNames ? '' : 'cardNumber')
    ..aOS(7, _omitFieldNames ? '' : 'pin')
    ..a<$core.double>(8, _omitFieldNames ? '' : 'originalAmount', $pb.PbFieldType.OD)
    ..a<$core.double>(9, _omitFieldNames ? '' : 'currentBalance', $pb.PbFieldType.OD)
    ..aOS(10, _omitFieldNames ? '' : 'currency')
    ..aOS(11, _omitFieldNames ? '' : 'status')
    ..aOS(12, _omitFieldNames ? '' : 'purchaseDate')
    ..aOS(13, _omitFieldNames ? '' : 'expiryDate')
    ..aOS(14, _omitFieldNames ? '' : 'recipientEmail')
    ..aOS(15, _omitFieldNames ? '' : 'recipientName')
    ..aOS(16, _omitFieldNames ? '' : 'message')
    ..aOS(17, _omitFieldNames ? '' : 'qrCode')
    ..aOS(18, _omitFieldNames ? '' : 'metadata')
    ..aOS(19, _omitFieldNames ? '' : 'createdAt')
    ..aOS(20, _omitFieldNames ? '' : 'updatedAt')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GiftCard clone() => GiftCard()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GiftCard copyWith(void Function(GiftCard) updates) => super.copyWith((message) => updates(message as GiftCard)) as GiftCard;

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

  @$pb.TagNumber(6)
  $core.String get cardNumber => $_getSZ(5);
  @$pb.TagNumber(6)
  set cardNumber($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasCardNumber() => $_has(5);
  @$pb.TagNumber(6)
  void clearCardNumber() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get pin => $_getSZ(6);
  @$pb.TagNumber(7)
  set pin($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasPin() => $_has(6);
  @$pb.TagNumber(7)
  void clearPin() => clearField(7);

  @$pb.TagNumber(8)
  $core.double get originalAmount => $_getN(7);
  @$pb.TagNumber(8)
  set originalAmount($core.double v) { $_setDouble(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasOriginalAmount() => $_has(7);
  @$pb.TagNumber(8)
  void clearOriginalAmount() => clearField(8);

  @$pb.TagNumber(9)
  $core.double get currentBalance => $_getN(8);
  @$pb.TagNumber(9)
  set currentBalance($core.double v) { $_setDouble(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasCurrentBalance() => $_has(8);
  @$pb.TagNumber(9)
  void clearCurrentBalance() => clearField(9);

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
  $core.String get purchaseDate => $_getSZ(11);
  @$pb.TagNumber(12)
  set purchaseDate($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasPurchaseDate() => $_has(11);
  @$pb.TagNumber(12)
  void clearPurchaseDate() => clearField(12);

  @$pb.TagNumber(13)
  $core.String get expiryDate => $_getSZ(12);
  @$pb.TagNumber(13)
  set expiryDate($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasExpiryDate() => $_has(12);
  @$pb.TagNumber(13)
  void clearExpiryDate() => clearField(13);

  @$pb.TagNumber(14)
  $core.String get recipientEmail => $_getSZ(13);
  @$pb.TagNumber(14)
  set recipientEmail($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasRecipientEmail() => $_has(13);
  @$pb.TagNumber(14)
  void clearRecipientEmail() => clearField(14);

  @$pb.TagNumber(15)
  $core.String get recipientName => $_getSZ(14);
  @$pb.TagNumber(15)
  set recipientName($core.String v) { $_setString(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasRecipientName() => $_has(14);
  @$pb.TagNumber(15)
  void clearRecipientName() => clearField(15);

  @$pb.TagNumber(16)
  $core.String get message => $_getSZ(15);
  @$pb.TagNumber(16)
  set message($core.String v) { $_setString(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasMessage() => $_has(15);
  @$pb.TagNumber(16)
  void clearMessage() => clearField(16);

  @$pb.TagNumber(17)
  $core.String get qrCode => $_getSZ(16);
  @$pb.TagNumber(17)
  set qrCode($core.String v) { $_setString(16, v); }
  @$pb.TagNumber(17)
  $core.bool hasQrCode() => $_has(16);
  @$pb.TagNumber(17)
  void clearQrCode() => clearField(17);

  @$pb.TagNumber(18)
  $core.String get metadata => $_getSZ(17);
  @$pb.TagNumber(18)
  set metadata($core.String v) { $_setString(17, v); }
  @$pb.TagNumber(18)
  $core.bool hasMetadata() => $_has(17);
  @$pb.TagNumber(18)
  void clearMetadata() => clearField(18);

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
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (name != null) {
      $result.name = name;
    }
    if (logoUrl != null) {
      $result.logoUrl = logoUrl;
    }
    if (category != null) {
      $result.category = category;
    }
    if (description != null) {
      $result.description = description;
    }
    if (denominations != null) {
      $result.denominations.addAll(denominations);
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
    if (termsAndConditions != null) {
      $result.termsAndConditions = termsAndConditions;
    }
    return $result;
  }
  GiftCardBrand._() : super();
  factory GiftCardBrand.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GiftCardBrand.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

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
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GiftCardBrand clone() => GiftCardBrand()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GiftCardBrand copyWith(void Function(GiftCardBrand) updates) => super.copyWith((message) => updates(message as GiftCardBrand)) as GiftCardBrand;

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
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (giftCardId != null) {
      $result.giftCardId = giftCardId;
    }
    if (userId != null) {
      $result.userId = userId;
    }
    if (transactionType != null) {
      $result.transactionType = transactionType;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (balanceBefore != null) {
      $result.balanceBefore = balanceBefore;
    }
    if (balanceAfter != null) {
      $result.balanceAfter = balanceAfter;
    }
    if (description != null) {
      $result.description = description;
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    return $result;
  }
  GiftCardTransaction._() : super();
  factory GiftCardTransaction.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GiftCardTransaction.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

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
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GiftCardTransaction clone() => GiftCardTransaction()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GiftCardTransaction copyWith(void Function(GiftCardTransaction) updates) => super.copyWith((message) => updates(message as GiftCardTransaction)) as GiftCardTransaction;

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
  }) {
    final $result = create();
    if (accountId != null) {
      $result.accountId = accountId;
    }
    if (brandId != null) {
      $result.brandId = brandId;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (recipientEmail != null) {
      $result.recipientEmail = recipientEmail;
    }
    if (recipientName != null) {
      $result.recipientName = recipientName;
    }
    if (giftMessage != null) {
      $result.giftMessage = giftMessage;
    }
    if (transactionId != null) {
      $result.transactionId = transactionId;
    }
    if (verificationToken != null) {
      $result.verificationToken = verificationToken;
    }
    return $result;
  }
  BuyGiftCardRequest._() : super();
  factory BuyGiftCardRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BuyGiftCardRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'BuyGiftCardRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..aOS(2, _omitFieldNames ? '' : 'brandId')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OD)
    ..aOS(4, _omitFieldNames ? '' : 'recipientEmail')
    ..aOS(5, _omitFieldNames ? '' : 'recipientName')
    ..aOS(6, _omitFieldNames ? '' : 'giftMessage')
    ..aOS(7, _omitFieldNames ? '' : 'transactionId')
    ..aOS(8, _omitFieldNames ? '' : 'verificationToken')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BuyGiftCardRequest clone() => BuyGiftCardRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BuyGiftCardRequest copyWith(void Function(BuyGiftCardRequest) updates) => super.copyWith((message) => updates(message as BuyGiftCardRequest)) as BuyGiftCardRequest;

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

  /// Transaction PIN verification (replaces direct PIN field)
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
}

class BuyGiftCardResponse extends $pb.GeneratedMessage {
  factory BuyGiftCardResponse({
    GiftCard? giftCard,
    $core.double? newBalance,
    $core.String? message,
  }) {
    final $result = create();
    if (giftCard != null) {
      $result.giftCard = giftCard;
    }
    if (newBalance != null) {
      $result.newBalance = newBalance;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  BuyGiftCardResponse._() : super();
  factory BuyGiftCardResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BuyGiftCardResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'BuyGiftCardResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOM<GiftCard>(1, _omitFieldNames ? '' : 'giftCard', subBuilder: GiftCard.create)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'newBalance', $pb.PbFieldType.OD)
    ..aOS(3, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BuyGiftCardResponse clone() => BuyGiftCardResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BuyGiftCardResponse copyWith(void Function(BuyGiftCardResponse) updates) => super.copyWith((message) => updates(message as BuyGiftCardResponse)) as BuyGiftCardResponse;

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
}

/// ===== REDEEM GIFT CARD =====
/// NOTE: user_id extracted from JWT token, not from request
class RedeemGiftCardRequest extends $pb.GeneratedMessage {
  factory RedeemGiftCardRequest({
    $core.String? accountId,
    $core.String? cardNumber,
    $core.String? cardPin,
  }) {
    final $result = create();
    if (accountId != null) {
      $result.accountId = accountId;
    }
    if (cardNumber != null) {
      $result.cardNumber = cardNumber;
    }
    if (cardPin != null) {
      $result.cardPin = cardPin;
    }
    return $result;
  }
  RedeemGiftCardRequest._() : super();
  factory RedeemGiftCardRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RedeemGiftCardRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RedeemGiftCardRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accountId')
    ..aOS(2, _omitFieldNames ? '' : 'cardNumber')
    ..aOS(3, _omitFieldNames ? '' : 'cardPin')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RedeemGiftCardRequest clone() => RedeemGiftCardRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RedeemGiftCardRequest copyWith(void Function(RedeemGiftCardRequest) updates) => super.copyWith((message) => updates(message as RedeemGiftCardRequest)) as RedeemGiftCardRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RedeemGiftCardRequest create() => RedeemGiftCardRequest._();
  RedeemGiftCardRequest createEmptyInstance() => create();
  static $pb.PbList<RedeemGiftCardRequest> createRepeated() => $pb.PbList<RedeemGiftCardRequest>();
  @$core.pragma('dart2js:noInline')
  static RedeemGiftCardRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RedeemGiftCardRequest>(create);
  static RedeemGiftCardRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get accountId => $_getSZ(0);
  @$pb.TagNumber(1)
  set accountId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccountId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccountId() => clearField(1);

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
}

class RedeemGiftCardResponse extends $pb.GeneratedMessage {
  factory RedeemGiftCardResponse({
    GiftCard? giftCard,
    $core.double? amountRedeemed,
    $core.double? newBalance,
    $core.String? message,
  }) {
    final $result = create();
    if (giftCard != null) {
      $result.giftCard = giftCard;
    }
    if (amountRedeemed != null) {
      $result.amountRedeemed = amountRedeemed;
    }
    if (newBalance != null) {
      $result.newBalance = newBalance;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  RedeemGiftCardResponse._() : super();
  factory RedeemGiftCardResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RedeemGiftCardResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RedeemGiftCardResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOM<GiftCard>(1, _omitFieldNames ? '' : 'giftCard', subBuilder: GiftCard.create)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'amountRedeemed', $pb.PbFieldType.OD)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'newBalance', $pb.PbFieldType.OD)
    ..aOS(4, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RedeemGiftCardResponse clone() => RedeemGiftCardResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RedeemGiftCardResponse copyWith(void Function(RedeemGiftCardResponse) updates) => super.copyWith((message) => updates(message as RedeemGiftCardResponse)) as RedeemGiftCardResponse;

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
  $core.double get amountRedeemed => $_getN(1);
  @$pb.TagNumber(2)
  set amountRedeemed($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAmountRedeemed() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmountRedeemed() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get newBalance => $_getN(2);
  @$pb.TagNumber(3)
  set newBalance($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasNewBalance() => $_has(2);
  @$pb.TagNumber(3)
  void clearNewBalance() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get message => $_getSZ(3);
  @$pb.TagNumber(4)
  set message($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMessage() => $_has(3);
  @$pb.TagNumber(4)
  void clearMessage() => clearField(4);
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
    final $result = create();
    if (status != null) {
      $result.status = status;
    }
    if (brandId != null) {
      $result.brandId = brandId;
    }
    if (limit != null) {
      $result.limit = limit;
    }
    if (offset != null) {
      $result.offset = offset;
    }
    return $result;
  }
  GetGiftCardsRequest._() : super();
  factory GetGiftCardsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetGiftCardsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetGiftCardsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'status')
    ..aOS(2, _omitFieldNames ? '' : 'brandId')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'offset', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetGiftCardsRequest clone() => GetGiftCardsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetGiftCardsRequest copyWith(void Function(GetGiftCardsRequest) updates) => super.copyWith((message) => updates(message as GetGiftCardsRequest)) as GetGiftCardsRequest;

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
  factory GetGiftCardsResponse({
    $core.Iterable<GiftCard>? giftCards,
    $core.int? total,
    $core.double? totalValue,
  }) {
    final $result = create();
    if (giftCards != null) {
      $result.giftCards.addAll(giftCards);
    }
    if (total != null) {
      $result.total = total;
    }
    if (totalValue != null) {
      $result.totalValue = totalValue;
    }
    return $result;
  }
  GetGiftCardsResponse._() : super();
  factory GetGiftCardsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetGiftCardsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetGiftCardsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..pc<GiftCard>(1, _omitFieldNames ? '' : 'giftCards', $pb.PbFieldType.PM, subBuilder: GiftCard.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'totalValue', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetGiftCardsResponse clone() => GetGiftCardsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetGiftCardsResponse copyWith(void Function(GetGiftCardsResponse) updates) => super.copyWith((message) => updates(message as GetGiftCardsResponse)) as GetGiftCardsResponse;

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

/// ===== GET GIFT CARD =====
/// NOTE: user_id extracted from JWT token, not from request
class GetGiftCardRequest extends $pb.GeneratedMessage {
  factory GetGiftCardRequest({
    $core.String? giftCardId,
  }) {
    final $result = create();
    if (giftCardId != null) {
      $result.giftCardId = giftCardId;
    }
    return $result;
  }
  GetGiftCardRequest._() : super();
  factory GetGiftCardRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetGiftCardRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetGiftCardRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'giftCardId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetGiftCardRequest clone() => GetGiftCardRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetGiftCardRequest copyWith(void Function(GetGiftCardRequest) updates) => super.copyWith((message) => updates(message as GetGiftCardRequest)) as GetGiftCardRequest;

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
  factory GetGiftCardResponse({
    GiftCard? giftCard,
  }) {
    final $result = create();
    if (giftCard != null) {
      $result.giftCard = giftCard;
    }
    return $result;
  }
  GetGiftCardResponse._() : super();
  factory GetGiftCardResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetGiftCardResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetGiftCardResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOM<GiftCard>(1, _omitFieldNames ? '' : 'giftCard', subBuilder: GiftCard.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetGiftCardResponse clone() => GetGiftCardResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetGiftCardResponse copyWith(void Function(GetGiftCardResponse) updates) => super.copyWith((message) => updates(message as GetGiftCardResponse)) as GetGiftCardResponse;

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
  }) {
    final $result = create();
    if (giftCardId != null) {
      $result.giftCardId = giftCardId;
    }
    if (recipientEmail != null) {
      $result.recipientEmail = recipientEmail;
    }
    if (recipientName != null) {
      $result.recipientName = recipientName;
    }
    if (message != null) {
      $result.message = message;
    }
    if (transactionId != null) {
      $result.transactionId = transactionId;
    }
    if (verificationToken != null) {
      $result.verificationToken = verificationToken;
    }
    return $result;
  }
  TransferGiftCardRequest._() : super();
  factory TransferGiftCardRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TransferGiftCardRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TransferGiftCardRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'giftCardId')
    ..aOS(2, _omitFieldNames ? '' : 'recipientEmail')
    ..aOS(3, _omitFieldNames ? '' : 'recipientName')
    ..aOS(4, _omitFieldNames ? '' : 'message')
    ..aOS(5, _omitFieldNames ? '' : 'transactionId')
    ..aOS(6, _omitFieldNames ? '' : 'verificationToken')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TransferGiftCardRequest clone() => TransferGiftCardRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TransferGiftCardRequest copyWith(void Function(TransferGiftCardRequest) updates) => super.copyWith((message) => updates(message as TransferGiftCardRequest)) as TransferGiftCardRequest;

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

class TransferGiftCardResponse extends $pb.GeneratedMessage {
  factory TransferGiftCardResponse({
    GiftCard? giftCard,
    $core.String? message,
  }) {
    final $result = create();
    if (giftCard != null) {
      $result.giftCard = giftCard;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  TransferGiftCardResponse._() : super();
  factory TransferGiftCardResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TransferGiftCardResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TransferGiftCardResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOM<GiftCard>(1, _omitFieldNames ? '' : 'giftCard', subBuilder: GiftCard.create)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TransferGiftCardResponse clone() => TransferGiftCardResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TransferGiftCardResponse copyWith(void Function(TransferGiftCardResponse) updates) => super.copyWith((message) => updates(message as TransferGiftCardResponse)) as TransferGiftCardResponse;

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

class GetGiftCardBalanceRequest extends $pb.GeneratedMessage {
  factory GetGiftCardBalanceRequest({
    $core.String? cardNumber,
    $core.String? cardPin,
  }) {
    final $result = create();
    if (cardNumber != null) {
      $result.cardNumber = cardNumber;
    }
    if (cardPin != null) {
      $result.cardPin = cardPin;
    }
    return $result;
  }
  GetGiftCardBalanceRequest._() : super();
  factory GetGiftCardBalanceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetGiftCardBalanceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetGiftCardBalanceRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'cardNumber')
    ..aOS(2, _omitFieldNames ? '' : 'cardPin')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetGiftCardBalanceRequest clone() => GetGiftCardBalanceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetGiftCardBalanceRequest copyWith(void Function(GetGiftCardBalanceRequest) updates) => super.copyWith((message) => updates(message as GetGiftCardBalanceRequest)) as GetGiftCardBalanceRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetGiftCardBalanceRequest create() => GetGiftCardBalanceRequest._();
  GetGiftCardBalanceRequest createEmptyInstance() => create();
  static $pb.PbList<GetGiftCardBalanceRequest> createRepeated() => $pb.PbList<GetGiftCardBalanceRequest>();
  @$core.pragma('dart2js:noInline')
  static GetGiftCardBalanceRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetGiftCardBalanceRequest>(create);
  static GetGiftCardBalanceRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get cardNumber => $_getSZ(0);
  @$pb.TagNumber(1)
  set cardNumber($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCardNumber() => $_has(0);
  @$pb.TagNumber(1)
  void clearCardNumber() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get cardPin => $_getSZ(1);
  @$pb.TagNumber(2)
  set cardPin($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCardPin() => $_has(1);
  @$pb.TagNumber(2)
  void clearCardPin() => clearField(2);
}

class GetGiftCardBalanceResponse extends $pb.GeneratedMessage {
  factory GetGiftCardBalanceResponse({
    $core.double? balance,
    $core.String? brandName,
    $core.String? expiryDate,
    $core.String? status,
  }) {
    final $result = create();
    if (balance != null) {
      $result.balance = balance;
    }
    if (brandName != null) {
      $result.brandName = brandName;
    }
    if (expiryDate != null) {
      $result.expiryDate = expiryDate;
    }
    if (status != null) {
      $result.status = status;
    }
    return $result;
  }
  GetGiftCardBalanceResponse._() : super();
  factory GetGiftCardBalanceResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetGiftCardBalanceResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetGiftCardBalanceResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'balance', $pb.PbFieldType.OD)
    ..aOS(2, _omitFieldNames ? '' : 'brandName')
    ..aOS(3, _omitFieldNames ? '' : 'expiryDate')
    ..aOS(4, _omitFieldNames ? '' : 'status')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetGiftCardBalanceResponse clone() => GetGiftCardBalanceResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetGiftCardBalanceResponse copyWith(void Function(GetGiftCardBalanceResponse) updates) => super.copyWith((message) => updates(message as GetGiftCardBalanceResponse)) as GetGiftCardBalanceResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetGiftCardBalanceResponse create() => GetGiftCardBalanceResponse._();
  GetGiftCardBalanceResponse createEmptyInstance() => create();
  static $pb.PbList<GetGiftCardBalanceResponse> createRepeated() => $pb.PbList<GetGiftCardBalanceResponse>();
  @$core.pragma('dart2js:noInline')
  static GetGiftCardBalanceResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetGiftCardBalanceResponse>(create);
  static GetGiftCardBalanceResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get balance => $_getN(0);
  @$pb.TagNumber(1)
  set balance($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasBalance() => $_has(0);
  @$pb.TagNumber(1)
  void clearBalance() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get brandName => $_getSZ(1);
  @$pb.TagNumber(2)
  set brandName($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasBrandName() => $_has(1);
  @$pb.TagNumber(2)
  void clearBrandName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get expiryDate => $_getSZ(2);
  @$pb.TagNumber(3)
  set expiryDate($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasExpiryDate() => $_has(2);
  @$pb.TagNumber(3)
  void clearExpiryDate() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get status => $_getSZ(3);
  @$pb.TagNumber(4)
  set status($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearStatus() => clearField(4);
}

class GetGiftCardBrandsRequest extends $pb.GeneratedMessage {
  factory GetGiftCardBrandsRequest({
    $core.String? category,
    $core.bool? activeOnly,
  }) {
    final $result = create();
    if (category != null) {
      $result.category = category;
    }
    if (activeOnly != null) {
      $result.activeOnly = activeOnly;
    }
    return $result;
  }
  GetGiftCardBrandsRequest._() : super();
  factory GetGiftCardBrandsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetGiftCardBrandsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetGiftCardBrandsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'category')
    ..aOB(2, _omitFieldNames ? '' : 'activeOnly')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetGiftCardBrandsRequest clone() => GetGiftCardBrandsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetGiftCardBrandsRequest copyWith(void Function(GetGiftCardBrandsRequest) updates) => super.copyWith((message) => updates(message as GetGiftCardBrandsRequest)) as GetGiftCardBrandsRequest;

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
}

class GetGiftCardBrandsResponse extends $pb.GeneratedMessage {
  factory GetGiftCardBrandsResponse({
    $core.Iterable<GiftCardBrand>? brands,
    $core.int? total,
  }) {
    final $result = create();
    if (brands != null) {
      $result.brands.addAll(brands);
    }
    if (total != null) {
      $result.total = total;
    }
    return $result;
  }
  GetGiftCardBrandsResponse._() : super();
  factory GetGiftCardBrandsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetGiftCardBrandsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetGiftCardBrandsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..pc<GiftCardBrand>(1, _omitFieldNames ? '' : 'brands', $pb.PbFieldType.PM, subBuilder: GiftCardBrand.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetGiftCardBrandsResponse clone() => GetGiftCardBrandsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetGiftCardBrandsResponse copyWith(void Function(GetGiftCardBrandsResponse) updates) => super.copyWith((message) => updates(message as GetGiftCardBrandsResponse)) as GetGiftCardBrandsResponse;

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
    final $result = create();
    if (giftCardId != null) {
      $result.giftCardId = giftCardId;
    }
    if (transactionType != null) {
      $result.transactionType = transactionType;
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
  GetGiftCardHistoryRequest._() : super();
  factory GetGiftCardHistoryRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetGiftCardHistoryRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetGiftCardHistoryRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'giftCardId')
    ..aOS(2, _omitFieldNames ? '' : 'transactionType')
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
  GetGiftCardHistoryRequest clone() => GetGiftCardHistoryRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetGiftCardHistoryRequest copyWith(void Function(GetGiftCardHistoryRequest) updates) => super.copyWith((message) => updates(message as GetGiftCardHistoryRequest)) as GetGiftCardHistoryRequest;

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
  factory GetGiftCardHistoryResponse({
    $core.Iterable<GiftCardTransaction>? transactions,
    $core.int? total,
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
  GetGiftCardHistoryResponse._() : super();
  factory GetGiftCardHistoryResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetGiftCardHistoryResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetGiftCardHistoryResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'giftcards'), createEmptyInstance: create)
    ..pc<GiftCardTransaction>(1, _omitFieldNames ? '' : 'transactions', $pb.PbFieldType.PM, subBuilder: GiftCardTransaction.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetGiftCardHistoryResponse clone() => GetGiftCardHistoryResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetGiftCardHistoryResponse copyWith(void Function(GetGiftCardHistoryResponse) updates) => super.copyWith((message) => updates(message as GetGiftCardHistoryResponse)) as GetGiftCardHistoryResponse;

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


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
